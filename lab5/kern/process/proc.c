#include <proc.h>
#include <kmalloc.h>
#include <string.h>
#include <sync.h>
#include <pmm.h>
#include <error.h>
#include <sched.h>
#include <elf.h>
#include <vmm.h>
#include <trap.h>
#include <riscv.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>


/* ------------- process/thread mechanism design&implementation -------------
(an simplified Linux process/thread mechanism )
introduction:
  ucore implements a simple process/thread mechanism. process contains the independent memory sapce, at least one threads
for execution, the kernel data(for management), processor state (for context switch), files(in lab6), etc. ucore needs to
manage all these details efficiently. In ucore, a thread is just a special kind of process(share process's memory).
------------------------------
process state       :     meaning               -- reason
    PROC_UNINIT     :   uninitialized           -- alloc_proc
    PROC_SLEEPING   :   sleeping                -- try_free_pages, do_wait, do_sleep
    PROC_RUNNABLE   :   runnable(maybe running) -- proc_init, wakeup_proc,
    PROC_ZOMBIE     :   almost dead             -- do_exit

-----------------------------
process state changing:

  alloc_proc                                 RUNNING
      +                                   +--<----<--+
      +                                   + proc_run +
      V                                   +-->---->--+
PROC_UNINIT -- proc_init/wakeup_proc --> PROC_RUNNABLE -- try_free_pages/do_wait/do_sleep --> PROC_SLEEPING --
                                           A      +                                                           +
                                           |      +--- do_exit --> PROC_ZOMBIE                                +
                                           +                                                                  +
                                           -----------------------wakeup_proc----------------------------------
-----------------------------
process relations
parent:           proc->parent  (proc is children)
children:         proc->cptr    (proc is parent)
older sibling:    proc->optr    (proc is younger sibling)
younger sibling:  proc->yptr    (proc is older sibling)
-----------------------------
related syscall for process:
SYS_exit        : process exit,                           -->do_exit
SYS_fork        : create child process, dup mm            -->do_fork-->wakeup_proc
SYS_wait        : wait process                            -->do_wait
SYS_exec        : after fork, process execute a program   -->load a program and refresh the mm
SYS_clone       : create child thread                     -->do_fork-->wakeup_proc
SYS_yield       : process flag itself need resecheduling, -- proc->need_sched=1, then scheduler will rescheule this process
SYS_sleep       : process sleep                           -->do_sleep
SYS_kill        : kill process                            -->do_kill-->proc->flags |= PF_EXITING
                                                                 -->wakeup_proc-->do_wait-->do_exit
SYS_getpid      : get the process's pid

*/

// the process set's list
list_entry_t proc_list;

#define HASH_SHIFT 10
#define HASH_LIST_SIZE (1 << HASH_SHIFT)
#define pid_hashfn(x) (hash32(x, HASH_SHIFT))

// has list for process set based on pid
static list_entry_t hash_list[HASH_LIST_SIZE];

// idle proc
struct proc_struct *idleproc = NULL;
// init proc
struct proc_struct *initproc = NULL;
// current proc
struct proc_struct *current = NULL;

static int nr_process = 0;

void kernel_thread_entry(void);
void forkrets(struct trapframe *tf);
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
// 在操作系统内核中分配并初始化进程控制块（Process Control Block, PCB
static struct proc_struct *
alloc_proc(void)
{
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
    // 如果分配成功
    if (proc != NULL)
    {
        proc->state = PROC_UNINIT;
        proc->pid = -1;
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context)); 
        proc->tf = NULL;
        proc->pgdir = 0;
        proc->flags = 0;
        memset(proc->name, 0, sizeof(proc->name));
        list_init(&(proc->list_link));
        list_init(&(proc->hash_link));
        // 修改了的部分
        proc->exit_code = 0; // 进程退出码初始化为0，默认正常退出
        proc->wait_state = 0; // 等待状态初始化为0，表示不在等待任何事件
        proc->cptr = proc->yptr = proc->optr = NULL; // cptr指向第一个子进程，yptr指向下一个兄弟进程，optr指向上一个兄弟进程.先都设置为空
    }
    return proc; // 返回分配的进程控制块指针，其指向新分配的PCB结构体
}

