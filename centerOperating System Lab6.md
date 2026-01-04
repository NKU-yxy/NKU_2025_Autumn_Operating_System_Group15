# <center>Operating System Lab6

组员：禹相祐（2312900） 查科言（2312189） 董丰瑞（2311973）

分工：

练习0：董丰瑞

练习1：查科言

练习2：禹相祐

Challenge1：查科言

Challenge2：FIFO 查科言 SJF 董丰瑞

## 一、练习0：填写已有实验

> 本实验依赖实验2/3/4/5。请把你做的实验2/3/4/5的代码填入本实验中代码中有“LAB2”/“LAB3”/“LAB4”“LAB5”的注释相应部分。并确保编译通过。 注意：为了能够正确执行lab6的测试应用程序，可能需对已完成的实验2/3/4/5的代码进行进一步改进。 由于我们在进程控制块中记录了一些和调度有关的信息，例如Stride、优先级、时间片等等，因此我们需要对进程控制块的初始化进行更新，将调度有关的信息初始化。同时，由于时间片轮转的调度算法依赖于时钟中断，你可能也要对时钟中断的处理进行一定的更新

我们需要补充的之前实验的代码有：

- `kern/process/proc.c`：
  - 函数`alloc_proc`
  - 函数`do_fork`
  - 函数`load_icode`
- `kern/trap/trap.c`：
  - 函数`interrupt_handler`

而Lab6这次实验需要对之前实现的部分进行修改与扩充。

这是Lab6在`proc_struct`中的新增字段，如下：

```
struct run_queue *rq;                   
list_entry_t run_link;                  
int time_slice;                         
skew_heap_entry_t lab6_run_pool;        
uint32_t lab6_stride;                   
uint32_t lab6_priority;                 
```

我们按字段简短说明：

- `struct run_queue *rq`：指向当前所属的运行队列（就绪队列），不在队列时为 `NULL`。
  
- `list_entry_t run_link` ：进程挂在运行队列链表上的节点（RR/FIFO/SJF 等用的双向链表结点）。
  
- `int time_slice;` ：剩余时间片，时钟中断里递减，到 0 时触发需要重新调度。
  
- `skew_heap_entry_t lab6_run_pool` ：Stride 调度用的“斜堆节点”，用来把进程插入到 `rq->lab6_run_pool` 这个优先队列中。
  
- `uint32_t lab6_stride`  ：Stride 调度的累计步长，越小越优先；每次被选中都按 `BIG_STRIDE / lab6_priority` 增加。
  
- `uint32_t lab6_priority`  ：Stride 调度的权重，越大表示优先级越高（对应的 `lab6_stride` 增长越慢，占用 CPU 比例越大）。

我们在`proc.c`中的`alloc_proc`进行了初始化：

```c++
proc->rq = NULL;
list_init(&(proc->run_link));
proc->time_slice = 0;
skew_heap_init(&(proc->lab6_run_pool));
proc->lab6_stride = 0;//stride的调度步长，数值越小，优先级越高
proc->lab6_priority = 1;//Stride调度的权重优先级，
```

我们先把“调度相关状态”清成一个安全的初始态，后续真正入队/调度时再由调度器按算法赋值和更新。

- `proc->time_slice = 0`  初生进程不直接给时间片，等调度器 `enqueue` 时按 `rq->max_time_slice` 统一发放。

- `skew_heap_init(&(proc->lab6_run_pool))`  ：把 stride 用的斜堆节点清零，保证后面做堆插入/删除时结构正确。

- `proc->lab6_stride = 0`  ：所有新进程从同一 stride 起点开始，后续“谁被调度一次谁就涨一截”，由算法逐步拉开差距。

- `proc->lab6_priority = 1` ：我们默认给一个普通优先级；以后可以通过 `lab6_set_priority` 调高或调低，影响 stride 增长速率和 CPU 占比。

以及写好了一个`lab6_set_priority`函数

```c++
// FOR LAB6, set the process's priority (bigger value will get more CPU time)
void lab6_set_priority(uint32_t priority)
{
    cprintf("set priority to %d\n", priority);
    if (priority == 0)
        current->lab6_priority = 1;
    else
        current->lab6_priority = priority;
}
```

在`kern/trap/trap.c`中，我们在 `IRQ_S_TIMER` 分支后加了用于 LAB6 的调度钩子注释和代码。

```c++
{
        clock_set_next_event();
        ticks++;
        if (ticks % TICK_NUM == 0)
        {
            print_ticks();
            if (++num == 10)
            {
                sbi_shutdown();
            }
        }
        if (current != NULL)
        {
            // lab6: 在时钟中断中驱动调度器进行时间片处理
            sched_class_proc_tick(current);
        }
    }
```

`sched_class_proc_tick(current)`把“发生了一次时钟中断”这个事件交给当前调度类处理

## 二、练习1：理解调度器框架的实现

---

### 1. 调度器框架分析

#### （1）sched_class

```c++
struct sched_class
{
    const char *name;
    void (*init)(struct run_queue *rq);
    void (*enqueue)(struct run_queue *rq, struct proc_struct *proc);
    void (*dequeue)(struct run_queue *rq, struct proc_struct *proc);
    struct proc_struct *(*pick_next)(struct run_queue *rq);
    void (*proc_tick)(struct run_queue *rq, struct proc_struct *proc);
};
```

`sched_class` 是一个“调度类接口”，用一组函数指针把具体调度算法（RR/FIFO/SJF/Stride）封装起来：

- `const char *name` ：用于标识当前调度算法，方便 `sched_init` 打印、调试和成绩脚本识别。
- `void (*init)(struct run_queue *rq)` ：初始化运行队列，不同算法在这里搭建自己的数据结构：  
  - RR/FIFO/SJF：初始化 `rq->run_list` 为空链表，`rq->lab6_run_pool = NULL`；  
  - Stride：初始化 `rq->lab6_run_pool` 为空斜堆根，`run_list` 仅占位。
- `void (*enqueue)(struct run_queue *rq, struct proc_struct *proc)` ：将一个已处于 `PROC_RUNNABLE` 状态的进程挂入就绪队列 
  - 按算法要求插入 `rq`（链表头/尾、按 runs 排序、插入斜堆等）；  
  - 初始化该进程的 `proc->rq`、`proc->time_slice`；  
  - `rq->proc_num++`。
- `void (*dequeue)(struct run_queue *rq, struct proc_struct *proc)` ：把一个进程从就绪队列移除：  
  - 从链表/斜堆中删除相应节点；  
  - 将 `proc->rq = NULL`；  
  - `rq->proc_num--`。 
  一般在 `schedule()` 选中下一个要运行的进程之后立刻调用。
