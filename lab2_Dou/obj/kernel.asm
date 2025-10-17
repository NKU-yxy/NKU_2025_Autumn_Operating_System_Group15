
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00005297          	auipc	t0,0x5
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0205000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00005297          	auipc	t0,0x5
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0205008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02042b7          	lui	t0,0xc0204
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
ffffffffc020003c:	c0204137          	lui	sp,0xc0204

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
ffffffffc020004c:	00001517          	auipc	a0,0x1
ffffffffc0200050:	2d450513          	addi	a0,a0,724 # ffffffffc0201320 <etext>
void print_kerninfo(void) {
ffffffffc0200054:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200056:	0f6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", (uintptr_t)kern_init);
ffffffffc020005a:	00000597          	auipc	a1,0x0
ffffffffc020005e:	07e58593          	addi	a1,a1,126 # ffffffffc02000d8 <kern_init>
ffffffffc0200062:	00001517          	auipc	a0,0x1
ffffffffc0200066:	2de50513          	addi	a0,a0,734 # ffffffffc0201340 <etext+0x20>
ffffffffc020006a:	0e2000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020006e:	00001597          	auipc	a1,0x1
ffffffffc0200072:	2b258593          	addi	a1,a1,690 # ffffffffc0201320 <etext>
ffffffffc0200076:	00001517          	auipc	a0,0x1
ffffffffc020007a:	2ea50513          	addi	a0,a0,746 # ffffffffc0201360 <etext+0x40>
ffffffffc020007e:	0ce000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200082:	00005597          	auipc	a1,0x5
ffffffffc0200086:	f9658593          	addi	a1,a1,-106 # ffffffffc0205018 <free_area>
ffffffffc020008a:	00001517          	auipc	a0,0x1
ffffffffc020008e:	2f650513          	addi	a0,a0,758 # ffffffffc0201380 <etext+0x60>
ffffffffc0200092:	0ba000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc0200096:	00005597          	auipc	a1,0x5
ffffffffc020009a:	09258593          	addi	a1,a1,146 # ffffffffc0205128 <end>
ffffffffc020009e:	00001517          	auipc	a0,0x1
ffffffffc02000a2:	30250513          	addi	a0,a0,770 # ffffffffc02013a0 <etext+0x80>
ffffffffc02000a6:	0a6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - (char*)kern_init + 1023) / 1024);
ffffffffc02000aa:	00005597          	auipc	a1,0x5
ffffffffc02000ae:	47d58593          	addi	a1,a1,1149 # ffffffffc0205527 <end+0x3ff>
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
ffffffffc02000cc:	00001517          	auipc	a0,0x1
ffffffffc02000d0:	2f450513          	addi	a0,a0,756 # ffffffffc02013c0 <etext+0xa0>
}
ffffffffc02000d4:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000d6:	a89d                	j	ffffffffc020014c <cprintf>