// set_proc_name - set the name of proc
char *
set_proc_name(struct proc_struct *proc, const char *name)
{
    memset(proc->name, 0, sizeof(proc->name));
    return memcpy(proc->name, name, PROC_NAME_LEN);
}

// get_proc_name - get the name of proc
char *
get_proc_name(struct proc_struct *proc)
{
    static char name[PROC_NAME_LEN + 1];
    memset(name, 0, sizeof(name));
    return memcpy(name, proc->name, PROC_NAME_LEN);
}

// set_links - set the relation links of process
static void
set_links(struct proc_struct *proc)
{
    list_add(&proc_list, &(proc->list_link));
    proc->yptr = NULL;
    if ((proc->optr = proc->parent->cptr) != NULL)
    {
        proc->optr->yptr = proc;
    }
    proc->parent->cptr = proc;
    nr_process++;
}

// remove_links - clean the relation links of process
static void
remove_links(struct proc_struct *proc)
{
    list_del(&(proc->list_link));
    if (proc->optr != NULL)
    {
        proc->optr->yptr = proc->yptr;
    }
    if (proc->yptr != NULL)
    {
        proc->yptr->optr = proc->optr;
    }
    else
    {
        proc->parent->cptr = proc->optr;
    }
    nr_process--;
}

// get_pid - alloc a unique pid for process
static int
get_pid(void)
{
    static_assert(MAX_PID > MAX_PROCESS);
    struct proc_struct *proc;
    list_entry_t *list = &proc_list, *le;
    static int next_safe = MAX_PID, last_pid = MAX_PID;
    if (++last_pid >= MAX_PID)
    {
        last_pid = 1;
        goto inside;
    }
    if (last_pid >= next_safe)
    {
    inside:
        next_safe = MAX_PID;
    repeat:
        le = list;
        while ((le = list_next(le)) != list)
        {
            proc = le2proc(le, list_link);
            if (proc->pid == last_pid)
            {
                if (++last_pid >= next_safe)
                {
                    if (last_pid >= MAX_PID)
                    {
                        last_pid = 1;
                    }
                    next_safe = MAX_PID;
                    goto repeat;
                }
            }
            else if (proc->pid > last_pid && next_safe > proc->pid)
            {
                next_safe = proc->pid;
            }
        }
    }
    return last_pid;
}

// proc_run - make process "proc" running on cpu
// NOTE: before call switch_to, should load  base addr of "proc"'s new PDT
// 修改修改修改修改
void proc_run(struct proc_struct *proc)
{
    if (proc != current)
    {
        bool intr_flag;
        struct proc_struct *prev = current;
        // 禁用CPU中断（CLI），避免切换过程被中断（如时钟中断）打断；
        local_intr_save(intr_flag);
        // 修改部分：
        // 之前是不区分用户进程还是内核线程就直接无条件调用 lsatp(proc->pgdir)
        // 但现在改为了区分，按 current->mm 是否为 NULL 分支，如果是用户进程就加载它自己的 pgdir，否则加载内核的 pgdir
        {
            current = proc;
            // 用户进程 mm!=NULL，加载用户进程的 pgdir
            if (current->mm != NULL)
            {
                lsatp(current->pgdir);
            }
            // 内核线程 mm==NULL，加载内核的 pgdir
            else
            {
                lsatp(boot_pgdir_pa);
            }
            // 上下文切换核心操作.同前
            switch_to(&(prev->context), &(current->context));
        }
        // 恢复中断状态
        local_intr_restore(intr_flag);
    }
}

// forkret -- the first kernel entry point of a new thread/process
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
}

// hash_proc - add proc into proc hash_list
static void
hash_proc(struct proc_struct *proc)
{
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
}

// unhash_proc - delete proc from proc hash_list
static void
unhash_proc(struct proc_struct *proc)
{
    list_del(&(proc->hash_link));
}

// find_proc - find proc frome proc hash_list according to pid
struct proc_struct *
find_proc(int pid)
{
    if (0 < pid && pid < MAX_PID)
    {
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
        while ((le = list_next(le)) != list)
        {
            struct proc_struct *proc = le2proc(le, hash_link);
            if (proc->pid == pid)
            {
                return proc;
            }
        }
    }
    return NULL;
}