- `struct proc_struct *(*pick_next)(struct run_queue *rq);` ：从就绪队列中“选一个候选者”：  
  - RR/FIFO：取链表队头；  
  - SJF：在链表中线性扫描 `runs` 最小的进程；  
  - Stride：返回 `rq->lab6_run_pool` 堆顶对应的进程，并在内部更新它的 `lab6_stride`。 
  - 这个函数只负责“选”，不负责真正删出队列，由 `schedule()` 再调用 `dequeue`。
- `void (*proc_tick)(struct run_queue *rq, struct proc_struct *proc);` 
  每个时钟滴答（tick）发生时，对当前进程执行的调度逻辑：  
  - `proc->time_slice--`，为 0 时设置 `proc->need_resched = 1`；  

**为什么用函数指针而不是直接函数？**

- 调度器框架（`schedule`、`wakeup_proc` 等）只依赖这组统一接口，不需要知道“具体算法内部用什么数据结构”；  
- 我们可以很简单的通过切换 `sched_class` 指针，就可以在运行时选择不同调度算法，而无需改调度框架代码；  
- 后续我们再实现challenge里的新代码时，新算法只需实现同样签名的一组函数，扩展和对比实验非常方便。

---

#### （2）run_queue

`run_queue` 表示“当前所有处于就绪态的进程集合”。

```
struct run_queue
{
    list_entry_t run_list;
    unsigned int proc_num;
    int max_time_slice;
    skew_heap_entry_t *lab6_run_pool;
};
```

- lab5 中没有明确的实现 `run_queue`和` sched_class`，调度逻辑都直接写在 `schedule `和` wakeup_proc` 里，操作的是全局链表` proc_list`
  - 唤醒进程：在` sched.c`里的
    `wakeup_proc(struct proc_struct *proc)`
    这里没有单独的“入队函数”，只是把进程状态改成` PROC_RUNNABLE`，因为所有进程本来就挂在全局链表` proc_list `上。
  - 选择下一个进程：在` sched.c` 里的`schedule(void)`
    我们直接在 `proc_list` 上用` list_next` 线性扫描，找到下一个 `PROC_RUNNABLE` 的进程，没有通过` run_queue/pick_next` 这种抽象。

而lab6 中的 `run_queue`，我们实现了以下四个字段：

```c++
struct run_queue
{
    list_entry_t run_list;
    unsigned int proc_num;
    int max_time_slice;
    skew_heap_entry_t *lab6_run_pool;
};
```

- `list_entry_t run_list;`  
  - 就绪队列的链表头，给 RR/FIFO/SJF 等“线性扫描/队列型”算法使用。  
- `unsigned int proc_num;`  
  - 当前队列中的进程数量。  
- `int max_time_slice;`  
  - 每个进程分配的默认时间片上限，`enqueue` 时赋给 `proc->time_slice`。  
- `skew_heap_entry_t *lab6_run_pool;`  
  - 仅 LAB6 使用的斜堆根指针，给 stride 这类“优先队列型”算法使用。  
  - 堆中每个节点对应某个进程的 `proc->lab6_run_pool` 字段。

**为什么 lab6 的 run_queue 需要“链表 + 斜堆”两种结构？**

- RR/FIFO/SJF 更适合用链表表达：顺序扫描或简单队头/队尾插入即可，简单直观；  
- Stride 需要按 `lab6_stride` 最小优先选取进程，本质是“按键值排序的优先队列”，用斜堆更合适；  
- 一个 run_queue 同时提供链表和斜堆字段，由各个 `sched_class` 决定使用哪种结构：  
  - RR/FIFO/SJF：只用 `run_list`，把 `lab6_run_pool` 置为 NULL；  
  - Stride：只用 `lab6_run_pool`，`run_list` 只是为了接口统一而保留。  
- 这样同一个调度框架可以在不同算法之间复用，而不需要为每个算法定义一套 run_queue 类型。

---

#### （3）调度器框架函数分析

我们主要看 lab6 中的三个函数：`sched_init`、`wakeup_proc`、`schedule`。

##### 1） sched_init() 

```c++
void sched_init(void)
{
    list_init(&timer_list);

    // 在这里“选一个调度算法”：把 sched_class 指向不同的 sched_class 实例
  sched_class = &stride_sched_class;        // Challenge1 评测切换为 Stride
  //sched_class = &default_sched_class;     // RR
  //sched_class = &fifo_sched_class;        // Challenge2 FIFO
  //sched_class = &sjf_sched_class;         // Challenge2 SJF
    
    // 绑定全局 run_queue，并设置“默认时间片”
    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    // 调度类负责根据自己的需要初始化 run_queue
    // （RR 用链表，stride 用斜堆）
    sched_class->init(rq);
    cprintf("sched class: %s\n", sched_class->name);
}
```

- 实现流程：
  - 初始化 `timer_list`；  
  - 选择一个调度类：  
    ```c
    sched_class = &stride_sched_class;        // Challenge1
    //sched_class = &default_sched_class;     // RR
    //sched_class = &fifo_sched_class;        // FIFO
    //sched_class = &sjf_sched_class;         // SJF
    ```
  - 绑定全局 run_queue：`rq = &__rq; rq->max_time_slice = MAX_TIME_SLICE;`  
  - 调用 `sched_class->init(rq)`：由具体算法初始化 run queue 的内部结构（链表或斜堆）；  
  - 打印当前使用的调度类名称。

- 解耦点：  
  - `sched_init` 只操作 `sched_class` 指针和 `rq`；初始化细节全部交给 `sched_class->init` 实现；  
  - 要切换算法，只需改一行 `sched_class = &xxx_sched_class;`。

##### 2）wakeup_proc()

```c++
void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
        {
            // 把进程从睡眠/阻塞状态唤醒为就绪态
            proc->state = PROC_RUNNABLE;
            proc->wait_state = 0;
            if (proc != current)
            {
                // 如果唤醒的不是当前进程，就把它放入就绪队列
                sched_class_enqueue(proc);
            }
        }
        else
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
```

- 实现流程：
  - 关中断，避免并发修改；  
  - 如果进程不是 `PROC_ZOMBIE` 且当前不处于 RUNNABLE，则：  
    - `proc->state = PROC_RUNNABLE; proc->wait_state = 0;`  
    - 若被唤醒的不是 `current`，则调用 `sched_class_enqueue(proc)`，即  
      `sched_class->enqueue(rq, proc);`  
  - 恢复中断。

- 解耦点：  
  - `wakeup_proc` 不再关心“就绪队列是什么结构”，只负责修改进程状态并调用 `enqueue`；  
  - 具体把进程插在链表哪儿、还是插入斜堆，由各算法的 `enqueue` 自己决定。

##### 3）schedule()

