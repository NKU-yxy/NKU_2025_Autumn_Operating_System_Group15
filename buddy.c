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

// 定义flist方便后续写，flist(order)即为order阶对应的list的表头
#define flist(order) (buddy_area.free_lists[(order)])

// 把一个“空闲块头页”p 插入 order阶对应的空闲表，并设置空闲&头页属性(原函数在memlayout.h内)
static inline void push_block(struct Page *p, int order) 
{
    assert(order >= 0 && order <= BUDDY_MAX_ORDER); // 先是检验order的值是否符合正常的范围
    p->property = ORDER_OF_PAGES(order);   // property=块包含的页数,order_of_pages就是输入order，返回 2^order
    SetPageProperty(p); //把空闲块头页标识符（PageProperty）置位，表示这是一个空闲块的头页
    list_add(&flist(order), &(p->page_link)); // 头插到对应阶的链表,flist(order)表示的是对应链表的头节点,用&获取地址，实现连接
}

// 从order阶对应的空闲表弹出一个块（若无则返回 NULL）
static struct Page* pop_block(int order) 
{
    list_entry_t *le = &flist(order);  // 先是用le指向order阶对应的链表头
    if (list_empty(le)) // 若对应链表为空，则返回null，表示没有需要的块能pop出来
        return NULL;
    le = list_next(le); // 若对应链表不为空，则将le指向链表的第二个block
    struct Page *p = le2page(le, page_link); // le2page()在memlayout.h内，作用是把指向list_entry_t的指针le转换为指向Page的指针p
    list_del(le); // 将pop出的块从链表中删去
    ClearPageProperty(p); // 将p的首位（PageProperty）置0，表示其已不再是一个空闲的block了
    p->property = 0; // 将p的property变成0，因为理论上当Pageproperty为0时，property就应该设置为0.表示该块已经被分配or非空闲块的头页
    return p; 
}