// kernel_thread - create a kernel thread using "fn" function
// NOTE: the contents of temp trapframe tf will be copied to
//       proc->tf in do_fork-->copy_thread function
int kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags)
{
    struct trapframe tf;
    memset(&tf, 0, sizeof(struct trapframe));
    tf.gpr.s0 = (uintptr_t)fn;
    tf.gpr.s1 = (uintptr_t)arg;
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
    tf.epc = (uintptr_t)kernel_thread_entry;
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
}

// setup_kstack - alloc pages with size KSTACKPAGE as process kernel stack
static int
setup_kstack(struct proc_struct *proc)
{
    struct Page *page = alloc_pages(KSTACKPAGE);
    if (page != NULL)
    {
        proc->kstack = (uintptr_t)page2kva(page);
        return 0;
    }
    return -E_NO_MEM;
}

// put_kstack - free the memory space of process kernel stack
static void
put_kstack(struct proc_struct *proc)
{
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
}

// setup_pgdir - alloc one page as PDT
static int
setup_pgdir(struct mm_struct *mm)
{
    struct Page *page = NULL;
    if ((page = alloc_page()) == NULL)
    {
        return -E_NO_MEM;
    }
    pde_t *pgdir = page2kva(page);
    memcpy(pgdir, boot_pgdir_va, PGSIZE);

    mm->pgdir = pgdir;
    return 0;
}

// put_pgdir - free the memory space of PDT
static void
put_pgdir(struct mm_struct *mm)
{
    free_page(kva2page(mm->pgdir));
}

// copy_mm - process "proc" duplicate OR share process "current"'s mm according clone_flags
//         - if clone_flags & CLONE_VM, then "share" ; else "duplicate"
// 内核中实现进程地址空间复制 / 共享的核心函数，为 fork/vfork/clone 等系统调用提供底层支持。
// 其核心逻辑是：根据 clone_flags 中的 CLONE_VM 标志，
// 决定新进程 proc 与当前进程（current）的地址空间是共享（如 vfork）还是独立复制（如 fork)
static int
copy_mm(uint32_t clone_flags, struct proc_struct *proc)
{
    struct mm_struct *mm, *oldmm = current->mm;

    /* current is a kernel thread */
    // 内核线程无用户地址空间（current->mm = NULL），因此无需处理地址空间，直接返回 0（成功
    if (oldmm == NULL)
    {
        return 0;
    }
    // 共享地址空间分支（CLONE_VM 置位,新进程直接复用父进程的 mm_struct)
    // 无需复制页表和内存映射，仅递增引用计数
    if (clone_flags & CLONE_VM)
    {
        mm = oldmm;
        goto good_mm;
    }
    // 复制地址空间分支（CLONE_VM 未置位，新进程需要独立的地址空间)
    int ret = -E_NO_MEM;  // 默认错误码：内存不足
    
    if ((mm = mm_create()) == NULL)
    {
        goto bad_mm;  // 新建mm失败，跳转到最终错误分支
    }
    if (setup_pgdir(mm) != 0)
    {
        goto bad_pgdir_cleanup_mm; // 页表初始化失败，清理已创建的mm
    }
    lock_mm(oldmm); // 加锁：防止父进程修改地址空间
    {
        /* 
        COW 实现思路（dup_mmap函数）
        1. 遍历父进程的所有 VMA（如代码段、数据段、堆、栈）；
        2. 为新进程创建相同的 VMA 结构（复制地址范围、权限、映射文件等）；
        3. 实现 “写时复制（COW）”：不立即复制物理内存页，仅标记页表项为 “只读 + COW”，当任一进程写该页时，内核才复制物理页并修改权限；
        */
        ret = dup_mmap(mm, oldmm); // 复制父进程的虚拟内存映射到新mm
    }
    unlock_mm(oldmm); // 解锁

    if (ret != 0)
    {
        goto bad_dup_cleanup_mmap;
    }

good_mm:
    mm_count_inc(mm);
    proc->mm = mm;
    proc->pgdir = PADDR(mm->pgdir);
    return 0;
bad_dup_cleanup_mmap:
    exit_mmap(mm);
    put_pgdir(mm);
bad_pgdir_cleanup_mm:
    mm_destroy(mm);
bad_mm:
    return ret;
}

