# Lab5 实验报告

<center>组员：查科言(2312189)   禹相祐(2312900)   董丰瑞(2311973) </center>

---



## 练习1：加载应用程序并执行


### do_execve 函数源码

```c
// do_execve - call exit_mmap(mm)&put_pgdir(mm) to reclaim memory space of current process
//           - call load_icode to setup new memory space accroding binary prog.
int do_execve(const char *name, size_t len, unsigned char *binary, size_t size)
{
      struct mm_struct *mm = current->mm;
      if (!user_mem_check(mm, (uintptr_t)name, len, 0))
      {
            return -E_INVAL;
      }
      if (len > PROC_NAME_LEN)
      {
            len = PROC_NAME_LEN;
      }

      char local_name[PROC_NAME_LEN + 1];
      memset(local_name, 0, sizeof(local_name));
      memcpy(local_name, name, len);

      if (mm != NULL)
      {
            cputs("mm != NULL");
            lsatp(boot_pgdir_pa);
            if (mm_count_dec(mm) == 0)
            {
                  exit_mmap(mm);
                  put_pgdir(mm);
                  mm_destroy(mm);
            }
            current->mm = NULL;
      }
      int ret;
      if ((ret = load_icode(binary, size)) != 0)
      {
            goto execve_exit;
      }
      set_proc_name(current, local_name);
      return 0;

execve_exit:
      do_exit(ret);
      panic("already exit: %e.\n", ret);
}
```

#### 设计与实现说明

1. 检查用户传入的程序名是否合法，防止非法访问。
2. 若当前进程已有内存空间（mm），则先释放原有内存空间。
3. 调用 `load_icode` 加载新的 ELF 程序，建立新的内存空间和页表。
4. 设置进程名。
5. 若加载失败则直接退出。

#### load_icode 关键步骤说明
在 `load_icode` 的第6步，设置 trapframe：

```c
struct trapframe *tf = current->tf;
uintptr_t sstatus = tf->status;
memset(tf, 0, sizeof(struct trapframe));
tf->gpr.sp = USTACKTOP;
tf->epc = elf->e_entry;
tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;
```
这样保证了新进程从用户栈顶和 ELF 入口地址开始执行，并以用户态运行。

### 练习1：用户态进程被 ucore 选择执行到第一条指令的经过

1. 进程被调度器选中，切换为 RUNNING 态。
2. 若是新进程，trapframe 已设置好入口地址和用户栈。
3. 通过 `switch_to` 切换上下文，恢复 trapframe。
4. 执行 `sret` 指令，从内核态返回用户态，CPU 跳转到 trapframe 设定的 epc（即应用程序入口）。
5. 用户程序开始执行第一条指令。

整个过程涉及：调度器选择进程、上下文切换、trapframe 恢复、sret 指令切换特权级。

---

## 练习2：父进程复制内存空间给子进程


### copy_range 函数源码

```c
/* copy_range - copy content of memory (start, end) of one process A to another
 * process B
 * @to:    the addr of process B's Page Directory
 * @from:  the addr of process A's Page Directory
 * @share: flags to indicate to dup OR share. We just use dup method, so it
 * didn't be used.
 *
 * CALL GRAPH: copy_mm-->dup_mmap-->copy_range
 */
int copy_range(pde_t *to, pde_t *from, uintptr_t start, uintptr_t end,
                     bool share)
{
      assert(start % PGSIZE == 0 && end % PGSIZE == 0);
      assert(USER_ACCESS(start, end));
      // copy content by page unit.
      do
      {
            // call get_pte to find process A's pte according to the addr start
            pte_t *ptep = get_pte(from, start, 0), *nptep;
            if (ptep == NULL)
            {
                  start = ROUNDDOWN(start + PTSIZE, PTSIZE);
                  continue;
            }
            // call get_pte to find process B's pte according to the addr start. If
            // pte is NULL, just alloc a PT
            if (*ptep & PTE_V)
            {
                  if ((nptep = get_pte(to, start, 1)) == NULL)
                  {
                        return -E_NO_MEM;
                  }
                  uint32_t perm = (*ptep & PTE_USER);
                  // get page from ptep
                  struct Page *page = pte2page(*ptep);
                  // alloc a page for process B
                  struct Page *npage = alloc_page();
                  assert(page != NULL);
                  assert(npage != NULL);
                  int ret = 0;
                  void *src_kvaddr = page2kva(page);
                  void *dst_kvaddr = page2kva(npage);
                  memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
                  ret = page_insert(to, npage, start, perm);
                  if (ret != 0)
                  {
                        free_page(npage);
                        return ret;
                  }
            }
            start += PGSIZE;
      } while (start != 0 && start < end);
      return 0;
}
```

