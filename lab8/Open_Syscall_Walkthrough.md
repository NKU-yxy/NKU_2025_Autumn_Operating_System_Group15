# open() 系统调用执行过程（基于你的 lab8 代码，可点击跳转）

本文把 open 的执行过程按“用户库 → syscall → sysfile → file → VFS → SFS → 磁盘设备”分层讲清楚，并给出每一步对应的源码跳转。

> 说明：本文链接都是相对于 lab8/ 目录的路径（例如 kern/...、user/...）。

---

## 0. 一句话总览（调用链）

1. 用户态 open： [user/libs/file.c#L10](user/libs/file.c#L10)
2. 用户态 sys_open（发起 SYS_open）：[user/libs/syscall.c#L105](user/libs/syscall.c#L105)
3. 内核 sys_open（syscall 分发后）：[kern/syscall/syscall.c#L91](kern/syscall/syscall.c#L91)
4. 内核 sysfile_open（拷贝路径到内核并进入 file 层）：[kern/fs/sysfile.c#L42](kern/fs/sysfile.c#L42)
5. file_open（分配 fd/file，并调用 VFS 打开 inode）：[kern/fs/file.c#L157](kern/fs/file.c#L157)
6. vfs_open（查找/创建 inode，并调用 vop_open 下发到具体 FS）：[kern/fs/vfs/vfsfile.c#L12](kern/fs/vfs/vfsfile.c#L12)
7. vfs_lookup（路径解析起点 + vop_lookup）：[kern/fs/vfs/vfslookup.c#L72](kern/fs/vfs/vfslookup.c#L72)
8. SFS 目录查找（sfs_lookup → sfs_lookup_once → dirent search → load inode）：[kern/fs/sfs/sfs_inode.c#L995](kern/fs/sfs/sfs_inode.c#L995)

---

## 1. 用户态：open 如何变成系统调用

### 1.1 open() 的用户库封装

- open 在用户库里只是薄封装：直接调用 sys_open
  - [user/libs/file.c#L10](user/libs/file.c#L10)

### 1.2 sys_open()：触发 SYS_open

- sys_open 把 SYS_open 号和参数交给通用 syscall 汇编/封装
  - [user/libs/syscall.c#L105](user/libs/syscall.c#L105)

---

## 2. 内核 syscall 分发：sys_open → sysfile_open

### 2.1 sys_open(uint64_t arg[])：从 trap 参数取出 path/open_flags

- sys_open 是内核侧的系统调用入口，它会取出用户参数并调用 sysfile_open
  - [kern/syscall/syscall.c#L91](kern/syscall/syscall.c#L91)
  - 其中调用 sysfile_open 的位置： [kern/syscall/syscall.c#L95](kern/syscall/syscall.c#L95)

### 2.2 sysfile_open：把用户态路径字符串拷贝到内核

- sysfile_open 做两件事：
  1) copy_path：把用户指针 __path 指向的字符串安全拷贝到内核缓冲 path
  2) file_open：进入“通用文件对象层”分配 fd 和 file

- 入口： [kern/fs/sysfile.c#L42](kern/fs/sysfile.c#L42)
- copy_path 实现： [kern/fs/sysfile.c#L20](kern/fs/sysfile.c#L20)

这一层的意义：
- 隔离用户态内存，内核后续处理只使用内核态字符串。

---

## 3. 通用文件对象层：file_open 做了什么

入口： [kern/fs/file.c#L157](kern/fs/file.c#L157)

file_open 的关键逻辑可以按顺序理解：

### 3.1 解析 open_flags → readable/writable

- 根据 O_RDONLY/O_WRONLY/O_RDWR 决定 file 是否可读/可写。
- 这会影响后续 read/write 系统调用的合法性检查。

### 3.2 分配一个空闲 fd / struct file

- fd_array_alloc：在当前进程的打开文件表里找空位并分配一个 struct file
  - [kern/fs/file.c#L37](kern/fs/file.c#L37)

理解要点：
- 你这份 lab8 里用的是 fd_array_* 体系（不是旧文档里说的 fs_struct->filemap[] 文字描述）。
- 分配成功后，这个 fd 就是未来返回给用户态的整数。

### 3.3 调用 vfs_open：把路径解析成 inode，并打开 inode

- vfs_open： [kern/fs/vfs/vfsfile.c#L12](kern/fs/vfs/vfsfile.c#L12)
- 如果 vfs_open 失败，需要 fd_array_free 回收： [kern/fs/file.c#L67](kern/fs/file.c#L67)

### 3.4 处理 O_APPEND：必要时把 file->pos 设置到文件末尾

- file_open 在 O_APPEND 下会调用 vop_fstat 读出文件大小
- 然后把 file->pos 设成 st_size

### 3.5 标记 file 为“已打开”，并返回 fd

- fd_array_open： [kern/fs/file.c#L94](kern/fs/file.c#L94)

---

## 4. VFS：vfs_open 如何把 open 下发到具体文件系统

入口： [kern/fs/vfs/vfsfile.c#L12](kern/fs/vfs/vfsfile.c#L12)

vfs_open 主要做两件事：

### 4.1 vfs_lookup / vop_create：拿到 inode

- 先尝试 vfs_lookup 找 inode：
  - vfs_lookup： [kern/fs/vfs/vfslookup.c#L72](kern/fs/vfs/vfslookup.c#L72)
- 如果不存在且 O_CREAT：
  - vfs_lookup_parent： [kern/fs/vfs/vfslookup.c#L92](kern/fs/vfs/vfslookup.c#L92)
  - vop_create（由具体 FS 实现创建）：宏定义见 [kern/fs/vfs/inode.h#L214](kern/fs/vfs/inode.h#L214)

### 4.2 vop_open：真正“打开文件/目录”（多态下发）

- vop_open 宏： [kern/fs/vfs/inode.h#L201](kern/fs/vfs/inode.h#L201)
- vfs_open 中调用 vop_open 成功后会：
  - vop_open_inc： [kern/fs/vfs/vfsfile.c#L56](kern/fs/vfs/vfsfile.c#L56)
  - 必要时 truncate： [kern/fs/vfs/vfsfile.c#L58](kern/fs/vfs/vfsfile.c#L58)

理解要点：
- vop_* 都是“对 inode->in_ops 里函数指针的统一转发”，具体行为由底层文件系统决定。

---

## 5. VFS 路径解析：vfs_lookup / get_device / vop_lookup

### 5.1 get_device：决定从哪个 inode 作为查找起点

入口： [kern/fs/vfs/vfslookup.c#L14](kern/fs/vfs/vfslookup.c#L14)

它根据 path 的形式选择起点：
- 形如 /path：从 bootfs 根开始
  - vfs_get_bootfs： [kern/fs/vfs/vfs.c#L80](kern/fs/vfs/vfs.c#L80)
- 形如 device:path：从 device 的根开始
  - vfs_get_root： [kern/fs/vfs/vfsdev.c#L68](kern/fs/vfs/vfsdev.c#L68)
- 相对路径（不以 / 开头）：从当前目录开始
  - vfs_get_curdir： [kern/fs/vfs/vfspath.c#L45](kern/fs/vfs/vfspath.c#L45)

### 5.2 vfs_lookup：拿到起点 inode 后调用 vop_lookup

入口： [kern/fs/vfs/vfslookup.c#L72](kern/fs/vfs/vfslookup.c#L72)

关键一步：
- vop_lookup 宏： [kern/fs/vfs/inode.h#L215](kern/fs/vfs/inode.h#L215)

这一步会进入“具体文件系统对目录的查找实现”。

---

## 6. SFS：vop_lookup 如何落到 sfs_lookup

### 6.1 inode_ops 绑定：目录 inode 的 vop_lookup = sfs_lookup

- SFS 目录操作表 sfs_node_dirops： [kern/fs/sfs/sfs_inode.c#L1016](kern/fs/sfs/sfs_inode.c#L1016)
- 其中 lookup 回调： [kern/fs/sfs/sfs_inode.c#L1026](kern/fs/sfs/sfs_inode.c#L1026)

### 6.2 sfs_lookup：在目录 inode 下查找名字对应的 inode

入口： [kern/fs/sfs/sfs_inode.c#L995](kern/fs/sfs/sfs_inode.c#L995)

这一版 lab8 的 sfs_lookup 做了简化：
- 它断言 path 不为空且不以 '/' 开头，然后直接调用一次 sfs_lookup_once
  - [kern/fs/sfs/sfs_inode.c#L499](kern/fs/sfs/sfs_inode.c#L499)

### 6.3 sfs_lookup_once：查目录项 → 得到 ino → load inode

入口： [kern/fs/sfs/sfs_inode.c#L499](kern/fs/sfs/sfs_inode.c#L499)

关键步骤：
1) sfs_dirent_search_nolock：遍历目录项，匹配 name
- [kern/fs/sfs/sfs_inode.c#L441](kern/fs/sfs/sfs_inode.c#L441)

2) 如果找到了目录项，从目录项里取到 ino（磁盘块号），再 sfs_load_inode
- [kern/fs/sfs/sfs_inode.c#L155](kern/fs/sfs/sfs_inode.c#L155)

### 6.4 sfs_load_inode：把磁盘 inode 读入内存 inode

入口： [kern/fs/sfs/sfs_inode.c#L155](kern/fs/sfs/sfs_inode.c#L155)

核心行为：
- 先查缓存/哈希表是否已有 inode（避免重复加载）
- 没有则从磁盘读出 sfs_disk_inode，并构造内存 inode，挂到链表/哈希表

---

## 7. 目录项读取最终如何访问磁盘

目录项搜索需要读目录文件内容，它最终会走到“块映射 + 读块”。典型路径如下：

- sfs_dirent_read_nolock：读目录项所在的数据块
  - [kern/fs/sfs/sfs_inode.c#L397](kern/fs/sfs/sfs_inode.c#L397)
- sfs_bmap_load_nolock：逻辑块号 → 磁盘块号
  - [kern/fs/sfs/sfs_inode.c#L353](kern/fs/sfs/sfs_inode.c#L353)
- sfs_rbuf：块内部分读
  - [kern/fs/sfs/sfs_io.c#L84](kern/fs/sfs/sfs_io.c#L84)
- sfs_rblock：整块读
  - [kern/fs/sfs/sfs_io.c#L59](kern/fs/sfs/sfs_io.c#L59)
- disk0_io：最终落到 disk0 设备 I/O
  - [kern/fs/devs/dev_disk0.c#L61](kern/fs/devs/dev_disk0.c#L61)

---

## 8. open 返回给用户态的到底是什么

- open 最终返回的是 fd（整数），对应当前进程打开文件表里的一个 struct file 槽位。
- struct file 内部保存：
  - node：VFS inode 指针（指向具体文件系统 inode）
  - pos：文件偏移
  - readable/writable：权限

这些信息由 file_open 填好后返回给 sysfile_open → sys_open → 用户态 open。
