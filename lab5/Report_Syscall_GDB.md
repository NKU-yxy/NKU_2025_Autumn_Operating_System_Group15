# Lab5 分支实验报告：GDB 观测系统调用进入与返回（`ecall` / `sret`）

> 说明：本报告基于你本次已完成的“客体侧（ucore）GDB 调试”结果撰写，包含可复现步骤、关键输出与机制解释；“双重 GDB（宿主侧调 QEMU 源码/TCG）”将作为后续扩展部分。

---

## 1. 实验目的

- 观测一次完整的系统调用控制流：用户态（U-mode）执行 `ecall` → 陷入内核态（S-mode）→ 内核分发并执行 syscall → 在 trap 返回路径执行 `sret` 返回用户态。
- 通过 GDB 采集关键证据：`scause/sepc/sstatus` 以及 `trapframe` 中 `epc/cause/寄存器参数`，并解释 `epc += 4` 的必要性。
- 记录调试中的典型问题（无法在用户态虚拟地址直接下断点）与解决方案。

---

## 2. 实验环境

- OS：Ubuntu 24.04.3 LTS
- QEMU：4.1.1
- 客体调试器：GNU gdb (SiFive GDB-Metal 10.1.0-2020.12.7)（target=riscv64-unknown-elf）
- uCore：本仓库 Lab5

补充说明：当前系统使用的 QEMU 为 `/usr/local/bin/qemu-system-riscv64`，且二进制为 stripped（无调试符号）。因此本报告先覆盖 uCore 内核侧系统调用观测；后续如需在宿主侧 GDB 中按源码跟踪 QEMU，需要另编译带符号的 QEMU 4.1.1。

---

## 3. 背景知识（简述）

### 3.1 为什么需要系统调用

用户态程序运行在受限特权级（U-mode），无法直接执行需要特权的操作（例如访问设备、修改页表等）。当用户程序需要内核服务时，通过系统调用触发陷入，让 CPU 切换到更高特权级（S-mode）执行内核代码。

### 3.2 RISC-V 上 `ecall` 与 `sret`

- `ecall`：触发环境调用异常。若在 U-mode 执行，通常产生 `scause = CAUSE_USER_ECALL`。
- `sret`：从 S-mode 返回到 `sepc` 指定的地址，并按照 `sstatus` 的相关位恢复特权级与中断使能。

---

## 4. 关键代码位置

- 用户态系统调用封装（最终执行 `ecall`）：[lab5/user/libs/syscall.c](user/libs/syscall.c)
- trap 保存/恢复现场与 `sret`： [lab5/kern/trap/trapentry.S](kern/trap/trapentry.S)
  - `__alltraps`：保存现场后跳转到 `trap`
  - `__trapret`：恢复现场并执行 `sret`
- 异常处理（含 `CAUSE_USER_ECALL` 分支与 `tf->epc += 4`）：[lab5/kern/trap/trap.c](kern/trap/trap.c)
- 异常号定义（`CAUSE_USER_ECALL=0x8`、`CAUSE_BREAKPOINT=0x3`）：[lab5/libs/riscv.h](libs/riscv.h)

---

## 5. 实验方法与调试策略

### 5.1 为什么不直接在用户态 `syscall()` 下断点

尝试对用户态源码行（如 `user/libs/syscall.c:8`）下断点时，GDB 报错：`Cannot access memory at address 0x8000d8`。

原因（核心点）：远程调试（QEMU gdbstub）在插入断点时往往需要访问目标地址的内存（读取/写入断点指令）。如果此时 CPU 仍处于内核态或当前地址空间对用户态 0x8000xx 区间不可访问，gdbstub 就无法完成断点插入。

因此本实验采用更稳健的做法：**在内核异常处理函数 `exception_handler(tf)` 下断点，并加条件 `tf->cause == 0x8`，只捕获用户态 `ecall` 陷入。**

### 5.2 条件断点捕获用户态 `ecall`

- 在 `exception_handler` 下断点
- 通过 `cond <bpnum> tf->cause == 0x8` 过滤，仅当异常类型为用户态 ecall 时停住

这能稳定捕获系统调用进入内核的瞬间，不依赖用户态地址能否被 gdbstub 直接访问。

---

## 6. 复现实验步骤（命令级）

### 6.1 启动 QEMU（等待 GDB 连接）

在 lab5 目录：

```bash
make debug
```

该目标在 QEMU 启动参数中包含 `-s -S`：
- `-s`：开启 gdbstub（默认 1234）
- `-S`：CPU 上电后暂停，等待 GDB 控制

### 6.2 连接 GDB 并设置断点

使用项目提供的 gdbinit：

```bash
riscv64-unknown-elf-gdb -x tools/gdbinit
```

然后在 GDB 中执行：

```gdb
break exception_handler
cond 2 tf->cause == 0x8
info break
```

（其中 `2` 是 GDB 回显的断点编号；可用 `info break` 确认条件生效。）

可选：为避免频繁停在 `kern_init`：

```gdb
disable 1
```

随后继续执行：

```gdb
c
```

---

## 7. 关键观测结果与分析（基于本次真实输出）

### 7.1 进入内核：捕获用户态 `ecall`（U→S）

在条件断点命中后，得到如下关键证据：

```gdb
(gdb) p/x tf->cause
$1 = 0x8

(gdb) p/x tf->epc
$2 = 0x800104

(gdb) x/6i tf->epc
   0x800104:    ecall
   0x800108:    sd      a0,28(sp)
   0x80010c:    lw      a0,28(sp)
   0x80010e:    addi    sp,sp,144
   0x800110:    ret
   0x800112:    mv      a1,a0
```

