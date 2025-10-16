
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
ffffffffc0200050:	1c450513          	addi	a0,a0,452 # ffffffffc0201210 <etext+0x6>
void print_kerninfo(void) {
ffffffffc0200054:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200056:	0f6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", (uintptr_t)kern_init);
ffffffffc020005a:	00000597          	auipc	a1,0x0
ffffffffc020005e:	07e58593          	addi	a1,a1,126 # ffffffffc02000d8 <kern_init>
ffffffffc0200062:	00001517          	auipc	a0,0x1
ffffffffc0200066:	1ce50513          	addi	a0,a0,462 # ffffffffc0201230 <etext+0x26>
ffffffffc020006a:	0e2000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020006e:	00001597          	auipc	a1,0x1
ffffffffc0200072:	19c58593          	addi	a1,a1,412 # ffffffffc020120a <etext>
ffffffffc0200076:	00001517          	auipc	a0,0x1
ffffffffc020007a:	1da50513          	addi	a0,a0,474 # ffffffffc0201250 <etext+0x46>
ffffffffc020007e:	0ce000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200082:	00005597          	auipc	a1,0x5
ffffffffc0200086:	f9658593          	addi	a1,a1,-106 # ffffffffc0205018 <free_areas>
ffffffffc020008a:	00001517          	auipc	a0,0x1
ffffffffc020008e:	1e650513          	addi	a0,a0,486 # ffffffffc0201270 <etext+0x66>
ffffffffc0200092:	0ba000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc0200096:	00005597          	auipc	a1,0x5
ffffffffc020009a:	16a58593          	addi	a1,a1,362 # ffffffffc0205200 <end>
ffffffffc020009e:	00001517          	auipc	a0,0x1
ffffffffc02000a2:	1f250513          	addi	a0,a0,498 # ffffffffc0201290 <etext+0x86>
ffffffffc02000a6:	0a6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - (char*)kern_init + 1023) / 1024);
ffffffffc02000aa:	00005597          	auipc	a1,0x5
ffffffffc02000ae:	55558593          	addi	a1,a1,1365 # ffffffffc02055ff <end+0x3ff>
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
ffffffffc02000d0:	1e450513          	addi	a0,a0,484 # ffffffffc02012b0 <etext+0xa6>
}
ffffffffc02000d4:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000d6:	a89d                	j	ffffffffc020014c <cprintf>

ffffffffc02000d8 <kern_init>:

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc02000d8:	00005517          	auipc	a0,0x5
ffffffffc02000dc:	f4050513          	addi	a0,a0,-192 # ffffffffc0205018 <free_areas>
ffffffffc02000e0:	00005617          	auipc	a2,0x5
ffffffffc02000e4:	12060613          	addi	a2,a2,288 # ffffffffc0205200 <end>
int kern_init(void) {
ffffffffc02000e8:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc02000ea:	8e09                	sub	a2,a2,a0
ffffffffc02000ec:	4581                	li	a1,0
int kern_init(void) {
ffffffffc02000ee:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc02000f0:	108010ef          	jal	ra,ffffffffc02011f8 <memset>
    dtb_init();
ffffffffc02000f4:	12c000ef          	jal	ra,ffffffffc0200220 <dtb_init>
    cons_init();  // init the console
ffffffffc02000f8:	11e000ef          	jal	ra,ffffffffc0200216 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc02000fc:	00001517          	auipc	a0,0x1
ffffffffc0200100:	1e450513          	addi	a0,a0,484 # ffffffffc02012e0 <etext+0xd6>
ffffffffc0200104:	07e000ef          	jal	ra,ffffffffc0200182 <cputs>

    print_kerninfo();
ffffffffc0200108:	f43ff0ef          	jal	ra,ffffffffc020004a <print_kerninfo>

    // grade_backtrace();
    pmm_init();  // init physical memory management
ffffffffc020010c:	293000ef          	jal	ra,ffffffffc0200b9e <pmm_init>

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
ffffffffc0200140:	4a3000ef          	jal	ra,ffffffffc0200de2 <vprintfmt>
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
ffffffffc0200176:	46d000ef          	jal	ra,ffffffffc0200de2 <vprintfmt>
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
ffffffffc02001c6:	fee30313          	addi	t1,t1,-18 # ffffffffc02051b0 <is_panic>
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
ffffffffc02001f6:	10e50513          	addi	a0,a0,270 # ffffffffc0201300 <etext+0xf6>
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
ffffffffc020020c:	0d050513          	addi	a0,a0,208 # ffffffffc02012d8 <etext+0xce>
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
ffffffffc020021c:	7490006f          	j	ffffffffc0201164 <sbi_console_putchar>

ffffffffc0200220 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200220:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200222:	00001517          	auipc	a0,0x1
ffffffffc0200226:	0fe50513          	addi	a0,a0,254 # ffffffffc0201320 <etext+0x116>
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
ffffffffc0200254:	0e050513          	addi	a0,a0,224 # ffffffffc0201330 <etext+0x126>
ffffffffc0200258:	ef5ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020025c:	00005417          	auipc	s0,0x5
ffffffffc0200260:	dac40413          	addi	s0,s0,-596 # ffffffffc0205008 <boot_dtb>
ffffffffc0200264:	600c                	ld	a1,0(s0)
ffffffffc0200266:	00001517          	auipc	a0,0x1
ffffffffc020026a:	0da50513          	addi	a0,a0,218 # ffffffffc0201340 <etext+0x136>
ffffffffc020026e:	edfff0ef          	jal	ra,ffffffffc020014c <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200272:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200276:	00001517          	auipc	a0,0x1
ffffffffc020027a:	0e250513          	addi	a0,a0,226 # ffffffffc0201358 <etext+0x14e>
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
ffffffffc02002be:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfedaced>
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
ffffffffc0200334:	07890913          	addi	s2,s2,120 # ffffffffc02013a8 <etext+0x19e>
ffffffffc0200338:	49bd                	li	s3,15
        switch (token) {
ffffffffc020033a:	4d91                	li	s11,4
ffffffffc020033c:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020033e:	00001497          	auipc	s1,0x1
ffffffffc0200342:	06248493          	addi	s1,s1,98 # ffffffffc02013a0 <etext+0x196>
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
ffffffffc0200396:	08e50513          	addi	a0,a0,142 # ffffffffc0201420 <etext+0x216>
ffffffffc020039a:	db3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020039e:	00001517          	auipc	a0,0x1
ffffffffc02003a2:	0ba50513          	addi	a0,a0,186 # ffffffffc0201458 <etext+0x24e>
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
ffffffffc02003e2:	f9a50513          	addi	a0,a0,-102 # ffffffffc0201378 <etext+0x16e>
}
ffffffffc02003e6:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003e8:	b395                	j	ffffffffc020014c <cprintf>
                int name_len = strlen(name);
ffffffffc02003ea:	8556                	mv	a0,s5
ffffffffc02003ec:	593000ef          	jal	ra,ffffffffc020117e <strlen>
ffffffffc02003f0:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003f2:	4619                	li	a2,6
ffffffffc02003f4:	85a6                	mv	a1,s1
ffffffffc02003f6:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02003f8:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003fa:	5d9000ef          	jal	ra,ffffffffc02011d2 <strncmp>
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
ffffffffc0200490:	525000ef          	jal	ra,ffffffffc02011b4 <strcmp>
ffffffffc0200494:	66a2                	ld	a3,8(sp)
ffffffffc0200496:	f94d                	bnez	a0,ffffffffc0200448 <dtb_init+0x228>
ffffffffc0200498:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200448 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020049c:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02004a0:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02004a4:	00001517          	auipc	a0,0x1
ffffffffc02004a8:	f0c50513          	addi	a0,a0,-244 # ffffffffc02013b0 <etext+0x1a6>
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
ffffffffc0200576:	e5e50513          	addi	a0,a0,-418 # ffffffffc02013d0 <etext+0x1c6>
ffffffffc020057a:	bd3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020057e:	014b5613          	srli	a2,s6,0x14
ffffffffc0200582:	85da                	mv	a1,s6
ffffffffc0200584:	00001517          	auipc	a0,0x1
ffffffffc0200588:	e6450513          	addi	a0,a0,-412 # ffffffffc02013e8 <etext+0x1de>
ffffffffc020058c:	bc1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200590:	008b05b3          	add	a1,s6,s0
ffffffffc0200594:	15fd                	addi	a1,a1,-1
ffffffffc0200596:	00001517          	auipc	a0,0x1
ffffffffc020059a:	e7250513          	addi	a0,a0,-398 # ffffffffc0201408 <etext+0x1fe>
ffffffffc020059e:	bafff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02005a2:	00001517          	auipc	a0,0x1
ffffffffc02005a6:	eb650513          	addi	a0,a0,-330 # ffffffffc0201458 <etext+0x24e>
        memory_base = mem_base;
ffffffffc02005aa:	00005797          	auipc	a5,0x5
ffffffffc02005ae:	c087b723          	sd	s0,-1010(a5) # ffffffffc02051b8 <memory_base>
        memory_size = mem_size;
ffffffffc02005b2:	00005797          	auipc	a5,0x5
ffffffffc02005b6:	c167b723          	sd	s6,-1010(a5) # ffffffffc02051c0 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc02005ba:	b3f5                	j	ffffffffc02003a6 <dtb_init+0x186>

ffffffffc02005bc <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc02005bc:	00005517          	auipc	a0,0x5
ffffffffc02005c0:	bfc53503          	ld	a0,-1028(a0) # ffffffffc02051b8 <memory_base>
ffffffffc02005c4:	8082                	ret

ffffffffc02005c6 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
ffffffffc02005c6:	00005517          	auipc	a0,0x5
ffffffffc02005ca:	bfa53503          	ld	a0,-1030(a0) # ffffffffc02051c0 <memory_size>
ffffffffc02005ce:	8082                	ret

ffffffffc02005d0 <buddy_init>:
    }
    return order;
}

