#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>
#include <stdio.h>

/* Simple buddy system implementation for page-granularity allocator.
 * Design overview:
 * - Maintain free lists for each order (0..MAX_ORDER-1). Order k holds blocks of 2^k pages.
 * - Each block is represented by its first Page struct which has PG_property set and property=2^k.
 * - free_area contains lists and total free pages counter.
 * - Allocation: find smallest order >= requested order with non-empty list, split larger blocks down.
 * - Free: coalesce with buddy if buddy is free and same order, repeat upward.
 */

#define MAX_ORDER 11 /* support up to 2^10 = 1024 pages per block; adjust if needed */

typedef struct {
    list_entry_t free_list[MAX_ORDER];
    unsigned int nr_free;
} buddy_area_t;

static buddy_area_t buddy_area;

/* helpers */
static inline size_t
order_of_size(size_t n) {
    size_t order = 0;
    size_t sz = 1;
    while (sz < n) { sz <<= 1; order++; }
    return order;
}

static inline uintptr_t
page_index(struct Page *p) {
    return p - pages;
}

static struct Page *
find_buddy_page(struct Page *base, size_t order) {
    uintptr_t idx = page_index(base);
    uintptr_t buddy_idx = idx ^ (1UL << order);
    if (buddy_idx >= npage) return NULL;
    return &pages[buddy_idx];
}

static void
buddy_init(void) {
    for (int i = 0; i < MAX_ORDER; i++) list_init(&buddy_area.free_list[i]);
    buddy_area.nr_free = 0;
}

static void
buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    /* initialize pages
     * We'll break the region into maximal power-of-two aligned blocks and add to free lists
     */
    for (struct Page *p = base; p < base + n; p++) {
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }

    /* Split the region into aligned power-of-two blocks */
    size_t offset = page_index(base);
    size_t remain = n;
    while (remain > 0) {
        /* find largest power-of-two block that fits and is aligned */
        size_t max_size = 1;
        size_t max_order = 0;
        while (max_size * 2 <= remain && ((offset & (max_size * 2 - 1)) == 0)) {
            max_size <<= 1; max_order++;
            if (max_order + 1 >= MAX_ORDER) break;
        }
        /* add block of size max_size at pages + offset */
        struct Page *head = pages + offset;
        head->property = max_size;
        SetPageProperty(head);
        list_add(&buddy_area.free_list[max_order], &head->page_link);
        buddy_area.nr_free += max_size;
        offset += max_size;
        remain -= max_size;
    }
}

static struct Page *
split_block(struct Page *block, size_t from_order, size_t to_order) {
    /* take block off its free list */
    list_del(&block->page_link);
    ClearPageProperty(block);
    size_t order = from_order;
    struct Page *head = block;
    while (order > to_order) {
        order--;
        size_t sz = 1UL << order;
        /* left = head, right = head + sz */
        struct Page *right = head + sz;
        right->property = sz;
        SetPageProperty(right);
        /* push right into free list of 'order' */
        list_add(&buddy_area.free_list[order], &right->page_link);
        /* head keeps going down */
    }
    head->property = 1UL << to_order;
    /* when allocating, the head will become non-free, so ClearPageProperty will be called by caller */
    return head;
}

