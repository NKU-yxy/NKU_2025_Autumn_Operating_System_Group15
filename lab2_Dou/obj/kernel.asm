
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00006297          	auipc	t0,0x6
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0206000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00006297          	auipc	t0,0x6
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0206008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02052b7          	lui	t0,0xc0205
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
ffffffffc020003c:	c0205137          	lui	sp,0xc0205

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	0d828293          	addi	t0,t0,216 # ffffffffc02000d8 <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc020004a:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[];
    cprintf("Special kernel symbols:\n");
ffffffffc020004c:	00002517          	auipc	a0,0x2
ffffffffc0200050:	8cc50513          	addi	a0,a0,-1844 # ffffffffc0201918 <etext+0x6>
void print_kerninfo(void) {
ffffffffc0200054:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200056:	0f6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", (uintptr_t)kern_init);
ffffffffc020005a:	00000597          	auipc	a1,0x0
ffffffffc020005e:	07e58593          	addi	a1,a1,126 # ffffffffc02000d8 <kern_init>
ffffffffc0200062:	00002517          	auipc	a0,0x2
ffffffffc0200066:	8d650513          	addi	a0,a0,-1834 # ffffffffc0201938 <etext+0x26>
ffffffffc020006a:	0e2000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020006e:	00002597          	auipc	a1,0x2
ffffffffc0200072:	8a458593          	addi	a1,a1,-1884 # ffffffffc0201912 <etext>
ffffffffc0200076:	00002517          	auipc	a0,0x2
ffffffffc020007a:	8e250513          	addi	a0,a0,-1822 # ffffffffc0201958 <etext+0x46>
ffffffffc020007e:	0ce000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200082:	00006597          	auipc	a1,0x6
ffffffffc0200086:	f9658593          	addi	a1,a1,-106 # ffffffffc0206018 <free_area>
ffffffffc020008a:	00002517          	auipc	a0,0x2
ffffffffc020008e:	8ee50513          	addi	a0,a0,-1810 # ffffffffc0201978 <etext+0x66>
ffffffffc0200092:	0ba000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc0200096:	00006597          	auipc	a1,0x6
ffffffffc020009a:	1fa58593          	addi	a1,a1,506 # ffffffffc0206290 <end>
ffffffffc020009e:	00002517          	auipc	a0,0x2
ffffffffc02000a2:	8fa50513          	addi	a0,a0,-1798 # ffffffffc0201998 <etext+0x86>
ffffffffc02000a6:	0a6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - (char*)kern_init + 1023) / 1024);
ffffffffc02000aa:	00006597          	auipc	a1,0x6
ffffffffc02000ae:	5e558593          	addi	a1,a1,1509 # ffffffffc020668f <end+0x3ff>
ffffffffc02000b2:	00000797          	auipc	a5,0x0
ffffffffc02000b6:	02678793          	addi	a5,a5,38 # ffffffffc02000d8 <kern_init>
ffffffffc02000ba:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000be:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc02000c2:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000c4:	3ff5f593          	andi	a1,a1,1023
ffffffffc02000c8:	95be                	add	a1,a1,a5
ffffffffc02000ca:	85a9                	srai	a1,a1,0xa
ffffffffc02000cc:	00002517          	auipc	a0,0x2
ffffffffc02000d0:	8ec50513          	addi	a0,a0,-1812 # ffffffffc02019b8 <etext+0xa6>
}
ffffffffc02000d4:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000d6:	a89d                	j	ffffffffc020014c <cprintf>

ffffffffc02000d8 <kern_init>:

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc02000d8:	00006517          	auipc	a0,0x6
ffffffffc02000dc:	f4050513          	addi	a0,a0,-192 # ffffffffc0206018 <free_area>
ffffffffc02000e0:	00006617          	auipc	a2,0x6
ffffffffc02000e4:	1b060613          	addi	a2,a2,432 # ffffffffc0206290 <end>
int kern_init(void) {
ffffffffc02000e8:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc02000ea:	8e09                	sub	a2,a2,a0
ffffffffc02000ec:	4581                	li	a1,0
int kern_init(void) {
ffffffffc02000ee:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc02000f0:	011010ef          	jal	ra,ffffffffc0201900 <memset>
    dtb_init();
ffffffffc02000f4:	12c000ef          	jal	ra,ffffffffc0200220 <dtb_init>
    cons_init();  // init the console
ffffffffc02000f8:	11e000ef          	jal	ra,ffffffffc0200216 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc02000fc:	00002517          	auipc	a0,0x2
ffffffffc0200100:	8ec50513          	addi	a0,a0,-1812 # ffffffffc02019e8 <etext+0xd6>
ffffffffc0200104:	07e000ef          	jal	ra,ffffffffc0200182 <cputs>

    print_kerninfo();
ffffffffc0200108:	f43ff0ef          	jal	ra,ffffffffc020004a <print_kerninfo>

    // grade_backtrace();
    pmm_init();  // init physical memory management
ffffffffc020010c:	3ab000ef          	jal	ra,ffffffffc0200cb6 <pmm_init>

    /* do nothing */
    while (1)
ffffffffc0200110:	a001                	j	ffffffffc0200110 <kern_init+0x38>

ffffffffc0200112 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc0200112:	1141                	addi	sp,sp,-16
ffffffffc0200114:	e022                	sd	s0,0(sp)
ffffffffc0200116:	e406                	sd	ra,8(sp)
ffffffffc0200118:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc020011a:	0fe000ef          	jal	ra,ffffffffc0200218 <cons_putc>
    (*cnt) ++;
ffffffffc020011e:	401c                	lw	a5,0(s0)
}
ffffffffc0200120:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc0200122:	2785                	addiw	a5,a5,1
ffffffffc0200124:	c01c                	sw	a5,0(s0)
}
ffffffffc0200126:	6402                	ld	s0,0(sp)
ffffffffc0200128:	0141                	addi	sp,sp,16
ffffffffc020012a:	8082                	ret

ffffffffc020012c <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc020012c:	1101                	addi	sp,sp,-32
ffffffffc020012e:	862a                	mv	a2,a0
ffffffffc0200130:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200132:	00000517          	auipc	a0,0x0
ffffffffc0200136:	fe050513          	addi	a0,a0,-32 # ffffffffc0200112 <cputch>
ffffffffc020013a:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc020013c:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc020013e:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200140:	3aa010ef          	jal	ra,ffffffffc02014ea <vprintfmt>
    return cnt;
}
ffffffffc0200144:	60e2                	ld	ra,24(sp)
ffffffffc0200146:	4532                	lw	a0,12(sp)
ffffffffc0200148:	6105                	addi	sp,sp,32
ffffffffc020014a:	8082                	ret

ffffffffc020014c <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc020014c:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc020014e:	02810313          	addi	t1,sp,40 # ffffffffc0205028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc0200152:	8e2a                	mv	t3,a0
ffffffffc0200154:	f42e                	sd	a1,40(sp)
ffffffffc0200156:	f832                	sd	a2,48(sp)
ffffffffc0200158:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc020015a:	00000517          	auipc	a0,0x0
ffffffffc020015e:	fb850513          	addi	a0,a0,-72 # ffffffffc0200112 <cputch>
ffffffffc0200162:	004c                	addi	a1,sp,4
ffffffffc0200164:	869a                	mv	a3,t1
ffffffffc0200166:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc0200168:	ec06                	sd	ra,24(sp)
ffffffffc020016a:	e0ba                	sd	a4,64(sp)
ffffffffc020016c:	e4be                	sd	a5,72(sp)
ffffffffc020016e:	e8c2                	sd	a6,80(sp)
ffffffffc0200170:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc0200172:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc0200174:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200176:	374010ef          	jal	ra,ffffffffc02014ea <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc020017a:	60e2                	ld	ra,24(sp)
ffffffffc020017c:	4512                	lw	a0,4(sp)
ffffffffc020017e:	6125                	addi	sp,sp,96
ffffffffc0200180:	8082                	ret

ffffffffc0200182 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200182:	1101                	addi	sp,sp,-32
ffffffffc0200184:	e822                	sd	s0,16(sp)
ffffffffc0200186:	ec06                	sd	ra,24(sp)
ffffffffc0200188:	e426                	sd	s1,8(sp)
ffffffffc020018a:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc020018c:	00054503          	lbu	a0,0(a0)
ffffffffc0200190:	c51d                	beqz	a0,ffffffffc02001be <cputs+0x3c>
ffffffffc0200192:	0405                	addi	s0,s0,1
ffffffffc0200194:	4485                	li	s1,1
ffffffffc0200196:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200198:	080000ef          	jal	ra,ffffffffc0200218 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc020019c:	00044503          	lbu	a0,0(s0)
ffffffffc02001a0:	008487bb          	addw	a5,s1,s0
ffffffffc02001a4:	0405                	addi	s0,s0,1
ffffffffc02001a6:	f96d                	bnez	a0,ffffffffc0200198 <cputs+0x16>
    (*cnt) ++;
ffffffffc02001a8:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001ac:	4529                	li	a0,10
ffffffffc02001ae:	06a000ef          	jal	ra,ffffffffc0200218 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc02001b2:	60e2                	ld	ra,24(sp)
ffffffffc02001b4:	8522                	mv	a0,s0
ffffffffc02001b6:	6442                	ld	s0,16(sp)
ffffffffc02001b8:	64a2                	ld	s1,8(sp)
ffffffffc02001ba:	6105                	addi	sp,sp,32
ffffffffc02001bc:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc02001be:	4405                	li	s0,1
ffffffffc02001c0:	b7f5                	j	ffffffffc02001ac <cputs+0x2a>

ffffffffc02001c2 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02001c2:	00006317          	auipc	t1,0x6
ffffffffc02001c6:	08630313          	addi	t1,t1,134 # ffffffffc0206248 <is_panic>
ffffffffc02001ca:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc02001ce:	715d                	addi	sp,sp,-80
ffffffffc02001d0:	ec06                	sd	ra,24(sp)
ffffffffc02001d2:	e822                	sd	s0,16(sp)
ffffffffc02001d4:	f436                	sd	a3,40(sp)
ffffffffc02001d6:	f83a                	sd	a4,48(sp)
ffffffffc02001d8:	fc3e                	sd	a5,56(sp)
ffffffffc02001da:	e0c2                	sd	a6,64(sp)
ffffffffc02001dc:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02001de:	000e0363          	beqz	t3,ffffffffc02001e4 <__panic+0x22>
    vcprintf(fmt, ap);
    cprintf("\n");
    va_end(ap);