static void buddy_init(void) {
    for (int i = 0; i <= MAX_ORDER; i++) {
ffffffffc02005d0:	00005797          	auipc	a5,0x5
ffffffffc02005d4:	a4878793          	addi	a5,a5,-1464 # ffffffffc0205018 <free_areas>
ffffffffc02005d8:	00005717          	auipc	a4,0x5
ffffffffc02005dc:	bd870713          	addi	a4,a4,-1064 # ffffffffc02051b0 <is_panic>
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc02005e0:	e79c                	sd	a5,8(a5)
ffffffffc02005e2:	e39c                	sd	a5,0(a5)
        list_init(&free_areas[i].free_list);
        free_areas[i].nr_free = 0;
ffffffffc02005e4:	0007a823          	sw	zero,16(a5)
    for (int i = 0; i <= MAX_ORDER; i++) {
ffffffffc02005e8:	07e1                	addi	a5,a5,24
ffffffffc02005ea:	fee79be3          	bne	a5,a4,ffffffffc02005e0 <buddy_init+0x10>
    }
    buddy_nr_free = 0;
ffffffffc02005ee:	00005797          	auipc	a5,0x5
ffffffffc02005f2:	bc07bd23          	sd	zero,-1062(a5) # ffffffffc02051c8 <buddy_nr_free>
}
ffffffffc02005f6:	8082                	ret

ffffffffc02005f8 <insert_free_block>:
 * Insert the new element @elm *after* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_after(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm, listelm->next);
ffffffffc02005f8:	00159793          	slli	a5,a1,0x1
ffffffffc02005fc:	97ae                	add	a5,a5,a1

/* helper to insert a free block (head) into order list */
static void insert_free_block(struct Page *p, int order) {
    p->property = 1UL << order; /* size in pages */
    SetPageProperty(p);
ffffffffc02005fe:	6510                	ld	a2,8(a0)
ffffffffc0200600:	00379713          	slli	a4,a5,0x3
ffffffffc0200604:	00005797          	auipc	a5,0x5
ffffffffc0200608:	a1478793          	addi	a5,a5,-1516 # ffffffffc0205018 <free_areas>
ffffffffc020060c:	97ba                	add	a5,a5,a4
    p->property = 1UL << order; /* size in pages */
ffffffffc020060e:	4705                	li	a4,1
ffffffffc0200610:	0087b303          	ld	t1,8(a5)
ffffffffc0200614:	00b715b3          	sll	a1,a4,a1
ffffffffc0200618:	0005889b          	sext.w	a7,a1
    SetPageProperty(p);
ffffffffc020061c:	00266713          	ori	a4,a2,2
    list_add(&free_areas[order].free_list, &p->page_link);
    free_areas[order].nr_free += p->property;
    buddy_nr_free += p->property;
ffffffffc0200620:	00005817          	auipc	a6,0x5
ffffffffc0200624:	ba880813          	addi	a6,a6,-1112 # ffffffffc02051c8 <buddy_nr_free>
    free_areas[order].nr_free += p->property;
ffffffffc0200628:	4b94                	lw	a3,16(a5)
    SetPageProperty(p);
ffffffffc020062a:	e518                	sd	a4,8(a0)
    p->property = 1UL << order; /* size in pages */
ffffffffc020062c:	01152823          	sw	a7,16(a0)
    buddy_nr_free += p->property;
ffffffffc0200630:	00083703          	ld	a4,0(a6)
    list_add(&free_areas[order].free_list, &p->page_link);
ffffffffc0200634:	01850613          	addi	a2,a0,24
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc0200638:	00c33023          	sd	a2,0(t1)
    buddy_nr_free += p->property;
ffffffffc020063c:	1582                	slli	a1,a1,0x20
ffffffffc020063e:	e790                	sd	a2,8(a5)
ffffffffc0200640:	9181                	srli	a1,a1,0x20
    elm->next = next;
ffffffffc0200642:	02653023          	sd	t1,32(a0)
    elm->prev = prev;
ffffffffc0200646:	ed1c                	sd	a5,24(a0)
    free_areas[order].nr_free += p->property;
ffffffffc0200648:	011686bb          	addw	a3,a3,a7
    buddy_nr_free += p->property;
ffffffffc020064c:	95ba                	add	a1,a1,a4
    free_areas[order].nr_free += p->property;
ffffffffc020064e:	cb94                	sw	a3,16(a5)
    buddy_nr_free += p->property;
ffffffffc0200650:	00b83023          	sd	a1,0(a6)
}
ffffffffc0200654:	8082                	ret

ffffffffc0200656 <buddy_nr_free_pages>:
            cur += block_size;
        }
    }
}

static size_t buddy_nr_free_pages(void) { return buddy_nr_free; }
ffffffffc0200656:	00005517          	auipc	a0,0x5
ffffffffc020065a:	b7253503          	ld	a0,-1166(a0) # ffffffffc02051c8 <buddy_nr_free>
ffffffffc020065e:	8082                	ret

ffffffffc0200660 <buddy_check>:
    free_page(p0);
    free_page(p1);
    free_page(p2);
}

static void buddy_check(void) {
ffffffffc0200660:	1101                	addi	sp,sp,-32
ffffffffc0200662:	e822                	sd	s0,16(sp)
ffffffffc0200664:	ec06                	sd	ra,24(sp)
ffffffffc0200666:	e426                	sd	s1,8(sp)
ffffffffc0200668:	e04a                	sd	s2,0(sp)
    // minimal smoke tests
    size_t before = nr_free_pages();
ffffffffc020066a:	528000ef          	jal	ra,ffffffffc0200b92 <nr_free_pages>
ffffffffc020066e:	842a                	mv	s0,a0
    struct Page *p = alloc_pages(8);
ffffffffc0200670:	4521                	li	a0,8
ffffffffc0200672:	508000ef          	jal	ra,ffffffffc0200b7a <alloc_pages>
    if (p) free_pages(p, 8);
ffffffffc0200676:	c501                	beqz	a0,ffffffffc020067e <buddy_check+0x1e>
ffffffffc0200678:	45a1                	li	a1,8
ffffffffc020067a:	50c000ef          	jal	ra,ffffffffc0200b86 <free_pages>
    assert(nr_free_pages() == before);
ffffffffc020067e:	514000ef          	jal	ra,ffffffffc0200b92 <nr_free_pages>
ffffffffc0200682:	0c851763          	bne	a0,s0,ffffffffc0200750 <buddy_check+0xf0>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200686:	4505                	li	a0,1
ffffffffc0200688:	4f2000ef          	jal	ra,ffffffffc0200b7a <alloc_pages>
ffffffffc020068c:	84aa                	mv	s1,a0
ffffffffc020068e:	c14d                	beqz	a0,ffffffffc0200730 <buddy_check+0xd0>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200690:	4505                	li	a0,1
ffffffffc0200692:	4e8000ef          	jal	ra,ffffffffc0200b7a <alloc_pages>
ffffffffc0200696:	842a                	mv	s0,a0
ffffffffc0200698:	cd25                	beqz	a0,ffffffffc0200710 <buddy_check+0xb0>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020069a:	4505                	li	a0,1
ffffffffc020069c:	4de000ef          	jal	ra,ffffffffc0200b7a <alloc_pages>
ffffffffc02006a0:	892a                	mv	s2,a0
ffffffffc02006a2:	c539                	beqz	a0,ffffffffc02006f0 <buddy_check+0x90>
    assert(p0 != p1 && p1 != p2 && p0 != p2);
ffffffffc02006a4:	02848663          	beq	s1,s0,ffffffffc02006d0 <buddy_check+0x70>
ffffffffc02006a8:	02a40463          	beq	s0,a0,ffffffffc02006d0 <buddy_check+0x70>
ffffffffc02006ac:	02a48263          	beq	s1,a0,ffffffffc02006d0 <buddy_check+0x70>
    free_page(p0);
ffffffffc02006b0:	8526                	mv	a0,s1
ffffffffc02006b2:	4585                	li	a1,1
ffffffffc02006b4:	4d2000ef          	jal	ra,ffffffffc0200b86 <free_pages>
    free_page(p1);
ffffffffc02006b8:	8522                	mv	a0,s0
ffffffffc02006ba:	4585                	li	a1,1
ffffffffc02006bc:	4ca000ef          	jal	ra,ffffffffc0200b86 <free_pages>
    buddy_basic_check();
}
ffffffffc02006c0:	6442                	ld	s0,16(sp)
ffffffffc02006c2:	60e2                	ld	ra,24(sp)
ffffffffc02006c4:	64a2                	ld	s1,8(sp)
    free_page(p2);
ffffffffc02006c6:	854a                	mv	a0,s2
}
ffffffffc02006c8:	6902                	ld	s2,0(sp)
    free_page(p2);
ffffffffc02006ca:	4585                	li	a1,1
}
ffffffffc02006cc:	6105                	addi	sp,sp,32
    free_page(p2);
ffffffffc02006ce:	a965                	j	ffffffffc0200b86 <free_pages>
    assert(p0 != p1 && p1 != p2 && p0 != p2);