解释：
- `tf->cause = 0x8` 对应 `CAUSE_USER_ECALL`，说明异常来自用户态环境调用。
- `tf->epc = 0x800104` 且该地址处指令为 `ecall`，说明陷入点正是用户态 `ecall`。

### 7.2 系统调用号与参数传递（本项目的 ABI 特点）

本次观测到：

```gdb
(gdb) p/x tf->gpr.a0
$4 = 0x1e
(gdb) p/x tf->gpr.a1
$5 = 0x49
(gdb) p/x tf->gpr.a2
$6 = 0x800968
(gdb) p/x tf->gpr.a3
$7 = 0x7fffff98
(gdb) p/x tf->gpr.a4
$9 = 0x0
(gdb) p/x tf->gpr.a5
$10 = 0x0
(gdb) p/x tf->gpr.a7
$11 = 0x0
```

结合 [lab5/user/libs/syscall.c](user/libs/syscall.c) 的实现（将 syscall 号 `num` 装入 `a0`，参数装入 `a1..a5`，再执行 `ecall`）：
- 本项目的 syscall 号来源于 `a0`（而不是类 Linux 的 `a7`）。
- 因此观测到 `a7=0` 并不矛盾。

### 7.3 内核为何要执行 `epc += 4`

在 [lab5/kern/trap/trap.c](kern/trap/trap.c) 的 `CAUSE_USER_ECALL` 分支，内核会先做：
- `tf->epc += 4;`

目的：让返回用户态时跳过 `ecall`，否则返回后会再次执行 `ecall`，导致无限陷入。

### 7.4 返回用户态：断到 `sret`（S→U）并验证返回地址

你在 `__trapret` 找到了 `sret` 指令并下断点：

```gdb
(gdb) disassemble __trapret
...
   0xffffffffc0200f3e <__trapret+86>:    sret
...

(gdb) b *0xffffffffc0200f3e
Breakpoint 3 at 0xffffffffc0200f3e
```

命中 `sret` 前，检查 CSR：

```gdb
(gdb) info reg sepc sstatus
sepc    0x800108
sstatus 0x8000000000046020

(gdb) x/6i $pc
=> 0xffffffffc0200f3e <__trapret+86>:   sret
```

执行 `sret`：

```gdb
(gdb) si
0x0000000000800108 in ?? ()

(gdb) si
0x000000000080010c in ?? ()

(gdb) si
0x000000000080010e in ?? ()

(gdb) si
0x0000000000800110 in ?? ()
```

解释：
- `sepc=0x800108` 表明返回地址已是 `ecall` 的下一条指令（对 `epc += 4` 的直接验证）。
- `sret` 执行后 PC 回到 `0x800108`，并继续执行用户态 `sd/lw/ret` 指令序列，证明系统调用返回路径闭环成立。

---

## 8. 调试过程中的“坑”与经验总结

### 8.1 `scause=0x3`（breakpoint）不是 ecall

早期可能在 `__alltraps` 捕获到 `scause=0x3`，这对应 `CAUSE_BREAKPOINT`。在本项目中，内核某些路径（如内核通过断点机制触发的流程）会导致 breakpoint 异常出现。

解决：用条件断点过滤到 `CAUSE_USER_ECALL=0x8`，精准抓用户态系统调用。

### 8.2 用户态断点“无法访问内存”的根因

这是远程调试常见现象：断点插入依赖 gdbstub 对目标地址可读/可写，但在内核态或页表未覆盖用户区时，用户态虚拟地址可能不可访问。

解决：将“观测点”改为内核侧 `exception_handler(tf)`，通过 `tf->cause` 过滤事件类型。

---

## 9. 实验结论

- 成功观测到：用户态 `ecall` 触发异常进入内核（`tf->cause=0x8`），陷入点位于 `tf->epc=0x800104`，且该地址处指令确为 `ecall`。
- 成功验证：内核对 `tf->epc` 执行 `+4`，导致 `sret` 前 `sepc=0x800108`，返回用户态后 PC 也确实回到 `0x800108`，避免重复陷入。
- 成功验证：`sret` 位于 `__trapret`，执行后控制流回用户态并继续执行 `ecall` 之后的用户指令。
- 观测到本项目的 syscall ABI：syscall 号来自 `a0`，而非 `a7`。

---

## 10. 后续扩展（双重 GDB + QEMU 源码/TCG，计划）

由于当前 QEMU 二进制 stripped，宿主侧 GDB 难以按源码定位。

后续计划：编译带符号的 QEMU 4.1.1（开启 debug、禁用 strip），再用“双重 GDB”同步观测：
- 在客体侧停在用户态 `ecall` 前/或内核 `sret` 前
- 在宿主侧断到 QEMU 的 RISC-V 翻译/异常处理代码（`target/riscv/translate.c` 与 helper 逻辑）
- 解释 QEMU 的 TCG translation 如何把 `ecall/sret` 翻译成 helper 调用并正确模拟特权切换

---

## 附录 A：本次关键 GDB 命令清单

```gdb
# 1) 连接后：在异常处理处下断点并过滤 user ecall
break exception_handler
cond 2 tf->cause == 0x8

# 2) 命中后：采集证据
p/x tf->cause
p/x tf->epc
x/6i tf->epc
p/x tf->status
p/x tf->gpr.a0
p/x tf->gpr.a1
p/x tf->gpr.a2
p/x tf->gpr.a3
p/x tf->gpr.a4
p/x tf->gpr.a5
p/x tf->gpr.a7

# 3) 找到并断住 sret
disassemble __trapret
b *0xffffffffc0200f3e   # 以实际反汇编地址为准
info reg sepc sstatus
x/6i $pc
si
```
