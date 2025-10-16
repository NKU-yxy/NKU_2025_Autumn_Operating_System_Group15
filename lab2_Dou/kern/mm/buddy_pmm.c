#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>

/*
 * A minimal buddy allocator for lab exercise. This implementation manages free
 * blocks in powers of two page units. It keeps free lists for each order and
 * for compatibility with existing tests we reuse PageProperty flag and
 * property field for bookkeeping of head pages.
 */

#define MAX_ORDER 16 /* supports up to 2^16 pages per block (tunable) */

static free_area_t free_areas[MAX_ORDER + 1];
static size_t buddy_nr_free = 0;

static int order_of_size(size_t n) {
    int order = 0;
    size_t size = 1;
    while (size < n && order <= MAX_ORDER) {
        size <<= 1;
        order++;
    }
    return order;
}

static void buddy_init(void) {
    for (int i = 0; i <= MAX_ORDER; i++) {
        list_init(&free_areas[i].free_list);
        free_areas[i].nr_free = 0;
    }
    buddy_nr_free = 0;
}

/* helper to insert a free block (head) into order list */
static void insert_free_block(struct Page *p, int order) {
    p->property = 1UL << order; /* size in pages */
    SetPageProperty(p);
    list_add(&free_areas[order].free_list, &p->page_link);
    free_areas[order].nr_free += p->property;
    buddy_nr_free += p->property;
}

/* helper to remove head from list */
static void remove_free_block(struct Page *p, int order) {
    list_del(&p->page_link);
    free_areas[order].nr_free -= p->property;
    buddy_nr_free -= p->property;
    ClearPageProperty(p);
}

/* split block p of 'order' into two buddies of order-1, return left buddy head */
static struct Page *split_block(struct Page *p, int order) {
    assert(order > 0);
    int half = 1UL << (order - 1);
    struct Page *right = p + half;
    /* right becomes a head of smaller block */
    right->property = half;
    SetPageProperty(right);
    /* left (p) also becomes head of smaller block */
    p->property = half;
    SetPageProperty(p);
    return p;
}

static void buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    /* initialize pages metadata */
    for (struct Page *p = base; p != base + n; p++) {
        assert(PageReserved(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }

    /* break the region into maximal power-of-two blocks and insert */
    size_t remaining = n;
    struct Page *cur = base;
    while (remaining > 0) {
        /* find largest power of two <= remaining (portable, avoids __builtin_clz) */
        size_t sz = 1UL;
        while ((sz << 1) <= remaining) {
            sz <<= 1;
        }
        /* cap by MAX_ORDER */
        int order = 0;
        while ((1UL << order) < sz) order++;
        if (order > MAX_ORDER) {
            order = MAX_ORDER;
            sz = 1UL << order;
        }
        insert_free_block(cur, order);
        cur += sz;
        remaining -= sz;
    }
}

/* allocate n pages: find smallest order with size >= n */
static struct Page *buddy_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > buddy_nr_free) return NULL;
    int target_order = order_of_size(n);
    for (int o = target_order; o <= MAX_ORDER; o++) {
        if (!list_empty(&free_areas[o].free_list)) {
            /* take head */
            list_entry_t *le = list_next(&free_areas[o].free_list);
            struct Page *p = le2page(le, page_link);
            remove_free_block(p, o);
            /* split until reach target_order */
            for (int cur = o; cur > target_order; cur--) {
                /* split p into two buddies of order cur-1 */
                int half = 1UL << (cur - 1);
                struct Page *buddy = p + half;
                /* left (p) will be kept for further split; right buddy inserted */
                buddy->property = half;
                SetPageProperty(buddy);
                list_add(&free_areas[cur - 1].free_list, &buddy->page_link);
                free_areas[cur - 1].nr_free += half;
                buddy_nr_free += half;
                /* update p */
                p->property = half;
                SetPageProperty(p);
            }
            /* allocate p (head of block of target_order) */
            ClearPageProperty(p);
            /* mark reserved */
            for (size_t i = 0; i < (1UL << target_order); i++) {
                SetPageReserved(p + i);
            }
            return p;
        }
    }
    return NULL;
}

/* free pages: expect base to be head and n is number of pages */
static void buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    /* clear reserved flags */
    for (size_t i = 0; i < n; i++) {
        ClearPageReserved(base + i);
        set_page_ref(base + i, 0);
    }
    /* merge into buddies: find smallest order matching n's power-of-two breakdown */
    size_t remaining = n;
    struct Page *cur = base;
    while (remaining > 0) {
        /* find largest power-of-two <= remaining (portable) */
        size_t sz = 1UL;
        while ((sz << 1) <= remaining) {
            sz <<= 1;
        }
        int order = 0;
        while ((1UL << order) < sz) order++;
        if (order > MAX_ORDER) order = MAX_ORDER;

        /* try to coalesce with buddy if buddy free and same order */
        struct Page *head = cur;
        size_t block_size = 1UL << order;
        uintptr_t pa = page2pa(head);
        /* compute buddy address: flip the order bit */
        uintptr_t buddy_pa = pa ^ (block_size * PGSIZE);
        struct Page *buddy = NULL;
        if (buddy_pa < npage * PGSIZE) {
            buddy = pa2page(buddy_pa);
        }
        /* if buddy is free and is head with same size, remove buddy and merge */
        if (buddy && PageProperty(buddy) && buddy->property == block_size) {
            /* remove buddy from its free list */
            list_del(&buddy->page_link);
            free_areas[order].nr_free -= buddy->property;
            buddy_nr_free -= buddy->property;
            /* decide new head */
            if (buddy < head) head = buddy;
            head->property = block_size * 2;
            SetPageProperty(head);
            /* continue try to merge at next order */
            cur = head;
            remaining -= block_size;
            continue;
        } else {
            /* cannot merge further, just insert this block */
            insert_free_block(head, order);
            remaining -= block_size;
            cur += block_size;
        }
    }
}

static size_t buddy_nr_free_pages(void) { return buddy_nr_free; }

/* basic check similar style to default_check: small tests */
static void buddy_basic_check(void) {
    struct Page *p0, *p1, *p2;
    // allocate three pages
    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);
    assert(p0 != p1 && p1 != p2 && p0 != p2);
    free_page(p0);
    free_page(p1);
    free_page(p2);
}

static void buddy_check(void) {
    // minimal smoke tests
    size_t before = nr_free_pages();
    struct Page *p = alloc_pages(8);
    if (p) free_pages(p, 8);
    assert(nr_free_pages() == before);
    buddy_basic_check();
}

const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};
