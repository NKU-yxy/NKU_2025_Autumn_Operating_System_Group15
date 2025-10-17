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

// 在order阶对应的空闲表里精确查找目标块p并删除 
// 此函数方便后续寻找某块对应的buddy块，方便后续合并，
// 成功返回1，否则返回0
static int remove_block_exact(struct Page *p, int order) 
{
     assert(order >= 0 && order <= BUDDY_MAX_ORDER); 
    list_entry_t *le = &flist(order);
    while ((le = list_next(le)) != &flist(order)) // 从链表头后下一个节点开始遍历（环形）
    {
        struct Page *q = le2page(le, page_link); // 依然将指向list_entry_t的指针转换为指向page的指针
        if (q == p) // 若是所寻找的目标块
        {
            list_del(le); // 将指针le删去
            ClearPageProperty(q); // 将PageProperty置0，表示其不再空闲
            q->property = 0; // 将property设置为0
            return 1; // 返回1表示success
        } 
    }
    return 0;
}

#define BUDDY_NR_FREE (buddy_area.nr_free)

// buddy算法初始化：将所有order的空闲list都设置为空，并且将全局的空闲页计数设置为0，方便后续
static void buddy_init(void) // 第二个void表示0参数
{
    for (int o = 0; o <= BUDDY_MAX_ORDER; ++o) // order从0到max_order，全部用函数list_init（），将双向链表的头项的prev指针和next指针都指向自己，实现每个链表都只有头block
        list_init(&flist(o));
    BUDDY_NR_FREE = 0;
}

// 然后是对物理空间的拆分，将其拆分为2^k的大小的页块，eg.1 2 4 8 16 ...
// 也就是把 [base, base+n) 这个区间拆成 按对齐的最大 2^k 页块 并且依次挂入空闲表 然后++全局的可用页数
static void buddy_init_memmap(struct Page *base, size_t n) 
{
    assert(n > 0);
    struct Page *p = base;
    // 循环把所有的page的标志位flag以及大小属性prperty都设置为0，保证page是干净并且可以分配的
    for (; p != base + n; ++p) 
    {
        assert(PageReserved(p)); // 对page进行检查，保证操作的page得是未被分配的
        p->flags = p->property = 0; // 置为0
        set_page_ref(p, 0);  // set_page_ref()在pmm.h内，很简单，就是把p的计数ref设置为0
    }
    // 计算起始page的pfn，方便后续对齐
    size_t pfn = turn_page_to_pfn(base);
    // while循环负责处理取块--->拆块--->入对应list--->对齐（修改blk）---> buddy_nr_free + blk（增加全局可用页数）
    while (n > 0) 
    {
        int k = 0;
        // while循环承担两个作用：
        // 1.找到一个最大的k且满足2^(k+1)<=n 
        // 2.(GPT帮改的)满足对齐条件，pfn是2^(k+1)的倍数，选出当前位置又能对齐又不会出界的最大的k
        // 都用k+1而不是k是为了寻找到最大的合法的k，eg. 若n=40 则当k=0就合法了 并且0+1也合法 就这样一直到k=4 发现k=4+1不合法了 所以最后k就是4
        while (k + 1 <= BUDDY_MAX_ORDER && (ORDER_OF_PAGES(k + 1) <= n) && ((pfn & (ORDER_OF_PAGES(k + 1) - 1)) == 0)) 
        {
            k++;
        }
        push_block(base, k); // 将地址base对应的page设置为初始page,大小为2^k的自由page组成的块插入order为k对应的链表并设置属性（函数在line 70）
        size_t blk = ORDER_OF_PAGES(k); // blk表示新增加的页数--2^k个page
        base += blk; // 基地址对应偏移
        pfn  += blk; // pfn同步偏移
        n    -= blk; // n减掉已经分配了的npage，接着循环
        BUDDY_NR_FREE += blk; // 全局空闲页+blk
    }
}