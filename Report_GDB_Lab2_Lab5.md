# GDB 调试综合报告（Lab2：TLB/SV39 翻译；Lab5：syscall ecall/sret）

本报告整合两次实验的 GDB 调试过程：
- **Lab2**：宿主侧调 QEMU 源码，观测地址翻译链路（TLB miss → SV39 页表遍历 → TLB 回填）。
- **Lab5**：客体侧调 uCore 内核，观测系统调用进入与返回（`ecall` → trap → `sret`）。

---

## 0. 通用说明：宿主（host）与客体（guest）

- **宿主（host）**：你的 Linux 环境；运行 QEMU 进程，使用 host `gdb` 调 QEMU 源码。
- **客体（guest）**：QEMU 内运行的 RISC-V uCore；使用 `riscv64-unknown-elf-gdb` 通过 gdbstub 连接调试。

重要现象：
- 当 **宿主 gdb attach/断住 QEMU** 时，QEMU 进程暂停，**客体 gdb 会表现为卡住**（因为 gdbstub 也停了），属于正常同步效应。

---

## 1. Lab2：双重 GDB 观测 QEMU 地址翻译（TLB + SV39）

### 1.1 实验目的

- 在 QEMU 源码层复现并观测：
  - TLB lookup
  - TLB miss 进入 `riscv_cpu_tlb_fill`
  - SV39 页表 walk 进入 `get_physical_address`
  - 成功后调用 `tlb_set_page` 完成 TLB fill

### 1.2 实验环境

- 目录：`lab2_Dou/`
- QEMU：4.1.1 debug 版（带符号、未 strip）
- 宿主调试器：`gdb`（x86_64）
- 客体调试器：`riscv64-unknown-elf-gdb`

### 1.3 复现步骤（三终端，按顺序逐条执行）

#### 终端 A（bash）：编译并启动 QEMU（gdbstub + 暂停）

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab2_Dou
make clean && make

# 端口检查：-s 默认占用 :1234
ss -ltnp | grep ':1234' || true
# 若被旧 qemu 占用，kill 对应 pid

make debug
```

说明：`make debug` 会以 `-s -S` 启动 QEMU。
- 看起来“卡住”是正常的：CPU 被 `-S` 暂停等待 gdb。
- **不要 Ctrl-C 终止**，否则 QEMU 直接退出、客体 gdb 会断连。

#### 终端 B（客体 gdb）：连接 gdbstub 并用断点控制节奏

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab2_Dou
make gdb
```

在 `(gdb)` 中：

```gdb
break kern_init
continue
```

到达 `kern_init` 后，可再 `continue` 让内核继续运行，以触发更多取指/访存，方便在宿主侧观测翻译。

#### 终端 C（宿主 gdb）：调 QEMU 源码（两种方式二选一）

**方式 1（推荐）：直接用宿主 gdb 启动 QEMU**

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab2_Dou

gdb --args /path/to/qemu-system-riscv64 \
  -machine virt -nographic -bios default \
  -device loader,file=bin/ucore.img,addr=0x80200000 \
  -s -S
```

在宿主 gdb 中：

```gdb
set pagination off
set breakpoint pending on

break riscv_cpu_tlb_fill
break get_physical_address
break tlb_set_page

run
```

**方式 2：attach 到“已经 make debug 启动”的 QEMU（你实际用过）**

```bash
pgrep -f qemu-system-riscv64
sudo gdb
```

在宿主 gdb 中：

```gdb
attach <PID>
handle SIGPIPE nostop noprint

# 只在分页开启后才抓（避免早期噪音）
break get_physical_address if env->satp != 0

continue
```

### 1.4 关键观测点（建议截图/记录）

#### 观测点 A：分页已开启（`env->satp != 0`）

在 `get_physical_address` 断住后：

```gdb
p/x env->satp
```

预期：
- `SATP_MODE` 为 Sv39
- `base = SATP_PPN << 12`（根页表物理基址）

#### 观测点 B：SV39 三层 walk（levels=3）

在 `get_physical_address` 内部继续单步，记录：
- `levels=3, ptidxbits=9, ptesize=8`
- 循环每层计算 `idx`（9-bit）
- 构造 `pte_addr = base + idx * 8` 并读取 `pte`
- 非叶子 PTE：更新 `base = PTE.PPN << 12` 进入下一层
- 叶子 PTE：得到最终 `physical` 与权限 `prot`

常用命令：

```gdb
bt
info args
info locals
next
```

#### 观测点 C：TLB fill（命中 `tlb_set_page`）

命中后：

```gdb
info args
```

预期能看到 vaddr/paddr/prot/mmu_idx/size 等参数（名称随版本略有差异）。

### 1.5 常见问题

- `-s: Failed to find an available port: Address already in use`
  - 说明 `:1234` 被旧 QEMU 占用；用 `ss -ltnp | grep 1234` 找 pid 后 `kill`。

- 终端 A “卡住”
  - 若是 `make debug`，这是 QEMU `-S` 等待调试器的正常现象；应去终端 B/C 连接并 `continue`。

---

## 2. Lab5：GDB 观测系统调用进入与返回（`ecall` / `sret`）

### 2.1 实验目的

- 观测：用户态执行 `ecall` → 进入内核 trap → 内核处理后在 trap 返回路径执行 `sret` → 回到用户态。
- 证明关键证据：
  - `tf->cause == 0x8 (CAUSE_USER_ECALL)`
  - `tf->epc` 指向 `ecall` 指令
  - 内核将 `tf->epc += 4`，使 `sret` 返回到 `ecall` 下一条

### 2.2 复现步骤（客体 gdb）

#### 终端 A：启动 QEMU（等待 gdb）

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab5
make debug
```

#### 终端 B：连接客体 gdb 并下条件断点

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab5
riscv64-unknown-elf-gdb -x tools/gdbinit
```

在 `(gdb)`：

```gdb
break exception_handler
cond 2 tf->cause == 0x8

# 如需避免频繁停在 kern_init：
# disable 1

continue
```

### 2.3 关键证据采集

#### 证据 A：捕获用户态 ecall 进入内核

命中后：

```gdb
p/x tf->cause
p/x tf->epc
x/6i tf->epc
```

预期：
- `tf->cause = 0x8`
- `tf->epc` 所在地址的指令反汇编第一条为 `ecall`

#### 证据 B：断到 `sret` 并验证返回地址

在 `__trapret` 中找到 `sret` 地址并断住：

```gdb
disassemble __trapret
b *<SRET_ADDR>
continue

info reg sepc sstatus
x/4i $pc

si
info reg pc
```

预期：
- `sepc == ecall_epc + 4`
- 单步执行 `sret` 后，`pc` 回到用户态返回地址。

### 2.4 调试经验

- 远程调试中直接对用户态虚拟地址下断点可能失败（gdbstub 插断点需要访问目标内存，可能因当时页表/特权级不可达）。
- 更稳的做法是在内核 `exception_handler(tf)` 下条件断点，按 `tf->cause` 精准过滤。

---

## 3. 总结

- Lab2 通过宿主 gdb 命中 QEMU 源码路径，可复现并解释 QEMU 对 SV39 翻译与 TLB fill 的模拟实现。
- Lab5 通过客体 gdb 在 uCore 内核侧捕获 `CAUSE_USER_ECALL` 并断到 `sret`，完成 `ecall → trap → sret` 的闭环验证。
