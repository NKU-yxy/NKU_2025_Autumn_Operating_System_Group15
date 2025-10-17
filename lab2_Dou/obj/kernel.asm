
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
ffffffffc0200050:	54450513          	addi	a0,a0,1348 # ffffffffc0201590 <etext+0x6>
void print_kerninfo(void) {
ffffffffc0200054:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200056:	0f6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", (uintptr_t)kern_init);
ffffffffc020005a:	00000597          	auipc	a1,0x0
ffffffffc020005e:	07e58593          	addi	a1,a1,126 # ffffffffc02000d8 <kern_init>
ffffffffc0200062:	00001517          	auipc	a0,0x1
ffffffffc0200066:	54e50513          	addi	a0,a0,1358 # ffffffffc02015b0 <etext+0x26>
ffffffffc020006a:	0e2000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020006e:	00001597          	auipc	a1,0x1
ffffffffc0200072:	51c58593          	addi	a1,a1,1308 # ffffffffc020158a <etext>
ffffffffc0200076:	00001517          	auipc	a0,0x1
ffffffffc020007a:	55a50513          	addi	a0,a0,1370 # ffffffffc02015d0 <etext+0x46>
ffffffffc020007e:	0ce000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200082:	00005597          	auipc	a1,0x5
ffffffffc0200086:	f9658593          	addi	a1,a1,-106 # ffffffffc0205018 <buddy_area>
ffffffffc020008a:	00001517          	auipc	a0,0x1
ffffffffc020008e:	56650513          	addi	a0,a0,1382 # ffffffffc02015f0 <etext+0x66>
ffffffffc0200092:	0ba000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc0200096:	00005597          	auipc	a1,0x5
ffffffffc020009a:	08258593          	addi	a1,a1,130 # ffffffffc0205118 <end>
ffffffffc020009e:	00001517          	auipc	a0,0x1
ffffffffc02000a2:	57250513          	addi	a0,a0,1394 # ffffffffc0201610 <etext+0x86>
ffffffffc02000a6:	0a6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - (char*)kern_init + 1023) / 1024);
ffffffffc02000aa:	00005597          	auipc	a1,0x5
ffffffffc02000ae:	46d58593          	addi	a1,a1,1133 # ffffffffc0205517 <end+0x3ff>
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
ffffffffc02000d0:	56450513          	addi	a0,a0,1380 # ffffffffc0201630 <etext+0xa6>
}
ffffffffc02000d4:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000d6:	a89d                	j	ffffffffc020014c <cprintf>

ffffffffc02000d8 <kern_init>:

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc02000d8:	00005517          	auipc	a0,0x5
ffffffffc02000dc:	f4050513          	addi	a0,a0,-192 # ffffffffc0205018 <buddy_area>
ffffffffc02000e0:	00005617          	auipc	a2,0x5
ffffffffc02000e4:	03860613          	addi	a2,a2,56 # ffffffffc0205118 <end>
int kern_init(void) {
ffffffffc02000e8:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc02000ea:	8e09                	sub	a2,a2,a0
ffffffffc02000ec:	4581                	li	a1,0
int kern_init(void) {
ffffffffc02000ee:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc02000f0:	488010ef          	jal	ra,ffffffffc0201578 <memset>
    dtb_init();
ffffffffc02000f4:	12c000ef          	jal	ra,ffffffffc0200220 <dtb_init>
    cons_init();  // init the console
ffffffffc02000f8:	11e000ef          	jal	ra,ffffffffc0200216 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc02000fc:	00001517          	auipc	a0,0x1
ffffffffc0200100:	56450513          	addi	a0,a0,1380 # ffffffffc0201660 <etext+0xd6>
ffffffffc0200104:	07e000ef          	jal	ra,ffffffffc0200182 <cputs>

    print_kerninfo();
ffffffffc0200108:	f43ff0ef          	jal	ra,ffffffffc020004a <print_kerninfo>

    // grade_backtrace();
    pmm_init();  // init physical memory management
ffffffffc020010c:	613000ef          	jal	ra,ffffffffc0200f1e <pmm_init>

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
ffffffffc0200140:	022010ef          	jal	ra,ffffffffc0201162 <vprintfmt>
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
ffffffffc0200176:	7ed000ef          	jal	ra,ffffffffc0201162 <vprintfmt>
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
ffffffffc02001c6:	f0e30313          	addi	t1,t1,-242 # ffffffffc02050d0 <is_panic>
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
ffffffffc02001f6:	48e50513          	addi	a0,a0,1166 # ffffffffc0201680 <etext+0xf6>
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
ffffffffc020020c:	45050513          	addi	a0,a0,1104 # ffffffffc0201658 <etext+0xce>
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
ffffffffc020021c:	2c80106f          	j	ffffffffc02014e4 <sbi_console_putchar>

ffffffffc0200220 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200220:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200222:	00001517          	auipc	a0,0x1
ffffffffc0200226:	47e50513          	addi	a0,a0,1150 # ffffffffc02016a0 <etext+0x116>
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
ffffffffc0200254:	46050513          	addi	a0,a0,1120 # ffffffffc02016b0 <etext+0x126>
ffffffffc0200258:	ef5ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020025c:	00005417          	auipc	s0,0x5
ffffffffc0200260:	dac40413          	addi	s0,s0,-596 # ffffffffc0205008 <boot_dtb>
ffffffffc0200264:	600c                	ld	a1,0(s0)
ffffffffc0200266:	00001517          	auipc	a0,0x1
ffffffffc020026a:	45a50513          	addi	a0,a0,1114 # ffffffffc02016c0 <etext+0x136>
ffffffffc020026e:	edfff0ef          	jal	ra,ffffffffc020014c <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200272:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200276:	00001517          	auipc	a0,0x1
ffffffffc020027a:	46250513          	addi	a0,a0,1122 # ffffffffc02016d8 <etext+0x14e>
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
ffffffffc02002be:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfedadd5>
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
ffffffffc0200334:	3f890913          	addi	s2,s2,1016 # ffffffffc0201728 <etext+0x19e>
ffffffffc0200338:	49bd                	li	s3,15
        switch (token) {
ffffffffc020033a:	4d91                	li	s11,4
ffffffffc020033c:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020033e:	00001497          	auipc	s1,0x1
ffffffffc0200342:	3e248493          	addi	s1,s1,994 # ffffffffc0201720 <etext+0x196>
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
ffffffffc0200396:	40e50513          	addi	a0,a0,1038 # ffffffffc02017a0 <etext+0x216>
ffffffffc020039a:	db3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020039e:	00001517          	auipc	a0,0x1
ffffffffc02003a2:	43a50513          	addi	a0,a0,1082 # ffffffffc02017d8 <etext+0x24e>
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
ffffffffc02003e2:	31a50513          	addi	a0,a0,794 # ffffffffc02016f8 <etext+0x16e>
}
ffffffffc02003e6:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003e8:	b395                	j	ffffffffc020014c <cprintf>
                int name_len = strlen(name);
ffffffffc02003ea:	8556                	mv	a0,s5
ffffffffc02003ec:	112010ef          	jal	ra,ffffffffc02014fe <strlen>
ffffffffc02003f0:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003f2:	4619                	li	a2,6
ffffffffc02003f4:	85a6                	mv	a1,s1
ffffffffc02003f6:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02003f8:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003fa:	158010ef          	jal	ra,ffffffffc0201552 <strncmp>
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
ffffffffc0200490:	0a4010ef          	jal	ra,ffffffffc0201534 <strcmp>
ffffffffc0200494:	66a2                	ld	a3,8(sp)
ffffffffc0200496:	f94d                	bnez	a0,ffffffffc0200448 <dtb_init+0x228>
ffffffffc0200498:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200448 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020049c:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02004a0:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02004a4:	00001517          	auipc	a0,0x1
ffffffffc02004a8:	28c50513          	addi	a0,a0,652 # ffffffffc0201730 <etext+0x1a6>
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
ffffffffc0200576:	1de50513          	addi	a0,a0,478 # ffffffffc0201750 <etext+0x1c6>
ffffffffc020057a:	bd3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020057e:	014b5613          	srli	a2,s6,0x14
ffffffffc0200582:	85da                	mv	a1,s6
ffffffffc0200584:	00001517          	auipc	a0,0x1
ffffffffc0200588:	1e450513          	addi	a0,a0,484 # ffffffffc0201768 <etext+0x1de>
ffffffffc020058c:	bc1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200590:	008b05b3          	add	a1,s6,s0
ffffffffc0200594:	15fd                	addi	a1,a1,-1
ffffffffc0200596:	00001517          	auipc	a0,0x1
ffffffffc020059a:	1f250513          	addi	a0,a0,498 # ffffffffc0201788 <etext+0x1fe>
ffffffffc020059e:	bafff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02005a2:	00001517          	auipc	a0,0x1
ffffffffc02005a6:	23650513          	addi	a0,a0,566 # ffffffffc02017d8 <etext+0x24e>
        memory_base = mem_base;
ffffffffc02005aa:	00005797          	auipc	a5,0x5
ffffffffc02005ae:	b287b723          	sd	s0,-1234(a5) # ffffffffc02050d8 <memory_base>
        memory_size = mem_size;
ffffffffc02005b2:	00005797          	auipc	a5,0x5
ffffffffc02005b6:	b367b723          	sd	s6,-1234(a5) # ffffffffc02050e0 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc02005ba:	b3f5                	j	ffffffffc02003a6 <dtb_init+0x186>

ffffffffc02005bc <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc02005bc:	00005517          	auipc	a0,0x5
ffffffffc02005c0:	b1c53503          	ld	a0,-1252(a0) # ffffffffc02050d8 <memory_base>
ffffffffc02005c4:	8082                	ret

ffffffffc02005c6 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
ffffffffc02005c6:	00005517          	auipc	a0,0x5
ffffffffc02005ca:	b1a53503          	ld	a0,-1254(a0) # ffffffffc02050e0 <memory_size>
ffffffffc02005ce:	8082                	ret

ffffffffc02005d0 <buddy_init>:
    return &pages[buddy_idx];
}

static void
buddy_init(void) {
    for (int i = 0; i < MAX_ORDER; i++) list_init(&buddy_area.free_list[i]);
ffffffffc02005d0:	00005797          	auipc	a5,0x5
ffffffffc02005d4:	a4878793          	addi	a5,a5,-1464 # ffffffffc0205018 <buddy_area>
ffffffffc02005d8:	00005717          	auipc	a4,0x5
ffffffffc02005dc:	af070713          	addi	a4,a4,-1296 # ffffffffc02050c8 <buddy_area+0xb0>
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc02005e0:	e79c                	sd	a5,8(a5)
ffffffffc02005e2:	e39c                	sd	a5,0(a5)
ffffffffc02005e4:	07c1                	addi	a5,a5,16
ffffffffc02005e6:	fee79de3          	bne	a5,a4,ffffffffc02005e0 <buddy_init+0x10>
    buddy_area.nr_free = 0;
ffffffffc02005ea:	00005797          	auipc	a5,0x5
ffffffffc02005ee:	ac07af23          	sw	zero,-1314(a5) # ffffffffc02050c8 <buddy_area+0xb0>
}
ffffffffc02005f2:	8082                	ret

ffffffffc02005f4 <buddy_nr_free_pages>:
}

static size_t
buddy_nr_free_pages(void) {
    return buddy_area.nr_free;
}
ffffffffc02005f4:	00005517          	auipc	a0,0x5
ffffffffc02005f8:	ad456503          	lwu	a0,-1324(a0) # ffffffffc02050c8 <buddy_area+0xb0>
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <verify_free_list_consistency>:

/* Verify free lists consistency: sum free pages from all lists and compare with nr_free */
static void
verify_free_list_consistency(void) {
ffffffffc02005fe:	1141                	addi	sp,sp,-16
ffffffffc0200600:	00005517          	auipc	a0,0x5
ffffffffc0200604:	a1850513          	addi	a0,a0,-1512 # ffffffffc0205018 <buddy_area>
ffffffffc0200608:	e406                	sd	ra,8(sp)
ffffffffc020060a:	862a                	mv	a2,a0
ffffffffc020060c:	00005597          	auipc	a1,0x5
ffffffffc0200610:	abc58593          	addi	a1,a1,-1348 # ffffffffc02050c8 <buddy_area+0xb0>
    size_t total = 0;
ffffffffc0200614:	4681                	li	a3,0
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200616:	661c                	ld	a5,8(a2)
    for (int o = 0; o < MAX_ORDER; o++) {
        list_entry_t *le = &buddy_area.free_list[o];
        while ((le = list_next(le)) != &buddy_area.free_list[o]) {
ffffffffc0200618:	00c78c63          	beq	a5,a2,ffffffffc0200630 <verify_free_list_consistency+0x32>
            struct Page *p = le2page(le, page_link);
            assert(PageProperty(p));
ffffffffc020061c:	ff07b703          	ld	a4,-16(a5)
ffffffffc0200620:	8b09                	andi	a4,a4,2
ffffffffc0200622:	c30d                	beqz	a4,ffffffffc0200644 <verify_free_list_consistency+0x46>
            total += p->property;
ffffffffc0200624:	ff87e703          	lwu	a4,-8(a5)
ffffffffc0200628:	679c                	ld	a5,8(a5)
ffffffffc020062a:	96ba                	add	a3,a3,a4
        while ((le = list_next(le)) != &buddy_area.free_list[o]) {
ffffffffc020062c:	fec798e3          	bne	a5,a2,ffffffffc020061c <verify_free_list_consistency+0x1e>
    for (int o = 0; o < MAX_ORDER; o++) {
ffffffffc0200630:	0641                	addi	a2,a2,16
ffffffffc0200632:	feb612e3          	bne	a2,a1,ffffffffc0200616 <verify_free_list_consistency+0x18>
        }
    }
    assert(total == buddy_area.nr_free);
ffffffffc0200636:	0b056783          	lwu	a5,176(a0)
ffffffffc020063a:	02d79563          	bne	a5,a3,ffffffffc0200664 <verify_free_list_consistency+0x66>
}
ffffffffc020063e:	60a2                	ld	ra,8(sp)
ffffffffc0200640:	0141                	addi	sp,sp,16
ffffffffc0200642:	8082                	ret
            assert(PageProperty(p));
ffffffffc0200644:	00001697          	auipc	a3,0x1
ffffffffc0200648:	1ac68693          	addi	a3,a3,428 # ffffffffc02017f0 <etext+0x266>
ffffffffc020064c:	00001617          	auipc	a2,0x1
ffffffffc0200650:	1b460613          	addi	a2,a2,436 # ffffffffc0201800 <etext+0x276>
ffffffffc0200654:	0b600593          	li	a1,182
ffffffffc0200658:	00001517          	auipc	a0,0x1
ffffffffc020065c:	1c050513          	addi	a0,a0,448 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200660:	b63ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(total == buddy_area.nr_free);
ffffffffc0200664:	00001697          	auipc	a3,0x1
ffffffffc0200668:	1cc68693          	addi	a3,a3,460 # ffffffffc0201830 <etext+0x2a6>
ffffffffc020066c:	00001617          	auipc	a2,0x1
ffffffffc0200670:	19460613          	addi	a2,a2,404 # ffffffffc0201800 <etext+0x276>
ffffffffc0200674:	0ba00593          	li	a1,186
ffffffffc0200678:	00001517          	auipc	a0,0x1
ffffffffc020067c:	1a050513          	addi	a0,a0,416 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200680:	b43ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200684 <buddy_check>:

static void
buddy_check(void) {
ffffffffc0200684:	bc010113          	addi	sp,sp,-1088
ffffffffc0200688:	42113c23          	sd	ra,1080(sp)
ffffffffc020068c:	42813823          	sd	s0,1072(sp)
ffffffffc0200690:	43213023          	sd	s2,1056(sp)
ffffffffc0200694:	41313c23          	sd	s3,1048(sp)
ffffffffc0200698:	42913423          	sd	s1,1064(sp)
ffffffffc020069c:	41413823          	sd	s4,1040(sp)
ffffffffc02006a0:	41513423          	sd	s5,1032(sp)
    /* More thorough checks: split/coalesce, alloc/free restore, small stress loop */
    size_t before = nr_free_pages();
ffffffffc02006a4:	06f000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc02006a8:	892a                	mv	s2,a0

    /* Basic small allocations and frees */
    struct Page *p0 = alloc_page();
ffffffffc02006aa:	4505                	li	a0,1
ffffffffc02006ac:	04f000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc02006b0:	89aa                	mv	s3,a0
    struct Page *p1 = alloc_page();
ffffffffc02006b2:	4505                	li	a0,1
ffffffffc02006b4:	047000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc02006b8:	842a                	mv	s0,a0
    struct Page *p2 = alloc_page();
ffffffffc02006ba:	4505                	li	a0,1
ffffffffc02006bc:	03f000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
    assert(p0 && p1 && p2 && p0 != p1 && p1 != p2);
ffffffffc02006c0:	12098363          	beqz	s3,ffffffffc02007e6 <buddy_check+0x162>
ffffffffc02006c4:	12040163          	beqz	s0,ffffffffc02007e6 <buddy_check+0x162>
ffffffffc02006c8:	84aa                	mv	s1,a0
ffffffffc02006ca:	10050e63          	beqz	a0,ffffffffc02007e6 <buddy_check+0x162>
ffffffffc02006ce:	10898c63          	beq	s3,s0,ffffffffc02007e6 <buddy_check+0x162>
ffffffffc02006d2:	10a40a63          	beq	s0,a0,ffffffffc02007e6 <buddy_check+0x162>
    free_page(p0);
ffffffffc02006d6:	4585                	li	a1,1
ffffffffc02006d8:	854e                	mv	a0,s3
ffffffffc02006da:	02d000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    free_page(p1);
ffffffffc02006de:	4585                	li	a1,1
ffffffffc02006e0:	8522                	mv	a0,s0
ffffffffc02006e2:	025000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    free_page(p2);
ffffffffc02006e6:	4585                	li	a1,1
ffffffffc02006e8:	8526                	mv	a0,s1
ffffffffc02006ea:	01d000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    verify_free_list_consistency();
ffffffffc02006ee:	f11ff0ef          	jal	ra,ffffffffc02005fe <verify_free_list_consistency>
    assert(nr_free_pages() == before);
ffffffffc02006f2:	021000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc02006f6:	1b251863          	bne	a0,s2,ffffffffc02008a6 <buddy_check+0x222>

    /* Test split and coalesce deterministically with small powers */
    /* allocate a big block then split into two halves and re-merge */
    size_t big = 8;
    struct Page *B = alloc_pages(big);
ffffffffc02006fa:	4521                	li	a0,8
ffffffffc02006fc:	7fe000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
    if (B) {
ffffffffc0200700:	c139                	beqz	a0,ffffffffc0200746 <buddy_check+0xc2>
        free_pages(B, big);
ffffffffc0200702:	45a1                	li	a1,8
ffffffffc0200704:	003000ef          	jal	ra,ffffffffc0200f06 <free_pages>
        size_t before2 = nr_free_pages();
ffffffffc0200708:	00b000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc020070c:	89aa                	mv	s3,a0
        struct Page *x = alloc_pages(big/2);
ffffffffc020070e:	4511                	li	a0,4
ffffffffc0200710:	7ea000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc0200714:	84aa                	mv	s1,a0
        assert(x != NULL);
ffffffffc0200716:	16050863          	beqz	a0,ffffffffc0200886 <buddy_check+0x202>
        struct Page *y = alloc_pages(big/2);
ffffffffc020071a:	4511                	li	a0,4
ffffffffc020071c:	7de000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc0200720:	842a                	mv	s0,a0
        assert(y != NULL);
ffffffffc0200722:	14050263          	beqz	a0,ffffffffc0200866 <buddy_check+0x1e2>
        /* free halves and expect coalescing back to big */
    free_pages(x, big/2);
ffffffffc0200726:	4591                	li	a1,4
ffffffffc0200728:	8526                	mv	a0,s1
ffffffffc020072a:	7dc000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    verify_free_list_consistency();
ffffffffc020072e:	ed1ff0ef          	jal	ra,ffffffffc02005fe <verify_free_list_consistency>
    free_pages(y, big/2);
ffffffffc0200732:	4591                	li	a1,4
ffffffffc0200734:	8522                	mv	a0,s0
ffffffffc0200736:	7d0000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    verify_free_list_consistency();
ffffffffc020073a:	ec5ff0ef          	jal	ra,ffffffffc02005fe <verify_free_list_consistency>
    assert(nr_free_pages() == before2);
ffffffffc020073e:	7d4000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc0200742:	11351263          	bne	a0,s3,ffffffffc0200846 <buddy_check+0x1c2>
    }

    /* Small randomized-like sequence but bounded and deterministic */
    size_t saved = nr_free_pages();
ffffffffc0200746:	7cc000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc020074a:	89aa                	mv	s3,a0
    struct Page *buf[128];
    int used = 0;
    for (int i = 0; i < 64; i++) {
ffffffffc020074c:	4401                	li	s0,0
    int used = 0;
ffffffffc020074e:	4481                	li	s1,0
        size_t req = (i % 7) + 1; /* sizes from 1..7 */
ffffffffc0200750:	4a9d                	li	s5,7
    for (int i = 0; i < 64; i++) {
ffffffffc0200752:	04000a13          	li	s4,64
        size_t req = (i % 7) + 1; /* sizes from 1..7 */
ffffffffc0200756:	0354653b          	remw	a0,s0,s5
        struct Page *q = alloc_pages(req);
ffffffffc020075a:	2505                	addiw	a0,a0,1
ffffffffc020075c:	79e000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
        if (q) {
ffffffffc0200760:	c909                	beqz	a0,ffffffffc0200772 <buddy_check+0xee>
            buf[used++] = q;
ffffffffc0200762:	00349793          	slli	a5,s1,0x3
ffffffffc0200766:	40010713          	addi	a4,sp,1024
ffffffffc020076a:	97ba                	add	a5,a5,a4
ffffffffc020076c:	c0a7b023          	sd	a0,-1024(a5)
ffffffffc0200770:	2485                	addiw	s1,s1,1
    for (int i = 0; i < 64; i++) {
ffffffffc0200772:	2405                	addiw	s0,s0,1
ffffffffc0200774:	ff4411e3          	bne	s0,s4,ffffffffc0200756 <buddy_check+0xd2>
        }
    }
    /* free allocated ones */
    for (int i = 0; i < used; i++) {
ffffffffc0200778:	cc85                	beqz	s1,ffffffffc02007b0 <buddy_check+0x12c>
ffffffffc020077a:	fff4841b          	addiw	s0,s1,-1
ffffffffc020077e:	02041793          	slli	a5,s0,0x20
ffffffffc0200782:	01d7d413          	srli	s0,a5,0x1d
ffffffffc0200786:	003c                	addi	a5,sp,8
ffffffffc0200788:	848a                	mv	s1,sp
ffffffffc020078a:	943e                	add	s0,s0,a5
ffffffffc020078c:	a801                	j	ffffffffc020079c <buddy_check+0x118>
        /* Determine size of the allocated block from property if head, otherwise free as single pages */
        struct Page *q = buf[i];
        /* We don't track the exact allocated size here; free single page (safe) or attempt to free property pages */
        if (PageProperty(q)) {
            size_t s = q->property;
            free_pages(q, s);
ffffffffc020078e:	01056583          	lwu	a1,16(a0)
    for (int i = 0; i < used; i++) {
ffffffffc0200792:	04a1                	addi	s1,s1,8
            free_pages(q, s);
ffffffffc0200794:	772000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    for (int i = 0; i < used; i++) {
ffffffffc0200798:	00848c63          	beq	s1,s0,ffffffffc02007b0 <buddy_check+0x12c>
        struct Page *q = buf[i];
ffffffffc020079c:	6088                	ld	a0,0(s1)
        if (PageProperty(q)) {
ffffffffc020079e:	651c                	ld	a5,8(a0)
ffffffffc02007a0:	8b89                	andi	a5,a5,2
ffffffffc02007a2:	f7f5                	bnez	a5,ffffffffc020078e <buddy_check+0x10a>
        } else {
            free_page(q);
ffffffffc02007a4:	4585                	li	a1,1
    for (int i = 0; i < used; i++) {
ffffffffc02007a6:	04a1                	addi	s1,s1,8
            free_page(q);
ffffffffc02007a8:	75e000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    for (int i = 0; i < used; i++) {
ffffffffc02007ac:	fe8498e3          	bne	s1,s0,ffffffffc020079c <buddy_check+0x118>
        }
    }
    verify_free_list_consistency();
ffffffffc02007b0:	e4fff0ef          	jal	ra,ffffffffc02005fe <verify_free_list_consistency>
    assert(nr_free_pages() == saved);
ffffffffc02007b4:	75e000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc02007b8:	07351763          	bne	a0,s3,ffffffffc0200826 <buddy_check+0x1a2>

    /* final invariant: total free pages should match original before everything */
    assert(nr_free_pages() == before);
ffffffffc02007bc:	756000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc02007c0:	05251363          	bne	a0,s2,ffffffffc0200806 <buddy_check+0x182>

    /* run deterministic tests in separate file */
    extern void run_buddy_tests(void);
    run_buddy_tests();
}
ffffffffc02007c4:	43013403          	ld	s0,1072(sp)
ffffffffc02007c8:	43813083          	ld	ra,1080(sp)
ffffffffc02007cc:	42813483          	ld	s1,1064(sp)
ffffffffc02007d0:	42013903          	ld	s2,1056(sp)
ffffffffc02007d4:	41813983          	ld	s3,1048(sp)
ffffffffc02007d8:	41013a03          	ld	s4,1040(sp)
ffffffffc02007dc:	40813a83          	ld	s5,1032(sp)
ffffffffc02007e0:	44010113          	addi	sp,sp,1088
    run_buddy_tests();
ffffffffc02007e4:	ab75                	j	ffffffffc0200da0 <run_buddy_tests>
    assert(p0 && p1 && p2 && p0 != p1 && p1 != p2);
ffffffffc02007e6:	00001697          	auipc	a3,0x1
ffffffffc02007ea:	06a68693          	addi	a3,a3,106 # ffffffffc0201850 <etext+0x2c6>
ffffffffc02007ee:	00001617          	auipc	a2,0x1
ffffffffc02007f2:	01260613          	addi	a2,a2,18 # ffffffffc0201800 <etext+0x276>
ffffffffc02007f6:	0c600593          	li	a1,198
ffffffffc02007fa:	00001517          	auipc	a0,0x1
ffffffffc02007fe:	01e50513          	addi	a0,a0,30 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200802:	9c1ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(nr_free_pages() == before);
ffffffffc0200806:	00001697          	auipc	a3,0x1
ffffffffc020080a:	07268693          	addi	a3,a3,114 # ffffffffc0201878 <etext+0x2ee>
ffffffffc020080e:	00001617          	auipc	a2,0x1
ffffffffc0200812:	ff260613          	addi	a2,a2,-14 # ffffffffc0201800 <etext+0x276>
ffffffffc0200816:	0fb00593          	li	a1,251
ffffffffc020081a:	00001517          	auipc	a0,0x1
ffffffffc020081e:	ffe50513          	addi	a0,a0,-2 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200822:	9a1ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(nr_free_pages() == saved);
ffffffffc0200826:	00001697          	auipc	a3,0x1
ffffffffc020082a:	0b268693          	addi	a3,a3,178 # ffffffffc02018d8 <etext+0x34e>
ffffffffc020082e:	00001617          	auipc	a2,0x1
ffffffffc0200832:	fd260613          	addi	a2,a2,-46 # ffffffffc0201800 <etext+0x276>
ffffffffc0200836:	0f800593          	li	a1,248
ffffffffc020083a:	00001517          	auipc	a0,0x1
ffffffffc020083e:	fde50513          	addi	a0,a0,-34 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200842:	981ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(nr_free_pages() == before2);
ffffffffc0200846:	00001697          	auipc	a3,0x1
ffffffffc020084a:	07268693          	addi	a3,a3,114 # ffffffffc02018b8 <etext+0x32e>
ffffffffc020084e:	00001617          	auipc	a2,0x1
ffffffffc0200852:	fb260613          	addi	a2,a2,-78 # ffffffffc0201800 <etext+0x276>
ffffffffc0200856:	0dd00593          	li	a1,221
ffffffffc020085a:	00001517          	auipc	a0,0x1
ffffffffc020085e:	fbe50513          	addi	a0,a0,-66 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200862:	961ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        assert(y != NULL);
ffffffffc0200866:	00001697          	auipc	a3,0x1
ffffffffc020086a:	04268693          	addi	a3,a3,66 # ffffffffc02018a8 <etext+0x31e>
ffffffffc020086e:	00001617          	auipc	a2,0x1
ffffffffc0200872:	f9260613          	addi	a2,a2,-110 # ffffffffc0201800 <etext+0x276>
ffffffffc0200876:	0d700593          	li	a1,215
ffffffffc020087a:	00001517          	auipc	a0,0x1
ffffffffc020087e:	f9e50513          	addi	a0,a0,-98 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200882:	941ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        assert(x != NULL);
ffffffffc0200886:	00001697          	auipc	a3,0x1
ffffffffc020088a:	01268693          	addi	a3,a3,18 # ffffffffc0201898 <etext+0x30e>
ffffffffc020088e:	00001617          	auipc	a2,0x1
ffffffffc0200892:	f7260613          	addi	a2,a2,-142 # ffffffffc0201800 <etext+0x276>
ffffffffc0200896:	0d500593          	li	a1,213
ffffffffc020089a:	00001517          	auipc	a0,0x1
ffffffffc020089e:	f7e50513          	addi	a0,a0,-130 # ffffffffc0201818 <etext+0x28e>
ffffffffc02008a2:	921ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(nr_free_pages() == before);
ffffffffc02008a6:	00001697          	auipc	a3,0x1
ffffffffc02008aa:	fd268693          	addi	a3,a3,-46 # ffffffffc0201878 <etext+0x2ee>
ffffffffc02008ae:	00001617          	auipc	a2,0x1
ffffffffc02008b2:	f5260613          	addi	a2,a2,-174 # ffffffffc0201800 <etext+0x276>
ffffffffc02008b6:	0cb00593          	li	a1,203
ffffffffc02008ba:	00001517          	auipc	a0,0x1
ffffffffc02008be:	f5e50513          	addi	a0,a0,-162 # ffffffffc0201818 <etext+0x28e>
ffffffffc02008c2:	901ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc02008c6 <buddy_free_pages>:
buddy_free_pages(struct Page *base, size_t n) {
ffffffffc02008c6:	1141                	addi	sp,sp,-16
ffffffffc02008c8:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02008ca:	14058e63          	beqz	a1,ffffffffc0200a26 <buddy_free_pages+0x160>
    for (struct Page *p = base; p < base + n; p++) {
ffffffffc02008ce:	00259693          	slli	a3,a1,0x2
ffffffffc02008d2:	96ae                	add	a3,a3,a1
ffffffffc02008d4:	068e                	slli	a3,a3,0x3
ffffffffc02008d6:	96aa                	add	a3,a3,a0
ffffffffc02008d8:	87aa                	mv	a5,a0
ffffffffc02008da:	00d57e63          	bgeu	a0,a3,ffffffffc02008f6 <buddy_free_pages+0x30>
        assert(!PageReserved(p));
ffffffffc02008de:	6798                	ld	a4,8(a5)
ffffffffc02008e0:	8b05                	andi	a4,a4,1
ffffffffc02008e2:	12071263          	bnez	a4,ffffffffc0200a06 <buddy_free_pages+0x140>
        p->flags = 0;
ffffffffc02008e6:	0007b423          	sd	zero,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc02008ea:	0007a023          	sw	zero,0(a5)
    for (struct Page *p = base; p < base + n; p++) {
ffffffffc02008ee:	02878793          	addi	a5,a5,40
ffffffffc02008f2:	fed7e6e3          	bltu	a5,a3,ffffffffc02008de <buddy_free_pages+0x18>
    SetPageProperty(head);
ffffffffc02008f6:	00853803          	ld	a6,8(a0)
    while (sz < n) { sz <<= 1; order++; }
ffffffffc02008fa:	4685                	li	a3,1
    size_t order = 0;
ffffffffc02008fc:	4701                	li	a4,0
    SetPageProperty(head);
ffffffffc02008fe:	00286813          	ori	a6,a6,2
    size_t sz = 1;
ffffffffc0200902:	4785                	li	a5,1
    while (sz < n) { sz <<= 1; order++; }
ffffffffc0200904:	0ed58763          	beq	a1,a3,ffffffffc02009f2 <buddy_free_pages+0x12c>
ffffffffc0200908:	0786                	slli	a5,a5,0x1
ffffffffc020090a:	86ba                	mv	a3,a4
ffffffffc020090c:	0705                	addi	a4,a4,1
ffffffffc020090e:	feb7ede3          	bltu	a5,a1,ffffffffc0200908 <buddy_free_pages+0x42>
    head->property = 1UL << order;
ffffffffc0200912:	4605                	li	a2,1
ffffffffc0200914:	00e61633          	sll	a2,a2,a4
ffffffffc0200918:	2601                	sext.w	a2,a2
ffffffffc020091a:	c910                	sw	a2,16(a0)
    SetPageProperty(head);
ffffffffc020091c:	01053423          	sd	a6,8(a0)
    while (order + 1 < MAX_ORDER) {
ffffffffc0200920:	00268593          	addi	a1,a3,2
ffffffffc0200924:	47a9                	li	a5,10
ffffffffc0200926:	08b7ed63          	bltu	a5,a1,ffffffffc02009c0 <buddy_free_pages+0xfa>
    return p - pages;
ffffffffc020092a:	00004817          	auipc	a6,0x4
ffffffffc020092e:	7c683803          	ld	a6,1990(a6) # ffffffffc02050f0 <pages>
ffffffffc0200932:	410507b3          	sub	a5,a0,a6
ffffffffc0200936:	00001e17          	auipc	t3,0x1
ffffffffc020093a:	44ae3e03          	ld	t3,1098(t3) # ffffffffc0201d80 <error_string+0x38>
ffffffffc020093e:	878d                	srai	a5,a5,0x3
ffffffffc0200940:	03c787b3          	mul	a5,a5,t3
    uintptr_t buddy_idx = idx ^ (1UL << order);
ffffffffc0200944:	4885                	li	a7,1
ffffffffc0200946:	00e89633          	sll	a2,a7,a4
    if (buddy_idx >= npage) return NULL;
ffffffffc020094a:	00004e97          	auipc	t4,0x4
ffffffffc020094e:	79eebe83          	ld	t4,1950(t4) # ffffffffc02050e8 <npage>
    while (order + 1 < MAX_ORDER) {
ffffffffc0200952:	4f2d                	li	t5,11
    uintptr_t buddy_idx = idx ^ (1UL << order);
ffffffffc0200954:	00c7c6b3          	xor	a3,a5,a2
    if (buddy_idx >= npage) return NULL;
ffffffffc0200958:	05d6ff63          	bgeu	a3,t4,ffffffffc02009b6 <buddy_free_pages+0xf0>
    return &pages[buddy_idx];
ffffffffc020095c:	00269793          	slli	a5,a3,0x2
ffffffffc0200960:	97b6                	add	a5,a5,a3
ffffffffc0200962:	078e                	slli	a5,a5,0x3
ffffffffc0200964:	97c2                	add	a5,a5,a6
        if (!buddy || !PageProperty(buddy) || buddy->property != (1UL << order)) break;
ffffffffc0200966:	cba1                	beqz	a5,ffffffffc02009b6 <buddy_free_pages+0xf0>
ffffffffc0200968:	6794                	ld	a3,8(a5)
ffffffffc020096a:	0026f313          	andi	t1,a3,2
ffffffffc020096e:	04030463          	beqz	t1,ffffffffc02009b6 <buddy_free_pages+0xf0>
ffffffffc0200972:	0107e303          	lwu	t1,16(a5)
ffffffffc0200976:	04661063          	bne	a2,t1,ffffffffc02009b6 <buddy_free_pages+0xf0>
    __list_del(listelm->prev, listelm->next);
ffffffffc020097a:	6f90                	ld	a2,24(a5)
ffffffffc020097c:	7398                	ld	a4,32(a5)
        ClearPageProperty(buddy);
ffffffffc020097e:	9af5                	andi	a3,a3,-3
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0200980:	e618                	sd	a4,8(a2)
    next->prev = prev;
ffffffffc0200982:	e310                	sd	a2,0(a4)
ffffffffc0200984:	e794                	sd	a3,8(a5)
        if (buddy < head) head = buddy;
ffffffffc0200986:	00a7f363          	bgeu	a5,a0,ffffffffc020098c <buddy_free_pages+0xc6>
ffffffffc020098a:	853e                	mv	a0,a5
        head->property = 1UL << order;
ffffffffc020098c:	00b89633          	sll	a2,a7,a1
ffffffffc0200990:	2601                	sext.w	a2,a2
ffffffffc0200992:	c910                	sw	a2,16(a0)
    while (order + 1 < MAX_ORDER) {
ffffffffc0200994:	00158793          	addi	a5,a1,1
ffffffffc0200998:	872e                	mv	a4,a1
ffffffffc020099a:	07e78063          	beq	a5,t5,ffffffffc02009fa <buddy_free_pages+0x134>
ffffffffc020099e:	85be                	mv	a1,a5
    return p - pages;
ffffffffc02009a0:	410507b3          	sub	a5,a0,a6
ffffffffc02009a4:	878d                	srai	a5,a5,0x3
ffffffffc02009a6:	03c787b3          	mul	a5,a5,t3
    uintptr_t buddy_idx = idx ^ (1UL << order);
ffffffffc02009aa:	00e89633          	sll	a2,a7,a4
ffffffffc02009ae:	00c7c6b3          	xor	a3,a5,a2
    if (buddy_idx >= npage) return NULL;
ffffffffc02009b2:	fbd6e5e3          	bltu	a3,t4,ffffffffc020095c <buddy_free_pages+0x96>
    SetPageProperty(head);
ffffffffc02009b6:	00853803          	ld	a6,8(a0)
    buddy_area.nr_free += (1UL << order);
ffffffffc02009ba:	2601                	sext.w	a2,a2
    SetPageProperty(head);
ffffffffc02009bc:	00286813          	ori	a6,a6,2
    __list_add(elm, listelm, listelm->next);
ffffffffc02009c0:	00004797          	auipc	a5,0x4
ffffffffc02009c4:	65878793          	addi	a5,a5,1624 # ffffffffc0205018 <buddy_area>
ffffffffc02009c8:	0712                	slli	a4,a4,0x4
ffffffffc02009ca:	973e                	add	a4,a4,a5
ffffffffc02009cc:	670c                	ld	a1,8(a4)
    buddy_area.nr_free += (1UL << order);
ffffffffc02009ce:	0b07a683          	lw	a3,176(a5)
    list_add(&buddy_area.free_list[order], &head->page_link);
ffffffffc02009d2:	01850893          	addi	a7,a0,24
    prev->next = next->prev = elm;
ffffffffc02009d6:	0115b023          	sd	a7,0(a1)
ffffffffc02009da:	01173423          	sd	a7,8(a4)
}
ffffffffc02009de:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc02009e0:	f10c                	sd	a1,32(a0)
    elm->prev = prev;
ffffffffc02009e2:	ed18                	sd	a4,24(a0)
    SetPageProperty(head);
ffffffffc02009e4:	01053423          	sd	a6,8(a0)
    buddy_area.nr_free += (1UL << order);
ffffffffc02009e8:	9e35                	addw	a2,a2,a3
ffffffffc02009ea:	0ac7a823          	sw	a2,176(a5)
}
ffffffffc02009ee:	0141                	addi	sp,sp,16
ffffffffc02009f0:	8082                	ret
    head->property = 1UL << order;
ffffffffc02009f2:	c90c                	sw	a1,16(a0)
    SetPageProperty(head);
ffffffffc02009f4:	01053423          	sd	a6,8(a0)
    while (order + 1 < MAX_ORDER) {
ffffffffc02009f8:	bf0d                	j	ffffffffc020092a <buddy_free_pages+0x64>
    SetPageProperty(head);
ffffffffc02009fa:	00853803          	ld	a6,8(a0)
ffffffffc02009fe:	4729                	li	a4,10
ffffffffc0200a00:	00286813          	ori	a6,a6,2
ffffffffc0200a04:	bf75                	j	ffffffffc02009c0 <buddy_free_pages+0xfa>
        assert(!PageReserved(p));
ffffffffc0200a06:	00001697          	auipc	a3,0x1
ffffffffc0200a0a:	efa68693          	addi	a3,a3,-262 # ffffffffc0201900 <etext+0x376>
ffffffffc0200a0e:	00001617          	auipc	a2,0x1
ffffffffc0200a12:	df260613          	addi	a2,a2,-526 # ffffffffc0201800 <etext+0x276>
ffffffffc0200a16:	08e00593          	li	a1,142
ffffffffc0200a1a:	00001517          	auipc	a0,0x1
ffffffffc0200a1e:	dfe50513          	addi	a0,a0,-514 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200a22:	fa0ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200a26:	00001697          	auipc	a3,0x1
ffffffffc0200a2a:	ed268693          	addi	a3,a3,-302 # ffffffffc02018f8 <etext+0x36e>
ffffffffc0200a2e:	00001617          	auipc	a2,0x1
ffffffffc0200a32:	dd260613          	addi	a2,a2,-558 # ffffffffc0201800 <etext+0x276>
ffffffffc0200a36:	08b00593          	li	a1,139
ffffffffc0200a3a:	00001517          	auipc	a0,0x1
ffffffffc0200a3e:	dde50513          	addi	a0,a0,-546 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200a42:	f80ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200a46 <buddy_alloc_pages>:
buddy_alloc_pages(size_t n) {
ffffffffc0200a46:	1141                	addi	sp,sp,-16
ffffffffc0200a48:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0200a4a:	10050a63          	beqz	a0,ffffffffc0200b5e <buddy_alloc_pages+0x118>
    if (n > buddy_area.nr_free) return NULL;
ffffffffc0200a4e:	00004e17          	auipc	t3,0x4
ffffffffc0200a52:	5cae0e13          	addi	t3,t3,1482 # ffffffffc0205018 <buddy_area>
ffffffffc0200a56:	0b0e2e83          	lw	t4,176(t3)
ffffffffc0200a5a:	020e9793          	slli	a5,t4,0x20
ffffffffc0200a5e:	9381                	srli	a5,a5,0x20
ffffffffc0200a60:	0ca7eb63          	bltu	a5,a0,ffffffffc0200b36 <buddy_alloc_pages+0xf0>
    while (sz < n) { sz <<= 1; order++; }
ffffffffc0200a64:	4785                	li	a5,1
    size_t order = 0;
ffffffffc0200a66:	4801                	li	a6,0
    while (sz < n) { sz <<= 1; order++; }
ffffffffc0200a68:	00f50963          	beq	a0,a5,ffffffffc0200a7a <buddy_alloc_pages+0x34>
ffffffffc0200a6c:	0786                	slli	a5,a5,0x1
ffffffffc0200a6e:	0805                	addi	a6,a6,1
ffffffffc0200a70:	fea7eee3          	bltu	a5,a0,ffffffffc0200a6c <buddy_alloc_pages+0x26>
    while (order < MAX_ORDER && list_empty(&buddy_area.free_list[order])) order++;
ffffffffc0200a74:	47a9                	li	a5,10
ffffffffc0200a76:	0d07e063          	bltu	a5,a6,ffffffffc0200b36 <buddy_alloc_pages+0xf0>
ffffffffc0200a7a:	00481713          	slli	a4,a6,0x4
ffffffffc0200a7e:	9772                	add	a4,a4,t3
    size_t order = 0;
ffffffffc0200a80:	85c2                	mv	a1,a6
    while (order < MAX_ORDER && list_empty(&buddy_area.free_list[order])) order++;
ffffffffc0200a82:	46ad                	li	a3,11
ffffffffc0200a84:	a029                	j	ffffffffc0200a8e <buddy_alloc_pages+0x48>
ffffffffc0200a86:	0585                	addi	a1,a1,1
ffffffffc0200a88:	0741                	addi	a4,a4,16
ffffffffc0200a8a:	0ad58663          	beq	a1,a3,ffffffffc0200b36 <buddy_alloc_pages+0xf0>
    return list->next == list;
ffffffffc0200a8e:	671c                	ld	a5,8(a4)
ffffffffc0200a90:	fee78be3          	beq	a5,a4,ffffffffc0200a86 <buddy_alloc_pages+0x40>
    __list_del(listelm->prev, listelm->next);
ffffffffc0200a94:	6388                	ld	a0,0(a5)
ffffffffc0200a96:	6794                	ld	a3,8(a5)
    ClearPageProperty(block);
ffffffffc0200a98:	ff07b703          	ld	a4,-16(a5)
ffffffffc0200a9c:	fff58613          	addi	a2,a1,-1
    prev->next = next;
ffffffffc0200aa0:	e514                	sd	a3,8(a0)
    next->prev = prev;
ffffffffc0200aa2:	e288                	sd	a0,0(a3)
ffffffffc0200aa4:	9b75                	andi	a4,a4,-3
ffffffffc0200aa6:	00461693          	slli	a3,a2,0x4
ffffffffc0200aaa:	fee7b823          	sd	a4,-16(a5)
    struct Page *blk = le2page(le, page_link);
ffffffffc0200aae:	fe878513          	addi	a0,a5,-24
    while (order > to_order) {
ffffffffc0200ab2:	96f2                	add	a3,a3,t3
        struct Page *right = head + sz;
ffffffffc0200ab4:	02800f93          	li	t6,40
        size_t sz = 1UL << order;
ffffffffc0200ab8:	4f05                	li	t5,1
    while (order > to_order) {
ffffffffc0200aba:	00b86463          	bltu	a6,a1,ffffffffc0200ac2 <buddy_alloc_pages+0x7c>
ffffffffc0200abe:	a82d                	j	ffffffffc0200af8 <buddy_alloc_pages+0xb2>
ffffffffc0200ac0:	167d                	addi	a2,a2,-1
        struct Page *right = head + sz;
ffffffffc0200ac2:	00cf9733          	sll	a4,t6,a2
ffffffffc0200ac6:	972a                	add	a4,a4,a0
        SetPageProperty(right);
ffffffffc0200ac8:	670c                	ld	a1,8(a4)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200aca:	0086b303          	ld	t1,8(a3)
        size_t sz = 1UL << order;
ffffffffc0200ace:	00cf18b3          	sll	a7,t5,a2
        SetPageProperty(right);
ffffffffc0200ad2:	0025e593          	ori	a1,a1,2
ffffffffc0200ad6:	e70c                	sd	a1,8(a4)
        right->property = sz;
ffffffffc0200ad8:	01172823          	sw	a7,16(a4)
        list_add(&buddy_area.free_list[order], &right->page_link);
ffffffffc0200adc:	01870593          	addi	a1,a4,24
    prev->next = next->prev = elm;
ffffffffc0200ae0:	00b33023          	sd	a1,0(t1)
ffffffffc0200ae4:	e68c                	sd	a1,8(a3)
    elm->prev = prev;
ffffffffc0200ae6:	ef14                	sd	a3,24(a4)
    elm->next = next;
ffffffffc0200ae8:	02673023          	sd	t1,32(a4)
    while (order > to_order) {
ffffffffc0200aec:	16c1                	addi	a3,a3,-16
ffffffffc0200aee:	fcc819e3          	bne	a6,a2,ffffffffc0200ac0 <buddy_alloc_pages+0x7a>
    ClearPageProperty(blk);
ffffffffc0200af2:	ff07b703          	ld	a4,-16(a5)
ffffffffc0200af6:	9b75                	andi	a4,a4,-3
    head->property = 1UL << to_order;
ffffffffc0200af8:	4685                	li	a3,1
ffffffffc0200afa:	01069833          	sll	a6,a3,a6
ffffffffc0200afe:	0008061b          	sext.w	a2,a6
ffffffffc0200b02:	fec7ac23          	sw	a2,-8(a5)
    ClearPageProperty(blk);
ffffffffc0200b06:	fee7b823          	sd	a4,-16(a5)
    for (size_t i = 0; i < (1UL << need_order); i++) {
ffffffffc0200b0a:	4681                	li	a3,0
ffffffffc0200b0c:	07e1                	addi	a5,a5,24
ffffffffc0200b0e:	a021                	j	ffffffffc0200b16 <buddy_alloc_pages+0xd0>
        assert(!PageReserved(p));
ffffffffc0200b10:	6398                	ld	a4,0(a5)
ffffffffc0200b12:	02878793          	addi	a5,a5,40
ffffffffc0200b16:	8b05                	andi	a4,a4,1
ffffffffc0200b18:	e31d                	bnez	a4,ffffffffc0200b3e <buddy_alloc_pages+0xf8>
        p->flags = 0;
ffffffffc0200b1a:	fc07bc23          	sd	zero,-40(a5)
ffffffffc0200b1e:	fc07a823          	sw	zero,-48(a5)
    for (size_t i = 0; i < (1UL << need_order); i++) {
ffffffffc0200b22:	0685                	addi	a3,a3,1
ffffffffc0200b24:	ff0696e3          	bne	a3,a6,ffffffffc0200b10 <buddy_alloc_pages+0xca>
}
ffffffffc0200b28:	60a2                	ld	ra,8(sp)
    buddy_area.nr_free -= (1UL << need_order);
ffffffffc0200b2a:	40ce863b          	subw	a2,t4,a2
ffffffffc0200b2e:	0ace2823          	sw	a2,176(t3)
}
ffffffffc0200b32:	0141                	addi	sp,sp,16
ffffffffc0200b34:	8082                	ret
ffffffffc0200b36:	60a2                	ld	ra,8(sp)
    if (n > buddy_area.nr_free) return NULL;
ffffffffc0200b38:	4501                	li	a0,0
}
ffffffffc0200b3a:	0141                	addi	sp,sp,16
ffffffffc0200b3c:	8082                	ret
        assert(!PageReserved(p));
ffffffffc0200b3e:	00001697          	auipc	a3,0x1
ffffffffc0200b42:	dc268693          	addi	a3,a3,-574 # ffffffffc0201900 <etext+0x376>
ffffffffc0200b46:	00001617          	auipc	a2,0x1
ffffffffc0200b4a:	cba60613          	addi	a2,a2,-838 # ffffffffc0201800 <etext+0x276>
ffffffffc0200b4e:	08100593          	li	a1,129
ffffffffc0200b52:	00001517          	auipc	a0,0x1
ffffffffc0200b56:	cc650513          	addi	a0,a0,-826 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200b5a:	e68ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200b5e:	00001697          	auipc	a3,0x1
ffffffffc0200b62:	d9a68693          	addi	a3,a3,-614 # ffffffffc02018f8 <etext+0x36e>
ffffffffc0200b66:	00001617          	auipc	a2,0x1
ffffffffc0200b6a:	c9a60613          	addi	a2,a2,-870 # ffffffffc0201800 <etext+0x276>
ffffffffc0200b6e:	07000593          	li	a1,112
ffffffffc0200b72:	00001517          	auipc	a0,0x1
ffffffffc0200b76:	ca650513          	addi	a0,a0,-858 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200b7a:	e48ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200b7e <buddy_init_memmap>:
buddy_init_memmap(struct Page *base, size_t n) {
ffffffffc0200b7e:	1141                	addi	sp,sp,-16
ffffffffc0200b80:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0200b82:	c1fd                	beqz	a1,ffffffffc0200c68 <buddy_init_memmap+0xea>
    for (struct Page *p = base; p < base + n; p++) {
ffffffffc0200b84:	00259693          	slli	a3,a1,0x2
ffffffffc0200b88:	96ae                	add	a3,a3,a1
ffffffffc0200b8a:	068e                	slli	a3,a3,0x3
ffffffffc0200b8c:	96aa                	add	a3,a3,a0
ffffffffc0200b8e:	87aa                	mv	a5,a0
ffffffffc0200b90:	00d57f63          	bgeu	a0,a3,ffffffffc0200bae <buddy_init_memmap+0x30>
        assert(PageReserved(p));
ffffffffc0200b94:	6798                	ld	a4,8(a5)
ffffffffc0200b96:	8b05                	andi	a4,a4,1
ffffffffc0200b98:	cb45                	beqz	a4,ffffffffc0200c48 <buddy_init_memmap+0xca>
        p->flags = p->property = 0;
ffffffffc0200b9a:	0007a823          	sw	zero,16(a5)
ffffffffc0200b9e:	0007b423          	sd	zero,8(a5)
ffffffffc0200ba2:	0007a023          	sw	zero,0(a5)
    for (struct Page *p = base; p < base + n; p++) {
ffffffffc0200ba6:	02878793          	addi	a5,a5,40
ffffffffc0200baa:	fed7e5e3          	bltu	a5,a3,ffffffffc0200b94 <buddy_init_memmap+0x16>
    return p - pages;
ffffffffc0200bae:	00004f97          	auipc	t6,0x4
ffffffffc0200bb2:	542fbf83          	ld	t6,1346(t6) # ffffffffc02050f0 <pages>
ffffffffc0200bb6:	41f50533          	sub	a0,a0,t6
ffffffffc0200bba:	850d                	srai	a0,a0,0x3
ffffffffc0200bbc:	00001797          	auipc	a5,0x1
ffffffffc0200bc0:	1c47b783          	ld	a5,452(a5) # ffffffffc0201d80 <error_string+0x38>
ffffffffc0200bc4:	02f50533          	mul	a0,a0,a5
    while (remain > 0) {
ffffffffc0200bc8:	00004e97          	auipc	t4,0x4
ffffffffc0200bcc:	450e8e93          	addi	t4,t4,1104 # ffffffffc0205018 <buddy_area>
ffffffffc0200bd0:	0b0eaf03          	lw	t5,176(t4)
            if (max_order + 1 >= MAX_ORDER) break;
ffffffffc0200bd4:	4829                	li	a6,10
        size_t max_order = 0;
ffffffffc0200bd6:	4781                	li	a5,0
        size_t max_size = 1;
ffffffffc0200bd8:	4605                	li	a2,1
        while (max_size * 2 <= remain && ((offset & (max_size * 2 - 1)) == 0)) {
ffffffffc0200bda:	00161713          	slli	a4,a2,0x1
ffffffffc0200bde:	06e5e263          	bltu	a1,a4,ffffffffc0200c42 <buddy_init_memmap+0xc4>
ffffffffc0200be2:	fff70693          	addi	a3,a4,-1
ffffffffc0200be6:	8ee9                	and	a3,a3,a0
ffffffffc0200be8:	eea9                	bnez	a3,ffffffffc0200c42 <buddy_init_memmap+0xc4>
            max_size <<= 1; max_order++;
ffffffffc0200bea:	0785                	addi	a5,a5,1
ffffffffc0200bec:	863a                	mv	a2,a4
            if (max_order + 1 >= MAX_ORDER) break;
ffffffffc0200bee:	ff0796e3          	bne	a5,a6,ffffffffc0200bda <buddy_init_memmap+0x5c>
ffffffffc0200bf2:	0a000893          	li	a7,160
ffffffffc0200bf6:	00481793          	slli	a5,a6,0x4
        struct Page *head = pages + offset;
ffffffffc0200bfa:	00251713          	slli	a4,a0,0x2
ffffffffc0200bfe:	972a                	add	a4,a4,a0
ffffffffc0200c00:	070e                	slli	a4,a4,0x3
ffffffffc0200c02:	977e                	add	a4,a4,t6
        SetPageProperty(head);
ffffffffc0200c04:	6714                	ld	a3,8(a4)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200c06:	97f6                	add	a5,a5,t4
ffffffffc0200c08:	0087be03          	ld	t3,8(a5)
        head->property = max_size;
ffffffffc0200c0c:	0006031b          	sext.w	t1,a2
        SetPageProperty(head);
ffffffffc0200c10:	0026e693          	ori	a3,a3,2
ffffffffc0200c14:	e714                	sd	a3,8(a4)
        head->property = max_size;
ffffffffc0200c16:	00672823          	sw	t1,16(a4)
        list_add(&buddy_area.free_list[max_order], &head->page_link);
ffffffffc0200c1a:	01870693          	addi	a3,a4,24
    prev->next = next->prev = elm;
ffffffffc0200c1e:	00de3023          	sd	a3,0(t3)
ffffffffc0200c22:	e794                	sd	a3,8(a5)
ffffffffc0200c24:	011e87b3          	add	a5,t4,a7
    elm->next = next;
ffffffffc0200c28:	03c73023          	sd	t3,32(a4)
    elm->prev = prev;
ffffffffc0200c2c:	ef1c                	sd	a5,24(a4)
        remain -= max_size;
ffffffffc0200c2e:	8d91                	sub	a1,a1,a2
        buddy_area.nr_free += max_size;
ffffffffc0200c30:	006f0f3b          	addw	t5,t5,t1
        offset += max_size;
ffffffffc0200c34:	9532                	add	a0,a0,a2
    while (remain > 0) {
ffffffffc0200c36:	f1c5                	bnez	a1,ffffffffc0200bd6 <buddy_init_memmap+0x58>
}
ffffffffc0200c38:	60a2                	ld	ra,8(sp)
ffffffffc0200c3a:	0beea823          	sw	t5,176(t4)
ffffffffc0200c3e:	0141                	addi	sp,sp,16
ffffffffc0200c40:	8082                	ret
ffffffffc0200c42:	0792                	slli	a5,a5,0x4
ffffffffc0200c44:	88be                	mv	a7,a5
ffffffffc0200c46:	bf55                	j	ffffffffc0200bfa <buddy_init_memmap+0x7c>
        assert(PageReserved(p));
ffffffffc0200c48:	00001697          	auipc	a3,0x1
ffffffffc0200c4c:	cd068693          	addi	a3,a3,-816 # ffffffffc0201918 <etext+0x38e>
ffffffffc0200c50:	00001617          	auipc	a2,0x1
ffffffffc0200c54:	bb060613          	addi	a2,a2,-1104 # ffffffffc0201800 <etext+0x276>
ffffffffc0200c58:	03c00593          	li	a1,60
ffffffffc0200c5c:	00001517          	auipc	a0,0x1
ffffffffc0200c60:	bbc50513          	addi	a0,a0,-1092 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200c64:	d5eff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200c68:	00001697          	auipc	a3,0x1
ffffffffc0200c6c:	c9068693          	addi	a3,a3,-880 # ffffffffc02018f8 <etext+0x36e>
ffffffffc0200c70:	00001617          	auipc	a2,0x1
ffffffffc0200c74:	b9060613          	addi	a2,a2,-1136 # ffffffffc0201800 <etext+0x276>
ffffffffc0200c78:	03700593          	li	a1,55
ffffffffc0200c7c:	00001517          	auipc	a0,0x1
ffffffffc0200c80:	b9c50513          	addi	a0,a0,-1124 # ffffffffc0201818 <etext+0x28e>
ffffffffc0200c84:	d3eff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200c88 <test_random_sequence>:
    /* free original big (if allocated) */
    free_pages(B, want);
    assert(nr_free_pages() == total);
}

static void test_random_sequence(void) {
ffffffffc0200c88:	bb010113          	addi	sp,sp,-1104
ffffffffc0200c8c:	44113423          	sd	ra,1096(sp)
ffffffffc0200c90:	44813023          	sd	s0,1088(sp)
ffffffffc0200c94:	42913c23          	sd	s1,1080(sp)
ffffffffc0200c98:	43213823          	sd	s2,1072(sp)
ffffffffc0200c9c:	43313423          	sd	s3,1064(sp)
ffffffffc0200ca0:	43413023          	sd	s4,1056(sp)
ffffffffc0200ca4:	41513c23          	sd	s5,1048(sp)
ffffffffc0200ca8:	41613823          	sd	s6,1040(sp)
ffffffffc0200cac:	41713423          	sd	s7,1032(sp)
    size_t total = nr_free_pages();
ffffffffc0200cb0:	262000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
    if (total == 0) return;
ffffffffc0200cb4:	c159                	beqz	a0,ffffffffc0200d3a <test_random_sequence+0xb2>
    struct Page *allocs[64];
    size_t sizes[64];
    int used = 0;
    unsigned int rnd = 123456789;
ffffffffc0200cb6:	075bd7b7          	lui	a5,0x75bd
    auto_next:
    for (int i = 0; i < 32; i++) {
        rnd = rnd * 1103515245 + 12345;
ffffffffc0200cba:	41c65a37          	lui	s4,0x41c65
ffffffffc0200cbe:	698d                	lui	s3,0x3
ffffffffc0200cc0:	8aaa                	mv	s5,a0
ffffffffc0200cc2:	02000b93          	li	s7,32
    unsigned int rnd = 123456789;
ffffffffc0200cc6:	d1578413          	addi	s0,a5,-747 # 75bcd15 <kern_entry-0xffffffffb8c432eb>
    int used = 0;
ffffffffc0200cca:	4901                	li	s2,0
        rnd = rnd * 1103515245 + 12345;
ffffffffc0200ccc:	e6da0a1b          	addiw	s4,s4,-403
ffffffffc0200cd0:	0399899b          	addiw	s3,s3,57
        struct Page *q = alloc_pages(req);
        if (q) {
            allocs[used] = q;
            sizes[used] = req;
            used++;
            if (used >= (int)(sizeof(allocs)/sizeof(allocs[0]))) break;
ffffffffc0200cd4:	03f00b13          	li	s6,63
ffffffffc0200cd8:	a021                	j	ffffffffc0200ce0 <test_random_sequence+0x58>
    for (int i = 0; i < 32; i++) {
ffffffffc0200cda:	3bfd                	addiw	s7,s7,-1
ffffffffc0200cdc:	080b8463          	beqz	s7,ffffffffc0200d64 <test_random_sequence+0xdc>
        rnd = rnd * 1103515245 + 12345;
ffffffffc0200ce0:	034407bb          	mulw	a5,s0,s4
ffffffffc0200ce4:	013787bb          	addw	a5,a5,s3
        size_t req = (rnd % 8) + 1; /* 1..8 */
ffffffffc0200ce8:	0077f493          	andi	s1,a5,7
ffffffffc0200cec:	0485                	addi	s1,s1,1
        struct Page *q = alloc_pages(req);
ffffffffc0200cee:	8526                	mv	a0,s1
        rnd = rnd * 1103515245 + 12345;
ffffffffc0200cf0:	0007841b          	sext.w	s0,a5
        struct Page *q = alloc_pages(req);
ffffffffc0200cf4:	206000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
        if (q) {
ffffffffc0200cf8:	d16d                	beqz	a0,ffffffffc0200cda <test_random_sequence+0x52>
            allocs[used] = q;
ffffffffc0200cfa:	00391793          	slli	a5,s2,0x3
ffffffffc0200cfe:	40010713          	addi	a4,sp,1024
ffffffffc0200d02:	973e                	add	a4,a4,a5
ffffffffc0200d04:	c0a73023          	sd	a0,-1024(a4)
            sizes[used] = req;
ffffffffc0200d08:	e0973023          	sd	s1,-512(a4)
            used++;
ffffffffc0200d0c:	2905                	addiw	s2,s2,1
            if (used >= (int)(sizeof(allocs)/sizeof(allocs[0]))) break;
ffffffffc0200d0e:	fd2b56e3          	bge	s6,s2,ffffffffc0200cda <test_random_sequence+0x52>
ffffffffc0200d12:	ff878413          	addi	s0,a5,-8
ffffffffc0200d16:	5941                	li	s2,-16
ffffffffc0200d18:	a039                	j	ffffffffc0200d26 <test_random_sequence+0x9e>
        }
    }
    /* free in reverse */
    for (int i = used - 1; i >= 0; i--) {
        free_pages(allocs[i], sizes[i]);
ffffffffc0200d1a:	008107b3          	add	a5,sp,s0
ffffffffc0200d1e:	6788                	ld	a0,8(a5)
ffffffffc0200d20:	041c                	addi	a5,sp,512
ffffffffc0200d22:	97a2                	add	a5,a5,s0
ffffffffc0200d24:	6784                	ld	s1,8(a5)
    for (int i = used - 1; i >= 0; i--) {
ffffffffc0200d26:	1461                	addi	s0,s0,-8
        free_pages(allocs[i], sizes[i]);
ffffffffc0200d28:	85a6                	mv	a1,s1
ffffffffc0200d2a:	1dc000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    for (int i = used - 1; i >= 0; i--) {
ffffffffc0200d2e:	ff2416e3          	bne	s0,s2,ffffffffc0200d1a <test_random_sequence+0x92>
    }
    assert(nr_free_pages() == total);
ffffffffc0200d32:	1e0000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc0200d36:	05551563          	bne	a0,s5,ffffffffc0200d80 <test_random_sequence+0xf8>
}
ffffffffc0200d3a:	44813083          	ld	ra,1096(sp)
ffffffffc0200d3e:	44013403          	ld	s0,1088(sp)
ffffffffc0200d42:	43813483          	ld	s1,1080(sp)
ffffffffc0200d46:	43013903          	ld	s2,1072(sp)
ffffffffc0200d4a:	42813983          	ld	s3,1064(sp)
ffffffffc0200d4e:	42013a03          	ld	s4,1056(sp)
ffffffffc0200d52:	41813a83          	ld	s5,1048(sp)
ffffffffc0200d56:	41013b03          	ld	s6,1040(sp)
ffffffffc0200d5a:	40813b83          	ld	s7,1032(sp)
ffffffffc0200d5e:	45010113          	addi	sp,sp,1104
ffffffffc0200d62:	8082                	ret
    for (int i = used - 1; i >= 0; i--) {
ffffffffc0200d64:	397d                	addiw	s2,s2,-1
ffffffffc0200d66:	57fd                	li	a5,-1
ffffffffc0200d68:	fcf905e3          	beq	s2,a5,ffffffffc0200d32 <test_random_sequence+0xaa>
        free_pages(allocs[i], sizes[i]);
ffffffffc0200d6c:	00391793          	slli	a5,s2,0x3
ffffffffc0200d70:	40010713          	addi	a4,sp,1024
ffffffffc0200d74:	973e                	add	a4,a4,a5
ffffffffc0200d76:	c0073503          	ld	a0,-1024(a4)
ffffffffc0200d7a:	e0073483          	ld	s1,-512(a4)
ffffffffc0200d7e:	bf51                	j	ffffffffc0200d12 <test_random_sequence+0x8a>
    assert(nr_free_pages() == total);
ffffffffc0200d80:	00001697          	auipc	a3,0x1
ffffffffc0200d84:	bf868693          	addi	a3,a3,-1032 # ffffffffc0201978 <buddy_pmm_manager+0x38>
ffffffffc0200d88:	00001617          	auipc	a2,0x1
ffffffffc0200d8c:	a7860613          	addi	a2,a2,-1416 # ffffffffc0201800 <etext+0x276>
ffffffffc0200d90:	05100593          	li	a1,81
ffffffffc0200d94:	00001517          	auipc	a0,0x1
ffffffffc0200d98:	c0450513          	addi	a0,a0,-1020 # ffffffffc0201998 <buddy_pmm_manager+0x58>
ffffffffc0200d9c:	c26ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200da0 <run_buddy_tests>:

/* public runner */
void run_buddy_tests(void) {
ffffffffc0200da0:	7179                	addi	sp,sp,-48
    cprintf("[buddy_tests] start\n");
ffffffffc0200da2:	00001517          	auipc	a0,0x1
ffffffffc0200da6:	c0e50513          	addi	a0,a0,-1010 # ffffffffc02019b0 <buddy_pmm_manager+0x70>
void run_buddy_tests(void) {
ffffffffc0200daa:	f406                	sd	ra,40(sp)
ffffffffc0200dac:	f022                	sd	s0,32(sp)
ffffffffc0200dae:	ec26                	sd	s1,24(sp)
ffffffffc0200db0:	e84a                	sd	s2,16(sp)
ffffffffc0200db2:	e44e                	sd	s3,8(sp)
    cprintf("[buddy_tests] start\n");
ffffffffc0200db4:	b98ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    size_t total = nr_free_pages();
ffffffffc0200db8:	15a000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
    struct Page *p = alloc_pages(total + 1);
ffffffffc0200dbc:	0505                	addi	a0,a0,1
ffffffffc0200dbe:	13c000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
    assert(p == NULL);
ffffffffc0200dc2:	0e051d63          	bnez	a0,ffffffffc0200ebc <run_buddy_tests+0x11c>
    size_t total = nr_free_pages();
ffffffffc0200dc6:	14c000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc0200dca:	842a                	mv	s0,a0
    size_t max_pow = 1;
ffffffffc0200dcc:	4785                	li	a5,1
    while ((max_pow << 1) <= total) max_pow <<= 1;
ffffffffc0200dce:	84be                	mv	s1,a5
ffffffffc0200dd0:	0786                	slli	a5,a5,0x1
ffffffffc0200dd2:	fef47ee3          	bgeu	s0,a5,ffffffffc0200dce <run_buddy_tests+0x2e>
    if (max_pow == 0) return;
ffffffffc0200dd6:	e8a1                	bnez	s1,ffffffffc0200e26 <run_buddy_tests+0x86>
    size_t total = nr_free_pages();
ffffffffc0200dd8:	13a000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc0200ddc:	84aa                	mv	s1,a0
    size_t cnt = 0;
ffffffffc0200dde:	4401                	li	s0,0
    while ((p = alloc_page()) != NULL) {
ffffffffc0200de0:	a039                	j	ffffffffc0200dee <run_buddy_tests+0x4e>
        cnt++;
ffffffffc0200de2:	0405                	addi	s0,s0,1
        free_page(p);
ffffffffc0200de4:	4585                	li	a1,1
ffffffffc0200de6:	120000ef          	jal	ra,ffffffffc0200f06 <free_pages>
        if (cnt > total) break;
ffffffffc0200dea:	0084e663          	bltu	s1,s0,ffffffffc0200df6 <run_buddy_tests+0x56>
    while ((p = alloc_page()) != NULL) {
ffffffffc0200dee:	4505                	li	a0,1
ffffffffc0200df0:	10a000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc0200df4:	f57d                	bnez	a0,ffffffffc0200de2 <run_buddy_tests+0x42>
    assert(nr_free_pages() == total);
ffffffffc0200df6:	11c000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc0200dfa:	0ea49063          	bne	s1,a0,ffffffffc0200eda <run_buddy_tests+0x13a>
    size_t total = nr_free_pages();
ffffffffc0200dfe:	114000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
    if (total < want) return;
ffffffffc0200e02:	479d                	li	a5,7
    size_t total = nr_free_pages();
ffffffffc0200e04:	842a                	mv	s0,a0
    if (total < want) return;
ffffffffc0200e06:	04a7ea63          	bltu	a5,a0,ffffffffc0200e5a <run_buddy_tests+0xba>
    test_over_alloc();
    test_max_block();
    test_repeat_alloc_free();
    test_split_and_coalesce();
    test_random_sequence();
ffffffffc0200e0a:	e7fff0ef          	jal	ra,ffffffffc0200c88 <test_random_sequence>
    cprintf("[buddy_tests] passed\n");
}
ffffffffc0200e0e:	7402                	ld	s0,32(sp)
ffffffffc0200e10:	70a2                	ld	ra,40(sp)
ffffffffc0200e12:	64e2                	ld	s1,24(sp)
ffffffffc0200e14:	6942                	ld	s2,16(sp)
ffffffffc0200e16:	69a2                	ld	s3,8(sp)
    cprintf("[buddy_tests] passed\n");
ffffffffc0200e18:	00001517          	auipc	a0,0x1
ffffffffc0200e1c:	bc050513          	addi	a0,a0,-1088 # ffffffffc02019d8 <buddy_pmm_manager+0x98>
}
ffffffffc0200e20:	6145                	addi	sp,sp,48
    cprintf("[buddy_tests] passed\n");
ffffffffc0200e22:	b2aff06f          	j	ffffffffc020014c <cprintf>
    struct Page *m = alloc_pages(max_pow);
ffffffffc0200e26:	8526                	mv	a0,s1
ffffffffc0200e28:	0d2000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
    if (m) {
ffffffffc0200e2c:	d555                	beqz	a0,ffffffffc0200dd8 <run_buddy_tests+0x38>
        free_pages(m, max_pow);
ffffffffc0200e2e:	85a6                	mv	a1,s1
ffffffffc0200e30:	0d6000ef          	jal	ra,ffffffffc0200f06 <free_pages>
        assert(nr_free_pages() == total);
ffffffffc0200e34:	0de000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc0200e38:	faa400e3          	beq	s0,a0,ffffffffc0200dd8 <run_buddy_tests+0x38>
ffffffffc0200e3c:	00001697          	auipc	a3,0x1
ffffffffc0200e40:	b3c68693          	addi	a3,a3,-1220 # ffffffffc0201978 <buddy_pmm_manager+0x38>
ffffffffc0200e44:	00001617          	auipc	a2,0x1
ffffffffc0200e48:	9bc60613          	addi	a2,a2,-1604 # ffffffffc0201800 <etext+0x276>
ffffffffc0200e4c:	45d9                	li	a1,22
ffffffffc0200e4e:	00001517          	auipc	a0,0x1
ffffffffc0200e52:	b4a50513          	addi	a0,a0,-1206 # ffffffffc0201998 <buddy_pmm_manager+0x58>
ffffffffc0200e56:	b6cff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    struct Page *B = alloc_pages(want);
ffffffffc0200e5a:	4521                	li	a0,8
ffffffffc0200e5c:	09e000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc0200e60:	84aa                	mv	s1,a0
    if (!B) return;
ffffffffc0200e62:	d545                	beqz	a0,ffffffffc0200e0a <run_buddy_tests+0x6a>
    struct Page *x = alloc_pages(want/2);
ffffffffc0200e64:	4511                	li	a0,4
ffffffffc0200e66:	094000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc0200e6a:	89aa                	mv	s3,a0
    struct Page *y = alloc_pages(want/2);
ffffffffc0200e6c:	4511                	li	a0,4
ffffffffc0200e6e:	08c000ef          	jal	ra,ffffffffc0200efa <alloc_pages>
ffffffffc0200e72:	892a                	mv	s2,a0
    if (x) free_pages(x, want/2);
ffffffffc0200e74:	00098663          	beqz	s3,ffffffffc0200e80 <run_buddy_tests+0xe0>
ffffffffc0200e78:	4591                	li	a1,4
ffffffffc0200e7a:	854e                	mv	a0,s3
ffffffffc0200e7c:	08a000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    if (y) free_pages(y, want/2);
ffffffffc0200e80:	00090663          	beqz	s2,ffffffffc0200e8c <run_buddy_tests+0xec>
ffffffffc0200e84:	4591                	li	a1,4
ffffffffc0200e86:	854a                	mv	a0,s2
ffffffffc0200e88:	07e000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    free_pages(B, want);
ffffffffc0200e8c:	45a1                	li	a1,8
ffffffffc0200e8e:	8526                	mv	a0,s1
ffffffffc0200e90:	076000ef          	jal	ra,ffffffffc0200f06 <free_pages>
    assert(nr_free_pages() == total);
ffffffffc0200e94:	07e000ef          	jal	ra,ffffffffc0200f12 <nr_free_pages>
ffffffffc0200e98:	f6a409e3          	beq	s0,a0,ffffffffc0200e0a <run_buddy_tests+0x6a>
ffffffffc0200e9c:	00001697          	auipc	a3,0x1
ffffffffc0200ea0:	adc68693          	addi	a3,a3,-1316 # ffffffffc0201978 <buddy_pmm_manager+0x38>
ffffffffc0200ea4:	00001617          	auipc	a2,0x1
ffffffffc0200ea8:	95c60613          	addi	a2,a2,-1700 # ffffffffc0201800 <etext+0x276>
ffffffffc0200eac:	03700593          	li	a1,55
ffffffffc0200eb0:	00001517          	auipc	a0,0x1
ffffffffc0200eb4:	ae850513          	addi	a0,a0,-1304 # ffffffffc0201998 <buddy_pmm_manager+0x58>
ffffffffc0200eb8:	b0aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p == NULL);
ffffffffc0200ebc:	00001697          	auipc	a3,0x1
ffffffffc0200ec0:	b0c68693          	addi	a3,a3,-1268 # ffffffffc02019c8 <buddy_pmm_manager+0x88>
ffffffffc0200ec4:	00001617          	auipc	a2,0x1
ffffffffc0200ec8:	93c60613          	addi	a2,a2,-1732 # ffffffffc0201800 <etext+0x276>
ffffffffc0200ecc:	45a9                	li	a1,10
ffffffffc0200ece:	00001517          	auipc	a0,0x1
ffffffffc0200ed2:	aca50513          	addi	a0,a0,-1334 # ffffffffc0201998 <buddy_pmm_manager+0x58>
ffffffffc0200ed6:	aecff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(nr_free_pages() == total);
ffffffffc0200eda:	00001697          	auipc	a3,0x1
ffffffffc0200ede:	a9e68693          	addi	a3,a3,-1378 # ffffffffc0201978 <buddy_pmm_manager+0x38>
ffffffffc0200ee2:	00001617          	auipc	a2,0x1
ffffffffc0200ee6:	91e60613          	addi	a2,a2,-1762 # ffffffffc0201800 <etext+0x276>
ffffffffc0200eea:	02700593          	li	a1,39
ffffffffc0200eee:	00001517          	auipc	a0,0x1
ffffffffc0200ef2:	aaa50513          	addi	a0,a0,-1366 # ffffffffc0201998 <buddy_pmm_manager+0x58>
ffffffffc0200ef6:	accff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200efa <alloc_pages>:
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
    return pmm_manager->alloc_pages(n);
ffffffffc0200efa:	00004797          	auipc	a5,0x4
ffffffffc0200efe:	1fe7b783          	ld	a5,510(a5) # ffffffffc02050f8 <pmm_manager>
ffffffffc0200f02:	6f9c                	ld	a5,24(a5)
ffffffffc0200f04:	8782                	jr	a5

ffffffffc0200f06 <free_pages>:
}

// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    pmm_manager->free_pages(base, n);
ffffffffc0200f06:	00004797          	auipc	a5,0x4
ffffffffc0200f0a:	1f27b783          	ld	a5,498(a5) # ffffffffc02050f8 <pmm_manager>
ffffffffc0200f0e:	739c                	ld	a5,32(a5)
ffffffffc0200f10:	8782                	jr	a5

ffffffffc0200f12 <nr_free_pages>:
}

// nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE)
// of current free memory
size_t nr_free_pages(void) {
    return pmm_manager->nr_free_pages();
ffffffffc0200f12:	00004797          	auipc	a5,0x4
ffffffffc0200f16:	1e67b783          	ld	a5,486(a5) # ffffffffc02050f8 <pmm_manager>
ffffffffc0200f1a:	779c                	ld	a5,40(a5)
ffffffffc0200f1c:	8782                	jr	a5

ffffffffc0200f1e <pmm_init>:
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200f1e:	00001797          	auipc	a5,0x1
ffffffffc0200f22:	a2278793          	addi	a5,a5,-1502 # ffffffffc0201940 <buddy_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200f26:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0200f28:	7179                	addi	sp,sp,-48
ffffffffc0200f2a:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200f2c:	00001517          	auipc	a0,0x1
ffffffffc0200f30:	ac450513          	addi	a0,a0,-1340 # ffffffffc02019f0 <buddy_pmm_manager+0xb0>
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200f34:	00004417          	auipc	s0,0x4
ffffffffc0200f38:	1c440413          	addi	s0,s0,452 # ffffffffc02050f8 <pmm_manager>
void pmm_init(void) {
ffffffffc0200f3c:	f406                	sd	ra,40(sp)
ffffffffc0200f3e:	ec26                	sd	s1,24(sp)
ffffffffc0200f40:	e44e                	sd	s3,8(sp)
ffffffffc0200f42:	e84a                	sd	s2,16(sp)
ffffffffc0200f44:	e052                	sd	s4,0(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200f46:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200f48:	a04ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    pmm_manager->init();
ffffffffc0200f4c:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200f4e:	00004497          	auipc	s1,0x4
ffffffffc0200f52:	1c248493          	addi	s1,s1,450 # ffffffffc0205110 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200f56:	679c                	ld	a5,8(a5)
ffffffffc0200f58:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200f5a:	57f5                	li	a5,-3
ffffffffc0200f5c:	07fa                	slli	a5,a5,0x1e
ffffffffc0200f5e:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0200f60:	e5cff0ef          	jal	ra,ffffffffc02005bc <get_memory_base>
ffffffffc0200f64:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0200f66:	e60ff0ef          	jal	ra,ffffffffc02005c6 <get_memory_size>
    if (mem_size == 0) {
ffffffffc0200f6a:	14050d63          	beqz	a0,ffffffffc02010c4 <pmm_init+0x1a6>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200f6e:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0200f70:	00001517          	auipc	a0,0x1
ffffffffc0200f74:	ac850513          	addi	a0,a0,-1336 # ffffffffc0201a38 <buddy_pmm_manager+0xf8>
ffffffffc0200f78:	9d4ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200f7c:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0200f80:	864e                	mv	a2,s3
ffffffffc0200f82:	fffa0693          	addi	a3,s4,-1 # 41c64fff <kern_entry-0xffffffff7e59b001>
ffffffffc0200f86:	85ca                	mv	a1,s2
ffffffffc0200f88:	00001517          	auipc	a0,0x1
ffffffffc0200f8c:	ac850513          	addi	a0,a0,-1336 # ffffffffc0201a50 <buddy_pmm_manager+0x110>
ffffffffc0200f90:	9bcff0ef          	jal	ra,ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200f94:	c80007b7          	lui	a5,0xc8000
ffffffffc0200f98:	8652                	mv	a2,s4
ffffffffc0200f9a:	0d47e463          	bltu	a5,s4,ffffffffc0201062 <pmm_init+0x144>
ffffffffc0200f9e:	00005797          	auipc	a5,0x5
ffffffffc0200fa2:	17978793          	addi	a5,a5,377 # ffffffffc0206117 <end+0xfff>
ffffffffc0200fa6:	757d                	lui	a0,0xfffff
ffffffffc0200fa8:	8d7d                	and	a0,a0,a5
ffffffffc0200faa:	8231                	srli	a2,a2,0xc
ffffffffc0200fac:	00004797          	auipc	a5,0x4
ffffffffc0200fb0:	12c7be23          	sd	a2,316(a5) # ffffffffc02050e8 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200fb4:	00004797          	auipc	a5,0x4
ffffffffc0200fb8:	12a7be23          	sd	a0,316(a5) # ffffffffc02050f0 <pages>
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200fbc:	000807b7          	lui	a5,0x80
ffffffffc0200fc0:	002005b7          	lui	a1,0x200
ffffffffc0200fc4:	02f60563          	beq	a2,a5,ffffffffc0200fee <pmm_init+0xd0>
ffffffffc0200fc8:	00261593          	slli	a1,a2,0x2
ffffffffc0200fcc:	00c586b3          	add	a3,a1,a2
ffffffffc0200fd0:	fec007b7          	lui	a5,0xfec00
ffffffffc0200fd4:	97aa                	add	a5,a5,a0
ffffffffc0200fd6:	068e                	slli	a3,a3,0x3
ffffffffc0200fd8:	96be                	add	a3,a3,a5
ffffffffc0200fda:	87aa                	mv	a5,a0
        SetPageReserved(pages + i);
ffffffffc0200fdc:	6798                	ld	a4,8(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200fde:	02878793          	addi	a5,a5,40 # fffffffffec00028 <end+0x3e9faf10>
        SetPageReserved(pages + i);
ffffffffc0200fe2:	00176713          	ori	a4,a4,1
ffffffffc0200fe6:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200fea:	fef699e3          	bne	a3,a5,ffffffffc0200fdc <pmm_init+0xbe>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200fee:	95b2                	add	a1,a1,a2
ffffffffc0200ff0:	fec006b7          	lui	a3,0xfec00
ffffffffc0200ff4:	96aa                	add	a3,a3,a0
ffffffffc0200ff6:	058e                	slli	a1,a1,0x3
ffffffffc0200ff8:	96ae                	add	a3,a3,a1
ffffffffc0200ffa:	c02007b7          	lui	a5,0xc0200
ffffffffc0200ffe:	0af6e763          	bltu	a3,a5,ffffffffc02010ac <pmm_init+0x18e>
ffffffffc0201002:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0201004:	77fd                	lui	a5,0xfffff
ffffffffc0201006:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020100a:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc020100c:	04b6ee63          	bltu	a3,a1,ffffffffc0201068 <pmm_init+0x14a>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0201010:	601c                	ld	a5,0(s0)
ffffffffc0201012:	7b9c                	ld	a5,48(a5)
ffffffffc0201014:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0201016:	00001517          	auipc	a0,0x1
ffffffffc020101a:	ac250513          	addi	a0,a0,-1342 # ffffffffc0201ad8 <buddy_pmm_manager+0x198>
ffffffffc020101e:	92eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0201022:	00003597          	auipc	a1,0x3
ffffffffc0201026:	fde58593          	addi	a1,a1,-34 # ffffffffc0204000 <boot_page_table_sv39>
ffffffffc020102a:	00004797          	auipc	a5,0x4
ffffffffc020102e:	0cb7bf23          	sd	a1,222(a5) # ffffffffc0205108 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201032:	c02007b7          	lui	a5,0xc0200
ffffffffc0201036:	0af5e363          	bltu	a1,a5,ffffffffc02010dc <pmm_init+0x1be>
ffffffffc020103a:	6090                	ld	a2,0(s1)
}
ffffffffc020103c:	7402                	ld	s0,32(sp)
ffffffffc020103e:	70a2                	ld	ra,40(sp)
ffffffffc0201040:	64e2                	ld	s1,24(sp)
ffffffffc0201042:	6942                	ld	s2,16(sp)
ffffffffc0201044:	69a2                	ld	s3,8(sp)
ffffffffc0201046:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0201048:	40c58633          	sub	a2,a1,a2
ffffffffc020104c:	00004797          	auipc	a5,0x4
ffffffffc0201050:	0ac7ba23          	sd	a2,180(a5) # ffffffffc0205100 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0201054:	00001517          	auipc	a0,0x1
ffffffffc0201058:	aa450513          	addi	a0,a0,-1372 # ffffffffc0201af8 <buddy_pmm_manager+0x1b8>
}
ffffffffc020105c:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc020105e:	8eeff06f          	j	ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0201062:	c8000637          	lui	a2,0xc8000
ffffffffc0201066:	bf25                	j	ffffffffc0200f9e <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0201068:	6705                	lui	a4,0x1
ffffffffc020106a:	177d                	addi	a4,a4,-1
ffffffffc020106c:	96ba                	add	a3,a3,a4
ffffffffc020106e:	8efd                	and	a3,a3,a5
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc0201070:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201074:	02c7f063          	bgeu	a5,a2,ffffffffc0201094 <pmm_init+0x176>
    pmm_manager->init_memmap(base, n);
ffffffffc0201078:	6010                	ld	a2,0(s0)
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc020107a:	fff80737          	lui	a4,0xfff80
ffffffffc020107e:	973e                	add	a4,a4,a5
ffffffffc0201080:	00271793          	slli	a5,a4,0x2
ffffffffc0201084:	97ba                	add	a5,a5,a4
ffffffffc0201086:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0201088:	8d95                	sub	a1,a1,a3
ffffffffc020108a:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc020108c:	81b1                	srli	a1,a1,0xc
ffffffffc020108e:	953e                	add	a0,a0,a5
ffffffffc0201090:	9702                	jalr	a4
}
ffffffffc0201092:	bfbd                	j	ffffffffc0201010 <pmm_init+0xf2>
        panic("pa2page called with invalid pa");
ffffffffc0201094:	00001617          	auipc	a2,0x1
ffffffffc0201098:	a1460613          	addi	a2,a2,-1516 # ffffffffc0201aa8 <buddy_pmm_manager+0x168>
ffffffffc020109c:	06a00593          	li	a1,106
ffffffffc02010a0:	00001517          	auipc	a0,0x1
ffffffffc02010a4:	a2850513          	addi	a0,a0,-1496 # ffffffffc0201ac8 <buddy_pmm_manager+0x188>
ffffffffc02010a8:	91aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02010ac:	00001617          	auipc	a2,0x1
ffffffffc02010b0:	9d460613          	addi	a2,a2,-1580 # ffffffffc0201a80 <buddy_pmm_manager+0x140>
ffffffffc02010b4:	05f00593          	li	a1,95
ffffffffc02010b8:	00001517          	auipc	a0,0x1
ffffffffc02010bc:	97050513          	addi	a0,a0,-1680 # ffffffffc0201a28 <buddy_pmm_manager+0xe8>
ffffffffc02010c0:	902ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        panic("DTB memory info not available");
ffffffffc02010c4:	00001617          	auipc	a2,0x1
ffffffffc02010c8:	94460613          	addi	a2,a2,-1724 # ffffffffc0201a08 <buddy_pmm_manager+0xc8>
ffffffffc02010cc:	04700593          	li	a1,71
ffffffffc02010d0:	00001517          	auipc	a0,0x1
ffffffffc02010d4:	95850513          	addi	a0,a0,-1704 # ffffffffc0201a28 <buddy_pmm_manager+0xe8>
ffffffffc02010d8:	8eaff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc02010dc:	86ae                	mv	a3,a1
ffffffffc02010de:	00001617          	auipc	a2,0x1
ffffffffc02010e2:	9a260613          	addi	a2,a2,-1630 # ffffffffc0201a80 <buddy_pmm_manager+0x140>
ffffffffc02010e6:	07a00593          	li	a1,122
ffffffffc02010ea:	00001517          	auipc	a0,0x1
ffffffffc02010ee:	93e50513          	addi	a0,a0,-1730 # ffffffffc0201a28 <buddy_pmm_manager+0xe8>
ffffffffc02010f2:	8d0ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc02010f6 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02010f6:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02010fa:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02010fc:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201100:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0201102:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201106:	f022                	sd	s0,32(sp)
ffffffffc0201108:	ec26                	sd	s1,24(sp)
ffffffffc020110a:	e84a                	sd	s2,16(sp)
ffffffffc020110c:	f406                	sd	ra,40(sp)
ffffffffc020110e:	e44e                	sd	s3,8(sp)
ffffffffc0201110:	84aa                	mv	s1,a0
ffffffffc0201112:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0201114:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201118:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc020111a:	03067e63          	bgeu	a2,a6,ffffffffc0201156 <printnum+0x60>
ffffffffc020111e:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201120:	00805763          	blez	s0,ffffffffc020112e <printnum+0x38>
ffffffffc0201124:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201126:	85ca                	mv	a1,s2
ffffffffc0201128:	854e                	mv	a0,s3
ffffffffc020112a:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc020112c:	fc65                	bnez	s0,ffffffffc0201124 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020112e:	1a02                	slli	s4,s4,0x20
ffffffffc0201130:	00001797          	auipc	a5,0x1
ffffffffc0201134:	a0878793          	addi	a5,a5,-1528 # ffffffffc0201b38 <buddy_pmm_manager+0x1f8>
ffffffffc0201138:	020a5a13          	srli	s4,s4,0x20
ffffffffc020113c:	9a3e                	add	s4,s4,a5
}
ffffffffc020113e:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201140:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201144:	70a2                	ld	ra,40(sp)
ffffffffc0201146:	69a2                	ld	s3,8(sp)
ffffffffc0201148:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020114a:	85ca                	mv	a1,s2
ffffffffc020114c:	87a6                	mv	a5,s1
}
ffffffffc020114e:	6942                	ld	s2,16(sp)
ffffffffc0201150:	64e2                	ld	s1,24(sp)
ffffffffc0201152:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201154:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201156:	03065633          	divu	a2,a2,a6
ffffffffc020115a:	8722                	mv	a4,s0
ffffffffc020115c:	f9bff0ef          	jal	ra,ffffffffc02010f6 <printnum>
ffffffffc0201160:	b7f9                	j	ffffffffc020112e <printnum+0x38>

ffffffffc0201162 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201162:	7119                	addi	sp,sp,-128
ffffffffc0201164:	f4a6                	sd	s1,104(sp)
ffffffffc0201166:	f0ca                	sd	s2,96(sp)
ffffffffc0201168:	ecce                	sd	s3,88(sp)
ffffffffc020116a:	e8d2                	sd	s4,80(sp)
ffffffffc020116c:	e4d6                	sd	s5,72(sp)
ffffffffc020116e:	e0da                	sd	s6,64(sp)
ffffffffc0201170:	fc5e                	sd	s7,56(sp)
ffffffffc0201172:	f06a                	sd	s10,32(sp)
ffffffffc0201174:	fc86                	sd	ra,120(sp)
ffffffffc0201176:	f8a2                	sd	s0,112(sp)
ffffffffc0201178:	f862                	sd	s8,48(sp)
ffffffffc020117a:	f466                	sd	s9,40(sp)
ffffffffc020117c:	ec6e                	sd	s11,24(sp)
ffffffffc020117e:	892a                	mv	s2,a0
ffffffffc0201180:	84ae                	mv	s1,a1
ffffffffc0201182:	8d32                	mv	s10,a2
ffffffffc0201184:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201186:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc020118a:	5b7d                	li	s6,-1
ffffffffc020118c:	00001a97          	auipc	s5,0x1
ffffffffc0201190:	9e0a8a93          	addi	s5,s5,-1568 # ffffffffc0201b6c <buddy_pmm_manager+0x22c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201194:	00001b97          	auipc	s7,0x1
ffffffffc0201198:	bb4b8b93          	addi	s7,s7,-1100 # ffffffffc0201d48 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020119c:	000d4503          	lbu	a0,0(s10)
ffffffffc02011a0:	001d0413          	addi	s0,s10,1
ffffffffc02011a4:	01350a63          	beq	a0,s3,ffffffffc02011b8 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc02011a8:	c121                	beqz	a0,ffffffffc02011e8 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc02011aa:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02011ac:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc02011ae:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02011b0:	fff44503          	lbu	a0,-1(s0)
ffffffffc02011b4:	ff351ae3          	bne	a0,s3,ffffffffc02011a8 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02011b8:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02011bc:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02011c0:	4c81                	li	s9,0
ffffffffc02011c2:	4881                	li	a7,0
        width = precision = -1;
ffffffffc02011c4:	5c7d                	li	s8,-1
ffffffffc02011c6:	5dfd                	li	s11,-1
ffffffffc02011c8:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02011cc:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02011ce:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02011d2:	0ff5f593          	zext.b	a1,a1
ffffffffc02011d6:	00140d13          	addi	s10,s0,1
ffffffffc02011da:	04b56263          	bltu	a0,a1,ffffffffc020121e <vprintfmt+0xbc>
ffffffffc02011de:	058a                	slli	a1,a1,0x2
ffffffffc02011e0:	95d6                	add	a1,a1,s5
ffffffffc02011e2:	4194                	lw	a3,0(a1)
ffffffffc02011e4:	96d6                	add	a3,a3,s5
ffffffffc02011e6:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02011e8:	70e6                	ld	ra,120(sp)
ffffffffc02011ea:	7446                	ld	s0,112(sp)
ffffffffc02011ec:	74a6                	ld	s1,104(sp)
ffffffffc02011ee:	7906                	ld	s2,96(sp)
ffffffffc02011f0:	69e6                	ld	s3,88(sp)
ffffffffc02011f2:	6a46                	ld	s4,80(sp)
ffffffffc02011f4:	6aa6                	ld	s5,72(sp)
ffffffffc02011f6:	6b06                	ld	s6,64(sp)
ffffffffc02011f8:	7be2                	ld	s7,56(sp)
ffffffffc02011fa:	7c42                	ld	s8,48(sp)
ffffffffc02011fc:	7ca2                	ld	s9,40(sp)
ffffffffc02011fe:	7d02                	ld	s10,32(sp)
ffffffffc0201200:	6de2                	ld	s11,24(sp)
ffffffffc0201202:	6109                	addi	sp,sp,128
ffffffffc0201204:	8082                	ret
            padc = '0';
ffffffffc0201206:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201208:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020120c:	846a                	mv	s0,s10
ffffffffc020120e:	00140d13          	addi	s10,s0,1
ffffffffc0201212:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201216:	0ff5f593          	zext.b	a1,a1
ffffffffc020121a:	fcb572e3          	bgeu	a0,a1,ffffffffc02011de <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc020121e:	85a6                	mv	a1,s1
ffffffffc0201220:	02500513          	li	a0,37
ffffffffc0201224:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201226:	fff44783          	lbu	a5,-1(s0)
ffffffffc020122a:	8d22                	mv	s10,s0
ffffffffc020122c:	f73788e3          	beq	a5,s3,ffffffffc020119c <vprintfmt+0x3a>
ffffffffc0201230:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201234:	1d7d                	addi	s10,s10,-1
ffffffffc0201236:	ff379de3          	bne	a5,s3,ffffffffc0201230 <vprintfmt+0xce>
ffffffffc020123a:	b78d                	j	ffffffffc020119c <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc020123c:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201240:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201244:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201246:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc020124a:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc020124e:	02d86463          	bltu	a6,a3,ffffffffc0201276 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201252:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201256:	002c169b          	slliw	a3,s8,0x2
ffffffffc020125a:	0186873b          	addw	a4,a3,s8
ffffffffc020125e:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201262:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201264:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201268:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc020126a:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc020126e:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201272:	fed870e3          	bgeu	a6,a3,ffffffffc0201252 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201276:	f40ddce3          	bgez	s11,ffffffffc02011ce <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc020127a:	8de2                	mv	s11,s8
ffffffffc020127c:	5c7d                	li	s8,-1
ffffffffc020127e:	bf81                	j	ffffffffc02011ce <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201280:	fffdc693          	not	a3,s11
ffffffffc0201284:	96fd                	srai	a3,a3,0x3f
ffffffffc0201286:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020128a:	00144603          	lbu	a2,1(s0)
ffffffffc020128e:	2d81                	sext.w	s11,s11
ffffffffc0201290:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201292:	bf35                	j	ffffffffc02011ce <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201294:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201298:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc020129c:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020129e:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc02012a0:	bfd9                	j	ffffffffc0201276 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc02012a2:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02012a4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02012a8:	01174463          	blt	a4,a7,ffffffffc02012b0 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc02012ac:	1a088e63          	beqz	a7,ffffffffc0201468 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc02012b0:	000a3603          	ld	a2,0(s4)
ffffffffc02012b4:	46c1                	li	a3,16
ffffffffc02012b6:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc02012b8:	2781                	sext.w	a5,a5
ffffffffc02012ba:	876e                	mv	a4,s11
ffffffffc02012bc:	85a6                	mv	a1,s1
ffffffffc02012be:	854a                	mv	a0,s2
ffffffffc02012c0:	e37ff0ef          	jal	ra,ffffffffc02010f6 <printnum>
            break;
ffffffffc02012c4:	bde1                	j	ffffffffc020119c <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc02012c6:	000a2503          	lw	a0,0(s4)
ffffffffc02012ca:	85a6                	mv	a1,s1
ffffffffc02012cc:	0a21                	addi	s4,s4,8
ffffffffc02012ce:	9902                	jalr	s2
            break;
ffffffffc02012d0:	b5f1                	j	ffffffffc020119c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02012d2:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02012d4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02012d8:	01174463          	blt	a4,a7,ffffffffc02012e0 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc02012dc:	18088163          	beqz	a7,ffffffffc020145e <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc02012e0:	000a3603          	ld	a2,0(s4)
ffffffffc02012e4:	46a9                	li	a3,10
ffffffffc02012e6:	8a2e                	mv	s4,a1
ffffffffc02012e8:	bfc1                	j	ffffffffc02012b8 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02012ea:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc02012ee:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02012f0:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02012f2:	bdf1                	j	ffffffffc02011ce <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc02012f4:	85a6                	mv	a1,s1
ffffffffc02012f6:	02500513          	li	a0,37
ffffffffc02012fa:	9902                	jalr	s2
            break;
ffffffffc02012fc:	b545                	j	ffffffffc020119c <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02012fe:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201302:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201304:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201306:	b5e1                	j	ffffffffc02011ce <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201308:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020130a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020130e:	01174463          	blt	a4,a7,ffffffffc0201316 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201312:	14088163          	beqz	a7,ffffffffc0201454 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201316:	000a3603          	ld	a2,0(s4)
ffffffffc020131a:	46a1                	li	a3,8
ffffffffc020131c:	8a2e                	mv	s4,a1
ffffffffc020131e:	bf69                	j	ffffffffc02012b8 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201320:	03000513          	li	a0,48
ffffffffc0201324:	85a6                	mv	a1,s1
ffffffffc0201326:	e03e                	sd	a5,0(sp)
ffffffffc0201328:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc020132a:	85a6                	mv	a1,s1
ffffffffc020132c:	07800513          	li	a0,120
ffffffffc0201330:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201332:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201334:	6782                	ld	a5,0(sp)
ffffffffc0201336:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201338:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc020133c:	bfb5                	j	ffffffffc02012b8 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020133e:	000a3403          	ld	s0,0(s4)
ffffffffc0201342:	008a0713          	addi	a4,s4,8
ffffffffc0201346:	e03a                	sd	a4,0(sp)
ffffffffc0201348:	14040263          	beqz	s0,ffffffffc020148c <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc020134c:	0fb05763          	blez	s11,ffffffffc020143a <vprintfmt+0x2d8>
ffffffffc0201350:	02d00693          	li	a3,45
ffffffffc0201354:	0cd79163          	bne	a5,a3,ffffffffc0201416 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201358:	00044783          	lbu	a5,0(s0)
ffffffffc020135c:	0007851b          	sext.w	a0,a5
ffffffffc0201360:	cf85                	beqz	a5,ffffffffc0201398 <vprintfmt+0x236>
ffffffffc0201362:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201366:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020136a:	000c4563          	bltz	s8,ffffffffc0201374 <vprintfmt+0x212>
ffffffffc020136e:	3c7d                	addiw	s8,s8,-1
ffffffffc0201370:	036c0263          	beq	s8,s6,ffffffffc0201394 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201374:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201376:	0e0c8e63          	beqz	s9,ffffffffc0201472 <vprintfmt+0x310>
ffffffffc020137a:	3781                	addiw	a5,a5,-32
ffffffffc020137c:	0ef47b63          	bgeu	s0,a5,ffffffffc0201472 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201380:	03f00513          	li	a0,63
ffffffffc0201384:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201386:	000a4783          	lbu	a5,0(s4)
ffffffffc020138a:	3dfd                	addiw	s11,s11,-1
ffffffffc020138c:	0a05                	addi	s4,s4,1
ffffffffc020138e:	0007851b          	sext.w	a0,a5
ffffffffc0201392:	ffe1                	bnez	a5,ffffffffc020136a <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201394:	01b05963          	blez	s11,ffffffffc02013a6 <vprintfmt+0x244>
ffffffffc0201398:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc020139a:	85a6                	mv	a1,s1
ffffffffc020139c:	02000513          	li	a0,32
ffffffffc02013a0:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc02013a2:	fe0d9be3          	bnez	s11,ffffffffc0201398 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02013a6:	6a02                	ld	s4,0(sp)
ffffffffc02013a8:	bbd5                	j	ffffffffc020119c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02013aa:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02013ac:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc02013b0:	01174463          	blt	a4,a7,ffffffffc02013b8 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc02013b4:	08088d63          	beqz	a7,ffffffffc020144e <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc02013b8:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc02013bc:	0a044d63          	bltz	s0,ffffffffc0201476 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc02013c0:	8622                	mv	a2,s0
ffffffffc02013c2:	8a66                	mv	s4,s9
ffffffffc02013c4:	46a9                	li	a3,10
ffffffffc02013c6:	bdcd                	j	ffffffffc02012b8 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc02013c8:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02013cc:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc02013ce:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc02013d0:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc02013d4:	8fb5                	xor	a5,a5,a3
ffffffffc02013d6:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02013da:	02d74163          	blt	a4,a3,ffffffffc02013fc <vprintfmt+0x29a>
ffffffffc02013de:	00369793          	slli	a5,a3,0x3
ffffffffc02013e2:	97de                	add	a5,a5,s7
ffffffffc02013e4:	639c                	ld	a5,0(a5)
ffffffffc02013e6:	cb99                	beqz	a5,ffffffffc02013fc <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc02013e8:	86be                	mv	a3,a5
ffffffffc02013ea:	00000617          	auipc	a2,0x0
ffffffffc02013ee:	77e60613          	addi	a2,a2,1918 # ffffffffc0201b68 <buddy_pmm_manager+0x228>
ffffffffc02013f2:	85a6                	mv	a1,s1
ffffffffc02013f4:	854a                	mv	a0,s2
ffffffffc02013f6:	0ce000ef          	jal	ra,ffffffffc02014c4 <printfmt>
ffffffffc02013fa:	b34d                	j	ffffffffc020119c <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc02013fc:	00000617          	auipc	a2,0x0
ffffffffc0201400:	75c60613          	addi	a2,a2,1884 # ffffffffc0201b58 <buddy_pmm_manager+0x218>
ffffffffc0201404:	85a6                	mv	a1,s1
ffffffffc0201406:	854a                	mv	a0,s2
ffffffffc0201408:	0bc000ef          	jal	ra,ffffffffc02014c4 <printfmt>
ffffffffc020140c:	bb41                	j	ffffffffc020119c <vprintfmt+0x3a>
                p = "(null)";
ffffffffc020140e:	00000417          	auipc	s0,0x0
ffffffffc0201412:	74240413          	addi	s0,s0,1858 # ffffffffc0201b50 <buddy_pmm_manager+0x210>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201416:	85e2                	mv	a1,s8
ffffffffc0201418:	8522                	mv	a0,s0
ffffffffc020141a:	e43e                	sd	a5,8(sp)
ffffffffc020141c:	0fc000ef          	jal	ra,ffffffffc0201518 <strnlen>
ffffffffc0201420:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201424:	01b05b63          	blez	s11,ffffffffc020143a <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201428:	67a2                	ld	a5,8(sp)
ffffffffc020142a:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020142e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201430:	85a6                	mv	a1,s1
ffffffffc0201432:	8552                	mv	a0,s4
ffffffffc0201434:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201436:	fe0d9ce3          	bnez	s11,ffffffffc020142e <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020143a:	00044783          	lbu	a5,0(s0)
ffffffffc020143e:	00140a13          	addi	s4,s0,1
ffffffffc0201442:	0007851b          	sext.w	a0,a5
ffffffffc0201446:	d3a5                	beqz	a5,ffffffffc02013a6 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201448:	05e00413          	li	s0,94
ffffffffc020144c:	bf39                	j	ffffffffc020136a <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc020144e:	000a2403          	lw	s0,0(s4)
ffffffffc0201452:	b7ad                	j	ffffffffc02013bc <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201454:	000a6603          	lwu	a2,0(s4)
ffffffffc0201458:	46a1                	li	a3,8
ffffffffc020145a:	8a2e                	mv	s4,a1
ffffffffc020145c:	bdb1                	j	ffffffffc02012b8 <vprintfmt+0x156>
ffffffffc020145e:	000a6603          	lwu	a2,0(s4)
ffffffffc0201462:	46a9                	li	a3,10
ffffffffc0201464:	8a2e                	mv	s4,a1
ffffffffc0201466:	bd89                	j	ffffffffc02012b8 <vprintfmt+0x156>
ffffffffc0201468:	000a6603          	lwu	a2,0(s4)
ffffffffc020146c:	46c1                	li	a3,16
ffffffffc020146e:	8a2e                	mv	s4,a1
ffffffffc0201470:	b5a1                	j	ffffffffc02012b8 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201472:	9902                	jalr	s2
ffffffffc0201474:	bf09                	j	ffffffffc0201386 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201476:	85a6                	mv	a1,s1
ffffffffc0201478:	02d00513          	li	a0,45
ffffffffc020147c:	e03e                	sd	a5,0(sp)
ffffffffc020147e:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201480:	6782                	ld	a5,0(sp)
ffffffffc0201482:	8a66                	mv	s4,s9
ffffffffc0201484:	40800633          	neg	a2,s0
ffffffffc0201488:	46a9                	li	a3,10
ffffffffc020148a:	b53d                	j	ffffffffc02012b8 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc020148c:	03b05163          	blez	s11,ffffffffc02014ae <vprintfmt+0x34c>
ffffffffc0201490:	02d00693          	li	a3,45
ffffffffc0201494:	f6d79de3          	bne	a5,a3,ffffffffc020140e <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201498:	00000417          	auipc	s0,0x0
ffffffffc020149c:	6b840413          	addi	s0,s0,1720 # ffffffffc0201b50 <buddy_pmm_manager+0x210>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02014a0:	02800793          	li	a5,40
ffffffffc02014a4:	02800513          	li	a0,40
ffffffffc02014a8:	00140a13          	addi	s4,s0,1
ffffffffc02014ac:	bd6d                	j	ffffffffc0201366 <vprintfmt+0x204>
ffffffffc02014ae:	00000a17          	auipc	s4,0x0
ffffffffc02014b2:	6a3a0a13          	addi	s4,s4,1699 # ffffffffc0201b51 <buddy_pmm_manager+0x211>
ffffffffc02014b6:	02800513          	li	a0,40
ffffffffc02014ba:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02014be:	05e00413          	li	s0,94
ffffffffc02014c2:	b565                	j	ffffffffc020136a <vprintfmt+0x208>

ffffffffc02014c4 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02014c4:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc02014c6:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02014ca:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02014cc:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02014ce:	ec06                	sd	ra,24(sp)
ffffffffc02014d0:	f83a                	sd	a4,48(sp)
ffffffffc02014d2:	fc3e                	sd	a5,56(sp)
ffffffffc02014d4:	e0c2                	sd	a6,64(sp)
ffffffffc02014d6:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02014d8:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02014da:	c89ff0ef          	jal	ra,ffffffffc0201162 <vprintfmt>
}
ffffffffc02014de:	60e2                	ld	ra,24(sp)
ffffffffc02014e0:	6161                	addi	sp,sp,80
ffffffffc02014e2:	8082                	ret

ffffffffc02014e4 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc02014e4:	4781                	li	a5,0
ffffffffc02014e6:	00004717          	auipc	a4,0x4
ffffffffc02014ea:	b2a73703          	ld	a4,-1238(a4) # ffffffffc0205010 <SBI_CONSOLE_PUTCHAR>
ffffffffc02014ee:	88ba                	mv	a7,a4
ffffffffc02014f0:	852a                	mv	a0,a0
ffffffffc02014f2:	85be                	mv	a1,a5
ffffffffc02014f4:	863e                	mv	a2,a5
ffffffffc02014f6:	00000073          	ecall
ffffffffc02014fa:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc02014fc:	8082                	ret

ffffffffc02014fe <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02014fe:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201502:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201504:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201506:	cb81                	beqz	a5,ffffffffc0201516 <strlen+0x18>
        cnt ++;
ffffffffc0201508:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc020150a:	00a707b3          	add	a5,a4,a0
ffffffffc020150e:	0007c783          	lbu	a5,0(a5)
ffffffffc0201512:	fbfd                	bnez	a5,ffffffffc0201508 <strlen+0xa>
ffffffffc0201514:	8082                	ret
    }
    return cnt;
}
ffffffffc0201516:	8082                	ret

ffffffffc0201518 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201518:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020151a:	e589                	bnez	a1,ffffffffc0201524 <strnlen+0xc>
ffffffffc020151c:	a811                	j	ffffffffc0201530 <strnlen+0x18>
        cnt ++;
ffffffffc020151e:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201520:	00f58863          	beq	a1,a5,ffffffffc0201530 <strnlen+0x18>
ffffffffc0201524:	00f50733          	add	a4,a0,a5
ffffffffc0201528:	00074703          	lbu	a4,0(a4)
ffffffffc020152c:	fb6d                	bnez	a4,ffffffffc020151e <strnlen+0x6>
ffffffffc020152e:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201530:	852e                	mv	a0,a1
ffffffffc0201532:	8082                	ret

ffffffffc0201534 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201534:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201538:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020153c:	cb89                	beqz	a5,ffffffffc020154e <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc020153e:	0505                	addi	a0,a0,1
ffffffffc0201540:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201542:	fee789e3          	beq	a5,a4,ffffffffc0201534 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201546:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc020154a:	9d19                	subw	a0,a0,a4
ffffffffc020154c:	8082                	ret
ffffffffc020154e:	4501                	li	a0,0
ffffffffc0201550:	bfed                	j	ffffffffc020154a <strcmp+0x16>

ffffffffc0201552 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201552:	c20d                	beqz	a2,ffffffffc0201574 <strncmp+0x22>
ffffffffc0201554:	962e                	add	a2,a2,a1
ffffffffc0201556:	a031                	j	ffffffffc0201562 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201558:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020155a:	00e79a63          	bne	a5,a4,ffffffffc020156e <strncmp+0x1c>
ffffffffc020155e:	00b60b63          	beq	a2,a1,ffffffffc0201574 <strncmp+0x22>
ffffffffc0201562:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201566:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201568:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020156c:	f7f5                	bnez	a5,ffffffffc0201558 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020156e:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201572:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201574:	4501                	li	a0,0
ffffffffc0201576:	8082                	ret

ffffffffc0201578 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201578:	ca01                	beqz	a2,ffffffffc0201588 <memset+0x10>
ffffffffc020157a:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc020157c:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020157e:	0785                	addi	a5,a5,1
ffffffffc0201580:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201584:	fec79de3          	bne	a5,a2,ffffffffc020157e <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201588:	8082                	ret