ffffffffc02000d8 <kern_init>:

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc02000d8:	00005517          	auipc	a0,0x5
ffffffffc02000dc:	f4050513          	addi	a0,a0,-192 # ffffffffc0205018 <free_area>
ffffffffc02000e0:	00005617          	auipc	a2,0x5
ffffffffc02000e4:	04860613          	addi	a2,a2,72 # ffffffffc0205128 <end>
int kern_init(void) {
ffffffffc02000e8:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc02000ea:	8e09                	sub	a2,a2,a0
ffffffffc02000ec:	4581                	li	a1,0
int kern_init(void) {
ffffffffc02000ee:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc02000f0:	21e010ef          	jal	ra,ffffffffc020130e <memset>
    dtb_init();
ffffffffc02000f4:	12c000ef          	jal	ra,ffffffffc0200220 <dtb_init>
    cons_init();  // init the console
ffffffffc02000f8:	11e000ef          	jal	ra,ffffffffc0200216 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc02000fc:	00001517          	auipc	a0,0x1
ffffffffc0200100:	2f450513          	addi	a0,a0,756 # ffffffffc02013f0 <etext+0xd0>
ffffffffc0200104:	07e000ef          	jal	ra,ffffffffc0200182 <cputs>

    print_kerninfo();
ffffffffc0200108:	f43ff0ef          	jal	ra,ffffffffc020004a <print_kerninfo>

    // grade_backtrace();
    pmm_init();  // init physical memory management
ffffffffc020010c:	3a9000ef          	jal	ra,ffffffffc0200cb4 <pmm_init>

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
ffffffffc0200140:	5b9000ef          	jal	ra,ffffffffc0200ef8 <vprintfmt>
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
ffffffffc020014e:	02810313          	addi	t1,sp,40 # ffffffffc0204028 <boot_page_table_sv39+0x28>
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
ffffffffc0200176:	583000ef          	jal	ra,ffffffffc0200ef8 <vprintfmt>
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
ffffffffc02001c2:	00005317          	auipc	t1,0x5
ffffffffc02001c6:	f1e30313          	addi	t1,t1,-226 # ffffffffc02050e0 <is_panic>
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
ffffffffc02001f2:	00001517          	auipc	a0,0x1
ffffffffc02001f6:	21e50513          	addi	a0,a0,542 # ffffffffc0201410 <etext+0xf0>
    va_start(ap, fmt);
ffffffffc02001fa:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02001fc:	f51ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200200:	65a2                	ld	a1,8(sp)
ffffffffc0200202:	8522                	mv	a0,s0
ffffffffc0200204:	f29ff0ef          	jal	ra,ffffffffc020012c <vcprintf>
    cprintf("\n");
ffffffffc0200208:	00001517          	auipc	a0,0x1
ffffffffc020020c:	4b850513          	addi	a0,a0,1208 # ffffffffc02016c0 <etext+0x3a0>
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
ffffffffc020021c:	05e0106f          	j	ffffffffc020127a <sbi_console_putchar>

ffffffffc0200220 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200220:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200222:	00001517          	auipc	a0,0x1
ffffffffc0200226:	20e50513          	addi	a0,a0,526 # ffffffffc0201430 <etext+0x110>
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
ffffffffc0200248:	00005597          	auipc	a1,0x5
ffffffffc020024c:	db85b583          	ld	a1,-584(a1) # ffffffffc0205000 <boot_hartid>
ffffffffc0200250:	00001517          	auipc	a0,0x1
ffffffffc0200254:	1f050513          	addi	a0,a0,496 # ffffffffc0201440 <etext+0x120>
ffffffffc0200258:	ef5ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020025c:	00005417          	auipc	s0,0x5
ffffffffc0200260:	dac40413          	addi	s0,s0,-596 # ffffffffc0205008 <boot_dtb>
ffffffffc0200264:	600c                	ld	a1,0(s0)
ffffffffc0200266:	00001517          	auipc	a0,0x1
ffffffffc020026a:	1ea50513          	addi	a0,a0,490 # ffffffffc0201450 <etext+0x130>
ffffffffc020026e:	edfff0ef          	jal	ra,ffffffffc020014c <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200272:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200276:	00001517          	auipc	a0,0x1
ffffffffc020027a:	1f250513          	addi	a0,a0,498 # ffffffffc0201468 <etext+0x148>
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
ffffffffc02002be:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfedadc5>
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
ffffffffc0200334:	18890913          	addi	s2,s2,392 # ffffffffc02014b8 <etext+0x198>
ffffffffc0200338:	49bd                	li	s3,15
        switch (token) {
ffffffffc020033a:	4d91                	li	s11,4
ffffffffc020033c:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020033e:	00001497          	auipc	s1,0x1
ffffffffc0200342:	17248493          	addi	s1,s1,370 # ffffffffc02014b0 <etext+0x190>
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
ffffffffc0200396:	19e50513          	addi	a0,a0,414 # ffffffffc0201530 <etext+0x210>
ffffffffc020039a:	db3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020039e:	00001517          	auipc	a0,0x1
ffffffffc02003a2:	1ca50513          	addi	a0,a0,458 # ffffffffc0201568 <etext+0x248>
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
ffffffffc02003e2:	0aa50513          	addi	a0,a0,170 # ffffffffc0201488 <etext+0x168>
}
ffffffffc02003e6:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003e8:	b395                	j	ffffffffc020014c <cprintf>
                int name_len = strlen(name);
ffffffffc02003ea:	8556                	mv	a0,s5
ffffffffc02003ec:	6a9000ef          	jal	ra,ffffffffc0201294 <strlen>
ffffffffc02003f0:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003f2:	4619                	li	a2,6
ffffffffc02003f4:	85a6                	mv	a1,s1
ffffffffc02003f6:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02003f8:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003fa:	6ef000ef          	jal	ra,ffffffffc02012e8 <strncmp>
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
ffffffffc0200490:	63b000ef          	jal	ra,ffffffffc02012ca <strcmp>
ffffffffc0200494:	66a2                	ld	a3,8(sp)
ffffffffc0200496:	f94d                	bnez	a0,ffffffffc0200448 <dtb_init+0x228>
ffffffffc0200498:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200448 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020049c:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02004a0:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02004a4:	00001517          	auipc	a0,0x1
ffffffffc02004a8:	01c50513          	addi	a0,a0,28 # ffffffffc02014c0 <etext+0x1a0>
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
ffffffffc0200576:	f6e50513          	addi	a0,a0,-146 # ffffffffc02014e0 <etext+0x1c0>
ffffffffc020057a:	bd3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020057e:	014b5613          	srli	a2,s6,0x14
ffffffffc0200582:	85da                	mv	a1,s6
ffffffffc0200584:	00001517          	auipc	a0,0x1
ffffffffc0200588:	f7450513          	addi	a0,a0,-140 # ffffffffc02014f8 <etext+0x1d8>
ffffffffc020058c:	bc1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200590:	008b05b3          	add	a1,s6,s0
ffffffffc0200594:	15fd                	addi	a1,a1,-1
ffffffffc0200596:	00001517          	auipc	a0,0x1
ffffffffc020059a:	f8250513          	addi	a0,a0,-126 # ffffffffc0201518 <etext+0x1f8>
ffffffffc020059e:	bafff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02005a2:	00001517          	auipc	a0,0x1
ffffffffc02005a6:	fc650513          	addi	a0,a0,-58 # ffffffffc0201568 <etext+0x248>
        memory_base = mem_base;
ffffffffc02005aa:	00005797          	auipc	a5,0x5
ffffffffc02005ae:	b287bf23          	sd	s0,-1218(a5) # ffffffffc02050e8 <memory_base>
        memory_size = mem_size;
ffffffffc02005b2:	00005797          	auipc	a5,0x5
ffffffffc02005b6:	b367bf23          	sd	s6,-1218(a5) # ffffffffc02050f0 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc02005ba:	b3f5                	j	ffffffffc02003a6 <dtb_init+0x186>

ffffffffc02005bc <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc02005bc:	00005517          	auipc	a0,0x5
ffffffffc02005c0:	b2c53503          	ld	a0,-1236(a0) # ffffffffc02050e8 <memory_base>
ffffffffc02005c4:	8082                	ret

ffffffffc02005c6 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
ffffffffc02005c6:	00005517          	auipc	a0,0x5
ffffffffc02005ca:	b2a53503          	ld	a0,-1238(a0) # ffffffffc02050f0 <memory_size>
ffffffffc02005ce:	8082                	ret

ffffffffc02005d0 <buddy_init>:

// ====================== 初始化 ======================

static void
buddy_init(void) {
    for (int i = 0; i < MAX_ORDER; i++) {
ffffffffc02005d0:	00005717          	auipc	a4,0x5
ffffffffc02005d4:	ae870713          	addi	a4,a4,-1304 # ffffffffc02050b8 <free_area+0xa0>
ffffffffc02005d8:	00005797          	auipc	a5,0x5
ffffffffc02005dc:	a4078793          	addi	a5,a5,-1472 # ffffffffc0205018 <free_area>
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
ffffffffc02005f4:	00005697          	auipc	a3,0x5
ffffffffc02005f8:	ac468693          	addi	a3,a3,-1340 # ffffffffc02050b8 <free_area+0xa0>
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
ffffffffc0200620:	f6450513          	addi	a0,a0,-156 # ffffffffc0201580 <etext+0x260>
ffffffffc0200624:	00005497          	auipc	s1,0x5
ffffffffc0200628:	a9448493          	addi	s1,s1,-1388 # ffffffffc02050b8 <free_area+0xa0>
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
ffffffffc0200646:	f5ea0a13          	addi	s4,s4,-162 # ffffffffc02015a0 <etext+0x280>
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
ffffffffc0200690:	f4450513          	addi	a0,a0,-188 # ffffffffc02015d0 <etext+0x2b0>
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
ffffffffc020069e:	f5650513          	addi	a0,a0,-170 # ffffffffc02015f0 <etext+0x2d0>
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
ffffffffc02006b6:	5f2000ef          	jal	ra,ffffffffc0200ca8 <nr_free_pages>
ffffffffc02006ba:	8aaa                	mv	s5,a0
    buddy_dump_free_list();
ffffffffc02006bc:	f5dff0ef          	jal	ra,ffffffffc0200618 <buddy_dump_free_list>

    struct Page *p0 = alloc_pages(1);
ffffffffc02006c0:	4505                	li	a0,1
ffffffffc02006c2:	5ce000ef          	jal	ra,ffffffffc0200c90 <alloc_pages>
ffffffffc02006c6:	842a                	mv	s0,a0
    struct Page *p1 = alloc_pages(2);
ffffffffc02006c8:	4509                	li	a0,2
ffffffffc02006ca:	5c6000ef          	jal	ra,ffffffffc0200c90 <alloc_pages>
ffffffffc02006ce:	89aa                	mv	s3,a0
    struct Page *p2 = alloc_pages(8);
ffffffffc02006d0:	4521                	li	a0,8
ffffffffc02006d2:	5be000ef          	jal	ra,ffffffffc0200c90 <alloc_pages>

    assert(p0 && p1 && p2);
ffffffffc02006d6:	12040663          	beqz	s0,ffffffffc0200802 <buddy_check+0x16a>
ffffffffc02006da:	12098463          	beqz	s3,ffffffffc0200802 <buddy_check+0x16a>
ffffffffc02006de:	8b2a                	mv	s6,a0
ffffffffc02006e0:	12050163          	beqz	a0,ffffffffc0200802 <buddy_check+0x16a>
    cprintf("[Check] Allocations successful:\n");
ffffffffc02006e4:	00001517          	auipc	a0,0x1
ffffffffc02006e8:	f7c50513          	addi	a0,a0,-132 # ffffffffc0201660 <etext+0x340>
ffffffffc02006ec:	a61ff0ef          	jal	ra,ffffffffc020014c <cprintf>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02006f0:	00005a17          	auipc	s4,0x5
ffffffffc02006f4:	a10a0a13          	addi	s4,s4,-1520 # ffffffffc0205100 <pages>
ffffffffc02006f8:	000a3583          	ld	a1,0(s4)
ffffffffc02006fc:	00001917          	auipc	s2,0x1
ffffffffc0200700:	5e493903          	ld	s2,1508(s2) # ffffffffc0201ce0 <error_string+0x38>
ffffffffc0200704:	00001497          	auipc	s1,0x1
ffffffffc0200708:	5e44b483          	ld	s1,1508(s1) # ffffffffc0201ce8 <nbase>
ffffffffc020070c:	40b405b3          	sub	a1,s0,a1
ffffffffc0200710:	858d                	srai	a1,a1,0x3
ffffffffc0200712:	032585b3          	mul	a1,a1,s2
    cprintf("  p0 = 0x%08lx (1 page)\n", page2pa(p0));
ffffffffc0200716:	00001517          	auipc	a0,0x1
ffffffffc020071a:	f7250513          	addi	a0,a0,-142 # ffffffffc0201688 <etext+0x368>
ffffffffc020071e:	95a6                	add	a1,a1,s1
ffffffffc0200720:	05b2                	slli	a1,a1,0xc
ffffffffc0200722:	a2bff0ef          	jal	ra,ffffffffc020014c <cprintf>
ffffffffc0200726:	000a3583          	ld	a1,0(s4)
    cprintf("  p1 = 0x%08lx (2 pages)\n", page2pa(p1));
ffffffffc020072a:	00001517          	auipc	a0,0x1
ffffffffc020072e:	f7e50513          	addi	a0,a0,-130 # ffffffffc02016a8 <etext+0x388>
ffffffffc0200732:	40b985b3          	sub	a1,s3,a1
ffffffffc0200736:	858d                	srai	a1,a1,0x3
ffffffffc0200738:	032585b3          	mul	a1,a1,s2
ffffffffc020073c:	95a6                	add	a1,a1,s1
ffffffffc020073e:	05b2                	slli	a1,a1,0xc
ffffffffc0200740:	a0dff0ef          	jal	ra,ffffffffc020014c <cprintf>
ffffffffc0200744:	000a3583          	ld	a1,0(s4)
    cprintf("  p2 = 0x%08lx (8 pages)\n", page2pa(p2));
ffffffffc0200748:	00001517          	auipc	a0,0x1
ffffffffc020074c:	f8050513          	addi	a0,a0,-128 # ffffffffc02016c8 <etext+0x3a8>
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
ffffffffc020076a:	532000ef          	jal	ra,ffffffffc0200c9c <free_pages>
    free_pages(p1, 2);
ffffffffc020076e:	4589                	li	a1,2
ffffffffc0200770:	854e                	mv	a0,s3
ffffffffc0200772:	52a000ef          	jal	ra,ffffffffc0200c9c <free_pages>
    free_pages(p2, 8);
ffffffffc0200776:	45a1                	li	a1,8
ffffffffc0200778:	855a                	mv	a0,s6
ffffffffc020077a:	522000ef          	jal	ra,ffffffffc0200c9c <free_pages>

    cprintf("[Check] Freed all pages.\n");
ffffffffc020077e:	00001517          	auipc	a0,0x1
ffffffffc0200782:	f6a50513          	addi	a0,a0,-150 # ffffffffc02016e8 <etext+0x3c8>
ffffffffc0200786:	9c7ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    buddy_dump_free_list();
ffffffffc020078a:	e8fff0ef          	jal	ra,ffffffffc0200618 <buddy_dump_free_list>

    assert(total == nr_free_pages());
ffffffffc020078e:	51a000ef          	jal	ra,ffffffffc0200ca8 <nr_free_pages>
ffffffffc0200792:	0b551863          	bne	a0,s5,ffffffffc0200842 <buddy_check+0x1aa>
    cprintf("[Check] Free page count restored (%d pages).\n", (int)total);
ffffffffc0200796:	0005059b          	sext.w	a1,a0
ffffffffc020079a:	00001517          	auipc	a0,0x1
ffffffffc020079e:	f8e50513          	addi	a0,a0,-114 # ffffffffc0201728 <etext+0x408>
ffffffffc02007a2:	9abff0ef          	jal	ra,ffffffffc020014c <cprintf>

    struct Page *p3 = alloc_pages(4);
ffffffffc02007a6:	4511                	li	a0,4
ffffffffc02007a8:	4e8000ef          	jal	ra,ffffffffc0200c90 <alloc_pages>
ffffffffc02007ac:	842a                	mv	s0,a0
    assert(p3);
ffffffffc02007ae:	c935                	beqz	a0,ffffffffc0200822 <buddy_check+0x18a>
ffffffffc02007b0:	000a3583          	ld	a1,0(s4)
    cprintf("[Check] Allocated again p3 = 0x%08lx (4 pages)\n", page2pa(p3));
ffffffffc02007b4:	00001517          	auipc	a0,0x1
ffffffffc02007b8:	fac50513          	addi	a0,a0,-84 # ffffffffc0201760 <etext+0x440>
ffffffffc02007bc:	40b405b3          	sub	a1,s0,a1
ffffffffc02007c0:	858d                	srai	a1,a1,0x3
ffffffffc02007c2:	032585b3          	mul	a1,a1,s2
ffffffffc02007c6:	95a6                	add	a1,a1,s1
ffffffffc02007c8:	05b2                	slli	a1,a1,0xc
ffffffffc02007ca:	983ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    free_pages(p3, 4);
ffffffffc02007ce:	8522                	mv	a0,s0
ffffffffc02007d0:	4591                	li	a1,4
ffffffffc02007d2:	4ca000ef          	jal	ra,ffffffffc0200c9c <free_pages>

    buddy_dump_free_list();
ffffffffc02007d6:	e43ff0ef          	jal	ra,ffffffffc0200618 <buddy_dump_free_list>
    cprintf("Buddy system check passed!\n");
ffffffffc02007da:	00001517          	auipc	a0,0x1
ffffffffc02007de:	fb650513          	addi	a0,a0,-74 # ffffffffc0201790 <etext+0x470>
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
ffffffffc02007fa:	fba50513          	addi	a0,a0,-70 # ffffffffc02017b0 <etext+0x490>
}
ffffffffc02007fe:	6121                	addi	sp,sp,64
    cprintf("========================================\n");
ffffffffc0200800:	b2b1                	j	ffffffffc020014c <cprintf>
    assert(p0 && p1 && p2);
ffffffffc0200802:	00001697          	auipc	a3,0x1
ffffffffc0200806:	e1e68693          	addi	a3,a3,-482 # ffffffffc0201620 <etext+0x300>
ffffffffc020080a:	00001617          	auipc	a2,0x1
ffffffffc020080e:	e2660613          	addi	a2,a2,-474 # ffffffffc0201630 <etext+0x310>
ffffffffc0200812:	09c00593          	li	a1,156
ffffffffc0200816:	00001517          	auipc	a0,0x1
ffffffffc020081a:	e3250513          	addi	a0,a0,-462 # ffffffffc0201648 <etext+0x328>
ffffffffc020081e:	9a5ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p3);
ffffffffc0200822:	00001697          	auipc	a3,0x1
ffffffffc0200826:	f3668693          	addi	a3,a3,-202 # ffffffffc0201758 <etext+0x438>
ffffffffc020082a:	00001617          	auipc	a2,0x1
ffffffffc020082e:	e0660613          	addi	a2,a2,-506 # ffffffffc0201630 <etext+0x310>
ffffffffc0200832:	0af00593          	li	a1,175
ffffffffc0200836:	00001517          	auipc	a0,0x1
ffffffffc020083a:	e1250513          	addi	a0,a0,-494 # ffffffffc0201648 <etext+0x328>
ffffffffc020083e:	985ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(total == nr_free_pages());
ffffffffc0200842:	00001697          	auipc	a3,0x1
ffffffffc0200846:	ec668693          	addi	a3,a3,-314 # ffffffffc0201708 <etext+0x3e8>
ffffffffc020084a:	00001617          	auipc	a2,0x1
ffffffffc020084e:	de660613          	addi	a2,a2,-538 # ffffffffc0201630 <etext+0x310>
ffffffffc0200852:	0ab00593          	li	a1,171
ffffffffc0200856:	00001517          	auipc	a0,0x1
ffffffffc020085a:	df250513          	addi	a0,a0,-526 # ffffffffc0201648 <etext+0x328>
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
ffffffffc02008b6:	00004717          	auipc	a4,0x4
ffffffffc02008ba:	76270713          	addi	a4,a4,1890 # ffffffffc0205018 <free_area>
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
ffffffffc0200918:	ecca0a13          	addi	s4,s4,-308 # ffffffffc02017e0 <etext+0x4c0>
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
ffffffffc020096e:	00004697          	auipc	a3,0x4
ffffffffc0200972:	7926b683          	ld	a3,1938(a3) # ffffffffc0205100 <pages>
ffffffffc0200976:	40d986b3          	sub	a3,s3,a3
ffffffffc020097a:	00001797          	auipc	a5,0x1
ffffffffc020097e:	3667b783          	ld	a5,870(a5) # ffffffffc0201ce0 <error_string+0x38>
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
ffffffffc0200996:	00001797          	auipc	a5,0x1
ffffffffc020099a:	3527b783          	ld	a5,850(a5) # ffffffffc0201ce8 <nbase>
    cprintf("[Buddy] Alloc %d pages (order %d) @ 0x%08lx\n", (1 << order), order, pa);
ffffffffc020099e:	012595bb          	sllw	a1,a1,s2
ffffffffc02009a2:	00001517          	auipc	a0,0x1
ffffffffc02009a6:	e6e50513          	addi	a0,a0,-402 # ffffffffc0201810 <etext+0x4f0>
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
ffffffffc02009d4:	00004417          	auipc	s0,0x4
ffffffffc02009d8:	72c40413          	addi	s0,s0,1836 # ffffffffc0205100 <pages>
ffffffffc02009dc:	6010                	ld	a2,0(s0)
ffffffffc02009de:	00001c97          	auipc	s9,0x1
ffffffffc02009e2:	302cbc83          	ld	s9,770(s9) # ffffffffc0201ce0 <error_string+0x38>
ffffffffc02009e6:	00001c17          	auipc	s8,0x1
ffffffffc02009ea:	302c3c03          	ld	s8,770(s8) # ffffffffc0201ce8 <nbase>
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
ffffffffc0200a22:	00004a17          	auipc	s4,0x4
ffffffffc0200a26:	5f6a0a13          	addi	s4,s4,1526 # ffffffffc0205018 <free_area>
ffffffffc0200a2a:	0b0a                	slli	s6,s6,0x2
ffffffffc0200a2c:	9b52                	add	s6,s6,s4
ffffffffc0200a2e:	00004d17          	auipc	s10,0x4
ffffffffc0200a32:	6cad0d13          	addi	s10,s10,1738 # ffffffffc02050f8 <npage>
        uintptr_t buddy_addr = base_pa ^ ((1U << (order + PGSHIFT)));
ffffffffc0200a36:	4485                	li	s1,1
        cprintf("[Buddy] Merge buddy blocks at 0x%08lx and 0x%08lx -> order %d\n",
ffffffffc0200a38:	00001997          	auipc	s3,0x1
ffffffffc0200a3c:	e4098993          	addi	s3,s3,-448 # ffffffffc0201878 <etext+0x558>
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
ffffffffc0200b26:	d9650513          	addi	a0,a0,-618 # ffffffffc02018b8 <etext+0x598>
}
ffffffffc0200b2a:	6165                	addi	sp,sp,112
    cprintf("[Buddy] Free %d pages (order %d) @ 0x%08lx\n", (1 << order), order, base_pa);
ffffffffc0200b2c:	e20ff06f          	j	ffffffffc020014c <cprintf>
    free_area.nr_free[order]++;
ffffffffc0200b30:	0c4a2603          	lw	a2,196(s4)
ffffffffc0200b34:	4525                	li	a0,9
ffffffffc0200b36:	bf41                	j	ffffffffc0200ac6 <buddy_free_pages+0x112>
ffffffffc0200b38:	028a8713          	addi	a4,s5,40
ffffffffc0200b3c:	00004a17          	auipc	s4,0x4
ffffffffc0200b40:	4dca0a13          	addi	s4,s4,1244 # ffffffffc0205018 <free_area>
ffffffffc0200b44:	00271793          	slli	a5,a4,0x2
ffffffffc0200b48:	97d2                	add	a5,a5,s4
ffffffffc0200b4a:	4390                	lw	a2,0(a5)
    base->property = order;
ffffffffc0200b4c:	000a851b          	sext.w	a0,s5
ffffffffc0200b50:	bfad                	j	ffffffffc0200aca <buddy_free_pages+0x116>
        panic("pa2page called with invalid pa");
ffffffffc0200b52:	00001617          	auipc	a2,0x1
ffffffffc0200b56:	cf660613          	addi	a2,a2,-778 # ffffffffc0201848 <etext+0x528>
ffffffffc0200b5a:	06a00593          	li	a1,106
ffffffffc0200b5e:	00001517          	auipc	a0,0x1
ffffffffc0200b62:	d0a50513          	addi	a0,a0,-758 # ffffffffc0201868 <etext+0x548>
ffffffffc0200b66:	e5cff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200b6a:	00001697          	auipc	a3,0x1
ffffffffc0200b6e:	cd668693          	addi	a3,a3,-810 # ffffffffc0201840 <etext+0x520>
ffffffffc0200b72:	00001617          	auipc	a2,0x1
ffffffffc0200b76:	abe60613          	addi	a2,a2,-1346 # ffffffffc0201630 <etext+0x310>
ffffffffc0200b7a:	06400593          	li	a1,100
ffffffffc0200b7e:	00001517          	auipc	a0,0x1
ffffffffc0200b82:	aca50513          	addi	a0,a0,-1334 # ffffffffc0201648 <etext+0x328>
ffffffffc0200b86:	e3cff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200b8a <buddy_init_memmap>:
buddy_init_memmap(struct Page *base, size_t n) {
ffffffffc0200b8a:	1141                	addi	sp,sp,-16
ffffffffc0200b8c:	e406                	sd	ra,8(sp)
ffffffffc0200b8e:	00850793          	addi	a5,a0,8
ffffffffc0200b92:	4681                	li	a3,0
    assert(n > 0);
ffffffffc0200b94:	cdf1                	beqz	a1,ffffffffc0200c70 <buddy_init_memmap+0xe6>
        assert(PageReserved(p));
ffffffffc0200b96:	6398                	ld	a4,0(a5)
ffffffffc0200b98:	8b05                	andi	a4,a4,1
ffffffffc0200b9a:	cb5d                	beqz	a4,ffffffffc0200c50 <buddy_init_memmap+0xc6>
        p->flags = 0;
ffffffffc0200b9c:	0007b023          	sd	zero,0(a5)
static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc0200ba0:	fe07ac23          	sw	zero,-8(a5)
    for (size_t i = 0; i < n; i++) {
ffffffffc0200ba4:	0685                	addi	a3,a3,1
ffffffffc0200ba6:	02878793          	addi	a5,a5,40
ffffffffc0200baa:	fed596e3          	bne	a1,a3,ffffffffc0200b96 <buddy_init_memmap+0xc>
    size_t offset = 0;
ffffffffc0200bae:	4881                	li	a7,0
ffffffffc0200bb0:	00004e97          	auipc	t4,0x4
ffffffffc0200bb4:	468e8e93          	addi	t4,t4,1128 # ffffffffc0205018 <free_area>
        while ((1U << order) > n)
ffffffffc0200bb8:	1ff00293          	li	t0,511
ffffffffc0200bbc:	4585                	li	a1,1
        int order = MAX_ORDER - 1;
ffffffffc0200bbe:	47a5                	li	a5,9
        while ((1U << order) > n)
ffffffffc0200bc0:	08d2e063          	bltu	t0,a3,ffffffffc0200c40 <buddy_init_memmap+0xb6>
            order--;
ffffffffc0200bc4:	37fd                	addiw	a5,a5,-1
        while ((1U << order) > n)
ffffffffc0200bc6:	00f5973b          	sllw	a4,a1,a5
ffffffffc0200bca:	1702                	slli	a4,a4,0x20
ffffffffc0200bcc:	9301                	srli	a4,a4,0x20
ffffffffc0200bce:	fee6ebe3          	bltu	a3,a4,ffffffffc0200bc4 <buddy_init_memmap+0x3a>
ffffffffc0200bd2:	00479813          	slli	a6,a5,0x4
        page->property = order;
ffffffffc0200bd6:	00078f9b          	sext.w	t6,a5
ffffffffc0200bda:	8e42                	mv	t3,a6
        struct Page *page = base + offset;
ffffffffc0200bdc:	00289613          	slli	a2,a7,0x2
ffffffffc0200be0:	9646                	add	a2,a2,a7
ffffffffc0200be2:	060e                	slli	a2,a2,0x3
ffffffffc0200be4:	962a                	add	a2,a2,a0
        SetPageProperty(page);
ffffffffc0200be6:	00863303          	ld	t1,8(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200bea:	9876                	add	a6,a6,t4
        free_area.nr_free[order]++;
ffffffffc0200bec:	02878793          	addi	a5,a5,40
ffffffffc0200bf0:	00883f03          	ld	t5,8(a6)
ffffffffc0200bf4:	078a                	slli	a5,a5,0x2
ffffffffc0200bf6:	97f6                	add	a5,a5,t4
        SetPageProperty(page);
ffffffffc0200bf8:	00236313          	ori	t1,t1,2
        page->property = order;
ffffffffc0200bfc:	01f62823          	sw	t6,16(a2)
        SetPageProperty(page);
ffffffffc0200c00:	00663423          	sd	t1,8(a2)
        list_add(&free_area.free_list[order], &(page->page_link));
ffffffffc0200c04:	01860f93          	addi	t6,a2,24
        free_area.nr_free[order]++;
ffffffffc0200c08:	0007a303          	lw	t1,0(a5)
    prev->next = next->prev = elm;
ffffffffc0200c0c:	01ff3023          	sd	t6,0(t5)
ffffffffc0200c10:	01f83423          	sd	t6,8(a6)
        list_add(&free_area.free_list[order], &(page->page_link));
ffffffffc0200c14:	01ce8833          	add	a6,t4,t3
    elm->next = next;
ffffffffc0200c18:	03e63023          	sd	t5,32(a2)
    elm->prev = prev;
ffffffffc0200c1c:	01063c23          	sd	a6,24(a2)
        free_area.nr_free[order]++;
ffffffffc0200c20:	0013061b          	addiw	a2,t1,1
ffffffffc0200c24:	c390                	sw	a2,0(a5)
        n -= (1U << order);
ffffffffc0200c26:	8e99                	sub	a3,a3,a4
        offset += (1U << order);
ffffffffc0200c28:	98ba                	add	a7,a7,a4
    while (n > 0) {
ffffffffc0200c2a:	fad1                	bnez	a3,ffffffffc0200bbe <buddy_init_memmap+0x34>
}
ffffffffc0200c2c:	60a2                	ld	ra,8(sp)
    cprintf("[Buddy] Initialized memory map: %zu pages (%d orders)\n", n, MAX_ORDER);
ffffffffc0200c2e:	4629                	li	a2,10
ffffffffc0200c30:	4581                	li	a1,0
ffffffffc0200c32:	00001517          	auipc	a0,0x1
ffffffffc0200c36:	cc650513          	addi	a0,a0,-826 # ffffffffc02018f8 <etext+0x5d8>
}
ffffffffc0200c3a:	0141                	addi	sp,sp,16
    cprintf("[Buddy] Initialized memory map: %zu pages (%d orders)\n", n, MAX_ORDER);
ffffffffc0200c3c:	d10ff06f          	j	ffffffffc020014c <cprintf>
        while ((1U << order) > n)
ffffffffc0200c40:	09000e13          	li	t3,144
ffffffffc0200c44:	4fa5                	li	t6,9
ffffffffc0200c46:	20000713          	li	a4,512
ffffffffc0200c4a:	09000813          	li	a6,144
ffffffffc0200c4e:	b779                	j	ffffffffc0200bdc <buddy_init_memmap+0x52>
        assert(PageReserved(p));
ffffffffc0200c50:	00001697          	auipc	a3,0x1
ffffffffc0200c54:	c9868693          	addi	a3,a3,-872 # ffffffffc02018e8 <etext+0x5c8>
ffffffffc0200c58:	00001617          	auipc	a2,0x1
ffffffffc0200c5c:	9d860613          	addi	a2,a2,-1576 # ffffffffc0201630 <etext+0x310>
ffffffffc0200c60:	02600593          	li	a1,38
ffffffffc0200c64:	00001517          	auipc	a0,0x1
ffffffffc0200c68:	9e450513          	addi	a0,a0,-1564 # ffffffffc0201648 <etext+0x328>
ffffffffc0200c6c:	d56ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200c70:	00001697          	auipc	a3,0x1
ffffffffc0200c74:	bd068693          	addi	a3,a3,-1072 # ffffffffc0201840 <etext+0x520>
ffffffffc0200c78:	00001617          	auipc	a2,0x1
ffffffffc0200c7c:	9b860613          	addi	a2,a2,-1608 # ffffffffc0201630 <etext+0x310>
ffffffffc0200c80:	02300593          	li	a1,35
ffffffffc0200c84:	00001517          	auipc	a0,0x1
ffffffffc0200c88:	9c450513          	addi	a0,a0,-1596 # ffffffffc0201648 <etext+0x328>
ffffffffc0200c8c:	d36ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200c90 <alloc_pages>:
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
    return pmm_manager->alloc_pages(n);
ffffffffc0200c90:	00004797          	auipc	a5,0x4
ffffffffc0200c94:	4787b783          	ld	a5,1144(a5) # ffffffffc0205108 <pmm_manager>
ffffffffc0200c98:	6f9c                	ld	a5,24(a5)
ffffffffc0200c9a:	8782                	jr	a5

ffffffffc0200c9c <free_pages>:
}

// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    pmm_manager->free_pages(base, n);
ffffffffc0200c9c:	00004797          	auipc	a5,0x4
ffffffffc0200ca0:	46c7b783          	ld	a5,1132(a5) # ffffffffc0205108 <pmm_manager>
ffffffffc0200ca4:	739c                	ld	a5,32(a5)
ffffffffc0200ca6:	8782                	jr	a5

ffffffffc0200ca8 <nr_free_pages>:
}

// nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE)
// of current free memory
size_t nr_free_pages(void) {
    return pmm_manager->nr_free_pages();
ffffffffc0200ca8:	00004797          	auipc	a5,0x4
ffffffffc0200cac:	4607b783          	ld	a5,1120(a5) # ffffffffc0205108 <pmm_manager>
ffffffffc0200cb0:	779c                	ld	a5,40(a5)
ffffffffc0200cb2:	8782                	jr	a5

ffffffffc0200cb4 <pmm_init>:
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200cb4:	00001797          	auipc	a5,0x1
ffffffffc0200cb8:	c9478793          	addi	a5,a5,-876 # ffffffffc0201948 <buddy_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200cbc:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0200cbe:	7179                	addi	sp,sp,-48
ffffffffc0200cc0:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200cc2:	00001517          	auipc	a0,0x1
ffffffffc0200cc6:	cbe50513          	addi	a0,a0,-834 # ffffffffc0201980 <buddy_pmm_manager+0x38>
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200cca:	00004417          	auipc	s0,0x4
ffffffffc0200cce:	43e40413          	addi	s0,s0,1086 # ffffffffc0205108 <pmm_manager>
void pmm_init(void) {
ffffffffc0200cd2:	f406                	sd	ra,40(sp)
ffffffffc0200cd4:	ec26                	sd	s1,24(sp)
ffffffffc0200cd6:	e44e                	sd	s3,8(sp)
ffffffffc0200cd8:	e84a                	sd	s2,16(sp)
ffffffffc0200cda:	e052                	sd	s4,0(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200cdc:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200cde:	c6eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    pmm_manager->init();
ffffffffc0200ce2:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200ce4:	00004497          	auipc	s1,0x4
ffffffffc0200ce8:	43c48493          	addi	s1,s1,1084 # ffffffffc0205120 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200cec:	679c                	ld	a5,8(a5)
ffffffffc0200cee:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200cf0:	57f5                	li	a5,-3
ffffffffc0200cf2:	07fa                	slli	a5,a5,0x1e
ffffffffc0200cf4:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0200cf6:	8c7ff0ef          	jal	ra,ffffffffc02005bc <get_memory_base>
ffffffffc0200cfa:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0200cfc:	8cbff0ef          	jal	ra,ffffffffc02005c6 <get_memory_size>
    if (mem_size == 0) {
ffffffffc0200d00:	14050d63          	beqz	a0,ffffffffc0200e5a <pmm_init+0x1a6>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200d04:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0200d06:	00001517          	auipc	a0,0x1
ffffffffc0200d0a:	cc250513          	addi	a0,a0,-830 # ffffffffc02019c8 <buddy_pmm_manager+0x80>
ffffffffc0200d0e:	c3eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200d12:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0200d16:	864e                	mv	a2,s3
ffffffffc0200d18:	fffa0693          	addi	a3,s4,-1
ffffffffc0200d1c:	85ca                	mv	a1,s2
ffffffffc0200d1e:	00001517          	auipc	a0,0x1
ffffffffc0200d22:	cc250513          	addi	a0,a0,-830 # ffffffffc02019e0 <buddy_pmm_manager+0x98>
ffffffffc0200d26:	c26ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200d2a:	c80007b7          	lui	a5,0xc8000
ffffffffc0200d2e:	8652                	mv	a2,s4
ffffffffc0200d30:	0d47e463          	bltu	a5,s4,ffffffffc0200df8 <pmm_init+0x144>
ffffffffc0200d34:	00005797          	auipc	a5,0x5
ffffffffc0200d38:	3f378793          	addi	a5,a5,1011 # ffffffffc0206127 <end+0xfff>
ffffffffc0200d3c:	757d                	lui	a0,0xfffff
ffffffffc0200d3e:	8d7d                	and	a0,a0,a5
ffffffffc0200d40:	8231                	srli	a2,a2,0xc
ffffffffc0200d42:	00004797          	auipc	a5,0x4
ffffffffc0200d46:	3ac7bb23          	sd	a2,950(a5) # ffffffffc02050f8 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200d4a:	00004797          	auipc	a5,0x4
ffffffffc0200d4e:	3aa7bb23          	sd	a0,950(a5) # ffffffffc0205100 <pages>
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200d52:	000807b7          	lui	a5,0x80
ffffffffc0200d56:	002005b7          	lui	a1,0x200
ffffffffc0200d5a:	02f60563          	beq	a2,a5,ffffffffc0200d84 <pmm_init+0xd0>
ffffffffc0200d5e:	00261593          	slli	a1,a2,0x2
ffffffffc0200d62:	00c586b3          	add	a3,a1,a2
ffffffffc0200d66:	fec007b7          	lui	a5,0xfec00
ffffffffc0200d6a:	97aa                	add	a5,a5,a0
ffffffffc0200d6c:	068e                	slli	a3,a3,0x3
ffffffffc0200d6e:	96be                	add	a3,a3,a5
ffffffffc0200d70:	87aa                	mv	a5,a0
        SetPageReserved(pages + i);
ffffffffc0200d72:	6798                	ld	a4,8(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200d74:	02878793          	addi	a5,a5,40 # fffffffffec00028 <end+0x3e9faf00>
        SetPageReserved(pages + i);
ffffffffc0200d78:	00176713          	ori	a4,a4,1
ffffffffc0200d7c:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200d80:	fef699e3          	bne	a3,a5,ffffffffc0200d72 <pmm_init+0xbe>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200d84:	95b2                	add	a1,a1,a2
ffffffffc0200d86:	fec006b7          	lui	a3,0xfec00
ffffffffc0200d8a:	96aa                	add	a3,a3,a0
ffffffffc0200d8c:	058e                	slli	a1,a1,0x3
ffffffffc0200d8e:	96ae                	add	a3,a3,a1
ffffffffc0200d90:	c02007b7          	lui	a5,0xc0200
ffffffffc0200d94:	0af6e763          	bltu	a3,a5,ffffffffc0200e42 <pmm_init+0x18e>
ffffffffc0200d98:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0200d9a:	77fd                	lui	a5,0xfffff
ffffffffc0200d9c:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200da0:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc0200da2:	04b6ee63          	bltu	a3,a1,ffffffffc0200dfe <pmm_init+0x14a>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0200da6:	601c                	ld	a5,0(s0)
ffffffffc0200da8:	7b9c                	ld	a5,48(a5)
ffffffffc0200daa:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0200dac:	00001517          	auipc	a0,0x1
ffffffffc0200db0:	c8c50513          	addi	a0,a0,-884 # ffffffffc0201a38 <buddy_pmm_manager+0xf0>
ffffffffc0200db4:	b98ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0200db8:	00003597          	auipc	a1,0x3
ffffffffc0200dbc:	24858593          	addi	a1,a1,584 # ffffffffc0204000 <boot_page_table_sv39>
ffffffffc0200dc0:	00004797          	auipc	a5,0x4
ffffffffc0200dc4:	34b7bc23          	sd	a1,856(a5) # ffffffffc0205118 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200dc8:	c02007b7          	lui	a5,0xc0200
ffffffffc0200dcc:	0af5e363          	bltu	a1,a5,ffffffffc0200e72 <pmm_init+0x1be>
ffffffffc0200dd0:	6090                	ld	a2,0(s1)
}
ffffffffc0200dd2:	7402                	ld	s0,32(sp)
ffffffffc0200dd4:	70a2                	ld	ra,40(sp)
ffffffffc0200dd6:	64e2                	ld	s1,24(sp)
ffffffffc0200dd8:	6942                	ld	s2,16(sp)
ffffffffc0200dda:	69a2                	ld	s3,8(sp)
ffffffffc0200ddc:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0200dde:	40c58633          	sub	a2,a1,a2
ffffffffc0200de2:	00004797          	auipc	a5,0x4
ffffffffc0200de6:	32c7b723          	sd	a2,814(a5) # ffffffffc0205110 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200dea:	00001517          	auipc	a0,0x1
ffffffffc0200dee:	c6e50513          	addi	a0,a0,-914 # ffffffffc0201a58 <buddy_pmm_manager+0x110>
}
ffffffffc0200df2:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200df4:	b58ff06f          	j	ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200df8:	c8000637          	lui	a2,0xc8000
ffffffffc0200dfc:	bf25                	j	ffffffffc0200d34 <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0200dfe:	6705                	lui	a4,0x1
ffffffffc0200e00:	177d                	addi	a4,a4,-1
ffffffffc0200e02:	96ba                	add	a3,a3,a4
ffffffffc0200e04:	8efd                	and	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0200e06:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200e0a:	02c7f063          	bgeu	a5,a2,ffffffffc0200e2a <pmm_init+0x176>
    pmm_manager->init_memmap(base, n);
ffffffffc0200e0e:	6010                	ld	a2,0(s0)
    return &pages[PPN(pa) - nbase];
ffffffffc0200e10:	fff80737          	lui	a4,0xfff80
ffffffffc0200e14:	973e                	add	a4,a4,a5
ffffffffc0200e16:	00271793          	slli	a5,a4,0x2
ffffffffc0200e1a:	97ba                	add	a5,a5,a4
ffffffffc0200e1c:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200e1e:	8d95                	sub	a1,a1,a3
ffffffffc0200e20:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc0200e22:	81b1                	srli	a1,a1,0xc
ffffffffc0200e24:	953e                	add	a0,a0,a5
ffffffffc0200e26:	9702                	jalr	a4
}
ffffffffc0200e28:	bfbd                	j	ffffffffc0200da6 <pmm_init+0xf2>
        panic("pa2page called with invalid pa");
ffffffffc0200e2a:	00001617          	auipc	a2,0x1
ffffffffc0200e2e:	a1e60613          	addi	a2,a2,-1506 # ffffffffc0201848 <etext+0x528>
ffffffffc0200e32:	06a00593          	li	a1,106
ffffffffc0200e36:	00001517          	auipc	a0,0x1
ffffffffc0200e3a:	a3250513          	addi	a0,a0,-1486 # ffffffffc0201868 <etext+0x548>
ffffffffc0200e3e:	b84ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200e42:	00001617          	auipc	a2,0x1
ffffffffc0200e46:	bce60613          	addi	a2,a2,-1074 # ffffffffc0201a10 <buddy_pmm_manager+0xc8>
ffffffffc0200e4a:	05f00593          	li	a1,95
ffffffffc0200e4e:	00001517          	auipc	a0,0x1
ffffffffc0200e52:	b6a50513          	addi	a0,a0,-1174 # ffffffffc02019b8 <buddy_pmm_manager+0x70>
ffffffffc0200e56:	b6cff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        panic("DTB memory info not available");
ffffffffc0200e5a:	00001617          	auipc	a2,0x1
ffffffffc0200e5e:	b3e60613          	addi	a2,a2,-1218 # ffffffffc0201998 <buddy_pmm_manager+0x50>
ffffffffc0200e62:	04700593          	li	a1,71
ffffffffc0200e66:	00001517          	auipc	a0,0x1
ffffffffc0200e6a:	b5250513          	addi	a0,a0,-1198 # ffffffffc02019b8 <buddy_pmm_manager+0x70>
ffffffffc0200e6e:	b54ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200e72:	86ae                	mv	a3,a1
ffffffffc0200e74:	00001617          	auipc	a2,0x1
ffffffffc0200e78:	b9c60613          	addi	a2,a2,-1124 # ffffffffc0201a10 <buddy_pmm_manager+0xc8>
ffffffffc0200e7c:	07a00593          	li	a1,122
ffffffffc0200e80:	00001517          	auipc	a0,0x1
ffffffffc0200e84:	b3850513          	addi	a0,a0,-1224 # ffffffffc02019b8 <buddy_pmm_manager+0x70>
ffffffffc0200e88:	b3aff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200e8c <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0200e8c:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200e90:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0200e92:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200e96:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0200e98:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200e9c:	f022                	sd	s0,32(sp)
ffffffffc0200e9e:	ec26                	sd	s1,24(sp)
ffffffffc0200ea0:	e84a                	sd	s2,16(sp)
ffffffffc0200ea2:	f406                	sd	ra,40(sp)
ffffffffc0200ea4:	e44e                	sd	s3,8(sp)
ffffffffc0200ea6:	84aa                	mv	s1,a0
ffffffffc0200ea8:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0200eaa:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0200eae:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0200eb0:	03067e63          	bgeu	a2,a6,ffffffffc0200eec <printnum+0x60>
ffffffffc0200eb4:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0200eb6:	00805763          	blez	s0,ffffffffc0200ec4 <printnum+0x38>
ffffffffc0200eba:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0200ebc:	85ca                	mv	a1,s2
ffffffffc0200ebe:	854e                	mv	a0,s3
ffffffffc0200ec0:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0200ec2:	fc65                	bnez	s0,ffffffffc0200eba <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200ec4:	1a02                	slli	s4,s4,0x20
ffffffffc0200ec6:	00001797          	auipc	a5,0x1
ffffffffc0200eca:	bd278793          	addi	a5,a5,-1070 # ffffffffc0201a98 <buddy_pmm_manager+0x150>
ffffffffc0200ece:	020a5a13          	srli	s4,s4,0x20
ffffffffc0200ed2:	9a3e                	add	s4,s4,a5
}
ffffffffc0200ed4:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200ed6:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0200eda:	70a2                	ld	ra,40(sp)
ffffffffc0200edc:	69a2                	ld	s3,8(sp)
ffffffffc0200ede:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200ee0:	85ca                	mv	a1,s2
ffffffffc0200ee2:	87a6                	mv	a5,s1
}
ffffffffc0200ee4:	6942                	ld	s2,16(sp)
ffffffffc0200ee6:	64e2                	ld	s1,24(sp)
ffffffffc0200ee8:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200eea:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0200eec:	03065633          	divu	a2,a2,a6
ffffffffc0200ef0:	8722                	mv	a4,s0
ffffffffc0200ef2:	f9bff0ef          	jal	ra,ffffffffc0200e8c <printnum>
ffffffffc0200ef6:	b7f9                	j	ffffffffc0200ec4 <printnum+0x38>

ffffffffc0200ef8 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0200ef8:	7119                	addi	sp,sp,-128
ffffffffc0200efa:	f4a6                	sd	s1,104(sp)
ffffffffc0200efc:	f0ca                	sd	s2,96(sp)
ffffffffc0200efe:	ecce                	sd	s3,88(sp)
ffffffffc0200f00:	e8d2                	sd	s4,80(sp)
ffffffffc0200f02:	e4d6                	sd	s5,72(sp)
ffffffffc0200f04:	e0da                	sd	s6,64(sp)
ffffffffc0200f06:	fc5e                	sd	s7,56(sp)
ffffffffc0200f08:	f06a                	sd	s10,32(sp)
ffffffffc0200f0a:	fc86                	sd	ra,120(sp)
ffffffffc0200f0c:	f8a2                	sd	s0,112(sp)
ffffffffc0200f0e:	f862                	sd	s8,48(sp)
ffffffffc0200f10:	f466                	sd	s9,40(sp)
ffffffffc0200f12:	ec6e                	sd	s11,24(sp)
ffffffffc0200f14:	892a                	mv	s2,a0
ffffffffc0200f16:	84ae                	mv	s1,a1
ffffffffc0200f18:	8d32                	mv	s10,a2
ffffffffc0200f1a:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200f1c:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0200f20:	5b7d                	li	s6,-1
ffffffffc0200f22:	00001a97          	auipc	s5,0x1
ffffffffc0200f26:	baaa8a93          	addi	s5,s5,-1110 # ffffffffc0201acc <buddy_pmm_manager+0x184>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0200f2a:	00001b97          	auipc	s7,0x1
ffffffffc0200f2e:	d7eb8b93          	addi	s7,s7,-642 # ffffffffc0201ca8 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200f32:	000d4503          	lbu	a0,0(s10)
ffffffffc0200f36:	001d0413          	addi	s0,s10,1
ffffffffc0200f3a:	01350a63          	beq	a0,s3,ffffffffc0200f4e <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0200f3e:	c121                	beqz	a0,ffffffffc0200f7e <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0200f40:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200f42:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0200f44:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200f46:	fff44503          	lbu	a0,-1(s0)
ffffffffc0200f4a:	ff351ae3          	bne	a0,s3,ffffffffc0200f3e <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f4e:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0200f52:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0200f56:	4c81                	li	s9,0
ffffffffc0200f58:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0200f5a:	5c7d                	li	s8,-1
ffffffffc0200f5c:	5dfd                	li	s11,-1
ffffffffc0200f5e:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0200f62:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f64:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0200f68:	0ff5f593          	zext.b	a1,a1
ffffffffc0200f6c:	00140d13          	addi	s10,s0,1
ffffffffc0200f70:	04b56263          	bltu	a0,a1,ffffffffc0200fb4 <vprintfmt+0xbc>
ffffffffc0200f74:	058a                	slli	a1,a1,0x2
ffffffffc0200f76:	95d6                	add	a1,a1,s5
ffffffffc0200f78:	4194                	lw	a3,0(a1)
ffffffffc0200f7a:	96d6                	add	a3,a3,s5
ffffffffc0200f7c:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0200f7e:	70e6                	ld	ra,120(sp)
ffffffffc0200f80:	7446                	ld	s0,112(sp)
ffffffffc0200f82:	74a6                	ld	s1,104(sp)
ffffffffc0200f84:	7906                	ld	s2,96(sp)
ffffffffc0200f86:	69e6                	ld	s3,88(sp)
ffffffffc0200f88:	6a46                	ld	s4,80(sp)
ffffffffc0200f8a:	6aa6                	ld	s5,72(sp)
ffffffffc0200f8c:	6b06                	ld	s6,64(sp)
ffffffffc0200f8e:	7be2                	ld	s7,56(sp)
ffffffffc0200f90:	7c42                	ld	s8,48(sp)
ffffffffc0200f92:	7ca2                	ld	s9,40(sp)
ffffffffc0200f94:	7d02                	ld	s10,32(sp)
ffffffffc0200f96:	6de2                	ld	s11,24(sp)
ffffffffc0200f98:	6109                	addi	sp,sp,128
ffffffffc0200f9a:	8082                	ret
            padc = '0';
ffffffffc0200f9c:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0200f9e:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200fa2:	846a                	mv	s0,s10
ffffffffc0200fa4:	00140d13          	addi	s10,s0,1
ffffffffc0200fa8:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0200fac:	0ff5f593          	zext.b	a1,a1
ffffffffc0200fb0:	fcb572e3          	bgeu	a0,a1,ffffffffc0200f74 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0200fb4:	85a6                	mv	a1,s1
ffffffffc0200fb6:	02500513          	li	a0,37
ffffffffc0200fba:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0200fbc:	fff44783          	lbu	a5,-1(s0)
ffffffffc0200fc0:	8d22                	mv	s10,s0
ffffffffc0200fc2:	f73788e3          	beq	a5,s3,ffffffffc0200f32 <vprintfmt+0x3a>
ffffffffc0200fc6:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0200fca:	1d7d                	addi	s10,s10,-1
ffffffffc0200fcc:	ff379de3          	bne	a5,s3,ffffffffc0200fc6 <vprintfmt+0xce>
ffffffffc0200fd0:	b78d                	j	ffffffffc0200f32 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0200fd2:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0200fd6:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200fda:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0200fdc:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0200fe0:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0200fe4:	02d86463          	bltu	a6,a3,ffffffffc020100c <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0200fe8:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0200fec:	002c169b          	slliw	a3,s8,0x2
ffffffffc0200ff0:	0186873b          	addw	a4,a3,s8
ffffffffc0200ff4:	0017171b          	slliw	a4,a4,0x1
ffffffffc0200ff8:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0200ffa:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0200ffe:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0201000:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0201004:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201008:	fed870e3          	bgeu	a6,a3,ffffffffc0200fe8 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc020100c:	f40ddce3          	bgez	s11,ffffffffc0200f64 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201010:	8de2                	mv	s11,s8
ffffffffc0201012:	5c7d                	li	s8,-1
ffffffffc0201014:	bf81                	j	ffffffffc0200f64 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201016:	fffdc693          	not	a3,s11
ffffffffc020101a:	96fd                	srai	a3,a3,0x3f
ffffffffc020101c:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201020:	00144603          	lbu	a2,1(s0)
ffffffffc0201024:	2d81                	sext.w	s11,s11
ffffffffc0201026:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201028:	bf35                	j	ffffffffc0200f64 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc020102a:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020102e:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201032:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201034:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201036:	bfd9                	j	ffffffffc020100c <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201038:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020103a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020103e:	01174463          	blt	a4,a7,ffffffffc0201046 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201042:	1a088e63          	beqz	a7,ffffffffc02011fe <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201046:	000a3603          	ld	a2,0(s4)
ffffffffc020104a:	46c1                	li	a3,16
ffffffffc020104c:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc020104e:	2781                	sext.w	a5,a5
ffffffffc0201050:	876e                	mv	a4,s11
ffffffffc0201052:	85a6                	mv	a1,s1
ffffffffc0201054:	854a                	mv	a0,s2
ffffffffc0201056:	e37ff0ef          	jal	ra,ffffffffc0200e8c <printnum>
            break;
ffffffffc020105a:	bde1                	j	ffffffffc0200f32 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc020105c:	000a2503          	lw	a0,0(s4)
ffffffffc0201060:	85a6                	mv	a1,s1
ffffffffc0201062:	0a21                	addi	s4,s4,8
ffffffffc0201064:	9902                	jalr	s2
            break;
ffffffffc0201066:	b5f1                	j	ffffffffc0200f32 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201068:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020106a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020106e:	01174463          	blt	a4,a7,ffffffffc0201076 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201072:	18088163          	beqz	a7,ffffffffc02011f4 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201076:	000a3603          	ld	a2,0(s4)
ffffffffc020107a:	46a9                	li	a3,10
ffffffffc020107c:	8a2e                	mv	s4,a1
ffffffffc020107e:	bfc1                	j	ffffffffc020104e <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201080:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201084:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201086:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201088:	bdf1                	j	ffffffffc0200f64 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc020108a:	85a6                	mv	a1,s1
ffffffffc020108c:	02500513          	li	a0,37
ffffffffc0201090:	9902                	jalr	s2
            break;
ffffffffc0201092:	b545                	j	ffffffffc0200f32 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201094:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201098:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020109a:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020109c:	b5e1                	j	ffffffffc0200f64 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc020109e:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02010a0:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02010a4:	01174463          	blt	a4,a7,ffffffffc02010ac <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc02010a8:	14088163          	beqz	a7,ffffffffc02011ea <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc02010ac:	000a3603          	ld	a2,0(s4)
ffffffffc02010b0:	46a1                	li	a3,8
ffffffffc02010b2:	8a2e                	mv	s4,a1
ffffffffc02010b4:	bf69                	j	ffffffffc020104e <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc02010b6:	03000513          	li	a0,48
ffffffffc02010ba:	85a6                	mv	a1,s1
ffffffffc02010bc:	e03e                	sd	a5,0(sp)
ffffffffc02010be:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc02010c0:	85a6                	mv	a1,s1
ffffffffc02010c2:	07800513          	li	a0,120
ffffffffc02010c6:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02010c8:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc02010ca:	6782                	ld	a5,0(sp)
ffffffffc02010cc:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02010ce:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc02010d2:	bfb5                	j	ffffffffc020104e <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02010d4:	000a3403          	ld	s0,0(s4)
ffffffffc02010d8:	008a0713          	addi	a4,s4,8
ffffffffc02010dc:	e03a                	sd	a4,0(sp)
ffffffffc02010de:	14040263          	beqz	s0,ffffffffc0201222 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc02010e2:	0fb05763          	blez	s11,ffffffffc02011d0 <vprintfmt+0x2d8>
ffffffffc02010e6:	02d00693          	li	a3,45
ffffffffc02010ea:	0cd79163          	bne	a5,a3,ffffffffc02011ac <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02010ee:	00044783          	lbu	a5,0(s0)
ffffffffc02010f2:	0007851b          	sext.w	a0,a5
ffffffffc02010f6:	cf85                	beqz	a5,ffffffffc020112e <vprintfmt+0x236>
ffffffffc02010f8:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02010fc:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201100:	000c4563          	bltz	s8,ffffffffc020110a <vprintfmt+0x212>
ffffffffc0201104:	3c7d                	addiw	s8,s8,-1
ffffffffc0201106:	036c0263          	beq	s8,s6,ffffffffc020112a <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc020110a:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020110c:	0e0c8e63          	beqz	s9,ffffffffc0201208 <vprintfmt+0x310>
ffffffffc0201110:	3781                	addiw	a5,a5,-32
ffffffffc0201112:	0ef47b63          	bgeu	s0,a5,ffffffffc0201208 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201116:	03f00513          	li	a0,63
ffffffffc020111a:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020111c:	000a4783          	lbu	a5,0(s4)
ffffffffc0201120:	3dfd                	addiw	s11,s11,-1
ffffffffc0201122:	0a05                	addi	s4,s4,1
ffffffffc0201124:	0007851b          	sext.w	a0,a5
ffffffffc0201128:	ffe1                	bnez	a5,ffffffffc0201100 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc020112a:	01b05963          	blez	s11,ffffffffc020113c <vprintfmt+0x244>
ffffffffc020112e:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201130:	85a6                	mv	a1,s1
ffffffffc0201132:	02000513          	li	a0,32
ffffffffc0201136:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201138:	fe0d9be3          	bnez	s11,ffffffffc020112e <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020113c:	6a02                	ld	s4,0(sp)
ffffffffc020113e:	bbd5                	j	ffffffffc0200f32 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201140:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201142:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201146:	01174463          	blt	a4,a7,ffffffffc020114e <vprintfmt+0x256>
    else if (lflag) {
ffffffffc020114a:	08088d63          	beqz	a7,ffffffffc02011e4 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc020114e:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201152:	0a044d63          	bltz	s0,ffffffffc020120c <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201156:	8622                	mv	a2,s0
ffffffffc0201158:	8a66                	mv	s4,s9
ffffffffc020115a:	46a9                	li	a3,10
ffffffffc020115c:	bdcd                	j	ffffffffc020104e <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc020115e:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201162:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201164:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201166:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc020116a:	8fb5                	xor	a5,a5,a3
ffffffffc020116c:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201170:	02d74163          	blt	a4,a3,ffffffffc0201192 <vprintfmt+0x29a>
ffffffffc0201174:	00369793          	slli	a5,a3,0x3
ffffffffc0201178:	97de                	add	a5,a5,s7
ffffffffc020117a:	639c                	ld	a5,0(a5)
ffffffffc020117c:	cb99                	beqz	a5,ffffffffc0201192 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc020117e:	86be                	mv	a3,a5
ffffffffc0201180:	00001617          	auipc	a2,0x1
ffffffffc0201184:	94860613          	addi	a2,a2,-1720 # ffffffffc0201ac8 <buddy_pmm_manager+0x180>
ffffffffc0201188:	85a6                	mv	a1,s1
ffffffffc020118a:	854a                	mv	a0,s2
ffffffffc020118c:	0ce000ef          	jal	ra,ffffffffc020125a <printfmt>
ffffffffc0201190:	b34d                	j	ffffffffc0200f32 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201192:	00001617          	auipc	a2,0x1
ffffffffc0201196:	92660613          	addi	a2,a2,-1754 # ffffffffc0201ab8 <buddy_pmm_manager+0x170>
ffffffffc020119a:	85a6                	mv	a1,s1
ffffffffc020119c:	854a                	mv	a0,s2
ffffffffc020119e:	0bc000ef          	jal	ra,ffffffffc020125a <printfmt>
ffffffffc02011a2:	bb41                	j	ffffffffc0200f32 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc02011a4:	00001417          	auipc	s0,0x1
ffffffffc02011a8:	90c40413          	addi	s0,s0,-1780 # ffffffffc0201ab0 <buddy_pmm_manager+0x168>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02011ac:	85e2                	mv	a1,s8
ffffffffc02011ae:	8522                	mv	a0,s0
ffffffffc02011b0:	e43e                	sd	a5,8(sp)
ffffffffc02011b2:	0fc000ef          	jal	ra,ffffffffc02012ae <strnlen>
ffffffffc02011b6:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02011ba:	01b05b63          	blez	s11,ffffffffc02011d0 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc02011be:	67a2                	ld	a5,8(sp)
ffffffffc02011c0:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02011c4:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc02011c6:	85a6                	mv	a1,s1
ffffffffc02011c8:	8552                	mv	a0,s4
ffffffffc02011ca:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02011cc:	fe0d9ce3          	bnez	s11,ffffffffc02011c4 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02011d0:	00044783          	lbu	a5,0(s0)
ffffffffc02011d4:	00140a13          	addi	s4,s0,1
ffffffffc02011d8:	0007851b          	sext.w	a0,a5
ffffffffc02011dc:	d3a5                	beqz	a5,ffffffffc020113c <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02011de:	05e00413          	li	s0,94
ffffffffc02011e2:	bf39                	j	ffffffffc0201100 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc02011e4:	000a2403          	lw	s0,0(s4)
ffffffffc02011e8:	b7ad                	j	ffffffffc0201152 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc02011ea:	000a6603          	lwu	a2,0(s4)
ffffffffc02011ee:	46a1                	li	a3,8
ffffffffc02011f0:	8a2e                	mv	s4,a1
ffffffffc02011f2:	bdb1                	j	ffffffffc020104e <vprintfmt+0x156>
ffffffffc02011f4:	000a6603          	lwu	a2,0(s4)
ffffffffc02011f8:	46a9                	li	a3,10
ffffffffc02011fa:	8a2e                	mv	s4,a1
ffffffffc02011fc:	bd89                	j	ffffffffc020104e <vprintfmt+0x156>
ffffffffc02011fe:	000a6603          	lwu	a2,0(s4)
ffffffffc0201202:	46c1                	li	a3,16
ffffffffc0201204:	8a2e                	mv	s4,a1
ffffffffc0201206:	b5a1                	j	ffffffffc020104e <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201208:	9902                	jalr	s2
ffffffffc020120a:	bf09                	j	ffffffffc020111c <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc020120c:	85a6                	mv	a1,s1
ffffffffc020120e:	02d00513          	li	a0,45
ffffffffc0201212:	e03e                	sd	a5,0(sp)
ffffffffc0201214:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201216:	6782                	ld	a5,0(sp)
ffffffffc0201218:	8a66                	mv	s4,s9
ffffffffc020121a:	40800633          	neg	a2,s0
ffffffffc020121e:	46a9                	li	a3,10
ffffffffc0201220:	b53d                	j	ffffffffc020104e <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201222:	03b05163          	blez	s11,ffffffffc0201244 <vprintfmt+0x34c>
ffffffffc0201226:	02d00693          	li	a3,45
ffffffffc020122a:	f6d79de3          	bne	a5,a3,ffffffffc02011a4 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc020122e:	00001417          	auipc	s0,0x1
ffffffffc0201232:	88240413          	addi	s0,s0,-1918 # ffffffffc0201ab0 <buddy_pmm_manager+0x168>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201236:	02800793          	li	a5,40
ffffffffc020123a:	02800513          	li	a0,40
ffffffffc020123e:	00140a13          	addi	s4,s0,1
ffffffffc0201242:	bd6d                	j	ffffffffc02010fc <vprintfmt+0x204>
ffffffffc0201244:	00001a17          	auipc	s4,0x1
ffffffffc0201248:	86da0a13          	addi	s4,s4,-1939 # ffffffffc0201ab1 <buddy_pmm_manager+0x169>
ffffffffc020124c:	02800513          	li	a0,40
ffffffffc0201250:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201254:	05e00413          	li	s0,94
ffffffffc0201258:	b565                	j	ffffffffc0201100 <vprintfmt+0x208>

ffffffffc020125a <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020125a:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc020125c:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201260:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201262:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201264:	ec06                	sd	ra,24(sp)
ffffffffc0201266:	f83a                	sd	a4,48(sp)
ffffffffc0201268:	fc3e                	sd	a5,56(sp)
ffffffffc020126a:	e0c2                	sd	a6,64(sp)
ffffffffc020126c:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020126e:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201270:	c89ff0ef          	jal	ra,ffffffffc0200ef8 <vprintfmt>
}
ffffffffc0201274:	60e2                	ld	ra,24(sp)
ffffffffc0201276:	6161                	addi	sp,sp,80
ffffffffc0201278:	8082                	ret

ffffffffc020127a <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc020127a:	4781                	li	a5,0
ffffffffc020127c:	00004717          	auipc	a4,0x4
ffffffffc0201280:	d9473703          	ld	a4,-620(a4) # ffffffffc0205010 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201284:	88ba                	mv	a7,a4
ffffffffc0201286:	852a                	mv	a0,a0
ffffffffc0201288:	85be                	mv	a1,a5
ffffffffc020128a:	863e                	mv	a2,a5
ffffffffc020128c:	00000073          	ecall
ffffffffc0201290:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201292:	8082                	ret

ffffffffc0201294 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201294:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201298:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc020129a:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc020129c:	cb81                	beqz	a5,ffffffffc02012ac <strlen+0x18>
        cnt ++;
ffffffffc020129e:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02012a0:	00a707b3          	add	a5,a4,a0
ffffffffc02012a4:	0007c783          	lbu	a5,0(a5)
ffffffffc02012a8:	fbfd                	bnez	a5,ffffffffc020129e <strlen+0xa>
ffffffffc02012aa:	8082                	ret
    }
    return cnt;
}
ffffffffc02012ac:	8082                	ret