```c++
void schedule(void)
{
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        // 清除当前进程的“需要调度”标记
        current->need_resched = 0;

        // 如果当前进程仍然是 RUNNABLE，就重新放回就绪队列等待下次运行
        if (current->state == PROC_RUNNABLE)
        {
            sched_class_enqueue(current);
        }
        // 由调度类从 run_queue 中挑选下一个要运行的进程
        if ((next = sched_class_pick_next()) != NULL)
        {
            sched_class_dequeue(next);
        }
        if (next == NULL)
        {
            // 没有就绪进程时，回退到 idle 进程
            next = idleproc;
        }
        next->runs++;
        if (next != current)
        {
            // 真正完成“进程切换”（切换上下文、页表等）
            proc_run(next);
        }
    }
    local_intr_restore(intr_flag);
}
```

- 实现流程：
  - 关中断；  
  - 清除当前进程 `current->need_resched` 标记；  
  - 如果当前进程状态仍为 `PROC_RUNNABLE`，则通过 `sched_class_enqueue(current)` 把它放回 run_queue；  
  - 调用 `sched_class_pick_next()`（即 `sched_class->pick_next(rq)`）选出 `next`：  
    - 若非 NULL，则再调用 `sched_class_dequeue(next)` 将其从 run_queue 移除；  
    - 若为 NULL，则退化为 `next = idleproc`。  
  - `next->runs++`；若 `next != current`，则调用 `proc_run(next)` 完成上下文切换；  
  - 恢复中断。

- 解耦点：  
  - `schedule` 完全通过 `sched_class` 的三个钩子工作：`enqueue / pick_next / dequeue`；  
  - 不关心内部是“轮转队列”还是“斜堆优先队列”，也不关心如何比较优先级；  
  - 这使得更换算法不影响调度框架主逻辑。

---

### 2. 调度器使用流程

#### （1）调度类的初始化流程

从内核启动到调度器就绪，大致流程：

1. 内核早期初始化阶段完成内存、陷阱门、中断等基本设置；  
2. 进程子系统 `proc_init()` 建立 `idleproc` 和 `initproc`；  
3. `sched_init()` 被调用：  
   - 初始化软定时器；  
   - 选择具体调度类（实验中可选 RR/FIFO/SJF/Stride）并赋给 `sched_class`；  
   - 将全局的 `rq` 指向静态 `__rq`，设置 `rq->max_time_slice`；  
   - 调用 `sched_class->init(rq)`，由相应调度算法初始化 run_queue（例如：  
     - `default_sched_class`：初始化链表 run_list、清空 lab6_run_pool；  
     - `stride_sched_class`：初始化斜堆 lab6_run_pool、proc_num 等）；  
   - 打印当前调度类名称。  

这样，`default_sched_class` / `fifo_sched_class` / `sjf_sched_class` / `stride_sched_class` 都是通过同一个 `sched_init` 挂接进来的，框架只依赖其函数指针接口。

---

#### （2）进程调度流程

可以概括为“一条从时钟中断到 schedule 的链路”，关键步骤如下：

1. **时钟中断触发**  
   - RISC-V 触发 `IRQ_S_TIMER` 中断，硬件跳转到内核陷阱入口，最终调用到 `interrupt_handler(tf)`。

2. **时钟中断处理**（kern/trap/trap.c）  
   - 在 `case IRQ_S_TIMER:` 分支中：
     - `clock_set_next_event();`：设定下一次时钟中断；  
     - `ticks++` 并根据 `TICK_NUM` 打印 `"100 ticks"`、关机等（LAB3 逻辑）；  
     - **LAB6 补充**：  
       ```c
       if (current != NULL) {
           sched_class_proc_tick(current);
       }
       ```
       把本次 tick 通知调度器。

3. **proc_tick 被调用**  
   - `sched_class_proc_tick(current)` 内部：  
     - 若不是 idle 进程，则调用 `sched_class->proc_tick(rq, current)`；  
     - 对 RR/SJF/Stride 来说，一般会：  
       - `current->time_slice--`；  
       - 时间片用完时：`current->need_resched = 1;`。

4. **从 trap 返回前检查 need_resched**（kern/trap/trap.c 中 `trap()`）  
   - 对用户态 trap 返回路径：  
     - 处理完中断/异常后，`trap()` 会检查：  
       ```c
       if (!in_kernel) {
           if (current->flags & PF_EXITING) do_exit(...);
           if (current->need_resched) schedule();
       }
       ```
     - 一旦 `need_resched == 1`，就调用 `schedule()`。

5. **schedule() 执行调度**  
   - 上文已分析：  
     - 把仍然 RUNNABLE 的 current 重新入队（`enqueue`）；  
     - 调用 `pick_next` 选出下一个进程；  
     - `dequeue(next)` 把它从 run_queue 中拿出；  
     - 调用 `proc_run(next)` 实际完成进程切换。

6. **具体调度类函数的调用顺序** 
   
   - 时钟中断：`interrupt_handler` → `sched_class_proc_tick(current)` → `sched_class->proc_tick(rq, current)`  
   - 返回前：`trap()` 看到 `need_resched == 1` → 调用 `schedule()`  
   - `schedule()` 内：  
     1. 若 current 仍是 RUNNABLE：`sched_class->enqueue(rq, current)`  
     2. `next = sched_class->pick_next(rq)`  
     3. 若 `next != NULL`：`sched_class->dequeue(rq, next)`  
     4. `proc_run(next)` 完成页表和上下文切换  

**need_resched 标志位的作用**

- 它把“时间片用完/应该换人跑”这个决策，从调度算法传到调度框架；  
- `proc_tick` 只做短小的标记更新（中断上下文不做复杂工作），真正的进程切换由 `trap()` 返回前统一调用 `schedule()` 完成；  
- 这种设计避免在中断处理函数里直接强制切换上下文，使逻辑更清晰、安全。

我们做出来的图如图所示：

