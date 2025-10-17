#include <pmm.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

/* Deterministic buddy allocator tests used by buddy_check */
static void test_over_alloc(void) {
    size_t total = nr_free_pages();
    struct Page *p = alloc_pages(total + 1);
    assert(p == NULL);
}

static void test_max_block(void) {
    size_t total = nr_free_pages();
    size_t max_pow = 1;
    while ((max_pow << 1) <= total) max_pow <<= 1;
    if (max_pow == 0) return;
    struct Page *m = alloc_pages(max_pow);
    /* if successful, free and assert restored */
    if (m) {
        free_pages(m, max_pow);
        assert(nr_free_pages() == total);
    }
}

static void test_repeat_alloc_free(void) {
    size_t total = nr_free_pages();
    struct Page **buf = (struct Page **)0; /* not allocating extra memory in kernel */
    /* allocate single pages until failure */
    size_t cnt = 0;
    struct Page *p;
    while ((p = alloc_page()) != NULL) {
        /* free immediately to avoid large buffers; we just count */
        free_page(p);
        cnt++;
        if (cnt > total) break;
    }
    /* after immediate free, count should be restored */
    assert(nr_free_pages() == total);
}

static void test_split_and_coalesce(void) {
    size_t total = nr_free_pages();
    size_t want = 8;
    if (total < want) return;
    struct Page *B = alloc_pages(want);
    if (!B) return;
    /* split by allocating halves */
    struct Page *x = alloc_pages(want/2);
    struct Page *y = alloc_pages(want/2);
    if (x) free_pages(x, want/2);
    if (y) free_pages(y, want/2);
    /* free original big (if allocated) */
    free_pages(B, want);
    assert(nr_free_pages() == total);
}

static void test_random_sequence(void) {
    size_t total = nr_free_pages();
    if (total == 0) return;
    struct Page *allocs[64];
    size_t sizes[64];
    int used = 0;
    unsigned int rnd = 123456789;
    auto_next:
    for (int i = 0; i < 32; i++) {
        rnd = rnd * 1103515245 + 12345;
        size_t req = (rnd % 8) + 1; /* 1..8 */
        struct Page *q = alloc_pages(req);
        if (q) {
            allocs[used] = q;
            sizes[used] = req;
            used++;
            if (used >= (int)(sizeof(allocs)/sizeof(allocs[0]))) break;
        }
    }
    /* free in reverse */
    for (int i = used - 1; i >= 0; i--) {
        free_pages(allocs[i], sizes[i]);
    }
    assert(nr_free_pages() == total);
}

/* public runner */
void run_buddy_tests(void) {
    cprintf("[buddy_tests] start\n");
    test_over_alloc();
    test_max_block();
    test_repeat_alloc_free();
    test_split_and_coalesce();
    test_random_sequence();
    cprintf("[buddy_tests] passed\n");
}
