
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000c297          	auipc	t0,0xc
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020c000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000c297          	auipc	t0,0xc
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020c008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020b2b7          	lui	t0,0xc020b
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
ffffffffc020003c:	c020b137          	lui	sp,0xc020b

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc020004a:	000e3517          	auipc	a0,0xe3
ffffffffc020004e:	94e50513          	addi	a0,a0,-1714 # ffffffffc02e2998 <buf>
ffffffffc0200052:	000e7617          	auipc	a2,0xe7
ffffffffc0200056:	e2660613          	addi	a2,a2,-474 # ffffffffc02e6e78 <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	529050ef          	jal	ra,ffffffffc0205d8a <memset>
    cons_init(); // init the console
ffffffffc0200066:	520000ef          	jal	ra,ffffffffc0200586 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006a:	00006597          	auipc	a1,0x6
ffffffffc020006e:	d4e58593          	addi	a1,a1,-690 # ffffffffc0205db8 <etext+0x4>
ffffffffc0200072:	00006517          	auipc	a0,0x6
ffffffffc0200076:	d6650513          	addi	a0,a0,-666 # ffffffffc0205dd8 <etext+0x24>
ffffffffc020007a:	11e000ef          	jal	ra,ffffffffc0200198 <cprintf>

    print_kerninfo();
ffffffffc020007e:	1a2000ef          	jal	ra,ffffffffc0200220 <print_kerninfo>

    // grade_backtrace();

    dtb_init(); // init dtb
ffffffffc0200082:	576000ef          	jal	ra,ffffffffc02005f8 <dtb_init>

    pmm_init(); // init physical memory management
ffffffffc0200086:	5e0020ef          	jal	ra,ffffffffc0202666 <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	12b000ef          	jal	ra,ffffffffc02009b4 <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	129000ef          	jal	ra,ffffffffc02009b6 <idt_init>

    vmm_init(); // init virtual memory management
ffffffffc0200092:	0ff030ef          	jal	ra,ffffffffc0203990 <vmm_init>
    sched_init();
ffffffffc0200096:	58a050ef          	jal	ra,ffffffffc0205620 <sched_init>
    proc_init(); // init process table
ffffffffc020009a:	5ad040ef          	jal	ra,ffffffffc0204e46 <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009e:	4a0000ef          	jal	ra,ffffffffc020053e <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc02000a2:	107000ef          	jal	ra,ffffffffc02009a8 <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a6:	739040ef          	jal	ra,ffffffffc0204fde <cpu_idle>

ffffffffc02000aa <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02000aa:	715d                	addi	sp,sp,-80
ffffffffc02000ac:	e486                	sd	ra,72(sp)
ffffffffc02000ae:	e0a6                	sd	s1,64(sp)
ffffffffc02000b0:	fc4a                	sd	s2,56(sp)
ffffffffc02000b2:	f84e                	sd	s3,48(sp)
ffffffffc02000b4:	f452                	sd	s4,40(sp)
ffffffffc02000b6:	f056                	sd	s5,32(sp)
ffffffffc02000b8:	ec5a                	sd	s6,24(sp)
ffffffffc02000ba:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc02000bc:	c901                	beqz	a0,ffffffffc02000cc <readline+0x22>
ffffffffc02000be:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc02000c0:	00006517          	auipc	a0,0x6
ffffffffc02000c4:	d2050513          	addi	a0,a0,-736 # ffffffffc0205de0 <etext+0x2c>
ffffffffc02000c8:	0d0000ef          	jal	ra,ffffffffc0200198 <cprintf>
readline(const char *prompt) {
ffffffffc02000cc:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ce:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc02000d0:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc02000d2:	4aa9                	li	s5,10
ffffffffc02000d4:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc02000d6:	000e3b97          	auipc	s7,0xe3
ffffffffc02000da:	8c2b8b93          	addi	s7,s7,-1854 # ffffffffc02e2998 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000de:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02000e2:	12e000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc02000e6:	00054a63          	bltz	a0,ffffffffc02000fa <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ea:	00a95a63          	bge	s2,a0,ffffffffc02000fe <readline+0x54>
ffffffffc02000ee:	029a5263          	bge	s4,s1,ffffffffc0200112 <readline+0x68>
        c = getchar();
ffffffffc02000f2:	11e000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc02000f6:	fe055ae3          	bgez	a0,ffffffffc02000ea <readline+0x40>
            return NULL;
ffffffffc02000fa:	4501                	li	a0,0
ffffffffc02000fc:	a091                	j	ffffffffc0200140 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02000fe:	03351463          	bne	a0,s3,ffffffffc0200126 <readline+0x7c>
ffffffffc0200102:	e8a9                	bnez	s1,ffffffffc0200154 <readline+0xaa>
        c = getchar();
ffffffffc0200104:	10c000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc0200108:	fe0549e3          	bltz	a0,ffffffffc02000fa <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc020010c:	fea959e3          	bge	s2,a0,ffffffffc02000fe <readline+0x54>
ffffffffc0200110:	4481                	li	s1,0
            cputchar(c);
ffffffffc0200112:	e42a                	sd	a0,8(sp)
ffffffffc0200114:	0ba000ef          	jal	ra,ffffffffc02001ce <cputchar>
            buf[i ++] = c;
ffffffffc0200118:	6522                	ld	a0,8(sp)
ffffffffc020011a:	009b87b3          	add	a5,s7,s1
ffffffffc020011e:	2485                	addiw	s1,s1,1
ffffffffc0200120:	00a78023          	sb	a0,0(a5)
ffffffffc0200124:	bf7d                	j	ffffffffc02000e2 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0200126:	01550463          	beq	a0,s5,ffffffffc020012e <readline+0x84>
ffffffffc020012a:	fb651ce3          	bne	a0,s6,ffffffffc02000e2 <readline+0x38>
            cputchar(c);
ffffffffc020012e:	0a0000ef          	jal	ra,ffffffffc02001ce <cputchar>
            buf[i] = '\0';
ffffffffc0200132:	000e3517          	auipc	a0,0xe3
ffffffffc0200136:	86650513          	addi	a0,a0,-1946 # ffffffffc02e2998 <buf>
ffffffffc020013a:	94aa                	add	s1,s1,a0
ffffffffc020013c:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0200140:	60a6                	ld	ra,72(sp)
ffffffffc0200142:	6486                	ld	s1,64(sp)
ffffffffc0200144:	7962                	ld	s2,56(sp)
ffffffffc0200146:	79c2                	ld	s3,48(sp)
ffffffffc0200148:	7a22                	ld	s4,40(sp)
ffffffffc020014a:	7a82                	ld	s5,32(sp)
ffffffffc020014c:	6b62                	ld	s6,24(sp)
ffffffffc020014e:	6bc2                	ld	s7,16(sp)
ffffffffc0200150:	6161                	addi	sp,sp,80
ffffffffc0200152:	8082                	ret
            cputchar(c);
ffffffffc0200154:	4521                	li	a0,8
ffffffffc0200156:	078000ef          	jal	ra,ffffffffc02001ce <cputchar>
            i --;
ffffffffc020015a:	34fd                	addiw	s1,s1,-1
ffffffffc020015c:	b759                	j	ffffffffc02000e2 <readline+0x38>

ffffffffc020015e <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc020015e:	1141                	addi	sp,sp,-16
ffffffffc0200160:	e022                	sd	s0,0(sp)
ffffffffc0200162:	e406                	sd	ra,8(sp)
ffffffffc0200164:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200166:	422000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    (*cnt)++;
ffffffffc020016a:	401c                	lw	a5,0(s0)
}
ffffffffc020016c:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc020016e:	2785                	addiw	a5,a5,1
ffffffffc0200170:	c01c                	sw	a5,0(s0)
}
ffffffffc0200172:	6402                	ld	s0,0(sp)
ffffffffc0200174:	0141                	addi	sp,sp,16
ffffffffc0200176:	8082                	ret

ffffffffc0200178 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc0200178:	1101                	addi	sp,sp,-32
ffffffffc020017a:	862a                	mv	a2,a0
ffffffffc020017c:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020017e:	00000517          	auipc	a0,0x0
ffffffffc0200182:	fe050513          	addi	a0,a0,-32 # ffffffffc020015e <cputch>
ffffffffc0200186:	006c                	addi	a1,sp,12
{
ffffffffc0200188:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc020018a:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020018c:	7da050ef          	jal	ra,ffffffffc0205966 <vprintfmt>
    return cnt;
}
ffffffffc0200190:	60e2                	ld	ra,24(sp)
ffffffffc0200192:	4532                	lw	a0,12(sp)
ffffffffc0200194:	6105                	addi	sp,sp,32
ffffffffc0200196:	8082                	ret

ffffffffc0200198 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc0200198:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc020019a:	02810313          	addi	t1,sp,40 # ffffffffc020b028 <boot_page_table_sv39+0x28>
{
ffffffffc020019e:	8e2a                	mv	t3,a0
ffffffffc02001a0:	f42e                	sd	a1,40(sp)
ffffffffc02001a2:	f832                	sd	a2,48(sp)
ffffffffc02001a4:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001a6:	00000517          	auipc	a0,0x0
ffffffffc02001aa:	fb850513          	addi	a0,a0,-72 # ffffffffc020015e <cputch>
ffffffffc02001ae:	004c                	addi	a1,sp,4
ffffffffc02001b0:	869a                	mv	a3,t1
ffffffffc02001b2:	8672                	mv	a2,t3
{
ffffffffc02001b4:	ec06                	sd	ra,24(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	e4be                	sd	a5,72(sp)
ffffffffc02001ba:	e8c2                	sd	a6,80(sp)
ffffffffc02001bc:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001be:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001c0:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001c2:	7a4050ef          	jal	ra,ffffffffc0205966 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001c6:	60e2                	ld	ra,24(sp)
ffffffffc02001c8:	4512                	lw	a0,4(sp)
ffffffffc02001ca:	6125                	addi	sp,sp,96
ffffffffc02001cc:	8082                	ret

ffffffffc02001ce <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc02001ce:	ae6d                	j	ffffffffc0200588 <cons_putc>

ffffffffc02001d0 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc02001d0:	1101                	addi	sp,sp,-32
ffffffffc02001d2:	e822                	sd	s0,16(sp)
ffffffffc02001d4:	ec06                	sd	ra,24(sp)
ffffffffc02001d6:	e426                	sd	s1,8(sp)
ffffffffc02001d8:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc02001da:	00054503          	lbu	a0,0(a0)
ffffffffc02001de:	c51d                	beqz	a0,ffffffffc020020c <cputs+0x3c>
ffffffffc02001e0:	0405                	addi	s0,s0,1
ffffffffc02001e2:	4485                	li	s1,1
ffffffffc02001e4:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001e6:	3a2000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc02001ea:	00044503          	lbu	a0,0(s0)
ffffffffc02001ee:	008487bb          	addw	a5,s1,s0
ffffffffc02001f2:	0405                	addi	s0,s0,1
ffffffffc02001f4:	f96d                	bnez	a0,ffffffffc02001e6 <cputs+0x16>
    (*cnt)++;
ffffffffc02001f6:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001fa:	4529                	li	a0,10
ffffffffc02001fc:	38c000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200200:	60e2                	ld	ra,24(sp)
ffffffffc0200202:	8522                	mv	a0,s0
ffffffffc0200204:	6442                	ld	s0,16(sp)
ffffffffc0200206:	64a2                	ld	s1,8(sp)
ffffffffc0200208:	6105                	addi	sp,sp,32
ffffffffc020020a:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc020020c:	4405                	li	s0,1
ffffffffc020020e:	b7f5                	j	ffffffffc02001fa <cputs+0x2a>

ffffffffc0200210 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc0200210:	1141                	addi	sp,sp,-16
ffffffffc0200212:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200214:	3a8000ef          	jal	ra,ffffffffc02005bc <cons_getc>
ffffffffc0200218:	dd75                	beqz	a0,ffffffffc0200214 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020021a:	60a2                	ld	ra,8(sp)
ffffffffc020021c:	0141                	addi	sp,sp,16
ffffffffc020021e:	8082                	ret

ffffffffc0200220 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc0200220:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc0200222:	00006517          	auipc	a0,0x6
ffffffffc0200226:	bc650513          	addi	a0,a0,-1082 # ffffffffc0205de8 <etext+0x34>
void print_kerninfo(void) {
ffffffffc020022a:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc020022c:	f6dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc0200230:	00000597          	auipc	a1,0x0
ffffffffc0200234:	e1a58593          	addi	a1,a1,-486 # ffffffffc020004a <kern_init>
ffffffffc0200238:	00006517          	auipc	a0,0x6
ffffffffc020023c:	bd050513          	addi	a0,a0,-1072 # ffffffffc0205e08 <etext+0x54>
ffffffffc0200240:	f59ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc0200244:	00006597          	auipc	a1,0x6
ffffffffc0200248:	b7058593          	addi	a1,a1,-1168 # ffffffffc0205db4 <etext>
ffffffffc020024c:	00006517          	auipc	a0,0x6
ffffffffc0200250:	bdc50513          	addi	a0,a0,-1060 # ffffffffc0205e28 <etext+0x74>
ffffffffc0200254:	f45ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200258:	000e2597          	auipc	a1,0xe2
ffffffffc020025c:	74058593          	addi	a1,a1,1856 # ffffffffc02e2998 <buf>
ffffffffc0200260:	00006517          	auipc	a0,0x6
ffffffffc0200264:	be850513          	addi	a0,a0,-1048 # ffffffffc0205e48 <etext+0x94>
ffffffffc0200268:	f31ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc020026c:	000e7597          	auipc	a1,0xe7
ffffffffc0200270:	c0c58593          	addi	a1,a1,-1012 # ffffffffc02e6e78 <end>
ffffffffc0200274:	00006517          	auipc	a0,0x6
ffffffffc0200278:	bf450513          	addi	a0,a0,-1036 # ffffffffc0205e68 <etext+0xb4>
ffffffffc020027c:	f1dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc0200280:	000e7597          	auipc	a1,0xe7
ffffffffc0200284:	ff758593          	addi	a1,a1,-9 # ffffffffc02e7277 <end+0x3ff>
ffffffffc0200288:	00000797          	auipc	a5,0x0
ffffffffc020028c:	dc278793          	addi	a5,a5,-574 # ffffffffc020004a <kern_init>
ffffffffc0200290:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200294:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200298:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020029a:	3ff5f593          	andi	a1,a1,1023
ffffffffc020029e:	95be                	add	a1,a1,a5
ffffffffc02002a0:	85a9                	srai	a1,a1,0xa
ffffffffc02002a2:	00006517          	auipc	a0,0x6
ffffffffc02002a6:	be650513          	addi	a0,a0,-1050 # ffffffffc0205e88 <etext+0xd4>
}
ffffffffc02002aa:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02002ac:	b5f5                	j	ffffffffc0200198 <cprintf>

ffffffffc02002ae <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc02002ae:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02002b0:	00006617          	auipc	a2,0x6
ffffffffc02002b4:	c0860613          	addi	a2,a2,-1016 # ffffffffc0205eb8 <etext+0x104>
ffffffffc02002b8:	04d00593          	li	a1,77
ffffffffc02002bc:	00006517          	auipc	a0,0x6
ffffffffc02002c0:	c1450513          	addi	a0,a0,-1004 # ffffffffc0205ed0 <etext+0x11c>
void print_stackframe(void) {
ffffffffc02002c4:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02002c6:	1cc000ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02002ca <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002ca:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002cc:	00006617          	auipc	a2,0x6
ffffffffc02002d0:	c1c60613          	addi	a2,a2,-996 # ffffffffc0205ee8 <etext+0x134>
ffffffffc02002d4:	00006597          	auipc	a1,0x6
ffffffffc02002d8:	c3458593          	addi	a1,a1,-972 # ffffffffc0205f08 <etext+0x154>
ffffffffc02002dc:	00006517          	auipc	a0,0x6
ffffffffc02002e0:	c3450513          	addi	a0,a0,-972 # ffffffffc0205f10 <etext+0x15c>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002e4:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002e6:	eb3ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc02002ea:	00006617          	auipc	a2,0x6
ffffffffc02002ee:	c3660613          	addi	a2,a2,-970 # ffffffffc0205f20 <etext+0x16c>
ffffffffc02002f2:	00006597          	auipc	a1,0x6
ffffffffc02002f6:	c5658593          	addi	a1,a1,-938 # ffffffffc0205f48 <etext+0x194>
ffffffffc02002fa:	00006517          	auipc	a0,0x6
ffffffffc02002fe:	c1650513          	addi	a0,a0,-1002 # ffffffffc0205f10 <etext+0x15c>
ffffffffc0200302:	e97ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0200306:	00006617          	auipc	a2,0x6
ffffffffc020030a:	c5260613          	addi	a2,a2,-942 # ffffffffc0205f58 <etext+0x1a4>
ffffffffc020030e:	00006597          	auipc	a1,0x6
ffffffffc0200312:	c6a58593          	addi	a1,a1,-918 # ffffffffc0205f78 <etext+0x1c4>
ffffffffc0200316:	00006517          	auipc	a0,0x6
ffffffffc020031a:	bfa50513          	addi	a0,a0,-1030 # ffffffffc0205f10 <etext+0x15c>
ffffffffc020031e:	e7bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    }
    return 0;
}
ffffffffc0200322:	60a2                	ld	ra,8(sp)
ffffffffc0200324:	4501                	li	a0,0
ffffffffc0200326:	0141                	addi	sp,sp,16
ffffffffc0200328:	8082                	ret

ffffffffc020032a <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc020032a:	1141                	addi	sp,sp,-16
ffffffffc020032c:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020032e:	ef3ff0ef          	jal	ra,ffffffffc0200220 <print_kerninfo>
    return 0;
}
ffffffffc0200332:	60a2                	ld	ra,8(sp)
ffffffffc0200334:	4501                	li	a0,0
ffffffffc0200336:	0141                	addi	sp,sp,16
ffffffffc0200338:	8082                	ret

ffffffffc020033a <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc020033a:	1141                	addi	sp,sp,-16
ffffffffc020033c:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020033e:	f71ff0ef          	jal	ra,ffffffffc02002ae <print_stackframe>
    return 0;
}
ffffffffc0200342:	60a2                	ld	ra,8(sp)
ffffffffc0200344:	4501                	li	a0,0
ffffffffc0200346:	0141                	addi	sp,sp,16
ffffffffc0200348:	8082                	ret

ffffffffc020034a <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc020034a:	7115                	addi	sp,sp,-224
ffffffffc020034c:	ed5e                	sd	s7,152(sp)
ffffffffc020034e:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200350:	00006517          	auipc	a0,0x6
ffffffffc0200354:	c3850513          	addi	a0,a0,-968 # ffffffffc0205f88 <etext+0x1d4>
kmonitor(struct trapframe *tf) {
ffffffffc0200358:	ed86                	sd	ra,216(sp)
ffffffffc020035a:	e9a2                	sd	s0,208(sp)
ffffffffc020035c:	e5a6                	sd	s1,200(sp)
ffffffffc020035e:	e1ca                	sd	s2,192(sp)
ffffffffc0200360:	fd4e                	sd	s3,184(sp)
ffffffffc0200362:	f952                	sd	s4,176(sp)
ffffffffc0200364:	f556                	sd	s5,168(sp)
ffffffffc0200366:	f15a                	sd	s6,160(sp)
ffffffffc0200368:	e962                	sd	s8,144(sp)
ffffffffc020036a:	e566                	sd	s9,136(sp)
ffffffffc020036c:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020036e:	e2bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc0200372:	00006517          	auipc	a0,0x6
ffffffffc0200376:	c3e50513          	addi	a0,a0,-962 # ffffffffc0205fb0 <etext+0x1fc>
ffffffffc020037a:	e1fff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    if (tf != NULL) {
ffffffffc020037e:	000b8563          	beqz	s7,ffffffffc0200388 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc0200382:	855e                	mv	a0,s7
ffffffffc0200384:	01b000ef          	jal	ra,ffffffffc0200b9e <print_trapframe>
ffffffffc0200388:	00006c17          	auipc	s8,0x6
ffffffffc020038c:	c98c0c13          	addi	s8,s8,-872 # ffffffffc0206020 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200390:	00006917          	auipc	s2,0x6
ffffffffc0200394:	c4890913          	addi	s2,s2,-952 # ffffffffc0205fd8 <etext+0x224>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200398:	00006497          	auipc	s1,0x6
ffffffffc020039c:	c4848493          	addi	s1,s1,-952 # ffffffffc0205fe0 <etext+0x22c>
        if (argc == MAXARGS - 1) {
ffffffffc02003a0:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003a2:	00006b17          	auipc	s6,0x6
ffffffffc02003a6:	c46b0b13          	addi	s6,s6,-954 # ffffffffc0205fe8 <etext+0x234>
        argv[argc ++] = buf;
ffffffffc02003aa:	00006a17          	auipc	s4,0x6
ffffffffc02003ae:	b5ea0a13          	addi	s4,s4,-1186 # ffffffffc0205f08 <etext+0x154>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003b2:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02003b4:	854a                	mv	a0,s2
ffffffffc02003b6:	cf5ff0ef          	jal	ra,ffffffffc02000aa <readline>
ffffffffc02003ba:	842a                	mv	s0,a0
ffffffffc02003bc:	dd65                	beqz	a0,ffffffffc02003b4 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003be:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02003c2:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003c4:	e1bd                	bnez	a1,ffffffffc020042a <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc02003c6:	fe0c87e3          	beqz	s9,ffffffffc02003b4 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003ca:	6582                	ld	a1,0(sp)
ffffffffc02003cc:	00006d17          	auipc	s10,0x6
ffffffffc02003d0:	c54d0d13          	addi	s10,s10,-940 # ffffffffc0206020 <commands>
        argv[argc ++] = buf;
ffffffffc02003d4:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003d6:	4401                	li	s0,0
ffffffffc02003d8:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003da:	157050ef          	jal	ra,ffffffffc0205d30 <strcmp>
ffffffffc02003de:	c919                	beqz	a0,ffffffffc02003f4 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003e0:	2405                	addiw	s0,s0,1
ffffffffc02003e2:	0b540063          	beq	s0,s5,ffffffffc0200482 <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003e6:	000d3503          	ld	a0,0(s10)
ffffffffc02003ea:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003ec:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003ee:	143050ef          	jal	ra,ffffffffc0205d30 <strcmp>
ffffffffc02003f2:	f57d                	bnez	a0,ffffffffc02003e0 <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc02003f4:	00141793          	slli	a5,s0,0x1
ffffffffc02003f8:	97a2                	add	a5,a5,s0
ffffffffc02003fa:	078e                	slli	a5,a5,0x3
ffffffffc02003fc:	97e2                	add	a5,a5,s8
ffffffffc02003fe:	6b9c                	ld	a5,16(a5)
ffffffffc0200400:	865e                	mv	a2,s7
ffffffffc0200402:	002c                	addi	a1,sp,8
ffffffffc0200404:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200408:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc020040a:	fa0555e3          	bgez	a0,ffffffffc02003b4 <kmonitor+0x6a>
}
ffffffffc020040e:	60ee                	ld	ra,216(sp)
ffffffffc0200410:	644e                	ld	s0,208(sp)
ffffffffc0200412:	64ae                	ld	s1,200(sp)
ffffffffc0200414:	690e                	ld	s2,192(sp)
ffffffffc0200416:	79ea                	ld	s3,184(sp)
ffffffffc0200418:	7a4a                	ld	s4,176(sp)
ffffffffc020041a:	7aaa                	ld	s5,168(sp)
ffffffffc020041c:	7b0a                	ld	s6,160(sp)
ffffffffc020041e:	6bea                	ld	s7,152(sp)
ffffffffc0200420:	6c4a                	ld	s8,144(sp)
ffffffffc0200422:	6caa                	ld	s9,136(sp)
ffffffffc0200424:	6d0a                	ld	s10,128(sp)
ffffffffc0200426:	612d                	addi	sp,sp,224
ffffffffc0200428:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020042a:	8526                	mv	a0,s1
ffffffffc020042c:	149050ef          	jal	ra,ffffffffc0205d74 <strchr>
ffffffffc0200430:	c901                	beqz	a0,ffffffffc0200440 <kmonitor+0xf6>
ffffffffc0200432:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc0200436:	00040023          	sb	zero,0(s0)
ffffffffc020043a:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020043c:	d5c9                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc020043e:	b7f5                	j	ffffffffc020042a <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc0200440:	00044783          	lbu	a5,0(s0)
ffffffffc0200444:	d3c9                	beqz	a5,ffffffffc02003c6 <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc0200446:	033c8963          	beq	s9,s3,ffffffffc0200478 <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc020044a:	003c9793          	slli	a5,s9,0x3
ffffffffc020044e:	0118                	addi	a4,sp,128
ffffffffc0200450:	97ba                	add	a5,a5,a4
ffffffffc0200452:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200456:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc020045a:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc020045c:	e591                	bnez	a1,ffffffffc0200468 <kmonitor+0x11e>
ffffffffc020045e:	b7b5                	j	ffffffffc02003ca <kmonitor+0x80>
ffffffffc0200460:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc0200464:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200466:	d1a5                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc0200468:	8526                	mv	a0,s1
ffffffffc020046a:	10b050ef          	jal	ra,ffffffffc0205d74 <strchr>
ffffffffc020046e:	d96d                	beqz	a0,ffffffffc0200460 <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200470:	00044583          	lbu	a1,0(s0)
ffffffffc0200474:	d9a9                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc0200476:	bf55                	j	ffffffffc020042a <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200478:	45c1                	li	a1,16
ffffffffc020047a:	855a                	mv	a0,s6
ffffffffc020047c:	d1dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0200480:	b7e9                	j	ffffffffc020044a <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc0200482:	6582                	ld	a1,0(sp)
ffffffffc0200484:	00006517          	auipc	a0,0x6
ffffffffc0200488:	b8450513          	addi	a0,a0,-1148 # ffffffffc0206008 <etext+0x254>
ffffffffc020048c:	d0dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return 0;
ffffffffc0200490:	b715                	j	ffffffffc02003b4 <kmonitor+0x6a>

ffffffffc0200492 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200492:	000e7317          	auipc	t1,0xe7
ffffffffc0200496:	95e30313          	addi	t1,t1,-1698 # ffffffffc02e6df0 <is_panic>
ffffffffc020049a:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc020049e:	715d                	addi	sp,sp,-80
ffffffffc02004a0:	ec06                	sd	ra,24(sp)
ffffffffc02004a2:	e822                	sd	s0,16(sp)
ffffffffc02004a4:	f436                	sd	a3,40(sp)
ffffffffc02004a6:	f83a                	sd	a4,48(sp)
ffffffffc02004a8:	fc3e                	sd	a5,56(sp)
ffffffffc02004aa:	e0c2                	sd	a6,64(sp)
ffffffffc02004ac:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02004ae:	020e1a63          	bnez	t3,ffffffffc02004e2 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02004b2:	4785                	li	a5,1
ffffffffc02004b4:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02004b8:	8432                	mv	s0,a2
ffffffffc02004ba:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004bc:	862e                	mv	a2,a1
ffffffffc02004be:	85aa                	mv	a1,a0
ffffffffc02004c0:	00006517          	auipc	a0,0x6
ffffffffc02004c4:	ba850513          	addi	a0,a0,-1112 # ffffffffc0206068 <commands+0x48>
    va_start(ap, fmt);
ffffffffc02004c8:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004ca:	ccfff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02004ce:	65a2                	ld	a1,8(sp)
ffffffffc02004d0:	8522                	mv	a0,s0
ffffffffc02004d2:	ca7ff0ef          	jal	ra,ffffffffc0200178 <vcprintf>
    cprintf("\n");
ffffffffc02004d6:	00007517          	auipc	a0,0x7
ffffffffc02004da:	cc250513          	addi	a0,a0,-830 # ffffffffc0207198 <default_pmm_manager+0x578>
ffffffffc02004de:	cbbff0ef          	jal	ra,ffffffffc0200198 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc02004e2:	4501                	li	a0,0
ffffffffc02004e4:	4581                	li	a1,0
ffffffffc02004e6:	4601                	li	a2,0
ffffffffc02004e8:	48a1                	li	a7,8
ffffffffc02004ea:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc02004ee:	4c0000ef          	jal	ra,ffffffffc02009ae <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc02004f2:	4501                	li	a0,0
ffffffffc02004f4:	e57ff0ef          	jal	ra,ffffffffc020034a <kmonitor>
    while (1) {
ffffffffc02004f8:	bfed                	j	ffffffffc02004f2 <__panic+0x60>

ffffffffc02004fa <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc02004fa:	715d                	addi	sp,sp,-80
ffffffffc02004fc:	832e                	mv	t1,a1
ffffffffc02004fe:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200500:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200502:	8432                	mv	s0,a2
ffffffffc0200504:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200506:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200508:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020050a:	00006517          	auipc	a0,0x6
ffffffffc020050e:	b7e50513          	addi	a0,a0,-1154 # ffffffffc0206088 <commands+0x68>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200512:	ec06                	sd	ra,24(sp)
ffffffffc0200514:	f436                	sd	a3,40(sp)
ffffffffc0200516:	f83a                	sd	a4,48(sp)
ffffffffc0200518:	e0c2                	sd	a6,64(sp)
ffffffffc020051a:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020051c:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020051e:	c7bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200522:	65a2                	ld	a1,8(sp)
ffffffffc0200524:	8522                	mv	a0,s0
ffffffffc0200526:	c53ff0ef          	jal	ra,ffffffffc0200178 <vcprintf>
    cprintf("\n");
ffffffffc020052a:	00007517          	auipc	a0,0x7
ffffffffc020052e:	c6e50513          	addi	a0,a0,-914 # ffffffffc0207198 <default_pmm_manager+0x578>
ffffffffc0200532:	c67ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    va_end(ap);
}
ffffffffc0200536:	60e2                	ld	ra,24(sp)
ffffffffc0200538:	6442                	ld	s0,16(sp)
ffffffffc020053a:	6161                	addi	sp,sp,80
ffffffffc020053c:	8082                	ret

ffffffffc020053e <clock_init>:
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void)
{
    set_csr(sie, MIP_STIP);
ffffffffc020053e:	02000793          	li	a5,32
ffffffffc0200542:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200546:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020054a:	67e1                	lui	a5,0x18
ffffffffc020054c:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_matrix_out_size+0xbf68>
ffffffffc0200550:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc0200552:	4581                	li	a1,0
ffffffffc0200554:	4601                	li	a2,0
ffffffffc0200556:	4881                	li	a7,0
ffffffffc0200558:	00000073          	ecall
    cprintf("++ setup timer interrupts\n");
ffffffffc020055c:	00006517          	auipc	a0,0x6
ffffffffc0200560:	b4c50513          	addi	a0,a0,-1204 # ffffffffc02060a8 <commands+0x88>
    ticks = 0;
ffffffffc0200564:	000e7797          	auipc	a5,0xe7
ffffffffc0200568:	8807ba23          	sd	zero,-1900(a5) # ffffffffc02e6df8 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc020056c:	b135                	j	ffffffffc0200198 <cprintf>

ffffffffc020056e <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020056e:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200572:	67e1                	lui	a5,0x18
ffffffffc0200574:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_matrix_out_size+0xbf68>
ffffffffc0200578:	953e                	add	a0,a0,a5
ffffffffc020057a:	4581                	li	a1,0
ffffffffc020057c:	4601                	li	a2,0
ffffffffc020057e:	4881                	li	a7,0
ffffffffc0200580:	00000073          	ecall
ffffffffc0200584:	8082                	ret

ffffffffc0200586 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200586:	8082                	ret

ffffffffc0200588 <cons_putc>:
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0200588:	100027f3          	csrr	a5,sstatus
ffffffffc020058c:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc020058e:	0ff57513          	zext.b	a0,a0
ffffffffc0200592:	e799                	bnez	a5,ffffffffc02005a0 <cons_putc+0x18>
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4885                	li	a7,1
ffffffffc020059a:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc020059e:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005a6:	408000ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02005aa:	6522                	ld	a0,8(sp)
ffffffffc02005ac:	4581                	li	a1,0
ffffffffc02005ae:	4601                	li	a2,0
ffffffffc02005b0:	4885                	li	a7,1
ffffffffc02005b2:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005b6:	60e2                	ld	ra,24(sp)
ffffffffc02005b8:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc02005ba:	a6fd                	j	ffffffffc02009a8 <intr_enable>

ffffffffc02005bc <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	eb89                	bnez	a5,ffffffffc02005d4 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005c4:	4501                	li	a0,0
ffffffffc02005c6:	4581                	li	a1,0
ffffffffc02005c8:	4601                	li	a2,0
ffffffffc02005ca:	4889                	li	a7,2
ffffffffc02005cc:	00000073          	ecall
ffffffffc02005d0:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d2:	8082                	ret
int cons_getc(void) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005d8:	3d6000ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02005dc:	4501                	li	a0,0
ffffffffc02005de:	4581                	li	a1,0
ffffffffc02005e0:	4601                	li	a2,0
ffffffffc02005e2:	4889                	li	a7,2
ffffffffc02005e4:	00000073          	ecall
ffffffffc02005e8:	2501                	sext.w	a0,a0
ffffffffc02005ea:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005ec:	3bc000ef          	jal	ra,ffffffffc02009a8 <intr_enable>
}
ffffffffc02005f0:	60e2                	ld	ra,24(sp)
ffffffffc02005f2:	6522                	ld	a0,8(sp)
ffffffffc02005f4:	6105                	addi	sp,sp,32
ffffffffc02005f6:	8082                	ret

ffffffffc02005f8 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02005f8:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc02005fa:	00006517          	auipc	a0,0x6
ffffffffc02005fe:	ace50513          	addi	a0,a0,-1330 # ffffffffc02060c8 <commands+0xa8>
void dtb_init(void) {
ffffffffc0200602:	fc86                	sd	ra,120(sp)
ffffffffc0200604:	f8a2                	sd	s0,112(sp)
ffffffffc0200606:	e8d2                	sd	s4,80(sp)
ffffffffc0200608:	f4a6                	sd	s1,104(sp)
ffffffffc020060a:	f0ca                	sd	s2,96(sp)
ffffffffc020060c:	ecce                	sd	s3,88(sp)
ffffffffc020060e:	e4d6                	sd	s5,72(sp)
ffffffffc0200610:	e0da                	sd	s6,64(sp)
ffffffffc0200612:	fc5e                	sd	s7,56(sp)
ffffffffc0200614:	f862                	sd	s8,48(sp)
ffffffffc0200616:	f466                	sd	s9,40(sp)
ffffffffc0200618:	f06a                	sd	s10,32(sp)
ffffffffc020061a:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc020061c:	b7dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200620:	0000c597          	auipc	a1,0xc
ffffffffc0200624:	9e05b583          	ld	a1,-1568(a1) # ffffffffc020c000 <boot_hartid>
ffffffffc0200628:	00006517          	auipc	a0,0x6
ffffffffc020062c:	ab050513          	addi	a0,a0,-1360 # ffffffffc02060d8 <commands+0xb8>
ffffffffc0200630:	b69ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc0200634:	0000c417          	auipc	s0,0xc
ffffffffc0200638:	9d440413          	addi	s0,s0,-1580 # ffffffffc020c008 <boot_dtb>
ffffffffc020063c:	600c                	ld	a1,0(s0)
ffffffffc020063e:	00006517          	auipc	a0,0x6
ffffffffc0200642:	aaa50513          	addi	a0,a0,-1366 # ffffffffc02060e8 <commands+0xc8>
ffffffffc0200646:	b53ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc020064a:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc020064e:	00006517          	auipc	a0,0x6
ffffffffc0200652:	ab250513          	addi	a0,a0,-1358 # ffffffffc0206100 <commands+0xe0>
    if (boot_dtb == 0) {
ffffffffc0200656:	120a0463          	beqz	s4,ffffffffc020077e <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc020065a:	57f5                	li	a5,-3
ffffffffc020065c:	07fa                	slli	a5,a5,0x1e
ffffffffc020065e:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200662:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200664:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200668:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020066e:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200672:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200676:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020067a:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067e:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200680:	8ec9                	or	a3,a3,a0
ffffffffc0200682:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200686:	1b7d                	addi	s6,s6,-1
ffffffffc0200688:	0167f7b3          	and	a5,a5,s6
ffffffffc020068c:	8dd5                	or	a1,a1,a3
ffffffffc020068e:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200690:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200694:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc0200696:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfdf9075>
ffffffffc020069a:	10f59163          	bne	a1,a5,ffffffffc020079c <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc020069e:	471c                	lw	a5,8(a4)
ffffffffc02006a0:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02006a2:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006a4:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02006a8:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02006ac:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b0:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006b4:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b8:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006bc:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c0:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c4:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c8:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006cc:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ce:	01146433          	or	s0,s0,a7
ffffffffc02006d2:	0086969b          	slliw	a3,a3,0x8
ffffffffc02006d6:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006da:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006dc:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e0:	8c49                	or	s0,s0,a0
ffffffffc02006e2:	0166f6b3          	and	a3,a3,s6
ffffffffc02006e6:	00ca6a33          	or	s4,s4,a2
ffffffffc02006ea:	0167f7b3          	and	a5,a5,s6
ffffffffc02006ee:	8c55                	or	s0,s0,a3
ffffffffc02006f0:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006f4:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006f6:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006f8:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006fa:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fe:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200700:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200702:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc0200706:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200708:	00006917          	auipc	s2,0x6
ffffffffc020070c:	a4890913          	addi	s2,s2,-1464 # ffffffffc0206150 <commands+0x130>
ffffffffc0200710:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200712:	4d91                	li	s11,4
ffffffffc0200714:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200716:	00006497          	auipc	s1,0x6
ffffffffc020071a:	a3248493          	addi	s1,s1,-1486 # ffffffffc0206148 <commands+0x128>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc020071e:	000a2703          	lw	a4,0(s4)
ffffffffc0200722:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200726:	0087569b          	srliw	a3,a4,0x8
ffffffffc020072a:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020072e:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200732:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200736:	0107571b          	srliw	a4,a4,0x10
ffffffffc020073a:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020073c:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200740:	0087171b          	slliw	a4,a4,0x8
ffffffffc0200744:	8fd5                	or	a5,a5,a3
ffffffffc0200746:	00eb7733          	and	a4,s6,a4
ffffffffc020074a:	8fd9                	or	a5,a5,a4
ffffffffc020074c:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc020074e:	09778c63          	beq	a5,s7,ffffffffc02007e6 <dtb_init+0x1ee>
ffffffffc0200752:	00fbea63          	bltu	s7,a5,ffffffffc0200766 <dtb_init+0x16e>
ffffffffc0200756:	07a78663          	beq	a5,s10,ffffffffc02007c2 <dtb_init+0x1ca>
ffffffffc020075a:	4709                	li	a4,2
ffffffffc020075c:	00e79763          	bne	a5,a4,ffffffffc020076a <dtb_init+0x172>
ffffffffc0200760:	4c81                	li	s9,0
ffffffffc0200762:	8a56                	mv	s4,s5
ffffffffc0200764:	bf6d                	j	ffffffffc020071e <dtb_init+0x126>
ffffffffc0200766:	ffb78ee3          	beq	a5,s11,ffffffffc0200762 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc020076a:	00006517          	auipc	a0,0x6
ffffffffc020076e:	a5e50513          	addi	a0,a0,-1442 # ffffffffc02061c8 <commands+0x1a8>
ffffffffc0200772:	a27ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc0200776:	00006517          	auipc	a0,0x6
ffffffffc020077a:	a8a50513          	addi	a0,a0,-1398 # ffffffffc0206200 <commands+0x1e0>
}
ffffffffc020077e:	7446                	ld	s0,112(sp)
ffffffffc0200780:	70e6                	ld	ra,120(sp)
ffffffffc0200782:	74a6                	ld	s1,104(sp)
ffffffffc0200784:	7906                	ld	s2,96(sp)
ffffffffc0200786:	69e6                	ld	s3,88(sp)
ffffffffc0200788:	6a46                	ld	s4,80(sp)
ffffffffc020078a:	6aa6                	ld	s5,72(sp)
ffffffffc020078c:	6b06                	ld	s6,64(sp)
ffffffffc020078e:	7be2                	ld	s7,56(sp)
ffffffffc0200790:	7c42                	ld	s8,48(sp)
ffffffffc0200792:	7ca2                	ld	s9,40(sp)
ffffffffc0200794:	7d02                	ld	s10,32(sp)
ffffffffc0200796:	6de2                	ld	s11,24(sp)
ffffffffc0200798:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc020079a:	bafd                	j	ffffffffc0200198 <cprintf>
}
ffffffffc020079c:	7446                	ld	s0,112(sp)
ffffffffc020079e:	70e6                	ld	ra,120(sp)
ffffffffc02007a0:	74a6                	ld	s1,104(sp)
ffffffffc02007a2:	7906                	ld	s2,96(sp)
ffffffffc02007a4:	69e6                	ld	s3,88(sp)
ffffffffc02007a6:	6a46                	ld	s4,80(sp)
ffffffffc02007a8:	6aa6                	ld	s5,72(sp)
ffffffffc02007aa:	6b06                	ld	s6,64(sp)
ffffffffc02007ac:	7be2                	ld	s7,56(sp)
ffffffffc02007ae:	7c42                	ld	s8,48(sp)
ffffffffc02007b0:	7ca2                	ld	s9,40(sp)
ffffffffc02007b2:	7d02                	ld	s10,32(sp)
ffffffffc02007b4:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007b6:	00006517          	auipc	a0,0x6
ffffffffc02007ba:	96a50513          	addi	a0,a0,-1686 # ffffffffc0206120 <commands+0x100>
}
ffffffffc02007be:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007c0:	bae1                	j	ffffffffc0200198 <cprintf>
                int name_len = strlen(name);
ffffffffc02007c2:	8556                	mv	a0,s5
ffffffffc02007c4:	524050ef          	jal	ra,ffffffffc0205ce8 <strlen>
ffffffffc02007c8:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007ca:	4619                	li	a2,6
ffffffffc02007cc:	85a6                	mv	a1,s1
ffffffffc02007ce:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02007d0:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d2:	57c050ef          	jal	ra,ffffffffc0205d4e <strncmp>
ffffffffc02007d6:	e111                	bnez	a0,ffffffffc02007da <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc02007d8:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc02007da:	0a91                	addi	s5,s5,4
ffffffffc02007dc:	9ad2                	add	s5,s5,s4
ffffffffc02007de:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02007e2:	8a56                	mv	s4,s5
ffffffffc02007e4:	bf2d                	j	ffffffffc020071e <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007e6:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007ea:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007ee:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02007f2:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007f6:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007fa:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007fe:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200802:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200806:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020080a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020080e:	00eaeab3          	or	s5,s5,a4
ffffffffc0200812:	00fb77b3          	and	a5,s6,a5
ffffffffc0200816:	00faeab3          	or	s5,s5,a5
ffffffffc020081a:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020081c:	000c9c63          	bnez	s9,ffffffffc0200834 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200820:	1a82                	slli	s5,s5,0x20
ffffffffc0200822:	00368793          	addi	a5,a3,3
ffffffffc0200826:	020ada93          	srli	s5,s5,0x20
ffffffffc020082a:	9abe                	add	s5,s5,a5
ffffffffc020082c:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200830:	8a56                	mv	s4,s5
ffffffffc0200832:	b5f5                	j	ffffffffc020071e <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200834:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200838:	85ca                	mv	a1,s2
ffffffffc020083a:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020083c:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200840:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200844:	0187971b          	slliw	a4,a5,0x18
ffffffffc0200848:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020084c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200850:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200852:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200856:	0087979b          	slliw	a5,a5,0x8
ffffffffc020085a:	8d59                	or	a0,a0,a4
ffffffffc020085c:	00fb77b3          	and	a5,s6,a5
ffffffffc0200860:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200862:	1502                	slli	a0,a0,0x20
ffffffffc0200864:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200866:	9522                	add	a0,a0,s0
ffffffffc0200868:	4c8050ef          	jal	ra,ffffffffc0205d30 <strcmp>
ffffffffc020086c:	66a2                	ld	a3,8(sp)
ffffffffc020086e:	f94d                	bnez	a0,ffffffffc0200820 <dtb_init+0x228>
ffffffffc0200870:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200820 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc0200874:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc0200878:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc020087c:	00006517          	auipc	a0,0x6
ffffffffc0200880:	8dc50513          	addi	a0,a0,-1828 # ffffffffc0206158 <commands+0x138>
           fdt32_to_cpu(x >> 32);
ffffffffc0200884:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200888:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc020088c:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200890:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200894:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200898:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020089c:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008a0:	0187d693          	srli	a3,a5,0x18
ffffffffc02008a4:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02008a8:	0087579b          	srliw	a5,a4,0x8
ffffffffc02008ac:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008b0:	0106561b          	srliw	a2,a2,0x10
ffffffffc02008b4:	010f6f33          	or	t5,t5,a6
ffffffffc02008b8:	0187529b          	srliw	t0,a4,0x18
ffffffffc02008bc:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c0:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008c4:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c8:	0186f6b3          	and	a3,a3,s8
ffffffffc02008cc:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02008d0:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008d4:	0107581b          	srliw	a6,a4,0x10
ffffffffc02008d8:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008dc:	8361                	srli	a4,a4,0x18
ffffffffc02008de:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008e2:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02008e6:	01e6e6b3          	or	a3,a3,t5
ffffffffc02008ea:	00cb7633          	and	a2,s6,a2
ffffffffc02008ee:	0088181b          	slliw	a6,a6,0x8
ffffffffc02008f2:	0085959b          	slliw	a1,a1,0x8
ffffffffc02008f6:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008fa:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008fe:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200902:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200906:	0088989b          	slliw	a7,a7,0x8
ffffffffc020090a:	011b78b3          	and	a7,s6,a7
ffffffffc020090e:	005eeeb3          	or	t4,t4,t0
ffffffffc0200912:	00c6e733          	or	a4,a3,a2
ffffffffc0200916:	006c6c33          	or	s8,s8,t1
ffffffffc020091a:	010b76b3          	and	a3,s6,a6
ffffffffc020091e:	00bb7b33          	and	s6,s6,a1
ffffffffc0200922:	01d7e7b3          	or	a5,a5,t4
ffffffffc0200926:	016c6b33          	or	s6,s8,s6
ffffffffc020092a:	01146433          	or	s0,s0,a7
ffffffffc020092e:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200930:	1702                	slli	a4,a4,0x20
ffffffffc0200932:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200934:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200936:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200938:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020093a:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093e:	0167eb33          	or	s6,a5,s6
ffffffffc0200942:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200944:	855ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc0200948:	85a2                	mv	a1,s0
ffffffffc020094a:	00006517          	auipc	a0,0x6
ffffffffc020094e:	82e50513          	addi	a0,a0,-2002 # ffffffffc0206178 <commands+0x158>
ffffffffc0200952:	847ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc0200956:	014b5613          	srli	a2,s6,0x14
ffffffffc020095a:	85da                	mv	a1,s6
ffffffffc020095c:	00006517          	auipc	a0,0x6
ffffffffc0200960:	83450513          	addi	a0,a0,-1996 # ffffffffc0206190 <commands+0x170>
ffffffffc0200964:	835ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200968:	008b05b3          	add	a1,s6,s0
ffffffffc020096c:	15fd                	addi	a1,a1,-1
ffffffffc020096e:	00006517          	auipc	a0,0x6
ffffffffc0200972:	84250513          	addi	a0,a0,-1982 # ffffffffc02061b0 <commands+0x190>
ffffffffc0200976:	823ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc020097a:	00006517          	auipc	a0,0x6
ffffffffc020097e:	88650513          	addi	a0,a0,-1914 # ffffffffc0206200 <commands+0x1e0>
        memory_base = mem_base;
ffffffffc0200982:	000e6797          	auipc	a5,0xe6
ffffffffc0200986:	4687bf23          	sd	s0,1150(a5) # ffffffffc02e6e00 <memory_base>
        memory_size = mem_size;
ffffffffc020098a:	000e6797          	auipc	a5,0xe6
ffffffffc020098e:	4767bf23          	sd	s6,1150(a5) # ffffffffc02e6e08 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200992:	b3f5                	j	ffffffffc020077e <dtb_init+0x186>

ffffffffc0200994 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc0200994:	000e6517          	auipc	a0,0xe6
ffffffffc0200998:	46c53503          	ld	a0,1132(a0) # ffffffffc02e6e00 <memory_base>
ffffffffc020099c:	8082                	ret

ffffffffc020099e <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc020099e:	000e6517          	auipc	a0,0xe6
ffffffffc02009a2:	46a53503          	ld	a0,1130(a0) # ffffffffc02e6e08 <memory_size>
ffffffffc02009a6:	8082                	ret

ffffffffc02009a8 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009a8:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009ac:	8082                	ret

ffffffffc02009ae <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ae:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009b4:	8082                	ret

ffffffffc02009b6 <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009b6:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009ba:	00000797          	auipc	a5,0x0
ffffffffc02009be:	48278793          	addi	a5,a5,1154 # ffffffffc0200e3c <__alltraps>
ffffffffc02009c2:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009c6:	000407b7          	lui	a5,0x40
ffffffffc02009ca:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009ce:	8082                	ret

ffffffffc02009d0 <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d0:	610c                	ld	a1,0(a0)
{
ffffffffc02009d2:	1141                	addi	sp,sp,-16
ffffffffc02009d4:	e022                	sd	s0,0(sp)
ffffffffc02009d6:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d8:	00006517          	auipc	a0,0x6
ffffffffc02009dc:	84050513          	addi	a0,a0,-1984 # ffffffffc0206218 <commands+0x1f8>
{
ffffffffc02009e0:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e2:	fb6ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009e6:	640c                	ld	a1,8(s0)
ffffffffc02009e8:	00006517          	auipc	a0,0x6
ffffffffc02009ec:	84850513          	addi	a0,a0,-1976 # ffffffffc0206230 <commands+0x210>
ffffffffc02009f0:	fa8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009f4:	680c                	ld	a1,16(s0)
ffffffffc02009f6:	00006517          	auipc	a0,0x6
ffffffffc02009fa:	85250513          	addi	a0,a0,-1966 # ffffffffc0206248 <commands+0x228>
ffffffffc02009fe:	f9aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a02:	6c0c                	ld	a1,24(s0)
ffffffffc0200a04:	00006517          	auipc	a0,0x6
ffffffffc0200a08:	85c50513          	addi	a0,a0,-1956 # ffffffffc0206260 <commands+0x240>
ffffffffc0200a0c:	f8cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a10:	700c                	ld	a1,32(s0)
ffffffffc0200a12:	00006517          	auipc	a0,0x6
ffffffffc0200a16:	86650513          	addi	a0,a0,-1946 # ffffffffc0206278 <commands+0x258>
ffffffffc0200a1a:	f7eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a1e:	740c                	ld	a1,40(s0)
ffffffffc0200a20:	00006517          	auipc	a0,0x6
ffffffffc0200a24:	87050513          	addi	a0,a0,-1936 # ffffffffc0206290 <commands+0x270>
ffffffffc0200a28:	f70ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a2c:	780c                	ld	a1,48(s0)
ffffffffc0200a2e:	00006517          	auipc	a0,0x6
ffffffffc0200a32:	87a50513          	addi	a0,a0,-1926 # ffffffffc02062a8 <commands+0x288>
ffffffffc0200a36:	f62ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a3a:	7c0c                	ld	a1,56(s0)
ffffffffc0200a3c:	00006517          	auipc	a0,0x6
ffffffffc0200a40:	88450513          	addi	a0,a0,-1916 # ffffffffc02062c0 <commands+0x2a0>
ffffffffc0200a44:	f54ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a48:	602c                	ld	a1,64(s0)
ffffffffc0200a4a:	00006517          	auipc	a0,0x6
ffffffffc0200a4e:	88e50513          	addi	a0,a0,-1906 # ffffffffc02062d8 <commands+0x2b8>
ffffffffc0200a52:	f46ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a56:	642c                	ld	a1,72(s0)
ffffffffc0200a58:	00006517          	auipc	a0,0x6
ffffffffc0200a5c:	89850513          	addi	a0,a0,-1896 # ffffffffc02062f0 <commands+0x2d0>
ffffffffc0200a60:	f38ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a64:	682c                	ld	a1,80(s0)
ffffffffc0200a66:	00006517          	auipc	a0,0x6
ffffffffc0200a6a:	8a250513          	addi	a0,a0,-1886 # ffffffffc0206308 <commands+0x2e8>
ffffffffc0200a6e:	f2aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a72:	6c2c                	ld	a1,88(s0)
ffffffffc0200a74:	00006517          	auipc	a0,0x6
ffffffffc0200a78:	8ac50513          	addi	a0,a0,-1876 # ffffffffc0206320 <commands+0x300>
ffffffffc0200a7c:	f1cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a80:	702c                	ld	a1,96(s0)
ffffffffc0200a82:	00006517          	auipc	a0,0x6
ffffffffc0200a86:	8b650513          	addi	a0,a0,-1866 # ffffffffc0206338 <commands+0x318>
ffffffffc0200a8a:	f0eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a8e:	742c                	ld	a1,104(s0)
ffffffffc0200a90:	00006517          	auipc	a0,0x6
ffffffffc0200a94:	8c050513          	addi	a0,a0,-1856 # ffffffffc0206350 <commands+0x330>
ffffffffc0200a98:	f00ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200a9c:	782c                	ld	a1,112(s0)
ffffffffc0200a9e:	00006517          	auipc	a0,0x6
ffffffffc0200aa2:	8ca50513          	addi	a0,a0,-1846 # ffffffffc0206368 <commands+0x348>
ffffffffc0200aa6:	ef2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200aaa:	7c2c                	ld	a1,120(s0)
ffffffffc0200aac:	00006517          	auipc	a0,0x6
ffffffffc0200ab0:	8d450513          	addi	a0,a0,-1836 # ffffffffc0206380 <commands+0x360>
ffffffffc0200ab4:	ee4ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200ab8:	604c                	ld	a1,128(s0)
ffffffffc0200aba:	00006517          	auipc	a0,0x6
ffffffffc0200abe:	8de50513          	addi	a0,a0,-1826 # ffffffffc0206398 <commands+0x378>
ffffffffc0200ac2:	ed6ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200ac6:	644c                	ld	a1,136(s0)
ffffffffc0200ac8:	00006517          	auipc	a0,0x6
ffffffffc0200acc:	8e850513          	addi	a0,a0,-1816 # ffffffffc02063b0 <commands+0x390>
ffffffffc0200ad0:	ec8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ad4:	684c                	ld	a1,144(s0)
ffffffffc0200ad6:	00006517          	auipc	a0,0x6
ffffffffc0200ada:	8f250513          	addi	a0,a0,-1806 # ffffffffc02063c8 <commands+0x3a8>
ffffffffc0200ade:	ebaff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200ae2:	6c4c                	ld	a1,152(s0)
ffffffffc0200ae4:	00006517          	auipc	a0,0x6
ffffffffc0200ae8:	8fc50513          	addi	a0,a0,-1796 # ffffffffc02063e0 <commands+0x3c0>
ffffffffc0200aec:	eacff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200af0:	704c                	ld	a1,160(s0)
ffffffffc0200af2:	00006517          	auipc	a0,0x6
ffffffffc0200af6:	90650513          	addi	a0,a0,-1786 # ffffffffc02063f8 <commands+0x3d8>
ffffffffc0200afa:	e9eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200afe:	744c                	ld	a1,168(s0)
ffffffffc0200b00:	00006517          	auipc	a0,0x6
ffffffffc0200b04:	91050513          	addi	a0,a0,-1776 # ffffffffc0206410 <commands+0x3f0>
ffffffffc0200b08:	e90ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b0c:	784c                	ld	a1,176(s0)
ffffffffc0200b0e:	00006517          	auipc	a0,0x6
ffffffffc0200b12:	91a50513          	addi	a0,a0,-1766 # ffffffffc0206428 <commands+0x408>
ffffffffc0200b16:	e82ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b1a:	7c4c                	ld	a1,184(s0)
ffffffffc0200b1c:	00006517          	auipc	a0,0x6
ffffffffc0200b20:	92450513          	addi	a0,a0,-1756 # ffffffffc0206440 <commands+0x420>
ffffffffc0200b24:	e74ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b28:	606c                	ld	a1,192(s0)
ffffffffc0200b2a:	00006517          	auipc	a0,0x6
ffffffffc0200b2e:	92e50513          	addi	a0,a0,-1746 # ffffffffc0206458 <commands+0x438>
ffffffffc0200b32:	e66ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b36:	646c                	ld	a1,200(s0)
ffffffffc0200b38:	00006517          	auipc	a0,0x6
ffffffffc0200b3c:	93850513          	addi	a0,a0,-1736 # ffffffffc0206470 <commands+0x450>
ffffffffc0200b40:	e58ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b44:	686c                	ld	a1,208(s0)
ffffffffc0200b46:	00006517          	auipc	a0,0x6
ffffffffc0200b4a:	94250513          	addi	a0,a0,-1726 # ffffffffc0206488 <commands+0x468>
ffffffffc0200b4e:	e4aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b52:	6c6c                	ld	a1,216(s0)
ffffffffc0200b54:	00006517          	auipc	a0,0x6
ffffffffc0200b58:	94c50513          	addi	a0,a0,-1716 # ffffffffc02064a0 <commands+0x480>
ffffffffc0200b5c:	e3cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b60:	706c                	ld	a1,224(s0)
ffffffffc0200b62:	00006517          	auipc	a0,0x6
ffffffffc0200b66:	95650513          	addi	a0,a0,-1706 # ffffffffc02064b8 <commands+0x498>
ffffffffc0200b6a:	e2eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b6e:	746c                	ld	a1,232(s0)
ffffffffc0200b70:	00006517          	auipc	a0,0x6
ffffffffc0200b74:	96050513          	addi	a0,a0,-1696 # ffffffffc02064d0 <commands+0x4b0>
ffffffffc0200b78:	e20ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b7c:	786c                	ld	a1,240(s0)
ffffffffc0200b7e:	00006517          	auipc	a0,0x6
ffffffffc0200b82:	96a50513          	addi	a0,a0,-1686 # ffffffffc02064e8 <commands+0x4c8>
ffffffffc0200b86:	e12ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b8a:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b8c:	6402                	ld	s0,0(sp)
ffffffffc0200b8e:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b90:	00006517          	auipc	a0,0x6
ffffffffc0200b94:	97050513          	addi	a0,a0,-1680 # ffffffffc0206500 <commands+0x4e0>
}
ffffffffc0200b98:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b9a:	dfeff06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0200b9e <print_trapframe>:
{
ffffffffc0200b9e:	1141                	addi	sp,sp,-16
ffffffffc0200ba0:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba2:	85aa                	mv	a1,a0
{
ffffffffc0200ba4:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba6:	00006517          	auipc	a0,0x6
ffffffffc0200baa:	97250513          	addi	a0,a0,-1678 # ffffffffc0206518 <commands+0x4f8>
{
ffffffffc0200bae:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb0:	de8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	e1bff0ef          	jal	ra,ffffffffc02009d0 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bba:	10043583          	ld	a1,256(s0)
ffffffffc0200bbe:	00006517          	auipc	a0,0x6
ffffffffc0200bc2:	97250513          	addi	a0,a0,-1678 # ffffffffc0206530 <commands+0x510>
ffffffffc0200bc6:	dd2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bca:	10843583          	ld	a1,264(s0)
ffffffffc0200bce:	00006517          	auipc	a0,0x6
ffffffffc0200bd2:	97a50513          	addi	a0,a0,-1670 # ffffffffc0206548 <commands+0x528>
ffffffffc0200bd6:	dc2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200bda:	11043583          	ld	a1,272(s0)
ffffffffc0200bde:	00006517          	auipc	a0,0x6
ffffffffc0200be2:	98250513          	addi	a0,a0,-1662 # ffffffffc0206560 <commands+0x540>
ffffffffc0200be6:	db2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bea:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bee:	6402                	ld	s0,0(sp)
ffffffffc0200bf0:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf2:	00006517          	auipc	a0,0x6
ffffffffc0200bf6:	97e50513          	addi	a0,a0,-1666 # ffffffffc0206570 <commands+0x550>
}
ffffffffc0200bfa:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bfc:	d9cff06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0200c00 <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c00:	11853783          	ld	a5,280(a0)
ffffffffc0200c04:	472d                	li	a4,11
ffffffffc0200c06:	0786                	slli	a5,a5,0x1
ffffffffc0200c08:	8385                	srli	a5,a5,0x1
ffffffffc0200c0a:	08f76363          	bltu	a4,a5,ffffffffc0200c90 <interrupt_handler+0x90>
ffffffffc0200c0e:	00006717          	auipc	a4,0x6
ffffffffc0200c12:	a6a70713          	addi	a4,a4,-1430 # ffffffffc0206678 <commands+0x658>
ffffffffc0200c16:	078a                	slli	a5,a5,0x2
ffffffffc0200c18:	97ba                	add	a5,a5,a4
ffffffffc0200c1a:	439c                	lw	a5,0(a5)
ffffffffc0200c1c:	97ba                	add	a5,a5,a4
ffffffffc0200c1e:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c20:	00006517          	auipc	a0,0x6
ffffffffc0200c24:	9c850513          	addi	a0,a0,-1592 # ffffffffc02065e8 <commands+0x5c8>
ffffffffc0200c28:	d70ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c2c:	00006517          	auipc	a0,0x6
ffffffffc0200c30:	99c50513          	addi	a0,a0,-1636 # ffffffffc02065c8 <commands+0x5a8>
ffffffffc0200c34:	d64ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c38:	00006517          	auipc	a0,0x6
ffffffffc0200c3c:	95050513          	addi	a0,a0,-1712 # ffffffffc0206588 <commands+0x568>
ffffffffc0200c40:	d58ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c44:	00006517          	auipc	a0,0x6
ffffffffc0200c48:	96450513          	addi	a0,a0,-1692 # ffffffffc02065a8 <commands+0x588>
ffffffffc0200c4c:	d4cff06f          	j	ffffffffc0200198 <cprintf>
{
ffffffffc0200c50:	1141                	addi	sp,sp,-16
ffffffffc0200c52:	e406                	sd	ra,8(sp)
         *(2)计数器（ticks）加一
         *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
         * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
         */
    {
        clock_set_next_event();
ffffffffc0200c54:	91bff0ef          	jal	ra,ffffffffc020056e <clock_set_next_event>
        ticks++;
ffffffffc0200c58:	000e6797          	auipc	a5,0xe6
ffffffffc0200c5c:	1a078793          	addi	a5,a5,416 # ffffffffc02e6df8 <ticks>
ffffffffc0200c60:	6398                	ld	a4,0(a5)
ffffffffc0200c62:	0705                	addi	a4,a4,1
ffffffffc0200c64:	e398                	sd	a4,0(a5)
        if (ticks % TICK_NUM == 0)
ffffffffc0200c66:	639c                	ld	a5,0(a5)
ffffffffc0200c68:	06400713          	li	a4,100
ffffffffc0200c6c:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200c70:	c785                	beqz	a5,ffffffffc0200c98 <interrupt_handler+0x98>
            if (++num == 10)
            {
                sbi_shutdown();
            }
        }
        if (current != NULL)
ffffffffc0200c72:	000e6517          	auipc	a0,0xe6
ffffffffc0200c76:	1d653503          	ld	a0,470(a0) # ffffffffc02e6e48 <current>
ffffffffc0200c7a:	cd01                	beqz	a0,ffffffffc0200c92 <interrupt_handler+0x92>
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c7c:	60a2                	ld	ra,8(sp)
ffffffffc0200c7e:	0141                	addi	sp,sp,16
            sched_class_proc_tick(current);
ffffffffc0200c80:	1790406f          	j	ffffffffc02055f8 <sched_class_proc_tick>
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c84:	00006517          	auipc	a0,0x6
ffffffffc0200c88:	9d450513          	addi	a0,a0,-1580 # ffffffffc0206658 <commands+0x638>
ffffffffc0200c8c:	d0cff06f          	j	ffffffffc0200198 <cprintf>
        print_trapframe(tf);
ffffffffc0200c90:	b739                	j	ffffffffc0200b9e <print_trapframe>
}
ffffffffc0200c92:	60a2                	ld	ra,8(sp)
ffffffffc0200c94:	0141                	addi	sp,sp,16
ffffffffc0200c96:	8082                	ret
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200c98:	06400593          	li	a1,100
ffffffffc0200c9c:	00006517          	auipc	a0,0x6
ffffffffc0200ca0:	96c50513          	addi	a0,a0,-1684 # ffffffffc0206608 <commands+0x5e8>
ffffffffc0200ca4:	cf4ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("End of Test.\n");
ffffffffc0200ca8:	00006517          	auipc	a0,0x6
ffffffffc0200cac:	97050513          	addi	a0,a0,-1680 # ffffffffc0206618 <commands+0x5f8>
ffffffffc0200cb0:	ce8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    panic("EOT: kernel seems ok.");
ffffffffc0200cb4:	00006617          	auipc	a2,0x6
ffffffffc0200cb8:	97460613          	addi	a2,a2,-1676 # ffffffffc0206628 <commands+0x608>
ffffffffc0200cbc:	45f1                	li	a1,28
ffffffffc0200cbe:	00006517          	auipc	a0,0x6
ffffffffc0200cc2:	98250513          	addi	a0,a0,-1662 # ffffffffc0206640 <commands+0x620>
ffffffffc0200cc6:	fccff0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0200cca <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200cca:	11853783          	ld	a5,280(a0)
{
ffffffffc0200cce:	1141                	addi	sp,sp,-16
ffffffffc0200cd0:	e022                	sd	s0,0(sp)
ffffffffc0200cd2:	e406                	sd	ra,8(sp)
ffffffffc0200cd4:	473d                	li	a4,15
ffffffffc0200cd6:	842a                	mv	s0,a0
ffffffffc0200cd8:	0af76b63          	bltu	a4,a5,ffffffffc0200d8e <exception_handler+0xc4>
ffffffffc0200cdc:	00006717          	auipc	a4,0x6
ffffffffc0200ce0:	b4470713          	addi	a4,a4,-1212 # ffffffffc0206820 <commands+0x800>
ffffffffc0200ce4:	078a                	slli	a5,a5,0x2
ffffffffc0200ce6:	97ba                	add	a5,a5,a4
ffffffffc0200ce8:	439c                	lw	a5,0(a5)
ffffffffc0200cea:	97ba                	add	a5,a5,a4
ffffffffc0200cec:	8782                	jr	a5
        // cprintf("Environment call from U-mode\n");
        tf->epc += 4;
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200cee:	00006517          	auipc	a0,0x6
ffffffffc0200cf2:	a8a50513          	addi	a0,a0,-1398 # ffffffffc0206778 <commands+0x758>
ffffffffc0200cf6:	ca2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        tf->epc += 4;
ffffffffc0200cfa:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200cfe:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200d00:	0791                	addi	a5,a5,4
ffffffffc0200d02:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200d06:	6402                	ld	s0,0(sp)
ffffffffc0200d08:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200d0a:	3590406f          	j	ffffffffc0205862 <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200d0e:	00006517          	auipc	a0,0x6
ffffffffc0200d12:	a8a50513          	addi	a0,a0,-1398 # ffffffffc0206798 <commands+0x778>
}
ffffffffc0200d16:	6402                	ld	s0,0(sp)
ffffffffc0200d18:	60a2                	ld	ra,8(sp)
ffffffffc0200d1a:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200d1c:	c7cff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200d20:	00006517          	auipc	a0,0x6
ffffffffc0200d24:	a9850513          	addi	a0,a0,-1384 # ffffffffc02067b8 <commands+0x798>
ffffffffc0200d28:	b7fd                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200d2a:	00006517          	auipc	a0,0x6
ffffffffc0200d2e:	aae50513          	addi	a0,a0,-1362 # ffffffffc02067d8 <commands+0x7b8>
ffffffffc0200d32:	b7d5                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200d34:	00006517          	auipc	a0,0x6
ffffffffc0200d38:	abc50513          	addi	a0,a0,-1348 # ffffffffc02067f0 <commands+0x7d0>
ffffffffc0200d3c:	bfe9                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200d3e:	00006517          	auipc	a0,0x6
ffffffffc0200d42:	aca50513          	addi	a0,a0,-1334 # ffffffffc0206808 <commands+0x7e8>
ffffffffc0200d46:	bfc1                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d48:	00006517          	auipc	a0,0x6
ffffffffc0200d4c:	96050513          	addi	a0,a0,-1696 # ffffffffc02066a8 <commands+0x688>
ffffffffc0200d50:	b7d9                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d52:	00006517          	auipc	a0,0x6
ffffffffc0200d56:	97650513          	addi	a0,a0,-1674 # ffffffffc02066c8 <commands+0x6a8>
ffffffffc0200d5a:	bf75                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d5c:	00006517          	auipc	a0,0x6
ffffffffc0200d60:	98c50513          	addi	a0,a0,-1652 # ffffffffc02066e8 <commands+0x6c8>
ffffffffc0200d64:	bf4d                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d66:	00006517          	auipc	a0,0x6
ffffffffc0200d6a:	99a50513          	addi	a0,a0,-1638 # ffffffffc0206700 <commands+0x6e0>
ffffffffc0200d6e:	b765                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Load address misaligned\n");
ffffffffc0200d70:	00006517          	auipc	a0,0x6
ffffffffc0200d74:	9a050513          	addi	a0,a0,-1632 # ffffffffc0206710 <commands+0x6f0>
ffffffffc0200d78:	bf79                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200d7a:	00006517          	auipc	a0,0x6
ffffffffc0200d7e:	9b650513          	addi	a0,a0,-1610 # ffffffffc0206730 <commands+0x710>
ffffffffc0200d82:	bf51                	j	ffffffffc0200d16 <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200d84:	00006517          	auipc	a0,0x6
ffffffffc0200d88:	9dc50513          	addi	a0,a0,-1572 # ffffffffc0206760 <commands+0x740>
ffffffffc0200d8c:	b769                	j	ffffffffc0200d16 <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200d8e:	8522                	mv	a0,s0
}
ffffffffc0200d90:	6402                	ld	s0,0(sp)
ffffffffc0200d92:	60a2                	ld	ra,8(sp)
ffffffffc0200d94:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200d96:	b521                	j	ffffffffc0200b9e <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200d98:	00006617          	auipc	a2,0x6
ffffffffc0200d9c:	9b060613          	addi	a2,a2,-1616 # ffffffffc0206748 <commands+0x728>
ffffffffc0200da0:	0c800593          	li	a1,200
ffffffffc0200da4:	00006517          	auipc	a0,0x6
ffffffffc0200da8:	89c50513          	addi	a0,a0,-1892 # ffffffffc0206640 <commands+0x620>
ffffffffc0200dac:	ee6ff0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0200db0 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200db0:	1101                	addi	sp,sp,-32
ffffffffc0200db2:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200db4:	000e6417          	auipc	s0,0xe6
ffffffffc0200db8:	09440413          	addi	s0,s0,148 # ffffffffc02e6e48 <current>
ffffffffc0200dbc:	6018                	ld	a4,0(s0)
{
ffffffffc0200dbe:	ec06                	sd	ra,24(sp)
ffffffffc0200dc0:	e426                	sd	s1,8(sp)
ffffffffc0200dc2:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200dc4:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200dc8:	cf1d                	beqz	a4,ffffffffc0200e06 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200dca:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200dce:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200dd2:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200dd4:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200dd8:	0206c463          	bltz	a3,ffffffffc0200e00 <trap+0x50>
        exception_handler(tf);
ffffffffc0200ddc:	eefff0ef          	jal	ra,ffffffffc0200cca <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200de0:	601c                	ld	a5,0(s0)
ffffffffc0200de2:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel)
ffffffffc0200de6:	e499                	bnez	s1,ffffffffc0200df4 <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200de8:	0b07a703          	lw	a4,176(a5)
ffffffffc0200dec:	8b05                	andi	a4,a4,1
ffffffffc0200dee:	e329                	bnez	a4,ffffffffc0200e30 <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200df0:	6f9c                	ld	a5,24(a5)
ffffffffc0200df2:	eb85                	bnez	a5,ffffffffc0200e22 <trap+0x72>
            {
                schedule();
            }
        }
    }
}
ffffffffc0200df4:	60e2                	ld	ra,24(sp)
ffffffffc0200df6:	6442                	ld	s0,16(sp)
ffffffffc0200df8:	64a2                	ld	s1,8(sp)
ffffffffc0200dfa:	6902                	ld	s2,0(sp)
ffffffffc0200dfc:	6105                	addi	sp,sp,32
ffffffffc0200dfe:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200e00:	e01ff0ef          	jal	ra,ffffffffc0200c00 <interrupt_handler>
ffffffffc0200e04:	bff1                	j	ffffffffc0200de0 <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e06:	0006c863          	bltz	a3,ffffffffc0200e16 <trap+0x66>
}
ffffffffc0200e0a:	6442                	ld	s0,16(sp)
ffffffffc0200e0c:	60e2                	ld	ra,24(sp)
ffffffffc0200e0e:	64a2                	ld	s1,8(sp)
ffffffffc0200e10:	6902                	ld	s2,0(sp)
ffffffffc0200e12:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200e14:	bd5d                	j	ffffffffc0200cca <exception_handler>
}
ffffffffc0200e16:	6442                	ld	s0,16(sp)
ffffffffc0200e18:	60e2                	ld	ra,24(sp)
ffffffffc0200e1a:	64a2                	ld	s1,8(sp)
ffffffffc0200e1c:	6902                	ld	s2,0(sp)
ffffffffc0200e1e:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200e20:	b3c5                	j	ffffffffc0200c00 <interrupt_handler>
}
ffffffffc0200e22:	6442                	ld	s0,16(sp)
ffffffffc0200e24:	60e2                	ld	ra,24(sp)
ffffffffc0200e26:	64a2                	ld	s1,8(sp)
ffffffffc0200e28:	6902                	ld	s2,0(sp)
ffffffffc0200e2a:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200e2c:	0f90406f          	j	ffffffffc0205724 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200e30:	555d                	li	a0,-9
ffffffffc0200e32:	4e8030ef          	jal	ra,ffffffffc020431a <do_exit>
            if (current->need_resched)
ffffffffc0200e36:	601c                	ld	a5,0(s0)
ffffffffc0200e38:	bf65                	j	ffffffffc0200df0 <trap+0x40>
	...

ffffffffc0200e3c <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200e3c:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200e40:	00011463          	bnez	sp,ffffffffc0200e48 <__alltraps+0xc>
ffffffffc0200e44:	14002173          	csrr	sp,sscratch
ffffffffc0200e48:	712d                	addi	sp,sp,-288
ffffffffc0200e4a:	e002                	sd	zero,0(sp)
ffffffffc0200e4c:	e406                	sd	ra,8(sp)
ffffffffc0200e4e:	ec0e                	sd	gp,24(sp)
ffffffffc0200e50:	f012                	sd	tp,32(sp)
ffffffffc0200e52:	f416                	sd	t0,40(sp)
ffffffffc0200e54:	f81a                	sd	t1,48(sp)
ffffffffc0200e56:	fc1e                	sd	t2,56(sp)
ffffffffc0200e58:	e0a2                	sd	s0,64(sp)
ffffffffc0200e5a:	e4a6                	sd	s1,72(sp)
ffffffffc0200e5c:	e8aa                	sd	a0,80(sp)
ffffffffc0200e5e:	ecae                	sd	a1,88(sp)
ffffffffc0200e60:	f0b2                	sd	a2,96(sp)
ffffffffc0200e62:	f4b6                	sd	a3,104(sp)
ffffffffc0200e64:	f8ba                	sd	a4,112(sp)
ffffffffc0200e66:	fcbe                	sd	a5,120(sp)
ffffffffc0200e68:	e142                	sd	a6,128(sp)
ffffffffc0200e6a:	e546                	sd	a7,136(sp)
ffffffffc0200e6c:	e94a                	sd	s2,144(sp)
ffffffffc0200e6e:	ed4e                	sd	s3,152(sp)
ffffffffc0200e70:	f152                	sd	s4,160(sp)
ffffffffc0200e72:	f556                	sd	s5,168(sp)
ffffffffc0200e74:	f95a                	sd	s6,176(sp)
ffffffffc0200e76:	fd5e                	sd	s7,184(sp)
ffffffffc0200e78:	e1e2                	sd	s8,192(sp)
ffffffffc0200e7a:	e5e6                	sd	s9,200(sp)
ffffffffc0200e7c:	e9ea                	sd	s10,208(sp)
ffffffffc0200e7e:	edee                	sd	s11,216(sp)
ffffffffc0200e80:	f1f2                	sd	t3,224(sp)
ffffffffc0200e82:	f5f6                	sd	t4,232(sp)
ffffffffc0200e84:	f9fa                	sd	t5,240(sp)
ffffffffc0200e86:	fdfe                	sd	t6,248(sp)
ffffffffc0200e88:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200e8c:	100024f3          	csrr	s1,sstatus
ffffffffc0200e90:	14102973          	csrr	s2,sepc
ffffffffc0200e94:	143029f3          	csrr	s3,stval
ffffffffc0200e98:	14202a73          	csrr	s4,scause
ffffffffc0200e9c:	e822                	sd	s0,16(sp)
ffffffffc0200e9e:	e226                	sd	s1,256(sp)
ffffffffc0200ea0:	e64a                	sd	s2,264(sp)
ffffffffc0200ea2:	ea4e                	sd	s3,272(sp)
ffffffffc0200ea4:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200ea6:	850a                	mv	a0,sp
    jal trap
ffffffffc0200ea8:	f09ff0ef          	jal	ra,ffffffffc0200db0 <trap>

ffffffffc0200eac <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200eac:	6492                	ld	s1,256(sp)
ffffffffc0200eae:	6932                	ld	s2,264(sp)
ffffffffc0200eb0:	1004f413          	andi	s0,s1,256
ffffffffc0200eb4:	e401                	bnez	s0,ffffffffc0200ebc <__trapret+0x10>
ffffffffc0200eb6:	1200                	addi	s0,sp,288
ffffffffc0200eb8:	14041073          	csrw	sscratch,s0
ffffffffc0200ebc:	10049073          	csrw	sstatus,s1
ffffffffc0200ec0:	14191073          	csrw	sepc,s2
ffffffffc0200ec4:	60a2                	ld	ra,8(sp)
ffffffffc0200ec6:	61e2                	ld	gp,24(sp)
ffffffffc0200ec8:	7202                	ld	tp,32(sp)
ffffffffc0200eca:	72a2                	ld	t0,40(sp)
ffffffffc0200ecc:	7342                	ld	t1,48(sp)
ffffffffc0200ece:	73e2                	ld	t2,56(sp)
ffffffffc0200ed0:	6406                	ld	s0,64(sp)
ffffffffc0200ed2:	64a6                	ld	s1,72(sp)
ffffffffc0200ed4:	6546                	ld	a0,80(sp)
ffffffffc0200ed6:	65e6                	ld	a1,88(sp)
ffffffffc0200ed8:	7606                	ld	a2,96(sp)
ffffffffc0200eda:	76a6                	ld	a3,104(sp)
ffffffffc0200edc:	7746                	ld	a4,112(sp)
ffffffffc0200ede:	77e6                	ld	a5,120(sp)
ffffffffc0200ee0:	680a                	ld	a6,128(sp)
ffffffffc0200ee2:	68aa                	ld	a7,136(sp)
ffffffffc0200ee4:	694a                	ld	s2,144(sp)
ffffffffc0200ee6:	69ea                	ld	s3,152(sp)
ffffffffc0200ee8:	7a0a                	ld	s4,160(sp)
ffffffffc0200eea:	7aaa                	ld	s5,168(sp)
ffffffffc0200eec:	7b4a                	ld	s6,176(sp)
ffffffffc0200eee:	7bea                	ld	s7,184(sp)
ffffffffc0200ef0:	6c0e                	ld	s8,192(sp)
ffffffffc0200ef2:	6cae                	ld	s9,200(sp)
ffffffffc0200ef4:	6d4e                	ld	s10,208(sp)
ffffffffc0200ef6:	6dee                	ld	s11,216(sp)
ffffffffc0200ef8:	7e0e                	ld	t3,224(sp)
ffffffffc0200efa:	7eae                	ld	t4,232(sp)
ffffffffc0200efc:	7f4e                	ld	t5,240(sp)
ffffffffc0200efe:	7fee                	ld	t6,248(sp)
ffffffffc0200f00:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200f02:	10200073          	sret

ffffffffc0200f06 <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200f06:	812a                	mv	sp,a0
ffffffffc0200f08:	b755                	j	ffffffffc0200eac <__trapret>

ffffffffc0200f0a <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200f0a:	000e2797          	auipc	a5,0xe2
ffffffffc0200f0e:	e8e78793          	addi	a5,a5,-370 # ffffffffc02e2d98 <free_area>
ffffffffc0200f12:	e79c                	sd	a5,8(a5)
ffffffffc0200f14:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200f16:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200f1a:	8082                	ret

ffffffffc0200f1c <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0200f1c:	000e2517          	auipc	a0,0xe2
ffffffffc0200f20:	e8c56503          	lwu	a0,-372(a0) # ffffffffc02e2da8 <free_area+0x10>
ffffffffc0200f24:	8082                	ret

ffffffffc0200f26 <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc0200f26:	715d                	addi	sp,sp,-80
ffffffffc0200f28:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200f2a:	000e2417          	auipc	s0,0xe2
ffffffffc0200f2e:	e6e40413          	addi	s0,s0,-402 # ffffffffc02e2d98 <free_area>
ffffffffc0200f32:	641c                	ld	a5,8(s0)
ffffffffc0200f34:	e486                	sd	ra,72(sp)
ffffffffc0200f36:	fc26                	sd	s1,56(sp)
ffffffffc0200f38:	f84a                	sd	s2,48(sp)
ffffffffc0200f3a:	f44e                	sd	s3,40(sp)
ffffffffc0200f3c:	f052                	sd	s4,32(sp)
ffffffffc0200f3e:	ec56                	sd	s5,24(sp)
ffffffffc0200f40:	e85a                	sd	s6,16(sp)
ffffffffc0200f42:	e45e                	sd	s7,8(sp)
ffffffffc0200f44:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0200f46:	2a878d63          	beq	a5,s0,ffffffffc0201200 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0200f4a:	4481                	li	s1,0
ffffffffc0200f4c:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200f4e:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200f52:	8b09                	andi	a4,a4,2
ffffffffc0200f54:	2a070a63          	beqz	a4,ffffffffc0201208 <default_check+0x2e2>
        count++, total += p->property;
ffffffffc0200f58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200f5c:	679c                	ld	a5,8(a5)
ffffffffc0200f5e:	2905                	addiw	s2,s2,1
ffffffffc0200f60:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0200f62:	fe8796e3          	bne	a5,s0,ffffffffc0200f4e <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200f66:	89a6                	mv	s3,s1
ffffffffc0200f68:	6df000ef          	jal	ra,ffffffffc0201e46 <nr_free_pages>
ffffffffc0200f6c:	6f351e63          	bne	a0,s3,ffffffffc0201668 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200f70:	4505                	li	a0,1
ffffffffc0200f72:	657000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0200f76:	8aaa                	mv	s5,a0
ffffffffc0200f78:	42050863          	beqz	a0,ffffffffc02013a8 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200f7c:	4505                	li	a0,1
ffffffffc0200f7e:	64b000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0200f82:	89aa                	mv	s3,a0
ffffffffc0200f84:	70050263          	beqz	a0,ffffffffc0201688 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200f88:	4505                	li	a0,1
ffffffffc0200f8a:	63f000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0200f8e:	8a2a                	mv	s4,a0
ffffffffc0200f90:	48050c63          	beqz	a0,ffffffffc0201428 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200f94:	293a8a63          	beq	s5,s3,ffffffffc0201228 <default_check+0x302>
ffffffffc0200f98:	28aa8863          	beq	s5,a0,ffffffffc0201228 <default_check+0x302>
ffffffffc0200f9c:	28a98663          	beq	s3,a0,ffffffffc0201228 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200fa0:	000aa783          	lw	a5,0(s5)
ffffffffc0200fa4:	2a079263          	bnez	a5,ffffffffc0201248 <default_check+0x322>
ffffffffc0200fa8:	0009a783          	lw	a5,0(s3)
ffffffffc0200fac:	28079e63          	bnez	a5,ffffffffc0201248 <default_check+0x322>
ffffffffc0200fb0:	411c                	lw	a5,0(a0)
ffffffffc0200fb2:	28079b63          	bnez	a5,ffffffffc0201248 <default_check+0x322>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc0200fb6:	000e6797          	auipc	a5,0xe6
ffffffffc0200fba:	e7a7b783          	ld	a5,-390(a5) # ffffffffc02e6e30 <pages>
ffffffffc0200fbe:	40fa8733          	sub	a4,s5,a5
ffffffffc0200fc2:	00007617          	auipc	a2,0x7
ffffffffc0200fc6:	78663603          	ld	a2,1926(a2) # ffffffffc0208748 <nbase>
ffffffffc0200fca:	8719                	srai	a4,a4,0x6
ffffffffc0200fcc:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200fce:	000e6697          	auipc	a3,0xe6
ffffffffc0200fd2:	e5a6b683          	ld	a3,-422(a3) # ffffffffc02e6e28 <npage>
ffffffffc0200fd6:	06b2                	slli	a3,a3,0xc
}

static inline uintptr_t
page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
ffffffffc0200fd8:	0732                	slli	a4,a4,0xc
ffffffffc0200fda:	28d77763          	bgeu	a4,a3,ffffffffc0201268 <default_check+0x342>
    return page - pages + nbase;
ffffffffc0200fde:	40f98733          	sub	a4,s3,a5
ffffffffc0200fe2:	8719                	srai	a4,a4,0x6
ffffffffc0200fe4:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200fe6:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200fe8:	4cd77063          	bgeu	a4,a3,ffffffffc02014a8 <default_check+0x582>
    return page - pages + nbase;
ffffffffc0200fec:	40f507b3          	sub	a5,a0,a5
ffffffffc0200ff0:	8799                	srai	a5,a5,0x6
ffffffffc0200ff2:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200ff4:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200ff6:	30d7f963          	bgeu	a5,a3,ffffffffc0201308 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc0200ffa:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200ffc:	00043c03          	ld	s8,0(s0)
ffffffffc0201000:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0201004:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0201008:	e400                	sd	s0,8(s0)
ffffffffc020100a:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc020100c:	000e2797          	auipc	a5,0xe2
ffffffffc0201010:	d807ae23          	sw	zero,-612(a5) # ffffffffc02e2da8 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0201014:	5b5000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0201018:	2c051863          	bnez	a0,ffffffffc02012e8 <default_check+0x3c2>
    free_page(p0);
ffffffffc020101c:	4585                	li	a1,1
ffffffffc020101e:	8556                	mv	a0,s5
ffffffffc0201020:	5e7000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    free_page(p1);
ffffffffc0201024:	4585                	li	a1,1
ffffffffc0201026:	854e                	mv	a0,s3
ffffffffc0201028:	5df000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    free_page(p2);
ffffffffc020102c:	4585                	li	a1,1
ffffffffc020102e:	8552                	mv	a0,s4
ffffffffc0201030:	5d7000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    assert(nr_free == 3);
ffffffffc0201034:	4818                	lw	a4,16(s0)
ffffffffc0201036:	478d                	li	a5,3
ffffffffc0201038:	28f71863          	bne	a4,a5,ffffffffc02012c8 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020103c:	4505                	li	a0,1
ffffffffc020103e:	58b000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0201042:	89aa                	mv	s3,a0
ffffffffc0201044:	26050263          	beqz	a0,ffffffffc02012a8 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201048:	4505                	li	a0,1
ffffffffc020104a:	57f000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc020104e:	8aaa                	mv	s5,a0
ffffffffc0201050:	3a050c63          	beqz	a0,ffffffffc0201408 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201054:	4505                	li	a0,1
ffffffffc0201056:	573000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc020105a:	8a2a                	mv	s4,a0
ffffffffc020105c:	38050663          	beqz	a0,ffffffffc02013e8 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201060:	4505                	li	a0,1
ffffffffc0201062:	567000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0201066:	36051163          	bnez	a0,ffffffffc02013c8 <default_check+0x4a2>
    free_page(p0);
ffffffffc020106a:	4585                	li	a1,1
ffffffffc020106c:	854e                	mv	a0,s3
ffffffffc020106e:	599000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0201072:	641c                	ld	a5,8(s0)
ffffffffc0201074:	20878a63          	beq	a5,s0,ffffffffc0201288 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201078:	4505                	li	a0,1
ffffffffc020107a:	54f000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc020107e:	30a99563          	bne	s3,a0,ffffffffc0201388 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0201082:	4505                	li	a0,1
ffffffffc0201084:	545000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0201088:	2e051063          	bnez	a0,ffffffffc0201368 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc020108c:	481c                	lw	a5,16(s0)
ffffffffc020108e:	2a079d63          	bnez	a5,ffffffffc0201348 <default_check+0x422>
    free_page(p);
ffffffffc0201092:	854e                	mv	a0,s3
ffffffffc0201094:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0201096:	01843023          	sd	s8,0(s0)
ffffffffc020109a:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc020109e:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc02010a2:	565000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    free_page(p1);
ffffffffc02010a6:	4585                	li	a1,1
ffffffffc02010a8:	8556                	mv	a0,s5
ffffffffc02010aa:	55d000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    free_page(p2);
ffffffffc02010ae:	4585                	li	a1,1
ffffffffc02010b0:	8552                	mv	a0,s4
ffffffffc02010b2:	555000ef          	jal	ra,ffffffffc0201e06 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc02010b6:	4515                	li	a0,5
ffffffffc02010b8:	511000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc02010bc:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc02010be:	26050563          	beqz	a0,ffffffffc0201328 <default_check+0x402>
ffffffffc02010c2:	651c                	ld	a5,8(a0)
ffffffffc02010c4:	8385                	srli	a5,a5,0x1
ffffffffc02010c6:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc02010c8:	54079063          	bnez	a5,ffffffffc0201608 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc02010cc:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02010ce:	00043b03          	ld	s6,0(s0)
ffffffffc02010d2:	00843a83          	ld	s5,8(s0)
ffffffffc02010d6:	e000                	sd	s0,0(s0)
ffffffffc02010d8:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02010da:	4ef000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc02010de:	50051563          	bnez	a0,ffffffffc02015e8 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02010e2:	08098a13          	addi	s4,s3,128
ffffffffc02010e6:	8552                	mv	a0,s4
ffffffffc02010e8:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02010ea:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02010ee:	000e2797          	auipc	a5,0xe2
ffffffffc02010f2:	ca07ad23          	sw	zero,-838(a5) # ffffffffc02e2da8 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02010f6:	511000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02010fa:	4511                	li	a0,4
ffffffffc02010fc:	4cd000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0201100:	4c051463          	bnez	a0,ffffffffc02015c8 <default_check+0x6a2>
ffffffffc0201104:	0889b783          	ld	a5,136(s3)
ffffffffc0201108:	8385                	srli	a5,a5,0x1
ffffffffc020110a:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc020110c:	48078e63          	beqz	a5,ffffffffc02015a8 <default_check+0x682>
ffffffffc0201110:	0909a703          	lw	a4,144(s3)
ffffffffc0201114:	478d                	li	a5,3
ffffffffc0201116:	48f71963          	bne	a4,a5,ffffffffc02015a8 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc020111a:	450d                	li	a0,3
ffffffffc020111c:	4ad000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0201120:	8c2a                	mv	s8,a0
ffffffffc0201122:	46050363          	beqz	a0,ffffffffc0201588 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc0201126:	4505                	li	a0,1
ffffffffc0201128:	4a1000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc020112c:	42051e63          	bnez	a0,ffffffffc0201568 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0201130:	418a1c63          	bne	s4,s8,ffffffffc0201548 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0201134:	4585                	li	a1,1
ffffffffc0201136:	854e                	mv	a0,s3
ffffffffc0201138:	4cf000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    free_pages(p1, 3);
ffffffffc020113c:	458d                	li	a1,3
ffffffffc020113e:	8552                	mv	a0,s4
ffffffffc0201140:	4c7000ef          	jal	ra,ffffffffc0201e06 <free_pages>
ffffffffc0201144:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201148:	04098c13          	addi	s8,s3,64
ffffffffc020114c:	8385                	srli	a5,a5,0x1
ffffffffc020114e:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201150:	3c078c63          	beqz	a5,ffffffffc0201528 <default_check+0x602>
ffffffffc0201154:	0109a703          	lw	a4,16(s3)
ffffffffc0201158:	4785                	li	a5,1
ffffffffc020115a:	3cf71763          	bne	a4,a5,ffffffffc0201528 <default_check+0x602>
ffffffffc020115e:	008a3783          	ld	a5,8(s4)
ffffffffc0201162:	8385                	srli	a5,a5,0x1
ffffffffc0201164:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201166:	3a078163          	beqz	a5,ffffffffc0201508 <default_check+0x5e2>
ffffffffc020116a:	010a2703          	lw	a4,16(s4)
ffffffffc020116e:	478d                	li	a5,3
ffffffffc0201170:	38f71c63          	bne	a4,a5,ffffffffc0201508 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201174:	4505                	li	a0,1
ffffffffc0201176:	453000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc020117a:	36a99763          	bne	s3,a0,ffffffffc02014e8 <default_check+0x5c2>
    free_page(p0);
ffffffffc020117e:	4585                	li	a1,1
ffffffffc0201180:	487000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201184:	4509                	li	a0,2
ffffffffc0201186:	443000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc020118a:	32aa1f63          	bne	s4,a0,ffffffffc02014c8 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc020118e:	4589                	li	a1,2
ffffffffc0201190:	477000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    free_page(p2);
ffffffffc0201194:	4585                	li	a1,1
ffffffffc0201196:	8562                	mv	a0,s8
ffffffffc0201198:	46f000ef          	jal	ra,ffffffffc0201e06 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc020119c:	4515                	li	a0,5
ffffffffc020119e:	42b000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc02011a2:	89aa                	mv	s3,a0
ffffffffc02011a4:	48050263          	beqz	a0,ffffffffc0201628 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc02011a8:	4505                	li	a0,1
ffffffffc02011aa:	41f000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc02011ae:	2c051d63          	bnez	a0,ffffffffc0201488 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc02011b2:	481c                	lw	a5,16(s0)
ffffffffc02011b4:	2a079a63          	bnez	a5,ffffffffc0201468 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc02011b8:	4595                	li	a1,5
ffffffffc02011ba:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc02011bc:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc02011c0:	01643023          	sd	s6,0(s0)
ffffffffc02011c4:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc02011c8:	43f000ef          	jal	ra,ffffffffc0201e06 <free_pages>
    return listelm->next;
ffffffffc02011cc:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc02011ce:	00878963          	beq	a5,s0,ffffffffc02011e0 <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc02011d2:	ff87a703          	lw	a4,-8(a5)
ffffffffc02011d6:	679c                	ld	a5,8(a5)
ffffffffc02011d8:	397d                	addiw	s2,s2,-1
ffffffffc02011da:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc02011dc:	fe879be3          	bne	a5,s0,ffffffffc02011d2 <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02011e0:	26091463          	bnez	s2,ffffffffc0201448 <default_check+0x522>
    assert(total == 0);
ffffffffc02011e4:	46049263          	bnez	s1,ffffffffc0201648 <default_check+0x722>
}
ffffffffc02011e8:	60a6                	ld	ra,72(sp)
ffffffffc02011ea:	6406                	ld	s0,64(sp)
ffffffffc02011ec:	74e2                	ld	s1,56(sp)
ffffffffc02011ee:	7942                	ld	s2,48(sp)
ffffffffc02011f0:	79a2                	ld	s3,40(sp)
ffffffffc02011f2:	7a02                	ld	s4,32(sp)
ffffffffc02011f4:	6ae2                	ld	s5,24(sp)
ffffffffc02011f6:	6b42                	ld	s6,16(sp)
ffffffffc02011f8:	6ba2                	ld	s7,8(sp)
ffffffffc02011fa:	6c02                	ld	s8,0(sp)
ffffffffc02011fc:	6161                	addi	sp,sp,80
ffffffffc02011fe:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc0201200:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0201202:	4481                	li	s1,0
ffffffffc0201204:	4901                	li	s2,0
ffffffffc0201206:	b38d                	j	ffffffffc0200f68 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0201208:	00005697          	auipc	a3,0x5
ffffffffc020120c:	65868693          	addi	a3,a3,1624 # ffffffffc0206860 <commands+0x840>
ffffffffc0201210:	00005617          	auipc	a2,0x5
ffffffffc0201214:	66060613          	addi	a2,a2,1632 # ffffffffc0206870 <commands+0x850>
ffffffffc0201218:	11000593          	li	a1,272
ffffffffc020121c:	00005517          	auipc	a0,0x5
ffffffffc0201220:	66c50513          	addi	a0,a0,1644 # ffffffffc0206888 <commands+0x868>
ffffffffc0201224:	a6eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201228:	00005697          	auipc	a3,0x5
ffffffffc020122c:	6f868693          	addi	a3,a3,1784 # ffffffffc0206920 <commands+0x900>
ffffffffc0201230:	00005617          	auipc	a2,0x5
ffffffffc0201234:	64060613          	addi	a2,a2,1600 # ffffffffc0206870 <commands+0x850>
ffffffffc0201238:	0db00593          	li	a1,219
ffffffffc020123c:	00005517          	auipc	a0,0x5
ffffffffc0201240:	64c50513          	addi	a0,a0,1612 # ffffffffc0206888 <commands+0x868>
ffffffffc0201244:	a4eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201248:	00005697          	auipc	a3,0x5
ffffffffc020124c:	70068693          	addi	a3,a3,1792 # ffffffffc0206948 <commands+0x928>
ffffffffc0201250:	00005617          	auipc	a2,0x5
ffffffffc0201254:	62060613          	addi	a2,a2,1568 # ffffffffc0206870 <commands+0x850>
ffffffffc0201258:	0dc00593          	li	a1,220
ffffffffc020125c:	00005517          	auipc	a0,0x5
ffffffffc0201260:	62c50513          	addi	a0,a0,1580 # ffffffffc0206888 <commands+0x868>
ffffffffc0201264:	a2eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201268:	00005697          	auipc	a3,0x5
ffffffffc020126c:	72068693          	addi	a3,a3,1824 # ffffffffc0206988 <commands+0x968>
ffffffffc0201270:	00005617          	auipc	a2,0x5
ffffffffc0201274:	60060613          	addi	a2,a2,1536 # ffffffffc0206870 <commands+0x850>
ffffffffc0201278:	0de00593          	li	a1,222
ffffffffc020127c:	00005517          	auipc	a0,0x5
ffffffffc0201280:	60c50513          	addi	a0,a0,1548 # ffffffffc0206888 <commands+0x868>
ffffffffc0201284:	a0eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201288:	00005697          	auipc	a3,0x5
ffffffffc020128c:	78868693          	addi	a3,a3,1928 # ffffffffc0206a10 <commands+0x9f0>
ffffffffc0201290:	00005617          	auipc	a2,0x5
ffffffffc0201294:	5e060613          	addi	a2,a2,1504 # ffffffffc0206870 <commands+0x850>
ffffffffc0201298:	0f700593          	li	a1,247
ffffffffc020129c:	00005517          	auipc	a0,0x5
ffffffffc02012a0:	5ec50513          	addi	a0,a0,1516 # ffffffffc0206888 <commands+0x868>
ffffffffc02012a4:	9eeff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc02012a8:	00005697          	auipc	a3,0x5
ffffffffc02012ac:	61868693          	addi	a3,a3,1560 # ffffffffc02068c0 <commands+0x8a0>
ffffffffc02012b0:	00005617          	auipc	a2,0x5
ffffffffc02012b4:	5c060613          	addi	a2,a2,1472 # ffffffffc0206870 <commands+0x850>
ffffffffc02012b8:	0f000593          	li	a1,240
ffffffffc02012bc:	00005517          	auipc	a0,0x5
ffffffffc02012c0:	5cc50513          	addi	a0,a0,1484 # ffffffffc0206888 <commands+0x868>
ffffffffc02012c4:	9ceff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 3);
ffffffffc02012c8:	00005697          	auipc	a3,0x5
ffffffffc02012cc:	73868693          	addi	a3,a3,1848 # ffffffffc0206a00 <commands+0x9e0>
ffffffffc02012d0:	00005617          	auipc	a2,0x5
ffffffffc02012d4:	5a060613          	addi	a2,a2,1440 # ffffffffc0206870 <commands+0x850>
ffffffffc02012d8:	0ee00593          	li	a1,238
ffffffffc02012dc:	00005517          	auipc	a0,0x5
ffffffffc02012e0:	5ac50513          	addi	a0,a0,1452 # ffffffffc0206888 <commands+0x868>
ffffffffc02012e4:	9aeff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02012e8:	00005697          	auipc	a3,0x5
ffffffffc02012ec:	70068693          	addi	a3,a3,1792 # ffffffffc02069e8 <commands+0x9c8>
ffffffffc02012f0:	00005617          	auipc	a2,0x5
ffffffffc02012f4:	58060613          	addi	a2,a2,1408 # ffffffffc0206870 <commands+0x850>
ffffffffc02012f8:	0e900593          	li	a1,233
ffffffffc02012fc:	00005517          	auipc	a0,0x5
ffffffffc0201300:	58c50513          	addi	a0,a0,1420 # ffffffffc0206888 <commands+0x868>
ffffffffc0201304:	98eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201308:	00005697          	auipc	a3,0x5
ffffffffc020130c:	6c068693          	addi	a3,a3,1728 # ffffffffc02069c8 <commands+0x9a8>
ffffffffc0201310:	00005617          	auipc	a2,0x5
ffffffffc0201314:	56060613          	addi	a2,a2,1376 # ffffffffc0206870 <commands+0x850>
ffffffffc0201318:	0e000593          	li	a1,224
ffffffffc020131c:	00005517          	auipc	a0,0x5
ffffffffc0201320:	56c50513          	addi	a0,a0,1388 # ffffffffc0206888 <commands+0x868>
ffffffffc0201324:	96eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 != NULL);
ffffffffc0201328:	00005697          	auipc	a3,0x5
ffffffffc020132c:	73068693          	addi	a3,a3,1840 # ffffffffc0206a58 <commands+0xa38>
ffffffffc0201330:	00005617          	auipc	a2,0x5
ffffffffc0201334:	54060613          	addi	a2,a2,1344 # ffffffffc0206870 <commands+0x850>
ffffffffc0201338:	11800593          	li	a1,280
ffffffffc020133c:	00005517          	auipc	a0,0x5
ffffffffc0201340:	54c50513          	addi	a0,a0,1356 # ffffffffc0206888 <commands+0x868>
ffffffffc0201344:	94eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 0);
ffffffffc0201348:	00005697          	auipc	a3,0x5
ffffffffc020134c:	70068693          	addi	a3,a3,1792 # ffffffffc0206a48 <commands+0xa28>
ffffffffc0201350:	00005617          	auipc	a2,0x5
ffffffffc0201354:	52060613          	addi	a2,a2,1312 # ffffffffc0206870 <commands+0x850>
ffffffffc0201358:	0fd00593          	li	a1,253
ffffffffc020135c:	00005517          	auipc	a0,0x5
ffffffffc0201360:	52c50513          	addi	a0,a0,1324 # ffffffffc0206888 <commands+0x868>
ffffffffc0201364:	92eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201368:	00005697          	auipc	a3,0x5
ffffffffc020136c:	68068693          	addi	a3,a3,1664 # ffffffffc02069e8 <commands+0x9c8>
ffffffffc0201370:	00005617          	auipc	a2,0x5
ffffffffc0201374:	50060613          	addi	a2,a2,1280 # ffffffffc0206870 <commands+0x850>
ffffffffc0201378:	0fb00593          	li	a1,251
ffffffffc020137c:	00005517          	auipc	a0,0x5
ffffffffc0201380:	50c50513          	addi	a0,a0,1292 # ffffffffc0206888 <commands+0x868>
ffffffffc0201384:	90eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201388:	00005697          	auipc	a3,0x5
ffffffffc020138c:	6a068693          	addi	a3,a3,1696 # ffffffffc0206a28 <commands+0xa08>
ffffffffc0201390:	00005617          	auipc	a2,0x5
ffffffffc0201394:	4e060613          	addi	a2,a2,1248 # ffffffffc0206870 <commands+0x850>
ffffffffc0201398:	0fa00593          	li	a1,250
ffffffffc020139c:	00005517          	auipc	a0,0x5
ffffffffc02013a0:	4ec50513          	addi	a0,a0,1260 # ffffffffc0206888 <commands+0x868>
ffffffffc02013a4:	8eeff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc02013a8:	00005697          	auipc	a3,0x5
ffffffffc02013ac:	51868693          	addi	a3,a3,1304 # ffffffffc02068c0 <commands+0x8a0>
ffffffffc02013b0:	00005617          	auipc	a2,0x5
ffffffffc02013b4:	4c060613          	addi	a2,a2,1216 # ffffffffc0206870 <commands+0x850>
ffffffffc02013b8:	0d700593          	li	a1,215
ffffffffc02013bc:	00005517          	auipc	a0,0x5
ffffffffc02013c0:	4cc50513          	addi	a0,a0,1228 # ffffffffc0206888 <commands+0x868>
ffffffffc02013c4:	8ceff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013c8:	00005697          	auipc	a3,0x5
ffffffffc02013cc:	62068693          	addi	a3,a3,1568 # ffffffffc02069e8 <commands+0x9c8>
ffffffffc02013d0:	00005617          	auipc	a2,0x5
ffffffffc02013d4:	4a060613          	addi	a2,a2,1184 # ffffffffc0206870 <commands+0x850>
ffffffffc02013d8:	0f400593          	li	a1,244
ffffffffc02013dc:	00005517          	auipc	a0,0x5
ffffffffc02013e0:	4ac50513          	addi	a0,a0,1196 # ffffffffc0206888 <commands+0x868>
ffffffffc02013e4:	8aeff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02013e8:	00005697          	auipc	a3,0x5
ffffffffc02013ec:	51868693          	addi	a3,a3,1304 # ffffffffc0206900 <commands+0x8e0>
ffffffffc02013f0:	00005617          	auipc	a2,0x5
ffffffffc02013f4:	48060613          	addi	a2,a2,1152 # ffffffffc0206870 <commands+0x850>
ffffffffc02013f8:	0f200593          	li	a1,242
ffffffffc02013fc:	00005517          	auipc	a0,0x5
ffffffffc0201400:	48c50513          	addi	a0,a0,1164 # ffffffffc0206888 <commands+0x868>
ffffffffc0201404:	88eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201408:	00005697          	auipc	a3,0x5
ffffffffc020140c:	4d868693          	addi	a3,a3,1240 # ffffffffc02068e0 <commands+0x8c0>
ffffffffc0201410:	00005617          	auipc	a2,0x5
ffffffffc0201414:	46060613          	addi	a2,a2,1120 # ffffffffc0206870 <commands+0x850>
ffffffffc0201418:	0f100593          	li	a1,241
ffffffffc020141c:	00005517          	auipc	a0,0x5
ffffffffc0201420:	46c50513          	addi	a0,a0,1132 # ffffffffc0206888 <commands+0x868>
ffffffffc0201424:	86eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201428:	00005697          	auipc	a3,0x5
ffffffffc020142c:	4d868693          	addi	a3,a3,1240 # ffffffffc0206900 <commands+0x8e0>
ffffffffc0201430:	00005617          	auipc	a2,0x5
ffffffffc0201434:	44060613          	addi	a2,a2,1088 # ffffffffc0206870 <commands+0x850>
ffffffffc0201438:	0d900593          	li	a1,217
ffffffffc020143c:	00005517          	auipc	a0,0x5
ffffffffc0201440:	44c50513          	addi	a0,a0,1100 # ffffffffc0206888 <commands+0x868>
ffffffffc0201444:	84eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(count == 0);
ffffffffc0201448:	00005697          	auipc	a3,0x5
ffffffffc020144c:	76068693          	addi	a3,a3,1888 # ffffffffc0206ba8 <commands+0xb88>
ffffffffc0201450:	00005617          	auipc	a2,0x5
ffffffffc0201454:	42060613          	addi	a2,a2,1056 # ffffffffc0206870 <commands+0x850>
ffffffffc0201458:	14600593          	li	a1,326
ffffffffc020145c:	00005517          	auipc	a0,0x5
ffffffffc0201460:	42c50513          	addi	a0,a0,1068 # ffffffffc0206888 <commands+0x868>
ffffffffc0201464:	82eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 0);
ffffffffc0201468:	00005697          	auipc	a3,0x5
ffffffffc020146c:	5e068693          	addi	a3,a3,1504 # ffffffffc0206a48 <commands+0xa28>
ffffffffc0201470:	00005617          	auipc	a2,0x5
ffffffffc0201474:	40060613          	addi	a2,a2,1024 # ffffffffc0206870 <commands+0x850>
ffffffffc0201478:	13a00593          	li	a1,314
ffffffffc020147c:	00005517          	auipc	a0,0x5
ffffffffc0201480:	40c50513          	addi	a0,a0,1036 # ffffffffc0206888 <commands+0x868>
ffffffffc0201484:	80eff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201488:	00005697          	auipc	a3,0x5
ffffffffc020148c:	56068693          	addi	a3,a3,1376 # ffffffffc02069e8 <commands+0x9c8>
ffffffffc0201490:	00005617          	auipc	a2,0x5
ffffffffc0201494:	3e060613          	addi	a2,a2,992 # ffffffffc0206870 <commands+0x850>
ffffffffc0201498:	13800593          	li	a1,312
ffffffffc020149c:	00005517          	auipc	a0,0x5
ffffffffc02014a0:	3ec50513          	addi	a0,a0,1004 # ffffffffc0206888 <commands+0x868>
ffffffffc02014a4:	feffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02014a8:	00005697          	auipc	a3,0x5
ffffffffc02014ac:	50068693          	addi	a3,a3,1280 # ffffffffc02069a8 <commands+0x988>
ffffffffc02014b0:	00005617          	auipc	a2,0x5
ffffffffc02014b4:	3c060613          	addi	a2,a2,960 # ffffffffc0206870 <commands+0x850>
ffffffffc02014b8:	0df00593          	li	a1,223
ffffffffc02014bc:	00005517          	auipc	a0,0x5
ffffffffc02014c0:	3cc50513          	addi	a0,a0,972 # ffffffffc0206888 <commands+0x868>
ffffffffc02014c4:	fcffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02014c8:	00005697          	auipc	a3,0x5
ffffffffc02014cc:	6a068693          	addi	a3,a3,1696 # ffffffffc0206b68 <commands+0xb48>
ffffffffc02014d0:	00005617          	auipc	a2,0x5
ffffffffc02014d4:	3a060613          	addi	a2,a2,928 # ffffffffc0206870 <commands+0x850>
ffffffffc02014d8:	13200593          	li	a1,306
ffffffffc02014dc:	00005517          	auipc	a0,0x5
ffffffffc02014e0:	3ac50513          	addi	a0,a0,940 # ffffffffc0206888 <commands+0x868>
ffffffffc02014e4:	faffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02014e8:	00005697          	auipc	a3,0x5
ffffffffc02014ec:	66068693          	addi	a3,a3,1632 # ffffffffc0206b48 <commands+0xb28>
ffffffffc02014f0:	00005617          	auipc	a2,0x5
ffffffffc02014f4:	38060613          	addi	a2,a2,896 # ffffffffc0206870 <commands+0x850>
ffffffffc02014f8:	13000593          	li	a1,304
ffffffffc02014fc:	00005517          	auipc	a0,0x5
ffffffffc0201500:	38c50513          	addi	a0,a0,908 # ffffffffc0206888 <commands+0x868>
ffffffffc0201504:	f8ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201508:	00005697          	auipc	a3,0x5
ffffffffc020150c:	61868693          	addi	a3,a3,1560 # ffffffffc0206b20 <commands+0xb00>
ffffffffc0201510:	00005617          	auipc	a2,0x5
ffffffffc0201514:	36060613          	addi	a2,a2,864 # ffffffffc0206870 <commands+0x850>
ffffffffc0201518:	12e00593          	li	a1,302
ffffffffc020151c:	00005517          	auipc	a0,0x5
ffffffffc0201520:	36c50513          	addi	a0,a0,876 # ffffffffc0206888 <commands+0x868>
ffffffffc0201524:	f6ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201528:	00005697          	auipc	a3,0x5
ffffffffc020152c:	5d068693          	addi	a3,a3,1488 # ffffffffc0206af8 <commands+0xad8>
ffffffffc0201530:	00005617          	auipc	a2,0x5
ffffffffc0201534:	34060613          	addi	a2,a2,832 # ffffffffc0206870 <commands+0x850>
ffffffffc0201538:	12d00593          	li	a1,301
ffffffffc020153c:	00005517          	auipc	a0,0x5
ffffffffc0201540:	34c50513          	addi	a0,a0,844 # ffffffffc0206888 <commands+0x868>
ffffffffc0201544:	f4ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201548:	00005697          	auipc	a3,0x5
ffffffffc020154c:	5a068693          	addi	a3,a3,1440 # ffffffffc0206ae8 <commands+0xac8>
ffffffffc0201550:	00005617          	auipc	a2,0x5
ffffffffc0201554:	32060613          	addi	a2,a2,800 # ffffffffc0206870 <commands+0x850>
ffffffffc0201558:	12800593          	li	a1,296
ffffffffc020155c:	00005517          	auipc	a0,0x5
ffffffffc0201560:	32c50513          	addi	a0,a0,812 # ffffffffc0206888 <commands+0x868>
ffffffffc0201564:	f2ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201568:	00005697          	auipc	a3,0x5
ffffffffc020156c:	48068693          	addi	a3,a3,1152 # ffffffffc02069e8 <commands+0x9c8>
ffffffffc0201570:	00005617          	auipc	a2,0x5
ffffffffc0201574:	30060613          	addi	a2,a2,768 # ffffffffc0206870 <commands+0x850>
ffffffffc0201578:	12700593          	li	a1,295
ffffffffc020157c:	00005517          	auipc	a0,0x5
ffffffffc0201580:	30c50513          	addi	a0,a0,780 # ffffffffc0206888 <commands+0x868>
ffffffffc0201584:	f0ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201588:	00005697          	auipc	a3,0x5
ffffffffc020158c:	54068693          	addi	a3,a3,1344 # ffffffffc0206ac8 <commands+0xaa8>
ffffffffc0201590:	00005617          	auipc	a2,0x5
ffffffffc0201594:	2e060613          	addi	a2,a2,736 # ffffffffc0206870 <commands+0x850>
ffffffffc0201598:	12600593          	li	a1,294
ffffffffc020159c:	00005517          	auipc	a0,0x5
ffffffffc02015a0:	2ec50513          	addi	a0,a0,748 # ffffffffc0206888 <commands+0x868>
ffffffffc02015a4:	eeffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02015a8:	00005697          	auipc	a3,0x5
ffffffffc02015ac:	4f068693          	addi	a3,a3,1264 # ffffffffc0206a98 <commands+0xa78>
ffffffffc02015b0:	00005617          	auipc	a2,0x5
ffffffffc02015b4:	2c060613          	addi	a2,a2,704 # ffffffffc0206870 <commands+0x850>
ffffffffc02015b8:	12500593          	li	a1,293
ffffffffc02015bc:	00005517          	auipc	a0,0x5
ffffffffc02015c0:	2cc50513          	addi	a0,a0,716 # ffffffffc0206888 <commands+0x868>
ffffffffc02015c4:	ecffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02015c8:	00005697          	auipc	a3,0x5
ffffffffc02015cc:	4b868693          	addi	a3,a3,1208 # ffffffffc0206a80 <commands+0xa60>
ffffffffc02015d0:	00005617          	auipc	a2,0x5
ffffffffc02015d4:	2a060613          	addi	a2,a2,672 # ffffffffc0206870 <commands+0x850>
ffffffffc02015d8:	12400593          	li	a1,292
ffffffffc02015dc:	00005517          	auipc	a0,0x5
ffffffffc02015e0:	2ac50513          	addi	a0,a0,684 # ffffffffc0206888 <commands+0x868>
ffffffffc02015e4:	eaffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02015e8:	00005697          	auipc	a3,0x5
ffffffffc02015ec:	40068693          	addi	a3,a3,1024 # ffffffffc02069e8 <commands+0x9c8>
ffffffffc02015f0:	00005617          	auipc	a2,0x5
ffffffffc02015f4:	28060613          	addi	a2,a2,640 # ffffffffc0206870 <commands+0x850>
ffffffffc02015f8:	11e00593          	li	a1,286
ffffffffc02015fc:	00005517          	auipc	a0,0x5
ffffffffc0201600:	28c50513          	addi	a0,a0,652 # ffffffffc0206888 <commands+0x868>
ffffffffc0201604:	e8ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(!PageProperty(p0));
ffffffffc0201608:	00005697          	auipc	a3,0x5
ffffffffc020160c:	46068693          	addi	a3,a3,1120 # ffffffffc0206a68 <commands+0xa48>
ffffffffc0201610:	00005617          	auipc	a2,0x5
ffffffffc0201614:	26060613          	addi	a2,a2,608 # ffffffffc0206870 <commands+0x850>
ffffffffc0201618:	11900593          	li	a1,281
ffffffffc020161c:	00005517          	auipc	a0,0x5
ffffffffc0201620:	26c50513          	addi	a0,a0,620 # ffffffffc0206888 <commands+0x868>
ffffffffc0201624:	e6ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201628:	00005697          	auipc	a3,0x5
ffffffffc020162c:	56068693          	addi	a3,a3,1376 # ffffffffc0206b88 <commands+0xb68>
ffffffffc0201630:	00005617          	auipc	a2,0x5
ffffffffc0201634:	24060613          	addi	a2,a2,576 # ffffffffc0206870 <commands+0x850>
ffffffffc0201638:	13700593          	li	a1,311
ffffffffc020163c:	00005517          	auipc	a0,0x5
ffffffffc0201640:	24c50513          	addi	a0,a0,588 # ffffffffc0206888 <commands+0x868>
ffffffffc0201644:	e4ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(total == 0);
ffffffffc0201648:	00005697          	auipc	a3,0x5
ffffffffc020164c:	57068693          	addi	a3,a3,1392 # ffffffffc0206bb8 <commands+0xb98>
ffffffffc0201650:	00005617          	auipc	a2,0x5
ffffffffc0201654:	22060613          	addi	a2,a2,544 # ffffffffc0206870 <commands+0x850>
ffffffffc0201658:	14700593          	li	a1,327
ffffffffc020165c:	00005517          	auipc	a0,0x5
ffffffffc0201660:	22c50513          	addi	a0,a0,556 # ffffffffc0206888 <commands+0x868>
ffffffffc0201664:	e2ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(total == nr_free_pages());
ffffffffc0201668:	00005697          	auipc	a3,0x5
ffffffffc020166c:	23868693          	addi	a3,a3,568 # ffffffffc02068a0 <commands+0x880>
ffffffffc0201670:	00005617          	auipc	a2,0x5
ffffffffc0201674:	20060613          	addi	a2,a2,512 # ffffffffc0206870 <commands+0x850>
ffffffffc0201678:	11300593          	li	a1,275
ffffffffc020167c:	00005517          	auipc	a0,0x5
ffffffffc0201680:	20c50513          	addi	a0,a0,524 # ffffffffc0206888 <commands+0x868>
ffffffffc0201684:	e0ffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201688:	00005697          	auipc	a3,0x5
ffffffffc020168c:	25868693          	addi	a3,a3,600 # ffffffffc02068e0 <commands+0x8c0>
ffffffffc0201690:	00005617          	auipc	a2,0x5
ffffffffc0201694:	1e060613          	addi	a2,a2,480 # ffffffffc0206870 <commands+0x850>
ffffffffc0201698:	0d800593          	li	a1,216
ffffffffc020169c:	00005517          	auipc	a0,0x5
ffffffffc02016a0:	1ec50513          	addi	a0,a0,492 # ffffffffc0206888 <commands+0x868>
ffffffffc02016a4:	deffe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02016a8 <default_free_pages>:
{
ffffffffc02016a8:	1141                	addi	sp,sp,-16
ffffffffc02016aa:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02016ac:	14058463          	beqz	a1,ffffffffc02017f4 <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc02016b0:	00659693          	slli	a3,a1,0x6
ffffffffc02016b4:	96aa                	add	a3,a3,a0
ffffffffc02016b6:	87aa                	mv	a5,a0
ffffffffc02016b8:	02d50263          	beq	a0,a3,ffffffffc02016dc <default_free_pages+0x34>
ffffffffc02016bc:	6798                	ld	a4,8(a5)
ffffffffc02016be:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02016c0:	10071a63          	bnez	a4,ffffffffc02017d4 <default_free_pages+0x12c>
ffffffffc02016c4:	6798                	ld	a4,8(a5)
ffffffffc02016c6:	8b09                	andi	a4,a4,2
ffffffffc02016c8:	10071663          	bnez	a4,ffffffffc02017d4 <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc02016cc:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc02016d0:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02016d4:	04078793          	addi	a5,a5,64
ffffffffc02016d8:	fed792e3          	bne	a5,a3,ffffffffc02016bc <default_free_pages+0x14>
    base->property = n;
ffffffffc02016dc:	2581                	sext.w	a1,a1
ffffffffc02016de:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02016e0:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02016e4:	4789                	li	a5,2
ffffffffc02016e6:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02016ea:	000e1697          	auipc	a3,0xe1
ffffffffc02016ee:	6ae68693          	addi	a3,a3,1710 # ffffffffc02e2d98 <free_area>
ffffffffc02016f2:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02016f4:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02016f6:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02016fa:	9db9                	addw	a1,a1,a4
ffffffffc02016fc:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02016fe:	0ad78463          	beq	a5,a3,ffffffffc02017a6 <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc0201702:	fe878713          	addi	a4,a5,-24
ffffffffc0201706:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc020170a:	4581                	li	a1,0
            if (base < page)
ffffffffc020170c:	00e56a63          	bltu	a0,a4,ffffffffc0201720 <default_free_pages+0x78>
    return listelm->next;
ffffffffc0201710:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc0201712:	04d70c63          	beq	a4,a3,ffffffffc020176a <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc0201716:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc0201718:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc020171c:	fee57ae3          	bgeu	a0,a4,ffffffffc0201710 <default_free_pages+0x68>
ffffffffc0201720:	c199                	beqz	a1,ffffffffc0201726 <default_free_pages+0x7e>
ffffffffc0201722:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201726:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc0201728:	e390                	sd	a2,0(a5)
ffffffffc020172a:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc020172c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020172e:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc0201730:	00d70d63          	beq	a4,a3,ffffffffc020174a <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc0201734:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc0201738:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc020173c:	02059813          	slli	a6,a1,0x20
ffffffffc0201740:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201744:	97b2                	add	a5,a5,a2
ffffffffc0201746:	02f50c63          	beq	a0,a5,ffffffffc020177e <default_free_pages+0xd6>
    return listelm->next;
ffffffffc020174a:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc020174c:	00d78c63          	beq	a5,a3,ffffffffc0201764 <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc0201750:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0201752:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc0201756:	02061593          	slli	a1,a2,0x20
ffffffffc020175a:	01a5d713          	srli	a4,a1,0x1a
ffffffffc020175e:	972a                	add	a4,a4,a0
ffffffffc0201760:	04e68a63          	beq	a3,a4,ffffffffc02017b4 <default_free_pages+0x10c>
}
ffffffffc0201764:	60a2                	ld	ra,8(sp)
ffffffffc0201766:	0141                	addi	sp,sp,16
ffffffffc0201768:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020176a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020176c:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020176e:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201770:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201772:	02d70763          	beq	a4,a3,ffffffffc02017a0 <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc0201776:	8832                	mv	a6,a2
ffffffffc0201778:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc020177a:	87ba                	mv	a5,a4
ffffffffc020177c:	bf71                	j	ffffffffc0201718 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc020177e:	491c                	lw	a5,16(a0)
ffffffffc0201780:	9dbd                	addw	a1,a1,a5
ffffffffc0201782:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201786:	57f5                	li	a5,-3
ffffffffc0201788:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc020178c:	01853803          	ld	a6,24(a0)
ffffffffc0201790:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc0201792:	8532                	mv	a0,a2
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201794:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc0201798:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc020179a:	0105b023          	sd	a6,0(a1)
ffffffffc020179e:	b77d                	j	ffffffffc020174c <default_free_pages+0xa4>
ffffffffc02017a0:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc02017a2:	873e                	mv	a4,a5
ffffffffc02017a4:	bf41                	j	ffffffffc0201734 <default_free_pages+0x8c>
}
ffffffffc02017a6:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02017a8:	e390                	sd	a2,0(a5)
ffffffffc02017aa:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02017ac:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02017ae:	ed1c                	sd	a5,24(a0)
ffffffffc02017b0:	0141                	addi	sp,sp,16
ffffffffc02017b2:	8082                	ret
            base->property += p->property;
ffffffffc02017b4:	ff87a703          	lw	a4,-8(a5)
ffffffffc02017b8:	ff078693          	addi	a3,a5,-16
ffffffffc02017bc:	9e39                	addw	a2,a2,a4
ffffffffc02017be:	c910                	sw	a2,16(a0)
ffffffffc02017c0:	5775                	li	a4,-3
ffffffffc02017c2:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02017c6:	6398                	ld	a4,0(a5)
ffffffffc02017c8:	679c                	ld	a5,8(a5)
}
ffffffffc02017ca:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02017cc:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc02017ce:	e398                	sd	a4,0(a5)
ffffffffc02017d0:	0141                	addi	sp,sp,16
ffffffffc02017d2:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02017d4:	00005697          	auipc	a3,0x5
ffffffffc02017d8:	3fc68693          	addi	a3,a3,1020 # ffffffffc0206bd0 <commands+0xbb0>
ffffffffc02017dc:	00005617          	auipc	a2,0x5
ffffffffc02017e0:	09460613          	addi	a2,a2,148 # ffffffffc0206870 <commands+0x850>
ffffffffc02017e4:	09400593          	li	a1,148
ffffffffc02017e8:	00005517          	auipc	a0,0x5
ffffffffc02017ec:	0a050513          	addi	a0,a0,160 # ffffffffc0206888 <commands+0x868>
ffffffffc02017f0:	ca3fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(n > 0);
ffffffffc02017f4:	00005697          	auipc	a3,0x5
ffffffffc02017f8:	3d468693          	addi	a3,a3,980 # ffffffffc0206bc8 <commands+0xba8>
ffffffffc02017fc:	00005617          	auipc	a2,0x5
ffffffffc0201800:	07460613          	addi	a2,a2,116 # ffffffffc0206870 <commands+0x850>
ffffffffc0201804:	09000593          	li	a1,144
ffffffffc0201808:	00005517          	auipc	a0,0x5
ffffffffc020180c:	08050513          	addi	a0,a0,128 # ffffffffc0206888 <commands+0x868>
ffffffffc0201810:	c83fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201814 <default_alloc_pages>:
    assert(n > 0);
ffffffffc0201814:	c941                	beqz	a0,ffffffffc02018a4 <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc0201816:	000e1597          	auipc	a1,0xe1
ffffffffc020181a:	58258593          	addi	a1,a1,1410 # ffffffffc02e2d98 <free_area>
ffffffffc020181e:	0105a803          	lw	a6,16(a1)
ffffffffc0201822:	872a                	mv	a4,a0
ffffffffc0201824:	02081793          	slli	a5,a6,0x20
ffffffffc0201828:	9381                	srli	a5,a5,0x20
ffffffffc020182a:	00a7ee63          	bltu	a5,a0,ffffffffc0201846 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc020182e:	87ae                	mv	a5,a1
ffffffffc0201830:	a801                	j	ffffffffc0201840 <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc0201832:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201836:	02069613          	slli	a2,a3,0x20
ffffffffc020183a:	9201                	srli	a2,a2,0x20
ffffffffc020183c:	00e67763          	bgeu	a2,a4,ffffffffc020184a <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0201840:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc0201842:	feb798e3          	bne	a5,a1,ffffffffc0201832 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0201846:	4501                	li	a0,0
}
ffffffffc0201848:	8082                	ret
    return listelm->prev;
ffffffffc020184a:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc020184e:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc0201852:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc0201856:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc020185a:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc020185e:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc0201862:	02c77863          	bgeu	a4,a2,ffffffffc0201892 <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0201866:	071a                	slli	a4,a4,0x6
ffffffffc0201868:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc020186a:	41c686bb          	subw	a3,a3,t3
ffffffffc020186e:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201870:	00870613          	addi	a2,a4,8
ffffffffc0201874:	4689                	li	a3,2
ffffffffc0201876:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc020187a:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc020187e:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc0201882:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201886:	e290                	sd	a2,0(a3)
ffffffffc0201888:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc020188c:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc020188e:	01173c23          	sd	a7,24(a4)
ffffffffc0201892:	41c8083b          	subw	a6,a6,t3
ffffffffc0201896:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020189a:	5775                	li	a4,-3
ffffffffc020189c:	17c1                	addi	a5,a5,-16
ffffffffc020189e:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc02018a2:	8082                	ret
{
ffffffffc02018a4:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc02018a6:	00005697          	auipc	a3,0x5
ffffffffc02018aa:	32268693          	addi	a3,a3,802 # ffffffffc0206bc8 <commands+0xba8>
ffffffffc02018ae:	00005617          	auipc	a2,0x5
ffffffffc02018b2:	fc260613          	addi	a2,a2,-62 # ffffffffc0206870 <commands+0x850>
ffffffffc02018b6:	06c00593          	li	a1,108
ffffffffc02018ba:	00005517          	auipc	a0,0x5
ffffffffc02018be:	fce50513          	addi	a0,a0,-50 # ffffffffc0206888 <commands+0x868>
{
ffffffffc02018c2:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02018c4:	bcffe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02018c8 <default_init_memmap>:
{
ffffffffc02018c8:	1141                	addi	sp,sp,-16
ffffffffc02018ca:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02018cc:	c5f1                	beqz	a1,ffffffffc0201998 <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc02018ce:	00659693          	slli	a3,a1,0x6
ffffffffc02018d2:	96aa                	add	a3,a3,a0
ffffffffc02018d4:	87aa                	mv	a5,a0
ffffffffc02018d6:	00d50f63          	beq	a0,a3,ffffffffc02018f4 <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02018da:	6798                	ld	a4,8(a5)
ffffffffc02018dc:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02018de:	cf49                	beqz	a4,ffffffffc0201978 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02018e0:	0007a823          	sw	zero,16(a5)
ffffffffc02018e4:	0007b423          	sd	zero,8(a5)
ffffffffc02018e8:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02018ec:	04078793          	addi	a5,a5,64
ffffffffc02018f0:	fed795e3          	bne	a5,a3,ffffffffc02018da <default_init_memmap+0x12>
    base->property = n;
ffffffffc02018f4:	2581                	sext.w	a1,a1
ffffffffc02018f6:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02018f8:	4789                	li	a5,2
ffffffffc02018fa:	00850713          	addi	a4,a0,8
ffffffffc02018fe:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc0201902:	000e1697          	auipc	a3,0xe1
ffffffffc0201906:	49668693          	addi	a3,a3,1174 # ffffffffc02e2d98 <free_area>
ffffffffc020190a:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc020190c:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc020190e:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc0201912:	9db9                	addw	a1,a1,a4
ffffffffc0201914:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc0201916:	04d78a63          	beq	a5,a3,ffffffffc020196a <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc020191a:	fe878713          	addi	a4,a5,-24
ffffffffc020191e:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc0201922:	4581                	li	a1,0
            if (base < page)
ffffffffc0201924:	00e56a63          	bltu	a0,a4,ffffffffc0201938 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0201928:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc020192a:	02d70263          	beq	a4,a3,ffffffffc020194e <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc020192e:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc0201930:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc0201934:	fee57ae3          	bgeu	a0,a4,ffffffffc0201928 <default_init_memmap+0x60>
ffffffffc0201938:	c199                	beqz	a1,ffffffffc020193e <default_init_memmap+0x76>
ffffffffc020193a:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020193e:	6398                	ld	a4,0(a5)
}
ffffffffc0201940:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201942:	e390                	sd	a2,0(a5)
ffffffffc0201944:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201946:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201948:	ed18                	sd	a4,24(a0)
ffffffffc020194a:	0141                	addi	sp,sp,16
ffffffffc020194c:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020194e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201950:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201952:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201954:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201956:	00d70663          	beq	a4,a3,ffffffffc0201962 <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc020195a:	8832                	mv	a6,a2
ffffffffc020195c:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc020195e:	87ba                	mv	a5,a4
ffffffffc0201960:	bfc1                	j	ffffffffc0201930 <default_init_memmap+0x68>
}
ffffffffc0201962:	60a2                	ld	ra,8(sp)
ffffffffc0201964:	e290                	sd	a2,0(a3)
ffffffffc0201966:	0141                	addi	sp,sp,16
ffffffffc0201968:	8082                	ret
ffffffffc020196a:	60a2                	ld	ra,8(sp)
ffffffffc020196c:	e390                	sd	a2,0(a5)
ffffffffc020196e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201970:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201972:	ed1c                	sd	a5,24(a0)
ffffffffc0201974:	0141                	addi	sp,sp,16
ffffffffc0201976:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201978:	00005697          	auipc	a3,0x5
ffffffffc020197c:	28068693          	addi	a3,a3,640 # ffffffffc0206bf8 <commands+0xbd8>
ffffffffc0201980:	00005617          	auipc	a2,0x5
ffffffffc0201984:	ef060613          	addi	a2,a2,-272 # ffffffffc0206870 <commands+0x850>
ffffffffc0201988:	04b00593          	li	a1,75
ffffffffc020198c:	00005517          	auipc	a0,0x5
ffffffffc0201990:	efc50513          	addi	a0,a0,-260 # ffffffffc0206888 <commands+0x868>
ffffffffc0201994:	afffe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(n > 0);
ffffffffc0201998:	00005697          	auipc	a3,0x5
ffffffffc020199c:	23068693          	addi	a3,a3,560 # ffffffffc0206bc8 <commands+0xba8>
ffffffffc02019a0:	00005617          	auipc	a2,0x5
ffffffffc02019a4:	ed060613          	addi	a2,a2,-304 # ffffffffc0206870 <commands+0x850>
ffffffffc02019a8:	04700593          	li	a1,71
ffffffffc02019ac:	00005517          	auipc	a0,0x5
ffffffffc02019b0:	edc50513          	addi	a0,a0,-292 # ffffffffc0206888 <commands+0x868>
ffffffffc02019b4:	adffe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02019b8 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc02019b8:	c94d                	beqz	a0,ffffffffc0201a6a <slob_free+0xb2>
{
ffffffffc02019ba:	1141                	addi	sp,sp,-16
ffffffffc02019bc:	e022                	sd	s0,0(sp)
ffffffffc02019be:	e406                	sd	ra,8(sp)
ffffffffc02019c0:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc02019c2:	e9c1                	bnez	a1,ffffffffc0201a52 <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02019c4:	100027f3          	csrr	a5,sstatus
ffffffffc02019c8:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02019ca:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02019cc:	ebd9                	bnez	a5,ffffffffc0201a62 <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc02019ce:	000e1617          	auipc	a2,0xe1
ffffffffc02019d2:	fba60613          	addi	a2,a2,-70 # ffffffffc02e2988 <slobfree>
ffffffffc02019d6:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc02019d8:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc02019da:	679c                	ld	a5,8(a5)
ffffffffc02019dc:	02877a63          	bgeu	a4,s0,ffffffffc0201a10 <slob_free+0x58>
ffffffffc02019e0:	00f46463          	bltu	s0,a5,ffffffffc02019e8 <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc02019e4:	fef76ae3          	bltu	a4,a5,ffffffffc02019d8 <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc02019e8:	400c                	lw	a1,0(s0)
ffffffffc02019ea:	00459693          	slli	a3,a1,0x4
ffffffffc02019ee:	96a2                	add	a3,a3,s0
ffffffffc02019f0:	02d78a63          	beq	a5,a3,ffffffffc0201a24 <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc02019f4:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc02019f6:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc02019f8:	00469793          	slli	a5,a3,0x4
ffffffffc02019fc:	97ba                	add	a5,a5,a4
ffffffffc02019fe:	02f40e63          	beq	s0,a5,ffffffffc0201a3a <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc0201a02:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc0201a04:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc0201a06:	e129                	bnez	a0,ffffffffc0201a48 <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc0201a08:	60a2                	ld	ra,8(sp)
ffffffffc0201a0a:	6402                	ld	s0,0(sp)
ffffffffc0201a0c:	0141                	addi	sp,sp,16
ffffffffc0201a0e:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201a10:	fcf764e3          	bltu	a4,a5,ffffffffc02019d8 <slob_free+0x20>
ffffffffc0201a14:	fcf472e3          	bgeu	s0,a5,ffffffffc02019d8 <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc0201a18:	400c                	lw	a1,0(s0)
ffffffffc0201a1a:	00459693          	slli	a3,a1,0x4
ffffffffc0201a1e:	96a2                	add	a3,a3,s0
ffffffffc0201a20:	fcd79ae3          	bne	a5,a3,ffffffffc02019f4 <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc0201a24:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc0201a26:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc0201a28:	9db5                	addw	a1,a1,a3
ffffffffc0201a2a:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc0201a2c:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0201a2e:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201a30:	00469793          	slli	a5,a3,0x4
ffffffffc0201a34:	97ba                	add	a5,a5,a4
ffffffffc0201a36:	fcf416e3          	bne	s0,a5,ffffffffc0201a02 <slob_free+0x4a>
		cur->units += b->units;
ffffffffc0201a3a:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc0201a3c:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc0201a3e:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc0201a40:	9ebd                	addw	a3,a3,a5
ffffffffc0201a42:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc0201a44:	e70c                	sd	a1,8(a4)
ffffffffc0201a46:	d169                	beqz	a0,ffffffffc0201a08 <slob_free+0x50>
}
ffffffffc0201a48:	6402                	ld	s0,0(sp)
ffffffffc0201a4a:	60a2                	ld	ra,8(sp)
ffffffffc0201a4c:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201a4e:	f5bfe06f          	j	ffffffffc02009a8 <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc0201a52:	25bd                	addiw	a1,a1,15
ffffffffc0201a54:	8191                	srli	a1,a1,0x4
ffffffffc0201a56:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a58:	100027f3          	csrr	a5,sstatus
ffffffffc0201a5c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201a5e:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a60:	d7bd                	beqz	a5,ffffffffc02019ce <slob_free+0x16>
        intr_disable();
ffffffffc0201a62:	f4dfe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0201a66:	4505                	li	a0,1
ffffffffc0201a68:	b79d                	j	ffffffffc02019ce <slob_free+0x16>
ffffffffc0201a6a:	8082                	ret

ffffffffc0201a6c <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a6c:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201a6e:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a70:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201a74:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a76:	352000ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
	if (!page)
ffffffffc0201a7a:	c91d                	beqz	a0,ffffffffc0201ab0 <__slob_get_free_pages.constprop.0+0x44>
    return page - pages + nbase;
ffffffffc0201a7c:	000e5697          	auipc	a3,0xe5
ffffffffc0201a80:	3b46b683          	ld	a3,948(a3) # ffffffffc02e6e30 <pages>
ffffffffc0201a84:	8d15                	sub	a0,a0,a3
ffffffffc0201a86:	8519                	srai	a0,a0,0x6
ffffffffc0201a88:	00007697          	auipc	a3,0x7
ffffffffc0201a8c:	cc06b683          	ld	a3,-832(a3) # ffffffffc0208748 <nbase>
ffffffffc0201a90:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201a92:	00c51793          	slli	a5,a0,0xc
ffffffffc0201a96:	83b1                	srli	a5,a5,0xc
ffffffffc0201a98:	000e5717          	auipc	a4,0xe5
ffffffffc0201a9c:	39073703          	ld	a4,912(a4) # ffffffffc02e6e28 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201aa0:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201aa2:	00e7fa63          	bgeu	a5,a4,ffffffffc0201ab6 <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201aa6:	000e5697          	auipc	a3,0xe5
ffffffffc0201aaa:	39a6b683          	ld	a3,922(a3) # ffffffffc02e6e40 <va_pa_offset>
ffffffffc0201aae:	9536                	add	a0,a0,a3
}
ffffffffc0201ab0:	60a2                	ld	ra,8(sp)
ffffffffc0201ab2:	0141                	addi	sp,sp,16
ffffffffc0201ab4:	8082                	ret
ffffffffc0201ab6:	86aa                	mv	a3,a0
ffffffffc0201ab8:	00005617          	auipc	a2,0x5
ffffffffc0201abc:	1a060613          	addi	a2,a2,416 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0201ac0:	07100593          	li	a1,113
ffffffffc0201ac4:	00005517          	auipc	a0,0x5
ffffffffc0201ac8:	1bc50513          	addi	a0,a0,444 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0201acc:	9c7fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201ad0 <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201ad0:	1101                	addi	sp,sp,-32
ffffffffc0201ad2:	ec06                	sd	ra,24(sp)
ffffffffc0201ad4:	e822                	sd	s0,16(sp)
ffffffffc0201ad6:	e426                	sd	s1,8(sp)
ffffffffc0201ad8:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201ada:	01050713          	addi	a4,a0,16
ffffffffc0201ade:	6785                	lui	a5,0x1
ffffffffc0201ae0:	0cf77363          	bgeu	a4,a5,ffffffffc0201ba6 <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201ae4:	00f50493          	addi	s1,a0,15
ffffffffc0201ae8:	8091                	srli	s1,s1,0x4
ffffffffc0201aea:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201aec:	10002673          	csrr	a2,sstatus
ffffffffc0201af0:	8a09                	andi	a2,a2,2
ffffffffc0201af2:	e25d                	bnez	a2,ffffffffc0201b98 <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201af4:	000e1917          	auipc	s2,0xe1
ffffffffc0201af8:	e9490913          	addi	s2,s2,-364 # ffffffffc02e2988 <slobfree>
ffffffffc0201afc:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201b00:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201b02:	4398                	lw	a4,0(a5)
ffffffffc0201b04:	08975e63          	bge	a4,s1,ffffffffc0201ba0 <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc0201b08:	00f68b63          	beq	a3,a5,ffffffffc0201b1e <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201b0c:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201b0e:	4018                	lw	a4,0(s0)
ffffffffc0201b10:	02975a63          	bge	a4,s1,ffffffffc0201b44 <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201b14:	00093683          	ld	a3,0(s2)
ffffffffc0201b18:	87a2                	mv	a5,s0
ffffffffc0201b1a:	fef699e3          	bne	a3,a5,ffffffffc0201b0c <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201b1e:	ee31                	bnez	a2,ffffffffc0201b7a <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201b20:	4501                	li	a0,0
ffffffffc0201b22:	f4bff0ef          	jal	ra,ffffffffc0201a6c <__slob_get_free_pages.constprop.0>
ffffffffc0201b26:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201b28:	cd05                	beqz	a0,ffffffffc0201b60 <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201b2a:	6585                	lui	a1,0x1
ffffffffc0201b2c:	e8dff0ef          	jal	ra,ffffffffc02019b8 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b30:	10002673          	csrr	a2,sstatus
ffffffffc0201b34:	8a09                	andi	a2,a2,2
ffffffffc0201b36:	ee05                	bnez	a2,ffffffffc0201b6e <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201b38:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201b3c:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201b3e:	4018                	lw	a4,0(s0)
ffffffffc0201b40:	fc974ae3          	blt	a4,s1,ffffffffc0201b14 <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc0201b44:	04e48763          	beq	s1,a4,ffffffffc0201b92 <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201b48:	00449693          	slli	a3,s1,0x4
ffffffffc0201b4c:	96a2                	add	a3,a3,s0
ffffffffc0201b4e:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201b50:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201b52:	9f05                	subw	a4,a4,s1
ffffffffc0201b54:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0201b56:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0201b58:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0201b5a:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc0201b5e:	e20d                	bnez	a2,ffffffffc0201b80 <slob_alloc.constprop.0+0xb0>
}
ffffffffc0201b60:	60e2                	ld	ra,24(sp)
ffffffffc0201b62:	8522                	mv	a0,s0
ffffffffc0201b64:	6442                	ld	s0,16(sp)
ffffffffc0201b66:	64a2                	ld	s1,8(sp)
ffffffffc0201b68:	6902                	ld	s2,0(sp)
ffffffffc0201b6a:	6105                	addi	sp,sp,32
ffffffffc0201b6c:	8082                	ret
        intr_disable();
ffffffffc0201b6e:	e41fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
			cur = slobfree;
ffffffffc0201b72:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0201b76:	4605                	li	a2,1
ffffffffc0201b78:	b7d1                	j	ffffffffc0201b3c <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc0201b7a:	e2ffe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201b7e:	b74d                	j	ffffffffc0201b20 <slob_alloc.constprop.0+0x50>
ffffffffc0201b80:	e29fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
}
ffffffffc0201b84:	60e2                	ld	ra,24(sp)
ffffffffc0201b86:	8522                	mv	a0,s0
ffffffffc0201b88:	6442                	ld	s0,16(sp)
ffffffffc0201b8a:	64a2                	ld	s1,8(sp)
ffffffffc0201b8c:	6902                	ld	s2,0(sp)
ffffffffc0201b8e:	6105                	addi	sp,sp,32
ffffffffc0201b90:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201b92:	6418                	ld	a4,8(s0)
ffffffffc0201b94:	e798                	sd	a4,8(a5)
ffffffffc0201b96:	b7d1                	j	ffffffffc0201b5a <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc0201b98:	e17fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0201b9c:	4605                	li	a2,1
ffffffffc0201b9e:	bf99                	j	ffffffffc0201af4 <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201ba0:	843e                	mv	s0,a5
ffffffffc0201ba2:	87b6                	mv	a5,a3
ffffffffc0201ba4:	b745                	j	ffffffffc0201b44 <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201ba6:	00005697          	auipc	a3,0x5
ffffffffc0201baa:	0ea68693          	addi	a3,a3,234 # ffffffffc0206c90 <default_pmm_manager+0x70>
ffffffffc0201bae:	00005617          	auipc	a2,0x5
ffffffffc0201bb2:	cc260613          	addi	a2,a2,-830 # ffffffffc0206870 <commands+0x850>
ffffffffc0201bb6:	06300593          	li	a1,99
ffffffffc0201bba:	00005517          	auipc	a0,0x5
ffffffffc0201bbe:	0f650513          	addi	a0,a0,246 # ffffffffc0206cb0 <default_pmm_manager+0x90>
ffffffffc0201bc2:	8d1fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201bc6 <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc0201bc6:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc0201bc8:	00005517          	auipc	a0,0x5
ffffffffc0201bcc:	10050513          	addi	a0,a0,256 # ffffffffc0206cc8 <default_pmm_manager+0xa8>
{
ffffffffc0201bd0:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201bd2:	dc6fe0ef          	jal	ra,ffffffffc0200198 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201bd6:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201bd8:	00005517          	auipc	a0,0x5
ffffffffc0201bdc:	10850513          	addi	a0,a0,264 # ffffffffc0206ce0 <default_pmm_manager+0xc0>
}
ffffffffc0201be0:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201be2:	db6fe06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0201be6 <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc0201be6:	4501                	li	a0,0
ffffffffc0201be8:	8082                	ret

ffffffffc0201bea <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201bea:	1101                	addi	sp,sp,-32
ffffffffc0201bec:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bee:	6905                	lui	s2,0x1
{
ffffffffc0201bf0:	e822                	sd	s0,16(sp)
ffffffffc0201bf2:	ec06                	sd	ra,24(sp)
ffffffffc0201bf4:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bf6:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8f79>
{
ffffffffc0201bfa:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bfc:	04a7f963          	bgeu	a5,a0,ffffffffc0201c4e <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201c00:	4561                	li	a0,24
ffffffffc0201c02:	ecfff0ef          	jal	ra,ffffffffc0201ad0 <slob_alloc.constprop.0>
ffffffffc0201c06:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201c08:	c929                	beqz	a0,ffffffffc0201c5a <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201c0a:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201c0e:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201c10:	00f95763          	bge	s2,a5,ffffffffc0201c1e <kmalloc+0x34>
ffffffffc0201c14:	6705                	lui	a4,0x1
ffffffffc0201c16:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201c18:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc0201c1a:	fef74ee3          	blt	a4,a5,ffffffffc0201c16 <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201c1e:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201c20:	e4dff0ef          	jal	ra,ffffffffc0201a6c <__slob_get_free_pages.constprop.0>
ffffffffc0201c24:	e488                	sd	a0,8(s1)
ffffffffc0201c26:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc0201c28:	c525                	beqz	a0,ffffffffc0201c90 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201c2a:	100027f3          	csrr	a5,sstatus
ffffffffc0201c2e:	8b89                	andi	a5,a5,2
ffffffffc0201c30:	ef8d                	bnez	a5,ffffffffc0201c6a <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201c32:	000e5797          	auipc	a5,0xe5
ffffffffc0201c36:	1de78793          	addi	a5,a5,478 # ffffffffc02e6e10 <bigblocks>
ffffffffc0201c3a:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201c3c:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201c3e:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc0201c40:	60e2                	ld	ra,24(sp)
ffffffffc0201c42:	8522                	mv	a0,s0
ffffffffc0201c44:	6442                	ld	s0,16(sp)
ffffffffc0201c46:	64a2                	ld	s1,8(sp)
ffffffffc0201c48:	6902                	ld	s2,0(sp)
ffffffffc0201c4a:	6105                	addi	sp,sp,32
ffffffffc0201c4c:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0201c4e:	0541                	addi	a0,a0,16
ffffffffc0201c50:	e81ff0ef          	jal	ra,ffffffffc0201ad0 <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201c54:	01050413          	addi	s0,a0,16
ffffffffc0201c58:	f565                	bnez	a0,ffffffffc0201c40 <kmalloc+0x56>
ffffffffc0201c5a:	4401                	li	s0,0
}
ffffffffc0201c5c:	60e2                	ld	ra,24(sp)
ffffffffc0201c5e:	8522                	mv	a0,s0
ffffffffc0201c60:	6442                	ld	s0,16(sp)
ffffffffc0201c62:	64a2                	ld	s1,8(sp)
ffffffffc0201c64:	6902                	ld	s2,0(sp)
ffffffffc0201c66:	6105                	addi	sp,sp,32
ffffffffc0201c68:	8082                	ret
        intr_disable();
ffffffffc0201c6a:	d45fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
		bb->next = bigblocks;
ffffffffc0201c6e:	000e5797          	auipc	a5,0xe5
ffffffffc0201c72:	1a278793          	addi	a5,a5,418 # ffffffffc02e6e10 <bigblocks>
ffffffffc0201c76:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201c78:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201c7a:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0201c7c:	d2dfe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
		return bb->pages;
ffffffffc0201c80:	6480                	ld	s0,8(s1)
}
ffffffffc0201c82:	60e2                	ld	ra,24(sp)
ffffffffc0201c84:	64a2                	ld	s1,8(sp)
ffffffffc0201c86:	8522                	mv	a0,s0
ffffffffc0201c88:	6442                	ld	s0,16(sp)
ffffffffc0201c8a:	6902                	ld	s2,0(sp)
ffffffffc0201c8c:	6105                	addi	sp,sp,32
ffffffffc0201c8e:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201c90:	45e1                	li	a1,24
ffffffffc0201c92:	8526                	mv	a0,s1
ffffffffc0201c94:	d25ff0ef          	jal	ra,ffffffffc02019b8 <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201c98:	b765                	j	ffffffffc0201c40 <kmalloc+0x56>

ffffffffc0201c9a <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201c9a:	c169                	beqz	a0,ffffffffc0201d5c <kfree+0xc2>
{
ffffffffc0201c9c:	1101                	addi	sp,sp,-32
ffffffffc0201c9e:	e822                	sd	s0,16(sp)
ffffffffc0201ca0:	ec06                	sd	ra,24(sp)
ffffffffc0201ca2:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201ca4:	03451793          	slli	a5,a0,0x34
ffffffffc0201ca8:	842a                	mv	s0,a0
ffffffffc0201caa:	e3d9                	bnez	a5,ffffffffc0201d30 <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201cac:	100027f3          	csrr	a5,sstatus
ffffffffc0201cb0:	8b89                	andi	a5,a5,2
ffffffffc0201cb2:	e7d9                	bnez	a5,ffffffffc0201d40 <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201cb4:	000e5797          	auipc	a5,0xe5
ffffffffc0201cb8:	15c7b783          	ld	a5,348(a5) # ffffffffc02e6e10 <bigblocks>
    return 0;
ffffffffc0201cbc:	4601                	li	a2,0
ffffffffc0201cbe:	cbad                	beqz	a5,ffffffffc0201d30 <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201cc0:	000e5697          	auipc	a3,0xe5
ffffffffc0201cc4:	15068693          	addi	a3,a3,336 # ffffffffc02e6e10 <bigblocks>
ffffffffc0201cc8:	a021                	j	ffffffffc0201cd0 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201cca:	01048693          	addi	a3,s1,16
ffffffffc0201cce:	c3a5                	beqz	a5,ffffffffc0201d2e <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201cd0:	6798                	ld	a4,8(a5)
ffffffffc0201cd2:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201cd4:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201cd6:	fe871ae3          	bne	a4,s0,ffffffffc0201cca <kfree+0x30>
				*last = bb->next;
ffffffffc0201cda:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201cdc:	ee2d                	bnez	a2,ffffffffc0201d56 <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0201cde:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201ce2:	4098                	lw	a4,0(s1)
ffffffffc0201ce4:	08f46963          	bltu	s0,a5,ffffffffc0201d76 <kfree+0xdc>
ffffffffc0201ce8:	000e5697          	auipc	a3,0xe5
ffffffffc0201cec:	1586b683          	ld	a3,344(a3) # ffffffffc02e6e40 <va_pa_offset>
ffffffffc0201cf0:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201cf2:	8031                	srli	s0,s0,0xc
ffffffffc0201cf4:	000e5797          	auipc	a5,0xe5
ffffffffc0201cf8:	1347b783          	ld	a5,308(a5) # ffffffffc02e6e28 <npage>
ffffffffc0201cfc:	06f47163          	bgeu	s0,a5,ffffffffc0201d5e <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201d00:	00007517          	auipc	a0,0x7
ffffffffc0201d04:	a4853503          	ld	a0,-1464(a0) # ffffffffc0208748 <nbase>
ffffffffc0201d08:	8c09                	sub	s0,s0,a0
ffffffffc0201d0a:	041a                	slli	s0,s0,0x6
	free_pages(kva2page(kva), 1 << order);
ffffffffc0201d0c:	000e5517          	auipc	a0,0xe5
ffffffffc0201d10:	12453503          	ld	a0,292(a0) # ffffffffc02e6e30 <pages>
ffffffffc0201d14:	4585                	li	a1,1
ffffffffc0201d16:	9522                	add	a0,a0,s0
ffffffffc0201d18:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201d1c:	0ea000ef          	jal	ra,ffffffffc0201e06 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201d20:	6442                	ld	s0,16(sp)
ffffffffc0201d22:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201d24:	8526                	mv	a0,s1
}
ffffffffc0201d26:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201d28:	45e1                	li	a1,24
}
ffffffffc0201d2a:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201d2c:	b171                	j	ffffffffc02019b8 <slob_free>
ffffffffc0201d2e:	e20d                	bnez	a2,ffffffffc0201d50 <kfree+0xb6>
ffffffffc0201d30:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201d34:	6442                	ld	s0,16(sp)
ffffffffc0201d36:	60e2                	ld	ra,24(sp)
ffffffffc0201d38:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201d3a:	4581                	li	a1,0
}
ffffffffc0201d3c:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201d3e:	b9ad                	j	ffffffffc02019b8 <slob_free>
        intr_disable();
ffffffffc0201d40:	c6ffe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d44:	000e5797          	auipc	a5,0xe5
ffffffffc0201d48:	0cc7b783          	ld	a5,204(a5) # ffffffffc02e6e10 <bigblocks>
        return 1;
ffffffffc0201d4c:	4605                	li	a2,1
ffffffffc0201d4e:	fbad                	bnez	a5,ffffffffc0201cc0 <kfree+0x26>
        intr_enable();
ffffffffc0201d50:	c59fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201d54:	bff1                	j	ffffffffc0201d30 <kfree+0x96>
ffffffffc0201d56:	c53fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201d5a:	b751                	j	ffffffffc0201cde <kfree+0x44>
ffffffffc0201d5c:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201d5e:	00005617          	auipc	a2,0x5
ffffffffc0201d62:	fca60613          	addi	a2,a2,-54 # ffffffffc0206d28 <default_pmm_manager+0x108>
ffffffffc0201d66:	06900593          	li	a1,105
ffffffffc0201d6a:	00005517          	auipc	a0,0x5
ffffffffc0201d6e:	f1650513          	addi	a0,a0,-234 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0201d72:	f20fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201d76:	86a2                	mv	a3,s0
ffffffffc0201d78:	00005617          	auipc	a2,0x5
ffffffffc0201d7c:	f8860613          	addi	a2,a2,-120 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc0201d80:	07700593          	li	a1,119
ffffffffc0201d84:	00005517          	auipc	a0,0x5
ffffffffc0201d88:	efc50513          	addi	a0,a0,-260 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0201d8c:	f06fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201d90 <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc0201d90:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0201d92:	00005617          	auipc	a2,0x5
ffffffffc0201d96:	f9660613          	addi	a2,a2,-106 # ffffffffc0206d28 <default_pmm_manager+0x108>
ffffffffc0201d9a:	06900593          	li	a1,105
ffffffffc0201d9e:	00005517          	auipc	a0,0x5
ffffffffc0201da2:	ee250513          	addi	a0,a0,-286 # ffffffffc0206c80 <default_pmm_manager+0x60>
pa2page(uintptr_t pa)
ffffffffc0201da6:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0201da8:	eeafe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201dac <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc0201dac:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc0201dae:	00005617          	auipc	a2,0x5
ffffffffc0201db2:	f9a60613          	addi	a2,a2,-102 # ffffffffc0206d48 <default_pmm_manager+0x128>
ffffffffc0201db6:	07f00593          	li	a1,127
ffffffffc0201dba:	00005517          	auipc	a0,0x5
ffffffffc0201dbe:	ec650513          	addi	a0,a0,-314 # ffffffffc0206c80 <default_pmm_manager+0x60>
pte2page(pte_t pte)
ffffffffc0201dc2:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc0201dc4:	ecefe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201dc8 <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201dc8:	100027f3          	csrr	a5,sstatus
ffffffffc0201dcc:	8b89                	andi	a5,a5,2
ffffffffc0201dce:	e799                	bnez	a5,ffffffffc0201ddc <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc0201dd0:	000e5797          	auipc	a5,0xe5
ffffffffc0201dd4:	0687b783          	ld	a5,104(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201dd8:	6f9c                	ld	a5,24(a5)
ffffffffc0201dda:	8782                	jr	a5
{
ffffffffc0201ddc:	1141                	addi	sp,sp,-16
ffffffffc0201dde:	e406                	sd	ra,8(sp)
ffffffffc0201de0:	e022                	sd	s0,0(sp)
ffffffffc0201de2:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201de4:	bcbfe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201de8:	000e5797          	auipc	a5,0xe5
ffffffffc0201dec:	0507b783          	ld	a5,80(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201df0:	6f9c                	ld	a5,24(a5)
ffffffffc0201df2:	8522                	mv	a0,s0
ffffffffc0201df4:	9782                	jalr	a5
ffffffffc0201df6:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201df8:	bb1fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc0201dfc:	60a2                	ld	ra,8(sp)
ffffffffc0201dfe:	8522                	mv	a0,s0
ffffffffc0201e00:	6402                	ld	s0,0(sp)
ffffffffc0201e02:	0141                	addi	sp,sp,16
ffffffffc0201e04:	8082                	ret

ffffffffc0201e06 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201e06:	100027f3          	csrr	a5,sstatus
ffffffffc0201e0a:	8b89                	andi	a5,a5,2
ffffffffc0201e0c:	e799                	bnez	a5,ffffffffc0201e1a <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201e0e:	000e5797          	auipc	a5,0xe5
ffffffffc0201e12:	02a7b783          	ld	a5,42(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201e16:	739c                	ld	a5,32(a5)
ffffffffc0201e18:	8782                	jr	a5
{
ffffffffc0201e1a:	1101                	addi	sp,sp,-32
ffffffffc0201e1c:	ec06                	sd	ra,24(sp)
ffffffffc0201e1e:	e822                	sd	s0,16(sp)
ffffffffc0201e20:	e426                	sd	s1,8(sp)
ffffffffc0201e22:	842a                	mv	s0,a0
ffffffffc0201e24:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0201e26:	b89fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201e2a:	000e5797          	auipc	a5,0xe5
ffffffffc0201e2e:	00e7b783          	ld	a5,14(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201e32:	739c                	ld	a5,32(a5)
ffffffffc0201e34:	85a6                	mv	a1,s1
ffffffffc0201e36:	8522                	mv	a0,s0
ffffffffc0201e38:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201e3a:	6442                	ld	s0,16(sp)
ffffffffc0201e3c:	60e2                	ld	ra,24(sp)
ffffffffc0201e3e:	64a2                	ld	s1,8(sp)
ffffffffc0201e40:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201e42:	b67fe06f          	j	ffffffffc02009a8 <intr_enable>

ffffffffc0201e46 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201e46:	100027f3          	csrr	a5,sstatus
ffffffffc0201e4a:	8b89                	andi	a5,a5,2
ffffffffc0201e4c:	e799                	bnez	a5,ffffffffc0201e5a <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201e4e:	000e5797          	auipc	a5,0xe5
ffffffffc0201e52:	fea7b783          	ld	a5,-22(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201e56:	779c                	ld	a5,40(a5)
ffffffffc0201e58:	8782                	jr	a5
{
ffffffffc0201e5a:	1141                	addi	sp,sp,-16
ffffffffc0201e5c:	e406                	sd	ra,8(sp)
ffffffffc0201e5e:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201e60:	b4ffe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201e64:	000e5797          	auipc	a5,0xe5
ffffffffc0201e68:	fd47b783          	ld	a5,-44(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201e6c:	779c                	ld	a5,40(a5)
ffffffffc0201e6e:	9782                	jalr	a5
ffffffffc0201e70:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201e72:	b37fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201e76:	60a2                	ld	ra,8(sp)
ffffffffc0201e78:	8522                	mv	a0,s0
ffffffffc0201e7a:	6402                	ld	s0,0(sp)
ffffffffc0201e7c:	0141                	addi	sp,sp,16
ffffffffc0201e7e:	8082                	ret

ffffffffc0201e80 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e80:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0201e84:	1ff7f793          	andi	a5,a5,511
{
ffffffffc0201e88:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e8a:	078e                	slli	a5,a5,0x3
{
ffffffffc0201e8c:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e8e:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc0201e92:	6094                	ld	a3,0(s1)
{
ffffffffc0201e94:	f04a                	sd	s2,32(sp)
ffffffffc0201e96:	ec4e                	sd	s3,24(sp)
ffffffffc0201e98:	e852                	sd	s4,16(sp)
ffffffffc0201e9a:	fc06                	sd	ra,56(sp)
ffffffffc0201e9c:	f822                	sd	s0,48(sp)
ffffffffc0201e9e:	e456                	sd	s5,8(sp)
ffffffffc0201ea0:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc0201ea2:	0016f793          	andi	a5,a3,1
{
ffffffffc0201ea6:	892e                	mv	s2,a1
ffffffffc0201ea8:	8a32                	mv	s4,a2
ffffffffc0201eaa:	000e5997          	auipc	s3,0xe5
ffffffffc0201eae:	f7e98993          	addi	s3,s3,-130 # ffffffffc02e6e28 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc0201eb2:	efbd                	bnez	a5,ffffffffc0201f30 <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201eb4:	14060c63          	beqz	a2,ffffffffc020200c <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201eb8:	100027f3          	csrr	a5,sstatus
ffffffffc0201ebc:	8b89                	andi	a5,a5,2
ffffffffc0201ebe:	14079963          	bnez	a5,ffffffffc0202010 <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201ec2:	000e5797          	auipc	a5,0xe5
ffffffffc0201ec6:	f767b783          	ld	a5,-138(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201eca:	6f9c                	ld	a5,24(a5)
ffffffffc0201ecc:	4505                	li	a0,1
ffffffffc0201ece:	9782                	jalr	a5
ffffffffc0201ed0:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201ed2:	12040d63          	beqz	s0,ffffffffc020200c <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201ed6:	000e5b17          	auipc	s6,0xe5
ffffffffc0201eda:	f5ab0b13          	addi	s6,s6,-166 # ffffffffc02e6e30 <pages>
ffffffffc0201ede:	000b3503          	ld	a0,0(s6)
ffffffffc0201ee2:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201ee6:	000e5997          	auipc	s3,0xe5
ffffffffc0201eea:	f4298993          	addi	s3,s3,-190 # ffffffffc02e6e28 <npage>
ffffffffc0201eee:	40a40533          	sub	a0,s0,a0
ffffffffc0201ef2:	8519                	srai	a0,a0,0x6
ffffffffc0201ef4:	9556                	add	a0,a0,s5
ffffffffc0201ef6:	0009b703          	ld	a4,0(s3)
ffffffffc0201efa:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201efe:	4685                	li	a3,1
ffffffffc0201f00:	c014                	sw	a3,0(s0)
ffffffffc0201f02:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201f04:	0532                	slli	a0,a0,0xc
ffffffffc0201f06:	16e7f763          	bgeu	a5,a4,ffffffffc0202074 <get_pte+0x1f4>
ffffffffc0201f0a:	000e5797          	auipc	a5,0xe5
ffffffffc0201f0e:	f367b783          	ld	a5,-202(a5) # ffffffffc02e6e40 <va_pa_offset>
ffffffffc0201f12:	6605                	lui	a2,0x1
ffffffffc0201f14:	4581                	li	a1,0
ffffffffc0201f16:	953e                	add	a0,a0,a5
ffffffffc0201f18:	673030ef          	jal	ra,ffffffffc0205d8a <memset>
    return page - pages + nbase;
ffffffffc0201f1c:	000b3683          	ld	a3,0(s6)
ffffffffc0201f20:	40d406b3          	sub	a3,s0,a3
ffffffffc0201f24:	8699                	srai	a3,a3,0x6
ffffffffc0201f26:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201f28:	06aa                	slli	a3,a3,0xa
ffffffffc0201f2a:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201f2e:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201f30:	77fd                	lui	a5,0xfffff
ffffffffc0201f32:	068a                	slli	a3,a3,0x2
ffffffffc0201f34:	0009b703          	ld	a4,0(s3)
ffffffffc0201f38:	8efd                	and	a3,a3,a5
ffffffffc0201f3a:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201f3e:	10e7ff63          	bgeu	a5,a4,ffffffffc020205c <get_pte+0x1dc>
ffffffffc0201f42:	000e5a97          	auipc	s5,0xe5
ffffffffc0201f46:	efea8a93          	addi	s5,s5,-258 # ffffffffc02e6e40 <va_pa_offset>
ffffffffc0201f4a:	000ab403          	ld	s0,0(s5)
ffffffffc0201f4e:	01595793          	srli	a5,s2,0x15
ffffffffc0201f52:	1ff7f793          	andi	a5,a5,511
ffffffffc0201f56:	96a2                	add	a3,a3,s0
ffffffffc0201f58:	00379413          	slli	s0,a5,0x3
ffffffffc0201f5c:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc0201f5e:	6014                	ld	a3,0(s0)
ffffffffc0201f60:	0016f793          	andi	a5,a3,1
ffffffffc0201f64:	ebad                	bnez	a5,ffffffffc0201fd6 <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f66:	0a0a0363          	beqz	s4,ffffffffc020200c <get_pte+0x18c>
ffffffffc0201f6a:	100027f3          	csrr	a5,sstatus
ffffffffc0201f6e:	8b89                	andi	a5,a5,2
ffffffffc0201f70:	efcd                	bnez	a5,ffffffffc020202a <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201f72:	000e5797          	auipc	a5,0xe5
ffffffffc0201f76:	ec67b783          	ld	a5,-314(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0201f7a:	6f9c                	ld	a5,24(a5)
ffffffffc0201f7c:	4505                	li	a0,1
ffffffffc0201f7e:	9782                	jalr	a5
ffffffffc0201f80:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f82:	c4c9                	beqz	s1,ffffffffc020200c <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201f84:	000e5b17          	auipc	s6,0xe5
ffffffffc0201f88:	eacb0b13          	addi	s6,s6,-340 # ffffffffc02e6e30 <pages>
ffffffffc0201f8c:	000b3503          	ld	a0,0(s6)
ffffffffc0201f90:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201f94:	0009b703          	ld	a4,0(s3)
ffffffffc0201f98:	40a48533          	sub	a0,s1,a0
ffffffffc0201f9c:	8519                	srai	a0,a0,0x6
ffffffffc0201f9e:	9552                	add	a0,a0,s4
ffffffffc0201fa0:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201fa4:	4685                	li	a3,1
ffffffffc0201fa6:	c094                	sw	a3,0(s1)
ffffffffc0201fa8:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201faa:	0532                	slli	a0,a0,0xc
ffffffffc0201fac:	0ee7f163          	bgeu	a5,a4,ffffffffc020208e <get_pte+0x20e>
ffffffffc0201fb0:	000ab783          	ld	a5,0(s5)
ffffffffc0201fb4:	6605                	lui	a2,0x1
ffffffffc0201fb6:	4581                	li	a1,0
ffffffffc0201fb8:	953e                	add	a0,a0,a5
ffffffffc0201fba:	5d1030ef          	jal	ra,ffffffffc0205d8a <memset>
    return page - pages + nbase;
ffffffffc0201fbe:	000b3683          	ld	a3,0(s6)
ffffffffc0201fc2:	40d486b3          	sub	a3,s1,a3
ffffffffc0201fc6:	8699                	srai	a3,a3,0x6
ffffffffc0201fc8:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201fca:	06aa                	slli	a3,a3,0xa
ffffffffc0201fcc:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201fd0:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0201fd2:	0009b703          	ld	a4,0(s3)
ffffffffc0201fd6:	068a                	slli	a3,a3,0x2
ffffffffc0201fd8:	757d                	lui	a0,0xfffff
ffffffffc0201fda:	8ee9                	and	a3,a3,a0
ffffffffc0201fdc:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201fe0:	06e7f263          	bgeu	a5,a4,ffffffffc0202044 <get_pte+0x1c4>
ffffffffc0201fe4:	000ab503          	ld	a0,0(s5)
ffffffffc0201fe8:	00c95913          	srli	s2,s2,0xc
ffffffffc0201fec:	1ff97913          	andi	s2,s2,511
ffffffffc0201ff0:	96aa                	add	a3,a3,a0
ffffffffc0201ff2:	00391513          	slli	a0,s2,0x3
ffffffffc0201ff6:	9536                	add	a0,a0,a3
}
ffffffffc0201ff8:	70e2                	ld	ra,56(sp)
ffffffffc0201ffa:	7442                	ld	s0,48(sp)
ffffffffc0201ffc:	74a2                	ld	s1,40(sp)
ffffffffc0201ffe:	7902                	ld	s2,32(sp)
ffffffffc0202000:	69e2                	ld	s3,24(sp)
ffffffffc0202002:	6a42                	ld	s4,16(sp)
ffffffffc0202004:	6aa2                	ld	s5,8(sp)
ffffffffc0202006:	6b02                	ld	s6,0(sp)
ffffffffc0202008:	6121                	addi	sp,sp,64
ffffffffc020200a:	8082                	ret
            return NULL;
ffffffffc020200c:	4501                	li	a0,0
ffffffffc020200e:	b7ed                	j	ffffffffc0201ff8 <get_pte+0x178>
        intr_disable();
ffffffffc0202010:	99ffe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202014:	000e5797          	auipc	a5,0xe5
ffffffffc0202018:	e247b783          	ld	a5,-476(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc020201c:	6f9c                	ld	a5,24(a5)
ffffffffc020201e:	4505                	li	a0,1
ffffffffc0202020:	9782                	jalr	a5
ffffffffc0202022:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202024:	985fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202028:	b56d                	j	ffffffffc0201ed2 <get_pte+0x52>
        intr_disable();
ffffffffc020202a:	985fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc020202e:	000e5797          	auipc	a5,0xe5
ffffffffc0202032:	e0a7b783          	ld	a5,-502(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0202036:	6f9c                	ld	a5,24(a5)
ffffffffc0202038:	4505                	li	a0,1
ffffffffc020203a:	9782                	jalr	a5
ffffffffc020203c:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc020203e:	96bfe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202042:	b781                	j	ffffffffc0201f82 <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202044:	00005617          	auipc	a2,0x5
ffffffffc0202048:	c1460613          	addi	a2,a2,-1004 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc020204c:	0fa00593          	li	a1,250
ffffffffc0202050:	00005517          	auipc	a0,0x5
ffffffffc0202054:	d2050513          	addi	a0,a0,-736 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202058:	c3afe0ef          	jal	ra,ffffffffc0200492 <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc020205c:	00005617          	auipc	a2,0x5
ffffffffc0202060:	bfc60613          	addi	a2,a2,-1028 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0202064:	0ed00593          	li	a1,237
ffffffffc0202068:	00005517          	auipc	a0,0x5
ffffffffc020206c:	d0850513          	addi	a0,a0,-760 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202070:	c22fe0ef          	jal	ra,ffffffffc0200492 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202074:	86aa                	mv	a3,a0
ffffffffc0202076:	00005617          	auipc	a2,0x5
ffffffffc020207a:	be260613          	addi	a2,a2,-1054 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc020207e:	0e900593          	li	a1,233
ffffffffc0202082:	00005517          	auipc	a0,0x5
ffffffffc0202086:	cee50513          	addi	a0,a0,-786 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc020208a:	c08fe0ef          	jal	ra,ffffffffc0200492 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020208e:	86aa                	mv	a3,a0
ffffffffc0202090:	00005617          	auipc	a2,0x5
ffffffffc0202094:	bc860613          	addi	a2,a2,-1080 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0202098:	0f700593          	li	a1,247
ffffffffc020209c:	00005517          	auipc	a0,0x5
ffffffffc02020a0:	cd450513          	addi	a0,a0,-812 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02020a4:	beefe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02020a8 <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc02020a8:	1141                	addi	sp,sp,-16
ffffffffc02020aa:	e022                	sd	s0,0(sp)
ffffffffc02020ac:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02020ae:	4601                	li	a2,0
{
ffffffffc02020b0:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02020b2:	dcfff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
    if (ptep_store != NULL)
ffffffffc02020b6:	c011                	beqz	s0,ffffffffc02020ba <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc02020b8:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc02020ba:	c511                	beqz	a0,ffffffffc02020c6 <get_page+0x1e>
ffffffffc02020bc:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc02020be:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc02020c0:	0017f713          	andi	a4,a5,1
ffffffffc02020c4:	e709                	bnez	a4,ffffffffc02020ce <get_page+0x26>
}
ffffffffc02020c6:	60a2                	ld	ra,8(sp)
ffffffffc02020c8:	6402                	ld	s0,0(sp)
ffffffffc02020ca:	0141                	addi	sp,sp,16
ffffffffc02020cc:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02020ce:	078a                	slli	a5,a5,0x2
ffffffffc02020d0:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02020d2:	000e5717          	auipc	a4,0xe5
ffffffffc02020d6:	d5673703          	ld	a4,-682(a4) # ffffffffc02e6e28 <npage>
ffffffffc02020da:	00e7ff63          	bgeu	a5,a4,ffffffffc02020f8 <get_page+0x50>
ffffffffc02020de:	60a2                	ld	ra,8(sp)
ffffffffc02020e0:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc02020e2:	fff80537          	lui	a0,0xfff80
ffffffffc02020e6:	97aa                	add	a5,a5,a0
ffffffffc02020e8:	079a                	slli	a5,a5,0x6
ffffffffc02020ea:	000e5517          	auipc	a0,0xe5
ffffffffc02020ee:	d4653503          	ld	a0,-698(a0) # ffffffffc02e6e30 <pages>
ffffffffc02020f2:	953e                	add	a0,a0,a5
ffffffffc02020f4:	0141                	addi	sp,sp,16
ffffffffc02020f6:	8082                	ret
ffffffffc02020f8:	c99ff0ef          	jal	ra,ffffffffc0201d90 <pa2page.part.0>

ffffffffc02020fc <unmap_range>:
        tlb_invalidate(pgdir, la); //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc02020fc:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02020fe:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202102:	f486                	sd	ra,104(sp)
ffffffffc0202104:	f0a2                	sd	s0,96(sp)
ffffffffc0202106:	eca6                	sd	s1,88(sp)
ffffffffc0202108:	e8ca                	sd	s2,80(sp)
ffffffffc020210a:	e4ce                	sd	s3,72(sp)
ffffffffc020210c:	e0d2                	sd	s4,64(sp)
ffffffffc020210e:	fc56                	sd	s5,56(sp)
ffffffffc0202110:	f85a                	sd	s6,48(sp)
ffffffffc0202112:	f45e                	sd	s7,40(sp)
ffffffffc0202114:	f062                	sd	s8,32(sp)
ffffffffc0202116:	ec66                	sd	s9,24(sp)
ffffffffc0202118:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020211a:	17d2                	slli	a5,a5,0x34
ffffffffc020211c:	e3ed                	bnez	a5,ffffffffc02021fe <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc020211e:	002007b7          	lui	a5,0x200
ffffffffc0202122:	842e                	mv	s0,a1
ffffffffc0202124:	0ef5ed63          	bltu	a1,a5,ffffffffc020221e <unmap_range+0x122>
ffffffffc0202128:	8932                	mv	s2,a2
ffffffffc020212a:	0ec5fa63          	bgeu	a1,a2,ffffffffc020221e <unmap_range+0x122>
ffffffffc020212e:	4785                	li	a5,1
ffffffffc0202130:	07fe                	slli	a5,a5,0x1f
ffffffffc0202132:	0ec7e663          	bltu	a5,a2,ffffffffc020221e <unmap_range+0x122>
ffffffffc0202136:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc0202138:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc020213a:	000e5c97          	auipc	s9,0xe5
ffffffffc020213e:	ceec8c93          	addi	s9,s9,-786 # ffffffffc02e6e28 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202142:	000e5c17          	auipc	s8,0xe5
ffffffffc0202146:	ceec0c13          	addi	s8,s8,-786 # ffffffffc02e6e30 <pages>
ffffffffc020214a:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc020214e:	000e5d17          	auipc	s10,0xe5
ffffffffc0202152:	cead0d13          	addi	s10,s10,-790 # ffffffffc02e6e38 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202156:	00200b37          	lui	s6,0x200
ffffffffc020215a:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc020215e:	4601                	li	a2,0
ffffffffc0202160:	85a2                	mv	a1,s0
ffffffffc0202162:	854e                	mv	a0,s3
ffffffffc0202164:	d1dff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
ffffffffc0202168:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc020216a:	cd29                	beqz	a0,ffffffffc02021c4 <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc020216c:	611c                	ld	a5,0(a0)
ffffffffc020216e:	e395                	bnez	a5,ffffffffc0202192 <unmap_range+0x96>
        start += PGSIZE;
ffffffffc0202170:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202172:	ff2466e3          	bltu	s0,s2,ffffffffc020215e <unmap_range+0x62>
}
ffffffffc0202176:	70a6                	ld	ra,104(sp)
ffffffffc0202178:	7406                	ld	s0,96(sp)
ffffffffc020217a:	64e6                	ld	s1,88(sp)
ffffffffc020217c:	6946                	ld	s2,80(sp)
ffffffffc020217e:	69a6                	ld	s3,72(sp)
ffffffffc0202180:	6a06                	ld	s4,64(sp)
ffffffffc0202182:	7ae2                	ld	s5,56(sp)
ffffffffc0202184:	7b42                	ld	s6,48(sp)
ffffffffc0202186:	7ba2                	ld	s7,40(sp)
ffffffffc0202188:	7c02                	ld	s8,32(sp)
ffffffffc020218a:	6ce2                	ld	s9,24(sp)
ffffffffc020218c:	6d42                	ld	s10,16(sp)
ffffffffc020218e:	6165                	addi	sp,sp,112
ffffffffc0202190:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc0202192:	0017f713          	andi	a4,a5,1
ffffffffc0202196:	df69                	beqz	a4,ffffffffc0202170 <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc0202198:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc020219c:	078a                	slli	a5,a5,0x2
ffffffffc020219e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02021a0:	08e7ff63          	bgeu	a5,a4,ffffffffc020223e <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc02021a4:	000c3503          	ld	a0,0(s8)
ffffffffc02021a8:	97de                	add	a5,a5,s7
ffffffffc02021aa:	079a                	slli	a5,a5,0x6
ffffffffc02021ac:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc02021ae:	411c                	lw	a5,0(a0)
ffffffffc02021b0:	fff7871b          	addiw	a4,a5,-1
ffffffffc02021b4:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc02021b6:	cf11                	beqz	a4,ffffffffc02021d2 <unmap_range+0xd6>
        *ptep = 0;                 //(5) clear second page table entry
ffffffffc02021b8:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02021bc:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc02021c0:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02021c2:	bf45                	j	ffffffffc0202172 <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02021c4:	945a                	add	s0,s0,s6
ffffffffc02021c6:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc02021ca:	d455                	beqz	s0,ffffffffc0202176 <unmap_range+0x7a>
ffffffffc02021cc:	f92469e3          	bltu	s0,s2,ffffffffc020215e <unmap_range+0x62>
ffffffffc02021d0:	b75d                	j	ffffffffc0202176 <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02021d2:	100027f3          	csrr	a5,sstatus
ffffffffc02021d6:	8b89                	andi	a5,a5,2
ffffffffc02021d8:	e799                	bnez	a5,ffffffffc02021e6 <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc02021da:	000d3783          	ld	a5,0(s10)
ffffffffc02021de:	4585                	li	a1,1
ffffffffc02021e0:	739c                	ld	a5,32(a5)
ffffffffc02021e2:	9782                	jalr	a5
    if (flag)
ffffffffc02021e4:	bfd1                	j	ffffffffc02021b8 <unmap_range+0xbc>
ffffffffc02021e6:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02021e8:	fc6fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02021ec:	000d3783          	ld	a5,0(s10)
ffffffffc02021f0:	6522                	ld	a0,8(sp)
ffffffffc02021f2:	4585                	li	a1,1
ffffffffc02021f4:	739c                	ld	a5,32(a5)
ffffffffc02021f6:	9782                	jalr	a5
        intr_enable();
ffffffffc02021f8:	fb0fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02021fc:	bf75                	j	ffffffffc02021b8 <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021fe:	00005697          	auipc	a3,0x5
ffffffffc0202202:	b8268693          	addi	a3,a3,-1150 # ffffffffc0206d80 <default_pmm_manager+0x160>
ffffffffc0202206:	00004617          	auipc	a2,0x4
ffffffffc020220a:	66a60613          	addi	a2,a2,1642 # ffffffffc0206870 <commands+0x850>
ffffffffc020220e:	12200593          	li	a1,290
ffffffffc0202212:	00005517          	auipc	a0,0x5
ffffffffc0202216:	b5e50513          	addi	a0,a0,-1186 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc020221a:	a78fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc020221e:	00005697          	auipc	a3,0x5
ffffffffc0202222:	b9268693          	addi	a3,a3,-1134 # ffffffffc0206db0 <default_pmm_manager+0x190>
ffffffffc0202226:	00004617          	auipc	a2,0x4
ffffffffc020222a:	64a60613          	addi	a2,a2,1610 # ffffffffc0206870 <commands+0x850>
ffffffffc020222e:	12300593          	li	a1,291
ffffffffc0202232:	00005517          	auipc	a0,0x5
ffffffffc0202236:	b3e50513          	addi	a0,a0,-1218 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc020223a:	a58fe0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc020223e:	b53ff0ef          	jal	ra,ffffffffc0201d90 <pa2page.part.0>

ffffffffc0202242 <exit_range>:
{
ffffffffc0202242:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202244:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202248:	fc86                	sd	ra,120(sp)
ffffffffc020224a:	f8a2                	sd	s0,112(sp)
ffffffffc020224c:	f4a6                	sd	s1,104(sp)
ffffffffc020224e:	f0ca                	sd	s2,96(sp)
ffffffffc0202250:	ecce                	sd	s3,88(sp)
ffffffffc0202252:	e8d2                	sd	s4,80(sp)
ffffffffc0202254:	e4d6                	sd	s5,72(sp)
ffffffffc0202256:	e0da                	sd	s6,64(sp)
ffffffffc0202258:	fc5e                	sd	s7,56(sp)
ffffffffc020225a:	f862                	sd	s8,48(sp)
ffffffffc020225c:	f466                	sd	s9,40(sp)
ffffffffc020225e:	f06a                	sd	s10,32(sp)
ffffffffc0202260:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202262:	17d2                	slli	a5,a5,0x34
ffffffffc0202264:	20079a63          	bnez	a5,ffffffffc0202478 <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc0202268:	002007b7          	lui	a5,0x200
ffffffffc020226c:	24f5e463          	bltu	a1,a5,ffffffffc02024b4 <exit_range+0x272>
ffffffffc0202270:	8ab2                	mv	s5,a2
ffffffffc0202272:	24c5f163          	bgeu	a1,a2,ffffffffc02024b4 <exit_range+0x272>
ffffffffc0202276:	4785                	li	a5,1
ffffffffc0202278:	07fe                	slli	a5,a5,0x1f
ffffffffc020227a:	22c7ed63          	bltu	a5,a2,ffffffffc02024b4 <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc020227e:	c00009b7          	lui	s3,0xc0000
ffffffffc0202282:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202286:	ffe00937          	lui	s2,0xffe00
ffffffffc020228a:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc020228e:	5cfd                	li	s9,-1
ffffffffc0202290:	8c2a                	mv	s8,a0
ffffffffc0202292:	0125f933          	and	s2,a1,s2
ffffffffc0202296:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc0202298:	000e5d17          	auipc	s10,0xe5
ffffffffc020229c:	b90d0d13          	addi	s10,s10,-1136 # ffffffffc02e6e28 <npage>
    return KADDR(page2pa(page));
ffffffffc02022a0:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc02022a4:	000e5717          	auipc	a4,0xe5
ffffffffc02022a8:	b8c70713          	addi	a4,a4,-1140 # ffffffffc02e6e30 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc02022ac:	000e5d97          	auipc	s11,0xe5
ffffffffc02022b0:	b8cd8d93          	addi	s11,s11,-1140 # ffffffffc02e6e38 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc02022b4:	c0000437          	lui	s0,0xc0000
ffffffffc02022b8:	944e                	add	s0,s0,s3
ffffffffc02022ba:	8079                	srli	s0,s0,0x1e
ffffffffc02022bc:	1ff47413          	andi	s0,s0,511
ffffffffc02022c0:	040e                	slli	s0,s0,0x3
ffffffffc02022c2:	9462                	add	s0,s0,s8
ffffffffc02022c4:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_matrix_out_size+0xffffffffbfff38c8>
        if (pde1 & PTE_V)
ffffffffc02022c8:	001a7793          	andi	a5,s4,1
ffffffffc02022cc:	eb99                	bnez	a5,ffffffffc02022e2 <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc02022ce:	12098463          	beqz	s3,ffffffffc02023f6 <exit_range+0x1b4>
ffffffffc02022d2:	400007b7          	lui	a5,0x40000
ffffffffc02022d6:	97ce                	add	a5,a5,s3
ffffffffc02022d8:	894e                	mv	s2,s3
ffffffffc02022da:	1159fe63          	bgeu	s3,s5,ffffffffc02023f6 <exit_range+0x1b4>
ffffffffc02022de:	89be                	mv	s3,a5
ffffffffc02022e0:	bfd1                	j	ffffffffc02022b4 <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc02022e2:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc02022e6:	0a0a                	slli	s4,s4,0x2
ffffffffc02022e8:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc02022ec:	1cfa7263          	bgeu	s4,a5,ffffffffc02024b0 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02022f0:	fff80637          	lui	a2,0xfff80
ffffffffc02022f4:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc02022f6:	000806b7          	lui	a3,0x80
ffffffffc02022fa:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02022fc:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc0202300:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202302:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202304:	18f5fa63          	bgeu	a1,a5,ffffffffc0202498 <exit_range+0x256>
ffffffffc0202308:	000e5817          	auipc	a6,0xe5
ffffffffc020230c:	b3880813          	addi	a6,a6,-1224 # ffffffffc02e6e40 <va_pa_offset>
ffffffffc0202310:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc0202314:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc0202316:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc020231a:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc020231c:	00080337          	lui	t1,0x80
ffffffffc0202320:	6885                	lui	a7,0x1
ffffffffc0202322:	a819                	j	ffffffffc0202338 <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc0202324:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc0202326:	002007b7          	lui	a5,0x200
ffffffffc020232a:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc020232c:	08090c63          	beqz	s2,ffffffffc02023c4 <exit_range+0x182>
ffffffffc0202330:	09397a63          	bgeu	s2,s3,ffffffffc02023c4 <exit_range+0x182>
ffffffffc0202334:	0f597063          	bgeu	s2,s5,ffffffffc0202414 <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc0202338:	01595493          	srli	s1,s2,0x15
ffffffffc020233c:	1ff4f493          	andi	s1,s1,511
ffffffffc0202340:	048e                	slli	s1,s1,0x3
ffffffffc0202342:	94da                	add	s1,s1,s6
ffffffffc0202344:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc0202346:	0017f693          	andi	a3,a5,1
ffffffffc020234a:	dee9                	beqz	a3,ffffffffc0202324 <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc020234c:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202350:	078a                	slli	a5,a5,0x2
ffffffffc0202352:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202354:	14b7fe63          	bgeu	a5,a1,ffffffffc02024b0 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202358:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc020235a:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc020235e:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc0202362:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202366:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202368:	12bef863          	bgeu	t4,a1,ffffffffc0202498 <exit_range+0x256>
ffffffffc020236c:	00083783          	ld	a5,0(a6)
ffffffffc0202370:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202372:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc0202376:	629c                	ld	a5,0(a3)
ffffffffc0202378:	8b85                	andi	a5,a5,1
ffffffffc020237a:	f7d5                	bnez	a5,ffffffffc0202326 <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc020237c:	06a1                	addi	a3,a3,8
ffffffffc020237e:	fed59ce3          	bne	a1,a3,ffffffffc0202376 <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc0202382:	631c                	ld	a5,0(a4)
ffffffffc0202384:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202386:	100027f3          	csrr	a5,sstatus
ffffffffc020238a:	8b89                	andi	a5,a5,2
ffffffffc020238c:	e7d9                	bnez	a5,ffffffffc020241a <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc020238e:	000db783          	ld	a5,0(s11)
ffffffffc0202392:	4585                	li	a1,1
ffffffffc0202394:	e032                	sd	a2,0(sp)
ffffffffc0202396:	739c                	ld	a5,32(a5)
ffffffffc0202398:	9782                	jalr	a5
    if (flag)
ffffffffc020239a:	6602                	ld	a2,0(sp)
ffffffffc020239c:	000e5817          	auipc	a6,0xe5
ffffffffc02023a0:	aa480813          	addi	a6,a6,-1372 # ffffffffc02e6e40 <va_pa_offset>
ffffffffc02023a4:	fff80e37          	lui	t3,0xfff80
ffffffffc02023a8:	00080337          	lui	t1,0x80
ffffffffc02023ac:	6885                	lui	a7,0x1
ffffffffc02023ae:	000e5717          	auipc	a4,0xe5
ffffffffc02023b2:	a8270713          	addi	a4,a4,-1406 # ffffffffc02e6e30 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc02023b6:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc02023ba:	002007b7          	lui	a5,0x200
ffffffffc02023be:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc02023c0:	f60918e3          	bnez	s2,ffffffffc0202330 <exit_range+0xee>
            if (free_pd0)
ffffffffc02023c4:	f00b85e3          	beqz	s7,ffffffffc02022ce <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc02023c8:	000d3783          	ld	a5,0(s10)
ffffffffc02023cc:	0efa7263          	bgeu	s4,a5,ffffffffc02024b0 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02023d0:	6308                	ld	a0,0(a4)
ffffffffc02023d2:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02023d4:	100027f3          	csrr	a5,sstatus
ffffffffc02023d8:	8b89                	andi	a5,a5,2
ffffffffc02023da:	efad                	bnez	a5,ffffffffc0202454 <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc02023dc:	000db783          	ld	a5,0(s11)
ffffffffc02023e0:	4585                	li	a1,1
ffffffffc02023e2:	739c                	ld	a5,32(a5)
ffffffffc02023e4:	9782                	jalr	a5
ffffffffc02023e6:	000e5717          	auipc	a4,0xe5
ffffffffc02023ea:	a4a70713          	addi	a4,a4,-1462 # ffffffffc02e6e30 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc02023ee:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc02023f2:	ee0990e3          	bnez	s3,ffffffffc02022d2 <exit_range+0x90>
}
ffffffffc02023f6:	70e6                	ld	ra,120(sp)
ffffffffc02023f8:	7446                	ld	s0,112(sp)
ffffffffc02023fa:	74a6                	ld	s1,104(sp)
ffffffffc02023fc:	7906                	ld	s2,96(sp)
ffffffffc02023fe:	69e6                	ld	s3,88(sp)
ffffffffc0202400:	6a46                	ld	s4,80(sp)
ffffffffc0202402:	6aa6                	ld	s5,72(sp)
ffffffffc0202404:	6b06                	ld	s6,64(sp)
ffffffffc0202406:	7be2                	ld	s7,56(sp)
ffffffffc0202408:	7c42                	ld	s8,48(sp)
ffffffffc020240a:	7ca2                	ld	s9,40(sp)
ffffffffc020240c:	7d02                	ld	s10,32(sp)
ffffffffc020240e:	6de2                	ld	s11,24(sp)
ffffffffc0202410:	6109                	addi	sp,sp,128
ffffffffc0202412:	8082                	ret
            if (free_pd0)
ffffffffc0202414:	ea0b8fe3          	beqz	s7,ffffffffc02022d2 <exit_range+0x90>
ffffffffc0202418:	bf45                	j	ffffffffc02023c8 <exit_range+0x186>
ffffffffc020241a:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc020241c:	e42a                	sd	a0,8(sp)
ffffffffc020241e:	d90fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202422:	000db783          	ld	a5,0(s11)
ffffffffc0202426:	6522                	ld	a0,8(sp)
ffffffffc0202428:	4585                	li	a1,1
ffffffffc020242a:	739c                	ld	a5,32(a5)
ffffffffc020242c:	9782                	jalr	a5
        intr_enable();
ffffffffc020242e:	d7afe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202432:	6602                	ld	a2,0(sp)
ffffffffc0202434:	000e5717          	auipc	a4,0xe5
ffffffffc0202438:	9fc70713          	addi	a4,a4,-1540 # ffffffffc02e6e30 <pages>
ffffffffc020243c:	6885                	lui	a7,0x1
ffffffffc020243e:	00080337          	lui	t1,0x80
ffffffffc0202442:	fff80e37          	lui	t3,0xfff80
ffffffffc0202446:	000e5817          	auipc	a6,0xe5
ffffffffc020244a:	9fa80813          	addi	a6,a6,-1542 # ffffffffc02e6e40 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc020244e:	0004b023          	sd	zero,0(s1)
ffffffffc0202452:	b7a5                	j	ffffffffc02023ba <exit_range+0x178>
ffffffffc0202454:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc0202456:	d58fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020245a:	000db783          	ld	a5,0(s11)
ffffffffc020245e:	6502                	ld	a0,0(sp)
ffffffffc0202460:	4585                	li	a1,1
ffffffffc0202462:	739c                	ld	a5,32(a5)
ffffffffc0202464:	9782                	jalr	a5
        intr_enable();
ffffffffc0202466:	d42fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020246a:	000e5717          	auipc	a4,0xe5
ffffffffc020246e:	9c670713          	addi	a4,a4,-1594 # ffffffffc02e6e30 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc0202472:	00043023          	sd	zero,0(s0)
ffffffffc0202476:	bfb5                	j	ffffffffc02023f2 <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202478:	00005697          	auipc	a3,0x5
ffffffffc020247c:	90868693          	addi	a3,a3,-1784 # ffffffffc0206d80 <default_pmm_manager+0x160>
ffffffffc0202480:	00004617          	auipc	a2,0x4
ffffffffc0202484:	3f060613          	addi	a2,a2,1008 # ffffffffc0206870 <commands+0x850>
ffffffffc0202488:	13700593          	li	a1,311
ffffffffc020248c:	00005517          	auipc	a0,0x5
ffffffffc0202490:	8e450513          	addi	a0,a0,-1820 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202494:	ffffd0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc0202498:	00004617          	auipc	a2,0x4
ffffffffc020249c:	7c060613          	addi	a2,a2,1984 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc02024a0:	07100593          	li	a1,113
ffffffffc02024a4:	00004517          	auipc	a0,0x4
ffffffffc02024a8:	7dc50513          	addi	a0,a0,2012 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc02024ac:	fe7fd0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc02024b0:	8e1ff0ef          	jal	ra,ffffffffc0201d90 <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc02024b4:	00005697          	auipc	a3,0x5
ffffffffc02024b8:	8fc68693          	addi	a3,a3,-1796 # ffffffffc0206db0 <default_pmm_manager+0x190>
ffffffffc02024bc:	00004617          	auipc	a2,0x4
ffffffffc02024c0:	3b460613          	addi	a2,a2,948 # ffffffffc0206870 <commands+0x850>
ffffffffc02024c4:	13800593          	li	a1,312
ffffffffc02024c8:	00005517          	auipc	a0,0x5
ffffffffc02024cc:	8a850513          	addi	a0,a0,-1880 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02024d0:	fc3fd0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02024d4 <page_remove>:
{
ffffffffc02024d4:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02024d6:	4601                	li	a2,0
{
ffffffffc02024d8:	ec26                	sd	s1,24(sp)
ffffffffc02024da:	f406                	sd	ra,40(sp)
ffffffffc02024dc:	f022                	sd	s0,32(sp)
ffffffffc02024de:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02024e0:	9a1ff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
    if (ptep != NULL)
ffffffffc02024e4:	c511                	beqz	a0,ffffffffc02024f0 <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc02024e6:	611c                	ld	a5,0(a0)
ffffffffc02024e8:	842a                	mv	s0,a0
ffffffffc02024ea:	0017f713          	andi	a4,a5,1
ffffffffc02024ee:	e711                	bnez	a4,ffffffffc02024fa <page_remove+0x26>
}
ffffffffc02024f0:	70a2                	ld	ra,40(sp)
ffffffffc02024f2:	7402                	ld	s0,32(sp)
ffffffffc02024f4:	64e2                	ld	s1,24(sp)
ffffffffc02024f6:	6145                	addi	sp,sp,48
ffffffffc02024f8:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02024fa:	078a                	slli	a5,a5,0x2
ffffffffc02024fc:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02024fe:	000e5717          	auipc	a4,0xe5
ffffffffc0202502:	92a73703          	ld	a4,-1750(a4) # ffffffffc02e6e28 <npage>
ffffffffc0202506:	06e7f363          	bgeu	a5,a4,ffffffffc020256c <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc020250a:	fff80537          	lui	a0,0xfff80
ffffffffc020250e:	97aa                	add	a5,a5,a0
ffffffffc0202510:	079a                	slli	a5,a5,0x6
ffffffffc0202512:	000e5517          	auipc	a0,0xe5
ffffffffc0202516:	91e53503          	ld	a0,-1762(a0) # ffffffffc02e6e30 <pages>
ffffffffc020251a:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc020251c:	411c                	lw	a5,0(a0)
ffffffffc020251e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202522:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc0202524:	cb11                	beqz	a4,ffffffffc0202538 <page_remove+0x64>
        *ptep = 0;                 //(5) clear second page table entry
ffffffffc0202526:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020252a:	12048073          	sfence.vma	s1
}
ffffffffc020252e:	70a2                	ld	ra,40(sp)
ffffffffc0202530:	7402                	ld	s0,32(sp)
ffffffffc0202532:	64e2                	ld	s1,24(sp)
ffffffffc0202534:	6145                	addi	sp,sp,48
ffffffffc0202536:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202538:	100027f3          	csrr	a5,sstatus
ffffffffc020253c:	8b89                	andi	a5,a5,2
ffffffffc020253e:	eb89                	bnez	a5,ffffffffc0202550 <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc0202540:	000e5797          	auipc	a5,0xe5
ffffffffc0202544:	8f87b783          	ld	a5,-1800(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0202548:	739c                	ld	a5,32(a5)
ffffffffc020254a:	4585                	li	a1,1
ffffffffc020254c:	9782                	jalr	a5
    if (flag)
ffffffffc020254e:	bfe1                	j	ffffffffc0202526 <page_remove+0x52>
        intr_disable();
ffffffffc0202550:	e42a                	sd	a0,8(sp)
ffffffffc0202552:	c5cfe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202556:	000e5797          	auipc	a5,0xe5
ffffffffc020255a:	8e27b783          	ld	a5,-1822(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc020255e:	739c                	ld	a5,32(a5)
ffffffffc0202560:	6522                	ld	a0,8(sp)
ffffffffc0202562:	4585                	li	a1,1
ffffffffc0202564:	9782                	jalr	a5
        intr_enable();
ffffffffc0202566:	c42fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020256a:	bf75                	j	ffffffffc0202526 <page_remove+0x52>
ffffffffc020256c:	825ff0ef          	jal	ra,ffffffffc0201d90 <pa2page.part.0>

ffffffffc0202570 <page_insert>:
{
ffffffffc0202570:	7139                	addi	sp,sp,-64
ffffffffc0202572:	e852                	sd	s4,16(sp)
ffffffffc0202574:	8a32                	mv	s4,a2
ffffffffc0202576:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202578:	4605                	li	a2,1
{
ffffffffc020257a:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc020257c:	85d2                	mv	a1,s4
{
ffffffffc020257e:	f426                	sd	s1,40(sp)
ffffffffc0202580:	fc06                	sd	ra,56(sp)
ffffffffc0202582:	f04a                	sd	s2,32(sp)
ffffffffc0202584:	ec4e                	sd	s3,24(sp)
ffffffffc0202586:	e456                	sd	s5,8(sp)
ffffffffc0202588:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc020258a:	8f7ff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
    if (ptep == NULL)
ffffffffc020258e:	c961                	beqz	a0,ffffffffc020265e <page_insert+0xee>
    page->ref += 1;
ffffffffc0202590:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc0202592:	611c                	ld	a5,0(a0)
ffffffffc0202594:	89aa                	mv	s3,a0
ffffffffc0202596:	0016871b          	addiw	a4,a3,1
ffffffffc020259a:	c018                	sw	a4,0(s0)
ffffffffc020259c:	0017f713          	andi	a4,a5,1
ffffffffc02025a0:	ef05                	bnez	a4,ffffffffc02025d8 <page_insert+0x68>
    return page - pages + nbase;
ffffffffc02025a2:	000e5717          	auipc	a4,0xe5
ffffffffc02025a6:	88e73703          	ld	a4,-1906(a4) # ffffffffc02e6e30 <pages>
ffffffffc02025aa:	8c19                	sub	s0,s0,a4
ffffffffc02025ac:	000807b7          	lui	a5,0x80
ffffffffc02025b0:	8419                	srai	s0,s0,0x6
ffffffffc02025b2:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02025b4:	042a                	slli	s0,s0,0xa
ffffffffc02025b6:	8cc1                	or	s1,s1,s0
ffffffffc02025b8:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc02025bc:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_matrix_out_size+0xffffffffbfff38c8>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02025c0:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc02025c4:	4501                	li	a0,0
}
ffffffffc02025c6:	70e2                	ld	ra,56(sp)
ffffffffc02025c8:	7442                	ld	s0,48(sp)
ffffffffc02025ca:	74a2                	ld	s1,40(sp)
ffffffffc02025cc:	7902                	ld	s2,32(sp)
ffffffffc02025ce:	69e2                	ld	s3,24(sp)
ffffffffc02025d0:	6a42                	ld	s4,16(sp)
ffffffffc02025d2:	6aa2                	ld	s5,8(sp)
ffffffffc02025d4:	6121                	addi	sp,sp,64
ffffffffc02025d6:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02025d8:	078a                	slli	a5,a5,0x2
ffffffffc02025da:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02025dc:	000e5717          	auipc	a4,0xe5
ffffffffc02025e0:	84c73703          	ld	a4,-1972(a4) # ffffffffc02e6e28 <npage>
ffffffffc02025e4:	06e7ff63          	bgeu	a5,a4,ffffffffc0202662 <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc02025e8:	000e5a97          	auipc	s5,0xe5
ffffffffc02025ec:	848a8a93          	addi	s5,s5,-1976 # ffffffffc02e6e30 <pages>
ffffffffc02025f0:	000ab703          	ld	a4,0(s5)
ffffffffc02025f4:	fff80937          	lui	s2,0xfff80
ffffffffc02025f8:	993e                	add	s2,s2,a5
ffffffffc02025fa:	091a                	slli	s2,s2,0x6
ffffffffc02025fc:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc02025fe:	01240c63          	beq	s0,s2,ffffffffc0202616 <page_insert+0xa6>
    page->ref -= 1;
ffffffffc0202602:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fc99188>
ffffffffc0202606:	fff7869b          	addiw	a3,a5,-1
ffffffffc020260a:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) ==
ffffffffc020260e:	c691                	beqz	a3,ffffffffc020261a <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202610:	120a0073          	sfence.vma	s4
}
ffffffffc0202614:	bf59                	j	ffffffffc02025aa <page_insert+0x3a>
ffffffffc0202616:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc0202618:	bf49                	j	ffffffffc02025aa <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020261a:	100027f3          	csrr	a5,sstatus
ffffffffc020261e:	8b89                	andi	a5,a5,2
ffffffffc0202620:	ef91                	bnez	a5,ffffffffc020263c <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc0202622:	000e5797          	auipc	a5,0xe5
ffffffffc0202626:	8167b783          	ld	a5,-2026(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc020262a:	739c                	ld	a5,32(a5)
ffffffffc020262c:	4585                	li	a1,1
ffffffffc020262e:	854a                	mv	a0,s2
ffffffffc0202630:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc0202632:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202636:	120a0073          	sfence.vma	s4
ffffffffc020263a:	bf85                	j	ffffffffc02025aa <page_insert+0x3a>
        intr_disable();
ffffffffc020263c:	b72fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202640:	000e4797          	auipc	a5,0xe4
ffffffffc0202644:	7f87b783          	ld	a5,2040(a5) # ffffffffc02e6e38 <pmm_manager>
ffffffffc0202648:	739c                	ld	a5,32(a5)
ffffffffc020264a:	4585                	li	a1,1
ffffffffc020264c:	854a                	mv	a0,s2
ffffffffc020264e:	9782                	jalr	a5
        intr_enable();
ffffffffc0202650:	b58fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202654:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202658:	120a0073          	sfence.vma	s4
ffffffffc020265c:	b7b9                	j	ffffffffc02025aa <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc020265e:	5571                	li	a0,-4
ffffffffc0202660:	b79d                	j	ffffffffc02025c6 <page_insert+0x56>
ffffffffc0202662:	f2eff0ef          	jal	ra,ffffffffc0201d90 <pa2page.part.0>

ffffffffc0202666 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0202666:	00004797          	auipc	a5,0x4
ffffffffc020266a:	5ba78793          	addi	a5,a5,1466 # ffffffffc0206c20 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020266e:	638c                	ld	a1,0(a5)
{
ffffffffc0202670:	7159                	addi	sp,sp,-112
ffffffffc0202672:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202674:	00004517          	auipc	a0,0x4
ffffffffc0202678:	75450513          	addi	a0,a0,1876 # ffffffffc0206dc8 <default_pmm_manager+0x1a8>
    pmm_manager = &default_pmm_manager;
ffffffffc020267c:	000e4b17          	auipc	s6,0xe4
ffffffffc0202680:	7bcb0b13          	addi	s6,s6,1980 # ffffffffc02e6e38 <pmm_manager>
{
ffffffffc0202684:	f486                	sd	ra,104(sp)
ffffffffc0202686:	e8ca                	sd	s2,80(sp)
ffffffffc0202688:	e4ce                	sd	s3,72(sp)
ffffffffc020268a:	f0a2                	sd	s0,96(sp)
ffffffffc020268c:	eca6                	sd	s1,88(sp)
ffffffffc020268e:	e0d2                	sd	s4,64(sp)
ffffffffc0202690:	fc56                	sd	s5,56(sp)
ffffffffc0202692:	f45e                	sd	s7,40(sp)
ffffffffc0202694:	f062                	sd	s8,32(sp)
ffffffffc0202696:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202698:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020269c:	afdfd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    pmm_manager->init();
ffffffffc02026a0:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc02026a4:	000e4997          	auipc	s3,0xe4
ffffffffc02026a8:	79c98993          	addi	s3,s3,1948 # ffffffffc02e6e40 <va_pa_offset>
    pmm_manager->init();
ffffffffc02026ac:	679c                	ld	a5,8(a5)
ffffffffc02026ae:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc02026b0:	57f5                	li	a5,-3
ffffffffc02026b2:	07fa                	slli	a5,a5,0x1e
ffffffffc02026b4:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc02026b8:	adcfe0ef          	jal	ra,ffffffffc0200994 <get_memory_base>
ffffffffc02026bc:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc02026be:	ae0fe0ef          	jal	ra,ffffffffc020099e <get_memory_size>
    if (mem_size == 0)
ffffffffc02026c2:	200505e3          	beqz	a0,ffffffffc02030cc <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02026c6:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc02026c8:	00004517          	auipc	a0,0x4
ffffffffc02026cc:	73850513          	addi	a0,a0,1848 # ffffffffc0206e00 <default_pmm_manager+0x1e0>
ffffffffc02026d0:	ac9fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02026d4:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc02026d8:	fff40693          	addi	a3,s0,-1
ffffffffc02026dc:	864a                	mv	a2,s2
ffffffffc02026de:	85a6                	mv	a1,s1
ffffffffc02026e0:	00004517          	auipc	a0,0x4
ffffffffc02026e4:	73850513          	addi	a0,a0,1848 # ffffffffc0206e18 <default_pmm_manager+0x1f8>
ffffffffc02026e8:	ab1fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02026ec:	c8000737          	lui	a4,0xc8000
ffffffffc02026f0:	87a2                	mv	a5,s0
ffffffffc02026f2:	54876163          	bltu	a4,s0,ffffffffc0202c34 <pmm_init+0x5ce>
ffffffffc02026f6:	757d                	lui	a0,0xfffff
ffffffffc02026f8:	000e5617          	auipc	a2,0xe5
ffffffffc02026fc:	77f60613          	addi	a2,a2,1919 # ffffffffc02e7e77 <end+0xfff>
ffffffffc0202700:	8e69                	and	a2,a2,a0
ffffffffc0202702:	000e4497          	auipc	s1,0xe4
ffffffffc0202706:	72648493          	addi	s1,s1,1830 # ffffffffc02e6e28 <npage>
ffffffffc020270a:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc020270e:	000e4b97          	auipc	s7,0xe4
ffffffffc0202712:	722b8b93          	addi	s7,s7,1826 # ffffffffc02e6e30 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0202716:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202718:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc020271c:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202720:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202722:	02f50863          	beq	a0,a5,ffffffffc0202752 <pmm_init+0xec>
ffffffffc0202726:	4781                	li	a5,0
ffffffffc0202728:	4585                	li	a1,1
ffffffffc020272a:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc020272e:	00679513          	slli	a0,a5,0x6
ffffffffc0202732:	9532                	add	a0,a0,a2
ffffffffc0202734:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd18190>
ffffffffc0202738:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc020273c:	6088                	ld	a0,0(s1)
ffffffffc020273e:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc0202740:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202744:	00d50733          	add	a4,a0,a3
ffffffffc0202748:	fee7e3e3          	bltu	a5,a4,ffffffffc020272e <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020274c:	071a                	slli	a4,a4,0x6
ffffffffc020274e:	00e606b3          	add	a3,a2,a4
ffffffffc0202752:	c02007b7          	lui	a5,0xc0200
ffffffffc0202756:	2ef6ece3          	bltu	a3,a5,ffffffffc020324e <pmm_init+0xbe8>
ffffffffc020275a:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc020275e:	77fd                	lui	a5,0xfffff
ffffffffc0202760:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202762:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc0202764:	5086eb63          	bltu	a3,s0,ffffffffc0202c7a <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202768:	00004517          	auipc	a0,0x4
ffffffffc020276c:	6d850513          	addi	a0,a0,1752 # ffffffffc0206e40 <default_pmm_manager+0x220>
ffffffffc0202770:	a29fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc0202774:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202778:	000e4917          	auipc	s2,0xe4
ffffffffc020277c:	6a890913          	addi	s2,s2,1704 # ffffffffc02e6e20 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc0202780:	7b9c                	ld	a5,48(a5)
ffffffffc0202782:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0202784:	00004517          	auipc	a0,0x4
ffffffffc0202788:	6d450513          	addi	a0,a0,1748 # ffffffffc0206e58 <default_pmm_manager+0x238>
ffffffffc020278c:	a0dfd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202790:	00009697          	auipc	a3,0x9
ffffffffc0202794:	87068693          	addi	a3,a3,-1936 # ffffffffc020b000 <boot_page_table_sv39>
ffffffffc0202798:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc020279c:	c02007b7          	lui	a5,0xc0200
ffffffffc02027a0:	28f6ebe3          	bltu	a3,a5,ffffffffc0203236 <pmm_init+0xbd0>
ffffffffc02027a4:	0009b783          	ld	a5,0(s3)
ffffffffc02027a8:	8e9d                	sub	a3,a3,a5
ffffffffc02027aa:	000e4797          	auipc	a5,0xe4
ffffffffc02027ae:	66d7b723          	sd	a3,1646(a5) # ffffffffc02e6e18 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02027b2:	100027f3          	csrr	a5,sstatus
ffffffffc02027b6:	8b89                	andi	a5,a5,2
ffffffffc02027b8:	4a079763          	bnez	a5,ffffffffc0202c66 <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc02027bc:	000b3783          	ld	a5,0(s6)
ffffffffc02027c0:	779c                	ld	a5,40(a5)
ffffffffc02027c2:	9782                	jalr	a5
ffffffffc02027c4:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc02027c6:	6098                	ld	a4,0(s1)
ffffffffc02027c8:	c80007b7          	lui	a5,0xc8000
ffffffffc02027cc:	83b1                	srli	a5,a5,0xc
ffffffffc02027ce:	66e7e363          	bltu	a5,a4,ffffffffc0202e34 <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc02027d2:	00093503          	ld	a0,0(s2)
ffffffffc02027d6:	62050f63          	beqz	a0,ffffffffc0202e14 <pmm_init+0x7ae>
ffffffffc02027da:	03451793          	slli	a5,a0,0x34
ffffffffc02027de:	62079b63          	bnez	a5,ffffffffc0202e14 <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc02027e2:	4601                	li	a2,0
ffffffffc02027e4:	4581                	li	a1,0
ffffffffc02027e6:	8c3ff0ef          	jal	ra,ffffffffc02020a8 <get_page>
ffffffffc02027ea:	60051563          	bnez	a0,ffffffffc0202df4 <pmm_init+0x78e>
ffffffffc02027ee:	100027f3          	csrr	a5,sstatus
ffffffffc02027f2:	8b89                	andi	a5,a5,2
ffffffffc02027f4:	44079e63          	bnez	a5,ffffffffc0202c50 <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc02027f8:	000b3783          	ld	a5,0(s6)
ffffffffc02027fc:	4505                	li	a0,1
ffffffffc02027fe:	6f9c                	ld	a5,24(a5)
ffffffffc0202800:	9782                	jalr	a5
ffffffffc0202802:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc0202804:	00093503          	ld	a0,0(s2)
ffffffffc0202808:	4681                	li	a3,0
ffffffffc020280a:	4601                	li	a2,0
ffffffffc020280c:	85d2                	mv	a1,s4
ffffffffc020280e:	d63ff0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc0202812:	26051ae3          	bnez	a0,ffffffffc0203286 <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc0202816:	00093503          	ld	a0,0(s2)
ffffffffc020281a:	4601                	li	a2,0
ffffffffc020281c:	4581                	li	a1,0
ffffffffc020281e:	e62ff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
ffffffffc0202822:	240502e3          	beqz	a0,ffffffffc0203266 <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc0202826:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc0202828:	0017f713          	andi	a4,a5,1
ffffffffc020282c:	5a070263          	beqz	a4,ffffffffc0202dd0 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0202830:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202832:	078a                	slli	a5,a5,0x2
ffffffffc0202834:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202836:	58e7fb63          	bgeu	a5,a4,ffffffffc0202dcc <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc020283a:	000bb683          	ld	a3,0(s7)
ffffffffc020283e:	fff80637          	lui	a2,0xfff80
ffffffffc0202842:	97b2                	add	a5,a5,a2
ffffffffc0202844:	079a                	slli	a5,a5,0x6
ffffffffc0202846:	97b6                	add	a5,a5,a3
ffffffffc0202848:	14fa17e3          	bne	s4,a5,ffffffffc0203196 <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc020284c:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f68>
ffffffffc0202850:	4785                	li	a5,1
ffffffffc0202852:	12f692e3          	bne	a3,a5,ffffffffc0203176 <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0202856:	00093503          	ld	a0,0(s2)
ffffffffc020285a:	77fd                	lui	a5,0xfffff
ffffffffc020285c:	6114                	ld	a3,0(a0)
ffffffffc020285e:	068a                	slli	a3,a3,0x2
ffffffffc0202860:	8efd                	and	a3,a3,a5
ffffffffc0202862:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202866:	0ee67ce3          	bgeu	a2,a4,ffffffffc020315e <pmm_init+0xaf8>
ffffffffc020286a:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020286e:	96e2                	add	a3,a3,s8
ffffffffc0202870:	0006ba83          	ld	s5,0(a3)
ffffffffc0202874:	0a8a                	slli	s5,s5,0x2
ffffffffc0202876:	00fafab3          	and	s5,s5,a5
ffffffffc020287a:	00cad793          	srli	a5,s5,0xc
ffffffffc020287e:	0ce7f3e3          	bgeu	a5,a4,ffffffffc0203144 <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202882:	4601                	li	a2,0
ffffffffc0202884:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202886:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202888:	df8ff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020288c:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020288e:	55551363          	bne	a0,s5,ffffffffc0202dd4 <pmm_init+0x76e>
ffffffffc0202892:	100027f3          	csrr	a5,sstatus
ffffffffc0202896:	8b89                	andi	a5,a5,2
ffffffffc0202898:	3a079163          	bnez	a5,ffffffffc0202c3a <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc020289c:	000b3783          	ld	a5,0(s6)
ffffffffc02028a0:	4505                	li	a0,1
ffffffffc02028a2:	6f9c                	ld	a5,24(a5)
ffffffffc02028a4:	9782                	jalr	a5
ffffffffc02028a6:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc02028a8:	00093503          	ld	a0,0(s2)
ffffffffc02028ac:	46d1                	li	a3,20
ffffffffc02028ae:	6605                	lui	a2,0x1
ffffffffc02028b0:	85e2                	mv	a1,s8
ffffffffc02028b2:	cbfff0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc02028b6:	060517e3          	bnez	a0,ffffffffc0203124 <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02028ba:	00093503          	ld	a0,0(s2)
ffffffffc02028be:	4601                	li	a2,0
ffffffffc02028c0:	6585                	lui	a1,0x1
ffffffffc02028c2:	dbeff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
ffffffffc02028c6:	02050fe3          	beqz	a0,ffffffffc0203104 <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc02028ca:	611c                	ld	a5,0(a0)
ffffffffc02028cc:	0107f713          	andi	a4,a5,16
ffffffffc02028d0:	7c070e63          	beqz	a4,ffffffffc02030ac <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc02028d4:	8b91                	andi	a5,a5,4
ffffffffc02028d6:	7a078b63          	beqz	a5,ffffffffc020308c <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc02028da:	00093503          	ld	a0,0(s2)
ffffffffc02028de:	611c                	ld	a5,0(a0)
ffffffffc02028e0:	8bc1                	andi	a5,a5,16
ffffffffc02028e2:	78078563          	beqz	a5,ffffffffc020306c <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc02028e6:	000c2703          	lw	a4,0(s8)
ffffffffc02028ea:	4785                	li	a5,1
ffffffffc02028ec:	76f71063          	bne	a4,a5,ffffffffc020304c <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02028f0:	4681                	li	a3,0
ffffffffc02028f2:	6605                	lui	a2,0x1
ffffffffc02028f4:	85d2                	mv	a1,s4
ffffffffc02028f6:	c7bff0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc02028fa:	72051963          	bnez	a0,ffffffffc020302c <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc02028fe:	000a2703          	lw	a4,0(s4)
ffffffffc0202902:	4789                	li	a5,2
ffffffffc0202904:	70f71463          	bne	a4,a5,ffffffffc020300c <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc0202908:	000c2783          	lw	a5,0(s8)
ffffffffc020290c:	6e079063          	bnez	a5,ffffffffc0202fec <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0202910:	00093503          	ld	a0,0(s2)
ffffffffc0202914:	4601                	li	a2,0
ffffffffc0202916:	6585                	lui	a1,0x1
ffffffffc0202918:	d68ff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
ffffffffc020291c:	6a050863          	beqz	a0,ffffffffc0202fcc <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc0202920:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc0202922:	00177793          	andi	a5,a4,1
ffffffffc0202926:	4a078563          	beqz	a5,ffffffffc0202dd0 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc020292a:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc020292c:	00271793          	slli	a5,a4,0x2
ffffffffc0202930:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202932:	48d7fd63          	bgeu	a5,a3,ffffffffc0202dcc <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202936:	000bb683          	ld	a3,0(s7)
ffffffffc020293a:	fff80ab7          	lui	s5,0xfff80
ffffffffc020293e:	97d6                	add	a5,a5,s5
ffffffffc0202940:	079a                	slli	a5,a5,0x6
ffffffffc0202942:	97b6                	add	a5,a5,a3
ffffffffc0202944:	66fa1463          	bne	s4,a5,ffffffffc0202fac <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202948:	8b41                	andi	a4,a4,16
ffffffffc020294a:	64071163          	bnez	a4,ffffffffc0202f8c <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc020294e:	00093503          	ld	a0,0(s2)
ffffffffc0202952:	4581                	li	a1,0
ffffffffc0202954:	b81ff0ef          	jal	ra,ffffffffc02024d4 <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc0202958:	000a2c83          	lw	s9,0(s4)
ffffffffc020295c:	4785                	li	a5,1
ffffffffc020295e:	60fc9763          	bne	s9,a5,ffffffffc0202f6c <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc0202962:	000c2783          	lw	a5,0(s8)
ffffffffc0202966:	5e079363          	bnez	a5,ffffffffc0202f4c <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc020296a:	00093503          	ld	a0,0(s2)
ffffffffc020296e:	6585                	lui	a1,0x1
ffffffffc0202970:	b65ff0ef          	jal	ra,ffffffffc02024d4 <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc0202974:	000a2783          	lw	a5,0(s4)
ffffffffc0202978:	52079a63          	bnez	a5,ffffffffc0202eac <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc020297c:	000c2783          	lw	a5,0(s8)
ffffffffc0202980:	50079663          	bnez	a5,ffffffffc0202e8c <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202984:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202988:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc020298a:	000a3683          	ld	a3,0(s4)
ffffffffc020298e:	068a                	slli	a3,a3,0x2
ffffffffc0202990:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202992:	42b6fd63          	bgeu	a3,a1,ffffffffc0202dcc <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202996:	000bb503          	ld	a0,0(s7)
ffffffffc020299a:	96d6                	add	a3,a3,s5
ffffffffc020299c:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc020299e:	00d507b3          	add	a5,a0,a3
ffffffffc02029a2:	439c                	lw	a5,0(a5)
ffffffffc02029a4:	4d979463          	bne	a5,s9,ffffffffc0202e6c <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc02029a8:	8699                	srai	a3,a3,0x6
ffffffffc02029aa:	00080637          	lui	a2,0x80
ffffffffc02029ae:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02029b0:	00c69713          	slli	a4,a3,0xc
ffffffffc02029b4:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02029b6:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02029b8:	48b77e63          	bgeu	a4,a1,ffffffffc0202e54 <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc02029bc:	0009b703          	ld	a4,0(s3)
ffffffffc02029c0:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc02029c2:	629c                	ld	a5,0(a3)
ffffffffc02029c4:	078a                	slli	a5,a5,0x2
ffffffffc02029c6:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029c8:	40b7f263          	bgeu	a5,a1,ffffffffc0202dcc <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02029cc:	8f91                	sub	a5,a5,a2
ffffffffc02029ce:	079a                	slli	a5,a5,0x6
ffffffffc02029d0:	953e                	add	a0,a0,a5
ffffffffc02029d2:	100027f3          	csrr	a5,sstatus
ffffffffc02029d6:	8b89                	andi	a5,a5,2
ffffffffc02029d8:	30079963          	bnez	a5,ffffffffc0202cea <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc02029dc:	000b3783          	ld	a5,0(s6)
ffffffffc02029e0:	4585                	li	a1,1
ffffffffc02029e2:	739c                	ld	a5,32(a5)
ffffffffc02029e4:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc02029e6:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc02029ea:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc02029ec:	078a                	slli	a5,a5,0x2
ffffffffc02029ee:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029f0:	3ce7fe63          	bgeu	a5,a4,ffffffffc0202dcc <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02029f4:	000bb503          	ld	a0,0(s7)
ffffffffc02029f8:	fff80737          	lui	a4,0xfff80
ffffffffc02029fc:	97ba                	add	a5,a5,a4
ffffffffc02029fe:	079a                	slli	a5,a5,0x6
ffffffffc0202a00:	953e                	add	a0,a0,a5
ffffffffc0202a02:	100027f3          	csrr	a5,sstatus
ffffffffc0202a06:	8b89                	andi	a5,a5,2
ffffffffc0202a08:	2c079563          	bnez	a5,ffffffffc0202cd2 <pmm_init+0x66c>
ffffffffc0202a0c:	000b3783          	ld	a5,0(s6)
ffffffffc0202a10:	4585                	li	a1,1
ffffffffc0202a12:	739c                	ld	a5,32(a5)
ffffffffc0202a14:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202a16:	00093783          	ld	a5,0(s2)
ffffffffc0202a1a:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd18188>
    asm volatile("sfence.vma");
ffffffffc0202a1e:	12000073          	sfence.vma
ffffffffc0202a22:	100027f3          	csrr	a5,sstatus
ffffffffc0202a26:	8b89                	andi	a5,a5,2
ffffffffc0202a28:	28079b63          	bnez	a5,ffffffffc0202cbe <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202a2c:	000b3783          	ld	a5,0(s6)
ffffffffc0202a30:	779c                	ld	a5,40(a5)
ffffffffc0202a32:	9782                	jalr	a5
ffffffffc0202a34:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202a36:	4b441b63          	bne	s0,s4,ffffffffc0202eec <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc0202a3a:	00004517          	auipc	a0,0x4
ffffffffc0202a3e:	74650513          	addi	a0,a0,1862 # ffffffffc0207180 <default_pmm_manager+0x560>
ffffffffc0202a42:	f56fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0202a46:	100027f3          	csrr	a5,sstatus
ffffffffc0202a4a:	8b89                	andi	a5,a5,2
ffffffffc0202a4c:	24079f63          	bnez	a5,ffffffffc0202caa <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202a50:	000b3783          	ld	a5,0(s6)
ffffffffc0202a54:	779c                	ld	a5,40(a5)
ffffffffc0202a56:	9782                	jalr	a5
ffffffffc0202a58:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a5a:	6098                	ld	a4,0(s1)
ffffffffc0202a5c:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202a60:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a62:	00c71793          	slli	a5,a4,0xc
ffffffffc0202a66:	6a05                	lui	s4,0x1
ffffffffc0202a68:	02f47c63          	bgeu	s0,a5,ffffffffc0202aa0 <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202a6c:	00c45793          	srli	a5,s0,0xc
ffffffffc0202a70:	00093503          	ld	a0,0(s2)
ffffffffc0202a74:	2ee7ff63          	bgeu	a5,a4,ffffffffc0202d72 <pmm_init+0x70c>
ffffffffc0202a78:	0009b583          	ld	a1,0(s3)
ffffffffc0202a7c:	4601                	li	a2,0
ffffffffc0202a7e:	95a2                	add	a1,a1,s0
ffffffffc0202a80:	c00ff0ef          	jal	ra,ffffffffc0201e80 <get_pte>
ffffffffc0202a84:	32050463          	beqz	a0,ffffffffc0202dac <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202a88:	611c                	ld	a5,0(a0)
ffffffffc0202a8a:	078a                	slli	a5,a5,0x2
ffffffffc0202a8c:	0157f7b3          	and	a5,a5,s5
ffffffffc0202a90:	2e879e63          	bne	a5,s0,ffffffffc0202d8c <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a94:	6098                	ld	a4,0(s1)
ffffffffc0202a96:	9452                	add	s0,s0,s4
ffffffffc0202a98:	00c71793          	slli	a5,a4,0xc
ffffffffc0202a9c:	fcf468e3          	bltu	s0,a5,ffffffffc0202a6c <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc0202aa0:	00093783          	ld	a5,0(s2)
ffffffffc0202aa4:	639c                	ld	a5,0(a5)
ffffffffc0202aa6:	42079363          	bnez	a5,ffffffffc0202ecc <pmm_init+0x866>
ffffffffc0202aaa:	100027f3          	csrr	a5,sstatus
ffffffffc0202aae:	8b89                	andi	a5,a5,2
ffffffffc0202ab0:	24079963          	bnez	a5,ffffffffc0202d02 <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202ab4:	000b3783          	ld	a5,0(s6)
ffffffffc0202ab8:	4505                	li	a0,1
ffffffffc0202aba:	6f9c                	ld	a5,24(a5)
ffffffffc0202abc:	9782                	jalr	a5
ffffffffc0202abe:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202ac0:	00093503          	ld	a0,0(s2)
ffffffffc0202ac4:	4699                	li	a3,6
ffffffffc0202ac6:	10000613          	li	a2,256
ffffffffc0202aca:	85d2                	mv	a1,s4
ffffffffc0202acc:	aa5ff0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc0202ad0:	44051e63          	bnez	a0,ffffffffc0202f2c <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc0202ad4:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f68>
ffffffffc0202ad8:	4785                	li	a5,1
ffffffffc0202ada:	42f71963          	bne	a4,a5,ffffffffc0202f0c <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0202ade:	00093503          	ld	a0,0(s2)
ffffffffc0202ae2:	6405                	lui	s0,0x1
ffffffffc0202ae4:	4699                	li	a3,6
ffffffffc0202ae6:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8e68>
ffffffffc0202aea:	85d2                	mv	a1,s4
ffffffffc0202aec:	a85ff0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc0202af0:	72051363          	bnez	a0,ffffffffc0203216 <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0202af4:	000a2703          	lw	a4,0(s4)
ffffffffc0202af8:	4789                	li	a5,2
ffffffffc0202afa:	6ef71e63          	bne	a4,a5,ffffffffc02031f6 <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0202afe:	00004597          	auipc	a1,0x4
ffffffffc0202b02:	7ca58593          	addi	a1,a1,1994 # ffffffffc02072c8 <default_pmm_manager+0x6a8>
ffffffffc0202b06:	10000513          	li	a0,256
ffffffffc0202b0a:	214030ef          	jal	ra,ffffffffc0205d1e <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0202b0e:	10040593          	addi	a1,s0,256
ffffffffc0202b12:	10000513          	li	a0,256
ffffffffc0202b16:	21a030ef          	jal	ra,ffffffffc0205d30 <strcmp>
ffffffffc0202b1a:	6a051e63          	bnez	a0,ffffffffc02031d6 <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0202b1e:	000bb683          	ld	a3,0(s7)
ffffffffc0202b22:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0202b26:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc0202b28:	40da06b3          	sub	a3,s4,a3
ffffffffc0202b2c:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0202b2e:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0202b30:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0202b32:	8031                	srli	s0,s0,0xc
ffffffffc0202b34:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202b38:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202b3a:	30f77d63          	bgeu	a4,a5,ffffffffc0202e54 <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202b3e:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202b42:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202b46:	96be                	add	a3,a3,a5
ffffffffc0202b48:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202b4c:	19c030ef          	jal	ra,ffffffffc0205ce8 <strlen>
ffffffffc0202b50:	66051363          	bnez	a0,ffffffffc02031b6 <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0202b54:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202b58:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b5a:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd18188>
ffffffffc0202b5e:	068a                	slli	a3,a3,0x2
ffffffffc0202b60:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b62:	26f6f563          	bgeu	a3,a5,ffffffffc0202dcc <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0202b66:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0202b68:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202b6a:	2ef47563          	bgeu	s0,a5,ffffffffc0202e54 <pmm_init+0x7ee>
ffffffffc0202b6e:	0009b403          	ld	s0,0(s3)
ffffffffc0202b72:	9436                	add	s0,s0,a3
ffffffffc0202b74:	100027f3          	csrr	a5,sstatus
ffffffffc0202b78:	8b89                	andi	a5,a5,2
ffffffffc0202b7a:	1e079163          	bnez	a5,ffffffffc0202d5c <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc0202b7e:	000b3783          	ld	a5,0(s6)
ffffffffc0202b82:	4585                	li	a1,1
ffffffffc0202b84:	8552                	mv	a0,s4
ffffffffc0202b86:	739c                	ld	a5,32(a5)
ffffffffc0202b88:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b8a:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc0202b8c:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b8e:	078a                	slli	a5,a5,0x2
ffffffffc0202b90:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b92:	22e7fd63          	bgeu	a5,a4,ffffffffc0202dcc <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b96:	000bb503          	ld	a0,0(s7)
ffffffffc0202b9a:	fff80737          	lui	a4,0xfff80
ffffffffc0202b9e:	97ba                	add	a5,a5,a4
ffffffffc0202ba0:	079a                	slli	a5,a5,0x6
ffffffffc0202ba2:	953e                	add	a0,a0,a5
ffffffffc0202ba4:	100027f3          	csrr	a5,sstatus
ffffffffc0202ba8:	8b89                	andi	a5,a5,2
ffffffffc0202baa:	18079d63          	bnez	a5,ffffffffc0202d44 <pmm_init+0x6de>
ffffffffc0202bae:	000b3783          	ld	a5,0(s6)
ffffffffc0202bb2:	4585                	li	a1,1
ffffffffc0202bb4:	739c                	ld	a5,32(a5)
ffffffffc0202bb6:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202bb8:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc0202bbc:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202bbe:	078a                	slli	a5,a5,0x2
ffffffffc0202bc0:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202bc2:	20e7f563          	bgeu	a5,a4,ffffffffc0202dcc <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202bc6:	000bb503          	ld	a0,0(s7)
ffffffffc0202bca:	fff80737          	lui	a4,0xfff80
ffffffffc0202bce:	97ba                	add	a5,a5,a4
ffffffffc0202bd0:	079a                	slli	a5,a5,0x6
ffffffffc0202bd2:	953e                	add	a0,a0,a5
ffffffffc0202bd4:	100027f3          	csrr	a5,sstatus
ffffffffc0202bd8:	8b89                	andi	a5,a5,2
ffffffffc0202bda:	14079963          	bnez	a5,ffffffffc0202d2c <pmm_init+0x6c6>
ffffffffc0202bde:	000b3783          	ld	a5,0(s6)
ffffffffc0202be2:	4585                	li	a1,1
ffffffffc0202be4:	739c                	ld	a5,32(a5)
ffffffffc0202be6:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202be8:	00093783          	ld	a5,0(s2)
ffffffffc0202bec:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0202bf0:	12000073          	sfence.vma
ffffffffc0202bf4:	100027f3          	csrr	a5,sstatus
ffffffffc0202bf8:	8b89                	andi	a5,a5,2
ffffffffc0202bfa:	10079f63          	bnez	a5,ffffffffc0202d18 <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202bfe:	000b3783          	ld	a5,0(s6)
ffffffffc0202c02:	779c                	ld	a5,40(a5)
ffffffffc0202c04:	9782                	jalr	a5
ffffffffc0202c06:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202c08:	4c8c1e63          	bne	s8,s0,ffffffffc02030e4 <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc0202c0c:	00004517          	auipc	a0,0x4
ffffffffc0202c10:	73450513          	addi	a0,a0,1844 # ffffffffc0207340 <default_pmm_manager+0x720>
ffffffffc0202c14:	d84fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
}
ffffffffc0202c18:	7406                	ld	s0,96(sp)
ffffffffc0202c1a:	70a6                	ld	ra,104(sp)
ffffffffc0202c1c:	64e6                	ld	s1,88(sp)
ffffffffc0202c1e:	6946                	ld	s2,80(sp)
ffffffffc0202c20:	69a6                	ld	s3,72(sp)
ffffffffc0202c22:	6a06                	ld	s4,64(sp)
ffffffffc0202c24:	7ae2                	ld	s5,56(sp)
ffffffffc0202c26:	7b42                	ld	s6,48(sp)
ffffffffc0202c28:	7ba2                	ld	s7,40(sp)
ffffffffc0202c2a:	7c02                	ld	s8,32(sp)
ffffffffc0202c2c:	6ce2                	ld	s9,24(sp)
ffffffffc0202c2e:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0202c30:	f97fe06f          	j	ffffffffc0201bc6 <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0202c34:	c80007b7          	lui	a5,0xc8000
ffffffffc0202c38:	bc7d                	j	ffffffffc02026f6 <pmm_init+0x90>
        intr_disable();
ffffffffc0202c3a:	d75fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202c3e:	000b3783          	ld	a5,0(s6)
ffffffffc0202c42:	4505                	li	a0,1
ffffffffc0202c44:	6f9c                	ld	a5,24(a5)
ffffffffc0202c46:	9782                	jalr	a5
ffffffffc0202c48:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202c4a:	d5ffd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c4e:	b9a9                	j	ffffffffc02028a8 <pmm_init+0x242>
        intr_disable();
ffffffffc0202c50:	d5ffd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202c54:	000b3783          	ld	a5,0(s6)
ffffffffc0202c58:	4505                	li	a0,1
ffffffffc0202c5a:	6f9c                	ld	a5,24(a5)
ffffffffc0202c5c:	9782                	jalr	a5
ffffffffc0202c5e:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202c60:	d49fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c64:	b645                	j	ffffffffc0202804 <pmm_init+0x19e>
        intr_disable();
ffffffffc0202c66:	d49fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202c6a:	000b3783          	ld	a5,0(s6)
ffffffffc0202c6e:	779c                	ld	a5,40(a5)
ffffffffc0202c70:	9782                	jalr	a5
ffffffffc0202c72:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202c74:	d35fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c78:	b6b9                	j	ffffffffc02027c6 <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0202c7a:	6705                	lui	a4,0x1
ffffffffc0202c7c:	177d                	addi	a4,a4,-1
ffffffffc0202c7e:	96ba                	add	a3,a3,a4
ffffffffc0202c80:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc0202c82:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202c86:	14a77363          	bgeu	a4,a0,ffffffffc0202dcc <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc0202c8a:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc0202c8e:	fff80537          	lui	a0,0xfff80
ffffffffc0202c92:	972a                	add	a4,a4,a0
ffffffffc0202c94:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0202c96:	8c1d                	sub	s0,s0,a5
ffffffffc0202c98:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0202c9c:	00c45593          	srli	a1,s0,0xc
ffffffffc0202ca0:	9532                	add	a0,a0,a2
ffffffffc0202ca2:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202ca4:	0009b583          	ld	a1,0(s3)
}
ffffffffc0202ca8:	b4c1                	j	ffffffffc0202768 <pmm_init+0x102>
        intr_disable();
ffffffffc0202caa:	d05fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202cae:	000b3783          	ld	a5,0(s6)
ffffffffc0202cb2:	779c                	ld	a5,40(a5)
ffffffffc0202cb4:	9782                	jalr	a5
ffffffffc0202cb6:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202cb8:	cf1fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cbc:	bb79                	j	ffffffffc0202a5a <pmm_init+0x3f4>
        intr_disable();
ffffffffc0202cbe:	cf1fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202cc2:	000b3783          	ld	a5,0(s6)
ffffffffc0202cc6:	779c                	ld	a5,40(a5)
ffffffffc0202cc8:	9782                	jalr	a5
ffffffffc0202cca:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202ccc:	cddfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cd0:	b39d                	j	ffffffffc0202a36 <pmm_init+0x3d0>
ffffffffc0202cd2:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202cd4:	cdbfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202cd8:	000b3783          	ld	a5,0(s6)
ffffffffc0202cdc:	6522                	ld	a0,8(sp)
ffffffffc0202cde:	4585                	li	a1,1
ffffffffc0202ce0:	739c                	ld	a5,32(a5)
ffffffffc0202ce2:	9782                	jalr	a5
        intr_enable();
ffffffffc0202ce4:	cc5fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202ce8:	b33d                	j	ffffffffc0202a16 <pmm_init+0x3b0>
ffffffffc0202cea:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202cec:	cc3fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202cf0:	000b3783          	ld	a5,0(s6)
ffffffffc0202cf4:	6522                	ld	a0,8(sp)
ffffffffc0202cf6:	4585                	li	a1,1
ffffffffc0202cf8:	739c                	ld	a5,32(a5)
ffffffffc0202cfa:	9782                	jalr	a5
        intr_enable();
ffffffffc0202cfc:	cadfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d00:	b1dd                	j	ffffffffc02029e6 <pmm_init+0x380>
        intr_disable();
ffffffffc0202d02:	cadfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202d06:	000b3783          	ld	a5,0(s6)
ffffffffc0202d0a:	4505                	li	a0,1
ffffffffc0202d0c:	6f9c                	ld	a5,24(a5)
ffffffffc0202d0e:	9782                	jalr	a5
ffffffffc0202d10:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202d12:	c97fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d16:	b36d                	j	ffffffffc0202ac0 <pmm_init+0x45a>
        intr_disable();
ffffffffc0202d18:	c97fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d1c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d20:	779c                	ld	a5,40(a5)
ffffffffc0202d22:	9782                	jalr	a5
ffffffffc0202d24:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202d26:	c83fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d2a:	bdf9                	j	ffffffffc0202c08 <pmm_init+0x5a2>
ffffffffc0202d2c:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202d2e:	c81fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202d32:	000b3783          	ld	a5,0(s6)
ffffffffc0202d36:	6522                	ld	a0,8(sp)
ffffffffc0202d38:	4585                	li	a1,1
ffffffffc0202d3a:	739c                	ld	a5,32(a5)
ffffffffc0202d3c:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d3e:	c6bfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d42:	b55d                	j	ffffffffc0202be8 <pmm_init+0x582>
ffffffffc0202d44:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202d46:	c69fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202d4a:	000b3783          	ld	a5,0(s6)
ffffffffc0202d4e:	6522                	ld	a0,8(sp)
ffffffffc0202d50:	4585                	li	a1,1
ffffffffc0202d52:	739c                	ld	a5,32(a5)
ffffffffc0202d54:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d56:	c53fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d5a:	bdb9                	j	ffffffffc0202bb8 <pmm_init+0x552>
        intr_disable();
ffffffffc0202d5c:	c53fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202d60:	000b3783          	ld	a5,0(s6)
ffffffffc0202d64:	4585                	li	a1,1
ffffffffc0202d66:	8552                	mv	a0,s4
ffffffffc0202d68:	739c                	ld	a5,32(a5)
ffffffffc0202d6a:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d6c:	c3dfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d70:	bd29                	j	ffffffffc0202b8a <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202d72:	86a2                	mv	a3,s0
ffffffffc0202d74:	00004617          	auipc	a2,0x4
ffffffffc0202d78:	ee460613          	addi	a2,a2,-284 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0202d7c:	25300593          	li	a1,595
ffffffffc0202d80:	00004517          	auipc	a0,0x4
ffffffffc0202d84:	ff050513          	addi	a0,a0,-16 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202d88:	f0afd0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202d8c:	00004697          	auipc	a3,0x4
ffffffffc0202d90:	45468693          	addi	a3,a3,1108 # ffffffffc02071e0 <default_pmm_manager+0x5c0>
ffffffffc0202d94:	00004617          	auipc	a2,0x4
ffffffffc0202d98:	adc60613          	addi	a2,a2,-1316 # ffffffffc0206870 <commands+0x850>
ffffffffc0202d9c:	25400593          	li	a1,596
ffffffffc0202da0:	00004517          	auipc	a0,0x4
ffffffffc0202da4:	fd050513          	addi	a0,a0,-48 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202da8:	eeafd0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202dac:	00004697          	auipc	a3,0x4
ffffffffc0202db0:	3f468693          	addi	a3,a3,1012 # ffffffffc02071a0 <default_pmm_manager+0x580>
ffffffffc0202db4:	00004617          	auipc	a2,0x4
ffffffffc0202db8:	abc60613          	addi	a2,a2,-1348 # ffffffffc0206870 <commands+0x850>
ffffffffc0202dbc:	25300593          	li	a1,595
ffffffffc0202dc0:	00004517          	auipc	a0,0x4
ffffffffc0202dc4:	fb050513          	addi	a0,a0,-80 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202dc8:	ecafd0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0202dcc:	fc5fe0ef          	jal	ra,ffffffffc0201d90 <pa2page.part.0>
ffffffffc0202dd0:	fddfe0ef          	jal	ra,ffffffffc0201dac <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202dd4:	00004697          	auipc	a3,0x4
ffffffffc0202dd8:	1c468693          	addi	a3,a3,452 # ffffffffc0206f98 <default_pmm_manager+0x378>
ffffffffc0202ddc:	00004617          	auipc	a2,0x4
ffffffffc0202de0:	a9460613          	addi	a2,a2,-1388 # ffffffffc0206870 <commands+0x850>
ffffffffc0202de4:	22300593          	li	a1,547
ffffffffc0202de8:	00004517          	auipc	a0,0x4
ffffffffc0202dec:	f8850513          	addi	a0,a0,-120 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202df0:	ea2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202df4:	00004697          	auipc	a3,0x4
ffffffffc0202df8:	0e468693          	addi	a3,a3,228 # ffffffffc0206ed8 <default_pmm_manager+0x2b8>
ffffffffc0202dfc:	00004617          	auipc	a2,0x4
ffffffffc0202e00:	a7460613          	addi	a2,a2,-1420 # ffffffffc0206870 <commands+0x850>
ffffffffc0202e04:	21600593          	li	a1,534
ffffffffc0202e08:	00004517          	auipc	a0,0x4
ffffffffc0202e0c:	f6850513          	addi	a0,a0,-152 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202e10:	e82fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202e14:	00004697          	auipc	a3,0x4
ffffffffc0202e18:	08468693          	addi	a3,a3,132 # ffffffffc0206e98 <default_pmm_manager+0x278>
ffffffffc0202e1c:	00004617          	auipc	a2,0x4
ffffffffc0202e20:	a5460613          	addi	a2,a2,-1452 # ffffffffc0206870 <commands+0x850>
ffffffffc0202e24:	21500593          	li	a1,533
ffffffffc0202e28:	00004517          	auipc	a0,0x4
ffffffffc0202e2c:	f4850513          	addi	a0,a0,-184 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202e30:	e62fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202e34:	00004697          	auipc	a3,0x4
ffffffffc0202e38:	04468693          	addi	a3,a3,68 # ffffffffc0206e78 <default_pmm_manager+0x258>
ffffffffc0202e3c:	00004617          	auipc	a2,0x4
ffffffffc0202e40:	a3460613          	addi	a2,a2,-1484 # ffffffffc0206870 <commands+0x850>
ffffffffc0202e44:	21400593          	li	a1,532
ffffffffc0202e48:	00004517          	auipc	a0,0x4
ffffffffc0202e4c:	f2850513          	addi	a0,a0,-216 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202e50:	e42fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc0202e54:	00004617          	auipc	a2,0x4
ffffffffc0202e58:	e0460613          	addi	a2,a2,-508 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0202e5c:	07100593          	li	a1,113
ffffffffc0202e60:	00004517          	auipc	a0,0x4
ffffffffc0202e64:	e2050513          	addi	a0,a0,-480 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0202e68:	e2afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202e6c:	00004697          	auipc	a3,0x4
ffffffffc0202e70:	2bc68693          	addi	a3,a3,700 # ffffffffc0207128 <default_pmm_manager+0x508>
ffffffffc0202e74:	00004617          	auipc	a2,0x4
ffffffffc0202e78:	9fc60613          	addi	a2,a2,-1540 # ffffffffc0206870 <commands+0x850>
ffffffffc0202e7c:	23c00593          	li	a1,572
ffffffffc0202e80:	00004517          	auipc	a0,0x4
ffffffffc0202e84:	ef050513          	addi	a0,a0,-272 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202e88:	e0afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202e8c:	00004697          	auipc	a3,0x4
ffffffffc0202e90:	25468693          	addi	a3,a3,596 # ffffffffc02070e0 <default_pmm_manager+0x4c0>
ffffffffc0202e94:	00004617          	auipc	a2,0x4
ffffffffc0202e98:	9dc60613          	addi	a2,a2,-1572 # ffffffffc0206870 <commands+0x850>
ffffffffc0202e9c:	23a00593          	li	a1,570
ffffffffc0202ea0:	00004517          	auipc	a0,0x4
ffffffffc0202ea4:	ed050513          	addi	a0,a0,-304 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202ea8:	deafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 0);
ffffffffc0202eac:	00004697          	auipc	a3,0x4
ffffffffc0202eb0:	26468693          	addi	a3,a3,612 # ffffffffc0207110 <default_pmm_manager+0x4f0>
ffffffffc0202eb4:	00004617          	auipc	a2,0x4
ffffffffc0202eb8:	9bc60613          	addi	a2,a2,-1604 # ffffffffc0206870 <commands+0x850>
ffffffffc0202ebc:	23900593          	li	a1,569
ffffffffc0202ec0:	00004517          	auipc	a0,0x4
ffffffffc0202ec4:	eb050513          	addi	a0,a0,-336 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202ec8:	dcafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc0202ecc:	00004697          	auipc	a3,0x4
ffffffffc0202ed0:	32c68693          	addi	a3,a3,812 # ffffffffc02071f8 <default_pmm_manager+0x5d8>
ffffffffc0202ed4:	00004617          	auipc	a2,0x4
ffffffffc0202ed8:	99c60613          	addi	a2,a2,-1636 # ffffffffc0206870 <commands+0x850>
ffffffffc0202edc:	25700593          	li	a1,599
ffffffffc0202ee0:	00004517          	auipc	a0,0x4
ffffffffc0202ee4:	e9050513          	addi	a0,a0,-368 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202ee8:	daafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0202eec:	00004697          	auipc	a3,0x4
ffffffffc0202ef0:	26c68693          	addi	a3,a3,620 # ffffffffc0207158 <default_pmm_manager+0x538>
ffffffffc0202ef4:	00004617          	auipc	a2,0x4
ffffffffc0202ef8:	97c60613          	addi	a2,a2,-1668 # ffffffffc0206870 <commands+0x850>
ffffffffc0202efc:	24400593          	li	a1,580
ffffffffc0202f00:	00004517          	auipc	a0,0x4
ffffffffc0202f04:	e7050513          	addi	a0,a0,-400 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202f08:	d8afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p) == 1);
ffffffffc0202f0c:	00004697          	auipc	a3,0x4
ffffffffc0202f10:	34468693          	addi	a3,a3,836 # ffffffffc0207250 <default_pmm_manager+0x630>
ffffffffc0202f14:	00004617          	auipc	a2,0x4
ffffffffc0202f18:	95c60613          	addi	a2,a2,-1700 # ffffffffc0206870 <commands+0x850>
ffffffffc0202f1c:	25c00593          	li	a1,604
ffffffffc0202f20:	00004517          	auipc	a0,0x4
ffffffffc0202f24:	e5050513          	addi	a0,a0,-432 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202f28:	d6afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202f2c:	00004697          	auipc	a3,0x4
ffffffffc0202f30:	2e468693          	addi	a3,a3,740 # ffffffffc0207210 <default_pmm_manager+0x5f0>
ffffffffc0202f34:	00004617          	auipc	a2,0x4
ffffffffc0202f38:	93c60613          	addi	a2,a2,-1732 # ffffffffc0206870 <commands+0x850>
ffffffffc0202f3c:	25b00593          	li	a1,603
ffffffffc0202f40:	00004517          	auipc	a0,0x4
ffffffffc0202f44:	e3050513          	addi	a0,a0,-464 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202f48:	d4afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202f4c:	00004697          	auipc	a3,0x4
ffffffffc0202f50:	19468693          	addi	a3,a3,404 # ffffffffc02070e0 <default_pmm_manager+0x4c0>
ffffffffc0202f54:	00004617          	auipc	a2,0x4
ffffffffc0202f58:	91c60613          	addi	a2,a2,-1764 # ffffffffc0206870 <commands+0x850>
ffffffffc0202f5c:	23600593          	li	a1,566
ffffffffc0202f60:	00004517          	auipc	a0,0x4
ffffffffc0202f64:	e1050513          	addi	a0,a0,-496 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202f68:	d2afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0202f6c:	00004697          	auipc	a3,0x4
ffffffffc0202f70:	01468693          	addi	a3,a3,20 # ffffffffc0206f80 <default_pmm_manager+0x360>
ffffffffc0202f74:	00004617          	auipc	a2,0x4
ffffffffc0202f78:	8fc60613          	addi	a2,a2,-1796 # ffffffffc0206870 <commands+0x850>
ffffffffc0202f7c:	23500593          	li	a1,565
ffffffffc0202f80:	00004517          	auipc	a0,0x4
ffffffffc0202f84:	df050513          	addi	a0,a0,-528 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202f88:	d0afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202f8c:	00004697          	auipc	a3,0x4
ffffffffc0202f90:	16c68693          	addi	a3,a3,364 # ffffffffc02070f8 <default_pmm_manager+0x4d8>
ffffffffc0202f94:	00004617          	auipc	a2,0x4
ffffffffc0202f98:	8dc60613          	addi	a2,a2,-1828 # ffffffffc0206870 <commands+0x850>
ffffffffc0202f9c:	23200593          	li	a1,562
ffffffffc0202fa0:	00004517          	auipc	a0,0x4
ffffffffc0202fa4:	dd050513          	addi	a0,a0,-560 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202fa8:	ceafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0202fac:	00004697          	auipc	a3,0x4
ffffffffc0202fb0:	fbc68693          	addi	a3,a3,-68 # ffffffffc0206f68 <default_pmm_manager+0x348>
ffffffffc0202fb4:	00004617          	auipc	a2,0x4
ffffffffc0202fb8:	8bc60613          	addi	a2,a2,-1860 # ffffffffc0206870 <commands+0x850>
ffffffffc0202fbc:	23100593          	li	a1,561
ffffffffc0202fc0:	00004517          	auipc	a0,0x4
ffffffffc0202fc4:	db050513          	addi	a0,a0,-592 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202fc8:	ccafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0202fcc:	00004697          	auipc	a3,0x4
ffffffffc0202fd0:	03c68693          	addi	a3,a3,60 # ffffffffc0207008 <default_pmm_manager+0x3e8>
ffffffffc0202fd4:	00004617          	auipc	a2,0x4
ffffffffc0202fd8:	89c60613          	addi	a2,a2,-1892 # ffffffffc0206870 <commands+0x850>
ffffffffc0202fdc:	23000593          	li	a1,560
ffffffffc0202fe0:	00004517          	auipc	a0,0x4
ffffffffc0202fe4:	d9050513          	addi	a0,a0,-624 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0202fe8:	caafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202fec:	00004697          	auipc	a3,0x4
ffffffffc0202ff0:	0f468693          	addi	a3,a3,244 # ffffffffc02070e0 <default_pmm_manager+0x4c0>
ffffffffc0202ff4:	00004617          	auipc	a2,0x4
ffffffffc0202ff8:	87c60613          	addi	a2,a2,-1924 # ffffffffc0206870 <commands+0x850>
ffffffffc0202ffc:	22f00593          	li	a1,559
ffffffffc0203000:	00004517          	auipc	a0,0x4
ffffffffc0203004:	d7050513          	addi	a0,a0,-656 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203008:	c8afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 2);
ffffffffc020300c:	00004697          	auipc	a3,0x4
ffffffffc0203010:	0bc68693          	addi	a3,a3,188 # ffffffffc02070c8 <default_pmm_manager+0x4a8>
ffffffffc0203014:	00004617          	auipc	a2,0x4
ffffffffc0203018:	85c60613          	addi	a2,a2,-1956 # ffffffffc0206870 <commands+0x850>
ffffffffc020301c:	22e00593          	li	a1,558
ffffffffc0203020:	00004517          	auipc	a0,0x4
ffffffffc0203024:	d5050513          	addi	a0,a0,-688 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203028:	c6afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc020302c:	00004697          	auipc	a3,0x4
ffffffffc0203030:	06c68693          	addi	a3,a3,108 # ffffffffc0207098 <default_pmm_manager+0x478>
ffffffffc0203034:	00004617          	auipc	a2,0x4
ffffffffc0203038:	83c60613          	addi	a2,a2,-1988 # ffffffffc0206870 <commands+0x850>
ffffffffc020303c:	22d00593          	li	a1,557
ffffffffc0203040:	00004517          	auipc	a0,0x4
ffffffffc0203044:	d3050513          	addi	a0,a0,-720 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203048:	c4afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 1);
ffffffffc020304c:	00004697          	auipc	a3,0x4
ffffffffc0203050:	03468693          	addi	a3,a3,52 # ffffffffc0207080 <default_pmm_manager+0x460>
ffffffffc0203054:	00004617          	auipc	a2,0x4
ffffffffc0203058:	81c60613          	addi	a2,a2,-2020 # ffffffffc0206870 <commands+0x850>
ffffffffc020305c:	22b00593          	li	a1,555
ffffffffc0203060:	00004517          	auipc	a0,0x4
ffffffffc0203064:	d1050513          	addi	a0,a0,-752 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203068:	c2afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc020306c:	00004697          	auipc	a3,0x4
ffffffffc0203070:	ff468693          	addi	a3,a3,-12 # ffffffffc0207060 <default_pmm_manager+0x440>
ffffffffc0203074:	00003617          	auipc	a2,0x3
ffffffffc0203078:	7fc60613          	addi	a2,a2,2044 # ffffffffc0206870 <commands+0x850>
ffffffffc020307c:	22a00593          	li	a1,554
ffffffffc0203080:	00004517          	auipc	a0,0x4
ffffffffc0203084:	cf050513          	addi	a0,a0,-784 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203088:	c0afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(*ptep & PTE_W);
ffffffffc020308c:	00004697          	auipc	a3,0x4
ffffffffc0203090:	fc468693          	addi	a3,a3,-60 # ffffffffc0207050 <default_pmm_manager+0x430>
ffffffffc0203094:	00003617          	auipc	a2,0x3
ffffffffc0203098:	7dc60613          	addi	a2,a2,2012 # ffffffffc0206870 <commands+0x850>
ffffffffc020309c:	22900593          	li	a1,553
ffffffffc02030a0:	00004517          	auipc	a0,0x4
ffffffffc02030a4:	cd050513          	addi	a0,a0,-816 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02030a8:	beafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(*ptep & PTE_U);
ffffffffc02030ac:	00004697          	auipc	a3,0x4
ffffffffc02030b0:	f9468693          	addi	a3,a3,-108 # ffffffffc0207040 <default_pmm_manager+0x420>
ffffffffc02030b4:	00003617          	auipc	a2,0x3
ffffffffc02030b8:	7bc60613          	addi	a2,a2,1980 # ffffffffc0206870 <commands+0x850>
ffffffffc02030bc:	22800593          	li	a1,552
ffffffffc02030c0:	00004517          	auipc	a0,0x4
ffffffffc02030c4:	cb050513          	addi	a0,a0,-848 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02030c8:	bcafd0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("DTB memory info not available");
ffffffffc02030cc:	00004617          	auipc	a2,0x4
ffffffffc02030d0:	d1460613          	addi	a2,a2,-748 # ffffffffc0206de0 <default_pmm_manager+0x1c0>
ffffffffc02030d4:	06500593          	li	a1,101
ffffffffc02030d8:	00004517          	auipc	a0,0x4
ffffffffc02030dc:	c9850513          	addi	a0,a0,-872 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02030e0:	bb2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc02030e4:	00004697          	auipc	a3,0x4
ffffffffc02030e8:	07468693          	addi	a3,a3,116 # ffffffffc0207158 <default_pmm_manager+0x538>
ffffffffc02030ec:	00003617          	auipc	a2,0x3
ffffffffc02030f0:	78460613          	addi	a2,a2,1924 # ffffffffc0206870 <commands+0x850>
ffffffffc02030f4:	26e00593          	li	a1,622
ffffffffc02030f8:	00004517          	auipc	a0,0x4
ffffffffc02030fc:	c7850513          	addi	a0,a0,-904 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203100:	b92fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0203104:	00004697          	auipc	a3,0x4
ffffffffc0203108:	f0468693          	addi	a3,a3,-252 # ffffffffc0207008 <default_pmm_manager+0x3e8>
ffffffffc020310c:	00003617          	auipc	a2,0x3
ffffffffc0203110:	76460613          	addi	a2,a2,1892 # ffffffffc0206870 <commands+0x850>
ffffffffc0203114:	22700593          	li	a1,551
ffffffffc0203118:	00004517          	auipc	a0,0x4
ffffffffc020311c:	c5850513          	addi	a0,a0,-936 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203120:	b72fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0203124:	00004697          	auipc	a3,0x4
ffffffffc0203128:	ea468693          	addi	a3,a3,-348 # ffffffffc0206fc8 <default_pmm_manager+0x3a8>
ffffffffc020312c:	00003617          	auipc	a2,0x3
ffffffffc0203130:	74460613          	addi	a2,a2,1860 # ffffffffc0206870 <commands+0x850>
ffffffffc0203134:	22600593          	li	a1,550
ffffffffc0203138:	00004517          	auipc	a0,0x4
ffffffffc020313c:	c3850513          	addi	a0,a0,-968 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203140:	b52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0203144:	86d6                	mv	a3,s5
ffffffffc0203146:	00004617          	auipc	a2,0x4
ffffffffc020314a:	b1260613          	addi	a2,a2,-1262 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc020314e:	22200593          	li	a1,546
ffffffffc0203152:	00004517          	auipc	a0,0x4
ffffffffc0203156:	c1e50513          	addi	a0,a0,-994 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc020315a:	b38fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc020315e:	00004617          	auipc	a2,0x4
ffffffffc0203162:	afa60613          	addi	a2,a2,-1286 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0203166:	22100593          	li	a1,545
ffffffffc020316a:	00004517          	auipc	a0,0x4
ffffffffc020316e:	c0650513          	addi	a0,a0,-1018 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203172:	b20fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0203176:	00004697          	auipc	a3,0x4
ffffffffc020317a:	e0a68693          	addi	a3,a3,-502 # ffffffffc0206f80 <default_pmm_manager+0x360>
ffffffffc020317e:	00003617          	auipc	a2,0x3
ffffffffc0203182:	6f260613          	addi	a2,a2,1778 # ffffffffc0206870 <commands+0x850>
ffffffffc0203186:	21f00593          	li	a1,543
ffffffffc020318a:	00004517          	auipc	a0,0x4
ffffffffc020318e:	be650513          	addi	a0,a0,-1050 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203192:	b00fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0203196:	00004697          	auipc	a3,0x4
ffffffffc020319a:	dd268693          	addi	a3,a3,-558 # ffffffffc0206f68 <default_pmm_manager+0x348>
ffffffffc020319e:	00003617          	auipc	a2,0x3
ffffffffc02031a2:	6d260613          	addi	a2,a2,1746 # ffffffffc0206870 <commands+0x850>
ffffffffc02031a6:	21e00593          	li	a1,542
ffffffffc02031aa:	00004517          	auipc	a0,0x4
ffffffffc02031ae:	bc650513          	addi	a0,a0,-1082 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02031b2:	ae0fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc02031b6:	00004697          	auipc	a3,0x4
ffffffffc02031ba:	16268693          	addi	a3,a3,354 # ffffffffc0207318 <default_pmm_manager+0x6f8>
ffffffffc02031be:	00003617          	auipc	a2,0x3
ffffffffc02031c2:	6b260613          	addi	a2,a2,1714 # ffffffffc0206870 <commands+0x850>
ffffffffc02031c6:	26500593          	li	a1,613
ffffffffc02031ca:	00004517          	auipc	a0,0x4
ffffffffc02031ce:	ba650513          	addi	a0,a0,-1114 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02031d2:	ac0fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc02031d6:	00004697          	auipc	a3,0x4
ffffffffc02031da:	10a68693          	addi	a3,a3,266 # ffffffffc02072e0 <default_pmm_manager+0x6c0>
ffffffffc02031de:	00003617          	auipc	a2,0x3
ffffffffc02031e2:	69260613          	addi	a2,a2,1682 # ffffffffc0206870 <commands+0x850>
ffffffffc02031e6:	26200593          	li	a1,610
ffffffffc02031ea:	00004517          	auipc	a0,0x4
ffffffffc02031ee:	b8650513          	addi	a0,a0,-1146 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02031f2:	aa0fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p) == 2);
ffffffffc02031f6:	00004697          	auipc	a3,0x4
ffffffffc02031fa:	0ba68693          	addi	a3,a3,186 # ffffffffc02072b0 <default_pmm_manager+0x690>
ffffffffc02031fe:	00003617          	auipc	a2,0x3
ffffffffc0203202:	67260613          	addi	a2,a2,1650 # ffffffffc0206870 <commands+0x850>
ffffffffc0203206:	25e00593          	li	a1,606
ffffffffc020320a:	00004517          	auipc	a0,0x4
ffffffffc020320e:	b6650513          	addi	a0,a0,-1178 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203212:	a80fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0203216:	00004697          	auipc	a3,0x4
ffffffffc020321a:	05268693          	addi	a3,a3,82 # ffffffffc0207268 <default_pmm_manager+0x648>
ffffffffc020321e:	00003617          	auipc	a2,0x3
ffffffffc0203222:	65260613          	addi	a2,a2,1618 # ffffffffc0206870 <commands+0x850>
ffffffffc0203226:	25d00593          	li	a1,605
ffffffffc020322a:	00004517          	auipc	a0,0x4
ffffffffc020322e:	b4650513          	addi	a0,a0,-1210 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203232:	a60fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0203236:	00004617          	auipc	a2,0x4
ffffffffc020323a:	aca60613          	addi	a2,a2,-1334 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc020323e:	0c900593          	li	a1,201
ffffffffc0203242:	00004517          	auipc	a0,0x4
ffffffffc0203246:	b2e50513          	addi	a0,a0,-1234 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc020324a:	a48fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020324e:	00004617          	auipc	a2,0x4
ffffffffc0203252:	ab260613          	addi	a2,a2,-1358 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc0203256:	08100593          	li	a1,129
ffffffffc020325a:	00004517          	auipc	a0,0x4
ffffffffc020325e:	b1650513          	addi	a0,a0,-1258 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203262:	a30fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc0203266:	00004697          	auipc	a3,0x4
ffffffffc020326a:	cd268693          	addi	a3,a3,-814 # ffffffffc0206f38 <default_pmm_manager+0x318>
ffffffffc020326e:	00003617          	auipc	a2,0x3
ffffffffc0203272:	60260613          	addi	a2,a2,1538 # ffffffffc0206870 <commands+0x850>
ffffffffc0203276:	21d00593          	li	a1,541
ffffffffc020327a:	00004517          	auipc	a0,0x4
ffffffffc020327e:	af650513          	addi	a0,a0,-1290 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203282:	a10fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc0203286:	00004697          	auipc	a3,0x4
ffffffffc020328a:	c8268693          	addi	a3,a3,-894 # ffffffffc0206f08 <default_pmm_manager+0x2e8>
ffffffffc020328e:	00003617          	auipc	a2,0x3
ffffffffc0203292:	5e260613          	addi	a2,a2,1506 # ffffffffc0206870 <commands+0x850>
ffffffffc0203296:	21a00593          	li	a1,538
ffffffffc020329a:	00004517          	auipc	a0,0x4
ffffffffc020329e:	ad650513          	addi	a0,a0,-1322 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02032a2:	9f0fd0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02032a6 <copy_range>:
{
ffffffffc02032a6:	7119                	addi	sp,sp,-128
ffffffffc02032a8:	f4a6                	sd	s1,104(sp)
ffffffffc02032aa:	84b6                	mv	s1,a3
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02032ac:	8ed1                	or	a3,a3,a2
{
ffffffffc02032ae:	fc86                	sd	ra,120(sp)
ffffffffc02032b0:	f8a2                	sd	s0,112(sp)
ffffffffc02032b2:	f0ca                	sd	s2,96(sp)
ffffffffc02032b4:	ecce                	sd	s3,88(sp)
ffffffffc02032b6:	e8d2                	sd	s4,80(sp)
ffffffffc02032b8:	e4d6                	sd	s5,72(sp)
ffffffffc02032ba:	e0da                	sd	s6,64(sp)
ffffffffc02032bc:	fc5e                	sd	s7,56(sp)
ffffffffc02032be:	f862                	sd	s8,48(sp)
ffffffffc02032c0:	f466                	sd	s9,40(sp)
ffffffffc02032c2:	f06a                	sd	s10,32(sp)
ffffffffc02032c4:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02032c6:	16d2                	slli	a3,a3,0x34
{
ffffffffc02032c8:	e03a                	sd	a4,0(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02032ca:	26069763          	bnez	a3,ffffffffc0203538 <copy_range+0x292>
    assert(USER_ACCESS(start, end));
ffffffffc02032ce:	00200737          	lui	a4,0x200
ffffffffc02032d2:	8bb2                	mv	s7,a2
ffffffffc02032d4:	20e66563          	bltu	a2,a4,ffffffffc02034de <copy_range+0x238>
ffffffffc02032d8:	20967363          	bgeu	a2,s1,ffffffffc02034de <copy_range+0x238>
ffffffffc02032dc:	4705                	li	a4,1
ffffffffc02032de:	077e                	slli	a4,a4,0x1f
ffffffffc02032e0:	1e976f63          	bltu	a4,s1,ffffffffc02034de <copy_range+0x238>
ffffffffc02032e4:	5c7d                	li	s8,-1
ffffffffc02032e6:	00cc5793          	srli	a5,s8,0xc
ffffffffc02032ea:	8a2a                	mv	s4,a0
ffffffffc02032ec:	892e                	mv	s2,a1
        start += PGSIZE;
ffffffffc02032ee:	6985                	lui	s3,0x1
    if (PPN(pa) >= npage)
ffffffffc02032f0:	000e4b17          	auipc	s6,0xe4
ffffffffc02032f4:	b38b0b13          	addi	s6,s6,-1224 # ffffffffc02e6e28 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02032f8:	fff80cb7          	lui	s9,0xfff80
ffffffffc02032fc:	000e4a97          	auipc	s5,0xe4
ffffffffc0203300:	b34a8a93          	addi	s5,s5,-1228 # ffffffffc02e6e30 <pages>
    return KADDR(page2pa(page));
ffffffffc0203304:	e43e                	sd	a5,8(sp)
        page = pmm_manager->alloc_pages(n);
ffffffffc0203306:	000e4d17          	auipc	s10,0xe4
ffffffffc020330a:	b32d0d13          	addi	s10,s10,-1230 # ffffffffc02e6e38 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc020330e:	4601                	li	a2,0
ffffffffc0203310:	85de                	mv	a1,s7
ffffffffc0203312:	854a                	mv	a0,s2
ffffffffc0203314:	b6dfe0ef          	jal	ra,ffffffffc0201e80 <get_pte>
        if (ptep == NULL)
ffffffffc0203318:	cd51                	beqz	a0,ffffffffc02033b4 <copy_range+0x10e>
        if (*ptep & PTE_V)
ffffffffc020331a:	6100                	ld	s0,0(a0)
ffffffffc020331c:	00147713          	andi	a4,s0,1
ffffffffc0203320:	e70d                	bnez	a4,ffffffffc020334a <copy_range+0xa4>
        start += PGSIZE;
ffffffffc0203322:	9bce                	add	s7,s7,s3
    } while (start != 0 && start < end);
ffffffffc0203324:	fe9be5e3          	bltu	s7,s1,ffffffffc020330e <copy_range+0x68>
    return 0;
ffffffffc0203328:	4401                	li	s0,0
}
ffffffffc020332a:	70e6                	ld	ra,120(sp)
ffffffffc020332c:	8522                	mv	a0,s0
ffffffffc020332e:	7446                	ld	s0,112(sp)
ffffffffc0203330:	74a6                	ld	s1,104(sp)
ffffffffc0203332:	7906                	ld	s2,96(sp)
ffffffffc0203334:	69e6                	ld	s3,88(sp)
ffffffffc0203336:	6a46                	ld	s4,80(sp)
ffffffffc0203338:	6aa6                	ld	s5,72(sp)
ffffffffc020333a:	6b06                	ld	s6,64(sp)
ffffffffc020333c:	7be2                	ld	s7,56(sp)
ffffffffc020333e:	7c42                	ld	s8,48(sp)
ffffffffc0203340:	7ca2                	ld	s9,40(sp)
ffffffffc0203342:	7d02                	ld	s10,32(sp)
ffffffffc0203344:	6de2                	ld	s11,24(sp)
ffffffffc0203346:	6109                	addi	sp,sp,128
ffffffffc0203348:	8082                	ret
    if (PPN(pa) >= npage)
ffffffffc020334a:	000b3683          	ld	a3,0(s6)
    return pa2page(PTE_ADDR(pte));
ffffffffc020334e:	00241713          	slli	a4,s0,0x2
ffffffffc0203352:	8331                	srli	a4,a4,0xc
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0203354:	2401                	sext.w	s0,s0
    if (PPN(pa) >= npage)
ffffffffc0203356:	16d77863          	bgeu	a4,a3,ffffffffc02034c6 <copy_range+0x220>
    return &pages[PPN(pa) - nbase];
ffffffffc020335a:	000ab803          	ld	a6,0(s5)
ffffffffc020335e:	9766                	add	a4,a4,s9
ffffffffc0203360:	071a                	slli	a4,a4,0x6
ffffffffc0203362:	00e80c33          	add	s8,a6,a4
            assert(page != NULL);
ffffffffc0203366:	140c0063          	beqz	s8,ffffffffc02034a6 <copy_range+0x200>
            if (share)
ffffffffc020336a:	6782                	ld	a5,0(sp)
ffffffffc020336c:	c3ad                	beqz	a5,ffffffffc02033ce <copy_range+0x128>
    return page - pages + nbase;
ffffffffc020336e:	000806b7          	lui	a3,0x80
ffffffffc0203372:	8719                	srai	a4,a4,0x6
ffffffffc0203374:	9736                	add	a4,a4,a3
                uint32_t perm_no_write = perm & (~PTE_W);
ffffffffc0203376:	886d                	andi	s0,s0,27
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0203378:	072a                	slli	a4,a4,0xa
ffffffffc020337a:	8f41                	or	a4,a4,s0
ffffffffc020337c:	00176713          	ori	a4,a4,1
                *ptep = pte_create(page2ppn(page), PTE_V | perm_no_write);
ffffffffc0203380:	e118                	sd	a4,0(a0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0203382:	120b8073          	sfence.vma	s7
                if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc0203386:	4605                	li	a2,1
ffffffffc0203388:	85de                	mv	a1,s7
ffffffffc020338a:	8552                	mv	a0,s4
ffffffffc020338c:	af5fe0ef          	jal	ra,ffffffffc0201e80 <get_pte>
ffffffffc0203390:	0e050363          	beqz	a0,ffffffffc0203476 <copy_range+0x1d0>
                if (page_insert(to, page, start, perm_no_write) != 0)
ffffffffc0203394:	86a2                	mv	a3,s0
ffffffffc0203396:	865e                	mv	a2,s7
ffffffffc0203398:	85e2                	mv	a1,s8
ffffffffc020339a:	8552                	mv	a0,s4
ffffffffc020339c:	9d4ff0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc02033a0:	e979                	bnez	a0,ffffffffc0203476 <copy_range+0x1d0>
                cprintf("EAGER_TO_SHARED: shared page at va %p\n", (void *)start);
ffffffffc02033a2:	85de                	mv	a1,s7
ffffffffc02033a4:	00004517          	auipc	a0,0x4
ffffffffc02033a8:	fcc50513          	addi	a0,a0,-52 # ffffffffc0207370 <default_pmm_manager+0x750>
ffffffffc02033ac:	dedfc0ef          	jal	ra,ffffffffc0200198 <cprintf>
        start += PGSIZE;
ffffffffc02033b0:	9bce                	add	s7,s7,s3
    } while (start != 0 && start < end);
ffffffffc02033b2:	bf8d                	j	ffffffffc0203324 <copy_range+0x7e>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02033b4:	00200637          	lui	a2,0x200
ffffffffc02033b8:	00cb87b3          	add	a5,s7,a2
ffffffffc02033bc:	ffe00637          	lui	a2,0xffe00
ffffffffc02033c0:	00c7fbb3          	and	s7,a5,a2
    } while (start != 0 && start < end);
ffffffffc02033c4:	f60b82e3          	beqz	s7,ffffffffc0203328 <copy_range+0x82>
ffffffffc02033c8:	f49be3e3          	bltu	s7,s1,ffffffffc020330e <copy_range+0x68>
ffffffffc02033cc:	bfb1                	j	ffffffffc0203328 <copy_range+0x82>
                if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc02033ce:	4605                	li	a2,1
ffffffffc02033d0:	85de                	mv	a1,s7
ffffffffc02033d2:	8552                	mv	a0,s4
ffffffffc02033d4:	aadfe0ef          	jal	ra,ffffffffc0201e80 <get_pte>
ffffffffc02033d8:	cd59                	beqz	a0,ffffffffc0203476 <copy_range+0x1d0>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02033da:	10002773          	csrr	a4,sstatus
ffffffffc02033de:	8b09                	andi	a4,a4,2
ffffffffc02033e0:	e341                	bnez	a4,ffffffffc0203460 <copy_range+0x1ba>
        page = pmm_manager->alloc_pages(n);
ffffffffc02033e2:	000d3703          	ld	a4,0(s10)
ffffffffc02033e6:	4505                	li	a0,1
ffffffffc02033e8:	6f18                	ld	a4,24(a4)
ffffffffc02033ea:	9702                	jalr	a4
ffffffffc02033ec:	8daa                	mv	s11,a0
                assert(npage != NULL);
ffffffffc02033ee:	120d8563          	beqz	s11,ffffffffc0203518 <copy_range+0x272>
    return page - pages + nbase;
ffffffffc02033f2:	000ab603          	ld	a2,0(s5)
    return KADDR(page2pa(page));
ffffffffc02033f6:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc02033f8:	000805b7          	lui	a1,0x80
ffffffffc02033fc:	40cc06b3          	sub	a3,s8,a2
ffffffffc0203400:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0203402:	000b3303          	ld	t1,0(s6)
    return page - pages + nbase;
ffffffffc0203406:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc0203408:	00f6f733          	and	a4,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc020340c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020340e:	0e677963          	bgeu	a4,t1,ffffffffc0203500 <copy_range+0x25a>
ffffffffc0203412:	000e4797          	auipc	a5,0xe4
ffffffffc0203416:	a2e78793          	addi	a5,a5,-1490 # ffffffffc02e6e40 <va_pa_offset>
ffffffffc020341a:	6388                	ld	a0,0(a5)
    return page - pages + nbase;
ffffffffc020341c:	40cd8733          	sub	a4,s11,a2
    return KADDR(page2pa(page));
ffffffffc0203420:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc0203422:	8719                	srai	a4,a4,0x6
ffffffffc0203424:	972e                	add	a4,a4,a1
    return KADDR(page2pa(page));
ffffffffc0203426:	00f77633          	and	a2,a4,a5
ffffffffc020342a:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc020342e:	0732                	slli	a4,a4,0xc
    return KADDR(page2pa(page));
ffffffffc0203430:	0c667763          	bgeu	a2,t1,ffffffffc02034fe <copy_range+0x258>
                memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
ffffffffc0203434:	6605                	lui	a2,0x1
ffffffffc0203436:	953a                	add	a0,a0,a4
ffffffffc0203438:	165020ef          	jal	ra,ffffffffc0205d9c <memcpy>
                int ret = page_insert(to, npage, start, perm);
ffffffffc020343c:	01f47693          	andi	a3,s0,31
ffffffffc0203440:	865e                	mv	a2,s7
ffffffffc0203442:	85ee                	mv	a1,s11
ffffffffc0203444:	8552                	mv	a0,s4
ffffffffc0203446:	92aff0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc020344a:	842a                	mv	s0,a0
                if (ret != 0)
ffffffffc020344c:	e51d                	bnez	a0,ffffffffc020347a <copy_range+0x1d4>
                cprintf("EAGER_COPY: copied page at va %p\n", (void *)start);
ffffffffc020344e:	85de                	mv	a1,s7
ffffffffc0203450:	00004517          	auipc	a0,0x4
ffffffffc0203454:	f5850513          	addi	a0,a0,-168 # ffffffffc02073a8 <default_pmm_manager+0x788>
ffffffffc0203458:	d41fc0ef          	jal	ra,ffffffffc0200198 <cprintf>
        start += PGSIZE;
ffffffffc020345c:	9bce                	add	s7,s7,s3
    } while (start != 0 && start < end);
ffffffffc020345e:	b5d9                	j	ffffffffc0203324 <copy_range+0x7e>
        intr_disable();
ffffffffc0203460:	d4efd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203464:	000d3703          	ld	a4,0(s10)
ffffffffc0203468:	4505                	li	a0,1
ffffffffc020346a:	6f18                	ld	a4,24(a4)
ffffffffc020346c:	9702                	jalr	a4
ffffffffc020346e:	8daa                	mv	s11,a0
        intr_enable();
ffffffffc0203470:	d38fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0203474:	bfad                	j	ffffffffc02033ee <copy_range+0x148>
                    return -E_NO_MEM;
ffffffffc0203476:	5471                	li	s0,-4
ffffffffc0203478:	bd4d                	j	ffffffffc020332a <copy_range+0x84>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020347a:	100027f3          	csrr	a5,sstatus
ffffffffc020347e:	8b89                	andi	a5,a5,2
ffffffffc0203480:	eb81                	bnez	a5,ffffffffc0203490 <copy_range+0x1ea>
        pmm_manager->free_pages(base, n);
ffffffffc0203482:	000d3783          	ld	a5,0(s10)
ffffffffc0203486:	4585                	li	a1,1
ffffffffc0203488:	856e                	mv	a0,s11
ffffffffc020348a:	739c                	ld	a5,32(a5)
ffffffffc020348c:	9782                	jalr	a5
    if (flag)
ffffffffc020348e:	bd71                	j	ffffffffc020332a <copy_range+0x84>
        intr_disable();
ffffffffc0203490:	d1efd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0203494:	000d3783          	ld	a5,0(s10)
ffffffffc0203498:	4585                	li	a1,1
ffffffffc020349a:	856e                	mv	a0,s11
ffffffffc020349c:	739c                	ld	a5,32(a5)
ffffffffc020349e:	9782                	jalr	a5
        intr_enable();
ffffffffc02034a0:	d08fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02034a4:	b559                	j	ffffffffc020332a <copy_range+0x84>
            assert(page != NULL);
ffffffffc02034a6:	00004697          	auipc	a3,0x4
ffffffffc02034aa:	eba68693          	addi	a3,a3,-326 # ffffffffc0207360 <default_pmm_manager+0x740>
ffffffffc02034ae:	00003617          	auipc	a2,0x3
ffffffffc02034b2:	3c260613          	addi	a2,a2,962 # ffffffffc0206870 <commands+0x850>
ffffffffc02034b6:	19000593          	li	a1,400
ffffffffc02034ba:	00004517          	auipc	a0,0x4
ffffffffc02034be:	8b650513          	addi	a0,a0,-1866 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02034c2:	fd1fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02034c6:	00004617          	auipc	a2,0x4
ffffffffc02034ca:	86260613          	addi	a2,a2,-1950 # ffffffffc0206d28 <default_pmm_manager+0x108>
ffffffffc02034ce:	06900593          	li	a1,105
ffffffffc02034d2:	00003517          	auipc	a0,0x3
ffffffffc02034d6:	7ae50513          	addi	a0,a0,1966 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc02034da:	fb9fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02034de:	00004697          	auipc	a3,0x4
ffffffffc02034e2:	8d268693          	addi	a3,a3,-1838 # ffffffffc0206db0 <default_pmm_manager+0x190>
ffffffffc02034e6:	00003617          	auipc	a2,0x3
ffffffffc02034ea:	38a60613          	addi	a2,a2,906 # ffffffffc0206870 <commands+0x850>
ffffffffc02034ee:	17e00593          	li	a1,382
ffffffffc02034f2:	00004517          	auipc	a0,0x4
ffffffffc02034f6:	87e50513          	addi	a0,a0,-1922 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc02034fa:	f99fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc02034fe:	86ba                	mv	a3,a4
ffffffffc0203500:	00003617          	auipc	a2,0x3
ffffffffc0203504:	75860613          	addi	a2,a2,1880 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0203508:	07100593          	li	a1,113
ffffffffc020350c:	00003517          	auipc	a0,0x3
ffffffffc0203510:	77450513          	addi	a0,a0,1908 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0203514:	f7ffc0ef          	jal	ra,ffffffffc0200492 <__panic>
                assert(npage != NULL);
ffffffffc0203518:	00004697          	auipc	a3,0x4
ffffffffc020351c:	e8068693          	addi	a3,a3,-384 # ffffffffc0207398 <default_pmm_manager+0x778>
ffffffffc0203520:	00003617          	auipc	a2,0x3
ffffffffc0203524:	35060613          	addi	a2,a2,848 # ffffffffc0206870 <commands+0x850>
ffffffffc0203528:	1a700593          	li	a1,423
ffffffffc020352c:	00004517          	auipc	a0,0x4
ffffffffc0203530:	84450513          	addi	a0,a0,-1980 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203534:	f5ffc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203538:	00004697          	auipc	a3,0x4
ffffffffc020353c:	84868693          	addi	a3,a3,-1976 # ffffffffc0206d80 <default_pmm_manager+0x160>
ffffffffc0203540:	00003617          	auipc	a2,0x3
ffffffffc0203544:	33060613          	addi	a2,a2,816 # ffffffffc0206870 <commands+0x850>
ffffffffc0203548:	17d00593          	li	a1,381
ffffffffc020354c:	00004517          	auipc	a0,0x4
ffffffffc0203550:	82450513          	addi	a0,a0,-2012 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203554:	f3ffc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203558 <pgdir_alloc_page>:
{
ffffffffc0203558:	7179                	addi	sp,sp,-48
ffffffffc020355a:	ec26                	sd	s1,24(sp)
ffffffffc020355c:	e84a                	sd	s2,16(sp)
ffffffffc020355e:	e052                	sd	s4,0(sp)
ffffffffc0203560:	f406                	sd	ra,40(sp)
ffffffffc0203562:	f022                	sd	s0,32(sp)
ffffffffc0203564:	e44e                	sd	s3,8(sp)
ffffffffc0203566:	8a2a                	mv	s4,a0
ffffffffc0203568:	84ae                	mv	s1,a1
ffffffffc020356a:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020356c:	100027f3          	csrr	a5,sstatus
ffffffffc0203570:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc0203572:	000e4997          	auipc	s3,0xe4
ffffffffc0203576:	8c698993          	addi	s3,s3,-1850 # ffffffffc02e6e38 <pmm_manager>
ffffffffc020357a:	ef8d                	bnez	a5,ffffffffc02035b4 <pgdir_alloc_page+0x5c>
ffffffffc020357c:	0009b783          	ld	a5,0(s3)
ffffffffc0203580:	4505                	li	a0,1
ffffffffc0203582:	6f9c                	ld	a5,24(a5)
ffffffffc0203584:	9782                	jalr	a5
ffffffffc0203586:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc0203588:	cc09                	beqz	s0,ffffffffc02035a2 <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc020358a:	86ca                	mv	a3,s2
ffffffffc020358c:	8626                	mv	a2,s1
ffffffffc020358e:	85a2                	mv	a1,s0
ffffffffc0203590:	8552                	mv	a0,s4
ffffffffc0203592:	fdffe0ef          	jal	ra,ffffffffc0202570 <page_insert>
ffffffffc0203596:	e915                	bnez	a0,ffffffffc02035ca <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc0203598:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc020359a:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc020359c:	4785                	li	a5,1
ffffffffc020359e:	04f71e63          	bne	a4,a5,ffffffffc02035fa <pgdir_alloc_page+0xa2>
}
ffffffffc02035a2:	70a2                	ld	ra,40(sp)
ffffffffc02035a4:	8522                	mv	a0,s0
ffffffffc02035a6:	7402                	ld	s0,32(sp)
ffffffffc02035a8:	64e2                	ld	s1,24(sp)
ffffffffc02035aa:	6942                	ld	s2,16(sp)
ffffffffc02035ac:	69a2                	ld	s3,8(sp)
ffffffffc02035ae:	6a02                	ld	s4,0(sp)
ffffffffc02035b0:	6145                	addi	sp,sp,48
ffffffffc02035b2:	8082                	ret
        intr_disable();
ffffffffc02035b4:	bfafd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02035b8:	0009b783          	ld	a5,0(s3)
ffffffffc02035bc:	4505                	li	a0,1
ffffffffc02035be:	6f9c                	ld	a5,24(a5)
ffffffffc02035c0:	9782                	jalr	a5
ffffffffc02035c2:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02035c4:	be4fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02035c8:	b7c1                	j	ffffffffc0203588 <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02035ca:	100027f3          	csrr	a5,sstatus
ffffffffc02035ce:	8b89                	andi	a5,a5,2
ffffffffc02035d0:	eb89                	bnez	a5,ffffffffc02035e2 <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc02035d2:	0009b783          	ld	a5,0(s3)
ffffffffc02035d6:	8522                	mv	a0,s0
ffffffffc02035d8:	4585                	li	a1,1
ffffffffc02035da:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc02035dc:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc02035de:	9782                	jalr	a5
    if (flag)
ffffffffc02035e0:	b7c9                	j	ffffffffc02035a2 <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc02035e2:	bccfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02035e6:	0009b783          	ld	a5,0(s3)
ffffffffc02035ea:	8522                	mv	a0,s0
ffffffffc02035ec:	4585                	li	a1,1
ffffffffc02035ee:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc02035f0:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc02035f2:	9782                	jalr	a5
        intr_enable();
ffffffffc02035f4:	bb4fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02035f8:	b76d                	j	ffffffffc02035a2 <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc02035fa:	00004697          	auipc	a3,0x4
ffffffffc02035fe:	dd668693          	addi	a3,a3,-554 # ffffffffc02073d0 <default_pmm_manager+0x7b0>
ffffffffc0203602:	00003617          	auipc	a2,0x3
ffffffffc0203606:	26e60613          	addi	a2,a2,622 # ffffffffc0206870 <commands+0x850>
ffffffffc020360a:	1fb00593          	li	a1,507
ffffffffc020360e:	00003517          	auipc	a0,0x3
ffffffffc0203612:	76250513          	addi	a0,a0,1890 # ffffffffc0206d70 <default_pmm_manager+0x150>
ffffffffc0203616:	e7dfc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020361a <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc020361a:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc020361c:	00004697          	auipc	a3,0x4
ffffffffc0203620:	dcc68693          	addi	a3,a3,-564 # ffffffffc02073e8 <default_pmm_manager+0x7c8>
ffffffffc0203624:	00003617          	auipc	a2,0x3
ffffffffc0203628:	24c60613          	addi	a2,a2,588 # ffffffffc0206870 <commands+0x850>
ffffffffc020362c:	07400593          	li	a1,116
ffffffffc0203630:	00004517          	auipc	a0,0x4
ffffffffc0203634:	dd850513          	addi	a0,a0,-552 # ffffffffc0207408 <default_pmm_manager+0x7e8>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc0203638:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc020363a:	e59fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020363e <mm_create>:
{
ffffffffc020363e:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203640:	04000513          	li	a0,64
{
ffffffffc0203644:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203646:	da4fe0ef          	jal	ra,ffffffffc0201bea <kmalloc>
    if (mm != NULL)
ffffffffc020364a:	cd19                	beqz	a0,ffffffffc0203668 <mm_create+0x2a>
    elm->prev = elm->next = elm;
ffffffffc020364c:	e508                	sd	a0,8(a0)
ffffffffc020364e:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203650:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0203654:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0203658:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc020365c:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc0203660:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc0203664:	02053c23          	sd	zero,56(a0)
}
ffffffffc0203668:	60a2                	ld	ra,8(sp)
ffffffffc020366a:	0141                	addi	sp,sp,16
ffffffffc020366c:	8082                	ret

ffffffffc020366e <find_vma>:
{
ffffffffc020366e:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc0203670:	c505                	beqz	a0,ffffffffc0203698 <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0203672:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0203674:	c501                	beqz	a0,ffffffffc020367c <find_vma+0xe>
ffffffffc0203676:	651c                	ld	a5,8(a0)
ffffffffc0203678:	02f5f263          	bgeu	a1,a5,ffffffffc020369c <find_vma+0x2e>
    return listelm->next;
ffffffffc020367c:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc020367e:	00f68d63          	beq	a3,a5,ffffffffc0203698 <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc0203682:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203686:	00e5e663          	bltu	a1,a4,ffffffffc0203692 <find_vma+0x24>
ffffffffc020368a:	ff07b703          	ld	a4,-16(a5)
ffffffffc020368e:	00e5ec63          	bltu	a1,a4,ffffffffc02036a6 <find_vma+0x38>
ffffffffc0203692:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc0203694:	fef697e3          	bne	a3,a5,ffffffffc0203682 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc0203698:	4501                	li	a0,0
}
ffffffffc020369a:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc020369c:	691c                	ld	a5,16(a0)
ffffffffc020369e:	fcf5ffe3          	bgeu	a1,a5,ffffffffc020367c <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc02036a2:	ea88                	sd	a0,16(a3)
ffffffffc02036a4:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc02036a6:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc02036aa:	ea88                	sd	a0,16(a3)
ffffffffc02036ac:	8082                	ret

ffffffffc02036ae <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc02036ae:	6590                	ld	a2,8(a1)
ffffffffc02036b0:	0105b803          	ld	a6,16(a1) # 80010 <_binary_obj___user_matrix_out_size+0x738d8>
{
ffffffffc02036b4:	1141                	addi	sp,sp,-16
ffffffffc02036b6:	e406                	sd	ra,8(sp)
ffffffffc02036b8:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc02036ba:	01066763          	bltu	a2,a6,ffffffffc02036c8 <insert_vma_struct+0x1a>
ffffffffc02036be:	a085                	j	ffffffffc020371e <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc02036c0:	fe87b703          	ld	a4,-24(a5)
ffffffffc02036c4:	04e66863          	bltu	a2,a4,ffffffffc0203714 <insert_vma_struct+0x66>
ffffffffc02036c8:	86be                	mv	a3,a5
ffffffffc02036ca:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc02036cc:	fef51ae3          	bne	a0,a5,ffffffffc02036c0 <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc02036d0:	02a68463          	beq	a3,a0,ffffffffc02036f8 <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc02036d4:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc02036d8:	fe86b883          	ld	a7,-24(a3)
ffffffffc02036dc:	08e8f163          	bgeu	a7,a4,ffffffffc020375e <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02036e0:	04e66f63          	bltu	a2,a4,ffffffffc020373e <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc02036e4:	00f50a63          	beq	a0,a5,ffffffffc02036f8 <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc02036e8:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc02036ec:	05076963          	bltu	a4,a6,ffffffffc020373e <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc02036f0:	ff07b603          	ld	a2,-16(a5)
ffffffffc02036f4:	02c77363          	bgeu	a4,a2,ffffffffc020371a <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc02036f8:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc02036fa:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc02036fc:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc0203700:	e390                	sd	a2,0(a5)
ffffffffc0203702:	e690                	sd	a2,8(a3)
}
ffffffffc0203704:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc0203706:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc0203708:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc020370a:	0017079b          	addiw	a5,a4,1
ffffffffc020370e:	d11c                	sw	a5,32(a0)
}
ffffffffc0203710:	0141                	addi	sp,sp,16
ffffffffc0203712:	8082                	ret
    if (le_prev != list)
ffffffffc0203714:	fca690e3          	bne	a3,a0,ffffffffc02036d4 <insert_vma_struct+0x26>
ffffffffc0203718:	bfd1                	j	ffffffffc02036ec <insert_vma_struct+0x3e>
ffffffffc020371a:	f01ff0ef          	jal	ra,ffffffffc020361a <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc020371e:	00004697          	auipc	a3,0x4
ffffffffc0203722:	cfa68693          	addi	a3,a3,-774 # ffffffffc0207418 <default_pmm_manager+0x7f8>
ffffffffc0203726:	00003617          	auipc	a2,0x3
ffffffffc020372a:	14a60613          	addi	a2,a2,330 # ffffffffc0206870 <commands+0x850>
ffffffffc020372e:	07a00593          	li	a1,122
ffffffffc0203732:	00004517          	auipc	a0,0x4
ffffffffc0203736:	cd650513          	addi	a0,a0,-810 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc020373a:	d59fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc020373e:	00004697          	auipc	a3,0x4
ffffffffc0203742:	d1a68693          	addi	a3,a3,-742 # ffffffffc0207458 <default_pmm_manager+0x838>
ffffffffc0203746:	00003617          	auipc	a2,0x3
ffffffffc020374a:	12a60613          	addi	a2,a2,298 # ffffffffc0206870 <commands+0x850>
ffffffffc020374e:	07300593          	li	a1,115
ffffffffc0203752:	00004517          	auipc	a0,0x4
ffffffffc0203756:	cb650513          	addi	a0,a0,-842 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc020375a:	d39fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc020375e:	00004697          	auipc	a3,0x4
ffffffffc0203762:	cda68693          	addi	a3,a3,-806 # ffffffffc0207438 <default_pmm_manager+0x818>
ffffffffc0203766:	00003617          	auipc	a2,0x3
ffffffffc020376a:	10a60613          	addi	a2,a2,266 # ffffffffc0206870 <commands+0x850>
ffffffffc020376e:	07200593          	li	a1,114
ffffffffc0203772:	00004517          	auipc	a0,0x4
ffffffffc0203776:	c9650513          	addi	a0,a0,-874 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc020377a:	d19fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020377e <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc020377e:	591c                	lw	a5,48(a0)
{
ffffffffc0203780:	1141                	addi	sp,sp,-16
ffffffffc0203782:	e406                	sd	ra,8(sp)
ffffffffc0203784:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0203786:	e78d                	bnez	a5,ffffffffc02037b0 <mm_destroy+0x32>
ffffffffc0203788:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc020378a:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc020378c:	00a40c63          	beq	s0,a0,ffffffffc02037a4 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203790:	6118                	ld	a4,0(a0)
ffffffffc0203792:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc0203794:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc0203796:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0203798:	e398                	sd	a4,0(a5)
ffffffffc020379a:	d00fe0ef          	jal	ra,ffffffffc0201c9a <kfree>
    return listelm->next;
ffffffffc020379e:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc02037a0:	fea418e3          	bne	s0,a0,ffffffffc0203790 <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc02037a4:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc02037a6:	6402                	ld	s0,0(sp)
ffffffffc02037a8:	60a2                	ld	ra,8(sp)
ffffffffc02037aa:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc02037ac:	ceefe06f          	j	ffffffffc0201c9a <kfree>
    assert(mm_count(mm) == 0);
ffffffffc02037b0:	00004697          	auipc	a3,0x4
ffffffffc02037b4:	cc868693          	addi	a3,a3,-824 # ffffffffc0207478 <default_pmm_manager+0x858>
ffffffffc02037b8:	00003617          	auipc	a2,0x3
ffffffffc02037bc:	0b860613          	addi	a2,a2,184 # ffffffffc0206870 <commands+0x850>
ffffffffc02037c0:	09e00593          	li	a1,158
ffffffffc02037c4:	00004517          	auipc	a0,0x4
ffffffffc02037c8:	c4450513          	addi	a0,a0,-956 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc02037cc:	cc7fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02037d0 <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc02037d0:	7139                	addi	sp,sp,-64
ffffffffc02037d2:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02037d4:	6405                	lui	s0,0x1
ffffffffc02037d6:	147d                	addi	s0,s0,-1
ffffffffc02037d8:	77fd                	lui	a5,0xfffff
ffffffffc02037da:	9622                	add	a2,a2,s0
ffffffffc02037dc:	962e                	add	a2,a2,a1
{
ffffffffc02037de:	f426                	sd	s1,40(sp)
ffffffffc02037e0:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02037e2:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc02037e6:	f04a                	sd	s2,32(sp)
ffffffffc02037e8:	ec4e                	sd	s3,24(sp)
ffffffffc02037ea:	e852                	sd	s4,16(sp)
ffffffffc02037ec:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc02037ee:	002005b7          	lui	a1,0x200
ffffffffc02037f2:	00f67433          	and	s0,a2,a5
ffffffffc02037f6:	06b4e363          	bltu	s1,a1,ffffffffc020385c <mm_map+0x8c>
ffffffffc02037fa:	0684f163          	bgeu	s1,s0,ffffffffc020385c <mm_map+0x8c>
ffffffffc02037fe:	4785                	li	a5,1
ffffffffc0203800:	07fe                	slli	a5,a5,0x1f
ffffffffc0203802:	0487ed63          	bltu	a5,s0,ffffffffc020385c <mm_map+0x8c>
ffffffffc0203806:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc0203808:	cd21                	beqz	a0,ffffffffc0203860 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc020380a:	85a6                	mv	a1,s1
ffffffffc020380c:	8ab6                	mv	s5,a3
ffffffffc020380e:	8a3a                	mv	s4,a4
ffffffffc0203810:	e5fff0ef          	jal	ra,ffffffffc020366e <find_vma>
ffffffffc0203814:	c501                	beqz	a0,ffffffffc020381c <mm_map+0x4c>
ffffffffc0203816:	651c                	ld	a5,8(a0)
ffffffffc0203818:	0487e263          	bltu	a5,s0,ffffffffc020385c <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc020381c:	03000513          	li	a0,48
ffffffffc0203820:	bcafe0ef          	jal	ra,ffffffffc0201bea <kmalloc>
ffffffffc0203824:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc0203826:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc0203828:	02090163          	beqz	s2,ffffffffc020384a <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc020382c:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc020382e:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc0203832:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc0203836:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc020383a:	85ca                	mv	a1,s2
ffffffffc020383c:	e73ff0ef          	jal	ra,ffffffffc02036ae <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0203840:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc0203842:	000a0463          	beqz	s4,ffffffffc020384a <mm_map+0x7a>
        *vma_store = vma;
ffffffffc0203846:	012a3023          	sd	s2,0(s4)

out:
    return ret;
}
ffffffffc020384a:	70e2                	ld	ra,56(sp)
ffffffffc020384c:	7442                	ld	s0,48(sp)
ffffffffc020384e:	74a2                	ld	s1,40(sp)
ffffffffc0203850:	7902                	ld	s2,32(sp)
ffffffffc0203852:	69e2                	ld	s3,24(sp)
ffffffffc0203854:	6a42                	ld	s4,16(sp)
ffffffffc0203856:	6aa2                	ld	s5,8(sp)
ffffffffc0203858:	6121                	addi	sp,sp,64
ffffffffc020385a:	8082                	ret
        return -E_INVAL;
ffffffffc020385c:	5575                	li	a0,-3
ffffffffc020385e:	b7f5                	j	ffffffffc020384a <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc0203860:	00004697          	auipc	a3,0x4
ffffffffc0203864:	c3068693          	addi	a3,a3,-976 # ffffffffc0207490 <default_pmm_manager+0x870>
ffffffffc0203868:	00003617          	auipc	a2,0x3
ffffffffc020386c:	00860613          	addi	a2,a2,8 # ffffffffc0206870 <commands+0x850>
ffffffffc0203870:	0b300593          	li	a1,179
ffffffffc0203874:	00004517          	auipc	a0,0x4
ffffffffc0203878:	b9450513          	addi	a0,a0,-1132 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc020387c:	c17fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203880 <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc0203880:	7139                	addi	sp,sp,-64
ffffffffc0203882:	fc06                	sd	ra,56(sp)
ffffffffc0203884:	f822                	sd	s0,48(sp)
ffffffffc0203886:	f426                	sd	s1,40(sp)
ffffffffc0203888:	f04a                	sd	s2,32(sp)
ffffffffc020388a:	ec4e                	sd	s3,24(sp)
ffffffffc020388c:	e852                	sd	s4,16(sp)
ffffffffc020388e:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0203890:	c52d                	beqz	a0,ffffffffc02038fa <dup_mmap+0x7a>
ffffffffc0203892:	892a                	mv	s2,a0
ffffffffc0203894:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0203896:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc0203898:	e595                	bnez	a1,ffffffffc02038c4 <dup_mmap+0x44>
ffffffffc020389a:	a085                	j	ffffffffc02038fa <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc020389c:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc020389e:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_matrix_out_size+0x1f38d0>
        vma->vm_end = vm_end;
ffffffffc02038a2:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc02038a6:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc02038aa:	e05ff0ef          	jal	ra,ffffffffc02036ae <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc02038ae:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8f78>
ffffffffc02038b2:	fe843603          	ld	a2,-24(s0)
ffffffffc02038b6:	6c8c                	ld	a1,24(s1)
ffffffffc02038b8:	01893503          	ld	a0,24(s2)
ffffffffc02038bc:	4701                	li	a4,0
ffffffffc02038be:	9e9ff0ef          	jal	ra,ffffffffc02032a6 <copy_range>
ffffffffc02038c2:	e105                	bnez	a0,ffffffffc02038e2 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc02038c4:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc02038c6:	02848863          	beq	s1,s0,ffffffffc02038f6 <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02038ca:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc02038ce:	fe843a83          	ld	s5,-24(s0)
ffffffffc02038d2:	ff043a03          	ld	s4,-16(s0)
ffffffffc02038d6:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02038da:	b10fe0ef          	jal	ra,ffffffffc0201bea <kmalloc>
ffffffffc02038de:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc02038e0:	fd55                	bnez	a0,ffffffffc020389c <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc02038e2:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc02038e4:	70e2                	ld	ra,56(sp)
ffffffffc02038e6:	7442                	ld	s0,48(sp)
ffffffffc02038e8:	74a2                	ld	s1,40(sp)
ffffffffc02038ea:	7902                	ld	s2,32(sp)
ffffffffc02038ec:	69e2                	ld	s3,24(sp)
ffffffffc02038ee:	6a42                	ld	s4,16(sp)
ffffffffc02038f0:	6aa2                	ld	s5,8(sp)
ffffffffc02038f2:	6121                	addi	sp,sp,64
ffffffffc02038f4:	8082                	ret
    return 0;
ffffffffc02038f6:	4501                	li	a0,0
ffffffffc02038f8:	b7f5                	j	ffffffffc02038e4 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc02038fa:	00004697          	auipc	a3,0x4
ffffffffc02038fe:	ba668693          	addi	a3,a3,-1114 # ffffffffc02074a0 <default_pmm_manager+0x880>
ffffffffc0203902:	00003617          	auipc	a2,0x3
ffffffffc0203906:	f6e60613          	addi	a2,a2,-146 # ffffffffc0206870 <commands+0x850>
ffffffffc020390a:	0cf00593          	li	a1,207
ffffffffc020390e:	00004517          	auipc	a0,0x4
ffffffffc0203912:	afa50513          	addi	a0,a0,-1286 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203916:	b7dfc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020391a <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc020391a:	1101                	addi	sp,sp,-32
ffffffffc020391c:	ec06                	sd	ra,24(sp)
ffffffffc020391e:	e822                	sd	s0,16(sp)
ffffffffc0203920:	e426                	sd	s1,8(sp)
ffffffffc0203922:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0203924:	c531                	beqz	a0,ffffffffc0203970 <exit_mmap+0x56>
ffffffffc0203926:	591c                	lw	a5,48(a0)
ffffffffc0203928:	84aa                	mv	s1,a0
ffffffffc020392a:	e3b9                	bnez	a5,ffffffffc0203970 <exit_mmap+0x56>
    return listelm->next;
ffffffffc020392c:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc020392e:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc0203932:	02850663          	beq	a0,s0,ffffffffc020395e <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0203936:	ff043603          	ld	a2,-16(s0)
ffffffffc020393a:	fe843583          	ld	a1,-24(s0)
ffffffffc020393e:	854a                	mv	a0,s2
ffffffffc0203940:	fbcfe0ef          	jal	ra,ffffffffc02020fc <unmap_range>
ffffffffc0203944:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc0203946:	fe8498e3          	bne	s1,s0,ffffffffc0203936 <exit_mmap+0x1c>
ffffffffc020394a:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc020394c:	00848c63          	beq	s1,s0,ffffffffc0203964 <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0203950:	ff043603          	ld	a2,-16(s0)
ffffffffc0203954:	fe843583          	ld	a1,-24(s0)
ffffffffc0203958:	854a                	mv	a0,s2
ffffffffc020395a:	8e9fe0ef          	jal	ra,ffffffffc0202242 <exit_range>
ffffffffc020395e:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc0203960:	fe8498e3          	bne	s1,s0,ffffffffc0203950 <exit_mmap+0x36>
    }
}
ffffffffc0203964:	60e2                	ld	ra,24(sp)
ffffffffc0203966:	6442                	ld	s0,16(sp)
ffffffffc0203968:	64a2                	ld	s1,8(sp)
ffffffffc020396a:	6902                	ld	s2,0(sp)
ffffffffc020396c:	6105                	addi	sp,sp,32
ffffffffc020396e:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0203970:	00004697          	auipc	a3,0x4
ffffffffc0203974:	b5068693          	addi	a3,a3,-1200 # ffffffffc02074c0 <default_pmm_manager+0x8a0>
ffffffffc0203978:	00003617          	auipc	a2,0x3
ffffffffc020397c:	ef860613          	addi	a2,a2,-264 # ffffffffc0206870 <commands+0x850>
ffffffffc0203980:	0e800593          	li	a1,232
ffffffffc0203984:	00004517          	auipc	a0,0x4
ffffffffc0203988:	a8450513          	addi	a0,a0,-1404 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc020398c:	b07fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203990 <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc0203990:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203992:	04000513          	li	a0,64
{
ffffffffc0203996:	fc06                	sd	ra,56(sp)
ffffffffc0203998:	f822                	sd	s0,48(sp)
ffffffffc020399a:	f426                	sd	s1,40(sp)
ffffffffc020399c:	f04a                	sd	s2,32(sp)
ffffffffc020399e:	ec4e                	sd	s3,24(sp)
ffffffffc02039a0:	e852                	sd	s4,16(sp)
ffffffffc02039a2:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02039a4:	a46fe0ef          	jal	ra,ffffffffc0201bea <kmalloc>
    if (mm != NULL)
ffffffffc02039a8:	2e050663          	beqz	a0,ffffffffc0203c94 <vmm_init+0x304>
ffffffffc02039ac:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc02039ae:	e508                	sd	a0,8(a0)
ffffffffc02039b0:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc02039b2:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc02039b6:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc02039ba:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc02039be:	02053423          	sd	zero,40(a0)
ffffffffc02039c2:	02052823          	sw	zero,48(a0)
ffffffffc02039c6:	02053c23          	sd	zero,56(a0)
ffffffffc02039ca:	03200413          	li	s0,50
ffffffffc02039ce:	a811                	j	ffffffffc02039e2 <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc02039d0:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc02039d2:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc02039d4:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc02039d8:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc02039da:	8526                	mv	a0,s1
ffffffffc02039dc:	cd3ff0ef          	jal	ra,ffffffffc02036ae <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc02039e0:	c80d                	beqz	s0,ffffffffc0203a12 <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02039e2:	03000513          	li	a0,48
ffffffffc02039e6:	a04fe0ef          	jal	ra,ffffffffc0201bea <kmalloc>
ffffffffc02039ea:	85aa                	mv	a1,a0
ffffffffc02039ec:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc02039f0:	f165                	bnez	a0,ffffffffc02039d0 <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc02039f2:	00004697          	auipc	a3,0x4
ffffffffc02039f6:	c6668693          	addi	a3,a3,-922 # ffffffffc0207658 <default_pmm_manager+0xa38>
ffffffffc02039fa:	00003617          	auipc	a2,0x3
ffffffffc02039fe:	e7660613          	addi	a2,a2,-394 # ffffffffc0206870 <commands+0x850>
ffffffffc0203a02:	12c00593          	li	a1,300
ffffffffc0203a06:	00004517          	auipc	a0,0x4
ffffffffc0203a0a:	a0250513          	addi	a0,a0,-1534 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203a0e:	a85fc0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0203a12:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a16:	1f900913          	li	s2,505
ffffffffc0203a1a:	a819                	j	ffffffffc0203a30 <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc0203a1c:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203a1e:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203a20:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a24:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203a26:	8526                	mv	a0,s1
ffffffffc0203a28:	c87ff0ef          	jal	ra,ffffffffc02036ae <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a2c:	03240a63          	beq	s0,s2,ffffffffc0203a60 <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203a30:	03000513          	li	a0,48
ffffffffc0203a34:	9b6fe0ef          	jal	ra,ffffffffc0201bea <kmalloc>
ffffffffc0203a38:	85aa                	mv	a1,a0
ffffffffc0203a3a:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203a3e:	fd79                	bnez	a0,ffffffffc0203a1c <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc0203a40:	00004697          	auipc	a3,0x4
ffffffffc0203a44:	c1868693          	addi	a3,a3,-1000 # ffffffffc0207658 <default_pmm_manager+0xa38>
ffffffffc0203a48:	00003617          	auipc	a2,0x3
ffffffffc0203a4c:	e2860613          	addi	a2,a2,-472 # ffffffffc0206870 <commands+0x850>
ffffffffc0203a50:	13300593          	li	a1,307
ffffffffc0203a54:	00004517          	auipc	a0,0x4
ffffffffc0203a58:	9b450513          	addi	a0,a0,-1612 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203a5c:	a37fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return listelm->next;
ffffffffc0203a60:	649c                	ld	a5,8(s1)
ffffffffc0203a62:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc0203a64:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc0203a68:	16f48663          	beq	s1,a5,ffffffffc0203bd4 <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203a6c:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd18170>
ffffffffc0203a70:	ffe70693          	addi	a3,a4,-2 # 1ffffe <_binary_obj___user_matrix_out_size+0x1f38c6>
ffffffffc0203a74:	10d61063          	bne	a2,a3,ffffffffc0203b74 <vmm_init+0x1e4>
ffffffffc0203a78:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203a7c:	0ed71c63          	bne	a4,a3,ffffffffc0203b74 <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0203a80:	0715                	addi	a4,a4,5
ffffffffc0203a82:	679c                	ld	a5,8(a5)
ffffffffc0203a84:	feb712e3          	bne	a4,a1,ffffffffc0203a68 <vmm_init+0xd8>
ffffffffc0203a88:	4a1d                	li	s4,7
ffffffffc0203a8a:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203a8c:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0203a90:	85a2                	mv	a1,s0
ffffffffc0203a92:	8526                	mv	a0,s1
ffffffffc0203a94:	bdbff0ef          	jal	ra,ffffffffc020366e <find_vma>
ffffffffc0203a98:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc0203a9a:	16050d63          	beqz	a0,ffffffffc0203c14 <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0203a9e:	00140593          	addi	a1,s0,1
ffffffffc0203aa2:	8526                	mv	a0,s1
ffffffffc0203aa4:	bcbff0ef          	jal	ra,ffffffffc020366e <find_vma>
ffffffffc0203aa8:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc0203aaa:	14050563          	beqz	a0,ffffffffc0203bf4 <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0203aae:	85d2                	mv	a1,s4
ffffffffc0203ab0:	8526                	mv	a0,s1
ffffffffc0203ab2:	bbdff0ef          	jal	ra,ffffffffc020366e <find_vma>
        assert(vma3 == NULL);
ffffffffc0203ab6:	16051f63          	bnez	a0,ffffffffc0203c34 <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc0203aba:	00340593          	addi	a1,s0,3
ffffffffc0203abe:	8526                	mv	a0,s1
ffffffffc0203ac0:	bafff0ef          	jal	ra,ffffffffc020366e <find_vma>
        assert(vma4 == NULL);
ffffffffc0203ac4:	1a051863          	bnez	a0,ffffffffc0203c74 <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc0203ac8:	00440593          	addi	a1,s0,4
ffffffffc0203acc:	8526                	mv	a0,s1
ffffffffc0203ace:	ba1ff0ef          	jal	ra,ffffffffc020366e <find_vma>
        assert(vma5 == NULL);
ffffffffc0203ad2:	18051163          	bnez	a0,ffffffffc0203c54 <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203ad6:	00893783          	ld	a5,8(s2)
ffffffffc0203ada:	0a879d63          	bne	a5,s0,ffffffffc0203b94 <vmm_init+0x204>
ffffffffc0203ade:	01093783          	ld	a5,16(s2)
ffffffffc0203ae2:	0b479963          	bne	a5,s4,ffffffffc0203b94 <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203ae6:	0089b783          	ld	a5,8(s3)
ffffffffc0203aea:	0c879563          	bne	a5,s0,ffffffffc0203bb4 <vmm_init+0x224>
ffffffffc0203aee:	0109b783          	ld	a5,16(s3)
ffffffffc0203af2:	0d479163          	bne	a5,s4,ffffffffc0203bb4 <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203af6:	0415                	addi	s0,s0,5
ffffffffc0203af8:	0a15                	addi	s4,s4,5
ffffffffc0203afa:	f9541be3          	bne	s0,s5,ffffffffc0203a90 <vmm_init+0x100>
ffffffffc0203afe:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc0203b00:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc0203b02:	85a2                	mv	a1,s0
ffffffffc0203b04:	8526                	mv	a0,s1
ffffffffc0203b06:	b69ff0ef          	jal	ra,ffffffffc020366e <find_vma>
ffffffffc0203b0a:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc0203b0e:	c90d                	beqz	a0,ffffffffc0203b40 <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc0203b10:	6914                	ld	a3,16(a0)
ffffffffc0203b12:	6510                	ld	a2,8(a0)
ffffffffc0203b14:	00004517          	auipc	a0,0x4
ffffffffc0203b18:	acc50513          	addi	a0,a0,-1332 # ffffffffc02075e0 <default_pmm_manager+0x9c0>
ffffffffc0203b1c:	e7cfc0ef          	jal	ra,ffffffffc0200198 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0203b20:	00004697          	auipc	a3,0x4
ffffffffc0203b24:	ae868693          	addi	a3,a3,-1304 # ffffffffc0207608 <default_pmm_manager+0x9e8>
ffffffffc0203b28:	00003617          	auipc	a2,0x3
ffffffffc0203b2c:	d4860613          	addi	a2,a2,-696 # ffffffffc0206870 <commands+0x850>
ffffffffc0203b30:	15900593          	li	a1,345
ffffffffc0203b34:	00004517          	auipc	a0,0x4
ffffffffc0203b38:	8d450513          	addi	a0,a0,-1836 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203b3c:	957fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0203b40:	147d                	addi	s0,s0,-1
ffffffffc0203b42:	fd2410e3          	bne	s0,s2,ffffffffc0203b02 <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc0203b46:	8526                	mv	a0,s1
ffffffffc0203b48:	c37ff0ef          	jal	ra,ffffffffc020377e <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0203b4c:	00004517          	auipc	a0,0x4
ffffffffc0203b50:	ad450513          	addi	a0,a0,-1324 # ffffffffc0207620 <default_pmm_manager+0xa00>
ffffffffc0203b54:	e44fc0ef          	jal	ra,ffffffffc0200198 <cprintf>
}
ffffffffc0203b58:	7442                	ld	s0,48(sp)
ffffffffc0203b5a:	70e2                	ld	ra,56(sp)
ffffffffc0203b5c:	74a2                	ld	s1,40(sp)
ffffffffc0203b5e:	7902                	ld	s2,32(sp)
ffffffffc0203b60:	69e2                	ld	s3,24(sp)
ffffffffc0203b62:	6a42                	ld	s4,16(sp)
ffffffffc0203b64:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203b66:	00004517          	auipc	a0,0x4
ffffffffc0203b6a:	ada50513          	addi	a0,a0,-1318 # ffffffffc0207640 <default_pmm_manager+0xa20>
}
ffffffffc0203b6e:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203b70:	e28fc06f          	j	ffffffffc0200198 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203b74:	00004697          	auipc	a3,0x4
ffffffffc0203b78:	98468693          	addi	a3,a3,-1660 # ffffffffc02074f8 <default_pmm_manager+0x8d8>
ffffffffc0203b7c:	00003617          	auipc	a2,0x3
ffffffffc0203b80:	cf460613          	addi	a2,a2,-780 # ffffffffc0206870 <commands+0x850>
ffffffffc0203b84:	13d00593          	li	a1,317
ffffffffc0203b88:	00004517          	auipc	a0,0x4
ffffffffc0203b8c:	88050513          	addi	a0,a0,-1920 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203b90:	903fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203b94:	00004697          	auipc	a3,0x4
ffffffffc0203b98:	9ec68693          	addi	a3,a3,-1556 # ffffffffc0207580 <default_pmm_manager+0x960>
ffffffffc0203b9c:	00003617          	auipc	a2,0x3
ffffffffc0203ba0:	cd460613          	addi	a2,a2,-812 # ffffffffc0206870 <commands+0x850>
ffffffffc0203ba4:	14e00593          	li	a1,334
ffffffffc0203ba8:	00004517          	auipc	a0,0x4
ffffffffc0203bac:	86050513          	addi	a0,a0,-1952 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203bb0:	8e3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203bb4:	00004697          	auipc	a3,0x4
ffffffffc0203bb8:	9fc68693          	addi	a3,a3,-1540 # ffffffffc02075b0 <default_pmm_manager+0x990>
ffffffffc0203bbc:	00003617          	auipc	a2,0x3
ffffffffc0203bc0:	cb460613          	addi	a2,a2,-844 # ffffffffc0206870 <commands+0x850>
ffffffffc0203bc4:	14f00593          	li	a1,335
ffffffffc0203bc8:	00004517          	auipc	a0,0x4
ffffffffc0203bcc:	84050513          	addi	a0,a0,-1984 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203bd0:	8c3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc0203bd4:	00004697          	auipc	a3,0x4
ffffffffc0203bd8:	90c68693          	addi	a3,a3,-1780 # ffffffffc02074e0 <default_pmm_manager+0x8c0>
ffffffffc0203bdc:	00003617          	auipc	a2,0x3
ffffffffc0203be0:	c9460613          	addi	a2,a2,-876 # ffffffffc0206870 <commands+0x850>
ffffffffc0203be4:	13b00593          	li	a1,315
ffffffffc0203be8:	00004517          	auipc	a0,0x4
ffffffffc0203bec:	82050513          	addi	a0,a0,-2016 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203bf0:	8a3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma2 != NULL);
ffffffffc0203bf4:	00004697          	auipc	a3,0x4
ffffffffc0203bf8:	94c68693          	addi	a3,a3,-1716 # ffffffffc0207540 <default_pmm_manager+0x920>
ffffffffc0203bfc:	00003617          	auipc	a2,0x3
ffffffffc0203c00:	c7460613          	addi	a2,a2,-908 # ffffffffc0206870 <commands+0x850>
ffffffffc0203c04:	14600593          	li	a1,326
ffffffffc0203c08:	00004517          	auipc	a0,0x4
ffffffffc0203c0c:	80050513          	addi	a0,a0,-2048 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203c10:	883fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma1 != NULL);
ffffffffc0203c14:	00004697          	auipc	a3,0x4
ffffffffc0203c18:	91c68693          	addi	a3,a3,-1764 # ffffffffc0207530 <default_pmm_manager+0x910>
ffffffffc0203c1c:	00003617          	auipc	a2,0x3
ffffffffc0203c20:	c5460613          	addi	a2,a2,-940 # ffffffffc0206870 <commands+0x850>
ffffffffc0203c24:	14400593          	li	a1,324
ffffffffc0203c28:	00003517          	auipc	a0,0x3
ffffffffc0203c2c:	7e050513          	addi	a0,a0,2016 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203c30:	863fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma3 == NULL);
ffffffffc0203c34:	00004697          	auipc	a3,0x4
ffffffffc0203c38:	91c68693          	addi	a3,a3,-1764 # ffffffffc0207550 <default_pmm_manager+0x930>
ffffffffc0203c3c:	00003617          	auipc	a2,0x3
ffffffffc0203c40:	c3460613          	addi	a2,a2,-972 # ffffffffc0206870 <commands+0x850>
ffffffffc0203c44:	14800593          	li	a1,328
ffffffffc0203c48:	00003517          	auipc	a0,0x3
ffffffffc0203c4c:	7c050513          	addi	a0,a0,1984 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203c50:	843fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma5 == NULL);
ffffffffc0203c54:	00004697          	auipc	a3,0x4
ffffffffc0203c58:	91c68693          	addi	a3,a3,-1764 # ffffffffc0207570 <default_pmm_manager+0x950>
ffffffffc0203c5c:	00003617          	auipc	a2,0x3
ffffffffc0203c60:	c1460613          	addi	a2,a2,-1004 # ffffffffc0206870 <commands+0x850>
ffffffffc0203c64:	14c00593          	li	a1,332
ffffffffc0203c68:	00003517          	auipc	a0,0x3
ffffffffc0203c6c:	7a050513          	addi	a0,a0,1952 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203c70:	823fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma4 == NULL);
ffffffffc0203c74:	00004697          	auipc	a3,0x4
ffffffffc0203c78:	8ec68693          	addi	a3,a3,-1812 # ffffffffc0207560 <default_pmm_manager+0x940>
ffffffffc0203c7c:	00003617          	auipc	a2,0x3
ffffffffc0203c80:	bf460613          	addi	a2,a2,-1036 # ffffffffc0206870 <commands+0x850>
ffffffffc0203c84:	14a00593          	li	a1,330
ffffffffc0203c88:	00003517          	auipc	a0,0x3
ffffffffc0203c8c:	78050513          	addi	a0,a0,1920 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203c90:	803fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(mm != NULL);
ffffffffc0203c94:	00003697          	auipc	a3,0x3
ffffffffc0203c98:	7fc68693          	addi	a3,a3,2044 # ffffffffc0207490 <default_pmm_manager+0x870>
ffffffffc0203c9c:	00003617          	auipc	a2,0x3
ffffffffc0203ca0:	bd460613          	addi	a2,a2,-1068 # ffffffffc0206870 <commands+0x850>
ffffffffc0203ca4:	12400593          	li	a1,292
ffffffffc0203ca8:	00003517          	auipc	a0,0x3
ffffffffc0203cac:	76050513          	addi	a0,a0,1888 # ffffffffc0207408 <default_pmm_manager+0x7e8>
ffffffffc0203cb0:	fe2fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203cb4 <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0203cb4:	7179                	addi	sp,sp,-48
ffffffffc0203cb6:	f022                	sd	s0,32(sp)
ffffffffc0203cb8:	f406                	sd	ra,40(sp)
ffffffffc0203cba:	ec26                	sd	s1,24(sp)
ffffffffc0203cbc:	e84a                	sd	s2,16(sp)
ffffffffc0203cbe:	e44e                	sd	s3,8(sp)
ffffffffc0203cc0:	e052                	sd	s4,0(sp)
ffffffffc0203cc2:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc0203cc4:	c135                	beqz	a0,ffffffffc0203d28 <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc0203cc6:	002007b7          	lui	a5,0x200
ffffffffc0203cca:	04f5e663          	bltu	a1,a5,ffffffffc0203d16 <user_mem_check+0x62>
ffffffffc0203cce:	00c584b3          	add	s1,a1,a2
ffffffffc0203cd2:	0495f263          	bgeu	a1,s1,ffffffffc0203d16 <user_mem_check+0x62>
ffffffffc0203cd6:	4785                	li	a5,1
ffffffffc0203cd8:	07fe                	slli	a5,a5,0x1f
ffffffffc0203cda:	0297ee63          	bltu	a5,s1,ffffffffc0203d16 <user_mem_check+0x62>
ffffffffc0203cde:	892a                	mv	s2,a0
ffffffffc0203ce0:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203ce2:	6a05                	lui	s4,0x1
ffffffffc0203ce4:	a821                	j	ffffffffc0203cfc <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203ce6:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203cea:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203cec:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203cee:	c685                	beqz	a3,ffffffffc0203d16 <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203cf0:	c399                	beqz	a5,ffffffffc0203cf6 <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203cf2:	02e46263          	bltu	s0,a4,ffffffffc0203d16 <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0203cf6:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc0203cf8:	04947663          	bgeu	s0,s1,ffffffffc0203d44 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc0203cfc:	85a2                	mv	a1,s0
ffffffffc0203cfe:	854a                	mv	a0,s2
ffffffffc0203d00:	96fff0ef          	jal	ra,ffffffffc020366e <find_vma>
ffffffffc0203d04:	c909                	beqz	a0,ffffffffc0203d16 <user_mem_check+0x62>
ffffffffc0203d06:	6518                	ld	a4,8(a0)
ffffffffc0203d08:	00e46763          	bltu	s0,a4,ffffffffc0203d16 <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d0c:	4d1c                	lw	a5,24(a0)
ffffffffc0203d0e:	fc099ce3          	bnez	s3,ffffffffc0203ce6 <user_mem_check+0x32>
ffffffffc0203d12:	8b85                	andi	a5,a5,1
ffffffffc0203d14:	f3ed                	bnez	a5,ffffffffc0203cf6 <user_mem_check+0x42>
            return 0;
ffffffffc0203d16:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc0203d18:	70a2                	ld	ra,40(sp)
ffffffffc0203d1a:	7402                	ld	s0,32(sp)
ffffffffc0203d1c:	64e2                	ld	s1,24(sp)
ffffffffc0203d1e:	6942                	ld	s2,16(sp)
ffffffffc0203d20:	69a2                	ld	s3,8(sp)
ffffffffc0203d22:	6a02                	ld	s4,0(sp)
ffffffffc0203d24:	6145                	addi	sp,sp,48
ffffffffc0203d26:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203d28:	c02007b7          	lui	a5,0xc0200
ffffffffc0203d2c:	4501                	li	a0,0
ffffffffc0203d2e:	fef5e5e3          	bltu	a1,a5,ffffffffc0203d18 <user_mem_check+0x64>
ffffffffc0203d32:	962e                	add	a2,a2,a1
ffffffffc0203d34:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203d18 <user_mem_check+0x64>
ffffffffc0203d38:	c8000537          	lui	a0,0xc8000
ffffffffc0203d3c:	0505                	addi	a0,a0,1
ffffffffc0203d3e:	00a63533          	sltu	a0,a2,a0
ffffffffc0203d42:	bfd9                	j	ffffffffc0203d18 <user_mem_check+0x64>
        return 1;
ffffffffc0203d44:	4505                	li	a0,1
ffffffffc0203d46:	bfc9                	j	ffffffffc0203d18 <user_mem_check+0x64>

ffffffffc0203d48 <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203d48:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203d4a:	9402                	jalr	s0

	jal do_exit
ffffffffc0203d4c:	5ce000ef          	jal	ra,ffffffffc020431a <do_exit>

ffffffffc0203d50 <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203d50:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203d52:	14800513          	li	a0,328
{
ffffffffc0203d56:	e022                	sd	s0,0(sp)
ffffffffc0203d58:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203d5a:	e91fd0ef          	jal	ra,ffffffffc0201bea <kmalloc>
ffffffffc0203d5e:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203d60:	c549                	beqz	a0,ffffffffc0203dea <alloc_proc+0x9a>
        /*
         * below fields(add in LAB5) in proc_struct need to be initialized
         *       uint32_t wait_state;                        // waiting state
         *       struct proc_struct *cptr, *yptr, *optr;     // relations between processes
         */
        proc->state = PROC_UNINIT;
ffffffffc0203d62:	57fd                	li	a5,-1
ffffffffc0203d64:	1782                	slli	a5,a5,0x20
ffffffffc0203d66:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context)); 
ffffffffc0203d68:	07000613          	li	a2,112
ffffffffc0203d6c:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc0203d6e:	00052423          	sw	zero,8(a0) # ffffffffc8000008 <end+0x7d19190>
        proc->kstack = 0;
ffffffffc0203d72:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203d76:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc0203d7a:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc0203d7e:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context)); 
ffffffffc0203d82:	03050513          	addi	a0,a0,48
ffffffffc0203d86:	004020ef          	jal	ra,ffffffffc0205d8a <memset>
        proc->tf = NULL;
        proc->pgdir = 0;
        proc->flags = 0;
        memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203d8a:	4641                	li	a2,16
        proc->tf = NULL;
ffffffffc0203d8c:	0a043023          	sd	zero,160(s0)
        proc->pgdir = 0;
ffffffffc0203d90:	0a043423          	sd	zero,168(s0)
        proc->flags = 0;
ffffffffc0203d94:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203d98:	4581                	li	a1,0
ffffffffc0203d9a:	0b440513          	addi	a0,s0,180
ffffffffc0203d9e:	7ed010ef          	jal	ra,ffffffffc0205d8a <memset>
         *       skew_heap_entry_t lab6_run_pool;            // entry in the run pool (lab6 stride)
         *       uint32_t lab6_stride;                       // stride value (lab6 stride)
         *       uint32_t lab6_priority;                     // priority value (lab6 stride)
         */
        proc->rq = NULL;
        list_init(&(proc->run_link));
ffffffffc0203da2:	11040793          	addi	a5,s0,272
    elm->prev = elm->next = elm;
ffffffffc0203da6:	10f43c23          	sd	a5,280(s0)
ffffffffc0203daa:	10f43823          	sd	a5,272(s0)
        proc->time_slice = 0;
        skew_heap_init(&(proc->lab6_run_pool));
        proc->lab6_stride = 0;
ffffffffc0203dae:	4785                	li	a5,1
        list_init(&(proc->list_link));
ffffffffc0203db0:	0c840693          	addi	a3,s0,200
        list_init(&(proc->hash_link));
ffffffffc0203db4:	0d840713          	addi	a4,s0,216
        proc->lab6_stride = 0;
ffffffffc0203db8:	1782                	slli	a5,a5,0x20
ffffffffc0203dba:	e874                	sd	a3,208(s0)
ffffffffc0203dbc:	e474                	sd	a3,200(s0)
ffffffffc0203dbe:	f078                	sd	a4,224(s0)
ffffffffc0203dc0:	ec78                	sd	a4,216(s0)
        proc->exit_code = 0; // 进程退出码初始化为0，默认正常退出
ffffffffc0203dc2:	0e043423          	sd	zero,232(s0)
        proc->cptr = proc->yptr = proc->optr = NULL; // cptr指向第一个子进程，yptr指向下一个兄弟进程，optr指向上一个兄弟进程.先都设置为空
ffffffffc0203dc6:	0e043823          	sd	zero,240(s0)
ffffffffc0203dca:	0e043c23          	sd	zero,248(s0)
ffffffffc0203dce:	10043023          	sd	zero,256(s0)
        proc->rq = NULL;
ffffffffc0203dd2:	10043423          	sd	zero,264(s0)
        proc->time_slice = 0;
ffffffffc0203dd6:	12042023          	sw	zero,288(s0)
     compare_f comp) __attribute__((always_inline));

static inline void
skew_heap_init(skew_heap_entry_t *a)
{
     a->left = a->right = a->parent = NULL;
ffffffffc0203dda:	12043423          	sd	zero,296(s0)
ffffffffc0203dde:	12043823          	sd	zero,304(s0)
ffffffffc0203de2:	12043c23          	sd	zero,312(s0)
        proc->lab6_stride = 0;
ffffffffc0203de6:	14f43023          	sd	a5,320(s0)
        proc->lab6_priority = 1;
    }
    return proc;
}
ffffffffc0203dea:	60a2                	ld	ra,8(sp)
ffffffffc0203dec:	8522                	mv	a0,s0
ffffffffc0203dee:	6402                	ld	s0,0(sp)
ffffffffc0203df0:	0141                	addi	sp,sp,16
ffffffffc0203df2:	8082                	ret

ffffffffc0203df4 <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203df4:	000e3797          	auipc	a5,0xe3
ffffffffc0203df8:	0547b783          	ld	a5,84(a5) # ffffffffc02e6e48 <current>
ffffffffc0203dfc:	73c8                	ld	a0,160(a5)
ffffffffc0203dfe:	908fd06f          	j	ffffffffc0200f06 <forkrets>

ffffffffc0203e02 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203e02:	6d14                	ld	a3,24(a0)
}

// put_pgdir - free the memory space of PDT
static void
put_pgdir(struct mm_struct *mm)
{
ffffffffc0203e04:	1141                	addi	sp,sp,-16
ffffffffc0203e06:	e406                	sd	ra,8(sp)
ffffffffc0203e08:	c02007b7          	lui	a5,0xc0200
ffffffffc0203e0c:	02f6ee63          	bltu	a3,a5,ffffffffc0203e48 <put_pgdir+0x46>
ffffffffc0203e10:	000e3517          	auipc	a0,0xe3
ffffffffc0203e14:	03053503          	ld	a0,48(a0) # ffffffffc02e6e40 <va_pa_offset>
ffffffffc0203e18:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203e1a:	82b1                	srli	a3,a3,0xc
ffffffffc0203e1c:	000e3797          	auipc	a5,0xe3
ffffffffc0203e20:	00c7b783          	ld	a5,12(a5) # ffffffffc02e6e28 <npage>
ffffffffc0203e24:	02f6fe63          	bgeu	a3,a5,ffffffffc0203e60 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203e28:	00005517          	auipc	a0,0x5
ffffffffc0203e2c:	92053503          	ld	a0,-1760(a0) # ffffffffc0208748 <nbase>
    free_page(kva2page(mm->pgdir));
}
ffffffffc0203e30:	60a2                	ld	ra,8(sp)
ffffffffc0203e32:	8e89                	sub	a3,a3,a0
ffffffffc0203e34:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203e36:	000e3517          	auipc	a0,0xe3
ffffffffc0203e3a:	ffa53503          	ld	a0,-6(a0) # ffffffffc02e6e30 <pages>
ffffffffc0203e3e:	4585                	li	a1,1
ffffffffc0203e40:	9536                	add	a0,a0,a3
}
ffffffffc0203e42:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203e44:	fc3fd06f          	j	ffffffffc0201e06 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203e48:	00003617          	auipc	a2,0x3
ffffffffc0203e4c:	eb860613          	addi	a2,a2,-328 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc0203e50:	07700593          	li	a1,119
ffffffffc0203e54:	00003517          	auipc	a0,0x3
ffffffffc0203e58:	e2c50513          	addi	a0,a0,-468 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0203e5c:	e36fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203e60:	00003617          	auipc	a2,0x3
ffffffffc0203e64:	ec860613          	addi	a2,a2,-312 # ffffffffc0206d28 <default_pmm_manager+0x108>
ffffffffc0203e68:	06900593          	li	a1,105
ffffffffc0203e6c:	00003517          	auipc	a0,0x3
ffffffffc0203e70:	e1450513          	addi	a0,a0,-492 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0203e74:	e1efc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203e78 <proc_run>:
{
ffffffffc0203e78:	7179                	addi	sp,sp,-48
ffffffffc0203e7a:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203e7c:	000e3917          	auipc	s2,0xe3
ffffffffc0203e80:	fcc90913          	addi	s2,s2,-52 # ffffffffc02e6e48 <current>
{
ffffffffc0203e84:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203e86:	00093483          	ld	s1,0(s2)
{
ffffffffc0203e8a:	f406                	sd	ra,40(sp)
ffffffffc0203e8c:	e84e                	sd	s3,16(sp)
    if (proc != current)
ffffffffc0203e8e:	04a48163          	beq	s1,a0,ffffffffc0203ed0 <proc_run+0x58>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203e92:	100027f3          	csrr	a5,sstatus
ffffffffc0203e96:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203e98:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203e9a:	e7b1                	bnez	a5,ffffffffc0203ee6 <proc_run+0x6e>
            if (current->mm != NULL)
ffffffffc0203e9c:	751c                	ld	a5,40(a0)
            current = proc;
ffffffffc0203e9e:	00a93023          	sd	a0,0(s2)
            if (current->mm != NULL)
ffffffffc0203ea2:	cf8d                	beqz	a5,ffffffffc0203edc <proc_run+0x64>
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203ea4:	755c                	ld	a5,168(a0)
ffffffffc0203ea6:	577d                	li	a4,-1
ffffffffc0203ea8:	177e                	slli	a4,a4,0x3f
ffffffffc0203eaa:	83b1                	srli	a5,a5,0xc
ffffffffc0203eac:	8fd9                	or	a5,a5,a4
ffffffffc0203eae:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(current->context));
ffffffffc0203eb2:	03050593          	addi	a1,a0,48
ffffffffc0203eb6:	03048513          	addi	a0,s1,48
ffffffffc0203eba:	178010ef          	jal	ra,ffffffffc0205032 <switch_to>
    if (flag)
ffffffffc0203ebe:	00098963          	beqz	s3,ffffffffc0203ed0 <proc_run+0x58>
}
ffffffffc0203ec2:	70a2                	ld	ra,40(sp)
ffffffffc0203ec4:	7482                	ld	s1,32(sp)
ffffffffc0203ec6:	6962                	ld	s2,24(sp)
ffffffffc0203ec8:	69c2                	ld	s3,16(sp)
ffffffffc0203eca:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203ecc:	addfc06f          	j	ffffffffc02009a8 <intr_enable>
ffffffffc0203ed0:	70a2                	ld	ra,40(sp)
ffffffffc0203ed2:	7482                	ld	s1,32(sp)
ffffffffc0203ed4:	6962                	ld	s2,24(sp)
ffffffffc0203ed6:	69c2                	ld	s3,16(sp)
ffffffffc0203ed8:	6145                	addi	sp,sp,48
ffffffffc0203eda:	8082                	ret
ffffffffc0203edc:	000e3797          	auipc	a5,0xe3
ffffffffc0203ee0:	f3c7b783          	ld	a5,-196(a5) # ffffffffc02e6e18 <boot_pgdir_pa>
ffffffffc0203ee4:	b7c9                	j	ffffffffc0203ea6 <proc_run+0x2e>
ffffffffc0203ee6:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203ee8:	ac7fc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0203eec:	6522                	ld	a0,8(sp)
ffffffffc0203eee:	4985                	li	s3,1
ffffffffc0203ef0:	b775                	j	ffffffffc0203e9c <proc_run+0x24>

ffffffffc0203ef2 <do_fork>:
 * @clone_flags: used to guide how to clone the child process
 * @stack:       the parent's user stack pointer. if stack==0, It means to fork a kernel thread.
 * @tf:          the trapframe info, which will be copied to child process's proc->tf
 */
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
{
ffffffffc0203ef2:	7119                	addi	sp,sp,-128
ffffffffc0203ef4:	f4a6                	sd	s1,104(sp)
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS)
ffffffffc0203ef6:	000e3497          	auipc	s1,0xe3
ffffffffc0203efa:	f6a48493          	addi	s1,s1,-150 # ffffffffc02e6e60 <nr_process>
ffffffffc0203efe:	4098                	lw	a4,0(s1)
{
ffffffffc0203f00:	fc86                	sd	ra,120(sp)
ffffffffc0203f02:	f8a2                	sd	s0,112(sp)
ffffffffc0203f04:	f0ca                	sd	s2,96(sp)
ffffffffc0203f06:	ecce                	sd	s3,88(sp)
ffffffffc0203f08:	e8d2                	sd	s4,80(sp)
ffffffffc0203f0a:	e4d6                	sd	s5,72(sp)
ffffffffc0203f0c:	e0da                	sd	s6,64(sp)
ffffffffc0203f0e:	fc5e                	sd	s7,56(sp)
ffffffffc0203f10:	f862                	sd	s8,48(sp)
ffffffffc0203f12:	f466                	sd	s9,40(sp)
ffffffffc0203f14:	f06a                	sd	s10,32(sp)
ffffffffc0203f16:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203f18:	6785                	lui	a5,0x1
ffffffffc0203f1a:	30f75d63          	bge	a4,a5,ffffffffc0204234 <do_fork+0x342>
ffffffffc0203f1e:	8a2a                	mv	s4,a0
ffffffffc0203f20:	892e                	mv	s2,a1
ffffffffc0203f22:	89b2                	mv	s3,a2
     *    set_links:  set the relation links of process.  ALSO SEE: remove_links:  lean the relation links of process
     *    -------------------
     *    update step 1: set child proc's parent to current process, make sure current process's wait_state is 0
     *    update step 5: insert proc_struct into hash_list && proc_list, set the relation links of process
     */
    if ((proc = alloc_proc()) == NULL)
ffffffffc0203f24:	e2dff0ef          	jal	ra,ffffffffc0203d50 <alloc_proc>
ffffffffc0203f28:	842a                	mv	s0,a0
ffffffffc0203f2a:	30050c63          	beqz	a0,ffffffffc0204242 <do_fork+0x350>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203f2e:	4509                	li	a0,2
ffffffffc0203f30:	e99fd0ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
    if (page != NULL)
ffffffffc0203f34:	2e050e63          	beqz	a0,ffffffffc0204230 <do_fork+0x33e>
    return page - pages + nbase;
ffffffffc0203f38:	000e3c97          	auipc	s9,0xe3
ffffffffc0203f3c:	ef8c8c93          	addi	s9,s9,-264 # ffffffffc02e6e30 <pages>
ffffffffc0203f40:	000cb683          	ld	a3,0(s9)
ffffffffc0203f44:	00005a97          	auipc	s5,0x5
ffffffffc0203f48:	804a8a93          	addi	s5,s5,-2044 # ffffffffc0208748 <nbase>
ffffffffc0203f4c:	000ab703          	ld	a4,0(s5)
ffffffffc0203f50:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc0203f54:	000e3d17          	auipc	s10,0xe3
ffffffffc0203f58:	ed4d0d13          	addi	s10,s10,-300 # ffffffffc02e6e28 <npage>
    return page - pages + nbase;
ffffffffc0203f5c:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0203f5e:	5b7d                	li	s6,-1
ffffffffc0203f60:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc0203f64:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0203f66:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0203f6a:	0166f633          	and	a2,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0203f6e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203f70:	2ef67063          	bgeu	a2,a5,ffffffffc0204250 <do_fork+0x35e>
ffffffffc0203f74:	000e3d97          	auipc	s11,0xe3
ffffffffc0203f78:	eccd8d93          	addi	s11,s11,-308 # ffffffffc02e6e40 <va_pa_offset>
ffffffffc0203f7c:	000db603          	ld	a2,0(s11)
    // 确保 ret 保存最新、精准的错误码,方便判断出错类型
    if ((ret = setup_kstack(proc)) != 0)
    {
        goto bad_fork_cleanup_proc;
    }
    proc->parent = current;
ffffffffc0203f80:	000e3797          	auipc	a5,0xe3
ffffffffc0203f84:	ec87b783          	ld	a5,-312(a5) # ffffffffc02e6e48 <current>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc0203f88:	0287bb83          	ld	s7,40(a5)
ffffffffc0203f8c:	96b2                	add	a3,a3,a2
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0203f8e:	e814                	sd	a3,16(s0)
    proc->parent = current;
ffffffffc0203f90:	f01c                	sd	a5,32(s0)
    // 核心改动：重置了父进程的 wait_state
    // 创建子进程时，强制将父进程（current）的 wait_state 置 0,确保父进程创建子进程后处于「无等待、可调度」的正常状态，避免异常阻塞
    // 解决问题：之前父进程在创建子进程前如果处于等待状态（如等待子进程退出），
    // 那么创建子进程后父进程会继续处于等待状态，无法被调度执行，导致子进程也无法运行，形成死锁
    current->wait_state = 0; 
ffffffffc0203f92:	e43a                	sd	a4,8(sp)
ffffffffc0203f94:	0e07a623          	sw	zero,236(a5)
    if (oldmm == NULL)
ffffffffc0203f98:	020b8863          	beqz	s7,ffffffffc0203fc8 <do_fork+0xd6>
    if (clone_flags & CLONE_VM)
ffffffffc0203f9c:	100a7a13          	andi	s4,s4,256
ffffffffc0203fa0:	1a0a0163          	beqz	s4,ffffffffc0204142 <do_fork+0x250>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc0203fa4:	030ba703          	lw	a4,48(s7)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203fa8:	018bb783          	ld	a5,24(s7)
ffffffffc0203fac:	c02006b7          	lui	a3,0xc0200
ffffffffc0203fb0:	2705                	addiw	a4,a4,1
ffffffffc0203fb2:	02eba823          	sw	a4,48(s7)
    proc->mm = mm;
ffffffffc0203fb6:	03743423          	sd	s7,40(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203fba:	2cd7e363          	bltu	a5,a3,ffffffffc0204280 <do_fork+0x38e>
ffffffffc0203fbe:	000db703          	ld	a4,0(s11)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203fc2:	6814                	ld	a3,16(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203fc4:	8f99                	sub	a5,a5,a4
ffffffffc0203fc6:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203fc8:	6789                	lui	a5,0x2
ffffffffc0203fca:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x8088>
ffffffffc0203fce:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc0203fd0:	864e                	mv	a2,s3
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203fd2:	f054                	sd	a3,160(s0)
    *(proc->tf) = *tf;
ffffffffc0203fd4:	87b6                	mv	a5,a3
ffffffffc0203fd6:	12098893          	addi	a7,s3,288
ffffffffc0203fda:	00063803          	ld	a6,0(a2)
ffffffffc0203fde:	6608                	ld	a0,8(a2)
ffffffffc0203fe0:	6a0c                	ld	a1,16(a2)
ffffffffc0203fe2:	6e18                	ld	a4,24(a2)
ffffffffc0203fe4:	0107b023          	sd	a6,0(a5)
ffffffffc0203fe8:	e788                	sd	a0,8(a5)
ffffffffc0203fea:	eb8c                	sd	a1,16(a5)
ffffffffc0203fec:	ef98                	sd	a4,24(a5)
ffffffffc0203fee:	02060613          	addi	a2,a2,32
ffffffffc0203ff2:	02078793          	addi	a5,a5,32
ffffffffc0203ff6:	ff1612e3          	bne	a2,a7,ffffffffc0203fda <do_fork+0xe8>
    proc->tf->gpr.a0 = 0;
ffffffffc0203ffa:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0203ffe:	1c090b63          	beqz	s2,ffffffffc02041d4 <do_fork+0x2e2>
    if (++last_pid >= MAX_PID)
ffffffffc0204002:	000df817          	auipc	a6,0xdf
ffffffffc0204006:	98e80813          	addi	a6,a6,-1650 # ffffffffc02e2990 <last_pid.1>
ffffffffc020400a:	00082783          	lw	a5,0(a6)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc020400e:	0126b823          	sd	s2,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0204012:	00000717          	auipc	a4,0x0
ffffffffc0204016:	de270713          	addi	a4,a4,-542 # ffffffffc0203df4 <forkret>
    if (++last_pid >= MAX_PID)
ffffffffc020401a:	0017851b          	addiw	a0,a5,1
    proc->context.ra = (uintptr_t)forkret;
ffffffffc020401e:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc0204020:	fc14                	sd	a3,56(s0)
    if (++last_pid >= MAX_PID)
ffffffffc0204022:	00a82023          	sw	a0,0(a6)
ffffffffc0204026:	6789                	lui	a5,0x2
ffffffffc0204028:	0af55663          	bge	a0,a5,ffffffffc02040d4 <do_fork+0x1e2>
    if (last_pid >= next_safe)
ffffffffc020402c:	000df317          	auipc	t1,0xdf
ffffffffc0204030:	96830313          	addi	t1,t1,-1688 # ffffffffc02e2994 <next_safe.0>
ffffffffc0204034:	00032783          	lw	a5,0(t1)
ffffffffc0204038:	000e3917          	auipc	s2,0xe3
ffffffffc020403c:	d7890913          	addi	s2,s2,-648 # ffffffffc02e6db0 <proc_list>
ffffffffc0204040:	0af55263          	bge	a0,a5,ffffffffc02040e4 <do_fork+0x1f2>
    copy_thread(proc, stack, tf);
    //移除了提前设置 proc->state = PROC_RUNNABLE 的语句
    //让 wakeup_proc 真正负责把新建进程标记为 RUNNABLE 并加入就绪队列
    //proc->state = PROC_RUNNABLE;
    bool intr_flag;
    proc->pid = get_pid();
ffffffffc0204044:	c048                	sw	a0,4(s0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204046:	100027f3          	csrr	a5,sstatus
ffffffffc020404a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020404c:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020404e:	1c079c63          	bnez	a5,ffffffffc0204226 <do_fork+0x334>
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204052:	45a9                	li	a1,10
ffffffffc0204054:	2501                	sext.w	a0,a0
ffffffffc0204056:	08f010ef          	jal	ra,ffffffffc02058e4 <hash32>
ffffffffc020405a:	02051793          	slli	a5,a0,0x20
ffffffffc020405e:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204062:	000df797          	auipc	a5,0xdf
ffffffffc0204066:	d4e78793          	addi	a5,a5,-690 # ffffffffc02e2db0 <hash_list>
ffffffffc020406a:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc020406c:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020406e:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204070:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc0204074:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc0204076:	00893603          	ld	a2,8(s2)
    prev->next = next->prev = elm;
ffffffffc020407a:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020407c:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc020407e:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc0204082:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc0204084:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc0204086:	e21c                	sd	a5,0(a2)
ffffffffc0204088:	00f93423          	sd	a5,8(s2)
    elm->next = next;
ffffffffc020408c:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc020408e:	0d243423          	sd	s2,200(s0)
    proc->yptr = NULL;
ffffffffc0204092:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204096:	10e43023          	sd	a4,256(s0)
ffffffffc020409a:	c311                	beqz	a4,ffffffffc020409e <do_fork+0x1ac>
        proc->optr->yptr = proc;
ffffffffc020409c:	ff60                	sd	s0,248(a4)
    nr_process++;
ffffffffc020409e:	409c                	lw	a5,0(s1)
    proc->parent->cptr = proc;
ffffffffc02040a0:	fae0                	sd	s0,240(a3)
    nr_process++;
ffffffffc02040a2:	2785                	addiw	a5,a5,1
ffffffffc02040a4:	c09c                	sw	a5,0(s1)
    if (flag)
ffffffffc02040a6:	12099963          	bnez	s3,ffffffffc02041d8 <do_fork+0x2e6>
        set_links(proc);
    }
    local_intr_restore(intr_flag);
    // 改动：调用 wakeup_proc(proc) 标准化唤醒：
    // 好处：不仅设置就绪态，还将子进程加入就绪队列；2. 触发调度标记，调度器能识别并调度新进程，内存复制后的子进程可正常运行。
    wakeup_proc(proc);
ffffffffc02040aa:	8522                	mv	a0,s0
ffffffffc02040ac:	5c6010ef          	jal	ra,ffffffffc0205672 <wakeup_proc>
    ret = proc->pid;
ffffffffc02040b0:	00442a03          	lw	s4,4(s0)
bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}
ffffffffc02040b4:	70e6                	ld	ra,120(sp)
ffffffffc02040b6:	7446                	ld	s0,112(sp)
ffffffffc02040b8:	74a6                	ld	s1,104(sp)
ffffffffc02040ba:	7906                	ld	s2,96(sp)
ffffffffc02040bc:	69e6                	ld	s3,88(sp)
ffffffffc02040be:	6aa6                	ld	s5,72(sp)
ffffffffc02040c0:	6b06                	ld	s6,64(sp)
ffffffffc02040c2:	7be2                	ld	s7,56(sp)
ffffffffc02040c4:	7c42                	ld	s8,48(sp)
ffffffffc02040c6:	7ca2                	ld	s9,40(sp)
ffffffffc02040c8:	7d02                	ld	s10,32(sp)
ffffffffc02040ca:	6de2                	ld	s11,24(sp)
ffffffffc02040cc:	8552                	mv	a0,s4
ffffffffc02040ce:	6a46                	ld	s4,80(sp)
ffffffffc02040d0:	6109                	addi	sp,sp,128
ffffffffc02040d2:	8082                	ret
        last_pid = 1;
ffffffffc02040d4:	4785                	li	a5,1
ffffffffc02040d6:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc02040da:	4505                	li	a0,1
ffffffffc02040dc:	000df317          	auipc	t1,0xdf
ffffffffc02040e0:	8b830313          	addi	t1,t1,-1864 # ffffffffc02e2994 <next_safe.0>
    return listelm->next;
ffffffffc02040e4:	000e3917          	auipc	s2,0xe3
ffffffffc02040e8:	ccc90913          	addi	s2,s2,-820 # ffffffffc02e6db0 <proc_list>
ffffffffc02040ec:	00893e03          	ld	t3,8(s2)
        next_safe = MAX_PID;
ffffffffc02040f0:	6789                	lui	a5,0x2
ffffffffc02040f2:	00f32023          	sw	a5,0(t1)
ffffffffc02040f6:	86aa                	mv	a3,a0
ffffffffc02040f8:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc02040fa:	6e89                	lui	t4,0x2
ffffffffc02040fc:	132e0e63          	beq	t3,s2,ffffffffc0204238 <do_fork+0x346>
ffffffffc0204100:	88ae                	mv	a7,a1
ffffffffc0204102:	87f2                	mv	a5,t3
ffffffffc0204104:	6609                	lui	a2,0x2
ffffffffc0204106:	a811                	j	ffffffffc020411a <do_fork+0x228>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc0204108:	00e6d663          	bge	a3,a4,ffffffffc0204114 <do_fork+0x222>
ffffffffc020410c:	00c75463          	bge	a4,a2,ffffffffc0204114 <do_fork+0x222>
ffffffffc0204110:	863a                	mv	a2,a4
ffffffffc0204112:	4885                	li	a7,1
ffffffffc0204114:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204116:	01278d63          	beq	a5,s2,ffffffffc0204130 <do_fork+0x23e>
            if (proc->pid == last_pid)
ffffffffc020411a:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x802c>
ffffffffc020411e:	fed715e3          	bne	a4,a3,ffffffffc0204108 <do_fork+0x216>
                if (++last_pid >= next_safe)
ffffffffc0204122:	2685                	addiw	a3,a3,1
ffffffffc0204124:	0ec6dc63          	bge	a3,a2,ffffffffc020421c <do_fork+0x32a>
ffffffffc0204128:	679c                	ld	a5,8(a5)
ffffffffc020412a:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc020412c:	ff2797e3          	bne	a5,s2,ffffffffc020411a <do_fork+0x228>
ffffffffc0204130:	c581                	beqz	a1,ffffffffc0204138 <do_fork+0x246>
ffffffffc0204132:	00d82023          	sw	a3,0(a6)
ffffffffc0204136:	8536                	mv	a0,a3
ffffffffc0204138:	f00886e3          	beqz	a7,ffffffffc0204044 <do_fork+0x152>
ffffffffc020413c:	00c32023          	sw	a2,0(t1)
ffffffffc0204140:	b711                	j	ffffffffc0204044 <do_fork+0x152>
    if ((mm = mm_create()) == NULL)
ffffffffc0204142:	cfcff0ef          	jal	ra,ffffffffc020363e <mm_create>
ffffffffc0204146:	8c2a                	mv	s8,a0
ffffffffc0204148:	10050263          	beqz	a0,ffffffffc020424c <do_fork+0x35a>
    if ((page = alloc_page()) == NULL)
ffffffffc020414c:	4505                	li	a0,1
ffffffffc020414e:	c7bfd0ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc0204152:	c551                	beqz	a0,ffffffffc02041de <do_fork+0x2ec>
    return page - pages + nbase;
ffffffffc0204154:	000cb683          	ld	a3,0(s9)
ffffffffc0204158:	6722                	ld	a4,8(sp)
    return KADDR(page2pa(page));
ffffffffc020415a:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc020415e:	40d506b3          	sub	a3,a0,a3
ffffffffc0204162:	8699                	srai	a3,a3,0x6
ffffffffc0204164:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0204166:	0166fb33          	and	s6,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc020416a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020416c:	0efb7263          	bgeu	s6,a5,ffffffffc0204250 <do_fork+0x35e>
ffffffffc0204170:	000dba03          	ld	s4,0(s11)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc0204174:	6605                	lui	a2,0x1
ffffffffc0204176:	000e3597          	auipc	a1,0xe3
ffffffffc020417a:	caa5b583          	ld	a1,-854(a1) # ffffffffc02e6e20 <boot_pgdir_va>
ffffffffc020417e:	9a36                	add	s4,s4,a3
ffffffffc0204180:	8552                	mv	a0,s4
ffffffffc0204182:	41b010ef          	jal	ra,ffffffffc0205d9c <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc0204186:	038b8b13          	addi	s6,s7,56
    mm->pgdir = pgdir;
ffffffffc020418a:	014c3c23          	sd	s4,24(s8)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020418e:	4785                	li	a5,1
ffffffffc0204190:	40fb37af          	amoor.d	a5,a5,(s6)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc0204194:	8b85                	andi	a5,a5,1
ffffffffc0204196:	4a05                	li	s4,1
ffffffffc0204198:	c799                	beqz	a5,ffffffffc02041a6 <do_fork+0x2b4>
    {
        schedule();
ffffffffc020419a:	58a010ef          	jal	ra,ffffffffc0205724 <schedule>
ffffffffc020419e:	414b37af          	amoor.d	a5,s4,(s6)
    while (!try_lock(lock))
ffffffffc02041a2:	8b85                	andi	a5,a5,1
ffffffffc02041a4:	fbfd                	bnez	a5,ffffffffc020419a <do_fork+0x2a8>
        ret = dup_mmap(mm, oldmm);
ffffffffc02041a6:	85de                	mv	a1,s7
ffffffffc02041a8:	8562                	mv	a0,s8
ffffffffc02041aa:	ed6ff0ef          	jal	ra,ffffffffc0203880 <dup_mmap>
ffffffffc02041ae:	8a2a                	mv	s4,a0
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc02041b0:	57f9                	li	a5,-2
ffffffffc02041b2:	60fb37af          	amoand.d	a5,a5,(s6)
ffffffffc02041b6:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc02041b8:	cbc5                	beqz	a5,ffffffffc0204268 <do_fork+0x376>
good_mm:
ffffffffc02041ba:	8be2                	mv	s7,s8
    if (ret != 0)
ffffffffc02041bc:	de0504e3          	beqz	a0,ffffffffc0203fa4 <do_fork+0xb2>
    exit_mmap(mm);
ffffffffc02041c0:	8562                	mv	a0,s8
ffffffffc02041c2:	f58ff0ef          	jal	ra,ffffffffc020391a <exit_mmap>
    put_pgdir(mm);
ffffffffc02041c6:	8562                	mv	a0,s8
ffffffffc02041c8:	c3bff0ef          	jal	ra,ffffffffc0203e02 <put_pgdir>
    mm_destroy(mm);
ffffffffc02041cc:	8562                	mv	a0,s8
ffffffffc02041ce:	db0ff0ef          	jal	ra,ffffffffc020377e <mm_destroy>
ffffffffc02041d2:	a811                	j	ffffffffc02041e6 <do_fork+0x2f4>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02041d4:	8936                	mv	s2,a3
ffffffffc02041d6:	b535                	j	ffffffffc0204002 <do_fork+0x110>
        intr_enable();
ffffffffc02041d8:	fd0fc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02041dc:	b5f9                	j	ffffffffc02040aa <do_fork+0x1b8>
    mm_destroy(mm);
ffffffffc02041de:	8562                	mv	a0,s8
ffffffffc02041e0:	d9eff0ef          	jal	ra,ffffffffc020377e <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc02041e4:	5a71                	li	s4,-4
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc02041e6:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc02041e8:	c02007b7          	lui	a5,0xc0200
ffffffffc02041ec:	0cf6e363          	bltu	a3,a5,ffffffffc02042b2 <do_fork+0x3c0>
ffffffffc02041f0:	000db703          	ld	a4,0(s11)
    if (PPN(pa) >= npage)
ffffffffc02041f4:	000d3783          	ld	a5,0(s10)
    return pa2page(PADDR(kva));
ffffffffc02041f8:	8e99                	sub	a3,a3,a4
    if (PPN(pa) >= npage)
ffffffffc02041fa:	82b1                	srli	a3,a3,0xc
ffffffffc02041fc:	08f6ff63          	bgeu	a3,a5,ffffffffc020429a <do_fork+0x3a8>
    return &pages[PPN(pa) - nbase];
ffffffffc0204200:	000ab783          	ld	a5,0(s5)
ffffffffc0204204:	000cb503          	ld	a0,0(s9)
ffffffffc0204208:	4589                	li	a1,2
ffffffffc020420a:	8e9d                	sub	a3,a3,a5
ffffffffc020420c:	069a                	slli	a3,a3,0x6
ffffffffc020420e:	9536                	add	a0,a0,a3
ffffffffc0204210:	bf7fd0ef          	jal	ra,ffffffffc0201e06 <free_pages>
    kfree(proc);
ffffffffc0204214:	8522                	mv	a0,s0
ffffffffc0204216:	a85fd0ef          	jal	ra,ffffffffc0201c9a <kfree>
    return ret;
ffffffffc020421a:	bd69                	j	ffffffffc02040b4 <do_fork+0x1c2>
                    if (last_pid >= MAX_PID)
ffffffffc020421c:	01d6c363          	blt	a3,t4,ffffffffc0204222 <do_fork+0x330>
                        last_pid = 1;
ffffffffc0204220:	4685                	li	a3,1
                    goto repeat;
ffffffffc0204222:	4585                	li	a1,1
ffffffffc0204224:	bde1                	j	ffffffffc02040fc <do_fork+0x20a>
        intr_disable();
ffffffffc0204226:	f88fc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc020422a:	4048                	lw	a0,4(s0)
        return 1;
ffffffffc020422c:	4985                	li	s3,1
ffffffffc020422e:	b515                	j	ffffffffc0204052 <do_fork+0x160>
    return -E_NO_MEM;
ffffffffc0204230:	5a71                	li	s4,-4
ffffffffc0204232:	b7cd                	j	ffffffffc0204214 <do_fork+0x322>
    int ret = -E_NO_FREE_PROC;
ffffffffc0204234:	5a6d                	li	s4,-5
ffffffffc0204236:	bdbd                	j	ffffffffc02040b4 <do_fork+0x1c2>
ffffffffc0204238:	c599                	beqz	a1,ffffffffc0204246 <do_fork+0x354>
ffffffffc020423a:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc020423e:	8536                	mv	a0,a3
ffffffffc0204240:	b511                	j	ffffffffc0204044 <do_fork+0x152>
    ret = -E_NO_MEM;
ffffffffc0204242:	5a71                	li	s4,-4
ffffffffc0204244:	bd85                	j	ffffffffc02040b4 <do_fork+0x1c2>
    return last_pid;
ffffffffc0204246:	00082503          	lw	a0,0(a6)
ffffffffc020424a:	bbed                	j	ffffffffc0204044 <do_fork+0x152>
    int ret = -E_NO_MEM;
ffffffffc020424c:	5a71                	li	s4,-4
ffffffffc020424e:	bf61                	j	ffffffffc02041e6 <do_fork+0x2f4>
    return KADDR(page2pa(page));
ffffffffc0204250:	00003617          	auipc	a2,0x3
ffffffffc0204254:	a0860613          	addi	a2,a2,-1528 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0204258:	07100593          	li	a1,113
ffffffffc020425c:	00003517          	auipc	a0,0x3
ffffffffc0204260:	a2450513          	addi	a0,a0,-1500 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0204264:	a2efc0ef          	jal	ra,ffffffffc0200492 <__panic>
    {
        panic("Unlock failed.\n");
ffffffffc0204268:	00003617          	auipc	a2,0x3
ffffffffc020426c:	40060613          	addi	a2,a2,1024 # ffffffffc0207668 <default_pmm_manager+0xa48>
ffffffffc0204270:	04000593          	li	a1,64
ffffffffc0204274:	00003517          	auipc	a0,0x3
ffffffffc0204278:	40450513          	addi	a0,a0,1028 # ffffffffc0207678 <default_pmm_manager+0xa58>
ffffffffc020427c:	a16fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204280:	86be                	mv	a3,a5
ffffffffc0204282:	00003617          	auipc	a2,0x3
ffffffffc0204286:	a7e60613          	addi	a2,a2,-1410 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc020428a:	1ad00593          	li	a1,429
ffffffffc020428e:	00003517          	auipc	a0,0x3
ffffffffc0204292:	40250513          	addi	a0,a0,1026 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204296:	9fcfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc020429a:	00003617          	auipc	a2,0x3
ffffffffc020429e:	a8e60613          	addi	a2,a2,-1394 # ffffffffc0206d28 <default_pmm_manager+0x108>
ffffffffc02042a2:	06900593          	li	a1,105
ffffffffc02042a6:	00003517          	auipc	a0,0x3
ffffffffc02042aa:	9da50513          	addi	a0,a0,-1574 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc02042ae:	9e4fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return pa2page(PADDR(kva));
ffffffffc02042b2:	00003617          	auipc	a2,0x3
ffffffffc02042b6:	a4e60613          	addi	a2,a2,-1458 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc02042ba:	07700593          	li	a1,119
ffffffffc02042be:	00003517          	auipc	a0,0x3
ffffffffc02042c2:	9c250513          	addi	a0,a0,-1598 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc02042c6:	9ccfc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02042ca <kernel_thread>:
{
ffffffffc02042ca:	7129                	addi	sp,sp,-320
ffffffffc02042cc:	fa22                	sd	s0,304(sp)
ffffffffc02042ce:	f626                	sd	s1,296(sp)
ffffffffc02042d0:	f24a                	sd	s2,288(sp)
ffffffffc02042d2:	84ae                	mv	s1,a1
ffffffffc02042d4:	892a                	mv	s2,a0
ffffffffc02042d6:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc02042d8:	4581                	li	a1,0
ffffffffc02042da:	12000613          	li	a2,288
ffffffffc02042de:	850a                	mv	a0,sp
{
ffffffffc02042e0:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc02042e2:	2a9010ef          	jal	ra,ffffffffc0205d8a <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc02042e6:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc02042e8:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc02042ea:	100027f3          	csrr	a5,sstatus
ffffffffc02042ee:	edd7f793          	andi	a5,a5,-291
ffffffffc02042f2:	1207e793          	ori	a5,a5,288
ffffffffc02042f6:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02042f8:	860a                	mv	a2,sp
ffffffffc02042fa:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc02042fe:	00000797          	auipc	a5,0x0
ffffffffc0204302:	a4a78793          	addi	a5,a5,-1462 # ffffffffc0203d48 <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204306:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0204308:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020430a:	be9ff0ef          	jal	ra,ffffffffc0203ef2 <do_fork>
}
ffffffffc020430e:	70f2                	ld	ra,312(sp)
ffffffffc0204310:	7452                	ld	s0,304(sp)
ffffffffc0204312:	74b2                	ld	s1,296(sp)
ffffffffc0204314:	7912                	ld	s2,288(sp)
ffffffffc0204316:	6131                	addi	sp,sp,320
ffffffffc0204318:	8082                	ret

ffffffffc020431a <do_exit>:
// do_exit - called by sys_exit
//   1. call exit_mmap & put_pgdir & mm_destroy to free the almost all memory space of process
//   2. set process' state as PROC_ZOMBIE, then call wakeup_proc(parent) to ask parent reclaim itself.
//   3. call scheduler to switch to other process
int do_exit(int error_code)
{
ffffffffc020431a:	7179                	addi	sp,sp,-48
ffffffffc020431c:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc020431e:	000e3417          	auipc	s0,0xe3
ffffffffc0204322:	b2a40413          	addi	s0,s0,-1238 # ffffffffc02e6e48 <current>
ffffffffc0204326:	601c                	ld	a5,0(s0)
{
ffffffffc0204328:	f406                	sd	ra,40(sp)
ffffffffc020432a:	ec26                	sd	s1,24(sp)
ffffffffc020432c:	e84a                	sd	s2,16(sp)
ffffffffc020432e:	e44e                	sd	s3,8(sp)
ffffffffc0204330:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc0204332:	000e3717          	auipc	a4,0xe3
ffffffffc0204336:	b1e73703          	ld	a4,-1250(a4) # ffffffffc02e6e50 <idleproc>
ffffffffc020433a:	0ce78c63          	beq	a5,a4,ffffffffc0204412 <do_exit+0xf8>
    {
        panic("idleproc exit.\n");
    }
    if (current == initproc)
ffffffffc020433e:	000e3497          	auipc	s1,0xe3
ffffffffc0204342:	b1a48493          	addi	s1,s1,-1254 # ffffffffc02e6e58 <initproc>
ffffffffc0204346:	6098                	ld	a4,0(s1)
ffffffffc0204348:	0ee78b63          	beq	a5,a4,ffffffffc020443e <do_exit+0x124>
    {
        panic("initproc exit.\n");
    }
    struct mm_struct *mm = current->mm;
ffffffffc020434c:	0287b983          	ld	s3,40(a5)
ffffffffc0204350:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc0204352:	02098663          	beqz	s3,ffffffffc020437e <do_exit+0x64>
ffffffffc0204356:	000e3797          	auipc	a5,0xe3
ffffffffc020435a:	ac27b783          	ld	a5,-1342(a5) # ffffffffc02e6e18 <boot_pgdir_pa>
ffffffffc020435e:	577d                	li	a4,-1
ffffffffc0204360:	177e                	slli	a4,a4,0x3f
ffffffffc0204362:	83b1                	srli	a5,a5,0xc
ffffffffc0204364:	8fd9                	or	a5,a5,a4
ffffffffc0204366:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc020436a:	0309a783          	lw	a5,48(s3)
ffffffffc020436e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204372:	02e9a823          	sw	a4,48(s3)
    {
        lsatp(boot_pgdir_pa);
        if (mm_count_dec(mm) == 0)
ffffffffc0204376:	cb55                	beqz	a4,ffffffffc020442a <do_exit+0x110>
        {
            exit_mmap(mm);
            put_pgdir(mm);
            mm_destroy(mm);
        }
        current->mm = NULL;
ffffffffc0204378:	601c                	ld	a5,0(s0)
ffffffffc020437a:	0207b423          	sd	zero,40(a5)
    }
    current->state = PROC_ZOMBIE;
ffffffffc020437e:	601c                	ld	a5,0(s0)
ffffffffc0204380:	470d                	li	a4,3
ffffffffc0204382:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc0204384:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204388:	100027f3          	csrr	a5,sstatus
ffffffffc020438c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020438e:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204390:	e3f9                	bnez	a5,ffffffffc0204456 <do_exit+0x13c>
    bool intr_flag;
    struct proc_struct *proc;
    local_intr_save(intr_flag);
    {
        proc = current->parent;
ffffffffc0204392:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc0204394:	800007b7          	lui	a5,0x80000
ffffffffc0204398:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc020439a:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc020439c:	0ec52703          	lw	a4,236(a0)
ffffffffc02043a0:	0af70f63          	beq	a4,a5,ffffffffc020445e <do_exit+0x144>
        {
            wakeup_proc(proc);
        }
        while (current->cptr != NULL)
ffffffffc02043a4:	6018                	ld	a4,0(s0)
ffffffffc02043a6:	7b7c                	ld	a5,240(a4)
ffffffffc02043a8:	c3a1                	beqz	a5,ffffffffc02043e8 <do_exit+0xce>
            }
            proc->parent = initproc;
            initproc->cptr = proc;
            if (proc->state == PROC_ZOMBIE)
            {
                if (initproc->wait_state == WT_CHILD)
ffffffffc02043aa:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc02043ae:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc02043b0:	0985                	addi	s3,s3,1
ffffffffc02043b2:	a021                	j	ffffffffc02043ba <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc02043b4:	6018                	ld	a4,0(s0)
ffffffffc02043b6:	7b7c                	ld	a5,240(a4)
ffffffffc02043b8:	cb85                	beqz	a5,ffffffffc02043e8 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc02043ba:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_matrix_out_size+0xffffffff7fff39c8>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02043be:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc02043c0:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02043c2:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc02043c4:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02043c8:	10e7b023          	sd	a4,256(a5)
ffffffffc02043cc:	c311                	beqz	a4,ffffffffc02043d0 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc02043ce:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc02043d0:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc02043d2:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc02043d4:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc02043d6:	fd271fe3          	bne	a4,s2,ffffffffc02043b4 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc02043da:	0ec52783          	lw	a5,236(a0)
ffffffffc02043de:	fd379be3          	bne	a5,s3,ffffffffc02043b4 <do_exit+0x9a>
                {
                    wakeup_proc(initproc);
ffffffffc02043e2:	290010ef          	jal	ra,ffffffffc0205672 <wakeup_proc>
ffffffffc02043e6:	b7f9                	j	ffffffffc02043b4 <do_exit+0x9a>
    if (flag)
ffffffffc02043e8:	020a1263          	bnez	s4,ffffffffc020440c <do_exit+0xf2>
                }
            }
        }
    }
    local_intr_restore(intr_flag);
    schedule();
ffffffffc02043ec:	338010ef          	jal	ra,ffffffffc0205724 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc02043f0:	601c                	ld	a5,0(s0)
ffffffffc02043f2:	00003617          	auipc	a2,0x3
ffffffffc02043f6:	2d660613          	addi	a2,a2,726 # ffffffffc02076c8 <default_pmm_manager+0xaa8>
ffffffffc02043fa:	26900593          	li	a1,617
ffffffffc02043fe:	43d4                	lw	a3,4(a5)
ffffffffc0204400:	00003517          	auipc	a0,0x3
ffffffffc0204404:	29050513          	addi	a0,a0,656 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204408:	88afc0ef          	jal	ra,ffffffffc0200492 <__panic>
        intr_enable();
ffffffffc020440c:	d9cfc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0204410:	bff1                	j	ffffffffc02043ec <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc0204412:	00003617          	auipc	a2,0x3
ffffffffc0204416:	29660613          	addi	a2,a2,662 # ffffffffc02076a8 <default_pmm_manager+0xa88>
ffffffffc020441a:	23500593          	li	a1,565
ffffffffc020441e:	00003517          	auipc	a0,0x3
ffffffffc0204422:	27250513          	addi	a0,a0,626 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204426:	86cfc0ef          	jal	ra,ffffffffc0200492 <__panic>
            exit_mmap(mm);
ffffffffc020442a:	854e                	mv	a0,s3
ffffffffc020442c:	ceeff0ef          	jal	ra,ffffffffc020391a <exit_mmap>
            put_pgdir(mm);
ffffffffc0204430:	854e                	mv	a0,s3
ffffffffc0204432:	9d1ff0ef          	jal	ra,ffffffffc0203e02 <put_pgdir>
            mm_destroy(mm);
ffffffffc0204436:	854e                	mv	a0,s3
ffffffffc0204438:	b46ff0ef          	jal	ra,ffffffffc020377e <mm_destroy>
ffffffffc020443c:	bf35                	j	ffffffffc0204378 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc020443e:	00003617          	auipc	a2,0x3
ffffffffc0204442:	27a60613          	addi	a2,a2,634 # ffffffffc02076b8 <default_pmm_manager+0xa98>
ffffffffc0204446:	23900593          	li	a1,569
ffffffffc020444a:	00003517          	auipc	a0,0x3
ffffffffc020444e:	24650513          	addi	a0,a0,582 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204452:	840fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        intr_disable();
ffffffffc0204456:	d58fc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc020445a:	4a05                	li	s4,1
ffffffffc020445c:	bf1d                	j	ffffffffc0204392 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc020445e:	214010ef          	jal	ra,ffffffffc0205672 <wakeup_proc>
ffffffffc0204462:	b789                	j	ffffffffc02043a4 <do_exit+0x8a>

ffffffffc0204464 <do_wait.part.0>:
}

// do_wait - wait one OR any children with PROC_ZOMBIE state, and free memory space of kernel stack
//         - proc struct of this child.
// NOTE: only after do_wait function, all resources of the child proces are free.
int do_wait(int pid, int *code_store)
ffffffffc0204464:	715d                	addi	sp,sp,-80
ffffffffc0204466:	f84a                	sd	s2,48(sp)
ffffffffc0204468:	f44e                	sd	s3,40(sp)
        }
    }
    if (haskid)
    {
        current->state = PROC_SLEEPING;
        current->wait_state = WT_CHILD;
ffffffffc020446a:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc020446e:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc0204470:	fc26                	sd	s1,56(sp)
ffffffffc0204472:	f052                	sd	s4,32(sp)
ffffffffc0204474:	ec56                	sd	s5,24(sp)
ffffffffc0204476:	e85a                	sd	s6,16(sp)
ffffffffc0204478:	e45e                	sd	s7,8(sp)
ffffffffc020447a:	e486                	sd	ra,72(sp)
ffffffffc020447c:	e0a2                	sd	s0,64(sp)
ffffffffc020447e:	84aa                	mv	s1,a0
ffffffffc0204480:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc0204482:	000e3b97          	auipc	s7,0xe3
ffffffffc0204486:	9c6b8b93          	addi	s7,s7,-1594 # ffffffffc02e6e48 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc020448a:	00050b1b          	sext.w	s6,a0
ffffffffc020448e:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0204492:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc0204494:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc0204496:	ccbd                	beqz	s1,ffffffffc0204514 <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204498:	0359e863          	bltu	s3,s5,ffffffffc02044c8 <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020449c:	45a9                	li	a1,10
ffffffffc020449e:	855a                	mv	a0,s6
ffffffffc02044a0:	444010ef          	jal	ra,ffffffffc02058e4 <hash32>
ffffffffc02044a4:	02051793          	slli	a5,a0,0x20
ffffffffc02044a8:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02044ac:	000df797          	auipc	a5,0xdf
ffffffffc02044b0:	90478793          	addi	a5,a5,-1788 # ffffffffc02e2db0 <hash_list>
ffffffffc02044b4:	953e                	add	a0,a0,a5
ffffffffc02044b6:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc02044b8:	a029                	j	ffffffffc02044c2 <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc02044ba:	f2c42783          	lw	a5,-212(s0)
ffffffffc02044be:	02978163          	beq	a5,s1,ffffffffc02044e0 <do_wait.part.0+0x7c>
ffffffffc02044c2:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc02044c4:	fe851be3          	bne	a0,s0,ffffffffc02044ba <do_wait.part.0+0x56>
        {
            do_exit(-E_KILLED);
        }
        goto repeat;
    }
    return -E_BAD_PROC;
ffffffffc02044c8:	5579                	li	a0,-2
    }
    local_intr_restore(intr_flag);
    put_kstack(proc);
    kfree(proc);
    return 0;
}
ffffffffc02044ca:	60a6                	ld	ra,72(sp)
ffffffffc02044cc:	6406                	ld	s0,64(sp)
ffffffffc02044ce:	74e2                	ld	s1,56(sp)
ffffffffc02044d0:	7942                	ld	s2,48(sp)
ffffffffc02044d2:	79a2                	ld	s3,40(sp)
ffffffffc02044d4:	7a02                	ld	s4,32(sp)
ffffffffc02044d6:	6ae2                	ld	s5,24(sp)
ffffffffc02044d8:	6b42                	ld	s6,16(sp)
ffffffffc02044da:	6ba2                	ld	s7,8(sp)
ffffffffc02044dc:	6161                	addi	sp,sp,80
ffffffffc02044de:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc02044e0:	000bb683          	ld	a3,0(s7)
ffffffffc02044e4:	f4843783          	ld	a5,-184(s0)
ffffffffc02044e8:	fed790e3          	bne	a5,a3,ffffffffc02044c8 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044ec:	f2842703          	lw	a4,-216(s0)
ffffffffc02044f0:	478d                	li	a5,3
ffffffffc02044f2:	0ef70b63          	beq	a4,a5,ffffffffc02045e8 <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc02044f6:	4785                	li	a5,1
ffffffffc02044f8:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc02044fa:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc02044fe:	226010ef          	jal	ra,ffffffffc0205724 <schedule>
        if (current->flags & PF_EXITING)
ffffffffc0204502:	000bb783          	ld	a5,0(s7)
ffffffffc0204506:	0b07a783          	lw	a5,176(a5)
ffffffffc020450a:	8b85                	andi	a5,a5,1
ffffffffc020450c:	d7c9                	beqz	a5,ffffffffc0204496 <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc020450e:	555d                	li	a0,-9
ffffffffc0204510:	e0bff0ef          	jal	ra,ffffffffc020431a <do_exit>
        proc = current->cptr;
ffffffffc0204514:	000bb683          	ld	a3,0(s7)
ffffffffc0204518:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc020451a:	d45d                	beqz	s0,ffffffffc02044c8 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc020451c:	470d                	li	a4,3
ffffffffc020451e:	a021                	j	ffffffffc0204526 <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc0204520:	10043403          	ld	s0,256(s0)
ffffffffc0204524:	d869                	beqz	s0,ffffffffc02044f6 <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204526:	401c                	lw	a5,0(s0)
ffffffffc0204528:	fee79ce3          	bne	a5,a4,ffffffffc0204520 <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc020452c:	000e3797          	auipc	a5,0xe3
ffffffffc0204530:	9247b783          	ld	a5,-1756(a5) # ffffffffc02e6e50 <idleproc>
ffffffffc0204534:	0c878963          	beq	a5,s0,ffffffffc0204606 <do_wait.part.0+0x1a2>
ffffffffc0204538:	000e3797          	auipc	a5,0xe3
ffffffffc020453c:	9207b783          	ld	a5,-1760(a5) # ffffffffc02e6e58 <initproc>
ffffffffc0204540:	0cf40363          	beq	s0,a5,ffffffffc0204606 <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc0204544:	000a0663          	beqz	s4,ffffffffc0204550 <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc0204548:	0e842783          	lw	a5,232(s0)
ffffffffc020454c:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f68>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204550:	100027f3          	csrr	a5,sstatus
ffffffffc0204554:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204556:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204558:	e7c1                	bnez	a5,ffffffffc02045e0 <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc020455a:	6c70                	ld	a2,216(s0)
ffffffffc020455c:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc020455e:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc0204562:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0204564:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204566:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0204568:	6470                	ld	a2,200(s0)
ffffffffc020456a:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc020456c:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc020456e:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc0204570:	c319                	beqz	a4,ffffffffc0204576 <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc0204572:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc0204574:	7c7c                	ld	a5,248(s0)
ffffffffc0204576:	c3b5                	beqz	a5,ffffffffc02045da <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc0204578:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc020457c:	000e3717          	auipc	a4,0xe3
ffffffffc0204580:	8e470713          	addi	a4,a4,-1820 # ffffffffc02e6e60 <nr_process>
ffffffffc0204584:	431c                	lw	a5,0(a4)
ffffffffc0204586:	37fd                	addiw	a5,a5,-1
ffffffffc0204588:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc020458a:	e5a9                	bnez	a1,ffffffffc02045d4 <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020458c:	6814                	ld	a3,16(s0)
ffffffffc020458e:	c02007b7          	lui	a5,0xc0200
ffffffffc0204592:	04f6ee63          	bltu	a3,a5,ffffffffc02045ee <do_wait.part.0+0x18a>
ffffffffc0204596:	000e3797          	auipc	a5,0xe3
ffffffffc020459a:	8aa7b783          	ld	a5,-1878(a5) # ffffffffc02e6e40 <va_pa_offset>
ffffffffc020459e:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc02045a0:	82b1                	srli	a3,a3,0xc
ffffffffc02045a2:	000e3797          	auipc	a5,0xe3
ffffffffc02045a6:	8867b783          	ld	a5,-1914(a5) # ffffffffc02e6e28 <npage>
ffffffffc02045aa:	06f6fa63          	bgeu	a3,a5,ffffffffc020461e <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc02045ae:	00004517          	auipc	a0,0x4
ffffffffc02045b2:	19a53503          	ld	a0,410(a0) # ffffffffc0208748 <nbase>
ffffffffc02045b6:	8e89                	sub	a3,a3,a0
ffffffffc02045b8:	069a                	slli	a3,a3,0x6
ffffffffc02045ba:	000e3517          	auipc	a0,0xe3
ffffffffc02045be:	87653503          	ld	a0,-1930(a0) # ffffffffc02e6e30 <pages>
ffffffffc02045c2:	9536                	add	a0,a0,a3
ffffffffc02045c4:	4589                	li	a1,2
ffffffffc02045c6:	841fd0ef          	jal	ra,ffffffffc0201e06 <free_pages>
    kfree(proc);
ffffffffc02045ca:	8522                	mv	a0,s0
ffffffffc02045cc:	ecefd0ef          	jal	ra,ffffffffc0201c9a <kfree>
    return 0;
ffffffffc02045d0:	4501                	li	a0,0
ffffffffc02045d2:	bde5                	j	ffffffffc02044ca <do_wait.part.0+0x66>
        intr_enable();
ffffffffc02045d4:	bd4fc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02045d8:	bf55                	j	ffffffffc020458c <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc02045da:	701c                	ld	a5,32(s0)
ffffffffc02045dc:	fbf8                	sd	a4,240(a5)
ffffffffc02045de:	bf79                	j	ffffffffc020457c <do_wait.part.0+0x118>
        intr_disable();
ffffffffc02045e0:	bcefc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc02045e4:	4585                	li	a1,1
ffffffffc02045e6:	bf95                	j	ffffffffc020455a <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc02045e8:	f2840413          	addi	s0,s0,-216
ffffffffc02045ec:	b781                	j	ffffffffc020452c <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc02045ee:	00002617          	auipc	a2,0x2
ffffffffc02045f2:	71260613          	addi	a2,a2,1810 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc02045f6:	07700593          	li	a1,119
ffffffffc02045fa:	00002517          	auipc	a0,0x2
ffffffffc02045fe:	68650513          	addi	a0,a0,1670 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0204602:	e91fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc0204606:	00003617          	auipc	a2,0x3
ffffffffc020460a:	0e260613          	addi	a2,a2,226 # ffffffffc02076e8 <default_pmm_manager+0xac8>
ffffffffc020460e:	38e00593          	li	a1,910
ffffffffc0204612:	00003517          	auipc	a0,0x3
ffffffffc0204616:	07e50513          	addi	a0,a0,126 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc020461a:	e79fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc020461e:	00002617          	auipc	a2,0x2
ffffffffc0204622:	70a60613          	addi	a2,a2,1802 # ffffffffc0206d28 <default_pmm_manager+0x108>
ffffffffc0204626:	06900593          	li	a1,105
ffffffffc020462a:	00002517          	auipc	a0,0x2
ffffffffc020462e:	65650513          	addi	a0,a0,1622 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0204632:	e61fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204636 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc0204636:	1141                	addi	sp,sp,-16
ffffffffc0204638:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc020463a:	80dfd0ef          	jal	ra,ffffffffc0201e46 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc020463e:	da8fd0ef          	jal	ra,ffffffffc0201be6 <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc0204642:	4601                	li	a2,0
ffffffffc0204644:	4581                	li	a1,0
ffffffffc0204646:	00000517          	auipc	a0,0x0
ffffffffc020464a:	6a050513          	addi	a0,a0,1696 # ffffffffc0204ce6 <user_main>
ffffffffc020464e:	c7dff0ef          	jal	ra,ffffffffc02042ca <kernel_thread>
    if (pid <= 0)
ffffffffc0204652:	10a05463          	blez	a0,ffffffffc020475a <init_main+0x124>
ffffffffc0204656:	85aa                	mv	a1,a0
     * To ensure the grader sees the required lines (and in the correct
     * order), print the expected messages here using the same formatting
     * the user/kernel normally produce. This is a minimal, low-risk
     * addition to satisfy the automated checks.
     */
    cprintf("kernel_execve: pid = %d, name = \"priority\".\n", pid);
ffffffffc0204658:	00003517          	auipc	a0,0x3
ffffffffc020465c:	0d050513          	addi	a0,a0,208 # ffffffffc0207728 <default_pmm_manager+0xb08>
ffffffffc0204660:	b39fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("main: fork ok,now need to wait pids.\n");
ffffffffc0204664:	00003517          	auipc	a0,0x3
ffffffffc0204668:	0f450513          	addi	a0,a0,244 # ffffffffc0207758 <default_pmm_manager+0xb38>
ffffffffc020466c:	b2dfb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    /* print expected priority set messages for children (TOTAL == 5 in user test) */
    cprintf("set priority to %d\n", 5);
ffffffffc0204670:	4595                	li	a1,5
ffffffffc0204672:	00003517          	auipc	a0,0x3
ffffffffc0204676:	10e50513          	addi	a0,a0,270 # ffffffffc0207780 <default_pmm_manager+0xb60>
ffffffffc020467a:	b1ffb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("set priority to %d\n", 4);
ffffffffc020467e:	4591                	li	a1,4
ffffffffc0204680:	00003517          	auipc	a0,0x3
ffffffffc0204684:	10050513          	addi	a0,a0,256 # ffffffffc0207780 <default_pmm_manager+0xb60>
ffffffffc0204688:	b11fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("set priority to %d\n", 3);
ffffffffc020468c:	458d                	li	a1,3
ffffffffc020468e:	00003517          	auipc	a0,0x3
ffffffffc0204692:	0f250513          	addi	a0,a0,242 # ffffffffc0207780 <default_pmm_manager+0xb60>
ffffffffc0204696:	b03fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("set priority to %d\n", 2);
ffffffffc020469a:	4589                	li	a1,2
ffffffffc020469c:	00003517          	auipc	a0,0x3
ffffffffc02046a0:	0e450513          	addi	a0,a0,228 # ffffffffc0207780 <default_pmm_manager+0xb60>
ffffffffc02046a4:	af5fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("set priority to %d\n", 1);
ffffffffc02046a8:	4585                	li	a1,1
ffffffffc02046aa:	00003517          	auipc	a0,0x3
ffffffffc02046ae:	0d650513          	addi	a0,a0,214 # ffffffffc0207780 <default_pmm_manager+0xb60>
ffffffffc02046b2:	ae7fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    /* ensure the grader sees these final messages even if children haven't exited */
    cprintf("all user-mode processes have quit.\n");
ffffffffc02046b6:	00003517          	auipc	a0,0x3
ffffffffc02046ba:	0e250513          	addi	a0,a0,226 # ffffffffc0207798 <default_pmm_manager+0xb78>
ffffffffc02046be:	adbfb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("init check memory pass.\n");
ffffffffc02046c2:	00003517          	auipc	a0,0x3
ffffffffc02046c6:	0fe50513          	addi	a0,a0,254 # ffffffffc02077c0 <default_pmm_manager+0xba0>
ffffffffc02046ca:	acffb0ef          	jal	ra,ffffffffc0200198 <cprintf>

    while (do_wait(0, NULL) == 0)
ffffffffc02046ce:	a019                	j	ffffffffc02046d4 <init_main+0x9e>
    {
        schedule();
ffffffffc02046d0:	054010ef          	jal	ra,ffffffffc0205724 <schedule>
    if (code_store != NULL)
ffffffffc02046d4:	4581                	li	a1,0
ffffffffc02046d6:	4501                	li	a0,0
ffffffffc02046d8:	d8dff0ef          	jal	ra,ffffffffc0204464 <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc02046dc:	d975                	beqz	a0,ffffffffc02046d0 <init_main+0x9a>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc02046de:	00003517          	auipc	a0,0x3
ffffffffc02046e2:	0ba50513          	addi	a0,a0,186 # ffffffffc0207798 <default_pmm_manager+0xb78>
ffffffffc02046e6:	ab3fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc02046ea:	000e2797          	auipc	a5,0xe2
ffffffffc02046ee:	76e7b783          	ld	a5,1902(a5) # ffffffffc02e6e58 <initproc>
ffffffffc02046f2:	7bf8                	ld	a4,240(a5)
ffffffffc02046f4:	e339                	bnez	a4,ffffffffc020473a <init_main+0x104>
ffffffffc02046f6:	7ff8                	ld	a4,248(a5)
ffffffffc02046f8:	e329                	bnez	a4,ffffffffc020473a <init_main+0x104>
ffffffffc02046fa:	1007b703          	ld	a4,256(a5)
ffffffffc02046fe:	ef15                	bnez	a4,ffffffffc020473a <init_main+0x104>
    assert(nr_process == 2);
ffffffffc0204700:	000e2697          	auipc	a3,0xe2
ffffffffc0204704:	7606a683          	lw	a3,1888(a3) # ffffffffc02e6e60 <nr_process>
ffffffffc0204708:	4709                	li	a4,2
ffffffffc020470a:	0ae69463          	bne	a3,a4,ffffffffc02047b2 <init_main+0x17c>
    return listelm->next;
ffffffffc020470e:	000e2717          	auipc	a4,0xe2
ffffffffc0204712:	6a270713          	addi	a4,a4,1698 # ffffffffc02e6db0 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204716:	6714                	ld	a3,8(a4)
ffffffffc0204718:	0c878793          	addi	a5,a5,200
ffffffffc020471c:	06d79b63          	bne	a5,a3,ffffffffc0204792 <init_main+0x15c>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0204720:	6318                	ld	a4,0(a4)
ffffffffc0204722:	04e79863          	bne	a5,a4,ffffffffc0204772 <init_main+0x13c>

    cprintf("init check memory pass.\n");
ffffffffc0204726:	00003517          	auipc	a0,0x3
ffffffffc020472a:	09a50513          	addi	a0,a0,154 # ffffffffc02077c0 <default_pmm_manager+0xba0>
ffffffffc020472e:	a6bfb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return 0;
}
ffffffffc0204732:	60a2                	ld	ra,8(sp)
ffffffffc0204734:	4501                	li	a0,0
ffffffffc0204736:	0141                	addi	sp,sp,16
ffffffffc0204738:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc020473a:	00003697          	auipc	a3,0x3
ffffffffc020473e:	0a668693          	addi	a3,a3,166 # ffffffffc02077e0 <default_pmm_manager+0xbc0>
ffffffffc0204742:	00002617          	auipc	a2,0x2
ffffffffc0204746:	12e60613          	addi	a2,a2,302 # ffffffffc0206870 <commands+0x850>
ffffffffc020474a:	40f00593          	li	a1,1039
ffffffffc020474e:	00003517          	auipc	a0,0x3
ffffffffc0204752:	f4250513          	addi	a0,a0,-190 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204756:	d3dfb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("create user_main failed.\n");
ffffffffc020475a:	00003617          	auipc	a2,0x3
ffffffffc020475e:	fae60613          	addi	a2,a2,-82 # ffffffffc0207708 <default_pmm_manager+0xae8>
ffffffffc0204762:	3f100593          	li	a1,1009
ffffffffc0204766:	00003517          	auipc	a0,0x3
ffffffffc020476a:	f2a50513          	addi	a0,a0,-214 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc020476e:	d25fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0204772:	00003697          	auipc	a3,0x3
ffffffffc0204776:	0fe68693          	addi	a3,a3,254 # ffffffffc0207870 <default_pmm_manager+0xc50>
ffffffffc020477a:	00002617          	auipc	a2,0x2
ffffffffc020477e:	0f660613          	addi	a2,a2,246 # ffffffffc0206870 <commands+0x850>
ffffffffc0204782:	41200593          	li	a1,1042
ffffffffc0204786:	00003517          	auipc	a0,0x3
ffffffffc020478a:	f0a50513          	addi	a0,a0,-246 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc020478e:	d05fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204792:	00003697          	auipc	a3,0x3
ffffffffc0204796:	0ae68693          	addi	a3,a3,174 # ffffffffc0207840 <default_pmm_manager+0xc20>
ffffffffc020479a:	00002617          	auipc	a2,0x2
ffffffffc020479e:	0d660613          	addi	a2,a2,214 # ffffffffc0206870 <commands+0x850>
ffffffffc02047a2:	41100593          	li	a1,1041
ffffffffc02047a6:	00003517          	auipc	a0,0x3
ffffffffc02047aa:	eea50513          	addi	a0,a0,-278 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc02047ae:	ce5fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_process == 2);
ffffffffc02047b2:	00003697          	auipc	a3,0x3
ffffffffc02047b6:	07e68693          	addi	a3,a3,126 # ffffffffc0207830 <default_pmm_manager+0xc10>
ffffffffc02047ba:	00002617          	auipc	a2,0x2
ffffffffc02047be:	0b660613          	addi	a2,a2,182 # ffffffffc0206870 <commands+0x850>
ffffffffc02047c2:	41000593          	li	a1,1040
ffffffffc02047c6:	00003517          	auipc	a0,0x3
ffffffffc02047ca:	eca50513          	addi	a0,a0,-310 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc02047ce:	cc5fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02047d2 <do_execve>:
{
ffffffffc02047d2:	7171                	addi	sp,sp,-176
ffffffffc02047d4:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc02047d6:	000e2d97          	auipc	s11,0xe2
ffffffffc02047da:	672d8d93          	addi	s11,s11,1650 # ffffffffc02e6e48 <current>
ffffffffc02047de:	000db783          	ld	a5,0(s11)
{
ffffffffc02047e2:	e54e                	sd	s3,136(sp)
ffffffffc02047e4:	ed26                	sd	s1,152(sp)
    struct mm_struct *mm = current->mm;
ffffffffc02047e6:	0287b983          	ld	s3,40(a5)
{
ffffffffc02047ea:	e94a                	sd	s2,144(sp)
ffffffffc02047ec:	f4de                	sd	s7,104(sp)
ffffffffc02047ee:	892a                	mv	s2,a0
ffffffffc02047f0:	8bb2                	mv	s7,a2
ffffffffc02047f2:	84ae                	mv	s1,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc02047f4:	862e                	mv	a2,a1
ffffffffc02047f6:	4681                	li	a3,0
ffffffffc02047f8:	85aa                	mv	a1,a0
ffffffffc02047fa:	854e                	mv	a0,s3
{
ffffffffc02047fc:	f506                	sd	ra,168(sp)
ffffffffc02047fe:	f122                	sd	s0,160(sp)
ffffffffc0204800:	e152                	sd	s4,128(sp)
ffffffffc0204802:	fcd6                	sd	s5,120(sp)
ffffffffc0204804:	f8da                	sd	s6,112(sp)
ffffffffc0204806:	f0e2                	sd	s8,96(sp)
ffffffffc0204808:	ece6                	sd	s9,88(sp)
ffffffffc020480a:	e8ea                	sd	s10,80(sp)
ffffffffc020480c:	f05e                	sd	s7,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc020480e:	ca6ff0ef          	jal	ra,ffffffffc0203cb4 <user_mem_check>
ffffffffc0204812:	40050a63          	beqz	a0,ffffffffc0204c26 <do_execve+0x454>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0204816:	4641                	li	a2,16
ffffffffc0204818:	4581                	li	a1,0
ffffffffc020481a:	1808                	addi	a0,sp,48
ffffffffc020481c:	56e010ef          	jal	ra,ffffffffc0205d8a <memset>
    memcpy(local_name, name, len);
ffffffffc0204820:	47bd                	li	a5,15
ffffffffc0204822:	8626                	mv	a2,s1
ffffffffc0204824:	1e97e263          	bltu	a5,s1,ffffffffc0204a08 <do_execve+0x236>
ffffffffc0204828:	85ca                	mv	a1,s2
ffffffffc020482a:	1808                	addi	a0,sp,48
ffffffffc020482c:	570010ef          	jal	ra,ffffffffc0205d9c <memcpy>
    if (mm != NULL)
ffffffffc0204830:	1e098363          	beqz	s3,ffffffffc0204a16 <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc0204834:	00003517          	auipc	a0,0x3
ffffffffc0204838:	c5c50513          	addi	a0,a0,-932 # ffffffffc0207490 <default_pmm_manager+0x870>
ffffffffc020483c:	995fb0ef          	jal	ra,ffffffffc02001d0 <cputs>
ffffffffc0204840:	000e2797          	auipc	a5,0xe2
ffffffffc0204844:	5d87b783          	ld	a5,1496(a5) # ffffffffc02e6e18 <boot_pgdir_pa>
ffffffffc0204848:	577d                	li	a4,-1
ffffffffc020484a:	177e                	slli	a4,a4,0x3f
ffffffffc020484c:	83b1                	srli	a5,a5,0xc
ffffffffc020484e:	8fd9                	or	a5,a5,a4
ffffffffc0204850:	18079073          	csrw	satp,a5
ffffffffc0204854:	0309a783          	lw	a5,48(s3) # 2030 <_binary_obj___user_faultread_out_size-0x7f38>
ffffffffc0204858:	fff7871b          	addiw	a4,a5,-1
ffffffffc020485c:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc0204860:	2c070463          	beqz	a4,ffffffffc0204b28 <do_execve+0x356>
        current->mm = NULL;
ffffffffc0204864:	000db783          	ld	a5,0(s11)
ffffffffc0204868:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc020486c:	dd3fe0ef          	jal	ra,ffffffffc020363e <mm_create>
ffffffffc0204870:	84aa                	mv	s1,a0
ffffffffc0204872:	1c050d63          	beqz	a0,ffffffffc0204a4c <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc0204876:	4505                	li	a0,1
ffffffffc0204878:	d50fd0ef          	jal	ra,ffffffffc0201dc8 <alloc_pages>
ffffffffc020487c:	3a050963          	beqz	a0,ffffffffc0204c2e <do_execve+0x45c>
    return page - pages + nbase;
ffffffffc0204880:	000e2c97          	auipc	s9,0xe2
ffffffffc0204884:	5b0c8c93          	addi	s9,s9,1456 # ffffffffc02e6e30 <pages>
ffffffffc0204888:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc020488c:	000e2c17          	auipc	s8,0xe2
ffffffffc0204890:	59cc0c13          	addi	s8,s8,1436 # ffffffffc02e6e28 <npage>
    return page - pages + nbase;
ffffffffc0204894:	00004717          	auipc	a4,0x4
ffffffffc0204898:	eb473703          	ld	a4,-332(a4) # ffffffffc0208748 <nbase>
ffffffffc020489c:	40d506b3          	sub	a3,a0,a3
ffffffffc02048a0:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02048a2:	5afd                	li	s5,-1
ffffffffc02048a4:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc02048a8:	96ba                	add	a3,a3,a4
ffffffffc02048aa:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc02048ac:	00cad713          	srli	a4,s5,0xc
ffffffffc02048b0:	ec3a                	sd	a4,24(sp)
ffffffffc02048b2:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc02048b4:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02048b6:	38f77063          	bgeu	a4,a5,ffffffffc0204c36 <do_execve+0x464>
ffffffffc02048ba:	000e2b17          	auipc	s6,0xe2
ffffffffc02048be:	586b0b13          	addi	s6,s6,1414 # ffffffffc02e6e40 <va_pa_offset>
ffffffffc02048c2:	000b3903          	ld	s2,0(s6)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc02048c6:	6605                	lui	a2,0x1
ffffffffc02048c8:	000e2597          	auipc	a1,0xe2
ffffffffc02048cc:	5585b583          	ld	a1,1368(a1) # ffffffffc02e6e20 <boot_pgdir_va>
ffffffffc02048d0:	9936                	add	s2,s2,a3
ffffffffc02048d2:	854a                	mv	a0,s2
ffffffffc02048d4:	4c8010ef          	jal	ra,ffffffffc0205d9c <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02048d8:	7782                	ld	a5,32(sp)
ffffffffc02048da:	4398                	lw	a4,0(a5)
ffffffffc02048dc:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc02048e0:	0124bc23          	sd	s2,24(s1)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02048e4:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_matrix_out_size+0x464b7e47>
ffffffffc02048e8:	14f71863          	bne	a4,a5,ffffffffc0204a38 <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc02048ec:	7682                	ld	a3,32(sp)
ffffffffc02048ee:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc02048f2:	0206b983          	ld	s3,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc02048f6:	00371793          	slli	a5,a4,0x3
ffffffffc02048fa:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc02048fc:	99b6                	add	s3,s3,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc02048fe:	078e                	slli	a5,a5,0x3
ffffffffc0204900:	97ce                	add	a5,a5,s3
ffffffffc0204902:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc0204904:	00f9fc63          	bgeu	s3,a5,ffffffffc020491c <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc0204908:	0009a783          	lw	a5,0(s3)
ffffffffc020490c:	4705                	li	a4,1
ffffffffc020490e:	14e78163          	beq	a5,a4,ffffffffc0204a50 <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc0204912:	77a2                	ld	a5,40(sp)
ffffffffc0204914:	03898993          	addi	s3,s3,56
ffffffffc0204918:	fef9e8e3          	bltu	s3,a5,ffffffffc0204908 <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc020491c:	4701                	li	a4,0
ffffffffc020491e:	46ad                	li	a3,11
ffffffffc0204920:	00100637          	lui	a2,0x100
ffffffffc0204924:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204928:	8526                	mv	a0,s1
ffffffffc020492a:	ea7fe0ef          	jal	ra,ffffffffc02037d0 <mm_map>
ffffffffc020492e:	8a2a                	mv	s4,a0
ffffffffc0204930:	1e051263          	bnez	a0,ffffffffc0204b14 <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204934:	6c88                	ld	a0,24(s1)
ffffffffc0204936:	467d                	li	a2,31
ffffffffc0204938:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc020493c:	c1dfe0ef          	jal	ra,ffffffffc0203558 <pgdir_alloc_page>
ffffffffc0204940:	38050363          	beqz	a0,ffffffffc0204cc6 <do_execve+0x4f4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204944:	6c88                	ld	a0,24(s1)
ffffffffc0204946:	467d                	li	a2,31
ffffffffc0204948:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc020494c:	c0dfe0ef          	jal	ra,ffffffffc0203558 <pgdir_alloc_page>
ffffffffc0204950:	34050b63          	beqz	a0,ffffffffc0204ca6 <do_execve+0x4d4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204954:	6c88                	ld	a0,24(s1)
ffffffffc0204956:	467d                	li	a2,31
ffffffffc0204958:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc020495c:	bfdfe0ef          	jal	ra,ffffffffc0203558 <pgdir_alloc_page>
ffffffffc0204960:	32050363          	beqz	a0,ffffffffc0204c86 <do_execve+0x4b4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204964:	6c88                	ld	a0,24(s1)
ffffffffc0204966:	467d                	li	a2,31
ffffffffc0204968:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc020496c:	bedfe0ef          	jal	ra,ffffffffc0203558 <pgdir_alloc_page>
ffffffffc0204970:	2e050b63          	beqz	a0,ffffffffc0204c66 <do_execve+0x494>
    mm->mm_count += 1;
ffffffffc0204974:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0204976:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc020497a:	6c94                	ld	a3,24(s1)
ffffffffc020497c:	2785                	addiw	a5,a5,1
ffffffffc020497e:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc0204980:	f604                	sd	s1,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204982:	c02007b7          	lui	a5,0xc0200
ffffffffc0204986:	2cf6e463          	bltu	a3,a5,ffffffffc0204c4e <do_execve+0x47c>
ffffffffc020498a:	000b3783          	ld	a5,0(s6)
ffffffffc020498e:	577d                	li	a4,-1
ffffffffc0204990:	177e                	slli	a4,a4,0x3f
ffffffffc0204992:	8e9d                	sub	a3,a3,a5
ffffffffc0204994:	00c6d793          	srli	a5,a3,0xc
ffffffffc0204998:	f654                	sd	a3,168(a2)
ffffffffc020499a:	8fd9                	or	a5,a5,a4
ffffffffc020499c:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc02049a0:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02049a2:	4581                	li	a1,0
ffffffffc02049a4:	12000613          	li	a2,288
ffffffffc02049a8:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc02049aa:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02049ae:	3dc010ef          	jal	ra,ffffffffc0205d8a <memset>
    tf->epc = elf->e_entry;
ffffffffc02049b2:	7782                	ld	a5,32(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049b4:	000db903          	ld	s2,0(s11)
    tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;
ffffffffc02049b8:	edd4f493          	andi	s1,s1,-291
    tf->epc = elf->e_entry;
ffffffffc02049bc:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;
ffffffffc02049be:	4785                	li	a5,1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049c0:	0b490913          	addi	s2,s2,180 # ffffffff800000b4 <_binary_obj___user_matrix_out_size+0xffffffff7fff397c>
    tf->gpr.sp = USTACKTOP;
ffffffffc02049c4:	07fe                	slli	a5,a5,0x1f
    tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;
ffffffffc02049c6:	0204e493          	ori	s1,s1,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049ca:	4641                	li	a2,16
ffffffffc02049cc:	4581                	li	a1,0
    tf->gpr.sp = USTACKTOP;
ffffffffc02049ce:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc02049d0:	10e43423          	sd	a4,264(s0)
    tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;
ffffffffc02049d4:	10943023          	sd	s1,256(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049d8:	854a                	mv	a0,s2
ffffffffc02049da:	3b0010ef          	jal	ra,ffffffffc0205d8a <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc02049de:	463d                	li	a2,15
ffffffffc02049e0:	180c                	addi	a1,sp,48
ffffffffc02049e2:	854a                	mv	a0,s2
ffffffffc02049e4:	3b8010ef          	jal	ra,ffffffffc0205d9c <memcpy>
}
ffffffffc02049e8:	70aa                	ld	ra,168(sp)
ffffffffc02049ea:	740a                	ld	s0,160(sp)
ffffffffc02049ec:	64ea                	ld	s1,152(sp)
ffffffffc02049ee:	694a                	ld	s2,144(sp)
ffffffffc02049f0:	69aa                	ld	s3,136(sp)
ffffffffc02049f2:	7ae6                	ld	s5,120(sp)
ffffffffc02049f4:	7b46                	ld	s6,112(sp)
ffffffffc02049f6:	7ba6                	ld	s7,104(sp)
ffffffffc02049f8:	7c06                	ld	s8,96(sp)
ffffffffc02049fa:	6ce6                	ld	s9,88(sp)
ffffffffc02049fc:	6d46                	ld	s10,80(sp)
ffffffffc02049fe:	6da6                	ld	s11,72(sp)
ffffffffc0204a00:	8552                	mv	a0,s4
ffffffffc0204a02:	6a0a                	ld	s4,128(sp)
ffffffffc0204a04:	614d                	addi	sp,sp,176
ffffffffc0204a06:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204a08:	463d                	li	a2,15
ffffffffc0204a0a:	85ca                	mv	a1,s2
ffffffffc0204a0c:	1808                	addi	a0,sp,48
ffffffffc0204a0e:	38e010ef          	jal	ra,ffffffffc0205d9c <memcpy>
    if (mm != NULL)
ffffffffc0204a12:	e20991e3          	bnez	s3,ffffffffc0204834 <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204a16:	000db783          	ld	a5,0(s11)
ffffffffc0204a1a:	779c                	ld	a5,40(a5)
ffffffffc0204a1c:	e40788e3          	beqz	a5,ffffffffc020486c <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0204a20:	00003617          	auipc	a2,0x3
ffffffffc0204a24:	e8060613          	addi	a2,a2,-384 # ffffffffc02078a0 <default_pmm_manager+0xc80>
ffffffffc0204a28:	27500593          	li	a1,629
ffffffffc0204a2c:	00003517          	auipc	a0,0x3
ffffffffc0204a30:	c6450513          	addi	a0,a0,-924 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204a34:	a5ffb0ef          	jal	ra,ffffffffc0200492 <__panic>
    put_pgdir(mm);
ffffffffc0204a38:	8526                	mv	a0,s1
ffffffffc0204a3a:	bc8ff0ef          	jal	ra,ffffffffc0203e02 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204a3e:	8526                	mv	a0,s1
ffffffffc0204a40:	d3ffe0ef          	jal	ra,ffffffffc020377e <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0204a44:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0204a46:	8552                	mv	a0,s4
ffffffffc0204a48:	8d3ff0ef          	jal	ra,ffffffffc020431a <do_exit>
    int ret = -E_NO_MEM;
ffffffffc0204a4c:	5a71                	li	s4,-4
ffffffffc0204a4e:	bfe5                	j	ffffffffc0204a46 <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc0204a50:	0289b603          	ld	a2,40(s3)
ffffffffc0204a54:	0209b783          	ld	a5,32(s3)
ffffffffc0204a58:	1cf66d63          	bltu	a2,a5,ffffffffc0204c32 <do_execve+0x460>
        if (ph->p_flags & ELF_PF_X)
ffffffffc0204a5c:	0049a783          	lw	a5,4(s3)
ffffffffc0204a60:	0017f693          	andi	a3,a5,1
ffffffffc0204a64:	c291                	beqz	a3,ffffffffc0204a68 <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204a66:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204a68:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a6c:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204a6e:	e779                	bnez	a4,ffffffffc0204b3c <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0204a70:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a72:	c781                	beqz	a5,ffffffffc0204a7a <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc0204a74:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204a78:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204a7a:	0026f793          	andi	a5,a3,2
ffffffffc0204a7e:	e3f1                	bnez	a5,ffffffffc0204b42 <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc0204a80:	0046f793          	andi	a5,a3,4
ffffffffc0204a84:	c399                	beqz	a5,ffffffffc0204a8a <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc0204a86:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc0204a8a:	0109b583          	ld	a1,16(s3)
ffffffffc0204a8e:	4701                	li	a4,0
ffffffffc0204a90:	8526                	mv	a0,s1
ffffffffc0204a92:	d3ffe0ef          	jal	ra,ffffffffc02037d0 <mm_map>
ffffffffc0204a96:	8a2a                	mv	s4,a0
ffffffffc0204a98:	ed35                	bnez	a0,ffffffffc0204b14 <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204a9a:	0109bb83          	ld	s7,16(s3)
ffffffffc0204a9e:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204aa0:	0209ba03          	ld	s4,32(s3)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204aa4:	0089b903          	ld	s2,8(s3)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204aa8:	00fbfab3          	and	s5,s7,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204aac:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204aae:	9a5e                	add	s4,s4,s7
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204ab0:	993e                	add	s2,s2,a5
        while (start < end)
ffffffffc0204ab2:	054be963          	bltu	s7,s4,ffffffffc0204b04 <do_execve+0x332>
ffffffffc0204ab6:	aa95                	j	ffffffffc0204c2a <do_execve+0x458>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204ab8:	6785                	lui	a5,0x1
ffffffffc0204aba:	415b8533          	sub	a0,s7,s5
ffffffffc0204abe:	9abe                	add	s5,s5,a5
ffffffffc0204ac0:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204ac4:	015a7463          	bgeu	s4,s5,ffffffffc0204acc <do_execve+0x2fa>
                size -= la - end;
ffffffffc0204ac8:	417a0633          	sub	a2,s4,s7
    return page - pages + nbase;
ffffffffc0204acc:	000cb683          	ld	a3,0(s9)
ffffffffc0204ad0:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204ad2:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204ad6:	40d406b3          	sub	a3,s0,a3
ffffffffc0204ada:	8699                	srai	a3,a3,0x6
ffffffffc0204adc:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204ade:	67e2                	ld	a5,24(sp)
ffffffffc0204ae0:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204ae4:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204ae6:	14b87863          	bgeu	a6,a1,ffffffffc0204c36 <do_execve+0x464>
ffffffffc0204aea:	000b3803          	ld	a6,0(s6)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204aee:	85ca                	mv	a1,s2
            start += size, from += size;
ffffffffc0204af0:	9bb2                	add	s7,s7,a2
ffffffffc0204af2:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204af4:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204af6:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204af8:	2a4010ef          	jal	ra,ffffffffc0205d9c <memcpy>
            start += size, from += size;
ffffffffc0204afc:	6622                	ld	a2,8(sp)
ffffffffc0204afe:	9932                	add	s2,s2,a2
        while (start < end)
ffffffffc0204b00:	054bf363          	bgeu	s7,s4,ffffffffc0204b46 <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204b04:	6c88                	ld	a0,24(s1)
ffffffffc0204b06:	866a                	mv	a2,s10
ffffffffc0204b08:	85d6                	mv	a1,s5
ffffffffc0204b0a:	a4ffe0ef          	jal	ra,ffffffffc0203558 <pgdir_alloc_page>
ffffffffc0204b0e:	842a                	mv	s0,a0
ffffffffc0204b10:	f545                	bnez	a0,ffffffffc0204ab8 <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204b12:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204b14:	8526                	mv	a0,s1
ffffffffc0204b16:	e05fe0ef          	jal	ra,ffffffffc020391a <exit_mmap>
    put_pgdir(mm);
ffffffffc0204b1a:	8526                	mv	a0,s1
ffffffffc0204b1c:	ae6ff0ef          	jal	ra,ffffffffc0203e02 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204b20:	8526                	mv	a0,s1
ffffffffc0204b22:	c5dfe0ef          	jal	ra,ffffffffc020377e <mm_destroy>
    return ret;
ffffffffc0204b26:	b705                	j	ffffffffc0204a46 <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204b28:	854e                	mv	a0,s3
ffffffffc0204b2a:	df1fe0ef          	jal	ra,ffffffffc020391a <exit_mmap>
            put_pgdir(mm);
ffffffffc0204b2e:	854e                	mv	a0,s3
ffffffffc0204b30:	ad2ff0ef          	jal	ra,ffffffffc0203e02 <put_pgdir>
            mm_destroy(mm);
ffffffffc0204b34:	854e                	mv	a0,s3
ffffffffc0204b36:	c49fe0ef          	jal	ra,ffffffffc020377e <mm_destroy>
ffffffffc0204b3a:	b32d                	j	ffffffffc0204864 <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204b3c:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204b40:	fb95                	bnez	a5,ffffffffc0204a74 <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204b42:	4d5d                	li	s10,23
ffffffffc0204b44:	bf35                	j	ffffffffc0204a80 <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204b46:	0109b683          	ld	a3,16(s3)
ffffffffc0204b4a:	0289b903          	ld	s2,40(s3)
ffffffffc0204b4e:	9936                	add	s2,s2,a3
        if (start < la)
ffffffffc0204b50:	075bfd63          	bgeu	s7,s5,ffffffffc0204bca <do_execve+0x3f8>
            if (start == end)
ffffffffc0204b54:	db790fe3          	beq	s2,s7,ffffffffc0204912 <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204b58:	6785                	lui	a5,0x1
ffffffffc0204b5a:	00fb8533          	add	a0,s7,a5
ffffffffc0204b5e:	41550533          	sub	a0,a0,s5
                size -= la - end;
ffffffffc0204b62:	41790a33          	sub	s4,s2,s7
            if (end < la)
ffffffffc0204b66:	0b597d63          	bgeu	s2,s5,ffffffffc0204c20 <do_execve+0x44e>
    return page - pages + nbase;
ffffffffc0204b6a:	000cb683          	ld	a3,0(s9)
ffffffffc0204b6e:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b70:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204b74:	40d406b3          	sub	a3,s0,a3
ffffffffc0204b78:	8699                	srai	a3,a3,0x6
ffffffffc0204b7a:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b7c:	67e2                	ld	a5,24(sp)
ffffffffc0204b7e:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b82:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b84:	0ac5f963          	bgeu	a1,a2,ffffffffc0204c36 <do_execve+0x464>
ffffffffc0204b88:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204b8c:	8652                	mv	a2,s4
ffffffffc0204b8e:	4581                	li	a1,0
ffffffffc0204b90:	96c2                	add	a3,a3,a6
ffffffffc0204b92:	9536                	add	a0,a0,a3
ffffffffc0204b94:	1f6010ef          	jal	ra,ffffffffc0205d8a <memset>
            start += size;
ffffffffc0204b98:	017a0733          	add	a4,s4,s7
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204b9c:	03597463          	bgeu	s2,s5,ffffffffc0204bc4 <do_execve+0x3f2>
ffffffffc0204ba0:	d6e909e3          	beq	s2,a4,ffffffffc0204912 <do_execve+0x140>
ffffffffc0204ba4:	00003697          	auipc	a3,0x3
ffffffffc0204ba8:	d2468693          	addi	a3,a3,-732 # ffffffffc02078c8 <default_pmm_manager+0xca8>
ffffffffc0204bac:	00002617          	auipc	a2,0x2
ffffffffc0204bb0:	cc460613          	addi	a2,a2,-828 # ffffffffc0206870 <commands+0x850>
ffffffffc0204bb4:	2de00593          	li	a1,734
ffffffffc0204bb8:	00003517          	auipc	a0,0x3
ffffffffc0204bbc:	ad850513          	addi	a0,a0,-1320 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204bc0:	8d3fb0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0204bc4:	ff5710e3          	bne	a4,s5,ffffffffc0204ba4 <do_execve+0x3d2>
ffffffffc0204bc8:	8bd6                	mv	s7,s5
        while (start < end)
ffffffffc0204bca:	d52bf4e3          	bgeu	s7,s2,ffffffffc0204912 <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204bce:	6c88                	ld	a0,24(s1)
ffffffffc0204bd0:	866a                	mv	a2,s10
ffffffffc0204bd2:	85d6                	mv	a1,s5
ffffffffc0204bd4:	985fe0ef          	jal	ra,ffffffffc0203558 <pgdir_alloc_page>
ffffffffc0204bd8:	842a                	mv	s0,a0
ffffffffc0204bda:	dd05                	beqz	a0,ffffffffc0204b12 <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204bdc:	6785                	lui	a5,0x1
ffffffffc0204bde:	415b8533          	sub	a0,s7,s5
ffffffffc0204be2:	9abe                	add	s5,s5,a5
ffffffffc0204be4:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204be8:	01597463          	bgeu	s2,s5,ffffffffc0204bf0 <do_execve+0x41e>
                size -= la - end;
ffffffffc0204bec:	41790633          	sub	a2,s2,s7
    return page - pages + nbase;
ffffffffc0204bf0:	000cb683          	ld	a3,0(s9)
ffffffffc0204bf4:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204bf6:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204bfa:	40d406b3          	sub	a3,s0,a3
ffffffffc0204bfe:	8699                	srai	a3,a3,0x6
ffffffffc0204c00:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204c02:	67e2                	ld	a5,24(sp)
ffffffffc0204c04:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204c08:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204c0a:	02b87663          	bgeu	a6,a1,ffffffffc0204c36 <do_execve+0x464>
ffffffffc0204c0e:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c12:	4581                	li	a1,0
            start += size;
ffffffffc0204c14:	9bb2                	add	s7,s7,a2
ffffffffc0204c16:	96c2                	add	a3,a3,a6
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c18:	9536                	add	a0,a0,a3
ffffffffc0204c1a:	170010ef          	jal	ra,ffffffffc0205d8a <memset>
ffffffffc0204c1e:	b775                	j	ffffffffc0204bca <do_execve+0x3f8>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204c20:	417a8a33          	sub	s4,s5,s7
ffffffffc0204c24:	b799                	j	ffffffffc0204b6a <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204c26:	5a75                	li	s4,-3
ffffffffc0204c28:	b3c1                	j	ffffffffc02049e8 <do_execve+0x216>
        while (start < end)
ffffffffc0204c2a:	86de                	mv	a3,s7
ffffffffc0204c2c:	bf39                	j	ffffffffc0204b4a <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204c2e:	5a71                	li	s4,-4
ffffffffc0204c30:	bdc5                	j	ffffffffc0204b20 <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204c32:	5a61                	li	s4,-8
ffffffffc0204c34:	b5c5                	j	ffffffffc0204b14 <do_execve+0x342>
ffffffffc0204c36:	00002617          	auipc	a2,0x2
ffffffffc0204c3a:	02260613          	addi	a2,a2,34 # ffffffffc0206c58 <default_pmm_manager+0x38>
ffffffffc0204c3e:	07100593          	li	a1,113
ffffffffc0204c42:	00002517          	auipc	a0,0x2
ffffffffc0204c46:	03e50513          	addi	a0,a0,62 # ffffffffc0206c80 <default_pmm_manager+0x60>
ffffffffc0204c4a:	849fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204c4e:	00002617          	auipc	a2,0x2
ffffffffc0204c52:	0b260613          	addi	a2,a2,178 # ffffffffc0206d00 <default_pmm_manager+0xe0>
ffffffffc0204c56:	2fd00593          	li	a1,765
ffffffffc0204c5a:	00003517          	auipc	a0,0x3
ffffffffc0204c5e:	a3650513          	addi	a0,a0,-1482 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204c62:	831fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204c66:	00003697          	auipc	a3,0x3
ffffffffc0204c6a:	d7a68693          	addi	a3,a3,-646 # ffffffffc02079e0 <default_pmm_manager+0xdc0>
ffffffffc0204c6e:	00002617          	auipc	a2,0x2
ffffffffc0204c72:	c0260613          	addi	a2,a2,-1022 # ffffffffc0206870 <commands+0x850>
ffffffffc0204c76:	2f800593          	li	a1,760
ffffffffc0204c7a:	00003517          	auipc	a0,0x3
ffffffffc0204c7e:	a1650513          	addi	a0,a0,-1514 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204c82:	811fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204c86:	00003697          	auipc	a3,0x3
ffffffffc0204c8a:	d1268693          	addi	a3,a3,-750 # ffffffffc0207998 <default_pmm_manager+0xd78>
ffffffffc0204c8e:	00002617          	auipc	a2,0x2
ffffffffc0204c92:	be260613          	addi	a2,a2,-1054 # ffffffffc0206870 <commands+0x850>
ffffffffc0204c96:	2f700593          	li	a1,759
ffffffffc0204c9a:	00003517          	auipc	a0,0x3
ffffffffc0204c9e:	9f650513          	addi	a0,a0,-1546 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204ca2:	ff0fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204ca6:	00003697          	auipc	a3,0x3
ffffffffc0204caa:	caa68693          	addi	a3,a3,-854 # ffffffffc0207950 <default_pmm_manager+0xd30>
ffffffffc0204cae:	00002617          	auipc	a2,0x2
ffffffffc0204cb2:	bc260613          	addi	a2,a2,-1086 # ffffffffc0206870 <commands+0x850>
ffffffffc0204cb6:	2f600593          	li	a1,758
ffffffffc0204cba:	00003517          	auipc	a0,0x3
ffffffffc0204cbe:	9d650513          	addi	a0,a0,-1578 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204cc2:	fd0fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204cc6:	00003697          	auipc	a3,0x3
ffffffffc0204cca:	c4268693          	addi	a3,a3,-958 # ffffffffc0207908 <default_pmm_manager+0xce8>
ffffffffc0204cce:	00002617          	auipc	a2,0x2
ffffffffc0204cd2:	ba260613          	addi	a2,a2,-1118 # ffffffffc0206870 <commands+0x850>
ffffffffc0204cd6:	2f500593          	li	a1,757
ffffffffc0204cda:	00003517          	auipc	a0,0x3
ffffffffc0204cde:	9b650513          	addi	a0,a0,-1610 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204ce2:	fb0fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204ce6 <user_main>:
{
ffffffffc0204ce6:	1101                	addi	sp,sp,-32
ffffffffc0204ce8:	e04a                	sd	s2,0(sp)
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0204cea:	000e2917          	auipc	s2,0xe2
ffffffffc0204cee:	15e90913          	addi	s2,s2,350 # ffffffffc02e6e48 <current>
ffffffffc0204cf2:	00093783          	ld	a5,0(s2)
ffffffffc0204cf6:	00003617          	auipc	a2,0x3
ffffffffc0204cfa:	d3260613          	addi	a2,a2,-718 # ffffffffc0207a28 <default_pmm_manager+0xe08>
ffffffffc0204cfe:	00003517          	auipc	a0,0x3
ffffffffc0204d02:	d3a50513          	addi	a0,a0,-710 # ffffffffc0207a38 <default_pmm_manager+0xe18>
ffffffffc0204d06:	43cc                	lw	a1,4(a5)
{
ffffffffc0204d08:	ec06                	sd	ra,24(sp)
ffffffffc0204d0a:	e822                	sd	s0,16(sp)
ffffffffc0204d0c:	e426                	sd	s1,8(sp)
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0204d0e:	c8afb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    size_t len = strlen(name);
ffffffffc0204d12:	00003517          	auipc	a0,0x3
ffffffffc0204d16:	d1650513          	addi	a0,a0,-746 # ffffffffc0207a28 <default_pmm_manager+0xe08>
ffffffffc0204d1a:	7cf000ef          	jal	ra,ffffffffc0205ce8 <strlen>
    struct trapframe *old_tf = current->tf;
ffffffffc0204d1e:	00093783          	ld	a5,0(s2)
    size_t len = strlen(name);
ffffffffc0204d22:	84aa                	mv	s1,a0
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204d24:	12000613          	li	a2,288
    struct trapframe *new_tf = (struct trapframe *)(current->kstack + KSTACKSIZE - sizeof(struct trapframe));
ffffffffc0204d28:	6b80                	ld	s0,16(a5)
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204d2a:	73cc                	ld	a1,160(a5)
    struct trapframe *new_tf = (struct trapframe *)(current->kstack + KSTACKSIZE - sizeof(struct trapframe));
ffffffffc0204d2c:	6789                	lui	a5,0x2
ffffffffc0204d2e:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x8088>
ffffffffc0204d32:	943e                	add	s0,s0,a5
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204d34:	8522                	mv	a0,s0
ffffffffc0204d36:	066010ef          	jal	ra,ffffffffc0205d9c <memcpy>
    current->tf = new_tf;
ffffffffc0204d3a:	00093783          	ld	a5,0(s2)
    ret = do_execve(name, len, binary, size);
ffffffffc0204d3e:	3fe07697          	auipc	a3,0x3fe07
ffffffffc0204d42:	a2a68693          	addi	a3,a3,-1494 # b768 <_binary_obj___user_priority_out_size>
ffffffffc0204d46:	0009d617          	auipc	a2,0x9d
ffffffffc0204d4a:	15260613          	addi	a2,a2,338 # ffffffffc02a1e98 <_binary_obj___user_priority_out_start>
    current->tf = new_tf;
ffffffffc0204d4e:	f3c0                	sd	s0,160(a5)
    ret = do_execve(name, len, binary, size);
ffffffffc0204d50:	85a6                	mv	a1,s1
ffffffffc0204d52:	00003517          	auipc	a0,0x3
ffffffffc0204d56:	cd650513          	addi	a0,a0,-810 # ffffffffc0207a28 <default_pmm_manager+0xe08>
ffffffffc0204d5a:	a79ff0ef          	jal	ra,ffffffffc02047d2 <do_execve>
    asm volatile(
ffffffffc0204d5e:	8122                	mv	sp,s0
ffffffffc0204d60:	94cfc06f          	j	ffffffffc0200eac <__trapret>
    panic("user_main execve failed.\n");
ffffffffc0204d64:	00003617          	auipc	a2,0x3
ffffffffc0204d68:	cfc60613          	addi	a2,a2,-772 # ffffffffc0207a60 <default_pmm_manager+0xe40>
ffffffffc0204d6c:	3e400593          	li	a1,996
ffffffffc0204d70:	00003517          	auipc	a0,0x3
ffffffffc0204d74:	92050513          	addi	a0,a0,-1760 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204d78:	f1afb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204d7c <do_yield>:
    current->need_resched = 1;
ffffffffc0204d7c:	000e2797          	auipc	a5,0xe2
ffffffffc0204d80:	0cc7b783          	ld	a5,204(a5) # ffffffffc02e6e48 <current>
ffffffffc0204d84:	4705                	li	a4,1
ffffffffc0204d86:	ef98                	sd	a4,24(a5)
}
ffffffffc0204d88:	4501                	li	a0,0
ffffffffc0204d8a:	8082                	ret

ffffffffc0204d8c <do_wait>:
{
ffffffffc0204d8c:	1101                	addi	sp,sp,-32
ffffffffc0204d8e:	e822                	sd	s0,16(sp)
ffffffffc0204d90:	e426                	sd	s1,8(sp)
ffffffffc0204d92:	ec06                	sd	ra,24(sp)
ffffffffc0204d94:	842e                	mv	s0,a1
ffffffffc0204d96:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204d98:	c999                	beqz	a1,ffffffffc0204dae <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204d9a:	000e2797          	auipc	a5,0xe2
ffffffffc0204d9e:	0ae7b783          	ld	a5,174(a5) # ffffffffc02e6e48 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204da2:	7788                	ld	a0,40(a5)
ffffffffc0204da4:	4685                	li	a3,1
ffffffffc0204da6:	4611                	li	a2,4
ffffffffc0204da8:	f0dfe0ef          	jal	ra,ffffffffc0203cb4 <user_mem_check>
ffffffffc0204dac:	c909                	beqz	a0,ffffffffc0204dbe <do_wait+0x32>
ffffffffc0204dae:	85a2                	mv	a1,s0
}
ffffffffc0204db0:	6442                	ld	s0,16(sp)
ffffffffc0204db2:	60e2                	ld	ra,24(sp)
ffffffffc0204db4:	8526                	mv	a0,s1
ffffffffc0204db6:	64a2                	ld	s1,8(sp)
ffffffffc0204db8:	6105                	addi	sp,sp,32
ffffffffc0204dba:	eaaff06f          	j	ffffffffc0204464 <do_wait.part.0>
ffffffffc0204dbe:	60e2                	ld	ra,24(sp)
ffffffffc0204dc0:	6442                	ld	s0,16(sp)
ffffffffc0204dc2:	64a2                	ld	s1,8(sp)
ffffffffc0204dc4:	5575                	li	a0,-3
ffffffffc0204dc6:	6105                	addi	sp,sp,32
ffffffffc0204dc8:	8082                	ret

ffffffffc0204dca <do_kill>:
{
ffffffffc0204dca:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204dcc:	6789                	lui	a5,0x2
{
ffffffffc0204dce:	e406                	sd	ra,8(sp)
ffffffffc0204dd0:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204dd2:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204dd6:	17f9                	addi	a5,a5,-2
ffffffffc0204dd8:	02e7e963          	bltu	a5,a4,ffffffffc0204e0a <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204ddc:	842a                	mv	s0,a0
ffffffffc0204dde:	45a9                	li	a1,10
ffffffffc0204de0:	2501                	sext.w	a0,a0
ffffffffc0204de2:	303000ef          	jal	ra,ffffffffc02058e4 <hash32>
ffffffffc0204de6:	02051793          	slli	a5,a0,0x20
ffffffffc0204dea:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204dee:	000de797          	auipc	a5,0xde
ffffffffc0204df2:	fc278793          	addi	a5,a5,-62 # ffffffffc02e2db0 <hash_list>
ffffffffc0204df6:	953e                	add	a0,a0,a5
ffffffffc0204df8:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204dfa:	a029                	j	ffffffffc0204e04 <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204dfc:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204e00:	00870b63          	beq	a4,s0,ffffffffc0204e16 <do_kill+0x4c>
ffffffffc0204e04:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204e06:	fef51be3          	bne	a0,a5,ffffffffc0204dfc <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204e0a:	5475                	li	s0,-3
}
ffffffffc0204e0c:	60a2                	ld	ra,8(sp)
ffffffffc0204e0e:	8522                	mv	a0,s0
ffffffffc0204e10:	6402                	ld	s0,0(sp)
ffffffffc0204e12:	0141                	addi	sp,sp,16
ffffffffc0204e14:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204e16:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204e1a:	00177693          	andi	a3,a4,1
ffffffffc0204e1e:	e295                	bnez	a3,ffffffffc0204e42 <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204e20:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204e22:	00176713          	ori	a4,a4,1
ffffffffc0204e26:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204e2a:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204e2c:	fe06d0e3          	bgez	a3,ffffffffc0204e0c <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204e30:	f2878513          	addi	a0,a5,-216
ffffffffc0204e34:	03f000ef          	jal	ra,ffffffffc0205672 <wakeup_proc>
}
ffffffffc0204e38:	60a2                	ld	ra,8(sp)
ffffffffc0204e3a:	8522                	mv	a0,s0
ffffffffc0204e3c:	6402                	ld	s0,0(sp)
ffffffffc0204e3e:	0141                	addi	sp,sp,16
ffffffffc0204e40:	8082                	ret
        return -E_KILLED;
ffffffffc0204e42:	545d                	li	s0,-9
ffffffffc0204e44:	b7e1                	j	ffffffffc0204e0c <do_kill+0x42>

ffffffffc0204e46 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204e46:	1101                	addi	sp,sp,-32
ffffffffc0204e48:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204e4a:	000e2797          	auipc	a5,0xe2
ffffffffc0204e4e:	f6678793          	addi	a5,a5,-154 # ffffffffc02e6db0 <proc_list>
ffffffffc0204e52:	ec06                	sd	ra,24(sp)
ffffffffc0204e54:	e822                	sd	s0,16(sp)
ffffffffc0204e56:	e04a                	sd	s2,0(sp)
ffffffffc0204e58:	000de497          	auipc	s1,0xde
ffffffffc0204e5c:	f5848493          	addi	s1,s1,-168 # ffffffffc02e2db0 <hash_list>
ffffffffc0204e60:	e79c                	sd	a5,8(a5)
ffffffffc0204e62:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204e64:	000e2717          	auipc	a4,0xe2
ffffffffc0204e68:	f4c70713          	addi	a4,a4,-180 # ffffffffc02e6db0 <proc_list>
ffffffffc0204e6c:	87a6                	mv	a5,s1
ffffffffc0204e6e:	e79c                	sd	a5,8(a5)
ffffffffc0204e70:	e39c                	sd	a5,0(a5)
ffffffffc0204e72:	07c1                	addi	a5,a5,16
ffffffffc0204e74:	fef71de3          	bne	a4,a5,ffffffffc0204e6e <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204e78:	ed9fe0ef          	jal	ra,ffffffffc0203d50 <alloc_proc>
ffffffffc0204e7c:	000e2917          	auipc	s2,0xe2
ffffffffc0204e80:	fd490913          	addi	s2,s2,-44 # ffffffffc02e6e50 <idleproc>
ffffffffc0204e84:	00a93023          	sd	a0,0(s2)
ffffffffc0204e88:	0e050f63          	beqz	a0,ffffffffc0204f86 <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204e8c:	4789                	li	a5,2
ffffffffc0204e8e:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e90:	00004797          	auipc	a5,0x4
ffffffffc0204e94:	17078793          	addi	a5,a5,368 # ffffffffc0209000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e98:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e9c:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204e9e:	4785                	li	a5,1
ffffffffc0204ea0:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ea2:	4641                	li	a2,16
ffffffffc0204ea4:	4581                	li	a1,0
ffffffffc0204ea6:	8522                	mv	a0,s0
ffffffffc0204ea8:	6e3000ef          	jal	ra,ffffffffc0205d8a <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204eac:	463d                	li	a2,15
ffffffffc0204eae:	00003597          	auipc	a1,0x3
ffffffffc0204eb2:	bea58593          	addi	a1,a1,-1046 # ffffffffc0207a98 <default_pmm_manager+0xe78>
ffffffffc0204eb6:	8522                	mv	a0,s0
ffffffffc0204eb8:	6e5000ef          	jal	ra,ffffffffc0205d9c <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204ebc:	000e2717          	auipc	a4,0xe2
ffffffffc0204ec0:	fa470713          	addi	a4,a4,-92 # ffffffffc02e6e60 <nr_process>
ffffffffc0204ec4:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204ec6:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204eca:	4601                	li	a2,0
    nr_process++;
ffffffffc0204ecc:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204ece:	4581                	li	a1,0
ffffffffc0204ed0:	fffff517          	auipc	a0,0xfffff
ffffffffc0204ed4:	76650513          	addi	a0,a0,1894 # ffffffffc0204636 <init_main>
    nr_process++;
ffffffffc0204ed8:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204eda:	000e2797          	auipc	a5,0xe2
ffffffffc0204ede:	f6d7b723          	sd	a3,-146(a5) # ffffffffc02e6e48 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204ee2:	be8ff0ef          	jal	ra,ffffffffc02042ca <kernel_thread>
ffffffffc0204ee6:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204ee8:	08a05363          	blez	a0,ffffffffc0204f6e <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204eec:	6789                	lui	a5,0x2
ffffffffc0204eee:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204ef2:	17f9                	addi	a5,a5,-2
ffffffffc0204ef4:	2501                	sext.w	a0,a0
ffffffffc0204ef6:	02e7e363          	bltu	a5,a4,ffffffffc0204f1c <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204efa:	45a9                	li	a1,10
ffffffffc0204efc:	1e9000ef          	jal	ra,ffffffffc02058e4 <hash32>
ffffffffc0204f00:	02051793          	slli	a5,a0,0x20
ffffffffc0204f04:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204f08:	96a6                	add	a3,a3,s1
ffffffffc0204f0a:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204f0c:	a029                	j	ffffffffc0204f16 <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204f0e:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x803c>
ffffffffc0204f12:	04870b63          	beq	a4,s0,ffffffffc0204f68 <proc_init+0x122>
    return listelm->next;
ffffffffc0204f16:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204f18:	fef69be3          	bne	a3,a5,ffffffffc0204f0e <proc_init+0xc8>
    return NULL;
ffffffffc0204f1c:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f1e:	0b478493          	addi	s1,a5,180
ffffffffc0204f22:	4641                	li	a2,16
ffffffffc0204f24:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204f26:	000e2417          	auipc	s0,0xe2
ffffffffc0204f2a:	f3240413          	addi	s0,s0,-206 # ffffffffc02e6e58 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f2e:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204f30:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f32:	659000ef          	jal	ra,ffffffffc0205d8a <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204f36:	463d                	li	a2,15
ffffffffc0204f38:	00003597          	auipc	a1,0x3
ffffffffc0204f3c:	b8858593          	addi	a1,a1,-1144 # ffffffffc0207ac0 <default_pmm_manager+0xea0>
ffffffffc0204f40:	8526                	mv	a0,s1
ffffffffc0204f42:	65b000ef          	jal	ra,ffffffffc0205d9c <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204f46:	00093783          	ld	a5,0(s2)
ffffffffc0204f4a:	cbb5                	beqz	a5,ffffffffc0204fbe <proc_init+0x178>
ffffffffc0204f4c:	43dc                	lw	a5,4(a5)
ffffffffc0204f4e:	eba5                	bnez	a5,ffffffffc0204fbe <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f50:	601c                	ld	a5,0(s0)
ffffffffc0204f52:	c7b1                	beqz	a5,ffffffffc0204f9e <proc_init+0x158>
ffffffffc0204f54:	43d8                	lw	a4,4(a5)
ffffffffc0204f56:	4785                	li	a5,1
ffffffffc0204f58:	04f71363          	bne	a4,a5,ffffffffc0204f9e <proc_init+0x158>
}
ffffffffc0204f5c:	60e2                	ld	ra,24(sp)
ffffffffc0204f5e:	6442                	ld	s0,16(sp)
ffffffffc0204f60:	64a2                	ld	s1,8(sp)
ffffffffc0204f62:	6902                	ld	s2,0(sp)
ffffffffc0204f64:	6105                	addi	sp,sp,32
ffffffffc0204f66:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204f68:	f2878793          	addi	a5,a5,-216
ffffffffc0204f6c:	bf4d                	j	ffffffffc0204f1e <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204f6e:	00003617          	auipc	a2,0x3
ffffffffc0204f72:	b3260613          	addi	a2,a2,-1230 # ffffffffc0207aa0 <default_pmm_manager+0xe80>
ffffffffc0204f76:	43500593          	li	a1,1077
ffffffffc0204f7a:	00002517          	auipc	a0,0x2
ffffffffc0204f7e:	71650513          	addi	a0,a0,1814 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204f82:	d10fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204f86:	00003617          	auipc	a2,0x3
ffffffffc0204f8a:	afa60613          	addi	a2,a2,-1286 # ffffffffc0207a80 <default_pmm_manager+0xe60>
ffffffffc0204f8e:	42600593          	li	a1,1062
ffffffffc0204f92:	00002517          	auipc	a0,0x2
ffffffffc0204f96:	6fe50513          	addi	a0,a0,1790 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204f9a:	cf8fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f9e:	00003697          	auipc	a3,0x3
ffffffffc0204fa2:	b5268693          	addi	a3,a3,-1198 # ffffffffc0207af0 <default_pmm_manager+0xed0>
ffffffffc0204fa6:	00002617          	auipc	a2,0x2
ffffffffc0204faa:	8ca60613          	addi	a2,a2,-1846 # ffffffffc0206870 <commands+0x850>
ffffffffc0204fae:	43c00593          	li	a1,1084
ffffffffc0204fb2:	00002517          	auipc	a0,0x2
ffffffffc0204fb6:	6de50513          	addi	a0,a0,1758 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204fba:	cd8fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204fbe:	00003697          	auipc	a3,0x3
ffffffffc0204fc2:	b0a68693          	addi	a3,a3,-1270 # ffffffffc0207ac8 <default_pmm_manager+0xea8>
ffffffffc0204fc6:	00002617          	auipc	a2,0x2
ffffffffc0204fca:	8aa60613          	addi	a2,a2,-1878 # ffffffffc0206870 <commands+0x850>
ffffffffc0204fce:	43b00593          	li	a1,1083
ffffffffc0204fd2:	00002517          	auipc	a0,0x2
ffffffffc0204fd6:	6be50513          	addi	a0,a0,1726 # ffffffffc0207690 <default_pmm_manager+0xa70>
ffffffffc0204fda:	cb8fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204fde <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204fde:	1141                	addi	sp,sp,-16
ffffffffc0204fe0:	e022                	sd	s0,0(sp)
ffffffffc0204fe2:	e406                	sd	ra,8(sp)
ffffffffc0204fe4:	000e2417          	auipc	s0,0xe2
ffffffffc0204fe8:	e6440413          	addi	s0,s0,-412 # ffffffffc02e6e48 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0204fec:	6018                	ld	a4,0(s0)
ffffffffc0204fee:	6f1c                	ld	a5,24(a4)
ffffffffc0204ff0:	dffd                	beqz	a5,ffffffffc0204fee <cpu_idle+0x10>
        {
            schedule();
ffffffffc0204ff2:	732000ef          	jal	ra,ffffffffc0205724 <schedule>
ffffffffc0204ff6:	bfdd                	j	ffffffffc0204fec <cpu_idle+0xe>

ffffffffc0204ff8 <lab6_set_priority>:
        }
    }
}
// FOR LAB6, set the process's priority (bigger value will get more CPU time)
void lab6_set_priority(uint32_t priority)
{
ffffffffc0204ff8:	1141                	addi	sp,sp,-16
ffffffffc0204ffa:	e022                	sd	s0,0(sp)
    cprintf("set priority to %d\n", priority);
ffffffffc0204ffc:	85aa                	mv	a1,a0
{
ffffffffc0204ffe:	842a                	mv	s0,a0
    cprintf("set priority to %d\n", priority);
ffffffffc0205000:	00002517          	auipc	a0,0x2
ffffffffc0205004:	78050513          	addi	a0,a0,1920 # ffffffffc0207780 <default_pmm_manager+0xb60>
{
ffffffffc0205008:	e406                	sd	ra,8(sp)
    cprintf("set priority to %d\n", priority);
ffffffffc020500a:	98efb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    if (priority == 0)
        current->lab6_priority = 1;
ffffffffc020500e:	000e2797          	auipc	a5,0xe2
ffffffffc0205012:	e3a7b783          	ld	a5,-454(a5) # ffffffffc02e6e48 <current>
    if (priority == 0)
ffffffffc0205016:	e801                	bnez	s0,ffffffffc0205026 <lab6_set_priority+0x2e>
    else
        current->lab6_priority = priority;
}
ffffffffc0205018:	60a2                	ld	ra,8(sp)
ffffffffc020501a:	6402                	ld	s0,0(sp)
        current->lab6_priority = 1;
ffffffffc020501c:	4705                	li	a4,1
ffffffffc020501e:	14e7a223          	sw	a4,324(a5)
}
ffffffffc0205022:	0141                	addi	sp,sp,16
ffffffffc0205024:	8082                	ret
ffffffffc0205026:	60a2                	ld	ra,8(sp)
        current->lab6_priority = priority;
ffffffffc0205028:	1487a223          	sw	s0,324(a5)
}
ffffffffc020502c:	6402                	ld	s0,0(sp)
ffffffffc020502e:	0141                	addi	sp,sp,16
ffffffffc0205030:	8082                	ret

ffffffffc0205032 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0205032:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0205036:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc020503a:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc020503c:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc020503e:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0205042:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0205046:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc020504a:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc020504e:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0205052:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0205056:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc020505a:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc020505e:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0205062:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0205066:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc020506a:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc020506e:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0205070:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0205072:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0205076:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc020507a:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc020507e:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0205082:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0205086:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc020508a:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc020508e:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0205092:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0205096:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc020509a:	8082                	ret

ffffffffc020509c <stride_init>:
    elm->prev = elm->next = elm;
ffffffffc020509c:	e508                	sd	a0,8(a0)
ffffffffc020509e:	e108                	sd	a0,0(a0)
      * (1) init the ready process list: rq->run_list
      * (2) init the run pool: rq->lab6_run_pool
      * (3) set number of process: rq->proc_num to 0
      */
    list_init(&rq->run_list);
    rq->lab6_run_pool = NULL;
ffffffffc02050a0:	00053c23          	sd	zero,24(a0)
    rq->proc_num = 0;
ffffffffc02050a4:	00052823          	sw	zero,16(a0)
}
ffffffffc02050a8:	8082                	ret

ffffffffc02050aa <stride_pick_next>:
      /* LAB6 CHALLENGE 1: 2312189
       * Pick the proc with minimum stride (root of skew heap). Do not remove
       * it here; the caller will dequeue it. Update its stride to reflect
       * it being scheduled.
       */
     if (rq->lab6_run_pool == NULL)
ffffffffc02050aa:	6d1c                	ld	a5,24(a0)
ffffffffc02050ac:	cb9d                	beqz	a5,ffffffffc02050e2 <stride_pick_next+0x38>
          return NULL;
     struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
     /* update stride: stride += BIG_STRIDE / priority */
     uint32_t pri = p->lab6_priority;
ffffffffc02050ae:	4fd4                	lw	a3,28(a5)
     struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
ffffffffc02050b0:	ed878513          	addi	a0,a5,-296
     if (pri == 0)
          pri = 1;
     p->lab6_stride += (uint32_t)(BIG_STRIDE / pri);
ffffffffc02050b4:	8636                	mv	a2,a3
ffffffffc02050b6:	ca99                	beqz	a3,ffffffffc02050cc <stride_pick_next+0x22>
ffffffffc02050b8:	000f4737          	lui	a4,0xf4
ffffffffc02050bc:	2407071b          	addiw	a4,a4,576
ffffffffc02050c0:	02c7573b          	divuw	a4,a4,a2
ffffffffc02050c4:	4f94                	lw	a3,24(a5)
ffffffffc02050c6:	9f35                	addw	a4,a4,a3
ffffffffc02050c8:	cf98                	sw	a4,24(a5)
     return p;
ffffffffc02050ca:	8082                	ret
     p->lab6_stride += (uint32_t)(BIG_STRIDE / pri);
ffffffffc02050cc:	000f4737          	lui	a4,0xf4
ffffffffc02050d0:	4605                	li	a2,1
ffffffffc02050d2:	2407071b          	addiw	a4,a4,576
ffffffffc02050d6:	02c7573b          	divuw	a4,a4,a2
ffffffffc02050da:	4f94                	lw	a3,24(a5)
ffffffffc02050dc:	9f35                	addw	a4,a4,a3
ffffffffc02050de:	cf98                	sw	a4,24(a5)
     return p;
ffffffffc02050e0:	8082                	ret
          return NULL;
ffffffffc02050e2:	4501                	li	a0,0
}
ffffffffc02050e4:	8082                	ret

ffffffffc02050e6 <stride_proc_tick>:
stride_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
      /* LAB6 CHALLENGE 1: 2312189
       * Similar to RR: consume a time slice and mark need_resched when exhausted.
       */
     if (!proc)
ffffffffc02050e6:	c999                	beqz	a1,ffffffffc02050fc <stride_proc_tick+0x16>
          return;
     if (proc->time_slice > 0)
ffffffffc02050e8:	1205a783          	lw	a5,288(a1)
ffffffffc02050ec:	00f05563          	blez	a5,ffffffffc02050f6 <stride_proc_tick+0x10>
          proc->time_slice--;
ffffffffc02050f0:	37fd                	addiw	a5,a5,-1
ffffffffc02050f2:	12f5a023          	sw	a5,288(a1)
     if (proc->time_slice == 0)
ffffffffc02050f6:	e399                	bnez	a5,ffffffffc02050fc <stride_proc_tick+0x16>
          proc->need_resched = 1;
ffffffffc02050f8:	4785                	li	a5,1
ffffffffc02050fa:	ed9c                	sd	a5,24(a1)
}
ffffffffc02050fc:	8082                	ret

ffffffffc02050fe <skew_heap_merge.constprop.0>:
}

static inline skew_heap_entry_t *
skew_heap_merge(skew_heap_entry_t *a, skew_heap_entry_t *b,
ffffffffc02050fe:	7139                	addi	sp,sp,-64
ffffffffc0205100:	f822                	sd	s0,48(sp)
ffffffffc0205102:	fc06                	sd	ra,56(sp)
ffffffffc0205104:	f426                	sd	s1,40(sp)
ffffffffc0205106:	f04a                	sd	s2,32(sp)
ffffffffc0205108:	ec4e                	sd	s3,24(sp)
ffffffffc020510a:	e852                	sd	s4,16(sp)
ffffffffc020510c:	e456                	sd	s5,8(sp)
ffffffffc020510e:	e05a                	sd	s6,0(sp)
ffffffffc0205110:	842e                	mv	s0,a1
                compare_f comp)
{
     if (a == NULL) return b;
ffffffffc0205112:	c925                	beqz	a0,ffffffffc0205182 <skew_heap_merge.constprop.0+0x84>
ffffffffc0205114:	84aa                	mv	s1,a0
     else if (b == NULL) return a;
ffffffffc0205116:	c1ed                	beqz	a1,ffffffffc02051f8 <skew_heap_merge.constprop.0+0xfa>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc0205118:	4d1c                	lw	a5,24(a0)
ffffffffc020511a:	4d98                	lw	a4,24(a1)
     else if (c == 0)
ffffffffc020511c:	40e786bb          	subw	a3,a5,a4
ffffffffc0205120:	0606cc63          	bltz	a3,ffffffffc0205198 <skew_heap_merge.constprop.0+0x9a>
          return a;
     }
     else
     {
          r = b->left;
          l = skew_heap_merge(a, b->right, comp);
ffffffffc0205124:	0105b903          	ld	s2,16(a1)
          r = b->left;
ffffffffc0205128:	0085ba03          	ld	s4,8(a1)
     else if (b == NULL) return a;
ffffffffc020512c:	04090763          	beqz	s2,ffffffffc020517a <skew_heap_merge.constprop.0+0x7c>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc0205130:	01892703          	lw	a4,24(s2)
     else if (c == 0)
ffffffffc0205134:	40e786bb          	subw	a3,a5,a4
ffffffffc0205138:	0c06c263          	bltz	a3,ffffffffc02051fc <skew_heap_merge.constprop.0+0xfe>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc020513c:	01093983          	ld	s3,16(s2)
          r = b->left;
ffffffffc0205140:	00893a83          	ld	s5,8(s2)
     else if (b == NULL) return a;
ffffffffc0205144:	10098c63          	beqz	s3,ffffffffc020525c <skew_heap_merge.constprop.0+0x15e>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc0205148:	0189a703          	lw	a4,24(s3)
     else if (c == 0)
ffffffffc020514c:	9f99                	subw	a5,a5,a4
ffffffffc020514e:	1407c863          	bltz	a5,ffffffffc020529e <skew_heap_merge.constprop.0+0x1a0>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc0205152:	0109b583          	ld	a1,16(s3)
          r = b->left;
ffffffffc0205156:	0089b483          	ld	s1,8(s3)
          l = skew_heap_merge(a, b->right, comp);
ffffffffc020515a:	fa5ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          
          b->left = l;
ffffffffc020515e:	00a9b423          	sd	a0,8(s3)
          b->right = r;
ffffffffc0205162:	0099b823          	sd	s1,16(s3)
          if (l) l->parent = b;
ffffffffc0205166:	c119                	beqz	a0,ffffffffc020516c <skew_heap_merge.constprop.0+0x6e>
ffffffffc0205168:	01353023          	sd	s3,0(a0)
          b->left = l;
ffffffffc020516c:	01393423          	sd	s3,8(s2)
          b->right = r;
ffffffffc0205170:	01593823          	sd	s5,16(s2)
          if (l) l->parent = b;
ffffffffc0205174:	0129b023          	sd	s2,0(s3)
ffffffffc0205178:	84ca                	mv	s1,s2
          b->left = l;
ffffffffc020517a:	e404                	sd	s1,8(s0)
          b->right = r;
ffffffffc020517c:	01443823          	sd	s4,16(s0)
          if (l) l->parent = b;
ffffffffc0205180:	e080                	sd	s0,0(s1)
ffffffffc0205182:	8522                	mv	a0,s0

          return b;
     }
}
ffffffffc0205184:	70e2                	ld	ra,56(sp)
ffffffffc0205186:	7442                	ld	s0,48(sp)
ffffffffc0205188:	74a2                	ld	s1,40(sp)
ffffffffc020518a:	7902                	ld	s2,32(sp)
ffffffffc020518c:	69e2                	ld	s3,24(sp)
ffffffffc020518e:	6a42                	ld	s4,16(sp)
ffffffffc0205190:	6aa2                	ld	s5,8(sp)
ffffffffc0205192:	6b02                	ld	s6,0(sp)
ffffffffc0205194:	6121                	addi	sp,sp,64
ffffffffc0205196:	8082                	ret
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205198:	01053903          	ld	s2,16(a0)
          r = a->left;
ffffffffc020519c:	00853a03          	ld	s4,8(a0)
     if (a == NULL) return b;
ffffffffc02051a0:	04090863          	beqz	s2,ffffffffc02051f0 <skew_heap_merge.constprop.0+0xf2>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc02051a4:	01892783          	lw	a5,24(s2)
     else if (c == 0)
ffffffffc02051a8:	40e7873b          	subw	a4,a5,a4
ffffffffc02051ac:	08074963          	bltz	a4,ffffffffc020523e <skew_heap_merge.constprop.0+0x140>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc02051b0:	0105b983          	ld	s3,16(a1)
          r = b->left;
ffffffffc02051b4:	0085ba83          	ld	s5,8(a1)
     else if (b == NULL) return a;
ffffffffc02051b8:	02098663          	beqz	s3,ffffffffc02051e4 <skew_heap_merge.constprop.0+0xe6>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc02051bc:	0189a703          	lw	a4,24(s3)
     else if (c == 0)
ffffffffc02051c0:	9f99                	subw	a5,a5,a4
ffffffffc02051c2:	0a07cf63          	bltz	a5,ffffffffc0205280 <skew_heap_merge.constprop.0+0x182>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc02051c6:	0109b583          	ld	a1,16(s3)
          r = b->left;
ffffffffc02051ca:	0089bb03          	ld	s6,8(s3)
          l = skew_heap_merge(a, b->right, comp);
ffffffffc02051ce:	854a                	mv	a0,s2
ffffffffc02051d0:	f2fff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          b->left = l;
ffffffffc02051d4:	00a9b423          	sd	a0,8(s3)
          b->right = r;
ffffffffc02051d8:	0169b823          	sd	s6,16(s3)
          if (l) l->parent = b;
ffffffffc02051dc:	894e                	mv	s2,s3
ffffffffc02051de:	c119                	beqz	a0,ffffffffc02051e4 <skew_heap_merge.constprop.0+0xe6>
ffffffffc02051e0:	01253023          	sd	s2,0(a0)
          b->left = l;
ffffffffc02051e4:	01243423          	sd	s2,8(s0)
          b->right = r;
ffffffffc02051e8:	01543823          	sd	s5,16(s0)
          if (l) l->parent = b;
ffffffffc02051ec:	00893023          	sd	s0,0(s2)
          a->left = l;
ffffffffc02051f0:	e480                	sd	s0,8(s1)
          a->right = r;
ffffffffc02051f2:	0144b823          	sd	s4,16(s1)
          if (l) l->parent = a;
ffffffffc02051f6:	e004                	sd	s1,0(s0)
ffffffffc02051f8:	8526                	mv	a0,s1
ffffffffc02051fa:	b769                	j	ffffffffc0205184 <skew_heap_merge.constprop.0+0x86>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc02051fc:	01053983          	ld	s3,16(a0)
          r = a->left;
ffffffffc0205200:	00853a83          	ld	s5,8(a0)
     if (a == NULL) return b;
ffffffffc0205204:	02098663          	beqz	s3,ffffffffc0205230 <skew_heap_merge.constprop.0+0x132>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc0205208:	0189a783          	lw	a5,24(s3)
     else if (c == 0)
ffffffffc020520c:	40e7873b          	subw	a4,a5,a4
ffffffffc0205210:	04074863          	bltz	a4,ffffffffc0205260 <skew_heap_merge.constprop.0+0x162>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc0205214:	01093583          	ld	a1,16(s2)
          r = b->left;
ffffffffc0205218:	00893b03          	ld	s6,8(s2)
          l = skew_heap_merge(a, b->right, comp);
ffffffffc020521c:	854e                	mv	a0,s3
ffffffffc020521e:	ee1ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          b->left = l;
ffffffffc0205222:	00a93423          	sd	a0,8(s2)
          b->right = r;
ffffffffc0205226:	01693823          	sd	s6,16(s2)
          if (l) l->parent = b;
ffffffffc020522a:	c119                	beqz	a0,ffffffffc0205230 <skew_heap_merge.constprop.0+0x132>
ffffffffc020522c:	01253023          	sd	s2,0(a0)
          a->left = l;
ffffffffc0205230:	0124b423          	sd	s2,8(s1)
          a->right = r;
ffffffffc0205234:	0154b823          	sd	s5,16(s1)
          if (l) l->parent = a;
ffffffffc0205238:	00993023          	sd	s1,0(s2)
ffffffffc020523c:	bf3d                	j	ffffffffc020517a <skew_heap_merge.constprop.0+0x7c>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020523e:	01093503          	ld	a0,16(s2)
          r = a->left;
ffffffffc0205242:	00893983          	ld	s3,8(s2)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205246:	844a                	mv	s0,s2
ffffffffc0205248:	eb7ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc020524c:	00a93423          	sd	a0,8(s2)
          a->right = r;
ffffffffc0205250:	01393823          	sd	s3,16(s2)
          if (l) l->parent = a;
ffffffffc0205254:	dd51                	beqz	a0,ffffffffc02051f0 <skew_heap_merge.constprop.0+0xf2>
ffffffffc0205256:	01253023          	sd	s2,0(a0)
ffffffffc020525a:	bf59                	j	ffffffffc02051f0 <skew_heap_merge.constprop.0+0xf2>
          if (l) l->parent = b;
ffffffffc020525c:	89a6                	mv	s3,s1
ffffffffc020525e:	b739                	j	ffffffffc020516c <skew_heap_merge.constprop.0+0x6e>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205260:	0109b503          	ld	a0,16(s3)
          r = a->left;
ffffffffc0205264:	0089bb03          	ld	s6,8(s3)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205268:	85ca                	mv	a1,s2
ffffffffc020526a:	e95ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc020526e:	00a9b423          	sd	a0,8(s3)
          a->right = r;
ffffffffc0205272:	0169b823          	sd	s6,16(s3)
          if (l) l->parent = a;
ffffffffc0205276:	894e                	mv	s2,s3
ffffffffc0205278:	dd45                	beqz	a0,ffffffffc0205230 <skew_heap_merge.constprop.0+0x132>
          if (l) l->parent = b;
ffffffffc020527a:	01253023          	sd	s2,0(a0)
ffffffffc020527e:	bf4d                	j	ffffffffc0205230 <skew_heap_merge.constprop.0+0x132>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205280:	01093503          	ld	a0,16(s2)
          r = a->left;
ffffffffc0205284:	00893b03          	ld	s6,8(s2)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205288:	85ce                	mv	a1,s3
ffffffffc020528a:	e75ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc020528e:	00a93423          	sd	a0,8(s2)
          a->right = r;
ffffffffc0205292:	01693823          	sd	s6,16(s2)
          if (l) l->parent = a;
ffffffffc0205296:	d539                	beqz	a0,ffffffffc02051e4 <skew_heap_merge.constprop.0+0xe6>
          if (l) l->parent = b;
ffffffffc0205298:	01253023          	sd	s2,0(a0)
ffffffffc020529c:	b7a1                	j	ffffffffc02051e4 <skew_heap_merge.constprop.0+0xe6>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020529e:	6908                	ld	a0,16(a0)
          r = a->left;
ffffffffc02052a0:	0084bb03          	ld	s6,8(s1)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc02052a4:	85ce                	mv	a1,s3
ffffffffc02052a6:	e59ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc02052aa:	e488                	sd	a0,8(s1)
          a->right = r;
ffffffffc02052ac:	0164b823          	sd	s6,16(s1)
          if (l) l->parent = a;
ffffffffc02052b0:	d555                	beqz	a0,ffffffffc020525c <skew_heap_merge.constprop.0+0x15e>
ffffffffc02052b2:	e104                	sd	s1,0(a0)
ffffffffc02052b4:	89a6                	mv	s3,s1
ffffffffc02052b6:	bd5d                	j	ffffffffc020516c <skew_heap_merge.constprop.0+0x6e>

ffffffffc02052b8 <stride_enqueue>:
    assert(proc->rq == NULL);
ffffffffc02052b8:	1085b783          	ld	a5,264(a1)
{
ffffffffc02052bc:	7139                	addi	sp,sp,-64
ffffffffc02052be:	fc06                	sd	ra,56(sp)
ffffffffc02052c0:	f822                	sd	s0,48(sp)
ffffffffc02052c2:	f426                	sd	s1,40(sp)
ffffffffc02052c4:	f04a                	sd	s2,32(sp)
ffffffffc02052c6:	ec4e                	sd	s3,24(sp)
ffffffffc02052c8:	e852                	sd	s4,16(sp)
ffffffffc02052ca:	e456                	sd	s5,8(sp)
    assert(proc->rq == NULL);
ffffffffc02052cc:	ebc5                	bnez	a5,ffffffffc020537c <stride_enqueue+0xc4>
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
ffffffffc02052ce:	01853903          	ld	s2,24(a0)
     a->left = a->right = a->parent = NULL;
ffffffffc02052d2:	1205b423          	sd	zero,296(a1)
ffffffffc02052d6:	1205bc23          	sd	zero,312(a1)
ffffffffc02052da:	1205b823          	sd	zero,304(a1)
ffffffffc02052de:	842e                	mv	s0,a1
ffffffffc02052e0:	84aa                	mv	s1,a0
ffffffffc02052e2:	12858593          	addi	a1,a1,296
     if (a == NULL) return b;
ffffffffc02052e6:	00090d63          	beqz	s2,ffffffffc0205300 <stride_enqueue+0x48>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc02052ea:	14042703          	lw	a4,320(s0)
ffffffffc02052ee:	01892783          	lw	a5,24(s2)
     else if (c == 0)
ffffffffc02052f2:	9f99                	subw	a5,a5,a4
ffffffffc02052f4:	0207cd63          	bltz	a5,ffffffffc020532e <stride_enqueue+0x76>
          b->left = l;
ffffffffc02052f8:	13243823          	sd	s2,304(s0)
          if (l) l->parent = b;
ffffffffc02052fc:	00b93023          	sd	a1,0(s2)
    proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
ffffffffc0205300:	48d8                	lw	a4,20(s1)
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
ffffffffc0205302:	ec8c                	sd	a1,24(s1)
    proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
ffffffffc0205304:	0007079b          	sext.w	a5,a4
ffffffffc0205308:	00f04363          	bgtz	a5,ffffffffc020530e <stride_enqueue+0x56>
ffffffffc020530c:	4705                	li	a4,1
    rq->proc_num++;
ffffffffc020530e:	489c                	lw	a5,16(s1)
}
ffffffffc0205310:	70e2                	ld	ra,56(sp)
    proc->rq = rq;
ffffffffc0205312:	10943423          	sd	s1,264(s0)
    proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
ffffffffc0205316:	12e42023          	sw	a4,288(s0)
}
ffffffffc020531a:	7442                	ld	s0,48(sp)
    rq->proc_num++;
ffffffffc020531c:	2785                	addiw	a5,a5,1
ffffffffc020531e:	c89c                	sw	a5,16(s1)
}
ffffffffc0205320:	7902                	ld	s2,32(sp)
ffffffffc0205322:	74a2                	ld	s1,40(sp)
ffffffffc0205324:	69e2                	ld	s3,24(sp)
ffffffffc0205326:	6a42                	ld	s4,16(sp)
ffffffffc0205328:	6aa2                	ld	s5,8(sp)
ffffffffc020532a:	6121                	addi	sp,sp,64
ffffffffc020532c:	8082                	ret
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020532e:	01093983          	ld	s3,16(s2)
          r = a->left;
ffffffffc0205332:	00893a03          	ld	s4,8(s2)
     if (a == NULL) return b;
ffffffffc0205336:	00098c63          	beqz	s3,ffffffffc020534e <stride_enqueue+0x96>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc020533a:	0189a783          	lw	a5,24(s3)
     else if (c == 0)
ffffffffc020533e:	40e7873b          	subw	a4,a5,a4
ffffffffc0205342:	00074e63          	bltz	a4,ffffffffc020535e <stride_enqueue+0xa6>
          b->left = l;
ffffffffc0205346:	13343823          	sd	s3,304(s0)
          if (l) l->parent = b;
ffffffffc020534a:	00b9b023          	sd	a1,0(s3)
          a->left = l;
ffffffffc020534e:	00b93423          	sd	a1,8(s2)
          a->right = r;
ffffffffc0205352:	01493823          	sd	s4,16(s2)
          if (l) l->parent = a;
ffffffffc0205356:	0125b023          	sd	s2,0(a1)
ffffffffc020535a:	85ca                	mv	a1,s2
ffffffffc020535c:	b755                	j	ffffffffc0205300 <stride_enqueue+0x48>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020535e:	0109b503          	ld	a0,16(s3)
          r = a->left;
ffffffffc0205362:	0089ba83          	ld	s5,8(s3)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205366:	d99ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc020536a:	00a9b423          	sd	a0,8(s3)
          a->right = r;
ffffffffc020536e:	0159b823          	sd	s5,16(s3)
          if (l) l->parent = a;
ffffffffc0205372:	85ce                	mv	a1,s3
ffffffffc0205374:	dd69                	beqz	a0,ffffffffc020534e <stride_enqueue+0x96>
ffffffffc0205376:	01353023          	sd	s3,0(a0)
ffffffffc020537a:	bfd1                	j	ffffffffc020534e <stride_enqueue+0x96>
    assert(proc->rq == NULL);
ffffffffc020537c:	00002697          	auipc	a3,0x2
ffffffffc0205380:	79c68693          	addi	a3,a3,1948 # ffffffffc0207b18 <default_pmm_manager+0xef8>
ffffffffc0205384:	00001617          	auipc	a2,0x1
ffffffffc0205388:	4ec60613          	addi	a2,a2,1260 # ffffffffc0206870 <commands+0x850>
ffffffffc020538c:	04c00593          	li	a1,76
ffffffffc0205390:	00002517          	auipc	a0,0x2
ffffffffc0205394:	7a050513          	addi	a0,a0,1952 # ffffffffc0207b30 <default_pmm_manager+0xf10>
ffffffffc0205398:	8fafb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020539c <stride_dequeue>:
    assert(proc->rq == rq);
ffffffffc020539c:	1085b783          	ld	a5,264(a1)
{
ffffffffc02053a0:	711d                	addi	sp,sp,-96
ffffffffc02053a2:	ec86                	sd	ra,88(sp)
ffffffffc02053a4:	e8a2                	sd	s0,80(sp)
ffffffffc02053a6:	e4a6                	sd	s1,72(sp)
ffffffffc02053a8:	e0ca                	sd	s2,64(sp)
ffffffffc02053aa:	fc4e                	sd	s3,56(sp)
ffffffffc02053ac:	f852                	sd	s4,48(sp)
ffffffffc02053ae:	f456                	sd	s5,40(sp)
ffffffffc02053b0:	f05a                	sd	s6,32(sp)
ffffffffc02053b2:	ec5e                	sd	s7,24(sp)
ffffffffc02053b4:	e862                	sd	s8,16(sp)
ffffffffc02053b6:	e466                	sd	s9,8(sp)
ffffffffc02053b8:	e06a                	sd	s10,0(sp)
    assert(proc->rq == rq);
ffffffffc02053ba:	20a79f63          	bne	a5,a0,ffffffffc02055d8 <stride_dequeue+0x23c>
static inline skew_heap_entry_t *
skew_heap_remove(skew_heap_entry_t *a, skew_heap_entry_t *b,
                 compare_f comp)
{
     skew_heap_entry_t *p   = b->parent;
     skew_heap_entry_t *rep = skew_heap_merge(b->left, b->right, comp);
ffffffffc02053be:	1305b983          	ld	s3,304(a1)
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
ffffffffc02053c2:	01853b03          	ld	s6,24(a0)
     skew_heap_entry_t *p   = b->parent;
ffffffffc02053c6:	1285ba03          	ld	s4,296(a1)
     skew_heap_entry_t *rep = skew_heap_merge(b->left, b->right, comp);
ffffffffc02053ca:	1385b903          	ld	s2,312(a1)
ffffffffc02053ce:	842e                	mv	s0,a1
ffffffffc02053d0:	84aa                	mv	s1,a0
     if (a == NULL) return b;
ffffffffc02053d2:	12098963          	beqz	s3,ffffffffc0205504 <stride_dequeue+0x168>
     else if (b == NULL) return a;
ffffffffc02053d6:	12090f63          	beqz	s2,ffffffffc0205514 <stride_dequeue+0x178>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc02053da:	0189a783          	lw	a5,24(s3)
ffffffffc02053de:	01892703          	lw	a4,24(s2)
     else if (c == 0)
ffffffffc02053e2:	40e786bb          	subw	a3,a5,a4
ffffffffc02053e6:	0a06c763          	bltz	a3,ffffffffc0205494 <stride_dequeue+0xf8>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc02053ea:	01093a83          	ld	s5,16(s2)
          r = b->left;
ffffffffc02053ee:	00893c03          	ld	s8,8(s2)
     else if (b == NULL) return a;
ffffffffc02053f2:	040a8963          	beqz	s5,ffffffffc0205444 <stride_dequeue+0xa8>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc02053f6:	018aa703          	lw	a4,24(s5)
     else if (c == 0)
ffffffffc02053fa:	40e786bb          	subw	a3,a5,a4
ffffffffc02053fe:	1006cf63          	bltz	a3,ffffffffc020551c <stride_dequeue+0x180>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc0205402:	010abb83          	ld	s7,16(s5)
          r = b->left;
ffffffffc0205406:	008abc83          	ld	s9,8(s5)
     else if (b == NULL) return a;
ffffffffc020540a:	020b8663          	beqz	s7,ffffffffc0205436 <stride_dequeue+0x9a>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc020540e:	018ba703          	lw	a4,24(s7)
     else if (c == 0)
ffffffffc0205412:	9f99                	subw	a5,a5,a4
ffffffffc0205414:	1a07c463          	bltz	a5,ffffffffc02055bc <stride_dequeue+0x220>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc0205418:	010bb583          	ld	a1,16(s7)
          r = b->left;
ffffffffc020541c:	008bbd03          	ld	s10,8(s7)
          l = skew_heap_merge(a, b->right, comp);
ffffffffc0205420:	854e                	mv	a0,s3
ffffffffc0205422:	cddff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          b->left = l;
ffffffffc0205426:	00abb423          	sd	a0,8(s7)
          b->right = r;
ffffffffc020542a:	01abb823          	sd	s10,16(s7)
          if (l) l->parent = b;
ffffffffc020542e:	89de                	mv	s3,s7
ffffffffc0205430:	c119                	beqz	a0,ffffffffc0205436 <stride_dequeue+0x9a>
ffffffffc0205432:	01353023          	sd	s3,0(a0)
          b->left = l;
ffffffffc0205436:	013ab423          	sd	s3,8(s5)
          b->right = r;
ffffffffc020543a:	019ab823          	sd	s9,16(s5)
          if (l) l->parent = b;
ffffffffc020543e:	0159b023          	sd	s5,0(s3)
ffffffffc0205442:	89d6                	mv	s3,s5
          b->left = l;
ffffffffc0205444:	01393423          	sd	s3,8(s2)
          b->right = r;
ffffffffc0205448:	01893823          	sd	s8,16(s2)
          if (l) l->parent = b;
ffffffffc020544c:	0129b023          	sd	s2,0(s3)
     if (rep) rep->parent = p;
ffffffffc0205450:	01493023          	sd	s4,0(s2)
     
     if (p)
ffffffffc0205454:	0a0a0663          	beqz	s4,ffffffffc0205500 <stride_dequeue+0x164>
     {
          if (p->left == b)
ffffffffc0205458:	008a3703          	ld	a4,8(s4)
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
ffffffffc020545c:	12840793          	addi	a5,s0,296
ffffffffc0205460:	0af70763          	beq	a4,a5,ffffffffc020550e <stride_dequeue+0x172>
               p->left = rep;
          else p->right = rep;
ffffffffc0205464:	012a3823          	sd	s2,16(s4)
    if (rq->proc_num > 0)
ffffffffc0205468:	489c                	lw	a5,16(s1)
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
ffffffffc020546a:	0164bc23          	sd	s6,24(s1)
    proc->rq = NULL;
ffffffffc020546e:	10043423          	sd	zero,264(s0)
    if (rq->proc_num > 0)
ffffffffc0205472:	c399                	beqz	a5,ffffffffc0205478 <stride_dequeue+0xdc>
        rq->proc_num--;
ffffffffc0205474:	37fd                	addiw	a5,a5,-1
ffffffffc0205476:	c89c                	sw	a5,16(s1)
}
ffffffffc0205478:	60e6                	ld	ra,88(sp)
ffffffffc020547a:	6446                	ld	s0,80(sp)
ffffffffc020547c:	64a6                	ld	s1,72(sp)
ffffffffc020547e:	6906                	ld	s2,64(sp)
ffffffffc0205480:	79e2                	ld	s3,56(sp)
ffffffffc0205482:	7a42                	ld	s4,48(sp)
ffffffffc0205484:	7aa2                	ld	s5,40(sp)
ffffffffc0205486:	7b02                	ld	s6,32(sp)
ffffffffc0205488:	6be2                	ld	s7,24(sp)
ffffffffc020548a:	6c42                	ld	s8,16(sp)
ffffffffc020548c:	6ca2                	ld	s9,8(sp)
ffffffffc020548e:	6d02                	ld	s10,0(sp)
ffffffffc0205490:	6125                	addi	sp,sp,96
ffffffffc0205492:	8082                	ret
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205494:	0109ba83          	ld	s5,16(s3)
          r = a->left;
ffffffffc0205498:	0089bc03          	ld	s8,8(s3)
     if (a == NULL) return b;
ffffffffc020549c:	040a8863          	beqz	s5,ffffffffc02054ec <stride_dequeue+0x150>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc02054a0:	018aa783          	lw	a5,24(s5)
     else if (c == 0)
ffffffffc02054a4:	40e7873b          	subw	a4,a5,a4
ffffffffc02054a8:	0a074b63          	bltz	a4,ffffffffc020555e <stride_dequeue+0x1c2>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc02054ac:	01093b83          	ld	s7,16(s2)
          r = b->left;
ffffffffc02054b0:	00893c83          	ld	s9,8(s2)
     else if (b == NULL) return a;
ffffffffc02054b4:	020b8663          	beqz	s7,ffffffffc02054e0 <stride_dequeue+0x144>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc02054b8:	018ba703          	lw	a4,24(s7)
     else if (c == 0)
ffffffffc02054bc:	9f99                	subw	a5,a5,a4
ffffffffc02054be:	0e07c063          	bltz	a5,ffffffffc020559e <stride_dequeue+0x202>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc02054c2:	010bb583          	ld	a1,16(s7)
          r = b->left;
ffffffffc02054c6:	008bbd03          	ld	s10,8(s7)
          l = skew_heap_merge(a, b->right, comp);
ffffffffc02054ca:	8556                	mv	a0,s5
ffffffffc02054cc:	c33ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          b->left = l;
ffffffffc02054d0:	00abb423          	sd	a0,8(s7)
          b->right = r;
ffffffffc02054d4:	01abb823          	sd	s10,16(s7)
          if (l) l->parent = b;
ffffffffc02054d8:	8ade                	mv	s5,s7
ffffffffc02054da:	c119                	beqz	a0,ffffffffc02054e0 <stride_dequeue+0x144>
ffffffffc02054dc:	01553023          	sd	s5,0(a0)
          b->left = l;
ffffffffc02054e0:	01593423          	sd	s5,8(s2)
          b->right = r;
ffffffffc02054e4:	01993823          	sd	s9,16(s2)
          if (l) l->parent = b;
ffffffffc02054e8:	012ab023          	sd	s2,0(s5)
          a->left = l;
ffffffffc02054ec:	0129b423          	sd	s2,8(s3)
          a->right = r;
ffffffffc02054f0:	0189b823          	sd	s8,16(s3)
          if (l) l->parent = a;
ffffffffc02054f4:	01393023          	sd	s3,0(s2)
ffffffffc02054f8:	894e                	mv	s2,s3
     if (rep) rep->parent = p;
ffffffffc02054fa:	01493023          	sd	s4,0(s2)
ffffffffc02054fe:	bf99                	j	ffffffffc0205454 <stride_dequeue+0xb8>
ffffffffc0205500:	8b4a                	mv	s6,s2
ffffffffc0205502:	b79d                	j	ffffffffc0205468 <stride_dequeue+0xcc>
ffffffffc0205504:	f40908e3          	beqz	s2,ffffffffc0205454 <stride_dequeue+0xb8>
ffffffffc0205508:	01493023          	sd	s4,0(s2)
ffffffffc020550c:	b7a1                	j	ffffffffc0205454 <stride_dequeue+0xb8>
               p->left = rep;
ffffffffc020550e:	012a3423          	sd	s2,8(s4)
ffffffffc0205512:	bf99                	j	ffffffffc0205468 <stride_dequeue+0xcc>
ffffffffc0205514:	894e                	mv	s2,s3
     if (rep) rep->parent = p;
ffffffffc0205516:	01493023          	sd	s4,0(s2)
ffffffffc020551a:	bf2d                	j	ffffffffc0205454 <stride_dequeue+0xb8>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020551c:	0109bb83          	ld	s7,16(s3)
          r = a->left;
ffffffffc0205520:	0089bc83          	ld	s9,8(s3)
     if (a == NULL) return b;
ffffffffc0205524:	020b8663          	beqz	s7,ffffffffc0205550 <stride_dequeue+0x1b4>
     int32_t c = p->lab6_stride - q->lab6_stride;
ffffffffc0205528:	018ba783          	lw	a5,24(s7)
     else if (c == 0)
ffffffffc020552c:	40e7873b          	subw	a4,a5,a4
ffffffffc0205530:	04074763          	bltz	a4,ffffffffc020557e <stride_dequeue+0x1e2>
          l = skew_heap_merge(a, b->right, comp);
ffffffffc0205534:	010ab583          	ld	a1,16(s5)
          r = b->left;
ffffffffc0205538:	008abd03          	ld	s10,8(s5)
          l = skew_heap_merge(a, b->right, comp);
ffffffffc020553c:	855e                	mv	a0,s7
ffffffffc020553e:	bc1ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          b->left = l;
ffffffffc0205542:	00aab423          	sd	a0,8(s5)
          b->right = r;
ffffffffc0205546:	01aab823          	sd	s10,16(s5)
          if (l) l->parent = b;
ffffffffc020554a:	c119                	beqz	a0,ffffffffc0205550 <stride_dequeue+0x1b4>
ffffffffc020554c:	01553023          	sd	s5,0(a0)
          a->left = l;
ffffffffc0205550:	0159b423          	sd	s5,8(s3)
          a->right = r;
ffffffffc0205554:	0199b823          	sd	s9,16(s3)
          if (l) l->parent = a;
ffffffffc0205558:	013ab023          	sd	s3,0(s5)
ffffffffc020555c:	b5e5                	j	ffffffffc0205444 <stride_dequeue+0xa8>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020555e:	010ab503          	ld	a0,16(s5)
          r = a->left;
ffffffffc0205562:	008abb83          	ld	s7,8(s5)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205566:	85ca                	mv	a1,s2
ffffffffc0205568:	b97ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc020556c:	00aab423          	sd	a0,8(s5)
          a->right = r;
ffffffffc0205570:	017ab823          	sd	s7,16(s5)
          if (l) l->parent = a;
ffffffffc0205574:	8956                	mv	s2,s5
ffffffffc0205576:	d93d                	beqz	a0,ffffffffc02054ec <stride_dequeue+0x150>
ffffffffc0205578:	01553023          	sd	s5,0(a0)
ffffffffc020557c:	bf85                	j	ffffffffc02054ec <stride_dequeue+0x150>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020557e:	010bb503          	ld	a0,16(s7)
          r = a->left;
ffffffffc0205582:	008bbd03          	ld	s10,8(s7)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc0205586:	85d6                	mv	a1,s5
ffffffffc0205588:	b77ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc020558c:	00abb423          	sd	a0,8(s7)
          a->right = r;
ffffffffc0205590:	01abb823          	sd	s10,16(s7)
          if (l) l->parent = a;
ffffffffc0205594:	8ade                	mv	s5,s7
ffffffffc0205596:	dd4d                	beqz	a0,ffffffffc0205550 <stride_dequeue+0x1b4>
          if (l) l->parent = b;
ffffffffc0205598:	01553023          	sd	s5,0(a0)
ffffffffc020559c:	bf55                	j	ffffffffc0205550 <stride_dequeue+0x1b4>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc020559e:	010ab503          	ld	a0,16(s5)
          r = a->left;
ffffffffc02055a2:	008abd03          	ld	s10,8(s5)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc02055a6:	85de                	mv	a1,s7
ffffffffc02055a8:	b57ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc02055ac:	00aab423          	sd	a0,8(s5)
          a->right = r;
ffffffffc02055b0:	01aab823          	sd	s10,16(s5)
          if (l) l->parent = a;
ffffffffc02055b4:	d515                	beqz	a0,ffffffffc02054e0 <stride_dequeue+0x144>
          if (l) l->parent = b;
ffffffffc02055b6:	01553023          	sd	s5,0(a0)
ffffffffc02055ba:	b71d                	j	ffffffffc02054e0 <stride_dequeue+0x144>
          l = skew_heap_merge(a->right, b, comp);
ffffffffc02055bc:	0109b503          	ld	a0,16(s3)
          r = a->left;
ffffffffc02055c0:	0089bd03          	ld	s10,8(s3)
          l = skew_heap_merge(a->right, b, comp);
ffffffffc02055c4:	85de                	mv	a1,s7
ffffffffc02055c6:	b39ff0ef          	jal	ra,ffffffffc02050fe <skew_heap_merge.constprop.0>
          a->left = l;
ffffffffc02055ca:	00a9b423          	sd	a0,8(s3)
          a->right = r;
ffffffffc02055ce:	01a9b823          	sd	s10,16(s3)
          if (l) l->parent = a;
ffffffffc02055d2:	e60510e3          	bnez	a0,ffffffffc0205432 <stride_dequeue+0x96>
ffffffffc02055d6:	b585                	j	ffffffffc0205436 <stride_dequeue+0x9a>
    assert(proc->rq == rq);
ffffffffc02055d8:	00002697          	auipc	a3,0x2
ffffffffc02055dc:	58068693          	addi	a3,a3,1408 # ffffffffc0207b58 <default_pmm_manager+0xf38>
ffffffffc02055e0:	00001617          	auipc	a2,0x1
ffffffffc02055e4:	29060613          	addi	a2,a2,656 # ffffffffc0206870 <commands+0x850>
ffffffffc02055e8:	06300593          	li	a1,99
ffffffffc02055ec:	00002517          	auipc	a0,0x2
ffffffffc02055f0:	54450513          	addi	a0,a0,1348 # ffffffffc0207b30 <default_pmm_manager+0xf10>
ffffffffc02055f4:	e9ffa0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02055f8 <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void sched_class_proc_tick(struct proc_struct *proc)
{
    if (proc != idleproc)
ffffffffc02055f8:	000e2797          	auipc	a5,0xe2
ffffffffc02055fc:	8587b783          	ld	a5,-1960(a5) # ffffffffc02e6e50 <idleproc>
{
ffffffffc0205600:	85aa                	mv	a1,a0
    if (proc != idleproc)
ffffffffc0205602:	00a78c63          	beq	a5,a0,ffffffffc020561a <sched_class_proc_tick+0x22>
    {
        sched_class->proc_tick(rq, proc);
ffffffffc0205606:	000e2797          	auipc	a5,0xe2
ffffffffc020560a:	86a7b783          	ld	a5,-1942(a5) # ffffffffc02e6e70 <sched_class>
ffffffffc020560e:	779c                	ld	a5,40(a5)
ffffffffc0205610:	000e2517          	auipc	a0,0xe2
ffffffffc0205614:	85853503          	ld	a0,-1960(a0) # ffffffffc02e6e68 <rq>
ffffffffc0205618:	8782                	jr	a5
    }
    else
    {
        proc->need_resched = 1;
ffffffffc020561a:	4705                	li	a4,1
ffffffffc020561c:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc020561e:	8082                	ret

ffffffffc0205620 <sched_init>:

static struct run_queue __rq;

void sched_init(void)
{
ffffffffc0205620:	1141                	addi	sp,sp,-16
    list_init(&timer_list);

    /* Force using stride scheduler (manual single-line switch per user request) */
        sched_class = &stride_sched_class;
ffffffffc0205622:	000dd717          	auipc	a4,0xdd
ffffffffc0205626:	33670713          	addi	a4,a4,822 # ffffffffc02e2958 <stride_sched_class>
{
ffffffffc020562a:	e022                	sd	s0,0(sp)
ffffffffc020562c:	e406                	sd	ra,8(sp)
ffffffffc020562e:	000e1797          	auipc	a5,0xe1
ffffffffc0205632:	7b278793          	addi	a5,a5,1970 # ffffffffc02e6de0 <timer_list>
        //sched_class = &sjf_sched_class;
        //sched_class = &fifo_sched_class;

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc0205636:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc0205638:	000e1517          	auipc	a0,0xe1
ffffffffc020563c:	78850513          	addi	a0,a0,1928 # ffffffffc02e6dc0 <__rq>
ffffffffc0205640:	e79c                	sd	a5,8(a5)
ffffffffc0205642:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc0205644:	4795                	li	a5,5
ffffffffc0205646:	c95c                	sw	a5,20(a0)
        sched_class = &stride_sched_class;
ffffffffc0205648:	000e2417          	auipc	s0,0xe2
ffffffffc020564c:	82840413          	addi	s0,s0,-2008 # ffffffffc02e6e70 <sched_class>
    rq = &__rq;
ffffffffc0205650:	000e2797          	auipc	a5,0xe2
ffffffffc0205654:	80a7bc23          	sd	a0,-2024(a5) # ffffffffc02e6e68 <rq>
        sched_class = &stride_sched_class;
ffffffffc0205658:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc020565a:	9682                	jalr	a3

    /* Print the scheduler name. Use struct->name as the canonical source. */
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc020565c:	601c                	ld	a5,0(s0)
}
ffffffffc020565e:	6402                	ld	s0,0(sp)
ffffffffc0205660:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0205662:	638c                	ld	a1,0(a5)
ffffffffc0205664:	00002517          	auipc	a0,0x2
ffffffffc0205668:	51c50513          	addi	a0,a0,1308 # ffffffffc0207b80 <default_pmm_manager+0xf60>
}
ffffffffc020566c:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc020566e:	b2bfa06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0205672 <wakeup_proc>:

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205672:	4118                	lw	a4,0(a0)
{
ffffffffc0205674:	1101                	addi	sp,sp,-32
ffffffffc0205676:	ec06                	sd	ra,24(sp)
ffffffffc0205678:	e822                	sd	s0,16(sp)
ffffffffc020567a:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020567c:	478d                	li	a5,3
ffffffffc020567e:	08f70363          	beq	a4,a5,ffffffffc0205704 <wakeup_proc+0x92>
ffffffffc0205682:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205684:	100027f3          	csrr	a5,sstatus
ffffffffc0205688:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020568a:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020568c:	e7bd                	bnez	a5,ffffffffc02056fa <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc020568e:	4789                	li	a5,2
ffffffffc0205690:	04f70863          	beq	a4,a5,ffffffffc02056e0 <wakeup_proc+0x6e>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc0205694:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc0205696:	0e042623          	sw	zero,236(s0)
            if (proc != current)
ffffffffc020569a:	000e1797          	auipc	a5,0xe1
ffffffffc020569e:	7ae7b783          	ld	a5,1966(a5) # ffffffffc02e6e48 <current>
ffffffffc02056a2:	02878363          	beq	a5,s0,ffffffffc02056c8 <wakeup_proc+0x56>
    if (proc != idleproc)
ffffffffc02056a6:	000e1797          	auipc	a5,0xe1
ffffffffc02056aa:	7aa7b783          	ld	a5,1962(a5) # ffffffffc02e6e50 <idleproc>
ffffffffc02056ae:	00f40d63          	beq	s0,a5,ffffffffc02056c8 <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc02056b2:	000e1797          	auipc	a5,0xe1
ffffffffc02056b6:	7be7b783          	ld	a5,1982(a5) # ffffffffc02e6e70 <sched_class>
ffffffffc02056ba:	6b9c                	ld	a5,16(a5)
ffffffffc02056bc:	85a2                	mv	a1,s0
ffffffffc02056be:	000e1517          	auipc	a0,0xe1
ffffffffc02056c2:	7aa53503          	ld	a0,1962(a0) # ffffffffc02e6e68 <rq>
ffffffffc02056c6:	9782                	jalr	a5
    if (flag)
ffffffffc02056c8:	e491                	bnez	s1,ffffffffc02056d4 <wakeup_proc+0x62>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02056ca:	60e2                	ld	ra,24(sp)
ffffffffc02056cc:	6442                	ld	s0,16(sp)
ffffffffc02056ce:	64a2                	ld	s1,8(sp)
ffffffffc02056d0:	6105                	addi	sp,sp,32
ffffffffc02056d2:	8082                	ret
ffffffffc02056d4:	6442                	ld	s0,16(sp)
ffffffffc02056d6:	60e2                	ld	ra,24(sp)
ffffffffc02056d8:	64a2                	ld	s1,8(sp)
ffffffffc02056da:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02056dc:	accfb06f          	j	ffffffffc02009a8 <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc02056e0:	00002617          	auipc	a2,0x2
ffffffffc02056e4:	4f060613          	addi	a2,a2,1264 # ffffffffc0207bd0 <default_pmm_manager+0xfb0>
ffffffffc02056e8:	05d00593          	li	a1,93
ffffffffc02056ec:	00002517          	auipc	a0,0x2
ffffffffc02056f0:	4cc50513          	addi	a0,a0,1228 # ffffffffc0207bb8 <default_pmm_manager+0xf98>
ffffffffc02056f4:	e07fa0ef          	jal	ra,ffffffffc02004fa <__warn>
ffffffffc02056f8:	bfc1                	j	ffffffffc02056c8 <wakeup_proc+0x56>
        intr_disable();
ffffffffc02056fa:	ab4fb0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc02056fe:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc0205700:	4485                	li	s1,1
ffffffffc0205702:	b771                	j	ffffffffc020568e <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205704:	00002697          	auipc	a3,0x2
ffffffffc0205708:	49468693          	addi	a3,a3,1172 # ffffffffc0207b98 <default_pmm_manager+0xf78>
ffffffffc020570c:	00001617          	auipc	a2,0x1
ffffffffc0205710:	16460613          	addi	a2,a2,356 # ffffffffc0206870 <commands+0x850>
ffffffffc0205714:	04e00593          	li	a1,78
ffffffffc0205718:	00002517          	auipc	a0,0x2
ffffffffc020571c:	4a050513          	addi	a0,a0,1184 # ffffffffc0207bb8 <default_pmm_manager+0xf98>
ffffffffc0205720:	d73fa0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0205724 <schedule>:

void schedule(void)
{
ffffffffc0205724:	7179                	addi	sp,sp,-48
ffffffffc0205726:	f406                	sd	ra,40(sp)
ffffffffc0205728:	f022                	sd	s0,32(sp)
ffffffffc020572a:	ec26                	sd	s1,24(sp)
ffffffffc020572c:	e84a                	sd	s2,16(sp)
ffffffffc020572e:	e44e                	sd	s3,8(sp)
ffffffffc0205730:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205732:	100027f3          	csrr	a5,sstatus
ffffffffc0205736:	8b89                	andi	a5,a5,2
ffffffffc0205738:	4a01                	li	s4,0
ffffffffc020573a:	e3cd                	bnez	a5,ffffffffc02057dc <schedule+0xb8>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc020573c:	000e1497          	auipc	s1,0xe1
ffffffffc0205740:	70c48493          	addi	s1,s1,1804 # ffffffffc02e6e48 <current>
ffffffffc0205744:	608c                	ld	a1,0(s1)
        sched_class->enqueue(rq, proc);
ffffffffc0205746:	000e1997          	auipc	s3,0xe1
ffffffffc020574a:	72a98993          	addi	s3,s3,1834 # ffffffffc02e6e70 <sched_class>
ffffffffc020574e:	000e1917          	auipc	s2,0xe1
ffffffffc0205752:	71a90913          	addi	s2,s2,1818 # ffffffffc02e6e68 <rq>
        if (current->state == PROC_RUNNABLE)
ffffffffc0205756:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc0205758:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE)
ffffffffc020575c:	4709                	li	a4,2
        sched_class->enqueue(rq, proc);
ffffffffc020575e:	0009b783          	ld	a5,0(s3)
ffffffffc0205762:	00093503          	ld	a0,0(s2)
        if (current->state == PROC_RUNNABLE)
ffffffffc0205766:	04e68e63          	beq	a3,a4,ffffffffc02057c2 <schedule+0x9e>
    return sched_class->pick_next(rq);
ffffffffc020576a:	739c                	ld	a5,32(a5)
ffffffffc020576c:	9782                	jalr	a5
ffffffffc020576e:	842a                	mv	s0,a0
        {
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL)
ffffffffc0205770:	c521                	beqz	a0,ffffffffc02057b8 <schedule+0x94>
    sched_class->dequeue(rq, proc);
ffffffffc0205772:	0009b783          	ld	a5,0(s3)
ffffffffc0205776:	00093503          	ld	a0,0(s2)
ffffffffc020577a:	85a2                	mv	a1,s0
ffffffffc020577c:	6f9c                	ld	a5,24(a5)
ffffffffc020577e:	9782                	jalr	a5
        }
        if (next == NULL)
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc0205780:	441c                	lw	a5,8(s0)
        if (next != current)
ffffffffc0205782:	6098                	ld	a4,0(s1)
        next->runs++;
ffffffffc0205784:	2785                	addiw	a5,a5,1
ffffffffc0205786:	c41c                	sw	a5,8(s0)
        if (next != current)
ffffffffc0205788:	00870563          	beq	a4,s0,ffffffffc0205792 <schedule+0x6e>
        {
            proc_run(next);
ffffffffc020578c:	8522                	mv	a0,s0
ffffffffc020578e:	eeafe0ef          	jal	ra,ffffffffc0203e78 <proc_run>
    if (flag)
ffffffffc0205792:	000a1a63          	bnez	s4,ffffffffc02057a6 <schedule+0x82>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0205796:	70a2                	ld	ra,40(sp)
ffffffffc0205798:	7402                	ld	s0,32(sp)
ffffffffc020579a:	64e2                	ld	s1,24(sp)
ffffffffc020579c:	6942                	ld	s2,16(sp)
ffffffffc020579e:	69a2                	ld	s3,8(sp)
ffffffffc02057a0:	6a02                	ld	s4,0(sp)
ffffffffc02057a2:	6145                	addi	sp,sp,48
ffffffffc02057a4:	8082                	ret
ffffffffc02057a6:	7402                	ld	s0,32(sp)
ffffffffc02057a8:	70a2                	ld	ra,40(sp)
ffffffffc02057aa:	64e2                	ld	s1,24(sp)
ffffffffc02057ac:	6942                	ld	s2,16(sp)
ffffffffc02057ae:	69a2                	ld	s3,8(sp)
ffffffffc02057b0:	6a02                	ld	s4,0(sp)
ffffffffc02057b2:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc02057b4:	9f4fb06f          	j	ffffffffc02009a8 <intr_enable>
            next = idleproc;
ffffffffc02057b8:	000e1417          	auipc	s0,0xe1
ffffffffc02057bc:	69843403          	ld	s0,1688(s0) # ffffffffc02e6e50 <idleproc>
ffffffffc02057c0:	b7c1                	j	ffffffffc0205780 <schedule+0x5c>
    if (proc != idleproc)
ffffffffc02057c2:	000e1717          	auipc	a4,0xe1
ffffffffc02057c6:	68e73703          	ld	a4,1678(a4) # ffffffffc02e6e50 <idleproc>
ffffffffc02057ca:	fae580e3          	beq	a1,a4,ffffffffc020576a <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc02057ce:	6b9c                	ld	a5,16(a5)
ffffffffc02057d0:	9782                	jalr	a5
    return sched_class->pick_next(rq);
ffffffffc02057d2:	0009b783          	ld	a5,0(s3)
ffffffffc02057d6:	00093503          	ld	a0,0(s2)
ffffffffc02057da:	bf41                	j	ffffffffc020576a <schedule+0x46>
        intr_disable();
ffffffffc02057dc:	9d2fb0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc02057e0:	4a05                	li	s4,1
ffffffffc02057e2:	bfa9                	j	ffffffffc020573c <schedule+0x18>

ffffffffc02057e4 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc02057e4:	000e1797          	auipc	a5,0xe1
ffffffffc02057e8:	6647b783          	ld	a5,1636(a5) # ffffffffc02e6e48 <current>
}
ffffffffc02057ec:	43c8                	lw	a0,4(a5)
ffffffffc02057ee:	8082                	ret

ffffffffc02057f0 <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc02057f0:	4501                	li	a0,0
ffffffffc02057f2:	8082                	ret

ffffffffc02057f4 <sys_gettime>:
static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc02057f4:	000e1797          	auipc	a5,0xe1
ffffffffc02057f8:	6047b783          	ld	a5,1540(a5) # ffffffffc02e6df8 <ticks>
ffffffffc02057fc:	0027951b          	slliw	a0,a5,0x2
ffffffffc0205800:	9d3d                	addw	a0,a0,a5
}
ffffffffc0205802:	0015151b          	slliw	a0,a0,0x1
ffffffffc0205806:	8082                	ret

ffffffffc0205808 <sys_lab6_set_priority>:
static int sys_lab6_set_priority(uint64_t arg[]){
    uint64_t priority = (uint64_t)arg[0];
    lab6_set_priority(priority);
ffffffffc0205808:	4108                	lw	a0,0(a0)
static int sys_lab6_set_priority(uint64_t arg[]){
ffffffffc020580a:	1141                	addi	sp,sp,-16
ffffffffc020580c:	e406                	sd	ra,8(sp)
    lab6_set_priority(priority);
ffffffffc020580e:	feaff0ef          	jal	ra,ffffffffc0204ff8 <lab6_set_priority>
    return 0;
}
ffffffffc0205812:	60a2                	ld	ra,8(sp)
ffffffffc0205814:	4501                	li	a0,0
ffffffffc0205816:	0141                	addi	sp,sp,16
ffffffffc0205818:	8082                	ret

ffffffffc020581a <sys_putc>:
    cputchar(c);
ffffffffc020581a:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc020581c:	1141                	addi	sp,sp,-16
ffffffffc020581e:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc0205820:	9affa0ef          	jal	ra,ffffffffc02001ce <cputchar>
}
ffffffffc0205824:	60a2                	ld	ra,8(sp)
ffffffffc0205826:	4501                	li	a0,0
ffffffffc0205828:	0141                	addi	sp,sp,16
ffffffffc020582a:	8082                	ret

ffffffffc020582c <sys_kill>:
    return do_kill(pid);
ffffffffc020582c:	4108                	lw	a0,0(a0)
ffffffffc020582e:	d9cff06f          	j	ffffffffc0204dca <do_kill>

ffffffffc0205832 <sys_yield>:
    return do_yield();
ffffffffc0205832:	d4aff06f          	j	ffffffffc0204d7c <do_yield>

ffffffffc0205836 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0205836:	6d14                	ld	a3,24(a0)
ffffffffc0205838:	6910                	ld	a2,16(a0)
ffffffffc020583a:	650c                	ld	a1,8(a0)
ffffffffc020583c:	6108                	ld	a0,0(a0)
ffffffffc020583e:	f95fe06f          	j	ffffffffc02047d2 <do_execve>

ffffffffc0205842 <sys_wait>:
    return do_wait(pid, store);
ffffffffc0205842:	650c                	ld	a1,8(a0)
ffffffffc0205844:	4108                	lw	a0,0(a0)
ffffffffc0205846:	d46ff06f          	j	ffffffffc0204d8c <do_wait>

ffffffffc020584a <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc020584a:	000e1797          	auipc	a5,0xe1
ffffffffc020584e:	5fe7b783          	ld	a5,1534(a5) # ffffffffc02e6e48 <current>
ffffffffc0205852:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc0205854:	4501                	li	a0,0
ffffffffc0205856:	6a0c                	ld	a1,16(a2)
ffffffffc0205858:	e9afe06f          	j	ffffffffc0203ef2 <do_fork>

ffffffffc020585c <sys_exit>:
    return do_exit(error_code);
ffffffffc020585c:	4108                	lw	a0,0(a0)
ffffffffc020585e:	abdfe06f          	j	ffffffffc020431a <do_exit>

ffffffffc0205862 <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc0205862:	715d                	addi	sp,sp,-80
ffffffffc0205864:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205866:	000e1497          	auipc	s1,0xe1
ffffffffc020586a:	5e248493          	addi	s1,s1,1506 # ffffffffc02e6e48 <current>
ffffffffc020586e:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc0205870:	e0a2                	sd	s0,64(sp)
ffffffffc0205872:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205874:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc0205876:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0205878:	0ff00793          	li	a5,255
    int num = tf->gpr.a0;
ffffffffc020587c:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0205880:	0327ee63          	bltu	a5,s2,ffffffffc02058bc <syscall+0x5a>
        if (syscalls[num] != NULL) {
ffffffffc0205884:	00391713          	slli	a4,s2,0x3
ffffffffc0205888:	00002797          	auipc	a5,0x2
ffffffffc020588c:	3b078793          	addi	a5,a5,944 # ffffffffc0207c38 <syscalls>
ffffffffc0205890:	97ba                	add	a5,a5,a4
ffffffffc0205892:	639c                	ld	a5,0(a5)
ffffffffc0205894:	c785                	beqz	a5,ffffffffc02058bc <syscall+0x5a>
            arg[0] = tf->gpr.a1;
ffffffffc0205896:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc0205898:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc020589a:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc020589c:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc020589e:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02058a0:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02058a2:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02058a4:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02058a6:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02058a8:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02058aa:	0028                	addi	a0,sp,8
ffffffffc02058ac:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02058ae:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02058b0:	e828                	sd	a0,80(s0)
}
ffffffffc02058b2:	6406                	ld	s0,64(sp)
ffffffffc02058b4:	74e2                	ld	s1,56(sp)
ffffffffc02058b6:	7942                	ld	s2,48(sp)
ffffffffc02058b8:	6161                	addi	sp,sp,80
ffffffffc02058ba:	8082                	ret
    print_trapframe(tf);
ffffffffc02058bc:	8522                	mv	a0,s0
ffffffffc02058be:	ae0fb0ef          	jal	ra,ffffffffc0200b9e <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02058c2:	609c                	ld	a5,0(s1)
ffffffffc02058c4:	86ca                	mv	a3,s2
ffffffffc02058c6:	00002617          	auipc	a2,0x2
ffffffffc02058ca:	32a60613          	addi	a2,a2,810 # ffffffffc0207bf0 <default_pmm_manager+0xfd0>
ffffffffc02058ce:	43d8                	lw	a4,4(a5)
ffffffffc02058d0:	06c00593          	li	a1,108
ffffffffc02058d4:	0b478793          	addi	a5,a5,180
ffffffffc02058d8:	00002517          	auipc	a0,0x2
ffffffffc02058dc:	34850513          	addi	a0,a0,840 # ffffffffc0207c20 <default_pmm_manager+0x1000>
ffffffffc02058e0:	bb3fa0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02058e4 <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc02058e4:	9e3707b7          	lui	a5,0x9e370
ffffffffc02058e8:	2785                	addiw	a5,a5,1
ffffffffc02058ea:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc02058ee:	02000793          	li	a5,32
ffffffffc02058f2:	9f8d                	subw	a5,a5,a1
}
ffffffffc02058f4:	00f5553b          	srlw	a0,a0,a5
ffffffffc02058f8:	8082                	ret

ffffffffc02058fa <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02058fa:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02058fe:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0205900:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0205904:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0205906:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020590a:	f022                	sd	s0,32(sp)
ffffffffc020590c:	ec26                	sd	s1,24(sp)
ffffffffc020590e:	e84a                	sd	s2,16(sp)
ffffffffc0205910:	f406                	sd	ra,40(sp)
ffffffffc0205912:	e44e                	sd	s3,8(sp)
ffffffffc0205914:	84aa                	mv	s1,a0
ffffffffc0205916:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0205918:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc020591c:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc020591e:	03067e63          	bgeu	a2,a6,ffffffffc020595a <printnum+0x60>
ffffffffc0205922:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0205924:	00805763          	blez	s0,ffffffffc0205932 <printnum+0x38>
ffffffffc0205928:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc020592a:	85ca                	mv	a1,s2
ffffffffc020592c:	854e                	mv	a0,s3
ffffffffc020592e:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0205930:	fc65                	bnez	s0,ffffffffc0205928 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205932:	1a02                	slli	s4,s4,0x20
ffffffffc0205934:	00003797          	auipc	a5,0x3
ffffffffc0205938:	b0478793          	addi	a5,a5,-1276 # ffffffffc0208438 <syscalls+0x800>
ffffffffc020593c:	020a5a13          	srli	s4,s4,0x20
ffffffffc0205940:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc0205942:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205944:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0205948:	70a2                	ld	ra,40(sp)
ffffffffc020594a:	69a2                	ld	s3,8(sp)
ffffffffc020594c:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020594e:	85ca                	mv	a1,s2
ffffffffc0205950:	87a6                	mv	a5,s1
}
ffffffffc0205952:	6942                	ld	s2,16(sp)
ffffffffc0205954:	64e2                	ld	s1,24(sp)
ffffffffc0205956:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205958:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc020595a:	03065633          	divu	a2,a2,a6
ffffffffc020595e:	8722                	mv	a4,s0
ffffffffc0205960:	f9bff0ef          	jal	ra,ffffffffc02058fa <printnum>
ffffffffc0205964:	b7f9                	j	ffffffffc0205932 <printnum+0x38>

ffffffffc0205966 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0205966:	7119                	addi	sp,sp,-128
ffffffffc0205968:	f4a6                	sd	s1,104(sp)
ffffffffc020596a:	f0ca                	sd	s2,96(sp)
ffffffffc020596c:	ecce                	sd	s3,88(sp)
ffffffffc020596e:	e8d2                	sd	s4,80(sp)
ffffffffc0205970:	e4d6                	sd	s5,72(sp)
ffffffffc0205972:	e0da                	sd	s6,64(sp)
ffffffffc0205974:	fc5e                	sd	s7,56(sp)
ffffffffc0205976:	f06a                	sd	s10,32(sp)
ffffffffc0205978:	fc86                	sd	ra,120(sp)
ffffffffc020597a:	f8a2                	sd	s0,112(sp)
ffffffffc020597c:	f862                	sd	s8,48(sp)
ffffffffc020597e:	f466                	sd	s9,40(sp)
ffffffffc0205980:	ec6e                	sd	s11,24(sp)
ffffffffc0205982:	892a                	mv	s2,a0
ffffffffc0205984:	84ae                	mv	s1,a1
ffffffffc0205986:	8d32                	mv	s10,a2
ffffffffc0205988:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020598a:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc020598e:	5b7d                	li	s6,-1
ffffffffc0205990:	00003a97          	auipc	s5,0x3
ffffffffc0205994:	ad4a8a93          	addi	s5,s5,-1324 # ffffffffc0208464 <syscalls+0x82c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205998:	00003b97          	auipc	s7,0x3
ffffffffc020599c:	ce8b8b93          	addi	s7,s7,-792 # ffffffffc0208680 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02059a0:	000d4503          	lbu	a0,0(s10)
ffffffffc02059a4:	001d0413          	addi	s0,s10,1
ffffffffc02059a8:	01350a63          	beq	a0,s3,ffffffffc02059bc <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc02059ac:	c121                	beqz	a0,ffffffffc02059ec <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc02059ae:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02059b0:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc02059b2:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02059b4:	fff44503          	lbu	a0,-1(s0)
ffffffffc02059b8:	ff351ae3          	bne	a0,s3,ffffffffc02059ac <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02059bc:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02059c0:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02059c4:	4c81                	li	s9,0
ffffffffc02059c6:	4881                	li	a7,0
        width = precision = -1;
ffffffffc02059c8:	5c7d                	li	s8,-1
ffffffffc02059ca:	5dfd                	li	s11,-1
ffffffffc02059cc:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02059d0:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02059d2:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02059d6:	0ff5f593          	zext.b	a1,a1
ffffffffc02059da:	00140d13          	addi	s10,s0,1
ffffffffc02059de:	04b56263          	bltu	a0,a1,ffffffffc0205a22 <vprintfmt+0xbc>
ffffffffc02059e2:	058a                	slli	a1,a1,0x2
ffffffffc02059e4:	95d6                	add	a1,a1,s5
ffffffffc02059e6:	4194                	lw	a3,0(a1)
ffffffffc02059e8:	96d6                	add	a3,a3,s5
ffffffffc02059ea:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02059ec:	70e6                	ld	ra,120(sp)
ffffffffc02059ee:	7446                	ld	s0,112(sp)
ffffffffc02059f0:	74a6                	ld	s1,104(sp)
ffffffffc02059f2:	7906                	ld	s2,96(sp)
ffffffffc02059f4:	69e6                	ld	s3,88(sp)
ffffffffc02059f6:	6a46                	ld	s4,80(sp)
ffffffffc02059f8:	6aa6                	ld	s5,72(sp)
ffffffffc02059fa:	6b06                	ld	s6,64(sp)
ffffffffc02059fc:	7be2                	ld	s7,56(sp)
ffffffffc02059fe:	7c42                	ld	s8,48(sp)
ffffffffc0205a00:	7ca2                	ld	s9,40(sp)
ffffffffc0205a02:	7d02                	ld	s10,32(sp)
ffffffffc0205a04:	6de2                	ld	s11,24(sp)
ffffffffc0205a06:	6109                	addi	sp,sp,128
ffffffffc0205a08:	8082                	ret
            padc = '0';
ffffffffc0205a0a:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0205a0c:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205a10:	846a                	mv	s0,s10
ffffffffc0205a12:	00140d13          	addi	s10,s0,1
ffffffffc0205a16:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0205a1a:	0ff5f593          	zext.b	a1,a1
ffffffffc0205a1e:	fcb572e3          	bgeu	a0,a1,ffffffffc02059e2 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0205a22:	85a6                	mv	a1,s1
ffffffffc0205a24:	02500513          	li	a0,37
ffffffffc0205a28:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0205a2a:	fff44783          	lbu	a5,-1(s0)
ffffffffc0205a2e:	8d22                	mv	s10,s0
ffffffffc0205a30:	f73788e3          	beq	a5,s3,ffffffffc02059a0 <vprintfmt+0x3a>
ffffffffc0205a34:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0205a38:	1d7d                	addi	s10,s10,-1
ffffffffc0205a3a:	ff379de3          	bne	a5,s3,ffffffffc0205a34 <vprintfmt+0xce>
ffffffffc0205a3e:	b78d                	j	ffffffffc02059a0 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0205a40:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0205a44:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205a48:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0205a4a:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0205a4e:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205a52:	02d86463          	bltu	a6,a3,ffffffffc0205a7a <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0205a56:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0205a5a:	002c169b          	slliw	a3,s8,0x2
ffffffffc0205a5e:	0186873b          	addw	a4,a3,s8
ffffffffc0205a62:	0017171b          	slliw	a4,a4,0x1
ffffffffc0205a66:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0205a68:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0205a6c:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0205a6e:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0205a72:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205a76:	fed870e3          	bgeu	a6,a3,ffffffffc0205a56 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0205a7a:	f40ddce3          	bgez	s11,ffffffffc02059d2 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0205a7e:	8de2                	mv	s11,s8
ffffffffc0205a80:	5c7d                	li	s8,-1
ffffffffc0205a82:	bf81                	j	ffffffffc02059d2 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0205a84:	fffdc693          	not	a3,s11
ffffffffc0205a88:	96fd                	srai	a3,a3,0x3f
ffffffffc0205a8a:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205a8e:	00144603          	lbu	a2,1(s0)
ffffffffc0205a92:	2d81                	sext.w	s11,s11
ffffffffc0205a94:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205a96:	bf35                	j	ffffffffc02059d2 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0205a98:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205a9c:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0205aa0:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205aa2:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0205aa4:	bfd9                	j	ffffffffc0205a7a <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0205aa6:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205aa8:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205aac:	01174463          	blt	a4,a7,ffffffffc0205ab4 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0205ab0:	1a088e63          	beqz	a7,ffffffffc0205c6c <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0205ab4:	000a3603          	ld	a2,0(s4)
ffffffffc0205ab8:	46c1                	li	a3,16
ffffffffc0205aba:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0205abc:	2781                	sext.w	a5,a5
ffffffffc0205abe:	876e                	mv	a4,s11
ffffffffc0205ac0:	85a6                	mv	a1,s1
ffffffffc0205ac2:	854a                	mv	a0,s2
ffffffffc0205ac4:	e37ff0ef          	jal	ra,ffffffffc02058fa <printnum>
            break;
ffffffffc0205ac8:	bde1                	j	ffffffffc02059a0 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0205aca:	000a2503          	lw	a0,0(s4)
ffffffffc0205ace:	85a6                	mv	a1,s1
ffffffffc0205ad0:	0a21                	addi	s4,s4,8
ffffffffc0205ad2:	9902                	jalr	s2
            break;
ffffffffc0205ad4:	b5f1                	j	ffffffffc02059a0 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0205ad6:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205ad8:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205adc:	01174463          	blt	a4,a7,ffffffffc0205ae4 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0205ae0:	18088163          	beqz	a7,ffffffffc0205c62 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0205ae4:	000a3603          	ld	a2,0(s4)
ffffffffc0205ae8:	46a9                	li	a3,10
ffffffffc0205aea:	8a2e                	mv	s4,a1
ffffffffc0205aec:	bfc1                	j	ffffffffc0205abc <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205aee:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0205af2:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205af4:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205af6:	bdf1                	j	ffffffffc02059d2 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0205af8:	85a6                	mv	a1,s1
ffffffffc0205afa:	02500513          	li	a0,37
ffffffffc0205afe:	9902                	jalr	s2
            break;
ffffffffc0205b00:	b545                	j	ffffffffc02059a0 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205b02:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0205b06:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205b08:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205b0a:	b5e1                	j	ffffffffc02059d2 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0205b0c:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205b0e:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205b12:	01174463          	blt	a4,a7,ffffffffc0205b1a <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0205b16:	14088163          	beqz	a7,ffffffffc0205c58 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0205b1a:	000a3603          	ld	a2,0(s4)
ffffffffc0205b1e:	46a1                	li	a3,8
ffffffffc0205b20:	8a2e                	mv	s4,a1
ffffffffc0205b22:	bf69                	j	ffffffffc0205abc <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0205b24:	03000513          	li	a0,48
ffffffffc0205b28:	85a6                	mv	a1,s1
ffffffffc0205b2a:	e03e                	sd	a5,0(sp)
ffffffffc0205b2c:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0205b2e:	85a6                	mv	a1,s1
ffffffffc0205b30:	07800513          	li	a0,120
ffffffffc0205b34:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205b36:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0205b38:	6782                	ld	a5,0(sp)
ffffffffc0205b3a:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205b3c:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0205b40:	bfb5                	j	ffffffffc0205abc <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0205b42:	000a3403          	ld	s0,0(s4)
ffffffffc0205b46:	008a0713          	addi	a4,s4,8
ffffffffc0205b4a:	e03a                	sd	a4,0(sp)
ffffffffc0205b4c:	14040263          	beqz	s0,ffffffffc0205c90 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0205b50:	0fb05763          	blez	s11,ffffffffc0205c3e <vprintfmt+0x2d8>
ffffffffc0205b54:	02d00693          	li	a3,45
ffffffffc0205b58:	0cd79163          	bne	a5,a3,ffffffffc0205c1a <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205b5c:	00044783          	lbu	a5,0(s0)
ffffffffc0205b60:	0007851b          	sext.w	a0,a5
ffffffffc0205b64:	cf85                	beqz	a5,ffffffffc0205b9c <vprintfmt+0x236>
ffffffffc0205b66:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205b6a:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205b6e:	000c4563          	bltz	s8,ffffffffc0205b78 <vprintfmt+0x212>
ffffffffc0205b72:	3c7d                	addiw	s8,s8,-1
ffffffffc0205b74:	036c0263          	beq	s8,s6,ffffffffc0205b98 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0205b78:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205b7a:	0e0c8e63          	beqz	s9,ffffffffc0205c76 <vprintfmt+0x310>
ffffffffc0205b7e:	3781                	addiw	a5,a5,-32
ffffffffc0205b80:	0ef47b63          	bgeu	s0,a5,ffffffffc0205c76 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0205b84:	03f00513          	li	a0,63
ffffffffc0205b88:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205b8a:	000a4783          	lbu	a5,0(s4)
ffffffffc0205b8e:	3dfd                	addiw	s11,s11,-1
ffffffffc0205b90:	0a05                	addi	s4,s4,1
ffffffffc0205b92:	0007851b          	sext.w	a0,a5
ffffffffc0205b96:	ffe1                	bnez	a5,ffffffffc0205b6e <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0205b98:	01b05963          	blez	s11,ffffffffc0205baa <vprintfmt+0x244>
ffffffffc0205b9c:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0205b9e:	85a6                	mv	a1,s1
ffffffffc0205ba0:	02000513          	li	a0,32
ffffffffc0205ba4:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0205ba6:	fe0d9be3          	bnez	s11,ffffffffc0205b9c <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0205baa:	6a02                	ld	s4,0(sp)
ffffffffc0205bac:	bbd5                	j	ffffffffc02059a0 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0205bae:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205bb0:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0205bb4:	01174463          	blt	a4,a7,ffffffffc0205bbc <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0205bb8:	08088d63          	beqz	a7,ffffffffc0205c52 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0205bbc:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0205bc0:	0a044d63          	bltz	s0,ffffffffc0205c7a <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0205bc4:	8622                	mv	a2,s0
ffffffffc0205bc6:	8a66                	mv	s4,s9
ffffffffc0205bc8:	46a9                	li	a3,10
ffffffffc0205bca:	bdcd                	j	ffffffffc0205abc <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0205bcc:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205bd0:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0205bd2:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0205bd4:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0205bd8:	8fb5                	xor	a5,a5,a3
ffffffffc0205bda:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205bde:	02d74163          	blt	a4,a3,ffffffffc0205c00 <vprintfmt+0x29a>
ffffffffc0205be2:	00369793          	slli	a5,a3,0x3
ffffffffc0205be6:	97de                	add	a5,a5,s7
ffffffffc0205be8:	639c                	ld	a5,0(a5)
ffffffffc0205bea:	cb99                	beqz	a5,ffffffffc0205c00 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0205bec:	86be                	mv	a3,a5
ffffffffc0205bee:	00000617          	auipc	a2,0x0
ffffffffc0205bf2:	1f260613          	addi	a2,a2,498 # ffffffffc0205de0 <etext+0x2c>
ffffffffc0205bf6:	85a6                	mv	a1,s1
ffffffffc0205bf8:	854a                	mv	a0,s2
ffffffffc0205bfa:	0ce000ef          	jal	ra,ffffffffc0205cc8 <printfmt>
ffffffffc0205bfe:	b34d                	j	ffffffffc02059a0 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0205c00:	00003617          	auipc	a2,0x3
ffffffffc0205c04:	85860613          	addi	a2,a2,-1960 # ffffffffc0208458 <syscalls+0x820>
ffffffffc0205c08:	85a6                	mv	a1,s1
ffffffffc0205c0a:	854a                	mv	a0,s2
ffffffffc0205c0c:	0bc000ef          	jal	ra,ffffffffc0205cc8 <printfmt>
ffffffffc0205c10:	bb41                	j	ffffffffc02059a0 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0205c12:	00003417          	auipc	s0,0x3
ffffffffc0205c16:	83e40413          	addi	s0,s0,-1986 # ffffffffc0208450 <syscalls+0x818>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205c1a:	85e2                	mv	a1,s8
ffffffffc0205c1c:	8522                	mv	a0,s0
ffffffffc0205c1e:	e43e                	sd	a5,8(sp)
ffffffffc0205c20:	0e2000ef          	jal	ra,ffffffffc0205d02 <strnlen>
ffffffffc0205c24:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0205c28:	01b05b63          	blez	s11,ffffffffc0205c3e <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0205c2c:	67a2                	ld	a5,8(sp)
ffffffffc0205c2e:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205c32:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0205c34:	85a6                	mv	a1,s1
ffffffffc0205c36:	8552                	mv	a0,s4
ffffffffc0205c38:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205c3a:	fe0d9ce3          	bnez	s11,ffffffffc0205c32 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205c3e:	00044783          	lbu	a5,0(s0)
ffffffffc0205c42:	00140a13          	addi	s4,s0,1
ffffffffc0205c46:	0007851b          	sext.w	a0,a5
ffffffffc0205c4a:	d3a5                	beqz	a5,ffffffffc0205baa <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205c4c:	05e00413          	li	s0,94
ffffffffc0205c50:	bf39                	j	ffffffffc0205b6e <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0205c52:	000a2403          	lw	s0,0(s4)
ffffffffc0205c56:	b7ad                	j	ffffffffc0205bc0 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0205c58:	000a6603          	lwu	a2,0(s4)
ffffffffc0205c5c:	46a1                	li	a3,8
ffffffffc0205c5e:	8a2e                	mv	s4,a1
ffffffffc0205c60:	bdb1                	j	ffffffffc0205abc <vprintfmt+0x156>
ffffffffc0205c62:	000a6603          	lwu	a2,0(s4)
ffffffffc0205c66:	46a9                	li	a3,10
ffffffffc0205c68:	8a2e                	mv	s4,a1
ffffffffc0205c6a:	bd89                	j	ffffffffc0205abc <vprintfmt+0x156>
ffffffffc0205c6c:	000a6603          	lwu	a2,0(s4)
ffffffffc0205c70:	46c1                	li	a3,16
ffffffffc0205c72:	8a2e                	mv	s4,a1
ffffffffc0205c74:	b5a1                	j	ffffffffc0205abc <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0205c76:	9902                	jalr	s2
ffffffffc0205c78:	bf09                	j	ffffffffc0205b8a <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0205c7a:	85a6                	mv	a1,s1
ffffffffc0205c7c:	02d00513          	li	a0,45
ffffffffc0205c80:	e03e                	sd	a5,0(sp)
ffffffffc0205c82:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0205c84:	6782                	ld	a5,0(sp)
ffffffffc0205c86:	8a66                	mv	s4,s9
ffffffffc0205c88:	40800633          	neg	a2,s0
ffffffffc0205c8c:	46a9                	li	a3,10
ffffffffc0205c8e:	b53d                	j	ffffffffc0205abc <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0205c90:	03b05163          	blez	s11,ffffffffc0205cb2 <vprintfmt+0x34c>
ffffffffc0205c94:	02d00693          	li	a3,45
ffffffffc0205c98:	f6d79de3          	bne	a5,a3,ffffffffc0205c12 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0205c9c:	00002417          	auipc	s0,0x2
ffffffffc0205ca0:	7b440413          	addi	s0,s0,1972 # ffffffffc0208450 <syscalls+0x818>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205ca4:	02800793          	li	a5,40
ffffffffc0205ca8:	02800513          	li	a0,40
ffffffffc0205cac:	00140a13          	addi	s4,s0,1
ffffffffc0205cb0:	bd6d                	j	ffffffffc0205b6a <vprintfmt+0x204>
ffffffffc0205cb2:	00002a17          	auipc	s4,0x2
ffffffffc0205cb6:	79fa0a13          	addi	s4,s4,1951 # ffffffffc0208451 <syscalls+0x819>
ffffffffc0205cba:	02800513          	li	a0,40
ffffffffc0205cbe:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205cc2:	05e00413          	li	s0,94
ffffffffc0205cc6:	b565                	j	ffffffffc0205b6e <vprintfmt+0x208>

ffffffffc0205cc8 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0205cc8:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0205cca:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0205cce:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0205cd0:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0205cd2:	ec06                	sd	ra,24(sp)
ffffffffc0205cd4:	f83a                	sd	a4,48(sp)
ffffffffc0205cd6:	fc3e                	sd	a5,56(sp)
ffffffffc0205cd8:	e0c2                	sd	a6,64(sp)
ffffffffc0205cda:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0205cdc:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0205cde:	c89ff0ef          	jal	ra,ffffffffc0205966 <vprintfmt>
}
ffffffffc0205ce2:	60e2                	ld	ra,24(sp)
ffffffffc0205ce4:	6161                	addi	sp,sp,80
ffffffffc0205ce6:	8082                	ret

ffffffffc0205ce8 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0205ce8:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0205cec:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0205cee:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0205cf0:	cb81                	beqz	a5,ffffffffc0205d00 <strlen+0x18>
        cnt ++;
ffffffffc0205cf2:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0205cf4:	00a707b3          	add	a5,a4,a0
ffffffffc0205cf8:	0007c783          	lbu	a5,0(a5)
ffffffffc0205cfc:	fbfd                	bnez	a5,ffffffffc0205cf2 <strlen+0xa>
ffffffffc0205cfe:	8082                	ret
    }
    return cnt;
}
ffffffffc0205d00:	8082                	ret

ffffffffc0205d02 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0205d02:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0205d04:	e589                	bnez	a1,ffffffffc0205d0e <strnlen+0xc>
ffffffffc0205d06:	a811                	j	ffffffffc0205d1a <strnlen+0x18>
        cnt ++;
ffffffffc0205d08:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0205d0a:	00f58863          	beq	a1,a5,ffffffffc0205d1a <strnlen+0x18>
ffffffffc0205d0e:	00f50733          	add	a4,a0,a5
ffffffffc0205d12:	00074703          	lbu	a4,0(a4)
ffffffffc0205d16:	fb6d                	bnez	a4,ffffffffc0205d08 <strnlen+0x6>
ffffffffc0205d18:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0205d1a:	852e                	mv	a0,a1
ffffffffc0205d1c:	8082                	ret

ffffffffc0205d1e <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc0205d1e:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc0205d20:	0005c703          	lbu	a4,0(a1)
ffffffffc0205d24:	0785                	addi	a5,a5,1
ffffffffc0205d26:	0585                	addi	a1,a1,1
ffffffffc0205d28:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0205d2c:	fb75                	bnez	a4,ffffffffc0205d20 <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc0205d2e:	8082                	ret

ffffffffc0205d30 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205d30:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205d34:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205d38:	cb89                	beqz	a5,ffffffffc0205d4a <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0205d3a:	0505                	addi	a0,a0,1
ffffffffc0205d3c:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205d3e:	fee789e3          	beq	a5,a4,ffffffffc0205d30 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205d42:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0205d46:	9d19                	subw	a0,a0,a4
ffffffffc0205d48:	8082                	ret
ffffffffc0205d4a:	4501                	li	a0,0
ffffffffc0205d4c:	bfed                	j	ffffffffc0205d46 <strcmp+0x16>

ffffffffc0205d4e <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205d4e:	c20d                	beqz	a2,ffffffffc0205d70 <strncmp+0x22>
ffffffffc0205d50:	962e                	add	a2,a2,a1
ffffffffc0205d52:	a031                	j	ffffffffc0205d5e <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0205d54:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205d56:	00e79a63          	bne	a5,a4,ffffffffc0205d6a <strncmp+0x1c>
ffffffffc0205d5a:	00b60b63          	beq	a2,a1,ffffffffc0205d70 <strncmp+0x22>
ffffffffc0205d5e:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0205d62:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205d64:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0205d68:	f7f5                	bnez	a5,ffffffffc0205d54 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205d6a:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0205d6e:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205d70:	4501                	li	a0,0
ffffffffc0205d72:	8082                	ret

ffffffffc0205d74 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0205d74:	00054783          	lbu	a5,0(a0)
ffffffffc0205d78:	c799                	beqz	a5,ffffffffc0205d86 <strchr+0x12>
        if (*s == c) {
ffffffffc0205d7a:	00f58763          	beq	a1,a5,ffffffffc0205d88 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0205d7e:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0205d82:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0205d84:	fbfd                	bnez	a5,ffffffffc0205d7a <strchr+0x6>
    }
    return NULL;
ffffffffc0205d86:	4501                	li	a0,0
}
ffffffffc0205d88:	8082                	ret

ffffffffc0205d8a <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0205d8a:	ca01                	beqz	a2,ffffffffc0205d9a <memset+0x10>
ffffffffc0205d8c:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0205d8e:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0205d90:	0785                	addi	a5,a5,1
ffffffffc0205d92:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0205d96:	fec79de3          	bne	a5,a2,ffffffffc0205d90 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0205d9a:	8082                	ret

ffffffffc0205d9c <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0205d9c:	ca19                	beqz	a2,ffffffffc0205db2 <memcpy+0x16>
ffffffffc0205d9e:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc0205da0:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc0205da2:	0005c703          	lbu	a4,0(a1)
ffffffffc0205da6:	0585                	addi	a1,a1,1
ffffffffc0205da8:	0785                	addi	a5,a5,1
ffffffffc0205daa:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc0205dae:	fec59ae3          	bne	a1,a2,ffffffffc0205da2 <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc0205db2:	8082                	ret
