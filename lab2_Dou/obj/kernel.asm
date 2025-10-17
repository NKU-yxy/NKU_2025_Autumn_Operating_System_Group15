
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
ffffffffc0200050:	0a450513          	addi	a0,a0,164 # ffffffffc02010f0 <etext+0x4>
void print_kerninfo(void) {
ffffffffc0200054:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200056:	0f6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", (uintptr_t)kern_init);
ffffffffc020005a:	00000597          	auipc	a1,0x0
ffffffffc020005e:	07e58593          	addi	a1,a1,126 # ffffffffc02000d8 <kern_init>
ffffffffc0200062:	00001517          	auipc	a0,0x1
ffffffffc0200066:	0ae50513          	addi	a0,a0,174 # ffffffffc0201110 <etext+0x24>
ffffffffc020006a:	0e2000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020006e:	00001597          	auipc	a1,0x1
ffffffffc0200072:	07e58593          	addi	a1,a1,126 # ffffffffc02010ec <etext>
ffffffffc0200076:	00001517          	auipc	a0,0x1
ffffffffc020007a:	0ba50513          	addi	a0,a0,186 # ffffffffc0201130 <etext+0x44>
ffffffffc020007e:	0ce000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200082:	00005597          	auipc	a1,0x5
ffffffffc0200086:	f9658593          	addi	a1,a1,-106 # ffffffffc0205018 <free_area>
ffffffffc020008a:	00001517          	auipc	a0,0x1
ffffffffc020008e:	0c650513          	addi	a0,a0,198 # ffffffffc0201150 <etext+0x64>
ffffffffc0200092:	0ba000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc0200096:	00005597          	auipc	a1,0x5
ffffffffc020009a:	09258593          	addi	a1,a1,146 # ffffffffc0205128 <end>
ffffffffc020009e:	00001517          	auipc	a0,0x1
ffffffffc02000a2:	0d250513          	addi	a0,a0,210 # ffffffffc0201170 <etext+0x84>
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
ffffffffc02000d0:	0c450513          	addi	a0,a0,196 # ffffffffc0201190 <etext+0xa4>
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
ffffffffc02000f0:	7eb000ef          	jal	ra,ffffffffc02010da <memset>
    dtb_init();
ffffffffc02000f4:	12c000ef          	jal	ra,ffffffffc0200220 <dtb_init>
    cons_init();  // init the console
ffffffffc02000f8:	11e000ef          	jal	ra,ffffffffc0200216 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc02000fc:	00001517          	auipc	a0,0x1
ffffffffc0200100:	0c450513          	addi	a0,a0,196 # ffffffffc02011c0 <etext+0xd4>
ffffffffc0200104:	07e000ef          	jal	ra,ffffffffc0200182 <cputs>

    print_kerninfo();
ffffffffc0200108:	f43ff0ef          	jal	ra,ffffffffc020004a <print_kerninfo>

    // grade_backtrace();
    pmm_init();  // init physical memory management
ffffffffc020010c:	175000ef          	jal	ra,ffffffffc0200a80 <pmm_init>

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
ffffffffc0200140:	385000ef          	jal	ra,ffffffffc0200cc4 <vprintfmt>
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
ffffffffc0200176:	34f000ef          	jal	ra,ffffffffc0200cc4 <vprintfmt>
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
ffffffffc02001f6:	fee50513          	addi	a0,a0,-18 # ffffffffc02011e0 <etext+0xf4>
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
ffffffffc020020c:	17050513          	addi	a0,a0,368 # ffffffffc0201378 <etext+0x28c>
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
ffffffffc020021c:	62b0006f          	j	ffffffffc0201046 <sbi_console_putchar>

ffffffffc0200220 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200220:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200222:	00001517          	auipc	a0,0x1
ffffffffc0200226:	fde50513          	addi	a0,a0,-34 # ffffffffc0201200 <etext+0x114>
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
ffffffffc0200254:	fc050513          	addi	a0,a0,-64 # ffffffffc0201210 <etext+0x124>
ffffffffc0200258:	ef5ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020025c:	00005417          	auipc	s0,0x5
ffffffffc0200260:	dac40413          	addi	s0,s0,-596 # ffffffffc0205008 <boot_dtb>
ffffffffc0200264:	600c                	ld	a1,0(s0)
ffffffffc0200266:	00001517          	auipc	a0,0x1
ffffffffc020026a:	fba50513          	addi	a0,a0,-70 # ffffffffc0201220 <etext+0x134>
ffffffffc020026e:	edfff0ef          	jal	ra,ffffffffc020014c <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200272:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200276:	00001517          	auipc	a0,0x1
ffffffffc020027a:	fc250513          	addi	a0,a0,-62 # ffffffffc0201238 <etext+0x14c>
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
ffffffffc0200334:	f5890913          	addi	s2,s2,-168 # ffffffffc0201288 <etext+0x19c>
ffffffffc0200338:	49bd                	li	s3,15
        switch (token) {
ffffffffc020033a:	4d91                	li	s11,4
ffffffffc020033c:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020033e:	00001497          	auipc	s1,0x1
ffffffffc0200342:	f4248493          	addi	s1,s1,-190 # ffffffffc0201280 <etext+0x194>
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
ffffffffc0200396:	f6e50513          	addi	a0,a0,-146 # ffffffffc0201300 <etext+0x214>
ffffffffc020039a:	db3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020039e:	00001517          	auipc	a0,0x1
ffffffffc02003a2:	f9a50513          	addi	a0,a0,-102 # ffffffffc0201338 <etext+0x24c>
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
ffffffffc02003e2:	e7a50513          	addi	a0,a0,-390 # ffffffffc0201258 <etext+0x16c>
}
ffffffffc02003e6:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003e8:	b395                	j	ffffffffc020014c <cprintf>
                int name_len = strlen(name);
ffffffffc02003ea:	8556                	mv	a0,s5
ffffffffc02003ec:	475000ef          	jal	ra,ffffffffc0201060 <strlen>
ffffffffc02003f0:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003f2:	4619                	li	a2,6
ffffffffc02003f4:	85a6                	mv	a1,s1
ffffffffc02003f6:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02003f8:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003fa:	4bb000ef          	jal	ra,ffffffffc02010b4 <strncmp>
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
ffffffffc0200490:	407000ef          	jal	ra,ffffffffc0201096 <strcmp>
ffffffffc0200494:	66a2                	ld	a3,8(sp)
ffffffffc0200496:	f94d                	bnez	a0,ffffffffc0200448 <dtb_init+0x228>
ffffffffc0200498:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200448 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020049c:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02004a0:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02004a4:	00001517          	auipc	a0,0x1
ffffffffc02004a8:	dec50513          	addi	a0,a0,-532 # ffffffffc0201290 <etext+0x1a4>
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
ffffffffc0200576:	d3e50513          	addi	a0,a0,-706 # ffffffffc02012b0 <etext+0x1c4>
ffffffffc020057a:	bd3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020057e:	014b5613          	srli	a2,s6,0x14
ffffffffc0200582:	85da                	mv	a1,s6
ffffffffc0200584:	00001517          	auipc	a0,0x1
ffffffffc0200588:	d4450513          	addi	a0,a0,-700 # ffffffffc02012c8 <etext+0x1dc>
ffffffffc020058c:	bc1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200590:	008b05b3          	add	a1,s6,s0
ffffffffc0200594:	15fd                	addi	a1,a1,-1
ffffffffc0200596:	00001517          	auipc	a0,0x1
ffffffffc020059a:	d5250513          	addi	a0,a0,-686 # ffffffffc02012e8 <etext+0x1fc>
ffffffffc020059e:	bafff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02005a2:	00001517          	auipc	a0,0x1
ffffffffc02005a6:	d9650513          	addi	a0,a0,-618 # ffffffffc0201338 <etext+0x24c>
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
static buddy_free_area_t free_area;

// 初始化伙伴系统
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

// 获取当前空闲页数
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

ffffffffc0200618 <buddy_check>:

// 检查函数（测试用例）
static void
buddy_check(void) {
ffffffffc0200618:	7179                	addi	sp,sp,-48
    cprintf("========== Buddy System Check ==========\n");
ffffffffc020061a:	00001517          	auipc	a0,0x1
ffffffffc020061e:	d3650513          	addi	a0,a0,-714 # ffffffffc0201350 <etext+0x264>
buddy_check(void) {
ffffffffc0200622:	f406                	sd	ra,40(sp)
ffffffffc0200624:	f022                	sd	s0,32(sp)
ffffffffc0200626:	e84a                	sd	s2,16(sp)
ffffffffc0200628:	e44e                	sd	s3,8(sp)
ffffffffc020062a:	ec26                	sd	s1,24(sp)
    cprintf("========== Buddy System Check ==========\n");
ffffffffc020062c:	b21ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    size_t total = nr_free_pages();
ffffffffc0200630:	444000ef          	jal	ra,ffffffffc0200a74 <nr_free_pages>
ffffffffc0200634:	89aa                	mv	s3,a0

    struct Page *p0 = alloc_pages(1);
ffffffffc0200636:	4505                	li	a0,1
ffffffffc0200638:	424000ef          	jal	ra,ffffffffc0200a5c <alloc_pages>
ffffffffc020063c:	842a                	mv	s0,a0
    struct Page *p1 = alloc_pages(2);
ffffffffc020063e:	4509                	li	a0,2
ffffffffc0200640:	41c000ef          	jal	ra,ffffffffc0200a5c <alloc_pages>
ffffffffc0200644:	892a                	mv	s2,a0
    struct Page *p2 = alloc_pages(8);
ffffffffc0200646:	4521                	li	a0,8
ffffffffc0200648:	414000ef          	jal	ra,ffffffffc0200a5c <alloc_pages>

    assert(p0 != NULL && p1 != NULL && p2 != NULL);
ffffffffc020064c:	cc3d                	beqz	s0,ffffffffc02006ca <buddy_check+0xb2>
ffffffffc020064e:	06090e63          	beqz	s2,ffffffffc02006ca <buddy_check+0xb2>
ffffffffc0200652:	84aa                	mv	s1,a0
ffffffffc0200654:	c93d                	beqz	a0,ffffffffc02006ca <buddy_check+0xb2>
    cprintf("Allocated: 1 + 2 + 8 pages OK\n");
ffffffffc0200656:	00001517          	auipc	a0,0x1
ffffffffc020065a:	d8250513          	addi	a0,a0,-638 # ffffffffc02013d8 <etext+0x2ec>
ffffffffc020065e:	aefff0ef          	jal	ra,ffffffffc020014c <cprintf>

    free_pages(p0, 1);
ffffffffc0200662:	4585                	li	a1,1
ffffffffc0200664:	8522                	mv	a0,s0
ffffffffc0200666:	402000ef          	jal	ra,ffffffffc0200a68 <free_pages>
    free_pages(p1, 2);
ffffffffc020066a:	4589                	li	a1,2
ffffffffc020066c:	854a                	mv	a0,s2
ffffffffc020066e:	3fa000ef          	jal	ra,ffffffffc0200a68 <free_pages>
    free_pages(p2, 8);
ffffffffc0200672:	45a1                	li	a1,8
ffffffffc0200674:	8526                	mv	a0,s1
ffffffffc0200676:	3f2000ef          	jal	ra,ffffffffc0200a68 <free_pages>
    cprintf("Freed all pages OK\n");
ffffffffc020067a:	00001517          	auipc	a0,0x1
ffffffffc020067e:	d7e50513          	addi	a0,a0,-642 # ffffffffc02013f8 <etext+0x30c>
ffffffffc0200682:	acbff0ef          	jal	ra,ffffffffc020014c <cprintf>

    assert(total == nr_free_pages());
ffffffffc0200686:	3ee000ef          	jal	ra,ffffffffc0200a74 <nr_free_pages>
ffffffffc020068a:	09351063          	bne	a0,s3,ffffffffc020070a <buddy_check+0xf2>
    cprintf("Free page count restored OK\n");
ffffffffc020068e:	00001517          	auipc	a0,0x1
ffffffffc0200692:	da250513          	addi	a0,a0,-606 # ffffffffc0201430 <etext+0x344>
ffffffffc0200696:	ab7ff0ef          	jal	ra,ffffffffc020014c <cprintf>

    struct Page *p3 = alloc_pages(4);
ffffffffc020069a:	4511                	li	a0,4
ffffffffc020069c:	3c0000ef          	jal	ra,ffffffffc0200a5c <alloc_pages>
    assert(p3 != NULL);
ffffffffc02006a0:	c529                	beqz	a0,ffffffffc02006ea <buddy_check+0xd2>
    free_pages(p3, 4);
ffffffffc02006a2:	4591                	li	a1,4
ffffffffc02006a4:	3c4000ef          	jal	ra,ffffffffc0200a68 <free_pages>

    cprintf("Buddy system check passed!\n");
ffffffffc02006a8:	00001517          	auipc	a0,0x1
ffffffffc02006ac:	db850513          	addi	a0,a0,-584 # ffffffffc0201460 <etext+0x374>
ffffffffc02006b0:	a9dff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("========================================\n");
}
ffffffffc02006b4:	7402                	ld	s0,32(sp)
ffffffffc02006b6:	70a2                	ld	ra,40(sp)
ffffffffc02006b8:	64e2                	ld	s1,24(sp)
ffffffffc02006ba:	6942                	ld	s2,16(sp)
ffffffffc02006bc:	69a2                	ld	s3,8(sp)
    cprintf("========================================\n");
ffffffffc02006be:	00001517          	auipc	a0,0x1
ffffffffc02006c2:	dc250513          	addi	a0,a0,-574 # ffffffffc0201480 <etext+0x394>
}
ffffffffc02006c6:	6145                	addi	sp,sp,48
    cprintf("========================================\n");
ffffffffc02006c8:	b451                	j	ffffffffc020014c <cprintf>
    assert(p0 != NULL && p1 != NULL && p2 != NULL);
ffffffffc02006ca:	00001697          	auipc	a3,0x1
ffffffffc02006ce:	cb668693          	addi	a3,a3,-842 # ffffffffc0201380 <etext+0x294>
ffffffffc02006d2:	00001617          	auipc	a2,0x1
ffffffffc02006d6:	cd660613          	addi	a2,a2,-810 # ffffffffc02013a8 <etext+0x2bc>
ffffffffc02006da:	07e00593          	li	a1,126
ffffffffc02006de:	00001517          	auipc	a0,0x1
ffffffffc02006e2:	ce250513          	addi	a0,a0,-798 # ffffffffc02013c0 <etext+0x2d4>
ffffffffc02006e6:	addff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p3 != NULL);
ffffffffc02006ea:	00001697          	auipc	a3,0x1
ffffffffc02006ee:	d6668693          	addi	a3,a3,-666 # ffffffffc0201450 <etext+0x364>
ffffffffc02006f2:	00001617          	auipc	a2,0x1
ffffffffc02006f6:	cb660613          	addi	a2,a2,-842 # ffffffffc02013a8 <etext+0x2bc>
ffffffffc02006fa:	08a00593          	li	a1,138
ffffffffc02006fe:	00001517          	auipc	a0,0x1
ffffffffc0200702:	cc250513          	addi	a0,a0,-830 # ffffffffc02013c0 <etext+0x2d4>
ffffffffc0200706:	abdff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(total == nr_free_pages());
ffffffffc020070a:	00001697          	auipc	a3,0x1
ffffffffc020070e:	d0668693          	addi	a3,a3,-762 # ffffffffc0201410 <etext+0x324>
ffffffffc0200712:	00001617          	auipc	a2,0x1
ffffffffc0200716:	c9660613          	addi	a2,a2,-874 # ffffffffc02013a8 <etext+0x2bc>
ffffffffc020071a:	08600593          	li	a1,134
ffffffffc020071e:	00001517          	auipc	a0,0x1
ffffffffc0200722:	ca250513          	addi	a0,a0,-862 # ffffffffc02013c0 <etext+0x2d4>
ffffffffc0200726:	a9dff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc020072a <buddy_alloc_pages>:
    if (n == 0) return NULL;
