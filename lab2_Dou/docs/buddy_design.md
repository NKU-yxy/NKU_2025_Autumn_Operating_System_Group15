Buddy System PMM — 设计文档

目标

在 ucore 的物理内存管理子系统中实现 Buddy System（伙伴系统）作为 pmm_manager 的一种实现，用于页粒度（4KB）分配。实现需兼容项目现有的 `pmm_manager` 接口并通过自检。

主要数据结构

- Page: 继承自 `memlayout.h` 的 `struct Page`，用于描述每一物理页。利用 `flags` 的 `PG_property` 与 `property` 字段表示空闲块的头页和块大小。
- buddy_area_t: 保存多个 free list，每个 list 对应一个 order（2^order 页块），以及 `nr_free` 记录总的空闲页数。

参数与限制

- MAX_ORDER: 当前实现的最大阶数为 11，支持最大块大小 2^(MAX_ORDER-1) 页（若需更大，可增大此常量并处理内存越界）。
- 对齐: 插入 free list 的块头必须已按块大小对齐（实现时通过在 init_memmap 中分割实现）。

核心操作

- init: 初始化每个 order 的空闲链表并将 nr_free 置零。
- init_memmap: 将一段连续的页（base, n）拆分成若干个对齐的 2^k 大小块并加入对应 order 的 free list，同时设置 `PG_property` 与 `property` 字段。
- alloc_pages(n): 计算需求的 order = ceil(log2(n))，在该 order 或更高阶寻找空闲块，若在更高阶找到则递归/迭代分裂到目标阶并将右侧分裂出的块插入较低阶 free list，最后返回分配的块首地址并更新 nr_free。
- free_pages(base, n): 将释放块插入对应阶的 free list，并尝试与其 buddy 合并（若 buddy 也是空闲且阶相同），合并后继续向更高阶尝试合并，直到无法合并或达到 MAX_ORDER。

复杂度

- 分配: 平均情况下在 O(1) 到 O(MAX_ORDER) 之间（需扫描 higher-order lists 或进行分裂）；最坏为 O(MAX_ORDER)
- 释放: 在需要合并时最多 O(MAX_ORDER) 次合并操作。

边界与细节

- 分配大小会向上取整到 2 的幂页数；例如请求 3 页 -> 实际分配 4 页的块。
- init_memmap 中须保证按块对齐，否则 buddy 计算（通过异或）会失效。
- 当前实现使用 `list_add` 将新释放块插入到对应 free list 的头部（无按地址排序要求）。

测试计划

自检函数 `buddy_check` 覆盖以下场景：
- 基本的单页分配/释放
- 多页分配/释放，验证 nr_free 的正确性
- 分配导致分裂（从更高阶分裂到低阶）
- 释放并验证合并（释放相邻伙伴后形成更高阶块）

更全面测试建议（额外脚本或在 qemu 中运行）

- 随机分配/释放压力测试：随机请求不同大小的页面并统计总空闲数是否恒定、检测内存越界和重复释放。
- 边界条件：请求大于 MAX_ORDER 的页数应返回 NULL 或安全失败；请求 0 页应触发断言。

如何运行

- 构建内核：在 `lab2_Dou` 目录运行 `make`。
- 启动 QEMU 并让内核运行内置检查：可运行 `tools/grade.sh` 中相应的 quick_check 项目，或直接运行 `qemu` 加载生成的 `bin/ucore.img`。

备注

当前实现是教育用途的简化版本。在生产或完整系统中建议：
- 使用地址排序的 free list 以加速合并操作
- 支持更灵活的最大阶数与动态调整
- 提供碎片统计与回收策略

