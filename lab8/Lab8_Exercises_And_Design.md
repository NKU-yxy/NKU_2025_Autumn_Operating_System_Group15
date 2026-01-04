# Lab8：练习实现定位 + Challenge 设计（可点击跳转）

本文档面向“对照源码理解实现”，聚焦：
- 练习1：读文件（SFS 读路径）
- 练习2：基于文件系统的执行程序（exec/ELF loader）
- Challenge1：UNIX Pipe 机制设计方案（只给接口语义与结构体，不要求实现）
- Challenge2：软/硬链接机制设计方案（只给接口语义与结构体，不要求实现）

> 跳转链接格式：`kern/.../file.c#Lx` / `user/.../file.c#Lx`（相对于本文件所在的 lab8/ 目录）。

---

## 练习1：完成读文件操作（你需要实现/理解的函数链）

### 1) 从用户态 read() 到 SFS 读取的总路径

- 用户程序调用用户库：通常在 user/libs（例如 [user/libs/file.c](user/libs/file.c)）
- 用户库触发系统调用：在 [user/libs/syscall.c](user/libs/syscall.c)
- 内核 syscall 分发（文件相关 sys_*）：[kern/syscall/syscall.c#L33](kern/syscall/syscall.c#L33)
- 进入内核文件接口 sysfile：
  - 读： [kern/fs/sysfile.c#L61](kern/fs/sysfile.c#L61)
- sysfile 再进入通用 file 层：
  - [kern/fs/file.c#L209](kern/fs/file.c#L209)
- file 层调用 inode 的 vop_read（多态下发到具体文件系统）：
  - 具体落在 SFS 的实现： [kern/fs/sfs/sfs_inode.c#L689](kern/fs/sfs/sfs_inode.c#L689)

### 2) SFS 读路径的关键函数（本练习核心）

- 入口：SFS 文件 inode 的读操作
  - [kern/fs/sfs/sfs_inode.c#L689](kern/fs/sfs/sfs_inode.c#L689)
  - 只是薄封装，转到带锁的统一读写：
    - [kern/fs/sfs/sfs_inode.c#L671](kern/fs/sfs/sfs_inode.c#L671)

- 核心：块映射 + 分段读取（本练习要求你补全/理解的主体逻辑）
  - [kern/fs/sfs/sfs_inode.c#L553](kern/fs/sfs/sfs_inode.c#L553)
  - 关键点（按逻辑顺序）：
    1. 计算 endpos，并对齐/裁剪（读不能越过 din->size）
    2. 选择读操作函数指针：`sfs_rbuf`/`sfs_rblock`
    3. 对“头部非对齐碎片 / 中间整块 / 尾部非对齐碎片”分别处理
    4. 每次读之前都要用 bmap 把“文件逻辑块号 blkno”映射成“磁盘块号 ino”

- 块号映射（逻辑块 -> 磁盘块号）
  - [kern/fs/sfs/sfs_inode.c#L354](kern/fs/sfs/sfs_inode.c#L354)
  - 该函数内部会在需要时创建新块（写路径会用到 create=1），读路径一般只是查。

- 真正执行磁盘 I/O 的底层例程
  - 整块读： [kern/fs/sfs/sfs_io.c#L59](kern/fs/sfs/sfs_io.c#L59)
  - 块内部分读： [kern/fs/sfs/sfs_io.c#L84](kern/fs/sfs/sfs_io.c#L84)

- 最终落到 disk0 设备
  - [kern/fs/devs/dev_disk0.c#L61](kern/fs/devs/dev_disk0.c#L61)

### 3) 你这份代码里我修过的一个关键 bug

- 问题：在 [kern/fs/sfs/sfs_inode.c#L553](kern/fs/sfs/sfs_inode.c#L553) 的 `out:` 结尾处，原先用“已经被推进过的 offset”再加一次 alen，可能导致文件 size 被错误放大。
- 修复：保存 `startpos`，用 `finalpos = startpos + alen` 更新 size，并且只在写操作时更新。

---

## 练习2：基于文件系统的执行程序机制（exec + ELF loader）

### 1) 从用户态执行到 do_execve 的路径

- 用户态（例如 sh）在需要启动程序时会调用 exec 系列接口（用户库通常在 user/libs）。
- syscall 分发到 exec：
  - [kern/syscall/syscall.c#L33](kern/syscall/syscall.c#L33)
  - 其中 `sys_exec` 会调用 `do_execve`。

- 关键实现：
  - `do_execve`：回收旧地址空间 + 打开可执行文件 + 调用 load_icode
    - [kern/process/proc.c#L1032](kern/process/proc.c#L1032)

### 2) “从文件系统加载 ELF 到进程地址空间”的关键函数

- 读取可执行文件内容（基于 fd）：
  - [kern/process/proc.c#L648](kern/process/proc.c#L648)
  - 实现方式：`sysfile_seek` + `sysfile_read`
    - [kern/fs/sysfile.c#L157](kern/fs/sysfile.c#L157)
    - [kern/fs/sysfile.c#L61](kern/fs/sysfile.c#L61)

- ELF 加载主逻辑：
  - [kern/process/proc.c#L665](kern/process/proc.c#L665)
  - 核心步骤（对应常见 ELF PT_LOAD 语义）：
    1. 读取 ELF Header，校验 `ELF_MAGIC`
    2. `mm_create` + `setup_pgdir` 创建新地址空间/页表
    3. 遍历 Program Header（`ELF_PT_LOAD`）：
       - `mm_map` 建立 VMA
       - `pgdir_alloc_page` 分配页
       - 从文件读 `filesz` 字节到内存，并对 `memsz-filesz` 做清零（BSS）
    4. `mm_map` 建立用户栈区，分配栈页
    5. 将 argv 字符串与 argv 指针数组写入用户栈
    6. 切换到新页表（`lsatp` + flush_tlb），设置 trapframe：`epc=e_entry, a0=argc, a1=argv`

### 3) “打开可执行文件”来自哪里

- `do_execve` 中打开文件用的是 `sysfile_open`（对 VFS 路径名）：
  - [kern/fs/sysfile.c#L42](kern/fs/sysfile.c#L42)
- sysfile_open 最终会走 VFS open：
  - [kern/fs/vfs/vfsfile.c#L12](kern/fs/vfs/vfsfile.c#L12)
- VFS 在 mount 了 disk0 的前提下，会把路径解析到 SFS inode，并通过 `vop_open/vop_read` 读取文件内容。

---

## Challenge1：UNIX Pipe 机制设计方案（概要）

目标：提供 `pipe()` 语义的“半双工字节流”，支持阻塞/唤醒、引用计数、与文件描述符表集成。

### 1) 建议新增/复用的数据结构

建议把 pipe 实现成一种“匿名文件”（像 Linux 一样把 pipe 端点当成 fd），核心是一个共享的 ring buffer。

```c
#define PIPE_BUF_DEFAULT 4096

struct pipe_buffer {
    char *buf;
    size_t cap;      // 缓冲区容量
    size_t rpos;     // 读指针
    size_t wpos;     // 写指针
    size_t size;     // 当前有效字节数
};

struct pipe_inode {
    struct pipe_buffer pb;

    int readers;     // 读端引用计数
    int writers;     // 写端引用计数

    semaphore_t mutex;      // 保护 pb/readers/writers
    wait_queue_t readq;     // 没数据时读者睡眠
    wait_queue_t writeq;    // 缓冲满时写者睡眠

    bool nonblock_read;
    bool nonblock_write;
};
```

与现有文件系统/FD 结构集成：
- 在 [kern/fs/file.h](kern/fs/file.h) / [kern/fs/file.c](kern/fs/file.c) 的“文件对象”模型里，新增一种 `inode` 类型或 `file` 类型指向 `pipe_inode`。
- 或者新增一个最小的 pseudo-fs（pipefs），其 inode_ops 只实现 read/write/close/ioctl。

### 2) 需要定义的接口（语义即可）

- 系统调用层（建议）：
  - `int sys_pipe(int pipefd[2]);`
    - 返回 `pipefd[0]` 读端，`pipefd[1]` 写端。
  - `int sys_pipe2(int pipefd[2], int flags);`
    - 支持 `O_NONBLOCK`、`O_CLOEXEC` 等。

- VFS/inode 层（建议语义）：
  - `vop_read(pipe_inode, ...)`：
    - 缓冲区为空：
      - 若仍有 writer：阻塞等待 readq；若 nonblock：返回 `-E_AGAIN`
      - 若 writers==0：返回 0（EOF）
  - `vop_write(pipe_inode, ...)`：
    - 缓冲区满：
      - 若 readers>0：阻塞等待 writeq；若 nonblock：返回 `-E_AGAIN`
      - 若 readers==0：返回 `-E_PIPE`（或对应错误）
  - `vop_close`：更新 readers/writers，必要时唤醒对端。

### 3) 同步互斥要点

- 互斥：对 ring buffer 的所有读写指针修改必须在 `mutex` 下。
- 条件同步：
  - 写入后 `wakeup(readq)`；读取后 `wakeup(writeq)`。
  - close 导致 readers/writers 归零时必须唤醒所有睡眠者避免永久阻塞。
- 原子性：可以定义“写入不超过 PIPE_BUF 的一段数据是原子的”（可选），超过则允许分片。

---

## Challenge2：UNIX 软连接/硬连接机制设计方案（概要）

### 1) 硬链接（hard link）

核心：目录项新增一个“指向已有 inode 的 entry”，并增加 inode 的 `nlinks`。

你当前的 SFS inode 已经有 `nlinks` 字段（可在 [kern/fs/sfs/sfs_inode.c](kern/fs/sfs/sfs_inode.c) 中看到多处 `din->nlinks` 的使用），因此硬链接主要缺：
- VFS 层的 `link/unlink` 接口
- sysfile/syscall 的 `sys_link/sys_unlink`
- SFS 层实现：新增/复用“在目录中新建一个 dirent 指向目标 ino”的逻辑，以及 unlink 时 `nlinks--`，为 0 时回收数据块。

建议接口语义：
- `int sys_link(const char *oldpath, const char *newpath);`
  - 增加 oldpath 对应 inode 的链接计数；在 newpath 的父目录中新建目录项。
- `int sys_unlink(const char *path);`
  - 删除目录项并 `nlinks--`；若 `nlinks==0` 且无打开引用，则释放 inode 和数据块。

建议新增 VFS API（示意）：
```c
int vfs_link(char *oldpath, char *newpath);
int vfs_unlink(char *path);
```

### 2) 软链接（symlink）

核心：软链接是一个“内容为目标路径字符串”的特殊 inode。

SFS 已有 `SFS_TYPE_LINK`（见 [kern/fs/sfs/sfs_inode.c](kern/fs/sfs/sfs_inode.c) 的 `sfs_get_ops` 分发逻辑），因此可以设计：
- symlink inode 的数据区存放目标路径（NUL 结尾）
- `readlink` 读取该路径字符串
- 路径解析（lookup）时若遇到 link：
  - 若是 open/exec 等“跟随链接”的操作，则把 link 内容当作新路径继续解析（限制最大跳转次数防环）

建议接口语义：
- `int sys_symlink(const char *target, const char *linkpath);`
  - 创建一个 `SFS_TYPE_LINK` inode，把 target 写入其文件内容。
- `ssize_t sys_readlink(const char *path, char *buf, size_t bufsz);`
  - 不跟随链接，直接返回链接内容。

建议新增 VFS API（示意）：
```c
int vfs_symlink(char *target, char *linkpath);
int vfs_readlink(char *path, struct iobuf *iob);
```

### 3) 同步互斥要点

- 目录与 inode 元数据修改必须持锁：
  - 目录项增删、`nlinks` 修改、truncate/free blocks 都需要互斥。
- 避免死锁：规定锁顺序，例如“先锁父目录 inode，再锁目标 inode”。
- 防止 symlink 环：在路径解析时维护跳转计数（例如 8/16 次），超过返回 `-E_LOOP`。

---

## 本文档与自动索引文档的关系

- 全量“按文件逐函数索引”在 [FS_Documentation.md](FS_Documentation.md)。
- 本文档是按题目（练习/挑战）把关键函数串起来，方便你写实验报告的“实现说明/调用链”。