```
        ┌───────────────────────────┐
        │   某进程 current 正在运行   │
        └────────────┬──────────────┘
                     │
                     ▼
          ┌─────────────────────┐
          │  硬件定时器到期：IRQ │
          └─────────┬───────────┘
                    ▼
        ┌───────────────────────────┐
        │  trap() / 中断处理入口      │
        └────────────┬──────────────┘
                     │ 识别为时钟中断
                     ▼
      ┌─────────────────────────────────┐
      │ sched_class_proc_tick(current)  │
      └────────────┬───────────────────┘
                   │
     current 是 idle? ──────┐
         是                  │ 否
         │                   ▼
         ▼        ┌──────────────────────────────┐
 ┌────────────────┤ sched_class->proc_tick(...)  │
 │               │ │ (time_slice--, 可能置标志)  │
 │               │ └──────────────────────────────┘
 │               │
 │               ▼
 │   current->need_resched ？（由上一步决定）
 └─────是───────────────────────────────┐
       否                               │
       │                                ▼
       ▼                     ┌──────────────────────┐
  恢复现场，返回 current      │   调用 schedule()    │
                             └──────────┬───────────┘
                                        │
                                        ▼
                   ┌────────────────────────────────────┐
                   │ 清 current->need_resched           │
                   │ 如果 current 仍 RUNNABLE：         │
                   │    sched_class->enqueue(rq,current)│
                   └──────────┬─────────────────────────┘
                              │
                              ▼
                 ┌───────────────────────────────┐
                 │ next = sched_class->pick_next │
                 └──────────┬────────────────────┘
                            │
                            ▼
             ┌───────────────────────────────────────┐
             │ sched_class->dequeue(rq, next)        │
             │ 若 next 为空则选 idleproc             │
             └──────────┬────────────────────────────┘
                        │
                        ▼
         next == current ? ────────┐
                是                 │ 否
                │                  ▼
                ▼      ┌──────────────────────────┐
       不切换，直接返回 │   proc_run(next) 切换上下文 │
                       └──────────────────────────┘
```

#### （3）调度算法的切换机制

**如果要添加一个新的调度算法（例如 stride），需要做什么？**

1. 首先定义一个新的 `sched_class` 实例
   - 实现对应的 `init/enqueue/dequeue/pick_next/proc_tick` 函数；  
   - 设置 `.name` 为算法名字；
2. 在 `sched_init()` 中选择这个类：  
   - 把 `sched_class = &sjf_sched_class;` 改成 `sched_class = &stride_sched_class;` 即可。
3. 如算法需要额外的 per-proc 字段，在 `struct proc_struct` 中增加字段，并在 `alloc_proc` 里初始化（LAB6 已经为 stride 加了 `lab6_run_pool/lab6_stride/lab6_priority` 等字段）。

**为什么当前设计切换算法很容易？**

- 调度框架只通过 `sched_class` 暴露的五个函数指针与算法交互：`init/enqueue/dequeue/pick_next/proc_tick`；  
- `run_queue` 预留了链表和斜堆两种基础结构，基本覆盖了常见算法的需要；  
- 算法内部完全封装在自己的 `.c` 文件里，不需要修改 `wakeup_proc`、`schedule` 等框架代码；  
- 切换算法只改一行 `sched_class = &xxx;`，其他使用逻辑（时钟中断 → proc_tick → need_resched → schedule）完全复用。



## 三、练习2：实现 Round Robin 调度算法



### 1. Lab5和Lab6对比

对比函数选择：我选择比较 kern/schedule/sched.c 中的 `schedule` 函数（lab5 和 lab6 都存在，但实现方式明显不同）。

```c++
	 do
        {
            if ((le = list_next(le)) != &proc_list)
            {
                next = le2proc(le, list_link);
                if (next->state == PROC_RUNNABLE)
                {
                    break;
                }
            }
        } while (le != last);
        if (next == NULL || next->state != PROC_RUNNABLE)
        {
            next = idleproc;
        }
        next->runs++;
        if (next != current)
        {
            proc_run(next);
        }
```

- Lab5 中的实现特点：
  - 调度逻辑直接写在 `schedule` 内部，使用的是全局进程链表，按固定策略在链表上顺序查找下一个 RUNNABLE 进程。
  - 不区分“调度框架”和“调度算法”，整个系统只能使用这一种写死的策略，改一种算法就要改 `schedule` 本身。
- Lab6 中的实现特点：
  - 新增了 `struct sched_class` 和 `struct run_queue` 抽象，`schedule` 不再直接操作链表，而是只通过 `sched_class->enqueue/dequeue/pick_next/proc_tick` 这组函数指针与调度算法交互。
  - `schedule` 的核心流程变成：“当前进程需要重入队则调用 `enqueue`，然后通过 `pick_next` 选出下一个进程，再用 `dequeue` 将其从队列结构中移除，最后调用 `proc_run` 切换”。
- 这样修改的原因：
  - 把“调度框架”（何时调度、如何切换）和“调度策略”（如何组织就绪队列、如何选择 next）解耦，便于在同一框架下切换不同调度算法（RR、FIFO、SJF、Stride 等）。
  - 后续实验只需要在各自的调度实现文件里填充 `sched_class` 的几个接口函数，而不必改动核心的 `schedule`，大大降低了实验难度和出错概率。
- 如果不做这样的改动会有什么问题：
  - 每引入一种新的调度算法都要直接修改 `schedule`，容易把已有逻辑改坏，维护成本高。
  - 无法同时支持多种调度算法并方便评测切换，也不利于从“框架层面”理解调度器的整体工作原理。

### 2. RR函数实现

#### （1）RR_init

```c
static void
RR_init(struct run_queue *rq)
{
    // LAB6: 2312900
    list_init(&rq->run_list);
    rq->proc_num = 0;
    /* Ensure a sensible default time slice if caller didn't set it */
    if (rq->max_time_slice <= 0)
        rq->max_time_slice = 1;
    rq->lab6_run_pool = NULL;
}
```

我们的目标是把 `run_queue `初始化成“空的就绪队列”，让后续的入队、出队都在一个干净的状态上进行。

- 核心做法：
  - 把` run_list `初始化成空的双向循环链表头，这样后续所有就绪进程都以它为哨兵结点挂上去。
  - 把 `proc_num` 置 0，明确当前队列里一个进程都没有。
  - 检查 `max_time_slice`，如果外面没设置或误设成非正数，就强制设成 1，保证后面分给进程的 time_slice 不会是 0。
  - 把` lab6_run_pool` 设成 `NULL`，表示 RR 调度不使用堆之类的复杂结构，只用链表。

`run_queue` 成为一个简单的“空队列 + 合理默认时间片”的状态，后面所有 RR 操作都只需要围绕这几个字段工作。

#### （2）RR_enqueue

````c
static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 2312900
    /* proc should not already belong to a run-queue */
    assert(proc->rq == NULL);
    /* insert at tail: add before the head sentinel */
    list_add_before(&rq->run_list, &proc->run_link);
    /* initialize process scheduling fields; protect against max_time_slice == 0 */
    proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
    proc->rq = rq;
    rq->proc_num++;
}
````

我们要把一个变成 RUNNABLE 的进程按“先来先服务”的顺序插入到就绪队列尾部，并初始化它的调度相关字段。

- 核心做法：
  - 先断言这个进程目前不在任何 run_queue 里，避免同一进程被插入多次导致链表结构乱掉。
  - 使用“在链表头结点前插入”的操作，相当于插到队尾；因为 run_list 是循环链表，head 前一个就是尾结点，这样就实现了 FIFO 语义。
  - 给进程分配时间片：直接设置为 run_queue 的 max_time_slice（若 max_time_slice 有问题再兜底成 1），保证新入队的进程从一个完整时间片开始计数。
  - 记录好双向关系：proc->rq 指向当前 run_queue，rq->proc_num++ 统计队列长度。

