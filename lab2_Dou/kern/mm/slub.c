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
 * 我们实现了一个 两层架构的简化版 SLUB 分配器：
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
 *     size_t size;          // 管理的对象大小
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
 *    - 若所有页已满，创建新 slab page；
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
 * ------------ 调试接口
 *   - slub_dump_state(tag)：打印当前各 cache 状态；
 *   - slub_check()：自动化完整测试。
 *
 */

#define MAX_BUCKET 9
static const size_t bucket_size[MAX_BUCKET] = {8,16,32,64,128,256,512,1024,2048};

typedef struct slab_obj {
    struct slab_obj *next;
} slab_obj_t;

typedef struct slab_page {
    list_entry_t list;      // 链入每个 bucket 的 page 链表（页起始位置存储）
    slab_obj_t *free;       // 当前页中空闲对象链表
    size_t obj_size;        // 每个对象的大小
    size_t nr_free;         // 当前空闲对象数
    size_t capacity;        // 当前页最多可容纳对象总数
} slab_page_t;

typedef struct slab_cache {
    size_t size;
    list_entry_t pages;     // 所有 slab_page_t 的链表（每页头部存储 slab_page_t）
    slab_obj_t *global_free; // 全局备用空闲对象（简化实现中未使用）
    unsigned int nr_pages;  // 当前 cache 管理的页数量
} slab_cache_t;

static slab_cache_t caches[MAX_BUCKET];

static void slub_dump_state(const char *tag) {
    cprintf("-- SLUB 状态: %s --\n", tag);
    for (int i = 0; i < MAX_BUCKET; i++) {
        slab_cache_t *c = &caches[i];
        cprintf(" cache[%2d] 对象大小=%4lu 页数=%u\n", i, (unsigned long)c->size, c->nr_pages);
        list_entry_t *le = &c->pages;
        while ((le = list_next(le)) != &c->pages) {
            slab_page_t *sp = to_struct(le, slab_page_t, list);
            // 从 slab_page_t 指针计算页的物理地址（pagev 是页对齐的指针）
            uintptr_t page_pa = page2pa(pa2page((uintptr_t)sp - va_pa_offset));
            cprintf("   页 pa=0x%08lx 对象大小=%lu 空闲数=%lu 容量=%lu\n",
                    page_pa, (unsigned long)sp->obj_size, (unsigned long)sp->nr_free, (unsigned long)sp->capacity);
        }
    }
    cprintf("-- SLUB 状态结束 --\n");
}

static int size_to_bucket(size_t size) {
    for (int i = 0; i < MAX_BUCKET; i++) {
        if (size <= bucket_size[i]) return i;
    }
    return -1; // 太大，无法放入 SLUB
}