ffffffffc02012ae <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc02012ae:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc02012b0:	e589                	bnez	a1,ffffffffc02012ba <strnlen+0xc>
ffffffffc02012b2:	a811                	j	ffffffffc02012c6 <strnlen+0x18>
        cnt ++;
ffffffffc02012b4:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc02012b6:	00f58863          	beq	a1,a5,ffffffffc02012c6 <strnlen+0x18>
ffffffffc02012ba:	00f50733          	add	a4,a0,a5
ffffffffc02012be:	00074703          	lbu	a4,0(a4)
ffffffffc02012c2:	fb6d                	bnez	a4,ffffffffc02012b4 <strnlen+0x6>
ffffffffc02012c4:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc02012c6:	852e                	mv	a0,a1
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02012ca:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02012ce:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02012d2:	cb89                	beqz	a5,ffffffffc02012e4 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc02012d4:	0505                	addi	a0,a0,1
ffffffffc02012d6:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02012d8:	fee789e3          	beq	a5,a4,ffffffffc02012ca <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02012dc:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc02012e0:	9d19                	subw	a0,a0,a4
ffffffffc02012e2:	8082                	ret
ffffffffc02012e4:	4501                	li	a0,0
ffffffffc02012e6:	bfed                	j	ffffffffc02012e0 <strcmp+0x16>

ffffffffc02012e8 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02012e8:	c20d                	beqz	a2,ffffffffc020130a <strncmp+0x22>
ffffffffc02012ea:	962e                	add	a2,a2,a1
ffffffffc02012ec:	a031                	j	ffffffffc02012f8 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc02012ee:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02012f0:	00e79a63          	bne	a5,a4,ffffffffc0201304 <strncmp+0x1c>
ffffffffc02012f4:	00b60b63          	beq	a2,a1,ffffffffc020130a <strncmp+0x22>
ffffffffc02012f8:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc02012fc:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02012fe:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0201302:	f7f5                	bnez	a5,ffffffffc02012ee <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201304:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201308:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020130a:	4501                	li	a0,0
ffffffffc020130c:	8082                	ret

ffffffffc020130e <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc020130e:	ca01                	beqz	a2,ffffffffc020131e <memset+0x10>
ffffffffc0201310:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201312:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201314:	0785                	addi	a5,a5,1
ffffffffc0201316:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc020131a:	fec79de3          	bne	a5,a2,ffffffffc0201314 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc020131e:	8082                	ret