// copy_thread - setup the trapframe on the  process's kernel stack top and
//             - setup the kernel entry point and stack of process
static void
copy_thread(struct proc_struct *proc, uintptr_t esp, struct trapframe *tf)
{
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
    *(proc->tf) = *tf;

    // Set a0 to 0 so a child process knows it's just forked
    proc->tf->gpr.a0 = 0;
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;

    proc->context.ra = (uintptr_t)forkret;
    proc->context.sp = (uintptr_t)(proc->tf);
}

/* do_fork -     parent process for a new child process
 * @clone_flags: used to guide how to clone the child process
 * @stack:       the parent's user stack pointer. if stack==0, It means to fork a kernel thread.
 * @tf:          the trapframe info, which will be copied to child process's proc->tf
 */
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
{
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS)
    {
        goto fork_out;
    }
    ret = -E_NO_MEM;
    if ((proc = alloc_proc()) == NULL)
    {
        goto fork_out;
    }
    // 改动：多了一个对ret的赋值
    // 将 setup_kstack/copy_mm 的返回值直接赋值给 ret，再判断是否失败；
    // 确保 ret 保存最新、精准的错误码,方便判断出错类型
    if ((ret = setup_kstack(proc)) != 0)
    {
        goto bad_fork_cleanup_proc;
    }
    proc->parent = current;
    // 核心改动：重置了父进程的 wait_state
    // 创建子进程时，强制将父进程（current）的 wait_state 置 0,确保父进程创建子进程后处于「无等待、可调度」的正常状态，避免异常阻塞
    // 解决问题：之前父进程在创建子进程前如果处于等待状态（如等待子进程退出），
    // 那么创建子进程后父进程会继续处于等待状态，无法被调度执行，导致子进程也无法运行，形成死锁
    current->wait_state = 0; 
    // 改动：多了一个对ret的赋值
    // 将 setup_kstack/copy_mm 的返回值直接赋值给 ret，再判断是否失败；
    // 确保 ret 保存最新、精准的错误码,方便判断出错类型
    if ((ret = copy_mm(clone_flags, proc)) != 0)
    {
        goto bad_fork_cleanup_kstack;
    }
    copy_thread(proc, stack, tf);
    proc->state = PROC_RUNNABLE;
    bool intr_flag;
    proc->pid = get_pid();
    // 核心改动：用 local_intr_save/restore 包裹 hash_proc/set_links，禁用中断保证原子性：
    // 好处：防止在添加新进程到全局进程列表和哈希表的过程中被中断打断，避免数据结构不一致或竞争条件
    local_intr_save(intr_flag);
    {
        hash_proc(proc);
        set_links(proc);
    }
    local_intr_restore(intr_flag);
    // 改动：调用 wakeup_proc(proc) 标准化唤醒：
    // 好处：不仅设置就绪态，还将子进程加入就绪队列；2. 触发调度标记，调度器能识别并调度新进程，内存复制后的子进程可正常运行。
    wakeup_proc(proc);
    ret = proc->pid;

fork_out:
    return ret;

bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}

// do_exit - called by sys_exit
//   1. call exit_mmap & put_pgdir & mm_destroy to free the almost all memory space of process
//   2. set process' state as PROC_ZOMBIE, then call wakeup_proc(parent) to ask parent reclaim itself.
//   3. call scheduler to switch to other process
int do_exit(int error_code)
{
    if (current == idleproc)
    {
        panic("idleproc exit.\n");
    }
    if (current == initproc)
    {
        panic("initproc exit.\n");
    }
    struct mm_struct *mm = current->mm;
    if (mm != NULL)
    {
        lsatp(boot_pgdir_pa);
        if (mm_count_dec(mm) == 0)
        {
            exit_mmap(mm);
            put_pgdir(mm);
            mm_destroy(mm);
        }
        current->mm = NULL;
    }
    current->state = PROC_ZOMBIE;
    current->exit_code = error_code;
    bool intr_flag;
    struct proc_struct *proc;
    local_intr_save(intr_flag);
    {
        proc = current->parent;
        if (proc->wait_state == WT_CHILD)
        {
            wakeup_proc(proc);
        }
        while (current->cptr != NULL)
        {
            proc = current->cptr;
            current->cptr = proc->optr;

            proc->yptr = NULL;
            if ((proc->optr = initproc->cptr) != NULL)
            {
                initproc->cptr->yptr = proc;
            }
            proc->parent = initproc;
            initproc->cptr = proc;
            if (proc->state == PROC_ZOMBIE)
            {
                if (initproc->wait_state == WT_CHILD)
                {
                    wakeup_proc(initproc);
                }
            }
        }
    }
    local_intr_restore(intr_flag);
    schedule();
    panic("do_exit will not return!! %d.\n", current->pid);
}

