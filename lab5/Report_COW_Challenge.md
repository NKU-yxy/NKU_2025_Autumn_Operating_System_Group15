# Copy on Write (COW) 机制实现与分析

## 一、COW 机制实现源码

### 1. fork 时页表共享与只读设置

在 `copy_range` 或 `dup_mmap` 中实现如下逻辑：

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

### 2. 缺页异常处理（写时复制）

在 page fault 处理函数中：

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

### 3. 物理页引用计数

在 Page 结构体中增加 `ref` 字段，fork 和写时复制时维护引用计数。

---

## 二、COW 测试用例

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

---

## 三、COW 状态转换（有限状态自动机）

```
[共享只读] --(写访问)--> [分配新页独占可写]
   |                         ^
   |--(fork)-----------------|
```
- 初始：父子进程共享物理页，页表只读，引用计数>1。
- 任一进程写入时，触发缺页异常，分配新物理页，原页引用计数-1，页表恢复可写。
- 之后各自独占物理页，互不影响。

---

## 四、dirtyCOW 漏洞与防范

dirtyCOW 是 Linux COW 实现中的竞态漏洞，攻击者可在只读映射下写入原本不可写的内存。

**模拟与防范：**
- 关键在于写时复制和权限检查必须原子进行。
- ucore 实现中，需加锁保护 page fault 处理和页表/引用计数修改，防止多核/多线程下的竞态。
- 可在 do_page_fault 关键路径加锁，确保同一页的 COW 操作不会被并发打断。

---

# 用户程序加载时机与常见OS对比

## 1. ucore 的加载方式
- 在 do_execve/load_icode 阶段，用户程序的所有代码段、数据段、BSS 段等全部一次性加载到内存。
- 用户栈也在此时分配。
- 加载完成后，进程才进入 RUNNABLE 态等待调度。

## 2. 常见操作系统（如 Linux/Windows）
- 采用懒加载（Lazy Loading）：execve 时只加载 ELF 元数据和段表，实际代码/数据段内容在首次访问时才通过缺页异常从磁盘加载。
- 依赖完善的页表和缺页异常机制，节省内存和 I/O。

## 3. 区别与原因
- ucore 一次性加载，简化实现，适合教学和嵌入式。
- 常见 OS 懒加载，提升资源利用率和性能，但实现复杂。
- ucore 没有实现磁盘文件系统和复杂的缺页异常处理，因此采用预加载。

---

如需进一步补充 COW 相关代码细节或测试，请告知！
