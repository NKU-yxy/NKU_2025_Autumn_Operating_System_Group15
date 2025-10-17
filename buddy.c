#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>
// 为了 cprintf
#include <stdio.h>   

#define BUDDY_MAX_ORDER   16              // 支持到 2^16 页
#define ORDER_OF_PAGES(o) (1U << (o)) 

// 多阶空闲表与总空闲页数
static struct
{
    list_entry_t free_lists[BUDDY_MAX_ORDER + 1]; // 每阶一个双向链表头
    size_t nr_free;                               // 以“页”为单位
} buddy_area;

// 对输入的页数n向上取到2^k次方，eg. n=3 --> k=2（2^2=4）
static inline int find_upper_number(size_t n) 
{
    int k = 0; 
    size_t v = 1;
    while (v < n) 
    { 
        v=v*2;
        k++; 
    }
    return k;
}

// PFN <-> Page 间的互相转换
static inline size_t turn_page_to_pfn(struct Page *p) 
{ 
    // 直接调用pmm.h内的函数page2pa即可,实现思路如下：
    // 首先是pmm.h内的page2ppn，拿来得到页帧号ppn=(page-pages)+nbase，括号得到这是第几页，然后再加上基地址
    // 此处的基地址,我们选取了page_size=4KB，所以基本的nbase=0x80000000/4096=0x80000
    // 然后是计算物理地址pa，pa=ppn*page_size，即左移PGSHIFT(=12)
    // 这些都在pmm.c内有的
    // 最后我们手动右移，因为我们需要的是pfn而非pa，最后得到结果
    return page2pa(p) >> PGSHIFT; 
}

static inline struct Page* turn_pfn_to_page(size_t pfn) 
{ 
    // 基本同上：
    // 对于函数turn_pfn_to_page 我们获得输入pfn 先左移12位得到pa，然后再：
    // pa2page函数可以在pmm.h内找到，先是通过mmu.h内的宏定义PPN()对输入的物理地址pa右移12位，得到ppn
    // 然后再是减掉基地址nbase，这样就得到了idx=pfn-nbase
    // 然后返回&pages[idx] 这样就返回了对应的page指针
    return pa2page((pfn << PGSHIFT)); 
}