/* load_icode - load the content of binary program(ELF format) as the new content of current process
 * @binary:  the memory addr of the content of binary program
 * @size:  the size of the content of binary program
 */
// load_icode作用：将 “静态 ELF 二进制数据” 转化为 “可执行的用户进程地址空间 + 可切换的用户态上下文”
/*
1. load_icode 的核心实现流程
1. 基础搭建：创建mm_struct和页目录表，为用户地址空间提供管理结构和页表基础；
2. ELF 解析：校验 ELF 合法性，遍历可加载段，创建 VMA 划分虚拟地址范围；
3. 内存加载：逐页分配物理内存，拷贝代码段 / 数据段，清零 BSS 段，构建完整的用户代码 / 数据空间；
4. 栈初始化：创建用户栈 VMA，预分配物理页，保证用户态栈可用；
5. 地址空间激活：关联mm到当前进程，加载页表到satp寄存器；
6. 上下文配置：清空旧陷阱帧，设置sp（用户栈顶）、epc（ELF 入口）、status（用户态特权级），保证sret能正确进入用户态执行第一条指令。
*/
static int
load_icode(unsigned char *binary, size_t size)
{
    // 确保进程无现有用户地址空间
    // 需要保证加载新 ELF 前地址空间 “干净”，避免旧内存数据干扰新程序执行
    if (current->mm != NULL)
    {
        panic("load_icode: current->mm must be empty.\n");
    }
    // 初始化内存管理结构（搭建用户地址空间基础
    int ret = -E_NO_MEM;
    struct mm_struct *mm;
    //(1) create a new mm for current process
    // 创建空的 mm_struct（进程内存管理核心结构体），初始化引用计数、VMA 链表等
    if ((mm = mm_create()) == NULL)
    {
        goto bad_mm;
    }
    //(2) create a new PDT, and mm->pgdir= kernel virtual addr of PDT
    // 为新地址空间创建页目录表（PDT），并将页目录表的内核虚拟地址赋值给 mm->pgdir
    if (setup_pgdir(mm) != 0)
    {
        goto bad_pgdir_cleanup_mm;
    }
    //(3) copy TEXT/DATA section, build BSS parts in binary to memory space of process
    // 解析 ELF 并加载代码段 / 数据段 / BSS 段（核心：构建用户内存空间的 VMA 和页表映射）
    struct Page *page = NULL;
    //(3.1) get the file header of the bianry program (ELF format)
    // ELF 头部校验（合法性检查
    struct elfhdr *elf = (struct elfhdr *)binary;
    //(3.2) get the entry of the program section headers of the bianry program (ELF format)
    // 遍历程序段（仅处理可加载段
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
    //(3.3) This program is valid?
    if (elf->e_magic != ELF_MAGIC)
    {
        ret = -E_INVAL_ELF;
        goto bad_elf_cleanup_pgdir;
    }
    uint32_t vm_flags, perm;
    struct proghdr *ph_end = ph + elf->e_phnum;
    for (; ph < ph_end; ph++)
    {
        //(3.4) find every program section headers
        if (ph->p_type != ELF_PT_LOAD)
        {
            continue;
        }
        if (ph->p_filesz > ph->p_memsz)
        {
            ret = -E_INVAL_ELF;
            goto bad_cleanup_mmap;
        }
        if (ph->p_filesz == 0)
        {
            // continue ;
        }
        //(3.5) call mm_map fun to setup the new vma ( ph->p_va, ph->p_memsz)
        // 配置段权限（虚拟内存属性 + 页表权限
        vm_flags = 0, perm = PTE_U | PTE_V;
        if (ph->p_flags & ELF_PF_X)
            vm_flags |= VM_EXEC; // 可执行
        if (ph->p_flags & ELF_PF_W)
            vm_flags |= VM_WRITE; // 可写
        if (ph->p_flags & ELF_PF_R)
            vm_flags |= VM_READ; // 可读
        // modify the perm bits here for RISC-V
        if (vm_flags & VM_READ)
            perm |= PTE_R; // 可读
        if (vm_flags & VM_WRITE)
            perm |= (PTE_W | PTE_R); // 可写（写权限隐含读权限
        if (vm_flags & VM_EXEC)
            perm |= PTE_X; // 可执行
        // 建立虚拟内存区域（VMA），为段分配虚拟地址空间
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
        {
            goto bad_cleanup_mmap;
        }
        // 加载代码段 / 数据段（拷贝 ELF 数据到物理页
        unsigned char *from = binary + ph->p_offset;
        size_t off, size;
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);

        ret = -E_NO_MEM;

        //(3.6) alloc memory, and  copy the contents of every program section (from, from+end) to process's memory (la, la+end)
        end = ph->p_va + ph->p_filesz;
        //(3.6.1) copy TEXT/DATA section of bianry program
        // 逐页拷贝ELF中的代码/数据到物理页
        while (start < end)
        {   // 分配物理页，并映射到虚拟地址la，设置权限perm
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
            {
                goto bad_cleanup_mmap;
            }
            off = start - la, size = PGSIZE - off, la += PGSIZE;
            if (end < la)
            {
                size -= la - end;
            }
            // 拷贝ELF数据到物理页的内核虚拟地址（page2kva转换为内核可访问地址
            memcpy(page2kva(page) + off, from, size);
            start += size, from += size;
        }
        // 初始化 BSS 段（清零
        //(3.6.2) build BSS section of binary program
        end = ph->p_va + ph->p_memsz;
        if (start < la)
        {
            /* ph->p_memsz == ph->p_filesz */
            if (start == end)
            {
                continue;
            }
            off = start + PGSIZE - la, size = PGSIZE - off;
            if (end < la)
            {
                size -= la - end;
            }
            // page is from the last allocation in the text/data copy loop
            // (the loop runs at least once when start < la). Guard to keep
            // static analyzers happy if control flow ever changes.
            if (page == NULL)
            {
                panic("load_icode: page is NULL when zeroing BSS tail");
            }
            memset(page2kva(page) + off, 0, size);
            start += size;
            assert((end < la && start == end) || (end >= la && start == la));
        }
        // 逐页分配并清零BSS段
        while (start < end)
        {
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
            {
                goto bad_cleanup_mmap;
            }
            off = start - la, size = PGSIZE - off, la += PGSIZE;
            if (end < la)
            {
                size -= la - end;
            }
            memset(page2kva(page) + off, 0, size);
            start += size;
        }
    }
    //(4) build user stack memory
    // 创建用户栈（用户态执行的栈空间
    vm_flags = VM_READ | VM_WRITE | VM_STACK;
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
    {
        goto bad_cleanup_mmap;
    }
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);

    //(5) set current process's mm, sr3, and set satp reg = physical addr of Page Directory
    // 关联内存结构到当前进程（激活地址空间）
    mm_count_inc(mm);
    current->mm = mm;
    current->pgdir = PADDR(mm->pgdir);
    lsatp(PADDR(mm->pgdir)); // 将页目录表物理地址写入satp寄存器

    //(6) setup trapframe for user environment
    // trapframe（陷阱帧）保存了进程从内核态切换到用户态的硬件上下文，是 CPU 执行sret（从异常返回）时的关键依据。
    struct trapframe *tf = current->tf;
    // Keep sstatus
    uintptr_t sstatus = tf->status;
    memset(tf, 0, sizeof(struct trapframe));
    /* LAB5:EXERCISE1 YOUR CODE
     * should set tf->gpr.sp, tf->epc, tf->status
     * NOTICE: If we set trapframe correctly, then the user level process can return to USER MODE from kernel. So
     *          tf->gpr.sp should be user stack top (the value of sp)
     *          tf->epc should be entry point of user program (the value of sepc)
     *          tf->status should be appropriate for user program (the value of sstatus)
     *          hint: check meaning of SPP, SPIE in SSTATUS, use them by SSTATUS_SPP, SSTATUS_SPIE(defined in risv.h)
     */

    // Set up user context: stack at top of user stack, entry point from ELF,
    // and drop privilege to user mode with interrupts enabled after sret.
    // 学号：2312189 姓名：查科言
    // 核心设置：配置用户态执行的关键上下文
    // (1) 设置用户栈指针（sp）：指向用户栈顶
    tf->gpr.sp = USTACKTOP;
    // (2) 设置用户态入口地址（epc）：ELF的入口地址（第一条指令地址
    tf->epc = elf->e_entry;
    // (3) 设置sstatus寄存器：配置用户态执行的权限和中断状态
    tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;

    ret = 0;