#### 设计与实现说明

1. 遍历父进程的页表，对每个有效页：
   - 分配新物理页
   - 拷贝原页内容到新页
   - 插入到子进程页表
2. 保证了父子进程虚拟地址空间内容一致，但物理页独立。

### Copy on Write (COW) 机制设计

**概要设计：**
fork 时，父子进程页表均指向同一物理页，并将页表项权限设为只读。每个物理页维护引用计数。

**详细设计：**
1. fork 时：
   - 父子页表均指向同一物理页，PTE_W 置零（只读），物理页引用计数+1。
2. 写入时：
   - 触发缺页异常，内核分配新物理页，拷贝原内容，更新页表为可写，原页引用计数-1。
   - 这样保证写操作互不影响，节省内存。

---

## 练习3：fork/exec/wait/exit 及系统调用分析


### fork/exec/wait/exit 关键实现与分析

#### fork
1. 用户态进程发起 fork 系统调用，陷入内核。
2. 内核分配新进程结构体，调用 `copy_mm` 复制父进程内存（或实现 COW），`copy_thread` 复制上下文。
3. 设置父子关系，插入进程链表，唤醒子进程。
4. 返回子进程 pid。

#### exec
1. 用户态进程发起 exec 系统调用，陷入内核。
2. 内核回收原有内存空间，调用 `load_icode` 加载新程序，重设 trapframe。
3. 设置新进程名。
4. 返回到用户态，进程从新入口执行。

#### wait
1. 用户态进程发起 wait 系统调用，陷入内核。
2. 内核查找子进程，若有 ZOMBIE 子进程则回收资源，否则阻塞当前进程。
3. 子进程 exit 时唤醒父进程，父进程回收资源。

#### exit
1. 用户态进程发起 exit 系统调用，陷入内核。
2. 内核释放内存空间，设置状态为 ZOMBIE，唤醒父进程。
3. 调度器切换到其他进程。

### fork/exec/wait/exit 执行流程分析

- 用户态通过系统调用（ebreak）进入内核态。
- 内核完成 fork/exec/wait/exit 操作后，通过 trapframe 恢复用户态。
- 结果通过寄存器（如 a0）或内存返回。
- 用户态和内核态通过 trap/sret 指令交替切换。

### ucore 用户态进程生命周期图

```
            +----------------+
            |    start       |
            +----------------+
                  |
            alloc_proc / proc_init
                  |
            +----------------+
            | PROC_UNINIT    |
            +----------------+
                  |
            wakeup_proc / do_fork
                  |
            +----------------+
            | PROC_RUNNABLE  |<-------------------+
            +----------------+                    |
                  |                             |
            do_wait / do_sleep                    |
                  |                             |
            +----------------+                    |
            | PROC_SLEEPING  |                    |
            +----------------+                    |
                  |                             |
            wakeup_proc / schedule                |
                  |                             |
            +----------------+                    |
            | PROC_RUNNABLE  |--------------------+
            +----------------+
                  |
            do_exit |
                  |
            +----------------+
            | PROC_ZOMBIE    |
            +----------------+
                  |
            do_wait (父进程回收)
                  |
            +----------------+
            |   资源释放     |
            +----------------+
```

状态变换由如 do_fork、do_exit、wakeup_proc、schedule、do_wait 等函数驱动。

---

## 重要知识点与原理对比

| 实验知识点         | OS原理知识点         | 理解与差异说明 |
|--------------------|---------------------|---------------|
| 进程控制块（PCB）   | 进程管理             | PCB 是进程的内核抽象，保存所有上下文信息 |
| 进程调度           | 调度算法、上下文切换 | 实验实现简单轮转，原理可扩展为多级队列等 |
| 虚拟内存与页表     | 虚拟内存管理         | 实验实现基本页表映射，原理包括多级页表、TLB |
| 系统调用           | 用户态/内核态切换    | 实验用 trap 实现，原理涉及更多安全与性能机制 |
| Copy on Write      | 共享与写时复制       | 实验为基础实现，原理可扩展为更复杂的引用计数 |

有些实验知识点如 trapframe、内核栈等，在原理课本中未详细展开，但对理解内核实现至关重要。

---

## OS原理重要但实验未覆盖的知识点

- 进程间通信（IPC）机制，如信号、管道、消息队列
- 复杂调度算法（如优先级、实时调度）
- 设备管理与驱动框架
- 文件系统实现
- 多核/多处理器支持

