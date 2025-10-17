#include <slub.h>
#include <pmm.h>
#include <list.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>

/*
 * Simplified SLUB-like allocator for the lab (two-layer):
 * - Layer 1: use alloc_pages/free_pages to get whole pages (unit: PAGE)
 * - Layer 2: maintain caches for object sizes (power-of-two buckets)
 *
 * Simplifications and choices:
 * - Page size = PGSIZE; objects are carved from pages returned by alloc_pages(1)
 * - Buckets: sizes 8,16,32,64,128,256,512,1024,2048 (up to half page)
 * - Each page used for slab contains a small header (slab_page_t) at its start
 * - Per-bucket free-list stores free objects
 * - No per-CPU caches, no red-zones, no partial-ordering. Focus on correctness.
 */

#define MAX_BUCKET 9
static const size_t bucket_size[MAX_BUCKET] = {8,16,32,64,128,256,512,1024,2048};

typedef struct slab_obj {
    struct slab_obj *next;
} slab_obj_t;

typedef struct slab_page {
    list_entry_t list;      // link in per-bucket page list (stored at page start)
    slab_obj_t *free;       // free list of objects in this page
    size_t obj_size;        // size of each object in this page
    size_t nr_free;         // number of free objects currently
    size_t capacity;        // total objects capacity in this page
} slab_page_t;

typedef struct slab_cache {
    size_t size;
    list_entry_t pages;     // list of slab_page_t (stored at page start)
    slab_obj_t *global_free; // global free objects (object pointers)
    unsigned int nr_pages;  // number of slab pages for this cache
} slab_cache_t;

static slab_cache_t caches[MAX_BUCKET];

static void slub_dump_state(const char *tag) {
    cprintf("-- SLUB STATE: %s --\n", tag);
    for (int i = 0; i < MAX_BUCKET; i++) {
        slab_cache_t *c = &caches[i];
        cprintf(" cache[%2d] size=%4lu pages=%u\n", i, (unsigned long)c->size, c->nr_pages);
        list_entry_t *le = &c->pages;
        while ((le = list_next(le)) != &c->pages) {
            slab_page_t *sp = to_struct(le, slab_page_t, list);
            // compute page struct pointer from slab_page_t pointer: pagev is sp (page-aligned)
            uintptr_t page_pa = page2pa(pa2page((uintptr_t)sp - va_pa_offset));
            cprintf("   page pa=0x%08lx obj_size=%lu nr_free=%lu capacity=%lu\n",
                    page_pa, (unsigned long)sp->obj_size, (unsigned long)sp->nr_free, (unsigned long)sp->capacity);
        }
    }
    cprintf("-- END SLUB STATE --\n");
}

static int size_to_bucket(size_t size) {
    for (int i = 0; i < MAX_BUCKET; i++) {
        if (size <= bucket_size[i]) return i;
    }
    return -1; // too large
}

static void slab_page_init(void *page, size_t obj_size) {
    slab_page_t *sp = (slab_page_t *)page;
    sp->free = NULL;
    sp->obj_size = obj_size;
    sp->nr_free = 0;
    list_init(&sp->list);

    // place objects right after the header
    uintptr_t base = (uintptr_t)page + sizeof(slab_page_t);
    uintptr_t end = (uintptr_t)page + PGSIZE;
    size_t stride = ((obj_size + sizeof(void*) - 1) / sizeof(void*)) * sizeof(void*);
    for (uintptr_t cur = base; cur + stride <= end; cur += stride) {
        slab_obj_t *o = (slab_obj_t *)cur;
        o->next = sp->free;
        sp->free = o;
        sp->nr_free++;
    }
    sp->capacity = sp->nr_free;
}

void slub_init(void) {
    for (int i = 0; i < MAX_BUCKET; i++) {
        caches[i].size = bucket_size[i];
        list_init(&caches[i].pages);
        caches[i].global_free = NULL;
        caches[i].nr_pages = 0;
    }
}