out:
    return ret;
bad_cleanup_mmap:
    exit_mmap(mm);
bad_elf_cleanup_pgdir:
    put_pgdir(mm);
bad_pgdir_cleanup_mm:
    mm_destroy(mm);
bad_mm:
    goto out;
}

// do_execve - call exit_mmap(mm)&put_pgdir(mm) to reclaim memory space of current process
//           - call load_icode to setup new memory space accroding binary prog.
// 回收当前进程旧用户地址空间 → 加载新 ELF 程序 → 错误处理
int do_execve(const char *name, size_t len, unsigned char *binary, size_t size)
{
    struct mm_struct *mm = current->mm;
    // 校验用户态传入的 name（新程序名）地址是否合法（避免用户态传递非法地址越界访问内核内存
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
    {
        return -E_INVAL;
    }
    // 截断程序名长度，防止溢出
    if (len > PROC_NAME_LEN)
    {
        len = PROC_NAME_LEN;
    }
    // 拷贝用户态传入的进程名到内核栈的 local_name，避免用户态地址后续失效导致进程名错误
    char local_name[PROC_NAME_LEN + 1];
    memset(local_name, 0, sizeof(local_name));
    memcpy(local_name, name, len);
    
    // 回收当前进程旧用户地址空间（如果存在
    if (mm != NULL)
    {
        cputs("mm != NULL");
        lsatp(boot_pgdir_pa); // 切换到内核启动页表
        if (mm_count_dec(mm) == 0)
        {
            exit_mmap(mm); // 释放虚拟内存区域（VMA）和页表
            put_pgdir(mm); // 释放页目录表物理页
            mm_destroy(mm); // 销毁mm_struct结构体
        }
        current->mm = NULL; // 清空当前进程的内存管理结构
    }
    // 加载新 ELF 程序到当前进程地址空间
    int ret;
    if ((ret = load_icode(binary, size)) != 0) // 构建新程序的代码段、数据段、BSS 段、用户栈，设置 trapframe 保证用户态执行
    {
        goto execve_exit;
    }
    set_proc_name(current, local_name); // 成功处理：设置进程名，返回 0（内核态通过寄存器将返回值传递给用户态
    return 0;

// 失败处理：调用 do_exit 终止进程，panic 确保不会执行到后续代码（加载失败后进程无法继续运行
execve_exit: 
    do_exit(ret);
    panic("already exit: %e.\n", ret);
}