ffffffffc020072a:	c105                	beqz	a0,ffffffffc020074a <buddy_alloc_pages+0x20>
    while ((1U << order) < n && order < MAX_ORDER) order++;
ffffffffc020072c:	4785                	li	a5,1
    int order = 0;
ffffffffc020072e:	4601                	li	a2,0
    while ((1U << order) < n && order < MAX_ORDER) order++;
ffffffffc0200730:	02f50263          	beq	a0,a5,ffffffffc0200754 <buddy_alloc_pages+0x2a>
ffffffffc0200734:	4705                	li	a4,1
ffffffffc0200736:	46a9                	li	a3,10
ffffffffc0200738:	2605                	addiw	a2,a2,1
ffffffffc020073a:	00c717bb          	sllw	a5,a4,a2
ffffffffc020073e:	1782                	slli	a5,a5,0x20
ffffffffc0200740:	9381                	srli	a5,a5,0x20
ffffffffc0200742:	00a7f663          	bgeu	a5,a0,ffffffffc020074e <buddy_alloc_pages+0x24>
ffffffffc0200746:	fed619e3          	bne	a2,a3,ffffffffc0200738 <buddy_alloc_pages+0xe>
    if (n == 0) return NULL;
ffffffffc020074a:	4501                	li	a0,0
}
ffffffffc020074c:	8082                	ret
    if (order >= MAX_ORDER) return NULL;
ffffffffc020074e:	47a9                	li	a5,10
ffffffffc0200750:	fef60de3          	beq	a2,a5,ffffffffc020074a <buddy_alloc_pages+0x20>
ffffffffc0200754:	00005597          	auipc	a1,0x5
ffffffffc0200758:	8c458593          	addi	a1,a1,-1852 # ffffffffc0205018 <free_area>
ffffffffc020075c:	00461713          	slli	a4,a2,0x4
ffffffffc0200760:	972e                	add	a4,a4,a1
 * list_empty - tests whether a list is empty
 * @list:       the list to test.
 * */
