
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00007297          	auipc	t0,0x7
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0207000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00007297          	auipc	t0,0x7
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0207008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02062b7          	lui	t0,0xc0206
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c0206137          	lui	sp,0xc0206

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 1. 使用临时寄存器 t1 计算栈顶的精确地址
    lui t1, %hi(bootstacktop)
ffffffffc0200040:	c0206337          	lui	t1,0xc0206
    addi t1, t1, %lo(bootstacktop)
ffffffffc0200044:	00030313          	mv	t1,t1
    # 2. 将精确地址一次性地、安全地传给 sp
    mv sp, t1
ffffffffc0200048:	811a                	mv	sp,t1
    # 现在栈指针已经完美设置，可以安全地调用任何C函数了
    # 然后跳转到 kern_init (不再返回)
    lui t0, %hi(kern_init)
ffffffffc020004a:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020004e:	05428293          	addi	t0,t0,84 # ffffffffc0200054 <kern_init>
    jr t0
ffffffffc0200052:	8282                	jr	t0

ffffffffc0200054 <kern_init>:
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    // 先清零 BSS，再读取并保存 DTB 的内存信息，避免被清零覆盖（为了解释变化 正式上传时我觉得应该删去这句话）
    memset(edata, 0, end - edata);
ffffffffc0200054:	00007517          	auipc	a0,0x7
ffffffffc0200058:	fd450513          	addi	a0,a0,-44 # ffffffffc0207028 <free_area>
ffffffffc020005c:	00007617          	auipc	a2,0x7
ffffffffc0200060:	44460613          	addi	a2,a2,1092 # ffffffffc02074a0 <end>
int kern_init(void) {
ffffffffc0200064:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200066:	8e09                	sub	a2,a2,a0
ffffffffc0200068:	4581                	li	a1,0
int kern_init(void) {
ffffffffc020006a:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020006c:	787010ef          	jal	ra,ffffffffc0201ff2 <memset>
    dtb_init();
ffffffffc0200070:	444000ef          	jal	ra,ffffffffc02004b4 <dtb_init>
    cons_init();  // init the console
ffffffffc0200074:	432000ef          	jal	ra,ffffffffc02004a6 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc0200078:	00002517          	auipc	a0,0x2
ffffffffc020007c:	06850513          	addi	a0,a0,104 # ffffffffc02020e0 <etext+0xdc>
ffffffffc0200080:	0c6000ef          	jal	ra,ffffffffc0200146 <cputs>

    print_kerninfo();
ffffffffc0200084:	112000ef          	jal	ra,ffffffffc0200196 <print_kerninfo>

    // grade_backtrace();
    idt_init();  // init interrupt descriptor table
ffffffffc0200088:	7e8000ef          	jal	ra,ffffffffc0200870 <idt_init>

    pmm_init();  // init physical memory management
ffffffffc020008c:	7ea010ef          	jal	ra,ffffffffc0201876 <pmm_init>

    idt_init();  // init interrupt descriptor table
ffffffffc0200090:	7e0000ef          	jal	ra,ffffffffc0200870 <idt_init>

    clock_init();   // init clock interrupt
ffffffffc0200094:	3d0000ef          	jal	ra,ffffffffc0200464 <clock_init>
    intr_enable();  // enable irq interrupt
ffffffffc0200098:	7cc000ef          	jal	ra,ffffffffc0200864 <intr_enable>

    // ==== Challenge3 quick self-test (optional) ====
    // Enable by building with: EXTRAFLAGS='-DCH3_SELFTEST'
    // Example: make EXTRAFLAGS='-DCH3_SELFTEST' -C lab3 qemu
    #ifdef CH3_SELFTEST
    cprintf("[CH3] trigger ebreak (breakpoint) test...\n");
ffffffffc020009c:	00002517          	auipc	a0,0x2
ffffffffc02000a0:	f6c50513          	addi	a0,a0,-148 # ffffffffc0202008 <etext+0x4>
ffffffffc02000a4:	06a000ef          	jal	ra,ffffffffc020010e <cprintf>
    __asm__ __volatile__("ebreak");
ffffffffc02000a8:	9002                	ebreak
    cprintf("[CH3] returned after breakpoint handler.\n");
ffffffffc02000aa:	00002517          	auipc	a0,0x2
ffffffffc02000ae:	f8e50513          	addi	a0,a0,-114 # ffffffffc0202038 <etext+0x34>
ffffffffc02000b2:	05c000ef          	jal	ra,ffffffffc020010e <cprintf>

    cprintf("[CH3] trigger illegal instruction (mret in S-mode) test...\n");
ffffffffc02000b6:	00002517          	auipc	a0,0x2
ffffffffc02000ba:	fb250513          	addi	a0,a0,-78 # ffffffffc0202068 <etext+0x64>
ffffffffc02000be:	050000ef          	jal	ra,ffffffffc020010e <cprintf>
ffffffffc02000c2:	30200073          	mret
    // Encode mret (privileged to M-mode) as a raw 32-bit instruction.
    // This will cause an Illegal instruction exception in S-mode.
    __asm__ __volatile__(".4byte 0x30200073"); // MATCH_MRET from riscv.h
    cprintf("[CH3] returned after illegal-instruction handler.\n");
ffffffffc02000c6:	00002517          	auipc	a0,0x2
ffffffffc02000ca:	fe250513          	addi	a0,a0,-30 # ffffffffc02020a8 <etext+0xa4>
ffffffffc02000ce:	040000ef          	jal	ra,ffffffffc020010e <cprintf>
    #endif

    /* do nothing */
    while (1)
ffffffffc02000d2:	a001                	j	ffffffffc02000d2 <kern_init+0x7e>

ffffffffc02000d4 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc02000d4:	1141                	addi	sp,sp,-16
ffffffffc02000d6:	e022                	sd	s0,0(sp)
ffffffffc02000d8:	e406                	sd	ra,8(sp)
ffffffffc02000da:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc02000dc:	3cc000ef          	jal	ra,ffffffffc02004a8 <cons_putc>
    (*cnt) ++;
ffffffffc02000e0:	401c                	lw	a5,0(s0)
}
ffffffffc02000e2:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc02000e4:	2785                	addiw	a5,a5,1
ffffffffc02000e6:	c01c                	sw	a5,0(s0)
}
ffffffffc02000e8:	6402                	ld	s0,0(sp)
ffffffffc02000ea:	0141                	addi	sp,sp,16
ffffffffc02000ec:	8082                	ret

ffffffffc02000ee <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000ee:	1101                	addi	sp,sp,-32
ffffffffc02000f0:	862a                	mv	a2,a0
ffffffffc02000f2:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000f4:	00000517          	auipc	a0,0x0
ffffffffc02000f8:	fe050513          	addi	a0,a0,-32 # ffffffffc02000d4 <cputch>
ffffffffc02000fc:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000fe:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc0200100:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200102:	1c1010ef          	jal	ra,ffffffffc0201ac2 <vprintfmt>
    return cnt;
}
ffffffffc0200106:	60e2                	ld	ra,24(sp)
ffffffffc0200108:	4532                	lw	a0,12(sp)
ffffffffc020010a:	6105                	addi	sp,sp,32
ffffffffc020010c:	8082                	ret

ffffffffc020010e <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc020010e:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200110:	02810313          	addi	t1,sp,40 # ffffffffc0206028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc0200114:	8e2a                	mv	t3,a0
ffffffffc0200116:	f42e                	sd	a1,40(sp)
ffffffffc0200118:	f832                	sd	a2,48(sp)
ffffffffc020011a:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc020011c:	00000517          	auipc	a0,0x0
ffffffffc0200120:	fb850513          	addi	a0,a0,-72 # ffffffffc02000d4 <cputch>
ffffffffc0200124:	004c                	addi	a1,sp,4
ffffffffc0200126:	869a                	mv	a3,t1
ffffffffc0200128:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc020012a:	ec06                	sd	ra,24(sp)
ffffffffc020012c:	e0ba                	sd	a4,64(sp)
ffffffffc020012e:	e4be                	sd	a5,72(sp)
ffffffffc0200130:	e8c2                	sd	a6,80(sp)
ffffffffc0200132:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc0200134:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc0200136:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200138:	18b010ef          	jal	ra,ffffffffc0201ac2 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc020013c:	60e2                	ld	ra,24(sp)
ffffffffc020013e:	4512                	lw	a0,4(sp)
ffffffffc0200140:	6125                	addi	sp,sp,96
ffffffffc0200142:	8082                	ret

ffffffffc0200144 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc0200144:	a695                	j	ffffffffc02004a8 <cons_putc>

ffffffffc0200146 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200146:	1101                	addi	sp,sp,-32
ffffffffc0200148:	e822                	sd	s0,16(sp)
ffffffffc020014a:	ec06                	sd	ra,24(sp)
ffffffffc020014c:	e426                	sd	s1,8(sp)
ffffffffc020014e:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc0200150:	00054503          	lbu	a0,0(a0)
ffffffffc0200154:	c51d                	beqz	a0,ffffffffc0200182 <cputs+0x3c>
ffffffffc0200156:	0405                	addi	s0,s0,1
ffffffffc0200158:	4485                	li	s1,1
ffffffffc020015a:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc020015c:	34c000ef          	jal	ra,ffffffffc02004a8 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc0200160:	00044503          	lbu	a0,0(s0)
ffffffffc0200164:	008487bb          	addw	a5,s1,s0
ffffffffc0200168:	0405                	addi	s0,s0,1
ffffffffc020016a:	f96d                	bnez	a0,ffffffffc020015c <cputs+0x16>
    (*cnt) ++;
ffffffffc020016c:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc0200170:	4529                	li	a0,10
ffffffffc0200172:	336000ef          	jal	ra,ffffffffc02004a8 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200176:	60e2                	ld	ra,24(sp)
ffffffffc0200178:	8522                	mv	a0,s0
ffffffffc020017a:	6442                	ld	s0,16(sp)
ffffffffc020017c:	64a2                	ld	s1,8(sp)
ffffffffc020017e:	6105                	addi	sp,sp,32
ffffffffc0200180:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc0200182:	4405                	li	s0,1
ffffffffc0200184:	b7f5                	j	ffffffffc0200170 <cputs+0x2a>

ffffffffc0200186 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc0200186:	1141                	addi	sp,sp,-16
ffffffffc0200188:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc020018a:	326000ef          	jal	ra,ffffffffc02004b0 <cons_getc>
ffffffffc020018e:	dd75                	beqz	a0,ffffffffc020018a <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200190:	60a2                	ld	ra,8(sp)
ffffffffc0200192:	0141                	addi	sp,sp,16
ffffffffc0200194:	8082                	ret

ffffffffc0200196 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc0200196:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc0200198:	00002517          	auipc	a0,0x2
ffffffffc020019c:	f6850513          	addi	a0,a0,-152 # ffffffffc0202100 <etext+0xfc>
void print_kerninfo(void) {
ffffffffc02001a0:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc02001a2:	f6dff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", kern_init);
ffffffffc02001a6:	00000597          	auipc	a1,0x0
ffffffffc02001aa:	eae58593          	addi	a1,a1,-338 # ffffffffc0200054 <kern_init>
ffffffffc02001ae:	00002517          	auipc	a0,0x2
ffffffffc02001b2:	f7250513          	addi	a0,a0,-142 # ffffffffc0202120 <etext+0x11c>
ffffffffc02001b6:	f59ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc02001ba:	00002597          	auipc	a1,0x2
ffffffffc02001be:	e4a58593          	addi	a1,a1,-438 # ffffffffc0202004 <etext>
ffffffffc02001c2:	00002517          	auipc	a0,0x2
ffffffffc02001c6:	f7e50513          	addi	a0,a0,-130 # ffffffffc0202140 <etext+0x13c>
ffffffffc02001ca:	f45ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc02001ce:	00007597          	auipc	a1,0x7
ffffffffc02001d2:	e5a58593          	addi	a1,a1,-422 # ffffffffc0207028 <free_area>
ffffffffc02001d6:	00002517          	auipc	a0,0x2
ffffffffc02001da:	f8a50513          	addi	a0,a0,-118 # ffffffffc0202160 <etext+0x15c>
ffffffffc02001de:	f31ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc02001e2:	00007597          	auipc	a1,0x7
ffffffffc02001e6:	2be58593          	addi	a1,a1,702 # ffffffffc02074a0 <end>
ffffffffc02001ea:	00002517          	auipc	a0,0x2
ffffffffc02001ee:	f9650513          	addi	a0,a0,-106 # ffffffffc0202180 <etext+0x17c>
ffffffffc02001f2:	f1dff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc02001f6:	00007597          	auipc	a1,0x7
ffffffffc02001fa:	6a958593          	addi	a1,a1,1705 # ffffffffc020789f <end+0x3ff>
ffffffffc02001fe:	00000797          	auipc	a5,0x0
ffffffffc0200202:	e5678793          	addi	a5,a5,-426 # ffffffffc0200054 <kern_init>
ffffffffc0200206:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020020a:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc020020e:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200210:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200214:	95be                	add	a1,a1,a5
ffffffffc0200216:	85a9                	srai	a1,a1,0xa
ffffffffc0200218:	00002517          	auipc	a0,0x2
ffffffffc020021c:	f8850513          	addi	a0,a0,-120 # ffffffffc02021a0 <etext+0x19c>
}
ffffffffc0200220:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200222:	b5f5                	j	ffffffffc020010e <cprintf>

ffffffffc0200224 <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc0200224:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc0200226:	00002617          	auipc	a2,0x2
ffffffffc020022a:	faa60613          	addi	a2,a2,-86 # ffffffffc02021d0 <etext+0x1cc>
ffffffffc020022e:	04d00593          	li	a1,77
ffffffffc0200232:	00002517          	auipc	a0,0x2
ffffffffc0200236:	fb650513          	addi	a0,a0,-74 # ffffffffc02021e8 <etext+0x1e4>
void print_stackframe(void) {
ffffffffc020023a:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc020023c:	1cc000ef          	jal	ra,ffffffffc0200408 <__panic>

ffffffffc0200240 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200240:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200242:	00002617          	auipc	a2,0x2
ffffffffc0200246:	fbe60613          	addi	a2,a2,-66 # ffffffffc0202200 <etext+0x1fc>
ffffffffc020024a:	00002597          	auipc	a1,0x2
ffffffffc020024e:	fd658593          	addi	a1,a1,-42 # ffffffffc0202220 <etext+0x21c>
ffffffffc0200252:	00002517          	auipc	a0,0x2
ffffffffc0200256:	fd650513          	addi	a0,a0,-42 # ffffffffc0202228 <etext+0x224>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc020025a:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc020025c:	eb3ff0ef          	jal	ra,ffffffffc020010e <cprintf>
ffffffffc0200260:	00002617          	auipc	a2,0x2
ffffffffc0200264:	fd860613          	addi	a2,a2,-40 # ffffffffc0202238 <etext+0x234>
ffffffffc0200268:	00002597          	auipc	a1,0x2
ffffffffc020026c:	ff858593          	addi	a1,a1,-8 # ffffffffc0202260 <etext+0x25c>
ffffffffc0200270:	00002517          	auipc	a0,0x2
ffffffffc0200274:	fb850513          	addi	a0,a0,-72 # ffffffffc0202228 <etext+0x224>
ffffffffc0200278:	e97ff0ef          	jal	ra,ffffffffc020010e <cprintf>
ffffffffc020027c:	00002617          	auipc	a2,0x2
ffffffffc0200280:	ff460613          	addi	a2,a2,-12 # ffffffffc0202270 <etext+0x26c>
ffffffffc0200284:	00002597          	auipc	a1,0x2
ffffffffc0200288:	00c58593          	addi	a1,a1,12 # ffffffffc0202290 <etext+0x28c>
ffffffffc020028c:	00002517          	auipc	a0,0x2
ffffffffc0200290:	f9c50513          	addi	a0,a0,-100 # ffffffffc0202228 <etext+0x224>
ffffffffc0200294:	e7bff0ef          	jal	ra,ffffffffc020010e <cprintf>
    }
    return 0;
}
ffffffffc0200298:	60a2                	ld	ra,8(sp)
ffffffffc020029a:	4501                	li	a0,0
ffffffffc020029c:	0141                	addi	sp,sp,16
ffffffffc020029e:	8082                	ret

ffffffffc02002a0 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002a0:	1141                	addi	sp,sp,-16
ffffffffc02002a2:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc02002a4:	ef3ff0ef          	jal	ra,ffffffffc0200196 <print_kerninfo>
    return 0;
}
ffffffffc02002a8:	60a2                	ld	ra,8(sp)
ffffffffc02002aa:	4501                	li	a0,0
ffffffffc02002ac:	0141                	addi	sp,sp,16
ffffffffc02002ae:	8082                	ret

ffffffffc02002b0 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002b0:	1141                	addi	sp,sp,-16
ffffffffc02002b2:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02002b4:	f71ff0ef          	jal	ra,ffffffffc0200224 <print_stackframe>
    return 0;
}
ffffffffc02002b8:	60a2                	ld	ra,8(sp)
ffffffffc02002ba:	4501                	li	a0,0
ffffffffc02002bc:	0141                	addi	sp,sp,16
ffffffffc02002be:	8082                	ret