这样就绪队列按进入顺序排成一条链，每个进程都带着一整段可用的时间片等待被调度运行。

#### （3）RR_dequeue

```c++
static void
RR_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 2312900
    /* only remove if proc currently belongs to this run-queue */
    assert(proc->rq == rq);
    list_del_init(&proc->run_link);
    proc->rq = NULL;
    if (rq->proc_num > 0)
        rq->proc_num--;
}
```

当一个进程不再属于就绪队列（比如被选中运行、进入睡眠或退出）时，该函数要把他从链表中安全地把它摘掉。

- 核心做法：
  - 先通过断言确认这个进程当前确实挂在这个 run_queue 上，避免从错误的队列里删东西。
  - 调用链表删除操作，把该进程对应的链表结点从 run_list 中移除，并把它的 prev/next 指针重置到“已初始化”状态，避免悬挂指针。
  - 清掉 proc->rq，把它标记为“不在任何就绪队列中”。
  - 如果 proc_num 大于 0，就自减 1，维持队列长度统计的正确性。

我们保证了无论是被调度出去还是被阻塞/退出的进程，都能干净地离开 RR 队列，不会破坏其他就绪进程的链表结构。

#### （4）RR_pick_next

```c
static struct proc_struct *
RR_pick_next(struct run_queue *rq)
{
    // LAB6: 2312900
    if (list_empty(&rq->run_list))
        return NULL;
    list_entry_t *le = list_next(&rq->run_list);
    return le2proc(le, run_link);
}
```

- 该函数实现在需要选出“下一个要运行的进程”时，按 Round Robin 的规则，从队头取出队首进程。
- 核心做法：
  - 先判断 run_list 是否为空，如果空则说明当前没有普通就绪进程，返回 NULL，交给上层选择 idle 进程。
  - 如果不空，就取链表头结点的下一个结点（head->next），这是当前队列中“最早入队但尚未轮完一圈”的进程。
  - 再把这个链表结点转换成对应的 proc_struct 指针返回，让 schedule 去做后续的 dequeue 和 context switch。
- 效果：RR_pick_next 每次都从队头取一个进程出来，配合时间片用完后重新入队，就构成了典型的“排队轮流上 CPU”的行为。

#### （5）RR_proc_tick

```c
static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 2312900
    if (!proc)
        return;
    /* consume one time slice if any left */
    if (proc->time_slice > 0)
        proc->time_slice--;
    /* if time slice exhausted, request reschedule */
    if (proc->time_slice == 0)
        proc->need_resched = 1;
}
```

- 该函数实现在时钟中断到来时，对当前正在运行的进程做一次“时间片记账”，并在时间片用完时通知调度器准备抢占。
- 核心做法：
  - 先判断传进来的进程指针是否为空，防御性地避免空指针操作。
  - 如果当前进程的 time_slice 还大于 0，就减 1，表示已经用掉了一个时钟节拍。
  - 如果减完之后 time_slice 正好变成 0，就把这个进程的 need_resched 置 1，发出“需要调度”的信号。
- 效果：
  - 每个被 CPU 选中的进程在自己的时间片内可以连续运行多个时钟周期，一旦时间片耗尽，下一次 trap 收尾时就会因为 need_resched 被置 1 而进入 schedule，从就绪队列里换上下一个进程，实现真正的“时间片轮转抢占”。

### 3. make grade结果

<img src="D:\WeChat\WeixinDocuments\xwechat_files\wxid_uvue83lqxf5q22_f088\temp\InputTemp\a960f479-813a-43b6-b719-0c0d1228483e.png" alt="a960f479-813a-43b6-b719-0c0d1228483e" style="zoom:75%;" />

我们的实验结果如上。

我们执行`make qemu`之后可以看到：采用的是`RR_scheduler`策略

<img src="D:\WeChat\WeixinDocuments\xwechat_files\wxid_uvue83lqxf5q22_f088\temp\InputTemp\9fd3d035-5ec7-4289-bea5-683da7779bcf.png" alt="9fd3d035-5ec7-4289-bea5-683da7779bcf" style="zoom: 50%;" />

### 4. 实验分析

- **Round Robin 调度算法的优点：**
  - 实现简单，只依赖一个 FIFO 就绪队列和时间片计数，易于在内核中维护。
  - 对所有普通进程一视同仁，每个进程都能在固定时间内获得 CPU 使用权，避免长作业完全饿死短作业。
  - 在交互式系统中，可以通过合理设置时间片大小，使得用户感觉“多个程序在并行运行”。
- **Round Robin 的缺点：**
  - 不考虑进程的优先级或不同作业的紧迫程度，重要任务可能和后台任务被平等对待。
  - 对 CPU 密集型任务较多的场景，频繁的上下文切换会带来额外开销，影响整体吞吐量。
  - 对 I/O 密集型进程，如果时间片设置过大，可能在一次时间片内就很快阻塞，导致时间片利用不充分。
- **时间片大小对系统性能的影响：**
  - 时间片过大：
    - 上下文切换次数少，切换开销小，有利于提高 CPU 利用率。
    - 但响应时间变长，交互延迟增加，用户感觉“卡顿”。
  - 时间片过小：
    - 响应速度快，看起来“很公平”，进程切换也很频繁。
    - 但上下文切换开销占比显著增大，实质上浪费了大量 CPU 时间在保存/恢复现场上，整体吞吐量下降。
  - 实际系统设计中通常在“响应时间”和“上下文切换开销”之间选择一个折中值。
- **为什么需要在 RR_proc_tick 中设置 `need_resched`：**
  - 调度器框架的设计是：`proc_tick` 只负责在“时钟中断上下文”中做时间片记账，并通过设置 `need_resched` 告诉上层“现在需要调度了”。
  - `trap()` 在中断返回前检查 `current->need_resched`，为真时才调用 `schedule()`，从而在统一的地方完成上下文切换。
  - 如果不在 `RR_proc_tick` 中设置 `need_resched`，那么时间片虽然被扣到 0，但 `trap()` 不会触发 `schedule()`，当前进程就会继续运行，失去了 Round Robin 抢占调度的意义。

### 5. 拓展思考

- **如果要实现优先级 RR 调度，代码需要如何修改？**
  - 可以在 `proc_struct` 中增加一个优先级字段（例如 `prio`），或者复用实验中已有的 `lab6_priority` 字段。
  - 在 `RR_enqueue` 中，不再简单地将进程插入链表末尾，而是按照优先级分层维护多个队列：
    - 一种方式是为每个优先级维护一个单独的 run_queue，调度时总是先在高优先级队列中 `pick_next`。
    - 另一种方式是在单个 run_queue 中按“优先级高的在前”插入，同时保持同优先级内部仍采取 RR 轮转。
  - 在 `RR_pick_next` 中，优先从高优先级队列或链表前端选取进程，实现“高优先级 + 轮转”的综合策略。
