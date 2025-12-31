
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000b297          	auipc	t0,0xb
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020b000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000b297          	auipc	t0,0xb
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020b008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020a2b7          	lui	t0,0xc020a
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
ffffffffc020003c:	c020a137          	lui	sp,0xc020a

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
ffffffffc020004a:	000a7517          	auipc	a0,0xa7
ffffffffc020004e:	95e50513          	addi	a0,a0,-1698 # ffffffffc02a69a8 <buf>
ffffffffc0200052:	000ab617          	auipc	a2,0xab
ffffffffc0200056:	e0260613          	addi	a2,a2,-510 # ffffffffc02aae54 <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	698050ef          	jal	ra,ffffffffc02056fa <memset>
    dtb_init();
ffffffffc0200066:	598000ef          	jal	ra,ffffffffc02005fe <dtb_init>
    cons_init(); // init the console
ffffffffc020006a:	522000ef          	jal	ra,ffffffffc020058c <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006e:	00005597          	auipc	a1,0x5
ffffffffc0200072:	6ba58593          	addi	a1,a1,1722 # ffffffffc0205728 <etext+0x4>
ffffffffc0200076:	00005517          	auipc	a0,0x5
ffffffffc020007a:	6d250513          	addi	a0,a0,1746 # ffffffffc0205748 <etext+0x24>
ffffffffc020007e:	116000ef          	jal	ra,ffffffffc0200194 <cprintf>

    print_kerninfo();
ffffffffc0200082:	19a000ef          	jal	ra,ffffffffc020021c <print_kerninfo>

    // grade_backtrace();

    pmm_init(); // init physical memory management
ffffffffc0200086:	6c4020ef          	jal	ra,ffffffffc020274a <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	131000ef          	jal	ra,ffffffffc02009ba <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	12f000ef          	jal	ra,ffffffffc02009bc <idt_init>

    vmm_init();  // init virtual memory management
ffffffffc0200092:	19d030ef          	jal	ra,ffffffffc0203a2e <vmm_init>
    proc_init(); // init process table
ffffffffc0200096:	5b7040ef          	jal	ra,ffffffffc0204e4c <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009a:	4a0000ef          	jal	ra,ffffffffc020053a <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc020009e:	111000ef          	jal	ra,ffffffffc02009ae <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a2:	743040ef          	jal	ra,ffffffffc0204fe4 <cpu_idle>

ffffffffc02000a6 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02000a6:	715d                	addi	sp,sp,-80
ffffffffc02000a8:	e486                	sd	ra,72(sp)
ffffffffc02000aa:	e0a6                	sd	s1,64(sp)
ffffffffc02000ac:	fc4a                	sd	s2,56(sp)
ffffffffc02000ae:	f84e                	sd	s3,48(sp)
ffffffffc02000b0:	f452                	sd	s4,40(sp)
ffffffffc02000b2:	f056                	sd	s5,32(sp)
ffffffffc02000b4:	ec5a                	sd	s6,24(sp)
ffffffffc02000b6:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc02000b8:	c901                	beqz	a0,ffffffffc02000c8 <readline+0x22>
ffffffffc02000ba:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc02000bc:	00005517          	auipc	a0,0x5
ffffffffc02000c0:	69450513          	addi	a0,a0,1684 # ffffffffc0205750 <etext+0x2c>
ffffffffc02000c4:	0d0000ef          	jal	ra,ffffffffc0200194 <cprintf>
readline(const char *prompt) {
ffffffffc02000c8:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ca:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc02000cc:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc02000ce:	4aa9                	li	s5,10
ffffffffc02000d0:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc02000d2:	000a7b97          	auipc	s7,0xa7
ffffffffc02000d6:	8d6b8b93          	addi	s7,s7,-1834 # ffffffffc02a69a8 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000da:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02000de:	12e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000e2:	00054a63          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000e6:	00a95a63          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc02000ea:	029a5263          	bge	s4,s1,ffffffffc020010e <readline+0x68>
        c = getchar();
ffffffffc02000ee:	11e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000f2:	fe055ae3          	bgez	a0,ffffffffc02000e6 <readline+0x40>
            return NULL;
ffffffffc02000f6:	4501                	li	a0,0
ffffffffc02000f8:	a091                	j	ffffffffc020013c <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02000fa:	03351463          	bne	a0,s3,ffffffffc0200122 <readline+0x7c>
ffffffffc02000fe:	e8a9                	bnez	s1,ffffffffc0200150 <readline+0xaa>
        c = getchar();
ffffffffc0200100:	10c000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc0200104:	fe0549e3          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200108:	fea959e3          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc020010c:	4481                	li	s1,0
            cputchar(c);
ffffffffc020010e:	e42a                	sd	a0,8(sp)
ffffffffc0200110:	0ba000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i ++] = c;
ffffffffc0200114:	6522                	ld	a0,8(sp)
ffffffffc0200116:	009b87b3          	add	a5,s7,s1
ffffffffc020011a:	2485                	addiw	s1,s1,1
ffffffffc020011c:	00a78023          	sb	a0,0(a5)
ffffffffc0200120:	bf7d                	j	ffffffffc02000de <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0200122:	01550463          	beq	a0,s5,ffffffffc020012a <readline+0x84>
ffffffffc0200126:	fb651ce3          	bne	a0,s6,ffffffffc02000de <readline+0x38>
            cputchar(c);
ffffffffc020012a:	0a0000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i] = '\0';
ffffffffc020012e:	000a7517          	auipc	a0,0xa7
ffffffffc0200132:	87a50513          	addi	a0,a0,-1926 # ffffffffc02a69a8 <buf>
ffffffffc0200136:	94aa                	add	s1,s1,a0
ffffffffc0200138:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc020013c:	60a6                	ld	ra,72(sp)
ffffffffc020013e:	6486                	ld	s1,64(sp)
ffffffffc0200140:	7962                	ld	s2,56(sp)
ffffffffc0200142:	79c2                	ld	s3,48(sp)
ffffffffc0200144:	7a22                	ld	s4,40(sp)
ffffffffc0200146:	7a82                	ld	s5,32(sp)
ffffffffc0200148:	6b62                	ld	s6,24(sp)
ffffffffc020014a:	6bc2                	ld	s7,16(sp)
ffffffffc020014c:	6161                	addi	sp,sp,80
ffffffffc020014e:	8082                	ret
            cputchar(c);
ffffffffc0200150:	4521                	li	a0,8
ffffffffc0200152:	078000ef          	jal	ra,ffffffffc02001ca <cputchar>
            i --;
ffffffffc0200156:	34fd                	addiw	s1,s1,-1
ffffffffc0200158:	b759                	j	ffffffffc02000de <readline+0x38>

ffffffffc020015a <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc020015a:	1141                	addi	sp,sp,-16
ffffffffc020015c:	e022                	sd	s0,0(sp)
ffffffffc020015e:	e406                	sd	ra,8(sp)
ffffffffc0200160:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200162:	42c000ef          	jal	ra,ffffffffc020058e <cons_putc>
    (*cnt)++;
ffffffffc0200166:	401c                	lw	a5,0(s0)
}
ffffffffc0200168:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc020016a:	2785                	addiw	a5,a5,1
ffffffffc020016c:	c01c                	sw	a5,0(s0)
}
ffffffffc020016e:	6402                	ld	s0,0(sp)
ffffffffc0200170:	0141                	addi	sp,sp,16
ffffffffc0200172:	8082                	ret

ffffffffc0200174 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc0200174:	1101                	addi	sp,sp,-32
ffffffffc0200176:	862a                	mv	a2,a0
ffffffffc0200178:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020017a:	00000517          	auipc	a0,0x0
ffffffffc020017e:	fe050513          	addi	a0,a0,-32 # ffffffffc020015a <cputch>
ffffffffc0200182:	006c                	addi	a1,sp,12
{
ffffffffc0200184:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc0200186:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc0200188:	14e050ef          	jal	ra,ffffffffc02052d6 <vprintfmt>
    return cnt;
}
ffffffffc020018c:	60e2                	ld	ra,24(sp)
ffffffffc020018e:	4532                	lw	a0,12(sp)
ffffffffc0200190:	6105                	addi	sp,sp,32
ffffffffc0200192:	8082                	ret

ffffffffc0200194 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc0200194:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200196:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
{
ffffffffc020019a:	8e2a                	mv	t3,a0
ffffffffc020019c:	f42e                	sd	a1,40(sp)
ffffffffc020019e:	f832                	sd	a2,48(sp)
ffffffffc02001a0:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001a2:	00000517          	auipc	a0,0x0
ffffffffc02001a6:	fb850513          	addi	a0,a0,-72 # ffffffffc020015a <cputch>
ffffffffc02001aa:	004c                	addi	a1,sp,4
ffffffffc02001ac:	869a                	mv	a3,t1
ffffffffc02001ae:	8672                	mv	a2,t3
{
ffffffffc02001b0:	ec06                	sd	ra,24(sp)
ffffffffc02001b2:	e0ba                	sd	a4,64(sp)
ffffffffc02001b4:	e4be                	sd	a5,72(sp)
ffffffffc02001b6:	e8c2                	sd	a6,80(sp)
ffffffffc02001b8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001ba:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001bc:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001be:	118050ef          	jal	ra,ffffffffc02052d6 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001c2:	60e2                	ld	ra,24(sp)
ffffffffc02001c4:	4512                	lw	a0,4(sp)
ffffffffc02001c6:	6125                	addi	sp,sp,96
ffffffffc02001c8:	8082                	ret

ffffffffc02001ca <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc02001ca:	a6d1                	j	ffffffffc020058e <cons_putc>

ffffffffc02001cc <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc02001cc:	1101                	addi	sp,sp,-32
ffffffffc02001ce:	e822                	sd	s0,16(sp)
ffffffffc02001d0:	ec06                	sd	ra,24(sp)
ffffffffc02001d2:	e426                	sd	s1,8(sp)
ffffffffc02001d4:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc02001d6:	00054503          	lbu	a0,0(a0)
ffffffffc02001da:	c51d                	beqz	a0,ffffffffc0200208 <cputs+0x3c>
ffffffffc02001dc:	0405                	addi	s0,s0,1
ffffffffc02001de:	4485                	li	s1,1
ffffffffc02001e0:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001e2:	3ac000ef          	jal	ra,ffffffffc020058e <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc02001e6:	00044503          	lbu	a0,0(s0)
ffffffffc02001ea:	008487bb          	addw	a5,s1,s0
ffffffffc02001ee:	0405                	addi	s0,s0,1
ffffffffc02001f0:	f96d                	bnez	a0,ffffffffc02001e2 <cputs+0x16>
    (*cnt)++;
ffffffffc02001f2:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001f6:	4529                	li	a0,10
ffffffffc02001f8:	396000ef          	jal	ra,ffffffffc020058e <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc02001fc:	60e2                	ld	ra,24(sp)
ffffffffc02001fe:	8522                	mv	a0,s0
ffffffffc0200200:	6442                	ld	s0,16(sp)
ffffffffc0200202:	64a2                	ld	s1,8(sp)
ffffffffc0200204:	6105                	addi	sp,sp,32
ffffffffc0200206:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc0200208:	4405                	li	s0,1
ffffffffc020020a:	b7f5                	j	ffffffffc02001f6 <cputs+0x2a>

ffffffffc020020c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc020020c:	1141                	addi	sp,sp,-16
ffffffffc020020e:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200210:	3b2000ef          	jal	ra,ffffffffc02005c2 <cons_getc>
ffffffffc0200214:	dd75                	beqz	a0,ffffffffc0200210 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200216:	60a2                	ld	ra,8(sp)
ffffffffc0200218:	0141                	addi	sp,sp,16
ffffffffc020021a:	8082                	ret

ffffffffc020021c <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void)
{
ffffffffc020021c:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc020021e:	00005517          	auipc	a0,0x5
ffffffffc0200222:	53a50513          	addi	a0,a0,1338 # ffffffffc0205758 <etext+0x34>
{
ffffffffc0200226:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200228:	f6dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc020022c:	00000597          	auipc	a1,0x0
ffffffffc0200230:	e1e58593          	addi	a1,a1,-482 # ffffffffc020004a <kern_init>
ffffffffc0200234:	00005517          	auipc	a0,0x5
ffffffffc0200238:	54450513          	addi	a0,a0,1348 # ffffffffc0205778 <etext+0x54>
ffffffffc020023c:	f59ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc0200240:	00005597          	auipc	a1,0x5
ffffffffc0200244:	4e458593          	addi	a1,a1,1252 # ffffffffc0205724 <etext>
ffffffffc0200248:	00005517          	auipc	a0,0x5
ffffffffc020024c:	55050513          	addi	a0,a0,1360 # ffffffffc0205798 <etext+0x74>
ffffffffc0200250:	f45ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200254:	000a6597          	auipc	a1,0xa6
ffffffffc0200258:	75458593          	addi	a1,a1,1876 # ffffffffc02a69a8 <buf>
ffffffffc020025c:	00005517          	auipc	a0,0x5
ffffffffc0200260:	55c50513          	addi	a0,a0,1372 # ffffffffc02057b8 <etext+0x94>
ffffffffc0200264:	f31ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc0200268:	000ab597          	auipc	a1,0xab
ffffffffc020026c:	bec58593          	addi	a1,a1,-1044 # ffffffffc02aae54 <end>
ffffffffc0200270:	00005517          	auipc	a0,0x5
ffffffffc0200274:	56850513          	addi	a0,a0,1384 # ffffffffc02057d8 <etext+0xb4>
ffffffffc0200278:	f1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc020027c:	000ab597          	auipc	a1,0xab
ffffffffc0200280:	fd758593          	addi	a1,a1,-41 # ffffffffc02ab253 <end+0x3ff>
ffffffffc0200284:	00000797          	auipc	a5,0x0
ffffffffc0200288:	dc678793          	addi	a5,a5,-570 # ffffffffc020004a <kern_init>
ffffffffc020028c:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200290:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200294:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200296:	3ff5f593          	andi	a1,a1,1023
ffffffffc020029a:	95be                	add	a1,a1,a5
ffffffffc020029c:	85a9                	srai	a1,a1,0xa
ffffffffc020029e:	00005517          	auipc	a0,0x5
ffffffffc02002a2:	55a50513          	addi	a0,a0,1370 # ffffffffc02057f8 <etext+0xd4>
}
ffffffffc02002a6:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02002a8:	b5f5                	j	ffffffffc0200194 <cprintf>

ffffffffc02002aa <print_stackframe>:
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void)
{
ffffffffc02002aa:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02002ac:	00005617          	auipc	a2,0x5
ffffffffc02002b0:	57c60613          	addi	a2,a2,1404 # ffffffffc0205828 <etext+0x104>
ffffffffc02002b4:	04f00593          	li	a1,79
ffffffffc02002b8:	00005517          	auipc	a0,0x5
ffffffffc02002bc:	58850513          	addi	a0,a0,1416 # ffffffffc0205840 <etext+0x11c>
{
ffffffffc02002c0:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02002c2:	1cc000ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02002c6 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int mon_help(int argc, char **argv, struct trapframe *tf)
{
ffffffffc02002c6:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i++)
    {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002c8:	00005617          	auipc	a2,0x5
ffffffffc02002cc:	59060613          	addi	a2,a2,1424 # ffffffffc0205858 <etext+0x134>
ffffffffc02002d0:	00005597          	auipc	a1,0x5
ffffffffc02002d4:	5a858593          	addi	a1,a1,1448 # ffffffffc0205878 <etext+0x154>
ffffffffc02002d8:	00005517          	auipc	a0,0x5
ffffffffc02002dc:	5a850513          	addi	a0,a0,1448 # ffffffffc0205880 <etext+0x15c>
{
ffffffffc02002e0:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002e2:	eb3ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc02002e6:	00005617          	auipc	a2,0x5
ffffffffc02002ea:	5aa60613          	addi	a2,a2,1450 # ffffffffc0205890 <etext+0x16c>
ffffffffc02002ee:	00005597          	auipc	a1,0x5
ffffffffc02002f2:	5ca58593          	addi	a1,a1,1482 # ffffffffc02058b8 <etext+0x194>
ffffffffc02002f6:	00005517          	auipc	a0,0x5
ffffffffc02002fa:	58a50513          	addi	a0,a0,1418 # ffffffffc0205880 <etext+0x15c>
ffffffffc02002fe:	e97ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0200302:	00005617          	auipc	a2,0x5
ffffffffc0200306:	5c660613          	addi	a2,a2,1478 # ffffffffc02058c8 <etext+0x1a4>
ffffffffc020030a:	00005597          	auipc	a1,0x5
ffffffffc020030e:	5de58593          	addi	a1,a1,1502 # ffffffffc02058e8 <etext+0x1c4>
ffffffffc0200312:	00005517          	auipc	a0,0x5
ffffffffc0200316:	56e50513          	addi	a0,a0,1390 # ffffffffc0205880 <etext+0x15c>
ffffffffc020031a:	e7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    return 0;
}
ffffffffc020031e:	60a2                	ld	ra,8(sp)
ffffffffc0200320:	4501                	li	a0,0
ffffffffc0200322:	0141                	addi	sp,sp,16
ffffffffc0200324:	8082                	ret

ffffffffc0200326 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int mon_kerninfo(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200326:	1141                	addi	sp,sp,-16
ffffffffc0200328:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020032a:	ef3ff0ef          	jal	ra,ffffffffc020021c <print_kerninfo>
    return 0;
}
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int mon_backtrace(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020033a:	f71ff0ef          	jal	ra,ffffffffc02002aa <print_stackframe>
    return 0;
}
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <kmonitor>:
{
ffffffffc0200346:	7115                	addi	sp,sp,-224
ffffffffc0200348:	ed5e                	sd	s7,152(sp)
ffffffffc020034a:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	5ac50513          	addi	a0,a0,1452 # ffffffffc02058f8 <etext+0x1d4>
{
ffffffffc0200354:	ed86                	sd	ra,216(sp)
ffffffffc0200356:	e9a2                	sd	s0,208(sp)
ffffffffc0200358:	e5a6                	sd	s1,200(sp)
ffffffffc020035a:	e1ca                	sd	s2,192(sp)
ffffffffc020035c:	fd4e                	sd	s3,184(sp)
ffffffffc020035e:	f952                	sd	s4,176(sp)
ffffffffc0200360:	f556                	sd	s5,168(sp)
ffffffffc0200362:	f15a                	sd	s6,160(sp)
ffffffffc0200364:	e962                	sd	s8,144(sp)
ffffffffc0200366:	e566                	sd	s9,136(sp)
ffffffffc0200368:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020036a:	e2bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc020036e:	00005517          	auipc	a0,0x5
ffffffffc0200372:	5b250513          	addi	a0,a0,1458 # ffffffffc0205920 <etext+0x1fc>
ffffffffc0200376:	e1fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    if (tf != NULL)
ffffffffc020037a:	000b8563          	beqz	s7,ffffffffc0200384 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc020037e:	855e                	mv	a0,s7
ffffffffc0200380:	025000ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
ffffffffc0200384:	00005c17          	auipc	s8,0x5
ffffffffc0200388:	60cc0c13          	addi	s8,s8,1548 # ffffffffc0205990 <commands>
        if ((buf = readline("K> ")) != NULL)
ffffffffc020038c:	00005917          	auipc	s2,0x5
ffffffffc0200390:	5bc90913          	addi	s2,s2,1468 # ffffffffc0205948 <etext+0x224>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200394:	00005497          	auipc	s1,0x5
ffffffffc0200398:	5bc48493          	addi	s1,s1,1468 # ffffffffc0205950 <etext+0x22c>
        if (argc == MAXARGS - 1)
ffffffffc020039c:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020039e:	00005b17          	auipc	s6,0x5
ffffffffc02003a2:	5bab0b13          	addi	s6,s6,1466 # ffffffffc0205958 <etext+0x234>
        argv[argc++] = buf;
ffffffffc02003a6:	00005a17          	auipc	s4,0x5
ffffffffc02003aa:	4d2a0a13          	addi	s4,s4,1234 # ffffffffc0205878 <etext+0x154>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003ae:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL)
ffffffffc02003b0:	854a                	mv	a0,s2
ffffffffc02003b2:	cf5ff0ef          	jal	ra,ffffffffc02000a6 <readline>
ffffffffc02003b6:	842a                	mv	s0,a0
ffffffffc02003b8:	dd65                	beqz	a0,ffffffffc02003b0 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003ba:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02003be:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003c0:	e1bd                	bnez	a1,ffffffffc0200426 <kmonitor+0xe0>
    if (argc == 0)
ffffffffc02003c2:	fe0c87e3          	beqz	s9,ffffffffc02003b0 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003c6:	6582                	ld	a1,0(sp)
ffffffffc02003c8:	00005d17          	auipc	s10,0x5
ffffffffc02003cc:	5c8d0d13          	addi	s10,s10,1480 # ffffffffc0205990 <commands>
        argv[argc++] = buf;
ffffffffc02003d0:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003d2:	4401                	li	s0,0
ffffffffc02003d4:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003d6:	2ca050ef          	jal	ra,ffffffffc02056a0 <strcmp>
ffffffffc02003da:	c919                	beqz	a0,ffffffffc02003f0 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003dc:	2405                	addiw	s0,s0,1
ffffffffc02003de:	0b540063          	beq	s0,s5,ffffffffc020047e <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003e2:	000d3503          	ld	a0,0(s10)
ffffffffc02003e6:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003e8:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003ea:	2b6050ef          	jal	ra,ffffffffc02056a0 <strcmp>
ffffffffc02003ee:	f57d                	bnez	a0,ffffffffc02003dc <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc02003f0:	00141793          	slli	a5,s0,0x1
ffffffffc02003f4:	97a2                	add	a5,a5,s0
ffffffffc02003f6:	078e                	slli	a5,a5,0x3
ffffffffc02003f8:	97e2                	add	a5,a5,s8
ffffffffc02003fa:	6b9c                	ld	a5,16(a5)
ffffffffc02003fc:	865e                	mv	a2,s7
ffffffffc02003fe:	002c                	addi	a1,sp,8
ffffffffc0200400:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200404:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0)
ffffffffc0200406:	fa0555e3          	bgez	a0,ffffffffc02003b0 <kmonitor+0x6a>
}
ffffffffc020040a:	60ee                	ld	ra,216(sp)
ffffffffc020040c:	644e                	ld	s0,208(sp)
ffffffffc020040e:	64ae                	ld	s1,200(sp)
ffffffffc0200410:	690e                	ld	s2,192(sp)
ffffffffc0200412:	79ea                	ld	s3,184(sp)
ffffffffc0200414:	7a4a                	ld	s4,176(sp)
ffffffffc0200416:	7aaa                	ld	s5,168(sp)
ffffffffc0200418:	7b0a                	ld	s6,160(sp)
ffffffffc020041a:	6bea                	ld	s7,152(sp)
ffffffffc020041c:	6c4a                	ld	s8,144(sp)
ffffffffc020041e:	6caa                	ld	s9,136(sp)
ffffffffc0200420:	6d0a                	ld	s10,128(sp)
ffffffffc0200422:	612d                	addi	sp,sp,224
ffffffffc0200424:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200426:	8526                	mv	a0,s1
ffffffffc0200428:	2bc050ef          	jal	ra,ffffffffc02056e4 <strchr>
ffffffffc020042c:	c901                	beqz	a0,ffffffffc020043c <kmonitor+0xf6>
ffffffffc020042e:	00144583          	lbu	a1,1(s0)
            *buf++ = '\0';
ffffffffc0200432:	00040023          	sb	zero,0(s0)
ffffffffc0200436:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200438:	d5c9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc020043a:	b7f5                	j	ffffffffc0200426 <kmonitor+0xe0>
        if (*buf == '\0')
ffffffffc020043c:	00044783          	lbu	a5,0(s0)
ffffffffc0200440:	d3c9                	beqz	a5,ffffffffc02003c2 <kmonitor+0x7c>
        if (argc == MAXARGS - 1)
ffffffffc0200442:	033c8963          	beq	s9,s3,ffffffffc0200474 <kmonitor+0x12e>
        argv[argc++] = buf;
ffffffffc0200446:	003c9793          	slli	a5,s9,0x3
ffffffffc020044a:	0118                	addi	a4,sp,128
ffffffffc020044c:	97ba                	add	a5,a5,a4
ffffffffc020044e:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200452:	00044583          	lbu	a1,0(s0)
        argv[argc++] = buf;
ffffffffc0200456:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200458:	e591                	bnez	a1,ffffffffc0200464 <kmonitor+0x11e>
ffffffffc020045a:	b7b5                	j	ffffffffc02003c6 <kmonitor+0x80>
ffffffffc020045c:	00144583          	lbu	a1,1(s0)
            buf++;
ffffffffc0200460:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200462:	d1a5                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200464:	8526                	mv	a0,s1
ffffffffc0200466:	27e050ef          	jal	ra,ffffffffc02056e4 <strchr>
ffffffffc020046a:	d96d                	beqz	a0,ffffffffc020045c <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc020046c:	00044583          	lbu	a1,0(s0)
ffffffffc0200470:	d9a9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200472:	bf55                	j	ffffffffc0200426 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200474:	45c1                	li	a1,16
ffffffffc0200476:	855a                	mv	a0,s6
ffffffffc0200478:	d1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc020047c:	b7e9                	j	ffffffffc0200446 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020047e:	6582                	ld	a1,0(sp)
ffffffffc0200480:	00005517          	auipc	a0,0x5
ffffffffc0200484:	4f850513          	addi	a0,a0,1272 # ffffffffc0205978 <etext+0x254>
ffffffffc0200488:	d0dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
ffffffffc020048c:	b715                	j	ffffffffc02003b0 <kmonitor+0x6a>

ffffffffc020048e <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void __panic(const char *file, int line, const char *fmt, ...)
{
    if (is_panic)
ffffffffc020048e:	000ab317          	auipc	t1,0xab
ffffffffc0200492:	94230313          	addi	t1,t1,-1726 # ffffffffc02aadd0 <is_panic>
ffffffffc0200496:	00033e03          	ld	t3,0(t1)
{
ffffffffc020049a:	715d                	addi	sp,sp,-80
ffffffffc020049c:	ec06                	sd	ra,24(sp)
ffffffffc020049e:	e822                	sd	s0,16(sp)
ffffffffc02004a0:	f436                	sd	a3,40(sp)
ffffffffc02004a2:	f83a                	sd	a4,48(sp)
ffffffffc02004a4:	fc3e                	sd	a5,56(sp)
ffffffffc02004a6:	e0c2                	sd	a6,64(sp)
ffffffffc02004a8:	e4c6                	sd	a7,72(sp)
    if (is_panic)
ffffffffc02004aa:	020e1a63          	bnez	t3,ffffffffc02004de <__panic+0x50>
    {
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02004ae:	4785                	li	a5,1
ffffffffc02004b0:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02004b4:	8432                	mv	s0,a2
ffffffffc02004b6:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004b8:	862e                	mv	a2,a1
ffffffffc02004ba:	85aa                	mv	a1,a0
ffffffffc02004bc:	00005517          	auipc	a0,0x5
ffffffffc02004c0:	51c50513          	addi	a0,a0,1308 # ffffffffc02059d8 <commands+0x48>
    va_start(ap, fmt);
ffffffffc02004c4:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004c6:	ccfff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02004ca:	65a2                	ld	a1,8(sp)
ffffffffc02004cc:	8522                	mv	a0,s0
ffffffffc02004ce:	ca7ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc02004d2:	00006517          	auipc	a0,0x6
ffffffffc02004d6:	60e50513          	addi	a0,a0,1550 # ffffffffc0206ae0 <default_pmm_manager+0x578>
ffffffffc02004da:	cbbff0ef          	jal	ra,ffffffffc0200194 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc02004de:	4501                	li	a0,0
ffffffffc02004e0:	4581                	li	a1,0
ffffffffc02004e2:	4601                	li	a2,0
ffffffffc02004e4:	48a1                	li	a7,8
ffffffffc02004e6:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc02004ea:	4ca000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
    while (1)
    {
        kmonitor(NULL);
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	e57ff0ef          	jal	ra,ffffffffc0200346 <kmonitor>
    while (1)
ffffffffc02004f4:	bfed                	j	ffffffffc02004ee <__panic+0x60>

ffffffffc02004f6 <__warn>:
    }
}

/* __warn - like panic, but don't */
void __warn(const char *file, int line, const char *fmt, ...)
{
ffffffffc02004f6:	715d                	addi	sp,sp,-80
ffffffffc02004f8:	832e                	mv	t1,a1
ffffffffc02004fa:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc02004fc:	85aa                	mv	a1,a0
{
ffffffffc02004fe:	8432                	mv	s0,a2
ffffffffc0200500:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200502:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200504:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200506:	00005517          	auipc	a0,0x5
ffffffffc020050a:	4f250513          	addi	a0,a0,1266 # ffffffffc02059f8 <commands+0x68>
{
ffffffffc020050e:	ec06                	sd	ra,24(sp)
ffffffffc0200510:	f436                	sd	a3,40(sp)
ffffffffc0200512:	f83a                	sd	a4,48(sp)
ffffffffc0200514:	e0c2                	sd	a6,64(sp)
ffffffffc0200516:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0200518:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020051a:	c7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020051e:	65a2                	ld	a1,8(sp)
ffffffffc0200520:	8522                	mv	a0,s0
ffffffffc0200522:	c53ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc0200526:	00006517          	auipc	a0,0x6
ffffffffc020052a:	5ba50513          	addi	a0,a0,1466 # ffffffffc0206ae0 <default_pmm_manager+0x578>
ffffffffc020052e:	c67ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    va_end(ap);
}
ffffffffc0200532:	60e2                	ld	ra,24(sp)
ffffffffc0200534:	6442                	ld	s0,16(sp)
ffffffffc0200536:	6161                	addi	sp,sp,80
ffffffffc0200538:	8082                	ret

ffffffffc020053a <clock_init>:
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
    // divided by 500 when using Spike(2MHz)
    // divided by 100 when using QEMU(10MHz)
    timebase = 1e7 / 100;
ffffffffc020053a:	67e1                	lui	a5,0x18
ffffffffc020053c:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_exit_out_size+0xd508>
ffffffffc0200540:	000ab717          	auipc	a4,0xab
ffffffffc0200544:	8af73023          	sd	a5,-1888(a4) # ffffffffc02aade0 <timebase>
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200548:	c0102573          	rdtime	a0
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc020054c:	4581                	li	a1,0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020054e:	953e                	add	a0,a0,a5
ffffffffc0200550:	4601                	li	a2,0
ffffffffc0200552:	4881                	li	a7,0
ffffffffc0200554:	00000073          	ecall
    set_csr(sie, MIP_STIP);
ffffffffc0200558:	02000793          	li	a5,32
ffffffffc020055c:	1047a7f3          	csrrs	a5,sie,a5
    cprintf("++ setup timer interrupts\n");
ffffffffc0200560:	00005517          	auipc	a0,0x5
ffffffffc0200564:	4b850513          	addi	a0,a0,1208 # ffffffffc0205a18 <commands+0x88>
    ticks = 0;
ffffffffc0200568:	000ab797          	auipc	a5,0xab
ffffffffc020056c:	8607b823          	sd	zero,-1936(a5) # ffffffffc02aadd8 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200570:	b115                	j	ffffffffc0200194 <cprintf>

ffffffffc0200572 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200572:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200576:	000ab797          	auipc	a5,0xab
ffffffffc020057a:	86a7b783          	ld	a5,-1942(a5) # ffffffffc02aade0 <timebase>
ffffffffc020057e:	953e                	add	a0,a0,a5
ffffffffc0200580:	4581                	li	a1,0
ffffffffc0200582:	4601                	li	a2,0
ffffffffc0200584:	4881                	li	a7,0
ffffffffc0200586:	00000073          	ecall
ffffffffc020058a:	8082                	ret

ffffffffc020058c <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc020058c:	8082                	ret

ffffffffc020058e <cons_putc>:
#include <riscv.h>
#include <assert.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020058e:	100027f3          	csrr	a5,sstatus
ffffffffc0200592:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc0200594:	0ff57513          	zext.b	a0,a0
ffffffffc0200598:	e799                	bnez	a5,ffffffffc02005a6 <cons_putc+0x18>
ffffffffc020059a:	4581                	li	a1,0
ffffffffc020059c:	4601                	li	a2,0
ffffffffc020059e:	4885                	li	a7,1
ffffffffc02005a0:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc02005a4:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a6:	1101                	addi	sp,sp,-32
ffffffffc02005a8:	ec06                	sd	ra,24(sp)
ffffffffc02005aa:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005ac:	408000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005b0:	6522                	ld	a0,8(sp)
ffffffffc02005b2:	4581                	li	a1,0
ffffffffc02005b4:	4601                	li	a2,0
ffffffffc02005b6:	4885                	li	a7,1
ffffffffc02005b8:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005bc:	60e2                	ld	ra,24(sp)
ffffffffc02005be:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc02005c0:	a6fd                	j	ffffffffc02009ae <intr_enable>

ffffffffc02005c2 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02005c2:	100027f3          	csrr	a5,sstatus
ffffffffc02005c6:	8b89                	andi	a5,a5,2
ffffffffc02005c8:	eb89                	bnez	a5,ffffffffc02005da <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005ca:	4501                	li	a0,0
ffffffffc02005cc:	4581                	li	a1,0
ffffffffc02005ce:	4601                	li	a2,0
ffffffffc02005d0:	4889                	li	a7,2
ffffffffc02005d2:	00000073          	ecall
ffffffffc02005d6:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d8:	8082                	ret
int cons_getc(void) {
ffffffffc02005da:	1101                	addi	sp,sp,-32
ffffffffc02005dc:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005de:	3d6000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005e2:	4501                	li	a0,0
ffffffffc02005e4:	4581                	li	a1,0
ffffffffc02005e6:	4601                	li	a2,0
ffffffffc02005e8:	4889                	li	a7,2
ffffffffc02005ea:	00000073          	ecall
ffffffffc02005ee:	2501                	sext.w	a0,a0
ffffffffc02005f0:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005f2:	3bc000ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc02005f6:	60e2                	ld	ra,24(sp)
ffffffffc02005f8:	6522                	ld	a0,8(sp)
ffffffffc02005fa:	6105                	addi	sp,sp,32
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02005fe:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200600:	00005517          	auipc	a0,0x5
ffffffffc0200604:	43850513          	addi	a0,a0,1080 # ffffffffc0205a38 <commands+0xa8>
void dtb_init(void) {
ffffffffc0200608:	fc86                	sd	ra,120(sp)
ffffffffc020060a:	f8a2                	sd	s0,112(sp)
ffffffffc020060c:	e8d2                	sd	s4,80(sp)
ffffffffc020060e:	f4a6                	sd	s1,104(sp)
ffffffffc0200610:	f0ca                	sd	s2,96(sp)
ffffffffc0200612:	ecce                	sd	s3,88(sp)
ffffffffc0200614:	e4d6                	sd	s5,72(sp)
ffffffffc0200616:	e0da                	sd	s6,64(sp)
ffffffffc0200618:	fc5e                	sd	s7,56(sp)
ffffffffc020061a:	f862                	sd	s8,48(sp)
ffffffffc020061c:	f466                	sd	s9,40(sp)
ffffffffc020061e:	f06a                	sd	s10,32(sp)
ffffffffc0200620:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc0200622:	b73ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200626:	0000b597          	auipc	a1,0xb
ffffffffc020062a:	9da5b583          	ld	a1,-1574(a1) # ffffffffc020b000 <boot_hartid>
ffffffffc020062e:	00005517          	auipc	a0,0x5
ffffffffc0200632:	41a50513          	addi	a0,a0,1050 # ffffffffc0205a48 <commands+0xb8>
ffffffffc0200636:	b5fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020063a:	0000b417          	auipc	s0,0xb
ffffffffc020063e:	9ce40413          	addi	s0,s0,-1586 # ffffffffc020b008 <boot_dtb>
ffffffffc0200642:	600c                	ld	a1,0(s0)
ffffffffc0200644:	00005517          	auipc	a0,0x5
ffffffffc0200648:	41450513          	addi	a0,a0,1044 # ffffffffc0205a58 <commands+0xc8>
ffffffffc020064c:	b49ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200650:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200654:	00005517          	auipc	a0,0x5
ffffffffc0200658:	41c50513          	addi	a0,a0,1052 # ffffffffc0205a70 <commands+0xe0>
    if (boot_dtb == 0) {
ffffffffc020065c:	120a0463          	beqz	s4,ffffffffc0200784 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc0200660:	57f5                	li	a5,-3
ffffffffc0200662:	07fa                	slli	a5,a5,0x1e
ffffffffc0200664:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200668:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020066e:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200670:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200674:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200678:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067c:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200680:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200684:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200686:	8ec9                	or	a3,a3,a0
ffffffffc0200688:	0087979b          	slliw	a5,a5,0x8
ffffffffc020068c:	1b7d                	addi	s6,s6,-1
ffffffffc020068e:	0167f7b3          	and	a5,a5,s6
ffffffffc0200692:	8dd5                	or	a1,a1,a3
ffffffffc0200694:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200696:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020069a:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc020069c:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe35099>
ffffffffc02006a0:	10f59163          	bne	a1,a5,ffffffffc02007a2 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02006a4:	471c                	lw	a5,8(a4)
ffffffffc02006a6:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02006a8:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006aa:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02006ae:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02006b2:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b6:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ba:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006be:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c2:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c6:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ca:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ce:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006d2:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006d4:	01146433          	or	s0,s0,a7
ffffffffc02006d8:	0086969b          	slliw	a3,a3,0x8
ffffffffc02006dc:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006e0:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006e2:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e6:	8c49                	or	s0,s0,a0
ffffffffc02006e8:	0166f6b3          	and	a3,a3,s6
ffffffffc02006ec:	00ca6a33          	or	s4,s4,a2
ffffffffc02006f0:	0167f7b3          	and	a5,a5,s6
ffffffffc02006f4:	8c55                	or	s0,s0,a3
ffffffffc02006f6:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fa:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006fc:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fe:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200700:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200704:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200706:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200708:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020070c:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020070e:	00005917          	auipc	s2,0x5
ffffffffc0200712:	3b290913          	addi	s2,s2,946 # ffffffffc0205ac0 <commands+0x130>
ffffffffc0200716:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200718:	4d91                	li	s11,4
ffffffffc020071a:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020071c:	00005497          	auipc	s1,0x5
ffffffffc0200720:	39c48493          	addi	s1,s1,924 # ffffffffc0205ab8 <commands+0x128>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200724:	000a2703          	lw	a4,0(s4)
ffffffffc0200728:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020072c:	0087569b          	srliw	a3,a4,0x8
ffffffffc0200730:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200734:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200738:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020073c:	0107571b          	srliw	a4,a4,0x10
ffffffffc0200740:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200742:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200746:	0087171b          	slliw	a4,a4,0x8
ffffffffc020074a:	8fd5                	or	a5,a5,a3
ffffffffc020074c:	00eb7733          	and	a4,s6,a4
ffffffffc0200750:	8fd9                	or	a5,a5,a4
ffffffffc0200752:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200754:	09778c63          	beq	a5,s7,ffffffffc02007ec <dtb_init+0x1ee>
ffffffffc0200758:	00fbea63          	bltu	s7,a5,ffffffffc020076c <dtb_init+0x16e>
ffffffffc020075c:	07a78663          	beq	a5,s10,ffffffffc02007c8 <dtb_init+0x1ca>
ffffffffc0200760:	4709                	li	a4,2
ffffffffc0200762:	00e79763          	bne	a5,a4,ffffffffc0200770 <dtb_init+0x172>
ffffffffc0200766:	4c81                	li	s9,0
ffffffffc0200768:	8a56                	mv	s4,s5
ffffffffc020076a:	bf6d                	j	ffffffffc0200724 <dtb_init+0x126>
ffffffffc020076c:	ffb78ee3          	beq	a5,s11,ffffffffc0200768 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc0200770:	00005517          	auipc	a0,0x5
ffffffffc0200774:	3c850513          	addi	a0,a0,968 # ffffffffc0205b38 <commands+0x1a8>
ffffffffc0200778:	a1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020077c:	00005517          	auipc	a0,0x5
ffffffffc0200780:	3f450513          	addi	a0,a0,1012 # ffffffffc0205b70 <commands+0x1e0>
}
ffffffffc0200784:	7446                	ld	s0,112(sp)
ffffffffc0200786:	70e6                	ld	ra,120(sp)
ffffffffc0200788:	74a6                	ld	s1,104(sp)
ffffffffc020078a:	7906                	ld	s2,96(sp)
ffffffffc020078c:	69e6                	ld	s3,88(sp)
ffffffffc020078e:	6a46                	ld	s4,80(sp)
ffffffffc0200790:	6aa6                	ld	s5,72(sp)
ffffffffc0200792:	6b06                	ld	s6,64(sp)
ffffffffc0200794:	7be2                	ld	s7,56(sp)
ffffffffc0200796:	7c42                	ld	s8,48(sp)
ffffffffc0200798:	7ca2                	ld	s9,40(sp)
ffffffffc020079a:	7d02                	ld	s10,32(sp)
ffffffffc020079c:	6de2                	ld	s11,24(sp)
ffffffffc020079e:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02007a0:	bad5                	j	ffffffffc0200194 <cprintf>
}
ffffffffc02007a2:	7446                	ld	s0,112(sp)
ffffffffc02007a4:	70e6                	ld	ra,120(sp)
ffffffffc02007a6:	74a6                	ld	s1,104(sp)
ffffffffc02007a8:	7906                	ld	s2,96(sp)
ffffffffc02007aa:	69e6                	ld	s3,88(sp)
ffffffffc02007ac:	6a46                	ld	s4,80(sp)
ffffffffc02007ae:	6aa6                	ld	s5,72(sp)
ffffffffc02007b0:	6b06                	ld	s6,64(sp)
ffffffffc02007b2:	7be2                	ld	s7,56(sp)
ffffffffc02007b4:	7c42                	ld	s8,48(sp)
ffffffffc02007b6:	7ca2                	ld	s9,40(sp)
ffffffffc02007b8:	7d02                	ld	s10,32(sp)
ffffffffc02007ba:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007bc:	00005517          	auipc	a0,0x5
ffffffffc02007c0:	2d450513          	addi	a0,a0,724 # ffffffffc0205a90 <commands+0x100>
}
ffffffffc02007c4:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007c6:	b2f9                	j	ffffffffc0200194 <cprintf>
                int name_len = strlen(name);
ffffffffc02007c8:	8556                	mv	a0,s5
ffffffffc02007ca:	68f040ef          	jal	ra,ffffffffc0205658 <strlen>
ffffffffc02007ce:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d0:	4619                	li	a2,6
ffffffffc02007d2:	85a6                	mv	a1,s1
ffffffffc02007d4:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02007d6:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d8:	6e7040ef          	jal	ra,ffffffffc02056be <strncmp>
ffffffffc02007dc:	e111                	bnez	a0,ffffffffc02007e0 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc02007de:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc02007e0:	0a91                	addi	s5,s5,4
ffffffffc02007e2:	9ad2                	add	s5,s5,s4
ffffffffc02007e4:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02007e8:	8a56                	mv	s4,s5
ffffffffc02007ea:	bf2d                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007ec:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007f0:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007f4:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02007f8:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007fc:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200800:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200804:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200808:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020080c:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200810:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200814:	00eaeab3          	or	s5,s5,a4
ffffffffc0200818:	00fb77b3          	and	a5,s6,a5
ffffffffc020081c:	00faeab3          	or	s5,s5,a5
ffffffffc0200820:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200822:	000c9c63          	bnez	s9,ffffffffc020083a <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200826:	1a82                	slli	s5,s5,0x20
ffffffffc0200828:	00368793          	addi	a5,a3,3
ffffffffc020082c:	020ada93          	srli	s5,s5,0x20
ffffffffc0200830:	9abe                	add	s5,s5,a5
ffffffffc0200832:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200836:	8a56                	mv	s4,s5
ffffffffc0200838:	b5f5                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020083a:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020083e:	85ca                	mv	a1,s2
ffffffffc0200840:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200842:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200846:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020084a:	0187971b          	slliw	a4,a5,0x18
ffffffffc020084e:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200852:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200856:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200858:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020085c:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200860:	8d59                	or	a0,a0,a4
ffffffffc0200862:	00fb77b3          	and	a5,s6,a5
ffffffffc0200866:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200868:	1502                	slli	a0,a0,0x20
ffffffffc020086a:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020086c:	9522                	add	a0,a0,s0
ffffffffc020086e:	633040ef          	jal	ra,ffffffffc02056a0 <strcmp>
ffffffffc0200872:	66a2                	ld	a3,8(sp)
ffffffffc0200874:	f94d                	bnez	a0,ffffffffc0200826 <dtb_init+0x228>
ffffffffc0200876:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200826 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020087a:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc020087e:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200882:	00005517          	auipc	a0,0x5
ffffffffc0200886:	24650513          	addi	a0,a0,582 # ffffffffc0205ac8 <commands+0x138>
           fdt32_to_cpu(x >> 32);
ffffffffc020088a:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020088e:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc0200892:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200896:	0187de1b          	srliw	t3,a5,0x18
ffffffffc020089a:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020089e:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008a2:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008a6:	0187d693          	srli	a3,a5,0x18
ffffffffc02008aa:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02008ae:	0087579b          	srliw	a5,a4,0x8
ffffffffc02008b2:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008b6:	0106561b          	srliw	a2,a2,0x10
ffffffffc02008ba:	010f6f33          	or	t5,t5,a6
ffffffffc02008be:	0187529b          	srliw	t0,a4,0x18
ffffffffc02008c2:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c6:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008ca:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008ce:	0186f6b3          	and	a3,a3,s8
ffffffffc02008d2:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02008d6:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008da:	0107581b          	srliw	a6,a4,0x10
ffffffffc02008de:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008e2:	8361                	srli	a4,a4,0x18
ffffffffc02008e4:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008e8:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02008ec:	01e6e6b3          	or	a3,a3,t5
ffffffffc02008f0:	00cb7633          	and	a2,s6,a2
ffffffffc02008f4:	0088181b          	slliw	a6,a6,0x8
ffffffffc02008f8:	0085959b          	slliw	a1,a1,0x8
ffffffffc02008fc:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200900:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200904:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200908:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020090c:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200910:	011b78b3          	and	a7,s6,a7
ffffffffc0200914:	005eeeb3          	or	t4,t4,t0
ffffffffc0200918:	00c6e733          	or	a4,a3,a2
ffffffffc020091c:	006c6c33          	or	s8,s8,t1
ffffffffc0200920:	010b76b3          	and	a3,s6,a6
ffffffffc0200924:	00bb7b33          	and	s6,s6,a1
ffffffffc0200928:	01d7e7b3          	or	a5,a5,t4
ffffffffc020092c:	016c6b33          	or	s6,s8,s6
ffffffffc0200930:	01146433          	or	s0,s0,a7
ffffffffc0200934:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200936:	1702                	slli	a4,a4,0x20
ffffffffc0200938:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093a:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020093c:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093e:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200940:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200944:	0167eb33          	or	s6,a5,s6
ffffffffc0200948:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc020094a:	84bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc020094e:	85a2                	mv	a1,s0
ffffffffc0200950:	00005517          	auipc	a0,0x5
ffffffffc0200954:	19850513          	addi	a0,a0,408 # ffffffffc0205ae8 <commands+0x158>
ffffffffc0200958:	83dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020095c:	014b5613          	srli	a2,s6,0x14
ffffffffc0200960:	85da                	mv	a1,s6
ffffffffc0200962:	00005517          	auipc	a0,0x5
ffffffffc0200966:	19e50513          	addi	a0,a0,414 # ffffffffc0205b00 <commands+0x170>
ffffffffc020096a:	82bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc020096e:	008b05b3          	add	a1,s6,s0
ffffffffc0200972:	15fd                	addi	a1,a1,-1
ffffffffc0200974:	00005517          	auipc	a0,0x5
ffffffffc0200978:	1ac50513          	addi	a0,a0,428 # ffffffffc0205b20 <commands+0x190>
ffffffffc020097c:	819ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc0200980:	00005517          	auipc	a0,0x5
ffffffffc0200984:	1f050513          	addi	a0,a0,496 # ffffffffc0205b70 <commands+0x1e0>
        memory_base = mem_base;
ffffffffc0200988:	000aa797          	auipc	a5,0xaa
ffffffffc020098c:	4687b023          	sd	s0,1120(a5) # ffffffffc02aade8 <memory_base>
        memory_size = mem_size;
ffffffffc0200990:	000aa797          	auipc	a5,0xaa
ffffffffc0200994:	4767b023          	sd	s6,1120(a5) # ffffffffc02aadf0 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200998:	b3f5                	j	ffffffffc0200784 <dtb_init+0x186>

ffffffffc020099a <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc020099a:	000aa517          	auipc	a0,0xaa
ffffffffc020099e:	44e53503          	ld	a0,1102(a0) # ffffffffc02aade8 <memory_base>
ffffffffc02009a2:	8082                	ret

ffffffffc02009a4 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc02009a4:	000aa517          	auipc	a0,0xaa
ffffffffc02009a8:	44c53503          	ld	a0,1100(a0) # ffffffffc02aadf0 <memory_size>
ffffffffc02009ac:	8082                	ret

ffffffffc02009ae <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ae:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009b4:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009b8:	8082                	ret

ffffffffc02009ba <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009ba:	8082                	ret

ffffffffc02009bc <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009bc:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009c0:	00000797          	auipc	a5,0x0
ffffffffc02009c4:	4b878793          	addi	a5,a5,1208 # ffffffffc0200e78 <__alltraps>
ffffffffc02009c8:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009cc:	000407b7          	lui	a5,0x40
ffffffffc02009d0:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009d4:	8082                	ret

ffffffffc02009d6 <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d6:	610c                	ld	a1,0(a0)
{
ffffffffc02009d8:	1141                	addi	sp,sp,-16
ffffffffc02009da:	e022                	sd	s0,0(sp)
ffffffffc02009dc:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009de:	00005517          	auipc	a0,0x5
ffffffffc02009e2:	1aa50513          	addi	a0,a0,426 # ffffffffc0205b88 <commands+0x1f8>
{
ffffffffc02009e6:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e8:	facff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009ec:	640c                	ld	a1,8(s0)
ffffffffc02009ee:	00005517          	auipc	a0,0x5
ffffffffc02009f2:	1b250513          	addi	a0,a0,434 # ffffffffc0205ba0 <commands+0x210>
ffffffffc02009f6:	f9eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009fa:	680c                	ld	a1,16(s0)
ffffffffc02009fc:	00005517          	auipc	a0,0x5
ffffffffc0200a00:	1bc50513          	addi	a0,a0,444 # ffffffffc0205bb8 <commands+0x228>
ffffffffc0200a04:	f90ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a08:	6c0c                	ld	a1,24(s0)
ffffffffc0200a0a:	00005517          	auipc	a0,0x5
ffffffffc0200a0e:	1c650513          	addi	a0,a0,454 # ffffffffc0205bd0 <commands+0x240>
ffffffffc0200a12:	f82ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a16:	700c                	ld	a1,32(s0)
ffffffffc0200a18:	00005517          	auipc	a0,0x5
ffffffffc0200a1c:	1d050513          	addi	a0,a0,464 # ffffffffc0205be8 <commands+0x258>
ffffffffc0200a20:	f74ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a24:	740c                	ld	a1,40(s0)
ffffffffc0200a26:	00005517          	auipc	a0,0x5
ffffffffc0200a2a:	1da50513          	addi	a0,a0,474 # ffffffffc0205c00 <commands+0x270>
ffffffffc0200a2e:	f66ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a32:	780c                	ld	a1,48(s0)
ffffffffc0200a34:	00005517          	auipc	a0,0x5
ffffffffc0200a38:	1e450513          	addi	a0,a0,484 # ffffffffc0205c18 <commands+0x288>
ffffffffc0200a3c:	f58ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a40:	7c0c                	ld	a1,56(s0)
ffffffffc0200a42:	00005517          	auipc	a0,0x5
ffffffffc0200a46:	1ee50513          	addi	a0,a0,494 # ffffffffc0205c30 <commands+0x2a0>
ffffffffc0200a4a:	f4aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a4e:	602c                	ld	a1,64(s0)
ffffffffc0200a50:	00005517          	auipc	a0,0x5
ffffffffc0200a54:	1f850513          	addi	a0,a0,504 # ffffffffc0205c48 <commands+0x2b8>
ffffffffc0200a58:	f3cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a5c:	642c                	ld	a1,72(s0)
ffffffffc0200a5e:	00005517          	auipc	a0,0x5
ffffffffc0200a62:	20250513          	addi	a0,a0,514 # ffffffffc0205c60 <commands+0x2d0>
ffffffffc0200a66:	f2eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a6a:	682c                	ld	a1,80(s0)
ffffffffc0200a6c:	00005517          	auipc	a0,0x5
ffffffffc0200a70:	20c50513          	addi	a0,a0,524 # ffffffffc0205c78 <commands+0x2e8>
ffffffffc0200a74:	f20ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a78:	6c2c                	ld	a1,88(s0)
ffffffffc0200a7a:	00005517          	auipc	a0,0x5
ffffffffc0200a7e:	21650513          	addi	a0,a0,534 # ffffffffc0205c90 <commands+0x300>
ffffffffc0200a82:	f12ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a86:	702c                	ld	a1,96(s0)
ffffffffc0200a88:	00005517          	auipc	a0,0x5
ffffffffc0200a8c:	22050513          	addi	a0,a0,544 # ffffffffc0205ca8 <commands+0x318>
ffffffffc0200a90:	f04ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a94:	742c                	ld	a1,104(s0)
ffffffffc0200a96:	00005517          	auipc	a0,0x5
ffffffffc0200a9a:	22a50513          	addi	a0,a0,554 # ffffffffc0205cc0 <commands+0x330>
ffffffffc0200a9e:	ef6ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200aa2:	782c                	ld	a1,112(s0)
ffffffffc0200aa4:	00005517          	auipc	a0,0x5
ffffffffc0200aa8:	23450513          	addi	a0,a0,564 # ffffffffc0205cd8 <commands+0x348>
ffffffffc0200aac:	ee8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200ab0:	7c2c                	ld	a1,120(s0)
ffffffffc0200ab2:	00005517          	auipc	a0,0x5
ffffffffc0200ab6:	23e50513          	addi	a0,a0,574 # ffffffffc0205cf0 <commands+0x360>
ffffffffc0200aba:	edaff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200abe:	604c                	ld	a1,128(s0)
ffffffffc0200ac0:	00005517          	auipc	a0,0x5
ffffffffc0200ac4:	24850513          	addi	a0,a0,584 # ffffffffc0205d08 <commands+0x378>
ffffffffc0200ac8:	eccff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200acc:	644c                	ld	a1,136(s0)
ffffffffc0200ace:	00005517          	auipc	a0,0x5
ffffffffc0200ad2:	25250513          	addi	a0,a0,594 # ffffffffc0205d20 <commands+0x390>
ffffffffc0200ad6:	ebeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ada:	684c                	ld	a1,144(s0)
ffffffffc0200adc:	00005517          	auipc	a0,0x5
ffffffffc0200ae0:	25c50513          	addi	a0,a0,604 # ffffffffc0205d38 <commands+0x3a8>
ffffffffc0200ae4:	eb0ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200ae8:	6c4c                	ld	a1,152(s0)
ffffffffc0200aea:	00005517          	auipc	a0,0x5
ffffffffc0200aee:	26650513          	addi	a0,a0,614 # ffffffffc0205d50 <commands+0x3c0>
ffffffffc0200af2:	ea2ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200af6:	704c                	ld	a1,160(s0)
ffffffffc0200af8:	00005517          	auipc	a0,0x5
ffffffffc0200afc:	27050513          	addi	a0,a0,624 # ffffffffc0205d68 <commands+0x3d8>
ffffffffc0200b00:	e94ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200b04:	744c                	ld	a1,168(s0)
ffffffffc0200b06:	00005517          	auipc	a0,0x5
ffffffffc0200b0a:	27a50513          	addi	a0,a0,634 # ffffffffc0205d80 <commands+0x3f0>
ffffffffc0200b0e:	e86ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b12:	784c                	ld	a1,176(s0)
ffffffffc0200b14:	00005517          	auipc	a0,0x5
ffffffffc0200b18:	28450513          	addi	a0,a0,644 # ffffffffc0205d98 <commands+0x408>
ffffffffc0200b1c:	e78ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b20:	7c4c                	ld	a1,184(s0)
ffffffffc0200b22:	00005517          	auipc	a0,0x5
ffffffffc0200b26:	28e50513          	addi	a0,a0,654 # ffffffffc0205db0 <commands+0x420>
ffffffffc0200b2a:	e6aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b2e:	606c                	ld	a1,192(s0)
ffffffffc0200b30:	00005517          	auipc	a0,0x5
ffffffffc0200b34:	29850513          	addi	a0,a0,664 # ffffffffc0205dc8 <commands+0x438>
ffffffffc0200b38:	e5cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b3c:	646c                	ld	a1,200(s0)
ffffffffc0200b3e:	00005517          	auipc	a0,0x5
ffffffffc0200b42:	2a250513          	addi	a0,a0,674 # ffffffffc0205de0 <commands+0x450>
ffffffffc0200b46:	e4eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b4a:	686c                	ld	a1,208(s0)
ffffffffc0200b4c:	00005517          	auipc	a0,0x5
ffffffffc0200b50:	2ac50513          	addi	a0,a0,684 # ffffffffc0205df8 <commands+0x468>
ffffffffc0200b54:	e40ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b58:	6c6c                	ld	a1,216(s0)
ffffffffc0200b5a:	00005517          	auipc	a0,0x5
ffffffffc0200b5e:	2b650513          	addi	a0,a0,694 # ffffffffc0205e10 <commands+0x480>
ffffffffc0200b62:	e32ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b66:	706c                	ld	a1,224(s0)
ffffffffc0200b68:	00005517          	auipc	a0,0x5
ffffffffc0200b6c:	2c050513          	addi	a0,a0,704 # ffffffffc0205e28 <commands+0x498>
ffffffffc0200b70:	e24ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b74:	746c                	ld	a1,232(s0)
ffffffffc0200b76:	00005517          	auipc	a0,0x5
ffffffffc0200b7a:	2ca50513          	addi	a0,a0,714 # ffffffffc0205e40 <commands+0x4b0>
ffffffffc0200b7e:	e16ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b82:	786c                	ld	a1,240(s0)
ffffffffc0200b84:	00005517          	auipc	a0,0x5
ffffffffc0200b88:	2d450513          	addi	a0,a0,724 # ffffffffc0205e58 <commands+0x4c8>
ffffffffc0200b8c:	e08ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b90:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b92:	6402                	ld	s0,0(sp)
ffffffffc0200b94:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b96:	00005517          	auipc	a0,0x5
ffffffffc0200b9a:	2da50513          	addi	a0,a0,730 # ffffffffc0205e70 <commands+0x4e0>
}
ffffffffc0200b9e:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200ba0:	df4ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200ba4 <print_trapframe>:
{
ffffffffc0200ba4:	1141                	addi	sp,sp,-16
ffffffffc0200ba6:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba8:	85aa                	mv	a1,a0
{
ffffffffc0200baa:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bac:	00005517          	auipc	a0,0x5
ffffffffc0200bb0:	2dc50513          	addi	a0,a0,732 # ffffffffc0205e88 <commands+0x4f8>
{
ffffffffc0200bb4:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb6:	ddeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bba:	8522                	mv	a0,s0
ffffffffc0200bbc:	e1bff0ef          	jal	ra,ffffffffc02009d6 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bc0:	10043583          	ld	a1,256(s0)
ffffffffc0200bc4:	00005517          	auipc	a0,0x5
ffffffffc0200bc8:	2dc50513          	addi	a0,a0,732 # ffffffffc0205ea0 <commands+0x510>
ffffffffc0200bcc:	dc8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bd0:	10843583          	ld	a1,264(s0)
ffffffffc0200bd4:	00005517          	auipc	a0,0x5
ffffffffc0200bd8:	2e450513          	addi	a0,a0,740 # ffffffffc0205eb8 <commands+0x528>
ffffffffc0200bdc:	db8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200be0:	11043583          	ld	a1,272(s0)
ffffffffc0200be4:	00005517          	auipc	a0,0x5
ffffffffc0200be8:	2ec50513          	addi	a0,a0,748 # ffffffffc0205ed0 <commands+0x540>
ffffffffc0200bec:	da8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf0:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bf4:	6402                	ld	s0,0(sp)
ffffffffc0200bf6:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf8:	00005517          	auipc	a0,0x5
ffffffffc0200bfc:	2e850513          	addi	a0,a0,744 # ffffffffc0205ee0 <commands+0x550>
}
ffffffffc0200c00:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200c02:	d92ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200c06 <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c06:	11853783          	ld	a5,280(a0)
ffffffffc0200c0a:	472d                	li	a4,11
ffffffffc0200c0c:	0786                	slli	a5,a5,0x1
ffffffffc0200c0e:	8385                	srli	a5,a5,0x1
ffffffffc0200c10:	08f76463          	bltu	a4,a5,ffffffffc0200c98 <interrupt_handler+0x92>
ffffffffc0200c14:	00005717          	auipc	a4,0x5
ffffffffc0200c18:	39470713          	addi	a4,a4,916 # ffffffffc0205fa8 <commands+0x618>
ffffffffc0200c1c:	078a                	slli	a5,a5,0x2
ffffffffc0200c1e:	97ba                	add	a5,a5,a4
ffffffffc0200c20:	439c                	lw	a5,0(a5)
ffffffffc0200c22:	97ba                	add	a5,a5,a4
ffffffffc0200c24:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c26:	00005517          	auipc	a0,0x5
ffffffffc0200c2a:	33250513          	addi	a0,a0,818 # ffffffffc0205f58 <commands+0x5c8>
ffffffffc0200c2e:	d66ff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c32:	00005517          	auipc	a0,0x5
ffffffffc0200c36:	30650513          	addi	a0,a0,774 # ffffffffc0205f38 <commands+0x5a8>
ffffffffc0200c3a:	d5aff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c3e:	00005517          	auipc	a0,0x5
ffffffffc0200c42:	2ba50513          	addi	a0,a0,698 # ffffffffc0205ef8 <commands+0x568>
ffffffffc0200c46:	d4eff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c4a:	00005517          	auipc	a0,0x5
ffffffffc0200c4e:	2ce50513          	addi	a0,a0,718 # ffffffffc0205f18 <commands+0x588>
ffffffffc0200c52:	d42ff06f          	j	ffffffffc0200194 <cprintf>
{
ffffffffc0200c56:	1141                	addi	sp,sp,-16
ffffffffc0200c58:	e406                	sd	ra,8(sp)
        cprintf("User software interrupt\n");
        break;
    case IRQ_S_TIMER:
    {
        static int num = 0;
        clock_set_next_event();
ffffffffc0200c5a:	919ff0ef          	jal	ra,ffffffffc0200572 <clock_set_next_event>
        ticks++;
ffffffffc0200c5e:	000aa797          	auipc	a5,0xaa
ffffffffc0200c62:	17a78793          	addi	a5,a5,378 # ffffffffc02aadd8 <ticks>
ffffffffc0200c66:	6398                	ld	a4,0(a5)
ffffffffc0200c68:	0705                	addi	a4,a4,1
ffffffffc0200c6a:	e398                	sd	a4,0(a5)
        if (ticks % TICK_NUM == 0)
ffffffffc0200c6c:	639c                	ld	a5,0(a5)
ffffffffc0200c6e:	06400713          	li	a4,100
ffffffffc0200c72:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200c76:	c395                	beqz	a5,ffffffffc0200c9a <interrupt_handler+0x94>
            if (++num == 10)
            {
                sbi_shutdown();
            }
        }
        if (current != NULL)
ffffffffc0200c78:	000aa797          	auipc	a5,0xaa
ffffffffc0200c7c:	1c07b783          	ld	a5,448(a5) # ffffffffc02aae38 <current>
ffffffffc0200c80:	c399                	beqz	a5,ffffffffc0200c86 <interrupt_handler+0x80>
        {
            current->need_resched = 1;
ffffffffc0200c82:	4705                	li	a4,1
ffffffffc0200c84:	ef98                	sd	a4,24(a5)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c86:	60a2                	ld	ra,8(sp)
ffffffffc0200c88:	0141                	addi	sp,sp,16
ffffffffc0200c8a:	8082                	ret
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c8c:	00005517          	auipc	a0,0x5
ffffffffc0200c90:	2fc50513          	addi	a0,a0,764 # ffffffffc0205f88 <commands+0x5f8>
ffffffffc0200c94:	d00ff06f          	j	ffffffffc0200194 <cprintf>
        print_trapframe(tf);
ffffffffc0200c98:	b731                	j	ffffffffc0200ba4 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200c9a:	06400593          	li	a1,100
ffffffffc0200c9e:	00005517          	auipc	a0,0x5
ffffffffc0200ca2:	2da50513          	addi	a0,a0,730 # ffffffffc0205f78 <commands+0x5e8>
ffffffffc0200ca6:	ceeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
            if (++num == 10)
ffffffffc0200caa:	000aa717          	auipc	a4,0xaa
ffffffffc0200cae:	14e70713          	addi	a4,a4,334 # ffffffffc02aadf8 <num.0>
ffffffffc0200cb2:	431c                	lw	a5,0(a4)
ffffffffc0200cb4:	46a9                	li	a3,10
ffffffffc0200cb6:	0017861b          	addiw	a2,a5,1
ffffffffc0200cba:	c310                	sw	a2,0(a4)
ffffffffc0200cbc:	fad61ee3          	bne	a2,a3,ffffffffc0200c78 <interrupt_handler+0x72>
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200cc0:	4501                	li	a0,0
ffffffffc0200cc2:	4581                	li	a1,0
ffffffffc0200cc4:	4601                	li	a2,0
ffffffffc0200cc6:	48a1                	li	a7,8
ffffffffc0200cc8:	00000073          	ecall
}
ffffffffc0200ccc:	b775                	j	ffffffffc0200c78 <interrupt_handler+0x72>

ffffffffc0200cce <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200cce:	11853783          	ld	a5,280(a0)
{
ffffffffc0200cd2:	1141                	addi	sp,sp,-16
ffffffffc0200cd4:	e022                	sd	s0,0(sp)
ffffffffc0200cd6:	e406                	sd	ra,8(sp)
ffffffffc0200cd8:	473d                	li	a4,15
ffffffffc0200cda:	842a                	mv	s0,a0
ffffffffc0200cdc:	0cf76463          	bltu	a4,a5,ffffffffc0200da4 <exception_handler+0xd6>
ffffffffc0200ce0:	00005717          	auipc	a4,0x5
ffffffffc0200ce4:	48870713          	addi	a4,a4,1160 # ffffffffc0206168 <commands+0x7d8>
ffffffffc0200ce8:	078a                	slli	a5,a5,0x2
ffffffffc0200cea:	97ba                	add	a5,a5,a4
ffffffffc0200cec:	439c                	lw	a5,0(a5)
ffffffffc0200cee:	97ba                	add	a5,a5,a4
ffffffffc0200cf0:	8782                	jr	a5
        // cprintf("Environment call from U-mode\n");
        tf->epc += 4;
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200cf2:	00005517          	auipc	a0,0x5
ffffffffc0200cf6:	3ce50513          	addi	a0,a0,974 # ffffffffc02060c0 <commands+0x730>
ffffffffc0200cfa:	c9aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        tf->epc += 4;
ffffffffc0200cfe:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200d02:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200d04:	0791                	addi	a5,a5,4
ffffffffc0200d06:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200d0a:	6402                	ld	s0,0(sp)
ffffffffc0200d0c:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200d0e:	4c60406f          	j	ffffffffc02051d4 <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200d12:	00005517          	auipc	a0,0x5
ffffffffc0200d16:	3ce50513          	addi	a0,a0,974 # ffffffffc02060e0 <commands+0x750>
}
ffffffffc0200d1a:	6402                	ld	s0,0(sp)
ffffffffc0200d1c:	60a2                	ld	ra,8(sp)
ffffffffc0200d1e:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200d20:	c74ff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200d24:	00005517          	auipc	a0,0x5
ffffffffc0200d28:	3dc50513          	addi	a0,a0,988 # ffffffffc0206100 <commands+0x770>
ffffffffc0200d2c:	b7fd                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200d2e:	00005517          	auipc	a0,0x5
ffffffffc0200d32:	3f250513          	addi	a0,a0,1010 # ffffffffc0206120 <commands+0x790>
ffffffffc0200d36:	b7d5                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200d38:	00005517          	auipc	a0,0x5
ffffffffc0200d3c:	40050513          	addi	a0,a0,1024 # ffffffffc0206138 <commands+0x7a8>
ffffffffc0200d40:	bfe9                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200d42:	00005517          	auipc	a0,0x5
ffffffffc0200d46:	40e50513          	addi	a0,a0,1038 # ffffffffc0206150 <commands+0x7c0>
ffffffffc0200d4a:	bfc1                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d4c:	00005517          	auipc	a0,0x5
ffffffffc0200d50:	28c50513          	addi	a0,a0,652 # ffffffffc0205fd8 <commands+0x648>
ffffffffc0200d54:	b7d9                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d56:	00005517          	auipc	a0,0x5
ffffffffc0200d5a:	2a250513          	addi	a0,a0,674 # ffffffffc0205ff8 <commands+0x668>
ffffffffc0200d5e:	bf75                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d60:	00005517          	auipc	a0,0x5
ffffffffc0200d64:	2b850513          	addi	a0,a0,696 # ffffffffc0206018 <commands+0x688>
ffffffffc0200d68:	bf4d                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d6a:	00005517          	auipc	a0,0x5
ffffffffc0200d6e:	2c650513          	addi	a0,a0,710 # ffffffffc0206030 <commands+0x6a0>
ffffffffc0200d72:	c22ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        if (tf->gpr.a7 == 10)
ffffffffc0200d76:	6458                	ld	a4,136(s0)
ffffffffc0200d78:	47a9                	li	a5,10
ffffffffc0200d7a:	04f70663          	beq	a4,a5,ffffffffc0200dc6 <exception_handler+0xf8>
}
ffffffffc0200d7e:	60a2                	ld	ra,8(sp)
ffffffffc0200d80:	6402                	ld	s0,0(sp)
ffffffffc0200d82:	0141                	addi	sp,sp,16
ffffffffc0200d84:	8082                	ret
        cprintf("Load address misaligned\n");
ffffffffc0200d86:	00005517          	auipc	a0,0x5
ffffffffc0200d8a:	2ba50513          	addi	a0,a0,698 # ffffffffc0206040 <commands+0x6b0>
ffffffffc0200d8e:	b771                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200d90:	00005517          	auipc	a0,0x5
ffffffffc0200d94:	2d050513          	addi	a0,a0,720 # ffffffffc0206060 <commands+0x6d0>
ffffffffc0200d98:	b749                	j	ffffffffc0200d1a <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200d9a:	00005517          	auipc	a0,0x5
ffffffffc0200d9e:	30e50513          	addi	a0,a0,782 # ffffffffc02060a8 <commands+0x718>
ffffffffc0200da2:	bfa5                	j	ffffffffc0200d1a <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200da4:	8522                	mv	a0,s0
}
ffffffffc0200da6:	6402                	ld	s0,0(sp)
ffffffffc0200da8:	60a2                	ld	ra,8(sp)
ffffffffc0200daa:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200dac:	bbe5                	j	ffffffffc0200ba4 <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200dae:	00005617          	auipc	a2,0x5
ffffffffc0200db2:	2ca60613          	addi	a2,a2,714 # ffffffffc0206078 <commands+0x6e8>
ffffffffc0200db6:	0bf00593          	li	a1,191
ffffffffc0200dba:	00005517          	auipc	a0,0x5
ffffffffc0200dbe:	2d650513          	addi	a0,a0,726 # ffffffffc0206090 <commands+0x700>
ffffffffc0200dc2:	eccff0ef          	jal	ra,ffffffffc020048e <__panic>
            tf->epc += 4;
ffffffffc0200dc6:	10843783          	ld	a5,264(s0)
ffffffffc0200dca:	0791                	addi	a5,a5,4
ffffffffc0200dcc:	10f43423          	sd	a5,264(s0)
            syscall();
ffffffffc0200dd0:	404040ef          	jal	ra,ffffffffc02051d4 <syscall>
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dd4:	000aa797          	auipc	a5,0xaa
ffffffffc0200dd8:	0647b783          	ld	a5,100(a5) # ffffffffc02aae38 <current>
ffffffffc0200ddc:	6b9c                	ld	a5,16(a5)
ffffffffc0200dde:	8522                	mv	a0,s0
}
ffffffffc0200de0:	6402                	ld	s0,0(sp)
ffffffffc0200de2:	60a2                	ld	ra,8(sp)
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200de4:	6589                	lui	a1,0x2
ffffffffc0200de6:	95be                	add	a1,a1,a5
}
ffffffffc0200de8:	0141                	addi	sp,sp,16
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dea:	aab1                	j	ffffffffc0200f46 <kernel_execve_ret>

ffffffffc0200dec <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200dec:	1101                	addi	sp,sp,-32
ffffffffc0200dee:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200df0:	000aa417          	auipc	s0,0xaa
ffffffffc0200df4:	04840413          	addi	s0,s0,72 # ffffffffc02aae38 <current>
ffffffffc0200df8:	6018                	ld	a4,0(s0)
{
ffffffffc0200dfa:	ec06                	sd	ra,24(sp)
ffffffffc0200dfc:	e426                	sd	s1,8(sp)
ffffffffc0200dfe:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e00:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200e04:	cf1d                	beqz	a4,ffffffffc0200e42 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200e06:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200e0a:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200e0e:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200e10:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e14:	0206c463          	bltz	a3,ffffffffc0200e3c <trap+0x50>
        exception_handler(tf);
ffffffffc0200e18:	eb7ff0ef          	jal	ra,ffffffffc0200cce <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200e1c:	601c                	ld	a5,0(s0)
ffffffffc0200e1e:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel)
ffffffffc0200e22:	e499                	bnez	s1,ffffffffc0200e30 <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200e24:	0b07a703          	lw	a4,176(a5)
ffffffffc0200e28:	8b05                	andi	a4,a4,1
ffffffffc0200e2a:	e329                	bnez	a4,ffffffffc0200e6c <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200e2c:	6f9c                	ld	a5,24(a5)
ffffffffc0200e2e:	eb85                	bnez	a5,ffffffffc0200e5e <trap+0x72>
            {
                schedule();
            }
        }
    }
}
ffffffffc0200e30:	60e2                	ld	ra,24(sp)
ffffffffc0200e32:	6442                	ld	s0,16(sp)
ffffffffc0200e34:	64a2                	ld	s1,8(sp)
ffffffffc0200e36:	6902                	ld	s2,0(sp)
ffffffffc0200e38:	6105                	addi	sp,sp,32
ffffffffc0200e3a:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200e3c:	dcbff0ef          	jal	ra,ffffffffc0200c06 <interrupt_handler>
ffffffffc0200e40:	bff1                	j	ffffffffc0200e1c <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e42:	0006c863          	bltz	a3,ffffffffc0200e52 <trap+0x66>
}
ffffffffc0200e46:	6442                	ld	s0,16(sp)
ffffffffc0200e48:	60e2                	ld	ra,24(sp)
ffffffffc0200e4a:	64a2                	ld	s1,8(sp)
ffffffffc0200e4c:	6902                	ld	s2,0(sp)
ffffffffc0200e4e:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200e50:	bdbd                	j	ffffffffc0200cce <exception_handler>
}
ffffffffc0200e52:	6442                	ld	s0,16(sp)
ffffffffc0200e54:	60e2                	ld	ra,24(sp)
ffffffffc0200e56:	64a2                	ld	s1,8(sp)
ffffffffc0200e58:	6902                	ld	s2,0(sp)
ffffffffc0200e5a:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200e5c:	b36d                	j	ffffffffc0200c06 <interrupt_handler>
}
ffffffffc0200e5e:	6442                	ld	s0,16(sp)
ffffffffc0200e60:	60e2                	ld	ra,24(sp)
ffffffffc0200e62:	64a2                	ld	s1,8(sp)
ffffffffc0200e64:	6902                	ld	s2,0(sp)
ffffffffc0200e66:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200e68:	2800406f          	j	ffffffffc02050e8 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200e6c:	555d                	li	a0,-9
ffffffffc0200e6e:	5a4030ef          	jal	ra,ffffffffc0204412 <do_exit>
            if (current->need_resched)
ffffffffc0200e72:	601c                	ld	a5,0(s0)
ffffffffc0200e74:	bf65                	j	ffffffffc0200e2c <trap+0x40>
	...

ffffffffc0200e78 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200e78:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200e7c:	00011463          	bnez	sp,ffffffffc0200e84 <__alltraps+0xc>
ffffffffc0200e80:	14002173          	csrr	sp,sscratch
ffffffffc0200e84:	712d                	addi	sp,sp,-288
ffffffffc0200e86:	e002                	sd	zero,0(sp)
ffffffffc0200e88:	e406                	sd	ra,8(sp)
ffffffffc0200e8a:	ec0e                	sd	gp,24(sp)
ffffffffc0200e8c:	f012                	sd	tp,32(sp)
ffffffffc0200e8e:	f416                	sd	t0,40(sp)
ffffffffc0200e90:	f81a                	sd	t1,48(sp)
ffffffffc0200e92:	fc1e                	sd	t2,56(sp)
ffffffffc0200e94:	e0a2                	sd	s0,64(sp)
ffffffffc0200e96:	e4a6                	sd	s1,72(sp)
ffffffffc0200e98:	e8aa                	sd	a0,80(sp)
ffffffffc0200e9a:	ecae                	sd	a1,88(sp)
ffffffffc0200e9c:	f0b2                	sd	a2,96(sp)
ffffffffc0200e9e:	f4b6                	sd	a3,104(sp)
ffffffffc0200ea0:	f8ba                	sd	a4,112(sp)
ffffffffc0200ea2:	fcbe                	sd	a5,120(sp)
ffffffffc0200ea4:	e142                	sd	a6,128(sp)
ffffffffc0200ea6:	e546                	sd	a7,136(sp)
ffffffffc0200ea8:	e94a                	sd	s2,144(sp)
ffffffffc0200eaa:	ed4e                	sd	s3,152(sp)
ffffffffc0200eac:	f152                	sd	s4,160(sp)
ffffffffc0200eae:	f556                	sd	s5,168(sp)
ffffffffc0200eb0:	f95a                	sd	s6,176(sp)
ffffffffc0200eb2:	fd5e                	sd	s7,184(sp)
ffffffffc0200eb4:	e1e2                	sd	s8,192(sp)
ffffffffc0200eb6:	e5e6                	sd	s9,200(sp)
ffffffffc0200eb8:	e9ea                	sd	s10,208(sp)
ffffffffc0200eba:	edee                	sd	s11,216(sp)
ffffffffc0200ebc:	f1f2                	sd	t3,224(sp)
ffffffffc0200ebe:	f5f6                	sd	t4,232(sp)
ffffffffc0200ec0:	f9fa                	sd	t5,240(sp)
ffffffffc0200ec2:	fdfe                	sd	t6,248(sp)
ffffffffc0200ec4:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200ec8:	100024f3          	csrr	s1,sstatus
ffffffffc0200ecc:	14102973          	csrr	s2,sepc
ffffffffc0200ed0:	143029f3          	csrr	s3,stval
ffffffffc0200ed4:	14202a73          	csrr	s4,scause
ffffffffc0200ed8:	e822                	sd	s0,16(sp)
ffffffffc0200eda:	e226                	sd	s1,256(sp)
ffffffffc0200edc:	e64a                	sd	s2,264(sp)
ffffffffc0200ede:	ea4e                	sd	s3,272(sp)
ffffffffc0200ee0:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200ee2:	850a                	mv	a0,sp
    jal trap
ffffffffc0200ee4:	f09ff0ef          	jal	ra,ffffffffc0200dec <trap>

ffffffffc0200ee8 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200ee8:	6492                	ld	s1,256(sp)
ffffffffc0200eea:	6932                	ld	s2,264(sp)
ffffffffc0200eec:	1004f413          	andi	s0,s1,256
ffffffffc0200ef0:	e401                	bnez	s0,ffffffffc0200ef8 <__trapret+0x10>
ffffffffc0200ef2:	1200                	addi	s0,sp,288
ffffffffc0200ef4:	14041073          	csrw	sscratch,s0
ffffffffc0200ef8:	10049073          	csrw	sstatus,s1
ffffffffc0200efc:	14191073          	csrw	sepc,s2
ffffffffc0200f00:	60a2                	ld	ra,8(sp)
ffffffffc0200f02:	61e2                	ld	gp,24(sp)
ffffffffc0200f04:	7202                	ld	tp,32(sp)
ffffffffc0200f06:	72a2                	ld	t0,40(sp)
ffffffffc0200f08:	7342                	ld	t1,48(sp)
ffffffffc0200f0a:	73e2                	ld	t2,56(sp)
ffffffffc0200f0c:	6406                	ld	s0,64(sp)
ffffffffc0200f0e:	64a6                	ld	s1,72(sp)
ffffffffc0200f10:	6546                	ld	a0,80(sp)
ffffffffc0200f12:	65e6                	ld	a1,88(sp)
ffffffffc0200f14:	7606                	ld	a2,96(sp)
ffffffffc0200f16:	76a6                	ld	a3,104(sp)
ffffffffc0200f18:	7746                	ld	a4,112(sp)
ffffffffc0200f1a:	77e6                	ld	a5,120(sp)
ffffffffc0200f1c:	680a                	ld	a6,128(sp)
ffffffffc0200f1e:	68aa                	ld	a7,136(sp)
ffffffffc0200f20:	694a                	ld	s2,144(sp)
ffffffffc0200f22:	69ea                	ld	s3,152(sp)
ffffffffc0200f24:	7a0a                	ld	s4,160(sp)
ffffffffc0200f26:	7aaa                	ld	s5,168(sp)
ffffffffc0200f28:	7b4a                	ld	s6,176(sp)
ffffffffc0200f2a:	7bea                	ld	s7,184(sp)
ffffffffc0200f2c:	6c0e                	ld	s8,192(sp)
ffffffffc0200f2e:	6cae                	ld	s9,200(sp)
ffffffffc0200f30:	6d4e                	ld	s10,208(sp)
ffffffffc0200f32:	6dee                	ld	s11,216(sp)
ffffffffc0200f34:	7e0e                	ld	t3,224(sp)
ffffffffc0200f36:	7eae                	ld	t4,232(sp)
ffffffffc0200f38:	7f4e                	ld	t5,240(sp)
ffffffffc0200f3a:	7fee                	ld	t6,248(sp)
ffffffffc0200f3c:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200f3e:	10200073          	sret

ffffffffc0200f42 <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200f42:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200f44:	b755                	j	ffffffffc0200ee8 <__trapret>

ffffffffc0200f46 <kernel_execve_ret>:

    .global kernel_execve_ret
kernel_execve_ret:
    // adjust sp to beneath kstacktop of current process
    addi a1, a1, -36*REGBYTES
ffffffffc0200f46:	ee058593          	addi	a1,a1,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7d40>

    // copy from previous trapframe to new trapframe
    LOAD s1, 35*REGBYTES(a0)
ffffffffc0200f4a:	11853483          	ld	s1,280(a0)
    STORE s1, 35*REGBYTES(a1)
ffffffffc0200f4e:	1095bc23          	sd	s1,280(a1)
    LOAD s1, 34*REGBYTES(a0)
ffffffffc0200f52:	11053483          	ld	s1,272(a0)
    STORE s1, 34*REGBYTES(a1)
ffffffffc0200f56:	1095b823          	sd	s1,272(a1)
    LOAD s1, 33*REGBYTES(a0)
ffffffffc0200f5a:	10853483          	ld	s1,264(a0)
    STORE s1, 33*REGBYTES(a1)
ffffffffc0200f5e:	1095b423          	sd	s1,264(a1)
    LOAD s1, 32*REGBYTES(a0)
ffffffffc0200f62:	10053483          	ld	s1,256(a0)
    STORE s1, 32*REGBYTES(a1)
ffffffffc0200f66:	1095b023          	sd	s1,256(a1)
    LOAD s1, 31*REGBYTES(a0)
ffffffffc0200f6a:	7d64                	ld	s1,248(a0)
    STORE s1, 31*REGBYTES(a1)
ffffffffc0200f6c:	fde4                	sd	s1,248(a1)
    LOAD s1, 30*REGBYTES(a0)
ffffffffc0200f6e:	7964                	ld	s1,240(a0)
    STORE s1, 30*REGBYTES(a1)
ffffffffc0200f70:	f9e4                	sd	s1,240(a1)
    LOAD s1, 29*REGBYTES(a0)
ffffffffc0200f72:	7564                	ld	s1,232(a0)
    STORE s1, 29*REGBYTES(a1)
ffffffffc0200f74:	f5e4                	sd	s1,232(a1)
    LOAD s1, 28*REGBYTES(a0)
ffffffffc0200f76:	7164                	ld	s1,224(a0)
    STORE s1, 28*REGBYTES(a1)
ffffffffc0200f78:	f1e4                	sd	s1,224(a1)
    LOAD s1, 27*REGBYTES(a0)
ffffffffc0200f7a:	6d64                	ld	s1,216(a0)
    STORE s1, 27*REGBYTES(a1)
ffffffffc0200f7c:	ede4                	sd	s1,216(a1)
    LOAD s1, 26*REGBYTES(a0)
ffffffffc0200f7e:	6964                	ld	s1,208(a0)
    STORE s1, 26*REGBYTES(a1)
ffffffffc0200f80:	e9e4                	sd	s1,208(a1)
    LOAD s1, 25*REGBYTES(a0)
ffffffffc0200f82:	6564                	ld	s1,200(a0)
    STORE s1, 25*REGBYTES(a1)
ffffffffc0200f84:	e5e4                	sd	s1,200(a1)
    LOAD s1, 24*REGBYTES(a0)
ffffffffc0200f86:	6164                	ld	s1,192(a0)
    STORE s1, 24*REGBYTES(a1)
ffffffffc0200f88:	e1e4                	sd	s1,192(a1)
    LOAD s1, 23*REGBYTES(a0)
ffffffffc0200f8a:	7d44                	ld	s1,184(a0)
    STORE s1, 23*REGBYTES(a1)
ffffffffc0200f8c:	fdc4                	sd	s1,184(a1)
    LOAD s1, 22*REGBYTES(a0)
ffffffffc0200f8e:	7944                	ld	s1,176(a0)
    STORE s1, 22*REGBYTES(a1)
ffffffffc0200f90:	f9c4                	sd	s1,176(a1)
    LOAD s1, 21*REGBYTES(a0)
ffffffffc0200f92:	7544                	ld	s1,168(a0)
    STORE s1, 21*REGBYTES(a1)
ffffffffc0200f94:	f5c4                	sd	s1,168(a1)
    LOAD s1, 20*REGBYTES(a0)
ffffffffc0200f96:	7144                	ld	s1,160(a0)
    STORE s1, 20*REGBYTES(a1)
ffffffffc0200f98:	f1c4                	sd	s1,160(a1)
    LOAD s1, 19*REGBYTES(a0)
ffffffffc0200f9a:	6d44                	ld	s1,152(a0)
    STORE s1, 19*REGBYTES(a1)
ffffffffc0200f9c:	edc4                	sd	s1,152(a1)
    LOAD s1, 18*REGBYTES(a0)
ffffffffc0200f9e:	6944                	ld	s1,144(a0)
    STORE s1, 18*REGBYTES(a1)
ffffffffc0200fa0:	e9c4                	sd	s1,144(a1)
    LOAD s1, 17*REGBYTES(a0)
ffffffffc0200fa2:	6544                	ld	s1,136(a0)
    STORE s1, 17*REGBYTES(a1)
ffffffffc0200fa4:	e5c4                	sd	s1,136(a1)
    LOAD s1, 16*REGBYTES(a0)
ffffffffc0200fa6:	6144                	ld	s1,128(a0)
    STORE s1, 16*REGBYTES(a1)
ffffffffc0200fa8:	e1c4                	sd	s1,128(a1)
    LOAD s1, 15*REGBYTES(a0)
ffffffffc0200faa:	7d24                	ld	s1,120(a0)
    STORE s1, 15*REGBYTES(a1)
ffffffffc0200fac:	fda4                	sd	s1,120(a1)
    LOAD s1, 14*REGBYTES(a0)
ffffffffc0200fae:	7924                	ld	s1,112(a0)
    STORE s1, 14*REGBYTES(a1)
ffffffffc0200fb0:	f9a4                	sd	s1,112(a1)
    LOAD s1, 13*REGBYTES(a0)
ffffffffc0200fb2:	7524                	ld	s1,104(a0)
    STORE s1, 13*REGBYTES(a1)
ffffffffc0200fb4:	f5a4                	sd	s1,104(a1)
    LOAD s1, 12*REGBYTES(a0)
ffffffffc0200fb6:	7124                	ld	s1,96(a0)
    STORE s1, 12*REGBYTES(a1)
ffffffffc0200fb8:	f1a4                	sd	s1,96(a1)
    LOAD s1, 11*REGBYTES(a0)
ffffffffc0200fba:	6d24                	ld	s1,88(a0)
    STORE s1, 11*REGBYTES(a1)
ffffffffc0200fbc:	eda4                	sd	s1,88(a1)
    LOAD s1, 10*REGBYTES(a0)
ffffffffc0200fbe:	6924                	ld	s1,80(a0)
    STORE s1, 10*REGBYTES(a1)
ffffffffc0200fc0:	e9a4                	sd	s1,80(a1)
    LOAD s1, 9*REGBYTES(a0)
ffffffffc0200fc2:	6524                	ld	s1,72(a0)
    STORE s1, 9*REGBYTES(a1)
ffffffffc0200fc4:	e5a4                	sd	s1,72(a1)
    LOAD s1, 8*REGBYTES(a0)
ffffffffc0200fc6:	6124                	ld	s1,64(a0)
    STORE s1, 8*REGBYTES(a1)
ffffffffc0200fc8:	e1a4                	sd	s1,64(a1)
    LOAD s1, 7*REGBYTES(a0)
ffffffffc0200fca:	7d04                	ld	s1,56(a0)
    STORE s1, 7*REGBYTES(a1)
ffffffffc0200fcc:	fd84                	sd	s1,56(a1)
    LOAD s1, 6*REGBYTES(a0)
ffffffffc0200fce:	7904                	ld	s1,48(a0)
    STORE s1, 6*REGBYTES(a1)
ffffffffc0200fd0:	f984                	sd	s1,48(a1)
    LOAD s1, 5*REGBYTES(a0)
ffffffffc0200fd2:	7504                	ld	s1,40(a0)
    STORE s1, 5*REGBYTES(a1)
ffffffffc0200fd4:	f584                	sd	s1,40(a1)
    LOAD s1, 4*REGBYTES(a0)
ffffffffc0200fd6:	7104                	ld	s1,32(a0)
    STORE s1, 4*REGBYTES(a1)
ffffffffc0200fd8:	f184                	sd	s1,32(a1)
    LOAD s1, 3*REGBYTES(a0)
ffffffffc0200fda:	6d04                	ld	s1,24(a0)
    STORE s1, 3*REGBYTES(a1)
ffffffffc0200fdc:	ed84                	sd	s1,24(a1)
    LOAD s1, 2*REGBYTES(a0)
ffffffffc0200fde:	6904                	ld	s1,16(a0)
    STORE s1, 2*REGBYTES(a1)
ffffffffc0200fe0:	e984                	sd	s1,16(a1)
    LOAD s1, 1*REGBYTES(a0)
ffffffffc0200fe2:	6504                	ld	s1,8(a0)
    STORE s1, 1*REGBYTES(a1)
ffffffffc0200fe4:	e584                	sd	s1,8(a1)
    LOAD s1, 0*REGBYTES(a0)
ffffffffc0200fe6:	6104                	ld	s1,0(a0)
    STORE s1, 0*REGBYTES(a1)
ffffffffc0200fe8:	e184                	sd	s1,0(a1)

    // acutually adjust sp
    move sp, a1
ffffffffc0200fea:	812e                	mv	sp,a1
ffffffffc0200fec:	bdf5                	j	ffffffffc0200ee8 <__trapret>

ffffffffc0200fee <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200fee:	000a6797          	auipc	a5,0xa6
ffffffffc0200ff2:	dba78793          	addi	a5,a5,-582 # ffffffffc02a6da8 <free_area>
ffffffffc0200ff6:	e79c                	sd	a5,8(a5)
ffffffffc0200ff8:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200ffa:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200ffe:	8082                	ret

ffffffffc0201000 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0201000:	000a6517          	auipc	a0,0xa6
ffffffffc0201004:	db856503          	lwu	a0,-584(a0) # ffffffffc02a6db8 <free_area+0x10>
ffffffffc0201008:	8082                	ret

ffffffffc020100a <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc020100a:	715d                	addi	sp,sp,-80
ffffffffc020100c:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc020100e:	000a6417          	auipc	s0,0xa6
ffffffffc0201012:	d9a40413          	addi	s0,s0,-614 # ffffffffc02a6da8 <free_area>
ffffffffc0201016:	641c                	ld	a5,8(s0)
ffffffffc0201018:	e486                	sd	ra,72(sp)
ffffffffc020101a:	fc26                	sd	s1,56(sp)
ffffffffc020101c:	f84a                	sd	s2,48(sp)
ffffffffc020101e:	f44e                	sd	s3,40(sp)
ffffffffc0201020:	f052                	sd	s4,32(sp)
ffffffffc0201022:	ec56                	sd	s5,24(sp)
ffffffffc0201024:	e85a                	sd	s6,16(sp)
ffffffffc0201026:	e45e                	sd	s7,8(sp)
ffffffffc0201028:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc020102a:	2a878d63          	beq	a5,s0,ffffffffc02012e4 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc020102e:	4481                	li	s1,0
ffffffffc0201030:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201032:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0201036:	8b09                	andi	a4,a4,2
ffffffffc0201038:	2a070a63          	beqz	a4,ffffffffc02012ec <default_check+0x2e2>
        count++, total += p->property;
ffffffffc020103c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201040:	679c                	ld	a5,8(a5)
ffffffffc0201042:	2905                	addiw	s2,s2,1
ffffffffc0201044:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0201046:	fe8796e3          	bne	a5,s0,ffffffffc0201032 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc020104a:	89a6                	mv	s3,s1
ffffffffc020104c:	6df000ef          	jal	ra,ffffffffc0201f2a <nr_free_pages>
ffffffffc0201050:	6f351e63          	bne	a0,s3,ffffffffc020174c <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201054:	4505                	li	a0,1
ffffffffc0201056:	657000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc020105a:	8aaa                	mv	s5,a0
ffffffffc020105c:	42050863          	beqz	a0,ffffffffc020148c <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201060:	4505                	li	a0,1
ffffffffc0201062:	64b000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201066:	89aa                	mv	s3,a0
ffffffffc0201068:	70050263          	beqz	a0,ffffffffc020176c <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020106c:	4505                	li	a0,1
ffffffffc020106e:	63f000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201072:	8a2a                	mv	s4,a0
ffffffffc0201074:	48050c63          	beqz	a0,ffffffffc020150c <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201078:	293a8a63          	beq	s5,s3,ffffffffc020130c <default_check+0x302>
ffffffffc020107c:	28aa8863          	beq	s5,a0,ffffffffc020130c <default_check+0x302>
ffffffffc0201080:	28a98663          	beq	s3,a0,ffffffffc020130c <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201084:	000aa783          	lw	a5,0(s5)
ffffffffc0201088:	2a079263          	bnez	a5,ffffffffc020132c <default_check+0x322>
ffffffffc020108c:	0009a783          	lw	a5,0(s3)
ffffffffc0201090:	28079e63          	bnez	a5,ffffffffc020132c <default_check+0x322>
ffffffffc0201094:	411c                	lw	a5,0(a0)
ffffffffc0201096:	28079b63          	bnez	a5,ffffffffc020132c <default_check+0x322>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc020109a:	000aa797          	auipc	a5,0xaa
ffffffffc020109e:	d867b783          	ld	a5,-634(a5) # ffffffffc02aae20 <pages>
ffffffffc02010a2:	40fa8733          	sub	a4,s5,a5
ffffffffc02010a6:	00006617          	auipc	a2,0x6
ffffffffc02010aa:	7e263603          	ld	a2,2018(a2) # ffffffffc0207888 <nbase>
ffffffffc02010ae:	8719                	srai	a4,a4,0x6
ffffffffc02010b0:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc02010b2:	000aa697          	auipc	a3,0xaa
ffffffffc02010b6:	d666b683          	ld	a3,-666(a3) # ffffffffc02aae18 <npage>
ffffffffc02010ba:	06b2                	slli	a3,a3,0xc
}

static inline uintptr_t
page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
ffffffffc02010bc:	0732                	slli	a4,a4,0xc
ffffffffc02010be:	28d77763          	bgeu	a4,a3,ffffffffc020134c <default_check+0x342>
    return page - pages + nbase;
ffffffffc02010c2:	40f98733          	sub	a4,s3,a5
ffffffffc02010c6:	8719                	srai	a4,a4,0x6
ffffffffc02010c8:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02010ca:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02010cc:	4cd77063          	bgeu	a4,a3,ffffffffc020158c <default_check+0x582>
    return page - pages + nbase;
ffffffffc02010d0:	40f507b3          	sub	a5,a0,a5
ffffffffc02010d4:	8799                	srai	a5,a5,0x6
ffffffffc02010d6:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02010d8:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010da:	30d7f963          	bgeu	a5,a3,ffffffffc02013ec <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc02010de:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02010e0:	00043c03          	ld	s8,0(s0)
ffffffffc02010e4:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc02010e8:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc02010ec:	e400                	sd	s0,8(s0)
ffffffffc02010ee:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc02010f0:	000a6797          	auipc	a5,0xa6
ffffffffc02010f4:	cc07a423          	sw	zero,-824(a5) # ffffffffc02a6db8 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc02010f8:	5b5000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc02010fc:	2c051863          	bnez	a0,ffffffffc02013cc <default_check+0x3c2>
    free_page(p0);
ffffffffc0201100:	4585                	li	a1,1
ffffffffc0201102:	8556                	mv	a0,s5
ffffffffc0201104:	5e7000ef          	jal	ra,ffffffffc0201eea <free_pages>
    free_page(p1);
ffffffffc0201108:	4585                	li	a1,1
ffffffffc020110a:	854e                	mv	a0,s3
ffffffffc020110c:	5df000ef          	jal	ra,ffffffffc0201eea <free_pages>
    free_page(p2);
ffffffffc0201110:	4585                	li	a1,1
ffffffffc0201112:	8552                	mv	a0,s4
ffffffffc0201114:	5d7000ef          	jal	ra,ffffffffc0201eea <free_pages>
    assert(nr_free == 3);
ffffffffc0201118:	4818                	lw	a4,16(s0)
ffffffffc020111a:	478d                	li	a5,3
ffffffffc020111c:	28f71863          	bne	a4,a5,ffffffffc02013ac <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201120:	4505                	li	a0,1
ffffffffc0201122:	58b000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201126:	89aa                	mv	s3,a0
ffffffffc0201128:	26050263          	beqz	a0,ffffffffc020138c <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc020112c:	4505                	li	a0,1
ffffffffc020112e:	57f000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201132:	8aaa                	mv	s5,a0
ffffffffc0201134:	3a050c63          	beqz	a0,ffffffffc02014ec <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201138:	4505                	li	a0,1
ffffffffc020113a:	573000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc020113e:	8a2a                	mv	s4,a0
ffffffffc0201140:	38050663          	beqz	a0,ffffffffc02014cc <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201144:	4505                	li	a0,1
ffffffffc0201146:	567000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc020114a:	36051163          	bnez	a0,ffffffffc02014ac <default_check+0x4a2>
    free_page(p0);
ffffffffc020114e:	4585                	li	a1,1
ffffffffc0201150:	854e                	mv	a0,s3
ffffffffc0201152:	599000ef          	jal	ra,ffffffffc0201eea <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0201156:	641c                	ld	a5,8(s0)
ffffffffc0201158:	20878a63          	beq	a5,s0,ffffffffc020136c <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc020115c:	4505                	li	a0,1
ffffffffc020115e:	54f000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201162:	30a99563          	bne	s3,a0,ffffffffc020146c <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0201166:	4505                	li	a0,1
ffffffffc0201168:	545000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc020116c:	2e051063          	bnez	a0,ffffffffc020144c <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201170:	481c                	lw	a5,16(s0)
ffffffffc0201172:	2a079d63          	bnez	a5,ffffffffc020142c <default_check+0x422>
    free_page(p);
ffffffffc0201176:	854e                	mv	a0,s3
ffffffffc0201178:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc020117a:	01843023          	sd	s8,0(s0)
ffffffffc020117e:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0201182:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0201186:	565000ef          	jal	ra,ffffffffc0201eea <free_pages>
    free_page(p1);
ffffffffc020118a:	4585                	li	a1,1
ffffffffc020118c:	8556                	mv	a0,s5
ffffffffc020118e:	55d000ef          	jal	ra,ffffffffc0201eea <free_pages>
    free_page(p2);
ffffffffc0201192:	4585                	li	a1,1
ffffffffc0201194:	8552                	mv	a0,s4
ffffffffc0201196:	555000ef          	jal	ra,ffffffffc0201eea <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc020119a:	4515                	li	a0,5
ffffffffc020119c:	511000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc02011a0:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc02011a2:	26050563          	beqz	a0,ffffffffc020140c <default_check+0x402>
ffffffffc02011a6:	651c                	ld	a5,8(a0)
ffffffffc02011a8:	8385                	srli	a5,a5,0x1
ffffffffc02011aa:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc02011ac:	54079063          	bnez	a5,ffffffffc02016ec <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc02011b0:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02011b2:	00043b03          	ld	s6,0(s0)
ffffffffc02011b6:	00843a83          	ld	s5,8(s0)
ffffffffc02011ba:	e000                	sd	s0,0(s0)
ffffffffc02011bc:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02011be:	4ef000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc02011c2:	50051563          	bnez	a0,ffffffffc02016cc <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02011c6:	08098a13          	addi	s4,s3,128
ffffffffc02011ca:	8552                	mv	a0,s4
ffffffffc02011cc:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02011ce:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02011d2:	000a6797          	auipc	a5,0xa6
ffffffffc02011d6:	be07a323          	sw	zero,-1050(a5) # ffffffffc02a6db8 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02011da:	511000ef          	jal	ra,ffffffffc0201eea <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02011de:	4511                	li	a0,4
ffffffffc02011e0:	4cd000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc02011e4:	4c051463          	bnez	a0,ffffffffc02016ac <default_check+0x6a2>
ffffffffc02011e8:	0889b783          	ld	a5,136(s3)
ffffffffc02011ec:	8385                	srli	a5,a5,0x1
ffffffffc02011ee:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02011f0:	48078e63          	beqz	a5,ffffffffc020168c <default_check+0x682>
ffffffffc02011f4:	0909a703          	lw	a4,144(s3)
ffffffffc02011f8:	478d                	li	a5,3
ffffffffc02011fa:	48f71963          	bne	a4,a5,ffffffffc020168c <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc02011fe:	450d                	li	a0,3
ffffffffc0201200:	4ad000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201204:	8c2a                	mv	s8,a0
ffffffffc0201206:	46050363          	beqz	a0,ffffffffc020166c <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc020120a:	4505                	li	a0,1
ffffffffc020120c:	4a1000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201210:	42051e63          	bnez	a0,ffffffffc020164c <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0201214:	418a1c63          	bne	s4,s8,ffffffffc020162c <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0201218:	4585                	li	a1,1
ffffffffc020121a:	854e                	mv	a0,s3
ffffffffc020121c:	4cf000ef          	jal	ra,ffffffffc0201eea <free_pages>
    free_pages(p1, 3);
ffffffffc0201220:	458d                	li	a1,3
ffffffffc0201222:	8552                	mv	a0,s4
ffffffffc0201224:	4c7000ef          	jal	ra,ffffffffc0201eea <free_pages>
ffffffffc0201228:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc020122c:	04098c13          	addi	s8,s3,64
ffffffffc0201230:	8385                	srli	a5,a5,0x1
ffffffffc0201232:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201234:	3c078c63          	beqz	a5,ffffffffc020160c <default_check+0x602>
ffffffffc0201238:	0109a703          	lw	a4,16(s3)
ffffffffc020123c:	4785                	li	a5,1
ffffffffc020123e:	3cf71763          	bne	a4,a5,ffffffffc020160c <default_check+0x602>
ffffffffc0201242:	008a3783          	ld	a5,8(s4)
ffffffffc0201246:	8385                	srli	a5,a5,0x1
ffffffffc0201248:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc020124a:	3a078163          	beqz	a5,ffffffffc02015ec <default_check+0x5e2>
ffffffffc020124e:	010a2703          	lw	a4,16(s4)
ffffffffc0201252:	478d                	li	a5,3
ffffffffc0201254:	38f71c63          	bne	a4,a5,ffffffffc02015ec <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201258:	4505                	li	a0,1
ffffffffc020125a:	453000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc020125e:	36a99763          	bne	s3,a0,ffffffffc02015cc <default_check+0x5c2>
    free_page(p0);
ffffffffc0201262:	4585                	li	a1,1
ffffffffc0201264:	487000ef          	jal	ra,ffffffffc0201eea <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201268:	4509                	li	a0,2
ffffffffc020126a:	443000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc020126e:	32aa1f63          	bne	s4,a0,ffffffffc02015ac <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0201272:	4589                	li	a1,2
ffffffffc0201274:	477000ef          	jal	ra,ffffffffc0201eea <free_pages>
    free_page(p2);
ffffffffc0201278:	4585                	li	a1,1
ffffffffc020127a:	8562                	mv	a0,s8
ffffffffc020127c:	46f000ef          	jal	ra,ffffffffc0201eea <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201280:	4515                	li	a0,5
ffffffffc0201282:	42b000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201286:	89aa                	mv	s3,a0
ffffffffc0201288:	48050263          	beqz	a0,ffffffffc020170c <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc020128c:	4505                	li	a0,1
ffffffffc020128e:	41f000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc0201292:	2c051d63          	bnez	a0,ffffffffc020156c <default_check+0x562>

    assert(nr_free == 0);
ffffffffc0201296:	481c                	lw	a5,16(s0)
ffffffffc0201298:	2a079a63          	bnez	a5,ffffffffc020154c <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc020129c:	4595                	li	a1,5
ffffffffc020129e:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc02012a0:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc02012a4:	01643023          	sd	s6,0(s0)
ffffffffc02012a8:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc02012ac:	43f000ef          	jal	ra,ffffffffc0201eea <free_pages>
    return listelm->next;
ffffffffc02012b0:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc02012b2:	00878963          	beq	a5,s0,ffffffffc02012c4 <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc02012b6:	ff87a703          	lw	a4,-8(a5)
ffffffffc02012ba:	679c                	ld	a5,8(a5)
ffffffffc02012bc:	397d                	addiw	s2,s2,-1
ffffffffc02012be:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc02012c0:	fe879be3          	bne	a5,s0,ffffffffc02012b6 <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02012c4:	26091463          	bnez	s2,ffffffffc020152c <default_check+0x522>
    assert(total == 0);
ffffffffc02012c8:	46049263          	bnez	s1,ffffffffc020172c <default_check+0x722>
}
ffffffffc02012cc:	60a6                	ld	ra,72(sp)
ffffffffc02012ce:	6406                	ld	s0,64(sp)
ffffffffc02012d0:	74e2                	ld	s1,56(sp)
ffffffffc02012d2:	7942                	ld	s2,48(sp)
ffffffffc02012d4:	79a2                	ld	s3,40(sp)
ffffffffc02012d6:	7a02                	ld	s4,32(sp)
ffffffffc02012d8:	6ae2                	ld	s5,24(sp)
ffffffffc02012da:	6b42                	ld	s6,16(sp)
ffffffffc02012dc:	6ba2                	ld	s7,8(sp)
ffffffffc02012de:	6c02                	ld	s8,0(sp)
ffffffffc02012e0:	6161                	addi	sp,sp,80
ffffffffc02012e2:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc02012e4:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc02012e6:	4481                	li	s1,0
ffffffffc02012e8:	4901                	li	s2,0
ffffffffc02012ea:	b38d                	j	ffffffffc020104c <default_check+0x42>
        assert(PageProperty(p));
ffffffffc02012ec:	00005697          	auipc	a3,0x5
ffffffffc02012f0:	ebc68693          	addi	a3,a3,-324 # ffffffffc02061a8 <commands+0x818>
ffffffffc02012f4:	00005617          	auipc	a2,0x5
ffffffffc02012f8:	ec460613          	addi	a2,a2,-316 # ffffffffc02061b8 <commands+0x828>
ffffffffc02012fc:	11000593          	li	a1,272
ffffffffc0201300:	00005517          	auipc	a0,0x5
ffffffffc0201304:	ed050513          	addi	a0,a0,-304 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201308:	986ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc020130c:	00005697          	auipc	a3,0x5
ffffffffc0201310:	f5c68693          	addi	a3,a3,-164 # ffffffffc0206268 <commands+0x8d8>
ffffffffc0201314:	00005617          	auipc	a2,0x5
ffffffffc0201318:	ea460613          	addi	a2,a2,-348 # ffffffffc02061b8 <commands+0x828>
ffffffffc020131c:	0db00593          	li	a1,219
ffffffffc0201320:	00005517          	auipc	a0,0x5
ffffffffc0201324:	eb050513          	addi	a0,a0,-336 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201328:	966ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc020132c:	00005697          	auipc	a3,0x5
ffffffffc0201330:	f6468693          	addi	a3,a3,-156 # ffffffffc0206290 <commands+0x900>
ffffffffc0201334:	00005617          	auipc	a2,0x5
ffffffffc0201338:	e8460613          	addi	a2,a2,-380 # ffffffffc02061b8 <commands+0x828>
ffffffffc020133c:	0dc00593          	li	a1,220
ffffffffc0201340:	00005517          	auipc	a0,0x5
ffffffffc0201344:	e9050513          	addi	a0,a0,-368 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201348:	946ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc020134c:	00005697          	auipc	a3,0x5
ffffffffc0201350:	f8468693          	addi	a3,a3,-124 # ffffffffc02062d0 <commands+0x940>
ffffffffc0201354:	00005617          	auipc	a2,0x5
ffffffffc0201358:	e6460613          	addi	a2,a2,-412 # ffffffffc02061b8 <commands+0x828>
ffffffffc020135c:	0de00593          	li	a1,222
ffffffffc0201360:	00005517          	auipc	a0,0x5
ffffffffc0201364:	e7050513          	addi	a0,a0,-400 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201368:	926ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!list_empty(&free_list));
ffffffffc020136c:	00005697          	auipc	a3,0x5
ffffffffc0201370:	fec68693          	addi	a3,a3,-20 # ffffffffc0206358 <commands+0x9c8>
ffffffffc0201374:	00005617          	auipc	a2,0x5
ffffffffc0201378:	e4460613          	addi	a2,a2,-444 # ffffffffc02061b8 <commands+0x828>
ffffffffc020137c:	0f700593          	li	a1,247
ffffffffc0201380:	00005517          	auipc	a0,0x5
ffffffffc0201384:	e5050513          	addi	a0,a0,-432 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201388:	906ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020138c:	00005697          	auipc	a3,0x5
ffffffffc0201390:	e7c68693          	addi	a3,a3,-388 # ffffffffc0206208 <commands+0x878>
ffffffffc0201394:	00005617          	auipc	a2,0x5
ffffffffc0201398:	e2460613          	addi	a2,a2,-476 # ffffffffc02061b8 <commands+0x828>
ffffffffc020139c:	0f000593          	li	a1,240
ffffffffc02013a0:	00005517          	auipc	a0,0x5
ffffffffc02013a4:	e3050513          	addi	a0,a0,-464 # ffffffffc02061d0 <commands+0x840>
ffffffffc02013a8:	8e6ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 3);
ffffffffc02013ac:	00005697          	auipc	a3,0x5
ffffffffc02013b0:	f9c68693          	addi	a3,a3,-100 # ffffffffc0206348 <commands+0x9b8>
ffffffffc02013b4:	00005617          	auipc	a2,0x5
ffffffffc02013b8:	e0460613          	addi	a2,a2,-508 # ffffffffc02061b8 <commands+0x828>
ffffffffc02013bc:	0ee00593          	li	a1,238
ffffffffc02013c0:	00005517          	auipc	a0,0x5
ffffffffc02013c4:	e1050513          	addi	a0,a0,-496 # ffffffffc02061d0 <commands+0x840>
ffffffffc02013c8:	8c6ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013cc:	00005697          	auipc	a3,0x5
ffffffffc02013d0:	f6468693          	addi	a3,a3,-156 # ffffffffc0206330 <commands+0x9a0>
ffffffffc02013d4:	00005617          	auipc	a2,0x5
ffffffffc02013d8:	de460613          	addi	a2,a2,-540 # ffffffffc02061b8 <commands+0x828>
ffffffffc02013dc:	0e900593          	li	a1,233
ffffffffc02013e0:	00005517          	auipc	a0,0x5
ffffffffc02013e4:	df050513          	addi	a0,a0,-528 # ffffffffc02061d0 <commands+0x840>
ffffffffc02013e8:	8a6ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02013ec:	00005697          	auipc	a3,0x5
ffffffffc02013f0:	f2468693          	addi	a3,a3,-220 # ffffffffc0206310 <commands+0x980>
ffffffffc02013f4:	00005617          	auipc	a2,0x5
ffffffffc02013f8:	dc460613          	addi	a2,a2,-572 # ffffffffc02061b8 <commands+0x828>
ffffffffc02013fc:	0e000593          	li	a1,224
ffffffffc0201400:	00005517          	auipc	a0,0x5
ffffffffc0201404:	dd050513          	addi	a0,a0,-560 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201408:	886ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != NULL);
ffffffffc020140c:	00005697          	auipc	a3,0x5
ffffffffc0201410:	f9468693          	addi	a3,a3,-108 # ffffffffc02063a0 <commands+0xa10>
ffffffffc0201414:	00005617          	auipc	a2,0x5
ffffffffc0201418:	da460613          	addi	a2,a2,-604 # ffffffffc02061b8 <commands+0x828>
ffffffffc020141c:	11800593          	li	a1,280
ffffffffc0201420:	00005517          	auipc	a0,0x5
ffffffffc0201424:	db050513          	addi	a0,a0,-592 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201428:	866ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc020142c:	00005697          	auipc	a3,0x5
ffffffffc0201430:	f6468693          	addi	a3,a3,-156 # ffffffffc0206390 <commands+0xa00>
ffffffffc0201434:	00005617          	auipc	a2,0x5
ffffffffc0201438:	d8460613          	addi	a2,a2,-636 # ffffffffc02061b8 <commands+0x828>
ffffffffc020143c:	0fd00593          	li	a1,253
ffffffffc0201440:	00005517          	auipc	a0,0x5
ffffffffc0201444:	d9050513          	addi	a0,a0,-624 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201448:	846ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc020144c:	00005697          	auipc	a3,0x5
ffffffffc0201450:	ee468693          	addi	a3,a3,-284 # ffffffffc0206330 <commands+0x9a0>
ffffffffc0201454:	00005617          	auipc	a2,0x5
ffffffffc0201458:	d6460613          	addi	a2,a2,-668 # ffffffffc02061b8 <commands+0x828>
ffffffffc020145c:	0fb00593          	li	a1,251
ffffffffc0201460:	00005517          	auipc	a0,0x5
ffffffffc0201464:	d7050513          	addi	a0,a0,-656 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201468:	826ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc020146c:	00005697          	auipc	a3,0x5
ffffffffc0201470:	f0468693          	addi	a3,a3,-252 # ffffffffc0206370 <commands+0x9e0>
ffffffffc0201474:	00005617          	auipc	a2,0x5
ffffffffc0201478:	d4460613          	addi	a2,a2,-700 # ffffffffc02061b8 <commands+0x828>
ffffffffc020147c:	0fa00593          	li	a1,250
ffffffffc0201480:	00005517          	auipc	a0,0x5
ffffffffc0201484:	d5050513          	addi	a0,a0,-688 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201488:	806ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020148c:	00005697          	auipc	a3,0x5
ffffffffc0201490:	d7c68693          	addi	a3,a3,-644 # ffffffffc0206208 <commands+0x878>
ffffffffc0201494:	00005617          	auipc	a2,0x5
ffffffffc0201498:	d2460613          	addi	a2,a2,-732 # ffffffffc02061b8 <commands+0x828>
ffffffffc020149c:	0d700593          	li	a1,215
ffffffffc02014a0:	00005517          	auipc	a0,0x5
ffffffffc02014a4:	d3050513          	addi	a0,a0,-720 # ffffffffc02061d0 <commands+0x840>
ffffffffc02014a8:	fe7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02014ac:	00005697          	auipc	a3,0x5
ffffffffc02014b0:	e8468693          	addi	a3,a3,-380 # ffffffffc0206330 <commands+0x9a0>
ffffffffc02014b4:	00005617          	auipc	a2,0x5
ffffffffc02014b8:	d0460613          	addi	a2,a2,-764 # ffffffffc02061b8 <commands+0x828>
ffffffffc02014bc:	0f400593          	li	a1,244
ffffffffc02014c0:	00005517          	auipc	a0,0x5
ffffffffc02014c4:	d1050513          	addi	a0,a0,-752 # ffffffffc02061d0 <commands+0x840>
ffffffffc02014c8:	fc7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02014cc:	00005697          	auipc	a3,0x5
ffffffffc02014d0:	d7c68693          	addi	a3,a3,-644 # ffffffffc0206248 <commands+0x8b8>
ffffffffc02014d4:	00005617          	auipc	a2,0x5
ffffffffc02014d8:	ce460613          	addi	a2,a2,-796 # ffffffffc02061b8 <commands+0x828>
ffffffffc02014dc:	0f200593          	li	a1,242
ffffffffc02014e0:	00005517          	auipc	a0,0x5
ffffffffc02014e4:	cf050513          	addi	a0,a0,-784 # ffffffffc02061d0 <commands+0x840>
ffffffffc02014e8:	fa7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02014ec:	00005697          	auipc	a3,0x5
ffffffffc02014f0:	d3c68693          	addi	a3,a3,-708 # ffffffffc0206228 <commands+0x898>
ffffffffc02014f4:	00005617          	auipc	a2,0x5
ffffffffc02014f8:	cc460613          	addi	a2,a2,-828 # ffffffffc02061b8 <commands+0x828>
ffffffffc02014fc:	0f100593          	li	a1,241
ffffffffc0201500:	00005517          	auipc	a0,0x5
ffffffffc0201504:	cd050513          	addi	a0,a0,-816 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201508:	f87fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020150c:	00005697          	auipc	a3,0x5
ffffffffc0201510:	d3c68693          	addi	a3,a3,-708 # ffffffffc0206248 <commands+0x8b8>
ffffffffc0201514:	00005617          	auipc	a2,0x5
ffffffffc0201518:	ca460613          	addi	a2,a2,-860 # ffffffffc02061b8 <commands+0x828>
ffffffffc020151c:	0d900593          	li	a1,217
ffffffffc0201520:	00005517          	auipc	a0,0x5
ffffffffc0201524:	cb050513          	addi	a0,a0,-848 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201528:	f67fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(count == 0);
ffffffffc020152c:	00005697          	auipc	a3,0x5
ffffffffc0201530:	fc468693          	addi	a3,a3,-60 # ffffffffc02064f0 <commands+0xb60>
ffffffffc0201534:	00005617          	auipc	a2,0x5
ffffffffc0201538:	c8460613          	addi	a2,a2,-892 # ffffffffc02061b8 <commands+0x828>
ffffffffc020153c:	14600593          	li	a1,326
ffffffffc0201540:	00005517          	auipc	a0,0x5
ffffffffc0201544:	c9050513          	addi	a0,a0,-880 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201548:	f47fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc020154c:	00005697          	auipc	a3,0x5
ffffffffc0201550:	e4468693          	addi	a3,a3,-444 # ffffffffc0206390 <commands+0xa00>
ffffffffc0201554:	00005617          	auipc	a2,0x5
ffffffffc0201558:	c6460613          	addi	a2,a2,-924 # ffffffffc02061b8 <commands+0x828>
ffffffffc020155c:	13a00593          	li	a1,314
ffffffffc0201560:	00005517          	auipc	a0,0x5
ffffffffc0201564:	c7050513          	addi	a0,a0,-912 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201568:	f27fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc020156c:	00005697          	auipc	a3,0x5
ffffffffc0201570:	dc468693          	addi	a3,a3,-572 # ffffffffc0206330 <commands+0x9a0>
ffffffffc0201574:	00005617          	auipc	a2,0x5
ffffffffc0201578:	c4460613          	addi	a2,a2,-956 # ffffffffc02061b8 <commands+0x828>
ffffffffc020157c:	13800593          	li	a1,312
ffffffffc0201580:	00005517          	auipc	a0,0x5
ffffffffc0201584:	c5050513          	addi	a0,a0,-944 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201588:	f07fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc020158c:	00005697          	auipc	a3,0x5
ffffffffc0201590:	d6468693          	addi	a3,a3,-668 # ffffffffc02062f0 <commands+0x960>
ffffffffc0201594:	00005617          	auipc	a2,0x5
ffffffffc0201598:	c2460613          	addi	a2,a2,-988 # ffffffffc02061b8 <commands+0x828>
ffffffffc020159c:	0df00593          	li	a1,223
ffffffffc02015a0:	00005517          	auipc	a0,0x5
ffffffffc02015a4:	c3050513          	addi	a0,a0,-976 # ffffffffc02061d0 <commands+0x840>
ffffffffc02015a8:	ee7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02015ac:	00005697          	auipc	a3,0x5
ffffffffc02015b0:	f0468693          	addi	a3,a3,-252 # ffffffffc02064b0 <commands+0xb20>
ffffffffc02015b4:	00005617          	auipc	a2,0x5
ffffffffc02015b8:	c0460613          	addi	a2,a2,-1020 # ffffffffc02061b8 <commands+0x828>
ffffffffc02015bc:	13200593          	li	a1,306
ffffffffc02015c0:	00005517          	auipc	a0,0x5
ffffffffc02015c4:	c1050513          	addi	a0,a0,-1008 # ffffffffc02061d0 <commands+0x840>
ffffffffc02015c8:	ec7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02015cc:	00005697          	auipc	a3,0x5
ffffffffc02015d0:	ec468693          	addi	a3,a3,-316 # ffffffffc0206490 <commands+0xb00>
ffffffffc02015d4:	00005617          	auipc	a2,0x5
ffffffffc02015d8:	be460613          	addi	a2,a2,-1052 # ffffffffc02061b8 <commands+0x828>
ffffffffc02015dc:	13000593          	li	a1,304
ffffffffc02015e0:	00005517          	auipc	a0,0x5
ffffffffc02015e4:	bf050513          	addi	a0,a0,-1040 # ffffffffc02061d0 <commands+0x840>
ffffffffc02015e8:	ea7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02015ec:	00005697          	auipc	a3,0x5
ffffffffc02015f0:	e7c68693          	addi	a3,a3,-388 # ffffffffc0206468 <commands+0xad8>
ffffffffc02015f4:	00005617          	auipc	a2,0x5
ffffffffc02015f8:	bc460613          	addi	a2,a2,-1084 # ffffffffc02061b8 <commands+0x828>
ffffffffc02015fc:	12e00593          	li	a1,302
ffffffffc0201600:	00005517          	auipc	a0,0x5
ffffffffc0201604:	bd050513          	addi	a0,a0,-1072 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201608:	e87fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc020160c:	00005697          	auipc	a3,0x5
ffffffffc0201610:	e3468693          	addi	a3,a3,-460 # ffffffffc0206440 <commands+0xab0>
ffffffffc0201614:	00005617          	auipc	a2,0x5
ffffffffc0201618:	ba460613          	addi	a2,a2,-1116 # ffffffffc02061b8 <commands+0x828>
ffffffffc020161c:	12d00593          	li	a1,301
ffffffffc0201620:	00005517          	auipc	a0,0x5
ffffffffc0201624:	bb050513          	addi	a0,a0,-1104 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201628:	e67fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 + 2 == p1);
ffffffffc020162c:	00005697          	auipc	a3,0x5
ffffffffc0201630:	e0468693          	addi	a3,a3,-508 # ffffffffc0206430 <commands+0xaa0>
ffffffffc0201634:	00005617          	auipc	a2,0x5
ffffffffc0201638:	b8460613          	addi	a2,a2,-1148 # ffffffffc02061b8 <commands+0x828>
ffffffffc020163c:	12800593          	li	a1,296
ffffffffc0201640:	00005517          	auipc	a0,0x5
ffffffffc0201644:	b9050513          	addi	a0,a0,-1136 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201648:	e47fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc020164c:	00005697          	auipc	a3,0x5
ffffffffc0201650:	ce468693          	addi	a3,a3,-796 # ffffffffc0206330 <commands+0x9a0>
ffffffffc0201654:	00005617          	auipc	a2,0x5
ffffffffc0201658:	b6460613          	addi	a2,a2,-1180 # ffffffffc02061b8 <commands+0x828>
ffffffffc020165c:	12700593          	li	a1,295
ffffffffc0201660:	00005517          	auipc	a0,0x5
ffffffffc0201664:	b7050513          	addi	a0,a0,-1168 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201668:	e27fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc020166c:	00005697          	auipc	a3,0x5
ffffffffc0201670:	da468693          	addi	a3,a3,-604 # ffffffffc0206410 <commands+0xa80>
ffffffffc0201674:	00005617          	auipc	a2,0x5
ffffffffc0201678:	b4460613          	addi	a2,a2,-1212 # ffffffffc02061b8 <commands+0x828>
ffffffffc020167c:	12600593          	li	a1,294
ffffffffc0201680:	00005517          	auipc	a0,0x5
ffffffffc0201684:	b5050513          	addi	a0,a0,-1200 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201688:	e07fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc020168c:	00005697          	auipc	a3,0x5
ffffffffc0201690:	d5468693          	addi	a3,a3,-684 # ffffffffc02063e0 <commands+0xa50>
ffffffffc0201694:	00005617          	auipc	a2,0x5
ffffffffc0201698:	b2460613          	addi	a2,a2,-1244 # ffffffffc02061b8 <commands+0x828>
ffffffffc020169c:	12500593          	li	a1,293
ffffffffc02016a0:	00005517          	auipc	a0,0x5
ffffffffc02016a4:	b3050513          	addi	a0,a0,-1232 # ffffffffc02061d0 <commands+0x840>
ffffffffc02016a8:	de7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02016ac:	00005697          	auipc	a3,0x5
ffffffffc02016b0:	d1c68693          	addi	a3,a3,-740 # ffffffffc02063c8 <commands+0xa38>
ffffffffc02016b4:	00005617          	auipc	a2,0x5
ffffffffc02016b8:	b0460613          	addi	a2,a2,-1276 # ffffffffc02061b8 <commands+0x828>
ffffffffc02016bc:	12400593          	li	a1,292
ffffffffc02016c0:	00005517          	auipc	a0,0x5
ffffffffc02016c4:	b1050513          	addi	a0,a0,-1264 # ffffffffc02061d0 <commands+0x840>
ffffffffc02016c8:	dc7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02016cc:	00005697          	auipc	a3,0x5
ffffffffc02016d0:	c6468693          	addi	a3,a3,-924 # ffffffffc0206330 <commands+0x9a0>
ffffffffc02016d4:	00005617          	auipc	a2,0x5
ffffffffc02016d8:	ae460613          	addi	a2,a2,-1308 # ffffffffc02061b8 <commands+0x828>
ffffffffc02016dc:	11e00593          	li	a1,286
ffffffffc02016e0:	00005517          	auipc	a0,0x5
ffffffffc02016e4:	af050513          	addi	a0,a0,-1296 # ffffffffc02061d0 <commands+0x840>
ffffffffc02016e8:	da7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!PageProperty(p0));
ffffffffc02016ec:	00005697          	auipc	a3,0x5
ffffffffc02016f0:	cc468693          	addi	a3,a3,-828 # ffffffffc02063b0 <commands+0xa20>
ffffffffc02016f4:	00005617          	auipc	a2,0x5
ffffffffc02016f8:	ac460613          	addi	a2,a2,-1340 # ffffffffc02061b8 <commands+0x828>
ffffffffc02016fc:	11900593          	li	a1,281
ffffffffc0201700:	00005517          	auipc	a0,0x5
ffffffffc0201704:	ad050513          	addi	a0,a0,-1328 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201708:	d87fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc020170c:	00005697          	auipc	a3,0x5
ffffffffc0201710:	dc468693          	addi	a3,a3,-572 # ffffffffc02064d0 <commands+0xb40>
ffffffffc0201714:	00005617          	auipc	a2,0x5
ffffffffc0201718:	aa460613          	addi	a2,a2,-1372 # ffffffffc02061b8 <commands+0x828>
ffffffffc020171c:	13700593          	li	a1,311
ffffffffc0201720:	00005517          	auipc	a0,0x5
ffffffffc0201724:	ab050513          	addi	a0,a0,-1360 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201728:	d67fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == 0);
ffffffffc020172c:	00005697          	auipc	a3,0x5
ffffffffc0201730:	dd468693          	addi	a3,a3,-556 # ffffffffc0206500 <commands+0xb70>
ffffffffc0201734:	00005617          	auipc	a2,0x5
ffffffffc0201738:	a8460613          	addi	a2,a2,-1404 # ffffffffc02061b8 <commands+0x828>
ffffffffc020173c:	14700593          	li	a1,327
ffffffffc0201740:	00005517          	auipc	a0,0x5
ffffffffc0201744:	a9050513          	addi	a0,a0,-1392 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201748:	d47fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == nr_free_pages());
ffffffffc020174c:	00005697          	auipc	a3,0x5
ffffffffc0201750:	a9c68693          	addi	a3,a3,-1380 # ffffffffc02061e8 <commands+0x858>
ffffffffc0201754:	00005617          	auipc	a2,0x5
ffffffffc0201758:	a6460613          	addi	a2,a2,-1436 # ffffffffc02061b8 <commands+0x828>
ffffffffc020175c:	11300593          	li	a1,275
ffffffffc0201760:	00005517          	auipc	a0,0x5
ffffffffc0201764:	a7050513          	addi	a0,a0,-1424 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201768:	d27fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc020176c:	00005697          	auipc	a3,0x5
ffffffffc0201770:	abc68693          	addi	a3,a3,-1348 # ffffffffc0206228 <commands+0x898>
ffffffffc0201774:	00005617          	auipc	a2,0x5
ffffffffc0201778:	a4460613          	addi	a2,a2,-1468 # ffffffffc02061b8 <commands+0x828>
ffffffffc020177c:	0d800593          	li	a1,216
ffffffffc0201780:	00005517          	auipc	a0,0x5
ffffffffc0201784:	a5050513          	addi	a0,a0,-1456 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201788:	d07fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020178c <default_free_pages>:
{
ffffffffc020178c:	1141                	addi	sp,sp,-16
ffffffffc020178e:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201790:	14058463          	beqz	a1,ffffffffc02018d8 <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc0201794:	00659693          	slli	a3,a1,0x6
ffffffffc0201798:	96aa                	add	a3,a3,a0
ffffffffc020179a:	87aa                	mv	a5,a0
ffffffffc020179c:	02d50263          	beq	a0,a3,ffffffffc02017c0 <default_free_pages+0x34>
ffffffffc02017a0:	6798                	ld	a4,8(a5)
ffffffffc02017a2:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02017a4:	10071a63          	bnez	a4,ffffffffc02018b8 <default_free_pages+0x12c>
ffffffffc02017a8:	6798                	ld	a4,8(a5)
ffffffffc02017aa:	8b09                	andi	a4,a4,2
ffffffffc02017ac:	10071663          	bnez	a4,ffffffffc02018b8 <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc02017b0:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc02017b4:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02017b8:	04078793          	addi	a5,a5,64
ffffffffc02017bc:	fed792e3          	bne	a5,a3,ffffffffc02017a0 <default_free_pages+0x14>
    base->property = n;
ffffffffc02017c0:	2581                	sext.w	a1,a1
ffffffffc02017c2:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02017c4:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02017c8:	4789                	li	a5,2
ffffffffc02017ca:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02017ce:	000a5697          	auipc	a3,0xa5
ffffffffc02017d2:	5da68693          	addi	a3,a3,1498 # ffffffffc02a6da8 <free_area>
ffffffffc02017d6:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02017d8:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02017da:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02017de:	9db9                	addw	a1,a1,a4
ffffffffc02017e0:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02017e2:	0ad78463          	beq	a5,a3,ffffffffc020188a <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc02017e6:	fe878713          	addi	a4,a5,-24
ffffffffc02017ea:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02017ee:	4581                	li	a1,0
            if (base < page)
ffffffffc02017f0:	00e56a63          	bltu	a0,a4,ffffffffc0201804 <default_free_pages+0x78>
    return listelm->next;
ffffffffc02017f4:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02017f6:	04d70c63          	beq	a4,a3,ffffffffc020184e <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc02017fa:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02017fc:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc0201800:	fee57ae3          	bgeu	a0,a4,ffffffffc02017f4 <default_free_pages+0x68>
ffffffffc0201804:	c199                	beqz	a1,ffffffffc020180a <default_free_pages+0x7e>
ffffffffc0201806:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020180a:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc020180c:	e390                	sd	a2,0(a5)
ffffffffc020180e:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201810:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201812:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc0201814:	00d70d63          	beq	a4,a3,ffffffffc020182e <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc0201818:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc020181c:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc0201820:	02059813          	slli	a6,a1,0x20
ffffffffc0201824:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201828:	97b2                	add	a5,a5,a2
ffffffffc020182a:	02f50c63          	beq	a0,a5,ffffffffc0201862 <default_free_pages+0xd6>
    return listelm->next;
ffffffffc020182e:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc0201830:	00d78c63          	beq	a5,a3,ffffffffc0201848 <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc0201834:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0201836:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc020183a:	02061593          	slli	a1,a2,0x20
ffffffffc020183e:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201842:	972a                	add	a4,a4,a0
ffffffffc0201844:	04e68a63          	beq	a3,a4,ffffffffc0201898 <default_free_pages+0x10c>
}
ffffffffc0201848:	60a2                	ld	ra,8(sp)
ffffffffc020184a:	0141                	addi	sp,sp,16
ffffffffc020184c:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020184e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201850:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201852:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201854:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201856:	02d70763          	beq	a4,a3,ffffffffc0201884 <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc020185a:	8832                	mv	a6,a2
ffffffffc020185c:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc020185e:	87ba                	mv	a5,a4
ffffffffc0201860:	bf71                	j	ffffffffc02017fc <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0201862:	491c                	lw	a5,16(a0)
ffffffffc0201864:	9dbd                	addw	a1,a1,a5
ffffffffc0201866:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020186a:	57f5                	li	a5,-3
ffffffffc020186c:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201870:	01853803          	ld	a6,24(a0)
ffffffffc0201874:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc0201876:	8532                	mv	a0,a2
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201878:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc020187c:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc020187e:	0105b023          	sd	a6,0(a1)
ffffffffc0201882:	b77d                	j	ffffffffc0201830 <default_free_pages+0xa4>
ffffffffc0201884:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201886:	873e                	mv	a4,a5
ffffffffc0201888:	bf41                	j	ffffffffc0201818 <default_free_pages+0x8c>
}
ffffffffc020188a:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc020188c:	e390                	sd	a2,0(a5)
ffffffffc020188e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201890:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201892:	ed1c                	sd	a5,24(a0)
ffffffffc0201894:	0141                	addi	sp,sp,16
ffffffffc0201896:	8082                	ret
            base->property += p->property;
ffffffffc0201898:	ff87a703          	lw	a4,-8(a5)
ffffffffc020189c:	ff078693          	addi	a3,a5,-16
ffffffffc02018a0:	9e39                	addw	a2,a2,a4
ffffffffc02018a2:	c910                	sw	a2,16(a0)
ffffffffc02018a4:	5775                	li	a4,-3
ffffffffc02018a6:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02018aa:	6398                	ld	a4,0(a5)
ffffffffc02018ac:	679c                	ld	a5,8(a5)
}
ffffffffc02018ae:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02018b0:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc02018b2:	e398                	sd	a4,0(a5)
ffffffffc02018b4:	0141                	addi	sp,sp,16
ffffffffc02018b6:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02018b8:	00005697          	auipc	a3,0x5
ffffffffc02018bc:	c6068693          	addi	a3,a3,-928 # ffffffffc0206518 <commands+0xb88>
ffffffffc02018c0:	00005617          	auipc	a2,0x5
ffffffffc02018c4:	8f860613          	addi	a2,a2,-1800 # ffffffffc02061b8 <commands+0x828>
ffffffffc02018c8:	09400593          	li	a1,148
ffffffffc02018cc:	00005517          	auipc	a0,0x5
ffffffffc02018d0:	90450513          	addi	a0,a0,-1788 # ffffffffc02061d0 <commands+0x840>
ffffffffc02018d4:	bbbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc02018d8:	00005697          	auipc	a3,0x5
ffffffffc02018dc:	c3868693          	addi	a3,a3,-968 # ffffffffc0206510 <commands+0xb80>
ffffffffc02018e0:	00005617          	auipc	a2,0x5
ffffffffc02018e4:	8d860613          	addi	a2,a2,-1832 # ffffffffc02061b8 <commands+0x828>
ffffffffc02018e8:	09000593          	li	a1,144
ffffffffc02018ec:	00005517          	auipc	a0,0x5
ffffffffc02018f0:	8e450513          	addi	a0,a0,-1820 # ffffffffc02061d0 <commands+0x840>
ffffffffc02018f4:	b9bfe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02018f8 <default_alloc_pages>:
    assert(n > 0);
ffffffffc02018f8:	c941                	beqz	a0,ffffffffc0201988 <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc02018fa:	000a5597          	auipc	a1,0xa5
ffffffffc02018fe:	4ae58593          	addi	a1,a1,1198 # ffffffffc02a6da8 <free_area>
ffffffffc0201902:	0105a803          	lw	a6,16(a1)
ffffffffc0201906:	872a                	mv	a4,a0
ffffffffc0201908:	02081793          	slli	a5,a6,0x20
ffffffffc020190c:	9381                	srli	a5,a5,0x20
ffffffffc020190e:	00a7ee63          	bltu	a5,a0,ffffffffc020192a <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0201912:	87ae                	mv	a5,a1
ffffffffc0201914:	a801                	j	ffffffffc0201924 <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc0201916:	ff87a683          	lw	a3,-8(a5)
ffffffffc020191a:	02069613          	slli	a2,a3,0x20
ffffffffc020191e:	9201                	srli	a2,a2,0x20
ffffffffc0201920:	00e67763          	bgeu	a2,a4,ffffffffc020192e <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0201924:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc0201926:	feb798e3          	bne	a5,a1,ffffffffc0201916 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc020192a:	4501                	li	a0,0
}
ffffffffc020192c:	8082                	ret
    return listelm->prev;
ffffffffc020192e:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201932:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc0201936:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc020193a:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc020193e:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0201942:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc0201946:	02c77863          	bgeu	a4,a2,ffffffffc0201976 <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc020194a:	071a                	slli	a4,a4,0x6
ffffffffc020194c:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc020194e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201952:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201954:	00870613          	addi	a2,a4,8
ffffffffc0201958:	4689                	li	a3,2
ffffffffc020195a:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc020195e:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201962:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc0201966:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc020196a:	e290                	sd	a2,0(a3)
ffffffffc020196c:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0201970:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0201972:	01173c23          	sd	a7,24(a4)
ffffffffc0201976:	41c8083b          	subw	a6,a6,t3
ffffffffc020197a:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020197e:	5775                	li	a4,-3
ffffffffc0201980:	17c1                	addi	a5,a5,-16
ffffffffc0201982:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc0201986:	8082                	ret
{
ffffffffc0201988:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc020198a:	00005697          	auipc	a3,0x5
ffffffffc020198e:	b8668693          	addi	a3,a3,-1146 # ffffffffc0206510 <commands+0xb80>
ffffffffc0201992:	00005617          	auipc	a2,0x5
ffffffffc0201996:	82660613          	addi	a2,a2,-2010 # ffffffffc02061b8 <commands+0x828>
ffffffffc020199a:	06c00593          	li	a1,108
ffffffffc020199e:	00005517          	auipc	a0,0x5
ffffffffc02019a2:	83250513          	addi	a0,a0,-1998 # ffffffffc02061d0 <commands+0x840>
{
ffffffffc02019a6:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02019a8:	ae7fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02019ac <default_init_memmap>:
{
ffffffffc02019ac:	1141                	addi	sp,sp,-16
ffffffffc02019ae:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02019b0:	c5f1                	beqz	a1,ffffffffc0201a7c <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc02019b2:	00659693          	slli	a3,a1,0x6
ffffffffc02019b6:	96aa                	add	a3,a3,a0
ffffffffc02019b8:	87aa                	mv	a5,a0
ffffffffc02019ba:	00d50f63          	beq	a0,a3,ffffffffc02019d8 <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02019be:	6798                	ld	a4,8(a5)
ffffffffc02019c0:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02019c2:	cf49                	beqz	a4,ffffffffc0201a5c <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02019c4:	0007a823          	sw	zero,16(a5)
ffffffffc02019c8:	0007b423          	sd	zero,8(a5)
ffffffffc02019cc:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02019d0:	04078793          	addi	a5,a5,64
ffffffffc02019d4:	fed795e3          	bne	a5,a3,ffffffffc02019be <default_init_memmap+0x12>
    base->property = n;
ffffffffc02019d8:	2581                	sext.w	a1,a1
ffffffffc02019da:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02019dc:	4789                	li	a5,2
ffffffffc02019de:	00850713          	addi	a4,a0,8
ffffffffc02019e2:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02019e6:	000a5697          	auipc	a3,0xa5
ffffffffc02019ea:	3c268693          	addi	a3,a3,962 # ffffffffc02a6da8 <free_area>
ffffffffc02019ee:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02019f0:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02019f2:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02019f6:	9db9                	addw	a1,a1,a4
ffffffffc02019f8:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02019fa:	04d78a63          	beq	a5,a3,ffffffffc0201a4e <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc02019fe:	fe878713          	addi	a4,a5,-24
ffffffffc0201a02:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc0201a06:	4581                	li	a1,0
            if (base < page)
ffffffffc0201a08:	00e56a63          	bltu	a0,a4,ffffffffc0201a1c <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0201a0c:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc0201a0e:	02d70263          	beq	a4,a3,ffffffffc0201a32 <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc0201a12:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc0201a14:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc0201a18:	fee57ae3          	bgeu	a0,a4,ffffffffc0201a0c <default_init_memmap+0x60>
ffffffffc0201a1c:	c199                	beqz	a1,ffffffffc0201a22 <default_init_memmap+0x76>
ffffffffc0201a1e:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201a22:	6398                	ld	a4,0(a5)
}
ffffffffc0201a24:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201a26:	e390                	sd	a2,0(a5)
ffffffffc0201a28:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201a2a:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201a2c:	ed18                	sd	a4,24(a0)
ffffffffc0201a2e:	0141                	addi	sp,sp,16
ffffffffc0201a30:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201a32:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a34:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201a36:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201a38:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201a3a:	00d70663          	beq	a4,a3,ffffffffc0201a46 <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0201a3e:	8832                	mv	a6,a2
ffffffffc0201a40:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201a42:	87ba                	mv	a5,a4
ffffffffc0201a44:	bfc1                	j	ffffffffc0201a14 <default_init_memmap+0x68>
}
ffffffffc0201a46:	60a2                	ld	ra,8(sp)
ffffffffc0201a48:	e290                	sd	a2,0(a3)
ffffffffc0201a4a:	0141                	addi	sp,sp,16
ffffffffc0201a4c:	8082                	ret
ffffffffc0201a4e:	60a2                	ld	ra,8(sp)
ffffffffc0201a50:	e390                	sd	a2,0(a5)
ffffffffc0201a52:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a54:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201a56:	ed1c                	sd	a5,24(a0)
ffffffffc0201a58:	0141                	addi	sp,sp,16
ffffffffc0201a5a:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201a5c:	00005697          	auipc	a3,0x5
ffffffffc0201a60:	ae468693          	addi	a3,a3,-1308 # ffffffffc0206540 <commands+0xbb0>
ffffffffc0201a64:	00004617          	auipc	a2,0x4
ffffffffc0201a68:	75460613          	addi	a2,a2,1876 # ffffffffc02061b8 <commands+0x828>
ffffffffc0201a6c:	04b00593          	li	a1,75
ffffffffc0201a70:	00004517          	auipc	a0,0x4
ffffffffc0201a74:	76050513          	addi	a0,a0,1888 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201a78:	a17fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc0201a7c:	00005697          	auipc	a3,0x5
ffffffffc0201a80:	a9468693          	addi	a3,a3,-1388 # ffffffffc0206510 <commands+0xb80>
ffffffffc0201a84:	00004617          	auipc	a2,0x4
ffffffffc0201a88:	73460613          	addi	a2,a2,1844 # ffffffffc02061b8 <commands+0x828>
ffffffffc0201a8c:	04700593          	li	a1,71
ffffffffc0201a90:	00004517          	auipc	a0,0x4
ffffffffc0201a94:	74050513          	addi	a0,a0,1856 # ffffffffc02061d0 <commands+0x840>
ffffffffc0201a98:	9f7fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201a9c <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201a9c:	c94d                	beqz	a0,ffffffffc0201b4e <slob_free+0xb2>
{
ffffffffc0201a9e:	1141                	addi	sp,sp,-16
ffffffffc0201aa0:	e022                	sd	s0,0(sp)
ffffffffc0201aa2:	e406                	sd	ra,8(sp)
ffffffffc0201aa4:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201aa6:	e9c1                	bnez	a1,ffffffffc0201b36 <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201aa8:	100027f3          	csrr	a5,sstatus
ffffffffc0201aac:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201aae:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201ab0:	ebd9                	bnez	a5,ffffffffc0201b46 <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201ab2:	000a5617          	auipc	a2,0xa5
ffffffffc0201ab6:	ee660613          	addi	a2,a2,-282 # ffffffffc02a6998 <slobfree>
ffffffffc0201aba:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201abc:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201abe:	679c                	ld	a5,8(a5)
ffffffffc0201ac0:	02877a63          	bgeu	a4,s0,ffffffffc0201af4 <slob_free+0x58>
ffffffffc0201ac4:	00f46463          	bltu	s0,a5,ffffffffc0201acc <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201ac8:	fef76ae3          	bltu	a4,a5,ffffffffc0201abc <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc0201acc:	400c                	lw	a1,0(s0)
ffffffffc0201ace:	00459693          	slli	a3,a1,0x4
ffffffffc0201ad2:	96a2                	add	a3,a3,s0
ffffffffc0201ad4:	02d78a63          	beq	a5,a3,ffffffffc0201b08 <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc0201ad8:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc0201ada:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201adc:	00469793          	slli	a5,a3,0x4
ffffffffc0201ae0:	97ba                	add	a5,a5,a4
ffffffffc0201ae2:	02f40e63          	beq	s0,a5,ffffffffc0201b1e <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc0201ae6:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc0201ae8:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc0201aea:	e129                	bnez	a0,ffffffffc0201b2c <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc0201aec:	60a2                	ld	ra,8(sp)
ffffffffc0201aee:	6402                	ld	s0,0(sp)
ffffffffc0201af0:	0141                	addi	sp,sp,16
ffffffffc0201af2:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201af4:	fcf764e3          	bltu	a4,a5,ffffffffc0201abc <slob_free+0x20>
ffffffffc0201af8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201abc <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc0201afc:	400c                	lw	a1,0(s0)
ffffffffc0201afe:	00459693          	slli	a3,a1,0x4
ffffffffc0201b02:	96a2                	add	a3,a3,s0
ffffffffc0201b04:	fcd79ae3          	bne	a5,a3,ffffffffc0201ad8 <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc0201b08:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc0201b0a:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc0201b0c:	9db5                	addw	a1,a1,a3
ffffffffc0201b0e:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc0201b10:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0201b12:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201b14:	00469793          	slli	a5,a3,0x4
ffffffffc0201b18:	97ba                	add	a5,a5,a4
ffffffffc0201b1a:	fcf416e3          	bne	s0,a5,ffffffffc0201ae6 <slob_free+0x4a>
		cur->units += b->units;
ffffffffc0201b1e:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc0201b20:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc0201b22:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc0201b24:	9ebd                	addw	a3,a3,a5
ffffffffc0201b26:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc0201b28:	e70c                	sd	a1,8(a4)
ffffffffc0201b2a:	d169                	beqz	a0,ffffffffc0201aec <slob_free+0x50>
}
ffffffffc0201b2c:	6402                	ld	s0,0(sp)
ffffffffc0201b2e:	60a2                	ld	ra,8(sp)
ffffffffc0201b30:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201b32:	e7dfe06f          	j	ffffffffc02009ae <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc0201b36:	25bd                	addiw	a1,a1,15
ffffffffc0201b38:	8191                	srli	a1,a1,0x4
ffffffffc0201b3a:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b3c:	100027f3          	csrr	a5,sstatus
ffffffffc0201b40:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201b42:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b44:	d7bd                	beqz	a5,ffffffffc0201ab2 <slob_free+0x16>
        intr_disable();
ffffffffc0201b46:	e6ffe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201b4a:	4505                	li	a0,1
ffffffffc0201b4c:	b79d                	j	ffffffffc0201ab2 <slob_free+0x16>
ffffffffc0201b4e:	8082                	ret

ffffffffc0201b50 <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b50:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b52:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b54:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b58:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b5a:	352000ef          	jal	ra,ffffffffc0201eac <alloc_pages>
	if (!page)
ffffffffc0201b5e:	c91d                	beqz	a0,ffffffffc0201b94 <__slob_get_free_pages.constprop.0+0x44>
    return page - pages + nbase;
ffffffffc0201b60:	000a9697          	auipc	a3,0xa9
ffffffffc0201b64:	2c06b683          	ld	a3,704(a3) # ffffffffc02aae20 <pages>
ffffffffc0201b68:	8d15                	sub	a0,a0,a3
ffffffffc0201b6a:	8519                	srai	a0,a0,0x6
ffffffffc0201b6c:	00006697          	auipc	a3,0x6
ffffffffc0201b70:	d1c6b683          	ld	a3,-740(a3) # ffffffffc0207888 <nbase>
ffffffffc0201b74:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201b76:	00c51793          	slli	a5,a0,0xc
ffffffffc0201b7a:	83b1                	srli	a5,a5,0xc
ffffffffc0201b7c:	000a9717          	auipc	a4,0xa9
ffffffffc0201b80:	29c73703          	ld	a4,668(a4) # ffffffffc02aae18 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201b84:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201b86:	00e7fa63          	bgeu	a5,a4,ffffffffc0201b9a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201b8a:	000a9697          	auipc	a3,0xa9
ffffffffc0201b8e:	2a66b683          	ld	a3,678(a3) # ffffffffc02aae30 <va_pa_offset>
ffffffffc0201b92:	9536                	add	a0,a0,a3
}
ffffffffc0201b94:	60a2                	ld	ra,8(sp)
ffffffffc0201b96:	0141                	addi	sp,sp,16
ffffffffc0201b98:	8082                	ret
ffffffffc0201b9a:	86aa                	mv	a3,a0
ffffffffc0201b9c:	00005617          	auipc	a2,0x5
ffffffffc0201ba0:	a0460613          	addi	a2,a2,-1532 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0201ba4:	07100593          	li	a1,113
ffffffffc0201ba8:	00005517          	auipc	a0,0x5
ffffffffc0201bac:	a2050513          	addi	a0,a0,-1504 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0201bb0:	8dffe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201bb4 <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201bb4:	1101                	addi	sp,sp,-32
ffffffffc0201bb6:	ec06                	sd	ra,24(sp)
ffffffffc0201bb8:	e822                	sd	s0,16(sp)
ffffffffc0201bba:	e426                	sd	s1,8(sp)
ffffffffc0201bbc:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201bbe:	01050713          	addi	a4,a0,16
ffffffffc0201bc2:	6785                	lui	a5,0x1
ffffffffc0201bc4:	0cf77363          	bgeu	a4,a5,ffffffffc0201c8a <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201bc8:	00f50493          	addi	s1,a0,15
ffffffffc0201bcc:	8091                	srli	s1,s1,0x4
ffffffffc0201bce:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201bd0:	10002673          	csrr	a2,sstatus
ffffffffc0201bd4:	8a09                	andi	a2,a2,2
ffffffffc0201bd6:	e25d                	bnez	a2,ffffffffc0201c7c <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201bd8:	000a5917          	auipc	s2,0xa5
ffffffffc0201bdc:	dc090913          	addi	s2,s2,-576 # ffffffffc02a6998 <slobfree>
ffffffffc0201be0:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201be4:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201be6:	4398                	lw	a4,0(a5)
ffffffffc0201be8:	08975e63          	bge	a4,s1,ffffffffc0201c84 <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc0201bec:	00f68b63          	beq	a3,a5,ffffffffc0201c02 <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201bf0:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201bf2:	4018                	lw	a4,0(s0)
ffffffffc0201bf4:	02975a63          	bge	a4,s1,ffffffffc0201c28 <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201bf8:	00093683          	ld	a3,0(s2)
ffffffffc0201bfc:	87a2                	mv	a5,s0
ffffffffc0201bfe:	fef699e3          	bne	a3,a5,ffffffffc0201bf0 <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201c02:	ee31                	bnez	a2,ffffffffc0201c5e <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201c04:	4501                	li	a0,0
ffffffffc0201c06:	f4bff0ef          	jal	ra,ffffffffc0201b50 <__slob_get_free_pages.constprop.0>
ffffffffc0201c0a:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201c0c:	cd05                	beqz	a0,ffffffffc0201c44 <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201c0e:	6585                	lui	a1,0x1
ffffffffc0201c10:	e8dff0ef          	jal	ra,ffffffffc0201a9c <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201c14:	10002673          	csrr	a2,sstatus
ffffffffc0201c18:	8a09                	andi	a2,a2,2
ffffffffc0201c1a:	ee05                	bnez	a2,ffffffffc0201c52 <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201c1c:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201c20:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201c22:	4018                	lw	a4,0(s0)
ffffffffc0201c24:	fc974ae3          	blt	a4,s1,ffffffffc0201bf8 <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc0201c28:	04e48763          	beq	s1,a4,ffffffffc0201c76 <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201c2c:	00449693          	slli	a3,s1,0x4
ffffffffc0201c30:	96a2                	add	a3,a3,s0
ffffffffc0201c32:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201c34:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201c36:	9f05                	subw	a4,a4,s1
ffffffffc0201c38:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0201c3a:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0201c3c:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0201c3e:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc0201c42:	e20d                	bnez	a2,ffffffffc0201c64 <slob_alloc.constprop.0+0xb0>
}
ffffffffc0201c44:	60e2                	ld	ra,24(sp)
ffffffffc0201c46:	8522                	mv	a0,s0
ffffffffc0201c48:	6442                	ld	s0,16(sp)
ffffffffc0201c4a:	64a2                	ld	s1,8(sp)
ffffffffc0201c4c:	6902                	ld	s2,0(sp)
ffffffffc0201c4e:	6105                	addi	sp,sp,32
ffffffffc0201c50:	8082                	ret
        intr_disable();
ffffffffc0201c52:	d63fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
			cur = slobfree;
ffffffffc0201c56:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0201c5a:	4605                	li	a2,1
ffffffffc0201c5c:	b7d1                	j	ffffffffc0201c20 <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc0201c5e:	d51fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201c62:	b74d                	j	ffffffffc0201c04 <slob_alloc.constprop.0+0x50>
ffffffffc0201c64:	d4bfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc0201c68:	60e2                	ld	ra,24(sp)
ffffffffc0201c6a:	8522                	mv	a0,s0
ffffffffc0201c6c:	6442                	ld	s0,16(sp)
ffffffffc0201c6e:	64a2                	ld	s1,8(sp)
ffffffffc0201c70:	6902                	ld	s2,0(sp)
ffffffffc0201c72:	6105                	addi	sp,sp,32
ffffffffc0201c74:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201c76:	6418                	ld	a4,8(s0)
ffffffffc0201c78:	e798                	sd	a4,8(a5)
ffffffffc0201c7a:	b7d1                	j	ffffffffc0201c3e <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc0201c7c:	d39fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201c80:	4605                	li	a2,1
ffffffffc0201c82:	bf99                	j	ffffffffc0201bd8 <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201c84:	843e                	mv	s0,a5
ffffffffc0201c86:	87b6                	mv	a5,a3
ffffffffc0201c88:	b745                	j	ffffffffc0201c28 <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201c8a:	00005697          	auipc	a3,0x5
ffffffffc0201c8e:	94e68693          	addi	a3,a3,-1714 # ffffffffc02065d8 <default_pmm_manager+0x70>
ffffffffc0201c92:	00004617          	auipc	a2,0x4
ffffffffc0201c96:	52660613          	addi	a2,a2,1318 # ffffffffc02061b8 <commands+0x828>
ffffffffc0201c9a:	06300593          	li	a1,99
ffffffffc0201c9e:	00005517          	auipc	a0,0x5
ffffffffc0201ca2:	95a50513          	addi	a0,a0,-1702 # ffffffffc02065f8 <default_pmm_manager+0x90>
ffffffffc0201ca6:	fe8fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201caa <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc0201caa:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc0201cac:	00005517          	auipc	a0,0x5
ffffffffc0201cb0:	96450513          	addi	a0,a0,-1692 # ffffffffc0206610 <default_pmm_manager+0xa8>
{
ffffffffc0201cb4:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201cb6:	cdefe0ef          	jal	ra,ffffffffc0200194 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201cba:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201cbc:	00005517          	auipc	a0,0x5
ffffffffc0201cc0:	96c50513          	addi	a0,a0,-1684 # ffffffffc0206628 <default_pmm_manager+0xc0>
}
ffffffffc0201cc4:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201cc6:	ccefe06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0201cca <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc0201cca:	4501                	li	a0,0
ffffffffc0201ccc:	8082                	ret

ffffffffc0201cce <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201cce:	1101                	addi	sp,sp,-32
ffffffffc0201cd0:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cd2:	6905                	lui	s2,0x1
{
ffffffffc0201cd4:	e822                	sd	s0,16(sp)
ffffffffc0201cd6:	ec06                	sd	ra,24(sp)
ffffffffc0201cd8:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cda:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8c31>
{
ffffffffc0201cde:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201ce0:	04a7f963          	bgeu	a5,a0,ffffffffc0201d32 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201ce4:	4561                	li	a0,24
ffffffffc0201ce6:	ecfff0ef          	jal	ra,ffffffffc0201bb4 <slob_alloc.constprop.0>
ffffffffc0201cea:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201cec:	c929                	beqz	a0,ffffffffc0201d3e <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201cee:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201cf2:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201cf4:	00f95763          	bge	s2,a5,ffffffffc0201d02 <kmalloc+0x34>
ffffffffc0201cf8:	6705                	lui	a4,0x1
ffffffffc0201cfa:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201cfc:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc0201cfe:	fef74ee3          	blt	a4,a5,ffffffffc0201cfa <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201d02:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201d04:	e4dff0ef          	jal	ra,ffffffffc0201b50 <__slob_get_free_pages.constprop.0>
ffffffffc0201d08:	e488                	sd	a0,8(s1)
ffffffffc0201d0a:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc0201d0c:	c525                	beqz	a0,ffffffffc0201d74 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201d0e:	100027f3          	csrr	a5,sstatus
ffffffffc0201d12:	8b89                	andi	a5,a5,2
ffffffffc0201d14:	ef8d                	bnez	a5,ffffffffc0201d4e <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201d16:	000a9797          	auipc	a5,0xa9
ffffffffc0201d1a:	0ea78793          	addi	a5,a5,234 # ffffffffc02aae00 <bigblocks>
ffffffffc0201d1e:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201d20:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201d22:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc0201d24:	60e2                	ld	ra,24(sp)
ffffffffc0201d26:	8522                	mv	a0,s0
ffffffffc0201d28:	6442                	ld	s0,16(sp)
ffffffffc0201d2a:	64a2                	ld	s1,8(sp)
ffffffffc0201d2c:	6902                	ld	s2,0(sp)
ffffffffc0201d2e:	6105                	addi	sp,sp,32
ffffffffc0201d30:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0201d32:	0541                	addi	a0,a0,16
ffffffffc0201d34:	e81ff0ef          	jal	ra,ffffffffc0201bb4 <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201d38:	01050413          	addi	s0,a0,16
ffffffffc0201d3c:	f565                	bnez	a0,ffffffffc0201d24 <kmalloc+0x56>
ffffffffc0201d3e:	4401                	li	s0,0
}
ffffffffc0201d40:	60e2                	ld	ra,24(sp)
ffffffffc0201d42:	8522                	mv	a0,s0
ffffffffc0201d44:	6442                	ld	s0,16(sp)
ffffffffc0201d46:	64a2                	ld	s1,8(sp)
ffffffffc0201d48:	6902                	ld	s2,0(sp)
ffffffffc0201d4a:	6105                	addi	sp,sp,32
ffffffffc0201d4c:	8082                	ret
        intr_disable();
ffffffffc0201d4e:	c67fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		bb->next = bigblocks;
ffffffffc0201d52:	000a9797          	auipc	a5,0xa9
ffffffffc0201d56:	0ae78793          	addi	a5,a5,174 # ffffffffc02aae00 <bigblocks>
ffffffffc0201d5a:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201d5c:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201d5e:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0201d60:	c4ffe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
		return bb->pages;
ffffffffc0201d64:	6480                	ld	s0,8(s1)
}
ffffffffc0201d66:	60e2                	ld	ra,24(sp)
ffffffffc0201d68:	64a2                	ld	s1,8(sp)
ffffffffc0201d6a:	8522                	mv	a0,s0
ffffffffc0201d6c:	6442                	ld	s0,16(sp)
ffffffffc0201d6e:	6902                	ld	s2,0(sp)
ffffffffc0201d70:	6105                	addi	sp,sp,32
ffffffffc0201d72:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201d74:	45e1                	li	a1,24
ffffffffc0201d76:	8526                	mv	a0,s1
ffffffffc0201d78:	d25ff0ef          	jal	ra,ffffffffc0201a9c <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201d7c:	b765                	j	ffffffffc0201d24 <kmalloc+0x56>

ffffffffc0201d7e <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201d7e:	c169                	beqz	a0,ffffffffc0201e40 <kfree+0xc2>
{
ffffffffc0201d80:	1101                	addi	sp,sp,-32
ffffffffc0201d82:	e822                	sd	s0,16(sp)
ffffffffc0201d84:	ec06                	sd	ra,24(sp)
ffffffffc0201d86:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201d88:	03451793          	slli	a5,a0,0x34
ffffffffc0201d8c:	842a                	mv	s0,a0
ffffffffc0201d8e:	e3d9                	bnez	a5,ffffffffc0201e14 <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201d90:	100027f3          	csrr	a5,sstatus
ffffffffc0201d94:	8b89                	andi	a5,a5,2
ffffffffc0201d96:	e7d9                	bnez	a5,ffffffffc0201e24 <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d98:	000a9797          	auipc	a5,0xa9
ffffffffc0201d9c:	0687b783          	ld	a5,104(a5) # ffffffffc02aae00 <bigblocks>
    return 0;
ffffffffc0201da0:	4601                	li	a2,0
ffffffffc0201da2:	cbad                	beqz	a5,ffffffffc0201e14 <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201da4:	000a9697          	auipc	a3,0xa9
ffffffffc0201da8:	05c68693          	addi	a3,a3,92 # ffffffffc02aae00 <bigblocks>
ffffffffc0201dac:	a021                	j	ffffffffc0201db4 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201dae:	01048693          	addi	a3,s1,16
ffffffffc0201db2:	c3a5                	beqz	a5,ffffffffc0201e12 <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201db4:	6798                	ld	a4,8(a5)
ffffffffc0201db6:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201db8:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201dba:	fe871ae3          	bne	a4,s0,ffffffffc0201dae <kfree+0x30>
				*last = bb->next;
ffffffffc0201dbe:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201dc0:	ee2d                	bnez	a2,ffffffffc0201e3a <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0201dc2:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201dc6:	4098                	lw	a4,0(s1)
ffffffffc0201dc8:	08f46963          	bltu	s0,a5,ffffffffc0201e5a <kfree+0xdc>
ffffffffc0201dcc:	000a9697          	auipc	a3,0xa9
ffffffffc0201dd0:	0646b683          	ld	a3,100(a3) # ffffffffc02aae30 <va_pa_offset>
ffffffffc0201dd4:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201dd6:	8031                	srli	s0,s0,0xc
ffffffffc0201dd8:	000a9797          	auipc	a5,0xa9
ffffffffc0201ddc:	0407b783          	ld	a5,64(a5) # ffffffffc02aae18 <npage>
ffffffffc0201de0:	06f47163          	bgeu	s0,a5,ffffffffc0201e42 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201de4:	00006517          	auipc	a0,0x6
ffffffffc0201de8:	aa453503          	ld	a0,-1372(a0) # ffffffffc0207888 <nbase>
ffffffffc0201dec:	8c09                	sub	s0,s0,a0
ffffffffc0201dee:	041a                	slli	s0,s0,0x6
	free_pages(kva2page((void *)kva), 1 << order);
ffffffffc0201df0:	000a9517          	auipc	a0,0xa9
ffffffffc0201df4:	03053503          	ld	a0,48(a0) # ffffffffc02aae20 <pages>
ffffffffc0201df8:	4585                	li	a1,1
ffffffffc0201dfa:	9522                	add	a0,a0,s0
ffffffffc0201dfc:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201e00:	0ea000ef          	jal	ra,ffffffffc0201eea <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201e04:	6442                	ld	s0,16(sp)
ffffffffc0201e06:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201e08:	8526                	mv	a0,s1
}
ffffffffc0201e0a:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201e0c:	45e1                	li	a1,24
}
ffffffffc0201e0e:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e10:	b171                	j	ffffffffc0201a9c <slob_free>
ffffffffc0201e12:	e20d                	bnez	a2,ffffffffc0201e34 <kfree+0xb6>
ffffffffc0201e14:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201e18:	6442                	ld	s0,16(sp)
ffffffffc0201e1a:	60e2                	ld	ra,24(sp)
ffffffffc0201e1c:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e1e:	4581                	li	a1,0
}
ffffffffc0201e20:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e22:	b9ad                	j	ffffffffc0201a9c <slob_free>
        intr_disable();
ffffffffc0201e24:	b91fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201e28:	000a9797          	auipc	a5,0xa9
ffffffffc0201e2c:	fd87b783          	ld	a5,-40(a5) # ffffffffc02aae00 <bigblocks>
        return 1;
ffffffffc0201e30:	4605                	li	a2,1
ffffffffc0201e32:	fbad                	bnez	a5,ffffffffc0201da4 <kfree+0x26>
        intr_enable();
ffffffffc0201e34:	b7bfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e38:	bff1                	j	ffffffffc0201e14 <kfree+0x96>
ffffffffc0201e3a:	b75fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e3e:	b751                	j	ffffffffc0201dc2 <kfree+0x44>
ffffffffc0201e40:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201e42:	00005617          	auipc	a2,0x5
ffffffffc0201e46:	82e60613          	addi	a2,a2,-2002 # ffffffffc0206670 <default_pmm_manager+0x108>
ffffffffc0201e4a:	06900593          	li	a1,105
ffffffffc0201e4e:	00004517          	auipc	a0,0x4
ffffffffc0201e52:	77a50513          	addi	a0,a0,1914 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0201e56:	e38fe0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201e5a:	86a2                	mv	a3,s0
ffffffffc0201e5c:	00004617          	auipc	a2,0x4
ffffffffc0201e60:	7ec60613          	addi	a2,a2,2028 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc0201e64:	07700593          	li	a1,119
ffffffffc0201e68:	00004517          	auipc	a0,0x4
ffffffffc0201e6c:	76050513          	addi	a0,a0,1888 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0201e70:	e1efe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e74 <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc0201e74:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0201e76:	00004617          	auipc	a2,0x4
ffffffffc0201e7a:	7fa60613          	addi	a2,a2,2042 # ffffffffc0206670 <default_pmm_manager+0x108>
ffffffffc0201e7e:	06900593          	li	a1,105
ffffffffc0201e82:	00004517          	auipc	a0,0x4
ffffffffc0201e86:	74650513          	addi	a0,a0,1862 # ffffffffc02065c8 <default_pmm_manager+0x60>
pa2page(uintptr_t pa)
ffffffffc0201e8a:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0201e8c:	e02fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e90 <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc0201e90:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc0201e92:	00004617          	auipc	a2,0x4
ffffffffc0201e96:	7fe60613          	addi	a2,a2,2046 # ffffffffc0206690 <default_pmm_manager+0x128>
ffffffffc0201e9a:	07f00593          	li	a1,127
ffffffffc0201e9e:	00004517          	auipc	a0,0x4
ffffffffc0201ea2:	72a50513          	addi	a0,a0,1834 # ffffffffc02065c8 <default_pmm_manager+0x60>
pte2page(pte_t pte)
ffffffffc0201ea6:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc0201ea8:	de6fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201eac <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201eac:	100027f3          	csrr	a5,sstatus
ffffffffc0201eb0:	8b89                	andi	a5,a5,2
ffffffffc0201eb2:	e799                	bnez	a5,ffffffffc0201ec0 <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc0201eb4:	000a9797          	auipc	a5,0xa9
ffffffffc0201eb8:	f747b783          	ld	a5,-140(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0201ebc:	6f9c                	ld	a5,24(a5)
ffffffffc0201ebe:	8782                	jr	a5
{
ffffffffc0201ec0:	1141                	addi	sp,sp,-16
ffffffffc0201ec2:	e406                	sd	ra,8(sp)
ffffffffc0201ec4:	e022                	sd	s0,0(sp)
ffffffffc0201ec6:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201ec8:	aedfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201ecc:	000a9797          	auipc	a5,0xa9
ffffffffc0201ed0:	f5c7b783          	ld	a5,-164(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0201ed4:	6f9c                	ld	a5,24(a5)
ffffffffc0201ed6:	8522                	mv	a0,s0
ffffffffc0201ed8:	9782                	jalr	a5
ffffffffc0201eda:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201edc:	ad3fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc0201ee0:	60a2                	ld	ra,8(sp)
ffffffffc0201ee2:	8522                	mv	a0,s0
ffffffffc0201ee4:	6402                	ld	s0,0(sp)
ffffffffc0201ee6:	0141                	addi	sp,sp,16
ffffffffc0201ee8:	8082                	ret

ffffffffc0201eea <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201eea:	100027f3          	csrr	a5,sstatus
ffffffffc0201eee:	8b89                	andi	a5,a5,2
ffffffffc0201ef0:	e799                	bnez	a5,ffffffffc0201efe <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201ef2:	000a9797          	auipc	a5,0xa9
ffffffffc0201ef6:	f367b783          	ld	a5,-202(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0201efa:	739c                	ld	a5,32(a5)
ffffffffc0201efc:	8782                	jr	a5
{
ffffffffc0201efe:	1101                	addi	sp,sp,-32
ffffffffc0201f00:	ec06                	sd	ra,24(sp)
ffffffffc0201f02:	e822                	sd	s0,16(sp)
ffffffffc0201f04:	e426                	sd	s1,8(sp)
ffffffffc0201f06:	842a                	mv	s0,a0
ffffffffc0201f08:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0201f0a:	aabfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201f0e:	000a9797          	auipc	a5,0xa9
ffffffffc0201f12:	f1a7b783          	ld	a5,-230(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0201f16:	739c                	ld	a5,32(a5)
ffffffffc0201f18:	85a6                	mv	a1,s1
ffffffffc0201f1a:	8522                	mv	a0,s0
ffffffffc0201f1c:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201f1e:	6442                	ld	s0,16(sp)
ffffffffc0201f20:	60e2                	ld	ra,24(sp)
ffffffffc0201f22:	64a2                	ld	s1,8(sp)
ffffffffc0201f24:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201f26:	a89fe06f          	j	ffffffffc02009ae <intr_enable>

ffffffffc0201f2a <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201f2a:	100027f3          	csrr	a5,sstatus
ffffffffc0201f2e:	8b89                	andi	a5,a5,2
ffffffffc0201f30:	e799                	bnez	a5,ffffffffc0201f3e <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201f32:	000a9797          	auipc	a5,0xa9
ffffffffc0201f36:	ef67b783          	ld	a5,-266(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0201f3a:	779c                	ld	a5,40(a5)
ffffffffc0201f3c:	8782                	jr	a5
{
ffffffffc0201f3e:	1141                	addi	sp,sp,-16
ffffffffc0201f40:	e406                	sd	ra,8(sp)
ffffffffc0201f42:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201f44:	a71fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201f48:	000a9797          	auipc	a5,0xa9
ffffffffc0201f4c:	ee07b783          	ld	a5,-288(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0201f50:	779c                	ld	a5,40(a5)
ffffffffc0201f52:	9782                	jalr	a5
ffffffffc0201f54:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201f56:	a59fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201f5a:	60a2                	ld	ra,8(sp)
ffffffffc0201f5c:	8522                	mv	a0,s0
ffffffffc0201f5e:	6402                	ld	s0,0(sp)
ffffffffc0201f60:	0141                	addi	sp,sp,16
ffffffffc0201f62:	8082                	ret

ffffffffc0201f64 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f64:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0201f68:	1ff7f793          	andi	a5,a5,511
{
ffffffffc0201f6c:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f6e:	078e                	slli	a5,a5,0x3
{
ffffffffc0201f70:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f72:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc0201f76:	6094                	ld	a3,0(s1)
{
ffffffffc0201f78:	f04a                	sd	s2,32(sp)
ffffffffc0201f7a:	ec4e                	sd	s3,24(sp)
ffffffffc0201f7c:	e852                	sd	s4,16(sp)
ffffffffc0201f7e:	fc06                	sd	ra,56(sp)
ffffffffc0201f80:	f822                	sd	s0,48(sp)
ffffffffc0201f82:	e456                	sd	s5,8(sp)
ffffffffc0201f84:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc0201f86:	0016f793          	andi	a5,a3,1
{
ffffffffc0201f8a:	892e                	mv	s2,a1
ffffffffc0201f8c:	8a32                	mv	s4,a2
ffffffffc0201f8e:	000a9997          	auipc	s3,0xa9
ffffffffc0201f92:	e8a98993          	addi	s3,s3,-374 # ffffffffc02aae18 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc0201f96:	efbd                	bnez	a5,ffffffffc0202014 <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f98:	14060c63          	beqz	a2,ffffffffc02020f0 <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201f9c:	100027f3          	csrr	a5,sstatus
ffffffffc0201fa0:	8b89                	andi	a5,a5,2
ffffffffc0201fa2:	14079963          	bnez	a5,ffffffffc02020f4 <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201fa6:	000a9797          	auipc	a5,0xa9
ffffffffc0201faa:	e827b783          	ld	a5,-382(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0201fae:	6f9c                	ld	a5,24(a5)
ffffffffc0201fb0:	4505                	li	a0,1
ffffffffc0201fb2:	9782                	jalr	a5
ffffffffc0201fb4:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201fb6:	12040d63          	beqz	s0,ffffffffc02020f0 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201fba:	000a9b17          	auipc	s6,0xa9
ffffffffc0201fbe:	e66b0b13          	addi	s6,s6,-410 # ffffffffc02aae20 <pages>
ffffffffc0201fc2:	000b3503          	ld	a0,0(s6)
ffffffffc0201fc6:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201fca:	000a9997          	auipc	s3,0xa9
ffffffffc0201fce:	e4e98993          	addi	s3,s3,-434 # ffffffffc02aae18 <npage>
ffffffffc0201fd2:	40a40533          	sub	a0,s0,a0
ffffffffc0201fd6:	8519                	srai	a0,a0,0x6
ffffffffc0201fd8:	9556                	add	a0,a0,s5
ffffffffc0201fda:	0009b703          	ld	a4,0(s3)
ffffffffc0201fde:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201fe2:	4685                	li	a3,1
ffffffffc0201fe4:	c014                	sw	a3,0(s0)
ffffffffc0201fe6:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201fe8:	0532                	slli	a0,a0,0xc
ffffffffc0201fea:	16e7f763          	bgeu	a5,a4,ffffffffc0202158 <get_pte+0x1f4>
ffffffffc0201fee:	000a9797          	auipc	a5,0xa9
ffffffffc0201ff2:	e427b783          	ld	a5,-446(a5) # ffffffffc02aae30 <va_pa_offset>
ffffffffc0201ff6:	6605                	lui	a2,0x1
ffffffffc0201ff8:	4581                	li	a1,0
ffffffffc0201ffa:	953e                	add	a0,a0,a5
ffffffffc0201ffc:	6fe030ef          	jal	ra,ffffffffc02056fa <memset>
    return page - pages + nbase;
ffffffffc0202000:	000b3683          	ld	a3,0(s6)
ffffffffc0202004:	40d406b3          	sub	a3,s0,a3
ffffffffc0202008:	8699                	srai	a3,a3,0x6
ffffffffc020200a:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020200c:	06aa                	slli	a3,a3,0xa
ffffffffc020200e:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0202012:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202014:	77fd                	lui	a5,0xfffff
ffffffffc0202016:	068a                	slli	a3,a3,0x2
ffffffffc0202018:	0009b703          	ld	a4,0(s3)
ffffffffc020201c:	8efd                	and	a3,a3,a5
ffffffffc020201e:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202022:	10e7ff63          	bgeu	a5,a4,ffffffffc0202140 <get_pte+0x1dc>
ffffffffc0202026:	000a9a97          	auipc	s5,0xa9
ffffffffc020202a:	e0aa8a93          	addi	s5,s5,-502 # ffffffffc02aae30 <va_pa_offset>
ffffffffc020202e:	000ab403          	ld	s0,0(s5)
ffffffffc0202032:	01595793          	srli	a5,s2,0x15
ffffffffc0202036:	1ff7f793          	andi	a5,a5,511
ffffffffc020203a:	96a2                	add	a3,a3,s0
ffffffffc020203c:	00379413          	slli	s0,a5,0x3
ffffffffc0202040:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc0202042:	6014                	ld	a3,0(s0)
ffffffffc0202044:	0016f793          	andi	a5,a3,1
ffffffffc0202048:	ebad                	bnez	a5,ffffffffc02020ba <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc020204a:	0a0a0363          	beqz	s4,ffffffffc02020f0 <get_pte+0x18c>
ffffffffc020204e:	100027f3          	csrr	a5,sstatus
ffffffffc0202052:	8b89                	andi	a5,a5,2
ffffffffc0202054:	efcd                	bnez	a5,ffffffffc020210e <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202056:	000a9797          	auipc	a5,0xa9
ffffffffc020205a:	dd27b783          	ld	a5,-558(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc020205e:	6f9c                	ld	a5,24(a5)
ffffffffc0202060:	4505                	li	a0,1
ffffffffc0202062:	9782                	jalr	a5
ffffffffc0202064:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0202066:	c4c9                	beqz	s1,ffffffffc02020f0 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0202068:	000a9b17          	auipc	s6,0xa9
ffffffffc020206c:	db8b0b13          	addi	s6,s6,-584 # ffffffffc02aae20 <pages>
ffffffffc0202070:	000b3503          	ld	a0,0(s6)
ffffffffc0202074:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202078:	0009b703          	ld	a4,0(s3)
ffffffffc020207c:	40a48533          	sub	a0,s1,a0
ffffffffc0202080:	8519                	srai	a0,a0,0x6
ffffffffc0202082:	9552                	add	a0,a0,s4
ffffffffc0202084:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0202088:	4685                	li	a3,1
ffffffffc020208a:	c094                	sw	a3,0(s1)
ffffffffc020208c:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc020208e:	0532                	slli	a0,a0,0xc
ffffffffc0202090:	0ee7f163          	bgeu	a5,a4,ffffffffc0202172 <get_pte+0x20e>
ffffffffc0202094:	000ab783          	ld	a5,0(s5)
ffffffffc0202098:	6605                	lui	a2,0x1
ffffffffc020209a:	4581                	li	a1,0
ffffffffc020209c:	953e                	add	a0,a0,a5
ffffffffc020209e:	65c030ef          	jal	ra,ffffffffc02056fa <memset>
    return page - pages + nbase;
ffffffffc02020a2:	000b3683          	ld	a3,0(s6)
ffffffffc02020a6:	40d486b3          	sub	a3,s1,a3
ffffffffc02020aa:	8699                	srai	a3,a3,0x6
ffffffffc02020ac:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02020ae:	06aa                	slli	a3,a3,0xa
ffffffffc02020b0:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02020b4:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc02020b6:	0009b703          	ld	a4,0(s3)
ffffffffc02020ba:	068a                	slli	a3,a3,0x2
ffffffffc02020bc:	757d                	lui	a0,0xfffff
ffffffffc02020be:	8ee9                	and	a3,a3,a0
ffffffffc02020c0:	00c6d793          	srli	a5,a3,0xc
ffffffffc02020c4:	06e7f263          	bgeu	a5,a4,ffffffffc0202128 <get_pte+0x1c4>
ffffffffc02020c8:	000ab503          	ld	a0,0(s5)
ffffffffc02020cc:	00c95913          	srli	s2,s2,0xc
ffffffffc02020d0:	1ff97913          	andi	s2,s2,511
ffffffffc02020d4:	96aa                	add	a3,a3,a0
ffffffffc02020d6:	00391513          	slli	a0,s2,0x3
ffffffffc02020da:	9536                	add	a0,a0,a3
}
ffffffffc02020dc:	70e2                	ld	ra,56(sp)
ffffffffc02020de:	7442                	ld	s0,48(sp)
ffffffffc02020e0:	74a2                	ld	s1,40(sp)
ffffffffc02020e2:	7902                	ld	s2,32(sp)
ffffffffc02020e4:	69e2                	ld	s3,24(sp)
ffffffffc02020e6:	6a42                	ld	s4,16(sp)
ffffffffc02020e8:	6aa2                	ld	s5,8(sp)
ffffffffc02020ea:	6b02                	ld	s6,0(sp)
ffffffffc02020ec:	6121                	addi	sp,sp,64
ffffffffc02020ee:	8082                	ret
            return NULL;
ffffffffc02020f0:	4501                	li	a0,0
ffffffffc02020f2:	b7ed                	j	ffffffffc02020dc <get_pte+0x178>
        intr_disable();
ffffffffc02020f4:	8c1fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02020f8:	000a9797          	auipc	a5,0xa9
ffffffffc02020fc:	d307b783          	ld	a5,-720(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0202100:	6f9c                	ld	a5,24(a5)
ffffffffc0202102:	4505                	li	a0,1
ffffffffc0202104:	9782                	jalr	a5
ffffffffc0202106:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202108:	8a7fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020210c:	b56d                	j	ffffffffc0201fb6 <get_pte+0x52>
        intr_disable();
ffffffffc020210e:	8a7fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202112:	000a9797          	auipc	a5,0xa9
ffffffffc0202116:	d167b783          	ld	a5,-746(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc020211a:	6f9c                	ld	a5,24(a5)
ffffffffc020211c:	4505                	li	a0,1
ffffffffc020211e:	9782                	jalr	a5
ffffffffc0202120:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc0202122:	88dfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202126:	b781                	j	ffffffffc0202066 <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202128:	00004617          	auipc	a2,0x4
ffffffffc020212c:	47860613          	addi	a2,a2,1144 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0202130:	0fa00593          	li	a1,250
ffffffffc0202134:	00004517          	auipc	a0,0x4
ffffffffc0202138:	58450513          	addi	a0,a0,1412 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020213c:	b52fe0ef          	jal	ra,ffffffffc020048e <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202140:	00004617          	auipc	a2,0x4
ffffffffc0202144:	46060613          	addi	a2,a2,1120 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0202148:	0ed00593          	li	a1,237
ffffffffc020214c:	00004517          	auipc	a0,0x4
ffffffffc0202150:	56c50513          	addi	a0,a0,1388 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202154:	b3afe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202158:	86aa                	mv	a3,a0
ffffffffc020215a:	00004617          	auipc	a2,0x4
ffffffffc020215e:	44660613          	addi	a2,a2,1094 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0202162:	0e900593          	li	a1,233
ffffffffc0202166:	00004517          	auipc	a0,0x4
ffffffffc020216a:	55250513          	addi	a0,a0,1362 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020216e:	b20fe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202172:	86aa                	mv	a3,a0
ffffffffc0202174:	00004617          	auipc	a2,0x4
ffffffffc0202178:	42c60613          	addi	a2,a2,1068 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc020217c:	0f700593          	li	a1,247
ffffffffc0202180:	00004517          	auipc	a0,0x4
ffffffffc0202184:	53850513          	addi	a0,a0,1336 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202188:	b06fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020218c <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc020218c:	1141                	addi	sp,sp,-16
ffffffffc020218e:	e022                	sd	s0,0(sp)
ffffffffc0202190:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202192:	4601                	li	a2,0
{
ffffffffc0202194:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202196:	dcfff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
    if (ptep_store != NULL)
ffffffffc020219a:	c011                	beqz	s0,ffffffffc020219e <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc020219c:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc020219e:	c511                	beqz	a0,ffffffffc02021aa <get_page+0x1e>
ffffffffc02021a0:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc02021a2:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc02021a4:	0017f713          	andi	a4,a5,1
ffffffffc02021a8:	e709                	bnez	a4,ffffffffc02021b2 <get_page+0x26>
}
ffffffffc02021aa:	60a2                	ld	ra,8(sp)
ffffffffc02021ac:	6402                	ld	s0,0(sp)
ffffffffc02021ae:	0141                	addi	sp,sp,16
ffffffffc02021b0:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02021b2:	078a                	slli	a5,a5,0x2
ffffffffc02021b4:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02021b6:	000a9717          	auipc	a4,0xa9
ffffffffc02021ba:	c6273703          	ld	a4,-926(a4) # ffffffffc02aae18 <npage>
ffffffffc02021be:	00e7ff63          	bgeu	a5,a4,ffffffffc02021dc <get_page+0x50>
ffffffffc02021c2:	60a2                	ld	ra,8(sp)
ffffffffc02021c4:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc02021c6:	fff80537          	lui	a0,0xfff80
ffffffffc02021ca:	97aa                	add	a5,a5,a0
ffffffffc02021cc:	079a                	slli	a5,a5,0x6
ffffffffc02021ce:	000a9517          	auipc	a0,0xa9
ffffffffc02021d2:	c5253503          	ld	a0,-942(a0) # ffffffffc02aae20 <pages>
ffffffffc02021d6:	953e                	add	a0,a0,a5
ffffffffc02021d8:	0141                	addi	sp,sp,16
ffffffffc02021da:	8082                	ret
ffffffffc02021dc:	c99ff0ef          	jal	ra,ffffffffc0201e74 <pa2page.part.0>

ffffffffc02021e0 <unmap_range>:
        tlb_invalidate(pgdir, la);
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc02021e0:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021e2:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc02021e6:	f486                	sd	ra,104(sp)
ffffffffc02021e8:	f0a2                	sd	s0,96(sp)
ffffffffc02021ea:	eca6                	sd	s1,88(sp)
ffffffffc02021ec:	e8ca                	sd	s2,80(sp)
ffffffffc02021ee:	e4ce                	sd	s3,72(sp)
ffffffffc02021f0:	e0d2                	sd	s4,64(sp)
ffffffffc02021f2:	fc56                	sd	s5,56(sp)
ffffffffc02021f4:	f85a                	sd	s6,48(sp)
ffffffffc02021f6:	f45e                	sd	s7,40(sp)
ffffffffc02021f8:	f062                	sd	s8,32(sp)
ffffffffc02021fa:	ec66                	sd	s9,24(sp)
ffffffffc02021fc:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021fe:	17d2                	slli	a5,a5,0x34
ffffffffc0202200:	e3ed                	bnez	a5,ffffffffc02022e2 <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc0202202:	002007b7          	lui	a5,0x200
ffffffffc0202206:	842e                	mv	s0,a1
ffffffffc0202208:	0ef5ed63          	bltu	a1,a5,ffffffffc0202302 <unmap_range+0x122>
ffffffffc020220c:	8932                	mv	s2,a2
ffffffffc020220e:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202302 <unmap_range+0x122>
ffffffffc0202212:	4785                	li	a5,1
ffffffffc0202214:	07fe                	slli	a5,a5,0x1f
ffffffffc0202216:	0ec7e663          	bltu	a5,a2,ffffffffc0202302 <unmap_range+0x122>
ffffffffc020221a:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc020221c:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc020221e:	000a9c97          	auipc	s9,0xa9
ffffffffc0202222:	bfac8c93          	addi	s9,s9,-1030 # ffffffffc02aae18 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202226:	000a9c17          	auipc	s8,0xa9
ffffffffc020222a:	bfac0c13          	addi	s8,s8,-1030 # ffffffffc02aae20 <pages>
ffffffffc020222e:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc0202232:	000a9d17          	auipc	s10,0xa9
ffffffffc0202236:	bf6d0d13          	addi	s10,s10,-1034 # ffffffffc02aae28 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc020223a:	00200b37          	lui	s6,0x200
ffffffffc020223e:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc0202242:	4601                	li	a2,0
ffffffffc0202244:	85a2                	mv	a1,s0
ffffffffc0202246:	854e                	mv	a0,s3
ffffffffc0202248:	d1dff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
ffffffffc020224c:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc020224e:	cd29                	beqz	a0,ffffffffc02022a8 <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc0202250:	611c                	ld	a5,0(a0)
ffffffffc0202252:	e395                	bnez	a5,ffffffffc0202276 <unmap_range+0x96>
        start += PGSIZE;
ffffffffc0202254:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202256:	ff2466e3          	bltu	s0,s2,ffffffffc0202242 <unmap_range+0x62>
}
ffffffffc020225a:	70a6                	ld	ra,104(sp)
ffffffffc020225c:	7406                	ld	s0,96(sp)
ffffffffc020225e:	64e6                	ld	s1,88(sp)
ffffffffc0202260:	6946                	ld	s2,80(sp)
ffffffffc0202262:	69a6                	ld	s3,72(sp)
ffffffffc0202264:	6a06                	ld	s4,64(sp)
ffffffffc0202266:	7ae2                	ld	s5,56(sp)
ffffffffc0202268:	7b42                	ld	s6,48(sp)
ffffffffc020226a:	7ba2                	ld	s7,40(sp)
ffffffffc020226c:	7c02                	ld	s8,32(sp)
ffffffffc020226e:	6ce2                	ld	s9,24(sp)
ffffffffc0202270:	6d42                	ld	s10,16(sp)
ffffffffc0202272:	6165                	addi	sp,sp,112
ffffffffc0202274:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc0202276:	0017f713          	andi	a4,a5,1
ffffffffc020227a:	df69                	beqz	a4,ffffffffc0202254 <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc020227c:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202280:	078a                	slli	a5,a5,0x2
ffffffffc0202282:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202284:	08e7ff63          	bgeu	a5,a4,ffffffffc0202322 <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc0202288:	000c3503          	ld	a0,0(s8)
ffffffffc020228c:	97de                	add	a5,a5,s7
ffffffffc020228e:	079a                	slli	a5,a5,0x6
ffffffffc0202290:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202292:	411c                	lw	a5,0(a0)
ffffffffc0202294:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202298:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc020229a:	cf11                	beqz	a4,ffffffffc02022b6 <unmap_range+0xd6>
        *ptep = 0;
ffffffffc020229c:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02022a0:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc02022a4:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02022a6:	bf45                	j	ffffffffc0202256 <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02022a8:	945a                	add	s0,s0,s6
ffffffffc02022aa:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc02022ae:	d455                	beqz	s0,ffffffffc020225a <unmap_range+0x7a>
ffffffffc02022b0:	f92469e3          	bltu	s0,s2,ffffffffc0202242 <unmap_range+0x62>
ffffffffc02022b4:	b75d                	j	ffffffffc020225a <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02022b6:	100027f3          	csrr	a5,sstatus
ffffffffc02022ba:	8b89                	andi	a5,a5,2
ffffffffc02022bc:	e799                	bnez	a5,ffffffffc02022ca <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc02022be:	000d3783          	ld	a5,0(s10)
ffffffffc02022c2:	4585                	li	a1,1
ffffffffc02022c4:	739c                	ld	a5,32(a5)
ffffffffc02022c6:	9782                	jalr	a5
    if (flag)
ffffffffc02022c8:	bfd1                	j	ffffffffc020229c <unmap_range+0xbc>
ffffffffc02022ca:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02022cc:	ee8fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02022d0:	000d3783          	ld	a5,0(s10)
ffffffffc02022d4:	6522                	ld	a0,8(sp)
ffffffffc02022d6:	4585                	li	a1,1
ffffffffc02022d8:	739c                	ld	a5,32(a5)
ffffffffc02022da:	9782                	jalr	a5
        intr_enable();
ffffffffc02022dc:	ed2fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02022e0:	bf75                	j	ffffffffc020229c <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02022e2:	00004697          	auipc	a3,0x4
ffffffffc02022e6:	3e668693          	addi	a3,a3,998 # ffffffffc02066c8 <default_pmm_manager+0x160>
ffffffffc02022ea:	00004617          	auipc	a2,0x4
ffffffffc02022ee:	ece60613          	addi	a2,a2,-306 # ffffffffc02061b8 <commands+0x828>
ffffffffc02022f2:	12000593          	li	a1,288
ffffffffc02022f6:	00004517          	auipc	a0,0x4
ffffffffc02022fa:	3c250513          	addi	a0,a0,962 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02022fe:	990fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0202302:	00004697          	auipc	a3,0x4
ffffffffc0202306:	3f668693          	addi	a3,a3,1014 # ffffffffc02066f8 <default_pmm_manager+0x190>
ffffffffc020230a:	00004617          	auipc	a2,0x4
ffffffffc020230e:	eae60613          	addi	a2,a2,-338 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202312:	12100593          	li	a1,289
ffffffffc0202316:	00004517          	auipc	a0,0x4
ffffffffc020231a:	3a250513          	addi	a0,a0,930 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020231e:	970fe0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202322:	b53ff0ef          	jal	ra,ffffffffc0201e74 <pa2page.part.0>

ffffffffc0202326 <exit_range>:
{
ffffffffc0202326:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202328:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc020232c:	fc86                	sd	ra,120(sp)
ffffffffc020232e:	f8a2                	sd	s0,112(sp)
ffffffffc0202330:	f4a6                	sd	s1,104(sp)
ffffffffc0202332:	f0ca                	sd	s2,96(sp)
ffffffffc0202334:	ecce                	sd	s3,88(sp)
ffffffffc0202336:	e8d2                	sd	s4,80(sp)
ffffffffc0202338:	e4d6                	sd	s5,72(sp)
ffffffffc020233a:	e0da                	sd	s6,64(sp)
ffffffffc020233c:	fc5e                	sd	s7,56(sp)
ffffffffc020233e:	f862                	sd	s8,48(sp)
ffffffffc0202340:	f466                	sd	s9,40(sp)
ffffffffc0202342:	f06a                	sd	s10,32(sp)
ffffffffc0202344:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202346:	17d2                	slli	a5,a5,0x34
ffffffffc0202348:	20079a63          	bnez	a5,ffffffffc020255c <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc020234c:	002007b7          	lui	a5,0x200
ffffffffc0202350:	24f5e463          	bltu	a1,a5,ffffffffc0202598 <exit_range+0x272>
ffffffffc0202354:	8ab2                	mv	s5,a2
ffffffffc0202356:	24c5f163          	bgeu	a1,a2,ffffffffc0202598 <exit_range+0x272>
ffffffffc020235a:	4785                	li	a5,1
ffffffffc020235c:	07fe                	slli	a5,a5,0x1f
ffffffffc020235e:	22c7ed63          	bltu	a5,a2,ffffffffc0202598 <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc0202362:	c00009b7          	lui	s3,0xc0000
ffffffffc0202366:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc020236a:	ffe00937          	lui	s2,0xffe00
ffffffffc020236e:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc0202372:	5cfd                	li	s9,-1
ffffffffc0202374:	8c2a                	mv	s8,a0
ffffffffc0202376:	0125f933          	and	s2,a1,s2
ffffffffc020237a:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc020237c:	000a9d17          	auipc	s10,0xa9
ffffffffc0202380:	a9cd0d13          	addi	s10,s10,-1380 # ffffffffc02aae18 <npage>
    return KADDR(page2pa(page));
ffffffffc0202384:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc0202388:	000a9717          	auipc	a4,0xa9
ffffffffc020238c:	a9870713          	addi	a4,a4,-1384 # ffffffffc02aae20 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc0202390:	000a9d97          	auipc	s11,0xa9
ffffffffc0202394:	a98d8d93          	addi	s11,s11,-1384 # ffffffffc02aae28 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc0202398:	c0000437          	lui	s0,0xc0000
ffffffffc020239c:	944e                	add	s0,s0,s3
ffffffffc020239e:	8079                	srli	s0,s0,0x1e
ffffffffc02023a0:	1ff47413          	andi	s0,s0,511
ffffffffc02023a4:	040e                	slli	s0,s0,0x3
ffffffffc02023a6:	9462                	add	s0,s0,s8
ffffffffc02023a8:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4e68>
        if (pde1 & PTE_V)
ffffffffc02023ac:	001a7793          	andi	a5,s4,1
ffffffffc02023b0:	eb99                	bnez	a5,ffffffffc02023c6 <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc02023b2:	12098463          	beqz	s3,ffffffffc02024da <exit_range+0x1b4>
ffffffffc02023b6:	400007b7          	lui	a5,0x40000
ffffffffc02023ba:	97ce                	add	a5,a5,s3
ffffffffc02023bc:	894e                	mv	s2,s3
ffffffffc02023be:	1159fe63          	bgeu	s3,s5,ffffffffc02024da <exit_range+0x1b4>
ffffffffc02023c2:	89be                	mv	s3,a5
ffffffffc02023c4:	bfd1                	j	ffffffffc0202398 <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc02023c6:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc02023ca:	0a0a                	slli	s4,s4,0x2
ffffffffc02023cc:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc02023d0:	1cfa7263          	bgeu	s4,a5,ffffffffc0202594 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02023d4:	fff80637          	lui	a2,0xfff80
ffffffffc02023d8:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc02023da:	000806b7          	lui	a3,0x80
ffffffffc02023de:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02023e0:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc02023e4:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc02023e6:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02023e8:	18f5fa63          	bgeu	a1,a5,ffffffffc020257c <exit_range+0x256>
ffffffffc02023ec:	000a9817          	auipc	a6,0xa9
ffffffffc02023f0:	a4480813          	addi	a6,a6,-1468 # ffffffffc02aae30 <va_pa_offset>
ffffffffc02023f4:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc02023f8:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc02023fa:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc02023fe:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc0202400:	00080337          	lui	t1,0x80
ffffffffc0202404:	6885                	lui	a7,0x1
ffffffffc0202406:	a819                	j	ffffffffc020241c <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc0202408:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc020240a:	002007b7          	lui	a5,0x200
ffffffffc020240e:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202410:	08090c63          	beqz	s2,ffffffffc02024a8 <exit_range+0x182>
ffffffffc0202414:	09397a63          	bgeu	s2,s3,ffffffffc02024a8 <exit_range+0x182>
ffffffffc0202418:	0f597063          	bgeu	s2,s5,ffffffffc02024f8 <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc020241c:	01595493          	srli	s1,s2,0x15
ffffffffc0202420:	1ff4f493          	andi	s1,s1,511
ffffffffc0202424:	048e                	slli	s1,s1,0x3
ffffffffc0202426:	94da                	add	s1,s1,s6
ffffffffc0202428:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc020242a:	0017f693          	andi	a3,a5,1
ffffffffc020242e:	dee9                	beqz	a3,ffffffffc0202408 <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc0202430:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202434:	078a                	slli	a5,a5,0x2
ffffffffc0202436:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202438:	14b7fe63          	bgeu	a5,a1,ffffffffc0202594 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc020243c:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc020243e:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc0202442:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc0202446:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc020244a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020244c:	12bef863          	bgeu	t4,a1,ffffffffc020257c <exit_range+0x256>
ffffffffc0202450:	00083783          	ld	a5,0(a6)
ffffffffc0202454:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202456:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc020245a:	629c                	ld	a5,0(a3)
ffffffffc020245c:	8b85                	andi	a5,a5,1
ffffffffc020245e:	f7d5                	bnez	a5,ffffffffc020240a <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202460:	06a1                	addi	a3,a3,8
ffffffffc0202462:	fed59ce3          	bne	a1,a3,ffffffffc020245a <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc0202466:	631c                	ld	a5,0(a4)
ffffffffc0202468:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020246a:	100027f3          	csrr	a5,sstatus
ffffffffc020246e:	8b89                	andi	a5,a5,2
ffffffffc0202470:	e7d9                	bnez	a5,ffffffffc02024fe <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc0202472:	000db783          	ld	a5,0(s11)
ffffffffc0202476:	4585                	li	a1,1
ffffffffc0202478:	e032                	sd	a2,0(sp)
ffffffffc020247a:	739c                	ld	a5,32(a5)
ffffffffc020247c:	9782                	jalr	a5
    if (flag)
ffffffffc020247e:	6602                	ld	a2,0(sp)
ffffffffc0202480:	000a9817          	auipc	a6,0xa9
ffffffffc0202484:	9b080813          	addi	a6,a6,-1616 # ffffffffc02aae30 <va_pa_offset>
ffffffffc0202488:	fff80e37          	lui	t3,0xfff80
ffffffffc020248c:	00080337          	lui	t1,0x80
ffffffffc0202490:	6885                	lui	a7,0x1
ffffffffc0202492:	000a9717          	auipc	a4,0xa9
ffffffffc0202496:	98e70713          	addi	a4,a4,-1650 # ffffffffc02aae20 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc020249a:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc020249e:	002007b7          	lui	a5,0x200
ffffffffc02024a2:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc02024a4:	f60918e3          	bnez	s2,ffffffffc0202414 <exit_range+0xee>
            if (free_pd0)
ffffffffc02024a8:	f00b85e3          	beqz	s7,ffffffffc02023b2 <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc02024ac:	000d3783          	ld	a5,0(s10)
ffffffffc02024b0:	0efa7263          	bgeu	s4,a5,ffffffffc0202594 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02024b4:	6308                	ld	a0,0(a4)
ffffffffc02024b6:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02024b8:	100027f3          	csrr	a5,sstatus
ffffffffc02024bc:	8b89                	andi	a5,a5,2
ffffffffc02024be:	efad                	bnez	a5,ffffffffc0202538 <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc02024c0:	000db783          	ld	a5,0(s11)
ffffffffc02024c4:	4585                	li	a1,1
ffffffffc02024c6:	739c                	ld	a5,32(a5)
ffffffffc02024c8:	9782                	jalr	a5
ffffffffc02024ca:	000a9717          	auipc	a4,0xa9
ffffffffc02024ce:	95670713          	addi	a4,a4,-1706 # ffffffffc02aae20 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc02024d2:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc02024d6:	ee0990e3          	bnez	s3,ffffffffc02023b6 <exit_range+0x90>
}
ffffffffc02024da:	70e6                	ld	ra,120(sp)
ffffffffc02024dc:	7446                	ld	s0,112(sp)
ffffffffc02024de:	74a6                	ld	s1,104(sp)
ffffffffc02024e0:	7906                	ld	s2,96(sp)
ffffffffc02024e2:	69e6                	ld	s3,88(sp)
ffffffffc02024e4:	6a46                	ld	s4,80(sp)
ffffffffc02024e6:	6aa6                	ld	s5,72(sp)
ffffffffc02024e8:	6b06                	ld	s6,64(sp)
ffffffffc02024ea:	7be2                	ld	s7,56(sp)
ffffffffc02024ec:	7c42                	ld	s8,48(sp)
ffffffffc02024ee:	7ca2                	ld	s9,40(sp)
ffffffffc02024f0:	7d02                	ld	s10,32(sp)
ffffffffc02024f2:	6de2                	ld	s11,24(sp)
ffffffffc02024f4:	6109                	addi	sp,sp,128
ffffffffc02024f6:	8082                	ret
            if (free_pd0)
ffffffffc02024f8:	ea0b8fe3          	beqz	s7,ffffffffc02023b6 <exit_range+0x90>
ffffffffc02024fc:	bf45                	j	ffffffffc02024ac <exit_range+0x186>
ffffffffc02024fe:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc0202500:	e42a                	sd	a0,8(sp)
ffffffffc0202502:	cb2fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202506:	000db783          	ld	a5,0(s11)
ffffffffc020250a:	6522                	ld	a0,8(sp)
ffffffffc020250c:	4585                	li	a1,1
ffffffffc020250e:	739c                	ld	a5,32(a5)
ffffffffc0202510:	9782                	jalr	a5
        intr_enable();
ffffffffc0202512:	c9cfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202516:	6602                	ld	a2,0(sp)
ffffffffc0202518:	000a9717          	auipc	a4,0xa9
ffffffffc020251c:	90870713          	addi	a4,a4,-1784 # ffffffffc02aae20 <pages>
ffffffffc0202520:	6885                	lui	a7,0x1
ffffffffc0202522:	00080337          	lui	t1,0x80
ffffffffc0202526:	fff80e37          	lui	t3,0xfff80
ffffffffc020252a:	000a9817          	auipc	a6,0xa9
ffffffffc020252e:	90680813          	addi	a6,a6,-1786 # ffffffffc02aae30 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202532:	0004b023          	sd	zero,0(s1)
ffffffffc0202536:	b7a5                	j	ffffffffc020249e <exit_range+0x178>
ffffffffc0202538:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc020253a:	c7afe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020253e:	000db783          	ld	a5,0(s11)
ffffffffc0202542:	6502                	ld	a0,0(sp)
ffffffffc0202544:	4585                	li	a1,1
ffffffffc0202546:	739c                	ld	a5,32(a5)
ffffffffc0202548:	9782                	jalr	a5
        intr_enable();
ffffffffc020254a:	c64fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020254e:	000a9717          	auipc	a4,0xa9
ffffffffc0202552:	8d270713          	addi	a4,a4,-1838 # ffffffffc02aae20 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc0202556:	00043023          	sd	zero,0(s0)
ffffffffc020255a:	bfb5                	j	ffffffffc02024d6 <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020255c:	00004697          	auipc	a3,0x4
ffffffffc0202560:	16c68693          	addi	a3,a3,364 # ffffffffc02066c8 <default_pmm_manager+0x160>
ffffffffc0202564:	00004617          	auipc	a2,0x4
ffffffffc0202568:	c5460613          	addi	a2,a2,-940 # ffffffffc02061b8 <commands+0x828>
ffffffffc020256c:	13500593          	li	a1,309
ffffffffc0202570:	00004517          	auipc	a0,0x4
ffffffffc0202574:	14850513          	addi	a0,a0,328 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202578:	f17fd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc020257c:	00004617          	auipc	a2,0x4
ffffffffc0202580:	02460613          	addi	a2,a2,36 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0202584:	07100593          	li	a1,113
ffffffffc0202588:	00004517          	auipc	a0,0x4
ffffffffc020258c:	04050513          	addi	a0,a0,64 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0202590:	efffd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202594:	8e1ff0ef          	jal	ra,ffffffffc0201e74 <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc0202598:	00004697          	auipc	a3,0x4
ffffffffc020259c:	16068693          	addi	a3,a3,352 # ffffffffc02066f8 <default_pmm_manager+0x190>
ffffffffc02025a0:	00004617          	auipc	a2,0x4
ffffffffc02025a4:	c1860613          	addi	a2,a2,-1000 # ffffffffc02061b8 <commands+0x828>
ffffffffc02025a8:	13600593          	li	a1,310
ffffffffc02025ac:	00004517          	auipc	a0,0x4
ffffffffc02025b0:	10c50513          	addi	a0,a0,268 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02025b4:	edbfd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02025b8 <page_remove>:
{
ffffffffc02025b8:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02025ba:	4601                	li	a2,0
{
ffffffffc02025bc:	ec26                	sd	s1,24(sp)
ffffffffc02025be:	f406                	sd	ra,40(sp)
ffffffffc02025c0:	f022                	sd	s0,32(sp)
ffffffffc02025c2:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02025c4:	9a1ff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
    if (ptep != NULL)
ffffffffc02025c8:	c511                	beqz	a0,ffffffffc02025d4 <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc02025ca:	611c                	ld	a5,0(a0)
ffffffffc02025cc:	842a                	mv	s0,a0
ffffffffc02025ce:	0017f713          	andi	a4,a5,1
ffffffffc02025d2:	e711                	bnez	a4,ffffffffc02025de <page_remove+0x26>
}
ffffffffc02025d4:	70a2                	ld	ra,40(sp)
ffffffffc02025d6:	7402                	ld	s0,32(sp)
ffffffffc02025d8:	64e2                	ld	s1,24(sp)
ffffffffc02025da:	6145                	addi	sp,sp,48
ffffffffc02025dc:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02025de:	078a                	slli	a5,a5,0x2
ffffffffc02025e0:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02025e2:	000a9717          	auipc	a4,0xa9
ffffffffc02025e6:	83673703          	ld	a4,-1994(a4) # ffffffffc02aae18 <npage>
ffffffffc02025ea:	06e7f363          	bgeu	a5,a4,ffffffffc0202650 <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc02025ee:	fff80537          	lui	a0,0xfff80
ffffffffc02025f2:	97aa                	add	a5,a5,a0
ffffffffc02025f4:	079a                	slli	a5,a5,0x6
ffffffffc02025f6:	000a9517          	auipc	a0,0xa9
ffffffffc02025fa:	82a53503          	ld	a0,-2006(a0) # ffffffffc02aae20 <pages>
ffffffffc02025fe:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202600:	411c                	lw	a5,0(a0)
ffffffffc0202602:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202606:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc0202608:	cb11                	beqz	a4,ffffffffc020261c <page_remove+0x64>
        *ptep = 0;
ffffffffc020260a:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020260e:	12048073          	sfence.vma	s1
}
ffffffffc0202612:	70a2                	ld	ra,40(sp)
ffffffffc0202614:	7402                	ld	s0,32(sp)
ffffffffc0202616:	64e2                	ld	s1,24(sp)
ffffffffc0202618:	6145                	addi	sp,sp,48
ffffffffc020261a:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020261c:	100027f3          	csrr	a5,sstatus
ffffffffc0202620:	8b89                	andi	a5,a5,2
ffffffffc0202622:	eb89                	bnez	a5,ffffffffc0202634 <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc0202624:	000a9797          	auipc	a5,0xa9
ffffffffc0202628:	8047b783          	ld	a5,-2044(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc020262c:	739c                	ld	a5,32(a5)
ffffffffc020262e:	4585                	li	a1,1
ffffffffc0202630:	9782                	jalr	a5
    if (flag)
ffffffffc0202632:	bfe1                	j	ffffffffc020260a <page_remove+0x52>
        intr_disable();
ffffffffc0202634:	e42a                	sd	a0,8(sp)
ffffffffc0202636:	b7efe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc020263a:	000a8797          	auipc	a5,0xa8
ffffffffc020263e:	7ee7b783          	ld	a5,2030(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc0202642:	739c                	ld	a5,32(a5)
ffffffffc0202644:	6522                	ld	a0,8(sp)
ffffffffc0202646:	4585                	li	a1,1
ffffffffc0202648:	9782                	jalr	a5
        intr_enable();
ffffffffc020264a:	b64fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020264e:	bf75                	j	ffffffffc020260a <page_remove+0x52>
ffffffffc0202650:	825ff0ef          	jal	ra,ffffffffc0201e74 <pa2page.part.0>

ffffffffc0202654 <page_insert>:
{
ffffffffc0202654:	7139                	addi	sp,sp,-64
ffffffffc0202656:	e852                	sd	s4,16(sp)
ffffffffc0202658:	8a32                	mv	s4,a2
ffffffffc020265a:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc020265c:	4605                	li	a2,1
{
ffffffffc020265e:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202660:	85d2                	mv	a1,s4
{
ffffffffc0202662:	f426                	sd	s1,40(sp)
ffffffffc0202664:	fc06                	sd	ra,56(sp)
ffffffffc0202666:	f04a                	sd	s2,32(sp)
ffffffffc0202668:	ec4e                	sd	s3,24(sp)
ffffffffc020266a:	e456                	sd	s5,8(sp)
ffffffffc020266c:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc020266e:	8f7ff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
    if (ptep == NULL)
ffffffffc0202672:	c961                	beqz	a0,ffffffffc0202742 <page_insert+0xee>
    page->ref += 1;
ffffffffc0202674:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc0202676:	611c                	ld	a5,0(a0)
ffffffffc0202678:	89aa                	mv	s3,a0
ffffffffc020267a:	0016871b          	addiw	a4,a3,1
ffffffffc020267e:	c018                	sw	a4,0(s0)
ffffffffc0202680:	0017f713          	andi	a4,a5,1
ffffffffc0202684:	ef05                	bnez	a4,ffffffffc02026bc <page_insert+0x68>
    return page - pages + nbase;
ffffffffc0202686:	000a8717          	auipc	a4,0xa8
ffffffffc020268a:	79a73703          	ld	a4,1946(a4) # ffffffffc02aae20 <pages>
ffffffffc020268e:	8c19                	sub	s0,s0,a4
ffffffffc0202690:	000807b7          	lui	a5,0x80
ffffffffc0202694:	8419                	srai	s0,s0,0x6
ffffffffc0202696:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202698:	042a                	slli	s0,s0,0xa
ffffffffc020269a:	8cc1                	or	s1,s1,s0
ffffffffc020269c:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc02026a0:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4e68>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02026a4:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc02026a8:	4501                	li	a0,0
}
ffffffffc02026aa:	70e2                	ld	ra,56(sp)
ffffffffc02026ac:	7442                	ld	s0,48(sp)
ffffffffc02026ae:	74a2                	ld	s1,40(sp)
ffffffffc02026b0:	7902                	ld	s2,32(sp)
ffffffffc02026b2:	69e2                	ld	s3,24(sp)
ffffffffc02026b4:	6a42                	ld	s4,16(sp)
ffffffffc02026b6:	6aa2                	ld	s5,8(sp)
ffffffffc02026b8:	6121                	addi	sp,sp,64
ffffffffc02026ba:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02026bc:	078a                	slli	a5,a5,0x2
ffffffffc02026be:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02026c0:	000a8717          	auipc	a4,0xa8
ffffffffc02026c4:	75873703          	ld	a4,1880(a4) # ffffffffc02aae18 <npage>
ffffffffc02026c8:	06e7ff63          	bgeu	a5,a4,ffffffffc0202746 <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc02026cc:	000a8a97          	auipc	s5,0xa8
ffffffffc02026d0:	754a8a93          	addi	s5,s5,1876 # ffffffffc02aae20 <pages>
ffffffffc02026d4:	000ab703          	ld	a4,0(s5)
ffffffffc02026d8:	fff80937          	lui	s2,0xfff80
ffffffffc02026dc:	993e                	add	s2,s2,a5
ffffffffc02026de:	091a                	slli	s2,s2,0x6
ffffffffc02026e0:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc02026e2:	01240c63          	beq	s0,s2,ffffffffc02026fa <page_insert+0xa6>
    page->ref -= 1;
ffffffffc02026e6:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcd51ac>
ffffffffc02026ea:	fff7869b          	addiw	a3,a5,-1
ffffffffc02026ee:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) == 0)
ffffffffc02026f2:	c691                	beqz	a3,ffffffffc02026fe <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02026f4:	120a0073          	sfence.vma	s4
}
ffffffffc02026f8:	bf59                	j	ffffffffc020268e <page_insert+0x3a>
ffffffffc02026fa:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc02026fc:	bf49                	j	ffffffffc020268e <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02026fe:	100027f3          	csrr	a5,sstatus
ffffffffc0202702:	8b89                	andi	a5,a5,2
ffffffffc0202704:	ef91                	bnez	a5,ffffffffc0202720 <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc0202706:	000a8797          	auipc	a5,0xa8
ffffffffc020270a:	7227b783          	ld	a5,1826(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc020270e:	739c                	ld	a5,32(a5)
ffffffffc0202710:	4585                	li	a1,1
ffffffffc0202712:	854a                	mv	a0,s2
ffffffffc0202714:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc0202716:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020271a:	120a0073          	sfence.vma	s4
ffffffffc020271e:	bf85                	j	ffffffffc020268e <page_insert+0x3a>
        intr_disable();
ffffffffc0202720:	a94fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202724:	000a8797          	auipc	a5,0xa8
ffffffffc0202728:	7047b783          	ld	a5,1796(a5) # ffffffffc02aae28 <pmm_manager>
ffffffffc020272c:	739c                	ld	a5,32(a5)
ffffffffc020272e:	4585                	li	a1,1
ffffffffc0202730:	854a                	mv	a0,s2
ffffffffc0202732:	9782                	jalr	a5
        intr_enable();
ffffffffc0202734:	a7afe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202738:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020273c:	120a0073          	sfence.vma	s4
ffffffffc0202740:	b7b9                	j	ffffffffc020268e <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc0202742:	5571                	li	a0,-4
ffffffffc0202744:	b79d                	j	ffffffffc02026aa <page_insert+0x56>
ffffffffc0202746:	f2eff0ef          	jal	ra,ffffffffc0201e74 <pa2page.part.0>

ffffffffc020274a <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc020274a:	00004797          	auipc	a5,0x4
ffffffffc020274e:	e1e78793          	addi	a5,a5,-482 # ffffffffc0206568 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202752:	638c                	ld	a1,0(a5)
{
ffffffffc0202754:	7159                	addi	sp,sp,-112
ffffffffc0202756:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202758:	00004517          	auipc	a0,0x4
ffffffffc020275c:	fb850513          	addi	a0,a0,-72 # ffffffffc0206710 <default_pmm_manager+0x1a8>
    pmm_manager = &default_pmm_manager;
ffffffffc0202760:	000a8b17          	auipc	s6,0xa8
ffffffffc0202764:	6c8b0b13          	addi	s6,s6,1736 # ffffffffc02aae28 <pmm_manager>
{
ffffffffc0202768:	f486                	sd	ra,104(sp)
ffffffffc020276a:	e8ca                	sd	s2,80(sp)
ffffffffc020276c:	e4ce                	sd	s3,72(sp)
ffffffffc020276e:	f0a2                	sd	s0,96(sp)
ffffffffc0202770:	eca6                	sd	s1,88(sp)
ffffffffc0202772:	e0d2                	sd	s4,64(sp)
ffffffffc0202774:	fc56                	sd	s5,56(sp)
ffffffffc0202776:	f45e                	sd	s7,40(sp)
ffffffffc0202778:	f062                	sd	s8,32(sp)
ffffffffc020277a:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc020277c:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202780:	a15fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    pmm_manager->init();
ffffffffc0202784:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202788:	000a8997          	auipc	s3,0xa8
ffffffffc020278c:	6a898993          	addi	s3,s3,1704 # ffffffffc02aae30 <va_pa_offset>
    pmm_manager->init();
ffffffffc0202790:	679c                	ld	a5,8(a5)
ffffffffc0202792:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202794:	57f5                	li	a5,-3
ffffffffc0202796:	07fa                	slli	a5,a5,0x1e
ffffffffc0202798:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc020279c:	9fefe0ef          	jal	ra,ffffffffc020099a <get_memory_base>
ffffffffc02027a0:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc02027a2:	a02fe0ef          	jal	ra,ffffffffc02009a4 <get_memory_size>
    if (mem_size == 0)
ffffffffc02027a6:	200505e3          	beqz	a0,ffffffffc02031b0 <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02027aa:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc02027ac:	00004517          	auipc	a0,0x4
ffffffffc02027b0:	f9c50513          	addi	a0,a0,-100 # ffffffffc0206748 <default_pmm_manager+0x1e0>
ffffffffc02027b4:	9e1fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02027b8:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc02027bc:	fff40693          	addi	a3,s0,-1
ffffffffc02027c0:	864a                	mv	a2,s2
ffffffffc02027c2:	85a6                	mv	a1,s1
ffffffffc02027c4:	00004517          	auipc	a0,0x4
ffffffffc02027c8:	f9c50513          	addi	a0,a0,-100 # ffffffffc0206760 <default_pmm_manager+0x1f8>
ffffffffc02027cc:	9c9fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02027d0:	c8000737          	lui	a4,0xc8000
ffffffffc02027d4:	87a2                	mv	a5,s0
ffffffffc02027d6:	54876163          	bltu	a4,s0,ffffffffc0202d18 <pmm_init+0x5ce>
ffffffffc02027da:	757d                	lui	a0,0xfffff
ffffffffc02027dc:	000a9617          	auipc	a2,0xa9
ffffffffc02027e0:	67760613          	addi	a2,a2,1655 # ffffffffc02abe53 <end+0xfff>
ffffffffc02027e4:	8e69                	and	a2,a2,a0
ffffffffc02027e6:	000a8497          	auipc	s1,0xa8
ffffffffc02027ea:	63248493          	addi	s1,s1,1586 # ffffffffc02aae18 <npage>
ffffffffc02027ee:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027f2:	000a8b97          	auipc	s7,0xa8
ffffffffc02027f6:	62eb8b93          	addi	s7,s7,1582 # ffffffffc02aae20 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02027fa:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027fc:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202800:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202804:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202806:	02f50863          	beq	a0,a5,ffffffffc0202836 <pmm_init+0xec>
ffffffffc020280a:	4781                	li	a5,0
ffffffffc020280c:	4585                	li	a1,1
ffffffffc020280e:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc0202812:	00679513          	slli	a0,a5,0x6
ffffffffc0202816:	9532                	add	a0,a0,a2
ffffffffc0202818:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd541b4>
ffffffffc020281c:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202820:	6088                	ld	a0,0(s1)
ffffffffc0202822:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc0202824:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202828:	00d50733          	add	a4,a0,a3
ffffffffc020282c:	fee7e3e3          	bltu	a5,a4,ffffffffc0202812 <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202830:	071a                	slli	a4,a4,0x6
ffffffffc0202832:	00e606b3          	add	a3,a2,a4
ffffffffc0202836:	c02007b7          	lui	a5,0xc0200
ffffffffc020283a:	2ef6ece3          	bltu	a3,a5,ffffffffc0203332 <pmm_init+0xbe8>
ffffffffc020283e:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0202842:	77fd                	lui	a5,0xfffff
ffffffffc0202844:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202846:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc0202848:	5086eb63          	bltu	a3,s0,ffffffffc0202d5e <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc020284c:	00004517          	auipc	a0,0x4
ffffffffc0202850:	f3c50513          	addi	a0,a0,-196 # ffffffffc0206788 <default_pmm_manager+0x220>
ffffffffc0202854:	941fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc0202858:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc020285c:	000a8917          	auipc	s2,0xa8
ffffffffc0202860:	5b490913          	addi	s2,s2,1460 # ffffffffc02aae10 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc0202864:	7b9c                	ld	a5,48(a5)
ffffffffc0202866:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0202868:	00004517          	auipc	a0,0x4
ffffffffc020286c:	f3850513          	addi	a0,a0,-200 # ffffffffc02067a0 <default_pmm_manager+0x238>
ffffffffc0202870:	925fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202874:	00007697          	auipc	a3,0x7
ffffffffc0202878:	78c68693          	addi	a3,a3,1932 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc020287c:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0202880:	c02007b7          	lui	a5,0xc0200
ffffffffc0202884:	28f6ebe3          	bltu	a3,a5,ffffffffc020331a <pmm_init+0xbd0>
ffffffffc0202888:	0009b783          	ld	a5,0(s3)
ffffffffc020288c:	8e9d                	sub	a3,a3,a5
ffffffffc020288e:	000a8797          	auipc	a5,0xa8
ffffffffc0202892:	56d7bd23          	sd	a3,1402(a5) # ffffffffc02aae08 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202896:	100027f3          	csrr	a5,sstatus
ffffffffc020289a:	8b89                	andi	a5,a5,2
ffffffffc020289c:	4a079763          	bnez	a5,ffffffffc0202d4a <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc02028a0:	000b3783          	ld	a5,0(s6)
ffffffffc02028a4:	779c                	ld	a5,40(a5)
ffffffffc02028a6:	9782                	jalr	a5
ffffffffc02028a8:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc02028aa:	6098                	ld	a4,0(s1)
ffffffffc02028ac:	c80007b7          	lui	a5,0xc8000
ffffffffc02028b0:	83b1                	srli	a5,a5,0xc
ffffffffc02028b2:	66e7e363          	bltu	a5,a4,ffffffffc0202f18 <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc02028b6:	00093503          	ld	a0,0(s2)
ffffffffc02028ba:	62050f63          	beqz	a0,ffffffffc0202ef8 <pmm_init+0x7ae>
ffffffffc02028be:	03451793          	slli	a5,a0,0x34
ffffffffc02028c2:	62079b63          	bnez	a5,ffffffffc0202ef8 <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc02028c6:	4601                	li	a2,0
ffffffffc02028c8:	4581                	li	a1,0
ffffffffc02028ca:	8c3ff0ef          	jal	ra,ffffffffc020218c <get_page>
ffffffffc02028ce:	60051563          	bnez	a0,ffffffffc0202ed8 <pmm_init+0x78e>
ffffffffc02028d2:	100027f3          	csrr	a5,sstatus
ffffffffc02028d6:	8b89                	andi	a5,a5,2
ffffffffc02028d8:	44079e63          	bnez	a5,ffffffffc0202d34 <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc02028dc:	000b3783          	ld	a5,0(s6)
ffffffffc02028e0:	4505                	li	a0,1
ffffffffc02028e2:	6f9c                	ld	a5,24(a5)
ffffffffc02028e4:	9782                	jalr	a5
ffffffffc02028e6:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc02028e8:	00093503          	ld	a0,0(s2)
ffffffffc02028ec:	4681                	li	a3,0
ffffffffc02028ee:	4601                	li	a2,0
ffffffffc02028f0:	85d2                	mv	a1,s4
ffffffffc02028f2:	d63ff0ef          	jal	ra,ffffffffc0202654 <page_insert>
ffffffffc02028f6:	26051ae3          	bnez	a0,ffffffffc020336a <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc02028fa:	00093503          	ld	a0,0(s2)
ffffffffc02028fe:	4601                	li	a2,0
ffffffffc0202900:	4581                	li	a1,0
ffffffffc0202902:	e62ff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
ffffffffc0202906:	240502e3          	beqz	a0,ffffffffc020334a <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc020290a:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc020290c:	0017f713          	andi	a4,a5,1
ffffffffc0202910:	5a070263          	beqz	a4,ffffffffc0202eb4 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0202914:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202916:	078a                	slli	a5,a5,0x2
ffffffffc0202918:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020291a:	58e7fb63          	bgeu	a5,a4,ffffffffc0202eb0 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc020291e:	000bb683          	ld	a3,0(s7)
ffffffffc0202922:	fff80637          	lui	a2,0xfff80
ffffffffc0202926:	97b2                	add	a5,a5,a2
ffffffffc0202928:	079a                	slli	a5,a5,0x6
ffffffffc020292a:	97b6                	add	a5,a5,a3
ffffffffc020292c:	14fa17e3          	bne	s4,a5,ffffffffc020327a <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc0202930:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8c20>
ffffffffc0202934:	4785                	li	a5,1
ffffffffc0202936:	12f692e3          	bne	a3,a5,ffffffffc020325a <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc020293a:	00093503          	ld	a0,0(s2)
ffffffffc020293e:	77fd                	lui	a5,0xfffff
ffffffffc0202940:	6114                	ld	a3,0(a0)
ffffffffc0202942:	068a                	slli	a3,a3,0x2
ffffffffc0202944:	8efd                	and	a3,a3,a5
ffffffffc0202946:	00c6d613          	srli	a2,a3,0xc
ffffffffc020294a:	0ee67ce3          	bgeu	a2,a4,ffffffffc0203242 <pmm_init+0xaf8>
ffffffffc020294e:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202952:	96e2                	add	a3,a3,s8
ffffffffc0202954:	0006ba83          	ld	s5,0(a3)
ffffffffc0202958:	0a8a                	slli	s5,s5,0x2
ffffffffc020295a:	00fafab3          	and	s5,s5,a5
ffffffffc020295e:	00cad793          	srli	a5,s5,0xc
ffffffffc0202962:	0ce7f3e3          	bgeu	a5,a4,ffffffffc0203228 <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202966:	4601                	li	a2,0
ffffffffc0202968:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020296a:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020296c:	df8ff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202970:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202972:	55551363          	bne	a0,s5,ffffffffc0202eb8 <pmm_init+0x76e>
ffffffffc0202976:	100027f3          	csrr	a5,sstatus
ffffffffc020297a:	8b89                	andi	a5,a5,2
ffffffffc020297c:	3a079163          	bnez	a5,ffffffffc0202d1e <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202980:	000b3783          	ld	a5,0(s6)
ffffffffc0202984:	4505                	li	a0,1
ffffffffc0202986:	6f9c                	ld	a5,24(a5)
ffffffffc0202988:	9782                	jalr	a5
ffffffffc020298a:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc020298c:	00093503          	ld	a0,0(s2)
ffffffffc0202990:	46d1                	li	a3,20
ffffffffc0202992:	6605                	lui	a2,0x1
ffffffffc0202994:	85e2                	mv	a1,s8
ffffffffc0202996:	cbfff0ef          	jal	ra,ffffffffc0202654 <page_insert>
ffffffffc020299a:	060517e3          	bnez	a0,ffffffffc0203208 <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc020299e:	00093503          	ld	a0,0(s2)
ffffffffc02029a2:	4601                	li	a2,0
ffffffffc02029a4:	6585                	lui	a1,0x1
ffffffffc02029a6:	dbeff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
ffffffffc02029aa:	02050fe3          	beqz	a0,ffffffffc02031e8 <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc02029ae:	611c                	ld	a5,0(a0)
ffffffffc02029b0:	0107f713          	andi	a4,a5,16
ffffffffc02029b4:	7c070e63          	beqz	a4,ffffffffc0203190 <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc02029b8:	8b91                	andi	a5,a5,4
ffffffffc02029ba:	7a078b63          	beqz	a5,ffffffffc0203170 <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc02029be:	00093503          	ld	a0,0(s2)
ffffffffc02029c2:	611c                	ld	a5,0(a0)
ffffffffc02029c4:	8bc1                	andi	a5,a5,16
ffffffffc02029c6:	78078563          	beqz	a5,ffffffffc0203150 <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc02029ca:	000c2703          	lw	a4,0(s8)
ffffffffc02029ce:	4785                	li	a5,1
ffffffffc02029d0:	76f71063          	bne	a4,a5,ffffffffc0203130 <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02029d4:	4681                	li	a3,0
ffffffffc02029d6:	6605                	lui	a2,0x1
ffffffffc02029d8:	85d2                	mv	a1,s4
ffffffffc02029da:	c7bff0ef          	jal	ra,ffffffffc0202654 <page_insert>
ffffffffc02029de:	72051963          	bnez	a0,ffffffffc0203110 <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc02029e2:	000a2703          	lw	a4,0(s4)
ffffffffc02029e6:	4789                	li	a5,2
ffffffffc02029e8:	70f71463          	bne	a4,a5,ffffffffc02030f0 <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc02029ec:	000c2783          	lw	a5,0(s8)
ffffffffc02029f0:	6e079063          	bnez	a5,ffffffffc02030d0 <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02029f4:	00093503          	ld	a0,0(s2)
ffffffffc02029f8:	4601                	li	a2,0
ffffffffc02029fa:	6585                	lui	a1,0x1
ffffffffc02029fc:	d68ff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
ffffffffc0202a00:	6a050863          	beqz	a0,ffffffffc02030b0 <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc0202a04:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc0202a06:	00177793          	andi	a5,a4,1
ffffffffc0202a0a:	4a078563          	beqz	a5,ffffffffc0202eb4 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0202a0e:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202a10:	00271793          	slli	a5,a4,0x2
ffffffffc0202a14:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a16:	48d7fd63          	bgeu	a5,a3,ffffffffc0202eb0 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a1a:	000bb683          	ld	a3,0(s7)
ffffffffc0202a1e:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202a22:	97d6                	add	a5,a5,s5
ffffffffc0202a24:	079a                	slli	a5,a5,0x6
ffffffffc0202a26:	97b6                	add	a5,a5,a3
ffffffffc0202a28:	66fa1463          	bne	s4,a5,ffffffffc0203090 <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202a2c:	8b41                	andi	a4,a4,16
ffffffffc0202a2e:	64071163          	bnez	a4,ffffffffc0203070 <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc0202a32:	00093503          	ld	a0,0(s2)
ffffffffc0202a36:	4581                	li	a1,0
ffffffffc0202a38:	b81ff0ef          	jal	ra,ffffffffc02025b8 <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc0202a3c:	000a2c83          	lw	s9,0(s4)
ffffffffc0202a40:	4785                	li	a5,1
ffffffffc0202a42:	60fc9763          	bne	s9,a5,ffffffffc0203050 <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc0202a46:	000c2783          	lw	a5,0(s8)
ffffffffc0202a4a:	5e079363          	bnez	a5,ffffffffc0203030 <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc0202a4e:	00093503          	ld	a0,0(s2)
ffffffffc0202a52:	6585                	lui	a1,0x1
ffffffffc0202a54:	b65ff0ef          	jal	ra,ffffffffc02025b8 <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc0202a58:	000a2783          	lw	a5,0(s4)
ffffffffc0202a5c:	52079a63          	bnez	a5,ffffffffc0202f90 <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc0202a60:	000c2783          	lw	a5,0(s8)
ffffffffc0202a64:	50079663          	bnez	a5,ffffffffc0202f70 <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202a68:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202a6c:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a6e:	000a3683          	ld	a3,0(s4)
ffffffffc0202a72:	068a                	slli	a3,a3,0x2
ffffffffc0202a74:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a76:	42b6fd63          	bgeu	a3,a1,ffffffffc0202eb0 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a7a:	000bb503          	ld	a0,0(s7)
ffffffffc0202a7e:	96d6                	add	a3,a3,s5
ffffffffc0202a80:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc0202a82:	00d507b3          	add	a5,a0,a3
ffffffffc0202a86:	439c                	lw	a5,0(a5)
ffffffffc0202a88:	4d979463          	bne	a5,s9,ffffffffc0202f50 <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc0202a8c:	8699                	srai	a3,a3,0x6
ffffffffc0202a8e:	00080637          	lui	a2,0x80
ffffffffc0202a92:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc0202a94:	00c69713          	slli	a4,a3,0xc
ffffffffc0202a98:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202a9a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202a9c:	48b77e63          	bgeu	a4,a1,ffffffffc0202f38 <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc0202aa0:	0009b703          	ld	a4,0(s3)
ffffffffc0202aa4:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc0202aa6:	629c                	ld	a5,0(a3)
ffffffffc0202aa8:	078a                	slli	a5,a5,0x2
ffffffffc0202aaa:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202aac:	40b7f263          	bgeu	a5,a1,ffffffffc0202eb0 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202ab0:	8f91                	sub	a5,a5,a2
ffffffffc0202ab2:	079a                	slli	a5,a5,0x6
ffffffffc0202ab4:	953e                	add	a0,a0,a5
ffffffffc0202ab6:	100027f3          	csrr	a5,sstatus
ffffffffc0202aba:	8b89                	andi	a5,a5,2
ffffffffc0202abc:	30079963          	bnez	a5,ffffffffc0202dce <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc0202ac0:	000b3783          	ld	a5,0(s6)
ffffffffc0202ac4:	4585                	li	a1,1
ffffffffc0202ac6:	739c                	ld	a5,32(a5)
ffffffffc0202ac8:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202aca:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc0202ace:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ad0:	078a                	slli	a5,a5,0x2
ffffffffc0202ad2:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202ad4:	3ce7fe63          	bgeu	a5,a4,ffffffffc0202eb0 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202ad8:	000bb503          	ld	a0,0(s7)
ffffffffc0202adc:	fff80737          	lui	a4,0xfff80
ffffffffc0202ae0:	97ba                	add	a5,a5,a4
ffffffffc0202ae2:	079a                	slli	a5,a5,0x6
ffffffffc0202ae4:	953e                	add	a0,a0,a5
ffffffffc0202ae6:	100027f3          	csrr	a5,sstatus
ffffffffc0202aea:	8b89                	andi	a5,a5,2
ffffffffc0202aec:	2c079563          	bnez	a5,ffffffffc0202db6 <pmm_init+0x66c>
ffffffffc0202af0:	000b3783          	ld	a5,0(s6)
ffffffffc0202af4:	4585                	li	a1,1
ffffffffc0202af6:	739c                	ld	a5,32(a5)
ffffffffc0202af8:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202afa:	00093783          	ld	a5,0(s2)
ffffffffc0202afe:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd541ac>
    asm volatile("sfence.vma");
ffffffffc0202b02:	12000073          	sfence.vma
ffffffffc0202b06:	100027f3          	csrr	a5,sstatus
ffffffffc0202b0a:	8b89                	andi	a5,a5,2
ffffffffc0202b0c:	28079b63          	bnez	a5,ffffffffc0202da2 <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202b10:	000b3783          	ld	a5,0(s6)
ffffffffc0202b14:	779c                	ld	a5,40(a5)
ffffffffc0202b16:	9782                	jalr	a5
ffffffffc0202b18:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202b1a:	4b441b63          	bne	s0,s4,ffffffffc0202fd0 <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc0202b1e:	00004517          	auipc	a0,0x4
ffffffffc0202b22:	faa50513          	addi	a0,a0,-86 # ffffffffc0206ac8 <default_pmm_manager+0x560>
ffffffffc0202b26:	e6efd0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0202b2a:	100027f3          	csrr	a5,sstatus
ffffffffc0202b2e:	8b89                	andi	a5,a5,2
ffffffffc0202b30:	24079f63          	bnez	a5,ffffffffc0202d8e <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202b34:	000b3783          	ld	a5,0(s6)
ffffffffc0202b38:	779c                	ld	a5,40(a5)
ffffffffc0202b3a:	9782                	jalr	a5
ffffffffc0202b3c:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b3e:	6098                	ld	a4,0(s1)
ffffffffc0202b40:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b44:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b46:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b4a:	6a05                	lui	s4,0x1
ffffffffc0202b4c:	02f47c63          	bgeu	s0,a5,ffffffffc0202b84 <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202b50:	00c45793          	srli	a5,s0,0xc
ffffffffc0202b54:	00093503          	ld	a0,0(s2)
ffffffffc0202b58:	2ee7ff63          	bgeu	a5,a4,ffffffffc0202e56 <pmm_init+0x70c>
ffffffffc0202b5c:	0009b583          	ld	a1,0(s3)
ffffffffc0202b60:	4601                	li	a2,0
ffffffffc0202b62:	95a2                	add	a1,a1,s0
ffffffffc0202b64:	c00ff0ef          	jal	ra,ffffffffc0201f64 <get_pte>
ffffffffc0202b68:	32050463          	beqz	a0,ffffffffc0202e90 <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b6c:	611c                	ld	a5,0(a0)
ffffffffc0202b6e:	078a                	slli	a5,a5,0x2
ffffffffc0202b70:	0157f7b3          	and	a5,a5,s5
ffffffffc0202b74:	2e879e63          	bne	a5,s0,ffffffffc0202e70 <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b78:	6098                	ld	a4,0(s1)
ffffffffc0202b7a:	9452                	add	s0,s0,s4
ffffffffc0202b7c:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b80:	fcf468e3          	bltu	s0,a5,ffffffffc0202b50 <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc0202b84:	00093783          	ld	a5,0(s2)
ffffffffc0202b88:	639c                	ld	a5,0(a5)
ffffffffc0202b8a:	42079363          	bnez	a5,ffffffffc0202fb0 <pmm_init+0x866>
ffffffffc0202b8e:	100027f3          	csrr	a5,sstatus
ffffffffc0202b92:	8b89                	andi	a5,a5,2
ffffffffc0202b94:	24079963          	bnez	a5,ffffffffc0202de6 <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202b98:	000b3783          	ld	a5,0(s6)
ffffffffc0202b9c:	4505                	li	a0,1
ffffffffc0202b9e:	6f9c                	ld	a5,24(a5)
ffffffffc0202ba0:	9782                	jalr	a5
ffffffffc0202ba2:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202ba4:	00093503          	ld	a0,0(s2)
ffffffffc0202ba8:	4699                	li	a3,6
ffffffffc0202baa:	10000613          	li	a2,256
ffffffffc0202bae:	85d2                	mv	a1,s4
ffffffffc0202bb0:	aa5ff0ef          	jal	ra,ffffffffc0202654 <page_insert>
ffffffffc0202bb4:	44051e63          	bnez	a0,ffffffffc0203010 <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc0202bb8:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8c20>
ffffffffc0202bbc:	4785                	li	a5,1
ffffffffc0202bbe:	42f71963          	bne	a4,a5,ffffffffc0202ff0 <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0202bc2:	00093503          	ld	a0,0(s2)
ffffffffc0202bc6:	6405                	lui	s0,0x1
ffffffffc0202bc8:	4699                	li	a3,6
ffffffffc0202bca:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8b20>
ffffffffc0202bce:	85d2                	mv	a1,s4
ffffffffc0202bd0:	a85ff0ef          	jal	ra,ffffffffc0202654 <page_insert>
ffffffffc0202bd4:	72051363          	bnez	a0,ffffffffc02032fa <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0202bd8:	000a2703          	lw	a4,0(s4)
ffffffffc0202bdc:	4789                	li	a5,2
ffffffffc0202bde:	6ef71e63          	bne	a4,a5,ffffffffc02032da <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0202be2:	00004597          	auipc	a1,0x4
ffffffffc0202be6:	02e58593          	addi	a1,a1,46 # ffffffffc0206c10 <default_pmm_manager+0x6a8>
ffffffffc0202bea:	10000513          	li	a0,256
ffffffffc0202bee:	2a1020ef          	jal	ra,ffffffffc020568e <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0202bf2:	10040593          	addi	a1,s0,256
ffffffffc0202bf6:	10000513          	li	a0,256
ffffffffc0202bfa:	2a7020ef          	jal	ra,ffffffffc02056a0 <strcmp>
ffffffffc0202bfe:	6a051e63          	bnez	a0,ffffffffc02032ba <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0202c02:	000bb683          	ld	a3,0(s7)
ffffffffc0202c06:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0202c0a:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc0202c0c:	40da06b3          	sub	a3,s4,a3
ffffffffc0202c10:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0202c12:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0202c14:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0202c16:	8031                	srli	s0,s0,0xc
ffffffffc0202c18:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202c1c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202c1e:	30f77d63          	bgeu	a4,a5,ffffffffc0202f38 <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202c22:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202c26:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202c2a:	96be                	add	a3,a3,a5
ffffffffc0202c2c:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202c30:	229020ef          	jal	ra,ffffffffc0205658 <strlen>
ffffffffc0202c34:	66051363          	bnez	a0,ffffffffc020329a <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0202c38:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202c3c:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c3e:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd541ac>
ffffffffc0202c42:	068a                	slli	a3,a3,0x2
ffffffffc0202c44:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c46:	26f6f563          	bgeu	a3,a5,ffffffffc0202eb0 <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0202c4a:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0202c4c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202c4e:	2ef47563          	bgeu	s0,a5,ffffffffc0202f38 <pmm_init+0x7ee>
ffffffffc0202c52:	0009b403          	ld	s0,0(s3)
ffffffffc0202c56:	9436                	add	s0,s0,a3
ffffffffc0202c58:	100027f3          	csrr	a5,sstatus
ffffffffc0202c5c:	8b89                	andi	a5,a5,2
ffffffffc0202c5e:	1e079163          	bnez	a5,ffffffffc0202e40 <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc0202c62:	000b3783          	ld	a5,0(s6)
ffffffffc0202c66:	4585                	li	a1,1
ffffffffc0202c68:	8552                	mv	a0,s4
ffffffffc0202c6a:	739c                	ld	a5,32(a5)
ffffffffc0202c6c:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c6e:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc0202c70:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c72:	078a                	slli	a5,a5,0x2
ffffffffc0202c74:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c76:	22e7fd63          	bgeu	a5,a4,ffffffffc0202eb0 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c7a:	000bb503          	ld	a0,0(s7)
ffffffffc0202c7e:	fff80737          	lui	a4,0xfff80
ffffffffc0202c82:	97ba                	add	a5,a5,a4
ffffffffc0202c84:	079a                	slli	a5,a5,0x6
ffffffffc0202c86:	953e                	add	a0,a0,a5
ffffffffc0202c88:	100027f3          	csrr	a5,sstatus
ffffffffc0202c8c:	8b89                	andi	a5,a5,2
ffffffffc0202c8e:	18079d63          	bnez	a5,ffffffffc0202e28 <pmm_init+0x6de>
ffffffffc0202c92:	000b3783          	ld	a5,0(s6)
ffffffffc0202c96:	4585                	li	a1,1
ffffffffc0202c98:	739c                	ld	a5,32(a5)
ffffffffc0202c9a:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c9c:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc0202ca0:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ca2:	078a                	slli	a5,a5,0x2
ffffffffc0202ca4:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202ca6:	20e7f563          	bgeu	a5,a4,ffffffffc0202eb0 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202caa:	000bb503          	ld	a0,0(s7)
ffffffffc0202cae:	fff80737          	lui	a4,0xfff80
ffffffffc0202cb2:	97ba                	add	a5,a5,a4
ffffffffc0202cb4:	079a                	slli	a5,a5,0x6
ffffffffc0202cb6:	953e                	add	a0,a0,a5
ffffffffc0202cb8:	100027f3          	csrr	a5,sstatus
ffffffffc0202cbc:	8b89                	andi	a5,a5,2
ffffffffc0202cbe:	14079963          	bnez	a5,ffffffffc0202e10 <pmm_init+0x6c6>
ffffffffc0202cc2:	000b3783          	ld	a5,0(s6)
ffffffffc0202cc6:	4585                	li	a1,1
ffffffffc0202cc8:	739c                	ld	a5,32(a5)
ffffffffc0202cca:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202ccc:	00093783          	ld	a5,0(s2)
ffffffffc0202cd0:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0202cd4:	12000073          	sfence.vma
ffffffffc0202cd8:	100027f3          	csrr	a5,sstatus
ffffffffc0202cdc:	8b89                	andi	a5,a5,2
ffffffffc0202cde:	10079f63          	bnez	a5,ffffffffc0202dfc <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202ce2:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce6:	779c                	ld	a5,40(a5)
ffffffffc0202ce8:	9782                	jalr	a5
ffffffffc0202cea:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202cec:	4c8c1e63          	bne	s8,s0,ffffffffc02031c8 <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc0202cf0:	00004517          	auipc	a0,0x4
ffffffffc0202cf4:	f9850513          	addi	a0,a0,-104 # ffffffffc0206c88 <default_pmm_manager+0x720>
ffffffffc0202cf8:	c9cfd0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0202cfc:	7406                	ld	s0,96(sp)
ffffffffc0202cfe:	70a6                	ld	ra,104(sp)
ffffffffc0202d00:	64e6                	ld	s1,88(sp)
ffffffffc0202d02:	6946                	ld	s2,80(sp)
ffffffffc0202d04:	69a6                	ld	s3,72(sp)
ffffffffc0202d06:	6a06                	ld	s4,64(sp)
ffffffffc0202d08:	7ae2                	ld	s5,56(sp)
ffffffffc0202d0a:	7b42                	ld	s6,48(sp)
ffffffffc0202d0c:	7ba2                	ld	s7,40(sp)
ffffffffc0202d0e:	7c02                	ld	s8,32(sp)
ffffffffc0202d10:	6ce2                	ld	s9,24(sp)
ffffffffc0202d12:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0202d14:	f97fe06f          	j	ffffffffc0201caa <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0202d18:	c80007b7          	lui	a5,0xc8000
ffffffffc0202d1c:	bc7d                	j	ffffffffc02027da <pmm_init+0x90>
        intr_disable();
ffffffffc0202d1e:	c97fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202d22:	000b3783          	ld	a5,0(s6)
ffffffffc0202d26:	4505                	li	a0,1
ffffffffc0202d28:	6f9c                	ld	a5,24(a5)
ffffffffc0202d2a:	9782                	jalr	a5
ffffffffc0202d2c:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202d2e:	c81fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d32:	b9a9                	j	ffffffffc020298c <pmm_init+0x242>
        intr_disable();
ffffffffc0202d34:	c81fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202d38:	000b3783          	ld	a5,0(s6)
ffffffffc0202d3c:	4505                	li	a0,1
ffffffffc0202d3e:	6f9c                	ld	a5,24(a5)
ffffffffc0202d40:	9782                	jalr	a5
ffffffffc0202d42:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202d44:	c6bfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d48:	b645                	j	ffffffffc02028e8 <pmm_init+0x19e>
        intr_disable();
ffffffffc0202d4a:	c6bfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d4e:	000b3783          	ld	a5,0(s6)
ffffffffc0202d52:	779c                	ld	a5,40(a5)
ffffffffc0202d54:	9782                	jalr	a5
ffffffffc0202d56:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202d58:	c57fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d5c:	b6b9                	j	ffffffffc02028aa <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0202d5e:	6705                	lui	a4,0x1
ffffffffc0202d60:	177d                	addi	a4,a4,-1
ffffffffc0202d62:	96ba                	add	a3,a3,a4
ffffffffc0202d64:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc0202d66:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202d6a:	14a77363          	bgeu	a4,a0,ffffffffc0202eb0 <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc0202d6e:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc0202d72:	fff80537          	lui	a0,0xfff80
ffffffffc0202d76:	972a                	add	a4,a4,a0
ffffffffc0202d78:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0202d7a:	8c1d                	sub	s0,s0,a5
ffffffffc0202d7c:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0202d80:	00c45593          	srli	a1,s0,0xc
ffffffffc0202d84:	9532                	add	a0,a0,a2
ffffffffc0202d86:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202d88:	0009b583          	ld	a1,0(s3)
}
ffffffffc0202d8c:	b4c1                	j	ffffffffc020284c <pmm_init+0x102>
        intr_disable();
ffffffffc0202d8e:	c27fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d92:	000b3783          	ld	a5,0(s6)
ffffffffc0202d96:	779c                	ld	a5,40(a5)
ffffffffc0202d98:	9782                	jalr	a5
ffffffffc0202d9a:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202d9c:	c13fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202da0:	bb79                	j	ffffffffc0202b3e <pmm_init+0x3f4>
        intr_disable();
ffffffffc0202da2:	c13fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202da6:	000b3783          	ld	a5,0(s6)
ffffffffc0202daa:	779c                	ld	a5,40(a5)
ffffffffc0202dac:	9782                	jalr	a5
ffffffffc0202dae:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202db0:	bfffd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202db4:	b39d                	j	ffffffffc0202b1a <pmm_init+0x3d0>
ffffffffc0202db6:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202db8:	bfdfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202dbc:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc0:	6522                	ld	a0,8(sp)
ffffffffc0202dc2:	4585                	li	a1,1
ffffffffc0202dc4:	739c                	ld	a5,32(a5)
ffffffffc0202dc6:	9782                	jalr	a5
        intr_enable();
ffffffffc0202dc8:	be7fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202dcc:	b33d                	j	ffffffffc0202afa <pmm_init+0x3b0>
ffffffffc0202dce:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202dd0:	be5fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202dd4:	000b3783          	ld	a5,0(s6)
ffffffffc0202dd8:	6522                	ld	a0,8(sp)
ffffffffc0202dda:	4585                	li	a1,1
ffffffffc0202ddc:	739c                	ld	a5,32(a5)
ffffffffc0202dde:	9782                	jalr	a5
        intr_enable();
ffffffffc0202de0:	bcffd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202de4:	b1dd                	j	ffffffffc0202aca <pmm_init+0x380>
        intr_disable();
ffffffffc0202de6:	bcffd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202dea:	000b3783          	ld	a5,0(s6)
ffffffffc0202dee:	4505                	li	a0,1
ffffffffc0202df0:	6f9c                	ld	a5,24(a5)
ffffffffc0202df2:	9782                	jalr	a5
ffffffffc0202df4:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202df6:	bb9fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202dfa:	b36d                	j	ffffffffc0202ba4 <pmm_init+0x45a>
        intr_disable();
ffffffffc0202dfc:	bb9fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202e00:	000b3783          	ld	a5,0(s6)
ffffffffc0202e04:	779c                	ld	a5,40(a5)
ffffffffc0202e06:	9782                	jalr	a5
ffffffffc0202e08:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202e0a:	ba5fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e0e:	bdf9                	j	ffffffffc0202cec <pmm_init+0x5a2>
ffffffffc0202e10:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202e12:	ba3fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202e16:	000b3783          	ld	a5,0(s6)
ffffffffc0202e1a:	6522                	ld	a0,8(sp)
ffffffffc0202e1c:	4585                	li	a1,1
ffffffffc0202e1e:	739c                	ld	a5,32(a5)
ffffffffc0202e20:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e22:	b8dfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e26:	b55d                	j	ffffffffc0202ccc <pmm_init+0x582>
ffffffffc0202e28:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202e2a:	b8bfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202e2e:	000b3783          	ld	a5,0(s6)
ffffffffc0202e32:	6522                	ld	a0,8(sp)
ffffffffc0202e34:	4585                	li	a1,1
ffffffffc0202e36:	739c                	ld	a5,32(a5)
ffffffffc0202e38:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e3a:	b75fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e3e:	bdb9                	j	ffffffffc0202c9c <pmm_init+0x552>
        intr_disable();
ffffffffc0202e40:	b75fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202e44:	000b3783          	ld	a5,0(s6)
ffffffffc0202e48:	4585                	li	a1,1
ffffffffc0202e4a:	8552                	mv	a0,s4
ffffffffc0202e4c:	739c                	ld	a5,32(a5)
ffffffffc0202e4e:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e50:	b5ffd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e54:	bd29                	j	ffffffffc0202c6e <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e56:	86a2                	mv	a3,s0
ffffffffc0202e58:	00003617          	auipc	a2,0x3
ffffffffc0202e5c:	74860613          	addi	a2,a2,1864 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0202e60:	24000593          	li	a1,576
ffffffffc0202e64:	00004517          	auipc	a0,0x4
ffffffffc0202e68:	85450513          	addi	a0,a0,-1964 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202e6c:	e22fd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202e70:	00004697          	auipc	a3,0x4
ffffffffc0202e74:	cb868693          	addi	a3,a3,-840 # ffffffffc0206b28 <default_pmm_manager+0x5c0>
ffffffffc0202e78:	00003617          	auipc	a2,0x3
ffffffffc0202e7c:	34060613          	addi	a2,a2,832 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202e80:	24100593          	li	a1,577
ffffffffc0202e84:	00004517          	auipc	a0,0x4
ffffffffc0202e88:	83450513          	addi	a0,a0,-1996 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202e8c:	e02fd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e90:	00004697          	auipc	a3,0x4
ffffffffc0202e94:	c5868693          	addi	a3,a3,-936 # ffffffffc0206ae8 <default_pmm_manager+0x580>
ffffffffc0202e98:	00003617          	auipc	a2,0x3
ffffffffc0202e9c:	32060613          	addi	a2,a2,800 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202ea0:	24000593          	li	a1,576
ffffffffc0202ea4:	00004517          	auipc	a0,0x4
ffffffffc0202ea8:	81450513          	addi	a0,a0,-2028 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202eac:	de2fd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202eb0:	fc5fe0ef          	jal	ra,ffffffffc0201e74 <pa2page.part.0>
ffffffffc0202eb4:	fddfe0ef          	jal	ra,ffffffffc0201e90 <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202eb8:	00004697          	auipc	a3,0x4
ffffffffc0202ebc:	a2868693          	addi	a3,a3,-1496 # ffffffffc02068e0 <default_pmm_manager+0x378>
ffffffffc0202ec0:	00003617          	auipc	a2,0x3
ffffffffc0202ec4:	2f860613          	addi	a2,a2,760 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202ec8:	21000593          	li	a1,528
ffffffffc0202ecc:	00003517          	auipc	a0,0x3
ffffffffc0202ed0:	7ec50513          	addi	a0,a0,2028 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202ed4:	dbafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202ed8:	00004697          	auipc	a3,0x4
ffffffffc0202edc:	94868693          	addi	a3,a3,-1720 # ffffffffc0206820 <default_pmm_manager+0x2b8>
ffffffffc0202ee0:	00003617          	auipc	a2,0x3
ffffffffc0202ee4:	2d860613          	addi	a2,a2,728 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202ee8:	20300593          	li	a1,515
ffffffffc0202eec:	00003517          	auipc	a0,0x3
ffffffffc0202ef0:	7cc50513          	addi	a0,a0,1996 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202ef4:	d9afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202ef8:	00004697          	auipc	a3,0x4
ffffffffc0202efc:	8e868693          	addi	a3,a3,-1816 # ffffffffc02067e0 <default_pmm_manager+0x278>
ffffffffc0202f00:	00003617          	auipc	a2,0x3
ffffffffc0202f04:	2b860613          	addi	a2,a2,696 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202f08:	20200593          	li	a1,514
ffffffffc0202f0c:	00003517          	auipc	a0,0x3
ffffffffc0202f10:	7ac50513          	addi	a0,a0,1964 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202f14:	d7afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202f18:	00004697          	auipc	a3,0x4
ffffffffc0202f1c:	8a868693          	addi	a3,a3,-1880 # ffffffffc02067c0 <default_pmm_manager+0x258>
ffffffffc0202f20:	00003617          	auipc	a2,0x3
ffffffffc0202f24:	29860613          	addi	a2,a2,664 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202f28:	20100593          	li	a1,513
ffffffffc0202f2c:	00003517          	auipc	a0,0x3
ffffffffc0202f30:	78c50513          	addi	a0,a0,1932 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202f34:	d5afd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202f38:	00003617          	auipc	a2,0x3
ffffffffc0202f3c:	66860613          	addi	a2,a2,1640 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0202f40:	07100593          	li	a1,113
ffffffffc0202f44:	00003517          	auipc	a0,0x3
ffffffffc0202f48:	68450513          	addi	a0,a0,1668 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0202f4c:	d42fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202f50:	00004697          	auipc	a3,0x4
ffffffffc0202f54:	b2068693          	addi	a3,a3,-1248 # ffffffffc0206a70 <default_pmm_manager+0x508>
ffffffffc0202f58:	00003617          	auipc	a2,0x3
ffffffffc0202f5c:	26060613          	addi	a2,a2,608 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202f60:	22900593          	li	a1,553
ffffffffc0202f64:	00003517          	auipc	a0,0x3
ffffffffc0202f68:	75450513          	addi	a0,a0,1876 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202f6c:	d22fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202f70:	00004697          	auipc	a3,0x4
ffffffffc0202f74:	ab868693          	addi	a3,a3,-1352 # ffffffffc0206a28 <default_pmm_manager+0x4c0>
ffffffffc0202f78:	00003617          	auipc	a2,0x3
ffffffffc0202f7c:	24060613          	addi	a2,a2,576 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202f80:	22700593          	li	a1,551
ffffffffc0202f84:	00003517          	auipc	a0,0x3
ffffffffc0202f88:	73450513          	addi	a0,a0,1844 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202f8c:	d02fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 0);
ffffffffc0202f90:	00004697          	auipc	a3,0x4
ffffffffc0202f94:	ac868693          	addi	a3,a3,-1336 # ffffffffc0206a58 <default_pmm_manager+0x4f0>
ffffffffc0202f98:	00003617          	auipc	a2,0x3
ffffffffc0202f9c:	22060613          	addi	a2,a2,544 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202fa0:	22600593          	li	a1,550
ffffffffc0202fa4:	00003517          	auipc	a0,0x3
ffffffffc0202fa8:	71450513          	addi	a0,a0,1812 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202fac:	ce2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc0202fb0:	00004697          	auipc	a3,0x4
ffffffffc0202fb4:	b9068693          	addi	a3,a3,-1136 # ffffffffc0206b40 <default_pmm_manager+0x5d8>
ffffffffc0202fb8:	00003617          	auipc	a2,0x3
ffffffffc0202fbc:	20060613          	addi	a2,a2,512 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202fc0:	24400593          	li	a1,580
ffffffffc0202fc4:	00003517          	auipc	a0,0x3
ffffffffc0202fc8:	6f450513          	addi	a0,a0,1780 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202fcc:	cc2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0202fd0:	00004697          	auipc	a3,0x4
ffffffffc0202fd4:	ad068693          	addi	a3,a3,-1328 # ffffffffc0206aa0 <default_pmm_manager+0x538>
ffffffffc0202fd8:	00003617          	auipc	a2,0x3
ffffffffc0202fdc:	1e060613          	addi	a2,a2,480 # ffffffffc02061b8 <commands+0x828>
ffffffffc0202fe0:	23100593          	li	a1,561
ffffffffc0202fe4:	00003517          	auipc	a0,0x3
ffffffffc0202fe8:	6d450513          	addi	a0,a0,1748 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0202fec:	ca2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 1);
ffffffffc0202ff0:	00004697          	auipc	a3,0x4
ffffffffc0202ff4:	ba868693          	addi	a3,a3,-1112 # ffffffffc0206b98 <default_pmm_manager+0x630>
ffffffffc0202ff8:	00003617          	auipc	a2,0x3
ffffffffc0202ffc:	1c060613          	addi	a2,a2,448 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203000:	24900593          	li	a1,585
ffffffffc0203004:	00003517          	auipc	a0,0x3
ffffffffc0203008:	6b450513          	addi	a0,a0,1716 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020300c:	c82fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0203010:	00004697          	auipc	a3,0x4
ffffffffc0203014:	b4868693          	addi	a3,a3,-1208 # ffffffffc0206b58 <default_pmm_manager+0x5f0>
ffffffffc0203018:	00003617          	auipc	a2,0x3
ffffffffc020301c:	1a060613          	addi	a2,a2,416 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203020:	24800593          	li	a1,584
ffffffffc0203024:	00003517          	auipc	a0,0x3
ffffffffc0203028:	69450513          	addi	a0,a0,1684 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020302c:	c62fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0203030:	00004697          	auipc	a3,0x4
ffffffffc0203034:	9f868693          	addi	a3,a3,-1544 # ffffffffc0206a28 <default_pmm_manager+0x4c0>
ffffffffc0203038:	00003617          	auipc	a2,0x3
ffffffffc020303c:	18060613          	addi	a2,a2,384 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203040:	22300593          	li	a1,547
ffffffffc0203044:	00003517          	auipc	a0,0x3
ffffffffc0203048:	67450513          	addi	a0,a0,1652 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020304c:	c42fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0203050:	00004697          	auipc	a3,0x4
ffffffffc0203054:	87868693          	addi	a3,a3,-1928 # ffffffffc02068c8 <default_pmm_manager+0x360>
ffffffffc0203058:	00003617          	auipc	a2,0x3
ffffffffc020305c:	16060613          	addi	a2,a2,352 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203060:	22200593          	li	a1,546
ffffffffc0203064:	00003517          	auipc	a0,0x3
ffffffffc0203068:	65450513          	addi	a0,a0,1620 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020306c:	c22fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc0203070:	00004697          	auipc	a3,0x4
ffffffffc0203074:	9d068693          	addi	a3,a3,-1584 # ffffffffc0206a40 <default_pmm_manager+0x4d8>
ffffffffc0203078:	00003617          	auipc	a2,0x3
ffffffffc020307c:	14060613          	addi	a2,a2,320 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203080:	21f00593          	li	a1,543
ffffffffc0203084:	00003517          	auipc	a0,0x3
ffffffffc0203088:	63450513          	addi	a0,a0,1588 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020308c:	c02fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0203090:	00004697          	auipc	a3,0x4
ffffffffc0203094:	82068693          	addi	a3,a3,-2016 # ffffffffc02068b0 <default_pmm_manager+0x348>
ffffffffc0203098:	00003617          	auipc	a2,0x3
ffffffffc020309c:	12060613          	addi	a2,a2,288 # ffffffffc02061b8 <commands+0x828>
ffffffffc02030a0:	21e00593          	li	a1,542
ffffffffc02030a4:	00003517          	auipc	a0,0x3
ffffffffc02030a8:	61450513          	addi	a0,a0,1556 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02030ac:	be2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02030b0:	00004697          	auipc	a3,0x4
ffffffffc02030b4:	8a068693          	addi	a3,a3,-1888 # ffffffffc0206950 <default_pmm_manager+0x3e8>
ffffffffc02030b8:	00003617          	auipc	a2,0x3
ffffffffc02030bc:	10060613          	addi	a2,a2,256 # ffffffffc02061b8 <commands+0x828>
ffffffffc02030c0:	21d00593          	li	a1,541
ffffffffc02030c4:	00003517          	auipc	a0,0x3
ffffffffc02030c8:	5f450513          	addi	a0,a0,1524 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02030cc:	bc2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc02030d0:	00004697          	auipc	a3,0x4
ffffffffc02030d4:	95868693          	addi	a3,a3,-1704 # ffffffffc0206a28 <default_pmm_manager+0x4c0>
ffffffffc02030d8:	00003617          	auipc	a2,0x3
ffffffffc02030dc:	0e060613          	addi	a2,a2,224 # ffffffffc02061b8 <commands+0x828>
ffffffffc02030e0:	21c00593          	li	a1,540
ffffffffc02030e4:	00003517          	auipc	a0,0x3
ffffffffc02030e8:	5d450513          	addi	a0,a0,1492 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02030ec:	ba2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 2);
ffffffffc02030f0:	00004697          	auipc	a3,0x4
ffffffffc02030f4:	92068693          	addi	a3,a3,-1760 # ffffffffc0206a10 <default_pmm_manager+0x4a8>
ffffffffc02030f8:	00003617          	auipc	a2,0x3
ffffffffc02030fc:	0c060613          	addi	a2,a2,192 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203100:	21b00593          	li	a1,539
ffffffffc0203104:	00003517          	auipc	a0,0x3
ffffffffc0203108:	5b450513          	addi	a0,a0,1460 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020310c:	b82fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc0203110:	00004697          	auipc	a3,0x4
ffffffffc0203114:	8d068693          	addi	a3,a3,-1840 # ffffffffc02069e0 <default_pmm_manager+0x478>
ffffffffc0203118:	00003617          	auipc	a2,0x3
ffffffffc020311c:	0a060613          	addi	a2,a2,160 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203120:	21a00593          	li	a1,538
ffffffffc0203124:	00003517          	auipc	a0,0x3
ffffffffc0203128:	59450513          	addi	a0,a0,1428 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020312c:	b62fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 1);
ffffffffc0203130:	00004697          	auipc	a3,0x4
ffffffffc0203134:	89868693          	addi	a3,a3,-1896 # ffffffffc02069c8 <default_pmm_manager+0x460>
ffffffffc0203138:	00003617          	auipc	a2,0x3
ffffffffc020313c:	08060613          	addi	a2,a2,128 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203140:	21800593          	li	a1,536
ffffffffc0203144:	00003517          	auipc	a0,0x3
ffffffffc0203148:	57450513          	addi	a0,a0,1396 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020314c:	b42fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc0203150:	00004697          	auipc	a3,0x4
ffffffffc0203154:	85868693          	addi	a3,a3,-1960 # ffffffffc02069a8 <default_pmm_manager+0x440>
ffffffffc0203158:	00003617          	auipc	a2,0x3
ffffffffc020315c:	06060613          	addi	a2,a2,96 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203160:	21700593          	li	a1,535
ffffffffc0203164:	00003517          	auipc	a0,0x3
ffffffffc0203168:	55450513          	addi	a0,a0,1364 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020316c:	b22fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_W);
ffffffffc0203170:	00004697          	auipc	a3,0x4
ffffffffc0203174:	82868693          	addi	a3,a3,-2008 # ffffffffc0206998 <default_pmm_manager+0x430>
ffffffffc0203178:	00003617          	auipc	a2,0x3
ffffffffc020317c:	04060613          	addi	a2,a2,64 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203180:	21600593          	li	a1,534
ffffffffc0203184:	00003517          	auipc	a0,0x3
ffffffffc0203188:	53450513          	addi	a0,a0,1332 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020318c:	b02fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_U);
ffffffffc0203190:	00003697          	auipc	a3,0x3
ffffffffc0203194:	7f868693          	addi	a3,a3,2040 # ffffffffc0206988 <default_pmm_manager+0x420>
ffffffffc0203198:	00003617          	auipc	a2,0x3
ffffffffc020319c:	02060613          	addi	a2,a2,32 # ffffffffc02061b8 <commands+0x828>
ffffffffc02031a0:	21500593          	li	a1,533
ffffffffc02031a4:	00003517          	auipc	a0,0x3
ffffffffc02031a8:	51450513          	addi	a0,a0,1300 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02031ac:	ae2fd0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("DTB memory info not available");
ffffffffc02031b0:	00003617          	auipc	a2,0x3
ffffffffc02031b4:	57860613          	addi	a2,a2,1400 # ffffffffc0206728 <default_pmm_manager+0x1c0>
ffffffffc02031b8:	06500593          	li	a1,101
ffffffffc02031bc:	00003517          	auipc	a0,0x3
ffffffffc02031c0:	4fc50513          	addi	a0,a0,1276 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02031c4:	acafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc02031c8:	00004697          	auipc	a3,0x4
ffffffffc02031cc:	8d868693          	addi	a3,a3,-1832 # ffffffffc0206aa0 <default_pmm_manager+0x538>
ffffffffc02031d0:	00003617          	auipc	a2,0x3
ffffffffc02031d4:	fe860613          	addi	a2,a2,-24 # ffffffffc02061b8 <commands+0x828>
ffffffffc02031d8:	25b00593          	li	a1,603
ffffffffc02031dc:	00003517          	auipc	a0,0x3
ffffffffc02031e0:	4dc50513          	addi	a0,a0,1244 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02031e4:	aaafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02031e8:	00003697          	auipc	a3,0x3
ffffffffc02031ec:	76868693          	addi	a3,a3,1896 # ffffffffc0206950 <default_pmm_manager+0x3e8>
ffffffffc02031f0:	00003617          	auipc	a2,0x3
ffffffffc02031f4:	fc860613          	addi	a2,a2,-56 # ffffffffc02061b8 <commands+0x828>
ffffffffc02031f8:	21400593          	li	a1,532
ffffffffc02031fc:	00003517          	auipc	a0,0x3
ffffffffc0203200:	4bc50513          	addi	a0,a0,1212 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203204:	a8afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0203208:	00003697          	auipc	a3,0x3
ffffffffc020320c:	70868693          	addi	a3,a3,1800 # ffffffffc0206910 <default_pmm_manager+0x3a8>
ffffffffc0203210:	00003617          	auipc	a2,0x3
ffffffffc0203214:	fa860613          	addi	a2,a2,-88 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203218:	21300593          	li	a1,531
ffffffffc020321c:	00003517          	auipc	a0,0x3
ffffffffc0203220:	49c50513          	addi	a0,a0,1180 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203224:	a6afd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0203228:	86d6                	mv	a3,s5
ffffffffc020322a:	00003617          	auipc	a2,0x3
ffffffffc020322e:	37660613          	addi	a2,a2,886 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0203232:	20f00593          	li	a1,527
ffffffffc0203236:	00003517          	auipc	a0,0x3
ffffffffc020323a:	48250513          	addi	a0,a0,1154 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020323e:	a50fd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0203242:	00003617          	auipc	a2,0x3
ffffffffc0203246:	35e60613          	addi	a2,a2,862 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc020324a:	20e00593          	li	a1,526
ffffffffc020324e:	00003517          	auipc	a0,0x3
ffffffffc0203252:	46a50513          	addi	a0,a0,1130 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203256:	a38fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc020325a:	00003697          	auipc	a3,0x3
ffffffffc020325e:	66e68693          	addi	a3,a3,1646 # ffffffffc02068c8 <default_pmm_manager+0x360>
ffffffffc0203262:	00003617          	auipc	a2,0x3
ffffffffc0203266:	f5660613          	addi	a2,a2,-170 # ffffffffc02061b8 <commands+0x828>
ffffffffc020326a:	20c00593          	li	a1,524
ffffffffc020326e:	00003517          	auipc	a0,0x3
ffffffffc0203272:	44a50513          	addi	a0,a0,1098 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203276:	a18fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc020327a:	00003697          	auipc	a3,0x3
ffffffffc020327e:	63668693          	addi	a3,a3,1590 # ffffffffc02068b0 <default_pmm_manager+0x348>
ffffffffc0203282:	00003617          	auipc	a2,0x3
ffffffffc0203286:	f3660613          	addi	a2,a2,-202 # ffffffffc02061b8 <commands+0x828>
ffffffffc020328a:	20b00593          	li	a1,523
ffffffffc020328e:	00003517          	auipc	a0,0x3
ffffffffc0203292:	42a50513          	addi	a0,a0,1066 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203296:	9f8fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc020329a:	00004697          	auipc	a3,0x4
ffffffffc020329e:	9c668693          	addi	a3,a3,-1594 # ffffffffc0206c60 <default_pmm_manager+0x6f8>
ffffffffc02032a2:	00003617          	auipc	a2,0x3
ffffffffc02032a6:	f1660613          	addi	a2,a2,-234 # ffffffffc02061b8 <commands+0x828>
ffffffffc02032aa:	25200593          	li	a1,594
ffffffffc02032ae:	00003517          	auipc	a0,0x3
ffffffffc02032b2:	40a50513          	addi	a0,a0,1034 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02032b6:	9d8fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc02032ba:	00004697          	auipc	a3,0x4
ffffffffc02032be:	96e68693          	addi	a3,a3,-1682 # ffffffffc0206c28 <default_pmm_manager+0x6c0>
ffffffffc02032c2:	00003617          	auipc	a2,0x3
ffffffffc02032c6:	ef660613          	addi	a2,a2,-266 # ffffffffc02061b8 <commands+0x828>
ffffffffc02032ca:	24f00593          	li	a1,591
ffffffffc02032ce:	00003517          	auipc	a0,0x3
ffffffffc02032d2:	3ea50513          	addi	a0,a0,1002 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02032d6:	9b8fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 2);
ffffffffc02032da:	00004697          	auipc	a3,0x4
ffffffffc02032de:	91e68693          	addi	a3,a3,-1762 # ffffffffc0206bf8 <default_pmm_manager+0x690>
ffffffffc02032e2:	00003617          	auipc	a2,0x3
ffffffffc02032e6:	ed660613          	addi	a2,a2,-298 # ffffffffc02061b8 <commands+0x828>
ffffffffc02032ea:	24b00593          	li	a1,587
ffffffffc02032ee:	00003517          	auipc	a0,0x3
ffffffffc02032f2:	3ca50513          	addi	a0,a0,970 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02032f6:	998fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc02032fa:	00004697          	auipc	a3,0x4
ffffffffc02032fe:	8b668693          	addi	a3,a3,-1866 # ffffffffc0206bb0 <default_pmm_manager+0x648>
ffffffffc0203302:	00003617          	auipc	a2,0x3
ffffffffc0203306:	eb660613          	addi	a2,a2,-330 # ffffffffc02061b8 <commands+0x828>
ffffffffc020330a:	24a00593          	li	a1,586
ffffffffc020330e:	00003517          	auipc	a0,0x3
ffffffffc0203312:	3aa50513          	addi	a0,a0,938 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203316:	978fd0ef          	jal	ra,ffffffffc020048e <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc020331a:	00003617          	auipc	a2,0x3
ffffffffc020331e:	32e60613          	addi	a2,a2,814 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc0203322:	0c900593          	li	a1,201
ffffffffc0203326:	00003517          	auipc	a0,0x3
ffffffffc020332a:	39250513          	addi	a0,a0,914 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc020332e:	960fd0ef          	jal	ra,ffffffffc020048e <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0203332:	00003617          	auipc	a2,0x3
ffffffffc0203336:	31660613          	addi	a2,a2,790 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc020333a:	08100593          	li	a1,129
ffffffffc020333e:	00003517          	auipc	a0,0x3
ffffffffc0203342:	37a50513          	addi	a0,a0,890 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203346:	948fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc020334a:	00003697          	auipc	a3,0x3
ffffffffc020334e:	53668693          	addi	a3,a3,1334 # ffffffffc0206880 <default_pmm_manager+0x318>
ffffffffc0203352:	00003617          	auipc	a2,0x3
ffffffffc0203356:	e6660613          	addi	a2,a2,-410 # ffffffffc02061b8 <commands+0x828>
ffffffffc020335a:	20a00593          	li	a1,522
ffffffffc020335e:	00003517          	auipc	a0,0x3
ffffffffc0203362:	35a50513          	addi	a0,a0,858 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203366:	928fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc020336a:	00003697          	auipc	a3,0x3
ffffffffc020336e:	4e668693          	addi	a3,a3,1254 # ffffffffc0206850 <default_pmm_manager+0x2e8>
ffffffffc0203372:	00003617          	auipc	a2,0x3
ffffffffc0203376:	e4660613          	addi	a2,a2,-442 # ffffffffc02061b8 <commands+0x828>
ffffffffc020337a:	20700593          	li	a1,519
ffffffffc020337e:	00003517          	auipc	a0,0x3
ffffffffc0203382:	33a50513          	addi	a0,a0,826 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203386:	908fd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020338a <copy_range>:
{
ffffffffc020338a:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020338c:	00d667b3          	or	a5,a2,a3
{
ffffffffc0203390:	f486                	sd	ra,104(sp)
ffffffffc0203392:	f0a2                	sd	s0,96(sp)
ffffffffc0203394:	eca6                	sd	s1,88(sp)
ffffffffc0203396:	e8ca                	sd	s2,80(sp)
ffffffffc0203398:	e4ce                	sd	s3,72(sp)
ffffffffc020339a:	e0d2                	sd	s4,64(sp)
ffffffffc020339c:	fc56                	sd	s5,56(sp)
ffffffffc020339e:	f85a                	sd	s6,48(sp)
ffffffffc02033a0:	f45e                	sd	s7,40(sp)
ffffffffc02033a2:	f062                	sd	s8,32(sp)
ffffffffc02033a4:	ec66                	sd	s9,24(sp)
ffffffffc02033a6:	e86a                	sd	s10,16(sp)
ffffffffc02033a8:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02033aa:	17d2                	slli	a5,a5,0x34
ffffffffc02033ac:	22079563          	bnez	a5,ffffffffc02035d6 <copy_range+0x24c>
    assert(USER_ACCESS(start, end));
ffffffffc02033b0:	002007b7          	lui	a5,0x200
ffffffffc02033b4:	8432                	mv	s0,a2
ffffffffc02033b6:	1af66863          	bltu	a2,a5,ffffffffc0203566 <copy_range+0x1dc>
ffffffffc02033ba:	8936                	mv	s2,a3
ffffffffc02033bc:	1ad67563          	bgeu	a2,a3,ffffffffc0203566 <copy_range+0x1dc>
ffffffffc02033c0:	4785                	li	a5,1
ffffffffc02033c2:	07fe                	slli	a5,a5,0x1f
ffffffffc02033c4:	1ad7e163          	bltu	a5,a3,ffffffffc0203566 <copy_range+0x1dc>
ffffffffc02033c8:	5b7d                	li	s6,-1
ffffffffc02033ca:	8aaa                	mv	s5,a0
ffffffffc02033cc:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc02033ce:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc02033d0:	000a8c17          	auipc	s8,0xa8
ffffffffc02033d4:	a48c0c13          	addi	s8,s8,-1464 # ffffffffc02aae18 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02033d8:	000a8b97          	auipc	s7,0xa8
ffffffffc02033dc:	a48b8b93          	addi	s7,s7,-1464 # ffffffffc02aae20 <pages>
    return KADDR(page2pa(page));
ffffffffc02033e0:	00cb5b13          	srli	s6,s6,0xc
        page = pmm_manager->alloc_pages(n);
ffffffffc02033e4:	000a8c97          	auipc	s9,0xa8
ffffffffc02033e8:	a44c8c93          	addi	s9,s9,-1468 # ffffffffc02aae28 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02033ec:	4601                	li	a2,0
ffffffffc02033ee:	85a2                	mv	a1,s0
ffffffffc02033f0:	854e                	mv	a0,s3
ffffffffc02033f2:	b73fe0ef          	jal	ra,ffffffffc0201f64 <get_pte>
ffffffffc02033f6:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc02033f8:	c965                	beqz	a0,ffffffffc02034e8 <copy_range+0x15e>
        if (*ptep & PTE_V)
ffffffffc02033fa:	611c                	ld	a5,0(a0)
ffffffffc02033fc:	8b85                	andi	a5,a5,1
ffffffffc02033fe:	e78d                	bnez	a5,ffffffffc0203428 <copy_range+0x9e>
        start += PGSIZE;
ffffffffc0203400:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0203402:	ff2465e3          	bltu	s0,s2,ffffffffc02033ec <copy_range+0x62>
    return 0;
ffffffffc0203406:	4481                	li	s1,0
}
ffffffffc0203408:	70a6                	ld	ra,104(sp)
ffffffffc020340a:	7406                	ld	s0,96(sp)
ffffffffc020340c:	6946                	ld	s2,80(sp)
ffffffffc020340e:	69a6                	ld	s3,72(sp)
ffffffffc0203410:	6a06                	ld	s4,64(sp)
ffffffffc0203412:	7ae2                	ld	s5,56(sp)
ffffffffc0203414:	7b42                	ld	s6,48(sp)
ffffffffc0203416:	7ba2                	ld	s7,40(sp)
ffffffffc0203418:	7c02                	ld	s8,32(sp)
ffffffffc020341a:	6ce2                	ld	s9,24(sp)
ffffffffc020341c:	6d42                	ld	s10,16(sp)
ffffffffc020341e:	6da2                	ld	s11,8(sp)
ffffffffc0203420:	8526                	mv	a0,s1
ffffffffc0203422:	64e6                	ld	s1,88(sp)
ffffffffc0203424:	6165                	addi	sp,sp,112
ffffffffc0203426:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc0203428:	4605                	li	a2,1
ffffffffc020342a:	85a2                	mv	a1,s0
ffffffffc020342c:	8556                	mv	a0,s5
ffffffffc020342e:	b37fe0ef          	jal	ra,ffffffffc0201f64 <get_pte>
ffffffffc0203432:	c165                	beqz	a0,ffffffffc0203512 <copy_range+0x188>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0203434:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V))
ffffffffc0203436:	0017f713          	andi	a4,a5,1
ffffffffc020343a:	01f7f493          	andi	s1,a5,31
ffffffffc020343e:	18070063          	beqz	a4,ffffffffc02035be <copy_range+0x234>
    if (PPN(pa) >= npage)
ffffffffc0203442:	000c3683          	ld	a3,0(s8)
    return pa2page(PTE_ADDR(pte));
ffffffffc0203446:	078a                	slli	a5,a5,0x2
ffffffffc0203448:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020344c:	14d77d63          	bgeu	a4,a3,ffffffffc02035a6 <copy_range+0x21c>
    return &pages[PPN(pa) - nbase];
ffffffffc0203450:	000bb783          	ld	a5,0(s7)
ffffffffc0203454:	fff806b7          	lui	a3,0xfff80
ffffffffc0203458:	9736                	add	a4,a4,a3
ffffffffc020345a:	071a                	slli	a4,a4,0x6
ffffffffc020345c:	00e78db3          	add	s11,a5,a4
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203460:	10002773          	csrr	a4,sstatus
ffffffffc0203464:	8b09                	andi	a4,a4,2
ffffffffc0203466:	eb59                	bnez	a4,ffffffffc02034fc <copy_range+0x172>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203468:	000cb703          	ld	a4,0(s9)
ffffffffc020346c:	4505                	li	a0,1
ffffffffc020346e:	6f18                	ld	a4,24(a4)
ffffffffc0203470:	9702                	jalr	a4
ffffffffc0203472:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0203474:	0c0d8963          	beqz	s11,ffffffffc0203546 <copy_range+0x1bc>
            assert(npage != NULL);
ffffffffc0203478:	100d0763          	beqz	s10,ffffffffc0203586 <copy_range+0x1fc>
    return page - pages + nbase;
ffffffffc020347c:	000bb703          	ld	a4,0(s7)
ffffffffc0203480:	000805b7          	lui	a1,0x80
    return KADDR(page2pa(page));
ffffffffc0203484:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0203488:	40ed86b3          	sub	a3,s11,a4
ffffffffc020348c:	8699                	srai	a3,a3,0x6
ffffffffc020348e:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc0203490:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0203494:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203496:	08c7fc63          	bgeu	a5,a2,ffffffffc020352e <copy_range+0x1a4>
    return page - pages + nbase;
ffffffffc020349a:	40ed07b3          	sub	a5,s10,a4
    return KADDR(page2pa(page));
ffffffffc020349e:	000a8717          	auipc	a4,0xa8
ffffffffc02034a2:	99270713          	addi	a4,a4,-1646 # ffffffffc02aae30 <va_pa_offset>
ffffffffc02034a6:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc02034a8:	8799                	srai	a5,a5,0x6
ffffffffc02034aa:	97ae                	add	a5,a5,a1
    return KADDR(page2pa(page));
ffffffffc02034ac:	0167f733          	and	a4,a5,s6
ffffffffc02034b0:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc02034b4:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc02034b6:	06c77b63          	bgeu	a4,a2,ffffffffc020352c <copy_range+0x1a2>
            memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
ffffffffc02034ba:	6605                	lui	a2,0x1
ffffffffc02034bc:	953e                	add	a0,a0,a5
ffffffffc02034be:	24e020ef          	jal	ra,ffffffffc020570c <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc02034c2:	86a6                	mv	a3,s1
ffffffffc02034c4:	8622                	mv	a2,s0
ffffffffc02034c6:	85ea                	mv	a1,s10
ffffffffc02034c8:	8556                	mv	a0,s5
ffffffffc02034ca:	98aff0ef          	jal	ra,ffffffffc0202654 <page_insert>
ffffffffc02034ce:	84aa                	mv	s1,a0
            if (ret != 0)
ffffffffc02034d0:	d905                	beqz	a0,ffffffffc0203400 <copy_range+0x76>
ffffffffc02034d2:	100027f3          	csrr	a5,sstatus
ffffffffc02034d6:	8b89                	andi	a5,a5,2
ffffffffc02034d8:	ef9d                	bnez	a5,ffffffffc0203516 <copy_range+0x18c>
        pmm_manager->free_pages(base, n);
ffffffffc02034da:	000cb783          	ld	a5,0(s9)
ffffffffc02034de:	4585                	li	a1,1
ffffffffc02034e0:	856a                	mv	a0,s10
ffffffffc02034e2:	739c                	ld	a5,32(a5)
ffffffffc02034e4:	9782                	jalr	a5
    if (flag)
ffffffffc02034e6:	b70d                	j	ffffffffc0203408 <copy_range+0x7e>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02034e8:	00200637          	lui	a2,0x200
ffffffffc02034ec:	9432                	add	s0,s0,a2
ffffffffc02034ee:	ffe00637          	lui	a2,0xffe00
ffffffffc02034f2:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc02034f4:	d809                	beqz	s0,ffffffffc0203406 <copy_range+0x7c>
ffffffffc02034f6:	ef246be3          	bltu	s0,s2,ffffffffc02033ec <copy_range+0x62>
ffffffffc02034fa:	b731                	j	ffffffffc0203406 <copy_range+0x7c>
        intr_disable();
ffffffffc02034fc:	cb8fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203500:	000cb703          	ld	a4,0(s9)
ffffffffc0203504:	4505                	li	a0,1
ffffffffc0203506:	6f18                	ld	a4,24(a4)
ffffffffc0203508:	9702                	jalr	a4
ffffffffc020350a:	8d2a                	mv	s10,a0
        intr_enable();
ffffffffc020350c:	ca2fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0203510:	b795                	j	ffffffffc0203474 <copy_range+0xea>
                return -E_NO_MEM;
ffffffffc0203512:	54f1                	li	s1,-4
ffffffffc0203514:	bdd5                	j	ffffffffc0203408 <copy_range+0x7e>
        intr_disable();
ffffffffc0203516:	c9efd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020351a:	000cb783          	ld	a5,0(s9)
ffffffffc020351e:	4585                	li	a1,1
ffffffffc0203520:	856a                	mv	a0,s10
ffffffffc0203522:	739c                	ld	a5,32(a5)
ffffffffc0203524:	9782                	jalr	a5
        intr_enable();
ffffffffc0203526:	c88fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020352a:	bdf9                	j	ffffffffc0203408 <copy_range+0x7e>
ffffffffc020352c:	86be                	mv	a3,a5
ffffffffc020352e:	00003617          	auipc	a2,0x3
ffffffffc0203532:	07260613          	addi	a2,a2,114 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0203536:	07100593          	li	a1,113
ffffffffc020353a:	00003517          	auipc	a0,0x3
ffffffffc020353e:	08e50513          	addi	a0,a0,142 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0203542:	f4dfc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(page != NULL);
ffffffffc0203546:	00003697          	auipc	a3,0x3
ffffffffc020354a:	76268693          	addi	a3,a3,1890 # ffffffffc0206ca8 <default_pmm_manager+0x740>
ffffffffc020354e:	00003617          	auipc	a2,0x3
ffffffffc0203552:	c6a60613          	addi	a2,a2,-918 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203556:	19400593          	li	a1,404
ffffffffc020355a:	00003517          	auipc	a0,0x3
ffffffffc020355e:	15e50513          	addi	a0,a0,350 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203562:	f2dfc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0203566:	00003697          	auipc	a3,0x3
ffffffffc020356a:	19268693          	addi	a3,a3,402 # ffffffffc02066f8 <default_pmm_manager+0x190>
ffffffffc020356e:	00003617          	auipc	a2,0x3
ffffffffc0203572:	c4a60613          	addi	a2,a2,-950 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203576:	17c00593          	li	a1,380
ffffffffc020357a:	00003517          	auipc	a0,0x3
ffffffffc020357e:	13e50513          	addi	a0,a0,318 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc0203582:	f0dfc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(npage != NULL);
ffffffffc0203586:	00003697          	auipc	a3,0x3
ffffffffc020358a:	73268693          	addi	a3,a3,1842 # ffffffffc0206cb8 <default_pmm_manager+0x750>
ffffffffc020358e:	00003617          	auipc	a2,0x3
ffffffffc0203592:	c2a60613          	addi	a2,a2,-982 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203596:	19500593          	li	a1,405
ffffffffc020359a:	00003517          	auipc	a0,0x3
ffffffffc020359e:	11e50513          	addi	a0,a0,286 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02035a2:	eedfc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02035a6:	00003617          	auipc	a2,0x3
ffffffffc02035aa:	0ca60613          	addi	a2,a2,202 # ffffffffc0206670 <default_pmm_manager+0x108>
ffffffffc02035ae:	06900593          	li	a1,105
ffffffffc02035b2:	00003517          	auipc	a0,0x3
ffffffffc02035b6:	01650513          	addi	a0,a0,22 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc02035ba:	ed5fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pte2page called with invalid pte");
ffffffffc02035be:	00003617          	auipc	a2,0x3
ffffffffc02035c2:	0d260613          	addi	a2,a2,210 # ffffffffc0206690 <default_pmm_manager+0x128>
ffffffffc02035c6:	07f00593          	li	a1,127
ffffffffc02035ca:	00003517          	auipc	a0,0x3
ffffffffc02035ce:	ffe50513          	addi	a0,a0,-2 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc02035d2:	ebdfc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02035d6:	00003697          	auipc	a3,0x3
ffffffffc02035da:	0f268693          	addi	a3,a3,242 # ffffffffc02066c8 <default_pmm_manager+0x160>
ffffffffc02035de:	00003617          	auipc	a2,0x3
ffffffffc02035e2:	bda60613          	addi	a2,a2,-1062 # ffffffffc02061b8 <commands+0x828>
ffffffffc02035e6:	17b00593          	li	a1,379
ffffffffc02035ea:	00003517          	auipc	a0,0x3
ffffffffc02035ee:	0ce50513          	addi	a0,a0,206 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02035f2:	e9dfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02035f6 <pgdir_alloc_page>:
{
ffffffffc02035f6:	7179                	addi	sp,sp,-48
ffffffffc02035f8:	ec26                	sd	s1,24(sp)
ffffffffc02035fa:	e84a                	sd	s2,16(sp)
ffffffffc02035fc:	e052                	sd	s4,0(sp)
ffffffffc02035fe:	f406                	sd	ra,40(sp)
ffffffffc0203600:	f022                	sd	s0,32(sp)
ffffffffc0203602:	e44e                	sd	s3,8(sp)
ffffffffc0203604:	8a2a                	mv	s4,a0
ffffffffc0203606:	84ae                	mv	s1,a1
ffffffffc0203608:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020360a:	100027f3          	csrr	a5,sstatus
ffffffffc020360e:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc0203610:	000a8997          	auipc	s3,0xa8
ffffffffc0203614:	81898993          	addi	s3,s3,-2024 # ffffffffc02aae28 <pmm_manager>
ffffffffc0203618:	ef8d                	bnez	a5,ffffffffc0203652 <pgdir_alloc_page+0x5c>
ffffffffc020361a:	0009b783          	ld	a5,0(s3)
ffffffffc020361e:	4505                	li	a0,1
ffffffffc0203620:	6f9c                	ld	a5,24(a5)
ffffffffc0203622:	9782                	jalr	a5
ffffffffc0203624:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc0203626:	cc09                	beqz	s0,ffffffffc0203640 <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc0203628:	86ca                	mv	a3,s2
ffffffffc020362a:	8626                	mv	a2,s1
ffffffffc020362c:	85a2                	mv	a1,s0
ffffffffc020362e:	8552                	mv	a0,s4
ffffffffc0203630:	824ff0ef          	jal	ra,ffffffffc0202654 <page_insert>
ffffffffc0203634:	e915                	bnez	a0,ffffffffc0203668 <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc0203636:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc0203638:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc020363a:	4785                	li	a5,1
ffffffffc020363c:	04f71e63          	bne	a4,a5,ffffffffc0203698 <pgdir_alloc_page+0xa2>
}
ffffffffc0203640:	70a2                	ld	ra,40(sp)
ffffffffc0203642:	8522                	mv	a0,s0
ffffffffc0203644:	7402                	ld	s0,32(sp)
ffffffffc0203646:	64e2                	ld	s1,24(sp)
ffffffffc0203648:	6942                	ld	s2,16(sp)
ffffffffc020364a:	69a2                	ld	s3,8(sp)
ffffffffc020364c:	6a02                	ld	s4,0(sp)
ffffffffc020364e:	6145                	addi	sp,sp,48
ffffffffc0203650:	8082                	ret
        intr_disable();
ffffffffc0203652:	b62fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203656:	0009b783          	ld	a5,0(s3)
ffffffffc020365a:	4505                	li	a0,1
ffffffffc020365c:	6f9c                	ld	a5,24(a5)
ffffffffc020365e:	9782                	jalr	a5
ffffffffc0203660:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0203662:	b4cfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0203666:	b7c1                	j	ffffffffc0203626 <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203668:	100027f3          	csrr	a5,sstatus
ffffffffc020366c:	8b89                	andi	a5,a5,2
ffffffffc020366e:	eb89                	bnez	a5,ffffffffc0203680 <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc0203670:	0009b783          	ld	a5,0(s3)
ffffffffc0203674:	8522                	mv	a0,s0
ffffffffc0203676:	4585                	li	a1,1
ffffffffc0203678:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc020367a:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc020367c:	9782                	jalr	a5
    if (flag)
ffffffffc020367e:	b7c9                	j	ffffffffc0203640 <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc0203680:	b34fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0203684:	0009b783          	ld	a5,0(s3)
ffffffffc0203688:	8522                	mv	a0,s0
ffffffffc020368a:	4585                	li	a1,1
ffffffffc020368c:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc020368e:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203690:	9782                	jalr	a5
        intr_enable();
ffffffffc0203692:	b1cfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0203696:	b76d                	j	ffffffffc0203640 <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc0203698:	00003697          	auipc	a3,0x3
ffffffffc020369c:	63068693          	addi	a3,a3,1584 # ffffffffc0206cc8 <default_pmm_manager+0x760>
ffffffffc02036a0:	00003617          	auipc	a2,0x3
ffffffffc02036a4:	b1860613          	addi	a2,a2,-1256 # ffffffffc02061b8 <commands+0x828>
ffffffffc02036a8:	1e800593          	li	a1,488
ffffffffc02036ac:	00003517          	auipc	a0,0x3
ffffffffc02036b0:	00c50513          	addi	a0,a0,12 # ffffffffc02066b8 <default_pmm_manager+0x150>
ffffffffc02036b4:	ddbfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02036b8 <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02036b8:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc02036ba:	00003697          	auipc	a3,0x3
ffffffffc02036be:	62668693          	addi	a3,a3,1574 # ffffffffc0206ce0 <default_pmm_manager+0x778>
ffffffffc02036c2:	00003617          	auipc	a2,0x3
ffffffffc02036c6:	af660613          	addi	a2,a2,-1290 # ffffffffc02061b8 <commands+0x828>
ffffffffc02036ca:	07400593          	li	a1,116
ffffffffc02036ce:	00003517          	auipc	a0,0x3
ffffffffc02036d2:	63250513          	addi	a0,a0,1586 # ffffffffc0206d00 <default_pmm_manager+0x798>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02036d6:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc02036d8:	db7fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02036dc <mm_create>:
{
ffffffffc02036dc:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02036de:	04000513          	li	a0,64
{
ffffffffc02036e2:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02036e4:	deafe0ef          	jal	ra,ffffffffc0201cce <kmalloc>
    if (mm != NULL)
ffffffffc02036e8:	cd19                	beqz	a0,ffffffffc0203706 <mm_create+0x2a>
    elm->prev = elm->next = elm;
ffffffffc02036ea:	e508                	sd	a0,8(a0)
ffffffffc02036ec:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc02036ee:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc02036f2:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc02036f6:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc02036fa:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc02036fe:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc0203702:	02053c23          	sd	zero,56(a0)
}
ffffffffc0203706:	60a2                	ld	ra,8(sp)
ffffffffc0203708:	0141                	addi	sp,sp,16
ffffffffc020370a:	8082                	ret

ffffffffc020370c <find_vma>:
{
ffffffffc020370c:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc020370e:	c505                	beqz	a0,ffffffffc0203736 <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0203710:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0203712:	c501                	beqz	a0,ffffffffc020371a <find_vma+0xe>
ffffffffc0203714:	651c                	ld	a5,8(a0)
ffffffffc0203716:	02f5f263          	bgeu	a1,a5,ffffffffc020373a <find_vma+0x2e>
    return listelm->next;
ffffffffc020371a:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc020371c:	00f68d63          	beq	a3,a5,ffffffffc0203736 <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc0203720:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_obj___user_exit_out_size+0x1f4e50>
ffffffffc0203724:	00e5e663          	bltu	a1,a4,ffffffffc0203730 <find_vma+0x24>
ffffffffc0203728:	ff07b703          	ld	a4,-16(a5)
ffffffffc020372c:	00e5ec63          	bltu	a1,a4,ffffffffc0203744 <find_vma+0x38>
ffffffffc0203730:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc0203732:	fef697e3          	bne	a3,a5,ffffffffc0203720 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc0203736:	4501                	li	a0,0
}
ffffffffc0203738:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc020373a:	691c                	ld	a5,16(a0)
ffffffffc020373c:	fcf5ffe3          	bgeu	a1,a5,ffffffffc020371a <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0203740:	ea88                	sd	a0,16(a3)
ffffffffc0203742:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc0203744:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0203748:	ea88                	sd	a0,16(a3)
ffffffffc020374a:	8082                	ret

ffffffffc020374c <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc020374c:	6590                	ld	a2,8(a1)
ffffffffc020374e:	0105b803          	ld	a6,16(a1) # 80010 <_binary_obj___user_exit_out_size+0x74e78>
{
ffffffffc0203752:	1141                	addi	sp,sp,-16
ffffffffc0203754:	e406                	sd	ra,8(sp)
ffffffffc0203756:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203758:	01066763          	bltu	a2,a6,ffffffffc0203766 <insert_vma_struct+0x1a>
ffffffffc020375c:	a085                	j	ffffffffc02037bc <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc020375e:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203762:	04e66863          	bltu	a2,a4,ffffffffc02037b2 <insert_vma_struct+0x66>
ffffffffc0203766:	86be                	mv	a3,a5
ffffffffc0203768:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc020376a:	fef51ae3          	bne	a0,a5,ffffffffc020375e <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc020376e:	02a68463          	beq	a3,a0,ffffffffc0203796 <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc0203772:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc0203776:	fe86b883          	ld	a7,-24(a3)
ffffffffc020377a:	08e8f163          	bgeu	a7,a4,ffffffffc02037fc <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc020377e:	04e66f63          	bltu	a2,a4,ffffffffc02037dc <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc0203782:	00f50a63          	beq	a0,a5,ffffffffc0203796 <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc0203786:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc020378a:	05076963          	bltu	a4,a6,ffffffffc02037dc <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc020378e:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203792:	02c77363          	bgeu	a4,a2,ffffffffc02037b8 <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc0203796:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0203798:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc020379a:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc020379e:	e390                	sd	a2,0(a5)
ffffffffc02037a0:	e690                	sd	a2,8(a3)
}
ffffffffc02037a2:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc02037a4:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc02037a6:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc02037a8:	0017079b          	addiw	a5,a4,1
ffffffffc02037ac:	d11c                	sw	a5,32(a0)
}
ffffffffc02037ae:	0141                	addi	sp,sp,16
ffffffffc02037b0:	8082                	ret
    if (le_prev != list)
ffffffffc02037b2:	fca690e3          	bne	a3,a0,ffffffffc0203772 <insert_vma_struct+0x26>
ffffffffc02037b6:	bfd1                	j	ffffffffc020378a <insert_vma_struct+0x3e>
ffffffffc02037b8:	f01ff0ef          	jal	ra,ffffffffc02036b8 <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc02037bc:	00003697          	auipc	a3,0x3
ffffffffc02037c0:	55468693          	addi	a3,a3,1364 # ffffffffc0206d10 <default_pmm_manager+0x7a8>
ffffffffc02037c4:	00003617          	auipc	a2,0x3
ffffffffc02037c8:	9f460613          	addi	a2,a2,-1548 # ffffffffc02061b8 <commands+0x828>
ffffffffc02037cc:	07a00593          	li	a1,122
ffffffffc02037d0:	00003517          	auipc	a0,0x3
ffffffffc02037d4:	53050513          	addi	a0,a0,1328 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc02037d8:	cb7fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02037dc:	00003697          	auipc	a3,0x3
ffffffffc02037e0:	57468693          	addi	a3,a3,1396 # ffffffffc0206d50 <default_pmm_manager+0x7e8>
ffffffffc02037e4:	00003617          	auipc	a2,0x3
ffffffffc02037e8:	9d460613          	addi	a2,a2,-1580 # ffffffffc02061b8 <commands+0x828>
ffffffffc02037ec:	07300593          	li	a1,115
ffffffffc02037f0:	00003517          	auipc	a0,0x3
ffffffffc02037f4:	51050513          	addi	a0,a0,1296 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc02037f8:	c97fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc02037fc:	00003697          	auipc	a3,0x3
ffffffffc0203800:	53468693          	addi	a3,a3,1332 # ffffffffc0206d30 <default_pmm_manager+0x7c8>
ffffffffc0203804:	00003617          	auipc	a2,0x3
ffffffffc0203808:	9b460613          	addi	a2,a2,-1612 # ffffffffc02061b8 <commands+0x828>
ffffffffc020380c:	07200593          	li	a1,114
ffffffffc0203810:	00003517          	auipc	a0,0x3
ffffffffc0203814:	4f050513          	addi	a0,a0,1264 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203818:	c77fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020381c <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc020381c:	591c                	lw	a5,48(a0)
{
ffffffffc020381e:	1141                	addi	sp,sp,-16
ffffffffc0203820:	e406                	sd	ra,8(sp)
ffffffffc0203822:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0203824:	e78d                	bnez	a5,ffffffffc020384e <mm_destroy+0x32>
ffffffffc0203826:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc0203828:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc020382a:	00a40c63          	beq	s0,a0,ffffffffc0203842 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc020382e:	6118                	ld	a4,0(a0)
ffffffffc0203830:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc0203832:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc0203834:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0203836:	e398                	sd	a4,0(a5)
ffffffffc0203838:	d46fe0ef          	jal	ra,ffffffffc0201d7e <kfree>
    return listelm->next;
ffffffffc020383c:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc020383e:	fea418e3          	bne	s0,a0,ffffffffc020382e <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc0203842:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc0203844:	6402                	ld	s0,0(sp)
ffffffffc0203846:	60a2                	ld	ra,8(sp)
ffffffffc0203848:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc020384a:	d34fe06f          	j	ffffffffc0201d7e <kfree>
    assert(mm_count(mm) == 0);
ffffffffc020384e:	00003697          	auipc	a3,0x3
ffffffffc0203852:	52268693          	addi	a3,a3,1314 # ffffffffc0206d70 <default_pmm_manager+0x808>
ffffffffc0203856:	00003617          	auipc	a2,0x3
ffffffffc020385a:	96260613          	addi	a2,a2,-1694 # ffffffffc02061b8 <commands+0x828>
ffffffffc020385e:	09e00593          	li	a1,158
ffffffffc0203862:	00003517          	auipc	a0,0x3
ffffffffc0203866:	49e50513          	addi	a0,a0,1182 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc020386a:	c25fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020386e <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc020386e:	7139                	addi	sp,sp,-64
ffffffffc0203870:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0203872:	6405                	lui	s0,0x1
ffffffffc0203874:	147d                	addi	s0,s0,-1
ffffffffc0203876:	77fd                	lui	a5,0xfffff
ffffffffc0203878:	9622                	add	a2,a2,s0
ffffffffc020387a:	962e                	add	a2,a2,a1
{
ffffffffc020387c:	f426                	sd	s1,40(sp)
ffffffffc020387e:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0203880:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc0203884:	f04a                	sd	s2,32(sp)
ffffffffc0203886:	ec4e                	sd	s3,24(sp)
ffffffffc0203888:	e852                	sd	s4,16(sp)
ffffffffc020388a:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc020388c:	002005b7          	lui	a1,0x200
ffffffffc0203890:	00f67433          	and	s0,a2,a5
ffffffffc0203894:	06b4e363          	bltu	s1,a1,ffffffffc02038fa <mm_map+0x8c>
ffffffffc0203898:	0684f163          	bgeu	s1,s0,ffffffffc02038fa <mm_map+0x8c>
ffffffffc020389c:	4785                	li	a5,1
ffffffffc020389e:	07fe                	slli	a5,a5,0x1f
ffffffffc02038a0:	0487ed63          	bltu	a5,s0,ffffffffc02038fa <mm_map+0x8c>
ffffffffc02038a4:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc02038a6:	cd21                	beqz	a0,ffffffffc02038fe <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc02038a8:	85a6                	mv	a1,s1
ffffffffc02038aa:	8ab6                	mv	s5,a3
ffffffffc02038ac:	8a3a                	mv	s4,a4
ffffffffc02038ae:	e5fff0ef          	jal	ra,ffffffffc020370c <find_vma>
ffffffffc02038b2:	c501                	beqz	a0,ffffffffc02038ba <mm_map+0x4c>
ffffffffc02038b4:	651c                	ld	a5,8(a0)
ffffffffc02038b6:	0487e263          	bltu	a5,s0,ffffffffc02038fa <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02038ba:	03000513          	li	a0,48
ffffffffc02038be:	c10fe0ef          	jal	ra,ffffffffc0201cce <kmalloc>
ffffffffc02038c2:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc02038c4:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc02038c6:	02090163          	beqz	s2,ffffffffc02038e8 <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc02038ca:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc02038cc:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc02038d0:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc02038d4:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc02038d8:	85ca                	mv	a1,s2
ffffffffc02038da:	e73ff0ef          	jal	ra,ffffffffc020374c <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc02038de:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc02038e0:	000a0463          	beqz	s4,ffffffffc02038e8 <mm_map+0x7a>
        *vma_store = vma;
ffffffffc02038e4:	012a3023          	sd	s2,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8c20>

out:
    return ret;
}
ffffffffc02038e8:	70e2                	ld	ra,56(sp)
ffffffffc02038ea:	7442                	ld	s0,48(sp)
ffffffffc02038ec:	74a2                	ld	s1,40(sp)
ffffffffc02038ee:	7902                	ld	s2,32(sp)
ffffffffc02038f0:	69e2                	ld	s3,24(sp)
ffffffffc02038f2:	6a42                	ld	s4,16(sp)
ffffffffc02038f4:	6aa2                	ld	s5,8(sp)
ffffffffc02038f6:	6121                	addi	sp,sp,64
ffffffffc02038f8:	8082                	ret
        return -E_INVAL;
ffffffffc02038fa:	5575                	li	a0,-3
ffffffffc02038fc:	b7f5                	j	ffffffffc02038e8 <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc02038fe:	00003697          	auipc	a3,0x3
ffffffffc0203902:	48a68693          	addi	a3,a3,1162 # ffffffffc0206d88 <default_pmm_manager+0x820>
ffffffffc0203906:	00003617          	auipc	a2,0x3
ffffffffc020390a:	8b260613          	addi	a2,a2,-1870 # ffffffffc02061b8 <commands+0x828>
ffffffffc020390e:	0b300593          	li	a1,179
ffffffffc0203912:	00003517          	auipc	a0,0x3
ffffffffc0203916:	3ee50513          	addi	a0,a0,1006 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc020391a:	b75fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020391e <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc020391e:	7139                	addi	sp,sp,-64
ffffffffc0203920:	fc06                	sd	ra,56(sp)
ffffffffc0203922:	f822                	sd	s0,48(sp)
ffffffffc0203924:	f426                	sd	s1,40(sp)
ffffffffc0203926:	f04a                	sd	s2,32(sp)
ffffffffc0203928:	ec4e                	sd	s3,24(sp)
ffffffffc020392a:	e852                	sd	s4,16(sp)
ffffffffc020392c:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc020392e:	c52d                	beqz	a0,ffffffffc0203998 <dup_mmap+0x7a>
ffffffffc0203930:	892a                	mv	s2,a0
ffffffffc0203932:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0203934:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc0203936:	e595                	bnez	a1,ffffffffc0203962 <dup_mmap+0x44>
ffffffffc0203938:	a085                	j	ffffffffc0203998 <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc020393a:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc020393c:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_exit_out_size+0x1f4e70>
        vma->vm_end = vm_end;
ffffffffc0203940:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc0203944:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0203948:	e05ff0ef          	jal	ra,ffffffffc020374c <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc020394c:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8c30>
ffffffffc0203950:	fe843603          	ld	a2,-24(s0)
ffffffffc0203954:	6c8c                	ld	a1,24(s1)
ffffffffc0203956:	01893503          	ld	a0,24(s2)
ffffffffc020395a:	4701                	li	a4,0
ffffffffc020395c:	a2fff0ef          	jal	ra,ffffffffc020338a <copy_range>
ffffffffc0203960:	e105                	bnez	a0,ffffffffc0203980 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc0203962:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc0203964:	02848863          	beq	s1,s0,ffffffffc0203994 <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203968:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc020396c:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203970:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203974:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203978:	b56fe0ef          	jal	ra,ffffffffc0201cce <kmalloc>
ffffffffc020397c:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc020397e:	fd55                	bnez	a0,ffffffffc020393a <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0203980:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc0203982:	70e2                	ld	ra,56(sp)
ffffffffc0203984:	7442                	ld	s0,48(sp)
ffffffffc0203986:	74a2                	ld	s1,40(sp)
ffffffffc0203988:	7902                	ld	s2,32(sp)
ffffffffc020398a:	69e2                	ld	s3,24(sp)
ffffffffc020398c:	6a42                	ld	s4,16(sp)
ffffffffc020398e:	6aa2                	ld	s5,8(sp)
ffffffffc0203990:	6121                	addi	sp,sp,64
ffffffffc0203992:	8082                	ret
    return 0;
ffffffffc0203994:	4501                	li	a0,0
ffffffffc0203996:	b7f5                	j	ffffffffc0203982 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0203998:	00003697          	auipc	a3,0x3
ffffffffc020399c:	40068693          	addi	a3,a3,1024 # ffffffffc0206d98 <default_pmm_manager+0x830>
ffffffffc02039a0:	00003617          	auipc	a2,0x3
ffffffffc02039a4:	81860613          	addi	a2,a2,-2024 # ffffffffc02061b8 <commands+0x828>
ffffffffc02039a8:	0cf00593          	li	a1,207
ffffffffc02039ac:	00003517          	auipc	a0,0x3
ffffffffc02039b0:	35450513          	addi	a0,a0,852 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc02039b4:	adbfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02039b8 <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc02039b8:	1101                	addi	sp,sp,-32
ffffffffc02039ba:	ec06                	sd	ra,24(sp)
ffffffffc02039bc:	e822                	sd	s0,16(sp)
ffffffffc02039be:	e426                	sd	s1,8(sp)
ffffffffc02039c0:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc02039c2:	c531                	beqz	a0,ffffffffc0203a0e <exit_mmap+0x56>
ffffffffc02039c4:	591c                	lw	a5,48(a0)
ffffffffc02039c6:	84aa                	mv	s1,a0
ffffffffc02039c8:	e3b9                	bnez	a5,ffffffffc0203a0e <exit_mmap+0x56>
    return listelm->next;
ffffffffc02039ca:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc02039cc:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc02039d0:	02850663          	beq	a0,s0,ffffffffc02039fc <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02039d4:	ff043603          	ld	a2,-16(s0)
ffffffffc02039d8:	fe843583          	ld	a1,-24(s0)
ffffffffc02039dc:	854a                	mv	a0,s2
ffffffffc02039de:	803fe0ef          	jal	ra,ffffffffc02021e0 <unmap_range>
ffffffffc02039e2:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02039e4:	fe8498e3          	bne	s1,s0,ffffffffc02039d4 <exit_mmap+0x1c>
ffffffffc02039e8:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc02039ea:	00848c63          	beq	s1,s0,ffffffffc0203a02 <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02039ee:	ff043603          	ld	a2,-16(s0)
ffffffffc02039f2:	fe843583          	ld	a1,-24(s0)
ffffffffc02039f6:	854a                	mv	a0,s2
ffffffffc02039f8:	92ffe0ef          	jal	ra,ffffffffc0202326 <exit_range>
ffffffffc02039fc:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02039fe:	fe8498e3          	bne	s1,s0,ffffffffc02039ee <exit_mmap+0x36>
    }
}
ffffffffc0203a02:	60e2                	ld	ra,24(sp)
ffffffffc0203a04:	6442                	ld	s0,16(sp)
ffffffffc0203a06:	64a2                	ld	s1,8(sp)
ffffffffc0203a08:	6902                	ld	s2,0(sp)
ffffffffc0203a0a:	6105                	addi	sp,sp,32
ffffffffc0203a0c:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0203a0e:	00003697          	auipc	a3,0x3
ffffffffc0203a12:	3aa68693          	addi	a3,a3,938 # ffffffffc0206db8 <default_pmm_manager+0x850>
ffffffffc0203a16:	00002617          	auipc	a2,0x2
ffffffffc0203a1a:	7a260613          	addi	a2,a2,1954 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203a1e:	0e800593          	li	a1,232
ffffffffc0203a22:	00003517          	auipc	a0,0x3
ffffffffc0203a26:	2de50513          	addi	a0,a0,734 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203a2a:	a65fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203a2e <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc0203a2e:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203a30:	04000513          	li	a0,64
{
ffffffffc0203a34:	fc06                	sd	ra,56(sp)
ffffffffc0203a36:	f822                	sd	s0,48(sp)
ffffffffc0203a38:	f426                	sd	s1,40(sp)
ffffffffc0203a3a:	f04a                	sd	s2,32(sp)
ffffffffc0203a3c:	ec4e                	sd	s3,24(sp)
ffffffffc0203a3e:	e852                	sd	s4,16(sp)
ffffffffc0203a40:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203a42:	a8cfe0ef          	jal	ra,ffffffffc0201cce <kmalloc>
    if (mm != NULL)
ffffffffc0203a46:	2e050663          	beqz	a0,ffffffffc0203d32 <vmm_init+0x304>
ffffffffc0203a4a:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc0203a4c:	e508                	sd	a0,8(a0)
ffffffffc0203a4e:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203a50:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0203a54:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0203a58:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc0203a5c:	02053423          	sd	zero,40(a0)
ffffffffc0203a60:	02052823          	sw	zero,48(a0)
ffffffffc0203a64:	02053c23          	sd	zero,56(a0)
ffffffffc0203a68:	03200413          	li	s0,50
ffffffffc0203a6c:	a811                	j	ffffffffc0203a80 <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc0203a6e:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203a70:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203a72:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc0203a76:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203a78:	8526                	mv	a0,s1
ffffffffc0203a7a:	cd3ff0ef          	jal	ra,ffffffffc020374c <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc0203a7e:	c80d                	beqz	s0,ffffffffc0203ab0 <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203a80:	03000513          	li	a0,48
ffffffffc0203a84:	a4afe0ef          	jal	ra,ffffffffc0201cce <kmalloc>
ffffffffc0203a88:	85aa                	mv	a1,a0
ffffffffc0203a8a:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203a8e:	f165                	bnez	a0,ffffffffc0203a6e <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc0203a90:	00003697          	auipc	a3,0x3
ffffffffc0203a94:	4c068693          	addi	a3,a3,1216 # ffffffffc0206f50 <default_pmm_manager+0x9e8>
ffffffffc0203a98:	00002617          	auipc	a2,0x2
ffffffffc0203a9c:	72060613          	addi	a2,a2,1824 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203aa0:	12c00593          	li	a1,300
ffffffffc0203aa4:	00003517          	auipc	a0,0x3
ffffffffc0203aa8:	25c50513          	addi	a0,a0,604 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203aac:	9e3fc0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0203ab0:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203ab4:	1f900913          	li	s2,505
ffffffffc0203ab8:	a819                	j	ffffffffc0203ace <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc0203aba:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203abc:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203abe:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203ac2:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203ac4:	8526                	mv	a0,s1
ffffffffc0203ac6:	c87ff0ef          	jal	ra,ffffffffc020374c <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203aca:	03240a63          	beq	s0,s2,ffffffffc0203afe <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203ace:	03000513          	li	a0,48
ffffffffc0203ad2:	9fcfe0ef          	jal	ra,ffffffffc0201cce <kmalloc>
ffffffffc0203ad6:	85aa                	mv	a1,a0
ffffffffc0203ad8:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203adc:	fd79                	bnez	a0,ffffffffc0203aba <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc0203ade:	00003697          	auipc	a3,0x3
ffffffffc0203ae2:	47268693          	addi	a3,a3,1138 # ffffffffc0206f50 <default_pmm_manager+0x9e8>
ffffffffc0203ae6:	00002617          	auipc	a2,0x2
ffffffffc0203aea:	6d260613          	addi	a2,a2,1746 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203aee:	13300593          	li	a1,307
ffffffffc0203af2:	00003517          	auipc	a0,0x3
ffffffffc0203af6:	20e50513          	addi	a0,a0,526 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203afa:	995fc0ef          	jal	ra,ffffffffc020048e <__panic>
    return listelm->next;
ffffffffc0203afe:	649c                	ld	a5,8(s1)
ffffffffc0203b00:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc0203b02:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc0203b06:	16f48663          	beq	s1,a5,ffffffffc0203c72 <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203b0a:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd54194>
ffffffffc0203b0e:	ffe70693          	addi	a3,a4,-2
ffffffffc0203b12:	10d61063          	bne	a2,a3,ffffffffc0203c12 <vmm_init+0x1e4>
ffffffffc0203b16:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203b1a:	0ed71c63          	bne	a4,a3,ffffffffc0203c12 <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0203b1e:	0715                	addi	a4,a4,5
ffffffffc0203b20:	679c                	ld	a5,8(a5)
ffffffffc0203b22:	feb712e3          	bne	a4,a1,ffffffffc0203b06 <vmm_init+0xd8>
ffffffffc0203b26:	4a1d                	li	s4,7
ffffffffc0203b28:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203b2a:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0203b2e:	85a2                	mv	a1,s0
ffffffffc0203b30:	8526                	mv	a0,s1
ffffffffc0203b32:	bdbff0ef          	jal	ra,ffffffffc020370c <find_vma>
ffffffffc0203b36:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc0203b38:	16050d63          	beqz	a0,ffffffffc0203cb2 <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0203b3c:	00140593          	addi	a1,s0,1
ffffffffc0203b40:	8526                	mv	a0,s1
ffffffffc0203b42:	bcbff0ef          	jal	ra,ffffffffc020370c <find_vma>
ffffffffc0203b46:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc0203b48:	14050563          	beqz	a0,ffffffffc0203c92 <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0203b4c:	85d2                	mv	a1,s4
ffffffffc0203b4e:	8526                	mv	a0,s1
ffffffffc0203b50:	bbdff0ef          	jal	ra,ffffffffc020370c <find_vma>
        assert(vma3 == NULL);
ffffffffc0203b54:	16051f63          	bnez	a0,ffffffffc0203cd2 <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc0203b58:	00340593          	addi	a1,s0,3
ffffffffc0203b5c:	8526                	mv	a0,s1
ffffffffc0203b5e:	bafff0ef          	jal	ra,ffffffffc020370c <find_vma>
        assert(vma4 == NULL);
ffffffffc0203b62:	1a051863          	bnez	a0,ffffffffc0203d12 <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc0203b66:	00440593          	addi	a1,s0,4
ffffffffc0203b6a:	8526                	mv	a0,s1
ffffffffc0203b6c:	ba1ff0ef          	jal	ra,ffffffffc020370c <find_vma>
        assert(vma5 == NULL);
ffffffffc0203b70:	18051163          	bnez	a0,ffffffffc0203cf2 <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203b74:	00893783          	ld	a5,8(s2)
ffffffffc0203b78:	0a879d63          	bne	a5,s0,ffffffffc0203c32 <vmm_init+0x204>
ffffffffc0203b7c:	01093783          	ld	a5,16(s2)
ffffffffc0203b80:	0b479963          	bne	a5,s4,ffffffffc0203c32 <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203b84:	0089b783          	ld	a5,8(s3)
ffffffffc0203b88:	0c879563          	bne	a5,s0,ffffffffc0203c52 <vmm_init+0x224>
ffffffffc0203b8c:	0109b783          	ld	a5,16(s3)
ffffffffc0203b90:	0d479163          	bne	a5,s4,ffffffffc0203c52 <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203b94:	0415                	addi	s0,s0,5
ffffffffc0203b96:	0a15                	addi	s4,s4,5
ffffffffc0203b98:	f9541be3          	bne	s0,s5,ffffffffc0203b2e <vmm_init+0x100>
ffffffffc0203b9c:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc0203b9e:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc0203ba0:	85a2                	mv	a1,s0
ffffffffc0203ba2:	8526                	mv	a0,s1
ffffffffc0203ba4:	b69ff0ef          	jal	ra,ffffffffc020370c <find_vma>
ffffffffc0203ba8:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc0203bac:	c90d                	beqz	a0,ffffffffc0203bde <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc0203bae:	6914                	ld	a3,16(a0)
ffffffffc0203bb0:	6510                	ld	a2,8(a0)
ffffffffc0203bb2:	00003517          	auipc	a0,0x3
ffffffffc0203bb6:	32650513          	addi	a0,a0,806 # ffffffffc0206ed8 <default_pmm_manager+0x970>
ffffffffc0203bba:	ddafc0ef          	jal	ra,ffffffffc0200194 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0203bbe:	00003697          	auipc	a3,0x3
ffffffffc0203bc2:	34268693          	addi	a3,a3,834 # ffffffffc0206f00 <default_pmm_manager+0x998>
ffffffffc0203bc6:	00002617          	auipc	a2,0x2
ffffffffc0203bca:	5f260613          	addi	a2,a2,1522 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203bce:	15900593          	li	a1,345
ffffffffc0203bd2:	00003517          	auipc	a0,0x3
ffffffffc0203bd6:	12e50513          	addi	a0,a0,302 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203bda:	8b5fc0ef          	jal	ra,ffffffffc020048e <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0203bde:	147d                	addi	s0,s0,-1
ffffffffc0203be0:	fd2410e3          	bne	s0,s2,ffffffffc0203ba0 <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc0203be4:	8526                	mv	a0,s1
ffffffffc0203be6:	c37ff0ef          	jal	ra,ffffffffc020381c <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0203bea:	00003517          	auipc	a0,0x3
ffffffffc0203bee:	32e50513          	addi	a0,a0,814 # ffffffffc0206f18 <default_pmm_manager+0x9b0>
ffffffffc0203bf2:	da2fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0203bf6:	7442                	ld	s0,48(sp)
ffffffffc0203bf8:	70e2                	ld	ra,56(sp)
ffffffffc0203bfa:	74a2                	ld	s1,40(sp)
ffffffffc0203bfc:	7902                	ld	s2,32(sp)
ffffffffc0203bfe:	69e2                	ld	s3,24(sp)
ffffffffc0203c00:	6a42                	ld	s4,16(sp)
ffffffffc0203c02:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203c04:	00003517          	auipc	a0,0x3
ffffffffc0203c08:	33450513          	addi	a0,a0,820 # ffffffffc0206f38 <default_pmm_manager+0x9d0>
}
ffffffffc0203c0c:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203c0e:	d86fc06f          	j	ffffffffc0200194 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203c12:	00003697          	auipc	a3,0x3
ffffffffc0203c16:	1de68693          	addi	a3,a3,478 # ffffffffc0206df0 <default_pmm_manager+0x888>
ffffffffc0203c1a:	00002617          	auipc	a2,0x2
ffffffffc0203c1e:	59e60613          	addi	a2,a2,1438 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203c22:	13d00593          	li	a1,317
ffffffffc0203c26:	00003517          	auipc	a0,0x3
ffffffffc0203c2a:	0da50513          	addi	a0,a0,218 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203c2e:	861fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203c32:	00003697          	auipc	a3,0x3
ffffffffc0203c36:	24668693          	addi	a3,a3,582 # ffffffffc0206e78 <default_pmm_manager+0x910>
ffffffffc0203c3a:	00002617          	auipc	a2,0x2
ffffffffc0203c3e:	57e60613          	addi	a2,a2,1406 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203c42:	14e00593          	li	a1,334
ffffffffc0203c46:	00003517          	auipc	a0,0x3
ffffffffc0203c4a:	0ba50513          	addi	a0,a0,186 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203c4e:	841fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203c52:	00003697          	auipc	a3,0x3
ffffffffc0203c56:	25668693          	addi	a3,a3,598 # ffffffffc0206ea8 <default_pmm_manager+0x940>
ffffffffc0203c5a:	00002617          	auipc	a2,0x2
ffffffffc0203c5e:	55e60613          	addi	a2,a2,1374 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203c62:	14f00593          	li	a1,335
ffffffffc0203c66:	00003517          	auipc	a0,0x3
ffffffffc0203c6a:	09a50513          	addi	a0,a0,154 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203c6e:	821fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc0203c72:	00003697          	auipc	a3,0x3
ffffffffc0203c76:	16668693          	addi	a3,a3,358 # ffffffffc0206dd8 <default_pmm_manager+0x870>
ffffffffc0203c7a:	00002617          	auipc	a2,0x2
ffffffffc0203c7e:	53e60613          	addi	a2,a2,1342 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203c82:	13b00593          	li	a1,315
ffffffffc0203c86:	00003517          	auipc	a0,0x3
ffffffffc0203c8a:	07a50513          	addi	a0,a0,122 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203c8e:	801fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2 != NULL);
ffffffffc0203c92:	00003697          	auipc	a3,0x3
ffffffffc0203c96:	1a668693          	addi	a3,a3,422 # ffffffffc0206e38 <default_pmm_manager+0x8d0>
ffffffffc0203c9a:	00002617          	auipc	a2,0x2
ffffffffc0203c9e:	51e60613          	addi	a2,a2,1310 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203ca2:	14600593          	li	a1,326
ffffffffc0203ca6:	00003517          	auipc	a0,0x3
ffffffffc0203caa:	05a50513          	addi	a0,a0,90 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203cae:	fe0fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1 != NULL);
ffffffffc0203cb2:	00003697          	auipc	a3,0x3
ffffffffc0203cb6:	17668693          	addi	a3,a3,374 # ffffffffc0206e28 <default_pmm_manager+0x8c0>
ffffffffc0203cba:	00002617          	auipc	a2,0x2
ffffffffc0203cbe:	4fe60613          	addi	a2,a2,1278 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203cc2:	14400593          	li	a1,324
ffffffffc0203cc6:	00003517          	auipc	a0,0x3
ffffffffc0203cca:	03a50513          	addi	a0,a0,58 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203cce:	fc0fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma3 == NULL);
ffffffffc0203cd2:	00003697          	auipc	a3,0x3
ffffffffc0203cd6:	17668693          	addi	a3,a3,374 # ffffffffc0206e48 <default_pmm_manager+0x8e0>
ffffffffc0203cda:	00002617          	auipc	a2,0x2
ffffffffc0203cde:	4de60613          	addi	a2,a2,1246 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203ce2:	14800593          	li	a1,328
ffffffffc0203ce6:	00003517          	auipc	a0,0x3
ffffffffc0203cea:	01a50513          	addi	a0,a0,26 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203cee:	fa0fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma5 == NULL);
ffffffffc0203cf2:	00003697          	auipc	a3,0x3
ffffffffc0203cf6:	17668693          	addi	a3,a3,374 # ffffffffc0206e68 <default_pmm_manager+0x900>
ffffffffc0203cfa:	00002617          	auipc	a2,0x2
ffffffffc0203cfe:	4be60613          	addi	a2,a2,1214 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203d02:	14c00593          	li	a1,332
ffffffffc0203d06:	00003517          	auipc	a0,0x3
ffffffffc0203d0a:	ffa50513          	addi	a0,a0,-6 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203d0e:	f80fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma4 == NULL);
ffffffffc0203d12:	00003697          	auipc	a3,0x3
ffffffffc0203d16:	14668693          	addi	a3,a3,326 # ffffffffc0206e58 <default_pmm_manager+0x8f0>
ffffffffc0203d1a:	00002617          	auipc	a2,0x2
ffffffffc0203d1e:	49e60613          	addi	a2,a2,1182 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203d22:	14a00593          	li	a1,330
ffffffffc0203d26:	00003517          	auipc	a0,0x3
ffffffffc0203d2a:	fda50513          	addi	a0,a0,-38 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203d2e:	f60fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(mm != NULL);
ffffffffc0203d32:	00003697          	auipc	a3,0x3
ffffffffc0203d36:	05668693          	addi	a3,a3,86 # ffffffffc0206d88 <default_pmm_manager+0x820>
ffffffffc0203d3a:	00002617          	auipc	a2,0x2
ffffffffc0203d3e:	47e60613          	addi	a2,a2,1150 # ffffffffc02061b8 <commands+0x828>
ffffffffc0203d42:	12400593          	li	a1,292
ffffffffc0203d46:	00003517          	auipc	a0,0x3
ffffffffc0203d4a:	fba50513          	addi	a0,a0,-70 # ffffffffc0206d00 <default_pmm_manager+0x798>
ffffffffc0203d4e:	f40fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203d52 <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0203d52:	7179                	addi	sp,sp,-48
ffffffffc0203d54:	f022                	sd	s0,32(sp)
ffffffffc0203d56:	f406                	sd	ra,40(sp)
ffffffffc0203d58:	ec26                	sd	s1,24(sp)
ffffffffc0203d5a:	e84a                	sd	s2,16(sp)
ffffffffc0203d5c:	e44e                	sd	s3,8(sp)
ffffffffc0203d5e:	e052                	sd	s4,0(sp)
ffffffffc0203d60:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc0203d62:	c135                	beqz	a0,ffffffffc0203dc6 <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc0203d64:	002007b7          	lui	a5,0x200
ffffffffc0203d68:	04f5e663          	bltu	a1,a5,ffffffffc0203db4 <user_mem_check+0x62>
ffffffffc0203d6c:	00c584b3          	add	s1,a1,a2
ffffffffc0203d70:	0495f263          	bgeu	a1,s1,ffffffffc0203db4 <user_mem_check+0x62>
ffffffffc0203d74:	4785                	li	a5,1
ffffffffc0203d76:	07fe                	slli	a5,a5,0x1f
ffffffffc0203d78:	0297ee63          	bltu	a5,s1,ffffffffc0203db4 <user_mem_check+0x62>
ffffffffc0203d7c:	892a                	mv	s2,a0
ffffffffc0203d7e:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d80:	6a05                	lui	s4,0x1
ffffffffc0203d82:	a821                	j	ffffffffc0203d9a <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d84:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d88:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d8a:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d8c:	c685                	beqz	a3,ffffffffc0203db4 <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d8e:	c399                	beqz	a5,ffffffffc0203d94 <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d90:	02e46263          	bltu	s0,a4,ffffffffc0203db4 <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0203d94:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc0203d96:	04947663          	bgeu	s0,s1,ffffffffc0203de2 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc0203d9a:	85a2                	mv	a1,s0
ffffffffc0203d9c:	854a                	mv	a0,s2
ffffffffc0203d9e:	96fff0ef          	jal	ra,ffffffffc020370c <find_vma>
ffffffffc0203da2:	c909                	beqz	a0,ffffffffc0203db4 <user_mem_check+0x62>
ffffffffc0203da4:	6518                	ld	a4,8(a0)
ffffffffc0203da6:	00e46763          	bltu	s0,a4,ffffffffc0203db4 <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203daa:	4d1c                	lw	a5,24(a0)
ffffffffc0203dac:	fc099ce3          	bnez	s3,ffffffffc0203d84 <user_mem_check+0x32>
ffffffffc0203db0:	8b85                	andi	a5,a5,1
ffffffffc0203db2:	f3ed                	bnez	a5,ffffffffc0203d94 <user_mem_check+0x42>
            return 0;
ffffffffc0203db4:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203db6:	70a2                	ld	ra,40(sp)
ffffffffc0203db8:	7402                	ld	s0,32(sp)
ffffffffc0203dba:	64e2                	ld	s1,24(sp)
ffffffffc0203dbc:	6942                	ld	s2,16(sp)
ffffffffc0203dbe:	69a2                	ld	s3,8(sp)
ffffffffc0203dc0:	6a02                	ld	s4,0(sp)
ffffffffc0203dc2:	6145                	addi	sp,sp,48
ffffffffc0203dc4:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203dc6:	c02007b7          	lui	a5,0xc0200
ffffffffc0203dca:	4501                	li	a0,0
ffffffffc0203dcc:	fef5e5e3          	bltu	a1,a5,ffffffffc0203db6 <user_mem_check+0x64>
ffffffffc0203dd0:	962e                	add	a2,a2,a1
ffffffffc0203dd2:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203db6 <user_mem_check+0x64>
ffffffffc0203dd6:	c8000537          	lui	a0,0xc8000
ffffffffc0203dda:	0505                	addi	a0,a0,1
ffffffffc0203ddc:	00a63533          	sltu	a0,a2,a0
ffffffffc0203de0:	bfd9                	j	ffffffffc0203db6 <user_mem_check+0x64>
        return 1;
ffffffffc0203de2:	4505                	li	a0,1
ffffffffc0203de4:	bfc9                	j	ffffffffc0203db6 <user_mem_check+0x64>

ffffffffc0203de6 <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203de6:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203de8:	9402                	jalr	s0

	jal do_exit
ffffffffc0203dea:	628000ef          	jal	ra,ffffffffc0204412 <do_exit>

ffffffffc0203dee <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203dee:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203df0:	10800513          	li	a0,264
{
ffffffffc0203df4:	e022                	sd	s0,0(sp)
ffffffffc0203df6:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203df8:	ed7fd0ef          	jal	ra,ffffffffc0201cce <kmalloc>
ffffffffc0203dfc:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203dfe:	c12d                	beqz	a0,ffffffffc0203e60 <alloc_proc+0x72>
    {
        proc->state = PROC_UNINIT;
ffffffffc0203e00:	57fd                	li	a5,-1
ffffffffc0203e02:	1782                	slli	a5,a5,0x20
ffffffffc0203e04:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203e06:	07000613          	li	a2,112
ffffffffc0203e0a:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc0203e0c:	00052423          	sw	zero,8(a0) # ffffffffc8000008 <end+0x7d551b4>
        proc->kstack = 0;
ffffffffc0203e10:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203e14:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc0203e18:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc0203e1c:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203e20:	03050513          	addi	a0,a0,48
ffffffffc0203e24:	0d7010ef          	jal	ra,ffffffffc02056fa <memset>
        proc->tf = NULL;
        proc->pgdir = 0;
        proc->flags = 0;
        memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203e28:	4641                	li	a2,16
        proc->tf = NULL;
ffffffffc0203e2a:	0a043023          	sd	zero,160(s0)
        proc->pgdir = 0;
ffffffffc0203e2e:	0a043423          	sd	zero,168(s0)
        proc->flags = 0;
ffffffffc0203e32:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203e36:	4581                	li	a1,0
ffffffffc0203e38:	0b440513          	addi	a0,s0,180
ffffffffc0203e3c:	0bf010ef          	jal	ra,ffffffffc02056fa <memset>
        list_init(&(proc->list_link));
ffffffffc0203e40:	0c840713          	addi	a4,s0,200
        list_init(&(proc->hash_link));
ffffffffc0203e44:	0d840793          	addi	a5,s0,216
    elm->prev = elm->next = elm;
ffffffffc0203e48:	e878                	sd	a4,208(s0)
ffffffffc0203e4a:	e478                	sd	a4,200(s0)
ffffffffc0203e4c:	f07c                	sd	a5,224(s0)
ffffffffc0203e4e:	ec7c                	sd	a5,216(s0)
        proc->exit_code = 0;
ffffffffc0203e50:	0e043423          	sd	zero,232(s0)
        proc->wait_state = 0;
        proc->cptr = proc->yptr = proc->optr = NULL;
ffffffffc0203e54:	0e043823          	sd	zero,240(s0)
ffffffffc0203e58:	0e043c23          	sd	zero,248(s0)
ffffffffc0203e5c:	10043023          	sd	zero,256(s0)
    }
    return proc;
}
ffffffffc0203e60:	60a2                	ld	ra,8(sp)
ffffffffc0203e62:	8522                	mv	a0,s0
ffffffffc0203e64:	6402                	ld	s0,0(sp)
ffffffffc0203e66:	0141                	addi	sp,sp,16
ffffffffc0203e68:	8082                	ret

ffffffffc0203e6a <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203e6a:	000a7797          	auipc	a5,0xa7
ffffffffc0203e6e:	fce7b783          	ld	a5,-50(a5) # ffffffffc02aae38 <current>
ffffffffc0203e72:	73c8                	ld	a0,160(a5)
ffffffffc0203e74:	8cefd06f          	j	ffffffffc0200f42 <forkrets>

ffffffffc0203e78 <user_main>:
// user_main - kernel thread used to exec a user program
static int
user_main(void *arg)
{
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203e78:	000a7797          	auipc	a5,0xa7
ffffffffc0203e7c:	fc07b783          	ld	a5,-64(a5) # ffffffffc02aae38 <current>
ffffffffc0203e80:	43cc                	lw	a1,4(a5)
{
ffffffffc0203e82:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203e84:	00003617          	auipc	a2,0x3
ffffffffc0203e88:	0dc60613          	addi	a2,a2,220 # ffffffffc0206f60 <default_pmm_manager+0x9f8>
ffffffffc0203e8c:	00003517          	auipc	a0,0x3
ffffffffc0203e90:	0dc50513          	addi	a0,a0,220 # ffffffffc0206f68 <default_pmm_manager+0xa00>
{
ffffffffc0203e94:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203e96:	afefc0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0203e9a:	3fe06797          	auipc	a5,0x3fe06
ffffffffc0203e9e:	77678793          	addi	a5,a5,1910 # a610 <_binary_obj___user_divzero_out_size>
ffffffffc0203ea2:	e43e                	sd	a5,8(sp)
ffffffffc0203ea4:	00003517          	auipc	a0,0x3
ffffffffc0203ea8:	0bc50513          	addi	a0,a0,188 # ffffffffc0206f60 <default_pmm_manager+0x9f8>
ffffffffc0203eac:	0001c797          	auipc	a5,0x1c
ffffffffc0203eb0:	1c478793          	addi	a5,a5,452 # ffffffffc0220070 <_binary_obj___user_divzero_out_start>
ffffffffc0203eb4:	f03e                	sd	a5,32(sp)
ffffffffc0203eb6:	f42a                	sd	a0,40(sp)
    int64_t ret = 0, len = strlen(name);
ffffffffc0203eb8:	e802                	sd	zero,16(sp)
ffffffffc0203eba:	79e010ef          	jal	ra,ffffffffc0205658 <strlen>
ffffffffc0203ebe:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203ec0:	4511                	li	a0,4
ffffffffc0203ec2:	55a2                	lw	a1,40(sp)
ffffffffc0203ec4:	4662                	lw	a2,24(sp)
ffffffffc0203ec6:	5682                	lw	a3,32(sp)
ffffffffc0203ec8:	4722                	lw	a4,8(sp)
ffffffffc0203eca:	48a9                	li	a7,10
ffffffffc0203ecc:	9002                	ebreak
ffffffffc0203ece:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203ed0:	65c2                	ld	a1,16(sp)
ffffffffc0203ed2:	00003517          	auipc	a0,0x3
ffffffffc0203ed6:	0be50513          	addi	a0,a0,190 # ffffffffc0206f90 <default_pmm_manager+0xa28>
ffffffffc0203eda:	abafc0ef          	jal	ra,ffffffffc0200194 <cprintf>
#else
    KERNEL_EXECVE(exit);
#endif
    panic("user_main execve failed.\n");
ffffffffc0203ede:	00003617          	auipc	a2,0x3
ffffffffc0203ee2:	0c260613          	addi	a2,a2,194 # ffffffffc0206fa0 <default_pmm_manager+0xa38>
ffffffffc0203ee6:	38200593          	li	a1,898
ffffffffc0203eea:	00003517          	auipc	a0,0x3
ffffffffc0203eee:	0d650513          	addi	a0,a0,214 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0203ef2:	d9cfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203ef6 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203ef6:	6d14                	ld	a3,24(a0)
{
ffffffffc0203ef8:	1141                	addi	sp,sp,-16
ffffffffc0203efa:	e406                	sd	ra,8(sp)
ffffffffc0203efc:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f00:	02f6ee63          	bltu	a3,a5,ffffffffc0203f3c <put_pgdir+0x46>
ffffffffc0203f04:	000a7517          	auipc	a0,0xa7
ffffffffc0203f08:	f2c53503          	ld	a0,-212(a0) # ffffffffc02aae30 <va_pa_offset>
ffffffffc0203f0c:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203f0e:	82b1                	srli	a3,a3,0xc
ffffffffc0203f10:	000a7797          	auipc	a5,0xa7
ffffffffc0203f14:	f087b783          	ld	a5,-248(a5) # ffffffffc02aae18 <npage>
ffffffffc0203f18:	02f6fe63          	bgeu	a3,a5,ffffffffc0203f54 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203f1c:	00004517          	auipc	a0,0x4
ffffffffc0203f20:	96c53503          	ld	a0,-1684(a0) # ffffffffc0207888 <nbase>
}
ffffffffc0203f24:	60a2                	ld	ra,8(sp)
ffffffffc0203f26:	8e89                	sub	a3,a3,a0
ffffffffc0203f28:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203f2a:	000a7517          	auipc	a0,0xa7
ffffffffc0203f2e:	ef653503          	ld	a0,-266(a0) # ffffffffc02aae20 <pages>
ffffffffc0203f32:	4585                	li	a1,1
ffffffffc0203f34:	9536                	add	a0,a0,a3
}
ffffffffc0203f36:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203f38:	fb3fd06f          	j	ffffffffc0201eea <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203f3c:	00002617          	auipc	a2,0x2
ffffffffc0203f40:	70c60613          	addi	a2,a2,1804 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc0203f44:	07700593          	li	a1,119
ffffffffc0203f48:	00002517          	auipc	a0,0x2
ffffffffc0203f4c:	68050513          	addi	a0,a0,1664 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0203f50:	d3efc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203f54:	00002617          	auipc	a2,0x2
ffffffffc0203f58:	71c60613          	addi	a2,a2,1820 # ffffffffc0206670 <default_pmm_manager+0x108>
ffffffffc0203f5c:	06900593          	li	a1,105
ffffffffc0203f60:	00002517          	auipc	a0,0x2
ffffffffc0203f64:	66850513          	addi	a0,a0,1640 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0203f68:	d26fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203f6c <proc_run>:
{
ffffffffc0203f6c:	7179                	addi	sp,sp,-48
ffffffffc0203f6e:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203f70:	000a7917          	auipc	s2,0xa7
ffffffffc0203f74:	ec890913          	addi	s2,s2,-312 # ffffffffc02aae38 <current>
{
ffffffffc0203f78:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203f7a:	00093483          	ld	s1,0(s2)
{
ffffffffc0203f7e:	f406                	sd	ra,40(sp)
ffffffffc0203f80:	e84e                	sd	s3,16(sp)
    if (proc != current)
ffffffffc0203f82:	04a48163          	beq	s1,a0,ffffffffc0203fc4 <proc_run+0x58>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f86:	100027f3          	csrr	a5,sstatus
ffffffffc0203f8a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203f8c:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f8e:	e7b1                	bnez	a5,ffffffffc0203fda <proc_run+0x6e>
            if (current->mm != NULL)
ffffffffc0203f90:	751c                	ld	a5,40(a0)
            current = proc;
ffffffffc0203f92:	00a93023          	sd	a0,0(s2)
            if (current->mm != NULL)
ffffffffc0203f96:	cf8d                	beqz	a5,ffffffffc0203fd0 <proc_run+0x64>
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203f98:	755c                	ld	a5,168(a0)
ffffffffc0203f9a:	577d                	li	a4,-1
ffffffffc0203f9c:	177e                	slli	a4,a4,0x3f
ffffffffc0203f9e:	83b1                	srli	a5,a5,0xc
ffffffffc0203fa0:	8fd9                	or	a5,a5,a4
ffffffffc0203fa2:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(current->context));
ffffffffc0203fa6:	03050593          	addi	a1,a0,48
ffffffffc0203faa:	03048513          	addi	a0,s1,48
ffffffffc0203fae:	050010ef          	jal	ra,ffffffffc0204ffe <switch_to>
    if (flag)
ffffffffc0203fb2:	00098963          	beqz	s3,ffffffffc0203fc4 <proc_run+0x58>
}
ffffffffc0203fb6:	70a2                	ld	ra,40(sp)
ffffffffc0203fb8:	7482                	ld	s1,32(sp)
ffffffffc0203fba:	6962                	ld	s2,24(sp)
ffffffffc0203fbc:	69c2                	ld	s3,16(sp)
ffffffffc0203fbe:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203fc0:	9effc06f          	j	ffffffffc02009ae <intr_enable>
ffffffffc0203fc4:	70a2                	ld	ra,40(sp)
ffffffffc0203fc6:	7482                	ld	s1,32(sp)
ffffffffc0203fc8:	6962                	ld	s2,24(sp)
ffffffffc0203fca:	69c2                	ld	s3,16(sp)
ffffffffc0203fcc:	6145                	addi	sp,sp,48
ffffffffc0203fce:	8082                	ret
ffffffffc0203fd0:	000a7797          	auipc	a5,0xa7
ffffffffc0203fd4:	e387b783          	ld	a5,-456(a5) # ffffffffc02aae08 <boot_pgdir_pa>
ffffffffc0203fd8:	b7c9                	j	ffffffffc0203f9a <proc_run+0x2e>
ffffffffc0203fda:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203fdc:	9d9fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0203fe0:	6522                	ld	a0,8(sp)
ffffffffc0203fe2:	4985                	li	s3,1
ffffffffc0203fe4:	b775                	j	ffffffffc0203f90 <proc_run+0x24>

ffffffffc0203fe6 <do_fork>:
{
ffffffffc0203fe6:	7119                	addi	sp,sp,-128
ffffffffc0203fe8:	f4a6                	sd	s1,104(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203fea:	000a7497          	auipc	s1,0xa7
ffffffffc0203fee:	e6648493          	addi	s1,s1,-410 # ffffffffc02aae50 <nr_process>
ffffffffc0203ff2:	4098                	lw	a4,0(s1)
{
ffffffffc0203ff4:	fc86                	sd	ra,120(sp)
ffffffffc0203ff6:	f8a2                	sd	s0,112(sp)
ffffffffc0203ff8:	f0ca                	sd	s2,96(sp)
ffffffffc0203ffa:	ecce                	sd	s3,88(sp)
ffffffffc0203ffc:	e8d2                	sd	s4,80(sp)
ffffffffc0203ffe:	e4d6                	sd	s5,72(sp)
ffffffffc0204000:	e0da                	sd	s6,64(sp)
ffffffffc0204002:	fc5e                	sd	s7,56(sp)
ffffffffc0204004:	f862                	sd	s8,48(sp)
ffffffffc0204006:	f466                	sd	s9,40(sp)
ffffffffc0204008:	f06a                	sd	s10,32(sp)
ffffffffc020400a:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc020400c:	6785                	lui	a5,0x1
ffffffffc020400e:	30f75f63          	bge	a4,a5,ffffffffc020432c <do_fork+0x346>
ffffffffc0204012:	8a2a                	mv	s4,a0
ffffffffc0204014:	892e                	mv	s2,a1
ffffffffc0204016:	89b2                	mv	s3,a2
    if ((proc = alloc_proc()) == NULL)
ffffffffc0204018:	dd7ff0ef          	jal	ra,ffffffffc0203dee <alloc_proc>
ffffffffc020401c:	842a                	mv	s0,a0
ffffffffc020401e:	30050e63          	beqz	a0,ffffffffc020433a <do_fork+0x354>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0204022:	4509                	li	a0,2
ffffffffc0204024:	e89fd0ef          	jal	ra,ffffffffc0201eac <alloc_pages>
    if (page != NULL)
ffffffffc0204028:	30050063          	beqz	a0,ffffffffc0204328 <do_fork+0x342>
    return page - pages + nbase;
ffffffffc020402c:	000a7c97          	auipc	s9,0xa7
ffffffffc0204030:	df4c8c93          	addi	s9,s9,-524 # ffffffffc02aae20 <pages>
ffffffffc0204034:	000cb683          	ld	a3,0(s9)
ffffffffc0204038:	00004a97          	auipc	s5,0x4
ffffffffc020403c:	850a8a93          	addi	s5,s5,-1968 # ffffffffc0207888 <nbase>
ffffffffc0204040:	000ab703          	ld	a4,0(s5)
ffffffffc0204044:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc0204048:	000a7d17          	auipc	s10,0xa7
ffffffffc020404c:	dd0d0d13          	addi	s10,s10,-560 # ffffffffc02aae18 <npage>
    return page - pages + nbase;
ffffffffc0204050:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204052:	5b7d                	li	s6,-1
ffffffffc0204054:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc0204058:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc020405a:	00cb5b13          	srli	s6,s6,0xc
ffffffffc020405e:	0166f633          	and	a2,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0204062:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204064:	2ef67263          	bgeu	a2,a5,ffffffffc0204348 <do_fork+0x362>
ffffffffc0204068:	000a7d97          	auipc	s11,0xa7
ffffffffc020406c:	dc8d8d93          	addi	s11,s11,-568 # ffffffffc02aae30 <va_pa_offset>
ffffffffc0204070:	000db603          	ld	a2,0(s11)
    proc->parent = current;
ffffffffc0204074:	000a7797          	auipc	a5,0xa7
ffffffffc0204078:	dc47b783          	ld	a5,-572(a5) # ffffffffc02aae38 <current>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc020407c:	0287bb83          	ld	s7,40(a5)
ffffffffc0204080:	96b2                	add	a3,a3,a2
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0204082:	e814                	sd	a3,16(s0)
    proc->parent = current;
ffffffffc0204084:	f01c                	sd	a5,32(s0)
    current->wait_state = 0;
ffffffffc0204086:	e43a                	sd	a4,8(sp)
ffffffffc0204088:	0e07a623          	sw	zero,236(a5)
    if (oldmm == NULL)
ffffffffc020408c:	020b8863          	beqz	s7,ffffffffc02040bc <do_fork+0xd6>
    if (clone_flags & CLONE_VM)
ffffffffc0204090:	100a7a13          	andi	s4,s4,256
ffffffffc0204094:	1a0a0363          	beqz	s4,ffffffffc020423a <do_fork+0x254>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc0204098:	030ba703          	lw	a4,48(s7)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc020409c:	018bb783          	ld	a5,24(s7)
ffffffffc02040a0:	c02006b7          	lui	a3,0xc0200
ffffffffc02040a4:	2705                	addiw	a4,a4,1
ffffffffc02040a6:	02eba823          	sw	a4,48(s7)
    proc->mm = mm;
ffffffffc02040aa:	03743423          	sd	s7,40(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc02040ae:	2cd7e563          	bltu	a5,a3,ffffffffc0204378 <do_fork+0x392>
ffffffffc02040b2:	000db703          	ld	a4,0(s11)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc02040b6:	6814                	ld	a3,16(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc02040b8:	8f99                	sub	a5,a5,a4
ffffffffc02040ba:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc02040bc:	6789                	lui	a5,0x2
ffffffffc02040be:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7d40>
ffffffffc02040c2:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc02040c4:	864e                	mv	a2,s3
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc02040c6:	f054                	sd	a3,160(s0)
    *(proc->tf) = *tf;
ffffffffc02040c8:	87b6                	mv	a5,a3
ffffffffc02040ca:	12098893          	addi	a7,s3,288
ffffffffc02040ce:	00063803          	ld	a6,0(a2)
ffffffffc02040d2:	6608                	ld	a0,8(a2)
ffffffffc02040d4:	6a0c                	ld	a1,16(a2)
ffffffffc02040d6:	6e18                	ld	a4,24(a2)
ffffffffc02040d8:	0107b023          	sd	a6,0(a5)
ffffffffc02040dc:	e788                	sd	a0,8(a5)
ffffffffc02040de:	eb8c                	sd	a1,16(a5)
ffffffffc02040e0:	ef98                	sd	a4,24(a5)
ffffffffc02040e2:	02060613          	addi	a2,a2,32
ffffffffc02040e6:	02078793          	addi	a5,a5,32
ffffffffc02040ea:	ff1612e3          	bne	a2,a7,ffffffffc02040ce <do_fork+0xe8>
    proc->tf->gpr.a0 = 0;
ffffffffc02040ee:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02040f2:	1c090d63          	beqz	s2,ffffffffc02042cc <do_fork+0x2e6>
    if (++last_pid >= MAX_PID)
ffffffffc02040f6:	000a3817          	auipc	a6,0xa3
ffffffffc02040fa:	8aa80813          	addi	a6,a6,-1878 # ffffffffc02a69a0 <last_pid.1>
ffffffffc02040fe:	00082783          	lw	a5,0(a6)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0204102:	0126b823          	sd	s2,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0204106:	00000717          	auipc	a4,0x0
ffffffffc020410a:	d6470713          	addi	a4,a4,-668 # ffffffffc0203e6a <forkret>
    if (++last_pid >= MAX_PID)
ffffffffc020410e:	0017851b          	addiw	a0,a5,1
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0204112:	f818                	sd	a4,48(s0)
    proc->state = PROC_RUNNABLE;
ffffffffc0204114:	4709                	li	a4,2
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc0204116:	fc14                	sd	a3,56(s0)
    proc->state = PROC_RUNNABLE;
ffffffffc0204118:	c018                	sw	a4,0(s0)
    if (++last_pid >= MAX_PID)
ffffffffc020411a:	00a82023          	sw	a0,0(a6)
ffffffffc020411e:	6789                	lui	a5,0x2
ffffffffc0204120:	0af55663          	bge	a0,a5,ffffffffc02041cc <do_fork+0x1e6>
    if (last_pid >= next_safe)
ffffffffc0204124:	000a3317          	auipc	t1,0xa3
ffffffffc0204128:	88030313          	addi	t1,t1,-1920 # ffffffffc02a69a4 <next_safe.0>
ffffffffc020412c:	00032783          	lw	a5,0(t1)
ffffffffc0204130:	000a7917          	auipc	s2,0xa7
ffffffffc0204134:	c9090913          	addi	s2,s2,-880 # ffffffffc02aadc0 <proc_list>
ffffffffc0204138:	0af55263          	bge	a0,a5,ffffffffc02041dc <do_fork+0x1f6>
    proc->pid = get_pid();
ffffffffc020413c:	c048                	sw	a0,4(s0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020413e:	100027f3          	csrr	a5,sstatus
ffffffffc0204142:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204144:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204146:	1c079c63          	bnez	a5,ffffffffc020431e <do_fork+0x338>
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc020414a:	45a9                	li	a1,10
ffffffffc020414c:	2501                	sext.w	a0,a0
ffffffffc020414e:	106010ef          	jal	ra,ffffffffc0205254 <hash32>
ffffffffc0204152:	02051793          	slli	a5,a0,0x20
ffffffffc0204156:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020415a:	000a3797          	auipc	a5,0xa3
ffffffffc020415e:	c6678793          	addi	a5,a5,-922 # ffffffffc02a6dc0 <hash_list>
ffffffffc0204162:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc0204164:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204166:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204168:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc020416c:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc020416e:	00893603          	ld	a2,8(s2)
    prev->next = next->prev = elm;
ffffffffc0204172:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204174:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc0204176:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc020417a:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc020417c:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc020417e:	e21c                	sd	a5,0(a2)
ffffffffc0204180:	00f93423          	sd	a5,8(s2)
    elm->next = next;
ffffffffc0204184:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc0204186:	0d243423          	sd	s2,200(s0)
    proc->yptr = NULL;
ffffffffc020418a:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020418e:	10e43023          	sd	a4,256(s0)
ffffffffc0204192:	c311                	beqz	a4,ffffffffc0204196 <do_fork+0x1b0>
        proc->optr->yptr = proc;
ffffffffc0204194:	ff60                	sd	s0,248(a4)
    nr_process++;
ffffffffc0204196:	409c                	lw	a5,0(s1)
    proc->parent->cptr = proc;
ffffffffc0204198:	fae0                	sd	s0,240(a3)
    nr_process++;
ffffffffc020419a:	2785                	addiw	a5,a5,1
ffffffffc020419c:	c09c                	sw	a5,0(s1)
    if (flag)
ffffffffc020419e:	12099963          	bnez	s3,ffffffffc02042d0 <do_fork+0x2ea>
    wakeup_proc(proc);
ffffffffc02041a2:	8522                	mv	a0,s0
ffffffffc02041a4:	6c5000ef          	jal	ra,ffffffffc0205068 <wakeup_proc>
    ret = proc->pid;
ffffffffc02041a8:	00442a03          	lw	s4,4(s0)
}
ffffffffc02041ac:	70e6                	ld	ra,120(sp)
ffffffffc02041ae:	7446                	ld	s0,112(sp)
ffffffffc02041b0:	74a6                	ld	s1,104(sp)
ffffffffc02041b2:	7906                	ld	s2,96(sp)
ffffffffc02041b4:	69e6                	ld	s3,88(sp)
ffffffffc02041b6:	6aa6                	ld	s5,72(sp)
ffffffffc02041b8:	6b06                	ld	s6,64(sp)
ffffffffc02041ba:	7be2                	ld	s7,56(sp)
ffffffffc02041bc:	7c42                	ld	s8,48(sp)
ffffffffc02041be:	7ca2                	ld	s9,40(sp)
ffffffffc02041c0:	7d02                	ld	s10,32(sp)
ffffffffc02041c2:	6de2                	ld	s11,24(sp)
ffffffffc02041c4:	8552                	mv	a0,s4
ffffffffc02041c6:	6a46                	ld	s4,80(sp)
ffffffffc02041c8:	6109                	addi	sp,sp,128
ffffffffc02041ca:	8082                	ret
        last_pid = 1;
ffffffffc02041cc:	4785                	li	a5,1
ffffffffc02041ce:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc02041d2:	4505                	li	a0,1
ffffffffc02041d4:	000a2317          	auipc	t1,0xa2
ffffffffc02041d8:	7d030313          	addi	t1,t1,2000 # ffffffffc02a69a4 <next_safe.0>
    return listelm->next;
ffffffffc02041dc:	000a7917          	auipc	s2,0xa7
ffffffffc02041e0:	be490913          	addi	s2,s2,-1052 # ffffffffc02aadc0 <proc_list>
ffffffffc02041e4:	00893e03          	ld	t3,8(s2)
        next_safe = MAX_PID;
ffffffffc02041e8:	6789                	lui	a5,0x2
ffffffffc02041ea:	00f32023          	sw	a5,0(t1)
ffffffffc02041ee:	86aa                	mv	a3,a0
ffffffffc02041f0:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc02041f2:	6e89                	lui	t4,0x2
ffffffffc02041f4:	132e0e63          	beq	t3,s2,ffffffffc0204330 <do_fork+0x34a>
ffffffffc02041f8:	88ae                	mv	a7,a1
ffffffffc02041fa:	87f2                	mv	a5,t3
ffffffffc02041fc:	6609                	lui	a2,0x2
ffffffffc02041fe:	a811                	j	ffffffffc0204212 <do_fork+0x22c>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc0204200:	00e6d663          	bge	a3,a4,ffffffffc020420c <do_fork+0x226>
ffffffffc0204204:	00c75463          	bge	a4,a2,ffffffffc020420c <do_fork+0x226>
ffffffffc0204208:	863a                	mv	a2,a4
ffffffffc020420a:	4885                	li	a7,1
ffffffffc020420c:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc020420e:	01278d63          	beq	a5,s2,ffffffffc0204228 <do_fork+0x242>
            if (proc->pid == last_pid)
ffffffffc0204212:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x7ce4>
ffffffffc0204216:	fed715e3          	bne	a4,a3,ffffffffc0204200 <do_fork+0x21a>
                if (++last_pid >= next_safe)
ffffffffc020421a:	2685                	addiw	a3,a3,1
ffffffffc020421c:	0ec6dc63          	bge	a3,a2,ffffffffc0204314 <do_fork+0x32e>
ffffffffc0204220:	679c                	ld	a5,8(a5)
ffffffffc0204222:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc0204224:	ff2797e3          	bne	a5,s2,ffffffffc0204212 <do_fork+0x22c>
ffffffffc0204228:	c581                	beqz	a1,ffffffffc0204230 <do_fork+0x24a>
ffffffffc020422a:	00d82023          	sw	a3,0(a6)
ffffffffc020422e:	8536                	mv	a0,a3
ffffffffc0204230:	f00886e3          	beqz	a7,ffffffffc020413c <do_fork+0x156>
ffffffffc0204234:	00c32023          	sw	a2,0(t1)
ffffffffc0204238:	b711                	j	ffffffffc020413c <do_fork+0x156>
    if ((mm = mm_create()) == NULL)
ffffffffc020423a:	ca2ff0ef          	jal	ra,ffffffffc02036dc <mm_create>
ffffffffc020423e:	8c2a                	mv	s8,a0
ffffffffc0204240:	10050263          	beqz	a0,ffffffffc0204344 <do_fork+0x35e>
    if ((page = alloc_page()) == NULL)
ffffffffc0204244:	4505                	li	a0,1
ffffffffc0204246:	c67fd0ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc020424a:	c551                	beqz	a0,ffffffffc02042d6 <do_fork+0x2f0>
    return page - pages + nbase;
ffffffffc020424c:	000cb683          	ld	a3,0(s9)
ffffffffc0204250:	6722                	ld	a4,8(sp)
    return KADDR(page2pa(page));
ffffffffc0204252:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc0204256:	40d506b3          	sub	a3,a0,a3
ffffffffc020425a:	8699                	srai	a3,a3,0x6
ffffffffc020425c:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc020425e:	0166fb33          	and	s6,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0204262:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204264:	0efb7263          	bgeu	s6,a5,ffffffffc0204348 <do_fork+0x362>
ffffffffc0204268:	000dba03          	ld	s4,0(s11)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc020426c:	6605                	lui	a2,0x1
ffffffffc020426e:	000a7597          	auipc	a1,0xa7
ffffffffc0204272:	ba25b583          	ld	a1,-1118(a1) # ffffffffc02aae10 <boot_pgdir_va>
ffffffffc0204276:	9a36                	add	s4,s4,a3
ffffffffc0204278:	8552                	mv	a0,s4
ffffffffc020427a:	492010ef          	jal	ra,ffffffffc020570c <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc020427e:	038b8b13          	addi	s6,s7,56
    mm->pgdir = pgdir;
ffffffffc0204282:	014c3c23          	sd	s4,24(s8)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0204286:	4785                	li	a5,1
ffffffffc0204288:	40fb37af          	amoor.d	a5,a5,(s6)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc020428c:	8b85                	andi	a5,a5,1
ffffffffc020428e:	4a05                	li	s4,1
ffffffffc0204290:	c799                	beqz	a5,ffffffffc020429e <do_fork+0x2b8>
    {
        schedule();
ffffffffc0204292:	657000ef          	jal	ra,ffffffffc02050e8 <schedule>
ffffffffc0204296:	414b37af          	amoor.d	a5,s4,(s6)
    while (!try_lock(lock))
ffffffffc020429a:	8b85                	andi	a5,a5,1
ffffffffc020429c:	fbfd                	bnez	a5,ffffffffc0204292 <do_fork+0x2ac>
        ret = dup_mmap(mm, oldmm);
ffffffffc020429e:	85de                	mv	a1,s7
ffffffffc02042a0:	8562                	mv	a0,s8
ffffffffc02042a2:	e7cff0ef          	jal	ra,ffffffffc020391e <dup_mmap>
ffffffffc02042a6:	8a2a                	mv	s4,a0
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc02042a8:	57f9                	li	a5,-2
ffffffffc02042aa:	60fb37af          	amoand.d	a5,a5,(s6)
ffffffffc02042ae:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc02042b0:	cbc5                	beqz	a5,ffffffffc0204360 <do_fork+0x37a>
good_mm:
ffffffffc02042b2:	8be2                	mv	s7,s8
    if (ret != 0)
ffffffffc02042b4:	de0502e3          	beqz	a0,ffffffffc0204098 <do_fork+0xb2>
    exit_mmap(mm);
ffffffffc02042b8:	8562                	mv	a0,s8
ffffffffc02042ba:	efeff0ef          	jal	ra,ffffffffc02039b8 <exit_mmap>
    put_pgdir(mm);
ffffffffc02042be:	8562                	mv	a0,s8
ffffffffc02042c0:	c37ff0ef          	jal	ra,ffffffffc0203ef6 <put_pgdir>
    mm_destroy(mm);
ffffffffc02042c4:	8562                	mv	a0,s8
ffffffffc02042c6:	d56ff0ef          	jal	ra,ffffffffc020381c <mm_destroy>
ffffffffc02042ca:	a811                	j	ffffffffc02042de <do_fork+0x2f8>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02042cc:	8936                	mv	s2,a3
ffffffffc02042ce:	b525                	j	ffffffffc02040f6 <do_fork+0x110>
        intr_enable();
ffffffffc02042d0:	edefc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02042d4:	b5f9                	j	ffffffffc02041a2 <do_fork+0x1bc>
    mm_destroy(mm);
ffffffffc02042d6:	8562                	mv	a0,s8
ffffffffc02042d8:	d44ff0ef          	jal	ra,ffffffffc020381c <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc02042dc:	5a71                	li	s4,-4
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc02042de:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc02042e0:	c02007b7          	lui	a5,0xc0200
ffffffffc02042e4:	0cf6e363          	bltu	a3,a5,ffffffffc02043aa <do_fork+0x3c4>
ffffffffc02042e8:	000db703          	ld	a4,0(s11)
    if (PPN(pa) >= npage)
ffffffffc02042ec:	000d3783          	ld	a5,0(s10)
    return pa2page(PADDR(kva));
ffffffffc02042f0:	8e99                	sub	a3,a3,a4
    if (PPN(pa) >= npage)
ffffffffc02042f2:	82b1                	srli	a3,a3,0xc
ffffffffc02042f4:	08f6ff63          	bgeu	a3,a5,ffffffffc0204392 <do_fork+0x3ac>
    return &pages[PPN(pa) - nbase];
ffffffffc02042f8:	000ab783          	ld	a5,0(s5)
ffffffffc02042fc:	000cb503          	ld	a0,0(s9)
ffffffffc0204300:	4589                	li	a1,2
ffffffffc0204302:	8e9d                	sub	a3,a3,a5
ffffffffc0204304:	069a                	slli	a3,a3,0x6
ffffffffc0204306:	9536                	add	a0,a0,a3
ffffffffc0204308:	be3fd0ef          	jal	ra,ffffffffc0201eea <free_pages>
    kfree(proc);
ffffffffc020430c:	8522                	mv	a0,s0
ffffffffc020430e:	a71fd0ef          	jal	ra,ffffffffc0201d7e <kfree>
    return ret;
ffffffffc0204312:	bd69                	j	ffffffffc02041ac <do_fork+0x1c6>
                    if (last_pid >= MAX_PID)
ffffffffc0204314:	01d6c363          	blt	a3,t4,ffffffffc020431a <do_fork+0x334>
                        last_pid = 1;
ffffffffc0204318:	4685                	li	a3,1
                    goto repeat;
ffffffffc020431a:	4585                	li	a1,1
ffffffffc020431c:	bde1                	j	ffffffffc02041f4 <do_fork+0x20e>
        intr_disable();
ffffffffc020431e:	e96fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204322:	4048                	lw	a0,4(s0)
        return 1;
ffffffffc0204324:	4985                	li	s3,1
ffffffffc0204326:	b515                	j	ffffffffc020414a <do_fork+0x164>
    return -E_NO_MEM;
ffffffffc0204328:	5a71                	li	s4,-4
ffffffffc020432a:	b7cd                	j	ffffffffc020430c <do_fork+0x326>
    int ret = -E_NO_FREE_PROC;
ffffffffc020432c:	5a6d                	li	s4,-5
ffffffffc020432e:	bdbd                	j	ffffffffc02041ac <do_fork+0x1c6>
ffffffffc0204330:	c599                	beqz	a1,ffffffffc020433e <do_fork+0x358>
ffffffffc0204332:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc0204336:	8536                	mv	a0,a3
ffffffffc0204338:	b511                	j	ffffffffc020413c <do_fork+0x156>
    ret = -E_NO_MEM;
ffffffffc020433a:	5a71                	li	s4,-4
ffffffffc020433c:	bd85                	j	ffffffffc02041ac <do_fork+0x1c6>
    return last_pid;
ffffffffc020433e:	00082503          	lw	a0,0(a6)
ffffffffc0204342:	bbed                	j	ffffffffc020413c <do_fork+0x156>
    int ret = -E_NO_MEM;
ffffffffc0204344:	5a71                	li	s4,-4
ffffffffc0204346:	bf61                	j	ffffffffc02042de <do_fork+0x2f8>
    return KADDR(page2pa(page));
ffffffffc0204348:	00002617          	auipc	a2,0x2
ffffffffc020434c:	25860613          	addi	a2,a2,600 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0204350:	07100593          	li	a1,113
ffffffffc0204354:	00002517          	auipc	a0,0x2
ffffffffc0204358:	27450513          	addi	a0,a0,628 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc020435c:	932fc0ef          	jal	ra,ffffffffc020048e <__panic>
    {
        panic("Unlock failed.\n");
ffffffffc0204360:	00003617          	auipc	a2,0x3
ffffffffc0204364:	c7860613          	addi	a2,a2,-904 # ffffffffc0206fd8 <default_pmm_manager+0xa70>
ffffffffc0204368:	03f00593          	li	a1,63
ffffffffc020436c:	00003517          	auipc	a0,0x3
ffffffffc0204370:	c7c50513          	addi	a0,a0,-900 # ffffffffc0206fe8 <default_pmm_manager+0xa80>
ffffffffc0204374:	91afc0ef          	jal	ra,ffffffffc020048e <__panic>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204378:	86be                	mv	a3,a5
ffffffffc020437a:	00002617          	auipc	a2,0x2
ffffffffc020437e:	2ce60613          	addi	a2,a2,718 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc0204382:	17500593          	li	a1,373
ffffffffc0204386:	00003517          	auipc	a0,0x3
ffffffffc020438a:	c3a50513          	addi	a0,a0,-966 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc020438e:	900fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0204392:	00002617          	auipc	a2,0x2
ffffffffc0204396:	2de60613          	addi	a2,a2,734 # ffffffffc0206670 <default_pmm_manager+0x108>
ffffffffc020439a:	06900593          	li	a1,105
ffffffffc020439e:	00002517          	auipc	a0,0x2
ffffffffc02043a2:	22a50513          	addi	a0,a0,554 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc02043a6:	8e8fc0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc02043aa:	00002617          	auipc	a2,0x2
ffffffffc02043ae:	29e60613          	addi	a2,a2,670 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc02043b2:	07700593          	li	a1,119
ffffffffc02043b6:	00002517          	auipc	a0,0x2
ffffffffc02043ba:	21250513          	addi	a0,a0,530 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc02043be:	8d0fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02043c2 <kernel_thread>:
{
ffffffffc02043c2:	7129                	addi	sp,sp,-320
ffffffffc02043c4:	fa22                	sd	s0,304(sp)
ffffffffc02043c6:	f626                	sd	s1,296(sp)
ffffffffc02043c8:	f24a                	sd	s2,288(sp)
ffffffffc02043ca:	84ae                	mv	s1,a1
ffffffffc02043cc:	892a                	mv	s2,a0
ffffffffc02043ce:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc02043d0:	4581                	li	a1,0
ffffffffc02043d2:	12000613          	li	a2,288
ffffffffc02043d6:	850a                	mv	a0,sp
{
ffffffffc02043d8:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc02043da:	320010ef          	jal	ra,ffffffffc02056fa <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc02043de:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc02043e0:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc02043e2:	100027f3          	csrr	a5,sstatus
ffffffffc02043e6:	edd7f793          	andi	a5,a5,-291
ffffffffc02043ea:	1207e793          	ori	a5,a5,288
ffffffffc02043ee:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02043f0:	860a                	mv	a2,sp
ffffffffc02043f2:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc02043f6:	00000797          	auipc	a5,0x0
ffffffffc02043fa:	9f078793          	addi	a5,a5,-1552 # ffffffffc0203de6 <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02043fe:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0204400:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204402:	be5ff0ef          	jal	ra,ffffffffc0203fe6 <do_fork>
}
ffffffffc0204406:	70f2                	ld	ra,312(sp)
ffffffffc0204408:	7452                	ld	s0,304(sp)
ffffffffc020440a:	74b2                	ld	s1,296(sp)
ffffffffc020440c:	7912                	ld	s2,288(sp)
ffffffffc020440e:	6131                	addi	sp,sp,320
ffffffffc0204410:	8082                	ret

ffffffffc0204412 <do_exit>:
{
ffffffffc0204412:	7179                	addi	sp,sp,-48
ffffffffc0204414:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc0204416:	000a7417          	auipc	s0,0xa7
ffffffffc020441a:	a2240413          	addi	s0,s0,-1502 # ffffffffc02aae38 <current>
ffffffffc020441e:	601c                	ld	a5,0(s0)
{
ffffffffc0204420:	f406                	sd	ra,40(sp)
ffffffffc0204422:	ec26                	sd	s1,24(sp)
ffffffffc0204424:	e84a                	sd	s2,16(sp)
ffffffffc0204426:	e44e                	sd	s3,8(sp)
ffffffffc0204428:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc020442a:	000a7717          	auipc	a4,0xa7
ffffffffc020442e:	a1673703          	ld	a4,-1514(a4) # ffffffffc02aae40 <idleproc>
ffffffffc0204432:	0ce78c63          	beq	a5,a4,ffffffffc020450a <do_exit+0xf8>
    if (current == initproc)
ffffffffc0204436:	000a7497          	auipc	s1,0xa7
ffffffffc020443a:	a1248493          	addi	s1,s1,-1518 # ffffffffc02aae48 <initproc>
ffffffffc020443e:	6098                	ld	a4,0(s1)
ffffffffc0204440:	0ee78b63          	beq	a5,a4,ffffffffc0204536 <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc0204444:	0287b983          	ld	s3,40(a5)
ffffffffc0204448:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc020444a:	02098663          	beqz	s3,ffffffffc0204476 <do_exit+0x64>
ffffffffc020444e:	000a7797          	auipc	a5,0xa7
ffffffffc0204452:	9ba7b783          	ld	a5,-1606(a5) # ffffffffc02aae08 <boot_pgdir_pa>
ffffffffc0204456:	577d                	li	a4,-1
ffffffffc0204458:	177e                	slli	a4,a4,0x3f
ffffffffc020445a:	83b1                	srli	a5,a5,0xc
ffffffffc020445c:	8fd9                	or	a5,a5,a4
ffffffffc020445e:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc0204462:	0309a783          	lw	a5,48(s3)
ffffffffc0204466:	fff7871b          	addiw	a4,a5,-1
ffffffffc020446a:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc020446e:	cb55                	beqz	a4,ffffffffc0204522 <do_exit+0x110>
        current->mm = NULL;
ffffffffc0204470:	601c                	ld	a5,0(s0)
ffffffffc0204472:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc0204476:	601c                	ld	a5,0(s0)
ffffffffc0204478:	470d                	li	a4,3
ffffffffc020447a:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc020447c:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204480:	100027f3          	csrr	a5,sstatus
ffffffffc0204484:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204486:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204488:	e3f9                	bnez	a5,ffffffffc020454e <do_exit+0x13c>
        proc = current->parent;
ffffffffc020448a:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc020448c:	800007b7          	lui	a5,0x80000
ffffffffc0204490:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc0204492:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc0204494:	0ec52703          	lw	a4,236(a0)
ffffffffc0204498:	0af70f63          	beq	a4,a5,ffffffffc0204556 <do_exit+0x144>
        while (current->cptr != NULL)
ffffffffc020449c:	6018                	ld	a4,0(s0)
ffffffffc020449e:	7b7c                	ld	a5,240(a4)
ffffffffc02044a0:	c3a1                	beqz	a5,ffffffffc02044e0 <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD)
ffffffffc02044a2:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044a6:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc02044a8:	0985                	addi	s3,s3,1
ffffffffc02044aa:	a021                	j	ffffffffc02044b2 <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc02044ac:	6018                	ld	a4,0(s0)
ffffffffc02044ae:	7b7c                	ld	a5,240(a4)
ffffffffc02044b0:	cb85                	beqz	a5,ffffffffc02044e0 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc02044b2:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_exit_out_size+0xffffffff7fff4f68>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02044b6:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc02044b8:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02044ba:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc02044bc:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02044c0:	10e7b023          	sd	a4,256(a5)
ffffffffc02044c4:	c311                	beqz	a4,ffffffffc02044c8 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc02044c6:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044c8:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc02044ca:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc02044cc:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044ce:	fd271fe3          	bne	a4,s2,ffffffffc02044ac <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc02044d2:	0ec52783          	lw	a5,236(a0)
ffffffffc02044d6:	fd379be3          	bne	a5,s3,ffffffffc02044ac <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc02044da:	38f000ef          	jal	ra,ffffffffc0205068 <wakeup_proc>
ffffffffc02044de:	b7f9                	j	ffffffffc02044ac <do_exit+0x9a>
    if (flag)
ffffffffc02044e0:	020a1263          	bnez	s4,ffffffffc0204504 <do_exit+0xf2>
    schedule();
ffffffffc02044e4:	405000ef          	jal	ra,ffffffffc02050e8 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc02044e8:	601c                	ld	a5,0(s0)
ffffffffc02044ea:	00003617          	auipc	a2,0x3
ffffffffc02044ee:	b3660613          	addi	a2,a2,-1226 # ffffffffc0207020 <default_pmm_manager+0xab8>
ffffffffc02044f2:	1ff00593          	li	a1,511
ffffffffc02044f6:	43d4                	lw	a3,4(a5)
ffffffffc02044f8:	00003517          	auipc	a0,0x3
ffffffffc02044fc:	ac850513          	addi	a0,a0,-1336 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204500:	f8ffb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_enable();
ffffffffc0204504:	caafc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0204508:	bff1                	j	ffffffffc02044e4 <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc020450a:	00003617          	auipc	a2,0x3
ffffffffc020450e:	af660613          	addi	a2,a2,-1290 # ffffffffc0207000 <default_pmm_manager+0xa98>
ffffffffc0204512:	1cb00593          	li	a1,459
ffffffffc0204516:	00003517          	auipc	a0,0x3
ffffffffc020451a:	aaa50513          	addi	a0,a0,-1366 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc020451e:	f71fb0ef          	jal	ra,ffffffffc020048e <__panic>
            exit_mmap(mm);
ffffffffc0204522:	854e                	mv	a0,s3
ffffffffc0204524:	c94ff0ef          	jal	ra,ffffffffc02039b8 <exit_mmap>
            put_pgdir(mm);
ffffffffc0204528:	854e                	mv	a0,s3
ffffffffc020452a:	9cdff0ef          	jal	ra,ffffffffc0203ef6 <put_pgdir>
            mm_destroy(mm);
ffffffffc020452e:	854e                	mv	a0,s3
ffffffffc0204530:	aecff0ef          	jal	ra,ffffffffc020381c <mm_destroy>
ffffffffc0204534:	bf35                	j	ffffffffc0204470 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc0204536:	00003617          	auipc	a2,0x3
ffffffffc020453a:	ada60613          	addi	a2,a2,-1318 # ffffffffc0207010 <default_pmm_manager+0xaa8>
ffffffffc020453e:	1cf00593          	li	a1,463
ffffffffc0204542:	00003517          	auipc	a0,0x3
ffffffffc0204546:	a7e50513          	addi	a0,a0,-1410 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc020454a:	f45fb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_disable();
ffffffffc020454e:	c66fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0204552:	4a05                	li	s4,1
ffffffffc0204554:	bf1d                	j	ffffffffc020448a <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc0204556:	313000ef          	jal	ra,ffffffffc0205068 <wakeup_proc>
ffffffffc020455a:	b789                	j	ffffffffc020449c <do_exit+0x8a>

ffffffffc020455c <do_wait.part.0>:
int do_wait(int pid, int *code_store)
ffffffffc020455c:	715d                	addi	sp,sp,-80
ffffffffc020455e:	f84a                	sd	s2,48(sp)
ffffffffc0204560:	f44e                	sd	s3,40(sp)
        current->wait_state = WT_CHILD;
ffffffffc0204562:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc0204566:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc0204568:	fc26                	sd	s1,56(sp)
ffffffffc020456a:	f052                	sd	s4,32(sp)
ffffffffc020456c:	ec56                	sd	s5,24(sp)
ffffffffc020456e:	e85a                	sd	s6,16(sp)
ffffffffc0204570:	e45e                	sd	s7,8(sp)
ffffffffc0204572:	e486                	sd	ra,72(sp)
ffffffffc0204574:	e0a2                	sd	s0,64(sp)
ffffffffc0204576:	84aa                	mv	s1,a0
ffffffffc0204578:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc020457a:	000a7b97          	auipc	s7,0xa7
ffffffffc020457e:	8beb8b93          	addi	s7,s7,-1858 # ffffffffc02aae38 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204582:	00050b1b          	sext.w	s6,a0
ffffffffc0204586:	fff50a9b          	addiw	s5,a0,-1
ffffffffc020458a:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc020458c:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc020458e:	ccbd                	beqz	s1,ffffffffc020460c <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204590:	0359e863          	bltu	s3,s5,ffffffffc02045c0 <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204594:	45a9                	li	a1,10
ffffffffc0204596:	855a                	mv	a0,s6
ffffffffc0204598:	4bd000ef          	jal	ra,ffffffffc0205254 <hash32>
ffffffffc020459c:	02051793          	slli	a5,a0,0x20
ffffffffc02045a0:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02045a4:	000a3797          	auipc	a5,0xa3
ffffffffc02045a8:	81c78793          	addi	a5,a5,-2020 # ffffffffc02a6dc0 <hash_list>
ffffffffc02045ac:	953e                	add	a0,a0,a5
ffffffffc02045ae:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc02045b0:	a029                	j	ffffffffc02045ba <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc02045b2:	f2c42783          	lw	a5,-212(s0)
ffffffffc02045b6:	02978163          	beq	a5,s1,ffffffffc02045d8 <do_wait.part.0+0x7c>
ffffffffc02045ba:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc02045bc:	fe851be3          	bne	a0,s0,ffffffffc02045b2 <do_wait.part.0+0x56>
    return -E_BAD_PROC;
ffffffffc02045c0:	5579                	li	a0,-2
}
ffffffffc02045c2:	60a6                	ld	ra,72(sp)
ffffffffc02045c4:	6406                	ld	s0,64(sp)
ffffffffc02045c6:	74e2                	ld	s1,56(sp)
ffffffffc02045c8:	7942                	ld	s2,48(sp)
ffffffffc02045ca:	79a2                	ld	s3,40(sp)
ffffffffc02045cc:	7a02                	ld	s4,32(sp)
ffffffffc02045ce:	6ae2                	ld	s5,24(sp)
ffffffffc02045d0:	6b42                	ld	s6,16(sp)
ffffffffc02045d2:	6ba2                	ld	s7,8(sp)
ffffffffc02045d4:	6161                	addi	sp,sp,80
ffffffffc02045d6:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc02045d8:	000bb683          	ld	a3,0(s7)
ffffffffc02045dc:	f4843783          	ld	a5,-184(s0)
ffffffffc02045e0:	fed790e3          	bne	a5,a3,ffffffffc02045c0 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045e4:	f2842703          	lw	a4,-216(s0)
ffffffffc02045e8:	478d                	li	a5,3
ffffffffc02045ea:	0ef70b63          	beq	a4,a5,ffffffffc02046e0 <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc02045ee:	4785                	li	a5,1
ffffffffc02045f0:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc02045f2:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc02045f6:	2f3000ef          	jal	ra,ffffffffc02050e8 <schedule>
        if (current->flags & PF_EXITING)
ffffffffc02045fa:	000bb783          	ld	a5,0(s7)
ffffffffc02045fe:	0b07a783          	lw	a5,176(a5)
ffffffffc0204602:	8b85                	andi	a5,a5,1
ffffffffc0204604:	d7c9                	beqz	a5,ffffffffc020458e <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc0204606:	555d                	li	a0,-9
ffffffffc0204608:	e0bff0ef          	jal	ra,ffffffffc0204412 <do_exit>
        proc = current->cptr;
ffffffffc020460c:	000bb683          	ld	a3,0(s7)
ffffffffc0204610:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc0204612:	d45d                	beqz	s0,ffffffffc02045c0 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204614:	470d                	li	a4,3
ffffffffc0204616:	a021                	j	ffffffffc020461e <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc0204618:	10043403          	ld	s0,256(s0)
ffffffffc020461c:	d869                	beqz	s0,ffffffffc02045ee <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc020461e:	401c                	lw	a5,0(s0)
ffffffffc0204620:	fee79ce3          	bne	a5,a4,ffffffffc0204618 <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc0204624:	000a7797          	auipc	a5,0xa7
ffffffffc0204628:	81c7b783          	ld	a5,-2020(a5) # ffffffffc02aae40 <idleproc>
ffffffffc020462c:	0c878963          	beq	a5,s0,ffffffffc02046fe <do_wait.part.0+0x1a2>
ffffffffc0204630:	000a7797          	auipc	a5,0xa7
ffffffffc0204634:	8187b783          	ld	a5,-2024(a5) # ffffffffc02aae48 <initproc>
ffffffffc0204638:	0cf40363          	beq	s0,a5,ffffffffc02046fe <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc020463c:	000a0663          	beqz	s4,ffffffffc0204648 <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc0204640:	0e842783          	lw	a5,232(s0)
ffffffffc0204644:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8c20>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204648:	100027f3          	csrr	a5,sstatus
ffffffffc020464c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020464e:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204650:	e7c1                	bnez	a5,ffffffffc02046d8 <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc0204652:	6c70                	ld	a2,216(s0)
ffffffffc0204654:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc0204656:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc020465a:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc020465c:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc020465e:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0204660:	6470                	ld	a2,200(s0)
ffffffffc0204662:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0204664:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204666:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc0204668:	c319                	beqz	a4,ffffffffc020466e <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc020466a:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc020466c:	7c7c                	ld	a5,248(s0)
ffffffffc020466e:	c3b5                	beqz	a5,ffffffffc02046d2 <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc0204670:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc0204674:	000a6717          	auipc	a4,0xa6
ffffffffc0204678:	7dc70713          	addi	a4,a4,2012 # ffffffffc02aae50 <nr_process>
ffffffffc020467c:	431c                	lw	a5,0(a4)
ffffffffc020467e:	37fd                	addiw	a5,a5,-1
ffffffffc0204680:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc0204682:	e5a9                	bnez	a1,ffffffffc02046cc <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0204684:	6814                	ld	a3,16(s0)
ffffffffc0204686:	c02007b7          	lui	a5,0xc0200
ffffffffc020468a:	04f6ee63          	bltu	a3,a5,ffffffffc02046e6 <do_wait.part.0+0x18a>
ffffffffc020468e:	000a6797          	auipc	a5,0xa6
ffffffffc0204692:	7a27b783          	ld	a5,1954(a5) # ffffffffc02aae30 <va_pa_offset>
ffffffffc0204696:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc0204698:	82b1                	srli	a3,a3,0xc
ffffffffc020469a:	000a6797          	auipc	a5,0xa6
ffffffffc020469e:	77e7b783          	ld	a5,1918(a5) # ffffffffc02aae18 <npage>
ffffffffc02046a2:	06f6fa63          	bgeu	a3,a5,ffffffffc0204716 <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc02046a6:	00003517          	auipc	a0,0x3
ffffffffc02046aa:	1e253503          	ld	a0,482(a0) # ffffffffc0207888 <nbase>
ffffffffc02046ae:	8e89                	sub	a3,a3,a0
ffffffffc02046b0:	069a                	slli	a3,a3,0x6
ffffffffc02046b2:	000a6517          	auipc	a0,0xa6
ffffffffc02046b6:	76e53503          	ld	a0,1902(a0) # ffffffffc02aae20 <pages>
ffffffffc02046ba:	9536                	add	a0,a0,a3
ffffffffc02046bc:	4589                	li	a1,2
ffffffffc02046be:	82dfd0ef          	jal	ra,ffffffffc0201eea <free_pages>
    kfree(proc);
ffffffffc02046c2:	8522                	mv	a0,s0
ffffffffc02046c4:	ebafd0ef          	jal	ra,ffffffffc0201d7e <kfree>
    return 0;
ffffffffc02046c8:	4501                	li	a0,0
ffffffffc02046ca:	bde5                	j	ffffffffc02045c2 <do_wait.part.0+0x66>
        intr_enable();
ffffffffc02046cc:	ae2fc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02046d0:	bf55                	j	ffffffffc0204684 <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc02046d2:	701c                	ld	a5,32(s0)
ffffffffc02046d4:	fbf8                	sd	a4,240(a5)
ffffffffc02046d6:	bf79                	j	ffffffffc0204674 <do_wait.part.0+0x118>
        intr_disable();
ffffffffc02046d8:	adcfc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc02046dc:	4585                	li	a1,1
ffffffffc02046de:	bf95                	j	ffffffffc0204652 <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc02046e0:	f2840413          	addi	s0,s0,-216
ffffffffc02046e4:	b781                	j	ffffffffc0204624 <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc02046e6:	00002617          	auipc	a2,0x2
ffffffffc02046ea:	f6260613          	addi	a2,a2,-158 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc02046ee:	07700593          	li	a1,119
ffffffffc02046f2:	00002517          	auipc	a0,0x2
ffffffffc02046f6:	ed650513          	addi	a0,a0,-298 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc02046fa:	d95fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc02046fe:	00003617          	auipc	a2,0x3
ffffffffc0204702:	94260613          	addi	a2,a2,-1726 # ffffffffc0207040 <default_pmm_manager+0xad8>
ffffffffc0204706:	32a00593          	li	a1,810
ffffffffc020470a:	00003517          	auipc	a0,0x3
ffffffffc020470e:	8b650513          	addi	a0,a0,-1866 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204712:	d7dfb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0204716:	00002617          	auipc	a2,0x2
ffffffffc020471a:	f5a60613          	addi	a2,a2,-166 # ffffffffc0206670 <default_pmm_manager+0x108>
ffffffffc020471e:	06900593          	li	a1,105
ffffffffc0204722:	00002517          	auipc	a0,0x2
ffffffffc0204726:	ea650513          	addi	a0,a0,-346 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc020472a:	d65fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020472e <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc020472e:	1141                	addi	sp,sp,-16
ffffffffc0204730:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc0204732:	ff8fd0ef          	jal	ra,ffffffffc0201f2a <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc0204736:	d94fd0ef          	jal	ra,ffffffffc0201cca <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc020473a:	4601                	li	a2,0
ffffffffc020473c:	4581                	li	a1,0
ffffffffc020473e:	fffff517          	auipc	a0,0xfffff
ffffffffc0204742:	73a50513          	addi	a0,a0,1850 # ffffffffc0203e78 <user_main>
ffffffffc0204746:	c7dff0ef          	jal	ra,ffffffffc02043c2 <kernel_thread>
    if (pid <= 0)
ffffffffc020474a:	00a04563          	bgtz	a0,ffffffffc0204754 <init_main+0x26>
ffffffffc020474e:	a071                	j	ffffffffc02047da <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
ffffffffc0204750:	199000ef          	jal	ra,ffffffffc02050e8 <schedule>
    if (code_store != NULL)
ffffffffc0204754:	4581                	li	a1,0
ffffffffc0204756:	4501                	li	a0,0
ffffffffc0204758:	e05ff0ef          	jal	ra,ffffffffc020455c <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc020475c:	d975                	beqz	a0,ffffffffc0204750 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc020475e:	00003517          	auipc	a0,0x3
ffffffffc0204762:	92250513          	addi	a0,a0,-1758 # ffffffffc0207080 <default_pmm_manager+0xb18>
ffffffffc0204766:	a2ffb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc020476a:	000a6797          	auipc	a5,0xa6
ffffffffc020476e:	6de7b783          	ld	a5,1758(a5) # ffffffffc02aae48 <initproc>
ffffffffc0204772:	7bf8                	ld	a4,240(a5)
ffffffffc0204774:	e339                	bnez	a4,ffffffffc02047ba <init_main+0x8c>
ffffffffc0204776:	7ff8                	ld	a4,248(a5)
ffffffffc0204778:	e329                	bnez	a4,ffffffffc02047ba <init_main+0x8c>
ffffffffc020477a:	1007b703          	ld	a4,256(a5)
ffffffffc020477e:	ef15                	bnez	a4,ffffffffc02047ba <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0204780:	000a6697          	auipc	a3,0xa6
ffffffffc0204784:	6d06a683          	lw	a3,1744(a3) # ffffffffc02aae50 <nr_process>
ffffffffc0204788:	4709                	li	a4,2
ffffffffc020478a:	0ae69463          	bne	a3,a4,ffffffffc0204832 <init_main+0x104>
    return listelm->next;
ffffffffc020478e:	000a6697          	auipc	a3,0xa6
ffffffffc0204792:	63268693          	addi	a3,a3,1586 # ffffffffc02aadc0 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204796:	6698                	ld	a4,8(a3)
ffffffffc0204798:	0c878793          	addi	a5,a5,200
ffffffffc020479c:	06f71b63          	bne	a4,a5,ffffffffc0204812 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc02047a0:	629c                	ld	a5,0(a3)
ffffffffc02047a2:	04f71863          	bne	a4,a5,ffffffffc02047f2 <init_main+0xc4>

    cprintf("init check memory pass.\n");
ffffffffc02047a6:	00003517          	auipc	a0,0x3
ffffffffc02047aa:	9c250513          	addi	a0,a0,-1598 # ffffffffc0207168 <default_pmm_manager+0xc00>
ffffffffc02047ae:	9e7fb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
}
ffffffffc02047b2:	60a2                	ld	ra,8(sp)
ffffffffc02047b4:	4501                	li	a0,0
ffffffffc02047b6:	0141                	addi	sp,sp,16
ffffffffc02047b8:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc02047ba:	00003697          	auipc	a3,0x3
ffffffffc02047be:	8ee68693          	addi	a3,a3,-1810 # ffffffffc02070a8 <default_pmm_manager+0xb40>
ffffffffc02047c2:	00002617          	auipc	a2,0x2
ffffffffc02047c6:	9f660613          	addi	a2,a2,-1546 # ffffffffc02061b8 <commands+0x828>
ffffffffc02047ca:	39800593          	li	a1,920
ffffffffc02047ce:	00002517          	auipc	a0,0x2
ffffffffc02047d2:	7f250513          	addi	a0,a0,2034 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc02047d6:	cb9fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("create user_main failed.\n");
ffffffffc02047da:	00003617          	auipc	a2,0x3
ffffffffc02047de:	88660613          	addi	a2,a2,-1914 # ffffffffc0207060 <default_pmm_manager+0xaf8>
ffffffffc02047e2:	38f00593          	li	a1,911
ffffffffc02047e6:	00002517          	auipc	a0,0x2
ffffffffc02047ea:	7da50513          	addi	a0,a0,2010 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc02047ee:	ca1fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc02047f2:	00003697          	auipc	a3,0x3
ffffffffc02047f6:	94668693          	addi	a3,a3,-1722 # ffffffffc0207138 <default_pmm_manager+0xbd0>
ffffffffc02047fa:	00002617          	auipc	a2,0x2
ffffffffc02047fe:	9be60613          	addi	a2,a2,-1602 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204802:	39b00593          	li	a1,923
ffffffffc0204806:	00002517          	auipc	a0,0x2
ffffffffc020480a:	7ba50513          	addi	a0,a0,1978 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc020480e:	c81fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204812:	00003697          	auipc	a3,0x3
ffffffffc0204816:	8f668693          	addi	a3,a3,-1802 # ffffffffc0207108 <default_pmm_manager+0xba0>
ffffffffc020481a:	00002617          	auipc	a2,0x2
ffffffffc020481e:	99e60613          	addi	a2,a2,-1634 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204822:	39a00593          	li	a1,922
ffffffffc0204826:	00002517          	auipc	a0,0x2
ffffffffc020482a:	79a50513          	addi	a0,a0,1946 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc020482e:	c61fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_process == 2);
ffffffffc0204832:	00003697          	auipc	a3,0x3
ffffffffc0204836:	8c668693          	addi	a3,a3,-1850 # ffffffffc02070f8 <default_pmm_manager+0xb90>
ffffffffc020483a:	00002617          	auipc	a2,0x2
ffffffffc020483e:	97e60613          	addi	a2,a2,-1666 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204842:	39900593          	li	a1,921
ffffffffc0204846:	00002517          	auipc	a0,0x2
ffffffffc020484a:	77a50513          	addi	a0,a0,1914 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc020484e:	c41fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204852 <do_execve>:
{
ffffffffc0204852:	7171                	addi	sp,sp,-176
ffffffffc0204854:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0204856:	000a6d97          	auipc	s11,0xa6
ffffffffc020485a:	5e2d8d93          	addi	s11,s11,1506 # ffffffffc02aae38 <current>
ffffffffc020485e:	000db783          	ld	a5,0(s11)
{
ffffffffc0204862:	e94a                	sd	s2,144(sp)
ffffffffc0204864:	f122                	sd	s0,160(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0204866:	0287b903          	ld	s2,40(a5)
{
ffffffffc020486a:	ed26                	sd	s1,152(sp)
ffffffffc020486c:	f8da                	sd	s6,112(sp)
ffffffffc020486e:	84aa                	mv	s1,a0
ffffffffc0204870:	8b32                	mv	s6,a2
ffffffffc0204872:	842e                	mv	s0,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc0204874:	862e                	mv	a2,a1
ffffffffc0204876:	4681                	li	a3,0
ffffffffc0204878:	85aa                	mv	a1,a0
ffffffffc020487a:	854a                	mv	a0,s2
{
ffffffffc020487c:	f506                	sd	ra,168(sp)
ffffffffc020487e:	e54e                	sd	s3,136(sp)
ffffffffc0204880:	e152                	sd	s4,128(sp)
ffffffffc0204882:	fcd6                	sd	s5,120(sp)
ffffffffc0204884:	f4de                	sd	s7,104(sp)
ffffffffc0204886:	f0e2                	sd	s8,96(sp)
ffffffffc0204888:	ece6                	sd	s9,88(sp)
ffffffffc020488a:	e8ea                	sd	s10,80(sp)
ffffffffc020488c:	f05a                	sd	s6,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc020488e:	cc4ff0ef          	jal	ra,ffffffffc0203d52 <user_mem_check>
ffffffffc0204892:	40050c63          	beqz	a0,ffffffffc0204caa <do_execve+0x458>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0204896:	4641                	li	a2,16
ffffffffc0204898:	4581                	li	a1,0
ffffffffc020489a:	1808                	addi	a0,sp,48
ffffffffc020489c:	65f000ef          	jal	ra,ffffffffc02056fa <memset>
    memcpy(local_name, name, len);
ffffffffc02048a0:	47bd                	li	a5,15
ffffffffc02048a2:	8622                	mv	a2,s0
ffffffffc02048a4:	1e87e263          	bltu	a5,s0,ffffffffc0204a88 <do_execve+0x236>
ffffffffc02048a8:	85a6                	mv	a1,s1
ffffffffc02048aa:	1808                	addi	a0,sp,48
ffffffffc02048ac:	661000ef          	jal	ra,ffffffffc020570c <memcpy>
    if (mm != NULL)
ffffffffc02048b0:	1e090363          	beqz	s2,ffffffffc0204a96 <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc02048b4:	00002517          	auipc	a0,0x2
ffffffffc02048b8:	4d450513          	addi	a0,a0,1236 # ffffffffc0206d88 <default_pmm_manager+0x820>
ffffffffc02048bc:	911fb0ef          	jal	ra,ffffffffc02001cc <cputs>
ffffffffc02048c0:	000a6797          	auipc	a5,0xa6
ffffffffc02048c4:	5487b783          	ld	a5,1352(a5) # ffffffffc02aae08 <boot_pgdir_pa>
ffffffffc02048c8:	577d                	li	a4,-1
ffffffffc02048ca:	177e                	slli	a4,a4,0x3f
ffffffffc02048cc:	83b1                	srli	a5,a5,0xc
ffffffffc02048ce:	8fd9                	or	a5,a5,a4
ffffffffc02048d0:	18079073          	csrw	satp,a5
ffffffffc02048d4:	03092783          	lw	a5,48(s2) # ffffffff80000030 <_binary_obj___user_exit_out_size+0xffffffff7fff4e98>
ffffffffc02048d8:	fff7871b          	addiw	a4,a5,-1
ffffffffc02048dc:	02e92823          	sw	a4,48(s2)
        if (mm_count_dec(mm) == 0)
ffffffffc02048e0:	2c070463          	beqz	a4,ffffffffc0204ba8 <do_execve+0x356>
        current->mm = NULL;
ffffffffc02048e4:	000db783          	ld	a5,0(s11)
ffffffffc02048e8:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc02048ec:	df1fe0ef          	jal	ra,ffffffffc02036dc <mm_create>
ffffffffc02048f0:	842a                	mv	s0,a0
ffffffffc02048f2:	1c050d63          	beqz	a0,ffffffffc0204acc <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc02048f6:	4505                	li	a0,1
ffffffffc02048f8:	db4fd0ef          	jal	ra,ffffffffc0201eac <alloc_pages>
ffffffffc02048fc:	3a050b63          	beqz	a0,ffffffffc0204cb2 <do_execve+0x460>
    return page - pages + nbase;
ffffffffc0204900:	000a6c97          	auipc	s9,0xa6
ffffffffc0204904:	520c8c93          	addi	s9,s9,1312 # ffffffffc02aae20 <pages>
ffffffffc0204908:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc020490c:	000a6c17          	auipc	s8,0xa6
ffffffffc0204910:	50cc0c13          	addi	s8,s8,1292 # ffffffffc02aae18 <npage>
    return page - pages + nbase;
ffffffffc0204914:	00003717          	auipc	a4,0x3
ffffffffc0204918:	f7473703          	ld	a4,-140(a4) # ffffffffc0207888 <nbase>
ffffffffc020491c:	40d506b3          	sub	a3,a0,a3
ffffffffc0204920:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204922:	5a7d                	li	s4,-1
ffffffffc0204924:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc0204928:	96ba                	add	a3,a3,a4
ffffffffc020492a:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc020492c:	00ca5713          	srli	a4,s4,0xc
ffffffffc0204930:	ec3a                	sd	a4,24(sp)
ffffffffc0204932:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0204934:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204936:	38f77263          	bgeu	a4,a5,ffffffffc0204cba <do_execve+0x468>
ffffffffc020493a:	000a6a97          	auipc	s5,0xa6
ffffffffc020493e:	4f6a8a93          	addi	s5,s5,1270 # ffffffffc02aae30 <va_pa_offset>
ffffffffc0204942:	000ab483          	ld	s1,0(s5)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc0204946:	6605                	lui	a2,0x1
ffffffffc0204948:	000a6597          	auipc	a1,0xa6
ffffffffc020494c:	4c85b583          	ld	a1,1224(a1) # ffffffffc02aae10 <boot_pgdir_va>
ffffffffc0204950:	94b6                	add	s1,s1,a3
ffffffffc0204952:	8526                	mv	a0,s1
ffffffffc0204954:	5b9000ef          	jal	ra,ffffffffc020570c <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc0204958:	7782                	ld	a5,32(sp)
ffffffffc020495a:	4398                	lw	a4,0(a5)
ffffffffc020495c:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc0204960:	ec04                	sd	s1,24(s0)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc0204962:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_exit_out_size+0x464b93e7>
ffffffffc0204966:	14f71963          	bne	a4,a5,ffffffffc0204ab8 <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020496a:	7682                	ld	a3,32(sp)
    struct Page *page = NULL;
ffffffffc020496c:	4b81                	li	s7,0
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020496e:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204972:	0206b903          	ld	s2,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204976:	00371793          	slli	a5,a4,0x3
ffffffffc020497a:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc020497c:	9936                	add	s2,s2,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020497e:	078e                	slli	a5,a5,0x3
ffffffffc0204980:	97ca                	add	a5,a5,s2
ffffffffc0204982:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc0204984:	00f97c63          	bgeu	s2,a5,ffffffffc020499c <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc0204988:	00092783          	lw	a5,0(s2)
ffffffffc020498c:	4705                	li	a4,1
ffffffffc020498e:	14e78163          	beq	a5,a4,ffffffffc0204ad0 <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc0204992:	77a2                	ld	a5,40(sp)
ffffffffc0204994:	03890913          	addi	s2,s2,56
ffffffffc0204998:	fef968e3          	bltu	s2,a5,ffffffffc0204988 <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc020499c:	4701                	li	a4,0
ffffffffc020499e:	46ad                	li	a3,11
ffffffffc02049a0:	00100637          	lui	a2,0x100
ffffffffc02049a4:	7ff005b7          	lui	a1,0x7ff00
ffffffffc02049a8:	8522                	mv	a0,s0
ffffffffc02049aa:	ec5fe0ef          	jal	ra,ffffffffc020386e <mm_map>
ffffffffc02049ae:	89aa                	mv	s3,a0
ffffffffc02049b0:	1e051263          	bnez	a0,ffffffffc0204b94 <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc02049b4:	6c08                	ld	a0,24(s0)
ffffffffc02049b6:	467d                	li	a2,31
ffffffffc02049b8:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc02049bc:	c3bfe0ef          	jal	ra,ffffffffc02035f6 <pgdir_alloc_page>
ffffffffc02049c0:	3a050163          	beqz	a0,ffffffffc0204d62 <do_execve+0x510>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc02049c4:	6c08                	ld	a0,24(s0)
ffffffffc02049c6:	467d                	li	a2,31
ffffffffc02049c8:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02049cc:	c2bfe0ef          	jal	ra,ffffffffc02035f6 <pgdir_alloc_page>
ffffffffc02049d0:	36050963          	beqz	a0,ffffffffc0204d42 <do_execve+0x4f0>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc02049d4:	6c08                	ld	a0,24(s0)
ffffffffc02049d6:	467d                	li	a2,31
ffffffffc02049d8:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02049dc:	c1bfe0ef          	jal	ra,ffffffffc02035f6 <pgdir_alloc_page>
ffffffffc02049e0:	34050163          	beqz	a0,ffffffffc0204d22 <do_execve+0x4d0>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc02049e4:	6c08                	ld	a0,24(s0)
ffffffffc02049e6:	467d                	li	a2,31
ffffffffc02049e8:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02049ec:	c0bfe0ef          	jal	ra,ffffffffc02035f6 <pgdir_alloc_page>
ffffffffc02049f0:	30050963          	beqz	a0,ffffffffc0204d02 <do_execve+0x4b0>
    mm->mm_count += 1;
ffffffffc02049f4:	581c                	lw	a5,48(s0)
    current->mm = mm;
ffffffffc02049f6:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc02049fa:	6c14                	ld	a3,24(s0)
ffffffffc02049fc:	2785                	addiw	a5,a5,1
ffffffffc02049fe:	d81c                	sw	a5,48(s0)
    current->mm = mm;
ffffffffc0204a00:	f600                	sd	s0,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204a02:	c02007b7          	lui	a5,0xc0200
ffffffffc0204a06:	2ef6e263          	bltu	a3,a5,ffffffffc0204cea <do_execve+0x498>
ffffffffc0204a0a:	000ab783          	ld	a5,0(s5)
ffffffffc0204a0e:	577d                	li	a4,-1
ffffffffc0204a10:	177e                	slli	a4,a4,0x3f
ffffffffc0204a12:	8e9d                	sub	a3,a3,a5
ffffffffc0204a14:	00c6d793          	srli	a5,a3,0xc
ffffffffc0204a18:	f654                	sd	a3,168(a2)
ffffffffc0204a1a:	8fd9                	or	a5,a5,a4
ffffffffc0204a1c:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc0204a20:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0204a22:	4581                	li	a1,0
ffffffffc0204a24:	12000613          	li	a2,288
ffffffffc0204a28:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc0204a2a:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0204a2e:	4cd000ef          	jal	ra,ffffffffc02056fa <memset>
    tf->epc = elf->e_entry;
ffffffffc0204a32:	7782                	ld	a5,32(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a34:	000db903          	ld	s2,0(s11)
    tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;
ffffffffc0204a38:	edd4f493          	andi	s1,s1,-291
    tf->epc = elf->e_entry;
ffffffffc0204a3c:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;
ffffffffc0204a3e:	4785                	li	a5,1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a40:	0b490913          	addi	s2,s2,180
    tf->gpr.sp = USTACKTOP;
ffffffffc0204a44:	07fe                	slli	a5,a5,0x1f
    tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;
ffffffffc0204a46:	0204e493          	ori	s1,s1,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a4a:	4641                	li	a2,16
ffffffffc0204a4c:	4581                	li	a1,0
    tf->gpr.sp = USTACKTOP;
ffffffffc0204a4e:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc0204a50:	10e43423          	sd	a4,264(s0)
    tf->status = (sstatus & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE;
ffffffffc0204a54:	10943023          	sd	s1,256(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a58:	854a                	mv	a0,s2
ffffffffc0204a5a:	4a1000ef          	jal	ra,ffffffffc02056fa <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204a5e:	463d                	li	a2,15
ffffffffc0204a60:	180c                	addi	a1,sp,48
ffffffffc0204a62:	854a                	mv	a0,s2
ffffffffc0204a64:	4a9000ef          	jal	ra,ffffffffc020570c <memcpy>
}
ffffffffc0204a68:	70aa                	ld	ra,168(sp)
ffffffffc0204a6a:	740a                	ld	s0,160(sp)
ffffffffc0204a6c:	64ea                	ld	s1,152(sp)
ffffffffc0204a6e:	694a                	ld	s2,144(sp)
ffffffffc0204a70:	6a0a                	ld	s4,128(sp)
ffffffffc0204a72:	7ae6                	ld	s5,120(sp)
ffffffffc0204a74:	7b46                	ld	s6,112(sp)
ffffffffc0204a76:	7ba6                	ld	s7,104(sp)
ffffffffc0204a78:	7c06                	ld	s8,96(sp)
ffffffffc0204a7a:	6ce6                	ld	s9,88(sp)
ffffffffc0204a7c:	6d46                	ld	s10,80(sp)
ffffffffc0204a7e:	6da6                	ld	s11,72(sp)
ffffffffc0204a80:	854e                	mv	a0,s3
ffffffffc0204a82:	69aa                	ld	s3,136(sp)
ffffffffc0204a84:	614d                	addi	sp,sp,176
ffffffffc0204a86:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204a88:	463d                	li	a2,15
ffffffffc0204a8a:	85a6                	mv	a1,s1
ffffffffc0204a8c:	1808                	addi	a0,sp,48
ffffffffc0204a8e:	47f000ef          	jal	ra,ffffffffc020570c <memcpy>
    if (mm != NULL)
ffffffffc0204a92:	e20911e3          	bnez	s2,ffffffffc02048b4 <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204a96:	000db783          	ld	a5,0(s11)
ffffffffc0204a9a:	779c                	ld	a5,40(a5)
ffffffffc0204a9c:	e40788e3          	beqz	a5,ffffffffc02048ec <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0204aa0:	00002617          	auipc	a2,0x2
ffffffffc0204aa4:	6e860613          	addi	a2,a2,1768 # ffffffffc0207188 <default_pmm_manager+0xc20>
ffffffffc0204aa8:	20b00593          	li	a1,523
ffffffffc0204aac:	00002517          	auipc	a0,0x2
ffffffffc0204ab0:	51450513          	addi	a0,a0,1300 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204ab4:	9dbfb0ef          	jal	ra,ffffffffc020048e <__panic>
    put_pgdir(mm);
ffffffffc0204ab8:	8522                	mv	a0,s0
ffffffffc0204aba:	c3cff0ef          	jal	ra,ffffffffc0203ef6 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204abe:	8522                	mv	a0,s0
ffffffffc0204ac0:	d5dfe0ef          	jal	ra,ffffffffc020381c <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0204ac4:	59e1                	li	s3,-8
    do_exit(ret);
ffffffffc0204ac6:	854e                	mv	a0,s3
ffffffffc0204ac8:	94bff0ef          	jal	ra,ffffffffc0204412 <do_exit>
    int ret = -E_NO_MEM;
ffffffffc0204acc:	59f1                	li	s3,-4
ffffffffc0204ace:	bfe5                	j	ffffffffc0204ac6 <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc0204ad0:	02893603          	ld	a2,40(s2)
ffffffffc0204ad4:	02093783          	ld	a5,32(s2)
ffffffffc0204ad8:	1cf66f63          	bltu	a2,a5,ffffffffc0204cb6 <do_execve+0x464>
        if (ph->p_flags & ELF_PF_X)
ffffffffc0204adc:	00492783          	lw	a5,4(s2)
ffffffffc0204ae0:	0017f693          	andi	a3,a5,1
ffffffffc0204ae4:	c291                	beqz	a3,ffffffffc0204ae8 <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204ae6:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204ae8:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204aec:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204aee:	e779                	bnez	a4,ffffffffc0204bbc <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0204af0:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204af2:	c781                	beqz	a5,ffffffffc0204afa <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc0204af4:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204af8:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204afa:	0026f793          	andi	a5,a3,2
ffffffffc0204afe:	e3f1                	bnez	a5,ffffffffc0204bc2 <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc0204b00:	0046f793          	andi	a5,a3,4
ffffffffc0204b04:	c399                	beqz	a5,ffffffffc0204b0a <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc0204b06:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc0204b0a:	01093583          	ld	a1,16(s2)
ffffffffc0204b0e:	4701                	li	a4,0
ffffffffc0204b10:	8522                	mv	a0,s0
ffffffffc0204b12:	d5dfe0ef          	jal	ra,ffffffffc020386e <mm_map>
ffffffffc0204b16:	89aa                	mv	s3,a0
ffffffffc0204b18:	ed35                	bnez	a0,ffffffffc0204b94 <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204b1a:	01093b03          	ld	s6,16(s2)
ffffffffc0204b1e:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204b20:	02093983          	ld	s3,32(s2)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204b24:	00893483          	ld	s1,8(s2)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204b28:	00fb7a33          	and	s4,s6,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204b2c:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204b2e:	99da                	add	s3,s3,s6
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204b30:	94be                	add	s1,s1,a5
        while (start < end)
ffffffffc0204b32:	053b6963          	bltu	s6,s3,ffffffffc0204b84 <do_execve+0x332>
ffffffffc0204b36:	aaa5                	j	ffffffffc0204cae <do_execve+0x45c>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204b38:	6785                	lui	a5,0x1
ffffffffc0204b3a:	414b0533          	sub	a0,s6,s4
ffffffffc0204b3e:	9a3e                	add	s4,s4,a5
ffffffffc0204b40:	416a0633          	sub	a2,s4,s6
            if (end < la)
ffffffffc0204b44:	0149f463          	bgeu	s3,s4,ffffffffc0204b4c <do_execve+0x2fa>
                size -= la - end;
ffffffffc0204b48:	41698633          	sub	a2,s3,s6
    return page - pages + nbase;
ffffffffc0204b4c:	000cb683          	ld	a3,0(s9)
ffffffffc0204b50:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b52:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204b56:	40db86b3          	sub	a3,s7,a3
ffffffffc0204b5a:	8699                	srai	a3,a3,0x6
ffffffffc0204b5c:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b5e:	67e2                	ld	a5,24(sp)
ffffffffc0204b60:	00f6f8b3          	and	a7,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b64:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b66:	14b8fa63          	bgeu	a7,a1,ffffffffc0204cba <do_execve+0x468>
ffffffffc0204b6a:	000ab883          	ld	a7,0(s5)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b6e:	85a6                	mv	a1,s1
            start += size, from += size;
ffffffffc0204b70:	9b32                	add	s6,s6,a2
ffffffffc0204b72:	96c6                	add	a3,a3,a7
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b74:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204b76:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b78:	395000ef          	jal	ra,ffffffffc020570c <memcpy>
            start += size, from += size;
ffffffffc0204b7c:	6622                	ld	a2,8(sp)
ffffffffc0204b7e:	94b2                	add	s1,s1,a2
        while (start < end)
ffffffffc0204b80:	053b7363          	bgeu	s6,s3,ffffffffc0204bc6 <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204b84:	6c08                	ld	a0,24(s0)
ffffffffc0204b86:	866a                	mv	a2,s10
ffffffffc0204b88:	85d2                	mv	a1,s4
ffffffffc0204b8a:	a6dfe0ef          	jal	ra,ffffffffc02035f6 <pgdir_alloc_page>
ffffffffc0204b8e:	8baa                	mv	s7,a0
ffffffffc0204b90:	f545                	bnez	a0,ffffffffc0204b38 <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204b92:	59f1                	li	s3,-4
    exit_mmap(mm);
ffffffffc0204b94:	8522                	mv	a0,s0
ffffffffc0204b96:	e23fe0ef          	jal	ra,ffffffffc02039b8 <exit_mmap>
    put_pgdir(mm);
ffffffffc0204b9a:	8522                	mv	a0,s0
ffffffffc0204b9c:	b5aff0ef          	jal	ra,ffffffffc0203ef6 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204ba0:	8522                	mv	a0,s0
ffffffffc0204ba2:	c7bfe0ef          	jal	ra,ffffffffc020381c <mm_destroy>
    return ret;
ffffffffc0204ba6:	b705                	j	ffffffffc0204ac6 <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204ba8:	854a                	mv	a0,s2
ffffffffc0204baa:	e0ffe0ef          	jal	ra,ffffffffc02039b8 <exit_mmap>
            put_pgdir(mm);
ffffffffc0204bae:	854a                	mv	a0,s2
ffffffffc0204bb0:	b46ff0ef          	jal	ra,ffffffffc0203ef6 <put_pgdir>
            mm_destroy(mm);
ffffffffc0204bb4:	854a                	mv	a0,s2
ffffffffc0204bb6:	c67fe0ef          	jal	ra,ffffffffc020381c <mm_destroy>
ffffffffc0204bba:	b32d                	j	ffffffffc02048e4 <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204bbc:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204bc0:	fb95                	bnez	a5,ffffffffc0204af4 <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204bc2:	4d5d                	li	s10,23
ffffffffc0204bc4:	bf35                	j	ffffffffc0204b00 <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204bc6:	01093483          	ld	s1,16(s2)
ffffffffc0204bca:	02893683          	ld	a3,40(s2)
ffffffffc0204bce:	94b6                	add	s1,s1,a3
        if (start < la)
ffffffffc0204bd0:	074b7f63          	bgeu	s6,s4,ffffffffc0204c4e <do_execve+0x3fc>
            if (start == end)
ffffffffc0204bd4:	db648fe3          	beq	s1,s6,ffffffffc0204992 <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204bd8:	6785                	lui	a5,0x1
ffffffffc0204bda:	00fb0533          	add	a0,s6,a5
ffffffffc0204bde:	41450533          	sub	a0,a0,s4
                size -= la - end;
ffffffffc0204be2:	416489b3          	sub	s3,s1,s6
            if (end < la)
ffffffffc0204be6:	0b44ff63          	bgeu	s1,s4,ffffffffc0204ca4 <do_execve+0x452>
            if (page == NULL)
ffffffffc0204bea:	0e0b8463          	beqz	s7,ffffffffc0204cd2 <do_execve+0x480>
    return page - pages + nbase;
ffffffffc0204bee:	000cb683          	ld	a3,0(s9)
ffffffffc0204bf2:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204bf4:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204bf8:	40db86b3          	sub	a3,s7,a3
ffffffffc0204bfc:	8699                	srai	a3,a3,0x6
ffffffffc0204bfe:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204c00:	67e2                	ld	a5,24(sp)
ffffffffc0204c02:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204c06:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204c08:	0ac5f963          	bgeu	a1,a2,ffffffffc0204cba <do_execve+0x468>
ffffffffc0204c0c:	000ab883          	ld	a7,0(s5)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c10:	864e                	mv	a2,s3
ffffffffc0204c12:	4581                	li	a1,0
ffffffffc0204c14:	96c6                	add	a3,a3,a7
ffffffffc0204c16:	9536                	add	a0,a0,a3
ffffffffc0204c18:	2e3000ef          	jal	ra,ffffffffc02056fa <memset>
            start += size;
ffffffffc0204c1c:	01698733          	add	a4,s3,s6
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204c20:	0344f463          	bgeu	s1,s4,ffffffffc0204c48 <do_execve+0x3f6>
ffffffffc0204c24:	d6e487e3          	beq	s1,a4,ffffffffc0204992 <do_execve+0x140>
ffffffffc0204c28:	00002697          	auipc	a3,0x2
ffffffffc0204c2c:	5b868693          	addi	a3,a3,1464 # ffffffffc02071e0 <default_pmm_manager+0xc78>
ffffffffc0204c30:	00001617          	auipc	a2,0x1
ffffffffc0204c34:	58860613          	addi	a2,a2,1416 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204c38:	27b00593          	li	a1,635
ffffffffc0204c3c:	00002517          	auipc	a0,0x2
ffffffffc0204c40:	38450513          	addi	a0,a0,900 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204c44:	84bfb0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0204c48:	ff4710e3          	bne	a4,s4,ffffffffc0204c28 <do_execve+0x3d6>
ffffffffc0204c4c:	8b52                	mv	s6,s4
        while (start < end)
ffffffffc0204c4e:	d49b72e3          	bgeu	s6,s1,ffffffffc0204992 <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204c52:	6c08                	ld	a0,24(s0)
ffffffffc0204c54:	866a                	mv	a2,s10
ffffffffc0204c56:	85d2                	mv	a1,s4
ffffffffc0204c58:	99ffe0ef          	jal	ra,ffffffffc02035f6 <pgdir_alloc_page>
ffffffffc0204c5c:	8baa                	mv	s7,a0
ffffffffc0204c5e:	d915                	beqz	a0,ffffffffc0204b92 <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204c60:	6785                	lui	a5,0x1
ffffffffc0204c62:	414b0533          	sub	a0,s6,s4
ffffffffc0204c66:	9a3e                	add	s4,s4,a5
ffffffffc0204c68:	416a0633          	sub	a2,s4,s6
            if (end < la)
ffffffffc0204c6c:	0144f463          	bgeu	s1,s4,ffffffffc0204c74 <do_execve+0x422>
                size -= la - end;
ffffffffc0204c70:	41648633          	sub	a2,s1,s6
    return page - pages + nbase;
ffffffffc0204c74:	000cb683          	ld	a3,0(s9)
ffffffffc0204c78:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204c7a:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204c7e:	40db86b3          	sub	a3,s7,a3
ffffffffc0204c82:	8699                	srai	a3,a3,0x6
ffffffffc0204c84:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204c86:	67e2                	ld	a5,24(sp)
ffffffffc0204c88:	00f6f8b3          	and	a7,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204c8c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204c8e:	02b8f663          	bgeu	a7,a1,ffffffffc0204cba <do_execve+0x468>
ffffffffc0204c92:	000ab883          	ld	a7,0(s5)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c96:	4581                	li	a1,0
            start += size;
ffffffffc0204c98:	9b32                	add	s6,s6,a2
ffffffffc0204c9a:	96c6                	add	a3,a3,a7
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c9c:	9536                	add	a0,a0,a3
ffffffffc0204c9e:	25d000ef          	jal	ra,ffffffffc02056fa <memset>
ffffffffc0204ca2:	b775                	j	ffffffffc0204c4e <do_execve+0x3fc>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204ca4:	416a09b3          	sub	s3,s4,s6
ffffffffc0204ca8:	b789                	j	ffffffffc0204bea <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204caa:	59f5                	li	s3,-3
ffffffffc0204cac:	bb75                	j	ffffffffc0204a68 <do_execve+0x216>
        while (start < end)
ffffffffc0204cae:	84da                	mv	s1,s6
ffffffffc0204cb0:	bf29                	j	ffffffffc0204bca <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204cb2:	59f1                	li	s3,-4
ffffffffc0204cb4:	b5f5                	j	ffffffffc0204ba0 <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204cb6:	59e1                	li	s3,-8
ffffffffc0204cb8:	bdf1                	j	ffffffffc0204b94 <do_execve+0x342>
ffffffffc0204cba:	00002617          	auipc	a2,0x2
ffffffffc0204cbe:	8e660613          	addi	a2,a2,-1818 # ffffffffc02065a0 <default_pmm_manager+0x38>
ffffffffc0204cc2:	07100593          	li	a1,113
ffffffffc0204cc6:	00002517          	auipc	a0,0x2
ffffffffc0204cca:	90250513          	addi	a0,a0,-1790 # ffffffffc02065c8 <default_pmm_manager+0x60>
ffffffffc0204cce:	fc0fb0ef          	jal	ra,ffffffffc020048e <__panic>
                panic("load_icode: page is NULL when zeroing BSS tail");
ffffffffc0204cd2:	00002617          	auipc	a2,0x2
ffffffffc0204cd6:	4de60613          	addi	a2,a2,1246 # ffffffffc02071b0 <default_pmm_manager+0xc48>
ffffffffc0204cda:	27700593          	li	a1,631
ffffffffc0204cde:	00002517          	auipc	a0,0x2
ffffffffc0204ce2:	2e250513          	addi	a0,a0,738 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204ce6:	fa8fb0ef          	jal	ra,ffffffffc020048e <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204cea:	00002617          	auipc	a2,0x2
ffffffffc0204cee:	95e60613          	addi	a2,a2,-1698 # ffffffffc0206648 <default_pmm_manager+0xe0>
ffffffffc0204cf2:	29a00593          	li	a1,666
ffffffffc0204cf6:	00002517          	auipc	a0,0x2
ffffffffc0204cfa:	2ca50513          	addi	a0,a0,714 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204cfe:	f90fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204d02:	00002697          	auipc	a3,0x2
ffffffffc0204d06:	5f668693          	addi	a3,a3,1526 # ffffffffc02072f8 <default_pmm_manager+0xd90>
ffffffffc0204d0a:	00001617          	auipc	a2,0x1
ffffffffc0204d0e:	4ae60613          	addi	a2,a2,1198 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204d12:	29500593          	li	a1,661
ffffffffc0204d16:	00002517          	auipc	a0,0x2
ffffffffc0204d1a:	2aa50513          	addi	a0,a0,682 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204d1e:	f70fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204d22:	00002697          	auipc	a3,0x2
ffffffffc0204d26:	58e68693          	addi	a3,a3,1422 # ffffffffc02072b0 <default_pmm_manager+0xd48>
ffffffffc0204d2a:	00001617          	auipc	a2,0x1
ffffffffc0204d2e:	48e60613          	addi	a2,a2,1166 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204d32:	29400593          	li	a1,660
ffffffffc0204d36:	00002517          	auipc	a0,0x2
ffffffffc0204d3a:	28a50513          	addi	a0,a0,650 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204d3e:	f50fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204d42:	00002697          	auipc	a3,0x2
ffffffffc0204d46:	52668693          	addi	a3,a3,1318 # ffffffffc0207268 <default_pmm_manager+0xd00>
ffffffffc0204d4a:	00001617          	auipc	a2,0x1
ffffffffc0204d4e:	46e60613          	addi	a2,a2,1134 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204d52:	29300593          	li	a1,659
ffffffffc0204d56:	00002517          	auipc	a0,0x2
ffffffffc0204d5a:	26a50513          	addi	a0,a0,618 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204d5e:	f30fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204d62:	00002697          	auipc	a3,0x2
ffffffffc0204d66:	4be68693          	addi	a3,a3,1214 # ffffffffc0207220 <default_pmm_manager+0xcb8>
ffffffffc0204d6a:	00001617          	auipc	a2,0x1
ffffffffc0204d6e:	44e60613          	addi	a2,a2,1102 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204d72:	29200593          	li	a1,658
ffffffffc0204d76:	00002517          	auipc	a0,0x2
ffffffffc0204d7a:	24a50513          	addi	a0,a0,586 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204d7e:	f10fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204d82 <do_yield>:
    current->need_resched = 1;
ffffffffc0204d82:	000a6797          	auipc	a5,0xa6
ffffffffc0204d86:	0b67b783          	ld	a5,182(a5) # ffffffffc02aae38 <current>
ffffffffc0204d8a:	4705                	li	a4,1
ffffffffc0204d8c:	ef98                	sd	a4,24(a5)
}
ffffffffc0204d8e:	4501                	li	a0,0
ffffffffc0204d90:	8082                	ret

ffffffffc0204d92 <do_wait>:
{
ffffffffc0204d92:	1101                	addi	sp,sp,-32
ffffffffc0204d94:	e822                	sd	s0,16(sp)
ffffffffc0204d96:	e426                	sd	s1,8(sp)
ffffffffc0204d98:	ec06                	sd	ra,24(sp)
ffffffffc0204d9a:	842e                	mv	s0,a1
ffffffffc0204d9c:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204d9e:	c999                	beqz	a1,ffffffffc0204db4 <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204da0:	000a6797          	auipc	a5,0xa6
ffffffffc0204da4:	0987b783          	ld	a5,152(a5) # ffffffffc02aae38 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204da8:	7788                	ld	a0,40(a5)
ffffffffc0204daa:	4685                	li	a3,1
ffffffffc0204dac:	4611                	li	a2,4
ffffffffc0204dae:	fa5fe0ef          	jal	ra,ffffffffc0203d52 <user_mem_check>
ffffffffc0204db2:	c909                	beqz	a0,ffffffffc0204dc4 <do_wait+0x32>
ffffffffc0204db4:	85a2                	mv	a1,s0
}
ffffffffc0204db6:	6442                	ld	s0,16(sp)
ffffffffc0204db8:	60e2                	ld	ra,24(sp)
ffffffffc0204dba:	8526                	mv	a0,s1
ffffffffc0204dbc:	64a2                	ld	s1,8(sp)
ffffffffc0204dbe:	6105                	addi	sp,sp,32
ffffffffc0204dc0:	f9cff06f          	j	ffffffffc020455c <do_wait.part.0>
ffffffffc0204dc4:	60e2                	ld	ra,24(sp)
ffffffffc0204dc6:	6442                	ld	s0,16(sp)
ffffffffc0204dc8:	64a2                	ld	s1,8(sp)
ffffffffc0204dca:	5575                	li	a0,-3
ffffffffc0204dcc:	6105                	addi	sp,sp,32
ffffffffc0204dce:	8082                	ret

ffffffffc0204dd0 <do_kill>:
{
ffffffffc0204dd0:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204dd2:	6789                	lui	a5,0x2
{
ffffffffc0204dd4:	e406                	sd	ra,8(sp)
ffffffffc0204dd6:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204dd8:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204ddc:	17f9                	addi	a5,a5,-2
ffffffffc0204dde:	02e7e963          	bltu	a5,a4,ffffffffc0204e10 <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204de2:	842a                	mv	s0,a0
ffffffffc0204de4:	45a9                	li	a1,10
ffffffffc0204de6:	2501                	sext.w	a0,a0
ffffffffc0204de8:	46c000ef          	jal	ra,ffffffffc0205254 <hash32>
ffffffffc0204dec:	02051793          	slli	a5,a0,0x20
ffffffffc0204df0:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204df4:	000a2797          	auipc	a5,0xa2
ffffffffc0204df8:	fcc78793          	addi	a5,a5,-52 # ffffffffc02a6dc0 <hash_list>
ffffffffc0204dfc:	953e                	add	a0,a0,a5
ffffffffc0204dfe:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204e00:	a029                	j	ffffffffc0204e0a <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204e02:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204e06:	00870b63          	beq	a4,s0,ffffffffc0204e1c <do_kill+0x4c>
ffffffffc0204e0a:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204e0c:	fef51be3          	bne	a0,a5,ffffffffc0204e02 <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204e10:	5475                	li	s0,-3
}
ffffffffc0204e12:	60a2                	ld	ra,8(sp)
ffffffffc0204e14:	8522                	mv	a0,s0
ffffffffc0204e16:	6402                	ld	s0,0(sp)
ffffffffc0204e18:	0141                	addi	sp,sp,16
ffffffffc0204e1a:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204e1c:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204e20:	00177693          	andi	a3,a4,1
ffffffffc0204e24:	e295                	bnez	a3,ffffffffc0204e48 <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204e26:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204e28:	00176713          	ori	a4,a4,1
ffffffffc0204e2c:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204e30:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204e32:	fe06d0e3          	bgez	a3,ffffffffc0204e12 <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204e36:	f2878513          	addi	a0,a5,-216
ffffffffc0204e3a:	22e000ef          	jal	ra,ffffffffc0205068 <wakeup_proc>
}
ffffffffc0204e3e:	60a2                	ld	ra,8(sp)
ffffffffc0204e40:	8522                	mv	a0,s0
ffffffffc0204e42:	6402                	ld	s0,0(sp)
ffffffffc0204e44:	0141                	addi	sp,sp,16
ffffffffc0204e46:	8082                	ret
        return -E_KILLED;
ffffffffc0204e48:	545d                	li	s0,-9
ffffffffc0204e4a:	b7e1                	j	ffffffffc0204e12 <do_kill+0x42>

ffffffffc0204e4c <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204e4c:	1101                	addi	sp,sp,-32
ffffffffc0204e4e:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204e50:	000a6797          	auipc	a5,0xa6
ffffffffc0204e54:	f7078793          	addi	a5,a5,-144 # ffffffffc02aadc0 <proc_list>
ffffffffc0204e58:	ec06                	sd	ra,24(sp)
ffffffffc0204e5a:	e822                	sd	s0,16(sp)
ffffffffc0204e5c:	e04a                	sd	s2,0(sp)
ffffffffc0204e5e:	000a2497          	auipc	s1,0xa2
ffffffffc0204e62:	f6248493          	addi	s1,s1,-158 # ffffffffc02a6dc0 <hash_list>
ffffffffc0204e66:	e79c                	sd	a5,8(a5)
ffffffffc0204e68:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204e6a:	000a6717          	auipc	a4,0xa6
ffffffffc0204e6e:	f5670713          	addi	a4,a4,-170 # ffffffffc02aadc0 <proc_list>
ffffffffc0204e72:	87a6                	mv	a5,s1
ffffffffc0204e74:	e79c                	sd	a5,8(a5)
ffffffffc0204e76:	e39c                	sd	a5,0(a5)
ffffffffc0204e78:	07c1                	addi	a5,a5,16
ffffffffc0204e7a:	fef71de3          	bne	a4,a5,ffffffffc0204e74 <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204e7e:	f71fe0ef          	jal	ra,ffffffffc0203dee <alloc_proc>
ffffffffc0204e82:	000a6917          	auipc	s2,0xa6
ffffffffc0204e86:	fbe90913          	addi	s2,s2,-66 # ffffffffc02aae40 <idleproc>
ffffffffc0204e8a:	00a93023          	sd	a0,0(s2)
ffffffffc0204e8e:	0e050f63          	beqz	a0,ffffffffc0204f8c <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204e92:	4789                	li	a5,2
ffffffffc0204e94:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e96:	00003797          	auipc	a5,0x3
ffffffffc0204e9a:	16a78793          	addi	a5,a5,362 # ffffffffc0208000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e9e:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204ea2:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204ea4:	4785                	li	a5,1
ffffffffc0204ea6:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ea8:	4641                	li	a2,16
ffffffffc0204eaa:	4581                	li	a1,0
ffffffffc0204eac:	8522                	mv	a0,s0
ffffffffc0204eae:	04d000ef          	jal	ra,ffffffffc02056fa <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204eb2:	463d                	li	a2,15
ffffffffc0204eb4:	00002597          	auipc	a1,0x2
ffffffffc0204eb8:	4a458593          	addi	a1,a1,1188 # ffffffffc0207358 <default_pmm_manager+0xdf0>
ffffffffc0204ebc:	8522                	mv	a0,s0
ffffffffc0204ebe:	04f000ef          	jal	ra,ffffffffc020570c <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204ec2:	000a6717          	auipc	a4,0xa6
ffffffffc0204ec6:	f8e70713          	addi	a4,a4,-114 # ffffffffc02aae50 <nr_process>
ffffffffc0204eca:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204ecc:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204ed0:	4601                	li	a2,0
    nr_process++;
ffffffffc0204ed2:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204ed4:	4581                	li	a1,0
ffffffffc0204ed6:	00000517          	auipc	a0,0x0
ffffffffc0204eda:	85850513          	addi	a0,a0,-1960 # ffffffffc020472e <init_main>
    nr_process++;
ffffffffc0204ede:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204ee0:	000a6797          	auipc	a5,0xa6
ffffffffc0204ee4:	f4d7bc23          	sd	a3,-168(a5) # ffffffffc02aae38 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204ee8:	cdaff0ef          	jal	ra,ffffffffc02043c2 <kernel_thread>
ffffffffc0204eec:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204eee:	08a05363          	blez	a0,ffffffffc0204f74 <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204ef2:	6789                	lui	a5,0x2
ffffffffc0204ef4:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204ef8:	17f9                	addi	a5,a5,-2
ffffffffc0204efa:	2501                	sext.w	a0,a0
ffffffffc0204efc:	02e7e363          	bltu	a5,a4,ffffffffc0204f22 <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204f00:	45a9                	li	a1,10
ffffffffc0204f02:	352000ef          	jal	ra,ffffffffc0205254 <hash32>
ffffffffc0204f06:	02051793          	slli	a5,a0,0x20
ffffffffc0204f0a:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204f0e:	96a6                	add	a3,a3,s1
ffffffffc0204f10:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204f12:	a029                	j	ffffffffc0204f1c <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204f14:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x7cf4>
ffffffffc0204f18:	04870b63          	beq	a4,s0,ffffffffc0204f6e <proc_init+0x122>
    return listelm->next;
ffffffffc0204f1c:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204f1e:	fef69be3          	bne	a3,a5,ffffffffc0204f14 <proc_init+0xc8>
    return NULL;
ffffffffc0204f22:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f24:	0b478493          	addi	s1,a5,180
ffffffffc0204f28:	4641                	li	a2,16
ffffffffc0204f2a:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204f2c:	000a6417          	auipc	s0,0xa6
ffffffffc0204f30:	f1c40413          	addi	s0,s0,-228 # ffffffffc02aae48 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f34:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204f36:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f38:	7c2000ef          	jal	ra,ffffffffc02056fa <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204f3c:	463d                	li	a2,15
ffffffffc0204f3e:	00002597          	auipc	a1,0x2
ffffffffc0204f42:	44258593          	addi	a1,a1,1090 # ffffffffc0207380 <default_pmm_manager+0xe18>
ffffffffc0204f46:	8526                	mv	a0,s1
ffffffffc0204f48:	7c4000ef          	jal	ra,ffffffffc020570c <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204f4c:	00093783          	ld	a5,0(s2)
ffffffffc0204f50:	cbb5                	beqz	a5,ffffffffc0204fc4 <proc_init+0x178>
ffffffffc0204f52:	43dc                	lw	a5,4(a5)
ffffffffc0204f54:	eba5                	bnez	a5,ffffffffc0204fc4 <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f56:	601c                	ld	a5,0(s0)
ffffffffc0204f58:	c7b1                	beqz	a5,ffffffffc0204fa4 <proc_init+0x158>
ffffffffc0204f5a:	43d8                	lw	a4,4(a5)
ffffffffc0204f5c:	4785                	li	a5,1
ffffffffc0204f5e:	04f71363          	bne	a4,a5,ffffffffc0204fa4 <proc_init+0x158>
}
ffffffffc0204f62:	60e2                	ld	ra,24(sp)
ffffffffc0204f64:	6442                	ld	s0,16(sp)
ffffffffc0204f66:	64a2                	ld	s1,8(sp)
ffffffffc0204f68:	6902                	ld	s2,0(sp)
ffffffffc0204f6a:	6105                	addi	sp,sp,32
ffffffffc0204f6c:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204f6e:	f2878793          	addi	a5,a5,-216
ffffffffc0204f72:	bf4d                	j	ffffffffc0204f24 <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204f74:	00002617          	auipc	a2,0x2
ffffffffc0204f78:	3ec60613          	addi	a2,a2,1004 # ffffffffc0207360 <default_pmm_manager+0xdf8>
ffffffffc0204f7c:	3be00593          	li	a1,958
ffffffffc0204f80:	00002517          	auipc	a0,0x2
ffffffffc0204f84:	04050513          	addi	a0,a0,64 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204f88:	d06fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204f8c:	00002617          	auipc	a2,0x2
ffffffffc0204f90:	3b460613          	addi	a2,a2,948 # ffffffffc0207340 <default_pmm_manager+0xdd8>
ffffffffc0204f94:	3af00593          	li	a1,943
ffffffffc0204f98:	00002517          	auipc	a0,0x2
ffffffffc0204f9c:	02850513          	addi	a0,a0,40 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204fa0:	ceefb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204fa4:	00002697          	auipc	a3,0x2
ffffffffc0204fa8:	40c68693          	addi	a3,a3,1036 # ffffffffc02073b0 <default_pmm_manager+0xe48>
ffffffffc0204fac:	00001617          	auipc	a2,0x1
ffffffffc0204fb0:	20c60613          	addi	a2,a2,524 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204fb4:	3c500593          	li	a1,965
ffffffffc0204fb8:	00002517          	auipc	a0,0x2
ffffffffc0204fbc:	00850513          	addi	a0,a0,8 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204fc0:	ccefb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204fc4:	00002697          	auipc	a3,0x2
ffffffffc0204fc8:	3c468693          	addi	a3,a3,964 # ffffffffc0207388 <default_pmm_manager+0xe20>
ffffffffc0204fcc:	00001617          	auipc	a2,0x1
ffffffffc0204fd0:	1ec60613          	addi	a2,a2,492 # ffffffffc02061b8 <commands+0x828>
ffffffffc0204fd4:	3c400593          	li	a1,964
ffffffffc0204fd8:	00002517          	auipc	a0,0x2
ffffffffc0204fdc:	fe850513          	addi	a0,a0,-24 # ffffffffc0206fc0 <default_pmm_manager+0xa58>
ffffffffc0204fe0:	caefb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204fe4 <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204fe4:	1141                	addi	sp,sp,-16
ffffffffc0204fe6:	e022                	sd	s0,0(sp)
ffffffffc0204fe8:	e406                	sd	ra,8(sp)
ffffffffc0204fea:	000a6417          	auipc	s0,0xa6
ffffffffc0204fee:	e4e40413          	addi	s0,s0,-434 # ffffffffc02aae38 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0204ff2:	6018                	ld	a4,0(s0)
ffffffffc0204ff4:	6f1c                	ld	a5,24(a4)
ffffffffc0204ff6:	dffd                	beqz	a5,ffffffffc0204ff4 <cpu_idle+0x10>
        {
            schedule();
ffffffffc0204ff8:	0f0000ef          	jal	ra,ffffffffc02050e8 <schedule>
ffffffffc0204ffc:	bfdd                	j	ffffffffc0204ff2 <cpu_idle+0xe>

ffffffffc0204ffe <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0204ffe:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0205002:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0205006:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0205008:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc020500a:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc020500e:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0205012:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0205016:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc020501a:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc020501e:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0205022:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0205026:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc020502a:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc020502e:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0205032:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0205036:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc020503a:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc020503c:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc020503e:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0205042:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0205046:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc020504a:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc020504e:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0205052:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0205056:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc020505a:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc020505e:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0205062:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0205066:	8082                	ret

ffffffffc0205068 <wakeup_proc>:
#include <sched.h>
#include <assert.h>

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205068:	4118                	lw	a4,0(a0)
{
ffffffffc020506a:	1101                	addi	sp,sp,-32
ffffffffc020506c:	ec06                	sd	ra,24(sp)
ffffffffc020506e:	e822                	sd	s0,16(sp)
ffffffffc0205070:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205072:	478d                	li	a5,3
ffffffffc0205074:	04f70b63          	beq	a4,a5,ffffffffc02050ca <wakeup_proc+0x62>
ffffffffc0205078:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020507a:	100027f3          	csrr	a5,sstatus
ffffffffc020507e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0205080:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205082:	ef9d                	bnez	a5,ffffffffc02050c0 <wakeup_proc+0x58>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc0205084:	4789                	li	a5,2
ffffffffc0205086:	02f70163          	beq	a4,a5,ffffffffc02050a8 <wakeup_proc+0x40>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc020508a:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc020508c:	0e042623          	sw	zero,236(s0)
    if (flag)
ffffffffc0205090:	e491                	bnez	s1,ffffffffc020509c <wakeup_proc+0x34>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0205092:	60e2                	ld	ra,24(sp)
ffffffffc0205094:	6442                	ld	s0,16(sp)
ffffffffc0205096:	64a2                	ld	s1,8(sp)
ffffffffc0205098:	6105                	addi	sp,sp,32
ffffffffc020509a:	8082                	ret
ffffffffc020509c:	6442                	ld	s0,16(sp)
ffffffffc020509e:	60e2                	ld	ra,24(sp)
ffffffffc02050a0:	64a2                	ld	s1,8(sp)
ffffffffc02050a2:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02050a4:	90bfb06f          	j	ffffffffc02009ae <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc02050a8:	00002617          	auipc	a2,0x2
ffffffffc02050ac:	36860613          	addi	a2,a2,872 # ffffffffc0207410 <default_pmm_manager+0xea8>
ffffffffc02050b0:	45d1                	li	a1,20
ffffffffc02050b2:	00002517          	auipc	a0,0x2
ffffffffc02050b6:	34650513          	addi	a0,a0,838 # ffffffffc02073f8 <default_pmm_manager+0xe90>
ffffffffc02050ba:	c3cfb0ef          	jal	ra,ffffffffc02004f6 <__warn>
ffffffffc02050be:	bfc9                	j	ffffffffc0205090 <wakeup_proc+0x28>
        intr_disable();
ffffffffc02050c0:	8f5fb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc02050c4:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc02050c6:	4485                	li	s1,1
ffffffffc02050c8:	bf75                	j	ffffffffc0205084 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02050ca:	00002697          	auipc	a3,0x2
ffffffffc02050ce:	30e68693          	addi	a3,a3,782 # ffffffffc02073d8 <default_pmm_manager+0xe70>
ffffffffc02050d2:	00001617          	auipc	a2,0x1
ffffffffc02050d6:	0e660613          	addi	a2,a2,230 # ffffffffc02061b8 <commands+0x828>
ffffffffc02050da:	45a5                	li	a1,9
ffffffffc02050dc:	00002517          	auipc	a0,0x2
ffffffffc02050e0:	31c50513          	addi	a0,a0,796 # ffffffffc02073f8 <default_pmm_manager+0xe90>
ffffffffc02050e4:	baafb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02050e8 <schedule>:

void schedule(void)
{
ffffffffc02050e8:	1141                	addi	sp,sp,-16
ffffffffc02050ea:	e406                	sd	ra,8(sp)
ffffffffc02050ec:	e022                	sd	s0,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02050ee:	100027f3          	csrr	a5,sstatus
ffffffffc02050f2:	8b89                	andi	a5,a5,2
ffffffffc02050f4:	4401                	li	s0,0
ffffffffc02050f6:	efbd                	bnez	a5,ffffffffc0205174 <schedule+0x8c>
    bool intr_flag;
    list_entry_t *le, *last;
    struct proc_struct *next = NULL;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc02050f8:	000a6897          	auipc	a7,0xa6
ffffffffc02050fc:	d408b883          	ld	a7,-704(a7) # ffffffffc02aae38 <current>
ffffffffc0205100:	0008bc23          	sd	zero,24(a7)
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc0205104:	000a6517          	auipc	a0,0xa6
ffffffffc0205108:	d3c53503          	ld	a0,-708(a0) # ffffffffc02aae40 <idleproc>
ffffffffc020510c:	04a88e63          	beq	a7,a0,ffffffffc0205168 <schedule+0x80>
ffffffffc0205110:	0c888693          	addi	a3,a7,200
ffffffffc0205114:	000a6617          	auipc	a2,0xa6
ffffffffc0205118:	cac60613          	addi	a2,a2,-852 # ffffffffc02aadc0 <proc_list>
        le = last;
ffffffffc020511c:	87b6                	mv	a5,a3
    struct proc_struct *next = NULL;
ffffffffc020511e:	4581                	li	a1,0
        do
        {
            if ((le = list_next(le)) != &proc_list)
            {
                next = le2proc(le, list_link);
                if (next->state == PROC_RUNNABLE)
ffffffffc0205120:	4809                	li	a6,2
ffffffffc0205122:	679c                	ld	a5,8(a5)
            if ((le = list_next(le)) != &proc_list)
ffffffffc0205124:	00c78863          	beq	a5,a2,ffffffffc0205134 <schedule+0x4c>
                if (next->state == PROC_RUNNABLE)
ffffffffc0205128:	f387a703          	lw	a4,-200(a5)
                next = le2proc(le, list_link);
ffffffffc020512c:	f3878593          	addi	a1,a5,-200
                if (next->state == PROC_RUNNABLE)
ffffffffc0205130:	03070163          	beq	a4,a6,ffffffffc0205152 <schedule+0x6a>
                {
                    break;
                }
            }
        } while (le != last);
ffffffffc0205134:	fef697e3          	bne	a3,a5,ffffffffc0205122 <schedule+0x3a>
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc0205138:	ed89                	bnez	a1,ffffffffc0205152 <schedule+0x6a>
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc020513a:	451c                	lw	a5,8(a0)
ffffffffc020513c:	2785                	addiw	a5,a5,1
ffffffffc020513e:	c51c                	sw	a5,8(a0)
        if (next != current)
ffffffffc0205140:	00a88463          	beq	a7,a0,ffffffffc0205148 <schedule+0x60>
        {
            proc_run(next);
ffffffffc0205144:	e29fe0ef          	jal	ra,ffffffffc0203f6c <proc_run>
    if (flag)
ffffffffc0205148:	e819                	bnez	s0,ffffffffc020515e <schedule+0x76>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc020514a:	60a2                	ld	ra,8(sp)
ffffffffc020514c:	6402                	ld	s0,0(sp)
ffffffffc020514e:	0141                	addi	sp,sp,16
ffffffffc0205150:	8082                	ret
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc0205152:	4198                	lw	a4,0(a1)
ffffffffc0205154:	4789                	li	a5,2
ffffffffc0205156:	fef712e3          	bne	a4,a5,ffffffffc020513a <schedule+0x52>
ffffffffc020515a:	852e                	mv	a0,a1
ffffffffc020515c:	bff9                	j	ffffffffc020513a <schedule+0x52>
}
ffffffffc020515e:	6402                	ld	s0,0(sp)
ffffffffc0205160:	60a2                	ld	ra,8(sp)
ffffffffc0205162:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0205164:	84bfb06f          	j	ffffffffc02009ae <intr_enable>
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc0205168:	000a6617          	auipc	a2,0xa6
ffffffffc020516c:	c5860613          	addi	a2,a2,-936 # ffffffffc02aadc0 <proc_list>
ffffffffc0205170:	86b2                	mv	a3,a2
ffffffffc0205172:	b76d                	j	ffffffffc020511c <schedule+0x34>
        intr_disable();
ffffffffc0205174:	841fb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0205178:	4405                	li	s0,1
ffffffffc020517a:	bfbd                	j	ffffffffc02050f8 <schedule+0x10>

ffffffffc020517c <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc020517c:	000a6797          	auipc	a5,0xa6
ffffffffc0205180:	cbc7b783          	ld	a5,-836(a5) # ffffffffc02aae38 <current>
}
ffffffffc0205184:	43c8                	lw	a0,4(a5)
ffffffffc0205186:	8082                	ret

ffffffffc0205188 <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc0205188:	4501                	li	a0,0
ffffffffc020518a:	8082                	ret

ffffffffc020518c <sys_putc>:
    cputchar(c);
ffffffffc020518c:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc020518e:	1141                	addi	sp,sp,-16
ffffffffc0205190:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc0205192:	838fb0ef          	jal	ra,ffffffffc02001ca <cputchar>
}
ffffffffc0205196:	60a2                	ld	ra,8(sp)
ffffffffc0205198:	4501                	li	a0,0
ffffffffc020519a:	0141                	addi	sp,sp,16
ffffffffc020519c:	8082                	ret

ffffffffc020519e <sys_kill>:
    return do_kill(pid);
ffffffffc020519e:	4108                	lw	a0,0(a0)
ffffffffc02051a0:	c31ff06f          	j	ffffffffc0204dd0 <do_kill>

ffffffffc02051a4 <sys_yield>:
    return do_yield();
ffffffffc02051a4:	bdfff06f          	j	ffffffffc0204d82 <do_yield>

ffffffffc02051a8 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc02051a8:	6d14                	ld	a3,24(a0)
ffffffffc02051aa:	6910                	ld	a2,16(a0)
ffffffffc02051ac:	650c                	ld	a1,8(a0)
ffffffffc02051ae:	6108                	ld	a0,0(a0)
ffffffffc02051b0:	ea2ff06f          	j	ffffffffc0204852 <do_execve>

ffffffffc02051b4 <sys_wait>:
    return do_wait(pid, store);
ffffffffc02051b4:	650c                	ld	a1,8(a0)
ffffffffc02051b6:	4108                	lw	a0,0(a0)
ffffffffc02051b8:	bdbff06f          	j	ffffffffc0204d92 <do_wait>

ffffffffc02051bc <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc02051bc:	000a6797          	auipc	a5,0xa6
ffffffffc02051c0:	c7c7b783          	ld	a5,-900(a5) # ffffffffc02aae38 <current>
ffffffffc02051c4:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc02051c6:	4501                	li	a0,0
ffffffffc02051c8:	6a0c                	ld	a1,16(a2)
ffffffffc02051ca:	e1dfe06f          	j	ffffffffc0203fe6 <do_fork>

ffffffffc02051ce <sys_exit>:
    return do_exit(error_code);
ffffffffc02051ce:	4108                	lw	a0,0(a0)
ffffffffc02051d0:	a42ff06f          	j	ffffffffc0204412 <do_exit>

ffffffffc02051d4 <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc02051d4:	715d                	addi	sp,sp,-80
ffffffffc02051d6:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc02051d8:	000a6497          	auipc	s1,0xa6
ffffffffc02051dc:	c6048493          	addi	s1,s1,-928 # ffffffffc02aae38 <current>
ffffffffc02051e0:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc02051e2:	e0a2                	sd	s0,64(sp)
ffffffffc02051e4:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc02051e6:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc02051e8:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc02051ea:	47fd                	li	a5,31
    int num = tf->gpr.a0;
ffffffffc02051ec:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc02051f0:	0327ee63          	bltu	a5,s2,ffffffffc020522c <syscall+0x58>
        if (syscalls[num] != NULL) {
ffffffffc02051f4:	00391713          	slli	a4,s2,0x3
ffffffffc02051f8:	00002797          	auipc	a5,0x2
ffffffffc02051fc:	28078793          	addi	a5,a5,640 # ffffffffc0207478 <syscalls>
ffffffffc0205200:	97ba                	add	a5,a5,a4
ffffffffc0205202:	639c                	ld	a5,0(a5)
ffffffffc0205204:	c785                	beqz	a5,ffffffffc020522c <syscall+0x58>
            arg[0] = tf->gpr.a1;
ffffffffc0205206:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc0205208:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc020520a:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc020520c:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc020520e:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc0205210:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc0205212:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc0205214:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc0205216:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc0205218:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc020521a:	0028                	addi	a0,sp,8
ffffffffc020521c:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc020521e:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc0205220:	e828                	sd	a0,80(s0)
}
ffffffffc0205222:	6406                	ld	s0,64(sp)
ffffffffc0205224:	74e2                	ld	s1,56(sp)
ffffffffc0205226:	7942                	ld	s2,48(sp)
ffffffffc0205228:	6161                	addi	sp,sp,80
ffffffffc020522a:	8082                	ret
    print_trapframe(tf);
ffffffffc020522c:	8522                	mv	a0,s0
ffffffffc020522e:	977fb0ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc0205232:	609c                	ld	a5,0(s1)
ffffffffc0205234:	86ca                	mv	a3,s2
ffffffffc0205236:	00002617          	auipc	a2,0x2
ffffffffc020523a:	1fa60613          	addi	a2,a2,506 # ffffffffc0207430 <default_pmm_manager+0xec8>
ffffffffc020523e:	43d8                	lw	a4,4(a5)
ffffffffc0205240:	06200593          	li	a1,98
ffffffffc0205244:	0b478793          	addi	a5,a5,180
ffffffffc0205248:	00002517          	auipc	a0,0x2
ffffffffc020524c:	21850513          	addi	a0,a0,536 # ffffffffc0207460 <default_pmm_manager+0xef8>
ffffffffc0205250:	a3efb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0205254 <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc0205254:	9e3707b7          	lui	a5,0x9e370
ffffffffc0205258:	2785                	addiw	a5,a5,1
ffffffffc020525a:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc020525e:	02000793          	li	a5,32
ffffffffc0205262:	9f8d                	subw	a5,a5,a1
}
ffffffffc0205264:	00f5553b          	srlw	a0,a0,a5
ffffffffc0205268:	8082                	ret

ffffffffc020526a <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc020526a:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020526e:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0205270:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0205274:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0205276:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020527a:	f022                	sd	s0,32(sp)
ffffffffc020527c:	ec26                	sd	s1,24(sp)
ffffffffc020527e:	e84a                	sd	s2,16(sp)
ffffffffc0205280:	f406                	sd	ra,40(sp)
ffffffffc0205282:	e44e                	sd	s3,8(sp)
ffffffffc0205284:	84aa                	mv	s1,a0
ffffffffc0205286:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0205288:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc020528c:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc020528e:	03067e63          	bgeu	a2,a6,ffffffffc02052ca <printnum+0x60>
ffffffffc0205292:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0205294:	00805763          	blez	s0,ffffffffc02052a2 <printnum+0x38>
ffffffffc0205298:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc020529a:	85ca                	mv	a1,s2
ffffffffc020529c:	854e                	mv	a0,s3
ffffffffc020529e:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02052a0:	fc65                	bnez	s0,ffffffffc0205298 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02052a2:	1a02                	slli	s4,s4,0x20
ffffffffc02052a4:	00002797          	auipc	a5,0x2
ffffffffc02052a8:	2d478793          	addi	a5,a5,724 # ffffffffc0207578 <syscalls+0x100>
ffffffffc02052ac:	020a5a13          	srli	s4,s4,0x20
ffffffffc02052b0:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc02052b2:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02052b4:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02052b8:	70a2                	ld	ra,40(sp)
ffffffffc02052ba:	69a2                	ld	s3,8(sp)
ffffffffc02052bc:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02052be:	85ca                	mv	a1,s2
ffffffffc02052c0:	87a6                	mv	a5,s1
}
ffffffffc02052c2:	6942                	ld	s2,16(sp)
ffffffffc02052c4:	64e2                	ld	s1,24(sp)
ffffffffc02052c6:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02052c8:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc02052ca:	03065633          	divu	a2,a2,a6
ffffffffc02052ce:	8722                	mv	a4,s0
ffffffffc02052d0:	f9bff0ef          	jal	ra,ffffffffc020526a <printnum>
ffffffffc02052d4:	b7f9                	j	ffffffffc02052a2 <printnum+0x38>

ffffffffc02052d6 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc02052d6:	7119                	addi	sp,sp,-128
ffffffffc02052d8:	f4a6                	sd	s1,104(sp)
ffffffffc02052da:	f0ca                	sd	s2,96(sp)
ffffffffc02052dc:	ecce                	sd	s3,88(sp)
ffffffffc02052de:	e8d2                	sd	s4,80(sp)
ffffffffc02052e0:	e4d6                	sd	s5,72(sp)
ffffffffc02052e2:	e0da                	sd	s6,64(sp)
ffffffffc02052e4:	fc5e                	sd	s7,56(sp)
ffffffffc02052e6:	f06a                	sd	s10,32(sp)
ffffffffc02052e8:	fc86                	sd	ra,120(sp)
ffffffffc02052ea:	f8a2                	sd	s0,112(sp)
ffffffffc02052ec:	f862                	sd	s8,48(sp)
ffffffffc02052ee:	f466                	sd	s9,40(sp)
ffffffffc02052f0:	ec6e                	sd	s11,24(sp)
ffffffffc02052f2:	892a                	mv	s2,a0
ffffffffc02052f4:	84ae                	mv	s1,a1
ffffffffc02052f6:	8d32                	mv	s10,a2
ffffffffc02052f8:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052fa:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc02052fe:	5b7d                	li	s6,-1
ffffffffc0205300:	00002a97          	auipc	s5,0x2
ffffffffc0205304:	2a4a8a93          	addi	s5,s5,676 # ffffffffc02075a4 <syscalls+0x12c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205308:	00002b97          	auipc	s7,0x2
ffffffffc020530c:	4b8b8b93          	addi	s7,s7,1208 # ffffffffc02077c0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205310:	000d4503          	lbu	a0,0(s10)
ffffffffc0205314:	001d0413          	addi	s0,s10,1
ffffffffc0205318:	01350a63          	beq	a0,s3,ffffffffc020532c <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc020531c:	c121                	beqz	a0,ffffffffc020535c <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc020531e:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205320:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0205322:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205324:	fff44503          	lbu	a0,-1(s0)
ffffffffc0205328:	ff351ae3          	bne	a0,s3,ffffffffc020531c <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020532c:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0205330:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0205334:	4c81                	li	s9,0
ffffffffc0205336:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0205338:	5c7d                	li	s8,-1
ffffffffc020533a:	5dfd                	li	s11,-1
ffffffffc020533c:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0205340:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205342:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0205346:	0ff5f593          	zext.b	a1,a1
ffffffffc020534a:	00140d13          	addi	s10,s0,1
ffffffffc020534e:	04b56263          	bltu	a0,a1,ffffffffc0205392 <vprintfmt+0xbc>
ffffffffc0205352:	058a                	slli	a1,a1,0x2
ffffffffc0205354:	95d6                	add	a1,a1,s5
ffffffffc0205356:	4194                	lw	a3,0(a1)
ffffffffc0205358:	96d6                	add	a3,a3,s5
ffffffffc020535a:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc020535c:	70e6                	ld	ra,120(sp)
ffffffffc020535e:	7446                	ld	s0,112(sp)
ffffffffc0205360:	74a6                	ld	s1,104(sp)
ffffffffc0205362:	7906                	ld	s2,96(sp)
ffffffffc0205364:	69e6                	ld	s3,88(sp)
ffffffffc0205366:	6a46                	ld	s4,80(sp)
ffffffffc0205368:	6aa6                	ld	s5,72(sp)
ffffffffc020536a:	6b06                	ld	s6,64(sp)
ffffffffc020536c:	7be2                	ld	s7,56(sp)
ffffffffc020536e:	7c42                	ld	s8,48(sp)
ffffffffc0205370:	7ca2                	ld	s9,40(sp)
ffffffffc0205372:	7d02                	ld	s10,32(sp)
ffffffffc0205374:	6de2                	ld	s11,24(sp)
ffffffffc0205376:	6109                	addi	sp,sp,128
ffffffffc0205378:	8082                	ret
            padc = '0';
ffffffffc020537a:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc020537c:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205380:	846a                	mv	s0,s10
ffffffffc0205382:	00140d13          	addi	s10,s0,1
ffffffffc0205386:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020538a:	0ff5f593          	zext.b	a1,a1
ffffffffc020538e:	fcb572e3          	bgeu	a0,a1,ffffffffc0205352 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0205392:	85a6                	mv	a1,s1
ffffffffc0205394:	02500513          	li	a0,37
ffffffffc0205398:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc020539a:	fff44783          	lbu	a5,-1(s0)
ffffffffc020539e:	8d22                	mv	s10,s0
ffffffffc02053a0:	f73788e3          	beq	a5,s3,ffffffffc0205310 <vprintfmt+0x3a>
ffffffffc02053a4:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02053a8:	1d7d                	addi	s10,s10,-1
ffffffffc02053aa:	ff379de3          	bne	a5,s3,ffffffffc02053a4 <vprintfmt+0xce>
ffffffffc02053ae:	b78d                	j	ffffffffc0205310 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02053b0:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02053b4:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053b8:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02053ba:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02053be:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02053c2:	02d86463          	bltu	a6,a3,ffffffffc02053ea <vprintfmt+0x114>
                ch = *fmt;
ffffffffc02053c6:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc02053ca:	002c169b          	slliw	a3,s8,0x2
ffffffffc02053ce:	0186873b          	addw	a4,a3,s8
ffffffffc02053d2:	0017171b          	slliw	a4,a4,0x1
ffffffffc02053d6:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc02053d8:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc02053dc:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc02053de:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc02053e2:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02053e6:	fed870e3          	bgeu	a6,a3,ffffffffc02053c6 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc02053ea:	f40ddce3          	bgez	s11,ffffffffc0205342 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc02053ee:	8de2                	mv	s11,s8
ffffffffc02053f0:	5c7d                	li	s8,-1
ffffffffc02053f2:	bf81                	j	ffffffffc0205342 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc02053f4:	fffdc693          	not	a3,s11
ffffffffc02053f8:	96fd                	srai	a3,a3,0x3f
ffffffffc02053fa:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053fe:	00144603          	lbu	a2,1(s0)
ffffffffc0205402:	2d81                	sext.w	s11,s11
ffffffffc0205404:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205406:	bf35                	j	ffffffffc0205342 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0205408:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020540c:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0205410:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205412:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0205414:	bfd9                	j	ffffffffc02053ea <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0205416:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205418:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020541c:	01174463          	blt	a4,a7,ffffffffc0205424 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0205420:	1a088e63          	beqz	a7,ffffffffc02055dc <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0205424:	000a3603          	ld	a2,0(s4)
ffffffffc0205428:	46c1                	li	a3,16
ffffffffc020542a:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc020542c:	2781                	sext.w	a5,a5
ffffffffc020542e:	876e                	mv	a4,s11
ffffffffc0205430:	85a6                	mv	a1,s1
ffffffffc0205432:	854a                	mv	a0,s2
ffffffffc0205434:	e37ff0ef          	jal	ra,ffffffffc020526a <printnum>
            break;
ffffffffc0205438:	bde1                	j	ffffffffc0205310 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc020543a:	000a2503          	lw	a0,0(s4)
ffffffffc020543e:	85a6                	mv	a1,s1
ffffffffc0205440:	0a21                	addi	s4,s4,8
ffffffffc0205442:	9902                	jalr	s2
            break;
ffffffffc0205444:	b5f1                	j	ffffffffc0205310 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0205446:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205448:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020544c:	01174463          	blt	a4,a7,ffffffffc0205454 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0205450:	18088163          	beqz	a7,ffffffffc02055d2 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0205454:	000a3603          	ld	a2,0(s4)
ffffffffc0205458:	46a9                	li	a3,10
ffffffffc020545a:	8a2e                	mv	s4,a1
ffffffffc020545c:	bfc1                	j	ffffffffc020542c <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020545e:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0205462:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205464:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205466:	bdf1                	j	ffffffffc0205342 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0205468:	85a6                	mv	a1,s1
ffffffffc020546a:	02500513          	li	a0,37
ffffffffc020546e:	9902                	jalr	s2
            break;
ffffffffc0205470:	b545                	j	ffffffffc0205310 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205472:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0205476:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205478:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020547a:	b5e1                	j	ffffffffc0205342 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc020547c:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020547e:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205482:	01174463          	blt	a4,a7,ffffffffc020548a <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0205486:	14088163          	beqz	a7,ffffffffc02055c8 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc020548a:	000a3603          	ld	a2,0(s4)
ffffffffc020548e:	46a1                	li	a3,8
ffffffffc0205490:	8a2e                	mv	s4,a1
ffffffffc0205492:	bf69                	j	ffffffffc020542c <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0205494:	03000513          	li	a0,48
ffffffffc0205498:	85a6                	mv	a1,s1
ffffffffc020549a:	e03e                	sd	a5,0(sp)
ffffffffc020549c:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc020549e:	85a6                	mv	a1,s1
ffffffffc02054a0:	07800513          	li	a0,120
ffffffffc02054a4:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02054a6:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc02054a8:	6782                	ld	a5,0(sp)
ffffffffc02054aa:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02054ac:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc02054b0:	bfb5                	j	ffffffffc020542c <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02054b2:	000a3403          	ld	s0,0(s4)
ffffffffc02054b6:	008a0713          	addi	a4,s4,8
ffffffffc02054ba:	e03a                	sd	a4,0(sp)
ffffffffc02054bc:	14040263          	beqz	s0,ffffffffc0205600 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc02054c0:	0fb05763          	blez	s11,ffffffffc02055ae <vprintfmt+0x2d8>
ffffffffc02054c4:	02d00693          	li	a3,45
ffffffffc02054c8:	0cd79163          	bne	a5,a3,ffffffffc020558a <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02054cc:	00044783          	lbu	a5,0(s0)
ffffffffc02054d0:	0007851b          	sext.w	a0,a5
ffffffffc02054d4:	cf85                	beqz	a5,ffffffffc020550c <vprintfmt+0x236>
ffffffffc02054d6:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02054da:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02054de:	000c4563          	bltz	s8,ffffffffc02054e8 <vprintfmt+0x212>
ffffffffc02054e2:	3c7d                	addiw	s8,s8,-1
ffffffffc02054e4:	036c0263          	beq	s8,s6,ffffffffc0205508 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc02054e8:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02054ea:	0e0c8e63          	beqz	s9,ffffffffc02055e6 <vprintfmt+0x310>
ffffffffc02054ee:	3781                	addiw	a5,a5,-32
ffffffffc02054f0:	0ef47b63          	bgeu	s0,a5,ffffffffc02055e6 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc02054f4:	03f00513          	li	a0,63
ffffffffc02054f8:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02054fa:	000a4783          	lbu	a5,0(s4)
ffffffffc02054fe:	3dfd                	addiw	s11,s11,-1
ffffffffc0205500:	0a05                	addi	s4,s4,1
ffffffffc0205502:	0007851b          	sext.w	a0,a5
ffffffffc0205506:	ffe1                	bnez	a5,ffffffffc02054de <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0205508:	01b05963          	blez	s11,ffffffffc020551a <vprintfmt+0x244>
ffffffffc020550c:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc020550e:	85a6                	mv	a1,s1
ffffffffc0205510:	02000513          	li	a0,32
ffffffffc0205514:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0205516:	fe0d9be3          	bnez	s11,ffffffffc020550c <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020551a:	6a02                	ld	s4,0(sp)
ffffffffc020551c:	bbd5                	j	ffffffffc0205310 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020551e:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205520:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0205524:	01174463          	blt	a4,a7,ffffffffc020552c <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0205528:	08088d63          	beqz	a7,ffffffffc02055c2 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc020552c:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0205530:	0a044d63          	bltz	s0,ffffffffc02055ea <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0205534:	8622                	mv	a2,s0
ffffffffc0205536:	8a66                	mv	s4,s9
ffffffffc0205538:	46a9                	li	a3,10
ffffffffc020553a:	bdcd                	j	ffffffffc020542c <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc020553c:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205540:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0205542:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0205544:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0205548:	8fb5                	xor	a5,a5,a3
ffffffffc020554a:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020554e:	02d74163          	blt	a4,a3,ffffffffc0205570 <vprintfmt+0x29a>
ffffffffc0205552:	00369793          	slli	a5,a3,0x3
ffffffffc0205556:	97de                	add	a5,a5,s7
ffffffffc0205558:	639c                	ld	a5,0(a5)
ffffffffc020555a:	cb99                	beqz	a5,ffffffffc0205570 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc020555c:	86be                	mv	a3,a5
ffffffffc020555e:	00000617          	auipc	a2,0x0
ffffffffc0205562:	1f260613          	addi	a2,a2,498 # ffffffffc0205750 <etext+0x2c>
ffffffffc0205566:	85a6                	mv	a1,s1
ffffffffc0205568:	854a                	mv	a0,s2
ffffffffc020556a:	0ce000ef          	jal	ra,ffffffffc0205638 <printfmt>
ffffffffc020556e:	b34d                	j	ffffffffc0205310 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0205570:	00002617          	auipc	a2,0x2
ffffffffc0205574:	02860613          	addi	a2,a2,40 # ffffffffc0207598 <syscalls+0x120>
ffffffffc0205578:	85a6                	mv	a1,s1
ffffffffc020557a:	854a                	mv	a0,s2
ffffffffc020557c:	0bc000ef          	jal	ra,ffffffffc0205638 <printfmt>
ffffffffc0205580:	bb41                	j	ffffffffc0205310 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0205582:	00002417          	auipc	s0,0x2
ffffffffc0205586:	00e40413          	addi	s0,s0,14 # ffffffffc0207590 <syscalls+0x118>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020558a:	85e2                	mv	a1,s8
ffffffffc020558c:	8522                	mv	a0,s0
ffffffffc020558e:	e43e                	sd	a5,8(sp)
ffffffffc0205590:	0e2000ef          	jal	ra,ffffffffc0205672 <strnlen>
ffffffffc0205594:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0205598:	01b05b63          	blez	s11,ffffffffc02055ae <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc020559c:	67a2                	ld	a5,8(sp)
ffffffffc020559e:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02055a2:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc02055a4:	85a6                	mv	a1,s1
ffffffffc02055a6:	8552                	mv	a0,s4
ffffffffc02055a8:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02055aa:	fe0d9ce3          	bnez	s11,ffffffffc02055a2 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02055ae:	00044783          	lbu	a5,0(s0)
ffffffffc02055b2:	00140a13          	addi	s4,s0,1
ffffffffc02055b6:	0007851b          	sext.w	a0,a5
ffffffffc02055ba:	d3a5                	beqz	a5,ffffffffc020551a <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02055bc:	05e00413          	li	s0,94
ffffffffc02055c0:	bf39                	j	ffffffffc02054de <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc02055c2:	000a2403          	lw	s0,0(s4)
ffffffffc02055c6:	b7ad                	j	ffffffffc0205530 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc02055c8:	000a6603          	lwu	a2,0(s4)
ffffffffc02055cc:	46a1                	li	a3,8
ffffffffc02055ce:	8a2e                	mv	s4,a1
ffffffffc02055d0:	bdb1                	j	ffffffffc020542c <vprintfmt+0x156>
ffffffffc02055d2:	000a6603          	lwu	a2,0(s4)
ffffffffc02055d6:	46a9                	li	a3,10
ffffffffc02055d8:	8a2e                	mv	s4,a1
ffffffffc02055da:	bd89                	j	ffffffffc020542c <vprintfmt+0x156>
ffffffffc02055dc:	000a6603          	lwu	a2,0(s4)
ffffffffc02055e0:	46c1                	li	a3,16
ffffffffc02055e2:	8a2e                	mv	s4,a1
ffffffffc02055e4:	b5a1                	j	ffffffffc020542c <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc02055e6:	9902                	jalr	s2
ffffffffc02055e8:	bf09                	j	ffffffffc02054fa <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc02055ea:	85a6                	mv	a1,s1
ffffffffc02055ec:	02d00513          	li	a0,45
ffffffffc02055f0:	e03e                	sd	a5,0(sp)
ffffffffc02055f2:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc02055f4:	6782                	ld	a5,0(sp)
ffffffffc02055f6:	8a66                	mv	s4,s9
ffffffffc02055f8:	40800633          	neg	a2,s0
ffffffffc02055fc:	46a9                	li	a3,10
ffffffffc02055fe:	b53d                	j	ffffffffc020542c <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0205600:	03b05163          	blez	s11,ffffffffc0205622 <vprintfmt+0x34c>
ffffffffc0205604:	02d00693          	li	a3,45
ffffffffc0205608:	f6d79de3          	bne	a5,a3,ffffffffc0205582 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc020560c:	00002417          	auipc	s0,0x2
ffffffffc0205610:	f8440413          	addi	s0,s0,-124 # ffffffffc0207590 <syscalls+0x118>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205614:	02800793          	li	a5,40
ffffffffc0205618:	02800513          	li	a0,40
ffffffffc020561c:	00140a13          	addi	s4,s0,1
ffffffffc0205620:	bd6d                	j	ffffffffc02054da <vprintfmt+0x204>
ffffffffc0205622:	00002a17          	auipc	s4,0x2
ffffffffc0205626:	f6fa0a13          	addi	s4,s4,-145 # ffffffffc0207591 <syscalls+0x119>
ffffffffc020562a:	02800513          	li	a0,40
ffffffffc020562e:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205632:	05e00413          	li	s0,94
ffffffffc0205636:	b565                	j	ffffffffc02054de <vprintfmt+0x208>

ffffffffc0205638 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0205638:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc020563a:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020563e:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0205640:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0205642:	ec06                	sd	ra,24(sp)
ffffffffc0205644:	f83a                	sd	a4,48(sp)
ffffffffc0205646:	fc3e                	sd	a5,56(sp)
ffffffffc0205648:	e0c2                	sd	a6,64(sp)
ffffffffc020564a:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020564c:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc020564e:	c89ff0ef          	jal	ra,ffffffffc02052d6 <vprintfmt>
}
ffffffffc0205652:	60e2                	ld	ra,24(sp)
ffffffffc0205654:	6161                	addi	sp,sp,80
ffffffffc0205656:	8082                	ret

ffffffffc0205658 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0205658:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc020565c:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc020565e:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0205660:	cb81                	beqz	a5,ffffffffc0205670 <strlen+0x18>
        cnt ++;
ffffffffc0205662:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0205664:	00a707b3          	add	a5,a4,a0
ffffffffc0205668:	0007c783          	lbu	a5,0(a5)
ffffffffc020566c:	fbfd                	bnez	a5,ffffffffc0205662 <strlen+0xa>
ffffffffc020566e:	8082                	ret
    }
    return cnt;
}
ffffffffc0205670:	8082                	ret

ffffffffc0205672 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0205672:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0205674:	e589                	bnez	a1,ffffffffc020567e <strnlen+0xc>
ffffffffc0205676:	a811                	j	ffffffffc020568a <strnlen+0x18>
        cnt ++;
ffffffffc0205678:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc020567a:	00f58863          	beq	a1,a5,ffffffffc020568a <strnlen+0x18>
ffffffffc020567e:	00f50733          	add	a4,a0,a5
ffffffffc0205682:	00074703          	lbu	a4,0(a4)
ffffffffc0205686:	fb6d                	bnez	a4,ffffffffc0205678 <strnlen+0x6>
ffffffffc0205688:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc020568a:	852e                	mv	a0,a1
ffffffffc020568c:	8082                	ret

ffffffffc020568e <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc020568e:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc0205690:	0005c703          	lbu	a4,0(a1)
ffffffffc0205694:	0785                	addi	a5,a5,1
ffffffffc0205696:	0585                	addi	a1,a1,1
ffffffffc0205698:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020569c:	fb75                	bnez	a4,ffffffffc0205690 <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc020569e:	8082                	ret

ffffffffc02056a0 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02056a0:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02056a4:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02056a8:	cb89                	beqz	a5,ffffffffc02056ba <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc02056aa:	0505                	addi	a0,a0,1
ffffffffc02056ac:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02056ae:	fee789e3          	beq	a5,a4,ffffffffc02056a0 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02056b2:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc02056b6:	9d19                	subw	a0,a0,a4
ffffffffc02056b8:	8082                	ret
ffffffffc02056ba:	4501                	li	a0,0
ffffffffc02056bc:	bfed                	j	ffffffffc02056b6 <strcmp+0x16>

ffffffffc02056be <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02056be:	c20d                	beqz	a2,ffffffffc02056e0 <strncmp+0x22>
ffffffffc02056c0:	962e                	add	a2,a2,a1
ffffffffc02056c2:	a031                	j	ffffffffc02056ce <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc02056c4:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02056c6:	00e79a63          	bne	a5,a4,ffffffffc02056da <strncmp+0x1c>
ffffffffc02056ca:	00b60b63          	beq	a2,a1,ffffffffc02056e0 <strncmp+0x22>
ffffffffc02056ce:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc02056d2:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02056d4:	fff5c703          	lbu	a4,-1(a1)
ffffffffc02056d8:	f7f5                	bnez	a5,ffffffffc02056c4 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02056da:	40e7853b          	subw	a0,a5,a4
}
ffffffffc02056de:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02056e0:	4501                	li	a0,0
ffffffffc02056e2:	8082                	ret

ffffffffc02056e4 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc02056e4:	00054783          	lbu	a5,0(a0)
ffffffffc02056e8:	c799                	beqz	a5,ffffffffc02056f6 <strchr+0x12>
        if (*s == c) {
ffffffffc02056ea:	00f58763          	beq	a1,a5,ffffffffc02056f8 <strchr+0x14>
    while (*s != '\0') {
ffffffffc02056ee:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc02056f2:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc02056f4:	fbfd                	bnez	a5,ffffffffc02056ea <strchr+0x6>
    }
    return NULL;
ffffffffc02056f6:	4501                	li	a0,0
}
ffffffffc02056f8:	8082                	ret

ffffffffc02056fa <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc02056fa:	ca01                	beqz	a2,ffffffffc020570a <memset+0x10>
ffffffffc02056fc:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc02056fe:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0205700:	0785                	addi	a5,a5,1
ffffffffc0205702:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0205706:	fec79de3          	bne	a5,a2,ffffffffc0205700 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc020570a:	8082                	ret

ffffffffc020570c <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc020570c:	ca19                	beqz	a2,ffffffffc0205722 <memcpy+0x16>
ffffffffc020570e:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc0205710:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc0205712:	0005c703          	lbu	a4,0(a1)
ffffffffc0205716:	0585                	addi	a1,a1,1
ffffffffc0205718:	0785                	addi	a5,a5,1
ffffffffc020571a:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc020571e:	fec59ae3          	bne	a1,a2,ffffffffc0205712 <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc0205722:	8082                	ret