panic_dead:
    while (1) {
ffffffffc02001e2:	a001                	j	ffffffffc02001e2 <__panic+0x20>
    is_panic = 1;
ffffffffc02001e4:	4785                	li	a5,1
ffffffffc02001e6:	00f32023          	sw	a5,0(t1)
    va_start(ap, fmt);
ffffffffc02001ea:	8432                	mv	s0,a2
ffffffffc02001ec:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02001ee:	862e                	mv	a2,a1
ffffffffc02001f0:	85aa                	mv	a1,a0
ffffffffc02001f2:	00002517          	auipc	a0,0x2
ffffffffc02001f6:	81650513          	addi	a0,a0,-2026 # ffffffffc0201a08 <etext+0xf6>
    va_start(ap, fmt);
ffffffffc02001fa:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02001fc:	f51ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200200:	65a2                	ld	a1,8(sp)
ffffffffc0200202:	8522                	mv	a0,s0
ffffffffc0200204:	f29ff0ef          	jal	ra,ffffffffc020012c <vcprintf>
    cprintf("\n");
ffffffffc0200208:	00002517          	auipc	a0,0x2
ffffffffc020020c:	ab050513          	addi	a0,a0,-1360 # ffffffffc0201cb8 <etext+0x3a6>
ffffffffc0200210:	f3dff0ef          	jal	ra,ffffffffc020014c <cprintf>
ffffffffc0200214:	b7f9                	j	ffffffffc02001e2 <__panic+0x20>

ffffffffc0200216 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200216:	8082                	ret

ffffffffc0200218 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc0200218:	0ff57513          	zext.b	a0,a0
ffffffffc020021c:	6500106f          	j	ffffffffc020186c <sbi_console_putchar>

ffffffffc0200220 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200220:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200222:	00002517          	auipc	a0,0x2
ffffffffc0200226:	80650513          	addi	a0,a0,-2042 # ffffffffc0201a28 <etext+0x116>
void dtb_init(void) {
ffffffffc020022a:	fc86                	sd	ra,120(sp)
ffffffffc020022c:	f8a2                	sd	s0,112(sp)
ffffffffc020022e:	e8d2                	sd	s4,80(sp)
ffffffffc0200230:	f4a6                	sd	s1,104(sp)
ffffffffc0200232:	f0ca                	sd	s2,96(sp)
ffffffffc0200234:	ecce                	sd	s3,88(sp)
ffffffffc0200236:	e4d6                	sd	s5,72(sp)
ffffffffc0200238:	e0da                	sd	s6,64(sp)
ffffffffc020023a:	fc5e                	sd	s7,56(sp)
ffffffffc020023c:	f862                	sd	s8,48(sp)
ffffffffc020023e:	f466                	sd	s9,40(sp)
ffffffffc0200240:	f06a                	sd	s10,32(sp)
ffffffffc0200242:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc0200244:	f09ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200248:	00006597          	auipc	a1,0x6
ffffffffc020024c:	db85b583          	ld	a1,-584(a1) # ffffffffc0206000 <boot_hartid>
ffffffffc0200250:	00001517          	auipc	a0,0x1
ffffffffc0200254:	7e850513          	addi	a0,a0,2024 # ffffffffc0201a38 <etext+0x126>
ffffffffc0200258:	ef5ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020025c:	00006417          	auipc	s0,0x6
ffffffffc0200260:	dac40413          	addi	s0,s0,-596 # ffffffffc0206008 <boot_dtb>
ffffffffc0200264:	600c                	ld	a1,0(s0)
ffffffffc0200266:	00001517          	auipc	a0,0x1
ffffffffc020026a:	7e250513          	addi	a0,a0,2018 # ffffffffc0201a48 <etext+0x136>
ffffffffc020026e:	edfff0ef          	jal	ra,ffffffffc020014c <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200272:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200276:	00001517          	auipc	a0,0x1
ffffffffc020027a:	7ea50513          	addi	a0,a0,2026 # ffffffffc0201a60 <etext+0x14e>
    if (boot_dtb == 0) {
ffffffffc020027e:	120a0463          	beqz	s4,ffffffffc02003a6 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc0200282:	57f5                	li	a5,-3
ffffffffc0200284:	07fa                	slli	a5,a5,0x1e
ffffffffc0200286:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc020028a:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020028c:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200290:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200292:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200296:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020029a:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020029e:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002a2:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002a6:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002a8:	8ec9                	or	a3,a3,a0
ffffffffc02002aa:	0087979b          	slliw	a5,a5,0x8
ffffffffc02002ae:	1b7d                	addi	s6,s6,-1
ffffffffc02002b0:	0167f7b3          	and	a5,a5,s6
ffffffffc02002b4:	8dd5                	or	a1,a1,a3
ffffffffc02002b6:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc02002b8:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002bc:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc02002be:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed9c5d>
ffffffffc02002c2:	10f59163          	bne	a1,a5,ffffffffc02003c4 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02002c6:	471c                	lw	a5,8(a4)
ffffffffc02002c8:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02002ca:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002cc:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02002d0:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02002d4:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002d8:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002dc:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002e0:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002e4:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002e8:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002ec:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002f0:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002f4:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002f6:	01146433          	or	s0,s0,a7
ffffffffc02002fa:	0086969b          	slliw	a3,a3,0x8
ffffffffc02002fe:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200302:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200304:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200308:	8c49                	or	s0,s0,a0
ffffffffc020030a:	0166f6b3          	and	a3,a3,s6
ffffffffc020030e:	00ca6a33          	or	s4,s4,a2
ffffffffc0200312:	0167f7b3          	and	a5,a5,s6
ffffffffc0200316:	8c55                	or	s0,s0,a3
ffffffffc0200318:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc020031c:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc020031e:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200320:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200322:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200326:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200328:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020032a:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020032e:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200330:	00001917          	auipc	s2,0x1
ffffffffc0200334:	78090913          	addi	s2,s2,1920 # ffffffffc0201ab0 <etext+0x19e>
ffffffffc0200338:	49bd                	li	s3,15
        switch (token) {
ffffffffc020033a:	4d91                	li	s11,4
ffffffffc020033c:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020033e:	00001497          	auipc	s1,0x1
ffffffffc0200342:	76a48493          	addi	s1,s1,1898 # ffffffffc0201aa8 <etext+0x196>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200346:	000a2703          	lw	a4,0(s4)
ffffffffc020034a:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020034e:	0087569b          	srliw	a3,a4,0x8
ffffffffc0200352:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200356:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020035a:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020035e:	0107571b          	srliw	a4,a4,0x10
ffffffffc0200362:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200364:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200368:	0087171b          	slliw	a4,a4,0x8
ffffffffc020036c:	8fd5                	or	a5,a5,a3
ffffffffc020036e:	00eb7733          	and	a4,s6,a4
ffffffffc0200372:	8fd9                	or	a5,a5,a4
ffffffffc0200374:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200376:	09778c63          	beq	a5,s7,ffffffffc020040e <dtb_init+0x1ee>
ffffffffc020037a:	00fbea63          	bltu	s7,a5,ffffffffc020038e <dtb_init+0x16e>
ffffffffc020037e:	07a78663          	beq	a5,s10,ffffffffc02003ea <dtb_init+0x1ca>
ffffffffc0200382:	4709                	li	a4,2
ffffffffc0200384:	00e79763          	bne	a5,a4,ffffffffc0200392 <dtb_init+0x172>
ffffffffc0200388:	4c81                	li	s9,0
ffffffffc020038a:	8a56                	mv	s4,s5
ffffffffc020038c:	bf6d                	j	ffffffffc0200346 <dtb_init+0x126>
ffffffffc020038e:	ffb78ee3          	beq	a5,s11,ffffffffc020038a <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc0200392:	00001517          	auipc	a0,0x1
ffffffffc0200396:	79650513          	addi	a0,a0,1942 # ffffffffc0201b28 <etext+0x216>
ffffffffc020039a:	db3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020039e:	00001517          	auipc	a0,0x1
ffffffffc02003a2:	7c250513          	addi	a0,a0,1986 # ffffffffc0201b60 <etext+0x24e>
}
ffffffffc02003a6:	7446                	ld	s0,112(sp)
ffffffffc02003a8:	70e6                	ld	ra,120(sp)
ffffffffc02003aa:	74a6                	ld	s1,104(sp)
ffffffffc02003ac:	7906                	ld	s2,96(sp)
ffffffffc02003ae:	69e6                	ld	s3,88(sp)
ffffffffc02003b0:	6a46                	ld	s4,80(sp)
ffffffffc02003b2:	6aa6                	ld	s5,72(sp)
ffffffffc02003b4:	6b06                	ld	s6,64(sp)
ffffffffc02003b6:	7be2                	ld	s7,56(sp)
ffffffffc02003b8:	7c42                	ld	s8,48(sp)
ffffffffc02003ba:	7ca2                	ld	s9,40(sp)
ffffffffc02003bc:	7d02                	ld	s10,32(sp)
ffffffffc02003be:	6de2                	ld	s11,24(sp)
ffffffffc02003c0:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02003c2:	b369                	j	ffffffffc020014c <cprintf>
}
ffffffffc02003c4:	7446                	ld	s0,112(sp)
ffffffffc02003c6:	70e6                	ld	ra,120(sp)
ffffffffc02003c8:	74a6                	ld	s1,104(sp)
ffffffffc02003ca:	7906                	ld	s2,96(sp)
ffffffffc02003cc:	69e6                	ld	s3,88(sp)
ffffffffc02003ce:	6a46                	ld	s4,80(sp)
ffffffffc02003d0:	6aa6                	ld	s5,72(sp)
ffffffffc02003d2:	6b06                	ld	s6,64(sp)
ffffffffc02003d4:	7be2                	ld	s7,56(sp)
ffffffffc02003d6:	7c42                	ld	s8,48(sp)
ffffffffc02003d8:	7ca2                	ld	s9,40(sp)
ffffffffc02003da:	7d02                	ld	s10,32(sp)
ffffffffc02003dc:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003de:	00001517          	auipc	a0,0x1
ffffffffc02003e2:	6a250513          	addi	a0,a0,1698 # ffffffffc0201a80 <etext+0x16e>
}
ffffffffc02003e6:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003e8:	b395                	j	ffffffffc020014c <cprintf>
                int name_len = strlen(name);
ffffffffc02003ea:	8556                	mv	a0,s5
ffffffffc02003ec:	49a010ef          	jal	ra,ffffffffc0201886 <strlen>
ffffffffc02003f0:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003f2:	4619                	li	a2,6
ffffffffc02003f4:	85a6                	mv	a1,s1
ffffffffc02003f6:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02003f8:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003fa:	4e0010ef          	jal	ra,ffffffffc02018da <strncmp>
ffffffffc02003fe:	e111                	bnez	a0,ffffffffc0200402 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc0200400:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc0200402:	0a91                	addi	s5,s5,4
ffffffffc0200404:	9ad2                	add	s5,s5,s4
ffffffffc0200406:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc020040a:	8a56                	mv	s4,s5
ffffffffc020040c:	bf2d                	j	ffffffffc0200346 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc020040e:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200412:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200416:	0087d71b          	srliw	a4,a5,0x8
ffffffffc020041a:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020041e:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200422:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200426:	0107d79b          	srliw	a5,a5,0x10
ffffffffc020042a:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020042e:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200432:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200436:	00eaeab3          	or	s5,s5,a4
ffffffffc020043a:	00fb77b3          	and	a5,s6,a5
ffffffffc020043e:	00faeab3          	or	s5,s5,a5
ffffffffc0200442:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200444:	000c9c63          	bnez	s9,ffffffffc020045c <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200448:	1a82                	slli	s5,s5,0x20
ffffffffc020044a:	00368793          	addi	a5,a3,3
ffffffffc020044e:	020ada93          	srli	s5,s5,0x20
ffffffffc0200452:	9abe                	add	s5,s5,a5
ffffffffc0200454:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200458:	8a56                	mv	s4,s5
ffffffffc020045a:	b5f5                	j	ffffffffc0200346 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020045c:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200460:	85ca                	mv	a1,s2
ffffffffc0200462:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200464:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200468:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020046c:	0187971b          	slliw	a4,a5,0x18
ffffffffc0200470:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200474:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200478:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020047a:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020047e:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200482:	8d59                	or	a0,a0,a4
ffffffffc0200484:	00fb77b3          	and	a5,s6,a5
ffffffffc0200488:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc020048a:	1502                	slli	a0,a0,0x20
ffffffffc020048c:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020048e:	9522                	add	a0,a0,s0
ffffffffc0200490:	42c010ef          	jal	ra,ffffffffc02018bc <strcmp>
ffffffffc0200494:	66a2                	ld	a3,8(sp)
ffffffffc0200496:	f94d                	bnez	a0,ffffffffc0200448 <dtb_init+0x228>
ffffffffc0200498:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200448 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020049c:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02004a0:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02004a4:	00001517          	auipc	a0,0x1
ffffffffc02004a8:	61450513          	addi	a0,a0,1556 # ffffffffc0201ab8 <etext+0x1a6>
           fdt32_to_cpu(x >> 32);
ffffffffc02004ac:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004b0:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc02004b4:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004b8:	0187de1b          	srliw	t3,a5,0x18
ffffffffc02004bc:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004c0:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004c4:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004c8:	0187d693          	srli	a3,a5,0x18
ffffffffc02004cc:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02004d0:	0087579b          	srliw	a5,a4,0x8
ffffffffc02004d4:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004d8:	0106561b          	srliw	a2,a2,0x10
ffffffffc02004dc:	010f6f33          	or	t5,t5,a6
ffffffffc02004e0:	0187529b          	srliw	t0,a4,0x18
ffffffffc02004e4:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004e8:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004ec:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02004f4:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02004f8:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004fc:	0107581b          	srliw	a6,a4,0x10
ffffffffc0200500:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200504:	8361                	srli	a4,a4,0x18
ffffffffc0200506:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020050a:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020050e:	01e6e6b3          	or	a3,a3,t5
ffffffffc0200512:	00cb7633          	and	a2,s6,a2
ffffffffc0200516:	0088181b          	slliw	a6,a6,0x8
ffffffffc020051a:	0085959b          	slliw	a1,a1,0x8
ffffffffc020051e:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200522:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200526:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020052a:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020052e:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200532:	011b78b3          	and	a7,s6,a7
ffffffffc0200536:	005eeeb3          	or	t4,t4,t0
ffffffffc020053a:	00c6e733          	or	a4,a3,a2
ffffffffc020053e:	006c6c33          	or	s8,s8,t1
ffffffffc0200542:	010b76b3          	and	a3,s6,a6
ffffffffc0200546:	00bb7b33          	and	s6,s6,a1
ffffffffc020054a:	01d7e7b3          	or	a5,a5,t4
ffffffffc020054e:	016c6b33          	or	s6,s8,s6
ffffffffc0200552:	01146433          	or	s0,s0,a7
ffffffffc0200556:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200558:	1702                	slli	a4,a4,0x20
ffffffffc020055a:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020055c:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020055e:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200560:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200562:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200566:	0167eb33          	or	s6,a5,s6
ffffffffc020056a:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc020056c:	be1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc0200570:	85a2                	mv	a1,s0
ffffffffc0200572:	00001517          	auipc	a0,0x1
ffffffffc0200576:	56650513          	addi	a0,a0,1382 # ffffffffc0201ad8 <etext+0x1c6>
ffffffffc020057a:	bd3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020057e:	014b5613          	srli	a2,s6,0x14
ffffffffc0200582:	85da                	mv	a1,s6
ffffffffc0200584:	00001517          	auipc	a0,0x1
ffffffffc0200588:	56c50513          	addi	a0,a0,1388 # ffffffffc0201af0 <etext+0x1de>
ffffffffc020058c:	bc1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200590:	008b05b3          	add	a1,s6,s0
ffffffffc0200594:	15fd                	addi	a1,a1,-1
ffffffffc0200596:	00001517          	auipc	a0,0x1
ffffffffc020059a:	57a50513          	addi	a0,a0,1402 # ffffffffc0201b10 <etext+0x1fe>
ffffffffc020059e:	bafff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02005a2:	00001517          	auipc	a0,0x1
ffffffffc02005a6:	5be50513          	addi	a0,a0,1470 # ffffffffc0201b60 <etext+0x24e>
        memory_base = mem_base;
ffffffffc02005aa:	00006797          	auipc	a5,0x6
ffffffffc02005ae:	ca87b323          	sd	s0,-858(a5) # ffffffffc0206250 <memory_base>
        memory_size = mem_size;
ffffffffc02005b2:	00006797          	auipc	a5,0x6
ffffffffc02005b6:	cb67b323          	sd	s6,-858(a5) # ffffffffc0206258 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc02005ba:	b3f5                	j	ffffffffc02003a6 <dtb_init+0x186>

ffffffffc02005bc <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc02005bc:	00006517          	auipc	a0,0x6
ffffffffc02005c0:	c9453503          	ld	a0,-876(a0) # ffffffffc0206250 <memory_base>
ffffffffc02005c4:	8082                	ret

ffffffffc02005c6 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
ffffffffc02005c6:	00006517          	auipc	a0,0x6
ffffffffc02005ca:	c9253503          	ld	a0,-878(a0) # ffffffffc0206258 <memory_size>
ffffffffc02005ce:	8082                	ret

ffffffffc02005d0 <buddy_init>:

// ====================== 初始化 ======================

static void
buddy_init(void) {
    for (int i = 0; i < MAX_ORDER; i++) {
ffffffffc02005d0:	00006717          	auipc	a4,0x6
ffffffffc02005d4:	ae870713          	addi	a4,a4,-1304 # ffffffffc02060b8 <free_area+0xa0>
ffffffffc02005d8:	00006797          	auipc	a5,0x6
ffffffffc02005dc:	a4078793          	addi	a5,a5,-1472 # ffffffffc0206018 <free_area>
ffffffffc02005e0:	86ba                	mv	a3,a4
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc02005e2:	e79c                	sd	a5,8(a5)
ffffffffc02005e4:	e39c                	sd	a5,0(a5)
        list_init(&free_area.free_list[i]);
        free_area.nr_free[i] = 0;
ffffffffc02005e6:	00072023          	sw	zero,0(a4)
    for (int i = 0; i < MAX_ORDER; i++) {
ffffffffc02005ea:	07c1                	addi	a5,a5,16
ffffffffc02005ec:	0711                	addi	a4,a4,4
ffffffffc02005ee:	fed79ae3          	bne	a5,a3,ffffffffc02005e2 <buddy_init+0x12>
    }
}
ffffffffc02005f2:	8082                	ret

ffffffffc02005f4 <buddy_nr_free_pages>:
// ====================== 统计 ======================

static size_t
buddy_nr_free_pages(void) {
    size_t total = 0;
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc02005f4:	00006697          	auipc	a3,0x6
ffffffffc02005f8:	ac468693          	addi	a3,a3,-1340 # ffffffffc02060b8 <free_area+0xa0>
ffffffffc02005fc:	4701                	li	a4,0
    size_t total = 0;
ffffffffc02005fe:	4501                	li	a0,0
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc0200600:	4629                	li	a2,10
        total += (free_area.nr_free[i] << i);
ffffffffc0200602:	429c                	lw	a5,0(a3)
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc0200604:	0691                	addi	a3,a3,4
        total += (free_area.nr_free[i] << i);
ffffffffc0200606:	00e797bb          	sllw	a5,a5,a4
ffffffffc020060a:	1782                	slli	a5,a5,0x20
ffffffffc020060c:	9381                	srli	a5,a5,0x20
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc020060e:	2705                	addiw	a4,a4,1
        total += (free_area.nr_free[i] << i);
ffffffffc0200610:	953e                	add	a0,a0,a5
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc0200612:	fec718e3          	bne	a4,a2,ffffffffc0200602 <buddy_nr_free_pages+0xe>
    return total;
}
ffffffffc0200616:	8082                	ret

ffffffffc0200618 <buddy_dump_free_list>:
buddy_dump_free_list(void) {
ffffffffc0200618:	7139                	addi	sp,sp,-64
ffffffffc020061a:	f426                	sd	s1,40(sp)
    cprintf("\n[Buddy] Free list status:\n");
ffffffffc020061c:	00001517          	auipc	a0,0x1
ffffffffc0200620:	55c50513          	addi	a0,a0,1372 # ffffffffc0201b78 <etext+0x266>
ffffffffc0200624:	00006497          	auipc	s1,0x6
ffffffffc0200628:	a9448493          	addi	s1,s1,-1388 # ffffffffc02060b8 <free_area+0xa0>
buddy_dump_free_list(void) {
ffffffffc020062c:	f822                	sd	s0,48(sp)
ffffffffc020062e:	f04a                	sd	s2,32(sp)
ffffffffc0200630:	ec4e                	sd	s3,24(sp)
ffffffffc0200632:	e852                	sd	s4,16(sp)
ffffffffc0200634:	e456                	sd	s5,8(sp)
ffffffffc0200636:	fc06                	sd	ra,56(sp)
    cprintf("\n[Buddy] Free list status:\n");
ffffffffc0200638:	8926                	mv	s2,s1
ffffffffc020063a:	b13ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    for (int i = 0; i < MAX_ORDER; i++) {
ffffffffc020063e:	4401                	li	s0,0
        cprintf("  order %d (block size %d pages): %d blocks\n",
ffffffffc0200640:	4a85                	li	s5,1
ffffffffc0200642:	00001a17          	auipc	s4,0x1
ffffffffc0200646:	556a0a13          	addi	s4,s4,1366 # ffffffffc0201b98 <etext+0x286>
    for (int i = 0; i < MAX_ORDER; i++) {
ffffffffc020064a:	49a9                	li	s3,10
        cprintf("  order %d (block size %d pages): %d blocks\n",
ffffffffc020064c:	00092683          	lw	a3,0(s2)
ffffffffc0200650:	008a963b          	sllw	a2,s5,s0
ffffffffc0200654:	85a2                	mv	a1,s0
ffffffffc0200656:	8552                	mv	a0,s4
    for (int i = 0; i < MAX_ORDER; i++) {
ffffffffc0200658:	2405                	addiw	s0,s0,1
        cprintf("  order %d (block size %d pages): %d blocks\n",
ffffffffc020065a:	af3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    for (int i = 0; i < MAX_ORDER; i++) {
ffffffffc020065e:	0911                	addi	s2,s2,4
ffffffffc0200660:	ff3416e3          	bne	s0,s3,ffffffffc020064c <buddy_dump_free_list+0x34>
    size_t total = 0;
ffffffffc0200664:	4581                	li	a1,0
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc0200666:	4701                	li	a4,0
ffffffffc0200668:	46a9                	li	a3,10
        total += (free_area.nr_free[i] << i);
ffffffffc020066a:	409c                	lw	a5,0(s1)
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc020066c:	0491                	addi	s1,s1,4
        total += (free_area.nr_free[i] << i);
ffffffffc020066e:	00e797bb          	sllw	a5,a5,a4
ffffffffc0200672:	1782                	slli	a5,a5,0x20
ffffffffc0200674:	9381                	srli	a5,a5,0x20
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc0200676:	2705                	addiw	a4,a4,1
        total += (free_area.nr_free[i] << i);
ffffffffc0200678:	95be                	add	a1,a1,a5
    for (int i = 0; i < MAX_ORDER; i++)
ffffffffc020067a:	fed718e3          	bne	a4,a3,ffffffffc020066a <buddy_dump_free_list+0x52>
}
ffffffffc020067e:	7442                	ld	s0,48(sp)
ffffffffc0200680:	70e2                	ld	ra,56(sp)
ffffffffc0200682:	74a2                	ld	s1,40(sp)
ffffffffc0200684:	7902                	ld	s2,32(sp)
ffffffffc0200686:	69e2                	ld	s3,24(sp)
ffffffffc0200688:	6a42                	ld	s4,16(sp)
ffffffffc020068a:	6aa2                	ld	s5,8(sp)
    cprintf("  Total free pages: %d\n\n", buddy_nr_free_pages());
ffffffffc020068c:	00001517          	auipc	a0,0x1
ffffffffc0200690:	53c50513          	addi	a0,a0,1340 # ffffffffc0201bc8 <etext+0x2b6>
}
ffffffffc0200694:	6121                	addi	sp,sp,64
    cprintf("  Total free pages: %d\n\n", buddy_nr_free_pages());
ffffffffc0200696:	bc5d                	j	ffffffffc020014c <cprintf>

ffffffffc0200698 <buddy_check>:

// ====================== 检查 ======================

static void
buddy_check(void) {
ffffffffc0200698:	7139                	addi	sp,sp,-64
    cprintf("========== Buddy System Check ==========\n");
ffffffffc020069a:	00001517          	auipc	a0,0x1
ffffffffc020069e:	54e50513          	addi	a0,a0,1358 # ffffffffc0201be8 <etext+0x2d6>
buddy_check(void) {
ffffffffc02006a2:	fc06                	sd	ra,56(sp)
ffffffffc02006a4:	f822                	sd	s0,48(sp)
ffffffffc02006a6:	ec4e                	sd	s3,24(sp)
ffffffffc02006a8:	e456                	sd	s5,8(sp)
ffffffffc02006aa:	f426                	sd	s1,40(sp)
ffffffffc02006ac:	f04a                	sd	s2,32(sp)
ffffffffc02006ae:	e852                	sd	s4,16(sp)
ffffffffc02006b0:	e05a                	sd	s6,0(sp)
    cprintf("========== Buddy System Check ==========\n");
ffffffffc02006b2:	a9bff0ef          	jal	ra,ffffffffc020014c <cprintf>
    size_t total = nr_free_pages();
ffffffffc02006b6:	5f4000ef          	jal	ra,ffffffffc0200caa <nr_free_pages>
ffffffffc02006ba:	8aaa                	mv	s5,a0
    buddy_dump_free_list();
ffffffffc02006bc:	f5dff0ef          	jal	ra,ffffffffc0200618 <buddy_dump_free_list>

    struct Page *p0 = alloc_pages(1);
ffffffffc02006c0:	4505                	li	a0,1
ffffffffc02006c2:	5d0000ef          	jal	ra,ffffffffc0200c92 <alloc_pages>
ffffffffc02006c6:	842a                	mv	s0,a0
    struct Page *p1 = alloc_pages(2);
ffffffffc02006c8:	4509                	li	a0,2
ffffffffc02006ca:	5c8000ef          	jal	ra,ffffffffc0200c92 <alloc_pages>
ffffffffc02006ce:	89aa                	mv	s3,a0
    struct Page *p2 = alloc_pages(8);
ffffffffc02006d0:	4521                	li	a0,8
ffffffffc02006d2:	5c0000ef          	jal	ra,ffffffffc0200c92 <alloc_pages>

    assert(p0 && p1 && p2);
ffffffffc02006d6:	12040663          	beqz	s0,ffffffffc0200802 <buddy_check+0x16a>
ffffffffc02006da:	12098463          	beqz	s3,ffffffffc0200802 <buddy_check+0x16a>
ffffffffc02006de:	8b2a                	mv	s6,a0
ffffffffc02006e0:	12050163          	beqz	a0,ffffffffc0200802 <buddy_check+0x16a>
    cprintf("[Check] Allocations successful:\n");
ffffffffc02006e4:	00001517          	auipc	a0,0x1
ffffffffc02006e8:	57450513          	addi	a0,a0,1396 # ffffffffc0201c58 <etext+0x346>
ffffffffc02006ec:	a61ff0ef          	jal	ra,ffffffffc020014c <cprintf>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02006f0:	00006a17          	auipc	s4,0x6
ffffffffc02006f4:	b78a0a13          	addi	s4,s4,-1160 # ffffffffc0206268 <pages>
ffffffffc02006f8:	000a3583          	ld	a1,0(s4)
ffffffffc02006fc:	00002917          	auipc	s2,0x2
ffffffffc0200700:	dec93903          	ld	s2,-532(s2) # ffffffffc02024e8 <error_string+0x38>
ffffffffc0200704:	00002497          	auipc	s1,0x2
ffffffffc0200708:	dec4b483          	ld	s1,-532(s1) # ffffffffc02024f0 <nbase>
ffffffffc020070c:	40b405b3          	sub	a1,s0,a1
ffffffffc0200710:	858d                	srai	a1,a1,0x3
ffffffffc0200712:	032585b3          	mul	a1,a1,s2
    cprintf("  p0 = 0x%08lx (1 page)\n", page2pa(p0));
ffffffffc0200716:	00001517          	auipc	a0,0x1
ffffffffc020071a:	56a50513          	addi	a0,a0,1386 # ffffffffc0201c80 <etext+0x36e>
ffffffffc020071e:	95a6                	add	a1,a1,s1
ffffffffc0200720:	05b2                	slli	a1,a1,0xc
ffffffffc0200722:	a2bff0ef          	jal	ra,ffffffffc020014c <cprintf>
ffffffffc0200726:	000a3583          	ld	a1,0(s4)
    cprintf("  p1 = 0x%08lx (2 pages)\n", page2pa(p1));
ffffffffc020072a:	00001517          	auipc	a0,0x1
ffffffffc020072e:	57650513          	addi	a0,a0,1398 # ffffffffc0201ca0 <etext+0x38e>
ffffffffc0200732:	40b985b3          	sub	a1,s3,a1
ffffffffc0200736:	858d                	srai	a1,a1,0x3
ffffffffc0200738:	032585b3          	mul	a1,a1,s2
ffffffffc020073c:	95a6                	add	a1,a1,s1
ffffffffc020073e:	05b2                	slli	a1,a1,0xc
ffffffffc0200740:	a0dff0ef          	jal	ra,ffffffffc020014c <cprintf>
ffffffffc0200744:	000a3583          	ld	a1,0(s4)
    cprintf("  p2 = 0x%08lx (8 pages)\n", page2pa(p2));
ffffffffc0200748:	00001517          	auipc	a0,0x1
ffffffffc020074c:	57850513          	addi	a0,a0,1400 # ffffffffc0201cc0 <etext+0x3ae>
ffffffffc0200750:	40bb05b3          	sub	a1,s6,a1
ffffffffc0200754:	858d                	srai	a1,a1,0x3
ffffffffc0200756:	032585b3          	mul	a1,a1,s2
ffffffffc020075a:	95a6                	add	a1,a1,s1
ffffffffc020075c:	05b2                	slli	a1,a1,0xc
ffffffffc020075e:	9efff0ef          	jal	ra,ffffffffc020014c <cprintf>

    buddy_dump_free_list();
ffffffffc0200762:	eb7ff0ef          	jal	ra,ffffffffc0200618 <buddy_dump_free_list>

    free_pages(p0, 1);
ffffffffc0200766:	4585                	li	a1,1
ffffffffc0200768:	8522                	mv	a0,s0
ffffffffc020076a:	534000ef          	jal	ra,ffffffffc0200c9e <free_pages>
    free_pages(p1, 2);
ffffffffc020076e:	4589                	li	a1,2
ffffffffc0200770:	854e                	mv	a0,s3
ffffffffc0200772:	52c000ef          	jal	ra,ffffffffc0200c9e <free_pages>
    free_pages(p2, 8);
ffffffffc0200776:	45a1                	li	a1,8
ffffffffc0200778:	855a                	mv	a0,s6
ffffffffc020077a:	524000ef          	jal	ra,ffffffffc0200c9e <free_pages>

    cprintf("[Check] Freed all pages.\n");
ffffffffc020077e:	00001517          	auipc	a0,0x1
ffffffffc0200782:	56250513          	addi	a0,a0,1378 # ffffffffc0201ce0 <etext+0x3ce>
ffffffffc0200786:	9c7ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    buddy_dump_free_list();
ffffffffc020078a:	e8fff0ef          	jal	ra,ffffffffc0200618 <buddy_dump_free_list>

    assert(total == nr_free_pages());
ffffffffc020078e:	51c000ef          	jal	ra,ffffffffc0200caa <nr_free_pages>
ffffffffc0200792:	0b551863          	bne	a0,s5,ffffffffc0200842 <buddy_check+0x1aa>
    cprintf("[Check] Free page count restored (%d pages).\n", (int)total);
ffffffffc0200796:	0005059b          	sext.w	a1,a0
ffffffffc020079a:	00001517          	auipc	a0,0x1
ffffffffc020079e:	58650513          	addi	a0,a0,1414 # ffffffffc0201d20 <etext+0x40e>
ffffffffc02007a2:	9abff0ef          	jal	ra,ffffffffc020014c <cprintf>

    struct Page *p3 = alloc_pages(4);
ffffffffc02007a6:	4511                	li	a0,4
ffffffffc02007a8:	4ea000ef          	jal	ra,ffffffffc0200c92 <alloc_pages>
ffffffffc02007ac:	842a                	mv	s0,a0
    assert(p3);
ffffffffc02007ae:	c935                	beqz	a0,ffffffffc0200822 <buddy_check+0x18a>
ffffffffc02007b0:	000a3583          	ld	a1,0(s4)
    cprintf("[Check] Allocated again p3 = 0x%08lx (4 pages)\n", page2pa(p3));
ffffffffc02007b4:	00001517          	auipc	a0,0x1
ffffffffc02007b8:	5a450513          	addi	a0,a0,1444 # ffffffffc0201d58 <etext+0x446>
ffffffffc02007bc:	40b405b3          	sub	a1,s0,a1
ffffffffc02007c0:	858d                	srai	a1,a1,0x3
ffffffffc02007c2:	032585b3          	mul	a1,a1,s2
ffffffffc02007c6:	95a6                	add	a1,a1,s1
ffffffffc02007c8:	05b2                	slli	a1,a1,0xc
ffffffffc02007ca:	983ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    free_pages(p3, 4);
ffffffffc02007ce:	8522                	mv	a0,s0
ffffffffc02007d0:	4591                	li	a1,4
ffffffffc02007d2:	4cc000ef          	jal	ra,ffffffffc0200c9e <free_pages>

    buddy_dump_free_list();
ffffffffc02007d6:	e43ff0ef          	jal	ra,ffffffffc0200618 <buddy_dump_free_list>
    cprintf("Buddy system check passed!\n");
ffffffffc02007da:	00001517          	auipc	a0,0x1
ffffffffc02007de:	5ae50513          	addi	a0,a0,1454 # ffffffffc0201d88 <etext+0x476>
ffffffffc02007e2:	96bff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("========================================\n");
}
ffffffffc02007e6:	7442                	ld	s0,48(sp)
ffffffffc02007e8:	70e2                	ld	ra,56(sp)
ffffffffc02007ea:	74a2                	ld	s1,40(sp)
ffffffffc02007ec:	7902                	ld	s2,32(sp)
ffffffffc02007ee:	69e2                	ld	s3,24(sp)
ffffffffc02007f0:	6a42                	ld	s4,16(sp)
ffffffffc02007f2:	6aa2                	ld	s5,8(sp)
ffffffffc02007f4:	6b02                	ld	s6,0(sp)
    cprintf("========================================\n");
ffffffffc02007f6:	00001517          	auipc	a0,0x1
ffffffffc02007fa:	5b250513          	addi	a0,a0,1458 # ffffffffc0201da8 <etext+0x496>
}
ffffffffc02007fe:	6121                	addi	sp,sp,64
    cprintf("========================================\n");
ffffffffc0200800:	b2b1                	j	ffffffffc020014c <cprintf>
    assert(p0 && p1 && p2);
ffffffffc0200802:	00001697          	auipc	a3,0x1
ffffffffc0200806:	41668693          	addi	a3,a3,1046 # ffffffffc0201c18 <etext+0x306>
ffffffffc020080a:	00001617          	auipc	a2,0x1
ffffffffc020080e:	41e60613          	addi	a2,a2,1054 # ffffffffc0201c28 <etext+0x316>
ffffffffc0200812:	09d00593          	li	a1,157
ffffffffc0200816:	00001517          	auipc	a0,0x1
ffffffffc020081a:	42a50513          	addi	a0,a0,1066 # ffffffffc0201c40 <etext+0x32e>
ffffffffc020081e:	9a5ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p3);
ffffffffc0200822:	00001697          	auipc	a3,0x1
ffffffffc0200826:	52e68693          	addi	a3,a3,1326 # ffffffffc0201d50 <etext+0x43e>
ffffffffc020082a:	00001617          	auipc	a2,0x1
ffffffffc020082e:	3fe60613          	addi	a2,a2,1022 # ffffffffc0201c28 <etext+0x316>
ffffffffc0200832:	0b000593          	li	a1,176
ffffffffc0200836:	00001517          	auipc	a0,0x1
ffffffffc020083a:	40a50513          	addi	a0,a0,1034 # ffffffffc0201c40 <etext+0x32e>
ffffffffc020083e:	985ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(total == nr_free_pages());
ffffffffc0200842:	00001697          	auipc	a3,0x1
ffffffffc0200846:	4be68693          	addi	a3,a3,1214 # ffffffffc0201d00 <etext+0x3ee>
ffffffffc020084a:	00001617          	auipc	a2,0x1
ffffffffc020084e:	3de60613          	addi	a2,a2,990 # ffffffffc0201c28 <etext+0x316>
ffffffffc0200852:	0ac00593          	li	a1,172
ffffffffc0200856:	00001517          	auipc	a0,0x1
ffffffffc020085a:	3ea50513          	addi	a0,a0,1002 # ffffffffc0201c40 <etext+0x32e>
ffffffffc020085e:	965ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200862 <buddy_alloc_pages>:
buddy_alloc_pages(size_t n) {
ffffffffc0200862:	715d                	addi	sp,sp,-80
ffffffffc0200864:	e486                	sd	ra,72(sp)
ffffffffc0200866:	e0a2                	sd	s0,64(sp)
ffffffffc0200868:	fc26                	sd	s1,56(sp)
ffffffffc020086a:	f84a                	sd	s2,48(sp)
ffffffffc020086c:	f44e                	sd	s3,40(sp)
ffffffffc020086e:	f052                	sd	s4,32(sp)
ffffffffc0200870:	ec56                	sd	s5,24(sp)
ffffffffc0200872:	e85a                	sd	s6,16(sp)
ffffffffc0200874:	e45e                	sd	s7,8(sp)
    if (n == 0) return NULL;
ffffffffc0200876:	c105                	beqz	a0,ffffffffc0200896 <buddy_alloc_pages+0x34>
    while ((1U << order) < n && order < MAX_ORDER) order++;
ffffffffc0200878:	4785                	li	a5,1
    int order = 0;
ffffffffc020087a:	4901                	li	s2,0
    while ((1U << order) < n && order < MAX_ORDER) order++;
ffffffffc020087c:	02f50d63          	beq	a0,a5,ffffffffc02008b6 <buddy_alloc_pages+0x54>
ffffffffc0200880:	4705                	li	a4,1
ffffffffc0200882:	46a9                	li	a3,10
ffffffffc0200884:	2905                	addiw	s2,s2,1
ffffffffc0200886:	012717bb          	sllw	a5,a4,s2
ffffffffc020088a:	1782                	slli	a5,a5,0x20
ffffffffc020088c:	9381                	srli	a5,a5,0x20
ffffffffc020088e:	02a7f163          	bgeu	a5,a0,ffffffffc02008b0 <buddy_alloc_pages+0x4e>
ffffffffc0200892:	fed919e3          	bne	s2,a3,ffffffffc0200884 <buddy_alloc_pages+0x22>
    if (n == 0) return NULL;
ffffffffc0200896:	4981                	li	s3,0
}
ffffffffc0200898:	60a6                	ld	ra,72(sp)
ffffffffc020089a:	6406                	ld	s0,64(sp)
ffffffffc020089c:	74e2                	ld	s1,56(sp)
ffffffffc020089e:	7942                	ld	s2,48(sp)
ffffffffc02008a0:	7a02                	ld	s4,32(sp)
ffffffffc02008a2:	6ae2                	ld	s5,24(sp)
ffffffffc02008a4:	6b42                	ld	s6,16(sp)
ffffffffc02008a6:	6ba2                	ld	s7,8(sp)
ffffffffc02008a8:	854e                	mv	a0,s3
ffffffffc02008aa:	79a2                	ld	s3,40(sp)
ffffffffc02008ac:	6161                	addi	sp,sp,80
ffffffffc02008ae:	8082                	ret
    if (order >= MAX_ORDER) return NULL;
ffffffffc02008b0:	47a9                	li	a5,10
ffffffffc02008b2:	fef902e3          	beq	s2,a5,ffffffffc0200896 <buddy_alloc_pages+0x34>
ffffffffc02008b6:	00005717          	auipc	a4,0x5
ffffffffc02008ba:	76270713          	addi	a4,a4,1890 # ffffffffc0206018 <free_area>
ffffffffc02008be:	00491793          	slli	a5,s2,0x4
ffffffffc02008c2:	97ba                	add	a5,a5,a4
 * list_empty - tests whether a list is empty
 * @list:       the list to test.
 * */
static inline bool
list_empty(list_entry_t *list) {
    return list->next == list;
ffffffffc02008c4:	0087bb83          	ld	s7,8(a5)
    int order = 0;
ffffffffc02008c8:	844a                	mv	s0,s2
    while (cur < MAX_ORDER && list_empty(&free_area.free_list[cur]))
ffffffffc02008ca:	46a9                	li	a3,10
ffffffffc02008cc:	00fb9a63          	bne	s7,a5,ffffffffc02008e0 <buddy_alloc_pages+0x7e>
        cur++;
ffffffffc02008d0:	2405                	addiw	s0,s0,1
    while (cur < MAX_ORDER && list_empty(&free_area.free_list[cur]))
ffffffffc02008d2:	07c1                	addi	a5,a5,16
ffffffffc02008d4:	fcd401e3          	beq	s0,a3,ffffffffc0200896 <buddy_alloc_pages+0x34>
ffffffffc02008d8:	0087bb83          	ld	s7,8(a5)
ffffffffc02008dc:	fefb8ae3          	beq	s7,a5,ffffffffc02008d0 <buddy_alloc_pages+0x6e>
    free_area.nr_free[cur]--;
ffffffffc02008e0:	02840793          	addi	a5,s0,40
ffffffffc02008e4:	078a                	slli	a5,a5,0x2
    __list_del(listelm->prev, listelm->next);
ffffffffc02008e6:	000bb583          	ld	a1,0(s7)
ffffffffc02008ea:	008bb603          	ld	a2,8(s7)
ffffffffc02008ee:	97ba                	add	a5,a5,a4
ffffffffc02008f0:	4394                	lw	a3,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc02008f2:	e590                	sd	a2,8(a1)
    next->prev = prev;
ffffffffc02008f4:	e20c                	sd	a1,0(a2)
ffffffffc02008f6:	36fd                	addiw	a3,a3,-1
ffffffffc02008f8:	c394                	sw	a3,0(a5)
    struct Page *page = le2page(le, page_link);
ffffffffc02008fa:	fe8b8993          	addi	s3,s7,-24
    while (cur > order) {
ffffffffc02008fe:	06895863          	bge	s2,s0,ffffffffc020096e <buddy_alloc_pages+0x10c>
ffffffffc0200902:	fff40493          	addi	s1,s0,-1
ffffffffc0200906:	02740b1b          	addiw	s6,s0,39
ffffffffc020090a:	0492                	slli	s1,s1,0x4
ffffffffc020090c:	0b0a                	slli	s6,s6,0x2
ffffffffc020090e:	94ba                	add	s1,s1,a4
ffffffffc0200910:	9b3a                	add	s6,s6,a4
        struct Page *buddy = page + (1U << cur);
ffffffffc0200912:	4a85                	li	s5,1
        cprintf("[Buddy] Split block: order %d -> two order %d\n", cur + 1, cur);
ffffffffc0200914:	00001a17          	auipc	s4,0x1
ffffffffc0200918:	4c4a0a13          	addi	s4,s4,1220 # ffffffffc0201dd8 <etext+0x4c6>
        cur--;
ffffffffc020091c:	fff4069b          	addiw	a3,s0,-1
        struct Page *buddy = page + (1U << cur);
ffffffffc0200920:	00da97bb          	sllw	a5,s5,a3
ffffffffc0200924:	02079713          	slli	a4,a5,0x20
ffffffffc0200928:	9301                	srli	a4,a4,0x20
ffffffffc020092a:	00271793          	slli	a5,a4,0x2
ffffffffc020092e:	97ba                	add	a5,a5,a4
ffffffffc0200930:	078e                	slli	a5,a5,0x3
ffffffffc0200932:	97ce                	add	a5,a5,s3
        SetPageProperty(buddy);
ffffffffc0200934:	6790                	ld	a2,8(a5)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200936:	6488                	ld	a0,8(s1)
        buddy->property = cur;
ffffffffc0200938:	cb94                	sw	a3,16(a5)
        SetPageProperty(buddy);
ffffffffc020093a:	00266613          	ori	a2,a2,2
        free_area.nr_free[cur]++;
ffffffffc020093e:	000b2703          	lw	a4,0(s6) # 10000 <kern_entry-0xffffffffc01f0000>
        SetPageProperty(buddy);
ffffffffc0200942:	e790                	sd	a2,8(a5)
        list_add(&free_area.free_list[cur], &(buddy->page_link));
ffffffffc0200944:	01878613          	addi	a2,a5,24
    prev->next = next->prev = elm;
ffffffffc0200948:	e110                	sd	a2,0(a0)
ffffffffc020094a:	e490                	sd	a2,8(s1)
    elm->prev = prev;
ffffffffc020094c:	ef84                	sd	s1,24(a5)
    elm->next = next;
ffffffffc020094e:	f388                	sd	a0,32(a5)
ffffffffc0200950:	85a2                	mv	a1,s0
        free_area.nr_free[cur]++;
ffffffffc0200952:	0017079b          	addiw	a5,a4,1
        cur--;
ffffffffc0200956:	0006841b          	sext.w	s0,a3
        free_area.nr_free[cur]++;
ffffffffc020095a:	00fb2023          	sw	a5,0(s6)
        cprintf("[Buddy] Split block: order %d -> two order %d\n", cur + 1, cur);
ffffffffc020095e:	8622                	mv	a2,s0
ffffffffc0200960:	8552                	mv	a0,s4
    while (cur > order) {
ffffffffc0200962:	14c1                	addi	s1,s1,-16
        cprintf("[Buddy] Split block: order %d -> two order %d\n", cur + 1, cur);
ffffffffc0200964:	fe8ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    while (cur > order) {
ffffffffc0200968:	1b71                	addi	s6,s6,-4
ffffffffc020096a:	fa8919e3          	bne	s2,s0,ffffffffc020091c <buddy_alloc_pages+0xba>
ffffffffc020096e:	00006697          	auipc	a3,0x6
ffffffffc0200972:	8fa6b683          	ld	a3,-1798(a3) # ffffffffc0206268 <pages>
ffffffffc0200976:	40d986b3          	sub	a3,s3,a3
ffffffffc020097a:	00002797          	auipc	a5,0x2
ffffffffc020097e:	b6e7b783          	ld	a5,-1170(a5) # ffffffffc02024e8 <error_string+0x38>
ffffffffc0200982:	868d                	srai	a3,a3,0x3
ffffffffc0200984:	02f686b3          	mul	a3,a3,a5
    ClearPageProperty(page);
ffffffffc0200988:	ff0bb783          	ld	a5,-16(s7)
    cprintf("[Buddy] Alloc %d pages (order %d) @ 0x%08lx\n", (1 << order), order, pa);
ffffffffc020098c:	4585                	li	a1,1
ffffffffc020098e:	864a                	mv	a2,s2
    ClearPageProperty(page);
ffffffffc0200990:	9bf5                	andi	a5,a5,-3
ffffffffc0200992:	fefbb823          	sd	a5,-16(s7)
ffffffffc0200996:	00002797          	auipc	a5,0x2
ffffffffc020099a:	b5a7b783          	ld	a5,-1190(a5) # ffffffffc02024f0 <nbase>
    cprintf("[Buddy] Alloc %d pages (order %d) @ 0x%08lx\n", (1 << order), order, pa);
ffffffffc020099e:	012595bb          	sllw	a1,a1,s2
ffffffffc02009a2:	00001517          	auipc	a0,0x1
ffffffffc02009a6:	46650513          	addi	a0,a0,1126 # ffffffffc0201e08 <etext+0x4f6>
ffffffffc02009aa:	96be                	add	a3,a3,a5
ffffffffc02009ac:	06b2                	slli	a3,a3,0xc
ffffffffc02009ae:	f9eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    return page;
ffffffffc02009b2:	b5dd                	j	ffffffffc0200898 <buddy_alloc_pages+0x36>

ffffffffc02009b4 <buddy_free_pages>:
buddy_free_pages(struct Page *base, size_t n) {
ffffffffc02009b4:	7159                	addi	sp,sp,-112
ffffffffc02009b6:	f486                	sd	ra,104(sp)
ffffffffc02009b8:	f0a2                	sd	s0,96(sp)
ffffffffc02009ba:	eca6                	sd	s1,88(sp)
ffffffffc02009bc:	e8ca                	sd	s2,80(sp)
ffffffffc02009be:	e4ce                	sd	s3,72(sp)
ffffffffc02009c0:	e0d2                	sd	s4,64(sp)
ffffffffc02009c2:	fc56                	sd	s5,56(sp)
ffffffffc02009c4:	f85a                	sd	s6,48(sp)
ffffffffc02009c6:	f45e                	sd	s7,40(sp)
ffffffffc02009c8:	f062                	sd	s8,32(sp)
ffffffffc02009ca:	ec66                	sd	s9,24(sp)
ffffffffc02009cc:	e86a                	sd	s10,16(sp)
ffffffffc02009ce:	e46e                	sd	s11,8(sp)
    assert(n > 0);
ffffffffc02009d0:	18058d63          	beqz	a1,ffffffffc0200b6a <buddy_free_pages+0x1b6>
ffffffffc02009d4:	00006417          	auipc	s0,0x6
ffffffffc02009d8:	89440413          	addi	s0,s0,-1900 # ffffffffc0206268 <pages>
ffffffffc02009dc:	6010                	ld	a2,0(s0)
ffffffffc02009de:	00002c97          	auipc	s9,0x2
ffffffffc02009e2:	b0acbc83          	ld	s9,-1270(s9) # ffffffffc02024e8 <error_string+0x38>
ffffffffc02009e6:	00002c17          	auipc	s8,0x2
ffffffffc02009ea:	b0ac3c03          	ld	s8,-1270(s8) # ffffffffc02024f0 <nbase>
ffffffffc02009ee:	40c50633          	sub	a2,a0,a2
ffffffffc02009f2:	860d                	srai	a2,a2,0x3
ffffffffc02009f4:	03960633          	mul	a2,a2,s9
    while ((1U << order) < n) order++;
ffffffffc02009f8:	4785                	li	a5,1
ffffffffc02009fa:	8baa                	mv	s7,a0
    int order = 0;
ffffffffc02009fc:	4a81                	li	s5,0
    while ((1U << order) < n) order++;
ffffffffc02009fe:	4705                	li	a4,1
ffffffffc0200a00:	9662                	add	a2,a2,s8

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
ffffffffc0200a02:	00c61d93          	slli	s11,a2,0xc
ffffffffc0200a06:	00f58c63          	beq	a1,a5,ffffffffc0200a1e <buddy_free_pages+0x6a>
ffffffffc0200a0a:	2a85                	addiw	s5,s5,1
ffffffffc0200a0c:	015717bb          	sllw	a5,a4,s5
ffffffffc0200a10:	1782                	slli	a5,a5,0x20
ffffffffc0200a12:	9381                	srli	a5,a5,0x20
ffffffffc0200a14:	feb7ebe3          	bltu	a5,a1,ffffffffc0200a0a <buddy_free_pages+0x56>
    while (order < MAX_ORDER - 1) {
ffffffffc0200a18:	47a1                	li	a5,8
ffffffffc0200a1a:	1157cf63          	blt	a5,s5,ffffffffc0200b38 <buddy_free_pages+0x184>
ffffffffc0200a1e:	028a8b1b          	addiw	s6,s5,40
ffffffffc0200a22:	00005a17          	auipc	s4,0x5
ffffffffc0200a26:	5f6a0a13          	addi	s4,s4,1526 # ffffffffc0206018 <free_area>
ffffffffc0200a2a:	0b0a                	slli	s6,s6,0x2
ffffffffc0200a2c:	9b52                	add	s6,s6,s4
ffffffffc0200a2e:	00006d17          	auipc	s10,0x6
ffffffffc0200a32:	832d0d13          	addi	s10,s10,-1998 # ffffffffc0206260 <npage>
        uintptr_t buddy_addr = base_pa ^ ((1U << (order + PGSHIFT)));
ffffffffc0200a36:	4485                	li	s1,1
        cprintf("[Buddy] Merge buddy blocks at 0x%08lx and 0x%08lx -> order %d\n",
ffffffffc0200a38:	00001997          	auipc	s3,0x1
ffffffffc0200a3c:	43898993          	addi	s3,s3,1080 # ffffffffc0201e70 <etext+0x55e>
    while (order < MAX_ORDER - 1) {
ffffffffc0200a40:	4925                	li	s2,9
ffffffffc0200a42:	a0a9                	j	ffffffffc0200a8c <buddy_free_pages+0xd8>
        if (!PageProperty(buddy) || buddy->property != order)
ffffffffc0200a44:	4b0c                	lw	a1,16(a4)
ffffffffc0200a46:	08a59063          	bne	a1,a0,ffffffffc0200ac6 <buddy_free_pages+0x112>
    __list_del(listelm->prev, listelm->next);
ffffffffc0200a4a:	6f08                	ld	a0,24(a4)
ffffffffc0200a4c:	730c                	ld	a1,32(a4)
        free_area.nr_free[order]--;
ffffffffc0200a4e:	367d                	addiw	a2,a2,-1
    prev->next = next;
ffffffffc0200a50:	e50c                	sd	a1,8(a0)
    next->prev = prev;
ffffffffc0200a52:	e188                	sd	a0,0(a1)
ffffffffc0200a54:	00cb2023          	sw	a2,0(s6)
        if (buddy < base) base = buddy;
ffffffffc0200a58:	01777363          	bgeu	a4,s7,ffffffffc0200a5e <buddy_free_pages+0xaa>
ffffffffc0200a5c:	8bba                	mv	s7,a4
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200a5e:	40db8633          	sub	a2,s7,a3
ffffffffc0200a62:	860d                	srai	a2,a2,0x3
ffffffffc0200a64:	03960633          	mul	a2,a2,s9
ffffffffc0200a68:	4037d593          	srai	a1,a5,0x3
        cprintf("[Buddy] Merge buddy blocks at 0x%08lx and 0x%08lx -> order %d\n",
ffffffffc0200a6c:	2a85                	addiw	s5,s5,1
ffffffffc0200a6e:	86d6                	mv	a3,s5
ffffffffc0200a70:	854e                	mv	a0,s3
    while (order < MAX_ORDER - 1) {
ffffffffc0200a72:	0b11                	addi	s6,s6,4
ffffffffc0200a74:	039585b3          	mul	a1,a1,s9
ffffffffc0200a78:	9662                	add	a2,a2,s8
    return page2ppn(page) << PGSHIFT;
ffffffffc0200a7a:	00c61d93          	slli	s11,a2,0xc
        cprintf("[Buddy] Merge buddy blocks at 0x%08lx and 0x%08lx -> order %d\n",
ffffffffc0200a7e:	866e                	mv	a2,s11
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200a80:	95e2                	add	a1,a1,s8
ffffffffc0200a82:	05b2                	slli	a1,a1,0xc
ffffffffc0200a84:	ec8ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    while (order < MAX_ORDER - 1) {
ffffffffc0200a88:	0b2a8463          	beq	s5,s2,ffffffffc0200b30 <buddy_free_pages+0x17c>
        uintptr_t buddy_addr = base_pa ^ ((1U << (order + PGSHIFT)));
ffffffffc0200a8c:	00ca879b          	addiw	a5,s5,12
ffffffffc0200a90:	00f497bb          	sllw	a5,s1,a5
ffffffffc0200a94:	1782                	slli	a5,a5,0x20
ffffffffc0200a96:	9381                	srli	a5,a5,0x20
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc0200a98:	000d3703          	ld	a4,0(s10)
ffffffffc0200a9c:	01b7c7b3          	xor	a5,a5,s11
ffffffffc0200aa0:	83b1                	srli	a5,a5,0xc
ffffffffc0200aa2:	000a851b          	sext.w	a0,s5
ffffffffc0200aa6:	0ae7f663          	bgeu	a5,a4,ffffffffc0200b52 <buddy_free_pages+0x19e>
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0200aaa:	418787b3          	sub	a5,a5,s8
ffffffffc0200aae:	00279713          	slli	a4,a5,0x2
ffffffffc0200ab2:	6014                	ld	a3,0(s0)
ffffffffc0200ab4:	97ba                	add	a5,a5,a4
ffffffffc0200ab6:	078e                	slli	a5,a5,0x3
ffffffffc0200ab8:	00f68733          	add	a4,a3,a5
        if (!PageProperty(buddy) || buddy->property != order)
ffffffffc0200abc:	670c                	ld	a1,8(a4)
        free_area.nr_free[order]--;
ffffffffc0200abe:	000b2603          	lw	a2,0(s6)
        if (!PageProperty(buddy) || buddy->property != order)
ffffffffc0200ac2:	8989                	andi	a1,a1,2
ffffffffc0200ac4:	f1c1                	bnez	a1,ffffffffc0200a44 <buddy_free_pages+0x90>
ffffffffc0200ac6:	028a8713          	addi	a4,s5,40
    SetPageProperty(base);
ffffffffc0200aca:	008bb683          	ld	a3,8(s7)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200ace:	004a9793          	slli	a5,s5,0x4
ffffffffc0200ad2:	97d2                	add	a5,a5,s4
ffffffffc0200ad4:	678c                	ld	a1,8(a5)
ffffffffc0200ad6:	0026e693          	ori	a3,a3,2
    base->property = order;
ffffffffc0200ada:	00aba823          	sw	a0,16(s7)
    SetPageProperty(base);
ffffffffc0200ade:	00dbb423          	sd	a3,8(s7)
    list_add(&free_area.free_list[order], &(base->page_link));
ffffffffc0200ae2:	018b8693          	addi	a3,s7,24
    prev->next = next->prev = elm;
ffffffffc0200ae6:	e194                	sd	a3,0(a1)
ffffffffc0200ae8:	e794                	sd	a3,8(a5)
    free_area.nr_free[order]++;
ffffffffc0200aea:	070a                	slli	a4,a4,0x2
    elm->next = next;
ffffffffc0200aec:	02bbb023          	sd	a1,32(s7)
    elm->prev = prev;
ffffffffc0200af0:	00fbbc23          	sd	a5,24(s7)
}
ffffffffc0200af4:	7406                	ld	s0,96(sp)
    free_area.nr_free[order]++;
ffffffffc0200af6:	9a3a                	add	s4,s4,a4
ffffffffc0200af8:	0016079b          	addiw	a5,a2,1
    cprintf("[Buddy] Free %d pages (order %d) @ 0x%08lx\n", (1 << order), order, base_pa);
ffffffffc0200afc:	4585                	li	a1,1
}
ffffffffc0200afe:	70a6                	ld	ra,104(sp)
ffffffffc0200b00:	64e6                	ld	s1,88(sp)
ffffffffc0200b02:	6946                	ld	s2,80(sp)
ffffffffc0200b04:	69a6                	ld	s3,72(sp)
ffffffffc0200b06:	7b42                	ld	s6,48(sp)
ffffffffc0200b08:	7ba2                	ld	s7,40(sp)
ffffffffc0200b0a:	7c02                	ld	s8,32(sp)
ffffffffc0200b0c:	6ce2                	ld	s9,24(sp)
ffffffffc0200b0e:	6d42                	ld	s10,16(sp)
    free_area.nr_free[order]++;
ffffffffc0200b10:	00fa2023          	sw	a5,0(s4)
    cprintf("[Buddy] Free %d pages (order %d) @ 0x%08lx\n", (1 << order), order, base_pa);
ffffffffc0200b14:	86ee                	mv	a3,s11
}
ffffffffc0200b16:	6a06                	ld	s4,64(sp)
ffffffffc0200b18:	6da2                	ld	s11,8(sp)
    cprintf("[Buddy] Free %d pages (order %d) @ 0x%08lx\n", (1 << order), order, base_pa);
ffffffffc0200b1a:	8656                	mv	a2,s5
ffffffffc0200b1c:	015595bb          	sllw	a1,a1,s5
}
ffffffffc0200b20:	7ae2                	ld	s5,56(sp)
    cprintf("[Buddy] Free %d pages (order %d) @ 0x%08lx\n", (1 << order), order, base_pa);
ffffffffc0200b22:	00001517          	auipc	a0,0x1
ffffffffc0200b26:	38e50513          	addi	a0,a0,910 # ffffffffc0201eb0 <etext+0x59e>
}
ffffffffc0200b2a:	6165                	addi	sp,sp,112
    cprintf("[Buddy] Free %d pages (order %d) @ 0x%08lx\n", (1 << order), order, base_pa);
ffffffffc0200b2c:	e20ff06f          	j	ffffffffc020014c <cprintf>
    free_area.nr_free[order]++;
ffffffffc0200b30:	0c4a2603          	lw	a2,196(s4)
ffffffffc0200b34:	4525                	li	a0,9
ffffffffc0200b36:	bf41                	j	ffffffffc0200ac6 <buddy_free_pages+0x112>
ffffffffc0200b38:	028a8713          	addi	a4,s5,40
ffffffffc0200b3c:	00005a17          	auipc	s4,0x5
ffffffffc0200b40:	4dca0a13          	addi	s4,s4,1244 # ffffffffc0206018 <free_area>
ffffffffc0200b44:	00271793          	slli	a5,a4,0x2
ffffffffc0200b48:	97d2                	add	a5,a5,s4
ffffffffc0200b4a:	4390                	lw	a2,0(a5)
    base->property = order;
ffffffffc0200b4c:	000a851b          	sext.w	a0,s5
ffffffffc0200b50:	bfad                	j	ffffffffc0200aca <buddy_free_pages+0x116>
        panic("pa2page called with invalid pa");
ffffffffc0200b52:	00001617          	auipc	a2,0x1
ffffffffc0200b56:	2ee60613          	addi	a2,a2,750 # ffffffffc0201e40 <etext+0x52e>
ffffffffc0200b5a:	06a00593          	li	a1,106
ffffffffc0200b5e:	00001517          	auipc	a0,0x1
ffffffffc0200b62:	30250513          	addi	a0,a0,770 # ffffffffc0201e60 <etext+0x54e>
ffffffffc0200b66:	e5cff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200b6a:	00001697          	auipc	a3,0x1
ffffffffc0200b6e:	2ce68693          	addi	a3,a3,718 # ffffffffc0201e38 <etext+0x526>
ffffffffc0200b72:	00001617          	auipc	a2,0x1
ffffffffc0200b76:	0b660613          	addi	a2,a2,182 # ffffffffc0201c28 <etext+0x316>
ffffffffc0200b7a:	06500593          	li	a1,101
ffffffffc0200b7e:	00001517          	auipc	a0,0x1
ffffffffc0200b82:	0c250513          	addi	a0,a0,194 # ffffffffc0201c40 <etext+0x32e>
ffffffffc0200b86:	e3cff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200b8a <buddy_init_memmap>:
buddy_init_memmap(struct Page *base, size_t n) {
ffffffffc0200b8a:	1141                	addi	sp,sp,-16
ffffffffc0200b8c:	86ae                	mv	a3,a1
ffffffffc0200b8e:	e406                	sd	ra,8(sp)
ffffffffc0200b90:	00850793          	addi	a5,a0,8
ffffffffc0200b94:	4581                	li	a1,0
    assert(n > 0);
ffffffffc0200b96:	cef1                	beqz	a3,ffffffffc0200c72 <buddy_init_memmap+0xe8>
        assert(PageReserved(p));
ffffffffc0200b98:	6398                	ld	a4,0(a5)
ffffffffc0200b9a:	8b05                	andi	a4,a4,1
ffffffffc0200b9c:	cb5d                	beqz	a4,ffffffffc0200c52 <buddy_init_memmap+0xc8>
        p->flags = 0;
ffffffffc0200b9e:	0007b023          	sd	zero,0(a5)
static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc0200ba2:	fe07ac23          	sw	zero,-8(a5)
    for (size_t i = 0; i < n; i++) {
ffffffffc0200ba6:	0585                	addi	a1,a1,1
ffffffffc0200ba8:	02878793          	addi	a5,a5,40
ffffffffc0200bac:	feb696e3          	bne	a3,a1,ffffffffc0200b98 <buddy_init_memmap+0xe>
ffffffffc0200bb0:	862e                	mv	a2,a1
    size_t offset = 0;
ffffffffc0200bb2:	4301                	li	t1,0
ffffffffc0200bb4:	00005f17          	auipc	t5,0x5
ffffffffc0200bb8:	464f0f13          	addi	t5,t5,1124 # ffffffffc0206018 <free_area>
        while ((1U << order) > n)
ffffffffc0200bbc:	1ff00393          	li	t2,511
ffffffffc0200bc0:	4805                	li	a6,1
        int order = MAX_ORDER - 1;
ffffffffc0200bc2:	47a5                	li	a5,9
        while ((1U << order) > n)
ffffffffc0200bc4:	06c3ef63          	bltu	t2,a2,ffffffffc0200c42 <buddy_init_memmap+0xb8>
            order--;
ffffffffc0200bc8:	37fd                	addiw	a5,a5,-1
        while ((1U << order) > n)
ffffffffc0200bca:	00f8173b          	sllw	a4,a6,a5
ffffffffc0200bce:	1702                	slli	a4,a4,0x20
ffffffffc0200bd0:	9301                	srli	a4,a4,0x20
ffffffffc0200bd2:	fee66be3          	bltu	a2,a4,ffffffffc0200bc8 <buddy_init_memmap+0x3e>
ffffffffc0200bd6:	00479893          	slli	a7,a5,0x4
        page->property = order;
ffffffffc0200bda:	0007829b          	sext.w	t0,a5
ffffffffc0200bde:	8ec6                	mv	t4,a7
        struct Page *page = base + offset;
ffffffffc0200be0:	00231693          	slli	a3,t1,0x2
ffffffffc0200be4:	969a                	add	a3,a3,t1
ffffffffc0200be6:	068e                	slli	a3,a3,0x3
ffffffffc0200be8:	96aa                	add	a3,a3,a0
        SetPageProperty(page);
ffffffffc0200bea:	0086be03          	ld	t3,8(a3)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200bee:	98fa                	add	a7,a7,t5
        free_area.nr_free[order]++;
ffffffffc0200bf0:	02878793          	addi	a5,a5,40
ffffffffc0200bf4:	0088bf83          	ld	t6,8(a7)
ffffffffc0200bf8:	078a                	slli	a5,a5,0x2
ffffffffc0200bfa:	97fa                	add	a5,a5,t5
        SetPageProperty(page);
ffffffffc0200bfc:	002e6e13          	ori	t3,t3,2
        page->property = order;
ffffffffc0200c00:	0056a823          	sw	t0,16(a3)
        SetPageProperty(page);
ffffffffc0200c04:	01c6b423          	sd	t3,8(a3)
        list_add(&free_area.free_list[order], &(page->page_link));
ffffffffc0200c08:	01868293          	addi	t0,a3,24
        free_area.nr_free[order]++;
ffffffffc0200c0c:	0007ae03          	lw	t3,0(a5)
    prev->next = next->prev = elm;
ffffffffc0200c10:	005fb023          	sd	t0,0(t6)
ffffffffc0200c14:	0058b423          	sd	t0,8(a7)
        list_add(&free_area.free_list[order], &(page->page_link));
ffffffffc0200c18:	01df08b3          	add	a7,t5,t4
    elm->next = next;
ffffffffc0200c1c:	03f6b023          	sd	t6,32(a3)
    elm->prev = prev;
ffffffffc0200c20:	0116bc23          	sd	a7,24(a3)
        free_area.nr_free[order]++;
ffffffffc0200c24:	001e069b          	addiw	a3,t3,1
ffffffffc0200c28:	c394                	sw	a3,0(a5)
        n -= (1U << order);
ffffffffc0200c2a:	8e19                	sub	a2,a2,a4
        offset += (1U << order);
ffffffffc0200c2c:	933a                	add	t1,t1,a4
    while (n > 0) {
ffffffffc0200c2e:	fa51                	bnez	a2,ffffffffc0200bc2 <buddy_init_memmap+0x38>
}
ffffffffc0200c30:	60a2                	ld	ra,8(sp)
    cprintf("[Buddy] Initialized memory map: %lu pages (%d orders)\n", (unsigned long)total, MAX_ORDER);
ffffffffc0200c32:	4629                	li	a2,10
ffffffffc0200c34:	00001517          	auipc	a0,0x1
ffffffffc0200c38:	2bc50513          	addi	a0,a0,700 # ffffffffc0201ef0 <etext+0x5de>
}
ffffffffc0200c3c:	0141                	addi	sp,sp,16
    cprintf("[Buddy] Initialized memory map: %lu pages (%d orders)\n", (unsigned long)total, MAX_ORDER);
ffffffffc0200c3e:	d0eff06f          	j	ffffffffc020014c <cprintf>
        while ((1U << order) > n)
ffffffffc0200c42:	09000e93          	li	t4,144
ffffffffc0200c46:	42a5                	li	t0,9
ffffffffc0200c48:	20000713          	li	a4,512
ffffffffc0200c4c:	09000893          	li	a7,144
ffffffffc0200c50:	bf41                	j	ffffffffc0200be0 <buddy_init_memmap+0x56>
        assert(PageReserved(p));
ffffffffc0200c52:	00001697          	auipc	a3,0x1
ffffffffc0200c56:	28e68693          	addi	a3,a3,654 # ffffffffc0201ee0 <etext+0x5ce>
ffffffffc0200c5a:	00001617          	auipc	a2,0x1
ffffffffc0200c5e:	fce60613          	addi	a2,a2,-50 # ffffffffc0201c28 <etext+0x316>
ffffffffc0200c62:	02600593          	li	a1,38
ffffffffc0200c66:	00001517          	auipc	a0,0x1
ffffffffc0200c6a:	fda50513          	addi	a0,a0,-38 # ffffffffc0201c40 <etext+0x32e>
ffffffffc0200c6e:	d54ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200c72:	00001697          	auipc	a3,0x1
ffffffffc0200c76:	1c668693          	addi	a3,a3,454 # ffffffffc0201e38 <etext+0x526>
ffffffffc0200c7a:	00001617          	auipc	a2,0x1
ffffffffc0200c7e:	fae60613          	addi	a2,a2,-82 # ffffffffc0201c28 <etext+0x316>
ffffffffc0200c82:	02300593          	li	a1,35
ffffffffc0200c86:	00001517          	auipc	a0,0x1
ffffffffc0200c8a:	fba50513          	addi	a0,a0,-70 # ffffffffc0201c40 <etext+0x32e>
ffffffffc0200c8e:	d34ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200c92 <alloc_pages>:
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
    return pmm_manager->alloc_pages(n);
ffffffffc0200c92:	00005797          	auipc	a5,0x5
ffffffffc0200c96:	5de7b783          	ld	a5,1502(a5) # ffffffffc0206270 <pmm_manager>
ffffffffc0200c9a:	6f9c                	ld	a5,24(a5)
ffffffffc0200c9c:	8782                	jr	a5

ffffffffc0200c9e <free_pages>:
}

// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    pmm_manager->free_pages(base, n);
ffffffffc0200c9e:	00005797          	auipc	a5,0x5
ffffffffc0200ca2:	5d27b783          	ld	a5,1490(a5) # ffffffffc0206270 <pmm_manager>
ffffffffc0200ca6:	739c                	ld	a5,32(a5)
ffffffffc0200ca8:	8782                	jr	a5

ffffffffc0200caa <nr_free_pages>:
}

// nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE)
// of current free memory
size_t nr_free_pages(void) {
    return pmm_manager->nr_free_pages();
ffffffffc0200caa:	00005797          	auipc	a5,0x5
ffffffffc0200cae:	5c67b783          	ld	a5,1478(a5) # ffffffffc0206270 <pmm_manager>
ffffffffc0200cb2:	779c                	ld	a5,40(a5)
ffffffffc0200cb4:	8782                	jr	a5

ffffffffc0200cb6 <pmm_init>:
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200cb6:	00001797          	auipc	a5,0x1
ffffffffc0200cba:	28a78793          	addi	a5,a5,650 # ffffffffc0201f40 <buddy_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200cbe:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0200cc0:	7179                	addi	sp,sp,-48
ffffffffc0200cc2:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200cc4:	00001517          	auipc	a0,0x1
ffffffffc0200cc8:	2b450513          	addi	a0,a0,692 # ffffffffc0201f78 <buddy_pmm_manager+0x38>
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200ccc:	00005417          	auipc	s0,0x5
ffffffffc0200cd0:	5a440413          	addi	s0,s0,1444 # ffffffffc0206270 <pmm_manager>
void pmm_init(void) {
ffffffffc0200cd4:	f406                	sd	ra,40(sp)
ffffffffc0200cd6:	ec26                	sd	s1,24(sp)
ffffffffc0200cd8:	e44e                	sd	s3,8(sp)
ffffffffc0200cda:	e84a                	sd	s2,16(sp)
ffffffffc0200cdc:	e052                	sd	s4,0(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200cde:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200ce0:	c6cff0ef          	jal	ra,ffffffffc020014c <cprintf>
    pmm_manager->init();
ffffffffc0200ce4:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200ce6:	00005497          	auipc	s1,0x5
ffffffffc0200cea:	5a248493          	addi	s1,s1,1442 # ffffffffc0206288 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200cee:	679c                	ld	a5,8(a5)
ffffffffc0200cf0:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200cf2:	57f5                	li	a5,-3
ffffffffc0200cf4:	07fa                	slli	a5,a5,0x1e
ffffffffc0200cf6:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0200cf8:	8c5ff0ef          	jal	ra,ffffffffc02005bc <get_memory_base>
ffffffffc0200cfc:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0200cfe:	8c9ff0ef          	jal	ra,ffffffffc02005c6 <get_memory_size>
    if (mem_size == 0) {
ffffffffc0200d02:	16050163          	beqz	a0,ffffffffc0200e64 <pmm_init+0x1ae>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200d06:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0200d08:	00001517          	auipc	a0,0x1
ffffffffc0200d0c:	2b850513          	addi	a0,a0,696 # ffffffffc0201fc0 <buddy_pmm_manager+0x80>
ffffffffc0200d10:	c3cff0ef          	jal	ra,ffffffffc020014c <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200d14:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0200d18:	864e                	mv	a2,s3
ffffffffc0200d1a:	fffa0693          	addi	a3,s4,-1
ffffffffc0200d1e:	85ca                	mv	a1,s2
ffffffffc0200d20:	00001517          	auipc	a0,0x1
ffffffffc0200d24:	2b850513          	addi	a0,a0,696 # ffffffffc0201fd8 <buddy_pmm_manager+0x98>
ffffffffc0200d28:	c24ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200d2c:	c80007b7          	lui	a5,0xc8000
ffffffffc0200d30:	8652                	mv	a2,s4
ffffffffc0200d32:	0d47e863          	bltu	a5,s4,ffffffffc0200e02 <pmm_init+0x14c>
ffffffffc0200d36:	00006797          	auipc	a5,0x6
ffffffffc0200d3a:	55978793          	addi	a5,a5,1369 # ffffffffc020728f <end+0xfff>
ffffffffc0200d3e:	757d                	lui	a0,0xfffff
ffffffffc0200d40:	8d7d                	and	a0,a0,a5
ffffffffc0200d42:	8231                	srli	a2,a2,0xc
ffffffffc0200d44:	00005797          	auipc	a5,0x5
ffffffffc0200d48:	50c7be23          	sd	a2,1308(a5) # ffffffffc0206260 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200d4c:	00005797          	auipc	a5,0x5
ffffffffc0200d50:	50a7be23          	sd	a0,1308(a5) # ffffffffc0206268 <pages>
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200d54:	000807b7          	lui	a5,0x80
ffffffffc0200d58:	002005b7          	lui	a1,0x200
ffffffffc0200d5c:	02f60563          	beq	a2,a5,ffffffffc0200d86 <pmm_init+0xd0>
ffffffffc0200d60:	00261593          	slli	a1,a2,0x2
ffffffffc0200d64:	00c586b3          	add	a3,a1,a2
ffffffffc0200d68:	fec007b7          	lui	a5,0xfec00
ffffffffc0200d6c:	97aa                	add	a5,a5,a0
ffffffffc0200d6e:	068e                	slli	a3,a3,0x3
ffffffffc0200d70:	96be                	add	a3,a3,a5
ffffffffc0200d72:	87aa                	mv	a5,a0
        SetPageReserved(pages + i);
ffffffffc0200d74:	6798                	ld	a4,8(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200d76:	02878793          	addi	a5,a5,40 # fffffffffec00028 <end+0x3e9f9d98>
        SetPageReserved(pages + i);
ffffffffc0200d7a:	00176713          	ori	a4,a4,1
ffffffffc0200d7e:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200d82:	fef699e3          	bne	a3,a5,ffffffffc0200d74 <pmm_init+0xbe>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200d86:	95b2                	add	a1,a1,a2
ffffffffc0200d88:	fec006b7          	lui	a3,0xfec00
ffffffffc0200d8c:	96aa                	add	a3,a3,a0
ffffffffc0200d8e:	058e                	slli	a1,a1,0x3
ffffffffc0200d90:	96ae                	add	a3,a3,a1
ffffffffc0200d92:	c02007b7          	lui	a5,0xc0200
ffffffffc0200d96:	0af6eb63          	bltu	a3,a5,ffffffffc0200e4c <pmm_init+0x196>
ffffffffc0200d9a:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0200d9c:	77fd                	lui	a5,0xfffff
ffffffffc0200d9e:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200da2:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc0200da4:	06b6e263          	bltu	a3,a1,ffffffffc0200e08 <pmm_init+0x152>
    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();

    /* initialize simplified SLUB allocator */
    slub_init();
ffffffffc0200da8:	372000ef          	jal	ra,ffffffffc020111a <slub_init>
    slub_check();
ffffffffc0200dac:	4b8000ef          	jal	ra,ffffffffc0201264 <slub_check>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0200db0:	601c                	ld	a5,0(s0)
ffffffffc0200db2:	7b9c                	ld	a5,48(a5)
ffffffffc0200db4:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0200db6:	00001517          	auipc	a0,0x1
ffffffffc0200dba:	27a50513          	addi	a0,a0,634 # ffffffffc0202030 <buddy_pmm_manager+0xf0>
ffffffffc0200dbe:	b8eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0200dc2:	00004597          	auipc	a1,0x4
ffffffffc0200dc6:	23e58593          	addi	a1,a1,574 # ffffffffc0205000 <boot_page_table_sv39>
ffffffffc0200dca:	00005797          	auipc	a5,0x5
ffffffffc0200dce:	4ab7bb23          	sd	a1,1206(a5) # ffffffffc0206280 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200dd2:	c02007b7          	lui	a5,0xc0200
ffffffffc0200dd6:	0af5e363          	bltu	a1,a5,ffffffffc0200e7c <pmm_init+0x1c6>
ffffffffc0200dda:	6090                	ld	a2,0(s1)
}
ffffffffc0200ddc:	7402                	ld	s0,32(sp)
ffffffffc0200dde:	70a2                	ld	ra,40(sp)
ffffffffc0200de0:	64e2                	ld	s1,24(sp)
ffffffffc0200de2:	6942                	ld	s2,16(sp)
ffffffffc0200de4:	69a2                	ld	s3,8(sp)
ffffffffc0200de6:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0200de8:	40c58633          	sub	a2,a1,a2
ffffffffc0200dec:	00005797          	auipc	a5,0x5
ffffffffc0200df0:	48c7b623          	sd	a2,1164(a5) # ffffffffc0206278 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200df4:	00001517          	auipc	a0,0x1
ffffffffc0200df8:	25c50513          	addi	a0,a0,604 # ffffffffc0202050 <buddy_pmm_manager+0x110>
}
ffffffffc0200dfc:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200dfe:	b4eff06f          	j	ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200e02:	c8000637          	lui	a2,0xc8000
ffffffffc0200e06:	bf05                	j	ffffffffc0200d36 <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0200e08:	6705                	lui	a4,0x1
ffffffffc0200e0a:	177d                	addi	a4,a4,-1
ffffffffc0200e0c:	96ba                	add	a3,a3,a4
ffffffffc0200e0e:	8efd                	and	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0200e10:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200e14:	02c7f063          	bgeu	a5,a2,ffffffffc0200e34 <pmm_init+0x17e>
    pmm_manager->init_memmap(base, n);
ffffffffc0200e18:	6010                	ld	a2,0(s0)
    return &pages[PPN(pa) - nbase];
ffffffffc0200e1a:	fff80737          	lui	a4,0xfff80
ffffffffc0200e1e:	973e                	add	a4,a4,a5
ffffffffc0200e20:	00271793          	slli	a5,a4,0x2
ffffffffc0200e24:	97ba                	add	a5,a5,a4
ffffffffc0200e26:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200e28:	8d95                	sub	a1,a1,a3
ffffffffc0200e2a:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc0200e2c:	81b1                	srli	a1,a1,0xc
ffffffffc0200e2e:	953e                	add	a0,a0,a5
ffffffffc0200e30:	9702                	jalr	a4
}
ffffffffc0200e32:	bf9d                	j	ffffffffc0200da8 <pmm_init+0xf2>
        panic("pa2page called with invalid pa");
ffffffffc0200e34:	00001617          	auipc	a2,0x1
ffffffffc0200e38:	00c60613          	addi	a2,a2,12 # ffffffffc0201e40 <etext+0x52e>
ffffffffc0200e3c:	06a00593          	li	a1,106
ffffffffc0200e40:	00001517          	auipc	a0,0x1
ffffffffc0200e44:	02050513          	addi	a0,a0,32 # ffffffffc0201e60 <etext+0x54e>
ffffffffc0200e48:	b7aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200e4c:	00001617          	auipc	a2,0x1
ffffffffc0200e50:	1bc60613          	addi	a2,a2,444 # ffffffffc0202008 <buddy_pmm_manager+0xc8>
ffffffffc0200e54:	06000593          	li	a1,96
ffffffffc0200e58:	00001517          	auipc	a0,0x1
ffffffffc0200e5c:	15850513          	addi	a0,a0,344 # ffffffffc0201fb0 <buddy_pmm_manager+0x70>
ffffffffc0200e60:	b62ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        panic("DTB memory info not available");
ffffffffc0200e64:	00001617          	auipc	a2,0x1
ffffffffc0200e68:	12c60613          	addi	a2,a2,300 # ffffffffc0201f90 <buddy_pmm_manager+0x50>
ffffffffc0200e6c:	04800593          	li	a1,72
ffffffffc0200e70:	00001517          	auipc	a0,0x1
ffffffffc0200e74:	14050513          	addi	a0,a0,320 # ffffffffc0201fb0 <buddy_pmm_manager+0x70>
ffffffffc0200e78:	b4aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200e7c:	86ae                	mv	a3,a1
ffffffffc0200e7e:	00001617          	auipc	a2,0x1
ffffffffc0200e82:	18a60613          	addi	a2,a2,394 # ffffffffc0202008 <buddy_pmm_manager+0xc8>
ffffffffc0200e86:	07f00593          	li	a1,127
ffffffffc0200e8a:	00001517          	auipc	a0,0x1
ffffffffc0200e8e:	12650513          	addi	a0,a0,294 # ffffffffc0201fb0 <buddy_pmm_manager+0x70>
ffffffffc0200e92:	b30ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200e96 <kmalloc.part.0>:
        caches[i].global_free = NULL;
        caches[i].nr_pages = 0;
    }
}

void *kmalloc(size_t size) {
ffffffffc0200e96:	7179                	addi	sp,sp,-48
ffffffffc0200e98:	ec26                	sd	s1,24(sp)
ffffffffc0200e9a:	f406                	sd	ra,40(sp)
ffffffffc0200e9c:	f022                	sd	s0,32(sp)
ffffffffc0200e9e:	e84a                	sd	s2,16(sp)
ffffffffc0200ea0:	e44e                	sd	s3,8(sp)
ffffffffc0200ea2:	e052                	sd	s4,0(sp)
ffffffffc0200ea4:	4721                	li	a4,8
ffffffffc0200ea6:	00001797          	auipc	a5,0x1
ffffffffc0200eaa:	3b278793          	addi	a5,a5,946 # ffffffffc0202258 <bucket_size>
    for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc0200eae:	4481                	li	s1,0
ffffffffc0200eb0:	46a5                	li	a3,9
        if (size <= bucket_size[i]) return i;
ffffffffc0200eb2:	00a77963          	bgeu	a4,a0,ffffffffc0200ec4 <kmalloc.part.0+0x2e>
    for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc0200eb6:	2485                	addiw	s1,s1,1
ffffffffc0200eb8:	07a1                	addi	a5,a5,8
ffffffffc0200eba:	0ed48c63          	beq	s1,a3,ffffffffc0200fb2 <kmalloc.part.0+0x11c>
        if (size <= bucket_size[i]) return i;
ffffffffc0200ebe:	6398                	ld	a4,0(a5)
ffffffffc0200ec0:	fea76be3          	bltu	a4,a0,ffffffffc0200eb6 <kmalloc.part.0+0x20>
    }

    slab_cache_t *c = &caches[b];

    // search existing pages for a free object
    list_entry_t *le = &c->pages;
ffffffffc0200ec4:	00249a13          	slli	s4,s1,0x2
ffffffffc0200ec8:	009a07b3          	add	a5,s4,s1
ffffffffc0200ecc:	078e                	slli	a5,a5,0x3
ffffffffc0200ece:	00005997          	auipc	s3,0x5
ffffffffc0200ed2:	21298993          	addi	s3,s3,530 # ffffffffc02060e0 <caches>
ffffffffc0200ed6:	07a1                	addi	a5,a5,8
ffffffffc0200ed8:	00f98933          	add	s2,s3,a5
ffffffffc0200edc:	844a                	mv	s0,s2
    while ((le = list_next(le)) != &c->pages) {
ffffffffc0200ede:	a019                	j	ffffffffc0200ee4 <kmalloc.part.0+0x4e>
        slab_page_t *sp = to_struct(le, slab_page_t, list);
        if (sp->free) {
ffffffffc0200ee0:	6808                	ld	a0,16(s0)
ffffffffc0200ee2:	e95d                	bnez	a0,ffffffffc0200f98 <kmalloc.part.0+0x102>
    return listelm->next;
ffffffffc0200ee4:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != &c->pages) {
ffffffffc0200ee6:	fe891de3          	bne	s2,s0,ffffffffc0200ee0 <kmalloc.part.0+0x4a>
            return (void *)o;
        }
    }

    // allocate a new page and carve it
    struct Page *p = alloc_pages(1);
ffffffffc0200eea:	4505                	li	a0,1
ffffffffc0200eec:	da7ff0ef          	jal	ra,ffffffffc0200c92 <alloc_pages>
    if (!p) return NULL;
ffffffffc0200ef0:	10050763          	beqz	a0,ffffffffc0200ffe <kmalloc.part.0+0x168>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200ef4:	00005717          	auipc	a4,0x5
ffffffffc0200ef8:	37473703          	ld	a4,884(a4) # ffffffffc0206268 <pages>
ffffffffc0200efc:	40e50733          	sub	a4,a0,a4
ffffffffc0200f00:	00001797          	auipc	a5,0x1
ffffffffc0200f04:	5e87b783          	ld	a5,1512(a5) # ffffffffc02024e8 <error_string+0x38>
ffffffffc0200f08:	870d                	srai	a4,a4,0x3
ffffffffc0200f0a:	02f70733          	mul	a4,a4,a5
    void *pagev = (void *)((uintptr_t)page2pa(p) + va_pa_offset);
    slab_page_init(pagev, c->size);
ffffffffc0200f0e:	009a06b3          	add	a3,s4,s1
ffffffffc0200f12:	068e                	slli	a3,a3,0x3
ffffffffc0200f14:	96ce                	add	a3,a3,s3
ffffffffc0200f16:	628c                	ld	a1,0(a3)
ffffffffc0200f18:	00001797          	auipc	a5,0x1
ffffffffc0200f1c:	5d87b783          	ld	a5,1496(a5) # ffffffffc02024f0 <nbase>
    uintptr_t end = (uintptr_t)page + PGSIZE;
ffffffffc0200f20:	6805                	lui	a6,0x1
    size_t stride = ((obj_size + sizeof(void*) - 1) / sizeof(void*)) * sizeof(void*);
ffffffffc0200f22:	00758613          	addi	a2,a1,7
ffffffffc0200f26:	9a61                	andi	a2,a2,-8
ffffffffc0200f28:	973e                	add	a4,a4,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0200f2a:	0732                	slli	a4,a4,0xc
    void *pagev = (void *)((uintptr_t)page2pa(p) + va_pa_offset);
ffffffffc0200f2c:	00005797          	auipc	a5,0x5
ffffffffc0200f30:	35c7b783          	ld	a5,860(a5) # ffffffffc0206288 <va_pa_offset>
ffffffffc0200f34:	973e                	add	a4,a4,a5
    for (uintptr_t cur = base; cur + stride <= end; cur += stride) {
ffffffffc0200f36:	03060793          	addi	a5,a2,48
    sp->free = NULL;
ffffffffc0200f3a:	00073823          	sd	zero,16(a4)
    sp->obj_size = obj_size;
ffffffffc0200f3e:	ef0c                	sd	a1,24(a4)
    sp->nr_free = 0;
ffffffffc0200f40:	02073023          	sd	zero,32(a4)
    elm->prev = elm->next = elm;
ffffffffc0200f44:	e718                	sd	a4,8(a4)
ffffffffc0200f46:	e318                	sd	a4,0(a4)
    uintptr_t end = (uintptr_t)page + PGSIZE;
ffffffffc0200f48:	983a                	add	a6,a6,a4
    for (uintptr_t cur = base; cur + stride <= end; cur += stride) {
ffffffffc0200f4a:	97ba                	add	a5,a5,a4
ffffffffc0200f4c:	0af86b63          	bltu	a6,a5,ffffffffc0201002 <kmalloc.part.0+0x16c>
ffffffffc0200f50:	4685                	li	a3,1
ffffffffc0200f52:	4501                	li	a0,0
        slab_obj_t *o = (slab_obj_t *)cur;
ffffffffc0200f54:	85aa                	mv	a1,a0
ffffffffc0200f56:	40c78533          	sub	a0,a5,a2
        o->next = sp->free;
ffffffffc0200f5a:	e10c                	sd	a1,0(a0)
    for (uintptr_t cur = base; cur + stride <= end; cur += stride) {
ffffffffc0200f5c:	97b2                	add	a5,a5,a2
ffffffffc0200f5e:	85b6                	mv	a1,a3
ffffffffc0200f60:	0685                	addi	a3,a3,1
ffffffffc0200f62:	fef879e3          	bgeu	a6,a5,ffffffffc0200f54 <kmalloc.part.0+0xbe>
    __list_add(elm, listelm, listelm->next);
ffffffffc0200f66:	009a07b3          	add	a5,s4,s1
ffffffffc0200f6a:	078e                	slli	a5,a5,0x3
ffffffffc0200f6c:	97ce                	add	a5,a5,s3
ffffffffc0200f6e:	6b94                	ld	a3,16(a5)
    sp->capacity = sp->nr_free;
ffffffffc0200f70:	f70c                	sd	a1,40(a4)
    list_add(&c->pages, &sp->list);
    c->nr_pages++;
    // take one object from sp->free
    slab_obj_t *o = sp->free;
    if (o) {
        sp->free = o->next;
ffffffffc0200f72:	6110                	ld	a2,0(a0)
    prev->next = next->prev = elm;
ffffffffc0200f74:	e298                	sd	a4,0(a3)
ffffffffc0200f76:	eb98                	sd	a4,16(a5)
    elm->next = next;
ffffffffc0200f78:	e714                	sd	a3,8(a4)
    elm->prev = prev;
ffffffffc0200f7a:	e300                	sd	s0,0(a4)
    c->nr_pages++;
ffffffffc0200f7c:	5394                	lw	a3,32(a5)
        sp->nr_free--;
ffffffffc0200f7e:	15fd                	addi	a1,a1,-1
    c->nr_pages++;
ffffffffc0200f80:	2685                	addiw	a3,a3,1
ffffffffc0200f82:	d394                	sw	a3,32(a5)
        sp->free = o->next;
ffffffffc0200f84:	eb10                	sd	a2,16(a4)
        sp->nr_free--;
ffffffffc0200f86:	f30c                	sd	a1,32(a4)
        return (void *)o;
    }
    return NULL;
}
ffffffffc0200f88:	70a2                	ld	ra,40(sp)
ffffffffc0200f8a:	7402                	ld	s0,32(sp)
ffffffffc0200f8c:	64e2                	ld	s1,24(sp)
ffffffffc0200f8e:	6942                	ld	s2,16(sp)
ffffffffc0200f90:	69a2                	ld	s3,8(sp)
ffffffffc0200f92:	6a02                	ld	s4,0(sp)
ffffffffc0200f94:	6145                	addi	sp,sp,48
ffffffffc0200f96:	8082                	ret
            sp->nr_free--;
ffffffffc0200f98:	701c                	ld	a5,32(s0)
            sp->free = o->next;
ffffffffc0200f9a:	6118                	ld	a4,0(a0)
}
ffffffffc0200f9c:	70a2                	ld	ra,40(sp)
            sp->nr_free--;
ffffffffc0200f9e:	17fd                	addi	a5,a5,-1
            sp->free = o->next;
ffffffffc0200fa0:	e818                	sd	a4,16(s0)
            sp->nr_free--;
ffffffffc0200fa2:	f01c                	sd	a5,32(s0)
}
ffffffffc0200fa4:	7402                	ld	s0,32(sp)
ffffffffc0200fa6:	64e2                	ld	s1,24(sp)
ffffffffc0200fa8:	6942                	ld	s2,16(sp)
ffffffffc0200faa:	69a2                	ld	s3,8(sp)
ffffffffc0200fac:	6a02                	ld	s4,0(sp)
ffffffffc0200fae:	6145                	addi	sp,sp,48
ffffffffc0200fb0:	8082                	ret
        size_t np = (size + PGSIZE - 1) / PGSIZE;
ffffffffc0200fb2:	6785                	lui	a5,0x1
ffffffffc0200fb4:	17fd                	addi	a5,a5,-1
ffffffffc0200fb6:	953e                	add	a0,a0,a5
        struct Page *p = alloc_pages(np);
ffffffffc0200fb8:	8131                	srli	a0,a0,0xc
ffffffffc0200fba:	cd9ff0ef          	jal	ra,ffffffffc0200c92 <alloc_pages>
        if (!p) return NULL;
ffffffffc0200fbe:	c121                	beqz	a0,ffffffffc0200ffe <kmalloc.part.0+0x168>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200fc0:	00005797          	auipc	a5,0x5
ffffffffc0200fc4:	2a87b783          	ld	a5,680(a5) # ffffffffc0206268 <pages>
ffffffffc0200fc8:	8d1d                	sub	a0,a0,a5
ffffffffc0200fca:	850d                	srai	a0,a0,0x3
ffffffffc0200fcc:	00001797          	auipc	a5,0x1
ffffffffc0200fd0:	51c7b783          	ld	a5,1308(a5) # ffffffffc02024e8 <error_string+0x38>
ffffffffc0200fd4:	02f50533          	mul	a0,a0,a5
}
ffffffffc0200fd8:	70a2                	ld	ra,40(sp)
ffffffffc0200fda:	00001797          	auipc	a5,0x1
ffffffffc0200fde:	5167b783          	ld	a5,1302(a5) # ffffffffc02024f0 <nbase>
ffffffffc0200fe2:	7402                	ld	s0,32(sp)
ffffffffc0200fe4:	64e2                	ld	s1,24(sp)
ffffffffc0200fe6:	6942                	ld	s2,16(sp)
ffffffffc0200fe8:	69a2                	ld	s3,8(sp)
ffffffffc0200fea:	6a02                	ld	s4,0(sp)
ffffffffc0200fec:	953e                	add	a0,a0,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0200fee:	0532                	slli	a0,a0,0xc
        return (void *)page2pa(p) + va_pa_offset; // return kernel virtual addr sim
ffffffffc0200ff0:	00005797          	auipc	a5,0x5
ffffffffc0200ff4:	2987b783          	ld	a5,664(a5) # ffffffffc0206288 <va_pa_offset>
ffffffffc0200ff8:	953e                	add	a0,a0,a5
}
ffffffffc0200ffa:	6145                	addi	sp,sp,48
ffffffffc0200ffc:	8082                	ret
    if (!p) return NULL;
ffffffffc0200ffe:	4501                	li	a0,0
ffffffffc0201000:	b761                	j	ffffffffc0200f88 <kmalloc.part.0+0xf2>
    __list_add(elm, listelm, listelm->next);
ffffffffc0201002:	6a9c                	ld	a5,16(a3)
    sp->capacity = sp->nr_free;
ffffffffc0201004:	02073423          	sd	zero,40(a4)
    return NULL;
ffffffffc0201008:	4501                	li	a0,0
    prev->next = next->prev = elm;
ffffffffc020100a:	e398                	sd	a4,0(a5)
ffffffffc020100c:	ea98                	sd	a4,16(a3)
    elm->next = next;
ffffffffc020100e:	e71c                	sd	a5,8(a4)
    elm->prev = prev;
ffffffffc0201010:	01273023          	sd	s2,0(a4)
    c->nr_pages++;
ffffffffc0201014:	529c                	lw	a5,32(a3)
ffffffffc0201016:	2785                	addiw	a5,a5,1
ffffffffc0201018:	d29c                	sw	a5,32(a3)
    if (o) {
ffffffffc020101a:	b7bd                	j	ffffffffc0200f88 <kmalloc.part.0+0xf2>

ffffffffc020101c <slub_dump_state>:
static void slub_dump_state(const char *tag) {
ffffffffc020101c:	715d                	addi	sp,sp,-80
ffffffffc020101e:	85aa                	mv	a1,a0
    cprintf("-- SLUB STATE: %s --\n", tag);
ffffffffc0201020:	00001517          	auipc	a0,0x1
ffffffffc0201024:	07050513          	addi	a0,a0,112 # ffffffffc0202090 <buddy_pmm_manager+0x150>
static void slub_dump_state(const char *tag) {
ffffffffc0201028:	e0a2                	sd	s0,64(sp)
ffffffffc020102a:	fc26                	sd	s1,56(sp)
ffffffffc020102c:	f84a                	sd	s2,48(sp)
ffffffffc020102e:	f44e                	sd	s3,40(sp)
ffffffffc0201030:	f052                	sd	s4,32(sp)
ffffffffc0201032:	ec56                	sd	s5,24(sp)
ffffffffc0201034:	e85a                	sd	s6,16(sp)
ffffffffc0201036:	e45e                	sd	s7,8(sp)
ffffffffc0201038:	e486                	sd	ra,72(sp)
ffffffffc020103a:	e062                	sd	s8,0(sp)
ffffffffc020103c:	00005417          	auipc	s0,0x5
ffffffffc0201040:	0ac40413          	addi	s0,s0,172 # ffffffffc02060e8 <caches+0x8>
    cprintf("-- SLUB STATE: %s --\n", tag);
ffffffffc0201044:	908ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc0201048:	4b01                	li	s6,0
        cprintf(" cache[%2d] size=%4lu pages=%u\n", i, (unsigned long)c->size, c->nr_pages);
ffffffffc020104a:	00001b97          	auipc	s7,0x1
ffffffffc020104e:	05eb8b93          	addi	s7,s7,94 # ffffffffc02020a8 <buddy_pmm_manager+0x168>
ffffffffc0201052:	00005917          	auipc	s2,0x5
ffffffffc0201056:	23690913          	addi	s2,s2,566 # ffffffffc0206288 <va_pa_offset>
ffffffffc020105a:	00005497          	auipc	s1,0x5
ffffffffc020105e:	20648493          	addi	s1,s1,518 # ffffffffc0206260 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0201062:	00001a97          	auipc	s5,0x1
ffffffffc0201066:	48ea8a93          	addi	s5,s5,1166 # ffffffffc02024f0 <nbase>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc020106a:	00001a17          	auipc	s4,0x1
ffffffffc020106e:	47ea3a03          	ld	s4,1150(s4) # ffffffffc02024e8 <error_string+0x38>
            cprintf("   page pa=0x%08lx obj_size=%lu nr_free=%lu capacity=%lu\n",
ffffffffc0201072:	00001997          	auipc	s3,0x1
ffffffffc0201076:	05698993          	addi	s3,s3,86 # ffffffffc02020c8 <buddy_pmm_manager+0x188>
        cprintf(" cache[%2d] size=%4lu pages=%u\n", i, (unsigned long)c->size, c->nr_pages);
ffffffffc020107a:	4c14                	lw	a3,24(s0)
ffffffffc020107c:	ff843603          	ld	a2,-8(s0)
ffffffffc0201080:	85da                	mv	a1,s6
ffffffffc0201082:	855e                	mv	a0,s7
ffffffffc0201084:	8c8ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    return listelm->next;
ffffffffc0201088:	00843c03          	ld	s8,8(s0)
        while ((le = list_next(le)) != &c->pages) {
ffffffffc020108c:	05840463          	beq	s0,s8,ffffffffc02010d4 <slub_dump_state+0xb8>
            uintptr_t page_pa = page2pa(pa2page((uintptr_t)sp - va_pa_offset));
ffffffffc0201090:	00093583          	ld	a1,0(s2)
    if (PPN(pa) >= npage) {
ffffffffc0201094:	609c                	ld	a5,0(s1)
ffffffffc0201096:	40bc05b3          	sub	a1,s8,a1
ffffffffc020109a:	81b1                	srli	a1,a1,0xc
ffffffffc020109c:	06f5f363          	bgeu	a1,a5,ffffffffc0201102 <slub_dump_state+0xe6>
    return &pages[PPN(pa) - nbase];
ffffffffc02010a0:	000ab803          	ld	a6,0(s5)
            cprintf("   page pa=0x%08lx obj_size=%lu nr_free=%lu capacity=%lu\n",
ffffffffc02010a4:	028c3703          	ld	a4,40(s8)
ffffffffc02010a8:	020c3683          	ld	a3,32(s8)
ffffffffc02010ac:	410587b3          	sub	a5,a1,a6
ffffffffc02010b0:	00279593          	slli	a1,a5,0x2
ffffffffc02010b4:	95be                	add	a1,a1,a5
ffffffffc02010b6:	058e                	slli	a1,a1,0x3
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02010b8:	858d                	srai	a1,a1,0x3
ffffffffc02010ba:	034585b3          	mul	a1,a1,s4
ffffffffc02010be:	018c3603          	ld	a2,24(s8)
ffffffffc02010c2:	854e                	mv	a0,s3
ffffffffc02010c4:	95c2                	add	a1,a1,a6
ffffffffc02010c6:	05b2                	slli	a1,a1,0xc
ffffffffc02010c8:	884ff0ef          	jal	ra,ffffffffc020014c <cprintf>
ffffffffc02010cc:	008c3c03          	ld	s8,8(s8)
        while ((le = list_next(le)) != &c->pages) {
ffffffffc02010d0:	fc8c10e3          	bne	s8,s0,ffffffffc0201090 <slub_dump_state+0x74>
    for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc02010d4:	2b05                	addiw	s6,s6,1
ffffffffc02010d6:	47a5                	li	a5,9
ffffffffc02010d8:	02840413          	addi	s0,s0,40
ffffffffc02010dc:	f8fb1fe3          	bne	s6,a5,ffffffffc020107a <slub_dump_state+0x5e>
}
ffffffffc02010e0:	6406                	ld	s0,64(sp)
ffffffffc02010e2:	60a6                	ld	ra,72(sp)
ffffffffc02010e4:	74e2                	ld	s1,56(sp)
ffffffffc02010e6:	7942                	ld	s2,48(sp)
ffffffffc02010e8:	79a2                	ld	s3,40(sp)
ffffffffc02010ea:	7a02                	ld	s4,32(sp)
ffffffffc02010ec:	6ae2                	ld	s5,24(sp)
ffffffffc02010ee:	6b42                	ld	s6,16(sp)
ffffffffc02010f0:	6ba2                	ld	s7,8(sp)
ffffffffc02010f2:	6c02                	ld	s8,0(sp)
    cprintf("-- END SLUB STATE --\n");
ffffffffc02010f4:	00001517          	auipc	a0,0x1
ffffffffc02010f8:	01450513          	addi	a0,a0,20 # ffffffffc0202108 <buddy_pmm_manager+0x1c8>
}
ffffffffc02010fc:	6161                	addi	sp,sp,80
    cprintf("-- END SLUB STATE --\n");
ffffffffc02010fe:	84eff06f          	j	ffffffffc020014c <cprintf>
        panic("pa2page called with invalid pa");
ffffffffc0201102:	00001617          	auipc	a2,0x1
ffffffffc0201106:	d3e60613          	addi	a2,a2,-706 # ffffffffc0201e40 <etext+0x52e>
ffffffffc020110a:	06a00593          	li	a1,106
ffffffffc020110e:	00001517          	auipc	a0,0x1
ffffffffc0201112:	d5250513          	addi	a0,a0,-686 # ffffffffc0201e60 <etext+0x54e>
ffffffffc0201116:	8acff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc020111a <slub_init>:
    for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc020111a:	00005797          	auipc	a5,0x5
ffffffffc020111e:	fce78793          	addi	a5,a5,-50 # ffffffffc02060e8 <caches+0x8>
ffffffffc0201122:	00001717          	auipc	a4,0x1
ffffffffc0201126:	13670713          	addi	a4,a4,310 # ffffffffc0202258 <bucket_size>
ffffffffc020112a:	00005617          	auipc	a2,0x5
ffffffffc020112e:	12660613          	addi	a2,a2,294 # ffffffffc0206250 <memory_base>
void slub_init(void) {
ffffffffc0201132:	46a1                	li	a3,8
ffffffffc0201134:	a011                	j	ffffffffc0201138 <slub_init+0x1e>
        caches[i].size = bucket_size[i];
ffffffffc0201136:	6314                	ld	a3,0(a4)
ffffffffc0201138:	fed7bc23          	sd	a3,-8(a5)
    elm->prev = elm->next = elm;
ffffffffc020113c:	e79c                	sd	a5,8(a5)
ffffffffc020113e:	e39c                	sd	a5,0(a5)
        caches[i].global_free = NULL;
ffffffffc0201140:	0007b823          	sd	zero,16(a5)
        caches[i].nr_pages = 0;
ffffffffc0201144:	0007ac23          	sw	zero,24(a5)
    for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc0201148:	02878793          	addi	a5,a5,40
ffffffffc020114c:	0721                	addi	a4,a4,8
ffffffffc020114e:	fec794e3          	bne	a5,a2,ffffffffc0201136 <slub_init+0x1c>
}
ffffffffc0201152:	8082                	ret

ffffffffc0201154 <kfree>:

void kfree(void *ptr) {
    if (!ptr) return;
ffffffffc0201154:	c519                	beqz	a0,ffffffffc0201162 <kfree+0xe>
    // map virtual addr to physical addr then to page struct
    uintptr_t v = (uintptr_t)ptr;
    if (v < va_pa_offset) return; // not kernel virtual address
ffffffffc0201156:	00005697          	auipc	a3,0x5
ffffffffc020115a:	1326b683          	ld	a3,306(a3) # ffffffffc0206288 <va_pa_offset>
ffffffffc020115e:	00d57363          	bgeu	a0,a3,ffffffffc0201164 <kfree+0x10>
ffffffffc0201162:	8082                	ret
    uintptr_t pa = v - va_pa_offset;
ffffffffc0201164:	40d50733          	sub	a4,a0,a3
    if (PPN(pa) >= npage) {
ffffffffc0201168:	8331                	srli	a4,a4,0xc
ffffffffc020116a:	00005797          	auipc	a5,0x5
ffffffffc020116e:	0f67b783          	ld	a5,246(a5) # ffffffffc0206260 <npage>
ffffffffc0201172:	0cf77b63          	bgeu	a4,a5,ffffffffc0201248 <kfree+0xf4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201176:	00001597          	auipc	a1,0x1
ffffffffc020117a:	37a5b583          	ld	a1,890(a1) # ffffffffc02024f0 <nbase>
ffffffffc020117e:	8f0d                	sub	a4,a4,a1
ffffffffc0201180:	00271613          	slli	a2,a4,0x2
ffffffffc0201184:	9732                	add	a4,a4,a2
ffffffffc0201186:	00371613          	slli	a2,a4,0x3
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc020118a:	40365793          	srai	a5,a2,0x3
ffffffffc020118e:	00001717          	auipc	a4,0x1
ffffffffc0201192:	35a73703          	ld	a4,858(a4) # ffffffffc02024e8 <error_string+0x38>
ffffffffc0201196:	02e787b3          	mul	a5,a5,a4
ffffffffc020119a:	97ae                	add	a5,a5,a1
    return page2ppn(page) << PGSHIFT;
ffffffffc020119c:	07b2                	slli	a5,a5,0xc
    struct Page *p = pa2page(pa);
    // page virtual base
    void *pagev = (void *)((uintptr_t)page2pa(p) + va_pa_offset);
ffffffffc020119e:	97b6                	add	a5,a5,a3
    slab_page_t *sp = (slab_page_t *)pagev;
    // validate obj_size
    if (sp->obj_size == 0) return; // not a slab page
ffffffffc02011a0:	6f94                	ld	a3,24(a5)
ffffffffc02011a2:	d2e1                	beqz	a3,ffffffffc0201162 <kfree+0xe>
    // ensure ptr lies within object region of the slab page
    uintptr_t obj_start = (uintptr_t)pagev + sizeof(slab_page_t);
ffffffffc02011a4:	03078713          	addi	a4,a5,48
    uintptr_t obj_end = (uintptr_t)pagev + PGSIZE;
    if ((uintptr_t)ptr < obj_start || (uintptr_t)ptr >= obj_end) {
ffffffffc02011a8:	fae56de3          	bltu	a0,a4,ffffffffc0201162 <kfree+0xe>
    uintptr_t obj_end = (uintptr_t)pagev + PGSIZE;
ffffffffc02011ac:	6705                	lui	a4,0x1
ffffffffc02011ae:	973e                	add	a4,a4,a5
    if ((uintptr_t)ptr < obj_start || (uintptr_t)ptr >= obj_end) {
ffffffffc02011b0:	fae579e3          	bgeu	a0,a4,ffffffffc0201162 <kfree+0xe>
        // not inside object region
        return;
    }
    // detect double free: traverse free list in this page and see if ptr already present
    slab_obj_t *it = sp->free;
ffffffffc02011b4:	6b8c                	ld	a1,16(a5)
    while (it) {
ffffffffc02011b6:	c989                	beqz	a1,ffffffffc02011c8 <kfree+0x74>
        if ((void *)it == ptr) {
ffffffffc02011b8:	06b50563          	beq	a0,a1,ffffffffc0201222 <kfree+0xce>
ffffffffc02011bc:	872e                	mv	a4,a1
ffffffffc02011be:	a019                	j	ffffffffc02011c4 <kfree+0x70>
ffffffffc02011c0:	06e50163          	beq	a0,a4,ffffffffc0201222 <kfree+0xce>
            cprintf("slub kfree: double free detected %p\n", ptr);
            return;
        }
        it = it->next;
ffffffffc02011c4:	6318                	ld	a4,0(a4)
    while (it) {
ffffffffc02011c6:	ff6d                	bnez	a4,ffffffffc02011c0 <kfree+0x6c>
    }
    // push back into page free list
    slab_obj_t *o = (slab_obj_t *)ptr;
    o->next = sp->free;
    sp->free = o;
    sp->nr_free++;
ffffffffc02011c8:	7398                	ld	a4,32(a5)

    // if page is completely free, remove and free the page
    if (sp->nr_free >= sp->capacity) {
ffffffffc02011ca:	0287b803          	ld	a6,40(a5)
    return &pages[PPN(pa) - nbase];
ffffffffc02011ce:	00005e17          	auipc	t3,0x5
ffffffffc02011d2:	09ae3e03          	ld	t3,154(t3) # ffffffffc0206268 <pages>
    sp->nr_free++;
ffffffffc02011d6:	0705                	addi	a4,a4,1
    o->next = sp->free;
ffffffffc02011d8:	e10c                	sd	a1,0(a0)
    sp->free = o;
ffffffffc02011da:	eb88                	sd	a0,16(a5)
    sp->nr_free++;
ffffffffc02011dc:	f398                	sd	a4,32(a5)
    if (sp->nr_free >= sp->capacity) {
ffffffffc02011de:	f90762e3          	bltu	a4,a6,ffffffffc0201162 <kfree+0xe>
    __list_del(listelm->prev, listelm->next);
ffffffffc02011e2:	6798                	ld	a4,8(a5)
ffffffffc02011e4:	6388                	ld	a0,0(a5)
    prev->next = next;
ffffffffc02011e6:	00005317          	auipc	t1,0x5
ffffffffc02011ea:	efa30313          	addi	t1,t1,-262 # ffffffffc02060e0 <caches>
ffffffffc02011ee:	859a                	mv	a1,t1
ffffffffc02011f0:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc02011f2:	e308                	sd	a0,0(a4)
        list_del(&sp->list);
        // decrement cache page count
        // find cache by obj_size
        for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc02011f4:	48a5                	li	a7,9
ffffffffc02011f6:	4701                	li	a4,0
            if (caches[i].size == sp->obj_size) {
ffffffffc02011f8:	0005b803          	ld	a6,0(a1)
ffffffffc02011fc:	03068a63          	beq	a3,a6,ffffffffc0201230 <kfree+0xdc>
        for (int i = 0; i < MAX_BUCKET; i++) {
ffffffffc0201200:	2705                	addiw	a4,a4,1
ffffffffc0201202:	02858593          	addi	a1,a1,40
ffffffffc0201206:	ff1719e3          	bne	a4,a7,ffffffffc02011f8 <kfree+0xa4>
                if (caches[i].nr_pages > 0) caches[i].nr_pages--;
                break;
            }
        }
        // clear header to avoid double free confusion
        sp->free = NULL;
ffffffffc020120a:	0007b823          	sd	zero,16(a5)
        sp->obj_size = 0;
ffffffffc020120e:	0007bc23          	sd	zero,24(a5)
        sp->nr_free = 0;
ffffffffc0201212:	0207b023          	sd	zero,32(a5)
        sp->capacity = 0;
ffffffffc0201216:	0207b423          	sd	zero,40(a5)
        free_pages(p, 1);
ffffffffc020121a:	4585                	li	a1,1
ffffffffc020121c:	00ce0533          	add	a0,t3,a2
ffffffffc0201220:	bcbd                	j	ffffffffc0200c9e <free_pages>
            cprintf("slub kfree: double free detected %p\n", ptr);
ffffffffc0201222:	85aa                	mv	a1,a0
ffffffffc0201224:	00001517          	auipc	a0,0x1
ffffffffc0201228:	efc50513          	addi	a0,a0,-260 # ffffffffc0202120 <buddy_pmm_manager+0x1e0>
ffffffffc020122c:	f21fe06f          	j	ffffffffc020014c <cprintf>
                if (caches[i].nr_pages > 0) caches[i].nr_pages--;
ffffffffc0201230:	00271693          	slli	a3,a4,0x2
ffffffffc0201234:	9736                	add	a4,a4,a3
ffffffffc0201236:	070e                	slli	a4,a4,0x3
ffffffffc0201238:	933a                	add	t1,t1,a4
ffffffffc020123a:	02032703          	lw	a4,32(t1)
ffffffffc020123e:	d771                	beqz	a4,ffffffffc020120a <kfree+0xb6>
ffffffffc0201240:	377d                	addiw	a4,a4,-1
ffffffffc0201242:	02e32023          	sw	a4,32(t1)
ffffffffc0201246:	b7d1                	j	ffffffffc020120a <kfree+0xb6>
void kfree(void *ptr) {
ffffffffc0201248:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc020124a:	00001617          	auipc	a2,0x1
ffffffffc020124e:	bf660613          	addi	a2,a2,-1034 # ffffffffc0201e40 <etext+0x52e>
ffffffffc0201252:	06a00593          	li	a1,106
ffffffffc0201256:	00001517          	auipc	a0,0x1
ffffffffc020125a:	c0a50513          	addi	a0,a0,-1014 # ffffffffc0201e60 <etext+0x54e>
ffffffffc020125e:	e406                	sd	ra,8(sp)
ffffffffc0201260:	f63fe0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0201264 <slub_check>:
    }
}

void slub_check(void) {
ffffffffc0201264:	9c010113          	addi	sp,sp,-1600
    cprintf("slub_check: start\n");
ffffffffc0201268:	00001517          	auipc	a0,0x1
ffffffffc020126c:	ee050513          	addi	a0,a0,-288 # ffffffffc0202148 <buddy_pmm_manager+0x208>
void slub_check(void) {
ffffffffc0201270:	62113c23          	sd	ra,1592(sp)
ffffffffc0201274:	62913423          	sd	s1,1576(sp)
ffffffffc0201278:	63213023          	sd	s2,1568(sp)
ffffffffc020127c:	61313c23          	sd	s3,1560(sp)
ffffffffc0201280:	61413823          	sd	s4,1552(sp)
ffffffffc0201284:	61513423          	sd	s5,1544(sp)
ffffffffc0201288:	61613023          	sd	s6,1536(sp)
ffffffffc020128c:	62813823          	sd	s0,1584(sp)
    cprintf("slub_check: start\n");
ffffffffc0201290:	ebdfe0ef          	jal	ra,ffffffffc020014c <cprintf>
    size_t before = nr_free_pages();
ffffffffc0201294:	a17ff0ef          	jal	ra,ffffffffc0200caa <nr_free_pages>
ffffffffc0201298:	892a                	mv	s2,a0

    slub_dump_state("initial");
ffffffffc020129a:	00001517          	auipc	a0,0x1
ffffffffc020129e:	ec650513          	addi	a0,a0,-314 # ffffffffc0202160 <buddy_pmm_manager+0x220>
ffffffffc02012a2:	20010993          	addi	s3,sp,512
ffffffffc02012a6:	d77ff0ef          	jal	ra,ffffffffc020101c <slub_dump_state>

    // allocate a batch of objects of various sizes
    void *objs[128];
    int cnt = 0;
ffffffffc02012aa:	4481                	li	s1,0
    for (int i = 0; i < 20; i++) {
        size_t s = 8 + (i % 9) * 16;
ffffffffc02012ac:	4b25                	li	s6,9
        objs[cnt] = kmalloc(s);
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc02012ae:	00001a97          	auipc	s5,0x1
ffffffffc02012b2:	ebaa8a93          	addi	s5,s5,-326 # ffffffffc0202168 <buddy_pmm_manager+0x228>
    for (int i = 0; i < 20; i++) {
ffffffffc02012b6:	4a51                	li	s4,20
        size_t s = 8 + (i % 9) * 16;
ffffffffc02012b8:	0364e43b          	remw	s0,s1,s6
    for (int i = 0; i < 20; i++) {
ffffffffc02012bc:	09a1                	addi	s3,s3,8
        cnt++;
ffffffffc02012be:	2485                	addiw	s1,s1,1
        size_t s = 8 + (i % 9) * 16;
ffffffffc02012c0:	0044141b          	slliw	s0,s0,0x4
ffffffffc02012c4:	2421                	addiw	s0,s0,8
    if (size == 0) return NULL;
ffffffffc02012c6:	8522                	mv	a0,s0
ffffffffc02012c8:	bcfff0ef          	jal	ra,ffffffffc0200e96 <kmalloc.part.0>
ffffffffc02012cc:	862a                	mv	a2,a0
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc02012ce:	85a2                	mv	a1,s0
ffffffffc02012d0:	8556                	mv	a0,s5
        objs[cnt] = kmalloc(s);
ffffffffc02012d2:	fec9bc23          	sd	a2,-8(s3)
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc02012d6:	e77fe0ef          	jal	ra,ffffffffc020014c <cprintf>
    for (int i = 0; i < 20; i++) {
ffffffffc02012da:	fd449fe3          	bne	s1,s4,ffffffffc02012b8 <slub_check+0x54>
ffffffffc02012de:	2a010993          	addi	s3,sp,672
    }
    for (int i = 0; i < 30; i++) {
ffffffffc02012e2:	4481                	li	s1,0
        size_t s = 64 + (i % 6) * 32;
ffffffffc02012e4:	4b19                	li	s6,6
        objs[cnt] = kmalloc(s);
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc02012e6:	00001a97          	auipc	s5,0x1
ffffffffc02012ea:	e82a8a93          	addi	s5,s5,-382 # ffffffffc0202168 <buddy_pmm_manager+0x228>
    for (int i = 0; i < 30; i++) {
ffffffffc02012ee:	4a79                	li	s4,30
        size_t s = 64 + (i % 6) * 32;
ffffffffc02012f0:	0364e43b          	remw	s0,s1,s6
    for (int i = 0; i < 30; i++) {
ffffffffc02012f4:	09a1                	addi	s3,s3,8
ffffffffc02012f6:	2485                	addiw	s1,s1,1
        size_t s = 64 + (i % 6) * 32;
ffffffffc02012f8:	2409                	addiw	s0,s0,2
ffffffffc02012fa:	0054141b          	slliw	s0,s0,0x5
    if (size == 0) return NULL;
ffffffffc02012fe:	8522                	mv	a0,s0
ffffffffc0201300:	b97ff0ef          	jal	ra,ffffffffc0200e96 <kmalloc.part.0>
ffffffffc0201304:	862a                	mv	a2,a0
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc0201306:	85a2                	mv	a1,s0
ffffffffc0201308:	8556                	mv	a0,s5
        objs[cnt] = kmalloc(s);
ffffffffc020130a:	fec9bc23          	sd	a2,-8(s3)
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc020130e:	e3ffe0ef          	jal	ra,ffffffffc020014c <cprintf>
    for (int i = 0; i < 30; i++) {
ffffffffc0201312:	fd449fe3          	bne	s1,s4,ffffffffc02012f0 <slub_check+0x8c>
ffffffffc0201316:	0f00                	addi	s0,sp,912
ffffffffc0201318:	1784                	addi	s1,sp,992
        cnt++;
    }
    for (int i = 0; i < 10; i++) {
        size_t s = 1500;
        objs[cnt] = kmalloc(s); // large near max bucket or larger
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc020131a:	00001997          	auipc	s3,0x1
ffffffffc020131e:	e4e98993          	addi	s3,s3,-434 # ffffffffc0202168 <buddy_pmm_manager+0x228>
    if (size == 0) return NULL;
ffffffffc0201322:	5dc00513          	li	a0,1500
ffffffffc0201326:	b71ff0ef          	jal	ra,ffffffffc0200e96 <kmalloc.part.0>
        objs[cnt] = kmalloc(s); // large near max bucket or larger
ffffffffc020132a:	e008                	sd	a0,0(s0)
ffffffffc020132c:	862a                	mv	a2,a0
    for (int i = 0; i < 10; i++) {
ffffffffc020132e:	0421                	addi	s0,s0,8
        cprintf("slub alloc size=%lu -> %p\n", (unsigned long)s, objs[cnt]);
ffffffffc0201330:	5dc00593          	li	a1,1500
ffffffffc0201334:	854e                	mv	a0,s3
ffffffffc0201336:	e17fe0ef          	jal	ra,ffffffffc020014c <cprintf>
    for (int i = 0; i < 10; i++) {
ffffffffc020133a:	fe9414e3          	bne	s0,s1,ffffffffc0201322 <slub_check+0xbe>
ffffffffc020133e:	041c                	addi	a5,sp,512
        cnt++;
    }

    for (int i = 0; i < cnt; i++) assert(objs[i] != NULL);
ffffffffc0201340:	6398                	ld	a4,0(a5)
ffffffffc0201342:	0e070e63          	beqz	a4,ffffffffc020143e <slub_check+0x1da>
ffffffffc0201346:	07a1                	addi	a5,a5,8
ffffffffc0201348:	fe979ce3          	bne	a5,s1,ffffffffc0201340 <slub_check+0xdc>
ffffffffc020134c:	0400                	addi	s0,sp,512

    // free half of them
    for (int i = 0; i < cnt; i += 2) kfree(objs[i]);
ffffffffc020134e:	6008                	ld	a0,0(s0)
ffffffffc0201350:	0441                	addi	s0,s0,16
ffffffffc0201352:	e03ff0ef          	jal	ra,ffffffffc0201154 <kfree>
ffffffffc0201356:	fe941ce3          	bne	s0,s1,ffffffffc020134e <slub_check+0xea>
    slub_dump_state("after free half");
ffffffffc020135a:	00001517          	auipc	a0,0x1
ffffffffc020135e:	e4e50513          	addi	a0,a0,-434 # ffffffffc02021a8 <buddy_pmm_manager+0x268>
ffffffffc0201362:	840a                	mv	s0,sp
ffffffffc0201364:	cb9ff0ef          	jal	ra,ffffffffc020101c <slub_dump_state>

    // allocate again to check reuse
    void *more[64];
    for (int i = 0; i < 30; i++) more[i] = kmalloc(64);
ffffffffc0201368:	0f010993          	addi	s3,sp,240
    slub_dump_state("after free half");
ffffffffc020136c:	84a2                	mv	s1,s0
    if (size == 0) return NULL;
ffffffffc020136e:	04000513          	li	a0,64
ffffffffc0201372:	b25ff0ef          	jal	ra,ffffffffc0200e96 <kmalloc.part.0>
    for (int i = 0; i < 30; i++) more[i] = kmalloc(64);
ffffffffc0201376:	e088                	sd	a0,0(s1)
ffffffffc0201378:	04a1                	addi	s1,s1,8
ffffffffc020137a:	ff349ae3          	bne	s1,s3,ffffffffc020136e <slub_check+0x10a>
ffffffffc020137e:	84a2                	mv	s1,s0
    for (int i = 0; i < 30; i++) {
        cprintf("slub alloc reuse size=64 -> %p\n", more[i]);
ffffffffc0201380:	00001a97          	auipc	s5,0x1
ffffffffc0201384:	e38a8a93          	addi	s5,s5,-456 # ffffffffc02021b8 <buddy_pmm_manager+0x278>
ffffffffc0201388:	0004ba03          	ld	s4,0(s1)
ffffffffc020138c:	8556                	mv	a0,s5
ffffffffc020138e:	85d2                	mv	a1,s4
ffffffffc0201390:	dbdfe0ef          	jal	ra,ffffffffc020014c <cprintf>
        assert(more[i] != NULL);
ffffffffc0201394:	080a0563          	beqz	s4,ffffffffc020141e <slub_check+0x1ba>
    for (int i = 0; i < 30; i++) {
ffffffffc0201398:	04a1                	addi	s1,s1,8
ffffffffc020139a:	ff3497e3          	bne	s1,s3,ffffffffc0201388 <slub_check+0x124>
ffffffffc020139e:	0424                	addi	s1,sp,520
ffffffffc02013a0:	3e810a13          	addi	s4,sp,1000
    }

    // free remaining
    for (int i = 1; i < cnt; i += 2) kfree(objs[i]);
ffffffffc02013a4:	6088                	ld	a0,0(s1)
ffffffffc02013a6:	04c1                	addi	s1,s1,16
ffffffffc02013a8:	dadff0ef          	jal	ra,ffffffffc0201154 <kfree>
ffffffffc02013ac:	fe9a1ce3          	bne	s4,s1,ffffffffc02013a4 <slub_check+0x140>
    slub_dump_state("after free rest");
ffffffffc02013b0:	00001517          	auipc	a0,0x1
ffffffffc02013b4:	e3850513          	addi	a0,a0,-456 # ffffffffc02021e8 <buddy_pmm_manager+0x2a8>
ffffffffc02013b8:	c65ff0ef          	jal	ra,ffffffffc020101c <slub_dump_state>
    for (int i = 0; i < 30; i++) kfree(more[i]);
ffffffffc02013bc:	6008                	ld	a0,0(s0)
ffffffffc02013be:	0421                	addi	s0,s0,8
ffffffffc02013c0:	d95ff0ef          	jal	ra,ffffffffc0201154 <kfree>
ffffffffc02013c4:	ff341ce3          	bne	s0,s3,ffffffffc02013bc <slub_check+0x158>
    slub_dump_state("after free more");
ffffffffc02013c8:	00001517          	auipc	a0,0x1
ffffffffc02013cc:	e3050513          	addi	a0,a0,-464 # ffffffffc02021f8 <buddy_pmm_manager+0x2b8>
ffffffffc02013d0:	c4dff0ef          	jal	ra,ffffffffc020101c <slub_dump_state>

    // after freeing all, underlying free pages should be restored (if pages were reclaimed)
    size_t after = nr_free_pages();
ffffffffc02013d4:	8d7ff0ef          	jal	ra,ffffffffc0200caa <nr_free_pages>
ffffffffc02013d8:	842a                	mv	s0,a0
    cprintf("slub_check: free pages before=%lu after=%lu\n", (unsigned long)before, (unsigned long)after);
ffffffffc02013da:	862a                	mv	a2,a0
ffffffffc02013dc:	85ca                	mv	a1,s2
ffffffffc02013de:	00001517          	auipc	a0,0x1
ffffffffc02013e2:	e2a50513          	addi	a0,a0,-470 # ffffffffc0202208 <buddy_pmm_manager+0x2c8>
ffffffffc02013e6:	d67fe0ef          	jal	ra,ffffffffc020014c <cprintf>
    // allow after >= before depending on allocator behavior
    assert(after >= before);
ffffffffc02013ea:	07246a63          	bltu	s0,s2,ffffffffc020145e <slub_check+0x1fa>
    cprintf("slub_check: OK\n");
}
ffffffffc02013ee:	63013403          	ld	s0,1584(sp)
ffffffffc02013f2:	63813083          	ld	ra,1592(sp)
ffffffffc02013f6:	62813483          	ld	s1,1576(sp)
ffffffffc02013fa:	62013903          	ld	s2,1568(sp)
ffffffffc02013fe:	61813983          	ld	s3,1560(sp)
ffffffffc0201402:	61013a03          	ld	s4,1552(sp)
ffffffffc0201406:	60813a83          	ld	s5,1544(sp)
ffffffffc020140a:	60013b03          	ld	s6,1536(sp)
    cprintf("slub_check: OK\n");
ffffffffc020140e:	00001517          	auipc	a0,0x1
ffffffffc0201412:	e3a50513          	addi	a0,a0,-454 # ffffffffc0202248 <buddy_pmm_manager+0x308>
}
ffffffffc0201416:	64010113          	addi	sp,sp,1600
    cprintf("slub_check: OK\n");
ffffffffc020141a:	d33fe06f          	j	ffffffffc020014c <cprintf>
        assert(more[i] != NULL);
ffffffffc020141e:	00001697          	auipc	a3,0x1
ffffffffc0201422:	dba68693          	addi	a3,a3,-582 # ffffffffc02021d8 <buddy_pmm_manager+0x298>
ffffffffc0201426:	00001617          	auipc	a2,0x1
ffffffffc020142a:	80260613          	addi	a2,a2,-2046 # ffffffffc0201c28 <etext+0x316>
ffffffffc020142e:	0eb00593          	li	a1,235
ffffffffc0201432:	00001517          	auipc	a0,0x1
ffffffffc0201436:	d6650513          	addi	a0,a0,-666 # ffffffffc0202198 <buddy_pmm_manager+0x258>
ffffffffc020143a:	d89fe0ef          	jal	ra,ffffffffc02001c2 <__panic>
    for (int i = 0; i < cnt; i++) assert(objs[i] != NULL);
ffffffffc020143e:	00001697          	auipc	a3,0x1
ffffffffc0201442:	d4a68693          	addi	a3,a3,-694 # ffffffffc0202188 <buddy_pmm_manager+0x248>
ffffffffc0201446:	00000617          	auipc	a2,0x0
ffffffffc020144a:	7e260613          	addi	a2,a2,2018 # ffffffffc0201c28 <etext+0x316>
ffffffffc020144e:	0e000593          	li	a1,224
ffffffffc0201452:	00001517          	auipc	a0,0x1
ffffffffc0201456:	d4650513          	addi	a0,a0,-698 # ffffffffc0202198 <buddy_pmm_manager+0x258>
ffffffffc020145a:	d69fe0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(after >= before);
ffffffffc020145e:	00001697          	auipc	a3,0x1
ffffffffc0201462:	dda68693          	addi	a3,a3,-550 # ffffffffc0202238 <buddy_pmm_manager+0x2f8>
ffffffffc0201466:	00000617          	auipc	a2,0x0
ffffffffc020146a:	7c260613          	addi	a2,a2,1986 # ffffffffc0201c28 <etext+0x316>
ffffffffc020146e:	0f800593          	li	a1,248
ffffffffc0201472:	00001517          	auipc	a0,0x1
ffffffffc0201476:	d2650513          	addi	a0,a0,-730 # ffffffffc0202198 <buddy_pmm_manager+0x258>
ffffffffc020147a:	d49fe0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc020147e <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc020147e:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201482:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0201484:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201488:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc020148a:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020148e:	f022                	sd	s0,32(sp)
ffffffffc0201490:	ec26                	sd	s1,24(sp)
ffffffffc0201492:	e84a                	sd	s2,16(sp)
ffffffffc0201494:	f406                	sd	ra,40(sp)
ffffffffc0201496:	e44e                	sd	s3,8(sp)
ffffffffc0201498:	84aa                	mv	s1,a0
ffffffffc020149a:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc020149c:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc02014a0:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc02014a2:	03067e63          	bgeu	a2,a6,ffffffffc02014de <printnum+0x60>
ffffffffc02014a6:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc02014a8:	00805763          	blez	s0,ffffffffc02014b6 <printnum+0x38>
ffffffffc02014ac:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02014ae:	85ca                	mv	a1,s2
ffffffffc02014b0:	854e                	mv	a0,s3
ffffffffc02014b2:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02014b4:	fc65                	bnez	s0,ffffffffc02014ac <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02014b6:	1a02                	slli	s4,s4,0x20
ffffffffc02014b8:	00001797          	auipc	a5,0x1
ffffffffc02014bc:	de878793          	addi	a5,a5,-536 # ffffffffc02022a0 <bucket_size+0x48>
ffffffffc02014c0:	020a5a13          	srli	s4,s4,0x20
ffffffffc02014c4:	9a3e                	add	s4,s4,a5
}
ffffffffc02014c6:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02014c8:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02014cc:	70a2                	ld	ra,40(sp)
ffffffffc02014ce:	69a2                	ld	s3,8(sp)
ffffffffc02014d0:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02014d2:	85ca                	mv	a1,s2
ffffffffc02014d4:	87a6                	mv	a5,s1
}
ffffffffc02014d6:	6942                	ld	s2,16(sp)
ffffffffc02014d8:	64e2                	ld	s1,24(sp)
ffffffffc02014da:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02014dc:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc02014de:	03065633          	divu	a2,a2,a6
ffffffffc02014e2:	8722                	mv	a4,s0
ffffffffc02014e4:	f9bff0ef          	jal	ra,ffffffffc020147e <printnum>
ffffffffc02014e8:	b7f9                	j	ffffffffc02014b6 <printnum+0x38>

ffffffffc02014ea <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc02014ea:	7119                	addi	sp,sp,-128
ffffffffc02014ec:	f4a6                	sd	s1,104(sp)
ffffffffc02014ee:	f0ca                	sd	s2,96(sp)
ffffffffc02014f0:	ecce                	sd	s3,88(sp)
ffffffffc02014f2:	e8d2                	sd	s4,80(sp)
ffffffffc02014f4:	e4d6                	sd	s5,72(sp)
ffffffffc02014f6:	e0da                	sd	s6,64(sp)
ffffffffc02014f8:	fc5e                	sd	s7,56(sp)
ffffffffc02014fa:	f06a                	sd	s10,32(sp)
ffffffffc02014fc:	fc86                	sd	ra,120(sp)
ffffffffc02014fe:	f8a2                	sd	s0,112(sp)
ffffffffc0201500:	f862                	sd	s8,48(sp)
ffffffffc0201502:	f466                	sd	s9,40(sp)
ffffffffc0201504:	ec6e                	sd	s11,24(sp)
ffffffffc0201506:	892a                	mv	s2,a0
ffffffffc0201508:	84ae                	mv	s1,a1
ffffffffc020150a:	8d32                	mv	s10,a2
ffffffffc020150c:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020150e:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0201512:	5b7d                	li	s6,-1
ffffffffc0201514:	00001a97          	auipc	s5,0x1
ffffffffc0201518:	dc0a8a93          	addi	s5,s5,-576 # ffffffffc02022d4 <bucket_size+0x7c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020151c:	00001b97          	auipc	s7,0x1
ffffffffc0201520:	f94b8b93          	addi	s7,s7,-108 # ffffffffc02024b0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201524:	000d4503          	lbu	a0,0(s10)
ffffffffc0201528:	001d0413          	addi	s0,s10,1
ffffffffc020152c:	01350a63          	beq	a0,s3,ffffffffc0201540 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201530:	c121                	beqz	a0,ffffffffc0201570 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0201532:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201534:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0201536:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201538:	fff44503          	lbu	a0,-1(s0)
ffffffffc020153c:	ff351ae3          	bne	a0,s3,ffffffffc0201530 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201540:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0201544:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0201548:	4c81                	li	s9,0
ffffffffc020154a:	4881                	li	a7,0
        width = precision = -1;
ffffffffc020154c:	5c7d                	li	s8,-1
ffffffffc020154e:	5dfd                	li	s11,-1
ffffffffc0201550:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0201554:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201556:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020155a:	0ff5f593          	zext.b	a1,a1
ffffffffc020155e:	00140d13          	addi	s10,s0,1
ffffffffc0201562:	04b56263          	bltu	a0,a1,ffffffffc02015a6 <vprintfmt+0xbc>
ffffffffc0201566:	058a                	slli	a1,a1,0x2
ffffffffc0201568:	95d6                	add	a1,a1,s5
ffffffffc020156a:	4194                	lw	a3,0(a1)
ffffffffc020156c:	96d6                	add	a3,a3,s5
ffffffffc020156e:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0201570:	70e6                	ld	ra,120(sp)
ffffffffc0201572:	7446                	ld	s0,112(sp)
ffffffffc0201574:	74a6                	ld	s1,104(sp)
ffffffffc0201576:	7906                	ld	s2,96(sp)
ffffffffc0201578:	69e6                	ld	s3,88(sp)
ffffffffc020157a:	6a46                	ld	s4,80(sp)
ffffffffc020157c:	6aa6                	ld	s5,72(sp)
ffffffffc020157e:	6b06                	ld	s6,64(sp)
ffffffffc0201580:	7be2                	ld	s7,56(sp)
ffffffffc0201582:	7c42                	ld	s8,48(sp)
ffffffffc0201584:	7ca2                	ld	s9,40(sp)
ffffffffc0201586:	7d02                	ld	s10,32(sp)
ffffffffc0201588:	6de2                	ld	s11,24(sp)
ffffffffc020158a:	6109                	addi	sp,sp,128
ffffffffc020158c:	8082                	ret
            padc = '0';
ffffffffc020158e:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201590:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201594:	846a                	mv	s0,s10
ffffffffc0201596:	00140d13          	addi	s10,s0,1
ffffffffc020159a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020159e:	0ff5f593          	zext.b	a1,a1
ffffffffc02015a2:	fcb572e3          	bgeu	a0,a1,ffffffffc0201566 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02015a6:	85a6                	mv	a1,s1
ffffffffc02015a8:	02500513          	li	a0,37
ffffffffc02015ac:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02015ae:	fff44783          	lbu	a5,-1(s0)
ffffffffc02015b2:	8d22                	mv	s10,s0
ffffffffc02015b4:	f73788e3          	beq	a5,s3,ffffffffc0201524 <vprintfmt+0x3a>
ffffffffc02015b8:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02015bc:	1d7d                	addi	s10,s10,-1
ffffffffc02015be:	ff379de3          	bne	a5,s3,ffffffffc02015b8 <vprintfmt+0xce>
ffffffffc02015c2:	b78d                	j	ffffffffc0201524 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02015c4:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02015c8:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02015cc:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02015ce:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02015d2:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02015d6:	02d86463          	bltu	a6,a3,ffffffffc02015fe <vprintfmt+0x114>
                ch = *fmt;
ffffffffc02015da:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc02015de:	002c169b          	slliw	a3,s8,0x2
ffffffffc02015e2:	0186873b          	addw	a4,a3,s8
ffffffffc02015e6:	0017171b          	slliw	a4,a4,0x1
ffffffffc02015ea:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc02015ec:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc02015f0:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc02015f2:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc02015f6:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02015fa:	fed870e3          	bgeu	a6,a3,ffffffffc02015da <vprintfmt+0xf0>
            if (width < 0)
ffffffffc02015fe:	f40ddce3          	bgez	s11,ffffffffc0201556 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201602:	8de2                	mv	s11,s8
ffffffffc0201604:	5c7d                	li	s8,-1
ffffffffc0201606:	bf81                	j	ffffffffc0201556 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201608:	fffdc693          	not	a3,s11
ffffffffc020160c:	96fd                	srai	a3,a3,0x3f
ffffffffc020160e:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201612:	00144603          	lbu	a2,1(s0)
ffffffffc0201616:	2d81                	sext.w	s11,s11
ffffffffc0201618:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020161a:	bf35                	j	ffffffffc0201556 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc020161c:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201620:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201624:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201626:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201628:	bfd9                	j	ffffffffc02015fe <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc020162a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020162c:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201630:	01174463          	blt	a4,a7,ffffffffc0201638 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201634:	1a088e63          	beqz	a7,ffffffffc02017f0 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201638:	000a3603          	ld	a2,0(s4)
ffffffffc020163c:	46c1                	li	a3,16
ffffffffc020163e:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0201640:	2781                	sext.w	a5,a5
ffffffffc0201642:	876e                	mv	a4,s11
ffffffffc0201644:	85a6                	mv	a1,s1
ffffffffc0201646:	854a                	mv	a0,s2
ffffffffc0201648:	e37ff0ef          	jal	ra,ffffffffc020147e <printnum>
            break;
ffffffffc020164c:	bde1                	j	ffffffffc0201524 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc020164e:	000a2503          	lw	a0,0(s4)
ffffffffc0201652:	85a6                	mv	a1,s1
ffffffffc0201654:	0a21                	addi	s4,s4,8
ffffffffc0201656:	9902                	jalr	s2
            break;
ffffffffc0201658:	b5f1                	j	ffffffffc0201524 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020165a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020165c:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201660:	01174463          	blt	a4,a7,ffffffffc0201668 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201664:	18088163          	beqz	a7,ffffffffc02017e6 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201668:	000a3603          	ld	a2,0(s4)
ffffffffc020166c:	46a9                	li	a3,10
ffffffffc020166e:	8a2e                	mv	s4,a1
ffffffffc0201670:	bfc1                	j	ffffffffc0201640 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201672:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201676:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201678:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020167a:	bdf1                	j	ffffffffc0201556 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc020167c:	85a6                	mv	a1,s1
ffffffffc020167e:	02500513          	li	a0,37
ffffffffc0201682:	9902                	jalr	s2
            break;
ffffffffc0201684:	b545                	j	ffffffffc0201524 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201686:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc020168a:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020168c:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020168e:	b5e1                	j	ffffffffc0201556 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201690:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201692:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201696:	01174463          	blt	a4,a7,ffffffffc020169e <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc020169a:	14088163          	beqz	a7,ffffffffc02017dc <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc020169e:	000a3603          	ld	a2,0(s4)
ffffffffc02016a2:	46a1                	li	a3,8
ffffffffc02016a4:	8a2e                	mv	s4,a1
ffffffffc02016a6:	bf69                	j	ffffffffc0201640 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc02016a8:	03000513          	li	a0,48
ffffffffc02016ac:	85a6                	mv	a1,s1
ffffffffc02016ae:	e03e                	sd	a5,0(sp)
ffffffffc02016b0:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc02016b2:	85a6                	mv	a1,s1
ffffffffc02016b4:	07800513          	li	a0,120
ffffffffc02016b8:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02016ba:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc02016bc:	6782                	ld	a5,0(sp)
ffffffffc02016be:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02016c0:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc02016c4:	bfb5                	j	ffffffffc0201640 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02016c6:	000a3403          	ld	s0,0(s4)
ffffffffc02016ca:	008a0713          	addi	a4,s4,8
ffffffffc02016ce:	e03a                	sd	a4,0(sp)
ffffffffc02016d0:	14040263          	beqz	s0,ffffffffc0201814 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc02016d4:	0fb05763          	blez	s11,ffffffffc02017c2 <vprintfmt+0x2d8>
ffffffffc02016d8:	02d00693          	li	a3,45
ffffffffc02016dc:	0cd79163          	bne	a5,a3,ffffffffc020179e <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02016e0:	00044783          	lbu	a5,0(s0)
ffffffffc02016e4:	0007851b          	sext.w	a0,a5
ffffffffc02016e8:	cf85                	beqz	a5,ffffffffc0201720 <vprintfmt+0x236>
ffffffffc02016ea:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02016ee:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02016f2:	000c4563          	bltz	s8,ffffffffc02016fc <vprintfmt+0x212>
ffffffffc02016f6:	3c7d                	addiw	s8,s8,-1
ffffffffc02016f8:	036c0263          	beq	s8,s6,ffffffffc020171c <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc02016fc:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02016fe:	0e0c8e63          	beqz	s9,ffffffffc02017fa <vprintfmt+0x310>
ffffffffc0201702:	3781                	addiw	a5,a5,-32
ffffffffc0201704:	0ef47b63          	bgeu	s0,a5,ffffffffc02017fa <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201708:	03f00513          	li	a0,63
ffffffffc020170c:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020170e:	000a4783          	lbu	a5,0(s4)
ffffffffc0201712:	3dfd                	addiw	s11,s11,-1
ffffffffc0201714:	0a05                	addi	s4,s4,1
ffffffffc0201716:	0007851b          	sext.w	a0,a5
ffffffffc020171a:	ffe1                	bnez	a5,ffffffffc02016f2 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc020171c:	01b05963          	blez	s11,ffffffffc020172e <vprintfmt+0x244>
ffffffffc0201720:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201722:	85a6                	mv	a1,s1
ffffffffc0201724:	02000513          	li	a0,32
ffffffffc0201728:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc020172a:	fe0d9be3          	bnez	s11,ffffffffc0201720 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020172e:	6a02                	ld	s4,0(sp)
ffffffffc0201730:	bbd5                	j	ffffffffc0201524 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201732:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201734:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201738:	01174463          	blt	a4,a7,ffffffffc0201740 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc020173c:	08088d63          	beqz	a7,ffffffffc02017d6 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201740:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201744:	0a044d63          	bltz	s0,ffffffffc02017fe <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201748:	8622                	mv	a2,s0
ffffffffc020174a:	8a66                	mv	s4,s9
ffffffffc020174c:	46a9                	li	a3,10
ffffffffc020174e:	bdcd                	j	ffffffffc0201640 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201750:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201754:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201756:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201758:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc020175c:	8fb5                	xor	a5,a5,a3
ffffffffc020175e:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201762:	02d74163          	blt	a4,a3,ffffffffc0201784 <vprintfmt+0x29a>
ffffffffc0201766:	00369793          	slli	a5,a3,0x3
ffffffffc020176a:	97de                	add	a5,a5,s7
ffffffffc020176c:	639c                	ld	a5,0(a5)
ffffffffc020176e:	cb99                	beqz	a5,ffffffffc0201784 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201770:	86be                	mv	a3,a5
ffffffffc0201772:	00001617          	auipc	a2,0x1
ffffffffc0201776:	b5e60613          	addi	a2,a2,-1186 # ffffffffc02022d0 <bucket_size+0x78>
ffffffffc020177a:	85a6                	mv	a1,s1
ffffffffc020177c:	854a                	mv	a0,s2
ffffffffc020177e:	0ce000ef          	jal	ra,ffffffffc020184c <printfmt>
ffffffffc0201782:	b34d                	j	ffffffffc0201524 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201784:	00001617          	auipc	a2,0x1
ffffffffc0201788:	b3c60613          	addi	a2,a2,-1220 # ffffffffc02022c0 <bucket_size+0x68>
ffffffffc020178c:	85a6                	mv	a1,s1
ffffffffc020178e:	854a                	mv	a0,s2
ffffffffc0201790:	0bc000ef          	jal	ra,ffffffffc020184c <printfmt>
ffffffffc0201794:	bb41                	j	ffffffffc0201524 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0201796:	00001417          	auipc	s0,0x1
ffffffffc020179a:	b2240413          	addi	s0,s0,-1246 # ffffffffc02022b8 <bucket_size+0x60>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020179e:	85e2                	mv	a1,s8
ffffffffc02017a0:	8522                	mv	a0,s0
ffffffffc02017a2:	e43e                	sd	a5,8(sp)
ffffffffc02017a4:	0fc000ef          	jal	ra,ffffffffc02018a0 <strnlen>
ffffffffc02017a8:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02017ac:	01b05b63          	blez	s11,ffffffffc02017c2 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc02017b0:	67a2                	ld	a5,8(sp)
ffffffffc02017b2:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02017b6:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc02017b8:	85a6                	mv	a1,s1
ffffffffc02017ba:	8552                	mv	a0,s4
ffffffffc02017bc:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02017be:	fe0d9ce3          	bnez	s11,ffffffffc02017b6 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02017c2:	00044783          	lbu	a5,0(s0)
ffffffffc02017c6:	00140a13          	addi	s4,s0,1
ffffffffc02017ca:	0007851b          	sext.w	a0,a5
ffffffffc02017ce:	d3a5                	beqz	a5,ffffffffc020172e <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02017d0:	05e00413          	li	s0,94
ffffffffc02017d4:	bf39                	j	ffffffffc02016f2 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc02017d6:	000a2403          	lw	s0,0(s4)
ffffffffc02017da:	b7ad                	j	ffffffffc0201744 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc02017dc:	000a6603          	lwu	a2,0(s4)
ffffffffc02017e0:	46a1                	li	a3,8
ffffffffc02017e2:	8a2e                	mv	s4,a1
ffffffffc02017e4:	bdb1                	j	ffffffffc0201640 <vprintfmt+0x156>
ffffffffc02017e6:	000a6603          	lwu	a2,0(s4)
ffffffffc02017ea:	46a9                	li	a3,10
ffffffffc02017ec:	8a2e                	mv	s4,a1
ffffffffc02017ee:	bd89                	j	ffffffffc0201640 <vprintfmt+0x156>
ffffffffc02017f0:	000a6603          	lwu	a2,0(s4)
ffffffffc02017f4:	46c1                	li	a3,16
ffffffffc02017f6:	8a2e                	mv	s4,a1
ffffffffc02017f8:	b5a1                	j	ffffffffc0201640 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc02017fa:	9902                	jalr	s2
ffffffffc02017fc:	bf09                	j	ffffffffc020170e <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc02017fe:	85a6                	mv	a1,s1
ffffffffc0201800:	02d00513          	li	a0,45
ffffffffc0201804:	e03e                	sd	a5,0(sp)
ffffffffc0201806:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201808:	6782                	ld	a5,0(sp)
ffffffffc020180a:	8a66                	mv	s4,s9
ffffffffc020180c:	40800633          	neg	a2,s0
ffffffffc0201810:	46a9                	li	a3,10
ffffffffc0201812:	b53d                	j	ffffffffc0201640 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201814:	03b05163          	blez	s11,ffffffffc0201836 <vprintfmt+0x34c>
ffffffffc0201818:	02d00693          	li	a3,45
ffffffffc020181c:	f6d79de3          	bne	a5,a3,ffffffffc0201796 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201820:	00001417          	auipc	s0,0x1
ffffffffc0201824:	a9840413          	addi	s0,s0,-1384 # ffffffffc02022b8 <bucket_size+0x60>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201828:	02800793          	li	a5,40
ffffffffc020182c:	02800513          	li	a0,40
ffffffffc0201830:	00140a13          	addi	s4,s0,1
ffffffffc0201834:	bd6d                	j	ffffffffc02016ee <vprintfmt+0x204>
ffffffffc0201836:	00001a17          	auipc	s4,0x1
ffffffffc020183a:	a83a0a13          	addi	s4,s4,-1405 # ffffffffc02022b9 <bucket_size+0x61>
ffffffffc020183e:	02800513          	li	a0,40
ffffffffc0201842:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201846:	05e00413          	li	s0,94
ffffffffc020184a:	b565                	j	ffffffffc02016f2 <vprintfmt+0x208>

ffffffffc020184c <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020184c:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc020184e:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201852:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201854:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201856:	ec06                	sd	ra,24(sp)
ffffffffc0201858:	f83a                	sd	a4,48(sp)
ffffffffc020185a:	fc3e                	sd	a5,56(sp)
ffffffffc020185c:	e0c2                	sd	a6,64(sp)
ffffffffc020185e:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201860:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201862:	c89ff0ef          	jal	ra,ffffffffc02014ea <vprintfmt>
}
ffffffffc0201866:	60e2                	ld	ra,24(sp)
ffffffffc0201868:	6161                	addi	sp,sp,80
ffffffffc020186a:	8082                	ret

ffffffffc020186c <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc020186c:	4781                	li	a5,0
ffffffffc020186e:	00004717          	auipc	a4,0x4
ffffffffc0201872:	7a273703          	ld	a4,1954(a4) # ffffffffc0206010 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201876:	88ba                	mv	a7,a4
ffffffffc0201878:	852a                	mv	a0,a0
ffffffffc020187a:	85be                	mv	a1,a5
ffffffffc020187c:	863e                	mv	a2,a5
ffffffffc020187e:	00000073          	ecall
ffffffffc0201882:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201884:	8082                	ret

ffffffffc0201886 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201886:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc020188a:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc020188c:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc020188e:	cb81                	beqz	a5,ffffffffc020189e <strlen+0x18>
        cnt ++;
ffffffffc0201890:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0201892:	00a707b3          	add	a5,a4,a0
ffffffffc0201896:	0007c783          	lbu	a5,0(a5)
ffffffffc020189a:	fbfd                	bnez	a5,ffffffffc0201890 <strlen+0xa>
ffffffffc020189c:	8082                	ret
    }
    return cnt;
}
ffffffffc020189e:	8082                	ret

ffffffffc02018a0 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc02018a0:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc02018a2:	e589                	bnez	a1,ffffffffc02018ac <strnlen+0xc>
ffffffffc02018a4:	a811                	j	ffffffffc02018b8 <strnlen+0x18>
        cnt ++;
ffffffffc02018a6:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc02018a8:	00f58863          	beq	a1,a5,ffffffffc02018b8 <strnlen+0x18>
ffffffffc02018ac:	00f50733          	add	a4,a0,a5
ffffffffc02018b0:	00074703          	lbu	a4,0(a4)
ffffffffc02018b4:	fb6d                	bnez	a4,ffffffffc02018a6 <strnlen+0x6>
ffffffffc02018b6:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc02018b8:	852e                	mv	a0,a1
ffffffffc02018ba:	8082                	ret

ffffffffc02018bc <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02018bc:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02018c0:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02018c4:	cb89                	beqz	a5,ffffffffc02018d6 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc02018c6:	0505                	addi	a0,a0,1
ffffffffc02018c8:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02018ca:	fee789e3          	beq	a5,a4,ffffffffc02018bc <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02018ce:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc02018d2:	9d19                	subw	a0,a0,a4
ffffffffc02018d4:	8082                	ret
ffffffffc02018d6:	4501                	li	a0,0
ffffffffc02018d8:	bfed                	j	ffffffffc02018d2 <strcmp+0x16>

ffffffffc02018da <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02018da:	c20d                	beqz	a2,ffffffffc02018fc <strncmp+0x22>
ffffffffc02018dc:	962e                	add	a2,a2,a1
ffffffffc02018de:	a031                	j	ffffffffc02018ea <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc02018e0:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02018e2:	00e79a63          	bne	a5,a4,ffffffffc02018f6 <strncmp+0x1c>
ffffffffc02018e6:	00b60b63          	beq	a2,a1,ffffffffc02018fc <strncmp+0x22>
ffffffffc02018ea:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc02018ee:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02018f0:	fff5c703          	lbu	a4,-1(a1)
ffffffffc02018f4:	f7f5                	bnez	a5,ffffffffc02018e0 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02018f6:	40e7853b          	subw	a0,a5,a4
}
ffffffffc02018fa:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02018fc:	4501                	li	a0,0
ffffffffc02018fe:	8082                	ret

ffffffffc0201900 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201900:	ca01                	beqz	a2,ffffffffc0201910 <memset+0x10>
ffffffffc0201902:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201904:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201906:	0785                	addi	a5,a5,1
ffffffffc0201908:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc020190c:	fec79de3          	bne	a5,a2,ffffffffc0201906 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201910:	8082                	ret