// do_yield - ask the scheduler to reschedule
// 标记进程需要调度，触发调度器后续切换,主动让出CPU使用权
// 执行res:当前进程从 PROC_RUNNING 变为 PROC_RUNNABLE，调度器选择其他进程执行
int do_yield(void)
{
    current->need_resched = 1; // 标记进程需要重新调度
    return 0;
}

// do_wait - wait one OR any children with PROC_ZOMBIE state, and free memory space of kernel stack
//         - proc struct of this child.
// NOTE: only after do_wait function, all resources of the child proces are free.
// 查找僵尸态子进程 → 无则睡眠等待 → 找到则回收资源
int do_wait(int pid, int *code_store)
{
    struct mm_struct *mm = current->mm;
    if (code_store != NULL)
    {
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
        {
            return -E_INVAL;
        }
    }

    struct proc_struct *proc;
    bool intr_flag, haskid;
// 查找目标子进程
repeat:
    haskid = 0;
    if (pid != 0) // 等待指定PID子进程
    {
        proc = find_proc(pid);
        if (proc != NULL && proc->parent == current)
        {
            haskid = 1;
            if (proc->state == PROC_ZOMBIE)
            {
                goto found;
            }
        }
    }
    else // 等待任意子进程
    {
        proc = current->cptr;
        for (; proc != NULL; proc = proc->optr)
        {
            haskid = 1;
            if (proc->state == PROC_ZOMBIE)
            {
                goto found;
            }
        }
    }
    // 睡眠等待子进程退出
    if (haskid)
    {
        current->state = PROC_SLEEPING;
        current->wait_state = WT_CHILD;
        schedule(); // 让出CPU，调度其他进程运行
        if (current->flags & PF_EXITING)
        {
            do_exit(-E_KILLED);
        }
        goto repeat; // 唤醒后重新查找僵尸子进程
    }
    return -E_BAD_PROC;

// 回收僵尸子进程资源
found:
    if (proc == idleproc || proc == initproc)
    {
        panic("wait idleproc or initproc.\n");
    }
    if (code_store != NULL)
    {
        *code_store = proc->exit_code;
    }
    // // 原子化移除进程（避免中断打断)
    local_intr_save(intr_flag);
    {
        unhash_proc(proc);
        remove_links(proc);
    }
    local_intr_restore(intr_flag);
    put_kstack(proc); // 释放内核栈
    kfree(proc); // 释放PCB
    return 0;
}