static inline bool
list_empty(list_entry_t *list) {
    return list->next == list;
ffffffffc0200762:	00873303          	ld	t1,8(a4)
    int order = 0;
ffffffffc0200766:	87b2                	mv	a5,a2
    while (cur < MAX_ORDER && list_empty(&free_area.free_list[cur]))
ffffffffc0200768:	46a9                	li	a3,10
ffffffffc020076a:	00e31a63          	bne	t1,a4,ffffffffc020077e <buddy_alloc_pages+0x54>
        cur++;
ffffffffc020076e:	2785                	addiw	a5,a5,1
    while (cur < MAX_ORDER && list_empty(&free_area.free_list[cur]))
ffffffffc0200770:	0741                	addi	a4,a4,16
ffffffffc0200772:	fcd78ce3          	beq	a5,a3,ffffffffc020074a <buddy_alloc_pages+0x20>
ffffffffc0200776:	00873303          	ld	t1,8(a4)
ffffffffc020077a:	fee30ae3          	beq	t1,a4,ffffffffc020076e <buddy_alloc_pages+0x44>
    free_area.nr_free[cur]--;
ffffffffc020077e:	02878713          	addi	a4,a5,40
ffffffffc0200782:	070a                	slli	a4,a4,0x2
    __list_del(listelm->prev, listelm->next);
ffffffffc0200784:	00833503          	ld	a0,8(t1)
ffffffffc0200788:	00033803          	ld	a6,0(t1)
ffffffffc020078c:	972e                	add	a4,a4,a1
ffffffffc020078e:	4314                	lw	a3,0(a4)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0200790:	00a83423          	sd	a0,8(a6)
    next->prev = prev;
ffffffffc0200794:	01053023          	sd	a6,0(a0)
ffffffffc0200798:	36fd                	addiw	a3,a3,-1
ffffffffc020079a:	c314                	sw	a3,0(a4)
    struct Page *page = le2page(le, page_link);
ffffffffc020079c:	fe830513          	addi	a0,t1,-24
    while (cur > order) {
ffffffffc02007a0:	06f65563          	bge	a2,a5,ffffffffc020080a <buddy_alloc_pages+0xe0>
ffffffffc02007a4:	fff78693          	addi	a3,a5,-1
ffffffffc02007a8:	0277881b          	addiw	a6,a5,39
ffffffffc02007ac:	0692                	slli	a3,a3,0x4
ffffffffc02007ae:	080a                	slli	a6,a6,0x2
ffffffffc02007b0:	96ae                	add	a3,a3,a1
ffffffffc02007b2:	982e                	add	a6,a6,a1
        struct Page *buddy = page + (1U << cur);
ffffffffc02007b4:	4e85                	li	t4,1
        cur--;
ffffffffc02007b6:	fff7871b          	addiw	a4,a5,-1
        struct Page *buddy = page + (1U << cur);
ffffffffc02007ba:	00ee97bb          	sllw	a5,t4,a4
ffffffffc02007be:	02079593          	slli	a1,a5,0x20
ffffffffc02007c2:	9181                	srli	a1,a1,0x20
ffffffffc02007c4:	00259793          	slli	a5,a1,0x2
ffffffffc02007c8:	97ae                	add	a5,a5,a1
ffffffffc02007ca:	078e                	slli	a5,a5,0x3
ffffffffc02007cc:	97aa                	add	a5,a5,a0
        SetPageProperty(buddy);
ffffffffc02007ce:	0087b883          	ld	a7,8(a5)
    __list_add(elm, listelm, listelm->next);
ffffffffc02007d2:	0086be03          	ld	t3,8(a3)
        buddy->property = cur;
ffffffffc02007d6:	cb98                	sw	a4,16(a5)
        SetPageProperty(buddy);
ffffffffc02007d8:	0028e893          	ori	a7,a7,2
        free_area.nr_free[cur]++;
ffffffffc02007dc:	00082583          	lw	a1,0(a6)
        SetPageProperty(buddy);
ffffffffc02007e0:	0117b423          	sd	a7,8(a5)
        list_add(&free_area.free_list[cur], &(buddy->page_link));
ffffffffc02007e4:	01878893          	addi	a7,a5,24
    prev->next = next->prev = elm;
ffffffffc02007e8:	011e3023          	sd	a7,0(t3)
ffffffffc02007ec:	0116b423          	sd	a7,8(a3)
    elm->prev = prev;
ffffffffc02007f0:	ef94                	sd	a3,24(a5)
    elm->next = next;
ffffffffc02007f2:	03c7b023          	sd	t3,32(a5)
        free_area.nr_free[cur]++;
ffffffffc02007f6:	0015879b          	addiw	a5,a1,1
ffffffffc02007fa:	00f82023          	sw	a5,0(a6)
        cur--;
ffffffffc02007fe:	0007079b          	sext.w	a5,a4
    while (cur > order) {
ffffffffc0200802:	16c1                	addi	a3,a3,-16
ffffffffc0200804:	1871                	addi	a6,a6,-4
ffffffffc0200806:	faf618e3          	bne	a2,a5,ffffffffc02007b6 <buddy_alloc_pages+0x8c>
    ClearPageProperty(page);
ffffffffc020080a:	ff033783          	ld	a5,-16(t1)
ffffffffc020080e:	9bf5                	andi	a5,a5,-3
ffffffffc0200810:	fef33823          	sd	a5,-16(t1)
    return page;
ffffffffc0200814:	8082                	ret

ffffffffc0200816 <buddy_free_pages>:
buddy_free_pages(struct Page *base, size_t n) {
ffffffffc0200816:	1141                	addi	sp,sp,-16
ffffffffc0200818:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020081a:	12058763          	beqz	a1,ffffffffc0200948 <buddy_free_pages+0x132>
    while ((1U << order) < n) order++;
ffffffffc020081e:	4785                	li	a5,1
    int order = 0;
ffffffffc0200820:	4681                	li	a3,0
    while ((1U << order) < n) order++;
ffffffffc0200822:	4705                	li	a4,1
ffffffffc0200824:	00f58c63          	beq	a1,a5,ffffffffc020083c <buddy_free_pages+0x26>
ffffffffc0200828:	2685                	addiw	a3,a3,1
ffffffffc020082a:	00d717bb          	sllw	a5,a4,a3
ffffffffc020082e:	1782                	slli	a5,a5,0x20
ffffffffc0200830:	9381                	srli	a5,a5,0x20
ffffffffc0200832:	feb7ebe3          	bltu	a5,a1,ffffffffc0200828 <buddy_free_pages+0x12>
    while (order < MAX_ORDER - 1) {
ffffffffc0200836:	47a1                	li	a5,8
ffffffffc0200838:	0cd7cf63          	blt	a5,a3,ffffffffc0200916 <buddy_free_pages+0x100>
ffffffffc020083c:	0286861b          	addiw	a2,a3,40
ffffffffc0200840:	00004e17          	auipc	t3,0x4
ffffffffc0200844:	7d8e0e13          	addi	t3,t3,2008 # ffffffffc0205018 <free_area>
ffffffffc0200848:	060a                	slli	a2,a2,0x2
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc020084a:	00005817          	auipc	a6,0x5
ffffffffc020084e:	8b683803          	ld	a6,-1866(a6) # ffffffffc0205100 <pages>
ffffffffc0200852:	00001597          	auipc	a1,0x1
ffffffffc0200856:	05e5b583          	ld	a1,94(a1) # ffffffffc02018b0 <nbase>
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc020085a:	00005e97          	auipc	t4,0x5
ffffffffc020085e:	89eebe83          	ld	t4,-1890(t4) # ffffffffc02050f8 <npage>
ffffffffc0200862:	9672                	add	a2,a2,t3
ffffffffc0200864:	00001317          	auipc	t1,0x1
ffffffffc0200868:	04433303          	ld	t1,68(t1) # ffffffffc02018a8 <error_string+0x38>
        uintptr_t buddy_addr = addr ^ ((1U << (order + PGSHIFT)));
ffffffffc020086c:	4885                	li	a7,1
    while (order < MAX_ORDER - 1) {
ffffffffc020086e:	4f25                	li	t5,9
ffffffffc0200870:	a035                	j	ffffffffc020089c <buddy_free_pages+0x86>
        if (!PageProperty(buddy) || buddy->property != order)
ffffffffc0200872:	0107af83          	lw	t6,16(a5)
ffffffffc0200876:	065f9363          	bne	t6,t0,ffffffffc02008dc <buddy_free_pages+0xc6>
    __list_del(listelm->prev, listelm->next);
ffffffffc020087a:	0187b283          	ld	t0,24(a5)
ffffffffc020087e:	0207bf83          	ld	t6,32(a5)
        free_area.nr_free[order]--;
ffffffffc0200882:	377d                	addiw	a4,a4,-1
    prev->next = next;
ffffffffc0200884:	01f2b423          	sd	t6,8(t0)
    next->prev = prev;
ffffffffc0200888:	005fb023          	sd	t0,0(t6)
ffffffffc020088c:	c218                	sw	a4,0(a2)
        if (buddy < base)
ffffffffc020088e:	00a7f363          	bgeu	a5,a0,ffffffffc0200894 <buddy_free_pages+0x7e>
ffffffffc0200892:	853e                	mv	a0,a5
        order++;
ffffffffc0200894:	2685                	addiw	a3,a3,1
    while (order < MAX_ORDER - 1) {
ffffffffc0200896:	0611                	addi	a2,a2,4
ffffffffc0200898:	07e68b63          	beq	a3,t5,ffffffffc020090e <buddy_free_pages+0xf8>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc020089c:	410507b3          	sub	a5,a0,a6
ffffffffc02008a0:	878d                	srai	a5,a5,0x3
ffffffffc02008a2:	026787b3          	mul	a5,a5,t1
        uintptr_t buddy_addr = addr ^ ((1U << (order + PGSHIFT)));
ffffffffc02008a6:	00c6871b          	addiw	a4,a3,12
ffffffffc02008aa:	00e8973b          	sllw	a4,a7,a4
ffffffffc02008ae:	1702                	slli	a4,a4,0x20
ffffffffc02008b0:	9301                	srli	a4,a4,0x20
ffffffffc02008b2:	0006829b          	sext.w	t0,a3
ffffffffc02008b6:	97ae                	add	a5,a5,a1
    return page2ppn(page) << PGSHIFT;
ffffffffc02008b8:	07b2                	slli	a5,a5,0xc
ffffffffc02008ba:	8fb9                	xor	a5,a5,a4
    if (PPN(pa) >= npage) {
ffffffffc02008bc:	83b1                	srli	a5,a5,0xc
ffffffffc02008be:	07d7f963          	bgeu	a5,t4,ffffffffc0200930 <buddy_free_pages+0x11a>
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc02008c2:	8f8d                	sub	a5,a5,a1
ffffffffc02008c4:	00279713          	slli	a4,a5,0x2
ffffffffc02008c8:	97ba                	add	a5,a5,a4
ffffffffc02008ca:	078e                	slli	a5,a5,0x3
ffffffffc02008cc:	97c2                	add	a5,a5,a6
        if (!PageProperty(buddy) || buddy->property != order)
ffffffffc02008ce:	0087bf83          	ld	t6,8(a5)
        free_area.nr_free[order]--;
ffffffffc02008d2:	4218                	lw	a4,0(a2)
        if (!PageProperty(buddy) || buddy->property != order)
ffffffffc02008d4:	002fff93          	andi	t6,t6,2
ffffffffc02008d8:	f80f9de3          	bnez	t6,ffffffffc0200872 <buddy_free_pages+0x5c>
ffffffffc02008dc:	02868793          	addi	a5,a3,40
    SetPageProperty(base);
ffffffffc02008e0:	6510                	ld	a2,8(a0)
    __list_add(elm, listelm, listelm->next);
ffffffffc02008e2:	0692                	slli	a3,a3,0x4
ffffffffc02008e4:	96f2                	add	a3,a3,t3
ffffffffc02008e6:	668c                	ld	a1,8(a3)
ffffffffc02008e8:	00266613          	ori	a2,a2,2
ffffffffc02008ec:	e510                	sd	a2,8(a0)
    base->property = order;
ffffffffc02008ee:	00552823          	sw	t0,16(a0)
    list_add(&free_area.free_list[order], &(base->page_link));
ffffffffc02008f2:	01850613          	addi	a2,a0,24
    prev->next = next->prev = elm;
ffffffffc02008f6:	e190                	sd	a2,0(a1)
ffffffffc02008f8:	e690                	sd	a2,8(a3)
}
ffffffffc02008fa:	60a2                	ld	ra,8(sp)
    free_area.nr_free[order]++;
ffffffffc02008fc:	078a                	slli	a5,a5,0x2
    elm->next = next;
ffffffffc02008fe:	f10c                	sd	a1,32(a0)
    elm->prev = prev;
ffffffffc0200900:	ed14                	sd	a3,24(a0)
ffffffffc0200902:	9e3e                	add	t3,t3,a5
ffffffffc0200904:	2705                	addiw	a4,a4,1
ffffffffc0200906:	00ee2023          	sw	a4,0(t3)
}
ffffffffc020090a:	0141                	addi	sp,sp,16
ffffffffc020090c:	8082                	ret
    free_area.nr_free[order]++;
ffffffffc020090e:	0c4e2703          	lw	a4,196(t3)
ffffffffc0200912:	42a5                	li	t0,9
ffffffffc0200914:	b7e1                	j	ffffffffc02008dc <buddy_free_pages+0xc6>
ffffffffc0200916:	02868793          	addi	a5,a3,40
ffffffffc020091a:	00004e17          	auipc	t3,0x4
ffffffffc020091e:	6fee0e13          	addi	t3,t3,1790 # ffffffffc0205018 <free_area>
ffffffffc0200922:	00279713          	slli	a4,a5,0x2
ffffffffc0200926:	9772                	add	a4,a4,t3
ffffffffc0200928:	4318                	lw	a4,0(a4)
    base->property = order;
ffffffffc020092a:	0006829b          	sext.w	t0,a3
ffffffffc020092e:	bf4d                	j	ffffffffc02008e0 <buddy_free_pages+0xca>
        panic("pa2page called with invalid pa");
ffffffffc0200930:	00001617          	auipc	a2,0x1
ffffffffc0200934:	b8860613          	addi	a2,a2,-1144 # ffffffffc02014b8 <etext+0x3cc>
ffffffffc0200938:	06a00593          	li	a1,106
ffffffffc020093c:	00001517          	auipc	a0,0x1
ffffffffc0200940:	b9c50513          	addi	a0,a0,-1124 # ffffffffc02014d8 <etext+0x3ec>
ffffffffc0200944:	87fff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200948:	00001697          	auipc	a3,0x1
ffffffffc020094c:	b6868693          	addi	a3,a3,-1176 # ffffffffc02014b0 <etext+0x3c4>
ffffffffc0200950:	00001617          	auipc	a2,0x1
ffffffffc0200954:	a5860613          	addi	a2,a2,-1448 # ffffffffc02013a8 <etext+0x2bc>
ffffffffc0200958:	05100593          	li	a1,81
ffffffffc020095c:	00001517          	auipc	a0,0x1
ffffffffc0200960:	a6450513          	addi	a0,a0,-1436 # ffffffffc02013c0 <etext+0x2d4>
ffffffffc0200964:	85fff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200968 <buddy_init_memmap>:
buddy_init_memmap(struct Page *base, size_t n) {
ffffffffc0200968:	1141                	addi	sp,sp,-16
ffffffffc020096a:	e406                	sd	ra,8(sp)
ffffffffc020096c:	00850793          	addi	a5,a0,8
ffffffffc0200970:	4681                	li	a3,0
    assert(n > 0);
ffffffffc0200972:	c5f1                	beqz	a1,ffffffffc0200a3e <buddy_init_memmap+0xd6>
        assert(PageReserved(p));
ffffffffc0200974:	6398                	ld	a4,0(a5)
ffffffffc0200976:	8b05                	andi	a4,a4,1
ffffffffc0200978:	c745                	beqz	a4,ffffffffc0200a20 <buddy_init_memmap+0xb8>
        p->flags = 0;
ffffffffc020097a:	0007b023          	sd	zero,0(a5)
static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc020097e:	fe07ac23          	sw	zero,-8(a5)
    for (size_t i = 0; i < n; i++) {
ffffffffc0200982:	0685                	addi	a3,a3,1
ffffffffc0200984:	02878793          	addi	a5,a5,40
ffffffffc0200988:	fed596e3          	bne	a1,a3,ffffffffc0200974 <buddy_init_memmap+0xc>
    size_t offset = 0;
ffffffffc020098c:	4881                	li	a7,0
ffffffffc020098e:	00004e97          	auipc	t4,0x4
ffffffffc0200992:	68ae8e93          	addi	t4,t4,1674 # ffffffffc0205018 <free_area>
        while ((1U << order) > n)
ffffffffc0200996:	1ff00293          	li	t0,511
ffffffffc020099a:	4585                	li	a1,1
        int order = MAX_ORDER - 1;
ffffffffc020099c:	47a5                	li	a5,9
        while ((1U << order) > n)
ffffffffc020099e:	06d2e963          	bltu	t0,a3,ffffffffc0200a10 <buddy_init_memmap+0xa8>
            order--;
ffffffffc02009a2:	37fd                	addiw	a5,a5,-1
        while ((1U << order) > n)
ffffffffc02009a4:	00f5973b          	sllw	a4,a1,a5
ffffffffc02009a8:	1702                	slli	a4,a4,0x20
ffffffffc02009aa:	9301                	srli	a4,a4,0x20
ffffffffc02009ac:	fee6ebe3          	bltu	a3,a4,ffffffffc02009a2 <buddy_init_memmap+0x3a>
ffffffffc02009b0:	00479813          	slli	a6,a5,0x4
        page->property = order;
ffffffffc02009b4:	00078f9b          	sext.w	t6,a5
ffffffffc02009b8:	8e42                	mv	t3,a6
        struct Page *page = base + offset;
ffffffffc02009ba:	00289613          	slli	a2,a7,0x2
ffffffffc02009be:	9646                	add	a2,a2,a7
ffffffffc02009c0:	060e                	slli	a2,a2,0x3
ffffffffc02009c2:	962a                	add	a2,a2,a0
        SetPageProperty(page);
ffffffffc02009c4:	00863303          	ld	t1,8(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc02009c8:	9876                	add	a6,a6,t4
        free_area.nr_free[order]++;
ffffffffc02009ca:	02878793          	addi	a5,a5,40
ffffffffc02009ce:	00883f03          	ld	t5,8(a6)
ffffffffc02009d2:	078a                	slli	a5,a5,0x2
ffffffffc02009d4:	97f6                	add	a5,a5,t4
        SetPageProperty(page);
ffffffffc02009d6:	00236313          	ori	t1,t1,2
        page->property = order;
ffffffffc02009da:	01f62823          	sw	t6,16(a2)
        SetPageProperty(page);
ffffffffc02009de:	00663423          	sd	t1,8(a2)
        list_add(&free_area.free_list[order], &(page->page_link));
ffffffffc02009e2:	01860f93          	addi	t6,a2,24
        free_area.nr_free[order]++;
ffffffffc02009e6:	0007a303          	lw	t1,0(a5)
    prev->next = next->prev = elm;
ffffffffc02009ea:	01ff3023          	sd	t6,0(t5)
ffffffffc02009ee:	01f83423          	sd	t6,8(a6)
        list_add(&free_area.free_list[order], &(page->page_link));
ffffffffc02009f2:	01ce8833          	add	a6,t4,t3
    elm->next = next;
ffffffffc02009f6:	03e63023          	sd	t5,32(a2)
    elm->prev = prev;
ffffffffc02009fa:	01063c23          	sd	a6,24(a2)
        free_area.nr_free[order]++;
ffffffffc02009fe:	0013061b          	addiw	a2,t1,1
ffffffffc0200a02:	c390                	sw	a2,0(a5)
        n -= (1U << order);
ffffffffc0200a04:	8e99                	sub	a3,a3,a4
        offset += (1U << order);
ffffffffc0200a06:	98ba                	add	a7,a7,a4
    while (n > 0) {
ffffffffc0200a08:	fad1                	bnez	a3,ffffffffc020099c <buddy_init_memmap+0x34>
}
ffffffffc0200a0a:	60a2                	ld	ra,8(sp)
ffffffffc0200a0c:	0141                	addi	sp,sp,16
ffffffffc0200a0e:	8082                	ret
        while ((1U << order) > n)
ffffffffc0200a10:	09000e13          	li	t3,144
ffffffffc0200a14:	4fa5                	li	t6,9
ffffffffc0200a16:	20000713          	li	a4,512
ffffffffc0200a1a:	09000813          	li	a6,144
ffffffffc0200a1e:	bf71                	j	ffffffffc02009ba <buddy_init_memmap+0x52>
        assert(PageReserved(p));
ffffffffc0200a20:	00001697          	auipc	a3,0x1
ffffffffc0200a24:	ac868693          	addi	a3,a3,-1336 # ffffffffc02014e8 <etext+0x3fc>
ffffffffc0200a28:	00001617          	auipc	a2,0x1
ffffffffc0200a2c:	98060613          	addi	a2,a2,-1664 # ffffffffc02013a8 <etext+0x2bc>
ffffffffc0200a30:	45e5                	li	a1,25
ffffffffc0200a32:	00001517          	auipc	a0,0x1
ffffffffc0200a36:	98e50513          	addi	a0,a0,-1650 # ffffffffc02013c0 <etext+0x2d4>
ffffffffc0200a3a:	f88ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200a3e:	00001697          	auipc	a3,0x1
ffffffffc0200a42:	a7268693          	addi	a3,a3,-1422 # ffffffffc02014b0 <etext+0x3c4>
ffffffffc0200a46:	00001617          	auipc	a2,0x1
ffffffffc0200a4a:	96260613          	addi	a2,a2,-1694 # ffffffffc02013a8 <etext+0x2bc>
ffffffffc0200a4e:	45d9                	li	a1,22
ffffffffc0200a50:	00001517          	auipc	a0,0x1
ffffffffc0200a54:	97050513          	addi	a0,a0,-1680 # ffffffffc02013c0 <etext+0x2d4>
ffffffffc0200a58:	f6aff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200a5c <alloc_pages>:
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
    return pmm_manager->alloc_pages(n);
ffffffffc0200a5c:	00004797          	auipc	a5,0x4
ffffffffc0200a60:	6ac7b783          	ld	a5,1708(a5) # ffffffffc0205108 <pmm_manager>
ffffffffc0200a64:	6f9c                	ld	a5,24(a5)
ffffffffc0200a66:	8782                	jr	a5

ffffffffc0200a68 <free_pages>:
}

// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    pmm_manager->free_pages(base, n);
ffffffffc0200a68:	00004797          	auipc	a5,0x4
ffffffffc0200a6c:	6a07b783          	ld	a5,1696(a5) # ffffffffc0205108 <pmm_manager>
ffffffffc0200a70:	739c                	ld	a5,32(a5)
ffffffffc0200a72:	8782                	jr	a5

ffffffffc0200a74 <nr_free_pages>:
}

// nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE)
// of current free memory
size_t nr_free_pages(void) {
    return pmm_manager->nr_free_pages();
ffffffffc0200a74:	00004797          	auipc	a5,0x4
ffffffffc0200a78:	6947b783          	ld	a5,1684(a5) # ffffffffc0205108 <pmm_manager>
ffffffffc0200a7c:	779c                	ld	a5,40(a5)
ffffffffc0200a7e:	8782                	jr	a5

ffffffffc0200a80 <pmm_init>:
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200a80:	00001797          	auipc	a5,0x1
ffffffffc0200a84:	a9078793          	addi	a5,a5,-1392 # ffffffffc0201510 <buddy_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200a88:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0200a8a:	7179                	addi	sp,sp,-48
ffffffffc0200a8c:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200a8e:	00001517          	auipc	a0,0x1
ffffffffc0200a92:	aba50513          	addi	a0,a0,-1350 # ffffffffc0201548 <buddy_pmm_manager+0x38>
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200a96:	00004417          	auipc	s0,0x4
ffffffffc0200a9a:	67240413          	addi	s0,s0,1650 # ffffffffc0205108 <pmm_manager>
void pmm_init(void) {
ffffffffc0200a9e:	f406                	sd	ra,40(sp)
ffffffffc0200aa0:	ec26                	sd	s1,24(sp)
ffffffffc0200aa2:	e44e                	sd	s3,8(sp)
ffffffffc0200aa4:	e84a                	sd	s2,16(sp)
ffffffffc0200aa6:	e052                	sd	s4,0(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc0200aa8:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200aaa:	ea2ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    pmm_manager->init();
ffffffffc0200aae:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200ab0:	00004497          	auipc	s1,0x4
ffffffffc0200ab4:	67048493          	addi	s1,s1,1648 # ffffffffc0205120 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200ab8:	679c                	ld	a5,8(a5)
ffffffffc0200aba:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0200abc:	57f5                	li	a5,-3
ffffffffc0200abe:	07fa                	slli	a5,a5,0x1e
ffffffffc0200ac0:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0200ac2:	afbff0ef          	jal	ra,ffffffffc02005bc <get_memory_base>
ffffffffc0200ac6:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0200ac8:	affff0ef          	jal	ra,ffffffffc02005c6 <get_memory_size>
    if (mem_size == 0) {
ffffffffc0200acc:	14050d63          	beqz	a0,ffffffffc0200c26 <pmm_init+0x1a6>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200ad0:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0200ad2:	00001517          	auipc	a0,0x1
ffffffffc0200ad6:	abe50513          	addi	a0,a0,-1346 # ffffffffc0201590 <buddy_pmm_manager+0x80>
ffffffffc0200ada:	e72ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc0200ade:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0200ae2:	864e                	mv	a2,s3
ffffffffc0200ae4:	fffa0693          	addi	a3,s4,-1
ffffffffc0200ae8:	85ca                	mv	a1,s2
ffffffffc0200aea:	00001517          	auipc	a0,0x1
ffffffffc0200aee:	abe50513          	addi	a0,a0,-1346 # ffffffffc02015a8 <buddy_pmm_manager+0x98>
ffffffffc0200af2:	e5aff0ef          	jal	ra,ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200af6:	c80007b7          	lui	a5,0xc8000
ffffffffc0200afa:	8652                	mv	a2,s4
ffffffffc0200afc:	0d47e463          	bltu	a5,s4,ffffffffc0200bc4 <pmm_init+0x144>
ffffffffc0200b00:	00005797          	auipc	a5,0x5
ffffffffc0200b04:	62778793          	addi	a5,a5,1575 # ffffffffc0206127 <end+0xfff>
ffffffffc0200b08:	757d                	lui	a0,0xfffff
ffffffffc0200b0a:	8d7d                	and	a0,a0,a5
ffffffffc0200b0c:	8231                	srli	a2,a2,0xc
ffffffffc0200b0e:	00004797          	auipc	a5,0x4
ffffffffc0200b12:	5ec7b523          	sd	a2,1514(a5) # ffffffffc02050f8 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200b16:	00004797          	auipc	a5,0x4
ffffffffc0200b1a:	5ea7b523          	sd	a0,1514(a5) # ffffffffc0205100 <pages>
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200b1e:	000807b7          	lui	a5,0x80
ffffffffc0200b22:	002005b7          	lui	a1,0x200
ffffffffc0200b26:	02f60563          	beq	a2,a5,ffffffffc0200b50 <pmm_init+0xd0>
ffffffffc0200b2a:	00261593          	slli	a1,a2,0x2
ffffffffc0200b2e:	00c586b3          	add	a3,a1,a2
ffffffffc0200b32:	fec007b7          	lui	a5,0xfec00
ffffffffc0200b36:	97aa                	add	a5,a5,a0
ffffffffc0200b38:	068e                	slli	a3,a3,0x3
ffffffffc0200b3a:	96be                	add	a3,a3,a5
ffffffffc0200b3c:	87aa                	mv	a5,a0
        SetPageReserved(pages + i);
ffffffffc0200b3e:	6798                	ld	a4,8(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200b40:	02878793          	addi	a5,a5,40 # fffffffffec00028 <end+0x3e9faf00>
        SetPageReserved(pages + i);
ffffffffc0200b44:	00176713          	ori	a4,a4,1
ffffffffc0200b48:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200b4c:	fef699e3          	bne	a3,a5,ffffffffc0200b3e <pmm_init+0xbe>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200b50:	95b2                	add	a1,a1,a2
ffffffffc0200b52:	fec006b7          	lui	a3,0xfec00
ffffffffc0200b56:	96aa                	add	a3,a3,a0
ffffffffc0200b58:	058e                	slli	a1,a1,0x3
ffffffffc0200b5a:	96ae                	add	a3,a3,a1
ffffffffc0200b5c:	c02007b7          	lui	a5,0xc0200
ffffffffc0200b60:	0af6e763          	bltu	a3,a5,ffffffffc0200c0e <pmm_init+0x18e>
ffffffffc0200b64:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0200b66:	77fd                	lui	a5,0xfffff
ffffffffc0200b68:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200b6c:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc0200b6e:	04b6ee63          	bltu	a3,a1,ffffffffc0200bca <pmm_init+0x14a>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0200b72:	601c                	ld	a5,0(s0)
ffffffffc0200b74:	7b9c                	ld	a5,48(a5)
ffffffffc0200b76:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0200b78:	00001517          	auipc	a0,0x1
ffffffffc0200b7c:	a8850513          	addi	a0,a0,-1400 # ffffffffc0201600 <buddy_pmm_manager+0xf0>
ffffffffc0200b80:	dccff0ef          	jal	ra,ffffffffc020014c <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0200b84:	00003597          	auipc	a1,0x3
ffffffffc0200b88:	47c58593          	addi	a1,a1,1148 # ffffffffc0204000 <boot_page_table_sv39>
ffffffffc0200b8c:	00004797          	auipc	a5,0x4
ffffffffc0200b90:	58b7b623          	sd	a1,1420(a5) # ffffffffc0205118 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200b94:	c02007b7          	lui	a5,0xc0200
ffffffffc0200b98:	0af5e363          	bltu	a1,a5,ffffffffc0200c3e <pmm_init+0x1be>
ffffffffc0200b9c:	6090                	ld	a2,0(s1)
}
ffffffffc0200b9e:	7402                	ld	s0,32(sp)
ffffffffc0200ba0:	70a2                	ld	ra,40(sp)
ffffffffc0200ba2:	64e2                	ld	s1,24(sp)
ffffffffc0200ba4:	6942                	ld	s2,16(sp)
ffffffffc0200ba6:	69a2                	ld	s3,8(sp)
ffffffffc0200ba8:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0200baa:	40c58633          	sub	a2,a1,a2
ffffffffc0200bae:	00004797          	auipc	a5,0x4
ffffffffc0200bb2:	56c7b123          	sd	a2,1378(a5) # ffffffffc0205110 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200bb6:	00001517          	auipc	a0,0x1
ffffffffc0200bba:	a6a50513          	addi	a0,a0,-1430 # ffffffffc0201620 <buddy_pmm_manager+0x110>
}
ffffffffc0200bbe:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0200bc0:	d8cff06f          	j	ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0200bc4:	c8000637          	lui	a2,0xc8000
ffffffffc0200bc8:	bf25                	j	ffffffffc0200b00 <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0200bca:	6705                	lui	a4,0x1
ffffffffc0200bcc:	177d                	addi	a4,a4,-1
ffffffffc0200bce:	96ba                	add	a3,a3,a4
ffffffffc0200bd0:	8efd                	and	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0200bd2:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200bd6:	02c7f063          	bgeu	a5,a2,ffffffffc0200bf6 <pmm_init+0x176>
    pmm_manager->init_memmap(base, n);
ffffffffc0200bda:	6010                	ld	a2,0(s0)
    return &pages[PPN(pa) - nbase];
ffffffffc0200bdc:	fff80737          	lui	a4,0xfff80
ffffffffc0200be0:	973e                	add	a4,a4,a5
ffffffffc0200be2:	00271793          	slli	a5,a4,0x2
ffffffffc0200be6:	97ba                	add	a5,a5,a4
ffffffffc0200be8:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200bea:	8d95                	sub	a1,a1,a3
ffffffffc0200bec:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc0200bee:	81b1                	srli	a1,a1,0xc
ffffffffc0200bf0:	953e                	add	a0,a0,a5
ffffffffc0200bf2:	9702                	jalr	a4
}
ffffffffc0200bf4:	bfbd                	j	ffffffffc0200b72 <pmm_init+0xf2>
        panic("pa2page called with invalid pa");
ffffffffc0200bf6:	00001617          	auipc	a2,0x1
ffffffffc0200bfa:	8c260613          	addi	a2,a2,-1854 # ffffffffc02014b8 <etext+0x3cc>
ffffffffc0200bfe:	06a00593          	li	a1,106
ffffffffc0200c02:	00001517          	auipc	a0,0x1
ffffffffc0200c06:	8d650513          	addi	a0,a0,-1834 # ffffffffc02014d8 <etext+0x3ec>
ffffffffc0200c0a:	db8ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200c0e:	00001617          	auipc	a2,0x1
ffffffffc0200c12:	9ca60613          	addi	a2,a2,-1590 # ffffffffc02015d8 <buddy_pmm_manager+0xc8>
ffffffffc0200c16:	05f00593          	li	a1,95
ffffffffc0200c1a:	00001517          	auipc	a0,0x1
ffffffffc0200c1e:	96650513          	addi	a0,a0,-1690 # ffffffffc0201580 <buddy_pmm_manager+0x70>
ffffffffc0200c22:	da0ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        panic("DTB memory info not available");
ffffffffc0200c26:	00001617          	auipc	a2,0x1
ffffffffc0200c2a:	93a60613          	addi	a2,a2,-1734 # ffffffffc0201560 <buddy_pmm_manager+0x50>
ffffffffc0200c2e:	04700593          	li	a1,71
ffffffffc0200c32:	00001517          	auipc	a0,0x1
ffffffffc0200c36:	94e50513          	addi	a0,a0,-1714 # ffffffffc0201580 <buddy_pmm_manager+0x70>
ffffffffc0200c3a:	d88ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0200c3e:	86ae                	mv	a3,a1
ffffffffc0200c40:	00001617          	auipc	a2,0x1
ffffffffc0200c44:	99860613          	addi	a2,a2,-1640 # ffffffffc02015d8 <buddy_pmm_manager+0xc8>
ffffffffc0200c48:	07a00593          	li	a1,122
ffffffffc0200c4c:	00001517          	auipc	a0,0x1
ffffffffc0200c50:	93450513          	addi	a0,a0,-1740 # ffffffffc0201580 <buddy_pmm_manager+0x70>
ffffffffc0200c54:	d6eff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200c58 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0200c58:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200c5c:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0200c5e:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200c62:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0200c64:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0200c68:	f022                	sd	s0,32(sp)
ffffffffc0200c6a:	ec26                	sd	s1,24(sp)
ffffffffc0200c6c:	e84a                	sd	s2,16(sp)
ffffffffc0200c6e:	f406                	sd	ra,40(sp)
ffffffffc0200c70:	e44e                	sd	s3,8(sp)
ffffffffc0200c72:	84aa                	mv	s1,a0
ffffffffc0200c74:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0200c76:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0200c7a:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0200c7c:	03067e63          	bgeu	a2,a6,ffffffffc0200cb8 <printnum+0x60>
ffffffffc0200c80:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0200c82:	00805763          	blez	s0,ffffffffc0200c90 <printnum+0x38>
ffffffffc0200c86:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0200c88:	85ca                	mv	a1,s2
ffffffffc0200c8a:	854e                	mv	a0,s3
ffffffffc0200c8c:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0200c8e:	fc65                	bnez	s0,ffffffffc0200c86 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200c90:	1a02                	slli	s4,s4,0x20
ffffffffc0200c92:	00001797          	auipc	a5,0x1
ffffffffc0200c96:	9ce78793          	addi	a5,a5,-1586 # ffffffffc0201660 <buddy_pmm_manager+0x150>
ffffffffc0200c9a:	020a5a13          	srli	s4,s4,0x20
ffffffffc0200c9e:	9a3e                	add	s4,s4,a5
}
ffffffffc0200ca0:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200ca2:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0200ca6:	70a2                	ld	ra,40(sp)
ffffffffc0200ca8:	69a2                	ld	s3,8(sp)
ffffffffc0200caa:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200cac:	85ca                	mv	a1,s2
ffffffffc0200cae:	87a6                	mv	a5,s1
}
ffffffffc0200cb0:	6942                	ld	s2,16(sp)
ffffffffc0200cb2:	64e2                	ld	s1,24(sp)
ffffffffc0200cb4:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0200cb6:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0200cb8:	03065633          	divu	a2,a2,a6
ffffffffc0200cbc:	8722                	mv	a4,s0
ffffffffc0200cbe:	f9bff0ef          	jal	ra,ffffffffc0200c58 <printnum>
ffffffffc0200cc2:	b7f9                	j	ffffffffc0200c90 <printnum+0x38>

ffffffffc0200cc4 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0200cc4:	7119                	addi	sp,sp,-128
ffffffffc0200cc6:	f4a6                	sd	s1,104(sp)
ffffffffc0200cc8:	f0ca                	sd	s2,96(sp)
ffffffffc0200cca:	ecce                	sd	s3,88(sp)
ffffffffc0200ccc:	e8d2                	sd	s4,80(sp)
ffffffffc0200cce:	e4d6                	sd	s5,72(sp)
ffffffffc0200cd0:	e0da                	sd	s6,64(sp)
ffffffffc0200cd2:	fc5e                	sd	s7,56(sp)
ffffffffc0200cd4:	f06a                	sd	s10,32(sp)
ffffffffc0200cd6:	fc86                	sd	ra,120(sp)
ffffffffc0200cd8:	f8a2                	sd	s0,112(sp)
ffffffffc0200cda:	f862                	sd	s8,48(sp)
ffffffffc0200cdc:	f466                	sd	s9,40(sp)
ffffffffc0200cde:	ec6e                	sd	s11,24(sp)
ffffffffc0200ce0:	892a                	mv	s2,a0
ffffffffc0200ce2:	84ae                	mv	s1,a1
ffffffffc0200ce4:	8d32                	mv	s10,a2
ffffffffc0200ce6:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200ce8:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0200cec:	5b7d                	li	s6,-1
ffffffffc0200cee:	00001a97          	auipc	s5,0x1
ffffffffc0200cf2:	9a6a8a93          	addi	s5,s5,-1626 # ffffffffc0201694 <buddy_pmm_manager+0x184>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0200cf6:	00001b97          	auipc	s7,0x1
ffffffffc0200cfa:	b7ab8b93          	addi	s7,s7,-1158 # ffffffffc0201870 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200cfe:	000d4503          	lbu	a0,0(s10)
ffffffffc0200d02:	001d0413          	addi	s0,s10,1
ffffffffc0200d06:	01350a63          	beq	a0,s3,ffffffffc0200d1a <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0200d0a:	c121                	beqz	a0,ffffffffc0200d4a <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0200d0c:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200d0e:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0200d10:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0200d12:	fff44503          	lbu	a0,-1(s0)
ffffffffc0200d16:	ff351ae3          	bne	a0,s3,ffffffffc0200d0a <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200d1a:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0200d1e:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0200d22:	4c81                	li	s9,0
ffffffffc0200d24:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0200d26:	5c7d                	li	s8,-1
ffffffffc0200d28:	5dfd                	li	s11,-1
ffffffffc0200d2a:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0200d2e:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200d30:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0200d34:	0ff5f593          	zext.b	a1,a1
ffffffffc0200d38:	00140d13          	addi	s10,s0,1
ffffffffc0200d3c:	04b56263          	bltu	a0,a1,ffffffffc0200d80 <vprintfmt+0xbc>
ffffffffc0200d40:	058a                	slli	a1,a1,0x2
ffffffffc0200d42:	95d6                	add	a1,a1,s5
ffffffffc0200d44:	4194                	lw	a3,0(a1)
ffffffffc0200d46:	96d6                	add	a3,a3,s5
ffffffffc0200d48:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0200d4a:	70e6                	ld	ra,120(sp)
ffffffffc0200d4c:	7446                	ld	s0,112(sp)
ffffffffc0200d4e:	74a6                	ld	s1,104(sp)
ffffffffc0200d50:	7906                	ld	s2,96(sp)
ffffffffc0200d52:	69e6                	ld	s3,88(sp)
ffffffffc0200d54:	6a46                	ld	s4,80(sp)
ffffffffc0200d56:	6aa6                	ld	s5,72(sp)
ffffffffc0200d58:	6b06                	ld	s6,64(sp)
ffffffffc0200d5a:	7be2                	ld	s7,56(sp)
ffffffffc0200d5c:	7c42                	ld	s8,48(sp)
ffffffffc0200d5e:	7ca2                	ld	s9,40(sp)
ffffffffc0200d60:	7d02                	ld	s10,32(sp)
ffffffffc0200d62:	6de2                	ld	s11,24(sp)
ffffffffc0200d64:	6109                	addi	sp,sp,128
ffffffffc0200d66:	8082                	ret
            padc = '0';
ffffffffc0200d68:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0200d6a:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200d6e:	846a                	mv	s0,s10
ffffffffc0200d70:	00140d13          	addi	s10,s0,1
ffffffffc0200d74:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0200d78:	0ff5f593          	zext.b	a1,a1
ffffffffc0200d7c:	fcb572e3          	bgeu	a0,a1,ffffffffc0200d40 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0200d80:	85a6                	mv	a1,s1
ffffffffc0200d82:	02500513          	li	a0,37
ffffffffc0200d86:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0200d88:	fff44783          	lbu	a5,-1(s0)
ffffffffc0200d8c:	8d22                	mv	s10,s0
ffffffffc0200d8e:	f73788e3          	beq	a5,s3,ffffffffc0200cfe <vprintfmt+0x3a>
ffffffffc0200d92:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0200d96:	1d7d                	addi	s10,s10,-1
ffffffffc0200d98:	ff379de3          	bne	a5,s3,ffffffffc0200d92 <vprintfmt+0xce>
ffffffffc0200d9c:	b78d                	j	ffffffffc0200cfe <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0200d9e:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0200da2:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200da6:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0200da8:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0200dac:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0200db0:	02d86463          	bltu	a6,a3,ffffffffc0200dd8 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0200db4:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0200db8:	002c169b          	slliw	a3,s8,0x2
ffffffffc0200dbc:	0186873b          	addw	a4,a3,s8
ffffffffc0200dc0:	0017171b          	slliw	a4,a4,0x1
ffffffffc0200dc4:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0200dc6:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0200dca:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0200dcc:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0200dd0:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0200dd4:	fed870e3          	bgeu	a6,a3,ffffffffc0200db4 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0200dd8:	f40ddce3          	bgez	s11,ffffffffc0200d30 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0200ddc:	8de2                	mv	s11,s8
ffffffffc0200dde:	5c7d                	li	s8,-1
ffffffffc0200de0:	bf81                	j	ffffffffc0200d30 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0200de2:	fffdc693          	not	a3,s11
ffffffffc0200de6:	96fd                	srai	a3,a3,0x3f
ffffffffc0200de8:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200dec:	00144603          	lbu	a2,1(s0)
ffffffffc0200df0:	2d81                	sext.w	s11,s11
ffffffffc0200df2:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0200df4:	bf35                	j	ffffffffc0200d30 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0200df6:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200dfa:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0200dfe:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e00:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0200e02:	bfd9                	j	ffffffffc0200dd8 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0200e04:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0200e06:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0200e0a:	01174463          	blt	a4,a7,ffffffffc0200e12 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0200e0e:	1a088e63          	beqz	a7,ffffffffc0200fca <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0200e12:	000a3603          	ld	a2,0(s4)
ffffffffc0200e16:	46c1                	li	a3,16
ffffffffc0200e18:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0200e1a:	2781                	sext.w	a5,a5
ffffffffc0200e1c:	876e                	mv	a4,s11
ffffffffc0200e1e:	85a6                	mv	a1,s1
ffffffffc0200e20:	854a                	mv	a0,s2
ffffffffc0200e22:	e37ff0ef          	jal	ra,ffffffffc0200c58 <printnum>
            break;
ffffffffc0200e26:	bde1                	j	ffffffffc0200cfe <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0200e28:	000a2503          	lw	a0,0(s4)
ffffffffc0200e2c:	85a6                	mv	a1,s1
ffffffffc0200e2e:	0a21                	addi	s4,s4,8
ffffffffc0200e30:	9902                	jalr	s2
            break;
ffffffffc0200e32:	b5f1                	j	ffffffffc0200cfe <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0200e34:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0200e36:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0200e3a:	01174463          	blt	a4,a7,ffffffffc0200e42 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0200e3e:	18088163          	beqz	a7,ffffffffc0200fc0 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0200e42:	000a3603          	ld	a2,0(s4)
ffffffffc0200e46:	46a9                	li	a3,10
ffffffffc0200e48:	8a2e                	mv	s4,a1
ffffffffc0200e4a:	bfc1                	j	ffffffffc0200e1a <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e4c:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0200e50:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e52:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0200e54:	bdf1                	j	ffffffffc0200d30 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0200e56:	85a6                	mv	a1,s1
ffffffffc0200e58:	02500513          	li	a0,37
ffffffffc0200e5c:	9902                	jalr	s2
            break;
ffffffffc0200e5e:	b545                	j	ffffffffc0200cfe <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e60:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0200e64:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0200e66:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0200e68:	b5e1                	j	ffffffffc0200d30 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0200e6a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0200e6c:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0200e70:	01174463          	blt	a4,a7,ffffffffc0200e78 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0200e74:	14088163          	beqz	a7,ffffffffc0200fb6 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0200e78:	000a3603          	ld	a2,0(s4)
ffffffffc0200e7c:	46a1                	li	a3,8
ffffffffc0200e7e:	8a2e                	mv	s4,a1
ffffffffc0200e80:	bf69                	j	ffffffffc0200e1a <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0200e82:	03000513          	li	a0,48
ffffffffc0200e86:	85a6                	mv	a1,s1
ffffffffc0200e88:	e03e                	sd	a5,0(sp)
ffffffffc0200e8a:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0200e8c:	85a6                	mv	a1,s1
ffffffffc0200e8e:	07800513          	li	a0,120
ffffffffc0200e92:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0200e94:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0200e96:	6782                	ld	a5,0(sp)
ffffffffc0200e98:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0200e9a:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0200e9e:	bfb5                	j	ffffffffc0200e1a <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0200ea0:	000a3403          	ld	s0,0(s4)
ffffffffc0200ea4:	008a0713          	addi	a4,s4,8
ffffffffc0200ea8:	e03a                	sd	a4,0(sp)
ffffffffc0200eaa:	14040263          	beqz	s0,ffffffffc0200fee <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0200eae:	0fb05763          	blez	s11,ffffffffc0200f9c <vprintfmt+0x2d8>
ffffffffc0200eb2:	02d00693          	li	a3,45
ffffffffc0200eb6:	0cd79163          	bne	a5,a3,ffffffffc0200f78 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0200eba:	00044783          	lbu	a5,0(s0)
ffffffffc0200ebe:	0007851b          	sext.w	a0,a5
ffffffffc0200ec2:	cf85                	beqz	a5,ffffffffc0200efa <vprintfmt+0x236>
ffffffffc0200ec4:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0200ec8:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0200ecc:	000c4563          	bltz	s8,ffffffffc0200ed6 <vprintfmt+0x212>
ffffffffc0200ed0:	3c7d                	addiw	s8,s8,-1
ffffffffc0200ed2:	036c0263          	beq	s8,s6,ffffffffc0200ef6 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0200ed6:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0200ed8:	0e0c8e63          	beqz	s9,ffffffffc0200fd4 <vprintfmt+0x310>
ffffffffc0200edc:	3781                	addiw	a5,a5,-32
ffffffffc0200ede:	0ef47b63          	bgeu	s0,a5,ffffffffc0200fd4 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0200ee2:	03f00513          	li	a0,63
ffffffffc0200ee6:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0200ee8:	000a4783          	lbu	a5,0(s4)
ffffffffc0200eec:	3dfd                	addiw	s11,s11,-1
ffffffffc0200eee:	0a05                	addi	s4,s4,1
ffffffffc0200ef0:	0007851b          	sext.w	a0,a5
ffffffffc0200ef4:	ffe1                	bnez	a5,ffffffffc0200ecc <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0200ef6:	01b05963          	blez	s11,ffffffffc0200f08 <vprintfmt+0x244>
ffffffffc0200efa:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0200efc:	85a6                	mv	a1,s1
ffffffffc0200efe:	02000513          	li	a0,32
ffffffffc0200f02:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0200f04:	fe0d9be3          	bnez	s11,ffffffffc0200efa <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0200f08:	6a02                	ld	s4,0(sp)
ffffffffc0200f0a:	bbd5                	j	ffffffffc0200cfe <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0200f0c:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0200f0e:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0200f12:	01174463          	blt	a4,a7,ffffffffc0200f1a <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0200f16:	08088d63          	beqz	a7,ffffffffc0200fb0 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0200f1a:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0200f1e:	0a044d63          	bltz	s0,ffffffffc0200fd8 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0200f22:	8622                	mv	a2,s0
ffffffffc0200f24:	8a66                	mv	s4,s9
ffffffffc0200f26:	46a9                	li	a3,10
ffffffffc0200f28:	bdcd                	j	ffffffffc0200e1a <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0200f2a:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0200f2e:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0200f30:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0200f32:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0200f36:	8fb5                	xor	a5,a5,a3
ffffffffc0200f38:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0200f3c:	02d74163          	blt	a4,a3,ffffffffc0200f5e <vprintfmt+0x29a>
ffffffffc0200f40:	00369793          	slli	a5,a3,0x3
ffffffffc0200f44:	97de                	add	a5,a5,s7
ffffffffc0200f46:	639c                	ld	a5,0(a5)
ffffffffc0200f48:	cb99                	beqz	a5,ffffffffc0200f5e <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0200f4a:	86be                	mv	a3,a5
ffffffffc0200f4c:	00000617          	auipc	a2,0x0
ffffffffc0200f50:	74460613          	addi	a2,a2,1860 # ffffffffc0201690 <buddy_pmm_manager+0x180>
ffffffffc0200f54:	85a6                	mv	a1,s1
ffffffffc0200f56:	854a                	mv	a0,s2
ffffffffc0200f58:	0ce000ef          	jal	ra,ffffffffc0201026 <printfmt>
ffffffffc0200f5c:	b34d                	j	ffffffffc0200cfe <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0200f5e:	00000617          	auipc	a2,0x0
ffffffffc0200f62:	72260613          	addi	a2,a2,1826 # ffffffffc0201680 <buddy_pmm_manager+0x170>
ffffffffc0200f66:	85a6                	mv	a1,s1
ffffffffc0200f68:	854a                	mv	a0,s2
ffffffffc0200f6a:	0bc000ef          	jal	ra,ffffffffc0201026 <printfmt>
ffffffffc0200f6e:	bb41                	j	ffffffffc0200cfe <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0200f70:	00000417          	auipc	s0,0x0
ffffffffc0200f74:	70840413          	addi	s0,s0,1800 # ffffffffc0201678 <buddy_pmm_manager+0x168>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0200f78:	85e2                	mv	a1,s8
ffffffffc0200f7a:	8522                	mv	a0,s0
ffffffffc0200f7c:	e43e                	sd	a5,8(sp)
ffffffffc0200f7e:	0fc000ef          	jal	ra,ffffffffc020107a <strnlen>
ffffffffc0200f82:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0200f86:	01b05b63          	blez	s11,ffffffffc0200f9c <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0200f8a:	67a2                	ld	a5,8(sp)
ffffffffc0200f8c:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0200f90:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0200f92:	85a6                	mv	a1,s1
ffffffffc0200f94:	8552                	mv	a0,s4
ffffffffc0200f96:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0200f98:	fe0d9ce3          	bnez	s11,ffffffffc0200f90 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0200f9c:	00044783          	lbu	a5,0(s0)
ffffffffc0200fa0:	00140a13          	addi	s4,s0,1
ffffffffc0200fa4:	0007851b          	sext.w	a0,a5
ffffffffc0200fa8:	d3a5                	beqz	a5,ffffffffc0200f08 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0200faa:	05e00413          	li	s0,94
ffffffffc0200fae:	bf39                	j	ffffffffc0200ecc <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0200fb0:	000a2403          	lw	s0,0(s4)
ffffffffc0200fb4:	b7ad                	j	ffffffffc0200f1e <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0200fb6:	000a6603          	lwu	a2,0(s4)
ffffffffc0200fba:	46a1                	li	a3,8
ffffffffc0200fbc:	8a2e                	mv	s4,a1
ffffffffc0200fbe:	bdb1                	j	ffffffffc0200e1a <vprintfmt+0x156>
ffffffffc0200fc0:	000a6603          	lwu	a2,0(s4)
ffffffffc0200fc4:	46a9                	li	a3,10
ffffffffc0200fc6:	8a2e                	mv	s4,a1
ffffffffc0200fc8:	bd89                	j	ffffffffc0200e1a <vprintfmt+0x156>
ffffffffc0200fca:	000a6603          	lwu	a2,0(s4)
ffffffffc0200fce:	46c1                	li	a3,16
ffffffffc0200fd0:	8a2e                	mv	s4,a1
ffffffffc0200fd2:	b5a1                	j	ffffffffc0200e1a <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0200fd4:	9902                	jalr	s2
ffffffffc0200fd6:	bf09                	j	ffffffffc0200ee8 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0200fd8:	85a6                	mv	a1,s1
ffffffffc0200fda:	02d00513          	li	a0,45
ffffffffc0200fde:	e03e                	sd	a5,0(sp)
ffffffffc0200fe0:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0200fe2:	6782                	ld	a5,0(sp)
ffffffffc0200fe4:	8a66                	mv	s4,s9
ffffffffc0200fe6:	40800633          	neg	a2,s0
ffffffffc0200fea:	46a9                	li	a3,10
ffffffffc0200fec:	b53d                	j	ffffffffc0200e1a <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0200fee:	03b05163          	blez	s11,ffffffffc0201010 <vprintfmt+0x34c>
ffffffffc0200ff2:	02d00693          	li	a3,45
ffffffffc0200ff6:	f6d79de3          	bne	a5,a3,ffffffffc0200f70 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0200ffa:	00000417          	auipc	s0,0x0
ffffffffc0200ffe:	67e40413          	addi	s0,s0,1662 # ffffffffc0201678 <buddy_pmm_manager+0x168>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201002:	02800793          	li	a5,40
ffffffffc0201006:	02800513          	li	a0,40
ffffffffc020100a:	00140a13          	addi	s4,s0,1
ffffffffc020100e:	bd6d                	j	ffffffffc0200ec8 <vprintfmt+0x204>
ffffffffc0201010:	00000a17          	auipc	s4,0x0
ffffffffc0201014:	669a0a13          	addi	s4,s4,1641 # ffffffffc0201679 <buddy_pmm_manager+0x169>
ffffffffc0201018:	02800513          	li	a0,40
ffffffffc020101c:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201020:	05e00413          	li	s0,94
ffffffffc0201024:	b565                	j	ffffffffc0200ecc <vprintfmt+0x208>

ffffffffc0201026 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201026:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201028:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020102c:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc020102e:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201030:	ec06                	sd	ra,24(sp)
ffffffffc0201032:	f83a                	sd	a4,48(sp)
ffffffffc0201034:	fc3e                	sd	a5,56(sp)
ffffffffc0201036:	e0c2                	sd	a6,64(sp)
ffffffffc0201038:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020103a:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc020103c:	c89ff0ef          	jal	ra,ffffffffc0200cc4 <vprintfmt>
}
ffffffffc0201040:	60e2                	ld	ra,24(sp)
ffffffffc0201042:	6161                	addi	sp,sp,80
ffffffffc0201044:	8082                	ret

ffffffffc0201046 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201046:	4781                	li	a5,0
ffffffffc0201048:	00004717          	auipc	a4,0x4
ffffffffc020104c:	fc873703          	ld	a4,-56(a4) # ffffffffc0205010 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201050:	88ba                	mv	a7,a4
ffffffffc0201052:	852a                	mv	a0,a0
ffffffffc0201054:	85be                	mv	a1,a5
ffffffffc0201056:	863e                	mv	a2,a5
ffffffffc0201058:	00000073          	ecall
ffffffffc020105c:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc020105e:	8082                	ret

ffffffffc0201060 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201060:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201064:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201066:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201068:	cb81                	beqz	a5,ffffffffc0201078 <strlen+0x18>
        cnt ++;
ffffffffc020106a:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc020106c:	00a707b3          	add	a5,a4,a0
ffffffffc0201070:	0007c783          	lbu	a5,0(a5)
ffffffffc0201074:	fbfd                	bnez	a5,ffffffffc020106a <strlen+0xa>
ffffffffc0201076:	8082                	ret
    }
    return cnt;
}
ffffffffc0201078:	8082                	ret

ffffffffc020107a <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc020107a:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020107c:	e589                	bnez	a1,ffffffffc0201086 <strnlen+0xc>
ffffffffc020107e:	a811                	j	ffffffffc0201092 <strnlen+0x18>
        cnt ++;
ffffffffc0201080:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201082:	00f58863          	beq	a1,a5,ffffffffc0201092 <strnlen+0x18>
ffffffffc0201086:	00f50733          	add	a4,a0,a5
ffffffffc020108a:	00074703          	lbu	a4,0(a4)
ffffffffc020108e:	fb6d                	bnez	a4,ffffffffc0201080 <strnlen+0x6>
ffffffffc0201090:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201092:	852e                	mv	a0,a1
ffffffffc0201094:	8082                	ret

ffffffffc0201096 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201096:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020109a:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020109e:	cb89                	beqz	a5,ffffffffc02010b0 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc02010a0:	0505                	addi	a0,a0,1
ffffffffc02010a2:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02010a4:	fee789e3          	beq	a5,a4,ffffffffc0201096 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02010a8:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc02010ac:	9d19                	subw	a0,a0,a4
ffffffffc02010ae:	8082                	ret
ffffffffc02010b0:	4501                	li	a0,0
ffffffffc02010b2:	bfed                	j	ffffffffc02010ac <strcmp+0x16>

ffffffffc02010b4 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02010b4:	c20d                	beqz	a2,ffffffffc02010d6 <strncmp+0x22>
ffffffffc02010b6:	962e                	add	a2,a2,a1
ffffffffc02010b8:	a031                	j	ffffffffc02010c4 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc02010ba:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02010bc:	00e79a63          	bne	a5,a4,ffffffffc02010d0 <strncmp+0x1c>
ffffffffc02010c0:	00b60b63          	beq	a2,a1,ffffffffc02010d6 <strncmp+0x22>
ffffffffc02010c4:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc02010c8:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02010ca:	fff5c703          	lbu	a4,-1(a1)
ffffffffc02010ce:	f7f5                	bnez	a5,ffffffffc02010ba <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02010d0:	40e7853b          	subw	a0,a5,a4
}
ffffffffc02010d4:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02010d6:	4501                	li	a0,0
ffffffffc02010d8:	8082                	ret

ffffffffc02010da <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc02010da:	ca01                	beqz	a2,ffffffffc02010ea <memset+0x10>
ffffffffc02010dc:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc02010de:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc02010e0:	0785                	addi	a5,a5,1
ffffffffc02010e2:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc02010e6:	fec79de3          	bne	a5,a2,ffffffffc02010e0 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc02010ea:	8082                	ret