- **当前实现是否支持多核调度？**
  - 目前的实验环境实际上是单核模型：
    - 内核只维护一个全局的 run_queue 和一个全局当前进程指针 `current`。
    - 调度决策默认只有一个 CPU 在执行，所有代码都以“单核互斥”为前提。
  - 因此，从严格意义上讲，当前实现并不支持真正的多核调度。
- **如果要支持多核调度，需要如何改进？**
  - 为每个 CPU 维护一个本地 run_queue 和一个本地 `current` 指针，实现 per-CPU 调度器。
  - 需要在调度器中加入锁或其他同步原语，确保多个 CPU 在迁移进程、负载均衡时不会破坏队列结构。
  - 考虑负载均衡策略：
    - 定期从负载较重的 CPU 上“偷”一部分就绪进程到负载较轻的 CPU 上（work stealing）。
    - 对绑定 CPU（CPU affinity）的进程要尽量优先放回原 CPU 的 run_queue。
  - 时钟中断与 `proc_tick` 也需要变为 per-CPU：
    - 每个 CPU 上的时钟中断只负责给本 CPU 的当前进程扣减时间片，并在本地触发调度，不再共享单一的全局状态。



## 四、扩展练习 Challenge 1: 实现 Stride Scheduling 调度算法

> Challenge1 目标：在 lab6 的调度框架下实现 Stride Scheduling，并通过用户态测试程序（如 `priority`/`bench_priority`）验证“CPU 份额随优先级变化”。

### 1. 代码切换点

Stride 调度器实现完成后，需要在 `sched_init()` 中将调度类切换为 `stride_sched_class`（见上文代码块）。启动时会打印：

```
sched class: stride_scheduler
```

### 2. Stride 调度算法核心思想

Stride Scheduling 用一个“累计步长” `stride` 来表示进程已经“消耗”了多少 CPU 份额：

- 每个进程有权重（优先级）`priority`（本实验中为 `proc->lab6_priority`）。
- 每当一个进程被选中运行一次，就把它的 `stride` 增加：
  $$\text{stride} \leftarrow \text{stride} + \frac{\text{BIG\_STRIDE}}{\text{priority}}$$
- 调度器每次选择 `stride` 最小的进程运行，从而使“权重高的进程 stride 增长更慢，因而更频繁地成为最小值”。

在本 lab 中：

- 使用常量 `BIG_STRIDE = 1000000` 做缩放，避免浮点运算。
- 使用 `rq->lab6_run_pool`（斜堆 skew heap）实现按 `lab6_stride` 取最小值的优先队列。

### 3. 数据结构与关键字段

Stride 依赖 `proc_struct` 中的三个字段：

- `lab6_priority`：权重（越大拿到越多 CPU）
- `lab6_stride`：累计步长（越小越先被选中）
- `lab6_run_pool`：斜堆节点，把进程挂进 `rq->lab6_run_pool`

同时复用统一框架字段：

- `proc->time_slice`：时间片剩余
- `proc->need_resched`：时间片耗尽时置 1，触发 `schedule()`

### 4. 接口实现（与 RR 类似，但队列结构不同）

Stride 的关键实现代码如下（展示核心常量/比较器与五个接口函数）：

```c
/* BIG_STRIDE: a large constant used to scale strides. */
#define BIG_STRIDE 1000000

/* The compare function for two skew_heap_node_t's and the corresponding procs */
static int
proc_stride_comp_f(void *a, void *b)
{
  struct proc_struct *p = le2proc(a, lab6_run_pool);
  struct proc_struct *q = le2proc(b, lab6_run_pool);
  int32_t c = p->lab6_stride - q->lab6_stride;
  if (c > 0)
    return 1;
  else if (c == 0)
    return 0;
  else
    return -1;
}
```

#### （1）stride_init

目标：初始化运行队列。

- `rq->run_list`：仍初始化为空（占位，Stride 实际不用链表）
- `rq->lab6_run_pool = NULL`：斜堆为空
- `rq->proc_num = 0`

```c
static void
stride_init(struct run_queue *rq)
{
  list_init(&rq->run_list);
  rq->lab6_run_pool = NULL;
  rq->proc_num = 0;
}
```

#### （2）stride_enqueue

目标：将 `PROC_RUNNABLE` 进程插入优先队列。

- 断言 `proc->rq == NULL`，避免重复入队
- `proc->time_slice = rq->max_time_slice`（与 RR 一致）
- `proc->rq = rq; rq->proc_num++`
- 关键：把 `&proc->lab6_run_pool` 插入 `rq->lab6_run_pool`：
  - `rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);`

```c
static void
stride_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(proc->rq == NULL);
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
    proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
    proc->rq = rq;
    rq->proc_num++;
}
```

#### （3）stride_dequeue

目标：把进程从就绪队列移除（由 `schedule()` 在 pick_next 后调用）。

- 断言 `proc->rq == rq`
- 关键：斜堆删除
  - `rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);`
- `proc->rq = NULL; rq->proc_num--`

```c
static void
stride_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
  assert(proc->rq == rq);
  rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
  proc->rq = NULL;
  if (rq->proc_num > 0)
    rq->proc_num--;
}
```

#### （4）stride_pick_next

目标：选择 `lab6_stride` 最小的进程。

- 若 `rq->lab6_run_pool == NULL` 返回 `NULL`
- 否则堆顶就是 stride 最小的进程：
  - `p = le2proc(rq->lab6_run_pool, lab6_run_pool)`
- 注意：`pick_next` **不负责出队**，只返回候选者，实际删除由 `schedule()` 调用 `dequeue()` 完成。
- 选中后立即更新 `p->lab6_stride`：
  - `p->lab6_stride += BIG_STRIDE / max(p->lab6_priority, 1)`

```c
static struct proc_struct *
stride_pick_next(struct run_queue *rq)
{
  if (rq->lab6_run_pool == NULL)
    return NULL;
  struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
  uint32_t pri = p->lab6_priority;
  if (pri == 0)
    pri = 1;
  p->lab6_stride += (uint32_t)(BIG_STRIDE / pri);
  return p;
}
```

这样做的效果是：一个进程每“被服务一次”，它的 stride 就上升一截，短期内不会一直霸占堆顶。

#### （5）stride_proc_tick

与 RR 相同：每个 tick 递减 `time_slice`，用完触发调度。

- `proc->time_slice--`
- 若 `proc->time_slice == 0` 则 `proc->need_resched = 1`