void *kmalloc(size_t size) {
    if (size == 0) return NULL;
    int b = size_to_bucket(size);
    if (b < 0) {
        // too large -> allocate whole pages rounded up
        size_t np = (size + PGSIZE - 1) / PGSIZE;
        struct Page *p = alloc_pages(np);
        if (!p) return NULL;
        return (void *)page2pa(p) + va_pa_offset; // return kernel virtual addr sim
    }

    slab_cache_t *c = &caches[b];

    // search existing pages for a free object
    list_entry_t *le = &c->pages;
    while ((le = list_next(le)) != &c->pages) {
        slab_page_t *sp = to_struct(le, slab_page_t, list);
        if (sp->free) {
            slab_obj_t *o = sp->free;
            sp->free = o->next;
            sp->nr_free--;
            return (void *)o;
        }
    }

    // allocate a new page and carve it
    struct Page *p = alloc_pages(1);
    if (!p) return NULL;
    void *pagev = (void *)((uintptr_t)page2pa(p) + va_pa_offset);
    slab_page_init(pagev, c->size);
    slab_page_t *sp = (slab_page_t *)pagev;
    // link page into cache page list
    list_add(&c->pages, &sp->list);
    c->nr_pages++;
    // take one object from sp->free
    slab_obj_t *o = sp->free;
    if (o) {
        sp->free = o->next;
        sp->nr_free--;
        return (void *)o;
    }
    return NULL;
}

void kfree(void *ptr) {
    if (!ptr) return;
    // map virtual addr to physical addr then to page struct
    uintptr_t v = (uintptr_t)ptr;
    if (v < va_pa_offset) return; // not kernel virtual address
    uintptr_t pa = v - va_pa_offset;
    struct Page *p = pa2page(pa);
    // page virtual base
    void *pagev = (void *)((uintptr_t)page2pa(p) + va_pa_offset);
    slab_page_t *sp = (slab_page_t *)pagev;
    // validate obj_size
    if (sp->obj_size == 0) return; // not a slab page
    // ensure ptr lies within object region of the slab page
    uintptr_t obj_start = (uintptr_t)pagev + sizeof(slab_page_t);
    uintptr_t obj_end = (uintptr_t)pagev + PGSIZE;
    if ((uintptr_t)ptr < obj_start || (uintptr_t)ptr >= obj_end) {
        // not inside object region
        return;
    }
    // detect double free: traverse free list in this page and see if ptr already present
    slab_obj_t *it = sp->free;
    while (it) {
        if ((void *)it == ptr) {
            cprintf("slub kfree: double free detected %p\n", ptr);
            return;
        }
        it = it->next;
    }
    // push back into page free list
    slab_obj_t *o = (slab_obj_t *)ptr;
    o->next = sp->free;
    sp->free = o;
    sp->nr_free++;

    // if page is completely free, remove and free the page
    if (sp->nr_free >= sp->capacity) {
        list_del(&sp->list);
        // decrement cache page count
        // find cache by obj_size
        for (int i = 0; i < MAX_BUCKET; i++) {
            if (caches[i].size == sp->obj_size) {
                if (caches[i].nr_pages > 0) caches[i].nr_pages--;
                break;
            }
        }
        // clear header to avoid double free confusion
        sp->free = NULL;
        sp->obj_size = 0;
        sp->nr_free = 0;
        sp->capacity = 0;
        free_pages(p, 1);
    }
}

void slub_check(void) {
    cprintf("slub_check: start\n");
    size_t before = nr_free_pages();

    slub_dump_state("initial");

    // allocate a batch of objects of various sizes
    void *objs[128];
    int cnt = 0;
    for (int i = 0; i < 20; i++) {
        size_t s = 8 + (i % 9) * 16;
        objs[cnt] = kmalloc(s);
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
        cnt++;
    }
    for (int i = 0; i < 30; i++) {
        size_t s = 64 + (i % 6) * 32;
        objs[cnt] = kmalloc(s);
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
        cnt++;
    }
    for (int i = 0; i < 10; i++) {
        size_t s = 1500;
        objs[cnt] = kmalloc(s); // large near max bucket or larger
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
        cnt++;
    }

    for (int i = 0; i < cnt; i++) assert(objs[i] != NULL);

    // free half of them
    for (int i = 0; i < cnt; i += 2) kfree(objs[i]);
    slub_dump_state("after free half");

    // allocate again to check reuse
    void *more[64];
    for (int i = 0; i < 30; i++) more[i] = kmalloc(64);
    for (int i = 0; i < 30; i++) {
        cprintf("slub alloc reuse size=64 -> %p\n", more[i]);
        assert(more[i] != NULL);
    }

    // free remaining
    for (int i = 1; i < cnt; i += 2) kfree(objs[i]);
    slub_dump_state("after free rest");
    for (int i = 0; i < 30; i++) kfree(more[i]);
    slub_dump_state("after free more");

    // after freeing all, underlying free pages should be restored (if pages were reclaimed)
    size_t after = nr_free_pages();
    cprintf("slub_check: free pages before=%lu after=%lu\n", (unsigned long)before, (unsigned long)after);
    // allow after >= before depending on allocator behavior
    assert(after >= before);
    cprintf("slub_check: OK\n");
}