static void slab_page_init(void *page, size_t obj_size) {
    slab_page_t *sp = (slab_page_t *)page;
    sp->free = NULL;
    sp->obj_size = obj_size;
    sp->nr_free = 0;
    list_init(&sp->list);

    // 从页头元信息之后开始放置对象
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
        // 太大 -> 按页对齐直接分配整页
        size_t np = (size + PGSIZE - 1) / PGSIZE;
        struct Page *p = alloc_pages(np);
        if (!p) return NULL;
        return (void *)page2pa(p) + va_pa_offset; // 返回内核虚拟地址
    }

    slab_cache_t *c = &caches[b];

    // 在已有的 slab 页中寻找空闲对象
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

    // 没有空闲页 -> 新分配一页并初始化
    struct Page *p = alloc_pages(1);
    if (!p) return NULL;
    void *pagev = (void *)((uintptr_t)page2pa(p) + va_pa_offset);
    slab_page_init(pagev, c->size);
    slab_page_t *sp = (slab_page_t *)pagev;
    // 将新页挂入 cache 页链表
    list_add(&c->pages, &sp->list);
    c->nr_pages++;
    // 从该页取出一个对象返回
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
    // 从虚拟地址映射到物理地址，再映射到 page 结构
    uintptr_t v = (uintptr_t)ptr;
    if (v < va_pa_offset) return; // 非内核虚拟地址
    uintptr_t pa = v - va_pa_offset;
    struct Page *p = pa2page(pa);
    // 页的虚拟基址
    void *pagev = (void *)((uintptr_t)page2pa(p) + va_pa_offset);
    slab_page_t *sp = (slab_page_t *)pagev;
    // 检查是否为 slab 页
    if (sp->obj_size == 0) return; // 非 slab 页
    // 确认对象地址位于该页的对象区域中
    uintptr_t obj_start = (uintptr_t)pagev + sizeof(slab_page_t);
    uintptr_t obj_end = (uintptr_t)pagev + PGSIZE;
    if ((uintptr_t)ptr < obj_start || (uintptr_t)ptr >= obj_end) {
        // 不在对象区间内
        return;
    }
    // 检查 double free：遍历该页空闲链，若重复则报警
    slab_obj_t *it = sp->free;
    while (it) {
        if ((void *)it == ptr) {
            cprintf("slub kfree: 检测到 double free %p\n", ptr);
            return;
        }
        it = it->next;
    }
    // 将对象挂回空闲链
    slab_obj_t *o = (slab_obj_t *)ptr;
    o->next = sp->free;
    sp->free = o;
    sp->nr_free++;

    // 若该页已完全空闲，释放整页并从 cache 中移除
    if (sp->nr_free >= sp->capacity) {
        list_del(&sp->list);
        // 减少对应 cache 的页计数
        for (int i = 0; i < MAX_BUCKET; i++) {
            if (caches[i].size == sp->obj_size) {
                if (caches[i].nr_pages > 0) caches[i].nr_pages--;
                break;
            }
        }
        // 清空头部信息以防混淆
        sp->free = NULL;
        sp->obj_size = 0;
        sp->nr_free = 0;
        sp->capacity = 0;
        free_pages(p, 1);
    }
}

void slub_check(void) {
    cprintf("slub_check: 开始测试\n");
    size_t before = nr_free_pages();

    slub_dump_state("初始状态");

    // 分配不同大小的一批对象
    void *objs[128];
    int cnt = 0;
    for (int i = 0; i < 20; i++) {
        size_t s = 8 + (i % 9) * 16;
        objs[cnt] = kmalloc(s);
        cprintf("slub 分配 size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
        cnt++;
    }
    for (int i = 0; i < 30; i++) {
        size_t s = 64 + (i % 6) * 32;
        objs[cnt] = kmalloc(s);
        cprintf("slub 分配 size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
        cnt++;
    }
    for (int i = 0; i < 10; i++) {
        size_t s = 1500;
        objs[cnt] = kmalloc(s); // 大对象（接近最大桶或更大）
        cprintf("slub 分配 size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
        cnt++;
    }

    for (int i = 0; i < cnt; i++) assert(objs[i] != NULL);

    // 释放一半对象
    for (int i = 0; i < cnt; i += 2) kfree(objs[i]);
    slub_dump_state("释放一半后");

    // 再次分配以测试复用
    void *more[64];
    for (int i = 0; i < 30; i++) more[i] = kmalloc(64);
    for (int i = 0; i < 30; i++) {
        cprintf("slub 再次分配 size=64 -> %p\n", more[i]);
        assert(more[i] != NULL);
    }

    // 释放剩余对象
    for (int i = 1; i < cnt; i += 2) kfree(objs[i]);
    slub_dump_state("释放剩余对象后");
    for (int i = 0; i < 30; i++) kfree(more[i]);
    slub_dump_state("释放全部后");

    // 检查释放后空闲页是否恢复
    size_t after = nr_free_pages();
    cprintf("slub_check: 释放前页数=%lu 释放后页数=%lu\n", (unsigned long)before, (unsigned long)after);
    assert(after >= before);
    cprintf("slub_check: 测试通过\n");
}
