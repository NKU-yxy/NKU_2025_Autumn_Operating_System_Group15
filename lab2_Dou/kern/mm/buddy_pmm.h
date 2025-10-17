#ifndef __KERN_MM_BUDDY_PMM_H__
#define __KERN_MM_BUDDY_PMM_H__

#include <defs.h>
#include <list.h>
#include <pmm.h>

// 最大阶次（即最大块为 2^MAX_ORDER 页）
#define MAX_ORDER 10  // 2^10 * 4KB = 4MB，根据实际物理内存可调

typedef struct {
    list_entry_t free_list[MAX_ORDER];  // 每阶空闲链表
    unsigned int nr_free[MAX_ORDER];    // 各阶空闲块计数
} buddy_free_area_t;

extern const struct pmm_manager buddy_pmm_manager;

#endif /* !__KERN_MM_BUDDY_PMM_H__ */
