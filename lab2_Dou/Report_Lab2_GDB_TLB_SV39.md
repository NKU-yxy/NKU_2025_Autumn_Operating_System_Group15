# Lab2：双重 GDB 观测 QEMU 地址翻译（TLB + SV39 页表遍历）简略报告

## 1. 实验目的

- 在 **QEMU 源码层**观察一次典型的地址翻译流程：
  - 先查 TLB
  - TLB miss 后触发 **SV39 页表 walk**
  - 回填 TLB（TLB fill）
- 在 **uCore 内核侧**通过 gdbstub 控制执行节奏，保证观测过程可复现。

## 2. 实验环境

- Host：Linux（bash）
- QEMU：4.1.1（自行编译 debug 版，带符号、未 strip）
- Host GDB：`gdb`（x86_64，用于调 QEMU 源码）
- Guest GDB：`riscv64-unknown-elf-gdb`（连接 QEMU gdbstub，调 uCore）
- 工程目录：`lab2_Dou/`

## 3. 实验准备

### 3.1 编译

在 `lab2_Dou` 目录编译镜像：

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab2_Dou
make clean && make
```

预期产物：
- `bin/ucore.img`
- `bin/kernel`

### 3.2 端口检查（避免 -s 端口占用）

QEMU `-s` 默认监听 `:1234`。如果端口被占用，`make debug` 会报：`-s: Address already in use`。

排查并释放端口：

```bash
ss -ltnp | grep ':1234' || true
# 若看到 qemu-system-riscv64 pid=XXXX
kill XXXX
# 仍占用再强制
kill -9 XXXX
```

## 4. 复现步骤（三终端）

> 说明：宿主 gdb 断住 QEMU 时，客体 gdb 会暂时“卡住”（因为 gdbstub 在 QEMU 进程内），属于正常现象。

### 终端 A：启动 QEMU（gdbstub，CPU 先暂停）

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab2_Dou
make debug
```

Makefile 的 `debug` 目标等价于（核心点）：
- 启动 `qemu-system-riscv64 ... -s -S`
- `-s` 开 gdbstub 端口 `1234`
- `-S` 让 CPU 暂停等待调试器

### 终端 B：客体 GDB（调 uCore）

使用仓库自带目标：

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab2_Dou
make gdb
```

可选手工方式：

```bash
riscv64-unknown-elf-gdb \
  -ex 'file bin/kernel' \
  -ex 'set arch riscv:rv64' \
  -ex 'target remote localhost:1234'
```

在 guest gdb 中设置断点并运行：

```gdb
break kern_init
continue
```

当停在 `kern_init` 后，可以继续 `continue` 让系统跑起来，从而触发更多内存访问/指令取指，方便观察翻译。

### 终端 C：宿主 GDB（调 QEMU 源码）

#### 方式 1：推荐（直接用带符号的 QEMU 启动）

```bash
cd /home/doufuru/OS/NKU_2025_Autumn_Operating_System_Group15/lab2_Dou

gdb --args /path/to/qemu-system-riscv64 \
  -machine virt -nographic -bios default \
  -device loader,file=bin/ucore.img,addr=0x80200000 \
  -s -S
```

在宿主 gdb 中设置关键断点：

```gdb
set pagination off
set breakpoint pending on

# TLB miss 入口：最终会走到页表遍历
break riscv_cpu_tlb_fill

# SV39 页表 walk：读取 satp、逐级算 idx，读取 PTE
break get_physical_address

# TLB 回填：把 vaddr->paddr 映射写入 TLB
break tlb_set_page

# 可选：sfence.vma 等会触发，频繁；不建议默认开启
# break tlb_flush

run
```

#### 方式 2：attach 到已运行的 QEMU（适合你已经 `make debug` 起起来了）

```bash
pgrep -f qemu-system-riscv64
sudo gdb
```

进入 gdb 后：

```gdb
attach <PID>
break get_physical_address if env->satp != 0
continue
```

## 5. 关键观测点（应记录到报告/截图的证据）

### 5.1 命中 `riscv_cpu_tlb_fill`：证明发生 TLB miss

在宿主 gdb 停住后：

```gdb
bt
info args
p/x address
p access_type
p mmu_idx
```

含义：
- `address`：本次触发翻译的虚拟地址
- `access_type`：取指/读/写（不同版本命名略有差异）
- `mmu_idx`：当前特权级/地址空间上下文（与 S/U/M 等相关）

### 5.2 进入 `get_physical_address`：观察 SV39 三层页表遍历

在宿主 gdb 中打印 `satp`：

```gdb
p/x env->satp
```

预期现象：
- `SATP_MODE` 为 Sv39
- 从 `SATP_PPN << 12` 得到根页表基址 `base`
- 循环 `levels=3`：每层计算 `idx`（9bit），构造 `pte_addr = base + idx * 8`，读取 `pte`，再决定：
  - 非叶子：更新 `base = PTE.PPN << 12` 进入下一层
  - 叶子：组合得到最终物理页号（PPN）与权限（R/W/X/U 等）

为了清晰记录每一层的变化，可在循环关键行附近观察 `i/base/idx/pte`：

```gdb
# 到 for 循环内部后
info locals
# 单步/下一步让 i/base/idx/pte 更新
next
```

### 5.3 命中 `tlb_set_page`：证明 TLB 回填

在宿主 gdb：

```gdb
info args
```

预期能看到（命名随版本略不同）：
- 虚拟页起始地址
- 物理页起始地址
- 权限 prot
- size（页大小）

### 5.4 二次命中/命不中：说明 TLB hit 生效

继续运行后，同一地址/同一页的访问往往不会再进入 `riscv_cpu_tlb_fill`（直到 `sfence.vma`/上下文切换/淘汰等导致失效）。


## 6. 实验结论

通过宿主 gdb 在 QEMU 源码中命中 `riscv_cpu_tlb_fill → get_physical_address → tlb_set_page`，可以完整观测到一次 **TLB miss → SV39 页表遍历 → TLB 回填** 的模拟实现路径；结合客体 gdb 控制 uCore 执行点，使该过程可稳定复现。