```c
static void
stride_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
  if (!proc)
    return;
  if (proc->time_slice > 0)
    proc->time_slice--;
  if (proc->time_slice == 0)
    proc->need_resched = 1;
}
```

### 5. 优先级设置与测试程序

本实验提供了设置优先级的系统调用：

- 内核侧：`lab6_set_priority(uint32_t priority)`（在 `proc.c` 中）
- 用户态封装：`lab6_setpriority()` → `sys_lab6_set_priority()`

用户程序 `priority` 与 `bench_priority` 会在运行过程中调用该接口设置不同进程的 `lab6_priority`，从而观察到：

- `lab6_priority` 更大的进程 stride 增长更慢
- 因而在斜堆中更容易保持较小的 `lab6_stride`，更频繁成为 `pick_next` 的结果

我们在本次提交中切换为 stride 后运行 `make grade`，`priority` 测试通过。

### 6. 为什么“运行足够久后，时间片份额 ∝ priority”

用一个直观但可自洽的说明：

设进程 $i$ 的权重为 $p_i$，被调度（成为 next 并运行一个时间片）的次数为 $n_i$。在 Stride 中每次被调度后：

$$S_i \leftarrow S_i + \frac{B}{p_i}$$

其中 $S_i$ 是累计 stride，$B=\text{BIG\_STRIDE}$。

调度器总是选择当前 $S$ 最小的进程。系统长期运行后，所有可运行进程的 $S_i$ 会被“拉”到差不多的量级：

- 若某个进程 $i$ 的 $S_i$ 长期显著小于其他进程，则它会频繁被选中；
- 频繁被选中会让 $S_i$ 以步长 $B/p_i$ 变大，从而把它推回到与其他进程相近的水平；
- 反之亦然。

因此在稳定状态下，各进程累计 stride 近似满足：

$$n_i \cdot \frac{B}{p_i} \approx n_j \cdot \frac{B}{p_j}$$

消去 $B$ 得：

$$\frac{n_i}{n_j} \approx \frac{p_i}{p_j}$$

也就是：运行足够久后，每个进程拿到的“时间片次数”与其优先级（权重）近似成正比。

### 7. 设计/实现过程简述

- 复用 lab6 的统一调度框架：`sched_class` + `run_queue` + `need_resched` 链路
- 选用斜堆实现优先队列：以 `lab6_stride` 为键值，取最小值为堆顶
- 把“份额控制”集中在 `pick_next` 的 stride 更新：通过 `BIG_STRIDE/priority` 控制增长速率
- 通过 `priority`/`bench_priority` 验证权重变化确实影响调度份额





## 五、扩展练习 Challenge 2 ：在ucore上实现尽可能多的各种基本调度算法(FIFO, SJF,...)

> Challenge2 目标：在同一调度框架下新增 FIFO 与 SJF 两种调度算法，并给出测试与适用场景分析。

### 1. FIFO 调度（First-In-First-Out）

FIFO 的关键实现代码如下：

```c
static void
FIFO_init(struct run_queue *rq)
{
  list_init(&rq->run_list);
  rq->proc_num = 0;
  if (rq->max_time_slice <= 0)
    rq->max_time_slice = 1;
  rq->lab6_run_pool = NULL;
}

static void
FIFO_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
  assert(proc->rq == NULL);
  list_add_before(&rq->run_list, &proc->run_link);
  proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
  proc->rq = rq;
  rq->proc_num++;
}

static void
FIFO_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
  assert(proc->rq == rq);
  list_del_init(&proc->run_link);
  proc->rq = NULL;
  if (rq->proc_num > 0)
    rq->proc_num--;
}

static struct proc_struct *
FIFO_pick_next(struct run_queue *rq)
{
  if (list_empty(&rq->run_list))
    return NULL;
  list_entry_t *le = list_next(&rq->run_list);
  return le2proc(le, run_link);
}

static void
FIFO_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
  if (!proc)
    return;
  if (proc->time_slice > 0)
    proc->time_slice--;
  if (proc->time_slice == 0)
    proc->need_resched = 1;
}

struct sched_class fifo_sched_class = {
  .name = "FIFO_scheduler",
  .init = FIFO_init,
  .enqueue = FIFO_enqueue,
  .dequeue = FIFO_dequeue,
  .pick_next = FIFO_pick_next,
  .proc_tick = FIFO_proc_tick,
};
```

- 数据结构：复用 `rq->run_list`（双向链表）
- 入队：尾插（先来先服务）
- 出队：由 `schedule()` 在选中 next 后调用 `dequeue` 删除节点
- 选取：取队头（`list_next(&rq->run_list)`）
- tick：与 RR 一致，时间片用完触发 `need_resched`

适用场景：实现简单、开销低；但不考虑作业长短和交互性，可能导致响应差。

### 2. SJF 调度（Shortest Job First，实验内的近似实现）

SJF 的关键实现代码如下（用 `runs` 近似作业长度，选择 `runs` 最小者）：

```c
static void
SJF_init(struct run_queue *rq)
{
  list_init(&rq->run_list);
  rq->proc_num = 0;
  if (rq->max_time_slice <= 0)
    rq->max_time_slice = 1;
  rq->lab6_run_pool = NULL;
}

static void
SJF_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
  assert(proc->rq == NULL);
  list_add_before(&rq->run_list, &proc->run_link);
  proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
  proc->rq = rq;
  rq->proc_num++;
}

static void
SJF_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
  assert(proc->rq == rq);
  list_del_init(&proc->run_link);
  proc->rq = NULL;
  if (rq->proc_num > 0)
    rq->proc_num--;
}

static struct proc_struct *
SJF_pick_next(struct run_queue *rq)
{
  if (list_empty(&rq->run_list))
    return NULL;
  list_entry_t *le = list_next(&rq->run_list);
  struct proc_struct *best = NULL;
  for (; le != &rq->run_list; le = list_next(le))
  {
    struct proc_struct *p = le2proc(le, run_link);
    if (best == NULL || p->runs < best->runs)
    {
      best = p;
    }
  }
  return best;
}

static void
SJF_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
  if (!proc)
    return;
  if (proc->time_slice > 0)
    proc->time_slice--;
  if (proc->time_slice == 0)
    proc->need_resched = 1;
}

struct sched_class sjf_sched_class = {
  .name = "SJF_scheduler",
  .init = SJF_init,
  .enqueue = SJF_enqueue,
  .dequeue = SJF_dequeue,
  .pick_next = SJF_pick_next,
  .proc_tick = SJF_proc_tick,
};
```

严格 SJF 需要已知“作业长度”，在操作系统中通常难以准确获得。本实验采用了一个可实现的近似：

- 仍用 `rq->run_list` 存放就绪进程
- `pick_next` 线性扫描队列，选择 `runs` 最小的进程（把 `runs` 视为“已运行量/历史 CPU 使用量”的粗略估计）
- 其余接口（init/enqueue/dequeue/proc_tick）与 RR/FIFO 保持一致

