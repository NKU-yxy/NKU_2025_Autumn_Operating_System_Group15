#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>
#include <stdio.h>
#include <assert.h>

static buddy_free_area_t free_area;

// 初始化伙伴系统
static void
buddy_init(void) {
    for (int i = 0; i < MAX_ORDER; i++) {
        list_init(&free_area.free_list[i]);
        free_area.nr_free[i] = 0;
    }
}

// 初始化一段物理内存块（memmap）
static void
buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    for (size_t i = 0; i < n; i++) {
        struct Page *p = base + i;
        assert(PageReserved(p));
        p->flags = 0;
        set_page_ref(p, 0);
        ClearPageProperty(p);
    }

    size_t offset = 0;
    while (n > 0) {
        int order = MAX_ORDER - 1;
        while ((1U << order) > n)
            order--;
        struct Page *page = base + offset;
        page->property = order;
        SetPageProperty(page);
        list_add(&free_area.free_list[order], &(page->page_link));
        free_area.nr_free[order]++;
        offset += (1U << order);
        n -= (1U << order);
    }
}

// 分配函数
static struct Page *
buddy_alloc_pages(size_t n) {
    if (n == 0) return NULL;

    int order = 0;
    while ((1U << order) < n && order < MAX_ORDER) order++;
    if (order >= MAX_ORDER) return NULL;

    int cur = order;
    while (cur < MAX_ORDER && list_empty(&free_area.free_list[cur]))
        cur++;
    if (cur == MAX_ORDER) return NULL;

    list_entry_t *le = list_next(&free_area.free_list[cur]);
    struct Page *page = le2page(le, page_link);
    list_del(le);
    free_area.nr_free[cur]--;

    while (cur > order) {
        cur--;
        struct Page *buddy = page + (1U << cur);
        buddy->property = cur;
        SetPageProperty(buddy);
        list_add(&free_area.free_list[cur], &(buddy->page_link));
        free_area.nr_free[cur]++;
    }

    ClearPageProperty(page);
    return page;
}

// 释放函数
static void
buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    int order = 0;
    while ((1U << order) < n) order++;

    while (order < MAX_ORDER - 1) {
        uintptr_t addr = page2pa(base);
        uintptr_t buddy_addr = addr ^ ((1U << (order + PGSHIFT)));
        struct Page *buddy = pa2page(buddy_addr);

        if (!PageProperty(buddy) || buddy->property != order)
            break;

        // 从空闲链表删除buddy并合并
        list_del(&buddy->page_link);
        free_area.nr_free[order]--;
        if (buddy < base)
            base = buddy;
        order++;
    }

    base->property = order;
    SetPageProperty(base);
    list_add(&free_area.free_list[order], &(base->page_link));
    free_area.nr_free[order]++;
}

// 获取当前空闲页数
static size_t
buddy_nr_free_pages(void) {
    size_t total = 0;
    for (int i = 0; i < MAX_ORDER; i++)
        total += (free_area.nr_free[i] << i);
    return total;
}

// 检查函数（测试用例）
static void
buddy_check(void) {
    cprintf("========== Buddy System Check ==========\n");
    size_t total = nr_free_pages();

    struct Page *p0 = alloc_pages(1);
    struct Page *p1 = alloc_pages(2);
    struct Page *p2 = alloc_pages(8);

    assert(p0 != NULL && p1 != NULL && p2 != NULL);
    cprintf("Allocated: 1 + 2 + 8 pages OK\n");

    free_pages(p0, 1);
    free_pages(p1, 2);
    free_pages(p2, 8);
    cprintf("Freed all pages OK\n");

    assert(total == nr_free_pages());
    cprintf("Free page count restored OK\n");

    struct Page *p3 = alloc_pages(4);
    assert(p3 != NULL);
    free_pages(p3, 4);

    cprintf("Buddy system check passed!\n");
    cprintf("========================================\n");
}

// 注册到 pmm_manager
const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};
