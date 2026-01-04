Wrote: /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab8/FS_Documentation.md
/gen_fs_doc.py` 自动生成：
- 目标：覆盖本次实验涉及的文件，并为每个函数提供跳转链接与说明（优先复用源码注释）。
- 跳转格式：`path/to/file.c#L123`（在 VS Code / GitHub Markdown 中可点击）。

## 0. 总体调用链（从 user 到磁盘）
- user 测试用例通过 `user/libs/syscall.c` 发起系统调用（open/read/write/getdirentry 等）。
- 内核在 `kern/syscall/syscall.c` 分发到对应 `sys_*` 实现，文件相关通常进入 `kern/fs/sysfile.c`。
- `kern/fs/sysfile.c` 调用 VFS 接口（如 `vfs_open/vfs_read/vfs_write/vfs_getdirentry/...`）。
- VFS 在 `kern/fs/vfs/*` 中完成路径解析、inode/文件对象管理，并通过 inode 的 `inode_ops` 下发到具体文件系统（SFS）。
- SFS 在 `kern/fs/sfs/*` 中实现 inode/目录项/块映射与实际 I/O；最终通过 `kern/fs/devs/dev_disk0.c` 等把请求落到磁盘设备。

## 1. 文件与函数索引
### kern/fs
- **kern/fs/devs/dev.c**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。
- **kern/fs/devs/dev.h**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。
- **kern/fs/devs/dev_disk0.c**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。
- **kern/fs/devs/dev_stdin.c**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。
- **kern/fs/devs/dev_stdout.c**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。
- **kern/fs/file.c**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/file.h**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/fs.c**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/fs.h**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/iobuf.c**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/iobuf.h**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/sfs/bitmap.c**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/sfs/bitmap.h**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/sfs/sfs.c**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/sfs/sfs.h**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/sfs/sfs_fs.c**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/sfs/sfs_inode.c**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/sfs/sfs_io.c**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/sfs/sfs_lock.c**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。
- **kern/fs/swap/swapfs.c**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/swap/swapfs.h**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/sysfile.c**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/sysfile.h**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。
- **kern/fs/vfs/inode.c**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。
- **kern/fs/vfs/inode.h**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。
- **kern/fs/vfs/vfs.c**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。
- **kern/fs/vfs/vfs.h**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。
- **kern/fs/vfs/vfsdev.c**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。
- **kern/fs/vfs/vfsfile.c**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。
- **kern/fs/vfs/vfslookup.c**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。
- **kern/fs/vfs/vfspath.c**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

### kern/init
- **kern/init/init.c**：内核初始化：包含文件系统初始化调用。

### kern/process
- **kern/process/proc.c**：进程结构扩展与文件系统状态（fs_struct）相关支持。
- **kern/process/proc.h**：进程结构扩展与文件系统状态（fs_struct）相关支持。

### kern/syscall
- **kern/syscall/syscall.c**：内核系统调用分发与文件系统相关 syscall 入口。
- **kern/syscall/syscall.h**：内核系统调用分发与文件系统相关 syscall 入口。

### tools/mksfs.c
- **tools/mksfs.c**：辅助工具：构造 SFS 磁盘镜像（理解布局/元数据很有帮助）。

### user/badarg.c
- **user/badarg.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/badsegment.c
- **user/badsegment.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/divzero.c
- **user/divzero.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/exit.c
- **user/exit.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/faultread.c
- **user/faultread.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/faultreadkernel.c
- **user/faultreadkernel.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/forktest.c
- **user/forktest.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/forktree.c
- **user/forktree.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/hello.c
- **user/hello.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/libs
- **user/libs/dir.c**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/file.c**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/panic.c**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/stdio.c**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/syscall.c**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/ulib.c**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/umain.c**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/dir.h**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/file.h**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/lock.h**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/syscall.h**：用户态文件/目录/系统调用封装库，用于测试用例调用。
- **user/libs/ulib.h**：用户态文件/目录/系统调用封装库，用于测试用例调用。

### user/matrix.c
- **user/matrix.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/pgdir.c
- **user/pgdir.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/priority.c
- **user/priority.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/sh.c
- **user/sh.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/sleep.c
- **user/sleep.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/sleepkill.c
- **user/sleepkill.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/softint.c
- **user/softint.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/spin.c
- **user/spin.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/testbss.c
- **user/testbss.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/waitkill.c
- **user/waitkill.c**：用户态测试用例（包含文件系统相关测试与 shell）。

### user/yield.c
- **user/yield.c**：用户态测试用例（包含文件系统相关测试与 shell）。

## 2. 按文件逐函数说明
### user/badarg.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [badarg.c#L4](user/badarg.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/badarg.c#L4)

```c
int main(void)
```

</details>

### user/badsegment.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [badsegment.c#L6](user/badsegment.c#L6) | /* try to load the kernel's TSS selector into the DS register */<br><br><b>中文解释</b><br>main：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/badsegment.c#L6)

```c
int main(void)
```

</details>

### user/divzero.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [divzero.c#L6](user/divzero.c#L6) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/divzero.c#L6)

```c
int main(void)
```

</details>

### user/exit.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [exit.c#L6](user/exit.c#L6) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/exit.c#L6)

```c
int main(void)
```

</details>

### user/faultread.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [faultread.c#L4](user/faultread.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/faultread.c#L4)

```c
int main(void)
```

</details>

### user/faultreadkernel.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [faultreadkernel.c#L4](user/faultreadkernel.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/faultreadkernel.c#L4)

```c
int main(void)
```

</details>

### user/forktest.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [forktest.c#L6](user/forktest.c#L6) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/forktest.c#L6)

```c
int main(void)
```

</details>

### user/forktree.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `forkchild` | [forktree.c#L9](user/forktree.c#L9) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `forktree` | [forktree.c#L24](user/forktree.c#L24) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `main` | [forktree.c#L32](user/forktree.c#L32) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [forkchild](user/forktree.c#L9)

```c
void forkchild(const char *cur, char branch)
```

