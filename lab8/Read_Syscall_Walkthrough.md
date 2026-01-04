# read 系统调用执行过程（可点击跳转，基于 lab8 代码）

本文按“用户态 → 系统调用入口 → 通用文件层（sysfile/file）→ VFS（vop_*）→ SFS → 块设备 disk0 → IDE”的顺序，解释 `read(fd, buf, len)` 如何最终变成对磁盘块的读取。

> 说明：这里假设目标文件已通过 `open()` 打开，并且 `fd` 合法。

---

## 1. 用户态封装：read → sys_read → ecall

- 用户程序调用：`read(fd, data, len)`
- 在用户库中，`read` 只是薄封装，直接转调 `sys_read`：
  - [user/libs/file.c#L20](user/libs/file.c#L20)

- `sys_read` 再封装为统一的 `syscall(SYS_read, ...)`，最终执行 `ecall` 进入内核：
  - [user/libs/syscall.c#L115](user/libs/syscall.c#L115)
  - `syscall(...)` 的通用实现（装载 a0-a5 并 `ecall`）：[user/libs/syscall.c#L12](user/libs/syscall.c#L12)

---

## 2. 内核 syscall 分发：syscall() → sys_read

- 进入内核后，统一入口在 [kern/syscall/syscall.c#L197](kern/syscall/syscall.c#L197)：
  - 从 `current->tf`（trapframe）取出 syscall 号 `num = a0`
  - 把参数从 `a1..a5` 搬到 `arg[]`
  - 调用 `syscalls[num]` 对应处理函数，并把返回值写回 `a0`

- `SYS_read` 对应 `sys_read`：
  - `syscalls[SYS_read] = sys_read` 见：[kern/syscall/syscall.c#L181](kern/syscall/syscall.c#L181)
  - `sys_read` 本身只是把参数拆出来，转交给 `sysfile_read`：
    - [kern/syscall/syscall.c#L106](kern/syscall/syscall.c#L106)

---

## 3. 通用文件访问接口层：sysfile_read

`sysfile_read` 位于 [kern/fs/sysfile.c#L61](kern/fs/sysfile.c#L61)，它做了三类事情：

1) **参数与权限检查**
- `len == 0` 直接返回 0
- `file_testfd(fd, 1, 0)` 检查：fd 是否有效、是否可读

2) **内核缓冲区分配（分块搬运）**
- 用 `kmalloc(IOBUF_SIZE)` 分配一个 4096 字节的内核 buffer：
  - `IOBUF_SIZE` 定义：[kern/fs/sysfile.c#L16](kern/fs/sysfile.c#L16)

3) **循环读取 + copy_to_user 拷回用户空间**
- 每次最多读 `IOBUF_SIZE` 字节：
  - 调用 `file_read(fd, buffer, alen, &alen)` 真正读取（`alen` 作为“期望长度”，返回后变为“实际读取长度”）
  - 若 `alen != 0`：
    - `lock_mm(mm)`
    - `copy_to_user(mm, base, buffer, alen)` 把内核 buffer 内容拷贝到用户虚拟地址 `base`
    - 更新 `base/len/copied`，继续下一轮

其中 `copy_to_user` 的安全语义在 [kern/mm/vmm.c#L257](kern/mm/vmm.c#L257)：
- 先 `user_mem_check(...)` 确认用户地址范围可写
- 再 `memcpy`

---

## 4. 文件对象层：file_read（fd → struct file → vop_read）

`file_read` 位于 [kern/fs/file.c#L209](kern/fs/file.c#L209)，关键步骤如下：

1) `fd2file(fd, &file)`：把 fd 映射到当前进程打开文件表里的 `struct file`

2) 检查可读：`file->readable`

3) `fd_array_acquire(file)`：增加引用/占用计数，避免并发关闭释放

4) 构造 iobuf：
- `iobuf_init(&__iob, base, len, file->pos)`
- `iobuf` 里携带了：缓冲区地址、剩余长度、以及文件偏移 `io_offset = file->pos`

5) 通过 VFS 虚函数派发读：
- `ret = vop_read(file->node, iob);`
- `vop_read` 宏展开见：[kern/fs/vfs/inode.h#L203](kern/fs/vfs/inode.h#L203)
  - 本质是 `file->node->in_ops->vop_read(node, iob)`

6) 更新文件偏移：
- `copied = iobuf_used(iob)`（本次实际读到的字节数）
- `file->pos += copied`

7) `fd_array_release(file)`：减少引用/占用计数

---

## 5. SFS 层：sfs_read → sfs_io → sfs_io_nolock

当文件属于 SFS 时，`vop_read` 会落到 `sfs_node_fileops.vop_read = sfs_read`：
- [kern/fs/sfs/sfs_inode.c#L1029](kern/fs/sfs/sfs_inode.c#L1029)

调用链如下：

1) `sfs_read(node, iob)`：
- [kern/fs/sfs/sfs_inode.c#L689](kern/fs/sfs/sfs_inode.c#L689)
- 直接 `return sfs_io(node, iob, 0)`（0 表示读）

2) `sfs_io(node, iob, write)`：
- [kern/fs/sfs/sfs_inode.c#L671](kern/fs/sfs/sfs_inode.c#L671)
- `lock_sin(sin)` 加 inode 锁
- 调 `sfs_io_nolock(sfs, sin, iob->io_base, iob->io_offset, &alen, write)`
- 完成后 `iobuf_skip(iob, alen)` 前移 iobuf 指针

3) `sfs_io_nolock(...)`：真正的“文件偏移 → 块号 → 磁盘读”的核心：
- [kern/fs/sfs/sfs_inode.c#L553](kern/fs/sfs/sfs_inode.c#L553)

它做了（读路径下的）关键处理：
- 越界与截断：如果 `offset >= din->size` 直接返回 0；如果 `endpos > din->size`，把 `endpos` 截到文件末尾
- 选择读操作函数：`sfs_buf_op = sfs_rbuf`、`sfs_block_op = sfs_rblock`
- 三段式读取：
  1) **首块未对齐部分**：用 `sfs_rbuf`（读一个块到内部 buffer，再 memcpy 子区间）
  2) **中间整块部分**：用 `sfs_rblock`（按整块读）
  3) **尾块未对齐部分**：用 `sfs_rbuf`