适用场景：偏向让“CPU 使用较少/更短”的进程先跑，整体响应更好；但可能对某些进程不公平（存在饥饿风险）。

### 3. 测试用例与定量分析思路（简述）

本实验自带多组用户态测试程序，可用于对比不同调度算法：

- `bench_short`：短任务集合，观察 SJF 是否更快完成短作业
- `bench_mixed`：长短混合，观察吞吐与等待时间
- `bench_priority`：优先级任务集合（更适合 Stride）

定量分析可用 lab6 自带脚本与日志（例如输出的 CSV 统计日志）统计：

- 平均周转时间（turnaround）
- 平均等待时间（waiting）
- 响应时间（response）
- 公平性（例如各进程获得的时间片占比偏差）

### 4. 多级反馈队列（MLFQ）概要设计

如果在 lab6 框架下实现 MLFQ（Multi-Level Feedback Queue），可以采用以下概要设计：

1. **数据结构**：
  - 在 `run_queue` 中扩展为多个就绪队列：$Q_0, Q_1, \dots, Q_{k-1}$（从高到低优先级）
  - 每级队列采用链表（FIFO）即可

2. **时间片策略**：
  - 高优先级队列时间片短、低优先级队列时间片长，例如 $ts_i = ts_0 \cdot 2^i$

3. **入队规则**：
  - 新创建/唤醒的交互型进程进入高优先级队列（如 $Q_0$）

4. **降级规则（反馈）**：
  - 若进程用完整个时间片仍未阻塞，则认为偏 CPU-bound，降到下一层队列
  - 若进程在时间片内主动阻塞（如 I/O），则保留或提升优先级（偏交互）

5. **选择规则**：
  - 总是从最高非空队列选取进程运行

6. **防止饥饿（优先级提升）**：
  - 周期性把所有进程提升到最高队列（priority boost），或对等待过久的进程进行 aging 提升

在实现上，MLFQ 仍可复用 lab6 的 `sched_class` 五个接口：

- `enqueue/dequeue` 操作具体某一层队列
- `pick_next` 从高到低扫描队列找到第一个非空队列
- `proc_tick` 负责 time_slice 递减，并在用尽时触发 `need_resched`，同时记录是否需要“降级/提升”的状态
## 六、总结：重要知识点与 OS 原理对应

### 1. 本实验中重要的知识点


1) **调度框架抽象（`sched_class` 接口）**
  - 对应原理：**机制与策略分离（mechanism vs. policy）**
  - 理解：框架（`schedule/wakeup_proc` 等）提供“何时切换、如何切换”的机制；RR/FIFO/SJF/Stride 是“选谁上 CPU”的策略。二者分离能让替换策略不破坏机制，降低修改风险。

2) **就绪队列 `run_queue` 与进程状态流转（RUNNABLE 等）**
  - 对应原理：**进程状态机、就绪队列模型**
  - 理解：实验把“可运行进程集合”显式化为 `run_queue`，把“状态变化”和“入队/出队”绑定起来。原理上这是把抽象状态机落到具体数据结构上。

3) **时间片 `time_slice` + 抢占标志 `need_resched`**
  - 对应原理：**时钟中断驱动的抢占式调度、延迟调度（deferred scheduling）**
  - 理解：在中断上下文里只做轻量记账（`time_slice--` 并置位），真正的上下文切换推迟到安全路径执行。差异在于：原理讲“抢占”通常是概念性的；实验体现为“中断里不直接切换”。

4) **RR（Round Robin）实现与公平性**
  - 对应原理：**分时系统、响应时间与上下文切换开销权衡**
  - 理解：RR 用时间片实现“近似公平”，但公平不是免费的：时间片越小响应越快、切换越频繁；时间片越大吞吐可能更好、交互更差。

5) **FIFO 与“非抢占/弱抢占”特性**
  - 对应原理：**先来先服务的队列模型、饥饿与响应性问题**
  - 理解：FIFO 对短任务/交互不友好，容易出现“队首长任务拖慢所有人”。实验里虽然仍用 `proc_tick` 触发调度，但策略层依旧体现了 FIFO 的核心缺陷：不区分作业特征。

6) **SJF 的近似实现（用 `runs` 作为“长度”估计）**
  - 对应原理：**SJF/预测 CPU burst、最小化平均等待时间**
  - 理解：原理中的 SJF 依赖“已知或可预测的运行时间”，现实里做不到精确。实验用 `runs` 这种历史统计做近似，本质是用“过去的 CPU 使用量”替代“未来的 CPU burst”，所以只能得到倾向性效果，且仍可能饥饿。

7) **Stride（比例份额调度）与优先级/权重**
  - 对应原理：**proportional-share scheduling（按份额分配 CPU）**
  - 理解：Stride 用整数步长把“CPU 份额”变成可比较的标量（`stride`），长期看份额 $\propto$ 权重。与“静态优先级”不同：这里优先级不是“谁永远更先跑”，而是“长期拿到多少比例”。

8) **优先队列（斜堆）实现 Stride 的 pick_next**
  - 对应原理：**内核数据结构选择与复杂度权衡（链表 vs. 优先队列）**
  - 理解：RR/FIFO/SJF 用链表就够（插入/扫描简单），Stride 需要频繁取最小 `stride`，用优先队列更合适。差异点在于：原理层通常不限定具体数据结构；实验要求你“用某种结构把策略落地”。

9) **用户态影响调度（设置优先级的系统调用）**
  - 对应原理：**系统调用接口、资源管理与权限控制**
  - 理解：实验展示了“用户可以通过 syscall 影响内核策略参数”。但在真实系统里，调高优先级涉及权限与防滥用（否则可能造成拒绝服务），实验中一般简化为功能验证。

### 2. OS 原理中重要但本实验没有直接对应的知识点

1) **多核调度与负载均衡**：per-CPU run queue、任务迁移、work stealing、NUMA/缓存亲和性等。

2) **实时调度与时限约束**：RM/EDF、deadline、抖动（jitter）控制、可调度性分析。

3) **优先级反转与继承机制**：锁竞争下的 priority inversion、priority inheritance/ceiling。

4) **更贴近现代 OS 的通用调度器设计**：如 CFS（红黑树按虚拟运行时间）、组调度/配额（cgroups 类思想）。

5) **I/O 与调度的耦合**：阻塞/唤醒对交互性的影响、I/O completion、磁盘/网络队列与 CPU 调度的协同。

6) **能耗与温控相关调度**：DVFS、能量感知调度（energy-aware scheduling）。

7) **安全与隔离视角的资源分配**：如何限制用户态调度影响、避免恶意抢占、配额与审计。


