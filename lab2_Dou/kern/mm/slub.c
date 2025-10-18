#include <slub.h>
#include <pmm.h>
#include <list.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>
/*
 * ------------------------ SLUB 设计文档
 *
 * ------------ SLUB 原理概述
 * SLUB（Slab Utilization By-pass）是 Linux 内核中的一种内存分配器，
 * 专门用于高效地管理内核中的小对象。
 * 它是 SLAB 分配器的改进版本，旨在提高性能、简化实现并减少内存碎片。
 * 在现代 Linux 内核中，SLUB 是默认的分配器，广泛用于分配和回收内核数据结构，
 * 如 task_struct、inode、file 等。
 *
 * ------------ 本实验简化版 SLUB 的核心目标
 * 我们实现了一个 **两层架构的简化版 SLUB 分配器**：
 *   - 第一层：基于页的分配（使用 alloc_pages/free_pages）
 *   - 第二层：基于固定大小对象的分配（通过 slab cache 管理）
 *
 * 整体思路：
 *   当用户调用 kmalloc() 时：
 *     1. 如果请求的对象较小（≤ 2048B），进入 SLUB 层分配；
 *     2. 如果请求的对象较大，则直接使用 alloc_pages() 分配整页。
 *
 * ------------ SLUB 的主要机制
 *
 * 1. 缓存 (Cache)
 *    - 每种对象大小对应一个 cache（slab_cache_t）。
 *    - cache 维护多个 slab_page_t（每个 slab_page 管理多个对象）。
 *    - 本实验中定义的 9 个桶大小：
 *         bucket_size = {8,16,32,64,128,256,512,1024,2048}
 *      每个 cache 管理对应大小的对象。
 *
 * 2. Slab Page
 *    - 每个 slab page 占用一整页（PGSIZE）。
 *    - 页首保存 slab_page_t 结构体（slab 元信息），
 *      后面依次存储多个固定大小的对象。
 *    - slab_page_t 主要成员：
 *          list_entry_t list;    // 链入 cache
 *          slab_obj_t *free;     // 当前空闲对象链表
 *          size_t obj_size;      // 对象大小
 *          size_t nr_free;       // 当前空闲对象数
 *          size_t capacity;      // 该页可容纳对象总数
 *
 * 3. 对象分配与释放流程
 *
 *   (1) 分配（kmalloc）：
 *       - 根据请求 size 选择对应的 bucket；
 *       - 遍历 cache->pages，寻找有空闲对象的 slab_page；
 *       - 若找到，则弹出一个对象并返回；
 *       - 若没有合适页，则：
 *            a. 通过 alloc_pages(1) 分配一页；
 *            b. 初始化 slab_page_t；
 *            c. 将该页挂入 cache->pages；
 *            d. 从该页分配一个对象返回。
 *
 *   (2) 释放（kfree）：
 *       - 根据虚拟地址推算其所在页；
 *       - 确认该页是 slab 页；
 *       - 将对象重新挂回 slab_page_t->free；
 *       - 若该页完全空闲，则释放整页并从 cache 移除。
 *
 * ------------ 关键数据结构
 *
 * typedef struct slab_obj {
 *     struct slab_obj *next;
 * } slab_obj_t;
 *
 * typedef struct slab_page {
 *     list_entry_t list;   // 链入 cache 的 page 链表
 *     slab_obj_t *free;    // 空闲对象链表
 *     size_t obj_size;     // 对象大小
 *     size_t nr_free;      // 当前空闲数量
 *     size_t capacity;     // 总容量
 * } slab_page_t;
 *
 * typedef struct slab_cache {
 *     size_t size;          // 管理对象大小
 *     list_entry_t pages;   // 所有 slab_page_t 的链表
 *     slab_obj_t *global_free; // 全局备用空闲链（简化版中未使用）
 *     unsigned int nr_pages;   // 当前缓存的页数
 * } slab_cache_t;
 *
 * static slab_cache_t caches[MAX_BUCKET];
 *
 * ------------ 核心函数实现
 *
 * 1. slub_init()
 *    - 初始化 9 个缓存桶；
 *    - 对每个 cache 初始化链表；
 *
 * 2. slab_page_init()
 *    - 初始化一页 slab，包括对象链表和元信息；
 *
 * 3. kmalloc(size_t size)
 *    - 若 size 超过最大桶，则使用 alloc_pages()；
 *    - 否则在对应 cache 查找空闲对象；
 *    - 若所有页满，创建新 slab page；
 *
 * 4. kfree(void *ptr)
 *    - 通过虚拟地址反推 slab_page；
 *    - 检查有效性、防止 double free；
 *    - 将对象重新挂回 free 链；
 *    - 若该页完全空闲，释放整页；
 *
 * 5. slub_check()
 *    - 自动测试整个分配/释放机制：
 *      a. 批量分配多种大小对象；
 *      b. 释放一半对象；
 *      c. 再次分配以验证复用；
 *      d. 释放全部对象；
 *      e. 检查页数是否恢复；
 *
 * ------------ 设计特点与取舍
 *
 * ✅ 优点：
 *   - 实现简单，结构清晰；
 *   - 基本复现了 Linux SLUB 的分层思想；
 *   - 支持动态增长的 per-size cache；
 *   - 具备完整测试与状态打印。
 *
 * ⚠️ 简化点：
 *   - 无 per-CPU cache；
 *   - 无 partial/full/empty 状态区分；
 *   - 未实现对象对齐优化；
 *   - 释放时需遍历查找（O(n)）。
 *
 * ------------ 调试接口
 *   - slub_dump_state(tag)：打印当前各 cache 状态；
 *   - slub_check()：自动化完整测试。
 *
 * ------------ 总结
 * 本实验通过实现一个简化的 SLUB 分配器，
 * 体现了 Linux 内核中小对象分配器的核心思想：
 *   —— 层次化的内存管理、按对象大小缓存、快速复用。
 * 尽管省略了复杂的性能优化，但完整展示了内核内存分配器的基本机制与逻辑。
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