---

## Challenge 扩展

### 1. Copy on Write (COW) 机制实现与分析

本实验进一步实现了 COW（写时复制）机制，极大提升了内存利用率。其核心思想是在 fork 时父子进程共享物理页，并将页表项权限设为只读，只有在任一进程写入该页时，才触发缺页异常，分配新物理页，实现真正的物理隔离。

#### 1.1 关键实现源码

**fork 时页表共享与只读设置：**
```c
// fork 时，父子进程页表均指向同一物理页，且只读
if (share_cow) {
      page_insert(from, page, start, perm & ~PTE_W); // 父进程页表只读
      ret = page_insert(to, page, start, perm & ~PTE_W); // 子进程页表只读
      page->ref++; // 增加引用计数
} else {
      // 原有的物理页复制逻辑
}
```

**缺页异常处理（写时复制）：**
```c
void do_page_fault(struct trapframe *tf) {
      uintptr_t addr = read_csr(stval);
      pte_t *ptep = get_pte(current->mm->pgdir, addr, 0);
      if (ptep && (*ptep & PTE_V) && !(*ptep & PTE_W)) {
            struct Page *old_page = pte2page(*ptep);
            if (old_page->ref > 1) {
                  struct Page *new_page = alloc_page();
                  memcpy(page2kva(new_page), page2kva(old_page), PGSIZE);
                  page_insert(current->mm->pgdir, new_page, ROUNDDOWN(addr, PGSIZE), PTE_USER | PTE_W);
                  old_page->ref--;
            } else {
                  *ptep |= PTE_W; // 独占后恢复可写
            }
      } else {
            // 其他异常处理
      }
}
```

**物理页引用计数：**
在 Page 结构体中增加 `ref` 字段，fork 和写时复制时维护引用计数，确保资源安全释放。

#### 1.2 COW 测试用例

```c
// 父进程写入一页，fork 后父子均读该页，子进程写该页
char *p = mmap(0, PGSIZE, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
strcpy(p, "hello");
int pid = fork();
if (pid == 0) {
      printf("child before write: %s\n", p); // 期望输出 hello
      p[0] = 'H';
      printf("child after write: %s\n", p); // 期望输出 Hello
      exit(0);
} else {
      wait(NULL);
      printf("parent after child write: %s\n", p); // 期望输出 hello
}
```

该测试用例验证了父子进程初始共享内存，子进程写入后自动分离，互不影响。

#### 1.3 COW 状态转换（有限状态自动机）

```
[共享只读] --(写访问)--> [分配新页独占可写]
   |                         ^
   |--(fork)-----------------|
```
- 初始：父子进程共享物理页，页表只读，引用计数>1。
- 任一进程写入时，触发缺页异常，分配新物理页，原页引用计数-1，页表恢复可写。
- 之后各自独占物理页，互不影响。

#### 1.4 dirtyCOW 漏洞与防范

dirtyCOW 是 Linux COW 实现中的经典竞态漏洞，攻击者可在只读映射下写入原本不可写的内存。其本质是写时复制和权限检查之间的竞态。

**在 ucore 中的防范措施：**
- 必须保证 page fault 处理和页表/引用计数修改的原子性。
- 在 do_page_fault 关键路径加锁，确保同一页的 COW 操作不会被并发打断。
- 这样可有效防止 dirtyCOW 类漏洞。

### 2. 用户程序加载时机与常见操作系统的对比

在 ucore 中，用户程序是在 do_execve/load_icode 阶段被一次性全部加载到内存的，包括所有代码段、数据段、BSS 段和用户栈。只有加载完成后，进程才进入 RUNNABLE 态等待调度。

而在常见操作系统（如 Linux/Windows）中，采用的是懒加载（Lazy Loading）机制。execve 时只加载 ELF 元数据和段表，实际的代码段、数据段内容在首次访问时才通过缺页异常从磁盘加载到内存。这种方式依赖完善的页表和缺页异常机制，能够显著节省内存和 I/O 资源。

**区别与原因总结：**
- ucore 采用一次性加载，简化了实现，适合教学和嵌入式场景。
- 常见 OS 采用懒加载，提升了资源利用率和系统性能，但实现更为复杂。
- ucore 没有实现磁盘文件系统和复杂的缺页异常处理，因此采用预加载方式。

---

# 结语

本实验通过实现进程管理、内存复制、系统调用等机制，深入理解了操作系统内核的基本原理与实现方法。