static struct Page *
buddy_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > buddy_area.nr_free) return NULL;
    size_t need_order = order_of_size(n);
    size_t order = need_order;
    while (order < MAX_ORDER && list_empty(&buddy_area.free_list[order])) order++;
    if (order >= MAX_ORDER) return NULL;

    /* take one block from order */
    list_entry_t *le = list_next(&buddy_area.free_list[order]);
    struct Page *blk = le2page(le, page_link);
    /* split down if needed */
    blk = split_block(blk, order, need_order);

    /* mark allocated pages and clear property on head */
    ClearPageProperty(blk);
    for (size_t i = 0; i < (1UL << need_order); i++) {
        struct Page *p = blk + i;
        assert(!PageReserved(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    buddy_area.nr_free -= (1UL << need_order);
    return blk;
}

static void
buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    /* mark pages cleared */
    for (struct Page *p = base; p < base + n; p++) {
        assert(!PageReserved(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    size_t order = order_of_size(n);
    struct Page *head = base;
    head->property = 1UL << order;
    SetPageProperty(head);

    /* try to coalesce upwards */
    while (order + 1 < MAX_ORDER) {
        struct Page *buddy = find_buddy_page(head, order);
        if (!buddy || !PageProperty(buddy) || buddy->property != (1UL << order)) break;
        /* buddy is free and same size; remove buddy from its free list */
        list_del(&buddy->page_link);
        ClearPageProperty(buddy);
        /* compute new head (lower address) */
        if (buddy < head) head = buddy;
        order++;
        head->property = 1UL << order;
    }
    /* insert head into free list */
    list_add(&buddy_area.free_list[order], &head->page_link);
    SetPageProperty(head);
    buddy_area.nr_free += (1UL << order);
}

static size_t
buddy_nr_free_pages(void) {
    return buddy_area.nr_free;
}

/* Verify free lists consistency: sum free pages from all lists and compare with nr_free */
static void
verify_free_list_consistency(void) {
    size_t total = 0;
    for (int o = 0; o < MAX_ORDER; o++) {
        list_entry_t *le = &buddy_area.free_list[o];
        while ((le = list_next(le)) != &buddy_area.free_list[o]) {
            struct Page *p = le2page(le, page_link);
            assert(PageProperty(p));
            total += p->property;
        }
    }
    assert(total == buddy_area.nr_free);
}

static void
buddy_check(void) {
    /* More thorough checks: split/coalesce, alloc/free restore, small stress loop */
    size_t before = nr_free_pages();

    /* Basic small allocations and frees */
    struct Page *p0 = alloc_page();
    struct Page *p1 = alloc_page();
    struct Page *p2 = alloc_page();
    assert(p0 && p1 && p2 && p0 != p1 && p1 != p2);
    free_page(p0);
    free_page(p1);
    free_page(p2);
    verify_free_list_consistency();
    assert(nr_free_pages() == before);

    /* Test split and coalesce deterministically with small powers */
    /* allocate a big block then split into two halves and re-merge */
    size_t big = 8;
    struct Page *B = alloc_pages(big);
    if (B) {
        free_pages(B, big);
        size_t before2 = nr_free_pages();
        struct Page *x = alloc_pages(big/2);
        assert(x != NULL);
        struct Page *y = alloc_pages(big/2);
        assert(y != NULL);
        /* free halves and expect coalescing back to big */
    free_pages(x, big/2);
    verify_free_list_consistency();
    free_pages(y, big/2);
    verify_free_list_consistency();
    assert(nr_free_pages() == before2);
    }

    /* Small randomized-like sequence but bounded and deterministic */
    size_t saved = nr_free_pages();
    struct Page *buf[128];
    int used = 0;
    for (int i = 0; i < 64; i++) {
        size_t req = (i % 7) + 1; /* sizes from 1..7 */
        struct Page *q = alloc_pages(req);
        if (q) {
            buf[used++] = q;
        }
    }
    /* free allocated ones */
    for (int i = 0; i < used; i++) {
        /* Determine size of the allocated block from property if head, otherwise free as single pages */
        struct Page *q = buf[i];
        /* We don't track the exact allocated size here; free single page (safe) or attempt to free property pages */
        if (PageProperty(q)) {
            size_t s = q->property;
            free_pages(q, s);
        } else {
            free_page(q);
        }
    }
    verify_free_list_consistency();
    assert(nr_free_pages() == saved);

    /* final invariant: total free pages should match original before everything */
    assert(nr_free_pages() == before);

    /* run deterministic tests in separate file */
    extern void run_buddy_tests(void);
    run_buddy_tests();
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