ffffffffc02002c0 <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02002c0:	7115                	addi	sp,sp,-224
ffffffffc02002c2:	ed5e                	sd	s7,152(sp)
ffffffffc02002c4:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002c6:	00002517          	auipc	a0,0x2
ffffffffc02002ca:	fda50513          	addi	a0,a0,-38 # ffffffffc02022a0 <etext+0x29c>
kmonitor(struct trapframe *tf) {
ffffffffc02002ce:	ed86                	sd	ra,216(sp)
ffffffffc02002d0:	e9a2                	sd	s0,208(sp)
ffffffffc02002d2:	e5a6                	sd	s1,200(sp)
ffffffffc02002d4:	e1ca                	sd	s2,192(sp)
ffffffffc02002d6:	fd4e                	sd	s3,184(sp)
ffffffffc02002d8:	f952                	sd	s4,176(sp)
ffffffffc02002da:	f556                	sd	s5,168(sp)
ffffffffc02002dc:	f15a                	sd	s6,160(sp)
ffffffffc02002de:	e962                	sd	s8,144(sp)
ffffffffc02002e0:	e566                	sd	s9,136(sp)
ffffffffc02002e2:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002e4:	e2bff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc02002e8:	00002517          	auipc	a0,0x2
ffffffffc02002ec:	fe050513          	addi	a0,a0,-32 # ffffffffc02022c8 <etext+0x2c4>
ffffffffc02002f0:	e1fff0ef          	jal	ra,ffffffffc020010e <cprintf>
    if (tf != NULL) {
ffffffffc02002f4:	000b8563          	beqz	s7,ffffffffc02002fe <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc02002f8:	855e                	mv	a0,s7
ffffffffc02002fa:	756000ef          	jal	ra,ffffffffc0200a50 <print_trapframe>
ffffffffc02002fe:	00002c17          	auipc	s8,0x2
ffffffffc0200302:	03ac0c13          	addi	s8,s8,58 # ffffffffc0202338 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200306:	00002917          	auipc	s2,0x2
ffffffffc020030a:	fea90913          	addi	s2,s2,-22 # ffffffffc02022f0 <etext+0x2ec>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020030e:	00002497          	auipc	s1,0x2
ffffffffc0200312:	fea48493          	addi	s1,s1,-22 # ffffffffc02022f8 <etext+0x2f4>
        if (argc == MAXARGS - 1) {
ffffffffc0200316:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200318:	00002b17          	auipc	s6,0x2
ffffffffc020031c:	fe8b0b13          	addi	s6,s6,-24 # ffffffffc0202300 <etext+0x2fc>
        argv[argc ++] = buf;
ffffffffc0200320:	00002a17          	auipc	s4,0x2
ffffffffc0200324:	f00a0a13          	addi	s4,s4,-256 # ffffffffc0202220 <etext+0x21c>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200328:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc020032a:	854a                	mv	a0,s2
ffffffffc020032c:	319010ef          	jal	ra,ffffffffc0201e44 <readline>
ffffffffc0200330:	842a                	mv	s0,a0
ffffffffc0200332:	dd65                	beqz	a0,ffffffffc020032a <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200334:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc0200338:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020033a:	e1bd                	bnez	a1,ffffffffc02003a0 <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc020033c:	fe0c87e3          	beqz	s9,ffffffffc020032a <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200340:	6582                	ld	a1,0(sp)
ffffffffc0200342:	00002d17          	auipc	s10,0x2
ffffffffc0200346:	ff6d0d13          	addi	s10,s10,-10 # ffffffffc0202338 <commands>
        argv[argc ++] = buf;
ffffffffc020034a:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020034c:	4401                	li	s0,0
ffffffffc020034e:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200350:	449010ef          	jal	ra,ffffffffc0201f98 <strcmp>
ffffffffc0200354:	c919                	beqz	a0,ffffffffc020036a <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200356:	2405                	addiw	s0,s0,1
ffffffffc0200358:	0b540063          	beq	s0,s5,ffffffffc02003f8 <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020035c:	000d3503          	ld	a0,0(s10)
ffffffffc0200360:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200362:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200364:	435010ef          	jal	ra,ffffffffc0201f98 <strcmp>
ffffffffc0200368:	f57d                	bnez	a0,ffffffffc0200356 <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc020036a:	00141793          	slli	a5,s0,0x1
ffffffffc020036e:	97a2                	add	a5,a5,s0
ffffffffc0200370:	078e                	slli	a5,a5,0x3
ffffffffc0200372:	97e2                	add	a5,a5,s8
ffffffffc0200374:	6b9c                	ld	a5,16(a5)
ffffffffc0200376:	865e                	mv	a2,s7
ffffffffc0200378:	002c                	addi	a1,sp,8
ffffffffc020037a:	fffc851b          	addiw	a0,s9,-1
ffffffffc020037e:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc0200380:	fa0555e3          	bgez	a0,ffffffffc020032a <kmonitor+0x6a>
}
ffffffffc0200384:	60ee                	ld	ra,216(sp)
ffffffffc0200386:	644e                	ld	s0,208(sp)
ffffffffc0200388:	64ae                	ld	s1,200(sp)
ffffffffc020038a:	690e                	ld	s2,192(sp)
ffffffffc020038c:	79ea                	ld	s3,184(sp)
ffffffffc020038e:	7a4a                	ld	s4,176(sp)
ffffffffc0200390:	7aaa                	ld	s5,168(sp)
ffffffffc0200392:	7b0a                	ld	s6,160(sp)
ffffffffc0200394:	6bea                	ld	s7,152(sp)
ffffffffc0200396:	6c4a                	ld	s8,144(sp)
ffffffffc0200398:	6caa                	ld	s9,136(sp)
ffffffffc020039a:	6d0a                	ld	s10,128(sp)
ffffffffc020039c:	612d                	addi	sp,sp,224
ffffffffc020039e:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003a0:	8526                	mv	a0,s1
ffffffffc02003a2:	43b010ef          	jal	ra,ffffffffc0201fdc <strchr>
ffffffffc02003a6:	c901                	beqz	a0,ffffffffc02003b6 <kmonitor+0xf6>
ffffffffc02003a8:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc02003ac:	00040023          	sb	zero,0(s0)
ffffffffc02003b0:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003b2:	d5c9                	beqz	a1,ffffffffc020033c <kmonitor+0x7c>
ffffffffc02003b4:	b7f5                	j	ffffffffc02003a0 <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc02003b6:	00044783          	lbu	a5,0(s0)
ffffffffc02003ba:	d3c9                	beqz	a5,ffffffffc020033c <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc02003bc:	033c8963          	beq	s9,s3,ffffffffc02003ee <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc02003c0:	003c9793          	slli	a5,s9,0x3
ffffffffc02003c4:	0118                	addi	a4,sp,128
ffffffffc02003c6:	97ba                	add	a5,a5,a4
ffffffffc02003c8:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003cc:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02003d0:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003d2:	e591                	bnez	a1,ffffffffc02003de <kmonitor+0x11e>
ffffffffc02003d4:	b7b5                	j	ffffffffc0200340 <kmonitor+0x80>
ffffffffc02003d6:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02003da:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003dc:	d1a5                	beqz	a1,ffffffffc020033c <kmonitor+0x7c>
ffffffffc02003de:	8526                	mv	a0,s1
ffffffffc02003e0:	3fd010ef          	jal	ra,ffffffffc0201fdc <strchr>
ffffffffc02003e4:	d96d                	beqz	a0,ffffffffc02003d6 <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003e6:	00044583          	lbu	a1,0(s0)
ffffffffc02003ea:	d9a9                	beqz	a1,ffffffffc020033c <kmonitor+0x7c>
ffffffffc02003ec:	bf55                	j	ffffffffc02003a0 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003ee:	45c1                	li	a1,16
ffffffffc02003f0:	855a                	mv	a0,s6
ffffffffc02003f2:	d1dff0ef          	jal	ra,ffffffffc020010e <cprintf>
ffffffffc02003f6:	b7e9                	j	ffffffffc02003c0 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc02003f8:	6582                	ld	a1,0(sp)
ffffffffc02003fa:	00002517          	auipc	a0,0x2
ffffffffc02003fe:	f2650513          	addi	a0,a0,-218 # ffffffffc0202320 <etext+0x31c>
ffffffffc0200402:	d0dff0ef          	jal	ra,ffffffffc020010e <cprintf>
    return 0;
ffffffffc0200406:	b715                	j	ffffffffc020032a <kmonitor+0x6a>

ffffffffc0200408 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200408:	00007317          	auipc	t1,0x7
ffffffffc020040c:	03830313          	addi	t1,t1,56 # ffffffffc0207440 <is_panic>
ffffffffc0200410:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc0200414:	715d                	addi	sp,sp,-80
ffffffffc0200416:	ec06                	sd	ra,24(sp)
ffffffffc0200418:	e822                	sd	s0,16(sp)
ffffffffc020041a:	f436                	sd	a3,40(sp)
ffffffffc020041c:	f83a                	sd	a4,48(sp)
ffffffffc020041e:	fc3e                	sd	a5,56(sp)
ffffffffc0200420:	e0c2                	sd	a6,64(sp)
ffffffffc0200422:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc0200424:	020e1a63          	bnez	t3,ffffffffc0200458 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc0200428:	4785                	li	a5,1
ffffffffc020042a:	00f32023          	sw	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc020042e:	8432                	mv	s0,a2
ffffffffc0200430:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200432:	862e                	mv	a2,a1
ffffffffc0200434:	85aa                	mv	a1,a0
ffffffffc0200436:	00002517          	auipc	a0,0x2
ffffffffc020043a:	f4a50513          	addi	a0,a0,-182 # ffffffffc0202380 <commands+0x48>
    va_start(ap, fmt);
ffffffffc020043e:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200440:	ccfff0ef          	jal	ra,ffffffffc020010e <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200444:	65a2                	ld	a1,8(sp)
ffffffffc0200446:	8522                	mv	a0,s0
ffffffffc0200448:	ca7ff0ef          	jal	ra,ffffffffc02000ee <vcprintf>
    cprintf("\n");
ffffffffc020044c:	00002517          	auipc	a0,0x2
ffffffffc0200450:	c1450513          	addi	a0,a0,-1004 # ffffffffc0202060 <etext+0x5c>
ffffffffc0200454:	cbbff0ef          	jal	ra,ffffffffc020010e <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
ffffffffc0200458:	412000ef          	jal	ra,ffffffffc020086a <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc020045c:	4501                	li	a0,0
ffffffffc020045e:	e63ff0ef          	jal	ra,ffffffffc02002c0 <kmonitor>
    while (1) {
ffffffffc0200462:	bfed                	j	ffffffffc020045c <__panic+0x54>

ffffffffc0200464 <clock_init>:

/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
ffffffffc0200464:	1141                	addi	sp,sp,-16
ffffffffc0200466:	e406                	sd	ra,8(sp)
    // enable timer interrupt in sie
    set_csr(sie, MIP_STIP);
ffffffffc0200468:	02000793          	li	a5,32
ffffffffc020046c:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200470:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200474:	67e1                	lui	a5,0x18
ffffffffc0200476:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc020047a:	953e                	add	a0,a0,a5
ffffffffc020047c:	297010ef          	jal	ra,ffffffffc0201f12 <sbi_set_timer>
}
ffffffffc0200480:	60a2                	ld	ra,8(sp)
    ticks = 0;
ffffffffc0200482:	00007797          	auipc	a5,0x7
ffffffffc0200486:	fc07b323          	sd	zero,-58(a5) # ffffffffc0207448 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc020048a:	00002517          	auipc	a0,0x2
ffffffffc020048e:	f1650513          	addi	a0,a0,-234 # ffffffffc02023a0 <commands+0x68>
}
ffffffffc0200492:	0141                	addi	sp,sp,16
    cprintf("++ setup timer interrupts\n");
ffffffffc0200494:	b9ad                	j	ffffffffc020010e <cprintf>

ffffffffc0200496 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200496:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020049a:	67e1                	lui	a5,0x18
ffffffffc020049c:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc02004a0:	953e                	add	a0,a0,a5
ffffffffc02004a2:	2710106f          	j	ffffffffc0201f12 <sbi_set_timer>

ffffffffc02004a6 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc02004a6:	8082                	ret

ffffffffc02004a8 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc02004a8:	0ff57513          	zext.b	a0,a0
ffffffffc02004ac:	24d0106f          	j	ffffffffc0201ef8 <sbi_console_putchar>

ffffffffc02004b0 <cons_getc>:
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int cons_getc(void) {
    int c = 0;
    c = sbi_console_getchar();
ffffffffc02004b0:	27d0106f          	j	ffffffffc0201f2c <sbi_console_getchar>

ffffffffc02004b4 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02004b4:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc02004b6:	00002517          	auipc	a0,0x2
ffffffffc02004ba:	f0a50513          	addi	a0,a0,-246 # ffffffffc02023c0 <commands+0x88>
void dtb_init(void) {
ffffffffc02004be:	fc86                	sd	ra,120(sp)
ffffffffc02004c0:	f8a2                	sd	s0,112(sp)
ffffffffc02004c2:	e8d2                	sd	s4,80(sp)
ffffffffc02004c4:	f4a6                	sd	s1,104(sp)
ffffffffc02004c6:	f0ca                	sd	s2,96(sp)
ffffffffc02004c8:	ecce                	sd	s3,88(sp)
ffffffffc02004ca:	e4d6                	sd	s5,72(sp)
ffffffffc02004cc:	e0da                	sd	s6,64(sp)
ffffffffc02004ce:	fc5e                	sd	s7,56(sp)
ffffffffc02004d0:	f862                	sd	s8,48(sp)
ffffffffc02004d2:	f466                	sd	s9,40(sp)
ffffffffc02004d4:	f06a                	sd	s10,32(sp)
ffffffffc02004d6:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc02004d8:	c37ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc02004dc:	00007597          	auipc	a1,0x7
ffffffffc02004e0:	b245b583          	ld	a1,-1244(a1) # ffffffffc0207000 <boot_hartid>
ffffffffc02004e4:	00002517          	auipc	a0,0x2
ffffffffc02004e8:	eec50513          	addi	a0,a0,-276 # ffffffffc02023d0 <commands+0x98>
ffffffffc02004ec:	c23ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc02004f0:	00007417          	auipc	s0,0x7
ffffffffc02004f4:	b1840413          	addi	s0,s0,-1256 # ffffffffc0207008 <boot_dtb>
ffffffffc02004f8:	600c                	ld	a1,0(s0)
ffffffffc02004fa:	00002517          	auipc	a0,0x2
ffffffffc02004fe:	ee650513          	addi	a0,a0,-282 # ffffffffc02023e0 <commands+0xa8>
ffffffffc0200502:	c0dff0ef          	jal	ra,ffffffffc020010e <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200506:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc020050a:	00002517          	auipc	a0,0x2
ffffffffc020050e:	eee50513          	addi	a0,a0,-274 # ffffffffc02023f8 <commands+0xc0>
    if (boot_dtb == 0) {
ffffffffc0200512:	120a0463          	beqz	s4,ffffffffc020063a <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc0200516:	57f5                	li	a5,-3
ffffffffc0200518:	07fa                	slli	a5,a5,0x1e
ffffffffc020051a:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc020051e:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200520:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200524:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200526:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020052a:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020052e:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200532:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200536:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020053a:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020053c:	8ec9                	or	a3,a3,a0
ffffffffc020053e:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200542:	1b7d                	addi	s6,s6,-1
ffffffffc0200544:	0167f7b3          	and	a5,a5,s6
ffffffffc0200548:	8dd5                	or	a1,a1,a3
ffffffffc020054a:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc020054c:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200550:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc0200552:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed8a4d>
ffffffffc0200556:	10f59163          	bne	a1,a5,ffffffffc0200658 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc020055a:	471c                	lw	a5,8(a4)
ffffffffc020055c:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc020055e:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200560:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200564:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200568:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020056c:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200570:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200574:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200578:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020057c:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200580:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200584:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200588:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020058a:	01146433          	or	s0,s0,a7
ffffffffc020058e:	0086969b          	slliw	a3,a3,0x8
ffffffffc0200592:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200596:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200598:	0087979b          	slliw	a5,a5,0x8
ffffffffc020059c:	8c49                	or	s0,s0,a0
ffffffffc020059e:	0166f6b3          	and	a3,a3,s6
ffffffffc02005a2:	00ca6a33          	or	s4,s4,a2
ffffffffc02005a6:	0167f7b3          	and	a5,a5,s6
ffffffffc02005aa:	8c55                	or	s0,s0,a3
ffffffffc02005ac:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005b0:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005b2:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005b4:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005b6:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005ba:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005bc:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005be:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc02005c2:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02005c4:	00002917          	auipc	s2,0x2
ffffffffc02005c8:	e8490913          	addi	s2,s2,-380 # ffffffffc0202448 <commands+0x110>
ffffffffc02005cc:	49bd                	li	s3,15
        switch (token) {
ffffffffc02005ce:	4d91                	li	s11,4
ffffffffc02005d0:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02005d2:	00002497          	auipc	s1,0x2
ffffffffc02005d6:	e6e48493          	addi	s1,s1,-402 # ffffffffc0202440 <commands+0x108>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc02005da:	000a2703          	lw	a4,0(s4)
ffffffffc02005de:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005e2:	0087569b          	srliw	a3,a4,0x8
ffffffffc02005e6:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005ea:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005ee:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005f2:	0107571b          	srliw	a4,a4,0x10
ffffffffc02005f6:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005f8:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005fc:	0087171b          	slliw	a4,a4,0x8
ffffffffc0200600:	8fd5                	or	a5,a5,a3
ffffffffc0200602:	00eb7733          	and	a4,s6,a4
ffffffffc0200606:	8fd9                	or	a5,a5,a4
ffffffffc0200608:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc020060a:	09778c63          	beq	a5,s7,ffffffffc02006a2 <dtb_init+0x1ee>
ffffffffc020060e:	00fbea63          	bltu	s7,a5,ffffffffc0200622 <dtb_init+0x16e>
ffffffffc0200612:	07a78663          	beq	a5,s10,ffffffffc020067e <dtb_init+0x1ca>
ffffffffc0200616:	4709                	li	a4,2
ffffffffc0200618:	00e79763          	bne	a5,a4,ffffffffc0200626 <dtb_init+0x172>
ffffffffc020061c:	4c81                	li	s9,0
ffffffffc020061e:	8a56                	mv	s4,s5
ffffffffc0200620:	bf6d                	j	ffffffffc02005da <dtb_init+0x126>
ffffffffc0200622:	ffb78ee3          	beq	a5,s11,ffffffffc020061e <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc0200626:	00002517          	auipc	a0,0x2
ffffffffc020062a:	e9a50513          	addi	a0,a0,-358 # ffffffffc02024c0 <commands+0x188>
ffffffffc020062e:	ae1ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc0200632:	00002517          	auipc	a0,0x2
ffffffffc0200636:	ec650513          	addi	a0,a0,-314 # ffffffffc02024f8 <commands+0x1c0>
}
ffffffffc020063a:	7446                	ld	s0,112(sp)
ffffffffc020063c:	70e6                	ld	ra,120(sp)
ffffffffc020063e:	74a6                	ld	s1,104(sp)
ffffffffc0200640:	7906                	ld	s2,96(sp)
ffffffffc0200642:	69e6                	ld	s3,88(sp)
ffffffffc0200644:	6a46                	ld	s4,80(sp)
ffffffffc0200646:	6aa6                	ld	s5,72(sp)
ffffffffc0200648:	6b06                	ld	s6,64(sp)
ffffffffc020064a:	7be2                	ld	s7,56(sp)
ffffffffc020064c:	7c42                	ld	s8,48(sp)
ffffffffc020064e:	7ca2                	ld	s9,40(sp)
ffffffffc0200650:	7d02                	ld	s10,32(sp)
ffffffffc0200652:	6de2                	ld	s11,24(sp)
ffffffffc0200654:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc0200656:	bc65                	j	ffffffffc020010e <cprintf>
}
ffffffffc0200658:	7446                	ld	s0,112(sp)
ffffffffc020065a:	70e6                	ld	ra,120(sp)
ffffffffc020065c:	74a6                	ld	s1,104(sp)
ffffffffc020065e:	7906                	ld	s2,96(sp)
ffffffffc0200660:	69e6                	ld	s3,88(sp)
ffffffffc0200662:	6a46                	ld	s4,80(sp)
ffffffffc0200664:	6aa6                	ld	s5,72(sp)
ffffffffc0200666:	6b06                	ld	s6,64(sp)
ffffffffc0200668:	7be2                	ld	s7,56(sp)
ffffffffc020066a:	7c42                	ld	s8,48(sp)
ffffffffc020066c:	7ca2                	ld	s9,40(sp)
ffffffffc020066e:	7d02                	ld	s10,32(sp)
ffffffffc0200670:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200672:	00002517          	auipc	a0,0x2
ffffffffc0200676:	da650513          	addi	a0,a0,-602 # ffffffffc0202418 <commands+0xe0>
}
ffffffffc020067a:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc020067c:	bc49                	j	ffffffffc020010e <cprintf>
                int name_len = strlen(name);
ffffffffc020067e:	8556                	mv	a0,s5
ffffffffc0200680:	0e3010ef          	jal	ra,ffffffffc0201f62 <strlen>
ffffffffc0200684:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200686:	4619                	li	a2,6
ffffffffc0200688:	85a6                	mv	a1,s1
ffffffffc020068a:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc020068c:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020068e:	129010ef          	jal	ra,ffffffffc0201fb6 <strncmp>
ffffffffc0200692:	e111                	bnez	a0,ffffffffc0200696 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc0200694:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc0200696:	0a91                	addi	s5,s5,4
ffffffffc0200698:	9ad2                	add	s5,s5,s4
ffffffffc020069a:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc020069e:	8a56                	mv	s4,s5
ffffffffc02006a0:	bf2d                	j	ffffffffc02005da <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02006a2:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02006a6:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006aa:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02006ae:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b2:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006b6:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ba:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02006be:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c2:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c6:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006ca:	00eaeab3          	or	s5,s5,a4
ffffffffc02006ce:	00fb77b3          	and	a5,s6,a5
ffffffffc02006d2:	00faeab3          	or	s5,s5,a5
ffffffffc02006d6:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006d8:	000c9c63          	bnez	s9,ffffffffc02006f0 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc02006dc:	1a82                	slli	s5,s5,0x20
ffffffffc02006de:	00368793          	addi	a5,a3,3
ffffffffc02006e2:	020ada93          	srli	s5,s5,0x20
ffffffffc02006e6:	9abe                	add	s5,s5,a5
ffffffffc02006e8:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02006ec:	8a56                	mv	s4,s5
ffffffffc02006ee:	b5f5                	j	ffffffffc02005da <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02006f0:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006f4:	85ca                	mv	a1,s2
ffffffffc02006f6:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006f8:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006fc:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200700:	0187971b          	slliw	a4,a5,0x18
ffffffffc0200704:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200708:	0107d79b          	srliw	a5,a5,0x10
ffffffffc020070c:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020070e:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200712:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200716:	8d59                	or	a0,a0,a4
ffffffffc0200718:	00fb77b3          	and	a5,s6,a5
ffffffffc020071c:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc020071e:	1502                	slli	a0,a0,0x20
ffffffffc0200720:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200722:	9522                	add	a0,a0,s0
ffffffffc0200724:	075010ef          	jal	ra,ffffffffc0201f98 <strcmp>
ffffffffc0200728:	66a2                	ld	a3,8(sp)
ffffffffc020072a:	f94d                	bnez	a0,ffffffffc02006dc <dtb_init+0x228>
ffffffffc020072c:	fb59f8e3          	bgeu	s3,s5,ffffffffc02006dc <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc0200730:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc0200734:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200738:	00002517          	auipc	a0,0x2
ffffffffc020073c:	d1850513          	addi	a0,a0,-744 # ffffffffc0202450 <commands+0x118>
           fdt32_to_cpu(x >> 32);
ffffffffc0200740:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200744:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc0200748:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020074c:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200750:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200754:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200758:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020075c:	0187d693          	srli	a3,a5,0x18
ffffffffc0200760:	01861f1b          	slliw	t5,a2,0x18
ffffffffc0200764:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200768:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020076c:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200770:	010f6f33          	or	t5,t5,a6
ffffffffc0200774:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200778:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020077c:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200780:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200784:	0186f6b3          	and	a3,a3,s8
ffffffffc0200788:	01859e1b          	slliw	t3,a1,0x18
ffffffffc020078c:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200790:	0107581b          	srliw	a6,a4,0x10
ffffffffc0200794:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200798:	8361                	srli	a4,a4,0x18
ffffffffc020079a:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020079e:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02007a2:	01e6e6b3          	or	a3,a3,t5
ffffffffc02007a6:	00cb7633          	and	a2,s6,a2
ffffffffc02007aa:	0088181b          	slliw	a6,a6,0x8
ffffffffc02007ae:	0085959b          	slliw	a1,a1,0x8
ffffffffc02007b2:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007b6:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007ba:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007be:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007c2:	0088989b          	slliw	a7,a7,0x8
ffffffffc02007c6:	011b78b3          	and	a7,s6,a7
ffffffffc02007ca:	005eeeb3          	or	t4,t4,t0
ffffffffc02007ce:	00c6e733          	or	a4,a3,a2
ffffffffc02007d2:	006c6c33          	or	s8,s8,t1
ffffffffc02007d6:	010b76b3          	and	a3,s6,a6
ffffffffc02007da:	00bb7b33          	and	s6,s6,a1
ffffffffc02007de:	01d7e7b3          	or	a5,a5,t4
ffffffffc02007e2:	016c6b33          	or	s6,s8,s6
ffffffffc02007e6:	01146433          	or	s0,s0,a7
ffffffffc02007ea:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc02007ec:	1702                	slli	a4,a4,0x20
ffffffffc02007ee:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007f0:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007f2:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007f4:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007f6:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007fa:	0167eb33          	or	s6,a5,s6
ffffffffc02007fe:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200800:	90fff0ef          	jal	ra,ffffffffc020010e <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc0200804:	85a2                	mv	a1,s0
ffffffffc0200806:	00002517          	auipc	a0,0x2
ffffffffc020080a:	c6a50513          	addi	a0,a0,-918 # ffffffffc0202470 <commands+0x138>
ffffffffc020080e:	901ff0ef          	jal	ra,ffffffffc020010e <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc0200812:	014b5613          	srli	a2,s6,0x14
ffffffffc0200816:	85da                	mv	a1,s6
ffffffffc0200818:	00002517          	auipc	a0,0x2
ffffffffc020081c:	c7050513          	addi	a0,a0,-912 # ffffffffc0202488 <commands+0x150>
ffffffffc0200820:	8efff0ef          	jal	ra,ffffffffc020010e <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200824:	008b05b3          	add	a1,s6,s0
ffffffffc0200828:	15fd                	addi	a1,a1,-1
ffffffffc020082a:	00002517          	auipc	a0,0x2
ffffffffc020082e:	c7e50513          	addi	a0,a0,-898 # ffffffffc02024a8 <commands+0x170>
ffffffffc0200832:	8ddff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("DTB init completed\n");
ffffffffc0200836:	00002517          	auipc	a0,0x2
ffffffffc020083a:	cc250513          	addi	a0,a0,-830 # ffffffffc02024f8 <commands+0x1c0>
        memory_base = mem_base;
ffffffffc020083e:	00007797          	auipc	a5,0x7
ffffffffc0200842:	c087b923          	sd	s0,-1006(a5) # ffffffffc0207450 <memory_base>
        memory_size = mem_size;
ffffffffc0200846:	00007797          	auipc	a5,0x7
ffffffffc020084a:	c167b923          	sd	s6,-1006(a5) # ffffffffc0207458 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc020084e:	b3f5                	j	ffffffffc020063a <dtb_init+0x186>

ffffffffc0200850 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc0200850:	00007517          	auipc	a0,0x7
ffffffffc0200854:	c0053503          	ld	a0,-1024(a0) # ffffffffc0207450 <memory_base>
ffffffffc0200858:	8082                	ret

ffffffffc020085a <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc020085a:	00007517          	auipc	a0,0x7
ffffffffc020085e:	bfe53503          	ld	a0,-1026(a0) # ffffffffc0207458 <memory_size>
ffffffffc0200862:	8082                	ret

ffffffffc0200864 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200864:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200868:	8082                	ret

ffffffffc020086a <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc020086a:	100177f3          	csrrci	a5,sstatus,2
ffffffffc020086e:	8082                	ret

ffffffffc0200870 <idt_init>:
     */

    extern void __alltraps(void);
    /* Set sup0 scratch register to 0, indicating to exception vector
       that we are presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200870:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc0200874:	00000797          	auipc	a5,0x0
ffffffffc0200878:	3bc78793          	addi	a5,a5,956 # ffffffffc0200c30 <__alltraps>
ffffffffc020087c:	10579073          	csrw	stvec,a5
}
ffffffffc0200880:	8082                	ret

ffffffffc0200882 <print_regs>:
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200882:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs *gpr) {
ffffffffc0200884:	1141                	addi	sp,sp,-16
ffffffffc0200886:	e022                	sd	s0,0(sp)
ffffffffc0200888:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020088a:	00002517          	auipc	a0,0x2
ffffffffc020088e:	c8650513          	addi	a0,a0,-890 # ffffffffc0202510 <commands+0x1d8>
void print_regs(struct pushregs *gpr) {
ffffffffc0200892:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200894:	87bff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200898:	640c                	ld	a1,8(s0)
ffffffffc020089a:	00002517          	auipc	a0,0x2
ffffffffc020089e:	c8e50513          	addi	a0,a0,-882 # ffffffffc0202528 <commands+0x1f0>
ffffffffc02008a2:	86dff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02008a6:	680c                	ld	a1,16(s0)
ffffffffc02008a8:	00002517          	auipc	a0,0x2
ffffffffc02008ac:	c9850513          	addi	a0,a0,-872 # ffffffffc0202540 <commands+0x208>
ffffffffc02008b0:	85fff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc02008b4:	6c0c                	ld	a1,24(s0)
ffffffffc02008b6:	00002517          	auipc	a0,0x2
ffffffffc02008ba:	ca250513          	addi	a0,a0,-862 # ffffffffc0202558 <commands+0x220>
ffffffffc02008be:	851ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc02008c2:	700c                	ld	a1,32(s0)
ffffffffc02008c4:	00002517          	auipc	a0,0x2
ffffffffc02008c8:	cac50513          	addi	a0,a0,-852 # ffffffffc0202570 <commands+0x238>
ffffffffc02008cc:	843ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02008d0:	740c                	ld	a1,40(s0)
ffffffffc02008d2:	00002517          	auipc	a0,0x2
ffffffffc02008d6:	cb650513          	addi	a0,a0,-842 # ffffffffc0202588 <commands+0x250>
ffffffffc02008da:	835ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02008de:	780c                	ld	a1,48(s0)
ffffffffc02008e0:	00002517          	auipc	a0,0x2
ffffffffc02008e4:	cc050513          	addi	a0,a0,-832 # ffffffffc02025a0 <commands+0x268>
ffffffffc02008e8:	827ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02008ec:	7c0c                	ld	a1,56(s0)
ffffffffc02008ee:	00002517          	auipc	a0,0x2
ffffffffc02008f2:	cca50513          	addi	a0,a0,-822 # ffffffffc02025b8 <commands+0x280>
ffffffffc02008f6:	819ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02008fa:	602c                	ld	a1,64(s0)
ffffffffc02008fc:	00002517          	auipc	a0,0x2
ffffffffc0200900:	cd450513          	addi	a0,a0,-812 # ffffffffc02025d0 <commands+0x298>
ffffffffc0200904:	80bff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200908:	642c                	ld	a1,72(s0)
ffffffffc020090a:	00002517          	auipc	a0,0x2
ffffffffc020090e:	cde50513          	addi	a0,a0,-802 # ffffffffc02025e8 <commands+0x2b0>
ffffffffc0200912:	ffcff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200916:	682c                	ld	a1,80(s0)
ffffffffc0200918:	00002517          	auipc	a0,0x2
ffffffffc020091c:	ce850513          	addi	a0,a0,-792 # ffffffffc0202600 <commands+0x2c8>
ffffffffc0200920:	feeff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200924:	6c2c                	ld	a1,88(s0)
ffffffffc0200926:	00002517          	auipc	a0,0x2
ffffffffc020092a:	cf250513          	addi	a0,a0,-782 # ffffffffc0202618 <commands+0x2e0>
ffffffffc020092e:	fe0ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200932:	702c                	ld	a1,96(s0)
ffffffffc0200934:	00002517          	auipc	a0,0x2
ffffffffc0200938:	cfc50513          	addi	a0,a0,-772 # ffffffffc0202630 <commands+0x2f8>
ffffffffc020093c:	fd2ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200940:	742c                	ld	a1,104(s0)
ffffffffc0200942:	00002517          	auipc	a0,0x2
ffffffffc0200946:	d0650513          	addi	a0,a0,-762 # ffffffffc0202648 <commands+0x310>
ffffffffc020094a:	fc4ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc020094e:	782c                	ld	a1,112(s0)
ffffffffc0200950:	00002517          	auipc	a0,0x2
ffffffffc0200954:	d1050513          	addi	a0,a0,-752 # ffffffffc0202660 <commands+0x328>
ffffffffc0200958:	fb6ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc020095c:	7c2c                	ld	a1,120(s0)
ffffffffc020095e:	00002517          	auipc	a0,0x2
ffffffffc0200962:	d1a50513          	addi	a0,a0,-742 # ffffffffc0202678 <commands+0x340>
ffffffffc0200966:	fa8ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc020096a:	604c                	ld	a1,128(s0)
ffffffffc020096c:	00002517          	auipc	a0,0x2
ffffffffc0200970:	d2450513          	addi	a0,a0,-732 # ffffffffc0202690 <commands+0x358>
ffffffffc0200974:	f9aff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200978:	644c                	ld	a1,136(s0)
ffffffffc020097a:	00002517          	auipc	a0,0x2
ffffffffc020097e:	d2e50513          	addi	a0,a0,-722 # ffffffffc02026a8 <commands+0x370>
ffffffffc0200982:	f8cff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200986:	684c                	ld	a1,144(s0)
ffffffffc0200988:	00002517          	auipc	a0,0x2
ffffffffc020098c:	d3850513          	addi	a0,a0,-712 # ffffffffc02026c0 <commands+0x388>
ffffffffc0200990:	f7eff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200994:	6c4c                	ld	a1,152(s0)
ffffffffc0200996:	00002517          	auipc	a0,0x2
ffffffffc020099a:	d4250513          	addi	a0,a0,-702 # ffffffffc02026d8 <commands+0x3a0>
ffffffffc020099e:	f70ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc02009a2:	704c                	ld	a1,160(s0)
ffffffffc02009a4:	00002517          	auipc	a0,0x2
ffffffffc02009a8:	d4c50513          	addi	a0,a0,-692 # ffffffffc02026f0 <commands+0x3b8>
ffffffffc02009ac:	f62ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc02009b0:	744c                	ld	a1,168(s0)
ffffffffc02009b2:	00002517          	auipc	a0,0x2
ffffffffc02009b6:	d5650513          	addi	a0,a0,-682 # ffffffffc0202708 <commands+0x3d0>
ffffffffc02009ba:	f54ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc02009be:	784c                	ld	a1,176(s0)
ffffffffc02009c0:	00002517          	auipc	a0,0x2
ffffffffc02009c4:	d6050513          	addi	a0,a0,-672 # ffffffffc0202720 <commands+0x3e8>
ffffffffc02009c8:	f46ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc02009cc:	7c4c                	ld	a1,184(s0)
ffffffffc02009ce:	00002517          	auipc	a0,0x2
ffffffffc02009d2:	d6a50513          	addi	a0,a0,-662 # ffffffffc0202738 <commands+0x400>
ffffffffc02009d6:	f38ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02009da:	606c                	ld	a1,192(s0)
ffffffffc02009dc:	00002517          	auipc	a0,0x2
ffffffffc02009e0:	d7450513          	addi	a0,a0,-652 # ffffffffc0202750 <commands+0x418>
ffffffffc02009e4:	f2aff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02009e8:	646c                	ld	a1,200(s0)
ffffffffc02009ea:	00002517          	auipc	a0,0x2
ffffffffc02009ee:	d7e50513          	addi	a0,a0,-642 # ffffffffc0202768 <commands+0x430>
ffffffffc02009f2:	f1cff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02009f6:	686c                	ld	a1,208(s0)
ffffffffc02009f8:	00002517          	auipc	a0,0x2
ffffffffc02009fc:	d8850513          	addi	a0,a0,-632 # ffffffffc0202780 <commands+0x448>
ffffffffc0200a00:	f0eff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200a04:	6c6c                	ld	a1,216(s0)
ffffffffc0200a06:	00002517          	auipc	a0,0x2
ffffffffc0200a0a:	d9250513          	addi	a0,a0,-622 # ffffffffc0202798 <commands+0x460>
ffffffffc0200a0e:	f00ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200a12:	706c                	ld	a1,224(s0)
ffffffffc0200a14:	00002517          	auipc	a0,0x2
ffffffffc0200a18:	d9c50513          	addi	a0,a0,-612 # ffffffffc02027b0 <commands+0x478>
ffffffffc0200a1c:	ef2ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200a20:	746c                	ld	a1,232(s0)
ffffffffc0200a22:	00002517          	auipc	a0,0x2
ffffffffc0200a26:	da650513          	addi	a0,a0,-602 # ffffffffc02027c8 <commands+0x490>
ffffffffc0200a2a:	ee4ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200a2e:	786c                	ld	a1,240(s0)
ffffffffc0200a30:	00002517          	auipc	a0,0x2
ffffffffc0200a34:	db050513          	addi	a0,a0,-592 # ffffffffc02027e0 <commands+0x4a8>
ffffffffc0200a38:	ed6ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a3c:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200a3e:	6402                	ld	s0,0(sp)
ffffffffc0200a40:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a42:	00002517          	auipc	a0,0x2
ffffffffc0200a46:	db650513          	addi	a0,a0,-586 # ffffffffc02027f8 <commands+0x4c0>
}
ffffffffc0200a4a:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a4c:	ec2ff06f          	j	ffffffffc020010e <cprintf>

ffffffffc0200a50 <print_trapframe>:
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a50:	1141                	addi	sp,sp,-16
ffffffffc0200a52:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a54:	85aa                	mv	a1,a0
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a56:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a58:	00002517          	auipc	a0,0x2
ffffffffc0200a5c:	db850513          	addi	a0,a0,-584 # ffffffffc0202810 <commands+0x4d8>
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a60:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a62:	eacff0ef          	jal	ra,ffffffffc020010e <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200a66:	8522                	mv	a0,s0
ffffffffc0200a68:	e1bff0ef          	jal	ra,ffffffffc0200882 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200a6c:	10043583          	ld	a1,256(s0)
ffffffffc0200a70:	00002517          	auipc	a0,0x2
ffffffffc0200a74:	db850513          	addi	a0,a0,-584 # ffffffffc0202828 <commands+0x4f0>
ffffffffc0200a78:	e96ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200a7c:	10843583          	ld	a1,264(s0)
ffffffffc0200a80:	00002517          	auipc	a0,0x2
ffffffffc0200a84:	dc050513          	addi	a0,a0,-576 # ffffffffc0202840 <commands+0x508>
ffffffffc0200a88:	e86ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
ffffffffc0200a8c:	11043583          	ld	a1,272(s0)
ffffffffc0200a90:	00002517          	auipc	a0,0x2
ffffffffc0200a94:	dc850513          	addi	a0,a0,-568 # ffffffffc0202858 <commands+0x520>
ffffffffc0200a98:	e76ff0ef          	jal	ra,ffffffffc020010e <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a9c:	11843583          	ld	a1,280(s0)
}
ffffffffc0200aa0:	6402                	ld	s0,0(sp)
ffffffffc0200aa2:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200aa4:	00002517          	auipc	a0,0x2
ffffffffc0200aa8:	dcc50513          	addi	a0,a0,-564 # ffffffffc0202870 <commands+0x538>
}
ffffffffc0200aac:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200aae:	e60ff06f          	j	ffffffffc020010e <cprintf>

ffffffffc0200ab2 <interrupt_handler>:

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200ab2:	11853783          	ld	a5,280(a0)
ffffffffc0200ab6:	472d                	li	a4,11
ffffffffc0200ab8:	0786                	slli	a5,a5,0x1
ffffffffc0200aba:	8385                	srli	a5,a5,0x1
ffffffffc0200abc:	08f76363          	bltu	a4,a5,ffffffffc0200b42 <interrupt_handler+0x90>
ffffffffc0200ac0:	00002717          	auipc	a4,0x2
ffffffffc0200ac4:	e9070713          	addi	a4,a4,-368 # ffffffffc0202950 <commands+0x618>
ffffffffc0200ac8:	078a                	slli	a5,a5,0x2
ffffffffc0200aca:	97ba                	add	a5,a5,a4
ffffffffc0200acc:	439c                	lw	a5,0(a5)
ffffffffc0200ace:	97ba                	add	a5,a5,a4
ffffffffc0200ad0:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc0200ad2:	00002517          	auipc	a0,0x2
ffffffffc0200ad6:	e1650513          	addi	a0,a0,-490 # ffffffffc02028e8 <commands+0x5b0>
ffffffffc0200ada:	e34ff06f          	j	ffffffffc020010e <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc0200ade:	00002517          	auipc	a0,0x2
ffffffffc0200ae2:	dea50513          	addi	a0,a0,-534 # ffffffffc02028c8 <commands+0x590>
ffffffffc0200ae6:	e28ff06f          	j	ffffffffc020010e <cprintf>
            cprintf("User software interrupt\n");
ffffffffc0200aea:	00002517          	auipc	a0,0x2
ffffffffc0200aee:	d9e50513          	addi	a0,a0,-610 # ffffffffc0202888 <commands+0x550>
ffffffffc0200af2:	e1cff06f          	j	ffffffffc020010e <cprintf>
            break;
        case IRQ_U_TIMER:
            cprintf("User Timer interrupt\n");
ffffffffc0200af6:	00002517          	auipc	a0,0x2
ffffffffc0200afa:	e1250513          	addi	a0,a0,-494 # ffffffffc0202908 <commands+0x5d0>
ffffffffc0200afe:	e10ff06f          	j	ffffffffc020010e <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc0200b02:	1141                	addi	sp,sp,-16
ffffffffc0200b04:	e406                	sd	ra,8(sp)
            /*(1)设置下次时钟中断- clock_set_next_event()
             *(2)计数器（ticks）加一
             *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
            * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
            */
            clock_set_next_event();
ffffffffc0200b06:	991ff0ef          	jal	ra,ffffffffc0200496 <clock_set_next_event>
            extern volatile size_t ticks;
            ticks++;
ffffffffc0200b0a:	00007797          	auipc	a5,0x7
ffffffffc0200b0e:	93e78793          	addi	a5,a5,-1730 # ffffffffc0207448 <ticks>
ffffffffc0200b12:	6398                	ld	a4,0(a5)
ffffffffc0200b14:	0705                	addi	a4,a4,1
ffffffffc0200b16:	e398                	sd	a4,0(a5)
            if (ticks % TICK_NUM == 0) {
ffffffffc0200b18:	639c                	ld	a5,0(a5)
ffffffffc0200b1a:	06400713          	li	a4,100
ffffffffc0200b1e:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200b22:	c38d                	beqz	a5,ffffffffc0200b44 <interrupt_handler+0x92>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200b24:	60a2                	ld	ra,8(sp)
ffffffffc0200b26:	0141                	addi	sp,sp,16
ffffffffc0200b28:	8082                	ret
            cprintf("Supervisor external interrupt\n");
ffffffffc0200b2a:	00002517          	auipc	a0,0x2
ffffffffc0200b2e:	e0650513          	addi	a0,a0,-506 # ffffffffc0202930 <commands+0x5f8>
ffffffffc0200b32:	ddcff06f          	j	ffffffffc020010e <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc0200b36:	00002517          	auipc	a0,0x2
ffffffffc0200b3a:	d7250513          	addi	a0,a0,-654 # ffffffffc02028a8 <commands+0x570>
ffffffffc0200b3e:	dd0ff06f          	j	ffffffffc020010e <cprintf>
            print_trapframe(tf);
ffffffffc0200b42:	b739                	j	ffffffffc0200a50 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200b44:	06400593          	li	a1,100
ffffffffc0200b48:	00002517          	auipc	a0,0x2
ffffffffc0200b4c:	dd850513          	addi	a0,a0,-552 # ffffffffc0202920 <commands+0x5e8>
ffffffffc0200b50:	dbeff0ef          	jal	ra,ffffffffc020010e <cprintf>
                tick_print_times++;
ffffffffc0200b54:	00007717          	auipc	a4,0x7
ffffffffc0200b58:	90c70713          	addi	a4,a4,-1780 # ffffffffc0207460 <tick_print_times>
ffffffffc0200b5c:	631c                	ld	a5,0(a4)
                if (tick_print_times >= 10) {
ffffffffc0200b5e:	46a5                	li	a3,9
                tick_print_times++;
ffffffffc0200b60:	0785                	addi	a5,a5,1
ffffffffc0200b62:	e31c                	sd	a5,0(a4)
                if (tick_print_times >= 10) {
ffffffffc0200b64:	fcf6f0e3          	bgeu	a3,a5,ffffffffc0200b24 <interrupt_handler+0x72>
}
ffffffffc0200b68:	60a2                	ld	ra,8(sp)
ffffffffc0200b6a:	0141                	addi	sp,sp,16
                    sbi_shutdown();
ffffffffc0200b6c:	3dc0106f          	j	ffffffffc0201f48 <sbi_shutdown>

ffffffffc0200b70 <exception_handler>:

void exception_handler(struct trapframe *tf) {
ffffffffc0200b70:	1101                	addi	sp,sp,-32
ffffffffc0200b72:	e822                	sd	s0,16(sp)
    switch (tf->cause) {
ffffffffc0200b74:	11853403          	ld	s0,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc0200b78:	e426                	sd	s1,8(sp)
ffffffffc0200b7a:	e04a                	sd	s2,0(sp)
ffffffffc0200b7c:	ec06                	sd	ra,24(sp)
    switch (tf->cause) {
ffffffffc0200b7e:	490d                	li	s2,3
void exception_handler(struct trapframe *tf) {
ffffffffc0200b80:	84aa                	mv	s1,a0
    switch (tf->cause) {
ffffffffc0200b82:	05240f63          	beq	s0,s2,ffffffffc0200be0 <exception_handler+0x70>
ffffffffc0200b86:	04896363          	bltu	s2,s0,ffffffffc0200bcc <exception_handler+0x5c>
ffffffffc0200b8a:	4789                	li	a5,2
ffffffffc0200b8c:	02f41a63          	bne	s0,a5,ffffffffc0200bc0 <exception_handler+0x50>
             /* LAB3 CHALLENGE3   YOUR CODE :  */
            /*(1)输出指令异常类型（ Illegal instruction）
             *(2)输出异常指令地址
             *(3)更新 tf->epc寄存器
            */
            cprintf("Illegal instruction caught at 0x%08x\n", tf->epc);
ffffffffc0200b90:	10853583          	ld	a1,264(a0)
ffffffffc0200b94:	00002517          	auipc	a0,0x2
ffffffffc0200b98:	dec50513          	addi	a0,a0,-532 # ffffffffc0202980 <commands+0x648>
ffffffffc0200b9c:	d72ff0ef          	jal	ra,ffffffffc020010e <cprintf>
            cprintf("Exception type:Illegal instruction\n");
ffffffffc0200ba0:	00002517          	auipc	a0,0x2
ffffffffc0200ba4:	e0850513          	addi	a0,a0,-504 # ffffffffc02029a8 <commands+0x670>
ffffffffc0200ba8:	d66ff0ef          	jal	ra,ffffffffc020010e <cprintf>
            {
                // advance sepc to skip the faulting instruction (handle RVC)
                uint16_t first_half = *(uint16_t *)(tf->epc);
ffffffffc0200bac:	1084b783          	ld	a5,264(s1)
                tf->epc += ((first_half & 0x3) == 0x3) ? 4 : 2;
ffffffffc0200bb0:	0007d703          	lhu	a4,0(a5)
ffffffffc0200bb4:	8b0d                	andi	a4,a4,3
ffffffffc0200bb6:	07270563          	beq	a4,s2,ffffffffc0200c20 <exception_handler+0xb0>
ffffffffc0200bba:	97a2                	add	a5,a5,s0
ffffffffc0200bbc:	10f4b423          	sd	a5,264(s1)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200bc0:	60e2                	ld	ra,24(sp)
ffffffffc0200bc2:	6442                	ld	s0,16(sp)
ffffffffc0200bc4:	64a2                	ld	s1,8(sp)
ffffffffc0200bc6:	6902                	ld	s2,0(sp)
ffffffffc0200bc8:	6105                	addi	sp,sp,32
ffffffffc0200bca:	8082                	ret
    switch (tf->cause) {
ffffffffc0200bcc:	1471                	addi	s0,s0,-4
ffffffffc0200bce:	479d                	li	a5,7
ffffffffc0200bd0:	fe87f8e3          	bgeu	a5,s0,ffffffffc0200bc0 <exception_handler+0x50>
}
ffffffffc0200bd4:	6442                	ld	s0,16(sp)
ffffffffc0200bd6:	60e2                	ld	ra,24(sp)
ffffffffc0200bd8:	64a2                	ld	s1,8(sp)
ffffffffc0200bda:	6902                	ld	s2,0(sp)
ffffffffc0200bdc:	6105                	addi	sp,sp,32
            print_trapframe(tf);
ffffffffc0200bde:	bd8d                	j	ffffffffc0200a50 <print_trapframe>
            cprintf("ebreak caught at 0x%08x\n", tf->epc);
ffffffffc0200be0:	10853583          	ld	a1,264(a0)
ffffffffc0200be4:	00002517          	auipc	a0,0x2
ffffffffc0200be8:	dec50513          	addi	a0,a0,-532 # ffffffffc02029d0 <commands+0x698>
ffffffffc0200bec:	d22ff0ef          	jal	ra,ffffffffc020010e <cprintf>
            cprintf("Exception type: breakpoint\n");
ffffffffc0200bf0:	00002517          	auipc	a0,0x2
ffffffffc0200bf4:	e0050513          	addi	a0,a0,-512 # ffffffffc02029f0 <commands+0x6b8>
ffffffffc0200bf8:	d16ff0ef          	jal	ra,ffffffffc020010e <cprintf>
                uint16_t first_half = *(uint16_t *)(tf->epc);
ffffffffc0200bfc:	1084b783          	ld	a5,264(s1)
                tf->epc += ((first_half & 0x3) == 0x3) ? 4 : 2;
ffffffffc0200c00:	4691                	li	a3,4
ffffffffc0200c02:	0007d703          	lhu	a4,0(a5)
ffffffffc0200c06:	8b0d                	andi	a4,a4,3
ffffffffc0200c08:	00870363          	beq	a4,s0,ffffffffc0200c0e <exception_handler+0x9e>
ffffffffc0200c0c:	4689                	li	a3,2
}
ffffffffc0200c0e:	60e2                	ld	ra,24(sp)
ffffffffc0200c10:	6442                	ld	s0,16(sp)
                tf->epc += ((first_half & 0x3) == 0x3) ? 4 : 2;
ffffffffc0200c12:	97b6                	add	a5,a5,a3
ffffffffc0200c14:	10f4b423          	sd	a5,264(s1)
}
ffffffffc0200c18:	6902                	ld	s2,0(sp)
ffffffffc0200c1a:	64a2                	ld	s1,8(sp)
ffffffffc0200c1c:	6105                	addi	sp,sp,32
ffffffffc0200c1e:	8082                	ret
                tf->epc += ((first_half & 0x3) == 0x3) ? 4 : 2;
ffffffffc0200c20:	4411                	li	s0,4
ffffffffc0200c22:	bf61                	j	ffffffffc0200bba <exception_handler+0x4a>

ffffffffc0200c24 <trap>:

static inline void trap_dispatch(struct trapframe *tf) {
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c24:	11853783          	ld	a5,280(a0)
ffffffffc0200c28:	0007c363          	bltz	a5,ffffffffc0200c2e <trap+0xa>
        // interrupts
        interrupt_handler(tf);
    } else {
        // exceptions
        exception_handler(tf);
ffffffffc0200c2c:	b791                	j	ffffffffc0200b70 <exception_handler>
        interrupt_handler(tf);
ffffffffc0200c2e:	b551                	j	ffffffffc0200ab2 <interrupt_handler>

ffffffffc0200c30 <__alltraps>:
    .endm

    .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
ffffffffc0200c30:	14011073          	csrw	sscratch,sp
ffffffffc0200c34:	712d                	addi	sp,sp,-288
ffffffffc0200c36:	e002                	sd	zero,0(sp)
ffffffffc0200c38:	e406                	sd	ra,8(sp)
ffffffffc0200c3a:	ec0e                	sd	gp,24(sp)
ffffffffc0200c3c:	f012                	sd	tp,32(sp)
ffffffffc0200c3e:	f416                	sd	t0,40(sp)
ffffffffc0200c40:	f81a                	sd	t1,48(sp)
ffffffffc0200c42:	fc1e                	sd	t2,56(sp)
ffffffffc0200c44:	e0a2                	sd	s0,64(sp)
ffffffffc0200c46:	e4a6                	sd	s1,72(sp)
ffffffffc0200c48:	e8aa                	sd	a0,80(sp)
ffffffffc0200c4a:	ecae                	sd	a1,88(sp)
ffffffffc0200c4c:	f0b2                	sd	a2,96(sp)
ffffffffc0200c4e:	f4b6                	sd	a3,104(sp)
ffffffffc0200c50:	f8ba                	sd	a4,112(sp)
ffffffffc0200c52:	fcbe                	sd	a5,120(sp)
ffffffffc0200c54:	e142                	sd	a6,128(sp)
ffffffffc0200c56:	e546                	sd	a7,136(sp)
ffffffffc0200c58:	e94a                	sd	s2,144(sp)
ffffffffc0200c5a:	ed4e                	sd	s3,152(sp)
ffffffffc0200c5c:	f152                	sd	s4,160(sp)
ffffffffc0200c5e:	f556                	sd	s5,168(sp)
ffffffffc0200c60:	f95a                	sd	s6,176(sp)
ffffffffc0200c62:	fd5e                	sd	s7,184(sp)
ffffffffc0200c64:	e1e2                	sd	s8,192(sp)
ffffffffc0200c66:	e5e6                	sd	s9,200(sp)
ffffffffc0200c68:	e9ea                	sd	s10,208(sp)
ffffffffc0200c6a:	edee                	sd	s11,216(sp)
ffffffffc0200c6c:	f1f2                	sd	t3,224(sp)
ffffffffc0200c6e:	f5f6                	sd	t4,232(sp)
ffffffffc0200c70:	f9fa                	sd	t5,240(sp)
ffffffffc0200c72:	fdfe                	sd	t6,248(sp)
ffffffffc0200c74:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200c78:	100024f3          	csrr	s1,sstatus
ffffffffc0200c7c:	14102973          	csrr	s2,sepc
ffffffffc0200c80:	143029f3          	csrr	s3,stval
ffffffffc0200c84:	14202a73          	csrr	s4,scause
ffffffffc0200c88:	e822                	sd	s0,16(sp)
ffffffffc0200c8a:	e226                	sd	s1,256(sp)
ffffffffc0200c8c:	e64a                	sd	s2,264(sp)
ffffffffc0200c8e:	ea4e                	sd	s3,272(sp)
ffffffffc0200c90:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200c92:	850a                	mv	a0,sp
    jal trap
ffffffffc0200c94:	f91ff0ef          	jal	ra,ffffffffc0200c24 <trap>

ffffffffc0200c98 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200c98:	6492                	ld	s1,256(sp)
ffffffffc0200c9a:	6932                	ld	s2,264(sp)
ffffffffc0200c9c:	10049073          	csrw	sstatus,s1
ffffffffc0200ca0:	14191073          	csrw	sepc,s2
ffffffffc0200ca4:	60a2                	ld	ra,8(sp)
ffffffffc0200ca6:	61e2                	ld	gp,24(sp)
ffffffffc0200ca8:	7202                	ld	tp,32(sp)
ffffffffc0200caa:	72a2                	ld	t0,40(sp)
ffffffffc0200cac:	7342                	ld	t1,48(sp)
ffffffffc0200cae:	73e2                	ld	t2,56(sp)
ffffffffc0200cb0:	6406                	ld	s0,64(sp)
ffffffffc0200cb2:	64a6                	ld	s1,72(sp)
ffffffffc0200cb4:	6546                	ld	a0,80(sp)
ffffffffc0200cb6:	65e6                	ld	a1,88(sp)
ffffffffc0200cb8:	7606                	ld	a2,96(sp)
ffffffffc0200cba:	76a6                	ld	a3,104(sp)
ffffffffc0200cbc:	7746                	ld	a4,112(sp)
ffffffffc0200cbe:	77e6                	ld	a5,120(sp)
ffffffffc0200cc0:	680a                	ld	a6,128(sp)
ffffffffc0200cc2:	68aa                	ld	a7,136(sp)
ffffffffc0200cc4:	694a                	ld	s2,144(sp)
ffffffffc0200cc6:	69ea                	ld	s3,152(sp)
ffffffffc0200cc8:	7a0a                	ld	s4,160(sp)
ffffffffc0200cca:	7aaa                	ld	s5,168(sp)
ffffffffc0200ccc:	7b4a                	ld	s6,176(sp)
ffffffffc0200cce:	7bea                	ld	s7,184(sp)
ffffffffc0200cd0:	6c0e                	ld	s8,192(sp)
ffffffffc0200cd2:	6cae                	ld	s9,200(sp)
ffffffffc0200cd4:	6d4e                	ld	s10,208(sp)
ffffffffc0200cd6:	6dee                	ld	s11,216(sp)
ffffffffc0200cd8:	7e0e                	ld	t3,224(sp)
ffffffffc0200cda:	7eae                	ld	t4,232(sp)
ffffffffc0200cdc:	7f4e                	ld	t5,240(sp)
ffffffffc0200cde:	7fee                	ld	t6,248(sp)
ffffffffc0200ce0:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200ce2:	10200073          	sret

ffffffffc0200ce6 <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200ce6:	00006797          	auipc	a5,0x6
ffffffffc0200cea:	34278793          	addi	a5,a5,834 # ffffffffc0207028 <free_area>
ffffffffc0200cee:	e79c                	sd	a5,8(a5)
ffffffffc0200cf0:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200cf2:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200cf6:	8082                	ret

ffffffffc0200cf8 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc0200cf8:	00006517          	auipc	a0,0x6
ffffffffc0200cfc:	34056503          	lwu	a0,832(a0) # ffffffffc0207038 <free_area+0x10>
ffffffffc0200d00:	8082                	ret

ffffffffc0200d02 <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0200d02:	715d                	addi	sp,sp,-80
ffffffffc0200d04:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200d06:	00006417          	auipc	s0,0x6
ffffffffc0200d0a:	32240413          	addi	s0,s0,802 # ffffffffc0207028 <free_area>
ffffffffc0200d0e:	641c                	ld	a5,8(s0)
ffffffffc0200d10:	e486                	sd	ra,72(sp)
ffffffffc0200d12:	fc26                	sd	s1,56(sp)
ffffffffc0200d14:	f84a                	sd	s2,48(sp)
ffffffffc0200d16:	f44e                	sd	s3,40(sp)
ffffffffc0200d18:	f052                	sd	s4,32(sp)
ffffffffc0200d1a:	ec56                	sd	s5,24(sp)
ffffffffc0200d1c:	e85a                	sd	s6,16(sp)
ffffffffc0200d1e:	e45e                	sd	s7,8(sp)
ffffffffc0200d20:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200d22:	2c878763          	beq	a5,s0,ffffffffc0200ff0 <default_check+0x2ee>
    int count = 0, total = 0;
ffffffffc0200d26:	4481                	li	s1,0
ffffffffc0200d28:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200d2a:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200d2e:	8b09                	andi	a4,a4,2
ffffffffc0200d30:	2c070463          	beqz	a4,ffffffffc0200ff8 <default_check+0x2f6>
        count ++, total += p->property;
ffffffffc0200d34:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200d38:	679c                	ld	a5,8(a5)
ffffffffc0200d3a:	2905                	addiw	s2,s2,1
ffffffffc0200d3c:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200d3e:	fe8796e3          	bne	a5,s0,ffffffffc0200d2a <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200d42:	89a6                	mv	s3,s1
ffffffffc0200d44:	2f9000ef          	jal	ra,ffffffffc020183c <nr_free_pages>
ffffffffc0200d48:	71351863          	bne	a0,s3,ffffffffc0201458 <default_check+0x756>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200d4c:	4505                	li	a0,1
ffffffffc0200d4e:	271000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200d52:	8a2a                	mv	s4,a0
ffffffffc0200d54:	44050263          	beqz	a0,ffffffffc0201198 <default_check+0x496>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200d58:	4505                	li	a0,1
ffffffffc0200d5a:	265000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200d5e:	89aa                	mv	s3,a0
ffffffffc0200d60:	70050c63          	beqz	a0,ffffffffc0201478 <default_check+0x776>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200d64:	4505                	li	a0,1
ffffffffc0200d66:	259000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200d6a:	8aaa                	mv	s5,a0
ffffffffc0200d6c:	4a050663          	beqz	a0,ffffffffc0201218 <default_check+0x516>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200d70:	2b3a0463          	beq	s4,s3,ffffffffc0201018 <default_check+0x316>
ffffffffc0200d74:	2aaa0263          	beq	s4,a0,ffffffffc0201018 <default_check+0x316>
ffffffffc0200d78:	2aa98063          	beq	s3,a0,ffffffffc0201018 <default_check+0x316>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200d7c:	000a2783          	lw	a5,0(s4)
ffffffffc0200d80:	2a079c63          	bnez	a5,ffffffffc0201038 <default_check+0x336>
ffffffffc0200d84:	0009a783          	lw	a5,0(s3)
ffffffffc0200d88:	2a079863          	bnez	a5,ffffffffc0201038 <default_check+0x336>
ffffffffc0200d8c:	411c                	lw	a5,0(a0)
ffffffffc0200d8e:	2a079563          	bnez	a5,ffffffffc0201038 <default_check+0x336>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d92:	00006797          	auipc	a5,0x6
ffffffffc0200d96:	6de7b783          	ld	a5,1758(a5) # ffffffffc0207470 <pages>
ffffffffc0200d9a:	40fa0733          	sub	a4,s4,a5
ffffffffc0200d9e:	870d                	srai	a4,a4,0x3
ffffffffc0200da0:	00002597          	auipc	a1,0x2
ffffffffc0200da4:	3f85b583          	ld	a1,1016(a1) # ffffffffc0203198 <error_string+0x38>
ffffffffc0200da8:	02b70733          	mul	a4,a4,a1
ffffffffc0200dac:	00002617          	auipc	a2,0x2
ffffffffc0200db0:	3f463603          	ld	a2,1012(a2) # ffffffffc02031a0 <nbase>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200db4:	00006697          	auipc	a3,0x6
ffffffffc0200db8:	6b46b683          	ld	a3,1716(a3) # ffffffffc0207468 <npage>
ffffffffc0200dbc:	06b2                	slli	a3,a3,0xc
ffffffffc0200dbe:	9732                	add	a4,a4,a2

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
ffffffffc0200dc0:	0732                	slli	a4,a4,0xc
ffffffffc0200dc2:	28d77b63          	bgeu	a4,a3,ffffffffc0201058 <default_check+0x356>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200dc6:	40f98733          	sub	a4,s3,a5
ffffffffc0200dca:	870d                	srai	a4,a4,0x3
ffffffffc0200dcc:	02b70733          	mul	a4,a4,a1
ffffffffc0200dd0:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200dd2:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200dd4:	4cd77263          	bgeu	a4,a3,ffffffffc0201298 <default_check+0x596>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200dd8:	40f507b3          	sub	a5,a0,a5
ffffffffc0200ddc:	878d                	srai	a5,a5,0x3
ffffffffc0200dde:	02b787b3          	mul	a5,a5,a1
ffffffffc0200de2:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200de4:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200de6:	30d7f963          	bgeu	a5,a3,ffffffffc02010f8 <default_check+0x3f6>
    assert(alloc_page() == NULL);
ffffffffc0200dea:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200dec:	00043c03          	ld	s8,0(s0)
ffffffffc0200df0:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0200df4:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0200df8:	e400                	sd	s0,8(s0)
ffffffffc0200dfa:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0200dfc:	00006797          	auipc	a5,0x6
ffffffffc0200e00:	2207ae23          	sw	zero,572(a5) # ffffffffc0207038 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0200e04:	1bb000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200e08:	2c051863          	bnez	a0,ffffffffc02010d8 <default_check+0x3d6>
    free_page(p0);
ffffffffc0200e0c:	4585                	li	a1,1
ffffffffc0200e0e:	8552                	mv	a0,s4
ffffffffc0200e10:	1ed000ef          	jal	ra,ffffffffc02017fc <free_pages>
    free_page(p1);
ffffffffc0200e14:	4585                	li	a1,1
ffffffffc0200e16:	854e                	mv	a0,s3
ffffffffc0200e18:	1e5000ef          	jal	ra,ffffffffc02017fc <free_pages>
    free_page(p2);
ffffffffc0200e1c:	4585                	li	a1,1
ffffffffc0200e1e:	8556                	mv	a0,s5
ffffffffc0200e20:	1dd000ef          	jal	ra,ffffffffc02017fc <free_pages>
    assert(nr_free == 3);
ffffffffc0200e24:	4818                	lw	a4,16(s0)
ffffffffc0200e26:	478d                	li	a5,3
ffffffffc0200e28:	28f71863          	bne	a4,a5,ffffffffc02010b8 <default_check+0x3b6>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200e2c:	4505                	li	a0,1
ffffffffc0200e2e:	191000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200e32:	89aa                	mv	s3,a0
ffffffffc0200e34:	26050263          	beqz	a0,ffffffffc0201098 <default_check+0x396>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200e38:	4505                	li	a0,1
ffffffffc0200e3a:	185000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200e3e:	8aaa                	mv	s5,a0
ffffffffc0200e40:	3a050c63          	beqz	a0,ffffffffc02011f8 <default_check+0x4f6>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200e44:	4505                	li	a0,1
ffffffffc0200e46:	179000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200e4a:	8a2a                	mv	s4,a0
ffffffffc0200e4c:	38050663          	beqz	a0,ffffffffc02011d8 <default_check+0x4d6>
    assert(alloc_page() == NULL);
ffffffffc0200e50:	4505                	li	a0,1
ffffffffc0200e52:	16d000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200e56:	36051163          	bnez	a0,ffffffffc02011b8 <default_check+0x4b6>
    free_page(p0);
ffffffffc0200e5a:	4585                	li	a1,1
ffffffffc0200e5c:	854e                	mv	a0,s3
ffffffffc0200e5e:	19f000ef          	jal	ra,ffffffffc02017fc <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0200e62:	641c                	ld	a5,8(s0)
ffffffffc0200e64:	20878a63          	beq	a5,s0,ffffffffc0201078 <default_check+0x376>
    assert((p = alloc_page()) == p0);
ffffffffc0200e68:	4505                	li	a0,1
ffffffffc0200e6a:	155000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200e6e:	30a99563          	bne	s3,a0,ffffffffc0201178 <default_check+0x476>
    assert(alloc_page() == NULL);
ffffffffc0200e72:	4505                	li	a0,1
ffffffffc0200e74:	14b000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200e78:	2e051063          	bnez	a0,ffffffffc0201158 <default_check+0x456>
    assert(nr_free == 0);
ffffffffc0200e7c:	481c                	lw	a5,16(s0)
ffffffffc0200e7e:	2a079d63          	bnez	a5,ffffffffc0201138 <default_check+0x436>
    free_page(p);
ffffffffc0200e82:	854e                	mv	a0,s3
ffffffffc0200e84:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0200e86:	01843023          	sd	s8,0(s0)
ffffffffc0200e8a:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0200e8e:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0200e92:	16b000ef          	jal	ra,ffffffffc02017fc <free_pages>
    free_page(p1);
ffffffffc0200e96:	4585                	li	a1,1
ffffffffc0200e98:	8556                	mv	a0,s5
ffffffffc0200e9a:	163000ef          	jal	ra,ffffffffc02017fc <free_pages>
    free_page(p2);
ffffffffc0200e9e:	4585                	li	a1,1
ffffffffc0200ea0:	8552                	mv	a0,s4
ffffffffc0200ea2:	15b000ef          	jal	ra,ffffffffc02017fc <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0200ea6:	4515                	li	a0,5
ffffffffc0200ea8:	117000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200eac:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0200eae:	26050563          	beqz	a0,ffffffffc0201118 <default_check+0x416>
ffffffffc0200eb2:	651c                	ld	a5,8(a0)
ffffffffc0200eb4:	8385                	srli	a5,a5,0x1
    assert(!PageProperty(p0));
ffffffffc0200eb6:	8b85                	andi	a5,a5,1
ffffffffc0200eb8:	54079063          	bnez	a5,ffffffffc02013f8 <default_check+0x6f6>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0200ebc:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200ebe:	00043b03          	ld	s6,0(s0)
ffffffffc0200ec2:	00843a83          	ld	s5,8(s0)
ffffffffc0200ec6:	e000                	sd	s0,0(s0)
ffffffffc0200ec8:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0200eca:	0f5000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200ece:	50051563          	bnez	a0,ffffffffc02013d8 <default_check+0x6d6>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0200ed2:	05098a13          	addi	s4,s3,80
ffffffffc0200ed6:	8552                	mv	a0,s4
ffffffffc0200ed8:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0200eda:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0200ede:	00006797          	auipc	a5,0x6
ffffffffc0200ee2:	1407ad23          	sw	zero,346(a5) # ffffffffc0207038 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0200ee6:	117000ef          	jal	ra,ffffffffc02017fc <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0200eea:	4511                	li	a0,4
ffffffffc0200eec:	0d3000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200ef0:	4c051463          	bnez	a0,ffffffffc02013b8 <default_check+0x6b6>
ffffffffc0200ef4:	0589b783          	ld	a5,88(s3)
ffffffffc0200ef8:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0200efa:	8b85                	andi	a5,a5,1
ffffffffc0200efc:	48078e63          	beqz	a5,ffffffffc0201398 <default_check+0x696>
ffffffffc0200f00:	0609a703          	lw	a4,96(s3)
ffffffffc0200f04:	478d                	li	a5,3
ffffffffc0200f06:	48f71963          	bne	a4,a5,ffffffffc0201398 <default_check+0x696>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0200f0a:	450d                	li	a0,3
ffffffffc0200f0c:	0b3000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200f10:	8c2a                	mv	s8,a0
ffffffffc0200f12:	46050363          	beqz	a0,ffffffffc0201378 <default_check+0x676>
    assert(alloc_page() == NULL);
ffffffffc0200f16:	4505                	li	a0,1
ffffffffc0200f18:	0a7000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200f1c:	42051e63          	bnez	a0,ffffffffc0201358 <default_check+0x656>
    assert(p0 + 2 == p1);
ffffffffc0200f20:	418a1c63          	bne	s4,s8,ffffffffc0201338 <default_check+0x636>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0200f24:	4585                	li	a1,1
ffffffffc0200f26:	854e                	mv	a0,s3
ffffffffc0200f28:	0d5000ef          	jal	ra,ffffffffc02017fc <free_pages>
    free_pages(p1, 3);
ffffffffc0200f2c:	458d                	li	a1,3
ffffffffc0200f2e:	8552                	mv	a0,s4
ffffffffc0200f30:	0cd000ef          	jal	ra,ffffffffc02017fc <free_pages>
ffffffffc0200f34:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0200f38:	02898c13          	addi	s8,s3,40
ffffffffc0200f3c:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0200f3e:	8b85                	andi	a5,a5,1
ffffffffc0200f40:	3c078c63          	beqz	a5,ffffffffc0201318 <default_check+0x616>
ffffffffc0200f44:	0109a703          	lw	a4,16(s3)
ffffffffc0200f48:	4785                	li	a5,1
ffffffffc0200f4a:	3cf71763          	bne	a4,a5,ffffffffc0201318 <default_check+0x616>
ffffffffc0200f4e:	008a3783          	ld	a5,8(s4)
ffffffffc0200f52:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0200f54:	8b85                	andi	a5,a5,1
ffffffffc0200f56:	3a078163          	beqz	a5,ffffffffc02012f8 <default_check+0x5f6>
ffffffffc0200f5a:	010a2703          	lw	a4,16(s4)
ffffffffc0200f5e:	478d                	li	a5,3
ffffffffc0200f60:	38f71c63          	bne	a4,a5,ffffffffc02012f8 <default_check+0x5f6>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0200f64:	4505                	li	a0,1
ffffffffc0200f66:	059000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200f6a:	36a99763          	bne	s3,a0,ffffffffc02012d8 <default_check+0x5d6>
    free_page(p0);
ffffffffc0200f6e:	4585                	li	a1,1
ffffffffc0200f70:	08d000ef          	jal	ra,ffffffffc02017fc <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0200f74:	4509                	li	a0,2
ffffffffc0200f76:	049000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200f7a:	32aa1f63          	bne	s4,a0,ffffffffc02012b8 <default_check+0x5b6>

    free_pages(p0, 2);
ffffffffc0200f7e:	4589                	li	a1,2
ffffffffc0200f80:	07d000ef          	jal	ra,ffffffffc02017fc <free_pages>
    free_page(p2);
ffffffffc0200f84:	4585                	li	a1,1
ffffffffc0200f86:	8562                	mv	a0,s8
ffffffffc0200f88:	075000ef          	jal	ra,ffffffffc02017fc <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0200f8c:	4515                	li	a0,5
ffffffffc0200f8e:	031000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200f92:	89aa                	mv	s3,a0
ffffffffc0200f94:	48050263          	beqz	a0,ffffffffc0201418 <default_check+0x716>
    assert(alloc_page() == NULL);
ffffffffc0200f98:	4505                	li	a0,1
ffffffffc0200f9a:	025000ef          	jal	ra,ffffffffc02017be <alloc_pages>
ffffffffc0200f9e:	2c051d63          	bnez	a0,ffffffffc0201278 <default_check+0x576>

    assert(nr_free == 0);
ffffffffc0200fa2:	481c                	lw	a5,16(s0)
ffffffffc0200fa4:	2a079a63          	bnez	a5,ffffffffc0201258 <default_check+0x556>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0200fa8:	4595                	li	a1,5
ffffffffc0200faa:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0200fac:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0200fb0:	01643023          	sd	s6,0(s0)
ffffffffc0200fb4:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0200fb8:	045000ef          	jal	ra,ffffffffc02017fc <free_pages>
    return listelm->next;
ffffffffc0200fbc:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200fbe:	00878963          	beq	a5,s0,ffffffffc0200fd0 <default_check+0x2ce>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc0200fc2:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200fc6:	679c                	ld	a5,8(a5)
ffffffffc0200fc8:	397d                	addiw	s2,s2,-1
ffffffffc0200fca:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200fcc:	fe879be3          	bne	a5,s0,ffffffffc0200fc2 <default_check+0x2c0>
    }
    assert(count == 0);
ffffffffc0200fd0:	26091463          	bnez	s2,ffffffffc0201238 <default_check+0x536>
    assert(total == 0);
ffffffffc0200fd4:	46049263          	bnez	s1,ffffffffc0201438 <default_check+0x736>
}
ffffffffc0200fd8:	60a6                	ld	ra,72(sp)
ffffffffc0200fda:	6406                	ld	s0,64(sp)
ffffffffc0200fdc:	74e2                	ld	s1,56(sp)
ffffffffc0200fde:	7942                	ld	s2,48(sp)
ffffffffc0200fe0:	79a2                	ld	s3,40(sp)
ffffffffc0200fe2:	7a02                	ld	s4,32(sp)
ffffffffc0200fe4:	6ae2                	ld	s5,24(sp)
ffffffffc0200fe6:	6b42                	ld	s6,16(sp)
ffffffffc0200fe8:	6ba2                	ld	s7,8(sp)
ffffffffc0200fea:	6c02                	ld	s8,0(sp)
ffffffffc0200fec:	6161                	addi	sp,sp,80
ffffffffc0200fee:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200ff0:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0200ff2:	4481                	li	s1,0
ffffffffc0200ff4:	4901                	li	s2,0
ffffffffc0200ff6:	b3b9                	j	ffffffffc0200d44 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0200ff8:	00002697          	auipc	a3,0x2
ffffffffc0200ffc:	a1868693          	addi	a3,a3,-1512 # ffffffffc0202a10 <commands+0x6d8>
ffffffffc0201000:	00002617          	auipc	a2,0x2
ffffffffc0201004:	a2060613          	addi	a2,a2,-1504 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201008:	0f000593          	li	a1,240
ffffffffc020100c:	00002517          	auipc	a0,0x2
ffffffffc0201010:	a2c50513          	addi	a0,a0,-1492 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201014:	bf4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201018:	00002697          	auipc	a3,0x2
ffffffffc020101c:	ab868693          	addi	a3,a3,-1352 # ffffffffc0202ad0 <commands+0x798>
ffffffffc0201020:	00002617          	auipc	a2,0x2
ffffffffc0201024:	a0060613          	addi	a2,a2,-1536 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201028:	0bd00593          	li	a1,189
ffffffffc020102c:	00002517          	auipc	a0,0x2
ffffffffc0201030:	a0c50513          	addi	a0,a0,-1524 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201034:	bd4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201038:	00002697          	auipc	a3,0x2
ffffffffc020103c:	ac068693          	addi	a3,a3,-1344 # ffffffffc0202af8 <commands+0x7c0>
ffffffffc0201040:	00002617          	auipc	a2,0x2
ffffffffc0201044:	9e060613          	addi	a2,a2,-1568 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201048:	0be00593          	li	a1,190
ffffffffc020104c:	00002517          	auipc	a0,0x2
ffffffffc0201050:	9ec50513          	addi	a0,a0,-1556 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201054:	bb4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201058:	00002697          	auipc	a3,0x2
ffffffffc020105c:	ae068693          	addi	a3,a3,-1312 # ffffffffc0202b38 <commands+0x800>
ffffffffc0201060:	00002617          	auipc	a2,0x2
ffffffffc0201064:	9c060613          	addi	a2,a2,-1600 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201068:	0c000593          	li	a1,192
ffffffffc020106c:	00002517          	auipc	a0,0x2
ffffffffc0201070:	9cc50513          	addi	a0,a0,-1588 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201074:	b94ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201078:	00002697          	auipc	a3,0x2
ffffffffc020107c:	b4868693          	addi	a3,a3,-1208 # ffffffffc0202bc0 <commands+0x888>
ffffffffc0201080:	00002617          	auipc	a2,0x2
ffffffffc0201084:	9a060613          	addi	a2,a2,-1632 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201088:	0d900593          	li	a1,217
ffffffffc020108c:	00002517          	auipc	a0,0x2
ffffffffc0201090:	9ac50513          	addi	a0,a0,-1620 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201094:	b74ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201098:	00002697          	auipc	a3,0x2
ffffffffc020109c:	9d868693          	addi	a3,a3,-1576 # ffffffffc0202a70 <commands+0x738>
ffffffffc02010a0:	00002617          	auipc	a2,0x2
ffffffffc02010a4:	98060613          	addi	a2,a2,-1664 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02010a8:	0d200593          	li	a1,210
ffffffffc02010ac:	00002517          	auipc	a0,0x2
ffffffffc02010b0:	98c50513          	addi	a0,a0,-1652 # ffffffffc0202a38 <commands+0x700>
ffffffffc02010b4:	b54ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(nr_free == 3);
ffffffffc02010b8:	00002697          	auipc	a3,0x2
ffffffffc02010bc:	af868693          	addi	a3,a3,-1288 # ffffffffc0202bb0 <commands+0x878>
ffffffffc02010c0:	00002617          	auipc	a2,0x2
ffffffffc02010c4:	96060613          	addi	a2,a2,-1696 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02010c8:	0d000593          	li	a1,208
ffffffffc02010cc:	00002517          	auipc	a0,0x2
ffffffffc02010d0:	96c50513          	addi	a0,a0,-1684 # ffffffffc0202a38 <commands+0x700>
ffffffffc02010d4:	b34ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02010d8:	00002697          	auipc	a3,0x2
ffffffffc02010dc:	ac068693          	addi	a3,a3,-1344 # ffffffffc0202b98 <commands+0x860>
ffffffffc02010e0:	00002617          	auipc	a2,0x2
ffffffffc02010e4:	94060613          	addi	a2,a2,-1728 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02010e8:	0cb00593          	li	a1,203
ffffffffc02010ec:	00002517          	auipc	a0,0x2
ffffffffc02010f0:	94c50513          	addi	a0,a0,-1716 # ffffffffc0202a38 <commands+0x700>
ffffffffc02010f4:	b14ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010f8:	00002697          	auipc	a3,0x2
ffffffffc02010fc:	a8068693          	addi	a3,a3,-1408 # ffffffffc0202b78 <commands+0x840>
ffffffffc0201100:	00002617          	auipc	a2,0x2
ffffffffc0201104:	92060613          	addi	a2,a2,-1760 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201108:	0c200593          	li	a1,194
ffffffffc020110c:	00002517          	auipc	a0,0x2
ffffffffc0201110:	92c50513          	addi	a0,a0,-1748 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201114:	af4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(p0 != NULL);
ffffffffc0201118:	00002697          	auipc	a3,0x2
ffffffffc020111c:	af068693          	addi	a3,a3,-1296 # ffffffffc0202c08 <commands+0x8d0>
ffffffffc0201120:	00002617          	auipc	a2,0x2
ffffffffc0201124:	90060613          	addi	a2,a2,-1792 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201128:	0f800593          	li	a1,248
ffffffffc020112c:	00002517          	auipc	a0,0x2
ffffffffc0201130:	90c50513          	addi	a0,a0,-1780 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201134:	ad4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(nr_free == 0);
ffffffffc0201138:	00002697          	auipc	a3,0x2
ffffffffc020113c:	ac068693          	addi	a3,a3,-1344 # ffffffffc0202bf8 <commands+0x8c0>
ffffffffc0201140:	00002617          	auipc	a2,0x2
ffffffffc0201144:	8e060613          	addi	a2,a2,-1824 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201148:	0df00593          	li	a1,223
ffffffffc020114c:	00002517          	auipc	a0,0x2
ffffffffc0201150:	8ec50513          	addi	a0,a0,-1812 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201154:	ab4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201158:	00002697          	auipc	a3,0x2
ffffffffc020115c:	a4068693          	addi	a3,a3,-1472 # ffffffffc0202b98 <commands+0x860>
ffffffffc0201160:	00002617          	auipc	a2,0x2
ffffffffc0201164:	8c060613          	addi	a2,a2,-1856 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201168:	0dd00593          	li	a1,221
ffffffffc020116c:	00002517          	auipc	a0,0x2
ffffffffc0201170:	8cc50513          	addi	a0,a0,-1844 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201174:	a94ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201178:	00002697          	auipc	a3,0x2
ffffffffc020117c:	a6068693          	addi	a3,a3,-1440 # ffffffffc0202bd8 <commands+0x8a0>
ffffffffc0201180:	00002617          	auipc	a2,0x2
ffffffffc0201184:	8a060613          	addi	a2,a2,-1888 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201188:	0dc00593          	li	a1,220
ffffffffc020118c:	00002517          	auipc	a0,0x2
ffffffffc0201190:	8ac50513          	addi	a0,a0,-1876 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201194:	a74ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201198:	00002697          	auipc	a3,0x2
ffffffffc020119c:	8d868693          	addi	a3,a3,-1832 # ffffffffc0202a70 <commands+0x738>
ffffffffc02011a0:	00002617          	auipc	a2,0x2
ffffffffc02011a4:	88060613          	addi	a2,a2,-1920 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02011a8:	0b900593          	li	a1,185
ffffffffc02011ac:	00002517          	auipc	a0,0x2
ffffffffc02011b0:	88c50513          	addi	a0,a0,-1908 # ffffffffc0202a38 <commands+0x700>
ffffffffc02011b4:	a54ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02011b8:	00002697          	auipc	a3,0x2
ffffffffc02011bc:	9e068693          	addi	a3,a3,-1568 # ffffffffc0202b98 <commands+0x860>
ffffffffc02011c0:	00002617          	auipc	a2,0x2
ffffffffc02011c4:	86060613          	addi	a2,a2,-1952 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02011c8:	0d600593          	li	a1,214
ffffffffc02011cc:	00002517          	auipc	a0,0x2
ffffffffc02011d0:	86c50513          	addi	a0,a0,-1940 # ffffffffc0202a38 <commands+0x700>
ffffffffc02011d4:	a34ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02011d8:	00002697          	auipc	a3,0x2
ffffffffc02011dc:	8d868693          	addi	a3,a3,-1832 # ffffffffc0202ab0 <commands+0x778>
ffffffffc02011e0:	00002617          	auipc	a2,0x2
ffffffffc02011e4:	84060613          	addi	a2,a2,-1984 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02011e8:	0d400593          	li	a1,212
ffffffffc02011ec:	00002517          	auipc	a0,0x2
ffffffffc02011f0:	84c50513          	addi	a0,a0,-1972 # ffffffffc0202a38 <commands+0x700>
ffffffffc02011f4:	a14ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02011f8:	00002697          	auipc	a3,0x2
ffffffffc02011fc:	89868693          	addi	a3,a3,-1896 # ffffffffc0202a90 <commands+0x758>
ffffffffc0201200:	00002617          	auipc	a2,0x2
ffffffffc0201204:	82060613          	addi	a2,a2,-2016 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201208:	0d300593          	li	a1,211
ffffffffc020120c:	00002517          	auipc	a0,0x2
ffffffffc0201210:	82c50513          	addi	a0,a0,-2004 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201214:	9f4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201218:	00002697          	auipc	a3,0x2
ffffffffc020121c:	89868693          	addi	a3,a3,-1896 # ffffffffc0202ab0 <commands+0x778>
ffffffffc0201220:	00002617          	auipc	a2,0x2
ffffffffc0201224:	80060613          	addi	a2,a2,-2048 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201228:	0bb00593          	li	a1,187
ffffffffc020122c:	00002517          	auipc	a0,0x2
ffffffffc0201230:	80c50513          	addi	a0,a0,-2036 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201234:	9d4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(count == 0);
ffffffffc0201238:	00002697          	auipc	a3,0x2
ffffffffc020123c:	b2068693          	addi	a3,a3,-1248 # ffffffffc0202d58 <commands+0xa20>
ffffffffc0201240:	00001617          	auipc	a2,0x1
ffffffffc0201244:	7e060613          	addi	a2,a2,2016 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201248:	12500593          	li	a1,293
ffffffffc020124c:	00001517          	auipc	a0,0x1
ffffffffc0201250:	7ec50513          	addi	a0,a0,2028 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201254:	9b4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(nr_free == 0);
ffffffffc0201258:	00002697          	auipc	a3,0x2
ffffffffc020125c:	9a068693          	addi	a3,a3,-1632 # ffffffffc0202bf8 <commands+0x8c0>
ffffffffc0201260:	00001617          	auipc	a2,0x1
ffffffffc0201264:	7c060613          	addi	a2,a2,1984 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201268:	11a00593          	li	a1,282
ffffffffc020126c:	00001517          	auipc	a0,0x1
ffffffffc0201270:	7cc50513          	addi	a0,a0,1996 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201274:	994ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201278:	00002697          	auipc	a3,0x2
ffffffffc020127c:	92068693          	addi	a3,a3,-1760 # ffffffffc0202b98 <commands+0x860>
ffffffffc0201280:	00001617          	auipc	a2,0x1
ffffffffc0201284:	7a060613          	addi	a2,a2,1952 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201288:	11800593          	li	a1,280
ffffffffc020128c:	00001517          	auipc	a0,0x1
ffffffffc0201290:	7ac50513          	addi	a0,a0,1964 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201294:	974ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201298:	00002697          	auipc	a3,0x2
ffffffffc020129c:	8c068693          	addi	a3,a3,-1856 # ffffffffc0202b58 <commands+0x820>
ffffffffc02012a0:	00001617          	auipc	a2,0x1
ffffffffc02012a4:	78060613          	addi	a2,a2,1920 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02012a8:	0c100593          	li	a1,193
ffffffffc02012ac:	00001517          	auipc	a0,0x1
ffffffffc02012b0:	78c50513          	addi	a0,a0,1932 # ffffffffc0202a38 <commands+0x700>
ffffffffc02012b4:	954ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02012b8:	00002697          	auipc	a3,0x2
ffffffffc02012bc:	a6068693          	addi	a3,a3,-1440 # ffffffffc0202d18 <commands+0x9e0>
ffffffffc02012c0:	00001617          	auipc	a2,0x1
ffffffffc02012c4:	76060613          	addi	a2,a2,1888 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02012c8:	11200593          	li	a1,274
ffffffffc02012cc:	00001517          	auipc	a0,0x1
ffffffffc02012d0:	76c50513          	addi	a0,a0,1900 # ffffffffc0202a38 <commands+0x700>
ffffffffc02012d4:	934ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02012d8:	00002697          	auipc	a3,0x2
ffffffffc02012dc:	a2068693          	addi	a3,a3,-1504 # ffffffffc0202cf8 <commands+0x9c0>
ffffffffc02012e0:	00001617          	auipc	a2,0x1
ffffffffc02012e4:	74060613          	addi	a2,a2,1856 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02012e8:	11000593          	li	a1,272
ffffffffc02012ec:	00001517          	auipc	a0,0x1
ffffffffc02012f0:	74c50513          	addi	a0,a0,1868 # ffffffffc0202a38 <commands+0x700>
ffffffffc02012f4:	914ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02012f8:	00002697          	auipc	a3,0x2
ffffffffc02012fc:	9d868693          	addi	a3,a3,-1576 # ffffffffc0202cd0 <commands+0x998>
ffffffffc0201300:	00001617          	auipc	a2,0x1
ffffffffc0201304:	72060613          	addi	a2,a2,1824 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201308:	10e00593          	li	a1,270
ffffffffc020130c:	00001517          	auipc	a0,0x1
ffffffffc0201310:	72c50513          	addi	a0,a0,1836 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201314:	8f4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201318:	00002697          	auipc	a3,0x2
ffffffffc020131c:	99068693          	addi	a3,a3,-1648 # ffffffffc0202ca8 <commands+0x970>
ffffffffc0201320:	00001617          	auipc	a2,0x1
ffffffffc0201324:	70060613          	addi	a2,a2,1792 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201328:	10d00593          	li	a1,269
ffffffffc020132c:	00001517          	auipc	a0,0x1
ffffffffc0201330:	70c50513          	addi	a0,a0,1804 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201334:	8d4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201338:	00002697          	auipc	a3,0x2
ffffffffc020133c:	96068693          	addi	a3,a3,-1696 # ffffffffc0202c98 <commands+0x960>
ffffffffc0201340:	00001617          	auipc	a2,0x1
ffffffffc0201344:	6e060613          	addi	a2,a2,1760 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201348:	10800593          	li	a1,264
ffffffffc020134c:	00001517          	auipc	a0,0x1
ffffffffc0201350:	6ec50513          	addi	a0,a0,1772 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201354:	8b4ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201358:	00002697          	auipc	a3,0x2
ffffffffc020135c:	84068693          	addi	a3,a3,-1984 # ffffffffc0202b98 <commands+0x860>
ffffffffc0201360:	00001617          	auipc	a2,0x1
ffffffffc0201364:	6c060613          	addi	a2,a2,1728 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201368:	10700593          	li	a1,263
ffffffffc020136c:	00001517          	auipc	a0,0x1
ffffffffc0201370:	6cc50513          	addi	a0,a0,1740 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201374:	894ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201378:	00002697          	auipc	a3,0x2
ffffffffc020137c:	90068693          	addi	a3,a3,-1792 # ffffffffc0202c78 <commands+0x940>
ffffffffc0201380:	00001617          	auipc	a2,0x1
ffffffffc0201384:	6a060613          	addi	a2,a2,1696 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201388:	10600593          	li	a1,262
ffffffffc020138c:	00001517          	auipc	a0,0x1
ffffffffc0201390:	6ac50513          	addi	a0,a0,1708 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201394:	874ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201398:	00002697          	auipc	a3,0x2
ffffffffc020139c:	8b068693          	addi	a3,a3,-1872 # ffffffffc0202c48 <commands+0x910>
ffffffffc02013a0:	00001617          	auipc	a2,0x1
ffffffffc02013a4:	68060613          	addi	a2,a2,1664 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02013a8:	10500593          	li	a1,261
ffffffffc02013ac:	00001517          	auipc	a0,0x1
ffffffffc02013b0:	68c50513          	addi	a0,a0,1676 # ffffffffc0202a38 <commands+0x700>
ffffffffc02013b4:	854ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02013b8:	00002697          	auipc	a3,0x2
ffffffffc02013bc:	87868693          	addi	a3,a3,-1928 # ffffffffc0202c30 <commands+0x8f8>
ffffffffc02013c0:	00001617          	auipc	a2,0x1
ffffffffc02013c4:	66060613          	addi	a2,a2,1632 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02013c8:	10400593          	li	a1,260
ffffffffc02013cc:	00001517          	auipc	a0,0x1
ffffffffc02013d0:	66c50513          	addi	a0,a0,1644 # ffffffffc0202a38 <commands+0x700>
ffffffffc02013d4:	834ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013d8:	00001697          	auipc	a3,0x1
ffffffffc02013dc:	7c068693          	addi	a3,a3,1984 # ffffffffc0202b98 <commands+0x860>
ffffffffc02013e0:	00001617          	auipc	a2,0x1
ffffffffc02013e4:	64060613          	addi	a2,a2,1600 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02013e8:	0fe00593          	li	a1,254
ffffffffc02013ec:	00001517          	auipc	a0,0x1
ffffffffc02013f0:	64c50513          	addi	a0,a0,1612 # ffffffffc0202a38 <commands+0x700>
ffffffffc02013f4:	814ff0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(!PageProperty(p0));
ffffffffc02013f8:	00002697          	auipc	a3,0x2
ffffffffc02013fc:	82068693          	addi	a3,a3,-2016 # ffffffffc0202c18 <commands+0x8e0>
ffffffffc0201400:	00001617          	auipc	a2,0x1
ffffffffc0201404:	62060613          	addi	a2,a2,1568 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201408:	0f900593          	li	a1,249
ffffffffc020140c:	00001517          	auipc	a0,0x1
ffffffffc0201410:	62c50513          	addi	a0,a0,1580 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201414:	ff5fe0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201418:	00002697          	auipc	a3,0x2
ffffffffc020141c:	92068693          	addi	a3,a3,-1760 # ffffffffc0202d38 <commands+0xa00>
ffffffffc0201420:	00001617          	auipc	a2,0x1
ffffffffc0201424:	60060613          	addi	a2,a2,1536 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201428:	11700593          	li	a1,279
ffffffffc020142c:	00001517          	auipc	a0,0x1
ffffffffc0201430:	60c50513          	addi	a0,a0,1548 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201434:	fd5fe0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(total == 0);
ffffffffc0201438:	00002697          	auipc	a3,0x2
ffffffffc020143c:	93068693          	addi	a3,a3,-1744 # ffffffffc0202d68 <commands+0xa30>
ffffffffc0201440:	00001617          	auipc	a2,0x1
ffffffffc0201444:	5e060613          	addi	a2,a2,1504 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201448:	12600593          	li	a1,294
ffffffffc020144c:	00001517          	auipc	a0,0x1
ffffffffc0201450:	5ec50513          	addi	a0,a0,1516 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201454:	fb5fe0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(total == nr_free_pages());
ffffffffc0201458:	00001697          	auipc	a3,0x1
ffffffffc020145c:	5f868693          	addi	a3,a3,1528 # ffffffffc0202a50 <commands+0x718>
ffffffffc0201460:	00001617          	auipc	a2,0x1
ffffffffc0201464:	5c060613          	addi	a2,a2,1472 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201468:	0f300593          	li	a1,243
ffffffffc020146c:	00001517          	auipc	a0,0x1
ffffffffc0201470:	5cc50513          	addi	a0,a0,1484 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201474:	f95fe0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201478:	00001697          	auipc	a3,0x1
ffffffffc020147c:	61868693          	addi	a3,a3,1560 # ffffffffc0202a90 <commands+0x758>
ffffffffc0201480:	00001617          	auipc	a2,0x1
ffffffffc0201484:	5a060613          	addi	a2,a2,1440 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201488:	0ba00593          	li	a1,186
ffffffffc020148c:	00001517          	auipc	a0,0x1
ffffffffc0201490:	5ac50513          	addi	a0,a0,1452 # ffffffffc0202a38 <commands+0x700>
ffffffffc0201494:	f75fe0ef          	jal	ra,ffffffffc0200408 <__panic>

ffffffffc0201498 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0201498:	1141                	addi	sp,sp,-16
ffffffffc020149a:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020149c:	14058a63          	beqz	a1,ffffffffc02015f0 <default_free_pages+0x158>
    for (; p != base + n; p ++) {
ffffffffc02014a0:	00259693          	slli	a3,a1,0x2
ffffffffc02014a4:	96ae                	add	a3,a3,a1
ffffffffc02014a6:	068e                	slli	a3,a3,0x3
ffffffffc02014a8:	96aa                	add	a3,a3,a0
ffffffffc02014aa:	87aa                	mv	a5,a0
ffffffffc02014ac:	02d50263          	beq	a0,a3,ffffffffc02014d0 <default_free_pages+0x38>
ffffffffc02014b0:	6798                	ld	a4,8(a5)
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02014b2:	8b05                	andi	a4,a4,1
ffffffffc02014b4:	10071e63          	bnez	a4,ffffffffc02015d0 <default_free_pages+0x138>
ffffffffc02014b8:	6798                	ld	a4,8(a5)
ffffffffc02014ba:	8b09                	andi	a4,a4,2
ffffffffc02014bc:	10071a63          	bnez	a4,ffffffffc02015d0 <default_free_pages+0x138>
        p->flags = 0;
ffffffffc02014c0:	0007b423          	sd	zero,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc02014c4:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02014c8:	02878793          	addi	a5,a5,40
ffffffffc02014cc:	fed792e3          	bne	a5,a3,ffffffffc02014b0 <default_free_pages+0x18>
    base->property = n;
ffffffffc02014d0:	2581                	sext.w	a1,a1
ffffffffc02014d2:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02014d4:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02014d8:	4789                	li	a5,2
ffffffffc02014da:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02014de:	00006697          	auipc	a3,0x6
ffffffffc02014e2:	b4a68693          	addi	a3,a3,-1206 # ffffffffc0207028 <free_area>
ffffffffc02014e6:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02014e8:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02014ea:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02014ee:	9db9                	addw	a1,a1,a4
ffffffffc02014f0:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02014f2:	0ad78863          	beq	a5,a3,ffffffffc02015a2 <default_free_pages+0x10a>
            struct Page* page = le2page(le, page_link);
ffffffffc02014f6:	fe878713          	addi	a4,a5,-24
ffffffffc02014fa:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02014fe:	4581                	li	a1,0
            if (base < page) {
ffffffffc0201500:	00e56a63          	bltu	a0,a4,ffffffffc0201514 <default_free_pages+0x7c>
    return listelm->next;
ffffffffc0201504:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0201506:	06d70263          	beq	a4,a3,ffffffffc020156a <default_free_pages+0xd2>
    for (; p != base + n; p ++) {
ffffffffc020150a:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc020150c:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0201510:	fee57ae3          	bgeu	a0,a4,ffffffffc0201504 <default_free_pages+0x6c>
ffffffffc0201514:	c199                	beqz	a1,ffffffffc020151a <default_free_pages+0x82>
ffffffffc0201516:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020151a:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc020151c:	e390                	sd	a2,0(a5)
ffffffffc020151e:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201520:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201522:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0201524:	02d70063          	beq	a4,a3,ffffffffc0201544 <default_free_pages+0xac>
        if (p + p->property == base) {
ffffffffc0201528:	ff872803          	lw	a6,-8(a4)
        p = le2page(le, page_link);
ffffffffc020152c:	fe870593          	addi	a1,a4,-24
        if (p + p->property == base) {
ffffffffc0201530:	02081613          	slli	a2,a6,0x20
ffffffffc0201534:	9201                	srli	a2,a2,0x20
ffffffffc0201536:	00261793          	slli	a5,a2,0x2
ffffffffc020153a:	97b2                	add	a5,a5,a2
ffffffffc020153c:	078e                	slli	a5,a5,0x3
ffffffffc020153e:	97ae                	add	a5,a5,a1
ffffffffc0201540:	02f50f63          	beq	a0,a5,ffffffffc020157e <default_free_pages+0xe6>
    return listelm->next;
ffffffffc0201544:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc0201546:	00d70f63          	beq	a4,a3,ffffffffc0201564 <default_free_pages+0xcc>
        if (base + base->property == p) {
ffffffffc020154a:	490c                	lw	a1,16(a0)
        p = le2page(le, page_link);
ffffffffc020154c:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc0201550:	02059613          	slli	a2,a1,0x20
ffffffffc0201554:	9201                	srli	a2,a2,0x20
ffffffffc0201556:	00261793          	slli	a5,a2,0x2
ffffffffc020155a:	97b2                	add	a5,a5,a2
ffffffffc020155c:	078e                	slli	a5,a5,0x3
ffffffffc020155e:	97aa                	add	a5,a5,a0
ffffffffc0201560:	04f68863          	beq	a3,a5,ffffffffc02015b0 <default_free_pages+0x118>
}
ffffffffc0201564:	60a2                	ld	ra,8(sp)
ffffffffc0201566:	0141                	addi	sp,sp,16
ffffffffc0201568:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020156a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020156c:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020156e:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201570:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0201572:	02d70563          	beq	a4,a3,ffffffffc020159c <default_free_pages+0x104>
    prev->next = next->prev = elm;
ffffffffc0201576:	8832                	mv	a6,a2
ffffffffc0201578:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc020157a:	87ba                	mv	a5,a4
ffffffffc020157c:	bf41                	j	ffffffffc020150c <default_free_pages+0x74>
            p->property += base->property;
ffffffffc020157e:	491c                	lw	a5,16(a0)
ffffffffc0201580:	0107883b          	addw	a6,a5,a6
ffffffffc0201584:	ff072c23          	sw	a6,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201588:	57f5                	li	a5,-3
ffffffffc020158a:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc020158e:	6d10                	ld	a2,24(a0)
ffffffffc0201590:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc0201592:	852e                	mv	a0,a1
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201594:	e61c                	sd	a5,8(a2)
    return listelm->next;
ffffffffc0201596:	6718                	ld	a4,8(a4)
    next->prev = prev;
ffffffffc0201598:	e390                	sd	a2,0(a5)
ffffffffc020159a:	b775                	j	ffffffffc0201546 <default_free_pages+0xae>
ffffffffc020159c:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020159e:	873e                	mv	a4,a5
ffffffffc02015a0:	b761                	j	ffffffffc0201528 <default_free_pages+0x90>
}
ffffffffc02015a2:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02015a4:	e390                	sd	a2,0(a5)
ffffffffc02015a6:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02015a8:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02015aa:	ed1c                	sd	a5,24(a0)
ffffffffc02015ac:	0141                	addi	sp,sp,16
ffffffffc02015ae:	8082                	ret
            base->property += p->property;
ffffffffc02015b0:	ff872783          	lw	a5,-8(a4)
ffffffffc02015b4:	ff070693          	addi	a3,a4,-16
ffffffffc02015b8:	9dbd                	addw	a1,a1,a5
ffffffffc02015ba:	c90c                	sw	a1,16(a0)
ffffffffc02015bc:	57f5                	li	a5,-3
ffffffffc02015be:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02015c2:	6314                	ld	a3,0(a4)
ffffffffc02015c4:	671c                	ld	a5,8(a4)
}
ffffffffc02015c6:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02015c8:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc02015ca:	e394                	sd	a3,0(a5)
ffffffffc02015cc:	0141                	addi	sp,sp,16
ffffffffc02015ce:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02015d0:	00001697          	auipc	a3,0x1
ffffffffc02015d4:	7b068693          	addi	a3,a3,1968 # ffffffffc0202d80 <commands+0xa48>
ffffffffc02015d8:	00001617          	auipc	a2,0x1
ffffffffc02015dc:	44860613          	addi	a2,a2,1096 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02015e0:	08300593          	li	a1,131
ffffffffc02015e4:	00001517          	auipc	a0,0x1
ffffffffc02015e8:	45450513          	addi	a0,a0,1108 # ffffffffc0202a38 <commands+0x700>
ffffffffc02015ec:	e1dfe0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(n > 0);
ffffffffc02015f0:	00001697          	auipc	a3,0x1
ffffffffc02015f4:	78868693          	addi	a3,a3,1928 # ffffffffc0202d78 <commands+0xa40>
ffffffffc02015f8:	00001617          	auipc	a2,0x1
ffffffffc02015fc:	42860613          	addi	a2,a2,1064 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc0201600:	08000593          	li	a1,128
ffffffffc0201604:	00001517          	auipc	a0,0x1
ffffffffc0201608:	43450513          	addi	a0,a0,1076 # ffffffffc0202a38 <commands+0x700>
ffffffffc020160c:	dfdfe0ef          	jal	ra,ffffffffc0200408 <__panic>

ffffffffc0201610 <default_alloc_pages>:
    assert(n > 0);
ffffffffc0201610:	c959                	beqz	a0,ffffffffc02016a6 <default_alloc_pages+0x96>
    if (n > nr_free) {
ffffffffc0201612:	00006597          	auipc	a1,0x6
ffffffffc0201616:	a1658593          	addi	a1,a1,-1514 # ffffffffc0207028 <free_area>
ffffffffc020161a:	0105a803          	lw	a6,16(a1)
ffffffffc020161e:	862a                	mv	a2,a0
ffffffffc0201620:	02081793          	slli	a5,a6,0x20
ffffffffc0201624:	9381                	srli	a5,a5,0x20
ffffffffc0201626:	00a7ee63          	bltu	a5,a0,ffffffffc0201642 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc020162a:	87ae                	mv	a5,a1
ffffffffc020162c:	a801                	j	ffffffffc020163c <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc020162e:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201632:	02071693          	slli	a3,a4,0x20
ffffffffc0201636:	9281                	srli	a3,a3,0x20
ffffffffc0201638:	00c6f763          	bgeu	a3,a2,ffffffffc0201646 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc020163c:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc020163e:	feb798e3          	bne	a5,a1,ffffffffc020162e <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0201642:	4501                	li	a0,0
}
ffffffffc0201644:	8082                	ret
    return listelm->prev;
ffffffffc0201646:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc020164a:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020164e:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc0201652:	00060e1b          	sext.w	t3,a2
    prev->next = next;
ffffffffc0201656:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc020165a:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc020165e:	02d67b63          	bgeu	a2,a3,ffffffffc0201694 <default_alloc_pages+0x84>
            struct Page *p = page + n;
ffffffffc0201662:	00261693          	slli	a3,a2,0x2
ffffffffc0201666:	96b2                	add	a3,a3,a2
ffffffffc0201668:	068e                	slli	a3,a3,0x3
ffffffffc020166a:	96aa                	add	a3,a3,a0
            p->property = page->property - n;
ffffffffc020166c:	41c7073b          	subw	a4,a4,t3
ffffffffc0201670:	ca98                	sw	a4,16(a3)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201672:	00868613          	addi	a2,a3,8
ffffffffc0201676:	4709                	li	a4,2
ffffffffc0201678:	40e6302f          	amoor.d	zero,a4,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc020167c:	0088b703          	ld	a4,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201680:	01868613          	addi	a2,a3,24
        nr_free -= n;
ffffffffc0201684:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201688:	e310                	sd	a2,0(a4)
ffffffffc020168a:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc020168e:	f298                	sd	a4,32(a3)
    elm->prev = prev;
ffffffffc0201690:	0116bc23          	sd	a7,24(a3)
ffffffffc0201694:	41c8083b          	subw	a6,a6,t3
ffffffffc0201698:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020169c:	5775                	li	a4,-3
ffffffffc020169e:	17c1                	addi	a5,a5,-16
ffffffffc02016a0:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc02016a4:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc02016a6:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc02016a8:	00001697          	auipc	a3,0x1
ffffffffc02016ac:	6d068693          	addi	a3,a3,1744 # ffffffffc0202d78 <commands+0xa40>
ffffffffc02016b0:	00001617          	auipc	a2,0x1
ffffffffc02016b4:	37060613          	addi	a2,a2,880 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02016b8:	06200593          	li	a1,98
ffffffffc02016bc:	00001517          	auipc	a0,0x1
ffffffffc02016c0:	37c50513          	addi	a0,a0,892 # ffffffffc0202a38 <commands+0x700>
default_alloc_pages(size_t n) {
ffffffffc02016c4:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02016c6:	d43fe0ef          	jal	ra,ffffffffc0200408 <__panic>

ffffffffc02016ca <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc02016ca:	1141                	addi	sp,sp,-16
ffffffffc02016cc:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02016ce:	c9e1                	beqz	a1,ffffffffc020179e <default_init_memmap+0xd4>
    for (; p != base + n; p ++) {
ffffffffc02016d0:	00259693          	slli	a3,a1,0x2
ffffffffc02016d4:	96ae                	add	a3,a3,a1
ffffffffc02016d6:	068e                	slli	a3,a3,0x3
ffffffffc02016d8:	96aa                	add	a3,a3,a0
ffffffffc02016da:	87aa                	mv	a5,a0
ffffffffc02016dc:	00d50f63          	beq	a0,a3,ffffffffc02016fa <default_init_memmap+0x30>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02016e0:	6798                	ld	a4,8(a5)
        assert(PageReserved(p));
ffffffffc02016e2:	8b05                	andi	a4,a4,1
ffffffffc02016e4:	cf49                	beqz	a4,ffffffffc020177e <default_init_memmap+0xb4>
        p->flags = p->property = 0;
ffffffffc02016e6:	0007a823          	sw	zero,16(a5)
ffffffffc02016ea:	0007b423          	sd	zero,8(a5)
ffffffffc02016ee:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02016f2:	02878793          	addi	a5,a5,40
ffffffffc02016f6:	fed795e3          	bne	a5,a3,ffffffffc02016e0 <default_init_memmap+0x16>
    base->property = n;
ffffffffc02016fa:	2581                	sext.w	a1,a1
ffffffffc02016fc:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02016fe:	4789                	li	a5,2
ffffffffc0201700:	00850713          	addi	a4,a0,8
ffffffffc0201704:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc0201708:	00006697          	auipc	a3,0x6
ffffffffc020170c:	92068693          	addi	a3,a3,-1760 # ffffffffc0207028 <free_area>
ffffffffc0201710:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0201712:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc0201714:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc0201718:	9db9                	addw	a1,a1,a4
ffffffffc020171a:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc020171c:	04d78a63          	beq	a5,a3,ffffffffc0201770 <default_init_memmap+0xa6>
            struct Page* page = le2page(le, page_link);
ffffffffc0201720:	fe878713          	addi	a4,a5,-24
ffffffffc0201724:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0201728:	4581                	li	a1,0
            if (base < page) {
ffffffffc020172a:	00e56a63          	bltu	a0,a4,ffffffffc020173e <default_init_memmap+0x74>
    return listelm->next;
ffffffffc020172e:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0201730:	02d70263          	beq	a4,a3,ffffffffc0201754 <default_init_memmap+0x8a>
    for (; p != base + n; p ++) {
ffffffffc0201734:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0201736:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc020173a:	fee57ae3          	bgeu	a0,a4,ffffffffc020172e <default_init_memmap+0x64>
ffffffffc020173e:	c199                	beqz	a1,ffffffffc0201744 <default_init_memmap+0x7a>
ffffffffc0201740:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201744:	6398                	ld	a4,0(a5)
}
ffffffffc0201746:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201748:	e390                	sd	a2,0(a5)
ffffffffc020174a:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc020174c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020174e:	ed18                	sd	a4,24(a0)
ffffffffc0201750:	0141                	addi	sp,sp,16
ffffffffc0201752:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201754:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201756:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201758:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020175a:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020175c:	00d70663          	beq	a4,a3,ffffffffc0201768 <default_init_memmap+0x9e>
    prev->next = next->prev = elm;
ffffffffc0201760:	8832                	mv	a6,a2
ffffffffc0201762:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0201764:	87ba                	mv	a5,a4
ffffffffc0201766:	bfc1                	j	ffffffffc0201736 <default_init_memmap+0x6c>
}
ffffffffc0201768:	60a2                	ld	ra,8(sp)
ffffffffc020176a:	e290                	sd	a2,0(a3)
ffffffffc020176c:	0141                	addi	sp,sp,16
ffffffffc020176e:	8082                	ret
ffffffffc0201770:	60a2                	ld	ra,8(sp)
ffffffffc0201772:	e390                	sd	a2,0(a5)
ffffffffc0201774:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201776:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201778:	ed1c                	sd	a5,24(a0)
ffffffffc020177a:	0141                	addi	sp,sp,16
ffffffffc020177c:	8082                	ret
        assert(PageReserved(p));
ffffffffc020177e:	00001697          	auipc	a3,0x1
ffffffffc0201782:	62a68693          	addi	a3,a3,1578 # ffffffffc0202da8 <commands+0xa70>
ffffffffc0201786:	00001617          	auipc	a2,0x1
ffffffffc020178a:	29a60613          	addi	a2,a2,666 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc020178e:	04900593          	li	a1,73
ffffffffc0201792:	00001517          	auipc	a0,0x1
ffffffffc0201796:	2a650513          	addi	a0,a0,678 # ffffffffc0202a38 <commands+0x700>
ffffffffc020179a:	c6ffe0ef          	jal	ra,ffffffffc0200408 <__panic>
    assert(n > 0);
ffffffffc020179e:	00001697          	auipc	a3,0x1
ffffffffc02017a2:	5da68693          	addi	a3,a3,1498 # ffffffffc0202d78 <commands+0xa40>
ffffffffc02017a6:	00001617          	auipc	a2,0x1
ffffffffc02017aa:	27a60613          	addi	a2,a2,634 # ffffffffc0202a20 <commands+0x6e8>
ffffffffc02017ae:	04600593          	li	a1,70
ffffffffc02017b2:	00001517          	auipc	a0,0x1
ffffffffc02017b6:	28650513          	addi	a0,a0,646 # ffffffffc0202a38 <commands+0x700>
ffffffffc02017ba:	c4ffe0ef          	jal	ra,ffffffffc0200408 <__panic>

ffffffffc02017be <alloc_pages>:
#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017be:	100027f3          	csrr	a5,sstatus
ffffffffc02017c2:	8b89                	andi	a5,a5,2
ffffffffc02017c4:	e799                	bnez	a5,ffffffffc02017d2 <alloc_pages+0x14>
struct Page *alloc_pages(size_t n) {
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc02017c6:	00006797          	auipc	a5,0x6
ffffffffc02017ca:	cb27b783          	ld	a5,-846(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017ce:	6f9c                	ld	a5,24(a5)
ffffffffc02017d0:	8782                	jr	a5
struct Page *alloc_pages(size_t n) {
ffffffffc02017d2:	1141                	addi	sp,sp,-16
ffffffffc02017d4:	e406                	sd	ra,8(sp)
ffffffffc02017d6:	e022                	sd	s0,0(sp)
ffffffffc02017d8:	842a                	mv	s0,a0
        intr_disable();
ffffffffc02017da:	890ff0ef          	jal	ra,ffffffffc020086a <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02017de:	00006797          	auipc	a5,0x6
ffffffffc02017e2:	c9a7b783          	ld	a5,-870(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017e6:	6f9c                	ld	a5,24(a5)
ffffffffc02017e8:	8522                	mv	a0,s0
ffffffffc02017ea:	9782                	jalr	a5
ffffffffc02017ec:	842a                	mv	s0,a0
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
ffffffffc02017ee:	876ff0ef          	jal	ra,ffffffffc0200864 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc02017f2:	60a2                	ld	ra,8(sp)
ffffffffc02017f4:	8522                	mv	a0,s0
ffffffffc02017f6:	6402                	ld	s0,0(sp)
ffffffffc02017f8:	0141                	addi	sp,sp,16
ffffffffc02017fa:	8082                	ret

ffffffffc02017fc <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017fc:	100027f3          	csrr	a5,sstatus
ffffffffc0201800:	8b89                	andi	a5,a5,2
ffffffffc0201802:	e799                	bnez	a5,ffffffffc0201810 <free_pages+0x14>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201804:	00006797          	auipc	a5,0x6
ffffffffc0201808:	c747b783          	ld	a5,-908(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc020180c:	739c                	ld	a5,32(a5)
ffffffffc020180e:	8782                	jr	a5
void free_pages(struct Page *base, size_t n) {
ffffffffc0201810:	1101                	addi	sp,sp,-32
ffffffffc0201812:	ec06                	sd	ra,24(sp)
ffffffffc0201814:	e822                	sd	s0,16(sp)
ffffffffc0201816:	e426                	sd	s1,8(sp)
ffffffffc0201818:	842a                	mv	s0,a0
ffffffffc020181a:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc020181c:	84eff0ef          	jal	ra,ffffffffc020086a <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201820:	00006797          	auipc	a5,0x6
ffffffffc0201824:	c587b783          	ld	a5,-936(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201828:	739c                	ld	a5,32(a5)
ffffffffc020182a:	85a6                	mv	a1,s1
ffffffffc020182c:	8522                	mv	a0,s0
ffffffffc020182e:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201830:	6442                	ld	s0,16(sp)
ffffffffc0201832:	60e2                	ld	ra,24(sp)
ffffffffc0201834:	64a2                	ld	s1,8(sp)
ffffffffc0201836:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201838:	82cff06f          	j	ffffffffc0200864 <intr_enable>

ffffffffc020183c <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020183c:	100027f3          	csrr	a5,sstatus
ffffffffc0201840:	8b89                	andi	a5,a5,2
ffffffffc0201842:	e799                	bnez	a5,ffffffffc0201850 <nr_free_pages+0x14>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201844:	00006797          	auipc	a5,0x6
ffffffffc0201848:	c347b783          	ld	a5,-972(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc020184c:	779c                	ld	a5,40(a5)
ffffffffc020184e:	8782                	jr	a5
size_t nr_free_pages(void) {
ffffffffc0201850:	1141                	addi	sp,sp,-16
ffffffffc0201852:	e406                	sd	ra,8(sp)
ffffffffc0201854:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201856:	814ff0ef          	jal	ra,ffffffffc020086a <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc020185a:	00006797          	auipc	a5,0x6
ffffffffc020185e:	c1e7b783          	ld	a5,-994(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201862:	779c                	ld	a5,40(a5)
ffffffffc0201864:	9782                	jalr	a5
ffffffffc0201866:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201868:	ffdfe0ef          	jal	ra,ffffffffc0200864 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc020186c:	60a2                	ld	ra,8(sp)
ffffffffc020186e:	8522                	mv	a0,s0
ffffffffc0201870:	6402                	ld	s0,0(sp)
ffffffffc0201872:	0141                	addi	sp,sp,16
ffffffffc0201874:	8082                	ret

ffffffffc0201876 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0201876:	00001797          	auipc	a5,0x1
ffffffffc020187a:	55a78793          	addi	a5,a5,1370 # ffffffffc0202dd0 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020187e:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0201880:	7179                	addi	sp,sp,-48
ffffffffc0201882:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201884:	00001517          	auipc	a0,0x1
ffffffffc0201888:	58450513          	addi	a0,a0,1412 # ffffffffc0202e08 <default_pmm_manager+0x38>
    pmm_manager = &default_pmm_manager;
ffffffffc020188c:	00006417          	auipc	s0,0x6
ffffffffc0201890:	bec40413          	addi	s0,s0,-1044 # ffffffffc0207478 <pmm_manager>
void pmm_init(void) {
ffffffffc0201894:	f406                	sd	ra,40(sp)
ffffffffc0201896:	ec26                	sd	s1,24(sp)
ffffffffc0201898:	e44e                	sd	s3,8(sp)
ffffffffc020189a:	e84a                	sd	s2,16(sp)
ffffffffc020189c:	e052                	sd	s4,0(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc020189e:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02018a0:	86ffe0ef          	jal	ra,ffffffffc020010e <cprintf>
    pmm_manager->init();
ffffffffc02018a4:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc02018a6:	00006497          	auipc	s1,0x6
ffffffffc02018aa:	bea48493          	addi	s1,s1,-1046 # ffffffffc0207490 <va_pa_offset>
    pmm_manager->init();
ffffffffc02018ae:	679c                	ld	a5,8(a5)
ffffffffc02018b0:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc02018b2:	57f5                	li	a5,-3
ffffffffc02018b4:	07fa                	slli	a5,a5,0x1e
ffffffffc02018b6:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc02018b8:	f99fe0ef          	jal	ra,ffffffffc0200850 <get_memory_base>
ffffffffc02018bc:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc02018be:	f9dfe0ef          	jal	ra,ffffffffc020085a <get_memory_size>
    if (mem_size == 0) {
ffffffffc02018c2:	16050163          	beqz	a0,ffffffffc0201a24 <pmm_init+0x1ae>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02018c6:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc02018c8:	00001517          	auipc	a0,0x1
ffffffffc02018cc:	58850513          	addi	a0,a0,1416 # ffffffffc0202e50 <default_pmm_manager+0x80>
ffffffffc02018d0:	83ffe0ef          	jal	ra,ffffffffc020010e <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02018d4:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc02018d8:	864e                	mv	a2,s3
ffffffffc02018da:	fffa0693          	addi	a3,s4,-1
ffffffffc02018de:	85ca                	mv	a1,s2
ffffffffc02018e0:	00001517          	auipc	a0,0x1
ffffffffc02018e4:	58850513          	addi	a0,a0,1416 # ffffffffc0202e68 <default_pmm_manager+0x98>
ffffffffc02018e8:	827fe0ef          	jal	ra,ffffffffc020010e <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02018ec:	c80007b7          	lui	a5,0xc8000
ffffffffc02018f0:	8652                	mv	a2,s4
ffffffffc02018f2:	0d47e863          	bltu	a5,s4,ffffffffc02019c2 <pmm_init+0x14c>
ffffffffc02018f6:	00007797          	auipc	a5,0x7
ffffffffc02018fa:	ba978793          	addi	a5,a5,-1111 # ffffffffc020849f <end+0xfff>
ffffffffc02018fe:	757d                	lui	a0,0xfffff
ffffffffc0201900:	8d7d                	and	a0,a0,a5
ffffffffc0201902:	8231                	srli	a2,a2,0xc
ffffffffc0201904:	00006597          	auipc	a1,0x6
ffffffffc0201908:	b6458593          	addi	a1,a1,-1180 # ffffffffc0207468 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc020190c:	00006817          	auipc	a6,0x6
ffffffffc0201910:	b6480813          	addi	a6,a6,-1180 # ffffffffc0207470 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0201914:	e190                	sd	a2,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0201916:	00a83023          	sd	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc020191a:	000807b7          	lui	a5,0x80
ffffffffc020191e:	02f60663          	beq	a2,a5,ffffffffc020194a <pmm_init+0xd4>
ffffffffc0201922:	4701                	li	a4,0
ffffffffc0201924:	4781                	li	a5,0
ffffffffc0201926:	4305                	li	t1,1
ffffffffc0201928:	fff808b7          	lui	a7,0xfff80
        SetPageReserved(pages + i);
ffffffffc020192c:	953a                	add	a0,a0,a4
ffffffffc020192e:	00850693          	addi	a3,a0,8 # fffffffffffff008 <end+0x3fdf7b68>
ffffffffc0201932:	4066b02f          	amoor.d	zero,t1,(a3)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0201936:	6190                	ld	a2,0(a1)
ffffffffc0201938:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc020193a:	00083503          	ld	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc020193e:	011606b3          	add	a3,a2,a7
ffffffffc0201942:	02870713          	addi	a4,a4,40
ffffffffc0201946:	fed7e3e3          	bltu	a5,a3,ffffffffc020192c <pmm_init+0xb6>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020194a:	00261693          	slli	a3,a2,0x2
ffffffffc020194e:	96b2                	add	a3,a3,a2
ffffffffc0201950:	fec007b7          	lui	a5,0xfec00
ffffffffc0201954:	97aa                	add	a5,a5,a0
ffffffffc0201956:	068e                	slli	a3,a3,0x3
ffffffffc0201958:	96be                	add	a3,a3,a5
ffffffffc020195a:	c02007b7          	lui	a5,0xc0200
ffffffffc020195e:	0af6e763          	bltu	a3,a5,ffffffffc0201a0c <pmm_init+0x196>
ffffffffc0201962:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0201964:	77fd                	lui	a5,0xfffff
ffffffffc0201966:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020196a:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc020196c:	04b6ee63          	bltu	a3,a1,ffffffffc02019c8 <pmm_init+0x152>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0201970:	601c                	ld	a5,0(s0)
ffffffffc0201972:	7b9c                	ld	a5,48(a5)
ffffffffc0201974:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0201976:	00001517          	auipc	a0,0x1
ffffffffc020197a:	57a50513          	addi	a0,a0,1402 # ffffffffc0202ef0 <default_pmm_manager+0x120>
ffffffffc020197e:	f90fe0ef          	jal	ra,ffffffffc020010e <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0201982:	00004597          	auipc	a1,0x4
ffffffffc0201986:	67e58593          	addi	a1,a1,1662 # ffffffffc0206000 <boot_page_table_sv39>
ffffffffc020198a:	00006797          	auipc	a5,0x6
ffffffffc020198e:	aeb7bf23          	sd	a1,-1282(a5) # ffffffffc0207488 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201992:	c02007b7          	lui	a5,0xc0200
ffffffffc0201996:	0af5e363          	bltu	a1,a5,ffffffffc0201a3c <pmm_init+0x1c6>
ffffffffc020199a:	6090                	ld	a2,0(s1)
}
ffffffffc020199c:	7402                	ld	s0,32(sp)
ffffffffc020199e:	70a2                	ld	ra,40(sp)
ffffffffc02019a0:	64e2                	ld	s1,24(sp)
ffffffffc02019a2:	6942                	ld	s2,16(sp)
ffffffffc02019a4:	69a2                	ld	s3,8(sp)
ffffffffc02019a6:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc02019a8:	40c58633          	sub	a2,a1,a2
ffffffffc02019ac:	00006797          	auipc	a5,0x6
ffffffffc02019b0:	acc7ba23          	sd	a2,-1324(a5) # ffffffffc0207480 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc02019b4:	00001517          	auipc	a0,0x1
ffffffffc02019b8:	55c50513          	addi	a0,a0,1372 # ffffffffc0202f10 <default_pmm_manager+0x140>
}
ffffffffc02019bc:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc02019be:	f50fe06f          	j	ffffffffc020010e <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02019c2:	c8000637          	lui	a2,0xc8000
ffffffffc02019c6:	bf05                	j	ffffffffc02018f6 <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc02019c8:	6705                	lui	a4,0x1
ffffffffc02019ca:	177d                	addi	a4,a4,-1
ffffffffc02019cc:	96ba                	add	a3,a3,a4
ffffffffc02019ce:	8efd                	and	a3,a3,a5
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc02019d0:	00c6d793          	srli	a5,a3,0xc
ffffffffc02019d4:	02c7f063          	bgeu	a5,a2,ffffffffc02019f4 <pmm_init+0x17e>
    pmm_manager->init_memmap(base, n);
ffffffffc02019d8:	6010                	ld	a2,0(s0)
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc02019da:	fff80737          	lui	a4,0xfff80
ffffffffc02019de:	973e                	add	a4,a4,a5
ffffffffc02019e0:	00271793          	slli	a5,a4,0x2
ffffffffc02019e4:	97ba                	add	a5,a5,a4
ffffffffc02019e6:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc02019e8:	8d95                	sub	a1,a1,a3
ffffffffc02019ea:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc02019ec:	81b1                	srli	a1,a1,0xc
ffffffffc02019ee:	953e                	add	a0,a0,a5
ffffffffc02019f0:	9702                	jalr	a4
}
ffffffffc02019f2:	bfbd                	j	ffffffffc0201970 <pmm_init+0xfa>
        panic("pa2page called with invalid pa");
ffffffffc02019f4:	00001617          	auipc	a2,0x1
ffffffffc02019f8:	4cc60613          	addi	a2,a2,1228 # ffffffffc0202ec0 <default_pmm_manager+0xf0>
ffffffffc02019fc:	06b00593          	li	a1,107
ffffffffc0201a00:	00001517          	auipc	a0,0x1
ffffffffc0201a04:	4e050513          	addi	a0,a0,1248 # ffffffffc0202ee0 <default_pmm_manager+0x110>
ffffffffc0201a08:	a01fe0ef          	jal	ra,ffffffffc0200408 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201a0c:	00001617          	auipc	a2,0x1
ffffffffc0201a10:	48c60613          	addi	a2,a2,1164 # ffffffffc0202e98 <default_pmm_manager+0xc8>
ffffffffc0201a14:	07100593          	li	a1,113
ffffffffc0201a18:	00001517          	auipc	a0,0x1
ffffffffc0201a1c:	42850513          	addi	a0,a0,1064 # ffffffffc0202e40 <default_pmm_manager+0x70>
ffffffffc0201a20:	9e9fe0ef          	jal	ra,ffffffffc0200408 <__panic>
        panic("DTB memory info not available");
ffffffffc0201a24:	00001617          	auipc	a2,0x1
ffffffffc0201a28:	3fc60613          	addi	a2,a2,1020 # ffffffffc0202e20 <default_pmm_manager+0x50>
ffffffffc0201a2c:	05a00593          	li	a1,90
ffffffffc0201a30:	00001517          	auipc	a0,0x1
ffffffffc0201a34:	41050513          	addi	a0,a0,1040 # ffffffffc0202e40 <default_pmm_manager+0x70>
ffffffffc0201a38:	9d1fe0ef          	jal	ra,ffffffffc0200408 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201a3c:	86ae                	mv	a3,a1
ffffffffc0201a3e:	00001617          	auipc	a2,0x1
ffffffffc0201a42:	45a60613          	addi	a2,a2,1114 # ffffffffc0202e98 <default_pmm_manager+0xc8>
ffffffffc0201a46:	08c00593          	li	a1,140
ffffffffc0201a4a:	00001517          	auipc	a0,0x1
ffffffffc0201a4e:	3f650513          	addi	a0,a0,1014 # ffffffffc0202e40 <default_pmm_manager+0x70>
ffffffffc0201a52:	9b7fe0ef          	jal	ra,ffffffffc0200408 <__panic>

ffffffffc0201a56 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0201a56:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a5a:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0201a5c:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a60:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0201a62:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a66:	f022                	sd	s0,32(sp)
ffffffffc0201a68:	ec26                	sd	s1,24(sp)
ffffffffc0201a6a:	e84a                	sd	s2,16(sp)
ffffffffc0201a6c:	f406                	sd	ra,40(sp)
ffffffffc0201a6e:	e44e                	sd	s3,8(sp)
ffffffffc0201a70:	84aa                	mv	s1,a0
ffffffffc0201a72:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0201a74:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201a78:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0201a7a:	03067e63          	bgeu	a2,a6,ffffffffc0201ab6 <printnum+0x60>
ffffffffc0201a7e:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201a80:	00805763          	blez	s0,ffffffffc0201a8e <printnum+0x38>
ffffffffc0201a84:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201a86:	85ca                	mv	a1,s2
ffffffffc0201a88:	854e                	mv	a0,s3
ffffffffc0201a8a:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0201a8c:	fc65                	bnez	s0,ffffffffc0201a84 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a8e:	1a02                	slli	s4,s4,0x20
ffffffffc0201a90:	00001797          	auipc	a5,0x1
ffffffffc0201a94:	4c078793          	addi	a5,a5,1216 # ffffffffc0202f50 <default_pmm_manager+0x180>
ffffffffc0201a98:	020a5a13          	srli	s4,s4,0x20
ffffffffc0201a9c:	9a3e                	add	s4,s4,a5
}
ffffffffc0201a9e:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201aa0:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201aa4:	70a2                	ld	ra,40(sp)
ffffffffc0201aa6:	69a2                	ld	s3,8(sp)
ffffffffc0201aa8:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201aaa:	85ca                	mv	a1,s2
ffffffffc0201aac:	87a6                	mv	a5,s1
}
ffffffffc0201aae:	6942                	ld	s2,16(sp)
ffffffffc0201ab0:	64e2                	ld	s1,24(sp)
ffffffffc0201ab2:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201ab4:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201ab6:	03065633          	divu	a2,a2,a6
ffffffffc0201aba:	8722                	mv	a4,s0
ffffffffc0201abc:	f9bff0ef          	jal	ra,ffffffffc0201a56 <printnum>
ffffffffc0201ac0:	b7f9                	j	ffffffffc0201a8e <printnum+0x38>

ffffffffc0201ac2 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201ac2:	7119                	addi	sp,sp,-128
ffffffffc0201ac4:	f4a6                	sd	s1,104(sp)
ffffffffc0201ac6:	f0ca                	sd	s2,96(sp)
ffffffffc0201ac8:	ecce                	sd	s3,88(sp)
ffffffffc0201aca:	e8d2                	sd	s4,80(sp)
ffffffffc0201acc:	e4d6                	sd	s5,72(sp)
ffffffffc0201ace:	e0da                	sd	s6,64(sp)
ffffffffc0201ad0:	fc5e                	sd	s7,56(sp)
ffffffffc0201ad2:	f06a                	sd	s10,32(sp)
ffffffffc0201ad4:	fc86                	sd	ra,120(sp)
ffffffffc0201ad6:	f8a2                	sd	s0,112(sp)
ffffffffc0201ad8:	f862                	sd	s8,48(sp)
ffffffffc0201ada:	f466                	sd	s9,40(sp)
ffffffffc0201adc:	ec6e                	sd	s11,24(sp)
ffffffffc0201ade:	892a                	mv	s2,a0
ffffffffc0201ae0:	84ae                	mv	s1,a1
ffffffffc0201ae2:	8d32                	mv	s10,a2
ffffffffc0201ae4:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201ae6:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0201aea:	5b7d                	li	s6,-1
ffffffffc0201aec:	00001a97          	auipc	s5,0x1
ffffffffc0201af0:	498a8a93          	addi	s5,s5,1176 # ffffffffc0202f84 <default_pmm_manager+0x1b4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201af4:	00001b97          	auipc	s7,0x1
ffffffffc0201af8:	66cb8b93          	addi	s7,s7,1644 # ffffffffc0203160 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201afc:	000d4503          	lbu	a0,0(s10)
ffffffffc0201b00:	001d0413          	addi	s0,s10,1
ffffffffc0201b04:	01350a63          	beq	a0,s3,ffffffffc0201b18 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201b08:	c121                	beqz	a0,ffffffffc0201b48 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0201b0a:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201b0c:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0201b0e:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201b10:	fff44503          	lbu	a0,-1(s0)
ffffffffc0201b14:	ff351ae3          	bne	a0,s3,ffffffffc0201b08 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b18:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0201b1c:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0201b20:	4c81                	li	s9,0
ffffffffc0201b22:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0201b24:	5c7d                	li	s8,-1
ffffffffc0201b26:	5dfd                	li	s11,-1
ffffffffc0201b28:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0201b2c:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b2e:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201b32:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b36:	00140d13          	addi	s10,s0,1
ffffffffc0201b3a:	04b56263          	bltu	a0,a1,ffffffffc0201b7e <vprintfmt+0xbc>
ffffffffc0201b3e:	058a                	slli	a1,a1,0x2
ffffffffc0201b40:	95d6                	add	a1,a1,s5
ffffffffc0201b42:	4194                	lw	a3,0(a1)
ffffffffc0201b44:	96d6                	add	a3,a3,s5
ffffffffc0201b46:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0201b48:	70e6                	ld	ra,120(sp)
ffffffffc0201b4a:	7446                	ld	s0,112(sp)
ffffffffc0201b4c:	74a6                	ld	s1,104(sp)
ffffffffc0201b4e:	7906                	ld	s2,96(sp)
ffffffffc0201b50:	69e6                	ld	s3,88(sp)
ffffffffc0201b52:	6a46                	ld	s4,80(sp)
ffffffffc0201b54:	6aa6                	ld	s5,72(sp)
ffffffffc0201b56:	6b06                	ld	s6,64(sp)
ffffffffc0201b58:	7be2                	ld	s7,56(sp)
ffffffffc0201b5a:	7c42                	ld	s8,48(sp)
ffffffffc0201b5c:	7ca2                	ld	s9,40(sp)
ffffffffc0201b5e:	7d02                	ld	s10,32(sp)
ffffffffc0201b60:	6de2                	ld	s11,24(sp)
ffffffffc0201b62:	6109                	addi	sp,sp,128
ffffffffc0201b64:	8082                	ret
            padc = '0';
ffffffffc0201b66:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201b68:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b6c:	846a                	mv	s0,s10
ffffffffc0201b6e:	00140d13          	addi	s10,s0,1
ffffffffc0201b72:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201b76:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b7a:	fcb572e3          	bgeu	a0,a1,ffffffffc0201b3e <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0201b7e:	85a6                	mv	a1,s1
ffffffffc0201b80:	02500513          	li	a0,37
ffffffffc0201b84:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201b86:	fff44783          	lbu	a5,-1(s0)
ffffffffc0201b8a:	8d22                	mv	s10,s0
ffffffffc0201b8c:	f73788e3          	beq	a5,s3,ffffffffc0201afc <vprintfmt+0x3a>
ffffffffc0201b90:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201b94:	1d7d                	addi	s10,s10,-1
ffffffffc0201b96:	ff379de3          	bne	a5,s3,ffffffffc0201b90 <vprintfmt+0xce>
ffffffffc0201b9a:	b78d                	j	ffffffffc0201afc <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0201b9c:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201ba0:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ba4:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201ba6:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0201baa:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201bae:	02d86463          	bltu	a6,a3,ffffffffc0201bd6 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201bb2:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201bb6:	002c169b          	slliw	a3,s8,0x2
ffffffffc0201bba:	0186873b          	addw	a4,a3,s8
ffffffffc0201bbe:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201bc2:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201bc4:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201bc8:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0201bca:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0201bce:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201bd2:	fed870e3          	bgeu	a6,a3,ffffffffc0201bb2 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201bd6:	f40ddce3          	bgez	s11,ffffffffc0201b2e <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201bda:	8de2                	mv	s11,s8
ffffffffc0201bdc:	5c7d                	li	s8,-1
ffffffffc0201bde:	bf81                	j	ffffffffc0201b2e <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201be0:	fffdc693          	not	a3,s11
ffffffffc0201be4:	96fd                	srai	a3,a3,0x3f
ffffffffc0201be6:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bea:	00144603          	lbu	a2,1(s0)
ffffffffc0201bee:	2d81                	sext.w	s11,s11
ffffffffc0201bf0:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201bf2:	bf35                	j	ffffffffc0201b2e <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201bf4:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bf8:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201bfc:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bfe:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201c00:	bfd9                	j	ffffffffc0201bd6 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201c02:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c04:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c08:	01174463          	blt	a4,a7,ffffffffc0201c10 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201c0c:	1a088e63          	beqz	a7,ffffffffc0201dc8 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201c10:	000a3603          	ld	a2,0(s4)
ffffffffc0201c14:	46c1                	li	a3,16
ffffffffc0201c16:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0201c18:	2781                	sext.w	a5,a5
ffffffffc0201c1a:	876e                	mv	a4,s11
ffffffffc0201c1c:	85a6                	mv	a1,s1
ffffffffc0201c1e:	854a                	mv	a0,s2
ffffffffc0201c20:	e37ff0ef          	jal	ra,ffffffffc0201a56 <printnum>
            break;
ffffffffc0201c24:	bde1                	j	ffffffffc0201afc <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0201c26:	000a2503          	lw	a0,0(s4)
ffffffffc0201c2a:	85a6                	mv	a1,s1
ffffffffc0201c2c:	0a21                	addi	s4,s4,8
ffffffffc0201c2e:	9902                	jalr	s2
            break;
ffffffffc0201c30:	b5f1                	j	ffffffffc0201afc <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201c32:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c34:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c38:	01174463          	blt	a4,a7,ffffffffc0201c40 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201c3c:	18088163          	beqz	a7,ffffffffc0201dbe <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201c40:	000a3603          	ld	a2,0(s4)
ffffffffc0201c44:	46a9                	li	a3,10
ffffffffc0201c46:	8a2e                	mv	s4,a1
ffffffffc0201c48:	bfc1                	j	ffffffffc0201c18 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c4a:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201c4e:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c50:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201c52:	bdf1                	j	ffffffffc0201b2e <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0201c54:	85a6                	mv	a1,s1
ffffffffc0201c56:	02500513          	li	a0,37
ffffffffc0201c5a:	9902                	jalr	s2
            break;
ffffffffc0201c5c:	b545                	j	ffffffffc0201afc <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c5e:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201c62:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c64:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201c66:	b5e1                	j	ffffffffc0201b2e <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201c68:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c6a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c6e:	01174463          	blt	a4,a7,ffffffffc0201c76 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201c72:	14088163          	beqz	a7,ffffffffc0201db4 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201c76:	000a3603          	ld	a2,0(s4)
ffffffffc0201c7a:	46a1                	li	a3,8
ffffffffc0201c7c:	8a2e                	mv	s4,a1
ffffffffc0201c7e:	bf69                	j	ffffffffc0201c18 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201c80:	03000513          	li	a0,48
ffffffffc0201c84:	85a6                	mv	a1,s1
ffffffffc0201c86:	e03e                	sd	a5,0(sp)
ffffffffc0201c88:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0201c8a:	85a6                	mv	a1,s1
ffffffffc0201c8c:	07800513          	li	a0,120
ffffffffc0201c90:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c92:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201c94:	6782                	ld	a5,0(sp)
ffffffffc0201c96:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c98:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0201c9c:	bfb5                	j	ffffffffc0201c18 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201c9e:	000a3403          	ld	s0,0(s4)
ffffffffc0201ca2:	008a0713          	addi	a4,s4,8
ffffffffc0201ca6:	e03a                	sd	a4,0(sp)
ffffffffc0201ca8:	14040263          	beqz	s0,ffffffffc0201dec <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0201cac:	0fb05763          	blez	s11,ffffffffc0201d9a <vprintfmt+0x2d8>
ffffffffc0201cb0:	02d00693          	li	a3,45
ffffffffc0201cb4:	0cd79163          	bne	a5,a3,ffffffffc0201d76 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201cb8:	00044783          	lbu	a5,0(s0)
ffffffffc0201cbc:	0007851b          	sext.w	a0,a5
ffffffffc0201cc0:	cf85                	beqz	a5,ffffffffc0201cf8 <vprintfmt+0x236>
ffffffffc0201cc2:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201cc6:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201cca:	000c4563          	bltz	s8,ffffffffc0201cd4 <vprintfmt+0x212>
ffffffffc0201cce:	3c7d                	addiw	s8,s8,-1
ffffffffc0201cd0:	036c0263          	beq	s8,s6,ffffffffc0201cf4 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201cd4:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201cd6:	0e0c8e63          	beqz	s9,ffffffffc0201dd2 <vprintfmt+0x310>
ffffffffc0201cda:	3781                	addiw	a5,a5,-32
ffffffffc0201cdc:	0ef47b63          	bgeu	s0,a5,ffffffffc0201dd2 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201ce0:	03f00513          	li	a0,63
ffffffffc0201ce4:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201ce6:	000a4783          	lbu	a5,0(s4)
ffffffffc0201cea:	3dfd                	addiw	s11,s11,-1
ffffffffc0201cec:	0a05                	addi	s4,s4,1
ffffffffc0201cee:	0007851b          	sext.w	a0,a5
ffffffffc0201cf2:	ffe1                	bnez	a5,ffffffffc0201cca <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201cf4:	01b05963          	blez	s11,ffffffffc0201d06 <vprintfmt+0x244>
ffffffffc0201cf8:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201cfa:	85a6                	mv	a1,s1
ffffffffc0201cfc:	02000513          	li	a0,32
ffffffffc0201d00:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201d02:	fe0d9be3          	bnez	s11,ffffffffc0201cf8 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201d06:	6a02                	ld	s4,0(sp)
ffffffffc0201d08:	bbd5                	j	ffffffffc0201afc <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201d0a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201d0c:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201d10:	01174463          	blt	a4,a7,ffffffffc0201d18 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0201d14:	08088d63          	beqz	a7,ffffffffc0201dae <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201d18:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201d1c:	0a044d63          	bltz	s0,ffffffffc0201dd6 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201d20:	8622                	mv	a2,s0
ffffffffc0201d22:	8a66                	mv	s4,s9
ffffffffc0201d24:	46a9                	li	a3,10
ffffffffc0201d26:	bdcd                	j	ffffffffc0201c18 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201d28:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201d2c:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201d2e:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201d30:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0201d34:	8fb5                	xor	a5,a5,a3
ffffffffc0201d36:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201d3a:	02d74163          	blt	a4,a3,ffffffffc0201d5c <vprintfmt+0x29a>
ffffffffc0201d3e:	00369793          	slli	a5,a3,0x3
ffffffffc0201d42:	97de                	add	a5,a5,s7
ffffffffc0201d44:	639c                	ld	a5,0(a5)
ffffffffc0201d46:	cb99                	beqz	a5,ffffffffc0201d5c <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201d48:	86be                	mv	a3,a5
ffffffffc0201d4a:	00001617          	auipc	a2,0x1
ffffffffc0201d4e:	23660613          	addi	a2,a2,566 # ffffffffc0202f80 <default_pmm_manager+0x1b0>
ffffffffc0201d52:	85a6                	mv	a1,s1
ffffffffc0201d54:	854a                	mv	a0,s2
ffffffffc0201d56:	0ce000ef          	jal	ra,ffffffffc0201e24 <printfmt>
ffffffffc0201d5a:	b34d                	j	ffffffffc0201afc <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201d5c:	00001617          	auipc	a2,0x1
ffffffffc0201d60:	21460613          	addi	a2,a2,532 # ffffffffc0202f70 <default_pmm_manager+0x1a0>
ffffffffc0201d64:	85a6                	mv	a1,s1
ffffffffc0201d66:	854a                	mv	a0,s2
ffffffffc0201d68:	0bc000ef          	jal	ra,ffffffffc0201e24 <printfmt>
ffffffffc0201d6c:	bb41                	j	ffffffffc0201afc <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0201d6e:	00001417          	auipc	s0,0x1
ffffffffc0201d72:	1fa40413          	addi	s0,s0,506 # ffffffffc0202f68 <default_pmm_manager+0x198>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d76:	85e2                	mv	a1,s8
ffffffffc0201d78:	8522                	mv	a0,s0
ffffffffc0201d7a:	e43e                	sd	a5,8(sp)
ffffffffc0201d7c:	200000ef          	jal	ra,ffffffffc0201f7c <strnlen>
ffffffffc0201d80:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201d84:	01b05b63          	blez	s11,ffffffffc0201d9a <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201d88:	67a2                	ld	a5,8(sp)
ffffffffc0201d8a:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d8e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201d90:	85a6                	mv	a1,s1
ffffffffc0201d92:	8552                	mv	a0,s4
ffffffffc0201d94:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d96:	fe0d9ce3          	bnez	s11,ffffffffc0201d8e <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201d9a:	00044783          	lbu	a5,0(s0)
ffffffffc0201d9e:	00140a13          	addi	s4,s0,1
ffffffffc0201da2:	0007851b          	sext.w	a0,a5
ffffffffc0201da6:	d3a5                	beqz	a5,ffffffffc0201d06 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201da8:	05e00413          	li	s0,94
ffffffffc0201dac:	bf39                	j	ffffffffc0201cca <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0201dae:	000a2403          	lw	s0,0(s4)
ffffffffc0201db2:	b7ad                	j	ffffffffc0201d1c <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201db4:	000a6603          	lwu	a2,0(s4)
ffffffffc0201db8:	46a1                	li	a3,8
ffffffffc0201dba:	8a2e                	mv	s4,a1
ffffffffc0201dbc:	bdb1                	j	ffffffffc0201c18 <vprintfmt+0x156>
ffffffffc0201dbe:	000a6603          	lwu	a2,0(s4)
ffffffffc0201dc2:	46a9                	li	a3,10
ffffffffc0201dc4:	8a2e                	mv	s4,a1
ffffffffc0201dc6:	bd89                	j	ffffffffc0201c18 <vprintfmt+0x156>
ffffffffc0201dc8:	000a6603          	lwu	a2,0(s4)
ffffffffc0201dcc:	46c1                	li	a3,16
ffffffffc0201dce:	8a2e                	mv	s4,a1
ffffffffc0201dd0:	b5a1                	j	ffffffffc0201c18 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201dd2:	9902                	jalr	s2
ffffffffc0201dd4:	bf09                	j	ffffffffc0201ce6 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201dd6:	85a6                	mv	a1,s1
ffffffffc0201dd8:	02d00513          	li	a0,45
ffffffffc0201ddc:	e03e                	sd	a5,0(sp)
ffffffffc0201dde:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201de0:	6782                	ld	a5,0(sp)
ffffffffc0201de2:	8a66                	mv	s4,s9
ffffffffc0201de4:	40800633          	neg	a2,s0
ffffffffc0201de8:	46a9                	li	a3,10
ffffffffc0201dea:	b53d                	j	ffffffffc0201c18 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201dec:	03b05163          	blez	s11,ffffffffc0201e0e <vprintfmt+0x34c>
ffffffffc0201df0:	02d00693          	li	a3,45
ffffffffc0201df4:	f6d79de3          	bne	a5,a3,ffffffffc0201d6e <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201df8:	00001417          	auipc	s0,0x1
ffffffffc0201dfc:	17040413          	addi	s0,s0,368 # ffffffffc0202f68 <default_pmm_manager+0x198>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201e00:	02800793          	li	a5,40
ffffffffc0201e04:	02800513          	li	a0,40
ffffffffc0201e08:	00140a13          	addi	s4,s0,1
ffffffffc0201e0c:	bd6d                	j	ffffffffc0201cc6 <vprintfmt+0x204>
ffffffffc0201e0e:	00001a17          	auipc	s4,0x1
ffffffffc0201e12:	15ba0a13          	addi	s4,s4,347 # ffffffffc0202f69 <default_pmm_manager+0x199>
ffffffffc0201e16:	02800513          	li	a0,40
ffffffffc0201e1a:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201e1e:	05e00413          	li	s0,94
ffffffffc0201e22:	b565                	j	ffffffffc0201cca <vprintfmt+0x208>

ffffffffc0201e24 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e24:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201e26:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e2a:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201e2c:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e2e:	ec06                	sd	ra,24(sp)
ffffffffc0201e30:	f83a                	sd	a4,48(sp)
ffffffffc0201e32:	fc3e                	sd	a5,56(sp)
ffffffffc0201e34:	e0c2                	sd	a6,64(sp)
ffffffffc0201e36:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201e38:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201e3a:	c89ff0ef          	jal	ra,ffffffffc0201ac2 <vprintfmt>
}
ffffffffc0201e3e:	60e2                	ld	ra,24(sp)
ffffffffc0201e40:	6161                	addi	sp,sp,80
ffffffffc0201e42:	8082                	ret

ffffffffc0201e44 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0201e44:	715d                	addi	sp,sp,-80
ffffffffc0201e46:	e486                	sd	ra,72(sp)
ffffffffc0201e48:	e0a6                	sd	s1,64(sp)
ffffffffc0201e4a:	fc4a                	sd	s2,56(sp)
ffffffffc0201e4c:	f84e                	sd	s3,48(sp)
ffffffffc0201e4e:	f452                	sd	s4,40(sp)
ffffffffc0201e50:	f056                	sd	s5,32(sp)
ffffffffc0201e52:	ec5a                	sd	s6,24(sp)
ffffffffc0201e54:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0201e56:	c901                	beqz	a0,ffffffffc0201e66 <readline+0x22>
ffffffffc0201e58:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0201e5a:	00001517          	auipc	a0,0x1
ffffffffc0201e5e:	12650513          	addi	a0,a0,294 # ffffffffc0202f80 <default_pmm_manager+0x1b0>
ffffffffc0201e62:	aacfe0ef          	jal	ra,ffffffffc020010e <cprintf>
readline(const char *prompt) {
ffffffffc0201e66:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e68:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0201e6a:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0201e6c:	4aa9                	li	s5,10
ffffffffc0201e6e:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0201e70:	00005b97          	auipc	s7,0x5
ffffffffc0201e74:	1d0b8b93          	addi	s7,s7,464 # ffffffffc0207040 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e78:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0201e7c:	b0afe0ef          	jal	ra,ffffffffc0200186 <getchar>
        if (c < 0) {
ffffffffc0201e80:	00054a63          	bltz	a0,ffffffffc0201e94 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e84:	00a95a63          	bge	s2,a0,ffffffffc0201e98 <readline+0x54>
ffffffffc0201e88:	029a5263          	bge	s4,s1,ffffffffc0201eac <readline+0x68>
        c = getchar();
ffffffffc0201e8c:	afafe0ef          	jal	ra,ffffffffc0200186 <getchar>
        if (c < 0) {
ffffffffc0201e90:	fe055ae3          	bgez	a0,ffffffffc0201e84 <readline+0x40>
            return NULL;
ffffffffc0201e94:	4501                	li	a0,0
ffffffffc0201e96:	a091                	j	ffffffffc0201eda <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc0201e98:	03351463          	bne	a0,s3,ffffffffc0201ec0 <readline+0x7c>
ffffffffc0201e9c:	e8a9                	bnez	s1,ffffffffc0201eee <readline+0xaa>
        c = getchar();
ffffffffc0201e9e:	ae8fe0ef          	jal	ra,ffffffffc0200186 <getchar>
        if (c < 0) {
ffffffffc0201ea2:	fe0549e3          	bltz	a0,ffffffffc0201e94 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201ea6:	fea959e3          	bge	s2,a0,ffffffffc0201e98 <readline+0x54>
ffffffffc0201eaa:	4481                	li	s1,0
            cputchar(c);
ffffffffc0201eac:	e42a                	sd	a0,8(sp)
ffffffffc0201eae:	a96fe0ef          	jal	ra,ffffffffc0200144 <cputchar>
            buf[i ++] = c;
ffffffffc0201eb2:	6522                	ld	a0,8(sp)
ffffffffc0201eb4:	009b87b3          	add	a5,s7,s1
ffffffffc0201eb8:	2485                	addiw	s1,s1,1
ffffffffc0201eba:	00a78023          	sb	a0,0(a5)
ffffffffc0201ebe:	bf7d                	j	ffffffffc0201e7c <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0201ec0:	01550463          	beq	a0,s5,ffffffffc0201ec8 <readline+0x84>
ffffffffc0201ec4:	fb651ce3          	bne	a0,s6,ffffffffc0201e7c <readline+0x38>
            cputchar(c);
ffffffffc0201ec8:	a7cfe0ef          	jal	ra,ffffffffc0200144 <cputchar>
            buf[i] = '\0';
ffffffffc0201ecc:	00005517          	auipc	a0,0x5
ffffffffc0201ed0:	17450513          	addi	a0,a0,372 # ffffffffc0207040 <buf>
ffffffffc0201ed4:	94aa                	add	s1,s1,a0
ffffffffc0201ed6:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0201eda:	60a6                	ld	ra,72(sp)
ffffffffc0201edc:	6486                	ld	s1,64(sp)
ffffffffc0201ede:	7962                	ld	s2,56(sp)
ffffffffc0201ee0:	79c2                	ld	s3,48(sp)
ffffffffc0201ee2:	7a22                	ld	s4,40(sp)
ffffffffc0201ee4:	7a82                	ld	s5,32(sp)
ffffffffc0201ee6:	6b62                	ld	s6,24(sp)
ffffffffc0201ee8:	6bc2                	ld	s7,16(sp)
ffffffffc0201eea:	6161                	addi	sp,sp,80
ffffffffc0201eec:	8082                	ret
            cputchar(c);
ffffffffc0201eee:	4521                	li	a0,8
ffffffffc0201ef0:	a54fe0ef          	jal	ra,ffffffffc0200144 <cputchar>
            i --;
ffffffffc0201ef4:	34fd                	addiw	s1,s1,-1
ffffffffc0201ef6:	b759                	j	ffffffffc0201e7c <readline+0x38>

ffffffffc0201ef8 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201ef8:	4781                	li	a5,0
ffffffffc0201efa:	00005717          	auipc	a4,0x5
ffffffffc0201efe:	11e73703          	ld	a4,286(a4) # ffffffffc0207018 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201f02:	88ba                	mv	a7,a4
ffffffffc0201f04:	852a                	mv	a0,a0
ffffffffc0201f06:	85be                	mv	a1,a5
ffffffffc0201f08:	863e                	mv	a2,a5
ffffffffc0201f0a:	00000073          	ecall
ffffffffc0201f0e:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201f10:	8082                	ret

ffffffffc0201f12 <sbi_set_timer>:
    __asm__ volatile (
ffffffffc0201f12:	4781                	li	a5,0
ffffffffc0201f14:	00005717          	auipc	a4,0x5
ffffffffc0201f18:	58473703          	ld	a4,1412(a4) # ffffffffc0207498 <SBI_SET_TIMER>
ffffffffc0201f1c:	88ba                	mv	a7,a4
ffffffffc0201f1e:	852a                	mv	a0,a0
ffffffffc0201f20:	85be                	mv	a1,a5
ffffffffc0201f22:	863e                	mv	a2,a5
ffffffffc0201f24:	00000073          	ecall
ffffffffc0201f28:	87aa                	mv	a5,a0

void sbi_set_timer(unsigned long long stime_value) {
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
}
ffffffffc0201f2a:	8082                	ret

ffffffffc0201f2c <sbi_console_getchar>:
    __asm__ volatile (
ffffffffc0201f2c:	4501                	li	a0,0
ffffffffc0201f2e:	00005797          	auipc	a5,0x5
ffffffffc0201f32:	0e27b783          	ld	a5,226(a5) # ffffffffc0207010 <SBI_CONSOLE_GETCHAR>
ffffffffc0201f36:	88be                	mv	a7,a5
ffffffffc0201f38:	852a                	mv	a0,a0
ffffffffc0201f3a:	85aa                	mv	a1,a0
ffffffffc0201f3c:	862a                	mv	a2,a0
ffffffffc0201f3e:	00000073          	ecall
ffffffffc0201f42:	852a                	mv	a0,a0

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
ffffffffc0201f44:	2501                	sext.w	a0,a0
ffffffffc0201f46:	8082                	ret

ffffffffc0201f48 <sbi_shutdown>:
    __asm__ volatile (
ffffffffc0201f48:	4781                	li	a5,0
ffffffffc0201f4a:	00005717          	auipc	a4,0x5
ffffffffc0201f4e:	0d673703          	ld	a4,214(a4) # ffffffffc0207020 <SBI_SHUTDOWN>
ffffffffc0201f52:	88ba                	mv	a7,a4
ffffffffc0201f54:	853e                	mv	a0,a5
ffffffffc0201f56:	85be                	mv	a1,a5
ffffffffc0201f58:	863e                	mv	a2,a5
ffffffffc0201f5a:	00000073          	ecall
ffffffffc0201f5e:	87aa                	mv	a5,a0

void sbi_shutdown(void)
{
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
ffffffffc0201f60:	8082                	ret

ffffffffc0201f62 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201f62:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201f66:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201f68:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201f6a:	cb81                	beqz	a5,ffffffffc0201f7a <strlen+0x18>
        cnt ++;
ffffffffc0201f6c:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0201f6e:	00a707b3          	add	a5,a4,a0
ffffffffc0201f72:	0007c783          	lbu	a5,0(a5)
ffffffffc0201f76:	fbfd                	bnez	a5,ffffffffc0201f6c <strlen+0xa>
ffffffffc0201f78:	8082                	ret
    }
    return cnt;
}
ffffffffc0201f7a:	8082                	ret

ffffffffc0201f7c <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201f7c:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f7e:	e589                	bnez	a1,ffffffffc0201f88 <strnlen+0xc>
ffffffffc0201f80:	a811                	j	ffffffffc0201f94 <strnlen+0x18>
        cnt ++;
ffffffffc0201f82:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f84:	00f58863          	beq	a1,a5,ffffffffc0201f94 <strnlen+0x18>
ffffffffc0201f88:	00f50733          	add	a4,a0,a5
ffffffffc0201f8c:	00074703          	lbu	a4,0(a4)
ffffffffc0201f90:	fb6d                	bnez	a4,ffffffffc0201f82 <strnlen+0x6>
ffffffffc0201f92:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201f94:	852e                	mv	a0,a1
ffffffffc0201f96:	8082                	ret

ffffffffc0201f98 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f98:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f9c:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201fa0:	cb89                	beqz	a5,ffffffffc0201fb2 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0201fa2:	0505                	addi	a0,a0,1
ffffffffc0201fa4:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201fa6:	fee789e3          	beq	a5,a4,ffffffffc0201f98 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201faa:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0201fae:	9d19                	subw	a0,a0,a4
ffffffffc0201fb0:	8082                	ret
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	bfed                	j	ffffffffc0201fae <strcmp+0x16>

ffffffffc0201fb6 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fb6:	c20d                	beqz	a2,ffffffffc0201fd8 <strncmp+0x22>
ffffffffc0201fb8:	962e                	add	a2,a2,a1
ffffffffc0201fba:	a031                	j	ffffffffc0201fc6 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201fbc:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fbe:	00e79a63          	bne	a5,a4,ffffffffc0201fd2 <strncmp+0x1c>
ffffffffc0201fc2:	00b60b63          	beq	a2,a1,ffffffffc0201fd8 <strncmp+0x22>
ffffffffc0201fc6:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201fca:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fcc:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0201fd0:	f7f5                	bnez	a5,ffffffffc0201fbc <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fd2:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201fd6:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fd8:	4501                	li	a0,0
ffffffffc0201fda:	8082                	ret

ffffffffc0201fdc <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0201fdc:	00054783          	lbu	a5,0(a0)
ffffffffc0201fe0:	c799                	beqz	a5,ffffffffc0201fee <strchr+0x12>
        if (*s == c) {
ffffffffc0201fe2:	00f58763          	beq	a1,a5,ffffffffc0201ff0 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0201fe6:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0201fea:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0201fec:	fbfd                	bnez	a5,ffffffffc0201fe2 <strchr+0x6>
    }
    return NULL;
ffffffffc0201fee:	4501                	li	a0,0
}
ffffffffc0201ff0:	8082                	ret

ffffffffc0201ff2 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201ff2:	ca01                	beqz	a2,ffffffffc0202002 <memset+0x10>
ffffffffc0201ff4:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201ff6:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201ff8:	0785                	addi	a5,a5,1
ffffffffc0201ffa:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201ffe:	fec79de3          	bne	a5,a2,ffffffffc0201ff8 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0202002:	8082                	ret