- 每次读之前用 `sfs_bmap_load_nolock` 把“文件逻辑块号 blkno”映射到“磁盘块号 ino”（SFS 的 block id）：
  - `sfs_bmap_load_nolock` 定义：[kern/fs/sfs/sfs_inode.c#L354](kern/fs/sfs/sfs_inode.c#L354)

> 注意：在读路径（`write==0`）下不会更新 `din->size`，仅写路径会根据 `startpos + alen` 扩大文件大小。

---

## 6. SFS 块 I/O：sfs_rbuf / sfs_rblock → dop_io

- `sfs_rblock`：按块读取 N 个磁盘块
  - [kern/fs/sfs/sfs_io.c#L59](kern/fs/sfs/sfs_io.c#L59)

- `sfs_rbuf`：处理“非整块/非对齐”的读取
  - [kern/fs/sfs/sfs_io.c#L84](kern/fs/sfs/sfs_io.c#L84)
  - 先 `sfs_rwblock_nolock(..., sfs->sfs_buffer, blkno, 0, ...)` 把整块读到内部 buffer
  - 再 `memcpy` 子区间到目标 `buf`

- 最底层实际发起 I/O 的位置是 `dop_io(sfs->dev, iob, write)`：
  - [kern/fs/sfs/sfs_io.c#L20](kern/fs/sfs/sfs_io.c#L20)
  - `dop_io` 是个宏：直接调用设备的 `d_io` 函数指针
    - [kern/fs/devs/dev.h#L24](kern/fs/devs/dev.h#L24)

---

## 7. disk0 设备：disk0_io → ide_read_secs

如果 `sfs->dev` 是 `disk0`，则 `dop_io` 最终进入：

- `disk0_io(struct device *dev, struct iobuf *iob, bool write)`
  - [kern/fs/devs/dev_disk0.c#L61](kern/fs/devs/dev_disk0.c#L61)

读路径（`write == 0`）下：
- 检查 offset/resid 必须按块对齐
- 计算 `blkno/nblks`
- 调 `disk0_read_blks_nolock(blkno, nblks)`：
  - [kern/fs/devs/dev_disk0.c#L41](kern/fs/devs/dev_disk0.c#L41)
- 而 `disk0_read_blks_nolock` 会调用 `ide_read_secs(...)`：
  - [kern/fs/devs/dev_disk0.c#L44](kern/fs/devs/dev_disk0.c#L44)

- `ide_read_secs` 再调用具体设备的 `read_secs` 回调（此实验环境多为 ramdisk/模拟块设备）：
  - [kern/driver/ide.c#L32](kern/driver/ide.c#L32)

---

## 8. 一句话总览（从用户到磁盘）

`read(fd, buf, len)`
→ [user/libs/file.c#L20](user/libs/file.c#L20)
→ [user/libs/syscall.c#L115](user/libs/syscall.c#L115)
→ `ecall`
→ [kern/syscall/syscall.c#L197](kern/syscall/syscall.c#L197)
→ [kern/syscall/syscall.c#L106](kern/syscall/syscall.c#L106)
→ [kern/fs/sysfile.c#L61](kern/fs/sysfile.c#L61)
→ [kern/fs/file.c#L209](kern/fs/file.c#L209)
→ [kern/fs/vfs/inode.h#L203](kern/fs/vfs/inode.h#L203)
→ [kern/fs/sfs/sfs_inode.c#L689](kern/fs/sfs/sfs_inode.c#L689)
→ [kern/fs/sfs/sfs_inode.c#L671](kern/fs/sfs/sfs_inode.c#L671)
→ [kern/fs/sfs/sfs_inode.c#L553](kern/fs/sfs/sfs_inode.c#L553)
→ [kern/fs/sfs/sfs_io.c#L84](kern/fs/sfs/sfs_io.c#L84) / [kern/fs/sfs/sfs_io.c#L59](kern/fs/sfs/sfs_io.c#L59)
→ [kern/fs/sfs/sfs_io.c#L20](kern/fs/sfs/sfs_io.c#L20)
→ [kern/fs/devs/dev_disk0.c#L61](kern/fs/devs/dev_disk0.c#L61)
→ [kern/fs/devs/dev_disk0.c#L44](kern/fs/devs/dev_disk0.c#L44)
→ [kern/driver/ide.c#L32](kern/driver/ide.c#L32)
