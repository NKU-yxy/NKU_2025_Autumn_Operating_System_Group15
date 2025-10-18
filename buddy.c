/*
// ----- 设计文档 -----------------------------------------------------------------------------------//

全流程： 获取一个需求(请求大小为n page的内存) 
        ---> 分配(alloc) 向上取整到2^k(n<=2^k) 然后尝试分配2^k大小的block，不行就接着k++
        ---> 拆分(split) 从申请到的block拆分出一个大小为n page的块 剩下的返回free list中 然后对buddy_nr_free减n
        ---> 这样就成功申请并且分配了一个大小为n page的连续内存

        申请完后释放（free）大小为n page的内存:
        ---> 释放(free) 利用while循环 尽量将大小为n的拆分成大的且大小满足 2^k的block 一直循环拆 最小拆成2^0=1的块 并且对buddy_nr_free加n
        ---> 合并(merge) 将free后的散块按照从小到大进行合并 就像游戏2048那样 然后再将无法再变大的block插入回对应order的free list
        ---> 至此释放一个大小为n page的内存

代码实现：
    函数： 
    • ORDER_OF_PAGES(o)：把阶数 o 变成页数 2^o。
    • find_upper_number(n)：把 n 向上凑成最小的 2^k，返回 k。
    • turn_page_to_pfn(p) / turn_pfn_to_page(pfn)：Page* 和 PFN 来回转。
    • push_block(p, o)：把以 p 为头、大小 2^o 的空闲块丢进 o 阶链表，打上头页标记。
    • pop_block(o)：从 o 阶链表拿一个块，去掉头页标记并返回头页指针。
    • remove_block_exact(p, o)：在 o 阶链表里精确把块 p 删掉。
    • buddy_of(p, o)：用 pfn ^ 2^o 找 p 的伙伴块头页。
    • check_if_head_page(p, s)：判断 p 是否对齐到 s=2^o，是头页就对齐。

    变量：
    • buddy_area.free_lists[o]：每个阶一个双向环链，存空闲头块。
    • buddy_area.nr_free：当前空闲页总数。
    • 宏：BUDDY_NR_FREE 是上面的别名，读写方便。

    流程：
    1.init logic：
    buddy_init()：把每个阶的链表设成空环，BUDDY_NR_FREE=0。
    buddy_init_memmap(base, n)：将所有物理内存进行分配，切分为2^o大小后 对应插入o对用的双向链表 最后各阶链表只含对齐好的 2^o 大小的块

    2.分块logic:
    split_block(head, bigger_order, n): 拆的时候始终保持两半都对齐到 2^(o-1)，未用半块都回收到对应阶。

    3.alloc logic:
    buddy_alloc_pages(n)：对于输入n 计算需要的阶need(n<=2^need) 从need阶从小到大找 找到一个block后再调用split拆出大小恰好为n的块 然后buddy_nr_free减去n

    4.free logic:
    buddy_free_pages(base, n)：利用while循环将连续大小为n的区间按“最大且对齐的 2^o”切开 并且将buddy_nr_free加n
    free_one_block_and_merge(p, o)：实现block合并,从小到大尝试合并，合并完后挂回对应阶的list

    5.check logic:
    check_each_list_block(tag)：数每阶块数 × 大小，和理论上应等于 nr_free_pages()
    buddy_own_check()：分配 n=1,2,3 再乱序释放 然后观察buddy_nr_free是否符合需求 符合就打印success


// ----- END -----------------------------------------------------------------------------------//

*/

#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>
// 为了 cprintf
#include <stdio.h>   

#define BUDDY_MAX_ORDER   16              // 支持到 2^16 页

// 输入o 返回2^o 即对应的大小
static inline size_t ORDER_OF_PAGES(unsigned o) 
{
    return (size_t)1 << o;
}

// 解决pmm.c内nr_free_pages曾被定义为函数的问题 方便后面当变量写
#ifdef nr_free_pages
#undef nr_free_pages
#endif

// 多阶空闲表与总空闲页数
static struct
{
    list_entry_t free_lists[BUDDY_MAX_ORDER + 1]; // 每阶一个双向链表头
    size_t nr_free;                               // 以“页”为单位
} buddy_area;

// 方便后续统计全局free的页数 对于nr_free进行修改
#define BUDDY_NR_FREE (buddy_area.nr_free)

// 定义flist 方便后续 flist意思就是list的第一个 也就是头
#define flist(order) (buddy_area.free_lists[(order)])