- [forktree](user/forktree.c#L24)

```c
void forktree(const char *cur)
```

- [main](user/forktree.c#L32)

```c
int main(void)
```

</details>

### user/hello.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [hello.c#L4](user/hello.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/hello.c#L4)

```c
int main(void)
```

</details>

### user/libs/dir.c
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `opendir` | [dir.c#L12](user/libs/dir.c#L12) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `readdir` | [dir.c#L29](user/libs/dir.c#L29) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `closedir` | [dir.c#L37](user/libs/dir.c#L37) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `getcwd` | [dir.c#L42](user/libs/dir.c#L42) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [opendir](user/libs/dir.c#L12)

```c
DIR * opendir(const char *path)
```

- [readdir](user/libs/dir.c#L29)

```c
struct dirent * readdir(DIR *dirp)
```

- [closedir](user/libs/dir.c#L37)

```c
void closedir(DIR *dirp)
```

- [getcwd](user/libs/dir.c#L42)

```c
int getcwd(char *buffer, size_t len)
```

</details>

### user/libs/file.c
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `open` | [file.c#L9](user/libs/file.c#L9) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `close` | [file.c#L14](user/libs/file.c#L14) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `read` | [file.c#L19](user/libs/file.c#L19) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `write` | [file.c#L24](user/libs/file.c#L24) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `seek` | [file.c#L29](user/libs/file.c#L29) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `fstat` | [file.c#L34](user/libs/file.c#L34) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `fsync` | [file.c#L39](user/libs/file.c#L39) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `dup2` | [file.c#L44](user/libs/file.c#L44) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `transmode` | [file.c#L49](user/libs/file.c#L49) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `print_stat` | [file.c#L60](user/libs/file.c#L60) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [open](user/libs/file.c#L9)

```c
int open(const char *path, uint32_t open_flags)
```

- [close](user/libs/file.c#L14)

```c
int close(int fd)
```

- [read](user/libs/file.c#L19)

```c
int read(int fd, void *base, size_t len)
```

- [write](user/libs/file.c#L24)

```c
int write(int fd, void *base, size_t len)
```

- [seek](user/libs/file.c#L29)

```c
int seek(int fd, off_t pos, int whence)
```

- [fstat](user/libs/file.c#L34)

```c
int fstat(int fd, struct stat *stat)
```

- [fsync](user/libs/file.c#L39)

```c
int fsync(int fd)
```

- [dup2](user/libs/file.c#L44)

```c
int dup2(int fd1, int fd2)
```

- [transmode](user/libs/file.c#L49)

```c
static char transmode(struct stat *stat)
```

- [print_stat](user/libs/file.c#L60)

```c
void print_stat(const char *name, int fd, struct stat *stat)
```

</details>

### user/libs/panic.c
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `__panic` | [panic.c#L7](user/libs/panic.c#L7) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `__warn` | [panic.c#L19](user/libs/panic.c#L19) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [__panic](user/libs/panic.c#L7)

```c
void __panic(const char *file, int line, const char *fmt, ...)
```

- [__warn](user/libs/panic.c#L19)

```c
void __warn(const char *file, int line, const char *fmt, ...)
```

</details>

### user/libs/stdio.c
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `cputch` | [stdio.c#L12](user/libs/stdio.c#L12) | /* *<br> * cputch - writes a single character @c to stdout, and it will<br> * increace the value of counter pointed by @cnt.<br> * */<br><br><b>中文解释</b><br>cputch：向标准输出写入一个字符，并更新计数器（用于统计输出字符数）。 |
| `vcprintf` | [stdio.c#L27](user/libs/stdio.c#L27) | /* *<br> * vcprintf - format a string and writes it to stdout<br> *<br> * The return value is the number of characters which would be<br> * written to stdout.<br> *<br> * Call this function if you are already dealing with a va_list.<br> * Or you probably want cprintf() instead.<br> * */<br><br><b>中文解释</b><br>vcprintf：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `cprintf` | [stdio.c#L40](user/libs/stdio.c#L40) | /* *<br> * cprintf - formats a string and writes it to stdout<br> *<br> * The return value is the number of characters which would be<br> * written to stdout.<br> * */<br><br><b>中文解释</b><br>cprintf：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `cputs` | [stdio.c#L55](user/libs/stdio.c#L55) | /* *<br> * cputs- writes the string pointed by @str to stdout and<br> * appends a newline character.<br> * */<br><br><b>中文解释</b><br>cputs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fputch` | [stdio.c#L67](user/libs/stdio.c#L67) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `vfprintf` | [stdio.c#L73](user/libs/stdio.c#L73) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `fprintf` | [stdio.c#L80](user/libs/stdio.c#L80) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [cputch](user/libs/stdio.c#L12)

```c
static void cputch(int c, int *cnt)
```

- [vcprintf](user/libs/stdio.c#L27)

```c
int vcprintf(const char *fmt, va_list ap)
```

- [cprintf](user/libs/stdio.c#L40)

```c
int cprintf(const char *fmt, ...)
```

- [cputs](user/libs/stdio.c#L55)

```c
int cputs(const char *str)
```

- [fputch](user/libs/stdio.c#L67)

```c
static void fputch(char c, int *cnt, int fd)
```

- [vfprintf](user/libs/stdio.c#L73)

```c
int vfprintf(int fd, const char *fmt, va_list ap)
```

- [fprintf](user/libs/stdio.c#L80)

```c
int fprintf(int fd, const char *fmt, ...)
```

</details>

### user/libs/syscall.c
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `syscall` | [syscall.c#L11](user/libs/syscall.c#L11) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_exit` | [syscall.c#L43](user/libs/syscall.c#L43) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_fork` | [syscall.c#L48](user/libs/syscall.c#L48) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_wait` | [syscall.c#L53](user/libs/syscall.c#L53) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_yield` | [syscall.c#L58](user/libs/syscall.c#L58) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_kill` | [syscall.c#L63](user/libs/syscall.c#L63) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_getpid` | [syscall.c#L68](user/libs/syscall.c#L68) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_putc` | [syscall.c#L73](user/libs/syscall.c#L73) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_pgdir` | [syscall.c#L78](user/libs/syscall.c#L78) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_lab6_set_priority` | [syscall.c#L83](user/libs/syscall.c#L83) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_sleep` | [syscall.c#L89](user/libs/syscall.c#L89) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_gettime` | [syscall.c#L94](user/libs/syscall.c#L94) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_exec` | [syscall.c#L99](user/libs/syscall.c#L99) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_open` | [syscall.c#L104](user/libs/syscall.c#L104) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_close` | [syscall.c#L109](user/libs/syscall.c#L109) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_read` | [syscall.c#L114](user/libs/syscall.c#L114) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_write` | [syscall.c#L119](user/libs/syscall.c#L119) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_seek` | [syscall.c#L124](user/libs/syscall.c#L124) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_fstat` | [syscall.c#L129](user/libs/syscall.c#L129) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_fsync` | [syscall.c#L134](user/libs/syscall.c#L134) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_getcwd` | [syscall.c#L139](user/libs/syscall.c#L139) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_getdirentry` | [syscall.c#L144](user/libs/syscall.c#L144) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_dup` | [syscall.c#L149](user/libs/syscall.c#L149) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [syscall](user/libs/syscall.c#L11)

```c
static inline int syscall(uint64_t num, ...)
```

- [sys_exit](user/libs/syscall.c#L43)

```c
int sys_exit(int64_t error_code)
```

- [sys_fork](user/libs/syscall.c#L48)

```c
int sys_fork(void)
```

- [sys_wait](user/libs/syscall.c#L53)

```c
int sys_wait(int64_t pid, int64_t *store)
```

- [sys_yield](user/libs/syscall.c#L58)

```c
int sys_yield(void)
```

- [sys_kill](user/libs/syscall.c#L63)

```c
int sys_kill(int64_t pid)
```

- [sys_getpid](user/libs/syscall.c#L68)

```c
int sys_getpid(void)
```

- [sys_putc](user/libs/syscall.c#L73)

```c
int sys_putc(int64_t c)
```

- [sys_pgdir](user/libs/syscall.c#L78)

```c
int sys_pgdir(void)
```

- [sys_lab6_set_priority](user/libs/syscall.c#L83)

```c
void sys_lab6_set_priority(uint64_t priority)
```

- [sys_sleep](user/libs/syscall.c#L89)

```c
int sys_sleep(int64_t time)
```

- [sys_gettime](user/libs/syscall.c#L94)

```c
int sys_gettime(void)
```

- [sys_exec](user/libs/syscall.c#L99)

```c
int sys_exec(const char *name, int64_t argc, const char **argv)
```

- [sys_open](user/libs/syscall.c#L104)

```c
int sys_open(const char *path, uint64_t open_flags)
```

- [sys_close](user/libs/syscall.c#L109)

```c
int sys_close(int64_t fd)
```

- [sys_read](user/libs/syscall.c#L114)

```c
int sys_read(int64_t fd, void *base, size_t len)
```

- [sys_write](user/libs/syscall.c#L119)

```c
int sys_write(int64_t fd, void *base, size_t len)
```

- [sys_seek](user/libs/syscall.c#L124)

```c
int sys_seek(int64_t fd, off_t pos, int64_t whence)
```

- [sys_fstat](user/libs/syscall.c#L129)

```c
int sys_fstat(int64_t fd, struct stat *stat)
```

- [sys_fsync](user/libs/syscall.c#L134)

```c
int sys_fsync(int64_t fd)
```

- [sys_getcwd](user/libs/syscall.c#L139)

```c
int sys_getcwd(char *buffer, size_t len)
```

- [sys_getdirentry](user/libs/syscall.c#L144)

```c
int sys_getdirentry(int64_t fd, struct dirent *dirent)
```

- [sys_dup](user/libs/syscall.c#L149)

```c
int sys_dup(int64_t fd1, int64_t fd2)
```

</details>

### user/libs/ulib.c
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `exit` | [ulib.c#L7](user/libs/ulib.c#L7) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `fork` | [ulib.c#L14](user/libs/ulib.c#L14) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `wait` | [ulib.c#L19](user/libs/ulib.c#L19) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `waitpid` | [ulib.c#L24](user/libs/ulib.c#L24) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `yield` | [ulib.c#L29](user/libs/ulib.c#L29) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `kill` | [ulib.c#L34](user/libs/ulib.c#L34) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `getpid` | [ulib.c#L39](user/libs/ulib.c#L39) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `print_pgdir` | [ulib.c#L45](user/libs/ulib.c#L45) | //print_pgdir - print the PDT&PT<br><br><b>中文解释</b><br>print_pgdir：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `gettime_msec` | [ulib.c#L50](user/libs/ulib.c#L50) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `lab6_set_priority` | [ulib.c#L55](user/libs/ulib.c#L55) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sleep` | [ulib.c#L61](user/libs/ulib.c#L61) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `__exec` | [ulib.c#L65](user/libs/ulib.c#L65) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [exit](user/libs/ulib.c#L7)

```c
void exit(int error_code)
```

- [fork](user/libs/ulib.c#L14)

```c
int fork(void)
```

- [wait](user/libs/ulib.c#L19)

```c
int wait(void)
```

- [waitpid](user/libs/ulib.c#L24)

```c
int waitpid(int pid, int *store)
```

- [yield](user/libs/ulib.c#L29)

```c
void yield(void)
```

- [kill](user/libs/ulib.c#L34)

```c
int kill(int pid)
```

- [getpid](user/libs/ulib.c#L39)

```c
int getpid(void)
```

- [print_pgdir](user/libs/ulib.c#L45)

```c
void print_pgdir(void)
```

- [gettime_msec](user/libs/ulib.c#L50)

```c
unsigned int gettime_msec(void)
```

- [lab6_set_priority](user/libs/ulib.c#L55)

```c
void lab6_set_priority(uint32_t priority)
```

- [sleep](user/libs/ulib.c#L61)

```c
int sleep(unsigned int time)
```

- [__exec](user/libs/ulib.c#L65)

```c
int __exec(const char *name, const char **argv)
```

</details>

### user/libs/umain.c
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `initfd` | [umain.c#L8](user/libs/umain.c#L8) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `umain` | [umain.c#L22](user/libs/umain.c#L22) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [initfd](user/libs/umain.c#L8)

```c
static int initfd(int fd2, const char *path, uint32_t open_flags)
```

- [umain](user/libs/umain.c#L22)

```c
void umain(int argc, char *argv[])
```

</details>

### user/matrix.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `work` | [matrix.c#L12](user/matrix.c#L12) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `main` | [matrix.c#L46](user/matrix.c#L46) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [work](user/matrix.c#L12)

```c
void work(unsigned int times)
```

- [main](user/matrix.c#L46)

```c
int main(void)
```

</details>

### user/pgdir.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [pgdir.c#L4](user/pgdir.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/pgdir.c#L4)

```c
int main(void)
```

</details>

### user/priority.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `spin_delay` | [priority.c#L13](user/priority.c#L13) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `main` | [priority.c#L24](user/priority.c#L24) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [spin_delay](user/priority.c#L13)

```c
static void spin_delay(void)
```

- [main](user/priority.c#L24)

```c
int main(void)
```

</details>

### user/sh.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `gettoken` | [sh.c#L18](user/sh.c#L18) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `readline` | [sh.c#L49](user/sh.c#L49) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `usage` | [sh.c#L89](user/sh.c#L89) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `reopen` | [sh.c#L94](user/sh.c#L94) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `testfile` | [sh.c#L106](user/sh.c#L106) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `runcmd` | [sh.c#L116](user/sh.c#L116) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `main` | [sh.c#L217](user/sh.c#L217) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [gettoken](user/sh.c#L18)

```c
int gettoken(char **p1, char **p2)
```

- [readline](user/sh.c#L49)

```c
char * readline(const char *prompt)
```

- [usage](user/sh.c#L89)

```c
void usage(void)
```

- [reopen](user/sh.c#L94)

```c
int reopen(int fd2, const char *filename, uint32_t open_flags)
```

- [testfile](user/sh.c#L106)

```c
int testfile(const char *name)
```

- [runcmd](user/sh.c#L116)

```c
int runcmd(char *cmd)
```

- [main](user/sh.c#L217)

```c
int main(int argc, char **argv)
```

</details>

### user/sleep.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `sleepy` | [sleep.c#L4](user/sleep.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `main` | [sleep.c#L14](user/sleep.c#L14) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [sleepy](user/sleep.c#L4)

```c
void sleepy(int pid)
```

- [main](user/sleep.c#L14)

```c
int main(void)
```

</details>

### user/sleepkill.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [sleepkill.c#L4](user/sleepkill.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/sleepkill.c#L4)

```c
int main(void)
```

</details>

### user/softint.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [softint.c#L4](user/softint.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/softint.c#L4)

```c
int main(void)
```

</details>

### user/spin.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [spin.c#L4](user/spin.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/spin.c#L4)

```c
int main(void)
```

</details>

### user/testbss.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [testbss.c#L8](user/testbss.c#L8) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/testbss.c#L8)

```c
int main(void)
```

</details>

### user/waitkill.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `do_yield` | [waitkill.c#L4](user/waitkill.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `loop` | [waitkill.c#L16](user/waitkill.c#L16) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `work` | [waitkill.c#L22](user/waitkill.c#L22) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `main` | [waitkill.c#L37](user/waitkill.c#L37) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [do_yield](user/waitkill.c#L4)

```c
void do_yield(void)
```

- [loop](user/waitkill.c#L16)

```c
void loop(void)
```

- [work](user/waitkill.c#L22)

```c
void work(void)
```

- [main](user/waitkill.c#L37)

```c
int main(void)
```

</details>

### user/yield.c
**文件作用**：用户态测试用例（包含文件系统相关测试与 shell）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `main` | [yield.c#L4](user/yield.c#L4) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [main](user/yield.c#L4)

```c
int main(void)
```

</details>

### user/libs/dir.h
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### user/libs/file.h
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### user/libs/lock.h
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `lock_init` | [lock.h#L12](user/libs/lock.h#L12) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `try_lock` | [lock.h#L17](user/libs/lock.h#L17) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `lock` | [lock.h#L22](user/libs/lock.h#L22) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `unlock` | [lock.h#L36](user/libs/lock.h#L36) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [lock_init](user/libs/lock.h#L12)

```c
static inline void lock_init(lock_t *l)
```

- [try_lock](user/libs/lock.h#L17)

```c
static inline bool try_lock(lock_t *l)
```

- [lock](user/libs/lock.h#L22)

```c
static inline void lock(lock_t *l)
```

- [unlock](user/libs/lock.h#L36)

```c
static inline void unlock(lock_t *l)
```

</details>

### user/libs/syscall.h
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### user/libs/ulib.h
**文件作用**：用户态文件/目录/系统调用封装库，用于测试用例调用。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/devs/dev.c
**文件作用**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `dev_open` | [dev.c#L12](kern/fs/devs/dev.c#L12) | /*<br> * dev_open - Called for each open().<br> */<br><br><b>中文解释</b><br>dev_open：每次调用 open() 时都会触发该函数。 |
| `dev_close` | [dev.c#L24](kern/fs/devs/dev.c#L24) | /*<br> * dev_close - Called on the last close(). Just pass through.<br> */<br><br><b>中文解释</b><br>dev_close：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `dev_read` | [dev.c#L33](kern/fs/devs/dev.c#L33) | /*<br> * dev_read -Called for read. Hand off to iobuf.<br> */<br><br><b>中文解释</b><br>dev_read：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `dev_write` | [dev.c#L42](kern/fs/devs/dev.c#L42) | /*<br> * dev_write -Called for write. Hand off to iobuf.<br> */<br><br><b>中文解释</b><br>dev_write：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：可能触发分配新块/更新 size，写入后设置 dirty 以便 fsync 落盘。 |
| `dev_ioctl` | [dev.c#L51](kern/fs/devs/dev.c#L51) | /*<br> * dev_ioctl - Called for ioctl(). Just pass through.<br> */<br><br><b>中文解释</b><br>dev_ioctl：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `dev_fstat` | [dev.c#L62](kern/fs/devs/dev.c#L62) | /*<br> * dev_fstat - Called for stat().<br> *             Set the type and the size (block devices only).<br> *             The link count for a device is always 1.<br> */<br><br><b>中文解释</b><br>dev_fstat：处理 stat()：填充/返回文件(或设备)的属性信息。<br>设置类型与大小（仅块设备有意义）。<br>设备的链接计数恒为 1（设备节点不参与普通文件的多链接语义）。 |
| `dev_gettype` | [dev.c#L81](kern/fs/devs/dev.c#L81) | /*<br> * dev_gettype - Return the type. A device is a "block device" if it has a known<br> *               length. A device that generates data in a stream is a "character<br> *               device".<br> */<br><br><b>中文解释</b><br>dev_gettype：返回对象类型（例如块设备/字符设备/普通文件等）。<br>如果设备长度已知，则可视为‘块设备’（支持按块随机访问）。<br>如果设备以数据流方式产生数据，则可视为‘字符设备’（通常不支持随机访问）。 |
| `dev_tryseek` | [dev.c#L93](kern/fs/devs/dev.c#L93) | /*<br> * dev_tryseek - Attempt a seek.<br> *               For block devices, require block alignment.<br> *               For character devices, prohibit seeking entirely.<br> */<br><br><b>中文解释</b><br>dev_tryseek：尝试执行 seek：把文件偏移移动到指定位置（可能受对齐/设备类型限制）。<br>对块设备：要求按块对齐（避免半块 seek/IO）。<br>对字符设备：完全禁止 seek（流式设备不支持随机访问）。 |
| `dev_lookup` | [dev.c#L118](kern/fs/devs/dev.c#L118) | /*<br> * dev_lookup - Name lookup.<br> *<br> * One interesting feature of device:name pathname syntax is that you<br> * can implement pathnames on arbitrary devices. For instance, if you<br> * had a graphics device that supported multiple resolutions (which we<br> * don't), you might arrange things so that you could open it with<br> * pathnames like "video:800x600/24bpp" in order to select the operating<br> * mode.<br> *<br> * However, we have no support for this in the base system.<br> */<br><br><b>中文解释</b><br>dev_lookup：该注释说明 device:name 这类路径语法：理论上可以把路径名解析委托给特定设备，从而在设备内部实现“子路径”。但基础实现不支持这种扩展，因此这里只做最基本的名称查找/透传。<br>逻辑要点：在目录项/索引节点结构中按名称/路径进行查找，成功则返回对应 inode。 |
| `dev_init` | [dev.c#L151](kern/fs/devs/dev.c#L151) | /* dev_init - Initialization functions for builtin vfs-level devices. */<br><br><b>中文解释</b><br>dev_init：初始化内建的 VFS 级设备。 |
| `dev_create_inode` | [dev.c#L159](kern/fs/devs/dev.c#L159) | /* dev_create_inode - Create inode for a vfs-level device. */<br><br><b>中文解释</b><br>dev_create_inode：为 VFS 级设备创建对应的 inode。 |

<details><summary>函数签名（展开查看）</summary>

- [dev_open](kern/fs/devs/dev.c#L12)

```c
static int dev_open(struct inode *node, uint32_t open_flags)
```

- [dev_close](kern/fs/devs/dev.c#L24)

```c
static int dev_close(struct inode *node)
```

- [dev_read](kern/fs/devs/dev.c#L33)

```c
static int dev_read(struct inode *node, struct iobuf *iob)
```

- [dev_write](kern/fs/devs/dev.c#L42)

```c
static int dev_write(struct inode *node, struct iobuf *iob)
```

- [dev_ioctl](kern/fs/devs/dev.c#L51)

```c
static int dev_ioctl(struct inode *node, int op, void *data)
```

- [dev_fstat](kern/fs/devs/dev.c#L62)

```c
static int dev_fstat(struct inode *node, struct stat *stat)
```

- [dev_gettype](kern/fs/devs/dev.c#L81)

```c
static int dev_gettype(struct inode *node, uint32_t *type_store)
```

- [dev_tryseek](kern/fs/devs/dev.c#L93)

```c
static int dev_tryseek(struct inode *node, off_t pos)
```

- [dev_lookup](kern/fs/devs/dev.c#L118)

```c
static int dev_lookup(struct inode *node, char *path, struct inode **node_store)
```

- [dev_init](kern/fs/devs/dev.c#L151)

```c
void dev_init(void)
```

- [dev_create_inode](kern/fs/devs/dev.c#L159)

```c
struct inode * dev_create_inode(void)
```

</details>

### kern/fs/devs/dev.h
**文件作用**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/devs/dev_disk0.c
**文件作用**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `lock_disk0` | [dev_disk0.c#L20](kern/fs/devs/dev_disk0.c#L20) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `unlock_disk0` | [dev_disk0.c#L25](kern/fs/devs/dev_disk0.c#L25) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `disk0_open` | [dev_disk0.c#L30](kern/fs/devs/dev_disk0.c#L30) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `disk0_close` | [dev_disk0.c#L35](kern/fs/devs/dev_disk0.c#L35) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `disk0_read_blks_nolock` | [dev_disk0.c#L40](kern/fs/devs/dev_disk0.c#L40) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `disk0_write_blks_nolock` | [dev_disk0.c#L50](kern/fs/devs/dev_disk0.c#L50) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `disk0_io` | [dev_disk0.c#L60](kern/fs/devs/dev_disk0.c#L60) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `disk0_ioctl` | [dev_disk0.c#L106](kern/fs/devs/dev_disk0.c#L106) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `disk0_device_init` | [dev_disk0.c#L111](kern/fs/devs/dev_disk0.c#L111) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `dev_init_disk0` | [dev_disk0.c#L131](kern/fs/devs/dev_disk0.c#L131) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [lock_disk0](kern/fs/devs/dev_disk0.c#L20)

```c
static void lock_disk0(void)
```

- [unlock_disk0](kern/fs/devs/dev_disk0.c#L25)

```c
static void unlock_disk0(void)
```

- [disk0_open](kern/fs/devs/dev_disk0.c#L30)

```c
static int disk0_open(struct device *dev, uint32_t open_flags)
```

- [disk0_close](kern/fs/devs/dev_disk0.c#L35)

```c
static int disk0_close(struct device *dev)
```

- [disk0_read_blks_nolock](kern/fs/devs/dev_disk0.c#L40)

```c
static void disk0_read_blks_nolock(uint32_t blkno, uint32_t nblks)
```

- [disk0_write_blks_nolock](kern/fs/devs/dev_disk0.c#L50)

```c
static void disk0_write_blks_nolock(uint32_t blkno, uint32_t nblks)
```

- [disk0_io](kern/fs/devs/dev_disk0.c#L60)

```c
static int disk0_io(struct device *dev, struct iobuf *iob, bool write)
```

- [disk0_ioctl](kern/fs/devs/dev_disk0.c#L106)

```c
static int disk0_ioctl(struct device *dev, int op, void *data)
```

- [disk0_device_init](kern/fs/devs/dev_disk0.c#L111)

```c
static void disk0_device_init(struct device *dev)
```

- [dev_init_disk0](kern/fs/devs/dev_disk0.c#L131)

```c
void dev_init_disk0(void)
```

</details>

### kern/fs/devs/dev_stdin.c
**文件作用**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `dev_stdin_write` | [dev_stdin.c#L21](kern/fs/devs/dev_stdin.c#L21) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `dev_stdin_read` | [dev_stdin.c#L39](kern/fs/devs/dev_stdin.c#L39) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdin_open` | [dev_stdin.c#L70](kern/fs/devs/dev_stdin.c#L70) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdin_close` | [dev_stdin.c#L78](kern/fs/devs/dev_stdin.c#L78) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdin_io` | [dev_stdin.c#L83](kern/fs/devs/dev_stdin.c#L83) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdin_ioctl` | [dev_stdin.c#L95](kern/fs/devs/dev_stdin.c#L95) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdin_device_init` | [dev_stdin.c#L100](kern/fs/devs/dev_stdin.c#L100) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `dev_init_stdin` | [dev_stdin.c#L113](kern/fs/devs/dev_stdin.c#L113) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [dev_stdin_write](kern/fs/devs/dev_stdin.c#L21)

```c
void dev_stdin_write(char c)
```

- [dev_stdin_read](kern/fs/devs/dev_stdin.c#L39)

```c
static int dev_stdin_read(char *buf, size_t len)
```

- [stdin_open](kern/fs/devs/dev_stdin.c#L70)

```c
static int stdin_open(struct device *dev, uint32_t open_flags)
```

- [stdin_close](kern/fs/devs/dev_stdin.c#L78)

```c
static int stdin_close(struct device *dev)
```

- [stdin_io](kern/fs/devs/dev_stdin.c#L83)

```c
static int stdin_io(struct device *dev, struct iobuf *iob, bool write)
```

- [stdin_ioctl](kern/fs/devs/dev_stdin.c#L95)

```c
static int stdin_ioctl(struct device *dev, int op, void *data)
```

- [stdin_device_init](kern/fs/devs/dev_stdin.c#L100)

```c
static void stdin_device_init(struct device *dev)
```

- [dev_init_stdin](kern/fs/devs/dev_stdin.c#L113)

```c
void dev_init_stdin(void)
```

</details>

### kern/fs/devs/dev_stdout.c
**文件作用**：文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `stdout_open` | [dev_stdout.c#L11](kern/fs/devs/dev_stdout.c#L11) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdout_close` | [dev_stdout.c#L19](kern/fs/devs/dev_stdout.c#L19) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdout_io` | [dev_stdout.c#L24](kern/fs/devs/dev_stdout.c#L24) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdout_ioctl` | [dev_stdout.c#L36](kern/fs/devs/dev_stdout.c#L36) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `stdout_device_init` | [dev_stdout.c#L41](kern/fs/devs/dev_stdout.c#L41) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `dev_init_stdout` | [dev_stdout.c#L51](kern/fs/devs/dev_stdout.c#L51) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [stdout_open](kern/fs/devs/dev_stdout.c#L11)

```c
static int stdout_open(struct device *dev, uint32_t open_flags)
```

- [stdout_close](kern/fs/devs/dev_stdout.c#L19)

```c
static int stdout_close(struct device *dev)
```

- [stdout_io](kern/fs/devs/dev_stdout.c#L24)

```c
static int stdout_io(struct device *dev, struct iobuf *iob, bool write)
```

- [stdout_ioctl](kern/fs/devs/dev_stdout.c#L36)

```c
static int stdout_ioctl(struct device *dev, int op, void *data)
```

- [stdout_device_init](kern/fs/devs/dev_stdout.c#L41)

```c
static void stdout_device_init(struct device *dev)
```

- [dev_init_stdout](kern/fs/devs/dev_stdout.c#L51)

```c
void dev_init_stdout(void)
```

</details>

### kern/fs/file.c
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `get_fd_array` | [file.c#L17](kern/fs/file.c#L17) | // get_fd_array - get current process's open files table<br><br><b>中文解释</b><br>get_fd_array：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fd_array_init` | [file.c#L25](kern/fs/file.c#L25) | // fd_array_init - initialize the open files table<br><br><b>中文解释</b><br>fd_array_init：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fd_array_alloc` | [file.c#L36](kern/fs/file.c#L36) | // fs_array_alloc - allocate a free file item (with FD_NONE status) in open files table<br><br><b>中文解释</b><br>fd_array_alloc：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：从空闲资源集合（如位图/缓存）选择一个可用项并标记为已占用。 |
| `fd_array_free` | [file.c#L66](kern/fs/file.c#L66) | // fd_array_free - free a file item in open files table<br><br><b>中文解释</b><br>fd_array_free：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：将资源标记为可复用，并更新计数/元数据。 |
| `fd_array_acquire` | [file.c#L76](kern/fs/file.c#L76) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `fd_array_release` | [file.c#L83](kern/fs/file.c#L83) | // fd_array_release - file's open_count--; if file's open_count-- == 0 , then call fd_array_free to free this file item<br><br><b>中文解释</b><br>fd_array_release：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fd_array_open` | [file.c#L93](kern/fs/file.c#L93) | // fd_array_open - file's open_count++, set status to FD_OPENED<br><br><b>中文解释</b><br>fd_array_open：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fd_array_close` | [file.c#L101](kern/fs/file.c#L101) | // fd_array_close - file's open_count--; if file's open_count-- == 0 , then call fd_array_free to free this file item<br><br><b>中文解释</b><br>fd_array_close：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fd_array_dup` | [file.c#L112](kern/fs/file.c#L112) | //fs_array_dup - duplicate file 'from'  to file 'to'<br><br><b>中文解释</b><br>fd_array_dup：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fd2file` | [file.c#L126](kern/fs/file.c#L126) | // fd2file - use fd as index of fd_array, return the array item (file)<br><br><b>中文解释</b><br>fd2file：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_testfd` | [file.c#L139](kern/fs/file.c#L139) | // file_testfd - test file is readble or writable?<br><br><b>中文解释</b><br>file_testfd：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_open` | [file.c#L156](kern/fs/file.c#L156) | // open file<br><br><b>中文解释</b><br>file_open：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_close` | [file.c#L196](kern/fs/file.c#L196) | // close file<br><br><b>中文解释</b><br>file_close：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_read` | [file.c#L208](kern/fs/file.c#L208) | // read file<br><br><b>中文解释</b><br>file_read：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `file_write` | [file.c#L234](kern/fs/file.c#L234) | // write file<br><br><b>中文解释</b><br>file_write：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：可能触发分配新块/更新 size，写入后设置 dirty 以便 fsync 落盘。 |
| `file_seek` | [file.c#L260](kern/fs/file.c#L260) | // seek file<br><br><b>中文解释</b><br>file_seek：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_fstat` | [file.c#L292](kern/fs/file.c#L292) | // stat file<br><br><b>中文解释</b><br>file_fstat：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_fsync` | [file.c#L306](kern/fs/file.c#L306) | // sync file<br><br><b>中文解释</b><br>file_fsync：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_getdirentry` | [file.c#L320](kern/fs/file.c#L320) | // get file entry in DIR<br><br><b>中文解释</b><br>file_getdirentry：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `file_dup` | [file.c#L338](kern/fs/file.c#L338) | // duplicate file<br><br><b>中文解释</b><br>file_dup：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [get_fd_array](kern/fs/file.c#L17)

```c
static struct file * get_fd_array(void)
```

- [fd_array_init](kern/fs/file.c#L25)

```c
void fd_array_init(struct file *fd_array)
```

- [fd_array_alloc](kern/fs/file.c#L36)

```c
static int fd_array_alloc(int fd, struct file **file_store)
```

- [fd_array_free](kern/fs/file.c#L66)

```c
static void fd_array_free(struct file *file)
```

- [fd_array_acquire](kern/fs/file.c#L76)

```c
static void fd_array_acquire(struct file *file)
```

- [fd_array_release](kern/fs/file.c#L83)

```c
static void fd_array_release(struct file *file)
```

- [fd_array_open](kern/fs/file.c#L93)

```c
void fd_array_open(struct file *file)
```

- [fd_array_close](kern/fs/file.c#L101)

```c
void fd_array_close(struct file *file)
```

- [fd_array_dup](kern/fs/file.c#L112)

```c
void fd_array_dup(struct file *to, struct file *from)
```

- [fd2file](kern/fs/file.c#L126)

```c
static inline int fd2file(int fd, struct file **file_store)
```

- [file_testfd](kern/fs/file.c#L139)

```c
bool file_testfd(int fd, bool readable, bool writable)
```

- [file_open](kern/fs/file.c#L156)

```c
int file_open(char *path, uint32_t open_flags)
```

- [file_close](kern/fs/file.c#L196)

```c
int file_close(int fd)
```

- [file_read](kern/fs/file.c#L208)

```c
int file_read(int fd, void *base, size_t len, size_t *copied_store)
```

- [file_write](kern/fs/file.c#L234)

```c
int file_write(int fd, void *base, size_t len, size_t *copied_store)
```

- [file_seek](kern/fs/file.c#L260)

```c
int file_seek(int fd, off_t pos, int whence)
```

- [file_fstat](kern/fs/file.c#L292)

```c
int file_fstat(int fd, struct stat *stat)
```

- [file_fsync](kern/fs/file.c#L306)

```c
int file_fsync(int fd)
```

- [file_getdirentry](kern/fs/file.c#L320)

```c
int file_getdirentry(int fd, struct dirent *direntp)
```

- [file_dup](kern/fs/file.c#L338)

```c
int file_dup(int fd1, int fd2)
```

</details>

### kern/fs/file.h
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `fopen_count` | [file.h#L44](kern/fs/file.h#L44) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `fopen_count_inc` | [file.h#L49](kern/fs/file.h#L49) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `fopen_count_dec` | [file.h#L55](kern/fs/file.h#L55) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [fopen_count](kern/fs/file.h#L44)

```c
static inline int fopen_count(struct file *file)
```

- [fopen_count_inc](kern/fs/file.h#L49)

```c
static inline int fopen_count_inc(struct file *file)
```

- [fopen_count_dec](kern/fs/file.h#L55)

```c
static inline int fopen_count_dec(struct file *file)
```

</details>

### kern/fs/fs.c
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `fs_init` | [fs.c#L11](kern/fs/fs.c#L11) | //called when init_main proc start<br><br><b>中文解释</b><br>fs_init：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `fs_cleanup` | [fs.c#L18](kern/fs/fs.c#L18) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `lock_files` | [fs.c#L23](kern/fs/fs.c#L23) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `unlock_files` | [fs.c#L28](kern/fs/fs.c#L28) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `files_create` | [fs.c#L33](kern/fs/fs.c#L33) | //Called when a new proc init<br><br><b>中文解释</b><br>files_create：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `files_destroy` | [fs.c#L48](kern/fs/fs.c#L48) | //Called when a proc exit<br><br><b>中文解释</b><br>files_destroy：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `files_closeall` | [fs.c#L66](kern/fs/fs.c#L66) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `dup_files` | [fs.c#L80](kern/fs/fs.c#L80) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [fs_init](kern/fs/fs.c#L11)

```c
void fs_init(void)
```

- [fs_cleanup](kern/fs/fs.c#L18)

```c
void fs_cleanup(void)
```

- [lock_files](kern/fs/fs.c#L23)

```c
void lock_files(struct files_struct *filesp)
```

- [unlock_files](kern/fs/fs.c#L28)

```c
void unlock_files(struct files_struct *filesp)
```

- [files_create](kern/fs/fs.c#L33)

```c
struct files_struct * files_create(void)
```

- [files_destroy](kern/fs/fs.c#L48)

```c
void files_destroy(struct files_struct *filesp)
```

- [files_closeall](kern/fs/fs.c#L66)

```c
void files_closeall(struct files_struct *filesp)
```

- [dup_files](kern/fs/fs.c#L80)

```c
int dup_files(struct files_struct *to, struct files_struct *from)
```

</details>

### kern/fs/fs.h
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `files_count` | [fs.h#L43](kern/fs/fs.h#L43) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `files_count_inc` | [fs.h#L48](kern/fs/fs.h#L48) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `files_count_dec` | [fs.h#L54](kern/fs/fs.h#L54) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [files_count](kern/fs/fs.h#L43)

```c
static inline int files_count(struct files_struct *filesp)
```

- [files_count_inc](kern/fs/fs.h#L48)

```c
static inline int files_count_inc(struct files_struct *filesp)
```

- [files_count_dec](kern/fs/fs.h#L54)

```c
static inline int files_count_dec(struct files_struct *filesp)
```

</details>

### kern/fs/iobuf.c
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `iobuf_init` | [iobuf.c#L13](kern/fs/iobuf.c#L13) | /* <br> * iobuf_init - init io buffer struct.<br> *                set up io_base to point to the buffer you want to transfer to, and set io_len to the length of buffer;<br> *                initialize io_offset as desired;<br> *                initialize io_resid to the total amount of data that can be transferred through this io.<br> */<br><br><b>中文解释</b><br>iobuf_init：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `iobuf_move` | [iobuf.c#L28](kern/fs/iobuf.c#L28) | /* iobuf_move - move data  (iob->io_base ---> data OR  data --> iob->io.base) in memory<br> * @copiedp:  the size of data memcopied<br> *<br> * iobuf_move may be called repeatedly on the same io to transfer<br> * additional data until the available buffer space the io refers to<br> * is exhausted.<br> */<br><br><b>中文解释</b><br>iobuf_move：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `iobuf_move_zeros` | [iobuf.c#L53](kern/fs/iobuf.c#L53) | /*<br> * iobuf_move_zeros - set io buffer zero<br> * @copiedp:  the size of data memcopied<br> */<br><br><b>中文解释</b><br>iobuf_move_zeros：（该句为实现细节/定义说明，建议结合源码阅读。）<br>参数 copiedp：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。 |
| `iobuf_skip` | [iobuf.c#L72](kern/fs/iobuf.c#L72) | /*<br> * iobuf_skip - change the current position of io buffer<br> */<br><br><b>中文解释</b><br>iobuf_skip：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [iobuf_init](kern/fs/iobuf.c#L13)

```c
struct iobuf * iobuf_init(struct iobuf *iob, void *base, size_t len, off_t offset)
```

- [iobuf_move](kern/fs/iobuf.c#L28)

```c
int iobuf_move(struct iobuf *iob, void *data, size_t len, bool m2b, size_t *copiedp)
```

- [iobuf_move_zeros](kern/fs/iobuf.c#L53)

```c
int iobuf_move_zeros(struct iobuf *iob, size_t len, size_t *copiedp)
```

- [iobuf_skip](kern/fs/iobuf.c#L72)

```c
void iobuf_skip(struct iobuf *iob, size_t n)
```

</details>

### kern/fs/iobuf.h
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/sfs/bitmap.c
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `bitmap_create` | [bitmap.c#L18](kern/fs/sfs/bitmap.c#L18) | // bitmap_create - allocate a new bitmap object.<br><br><b>中文解释</b><br>bitmap_create：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `bitmap_alloc` | [bitmap.c#L53](kern/fs/sfs/bitmap.c#L53) | // bitmap_alloc - locate a cleared bit, set it, and return its index.<br><br><b>中文解释</b><br>bitmap_alloc：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：从空闲资源集合（如位图/缓存）选择一个可用项并标记为已占用。 |
| `bitmap_translate` | [bitmap.c#L74](kern/fs/sfs/bitmap.c#L74) | // bitmap_translate - according index, get the related word and mask<br><br><b>中文解释</b><br>bitmap_translate：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `bitmap_test` | [bitmap.c#L83](kern/fs/sfs/bitmap.c#L83) | // bitmap_test - according index, get the related value (0 OR 1) in the bitmap<br><br><b>中文解释</b><br>bitmap_test：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `bitmap_free` | [bitmap.c#L91](kern/fs/sfs/bitmap.c#L91) | // bitmap_free - according index, set related bit to 1<br><br><b>中文解释</b><br>bitmap_free：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：将资源标记为可复用，并更新计数/元数据。 |
| `bitmap_destroy` | [bitmap.c#L100](kern/fs/sfs/bitmap.c#L100) | // bitmap_destroy - free memory contains bitmap<br><br><b>中文解释</b><br>bitmap_destroy：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `bitmap_getdata` | [bitmap.c#L107](kern/fs/sfs/bitmap.c#L107) | // bitmap_getdata - return bitmap->map, return the length of bits to len_store<br><br><b>中文解释</b><br>bitmap_getdata：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [bitmap_create](kern/fs/sfs/bitmap.c#L18)

```c
struct bitmap * bitmap_create(uint32_t nbits)
```

- [bitmap_alloc](kern/fs/sfs/bitmap.c#L53)

```c
int bitmap_alloc(struct bitmap *bitmap, uint32_t *index_store)
```

- [bitmap_translate](kern/fs/sfs/bitmap.c#L74)

```c
static void bitmap_translate(struct bitmap *bitmap, uint32_t index, WORD_TYPE **word, WORD_TYPE *mask)
```

- [bitmap_test](kern/fs/sfs/bitmap.c#L83)

```c
bool bitmap_test(struct bitmap *bitmap, uint32_t index)
```

- [bitmap_free](kern/fs/sfs/bitmap.c#L91)

```c
void bitmap_free(struct bitmap *bitmap, uint32_t index)
```

- [bitmap_destroy](kern/fs/sfs/bitmap.c#L100)

```c
void bitmap_destroy(struct bitmap *bitmap)
```

- [bitmap_getdata](kern/fs/sfs/bitmap.c#L107)

```c
void * bitmap_getdata(struct bitmap *bitmap, size_t *len_store)
```

</details>

### kern/fs/sfs/bitmap.h
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/sfs/sfs.c
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `sfs_init` | [sfs.c#L12](kern/fs/sfs/sfs.c#L12) | /*<br> * sfs_init - mount sfs on disk0<br> *<br> * CALL GRAPH:<br> *   kern_init-->fs_init-->sfs_init<br> */<br><br><b>中文解释</b><br>sfs_init：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [sfs_init](kern/fs/sfs/sfs.c#L12)

```c
void sfs_init(void)
```

</details>

### kern/fs/sfs/sfs.h
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/sfs/sfs_fs.c
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `sfs_sync` | [sfs_fs.c#L19](kern/fs/sfs/sfs_fs.c#L19) | /*<br> * sfs_sync - sync sfs's superblock and freemap in memroy into disk<br> */<br><br><b>中文解释</b><br>sfs_sync：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_get_root` | [sfs_fs.c#L50](kern/fs/sfs/sfs_fs.c#L50) | /*<br> * sfs_get_root - get the root directory inode  from disk (SFS_BLKN_ROOT,1)<br> */<br><br><b>中文解释</b><br>sfs_get_root：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_unmount` | [sfs_fs.c#L63](kern/fs/sfs/sfs_fs.c#L63) | /*<br> * sfs_unmount - unmount sfs, and free the memorys contain sfs->freemap/sfs_buffer/hash_liskt and sfs itself.<br> */<br><br><b>中文解释</b><br>sfs_unmount：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_cleanup` | [sfs_fs.c#L82](kern/fs/sfs/sfs_fs.c#L82) | /*<br> * sfs_cleanup - when sfs failed, then should call this function to sync sfs by calling sfs_sync<br> *<br> * NOTICE: nouse now.<br> */<br><br><b>中文解释</b><br>sfs_cleanup：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_init_read` | [sfs_fs.c#L109](kern/fs/sfs/sfs_fs.c#L109) | /*<br> * sfs_init_read - used in sfs_do_mount to read disk block(blkno, 1) directly.<br> *<br> * @dev:        the block device<br> * @blkno:      the NO. of disk block<br> * @blk_buffer: the buffer used for read<br> *<br> *      (1) init iobuf<br> *      (2) read dev into iobuf<br> */<br><br><b>中文解释</b><br>sfs_init_read：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。）<br>参数 dev：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 blkno：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 blk_buffer：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `sfs_init_freemap` | [sfs_fs.c#L127](kern/fs/sfs/sfs_fs.c#L127) | /*<br> * sfs_init_freemap - used in sfs_do_mount to read freemap data info in disk block(blkno, nblks) directly.<br> *<br> * @dev:        the block device<br> * @bitmap:     the bitmap in memroy<br> * @blkno:      the NO. of disk block<br> * @nblks:      Rd number of disk block<br> * @blk_buffer: the buffer used for read<br> *<br> *      (1) get data addr in bitmap<br> *      (2) read dev into iobuf<br> */<br><br><b>中文解释</b><br>sfs_init_freemap：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。<br>逻辑要点：将资源标记为可复用，并更新计数/元数据。 |
| `sfs_do_mount` | [sfs_fs.c#L148](kern/fs/sfs/sfs_fs.c#L148) | /*<br> * sfs_do_mount - mount sfs file system.<br> *<br> * @dev:        the block device contains sfs file system<br> * @fs_store:   the fs struct in memroy<br> */<br><br><b>中文解释</b><br>sfs_do_mount：（该句为实现细节/定义说明，建议结合源码阅读。）<br>参数 dev：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 fs_store：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。 |
| `sfs_mount` | [sfs_fs.c#L254](kern/fs/sfs/sfs_fs.c#L254) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [sfs_sync](kern/fs/sfs/sfs_fs.c#L19)

```c
static int sfs_sync(struct fs *fs)
```

- [sfs_get_root](kern/fs/sfs/sfs_fs.c#L50)

```c
static struct inode * sfs_get_root(struct fs *fs)
```

- [sfs_unmount](kern/fs/sfs/sfs_fs.c#L63)

```c
static int sfs_unmount(struct fs *fs)
```

- [sfs_cleanup](kern/fs/sfs/sfs_fs.c#L82)

```c
static void sfs_cleanup(struct fs *fs)
```

- [sfs_init_read](kern/fs/sfs/sfs_fs.c#L109)

```c
static int sfs_init_read(struct device *dev, uint32_t blkno, void *blk_buffer)
```

- [sfs_init_freemap](kern/fs/sfs/sfs_fs.c#L127)

```c
static int sfs_init_freemap(struct device *dev, struct bitmap *freemap, uint32_t blkno, uint32_t nblks, void *blk_buffer)
```

- [sfs_do_mount](kern/fs/sfs/sfs_fs.c#L148)

```c
static int sfs_do_mount(struct device *dev, struct fs **fs_store)
```

- [sfs_mount](kern/fs/sfs/sfs_fs.c#L254)

```c
int sfs_mount(const char *devname)
```

</details>

### kern/fs/sfs/sfs_inode.c
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `lock_sin` | [sfs_inode.c#L22](kern/fs/sfs/sfs_inode.c#L22) | /*<br> * lock_sin - lock the process of inode Rd/Wr<br> */<br><br><b>中文解释</b><br>lock_sin：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `unlock_sin` | [sfs_inode.c#L30](kern/fs/sfs/sfs_inode.c#L30) | /*<br> * unlock_sin - unlock the process of inode Rd/Wr<br> */<br><br><b>中文解释</b><br>unlock_sin：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_get_ops` | [sfs_inode.c#L38](kern/fs/sfs/sfs_inode.c#L38) | /*<br> * sfs_get_ops - return function addr of fs_node_dirops/sfs_node_fileops<br> */<br><br><b>中文解释</b><br>sfs_get_ops：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_hash_list` | [sfs_inode.c#L52](kern/fs/sfs/sfs_inode.c#L52) | /*<br> * sfs_hash_list - return inode entry in sfs->hash_list<br> */<br><br><b>中文解释</b><br>sfs_hash_list：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_set_links` | [sfs_inode.c#L60](kern/fs/sfs/sfs_inode.c#L60) | /*<br> * sfs_set_links - link inode sin in sfs->linked-list AND sfs->hash_link<br> */<br><br><b>中文解释</b><br>sfs_set_links：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_remove_links` | [sfs_inode.c#L69](kern/fs/sfs/sfs_inode.c#L69) | /*<br> * sfs_remove_links - unlink inode sin in sfs->linked-list AND sfs->hash_link<br> */<br><br><b>中文解释</b><br>sfs_remove_links：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_block_inuse` | [sfs_inode.c#L78](kern/fs/sfs/sfs_inode.c#L78) | /*<br> * sfs_block_inuse - check the inode with NO. ino inuse info in bitmap<br> */<br><br><b>中文解释</b><br>sfs_block_inuse：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_block_alloc` | [sfs_inode.c#L89](kern/fs/sfs/sfs_inode.c#L89) | /*<br> * sfs_block_alloc -  check and get a free disk block<br> */<br><br><b>中文解释</b><br>sfs_block_alloc：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：从空闲资源集合（如位图/缓存）选择一个可用项并标记为已占用。 |
| `sfs_block_free` | [sfs_inode.c#L104](kern/fs/sfs/sfs_inode.c#L104) | /*<br> * sfs_block_free - set related bits for ino block to 1(means free) in bitmap, add sfs->super.unused_blocks, set superblock dirty *<br> */<br><br><b>中文解释</b><br>sfs_block_free：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：将资源标记为可复用，并更新计数/元数据。 |
| `sfs_create_inode` | [sfs_inode.c#L114](kern/fs/sfs/sfs_inode.c#L114) | /*<br> * sfs_create_inode - alloc a inode in memroy, and init din/ino/dirty/reclian_count/sem fields in sfs_inode in inode<br> */<br><br><b>中文解释</b><br>sfs_create_inode：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `lookup_sfs_nolock` | [sfs_inode.c#L133](kern/fs/sfs/sfs_inode.c#L133) | /*<br> * lookup_sfs_nolock - according ino, find related inode<br> *<br> * NOTICE: le2sin, info2node MACRO<br> */<br><br><b>中文解释</b><br>lookup_sfs_nolock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：在目录项/索引节点结构中按名称/路径进行查找，成功则返回对应 inode。 |
| `sfs_load_inode` | [sfs_inode.c#L154](kern/fs/sfs/sfs_inode.c#L154) | /*<br> * sfs_load_inode - If the inode isn't existed, load inode related ino disk block data into a new created inode.<br> *                  If the inode is in memory alreadily, then do nothing<br> */<br><br><b>中文解释</b><br>sfs_load_inode：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_bmap_get_sub_nolock` | [sfs_inode.c#L200](kern/fs/sfs/sfs_inode.c#L200) | /*<br> * sfs_bmap_get_sub_nolock - according entry pointer entp and index, find the index of indrect disk block<br> *                           return the index of indrect disk block to ino_store. no lock protect<br> * @sfs:      sfs file system<br> * @entp:     the pointer of index of entry disk block<br> * @index:    the index of block in indrect block<br> * @create:   BOOL, if the block isn't allocated, if create = 1 the alloc a block,  otherwise just do nothing<br> * @ino_store: 0 OR the index of already inused block or new allocated block.<br> */<br><br><b>中文解释</b><br>sfs_bmap_get_sub_nolock：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。<br>逻辑要点：把文件的逻辑块号映射到磁盘块号，必要时分配间接块/数据块。 |
| `sfs_bmap_get_nolock` | [sfs_inode.c#L256](kern/fs/sfs/sfs_inode.c#L256) | /*<br> * sfs_bmap_get_nolock - according sfs_inode and index of block, find the NO. of disk block<br> *                       no lock protect<br> * @sfs:      sfs file system<br> * @sin:      sfs inode in memory<br> * @index:    the index of block in inode<br> * @create:   BOOL, if the block isn't allocated, if create = 1 the alloc a block,  otherwise just do nothing<br> * @ino_store: 0 OR the index of already inused block or new allocated block.<br> */<br><br><b>中文解释</b><br>sfs_bmap_get_nolock：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。<br>逻辑要点：把文件的逻辑块号映射到磁盘块号，必要时分配间接块/数据块。 |
| `sfs_bmap_free_sub_nolock` | [sfs_inode.c#L297](kern/fs/sfs/sfs_inode.c#L297) | /*<br> * sfs_bmap_free_sub_nolock - set the entry item to 0 (free) in the indirect block<br> */<br><br><b>中文解释</b><br>sfs_bmap_free_sub_nolock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：将资源标记为可复用，并更新计数/元数据。 |
| `sfs_bmap_free_nolock` | [sfs_inode.c#L318](kern/fs/sfs/sfs_inode.c#L318) | /*<br> * sfs_bmap_free_nolock - free a block with logical index in inode and reset the inode's fields<br> */<br><br><b>中文解释</b><br>sfs_bmap_free_nolock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：将资源标记为可复用，并更新计数/元数据。 |
| `sfs_bmap_load_nolock` | [sfs_inode.c#L353](kern/fs/sfs/sfs_inode.c#L353) | /*<br> * sfs_bmap_load_nolock - according to the DIR's inode and the logical index of block in inode, find the NO. of disk block.<br> * @sfs:      sfs file system<br> * @sin:      sfs inode in memory<br> * @index:    the logical index of disk block in inode<br> * @ino_store:the NO. of disk block<br> */<br><br><b>中文解释</b><br>sfs_bmap_load_nolock：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。<br>逻辑要点：把文件的逻辑块号映射到磁盘块号，必要时分配间接块/数据块。 |
| `sfs_bmap_truncate_nolock` | [sfs_inode.c#L376](kern/fs/sfs/sfs_inode.c#L376) | /*<br> * sfs_bmap_truncate_nolock - free the disk block at the end of file<br> */<br><br><b>中文解释</b><br>sfs_bmap_truncate_nolock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：把文件的逻辑块号映射到磁盘块号，必要时分配间接块/数据块。 |
| `sfs_dirent_read_nolock` | [sfs_inode.c#L396](kern/fs/sfs/sfs_inode.c#L396) | /*<br> * sfs_dirent_read_nolock - read the file entry from disk block which contains this entry<br> * @sfs:      sfs file system<br> * @sin:      sfs inode in memory<br> * @slot:     the index of file entry<br> * @entry:    file entry<br> */<br><br><b>中文解释</b><br>sfs_dirent_read_nolock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>参数 sfs：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 sin：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 slot：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 entry：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `sfs_dirent_search_nolock` | [sfs_inode.c#L440](kern/fs/sfs/sfs_inode.c#L440) | /*<br> * sfs_dirent_search_nolock - read every file entry in the DIR, compare file name with each entry->name<br> *                            If equal, then return slot and NO. of disk of this file's inode<br> * @sfs:        sfs file system<br> * @sin:        sfs inode in memory<br> * @name:       the filename<br> * @ino_store:  NO. of disk of this file (with the filename)'s inode<br> * @slot:       logical index of file entry (NOTICE: each file entry ocupied one  disk block)<br> * @empty_slot: the empty logical index of file entry.<br> */<br><br><b>中文解释</b><br>sfs_dirent_search_nolock：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `sfs_dirent_findino_nolock` | [sfs_inode.c#L476](kern/fs/sfs/sfs_inode.c#L476) | /*<br> * sfs_dirent_findino_nolock - read all file entries in DIR's inode and find a entry->ino == ino<br> */<br><br><b>中文解释</b><br>sfs_dirent_findino_nolock：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_lookup_once` | [sfs_inode.c#L498](kern/fs/sfs/sfs_inode.c#L498) | /*<br> * sfs_lookup_once - find inode corresponding the file name in DIR's sin inode <br> * @sfs:        sfs file system<br> * @sin:        DIR sfs inode in memory<br> * @name:       the file name in DIR<br> * @node_store: the inode corresponding the file name in DIR<br> * @slot:       the logical index of file entry<br> */<br><br><b>中文解释</b><br>sfs_lookup_once：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。<br>逻辑要点：在目录项/索引节点结构中按名称/路径进行查找，成功则返回对应 inode。 |
| `sfs_opendir` | [sfs_inode.c#L515](kern/fs/sfs/sfs_inode.c#L515) | // sfs_opendir - just check the opne_flags, now support readonly<br><br><b>中文解释</b><br>sfs_opendir：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_openfile` | [sfs_inode.c#L532](kern/fs/sfs/sfs_inode.c#L532) | // sfs_openfile - open file (no use)<br><br><b>中文解释</b><br>sfs_openfile：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_close` | [sfs_inode.c#L538](kern/fs/sfs/sfs_inode.c#L538) | // sfs_close - close file<br><br><b>中文解释</b><br>sfs_close：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_io_nolock` | [sfs_inode.c#L552](kern/fs/sfs/sfs_inode.c#L552) | /*  <br> * sfs_io_nolock - Rd/Wr a file contentfrom offset position to offset+ length  disk blocks<-->buffer (in memroy)<br> * @sfs:      sfs file system<br> * @sin:      sfs inode in memory<br> * @buf:      the buffer Rd/Wr<br> * @offset:   the offset of file<br> * @alenp:    the length need to read (is a pointer). and will RETURN the really Rd/Wr lenght<br> * @write:    BOOL, 0 read, 1 write<br> */<br><br><b>中文解释</b><br>sfs_io_nolock：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `sfs_io` | [sfs_inode.c#L670](kern/fs/sfs/sfs_inode.c#L670) | /*<br> * sfs_io - Rd/Wr file. the wrapper of sfs_io_nolock<br>            with lock protect<br> */<br><br><b>中文解释</b><br>sfs_io：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_read` | [sfs_inode.c#L688](kern/fs/sfs/sfs_inode.c#L688) | // sfs_read - read file<br><br><b>中文解释</b><br>sfs_read：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `sfs_write` | [sfs_inode.c#L694](kern/fs/sfs/sfs_inode.c#L694) | // sfs_write - write file<br><br><b>中文解释</b><br>sfs_write：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：可能触发分配新块/更新 size，写入后设置 dirty 以便 fsync 落盘。 |
| `sfs_fstat` | [sfs_inode.c#L702](kern/fs/sfs/sfs_inode.c#L702) | /*<br> * sfs_fstat - Return nlinks/block/size, etc. info about a file. The pointer is a pointer to struct stat;<br> */<br><br><b>中文解释</b><br>sfs_fstat：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_fsync` | [sfs_inode.c#L719](kern/fs/sfs/sfs_inode.c#L719) | /*<br> * sfs_fsync - Force any dirty inode info associated with this file to stable storage.<br> */<br><br><b>中文解释</b><br>sfs_fsync：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_namefile` | [sfs_inode.c#L743](kern/fs/sfs/sfs_inode.c#L743) | /*<br> *sfs_namefile -Compute pathname relative to filesystem root of the file and copy to the specified io buffer.<br> *  <br> */<br><br><b>中文解释</b><br>sfs_namefile：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_getdirentry_sub_nolock` | [sfs_inode.c#L808](kern/fs/sfs/sfs_inode.c#L808) | /*<br> * sfs_getdirentry_sub_noblock - get the content of file entry in DIR<br> */<br><br><b>中文解释</b><br>sfs_getdirentry_sub_nolock：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_getdirentry` | [sfs_inode.c#L829](kern/fs/sfs/sfs_inode.c#L829) | /*<br> * sfs_getdirentry - according to the iob->io_offset, calculate the dir entry's slot in disk block,<br>                     get dir entry content from the disk <br> */<br><br><b>中文解释</b><br>sfs_getdirentry：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_reclaim` | [sfs_inode.c#L864](kern/fs/sfs/sfs_inode.c#L864) | /*<br> * sfs_reclaim - Free all resources inode occupied . Called when inode is no longer in use. <br> */<br><br><b>中文解释</b><br>sfs_reclaim：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_gettype` | [sfs_inode.c#L907](kern/fs/sfs/sfs_inode.c#L907) | /*<br> * sfs_gettype - Return type of file. The values for file types are in sfs.h.<br> */<br><br><b>中文解释</b><br>sfs_gettype：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_tryseek` | [sfs_inode.c#L927](kern/fs/sfs/sfs_inode.c#L927) | /* <br> * sfs_tryseek - Check if seeking to the specified position within the file is legal.<br> */<br><br><b>中文解释</b><br>sfs_tryseek：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_truncfile` | [sfs_inode.c#L942](kern/fs/sfs/sfs_inode.c#L942) | /*<br> * sfs_truncfile : reszie the file with new length<br> */<br><br><b>中文解释</b><br>sfs_truncfile：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_lookup` | [sfs_inode.c#L994](kern/fs/sfs/sfs_inode.c#L994) | /*<br> * sfs_lookup - Parse path relative to the passed directory<br> *              DIR, and hand back the inode for the file it<br> *              refers to.<br> */<br><br><b>中文解释</b><br>sfs_lookup：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：在目录项/索引节点结构中按名称/路径进行查找，成功则返回对应 inode。 |

<details><summary>函数签名（展开查看）</summary>

- [lock_sin](kern/fs/sfs/sfs_inode.c#L22)

```c
static void lock_sin(struct sfs_inode *sin)
```

- [unlock_sin](kern/fs/sfs/sfs_inode.c#L30)

```c
static void unlock_sin(struct sfs_inode *sin)
```

- [sfs_get_ops](kern/fs/sfs/sfs_inode.c#L38)

```c
static const struct inode_ops * sfs_get_ops(uint16_t type)
```

- [sfs_hash_list](kern/fs/sfs/sfs_inode.c#L52)

```c
static list_entry_t * sfs_hash_list(struct sfs_fs *sfs, uint32_t ino)
```

- [sfs_set_links](kern/fs/sfs/sfs_inode.c#L60)

```c
static void sfs_set_links(struct sfs_fs *sfs, struct sfs_inode *sin)
```

- [sfs_remove_links](kern/fs/sfs/sfs_inode.c#L69)

```c
static void sfs_remove_links(struct sfs_inode *sin)
```

- [sfs_block_inuse](kern/fs/sfs/sfs_inode.c#L78)

```c
static bool sfs_block_inuse(struct sfs_fs *sfs, uint32_t ino)
```

- [sfs_block_alloc](kern/fs/sfs/sfs_inode.c#L89)

```c
static int sfs_block_alloc(struct sfs_fs *sfs, uint32_t *ino_store)
```

- [sfs_block_free](kern/fs/sfs/sfs_inode.c#L104)

```c
static void sfs_block_free(struct sfs_fs *sfs, uint32_t ino)
```

- [sfs_create_inode](kern/fs/sfs/sfs_inode.c#L114)

```c
static int sfs_create_inode(struct sfs_fs *sfs, struct sfs_disk_inode *din, uint32_t ino, struct inode **node_store)
```

- [lookup_sfs_nolock](kern/fs/sfs/sfs_inode.c#L133)

```c
static struct inode * lookup_sfs_nolock(struct sfs_fs *sfs, uint32_t ino)
```

- [sfs_load_inode](kern/fs/sfs/sfs_inode.c#L154)

```c
int sfs_load_inode(struct sfs_fs *sfs, struct inode **node_store, uint32_t ino)
```

- [sfs_bmap_get_sub_nolock](kern/fs/sfs/sfs_inode.c#L200)

```c
static int sfs_bmap_get_sub_nolock(struct sfs_fs *sfs, uint32_t *entp, uint32_t index, bool create, uint32_t *ino_store)
```

- [sfs_bmap_get_nolock](kern/fs/sfs/sfs_inode.c#L256)

```c
static int sfs_bmap_get_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t index, bool create, uint32_t *ino_store)
```

- [sfs_bmap_free_sub_nolock](kern/fs/sfs/sfs_inode.c#L297)

```c
static int sfs_bmap_free_sub_nolock(struct sfs_fs *sfs, uint32_t ent, uint32_t index)
```

- [sfs_bmap_free_nolock](kern/fs/sfs/sfs_inode.c#L318)

```c
static int sfs_bmap_free_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t index)
```

- [sfs_bmap_load_nolock](kern/fs/sfs/sfs_inode.c#L353)

```c
static int sfs_bmap_load_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t index, uint32_t *ino_store)
```

- [sfs_bmap_truncate_nolock](kern/fs/sfs/sfs_inode.c#L376)

```c
static int sfs_bmap_truncate_nolock(struct sfs_fs *sfs, struct sfs_inode *sin)
```

- [sfs_dirent_read_nolock](kern/fs/sfs/sfs_inode.c#L396)

```c
static int sfs_dirent_read_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, int slot, struct sfs_disk_entry *entry)
```

- [sfs_dirent_search_nolock](kern/fs/sfs/sfs_inode.c#L440)

```c
static int sfs_dirent_search_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, const char *name, uint32_t *ino_store, int *slot, int *empty_slot)
```

- [sfs_dirent_findino_nolock](kern/fs/sfs/sfs_inode.c#L476)

```c
static int sfs_dirent_findino_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t ino, struct sfs_disk_entry *entry)
```

- [sfs_lookup_once](kern/fs/sfs/sfs_inode.c#L498)

```c
static int sfs_lookup_once(struct sfs_fs *sfs, struct sfs_inode *sin, const char *name, struct inode **node_store, int *slot)
```

- [sfs_opendir](kern/fs/sfs/sfs_inode.c#L515)

```c
static int sfs_opendir(struct inode *node, uint32_t open_flags)
```

- [sfs_openfile](kern/fs/sfs/sfs_inode.c#L532)

```c
static int sfs_openfile(struct inode *node, uint32_t open_flags)
```

- [sfs_close](kern/fs/sfs/sfs_inode.c#L538)

```c
static int sfs_close(struct inode *node)
```

- [sfs_io_nolock](kern/fs/sfs/sfs_inode.c#L552)

```c
static int sfs_io_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, void *buf, off_t offset, size_t *alenp, bool write)
```

- [sfs_io](kern/fs/sfs/sfs_inode.c#L670)

```c
static inline int sfs_io(struct inode *node, struct iobuf *iob, bool write)
```

- [sfs_read](kern/fs/sfs/sfs_inode.c#L688)

```c
static int sfs_read(struct inode *node, struct iobuf *iob)
```

- [sfs_write](kern/fs/sfs/sfs_inode.c#L694)

```c
static int sfs_write(struct inode *node, struct iobuf *iob)
```

- [sfs_fstat](kern/fs/sfs/sfs_inode.c#L702)

```c
static int sfs_fstat(struct inode *node, struct stat *stat)
```

- [sfs_fsync](kern/fs/sfs/sfs_inode.c#L719)

```c
static int sfs_fsync(struct inode *node)
```

- [sfs_namefile](kern/fs/sfs/sfs_inode.c#L743)

```c
static int sfs_namefile(struct inode *node, struct iobuf *iob)
```

- [sfs_getdirentry_sub_nolock](kern/fs/sfs/sfs_inode.c#L808)

```c
static int sfs_getdirentry_sub_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, int slot, struct sfs_disk_entry *entry)
```

- [sfs_getdirentry](kern/fs/sfs/sfs_inode.c#L829)

```c
static int sfs_getdirentry(struct inode *node, struct iobuf *iob)
```

- [sfs_reclaim](kern/fs/sfs/sfs_inode.c#L864)

```c
static int sfs_reclaim(struct inode *node)
```

- [sfs_gettype](kern/fs/sfs/sfs_inode.c#L907)

```c
static int sfs_gettype(struct inode *node, uint32_t *type_store)
```

- [sfs_tryseek](kern/fs/sfs/sfs_inode.c#L927)

```c
static int sfs_tryseek(struct inode *node, off_t pos)
```

- [sfs_truncfile](kern/fs/sfs/sfs_inode.c#L942)

```c
static int sfs_truncfile(struct inode *node, off_t len)
```

- [sfs_lookup](kern/fs/sfs/sfs_inode.c#L994)

```c
static int sfs_lookup(struct inode *node, char *path, struct inode **node_store)
```

</details>

### kern/fs/sfs/sfs_io.c
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `sfs_rwblock_nolock` | [sfs_io.c#L19](kern/fs/sfs/sfs_io.c#L19) | /* sfs_rwblock_nolock - Basic block-level I/O routine for Rd/Wr one disk block,<br> *                      without lock protect for mutex process on Rd/Wr disk block<br> * @sfs:   sfs_fs which will be process<br> * @buf:   the buffer uesed for Rd/Wr<br> * @blkno: the NO. of disk block<br> * @write: BOOL: Read or Write<br> * @check: BOOL: if check (blono < sfs super.blocks)<br> */<br><br><b>中文解释</b><br>sfs_rwblock_nolock：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `sfs_rwblock` | [sfs_io.c#L34](kern/fs/sfs/sfs_io.c#L34) | /* sfs_rwblock - Basic block-level I/O routine for Rd/Wr N disk blocks ,<br> *               with lock protect for mutex process on Rd/Wr disk block<br> * @sfs:   sfs_fs which will be process<br> * @buf:   the buffer uesed for Rd/Wr<br> * @blkno: the NO. of disk block<br> * @nblks: Rd/Wr number of disk block<br> * @write: BOOL: Read - 0 or Write - 1<br> */<br><br><b>中文解释</b><br>sfs_rwblock：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `sfs_rblock` | [sfs_io.c#L58](kern/fs/sfs/sfs_io.c#L58) | /* sfs_rblock - The Wrap of sfs_rwblock function for Rd N disk blocks ,<br> *<br> * @sfs:   sfs_fs which will be process<br> * @buf:   the buffer uesed for Rd/Wr<br> * @blkno: the NO. of disk block<br> * @nblks: Rd/Wr number of disk block<br> */<br><br><b>中文解释</b><br>sfs_rblock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>参数 sfs：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 buf：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 blkno：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 nblks：读/写 数量 of 磁盘块 |
| `sfs_wblock` | [sfs_io.c#L70](kern/fs/sfs/sfs_io.c#L70) | /* sfs_wblock - The Wrap of sfs_rwblock function for Wr N disk blocks ,<br> *<br> * @sfs:   sfs_fs which will be process<br> * @buf:   the buffer uesed for Rd/Wr<br> * @blkno: the NO. of disk block<br> * @nblks: Rd/Wr number of disk block<br> */<br><br><b>中文解释</b><br>sfs_wblock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>参数 sfs：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 buf：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 blkno：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 nblks：读/写 数量 of 磁盘块 |
| `sfs_rbuf` | [sfs_io.c#L83](kern/fs/sfs/sfs_io.c#L83) | /* sfs_rbuf - The Basic block-level I/O routine for  Rd( non-block & non-aligned io) one disk block(using sfs->sfs_buffer)<br> *            with lock protect for mutex process on Rd/Wr disk block<br> * @sfs:    sfs_fs which will be process<br> * @buf:    the buffer uesed for Rd<br> * @len:    the length need to Rd<br> * @blkno:  the NO. of disk block<br> * @offset: the offset in the content of disk block<br> */<br><br><b>中文解释</b><br>sfs_rbuf：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `sfs_wbuf` | [sfs_io.c#L105](kern/fs/sfs/sfs_io.c#L105) | /* sfs_wbuf - The Basic block-level I/O routine for  Wr( non-block & non-aligned io) one disk block(using sfs->sfs_buffer)<br> *            with lock protect for mutex process on Rd/Wr disk block<br> * @sfs:    sfs_fs which will be process<br> * @buf:    the buffer uesed for Wr<br> * @len:    the length need to Wr<br> * @blkno:  the NO. of disk block<br> * @offset: the offset in the content of disk block<br> */<br><br><b>中文解释</b><br>sfs_wbuf：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `sfs_sync_super` | [sfs_io.c#L123](kern/fs/sfs/sfs_io.c#L123) | /*<br> * sfs_sync_super - write sfs->super (in memory) into disk (SFS_BLKN_SUPER, 1) with lock protect.<br> */<br><br><b>中文解释</b><br>sfs_sync_super：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sfs_sync_freemap` | [sfs_io.c#L139](kern/fs/sfs/sfs_io.c#L139) | /*<br> * sfs_sync_freemap - write sfs bitmap into disk (SFS_BLKN_FREEMAP, nblks)  without lock protect.<br> */<br><br><b>中文解释</b><br>sfs_sync_freemap：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：将资源标记为可复用，并更新计数/元数据。 |
| `sfs_clear_block` | [sfs_io.c#L151](kern/fs/sfs/sfs_io.c#L151) | /*<br> * sfs_clear_block - write zero info into disk (blkno, nblks)  with lock protect.<br> * @sfs:   sfs_fs which will be process<br> * @blkno: the NO. of disk block<br> * @nblks: Rd/Wr number of disk block<br> */<br><br><b>中文解释</b><br>sfs_clear_block：（该句为实现细节/定义说明，建议结合源码阅读。）<br>参数 sfs：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 blkno：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。<br>参数 nblks：读/写 数量 of 磁盘块 |

<details><summary>函数签名（展开查看）</summary>

- [sfs_rwblock_nolock](kern/fs/sfs/sfs_io.c#L19)

```c
static int sfs_rwblock_nolock(struct sfs_fs *sfs, void *buf, uint32_t blkno, bool write, bool check)
```

- [sfs_rwblock](kern/fs/sfs/sfs_io.c#L34)

```c
static int sfs_rwblock(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks, bool write)
```

- [sfs_rblock](kern/fs/sfs/sfs_io.c#L58)

```c
int sfs_rblock(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks)
```

- [sfs_wblock](kern/fs/sfs/sfs_io.c#L70)

```c
int sfs_wblock(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks)
```

- [sfs_rbuf](kern/fs/sfs/sfs_io.c#L83)

```c
int sfs_rbuf(struct sfs_fs *sfs, void *buf, size_t len, uint32_t blkno, off_t offset)
```

- [sfs_wbuf](kern/fs/sfs/sfs_io.c#L105)

```c
int sfs_wbuf(struct sfs_fs *sfs, void *buf, size_t len, uint32_t blkno, off_t offset)
```

- [sfs_sync_super](kern/fs/sfs/sfs_io.c#L123)

```c
int sfs_sync_super(struct sfs_fs *sfs)
```

- [sfs_sync_freemap](kern/fs/sfs/sfs_io.c#L139)

```c
int sfs_sync_freemap(struct sfs_fs *sfs)
```

- [sfs_clear_block](kern/fs/sfs/sfs_io.c#L151)

```c
int sfs_clear_block(struct sfs_fs *sfs, uint32_t blkno, uint32_t nblks)
```

</details>

### kern/fs/sfs/sfs_lock.c
**文件作用**：SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `lock_sfs_fs` | [sfs_lock.c#L11](kern/fs/sfs/sfs_lock.c#L11) | /*<br> * lock_sfs_fs - lock the process of  SFS Filesystem Rd/Wr Disk Block<br> *<br> * called by: sfs_load_inode, sfs_sync, sfs_reclaim<br> */<br><br><b>中文解释</b><br>lock_sfs_fs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `lock_sfs_io` | [sfs_lock.c#L21](kern/fs/sfs/sfs_lock.c#L21) | /*<br> * lock_sfs_io - lock the process of SFS File Rd/Wr Disk Block<br> *<br> * called by: sfs_rwblock, sfs_clear_block, sfs_sync_super<br> */<br><br><b>中文解释</b><br>lock_sfs_io：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `unlock_sfs_fs` | [sfs_lock.c#L31](kern/fs/sfs/sfs_lock.c#L31) | /*<br> * unlock_sfs_fs - unlock the process of  SFS Filesystem Rd/Wr Disk Block<br> *<br> * called by: sfs_load_inode, sfs_sync, sfs_reclaim<br> */<br><br><b>中文解释</b><br>unlock_sfs_fs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `unlock_sfs_io` | [sfs_lock.c#L41](kern/fs/sfs/sfs_lock.c#L41) | /*<br> * unlock_sfs_io - unlock the process of sfs Rd/Wr Disk Block<br> *<br> * called by: sfs_rwblock sfs_clear_block sfs_sync_super<br> */<br><br><b>中文解释</b><br>unlock_sfs_io：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [lock_sfs_fs](kern/fs/sfs/sfs_lock.c#L11)

```c
void lock_sfs_fs(struct sfs_fs *sfs)
```

- [lock_sfs_io](kern/fs/sfs/sfs_lock.c#L21)

```c
void lock_sfs_io(struct sfs_fs *sfs)
```

- [unlock_sfs_fs](kern/fs/sfs/sfs_lock.c#L31)

```c
void unlock_sfs_fs(struct sfs_fs *sfs)
```

- [unlock_sfs_io](kern/fs/sfs/sfs_lock.c#L41)

```c
void unlock_sfs_io(struct sfs_fs *sfs)
```

</details>

### kern/fs/swap/swapfs.c
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `swapfs_init` | [swapfs.c#L8](kern/fs/swap/swapfs.c#L8) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `swapfs_read` | [swapfs.c#L18](kern/fs/swap/swapfs.c#L18) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `swapfs_write` | [swapfs.c#L23](kern/fs/swap/swapfs.c#L23) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [swapfs_init](kern/fs/swap/swapfs.c#L8)

```c
void swapfs_init(void)
```

- [swapfs_read](kern/fs/swap/swapfs.c#L18)

```c
int swapfs_read(swap_entry_t entry, struct Page *page)
```

- [swapfs_write](kern/fs/swap/swapfs.c#L23)

```c
int swapfs_write(swap_entry_t entry, struct Page *page)
```

</details>

### kern/fs/swap/swapfs.h
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/sysfile.c
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `copy_path` | [sysfile.c#L19](kern/fs/sysfile.c#L19) | /* copy_path - copy path name */<br><br><b>中文解释</b><br>copy_path：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_open` | [sysfile.c#L41](kern/fs/sysfile.c#L41) | /* sysfile_open - open file */<br><br><b>中文解释</b><br>sysfile_open：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_close` | [sysfile.c#L54](kern/fs/sysfile.c#L54) | /* sysfile_close - close file */<br><br><b>中文解释</b><br>sysfile_close：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_read` | [sysfile.c#L60](kern/fs/sysfile.c#L60) | /* sysfile_read - read file */<br><br><b>中文解释</b><br>sysfile_read：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `sysfile_write` | [sysfile.c#L108](kern/fs/sysfile.c#L108) | /* sysfile_write - write file */<br><br><b>中文解释</b><br>sysfile_write：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：可能触发分配新块/更新 size，写入后设置 dirty 以便 fsync 落盘。 |
| `sysfile_seek` | [sysfile.c#L156](kern/fs/sysfile.c#L156) | /* sysfile_seek - seek file */<br><br><b>中文解释</b><br>sysfile_seek：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_fstat` | [sysfile.c#L162](kern/fs/sysfile.c#L162) | /* sysfile_fstat - stat file */<br><br><b>中文解释</b><br>sysfile_fstat：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_fsync` | [sysfile.c#L182](kern/fs/sysfile.c#L182) | /* sysfile_fsync - sync file */<br><br><b>中文解释</b><br>sysfile_fsync：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_chdir` | [sysfile.c#L188](kern/fs/sysfile.c#L188) | /* sysfile_chdir - change dir */<br><br><b>中文解释</b><br>sysfile_chdir：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_link` | [sysfile.c#L201](kern/fs/sysfile.c#L201) | /* sysfile_link - link file */<br><br><b>中文解释</b><br>sysfile_link：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_rename` | [sysfile.c#L218](kern/fs/sysfile.c#L218) | /* sysfile_rename - rename file */<br><br><b>中文解释</b><br>sysfile_rename：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_unlink` | [sysfile.c#L235](kern/fs/sysfile.c#L235) | /* sysfile_unlink - unlink file */<br><br><b>中文解释</b><br>sysfile_unlink：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_getcwd` | [sysfile.c#L248](kern/fs/sysfile.c#L248) | /* sysfile_get cwd - get current working directory */<br><br><b>中文解释</b><br>sysfile_getcwd：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_getdirentry` | [sysfile.c#L268](kern/fs/sysfile.c#L268) | /* sysfile_getdirentry - get the file entry in DIR */<br><br><b>中文解释</b><br>sysfile_getdirentry：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_dup` | [sysfile.c#L303](kern/fs/sysfile.c#L303) | /* sysfile_dup -  duplicate fd1 to fd2 */<br><br><b>中文解释</b><br>sysfile_dup：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `sysfile_pipe` | [sysfile.c#L308](kern/fs/sysfile.c#L308) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sysfile_mkfifo` | [sysfile.c#L313](kern/fs/sysfile.c#L313) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [copy_path](kern/fs/sysfile.c#L19)

```c
static int copy_path(char **to, const char *from)
```

- [sysfile_open](kern/fs/sysfile.c#L41)

```c
int sysfile_open(const char *__path, uint32_t open_flags)
```

- [sysfile_close](kern/fs/sysfile.c#L54)

```c
int sysfile_close(int fd)
```

- [sysfile_read](kern/fs/sysfile.c#L60)

```c
int sysfile_read(int fd, void *base, size_t len)
```

- [sysfile_write](kern/fs/sysfile.c#L108)

```c
int sysfile_write(int fd, void *base, size_t len)
```

- [sysfile_seek](kern/fs/sysfile.c#L156)

```c
int sysfile_seek(int fd, off_t pos, int whence)
```

- [sysfile_fstat](kern/fs/sysfile.c#L162)

```c
int sysfile_fstat(int fd, struct stat *__stat)
```

- [sysfile_fsync](kern/fs/sysfile.c#L182)

```c
int sysfile_fsync(int fd)
```

- [sysfile_chdir](kern/fs/sysfile.c#L188)

```c
int sysfile_chdir(const char *__path)
```

- [sysfile_link](kern/fs/sysfile.c#L201)

```c
int sysfile_link(const char *__path1, const char *__path2)
```

- [sysfile_rename](kern/fs/sysfile.c#L218)

```c
int sysfile_rename(const char *__path1, const char *__path2)
```

- [sysfile_unlink](kern/fs/sysfile.c#L235)

```c
int sysfile_unlink(const char *__path)
```

- [sysfile_getcwd](kern/fs/sysfile.c#L248)

```c
int sysfile_getcwd(char *buf, size_t len)
```

- [sysfile_getdirentry](kern/fs/sysfile.c#L268)

```c
int sysfile_getdirentry(int fd, struct dirent *__direntp)
```

- [sysfile_dup](kern/fs/sysfile.c#L303)

```c
int sysfile_dup(int fd1, int fd2)
```

- [sysfile_pipe](kern/fs/sysfile.c#L308)

```c
int sysfile_pipe(int *fd_store)
```

- [sysfile_mkfifo](kern/fs/sysfile.c#L313)

```c
int sysfile_mkfifo(const char *__name, uint32_t open_flags)
```

</details>

### kern/fs/sysfile.h
**文件作用**：通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/vfs/inode.c
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `__alloc_inode` | [inode.c#L14](kern/fs/vfs/inode.c#L14) | /* *<br> * __alloc_inode - alloc a inode structure and initialize in_type<br> * */<br><br><b>中文解释</b><br>__alloc_inode：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：从空闲资源集合（如位图/缓存）选择一个可用项并标记为已占用。 |
| `inode_init` | [inode.c#L27](kern/fs/vfs/inode.c#L27) | /* *<br> * inode_init - initialize a inode structure<br> * invoked by vop_init<br> * */<br><br><b>中文解释</b><br>inode_init：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `inode_kill` | [inode.c#L39](kern/fs/vfs/inode.c#L39) | /* *<br> * inode_kill - kill a inode structure<br> * invoked by vop_kill<br> * */<br><br><b>中文解释</b><br>inode_kill：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `inode_ref_inc` | [inode.c#L50](kern/fs/vfs/inode.c#L50) | /* *<br> * inode_ref_inc - increment ref_count<br> * invoked by vop_ref_inc<br> * */<br><br><b>中文解释</b><br>inode_ref_inc：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `inode_ref_dec` | [inode.c#L61](kern/fs/vfs/inode.c#L61) | /* *<br> * inode_ref_dec - decrement ref_count<br> * invoked by vop_ref_dec<br> * calls vop_reclaim if the ref_count hits zero<br> * */<br><br><b>中文解释</b><br>inode_ref_dec：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `inode_open_inc` | [inode.c#L79](kern/fs/vfs/inode.c#L79) | /* *<br> * inode_open_inc - increment the open_count<br> * invoked by vop_open_inc<br> * */<br><br><b>中文解释</b><br>inode_open_inc：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `inode_open_dec` | [inode.c#L90](kern/fs/vfs/inode.c#L90) | /* *<br> * inode_open_dec - decrement the open_count<br> * invoked by vop_open_dec<br> * calls vop_close if the open_count hits zero<br> * */<br><br><b>中文解释</b><br>inode_open_dec：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `inode_check` | [inode.c#L108](kern/fs/vfs/inode.c#L108) | /* *<br> * inode_check - check the various things being valid<br> * called before all vop_* calls<br> * */<br><br><b>中文解释</b><br>inode_check：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [__alloc_inode](kern/fs/vfs/inode.c#L14)

```c
struct inode * __alloc_inode(int type)
```

- [inode_init](kern/fs/vfs/inode.c#L27)

```c
void inode_init(struct inode *node, const struct inode_ops *ops, struct fs *fs)
```

- [inode_kill](kern/fs/vfs/inode.c#L39)

```c
void inode_kill(struct inode *node)
```

- [inode_ref_inc](kern/fs/vfs/inode.c#L50)

```c
int inode_ref_inc(struct inode *node)
```

- [inode_ref_dec](kern/fs/vfs/inode.c#L61)

```c
int inode_ref_dec(struct inode *node)
```

- [inode_open_inc](kern/fs/vfs/inode.c#L79)

```c
int inode_open_inc(struct inode *node)
```

- [inode_open_dec](kern/fs/vfs/inode.c#L90)

```c
int inode_open_dec(struct inode *node)
```

- [inode_check](kern/fs/vfs/inode.c#L108)

```c
void inode_check(struct inode *node, const char *opstr)
```

</details>

### kern/fs/vfs/inode.h
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `inode_ref_count` | [inode.h#L237](kern/fs/vfs/inode.h#L237) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `inode_open_count` | [inode.h#L242](kern/fs/vfs/inode.h#L242) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [inode_ref_count](kern/fs/vfs/inode.h#L237)

```c
static inline int inode_ref_count(struct inode *node)
```

- [inode_open_count](kern/fs/vfs/inode.h#L242)

```c
static inline int inode_open_count(struct inode *node)
```

</details>

### kern/fs/vfs/vfs.c
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `__alloc_fs` | [vfs.c#L16](kern/fs/vfs/vfs.c#L16) | // __alloc_fs - allocate memory for fs, and set fs type<br><br><b>中文解释</b><br>__alloc_fs：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：从空闲资源集合（如位图/缓存）选择一个可用项并标记为已占用。 |
| `vfs_init` | [vfs.c#L26](kern/fs/vfs/vfs.c#L26) | // vfs_init -  vfs initialize<br><br><b>中文解释</b><br>vfs_init：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `lock_bootfs` | [vfs.c#L33](kern/fs/vfs/vfs.c#L33) | // lock_bootfs - lock  for bootfs<br><br><b>中文解释</b><br>lock_bootfs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `unlock_bootfs` | [vfs.c#L38](kern/fs/vfs/vfs.c#L38) | // ulock_bootfs - ulock for bootfs<br><br><b>中文解释</b><br>unlock_bootfs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `change_bootfs` | [vfs.c#L44](kern/fs/vfs/vfs.c#L44) | // change_bootfs - set the new fs inode<br><br><b>中文解释</b><br>change_bootfs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_set_bootfs` | [vfs.c#L58](kern/fs/vfs/vfs.c#L58) | // vfs_set_bootfs - change the dir of file system<br><br><b>中文解释</b><br>vfs_set_bootfs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_get_bootfs` | [vfs.c#L79](kern/fs/vfs/vfs.c#L79) | // vfs_get_bootfs - get the inode of bootfs<br><br><b>中文解释</b><br>vfs_get_bootfs：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [__alloc_fs](kern/fs/vfs/vfs.c#L16)

```c
struct fs * __alloc_fs(int type)
```

- [vfs_init](kern/fs/vfs/vfs.c#L26)

```c
void vfs_init(void)
```

- [lock_bootfs](kern/fs/vfs/vfs.c#L33)

```c
static void lock_bootfs(void)
```

- [unlock_bootfs](kern/fs/vfs/vfs.c#L38)

```c
static void unlock_bootfs(void)
```

- [change_bootfs](kern/fs/vfs/vfs.c#L44)

```c
static void change_bootfs(struct inode *node)
```

- [vfs_set_bootfs](kern/fs/vfs/vfs.c#L58)

```c
int vfs_set_bootfs(char *fsname)
```

- [vfs_get_bootfs](kern/fs/vfs/vfs.c#L79)

```c
int vfs_get_bootfs(struct inode **node_store)
```

</details>

### kern/fs/vfs/vfs.h
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/fs/vfs/vfsdev.c
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `lock_vdev_list` | [vfsdev.c#L29](kern/fs/vfs/vfsdev.c#L29) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `unlock_vdev_list` | [vfsdev.c#L34](kern/fs/vfs/vfsdev.c#L34) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `vfs_devlist_init` | [vfsdev.c#L39](kern/fs/vfs/vfsdev.c#L39) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `vfs_cleanup` | [vfsdev.c#L46](kern/fs/vfs/vfsdev.c#L46) | // vfs_cleanup - finally clean (or sync) fs<br><br><b>中文解释</b><br>vfs_cleanup：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_get_root` | [vfsdev.c#L67](kern/fs/vfs/vfsdev.c#L67) | /*<br> * vfs_get_root - Given a device name (stdin, stdout, etc.), hand<br> *                back an appropriate inode.<br> */<br><br><b>中文解释</b><br>vfs_get_root：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_get_devname` | [vfsdev.c#L104](kern/fs/vfs/vfsdev.c#L104) | /*<br> * vfs_get_devname - Given a filesystem, hand back the name of the device it's mounted on.<br> */<br><br><b>中文解释</b><br>vfs_get_devname：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `check_devname_conflict` | [vfsdev.c#L120](kern/fs/vfs/vfsdev.c#L120) | /*<br> * check_devname_confilct - Is there alreadily device which has the same name?<br> */<br><br><b>中文解释</b><br>check_devname_conflict：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_do_add` | [vfsdev.c#L140](kern/fs/vfs/vfsdev.c#L140) | /*<br>* vfs_do_add - Add a new device to the VFS layer's device table.<br>*<br>* If "mountable" is set, the device will be treated as one that expects<br>* to have a filesystem mounted on it, and a raw device will be created<br>* for direct access.<br>*/<br><br><b>中文解释</b><br>vfs_do_add：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_add_fs` | [vfsdev.c#L185](kern/fs/vfs/vfsdev.c#L185) | /*<br> * vfs_add_fs - Add a new fs,  by name. See  vfs_do_add information for the description of<br> *              mountable.<br> */<br><br><b>中文解释</b><br>vfs_add_fs：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_add_dev` | [vfsdev.c#L194](kern/fs/vfs/vfsdev.c#L194) | /*<br> * vfs_add_dev - Add a new device, by name. See  vfs_do_add information for the description of<br> *               mountable.<br> */<br><br><b>中文解释</b><br>vfs_add_dev：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `find_mount` | [vfsdev.c#L203](kern/fs/vfs/vfsdev.c#L203) | /*<br> * find_mount - Look for a mountable device named DEVNAME.<br> *              Should already hold vdev_list lock.<br> */<br><br><b>中文解释</b><br>find_mount：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `int` | [vfsdev.c#L223](kern/fs/vfs/vfsdev.c#L223) | /*<br> * vfs_mount - Mount a filesystem. Once we've found the device, call MOUNTFUNC to<br> *             set up the filesystem and hand back a struct fs.<br> *<br> * The DATA argument is passed through unchanged to MOUNTFUNC.<br> */<br><br><b>中文解释</b><br>int：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_unmount` | [vfsdev.c#L252](kern/fs/vfs/vfsdev.c#L252) | /*<br> * vfs_unmount - Unmount a filesystem/device by name.<br> *               First calls FSOP_SYNC on the filesystem; then calls FSOP_UNMOUNT.<br> */<br><br><b>中文解释</b><br>vfs_unmount：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_unmount_all` | [vfsdev.c#L282](kern/fs/vfs/vfsdev.c#L282) | /*<br> * vfs_unmount_all - Global unmount function.<br> */<br><br><b>中文解释</b><br>vfs_unmount_all：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [lock_vdev_list](kern/fs/vfs/vfsdev.c#L29)

```c
static void lock_vdev_list(void)
```

- [unlock_vdev_list](kern/fs/vfs/vfsdev.c#L34)

```c
static void unlock_vdev_list(void)
```

- [vfs_devlist_init](kern/fs/vfs/vfsdev.c#L39)

```c
void vfs_devlist_init(void)
```

- [vfs_cleanup](kern/fs/vfs/vfsdev.c#L46)

```c
void vfs_cleanup(void)
```

- [vfs_get_root](kern/fs/vfs/vfsdev.c#L67)

```c
int vfs_get_root(const char *devname, struct inode **node_store)
```

- [vfs_get_devname](kern/fs/vfs/vfsdev.c#L104)

```c
const char * vfs_get_devname(struct fs *fs)
```

- [check_devname_conflict](kern/fs/vfs/vfsdev.c#L120)

```c
static bool check_devname_conflict(const char *devname)
```

- [vfs_do_add](kern/fs/vfs/vfsdev.c#L140)

```c
static int vfs_do_add(const char *devname, struct inode *devnode, struct fs *fs, bool mountable)
```

- [vfs_add_fs](kern/fs/vfs/vfsdev.c#L185)

```c
int vfs_add_fs(const char *devname, struct fs *fs)
```

- [vfs_add_dev](kern/fs/vfs/vfsdev.c#L194)

```c
int vfs_add_dev(const char *devname, struct inode *devnode, bool mountable)
```

- [find_mount](kern/fs/vfs/vfsdev.c#L203)

```c
static int find_mount(const char *devname, vfs_dev_t **vdev_store)
```

- [int](kern/fs/vfs/vfsdev.c#L223)

```c
int vfs_mount(const char *devname, int (*mountfunc)(struct device *dev, struct fs **fs_store))
```

- [vfs_unmount](kern/fs/vfs/vfsdev.c#L252)

```c
int vfs_unmount(const char *devname)
```

- [vfs_unmount_all](kern/fs/vfs/vfsdev.c#L282)

```c
int vfs_unmount_all(void)
```

</details>

### kern/fs/vfs/vfsfile.c
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `vfs_open` | [vfsfile.c#L11](kern/fs/vfs/vfsfile.c#L11) | // open file in vfs, get/create inode for file with filename path.<br><br><b>中文解释</b><br>vfs_open：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_close` | [vfsfile.c#L69](kern/fs/vfs/vfsfile.c#L69) | // close file in vfs<br><br><b>中文解释</b><br>vfs_close：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_unlink` | [vfsfile.c#L77](kern/fs/vfs/vfsfile.c#L77) | // unimplement<br><br><b>中文解释</b><br>vfs_unlink：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_rename` | [vfsfile.c#L83](kern/fs/vfs/vfsfile.c#L83) | // unimplement<br><br><b>中文解释</b><br>vfs_rename：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_link` | [vfsfile.c#L89](kern/fs/vfs/vfsfile.c#L89) | // unimplement<br><br><b>中文解释</b><br>vfs_link：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_symlink` | [vfsfile.c#L95](kern/fs/vfs/vfsfile.c#L95) | // unimplement<br><br><b>中文解释</b><br>vfs_symlink：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_readlink` | [vfsfile.c#L101](kern/fs/vfs/vfsfile.c#L101) | // unimplement<br><br><b>中文解释</b><br>vfs_readlink：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `vfs_mkdir` | [vfsfile.c#L107](kern/fs/vfs/vfsfile.c#L107) | // unimplement<br><br><b>中文解释</b><br>vfs_mkdir：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [vfs_open](kern/fs/vfs/vfsfile.c#L11)

```c
int vfs_open(char *path, uint32_t open_flags, struct inode **node_store)
```

- [vfs_close](kern/fs/vfs/vfsfile.c#L69)

```c
int vfs_close(struct inode *node)
```

- [vfs_unlink](kern/fs/vfs/vfsfile.c#L77)

```c
int vfs_unlink(char *path)
```

- [vfs_rename](kern/fs/vfs/vfsfile.c#L83)

```c
int vfs_rename(char *old_path, char *new_path)
```

- [vfs_link](kern/fs/vfs/vfsfile.c#L89)

```c
int vfs_link(char *old_path, char *new_path)
```

- [vfs_symlink](kern/fs/vfs/vfsfile.c#L95)

```c
int vfs_symlink(char *old_path, char *new_path)
```

- [vfs_readlink](kern/fs/vfs/vfsfile.c#L101)

```c
int vfs_readlink(char *path, struct iobuf *iob)
```

- [vfs_mkdir](kern/fs/vfs/vfsfile.c#L107)

```c
int vfs_mkdir(char *path)
```

</details>

### kern/fs/vfs/vfslookup.c
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `get_device` | [vfslookup.c#L13](kern/fs/vfs/vfslookup.c#L13) | /*<br> * get_device- Common code to pull the device name, if any, off the front of a<br> *             path and choose the inode to begin the name lookup relative to.<br> */<br><br><b>中文解释</b><br>get_device：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_lookup` | [vfslookup.c#L71](kern/fs/vfs/vfslookup.c#L71) | /*<br> * vfs_lookup - get the inode according to the path filename<br> */<br><br><b>中文解释</b><br>vfs_lookup：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：在目录项/索引节点结构中按名称/路径进行查找，成功则返回对应 inode。 |
| `vfs_lookup_parent` | [vfslookup.c#L91](kern/fs/vfs/vfslookup.c#L91) | /*<br> * vfs_lookup_parent - Name-to-vnode translation.<br> *  (In BSD, both of these are subsumed by namei().)<br> */<br><br><b>中文解释</b><br>vfs_lookup_parent：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：在目录项/索引节点结构中按名称/路径进行查找，成功则返回对应 inode。 |

<details><summary>函数签名（展开查看）</summary>

- [get_device](kern/fs/vfs/vfslookup.c#L13)

```c
static int get_device(char *path, char **subpath, struct inode **node_store)
```

- [vfs_lookup](kern/fs/vfs/vfslookup.c#L71)

```c
int vfs_lookup(char *path, struct inode **node_store)
```

- [vfs_lookup_parent](kern/fs/vfs/vfslookup.c#L91)

```c
int vfs_lookup_parent(char *path, struct inode **node_store, char **endp)
```

</details>

### kern/fs/vfs/vfspath.c
**文件作用**：VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `get_cwd_nolock` | [vfspath.c#L14](kern/fs/vfs/vfspath.c#L14) | /*<br> * get_cwd_nolock - retrieve current process's working directory. without lock protect<br> */<br><br><b>中文解释</b><br>get_cwd_nolock：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `set_cwd_nolock` | [vfspath.c#L21](kern/fs/vfs/vfspath.c#L21) | /*<br> * set_cwd_nolock - set current working directory.<br> */<br><br><b>中文解释</b><br>set_cwd_nolock：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `lock_cfs` | [vfspath.c#L29](kern/fs/vfs/vfspath.c#L29) | /*<br> * lock_cfs - lock the fs related process on current process <br> */<br><br><b>中文解释</b><br>lock_cfs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `unlock_cfs` | [vfspath.c#L36](kern/fs/vfs/vfspath.c#L36) | /*<br> * unlock_cfs - unlock the fs related process on current process <br> */<br><br><b>中文解释</b><br>unlock_cfs：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_get_curdir` | [vfspath.c#L44](kern/fs/vfs/vfspath.c#L44) | /*<br> *  vfs_get_curdir - Get current directory as a inode.<br> */<br><br><b>中文解释</b><br>vfs_get_curdir：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_set_curdir` | [vfspath.c#L59](kern/fs/vfs/vfspath.c#L59) | /*<br> * vfs_set_curdir - Set current directory as a inode.<br> *                  The passed inode must in fact be a directory.<br> */<br><br><b>中文解释</b><br>vfs_set_curdir：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_chdir` | [vfspath.c#L90](kern/fs/vfs/vfspath.c#L90) | /*<br> * vfs_chdir - Set current directory, as a pathname. Use vfs_lookup to translate<br> *             it to a inode.<br> */<br><br><b>中文解释</b><br>vfs_chdir：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |
| `vfs_getcwd` | [vfspath.c#L103](kern/fs/vfs/vfspath.c#L103) | /*<br> * vfs_getcwd - retrieve current working directory(cwd).<br> */<br><br><b>中文解释</b><br>vfs_getcwd：（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [get_cwd_nolock](kern/fs/vfs/vfspath.c#L14)

```c
static struct inode * get_cwd_nolock(void)
```

- [set_cwd_nolock](kern/fs/vfs/vfspath.c#L21)

```c
static void set_cwd_nolock(struct inode *pwd)
```

- [lock_cfs](kern/fs/vfs/vfspath.c#L29)

```c
static void lock_cfs(void)
```

- [unlock_cfs](kern/fs/vfs/vfspath.c#L36)

```c
static void unlock_cfs(void)
```

- [vfs_get_curdir](kern/fs/vfs/vfspath.c#L44)

```c
int vfs_get_curdir(struct inode **dir_store)
```

- [vfs_set_curdir](kern/fs/vfs/vfspath.c#L59)

```c
int vfs_set_curdir(struct inode *dir)
```

- [vfs_chdir](kern/fs/vfs/vfspath.c#L90)

```c
int vfs_chdir(char *path)
```

- [vfs_getcwd](kern/fs/vfs/vfspath.c#L103)

```c
int vfs_getcwd(struct iobuf *iob)
```

</details>

### kern/syscall/syscall.c
**文件作用**：内核系统调用分发与文件系统相关 syscall 入口。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `sys_exit` | [syscall.c#L10](kern/syscall/syscall.c#L10) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_fork` | [syscall.c#L17](kern/syscall/syscall.c#L17) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_wait` | [syscall.c#L25](kern/syscall/syscall.c#L25) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_exec` | [syscall.c#L32](kern/syscall/syscall.c#L32) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_yield` | [syscall.c#L41](kern/syscall/syscall.c#L41) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_kill` | [syscall.c#L47](kern/syscall/syscall.c#L47) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_getpid` | [syscall.c#L54](kern/syscall/syscall.c#L54) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_putc` | [syscall.c#L60](kern/syscall/syscall.c#L60) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_pgdir` | [syscall.c#L68](kern/syscall/syscall.c#L68) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_gettime` | [syscall.c#L74](kern/syscall/syscall.c#L74) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_lab6_set_priority` | [syscall.c#L78](kern/syscall/syscall.c#L78) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_sleep` | [syscall.c#L84](kern/syscall/syscall.c#L84) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_open` | [syscall.c#L90](kern/syscall/syscall.c#L90) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_close` | [syscall.c#L98](kern/syscall/syscall.c#L98) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_read` | [syscall.c#L105](kern/syscall/syscall.c#L105) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_write` | [syscall.c#L114](kern/syscall/syscall.c#L114) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_seek` | [syscall.c#L123](kern/syscall/syscall.c#L123) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_fstat` | [syscall.c#L132](kern/syscall/syscall.c#L132) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_fsync` | [syscall.c#L140](kern/syscall/syscall.c#L140) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_getcwd` | [syscall.c#L147](kern/syscall/syscall.c#L147) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_getdirentry` | [syscall.c#L155](kern/syscall/syscall.c#L155) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sys_dup` | [syscall.c#L163](kern/syscall/syscall.c#L163) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `syscall` | [syscall.c#L197](kern/syscall/syscall.c#L197) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [sys_exit](kern/syscall/syscall.c#L10)

```c
static int sys_exit(uint64_t arg[])
```

- [sys_fork](kern/syscall/syscall.c#L17)

```c
static int sys_fork(uint64_t arg[])
```

- [sys_wait](kern/syscall/syscall.c#L25)

```c
static int sys_wait(uint64_t arg[])
```

- [sys_exec](kern/syscall/syscall.c#L32)

```c
static int sys_exec(uint64_t arg[])
```

- [sys_yield](kern/syscall/syscall.c#L41)

```c
static int sys_yield(uint64_t arg[])
```

- [sys_kill](kern/syscall/syscall.c#L47)

```c
static int sys_kill(uint64_t arg[])
```

- [sys_getpid](kern/syscall/syscall.c#L54)

```c
static int sys_getpid(uint64_t arg[])
```

- [sys_putc](kern/syscall/syscall.c#L60)

```c
static int sys_putc(uint64_t arg[])
```

- [sys_pgdir](kern/syscall/syscall.c#L68)

```c
static int sys_pgdir(uint64_t arg[])
```

- [sys_gettime](kern/syscall/syscall.c#L74)

```c
static int sys_gettime(uint64_t arg[])
```

- [sys_lab6_set_priority](kern/syscall/syscall.c#L78)

```c
static int sys_lab6_set_priority(uint64_t arg[])
```

- [sys_sleep](kern/syscall/syscall.c#L84)

```c
static int sys_sleep(uint64_t arg[])
```

- [sys_open](kern/syscall/syscall.c#L90)

```c
static int sys_open(uint64_t arg[])
```

- [sys_close](kern/syscall/syscall.c#L98)

```c
static int sys_close(uint64_t arg[])
```

- [sys_read](kern/syscall/syscall.c#L105)

```c
static int sys_read(uint64_t arg[])
```

- [sys_write](kern/syscall/syscall.c#L114)

```c
static int sys_write(uint64_t arg[])
```

- [sys_seek](kern/syscall/syscall.c#L123)

```c
static int sys_seek(uint64_t arg[])
```

- [sys_fstat](kern/syscall/syscall.c#L132)

```c
static int sys_fstat(uint64_t arg[])
```

- [sys_fsync](kern/syscall/syscall.c#L140)

```c
static int sys_fsync(uint64_t arg[])
```

- [sys_getcwd](kern/syscall/syscall.c#L147)

```c
static int sys_getcwd(uint64_t arg[])
```

- [sys_getdirentry](kern/syscall/syscall.c#L155)

```c
static int sys_getdirentry(uint64_t arg[])
```

- [sys_dup](kern/syscall/syscall.c#L163)

```c
static int sys_dup(uint64_t arg[])
```

- [syscall](kern/syscall/syscall.c#L197)

```c
void syscall(void)
```

</details>

### kern/syscall/syscall.h
**文件作用**：内核系统调用分发与文件系统相关 syscall 入口。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/process/proc.c
**文件作用**：进程结构扩展与文件系统状态（fs_struct）相关支持。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `alloc_proc` | [proc.c#L88](kern/process/proc.c#L88) | // alloc_proc - alloc a proc_struct and init all fields of proc_struct<br><br><b>中文解释</b><br>alloc_proc：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：从空闲资源集合（如位图/缓存）选择一个可用项并标记为已占用。 |
| `set_proc_name` | [proc.c#L165](kern/process/proc.c#L165) | // set_proc_name - set the name of proc<br><br><b>中文解释</b><br>set_proc_name：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `get_proc_name` | [proc.c#L173](kern/process/proc.c#L173) | // get_proc_name - get the name of proc<br><br><b>中文解释</b><br>get_proc_name：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `set_links` | [proc.c#L182](kern/process/proc.c#L182) | // set_links - set the relation links of process<br><br><b>中文解释</b><br>set_links：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `remove_links` | [proc.c#L196](kern/process/proc.c#L196) | // remove_links - clean the relation links of process<br><br><b>中文解释</b><br>remove_links：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `get_pid` | [proc.c#L216](kern/process/proc.c#L216) | // get_pid - alloc a unique pid for process<br><br><b>中文解释</b><br>get_pid：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `proc_run` | [proc.c#L260](kern/process/proc.c#L260) | // proc_run - make process "proc" running on cpu<br>// NOTE: before call switch_to, should load  base addr of "proc"'s new PDT<br><br><b>中文解释</b><br>proc_run：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `forkret` | [proc.c#L296](kern/process/proc.c#L296) | // forkret -- the first kernel entry point of a new thread/process<br>// NOTE: the addr of forkret is setted in copy_thread function<br>//       after switch_to, the current proc will execute here.<br><br><b>中文解释</b><br>forkret：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `hash_proc` | [proc.c#L303](kern/process/proc.c#L303) | // hash_proc - add proc into proc hash_list<br><br><b>中文解释</b><br>hash_proc：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `unhash_proc` | [proc.c#L310](kern/process/proc.c#L310) | // unhash_proc - delete proc from proc hash_list<br><br><b>中文解释</b><br>unhash_proc：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `find_proc` | [proc.c#L317](kern/process/proc.c#L317) | // find_proc - find proc frome proc hash_list according to pid<br><br><b>中文解释</b><br>find_proc：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `int` | [proc.c#L338](kern/process/proc.c#L338) | // kernel_thread - create a kernel thread using "fn" function<br>// NOTE: the contents of temp trapframe tf will be copied to<br>//       proc->tf in do_fork-->copy_thread function<br><br><b>中文解释</b><br>int：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `setup_kstack` | [proc.c#L350](kern/process/proc.c#L350) | // setup_kstack - alloc pages with size KSTACKPAGE as process kernel stack<br><br><b>中文解释</b><br>setup_kstack：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `put_kstack` | [proc.c#L363](kern/process/proc.c#L363) | // put_kstack - free the memory space of process kernel stack<br><br><b>中文解释</b><br>put_kstack：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `setup_pgdir` | [proc.c#L370](kern/process/proc.c#L370) | // setup_pgdir - alloc one page as PDT<br><br><b>中文解释</b><br>setup_pgdir：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `put_pgdir` | [proc.c#L386](kern/process/proc.c#L386) | // put_pgdir - free the memory space of PDT<br><br><b>中文解释</b><br>put_pgdir：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `copy_mm` | [proc.c#L394](kern/process/proc.c#L394) | // copy_mm - process "proc" duplicate OR share process "current"'s mm according clone_flags<br>//         - if clone_flags & CLONE_VM, then "share" ; else "duplicate"<br><br><b>中文解释</b><br>copy_mm：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `copy_thread` | [proc.c#L445](kern/process/proc.c#L445) | // copy_thread - setup the trapframe on the  process's kernel stack top and<br>//             - setup the kernel entry point and stack of process<br><br><b>中文解释</b><br>copy_thread：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `copy_files` | [proc.c#L460](kern/process/proc.c#L460) | // copy_files&put_files function used by do_fork in LAB8<br>// copy the files_struct from current to proc<br><br><b>中文解释</b><br>copy_files：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `put_files` | [proc.c#L495](kern/process/proc.c#L495) | // decrease the ref_count of files, and if ref_count==0, then destroy files_struct<br><br><b>中文解释</b><br>put_files：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `do_fork` | [proc.c#L513](kern/process/proc.c#L513) | /* do_fork -     parent process for a new child process<br> * @clone_flags: used to guide how to clone the child process<br> * @stack:       the parent's user stack pointer. if stack==0, It means to fork a kernel thread.<br> * @tf:          the trapframe info, which will be copied to child process's proc->tf<br> */<br><br><b>中文解释</b><br>do_fork：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `do_exit` | [proc.c#L587](kern/process/proc.c#L587) | // do_exit - called by sys_exit<br>//   1. call exit_mmap & put_pgdir & mm_destroy to free the almost all memory space of process<br>//   2. set process' state as PROC_ZOMBIE, then call wakeup_proc(parent) to ask parent reclaim itself.<br>//   3. call scheduler to switch to other process<br><br><b>中文解释</b><br>do_exit：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `load_icode_read` | [proc.c#L648](kern/process/proc.c#L648) | // load_icode_read is used by load_icode in LAB8<br><br><b>中文解释</b><br>load_icode_read：（该句为实现细节/定义说明，建议结合源码阅读。）<br>逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。 |
| `load_icode` | [proc.c#L665](kern/process/proc.c#L665) | // load_icode -  called by sys_exec-->do_execve<br><br><b>中文解释</b><br>load_icode：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `put_kargv` | [proc.c#L990](kern/process/proc.c#L990) | // this function isn't very correct in LAB8<br><br><b>中文解释</b><br>put_kargv：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `copy_kargv` | [proc.c#L999](kern/process/proc.c#L999) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `do_execve` | [proc.c#L1032](kern/process/proc.c#L1032) | // do_execve - call exit_mmap(mm)&put_pgdir(mm) to reclaim memory space of current process<br>//           - call load_icode to setup new memory space accroding binary prog.<br><br><b>中文解释</b><br>do_execve：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `do_yield` | [proc.c#L1105](kern/process/proc.c#L1105) | // do_yield - ask the scheduler to reschedule<br><br><b>中文解释</b><br>do_yield：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `do_wait` | [proc.c#L1114](kern/process/proc.c#L1114) | // do_wait - wait one OR any children with PROC_ZOMBIE state, and free memory space of kernel stack<br>//         - proc struct of this child.<br>// NOTE: only after do_wait function, all resources of the child proces are free.<br><br><b>中文解释</b><br>do_wait：该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。 |
| `do_kill` | [proc.c#L1186](kern/process/proc.c#L1186) | // do_kill - kill process with pid by set this process's flags with PF_EXITING<br><br><b>中文解释</b><br>do_kill：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `kernel_execve` | [proc.c#L1206](kern/process/proc.c#L1206) | // kernel_execve - build a new trapframe, execute do_execve in-kernel, and return to user mode via __trapret<br><br><b>中文解释</b><br>kernel_execve：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `user_main` | [proc.c#L1244](kern/process/proc.c#L1244) | // user_main - kernel thread used to exec a user program<br><br><b>中文解释</b><br>user_main：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `init_main` | [proc.c#L1260](kern/process/proc.c#L1260) | // init_main - the second kernel thread used to create user_main kernel threads<br><br><b>中文解释</b><br>init_main：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `proc_init` | [proc.c#L1298](kern/process/proc.c#L1298) | // proc_init - set up the first kernel thread idleproc "idle" by itself and<br>//           - create the second kernel thread init_main<br><br><b>中文解释</b><br>proc_init：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `cpu_idle` | [proc.c#L1343](kern/process/proc.c#L1343) | // cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works<br><br><b>中文解释</b><br>cpu_idle：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `lab6_set_priority` | [proc.c#L1354](kern/process/proc.c#L1354) | // FOR LAB6, set the process's priority (bigger value will get more CPU time)<br><br><b>中文解释</b><br>lab6_set_priority：（该句为实现细节/定义说明，建议结合源码阅读。） |
| `do_sleep` | [proc.c#L1364](kern/process/proc.c#L1364) | // do_sleep - set current process state to sleep and add timer with "time"<br>//          - then call scheduler. if process run again, delete timer first.<br><br><b>中文解释</b><br>do_sleep：（该句为实现细节/定义说明，建议结合源码阅读。）<br>（该句为实现细节/定义说明，建议结合源码阅读。） |

<details><summary>函数签名（展开查看）</summary>

- [alloc_proc](kern/process/proc.c#L88)

```c
static struct proc_struct * alloc_proc(void)
```

- [set_proc_name](kern/process/proc.c#L165)

```c
char * set_proc_name(struct proc_struct *proc, const char *name)
```

- [get_proc_name](kern/process/proc.c#L173)

```c
char * get_proc_name(struct proc_struct *proc)
```

- [set_links](kern/process/proc.c#L182)

```c
static void set_links(struct proc_struct *proc)
```

- [remove_links](kern/process/proc.c#L196)

```c
static void remove_links(struct proc_struct *proc)
```

- [get_pid](kern/process/proc.c#L216)

```c
static int get_pid(void)
```

- [proc_run](kern/process/proc.c#L260)

```c
void proc_run(struct proc_struct *proc)
```

- [forkret](kern/process/proc.c#L296)

```c
static void forkret(void)
```

- [hash_proc](kern/process/proc.c#L303)

```c
static void hash_proc(struct proc_struct *proc)
```

- [unhash_proc](kern/process/proc.c#L310)

```c
static void unhash_proc(struct proc_struct *proc)
```

- [find_proc](kern/process/proc.c#L317)

```c
struct proc_struct * find_proc(int pid)
```

- [int](kern/process/proc.c#L338)

```c
int kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags)
```

- [setup_kstack](kern/process/proc.c#L350)

```c
static int setup_kstack(struct proc_struct *proc)
```

- [put_kstack](kern/process/proc.c#L363)

```c
static void put_kstack(struct proc_struct *proc)
```

- [setup_pgdir](kern/process/proc.c#L370)

```c
static int setup_pgdir(struct mm_struct *mm)
```

- [put_pgdir](kern/process/proc.c#L386)

```c
static void put_pgdir(struct mm_struct *mm)
```

- [copy_mm](kern/process/proc.c#L394)

```c
static int copy_mm(uint32_t clone_flags, struct proc_struct *proc)
```

- [copy_thread](kern/process/proc.c#L445)

```c
static void copy_thread(struct proc_struct *proc, uintptr_t esp, struct trapframe *tf)
```

- [copy_files](kern/process/proc.c#L460)

```c
static int copy_files(uint32_t clone_flags, struct proc_struct *proc)
```

- [put_files](kern/process/proc.c#L495)

```c
static void put_files(struct proc_struct *proc)
```

- [do_fork](kern/process/proc.c#L513)

```c
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
```

- [do_exit](kern/process/proc.c#L587)

```c
int do_exit(int error_code)
```

- [load_icode_read](kern/process/proc.c#L648)

```c
static int load_icode_read(int fd, void *buf, size_t len, off_t offset)
```

- [load_icode](kern/process/proc.c#L665)

```c
static int load_icode(int fd, int argc, char **kargv)
```

- [put_kargv](kern/process/proc.c#L990)

```c
static void put_kargv(int argc, char **kargv)
```

- [copy_kargv](kern/process/proc.c#L999)

```c
static int copy_kargv(struct mm_struct *mm, int argc, char **kargv, const char **argv)
```

- [do_execve](kern/process/proc.c#L1032)

```c
int do_execve(const char *name, int argc, const char **argv)
```

- [do_yield](kern/process/proc.c#L1105)

```c
int do_yield(void)
```

- [do_wait](kern/process/proc.c#L1114)

```c
int do_wait(int pid, int *code_store)
```

- [do_kill](kern/process/proc.c#L1186)

```c
int do_kill(int pid)
```

- [kernel_execve](kern/process/proc.c#L1206)

```c
static int kernel_execve(const char *name, const char **argv)
```

- [user_main](kern/process/proc.c#L1244)

```c
static int user_main(void *arg)
```

- [init_main](kern/process/proc.c#L1260)

```c
static int init_main(void *arg)
```

- [proc_init](kern/process/proc.c#L1298)

```c
void proc_init(void)
```

- [cpu_idle](kern/process/proc.c#L1343)

```c
void cpu_idle(void)
```

- [lab6_set_priority](kern/process/proc.c#L1354)

```c
void lab6_set_priority(uint32_t priority)
```

- [do_sleep](kern/process/proc.c#L1364)

```c
int do_sleep(unsigned int time)
```

</details>

### kern/process/proc.h
**文件作用**：进程结构扩展与文件系统状态（fs_struct）相关支持。

（未检测到函数定义，或本文件主要为结构/宏定义。）

### kern/init/init.c
**文件作用**：内核初始化：包含文件系统初始化调用。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `kern_init` | [init.c#L21](kern/init/init.c#L21) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [kern_init](kern/init/init.c#L21)

```c
int kern_init(void)
```

</details>

### tools/mksfs.c
**文件作用**：辅助工具：构造 SFS 磁盘镜像（理解布局/元数据很有帮助）。

| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |
|---|---:|---|
| `__hash32` | [mksfs.c#L42](tools/mksfs.c#L42) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `hash32` | [mksfs.c#L48](tools/mksfs.c#L48) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `hash64` | [mksfs.c#L53](tools/mksfs.c#L53) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `safe_malloc` | [mksfs.c#L58](tools/mksfs.c#L58) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `safe_strdup` | [mksfs.c#L67](tools/mksfs.c#L67) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `safe_stat` | [mksfs.c#L76](tools/mksfs.c#L76) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `safe_fstat` | [mksfs.c#L85](tools/mksfs.c#L85) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `safe_lstat` | [mksfs.c#L94](tools/mksfs.c#L94) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `safe_fchdir` | [mksfs.c#L103](tools/mksfs.c#L103) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `sfs_alloc_ino` | [mksfs.c#L173](tools/mksfs.c#L173) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `alloc_cache_block` | [mksfs.c#L182](tools/mksfs.c#L182) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `search_cache_block` | [mksfs.c#L192](tools/mksfs.c#L192) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `alloc_cache_inode` | [mksfs.c#L201](tools/mksfs.c#L201) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `search_cache_inode` | [mksfs.c#L214](tools/mksfs.c#L214) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `create_sfs` | [mksfs.c#L223](tools/mksfs.c#L223) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `subpath_push` | [mksfs.c#L256](tools/mksfs.c#L256) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `subpath_pop` | [mksfs.c#L266](tools/mksfs.c#L266) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `subpath_show` | [mksfs.c#L274](tools/mksfs.c#L274) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `write_block` | [mksfs.c#L287](tools/mksfs.c#L287) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `flush_cache_block` | [mksfs.c#L302](tools/mksfs.c#L302) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `flush_cache_inode` | [mksfs.c#L307](tools/mksfs.c#L307) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `close_sfs` | [mksfs.c#L312](tools/mksfs.c#L312) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `open_img` | [mksfs.c#L351](tools/mksfs.c#L351) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `update_cache` | [mksfs.c#L382](tools/mksfs.c#L382) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `append_block` | [mksfs.c#L397](tools/mksfs.c#L397) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `add_entry` | [mksfs.c#L428](tools/mksfs.c#L428) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `add_dir` | [mksfs.c#L439](tools/mksfs.c#L439) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `add_file` | [mksfs.c#L449](tools/mksfs.c#L449) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `add_link` | [mksfs.c#L459](tools/mksfs.c#L459) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `open_dir` | [mksfs.c#L466](tools/mksfs.c#L466) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `open_file` | [mksfs.c#L516](tools/mksfs.c#L516) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `open_link` | [mksfs.c#L532](tools/mksfs.c#L532) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `create_img` | [mksfs.c#L544](tools/mksfs.c#L544) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `static_check` | [mksfs.c#L561](tools/mksfs.c#L561) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |
| `main` | [mksfs.c#L569](tools/mksfs.c#L569) | （建议直接点链接阅读实现细节；本函数缺少紧邻注释。） |

<details><summary>函数签名（展开查看）</summary>

- [__hash32](tools/mksfs.c#L42)

```c
static inline uint32_t __hash32(uint32_t val, unsigned int bits)
```

- [hash32](tools/mksfs.c#L48)

```c
static uint32_t hash32(uint32_t val)
```

- [hash64](tools/mksfs.c#L53)

```c
static uint32_t hash64(uint64_t val)
```

- [safe_malloc](tools/mksfs.c#L58)

```c
void * safe_malloc(size_t size)
```

- [safe_strdup](tools/mksfs.c#L67)

```c
char * safe_strdup(const char *str)
```

- [safe_stat](tools/mksfs.c#L76)

```c
struct stat * safe_stat(const char *filename)
```

- [safe_fstat](tools/mksfs.c#L85)

```c
struct stat * safe_fstat(int fd)
```

- [safe_lstat](tools/mksfs.c#L94)

```c
struct stat * safe_lstat(const char *name)
```

- [safe_fchdir](tools/mksfs.c#L103)

```c
void safe_fchdir(int fd)
```

- [sfs_alloc_ino](tools/mksfs.c#L173)

```c
static uint32_t sfs_alloc_ino(struct sfs_fs *sfs)
```

- [alloc_cache_block](tools/mksfs.c#L182)

```c
static struct cache_block * alloc_cache_block(struct sfs_fs *sfs, uint32_t ino)
```

- [search_cache_block](tools/mksfs.c#L192)

```c
struct cache_block * search_cache_block(struct sfs_fs *sfs, uint32_t ino)
```

- [alloc_cache_inode](tools/mksfs.c#L201)

```c
static struct cache_inode * alloc_cache_inode(struct sfs_fs *sfs, ino_t real, uint32_t ino, uint16_t type)
```

- [search_cache_inode](tools/mksfs.c#L214)

```c
struct cache_inode * search_cache_inode(struct sfs_fs *sfs, ino_t real)
```

- [create_sfs](tools/mksfs.c#L223)

```c
struct sfs_fs * create_sfs(int imgfd)
```

- [subpath_push](tools/mksfs.c#L256)

```c
static void subpath_push(struct sfs_fs *sfs, const char *subname)
```

- [subpath_pop](tools/mksfs.c#L266)

```c
static void subpath_pop(struct sfs_fs *sfs)
```

- [subpath_show](tools/mksfs.c#L274)

```c
static void subpath_show(FILE *fout, struct sfs_fs *sfs, const char *name)
```

- [write_block](tools/mksfs.c#L287)

```c
static void write_block(struct sfs_fs *sfs, void *data, size_t len, uint32_t ino)
```

- [flush_cache_block](tools/mksfs.c#L302)

```c
static void flush_cache_block(struct sfs_fs *sfs, struct cache_block *cb)
```

- [flush_cache_inode](tools/mksfs.c#L307)

```c
static void flush_cache_inode(struct sfs_fs *sfs, struct cache_inode *ci)
```

- [close_sfs](tools/mksfs.c#L312)

```c
void close_sfs(struct sfs_fs *sfs)
```

- [open_img](tools/mksfs.c#L351)

```c
struct sfs_fs * open_img(const char *imgname)
```

- [update_cache](tools/mksfs.c#L382)

```c
static void update_cache(struct sfs_fs *sfs, struct cache_block **cbp, uint32_t *inop)
```

- [append_block](tools/mksfs.c#L397)

```c
static void append_block(struct sfs_fs *sfs, struct cache_inode *file, size_t size, uint32_t ino, const char *filename)
```

- [add_entry](tools/mksfs.c#L428)

```c
static void add_entry(struct sfs_fs *sfs, struct cache_inode *current, struct cache_inode *file, const char *name)
```

- [add_dir](tools/mksfs.c#L439)

```c
static void add_dir(struct sfs_fs *sfs, struct cache_inode *parent, const char *dirname, int curfd, int fd, ino_t real)
```

- [add_file](tools/mksfs.c#L449)

```c
static void add_file(struct sfs_fs *sfs, struct cache_inode *current, const char *filename, int fd, ino_t real)
```

- [add_link](tools/mksfs.c#L459)

```c
static void add_link(struct sfs_fs *sfs, struct cache_inode *current, const char *filename, ino_t real)
```

- [open_dir](tools/mksfs.c#L466)

```c
void open_dir(struct sfs_fs *sfs, struct cache_inode *current, struct cache_inode *parent)
```

- [open_file](tools/mksfs.c#L516)

```c
void open_file(struct sfs_fs *sfs, struct cache_inode *file, const char *filename, int fd)
```

- [open_link](tools/mksfs.c#L532)

```c
void open_link(struct sfs_fs *sfs, struct cache_inode *file, const char *filename)
```

- [create_img](tools/mksfs.c#L544)

```c
int create_img(struct sfs_fs *sfs, const char *home)
```

- [static_check](tools/mksfs.c#L561)

```c
static void static_check(void)
```

- [main](tools/mksfs.c#L569)

```c
int main(int argc, char **argv)
```

</details>