// do_kill - kill process with pid by set this process's flags with PF_EXITING
// 标记进程为退出状态，触发进程退出
int do_kill(int pid)
{
    struct proc_struct *proc;
    if ((proc = find_proc(pid)) != NULL)
    {
        if (!(proc->flags & PF_EXITING))
        {
            proc->flags |= PF_EXITING; // 标记进程为退出状态
            if (proc->wait_state & WT_INTERRUPTED)
            {
                wakeup_proc(proc); // 唤醒处于可中断等待的进程，促使其尽快退出
            }
            return 0;
        }
        return -E_KILLED; // 进程已退出
    }
    return -E_INVAL; // 进程不存在
}

// kernel_execve - do SYS_exec syscall to exec a user program called by user_main kernel_thread
static int
kernel_execve(const char *name, unsigned char *binary, size_t size)
{
    int64_t ret = 0, len = strlen(name);
    //   ret = do_execve(name, len, binary, size);
    asm volatile(
        "li a0, %1\n"
        "lw a1, %2\n"
        "lw a2, %3\n"
        "lw a3, %4\n"
        "lw a4, %5\n"
        "li a7, 10\n"
        "ebreak\n"
        "sw a0, %0\n"
        : "=m"(ret)
        : "i"(SYS_exec), "m"(name), "m"(len), "m"(binary), "m"(size)
        : "memory");
    cprintf("ret = %d\n", ret);
    return ret;
}

#define __KERNEL_EXECVE(name, binary, size) ({           \
    cprintf("kernel_execve: pid = %d, name = \"%s\".\n", \
            current->pid, name);                         \
    kernel_execve(name, binary, (size_t)(size));         \
})

#define KERNEL_EXECVE(x) ({                                    \
    extern unsigned char _binary_obj___user_##x##_out_start[], \
        _binary_obj___user_##x##_out_size[];                   \
    __KERNEL_EXECVE(#x, _binary_obj___user_##x##_out_start,    \
                    _binary_obj___user_##x##_out_size);        \
})

#define __KERNEL_EXECVE2(x, xstart, xsize) ({   \
    extern unsigned char xstart[], xsize[];     \
    __KERNEL_EXECVE(#x, xstart, (size_t)xsize); \
})

#define KERNEL_EXECVE2(x, xstart, xsize) __KERNEL_EXECVE2(x, xstart, xsize)

// user_main - kernel thread used to exec a user program
static int
user_main(void *arg)
{
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
#else
    KERNEL_EXECVE(exit);
#endif
    panic("user_main execve failed.\n");
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
    size_t nr_free_pages_store = nr_free_pages();
    size_t kernel_allocated_store = kallocated();

    int pid = kernel_thread(user_main, NULL, 0);
    if (pid <= 0)
    {
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
    }

    cprintf("all user-mode processes have quit.\n");
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
    assert(nr_process == 2);
    assert(list_next(&proc_list) == &(initproc->list_link));
    assert(list_prev(&proc_list) == &(initproc->list_link));

    cprintf("init check memory pass.\n");
    return 0;
}

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
    idleproc->kstack = (uintptr_t)bootstack;
    idleproc->need_resched = 1;
    set_proc_name(idleproc, "idle");
    nr_process++;

    current = idleproc;

    int pid = kernel_thread(init_main, NULL, 0);
    if (pid <= 0)
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
    assert(initproc != NULL && initproc->pid == 1);
}

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
    while (1)
    {
        if (current->need_resched)
        {
            schedule();
        }
    }
}
