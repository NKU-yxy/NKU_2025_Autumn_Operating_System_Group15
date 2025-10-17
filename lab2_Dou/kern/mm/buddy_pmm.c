#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>
#include <stdio.h>
#include <assert.h>

static buddy_free_area_t free_area;
static size_t buddy_nr_free_pages(void);
// ====================== 工具函数 ======================

// 打印各阶空闲链表信息
static void
buddy_dump_free_list(void) {
    cprintf("\n[Buddy] Free list status:\n");
    for (int i = 0; i < MAX_ORDER; i++) {
        cprintf("  order %d (block size %d pages): %d blocks\n",
                i, (1 << i), free_area.nr_free[i]);
    }
    cprintf("  Total free pages: %d\n\n", buddy_nr_free_pages());
}

// ====================== 初始化 ======================

static void
buddy_init(void) {
    for (int i = 0; i < MAX_ORDER; i++) {
        list_init(&free_area.free_list[i]);
        free_area.nr_free[i] = 0;
    }
}

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
    cprintf("[Buddy] Initialized memory map: %zu pages (%d orders)\n", n, MAX_ORDER);
}

// ====================== 分配 ======================

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
        cprintf("[Buddy] Split block: order %d -> two order %d\n", cur + 1, cur);
    }

    ClearPageProperty(page);
    uintptr_t pa = page2pa(page);
    cprintf("[Buddy] Alloc %d pages (order %d) @ 0x%08lx\n", (1 << order), order, pa);
    return page;
}

// ====================== 释放 ======================

static void
buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    int order = 0;
    while ((1U << order) < n) order++;

    uintptr_t base_pa = page2pa(base);

    while (order < MAX_ORDER - 1) {
        uintptr_t buddy_addr = base_pa ^ ((1U << (order + PGSHIFT)));
        struct Page *buddy = pa2page(buddy_addr);

        if (!PageProperty(buddy) || buddy->property != order)
            break;

        // 从空闲链表删除buddy并合并
        list_del(&buddy->page_link);
        free_area.nr_free[order]--;

        if (buddy < base) base = buddy;
        base_pa = page2pa(base);

        cprintf("[Buddy] Merge buddy blocks at 0x%08lx and 0x%08lx -> order %d\n",
                page2pa(buddy), base_pa, order + 1);

        order++;
    }

    base->property = order;
    SetPageProperty(base);
    list_add(&free_area.free_list[order], &(base->page_link));
    free_area.nr_free[order]++;

    cprintf("[Buddy] Free %d pages (order %d) @ 0x%08lx\n", (1 << order), order, base_pa);
}

// ====================== 统计 ======================

static size_t
buddy_nr_free_pages(void) {
    size_t total = 0;
    for (int i = 0; i < MAX_ORDER; i++)
        total += (free_area.nr_free[i] << i);
    return total;
}

// ====================== 检查 ======================

static void
buddy_check(void) {
    cprintf("========== Buddy System Check ==========\n");
    size_t total = nr_free_pages();
    buddy_dump_free_list();

    struct Page *p0 = alloc_pages(1);
    struct Page *p1 = alloc_pages(2);
    struct Page *p2 = alloc_pages(8);

    assert(p0 && p1 && p2);
    cprintf("[Check] Allocations successful:\n");
    cprintf("  p0 = 0x%08lx (1 page)\n", page2pa(p0));
    cprintf("  p1 = 0x%08lx (2 pages)\n", page2pa(p1));
    cprintf("  p2 = 0x%08lx (8 pages)\n", page2pa(p2));

    buddy_dump_free_list();

    free_pages(p0, 1);
    free_pages(p1, 2);
    free_pages(p2, 8);

    cprintf("[Check] Freed all pages.\n");
    buddy_dump_free_list();

    assert(total == nr_free_pages());
    cprintf("[Check] Free page count restored (%d pages).\n", (int)total);

    struct Page *p3 = alloc_pages(4);
    assert(p3);
    cprintf("[Check] Allocated again p3 = 0x%08lx (4 pages)\n", page2pa(p3));
    free_pages(p3, 4);

    buddy_dump_free_list();
    cprintf("Buddy system check passed!\n");
    cprintf("========================================\n");
}

// ====================== 注册 ======================

const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};