ffffffffc02006d0:	00001697          	auipc	a3,0x1
ffffffffc02006d4:	e5068693          	addi	a3,a3,-432 # ffffffffc0201520 <etext+0x316>
ffffffffc02006d8:	00001617          	auipc	a2,0x1
ffffffffc02006dc:	db860613          	addi	a2,a2,-584 # ffffffffc0201490 <etext+0x286>
ffffffffc02006e0:	0c700593          	li	a1,199
ffffffffc02006e4:	00001517          	auipc	a0,0x1
ffffffffc02006e8:	dc450513          	addi	a0,a0,-572 # ffffffffc02014a8 <etext+0x29e>
ffffffffc02006ec:	ad7ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02006f0:	00001697          	auipc	a3,0x1
ffffffffc02006f4:	e1068693          	addi	a3,a3,-496 # ffffffffc0201500 <etext+0x2f6>
ffffffffc02006f8:	00001617          	auipc	a2,0x1
ffffffffc02006fc:	d9860613          	addi	a2,a2,-616 # ffffffffc0201490 <etext+0x286>
ffffffffc0200700:	0c600593          	li	a1,198
ffffffffc0200704:	00001517          	auipc	a0,0x1
ffffffffc0200708:	da450513          	addi	a0,a0,-604 # ffffffffc02014a8 <etext+0x29e>
ffffffffc020070c:	ab7ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200710:	00001697          	auipc	a3,0x1
ffffffffc0200714:	dd068693          	addi	a3,a3,-560 # ffffffffc02014e0 <etext+0x2d6>
ffffffffc0200718:	00001617          	auipc	a2,0x1
ffffffffc020071c:	d7860613          	addi	a2,a2,-648 # ffffffffc0201490 <etext+0x286>
ffffffffc0200720:	0c500593          	li	a1,197
ffffffffc0200724:	00001517          	auipc	a0,0x1
ffffffffc0200728:	d8450513          	addi	a0,a0,-636 # ffffffffc02014a8 <etext+0x29e>
ffffffffc020072c:	a97ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200730:	00001697          	auipc	a3,0x1
ffffffffc0200734:	d9068693          	addi	a3,a3,-624 # ffffffffc02014c0 <etext+0x2b6>
ffffffffc0200738:	00001617          	auipc	a2,0x1
ffffffffc020073c:	d5860613          	addi	a2,a2,-680 # ffffffffc0201490 <etext+0x286>
ffffffffc0200740:	0c400593          	li	a1,196
ffffffffc0200744:	00001517          	auipc	a0,0x1
ffffffffc0200748:	d6450513          	addi	a0,a0,-668 # ffffffffc02014a8 <etext+0x29e>
ffffffffc020074c:	a77ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(nr_free_pages() == before);
ffffffffc0200750:	00001697          	auipc	a3,0x1
ffffffffc0200754:	d2068693          	addi	a3,a3,-736 # ffffffffc0201470 <etext+0x266>
ffffffffc0200758:	00001617          	auipc	a2,0x1
ffffffffc020075c:	d3860613          	addi	a2,a2,-712 # ffffffffc0201490 <etext+0x286>
ffffffffc0200760:	0d200593          	li	a1,210
ffffffffc0200764:	00001517          	auipc	a0,0x1
ffffffffc0200768:	d4450513          	addi	a0,a0,-700 # ffffffffc02014a8 <etext+0x29e>
ffffffffc020076c:	a57ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200770 <buddy_free_pages>:
static void buddy_free_pages(struct Page *base, size_t n) {
ffffffffc0200770:	7159                	addi	sp,sp,-112
ffffffffc0200772:	f486                	sd	ra,104(sp)
ffffffffc0200774:	f0a2                	sd	s0,96(sp)
ffffffffc0200776:	eca6                	sd	s1,88(sp)
ffffffffc0200778:	e8ca                	sd	s2,80(sp)
ffffffffc020077a:	e4ce                	sd	s3,72(sp)
ffffffffc020077c:	e0d2                	sd	s4,64(sp)
ffffffffc020077e:	fc56                	sd	s5,56(sp)
ffffffffc0200780:	f85a                	sd	s6,48(sp)
ffffffffc0200782:	f45e                	sd	s7,40(sp)
ffffffffc0200784:	f062                	sd	s8,32(sp)
ffffffffc0200786:	ec66                	sd	s9,24(sp)
ffffffffc0200788:	e86a                	sd	s10,16(sp)
ffffffffc020078a:	e46e                	sd	s11,8(sp)
    assert(n > 0);
ffffffffc020078c:	18058163          	beqz	a1,ffffffffc020090e <buddy_free_pages+0x19e>
ffffffffc0200790:	00259693          	slli	a3,a1,0x2
ffffffffc0200794:	96ae                	add	a3,a3,a1
ffffffffc0200796:	068e                	slli	a3,a3,0x3
ffffffffc0200798:	8cae                	mv	s9,a1
ffffffffc020079a:	8daa                	mv	s11,a0
ffffffffc020079c:	87aa                	mv	a5,a0
ffffffffc020079e:	96aa                	add	a3,a3,a0
        ClearPageReserved(base + i);
ffffffffc02007a0:	6798                	ld	a4,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc02007a2:	0007a023          	sw	zero,0(a5)
    for (size_t i = 0; i < n; i++) {
ffffffffc02007a6:	02878793          	addi	a5,a5,40
        ClearPageReserved(base + i);
ffffffffc02007aa:	9b79                	andi	a4,a4,-2
ffffffffc02007ac:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < n; i++) {
ffffffffc02007b0:	fef698e3          	bne	a3,a5,ffffffffc02007a0 <buddy_free_pages+0x30>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02007b4:	00001417          	auipc	s0,0x1
ffffffffc02007b8:	19443403          	ld	s0,404(s0) # ffffffffc0201948 <nbase>
ffffffffc02007bc:	00005997          	auipc	s3,0x5
ffffffffc02007c0:	a1c98993          	addi	s3,s3,-1508 # ffffffffc02051d8 <pages>
ffffffffc02007c4:	00001917          	auipc	s2,0x1
ffffffffc02007c8:	17c93903          	ld	s2,380(s2) # ffffffffc0201940 <error_string+0x38>
ffffffffc02007cc:	00005497          	auipc	s1,0x5
ffffffffc02007d0:	a0448493          	addi	s1,s1,-1532 # ffffffffc02051d0 <npage>
        while ((1UL << order) < sz) order++;
ffffffffc02007d4:	4d05                	li	s10,1
ffffffffc02007d6:	6b05                	lui	s6,0x1
ffffffffc02007d8:	4ac1                	li	s5,16
            cur += block_size;
ffffffffc02007da:	02800a13          	li	s4,40
        size_t sz = 1UL;
ffffffffc02007de:	4785                	li	a5,1
        while ((sz << 1) <= remaining) {
ffffffffc02007e0:	873e                	mv	a4,a5
ffffffffc02007e2:	0786                	slli	a5,a5,0x1
ffffffffc02007e4:	fefcfee3          	bgeu	s9,a5,ffffffffc02007e0 <buddy_free_pages+0x70>
        while ((1UL << order) < sz) order++;
ffffffffc02007e8:	08ed7e63          	bgeu	s10,a4,ffffffffc0200884 <buddy_free_pages+0x114>
        int order = 0;
ffffffffc02007ec:	4781                	li	a5,0
        while ((1UL << order) < sz) order++;
ffffffffc02007ee:	2785                	addiw	a5,a5,1
ffffffffc02007f0:	00fd16b3          	sll	a3,s10,a5
ffffffffc02007f4:	fee6ede3          	bltu	a3,a4,ffffffffc02007ee <buddy_free_pages+0x7e>
ffffffffc02007f8:	873e                	mv	a4,a5
ffffffffc02007fa:	00fad363          	bge	s5,a5,ffffffffc0200800 <buddy_free_pages+0x90>
ffffffffc02007fe:	4741                	li	a4,16
ffffffffc0200800:	00070b9b          	sext.w	s7,a4
        size_t block_size = 1UL << order;
ffffffffc0200804:	00ed1c33          	sll	s8,s10,a4
        uintptr_t buddy_pa = pa ^ (block_size * PGSIZE);
ffffffffc0200808:	00eb1733          	sll	a4,s6,a4
ffffffffc020080c:	0009b603          	ld	a2,0(s3)
        if (buddy_pa < npage * PGSIZE) {
ffffffffc0200810:	6088                	ld	a0,0(s1)
ffffffffc0200812:	40cd87b3          	sub	a5,s11,a2
ffffffffc0200816:	878d                	srai	a5,a5,0x3
ffffffffc0200818:	032787b3          	mul	a5,a5,s2
ffffffffc020081c:	00c51813          	slli	a6,a0,0xc
ffffffffc0200820:	97a2                	add	a5,a5,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0200822:	07b2                	slli	a5,a5,0xc
        uintptr_t buddy_pa = pa ^ (block_size * PGSIZE);
ffffffffc0200824:	8fb9                	xor	a5,a5,a4
        if (buddy_pa < npage * PGSIZE) {
ffffffffc0200826:	0307f563          	bgeu	a5,a6,ffffffffc0200850 <buddy_free_pages+0xe0>
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc020082a:	83b1                	srli	a5,a5,0xc
ffffffffc020082c:	10a7f163          	bgeu	a5,a0,ffffffffc020092e <buddy_free_pages+0x1be>
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0200830:	8f81                	sub	a5,a5,s0
ffffffffc0200832:	00279713          	slli	a4,a5,0x2
ffffffffc0200836:	97ba                	add	a5,a5,a4
ffffffffc0200838:	078e                	slli	a5,a5,0x3
ffffffffc020083a:	97b2                	add	a5,a5,a2
        if (buddy && PageProperty(buddy) && buddy->property == block_size) {
ffffffffc020083c:	cb91                	beqz	a5,ffffffffc0200850 <buddy_free_pages+0xe0>
ffffffffc020083e:	6798                	ld	a4,8(a5)
ffffffffc0200840:	8b09                	andi	a4,a4,2
ffffffffc0200842:	c719                	beqz	a4,ffffffffc0200850 <buddy_free_pages+0xe0>
ffffffffc0200844:	4b98                	lw	a4,16(a5)
ffffffffc0200846:	02071613          	slli	a2,a4,0x20
ffffffffc020084a:	9201                	srli	a2,a2,0x20
ffffffffc020084c:	05860063          	beq	a2,s8,ffffffffc020088c <buddy_free_pages+0x11c>
            insert_free_block(head, order);
ffffffffc0200850:	856e                	mv	a0,s11
ffffffffc0200852:	85de                	mv	a1,s7
ffffffffc0200854:	da5ff0ef          	jal	ra,ffffffffc02005f8 <insert_free_block>
            cur += block_size;
ffffffffc0200858:	017a15b3          	sll	a1,s4,s7
            remaining -= block_size;
ffffffffc020085c:	418c8cb3          	sub	s9,s9,s8
            cur += block_size;
ffffffffc0200860:	9dae                	add	s11,s11,a1
    while (remaining > 0) {
ffffffffc0200862:	f60c9ee3          	bnez	s9,ffffffffc02007de <buddy_free_pages+0x6e>
}
ffffffffc0200866:	70a6                	ld	ra,104(sp)
ffffffffc0200868:	7406                	ld	s0,96(sp)
ffffffffc020086a:	64e6                	ld	s1,88(sp)
ffffffffc020086c:	6946                	ld	s2,80(sp)
ffffffffc020086e:	69a6                	ld	s3,72(sp)
ffffffffc0200870:	6a06                	ld	s4,64(sp)
ffffffffc0200872:	7ae2                	ld	s5,56(sp)
ffffffffc0200874:	7b42                	ld	s6,48(sp)
ffffffffc0200876:	7ba2                	ld	s7,40(sp)
ffffffffc0200878:	7c02                	ld	s8,32(sp)
ffffffffc020087a:	6ce2                	ld	s9,24(sp)
ffffffffc020087c:	6d42                	ld	s10,16(sp)
ffffffffc020087e:	6da2                	ld	s11,8(sp)
ffffffffc0200880:	6165                	addi	sp,sp,112
ffffffffc0200882:	8082                	ret
        while ((1UL << order) < sz) order++;
ffffffffc0200884:	6705                	lui	a4,0x1
ffffffffc0200886:	4c05                	li	s8,1
ffffffffc0200888:	4b81                	li	s7,0
ffffffffc020088a:	b749                	j	ffffffffc020080c <buddy_free_pages+0x9c>
            free_areas[order].nr_free -= buddy->property;
ffffffffc020088c:	001b9513          	slli	a0,s7,0x1
ffffffffc0200890:	017505b3          	add	a1,a0,s7
ffffffffc0200894:	00004697          	auipc	a3,0x4
ffffffffc0200898:	78468693          	addi	a3,a3,1924 # ffffffffc0205018 <free_areas>
ffffffffc020089c:	058e                	slli	a1,a1,0x3
    __list_del(listelm->prev, listelm->next);
ffffffffc020089e:	0187b303          	ld	t1,24(a5)
ffffffffc02008a2:	0207b883          	ld	a7,32(a5)
ffffffffc02008a6:	95b6                	add	a1,a1,a3
            buddy_nr_free -= buddy->property;
ffffffffc02008a8:	00005e17          	auipc	t3,0x5
ffffffffc02008ac:	920e0e13          	addi	t3,t3,-1760 # ffffffffc02051c8 <buddy_nr_free>
            free_areas[order].nr_free -= buddy->property;
ffffffffc02008b0:	0105a803          	lw	a6,16(a1)
            buddy_nr_free -= buddy->property;
ffffffffc02008b4:	000e3503          	ld	a0,0(t3)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc02008b8:	01133423          	sd	a7,8(t1)
    next->prev = prev;
ffffffffc02008bc:	0068b023          	sd	t1,0(a7)
            free_areas[order].nr_free -= buddy->property;
ffffffffc02008c0:	40e8083b          	subw	a6,a6,a4
            buddy_nr_free -= buddy->property;
ffffffffc02008c4:	418506b3          	sub	a3,a0,s8
            free_areas[order].nr_free -= buddy->property;
ffffffffc02008c8:	0105a823          	sw	a6,16(a1)
            buddy_nr_free -= buddy->property;
ffffffffc02008cc:	00de3023          	sd	a3,0(t3)
            if (buddy < head) head = buddy;
ffffffffc02008d0:	03b7e163          	bltu	a5,s11,ffffffffc02008f2 <buddy_free_pages+0x182>
            SetPageProperty(head);
ffffffffc02008d4:	008db783          	ld	a5,8(s11)
            head->property = block_size * 2;
ffffffffc02008d8:	0017171b          	slliw	a4,a4,0x1
ffffffffc02008dc:	00eda823          	sw	a4,16(s11)
            SetPageProperty(head);
ffffffffc02008e0:	0027e793          	ori	a5,a5,2
ffffffffc02008e4:	00fdb423          	sd	a5,8(s11)
            remaining -= block_size;
ffffffffc02008e8:	40cc8cb3          	sub	s9,s9,a2
    while (remaining > 0) {
ffffffffc02008ec:	ee0c99e3          	bnez	s9,ffffffffc02007de <buddy_free_pages+0x6e>
ffffffffc02008f0:	bf9d                	j	ffffffffc0200866 <buddy_free_pages+0xf6>
ffffffffc02008f2:	8dbe                	mv	s11,a5
            SetPageProperty(head);
ffffffffc02008f4:	008db783          	ld	a5,8(s11)
            head->property = block_size * 2;
ffffffffc02008f8:	0017171b          	slliw	a4,a4,0x1
ffffffffc02008fc:	00eda823          	sw	a4,16(s11)
            SetPageProperty(head);
ffffffffc0200900:	0027e793          	ori	a5,a5,2
ffffffffc0200904:	00fdb423          	sd	a5,8(s11)
            remaining -= block_size;
ffffffffc0200908:	40cc8cb3          	sub	s9,s9,a2
            continue;
ffffffffc020090c:	b7c5                	j	ffffffffc02008ec <buddy_free_pages+0x17c>
    assert(n > 0);
ffffffffc020090e:	00001697          	auipc	a3,0x1
ffffffffc0200912:	c3a68693          	addi	a3,a3,-966 # ffffffffc0201548 <etext+0x33e>
ffffffffc0200916:	00001617          	auipc	a2,0x1
ffffffffc020091a:	b7a60613          	addi	a2,a2,-1158 # ffffffffc0201490 <etext+0x286>
ffffffffc020091e:	08a00593          	li	a1,138
ffffffffc0200922:	00001517          	auipc	a0,0x1
ffffffffc0200926:	b8650513          	addi	a0,a0,-1146 # ffffffffc02014a8 <etext+0x29e>
ffffffffc020092a:	899ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc020092e:	00001617          	auipc	a2,0x1
ffffffffc0200932:	c2260613          	addi	a2,a2,-990 # ffffffffc0201550 <etext+0x346>
ffffffffc0200936:	06a00593          	li	a1,106
ffffffffc020093a:	00001517          	auipc	a0,0x1
ffffffffc020093e:	c3650513          	addi	a0,a0,-970 # ffffffffc0201570 <etext+0x366>
ffffffffc0200942:	881ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200946 <buddy_alloc_pages>:
static struct Page *buddy_alloc_pages(size_t n) {
ffffffffc0200946:	1141                	addi	sp,sp,-16
ffffffffc0200948:	e406                	sd	ra,8(sp)
ffffffffc020094a:	e022                	sd	s0,0(sp)
    assert(n > 0);
ffffffffc020094c:	14050263          	beqz	a0,ffffffffc0200a90 <buddy_alloc_pages+0x14a>
    if (n > buddy_nr_free) return NULL;
ffffffffc0200950:	00005297          	auipc	t0,0x5
ffffffffc0200954:	87828293          	addi	t0,t0,-1928 # ffffffffc02051c8 <buddy_nr_free>
ffffffffc0200958:	0002be03          	ld	t3,0(t0)
ffffffffc020095c:	12ae6563          	bltu	t3,a0,ffffffffc0200a86 <buddy_alloc_pages+0x140>
    while (size < n && order <= MAX_ORDER) {
ffffffffc0200960:	4785                	li	a5,1
    int order = 0;
ffffffffc0200962:	4601                	li	a2,0
    while (size < n && order <= MAX_ORDER) {
ffffffffc0200964:	00f50d63          	beq	a0,a5,ffffffffc020097e <buddy_alloc_pages+0x38>
ffffffffc0200968:	4745                	li	a4,17
ffffffffc020096a:	a019                	j	ffffffffc0200970 <buddy_alloc_pages+0x2a>
ffffffffc020096c:	10e60d63          	beq	a2,a4,ffffffffc0200a86 <buddy_alloc_pages+0x140>
        size <<= 1;
ffffffffc0200970:	0786                	slli	a5,a5,0x1
        order++;
ffffffffc0200972:	2605                	addiw	a2,a2,1
    while (size < n && order <= MAX_ORDER) {
ffffffffc0200974:	fea7ece3          	bltu	a5,a0,ffffffffc020096c <buddy_alloc_pages+0x26>
    for (int o = target_order; o <= MAX_ORDER; o++) {
ffffffffc0200978:	47c5                	li	a5,17
ffffffffc020097a:	10f60663          	beq	a2,a5,ffffffffc0200a86 <buddy_alloc_pages+0x140>
ffffffffc020097e:	00161713          	slli	a4,a2,0x1
ffffffffc0200982:	9732                	add	a4,a4,a2
ffffffffc0200984:	00004597          	auipc	a1,0x4
ffffffffc0200988:	69458593          	addi	a1,a1,1684 # ffffffffc0205018 <free_areas>
ffffffffc020098c:	070e                	slli	a4,a4,0x3
ffffffffc020098e:	972e                	add	a4,a4,a1
    int order = 0;
ffffffffc0200990:	87b2                	mv	a5,a2
    for (int o = target_order; o <= MAX_ORDER; o++) {
ffffffffc0200992:	4545                	li	a0,17
ffffffffc0200994:	a029                	j	ffffffffc020099e <buddy_alloc_pages+0x58>
ffffffffc0200996:	2785                	addiw	a5,a5,1
ffffffffc0200998:	0761                	addi	a4,a4,24
ffffffffc020099a:	0ea78663          	beq	a5,a0,ffffffffc0200a86 <buddy_alloc_pages+0x140>
    return list->next == list;
ffffffffc020099e:	6714                	ld	a3,8(a4)
        if (!list_empty(&free_areas[o].free_list)) {
ffffffffc02009a0:	fee68be3          	beq	a3,a4,ffffffffc0200996 <buddy_alloc_pages+0x50>
    free_areas[order].nr_free -= p->property;
ffffffffc02009a4:	00179813          	slli	a6,a5,0x1
ffffffffc02009a8:	983e                	add	a6,a6,a5
ffffffffc02009aa:	080e                	slli	a6,a6,0x3
ffffffffc02009ac:	01058333          	add	t1,a1,a6
ffffffffc02009b0:	ff86a503          	lw	a0,-8(a3)
ffffffffc02009b4:	01032883          	lw	a7,16(t1)
    __list_del(listelm->prev, listelm->next);
ffffffffc02009b8:	0006bf03          	ld	t5,0(a3)
ffffffffc02009bc:	0086be83          	ld	t4,8(a3)
    ClearPageProperty(p);
ffffffffc02009c0:	ff06b703          	ld	a4,-16(a3)
    free_areas[order].nr_free -= p->property;
ffffffffc02009c4:	40a888bb          	subw	a7,a7,a0
    prev->next = next;
ffffffffc02009c8:	01df3423          	sd	t4,8(t5)
    buddy_nr_free -= p->property;
ffffffffc02009cc:	1502                	slli	a0,a0,0x20
    next->prev = prev;
ffffffffc02009ce:	01eeb023          	sd	t5,0(t4)
ffffffffc02009d2:	9101                	srli	a0,a0,0x20
ffffffffc02009d4:	40ae0e33          	sub	t3,t3,a0
    free_areas[order].nr_free -= p->property;
ffffffffc02009d8:	01132823          	sw	a7,16(t1)
    ClearPageProperty(p);
ffffffffc02009dc:	9b75                	andi	a4,a4,-3
    buddy_nr_free -= p->property;
ffffffffc02009de:	01c2b023          	sd	t3,0(t0)
    ClearPageProperty(p);
ffffffffc02009e2:	fee6b823          	sd	a4,-16(a3)
            struct Page *p = le2page(le, page_link);
ffffffffc02009e6:	fe868513          	addi	a0,a3,-24
            for (int cur = o; cur > target_order; cur--) {
ffffffffc02009ea:	06f65763          	bge	a2,a5,ffffffffc0200a58 <buddy_alloc_pages+0x112>
ffffffffc02009ee:	1821                	addi	a6,a6,-24
ffffffffc02009f0:	95c2                	add	a1,a1,a6
                int half = 1UL << (cur - 1);
ffffffffc02009f2:	4405                	li	s0,1
                struct Page *buddy = p + half;
ffffffffc02009f4:	02800393          	li	t2,40
                int half = 1UL << (cur - 1);
ffffffffc02009f8:	37fd                	addiw	a5,a5,-1
                struct Page *buddy = p + half;
ffffffffc02009fa:	00f39733          	sll	a4,t2,a5
ffffffffc02009fe:	972a                	add	a4,a4,a0
                SetPageProperty(buddy);
ffffffffc0200a00:	00873803          	ld	a6,8(a4) # 1008 <kern_entry-0xffffffffc01feff8>
                int half = 1UL << (cur - 1);
ffffffffc0200a04:	00f41eb3          	sll	t4,s0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc0200a08:	0085bf03          	ld	t5,8(a1)
                buddy->property = half;
ffffffffc0200a0c:	000e889b          	sext.w	a7,t4
ffffffffc0200a10:	01172823          	sw	a7,16(a4)
                SetPageProperty(buddy);
ffffffffc0200a14:	00286813          	ori	a6,a6,2
                free_areas[cur - 1].nr_free += half;
ffffffffc0200a18:	0105a303          	lw	t1,16(a1)
                SetPageProperty(buddy);
ffffffffc0200a1c:	01073423          	sd	a6,8(a4)
                list_add(&free_areas[cur - 1].free_list, &buddy->page_link);
ffffffffc0200a20:	01870f93          	addi	t6,a4,24
                SetPageProperty(p);
ffffffffc0200a24:	ff06b803          	ld	a6,-16(a3)
    prev->next = next->prev = elm;
ffffffffc0200a28:	01ff3023          	sd	t6,0(t5)
ffffffffc0200a2c:	01f5b423          	sd	t6,8(a1)
    elm->prev = prev;
ffffffffc0200a30:	ef0c                	sd	a1,24(a4)
    elm->next = next;
ffffffffc0200a32:	03e73023          	sd	t5,32(a4)
                free_areas[cur - 1].nr_free += half;
ffffffffc0200a36:	0113073b          	addw	a4,t1,a7
ffffffffc0200a3a:	c998                	sw	a4,16(a1)
                SetPageProperty(p);
ffffffffc0200a3c:	00286713          	ori	a4,a6,2
                p->property = half;
ffffffffc0200a40:	ff16ac23          	sw	a7,-8(a3)
                SetPageProperty(p);
ffffffffc0200a44:	fee6b823          	sd	a4,-16(a3)
                buddy_nr_free += half;
ffffffffc0200a48:	9e76                	add	t3,t3,t4
            for (int cur = o; cur > target_order; cur--) {
ffffffffc0200a4a:	15a1                	addi	a1,a1,-24
ffffffffc0200a4c:	faf616e3          	bne	a2,a5,ffffffffc02009f8 <buddy_alloc_pages+0xb2>
ffffffffc0200a50:	01c2b023          	sd	t3,0(t0)
ffffffffc0200a54:	ffd87713          	andi	a4,a6,-3
            ClearPageProperty(p);
ffffffffc0200a58:	02800593          	li	a1,40
ffffffffc0200a5c:	00c59633          	sll	a2,a1,a2
ffffffffc0200a60:	87b6                	mv	a5,a3
ffffffffc0200a62:	fee6b823          	sd	a4,-16(a3)
            for (size_t i = 0; i < (1UL << target_order); i++) {
ffffffffc0200a66:	9636                	add	a2,a2,a3
ffffffffc0200a68:	a019                	j	ffffffffc0200a6e <buddy_alloc_pages+0x128>
                SetPageReserved(p + i);
ffffffffc0200a6a:	ff07b703          	ld	a4,-16(a5)
ffffffffc0200a6e:	00176713          	ori	a4,a4,1
ffffffffc0200a72:	fee7b823          	sd	a4,-16(a5)
            for (size_t i = 0; i < (1UL << target_order); i++) {
ffffffffc0200a76:	02878793          	addi	a5,a5,40
ffffffffc0200a7a:	fef618e3          	bne	a2,a5,ffffffffc0200a6a <buddy_alloc_pages+0x124>
}
ffffffffc0200a7e:	60a2                	ld	ra,8(sp)
ffffffffc0200a80:	6402                	ld	s0,0(sp)
ffffffffc0200a82:	0141                	addi	sp,sp,16
ffffffffc0200a84:	8082                	ret
ffffffffc0200a86:	60a2                	ld	ra,8(sp)
ffffffffc0200a88:	6402                	ld	s0,0(sp)
    if (n > buddy_nr_free) return NULL;
ffffffffc0200a8a:	4501                	li	a0,0
}
ffffffffc0200a8c:	0141                	addi	sp,sp,16
ffffffffc0200a8e:	8082                	ret
    assert(n > 0);
ffffffffc0200a90:	00001697          	auipc	a3,0x1
ffffffffc0200a94:	ab868693          	addi	a3,a3,-1352 # ffffffffc0201548 <etext+0x33e>
ffffffffc0200a98:	00001617          	auipc	a2,0x1
ffffffffc0200a9c:	9f860613          	addi	a2,a2,-1544 # ffffffffc0201490 <etext+0x286>
ffffffffc0200aa0:	06400593          	li	a1,100
ffffffffc0200aa4:	00001517          	auipc	a0,0x1
ffffffffc0200aa8:	a0450513          	addi	a0,a0,-1532 # ffffffffc02014a8 <etext+0x29e>
ffffffffc0200aac:	f16ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200ab0 <buddy_init_memmap>:
static void buddy_init_memmap(struct Page *base, size_t n) {
ffffffffc0200ab0:	7179                	addi	sp,sp,-48
ffffffffc0200ab2:	f406                	sd	ra,40(sp)
ffffffffc0200ab4:	f022                	sd	s0,32(sp)
ffffffffc0200ab6:	ec26                	sd	s1,24(sp)
ffffffffc0200ab8:	e84a                	sd	s2,16(sp)
ffffffffc0200aba:	e44e                	sd	s3,8(sp)
ffffffffc0200abc:	e052                	sd	s4,0(sp)
    assert(n > 0);
ffffffffc0200abe:	cdd1                	beqz	a1,ffffffffc0200b5a <buddy_init_memmap+0xaa>
    for (struct Page *p = base; p != base + n; p++) {
ffffffffc0200ac0:	00259693          	slli	a3,a1,0x2
ffffffffc0200ac4:	96ae                	add	a3,a3,a1
ffffffffc0200ac6:	068e                	slli	a3,a3,0x3
ffffffffc0200ac8:	96aa                	add	a3,a3,a0
ffffffffc0200aca:	842e                	mv	s0,a1
ffffffffc0200acc:	89aa                	mv	s3,a0
ffffffffc0200ace:	87aa                	mv	a5,a0
ffffffffc0200ad0:	00d50d63          	beq	a0,a3,ffffffffc0200aea <buddy_init_memmap+0x3a>
        assert(PageReserved(p));
ffffffffc0200ad4:	6798                	ld	a4,8(a5)
ffffffffc0200ad6:	8b05                	andi	a4,a4,1
ffffffffc0200ad8:	c32d                	beqz	a4,ffffffffc0200b3a <buddy_init_memmap+0x8a>
        p->flags = 0;
ffffffffc0200ada:	0007b423          	sd	zero,8(a5)
static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc0200ade:	0007a023          	sw	zero,0(a5)
    for (struct Page *p = base; p != base + n; p++) {
ffffffffc0200ae2:	02878793          	addi	a5,a5,40
ffffffffc0200ae6:	fed797e3          	bne	a5,a3,ffffffffc0200ad4 <buddy_init_memmap+0x24>
        while ((1UL << order) < sz) order++;
ffffffffc0200aea:	4485                	li	s1,1
        if (order > MAX_ORDER) {
ffffffffc0200aec:	4a41                	li	s4,16
        size_t sz = 1UL;
ffffffffc0200aee:	4705                	li	a4,1
        while ((sz << 1) <= remaining) {
ffffffffc0200af0:	87ba                	mv	a5,a4
ffffffffc0200af2:	0706                	slli	a4,a4,0x1
ffffffffc0200af4:	fee47ee3          	bgeu	s0,a4,ffffffffc0200af0 <buddy_init_memmap+0x40>
        int order = 0;
ffffffffc0200af8:	4581                	li	a1,0
        while ((1UL << order) < sz) order++;
ffffffffc0200afa:	02f4fb63          	bgeu	s1,a5,ffffffffc0200b30 <buddy_init_memmap+0x80>
ffffffffc0200afe:	2585                	addiw	a1,a1,1
ffffffffc0200b00:	00b49733          	sll	a4,s1,a1
ffffffffc0200b04:	fef76de3          	bltu	a4,a5,ffffffffc0200afe <buddy_init_memmap+0x4e>
        if (order > MAX_ORDER) {
ffffffffc0200b08:	02ba5463          	bge	s4,a1,ffffffffc0200b30 <buddy_init_memmap+0x80>
ffffffffc0200b0c:	00280937          	lui	s2,0x280
            order = MAX_ORDER;
ffffffffc0200b10:	45c1                	li	a1,16
            sz = 1UL << order;
ffffffffc0200b12:	67c1                	lui	a5,0x10
        insert_free_block(cur, order);
ffffffffc0200b14:	854e                	mv	a0,s3
        remaining -= sz;
ffffffffc0200b16:	8c1d                	sub	s0,s0,a5
        cur += sz;
ffffffffc0200b18:	99ca                	add	s3,s3,s2
        insert_free_block(cur, order);
ffffffffc0200b1a:	adfff0ef          	jal	ra,ffffffffc02005f8 <insert_free_block>
    while (remaining > 0) {
ffffffffc0200b1e:	f861                	bnez	s0,ffffffffc0200aee <buddy_init_memmap+0x3e>
}
ffffffffc0200b20:	70a2                	ld	ra,40(sp)
ffffffffc0200b22:	7402                	ld	s0,32(sp)
ffffffffc0200b24:	64e2                	ld	s1,24(sp)
ffffffffc0200b26:	6942                	ld	s2,16(sp)
ffffffffc0200b28:	69a2                	ld	s3,8(sp)
ffffffffc0200b2a:	6a02                	ld	s4,0(sp)
ffffffffc0200b2c:	6145                	addi	sp,sp,48
ffffffffc0200b2e:	8082                	ret
        cur += sz;
ffffffffc0200b30:	00279913          	slli	s2,a5,0x2
ffffffffc0200b34:	993e                	add	s2,s2,a5
ffffffffc0200b36:	090e                	slli	s2,s2,0x3
ffffffffc0200b38:	bff1                	j	ffffffffc0200b14 <buddy_init_memmap+0x64>
        assert(PageReserved(p));
ffffffffc0200b3a:	00001697          	auipc	a3,0x1
ffffffffc0200b3e:	a4668693          	addi	a3,a3,-1466 # ffffffffc0201580 <etext+0x376>
ffffffffc0200b42:	00001617          	auipc	a2,0x1
ffffffffc0200b46:	94e60613          	addi	a2,a2,-1714 # ffffffffc0201490 <etext+0x286>
ffffffffc0200b4a:	04700593          	li	a1,71
ffffffffc0200b4e:	00001517          	auipc	a0,0x1
ffffffffc0200b52:	95a50513          	addi	a0,a0,-1702 # ffffffffc02014a8 <etext+0x29e>
ffffffffc0200b56:	e6cff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200b5a:	00001697          	auipc	a3,0x1
ffffffffc0200b5e:	9ee68693          	addi	a3,a3,-1554 # ffffffffc0201548 <etext+0x33e>
ffffffffc0200b62:	00001617          	auipc	a2,0x1
ffffffffc0200b66:	92e60613          	addi	a2,a2,-1746 # ffffffffc0201490 <etext+0x286>
ffffffffc0200b6a:	04400593          	li	a1,68
ffffffffc0200b6e:	00001517          	auipc	a0,0x1
ffffffffc0200b72:	93a50513          	addi	a0,a0,-1734 # ffffffffc02014a8 <etext+0x29e>
ffffffffc0200b76:	e4cff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200b7a <alloc_pages>:
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
    return pmm_manager->alloc_pages(n);
ffffffffc0200b7a:	00004797          	auipc	a5,0x4
ffffffffc0200b7e:	6667b783          	ld	a5,1638(a5) # ffffffffc02051e0 <pmm_manager>
ffffffffc0200b82:	6f9c                	ld	a5,24(a5)
ffffffffc0200b84:	8782                	jr	a5

ffffffffc0200b86 <free_pages>:
}

// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    pmm_manager->free_pages(base, n);
ffffffffc0200b86:	00004797          	auipc	a5,0x4
ffffffffc0200b8a:	65a7b783          	ld	a5,1626(a5) # ffffffffc02051e0 <pmm_manager>
ffffffffc0200b8e:	739c                	ld	a5,32(a5)
ffffffffc0200b90:	8782                	jr	a5

ffffffffc0200b92 <nr_free_pages>:
}

// nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE)
// of current free memory
size_t nr_free_pages(void) {
    return pmm_manager->nr_free_pages();
ffffffffc0200b92:	00004797          	auipc	a5,0x4
ffffffffc0200b96:	64e7b783          	ld	a5,1614(a5) # ffffffffc02051e0 <pmm_manager>
ffffffffc0200b9a:	779c                	ld	a5,40(a5)
ffffffffc0200b9c:	8782                	jr	a5

ffffffffc0200b9e <pmm_init>:
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200b9e:	00001797          	auipc	a5,0x1
ffffffffc0200ba2:	a0a78793          	addi	a5,a5,-1526 # ffffffffc02015a8 <buddy_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200ba6:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0200ba8:	7179                	addi	sp,sp,-48
ffffffffc0200baa:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200bac:	00001517          	auipc	a0,0x1
ffffffffc0200bb0:	a3450513          	addi	a0,a0,-1484 # ffffffffc02015e0 <buddy_pmm_manager+0x38>
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200bb4:	00004417          	auipc	s0,0x4
ffffffffc0200bb8:	62c40413          	addi	s0,s0,1580 # ffffffffc02051e0 <pmm_manager>
void pmm_init(void) {
ffffffffc0200bbc:	f406                	sd	ra,40(sp)
ffffffffc0200bbe:	ec26                	sd	s1,24(sp)
ffffffffc0200bc0:	e44e                	sd	s3,8(sp)
ffffffffc0200bc2:	e84a                	sd	s2,16(sp)
ffffffffc0200bc4:	e052                	sd	s4,0(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200bc6:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200bc8:	d84ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    pmm_manager->init();
ffffffffc0200bcc:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200bce:	00004497          	auipc	s1,0x4
ffffffffc0200bd2:	62a48493          	addi	s1,s1,1578 # ffffffffc02051f8 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200bd6:	679c                	ld	a5,8(a5)
ffffffffc0200bd8:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200bda:	57f5                	li	a5,-3
ffffffffc0200bdc:	07fa                	slli	a5,a5,0x1e
ffffffffc0200bde:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0200be0:	9ddff0ef          	jal	ra,ffffffffc02005bc <get_memory_base>
ffffffffc0200be4:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0200be6:	9e1ff0ef          	jal	ra,ffffffffc02005c6 <get_memory_size>
    if (mem_size == 0) {
ffffffffc0200bea:	14050d63          	beqz	a0,ffffffffc0200d44 <pmm_init+0x1a6>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200bee:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0200bf0:	00001517          	auipc	a0,0x1
ffffffffc0200bf4:	a3850513          	addi	a0,a0,-1480 # ffffffffc0201628 <buddy_pmm_manager+0x80>
ffffffffc0200bf8:	d54ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200bfc:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0200c00:	864e                	mv	a2,s3
ffffffffc0200c02:	fffa0693          	addi	a3,s4,-1
ffffffffc0200c06:	85ca                	mv	a1,s2
ffffffffc0200c08:	00001517          	auipc	a0,0x1
ffffffffc0200c0c:	a3850513          	addi	a0,a0,-1480 # ffffffffc0201640 <buddy_pmm_manager+0x98>
ffffffffc0200c10:	d3cff0ef          	jal	ra,ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200c14:	c80007b7          	lui	a5,0xc8000
ffffffffc0200c18:	8652                	mv	a2,s4
ffffffffc0200c1a:	0d47e463          	bltu	a5,s4,ffffffffc0200ce2 <pmm_init+0x144>
ffffffffc0200c1e:	00005797          	auipc	a5,0x5
ffffffffc0200c22:	5e178793          	addi	a5,a5,1505 # ffffffffc02061ff <end+0xfff>
ffffffffc0200c26:	757d                	lui	a0,0xfffff
ffffffffc0200c28:	8d7d                	and	a0,a0,a5
ffffffffc0200c2a:	8231                	srli	a2,a2,0xc
ffffffffc0200c2c:	00004797          	auipc	a5,0x4
ffffffffc0200c30:	5ac7b223          	sd	a2,1444(a5) # ffffffffc02051d0 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200c34:	00004797          	auipc	a5,0x4
ffffffffc0200c38:	5aa7b223          	sd	a0,1444(a5) # ffffffffc02051d8 <pages>
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200c3c:	000807b7          	lui	a5,0x80
ffffffffc0200c40:	002005b7          	lui	a1,0x200
ffffffffc0200c44:	02f60563          	beq	a2,a5,ffffffffc0200c6e <pmm_init+0xd0>
ffffffffc0200c48:	00261593          	slli	a1,a2,0x2
ffffffffc0200c4c:	00c586b3          	add	a3,a1,a2
ffffffffc0200c50:	fec007b7          	lui	a5,0xfec00
ffffffffc0200c54:	97aa                	add	a5,a5,a0
ffffffffc0200c56:	068e                	slli	a3,a3,0x3
ffffffffc0200c58:	96be                	add	a3,a3,a5
ffffffffc0200c5a:	87aa                	mv	a5,a0
        SetPageReserved(pages + i);
ffffffffc0200c5c:	6798                	ld	a4,8(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200c5e:	02878793          	addi	a5,a5,40 # fffffffffec00028 <end+0x3e9fae28>
        SetPageReserved(pages + i);
ffffffffc0200c62:	00176713          	ori	a4,a4,1
ffffffffc0200c66:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200c6a:	fef699e3          	bne	a3,a5,ffffffffc0200c5c <pmm_init+0xbe>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200c6e:	95b2                	add	a1,a1,a2
ffffffffc0200c70:	fec006b7          	lui	a3,0xfec00
ffffffffc0200c74:	96aa                	add	a3,a3,a0
ffffffffc0200c76:	058e                	slli	a1,a1,0x3
ffffffffc0200c78:	96ae                	add	a3,a3,a1
ffffffffc0200c7a:	c02007b7          	lui	a5,0xc0200
ffffffffc0200c7e:	0af6e763          	bltu	a3,a5,ffffffffc0200d2c <pmm_init+0x18e>
ffffffffc0200c82:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0200c84:	77fd                	lui	a5,0xfffff
ffffffffc0200c86:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200c8a:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc0200c8c:	04b6ee63          	bltu	a3,a1,ffffffffc0200ce8 <pmm_init+0x14a>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0200c90:	601c                	ld	a5,0(s0)
ffffffffc0200c92:	7b9c                	ld	a5,48(a5)
ffffffffc0200c94:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0200c96:	00001517          	auipc	a0,0x1
ffffffffc0200c9a:	a0250513          	addi	a0,a0,-1534 # ffffffffc0201698 <buddy_pmm_manager+0xf0>
ffffffffc0200c9e:	caeff0ef          	jal	ra,ffffffffc020014c <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0200ca2:	00003597          	auipc	a1,0x3
ffffffffc0200ca6:	35e58593          	addi	a1,a1,862 # ffffffffc0204000 <boot_page_table_sv39>
ffffffffc0200caa:	00004797          	auipc	a5,0x4
ffffffffc0200cae:	54b7b323          	sd	a1,1350(a5) # ffffffffc02051f0 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200cb2:	c02007b7          	lui	a5,0xc0200
ffffffffc0200cb6:	0af5e363          	bltu	a1,a5,ffffffffc0200d5c <pmm_init+0x1be>
ffffffffc0200cba:	6090                	ld	a2,0(s1)
}
ffffffffc0200cbc:	7402                	ld	s0,32(sp)
ffffffffc0200cbe:	70a2                	ld	ra,40(sp)
ffffffffc0200cc0:	64e2                	ld	s1,24(sp)
ffffffffc0200cc2:	6942                	ld	s2,16(sp)
ffffffffc0200cc4:	69a2                	ld	s3,8(sp)
ffffffffc0200cc6:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0200cc8:	40c58633          	sub	a2,a1,a2
ffffffffc0200ccc:	00004797          	auipc	a5,0x4
ffffffffc0200cd0:	50c7be23          	sd	a2,1308(a5) # ffffffffc02051e8 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200cd4:	00001517          	auipc	a0,0x1
ffffffffc0200cd8:	9e450513          	addi	a0,a0,-1564 # ffffffffc02016b8 <buddy_pmm_manager+0x110>
}
ffffffffc0200cdc:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200cde:	c6eff06f          	j	ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200ce2:	c8000637          	lui	a2,0xc8000
ffffffffc0200ce6:	bf25                	j	ffffffffc0200c1e <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0200ce8:	6705                	lui	a4,0x1
ffffffffc0200cea:	177d                	addi	a4,a4,-1
ffffffffc0200cec:	96ba                	add	a3,a3,a4
ffffffffc0200cee:	8efd                	and	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0200cf0:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200cf4:	02c7f063          	bgeu	a5,a2,ffffffffc0200d14 <pmm_init+0x176>
    pmm_manager->init_memmap(base, n);
ffffffffc0200cf8:	6010                	ld	a2,0(s0)
    return &pages[PPN(pa) - nbase];
ffffffffc0200cfa:	fff80737          	lui	a4,0xfff80
ffffffffc0200cfe:	973e                	add	a4,a4,a5
ffffffffc0200d00:	00271793          	slli	a5,a4,0x2
ffffffffc0200d04:	97ba                	add	a5,a5,a4
ffffffffc0200d06:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200d08:	8d95                	sub	a1,a1,a3
ffffffffc0200d0a:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc0200d0c:	81b1                	srli	a1,a1,0xc
ffffffffc0200d0e:	953e                	add	a0,a0,a5
ffffffffc0200d10:	9702                	jalr	a4
}
ffffffffc0200d12:	bfbd                	j	ffffffffc0200c90 <pmm_init+0xf2>
        panic("pa2page called with invalid pa");
ffffffffc0200d14:	00001617          	auipc	a2,0x1
ffffffffc0200d18:	83c60613          	addi	a2,a2,-1988 # ffffffffc0201550 <etext+0x346>
ffffffffc0200d1c:	06a00593          	li	a1,106
ffffffffc0200d20:	00001517          	auipc	a0,0x1
ffffffffc0200d24:	85050513          	addi	a0,a0,-1968 # ffffffffc0201570 <etext+0x366>
ffffffffc0200d28:	c9aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200d2c:	00001617          	auipc	a2,0x1
ffffffffc0200d30:	94460613          	addi	a2,a2,-1724 # ffffffffc0201670 <buddy_pmm_manager+0xc8>
ffffffffc0200d34:	05f00593          	li	a1,95
ffffffffc0200d38:	00001517          	auipc	a0,0x1
ffffffffc0200d3c:	8e050513          	addi	a0,a0,-1824 # ffffffffc0201618 <buddy_pmm_manager+0x70>
ffffffffc0200d40:	c82ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        panic("DTB memory info not available");
ffffffffc0200d44:	00001617          	auipc	a2,0x1
ffffffffc0200d48:	8b460613          	addi	a2,a2,-1868 # ffffffffc02015f8 <buddy_pmm_manager+0x50>
ffffffffc0200d4c:	04700593          	li	a1,71
ffffffffc0200d50:	00001517          	auipc	a0,0x1
ffffffffc0200d54:	8c850513          	addi	a0,a0,-1848 # ffffffffc0201618 <buddy_pmm_manager+0x70>
ffffffffc0200d58:	c6aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200d5c:	86ae                	mv	a3,a1
ffffffffc0200d5e:	00001617          	auipc	a2,0x1
ffffffffc0200d62:	91260613          	addi	a2,a2,-1774 # ffffffffc0201670 <buddy_pmm_manager+0xc8>
ffffffffc0200d66:	07a00593          	li	a1,122
ffffffffc0200d6a:	00001517          	auipc	a0,0x1
ffffffffc0200d6e:	8ae50513          	addi	a0,a0,-1874 # ffffffffc0201618 <buddy_pmm_manager+0x70>
ffffffffc0200d72:	c50ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200d76 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0200d76:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200d7a:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0200d7c:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200d80:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0200d82:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200d86:	f022                	sd	s0,32(sp)
ffffffffc0200d88:	ec26                	sd	s1,24(sp)
ffffffffc0200d8a:	e84a                	sd	s2,16(sp)
ffffffffc0200d8c:	f406                	sd	ra,40(sp)
ffffffffc0200d8e:	e44e                	sd	s3,8(sp)
ffffffffc0200d90:	84aa                	mv	s1,a0
ffffffffc0200d92:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0200d94:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0200d98:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0200d9a:	03067e63          	bgeu	a2,a6,ffffffffc0200dd6 <printnum+0x60>
ffffffffc0200d9e:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0200da0:	00805763          	blez	s0,ffffffffc0200dae <printnum+0x38>
ffffffffc0200da4:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0200da6:	85ca                	mv	a1,s2
ffffffffc0200da8:	854e                	mv	a0,s3
ffffffffc0200daa:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0200dac:	fc65                	bnez	s0,ffffffffc0200da4 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200dae:	1a02                	slli	s4,s4,0x20
ffffffffc0200db0:	00001797          	auipc	a5,0x1
ffffffffc0200db4:	94878793          	addi	a5,a5,-1720 # ffffffffc02016f8 <buddy_pmm_manager+0x150>
ffffffffc0200db8:	020a5a13          	srli	s4,s4,0x20
ffffffffc0200dbc:	9a3e                	add	s4,s4,a5
}
ffffffffc0200dbe:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200dc0:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0200dc4:	70a2                	ld	ra,40(sp)
ffffffffc0200dc6:	69a2                	ld	s3,8(sp)
ffffffffc0200dc8:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200dca:	85ca                	mv	a1,s2
ffffffffc0200dcc:	87a6                	mv	a5,s1
}
ffffffffc0200dce:	6942                	ld	s2,16(sp)
ffffffffc0200dd0:	64e2                	ld	s1,24(sp)
ffffffffc0200dd2:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200dd4:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0200dd6:	03065633          	divu	a2,a2,a6
ffffffffc0200dda:	8722                	mv	a4,s0
ffffffffc0200ddc:	f9bff0ef          	jal	ra,ffffffffc0200d76 <printnum>
ffffffffc0200de0:	b7f9                	j	ffffffffc0200dae <printnum+0x38>

ffffffffc0200de2 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0200de2:	7119                	addi	sp,sp,-128
ffffffffc0200de4:	f4a6                	sd	s1,104(sp)
ffffffffc0200de6:	f0ca                	sd	s2,96(sp)
ffffffffc0200de8:	ecce                	sd	s3,88(sp)
ffffffffc0200dea:	e8d2                	sd	s4,80(sp)
ffffffffc0200dec:	e4d6                	sd	s5,72(sp)
ffffffffc0200dee:	e0da                	sd	s6,64(sp)
ffffffffc0200df0:	fc5e                	sd	s7,56(sp)
ffffffffc0200df2:	f06a                	sd	s10,32(sp)
ffffffffc0200df4:	fc86                	sd	ra,120(sp)
ffffffffc0200df6:	f8a2                	sd	s0,112(sp)
ffffffffc0200df8:	f862                	sd	s8,48(sp)
ffffffffc0200dfa:	f466                	sd	s9,40(sp)
ffffffffc0200dfc:	ec6e                	sd	s11,24(sp)
ffffffffc0200dfe:	892a                	mv	s2,a0
ffffffffc0200e00:	84ae                	mv	s1,a1
ffffffffc0200e02:	8d32                	mv	s10,a2
ffffffffc0200e04:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200e06:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0200e0a:	5b7d                	li	s6,-1
ffffffffc0200e0c:	00001a97          	auipc	s5,0x1
ffffffffc0200e10:	920a8a93          	addi	s5,s5,-1760 # ffffffffc020172c <buddy_pmm_manager+0x184>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0200e14:	00001b97          	auipc	s7,0x1
ffffffffc0200e18:	af4b8b93          	addi	s7,s7,-1292 # ffffffffc0201908 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200e1c:	000d4503          	lbu	a0,0(s10)
ffffffffc0200e20:	001d0413          	addi	s0,s10,1
ffffffffc0200e24:	01350a63          	beq	a0,s3,ffffffffc0200e38 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0200e28:	c121                	beqz	a0,ffffffffc0200e68 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0200e2a:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200e2c:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0200e2e:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200e30:	fff44503          	lbu	a0,-1(s0)
ffffffffc0200e34:	ff351ae3          	bne	a0,s3,ffffffffc0200e28 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e38:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0200e3c:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0200e40:	4c81                	li	s9,0
ffffffffc0200e42:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0200e44:	5c7d                	li	s8,-1
ffffffffc0200e46:	5dfd                	li	s11,-1
ffffffffc0200e48:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0200e4c:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e4e:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0200e52:	0ff5f593          	zext.b	a1,a1
ffffffffc0200e56:	00140d13          	addi	s10,s0,1
ffffffffc0200e5a:	04b56263          	bltu	a0,a1,ffffffffc0200e9e <vprintfmt+0xbc>
ffffffffc0200e5e:	058a                	slli	a1,a1,0x2
ffffffffc0200e60:	95d6                	add	a1,a1,s5
ffffffffc0200e62:	4194                	lw	a3,0(a1)
ffffffffc0200e64:	96d6                	add	a3,a3,s5
ffffffffc0200e66:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0200e68:	70e6                	ld	ra,120(sp)
ffffffffc0200e6a:	7446                	ld	s0,112(sp)
ffffffffc0200e6c:	74a6                	ld	s1,104(sp)
ffffffffc0200e6e:	7906                	ld	s2,96(sp)
ffffffffc0200e70:	69e6                	ld	s3,88(sp)
ffffffffc0200e72:	6a46                	ld	s4,80(sp)
ffffffffc0200e74:	6aa6                	ld	s5,72(sp)
ffffffffc0200e76:	6b06                	ld	s6,64(sp)
ffffffffc0200e78:	7be2                	ld	s7,56(sp)
ffffffffc0200e7a:	7c42                	ld	s8,48(sp)
ffffffffc0200e7c:	7ca2                	ld	s9,40(sp)
ffffffffc0200e7e:	7d02                	ld	s10,32(sp)
ffffffffc0200e80:	6de2                	ld	s11,24(sp)
ffffffffc0200e82:	6109                	addi	sp,sp,128
ffffffffc0200e84:	8082                	ret
            padc = '0';
ffffffffc0200e86:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0200e88:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e8c:	846a                	mv	s0,s10
ffffffffc0200e8e:	00140d13          	addi	s10,s0,1
ffffffffc0200e92:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0200e96:	0ff5f593          	zext.b	a1,a1
ffffffffc0200e9a:	fcb572e3          	bgeu	a0,a1,ffffffffc0200e5e <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0200e9e:	85a6                	mv	a1,s1
ffffffffc0200ea0:	02500513          	li	a0,37
ffffffffc0200ea4:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0200ea6:	fff44783          	lbu	a5,-1(s0)
ffffffffc0200eaa:	8d22                	mv	s10,s0
ffffffffc0200eac:	f73788e3          	beq	a5,s3,ffffffffc0200e1c <vprintfmt+0x3a>
ffffffffc0200eb0:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0200eb4:	1d7d                	addi	s10,s10,-1
ffffffffc0200eb6:	ff379de3          	bne	a5,s3,ffffffffc0200eb0 <vprintfmt+0xce>
ffffffffc0200eba:	b78d                	j	ffffffffc0200e1c <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0200ebc:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0200ec0:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200ec4:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0200ec6:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0200eca:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0200ece:	02d86463          	bltu	a6,a3,ffffffffc0200ef6 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0200ed2:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0200ed6:	002c169b          	slliw	a3,s8,0x2
ffffffffc0200eda:	0186873b          	addw	a4,a3,s8
ffffffffc0200ede:	0017171b          	slliw	a4,a4,0x1
ffffffffc0200ee2:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0200ee4:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0200ee8:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0200eea:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0200eee:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0200ef2:	fed870e3          	bgeu	a6,a3,ffffffffc0200ed2 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0200ef6:	f40ddce3          	bgez	s11,ffffffffc0200e4e <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0200efa:	8de2                	mv	s11,s8
ffffffffc0200efc:	5c7d                	li	s8,-1
ffffffffc0200efe:	bf81                	j	ffffffffc0200e4e <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0200f00:	fffdc693          	not	a3,s11
ffffffffc0200f04:	96fd                	srai	a3,a3,0x3f
ffffffffc0200f06:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f0a:	00144603          	lbu	a2,1(s0)
ffffffffc0200f0e:	2d81                	sext.w	s11,s11
ffffffffc0200f10:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0200f12:	bf35                	j	ffffffffc0200e4e <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0200f14:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f18:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0200f1c:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f1e:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0200f20:	bfd9                	j	ffffffffc0200ef6 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0200f22:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0200f24:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0200f28:	01174463          	blt	a4,a7,ffffffffc0200f30 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0200f2c:	1a088e63          	beqz	a7,ffffffffc02010e8 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0200f30:	000a3603          	ld	a2,0(s4)
ffffffffc0200f34:	46c1                	li	a3,16
ffffffffc0200f36:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0200f38:	2781                	sext.w	a5,a5
ffffffffc0200f3a:	876e                	mv	a4,s11
ffffffffc0200f3c:	85a6                	mv	a1,s1
ffffffffc0200f3e:	854a                	mv	a0,s2
ffffffffc0200f40:	e37ff0ef          	jal	ra,ffffffffc0200d76 <printnum>
            break;
ffffffffc0200f44:	bde1                	j	ffffffffc0200e1c <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0200f46:	000a2503          	lw	a0,0(s4)
ffffffffc0200f4a:	85a6                	mv	a1,s1
ffffffffc0200f4c:	0a21                	addi	s4,s4,8
ffffffffc0200f4e:	9902                	jalr	s2
            break;
ffffffffc0200f50:	b5f1                	j	ffffffffc0200e1c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0200f52:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0200f54:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0200f58:	01174463          	blt	a4,a7,ffffffffc0200f60 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0200f5c:	18088163          	beqz	a7,ffffffffc02010de <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0200f60:	000a3603          	ld	a2,0(s4)
ffffffffc0200f64:	46a9                	li	a3,10
ffffffffc0200f66:	8a2e                	mv	s4,a1
ffffffffc0200f68:	bfc1                	j	ffffffffc0200f38 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f6a:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0200f6e:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f70:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0200f72:	bdf1                	j	ffffffffc0200e4e <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0200f74:	85a6                	mv	a1,s1
ffffffffc0200f76:	02500513          	li	a0,37
ffffffffc0200f7a:	9902                	jalr	s2
            break;
ffffffffc0200f7c:	b545                	j	ffffffffc0200e1c <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f7e:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0200f82:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200f84:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0200f86:	b5e1                	j	ffffffffc0200e4e <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0200f88:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0200f8a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0200f8e:	01174463          	blt	a4,a7,ffffffffc0200f96 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0200f92:	14088163          	beqz	a7,ffffffffc02010d4 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0200f96:	000a3603          	ld	a2,0(s4)
ffffffffc0200f9a:	46a1                	li	a3,8
ffffffffc0200f9c:	8a2e                	mv	s4,a1
ffffffffc0200f9e:	bf69                	j	ffffffffc0200f38 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0200fa0:	03000513          	li	a0,48
ffffffffc0200fa4:	85a6                	mv	a1,s1
ffffffffc0200fa6:	e03e                	sd	a5,0(sp)
ffffffffc0200fa8:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0200faa:	85a6                	mv	a1,s1
ffffffffc0200fac:	07800513          	li	a0,120
ffffffffc0200fb0:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0200fb2:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0200fb4:	6782                	ld	a5,0(sp)
ffffffffc0200fb6:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0200fb8:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0200fbc:	bfb5                	j	ffffffffc0200f38 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0200fbe:	000a3403          	ld	s0,0(s4)
ffffffffc0200fc2:	008a0713          	addi	a4,s4,8
ffffffffc0200fc6:	e03a                	sd	a4,0(sp)
ffffffffc0200fc8:	14040263          	beqz	s0,ffffffffc020110c <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0200fcc:	0fb05763          	blez	s11,ffffffffc02010ba <vprintfmt+0x2d8>
ffffffffc0200fd0:	02d00693          	li	a3,45
ffffffffc0200fd4:	0cd79163          	bne	a5,a3,ffffffffc0201096 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0200fd8:	00044783          	lbu	a5,0(s0)
ffffffffc0200fdc:	0007851b          	sext.w	a0,a5
ffffffffc0200fe0:	cf85                	beqz	a5,ffffffffc0201018 <vprintfmt+0x236>
ffffffffc0200fe2:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0200fe6:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0200fea:	000c4563          	bltz	s8,ffffffffc0200ff4 <vprintfmt+0x212>
ffffffffc0200fee:	3c7d                	addiw	s8,s8,-1
ffffffffc0200ff0:	036c0263          	beq	s8,s6,ffffffffc0201014 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0200ff4:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0200ff6:	0e0c8e63          	beqz	s9,ffffffffc02010f2 <vprintfmt+0x310>
ffffffffc0200ffa:	3781                	addiw	a5,a5,-32
ffffffffc0200ffc:	0ef47b63          	bgeu	s0,a5,ffffffffc02010f2 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201000:	03f00513          	li	a0,63
ffffffffc0201004:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201006:	000a4783          	lbu	a5,0(s4)
ffffffffc020100a:	3dfd                	addiw	s11,s11,-1
ffffffffc020100c:	0a05                	addi	s4,s4,1
ffffffffc020100e:	0007851b          	sext.w	a0,a5
ffffffffc0201012:	ffe1                	bnez	a5,ffffffffc0200fea <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201014:	01b05963          	blez	s11,ffffffffc0201026 <vprintfmt+0x244>
ffffffffc0201018:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc020101a:	85a6                	mv	a1,s1
ffffffffc020101c:	02000513          	li	a0,32
ffffffffc0201020:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201022:	fe0d9be3          	bnez	s11,ffffffffc0201018 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201026:	6a02                	ld	s4,0(sp)
ffffffffc0201028:	bbd5                	j	ffffffffc0200e1c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020102a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020102c:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201030:	01174463          	blt	a4,a7,ffffffffc0201038 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0201034:	08088d63          	beqz	a7,ffffffffc02010ce <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201038:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc020103c:	0a044d63          	bltz	s0,ffffffffc02010f6 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201040:	8622                	mv	a2,s0
ffffffffc0201042:	8a66                	mv	s4,s9
ffffffffc0201044:	46a9                	li	a3,10
ffffffffc0201046:	bdcd                	j	ffffffffc0200f38 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201048:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020104c:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc020104e:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201050:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0201054:	8fb5                	xor	a5,a5,a3
ffffffffc0201056:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020105a:	02d74163          	blt	a4,a3,ffffffffc020107c <vprintfmt+0x29a>
ffffffffc020105e:	00369793          	slli	a5,a3,0x3
ffffffffc0201062:	97de                	add	a5,a5,s7
ffffffffc0201064:	639c                	ld	a5,0(a5)
ffffffffc0201066:	cb99                	beqz	a5,ffffffffc020107c <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201068:	86be                	mv	a3,a5
ffffffffc020106a:	00000617          	auipc	a2,0x0
ffffffffc020106e:	6be60613          	addi	a2,a2,1726 # ffffffffc0201728 <buddy_pmm_manager+0x180>
ffffffffc0201072:	85a6                	mv	a1,s1
ffffffffc0201074:	854a                	mv	a0,s2
ffffffffc0201076:	0ce000ef          	jal	ra,ffffffffc0201144 <printfmt>
ffffffffc020107a:	b34d                	j	ffffffffc0200e1c <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc020107c:	00000617          	auipc	a2,0x0
ffffffffc0201080:	69c60613          	addi	a2,a2,1692 # ffffffffc0201718 <buddy_pmm_manager+0x170>
ffffffffc0201084:	85a6                	mv	a1,s1
ffffffffc0201086:	854a                	mv	a0,s2
ffffffffc0201088:	0bc000ef          	jal	ra,ffffffffc0201144 <printfmt>
ffffffffc020108c:	bb41                	j	ffffffffc0200e1c <vprintfmt+0x3a>
                p = "(null)";
ffffffffc020108e:	00000417          	auipc	s0,0x0
ffffffffc0201092:	68240413          	addi	s0,s0,1666 # ffffffffc0201710 <buddy_pmm_manager+0x168>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201096:	85e2                	mv	a1,s8
ffffffffc0201098:	8522                	mv	a0,s0
ffffffffc020109a:	e43e                	sd	a5,8(sp)
ffffffffc020109c:	0fc000ef          	jal	ra,ffffffffc0201198 <strnlen>
ffffffffc02010a0:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02010a4:	01b05b63          	blez	s11,ffffffffc02010ba <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc02010a8:	67a2                	ld	a5,8(sp)
ffffffffc02010aa:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02010ae:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc02010b0:	85a6                	mv	a1,s1
ffffffffc02010b2:	8552                	mv	a0,s4
ffffffffc02010b4:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02010b6:	fe0d9ce3          	bnez	s11,ffffffffc02010ae <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02010ba:	00044783          	lbu	a5,0(s0)
ffffffffc02010be:	00140a13          	addi	s4,s0,1
ffffffffc02010c2:	0007851b          	sext.w	a0,a5
ffffffffc02010c6:	d3a5                	beqz	a5,ffffffffc0201026 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02010c8:	05e00413          	li	s0,94
ffffffffc02010cc:	bf39                	j	ffffffffc0200fea <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc02010ce:	000a2403          	lw	s0,0(s4)
ffffffffc02010d2:	b7ad                	j	ffffffffc020103c <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc02010d4:	000a6603          	lwu	a2,0(s4)
ffffffffc02010d8:	46a1                	li	a3,8
ffffffffc02010da:	8a2e                	mv	s4,a1
ffffffffc02010dc:	bdb1                	j	ffffffffc0200f38 <vprintfmt+0x156>
ffffffffc02010de:	000a6603          	lwu	a2,0(s4)
ffffffffc02010e2:	46a9                	li	a3,10
ffffffffc02010e4:	8a2e                	mv	s4,a1
ffffffffc02010e6:	bd89                	j	ffffffffc0200f38 <vprintfmt+0x156>
ffffffffc02010e8:	000a6603          	lwu	a2,0(s4)
ffffffffc02010ec:	46c1                	li	a3,16
ffffffffc02010ee:	8a2e                	mv	s4,a1
ffffffffc02010f0:	b5a1                	j	ffffffffc0200f38 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc02010f2:	9902                	jalr	s2
ffffffffc02010f4:	bf09                	j	ffffffffc0201006 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc02010f6:	85a6                	mv	a1,s1
ffffffffc02010f8:	02d00513          	li	a0,45
ffffffffc02010fc:	e03e                	sd	a5,0(sp)
ffffffffc02010fe:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201100:	6782                	ld	a5,0(sp)
ffffffffc0201102:	8a66                	mv	s4,s9
ffffffffc0201104:	40800633          	neg	a2,s0
ffffffffc0201108:	46a9                	li	a3,10
ffffffffc020110a:	b53d                	j	ffffffffc0200f38 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc020110c:	03b05163          	blez	s11,ffffffffc020112e <vprintfmt+0x34c>
ffffffffc0201110:	02d00693          	li	a3,45
ffffffffc0201114:	f6d79de3          	bne	a5,a3,ffffffffc020108e <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201118:	00000417          	auipc	s0,0x0
ffffffffc020111c:	5f840413          	addi	s0,s0,1528 # ffffffffc0201710 <buddy_pmm_manager+0x168>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201120:	02800793          	li	a5,40
ffffffffc0201124:	02800513          	li	a0,40
ffffffffc0201128:	00140a13          	addi	s4,s0,1
ffffffffc020112c:	bd6d                	j	ffffffffc0200fe6 <vprintfmt+0x204>
ffffffffc020112e:	00000a17          	auipc	s4,0x0
ffffffffc0201132:	5e3a0a13          	addi	s4,s4,1507 # ffffffffc0201711 <buddy_pmm_manager+0x169>
ffffffffc0201136:	02800513          	li	a0,40
ffffffffc020113a:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020113e:	05e00413          	li	s0,94
ffffffffc0201142:	b565                	j	ffffffffc0200fea <vprintfmt+0x208>

ffffffffc0201144 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201144:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201146:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020114a:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc020114c:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020114e:	ec06                	sd	ra,24(sp)
ffffffffc0201150:	f83a                	sd	a4,48(sp)
ffffffffc0201152:	fc3e                	sd	a5,56(sp)
ffffffffc0201154:	e0c2                	sd	a6,64(sp)
ffffffffc0201156:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201158:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc020115a:	c89ff0ef          	jal	ra,ffffffffc0200de2 <vprintfmt>
}
ffffffffc020115e:	60e2                	ld	ra,24(sp)
ffffffffc0201160:	6161                	addi	sp,sp,80
ffffffffc0201162:	8082                	ret

ffffffffc0201164 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201164:	4781                	li	a5,0
ffffffffc0201166:	00004717          	auipc	a4,0x4
ffffffffc020116a:	eaa73703          	ld	a4,-342(a4) # ffffffffc0205010 <SBI_CONSOLE_PUTCHAR>
ffffffffc020116e:	88ba                	mv	a7,a4
ffffffffc0201170:	852a                	mv	a0,a0
ffffffffc0201172:	85be                	mv	a1,a5
ffffffffc0201174:	863e                	mv	a2,a5
ffffffffc0201176:	00000073          	ecall
ffffffffc020117a:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc020117c:	8082                	ret

ffffffffc020117e <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc020117e:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201182:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201184:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201186:	cb81                	beqz	a5,ffffffffc0201196 <strlen+0x18>
        cnt ++;
ffffffffc0201188:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc020118a:	00a707b3          	add	a5,a4,a0
ffffffffc020118e:	0007c783          	lbu	a5,0(a5)
ffffffffc0201192:	fbfd                	bnez	a5,ffffffffc0201188 <strlen+0xa>
ffffffffc0201194:	8082                	ret
    }
    return cnt;
}
ffffffffc0201196:	8082                	ret

ffffffffc0201198 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201198:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020119a:	e589                	bnez	a1,ffffffffc02011a4 <strnlen+0xc>
ffffffffc020119c:	a811                	j	ffffffffc02011b0 <strnlen+0x18>
        cnt ++;
ffffffffc020119e:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc02011a0:	00f58863          	beq	a1,a5,ffffffffc02011b0 <strnlen+0x18>
ffffffffc02011a4:	00f50733          	add	a4,a0,a5
ffffffffc02011a8:	00074703          	lbu	a4,0(a4)
ffffffffc02011ac:	fb6d                	bnez	a4,ffffffffc020119e <strnlen+0x6>
ffffffffc02011ae:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc02011b0:	852e                	mv	a0,a1
ffffffffc02011b2:	8082                	ret

ffffffffc02011b4 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02011b4:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02011b8:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02011bc:	cb89                	beqz	a5,ffffffffc02011ce <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc02011be:	0505                	addi	a0,a0,1
ffffffffc02011c0:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02011c2:	fee789e3          	beq	a5,a4,ffffffffc02011b4 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02011c6:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc02011ca:	9d19                	subw	a0,a0,a4
ffffffffc02011cc:	8082                	ret
ffffffffc02011ce:	4501                	li	a0,0
ffffffffc02011d0:	bfed                	j	ffffffffc02011ca <strcmp+0x16>

ffffffffc02011d2 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02011d2:	c20d                	beqz	a2,ffffffffc02011f4 <strncmp+0x22>
ffffffffc02011d4:	962e                	add	a2,a2,a1
ffffffffc02011d6:	a031                	j	ffffffffc02011e2 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc02011d8:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02011da:	00e79a63          	bne	a5,a4,ffffffffc02011ee <strncmp+0x1c>
ffffffffc02011de:	00b60b63          	beq	a2,a1,ffffffffc02011f4 <strncmp+0x22>
ffffffffc02011e2:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc02011e6:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02011e8:	fff5c703          	lbu	a4,-1(a1)
ffffffffc02011ec:	f7f5                	bnez	a5,ffffffffc02011d8 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02011ee:	40e7853b          	subw	a0,a5,a4
}
ffffffffc02011f2:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02011f4:	4501                	li	a0,0
ffffffffc02011f6:	8082                	ret

ffffffffc02011f8 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc02011f8:	ca01                	beqz	a2,ffffffffc0201208 <memset+0x10>
ffffffffc02011fa:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc02011fc:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc02011fe:	0785                	addi	a5,a5,1
ffffffffc0201200:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201204:	fec79de3          	bne	a5,a2,ffffffffc02011fe <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201208:	8082                	ret