// 对输入的页数n向上取到2^k次方，eg. n=3 --> k=2（2^2=4）
static inline int find_upper_number(size_t n) 
{
    int k = 0; 
    size_t v = 1;
    while (v < n) 
    { 
        v=v<<1;
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

// 返回o阶对应的链表的块首的buddy的头页指针
// 为什么需要？ 
// 因为后续合并需要判断buddy是否闲，必须知道buddy的头指针才能访问property属性来确定是否闲
// 如何得到buddy_pfn?
// 直接和2^o 异或 就行 
// eg. o=3 原先pfn=b11000(24) 这样2^o＝b01000 异或得到: b10000(16) [24...31]的buddy就是[16...23]
static inline struct Page *buddy_of(struct Page *p, int o) 
{
    size_t s   = ORDER_OF_PAGES(o); // s = 1^o 得到页数/大小
    size_t p_pfn = turn_page_to_pfn(p); // 获得p的pfn
    size_t buddy_pfn = p_pfn ^ s; // 一个块的pfn和其buddy的pfn只差了第o位，所以我们直接反转第o位就能得到伙伴的pfn 这里我们通过和s异或就能得到对应的buddy_pfn
    return p + (size_t)(buddy_pfn - p_pfn);
}

// 检查p是否为头page：将p转换为pfn后与s_pages相除，看余数是否为0，若为0则证明已经对齐，即是头page
#define check_if_head_page(p, s_pages) ( ( (turn_page_to_pfn(p)) % (s_pages) == 0 ) )

// 将以p为头的2^o页的空闲块释放到空闲List，并尽量和同阶的buddy块连续合并后再放回对应的阶的链表内
static void free_one_block_and_merge(struct Page *p, int o) 
{
    size_t s = ORDER_OF_PAGES(o); // s = 2^o 

    assert(check_if_head_page(p, s)); // 检查p是否为头page
    p->property = s; // 写入块大小s
    SetPageProperty(p); // 将PageProperty置1，表示是头page

    // 从小到大尝试合并,max是最大阶max_order
    while (o < BUDDY_MAX_ORDER) 
    {
        // page指针q指向p的buddy page
        struct Page *q = buddy_of(p, o);

        // q不能越界，进行检查
        if (q < pages || q >= pages + npage)
            break;
        // 若伙伴不是空闲的头 or 大小不相同就停止合并
        if (!PageProperty(q) || q->property != s) 
            break;

        // 若大小合适且空闲 就摘出来并且把PageProperty置0 表示不再是free的头page了
        list_del(&q->page_link);
        ClearPageProperty(q); // 置0

        // 选择更小的头page作为合并后的新的头page
        if (q < p) 
            p = q;
        // 阶数 o++ && s=s*2
        s <<= 1; 
        o++;
        assert(check_if_head_page(p, s)); // 接着检查新的头有没有对齐
        // 更新peoperty属性 变为新的s(s=原先的2倍)
        p->property = s;
        SetPageProperty(p);  // 接着把p的PageProperty设置为1，表示是头page
    }
    // 把得到的新合并的挂到对应的o的free list
    list_add(&flist(o), &p->page_link);
}

// 将区间 [base,base+n) 释放
static void buddy_free_pages(struct Page *base, size_t n) 
{
    assert(n > 0);
    // 先把释放page的引用计数ref设置为0
    for (struct Page *p = base; p != base + n; ++p) 
    {
        // 保证这一页不是保留页并且也不是free的再进行操作
        assert(!PageReserved(p));
        assert(!PageProperty(p));

        set_page_ref(p, 0); // set_page_ref()在pmm.h内，很简单，就是把p的计数ref设置为0
    }

    size_t base_pfn = turn_page_to_pfn(base);
    size_t remaining_n = n;
    while (remaining_n > 0) 
    {
        int k = 0;
        // 依然找到尽量大的且合法的k
        while (k + 1 <= BUDDY_MAX_ORDER && ORDER_OF_PAGES(k + 1) <= remaining_n && ((base_pfn & (ORDER_OF_PAGES(k + 1) - 1)) == 0)) 
        {
            k++;
        }
        // 将以p为头的2^k页的空闲块释放到空闲List，并尽量和同阶的buddy块连续合并后再放回对应的阶的链表内
        free_one_block_and_merge(base, k);

        size_t blk = ORDER_OF_PAGES(k); // blk = 2^k
        base += blk; 
        base_pfn  += blk;
        remaining_n -= blk; 
    }
    BUDDY_NR_FREE += n;  // 统一加n n长度的区间释放就会得到新的n页
}


// 将大区间拆分为两部分，一部分为需要的n页，另一部分作为新的remianing
// 递归实现
static struct Page* split_block(struct Page *head, int bigger_order, size_t n) 
{
    size_t whole = ORDER_OF_PAGES(bigger_order);
    // Case 1:最简单的情况 =无需拆分 直接返回head即可
    if (n == whole) 
        return head;

    size_t half = whole >> 1;
    // Page一分为二 left指向head的地址 right指向(head+half)
    struct Page *left  = head; 
    struct Page *right = head + half;
    // Case 2: 需要的n页较小，n<half 则将左半部分接着拆分 右半边原封不动回收
    if (n <= half) 
    {
        // 将右半边空间回收
        push_block(right, bigger_order - 1);
        // 左半边递归
        return split_block(left, bigger_order - 1, n);
    } 
    // Case 3:需要的n较大 则左半边的half页+右边的(n-half)页拿来分配
    // case3待补充 为什么要多return一个head????
    else 
    {
        // 对右半边接着递归 分配所需要的
        struct Page* temp= split_block(right, bigger_order - 1, n - half);
        // 接着调用右边最后会递归的返回一个page*，但我们其实并不需要这个指针 所以直接void掉 也可以写成:(void)split_block(right, bigger_order - 1, n - half);
        (void) temp;
        return head;  // 这一处需要返回head是因为进入递归后函数会返回一个新的head 
                     // 但实际分配的块应该是以最开始的区间的head为head 所以要先返回一个head作为真正的head
    }
}



// 作用：取出n页连续的物理空间
// 若n>buddy_nr_free 则证明无法满足 直接返回null
// 若n<buddy_nr_free,先求出need 满足n<=2^need 然后从need阶及以上对应的free list寻找有无free的块
// 然后找到合适的块后 再调用split_block对块进行拆分 只拿出n页的大小的块 其余按照对应大小放回free list 
// 最后更新buddy_nr_free 让其减去n 至此结束
static struct Page* buddy_alloc_pages(size_t n) 
{
    assert(n > 0);
    if (n > BUDDY_NR_FREE) 
        return NULL;

    int need = find_upper_number(n);
    int curr_order = need;
    struct Page *blk = NULL; // blk保存找到的块的head(从某一>=need阶的free list取出来的块的地址)
    // 寻找适合的块 从小到大
    for (; curr_order <= BUDDY_MAX_ORDER; curr_order++)
    {
        // 若curr_order阶对应的free list不是空的，则取一块下来作为blk，准备后续拆分
        if ( !list_empty( &flist( curr_order ) ) ) 
            { 
                blk = pop_block(curr_order); 
                break; 
            }
    }
    // 若遍历后 发现没有适合的块 那就返回Null
    if (blk == NULL) 
        return NULL;
    // 若有合适的块 就对其拆分 只要n page大小 其他还回去
    struct Page *result = split_block(blk, curr_order, n);
    BUDDY_NR_FREE -= n;
    return result;
}

// 返回全局的空闲页数
static size_t buddy_nr_free_pages(void) 
{ 
    return BUDDY_NR_FREE; 
}

// 自己写的 print 函数
// 检查每一个order对应的free list的空闲块数 累加后与buddy_nr_free_pages对比是否一致
static size_t check_each_list_block(const char *tag) 
{
    size_t total = 0;
    cprintf("[BUDDY] %s\n", tag);
    // 遍历每个order的free list
    for (int o = 0; o <= BUDDY_MAX_ORDER; ++o)
     {
        size_t cnt = 0;
        list_entry_t *head = &flist(o);
        list_entry_t *le = head;
        // 环形的list 若le==head 证明已经遍历完了
        while ((le = list_next(le)) != head) 
        {
            struct Page *p = le2page(le, page_link);
            assert(PageProperty(p)); // 保证必须得是头页且空闲的
            assert(p->property == ORDER_OF_PAGES(o));  // property必须==2^o 大小要对
            cnt++; // 都满足就认为是一个合适的 进行++
        }
        // 然后 total要 + cnt*2^o
        size_t pages = cnt * ORDER_OF_PAGES(o);
        total += pages;
        cprintf("  order=%2d  blk=%4d  blocks=%5d  pages=%7d\n",
                o, ORDER_OF_PAGES(o), cnt, pages);
    }
    size_t nfree = nr_free_pages();
    cprintf("  ==> total_pages=%d  nr_free_pages=%d  %s\n",
            total, nfree, (total == nfree ? "[YES!]" : "[WRONG!]")); // 累加和==nfree 就输出[yes] 不然输出[wrong]
    assert(total == nfree);
    return total; 
}

// 然后进行check
static void buddy_own_check(void) 
{
    // 1.统计alloc前的free_page数量
    size_t before = check_each_list_block("before");

    // 2) 进行三次分配 n=1,2,3 按照顺序 总共6页
    // assert()确保分配成功
    struct Page *a = alloc_pages(1);  
    assert(a);
    struct Page *b = alloc_pages(2);  
    assert(b);
    struct Page *c = alloc_pages(3);  
    assert(c);
    // 再check一下 是不是真的只是消耗了6个page
    size_t after_alloc = check_each_list_block("after alloc");
    cprintf("[BUDDY] expect change = -6 pages\n");
    assert(after_alloc + 6 == before);

    // 3) 打乱释放 检查是否真的能自己释放好page
    free_pages(c, 3);
    free_pages(a, 1);
    free_pages(b, 2);

    size_t after_free = check_each_list_block("after free");
    cprintf("[BUDDY] expect change = 0 pages\n");
    assert(after_free == before);

    // 若前面都通过 证明buddy实现成功
    cprintf("Buddy SUCCESS !\n");
}

// pmm_manager 实例
const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_own_check
};