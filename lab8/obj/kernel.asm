
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	0b70b0ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000c597          	auipc	a1,0xc
ffffffffc020006e:	91e58593          	addi	a1,a1,-1762 # ffffffffc020b988 <etext+0x6>
ffffffffc0200072:	0000c517          	auipc	a0,0xc
ffffffffc0200076:	93650513          	addi	a0,a0,-1738 # ffffffffc020b9a8 <etext+0x26>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	2df020ef          	jal	ra,ffffffffc0202b64 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	76b030ef          	jal	ra,ffffffffc0203ffc <vmm_init>
ffffffffc0200096:	61e070ef          	jal	ra,ffffffffc02076b4 <sched_init>
ffffffffc020009a:	224070ef          	jal	ra,ffffffffc02072be <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	1a0050ef          	jal	ra,ffffffffc0205242 <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	3dc070ef          	jal	ra,ffffffffc020748a <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000c517          	auipc	a0,0xc
ffffffffc02000cc:	8e850513          	addi	a0,a0,-1816 # ffffffffc020b9b0 <etext+0x2e>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00091b97          	auipc	s7,0x91
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0291060 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00091517          	auipc	a0,0x91
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0291060 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	2f00b0ef          	jal	ra,ffffffffc020b48a <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	2b40b0ef          	jal	ra,ffffffffc020b48a <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	6760b0ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	61b010ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	7540b0ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000b517          	auipc	a0,0xb
ffffffffc0200232:	78a50513          	addi	a0,a0,1930 # ffffffffc020b9b8 <etext+0x36>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	79450513          	addi	a0,a0,1940 # ffffffffc020b9d8 <etext+0x56>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	73258593          	addi	a1,a1,1842 # ffffffffc020b982 <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	7a050513          	addi	a0,a0,1952 # ffffffffc020b9f8 <etext+0x76>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	7ac50513          	addi	a0,a0,1964 # ffffffffc020ba18 <etext+0x96>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	7b850513          	addi	a0,a0,1976 # ffffffffc020ba38 <etext+0xb6>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00097597          	auipc	a1,0x97
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	7aa50513          	addi	a0,a0,1962 # ffffffffc020ba58 <etext+0xd6>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	7cc60613          	addi	a2,a2,1996 # ffffffffc020ba88 <etext+0x106>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	7d850513          	addi	a0,a0,2008 # ffffffffc020baa0 <etext+0x11e>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	7e060613          	addi	a2,a2,2016 # ffffffffc020bab8 <etext+0x136>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	7f858593          	addi	a1,a1,2040 # ffffffffc020bad8 <etext+0x156>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	7f850513          	addi	a0,a0,2040 # ffffffffc020bae0 <etext+0x15e>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	7fa60613          	addi	a2,a2,2042 # ffffffffc020baf0 <etext+0x16e>
ffffffffc02002fe:	0000c597          	auipc	a1,0xc
ffffffffc0200302:	81a58593          	addi	a1,a1,-2022 # ffffffffc020bb18 <etext+0x196>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	7da50513          	addi	a0,a0,2010 # ffffffffc020bae0 <etext+0x15e>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000c617          	auipc	a2,0xc
ffffffffc0200316:	81660613          	addi	a2,a2,-2026 # ffffffffc020bb28 <etext+0x1a6>
ffffffffc020031a:	0000c597          	auipc	a1,0xc
ffffffffc020031e:	82e58593          	addi	a1,a1,-2002 # ffffffffc020bb48 <etext+0x1c6>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	7be50513          	addi	a0,a0,1982 # ffffffffc020bae0 <etext+0x15e>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	7fc50513          	addi	a0,a0,2044 # ffffffffc020bb58 <etext+0x1d6>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000c517          	auipc	a0,0xc
ffffffffc0200382:	80250513          	addi	a0,a0,-2046 # ffffffffc020bb80 <etext+0x1fe>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000cc17          	auipc	s8,0xc
ffffffffc0200398:	85cc0c13          	addi	s8,s8,-1956 # ffffffffc020bbf0 <commands>
ffffffffc020039c:	0000c917          	auipc	s2,0xc
ffffffffc02003a0:	80c90913          	addi	s2,s2,-2036 # ffffffffc020bba8 <etext+0x226>
ffffffffc02003a4:	0000c497          	auipc	s1,0xc
ffffffffc02003a8:	80c48493          	addi	s1,s1,-2036 # ffffffffc020bbb0 <etext+0x22e>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000cb17          	auipc	s6,0xc
ffffffffc02003b2:	80ab0b13          	addi	s6,s6,-2038 # ffffffffc020bbb8 <etext+0x236>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	722a0a13          	addi	s4,s4,1826 # ffffffffc020bad8 <etext+0x156>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000cd17          	auipc	s10,0xc
ffffffffc02003dc:	818d0d13          	addi	s10,s10,-2024 # ffffffffc020bbf0 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	4d80b0ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	4c40b0ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	4ca0b0ef          	jal	ra,ffffffffc020b902 <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	48c0b0ef          	jal	ra,ffffffffc020b902 <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000b517          	auipc	a0,0xb
ffffffffc0200494:	74850513          	addi	a0,a0,1864 # ffffffffc020bbd8 <etext+0x256>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00096317          	auipc	t1,0x96
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0296868 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000b517          	auipc	a0,0xb
ffffffffc02004d0:	76c50513          	addi	a0,a0,1900 # ffffffffc020bc38 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000d517          	auipc	a0,0xd
ffffffffc02004e6:	a4e50513          	addi	a0,a0,-1458 # ffffffffc020cf30 <default_pmm_manager+0x610>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000b517          	auipc	a0,0xb
ffffffffc020051a:	74250513          	addi	a0,a0,1858 # ffffffffc020bc58 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000d517          	auipc	a0,0xd
ffffffffc020053a:	9fa50513          	addi	a0,a0,-1542 # ffffffffc020cf30 <default_pmm_manager+0x610>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000b517          	auipc	a0,0xb
ffffffffc020056c:	71050513          	addi	a0,a0,1808 # ffffffffc020bc78 <commands+0x88>
ffffffffc0200570:	00096797          	auipc	a5,0x96
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0296870 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00091697          	auipc	a3,0x91
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0291460 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00091797          	auipc	a5,0x91
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0291664 <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00091797          	auipc	a5,0x91
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0291660 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000b517          	auipc	a0,0xb
ffffffffc02006b2:	5ea50513          	addi	a0,a0,1514 # ffffffffc020bc98 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00014597          	auipc	a1,0x14
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02006dc:	0000b517          	auipc	a0,0xb
ffffffffc02006e0:	5cc50513          	addi	a0,a0,1484 # ffffffffc020bca8 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	5c650513          	addi	a0,a0,1478 # ffffffffc020bcb8 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	5ce50513          	addi	a0,a0,1486 # ffffffffc020bcd0 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000b917          	auipc	s2,0xb
ffffffffc02007c0:	56490913          	addi	s2,s2,1380 # ffffffffc020bd20 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	54e48493          	addi	s1,s1,1358 # ffffffffc020bd18 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000b517          	auipc	a0,0xb
ffffffffc0200822:	57a50513          	addi	a0,a0,1402 # ffffffffc020bd98 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	5a650513          	addi	a0,a0,1446 # ffffffffc020bdd0 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000b517          	auipc	a0,0xb
ffffffffc020086e:	48650513          	addi	a0,a0,1158 # ffffffffc020bcf0 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	7ff0a0ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	0560b0ef          	jal	ra,ffffffffc020b8dc <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	7a30a0ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	3f850513          	addi	a0,a0,1016 # ffffffffc020bd28 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000b517          	auipc	a0,0xb
ffffffffc0200a02:	34a50513          	addi	a0,a0,842 # ffffffffc020bd48 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	35050513          	addi	a0,a0,848 # ffffffffc020bd60 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	35e50513          	addi	a0,a0,862 # ffffffffc020bd80 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	3a250513          	addi	a0,a0,930 # ffffffffc020bdd0 <commands+0x1e0>
ffffffffc0200a36:	00096797          	auipc	a5,0x96
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200a3e:	00096797          	auipc	a5,0x96
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00096517          	auipc	a0,0x96
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00096517          	auipc	a0,0x96
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00091597          	auipc	a1,0x91
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00091797          	auipc	a5,0x91
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0291668 <ide_devices>
ffffffffc0200a72:	00091797          	auipc	a5,0x91
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a7a:	00091797          	auipc	a5,0x91
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200a82:	00091797          	auipc	a5,0x91
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0291758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00091417          	auipc	s0,0x91
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0291668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00091597          	auipc	a1,0x91
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000b697          	auipc	a3,0xb
ffffffffc0200abc:	33068693          	addi	a3,a3,816 # ffffffffc020bde8 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	34060613          	addi	a2,a2,832 # ffffffffc020be00 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	34e50513          	addi	a0,a0,846 # ffffffffc020be18 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	35a68693          	addi	a3,a3,858 # ffffffffc020be30 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	32260613          	addi	a2,a2,802 # ffffffffc020be00 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	33050513          	addi	a0,a0,816 # ffffffffc020be18 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00091797          	auipc	a5,0x91
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0291668 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00091797          	auipc	a5,0x91
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0291668 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00091817          	auipc	a6,0x91
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0291668 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000b697          	auipc	a3,0xb
ffffffffc0200b9a:	2b268693          	addi	a3,a3,690 # ffffffffc020be48 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	26260613          	addi	a2,a2,610 # ffffffffc020be00 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	26e50513          	addi	a0,a0,622 # ffffffffc020be18 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	2ba68693          	addi	a3,a3,698 # ffffffffc020be70 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	24260613          	addi	a2,a2,578 # ffffffffc020be00 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	24e50513          	addi	a0,a0,590 # ffffffffc020be18 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00091817          	auipc	a6,0x91
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0291668 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000b697          	auipc	a3,0xb
ffffffffc0200c30:	21c68693          	addi	a3,a3,540 # ffffffffc020be48 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	1cc60613          	addi	a2,a2,460 # ffffffffc020be00 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	1d850513          	addi	a0,a0,472 # ffffffffc020be18 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	22468693          	addi	a3,a3,548 # ffffffffc020be70 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	1ac60613          	addi	a2,a2,428 # ffffffffc020be00 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	1b850513          	addi	a0,a0,440 # ffffffffc020be18 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	4d30a0ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	4a90a0ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	4350a0ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	00090617          	auipc	a2,0x90
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0291010 <arena>
ffffffffc0200cf8:	0001b917          	auipc	s2,0x1b
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000b517          	auipc	a0,0xb
ffffffffc0200d16:	1b650513          	addi	a0,a0,438 # ffffffffc020bec8 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000b597          	auipc	a1,0xb
ffffffffc0200d38:	1ec58593          	addi	a1,a1,492 # ffffffffc020bf20 <commands+0x330>
ffffffffc0200d3c:	3710a0ef          	jal	ra,ffffffffc020b8ac <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001b617          	auipc	a2,0x1b
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00013917          	auipc	s2,0x13
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000b517          	auipc	a0,0xb
ffffffffc0200d80:	13450513          	addi	a0,a0,308 # ffffffffc020beb0 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	16660613          	addi	a2,a2,358 # ffffffffc020bef0 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	17250513          	addi	a0,a0,370 # ffffffffc020bf08 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	4ce78793          	addi	a5,a5,1230 # ffffffffc0201274 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000b517          	auipc	a0,0xb
ffffffffc0200dc8:	16c50513          	addi	a0,a0,364 # ffffffffc020bf30 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	17450513          	addi	a0,a0,372 # ffffffffc020bf48 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	17e50513          	addi	a0,a0,382 # ffffffffc020bf60 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	18850513          	addi	a0,a0,392 # ffffffffc020bf78 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	19250513          	addi	a0,a0,402 # ffffffffc020bf90 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	19c50513          	addi	a0,a0,412 # ffffffffc020bfa8 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	1a650513          	addi	a0,a0,422 # ffffffffc020bfc0 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	1b050513          	addi	a0,a0,432 # ffffffffc020bfd8 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	1ba50513          	addi	a0,a0,442 # ffffffffc020bff0 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	1c450513          	addi	a0,a0,452 # ffffffffc020c008 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	1ce50513          	addi	a0,a0,462 # ffffffffc020c020 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	1d850513          	addi	a0,a0,472 # ffffffffc020c038 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	1e250513          	addi	a0,a0,482 # ffffffffc020c050 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	1ec50513          	addi	a0,a0,492 # ffffffffc020c068 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	1f650513          	addi	a0,a0,502 # ffffffffc020c080 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	20050513          	addi	a0,a0,512 # ffffffffc020c098 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	20a50513          	addi	a0,a0,522 # ffffffffc020c0b0 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	21450513          	addi	a0,a0,532 # ffffffffc020c0c8 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	21e50513          	addi	a0,a0,542 # ffffffffc020c0e0 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	22850513          	addi	a0,a0,552 # ffffffffc020c0f8 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	23250513          	addi	a0,a0,562 # ffffffffc020c110 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	23c50513          	addi	a0,a0,572 # ffffffffc020c128 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	24650513          	addi	a0,a0,582 # ffffffffc020c140 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	25050513          	addi	a0,a0,592 # ffffffffc020c158 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	25a50513          	addi	a0,a0,602 # ffffffffc020c170 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	26450513          	addi	a0,a0,612 # ffffffffc020c188 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	26e50513          	addi	a0,a0,622 # ffffffffc020c1a0 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	27850513          	addi	a0,a0,632 # ffffffffc020c1b8 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	28250513          	addi	a0,a0,642 # ffffffffc020c1d0 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	28c50513          	addi	a0,a0,652 # ffffffffc020c1e8 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	29650513          	addi	a0,a0,662 # ffffffffc020c200 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	29c50513          	addi	a0,a0,668 # ffffffffc020c218 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	29e50513          	addi	a0,a0,670 # ffffffffc020c230 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	29e50513          	addi	a0,a0,670 # ffffffffc020c248 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	2a650513          	addi	a0,a0,678 # ffffffffc020c260 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	2ae50513          	addi	a0,a0,686 # ffffffffc020c278 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	2aa50513          	addi	a0,a0,682 # ffffffffc020c288 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <pgfault_handler.isra.0>:
ffffffffc0200fec:	10053783          	ld	a5,256(a0)
ffffffffc0200ff0:	1101                	addi	sp,sp,-32
ffffffffc0200ff2:	ec06                	sd	ra,24(sp)
ffffffffc0200ff4:	e822                	sd	s0,16(sp)
ffffffffc0200ff6:	e426                	sd	s1,8(sp)
ffffffffc0200ff8:	e04a                	sd	s2,0(sp)
ffffffffc0200ffa:	1007f793          	andi	a5,a5,256
ffffffffc0200ffe:	efad                	bnez	a5,ffffffffc0201078 <pgfault_handler.isra.0+0x8c>
ffffffffc0201000:	00096497          	auipc	s1,0x96
ffffffffc0201004:	8c048493          	addi	s1,s1,-1856 # ffffffffc02968c0 <current>
ffffffffc0201008:	609c                	ld	a5,0(s1)
ffffffffc020100a:	842a                	mv	s0,a0
ffffffffc020100c:	c7b9                	beqz	a5,ffffffffc020105a <pgfault_handler.isra.0+0x6e>
ffffffffc020100e:	7788                	ld	a0,40(a5)
ffffffffc0201010:	c529                	beqz	a0,ffffffffc020105a <pgfault_handler.isra.0+0x6e>
ffffffffc0201012:	11043903          	ld	s2,272(s0)
ffffffffc0201016:	4581                	li	a1,0
ffffffffc0201018:	864a                	mv	a2,s2
ffffffffc020101a:	48c030ef          	jal	ra,ffffffffc02044a6 <do_pgfault>
ffffffffc020101e:	e519                	bnez	a0,ffffffffc020102c <pgfault_handler.isra.0+0x40>
ffffffffc0201020:	60e2                	ld	ra,24(sp)
ffffffffc0201022:	6442                	ld	s0,16(sp)
ffffffffc0201024:	64a2                	ld	s1,8(sp)
ffffffffc0201026:	6902                	ld	s2,0(sp)
ffffffffc0201028:	6105                	addi	sp,sp,32
ffffffffc020102a:	8082                	ret
ffffffffc020102c:	609c                	ld	a5,0(s1)
ffffffffc020102e:	10843683          	ld	a3,264(s0)
ffffffffc0201032:	872a                	mv	a4,a0
ffffffffc0201034:	43cc                	lw	a1,4(a5)
ffffffffc0201036:	864a                	mv	a2,s2
ffffffffc0201038:	0000b517          	auipc	a0,0xb
ffffffffc020103c:	2c050513          	addi	a0,a0,704 # ffffffffc020c2f8 <commands+0x708>
ffffffffc0201040:	966ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201044:	8522                	mv	a0,s0
ffffffffc0201046:	f45ff0ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc020104a:	6442                	ld	s0,16(sp)
ffffffffc020104c:	60e2                	ld	ra,24(sp)
ffffffffc020104e:	64a2                	ld	s1,8(sp)
ffffffffc0201050:	6902                	ld	s2,0(sp)
ffffffffc0201052:	555d                	li	a0,-9
ffffffffc0201054:	6105                	addi	sp,sp,32
ffffffffc0201056:	0c80506f          	j	ffffffffc020611e <do_exit>
ffffffffc020105a:	8522                	mv	a0,s0
ffffffffc020105c:	f2fff0ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0201060:	0000b617          	auipc	a2,0xb
ffffffffc0201064:	27060613          	addi	a2,a2,624 # ffffffffc020c2d0 <commands+0x6e0>
ffffffffc0201068:	06c00593          	li	a1,108
ffffffffc020106c:	0000b517          	auipc	a0,0xb
ffffffffc0201070:	24c50513          	addi	a0,a0,588 # ffffffffc020c2b8 <commands+0x6c8>
ffffffffc0201074:	c2aff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201078:	f13ff0ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc020107c:	0000b617          	auipc	a2,0xb
ffffffffc0201080:	22460613          	addi	a2,a2,548 # ffffffffc020c2a0 <commands+0x6b0>
ffffffffc0201084:	06700593          	li	a1,103
ffffffffc0201088:	0000b517          	auipc	a0,0xb
ffffffffc020108c:	23050513          	addi	a0,a0,560 # ffffffffc020c2b8 <commands+0x6c8>
ffffffffc0201090:	c0eff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201094 <interrupt_handler>:
ffffffffc0201094:	11853783          	ld	a5,280(a0)
ffffffffc0201098:	472d                	li	a4,11
ffffffffc020109a:	0786                	slli	a5,a5,0x1
ffffffffc020109c:	8385                	srli	a5,a5,0x1
ffffffffc020109e:	06f76c63          	bltu	a4,a5,ffffffffc0201116 <interrupt_handler+0x82>
ffffffffc02010a2:	0000b717          	auipc	a4,0xb
ffffffffc02010a6:	33670713          	addi	a4,a4,822 # ffffffffc020c3d8 <commands+0x7e8>
ffffffffc02010aa:	078a                	slli	a5,a5,0x2
ffffffffc02010ac:	97ba                	add	a5,a5,a4
ffffffffc02010ae:	439c                	lw	a5,0(a5)
ffffffffc02010b0:	97ba                	add	a5,a5,a4
ffffffffc02010b2:	8782                	jr	a5
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	2e450513          	addi	a0,a0,740 # ffffffffc020c398 <commands+0x7a8>
ffffffffc02010bc:	8eaff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c0:	0000b517          	auipc	a0,0xb
ffffffffc02010c4:	2b850513          	addi	a0,a0,696 # ffffffffc020c378 <commands+0x788>
ffffffffc02010c8:	8deff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010cc:	0000b517          	auipc	a0,0xb
ffffffffc02010d0:	26c50513          	addi	a0,a0,620 # ffffffffc020c338 <commands+0x748>
ffffffffc02010d4:	8d2ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010d8:	0000b517          	auipc	a0,0xb
ffffffffc02010dc:	28050513          	addi	a0,a0,640 # ffffffffc020c358 <commands+0x768>
ffffffffc02010e0:	8c6ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010e4:	1141                	addi	sp,sp,-16
ffffffffc02010e6:	e406                	sd	ra,8(sp)
ffffffffc02010e8:	c92ff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc02010ec:	00095717          	auipc	a4,0x95
ffffffffc02010f0:	78470713          	addi	a4,a4,1924 # ffffffffc0296870 <ticks>
ffffffffc02010f4:	631c                	ld	a5,0(a4)
ffffffffc02010f6:	0785                	addi	a5,a5,1
ffffffffc02010f8:	e31c                	sd	a5,0(a4)
ffffffffc02010fa:	0cb060ef          	jal	ra,ffffffffc02079c4 <run_timer_list>
ffffffffc02010fe:	cf6ff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc0201102:	60a2                	ld	ra,8(sp)
ffffffffc0201104:	0141                	addi	sp,sp,16
ffffffffc0201106:	78f0706f          	j	ffffffffc0209094 <dev_stdin_write>
ffffffffc020110a:	0000b517          	auipc	a0,0xb
ffffffffc020110e:	2ae50513          	addi	a0,a0,686 # ffffffffc020c3b8 <commands+0x7c8>
ffffffffc0201112:	894ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201116:	bd95                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201118 <exception_handler>:
ffffffffc0201118:	11853783          	ld	a5,280(a0)
ffffffffc020111c:	1141                	addi	sp,sp,-16
ffffffffc020111e:	e022                	sd	s0,0(sp)
ffffffffc0201120:	e406                	sd	ra,8(sp)
ffffffffc0201122:	473d                	li	a4,15
ffffffffc0201124:	842a                	mv	s0,a0
ffffffffc0201126:	0af76063          	bltu	a4,a5,ffffffffc02011c6 <exception_handler+0xae>
ffffffffc020112a:	0000b717          	auipc	a4,0xb
ffffffffc020112e:	40e70713          	addi	a4,a4,1038 # ffffffffc020c538 <commands+0x948>
ffffffffc0201132:	078a                	slli	a5,a5,0x2
ffffffffc0201134:	97ba                	add	a5,a5,a4
ffffffffc0201136:	439c                	lw	a5,0(a5)
ffffffffc0201138:	97ba                	add	a5,a5,a4
ffffffffc020113a:	8782                	jr	a5
ffffffffc020113c:	6402                	ld	s0,0(sp)
ffffffffc020113e:	60a2                	ld	ra,8(sp)
ffffffffc0201140:	0141                	addi	sp,sp,16
ffffffffc0201142:	b56d                	j	ffffffffc0200fec <pgfault_handler.isra.0>
ffffffffc0201144:	0000b517          	auipc	a0,0xb
ffffffffc0201148:	39450513          	addi	a0,a0,916 # ffffffffc020c4d8 <commands+0x8e8>
ffffffffc020114c:	85aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201150:	10843783          	ld	a5,264(s0)
ffffffffc0201154:	60a2                	ld	ra,8(sp)
ffffffffc0201156:	0791                	addi	a5,a5,4
ffffffffc0201158:	10f43423          	sd	a5,264(s0)
ffffffffc020115c:	6402                	ld	s0,0(sp)
ffffffffc020115e:	0141                	addi	sp,sp,16
ffffffffc0201160:	27b0606f          	j	ffffffffc0207bda <syscall>
ffffffffc0201164:	0000b517          	auipc	a0,0xb
ffffffffc0201168:	2a450513          	addi	a0,a0,676 # ffffffffc020c408 <commands+0x818>
ffffffffc020116c:	6402                	ld	s0,0(sp)
ffffffffc020116e:	60a2                	ld	ra,8(sp)
ffffffffc0201170:	0141                	addi	sp,sp,16
ffffffffc0201172:	834ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201176:	0000b517          	auipc	a0,0xb
ffffffffc020117a:	2b250513          	addi	a0,a0,690 # ffffffffc020c428 <commands+0x838>
ffffffffc020117e:	b7fd                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc0201180:	0000b517          	auipc	a0,0xb
ffffffffc0201184:	2c850513          	addi	a0,a0,712 # ffffffffc020c448 <commands+0x858>
ffffffffc0201188:	b7d5                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc020118a:	0000b517          	auipc	a0,0xb
ffffffffc020118e:	38e50513          	addi	a0,a0,910 # ffffffffc020c518 <commands+0x928>
ffffffffc0201192:	bfe9                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc0201194:	0000b517          	auipc	a0,0xb
ffffffffc0201198:	36450513          	addi	a0,a0,868 # ffffffffc020c4f8 <commands+0x908>
ffffffffc020119c:	bfc1                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc020119e:	0000b517          	auipc	a0,0xb
ffffffffc02011a2:	32250513          	addi	a0,a0,802 # ffffffffc020c4c0 <commands+0x8d0>
ffffffffc02011a6:	b7d9                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011a8:	0000b517          	auipc	a0,0xb
ffffffffc02011ac:	2b850513          	addi	a0,a0,696 # ffffffffc020c460 <commands+0x870>
ffffffffc02011b0:	bf75                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011b2:	0000b517          	auipc	a0,0xb
ffffffffc02011b6:	2be50513          	addi	a0,a0,702 # ffffffffc020c470 <commands+0x880>
ffffffffc02011ba:	bf4d                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011bc:	0000b517          	auipc	a0,0xb
ffffffffc02011c0:	2d450513          	addi	a0,a0,724 # ffffffffc020c490 <commands+0x8a0>
ffffffffc02011c4:	b765                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011c6:	8522                	mv	a0,s0
ffffffffc02011c8:	6402                	ld	s0,0(sp)
ffffffffc02011ca:	60a2                	ld	ra,8(sp)
ffffffffc02011cc:	0141                	addi	sp,sp,16
ffffffffc02011ce:	bb75                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc02011d0:	0000b617          	auipc	a2,0xb
ffffffffc02011d4:	2d860613          	addi	a2,a2,728 # ffffffffc020c4a8 <commands+0x8b8>
ffffffffc02011d8:	0c800593          	li	a1,200
ffffffffc02011dc:	0000b517          	auipc	a0,0xb
ffffffffc02011e0:	0dc50513          	addi	a0,a0,220 # ffffffffc020c2b8 <commands+0x6c8>
ffffffffc02011e4:	abaff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02011e8 <trap>:
ffffffffc02011e8:	1101                	addi	sp,sp,-32
ffffffffc02011ea:	e822                	sd	s0,16(sp)
ffffffffc02011ec:	00095417          	auipc	s0,0x95
ffffffffc02011f0:	6d440413          	addi	s0,s0,1748 # ffffffffc02968c0 <current>
ffffffffc02011f4:	6018                	ld	a4,0(s0)
ffffffffc02011f6:	ec06                	sd	ra,24(sp)
ffffffffc02011f8:	e426                	sd	s1,8(sp)
ffffffffc02011fa:	e04a                	sd	s2,0(sp)
ffffffffc02011fc:	11853683          	ld	a3,280(a0)
ffffffffc0201200:	cf1d                	beqz	a4,ffffffffc020123e <trap+0x56>
ffffffffc0201202:	10053483          	ld	s1,256(a0)
ffffffffc0201206:	0a073903          	ld	s2,160(a4)
ffffffffc020120a:	f348                	sd	a0,160(a4)
ffffffffc020120c:	1004f493          	andi	s1,s1,256
ffffffffc0201210:	0206c463          	bltz	a3,ffffffffc0201238 <trap+0x50>
ffffffffc0201214:	f05ff0ef          	jal	ra,ffffffffc0201118 <exception_handler>
ffffffffc0201218:	601c                	ld	a5,0(s0)
ffffffffc020121a:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020121e:	e499                	bnez	s1,ffffffffc020122c <trap+0x44>
ffffffffc0201220:	0b07a703          	lw	a4,176(a5)
ffffffffc0201224:	8b05                	andi	a4,a4,1
ffffffffc0201226:	e329                	bnez	a4,ffffffffc0201268 <trap+0x80>
ffffffffc0201228:	6f9c                	ld	a5,24(a5)
ffffffffc020122a:	eb85                	bnez	a5,ffffffffc020125a <trap+0x72>
ffffffffc020122c:	60e2                	ld	ra,24(sp)
ffffffffc020122e:	6442                	ld	s0,16(sp)
ffffffffc0201230:	64a2                	ld	s1,8(sp)
ffffffffc0201232:	6902                	ld	s2,0(sp)
ffffffffc0201234:	6105                	addi	sp,sp,32
ffffffffc0201236:	8082                	ret
ffffffffc0201238:	e5dff0ef          	jal	ra,ffffffffc0201094 <interrupt_handler>
ffffffffc020123c:	bff1                	j	ffffffffc0201218 <trap+0x30>
ffffffffc020123e:	0006c863          	bltz	a3,ffffffffc020124e <trap+0x66>
ffffffffc0201242:	6442                	ld	s0,16(sp)
ffffffffc0201244:	60e2                	ld	ra,24(sp)
ffffffffc0201246:	64a2                	ld	s1,8(sp)
ffffffffc0201248:	6902                	ld	s2,0(sp)
ffffffffc020124a:	6105                	addi	sp,sp,32
ffffffffc020124c:	b5f1                	j	ffffffffc0201118 <exception_handler>
ffffffffc020124e:	6442                	ld	s0,16(sp)
ffffffffc0201250:	60e2                	ld	ra,24(sp)
ffffffffc0201252:	64a2                	ld	s1,8(sp)
ffffffffc0201254:	6902                	ld	s2,0(sp)
ffffffffc0201256:	6105                	addi	sp,sp,32
ffffffffc0201258:	bd35                	j	ffffffffc0201094 <interrupt_handler>
ffffffffc020125a:	6442                	ld	s0,16(sp)
ffffffffc020125c:	60e2                	ld	ra,24(sp)
ffffffffc020125e:	64a2                	ld	s1,8(sp)
ffffffffc0201260:	6902                	ld	s2,0(sp)
ffffffffc0201262:	6105                	addi	sp,sp,32
ffffffffc0201264:	5540606f          	j	ffffffffc02077b8 <schedule>
ffffffffc0201268:	555d                	li	a0,-9
ffffffffc020126a:	6b5040ef          	jal	ra,ffffffffc020611e <do_exit>
ffffffffc020126e:	601c                	ld	a5,0(s0)
ffffffffc0201270:	bf65                	j	ffffffffc0201228 <trap+0x40>
	...

ffffffffc0201274 <__alltraps>:
ffffffffc0201274:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0201278:	00011463          	bnez	sp,ffffffffc0201280 <__alltraps+0xc>
ffffffffc020127c:	14002173          	csrr	sp,sscratch
ffffffffc0201280:	712d                	addi	sp,sp,-288
ffffffffc0201282:	e002                	sd	zero,0(sp)
ffffffffc0201284:	e406                	sd	ra,8(sp)
ffffffffc0201286:	ec0e                	sd	gp,24(sp)
ffffffffc0201288:	f012                	sd	tp,32(sp)
ffffffffc020128a:	f416                	sd	t0,40(sp)
ffffffffc020128c:	f81a                	sd	t1,48(sp)
ffffffffc020128e:	fc1e                	sd	t2,56(sp)
ffffffffc0201290:	e0a2                	sd	s0,64(sp)
ffffffffc0201292:	e4a6                	sd	s1,72(sp)
ffffffffc0201294:	e8aa                	sd	a0,80(sp)
ffffffffc0201296:	ecae                	sd	a1,88(sp)
ffffffffc0201298:	f0b2                	sd	a2,96(sp)
ffffffffc020129a:	f4b6                	sd	a3,104(sp)
ffffffffc020129c:	f8ba                	sd	a4,112(sp)
ffffffffc020129e:	fcbe                	sd	a5,120(sp)
ffffffffc02012a0:	e142                	sd	a6,128(sp)
ffffffffc02012a2:	e546                	sd	a7,136(sp)
ffffffffc02012a4:	e94a                	sd	s2,144(sp)
ffffffffc02012a6:	ed4e                	sd	s3,152(sp)
ffffffffc02012a8:	f152                	sd	s4,160(sp)
ffffffffc02012aa:	f556                	sd	s5,168(sp)
ffffffffc02012ac:	f95a                	sd	s6,176(sp)
ffffffffc02012ae:	fd5e                	sd	s7,184(sp)
ffffffffc02012b0:	e1e2                	sd	s8,192(sp)
ffffffffc02012b2:	e5e6                	sd	s9,200(sp)
ffffffffc02012b4:	e9ea                	sd	s10,208(sp)
ffffffffc02012b6:	edee                	sd	s11,216(sp)
ffffffffc02012b8:	f1f2                	sd	t3,224(sp)
ffffffffc02012ba:	f5f6                	sd	t4,232(sp)
ffffffffc02012bc:	f9fa                	sd	t5,240(sp)
ffffffffc02012be:	fdfe                	sd	t6,248(sp)
ffffffffc02012c0:	14001473          	csrrw	s0,sscratch,zero
ffffffffc02012c4:	100024f3          	csrr	s1,sstatus
ffffffffc02012c8:	14102973          	csrr	s2,sepc
ffffffffc02012cc:	143029f3          	csrr	s3,stval
ffffffffc02012d0:	14202a73          	csrr	s4,scause
ffffffffc02012d4:	e822                	sd	s0,16(sp)
ffffffffc02012d6:	e226                	sd	s1,256(sp)
ffffffffc02012d8:	e64a                	sd	s2,264(sp)
ffffffffc02012da:	ea4e                	sd	s3,272(sp)
ffffffffc02012dc:	ee52                	sd	s4,280(sp)
ffffffffc02012de:	850a                	mv	a0,sp
ffffffffc02012e0:	f09ff0ef          	jal	ra,ffffffffc02011e8 <trap>

ffffffffc02012e4 <__trapret>:
ffffffffc02012e4:	6492                	ld	s1,256(sp)
ffffffffc02012e6:	6932                	ld	s2,264(sp)
ffffffffc02012e8:	1004f413          	andi	s0,s1,256
ffffffffc02012ec:	e401                	bnez	s0,ffffffffc02012f4 <__trapret+0x10>
ffffffffc02012ee:	1200                	addi	s0,sp,288
ffffffffc02012f0:	14041073          	csrw	sscratch,s0
ffffffffc02012f4:	10049073          	csrw	sstatus,s1
ffffffffc02012f8:	14191073          	csrw	sepc,s2
ffffffffc02012fc:	60a2                	ld	ra,8(sp)
ffffffffc02012fe:	61e2                	ld	gp,24(sp)
ffffffffc0201300:	7202                	ld	tp,32(sp)
ffffffffc0201302:	72a2                	ld	t0,40(sp)
ffffffffc0201304:	7342                	ld	t1,48(sp)
ffffffffc0201306:	73e2                	ld	t2,56(sp)
ffffffffc0201308:	6406                	ld	s0,64(sp)
ffffffffc020130a:	64a6                	ld	s1,72(sp)
ffffffffc020130c:	6546                	ld	a0,80(sp)
ffffffffc020130e:	65e6                	ld	a1,88(sp)
ffffffffc0201310:	7606                	ld	a2,96(sp)
ffffffffc0201312:	76a6                	ld	a3,104(sp)
ffffffffc0201314:	7746                	ld	a4,112(sp)
ffffffffc0201316:	77e6                	ld	a5,120(sp)
ffffffffc0201318:	680a                	ld	a6,128(sp)
ffffffffc020131a:	68aa                	ld	a7,136(sp)
ffffffffc020131c:	694a                	ld	s2,144(sp)
ffffffffc020131e:	69ea                	ld	s3,152(sp)
ffffffffc0201320:	7a0a                	ld	s4,160(sp)
ffffffffc0201322:	7aaa                	ld	s5,168(sp)
ffffffffc0201324:	7b4a                	ld	s6,176(sp)
ffffffffc0201326:	7bea                	ld	s7,184(sp)
ffffffffc0201328:	6c0e                	ld	s8,192(sp)
ffffffffc020132a:	6cae                	ld	s9,200(sp)
ffffffffc020132c:	6d4e                	ld	s10,208(sp)
ffffffffc020132e:	6dee                	ld	s11,216(sp)
ffffffffc0201330:	7e0e                	ld	t3,224(sp)
ffffffffc0201332:	7eae                	ld	t4,232(sp)
ffffffffc0201334:	7f4e                	ld	t5,240(sp)
ffffffffc0201336:	7fee                	ld	t6,248(sp)
ffffffffc0201338:	6142                	ld	sp,16(sp)
ffffffffc020133a:	10200073          	sret

ffffffffc020133e <forkrets>:
ffffffffc020133e:	812a                	mv	sp,a0
ffffffffc0201340:	b755                	j	ffffffffc02012e4 <__trapret>

ffffffffc0201342 <default_init>:
ffffffffc0201342:	00090797          	auipc	a5,0x90
ffffffffc0201346:	46678793          	addi	a5,a5,1126 # ffffffffc02917a8 <free_area>
ffffffffc020134a:	e79c                	sd	a5,8(a5)
ffffffffc020134c:	e39c                	sd	a5,0(a5)
ffffffffc020134e:	0007a823          	sw	zero,16(a5)
ffffffffc0201352:	8082                	ret

ffffffffc0201354 <default_nr_free_pages>:
ffffffffc0201354:	00090517          	auipc	a0,0x90
ffffffffc0201358:	46456503          	lwu	a0,1124(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020135c:	8082                	ret

ffffffffc020135e <default_check>:
ffffffffc020135e:	715d                	addi	sp,sp,-80
ffffffffc0201360:	e0a2                	sd	s0,64(sp)
ffffffffc0201362:	00090417          	auipc	s0,0x90
ffffffffc0201366:	44640413          	addi	s0,s0,1094 # ffffffffc02917a8 <free_area>
ffffffffc020136a:	641c                	ld	a5,8(s0)
ffffffffc020136c:	e486                	sd	ra,72(sp)
ffffffffc020136e:	fc26                	sd	s1,56(sp)
ffffffffc0201370:	f84a                	sd	s2,48(sp)
ffffffffc0201372:	f44e                	sd	s3,40(sp)
ffffffffc0201374:	f052                	sd	s4,32(sp)
ffffffffc0201376:	ec56                	sd	s5,24(sp)
ffffffffc0201378:	e85a                	sd	s6,16(sp)
ffffffffc020137a:	e45e                	sd	s7,8(sp)
ffffffffc020137c:	e062                	sd	s8,0(sp)
ffffffffc020137e:	2a878d63          	beq	a5,s0,ffffffffc0201638 <default_check+0x2da>
ffffffffc0201382:	4481                	li	s1,0
ffffffffc0201384:	4901                	li	s2,0
ffffffffc0201386:	ff07b703          	ld	a4,-16(a5)
ffffffffc020138a:	8b09                	andi	a4,a4,2
ffffffffc020138c:	2a070a63          	beqz	a4,ffffffffc0201640 <default_check+0x2e2>
ffffffffc0201390:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201394:	679c                	ld	a5,8(a5)
ffffffffc0201396:	2905                	addiw	s2,s2,1
ffffffffc0201398:	9cb9                	addw	s1,s1,a4
ffffffffc020139a:	fe8796e3          	bne	a5,s0,ffffffffc0201386 <default_check+0x28>
ffffffffc020139e:	89a6                	mv	s3,s1
ffffffffc02013a0:	6df000ef          	jal	ra,ffffffffc020227e <nr_free_pages>
ffffffffc02013a4:	6f351e63          	bne	a0,s3,ffffffffc0201aa0 <default_check+0x742>
ffffffffc02013a8:	4505                	li	a0,1
ffffffffc02013aa:	657000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02013ae:	8aaa                	mv	s5,a0
ffffffffc02013b0:	42050863          	beqz	a0,ffffffffc02017e0 <default_check+0x482>
ffffffffc02013b4:	4505                	li	a0,1
ffffffffc02013b6:	64b000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02013ba:	89aa                	mv	s3,a0
ffffffffc02013bc:	70050263          	beqz	a0,ffffffffc0201ac0 <default_check+0x762>
ffffffffc02013c0:	4505                	li	a0,1
ffffffffc02013c2:	63f000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02013c6:	8a2a                	mv	s4,a0
ffffffffc02013c8:	48050c63          	beqz	a0,ffffffffc0201860 <default_check+0x502>
ffffffffc02013cc:	293a8a63          	beq	s5,s3,ffffffffc0201660 <default_check+0x302>
ffffffffc02013d0:	28aa8863          	beq	s5,a0,ffffffffc0201660 <default_check+0x302>
ffffffffc02013d4:	28a98663          	beq	s3,a0,ffffffffc0201660 <default_check+0x302>
ffffffffc02013d8:	000aa783          	lw	a5,0(s5)
ffffffffc02013dc:	2a079263          	bnez	a5,ffffffffc0201680 <default_check+0x322>
ffffffffc02013e0:	0009a783          	lw	a5,0(s3)
ffffffffc02013e4:	28079e63          	bnez	a5,ffffffffc0201680 <default_check+0x322>
ffffffffc02013e8:	411c                	lw	a5,0(a0)
ffffffffc02013ea:	28079b63          	bnez	a5,ffffffffc0201680 <default_check+0x322>
ffffffffc02013ee:	00095797          	auipc	a5,0x95
ffffffffc02013f2:	4ba7b783          	ld	a5,1210(a5) # ffffffffc02968a8 <pages>
ffffffffc02013f6:	40fa8733          	sub	a4,s5,a5
ffffffffc02013fa:	0000e617          	auipc	a2,0xe
ffffffffc02013fe:	7be63603          	ld	a2,1982(a2) # ffffffffc020fbb8 <nbase>
ffffffffc0201402:	8719                	srai	a4,a4,0x6
ffffffffc0201404:	9732                	add	a4,a4,a2
ffffffffc0201406:	00095697          	auipc	a3,0x95
ffffffffc020140a:	49a6b683          	ld	a3,1178(a3) # ffffffffc02968a0 <npage>
ffffffffc020140e:	06b2                	slli	a3,a3,0xc
ffffffffc0201410:	0732                	slli	a4,a4,0xc
ffffffffc0201412:	28d77763          	bgeu	a4,a3,ffffffffc02016a0 <default_check+0x342>
ffffffffc0201416:	40f98733          	sub	a4,s3,a5
ffffffffc020141a:	8719                	srai	a4,a4,0x6
ffffffffc020141c:	9732                	add	a4,a4,a2
ffffffffc020141e:	0732                	slli	a4,a4,0xc
ffffffffc0201420:	4cd77063          	bgeu	a4,a3,ffffffffc02018e0 <default_check+0x582>
ffffffffc0201424:	40f507b3          	sub	a5,a0,a5
ffffffffc0201428:	8799                	srai	a5,a5,0x6
ffffffffc020142a:	97b2                	add	a5,a5,a2
ffffffffc020142c:	07b2                	slli	a5,a5,0xc
ffffffffc020142e:	30d7f963          	bgeu	a5,a3,ffffffffc0201740 <default_check+0x3e2>
ffffffffc0201432:	4505                	li	a0,1
ffffffffc0201434:	00043c03          	ld	s8,0(s0)
ffffffffc0201438:	00843b83          	ld	s7,8(s0)
ffffffffc020143c:	01042b03          	lw	s6,16(s0)
ffffffffc0201440:	e400                	sd	s0,8(s0)
ffffffffc0201442:	e000                	sd	s0,0(s0)
ffffffffc0201444:	00090797          	auipc	a5,0x90
ffffffffc0201448:	3607aa23          	sw	zero,884(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020144c:	5b5000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201450:	2c051863          	bnez	a0,ffffffffc0201720 <default_check+0x3c2>
ffffffffc0201454:	4585                	li	a1,1
ffffffffc0201456:	8556                	mv	a0,s5
ffffffffc0201458:	5e7000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc020145c:	4585                	li	a1,1
ffffffffc020145e:	854e                	mv	a0,s3
ffffffffc0201460:	5df000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc0201464:	4585                	li	a1,1
ffffffffc0201466:	8552                	mv	a0,s4
ffffffffc0201468:	5d7000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc020146c:	4818                	lw	a4,16(s0)
ffffffffc020146e:	478d                	li	a5,3
ffffffffc0201470:	28f71863          	bne	a4,a5,ffffffffc0201700 <default_check+0x3a2>
ffffffffc0201474:	4505                	li	a0,1
ffffffffc0201476:	58b000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc020147a:	89aa                	mv	s3,a0
ffffffffc020147c:	26050263          	beqz	a0,ffffffffc02016e0 <default_check+0x382>
ffffffffc0201480:	4505                	li	a0,1
ffffffffc0201482:	57f000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201486:	8aaa                	mv	s5,a0
ffffffffc0201488:	3a050c63          	beqz	a0,ffffffffc0201840 <default_check+0x4e2>
ffffffffc020148c:	4505                	li	a0,1
ffffffffc020148e:	573000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201492:	8a2a                	mv	s4,a0
ffffffffc0201494:	38050663          	beqz	a0,ffffffffc0201820 <default_check+0x4c2>
ffffffffc0201498:	4505                	li	a0,1
ffffffffc020149a:	567000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc020149e:	36051163          	bnez	a0,ffffffffc0201800 <default_check+0x4a2>
ffffffffc02014a2:	4585                	li	a1,1
ffffffffc02014a4:	854e                	mv	a0,s3
ffffffffc02014a6:	599000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02014aa:	641c                	ld	a5,8(s0)
ffffffffc02014ac:	20878a63          	beq	a5,s0,ffffffffc02016c0 <default_check+0x362>
ffffffffc02014b0:	4505                	li	a0,1
ffffffffc02014b2:	54f000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02014b6:	30a99563          	bne	s3,a0,ffffffffc02017c0 <default_check+0x462>
ffffffffc02014ba:	4505                	li	a0,1
ffffffffc02014bc:	545000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02014c0:	2e051063          	bnez	a0,ffffffffc02017a0 <default_check+0x442>
ffffffffc02014c4:	481c                	lw	a5,16(s0)
ffffffffc02014c6:	2a079d63          	bnez	a5,ffffffffc0201780 <default_check+0x422>
ffffffffc02014ca:	854e                	mv	a0,s3
ffffffffc02014cc:	4585                	li	a1,1
ffffffffc02014ce:	01843023          	sd	s8,0(s0)
ffffffffc02014d2:	01743423          	sd	s7,8(s0)
ffffffffc02014d6:	01642823          	sw	s6,16(s0)
ffffffffc02014da:	565000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02014de:	4585                	li	a1,1
ffffffffc02014e0:	8556                	mv	a0,s5
ffffffffc02014e2:	55d000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02014e6:	4585                	li	a1,1
ffffffffc02014e8:	8552                	mv	a0,s4
ffffffffc02014ea:	555000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02014ee:	4515                	li	a0,5
ffffffffc02014f0:	511000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02014f4:	89aa                	mv	s3,a0
ffffffffc02014f6:	26050563          	beqz	a0,ffffffffc0201760 <default_check+0x402>
ffffffffc02014fa:	651c                	ld	a5,8(a0)
ffffffffc02014fc:	8385                	srli	a5,a5,0x1
ffffffffc02014fe:	8b85                	andi	a5,a5,1
ffffffffc0201500:	54079063          	bnez	a5,ffffffffc0201a40 <default_check+0x6e2>
ffffffffc0201504:	4505                	li	a0,1
ffffffffc0201506:	00043b03          	ld	s6,0(s0)
ffffffffc020150a:	00843a83          	ld	s5,8(s0)
ffffffffc020150e:	e000                	sd	s0,0(s0)
ffffffffc0201510:	e400                	sd	s0,8(s0)
ffffffffc0201512:	4ef000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201516:	50051563          	bnez	a0,ffffffffc0201a20 <default_check+0x6c2>
ffffffffc020151a:	08098a13          	addi	s4,s3,128
ffffffffc020151e:	8552                	mv	a0,s4
ffffffffc0201520:	458d                	li	a1,3
ffffffffc0201522:	01042b83          	lw	s7,16(s0)
ffffffffc0201526:	00090797          	auipc	a5,0x90
ffffffffc020152a:	2807a923          	sw	zero,658(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020152e:	511000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc0201532:	4511                	li	a0,4
ffffffffc0201534:	4cd000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201538:	4c051463          	bnez	a0,ffffffffc0201a00 <default_check+0x6a2>
ffffffffc020153c:	0889b783          	ld	a5,136(s3)
ffffffffc0201540:	8385                	srli	a5,a5,0x1
ffffffffc0201542:	8b85                	andi	a5,a5,1
ffffffffc0201544:	48078e63          	beqz	a5,ffffffffc02019e0 <default_check+0x682>
ffffffffc0201548:	0909a703          	lw	a4,144(s3)
ffffffffc020154c:	478d                	li	a5,3
ffffffffc020154e:	48f71963          	bne	a4,a5,ffffffffc02019e0 <default_check+0x682>
ffffffffc0201552:	450d                	li	a0,3
ffffffffc0201554:	4ad000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201558:	8c2a                	mv	s8,a0
ffffffffc020155a:	46050363          	beqz	a0,ffffffffc02019c0 <default_check+0x662>
ffffffffc020155e:	4505                	li	a0,1
ffffffffc0201560:	4a1000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201564:	42051e63          	bnez	a0,ffffffffc02019a0 <default_check+0x642>
ffffffffc0201568:	418a1c63          	bne	s4,s8,ffffffffc0201980 <default_check+0x622>
ffffffffc020156c:	4585                	li	a1,1
ffffffffc020156e:	854e                	mv	a0,s3
ffffffffc0201570:	4cf000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc0201574:	458d                	li	a1,3
ffffffffc0201576:	8552                	mv	a0,s4
ffffffffc0201578:	4c7000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc020157c:	0089b783          	ld	a5,8(s3)
ffffffffc0201580:	04098c13          	addi	s8,s3,64
ffffffffc0201584:	8385                	srli	a5,a5,0x1
ffffffffc0201586:	8b85                	andi	a5,a5,1
ffffffffc0201588:	3c078c63          	beqz	a5,ffffffffc0201960 <default_check+0x602>
ffffffffc020158c:	0109a703          	lw	a4,16(s3)
ffffffffc0201590:	4785                	li	a5,1
ffffffffc0201592:	3cf71763          	bne	a4,a5,ffffffffc0201960 <default_check+0x602>
ffffffffc0201596:	008a3783          	ld	a5,8(s4)
ffffffffc020159a:	8385                	srli	a5,a5,0x1
ffffffffc020159c:	8b85                	andi	a5,a5,1
ffffffffc020159e:	3a078163          	beqz	a5,ffffffffc0201940 <default_check+0x5e2>
ffffffffc02015a2:	010a2703          	lw	a4,16(s4)
ffffffffc02015a6:	478d                	li	a5,3
ffffffffc02015a8:	38f71c63          	bne	a4,a5,ffffffffc0201940 <default_check+0x5e2>
ffffffffc02015ac:	4505                	li	a0,1
ffffffffc02015ae:	453000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02015b2:	36a99763          	bne	s3,a0,ffffffffc0201920 <default_check+0x5c2>
ffffffffc02015b6:	4585                	li	a1,1
ffffffffc02015b8:	487000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02015bc:	4509                	li	a0,2
ffffffffc02015be:	443000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02015c2:	32aa1f63          	bne	s4,a0,ffffffffc0201900 <default_check+0x5a2>
ffffffffc02015c6:	4589                	li	a1,2
ffffffffc02015c8:	477000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02015cc:	4585                	li	a1,1
ffffffffc02015ce:	8562                	mv	a0,s8
ffffffffc02015d0:	46f000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02015d4:	4515                	li	a0,5
ffffffffc02015d6:	42b000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02015da:	89aa                	mv	s3,a0
ffffffffc02015dc:	48050263          	beqz	a0,ffffffffc0201a60 <default_check+0x702>
ffffffffc02015e0:	4505                	li	a0,1
ffffffffc02015e2:	41f000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc02015e6:	2c051d63          	bnez	a0,ffffffffc02018c0 <default_check+0x562>
ffffffffc02015ea:	481c                	lw	a5,16(s0)
ffffffffc02015ec:	2a079a63          	bnez	a5,ffffffffc02018a0 <default_check+0x542>
ffffffffc02015f0:	4595                	li	a1,5
ffffffffc02015f2:	854e                	mv	a0,s3
ffffffffc02015f4:	01742823          	sw	s7,16(s0)
ffffffffc02015f8:	01643023          	sd	s6,0(s0)
ffffffffc02015fc:	01543423          	sd	s5,8(s0)
ffffffffc0201600:	43f000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc0201604:	641c                	ld	a5,8(s0)
ffffffffc0201606:	00878963          	beq	a5,s0,ffffffffc0201618 <default_check+0x2ba>
ffffffffc020160a:	ff87a703          	lw	a4,-8(a5)
ffffffffc020160e:	679c                	ld	a5,8(a5)
ffffffffc0201610:	397d                	addiw	s2,s2,-1
ffffffffc0201612:	9c99                	subw	s1,s1,a4
ffffffffc0201614:	fe879be3          	bne	a5,s0,ffffffffc020160a <default_check+0x2ac>
ffffffffc0201618:	26091463          	bnez	s2,ffffffffc0201880 <default_check+0x522>
ffffffffc020161c:	46049263          	bnez	s1,ffffffffc0201a80 <default_check+0x722>
ffffffffc0201620:	60a6                	ld	ra,72(sp)
ffffffffc0201622:	6406                	ld	s0,64(sp)
ffffffffc0201624:	74e2                	ld	s1,56(sp)
ffffffffc0201626:	7942                	ld	s2,48(sp)
ffffffffc0201628:	79a2                	ld	s3,40(sp)
ffffffffc020162a:	7a02                	ld	s4,32(sp)
ffffffffc020162c:	6ae2                	ld	s5,24(sp)
ffffffffc020162e:	6b42                	ld	s6,16(sp)
ffffffffc0201630:	6ba2                	ld	s7,8(sp)
ffffffffc0201632:	6c02                	ld	s8,0(sp)
ffffffffc0201634:	6161                	addi	sp,sp,80
ffffffffc0201636:	8082                	ret
ffffffffc0201638:	4981                	li	s3,0
ffffffffc020163a:	4481                	li	s1,0
ffffffffc020163c:	4901                	li	s2,0
ffffffffc020163e:	b38d                	j	ffffffffc02013a0 <default_check+0x42>
ffffffffc0201640:	0000b697          	auipc	a3,0xb
ffffffffc0201644:	f3868693          	addi	a3,a3,-200 # ffffffffc020c578 <commands+0x988>
ffffffffc0201648:	0000a617          	auipc	a2,0xa
ffffffffc020164c:	7b860613          	addi	a2,a2,1976 # ffffffffc020be00 <commands+0x210>
ffffffffc0201650:	0ef00593          	li	a1,239
ffffffffc0201654:	0000b517          	auipc	a0,0xb
ffffffffc0201658:	f3450513          	addi	a0,a0,-204 # ffffffffc020c588 <commands+0x998>
ffffffffc020165c:	e43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201660:	0000b697          	auipc	a3,0xb
ffffffffc0201664:	fc068693          	addi	a3,a3,-64 # ffffffffc020c620 <commands+0xa30>
ffffffffc0201668:	0000a617          	auipc	a2,0xa
ffffffffc020166c:	79860613          	addi	a2,a2,1944 # ffffffffc020be00 <commands+0x210>
ffffffffc0201670:	0bc00593          	li	a1,188
ffffffffc0201674:	0000b517          	auipc	a0,0xb
ffffffffc0201678:	f1450513          	addi	a0,a0,-236 # ffffffffc020c588 <commands+0x998>
ffffffffc020167c:	e23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201680:	0000b697          	auipc	a3,0xb
ffffffffc0201684:	fc868693          	addi	a3,a3,-56 # ffffffffc020c648 <commands+0xa58>
ffffffffc0201688:	0000a617          	auipc	a2,0xa
ffffffffc020168c:	77860613          	addi	a2,a2,1912 # ffffffffc020be00 <commands+0x210>
ffffffffc0201690:	0bd00593          	li	a1,189
ffffffffc0201694:	0000b517          	auipc	a0,0xb
ffffffffc0201698:	ef450513          	addi	a0,a0,-268 # ffffffffc020c588 <commands+0x998>
ffffffffc020169c:	e03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016a0:	0000b697          	auipc	a3,0xb
ffffffffc02016a4:	fe868693          	addi	a3,a3,-24 # ffffffffc020c688 <commands+0xa98>
ffffffffc02016a8:	0000a617          	auipc	a2,0xa
ffffffffc02016ac:	75860613          	addi	a2,a2,1880 # ffffffffc020be00 <commands+0x210>
ffffffffc02016b0:	0bf00593          	li	a1,191
ffffffffc02016b4:	0000b517          	auipc	a0,0xb
ffffffffc02016b8:	ed450513          	addi	a0,a0,-300 # ffffffffc020c588 <commands+0x998>
ffffffffc02016bc:	de3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016c0:	0000b697          	auipc	a3,0xb
ffffffffc02016c4:	05068693          	addi	a3,a3,80 # ffffffffc020c710 <commands+0xb20>
ffffffffc02016c8:	0000a617          	auipc	a2,0xa
ffffffffc02016cc:	73860613          	addi	a2,a2,1848 # ffffffffc020be00 <commands+0x210>
ffffffffc02016d0:	0d800593          	li	a1,216
ffffffffc02016d4:	0000b517          	auipc	a0,0xb
ffffffffc02016d8:	eb450513          	addi	a0,a0,-332 # ffffffffc020c588 <commands+0x998>
ffffffffc02016dc:	dc3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016e0:	0000b697          	auipc	a3,0xb
ffffffffc02016e4:	ee068693          	addi	a3,a3,-288 # ffffffffc020c5c0 <commands+0x9d0>
ffffffffc02016e8:	0000a617          	auipc	a2,0xa
ffffffffc02016ec:	71860613          	addi	a2,a2,1816 # ffffffffc020be00 <commands+0x210>
ffffffffc02016f0:	0d100593          	li	a1,209
ffffffffc02016f4:	0000b517          	auipc	a0,0xb
ffffffffc02016f8:	e9450513          	addi	a0,a0,-364 # ffffffffc020c588 <commands+0x998>
ffffffffc02016fc:	da3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201700:	0000b697          	auipc	a3,0xb
ffffffffc0201704:	00068693          	mv	a3,a3
ffffffffc0201708:	0000a617          	auipc	a2,0xa
ffffffffc020170c:	6f860613          	addi	a2,a2,1784 # ffffffffc020be00 <commands+0x210>
ffffffffc0201710:	0cf00593          	li	a1,207
ffffffffc0201714:	0000b517          	auipc	a0,0xb
ffffffffc0201718:	e7450513          	addi	a0,a0,-396 # ffffffffc020c588 <commands+0x998>
ffffffffc020171c:	d83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201720:	0000b697          	auipc	a3,0xb
ffffffffc0201724:	fc868693          	addi	a3,a3,-56 # ffffffffc020c6e8 <commands+0xaf8>
ffffffffc0201728:	0000a617          	auipc	a2,0xa
ffffffffc020172c:	6d860613          	addi	a2,a2,1752 # ffffffffc020be00 <commands+0x210>
ffffffffc0201730:	0ca00593          	li	a1,202
ffffffffc0201734:	0000b517          	auipc	a0,0xb
ffffffffc0201738:	e5450513          	addi	a0,a0,-428 # ffffffffc020c588 <commands+0x998>
ffffffffc020173c:	d63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201740:	0000b697          	auipc	a3,0xb
ffffffffc0201744:	f8868693          	addi	a3,a3,-120 # ffffffffc020c6c8 <commands+0xad8>
ffffffffc0201748:	0000a617          	auipc	a2,0xa
ffffffffc020174c:	6b860613          	addi	a2,a2,1720 # ffffffffc020be00 <commands+0x210>
ffffffffc0201750:	0c100593          	li	a1,193
ffffffffc0201754:	0000b517          	auipc	a0,0xb
ffffffffc0201758:	e3450513          	addi	a0,a0,-460 # ffffffffc020c588 <commands+0x998>
ffffffffc020175c:	d43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201760:	0000b697          	auipc	a3,0xb
ffffffffc0201764:	ff868693          	addi	a3,a3,-8 # ffffffffc020c758 <commands+0xb68>
ffffffffc0201768:	0000a617          	auipc	a2,0xa
ffffffffc020176c:	69860613          	addi	a2,a2,1688 # ffffffffc020be00 <commands+0x210>
ffffffffc0201770:	0f700593          	li	a1,247
ffffffffc0201774:	0000b517          	auipc	a0,0xb
ffffffffc0201778:	e1450513          	addi	a0,a0,-492 # ffffffffc020c588 <commands+0x998>
ffffffffc020177c:	d23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201780:	0000b697          	auipc	a3,0xb
ffffffffc0201784:	fc868693          	addi	a3,a3,-56 # ffffffffc020c748 <commands+0xb58>
ffffffffc0201788:	0000a617          	auipc	a2,0xa
ffffffffc020178c:	67860613          	addi	a2,a2,1656 # ffffffffc020be00 <commands+0x210>
ffffffffc0201790:	0de00593          	li	a1,222
ffffffffc0201794:	0000b517          	auipc	a0,0xb
ffffffffc0201798:	df450513          	addi	a0,a0,-524 # ffffffffc020c588 <commands+0x998>
ffffffffc020179c:	d03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017a0:	0000b697          	auipc	a3,0xb
ffffffffc02017a4:	f4868693          	addi	a3,a3,-184 # ffffffffc020c6e8 <commands+0xaf8>
ffffffffc02017a8:	0000a617          	auipc	a2,0xa
ffffffffc02017ac:	65860613          	addi	a2,a2,1624 # ffffffffc020be00 <commands+0x210>
ffffffffc02017b0:	0dc00593          	li	a1,220
ffffffffc02017b4:	0000b517          	auipc	a0,0xb
ffffffffc02017b8:	dd450513          	addi	a0,a0,-556 # ffffffffc020c588 <commands+0x998>
ffffffffc02017bc:	ce3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017c0:	0000b697          	auipc	a3,0xb
ffffffffc02017c4:	f6868693          	addi	a3,a3,-152 # ffffffffc020c728 <commands+0xb38>
ffffffffc02017c8:	0000a617          	auipc	a2,0xa
ffffffffc02017cc:	63860613          	addi	a2,a2,1592 # ffffffffc020be00 <commands+0x210>
ffffffffc02017d0:	0db00593          	li	a1,219
ffffffffc02017d4:	0000b517          	auipc	a0,0xb
ffffffffc02017d8:	db450513          	addi	a0,a0,-588 # ffffffffc020c588 <commands+0x998>
ffffffffc02017dc:	cc3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017e0:	0000b697          	auipc	a3,0xb
ffffffffc02017e4:	de068693          	addi	a3,a3,-544 # ffffffffc020c5c0 <commands+0x9d0>
ffffffffc02017e8:	0000a617          	auipc	a2,0xa
ffffffffc02017ec:	61860613          	addi	a2,a2,1560 # ffffffffc020be00 <commands+0x210>
ffffffffc02017f0:	0b800593          	li	a1,184
ffffffffc02017f4:	0000b517          	auipc	a0,0xb
ffffffffc02017f8:	d9450513          	addi	a0,a0,-620 # ffffffffc020c588 <commands+0x998>
ffffffffc02017fc:	ca3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201800:	0000b697          	auipc	a3,0xb
ffffffffc0201804:	ee868693          	addi	a3,a3,-280 # ffffffffc020c6e8 <commands+0xaf8>
ffffffffc0201808:	0000a617          	auipc	a2,0xa
ffffffffc020180c:	5f860613          	addi	a2,a2,1528 # ffffffffc020be00 <commands+0x210>
ffffffffc0201810:	0d500593          	li	a1,213
ffffffffc0201814:	0000b517          	auipc	a0,0xb
ffffffffc0201818:	d7450513          	addi	a0,a0,-652 # ffffffffc020c588 <commands+0x998>
ffffffffc020181c:	c83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201820:	0000b697          	auipc	a3,0xb
ffffffffc0201824:	de068693          	addi	a3,a3,-544 # ffffffffc020c600 <commands+0xa10>
ffffffffc0201828:	0000a617          	auipc	a2,0xa
ffffffffc020182c:	5d860613          	addi	a2,a2,1496 # ffffffffc020be00 <commands+0x210>
ffffffffc0201830:	0d300593          	li	a1,211
ffffffffc0201834:	0000b517          	auipc	a0,0xb
ffffffffc0201838:	d5450513          	addi	a0,a0,-684 # ffffffffc020c588 <commands+0x998>
ffffffffc020183c:	c63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201840:	0000b697          	auipc	a3,0xb
ffffffffc0201844:	da068693          	addi	a3,a3,-608 # ffffffffc020c5e0 <commands+0x9f0>
ffffffffc0201848:	0000a617          	auipc	a2,0xa
ffffffffc020184c:	5b860613          	addi	a2,a2,1464 # ffffffffc020be00 <commands+0x210>
ffffffffc0201850:	0d200593          	li	a1,210
ffffffffc0201854:	0000b517          	auipc	a0,0xb
ffffffffc0201858:	d3450513          	addi	a0,a0,-716 # ffffffffc020c588 <commands+0x998>
ffffffffc020185c:	c43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201860:	0000b697          	auipc	a3,0xb
ffffffffc0201864:	da068693          	addi	a3,a3,-608 # ffffffffc020c600 <commands+0xa10>
ffffffffc0201868:	0000a617          	auipc	a2,0xa
ffffffffc020186c:	59860613          	addi	a2,a2,1432 # ffffffffc020be00 <commands+0x210>
ffffffffc0201870:	0ba00593          	li	a1,186
ffffffffc0201874:	0000b517          	auipc	a0,0xb
ffffffffc0201878:	d1450513          	addi	a0,a0,-748 # ffffffffc020c588 <commands+0x998>
ffffffffc020187c:	c23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201880:	0000b697          	auipc	a3,0xb
ffffffffc0201884:	02868693          	addi	a3,a3,40 # ffffffffc020c8a8 <commands+0xcb8>
ffffffffc0201888:	0000a617          	auipc	a2,0xa
ffffffffc020188c:	57860613          	addi	a2,a2,1400 # ffffffffc020be00 <commands+0x210>
ffffffffc0201890:	12400593          	li	a1,292
ffffffffc0201894:	0000b517          	auipc	a0,0xb
ffffffffc0201898:	cf450513          	addi	a0,a0,-780 # ffffffffc020c588 <commands+0x998>
ffffffffc020189c:	c03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018a0:	0000b697          	auipc	a3,0xb
ffffffffc02018a4:	ea868693          	addi	a3,a3,-344 # ffffffffc020c748 <commands+0xb58>
ffffffffc02018a8:	0000a617          	auipc	a2,0xa
ffffffffc02018ac:	55860613          	addi	a2,a2,1368 # ffffffffc020be00 <commands+0x210>
ffffffffc02018b0:	11900593          	li	a1,281
ffffffffc02018b4:	0000b517          	auipc	a0,0xb
ffffffffc02018b8:	cd450513          	addi	a0,a0,-812 # ffffffffc020c588 <commands+0x998>
ffffffffc02018bc:	be3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018c0:	0000b697          	auipc	a3,0xb
ffffffffc02018c4:	e2868693          	addi	a3,a3,-472 # ffffffffc020c6e8 <commands+0xaf8>
ffffffffc02018c8:	0000a617          	auipc	a2,0xa
ffffffffc02018cc:	53860613          	addi	a2,a2,1336 # ffffffffc020be00 <commands+0x210>
ffffffffc02018d0:	11700593          	li	a1,279
ffffffffc02018d4:	0000b517          	auipc	a0,0xb
ffffffffc02018d8:	cb450513          	addi	a0,a0,-844 # ffffffffc020c588 <commands+0x998>
ffffffffc02018dc:	bc3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018e0:	0000b697          	auipc	a3,0xb
ffffffffc02018e4:	dc868693          	addi	a3,a3,-568 # ffffffffc020c6a8 <commands+0xab8>
ffffffffc02018e8:	0000a617          	auipc	a2,0xa
ffffffffc02018ec:	51860613          	addi	a2,a2,1304 # ffffffffc020be00 <commands+0x210>
ffffffffc02018f0:	0c000593          	li	a1,192
ffffffffc02018f4:	0000b517          	auipc	a0,0xb
ffffffffc02018f8:	c9450513          	addi	a0,a0,-876 # ffffffffc020c588 <commands+0x998>
ffffffffc02018fc:	ba3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201900:	0000b697          	auipc	a3,0xb
ffffffffc0201904:	f6868693          	addi	a3,a3,-152 # ffffffffc020c868 <commands+0xc78>
ffffffffc0201908:	0000a617          	auipc	a2,0xa
ffffffffc020190c:	4f860613          	addi	a2,a2,1272 # ffffffffc020be00 <commands+0x210>
ffffffffc0201910:	11100593          	li	a1,273
ffffffffc0201914:	0000b517          	auipc	a0,0xb
ffffffffc0201918:	c7450513          	addi	a0,a0,-908 # ffffffffc020c588 <commands+0x998>
ffffffffc020191c:	b83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201920:	0000b697          	auipc	a3,0xb
ffffffffc0201924:	f2868693          	addi	a3,a3,-216 # ffffffffc020c848 <commands+0xc58>
ffffffffc0201928:	0000a617          	auipc	a2,0xa
ffffffffc020192c:	4d860613          	addi	a2,a2,1240 # ffffffffc020be00 <commands+0x210>
ffffffffc0201930:	10f00593          	li	a1,271
ffffffffc0201934:	0000b517          	auipc	a0,0xb
ffffffffc0201938:	c5450513          	addi	a0,a0,-940 # ffffffffc020c588 <commands+0x998>
ffffffffc020193c:	b63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201940:	0000b697          	auipc	a3,0xb
ffffffffc0201944:	ee068693          	addi	a3,a3,-288 # ffffffffc020c820 <commands+0xc30>
ffffffffc0201948:	0000a617          	auipc	a2,0xa
ffffffffc020194c:	4b860613          	addi	a2,a2,1208 # ffffffffc020be00 <commands+0x210>
ffffffffc0201950:	10d00593          	li	a1,269
ffffffffc0201954:	0000b517          	auipc	a0,0xb
ffffffffc0201958:	c3450513          	addi	a0,a0,-972 # ffffffffc020c588 <commands+0x998>
ffffffffc020195c:	b43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201960:	0000b697          	auipc	a3,0xb
ffffffffc0201964:	e9868693          	addi	a3,a3,-360 # ffffffffc020c7f8 <commands+0xc08>
ffffffffc0201968:	0000a617          	auipc	a2,0xa
ffffffffc020196c:	49860613          	addi	a2,a2,1176 # ffffffffc020be00 <commands+0x210>
ffffffffc0201970:	10c00593          	li	a1,268
ffffffffc0201974:	0000b517          	auipc	a0,0xb
ffffffffc0201978:	c1450513          	addi	a0,a0,-1004 # ffffffffc020c588 <commands+0x998>
ffffffffc020197c:	b23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201980:	0000b697          	auipc	a3,0xb
ffffffffc0201984:	e6868693          	addi	a3,a3,-408 # ffffffffc020c7e8 <commands+0xbf8>
ffffffffc0201988:	0000a617          	auipc	a2,0xa
ffffffffc020198c:	47860613          	addi	a2,a2,1144 # ffffffffc020be00 <commands+0x210>
ffffffffc0201990:	10700593          	li	a1,263
ffffffffc0201994:	0000b517          	auipc	a0,0xb
ffffffffc0201998:	bf450513          	addi	a0,a0,-1036 # ffffffffc020c588 <commands+0x998>
ffffffffc020199c:	b03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019a0:	0000b697          	auipc	a3,0xb
ffffffffc02019a4:	d4868693          	addi	a3,a3,-696 # ffffffffc020c6e8 <commands+0xaf8>
ffffffffc02019a8:	0000a617          	auipc	a2,0xa
ffffffffc02019ac:	45860613          	addi	a2,a2,1112 # ffffffffc020be00 <commands+0x210>
ffffffffc02019b0:	10600593          	li	a1,262
ffffffffc02019b4:	0000b517          	auipc	a0,0xb
ffffffffc02019b8:	bd450513          	addi	a0,a0,-1068 # ffffffffc020c588 <commands+0x998>
ffffffffc02019bc:	ae3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019c0:	0000b697          	auipc	a3,0xb
ffffffffc02019c4:	e0868693          	addi	a3,a3,-504 # ffffffffc020c7c8 <commands+0xbd8>
ffffffffc02019c8:	0000a617          	auipc	a2,0xa
ffffffffc02019cc:	43860613          	addi	a2,a2,1080 # ffffffffc020be00 <commands+0x210>
ffffffffc02019d0:	10500593          	li	a1,261
ffffffffc02019d4:	0000b517          	auipc	a0,0xb
ffffffffc02019d8:	bb450513          	addi	a0,a0,-1100 # ffffffffc020c588 <commands+0x998>
ffffffffc02019dc:	ac3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019e0:	0000b697          	auipc	a3,0xb
ffffffffc02019e4:	db868693          	addi	a3,a3,-584 # ffffffffc020c798 <commands+0xba8>
ffffffffc02019e8:	0000a617          	auipc	a2,0xa
ffffffffc02019ec:	41860613          	addi	a2,a2,1048 # ffffffffc020be00 <commands+0x210>
ffffffffc02019f0:	10400593          	li	a1,260
ffffffffc02019f4:	0000b517          	auipc	a0,0xb
ffffffffc02019f8:	b9450513          	addi	a0,a0,-1132 # ffffffffc020c588 <commands+0x998>
ffffffffc02019fc:	aa3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a00:	0000b697          	auipc	a3,0xb
ffffffffc0201a04:	d8068693          	addi	a3,a3,-640 # ffffffffc020c780 <commands+0xb90>
ffffffffc0201a08:	0000a617          	auipc	a2,0xa
ffffffffc0201a0c:	3f860613          	addi	a2,a2,1016 # ffffffffc020be00 <commands+0x210>
ffffffffc0201a10:	10300593          	li	a1,259
ffffffffc0201a14:	0000b517          	auipc	a0,0xb
ffffffffc0201a18:	b7450513          	addi	a0,a0,-1164 # ffffffffc020c588 <commands+0x998>
ffffffffc0201a1c:	a83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a20:	0000b697          	auipc	a3,0xb
ffffffffc0201a24:	cc868693          	addi	a3,a3,-824 # ffffffffc020c6e8 <commands+0xaf8>
ffffffffc0201a28:	0000a617          	auipc	a2,0xa
ffffffffc0201a2c:	3d860613          	addi	a2,a2,984 # ffffffffc020be00 <commands+0x210>
ffffffffc0201a30:	0fd00593          	li	a1,253
ffffffffc0201a34:	0000b517          	auipc	a0,0xb
ffffffffc0201a38:	b5450513          	addi	a0,a0,-1196 # ffffffffc020c588 <commands+0x998>
ffffffffc0201a3c:	a63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a40:	0000b697          	auipc	a3,0xb
ffffffffc0201a44:	d2868693          	addi	a3,a3,-728 # ffffffffc020c768 <commands+0xb78>
ffffffffc0201a48:	0000a617          	auipc	a2,0xa
ffffffffc0201a4c:	3b860613          	addi	a2,a2,952 # ffffffffc020be00 <commands+0x210>
ffffffffc0201a50:	0f800593          	li	a1,248
ffffffffc0201a54:	0000b517          	auipc	a0,0xb
ffffffffc0201a58:	b3450513          	addi	a0,a0,-1228 # ffffffffc020c588 <commands+0x998>
ffffffffc0201a5c:	a43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a60:	0000b697          	auipc	a3,0xb
ffffffffc0201a64:	e2868693          	addi	a3,a3,-472 # ffffffffc020c888 <commands+0xc98>
ffffffffc0201a68:	0000a617          	auipc	a2,0xa
ffffffffc0201a6c:	39860613          	addi	a2,a2,920 # ffffffffc020be00 <commands+0x210>
ffffffffc0201a70:	11600593          	li	a1,278
ffffffffc0201a74:	0000b517          	auipc	a0,0xb
ffffffffc0201a78:	b1450513          	addi	a0,a0,-1260 # ffffffffc020c588 <commands+0x998>
ffffffffc0201a7c:	a23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a80:	0000b697          	auipc	a3,0xb
ffffffffc0201a84:	e3868693          	addi	a3,a3,-456 # ffffffffc020c8b8 <commands+0xcc8>
ffffffffc0201a88:	0000a617          	auipc	a2,0xa
ffffffffc0201a8c:	37860613          	addi	a2,a2,888 # ffffffffc020be00 <commands+0x210>
ffffffffc0201a90:	12500593          	li	a1,293
ffffffffc0201a94:	0000b517          	auipc	a0,0xb
ffffffffc0201a98:	af450513          	addi	a0,a0,-1292 # ffffffffc020c588 <commands+0x998>
ffffffffc0201a9c:	a03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201aa0:	0000b697          	auipc	a3,0xb
ffffffffc0201aa4:	b0068693          	addi	a3,a3,-1280 # ffffffffc020c5a0 <commands+0x9b0>
ffffffffc0201aa8:	0000a617          	auipc	a2,0xa
ffffffffc0201aac:	35860613          	addi	a2,a2,856 # ffffffffc020be00 <commands+0x210>
ffffffffc0201ab0:	0f200593          	li	a1,242
ffffffffc0201ab4:	0000b517          	auipc	a0,0xb
ffffffffc0201ab8:	ad450513          	addi	a0,a0,-1324 # ffffffffc020c588 <commands+0x998>
ffffffffc0201abc:	9e3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201ac0:	0000b697          	auipc	a3,0xb
ffffffffc0201ac4:	b2068693          	addi	a3,a3,-1248 # ffffffffc020c5e0 <commands+0x9f0>
ffffffffc0201ac8:	0000a617          	auipc	a2,0xa
ffffffffc0201acc:	33860613          	addi	a2,a2,824 # ffffffffc020be00 <commands+0x210>
ffffffffc0201ad0:	0b900593          	li	a1,185
ffffffffc0201ad4:	0000b517          	auipc	a0,0xb
ffffffffc0201ad8:	ab450513          	addi	a0,a0,-1356 # ffffffffc020c588 <commands+0x998>
ffffffffc0201adc:	9c3fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201ae0 <default_free_pages>:
ffffffffc0201ae0:	1141                	addi	sp,sp,-16
ffffffffc0201ae2:	e406                	sd	ra,8(sp)
ffffffffc0201ae4:	14058463          	beqz	a1,ffffffffc0201c2c <default_free_pages+0x14c>
ffffffffc0201ae8:	00659693          	slli	a3,a1,0x6
ffffffffc0201aec:	96aa                	add	a3,a3,a0
ffffffffc0201aee:	87aa                	mv	a5,a0
ffffffffc0201af0:	02d50263          	beq	a0,a3,ffffffffc0201b14 <default_free_pages+0x34>
ffffffffc0201af4:	6798                	ld	a4,8(a5)
ffffffffc0201af6:	8b05                	andi	a4,a4,1
ffffffffc0201af8:	10071a63          	bnez	a4,ffffffffc0201c0c <default_free_pages+0x12c>
ffffffffc0201afc:	6798                	ld	a4,8(a5)
ffffffffc0201afe:	8b09                	andi	a4,a4,2
ffffffffc0201b00:	10071663          	bnez	a4,ffffffffc0201c0c <default_free_pages+0x12c>
ffffffffc0201b04:	0007b423          	sd	zero,8(a5)
ffffffffc0201b08:	0007a023          	sw	zero,0(a5)
ffffffffc0201b0c:	04078793          	addi	a5,a5,64
ffffffffc0201b10:	fed792e3          	bne	a5,a3,ffffffffc0201af4 <default_free_pages+0x14>
ffffffffc0201b14:	2581                	sext.w	a1,a1
ffffffffc0201b16:	c90c                	sw	a1,16(a0)
ffffffffc0201b18:	00850893          	addi	a7,a0,8
ffffffffc0201b1c:	4789                	li	a5,2
ffffffffc0201b1e:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201b22:	00090697          	auipc	a3,0x90
ffffffffc0201b26:	c8668693          	addi	a3,a3,-890 # ffffffffc02917a8 <free_area>
ffffffffc0201b2a:	4a98                	lw	a4,16(a3)
ffffffffc0201b2c:	669c                	ld	a5,8(a3)
ffffffffc0201b2e:	01850613          	addi	a2,a0,24
ffffffffc0201b32:	9db9                	addw	a1,a1,a4
ffffffffc0201b34:	ca8c                	sw	a1,16(a3)
ffffffffc0201b36:	0ad78463          	beq	a5,a3,ffffffffc0201bde <default_free_pages+0xfe>
ffffffffc0201b3a:	fe878713          	addi	a4,a5,-24
ffffffffc0201b3e:	0006b803          	ld	a6,0(a3)
ffffffffc0201b42:	4581                	li	a1,0
ffffffffc0201b44:	00e56a63          	bltu	a0,a4,ffffffffc0201b58 <default_free_pages+0x78>
ffffffffc0201b48:	6798                	ld	a4,8(a5)
ffffffffc0201b4a:	04d70c63          	beq	a4,a3,ffffffffc0201ba2 <default_free_pages+0xc2>
ffffffffc0201b4e:	87ba                	mv	a5,a4
ffffffffc0201b50:	fe878713          	addi	a4,a5,-24
ffffffffc0201b54:	fee57ae3          	bgeu	a0,a4,ffffffffc0201b48 <default_free_pages+0x68>
ffffffffc0201b58:	c199                	beqz	a1,ffffffffc0201b5e <default_free_pages+0x7e>
ffffffffc0201b5a:	0106b023          	sd	a6,0(a3)
ffffffffc0201b5e:	6398                	ld	a4,0(a5)
ffffffffc0201b60:	e390                	sd	a2,0(a5)
ffffffffc0201b62:	e710                	sd	a2,8(a4)
ffffffffc0201b64:	f11c                	sd	a5,32(a0)
ffffffffc0201b66:	ed18                	sd	a4,24(a0)
ffffffffc0201b68:	00d70d63          	beq	a4,a3,ffffffffc0201b82 <default_free_pages+0xa2>
ffffffffc0201b6c:	ff872583          	lw	a1,-8(a4)
ffffffffc0201b70:	fe870613          	addi	a2,a4,-24
ffffffffc0201b74:	02059813          	slli	a6,a1,0x20
ffffffffc0201b78:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201b7c:	97b2                	add	a5,a5,a2
ffffffffc0201b7e:	02f50c63          	beq	a0,a5,ffffffffc0201bb6 <default_free_pages+0xd6>
ffffffffc0201b82:	711c                	ld	a5,32(a0)
ffffffffc0201b84:	00d78c63          	beq	a5,a3,ffffffffc0201b9c <default_free_pages+0xbc>
ffffffffc0201b88:	4910                	lw	a2,16(a0)
ffffffffc0201b8a:	fe878693          	addi	a3,a5,-24
ffffffffc0201b8e:	02061593          	slli	a1,a2,0x20
ffffffffc0201b92:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b96:	972a                	add	a4,a4,a0
ffffffffc0201b98:	04e68a63          	beq	a3,a4,ffffffffc0201bec <default_free_pages+0x10c>
ffffffffc0201b9c:	60a2                	ld	ra,8(sp)
ffffffffc0201b9e:	0141                	addi	sp,sp,16
ffffffffc0201ba0:	8082                	ret
ffffffffc0201ba2:	e790                	sd	a2,8(a5)
ffffffffc0201ba4:	f114                	sd	a3,32(a0)
ffffffffc0201ba6:	6798                	ld	a4,8(a5)
ffffffffc0201ba8:	ed1c                	sd	a5,24(a0)
ffffffffc0201baa:	02d70763          	beq	a4,a3,ffffffffc0201bd8 <default_free_pages+0xf8>
ffffffffc0201bae:	8832                	mv	a6,a2
ffffffffc0201bb0:	4585                	li	a1,1
ffffffffc0201bb2:	87ba                	mv	a5,a4
ffffffffc0201bb4:	bf71                	j	ffffffffc0201b50 <default_free_pages+0x70>
ffffffffc0201bb6:	491c                	lw	a5,16(a0)
ffffffffc0201bb8:	9dbd                	addw	a1,a1,a5
ffffffffc0201bba:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201bbe:	57f5                	li	a5,-3
ffffffffc0201bc0:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201bc4:	01853803          	ld	a6,24(a0)
ffffffffc0201bc8:	710c                	ld	a1,32(a0)
ffffffffc0201bca:	8532                	mv	a0,a2
ffffffffc0201bcc:	00b83423          	sd	a1,8(a6)
ffffffffc0201bd0:	671c                	ld	a5,8(a4)
ffffffffc0201bd2:	0105b023          	sd	a6,0(a1)
ffffffffc0201bd6:	b77d                	j	ffffffffc0201b84 <default_free_pages+0xa4>
ffffffffc0201bd8:	e290                	sd	a2,0(a3)
ffffffffc0201bda:	873e                	mv	a4,a5
ffffffffc0201bdc:	bf41                	j	ffffffffc0201b6c <default_free_pages+0x8c>
ffffffffc0201bde:	60a2                	ld	ra,8(sp)
ffffffffc0201be0:	e390                	sd	a2,0(a5)
ffffffffc0201be2:	e790                	sd	a2,8(a5)
ffffffffc0201be4:	f11c                	sd	a5,32(a0)
ffffffffc0201be6:	ed1c                	sd	a5,24(a0)
ffffffffc0201be8:	0141                	addi	sp,sp,16
ffffffffc0201bea:	8082                	ret
ffffffffc0201bec:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201bf0:	ff078693          	addi	a3,a5,-16
ffffffffc0201bf4:	9e39                	addw	a2,a2,a4
ffffffffc0201bf6:	c910                	sw	a2,16(a0)
ffffffffc0201bf8:	5775                	li	a4,-3
ffffffffc0201bfa:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201bfe:	6398                	ld	a4,0(a5)
ffffffffc0201c00:	679c                	ld	a5,8(a5)
ffffffffc0201c02:	60a2                	ld	ra,8(sp)
ffffffffc0201c04:	e71c                	sd	a5,8(a4)
ffffffffc0201c06:	e398                	sd	a4,0(a5)
ffffffffc0201c08:	0141                	addi	sp,sp,16
ffffffffc0201c0a:	8082                	ret
ffffffffc0201c0c:	0000b697          	auipc	a3,0xb
ffffffffc0201c10:	cc468693          	addi	a3,a3,-828 # ffffffffc020c8d0 <commands+0xce0>
ffffffffc0201c14:	0000a617          	auipc	a2,0xa
ffffffffc0201c18:	1ec60613          	addi	a2,a2,492 # ffffffffc020be00 <commands+0x210>
ffffffffc0201c1c:	08200593          	li	a1,130
ffffffffc0201c20:	0000b517          	auipc	a0,0xb
ffffffffc0201c24:	96850513          	addi	a0,a0,-1688 # ffffffffc020c588 <commands+0x998>
ffffffffc0201c28:	877fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201c2c:	0000b697          	auipc	a3,0xb
ffffffffc0201c30:	c9c68693          	addi	a3,a3,-868 # ffffffffc020c8c8 <commands+0xcd8>
ffffffffc0201c34:	0000a617          	auipc	a2,0xa
ffffffffc0201c38:	1cc60613          	addi	a2,a2,460 # ffffffffc020be00 <commands+0x210>
ffffffffc0201c3c:	07f00593          	li	a1,127
ffffffffc0201c40:	0000b517          	auipc	a0,0xb
ffffffffc0201c44:	94850513          	addi	a0,a0,-1720 # ffffffffc020c588 <commands+0x998>
ffffffffc0201c48:	857fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c4c <default_alloc_pages>:
ffffffffc0201c4c:	c941                	beqz	a0,ffffffffc0201cdc <default_alloc_pages+0x90>
ffffffffc0201c4e:	00090597          	auipc	a1,0x90
ffffffffc0201c52:	b5a58593          	addi	a1,a1,-1190 # ffffffffc02917a8 <free_area>
ffffffffc0201c56:	0105a803          	lw	a6,16(a1)
ffffffffc0201c5a:	872a                	mv	a4,a0
ffffffffc0201c5c:	02081793          	slli	a5,a6,0x20
ffffffffc0201c60:	9381                	srli	a5,a5,0x20
ffffffffc0201c62:	00a7ee63          	bltu	a5,a0,ffffffffc0201c7e <default_alloc_pages+0x32>
ffffffffc0201c66:	87ae                	mv	a5,a1
ffffffffc0201c68:	a801                	j	ffffffffc0201c78 <default_alloc_pages+0x2c>
ffffffffc0201c6a:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201c6e:	02069613          	slli	a2,a3,0x20
ffffffffc0201c72:	9201                	srli	a2,a2,0x20
ffffffffc0201c74:	00e67763          	bgeu	a2,a4,ffffffffc0201c82 <default_alloc_pages+0x36>
ffffffffc0201c78:	679c                	ld	a5,8(a5)
ffffffffc0201c7a:	feb798e3          	bne	a5,a1,ffffffffc0201c6a <default_alloc_pages+0x1e>
ffffffffc0201c7e:	4501                	li	a0,0
ffffffffc0201c80:	8082                	ret
ffffffffc0201c82:	0007b883          	ld	a7,0(a5)
ffffffffc0201c86:	0087b303          	ld	t1,8(a5)
ffffffffc0201c8a:	fe878513          	addi	a0,a5,-24
ffffffffc0201c8e:	00070e1b          	sext.w	t3,a4
ffffffffc0201c92:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c96:	01133023          	sd	a7,0(t1)
ffffffffc0201c9a:	02c77863          	bgeu	a4,a2,ffffffffc0201cca <default_alloc_pages+0x7e>
ffffffffc0201c9e:	071a                	slli	a4,a4,0x6
ffffffffc0201ca0:	972a                	add	a4,a4,a0
ffffffffc0201ca2:	41c686bb          	subw	a3,a3,t3
ffffffffc0201ca6:	cb14                	sw	a3,16(a4)
ffffffffc0201ca8:	00870613          	addi	a2,a4,8
ffffffffc0201cac:	4689                	li	a3,2
ffffffffc0201cae:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201cb2:	0088b683          	ld	a3,8(a7)
ffffffffc0201cb6:	01870613          	addi	a2,a4,24
ffffffffc0201cba:	0105a803          	lw	a6,16(a1)
ffffffffc0201cbe:	e290                	sd	a2,0(a3)
ffffffffc0201cc0:	00c8b423          	sd	a2,8(a7)
ffffffffc0201cc4:	f314                	sd	a3,32(a4)
ffffffffc0201cc6:	01173c23          	sd	a7,24(a4)
ffffffffc0201cca:	41c8083b          	subw	a6,a6,t3
ffffffffc0201cce:	0105a823          	sw	a6,16(a1)
ffffffffc0201cd2:	5775                	li	a4,-3
ffffffffc0201cd4:	17c1                	addi	a5,a5,-16
ffffffffc0201cd6:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201cda:	8082                	ret
ffffffffc0201cdc:	1141                	addi	sp,sp,-16
ffffffffc0201cde:	0000b697          	auipc	a3,0xb
ffffffffc0201ce2:	bea68693          	addi	a3,a3,-1046 # ffffffffc020c8c8 <commands+0xcd8>
ffffffffc0201ce6:	0000a617          	auipc	a2,0xa
ffffffffc0201cea:	11a60613          	addi	a2,a2,282 # ffffffffc020be00 <commands+0x210>
ffffffffc0201cee:	06100593          	li	a1,97
ffffffffc0201cf2:	0000b517          	auipc	a0,0xb
ffffffffc0201cf6:	89650513          	addi	a0,a0,-1898 # ffffffffc020c588 <commands+0x998>
ffffffffc0201cfa:	e406                	sd	ra,8(sp)
ffffffffc0201cfc:	fa2fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d00 <default_init_memmap>:
ffffffffc0201d00:	1141                	addi	sp,sp,-16
ffffffffc0201d02:	e406                	sd	ra,8(sp)
ffffffffc0201d04:	c5f1                	beqz	a1,ffffffffc0201dd0 <default_init_memmap+0xd0>
ffffffffc0201d06:	00659693          	slli	a3,a1,0x6
ffffffffc0201d0a:	96aa                	add	a3,a3,a0
ffffffffc0201d0c:	87aa                	mv	a5,a0
ffffffffc0201d0e:	00d50f63          	beq	a0,a3,ffffffffc0201d2c <default_init_memmap+0x2c>
ffffffffc0201d12:	6798                	ld	a4,8(a5)
ffffffffc0201d14:	8b05                	andi	a4,a4,1
ffffffffc0201d16:	cf49                	beqz	a4,ffffffffc0201db0 <default_init_memmap+0xb0>
ffffffffc0201d18:	0007a823          	sw	zero,16(a5)
ffffffffc0201d1c:	0007b423          	sd	zero,8(a5)
ffffffffc0201d20:	0007a023          	sw	zero,0(a5)
ffffffffc0201d24:	04078793          	addi	a5,a5,64
ffffffffc0201d28:	fed795e3          	bne	a5,a3,ffffffffc0201d12 <default_init_memmap+0x12>
ffffffffc0201d2c:	2581                	sext.w	a1,a1
ffffffffc0201d2e:	c90c                	sw	a1,16(a0)
ffffffffc0201d30:	4789                	li	a5,2
ffffffffc0201d32:	00850713          	addi	a4,a0,8
ffffffffc0201d36:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201d3a:	00090697          	auipc	a3,0x90
ffffffffc0201d3e:	a6e68693          	addi	a3,a3,-1426 # ffffffffc02917a8 <free_area>
ffffffffc0201d42:	4a98                	lw	a4,16(a3)
ffffffffc0201d44:	669c                	ld	a5,8(a3)
ffffffffc0201d46:	01850613          	addi	a2,a0,24
ffffffffc0201d4a:	9db9                	addw	a1,a1,a4
ffffffffc0201d4c:	ca8c                	sw	a1,16(a3)
ffffffffc0201d4e:	04d78a63          	beq	a5,a3,ffffffffc0201da2 <default_init_memmap+0xa2>
ffffffffc0201d52:	fe878713          	addi	a4,a5,-24
ffffffffc0201d56:	0006b803          	ld	a6,0(a3)
ffffffffc0201d5a:	4581                	li	a1,0
ffffffffc0201d5c:	00e56a63          	bltu	a0,a4,ffffffffc0201d70 <default_init_memmap+0x70>
ffffffffc0201d60:	6798                	ld	a4,8(a5)
ffffffffc0201d62:	02d70263          	beq	a4,a3,ffffffffc0201d86 <default_init_memmap+0x86>
ffffffffc0201d66:	87ba                	mv	a5,a4
ffffffffc0201d68:	fe878713          	addi	a4,a5,-24
ffffffffc0201d6c:	fee57ae3          	bgeu	a0,a4,ffffffffc0201d60 <default_init_memmap+0x60>
ffffffffc0201d70:	c199                	beqz	a1,ffffffffc0201d76 <default_init_memmap+0x76>
ffffffffc0201d72:	0106b023          	sd	a6,0(a3)
ffffffffc0201d76:	6398                	ld	a4,0(a5)
ffffffffc0201d78:	60a2                	ld	ra,8(sp)
ffffffffc0201d7a:	e390                	sd	a2,0(a5)
ffffffffc0201d7c:	e710                	sd	a2,8(a4)
ffffffffc0201d7e:	f11c                	sd	a5,32(a0)
ffffffffc0201d80:	ed18                	sd	a4,24(a0)
ffffffffc0201d82:	0141                	addi	sp,sp,16
ffffffffc0201d84:	8082                	ret
ffffffffc0201d86:	e790                	sd	a2,8(a5)
ffffffffc0201d88:	f114                	sd	a3,32(a0)
ffffffffc0201d8a:	6798                	ld	a4,8(a5)
ffffffffc0201d8c:	ed1c                	sd	a5,24(a0)
ffffffffc0201d8e:	00d70663          	beq	a4,a3,ffffffffc0201d9a <default_init_memmap+0x9a>
ffffffffc0201d92:	8832                	mv	a6,a2
ffffffffc0201d94:	4585                	li	a1,1
ffffffffc0201d96:	87ba                	mv	a5,a4
ffffffffc0201d98:	bfc1                	j	ffffffffc0201d68 <default_init_memmap+0x68>
ffffffffc0201d9a:	60a2                	ld	ra,8(sp)
ffffffffc0201d9c:	e290                	sd	a2,0(a3)
ffffffffc0201d9e:	0141                	addi	sp,sp,16
ffffffffc0201da0:	8082                	ret
ffffffffc0201da2:	60a2                	ld	ra,8(sp)
ffffffffc0201da4:	e390                	sd	a2,0(a5)
ffffffffc0201da6:	e790                	sd	a2,8(a5)
ffffffffc0201da8:	f11c                	sd	a5,32(a0)
ffffffffc0201daa:	ed1c                	sd	a5,24(a0)
ffffffffc0201dac:	0141                	addi	sp,sp,16
ffffffffc0201dae:	8082                	ret
ffffffffc0201db0:	0000b697          	auipc	a3,0xb
ffffffffc0201db4:	b4868693          	addi	a3,a3,-1208 # ffffffffc020c8f8 <commands+0xd08>
ffffffffc0201db8:	0000a617          	auipc	a2,0xa
ffffffffc0201dbc:	04860613          	addi	a2,a2,72 # ffffffffc020be00 <commands+0x210>
ffffffffc0201dc0:	04800593          	li	a1,72
ffffffffc0201dc4:	0000a517          	auipc	a0,0xa
ffffffffc0201dc8:	7c450513          	addi	a0,a0,1988 # ffffffffc020c588 <commands+0x998>
ffffffffc0201dcc:	ed2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201dd0:	0000b697          	auipc	a3,0xb
ffffffffc0201dd4:	af868693          	addi	a3,a3,-1288 # ffffffffc020c8c8 <commands+0xcd8>
ffffffffc0201dd8:	0000a617          	auipc	a2,0xa
ffffffffc0201ddc:	02860613          	addi	a2,a2,40 # ffffffffc020be00 <commands+0x210>
ffffffffc0201de0:	04500593          	li	a1,69
ffffffffc0201de4:	0000a517          	auipc	a0,0xa
ffffffffc0201de8:	7a450513          	addi	a0,a0,1956 # ffffffffc020c588 <commands+0x998>
ffffffffc0201dec:	eb2fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201df0 <slob_free>:
ffffffffc0201df0:	c94d                	beqz	a0,ffffffffc0201ea2 <slob_free+0xb2>
ffffffffc0201df2:	1141                	addi	sp,sp,-16
ffffffffc0201df4:	e022                	sd	s0,0(sp)
ffffffffc0201df6:	e406                	sd	ra,8(sp)
ffffffffc0201df8:	842a                	mv	s0,a0
ffffffffc0201dfa:	e9c1                	bnez	a1,ffffffffc0201e8a <slob_free+0x9a>
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	ebd9                	bnez	a5,ffffffffc0201e9a <slob_free+0xaa>
ffffffffc0201e06:	0008f617          	auipc	a2,0x8f
ffffffffc0201e0a:	24a60613          	addi	a2,a2,586 # ffffffffc0291050 <slobfree>
ffffffffc0201e0e:	621c                	ld	a5,0(a2)
ffffffffc0201e10:	873e                	mv	a4,a5
ffffffffc0201e12:	679c                	ld	a5,8(a5)
ffffffffc0201e14:	02877a63          	bgeu	a4,s0,ffffffffc0201e48 <slob_free+0x58>
ffffffffc0201e18:	00f46463          	bltu	s0,a5,ffffffffc0201e20 <slob_free+0x30>
ffffffffc0201e1c:	fef76ae3          	bltu	a4,a5,ffffffffc0201e10 <slob_free+0x20>
ffffffffc0201e20:	400c                	lw	a1,0(s0)
ffffffffc0201e22:	00459693          	slli	a3,a1,0x4
ffffffffc0201e26:	96a2                	add	a3,a3,s0
ffffffffc0201e28:	02d78a63          	beq	a5,a3,ffffffffc0201e5c <slob_free+0x6c>
ffffffffc0201e2c:	4314                	lw	a3,0(a4)
ffffffffc0201e2e:	e41c                	sd	a5,8(s0)
ffffffffc0201e30:	00469793          	slli	a5,a3,0x4
ffffffffc0201e34:	97ba                	add	a5,a5,a4
ffffffffc0201e36:	02f40e63          	beq	s0,a5,ffffffffc0201e72 <slob_free+0x82>
ffffffffc0201e3a:	e700                	sd	s0,8(a4)
ffffffffc0201e3c:	e218                	sd	a4,0(a2)
ffffffffc0201e3e:	e129                	bnez	a0,ffffffffc0201e80 <slob_free+0x90>
ffffffffc0201e40:	60a2                	ld	ra,8(sp)
ffffffffc0201e42:	6402                	ld	s0,0(sp)
ffffffffc0201e44:	0141                	addi	sp,sp,16
ffffffffc0201e46:	8082                	ret
ffffffffc0201e48:	fcf764e3          	bltu	a4,a5,ffffffffc0201e10 <slob_free+0x20>
ffffffffc0201e4c:	fcf472e3          	bgeu	s0,a5,ffffffffc0201e10 <slob_free+0x20>
ffffffffc0201e50:	400c                	lw	a1,0(s0)
ffffffffc0201e52:	00459693          	slli	a3,a1,0x4
ffffffffc0201e56:	96a2                	add	a3,a3,s0
ffffffffc0201e58:	fcd79ae3          	bne	a5,a3,ffffffffc0201e2c <slob_free+0x3c>
ffffffffc0201e5c:	4394                	lw	a3,0(a5)
ffffffffc0201e5e:	679c                	ld	a5,8(a5)
ffffffffc0201e60:	9db5                	addw	a1,a1,a3
ffffffffc0201e62:	c00c                	sw	a1,0(s0)
ffffffffc0201e64:	4314                	lw	a3,0(a4)
ffffffffc0201e66:	e41c                	sd	a5,8(s0)
ffffffffc0201e68:	00469793          	slli	a5,a3,0x4
ffffffffc0201e6c:	97ba                	add	a5,a5,a4
ffffffffc0201e6e:	fcf416e3          	bne	s0,a5,ffffffffc0201e3a <slob_free+0x4a>
ffffffffc0201e72:	401c                	lw	a5,0(s0)
ffffffffc0201e74:	640c                	ld	a1,8(s0)
ffffffffc0201e76:	e218                	sd	a4,0(a2)
ffffffffc0201e78:	9ebd                	addw	a3,a3,a5
ffffffffc0201e7a:	c314                	sw	a3,0(a4)
ffffffffc0201e7c:	e70c                	sd	a1,8(a4)
ffffffffc0201e7e:	d169                	beqz	a0,ffffffffc0201e40 <slob_free+0x50>
ffffffffc0201e80:	6402                	ld	s0,0(sp)
ffffffffc0201e82:	60a2                	ld	ra,8(sp)
ffffffffc0201e84:	0141                	addi	sp,sp,16
ffffffffc0201e86:	de7fe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201e8a:	25bd                	addiw	a1,a1,15
ffffffffc0201e8c:	8191                	srli	a1,a1,0x4
ffffffffc0201e8e:	c10c                	sw	a1,0(a0)
ffffffffc0201e90:	100027f3          	csrr	a5,sstatus
ffffffffc0201e94:	8b89                	andi	a5,a5,2
ffffffffc0201e96:	4501                	li	a0,0
ffffffffc0201e98:	d7bd                	beqz	a5,ffffffffc0201e06 <slob_free+0x16>
ffffffffc0201e9a:	dd9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e9e:	4505                	li	a0,1
ffffffffc0201ea0:	b79d                	j	ffffffffc0201e06 <slob_free+0x16>
ffffffffc0201ea2:	8082                	ret

ffffffffc0201ea4 <__slob_get_free_pages.constprop.0>:
ffffffffc0201ea4:	4785                	li	a5,1
ffffffffc0201ea6:	1141                	addi	sp,sp,-16
ffffffffc0201ea8:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201eac:	e406                	sd	ra,8(sp)
ffffffffc0201eae:	352000ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0201eb2:	c91d                	beqz	a0,ffffffffc0201ee8 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201eb4:	00095697          	auipc	a3,0x95
ffffffffc0201eb8:	9f46b683          	ld	a3,-1548(a3) # ffffffffc02968a8 <pages>
ffffffffc0201ebc:	8d15                	sub	a0,a0,a3
ffffffffc0201ebe:	8519                	srai	a0,a0,0x6
ffffffffc0201ec0:	0000e697          	auipc	a3,0xe
ffffffffc0201ec4:	cf86b683          	ld	a3,-776(a3) # ffffffffc020fbb8 <nbase>
ffffffffc0201ec8:	9536                	add	a0,a0,a3
ffffffffc0201eca:	00c51793          	slli	a5,a0,0xc
ffffffffc0201ece:	83b1                	srli	a5,a5,0xc
ffffffffc0201ed0:	00095717          	auipc	a4,0x95
ffffffffc0201ed4:	9d073703          	ld	a4,-1584(a4) # ffffffffc02968a0 <npage>
ffffffffc0201ed8:	0532                	slli	a0,a0,0xc
ffffffffc0201eda:	00e7fa63          	bgeu	a5,a4,ffffffffc0201eee <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201ede:	00095697          	auipc	a3,0x95
ffffffffc0201ee2:	9da6b683          	ld	a3,-1574(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201ee6:	9536                	add	a0,a0,a3
ffffffffc0201ee8:	60a2                	ld	ra,8(sp)
ffffffffc0201eea:	0141                	addi	sp,sp,16
ffffffffc0201eec:	8082                	ret
ffffffffc0201eee:	86aa                	mv	a3,a0
ffffffffc0201ef0:	0000b617          	auipc	a2,0xb
ffffffffc0201ef4:	a6860613          	addi	a2,a2,-1432 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc0201ef8:	07100593          	li	a1,113
ffffffffc0201efc:	0000b517          	auipc	a0,0xb
ffffffffc0201f00:	a8450513          	addi	a0,a0,-1404 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0201f04:	d9afe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f08 <slob_alloc.constprop.0>:
ffffffffc0201f08:	1101                	addi	sp,sp,-32
ffffffffc0201f0a:	ec06                	sd	ra,24(sp)
ffffffffc0201f0c:	e822                	sd	s0,16(sp)
ffffffffc0201f0e:	e426                	sd	s1,8(sp)
ffffffffc0201f10:	e04a                	sd	s2,0(sp)
ffffffffc0201f12:	01050713          	addi	a4,a0,16
ffffffffc0201f16:	6785                	lui	a5,0x1
ffffffffc0201f18:	0cf77363          	bgeu	a4,a5,ffffffffc0201fde <slob_alloc.constprop.0+0xd6>
ffffffffc0201f1c:	00f50493          	addi	s1,a0,15
ffffffffc0201f20:	8091                	srli	s1,s1,0x4
ffffffffc0201f22:	2481                	sext.w	s1,s1
ffffffffc0201f24:	10002673          	csrr	a2,sstatus
ffffffffc0201f28:	8a09                	andi	a2,a2,2
ffffffffc0201f2a:	e25d                	bnez	a2,ffffffffc0201fd0 <slob_alloc.constprop.0+0xc8>
ffffffffc0201f2c:	0008f917          	auipc	s2,0x8f
ffffffffc0201f30:	12490913          	addi	s2,s2,292 # ffffffffc0291050 <slobfree>
ffffffffc0201f34:	00093683          	ld	a3,0(s2)
ffffffffc0201f38:	669c                	ld	a5,8(a3)
ffffffffc0201f3a:	4398                	lw	a4,0(a5)
ffffffffc0201f3c:	08975e63          	bge	a4,s1,ffffffffc0201fd8 <slob_alloc.constprop.0+0xd0>
ffffffffc0201f40:	00f68b63          	beq	a3,a5,ffffffffc0201f56 <slob_alloc.constprop.0+0x4e>
ffffffffc0201f44:	6780                	ld	s0,8(a5)
ffffffffc0201f46:	4018                	lw	a4,0(s0)
ffffffffc0201f48:	02975a63          	bge	a4,s1,ffffffffc0201f7c <slob_alloc.constprop.0+0x74>
ffffffffc0201f4c:	00093683          	ld	a3,0(s2)
ffffffffc0201f50:	87a2                	mv	a5,s0
ffffffffc0201f52:	fef699e3          	bne	a3,a5,ffffffffc0201f44 <slob_alloc.constprop.0+0x3c>
ffffffffc0201f56:	ee31                	bnez	a2,ffffffffc0201fb2 <slob_alloc.constprop.0+0xaa>
ffffffffc0201f58:	4501                	li	a0,0
ffffffffc0201f5a:	f4bff0ef          	jal	ra,ffffffffc0201ea4 <__slob_get_free_pages.constprop.0>
ffffffffc0201f5e:	842a                	mv	s0,a0
ffffffffc0201f60:	cd05                	beqz	a0,ffffffffc0201f98 <slob_alloc.constprop.0+0x90>
ffffffffc0201f62:	6585                	lui	a1,0x1
ffffffffc0201f64:	e8dff0ef          	jal	ra,ffffffffc0201df0 <slob_free>
ffffffffc0201f68:	10002673          	csrr	a2,sstatus
ffffffffc0201f6c:	8a09                	andi	a2,a2,2
ffffffffc0201f6e:	ee05                	bnez	a2,ffffffffc0201fa6 <slob_alloc.constprop.0+0x9e>
ffffffffc0201f70:	00093783          	ld	a5,0(s2)
ffffffffc0201f74:	6780                	ld	s0,8(a5)
ffffffffc0201f76:	4018                	lw	a4,0(s0)
ffffffffc0201f78:	fc974ae3          	blt	a4,s1,ffffffffc0201f4c <slob_alloc.constprop.0+0x44>
ffffffffc0201f7c:	04e48763          	beq	s1,a4,ffffffffc0201fca <slob_alloc.constprop.0+0xc2>
ffffffffc0201f80:	00449693          	slli	a3,s1,0x4
ffffffffc0201f84:	96a2                	add	a3,a3,s0
ffffffffc0201f86:	e794                	sd	a3,8(a5)
ffffffffc0201f88:	640c                	ld	a1,8(s0)
ffffffffc0201f8a:	9f05                	subw	a4,a4,s1
ffffffffc0201f8c:	c298                	sw	a4,0(a3)
ffffffffc0201f8e:	e68c                	sd	a1,8(a3)
ffffffffc0201f90:	c004                	sw	s1,0(s0)
ffffffffc0201f92:	00f93023          	sd	a5,0(s2)
ffffffffc0201f96:	e20d                	bnez	a2,ffffffffc0201fb8 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f98:	60e2                	ld	ra,24(sp)
ffffffffc0201f9a:	8522                	mv	a0,s0
ffffffffc0201f9c:	6442                	ld	s0,16(sp)
ffffffffc0201f9e:	64a2                	ld	s1,8(sp)
ffffffffc0201fa0:	6902                	ld	s2,0(sp)
ffffffffc0201fa2:	6105                	addi	sp,sp,32
ffffffffc0201fa4:	8082                	ret
ffffffffc0201fa6:	ccdfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201faa:	00093783          	ld	a5,0(s2)
ffffffffc0201fae:	4605                	li	a2,1
ffffffffc0201fb0:	b7d1                	j	ffffffffc0201f74 <slob_alloc.constprop.0+0x6c>
ffffffffc0201fb2:	cbbfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201fb6:	b74d                	j	ffffffffc0201f58 <slob_alloc.constprop.0+0x50>
ffffffffc0201fb8:	cb5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201fbc:	60e2                	ld	ra,24(sp)
ffffffffc0201fbe:	8522                	mv	a0,s0
ffffffffc0201fc0:	6442                	ld	s0,16(sp)
ffffffffc0201fc2:	64a2                	ld	s1,8(sp)
ffffffffc0201fc4:	6902                	ld	s2,0(sp)
ffffffffc0201fc6:	6105                	addi	sp,sp,32
ffffffffc0201fc8:	8082                	ret
ffffffffc0201fca:	6418                	ld	a4,8(s0)
ffffffffc0201fcc:	e798                	sd	a4,8(a5)
ffffffffc0201fce:	b7d1                	j	ffffffffc0201f92 <slob_alloc.constprop.0+0x8a>
ffffffffc0201fd0:	ca3fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201fd4:	4605                	li	a2,1
ffffffffc0201fd6:	bf99                	j	ffffffffc0201f2c <slob_alloc.constprop.0+0x24>
ffffffffc0201fd8:	843e                	mv	s0,a5
ffffffffc0201fda:	87b6                	mv	a5,a3
ffffffffc0201fdc:	b745                	j	ffffffffc0201f7c <slob_alloc.constprop.0+0x74>
ffffffffc0201fde:	0000b697          	auipc	a3,0xb
ffffffffc0201fe2:	9b268693          	addi	a3,a3,-1614 # ffffffffc020c990 <default_pmm_manager+0x70>
ffffffffc0201fe6:	0000a617          	auipc	a2,0xa
ffffffffc0201fea:	e1a60613          	addi	a2,a2,-486 # ffffffffc020be00 <commands+0x210>
ffffffffc0201fee:	06300593          	li	a1,99
ffffffffc0201ff2:	0000b517          	auipc	a0,0xb
ffffffffc0201ff6:	9be50513          	addi	a0,a0,-1602 # ffffffffc020c9b0 <default_pmm_manager+0x90>
ffffffffc0201ffa:	ca4fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201ffe <kmalloc_init>:
ffffffffc0201ffe:	1141                	addi	sp,sp,-16
ffffffffc0202000:	0000b517          	auipc	a0,0xb
ffffffffc0202004:	9c850513          	addi	a0,a0,-1592 # ffffffffc020c9c8 <default_pmm_manager+0xa8>
ffffffffc0202008:	e406                	sd	ra,8(sp)
ffffffffc020200a:	99cfe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020200e:	60a2                	ld	ra,8(sp)
ffffffffc0202010:	0000b517          	auipc	a0,0xb
ffffffffc0202014:	9d050513          	addi	a0,a0,-1584 # ffffffffc020c9e0 <default_pmm_manager+0xc0>
ffffffffc0202018:	0141                	addi	sp,sp,16
ffffffffc020201a:	98cfe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc020201e <kallocated>:
ffffffffc020201e:	4501                	li	a0,0
ffffffffc0202020:	8082                	ret

ffffffffc0202022 <kmalloc>:
ffffffffc0202022:	1101                	addi	sp,sp,-32
ffffffffc0202024:	e04a                	sd	s2,0(sp)
ffffffffc0202026:	6905                	lui	s2,0x1
ffffffffc0202028:	e822                	sd	s0,16(sp)
ffffffffc020202a:	ec06                	sd	ra,24(sp)
ffffffffc020202c:	e426                	sd	s1,8(sp)
ffffffffc020202e:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0202032:	842a                	mv	s0,a0
ffffffffc0202034:	04a7f963          	bgeu	a5,a0,ffffffffc0202086 <kmalloc+0x64>
ffffffffc0202038:	4561                	li	a0,24
ffffffffc020203a:	ecfff0ef          	jal	ra,ffffffffc0201f08 <slob_alloc.constprop.0>
ffffffffc020203e:	84aa                	mv	s1,a0
ffffffffc0202040:	c929                	beqz	a0,ffffffffc0202092 <kmalloc+0x70>
ffffffffc0202042:	0004079b          	sext.w	a5,s0
ffffffffc0202046:	4501                	li	a0,0
ffffffffc0202048:	00f95763          	bge	s2,a5,ffffffffc0202056 <kmalloc+0x34>
ffffffffc020204c:	6705                	lui	a4,0x1
ffffffffc020204e:	8785                	srai	a5,a5,0x1
ffffffffc0202050:	2505                	addiw	a0,a0,1
ffffffffc0202052:	fef74ee3          	blt	a4,a5,ffffffffc020204e <kmalloc+0x2c>
ffffffffc0202056:	c088                	sw	a0,0(s1)
ffffffffc0202058:	e4dff0ef          	jal	ra,ffffffffc0201ea4 <__slob_get_free_pages.constprop.0>
ffffffffc020205c:	e488                	sd	a0,8(s1)
ffffffffc020205e:	842a                	mv	s0,a0
ffffffffc0202060:	c525                	beqz	a0,ffffffffc02020c8 <kmalloc+0xa6>
ffffffffc0202062:	100027f3          	csrr	a5,sstatus
ffffffffc0202066:	8b89                	andi	a5,a5,2
ffffffffc0202068:	ef8d                	bnez	a5,ffffffffc02020a2 <kmalloc+0x80>
ffffffffc020206a:	00095797          	auipc	a5,0x95
ffffffffc020206e:	81e78793          	addi	a5,a5,-2018 # ffffffffc0296888 <bigblocks>
ffffffffc0202072:	6398                	ld	a4,0(a5)
ffffffffc0202074:	e384                	sd	s1,0(a5)
ffffffffc0202076:	e898                	sd	a4,16(s1)
ffffffffc0202078:	60e2                	ld	ra,24(sp)
ffffffffc020207a:	8522                	mv	a0,s0
ffffffffc020207c:	6442                	ld	s0,16(sp)
ffffffffc020207e:	64a2                	ld	s1,8(sp)
ffffffffc0202080:	6902                	ld	s2,0(sp)
ffffffffc0202082:	6105                	addi	sp,sp,32
ffffffffc0202084:	8082                	ret
ffffffffc0202086:	0541                	addi	a0,a0,16
ffffffffc0202088:	e81ff0ef          	jal	ra,ffffffffc0201f08 <slob_alloc.constprop.0>
ffffffffc020208c:	01050413          	addi	s0,a0,16
ffffffffc0202090:	f565                	bnez	a0,ffffffffc0202078 <kmalloc+0x56>
ffffffffc0202092:	4401                	li	s0,0
ffffffffc0202094:	60e2                	ld	ra,24(sp)
ffffffffc0202096:	8522                	mv	a0,s0
ffffffffc0202098:	6442                	ld	s0,16(sp)
ffffffffc020209a:	64a2                	ld	s1,8(sp)
ffffffffc020209c:	6902                	ld	s2,0(sp)
ffffffffc020209e:	6105                	addi	sp,sp,32
ffffffffc02020a0:	8082                	ret
ffffffffc02020a2:	bd1fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020a6:	00094797          	auipc	a5,0x94
ffffffffc02020aa:	7e278793          	addi	a5,a5,2018 # ffffffffc0296888 <bigblocks>
ffffffffc02020ae:	6398                	ld	a4,0(a5)
ffffffffc02020b0:	e384                	sd	s1,0(a5)
ffffffffc02020b2:	e898                	sd	a4,16(s1)
ffffffffc02020b4:	bb9fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020b8:	6480                	ld	s0,8(s1)
ffffffffc02020ba:	60e2                	ld	ra,24(sp)
ffffffffc02020bc:	64a2                	ld	s1,8(sp)
ffffffffc02020be:	8522                	mv	a0,s0
ffffffffc02020c0:	6442                	ld	s0,16(sp)
ffffffffc02020c2:	6902                	ld	s2,0(sp)
ffffffffc02020c4:	6105                	addi	sp,sp,32
ffffffffc02020c6:	8082                	ret
ffffffffc02020c8:	45e1                	li	a1,24
ffffffffc02020ca:	8526                	mv	a0,s1
ffffffffc02020cc:	d25ff0ef          	jal	ra,ffffffffc0201df0 <slob_free>
ffffffffc02020d0:	b765                	j	ffffffffc0202078 <kmalloc+0x56>

ffffffffc02020d2 <kfree>:
ffffffffc02020d2:	c169                	beqz	a0,ffffffffc0202194 <kfree+0xc2>
ffffffffc02020d4:	1101                	addi	sp,sp,-32
ffffffffc02020d6:	e822                	sd	s0,16(sp)
ffffffffc02020d8:	ec06                	sd	ra,24(sp)
ffffffffc02020da:	e426                	sd	s1,8(sp)
ffffffffc02020dc:	03451793          	slli	a5,a0,0x34
ffffffffc02020e0:	842a                	mv	s0,a0
ffffffffc02020e2:	e3d9                	bnez	a5,ffffffffc0202168 <kfree+0x96>
ffffffffc02020e4:	100027f3          	csrr	a5,sstatus
ffffffffc02020e8:	8b89                	andi	a5,a5,2
ffffffffc02020ea:	e7d9                	bnez	a5,ffffffffc0202178 <kfree+0xa6>
ffffffffc02020ec:	00094797          	auipc	a5,0x94
ffffffffc02020f0:	79c7b783          	ld	a5,1948(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020f4:	4601                	li	a2,0
ffffffffc02020f6:	cbad                	beqz	a5,ffffffffc0202168 <kfree+0x96>
ffffffffc02020f8:	00094697          	auipc	a3,0x94
ffffffffc02020fc:	79068693          	addi	a3,a3,1936 # ffffffffc0296888 <bigblocks>
ffffffffc0202100:	a021                	j	ffffffffc0202108 <kfree+0x36>
ffffffffc0202102:	01048693          	addi	a3,s1,16
ffffffffc0202106:	c3a5                	beqz	a5,ffffffffc0202166 <kfree+0x94>
ffffffffc0202108:	6798                	ld	a4,8(a5)
ffffffffc020210a:	84be                	mv	s1,a5
ffffffffc020210c:	6b9c                	ld	a5,16(a5)
ffffffffc020210e:	fe871ae3          	bne	a4,s0,ffffffffc0202102 <kfree+0x30>
ffffffffc0202112:	e29c                	sd	a5,0(a3)
ffffffffc0202114:	ee2d                	bnez	a2,ffffffffc020218e <kfree+0xbc>
ffffffffc0202116:	c02007b7          	lui	a5,0xc0200
ffffffffc020211a:	4098                	lw	a4,0(s1)
ffffffffc020211c:	08f46963          	bltu	s0,a5,ffffffffc02021ae <kfree+0xdc>
ffffffffc0202120:	00094697          	auipc	a3,0x94
ffffffffc0202124:	7986b683          	ld	a3,1944(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202128:	8c15                	sub	s0,s0,a3
ffffffffc020212a:	8031                	srli	s0,s0,0xc
ffffffffc020212c:	00094797          	auipc	a5,0x94
ffffffffc0202130:	7747b783          	ld	a5,1908(a5) # ffffffffc02968a0 <npage>
ffffffffc0202134:	06f47163          	bgeu	s0,a5,ffffffffc0202196 <kfree+0xc4>
ffffffffc0202138:	0000e517          	auipc	a0,0xe
ffffffffc020213c:	a8053503          	ld	a0,-1408(a0) # ffffffffc020fbb8 <nbase>
ffffffffc0202140:	8c09                	sub	s0,s0,a0
ffffffffc0202142:	041a                	slli	s0,s0,0x6
ffffffffc0202144:	00094517          	auipc	a0,0x94
ffffffffc0202148:	76453503          	ld	a0,1892(a0) # ffffffffc02968a8 <pages>
ffffffffc020214c:	4585                	li	a1,1
ffffffffc020214e:	9522                	add	a0,a0,s0
ffffffffc0202150:	00e595bb          	sllw	a1,a1,a4
ffffffffc0202154:	0ea000ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc0202158:	6442                	ld	s0,16(sp)
ffffffffc020215a:	60e2                	ld	ra,24(sp)
ffffffffc020215c:	8526                	mv	a0,s1
ffffffffc020215e:	64a2                	ld	s1,8(sp)
ffffffffc0202160:	45e1                	li	a1,24
ffffffffc0202162:	6105                	addi	sp,sp,32
ffffffffc0202164:	b171                	j	ffffffffc0201df0 <slob_free>
ffffffffc0202166:	e20d                	bnez	a2,ffffffffc0202188 <kfree+0xb6>
ffffffffc0202168:	ff040513          	addi	a0,s0,-16
ffffffffc020216c:	6442                	ld	s0,16(sp)
ffffffffc020216e:	60e2                	ld	ra,24(sp)
ffffffffc0202170:	64a2                	ld	s1,8(sp)
ffffffffc0202172:	4581                	li	a1,0
ffffffffc0202174:	6105                	addi	sp,sp,32
ffffffffc0202176:	b9ad                	j	ffffffffc0201df0 <slob_free>
ffffffffc0202178:	afbfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020217c:	00094797          	auipc	a5,0x94
ffffffffc0202180:	70c7b783          	ld	a5,1804(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202184:	4605                	li	a2,1
ffffffffc0202186:	fbad                	bnez	a5,ffffffffc02020f8 <kfree+0x26>
ffffffffc0202188:	ae5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020218c:	bff1                	j	ffffffffc0202168 <kfree+0x96>
ffffffffc020218e:	adffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202192:	b751                	j	ffffffffc0202116 <kfree+0x44>
ffffffffc0202194:	8082                	ret
ffffffffc0202196:	0000b617          	auipc	a2,0xb
ffffffffc020219a:	89260613          	addi	a2,a2,-1902 # ffffffffc020ca28 <default_pmm_manager+0x108>
ffffffffc020219e:	06900593          	li	a1,105
ffffffffc02021a2:	0000a517          	auipc	a0,0xa
ffffffffc02021a6:	7de50513          	addi	a0,a0,2014 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02021aa:	af4fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02021ae:	86a2                	mv	a3,s0
ffffffffc02021b0:	0000b617          	auipc	a2,0xb
ffffffffc02021b4:	85060613          	addi	a2,a2,-1968 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc02021b8:	07700593          	li	a1,119
ffffffffc02021bc:	0000a517          	auipc	a0,0xa
ffffffffc02021c0:	7c450513          	addi	a0,a0,1988 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02021c4:	adafe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02021c8 <pa2page.part.0>:
ffffffffc02021c8:	1141                	addi	sp,sp,-16
ffffffffc02021ca:	0000b617          	auipc	a2,0xb
ffffffffc02021ce:	85e60613          	addi	a2,a2,-1954 # ffffffffc020ca28 <default_pmm_manager+0x108>
ffffffffc02021d2:	06900593          	li	a1,105
ffffffffc02021d6:	0000a517          	auipc	a0,0xa
ffffffffc02021da:	7aa50513          	addi	a0,a0,1962 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02021de:	e406                	sd	ra,8(sp)
ffffffffc02021e0:	abefe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02021e4 <pte2page.part.0>:
ffffffffc02021e4:	1141                	addi	sp,sp,-16
ffffffffc02021e6:	0000b617          	auipc	a2,0xb
ffffffffc02021ea:	86260613          	addi	a2,a2,-1950 # ffffffffc020ca48 <default_pmm_manager+0x128>
ffffffffc02021ee:	07f00593          	li	a1,127
ffffffffc02021f2:	0000a517          	auipc	a0,0xa
ffffffffc02021f6:	78e50513          	addi	a0,a0,1934 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02021fa:	e406                	sd	ra,8(sp)
ffffffffc02021fc:	aa2fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202200 <alloc_pages>:
ffffffffc0202200:	100027f3          	csrr	a5,sstatus
ffffffffc0202204:	8b89                	andi	a5,a5,2
ffffffffc0202206:	e799                	bnez	a5,ffffffffc0202214 <alloc_pages+0x14>
ffffffffc0202208:	00094797          	auipc	a5,0x94
ffffffffc020220c:	6a87b783          	ld	a5,1704(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202210:	6f9c                	ld	a5,24(a5)
ffffffffc0202212:	8782                	jr	a5
ffffffffc0202214:	1141                	addi	sp,sp,-16
ffffffffc0202216:	e406                	sd	ra,8(sp)
ffffffffc0202218:	e022                	sd	s0,0(sp)
ffffffffc020221a:	842a                	mv	s0,a0
ffffffffc020221c:	a57fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202220:	00094797          	auipc	a5,0x94
ffffffffc0202224:	6907b783          	ld	a5,1680(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202228:	6f9c                	ld	a5,24(a5)
ffffffffc020222a:	8522                	mv	a0,s0
ffffffffc020222c:	9782                	jalr	a5
ffffffffc020222e:	842a                	mv	s0,a0
ffffffffc0202230:	a3dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202234:	60a2                	ld	ra,8(sp)
ffffffffc0202236:	8522                	mv	a0,s0
ffffffffc0202238:	6402                	ld	s0,0(sp)
ffffffffc020223a:	0141                	addi	sp,sp,16
ffffffffc020223c:	8082                	ret

ffffffffc020223e <free_pages>:
ffffffffc020223e:	100027f3          	csrr	a5,sstatus
ffffffffc0202242:	8b89                	andi	a5,a5,2
ffffffffc0202244:	e799                	bnez	a5,ffffffffc0202252 <free_pages+0x14>
ffffffffc0202246:	00094797          	auipc	a5,0x94
ffffffffc020224a:	66a7b783          	ld	a5,1642(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020224e:	739c                	ld	a5,32(a5)
ffffffffc0202250:	8782                	jr	a5
ffffffffc0202252:	1101                	addi	sp,sp,-32
ffffffffc0202254:	ec06                	sd	ra,24(sp)
ffffffffc0202256:	e822                	sd	s0,16(sp)
ffffffffc0202258:	e426                	sd	s1,8(sp)
ffffffffc020225a:	842a                	mv	s0,a0
ffffffffc020225c:	84ae                	mv	s1,a1
ffffffffc020225e:	a15fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202262:	00094797          	auipc	a5,0x94
ffffffffc0202266:	64e7b783          	ld	a5,1614(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020226a:	739c                	ld	a5,32(a5)
ffffffffc020226c:	85a6                	mv	a1,s1
ffffffffc020226e:	8522                	mv	a0,s0
ffffffffc0202270:	9782                	jalr	a5
ffffffffc0202272:	6442                	ld	s0,16(sp)
ffffffffc0202274:	60e2                	ld	ra,24(sp)
ffffffffc0202276:	64a2                	ld	s1,8(sp)
ffffffffc0202278:	6105                	addi	sp,sp,32
ffffffffc020227a:	9f3fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc020227e <nr_free_pages>:
ffffffffc020227e:	100027f3          	csrr	a5,sstatus
ffffffffc0202282:	8b89                	andi	a5,a5,2
ffffffffc0202284:	e799                	bnez	a5,ffffffffc0202292 <nr_free_pages+0x14>
ffffffffc0202286:	00094797          	auipc	a5,0x94
ffffffffc020228a:	62a7b783          	ld	a5,1578(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020228e:	779c                	ld	a5,40(a5)
ffffffffc0202290:	8782                	jr	a5
ffffffffc0202292:	1141                	addi	sp,sp,-16
ffffffffc0202294:	e406                	sd	ra,8(sp)
ffffffffc0202296:	e022                	sd	s0,0(sp)
ffffffffc0202298:	9dbfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020229c:	00094797          	auipc	a5,0x94
ffffffffc02022a0:	6147b783          	ld	a5,1556(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02022a4:	779c                	ld	a5,40(a5)
ffffffffc02022a6:	9782                	jalr	a5
ffffffffc02022a8:	842a                	mv	s0,a0
ffffffffc02022aa:	9c3fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02022ae:	60a2                	ld	ra,8(sp)
ffffffffc02022b0:	8522                	mv	a0,s0
ffffffffc02022b2:	6402                	ld	s0,0(sp)
ffffffffc02022b4:	0141                	addi	sp,sp,16
ffffffffc02022b6:	8082                	ret

ffffffffc02022b8 <get_pte>:
ffffffffc02022b8:	01e5d793          	srli	a5,a1,0x1e
ffffffffc02022bc:	1ff7f793          	andi	a5,a5,511
ffffffffc02022c0:	7139                	addi	sp,sp,-64
ffffffffc02022c2:	078e                	slli	a5,a5,0x3
ffffffffc02022c4:	f426                	sd	s1,40(sp)
ffffffffc02022c6:	00f504b3          	add	s1,a0,a5
ffffffffc02022ca:	6094                	ld	a3,0(s1)
ffffffffc02022cc:	f04a                	sd	s2,32(sp)
ffffffffc02022ce:	ec4e                	sd	s3,24(sp)
ffffffffc02022d0:	e852                	sd	s4,16(sp)
ffffffffc02022d2:	fc06                	sd	ra,56(sp)
ffffffffc02022d4:	f822                	sd	s0,48(sp)
ffffffffc02022d6:	e456                	sd	s5,8(sp)
ffffffffc02022d8:	e05a                	sd	s6,0(sp)
ffffffffc02022da:	0016f793          	andi	a5,a3,1
ffffffffc02022de:	892e                	mv	s2,a1
ffffffffc02022e0:	8a32                	mv	s4,a2
ffffffffc02022e2:	00094997          	auipc	s3,0x94
ffffffffc02022e6:	5be98993          	addi	s3,s3,1470 # ffffffffc02968a0 <npage>
ffffffffc02022ea:	efbd                	bnez	a5,ffffffffc0202368 <get_pte+0xb0>
ffffffffc02022ec:	14060c63          	beqz	a2,ffffffffc0202444 <get_pte+0x18c>
ffffffffc02022f0:	100027f3          	csrr	a5,sstatus
ffffffffc02022f4:	8b89                	andi	a5,a5,2
ffffffffc02022f6:	14079963          	bnez	a5,ffffffffc0202448 <get_pte+0x190>
ffffffffc02022fa:	00094797          	auipc	a5,0x94
ffffffffc02022fe:	5b67b783          	ld	a5,1462(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202302:	6f9c                	ld	a5,24(a5)
ffffffffc0202304:	4505                	li	a0,1
ffffffffc0202306:	9782                	jalr	a5
ffffffffc0202308:	842a                	mv	s0,a0
ffffffffc020230a:	12040d63          	beqz	s0,ffffffffc0202444 <get_pte+0x18c>
ffffffffc020230e:	00094b17          	auipc	s6,0x94
ffffffffc0202312:	59ab0b13          	addi	s6,s6,1434 # ffffffffc02968a8 <pages>
ffffffffc0202316:	000b3503          	ld	a0,0(s6)
ffffffffc020231a:	00080ab7          	lui	s5,0x80
ffffffffc020231e:	00094997          	auipc	s3,0x94
ffffffffc0202322:	58298993          	addi	s3,s3,1410 # ffffffffc02968a0 <npage>
ffffffffc0202326:	40a40533          	sub	a0,s0,a0
ffffffffc020232a:	8519                	srai	a0,a0,0x6
ffffffffc020232c:	9556                	add	a0,a0,s5
ffffffffc020232e:	0009b703          	ld	a4,0(s3)
ffffffffc0202332:	00c51793          	slli	a5,a0,0xc
ffffffffc0202336:	4685                	li	a3,1
ffffffffc0202338:	c014                	sw	a3,0(s0)
ffffffffc020233a:	83b1                	srli	a5,a5,0xc
ffffffffc020233c:	0532                	slli	a0,a0,0xc
ffffffffc020233e:	16e7f763          	bgeu	a5,a4,ffffffffc02024ac <get_pte+0x1f4>
ffffffffc0202342:	00094797          	auipc	a5,0x94
ffffffffc0202346:	5767b783          	ld	a5,1398(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc020234a:	6605                	lui	a2,0x1
ffffffffc020234c:	4581                	li	a1,0
ffffffffc020234e:	953e                	add	a0,a0,a5
ffffffffc0202350:	5c8090ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0202354:	000b3683          	ld	a3,0(s6)
ffffffffc0202358:	40d406b3          	sub	a3,s0,a3
ffffffffc020235c:	8699                	srai	a3,a3,0x6
ffffffffc020235e:	96d6                	add	a3,a3,s5
ffffffffc0202360:	06aa                	slli	a3,a3,0xa
ffffffffc0202362:	0116e693          	ori	a3,a3,17
ffffffffc0202366:	e094                	sd	a3,0(s1)
ffffffffc0202368:	77fd                	lui	a5,0xfffff
ffffffffc020236a:	068a                	slli	a3,a3,0x2
ffffffffc020236c:	0009b703          	ld	a4,0(s3)
ffffffffc0202370:	8efd                	and	a3,a3,a5
ffffffffc0202372:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202376:	10e7ff63          	bgeu	a5,a4,ffffffffc0202494 <get_pte+0x1dc>
ffffffffc020237a:	00094a97          	auipc	s5,0x94
ffffffffc020237e:	53ea8a93          	addi	s5,s5,1342 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202382:	000ab403          	ld	s0,0(s5)
ffffffffc0202386:	01595793          	srli	a5,s2,0x15
ffffffffc020238a:	1ff7f793          	andi	a5,a5,511
ffffffffc020238e:	96a2                	add	a3,a3,s0
ffffffffc0202390:	00379413          	slli	s0,a5,0x3
ffffffffc0202394:	9436                	add	s0,s0,a3
ffffffffc0202396:	6014                	ld	a3,0(s0)
ffffffffc0202398:	0016f793          	andi	a5,a3,1
ffffffffc020239c:	ebad                	bnez	a5,ffffffffc020240e <get_pte+0x156>
ffffffffc020239e:	0a0a0363          	beqz	s4,ffffffffc0202444 <get_pte+0x18c>
ffffffffc02023a2:	100027f3          	csrr	a5,sstatus
ffffffffc02023a6:	8b89                	andi	a5,a5,2
ffffffffc02023a8:	efcd                	bnez	a5,ffffffffc0202462 <get_pte+0x1aa>
ffffffffc02023aa:	00094797          	auipc	a5,0x94
ffffffffc02023ae:	5067b783          	ld	a5,1286(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023b2:	6f9c                	ld	a5,24(a5)
ffffffffc02023b4:	4505                	li	a0,1
ffffffffc02023b6:	9782                	jalr	a5
ffffffffc02023b8:	84aa                	mv	s1,a0
ffffffffc02023ba:	c4c9                	beqz	s1,ffffffffc0202444 <get_pte+0x18c>
ffffffffc02023bc:	00094b17          	auipc	s6,0x94
ffffffffc02023c0:	4ecb0b13          	addi	s6,s6,1260 # ffffffffc02968a8 <pages>
ffffffffc02023c4:	000b3503          	ld	a0,0(s6)
ffffffffc02023c8:	00080a37          	lui	s4,0x80
ffffffffc02023cc:	0009b703          	ld	a4,0(s3)
ffffffffc02023d0:	40a48533          	sub	a0,s1,a0
ffffffffc02023d4:	8519                	srai	a0,a0,0x6
ffffffffc02023d6:	9552                	add	a0,a0,s4
ffffffffc02023d8:	00c51793          	slli	a5,a0,0xc
ffffffffc02023dc:	4685                	li	a3,1
ffffffffc02023de:	c094                	sw	a3,0(s1)
ffffffffc02023e0:	83b1                	srli	a5,a5,0xc
ffffffffc02023e2:	0532                	slli	a0,a0,0xc
ffffffffc02023e4:	0ee7f163          	bgeu	a5,a4,ffffffffc02024c6 <get_pte+0x20e>
ffffffffc02023e8:	000ab783          	ld	a5,0(s5)
ffffffffc02023ec:	6605                	lui	a2,0x1
ffffffffc02023ee:	4581                	li	a1,0
ffffffffc02023f0:	953e                	add	a0,a0,a5
ffffffffc02023f2:	526090ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc02023f6:	000b3683          	ld	a3,0(s6)
ffffffffc02023fa:	40d486b3          	sub	a3,s1,a3
ffffffffc02023fe:	8699                	srai	a3,a3,0x6
ffffffffc0202400:	96d2                	add	a3,a3,s4
ffffffffc0202402:	06aa                	slli	a3,a3,0xa
ffffffffc0202404:	0116e693          	ori	a3,a3,17
ffffffffc0202408:	e014                	sd	a3,0(s0)
ffffffffc020240a:	0009b703          	ld	a4,0(s3)
ffffffffc020240e:	068a                	slli	a3,a3,0x2
ffffffffc0202410:	757d                	lui	a0,0xfffff
ffffffffc0202412:	8ee9                	and	a3,a3,a0
ffffffffc0202414:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202418:	06e7f263          	bgeu	a5,a4,ffffffffc020247c <get_pte+0x1c4>
ffffffffc020241c:	000ab503          	ld	a0,0(s5)
ffffffffc0202420:	00c95913          	srli	s2,s2,0xc
ffffffffc0202424:	1ff97913          	andi	s2,s2,511
ffffffffc0202428:	96aa                	add	a3,a3,a0
ffffffffc020242a:	00391513          	slli	a0,s2,0x3
ffffffffc020242e:	9536                	add	a0,a0,a3
ffffffffc0202430:	70e2                	ld	ra,56(sp)
ffffffffc0202432:	7442                	ld	s0,48(sp)
ffffffffc0202434:	74a2                	ld	s1,40(sp)
ffffffffc0202436:	7902                	ld	s2,32(sp)
ffffffffc0202438:	69e2                	ld	s3,24(sp)
ffffffffc020243a:	6a42                	ld	s4,16(sp)
ffffffffc020243c:	6aa2                	ld	s5,8(sp)
ffffffffc020243e:	6b02                	ld	s6,0(sp)
ffffffffc0202440:	6121                	addi	sp,sp,64
ffffffffc0202442:	8082                	ret
ffffffffc0202444:	4501                	li	a0,0
ffffffffc0202446:	b7ed                	j	ffffffffc0202430 <get_pte+0x178>
ffffffffc0202448:	82bfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020244c:	00094797          	auipc	a5,0x94
ffffffffc0202450:	4647b783          	ld	a5,1124(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202454:	6f9c                	ld	a5,24(a5)
ffffffffc0202456:	4505                	li	a0,1
ffffffffc0202458:	9782                	jalr	a5
ffffffffc020245a:	842a                	mv	s0,a0
ffffffffc020245c:	811fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202460:	b56d                	j	ffffffffc020230a <get_pte+0x52>
ffffffffc0202462:	811fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202466:	00094797          	auipc	a5,0x94
ffffffffc020246a:	44a7b783          	ld	a5,1098(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020246e:	6f9c                	ld	a5,24(a5)
ffffffffc0202470:	4505                	li	a0,1
ffffffffc0202472:	9782                	jalr	a5
ffffffffc0202474:	84aa                	mv	s1,a0
ffffffffc0202476:	ff6fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020247a:	b781                	j	ffffffffc02023ba <get_pte+0x102>
ffffffffc020247c:	0000a617          	auipc	a2,0xa
ffffffffc0202480:	4dc60613          	addi	a2,a2,1244 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc0202484:	13200593          	li	a1,306
ffffffffc0202488:	0000a517          	auipc	a0,0xa
ffffffffc020248c:	5e850513          	addi	a0,a0,1512 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0202490:	80efe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202494:	0000a617          	auipc	a2,0xa
ffffffffc0202498:	4c460613          	addi	a2,a2,1220 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc020249c:	12500593          	li	a1,293
ffffffffc02024a0:	0000a517          	auipc	a0,0xa
ffffffffc02024a4:	5d050513          	addi	a0,a0,1488 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02024a8:	ff7fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024ac:	86aa                	mv	a3,a0
ffffffffc02024ae:	0000a617          	auipc	a2,0xa
ffffffffc02024b2:	4aa60613          	addi	a2,a2,1194 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02024b6:	12100593          	li	a1,289
ffffffffc02024ba:	0000a517          	auipc	a0,0xa
ffffffffc02024be:	5b650513          	addi	a0,a0,1462 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02024c2:	fddfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024c6:	86aa                	mv	a3,a0
ffffffffc02024c8:	0000a617          	auipc	a2,0xa
ffffffffc02024cc:	49060613          	addi	a2,a2,1168 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02024d0:	12f00593          	li	a1,303
ffffffffc02024d4:	0000a517          	auipc	a0,0xa
ffffffffc02024d8:	59c50513          	addi	a0,a0,1436 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02024dc:	fc3fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02024e0 <boot_map_segment>:
ffffffffc02024e0:	6785                	lui	a5,0x1
ffffffffc02024e2:	7139                	addi	sp,sp,-64
ffffffffc02024e4:	00d5c833          	xor	a6,a1,a3
ffffffffc02024e8:	17fd                	addi	a5,a5,-1
ffffffffc02024ea:	fc06                	sd	ra,56(sp)
ffffffffc02024ec:	f822                	sd	s0,48(sp)
ffffffffc02024ee:	f426                	sd	s1,40(sp)
ffffffffc02024f0:	f04a                	sd	s2,32(sp)
ffffffffc02024f2:	ec4e                	sd	s3,24(sp)
ffffffffc02024f4:	e852                	sd	s4,16(sp)
ffffffffc02024f6:	e456                	sd	s5,8(sp)
ffffffffc02024f8:	00f87833          	and	a6,a6,a5
ffffffffc02024fc:	08081563          	bnez	a6,ffffffffc0202586 <boot_map_segment+0xa6>
ffffffffc0202500:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202504:	963e                	add	a2,a2,a5
ffffffffc0202506:	94b2                	add	s1,s1,a2
ffffffffc0202508:	797d                	lui	s2,0xfffff
ffffffffc020250a:	80b1                	srli	s1,s1,0xc
ffffffffc020250c:	0125f5b3          	and	a1,a1,s2
ffffffffc0202510:	0126f6b3          	and	a3,a3,s2
ffffffffc0202514:	c0a1                	beqz	s1,ffffffffc0202554 <boot_map_segment+0x74>
ffffffffc0202516:	00176713          	ori	a4,a4,1
ffffffffc020251a:	04b2                	slli	s1,s1,0xc
ffffffffc020251c:	02071993          	slli	s3,a4,0x20
ffffffffc0202520:	8a2a                	mv	s4,a0
ffffffffc0202522:	842e                	mv	s0,a1
ffffffffc0202524:	94ae                	add	s1,s1,a1
ffffffffc0202526:	40b68933          	sub	s2,a3,a1
ffffffffc020252a:	0209d993          	srli	s3,s3,0x20
ffffffffc020252e:	6a85                	lui	s5,0x1
ffffffffc0202530:	4605                	li	a2,1
ffffffffc0202532:	85a2                	mv	a1,s0
ffffffffc0202534:	8552                	mv	a0,s4
ffffffffc0202536:	d83ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc020253a:	008907b3          	add	a5,s2,s0
ffffffffc020253e:	c505                	beqz	a0,ffffffffc0202566 <boot_map_segment+0x86>
ffffffffc0202540:	83b1                	srli	a5,a5,0xc
ffffffffc0202542:	07aa                	slli	a5,a5,0xa
ffffffffc0202544:	0137e7b3          	or	a5,a5,s3
ffffffffc0202548:	0017e793          	ori	a5,a5,1
ffffffffc020254c:	e11c                	sd	a5,0(a0)
ffffffffc020254e:	9456                	add	s0,s0,s5
ffffffffc0202550:	fe8490e3          	bne	s1,s0,ffffffffc0202530 <boot_map_segment+0x50>
ffffffffc0202554:	70e2                	ld	ra,56(sp)
ffffffffc0202556:	7442                	ld	s0,48(sp)
ffffffffc0202558:	74a2                	ld	s1,40(sp)
ffffffffc020255a:	7902                	ld	s2,32(sp)
ffffffffc020255c:	69e2                	ld	s3,24(sp)
ffffffffc020255e:	6a42                	ld	s4,16(sp)
ffffffffc0202560:	6aa2                	ld	s5,8(sp)
ffffffffc0202562:	6121                	addi	sp,sp,64
ffffffffc0202564:	8082                	ret
ffffffffc0202566:	0000a697          	auipc	a3,0xa
ffffffffc020256a:	53268693          	addi	a3,a3,1330 # ffffffffc020ca98 <default_pmm_manager+0x178>
ffffffffc020256e:	0000a617          	auipc	a2,0xa
ffffffffc0202572:	89260613          	addi	a2,a2,-1902 # ffffffffc020be00 <commands+0x210>
ffffffffc0202576:	09c00593          	li	a1,156
ffffffffc020257a:	0000a517          	auipc	a0,0xa
ffffffffc020257e:	4f650513          	addi	a0,a0,1270 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0202582:	f1dfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202586:	0000a697          	auipc	a3,0xa
ffffffffc020258a:	4fa68693          	addi	a3,a3,1274 # ffffffffc020ca80 <default_pmm_manager+0x160>
ffffffffc020258e:	0000a617          	auipc	a2,0xa
ffffffffc0202592:	87260613          	addi	a2,a2,-1934 # ffffffffc020be00 <commands+0x210>
ffffffffc0202596:	09500593          	li	a1,149
ffffffffc020259a:	0000a517          	auipc	a0,0xa
ffffffffc020259e:	4d650513          	addi	a0,a0,1238 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02025a2:	efdfd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02025a6 <get_page>:
ffffffffc02025a6:	1141                	addi	sp,sp,-16
ffffffffc02025a8:	e022                	sd	s0,0(sp)
ffffffffc02025aa:	8432                	mv	s0,a2
ffffffffc02025ac:	4601                	li	a2,0
ffffffffc02025ae:	e406                	sd	ra,8(sp)
ffffffffc02025b0:	d09ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc02025b4:	c011                	beqz	s0,ffffffffc02025b8 <get_page+0x12>
ffffffffc02025b6:	e008                	sd	a0,0(s0)
ffffffffc02025b8:	c511                	beqz	a0,ffffffffc02025c4 <get_page+0x1e>
ffffffffc02025ba:	611c                	ld	a5,0(a0)
ffffffffc02025bc:	4501                	li	a0,0
ffffffffc02025be:	0017f713          	andi	a4,a5,1
ffffffffc02025c2:	e709                	bnez	a4,ffffffffc02025cc <get_page+0x26>
ffffffffc02025c4:	60a2                	ld	ra,8(sp)
ffffffffc02025c6:	6402                	ld	s0,0(sp)
ffffffffc02025c8:	0141                	addi	sp,sp,16
ffffffffc02025ca:	8082                	ret
ffffffffc02025cc:	078a                	slli	a5,a5,0x2
ffffffffc02025ce:	83b1                	srli	a5,a5,0xc
ffffffffc02025d0:	00094717          	auipc	a4,0x94
ffffffffc02025d4:	2d073703          	ld	a4,720(a4) # ffffffffc02968a0 <npage>
ffffffffc02025d8:	00e7ff63          	bgeu	a5,a4,ffffffffc02025f6 <get_page+0x50>
ffffffffc02025dc:	60a2                	ld	ra,8(sp)
ffffffffc02025de:	6402                	ld	s0,0(sp)
ffffffffc02025e0:	fff80537          	lui	a0,0xfff80
ffffffffc02025e4:	97aa                	add	a5,a5,a0
ffffffffc02025e6:	079a                	slli	a5,a5,0x6
ffffffffc02025e8:	00094517          	auipc	a0,0x94
ffffffffc02025ec:	2c053503          	ld	a0,704(a0) # ffffffffc02968a8 <pages>
ffffffffc02025f0:	953e                	add	a0,a0,a5
ffffffffc02025f2:	0141                	addi	sp,sp,16
ffffffffc02025f4:	8082                	ret
ffffffffc02025f6:	bd3ff0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>

ffffffffc02025fa <unmap_range>:
ffffffffc02025fa:	7159                	addi	sp,sp,-112
ffffffffc02025fc:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202600:	f486                	sd	ra,104(sp)
ffffffffc0202602:	f0a2                	sd	s0,96(sp)
ffffffffc0202604:	eca6                	sd	s1,88(sp)
ffffffffc0202606:	e8ca                	sd	s2,80(sp)
ffffffffc0202608:	e4ce                	sd	s3,72(sp)
ffffffffc020260a:	e0d2                	sd	s4,64(sp)
ffffffffc020260c:	fc56                	sd	s5,56(sp)
ffffffffc020260e:	f85a                	sd	s6,48(sp)
ffffffffc0202610:	f45e                	sd	s7,40(sp)
ffffffffc0202612:	f062                	sd	s8,32(sp)
ffffffffc0202614:	ec66                	sd	s9,24(sp)
ffffffffc0202616:	e86a                	sd	s10,16(sp)
ffffffffc0202618:	17d2                	slli	a5,a5,0x34
ffffffffc020261a:	e3ed                	bnez	a5,ffffffffc02026fc <unmap_range+0x102>
ffffffffc020261c:	002007b7          	lui	a5,0x200
ffffffffc0202620:	842e                	mv	s0,a1
ffffffffc0202622:	0ef5ed63          	bltu	a1,a5,ffffffffc020271c <unmap_range+0x122>
ffffffffc0202626:	8932                	mv	s2,a2
ffffffffc0202628:	0ec5fa63          	bgeu	a1,a2,ffffffffc020271c <unmap_range+0x122>
ffffffffc020262c:	4785                	li	a5,1
ffffffffc020262e:	07fe                	slli	a5,a5,0x1f
ffffffffc0202630:	0ec7e663          	bltu	a5,a2,ffffffffc020271c <unmap_range+0x122>
ffffffffc0202634:	89aa                	mv	s3,a0
ffffffffc0202636:	6a05                	lui	s4,0x1
ffffffffc0202638:	00094c97          	auipc	s9,0x94
ffffffffc020263c:	268c8c93          	addi	s9,s9,616 # ffffffffc02968a0 <npage>
ffffffffc0202640:	00094c17          	auipc	s8,0x94
ffffffffc0202644:	268c0c13          	addi	s8,s8,616 # ffffffffc02968a8 <pages>
ffffffffc0202648:	fff80bb7          	lui	s7,0xfff80
ffffffffc020264c:	00094d17          	auipc	s10,0x94
ffffffffc0202650:	264d0d13          	addi	s10,s10,612 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202654:	00200b37          	lui	s6,0x200
ffffffffc0202658:	ffe00ab7          	lui	s5,0xffe00
ffffffffc020265c:	4601                	li	a2,0
ffffffffc020265e:	85a2                	mv	a1,s0
ffffffffc0202660:	854e                	mv	a0,s3
ffffffffc0202662:	c57ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc0202666:	84aa                	mv	s1,a0
ffffffffc0202668:	cd29                	beqz	a0,ffffffffc02026c2 <unmap_range+0xc8>
ffffffffc020266a:	611c                	ld	a5,0(a0)
ffffffffc020266c:	e395                	bnez	a5,ffffffffc0202690 <unmap_range+0x96>
ffffffffc020266e:	9452                	add	s0,s0,s4
ffffffffc0202670:	ff2466e3          	bltu	s0,s2,ffffffffc020265c <unmap_range+0x62>
ffffffffc0202674:	70a6                	ld	ra,104(sp)
ffffffffc0202676:	7406                	ld	s0,96(sp)
ffffffffc0202678:	64e6                	ld	s1,88(sp)
ffffffffc020267a:	6946                	ld	s2,80(sp)
ffffffffc020267c:	69a6                	ld	s3,72(sp)
ffffffffc020267e:	6a06                	ld	s4,64(sp)
ffffffffc0202680:	7ae2                	ld	s5,56(sp)
ffffffffc0202682:	7b42                	ld	s6,48(sp)
ffffffffc0202684:	7ba2                	ld	s7,40(sp)
ffffffffc0202686:	7c02                	ld	s8,32(sp)
ffffffffc0202688:	6ce2                	ld	s9,24(sp)
ffffffffc020268a:	6d42                	ld	s10,16(sp)
ffffffffc020268c:	6165                	addi	sp,sp,112
ffffffffc020268e:	8082                	ret
ffffffffc0202690:	0017f713          	andi	a4,a5,1
ffffffffc0202694:	df69                	beqz	a4,ffffffffc020266e <unmap_range+0x74>
ffffffffc0202696:	000cb703          	ld	a4,0(s9)
ffffffffc020269a:	078a                	slli	a5,a5,0x2
ffffffffc020269c:	83b1                	srli	a5,a5,0xc
ffffffffc020269e:	08e7ff63          	bgeu	a5,a4,ffffffffc020273c <unmap_range+0x142>
ffffffffc02026a2:	000c3503          	ld	a0,0(s8)
ffffffffc02026a6:	97de                	add	a5,a5,s7
ffffffffc02026a8:	079a                	slli	a5,a5,0x6
ffffffffc02026aa:	953e                	add	a0,a0,a5
ffffffffc02026ac:	411c                	lw	a5,0(a0)
ffffffffc02026ae:	fff7871b          	addiw	a4,a5,-1
ffffffffc02026b2:	c118                	sw	a4,0(a0)
ffffffffc02026b4:	cf11                	beqz	a4,ffffffffc02026d0 <unmap_range+0xd6>
ffffffffc02026b6:	0004b023          	sd	zero,0(s1)
ffffffffc02026ba:	12040073          	sfence.vma	s0
ffffffffc02026be:	9452                	add	s0,s0,s4
ffffffffc02026c0:	bf45                	j	ffffffffc0202670 <unmap_range+0x76>
ffffffffc02026c2:	945a                	add	s0,s0,s6
ffffffffc02026c4:	01547433          	and	s0,s0,s5
ffffffffc02026c8:	d455                	beqz	s0,ffffffffc0202674 <unmap_range+0x7a>
ffffffffc02026ca:	f92469e3          	bltu	s0,s2,ffffffffc020265c <unmap_range+0x62>
ffffffffc02026ce:	b75d                	j	ffffffffc0202674 <unmap_range+0x7a>
ffffffffc02026d0:	100027f3          	csrr	a5,sstatus
ffffffffc02026d4:	8b89                	andi	a5,a5,2
ffffffffc02026d6:	e799                	bnez	a5,ffffffffc02026e4 <unmap_range+0xea>
ffffffffc02026d8:	000d3783          	ld	a5,0(s10)
ffffffffc02026dc:	4585                	li	a1,1
ffffffffc02026de:	739c                	ld	a5,32(a5)
ffffffffc02026e0:	9782                	jalr	a5
ffffffffc02026e2:	bfd1                	j	ffffffffc02026b6 <unmap_range+0xbc>
ffffffffc02026e4:	e42a                	sd	a0,8(sp)
ffffffffc02026e6:	d8cfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02026ea:	000d3783          	ld	a5,0(s10)
ffffffffc02026ee:	6522                	ld	a0,8(sp)
ffffffffc02026f0:	4585                	li	a1,1
ffffffffc02026f2:	739c                	ld	a5,32(a5)
ffffffffc02026f4:	9782                	jalr	a5
ffffffffc02026f6:	d76fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02026fa:	bf75                	j	ffffffffc02026b6 <unmap_range+0xbc>
ffffffffc02026fc:	0000a697          	auipc	a3,0xa
ffffffffc0202700:	3ac68693          	addi	a3,a3,940 # ffffffffc020caa8 <default_pmm_manager+0x188>
ffffffffc0202704:	00009617          	auipc	a2,0x9
ffffffffc0202708:	6fc60613          	addi	a2,a2,1788 # ffffffffc020be00 <commands+0x210>
ffffffffc020270c:	15a00593          	li	a1,346
ffffffffc0202710:	0000a517          	auipc	a0,0xa
ffffffffc0202714:	36050513          	addi	a0,a0,864 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0202718:	d87fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020271c:	0000a697          	auipc	a3,0xa
ffffffffc0202720:	3bc68693          	addi	a3,a3,956 # ffffffffc020cad8 <default_pmm_manager+0x1b8>
ffffffffc0202724:	00009617          	auipc	a2,0x9
ffffffffc0202728:	6dc60613          	addi	a2,a2,1756 # ffffffffc020be00 <commands+0x210>
ffffffffc020272c:	15b00593          	li	a1,347
ffffffffc0202730:	0000a517          	auipc	a0,0xa
ffffffffc0202734:	34050513          	addi	a0,a0,832 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0202738:	d67fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020273c:	a8dff0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>

ffffffffc0202740 <exit_range>:
ffffffffc0202740:	7119                	addi	sp,sp,-128
ffffffffc0202742:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202746:	fc86                	sd	ra,120(sp)
ffffffffc0202748:	f8a2                	sd	s0,112(sp)
ffffffffc020274a:	f4a6                	sd	s1,104(sp)
ffffffffc020274c:	f0ca                	sd	s2,96(sp)
ffffffffc020274e:	ecce                	sd	s3,88(sp)
ffffffffc0202750:	e8d2                	sd	s4,80(sp)
ffffffffc0202752:	e4d6                	sd	s5,72(sp)
ffffffffc0202754:	e0da                	sd	s6,64(sp)
ffffffffc0202756:	fc5e                	sd	s7,56(sp)
ffffffffc0202758:	f862                	sd	s8,48(sp)
ffffffffc020275a:	f466                	sd	s9,40(sp)
ffffffffc020275c:	f06a                	sd	s10,32(sp)
ffffffffc020275e:	ec6e                	sd	s11,24(sp)
ffffffffc0202760:	17d2                	slli	a5,a5,0x34
ffffffffc0202762:	20079a63          	bnez	a5,ffffffffc0202976 <exit_range+0x236>
ffffffffc0202766:	002007b7          	lui	a5,0x200
ffffffffc020276a:	24f5e463          	bltu	a1,a5,ffffffffc02029b2 <exit_range+0x272>
ffffffffc020276e:	8ab2                	mv	s5,a2
ffffffffc0202770:	24c5f163          	bgeu	a1,a2,ffffffffc02029b2 <exit_range+0x272>
ffffffffc0202774:	4785                	li	a5,1
ffffffffc0202776:	07fe                	slli	a5,a5,0x1f
ffffffffc0202778:	22c7ed63          	bltu	a5,a2,ffffffffc02029b2 <exit_range+0x272>
ffffffffc020277c:	c00009b7          	lui	s3,0xc0000
ffffffffc0202780:	0135f9b3          	and	s3,a1,s3
ffffffffc0202784:	ffe00937          	lui	s2,0xffe00
ffffffffc0202788:	400007b7          	lui	a5,0x40000
ffffffffc020278c:	5cfd                	li	s9,-1
ffffffffc020278e:	8c2a                	mv	s8,a0
ffffffffc0202790:	0125f933          	and	s2,a1,s2
ffffffffc0202794:	99be                	add	s3,s3,a5
ffffffffc0202796:	00094d17          	auipc	s10,0x94
ffffffffc020279a:	10ad0d13          	addi	s10,s10,266 # ffffffffc02968a0 <npage>
ffffffffc020279e:	00ccdc93          	srli	s9,s9,0xc
ffffffffc02027a2:	00094717          	auipc	a4,0x94
ffffffffc02027a6:	10670713          	addi	a4,a4,262 # ffffffffc02968a8 <pages>
ffffffffc02027aa:	00094d97          	auipc	s11,0x94
ffffffffc02027ae:	106d8d93          	addi	s11,s11,262 # ffffffffc02968b0 <pmm_manager>
ffffffffc02027b2:	c0000437          	lui	s0,0xc0000
ffffffffc02027b6:	944e                	add	s0,s0,s3
ffffffffc02027b8:	8079                	srli	s0,s0,0x1e
ffffffffc02027ba:	1ff47413          	andi	s0,s0,511
ffffffffc02027be:	040e                	slli	s0,s0,0x3
ffffffffc02027c0:	9462                	add	s0,s0,s8
ffffffffc02027c2:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc02027c6:	001a7793          	andi	a5,s4,1
ffffffffc02027ca:	eb99                	bnez	a5,ffffffffc02027e0 <exit_range+0xa0>
ffffffffc02027cc:	12098463          	beqz	s3,ffffffffc02028f4 <exit_range+0x1b4>
ffffffffc02027d0:	400007b7          	lui	a5,0x40000
ffffffffc02027d4:	97ce                	add	a5,a5,s3
ffffffffc02027d6:	894e                	mv	s2,s3
ffffffffc02027d8:	1159fe63          	bgeu	s3,s5,ffffffffc02028f4 <exit_range+0x1b4>
ffffffffc02027dc:	89be                	mv	s3,a5
ffffffffc02027de:	bfd1                	j	ffffffffc02027b2 <exit_range+0x72>
ffffffffc02027e0:	000d3783          	ld	a5,0(s10)
ffffffffc02027e4:	0a0a                	slli	s4,s4,0x2
ffffffffc02027e6:	00ca5a13          	srli	s4,s4,0xc
ffffffffc02027ea:	1cfa7263          	bgeu	s4,a5,ffffffffc02029ae <exit_range+0x26e>
ffffffffc02027ee:	fff80637          	lui	a2,0xfff80
ffffffffc02027f2:	9652                	add	a2,a2,s4
ffffffffc02027f4:	000806b7          	lui	a3,0x80
ffffffffc02027f8:	96b2                	add	a3,a3,a2
ffffffffc02027fa:	0196f5b3          	and	a1,a3,s9
ffffffffc02027fe:	061a                	slli	a2,a2,0x6
ffffffffc0202800:	06b2                	slli	a3,a3,0xc
ffffffffc0202802:	18f5fa63          	bgeu	a1,a5,ffffffffc0202996 <exit_range+0x256>
ffffffffc0202806:	00094817          	auipc	a6,0x94
ffffffffc020280a:	0b280813          	addi	a6,a6,178 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020280e:	00083b03          	ld	s6,0(a6)
ffffffffc0202812:	4b85                	li	s7,1
ffffffffc0202814:	fff80e37          	lui	t3,0xfff80
ffffffffc0202818:	9b36                	add	s6,s6,a3
ffffffffc020281a:	00080337          	lui	t1,0x80
ffffffffc020281e:	6885                	lui	a7,0x1
ffffffffc0202820:	a819                	j	ffffffffc0202836 <exit_range+0xf6>
ffffffffc0202822:	4b81                	li	s7,0
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	08090c63          	beqz	s2,ffffffffc02028c2 <exit_range+0x182>
ffffffffc020282e:	09397a63          	bgeu	s2,s3,ffffffffc02028c2 <exit_range+0x182>
ffffffffc0202832:	0f597063          	bgeu	s2,s5,ffffffffc0202912 <exit_range+0x1d2>
ffffffffc0202836:	01595493          	srli	s1,s2,0x15
ffffffffc020283a:	1ff4f493          	andi	s1,s1,511
ffffffffc020283e:	048e                	slli	s1,s1,0x3
ffffffffc0202840:	94da                	add	s1,s1,s6
ffffffffc0202842:	609c                	ld	a5,0(s1)
ffffffffc0202844:	0017f693          	andi	a3,a5,1
ffffffffc0202848:	dee9                	beqz	a3,ffffffffc0202822 <exit_range+0xe2>
ffffffffc020284a:	000d3583          	ld	a1,0(s10)
ffffffffc020284e:	078a                	slli	a5,a5,0x2
ffffffffc0202850:	83b1                	srli	a5,a5,0xc
ffffffffc0202852:	14b7fe63          	bgeu	a5,a1,ffffffffc02029ae <exit_range+0x26e>
ffffffffc0202856:	97f2                	add	a5,a5,t3
ffffffffc0202858:	006786b3          	add	a3,a5,t1
ffffffffc020285c:	0196feb3          	and	t4,a3,s9
ffffffffc0202860:	00679513          	slli	a0,a5,0x6
ffffffffc0202864:	06b2                	slli	a3,a3,0xc
ffffffffc0202866:	12bef863          	bgeu	t4,a1,ffffffffc0202996 <exit_range+0x256>
ffffffffc020286a:	00083783          	ld	a5,0(a6)
ffffffffc020286e:	96be                	add	a3,a3,a5
ffffffffc0202870:	011685b3          	add	a1,a3,a7
ffffffffc0202874:	629c                	ld	a5,0(a3)
ffffffffc0202876:	8b85                	andi	a5,a5,1
ffffffffc0202878:	f7d5                	bnez	a5,ffffffffc0202824 <exit_range+0xe4>
ffffffffc020287a:	06a1                	addi	a3,a3,8
ffffffffc020287c:	fed59ce3          	bne	a1,a3,ffffffffc0202874 <exit_range+0x134>
ffffffffc0202880:	631c                	ld	a5,0(a4)
ffffffffc0202882:	953e                	add	a0,a0,a5
ffffffffc0202884:	100027f3          	csrr	a5,sstatus
ffffffffc0202888:	8b89                	andi	a5,a5,2
ffffffffc020288a:	e7d9                	bnez	a5,ffffffffc0202918 <exit_range+0x1d8>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	4585                	li	a1,1
ffffffffc0202892:	e032                	sd	a2,0(sp)
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	6602                	ld	a2,0(sp)
ffffffffc020289a:	00094817          	auipc	a6,0x94
ffffffffc020289e:	01e80813          	addi	a6,a6,30 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02028a2:	fff80e37          	lui	t3,0xfff80
ffffffffc02028a6:	00080337          	lui	t1,0x80
ffffffffc02028aa:	6885                	lui	a7,0x1
ffffffffc02028ac:	00094717          	auipc	a4,0x94
ffffffffc02028b0:	ffc70713          	addi	a4,a4,-4 # ffffffffc02968a8 <pages>
ffffffffc02028b4:	0004b023          	sd	zero,0(s1)
ffffffffc02028b8:	002007b7          	lui	a5,0x200
ffffffffc02028bc:	993e                	add	s2,s2,a5
ffffffffc02028be:	f60918e3          	bnez	s2,ffffffffc020282e <exit_range+0xee>
ffffffffc02028c2:	f00b85e3          	beqz	s7,ffffffffc02027cc <exit_range+0x8c>
ffffffffc02028c6:	000d3783          	ld	a5,0(s10)
ffffffffc02028ca:	0efa7263          	bgeu	s4,a5,ffffffffc02029ae <exit_range+0x26e>
ffffffffc02028ce:	6308                	ld	a0,0(a4)
ffffffffc02028d0:	9532                	add	a0,a0,a2
ffffffffc02028d2:	100027f3          	csrr	a5,sstatus
ffffffffc02028d6:	8b89                	andi	a5,a5,2
ffffffffc02028d8:	efad                	bnez	a5,ffffffffc0202952 <exit_range+0x212>
ffffffffc02028da:	000db783          	ld	a5,0(s11)
ffffffffc02028de:	4585                	li	a1,1
ffffffffc02028e0:	739c                	ld	a5,32(a5)
ffffffffc02028e2:	9782                	jalr	a5
ffffffffc02028e4:	00094717          	auipc	a4,0x94
ffffffffc02028e8:	fc470713          	addi	a4,a4,-60 # ffffffffc02968a8 <pages>
ffffffffc02028ec:	00043023          	sd	zero,0(s0)
ffffffffc02028f0:	ee0990e3          	bnez	s3,ffffffffc02027d0 <exit_range+0x90>
ffffffffc02028f4:	70e6                	ld	ra,120(sp)
ffffffffc02028f6:	7446                	ld	s0,112(sp)
ffffffffc02028f8:	74a6                	ld	s1,104(sp)
ffffffffc02028fa:	7906                	ld	s2,96(sp)
ffffffffc02028fc:	69e6                	ld	s3,88(sp)
ffffffffc02028fe:	6a46                	ld	s4,80(sp)
ffffffffc0202900:	6aa6                	ld	s5,72(sp)
ffffffffc0202902:	6b06                	ld	s6,64(sp)
ffffffffc0202904:	7be2                	ld	s7,56(sp)
ffffffffc0202906:	7c42                	ld	s8,48(sp)
ffffffffc0202908:	7ca2                	ld	s9,40(sp)
ffffffffc020290a:	7d02                	ld	s10,32(sp)
ffffffffc020290c:	6de2                	ld	s11,24(sp)
ffffffffc020290e:	6109                	addi	sp,sp,128
ffffffffc0202910:	8082                	ret
ffffffffc0202912:	ea0b8fe3          	beqz	s7,ffffffffc02027d0 <exit_range+0x90>
ffffffffc0202916:	bf45                	j	ffffffffc02028c6 <exit_range+0x186>
ffffffffc0202918:	e032                	sd	a2,0(sp)
ffffffffc020291a:	e42a                	sd	a0,8(sp)
ffffffffc020291c:	b56fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202920:	000db783          	ld	a5,0(s11)
ffffffffc0202924:	6522                	ld	a0,8(sp)
ffffffffc0202926:	4585                	li	a1,1
ffffffffc0202928:	739c                	ld	a5,32(a5)
ffffffffc020292a:	9782                	jalr	a5
ffffffffc020292c:	b40fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202930:	6602                	ld	a2,0(sp)
ffffffffc0202932:	00094717          	auipc	a4,0x94
ffffffffc0202936:	f7670713          	addi	a4,a4,-138 # ffffffffc02968a8 <pages>
ffffffffc020293a:	6885                	lui	a7,0x1
ffffffffc020293c:	00080337          	lui	t1,0x80
ffffffffc0202940:	fff80e37          	lui	t3,0xfff80
ffffffffc0202944:	00094817          	auipc	a6,0x94
ffffffffc0202948:	f7480813          	addi	a6,a6,-140 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020294c:	0004b023          	sd	zero,0(s1)
ffffffffc0202950:	b7a5                	j	ffffffffc02028b8 <exit_range+0x178>
ffffffffc0202952:	e02a                	sd	a0,0(sp)
ffffffffc0202954:	b1efe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202958:	000db783          	ld	a5,0(s11)
ffffffffc020295c:	6502                	ld	a0,0(sp)
ffffffffc020295e:	4585                	li	a1,1
ffffffffc0202960:	739c                	ld	a5,32(a5)
ffffffffc0202962:	9782                	jalr	a5
ffffffffc0202964:	b08fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202968:	00094717          	auipc	a4,0x94
ffffffffc020296c:	f4070713          	addi	a4,a4,-192 # ffffffffc02968a8 <pages>
ffffffffc0202970:	00043023          	sd	zero,0(s0)
ffffffffc0202974:	bfb5                	j	ffffffffc02028f0 <exit_range+0x1b0>
ffffffffc0202976:	0000a697          	auipc	a3,0xa
ffffffffc020297a:	13268693          	addi	a3,a3,306 # ffffffffc020caa8 <default_pmm_manager+0x188>
ffffffffc020297e:	00009617          	auipc	a2,0x9
ffffffffc0202982:	48260613          	addi	a2,a2,1154 # ffffffffc020be00 <commands+0x210>
ffffffffc0202986:	16f00593          	li	a1,367
ffffffffc020298a:	0000a517          	auipc	a0,0xa
ffffffffc020298e:	0e650513          	addi	a0,a0,230 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0202992:	b0dfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202996:	0000a617          	auipc	a2,0xa
ffffffffc020299a:	fc260613          	addi	a2,a2,-62 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc020299e:	07100593          	li	a1,113
ffffffffc02029a2:	0000a517          	auipc	a0,0xa
ffffffffc02029a6:	fde50513          	addi	a0,a0,-34 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02029aa:	af5fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02029ae:	81bff0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>
ffffffffc02029b2:	0000a697          	auipc	a3,0xa
ffffffffc02029b6:	12668693          	addi	a3,a3,294 # ffffffffc020cad8 <default_pmm_manager+0x1b8>
ffffffffc02029ba:	00009617          	auipc	a2,0x9
ffffffffc02029be:	44660613          	addi	a2,a2,1094 # ffffffffc020be00 <commands+0x210>
ffffffffc02029c2:	17000593          	li	a1,368
ffffffffc02029c6:	0000a517          	auipc	a0,0xa
ffffffffc02029ca:	0aa50513          	addi	a0,a0,170 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02029ce:	ad1fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02029d2 <page_remove>:
ffffffffc02029d2:	7179                	addi	sp,sp,-48
ffffffffc02029d4:	4601                	li	a2,0
ffffffffc02029d6:	ec26                	sd	s1,24(sp)
ffffffffc02029d8:	f406                	sd	ra,40(sp)
ffffffffc02029da:	f022                	sd	s0,32(sp)
ffffffffc02029dc:	84ae                	mv	s1,a1
ffffffffc02029de:	8dbff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc02029e2:	c511                	beqz	a0,ffffffffc02029ee <page_remove+0x1c>
ffffffffc02029e4:	611c                	ld	a5,0(a0)
ffffffffc02029e6:	842a                	mv	s0,a0
ffffffffc02029e8:	0017f713          	andi	a4,a5,1
ffffffffc02029ec:	e711                	bnez	a4,ffffffffc02029f8 <page_remove+0x26>
ffffffffc02029ee:	70a2                	ld	ra,40(sp)
ffffffffc02029f0:	7402                	ld	s0,32(sp)
ffffffffc02029f2:	64e2                	ld	s1,24(sp)
ffffffffc02029f4:	6145                	addi	sp,sp,48
ffffffffc02029f6:	8082                	ret
ffffffffc02029f8:	078a                	slli	a5,a5,0x2
ffffffffc02029fa:	83b1                	srli	a5,a5,0xc
ffffffffc02029fc:	00094717          	auipc	a4,0x94
ffffffffc0202a00:	ea473703          	ld	a4,-348(a4) # ffffffffc02968a0 <npage>
ffffffffc0202a04:	06e7f363          	bgeu	a5,a4,ffffffffc0202a6a <page_remove+0x98>
ffffffffc0202a08:	fff80537          	lui	a0,0xfff80
ffffffffc0202a0c:	97aa                	add	a5,a5,a0
ffffffffc0202a0e:	079a                	slli	a5,a5,0x6
ffffffffc0202a10:	00094517          	auipc	a0,0x94
ffffffffc0202a14:	e9853503          	ld	a0,-360(a0) # ffffffffc02968a8 <pages>
ffffffffc0202a18:	953e                	add	a0,a0,a5
ffffffffc0202a1a:	411c                	lw	a5,0(a0)
ffffffffc0202a1c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202a20:	c118                	sw	a4,0(a0)
ffffffffc0202a22:	cb11                	beqz	a4,ffffffffc0202a36 <page_remove+0x64>
ffffffffc0202a24:	00043023          	sd	zero,0(s0)
ffffffffc0202a28:	12048073          	sfence.vma	s1
ffffffffc0202a2c:	70a2                	ld	ra,40(sp)
ffffffffc0202a2e:	7402                	ld	s0,32(sp)
ffffffffc0202a30:	64e2                	ld	s1,24(sp)
ffffffffc0202a32:	6145                	addi	sp,sp,48
ffffffffc0202a34:	8082                	ret
ffffffffc0202a36:	100027f3          	csrr	a5,sstatus
ffffffffc0202a3a:	8b89                	andi	a5,a5,2
ffffffffc0202a3c:	eb89                	bnez	a5,ffffffffc0202a4e <page_remove+0x7c>
ffffffffc0202a3e:	00094797          	auipc	a5,0x94
ffffffffc0202a42:	e727b783          	ld	a5,-398(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a46:	739c                	ld	a5,32(a5)
ffffffffc0202a48:	4585                	li	a1,1
ffffffffc0202a4a:	9782                	jalr	a5
ffffffffc0202a4c:	bfe1                	j	ffffffffc0202a24 <page_remove+0x52>
ffffffffc0202a4e:	e42a                	sd	a0,8(sp)
ffffffffc0202a50:	a22fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202a54:	00094797          	auipc	a5,0x94
ffffffffc0202a58:	e5c7b783          	ld	a5,-420(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a5c:	739c                	ld	a5,32(a5)
ffffffffc0202a5e:	6522                	ld	a0,8(sp)
ffffffffc0202a60:	4585                	li	a1,1
ffffffffc0202a62:	9782                	jalr	a5
ffffffffc0202a64:	a08fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202a68:	bf75                	j	ffffffffc0202a24 <page_remove+0x52>
ffffffffc0202a6a:	f5eff0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>

ffffffffc0202a6e <page_insert>:
ffffffffc0202a6e:	7139                	addi	sp,sp,-64
ffffffffc0202a70:	e852                	sd	s4,16(sp)
ffffffffc0202a72:	8a32                	mv	s4,a2
ffffffffc0202a74:	f822                	sd	s0,48(sp)
ffffffffc0202a76:	4605                	li	a2,1
ffffffffc0202a78:	842e                	mv	s0,a1
ffffffffc0202a7a:	85d2                	mv	a1,s4
ffffffffc0202a7c:	f426                	sd	s1,40(sp)
ffffffffc0202a7e:	fc06                	sd	ra,56(sp)
ffffffffc0202a80:	f04a                	sd	s2,32(sp)
ffffffffc0202a82:	ec4e                	sd	s3,24(sp)
ffffffffc0202a84:	e456                	sd	s5,8(sp)
ffffffffc0202a86:	84b6                	mv	s1,a3
ffffffffc0202a88:	831ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc0202a8c:	c961                	beqz	a0,ffffffffc0202b5c <page_insert+0xee>
ffffffffc0202a8e:	4014                	lw	a3,0(s0)
ffffffffc0202a90:	611c                	ld	a5,0(a0)
ffffffffc0202a92:	89aa                	mv	s3,a0
ffffffffc0202a94:	0016871b          	addiw	a4,a3,1
ffffffffc0202a98:	c018                	sw	a4,0(s0)
ffffffffc0202a9a:	0017f713          	andi	a4,a5,1
ffffffffc0202a9e:	ef05                	bnez	a4,ffffffffc0202ad6 <page_insert+0x68>
ffffffffc0202aa0:	00094717          	auipc	a4,0x94
ffffffffc0202aa4:	e0873703          	ld	a4,-504(a4) # ffffffffc02968a8 <pages>
ffffffffc0202aa8:	8c19                	sub	s0,s0,a4
ffffffffc0202aaa:	000807b7          	lui	a5,0x80
ffffffffc0202aae:	8419                	srai	s0,s0,0x6
ffffffffc0202ab0:	943e                	add	s0,s0,a5
ffffffffc0202ab2:	042a                	slli	s0,s0,0xa
ffffffffc0202ab4:	8cc1                	or	s1,s1,s0
ffffffffc0202ab6:	0014e493          	ori	s1,s1,1
ffffffffc0202aba:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202abe:	120a0073          	sfence.vma	s4
ffffffffc0202ac2:	4501                	li	a0,0
ffffffffc0202ac4:	70e2                	ld	ra,56(sp)
ffffffffc0202ac6:	7442                	ld	s0,48(sp)
ffffffffc0202ac8:	74a2                	ld	s1,40(sp)
ffffffffc0202aca:	7902                	ld	s2,32(sp)
ffffffffc0202acc:	69e2                	ld	s3,24(sp)
ffffffffc0202ace:	6a42                	ld	s4,16(sp)
ffffffffc0202ad0:	6aa2                	ld	s5,8(sp)
ffffffffc0202ad2:	6121                	addi	sp,sp,64
ffffffffc0202ad4:	8082                	ret
ffffffffc0202ad6:	078a                	slli	a5,a5,0x2
ffffffffc0202ad8:	83b1                	srli	a5,a5,0xc
ffffffffc0202ada:	00094717          	auipc	a4,0x94
ffffffffc0202ade:	dc673703          	ld	a4,-570(a4) # ffffffffc02968a0 <npage>
ffffffffc0202ae2:	06e7ff63          	bgeu	a5,a4,ffffffffc0202b60 <page_insert+0xf2>
ffffffffc0202ae6:	00094a97          	auipc	s5,0x94
ffffffffc0202aea:	dc2a8a93          	addi	s5,s5,-574 # ffffffffc02968a8 <pages>
ffffffffc0202aee:	000ab703          	ld	a4,0(s5)
ffffffffc0202af2:	fff80937          	lui	s2,0xfff80
ffffffffc0202af6:	993e                	add	s2,s2,a5
ffffffffc0202af8:	091a                	slli	s2,s2,0x6
ffffffffc0202afa:	993a                	add	s2,s2,a4
ffffffffc0202afc:	01240c63          	beq	s0,s2,ffffffffc0202b14 <page_insert+0xa6>
ffffffffc0202b00:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202b04:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202b08:	00d92023          	sw	a3,0(s2)
ffffffffc0202b0c:	c691                	beqz	a3,ffffffffc0202b18 <page_insert+0xaa>
ffffffffc0202b0e:	120a0073          	sfence.vma	s4
ffffffffc0202b12:	bf59                	j	ffffffffc0202aa8 <page_insert+0x3a>
ffffffffc0202b14:	c014                	sw	a3,0(s0)
ffffffffc0202b16:	bf49                	j	ffffffffc0202aa8 <page_insert+0x3a>
ffffffffc0202b18:	100027f3          	csrr	a5,sstatus
ffffffffc0202b1c:	8b89                	andi	a5,a5,2
ffffffffc0202b1e:	ef91                	bnez	a5,ffffffffc0202b3a <page_insert+0xcc>
ffffffffc0202b20:	00094797          	auipc	a5,0x94
ffffffffc0202b24:	d907b783          	ld	a5,-624(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b28:	739c                	ld	a5,32(a5)
ffffffffc0202b2a:	4585                	li	a1,1
ffffffffc0202b2c:	854a                	mv	a0,s2
ffffffffc0202b2e:	9782                	jalr	a5
ffffffffc0202b30:	000ab703          	ld	a4,0(s5)
ffffffffc0202b34:	120a0073          	sfence.vma	s4
ffffffffc0202b38:	bf85                	j	ffffffffc0202aa8 <page_insert+0x3a>
ffffffffc0202b3a:	938fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202b3e:	00094797          	auipc	a5,0x94
ffffffffc0202b42:	d727b783          	ld	a5,-654(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b46:	739c                	ld	a5,32(a5)
ffffffffc0202b48:	4585                	li	a1,1
ffffffffc0202b4a:	854a                	mv	a0,s2
ffffffffc0202b4c:	9782                	jalr	a5
ffffffffc0202b4e:	91efe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202b52:	000ab703          	ld	a4,0(s5)
ffffffffc0202b56:	120a0073          	sfence.vma	s4
ffffffffc0202b5a:	b7b9                	j	ffffffffc0202aa8 <page_insert+0x3a>
ffffffffc0202b5c:	5571                	li	a0,-4
ffffffffc0202b5e:	b79d                	j	ffffffffc0202ac4 <page_insert+0x56>
ffffffffc0202b60:	e68ff0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>

ffffffffc0202b64 <pmm_init>:
ffffffffc0202b64:	0000a797          	auipc	a5,0xa
ffffffffc0202b68:	dbc78793          	addi	a5,a5,-580 # ffffffffc020c920 <default_pmm_manager>
ffffffffc0202b6c:	638c                	ld	a1,0(a5)
ffffffffc0202b6e:	7159                	addi	sp,sp,-112
ffffffffc0202b70:	f85a                	sd	s6,48(sp)
ffffffffc0202b72:	0000a517          	auipc	a0,0xa
ffffffffc0202b76:	f7e50513          	addi	a0,a0,-130 # ffffffffc020caf0 <default_pmm_manager+0x1d0>
ffffffffc0202b7a:	00094b17          	auipc	s6,0x94
ffffffffc0202b7e:	d36b0b13          	addi	s6,s6,-714 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b82:	f486                	sd	ra,104(sp)
ffffffffc0202b84:	e8ca                	sd	s2,80(sp)
ffffffffc0202b86:	e4ce                	sd	s3,72(sp)
ffffffffc0202b88:	f0a2                	sd	s0,96(sp)
ffffffffc0202b8a:	eca6                	sd	s1,88(sp)
ffffffffc0202b8c:	e0d2                	sd	s4,64(sp)
ffffffffc0202b8e:	fc56                	sd	s5,56(sp)
ffffffffc0202b90:	f45e                	sd	s7,40(sp)
ffffffffc0202b92:	f062                	sd	s8,32(sp)
ffffffffc0202b94:	ec66                	sd	s9,24(sp)
ffffffffc0202b96:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b9a:	e0cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b9e:	000b3783          	ld	a5,0(s6)
ffffffffc0202ba2:	00094997          	auipc	s3,0x94
ffffffffc0202ba6:	d1698993          	addi	s3,s3,-746 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202baa:	679c                	ld	a5,8(a5)
ffffffffc0202bac:	9782                	jalr	a5
ffffffffc0202bae:	57f5                	li	a5,-3
ffffffffc0202bb0:	07fa                	slli	a5,a5,0x1e
ffffffffc0202bb2:	00f9b023          	sd	a5,0(s3)
ffffffffc0202bb6:	e93fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202bba:	892a                	mv	s2,a0
ffffffffc0202bbc:	e97fd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202bc0:	280502e3          	beqz	a0,ffffffffc0203644 <pmm_init+0xae0>
ffffffffc0202bc4:	84aa                	mv	s1,a0
ffffffffc0202bc6:	0000a517          	auipc	a0,0xa
ffffffffc0202bca:	f6250513          	addi	a0,a0,-158 # ffffffffc020cb28 <default_pmm_manager+0x208>
ffffffffc0202bce:	dd8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bd2:	00990433          	add	s0,s2,s1
ffffffffc0202bd6:	fff40693          	addi	a3,s0,-1
ffffffffc0202bda:	864a                	mv	a2,s2
ffffffffc0202bdc:	85a6                	mv	a1,s1
ffffffffc0202bde:	0000a517          	auipc	a0,0xa
ffffffffc0202be2:	f6250513          	addi	a0,a0,-158 # ffffffffc020cb40 <default_pmm_manager+0x220>
ffffffffc0202be6:	dc0fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bea:	c8000737          	lui	a4,0xc8000
ffffffffc0202bee:	87a2                	mv	a5,s0
ffffffffc0202bf0:	5e876e63          	bltu	a4,s0,ffffffffc02031ec <pmm_init+0x688>
ffffffffc0202bf4:	757d                	lui	a0,0xfffff
ffffffffc0202bf6:	00095617          	auipc	a2,0x95
ffffffffc0202bfa:	d1960613          	addi	a2,a2,-743 # ffffffffc029790f <end+0xfff>
ffffffffc0202bfe:	8e69                	and	a2,a2,a0
ffffffffc0202c00:	00094497          	auipc	s1,0x94
ffffffffc0202c04:	ca048493          	addi	s1,s1,-864 # ffffffffc02968a0 <npage>
ffffffffc0202c08:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202c0c:	00094b97          	auipc	s7,0x94
ffffffffc0202c10:	c9cb8b93          	addi	s7,s7,-868 # ffffffffc02968a8 <pages>
ffffffffc0202c14:	e088                	sd	a0,0(s1)
ffffffffc0202c16:	00cbb023          	sd	a2,0(s7)
ffffffffc0202c1a:	000807b7          	lui	a5,0x80
ffffffffc0202c1e:	86b2                	mv	a3,a2
ffffffffc0202c20:	02f50863          	beq	a0,a5,ffffffffc0202c50 <pmm_init+0xec>
ffffffffc0202c24:	4781                	li	a5,0
ffffffffc0202c26:	4585                	li	a1,1
ffffffffc0202c28:	fff806b7          	lui	a3,0xfff80
ffffffffc0202c2c:	00679513          	slli	a0,a5,0x6
ffffffffc0202c30:	9532                	add	a0,a0,a2
ffffffffc0202c32:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202c36:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202c3a:	6088                	ld	a0,0(s1)
ffffffffc0202c3c:	0785                	addi	a5,a5,1
ffffffffc0202c3e:	000bb603          	ld	a2,0(s7)
ffffffffc0202c42:	00d50733          	add	a4,a0,a3
ffffffffc0202c46:	fee7e3e3          	bltu	a5,a4,ffffffffc0202c2c <pmm_init+0xc8>
ffffffffc0202c4a:	071a                	slli	a4,a4,0x6
ffffffffc0202c4c:	00e606b3          	add	a3,a2,a4
ffffffffc0202c50:	c02007b7          	lui	a5,0xc0200
ffffffffc0202c54:	3af6eae3          	bltu	a3,a5,ffffffffc0203808 <pmm_init+0xca4>
ffffffffc0202c58:	0009b583          	ld	a1,0(s3)
ffffffffc0202c5c:	77fd                	lui	a5,0xfffff
ffffffffc0202c5e:	8c7d                	and	s0,s0,a5
ffffffffc0202c60:	8e8d                	sub	a3,a3,a1
ffffffffc0202c62:	5e86e363          	bltu	a3,s0,ffffffffc0203248 <pmm_init+0x6e4>
ffffffffc0202c66:	0000a517          	auipc	a0,0xa
ffffffffc0202c6a:	f0250513          	addi	a0,a0,-254 # ffffffffc020cb68 <default_pmm_manager+0x248>
ffffffffc0202c6e:	d38fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202c72:	000b3783          	ld	a5,0(s6)
ffffffffc0202c76:	7b9c                	ld	a5,48(a5)
ffffffffc0202c78:	9782                	jalr	a5
ffffffffc0202c7a:	0000a517          	auipc	a0,0xa
ffffffffc0202c7e:	f0650513          	addi	a0,a0,-250 # ffffffffc020cb80 <default_pmm_manager+0x260>
ffffffffc0202c82:	d24fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202c86:	100027f3          	csrr	a5,sstatus
ffffffffc0202c8a:	8b89                	andi	a5,a5,2
ffffffffc0202c8c:	5a079363          	bnez	a5,ffffffffc0203232 <pmm_init+0x6ce>
ffffffffc0202c90:	000b3783          	ld	a5,0(s6)
ffffffffc0202c94:	4505                	li	a0,1
ffffffffc0202c96:	6f9c                	ld	a5,24(a5)
ffffffffc0202c98:	9782                	jalr	a5
ffffffffc0202c9a:	842a                	mv	s0,a0
ffffffffc0202c9c:	180408e3          	beqz	s0,ffffffffc020362c <pmm_init+0xac8>
ffffffffc0202ca0:	000bb683          	ld	a3,0(s7)
ffffffffc0202ca4:	5a7d                	li	s4,-1
ffffffffc0202ca6:	6098                	ld	a4,0(s1)
ffffffffc0202ca8:	40d406b3          	sub	a3,s0,a3
ffffffffc0202cac:	8699                	srai	a3,a3,0x6
ffffffffc0202cae:	00080437          	lui	s0,0x80
ffffffffc0202cb2:	96a2                	add	a3,a3,s0
ffffffffc0202cb4:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202cb8:	8ff5                	and	a5,a5,a3
ffffffffc0202cba:	06b2                	slli	a3,a3,0xc
ffffffffc0202cbc:	30e7fde3          	bgeu	a5,a4,ffffffffc02037d6 <pmm_init+0xc72>
ffffffffc0202cc0:	0009b403          	ld	s0,0(s3)
ffffffffc0202cc4:	6605                	lui	a2,0x1
ffffffffc0202cc6:	4581                	li	a1,0
ffffffffc0202cc8:	9436                	add	s0,s0,a3
ffffffffc0202cca:	8522                	mv	a0,s0
ffffffffc0202ccc:	44d080ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0202cd0:	0009b683          	ld	a3,0(s3)
ffffffffc0202cd4:	77fd                	lui	a5,0xfffff
ffffffffc0202cd6:	0000a917          	auipc	s2,0xa
ffffffffc0202cda:	cab90913          	addi	s2,s2,-853 # ffffffffc020c981 <default_pmm_manager+0x61>
ffffffffc0202cde:	00f97933          	and	s2,s2,a5
ffffffffc0202ce2:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202ce6:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202cea:	964a                	add	a2,a2,s2
ffffffffc0202cec:	4729                	li	a4,10
ffffffffc0202cee:	40da86b3          	sub	a3,s5,a3
ffffffffc0202cf2:	c02005b7          	lui	a1,0xc0200
ffffffffc0202cf6:	8522                	mv	a0,s0
ffffffffc0202cf8:	fe8ff0ef          	jal	ra,ffffffffc02024e0 <boot_map_segment>
ffffffffc0202cfc:	c8000637          	lui	a2,0xc8000
ffffffffc0202d00:	41260633          	sub	a2,a2,s2
ffffffffc0202d04:	3f596ce3          	bltu	s2,s5,ffffffffc02038fc <pmm_init+0xd98>
ffffffffc0202d08:	0009b683          	ld	a3,0(s3)
ffffffffc0202d0c:	85ca                	mv	a1,s2
ffffffffc0202d0e:	4719                	li	a4,6
ffffffffc0202d10:	40d906b3          	sub	a3,s2,a3
ffffffffc0202d14:	8522                	mv	a0,s0
ffffffffc0202d16:	00094917          	auipc	s2,0x94
ffffffffc0202d1a:	b8290913          	addi	s2,s2,-1150 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202d1e:	fc2ff0ef          	jal	ra,ffffffffc02024e0 <boot_map_segment>
ffffffffc0202d22:	00893023          	sd	s0,0(s2)
ffffffffc0202d26:	2d5464e3          	bltu	s0,s5,ffffffffc02037ee <pmm_init+0xc8a>
ffffffffc0202d2a:	0009b783          	ld	a5,0(s3)
ffffffffc0202d2e:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202d30:	8c1d                	sub	s0,s0,a5
ffffffffc0202d32:	00c45793          	srli	a5,s0,0xc
ffffffffc0202d36:	00094717          	auipc	a4,0x94
ffffffffc0202d3a:	b4873d23          	sd	s0,-1190(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202d3e:	0147ea33          	or	s4,a5,s4
ffffffffc0202d42:	180a1073          	csrw	satp,s4
ffffffffc0202d46:	12000073          	sfence.vma
ffffffffc0202d4a:	0000a517          	auipc	a0,0xa
ffffffffc0202d4e:	e7650513          	addi	a0,a0,-394 # ffffffffc020cbc0 <default_pmm_manager+0x2a0>
ffffffffc0202d52:	c54fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202d56:	0000e717          	auipc	a4,0xe
ffffffffc0202d5a:	2aa70713          	addi	a4,a4,682 # ffffffffc0211000 <bootstack>
ffffffffc0202d5e:	0000e797          	auipc	a5,0xe
ffffffffc0202d62:	2a278793          	addi	a5,a5,674 # ffffffffc0211000 <bootstack>
ffffffffc0202d66:	5cf70d63          	beq	a4,a5,ffffffffc0203340 <pmm_init+0x7dc>
ffffffffc0202d6a:	100027f3          	csrr	a5,sstatus
ffffffffc0202d6e:	8b89                	andi	a5,a5,2
ffffffffc0202d70:	4a079763          	bnez	a5,ffffffffc020321e <pmm_init+0x6ba>
ffffffffc0202d74:	000b3783          	ld	a5,0(s6)
ffffffffc0202d78:	779c                	ld	a5,40(a5)
ffffffffc0202d7a:	9782                	jalr	a5
ffffffffc0202d7c:	842a                	mv	s0,a0
ffffffffc0202d7e:	6098                	ld	a4,0(s1)
ffffffffc0202d80:	c80007b7          	lui	a5,0xc8000
ffffffffc0202d84:	83b1                	srli	a5,a5,0xc
ffffffffc0202d86:	08e7e3e3          	bltu	a5,a4,ffffffffc020360c <pmm_init+0xaa8>
ffffffffc0202d8a:	00093503          	ld	a0,0(s2)
ffffffffc0202d8e:	04050fe3          	beqz	a0,ffffffffc02035ec <pmm_init+0xa88>
ffffffffc0202d92:	03451793          	slli	a5,a0,0x34
ffffffffc0202d96:	04079be3          	bnez	a5,ffffffffc02035ec <pmm_init+0xa88>
ffffffffc0202d9a:	4601                	li	a2,0
ffffffffc0202d9c:	4581                	li	a1,0
ffffffffc0202d9e:	809ff0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0202da2:	2e0511e3          	bnez	a0,ffffffffc0203884 <pmm_init+0xd20>
ffffffffc0202da6:	100027f3          	csrr	a5,sstatus
ffffffffc0202daa:	8b89                	andi	a5,a5,2
ffffffffc0202dac:	44079e63          	bnez	a5,ffffffffc0203208 <pmm_init+0x6a4>
ffffffffc0202db0:	000b3783          	ld	a5,0(s6)
ffffffffc0202db4:	4505                	li	a0,1
ffffffffc0202db6:	6f9c                	ld	a5,24(a5)
ffffffffc0202db8:	9782                	jalr	a5
ffffffffc0202dba:	8a2a                	mv	s4,a0
ffffffffc0202dbc:	00093503          	ld	a0,0(s2)
ffffffffc0202dc0:	4681                	li	a3,0
ffffffffc0202dc2:	4601                	li	a2,0
ffffffffc0202dc4:	85d2                	mv	a1,s4
ffffffffc0202dc6:	ca9ff0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc0202dca:	26051be3          	bnez	a0,ffffffffc0203840 <pmm_init+0xcdc>
ffffffffc0202dce:	00093503          	ld	a0,0(s2)
ffffffffc0202dd2:	4601                	li	a2,0
ffffffffc0202dd4:	4581                	li	a1,0
ffffffffc0202dd6:	ce2ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc0202dda:	280505e3          	beqz	a0,ffffffffc0203864 <pmm_init+0xd00>
ffffffffc0202dde:	611c                	ld	a5,0(a0)
ffffffffc0202de0:	0017f713          	andi	a4,a5,1
ffffffffc0202de4:	26070ee3          	beqz	a4,ffffffffc0203860 <pmm_init+0xcfc>
ffffffffc0202de8:	6098                	ld	a4,0(s1)
ffffffffc0202dea:	078a                	slli	a5,a5,0x2
ffffffffc0202dec:	83b1                	srli	a5,a5,0xc
ffffffffc0202dee:	62e7f363          	bgeu	a5,a4,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc0202df2:	000bb683          	ld	a3,0(s7)
ffffffffc0202df6:	fff80637          	lui	a2,0xfff80
ffffffffc0202dfa:	97b2                	add	a5,a5,a2
ffffffffc0202dfc:	079a                	slli	a5,a5,0x6
ffffffffc0202dfe:	97b6                	add	a5,a5,a3
ffffffffc0202e00:	2afa12e3          	bne	s4,a5,ffffffffc02038a4 <pmm_init+0xd40>
ffffffffc0202e04:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202e08:	4785                	li	a5,1
ffffffffc0202e0a:	2cf699e3          	bne	a3,a5,ffffffffc02038dc <pmm_init+0xd78>
ffffffffc0202e0e:	00093503          	ld	a0,0(s2)
ffffffffc0202e12:	77fd                	lui	a5,0xfffff
ffffffffc0202e14:	6114                	ld	a3,0(a0)
ffffffffc0202e16:	068a                	slli	a3,a3,0x2
ffffffffc0202e18:	8efd                	and	a3,a3,a5
ffffffffc0202e1a:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202e1e:	2ae673e3          	bgeu	a2,a4,ffffffffc02038c4 <pmm_init+0xd60>
ffffffffc0202e22:	0009bc03          	ld	s8,0(s3)
ffffffffc0202e26:	96e2                	add	a3,a3,s8
ffffffffc0202e28:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202e2c:	0a8a                	slli	s5,s5,0x2
ffffffffc0202e2e:	00fafab3          	and	s5,s5,a5
ffffffffc0202e32:	00cad793          	srli	a5,s5,0xc
ffffffffc0202e36:	06e7f3e3          	bgeu	a5,a4,ffffffffc020369c <pmm_init+0xb38>
ffffffffc0202e3a:	4601                	li	a2,0
ffffffffc0202e3c:	6585                	lui	a1,0x1
ffffffffc0202e3e:	9ae2                	add	s5,s5,s8
ffffffffc0202e40:	c78ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc0202e44:	0aa1                	addi	s5,s5,8
ffffffffc0202e46:	03551be3          	bne	a0,s5,ffffffffc020367c <pmm_init+0xb18>
ffffffffc0202e4a:	100027f3          	csrr	a5,sstatus
ffffffffc0202e4e:	8b89                	andi	a5,a5,2
ffffffffc0202e50:	3a079163          	bnez	a5,ffffffffc02031f2 <pmm_init+0x68e>
ffffffffc0202e54:	000b3783          	ld	a5,0(s6)
ffffffffc0202e58:	4505                	li	a0,1
ffffffffc0202e5a:	6f9c                	ld	a5,24(a5)
ffffffffc0202e5c:	9782                	jalr	a5
ffffffffc0202e5e:	8c2a                	mv	s8,a0
ffffffffc0202e60:	00093503          	ld	a0,0(s2)
ffffffffc0202e64:	46d1                	li	a3,20
ffffffffc0202e66:	6605                	lui	a2,0x1
ffffffffc0202e68:	85e2                	mv	a1,s8
ffffffffc0202e6a:	c05ff0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc0202e6e:	1a0519e3          	bnez	a0,ffffffffc0203820 <pmm_init+0xcbc>
ffffffffc0202e72:	00093503          	ld	a0,0(s2)
ffffffffc0202e76:	4601                	li	a2,0
ffffffffc0202e78:	6585                	lui	a1,0x1
ffffffffc0202e7a:	c3eff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc0202e7e:	10050ce3          	beqz	a0,ffffffffc0203796 <pmm_init+0xc32>
ffffffffc0202e82:	611c                	ld	a5,0(a0)
ffffffffc0202e84:	0107f713          	andi	a4,a5,16
ffffffffc0202e88:	0e0707e3          	beqz	a4,ffffffffc0203776 <pmm_init+0xc12>
ffffffffc0202e8c:	8b91                	andi	a5,a5,4
ffffffffc0202e8e:	0c0784e3          	beqz	a5,ffffffffc0203756 <pmm_init+0xbf2>
ffffffffc0202e92:	00093503          	ld	a0,0(s2)
ffffffffc0202e96:	611c                	ld	a5,0(a0)
ffffffffc0202e98:	8bc1                	andi	a5,a5,16
ffffffffc0202e9a:	08078ee3          	beqz	a5,ffffffffc0203736 <pmm_init+0xbd2>
ffffffffc0202e9e:	000c2703          	lw	a4,0(s8)
ffffffffc0202ea2:	4785                	li	a5,1
ffffffffc0202ea4:	06f719e3          	bne	a4,a5,ffffffffc0203716 <pmm_init+0xbb2>
ffffffffc0202ea8:	4681                	li	a3,0
ffffffffc0202eaa:	6605                	lui	a2,0x1
ffffffffc0202eac:	85d2                	mv	a1,s4
ffffffffc0202eae:	bc1ff0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc0202eb2:	040512e3          	bnez	a0,ffffffffc02036f6 <pmm_init+0xb92>
ffffffffc0202eb6:	000a2703          	lw	a4,0(s4)
ffffffffc0202eba:	4789                	li	a5,2
ffffffffc0202ebc:	00f71de3          	bne	a4,a5,ffffffffc02036d6 <pmm_init+0xb72>
ffffffffc0202ec0:	000c2783          	lw	a5,0(s8)
ffffffffc0202ec4:	7e079963          	bnez	a5,ffffffffc02036b6 <pmm_init+0xb52>
ffffffffc0202ec8:	00093503          	ld	a0,0(s2)
ffffffffc0202ecc:	4601                	li	a2,0
ffffffffc0202ece:	6585                	lui	a1,0x1
ffffffffc0202ed0:	be8ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc0202ed4:	54050263          	beqz	a0,ffffffffc0203418 <pmm_init+0x8b4>
ffffffffc0202ed8:	6118                	ld	a4,0(a0)
ffffffffc0202eda:	00177793          	andi	a5,a4,1
ffffffffc0202ede:	180781e3          	beqz	a5,ffffffffc0203860 <pmm_init+0xcfc>
ffffffffc0202ee2:	6094                	ld	a3,0(s1)
ffffffffc0202ee4:	00271793          	slli	a5,a4,0x2
ffffffffc0202ee8:	83b1                	srli	a5,a5,0xc
ffffffffc0202eea:	52d7f563          	bgeu	a5,a3,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc0202eee:	000bb683          	ld	a3,0(s7)
ffffffffc0202ef2:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202ef6:	97d6                	add	a5,a5,s5
ffffffffc0202ef8:	079a                	slli	a5,a5,0x6
ffffffffc0202efa:	97b6                	add	a5,a5,a3
ffffffffc0202efc:	58fa1e63          	bne	s4,a5,ffffffffc0203498 <pmm_init+0x934>
ffffffffc0202f00:	8b41                	andi	a4,a4,16
ffffffffc0202f02:	56071b63          	bnez	a4,ffffffffc0203478 <pmm_init+0x914>
ffffffffc0202f06:	00093503          	ld	a0,0(s2)
ffffffffc0202f0a:	4581                	li	a1,0
ffffffffc0202f0c:	ac7ff0ef          	jal	ra,ffffffffc02029d2 <page_remove>
ffffffffc0202f10:	000a2c83          	lw	s9,0(s4)
ffffffffc0202f14:	4785                	li	a5,1
ffffffffc0202f16:	5cfc9163          	bne	s9,a5,ffffffffc02034d8 <pmm_init+0x974>
ffffffffc0202f1a:	000c2783          	lw	a5,0(s8)
ffffffffc0202f1e:	58079d63          	bnez	a5,ffffffffc02034b8 <pmm_init+0x954>
ffffffffc0202f22:	00093503          	ld	a0,0(s2)
ffffffffc0202f26:	6585                	lui	a1,0x1
ffffffffc0202f28:	aabff0ef          	jal	ra,ffffffffc02029d2 <page_remove>
ffffffffc0202f2c:	000a2783          	lw	a5,0(s4)
ffffffffc0202f30:	200793e3          	bnez	a5,ffffffffc0203936 <pmm_init+0xdd2>
ffffffffc0202f34:	000c2783          	lw	a5,0(s8)
ffffffffc0202f38:	1c079fe3          	bnez	a5,ffffffffc0203916 <pmm_init+0xdb2>
ffffffffc0202f3c:	00093a03          	ld	s4,0(s2)
ffffffffc0202f40:	608c                	ld	a1,0(s1)
ffffffffc0202f42:	000a3683          	ld	a3,0(s4)
ffffffffc0202f46:	068a                	slli	a3,a3,0x2
ffffffffc0202f48:	82b1                	srli	a3,a3,0xc
ffffffffc0202f4a:	4cb6f563          	bgeu	a3,a1,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc0202f4e:	000bb503          	ld	a0,0(s7)
ffffffffc0202f52:	96d6                	add	a3,a3,s5
ffffffffc0202f54:	069a                	slli	a3,a3,0x6
ffffffffc0202f56:	00d507b3          	add	a5,a0,a3
ffffffffc0202f5a:	439c                	lw	a5,0(a5)
ffffffffc0202f5c:	4f979e63          	bne	a5,s9,ffffffffc0203458 <pmm_init+0x8f4>
ffffffffc0202f60:	8699                	srai	a3,a3,0x6
ffffffffc0202f62:	00080637          	lui	a2,0x80
ffffffffc0202f66:	96b2                	add	a3,a3,a2
ffffffffc0202f68:	00c69713          	slli	a4,a3,0xc
ffffffffc0202f6c:	8331                	srli	a4,a4,0xc
ffffffffc0202f6e:	06b2                	slli	a3,a3,0xc
ffffffffc0202f70:	06b773e3          	bgeu	a4,a1,ffffffffc02037d6 <pmm_init+0xc72>
ffffffffc0202f74:	0009b703          	ld	a4,0(s3)
ffffffffc0202f78:	96ba                	add	a3,a3,a4
ffffffffc0202f7a:	629c                	ld	a5,0(a3)
ffffffffc0202f7c:	078a                	slli	a5,a5,0x2
ffffffffc0202f7e:	83b1                	srli	a5,a5,0xc
ffffffffc0202f80:	48b7fa63          	bgeu	a5,a1,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc0202f84:	8f91                	sub	a5,a5,a2
ffffffffc0202f86:	079a                	slli	a5,a5,0x6
ffffffffc0202f88:	953e                	add	a0,a0,a5
ffffffffc0202f8a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f8e:	8b89                	andi	a5,a5,2
ffffffffc0202f90:	32079463          	bnez	a5,ffffffffc02032b8 <pmm_init+0x754>
ffffffffc0202f94:	000b3783          	ld	a5,0(s6)
ffffffffc0202f98:	4585                	li	a1,1
ffffffffc0202f9a:	739c                	ld	a5,32(a5)
ffffffffc0202f9c:	9782                	jalr	a5
ffffffffc0202f9e:	000a3783          	ld	a5,0(s4)
ffffffffc0202fa2:	6098                	ld	a4,0(s1)
ffffffffc0202fa4:	078a                	slli	a5,a5,0x2
ffffffffc0202fa6:	83b1                	srli	a5,a5,0xc
ffffffffc0202fa8:	46e7f663          	bgeu	a5,a4,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc0202fac:	000bb503          	ld	a0,0(s7)
ffffffffc0202fb0:	fff80737          	lui	a4,0xfff80
ffffffffc0202fb4:	97ba                	add	a5,a5,a4
ffffffffc0202fb6:	079a                	slli	a5,a5,0x6
ffffffffc0202fb8:	953e                	add	a0,a0,a5
ffffffffc0202fba:	100027f3          	csrr	a5,sstatus
ffffffffc0202fbe:	8b89                	andi	a5,a5,2
ffffffffc0202fc0:	2e079063          	bnez	a5,ffffffffc02032a0 <pmm_init+0x73c>
ffffffffc0202fc4:	000b3783          	ld	a5,0(s6)
ffffffffc0202fc8:	4585                	li	a1,1
ffffffffc0202fca:	739c                	ld	a5,32(a5)
ffffffffc0202fcc:	9782                	jalr	a5
ffffffffc0202fce:	00093783          	ld	a5,0(s2)
ffffffffc0202fd2:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0202fd6:	12000073          	sfence.vma
ffffffffc0202fda:	100027f3          	csrr	a5,sstatus
ffffffffc0202fde:	8b89                	andi	a5,a5,2
ffffffffc0202fe0:	2a079663          	bnez	a5,ffffffffc020328c <pmm_init+0x728>
ffffffffc0202fe4:	000b3783          	ld	a5,0(s6)
ffffffffc0202fe8:	779c                	ld	a5,40(a5)
ffffffffc0202fea:	9782                	jalr	a5
ffffffffc0202fec:	8a2a                	mv	s4,a0
ffffffffc0202fee:	7d441463          	bne	s0,s4,ffffffffc02037b6 <pmm_init+0xc52>
ffffffffc0202ff2:	0000a517          	auipc	a0,0xa
ffffffffc0202ff6:	f2650513          	addi	a0,a0,-218 # ffffffffc020cf18 <default_pmm_manager+0x5f8>
ffffffffc0202ffa:	9acfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202ffe:	100027f3          	csrr	a5,sstatus
ffffffffc0203002:	8b89                	andi	a5,a5,2
ffffffffc0203004:	26079a63          	bnez	a5,ffffffffc0203278 <pmm_init+0x714>
ffffffffc0203008:	000b3783          	ld	a5,0(s6)
ffffffffc020300c:	779c                	ld	a5,40(a5)
ffffffffc020300e:	9782                	jalr	a5
ffffffffc0203010:	8c2a                	mv	s8,a0
ffffffffc0203012:	6098                	ld	a4,0(s1)
ffffffffc0203014:	c0200437          	lui	s0,0xc0200
ffffffffc0203018:	7afd                	lui	s5,0xfffff
ffffffffc020301a:	00c71793          	slli	a5,a4,0xc
ffffffffc020301e:	6a05                	lui	s4,0x1
ffffffffc0203020:	02f47c63          	bgeu	s0,a5,ffffffffc0203058 <pmm_init+0x4f4>
ffffffffc0203024:	00c45793          	srli	a5,s0,0xc
ffffffffc0203028:	00093503          	ld	a0,0(s2)
ffffffffc020302c:	3ae7f763          	bgeu	a5,a4,ffffffffc02033da <pmm_init+0x876>
ffffffffc0203030:	0009b583          	ld	a1,0(s3)
ffffffffc0203034:	4601                	li	a2,0
ffffffffc0203036:	95a2                	add	a1,a1,s0
ffffffffc0203038:	a80ff0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc020303c:	36050f63          	beqz	a0,ffffffffc02033ba <pmm_init+0x856>
ffffffffc0203040:	611c                	ld	a5,0(a0)
ffffffffc0203042:	078a                	slli	a5,a5,0x2
ffffffffc0203044:	0157f7b3          	and	a5,a5,s5
ffffffffc0203048:	3a879663          	bne	a5,s0,ffffffffc02033f4 <pmm_init+0x890>
ffffffffc020304c:	6098                	ld	a4,0(s1)
ffffffffc020304e:	9452                	add	s0,s0,s4
ffffffffc0203050:	00c71793          	slli	a5,a4,0xc
ffffffffc0203054:	fcf468e3          	bltu	s0,a5,ffffffffc0203024 <pmm_init+0x4c0>
ffffffffc0203058:	00093783          	ld	a5,0(s2)
ffffffffc020305c:	639c                	ld	a5,0(a5)
ffffffffc020305e:	48079d63          	bnez	a5,ffffffffc02034f8 <pmm_init+0x994>
ffffffffc0203062:	100027f3          	csrr	a5,sstatus
ffffffffc0203066:	8b89                	andi	a5,a5,2
ffffffffc0203068:	26079463          	bnez	a5,ffffffffc02032d0 <pmm_init+0x76c>
ffffffffc020306c:	000b3783          	ld	a5,0(s6)
ffffffffc0203070:	4505                	li	a0,1
ffffffffc0203072:	6f9c                	ld	a5,24(a5)
ffffffffc0203074:	9782                	jalr	a5
ffffffffc0203076:	8a2a                	mv	s4,a0
ffffffffc0203078:	00093503          	ld	a0,0(s2)
ffffffffc020307c:	4699                	li	a3,6
ffffffffc020307e:	10000613          	li	a2,256
ffffffffc0203082:	85d2                	mv	a1,s4
ffffffffc0203084:	9ebff0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc0203088:	4a051863          	bnez	a0,ffffffffc0203538 <pmm_init+0x9d4>
ffffffffc020308c:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203090:	4785                	li	a5,1
ffffffffc0203092:	48f71363          	bne	a4,a5,ffffffffc0203518 <pmm_init+0x9b4>
ffffffffc0203096:	00093503          	ld	a0,0(s2)
ffffffffc020309a:	6405                	lui	s0,0x1
ffffffffc020309c:	4699                	li	a3,6
ffffffffc020309e:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc02030a2:	85d2                	mv	a1,s4
ffffffffc02030a4:	9cbff0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc02030a8:	38051863          	bnez	a0,ffffffffc0203438 <pmm_init+0x8d4>
ffffffffc02030ac:	000a2703          	lw	a4,0(s4)
ffffffffc02030b0:	4789                	li	a5,2
ffffffffc02030b2:	4ef71363          	bne	a4,a5,ffffffffc0203598 <pmm_init+0xa34>
ffffffffc02030b6:	0000a597          	auipc	a1,0xa
ffffffffc02030ba:	faa58593          	addi	a1,a1,-86 # ffffffffc020d060 <default_pmm_manager+0x740>
ffffffffc02030be:	10000513          	li	a0,256
ffffffffc02030c2:	7ea080ef          	jal	ra,ffffffffc020b8ac <strcpy>
ffffffffc02030c6:	10040593          	addi	a1,s0,256
ffffffffc02030ca:	10000513          	li	a0,256
ffffffffc02030ce:	7f0080ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc02030d2:	4a051363          	bnez	a0,ffffffffc0203578 <pmm_init+0xa14>
ffffffffc02030d6:	000bb683          	ld	a3,0(s7)
ffffffffc02030da:	00080737          	lui	a4,0x80
ffffffffc02030de:	547d                	li	s0,-1
ffffffffc02030e0:	40da06b3          	sub	a3,s4,a3
ffffffffc02030e4:	8699                	srai	a3,a3,0x6
ffffffffc02030e6:	609c                	ld	a5,0(s1)
ffffffffc02030e8:	96ba                	add	a3,a3,a4
ffffffffc02030ea:	8031                	srli	s0,s0,0xc
ffffffffc02030ec:	0086f733          	and	a4,a3,s0
ffffffffc02030f0:	06b2                	slli	a3,a3,0xc
ffffffffc02030f2:	6ef77263          	bgeu	a4,a5,ffffffffc02037d6 <pmm_init+0xc72>
ffffffffc02030f6:	0009b783          	ld	a5,0(s3)
ffffffffc02030fa:	10000513          	li	a0,256
ffffffffc02030fe:	96be                	add	a3,a3,a5
ffffffffc0203100:	10068023          	sb	zero,256(a3)
ffffffffc0203104:	772080ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc0203108:	44051863          	bnez	a0,ffffffffc0203558 <pmm_init+0x9f4>
ffffffffc020310c:	00093a83          	ld	s5,0(s2)
ffffffffc0203110:	609c                	ld	a5,0(s1)
ffffffffc0203112:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203116:	068a                	slli	a3,a3,0x2
ffffffffc0203118:	82b1                	srli	a3,a3,0xc
ffffffffc020311a:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc020311e:	8c75                	and	s0,s0,a3
ffffffffc0203120:	06b2                	slli	a3,a3,0xc
ffffffffc0203122:	6af47a63          	bgeu	s0,a5,ffffffffc02037d6 <pmm_init+0xc72>
ffffffffc0203126:	0009b403          	ld	s0,0(s3)
ffffffffc020312a:	9436                	add	s0,s0,a3
ffffffffc020312c:	100027f3          	csrr	a5,sstatus
ffffffffc0203130:	8b89                	andi	a5,a5,2
ffffffffc0203132:	1e079c63          	bnez	a5,ffffffffc020332a <pmm_init+0x7c6>
ffffffffc0203136:	000b3783          	ld	a5,0(s6)
ffffffffc020313a:	4585                	li	a1,1
ffffffffc020313c:	8552                	mv	a0,s4
ffffffffc020313e:	739c                	ld	a5,32(a5)
ffffffffc0203140:	9782                	jalr	a5
ffffffffc0203142:	601c                	ld	a5,0(s0)
ffffffffc0203144:	6098                	ld	a4,0(s1)
ffffffffc0203146:	078a                	slli	a5,a5,0x2
ffffffffc0203148:	83b1                	srli	a5,a5,0xc
ffffffffc020314a:	2ce7f563          	bgeu	a5,a4,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc020314e:	000bb503          	ld	a0,0(s7)
ffffffffc0203152:	fff80737          	lui	a4,0xfff80
ffffffffc0203156:	97ba                	add	a5,a5,a4
ffffffffc0203158:	079a                	slli	a5,a5,0x6
ffffffffc020315a:	953e                	add	a0,a0,a5
ffffffffc020315c:	100027f3          	csrr	a5,sstatus
ffffffffc0203160:	8b89                	andi	a5,a5,2
ffffffffc0203162:	1a079863          	bnez	a5,ffffffffc0203312 <pmm_init+0x7ae>
ffffffffc0203166:	000b3783          	ld	a5,0(s6)
ffffffffc020316a:	4585                	li	a1,1
ffffffffc020316c:	739c                	ld	a5,32(a5)
ffffffffc020316e:	9782                	jalr	a5
ffffffffc0203170:	000ab783          	ld	a5,0(s5)
ffffffffc0203174:	6098                	ld	a4,0(s1)
ffffffffc0203176:	078a                	slli	a5,a5,0x2
ffffffffc0203178:	83b1                	srli	a5,a5,0xc
ffffffffc020317a:	28e7fd63          	bgeu	a5,a4,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc020317e:	000bb503          	ld	a0,0(s7)
ffffffffc0203182:	fff80737          	lui	a4,0xfff80
ffffffffc0203186:	97ba                	add	a5,a5,a4
ffffffffc0203188:	079a                	slli	a5,a5,0x6
ffffffffc020318a:	953e                	add	a0,a0,a5
ffffffffc020318c:	100027f3          	csrr	a5,sstatus
ffffffffc0203190:	8b89                	andi	a5,a5,2
ffffffffc0203192:	16079463          	bnez	a5,ffffffffc02032fa <pmm_init+0x796>
ffffffffc0203196:	000b3783          	ld	a5,0(s6)
ffffffffc020319a:	4585                	li	a1,1
ffffffffc020319c:	739c                	ld	a5,32(a5)
ffffffffc020319e:	9782                	jalr	a5
ffffffffc02031a0:	00093783          	ld	a5,0(s2)
ffffffffc02031a4:	0007b023          	sd	zero,0(a5)
ffffffffc02031a8:	12000073          	sfence.vma
ffffffffc02031ac:	100027f3          	csrr	a5,sstatus
ffffffffc02031b0:	8b89                	andi	a5,a5,2
ffffffffc02031b2:	12079a63          	bnez	a5,ffffffffc02032e6 <pmm_init+0x782>
ffffffffc02031b6:	000b3783          	ld	a5,0(s6)
ffffffffc02031ba:	779c                	ld	a5,40(a5)
ffffffffc02031bc:	9782                	jalr	a5
ffffffffc02031be:	842a                	mv	s0,a0
ffffffffc02031c0:	488c1e63          	bne	s8,s0,ffffffffc020365c <pmm_init+0xaf8>
ffffffffc02031c4:	0000a517          	auipc	a0,0xa
ffffffffc02031c8:	f1450513          	addi	a0,a0,-236 # ffffffffc020d0d8 <default_pmm_manager+0x7b8>
ffffffffc02031cc:	fdbfc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02031d0:	7406                	ld	s0,96(sp)
ffffffffc02031d2:	70a6                	ld	ra,104(sp)
ffffffffc02031d4:	64e6                	ld	s1,88(sp)
ffffffffc02031d6:	6946                	ld	s2,80(sp)
ffffffffc02031d8:	69a6                	ld	s3,72(sp)
ffffffffc02031da:	6a06                	ld	s4,64(sp)
ffffffffc02031dc:	7ae2                	ld	s5,56(sp)
ffffffffc02031de:	7b42                	ld	s6,48(sp)
ffffffffc02031e0:	7ba2                	ld	s7,40(sp)
ffffffffc02031e2:	7c02                	ld	s8,32(sp)
ffffffffc02031e4:	6ce2                	ld	s9,24(sp)
ffffffffc02031e6:	6165                	addi	sp,sp,112
ffffffffc02031e8:	e17fe06f          	j	ffffffffc0201ffe <kmalloc_init>
ffffffffc02031ec:	c80007b7          	lui	a5,0xc8000
ffffffffc02031f0:	b411                	j	ffffffffc0202bf4 <pmm_init+0x90>
ffffffffc02031f2:	a81fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031f6:	000b3783          	ld	a5,0(s6)
ffffffffc02031fa:	4505                	li	a0,1
ffffffffc02031fc:	6f9c                	ld	a5,24(a5)
ffffffffc02031fe:	9782                	jalr	a5
ffffffffc0203200:	8c2a                	mv	s8,a0
ffffffffc0203202:	a6bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203206:	b9a9                	j	ffffffffc0202e60 <pmm_init+0x2fc>
ffffffffc0203208:	a6bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020320c:	000b3783          	ld	a5,0(s6)
ffffffffc0203210:	4505                	li	a0,1
ffffffffc0203212:	6f9c                	ld	a5,24(a5)
ffffffffc0203214:	9782                	jalr	a5
ffffffffc0203216:	8a2a                	mv	s4,a0
ffffffffc0203218:	a55fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020321c:	b645                	j	ffffffffc0202dbc <pmm_init+0x258>
ffffffffc020321e:	a55fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203222:	000b3783          	ld	a5,0(s6)
ffffffffc0203226:	779c                	ld	a5,40(a5)
ffffffffc0203228:	9782                	jalr	a5
ffffffffc020322a:	842a                	mv	s0,a0
ffffffffc020322c:	a41fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203230:	b6b9                	j	ffffffffc0202d7e <pmm_init+0x21a>
ffffffffc0203232:	a41fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203236:	000b3783          	ld	a5,0(s6)
ffffffffc020323a:	4505                	li	a0,1
ffffffffc020323c:	6f9c                	ld	a5,24(a5)
ffffffffc020323e:	9782                	jalr	a5
ffffffffc0203240:	842a                	mv	s0,a0
ffffffffc0203242:	a2bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203246:	bc99                	j	ffffffffc0202c9c <pmm_init+0x138>
ffffffffc0203248:	6705                	lui	a4,0x1
ffffffffc020324a:	177d                	addi	a4,a4,-1
ffffffffc020324c:	96ba                	add	a3,a3,a4
ffffffffc020324e:	8ff5                	and	a5,a5,a3
ffffffffc0203250:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203254:	1ca77063          	bgeu	a4,a0,ffffffffc0203414 <pmm_init+0x8b0>
ffffffffc0203258:	000b3683          	ld	a3,0(s6)
ffffffffc020325c:	fff80537          	lui	a0,0xfff80
ffffffffc0203260:	972a                	add	a4,a4,a0
ffffffffc0203262:	6a94                	ld	a3,16(a3)
ffffffffc0203264:	8c1d                	sub	s0,s0,a5
ffffffffc0203266:	00671513          	slli	a0,a4,0x6
ffffffffc020326a:	00c45593          	srli	a1,s0,0xc
ffffffffc020326e:	9532                	add	a0,a0,a2
ffffffffc0203270:	9682                	jalr	a3
ffffffffc0203272:	0009b583          	ld	a1,0(s3)
ffffffffc0203276:	bac5                	j	ffffffffc0202c66 <pmm_init+0x102>
ffffffffc0203278:	9fbfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020327c:	000b3783          	ld	a5,0(s6)
ffffffffc0203280:	779c                	ld	a5,40(a5)
ffffffffc0203282:	9782                	jalr	a5
ffffffffc0203284:	8c2a                	mv	s8,a0
ffffffffc0203286:	9e7fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020328a:	b361                	j	ffffffffc0203012 <pmm_init+0x4ae>
ffffffffc020328c:	9e7fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203290:	000b3783          	ld	a5,0(s6)
ffffffffc0203294:	779c                	ld	a5,40(a5)
ffffffffc0203296:	9782                	jalr	a5
ffffffffc0203298:	8a2a                	mv	s4,a0
ffffffffc020329a:	9d3fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020329e:	bb81                	j	ffffffffc0202fee <pmm_init+0x48a>
ffffffffc02032a0:	e42a                	sd	a0,8(sp)
ffffffffc02032a2:	9d1fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032a6:	000b3783          	ld	a5,0(s6)
ffffffffc02032aa:	6522                	ld	a0,8(sp)
ffffffffc02032ac:	4585                	li	a1,1
ffffffffc02032ae:	739c                	ld	a5,32(a5)
ffffffffc02032b0:	9782                	jalr	a5
ffffffffc02032b2:	9bbfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032b6:	bb21                	j	ffffffffc0202fce <pmm_init+0x46a>
ffffffffc02032b8:	e42a                	sd	a0,8(sp)
ffffffffc02032ba:	9b9fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032be:	000b3783          	ld	a5,0(s6)
ffffffffc02032c2:	6522                	ld	a0,8(sp)
ffffffffc02032c4:	4585                	li	a1,1
ffffffffc02032c6:	739c                	ld	a5,32(a5)
ffffffffc02032c8:	9782                	jalr	a5
ffffffffc02032ca:	9a3fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032ce:	b9c1                	j	ffffffffc0202f9e <pmm_init+0x43a>
ffffffffc02032d0:	9a3fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032d4:	000b3783          	ld	a5,0(s6)
ffffffffc02032d8:	4505                	li	a0,1
ffffffffc02032da:	6f9c                	ld	a5,24(a5)
ffffffffc02032dc:	9782                	jalr	a5
ffffffffc02032de:	8a2a                	mv	s4,a0
ffffffffc02032e0:	98dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032e4:	bb51                	j	ffffffffc0203078 <pmm_init+0x514>
ffffffffc02032e6:	98dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032ea:	000b3783          	ld	a5,0(s6)
ffffffffc02032ee:	779c                	ld	a5,40(a5)
ffffffffc02032f0:	9782                	jalr	a5
ffffffffc02032f2:	842a                	mv	s0,a0
ffffffffc02032f4:	979fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032f8:	b5e1                	j	ffffffffc02031c0 <pmm_init+0x65c>
ffffffffc02032fa:	e42a                	sd	a0,8(sp)
ffffffffc02032fc:	977fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203300:	000b3783          	ld	a5,0(s6)
ffffffffc0203304:	6522                	ld	a0,8(sp)
ffffffffc0203306:	4585                	li	a1,1
ffffffffc0203308:	739c                	ld	a5,32(a5)
ffffffffc020330a:	9782                	jalr	a5
ffffffffc020330c:	961fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203310:	bd41                	j	ffffffffc02031a0 <pmm_init+0x63c>
ffffffffc0203312:	e42a                	sd	a0,8(sp)
ffffffffc0203314:	95ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203318:	000b3783          	ld	a5,0(s6)
ffffffffc020331c:	6522                	ld	a0,8(sp)
ffffffffc020331e:	4585                	li	a1,1
ffffffffc0203320:	739c                	ld	a5,32(a5)
ffffffffc0203322:	9782                	jalr	a5
ffffffffc0203324:	949fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203328:	b5a1                	j	ffffffffc0203170 <pmm_init+0x60c>
ffffffffc020332a:	949fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020332e:	000b3783          	ld	a5,0(s6)
ffffffffc0203332:	4585                	li	a1,1
ffffffffc0203334:	8552                	mv	a0,s4
ffffffffc0203336:	739c                	ld	a5,32(a5)
ffffffffc0203338:	9782                	jalr	a5
ffffffffc020333a:	933fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020333e:	b511                	j	ffffffffc0203142 <pmm_init+0x5de>
ffffffffc0203340:	00010417          	auipc	s0,0x10
ffffffffc0203344:	cc040413          	addi	s0,s0,-832 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc0203348:	00010797          	auipc	a5,0x10
ffffffffc020334c:	cb878793          	addi	a5,a5,-840 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc0203350:	a0f41de3          	bne	s0,a5,ffffffffc0202d6a <pmm_init+0x206>
ffffffffc0203354:	4581                	li	a1,0
ffffffffc0203356:	6605                	lui	a2,0x1
ffffffffc0203358:	8522                	mv	a0,s0
ffffffffc020335a:	5be080ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc020335e:	0000d597          	auipc	a1,0xd
ffffffffc0203362:	ca258593          	addi	a1,a1,-862 # ffffffffc0210000 <bootstackguard>
ffffffffc0203366:	0000e797          	auipc	a5,0xe
ffffffffc020336a:	c8078ca3          	sb	zero,-871(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc020336e:	0000d797          	auipc	a5,0xd
ffffffffc0203372:	c8078923          	sb	zero,-878(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc0203376:	00093503          	ld	a0,0(s2)
ffffffffc020337a:	2555ec63          	bltu	a1,s5,ffffffffc02035d2 <pmm_init+0xa6e>
ffffffffc020337e:	0009b683          	ld	a3,0(s3)
ffffffffc0203382:	4701                	li	a4,0
ffffffffc0203384:	6605                	lui	a2,0x1
ffffffffc0203386:	40d586b3          	sub	a3,a1,a3
ffffffffc020338a:	956ff0ef          	jal	ra,ffffffffc02024e0 <boot_map_segment>
ffffffffc020338e:	00093503          	ld	a0,0(s2)
ffffffffc0203392:	23546363          	bltu	s0,s5,ffffffffc02035b8 <pmm_init+0xa54>
ffffffffc0203396:	0009b683          	ld	a3,0(s3)
ffffffffc020339a:	4701                	li	a4,0
ffffffffc020339c:	6605                	lui	a2,0x1
ffffffffc020339e:	40d406b3          	sub	a3,s0,a3
ffffffffc02033a2:	85a2                	mv	a1,s0
ffffffffc02033a4:	93cff0ef          	jal	ra,ffffffffc02024e0 <boot_map_segment>
ffffffffc02033a8:	12000073          	sfence.vma
ffffffffc02033ac:	0000a517          	auipc	a0,0xa
ffffffffc02033b0:	83c50513          	addi	a0,a0,-1988 # ffffffffc020cbe8 <default_pmm_manager+0x2c8>
ffffffffc02033b4:	df3fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02033b8:	ba4d                	j	ffffffffc0202d6a <pmm_init+0x206>
ffffffffc02033ba:	0000a697          	auipc	a3,0xa
ffffffffc02033be:	b7e68693          	addi	a3,a3,-1154 # ffffffffc020cf38 <default_pmm_manager+0x618>
ffffffffc02033c2:	00009617          	auipc	a2,0x9
ffffffffc02033c6:	a3e60613          	addi	a2,a2,-1474 # ffffffffc020be00 <commands+0x210>
ffffffffc02033ca:	28800593          	li	a1,648
ffffffffc02033ce:	00009517          	auipc	a0,0x9
ffffffffc02033d2:	6a250513          	addi	a0,a0,1698 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02033d6:	8c8fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033da:	86a2                	mv	a3,s0
ffffffffc02033dc:	00009617          	auipc	a2,0x9
ffffffffc02033e0:	57c60613          	addi	a2,a2,1404 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02033e4:	28800593          	li	a1,648
ffffffffc02033e8:	00009517          	auipc	a0,0x9
ffffffffc02033ec:	68850513          	addi	a0,a0,1672 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02033f0:	8aefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033f4:	0000a697          	auipc	a3,0xa
ffffffffc02033f8:	b8468693          	addi	a3,a3,-1148 # ffffffffc020cf78 <default_pmm_manager+0x658>
ffffffffc02033fc:	00009617          	auipc	a2,0x9
ffffffffc0203400:	a0460613          	addi	a2,a2,-1532 # ffffffffc020be00 <commands+0x210>
ffffffffc0203404:	28900593          	li	a1,649
ffffffffc0203408:	00009517          	auipc	a0,0x9
ffffffffc020340c:	66850513          	addi	a0,a0,1640 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203410:	88efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203414:	db5fe0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>
ffffffffc0203418:	0000a697          	auipc	a3,0xa
ffffffffc020341c:	98868693          	addi	a3,a3,-1656 # ffffffffc020cda0 <default_pmm_manager+0x480>
ffffffffc0203420:	00009617          	auipc	a2,0x9
ffffffffc0203424:	9e060613          	addi	a2,a2,-1568 # ffffffffc020be00 <commands+0x210>
ffffffffc0203428:	26500593          	li	a1,613
ffffffffc020342c:	00009517          	auipc	a0,0x9
ffffffffc0203430:	64450513          	addi	a0,a0,1604 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203434:	86afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203438:	0000a697          	auipc	a3,0xa
ffffffffc020343c:	bc868693          	addi	a3,a3,-1080 # ffffffffc020d000 <default_pmm_manager+0x6e0>
ffffffffc0203440:	00009617          	auipc	a2,0x9
ffffffffc0203444:	9c060613          	addi	a2,a2,-1600 # ffffffffc020be00 <commands+0x210>
ffffffffc0203448:	29200593          	li	a1,658
ffffffffc020344c:	00009517          	auipc	a0,0x9
ffffffffc0203450:	62450513          	addi	a0,a0,1572 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203454:	84afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203458:	0000a697          	auipc	a3,0xa
ffffffffc020345c:	a6868693          	addi	a3,a3,-1432 # ffffffffc020cec0 <default_pmm_manager+0x5a0>
ffffffffc0203460:	00009617          	auipc	a2,0x9
ffffffffc0203464:	9a060613          	addi	a2,a2,-1632 # ffffffffc020be00 <commands+0x210>
ffffffffc0203468:	27100593          	li	a1,625
ffffffffc020346c:	00009517          	auipc	a0,0x9
ffffffffc0203470:	60450513          	addi	a0,a0,1540 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203474:	82afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203478:	0000a697          	auipc	a3,0xa
ffffffffc020347c:	a1868693          	addi	a3,a3,-1512 # ffffffffc020ce90 <default_pmm_manager+0x570>
ffffffffc0203480:	00009617          	auipc	a2,0x9
ffffffffc0203484:	98060613          	addi	a2,a2,-1664 # ffffffffc020be00 <commands+0x210>
ffffffffc0203488:	26700593          	li	a1,615
ffffffffc020348c:	00009517          	auipc	a0,0x9
ffffffffc0203490:	5e450513          	addi	a0,a0,1508 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203494:	80afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203498:	0000a697          	auipc	a3,0xa
ffffffffc020349c:	86868693          	addi	a3,a3,-1944 # ffffffffc020cd00 <default_pmm_manager+0x3e0>
ffffffffc02034a0:	00009617          	auipc	a2,0x9
ffffffffc02034a4:	96060613          	addi	a2,a2,-1696 # ffffffffc020be00 <commands+0x210>
ffffffffc02034a8:	26600593          	li	a1,614
ffffffffc02034ac:	00009517          	auipc	a0,0x9
ffffffffc02034b0:	5c450513          	addi	a0,a0,1476 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02034b4:	febfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034b8:	0000a697          	auipc	a3,0xa
ffffffffc02034bc:	9c068693          	addi	a3,a3,-1600 # ffffffffc020ce78 <default_pmm_manager+0x558>
ffffffffc02034c0:	00009617          	auipc	a2,0x9
ffffffffc02034c4:	94060613          	addi	a2,a2,-1728 # ffffffffc020be00 <commands+0x210>
ffffffffc02034c8:	26b00593          	li	a1,619
ffffffffc02034cc:	00009517          	auipc	a0,0x9
ffffffffc02034d0:	5a450513          	addi	a0,a0,1444 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02034d4:	fcbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034d8:	0000a697          	auipc	a3,0xa
ffffffffc02034dc:	84068693          	addi	a3,a3,-1984 # ffffffffc020cd18 <default_pmm_manager+0x3f8>
ffffffffc02034e0:	00009617          	auipc	a2,0x9
ffffffffc02034e4:	92060613          	addi	a2,a2,-1760 # ffffffffc020be00 <commands+0x210>
ffffffffc02034e8:	26a00593          	li	a1,618
ffffffffc02034ec:	00009517          	auipc	a0,0x9
ffffffffc02034f0:	58450513          	addi	a0,a0,1412 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02034f4:	fabfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034f8:	0000a697          	auipc	a3,0xa
ffffffffc02034fc:	a9868693          	addi	a3,a3,-1384 # ffffffffc020cf90 <default_pmm_manager+0x670>
ffffffffc0203500:	00009617          	auipc	a2,0x9
ffffffffc0203504:	90060613          	addi	a2,a2,-1792 # ffffffffc020be00 <commands+0x210>
ffffffffc0203508:	28c00593          	li	a1,652
ffffffffc020350c:	00009517          	auipc	a0,0x9
ffffffffc0203510:	56450513          	addi	a0,a0,1380 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203514:	f8bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203518:	0000a697          	auipc	a3,0xa
ffffffffc020351c:	ad068693          	addi	a3,a3,-1328 # ffffffffc020cfe8 <default_pmm_manager+0x6c8>
ffffffffc0203520:	00009617          	auipc	a2,0x9
ffffffffc0203524:	8e060613          	addi	a2,a2,-1824 # ffffffffc020be00 <commands+0x210>
ffffffffc0203528:	29100593          	li	a1,657
ffffffffc020352c:	00009517          	auipc	a0,0x9
ffffffffc0203530:	54450513          	addi	a0,a0,1348 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203534:	f6bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203538:	0000a697          	auipc	a3,0xa
ffffffffc020353c:	a7068693          	addi	a3,a3,-1424 # ffffffffc020cfa8 <default_pmm_manager+0x688>
ffffffffc0203540:	00009617          	auipc	a2,0x9
ffffffffc0203544:	8c060613          	addi	a2,a2,-1856 # ffffffffc020be00 <commands+0x210>
ffffffffc0203548:	29000593          	li	a1,656
ffffffffc020354c:	00009517          	auipc	a0,0x9
ffffffffc0203550:	52450513          	addi	a0,a0,1316 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203554:	f4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203558:	0000a697          	auipc	a3,0xa
ffffffffc020355c:	b5868693          	addi	a3,a3,-1192 # ffffffffc020d0b0 <default_pmm_manager+0x790>
ffffffffc0203560:	00009617          	auipc	a2,0x9
ffffffffc0203564:	8a060613          	addi	a2,a2,-1888 # ffffffffc020be00 <commands+0x210>
ffffffffc0203568:	29a00593          	li	a1,666
ffffffffc020356c:	00009517          	auipc	a0,0x9
ffffffffc0203570:	50450513          	addi	a0,a0,1284 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203574:	f2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203578:	0000a697          	auipc	a3,0xa
ffffffffc020357c:	b0068693          	addi	a3,a3,-1280 # ffffffffc020d078 <default_pmm_manager+0x758>
ffffffffc0203580:	00009617          	auipc	a2,0x9
ffffffffc0203584:	88060613          	addi	a2,a2,-1920 # ffffffffc020be00 <commands+0x210>
ffffffffc0203588:	29700593          	li	a1,663
ffffffffc020358c:	00009517          	auipc	a0,0x9
ffffffffc0203590:	4e450513          	addi	a0,a0,1252 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203594:	f0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203598:	0000a697          	auipc	a3,0xa
ffffffffc020359c:	ab068693          	addi	a3,a3,-1360 # ffffffffc020d048 <default_pmm_manager+0x728>
ffffffffc02035a0:	00009617          	auipc	a2,0x9
ffffffffc02035a4:	86060613          	addi	a2,a2,-1952 # ffffffffc020be00 <commands+0x210>
ffffffffc02035a8:	29300593          	li	a1,659
ffffffffc02035ac:	00009517          	auipc	a0,0x9
ffffffffc02035b0:	4c450513          	addi	a0,a0,1220 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02035b4:	eebfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b8:	86a2                	mv	a3,s0
ffffffffc02035ba:	00009617          	auipc	a2,0x9
ffffffffc02035be:	44660613          	addi	a2,a2,1094 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc02035c2:	0dc00593          	li	a1,220
ffffffffc02035c6:	00009517          	auipc	a0,0x9
ffffffffc02035ca:	4aa50513          	addi	a0,a0,1194 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02035ce:	ed1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035d2:	86ae                	mv	a3,a1
ffffffffc02035d4:	00009617          	auipc	a2,0x9
ffffffffc02035d8:	42c60613          	addi	a2,a2,1068 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc02035dc:	0db00593          	li	a1,219
ffffffffc02035e0:	00009517          	auipc	a0,0x9
ffffffffc02035e4:	49050513          	addi	a0,a0,1168 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02035e8:	eb7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035ec:	00009697          	auipc	a3,0x9
ffffffffc02035f0:	64468693          	addi	a3,a3,1604 # ffffffffc020cc30 <default_pmm_manager+0x310>
ffffffffc02035f4:	00009617          	auipc	a2,0x9
ffffffffc02035f8:	80c60613          	addi	a2,a2,-2036 # ffffffffc020be00 <commands+0x210>
ffffffffc02035fc:	24a00593          	li	a1,586
ffffffffc0203600:	00009517          	auipc	a0,0x9
ffffffffc0203604:	47050513          	addi	a0,a0,1136 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203608:	e97fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020360c:	00009697          	auipc	a3,0x9
ffffffffc0203610:	60468693          	addi	a3,a3,1540 # ffffffffc020cc10 <default_pmm_manager+0x2f0>
ffffffffc0203614:	00008617          	auipc	a2,0x8
ffffffffc0203618:	7ec60613          	addi	a2,a2,2028 # ffffffffc020be00 <commands+0x210>
ffffffffc020361c:	24900593          	li	a1,585
ffffffffc0203620:	00009517          	auipc	a0,0x9
ffffffffc0203624:	45050513          	addi	a0,a0,1104 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203628:	e77fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020362c:	00009617          	auipc	a2,0x9
ffffffffc0203630:	57460613          	addi	a2,a2,1396 # ffffffffc020cba0 <default_pmm_manager+0x280>
ffffffffc0203634:	0aa00593          	li	a1,170
ffffffffc0203638:	00009517          	auipc	a0,0x9
ffffffffc020363c:	43850513          	addi	a0,a0,1080 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203640:	e5ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203644:	00009617          	auipc	a2,0x9
ffffffffc0203648:	4c460613          	addi	a2,a2,1220 # ffffffffc020cb08 <default_pmm_manager+0x1e8>
ffffffffc020364c:	06500593          	li	a1,101
ffffffffc0203650:	00009517          	auipc	a0,0x9
ffffffffc0203654:	42050513          	addi	a0,a0,1056 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203658:	e47fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020365c:	0000a697          	auipc	a3,0xa
ffffffffc0203660:	89468693          	addi	a3,a3,-1900 # ffffffffc020cef0 <default_pmm_manager+0x5d0>
ffffffffc0203664:	00008617          	auipc	a2,0x8
ffffffffc0203668:	79c60613          	addi	a2,a2,1948 # ffffffffc020be00 <commands+0x210>
ffffffffc020366c:	2a300593          	li	a1,675
ffffffffc0203670:	00009517          	auipc	a0,0x9
ffffffffc0203674:	40050513          	addi	a0,a0,1024 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203678:	e27fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020367c:	00009697          	auipc	a3,0x9
ffffffffc0203680:	6b468693          	addi	a3,a3,1716 # ffffffffc020cd30 <default_pmm_manager+0x410>
ffffffffc0203684:	00008617          	auipc	a2,0x8
ffffffffc0203688:	77c60613          	addi	a2,a2,1916 # ffffffffc020be00 <commands+0x210>
ffffffffc020368c:	25800593          	li	a1,600
ffffffffc0203690:	00009517          	auipc	a0,0x9
ffffffffc0203694:	3e050513          	addi	a0,a0,992 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203698:	e07fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020369c:	86d6                	mv	a3,s5
ffffffffc020369e:	00009617          	auipc	a2,0x9
ffffffffc02036a2:	2ba60613          	addi	a2,a2,698 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02036a6:	25700593          	li	a1,599
ffffffffc02036aa:	00009517          	auipc	a0,0x9
ffffffffc02036ae:	3c650513          	addi	a0,a0,966 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02036b2:	dedfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036b6:	00009697          	auipc	a3,0x9
ffffffffc02036ba:	7c268693          	addi	a3,a3,1986 # ffffffffc020ce78 <default_pmm_manager+0x558>
ffffffffc02036be:	00008617          	auipc	a2,0x8
ffffffffc02036c2:	74260613          	addi	a2,a2,1858 # ffffffffc020be00 <commands+0x210>
ffffffffc02036c6:	26400593          	li	a1,612
ffffffffc02036ca:	00009517          	auipc	a0,0x9
ffffffffc02036ce:	3a650513          	addi	a0,a0,934 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02036d2:	dcdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036d6:	00009697          	auipc	a3,0x9
ffffffffc02036da:	78a68693          	addi	a3,a3,1930 # ffffffffc020ce60 <default_pmm_manager+0x540>
ffffffffc02036de:	00008617          	auipc	a2,0x8
ffffffffc02036e2:	72260613          	addi	a2,a2,1826 # ffffffffc020be00 <commands+0x210>
ffffffffc02036e6:	26300593          	li	a1,611
ffffffffc02036ea:	00009517          	auipc	a0,0x9
ffffffffc02036ee:	38650513          	addi	a0,a0,902 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02036f2:	dadfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036f6:	00009697          	auipc	a3,0x9
ffffffffc02036fa:	73a68693          	addi	a3,a3,1850 # ffffffffc020ce30 <default_pmm_manager+0x510>
ffffffffc02036fe:	00008617          	auipc	a2,0x8
ffffffffc0203702:	70260613          	addi	a2,a2,1794 # ffffffffc020be00 <commands+0x210>
ffffffffc0203706:	26200593          	li	a1,610
ffffffffc020370a:	00009517          	auipc	a0,0x9
ffffffffc020370e:	36650513          	addi	a0,a0,870 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203712:	d8dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203716:	00009697          	auipc	a3,0x9
ffffffffc020371a:	70268693          	addi	a3,a3,1794 # ffffffffc020ce18 <default_pmm_manager+0x4f8>
ffffffffc020371e:	00008617          	auipc	a2,0x8
ffffffffc0203722:	6e260613          	addi	a2,a2,1762 # ffffffffc020be00 <commands+0x210>
ffffffffc0203726:	26000593          	li	a1,608
ffffffffc020372a:	00009517          	auipc	a0,0x9
ffffffffc020372e:	34650513          	addi	a0,a0,838 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203732:	d6dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203736:	00009697          	auipc	a3,0x9
ffffffffc020373a:	6c268693          	addi	a3,a3,1730 # ffffffffc020cdf8 <default_pmm_manager+0x4d8>
ffffffffc020373e:	00008617          	auipc	a2,0x8
ffffffffc0203742:	6c260613          	addi	a2,a2,1730 # ffffffffc020be00 <commands+0x210>
ffffffffc0203746:	25f00593          	li	a1,607
ffffffffc020374a:	00009517          	auipc	a0,0x9
ffffffffc020374e:	32650513          	addi	a0,a0,806 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203752:	d4dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203756:	00009697          	auipc	a3,0x9
ffffffffc020375a:	69268693          	addi	a3,a3,1682 # ffffffffc020cde8 <default_pmm_manager+0x4c8>
ffffffffc020375e:	00008617          	auipc	a2,0x8
ffffffffc0203762:	6a260613          	addi	a2,a2,1698 # ffffffffc020be00 <commands+0x210>
ffffffffc0203766:	25e00593          	li	a1,606
ffffffffc020376a:	00009517          	auipc	a0,0x9
ffffffffc020376e:	30650513          	addi	a0,a0,774 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203772:	d2dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203776:	00009697          	auipc	a3,0x9
ffffffffc020377a:	66268693          	addi	a3,a3,1634 # ffffffffc020cdd8 <default_pmm_manager+0x4b8>
ffffffffc020377e:	00008617          	auipc	a2,0x8
ffffffffc0203782:	68260613          	addi	a2,a2,1666 # ffffffffc020be00 <commands+0x210>
ffffffffc0203786:	25d00593          	li	a1,605
ffffffffc020378a:	00009517          	auipc	a0,0x9
ffffffffc020378e:	2e650513          	addi	a0,a0,742 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203792:	d0dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203796:	00009697          	auipc	a3,0x9
ffffffffc020379a:	60a68693          	addi	a3,a3,1546 # ffffffffc020cda0 <default_pmm_manager+0x480>
ffffffffc020379e:	00008617          	auipc	a2,0x8
ffffffffc02037a2:	66260613          	addi	a2,a2,1634 # ffffffffc020be00 <commands+0x210>
ffffffffc02037a6:	25c00593          	li	a1,604
ffffffffc02037aa:	00009517          	auipc	a0,0x9
ffffffffc02037ae:	2c650513          	addi	a0,a0,710 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02037b2:	cedfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037b6:	00009697          	auipc	a3,0x9
ffffffffc02037ba:	73a68693          	addi	a3,a3,1850 # ffffffffc020cef0 <default_pmm_manager+0x5d0>
ffffffffc02037be:	00008617          	auipc	a2,0x8
ffffffffc02037c2:	64260613          	addi	a2,a2,1602 # ffffffffc020be00 <commands+0x210>
ffffffffc02037c6:	27900593          	li	a1,633
ffffffffc02037ca:	00009517          	auipc	a0,0x9
ffffffffc02037ce:	2a650513          	addi	a0,a0,678 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02037d2:	ccdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037d6:	00009617          	auipc	a2,0x9
ffffffffc02037da:	18260613          	addi	a2,a2,386 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02037de:	07100593          	li	a1,113
ffffffffc02037e2:	00009517          	auipc	a0,0x9
ffffffffc02037e6:	19e50513          	addi	a0,a0,414 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02037ea:	cb5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037ee:	86a2                	mv	a3,s0
ffffffffc02037f0:	00009617          	auipc	a2,0x9
ffffffffc02037f4:	21060613          	addi	a2,a2,528 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc02037f8:	0ca00593          	li	a1,202
ffffffffc02037fc:	00009517          	auipc	a0,0x9
ffffffffc0203800:	27450513          	addi	a0,a0,628 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203804:	c9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203808:	00009617          	auipc	a2,0x9
ffffffffc020380c:	1f860613          	addi	a2,a2,504 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc0203810:	08100593          	li	a1,129
ffffffffc0203814:	00009517          	auipc	a0,0x9
ffffffffc0203818:	25c50513          	addi	a0,a0,604 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc020381c:	c83fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203820:	00009697          	auipc	a3,0x9
ffffffffc0203824:	54068693          	addi	a3,a3,1344 # ffffffffc020cd60 <default_pmm_manager+0x440>
ffffffffc0203828:	00008617          	auipc	a2,0x8
ffffffffc020382c:	5d860613          	addi	a2,a2,1496 # ffffffffc020be00 <commands+0x210>
ffffffffc0203830:	25b00593          	li	a1,603
ffffffffc0203834:	00009517          	auipc	a0,0x9
ffffffffc0203838:	23c50513          	addi	a0,a0,572 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc020383c:	c63fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203840:	00009697          	auipc	a3,0x9
ffffffffc0203844:	46068693          	addi	a3,a3,1120 # ffffffffc020cca0 <default_pmm_manager+0x380>
ffffffffc0203848:	00008617          	auipc	a2,0x8
ffffffffc020384c:	5b860613          	addi	a2,a2,1464 # ffffffffc020be00 <commands+0x210>
ffffffffc0203850:	24f00593          	li	a1,591
ffffffffc0203854:	00009517          	auipc	a0,0x9
ffffffffc0203858:	21c50513          	addi	a0,a0,540 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc020385c:	c43fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203860:	985fe0ef          	jal	ra,ffffffffc02021e4 <pte2page.part.0>
ffffffffc0203864:	00009697          	auipc	a3,0x9
ffffffffc0203868:	46c68693          	addi	a3,a3,1132 # ffffffffc020ccd0 <default_pmm_manager+0x3b0>
ffffffffc020386c:	00008617          	auipc	a2,0x8
ffffffffc0203870:	59460613          	addi	a2,a2,1428 # ffffffffc020be00 <commands+0x210>
ffffffffc0203874:	25200593          	li	a1,594
ffffffffc0203878:	00009517          	auipc	a0,0x9
ffffffffc020387c:	1f850513          	addi	a0,a0,504 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203880:	c1ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203884:	00009697          	auipc	a3,0x9
ffffffffc0203888:	3ec68693          	addi	a3,a3,1004 # ffffffffc020cc70 <default_pmm_manager+0x350>
ffffffffc020388c:	00008617          	auipc	a2,0x8
ffffffffc0203890:	57460613          	addi	a2,a2,1396 # ffffffffc020be00 <commands+0x210>
ffffffffc0203894:	24b00593          	li	a1,587
ffffffffc0203898:	00009517          	auipc	a0,0x9
ffffffffc020389c:	1d850513          	addi	a0,a0,472 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02038a0:	bfffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a4:	00009697          	auipc	a3,0x9
ffffffffc02038a8:	45c68693          	addi	a3,a3,1116 # ffffffffc020cd00 <default_pmm_manager+0x3e0>
ffffffffc02038ac:	00008617          	auipc	a2,0x8
ffffffffc02038b0:	55460613          	addi	a2,a2,1364 # ffffffffc020be00 <commands+0x210>
ffffffffc02038b4:	25300593          	li	a1,595
ffffffffc02038b8:	00009517          	auipc	a0,0x9
ffffffffc02038bc:	1b850513          	addi	a0,a0,440 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02038c0:	bdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038c4:	00009617          	auipc	a2,0x9
ffffffffc02038c8:	09460613          	addi	a2,a2,148 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02038cc:	25600593          	li	a1,598
ffffffffc02038d0:	00009517          	auipc	a0,0x9
ffffffffc02038d4:	1a050513          	addi	a0,a0,416 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02038d8:	bc7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038dc:	00009697          	auipc	a3,0x9
ffffffffc02038e0:	43c68693          	addi	a3,a3,1084 # ffffffffc020cd18 <default_pmm_manager+0x3f8>
ffffffffc02038e4:	00008617          	auipc	a2,0x8
ffffffffc02038e8:	51c60613          	addi	a2,a2,1308 # ffffffffc020be00 <commands+0x210>
ffffffffc02038ec:	25400593          	li	a1,596
ffffffffc02038f0:	00009517          	auipc	a0,0x9
ffffffffc02038f4:	18050513          	addi	a0,a0,384 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc02038f8:	ba7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038fc:	86ca                	mv	a3,s2
ffffffffc02038fe:	00009617          	auipc	a2,0x9
ffffffffc0203902:	10260613          	addi	a2,a2,258 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc0203906:	0c600593          	li	a1,198
ffffffffc020390a:	00009517          	auipc	a0,0x9
ffffffffc020390e:	16650513          	addi	a0,a0,358 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203912:	b8dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203916:	00009697          	auipc	a3,0x9
ffffffffc020391a:	56268693          	addi	a3,a3,1378 # ffffffffc020ce78 <default_pmm_manager+0x558>
ffffffffc020391e:	00008617          	auipc	a2,0x8
ffffffffc0203922:	4e260613          	addi	a2,a2,1250 # ffffffffc020be00 <commands+0x210>
ffffffffc0203926:	26f00593          	li	a1,623
ffffffffc020392a:	00009517          	auipc	a0,0x9
ffffffffc020392e:	14650513          	addi	a0,a0,326 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203932:	b6dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203936:	00009697          	auipc	a3,0x9
ffffffffc020393a:	57268693          	addi	a3,a3,1394 # ffffffffc020cea8 <default_pmm_manager+0x588>
ffffffffc020393e:	00008617          	auipc	a2,0x8
ffffffffc0203942:	4c260613          	addi	a2,a2,1218 # ffffffffc020be00 <commands+0x210>
ffffffffc0203946:	26e00593          	li	a1,622
ffffffffc020394a:	00009517          	auipc	a0,0x9
ffffffffc020394e:	12650513          	addi	a0,a0,294 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203952:	b4dfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203956 <copy_range>:
ffffffffc0203956:	7159                	addi	sp,sp,-112
ffffffffc0203958:	00d667b3          	or	a5,a2,a3
ffffffffc020395c:	f486                	sd	ra,104(sp)
ffffffffc020395e:	f0a2                	sd	s0,96(sp)
ffffffffc0203960:	eca6                	sd	s1,88(sp)
ffffffffc0203962:	e8ca                	sd	s2,80(sp)
ffffffffc0203964:	e4ce                	sd	s3,72(sp)
ffffffffc0203966:	e0d2                	sd	s4,64(sp)
ffffffffc0203968:	fc56                	sd	s5,56(sp)
ffffffffc020396a:	f85a                	sd	s6,48(sp)
ffffffffc020396c:	f45e                	sd	s7,40(sp)
ffffffffc020396e:	f062                	sd	s8,32(sp)
ffffffffc0203970:	ec66                	sd	s9,24(sp)
ffffffffc0203972:	e86a                	sd	s10,16(sp)
ffffffffc0203974:	e46e                	sd	s11,8(sp)
ffffffffc0203976:	17d2                	slli	a5,a5,0x34
ffffffffc0203978:	20079f63          	bnez	a5,ffffffffc0203b96 <copy_range+0x240>
ffffffffc020397c:	002007b7          	lui	a5,0x200
ffffffffc0203980:	8432                	mv	s0,a2
ffffffffc0203982:	1af66263          	bltu	a2,a5,ffffffffc0203b26 <copy_range+0x1d0>
ffffffffc0203986:	8936                	mv	s2,a3
ffffffffc0203988:	18d67f63          	bgeu	a2,a3,ffffffffc0203b26 <copy_range+0x1d0>
ffffffffc020398c:	4785                	li	a5,1
ffffffffc020398e:	07fe                	slli	a5,a5,0x1f
ffffffffc0203990:	18d7eb63          	bltu	a5,a3,ffffffffc0203b26 <copy_range+0x1d0>
ffffffffc0203994:	5b7d                	li	s6,-1
ffffffffc0203996:	8aaa                	mv	s5,a0
ffffffffc0203998:	89ae                	mv	s3,a1
ffffffffc020399a:	6a05                	lui	s4,0x1
ffffffffc020399c:	00093c17          	auipc	s8,0x93
ffffffffc02039a0:	f04c0c13          	addi	s8,s8,-252 # ffffffffc02968a0 <npage>
ffffffffc02039a4:	00093b97          	auipc	s7,0x93
ffffffffc02039a8:	f04b8b93          	addi	s7,s7,-252 # ffffffffc02968a8 <pages>
ffffffffc02039ac:	00cb5b13          	srli	s6,s6,0xc
ffffffffc02039b0:	00093c97          	auipc	s9,0x93
ffffffffc02039b4:	f00c8c93          	addi	s9,s9,-256 # ffffffffc02968b0 <pmm_manager>
ffffffffc02039b8:	4601                	li	a2,0
ffffffffc02039ba:	85a2                	mv	a1,s0
ffffffffc02039bc:	854e                	mv	a0,s3
ffffffffc02039be:	8fbfe0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc02039c2:	84aa                	mv	s1,a0
ffffffffc02039c4:	0e050c63          	beqz	a0,ffffffffc0203abc <copy_range+0x166>
ffffffffc02039c8:	611c                	ld	a5,0(a0)
ffffffffc02039ca:	8b85                	andi	a5,a5,1
ffffffffc02039cc:	e785                	bnez	a5,ffffffffc02039f4 <copy_range+0x9e>
ffffffffc02039ce:	9452                	add	s0,s0,s4
ffffffffc02039d0:	ff2464e3          	bltu	s0,s2,ffffffffc02039b8 <copy_range+0x62>
ffffffffc02039d4:	4501                	li	a0,0
ffffffffc02039d6:	70a6                	ld	ra,104(sp)
ffffffffc02039d8:	7406                	ld	s0,96(sp)
ffffffffc02039da:	64e6                	ld	s1,88(sp)
ffffffffc02039dc:	6946                	ld	s2,80(sp)
ffffffffc02039de:	69a6                	ld	s3,72(sp)
ffffffffc02039e0:	6a06                	ld	s4,64(sp)
ffffffffc02039e2:	7ae2                	ld	s5,56(sp)
ffffffffc02039e4:	7b42                	ld	s6,48(sp)
ffffffffc02039e6:	7ba2                	ld	s7,40(sp)
ffffffffc02039e8:	7c02                	ld	s8,32(sp)
ffffffffc02039ea:	6ce2                	ld	s9,24(sp)
ffffffffc02039ec:	6d42                	ld	s10,16(sp)
ffffffffc02039ee:	6da2                	ld	s11,8(sp)
ffffffffc02039f0:	6165                	addi	sp,sp,112
ffffffffc02039f2:	8082                	ret
ffffffffc02039f4:	4605                	li	a2,1
ffffffffc02039f6:	85a2                	mv	a1,s0
ffffffffc02039f8:	8556                	mv	a0,s5
ffffffffc02039fa:	8bffe0ef          	jal	ra,ffffffffc02022b8 <get_pte>
ffffffffc02039fe:	c56d                	beqz	a0,ffffffffc0203ae8 <copy_range+0x192>
ffffffffc0203a00:	609c                	ld	a5,0(s1)
ffffffffc0203a02:	0017f713          	andi	a4,a5,1
ffffffffc0203a06:	01f7f493          	andi	s1,a5,31
ffffffffc0203a0a:	16070a63          	beqz	a4,ffffffffc0203b7e <copy_range+0x228>
ffffffffc0203a0e:	000c3683          	ld	a3,0(s8)
ffffffffc0203a12:	078a                	slli	a5,a5,0x2
ffffffffc0203a14:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203a18:	14d77763          	bgeu	a4,a3,ffffffffc0203b66 <copy_range+0x210>
ffffffffc0203a1c:	000bb783          	ld	a5,0(s7)
ffffffffc0203a20:	fff806b7          	lui	a3,0xfff80
ffffffffc0203a24:	9736                	add	a4,a4,a3
ffffffffc0203a26:	071a                	slli	a4,a4,0x6
ffffffffc0203a28:	00e78db3          	add	s11,a5,a4
ffffffffc0203a2c:	10002773          	csrr	a4,sstatus
ffffffffc0203a30:	8b09                	andi	a4,a4,2
ffffffffc0203a32:	e345                	bnez	a4,ffffffffc0203ad2 <copy_range+0x17c>
ffffffffc0203a34:	000cb703          	ld	a4,0(s9)
ffffffffc0203a38:	4505                	li	a0,1
ffffffffc0203a3a:	6f18                	ld	a4,24(a4)
ffffffffc0203a3c:	9702                	jalr	a4
ffffffffc0203a3e:	8d2a                	mv	s10,a0
ffffffffc0203a40:	0c0d8363          	beqz	s11,ffffffffc0203b06 <copy_range+0x1b0>
ffffffffc0203a44:	100d0163          	beqz	s10,ffffffffc0203b46 <copy_range+0x1f0>
ffffffffc0203a48:	000bb703          	ld	a4,0(s7)
ffffffffc0203a4c:	000805b7          	lui	a1,0x80
ffffffffc0203a50:	000c3603          	ld	a2,0(s8)
ffffffffc0203a54:	40ed86b3          	sub	a3,s11,a4
ffffffffc0203a58:	8699                	srai	a3,a3,0x6
ffffffffc0203a5a:	96ae                	add	a3,a3,a1
ffffffffc0203a5c:	0166f7b3          	and	a5,a3,s6
ffffffffc0203a60:	06b2                	slli	a3,a3,0xc
ffffffffc0203a62:	08c7f663          	bgeu	a5,a2,ffffffffc0203aee <copy_range+0x198>
ffffffffc0203a66:	40ed07b3          	sub	a5,s10,a4
ffffffffc0203a6a:	00093717          	auipc	a4,0x93
ffffffffc0203a6e:	e4e70713          	addi	a4,a4,-434 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0203a72:	6308                	ld	a0,0(a4)
ffffffffc0203a74:	8799                	srai	a5,a5,0x6
ffffffffc0203a76:	97ae                	add	a5,a5,a1
ffffffffc0203a78:	0167f733          	and	a4,a5,s6
ffffffffc0203a7c:	00a685b3          	add	a1,a3,a0
ffffffffc0203a80:	07b2                	slli	a5,a5,0xc
ffffffffc0203a82:	06c77563          	bgeu	a4,a2,ffffffffc0203aec <copy_range+0x196>
ffffffffc0203a86:	6605                	lui	a2,0x1
ffffffffc0203a88:	953e                	add	a0,a0,a5
ffffffffc0203a8a:	6e1070ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0203a8e:	86a6                	mv	a3,s1
ffffffffc0203a90:	8622                	mv	a2,s0
ffffffffc0203a92:	85ea                	mv	a1,s10
ffffffffc0203a94:	8556                	mv	a0,s5
ffffffffc0203a96:	fd9fe0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc0203a9a:	d915                	beqz	a0,ffffffffc02039ce <copy_range+0x78>
ffffffffc0203a9c:	00009697          	auipc	a3,0x9
ffffffffc0203aa0:	67c68693          	addi	a3,a3,1660 # ffffffffc020d118 <default_pmm_manager+0x7f8>
ffffffffc0203aa4:	00008617          	auipc	a2,0x8
ffffffffc0203aa8:	35c60613          	addi	a2,a2,860 # ffffffffc020be00 <commands+0x210>
ffffffffc0203aac:	1e700593          	li	a1,487
ffffffffc0203ab0:	00009517          	auipc	a0,0x9
ffffffffc0203ab4:	fc050513          	addi	a0,a0,-64 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203ab8:	9e7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203abc:	00200637          	lui	a2,0x200
ffffffffc0203ac0:	9432                	add	s0,s0,a2
ffffffffc0203ac2:	ffe00637          	lui	a2,0xffe00
ffffffffc0203ac6:	8c71                	and	s0,s0,a2
ffffffffc0203ac8:	f00406e3          	beqz	s0,ffffffffc02039d4 <copy_range+0x7e>
ffffffffc0203acc:	ef2466e3          	bltu	s0,s2,ffffffffc02039b8 <copy_range+0x62>
ffffffffc0203ad0:	b711                	j	ffffffffc02039d4 <copy_range+0x7e>
ffffffffc0203ad2:	9a0fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203ad6:	000cb703          	ld	a4,0(s9)
ffffffffc0203ada:	4505                	li	a0,1
ffffffffc0203adc:	6f18                	ld	a4,24(a4)
ffffffffc0203ade:	9702                	jalr	a4
ffffffffc0203ae0:	8d2a                	mv	s10,a0
ffffffffc0203ae2:	98afd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203ae6:	bfa9                	j	ffffffffc0203a40 <copy_range+0xea>
ffffffffc0203ae8:	5571                	li	a0,-4
ffffffffc0203aea:	b5f5                	j	ffffffffc02039d6 <copy_range+0x80>
ffffffffc0203aec:	86be                	mv	a3,a5
ffffffffc0203aee:	00009617          	auipc	a2,0x9
ffffffffc0203af2:	e6a60613          	addi	a2,a2,-406 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc0203af6:	07100593          	li	a1,113
ffffffffc0203afa:	00009517          	auipc	a0,0x9
ffffffffc0203afe:	e8650513          	addi	a0,a0,-378 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0203b02:	99dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b06:	00009697          	auipc	a3,0x9
ffffffffc0203b0a:	5f268693          	addi	a3,a3,1522 # ffffffffc020d0f8 <default_pmm_manager+0x7d8>
ffffffffc0203b0e:	00008617          	auipc	a2,0x8
ffffffffc0203b12:	2f260613          	addi	a2,a2,754 # ffffffffc020be00 <commands+0x210>
ffffffffc0203b16:	1ce00593          	li	a1,462
ffffffffc0203b1a:	00009517          	auipc	a0,0x9
ffffffffc0203b1e:	f5650513          	addi	a0,a0,-170 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203b22:	97dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b26:	00009697          	auipc	a3,0x9
ffffffffc0203b2a:	fb268693          	addi	a3,a3,-78 # ffffffffc020cad8 <default_pmm_manager+0x1b8>
ffffffffc0203b2e:	00008617          	auipc	a2,0x8
ffffffffc0203b32:	2d260613          	addi	a2,a2,722 # ffffffffc020be00 <commands+0x210>
ffffffffc0203b36:	1b600593          	li	a1,438
ffffffffc0203b3a:	00009517          	auipc	a0,0x9
ffffffffc0203b3e:	f3650513          	addi	a0,a0,-202 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203b42:	95dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b46:	00009697          	auipc	a3,0x9
ffffffffc0203b4a:	5c268693          	addi	a3,a3,1474 # ffffffffc020d108 <default_pmm_manager+0x7e8>
ffffffffc0203b4e:	00008617          	auipc	a2,0x8
ffffffffc0203b52:	2b260613          	addi	a2,a2,690 # ffffffffc020be00 <commands+0x210>
ffffffffc0203b56:	1cf00593          	li	a1,463
ffffffffc0203b5a:	00009517          	auipc	a0,0x9
ffffffffc0203b5e:	f1650513          	addi	a0,a0,-234 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203b62:	93dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b66:	00009617          	auipc	a2,0x9
ffffffffc0203b6a:	ec260613          	addi	a2,a2,-318 # ffffffffc020ca28 <default_pmm_manager+0x108>
ffffffffc0203b6e:	06900593          	li	a1,105
ffffffffc0203b72:	00009517          	auipc	a0,0x9
ffffffffc0203b76:	e0e50513          	addi	a0,a0,-498 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0203b7a:	925fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b7e:	00009617          	auipc	a2,0x9
ffffffffc0203b82:	eca60613          	addi	a2,a2,-310 # ffffffffc020ca48 <default_pmm_manager+0x128>
ffffffffc0203b86:	07f00593          	li	a1,127
ffffffffc0203b8a:	00009517          	auipc	a0,0x9
ffffffffc0203b8e:	df650513          	addi	a0,a0,-522 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0203b92:	90dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b96:	00009697          	auipc	a3,0x9
ffffffffc0203b9a:	f1268693          	addi	a3,a3,-238 # ffffffffc020caa8 <default_pmm_manager+0x188>
ffffffffc0203b9e:	00008617          	auipc	a2,0x8
ffffffffc0203ba2:	26260613          	addi	a2,a2,610 # ffffffffc020be00 <commands+0x210>
ffffffffc0203ba6:	1b500593          	li	a1,437
ffffffffc0203baa:	00009517          	auipc	a0,0x9
ffffffffc0203bae:	ec650513          	addi	a0,a0,-314 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203bb2:	8edfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203bb6 <pgdir_alloc_page>:
ffffffffc0203bb6:	7179                	addi	sp,sp,-48
ffffffffc0203bb8:	ec26                	sd	s1,24(sp)
ffffffffc0203bba:	e84a                	sd	s2,16(sp)
ffffffffc0203bbc:	e052                	sd	s4,0(sp)
ffffffffc0203bbe:	f406                	sd	ra,40(sp)
ffffffffc0203bc0:	f022                	sd	s0,32(sp)
ffffffffc0203bc2:	e44e                	sd	s3,8(sp)
ffffffffc0203bc4:	8a2a                	mv	s4,a0
ffffffffc0203bc6:	84ae                	mv	s1,a1
ffffffffc0203bc8:	8932                	mv	s2,a2
ffffffffc0203bca:	100027f3          	csrr	a5,sstatus
ffffffffc0203bce:	8b89                	andi	a5,a5,2
ffffffffc0203bd0:	00093997          	auipc	s3,0x93
ffffffffc0203bd4:	ce098993          	addi	s3,s3,-800 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203bd8:	ef8d                	bnez	a5,ffffffffc0203c12 <pgdir_alloc_page+0x5c>
ffffffffc0203bda:	0009b783          	ld	a5,0(s3)
ffffffffc0203bde:	4505                	li	a0,1
ffffffffc0203be0:	6f9c                	ld	a5,24(a5)
ffffffffc0203be2:	9782                	jalr	a5
ffffffffc0203be4:	842a                	mv	s0,a0
ffffffffc0203be6:	cc09                	beqz	s0,ffffffffc0203c00 <pgdir_alloc_page+0x4a>
ffffffffc0203be8:	86ca                	mv	a3,s2
ffffffffc0203bea:	8626                	mv	a2,s1
ffffffffc0203bec:	85a2                	mv	a1,s0
ffffffffc0203bee:	8552                	mv	a0,s4
ffffffffc0203bf0:	e7ffe0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc0203bf4:	e915                	bnez	a0,ffffffffc0203c28 <pgdir_alloc_page+0x72>
ffffffffc0203bf6:	4018                	lw	a4,0(s0)
ffffffffc0203bf8:	fc04                	sd	s1,56(s0)
ffffffffc0203bfa:	4785                	li	a5,1
ffffffffc0203bfc:	04f71e63          	bne	a4,a5,ffffffffc0203c58 <pgdir_alloc_page+0xa2>
ffffffffc0203c00:	70a2                	ld	ra,40(sp)
ffffffffc0203c02:	8522                	mv	a0,s0
ffffffffc0203c04:	7402                	ld	s0,32(sp)
ffffffffc0203c06:	64e2                	ld	s1,24(sp)
ffffffffc0203c08:	6942                	ld	s2,16(sp)
ffffffffc0203c0a:	69a2                	ld	s3,8(sp)
ffffffffc0203c0c:	6a02                	ld	s4,0(sp)
ffffffffc0203c0e:	6145                	addi	sp,sp,48
ffffffffc0203c10:	8082                	ret
ffffffffc0203c12:	860fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203c16:	0009b783          	ld	a5,0(s3)
ffffffffc0203c1a:	4505                	li	a0,1
ffffffffc0203c1c:	6f9c                	ld	a5,24(a5)
ffffffffc0203c1e:	9782                	jalr	a5
ffffffffc0203c20:	842a                	mv	s0,a0
ffffffffc0203c22:	84afd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203c26:	b7c1                	j	ffffffffc0203be6 <pgdir_alloc_page+0x30>
ffffffffc0203c28:	100027f3          	csrr	a5,sstatus
ffffffffc0203c2c:	8b89                	andi	a5,a5,2
ffffffffc0203c2e:	eb89                	bnez	a5,ffffffffc0203c40 <pgdir_alloc_page+0x8a>
ffffffffc0203c30:	0009b783          	ld	a5,0(s3)
ffffffffc0203c34:	8522                	mv	a0,s0
ffffffffc0203c36:	4585                	li	a1,1
ffffffffc0203c38:	739c                	ld	a5,32(a5)
ffffffffc0203c3a:	4401                	li	s0,0
ffffffffc0203c3c:	9782                	jalr	a5
ffffffffc0203c3e:	b7c9                	j	ffffffffc0203c00 <pgdir_alloc_page+0x4a>
ffffffffc0203c40:	832fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203c44:	0009b783          	ld	a5,0(s3)
ffffffffc0203c48:	8522                	mv	a0,s0
ffffffffc0203c4a:	4585                	li	a1,1
ffffffffc0203c4c:	739c                	ld	a5,32(a5)
ffffffffc0203c4e:	4401                	li	s0,0
ffffffffc0203c50:	9782                	jalr	a5
ffffffffc0203c52:	81afd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203c56:	b76d                	j	ffffffffc0203c00 <pgdir_alloc_page+0x4a>
ffffffffc0203c58:	00009697          	auipc	a3,0x9
ffffffffc0203c5c:	4d068693          	addi	a3,a3,1232 # ffffffffc020d128 <default_pmm_manager+0x808>
ffffffffc0203c60:	00008617          	auipc	a2,0x8
ffffffffc0203c64:	1a060613          	addi	a2,a2,416 # ffffffffc020be00 <commands+0x210>
ffffffffc0203c68:	23000593          	li	a1,560
ffffffffc0203c6c:	00009517          	auipc	a0,0x9
ffffffffc0203c70:	e0450513          	addi	a0,a0,-508 # ffffffffc020ca70 <default_pmm_manager+0x150>
ffffffffc0203c74:	82bfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c78 <check_vma_overlap.part.0>:
ffffffffc0203c78:	1141                	addi	sp,sp,-16
ffffffffc0203c7a:	00009697          	auipc	a3,0x9
ffffffffc0203c7e:	4c668693          	addi	a3,a3,1222 # ffffffffc020d140 <default_pmm_manager+0x820>
ffffffffc0203c82:	00008617          	auipc	a2,0x8
ffffffffc0203c86:	17e60613          	addi	a2,a2,382 # ffffffffc020be00 <commands+0x210>
ffffffffc0203c8a:	07400593          	li	a1,116
ffffffffc0203c8e:	00009517          	auipc	a0,0x9
ffffffffc0203c92:	4d250513          	addi	a0,a0,1234 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203c96:	e406                	sd	ra,8(sp)
ffffffffc0203c98:	807fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c9c <mm_create>:
ffffffffc0203c9c:	1141                	addi	sp,sp,-16
ffffffffc0203c9e:	05800513          	li	a0,88
ffffffffc0203ca2:	e022                	sd	s0,0(sp)
ffffffffc0203ca4:	e406                	sd	ra,8(sp)
ffffffffc0203ca6:	b7cfe0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0203caa:	842a                	mv	s0,a0
ffffffffc0203cac:	c115                	beqz	a0,ffffffffc0203cd0 <mm_create+0x34>
ffffffffc0203cae:	e408                	sd	a0,8(s0)
ffffffffc0203cb0:	e008                	sd	a0,0(s0)
ffffffffc0203cb2:	00053823          	sd	zero,16(a0)
ffffffffc0203cb6:	00053c23          	sd	zero,24(a0)
ffffffffc0203cba:	02052023          	sw	zero,32(a0)
ffffffffc0203cbe:	02053423          	sd	zero,40(a0)
ffffffffc0203cc2:	02052823          	sw	zero,48(a0)
ffffffffc0203cc6:	4585                	li	a1,1
ffffffffc0203cc8:	03850513          	addi	a0,a0,56
ffffffffc0203ccc:	127000ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc0203cd0:	60a2                	ld	ra,8(sp)
ffffffffc0203cd2:	8522                	mv	a0,s0
ffffffffc0203cd4:	6402                	ld	s0,0(sp)
ffffffffc0203cd6:	0141                	addi	sp,sp,16
ffffffffc0203cd8:	8082                	ret

ffffffffc0203cda <find_vma>:
ffffffffc0203cda:	86aa                	mv	a3,a0
ffffffffc0203cdc:	c505                	beqz	a0,ffffffffc0203d04 <find_vma+0x2a>
ffffffffc0203cde:	6908                	ld	a0,16(a0)
ffffffffc0203ce0:	c501                	beqz	a0,ffffffffc0203ce8 <find_vma+0xe>
ffffffffc0203ce2:	651c                	ld	a5,8(a0)
ffffffffc0203ce4:	02f5f263          	bgeu	a1,a5,ffffffffc0203d08 <find_vma+0x2e>
ffffffffc0203ce8:	669c                	ld	a5,8(a3)
ffffffffc0203cea:	00f68d63          	beq	a3,a5,ffffffffc0203d04 <find_vma+0x2a>
ffffffffc0203cee:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_bin_sfs_img_size+0x18ace8>
ffffffffc0203cf2:	00e5e663          	bltu	a1,a4,ffffffffc0203cfe <find_vma+0x24>
ffffffffc0203cf6:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203cfa:	00e5ec63          	bltu	a1,a4,ffffffffc0203d12 <find_vma+0x38>
ffffffffc0203cfe:	679c                	ld	a5,8(a5)
ffffffffc0203d00:	fef697e3          	bne	a3,a5,ffffffffc0203cee <find_vma+0x14>
ffffffffc0203d04:	4501                	li	a0,0
ffffffffc0203d06:	8082                	ret
ffffffffc0203d08:	691c                	ld	a5,16(a0)
ffffffffc0203d0a:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203ce8 <find_vma+0xe>
ffffffffc0203d0e:	ea88                	sd	a0,16(a3)
ffffffffc0203d10:	8082                	ret
ffffffffc0203d12:	fe078513          	addi	a0,a5,-32
ffffffffc0203d16:	ea88                	sd	a0,16(a3)
ffffffffc0203d18:	8082                	ret

ffffffffc0203d1a <insert_vma_struct>:
ffffffffc0203d1a:	6590                	ld	a2,8(a1)
ffffffffc0203d1c:	0105b803          	ld	a6,16(a1) # 80010 <_binary_bin_sfs_img_size+0xad10>
ffffffffc0203d20:	1141                	addi	sp,sp,-16
ffffffffc0203d22:	e406                	sd	ra,8(sp)
ffffffffc0203d24:	87aa                	mv	a5,a0
ffffffffc0203d26:	01066763          	bltu	a2,a6,ffffffffc0203d34 <insert_vma_struct+0x1a>
ffffffffc0203d2a:	a085                	j	ffffffffc0203d8a <insert_vma_struct+0x70>
ffffffffc0203d2c:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203d30:	04e66863          	bltu	a2,a4,ffffffffc0203d80 <insert_vma_struct+0x66>
ffffffffc0203d34:	86be                	mv	a3,a5
ffffffffc0203d36:	679c                	ld	a5,8(a5)
ffffffffc0203d38:	fef51ae3          	bne	a0,a5,ffffffffc0203d2c <insert_vma_struct+0x12>
ffffffffc0203d3c:	02a68463          	beq	a3,a0,ffffffffc0203d64 <insert_vma_struct+0x4a>
ffffffffc0203d40:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203d44:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203d48:	08e8f163          	bgeu	a7,a4,ffffffffc0203dca <insert_vma_struct+0xb0>
ffffffffc0203d4c:	04e66f63          	bltu	a2,a4,ffffffffc0203daa <insert_vma_struct+0x90>
ffffffffc0203d50:	00f50a63          	beq	a0,a5,ffffffffc0203d64 <insert_vma_struct+0x4a>
ffffffffc0203d54:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203d58:	05076963          	bltu	a4,a6,ffffffffc0203daa <insert_vma_struct+0x90>
ffffffffc0203d5c:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203d60:	02c77363          	bgeu	a4,a2,ffffffffc0203d86 <insert_vma_struct+0x6c>
ffffffffc0203d64:	5118                	lw	a4,32(a0)
ffffffffc0203d66:	e188                	sd	a0,0(a1)
ffffffffc0203d68:	02058613          	addi	a2,a1,32
ffffffffc0203d6c:	e390                	sd	a2,0(a5)
ffffffffc0203d6e:	e690                	sd	a2,8(a3)
ffffffffc0203d70:	60a2                	ld	ra,8(sp)
ffffffffc0203d72:	f59c                	sd	a5,40(a1)
ffffffffc0203d74:	f194                	sd	a3,32(a1)
ffffffffc0203d76:	0017079b          	addiw	a5,a4,1
ffffffffc0203d7a:	d11c                	sw	a5,32(a0)
ffffffffc0203d7c:	0141                	addi	sp,sp,16
ffffffffc0203d7e:	8082                	ret
ffffffffc0203d80:	fca690e3          	bne	a3,a0,ffffffffc0203d40 <insert_vma_struct+0x26>
ffffffffc0203d84:	bfd1                	j	ffffffffc0203d58 <insert_vma_struct+0x3e>
ffffffffc0203d86:	ef3ff0ef          	jal	ra,ffffffffc0203c78 <check_vma_overlap.part.0>
ffffffffc0203d8a:	00009697          	auipc	a3,0x9
ffffffffc0203d8e:	3e668693          	addi	a3,a3,998 # ffffffffc020d170 <default_pmm_manager+0x850>
ffffffffc0203d92:	00008617          	auipc	a2,0x8
ffffffffc0203d96:	06e60613          	addi	a2,a2,110 # ffffffffc020be00 <commands+0x210>
ffffffffc0203d9a:	07a00593          	li	a1,122
ffffffffc0203d9e:	00009517          	auipc	a0,0x9
ffffffffc0203da2:	3c250513          	addi	a0,a0,962 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203da6:	ef8fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203daa:	00009697          	auipc	a3,0x9
ffffffffc0203dae:	40668693          	addi	a3,a3,1030 # ffffffffc020d1b0 <default_pmm_manager+0x890>
ffffffffc0203db2:	00008617          	auipc	a2,0x8
ffffffffc0203db6:	04e60613          	addi	a2,a2,78 # ffffffffc020be00 <commands+0x210>
ffffffffc0203dba:	07300593          	li	a1,115
ffffffffc0203dbe:	00009517          	auipc	a0,0x9
ffffffffc0203dc2:	3a250513          	addi	a0,a0,930 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203dc6:	ed8fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203dca:	00009697          	auipc	a3,0x9
ffffffffc0203dce:	3c668693          	addi	a3,a3,966 # ffffffffc020d190 <default_pmm_manager+0x870>
ffffffffc0203dd2:	00008617          	auipc	a2,0x8
ffffffffc0203dd6:	02e60613          	addi	a2,a2,46 # ffffffffc020be00 <commands+0x210>
ffffffffc0203dda:	07200593          	li	a1,114
ffffffffc0203dde:	00009517          	auipc	a0,0x9
ffffffffc0203de2:	38250513          	addi	a0,a0,898 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203de6:	eb8fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203dea <mm_destroy>:
ffffffffc0203dea:	591c                	lw	a5,48(a0)
ffffffffc0203dec:	1141                	addi	sp,sp,-16
ffffffffc0203dee:	e406                	sd	ra,8(sp)
ffffffffc0203df0:	e022                	sd	s0,0(sp)
ffffffffc0203df2:	e78d                	bnez	a5,ffffffffc0203e1c <mm_destroy+0x32>
ffffffffc0203df4:	842a                	mv	s0,a0
ffffffffc0203df6:	6508                	ld	a0,8(a0)
ffffffffc0203df8:	00a40c63          	beq	s0,a0,ffffffffc0203e10 <mm_destroy+0x26>
ffffffffc0203dfc:	6118                	ld	a4,0(a0)
ffffffffc0203dfe:	651c                	ld	a5,8(a0)
ffffffffc0203e00:	1501                	addi	a0,a0,-32
ffffffffc0203e02:	e71c                	sd	a5,8(a4)
ffffffffc0203e04:	e398                	sd	a4,0(a5)
ffffffffc0203e06:	accfe0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0203e0a:	6408                	ld	a0,8(s0)
ffffffffc0203e0c:	fea418e3          	bne	s0,a0,ffffffffc0203dfc <mm_destroy+0x12>
ffffffffc0203e10:	8522                	mv	a0,s0
ffffffffc0203e12:	6402                	ld	s0,0(sp)
ffffffffc0203e14:	60a2                	ld	ra,8(sp)
ffffffffc0203e16:	0141                	addi	sp,sp,16
ffffffffc0203e18:	abafe06f          	j	ffffffffc02020d2 <kfree>
ffffffffc0203e1c:	00009697          	auipc	a3,0x9
ffffffffc0203e20:	3b468693          	addi	a3,a3,948 # ffffffffc020d1d0 <default_pmm_manager+0x8b0>
ffffffffc0203e24:	00008617          	auipc	a2,0x8
ffffffffc0203e28:	fdc60613          	addi	a2,a2,-36 # ffffffffc020be00 <commands+0x210>
ffffffffc0203e2c:	09e00593          	li	a1,158
ffffffffc0203e30:	00009517          	auipc	a0,0x9
ffffffffc0203e34:	33050513          	addi	a0,a0,816 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203e38:	e66fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203e3c <mm_map>:
ffffffffc0203e3c:	7139                	addi	sp,sp,-64
ffffffffc0203e3e:	f822                	sd	s0,48(sp)
ffffffffc0203e40:	6405                	lui	s0,0x1
ffffffffc0203e42:	147d                	addi	s0,s0,-1
ffffffffc0203e44:	77fd                	lui	a5,0xfffff
ffffffffc0203e46:	9622                	add	a2,a2,s0
ffffffffc0203e48:	962e                	add	a2,a2,a1
ffffffffc0203e4a:	f426                	sd	s1,40(sp)
ffffffffc0203e4c:	fc06                	sd	ra,56(sp)
ffffffffc0203e4e:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203e52:	f04a                	sd	s2,32(sp)
ffffffffc0203e54:	ec4e                	sd	s3,24(sp)
ffffffffc0203e56:	e852                	sd	s4,16(sp)
ffffffffc0203e58:	e456                	sd	s5,8(sp)
ffffffffc0203e5a:	002005b7          	lui	a1,0x200
ffffffffc0203e5e:	00f67433          	and	s0,a2,a5
ffffffffc0203e62:	06b4e363          	bltu	s1,a1,ffffffffc0203ec8 <mm_map+0x8c>
ffffffffc0203e66:	0684f163          	bgeu	s1,s0,ffffffffc0203ec8 <mm_map+0x8c>
ffffffffc0203e6a:	4785                	li	a5,1
ffffffffc0203e6c:	07fe                	slli	a5,a5,0x1f
ffffffffc0203e6e:	0487ed63          	bltu	a5,s0,ffffffffc0203ec8 <mm_map+0x8c>
ffffffffc0203e72:	89aa                	mv	s3,a0
ffffffffc0203e74:	cd21                	beqz	a0,ffffffffc0203ecc <mm_map+0x90>
ffffffffc0203e76:	85a6                	mv	a1,s1
ffffffffc0203e78:	8ab6                	mv	s5,a3
ffffffffc0203e7a:	8a3a                	mv	s4,a4
ffffffffc0203e7c:	e5fff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc0203e80:	c501                	beqz	a0,ffffffffc0203e88 <mm_map+0x4c>
ffffffffc0203e82:	651c                	ld	a5,8(a0)
ffffffffc0203e84:	0487e263          	bltu	a5,s0,ffffffffc0203ec8 <mm_map+0x8c>
ffffffffc0203e88:	03000513          	li	a0,48
ffffffffc0203e8c:	996fe0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0203e90:	892a                	mv	s2,a0
ffffffffc0203e92:	5571                	li	a0,-4
ffffffffc0203e94:	02090163          	beqz	s2,ffffffffc0203eb6 <mm_map+0x7a>
ffffffffc0203e98:	854e                	mv	a0,s3
ffffffffc0203e9a:	00993423          	sd	s1,8(s2)
ffffffffc0203e9e:	00893823          	sd	s0,16(s2)
ffffffffc0203ea2:	01592c23          	sw	s5,24(s2)
ffffffffc0203ea6:	85ca                	mv	a1,s2
ffffffffc0203ea8:	e73ff0ef          	jal	ra,ffffffffc0203d1a <insert_vma_struct>
ffffffffc0203eac:	4501                	li	a0,0
ffffffffc0203eae:	000a0463          	beqz	s4,ffffffffc0203eb6 <mm_map+0x7a>
ffffffffc0203eb2:	012a3023          	sd	s2,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203eb6:	70e2                	ld	ra,56(sp)
ffffffffc0203eb8:	7442                	ld	s0,48(sp)
ffffffffc0203eba:	74a2                	ld	s1,40(sp)
ffffffffc0203ebc:	7902                	ld	s2,32(sp)
ffffffffc0203ebe:	69e2                	ld	s3,24(sp)
ffffffffc0203ec0:	6a42                	ld	s4,16(sp)
ffffffffc0203ec2:	6aa2                	ld	s5,8(sp)
ffffffffc0203ec4:	6121                	addi	sp,sp,64
ffffffffc0203ec6:	8082                	ret
ffffffffc0203ec8:	5575                	li	a0,-3
ffffffffc0203eca:	b7f5                	j	ffffffffc0203eb6 <mm_map+0x7a>
ffffffffc0203ecc:	00009697          	auipc	a3,0x9
ffffffffc0203ed0:	31c68693          	addi	a3,a3,796 # ffffffffc020d1e8 <default_pmm_manager+0x8c8>
ffffffffc0203ed4:	00008617          	auipc	a2,0x8
ffffffffc0203ed8:	f2c60613          	addi	a2,a2,-212 # ffffffffc020be00 <commands+0x210>
ffffffffc0203edc:	0b300593          	li	a1,179
ffffffffc0203ee0:	00009517          	auipc	a0,0x9
ffffffffc0203ee4:	28050513          	addi	a0,a0,640 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203ee8:	db6fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203eec <dup_mmap>:
ffffffffc0203eec:	7139                	addi	sp,sp,-64
ffffffffc0203eee:	fc06                	sd	ra,56(sp)
ffffffffc0203ef0:	f822                	sd	s0,48(sp)
ffffffffc0203ef2:	f426                	sd	s1,40(sp)
ffffffffc0203ef4:	f04a                	sd	s2,32(sp)
ffffffffc0203ef6:	ec4e                	sd	s3,24(sp)
ffffffffc0203ef8:	e852                	sd	s4,16(sp)
ffffffffc0203efa:	e456                	sd	s5,8(sp)
ffffffffc0203efc:	c52d                	beqz	a0,ffffffffc0203f66 <dup_mmap+0x7a>
ffffffffc0203efe:	892a                	mv	s2,a0
ffffffffc0203f00:	84ae                	mv	s1,a1
ffffffffc0203f02:	842e                	mv	s0,a1
ffffffffc0203f04:	e595                	bnez	a1,ffffffffc0203f30 <dup_mmap+0x44>
ffffffffc0203f06:	a085                	j	ffffffffc0203f66 <dup_mmap+0x7a>
ffffffffc0203f08:	854a                	mv	a0,s2
ffffffffc0203f0a:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203f0e:	0145b823          	sd	s4,16(a1)
ffffffffc0203f12:	0135ac23          	sw	s3,24(a1)
ffffffffc0203f16:	e05ff0ef          	jal	ra,ffffffffc0203d1a <insert_vma_struct>
ffffffffc0203f1a:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203f1e:	fe843603          	ld	a2,-24(s0)
ffffffffc0203f22:	6c8c                	ld	a1,24(s1)
ffffffffc0203f24:	01893503          	ld	a0,24(s2)
ffffffffc0203f28:	4701                	li	a4,0
ffffffffc0203f2a:	a2dff0ef          	jal	ra,ffffffffc0203956 <copy_range>
ffffffffc0203f2e:	e105                	bnez	a0,ffffffffc0203f4e <dup_mmap+0x62>
ffffffffc0203f30:	6000                	ld	s0,0(s0)
ffffffffc0203f32:	02848863          	beq	s1,s0,ffffffffc0203f62 <dup_mmap+0x76>
ffffffffc0203f36:	03000513          	li	a0,48
ffffffffc0203f3a:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203f3e:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203f42:	ff842983          	lw	s3,-8(s0)
ffffffffc0203f46:	8dcfe0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0203f4a:	85aa                	mv	a1,a0
ffffffffc0203f4c:	fd55                	bnez	a0,ffffffffc0203f08 <dup_mmap+0x1c>
ffffffffc0203f4e:	5571                	li	a0,-4
ffffffffc0203f50:	70e2                	ld	ra,56(sp)
ffffffffc0203f52:	7442                	ld	s0,48(sp)
ffffffffc0203f54:	74a2                	ld	s1,40(sp)
ffffffffc0203f56:	7902                	ld	s2,32(sp)
ffffffffc0203f58:	69e2                	ld	s3,24(sp)
ffffffffc0203f5a:	6a42                	ld	s4,16(sp)
ffffffffc0203f5c:	6aa2                	ld	s5,8(sp)
ffffffffc0203f5e:	6121                	addi	sp,sp,64
ffffffffc0203f60:	8082                	ret
ffffffffc0203f62:	4501                	li	a0,0
ffffffffc0203f64:	b7f5                	j	ffffffffc0203f50 <dup_mmap+0x64>
ffffffffc0203f66:	00009697          	auipc	a3,0x9
ffffffffc0203f6a:	29268693          	addi	a3,a3,658 # ffffffffc020d1f8 <default_pmm_manager+0x8d8>
ffffffffc0203f6e:	00008617          	auipc	a2,0x8
ffffffffc0203f72:	e9260613          	addi	a2,a2,-366 # ffffffffc020be00 <commands+0x210>
ffffffffc0203f76:	0cf00593          	li	a1,207
ffffffffc0203f7a:	00009517          	auipc	a0,0x9
ffffffffc0203f7e:	1e650513          	addi	a0,a0,486 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203f82:	d1cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203f86 <exit_mmap>:
ffffffffc0203f86:	1101                	addi	sp,sp,-32
ffffffffc0203f88:	ec06                	sd	ra,24(sp)
ffffffffc0203f8a:	e822                	sd	s0,16(sp)
ffffffffc0203f8c:	e426                	sd	s1,8(sp)
ffffffffc0203f8e:	e04a                	sd	s2,0(sp)
ffffffffc0203f90:	c531                	beqz	a0,ffffffffc0203fdc <exit_mmap+0x56>
ffffffffc0203f92:	591c                	lw	a5,48(a0)
ffffffffc0203f94:	84aa                	mv	s1,a0
ffffffffc0203f96:	e3b9                	bnez	a5,ffffffffc0203fdc <exit_mmap+0x56>
ffffffffc0203f98:	6500                	ld	s0,8(a0)
ffffffffc0203f9a:	01853903          	ld	s2,24(a0)
ffffffffc0203f9e:	02850663          	beq	a0,s0,ffffffffc0203fca <exit_mmap+0x44>
ffffffffc0203fa2:	ff043603          	ld	a2,-16(s0)
ffffffffc0203fa6:	fe843583          	ld	a1,-24(s0)
ffffffffc0203faa:	854a                	mv	a0,s2
ffffffffc0203fac:	e4efe0ef          	jal	ra,ffffffffc02025fa <unmap_range>
ffffffffc0203fb0:	6400                	ld	s0,8(s0)
ffffffffc0203fb2:	fe8498e3          	bne	s1,s0,ffffffffc0203fa2 <exit_mmap+0x1c>
ffffffffc0203fb6:	6400                	ld	s0,8(s0)
ffffffffc0203fb8:	00848c63          	beq	s1,s0,ffffffffc0203fd0 <exit_mmap+0x4a>
ffffffffc0203fbc:	ff043603          	ld	a2,-16(s0)
ffffffffc0203fc0:	fe843583          	ld	a1,-24(s0)
ffffffffc0203fc4:	854a                	mv	a0,s2
ffffffffc0203fc6:	f7afe0ef          	jal	ra,ffffffffc0202740 <exit_range>
ffffffffc0203fca:	6400                	ld	s0,8(s0)
ffffffffc0203fcc:	fe8498e3          	bne	s1,s0,ffffffffc0203fbc <exit_mmap+0x36>
ffffffffc0203fd0:	60e2                	ld	ra,24(sp)
ffffffffc0203fd2:	6442                	ld	s0,16(sp)
ffffffffc0203fd4:	64a2                	ld	s1,8(sp)
ffffffffc0203fd6:	6902                	ld	s2,0(sp)
ffffffffc0203fd8:	6105                	addi	sp,sp,32
ffffffffc0203fda:	8082                	ret
ffffffffc0203fdc:	00009697          	auipc	a3,0x9
ffffffffc0203fe0:	23c68693          	addi	a3,a3,572 # ffffffffc020d218 <default_pmm_manager+0x8f8>
ffffffffc0203fe4:	00008617          	auipc	a2,0x8
ffffffffc0203fe8:	e1c60613          	addi	a2,a2,-484 # ffffffffc020be00 <commands+0x210>
ffffffffc0203fec:	0e800593          	li	a1,232
ffffffffc0203ff0:	00009517          	auipc	a0,0x9
ffffffffc0203ff4:	17050513          	addi	a0,a0,368 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0203ff8:	ca6fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ffc <vmm_init>:
ffffffffc0203ffc:	7139                	addi	sp,sp,-64
ffffffffc0203ffe:	05800513          	li	a0,88
ffffffffc0204002:	fc06                	sd	ra,56(sp)
ffffffffc0204004:	f822                	sd	s0,48(sp)
ffffffffc0204006:	f426                	sd	s1,40(sp)
ffffffffc0204008:	f04a                	sd	s2,32(sp)
ffffffffc020400a:	ec4e                	sd	s3,24(sp)
ffffffffc020400c:	e852                	sd	s4,16(sp)
ffffffffc020400e:	e456                	sd	s5,8(sp)
ffffffffc0204010:	812fe0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0204014:	2e050963          	beqz	a0,ffffffffc0204306 <vmm_init+0x30a>
ffffffffc0204018:	e508                	sd	a0,8(a0)
ffffffffc020401a:	e108                	sd	a0,0(a0)
ffffffffc020401c:	00053823          	sd	zero,16(a0)
ffffffffc0204020:	00053c23          	sd	zero,24(a0)
ffffffffc0204024:	02052023          	sw	zero,32(a0)
ffffffffc0204028:	02053423          	sd	zero,40(a0)
ffffffffc020402c:	02052823          	sw	zero,48(a0)
ffffffffc0204030:	84aa                	mv	s1,a0
ffffffffc0204032:	4585                	li	a1,1
ffffffffc0204034:	03850513          	addi	a0,a0,56
ffffffffc0204038:	5ba000ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc020403c:	03200413          	li	s0,50
ffffffffc0204040:	a811                	j	ffffffffc0204054 <vmm_init+0x58>
ffffffffc0204042:	e500                	sd	s0,8(a0)
ffffffffc0204044:	e91c                	sd	a5,16(a0)
ffffffffc0204046:	00052c23          	sw	zero,24(a0)
ffffffffc020404a:	146d                	addi	s0,s0,-5
ffffffffc020404c:	8526                	mv	a0,s1
ffffffffc020404e:	ccdff0ef          	jal	ra,ffffffffc0203d1a <insert_vma_struct>
ffffffffc0204052:	c80d                	beqz	s0,ffffffffc0204084 <vmm_init+0x88>
ffffffffc0204054:	03000513          	li	a0,48
ffffffffc0204058:	fcbfd0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020405c:	85aa                	mv	a1,a0
ffffffffc020405e:	00240793          	addi	a5,s0,2
ffffffffc0204062:	f165                	bnez	a0,ffffffffc0204042 <vmm_init+0x46>
ffffffffc0204064:	00009697          	auipc	a3,0x9
ffffffffc0204068:	34c68693          	addi	a3,a3,844 # ffffffffc020d3b0 <default_pmm_manager+0xa90>
ffffffffc020406c:	00008617          	auipc	a2,0x8
ffffffffc0204070:	d9460613          	addi	a2,a2,-620 # ffffffffc020be00 <commands+0x210>
ffffffffc0204074:	12c00593          	li	a1,300
ffffffffc0204078:	00009517          	auipc	a0,0x9
ffffffffc020407c:	0e850513          	addi	a0,a0,232 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204080:	c1efc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204084:	03700413          	li	s0,55
ffffffffc0204088:	1f900913          	li	s2,505
ffffffffc020408c:	a819                	j	ffffffffc02040a2 <vmm_init+0xa6>
ffffffffc020408e:	e500                	sd	s0,8(a0)
ffffffffc0204090:	e91c                	sd	a5,16(a0)
ffffffffc0204092:	00052c23          	sw	zero,24(a0)
ffffffffc0204096:	0415                	addi	s0,s0,5
ffffffffc0204098:	8526                	mv	a0,s1
ffffffffc020409a:	c81ff0ef          	jal	ra,ffffffffc0203d1a <insert_vma_struct>
ffffffffc020409e:	03240a63          	beq	s0,s2,ffffffffc02040d2 <vmm_init+0xd6>
ffffffffc02040a2:	03000513          	li	a0,48
ffffffffc02040a6:	f7dfd0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc02040aa:	85aa                	mv	a1,a0
ffffffffc02040ac:	00240793          	addi	a5,s0,2
ffffffffc02040b0:	fd79                	bnez	a0,ffffffffc020408e <vmm_init+0x92>
ffffffffc02040b2:	00009697          	auipc	a3,0x9
ffffffffc02040b6:	2fe68693          	addi	a3,a3,766 # ffffffffc020d3b0 <default_pmm_manager+0xa90>
ffffffffc02040ba:	00008617          	auipc	a2,0x8
ffffffffc02040be:	d4660613          	addi	a2,a2,-698 # ffffffffc020be00 <commands+0x210>
ffffffffc02040c2:	13300593          	li	a1,307
ffffffffc02040c6:	00009517          	auipc	a0,0x9
ffffffffc02040ca:	09a50513          	addi	a0,a0,154 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc02040ce:	bd0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040d2:	649c                	ld	a5,8(s1)
ffffffffc02040d4:	471d                	li	a4,7
ffffffffc02040d6:	1fb00593          	li	a1,507
ffffffffc02040da:	16f48663          	beq	s1,a5,ffffffffc0204246 <vmm_init+0x24a>
ffffffffc02040de:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc02040e2:	ffe70693          	addi	a3,a4,-2
ffffffffc02040e6:	10d61063          	bne	a2,a3,ffffffffc02041e6 <vmm_init+0x1ea>
ffffffffc02040ea:	ff07b683          	ld	a3,-16(a5)
ffffffffc02040ee:	0ed71c63          	bne	a4,a3,ffffffffc02041e6 <vmm_init+0x1ea>
ffffffffc02040f2:	0715                	addi	a4,a4,5
ffffffffc02040f4:	679c                	ld	a5,8(a5)
ffffffffc02040f6:	feb712e3          	bne	a4,a1,ffffffffc02040da <vmm_init+0xde>
ffffffffc02040fa:	4a1d                	li	s4,7
ffffffffc02040fc:	4415                	li	s0,5
ffffffffc02040fe:	1f900a93          	li	s5,505
ffffffffc0204102:	85a2                	mv	a1,s0
ffffffffc0204104:	8526                	mv	a0,s1
ffffffffc0204106:	bd5ff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc020410a:	892a                	mv	s2,a0
ffffffffc020410c:	16050d63          	beqz	a0,ffffffffc0204286 <vmm_init+0x28a>
ffffffffc0204110:	00140593          	addi	a1,s0,1
ffffffffc0204114:	8526                	mv	a0,s1
ffffffffc0204116:	bc5ff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc020411a:	89aa                	mv	s3,a0
ffffffffc020411c:	14050563          	beqz	a0,ffffffffc0204266 <vmm_init+0x26a>
ffffffffc0204120:	85d2                	mv	a1,s4
ffffffffc0204122:	8526                	mv	a0,s1
ffffffffc0204124:	bb7ff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc0204128:	16051f63          	bnez	a0,ffffffffc02042a6 <vmm_init+0x2aa>
ffffffffc020412c:	00340593          	addi	a1,s0,3
ffffffffc0204130:	8526                	mv	a0,s1
ffffffffc0204132:	ba9ff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc0204136:	1a051863          	bnez	a0,ffffffffc02042e6 <vmm_init+0x2ea>
ffffffffc020413a:	00440593          	addi	a1,s0,4
ffffffffc020413e:	8526                	mv	a0,s1
ffffffffc0204140:	b9bff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc0204144:	18051163          	bnez	a0,ffffffffc02042c6 <vmm_init+0x2ca>
ffffffffc0204148:	00893783          	ld	a5,8(s2)
ffffffffc020414c:	0a879d63          	bne	a5,s0,ffffffffc0204206 <vmm_init+0x20a>
ffffffffc0204150:	01093783          	ld	a5,16(s2)
ffffffffc0204154:	0b479963          	bne	a5,s4,ffffffffc0204206 <vmm_init+0x20a>
ffffffffc0204158:	0089b783          	ld	a5,8(s3)
ffffffffc020415c:	0c879563          	bne	a5,s0,ffffffffc0204226 <vmm_init+0x22a>
ffffffffc0204160:	0109b783          	ld	a5,16(s3)
ffffffffc0204164:	0d479163          	bne	a5,s4,ffffffffc0204226 <vmm_init+0x22a>
ffffffffc0204168:	0415                	addi	s0,s0,5
ffffffffc020416a:	0a15                	addi	s4,s4,5
ffffffffc020416c:	f9541be3          	bne	s0,s5,ffffffffc0204102 <vmm_init+0x106>
ffffffffc0204170:	4411                	li	s0,4
ffffffffc0204172:	597d                	li	s2,-1
ffffffffc0204174:	85a2                	mv	a1,s0
ffffffffc0204176:	8526                	mv	a0,s1
ffffffffc0204178:	b63ff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc020417c:	0004059b          	sext.w	a1,s0
ffffffffc0204180:	c90d                	beqz	a0,ffffffffc02041b2 <vmm_init+0x1b6>
ffffffffc0204182:	6914                	ld	a3,16(a0)
ffffffffc0204184:	6510                	ld	a2,8(a0)
ffffffffc0204186:	00009517          	auipc	a0,0x9
ffffffffc020418a:	1b250513          	addi	a0,a0,434 # ffffffffc020d338 <default_pmm_manager+0xa18>
ffffffffc020418e:	818fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204192:	00009697          	auipc	a3,0x9
ffffffffc0204196:	1ce68693          	addi	a3,a3,462 # ffffffffc020d360 <default_pmm_manager+0xa40>
ffffffffc020419a:	00008617          	auipc	a2,0x8
ffffffffc020419e:	c6660613          	addi	a2,a2,-922 # ffffffffc020be00 <commands+0x210>
ffffffffc02041a2:	15900593          	li	a1,345
ffffffffc02041a6:	00009517          	auipc	a0,0x9
ffffffffc02041aa:	fba50513          	addi	a0,a0,-70 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc02041ae:	af0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b2:	147d                	addi	s0,s0,-1
ffffffffc02041b4:	fd2410e3          	bne	s0,s2,ffffffffc0204174 <vmm_init+0x178>
ffffffffc02041b8:	8526                	mv	a0,s1
ffffffffc02041ba:	c31ff0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc02041be:	00009517          	auipc	a0,0x9
ffffffffc02041c2:	1ba50513          	addi	a0,a0,442 # ffffffffc020d378 <default_pmm_manager+0xa58>
ffffffffc02041c6:	fe1fb0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02041ca:	7442                	ld	s0,48(sp)
ffffffffc02041cc:	70e2                	ld	ra,56(sp)
ffffffffc02041ce:	74a2                	ld	s1,40(sp)
ffffffffc02041d0:	7902                	ld	s2,32(sp)
ffffffffc02041d2:	69e2                	ld	s3,24(sp)
ffffffffc02041d4:	6a42                	ld	s4,16(sp)
ffffffffc02041d6:	6aa2                	ld	s5,8(sp)
ffffffffc02041d8:	00009517          	auipc	a0,0x9
ffffffffc02041dc:	1c050513          	addi	a0,a0,448 # ffffffffc020d398 <default_pmm_manager+0xa78>
ffffffffc02041e0:	6121                	addi	sp,sp,64
ffffffffc02041e2:	fc5fb06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02041e6:	00009697          	auipc	a3,0x9
ffffffffc02041ea:	06a68693          	addi	a3,a3,106 # ffffffffc020d250 <default_pmm_manager+0x930>
ffffffffc02041ee:	00008617          	auipc	a2,0x8
ffffffffc02041f2:	c1260613          	addi	a2,a2,-1006 # ffffffffc020be00 <commands+0x210>
ffffffffc02041f6:	13d00593          	li	a1,317
ffffffffc02041fa:	00009517          	auipc	a0,0x9
ffffffffc02041fe:	f6650513          	addi	a0,a0,-154 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204202:	a9cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204206:	00009697          	auipc	a3,0x9
ffffffffc020420a:	0d268693          	addi	a3,a3,210 # ffffffffc020d2d8 <default_pmm_manager+0x9b8>
ffffffffc020420e:	00008617          	auipc	a2,0x8
ffffffffc0204212:	bf260613          	addi	a2,a2,-1038 # ffffffffc020be00 <commands+0x210>
ffffffffc0204216:	14e00593          	li	a1,334
ffffffffc020421a:	00009517          	auipc	a0,0x9
ffffffffc020421e:	f4650513          	addi	a0,a0,-186 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204222:	a7cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204226:	00009697          	auipc	a3,0x9
ffffffffc020422a:	0e268693          	addi	a3,a3,226 # ffffffffc020d308 <default_pmm_manager+0x9e8>
ffffffffc020422e:	00008617          	auipc	a2,0x8
ffffffffc0204232:	bd260613          	addi	a2,a2,-1070 # ffffffffc020be00 <commands+0x210>
ffffffffc0204236:	14f00593          	li	a1,335
ffffffffc020423a:	00009517          	auipc	a0,0x9
ffffffffc020423e:	f2650513          	addi	a0,a0,-218 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204242:	a5cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204246:	00009697          	auipc	a3,0x9
ffffffffc020424a:	ff268693          	addi	a3,a3,-14 # ffffffffc020d238 <default_pmm_manager+0x918>
ffffffffc020424e:	00008617          	auipc	a2,0x8
ffffffffc0204252:	bb260613          	addi	a2,a2,-1102 # ffffffffc020be00 <commands+0x210>
ffffffffc0204256:	13b00593          	li	a1,315
ffffffffc020425a:	00009517          	auipc	a0,0x9
ffffffffc020425e:	f0650513          	addi	a0,a0,-250 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204262:	a3cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204266:	00009697          	auipc	a3,0x9
ffffffffc020426a:	03268693          	addi	a3,a3,50 # ffffffffc020d298 <default_pmm_manager+0x978>
ffffffffc020426e:	00008617          	auipc	a2,0x8
ffffffffc0204272:	b9260613          	addi	a2,a2,-1134 # ffffffffc020be00 <commands+0x210>
ffffffffc0204276:	14600593          	li	a1,326
ffffffffc020427a:	00009517          	auipc	a0,0x9
ffffffffc020427e:	ee650513          	addi	a0,a0,-282 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204282:	a1cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204286:	00009697          	auipc	a3,0x9
ffffffffc020428a:	00268693          	addi	a3,a3,2 # ffffffffc020d288 <default_pmm_manager+0x968>
ffffffffc020428e:	00008617          	auipc	a2,0x8
ffffffffc0204292:	b7260613          	addi	a2,a2,-1166 # ffffffffc020be00 <commands+0x210>
ffffffffc0204296:	14400593          	li	a1,324
ffffffffc020429a:	00009517          	auipc	a0,0x9
ffffffffc020429e:	ec650513          	addi	a0,a0,-314 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc02042a2:	9fcfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042a6:	00009697          	auipc	a3,0x9
ffffffffc02042aa:	00268693          	addi	a3,a3,2 # ffffffffc020d2a8 <default_pmm_manager+0x988>
ffffffffc02042ae:	00008617          	auipc	a2,0x8
ffffffffc02042b2:	b5260613          	addi	a2,a2,-1198 # ffffffffc020be00 <commands+0x210>
ffffffffc02042b6:	14800593          	li	a1,328
ffffffffc02042ba:	00009517          	auipc	a0,0x9
ffffffffc02042be:	ea650513          	addi	a0,a0,-346 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc02042c2:	9dcfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042c6:	00009697          	auipc	a3,0x9
ffffffffc02042ca:	00268693          	addi	a3,a3,2 # ffffffffc020d2c8 <default_pmm_manager+0x9a8>
ffffffffc02042ce:	00008617          	auipc	a2,0x8
ffffffffc02042d2:	b3260613          	addi	a2,a2,-1230 # ffffffffc020be00 <commands+0x210>
ffffffffc02042d6:	14c00593          	li	a1,332
ffffffffc02042da:	00009517          	auipc	a0,0x9
ffffffffc02042de:	e8650513          	addi	a0,a0,-378 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc02042e2:	9bcfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042e6:	00009697          	auipc	a3,0x9
ffffffffc02042ea:	fd268693          	addi	a3,a3,-46 # ffffffffc020d2b8 <default_pmm_manager+0x998>
ffffffffc02042ee:	00008617          	auipc	a2,0x8
ffffffffc02042f2:	b1260613          	addi	a2,a2,-1262 # ffffffffc020be00 <commands+0x210>
ffffffffc02042f6:	14a00593          	li	a1,330
ffffffffc02042fa:	00009517          	auipc	a0,0x9
ffffffffc02042fe:	e6650513          	addi	a0,a0,-410 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204302:	99cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204306:	00009697          	auipc	a3,0x9
ffffffffc020430a:	ee268693          	addi	a3,a3,-286 # ffffffffc020d1e8 <default_pmm_manager+0x8c8>
ffffffffc020430e:	00008617          	auipc	a2,0x8
ffffffffc0204312:	af260613          	addi	a2,a2,-1294 # ffffffffc020be00 <commands+0x210>
ffffffffc0204316:	12400593          	li	a1,292
ffffffffc020431a:	00009517          	auipc	a0,0x9
ffffffffc020431e:	e4650513          	addi	a0,a0,-442 # ffffffffc020d160 <default_pmm_manager+0x840>
ffffffffc0204322:	97cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204326 <user_mem_check>:
ffffffffc0204326:	7179                	addi	sp,sp,-48
ffffffffc0204328:	f022                	sd	s0,32(sp)
ffffffffc020432a:	f406                	sd	ra,40(sp)
ffffffffc020432c:	ec26                	sd	s1,24(sp)
ffffffffc020432e:	e84a                	sd	s2,16(sp)
ffffffffc0204330:	e44e                	sd	s3,8(sp)
ffffffffc0204332:	e052                	sd	s4,0(sp)
ffffffffc0204334:	842e                	mv	s0,a1
ffffffffc0204336:	c135                	beqz	a0,ffffffffc020439a <user_mem_check+0x74>
ffffffffc0204338:	002007b7          	lui	a5,0x200
ffffffffc020433c:	04f5e663          	bltu	a1,a5,ffffffffc0204388 <user_mem_check+0x62>
ffffffffc0204340:	00c584b3          	add	s1,a1,a2
ffffffffc0204344:	0495f263          	bgeu	a1,s1,ffffffffc0204388 <user_mem_check+0x62>
ffffffffc0204348:	4785                	li	a5,1
ffffffffc020434a:	07fe                	slli	a5,a5,0x1f
ffffffffc020434c:	0297ee63          	bltu	a5,s1,ffffffffc0204388 <user_mem_check+0x62>
ffffffffc0204350:	892a                	mv	s2,a0
ffffffffc0204352:	89b6                	mv	s3,a3
ffffffffc0204354:	6a05                	lui	s4,0x1
ffffffffc0204356:	a821                	j	ffffffffc020436e <user_mem_check+0x48>
ffffffffc0204358:	0027f693          	andi	a3,a5,2
ffffffffc020435c:	9752                	add	a4,a4,s4
ffffffffc020435e:	8ba1                	andi	a5,a5,8
ffffffffc0204360:	c685                	beqz	a3,ffffffffc0204388 <user_mem_check+0x62>
ffffffffc0204362:	c399                	beqz	a5,ffffffffc0204368 <user_mem_check+0x42>
ffffffffc0204364:	02e46263          	bltu	s0,a4,ffffffffc0204388 <user_mem_check+0x62>
ffffffffc0204368:	6900                	ld	s0,16(a0)
ffffffffc020436a:	04947663          	bgeu	s0,s1,ffffffffc02043b6 <user_mem_check+0x90>
ffffffffc020436e:	85a2                	mv	a1,s0
ffffffffc0204370:	854a                	mv	a0,s2
ffffffffc0204372:	969ff0ef          	jal	ra,ffffffffc0203cda <find_vma>
ffffffffc0204376:	c909                	beqz	a0,ffffffffc0204388 <user_mem_check+0x62>
ffffffffc0204378:	6518                	ld	a4,8(a0)
ffffffffc020437a:	00e46763          	bltu	s0,a4,ffffffffc0204388 <user_mem_check+0x62>
ffffffffc020437e:	4d1c                	lw	a5,24(a0)
ffffffffc0204380:	fc099ce3          	bnez	s3,ffffffffc0204358 <user_mem_check+0x32>
ffffffffc0204384:	8b85                	andi	a5,a5,1
ffffffffc0204386:	f3ed                	bnez	a5,ffffffffc0204368 <user_mem_check+0x42>
ffffffffc0204388:	4501                	li	a0,0
ffffffffc020438a:	70a2                	ld	ra,40(sp)
ffffffffc020438c:	7402                	ld	s0,32(sp)
ffffffffc020438e:	64e2                	ld	s1,24(sp)
ffffffffc0204390:	6942                	ld	s2,16(sp)
ffffffffc0204392:	69a2                	ld	s3,8(sp)
ffffffffc0204394:	6a02                	ld	s4,0(sp)
ffffffffc0204396:	6145                	addi	sp,sp,48
ffffffffc0204398:	8082                	ret
ffffffffc020439a:	c02007b7          	lui	a5,0xc0200
ffffffffc020439e:	4501                	li	a0,0
ffffffffc02043a0:	fef5e5e3          	bltu	a1,a5,ffffffffc020438a <user_mem_check+0x64>
ffffffffc02043a4:	962e                	add	a2,a2,a1
ffffffffc02043a6:	fec5f2e3          	bgeu	a1,a2,ffffffffc020438a <user_mem_check+0x64>
ffffffffc02043aa:	c8000537          	lui	a0,0xc8000
ffffffffc02043ae:	0505                	addi	a0,a0,1
ffffffffc02043b0:	00a63533          	sltu	a0,a2,a0
ffffffffc02043b4:	bfd9                	j	ffffffffc020438a <user_mem_check+0x64>
ffffffffc02043b6:	4505                	li	a0,1
ffffffffc02043b8:	bfc9                	j	ffffffffc020438a <user_mem_check+0x64>

ffffffffc02043ba <copy_from_user>:
ffffffffc02043ba:	1101                	addi	sp,sp,-32
ffffffffc02043bc:	e822                	sd	s0,16(sp)
ffffffffc02043be:	e426                	sd	s1,8(sp)
ffffffffc02043c0:	8432                	mv	s0,a2
ffffffffc02043c2:	84b6                	mv	s1,a3
ffffffffc02043c4:	e04a                	sd	s2,0(sp)
ffffffffc02043c6:	86ba                	mv	a3,a4
ffffffffc02043c8:	892e                	mv	s2,a1
ffffffffc02043ca:	8626                	mv	a2,s1
ffffffffc02043cc:	85a2                	mv	a1,s0
ffffffffc02043ce:	ec06                	sd	ra,24(sp)
ffffffffc02043d0:	f57ff0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc02043d4:	c519                	beqz	a0,ffffffffc02043e2 <copy_from_user+0x28>
ffffffffc02043d6:	8626                	mv	a2,s1
ffffffffc02043d8:	85a2                	mv	a1,s0
ffffffffc02043da:	854a                	mv	a0,s2
ffffffffc02043dc:	58e070ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc02043e0:	4505                	li	a0,1
ffffffffc02043e2:	60e2                	ld	ra,24(sp)
ffffffffc02043e4:	6442                	ld	s0,16(sp)
ffffffffc02043e6:	64a2                	ld	s1,8(sp)
ffffffffc02043e8:	6902                	ld	s2,0(sp)
ffffffffc02043ea:	6105                	addi	sp,sp,32
ffffffffc02043ec:	8082                	ret

ffffffffc02043ee <copy_to_user>:
ffffffffc02043ee:	1101                	addi	sp,sp,-32
ffffffffc02043f0:	e822                	sd	s0,16(sp)
ffffffffc02043f2:	8436                	mv	s0,a3
ffffffffc02043f4:	e04a                	sd	s2,0(sp)
ffffffffc02043f6:	4685                	li	a3,1
ffffffffc02043f8:	8932                	mv	s2,a2
ffffffffc02043fa:	8622                	mv	a2,s0
ffffffffc02043fc:	e426                	sd	s1,8(sp)
ffffffffc02043fe:	ec06                	sd	ra,24(sp)
ffffffffc0204400:	84ae                	mv	s1,a1
ffffffffc0204402:	f25ff0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc0204406:	c519                	beqz	a0,ffffffffc0204414 <copy_to_user+0x26>
ffffffffc0204408:	8622                	mv	a2,s0
ffffffffc020440a:	85ca                	mv	a1,s2
ffffffffc020440c:	8526                	mv	a0,s1
ffffffffc020440e:	55c070ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0204412:	4505                	li	a0,1
ffffffffc0204414:	60e2                	ld	ra,24(sp)
ffffffffc0204416:	6442                	ld	s0,16(sp)
ffffffffc0204418:	64a2                	ld	s1,8(sp)
ffffffffc020441a:	6902                	ld	s2,0(sp)
ffffffffc020441c:	6105                	addi	sp,sp,32
ffffffffc020441e:	8082                	ret

ffffffffc0204420 <copy_string>:
ffffffffc0204420:	7139                	addi	sp,sp,-64
ffffffffc0204422:	ec4e                	sd	s3,24(sp)
ffffffffc0204424:	6985                	lui	s3,0x1
ffffffffc0204426:	99b2                	add	s3,s3,a2
ffffffffc0204428:	77fd                	lui	a5,0xfffff
ffffffffc020442a:	00f9f9b3          	and	s3,s3,a5
ffffffffc020442e:	f426                	sd	s1,40(sp)
ffffffffc0204430:	f04a                	sd	s2,32(sp)
ffffffffc0204432:	e852                	sd	s4,16(sp)
ffffffffc0204434:	e456                	sd	s5,8(sp)
ffffffffc0204436:	fc06                	sd	ra,56(sp)
ffffffffc0204438:	f822                	sd	s0,48(sp)
ffffffffc020443a:	84b2                	mv	s1,a2
ffffffffc020443c:	8aaa                	mv	s5,a0
ffffffffc020443e:	8a2e                	mv	s4,a1
ffffffffc0204440:	8936                	mv	s2,a3
ffffffffc0204442:	40c989b3          	sub	s3,s3,a2
ffffffffc0204446:	a015                	j	ffffffffc020446a <copy_string+0x4a>
ffffffffc0204448:	448070ef          	jal	ra,ffffffffc020b890 <strnlen>
ffffffffc020444c:	87aa                	mv	a5,a0
ffffffffc020444e:	85a6                	mv	a1,s1
ffffffffc0204450:	8552                	mv	a0,s4
ffffffffc0204452:	8622                	mv	a2,s0
ffffffffc0204454:	0487e363          	bltu	a5,s0,ffffffffc020449a <copy_string+0x7a>
ffffffffc0204458:	0329f763          	bgeu	s3,s2,ffffffffc0204486 <copy_string+0x66>
ffffffffc020445c:	50e070ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0204460:	9a22                	add	s4,s4,s0
ffffffffc0204462:	94a2                	add	s1,s1,s0
ffffffffc0204464:	40890933          	sub	s2,s2,s0
ffffffffc0204468:	6985                	lui	s3,0x1
ffffffffc020446a:	4681                	li	a3,0
ffffffffc020446c:	85a6                	mv	a1,s1
ffffffffc020446e:	8556                	mv	a0,s5
ffffffffc0204470:	844a                	mv	s0,s2
ffffffffc0204472:	0129f363          	bgeu	s3,s2,ffffffffc0204478 <copy_string+0x58>
ffffffffc0204476:	844e                	mv	s0,s3
ffffffffc0204478:	8622                	mv	a2,s0
ffffffffc020447a:	eadff0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc020447e:	87aa                	mv	a5,a0
ffffffffc0204480:	85a2                	mv	a1,s0
ffffffffc0204482:	8526                	mv	a0,s1
ffffffffc0204484:	f3f1                	bnez	a5,ffffffffc0204448 <copy_string+0x28>
ffffffffc0204486:	4501                	li	a0,0
ffffffffc0204488:	70e2                	ld	ra,56(sp)
ffffffffc020448a:	7442                	ld	s0,48(sp)
ffffffffc020448c:	74a2                	ld	s1,40(sp)
ffffffffc020448e:	7902                	ld	s2,32(sp)
ffffffffc0204490:	69e2                	ld	s3,24(sp)
ffffffffc0204492:	6a42                	ld	s4,16(sp)
ffffffffc0204494:	6aa2                	ld	s5,8(sp)
ffffffffc0204496:	6121                	addi	sp,sp,64
ffffffffc0204498:	8082                	ret
ffffffffc020449a:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc020449e:	4cc070ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc02044a2:	4505                	li	a0,1
ffffffffc02044a4:	b7d5                	j	ffffffffc0204488 <copy_string+0x68>

ffffffffc02044a6 <do_pgfault>:
ffffffffc02044a6:	5575                	li	a0,-3
ffffffffc02044a8:	8082                	ret

ffffffffc02044aa <__down.constprop.0>:
ffffffffc02044aa:	715d                	addi	sp,sp,-80
ffffffffc02044ac:	e0a2                	sd	s0,64(sp)
ffffffffc02044ae:	e486                	sd	ra,72(sp)
ffffffffc02044b0:	fc26                	sd	s1,56(sp)
ffffffffc02044b2:	842a                	mv	s0,a0
ffffffffc02044b4:	100027f3          	csrr	a5,sstatus
ffffffffc02044b8:	8b89                	andi	a5,a5,2
ffffffffc02044ba:	ebb1                	bnez	a5,ffffffffc020450e <__down.constprop.0+0x64>
ffffffffc02044bc:	411c                	lw	a5,0(a0)
ffffffffc02044be:	00f05a63          	blez	a5,ffffffffc02044d2 <__down.constprop.0+0x28>
ffffffffc02044c2:	37fd                	addiw	a5,a5,-1
ffffffffc02044c4:	c11c                	sw	a5,0(a0)
ffffffffc02044c6:	4501                	li	a0,0
ffffffffc02044c8:	60a6                	ld	ra,72(sp)
ffffffffc02044ca:	6406                	ld	s0,64(sp)
ffffffffc02044cc:	74e2                	ld	s1,56(sp)
ffffffffc02044ce:	6161                	addi	sp,sp,80
ffffffffc02044d0:	8082                	ret
ffffffffc02044d2:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc02044d6:	0024                	addi	s1,sp,8
ffffffffc02044d8:	10000613          	li	a2,256
ffffffffc02044dc:	85a6                	mv	a1,s1
ffffffffc02044de:	8522                	mv	a0,s0
ffffffffc02044e0:	2d8000ef          	jal	ra,ffffffffc02047b8 <wait_current_set>
ffffffffc02044e4:	2d4030ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc02044e8:	100027f3          	csrr	a5,sstatus
ffffffffc02044ec:	8b89                	andi	a5,a5,2
ffffffffc02044ee:	efb9                	bnez	a5,ffffffffc020454c <__down.constprop.0+0xa2>
ffffffffc02044f0:	8526                	mv	a0,s1
ffffffffc02044f2:	19c000ef          	jal	ra,ffffffffc020468e <wait_in_queue>
ffffffffc02044f6:	e531                	bnez	a0,ffffffffc0204542 <__down.constprop.0+0x98>
ffffffffc02044f8:	4542                	lw	a0,16(sp)
ffffffffc02044fa:	10000793          	li	a5,256
ffffffffc02044fe:	fcf515e3          	bne	a0,a5,ffffffffc02044c8 <__down.constprop.0+0x1e>
ffffffffc0204502:	60a6                	ld	ra,72(sp)
ffffffffc0204504:	6406                	ld	s0,64(sp)
ffffffffc0204506:	74e2                	ld	s1,56(sp)
ffffffffc0204508:	4501                	li	a0,0
ffffffffc020450a:	6161                	addi	sp,sp,80
ffffffffc020450c:	8082                	ret
ffffffffc020450e:	f64fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204512:	401c                	lw	a5,0(s0)
ffffffffc0204514:	00f05c63          	blez	a5,ffffffffc020452c <__down.constprop.0+0x82>
ffffffffc0204518:	37fd                	addiw	a5,a5,-1
ffffffffc020451a:	c01c                	sw	a5,0(s0)
ffffffffc020451c:	f50fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204520:	60a6                	ld	ra,72(sp)
ffffffffc0204522:	6406                	ld	s0,64(sp)
ffffffffc0204524:	74e2                	ld	s1,56(sp)
ffffffffc0204526:	4501                	li	a0,0
ffffffffc0204528:	6161                	addi	sp,sp,80
ffffffffc020452a:	8082                	ret
ffffffffc020452c:	0421                	addi	s0,s0,8
ffffffffc020452e:	0024                	addi	s1,sp,8
ffffffffc0204530:	10000613          	li	a2,256
ffffffffc0204534:	85a6                	mv	a1,s1
ffffffffc0204536:	8522                	mv	a0,s0
ffffffffc0204538:	280000ef          	jal	ra,ffffffffc02047b8 <wait_current_set>
ffffffffc020453c:	f30fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204540:	b755                	j	ffffffffc02044e4 <__down.constprop.0+0x3a>
ffffffffc0204542:	85a6                	mv	a1,s1
ffffffffc0204544:	8522                	mv	a0,s0
ffffffffc0204546:	0ee000ef          	jal	ra,ffffffffc0204634 <wait_queue_del>
ffffffffc020454a:	b77d                	j	ffffffffc02044f8 <__down.constprop.0+0x4e>
ffffffffc020454c:	f26fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204550:	8526                	mv	a0,s1
ffffffffc0204552:	13c000ef          	jal	ra,ffffffffc020468e <wait_in_queue>
ffffffffc0204556:	e501                	bnez	a0,ffffffffc020455e <__down.constprop.0+0xb4>
ffffffffc0204558:	f14fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020455c:	bf71                	j	ffffffffc02044f8 <__down.constprop.0+0x4e>
ffffffffc020455e:	85a6                	mv	a1,s1
ffffffffc0204560:	8522                	mv	a0,s0
ffffffffc0204562:	0d2000ef          	jal	ra,ffffffffc0204634 <wait_queue_del>
ffffffffc0204566:	bfcd                	j	ffffffffc0204558 <__down.constprop.0+0xae>

ffffffffc0204568 <__up.constprop.0>:
ffffffffc0204568:	1101                	addi	sp,sp,-32
ffffffffc020456a:	e822                	sd	s0,16(sp)
ffffffffc020456c:	ec06                	sd	ra,24(sp)
ffffffffc020456e:	e426                	sd	s1,8(sp)
ffffffffc0204570:	e04a                	sd	s2,0(sp)
ffffffffc0204572:	842a                	mv	s0,a0
ffffffffc0204574:	100027f3          	csrr	a5,sstatus
ffffffffc0204578:	8b89                	andi	a5,a5,2
ffffffffc020457a:	4901                	li	s2,0
ffffffffc020457c:	eba1                	bnez	a5,ffffffffc02045cc <__up.constprop.0+0x64>
ffffffffc020457e:	00840493          	addi	s1,s0,8
ffffffffc0204582:	8526                	mv	a0,s1
ffffffffc0204584:	0ee000ef          	jal	ra,ffffffffc0204672 <wait_queue_first>
ffffffffc0204588:	85aa                	mv	a1,a0
ffffffffc020458a:	cd0d                	beqz	a0,ffffffffc02045c4 <__up.constprop.0+0x5c>
ffffffffc020458c:	6118                	ld	a4,0(a0)
ffffffffc020458e:	10000793          	li	a5,256
ffffffffc0204592:	0ec72703          	lw	a4,236(a4)
ffffffffc0204596:	02f71f63          	bne	a4,a5,ffffffffc02045d4 <__up.constprop.0+0x6c>
ffffffffc020459a:	4685                	li	a3,1
ffffffffc020459c:	10000613          	li	a2,256
ffffffffc02045a0:	8526                	mv	a0,s1
ffffffffc02045a2:	0fa000ef          	jal	ra,ffffffffc020469c <wakeup_wait>
ffffffffc02045a6:	00091863          	bnez	s2,ffffffffc02045b6 <__up.constprop.0+0x4e>
ffffffffc02045aa:	60e2                	ld	ra,24(sp)
ffffffffc02045ac:	6442                	ld	s0,16(sp)
ffffffffc02045ae:	64a2                	ld	s1,8(sp)
ffffffffc02045b0:	6902                	ld	s2,0(sp)
ffffffffc02045b2:	6105                	addi	sp,sp,32
ffffffffc02045b4:	8082                	ret
ffffffffc02045b6:	6442                	ld	s0,16(sp)
ffffffffc02045b8:	60e2                	ld	ra,24(sp)
ffffffffc02045ba:	64a2                	ld	s1,8(sp)
ffffffffc02045bc:	6902                	ld	s2,0(sp)
ffffffffc02045be:	6105                	addi	sp,sp,32
ffffffffc02045c0:	eacfc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02045c4:	401c                	lw	a5,0(s0)
ffffffffc02045c6:	2785                	addiw	a5,a5,1
ffffffffc02045c8:	c01c                	sw	a5,0(s0)
ffffffffc02045ca:	bff1                	j	ffffffffc02045a6 <__up.constprop.0+0x3e>
ffffffffc02045cc:	ea6fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02045d0:	4905                	li	s2,1
ffffffffc02045d2:	b775                	j	ffffffffc020457e <__up.constprop.0+0x16>
ffffffffc02045d4:	00009697          	auipc	a3,0x9
ffffffffc02045d8:	dec68693          	addi	a3,a3,-532 # ffffffffc020d3c0 <default_pmm_manager+0xaa0>
ffffffffc02045dc:	00008617          	auipc	a2,0x8
ffffffffc02045e0:	82460613          	addi	a2,a2,-2012 # ffffffffc020be00 <commands+0x210>
ffffffffc02045e4:	45e5                	li	a1,25
ffffffffc02045e6:	00009517          	auipc	a0,0x9
ffffffffc02045ea:	e0250513          	addi	a0,a0,-510 # ffffffffc020d3e8 <default_pmm_manager+0xac8>
ffffffffc02045ee:	eb1fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045f2 <sem_init>:
ffffffffc02045f2:	c10c                	sw	a1,0(a0)
ffffffffc02045f4:	0521                	addi	a0,a0,8
ffffffffc02045f6:	a825                	j	ffffffffc020462e <wait_queue_init>

ffffffffc02045f8 <up>:
ffffffffc02045f8:	f71ff06f          	j	ffffffffc0204568 <__up.constprop.0>

ffffffffc02045fc <down>:
ffffffffc02045fc:	1141                	addi	sp,sp,-16
ffffffffc02045fe:	e406                	sd	ra,8(sp)
ffffffffc0204600:	eabff0ef          	jal	ra,ffffffffc02044aa <__down.constprop.0>
ffffffffc0204604:	2501                	sext.w	a0,a0
ffffffffc0204606:	e501                	bnez	a0,ffffffffc020460e <down+0x12>
ffffffffc0204608:	60a2                	ld	ra,8(sp)
ffffffffc020460a:	0141                	addi	sp,sp,16
ffffffffc020460c:	8082                	ret
ffffffffc020460e:	00009697          	auipc	a3,0x9
ffffffffc0204612:	dea68693          	addi	a3,a3,-534 # ffffffffc020d3f8 <default_pmm_manager+0xad8>
ffffffffc0204616:	00007617          	auipc	a2,0x7
ffffffffc020461a:	7ea60613          	addi	a2,a2,2026 # ffffffffc020be00 <commands+0x210>
ffffffffc020461e:	04000593          	li	a1,64
ffffffffc0204622:	00009517          	auipc	a0,0x9
ffffffffc0204626:	dc650513          	addi	a0,a0,-570 # ffffffffc020d3e8 <default_pmm_manager+0xac8>
ffffffffc020462a:	e75fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020462e <wait_queue_init>:
ffffffffc020462e:	e508                	sd	a0,8(a0)
ffffffffc0204630:	e108                	sd	a0,0(a0)
ffffffffc0204632:	8082                	ret

ffffffffc0204634 <wait_queue_del>:
ffffffffc0204634:	7198                	ld	a4,32(a1)
ffffffffc0204636:	01858793          	addi	a5,a1,24
ffffffffc020463a:	00e78b63          	beq	a5,a4,ffffffffc0204650 <wait_queue_del+0x1c>
ffffffffc020463e:	6994                	ld	a3,16(a1)
ffffffffc0204640:	00a69863          	bne	a3,a0,ffffffffc0204650 <wait_queue_del+0x1c>
ffffffffc0204644:	6d94                	ld	a3,24(a1)
ffffffffc0204646:	e698                	sd	a4,8(a3)
ffffffffc0204648:	e314                	sd	a3,0(a4)
ffffffffc020464a:	f19c                	sd	a5,32(a1)
ffffffffc020464c:	ed9c                	sd	a5,24(a1)
ffffffffc020464e:	8082                	ret
ffffffffc0204650:	1141                	addi	sp,sp,-16
ffffffffc0204652:	00009697          	auipc	a3,0x9
ffffffffc0204656:	e0668693          	addi	a3,a3,-506 # ffffffffc020d458 <default_pmm_manager+0xb38>
ffffffffc020465a:	00007617          	auipc	a2,0x7
ffffffffc020465e:	7a660613          	addi	a2,a2,1958 # ffffffffc020be00 <commands+0x210>
ffffffffc0204662:	45f1                	li	a1,28
ffffffffc0204664:	00009517          	auipc	a0,0x9
ffffffffc0204668:	ddc50513          	addi	a0,a0,-548 # ffffffffc020d440 <default_pmm_manager+0xb20>
ffffffffc020466c:	e406                	sd	ra,8(sp)
ffffffffc020466e:	e31fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204672 <wait_queue_first>:
ffffffffc0204672:	651c                	ld	a5,8(a0)
ffffffffc0204674:	00f50563          	beq	a0,a5,ffffffffc020467e <wait_queue_first+0xc>
ffffffffc0204678:	fe878513          	addi	a0,a5,-24
ffffffffc020467c:	8082                	ret
ffffffffc020467e:	4501                	li	a0,0
ffffffffc0204680:	8082                	ret

ffffffffc0204682 <wait_queue_empty>:
ffffffffc0204682:	651c                	ld	a5,8(a0)
ffffffffc0204684:	40a78533          	sub	a0,a5,a0
ffffffffc0204688:	00153513          	seqz	a0,a0
ffffffffc020468c:	8082                	ret

ffffffffc020468e <wait_in_queue>:
ffffffffc020468e:	711c                	ld	a5,32(a0)
ffffffffc0204690:	0561                	addi	a0,a0,24
ffffffffc0204692:	40a78533          	sub	a0,a5,a0
ffffffffc0204696:	00a03533          	snez	a0,a0
ffffffffc020469a:	8082                	ret

ffffffffc020469c <wakeup_wait>:
ffffffffc020469c:	e689                	bnez	a3,ffffffffc02046a6 <wakeup_wait+0xa>
ffffffffc020469e:	6188                	ld	a0,0(a1)
ffffffffc02046a0:	c590                	sw	a2,8(a1)
ffffffffc02046a2:	0640306f          	j	ffffffffc0207706 <wakeup_proc>
ffffffffc02046a6:	7198                	ld	a4,32(a1)
ffffffffc02046a8:	01858793          	addi	a5,a1,24
ffffffffc02046ac:	00e78e63          	beq	a5,a4,ffffffffc02046c8 <wakeup_wait+0x2c>
ffffffffc02046b0:	6994                	ld	a3,16(a1)
ffffffffc02046b2:	00d51b63          	bne	a0,a3,ffffffffc02046c8 <wakeup_wait+0x2c>
ffffffffc02046b6:	6d94                	ld	a3,24(a1)
ffffffffc02046b8:	6188                	ld	a0,0(a1)
ffffffffc02046ba:	e698                	sd	a4,8(a3)
ffffffffc02046bc:	e314                	sd	a3,0(a4)
ffffffffc02046be:	f19c                	sd	a5,32(a1)
ffffffffc02046c0:	ed9c                	sd	a5,24(a1)
ffffffffc02046c2:	c590                	sw	a2,8(a1)
ffffffffc02046c4:	0420306f          	j	ffffffffc0207706 <wakeup_proc>
ffffffffc02046c8:	1141                	addi	sp,sp,-16
ffffffffc02046ca:	00009697          	auipc	a3,0x9
ffffffffc02046ce:	d8e68693          	addi	a3,a3,-626 # ffffffffc020d458 <default_pmm_manager+0xb38>
ffffffffc02046d2:	00007617          	auipc	a2,0x7
ffffffffc02046d6:	72e60613          	addi	a2,a2,1838 # ffffffffc020be00 <commands+0x210>
ffffffffc02046da:	45f1                	li	a1,28
ffffffffc02046dc:	00009517          	auipc	a0,0x9
ffffffffc02046e0:	d6450513          	addi	a0,a0,-668 # ffffffffc020d440 <default_pmm_manager+0xb20>
ffffffffc02046e4:	e406                	sd	ra,8(sp)
ffffffffc02046e6:	db9fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046ea <wakeup_queue>:
ffffffffc02046ea:	651c                	ld	a5,8(a0)
ffffffffc02046ec:	0ca78563          	beq	a5,a0,ffffffffc02047b6 <wakeup_queue+0xcc>
ffffffffc02046f0:	1101                	addi	sp,sp,-32
ffffffffc02046f2:	e822                	sd	s0,16(sp)
ffffffffc02046f4:	e426                	sd	s1,8(sp)
ffffffffc02046f6:	e04a                	sd	s2,0(sp)
ffffffffc02046f8:	ec06                	sd	ra,24(sp)
ffffffffc02046fa:	84aa                	mv	s1,a0
ffffffffc02046fc:	892e                	mv	s2,a1
ffffffffc02046fe:	fe878413          	addi	s0,a5,-24
ffffffffc0204702:	e23d                	bnez	a2,ffffffffc0204768 <wakeup_queue+0x7e>
ffffffffc0204704:	6008                	ld	a0,0(s0)
ffffffffc0204706:	01242423          	sw	s2,8(s0)
ffffffffc020470a:	7fd020ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc020470e:	701c                	ld	a5,32(s0)
ffffffffc0204710:	01840713          	addi	a4,s0,24
ffffffffc0204714:	02e78463          	beq	a5,a4,ffffffffc020473c <wakeup_queue+0x52>
ffffffffc0204718:	6818                	ld	a4,16(s0)
ffffffffc020471a:	02e49163          	bne	s1,a4,ffffffffc020473c <wakeup_queue+0x52>
ffffffffc020471e:	02f48f63          	beq	s1,a5,ffffffffc020475c <wakeup_queue+0x72>
ffffffffc0204722:	fe87b503          	ld	a0,-24(a5)
ffffffffc0204726:	ff27a823          	sw	s2,-16(a5)
ffffffffc020472a:	fe878413          	addi	s0,a5,-24
ffffffffc020472e:	7d9020ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc0204732:	701c                	ld	a5,32(s0)
ffffffffc0204734:	01840713          	addi	a4,s0,24
ffffffffc0204738:	fee790e3          	bne	a5,a4,ffffffffc0204718 <wakeup_queue+0x2e>
ffffffffc020473c:	00009697          	auipc	a3,0x9
ffffffffc0204740:	d1c68693          	addi	a3,a3,-740 # ffffffffc020d458 <default_pmm_manager+0xb38>
ffffffffc0204744:	00007617          	auipc	a2,0x7
ffffffffc0204748:	6bc60613          	addi	a2,a2,1724 # ffffffffc020be00 <commands+0x210>
ffffffffc020474c:	02200593          	li	a1,34
ffffffffc0204750:	00009517          	auipc	a0,0x9
ffffffffc0204754:	cf050513          	addi	a0,a0,-784 # ffffffffc020d440 <default_pmm_manager+0xb20>
ffffffffc0204758:	d47fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020475c:	60e2                	ld	ra,24(sp)
ffffffffc020475e:	6442                	ld	s0,16(sp)
ffffffffc0204760:	64a2                	ld	s1,8(sp)
ffffffffc0204762:	6902                	ld	s2,0(sp)
ffffffffc0204764:	6105                	addi	sp,sp,32
ffffffffc0204766:	8082                	ret
ffffffffc0204768:	6798                	ld	a4,8(a5)
ffffffffc020476a:	02f70763          	beq	a4,a5,ffffffffc0204798 <wakeup_queue+0xae>
ffffffffc020476e:	6814                	ld	a3,16(s0)
ffffffffc0204770:	02d49463          	bne	s1,a3,ffffffffc0204798 <wakeup_queue+0xae>
ffffffffc0204774:	6c14                	ld	a3,24(s0)
ffffffffc0204776:	6008                	ld	a0,0(s0)
ffffffffc0204778:	e698                	sd	a4,8(a3)
ffffffffc020477a:	e314                	sd	a3,0(a4)
ffffffffc020477c:	f01c                	sd	a5,32(s0)
ffffffffc020477e:	ec1c                	sd	a5,24(s0)
ffffffffc0204780:	01242423          	sw	s2,8(s0)
ffffffffc0204784:	783020ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc0204788:	6480                	ld	s0,8(s1)
ffffffffc020478a:	fc8489e3          	beq	s1,s0,ffffffffc020475c <wakeup_queue+0x72>
ffffffffc020478e:	6418                	ld	a4,8(s0)
ffffffffc0204790:	87a2                	mv	a5,s0
ffffffffc0204792:	1421                	addi	s0,s0,-24
ffffffffc0204794:	fce79de3          	bne	a5,a4,ffffffffc020476e <wakeup_queue+0x84>
ffffffffc0204798:	00009697          	auipc	a3,0x9
ffffffffc020479c:	cc068693          	addi	a3,a3,-832 # ffffffffc020d458 <default_pmm_manager+0xb38>
ffffffffc02047a0:	00007617          	auipc	a2,0x7
ffffffffc02047a4:	66060613          	addi	a2,a2,1632 # ffffffffc020be00 <commands+0x210>
ffffffffc02047a8:	45f1                	li	a1,28
ffffffffc02047aa:	00009517          	auipc	a0,0x9
ffffffffc02047ae:	c9650513          	addi	a0,a0,-874 # ffffffffc020d440 <default_pmm_manager+0xb20>
ffffffffc02047b2:	cedfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02047b6:	8082                	ret

ffffffffc02047b8 <wait_current_set>:
ffffffffc02047b8:	00092797          	auipc	a5,0x92
ffffffffc02047bc:	1087b783          	ld	a5,264(a5) # ffffffffc02968c0 <current>
ffffffffc02047c0:	c39d                	beqz	a5,ffffffffc02047e6 <wait_current_set+0x2e>
ffffffffc02047c2:	01858713          	addi	a4,a1,24
ffffffffc02047c6:	800006b7          	lui	a3,0x80000
ffffffffc02047ca:	ed98                	sd	a4,24(a1)
ffffffffc02047cc:	e19c                	sd	a5,0(a1)
ffffffffc02047ce:	c594                	sw	a3,8(a1)
ffffffffc02047d0:	4685                	li	a3,1
ffffffffc02047d2:	c394                	sw	a3,0(a5)
ffffffffc02047d4:	0ec7a623          	sw	a2,236(a5)
ffffffffc02047d8:	611c                	ld	a5,0(a0)
ffffffffc02047da:	e988                	sd	a0,16(a1)
ffffffffc02047dc:	e118                	sd	a4,0(a0)
ffffffffc02047de:	e798                	sd	a4,8(a5)
ffffffffc02047e0:	f188                	sd	a0,32(a1)
ffffffffc02047e2:	ed9c                	sd	a5,24(a1)
ffffffffc02047e4:	8082                	ret
ffffffffc02047e6:	1141                	addi	sp,sp,-16
ffffffffc02047e8:	00009697          	auipc	a3,0x9
ffffffffc02047ec:	cb068693          	addi	a3,a3,-848 # ffffffffc020d498 <default_pmm_manager+0xb78>
ffffffffc02047f0:	00007617          	auipc	a2,0x7
ffffffffc02047f4:	61060613          	addi	a2,a2,1552 # ffffffffc020be00 <commands+0x210>
ffffffffc02047f8:	07400593          	li	a1,116
ffffffffc02047fc:	00009517          	auipc	a0,0x9
ffffffffc0204800:	c4450513          	addi	a0,a0,-956 # ffffffffc020d440 <default_pmm_manager+0xb20>
ffffffffc0204804:	e406                	sd	ra,8(sp)
ffffffffc0204806:	c99fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020480a <get_fd_array.part.0>:
ffffffffc020480a:	1141                	addi	sp,sp,-16
ffffffffc020480c:	00009697          	auipc	a3,0x9
ffffffffc0204810:	c9c68693          	addi	a3,a3,-868 # ffffffffc020d4a8 <default_pmm_manager+0xb88>
ffffffffc0204814:	00007617          	auipc	a2,0x7
ffffffffc0204818:	5ec60613          	addi	a2,a2,1516 # ffffffffc020be00 <commands+0x210>
ffffffffc020481c:	45d1                	li	a1,20
ffffffffc020481e:	00009517          	auipc	a0,0x9
ffffffffc0204822:	cba50513          	addi	a0,a0,-838 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204826:	e406                	sd	ra,8(sp)
ffffffffc0204828:	c77fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020482c <fd_array_alloc>:
ffffffffc020482c:	00092797          	auipc	a5,0x92
ffffffffc0204830:	0947b783          	ld	a5,148(a5) # ffffffffc02968c0 <current>
ffffffffc0204834:	1487b783          	ld	a5,328(a5)
ffffffffc0204838:	1141                	addi	sp,sp,-16
ffffffffc020483a:	e406                	sd	ra,8(sp)
ffffffffc020483c:	c3a5                	beqz	a5,ffffffffc020489c <fd_array_alloc+0x70>
ffffffffc020483e:	4b98                	lw	a4,16(a5)
ffffffffc0204840:	04e05e63          	blez	a4,ffffffffc020489c <fd_array_alloc+0x70>
ffffffffc0204844:	775d                	lui	a4,0xffff7
ffffffffc0204846:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020484a:	679c                	ld	a5,8(a5)
ffffffffc020484c:	02e50863          	beq	a0,a4,ffffffffc020487c <fd_array_alloc+0x50>
ffffffffc0204850:	04700713          	li	a4,71
ffffffffc0204854:	04a76263          	bltu	a4,a0,ffffffffc0204898 <fd_array_alloc+0x6c>
ffffffffc0204858:	00351713          	slli	a4,a0,0x3
ffffffffc020485c:	40a70533          	sub	a0,a4,a0
ffffffffc0204860:	050e                	slli	a0,a0,0x3
ffffffffc0204862:	97aa                	add	a5,a5,a0
ffffffffc0204864:	4398                	lw	a4,0(a5)
ffffffffc0204866:	e71d                	bnez	a4,ffffffffc0204894 <fd_array_alloc+0x68>
ffffffffc0204868:	5b88                	lw	a0,48(a5)
ffffffffc020486a:	e91d                	bnez	a0,ffffffffc02048a0 <fd_array_alloc+0x74>
ffffffffc020486c:	4705                	li	a4,1
ffffffffc020486e:	c398                	sw	a4,0(a5)
ffffffffc0204870:	0207b423          	sd	zero,40(a5)
ffffffffc0204874:	e19c                	sd	a5,0(a1)
ffffffffc0204876:	60a2                	ld	ra,8(sp)
ffffffffc0204878:	0141                	addi	sp,sp,16
ffffffffc020487a:	8082                	ret
ffffffffc020487c:	6685                	lui	a3,0x1
ffffffffc020487e:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204882:	96be                	add	a3,a3,a5
ffffffffc0204884:	4398                	lw	a4,0(a5)
ffffffffc0204886:	d36d                	beqz	a4,ffffffffc0204868 <fd_array_alloc+0x3c>
ffffffffc0204888:	03878793          	addi	a5,a5,56
ffffffffc020488c:	fef69ce3          	bne	a3,a5,ffffffffc0204884 <fd_array_alloc+0x58>
ffffffffc0204890:	5529                	li	a0,-22
ffffffffc0204892:	b7d5                	j	ffffffffc0204876 <fd_array_alloc+0x4a>
ffffffffc0204894:	5545                	li	a0,-15
ffffffffc0204896:	b7c5                	j	ffffffffc0204876 <fd_array_alloc+0x4a>
ffffffffc0204898:	5575                	li	a0,-3
ffffffffc020489a:	bff1                	j	ffffffffc0204876 <fd_array_alloc+0x4a>
ffffffffc020489c:	f6fff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>
ffffffffc02048a0:	00009697          	auipc	a3,0x9
ffffffffc02048a4:	c4868693          	addi	a3,a3,-952 # ffffffffc020d4e8 <default_pmm_manager+0xbc8>
ffffffffc02048a8:	00007617          	auipc	a2,0x7
ffffffffc02048ac:	55860613          	addi	a2,a2,1368 # ffffffffc020be00 <commands+0x210>
ffffffffc02048b0:	03b00593          	li	a1,59
ffffffffc02048b4:	00009517          	auipc	a0,0x9
ffffffffc02048b8:	c2450513          	addi	a0,a0,-988 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc02048bc:	be3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02048c0 <fd_array_free>:
ffffffffc02048c0:	411c                	lw	a5,0(a0)
ffffffffc02048c2:	1141                	addi	sp,sp,-16
ffffffffc02048c4:	e022                	sd	s0,0(sp)
ffffffffc02048c6:	e406                	sd	ra,8(sp)
ffffffffc02048c8:	4705                	li	a4,1
ffffffffc02048ca:	842a                	mv	s0,a0
ffffffffc02048cc:	04e78063          	beq	a5,a4,ffffffffc020490c <fd_array_free+0x4c>
ffffffffc02048d0:	470d                	li	a4,3
ffffffffc02048d2:	04e79563          	bne	a5,a4,ffffffffc020491c <fd_array_free+0x5c>
ffffffffc02048d6:	591c                	lw	a5,48(a0)
ffffffffc02048d8:	c38d                	beqz	a5,ffffffffc02048fa <fd_array_free+0x3a>
ffffffffc02048da:	00009697          	auipc	a3,0x9
ffffffffc02048de:	c0e68693          	addi	a3,a3,-1010 # ffffffffc020d4e8 <default_pmm_manager+0xbc8>
ffffffffc02048e2:	00007617          	auipc	a2,0x7
ffffffffc02048e6:	51e60613          	addi	a2,a2,1310 # ffffffffc020be00 <commands+0x210>
ffffffffc02048ea:	04500593          	li	a1,69
ffffffffc02048ee:	00009517          	auipc	a0,0x9
ffffffffc02048f2:	bea50513          	addi	a0,a0,-1046 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc02048f6:	ba9fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048fa:	7408                	ld	a0,40(s0)
ffffffffc02048fc:	481030ef          	jal	ra,ffffffffc020857c <vfs_close>
ffffffffc0204900:	60a2                	ld	ra,8(sp)
ffffffffc0204902:	00042023          	sw	zero,0(s0)
ffffffffc0204906:	6402                	ld	s0,0(sp)
ffffffffc0204908:	0141                	addi	sp,sp,16
ffffffffc020490a:	8082                	ret
ffffffffc020490c:	591c                	lw	a5,48(a0)
ffffffffc020490e:	f7f1                	bnez	a5,ffffffffc02048da <fd_array_free+0x1a>
ffffffffc0204910:	60a2                	ld	ra,8(sp)
ffffffffc0204912:	00042023          	sw	zero,0(s0)
ffffffffc0204916:	6402                	ld	s0,0(sp)
ffffffffc0204918:	0141                	addi	sp,sp,16
ffffffffc020491a:	8082                	ret
ffffffffc020491c:	00009697          	auipc	a3,0x9
ffffffffc0204920:	c0468693          	addi	a3,a3,-1020 # ffffffffc020d520 <default_pmm_manager+0xc00>
ffffffffc0204924:	00007617          	auipc	a2,0x7
ffffffffc0204928:	4dc60613          	addi	a2,a2,1244 # ffffffffc020be00 <commands+0x210>
ffffffffc020492c:	04400593          	li	a1,68
ffffffffc0204930:	00009517          	auipc	a0,0x9
ffffffffc0204934:	ba850513          	addi	a0,a0,-1112 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204938:	b67fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020493c <fd_array_release>:
ffffffffc020493c:	4118                	lw	a4,0(a0)
ffffffffc020493e:	1141                	addi	sp,sp,-16
ffffffffc0204940:	e406                	sd	ra,8(sp)
ffffffffc0204942:	4685                	li	a3,1
ffffffffc0204944:	3779                	addiw	a4,a4,-2
ffffffffc0204946:	04e6e063          	bltu	a3,a4,ffffffffc0204986 <fd_array_release+0x4a>
ffffffffc020494a:	5918                	lw	a4,48(a0)
ffffffffc020494c:	00e05d63          	blez	a4,ffffffffc0204966 <fd_array_release+0x2a>
ffffffffc0204950:	fff7069b          	addiw	a3,a4,-1
ffffffffc0204954:	d914                	sw	a3,48(a0)
ffffffffc0204956:	c681                	beqz	a3,ffffffffc020495e <fd_array_release+0x22>
ffffffffc0204958:	60a2                	ld	ra,8(sp)
ffffffffc020495a:	0141                	addi	sp,sp,16
ffffffffc020495c:	8082                	ret
ffffffffc020495e:	60a2                	ld	ra,8(sp)
ffffffffc0204960:	0141                	addi	sp,sp,16
ffffffffc0204962:	f5fff06f          	j	ffffffffc02048c0 <fd_array_free>
ffffffffc0204966:	00009697          	auipc	a3,0x9
ffffffffc020496a:	c2a68693          	addi	a3,a3,-982 # ffffffffc020d590 <default_pmm_manager+0xc70>
ffffffffc020496e:	00007617          	auipc	a2,0x7
ffffffffc0204972:	49260613          	addi	a2,a2,1170 # ffffffffc020be00 <commands+0x210>
ffffffffc0204976:	05600593          	li	a1,86
ffffffffc020497a:	00009517          	auipc	a0,0x9
ffffffffc020497e:	b5e50513          	addi	a0,a0,-1186 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204982:	b1dfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204986:	00009697          	auipc	a3,0x9
ffffffffc020498a:	bd268693          	addi	a3,a3,-1070 # ffffffffc020d558 <default_pmm_manager+0xc38>
ffffffffc020498e:	00007617          	auipc	a2,0x7
ffffffffc0204992:	47260613          	addi	a2,a2,1138 # ffffffffc020be00 <commands+0x210>
ffffffffc0204996:	05500593          	li	a1,85
ffffffffc020499a:	00009517          	auipc	a0,0x9
ffffffffc020499e:	b3e50513          	addi	a0,a0,-1218 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc02049a2:	afdfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02049a6 <fd_array_open.part.0>:
ffffffffc02049a6:	1141                	addi	sp,sp,-16
ffffffffc02049a8:	00009697          	auipc	a3,0x9
ffffffffc02049ac:	c0068693          	addi	a3,a3,-1024 # ffffffffc020d5a8 <default_pmm_manager+0xc88>
ffffffffc02049b0:	00007617          	auipc	a2,0x7
ffffffffc02049b4:	45060613          	addi	a2,a2,1104 # ffffffffc020be00 <commands+0x210>
ffffffffc02049b8:	05f00593          	li	a1,95
ffffffffc02049bc:	00009517          	auipc	a0,0x9
ffffffffc02049c0:	b1c50513          	addi	a0,a0,-1252 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc02049c4:	e406                	sd	ra,8(sp)
ffffffffc02049c6:	ad9fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02049ca <fd_array_init>:
ffffffffc02049ca:	4781                	li	a5,0
ffffffffc02049cc:	04800713          	li	a4,72
ffffffffc02049d0:	cd1c                	sw	a5,24(a0)
ffffffffc02049d2:	02052823          	sw	zero,48(a0)
ffffffffc02049d6:	00052023          	sw	zero,0(a0)
ffffffffc02049da:	2785                	addiw	a5,a5,1
ffffffffc02049dc:	03850513          	addi	a0,a0,56
ffffffffc02049e0:	fee798e3          	bne	a5,a4,ffffffffc02049d0 <fd_array_init+0x6>
ffffffffc02049e4:	8082                	ret

ffffffffc02049e6 <fd_array_close>:
ffffffffc02049e6:	4118                	lw	a4,0(a0)
ffffffffc02049e8:	1141                	addi	sp,sp,-16
ffffffffc02049ea:	e406                	sd	ra,8(sp)
ffffffffc02049ec:	e022                	sd	s0,0(sp)
ffffffffc02049ee:	4789                	li	a5,2
ffffffffc02049f0:	04f71a63          	bne	a4,a5,ffffffffc0204a44 <fd_array_close+0x5e>
ffffffffc02049f4:	591c                	lw	a5,48(a0)
ffffffffc02049f6:	842a                	mv	s0,a0
ffffffffc02049f8:	02f05663          	blez	a5,ffffffffc0204a24 <fd_array_close+0x3e>
ffffffffc02049fc:	37fd                	addiw	a5,a5,-1
ffffffffc02049fe:	470d                	li	a4,3
ffffffffc0204a00:	c118                	sw	a4,0(a0)
ffffffffc0204a02:	d91c                	sw	a5,48(a0)
ffffffffc0204a04:	0007871b          	sext.w	a4,a5
ffffffffc0204a08:	c709                	beqz	a4,ffffffffc0204a12 <fd_array_close+0x2c>
ffffffffc0204a0a:	60a2                	ld	ra,8(sp)
ffffffffc0204a0c:	6402                	ld	s0,0(sp)
ffffffffc0204a0e:	0141                	addi	sp,sp,16
ffffffffc0204a10:	8082                	ret
ffffffffc0204a12:	7508                	ld	a0,40(a0)
ffffffffc0204a14:	369030ef          	jal	ra,ffffffffc020857c <vfs_close>
ffffffffc0204a18:	60a2                	ld	ra,8(sp)
ffffffffc0204a1a:	00042023          	sw	zero,0(s0)
ffffffffc0204a1e:	6402                	ld	s0,0(sp)
ffffffffc0204a20:	0141                	addi	sp,sp,16
ffffffffc0204a22:	8082                	ret
ffffffffc0204a24:	00009697          	auipc	a3,0x9
ffffffffc0204a28:	b6c68693          	addi	a3,a3,-1172 # ffffffffc020d590 <default_pmm_manager+0xc70>
ffffffffc0204a2c:	00007617          	auipc	a2,0x7
ffffffffc0204a30:	3d460613          	addi	a2,a2,980 # ffffffffc020be00 <commands+0x210>
ffffffffc0204a34:	06800593          	li	a1,104
ffffffffc0204a38:	00009517          	auipc	a0,0x9
ffffffffc0204a3c:	aa050513          	addi	a0,a0,-1376 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204a40:	a5ffb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a44:	00009697          	auipc	a3,0x9
ffffffffc0204a48:	abc68693          	addi	a3,a3,-1348 # ffffffffc020d500 <default_pmm_manager+0xbe0>
ffffffffc0204a4c:	00007617          	auipc	a2,0x7
ffffffffc0204a50:	3b460613          	addi	a2,a2,948 # ffffffffc020be00 <commands+0x210>
ffffffffc0204a54:	06700593          	li	a1,103
ffffffffc0204a58:	00009517          	auipc	a0,0x9
ffffffffc0204a5c:	a8050513          	addi	a0,a0,-1408 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204a60:	a3ffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204a64 <fd_array_dup>:
ffffffffc0204a64:	7179                	addi	sp,sp,-48
ffffffffc0204a66:	e84a                	sd	s2,16(sp)
ffffffffc0204a68:	00052903          	lw	s2,0(a0)
ffffffffc0204a6c:	f406                	sd	ra,40(sp)
ffffffffc0204a6e:	f022                	sd	s0,32(sp)
ffffffffc0204a70:	ec26                	sd	s1,24(sp)
ffffffffc0204a72:	e44e                	sd	s3,8(sp)
ffffffffc0204a74:	4785                	li	a5,1
ffffffffc0204a76:	04f91663          	bne	s2,a5,ffffffffc0204ac2 <fd_array_dup+0x5e>
ffffffffc0204a7a:	0005a983          	lw	s3,0(a1)
ffffffffc0204a7e:	4789                	li	a5,2
ffffffffc0204a80:	04f99163          	bne	s3,a5,ffffffffc0204ac2 <fd_array_dup+0x5e>
ffffffffc0204a84:	7584                	ld	s1,40(a1)
ffffffffc0204a86:	699c                	ld	a5,16(a1)
ffffffffc0204a88:	7194                	ld	a3,32(a1)
ffffffffc0204a8a:	6598                	ld	a4,8(a1)
ffffffffc0204a8c:	842a                	mv	s0,a0
ffffffffc0204a8e:	e91c                	sd	a5,16(a0)
ffffffffc0204a90:	f114                	sd	a3,32(a0)
ffffffffc0204a92:	e518                	sd	a4,8(a0)
ffffffffc0204a94:	8526                	mv	a0,s1
ffffffffc0204a96:	244030ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc0204a9a:	8526                	mv	a0,s1
ffffffffc0204a9c:	24a030ef          	jal	ra,ffffffffc0207ce6 <inode_open_inc>
ffffffffc0204aa0:	401c                	lw	a5,0(s0)
ffffffffc0204aa2:	f404                	sd	s1,40(s0)
ffffffffc0204aa4:	03279f63          	bne	a5,s2,ffffffffc0204ae2 <fd_array_dup+0x7e>
ffffffffc0204aa8:	cc8d                	beqz	s1,ffffffffc0204ae2 <fd_array_dup+0x7e>
ffffffffc0204aaa:	581c                	lw	a5,48(s0)
ffffffffc0204aac:	01342023          	sw	s3,0(s0)
ffffffffc0204ab0:	70a2                	ld	ra,40(sp)
ffffffffc0204ab2:	2785                	addiw	a5,a5,1
ffffffffc0204ab4:	d81c                	sw	a5,48(s0)
ffffffffc0204ab6:	7402                	ld	s0,32(sp)
ffffffffc0204ab8:	64e2                	ld	s1,24(sp)
ffffffffc0204aba:	6942                	ld	s2,16(sp)
ffffffffc0204abc:	69a2                	ld	s3,8(sp)
ffffffffc0204abe:	6145                	addi	sp,sp,48
ffffffffc0204ac0:	8082                	ret
ffffffffc0204ac2:	00009697          	auipc	a3,0x9
ffffffffc0204ac6:	b1668693          	addi	a3,a3,-1258 # ffffffffc020d5d8 <default_pmm_manager+0xcb8>
ffffffffc0204aca:	00007617          	auipc	a2,0x7
ffffffffc0204ace:	33660613          	addi	a2,a2,822 # ffffffffc020be00 <commands+0x210>
ffffffffc0204ad2:	07300593          	li	a1,115
ffffffffc0204ad6:	00009517          	auipc	a0,0x9
ffffffffc0204ada:	a0250513          	addi	a0,a0,-1534 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204ade:	9c1fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204ae2:	ec5ff0ef          	jal	ra,ffffffffc02049a6 <fd_array_open.part.0>

ffffffffc0204ae6 <file_testfd>:
ffffffffc0204ae6:	04700793          	li	a5,71
ffffffffc0204aea:	04a7e263          	bltu	a5,a0,ffffffffc0204b2e <file_testfd+0x48>
ffffffffc0204aee:	00092797          	auipc	a5,0x92
ffffffffc0204af2:	dd27b783          	ld	a5,-558(a5) # ffffffffc02968c0 <current>
ffffffffc0204af6:	1487b783          	ld	a5,328(a5)
ffffffffc0204afa:	cf85                	beqz	a5,ffffffffc0204b32 <file_testfd+0x4c>
ffffffffc0204afc:	4b98                	lw	a4,16(a5)
ffffffffc0204afe:	02e05a63          	blez	a4,ffffffffc0204b32 <file_testfd+0x4c>
ffffffffc0204b02:	6798                	ld	a4,8(a5)
ffffffffc0204b04:	00351793          	slli	a5,a0,0x3
ffffffffc0204b08:	8f89                	sub	a5,a5,a0
ffffffffc0204b0a:	078e                	slli	a5,a5,0x3
ffffffffc0204b0c:	97ba                	add	a5,a5,a4
ffffffffc0204b0e:	4394                	lw	a3,0(a5)
ffffffffc0204b10:	4709                	li	a4,2
ffffffffc0204b12:	00e69e63          	bne	a3,a4,ffffffffc0204b2e <file_testfd+0x48>
ffffffffc0204b16:	4f98                	lw	a4,24(a5)
ffffffffc0204b18:	00a71b63          	bne	a4,a0,ffffffffc0204b2e <file_testfd+0x48>
ffffffffc0204b1c:	c199                	beqz	a1,ffffffffc0204b22 <file_testfd+0x3c>
ffffffffc0204b1e:	6788                	ld	a0,8(a5)
ffffffffc0204b20:	c901                	beqz	a0,ffffffffc0204b30 <file_testfd+0x4a>
ffffffffc0204b22:	4505                	li	a0,1
ffffffffc0204b24:	c611                	beqz	a2,ffffffffc0204b30 <file_testfd+0x4a>
ffffffffc0204b26:	6b88                	ld	a0,16(a5)
ffffffffc0204b28:	00a03533          	snez	a0,a0
ffffffffc0204b2c:	8082                	ret
ffffffffc0204b2e:	4501                	li	a0,0
ffffffffc0204b30:	8082                	ret
ffffffffc0204b32:	1141                	addi	sp,sp,-16
ffffffffc0204b34:	e406                	sd	ra,8(sp)
ffffffffc0204b36:	cd5ff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>

ffffffffc0204b3a <file_open>:
ffffffffc0204b3a:	711d                	addi	sp,sp,-96
ffffffffc0204b3c:	ec86                	sd	ra,88(sp)
ffffffffc0204b3e:	e8a2                	sd	s0,80(sp)
ffffffffc0204b40:	e4a6                	sd	s1,72(sp)
ffffffffc0204b42:	e0ca                	sd	s2,64(sp)
ffffffffc0204b44:	fc4e                	sd	s3,56(sp)
ffffffffc0204b46:	f852                	sd	s4,48(sp)
ffffffffc0204b48:	0035f793          	andi	a5,a1,3
ffffffffc0204b4c:	470d                	li	a4,3
ffffffffc0204b4e:	0ce78163          	beq	a5,a4,ffffffffc0204c10 <file_open+0xd6>
ffffffffc0204b52:	078e                	slli	a5,a5,0x3
ffffffffc0204b54:	00009717          	auipc	a4,0x9
ffffffffc0204b58:	cf470713          	addi	a4,a4,-780 # ffffffffc020d848 <CSWTCH.79>
ffffffffc0204b5c:	892a                	mv	s2,a0
ffffffffc0204b5e:	00009697          	auipc	a3,0x9
ffffffffc0204b62:	cd268693          	addi	a3,a3,-814 # ffffffffc020d830 <CSWTCH.78>
ffffffffc0204b66:	755d                	lui	a0,0xffff7
ffffffffc0204b68:	96be                	add	a3,a3,a5
ffffffffc0204b6a:	84ae                	mv	s1,a1
ffffffffc0204b6c:	97ba                	add	a5,a5,a4
ffffffffc0204b6e:	858a                	mv	a1,sp
ffffffffc0204b70:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204b74:	0006ba03          	ld	s4,0(a3)
ffffffffc0204b78:	0007b983          	ld	s3,0(a5)
ffffffffc0204b7c:	cb1ff0ef          	jal	ra,ffffffffc020482c <fd_array_alloc>
ffffffffc0204b80:	842a                	mv	s0,a0
ffffffffc0204b82:	c911                	beqz	a0,ffffffffc0204b96 <file_open+0x5c>
ffffffffc0204b84:	60e6                	ld	ra,88(sp)
ffffffffc0204b86:	8522                	mv	a0,s0
ffffffffc0204b88:	6446                	ld	s0,80(sp)
ffffffffc0204b8a:	64a6                	ld	s1,72(sp)
ffffffffc0204b8c:	6906                	ld	s2,64(sp)
ffffffffc0204b8e:	79e2                	ld	s3,56(sp)
ffffffffc0204b90:	7a42                	ld	s4,48(sp)
ffffffffc0204b92:	6125                	addi	sp,sp,96
ffffffffc0204b94:	8082                	ret
ffffffffc0204b96:	0030                	addi	a2,sp,8
ffffffffc0204b98:	85a6                	mv	a1,s1
ffffffffc0204b9a:	854a                	mv	a0,s2
ffffffffc0204b9c:	03b030ef          	jal	ra,ffffffffc02083d6 <vfs_open>
ffffffffc0204ba0:	842a                	mv	s0,a0
ffffffffc0204ba2:	e13d                	bnez	a0,ffffffffc0204c08 <file_open+0xce>
ffffffffc0204ba4:	6782                	ld	a5,0(sp)
ffffffffc0204ba6:	0204f493          	andi	s1,s1,32
ffffffffc0204baa:	6422                	ld	s0,8(sp)
ffffffffc0204bac:	0207b023          	sd	zero,32(a5)
ffffffffc0204bb0:	c885                	beqz	s1,ffffffffc0204be0 <file_open+0xa6>
ffffffffc0204bb2:	c03d                	beqz	s0,ffffffffc0204c18 <file_open+0xde>
ffffffffc0204bb4:	783c                	ld	a5,112(s0)
ffffffffc0204bb6:	c3ad                	beqz	a5,ffffffffc0204c18 <file_open+0xde>
ffffffffc0204bb8:	779c                	ld	a5,40(a5)
ffffffffc0204bba:	cfb9                	beqz	a5,ffffffffc0204c18 <file_open+0xde>
ffffffffc0204bbc:	8522                	mv	a0,s0
ffffffffc0204bbe:	00009597          	auipc	a1,0x9
ffffffffc0204bc2:	aa258593          	addi	a1,a1,-1374 # ffffffffc020d660 <default_pmm_manager+0xd40>
ffffffffc0204bc6:	12c030ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0204bca:	783c                	ld	a5,112(s0)
ffffffffc0204bcc:	6522                	ld	a0,8(sp)
ffffffffc0204bce:	080c                	addi	a1,sp,16
ffffffffc0204bd0:	779c                	ld	a5,40(a5)
ffffffffc0204bd2:	9782                	jalr	a5
ffffffffc0204bd4:	842a                	mv	s0,a0
ffffffffc0204bd6:	e515                	bnez	a0,ffffffffc0204c02 <file_open+0xc8>
ffffffffc0204bd8:	6782                	ld	a5,0(sp)
ffffffffc0204bda:	7722                	ld	a4,40(sp)
ffffffffc0204bdc:	6422                	ld	s0,8(sp)
ffffffffc0204bde:	f398                	sd	a4,32(a5)
ffffffffc0204be0:	4394                	lw	a3,0(a5)
ffffffffc0204be2:	f780                	sd	s0,40(a5)
ffffffffc0204be4:	0147b423          	sd	s4,8(a5)
ffffffffc0204be8:	0137b823          	sd	s3,16(a5)
ffffffffc0204bec:	4705                	li	a4,1
ffffffffc0204bee:	02e69363          	bne	a3,a4,ffffffffc0204c14 <file_open+0xda>
ffffffffc0204bf2:	c00d                	beqz	s0,ffffffffc0204c14 <file_open+0xda>
ffffffffc0204bf4:	5b98                	lw	a4,48(a5)
ffffffffc0204bf6:	4689                	li	a3,2
ffffffffc0204bf8:	4f80                	lw	s0,24(a5)
ffffffffc0204bfa:	2705                	addiw	a4,a4,1
ffffffffc0204bfc:	c394                	sw	a3,0(a5)
ffffffffc0204bfe:	db98                	sw	a4,48(a5)
ffffffffc0204c00:	b751                	j	ffffffffc0204b84 <file_open+0x4a>
ffffffffc0204c02:	6522                	ld	a0,8(sp)
ffffffffc0204c04:	179030ef          	jal	ra,ffffffffc020857c <vfs_close>
ffffffffc0204c08:	6502                	ld	a0,0(sp)
ffffffffc0204c0a:	cb7ff0ef          	jal	ra,ffffffffc02048c0 <fd_array_free>
ffffffffc0204c0e:	bf9d                	j	ffffffffc0204b84 <file_open+0x4a>
ffffffffc0204c10:	5475                	li	s0,-3
ffffffffc0204c12:	bf8d                	j	ffffffffc0204b84 <file_open+0x4a>
ffffffffc0204c14:	d93ff0ef          	jal	ra,ffffffffc02049a6 <fd_array_open.part.0>
ffffffffc0204c18:	00009697          	auipc	a3,0x9
ffffffffc0204c1c:	9f868693          	addi	a3,a3,-1544 # ffffffffc020d610 <default_pmm_manager+0xcf0>
ffffffffc0204c20:	00007617          	auipc	a2,0x7
ffffffffc0204c24:	1e060613          	addi	a2,a2,480 # ffffffffc020be00 <commands+0x210>
ffffffffc0204c28:	0b500593          	li	a1,181
ffffffffc0204c2c:	00009517          	auipc	a0,0x9
ffffffffc0204c30:	8ac50513          	addi	a0,a0,-1876 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204c34:	86bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204c38 <file_close>:
ffffffffc0204c38:	04700713          	li	a4,71
ffffffffc0204c3c:	04a76563          	bltu	a4,a0,ffffffffc0204c86 <file_close+0x4e>
ffffffffc0204c40:	00092717          	auipc	a4,0x92
ffffffffc0204c44:	c8073703          	ld	a4,-896(a4) # ffffffffc02968c0 <current>
ffffffffc0204c48:	14873703          	ld	a4,328(a4)
ffffffffc0204c4c:	1141                	addi	sp,sp,-16
ffffffffc0204c4e:	e406                	sd	ra,8(sp)
ffffffffc0204c50:	cf0d                	beqz	a4,ffffffffc0204c8a <file_close+0x52>
ffffffffc0204c52:	4b14                	lw	a3,16(a4)
ffffffffc0204c54:	02d05b63          	blez	a3,ffffffffc0204c8a <file_close+0x52>
ffffffffc0204c58:	6718                	ld	a4,8(a4)
ffffffffc0204c5a:	87aa                	mv	a5,a0
ffffffffc0204c5c:	050e                	slli	a0,a0,0x3
ffffffffc0204c5e:	8d1d                	sub	a0,a0,a5
ffffffffc0204c60:	050e                	slli	a0,a0,0x3
ffffffffc0204c62:	953a                	add	a0,a0,a4
ffffffffc0204c64:	4114                	lw	a3,0(a0)
ffffffffc0204c66:	4709                	li	a4,2
ffffffffc0204c68:	00e69b63          	bne	a3,a4,ffffffffc0204c7e <file_close+0x46>
ffffffffc0204c6c:	4d18                	lw	a4,24(a0)
ffffffffc0204c6e:	00f71863          	bne	a4,a5,ffffffffc0204c7e <file_close+0x46>
ffffffffc0204c72:	d75ff0ef          	jal	ra,ffffffffc02049e6 <fd_array_close>
ffffffffc0204c76:	60a2                	ld	ra,8(sp)
ffffffffc0204c78:	4501                	li	a0,0
ffffffffc0204c7a:	0141                	addi	sp,sp,16
ffffffffc0204c7c:	8082                	ret
ffffffffc0204c7e:	60a2                	ld	ra,8(sp)
ffffffffc0204c80:	5575                	li	a0,-3
ffffffffc0204c82:	0141                	addi	sp,sp,16
ffffffffc0204c84:	8082                	ret
ffffffffc0204c86:	5575                	li	a0,-3
ffffffffc0204c88:	8082                	ret
ffffffffc0204c8a:	b81ff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>

ffffffffc0204c8e <file_read>:
ffffffffc0204c8e:	715d                	addi	sp,sp,-80
ffffffffc0204c90:	e486                	sd	ra,72(sp)
ffffffffc0204c92:	e0a2                	sd	s0,64(sp)
ffffffffc0204c94:	fc26                	sd	s1,56(sp)
ffffffffc0204c96:	f84a                	sd	s2,48(sp)
ffffffffc0204c98:	f44e                	sd	s3,40(sp)
ffffffffc0204c9a:	f052                	sd	s4,32(sp)
ffffffffc0204c9c:	0006b023          	sd	zero,0(a3)
ffffffffc0204ca0:	04700793          	li	a5,71
ffffffffc0204ca4:	0aa7e463          	bltu	a5,a0,ffffffffc0204d4c <file_read+0xbe>
ffffffffc0204ca8:	00092797          	auipc	a5,0x92
ffffffffc0204cac:	c187b783          	ld	a5,-1000(a5) # ffffffffc02968c0 <current>
ffffffffc0204cb0:	1487b783          	ld	a5,328(a5)
ffffffffc0204cb4:	cfd1                	beqz	a5,ffffffffc0204d50 <file_read+0xc2>
ffffffffc0204cb6:	4b98                	lw	a4,16(a5)
ffffffffc0204cb8:	08e05c63          	blez	a4,ffffffffc0204d50 <file_read+0xc2>
ffffffffc0204cbc:	6780                	ld	s0,8(a5)
ffffffffc0204cbe:	00351793          	slli	a5,a0,0x3
ffffffffc0204cc2:	8f89                	sub	a5,a5,a0
ffffffffc0204cc4:	078e                	slli	a5,a5,0x3
ffffffffc0204cc6:	943e                	add	s0,s0,a5
ffffffffc0204cc8:	00042983          	lw	s3,0(s0)
ffffffffc0204ccc:	4789                	li	a5,2
ffffffffc0204cce:	06f99f63          	bne	s3,a5,ffffffffc0204d4c <file_read+0xbe>
ffffffffc0204cd2:	4c1c                	lw	a5,24(s0)
ffffffffc0204cd4:	06a79c63          	bne	a5,a0,ffffffffc0204d4c <file_read+0xbe>
ffffffffc0204cd8:	641c                	ld	a5,8(s0)
ffffffffc0204cda:	cbad                	beqz	a5,ffffffffc0204d4c <file_read+0xbe>
ffffffffc0204cdc:	581c                	lw	a5,48(s0)
ffffffffc0204cde:	8a36                	mv	s4,a3
ffffffffc0204ce0:	7014                	ld	a3,32(s0)
ffffffffc0204ce2:	2785                	addiw	a5,a5,1
ffffffffc0204ce4:	850a                	mv	a0,sp
ffffffffc0204ce6:	d81c                	sw	a5,48(s0)
ffffffffc0204ce8:	792000ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0204cec:	02843903          	ld	s2,40(s0)
ffffffffc0204cf0:	84aa                	mv	s1,a0
ffffffffc0204cf2:	06090163          	beqz	s2,ffffffffc0204d54 <file_read+0xc6>
ffffffffc0204cf6:	07093783          	ld	a5,112(s2)
ffffffffc0204cfa:	cfa9                	beqz	a5,ffffffffc0204d54 <file_read+0xc6>
ffffffffc0204cfc:	6f9c                	ld	a5,24(a5)
ffffffffc0204cfe:	cbb9                	beqz	a5,ffffffffc0204d54 <file_read+0xc6>
ffffffffc0204d00:	00009597          	auipc	a1,0x9
ffffffffc0204d04:	9b858593          	addi	a1,a1,-1608 # ffffffffc020d6b8 <default_pmm_manager+0xd98>
ffffffffc0204d08:	854a                	mv	a0,s2
ffffffffc0204d0a:	7e9020ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0204d0e:	07093783          	ld	a5,112(s2)
ffffffffc0204d12:	7408                	ld	a0,40(s0)
ffffffffc0204d14:	85a6                	mv	a1,s1
ffffffffc0204d16:	6f9c                	ld	a5,24(a5)
ffffffffc0204d18:	9782                	jalr	a5
ffffffffc0204d1a:	689c                	ld	a5,16(s1)
ffffffffc0204d1c:	6c94                	ld	a3,24(s1)
ffffffffc0204d1e:	4018                	lw	a4,0(s0)
ffffffffc0204d20:	84aa                	mv	s1,a0
ffffffffc0204d22:	8f95                	sub	a5,a5,a3
ffffffffc0204d24:	03370063          	beq	a4,s3,ffffffffc0204d44 <file_read+0xb6>
ffffffffc0204d28:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204d2c:	8522                	mv	a0,s0
ffffffffc0204d2e:	c0fff0ef          	jal	ra,ffffffffc020493c <fd_array_release>
ffffffffc0204d32:	60a6                	ld	ra,72(sp)
ffffffffc0204d34:	6406                	ld	s0,64(sp)
ffffffffc0204d36:	7942                	ld	s2,48(sp)
ffffffffc0204d38:	79a2                	ld	s3,40(sp)
ffffffffc0204d3a:	7a02                	ld	s4,32(sp)
ffffffffc0204d3c:	8526                	mv	a0,s1
ffffffffc0204d3e:	74e2                	ld	s1,56(sp)
ffffffffc0204d40:	6161                	addi	sp,sp,80
ffffffffc0204d42:	8082                	ret
ffffffffc0204d44:	7018                	ld	a4,32(s0)
ffffffffc0204d46:	973e                	add	a4,a4,a5
ffffffffc0204d48:	f018                	sd	a4,32(s0)
ffffffffc0204d4a:	bff9                	j	ffffffffc0204d28 <file_read+0x9a>
ffffffffc0204d4c:	54f5                	li	s1,-3
ffffffffc0204d4e:	b7d5                	j	ffffffffc0204d32 <file_read+0xa4>
ffffffffc0204d50:	abbff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>
ffffffffc0204d54:	00009697          	auipc	a3,0x9
ffffffffc0204d58:	91468693          	addi	a3,a3,-1772 # ffffffffc020d668 <default_pmm_manager+0xd48>
ffffffffc0204d5c:	00007617          	auipc	a2,0x7
ffffffffc0204d60:	0a460613          	addi	a2,a2,164 # ffffffffc020be00 <commands+0x210>
ffffffffc0204d64:	0de00593          	li	a1,222
ffffffffc0204d68:	00008517          	auipc	a0,0x8
ffffffffc0204d6c:	77050513          	addi	a0,a0,1904 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204d70:	f2efb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204d74 <file_write>:
ffffffffc0204d74:	715d                	addi	sp,sp,-80
ffffffffc0204d76:	e486                	sd	ra,72(sp)
ffffffffc0204d78:	e0a2                	sd	s0,64(sp)
ffffffffc0204d7a:	fc26                	sd	s1,56(sp)
ffffffffc0204d7c:	f84a                	sd	s2,48(sp)
ffffffffc0204d7e:	f44e                	sd	s3,40(sp)
ffffffffc0204d80:	f052                	sd	s4,32(sp)
ffffffffc0204d82:	0006b023          	sd	zero,0(a3)
ffffffffc0204d86:	04700793          	li	a5,71
ffffffffc0204d8a:	0aa7e463          	bltu	a5,a0,ffffffffc0204e32 <file_write+0xbe>
ffffffffc0204d8e:	00092797          	auipc	a5,0x92
ffffffffc0204d92:	b327b783          	ld	a5,-1230(a5) # ffffffffc02968c0 <current>
ffffffffc0204d96:	1487b783          	ld	a5,328(a5)
ffffffffc0204d9a:	cfd1                	beqz	a5,ffffffffc0204e36 <file_write+0xc2>
ffffffffc0204d9c:	4b98                	lw	a4,16(a5)
ffffffffc0204d9e:	08e05c63          	blez	a4,ffffffffc0204e36 <file_write+0xc2>
ffffffffc0204da2:	6780                	ld	s0,8(a5)
ffffffffc0204da4:	00351793          	slli	a5,a0,0x3
ffffffffc0204da8:	8f89                	sub	a5,a5,a0
ffffffffc0204daa:	078e                	slli	a5,a5,0x3
ffffffffc0204dac:	943e                	add	s0,s0,a5
ffffffffc0204dae:	00042983          	lw	s3,0(s0)
ffffffffc0204db2:	4789                	li	a5,2
ffffffffc0204db4:	06f99f63          	bne	s3,a5,ffffffffc0204e32 <file_write+0xbe>
ffffffffc0204db8:	4c1c                	lw	a5,24(s0)
ffffffffc0204dba:	06a79c63          	bne	a5,a0,ffffffffc0204e32 <file_write+0xbe>
ffffffffc0204dbe:	681c                	ld	a5,16(s0)
ffffffffc0204dc0:	cbad                	beqz	a5,ffffffffc0204e32 <file_write+0xbe>
ffffffffc0204dc2:	581c                	lw	a5,48(s0)
ffffffffc0204dc4:	8a36                	mv	s4,a3
ffffffffc0204dc6:	7014                	ld	a3,32(s0)
ffffffffc0204dc8:	2785                	addiw	a5,a5,1
ffffffffc0204dca:	850a                	mv	a0,sp
ffffffffc0204dcc:	d81c                	sw	a5,48(s0)
ffffffffc0204dce:	6ac000ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0204dd2:	02843903          	ld	s2,40(s0)
ffffffffc0204dd6:	84aa                	mv	s1,a0
ffffffffc0204dd8:	06090163          	beqz	s2,ffffffffc0204e3a <file_write+0xc6>
ffffffffc0204ddc:	07093783          	ld	a5,112(s2)
ffffffffc0204de0:	cfa9                	beqz	a5,ffffffffc0204e3a <file_write+0xc6>
ffffffffc0204de2:	739c                	ld	a5,32(a5)
ffffffffc0204de4:	cbb9                	beqz	a5,ffffffffc0204e3a <file_write+0xc6>
ffffffffc0204de6:	00009597          	auipc	a1,0x9
ffffffffc0204dea:	92a58593          	addi	a1,a1,-1750 # ffffffffc020d710 <default_pmm_manager+0xdf0>
ffffffffc0204dee:	854a                	mv	a0,s2
ffffffffc0204df0:	703020ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0204df4:	07093783          	ld	a5,112(s2)
ffffffffc0204df8:	7408                	ld	a0,40(s0)
ffffffffc0204dfa:	85a6                	mv	a1,s1
ffffffffc0204dfc:	739c                	ld	a5,32(a5)
ffffffffc0204dfe:	9782                	jalr	a5
ffffffffc0204e00:	689c                	ld	a5,16(s1)
ffffffffc0204e02:	6c94                	ld	a3,24(s1)
ffffffffc0204e04:	4018                	lw	a4,0(s0)
ffffffffc0204e06:	84aa                	mv	s1,a0
ffffffffc0204e08:	8f95                	sub	a5,a5,a3
ffffffffc0204e0a:	03370063          	beq	a4,s3,ffffffffc0204e2a <file_write+0xb6>
ffffffffc0204e0e:	00fa3023          	sd	a5,0(s4)
ffffffffc0204e12:	8522                	mv	a0,s0
ffffffffc0204e14:	b29ff0ef          	jal	ra,ffffffffc020493c <fd_array_release>
ffffffffc0204e18:	60a6                	ld	ra,72(sp)
ffffffffc0204e1a:	6406                	ld	s0,64(sp)
ffffffffc0204e1c:	7942                	ld	s2,48(sp)
ffffffffc0204e1e:	79a2                	ld	s3,40(sp)
ffffffffc0204e20:	7a02                	ld	s4,32(sp)
ffffffffc0204e22:	8526                	mv	a0,s1
ffffffffc0204e24:	74e2                	ld	s1,56(sp)
ffffffffc0204e26:	6161                	addi	sp,sp,80
ffffffffc0204e28:	8082                	ret
ffffffffc0204e2a:	7018                	ld	a4,32(s0)
ffffffffc0204e2c:	973e                	add	a4,a4,a5
ffffffffc0204e2e:	f018                	sd	a4,32(s0)
ffffffffc0204e30:	bff9                	j	ffffffffc0204e0e <file_write+0x9a>
ffffffffc0204e32:	54f5                	li	s1,-3
ffffffffc0204e34:	b7d5                	j	ffffffffc0204e18 <file_write+0xa4>
ffffffffc0204e36:	9d5ff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>
ffffffffc0204e3a:	00009697          	auipc	a3,0x9
ffffffffc0204e3e:	88668693          	addi	a3,a3,-1914 # ffffffffc020d6c0 <default_pmm_manager+0xda0>
ffffffffc0204e42:	00007617          	auipc	a2,0x7
ffffffffc0204e46:	fbe60613          	addi	a2,a2,-66 # ffffffffc020be00 <commands+0x210>
ffffffffc0204e4a:	0f800593          	li	a1,248
ffffffffc0204e4e:	00008517          	auipc	a0,0x8
ffffffffc0204e52:	68a50513          	addi	a0,a0,1674 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204e56:	e48fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204e5a <file_seek>:
ffffffffc0204e5a:	7139                	addi	sp,sp,-64
ffffffffc0204e5c:	fc06                	sd	ra,56(sp)
ffffffffc0204e5e:	f822                	sd	s0,48(sp)
ffffffffc0204e60:	f426                	sd	s1,40(sp)
ffffffffc0204e62:	f04a                	sd	s2,32(sp)
ffffffffc0204e64:	04700793          	li	a5,71
ffffffffc0204e68:	08a7e863          	bltu	a5,a0,ffffffffc0204ef8 <file_seek+0x9e>
ffffffffc0204e6c:	00092797          	auipc	a5,0x92
ffffffffc0204e70:	a547b783          	ld	a5,-1452(a5) # ffffffffc02968c0 <current>
ffffffffc0204e74:	1487b783          	ld	a5,328(a5)
ffffffffc0204e78:	cfdd                	beqz	a5,ffffffffc0204f36 <file_seek+0xdc>
ffffffffc0204e7a:	4b98                	lw	a4,16(a5)
ffffffffc0204e7c:	0ae05d63          	blez	a4,ffffffffc0204f36 <file_seek+0xdc>
ffffffffc0204e80:	6780                	ld	s0,8(a5)
ffffffffc0204e82:	00351793          	slli	a5,a0,0x3
ffffffffc0204e86:	8f89                	sub	a5,a5,a0
ffffffffc0204e88:	078e                	slli	a5,a5,0x3
ffffffffc0204e8a:	943e                	add	s0,s0,a5
ffffffffc0204e8c:	4018                	lw	a4,0(s0)
ffffffffc0204e8e:	4789                	li	a5,2
ffffffffc0204e90:	06f71463          	bne	a4,a5,ffffffffc0204ef8 <file_seek+0x9e>
ffffffffc0204e94:	4c1c                	lw	a5,24(s0)
ffffffffc0204e96:	06a79163          	bne	a5,a0,ffffffffc0204ef8 <file_seek+0x9e>
ffffffffc0204e9a:	581c                	lw	a5,48(s0)
ffffffffc0204e9c:	4685                	li	a3,1
ffffffffc0204e9e:	892e                	mv	s2,a1
ffffffffc0204ea0:	2785                	addiw	a5,a5,1
ffffffffc0204ea2:	d81c                	sw	a5,48(s0)
ffffffffc0204ea4:	02d60063          	beq	a2,a3,ffffffffc0204ec4 <file_seek+0x6a>
ffffffffc0204ea8:	06e60063          	beq	a2,a4,ffffffffc0204f08 <file_seek+0xae>
ffffffffc0204eac:	54f5                	li	s1,-3
ffffffffc0204eae:	ce11                	beqz	a2,ffffffffc0204eca <file_seek+0x70>
ffffffffc0204eb0:	8522                	mv	a0,s0
ffffffffc0204eb2:	a8bff0ef          	jal	ra,ffffffffc020493c <fd_array_release>
ffffffffc0204eb6:	70e2                	ld	ra,56(sp)
ffffffffc0204eb8:	7442                	ld	s0,48(sp)
ffffffffc0204eba:	7902                	ld	s2,32(sp)
ffffffffc0204ebc:	8526                	mv	a0,s1
ffffffffc0204ebe:	74a2                	ld	s1,40(sp)
ffffffffc0204ec0:	6121                	addi	sp,sp,64
ffffffffc0204ec2:	8082                	ret
ffffffffc0204ec4:	701c                	ld	a5,32(s0)
ffffffffc0204ec6:	00f58933          	add	s2,a1,a5
ffffffffc0204eca:	7404                	ld	s1,40(s0)
ffffffffc0204ecc:	c4bd                	beqz	s1,ffffffffc0204f3a <file_seek+0xe0>
ffffffffc0204ece:	78bc                	ld	a5,112(s1)
ffffffffc0204ed0:	c7ad                	beqz	a5,ffffffffc0204f3a <file_seek+0xe0>
ffffffffc0204ed2:	6fbc                	ld	a5,88(a5)
ffffffffc0204ed4:	c3bd                	beqz	a5,ffffffffc0204f3a <file_seek+0xe0>
ffffffffc0204ed6:	8526                	mv	a0,s1
ffffffffc0204ed8:	00009597          	auipc	a1,0x9
ffffffffc0204edc:	89058593          	addi	a1,a1,-1904 # ffffffffc020d768 <default_pmm_manager+0xe48>
ffffffffc0204ee0:	613020ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0204ee4:	78bc                	ld	a5,112(s1)
ffffffffc0204ee6:	7408                	ld	a0,40(s0)
ffffffffc0204ee8:	85ca                	mv	a1,s2
ffffffffc0204eea:	6fbc                	ld	a5,88(a5)
ffffffffc0204eec:	9782                	jalr	a5
ffffffffc0204eee:	84aa                	mv	s1,a0
ffffffffc0204ef0:	f161                	bnez	a0,ffffffffc0204eb0 <file_seek+0x56>
ffffffffc0204ef2:	03243023          	sd	s2,32(s0)
ffffffffc0204ef6:	bf6d                	j	ffffffffc0204eb0 <file_seek+0x56>
ffffffffc0204ef8:	70e2                	ld	ra,56(sp)
ffffffffc0204efa:	7442                	ld	s0,48(sp)
ffffffffc0204efc:	54f5                	li	s1,-3
ffffffffc0204efe:	7902                	ld	s2,32(sp)
ffffffffc0204f00:	8526                	mv	a0,s1
ffffffffc0204f02:	74a2                	ld	s1,40(sp)
ffffffffc0204f04:	6121                	addi	sp,sp,64
ffffffffc0204f06:	8082                	ret
ffffffffc0204f08:	7404                	ld	s1,40(s0)
ffffffffc0204f0a:	c8a1                	beqz	s1,ffffffffc0204f5a <file_seek+0x100>
ffffffffc0204f0c:	78bc                	ld	a5,112(s1)
ffffffffc0204f0e:	c7b1                	beqz	a5,ffffffffc0204f5a <file_seek+0x100>
ffffffffc0204f10:	779c                	ld	a5,40(a5)
ffffffffc0204f12:	c7a1                	beqz	a5,ffffffffc0204f5a <file_seek+0x100>
ffffffffc0204f14:	8526                	mv	a0,s1
ffffffffc0204f16:	00008597          	auipc	a1,0x8
ffffffffc0204f1a:	74a58593          	addi	a1,a1,1866 # ffffffffc020d660 <default_pmm_manager+0xd40>
ffffffffc0204f1e:	5d5020ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0204f22:	78bc                	ld	a5,112(s1)
ffffffffc0204f24:	7408                	ld	a0,40(s0)
ffffffffc0204f26:	858a                	mv	a1,sp
ffffffffc0204f28:	779c                	ld	a5,40(a5)
ffffffffc0204f2a:	9782                	jalr	a5
ffffffffc0204f2c:	84aa                	mv	s1,a0
ffffffffc0204f2e:	f149                	bnez	a0,ffffffffc0204eb0 <file_seek+0x56>
ffffffffc0204f30:	67e2                	ld	a5,24(sp)
ffffffffc0204f32:	993e                	add	s2,s2,a5
ffffffffc0204f34:	bf59                	j	ffffffffc0204eca <file_seek+0x70>
ffffffffc0204f36:	8d5ff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>
ffffffffc0204f3a:	00008697          	auipc	a3,0x8
ffffffffc0204f3e:	7de68693          	addi	a3,a3,2014 # ffffffffc020d718 <default_pmm_manager+0xdf8>
ffffffffc0204f42:	00007617          	auipc	a2,0x7
ffffffffc0204f46:	ebe60613          	addi	a2,a2,-322 # ffffffffc020be00 <commands+0x210>
ffffffffc0204f4a:	11a00593          	li	a1,282
ffffffffc0204f4e:	00008517          	auipc	a0,0x8
ffffffffc0204f52:	58a50513          	addi	a0,a0,1418 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204f56:	d48fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204f5a:	00008697          	auipc	a3,0x8
ffffffffc0204f5e:	6b668693          	addi	a3,a3,1718 # ffffffffc020d610 <default_pmm_manager+0xcf0>
ffffffffc0204f62:	00007617          	auipc	a2,0x7
ffffffffc0204f66:	e9e60613          	addi	a2,a2,-354 # ffffffffc020be00 <commands+0x210>
ffffffffc0204f6a:	11200593          	li	a1,274
ffffffffc0204f6e:	00008517          	auipc	a0,0x8
ffffffffc0204f72:	56a50513          	addi	a0,a0,1386 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0204f76:	d28fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204f7a <file_fstat>:
ffffffffc0204f7a:	1101                	addi	sp,sp,-32
ffffffffc0204f7c:	ec06                	sd	ra,24(sp)
ffffffffc0204f7e:	e822                	sd	s0,16(sp)
ffffffffc0204f80:	e426                	sd	s1,8(sp)
ffffffffc0204f82:	e04a                	sd	s2,0(sp)
ffffffffc0204f84:	04700793          	li	a5,71
ffffffffc0204f88:	06a7ef63          	bltu	a5,a0,ffffffffc0205006 <file_fstat+0x8c>
ffffffffc0204f8c:	00092797          	auipc	a5,0x92
ffffffffc0204f90:	9347b783          	ld	a5,-1740(a5) # ffffffffc02968c0 <current>
ffffffffc0204f94:	1487b783          	ld	a5,328(a5)
ffffffffc0204f98:	cfd9                	beqz	a5,ffffffffc0205036 <file_fstat+0xbc>
ffffffffc0204f9a:	4b98                	lw	a4,16(a5)
ffffffffc0204f9c:	08e05d63          	blez	a4,ffffffffc0205036 <file_fstat+0xbc>
ffffffffc0204fa0:	6780                	ld	s0,8(a5)
ffffffffc0204fa2:	00351793          	slli	a5,a0,0x3
ffffffffc0204fa6:	8f89                	sub	a5,a5,a0
ffffffffc0204fa8:	078e                	slli	a5,a5,0x3
ffffffffc0204faa:	943e                	add	s0,s0,a5
ffffffffc0204fac:	4018                	lw	a4,0(s0)
ffffffffc0204fae:	4789                	li	a5,2
ffffffffc0204fb0:	04f71b63          	bne	a4,a5,ffffffffc0205006 <file_fstat+0x8c>
ffffffffc0204fb4:	4c1c                	lw	a5,24(s0)
ffffffffc0204fb6:	04a79863          	bne	a5,a0,ffffffffc0205006 <file_fstat+0x8c>
ffffffffc0204fba:	581c                	lw	a5,48(s0)
ffffffffc0204fbc:	02843903          	ld	s2,40(s0)
ffffffffc0204fc0:	2785                	addiw	a5,a5,1
ffffffffc0204fc2:	d81c                	sw	a5,48(s0)
ffffffffc0204fc4:	04090963          	beqz	s2,ffffffffc0205016 <file_fstat+0x9c>
ffffffffc0204fc8:	07093783          	ld	a5,112(s2)
ffffffffc0204fcc:	c7a9                	beqz	a5,ffffffffc0205016 <file_fstat+0x9c>
ffffffffc0204fce:	779c                	ld	a5,40(a5)
ffffffffc0204fd0:	c3b9                	beqz	a5,ffffffffc0205016 <file_fstat+0x9c>
ffffffffc0204fd2:	84ae                	mv	s1,a1
ffffffffc0204fd4:	854a                	mv	a0,s2
ffffffffc0204fd6:	00008597          	auipc	a1,0x8
ffffffffc0204fda:	68a58593          	addi	a1,a1,1674 # ffffffffc020d660 <default_pmm_manager+0xd40>
ffffffffc0204fde:	515020ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0204fe2:	07093783          	ld	a5,112(s2)
ffffffffc0204fe6:	7408                	ld	a0,40(s0)
ffffffffc0204fe8:	85a6                	mv	a1,s1
ffffffffc0204fea:	779c                	ld	a5,40(a5)
ffffffffc0204fec:	9782                	jalr	a5
ffffffffc0204fee:	87aa                	mv	a5,a0
ffffffffc0204ff0:	8522                	mv	a0,s0
ffffffffc0204ff2:	843e                	mv	s0,a5
ffffffffc0204ff4:	949ff0ef          	jal	ra,ffffffffc020493c <fd_array_release>
ffffffffc0204ff8:	60e2                	ld	ra,24(sp)
ffffffffc0204ffa:	8522                	mv	a0,s0
ffffffffc0204ffc:	6442                	ld	s0,16(sp)
ffffffffc0204ffe:	64a2                	ld	s1,8(sp)
ffffffffc0205000:	6902                	ld	s2,0(sp)
ffffffffc0205002:	6105                	addi	sp,sp,32
ffffffffc0205004:	8082                	ret
ffffffffc0205006:	5475                	li	s0,-3
ffffffffc0205008:	60e2                	ld	ra,24(sp)
ffffffffc020500a:	8522                	mv	a0,s0
ffffffffc020500c:	6442                	ld	s0,16(sp)
ffffffffc020500e:	64a2                	ld	s1,8(sp)
ffffffffc0205010:	6902                	ld	s2,0(sp)
ffffffffc0205012:	6105                	addi	sp,sp,32
ffffffffc0205014:	8082                	ret
ffffffffc0205016:	00008697          	auipc	a3,0x8
ffffffffc020501a:	5fa68693          	addi	a3,a3,1530 # ffffffffc020d610 <default_pmm_manager+0xcf0>
ffffffffc020501e:	00007617          	auipc	a2,0x7
ffffffffc0205022:	de260613          	addi	a2,a2,-542 # ffffffffc020be00 <commands+0x210>
ffffffffc0205026:	12c00593          	li	a1,300
ffffffffc020502a:	00008517          	auipc	a0,0x8
ffffffffc020502e:	4ae50513          	addi	a0,a0,1198 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc0205032:	c6cfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205036:	fd4ff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>

ffffffffc020503a <file_fsync>:
ffffffffc020503a:	1101                	addi	sp,sp,-32
ffffffffc020503c:	ec06                	sd	ra,24(sp)
ffffffffc020503e:	e822                	sd	s0,16(sp)
ffffffffc0205040:	e426                	sd	s1,8(sp)
ffffffffc0205042:	04700793          	li	a5,71
ffffffffc0205046:	06a7e863          	bltu	a5,a0,ffffffffc02050b6 <file_fsync+0x7c>
ffffffffc020504a:	00092797          	auipc	a5,0x92
ffffffffc020504e:	8767b783          	ld	a5,-1930(a5) # ffffffffc02968c0 <current>
ffffffffc0205052:	1487b783          	ld	a5,328(a5)
ffffffffc0205056:	c7d9                	beqz	a5,ffffffffc02050e4 <file_fsync+0xaa>
ffffffffc0205058:	4b98                	lw	a4,16(a5)
ffffffffc020505a:	08e05563          	blez	a4,ffffffffc02050e4 <file_fsync+0xaa>
ffffffffc020505e:	6780                	ld	s0,8(a5)
ffffffffc0205060:	00351793          	slli	a5,a0,0x3
ffffffffc0205064:	8f89                	sub	a5,a5,a0
ffffffffc0205066:	078e                	slli	a5,a5,0x3
ffffffffc0205068:	943e                	add	s0,s0,a5
ffffffffc020506a:	4018                	lw	a4,0(s0)
ffffffffc020506c:	4789                	li	a5,2
ffffffffc020506e:	04f71463          	bne	a4,a5,ffffffffc02050b6 <file_fsync+0x7c>
ffffffffc0205072:	4c1c                	lw	a5,24(s0)
ffffffffc0205074:	04a79163          	bne	a5,a0,ffffffffc02050b6 <file_fsync+0x7c>
ffffffffc0205078:	581c                	lw	a5,48(s0)
ffffffffc020507a:	7404                	ld	s1,40(s0)
ffffffffc020507c:	2785                	addiw	a5,a5,1
ffffffffc020507e:	d81c                	sw	a5,48(s0)
ffffffffc0205080:	c0b1                	beqz	s1,ffffffffc02050c4 <file_fsync+0x8a>
ffffffffc0205082:	78bc                	ld	a5,112(s1)
ffffffffc0205084:	c3a1                	beqz	a5,ffffffffc02050c4 <file_fsync+0x8a>
ffffffffc0205086:	7b9c                	ld	a5,48(a5)
ffffffffc0205088:	cf95                	beqz	a5,ffffffffc02050c4 <file_fsync+0x8a>
ffffffffc020508a:	00008597          	auipc	a1,0x8
ffffffffc020508e:	73658593          	addi	a1,a1,1846 # ffffffffc020d7c0 <default_pmm_manager+0xea0>
ffffffffc0205092:	8526                	mv	a0,s1
ffffffffc0205094:	45f020ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0205098:	78bc                	ld	a5,112(s1)
ffffffffc020509a:	7408                	ld	a0,40(s0)
ffffffffc020509c:	7b9c                	ld	a5,48(a5)
ffffffffc020509e:	9782                	jalr	a5
ffffffffc02050a0:	87aa                	mv	a5,a0
ffffffffc02050a2:	8522                	mv	a0,s0
ffffffffc02050a4:	843e                	mv	s0,a5
ffffffffc02050a6:	897ff0ef          	jal	ra,ffffffffc020493c <fd_array_release>
ffffffffc02050aa:	60e2                	ld	ra,24(sp)
ffffffffc02050ac:	8522                	mv	a0,s0
ffffffffc02050ae:	6442                	ld	s0,16(sp)
ffffffffc02050b0:	64a2                	ld	s1,8(sp)
ffffffffc02050b2:	6105                	addi	sp,sp,32
ffffffffc02050b4:	8082                	ret
ffffffffc02050b6:	5475                	li	s0,-3
ffffffffc02050b8:	60e2                	ld	ra,24(sp)
ffffffffc02050ba:	8522                	mv	a0,s0
ffffffffc02050bc:	6442                	ld	s0,16(sp)
ffffffffc02050be:	64a2                	ld	s1,8(sp)
ffffffffc02050c0:	6105                	addi	sp,sp,32
ffffffffc02050c2:	8082                	ret
ffffffffc02050c4:	00008697          	auipc	a3,0x8
ffffffffc02050c8:	6ac68693          	addi	a3,a3,1708 # ffffffffc020d770 <default_pmm_manager+0xe50>
ffffffffc02050cc:	00007617          	auipc	a2,0x7
ffffffffc02050d0:	d3460613          	addi	a2,a2,-716 # ffffffffc020be00 <commands+0x210>
ffffffffc02050d4:	13a00593          	li	a1,314
ffffffffc02050d8:	00008517          	auipc	a0,0x8
ffffffffc02050dc:	40050513          	addi	a0,a0,1024 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc02050e0:	bbefb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02050e4:	f26ff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>

ffffffffc02050e8 <file_getdirentry>:
ffffffffc02050e8:	715d                	addi	sp,sp,-80
ffffffffc02050ea:	e486                	sd	ra,72(sp)
ffffffffc02050ec:	e0a2                	sd	s0,64(sp)
ffffffffc02050ee:	fc26                	sd	s1,56(sp)
ffffffffc02050f0:	f84a                	sd	s2,48(sp)
ffffffffc02050f2:	f44e                	sd	s3,40(sp)
ffffffffc02050f4:	04700793          	li	a5,71
ffffffffc02050f8:	0aa7e063          	bltu	a5,a0,ffffffffc0205198 <file_getdirentry+0xb0>
ffffffffc02050fc:	00091797          	auipc	a5,0x91
ffffffffc0205100:	7c47b783          	ld	a5,1988(a5) # ffffffffc02968c0 <current>
ffffffffc0205104:	1487b783          	ld	a5,328(a5)
ffffffffc0205108:	c3e9                	beqz	a5,ffffffffc02051ca <file_getdirentry+0xe2>
ffffffffc020510a:	4b98                	lw	a4,16(a5)
ffffffffc020510c:	0ae05f63          	blez	a4,ffffffffc02051ca <file_getdirentry+0xe2>
ffffffffc0205110:	6780                	ld	s0,8(a5)
ffffffffc0205112:	00351793          	slli	a5,a0,0x3
ffffffffc0205116:	8f89                	sub	a5,a5,a0
ffffffffc0205118:	078e                	slli	a5,a5,0x3
ffffffffc020511a:	943e                	add	s0,s0,a5
ffffffffc020511c:	4018                	lw	a4,0(s0)
ffffffffc020511e:	4789                	li	a5,2
ffffffffc0205120:	06f71c63          	bne	a4,a5,ffffffffc0205198 <file_getdirentry+0xb0>
ffffffffc0205124:	4c1c                	lw	a5,24(s0)
ffffffffc0205126:	06a79963          	bne	a5,a0,ffffffffc0205198 <file_getdirentry+0xb0>
ffffffffc020512a:	581c                	lw	a5,48(s0)
ffffffffc020512c:	6194                	ld	a3,0(a1)
ffffffffc020512e:	84ae                	mv	s1,a1
ffffffffc0205130:	2785                	addiw	a5,a5,1
ffffffffc0205132:	10000613          	li	a2,256
ffffffffc0205136:	d81c                	sw	a5,48(s0)
ffffffffc0205138:	05a1                	addi	a1,a1,8
ffffffffc020513a:	850a                	mv	a0,sp
ffffffffc020513c:	33e000ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0205140:	02843983          	ld	s3,40(s0)
ffffffffc0205144:	892a                	mv	s2,a0
ffffffffc0205146:	06098263          	beqz	s3,ffffffffc02051aa <file_getdirentry+0xc2>
ffffffffc020514a:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc020514e:	cfb1                	beqz	a5,ffffffffc02051aa <file_getdirentry+0xc2>
ffffffffc0205150:	63bc                	ld	a5,64(a5)
ffffffffc0205152:	cfa1                	beqz	a5,ffffffffc02051aa <file_getdirentry+0xc2>
ffffffffc0205154:	854e                	mv	a0,s3
ffffffffc0205156:	00008597          	auipc	a1,0x8
ffffffffc020515a:	6ca58593          	addi	a1,a1,1738 # ffffffffc020d820 <default_pmm_manager+0xf00>
ffffffffc020515e:	395020ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0205162:	0709b783          	ld	a5,112(s3)
ffffffffc0205166:	7408                	ld	a0,40(s0)
ffffffffc0205168:	85ca                	mv	a1,s2
ffffffffc020516a:	63bc                	ld	a5,64(a5)
ffffffffc020516c:	9782                	jalr	a5
ffffffffc020516e:	89aa                	mv	s3,a0
ffffffffc0205170:	e909                	bnez	a0,ffffffffc0205182 <file_getdirentry+0x9a>
ffffffffc0205172:	609c                	ld	a5,0(s1)
ffffffffc0205174:	01093683          	ld	a3,16(s2)
ffffffffc0205178:	01893703          	ld	a4,24(s2)
ffffffffc020517c:	97b6                	add	a5,a5,a3
ffffffffc020517e:	8f99                	sub	a5,a5,a4
ffffffffc0205180:	e09c                	sd	a5,0(s1)
ffffffffc0205182:	8522                	mv	a0,s0
ffffffffc0205184:	fb8ff0ef          	jal	ra,ffffffffc020493c <fd_array_release>
ffffffffc0205188:	60a6                	ld	ra,72(sp)
ffffffffc020518a:	6406                	ld	s0,64(sp)
ffffffffc020518c:	74e2                	ld	s1,56(sp)
ffffffffc020518e:	7942                	ld	s2,48(sp)
ffffffffc0205190:	854e                	mv	a0,s3
ffffffffc0205192:	79a2                	ld	s3,40(sp)
ffffffffc0205194:	6161                	addi	sp,sp,80
ffffffffc0205196:	8082                	ret
ffffffffc0205198:	60a6                	ld	ra,72(sp)
ffffffffc020519a:	6406                	ld	s0,64(sp)
ffffffffc020519c:	59f5                	li	s3,-3
ffffffffc020519e:	74e2                	ld	s1,56(sp)
ffffffffc02051a0:	7942                	ld	s2,48(sp)
ffffffffc02051a2:	854e                	mv	a0,s3
ffffffffc02051a4:	79a2                	ld	s3,40(sp)
ffffffffc02051a6:	6161                	addi	sp,sp,80
ffffffffc02051a8:	8082                	ret
ffffffffc02051aa:	00008697          	auipc	a3,0x8
ffffffffc02051ae:	61e68693          	addi	a3,a3,1566 # ffffffffc020d7c8 <default_pmm_manager+0xea8>
ffffffffc02051b2:	00007617          	auipc	a2,0x7
ffffffffc02051b6:	c4e60613          	addi	a2,a2,-946 # ffffffffc020be00 <commands+0x210>
ffffffffc02051ba:	14a00593          	li	a1,330
ffffffffc02051be:	00008517          	auipc	a0,0x8
ffffffffc02051c2:	31a50513          	addi	a0,a0,794 # ffffffffc020d4d8 <default_pmm_manager+0xbb8>
ffffffffc02051c6:	ad8fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02051ca:	e40ff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>

ffffffffc02051ce <file_dup>:
ffffffffc02051ce:	04700713          	li	a4,71
ffffffffc02051d2:	06a76463          	bltu	a4,a0,ffffffffc020523a <file_dup+0x6c>
ffffffffc02051d6:	00091717          	auipc	a4,0x91
ffffffffc02051da:	6ea73703          	ld	a4,1770(a4) # ffffffffc02968c0 <current>
ffffffffc02051de:	14873703          	ld	a4,328(a4)
ffffffffc02051e2:	1101                	addi	sp,sp,-32
ffffffffc02051e4:	ec06                	sd	ra,24(sp)
ffffffffc02051e6:	e822                	sd	s0,16(sp)
ffffffffc02051e8:	cb39                	beqz	a4,ffffffffc020523e <file_dup+0x70>
ffffffffc02051ea:	4b14                	lw	a3,16(a4)
ffffffffc02051ec:	04d05963          	blez	a3,ffffffffc020523e <file_dup+0x70>
ffffffffc02051f0:	6700                	ld	s0,8(a4)
ffffffffc02051f2:	00351713          	slli	a4,a0,0x3
ffffffffc02051f6:	8f09                	sub	a4,a4,a0
ffffffffc02051f8:	070e                	slli	a4,a4,0x3
ffffffffc02051fa:	943a                	add	s0,s0,a4
ffffffffc02051fc:	4014                	lw	a3,0(s0)
ffffffffc02051fe:	4709                	li	a4,2
ffffffffc0205200:	02e69863          	bne	a3,a4,ffffffffc0205230 <file_dup+0x62>
ffffffffc0205204:	4c18                	lw	a4,24(s0)
ffffffffc0205206:	02a71563          	bne	a4,a0,ffffffffc0205230 <file_dup+0x62>
ffffffffc020520a:	852e                	mv	a0,a1
ffffffffc020520c:	002c                	addi	a1,sp,8
ffffffffc020520e:	e1eff0ef          	jal	ra,ffffffffc020482c <fd_array_alloc>
ffffffffc0205212:	c509                	beqz	a0,ffffffffc020521c <file_dup+0x4e>
ffffffffc0205214:	60e2                	ld	ra,24(sp)
ffffffffc0205216:	6442                	ld	s0,16(sp)
ffffffffc0205218:	6105                	addi	sp,sp,32
ffffffffc020521a:	8082                	ret
ffffffffc020521c:	6522                	ld	a0,8(sp)
ffffffffc020521e:	85a2                	mv	a1,s0
ffffffffc0205220:	845ff0ef          	jal	ra,ffffffffc0204a64 <fd_array_dup>
ffffffffc0205224:	67a2                	ld	a5,8(sp)
ffffffffc0205226:	60e2                	ld	ra,24(sp)
ffffffffc0205228:	6442                	ld	s0,16(sp)
ffffffffc020522a:	4f88                	lw	a0,24(a5)
ffffffffc020522c:	6105                	addi	sp,sp,32
ffffffffc020522e:	8082                	ret
ffffffffc0205230:	60e2                	ld	ra,24(sp)
ffffffffc0205232:	6442                	ld	s0,16(sp)
ffffffffc0205234:	5575                	li	a0,-3
ffffffffc0205236:	6105                	addi	sp,sp,32
ffffffffc0205238:	8082                	ret
ffffffffc020523a:	5575                	li	a0,-3
ffffffffc020523c:	8082                	ret
ffffffffc020523e:	dccff0ef          	jal	ra,ffffffffc020480a <get_fd_array.part.0>

ffffffffc0205242 <fs_init>:
ffffffffc0205242:	1141                	addi	sp,sp,-16
ffffffffc0205244:	e406                	sd	ra,8(sp)
ffffffffc0205246:	4cb020ef          	jal	ra,ffffffffc0207f10 <vfs_init>
ffffffffc020524a:	1a3030ef          	jal	ra,ffffffffc0208bec <dev_init>
ffffffffc020524e:	60a2                	ld	ra,8(sp)
ffffffffc0205250:	0141                	addi	sp,sp,16
ffffffffc0205252:	2f20406f          	j	ffffffffc0209544 <sfs_init>

ffffffffc0205256 <fs_cleanup>:
ffffffffc0205256:	70d0206f          	j	ffffffffc0208162 <vfs_cleanup>

ffffffffc020525a <lock_files>:
ffffffffc020525a:	0561                	addi	a0,a0,24
ffffffffc020525c:	ba0ff06f          	j	ffffffffc02045fc <down>

ffffffffc0205260 <unlock_files>:
ffffffffc0205260:	0561                	addi	a0,a0,24
ffffffffc0205262:	b96ff06f          	j	ffffffffc02045f8 <up>

ffffffffc0205266 <files_create>:
ffffffffc0205266:	1141                	addi	sp,sp,-16
ffffffffc0205268:	6505                	lui	a0,0x1
ffffffffc020526a:	e022                	sd	s0,0(sp)
ffffffffc020526c:	e406                	sd	ra,8(sp)
ffffffffc020526e:	db5fc0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0205272:	842a                	mv	s0,a0
ffffffffc0205274:	cd19                	beqz	a0,ffffffffc0205292 <files_create+0x2c>
ffffffffc0205276:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc020527a:	00043023          	sd	zero,0(s0)
ffffffffc020527e:	0561                	addi	a0,a0,24
ffffffffc0205280:	e41c                	sd	a5,8(s0)
ffffffffc0205282:	00042823          	sw	zero,16(s0)
ffffffffc0205286:	4585                	li	a1,1
ffffffffc0205288:	b6aff0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc020528c:	6408                	ld	a0,8(s0)
ffffffffc020528e:	f3cff0ef          	jal	ra,ffffffffc02049ca <fd_array_init>
ffffffffc0205292:	60a2                	ld	ra,8(sp)
ffffffffc0205294:	8522                	mv	a0,s0
ffffffffc0205296:	6402                	ld	s0,0(sp)
ffffffffc0205298:	0141                	addi	sp,sp,16
ffffffffc020529a:	8082                	ret

ffffffffc020529c <files_destroy>:
ffffffffc020529c:	7179                	addi	sp,sp,-48
ffffffffc020529e:	f406                	sd	ra,40(sp)
ffffffffc02052a0:	f022                	sd	s0,32(sp)
ffffffffc02052a2:	ec26                	sd	s1,24(sp)
ffffffffc02052a4:	e84a                	sd	s2,16(sp)
ffffffffc02052a6:	e44e                	sd	s3,8(sp)
ffffffffc02052a8:	c52d                	beqz	a0,ffffffffc0205312 <files_destroy+0x76>
ffffffffc02052aa:	491c                	lw	a5,16(a0)
ffffffffc02052ac:	89aa                	mv	s3,a0
ffffffffc02052ae:	e3b5                	bnez	a5,ffffffffc0205312 <files_destroy+0x76>
ffffffffc02052b0:	6108                	ld	a0,0(a0)
ffffffffc02052b2:	c119                	beqz	a0,ffffffffc02052b8 <files_destroy+0x1c>
ffffffffc02052b4:	2f5020ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc02052b8:	0089b403          	ld	s0,8(s3)
ffffffffc02052bc:	6485                	lui	s1,0x1
ffffffffc02052be:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02052c2:	94a2                	add	s1,s1,s0
ffffffffc02052c4:	4909                	li	s2,2
ffffffffc02052c6:	401c                	lw	a5,0(s0)
ffffffffc02052c8:	03278063          	beq	a5,s2,ffffffffc02052e8 <files_destroy+0x4c>
ffffffffc02052cc:	e39d                	bnez	a5,ffffffffc02052f2 <files_destroy+0x56>
ffffffffc02052ce:	03840413          	addi	s0,s0,56
ffffffffc02052d2:	fe849ae3          	bne	s1,s0,ffffffffc02052c6 <files_destroy+0x2a>
ffffffffc02052d6:	7402                	ld	s0,32(sp)
ffffffffc02052d8:	70a2                	ld	ra,40(sp)
ffffffffc02052da:	64e2                	ld	s1,24(sp)
ffffffffc02052dc:	6942                	ld	s2,16(sp)
ffffffffc02052de:	854e                	mv	a0,s3
ffffffffc02052e0:	69a2                	ld	s3,8(sp)
ffffffffc02052e2:	6145                	addi	sp,sp,48
ffffffffc02052e4:	deffc06f          	j	ffffffffc02020d2 <kfree>
ffffffffc02052e8:	8522                	mv	a0,s0
ffffffffc02052ea:	efcff0ef          	jal	ra,ffffffffc02049e6 <fd_array_close>
ffffffffc02052ee:	401c                	lw	a5,0(s0)
ffffffffc02052f0:	bff1                	j	ffffffffc02052cc <files_destroy+0x30>
ffffffffc02052f2:	00008697          	auipc	a3,0x8
ffffffffc02052f6:	5ae68693          	addi	a3,a3,1454 # ffffffffc020d8a0 <CSWTCH.79+0x58>
ffffffffc02052fa:	00007617          	auipc	a2,0x7
ffffffffc02052fe:	b0660613          	addi	a2,a2,-1274 # ffffffffc020be00 <commands+0x210>
ffffffffc0205302:	03d00593          	li	a1,61
ffffffffc0205306:	00008517          	auipc	a0,0x8
ffffffffc020530a:	58a50513          	addi	a0,a0,1418 # ffffffffc020d890 <CSWTCH.79+0x48>
ffffffffc020530e:	990fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205312:	00008697          	auipc	a3,0x8
ffffffffc0205316:	54e68693          	addi	a3,a3,1358 # ffffffffc020d860 <CSWTCH.79+0x18>
ffffffffc020531a:	00007617          	auipc	a2,0x7
ffffffffc020531e:	ae660613          	addi	a2,a2,-1306 # ffffffffc020be00 <commands+0x210>
ffffffffc0205322:	03300593          	li	a1,51
ffffffffc0205326:	00008517          	auipc	a0,0x8
ffffffffc020532a:	56a50513          	addi	a0,a0,1386 # ffffffffc020d890 <CSWTCH.79+0x48>
ffffffffc020532e:	970fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205332 <files_closeall>:
ffffffffc0205332:	1101                	addi	sp,sp,-32
ffffffffc0205334:	ec06                	sd	ra,24(sp)
ffffffffc0205336:	e822                	sd	s0,16(sp)
ffffffffc0205338:	e426                	sd	s1,8(sp)
ffffffffc020533a:	e04a                	sd	s2,0(sp)
ffffffffc020533c:	c129                	beqz	a0,ffffffffc020537e <files_closeall+0x4c>
ffffffffc020533e:	491c                	lw	a5,16(a0)
ffffffffc0205340:	02f05f63          	blez	a5,ffffffffc020537e <files_closeall+0x4c>
ffffffffc0205344:	6504                	ld	s1,8(a0)
ffffffffc0205346:	6785                	lui	a5,0x1
ffffffffc0205348:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc020534c:	07048413          	addi	s0,s1,112
ffffffffc0205350:	4909                	li	s2,2
ffffffffc0205352:	94be                	add	s1,s1,a5
ffffffffc0205354:	a029                	j	ffffffffc020535e <files_closeall+0x2c>
ffffffffc0205356:	03840413          	addi	s0,s0,56
ffffffffc020535a:	00848c63          	beq	s1,s0,ffffffffc0205372 <files_closeall+0x40>
ffffffffc020535e:	401c                	lw	a5,0(s0)
ffffffffc0205360:	ff279be3          	bne	a5,s2,ffffffffc0205356 <files_closeall+0x24>
ffffffffc0205364:	8522                	mv	a0,s0
ffffffffc0205366:	03840413          	addi	s0,s0,56
ffffffffc020536a:	e7cff0ef          	jal	ra,ffffffffc02049e6 <fd_array_close>
ffffffffc020536e:	fe8498e3          	bne	s1,s0,ffffffffc020535e <files_closeall+0x2c>
ffffffffc0205372:	60e2                	ld	ra,24(sp)
ffffffffc0205374:	6442                	ld	s0,16(sp)
ffffffffc0205376:	64a2                	ld	s1,8(sp)
ffffffffc0205378:	6902                	ld	s2,0(sp)
ffffffffc020537a:	6105                	addi	sp,sp,32
ffffffffc020537c:	8082                	ret
ffffffffc020537e:	00008697          	auipc	a3,0x8
ffffffffc0205382:	12a68693          	addi	a3,a3,298 # ffffffffc020d4a8 <default_pmm_manager+0xb88>
ffffffffc0205386:	00007617          	auipc	a2,0x7
ffffffffc020538a:	a7a60613          	addi	a2,a2,-1414 # ffffffffc020be00 <commands+0x210>
ffffffffc020538e:	04500593          	li	a1,69
ffffffffc0205392:	00008517          	auipc	a0,0x8
ffffffffc0205396:	4fe50513          	addi	a0,a0,1278 # ffffffffc020d890 <CSWTCH.79+0x48>
ffffffffc020539a:	904fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020539e <dup_files>:
ffffffffc020539e:	7179                	addi	sp,sp,-48
ffffffffc02053a0:	f406                	sd	ra,40(sp)
ffffffffc02053a2:	f022                	sd	s0,32(sp)
ffffffffc02053a4:	ec26                	sd	s1,24(sp)
ffffffffc02053a6:	e84a                	sd	s2,16(sp)
ffffffffc02053a8:	e44e                	sd	s3,8(sp)
ffffffffc02053aa:	e052                	sd	s4,0(sp)
ffffffffc02053ac:	c52d                	beqz	a0,ffffffffc0205416 <dup_files+0x78>
ffffffffc02053ae:	842e                	mv	s0,a1
ffffffffc02053b0:	c1bd                	beqz	a1,ffffffffc0205416 <dup_files+0x78>
ffffffffc02053b2:	491c                	lw	a5,16(a0)
ffffffffc02053b4:	84aa                	mv	s1,a0
ffffffffc02053b6:	e3c1                	bnez	a5,ffffffffc0205436 <dup_files+0x98>
ffffffffc02053b8:	499c                	lw	a5,16(a1)
ffffffffc02053ba:	06f05e63          	blez	a5,ffffffffc0205436 <dup_files+0x98>
ffffffffc02053be:	6188                	ld	a0,0(a1)
ffffffffc02053c0:	e088                	sd	a0,0(s1)
ffffffffc02053c2:	c119                	beqz	a0,ffffffffc02053c8 <dup_files+0x2a>
ffffffffc02053c4:	117020ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc02053c8:	6400                	ld	s0,8(s0)
ffffffffc02053ca:	6905                	lui	s2,0x1
ffffffffc02053cc:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02053d0:	6484                	ld	s1,8(s1)
ffffffffc02053d2:	9922                	add	s2,s2,s0
ffffffffc02053d4:	4989                	li	s3,2
ffffffffc02053d6:	4a05                	li	s4,1
ffffffffc02053d8:	a039                	j	ffffffffc02053e6 <dup_files+0x48>
ffffffffc02053da:	03840413          	addi	s0,s0,56
ffffffffc02053de:	03848493          	addi	s1,s1,56
ffffffffc02053e2:	02890163          	beq	s2,s0,ffffffffc0205404 <dup_files+0x66>
ffffffffc02053e6:	401c                	lw	a5,0(s0)
ffffffffc02053e8:	ff3799e3          	bne	a5,s3,ffffffffc02053da <dup_files+0x3c>
ffffffffc02053ec:	0144a023          	sw	s4,0(s1)
ffffffffc02053f0:	85a2                	mv	a1,s0
ffffffffc02053f2:	8526                	mv	a0,s1
ffffffffc02053f4:	03840413          	addi	s0,s0,56
ffffffffc02053f8:	e6cff0ef          	jal	ra,ffffffffc0204a64 <fd_array_dup>
ffffffffc02053fc:	03848493          	addi	s1,s1,56
ffffffffc0205400:	fe8913e3          	bne	s2,s0,ffffffffc02053e6 <dup_files+0x48>
ffffffffc0205404:	70a2                	ld	ra,40(sp)
ffffffffc0205406:	7402                	ld	s0,32(sp)
ffffffffc0205408:	64e2                	ld	s1,24(sp)
ffffffffc020540a:	6942                	ld	s2,16(sp)
ffffffffc020540c:	69a2                	ld	s3,8(sp)
ffffffffc020540e:	6a02                	ld	s4,0(sp)
ffffffffc0205410:	4501                	li	a0,0
ffffffffc0205412:	6145                	addi	sp,sp,48
ffffffffc0205414:	8082                	ret
ffffffffc0205416:	00008697          	auipc	a3,0x8
ffffffffc020541a:	de268693          	addi	a3,a3,-542 # ffffffffc020d1f8 <default_pmm_manager+0x8d8>
ffffffffc020541e:	00007617          	auipc	a2,0x7
ffffffffc0205422:	9e260613          	addi	a2,a2,-1566 # ffffffffc020be00 <commands+0x210>
ffffffffc0205426:	05300593          	li	a1,83
ffffffffc020542a:	00008517          	auipc	a0,0x8
ffffffffc020542e:	46650513          	addi	a0,a0,1126 # ffffffffc020d890 <CSWTCH.79+0x48>
ffffffffc0205432:	86cfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205436:	00008697          	auipc	a3,0x8
ffffffffc020543a:	48268693          	addi	a3,a3,1154 # ffffffffc020d8b8 <CSWTCH.79+0x70>
ffffffffc020543e:	00007617          	auipc	a2,0x7
ffffffffc0205442:	9c260613          	addi	a2,a2,-1598 # ffffffffc020be00 <commands+0x210>
ffffffffc0205446:	05400593          	li	a1,84
ffffffffc020544a:	00008517          	auipc	a0,0x8
ffffffffc020544e:	44650513          	addi	a0,a0,1094 # ffffffffc020d890 <CSWTCH.79+0x48>
ffffffffc0205452:	84cfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205456 <iobuf_skip.part.0>:
ffffffffc0205456:	1141                	addi	sp,sp,-16
ffffffffc0205458:	00008697          	auipc	a3,0x8
ffffffffc020545c:	49068693          	addi	a3,a3,1168 # ffffffffc020d8e8 <CSWTCH.79+0xa0>
ffffffffc0205460:	00007617          	auipc	a2,0x7
ffffffffc0205464:	9a060613          	addi	a2,a2,-1632 # ffffffffc020be00 <commands+0x210>
ffffffffc0205468:	04a00593          	li	a1,74
ffffffffc020546c:	00008517          	auipc	a0,0x8
ffffffffc0205470:	49450513          	addi	a0,a0,1172 # ffffffffc020d900 <CSWTCH.79+0xb8>
ffffffffc0205474:	e406                	sd	ra,8(sp)
ffffffffc0205476:	828fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020547a <iobuf_init>:
ffffffffc020547a:	e10c                	sd	a1,0(a0)
ffffffffc020547c:	e514                	sd	a3,8(a0)
ffffffffc020547e:	ed10                	sd	a2,24(a0)
ffffffffc0205480:	e910                	sd	a2,16(a0)
ffffffffc0205482:	8082                	ret

ffffffffc0205484 <iobuf_move>:
ffffffffc0205484:	7179                	addi	sp,sp,-48
ffffffffc0205486:	ec26                	sd	s1,24(sp)
ffffffffc0205488:	6d04                	ld	s1,24(a0)
ffffffffc020548a:	f022                	sd	s0,32(sp)
ffffffffc020548c:	e84a                	sd	s2,16(sp)
ffffffffc020548e:	e44e                	sd	s3,8(sp)
ffffffffc0205490:	f406                	sd	ra,40(sp)
ffffffffc0205492:	842a                	mv	s0,a0
ffffffffc0205494:	8932                	mv	s2,a2
ffffffffc0205496:	852e                	mv	a0,a1
ffffffffc0205498:	89ba                	mv	s3,a4
ffffffffc020549a:	00967363          	bgeu	a2,s1,ffffffffc02054a0 <iobuf_move+0x1c>
ffffffffc020549e:	84b2                	mv	s1,a2
ffffffffc02054a0:	c495                	beqz	s1,ffffffffc02054cc <iobuf_move+0x48>
ffffffffc02054a2:	600c                	ld	a1,0(s0)
ffffffffc02054a4:	c681                	beqz	a3,ffffffffc02054ac <iobuf_move+0x28>
ffffffffc02054a6:	87ae                	mv	a5,a1
ffffffffc02054a8:	85aa                	mv	a1,a0
ffffffffc02054aa:	853e                	mv	a0,a5
ffffffffc02054ac:	8626                	mv	a2,s1
ffffffffc02054ae:	47c060ef          	jal	ra,ffffffffc020b92a <memmove>
ffffffffc02054b2:	6c1c                	ld	a5,24(s0)
ffffffffc02054b4:	0297ea63          	bltu	a5,s1,ffffffffc02054e8 <iobuf_move+0x64>
ffffffffc02054b8:	6014                	ld	a3,0(s0)
ffffffffc02054ba:	6418                	ld	a4,8(s0)
ffffffffc02054bc:	8f85                	sub	a5,a5,s1
ffffffffc02054be:	96a6                	add	a3,a3,s1
ffffffffc02054c0:	9726                	add	a4,a4,s1
ffffffffc02054c2:	e014                	sd	a3,0(s0)
ffffffffc02054c4:	e418                	sd	a4,8(s0)
ffffffffc02054c6:	ec1c                	sd	a5,24(s0)
ffffffffc02054c8:	40990933          	sub	s2,s2,s1
ffffffffc02054cc:	00098463          	beqz	s3,ffffffffc02054d4 <iobuf_move+0x50>
ffffffffc02054d0:	0099b023          	sd	s1,0(s3)
ffffffffc02054d4:	4501                	li	a0,0
ffffffffc02054d6:	00091b63          	bnez	s2,ffffffffc02054ec <iobuf_move+0x68>
ffffffffc02054da:	70a2                	ld	ra,40(sp)
ffffffffc02054dc:	7402                	ld	s0,32(sp)
ffffffffc02054de:	64e2                	ld	s1,24(sp)
ffffffffc02054e0:	6942                	ld	s2,16(sp)
ffffffffc02054e2:	69a2                	ld	s3,8(sp)
ffffffffc02054e4:	6145                	addi	sp,sp,48
ffffffffc02054e6:	8082                	ret
ffffffffc02054e8:	f6fff0ef          	jal	ra,ffffffffc0205456 <iobuf_skip.part.0>
ffffffffc02054ec:	5571                	li	a0,-4
ffffffffc02054ee:	b7f5                	j	ffffffffc02054da <iobuf_move+0x56>

ffffffffc02054f0 <iobuf_skip>:
ffffffffc02054f0:	6d1c                	ld	a5,24(a0)
ffffffffc02054f2:	00b7eb63          	bltu	a5,a1,ffffffffc0205508 <iobuf_skip+0x18>
ffffffffc02054f6:	6114                	ld	a3,0(a0)
ffffffffc02054f8:	6518                	ld	a4,8(a0)
ffffffffc02054fa:	8f8d                	sub	a5,a5,a1
ffffffffc02054fc:	96ae                	add	a3,a3,a1
ffffffffc02054fe:	95ba                	add	a1,a1,a4
ffffffffc0205500:	e114                	sd	a3,0(a0)
ffffffffc0205502:	e50c                	sd	a1,8(a0)
ffffffffc0205504:	ed1c                	sd	a5,24(a0)
ffffffffc0205506:	8082                	ret
ffffffffc0205508:	1141                	addi	sp,sp,-16
ffffffffc020550a:	e406                	sd	ra,8(sp)
ffffffffc020550c:	f4bff0ef          	jal	ra,ffffffffc0205456 <iobuf_skip.part.0>

ffffffffc0205510 <copy_path>:
ffffffffc0205510:	7139                	addi	sp,sp,-64
ffffffffc0205512:	f04a                	sd	s2,32(sp)
ffffffffc0205514:	00091917          	auipc	s2,0x91
ffffffffc0205518:	3ac90913          	addi	s2,s2,940 # ffffffffc02968c0 <current>
ffffffffc020551c:	00093703          	ld	a4,0(s2)
ffffffffc0205520:	ec4e                	sd	s3,24(sp)
ffffffffc0205522:	89aa                	mv	s3,a0
ffffffffc0205524:	6505                	lui	a0,0x1
ffffffffc0205526:	f426                	sd	s1,40(sp)
ffffffffc0205528:	e852                	sd	s4,16(sp)
ffffffffc020552a:	fc06                	sd	ra,56(sp)
ffffffffc020552c:	f822                	sd	s0,48(sp)
ffffffffc020552e:	e456                	sd	s5,8(sp)
ffffffffc0205530:	02873a03          	ld	s4,40(a4)
ffffffffc0205534:	84ae                	mv	s1,a1
ffffffffc0205536:	aedfc0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020553a:	c141                	beqz	a0,ffffffffc02055ba <copy_path+0xaa>
ffffffffc020553c:	842a                	mv	s0,a0
ffffffffc020553e:	040a0563          	beqz	s4,ffffffffc0205588 <copy_path+0x78>
ffffffffc0205542:	038a0a93          	addi	s5,s4,56
ffffffffc0205546:	8556                	mv	a0,s5
ffffffffc0205548:	8b4ff0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020554c:	00093783          	ld	a5,0(s2)
ffffffffc0205550:	cba1                	beqz	a5,ffffffffc02055a0 <copy_path+0x90>
ffffffffc0205552:	43dc                	lw	a5,4(a5)
ffffffffc0205554:	6685                	lui	a3,0x1
ffffffffc0205556:	8626                	mv	a2,s1
ffffffffc0205558:	04fa2823          	sw	a5,80(s4)
ffffffffc020555c:	85a2                	mv	a1,s0
ffffffffc020555e:	8552                	mv	a0,s4
ffffffffc0205560:	ec1fe0ef          	jal	ra,ffffffffc0204420 <copy_string>
ffffffffc0205564:	c529                	beqz	a0,ffffffffc02055ae <copy_path+0x9e>
ffffffffc0205566:	8556                	mv	a0,s5
ffffffffc0205568:	890ff0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020556c:	040a2823          	sw	zero,80(s4)
ffffffffc0205570:	0089b023          	sd	s0,0(s3)
ffffffffc0205574:	4501                	li	a0,0
ffffffffc0205576:	70e2                	ld	ra,56(sp)
ffffffffc0205578:	7442                	ld	s0,48(sp)
ffffffffc020557a:	74a2                	ld	s1,40(sp)
ffffffffc020557c:	7902                	ld	s2,32(sp)
ffffffffc020557e:	69e2                	ld	s3,24(sp)
ffffffffc0205580:	6a42                	ld	s4,16(sp)
ffffffffc0205582:	6aa2                	ld	s5,8(sp)
ffffffffc0205584:	6121                	addi	sp,sp,64
ffffffffc0205586:	8082                	ret
ffffffffc0205588:	85aa                	mv	a1,a0
ffffffffc020558a:	6685                	lui	a3,0x1
ffffffffc020558c:	8626                	mv	a2,s1
ffffffffc020558e:	4501                	li	a0,0
ffffffffc0205590:	e91fe0ef          	jal	ra,ffffffffc0204420 <copy_string>
ffffffffc0205594:	fd71                	bnez	a0,ffffffffc0205570 <copy_path+0x60>
ffffffffc0205596:	8522                	mv	a0,s0
ffffffffc0205598:	b3bfc0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020559c:	5575                	li	a0,-3
ffffffffc020559e:	bfe1                	j	ffffffffc0205576 <copy_path+0x66>
ffffffffc02055a0:	6685                	lui	a3,0x1
ffffffffc02055a2:	8626                	mv	a2,s1
ffffffffc02055a4:	85a2                	mv	a1,s0
ffffffffc02055a6:	8552                	mv	a0,s4
ffffffffc02055a8:	e79fe0ef          	jal	ra,ffffffffc0204420 <copy_string>
ffffffffc02055ac:	fd4d                	bnez	a0,ffffffffc0205566 <copy_path+0x56>
ffffffffc02055ae:	8556                	mv	a0,s5
ffffffffc02055b0:	848ff0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02055b4:	040a2823          	sw	zero,80(s4)
ffffffffc02055b8:	bff9                	j	ffffffffc0205596 <copy_path+0x86>
ffffffffc02055ba:	5571                	li	a0,-4
ffffffffc02055bc:	bf6d                	j	ffffffffc0205576 <copy_path+0x66>

ffffffffc02055be <sysfile_open>:
ffffffffc02055be:	7179                	addi	sp,sp,-48
ffffffffc02055c0:	872a                	mv	a4,a0
ffffffffc02055c2:	ec26                	sd	s1,24(sp)
ffffffffc02055c4:	0028                	addi	a0,sp,8
ffffffffc02055c6:	84ae                	mv	s1,a1
ffffffffc02055c8:	85ba                	mv	a1,a4
ffffffffc02055ca:	f022                	sd	s0,32(sp)
ffffffffc02055cc:	f406                	sd	ra,40(sp)
ffffffffc02055ce:	f43ff0ef          	jal	ra,ffffffffc0205510 <copy_path>
ffffffffc02055d2:	842a                	mv	s0,a0
ffffffffc02055d4:	e909                	bnez	a0,ffffffffc02055e6 <sysfile_open+0x28>
ffffffffc02055d6:	6522                	ld	a0,8(sp)
ffffffffc02055d8:	85a6                	mv	a1,s1
ffffffffc02055da:	d60ff0ef          	jal	ra,ffffffffc0204b3a <file_open>
ffffffffc02055de:	842a                	mv	s0,a0
ffffffffc02055e0:	6522                	ld	a0,8(sp)
ffffffffc02055e2:	af1fc0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02055e6:	70a2                	ld	ra,40(sp)
ffffffffc02055e8:	8522                	mv	a0,s0
ffffffffc02055ea:	7402                	ld	s0,32(sp)
ffffffffc02055ec:	64e2                	ld	s1,24(sp)
ffffffffc02055ee:	6145                	addi	sp,sp,48
ffffffffc02055f0:	8082                	ret

ffffffffc02055f2 <sysfile_close>:
ffffffffc02055f2:	e46ff06f          	j	ffffffffc0204c38 <file_close>

ffffffffc02055f6 <sysfile_read>:
ffffffffc02055f6:	7159                	addi	sp,sp,-112
ffffffffc02055f8:	f0a2                	sd	s0,96(sp)
ffffffffc02055fa:	f486                	sd	ra,104(sp)
ffffffffc02055fc:	eca6                	sd	s1,88(sp)
ffffffffc02055fe:	e8ca                	sd	s2,80(sp)
ffffffffc0205600:	e4ce                	sd	s3,72(sp)
ffffffffc0205602:	e0d2                	sd	s4,64(sp)
ffffffffc0205604:	fc56                	sd	s5,56(sp)
ffffffffc0205606:	f85a                	sd	s6,48(sp)
ffffffffc0205608:	f45e                	sd	s7,40(sp)
ffffffffc020560a:	f062                	sd	s8,32(sp)
ffffffffc020560c:	ec66                	sd	s9,24(sp)
ffffffffc020560e:	4401                	li	s0,0
ffffffffc0205610:	ee19                	bnez	a2,ffffffffc020562e <sysfile_read+0x38>
ffffffffc0205612:	70a6                	ld	ra,104(sp)
ffffffffc0205614:	8522                	mv	a0,s0
ffffffffc0205616:	7406                	ld	s0,96(sp)
ffffffffc0205618:	64e6                	ld	s1,88(sp)
ffffffffc020561a:	6946                	ld	s2,80(sp)
ffffffffc020561c:	69a6                	ld	s3,72(sp)
ffffffffc020561e:	6a06                	ld	s4,64(sp)
ffffffffc0205620:	7ae2                	ld	s5,56(sp)
ffffffffc0205622:	7b42                	ld	s6,48(sp)
ffffffffc0205624:	7ba2                	ld	s7,40(sp)
ffffffffc0205626:	7c02                	ld	s8,32(sp)
ffffffffc0205628:	6ce2                	ld	s9,24(sp)
ffffffffc020562a:	6165                	addi	sp,sp,112
ffffffffc020562c:	8082                	ret
ffffffffc020562e:	00091c97          	auipc	s9,0x91
ffffffffc0205632:	292c8c93          	addi	s9,s9,658 # ffffffffc02968c0 <current>
ffffffffc0205636:	000cb783          	ld	a5,0(s9)
ffffffffc020563a:	84b2                	mv	s1,a2
ffffffffc020563c:	8b2e                	mv	s6,a1
ffffffffc020563e:	4601                	li	a2,0
ffffffffc0205640:	4585                	li	a1,1
ffffffffc0205642:	0287b903          	ld	s2,40(a5)
ffffffffc0205646:	8aaa                	mv	s5,a0
ffffffffc0205648:	c9eff0ef          	jal	ra,ffffffffc0204ae6 <file_testfd>
ffffffffc020564c:	c959                	beqz	a0,ffffffffc02056e2 <sysfile_read+0xec>
ffffffffc020564e:	6505                	lui	a0,0x1
ffffffffc0205650:	9d3fc0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0205654:	89aa                	mv	s3,a0
ffffffffc0205656:	c941                	beqz	a0,ffffffffc02056e6 <sysfile_read+0xf0>
ffffffffc0205658:	4b81                	li	s7,0
ffffffffc020565a:	6a05                	lui	s4,0x1
ffffffffc020565c:	03890c13          	addi	s8,s2,56
ffffffffc0205660:	0744ec63          	bltu	s1,s4,ffffffffc02056d8 <sysfile_read+0xe2>
ffffffffc0205664:	e452                	sd	s4,8(sp)
ffffffffc0205666:	6605                	lui	a2,0x1
ffffffffc0205668:	0034                	addi	a3,sp,8
ffffffffc020566a:	85ce                	mv	a1,s3
ffffffffc020566c:	8556                	mv	a0,s5
ffffffffc020566e:	e20ff0ef          	jal	ra,ffffffffc0204c8e <file_read>
ffffffffc0205672:	66a2                	ld	a3,8(sp)
ffffffffc0205674:	842a                	mv	s0,a0
ffffffffc0205676:	ca9d                	beqz	a3,ffffffffc02056ac <sysfile_read+0xb6>
ffffffffc0205678:	00090c63          	beqz	s2,ffffffffc0205690 <sysfile_read+0x9a>
ffffffffc020567c:	8562                	mv	a0,s8
ffffffffc020567e:	f7ffe0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0205682:	000cb783          	ld	a5,0(s9)
ffffffffc0205686:	cfa1                	beqz	a5,ffffffffc02056de <sysfile_read+0xe8>
ffffffffc0205688:	43dc                	lw	a5,4(a5)
ffffffffc020568a:	66a2                	ld	a3,8(sp)
ffffffffc020568c:	04f92823          	sw	a5,80(s2)
ffffffffc0205690:	864e                	mv	a2,s3
ffffffffc0205692:	85da                	mv	a1,s6
ffffffffc0205694:	854a                	mv	a0,s2
ffffffffc0205696:	d59fe0ef          	jal	ra,ffffffffc02043ee <copy_to_user>
ffffffffc020569a:	c50d                	beqz	a0,ffffffffc02056c4 <sysfile_read+0xce>
ffffffffc020569c:	67a2                	ld	a5,8(sp)
ffffffffc020569e:	04f4e663          	bltu	s1,a5,ffffffffc02056ea <sysfile_read+0xf4>
ffffffffc02056a2:	9b3e                	add	s6,s6,a5
ffffffffc02056a4:	8c9d                	sub	s1,s1,a5
ffffffffc02056a6:	9bbe                	add	s7,s7,a5
ffffffffc02056a8:	02091263          	bnez	s2,ffffffffc02056cc <sysfile_read+0xd6>
ffffffffc02056ac:	e401                	bnez	s0,ffffffffc02056b4 <sysfile_read+0xbe>
ffffffffc02056ae:	67a2                	ld	a5,8(sp)
ffffffffc02056b0:	c391                	beqz	a5,ffffffffc02056b4 <sysfile_read+0xbe>
ffffffffc02056b2:	f4dd                	bnez	s1,ffffffffc0205660 <sysfile_read+0x6a>
ffffffffc02056b4:	854e                	mv	a0,s3
ffffffffc02056b6:	a1dfc0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02056ba:	f40b8ce3          	beqz	s7,ffffffffc0205612 <sysfile_read+0x1c>
ffffffffc02056be:	000b841b          	sext.w	s0,s7
ffffffffc02056c2:	bf81                	j	ffffffffc0205612 <sysfile_read+0x1c>
ffffffffc02056c4:	e011                	bnez	s0,ffffffffc02056c8 <sysfile_read+0xd2>
ffffffffc02056c6:	5475                	li	s0,-3
ffffffffc02056c8:	fe0906e3          	beqz	s2,ffffffffc02056b4 <sysfile_read+0xbe>
ffffffffc02056cc:	8562                	mv	a0,s8
ffffffffc02056ce:	f2bfe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02056d2:	04092823          	sw	zero,80(s2)
ffffffffc02056d6:	bfd9                	j	ffffffffc02056ac <sysfile_read+0xb6>
ffffffffc02056d8:	e426                	sd	s1,8(sp)
ffffffffc02056da:	8626                	mv	a2,s1
ffffffffc02056dc:	b771                	j	ffffffffc0205668 <sysfile_read+0x72>
ffffffffc02056de:	66a2                	ld	a3,8(sp)
ffffffffc02056e0:	bf45                	j	ffffffffc0205690 <sysfile_read+0x9a>
ffffffffc02056e2:	5475                	li	s0,-3
ffffffffc02056e4:	b73d                	j	ffffffffc0205612 <sysfile_read+0x1c>
ffffffffc02056e6:	5471                	li	s0,-4
ffffffffc02056e8:	b72d                	j	ffffffffc0205612 <sysfile_read+0x1c>
ffffffffc02056ea:	00008697          	auipc	a3,0x8
ffffffffc02056ee:	22668693          	addi	a3,a3,550 # ffffffffc020d910 <CSWTCH.79+0xc8>
ffffffffc02056f2:	00006617          	auipc	a2,0x6
ffffffffc02056f6:	70e60613          	addi	a2,a2,1806 # ffffffffc020be00 <commands+0x210>
ffffffffc02056fa:	05500593          	li	a1,85
ffffffffc02056fe:	00008517          	auipc	a0,0x8
ffffffffc0205702:	22250513          	addi	a0,a0,546 # ffffffffc020d920 <CSWTCH.79+0xd8>
ffffffffc0205706:	d99fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020570a <sysfile_write>:
ffffffffc020570a:	7159                	addi	sp,sp,-112
ffffffffc020570c:	e8ca                	sd	s2,80(sp)
ffffffffc020570e:	f486                	sd	ra,104(sp)
ffffffffc0205710:	f0a2                	sd	s0,96(sp)
ffffffffc0205712:	eca6                	sd	s1,88(sp)
ffffffffc0205714:	e4ce                	sd	s3,72(sp)
ffffffffc0205716:	e0d2                	sd	s4,64(sp)
ffffffffc0205718:	fc56                	sd	s5,56(sp)
ffffffffc020571a:	f85a                	sd	s6,48(sp)
ffffffffc020571c:	f45e                	sd	s7,40(sp)
ffffffffc020571e:	f062                	sd	s8,32(sp)
ffffffffc0205720:	ec66                	sd	s9,24(sp)
ffffffffc0205722:	4901                	li	s2,0
ffffffffc0205724:	ee19                	bnez	a2,ffffffffc0205742 <sysfile_write+0x38>
ffffffffc0205726:	70a6                	ld	ra,104(sp)
ffffffffc0205728:	7406                	ld	s0,96(sp)
ffffffffc020572a:	64e6                	ld	s1,88(sp)
ffffffffc020572c:	69a6                	ld	s3,72(sp)
ffffffffc020572e:	6a06                	ld	s4,64(sp)
ffffffffc0205730:	7ae2                	ld	s5,56(sp)
ffffffffc0205732:	7b42                	ld	s6,48(sp)
ffffffffc0205734:	7ba2                	ld	s7,40(sp)
ffffffffc0205736:	7c02                	ld	s8,32(sp)
ffffffffc0205738:	6ce2                	ld	s9,24(sp)
ffffffffc020573a:	854a                	mv	a0,s2
ffffffffc020573c:	6946                	ld	s2,80(sp)
ffffffffc020573e:	6165                	addi	sp,sp,112
ffffffffc0205740:	8082                	ret
ffffffffc0205742:	00091c17          	auipc	s8,0x91
ffffffffc0205746:	17ec0c13          	addi	s8,s8,382 # ffffffffc02968c0 <current>
ffffffffc020574a:	000c3783          	ld	a5,0(s8)
ffffffffc020574e:	8432                	mv	s0,a2
ffffffffc0205750:	89ae                	mv	s3,a1
ffffffffc0205752:	4605                	li	a2,1
ffffffffc0205754:	4581                	li	a1,0
ffffffffc0205756:	7784                	ld	s1,40(a5)
ffffffffc0205758:	8baa                	mv	s7,a0
ffffffffc020575a:	b8cff0ef          	jal	ra,ffffffffc0204ae6 <file_testfd>
ffffffffc020575e:	cd59                	beqz	a0,ffffffffc02057fc <sysfile_write+0xf2>
ffffffffc0205760:	6505                	lui	a0,0x1
ffffffffc0205762:	8c1fc0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0205766:	8a2a                	mv	s4,a0
ffffffffc0205768:	cd41                	beqz	a0,ffffffffc0205800 <sysfile_write+0xf6>
ffffffffc020576a:	4c81                	li	s9,0
ffffffffc020576c:	6a85                	lui	s5,0x1
ffffffffc020576e:	03848b13          	addi	s6,s1,56
ffffffffc0205772:	05546a63          	bltu	s0,s5,ffffffffc02057c6 <sysfile_write+0xbc>
ffffffffc0205776:	e456                	sd	s5,8(sp)
ffffffffc0205778:	c8a9                	beqz	s1,ffffffffc02057ca <sysfile_write+0xc0>
ffffffffc020577a:	855a                	mv	a0,s6
ffffffffc020577c:	e81fe0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0205780:	000c3783          	ld	a5,0(s8)
ffffffffc0205784:	c399                	beqz	a5,ffffffffc020578a <sysfile_write+0x80>
ffffffffc0205786:	43dc                	lw	a5,4(a5)
ffffffffc0205788:	c8bc                	sw	a5,80(s1)
ffffffffc020578a:	66a2                	ld	a3,8(sp)
ffffffffc020578c:	4701                	li	a4,0
ffffffffc020578e:	864e                	mv	a2,s3
ffffffffc0205790:	85d2                	mv	a1,s4
ffffffffc0205792:	8526                	mv	a0,s1
ffffffffc0205794:	c27fe0ef          	jal	ra,ffffffffc02043ba <copy_from_user>
ffffffffc0205798:	c139                	beqz	a0,ffffffffc02057de <sysfile_write+0xd4>
ffffffffc020579a:	855a                	mv	a0,s6
ffffffffc020579c:	e5dfe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02057a0:	0404a823          	sw	zero,80(s1)
ffffffffc02057a4:	6622                	ld	a2,8(sp)
ffffffffc02057a6:	0034                	addi	a3,sp,8
ffffffffc02057a8:	85d2                	mv	a1,s4
ffffffffc02057aa:	855e                	mv	a0,s7
ffffffffc02057ac:	dc8ff0ef          	jal	ra,ffffffffc0204d74 <file_write>
ffffffffc02057b0:	67a2                	ld	a5,8(sp)
ffffffffc02057b2:	892a                	mv	s2,a0
ffffffffc02057b4:	ef85                	bnez	a5,ffffffffc02057ec <sysfile_write+0xe2>
ffffffffc02057b6:	8552                	mv	a0,s4
ffffffffc02057b8:	91bfc0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02057bc:	f60c85e3          	beqz	s9,ffffffffc0205726 <sysfile_write+0x1c>
ffffffffc02057c0:	000c891b          	sext.w	s2,s9
ffffffffc02057c4:	b78d                	j	ffffffffc0205726 <sysfile_write+0x1c>
ffffffffc02057c6:	e422                	sd	s0,8(sp)
ffffffffc02057c8:	f8cd                	bnez	s1,ffffffffc020577a <sysfile_write+0x70>
ffffffffc02057ca:	66a2                	ld	a3,8(sp)
ffffffffc02057cc:	4701                	li	a4,0
ffffffffc02057ce:	864e                	mv	a2,s3
ffffffffc02057d0:	85d2                	mv	a1,s4
ffffffffc02057d2:	4501                	li	a0,0
ffffffffc02057d4:	be7fe0ef          	jal	ra,ffffffffc02043ba <copy_from_user>
ffffffffc02057d8:	f571                	bnez	a0,ffffffffc02057a4 <sysfile_write+0x9a>
ffffffffc02057da:	5975                	li	s2,-3
ffffffffc02057dc:	bfe9                	j	ffffffffc02057b6 <sysfile_write+0xac>
ffffffffc02057de:	855a                	mv	a0,s6
ffffffffc02057e0:	e19fe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02057e4:	5975                	li	s2,-3
ffffffffc02057e6:	0404a823          	sw	zero,80(s1)
ffffffffc02057ea:	b7f1                	j	ffffffffc02057b6 <sysfile_write+0xac>
ffffffffc02057ec:	00f46c63          	bltu	s0,a5,ffffffffc0205804 <sysfile_write+0xfa>
ffffffffc02057f0:	99be                	add	s3,s3,a5
ffffffffc02057f2:	8c1d                	sub	s0,s0,a5
ffffffffc02057f4:	9cbe                	add	s9,s9,a5
ffffffffc02057f6:	f161                	bnez	a0,ffffffffc02057b6 <sysfile_write+0xac>
ffffffffc02057f8:	fc2d                	bnez	s0,ffffffffc0205772 <sysfile_write+0x68>
ffffffffc02057fa:	bf75                	j	ffffffffc02057b6 <sysfile_write+0xac>
ffffffffc02057fc:	5975                	li	s2,-3
ffffffffc02057fe:	b725                	j	ffffffffc0205726 <sysfile_write+0x1c>
ffffffffc0205800:	5971                	li	s2,-4
ffffffffc0205802:	b715                	j	ffffffffc0205726 <sysfile_write+0x1c>
ffffffffc0205804:	00008697          	auipc	a3,0x8
ffffffffc0205808:	10c68693          	addi	a3,a3,268 # ffffffffc020d910 <CSWTCH.79+0xc8>
ffffffffc020580c:	00006617          	auipc	a2,0x6
ffffffffc0205810:	5f460613          	addi	a2,a2,1524 # ffffffffc020be00 <commands+0x210>
ffffffffc0205814:	08a00593          	li	a1,138
ffffffffc0205818:	00008517          	auipc	a0,0x8
ffffffffc020581c:	10850513          	addi	a0,a0,264 # ffffffffc020d920 <CSWTCH.79+0xd8>
ffffffffc0205820:	c7ffa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205824 <sysfile_seek>:
ffffffffc0205824:	e36ff06f          	j	ffffffffc0204e5a <file_seek>

ffffffffc0205828 <sysfile_fstat>:
ffffffffc0205828:	715d                	addi	sp,sp,-80
ffffffffc020582a:	f44e                	sd	s3,40(sp)
ffffffffc020582c:	00091997          	auipc	s3,0x91
ffffffffc0205830:	09498993          	addi	s3,s3,148 # ffffffffc02968c0 <current>
ffffffffc0205834:	0009b703          	ld	a4,0(s3)
ffffffffc0205838:	fc26                	sd	s1,56(sp)
ffffffffc020583a:	84ae                	mv	s1,a1
ffffffffc020583c:	858a                	mv	a1,sp
ffffffffc020583e:	e0a2                	sd	s0,64(sp)
ffffffffc0205840:	f84a                	sd	s2,48(sp)
ffffffffc0205842:	e486                	sd	ra,72(sp)
ffffffffc0205844:	02873903          	ld	s2,40(a4)
ffffffffc0205848:	f052                	sd	s4,32(sp)
ffffffffc020584a:	f30ff0ef          	jal	ra,ffffffffc0204f7a <file_fstat>
ffffffffc020584e:	842a                	mv	s0,a0
ffffffffc0205850:	e91d                	bnez	a0,ffffffffc0205886 <sysfile_fstat+0x5e>
ffffffffc0205852:	04090363          	beqz	s2,ffffffffc0205898 <sysfile_fstat+0x70>
ffffffffc0205856:	03890a13          	addi	s4,s2,56
ffffffffc020585a:	8552                	mv	a0,s4
ffffffffc020585c:	da1fe0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0205860:	0009b783          	ld	a5,0(s3)
ffffffffc0205864:	c3b9                	beqz	a5,ffffffffc02058aa <sysfile_fstat+0x82>
ffffffffc0205866:	43dc                	lw	a5,4(a5)
ffffffffc0205868:	02000693          	li	a3,32
ffffffffc020586c:	860a                	mv	a2,sp
ffffffffc020586e:	04f92823          	sw	a5,80(s2)
ffffffffc0205872:	85a6                	mv	a1,s1
ffffffffc0205874:	854a                	mv	a0,s2
ffffffffc0205876:	b79fe0ef          	jal	ra,ffffffffc02043ee <copy_to_user>
ffffffffc020587a:	c121                	beqz	a0,ffffffffc02058ba <sysfile_fstat+0x92>
ffffffffc020587c:	8552                	mv	a0,s4
ffffffffc020587e:	d7bfe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0205882:	04092823          	sw	zero,80(s2)
ffffffffc0205886:	60a6                	ld	ra,72(sp)
ffffffffc0205888:	8522                	mv	a0,s0
ffffffffc020588a:	6406                	ld	s0,64(sp)
ffffffffc020588c:	74e2                	ld	s1,56(sp)
ffffffffc020588e:	7942                	ld	s2,48(sp)
ffffffffc0205890:	79a2                	ld	s3,40(sp)
ffffffffc0205892:	7a02                	ld	s4,32(sp)
ffffffffc0205894:	6161                	addi	sp,sp,80
ffffffffc0205896:	8082                	ret
ffffffffc0205898:	02000693          	li	a3,32
ffffffffc020589c:	860a                	mv	a2,sp
ffffffffc020589e:	85a6                	mv	a1,s1
ffffffffc02058a0:	b4ffe0ef          	jal	ra,ffffffffc02043ee <copy_to_user>
ffffffffc02058a4:	f16d                	bnez	a0,ffffffffc0205886 <sysfile_fstat+0x5e>
ffffffffc02058a6:	5475                	li	s0,-3
ffffffffc02058a8:	bff9                	j	ffffffffc0205886 <sysfile_fstat+0x5e>
ffffffffc02058aa:	02000693          	li	a3,32
ffffffffc02058ae:	860a                	mv	a2,sp
ffffffffc02058b0:	85a6                	mv	a1,s1
ffffffffc02058b2:	854a                	mv	a0,s2
ffffffffc02058b4:	b3bfe0ef          	jal	ra,ffffffffc02043ee <copy_to_user>
ffffffffc02058b8:	f171                	bnez	a0,ffffffffc020587c <sysfile_fstat+0x54>
ffffffffc02058ba:	8552                	mv	a0,s4
ffffffffc02058bc:	d3dfe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02058c0:	5475                	li	s0,-3
ffffffffc02058c2:	04092823          	sw	zero,80(s2)
ffffffffc02058c6:	b7c1                	j	ffffffffc0205886 <sysfile_fstat+0x5e>

ffffffffc02058c8 <sysfile_fsync>:
ffffffffc02058c8:	f72ff06f          	j	ffffffffc020503a <file_fsync>

ffffffffc02058cc <sysfile_getcwd>:
ffffffffc02058cc:	715d                	addi	sp,sp,-80
ffffffffc02058ce:	f44e                	sd	s3,40(sp)
ffffffffc02058d0:	00091997          	auipc	s3,0x91
ffffffffc02058d4:	ff098993          	addi	s3,s3,-16 # ffffffffc02968c0 <current>
ffffffffc02058d8:	0009b783          	ld	a5,0(s3)
ffffffffc02058dc:	f84a                	sd	s2,48(sp)
ffffffffc02058de:	e486                	sd	ra,72(sp)
ffffffffc02058e0:	e0a2                	sd	s0,64(sp)
ffffffffc02058e2:	fc26                	sd	s1,56(sp)
ffffffffc02058e4:	f052                	sd	s4,32(sp)
ffffffffc02058e6:	0287b903          	ld	s2,40(a5)
ffffffffc02058ea:	cda9                	beqz	a1,ffffffffc0205944 <sysfile_getcwd+0x78>
ffffffffc02058ec:	842e                	mv	s0,a1
ffffffffc02058ee:	84aa                	mv	s1,a0
ffffffffc02058f0:	04090363          	beqz	s2,ffffffffc0205936 <sysfile_getcwd+0x6a>
ffffffffc02058f4:	03890a13          	addi	s4,s2,56
ffffffffc02058f8:	8552                	mv	a0,s4
ffffffffc02058fa:	d03fe0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc02058fe:	0009b783          	ld	a5,0(s3)
ffffffffc0205902:	c781                	beqz	a5,ffffffffc020590a <sysfile_getcwd+0x3e>
ffffffffc0205904:	43dc                	lw	a5,4(a5)
ffffffffc0205906:	04f92823          	sw	a5,80(s2)
ffffffffc020590a:	4685                	li	a3,1
ffffffffc020590c:	8622                	mv	a2,s0
ffffffffc020590e:	85a6                	mv	a1,s1
ffffffffc0205910:	854a                	mv	a0,s2
ffffffffc0205912:	a15fe0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc0205916:	e90d                	bnez	a0,ffffffffc0205948 <sysfile_getcwd+0x7c>
ffffffffc0205918:	5475                	li	s0,-3
ffffffffc020591a:	8552                	mv	a0,s4
ffffffffc020591c:	cddfe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0205920:	04092823          	sw	zero,80(s2)
ffffffffc0205924:	60a6                	ld	ra,72(sp)
ffffffffc0205926:	8522                	mv	a0,s0
ffffffffc0205928:	6406                	ld	s0,64(sp)
ffffffffc020592a:	74e2                	ld	s1,56(sp)
ffffffffc020592c:	7942                	ld	s2,48(sp)
ffffffffc020592e:	79a2                	ld	s3,40(sp)
ffffffffc0205930:	7a02                	ld	s4,32(sp)
ffffffffc0205932:	6161                	addi	sp,sp,80
ffffffffc0205934:	8082                	ret
ffffffffc0205936:	862e                	mv	a2,a1
ffffffffc0205938:	4685                	li	a3,1
ffffffffc020593a:	85aa                	mv	a1,a0
ffffffffc020593c:	4501                	li	a0,0
ffffffffc020593e:	9e9fe0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc0205942:	ed09                	bnez	a0,ffffffffc020595c <sysfile_getcwd+0x90>
ffffffffc0205944:	5475                	li	s0,-3
ffffffffc0205946:	bff9                	j	ffffffffc0205924 <sysfile_getcwd+0x58>
ffffffffc0205948:	8622                	mv	a2,s0
ffffffffc020594a:	4681                	li	a3,0
ffffffffc020594c:	85a6                	mv	a1,s1
ffffffffc020594e:	850a                	mv	a0,sp
ffffffffc0205950:	b2bff0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0205954:	745020ef          	jal	ra,ffffffffc0208898 <vfs_getcwd>
ffffffffc0205958:	842a                	mv	s0,a0
ffffffffc020595a:	b7c1                	j	ffffffffc020591a <sysfile_getcwd+0x4e>
ffffffffc020595c:	8622                	mv	a2,s0
ffffffffc020595e:	4681                	li	a3,0
ffffffffc0205960:	85a6                	mv	a1,s1
ffffffffc0205962:	850a                	mv	a0,sp
ffffffffc0205964:	b17ff0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0205968:	731020ef          	jal	ra,ffffffffc0208898 <vfs_getcwd>
ffffffffc020596c:	842a                	mv	s0,a0
ffffffffc020596e:	bf5d                	j	ffffffffc0205924 <sysfile_getcwd+0x58>

ffffffffc0205970 <sysfile_getdirentry>:
ffffffffc0205970:	7139                	addi	sp,sp,-64
ffffffffc0205972:	e852                	sd	s4,16(sp)
ffffffffc0205974:	00091a17          	auipc	s4,0x91
ffffffffc0205978:	f4ca0a13          	addi	s4,s4,-180 # ffffffffc02968c0 <current>
ffffffffc020597c:	000a3703          	ld	a4,0(s4)
ffffffffc0205980:	ec4e                	sd	s3,24(sp)
ffffffffc0205982:	89aa                	mv	s3,a0
ffffffffc0205984:	10800513          	li	a0,264
ffffffffc0205988:	f426                	sd	s1,40(sp)
ffffffffc020598a:	f04a                	sd	s2,32(sp)
ffffffffc020598c:	fc06                	sd	ra,56(sp)
ffffffffc020598e:	f822                	sd	s0,48(sp)
ffffffffc0205990:	e456                	sd	s5,8(sp)
ffffffffc0205992:	7704                	ld	s1,40(a4)
ffffffffc0205994:	892e                	mv	s2,a1
ffffffffc0205996:	e8cfc0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020599a:	c169                	beqz	a0,ffffffffc0205a5c <sysfile_getdirentry+0xec>
ffffffffc020599c:	842a                	mv	s0,a0
ffffffffc020599e:	c8c1                	beqz	s1,ffffffffc0205a2e <sysfile_getdirentry+0xbe>
ffffffffc02059a0:	03848a93          	addi	s5,s1,56
ffffffffc02059a4:	8556                	mv	a0,s5
ffffffffc02059a6:	c57fe0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc02059aa:	000a3783          	ld	a5,0(s4)
ffffffffc02059ae:	c399                	beqz	a5,ffffffffc02059b4 <sysfile_getdirentry+0x44>
ffffffffc02059b0:	43dc                	lw	a5,4(a5)
ffffffffc02059b2:	c8bc                	sw	a5,80(s1)
ffffffffc02059b4:	4705                	li	a4,1
ffffffffc02059b6:	46a1                	li	a3,8
ffffffffc02059b8:	864a                	mv	a2,s2
ffffffffc02059ba:	85a2                	mv	a1,s0
ffffffffc02059bc:	8526                	mv	a0,s1
ffffffffc02059be:	9fdfe0ef          	jal	ra,ffffffffc02043ba <copy_from_user>
ffffffffc02059c2:	e505                	bnez	a0,ffffffffc02059ea <sysfile_getdirentry+0x7a>
ffffffffc02059c4:	8556                	mv	a0,s5
ffffffffc02059c6:	c33fe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02059ca:	59f5                	li	s3,-3
ffffffffc02059cc:	0404a823          	sw	zero,80(s1)
ffffffffc02059d0:	8522                	mv	a0,s0
ffffffffc02059d2:	f00fc0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02059d6:	70e2                	ld	ra,56(sp)
ffffffffc02059d8:	7442                	ld	s0,48(sp)
ffffffffc02059da:	74a2                	ld	s1,40(sp)
ffffffffc02059dc:	7902                	ld	s2,32(sp)
ffffffffc02059de:	6a42                	ld	s4,16(sp)
ffffffffc02059e0:	6aa2                	ld	s5,8(sp)
ffffffffc02059e2:	854e                	mv	a0,s3
ffffffffc02059e4:	69e2                	ld	s3,24(sp)
ffffffffc02059e6:	6121                	addi	sp,sp,64
ffffffffc02059e8:	8082                	ret
ffffffffc02059ea:	8556                	mv	a0,s5
ffffffffc02059ec:	c0dfe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02059f0:	854e                	mv	a0,s3
ffffffffc02059f2:	85a2                	mv	a1,s0
ffffffffc02059f4:	0404a823          	sw	zero,80(s1)
ffffffffc02059f8:	ef0ff0ef          	jal	ra,ffffffffc02050e8 <file_getdirentry>
ffffffffc02059fc:	89aa                	mv	s3,a0
ffffffffc02059fe:	f969                	bnez	a0,ffffffffc02059d0 <sysfile_getdirentry+0x60>
ffffffffc0205a00:	8556                	mv	a0,s5
ffffffffc0205a02:	bfbfe0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0205a06:	000a3783          	ld	a5,0(s4)
ffffffffc0205a0a:	c399                	beqz	a5,ffffffffc0205a10 <sysfile_getdirentry+0xa0>
ffffffffc0205a0c:	43dc                	lw	a5,4(a5)
ffffffffc0205a0e:	c8bc                	sw	a5,80(s1)
ffffffffc0205a10:	10800693          	li	a3,264
ffffffffc0205a14:	8622                	mv	a2,s0
ffffffffc0205a16:	85ca                	mv	a1,s2
ffffffffc0205a18:	8526                	mv	a0,s1
ffffffffc0205a1a:	9d5fe0ef          	jal	ra,ffffffffc02043ee <copy_to_user>
ffffffffc0205a1e:	e111                	bnez	a0,ffffffffc0205a22 <sysfile_getdirentry+0xb2>
ffffffffc0205a20:	59f5                	li	s3,-3
ffffffffc0205a22:	8556                	mv	a0,s5
ffffffffc0205a24:	bd5fe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0205a28:	0404a823          	sw	zero,80(s1)
ffffffffc0205a2c:	b755                	j	ffffffffc02059d0 <sysfile_getdirentry+0x60>
ffffffffc0205a2e:	85aa                	mv	a1,a0
ffffffffc0205a30:	4705                	li	a4,1
ffffffffc0205a32:	46a1                	li	a3,8
ffffffffc0205a34:	864a                	mv	a2,s2
ffffffffc0205a36:	4501                	li	a0,0
ffffffffc0205a38:	983fe0ef          	jal	ra,ffffffffc02043ba <copy_from_user>
ffffffffc0205a3c:	cd11                	beqz	a0,ffffffffc0205a58 <sysfile_getdirentry+0xe8>
ffffffffc0205a3e:	854e                	mv	a0,s3
ffffffffc0205a40:	85a2                	mv	a1,s0
ffffffffc0205a42:	ea6ff0ef          	jal	ra,ffffffffc02050e8 <file_getdirentry>
ffffffffc0205a46:	89aa                	mv	s3,a0
ffffffffc0205a48:	f541                	bnez	a0,ffffffffc02059d0 <sysfile_getdirentry+0x60>
ffffffffc0205a4a:	10800693          	li	a3,264
ffffffffc0205a4e:	8622                	mv	a2,s0
ffffffffc0205a50:	85ca                	mv	a1,s2
ffffffffc0205a52:	99dfe0ef          	jal	ra,ffffffffc02043ee <copy_to_user>
ffffffffc0205a56:	fd2d                	bnez	a0,ffffffffc02059d0 <sysfile_getdirentry+0x60>
ffffffffc0205a58:	59f5                	li	s3,-3
ffffffffc0205a5a:	bf9d                	j	ffffffffc02059d0 <sysfile_getdirentry+0x60>
ffffffffc0205a5c:	59f1                	li	s3,-4
ffffffffc0205a5e:	bfa5                	j	ffffffffc02059d6 <sysfile_getdirentry+0x66>

ffffffffc0205a60 <sysfile_dup>:
ffffffffc0205a60:	f6eff06f          	j	ffffffffc02051ce <file_dup>

ffffffffc0205a64 <kernel_thread_entry>:
ffffffffc0205a64:	8526                	mv	a0,s1
ffffffffc0205a66:	9402                	jalr	s0
ffffffffc0205a68:	6b6000ef          	jal	ra,ffffffffc020611e <do_exit>

ffffffffc0205a6c <alloc_proc>:
ffffffffc0205a6c:	1141                	addi	sp,sp,-16
ffffffffc0205a6e:	15000513          	li	a0,336
ffffffffc0205a72:	e022                	sd	s0,0(sp)
ffffffffc0205a74:	e406                	sd	ra,8(sp)
ffffffffc0205a76:	dacfc0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0205a7a:	842a                	mv	s0,a0
ffffffffc0205a7c:	c141                	beqz	a0,ffffffffc0205afc <alloc_proc+0x90>
ffffffffc0205a7e:	57fd                	li	a5,-1
ffffffffc0205a80:	1782                	slli	a5,a5,0x20
ffffffffc0205a82:	e11c                	sd	a5,0(a0)
ffffffffc0205a84:	07000613          	li	a2,112
ffffffffc0205a88:	4581                	li	a1,0
ffffffffc0205a8a:	00052423          	sw	zero,8(a0)
ffffffffc0205a8e:	00053823          	sd	zero,16(a0)
ffffffffc0205a92:	00053c23          	sd	zero,24(a0)
ffffffffc0205a96:	02053023          	sd	zero,32(a0)
ffffffffc0205a9a:	02053423          	sd	zero,40(a0)
ffffffffc0205a9e:	03050513          	addi	a0,a0,48
ffffffffc0205aa2:	677050ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0205aa6:	00091797          	auipc	a5,0x91
ffffffffc0205aaa:	dea7b783          	ld	a5,-534(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205aae:	f45c                	sd	a5,168(s0)
ffffffffc0205ab0:	0a043023          	sd	zero,160(s0)
ffffffffc0205ab4:	0a042823          	sw	zero,176(s0)
ffffffffc0205ab8:	463d                	li	a2,15
ffffffffc0205aba:	4581                	li	a1,0
ffffffffc0205abc:	0b440513          	addi	a0,s0,180
ffffffffc0205ac0:	659050ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0205ac4:	11040793          	addi	a5,s0,272
ffffffffc0205ac8:	0e042623          	sw	zero,236(s0)
ffffffffc0205acc:	0e043c23          	sd	zero,248(s0)
ffffffffc0205ad0:	10043023          	sd	zero,256(s0)
ffffffffc0205ad4:	0e043823          	sd	zero,240(s0)
ffffffffc0205ad8:	10043423          	sd	zero,264(s0)
ffffffffc0205adc:	10f43c23          	sd	a5,280(s0)
ffffffffc0205ae0:	10f43823          	sd	a5,272(s0)
ffffffffc0205ae4:	12042023          	sw	zero,288(s0)
ffffffffc0205ae8:	12043423          	sd	zero,296(s0)
ffffffffc0205aec:	12043823          	sd	zero,304(s0)
ffffffffc0205af0:	12043c23          	sd	zero,312(s0)
ffffffffc0205af4:	14043023          	sd	zero,320(s0)
ffffffffc0205af8:	14043423          	sd	zero,328(s0)
ffffffffc0205afc:	60a2                	ld	ra,8(sp)
ffffffffc0205afe:	8522                	mv	a0,s0
ffffffffc0205b00:	6402                	ld	s0,0(sp)
ffffffffc0205b02:	0141                	addi	sp,sp,16
ffffffffc0205b04:	8082                	ret

ffffffffc0205b06 <page2kva>:
ffffffffc0205b06:	00091797          	auipc	a5,0x91
ffffffffc0205b0a:	da27b783          	ld	a5,-606(a5) # ffffffffc02968a8 <pages>
ffffffffc0205b0e:	8d1d                	sub	a0,a0,a5
ffffffffc0205b10:	8519                	srai	a0,a0,0x6
ffffffffc0205b12:	0000a697          	auipc	a3,0xa
ffffffffc0205b16:	0a66b683          	ld	a3,166(a3) # ffffffffc020fbb8 <nbase>
ffffffffc0205b1a:	9536                	add	a0,a0,a3
ffffffffc0205b1c:	00c51793          	slli	a5,a0,0xc
ffffffffc0205b20:	83b1                	srli	a5,a5,0xc
ffffffffc0205b22:	00091717          	auipc	a4,0x91
ffffffffc0205b26:	d7e73703          	ld	a4,-642(a4) # ffffffffc02968a0 <npage>
ffffffffc0205b2a:	0532                	slli	a0,a0,0xc
ffffffffc0205b2c:	00e7f863          	bgeu	a5,a4,ffffffffc0205b3c <page2kva+0x36>
ffffffffc0205b30:	00091797          	auipc	a5,0x91
ffffffffc0205b34:	d887b783          	ld	a5,-632(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205b38:	953e                	add	a0,a0,a5
ffffffffc0205b3a:	8082                	ret
ffffffffc0205b3c:	1141                	addi	sp,sp,-16
ffffffffc0205b3e:	86aa                	mv	a3,a0
ffffffffc0205b40:	00007617          	auipc	a2,0x7
ffffffffc0205b44:	e1860613          	addi	a2,a2,-488 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc0205b48:	07100593          	li	a1,113
ffffffffc0205b4c:	00007517          	auipc	a0,0x7
ffffffffc0205b50:	e3450513          	addi	a0,a0,-460 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0205b54:	e406                	sd	ra,8(sp)
ffffffffc0205b56:	949fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205b5a <forkret>:
ffffffffc0205b5a:	00091797          	auipc	a5,0x91
ffffffffc0205b5e:	d667b783          	ld	a5,-666(a5) # ffffffffc02968c0 <current>
ffffffffc0205b62:	73c8                	ld	a0,160(a5)
ffffffffc0205b64:	fdafb06f          	j	ffffffffc020133e <forkrets>

ffffffffc0205b68 <put_pgdir.isra.0>:
ffffffffc0205b68:	1141                	addi	sp,sp,-16
ffffffffc0205b6a:	e406                	sd	ra,8(sp)
ffffffffc0205b6c:	c02007b7          	lui	a5,0xc0200
ffffffffc0205b70:	02f56e63          	bltu	a0,a5,ffffffffc0205bac <put_pgdir.isra.0+0x44>
ffffffffc0205b74:	00091697          	auipc	a3,0x91
ffffffffc0205b78:	d446b683          	ld	a3,-700(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205b7c:	8d15                	sub	a0,a0,a3
ffffffffc0205b7e:	8131                	srli	a0,a0,0xc
ffffffffc0205b80:	00091797          	auipc	a5,0x91
ffffffffc0205b84:	d207b783          	ld	a5,-736(a5) # ffffffffc02968a0 <npage>
ffffffffc0205b88:	02f57f63          	bgeu	a0,a5,ffffffffc0205bc6 <put_pgdir.isra.0+0x5e>
ffffffffc0205b8c:	0000a697          	auipc	a3,0xa
ffffffffc0205b90:	02c6b683          	ld	a3,44(a3) # ffffffffc020fbb8 <nbase>
ffffffffc0205b94:	60a2                	ld	ra,8(sp)
ffffffffc0205b96:	8d15                	sub	a0,a0,a3
ffffffffc0205b98:	00091797          	auipc	a5,0x91
ffffffffc0205b9c:	d107b783          	ld	a5,-752(a5) # ffffffffc02968a8 <pages>
ffffffffc0205ba0:	051a                	slli	a0,a0,0x6
ffffffffc0205ba2:	4585                	li	a1,1
ffffffffc0205ba4:	953e                	add	a0,a0,a5
ffffffffc0205ba6:	0141                	addi	sp,sp,16
ffffffffc0205ba8:	e96fc06f          	j	ffffffffc020223e <free_pages>
ffffffffc0205bac:	86aa                	mv	a3,a0
ffffffffc0205bae:	00007617          	auipc	a2,0x7
ffffffffc0205bb2:	e5260613          	addi	a2,a2,-430 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc0205bb6:	07700593          	li	a1,119
ffffffffc0205bba:	00007517          	auipc	a0,0x7
ffffffffc0205bbe:	dc650513          	addi	a0,a0,-570 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0205bc2:	8ddfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205bc6:	00007617          	auipc	a2,0x7
ffffffffc0205bca:	e6260613          	addi	a2,a2,-414 # ffffffffc020ca28 <default_pmm_manager+0x108>
ffffffffc0205bce:	06900593          	li	a1,105
ffffffffc0205bd2:	00007517          	auipc	a0,0x7
ffffffffc0205bd6:	dae50513          	addi	a0,a0,-594 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0205bda:	8c5fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205bde <proc_run>:
ffffffffc0205bde:	7179                	addi	sp,sp,-48
ffffffffc0205be0:	ec4a                	sd	s2,24(sp)
ffffffffc0205be2:	00091917          	auipc	s2,0x91
ffffffffc0205be6:	cde90913          	addi	s2,s2,-802 # ffffffffc02968c0 <current>
ffffffffc0205bea:	f026                	sd	s1,32(sp)
ffffffffc0205bec:	00093483          	ld	s1,0(s2)
ffffffffc0205bf0:	f406                	sd	ra,40(sp)
ffffffffc0205bf2:	e84e                	sd	s3,16(sp)
ffffffffc0205bf4:	02a48a63          	beq	s1,a0,ffffffffc0205c28 <proc_run+0x4a>
ffffffffc0205bf8:	100027f3          	csrr	a5,sstatus
ffffffffc0205bfc:	8b89                	andi	a5,a5,2
ffffffffc0205bfe:	4981                	li	s3,0
ffffffffc0205c00:	e3a9                	bnez	a5,ffffffffc0205c42 <proc_run+0x64>
ffffffffc0205c02:	755c                	ld	a5,168(a0)
ffffffffc0205c04:	577d                	li	a4,-1
ffffffffc0205c06:	177e                	slli	a4,a4,0x3f
ffffffffc0205c08:	83b1                	srli	a5,a5,0xc
ffffffffc0205c0a:	00a93023          	sd	a0,0(s2)
ffffffffc0205c0e:	8fd9                	or	a5,a5,a4
ffffffffc0205c10:	18079073          	csrw	satp,a5
ffffffffc0205c14:	12000073          	sfence.vma
ffffffffc0205c18:	03050593          	addi	a1,a0,48
ffffffffc0205c1c:	03048513          	addi	a0,s1,48
ffffffffc0205c20:	143010ef          	jal	ra,ffffffffc0207562 <switch_to>
ffffffffc0205c24:	00099863          	bnez	s3,ffffffffc0205c34 <proc_run+0x56>
ffffffffc0205c28:	70a2                	ld	ra,40(sp)
ffffffffc0205c2a:	7482                	ld	s1,32(sp)
ffffffffc0205c2c:	6962                	ld	s2,24(sp)
ffffffffc0205c2e:	69c2                	ld	s3,16(sp)
ffffffffc0205c30:	6145                	addi	sp,sp,48
ffffffffc0205c32:	8082                	ret
ffffffffc0205c34:	70a2                	ld	ra,40(sp)
ffffffffc0205c36:	7482                	ld	s1,32(sp)
ffffffffc0205c38:	6962                	ld	s2,24(sp)
ffffffffc0205c3a:	69c2                	ld	s3,16(sp)
ffffffffc0205c3c:	6145                	addi	sp,sp,48
ffffffffc0205c3e:	82efb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205c42:	e42a                	sd	a0,8(sp)
ffffffffc0205c44:	82efb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205c48:	6522                	ld	a0,8(sp)
ffffffffc0205c4a:	4985                	li	s3,1
ffffffffc0205c4c:	bf5d                	j	ffffffffc0205c02 <proc_run+0x24>

ffffffffc0205c4e <do_fork>:
ffffffffc0205c4e:	7119                	addi	sp,sp,-128
ffffffffc0205c50:	f4a6                	sd	s1,104(sp)
ffffffffc0205c52:	00091497          	auipc	s1,0x91
ffffffffc0205c56:	c8648493          	addi	s1,s1,-890 # ffffffffc02968d8 <nr_process>
ffffffffc0205c5a:	4098                	lw	a4,0(s1)
ffffffffc0205c5c:	fc86                	sd	ra,120(sp)
ffffffffc0205c5e:	f8a2                	sd	s0,112(sp)
ffffffffc0205c60:	f0ca                	sd	s2,96(sp)
ffffffffc0205c62:	ecce                	sd	s3,88(sp)
ffffffffc0205c64:	e8d2                	sd	s4,80(sp)
ffffffffc0205c66:	e4d6                	sd	s5,72(sp)
ffffffffc0205c68:	e0da                	sd	s6,64(sp)
ffffffffc0205c6a:	fc5e                	sd	s7,56(sp)
ffffffffc0205c6c:	f862                	sd	s8,48(sp)
ffffffffc0205c6e:	f466                	sd	s9,40(sp)
ffffffffc0205c70:	f06a                	sd	s10,32(sp)
ffffffffc0205c72:	ec6e                	sd	s11,24(sp)
ffffffffc0205c74:	6785                	lui	a5,0x1
ffffffffc0205c76:	e032                	sd	a2,0(sp)
ffffffffc0205c78:	38f75e63          	bge	a4,a5,ffffffffc0206014 <do_fork+0x3c6>
ffffffffc0205c7c:	89aa                	mv	s3,a0
ffffffffc0205c7e:	8a2e                	mv	s4,a1
ffffffffc0205c80:	dedff0ef          	jal	ra,ffffffffc0205a6c <alloc_proc>
ffffffffc0205c84:	842a                	mv	s0,a0
ffffffffc0205c86:	3a050763          	beqz	a0,ffffffffc0206034 <do_fork+0x3e6>
ffffffffc0205c8a:	00091b97          	auipc	s7,0x91
ffffffffc0205c8e:	c36b8b93          	addi	s7,s7,-970 # ffffffffc02968c0 <current>
ffffffffc0205c92:	000bb783          	ld	a5,0(s7)
ffffffffc0205c96:	4509                	li	a0,2
ffffffffc0205c98:	f01c                	sd	a5,32(s0)
ffffffffc0205c9a:	0e07a623          	sw	zero,236(a5) # 10ec <_binary_bin_swap_img_size-0x6c14>
ffffffffc0205c9e:	d62fc0ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0205ca2:	32050263          	beqz	a0,ffffffffc0205fc6 <do_fork+0x378>
ffffffffc0205ca6:	00091d17          	auipc	s10,0x91
ffffffffc0205caa:	c02d0d13          	addi	s10,s10,-1022 # ffffffffc02968a8 <pages>
ffffffffc0205cae:	000d3683          	ld	a3,0(s10)
ffffffffc0205cb2:	00091d97          	auipc	s11,0x91
ffffffffc0205cb6:	beed8d93          	addi	s11,s11,-1042 # ffffffffc02968a0 <npage>
ffffffffc0205cba:	0000ac97          	auipc	s9,0xa
ffffffffc0205cbe:	efecbc83          	ld	s9,-258(s9) # ffffffffc020fbb8 <nbase>
ffffffffc0205cc2:	40d506b3          	sub	a3,a0,a3
ffffffffc0205cc6:	8699                	srai	a3,a3,0x6
ffffffffc0205cc8:	5afd                	li	s5,-1
ffffffffc0205cca:	000db783          	ld	a5,0(s11)
ffffffffc0205cce:	96e6                	add	a3,a3,s9
ffffffffc0205cd0:	00cada93          	srli	s5,s5,0xc
ffffffffc0205cd4:	0156f733          	and	a4,a3,s5
ffffffffc0205cd8:	06b2                	slli	a3,a3,0xc
ffffffffc0205cda:	36f77a63          	bgeu	a4,a5,ffffffffc020604e <do_fork+0x400>
ffffffffc0205cde:	000bbc03          	ld	s8,0(s7)
ffffffffc0205ce2:	00091917          	auipc	s2,0x91
ffffffffc0205ce6:	bd690913          	addi	s2,s2,-1066 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205cea:	00093783          	ld	a5,0(s2)
ffffffffc0205cee:	028c3b03          	ld	s6,40(s8)
ffffffffc0205cf2:	96be                	add	a3,a3,a5
ffffffffc0205cf4:	e814                	sd	a3,16(s0)
ffffffffc0205cf6:	020b0963          	beqz	s6,ffffffffc0205d28 <do_fork+0xda>
ffffffffc0205cfa:	1009f793          	andi	a5,s3,256
ffffffffc0205cfe:	10078863          	beqz	a5,ffffffffc0205e0e <do_fork+0x1c0>
ffffffffc0205d02:	030b2783          	lw	a5,48(s6)
ffffffffc0205d06:	018b3683          	ld	a3,24(s6)
ffffffffc0205d0a:	c0200637          	lui	a2,0xc0200
ffffffffc0205d0e:	2785                	addiw	a5,a5,1
ffffffffc0205d10:	02fb2823          	sw	a5,48(s6)
ffffffffc0205d14:	03643423          	sd	s6,40(s0)
ffffffffc0205d18:	36c6ef63          	bltu	a3,a2,ffffffffc0206096 <do_fork+0x448>
ffffffffc0205d1c:	00093783          	ld	a5,0(s2)
ffffffffc0205d20:	000bbc03          	ld	s8,0(s7)
ffffffffc0205d24:	8e9d                	sub	a3,a3,a5
ffffffffc0205d26:	f454                	sd	a3,168(s0)
ffffffffc0205d28:	148c3a83          	ld	s5,328(s8)
ffffffffc0205d2c:	380a8163          	beqz	s5,ffffffffc02060ae <do_fork+0x460>
ffffffffc0205d30:	00b9d993          	srli	s3,s3,0xb
ffffffffc0205d34:	0019f993          	andi	s3,s3,1
ffffffffc0205d38:	14098c63          	beqz	s3,ffffffffc0205e90 <do_fork+0x242>
ffffffffc0205d3c:	010aa783          	lw	a5,16(s5) # 1010 <_binary_bin_swap_img_size-0x6cf0>
ffffffffc0205d40:	6818                	ld	a4,16(s0)
ffffffffc0205d42:	6602                	ld	a2,0(sp)
ffffffffc0205d44:	2785                	addiw	a5,a5,1
ffffffffc0205d46:	00faa823          	sw	a5,16(s5)
ffffffffc0205d4a:	6789                	lui	a5,0x2
ffffffffc0205d4c:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205d50:	973e                	add	a4,a4,a5
ffffffffc0205d52:	15543423          	sd	s5,328(s0)
ffffffffc0205d56:	f058                	sd	a4,160(s0)
ffffffffc0205d58:	87ba                	mv	a5,a4
ffffffffc0205d5a:	12060893          	addi	a7,a2,288 # ffffffffc0200120 <readline+0x6e>
ffffffffc0205d5e:	00063803          	ld	a6,0(a2)
ffffffffc0205d62:	6608                	ld	a0,8(a2)
ffffffffc0205d64:	6a0c                	ld	a1,16(a2)
ffffffffc0205d66:	6e14                	ld	a3,24(a2)
ffffffffc0205d68:	0107b023          	sd	a6,0(a5)
ffffffffc0205d6c:	e788                	sd	a0,8(a5)
ffffffffc0205d6e:	eb8c                	sd	a1,16(a5)
ffffffffc0205d70:	ef94                	sd	a3,24(a5)
ffffffffc0205d72:	02060613          	addi	a2,a2,32
ffffffffc0205d76:	02078793          	addi	a5,a5,32
ffffffffc0205d7a:	ff1612e3          	bne	a2,a7,ffffffffc0205d5e <do_fork+0x110>
ffffffffc0205d7e:	04073823          	sd	zero,80(a4)
ffffffffc0205d82:	120a0663          	beqz	s4,ffffffffc0205eae <do_fork+0x260>
ffffffffc0205d86:	0008b517          	auipc	a0,0x8b
ffffffffc0205d8a:	2d250513          	addi	a0,a0,722 # ffffffffc0291058 <last_pid.1>
ffffffffc0205d8e:	411c                	lw	a5,0(a0)
ffffffffc0205d90:	01473823          	sd	s4,16(a4)
ffffffffc0205d94:	00000697          	auipc	a3,0x0
ffffffffc0205d98:	dc668693          	addi	a3,a3,-570 # ffffffffc0205b5a <forkret>
ffffffffc0205d9c:	0017881b          	addiw	a6,a5,1
ffffffffc0205da0:	f814                	sd	a3,48(s0)
ffffffffc0205da2:	fc18                	sd	a4,56(s0)
ffffffffc0205da4:	01052023          	sw	a6,0(a0)
ffffffffc0205da8:	6789                	lui	a5,0x2
ffffffffc0205daa:	1ef85e63          	bge	a6,a5,ffffffffc0205fa6 <do_fork+0x358>
ffffffffc0205dae:	0008b317          	auipc	t1,0x8b
ffffffffc0205db2:	2ae30313          	addi	t1,t1,686 # ffffffffc029105c <next_safe.0>
ffffffffc0205db6:	00032783          	lw	a5,0(t1)
ffffffffc0205dba:	00090917          	auipc	s2,0x90
ffffffffc0205dbe:	a0690913          	addi	s2,s2,-1530 # ffffffffc02957c0 <proc_list>
ffffffffc0205dc2:	0ef84f63          	blt	a6,a5,ffffffffc0205ec0 <do_fork+0x272>
ffffffffc0205dc6:	00090917          	auipc	s2,0x90
ffffffffc0205dca:	9fa90913          	addi	s2,s2,-1542 # ffffffffc02957c0 <proc_list>
ffffffffc0205dce:	00893e03          	ld	t3,8(s2)
ffffffffc0205dd2:	6789                	lui	a5,0x2
ffffffffc0205dd4:	00f32023          	sw	a5,0(t1)
ffffffffc0205dd8:	86c2                	mv	a3,a6
ffffffffc0205dda:	4581                	li	a1,0
ffffffffc0205ddc:	6e89                	lui	t4,0x2
ffffffffc0205dde:	252e0d63          	beq	t3,s2,ffffffffc0206038 <do_fork+0x3ea>
ffffffffc0205de2:	88ae                	mv	a7,a1
ffffffffc0205de4:	87f2                	mv	a5,t3
ffffffffc0205de6:	6609                	lui	a2,0x2
ffffffffc0205de8:	a811                	j	ffffffffc0205dfc <do_fork+0x1ae>
ffffffffc0205dea:	00e6d663          	bge	a3,a4,ffffffffc0205df6 <do_fork+0x1a8>
ffffffffc0205dee:	00c75463          	bge	a4,a2,ffffffffc0205df6 <do_fork+0x1a8>
ffffffffc0205df2:	863a                	mv	a2,a4
ffffffffc0205df4:	4885                	li	a7,1
ffffffffc0205df6:	679c                	ld	a5,8(a5)
ffffffffc0205df8:	0b278d63          	beq	a5,s2,ffffffffc0205eb2 <do_fork+0x264>
ffffffffc0205dfc:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205e00:	fed715e3          	bne	a4,a3,ffffffffc0205dea <do_fork+0x19c>
ffffffffc0205e04:	2685                	addiw	a3,a3,1
ffffffffc0205e06:	1ac6db63          	bge	a3,a2,ffffffffc0205fbc <do_fork+0x36e>
ffffffffc0205e0a:	4585                	li	a1,1
ffffffffc0205e0c:	b7ed                	j	ffffffffc0205df6 <do_fork+0x1a8>
ffffffffc0205e0e:	e8ffd0ef          	jal	ra,ffffffffc0203c9c <mm_create>
ffffffffc0205e12:	8c2a                	mv	s8,a0
ffffffffc0205e14:	22050663          	beqz	a0,ffffffffc0206040 <do_fork+0x3f2>
ffffffffc0205e18:	4505                	li	a0,1
ffffffffc0205e1a:	be6fc0ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0205e1e:	14050663          	beqz	a0,ffffffffc0205f6a <do_fork+0x31c>
ffffffffc0205e22:	000d3683          	ld	a3,0(s10)
ffffffffc0205e26:	000db783          	ld	a5,0(s11)
ffffffffc0205e2a:	40d506b3          	sub	a3,a0,a3
ffffffffc0205e2e:	8699                	srai	a3,a3,0x6
ffffffffc0205e30:	96e6                	add	a3,a3,s9
ffffffffc0205e32:	0156fab3          	and	s5,a3,s5
ffffffffc0205e36:	06b2                	slli	a3,a3,0xc
ffffffffc0205e38:	20fafb63          	bgeu	s5,a5,ffffffffc020604e <do_fork+0x400>
ffffffffc0205e3c:	00093a83          	ld	s5,0(s2)
ffffffffc0205e40:	6605                	lui	a2,0x1
ffffffffc0205e42:	00091597          	auipc	a1,0x91
ffffffffc0205e46:	a565b583          	ld	a1,-1450(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205e4a:	9ab6                	add	s5,s5,a3
ffffffffc0205e4c:	8556                	mv	a0,s5
ffffffffc0205e4e:	31d050ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0205e52:	038b0793          	addi	a5,s6,56
ffffffffc0205e56:	853e                	mv	a0,a5
ffffffffc0205e58:	015c3c23          	sd	s5,24(s8)
ffffffffc0205e5c:	e43e                	sd	a5,8(sp)
ffffffffc0205e5e:	f9efe0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0205e62:	000bb683          	ld	a3,0(s7)
ffffffffc0205e66:	67a2                	ld	a5,8(sp)
ffffffffc0205e68:	c681                	beqz	a3,ffffffffc0205e70 <do_fork+0x222>
ffffffffc0205e6a:	42d4                	lw	a3,4(a3)
ffffffffc0205e6c:	04db2823          	sw	a3,80(s6)
ffffffffc0205e70:	85da                	mv	a1,s6
ffffffffc0205e72:	8562                	mv	a0,s8
ffffffffc0205e74:	e43e                	sd	a5,8(sp)
ffffffffc0205e76:	876fe0ef          	jal	ra,ffffffffc0203eec <dup_mmap>
ffffffffc0205e7a:	67a2                	ld	a5,8(sp)
ffffffffc0205e7c:	8aaa                	mv	s5,a0
ffffffffc0205e7e:	853e                	mv	a0,a5
ffffffffc0205e80:	f78fe0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0205e84:	040b2823          	sw	zero,80(s6)
ffffffffc0205e88:	180a9b63          	bnez	s5,ffffffffc020601e <do_fork+0x3d0>
ffffffffc0205e8c:	8b62                	mv	s6,s8
ffffffffc0205e8e:	bd95                	j	ffffffffc0205d02 <do_fork+0xb4>
ffffffffc0205e90:	bd6ff0ef          	jal	ra,ffffffffc0205266 <files_create>
ffffffffc0205e94:	89aa                	mv	s3,a0
ffffffffc0205e96:	1a050a63          	beqz	a0,ffffffffc020604a <do_fork+0x3fc>
ffffffffc0205e9a:	85d6                	mv	a1,s5
ffffffffc0205e9c:	d02ff0ef          	jal	ra,ffffffffc020539e <dup_files>
ffffffffc0205ea0:	8aaa                	mv	s5,a0
ffffffffc0205ea2:	12051863          	bnez	a0,ffffffffc0205fd2 <do_fork+0x384>
ffffffffc0205ea6:	000bbc03          	ld	s8,0(s7)
ffffffffc0205eaa:	8ace                	mv	s5,s3
ffffffffc0205eac:	bd41                	j	ffffffffc0205d3c <do_fork+0xee>
ffffffffc0205eae:	8a3a                	mv	s4,a4
ffffffffc0205eb0:	bdd9                	j	ffffffffc0205d86 <do_fork+0x138>
ffffffffc0205eb2:	c199                	beqz	a1,ffffffffc0205eb8 <do_fork+0x26a>
ffffffffc0205eb4:	c114                	sw	a3,0(a0)
ffffffffc0205eb6:	8836                	mv	a6,a3
ffffffffc0205eb8:	00088463          	beqz	a7,ffffffffc0205ec0 <do_fork+0x272>
ffffffffc0205ebc:	00c32023          	sw	a2,0(t1)
ffffffffc0205ec0:	0b440993          	addi	s3,s0,180
ffffffffc0205ec4:	01042223          	sw	a6,4(s0)
ffffffffc0205ec8:	4641                	li	a2,16
ffffffffc0205eca:	4581                	li	a1,0
ffffffffc0205ecc:	854e                	mv	a0,s3
ffffffffc0205ece:	24b050ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0205ed2:	463d                	li	a2,15
ffffffffc0205ed4:	0b4c0593          	addi	a1,s8,180
ffffffffc0205ed8:	854e                	mv	a0,s3
ffffffffc0205eda:	291050ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0205ede:	100027f3          	csrr	a5,sstatus
ffffffffc0205ee2:	8b89                	andi	a5,a5,2
ffffffffc0205ee4:	4981                	li	s3,0
ffffffffc0205ee6:	e3f5                	bnez	a5,ffffffffc0205fca <do_fork+0x37c>
ffffffffc0205ee8:	4048                	lw	a0,4(s0)
ffffffffc0205eea:	45a9                	li	a1,10
ffffffffc0205eec:	4f8050ef          	jal	ra,ffffffffc020b3e4 <hash32>
ffffffffc0205ef0:	02051793          	slli	a5,a0,0x20
ffffffffc0205ef4:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205ef8:	0008c797          	auipc	a5,0x8c
ffffffffc0205efc:	8c878793          	addi	a5,a5,-1848 # ffffffffc02917c0 <hash_list>
ffffffffc0205f00:	953e                	add	a0,a0,a5
ffffffffc0205f02:	650c                	ld	a1,8(a0)
ffffffffc0205f04:	7014                	ld	a3,32(s0)
ffffffffc0205f06:	0d840793          	addi	a5,s0,216
ffffffffc0205f0a:	e19c                	sd	a5,0(a1)
ffffffffc0205f0c:	00893603          	ld	a2,8(s2)
ffffffffc0205f10:	e51c                	sd	a5,8(a0)
ffffffffc0205f12:	7af8                	ld	a4,240(a3)
ffffffffc0205f14:	0c840793          	addi	a5,s0,200
ffffffffc0205f18:	f06c                	sd	a1,224(s0)
ffffffffc0205f1a:	ec68                	sd	a0,216(s0)
ffffffffc0205f1c:	e21c                	sd	a5,0(a2)
ffffffffc0205f1e:	00f93423          	sd	a5,8(s2)
ffffffffc0205f22:	e870                	sd	a2,208(s0)
ffffffffc0205f24:	0d243423          	sd	s2,200(s0)
ffffffffc0205f28:	0e043c23          	sd	zero,248(s0)
ffffffffc0205f2c:	10e43023          	sd	a4,256(s0)
ffffffffc0205f30:	c311                	beqz	a4,ffffffffc0205f34 <do_fork+0x2e6>
ffffffffc0205f32:	ff60                	sd	s0,248(a4)
ffffffffc0205f34:	409c                	lw	a5,0(s1)
ffffffffc0205f36:	fae0                	sd	s0,240(a3)
ffffffffc0205f38:	2785                	addiw	a5,a5,1
ffffffffc0205f3a:	c09c                	sw	a5,0(s1)
ffffffffc0205f3c:	06099d63          	bnez	s3,ffffffffc0205fb6 <do_fork+0x368>
ffffffffc0205f40:	8522                	mv	a0,s0
ffffffffc0205f42:	7c4010ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc0205f46:	00442a83          	lw	s5,4(s0)
ffffffffc0205f4a:	70e6                	ld	ra,120(sp)
ffffffffc0205f4c:	7446                	ld	s0,112(sp)
ffffffffc0205f4e:	74a6                	ld	s1,104(sp)
ffffffffc0205f50:	7906                	ld	s2,96(sp)
ffffffffc0205f52:	69e6                	ld	s3,88(sp)
ffffffffc0205f54:	6a46                	ld	s4,80(sp)
ffffffffc0205f56:	6b06                	ld	s6,64(sp)
ffffffffc0205f58:	7be2                	ld	s7,56(sp)
ffffffffc0205f5a:	7c42                	ld	s8,48(sp)
ffffffffc0205f5c:	7ca2                	ld	s9,40(sp)
ffffffffc0205f5e:	7d02                	ld	s10,32(sp)
ffffffffc0205f60:	6de2                	ld	s11,24(sp)
ffffffffc0205f62:	8556                	mv	a0,s5
ffffffffc0205f64:	6aa6                	ld	s5,72(sp)
ffffffffc0205f66:	6109                	addi	sp,sp,128
ffffffffc0205f68:	8082                	ret
ffffffffc0205f6a:	8562                	mv	a0,s8
ffffffffc0205f6c:	e7ffd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0205f70:	5af1                	li	s5,-4
ffffffffc0205f72:	6814                	ld	a3,16(s0)
ffffffffc0205f74:	c02007b7          	lui	a5,0xc0200
ffffffffc0205f78:	0ef6e763          	bltu	a3,a5,ffffffffc0206066 <do_fork+0x418>
ffffffffc0205f7c:	00093703          	ld	a4,0(s2)
ffffffffc0205f80:	000db783          	ld	a5,0(s11)
ffffffffc0205f84:	8e99                	sub	a3,a3,a4
ffffffffc0205f86:	82b1                	srli	a3,a3,0xc
ffffffffc0205f88:	0ef6fb63          	bgeu	a3,a5,ffffffffc020607e <do_fork+0x430>
ffffffffc0205f8c:	000d3503          	ld	a0,0(s10)
ffffffffc0205f90:	419686b3          	sub	a3,a3,s9
ffffffffc0205f94:	069a                	slli	a3,a3,0x6
ffffffffc0205f96:	4589                	li	a1,2
ffffffffc0205f98:	9536                	add	a0,a0,a3
ffffffffc0205f9a:	aa4fc0ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc0205f9e:	8522                	mv	a0,s0
ffffffffc0205fa0:	932fc0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0205fa4:	b75d                	j	ffffffffc0205f4a <do_fork+0x2fc>
ffffffffc0205fa6:	4785                	li	a5,1
ffffffffc0205fa8:	c11c                	sw	a5,0(a0)
ffffffffc0205faa:	4805                	li	a6,1
ffffffffc0205fac:	0008b317          	auipc	t1,0x8b
ffffffffc0205fb0:	0b030313          	addi	t1,t1,176 # ffffffffc029105c <next_safe.0>
ffffffffc0205fb4:	bd09                	j	ffffffffc0205dc6 <do_fork+0x178>
ffffffffc0205fb6:	cb7fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0205fba:	b759                	j	ffffffffc0205f40 <do_fork+0x2f2>
ffffffffc0205fbc:	01d6c363          	blt	a3,t4,ffffffffc0205fc2 <do_fork+0x374>
ffffffffc0205fc0:	4685                	li	a3,1
ffffffffc0205fc2:	4585                	li	a1,1
ffffffffc0205fc4:	bd29                	j	ffffffffc0205dde <do_fork+0x190>
ffffffffc0205fc6:	5af1                	li	s5,-4
ffffffffc0205fc8:	bfd9                	j	ffffffffc0205f9e <do_fork+0x350>
ffffffffc0205fca:	ca9fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205fce:	4985                	li	s3,1
ffffffffc0205fd0:	bf21                	j	ffffffffc0205ee8 <do_fork+0x29a>
ffffffffc0205fd2:	854e                	mv	a0,s3
ffffffffc0205fd4:	ac8ff0ef          	jal	ra,ffffffffc020529c <files_destroy>
ffffffffc0205fd8:	14843503          	ld	a0,328(s0)
ffffffffc0205fdc:	c511                	beqz	a0,ffffffffc0205fe8 <do_fork+0x39a>
ffffffffc0205fde:	491c                	lw	a5,16(a0)
ffffffffc0205fe0:	fff7869b          	addiw	a3,a5,-1
ffffffffc0205fe4:	c914                	sw	a3,16(a0)
ffffffffc0205fe6:	ca8d                	beqz	a3,ffffffffc0206018 <do_fork+0x3ca>
ffffffffc0205fe8:	7408                	ld	a0,40(s0)
ffffffffc0205fea:	d541                	beqz	a0,ffffffffc0205f72 <do_fork+0x324>
ffffffffc0205fec:	591c                	lw	a5,48(a0)
ffffffffc0205fee:	fff7869b          	addiw	a3,a5,-1
ffffffffc0205ff2:	d914                	sw	a3,48(a0)
ffffffffc0205ff4:	c681                	beqz	a3,ffffffffc0205ffc <do_fork+0x3ae>
ffffffffc0205ff6:	02043423          	sd	zero,40(s0)
ffffffffc0205ffa:	bfa5                	j	ffffffffc0205f72 <do_fork+0x324>
ffffffffc0205ffc:	f8bfd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc0206000:	741c                	ld	a5,40(s0)
ffffffffc0206002:	6f88                	ld	a0,24(a5)
ffffffffc0206004:	b65ff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc0206008:	7408                	ld	a0,40(s0)
ffffffffc020600a:	de1fd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc020600e:	02043423          	sd	zero,40(s0)
ffffffffc0206012:	b785                	j	ffffffffc0205f72 <do_fork+0x324>
ffffffffc0206014:	5aed                	li	s5,-5
ffffffffc0206016:	bf15                	j	ffffffffc0205f4a <do_fork+0x2fc>
ffffffffc0206018:	a84ff0ef          	jal	ra,ffffffffc020529c <files_destroy>
ffffffffc020601c:	b7f1                	j	ffffffffc0205fe8 <do_fork+0x39a>
ffffffffc020601e:	8562                	mv	a0,s8
ffffffffc0206020:	f67fd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc0206024:	018c3503          	ld	a0,24(s8)
ffffffffc0206028:	b41ff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc020602c:	8562                	mv	a0,s8
ffffffffc020602e:	dbdfd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206032:	b781                	j	ffffffffc0205f72 <do_fork+0x324>
ffffffffc0206034:	5af1                	li	s5,-4
ffffffffc0206036:	bf11                	j	ffffffffc0205f4a <do_fork+0x2fc>
ffffffffc0206038:	c591                	beqz	a1,ffffffffc0206044 <do_fork+0x3f6>
ffffffffc020603a:	c114                	sw	a3,0(a0)
ffffffffc020603c:	8836                	mv	a6,a3
ffffffffc020603e:	b549                	j	ffffffffc0205ec0 <do_fork+0x272>
ffffffffc0206040:	5af1                	li	s5,-4
ffffffffc0206042:	bf05                	j	ffffffffc0205f72 <do_fork+0x324>
ffffffffc0206044:	00052803          	lw	a6,0(a0)
ffffffffc0206048:	bda5                	j	ffffffffc0205ec0 <do_fork+0x272>
ffffffffc020604a:	5af1                	li	s5,-4
ffffffffc020604c:	b771                	j	ffffffffc0205fd8 <do_fork+0x38a>
ffffffffc020604e:	00007617          	auipc	a2,0x7
ffffffffc0206052:	90a60613          	addi	a2,a2,-1782 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc0206056:	07100593          	li	a1,113
ffffffffc020605a:	00007517          	auipc	a0,0x7
ffffffffc020605e:	92650513          	addi	a0,a0,-1754 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0206062:	c3cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206066:	00007617          	auipc	a2,0x7
ffffffffc020606a:	99a60613          	addi	a2,a2,-1638 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc020606e:	07700593          	li	a1,119
ffffffffc0206072:	00007517          	auipc	a0,0x7
ffffffffc0206076:	90e50513          	addi	a0,a0,-1778 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc020607a:	c24fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020607e:	00007617          	auipc	a2,0x7
ffffffffc0206082:	9aa60613          	addi	a2,a2,-1622 # ffffffffc020ca28 <default_pmm_manager+0x108>
ffffffffc0206086:	06900593          	li	a1,105
ffffffffc020608a:	00007517          	auipc	a0,0x7
ffffffffc020608e:	8f650513          	addi	a0,a0,-1802 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc0206092:	c0cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206096:	00007617          	auipc	a2,0x7
ffffffffc020609a:	96a60613          	addi	a2,a2,-1686 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc020609e:	1b000593          	li	a1,432
ffffffffc02060a2:	00008517          	auipc	a0,0x8
ffffffffc02060a6:	89650513          	addi	a0,a0,-1898 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc02060aa:	bf4fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02060ae:	00008697          	auipc	a3,0x8
ffffffffc02060b2:	8a268693          	addi	a3,a3,-1886 # ffffffffc020d950 <CSWTCH.79+0x108>
ffffffffc02060b6:	00006617          	auipc	a2,0x6
ffffffffc02060ba:	d4a60613          	addi	a2,a2,-694 # ffffffffc020be00 <commands+0x210>
ffffffffc02060be:	1d000593          	li	a1,464
ffffffffc02060c2:	00008517          	auipc	a0,0x8
ffffffffc02060c6:	87650513          	addi	a0,a0,-1930 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc02060ca:	bd4fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02060ce <kernel_thread>:
ffffffffc02060ce:	7129                	addi	sp,sp,-320
ffffffffc02060d0:	fa22                	sd	s0,304(sp)
ffffffffc02060d2:	f626                	sd	s1,296(sp)
ffffffffc02060d4:	f24a                	sd	s2,288(sp)
ffffffffc02060d6:	84ae                	mv	s1,a1
ffffffffc02060d8:	892a                	mv	s2,a0
ffffffffc02060da:	8432                	mv	s0,a2
ffffffffc02060dc:	4581                	li	a1,0
ffffffffc02060de:	12000613          	li	a2,288
ffffffffc02060e2:	850a                	mv	a0,sp
ffffffffc02060e4:	fe06                	sd	ra,312(sp)
ffffffffc02060e6:	033050ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc02060ea:	e0ca                	sd	s2,64(sp)
ffffffffc02060ec:	e4a6                	sd	s1,72(sp)
ffffffffc02060ee:	100027f3          	csrr	a5,sstatus
ffffffffc02060f2:	edd7f793          	andi	a5,a5,-291
ffffffffc02060f6:	1207e793          	ori	a5,a5,288
ffffffffc02060fa:	e23e                	sd	a5,256(sp)
ffffffffc02060fc:	860a                	mv	a2,sp
ffffffffc02060fe:	10046513          	ori	a0,s0,256
ffffffffc0206102:	00000797          	auipc	a5,0x0
ffffffffc0206106:	96278793          	addi	a5,a5,-1694 # ffffffffc0205a64 <kernel_thread_entry>
ffffffffc020610a:	4581                	li	a1,0
ffffffffc020610c:	e63e                	sd	a5,264(sp)
ffffffffc020610e:	b41ff0ef          	jal	ra,ffffffffc0205c4e <do_fork>
ffffffffc0206112:	70f2                	ld	ra,312(sp)
ffffffffc0206114:	7452                	ld	s0,304(sp)
ffffffffc0206116:	74b2                	ld	s1,296(sp)
ffffffffc0206118:	7912                	ld	s2,288(sp)
ffffffffc020611a:	6131                	addi	sp,sp,320
ffffffffc020611c:	8082                	ret

ffffffffc020611e <do_exit>:
ffffffffc020611e:	7179                	addi	sp,sp,-48
ffffffffc0206120:	f022                	sd	s0,32(sp)
ffffffffc0206122:	00090417          	auipc	s0,0x90
ffffffffc0206126:	79e40413          	addi	s0,s0,1950 # ffffffffc02968c0 <current>
ffffffffc020612a:	601c                	ld	a5,0(s0)
ffffffffc020612c:	f406                	sd	ra,40(sp)
ffffffffc020612e:	ec26                	sd	s1,24(sp)
ffffffffc0206130:	e84a                	sd	s2,16(sp)
ffffffffc0206132:	e44e                	sd	s3,8(sp)
ffffffffc0206134:	e052                	sd	s4,0(sp)
ffffffffc0206136:	00090717          	auipc	a4,0x90
ffffffffc020613a:	79273703          	ld	a4,1938(a4) # ffffffffc02968c8 <idleproc>
ffffffffc020613e:	0ee78763          	beq	a5,a4,ffffffffc020622c <do_exit+0x10e>
ffffffffc0206142:	00090497          	auipc	s1,0x90
ffffffffc0206146:	78e48493          	addi	s1,s1,1934 # ffffffffc02968d0 <initproc>
ffffffffc020614a:	6098                	ld	a4,0(s1)
ffffffffc020614c:	10e78763          	beq	a5,a4,ffffffffc020625a <do_exit+0x13c>
ffffffffc0206150:	0287b983          	ld	s3,40(a5)
ffffffffc0206154:	892a                	mv	s2,a0
ffffffffc0206156:	02098e63          	beqz	s3,ffffffffc0206192 <do_exit+0x74>
ffffffffc020615a:	00090797          	auipc	a5,0x90
ffffffffc020615e:	7367b783          	ld	a5,1846(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206162:	577d                	li	a4,-1
ffffffffc0206164:	177e                	slli	a4,a4,0x3f
ffffffffc0206166:	83b1                	srli	a5,a5,0xc
ffffffffc0206168:	8fd9                	or	a5,a5,a4
ffffffffc020616a:	18079073          	csrw	satp,a5
ffffffffc020616e:	0309a783          	lw	a5,48(s3)
ffffffffc0206172:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206176:	02e9a823          	sw	a4,48(s3)
ffffffffc020617a:	c769                	beqz	a4,ffffffffc0206244 <do_exit+0x126>
ffffffffc020617c:	601c                	ld	a5,0(s0)
ffffffffc020617e:	1487b503          	ld	a0,328(a5)
ffffffffc0206182:	0207b423          	sd	zero,40(a5)
ffffffffc0206186:	c511                	beqz	a0,ffffffffc0206192 <do_exit+0x74>
ffffffffc0206188:	491c                	lw	a5,16(a0)
ffffffffc020618a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020618e:	c918                	sw	a4,16(a0)
ffffffffc0206190:	cb59                	beqz	a4,ffffffffc0206226 <do_exit+0x108>
ffffffffc0206192:	601c                	ld	a5,0(s0)
ffffffffc0206194:	470d                	li	a4,3
ffffffffc0206196:	c398                	sw	a4,0(a5)
ffffffffc0206198:	0f27a423          	sw	s2,232(a5)
ffffffffc020619c:	100027f3          	csrr	a5,sstatus
ffffffffc02061a0:	8b89                	andi	a5,a5,2
ffffffffc02061a2:	4a01                	li	s4,0
ffffffffc02061a4:	e7f9                	bnez	a5,ffffffffc0206272 <do_exit+0x154>
ffffffffc02061a6:	6018                	ld	a4,0(s0)
ffffffffc02061a8:	800007b7          	lui	a5,0x80000
ffffffffc02061ac:	0785                	addi	a5,a5,1
ffffffffc02061ae:	7308                	ld	a0,32(a4)
ffffffffc02061b0:	0ec52703          	lw	a4,236(a0)
ffffffffc02061b4:	0cf70363          	beq	a4,a5,ffffffffc020627a <do_exit+0x15c>
ffffffffc02061b8:	6018                	ld	a4,0(s0)
ffffffffc02061ba:	7b7c                	ld	a5,240(a4)
ffffffffc02061bc:	c3a1                	beqz	a5,ffffffffc02061fc <do_exit+0xde>
ffffffffc02061be:	800009b7          	lui	s3,0x80000
ffffffffc02061c2:	490d                	li	s2,3
ffffffffc02061c4:	0985                	addi	s3,s3,1
ffffffffc02061c6:	a021                	j	ffffffffc02061ce <do_exit+0xb0>
ffffffffc02061c8:	6018                	ld	a4,0(s0)
ffffffffc02061ca:	7b7c                	ld	a5,240(a4)
ffffffffc02061cc:	cb85                	beqz	a5,ffffffffc02061fc <do_exit+0xde>
ffffffffc02061ce:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc02061d2:	6088                	ld	a0,0(s1)
ffffffffc02061d4:	fb74                	sd	a3,240(a4)
ffffffffc02061d6:	7978                	ld	a4,240(a0)
ffffffffc02061d8:	0e07bc23          	sd	zero,248(a5)
ffffffffc02061dc:	10e7b023          	sd	a4,256(a5)
ffffffffc02061e0:	c311                	beqz	a4,ffffffffc02061e4 <do_exit+0xc6>
ffffffffc02061e2:	ff7c                	sd	a5,248(a4)
ffffffffc02061e4:	4398                	lw	a4,0(a5)
ffffffffc02061e6:	f388                	sd	a0,32(a5)
ffffffffc02061e8:	f97c                	sd	a5,240(a0)
ffffffffc02061ea:	fd271fe3          	bne	a4,s2,ffffffffc02061c8 <do_exit+0xaa>
ffffffffc02061ee:	0ec52783          	lw	a5,236(a0)
ffffffffc02061f2:	fd379be3          	bne	a5,s3,ffffffffc02061c8 <do_exit+0xaa>
ffffffffc02061f6:	510010ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc02061fa:	b7f9                	j	ffffffffc02061c8 <do_exit+0xaa>
ffffffffc02061fc:	020a1263          	bnez	s4,ffffffffc0206220 <do_exit+0x102>
ffffffffc0206200:	5b8010ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc0206204:	601c                	ld	a5,0(s0)
ffffffffc0206206:	00007617          	auipc	a2,0x7
ffffffffc020620a:	78260613          	addi	a2,a2,1922 # ffffffffc020d988 <CSWTCH.79+0x140>
ffffffffc020620e:	28400593          	li	a1,644
ffffffffc0206212:	43d4                	lw	a3,4(a5)
ffffffffc0206214:	00007517          	auipc	a0,0x7
ffffffffc0206218:	72450513          	addi	a0,a0,1828 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020621c:	a82fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206220:	a4dfa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206224:	bff1                	j	ffffffffc0206200 <do_exit+0xe2>
ffffffffc0206226:	876ff0ef          	jal	ra,ffffffffc020529c <files_destroy>
ffffffffc020622a:	b7a5                	j	ffffffffc0206192 <do_exit+0x74>
ffffffffc020622c:	00007617          	auipc	a2,0x7
ffffffffc0206230:	73c60613          	addi	a2,a2,1852 # ffffffffc020d968 <CSWTCH.79+0x120>
ffffffffc0206234:	24f00593          	li	a1,591
ffffffffc0206238:	00007517          	auipc	a0,0x7
ffffffffc020623c:	70050513          	addi	a0,a0,1792 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc0206240:	a5efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206244:	854e                	mv	a0,s3
ffffffffc0206246:	d41fd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc020624a:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc020624e:	91bff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc0206252:	854e                	mv	a0,s3
ffffffffc0206254:	b97fd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206258:	b715                	j	ffffffffc020617c <do_exit+0x5e>
ffffffffc020625a:	00007617          	auipc	a2,0x7
ffffffffc020625e:	71e60613          	addi	a2,a2,1822 # ffffffffc020d978 <CSWTCH.79+0x130>
ffffffffc0206262:	25300593          	li	a1,595
ffffffffc0206266:	00007517          	auipc	a0,0x7
ffffffffc020626a:	6d250513          	addi	a0,a0,1746 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020626e:	a30fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206272:	a01fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206276:	4a05                	li	s4,1
ffffffffc0206278:	b73d                	j	ffffffffc02061a6 <do_exit+0x88>
ffffffffc020627a:	48c010ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc020627e:	bf2d                	j	ffffffffc02061b8 <do_exit+0x9a>

ffffffffc0206280 <do_wait.part.0>:
ffffffffc0206280:	715d                	addi	sp,sp,-80
ffffffffc0206282:	f84a                	sd	s2,48(sp)
ffffffffc0206284:	f44e                	sd	s3,40(sp)
ffffffffc0206286:	80000937          	lui	s2,0x80000
ffffffffc020628a:	6989                	lui	s3,0x2
ffffffffc020628c:	fc26                	sd	s1,56(sp)
ffffffffc020628e:	f052                	sd	s4,32(sp)
ffffffffc0206290:	ec56                	sd	s5,24(sp)
ffffffffc0206292:	e85a                	sd	s6,16(sp)
ffffffffc0206294:	e45e                	sd	s7,8(sp)
ffffffffc0206296:	e486                	sd	ra,72(sp)
ffffffffc0206298:	e0a2                	sd	s0,64(sp)
ffffffffc020629a:	84aa                	mv	s1,a0
ffffffffc020629c:	8a2e                	mv	s4,a1
ffffffffc020629e:	00090b97          	auipc	s7,0x90
ffffffffc02062a2:	622b8b93          	addi	s7,s7,1570 # ffffffffc02968c0 <current>
ffffffffc02062a6:	00050b1b          	sext.w	s6,a0
ffffffffc02062aa:	fff50a9b          	addiw	s5,a0,-1
ffffffffc02062ae:	19f9                	addi	s3,s3,-2
ffffffffc02062b0:	0905                	addi	s2,s2,1
ffffffffc02062b2:	ccbd                	beqz	s1,ffffffffc0206330 <do_wait.part.0+0xb0>
ffffffffc02062b4:	0359e863          	bltu	s3,s5,ffffffffc02062e4 <do_wait.part.0+0x64>
ffffffffc02062b8:	45a9                	li	a1,10
ffffffffc02062ba:	855a                	mv	a0,s6
ffffffffc02062bc:	128050ef          	jal	ra,ffffffffc020b3e4 <hash32>
ffffffffc02062c0:	02051793          	slli	a5,a0,0x20
ffffffffc02062c4:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02062c8:	0008b797          	auipc	a5,0x8b
ffffffffc02062cc:	4f878793          	addi	a5,a5,1272 # ffffffffc02917c0 <hash_list>
ffffffffc02062d0:	953e                	add	a0,a0,a5
ffffffffc02062d2:	842a                	mv	s0,a0
ffffffffc02062d4:	a029                	j	ffffffffc02062de <do_wait.part.0+0x5e>
ffffffffc02062d6:	f2c42783          	lw	a5,-212(s0)
ffffffffc02062da:	02978163          	beq	a5,s1,ffffffffc02062fc <do_wait.part.0+0x7c>
ffffffffc02062de:	6400                	ld	s0,8(s0)
ffffffffc02062e0:	fe851be3          	bne	a0,s0,ffffffffc02062d6 <do_wait.part.0+0x56>
ffffffffc02062e4:	5579                	li	a0,-2
ffffffffc02062e6:	60a6                	ld	ra,72(sp)
ffffffffc02062e8:	6406                	ld	s0,64(sp)
ffffffffc02062ea:	74e2                	ld	s1,56(sp)
ffffffffc02062ec:	7942                	ld	s2,48(sp)
ffffffffc02062ee:	79a2                	ld	s3,40(sp)
ffffffffc02062f0:	7a02                	ld	s4,32(sp)
ffffffffc02062f2:	6ae2                	ld	s5,24(sp)
ffffffffc02062f4:	6b42                	ld	s6,16(sp)
ffffffffc02062f6:	6ba2                	ld	s7,8(sp)
ffffffffc02062f8:	6161                	addi	sp,sp,80
ffffffffc02062fa:	8082                	ret
ffffffffc02062fc:	000bb683          	ld	a3,0(s7)
ffffffffc0206300:	f4843783          	ld	a5,-184(s0)
ffffffffc0206304:	fed790e3          	bne	a5,a3,ffffffffc02062e4 <do_wait.part.0+0x64>
ffffffffc0206308:	f2842703          	lw	a4,-216(s0)
ffffffffc020630c:	478d                	li	a5,3
ffffffffc020630e:	0ef70b63          	beq	a4,a5,ffffffffc0206404 <do_wait.part.0+0x184>
ffffffffc0206312:	4785                	li	a5,1
ffffffffc0206314:	c29c                	sw	a5,0(a3)
ffffffffc0206316:	0f26a623          	sw	s2,236(a3)
ffffffffc020631a:	49e010ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc020631e:	000bb783          	ld	a5,0(s7)
ffffffffc0206322:	0b07a783          	lw	a5,176(a5)
ffffffffc0206326:	8b85                	andi	a5,a5,1
ffffffffc0206328:	d7c9                	beqz	a5,ffffffffc02062b2 <do_wait.part.0+0x32>
ffffffffc020632a:	555d                	li	a0,-9
ffffffffc020632c:	df3ff0ef          	jal	ra,ffffffffc020611e <do_exit>
ffffffffc0206330:	000bb683          	ld	a3,0(s7)
ffffffffc0206334:	7ae0                	ld	s0,240(a3)
ffffffffc0206336:	d45d                	beqz	s0,ffffffffc02062e4 <do_wait.part.0+0x64>
ffffffffc0206338:	470d                	li	a4,3
ffffffffc020633a:	a021                	j	ffffffffc0206342 <do_wait.part.0+0xc2>
ffffffffc020633c:	10043403          	ld	s0,256(s0)
ffffffffc0206340:	d869                	beqz	s0,ffffffffc0206312 <do_wait.part.0+0x92>
ffffffffc0206342:	401c                	lw	a5,0(s0)
ffffffffc0206344:	fee79ce3          	bne	a5,a4,ffffffffc020633c <do_wait.part.0+0xbc>
ffffffffc0206348:	00090797          	auipc	a5,0x90
ffffffffc020634c:	5807b783          	ld	a5,1408(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0206350:	0c878963          	beq	a5,s0,ffffffffc0206422 <do_wait.part.0+0x1a2>
ffffffffc0206354:	00090797          	auipc	a5,0x90
ffffffffc0206358:	57c7b783          	ld	a5,1404(a5) # ffffffffc02968d0 <initproc>
ffffffffc020635c:	0cf40363          	beq	s0,a5,ffffffffc0206422 <do_wait.part.0+0x1a2>
ffffffffc0206360:	000a0663          	beqz	s4,ffffffffc020636c <do_wait.part.0+0xec>
ffffffffc0206364:	0e842783          	lw	a5,232(s0)
ffffffffc0206368:	00fa2023          	sw	a5,0(s4)
ffffffffc020636c:	100027f3          	csrr	a5,sstatus
ffffffffc0206370:	8b89                	andi	a5,a5,2
ffffffffc0206372:	4581                	li	a1,0
ffffffffc0206374:	e7c1                	bnez	a5,ffffffffc02063fc <do_wait.part.0+0x17c>
ffffffffc0206376:	6c70                	ld	a2,216(s0)
ffffffffc0206378:	7074                	ld	a3,224(s0)
ffffffffc020637a:	10043703          	ld	a4,256(s0)
ffffffffc020637e:	7c7c                	ld	a5,248(s0)
ffffffffc0206380:	e614                	sd	a3,8(a2)
ffffffffc0206382:	e290                	sd	a2,0(a3)
ffffffffc0206384:	6470                	ld	a2,200(s0)
ffffffffc0206386:	6874                	ld	a3,208(s0)
ffffffffc0206388:	e614                	sd	a3,8(a2)
ffffffffc020638a:	e290                	sd	a2,0(a3)
ffffffffc020638c:	c319                	beqz	a4,ffffffffc0206392 <do_wait.part.0+0x112>
ffffffffc020638e:	ff7c                	sd	a5,248(a4)
ffffffffc0206390:	7c7c                	ld	a5,248(s0)
ffffffffc0206392:	c3b5                	beqz	a5,ffffffffc02063f6 <do_wait.part.0+0x176>
ffffffffc0206394:	10e7b023          	sd	a4,256(a5)
ffffffffc0206398:	00090717          	auipc	a4,0x90
ffffffffc020639c:	54070713          	addi	a4,a4,1344 # ffffffffc02968d8 <nr_process>
ffffffffc02063a0:	431c                	lw	a5,0(a4)
ffffffffc02063a2:	37fd                	addiw	a5,a5,-1
ffffffffc02063a4:	c31c                	sw	a5,0(a4)
ffffffffc02063a6:	e5a9                	bnez	a1,ffffffffc02063f0 <do_wait.part.0+0x170>
ffffffffc02063a8:	6814                	ld	a3,16(s0)
ffffffffc02063aa:	c02007b7          	lui	a5,0xc0200
ffffffffc02063ae:	04f6ee63          	bltu	a3,a5,ffffffffc020640a <do_wait.part.0+0x18a>
ffffffffc02063b2:	00090797          	auipc	a5,0x90
ffffffffc02063b6:	5067b783          	ld	a5,1286(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02063ba:	8e9d                	sub	a3,a3,a5
ffffffffc02063bc:	82b1                	srli	a3,a3,0xc
ffffffffc02063be:	00090797          	auipc	a5,0x90
ffffffffc02063c2:	4e27b783          	ld	a5,1250(a5) # ffffffffc02968a0 <npage>
ffffffffc02063c6:	06f6fa63          	bgeu	a3,a5,ffffffffc020643a <do_wait.part.0+0x1ba>
ffffffffc02063ca:	00009517          	auipc	a0,0x9
ffffffffc02063ce:	7ee53503          	ld	a0,2030(a0) # ffffffffc020fbb8 <nbase>
ffffffffc02063d2:	8e89                	sub	a3,a3,a0
ffffffffc02063d4:	069a                	slli	a3,a3,0x6
ffffffffc02063d6:	00090517          	auipc	a0,0x90
ffffffffc02063da:	4d253503          	ld	a0,1234(a0) # ffffffffc02968a8 <pages>
ffffffffc02063de:	9536                	add	a0,a0,a3
ffffffffc02063e0:	4589                	li	a1,2
ffffffffc02063e2:	e5dfb0ef          	jal	ra,ffffffffc020223e <free_pages>
ffffffffc02063e6:	8522                	mv	a0,s0
ffffffffc02063e8:	cebfb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02063ec:	4501                	li	a0,0
ffffffffc02063ee:	bde5                	j	ffffffffc02062e6 <do_wait.part.0+0x66>
ffffffffc02063f0:	87dfa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02063f4:	bf55                	j	ffffffffc02063a8 <do_wait.part.0+0x128>
ffffffffc02063f6:	701c                	ld	a5,32(s0)
ffffffffc02063f8:	fbf8                	sd	a4,240(a5)
ffffffffc02063fa:	bf79                	j	ffffffffc0206398 <do_wait.part.0+0x118>
ffffffffc02063fc:	877fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206400:	4585                	li	a1,1
ffffffffc0206402:	bf95                	j	ffffffffc0206376 <do_wait.part.0+0xf6>
ffffffffc0206404:	f2840413          	addi	s0,s0,-216
ffffffffc0206408:	b781                	j	ffffffffc0206348 <do_wait.part.0+0xc8>
ffffffffc020640a:	00006617          	auipc	a2,0x6
ffffffffc020640e:	5f660613          	addi	a2,a2,1526 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc0206412:	07700593          	li	a1,119
ffffffffc0206416:	00006517          	auipc	a0,0x6
ffffffffc020641a:	56a50513          	addi	a0,a0,1386 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc020641e:	880fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206422:	00007617          	auipc	a2,0x7
ffffffffc0206426:	58660613          	addi	a2,a2,1414 # ffffffffc020d9a8 <CSWTCH.79+0x160>
ffffffffc020642a:	4a800593          	li	a1,1192
ffffffffc020642e:	00007517          	auipc	a0,0x7
ffffffffc0206432:	50a50513          	addi	a0,a0,1290 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc0206436:	868fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020643a:	00006617          	auipc	a2,0x6
ffffffffc020643e:	5ee60613          	addi	a2,a2,1518 # ffffffffc020ca28 <default_pmm_manager+0x108>
ffffffffc0206442:	06900593          	li	a1,105
ffffffffc0206446:	00006517          	auipc	a0,0x6
ffffffffc020644a:	53a50513          	addi	a0,a0,1338 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc020644e:	850fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206452 <init_main>:
ffffffffc0206452:	1141                	addi	sp,sp,-16
ffffffffc0206454:	00007517          	auipc	a0,0x7
ffffffffc0206458:	57450513          	addi	a0,a0,1396 # ffffffffc020d9c8 <CSWTCH.79+0x180>
ffffffffc020645c:	e406                	sd	ra,8(sp)
ffffffffc020645e:	2cb010ef          	jal	ra,ffffffffc0207f28 <vfs_set_bootfs>
ffffffffc0206462:	e179                	bnez	a0,ffffffffc0206528 <init_main+0xd6>
ffffffffc0206464:	e1bfb0ef          	jal	ra,ffffffffc020227e <nr_free_pages>
ffffffffc0206468:	bb7fb0ef          	jal	ra,ffffffffc020201e <kallocated>
ffffffffc020646c:	4601                	li	a2,0
ffffffffc020646e:	4581                	li	a1,0
ffffffffc0206470:	00001517          	auipc	a0,0x1
ffffffffc0206474:	cf050513          	addi	a0,a0,-784 # ffffffffc0207160 <user_main>
ffffffffc0206478:	c57ff0ef          	jal	ra,ffffffffc02060ce <kernel_thread>
ffffffffc020647c:	00a04563          	bgtz	a0,ffffffffc0206486 <init_main+0x34>
ffffffffc0206480:	a841                	j	ffffffffc0206510 <init_main+0xbe>
ffffffffc0206482:	336010ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc0206486:	4581                	li	a1,0
ffffffffc0206488:	4501                	li	a0,0
ffffffffc020648a:	df7ff0ef          	jal	ra,ffffffffc0206280 <do_wait.part.0>
ffffffffc020648e:	d975                	beqz	a0,ffffffffc0206482 <init_main+0x30>
ffffffffc0206490:	dc7fe0ef          	jal	ra,ffffffffc0205256 <fs_cleanup>
ffffffffc0206494:	00007517          	auipc	a0,0x7
ffffffffc0206498:	57c50513          	addi	a0,a0,1404 # ffffffffc020da10 <CSWTCH.79+0x1c8>
ffffffffc020649c:	d0bf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02064a0:	00090797          	auipc	a5,0x90
ffffffffc02064a4:	4307b783          	ld	a5,1072(a5) # ffffffffc02968d0 <initproc>
ffffffffc02064a8:	7bf8                	ld	a4,240(a5)
ffffffffc02064aa:	e339                	bnez	a4,ffffffffc02064f0 <init_main+0x9e>
ffffffffc02064ac:	7ff8                	ld	a4,248(a5)
ffffffffc02064ae:	e329                	bnez	a4,ffffffffc02064f0 <init_main+0x9e>
ffffffffc02064b0:	1007b703          	ld	a4,256(a5)
ffffffffc02064b4:	ef15                	bnez	a4,ffffffffc02064f0 <init_main+0x9e>
ffffffffc02064b6:	00090697          	auipc	a3,0x90
ffffffffc02064ba:	4226a683          	lw	a3,1058(a3) # ffffffffc02968d8 <nr_process>
ffffffffc02064be:	4709                	li	a4,2
ffffffffc02064c0:	0ce69163          	bne	a3,a4,ffffffffc0206582 <init_main+0x130>
ffffffffc02064c4:	0008f717          	auipc	a4,0x8f
ffffffffc02064c8:	2fc70713          	addi	a4,a4,764 # ffffffffc02957c0 <proc_list>
ffffffffc02064cc:	6714                	ld	a3,8(a4)
ffffffffc02064ce:	0c878793          	addi	a5,a5,200
ffffffffc02064d2:	08d79863          	bne	a5,a3,ffffffffc0206562 <init_main+0x110>
ffffffffc02064d6:	6318                	ld	a4,0(a4)
ffffffffc02064d8:	06e79563          	bne	a5,a4,ffffffffc0206542 <init_main+0xf0>
ffffffffc02064dc:	00007517          	auipc	a0,0x7
ffffffffc02064e0:	61c50513          	addi	a0,a0,1564 # ffffffffc020daf8 <CSWTCH.79+0x2b0>
ffffffffc02064e4:	cc3f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02064e8:	60a2                	ld	ra,8(sp)
ffffffffc02064ea:	4501                	li	a0,0
ffffffffc02064ec:	0141                	addi	sp,sp,16
ffffffffc02064ee:	8082                	ret
ffffffffc02064f0:	00007697          	auipc	a3,0x7
ffffffffc02064f4:	54868693          	addi	a3,a3,1352 # ffffffffc020da38 <CSWTCH.79+0x1f0>
ffffffffc02064f8:	00006617          	auipc	a2,0x6
ffffffffc02064fc:	90860613          	addi	a2,a2,-1784 # ffffffffc020be00 <commands+0x210>
ffffffffc0206500:	51e00593          	li	a1,1310
ffffffffc0206504:	00007517          	auipc	a0,0x7
ffffffffc0206508:	43450513          	addi	a0,a0,1076 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020650c:	f93f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206510:	00007617          	auipc	a2,0x7
ffffffffc0206514:	4e060613          	addi	a2,a2,1248 # ffffffffc020d9f0 <CSWTCH.79+0x1a8>
ffffffffc0206518:	51100593          	li	a1,1297
ffffffffc020651c:	00007517          	auipc	a0,0x7
ffffffffc0206520:	41c50513          	addi	a0,a0,1052 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc0206524:	f7bf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206528:	86aa                	mv	a3,a0
ffffffffc020652a:	00007617          	auipc	a2,0x7
ffffffffc020652e:	4a660613          	addi	a2,a2,1190 # ffffffffc020d9d0 <CSWTCH.79+0x188>
ffffffffc0206532:	50900593          	li	a1,1289
ffffffffc0206536:	00007517          	auipc	a0,0x7
ffffffffc020653a:	40250513          	addi	a0,a0,1026 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020653e:	f61f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206542:	00007697          	auipc	a3,0x7
ffffffffc0206546:	58668693          	addi	a3,a3,1414 # ffffffffc020dac8 <CSWTCH.79+0x280>
ffffffffc020654a:	00006617          	auipc	a2,0x6
ffffffffc020654e:	8b660613          	addi	a2,a2,-1866 # ffffffffc020be00 <commands+0x210>
ffffffffc0206552:	52100593          	li	a1,1313
ffffffffc0206556:	00007517          	auipc	a0,0x7
ffffffffc020655a:	3e250513          	addi	a0,a0,994 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020655e:	f41f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206562:	00007697          	auipc	a3,0x7
ffffffffc0206566:	53668693          	addi	a3,a3,1334 # ffffffffc020da98 <CSWTCH.79+0x250>
ffffffffc020656a:	00006617          	auipc	a2,0x6
ffffffffc020656e:	89660613          	addi	a2,a2,-1898 # ffffffffc020be00 <commands+0x210>
ffffffffc0206572:	52000593          	li	a1,1312
ffffffffc0206576:	00007517          	auipc	a0,0x7
ffffffffc020657a:	3c250513          	addi	a0,a0,962 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020657e:	f21f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206582:	00007697          	auipc	a3,0x7
ffffffffc0206586:	50668693          	addi	a3,a3,1286 # ffffffffc020da88 <CSWTCH.79+0x240>
ffffffffc020658a:	00006617          	auipc	a2,0x6
ffffffffc020658e:	87660613          	addi	a2,a2,-1930 # ffffffffc020be00 <commands+0x210>
ffffffffc0206592:	51f00593          	li	a1,1311
ffffffffc0206596:	00007517          	auipc	a0,0x7
ffffffffc020659a:	3a250513          	addi	a0,a0,930 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020659e:	f01f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02065a2 <do_execve>:
ffffffffc02065a2:	c8010113          	addi	sp,sp,-896
ffffffffc02065a6:	35513423          	sd	s5,840(sp)
ffffffffc02065aa:	00090a97          	auipc	s5,0x90
ffffffffc02065ae:	316a8a93          	addi	s5,s5,790 # ffffffffc02968c0 <current>
ffffffffc02065b2:	000ab683          	ld	a3,0(s5)
ffffffffc02065b6:	37213023          	sd	s2,864(sp)
ffffffffc02065ba:	fff5891b          	addiw	s2,a1,-1
ffffffffc02065be:	33813823          	sd	s8,816(sp)
ffffffffc02065c2:	36113c23          	sd	ra,888(sp)
ffffffffc02065c6:	36813823          	sd	s0,880(sp)
ffffffffc02065ca:	36913423          	sd	s1,872(sp)
ffffffffc02065ce:	35313c23          	sd	s3,856(sp)
ffffffffc02065d2:	35413823          	sd	s4,848(sp)
ffffffffc02065d6:	35613023          	sd	s6,832(sp)
ffffffffc02065da:	33713c23          	sd	s7,824(sp)
ffffffffc02065de:	33913423          	sd	s9,808(sp)
ffffffffc02065e2:	33a13023          	sd	s10,800(sp)
ffffffffc02065e6:	31b13c23          	sd	s11,792(sp)
ffffffffc02065ea:	0009071b          	sext.w	a4,s2
ffffffffc02065ee:	47fd                	li	a5,31
ffffffffc02065f0:	0286bc03          	ld	s8,40(a3)
ffffffffc02065f4:	5ee7ef63          	bltu	a5,a4,ffffffffc0206bf2 <do_execve+0x650>
ffffffffc02065f8:	842e                	mv	s0,a1
ffffffffc02065fa:	84aa                	mv	s1,a0
ffffffffc02065fc:	8cb2                	mv	s9,a2
ffffffffc02065fe:	4581                	li	a1,0
ffffffffc0206600:	4641                	li	a2,16
ffffffffc0206602:	18a8                	addi	a0,sp,120
ffffffffc0206604:	314050ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0206608:	000c0c63          	beqz	s8,ffffffffc0206620 <do_execve+0x7e>
ffffffffc020660c:	038c0513          	addi	a0,s8,56
ffffffffc0206610:	fedfd0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0206614:	000ab783          	ld	a5,0(s5)
ffffffffc0206618:	c781                	beqz	a5,ffffffffc0206620 <do_execve+0x7e>
ffffffffc020661a:	43dc                	lw	a5,4(a5)
ffffffffc020661c:	04fc2823          	sw	a5,80(s8)
ffffffffc0206620:	22048363          	beqz	s1,ffffffffc0206846 <do_execve+0x2a4>
ffffffffc0206624:	46c1                	li	a3,16
ffffffffc0206626:	8626                	mv	a2,s1
ffffffffc0206628:	18ac                	addi	a1,sp,120
ffffffffc020662a:	8562                	mv	a0,s8
ffffffffc020662c:	df5fd0ef          	jal	ra,ffffffffc0204420 <copy_string>
ffffffffc0206630:	66050763          	beqz	a0,ffffffffc0206c9e <do_execve+0x6fc>
ffffffffc0206634:	00341b13          	slli	s6,s0,0x3
ffffffffc0206638:	4681                	li	a3,0
ffffffffc020663a:	865a                	mv	a2,s6
ffffffffc020663c:	85e6                	mv	a1,s9
ffffffffc020663e:	8562                	mv	a0,s8
ffffffffc0206640:	ce7fd0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc0206644:	8a66                	mv	s4,s9
ffffffffc0206646:	5a050a63          	beqz	a0,ffffffffc0206bfa <do_execve+0x658>
ffffffffc020664a:	11010b93          	addi	s7,sp,272
ffffffffc020664e:	4481                	li	s1,0
ffffffffc0206650:	a011                	j	ffffffffc0206654 <do_execve+0xb2>
ffffffffc0206652:	84ee                	mv	s1,s11
ffffffffc0206654:	6505                	lui	a0,0x1
ffffffffc0206656:	9cdfb0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020665a:	89aa                	mv	s3,a0
ffffffffc020665c:	18050f63          	beqz	a0,ffffffffc02067fa <do_execve+0x258>
ffffffffc0206660:	000a3603          	ld	a2,0(s4)
ffffffffc0206664:	85aa                	mv	a1,a0
ffffffffc0206666:	6685                	lui	a3,0x1
ffffffffc0206668:	8562                	mv	a0,s8
ffffffffc020666a:	db7fd0ef          	jal	ra,ffffffffc0204420 <copy_string>
ffffffffc020666e:	1c050763          	beqz	a0,ffffffffc020683c <do_execve+0x29a>
ffffffffc0206672:	013bb023          	sd	s3,0(s7)
ffffffffc0206676:	00148d9b          	addiw	s11,s1,1
ffffffffc020667a:	0ba1                	addi	s7,s7,8
ffffffffc020667c:	0a21                	addi	s4,s4,8
ffffffffc020667e:	fdb41ae3          	bne	s0,s11,ffffffffc0206652 <do_execve+0xb0>
ffffffffc0206682:	000cb983          	ld	s3,0(s9)
ffffffffc0206686:	100c0763          	beqz	s8,ffffffffc0206794 <do_execve+0x1f2>
ffffffffc020668a:	038c0513          	addi	a0,s8,56
ffffffffc020668e:	f6bfd0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0206692:	000ab783          	ld	a5,0(s5)
ffffffffc0206696:	040c2823          	sw	zero,80(s8)
ffffffffc020669a:	1487b503          	ld	a0,328(a5)
ffffffffc020669e:	c95fe0ef          	jal	ra,ffffffffc0205332 <files_closeall>
ffffffffc02066a2:	854e                	mv	a0,s3
ffffffffc02066a4:	4581                	li	a1,0
ffffffffc02066a6:	f19fe0ef          	jal	ra,ffffffffc02055be <sysfile_open>
ffffffffc02066aa:	89aa                	mv	s3,a0
ffffffffc02066ac:	10054163          	bltz	a0,ffffffffc02067ae <do_execve+0x20c>
ffffffffc02066b0:	00090797          	auipc	a5,0x90
ffffffffc02066b4:	1e07b783          	ld	a5,480(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02066b8:	577d                	li	a4,-1
ffffffffc02066ba:	177e                	slli	a4,a4,0x3f
ffffffffc02066bc:	83b1                	srli	a5,a5,0xc
ffffffffc02066be:	8fd9                	or	a5,a5,a4
ffffffffc02066c0:	18079073          	csrw	satp,a5
ffffffffc02066c4:	030c2783          	lw	a5,48(s8)
ffffffffc02066c8:	fff7871b          	addiw	a4,a5,-1
ffffffffc02066cc:	02ec2823          	sw	a4,48(s8)
ffffffffc02066d0:	18070763          	beqz	a4,ffffffffc020685e <do_execve+0x2bc>
ffffffffc02066d4:	000ab783          	ld	a5,0(s5)
ffffffffc02066d8:	0207b423          	sd	zero,40(a5)
ffffffffc02066dc:	4601                	li	a2,0
ffffffffc02066de:	4581                	li	a1,0
ffffffffc02066e0:	854e                	mv	a0,s3
ffffffffc02066e2:	942ff0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc02066e6:	8a2a                	mv	s4,a0
ffffffffc02066e8:	0e051f63          	bnez	a0,ffffffffc02067e6 <do_execve+0x244>
ffffffffc02066ec:	04000613          	li	a2,64
ffffffffc02066f0:	098c                	addi	a1,sp,208
ffffffffc02066f2:	854e                	mv	a0,s3
ffffffffc02066f4:	f03fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc02066f8:	04000793          	li	a5,64
ffffffffc02066fc:	8d2a                	mv	s10,a0
ffffffffc02066fe:	0cf51f63          	bne	a0,a5,ffffffffc02067dc <do_execve+0x23a>
ffffffffc0206702:	474e                	lw	a4,208(sp)
ffffffffc0206704:	464c47b7          	lui	a5,0x464c4
ffffffffc0206708:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc020670c:	16f70463          	beq	a4,a5,ffffffffc0206874 <do_execve+0x2d2>
ffffffffc0206710:	854e                	mv	a0,s3
ffffffffc0206712:	1902                	slli	s2,s2,0x20
ffffffffc0206714:	edffe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc0206718:	10010c93          	addi	s9,sp,256
ffffffffc020671c:	02095913          	srli	s2,s2,0x20
ffffffffc0206720:	147d                	addi	s0,s0,-1
ffffffffc0206722:	040e                	slli	s0,s0,0x3
ffffffffc0206724:	9b66                	add	s6,s6,s9
ffffffffc0206726:	090e                	slli	s2,s2,0x3
ffffffffc0206728:	0a1c                	addi	a5,sp,272
ffffffffc020672a:	943e                	add	s0,s0,a5
ffffffffc020672c:	412b0b33          	sub	s6,s6,s2
ffffffffc0206730:	6008                	ld	a0,0(s0)
ffffffffc0206732:	1461                	addi	s0,s0,-8
ffffffffc0206734:	99ffb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206738:	ff641ce3          	bne	s0,s6,ffffffffc0206730 <do_execve+0x18e>
ffffffffc020673c:	000ab403          	ld	s0,0(s5)
ffffffffc0206740:	4641                	li	a2,16
ffffffffc0206742:	4581                	li	a1,0
ffffffffc0206744:	0b440413          	addi	s0,s0,180
ffffffffc0206748:	8522                	mv	a0,s0
ffffffffc020674a:	1ce050ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc020674e:	463d                	li	a2,15
ffffffffc0206750:	18ac                	addi	a1,sp,120
ffffffffc0206752:	8522                	mv	a0,s0
ffffffffc0206754:	216050ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0206758:	37813083          	ld	ra,888(sp)
ffffffffc020675c:	37013403          	ld	s0,880(sp)
ffffffffc0206760:	36813483          	ld	s1,872(sp)
ffffffffc0206764:	36013903          	ld	s2,864(sp)
ffffffffc0206768:	35813983          	ld	s3,856(sp)
ffffffffc020676c:	34813a83          	ld	s5,840(sp)
ffffffffc0206770:	34013b03          	ld	s6,832(sp)
ffffffffc0206774:	33813b83          	ld	s7,824(sp)
ffffffffc0206778:	33013c03          	ld	s8,816(sp)
ffffffffc020677c:	32813c83          	ld	s9,808(sp)
ffffffffc0206780:	32013d03          	ld	s10,800(sp)
ffffffffc0206784:	31813d83          	ld	s11,792(sp)
ffffffffc0206788:	8552                	mv	a0,s4
ffffffffc020678a:	35013a03          	ld	s4,848(sp)
ffffffffc020678e:	38010113          	addi	sp,sp,896
ffffffffc0206792:	8082                	ret
ffffffffc0206794:	000ab783          	ld	a5,0(s5)
ffffffffc0206798:	1487b503          	ld	a0,328(a5)
ffffffffc020679c:	b97fe0ef          	jal	ra,ffffffffc0205332 <files_closeall>
ffffffffc02067a0:	854e                	mv	a0,s3
ffffffffc02067a2:	4581                	li	a1,0
ffffffffc02067a4:	e1bfe0ef          	jal	ra,ffffffffc02055be <sysfile_open>
ffffffffc02067a8:	89aa                	mv	s3,a0
ffffffffc02067aa:	f20559e3          	bgez	a0,ffffffffc02066dc <do_execve+0x13a>
ffffffffc02067ae:	1902                	slli	s2,s2,0x20
ffffffffc02067b0:	10010c93          	addi	s9,sp,256
ffffffffc02067b4:	02095913          	srli	s2,s2,0x20
ffffffffc02067b8:	147d                	addi	s0,s0,-1
ffffffffc02067ba:	040e                	slli	s0,s0,0x3
ffffffffc02067bc:	016c87b3          	add	a5,s9,s6
ffffffffc02067c0:	090e                	slli	s2,s2,0x3
ffffffffc02067c2:	0a18                	addi	a4,sp,272
ffffffffc02067c4:	943a                	add	s0,s0,a4
ffffffffc02067c6:	41278933          	sub	s2,a5,s2
ffffffffc02067ca:	6008                	ld	a0,0(s0)
ffffffffc02067cc:	1461                	addi	s0,s0,-8
ffffffffc02067ce:	905fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02067d2:	fe891ce3          	bne	s2,s0,ffffffffc02067ca <do_execve+0x228>
ffffffffc02067d6:	854e                	mv	a0,s3
ffffffffc02067d8:	947ff0ef          	jal	ra,ffffffffc020611e <do_exit>
ffffffffc02067dc:	00050a1b          	sext.w	s4,a0
ffffffffc02067e0:	00054363          	bltz	a0,ffffffffc02067e6 <do_execve+0x244>
ffffffffc02067e4:	5a7d                	li	s4,-1
ffffffffc02067e6:	1902                	slli	s2,s2,0x20
ffffffffc02067e8:	10010c93          	addi	s9,sp,256
ffffffffc02067ec:	02095913          	srli	s2,s2,0x20
ffffffffc02067f0:	854e                	mv	a0,s3
ffffffffc02067f2:	e01fe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc02067f6:	89d2                	mv	s3,s4
ffffffffc02067f8:	b7c1                	j	ffffffffc02067b8 <do_execve+0x216>
ffffffffc02067fa:	5a71                	li	s4,-4
ffffffffc02067fc:	c49d                	beqz	s1,ffffffffc020682a <do_execve+0x288>
ffffffffc02067fe:	00349713          	slli	a4,s1,0x3
ffffffffc0206802:	fff48413          	addi	s0,s1,-1
ffffffffc0206806:	021c                	addi	a5,sp,256
ffffffffc0206808:	34fd                	addiw	s1,s1,-1
ffffffffc020680a:	97ba                	add	a5,a5,a4
ffffffffc020680c:	02049713          	slli	a4,s1,0x20
ffffffffc0206810:	01d75493          	srli	s1,a4,0x1d
ffffffffc0206814:	040e                	slli	s0,s0,0x3
ffffffffc0206816:	0a18                	addi	a4,sp,272
ffffffffc0206818:	943a                	add	s0,s0,a4
ffffffffc020681a:	409784b3          	sub	s1,a5,s1
ffffffffc020681e:	6008                	ld	a0,0(s0)
ffffffffc0206820:	1461                	addi	s0,s0,-8
ffffffffc0206822:	8b1fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206826:	fe849ce3          	bne	s1,s0,ffffffffc020681e <do_execve+0x27c>
ffffffffc020682a:	f20c07e3          	beqz	s8,ffffffffc0206758 <do_execve+0x1b6>
ffffffffc020682e:	038c0513          	addi	a0,s8,56
ffffffffc0206832:	dc7fd0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0206836:	040c2823          	sw	zero,80(s8)
ffffffffc020683a:	bf39                	j	ffffffffc0206758 <do_execve+0x1b6>
ffffffffc020683c:	854e                	mv	a0,s3
ffffffffc020683e:	895fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206842:	5a75                	li	s4,-3
ffffffffc0206844:	bf65                	j	ffffffffc02067fc <do_execve+0x25a>
ffffffffc0206846:	000ab783          	ld	a5,0(s5)
ffffffffc020684a:	00007617          	auipc	a2,0x7
ffffffffc020684e:	2ce60613          	addi	a2,a2,718 # ffffffffc020db18 <CSWTCH.79+0x2d0>
ffffffffc0206852:	45c1                	li	a1,16
ffffffffc0206854:	43d4                	lw	a3,4(a5)
ffffffffc0206856:	18a8                	addi	a0,sp,120
ffffffffc0206858:	7d1040ef          	jal	ra,ffffffffc020b828 <snprintf>
ffffffffc020685c:	bbe1                	j	ffffffffc0206634 <do_execve+0x92>
ffffffffc020685e:	8562                	mv	a0,s8
ffffffffc0206860:	f26fd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc0206864:	018c3503          	ld	a0,24(s8)
ffffffffc0206868:	b00ff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc020686c:	8562                	mv	a0,s8
ffffffffc020686e:	d7cfd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206872:	b58d                	j	ffffffffc02066d4 <do_execve+0x132>
ffffffffc0206874:	c28fd0ef          	jal	ra,ffffffffc0203c9c <mm_create>
ffffffffc0206878:	f42a                	sd	a0,40(sp)
ffffffffc020687a:	34050a63          	beqz	a0,ffffffffc0206bce <do_execve+0x62c>
ffffffffc020687e:	4505                	li	a0,1
ffffffffc0206880:	981fb0ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0206884:	34050263          	beqz	a0,ffffffffc0206bc8 <do_execve+0x626>
ffffffffc0206888:	00090717          	auipc	a4,0x90
ffffffffc020688c:	02070713          	addi	a4,a4,32 # ffffffffc02968a8 <pages>
ffffffffc0206890:	6318                	ld	a4,0(a4)
ffffffffc0206892:	00009697          	auipc	a3,0x9
ffffffffc0206896:	3266b683          	ld	a3,806(a3) # ffffffffc020fbb8 <nbase>
ffffffffc020689a:	00090c17          	auipc	s8,0x90
ffffffffc020689e:	006c0c13          	addi	s8,s8,6 # ffffffffc02968a0 <npage>
ffffffffc02068a2:	40e507b3          	sub	a5,a0,a4
ffffffffc02068a6:	8799                	srai	a5,a5,0x6
ffffffffc02068a8:	97b6                	add	a5,a5,a3
ffffffffc02068aa:	000c3603          	ld	a2,0(s8)
ffffffffc02068ae:	00c79713          	slli	a4,a5,0xc
ffffffffc02068b2:	fc36                	sd	a3,56(sp)
ffffffffc02068b4:	8331                	srli	a4,a4,0xc
ffffffffc02068b6:	00c79693          	slli	a3,a5,0xc
ffffffffc02068ba:	7ec77663          	bgeu	a4,a2,ffffffffc02070a6 <do_execve+0xb04>
ffffffffc02068be:	00090b97          	auipc	s7,0x90
ffffffffc02068c2:	ffab8b93          	addi	s7,s7,-6 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02068c6:	000bbc83          	ld	s9,0(s7)
ffffffffc02068ca:	6605                	lui	a2,0x1
ffffffffc02068cc:	00090597          	auipc	a1,0x90
ffffffffc02068d0:	fcc5b583          	ld	a1,-52(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc02068d4:	9cb6                	add	s9,s9,a3
ffffffffc02068d6:	8566                	mv	a0,s9
ffffffffc02068d8:	092050ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc02068dc:	77ee                	ld	a5,248(sp)
ffffffffc02068de:	7722                	ld	a4,40(sp)
ffffffffc02068e0:	e0be                	sd	a5,64(sp)
ffffffffc02068e2:	01973c23          	sd	s9,24(a4)
ffffffffc02068e6:	26079f63          	bnez	a5,ffffffffc0206b64 <do_execve+0x5c2>
ffffffffc02068ea:	10815783          	lhu	a5,264(sp)
ffffffffc02068ee:	4681                	li	a3,0
ffffffffc02068f0:	4701                	li	a4,0
ffffffffc02068f2:	52078963          	beqz	a5,ffffffffc0206e24 <do_execve+0x882>
ffffffffc02068f6:	57fd                	li	a5,-1
ffffffffc02068f8:	ec22                	sd	s0,24(sp)
ffffffffc02068fa:	7462                	ld	s0,56(sp)
ffffffffc02068fc:	83b1                	srli	a5,a5,0xc
ffffffffc02068fe:	f0a6                	sd	s1,96(sp)
ffffffffc0206900:	f4d2                	sd	s4,104(sp)
ffffffffc0206902:	e43e                	sd	a5,8(sp)
ffffffffc0206904:	e85a                	sd	s6,16(sp)
ffffffffc0206906:	ecee                	sd	s11,88(sp)
ffffffffc0206908:	84b6                	mv	s1,a3
ffffffffc020690a:	8a3a                	mv	s4,a4
ffffffffc020690c:	d04a                	sw	s2,32(sp)
ffffffffc020690e:	75ce                	ld	a1,240(sp)
ffffffffc0206910:	4601                	li	a2,0
ffffffffc0206912:	854e                	mv	a0,s3
ffffffffc0206914:	95d2                	add	a1,a1,s4
ffffffffc0206916:	f0ffe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc020691a:	12051863          	bnez	a0,ffffffffc0206a4a <do_execve+0x4a8>
ffffffffc020691e:	03800613          	li	a2,56
ffffffffc0206922:	092c                	addi	a1,sp,152
ffffffffc0206924:	854e                	mv	a0,s3
ffffffffc0206926:	cd1fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc020692a:	0938                	addi	a4,sp,152
ffffffffc020692c:	03800793          	li	a5,56
ffffffffc0206930:	f83a                	sd	a4,48(sp)
ffffffffc0206932:	02f50d63          	beq	a0,a5,ffffffffc020696c <do_execve+0x3ca>
ffffffffc0206936:	6b42                	ld	s6,16(sp)
ffffffffc0206938:	6462                	ld	s0,24(sp)
ffffffffc020693a:	5902                	lw	s2,32(sp)
ffffffffc020693c:	0005081b          	sext.w	a6,a0
ffffffffc0206940:	00054363          	bltz	a0,ffffffffc0206946 <do_execve+0x3a4>
ffffffffc0206944:	587d                	li	a6,-1
ffffffffc0206946:	1902                	slli	s2,s2,0x20
ffffffffc0206948:	10010c93          	addi	s9,sp,256
ffffffffc020694c:	02095913          	srli	s2,s2,0x20
ffffffffc0206950:	74a2                	ld	s1,40(sp)
ffffffffc0206952:	e442                	sd	a6,8(sp)
ffffffffc0206954:	8526                	mv	a0,s1
ffffffffc0206956:	e30fd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc020695a:	6822                	ld	a6,8(sp)
ffffffffc020695c:	6c88                	ld	a0,24(s1)
ffffffffc020695e:	8a42                	mv	s4,a6
ffffffffc0206960:	a08ff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc0206964:	7522                	ld	a0,40(sp)
ffffffffc0206966:	c84fd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc020696a:	b559                	j	ffffffffc02067f0 <do_execve+0x24e>
ffffffffc020696c:	47ea                	lw	a5,152(sp)
ffffffffc020696e:	4705                	li	a4,1
ffffffffc0206970:	0ee78763          	beq	a5,a4,ffffffffc0206a5e <do_execve+0x4bc>
ffffffffc0206974:	10815783          	lhu	a5,264(sp)
ffffffffc0206978:	2485                	addiw	s1,s1,1
ffffffffc020697a:	038a0a13          	addi	s4,s4,56
ffffffffc020697e:	f8f4c8e3          	blt	s1,a5,ffffffffc020690e <do_execve+0x36c>
ffffffffc0206982:	6b42                	ld	s6,16(sp)
ffffffffc0206984:	6de6                	ld	s11,88(sp)
ffffffffc0206986:	7486                	ld	s1,96(sp)
ffffffffc0206988:	7a26                	ld	s4,104(sp)
ffffffffc020698a:	6462                	ld	s0,24(sp)
ffffffffc020698c:	5902                	lw	s2,32(sp)
ffffffffc020698e:	00800cb7          	lui	s9,0x800
ffffffffc0206992:	320c8793          	addi	a5,s9,800 # 800320 <_binary_bin_sfs_img_size+0x78b020>
ffffffffc0206996:	e93e                	sd	a5,144(sp)
ffffffffc0206998:	57fd                	li	a5,-1
ffffffffc020699a:	83b1                	srli	a5,a5,0xc
ffffffffc020699c:	e43e                	sd	a5,8(sp)
ffffffffc020699e:	e4a6                	sd	s1,72(sp)
ffffffffc02069a0:	6785                	lui	a5,0x1
ffffffffc02069a2:	e8a2                	sd	s0,80(sp)
ffffffffc02069a4:	74e2                	ld	s1,56(sp)
ffffffffc02069a6:	7422                	ld	s0,40(sp)
ffffffffc02069a8:	0138                	addi	a4,sp,136
ffffffffc02069aa:	17fd                	addi	a5,a5,-1
ffffffffc02069ac:	ccca                	sw	s2,88(sp)
ffffffffc02069ae:	020c8c93          	addi	s9,s9,32
ffffffffc02069b2:	e83e                	sd	a5,16(sp)
ffffffffc02069b4:	ec5a                	sd	s6,24(sp)
ffffffffc02069b6:	f04e                	sd	s3,32(sp)
ffffffffc02069b8:	893a                	mv	s2,a4
ffffffffc02069ba:	0c1c                	addi	a5,sp,528
ffffffffc02069bc:	20013823          	sd	zero,528(sp)
ffffffffc02069c0:	20013c23          	sd	zero,536(sp)
ffffffffc02069c4:	010c8d13          	addi	s10,s9,16
ffffffffc02069c8:	89e6                	mv	s3,s9
ffffffffc02069ca:	41978b33          	sub	s6,a5,s9
ffffffffc02069ce:	6c08                	ld	a0,24(s0)
ffffffffc02069d0:	4601                	li	a2,0
ffffffffc02069d2:	85ce                	mv	a1,s3
ffffffffc02069d4:	bd3fb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc02069d8:	87aa                	mv	a5,a0
ffffffffc02069da:	2e050163          	beqz	a0,ffffffffc0206cbc <do_execve+0x71a>
ffffffffc02069de:	00090717          	auipc	a4,0x90
ffffffffc02069e2:	eca70713          	addi	a4,a4,-310 # ffffffffc02968a8 <pages>
ffffffffc02069e6:	6314                	ld	a3,0(a4)
ffffffffc02069e8:	6722                	ld	a4,8(sp)
ffffffffc02069ea:	000c3603          	ld	a2,0(s8)
ffffffffc02069ee:	8f95                	sub	a5,a5,a3
ffffffffc02069f0:	8799                	srai	a5,a5,0x6
ffffffffc02069f2:	97a6                	add	a5,a5,s1
ffffffffc02069f4:	00e7f5b3          	and	a1,a5,a4
ffffffffc02069f8:	013b0533          	add	a0,s6,s3
ffffffffc02069fc:	00c79693          	slli	a3,a5,0xc
ffffffffc0206a00:	6ac5f363          	bgeu	a1,a2,ffffffffc02070a6 <do_execve+0xb04>
ffffffffc0206a04:	000bb783          	ld	a5,0(s7)
ffffffffc0206a08:	6742                	ld	a4,16(sp)
ffffffffc0206a0a:	4611                	li	a2,4
ffffffffc0206a0c:	97b6                	add	a5,a5,a3
ffffffffc0206a0e:	00e9f5b3          	and	a1,s3,a4
ffffffffc0206a12:	95be                	add	a1,a1,a5
ffffffffc0206a14:	0991                	addi	s3,s3,4
ffffffffc0206a16:	755040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0206a1a:	fba99ae3          	bne	s3,s10,ffffffffc02069ce <do_execve+0x42c>
ffffffffc0206a1e:	21c12783          	lw	a5,540(sp)
ffffffffc0206a22:	21812703          	lw	a4,536(sp)
ffffffffc0206a26:	21412683          	lw	a3,532(sp)
ffffffffc0206a2a:	21012603          	lw	a2,528(sp)
ffffffffc0206a2e:	85e6                	mv	a1,s9
ffffffffc0206a30:	00007517          	auipc	a0,0x7
ffffffffc0206a34:	17850513          	addi	a0,a0,376 # ffffffffc020dba8 <CSWTCH.79+0x360>
ffffffffc0206a38:	f6ef90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206a3c:	77c2                	ld	a5,48(sp)
ffffffffc0206a3e:	0921                	addi	s2,s2,8
ffffffffc0206a40:	1d278163          	beq	a5,s2,ffffffffc0206c02 <do_execve+0x660>
ffffffffc0206a44:	00093c83          	ld	s9,0(s2) # ffffffff80000000 <_binary_bin_sfs_img_size+0xffffffff7ff8ad00>
ffffffffc0206a48:	bf8d                	j	ffffffffc02069ba <do_execve+0x418>
ffffffffc0206a4a:	5902                	lw	s2,32(sp)
ffffffffc0206a4c:	6b42                	ld	s6,16(sp)
ffffffffc0206a4e:	6462                	ld	s0,24(sp)
ffffffffc0206a50:	1902                	slli	s2,s2,0x20
ffffffffc0206a52:	882a                	mv	a6,a0
ffffffffc0206a54:	10010c93          	addi	s9,sp,256
ffffffffc0206a58:	02095913          	srli	s2,s2,0x20
ffffffffc0206a5c:	bdd5                	j	ffffffffc0206950 <do_execve+0x3ae>
ffffffffc0206a5e:	678e                	ld	a5,192(sp)
ffffffffc0206a60:	760a                	ld	a2,160(sp)
ffffffffc0206a62:	487a                	lw	a6,156(sp)
ffffffffc0206a64:	776a                	ld	a4,184(sp)
ffffffffc0206a66:	76aa                	ld	a3,168(sp)
ffffffffc0206a68:	85a6                	mv	a1,s1
ffffffffc0206a6a:	00007517          	auipc	a0,0x7
ffffffffc0206a6e:	0d650513          	addi	a0,a0,214 # ffffffffc020db40 <CSWTCH.79+0x2f8>
ffffffffc0206a72:	f34f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206a76:	660e                	ld	a2,192(sp)
ffffffffc0206a78:	77ea                	ld	a5,184(sp)
ffffffffc0206a7a:	22f66c63          	bltu	a2,a5,ffffffffc0206cb2 <do_execve+0x710>
ffffffffc0206a7e:	75aa                	ld	a1,168(sp)
ffffffffc0206a80:	002007b7          	lui	a5,0x200
ffffffffc0206a84:	22f5e763          	bltu	a1,a5,ffffffffc0206cb2 <do_execve+0x710>
ffffffffc0206a88:	00b607b3          	add	a5,a2,a1
ffffffffc0206a8c:	22f5f363          	bgeu	a1,a5,ffffffffc0206cb2 <do_execve+0x710>
ffffffffc0206a90:	4705                	li	a4,1
ffffffffc0206a92:	077e                	slli	a4,a4,0x1f
ffffffffc0206a94:	20f76f63          	bltu	a4,a5,ffffffffc0206cb2 <do_execve+0x710>
ffffffffc0206a98:	47fa                	lw	a5,156(sp)
ffffffffc0206a9a:	4dc1                	li	s11,16
ffffffffc0206a9c:	0017f693          	andi	a3,a5,1
ffffffffc0206aa0:	c299                	beqz	a3,ffffffffc0206aa6 <do_execve+0x504>
ffffffffc0206aa2:	4de9                	li	s11,26
ffffffffc0206aa4:	4691                	li	a3,4
ffffffffc0206aa6:	0027f713          	andi	a4,a5,2
ffffffffc0206aaa:	c709                	beqz	a4,ffffffffc0206ab4 <do_execve+0x512>
ffffffffc0206aac:	0026e693          	ori	a3,a3,2
ffffffffc0206ab0:	006ded93          	ori	s11,s11,6
ffffffffc0206ab4:	8b91                	andi	a5,a5,4
ffffffffc0206ab6:	0e079863          	bnez	a5,ffffffffc0206ba6 <do_execve+0x604>
ffffffffc0206aba:	7522                	ld	a0,40(sp)
ffffffffc0206abc:	4701                	li	a4,0
ffffffffc0206abe:	b7efd0ef          	jal	ra,ffffffffc0203e3c <mm_map>
ffffffffc0206ac2:	f541                	bnez	a0,ffffffffc0206a4a <do_execve+0x4a8>
ffffffffc0206ac4:	792a                	ld	s2,168(sp)
ffffffffc0206ac6:	6d0e                	ld	s10,192(sp)
ffffffffc0206ac8:	7cea                	ld	s9,184(sp)
ffffffffc0206aca:	9d4a                	add	s10,s10,s2
ffffffffc0206acc:	9cca                	add	s9,s9,s2
ffffffffc0206ace:	eba973e3          	bgeu	s2,s10,ffffffffc0206974 <do_execve+0x3d2>
ffffffffc0206ad2:	e4a6                	sd	s1,72(sp)
ffffffffc0206ad4:	7b22                	ld	s6,40(sp)
ffffffffc0206ad6:	84ca                	mv	s1,s2
ffffffffc0206ad8:	e8d2                	sd	s4,80(sp)
ffffffffc0206ada:	a029                	j	ffffffffc0206ae4 <do_execve+0x542>
ffffffffc0206adc:	6785                	lui	a5,0x1
ffffffffc0206ade:	94be                	add	s1,s1,a5
ffffffffc0206ae0:	11a4f663          	bgeu	s1,s10,ffffffffc0206bec <do_execve+0x64a>
ffffffffc0206ae4:	018b3503          	ld	a0,24(s6)
ffffffffc0206ae8:	866e                	mv	a2,s11
ffffffffc0206aea:	85a6                	mv	a1,s1
ffffffffc0206aec:	8cafd0ef          	jal	ra,ffffffffc0203bb6 <pgdir_alloc_page>
ffffffffc0206af0:	0e050463          	beqz	a0,ffffffffc0206bd8 <do_execve+0x636>
ffffffffc0206af4:	00090797          	auipc	a5,0x90
ffffffffc0206af8:	db478793          	addi	a5,a5,-588 # ffffffffc02968a8 <pages>
ffffffffc0206afc:	6394                	ld	a3,0(a5)
ffffffffc0206afe:	67a2                	ld	a5,8(sp)
ffffffffc0206b00:	000c3703          	ld	a4,0(s8)
ffffffffc0206b04:	8d15                	sub	a0,a0,a3
ffffffffc0206b06:	8519                	srai	a0,a0,0x6
ffffffffc0206b08:	9522                	add	a0,a0,s0
ffffffffc0206b0a:	00f576b3          	and	a3,a0,a5
ffffffffc0206b0e:	0532                	slli	a0,a0,0xc
ffffffffc0206b10:	58e6fa63          	bgeu	a3,a4,ffffffffc02070a4 <do_execve+0xb02>
ffffffffc0206b14:	000bb903          	ld	s2,0(s7)
ffffffffc0206b18:	6605                	lui	a2,0x1
ffffffffc0206b1a:	4581                	li	a1,0
ffffffffc0206b1c:	992a                	add	s2,s2,a0
ffffffffc0206b1e:	854a                	mv	a0,s2
ffffffffc0206b20:	5f9040ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0206b24:	fb94fce3          	bgeu	s1,s9,ffffffffc0206adc <do_execve+0x53a>
ffffffffc0206b28:	758a                	ld	a1,160(sp)
ffffffffc0206b2a:	772a                	ld	a4,168(sp)
ffffffffc0206b2c:	4601                	li	a2,0
ffffffffc0206b2e:	854e                	mv	a0,s3
ffffffffc0206b30:	8d99                	sub	a1,a1,a4
ffffffffc0206b32:	95a6                	add	a1,a1,s1
ffffffffc0206b34:	cf1fe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206b38:	f00519e3          	bnez	a0,ffffffffc0206a4a <do_execve+0x4a8>
ffffffffc0206b3c:	6785                	lui	a5,0x1
ffffffffc0206b3e:	fff78713          	addi	a4,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0206b42:	00e4f5b3          	and	a1,s1,a4
ffffffffc0206b46:	40b78733          	sub	a4,a5,a1
ffffffffc0206b4a:	409c8a33          	sub	s4,s9,s1
ffffffffc0206b4e:	01477363          	bgeu	a4,s4,ffffffffc0206b54 <do_execve+0x5b2>
ffffffffc0206b52:	8a3a                	mv	s4,a4
ffffffffc0206b54:	8652                	mv	a2,s4
ffffffffc0206b56:	95ca                	add	a1,a1,s2
ffffffffc0206b58:	854e                	mv	a0,s3
ffffffffc0206b5a:	a9dfe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206b5e:	f6aa0fe3          	beq	s4,a0,ffffffffc0206adc <do_execve+0x53a>
ffffffffc0206b62:	bbd1                	j	ffffffffc0206936 <do_execve+0x394>
ffffffffc0206b64:	10c15783          	lhu	a5,268(sp)
ffffffffc0206b68:	c7d9                	beqz	a5,ffffffffc0206bf6 <do_execve+0x654>
ffffffffc0206b6a:	10a15703          	lhu	a4,266(sp)
ffffffffc0206b6e:	e082                	sd	zero,64(sp)
ffffffffc0206b70:	d7a71de3          	bne	a4,s10,ffffffffc02068ea <do_execve+0x348>
ffffffffc0206b74:	00679d13          	slli	s10,a5,0x6
ffffffffc0206b78:	856a                	mv	a0,s10
ffffffffc0206b7a:	ca8fb0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0206b7e:	e42a                	sd	a0,8(sp)
ffffffffc0206b80:	c521                	beqz	a0,ffffffffc0206bc8 <do_execve+0x626>
ffffffffc0206b82:	75ee                	ld	a1,248(sp)
ffffffffc0206b84:	4601                	li	a2,0
ffffffffc0206b86:	854e                	mv	a0,s3
ffffffffc0206b88:	c9dfe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206b8c:	8caa                	mv	s9,a0
ffffffffc0206b8e:	12050f63          	beqz	a0,ffffffffc0206ccc <do_execve+0x72a>
ffffffffc0206b92:	6522                	ld	a0,8(sp)
ffffffffc0206b94:	1902                	slli	s2,s2,0x20
ffffffffc0206b96:	8a66                	mv	s4,s9
ffffffffc0206b98:	d3afb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206b9c:	10010c93          	addi	s9,sp,256
ffffffffc0206ba0:	02095913          	srli	s2,s2,0x20
ffffffffc0206ba4:	b3c1                	j	ffffffffc0206964 <do_execve+0x3c2>
ffffffffc0206ba6:	0016e693          	ori	a3,a3,1
ffffffffc0206baa:	002ded93          	ori	s11,s11,2
ffffffffc0206bae:	b731                	j	ffffffffc0206aba <do_execve+0x518>
ffffffffc0206bb0:	855a                	mv	a0,s6
ffffffffc0206bb2:	6462                	ld	s0,24(sp)
ffffffffc0206bb4:	6b42                	ld	s6,16(sp)
ffffffffc0206bb6:	5902                	lw	s2,32(sp)
ffffffffc0206bb8:	d1afb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206bbc:	4501                	li	a0,0
ffffffffc0206bbe:	d14fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206bc2:	6522                	ld	a0,8(sp)
ffffffffc0206bc4:	d0efb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206bc8:	7522                	ld	a0,40(sp)
ffffffffc0206bca:	a20fd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206bce:	854e                	mv	a0,s3
ffffffffc0206bd0:	a23fe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc0206bd4:	59f1                	li	s3,-4
ffffffffc0206bd6:	bee1                	j	ffffffffc02067ae <do_execve+0x20c>
ffffffffc0206bd8:	5902                	lw	s2,32(sp)
ffffffffc0206bda:	6b42                	ld	s6,16(sp)
ffffffffc0206bdc:	6462                	ld	s0,24(sp)
ffffffffc0206bde:	1902                	slli	s2,s2,0x20
ffffffffc0206be0:	10010c93          	addi	s9,sp,256
ffffffffc0206be4:	02095913          	srli	s2,s2,0x20
ffffffffc0206be8:	5871                	li	a6,-4
ffffffffc0206bea:	b39d                	j	ffffffffc0206950 <do_execve+0x3ae>
ffffffffc0206bec:	64a6                	ld	s1,72(sp)
ffffffffc0206bee:	6a46                	ld	s4,80(sp)
ffffffffc0206bf0:	b351                	j	ffffffffc0206974 <do_execve+0x3d2>
ffffffffc0206bf2:	5a75                	li	s4,-3
ffffffffc0206bf4:	b695                	j	ffffffffc0206758 <do_execve+0x1b6>
ffffffffc0206bf6:	e082                	sd	zero,64(sp)
ffffffffc0206bf8:	b9cd                	j	ffffffffc02068ea <do_execve+0x348>
ffffffffc0206bfa:	5a75                	li	s4,-3
ffffffffc0206bfc:	c20c19e3          	bnez	s8,ffffffffc020682e <do_execve+0x28c>
ffffffffc0206c00:	bea1                	j	ffffffffc0206758 <do_execve+0x1b6>
ffffffffc0206c02:	7522                	ld	a0,40(sp)
ffffffffc0206c04:	4701                	li	a4,0
ffffffffc0206c06:	46ad                	li	a3,11
ffffffffc0206c08:	00100637          	lui	a2,0x100
ffffffffc0206c0c:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0206c10:	6b62                	ld	s6,24(sp)
ffffffffc0206c12:	7982                	ld	s3,32(sp)
ffffffffc0206c14:	64a6                	ld	s1,72(sp)
ffffffffc0206c16:	6446                	ld	s0,80(sp)
ffffffffc0206c18:	4966                	lw	s2,88(sp)
ffffffffc0206c1a:	a22fd0ef          	jal	ra,ffffffffc0203e3c <mm_map>
ffffffffc0206c1e:	882a                	mv	a6,a0
ffffffffc0206c20:	d20513e3          	bnez	a0,ffffffffc0206946 <do_execve+0x3a4>
ffffffffc0206c24:	57fd                	li	a5,-1
ffffffffc0206c26:	7ff00d37          	lui	s10,0x7ff00
ffffffffc0206c2a:	83b1                	srli	a5,a5,0xc
ffffffffc0206c2c:	4c85                	li	s9,1
ffffffffc0206c2e:	e85a                	sd	s6,16(sp)
ffffffffc0206c30:	f026                	sd	s1,32(sp)
ffffffffc0206c32:	7b22                	ld	s6,40(sp)
ffffffffc0206c34:	84ea                	mv	s1,s10
ffffffffc0206c36:	e43e                	sd	a5,8(sp)
ffffffffc0206c38:	8d4a                	mv	s10,s2
ffffffffc0206c3a:	0cfe                	slli	s9,s9,0x1f
ffffffffc0206c3c:	8922                	mv	s2,s0
ffffffffc0206c3e:	ec2a                	sd	a0,24(sp)
ffffffffc0206c40:	7462                	ld	s0,56(sp)
ffffffffc0206c42:	a82d                	j	ffffffffc0206c7c <do_execve+0x6da>
ffffffffc0206c44:	00090797          	auipc	a5,0x90
ffffffffc0206c48:	c6478793          	addi	a5,a5,-924 # ffffffffc02968a8 <pages>
ffffffffc0206c4c:	639c                	ld	a5,0(a5)
ffffffffc0206c4e:	6722                	ld	a4,8(sp)
ffffffffc0206c50:	000c3603          	ld	a2,0(s8)
ffffffffc0206c54:	40f507b3          	sub	a5,a0,a5
ffffffffc0206c58:	8799                	srai	a5,a5,0x6
ffffffffc0206c5a:	97a2                	add	a5,a5,s0
ffffffffc0206c5c:	00e7f5b3          	and	a1,a5,a4
ffffffffc0206c60:	07b2                	slli	a5,a5,0xc
ffffffffc0206c62:	44c5fe63          	bgeu	a1,a2,ffffffffc02070be <do_execve+0xb1c>
ffffffffc0206c66:	000bb503          	ld	a0,0(s7)
ffffffffc0206c6a:	6605                	lui	a2,0x1
ffffffffc0206c6c:	4581                	li	a1,0
ffffffffc0206c6e:	953e                	add	a0,a0,a5
ffffffffc0206c70:	4a9040ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0206c74:	6685                	lui	a3,0x1
ffffffffc0206c76:	94b6                	add	s1,s1,a3
ffffffffc0206c78:	1b948963          	beq	s1,s9,ffffffffc0206e2a <do_execve+0x888>
ffffffffc0206c7c:	018b3503          	ld	a0,24(s6)
ffffffffc0206c80:	4659                	li	a2,22
ffffffffc0206c82:	85a6                	mv	a1,s1
ffffffffc0206c84:	f33fc0ef          	jal	ra,ffffffffc0203bb6 <pgdir_alloc_page>
ffffffffc0206c88:	fd55                	bnez	a0,ffffffffc0206c44 <do_execve+0x6a2>
ffffffffc0206c8a:	844a                	mv	s0,s2
ffffffffc0206c8c:	896a                	mv	s2,s10
ffffffffc0206c8e:	1902                	slli	s2,s2,0x20
ffffffffc0206c90:	6b42                	ld	s6,16(sp)
ffffffffc0206c92:	10010c93          	addi	s9,sp,256
ffffffffc0206c96:	02095913          	srli	s2,s2,0x20
ffffffffc0206c9a:	5871                	li	a6,-4
ffffffffc0206c9c:	b955                	j	ffffffffc0206950 <do_execve+0x3ae>
ffffffffc0206c9e:	f40c0ae3          	beqz	s8,ffffffffc0206bf2 <do_execve+0x650>
ffffffffc0206ca2:	038c0513          	addi	a0,s8,56
ffffffffc0206ca6:	953fd0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0206caa:	5a75                	li	s4,-3
ffffffffc0206cac:	040c2823          	sw	zero,80(s8)
ffffffffc0206cb0:	b465                	j	ffffffffc0206758 <do_execve+0x1b6>
ffffffffc0206cb2:	6b42                	ld	s6,16(sp)
ffffffffc0206cb4:	6462                	ld	s0,24(sp)
ffffffffc0206cb6:	5902                	lw	s2,32(sp)
ffffffffc0206cb8:	5875                	li	a6,-3
ffffffffc0206cba:	b171                	j	ffffffffc0206946 <do_execve+0x3a4>
ffffffffc0206cbc:	85ce                	mv	a1,s3
ffffffffc0206cbe:	00007517          	auipc	a0,0x7
ffffffffc0206cc2:	ec250513          	addi	a0,a0,-318 # ffffffffc020db80 <CSWTCH.79+0x338>
ffffffffc0206cc6:	ce0f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206cca:	bb91                	j	ffffffffc0206a1e <do_execve+0x47c>
ffffffffc0206ccc:	65a2                	ld	a1,8(sp)
ffffffffc0206cce:	866a                	mv	a2,s10
ffffffffc0206cd0:	854e                	mv	a0,s3
ffffffffc0206cd2:	925fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206cd6:	3aad1163          	bne	s10,a0,ffffffffc0207078 <do_execve+0xad6>
ffffffffc0206cda:	67a2                	ld	a5,8(sp)
ffffffffc0206cdc:	10c15683          	lhu	a3,268(sp)
ffffffffc0206ce0:	00478d13          	addi	s10,a5,4
ffffffffc0206ce4:	0006879b          	sext.w	a5,a3
ffffffffc0206ce8:	38078263          	beqz	a5,ffffffffc020706c <do_execve+0xaca>
ffffffffc0206cec:	d04a                	sw	s2,32(sp)
ffffffffc0206cee:	e85a                	sd	s6,16(sp)
ffffffffc0206cf0:	f86e                	sd	s11,48(sp)
ffffffffc0206cf2:	e4a6                	sd	s1,72(sp)
ffffffffc0206cf4:	e8d2                	sd	s4,80(sp)
ffffffffc0206cf6:	ec22                	sd	s0,24(sp)
ffffffffc0206cf8:	896a                	mv	s2,s10
ffffffffc0206cfa:	a801                	j	ffffffffc0206d0a <do_execve+0x768>
ffffffffc0206cfc:	2c85                	addiw	s9,s9,1
ffffffffc0206cfe:	0006879b          	sext.w	a5,a3
ffffffffc0206d02:	04090913          	addi	s2,s2,64
ffffffffc0206d06:	34fcdd63          	bge	s9,a5,ffffffffc0207060 <do_execve+0xabe>
ffffffffc0206d0a:	00092783          	lw	a5,0(s2)
ffffffffc0206d0e:	4709                	li	a4,2
ffffffffc0206d10:	fee796e3          	bne	a5,a4,ffffffffc0206cfc <do_execve+0x75a>
ffffffffc0206d14:	03493783          	ld	a5,52(s2)
ffffffffc0206d18:	4761                	li	a4,24
ffffffffc0206d1a:	fee791e3          	bne	a5,a4,ffffffffc0206cfc <do_execve+0x75a>
ffffffffc0206d1e:	02496783          	lwu	a5,36(s2)
ffffffffc0206d22:	01c93d83          	ld	s11,28(s2)
ffffffffc0206d26:	6722                	ld	a4,8(sp)
ffffffffc0206d28:	079a                	slli	a5,a5,0x6
ffffffffc0206d2a:	856e                	mv	a0,s11
ffffffffc0206d2c:	00f70a33          	add	s4,a4,a5
ffffffffc0206d30:	020a3403          	ld	s0,32(s4)
ffffffffc0206d34:	aeefb0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0206d38:	8b2a                	mv	s6,a0
ffffffffc0206d3a:	e6050be3          	beqz	a0,ffffffffc0206bb0 <do_execve+0x60e>
ffffffffc0206d3e:	8522                	mv	a0,s0
ffffffffc0206d40:	ae2fb0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0206d44:	84aa                	mv	s1,a0
ffffffffc0206d46:	e60505e3          	beqz	a0,ffffffffc0206bb0 <do_execve+0x60e>
ffffffffc0206d4a:	01493583          	ld	a1,20(s2)
ffffffffc0206d4e:	4601                	li	a2,0
ffffffffc0206d50:	854e                	mv	a0,s3
ffffffffc0206d52:	ad3fe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206d56:	87aa                	mv	a5,a0
ffffffffc0206d58:	e945                	bnez	a0,ffffffffc0206e08 <do_execve+0x866>
ffffffffc0206d5a:	866e                	mv	a2,s11
ffffffffc0206d5c:	85da                	mv	a1,s6
ffffffffc0206d5e:	854e                	mv	a0,s3
ffffffffc0206d60:	897fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206d64:	86aa                	mv	a3,a0
ffffffffc0206d66:	02ad8d63          	beq	s11,a0,ffffffffc0206da0 <do_execve+0x7fe>
ffffffffc0206d6a:	875a                	mv	a4,s6
ffffffffc0206d6c:	6462                	ld	s0,24(sp)
ffffffffc0206d6e:	6b42                	ld	s6,16(sp)
ffffffffc0206d70:	5902                	lw	s2,32(sp)
ffffffffc0206d72:	0006879b          	sext.w	a5,a3
ffffffffc0206d76:	0006c363          	bltz	a3,ffffffffc0206d7c <do_execve+0x7da>
ffffffffc0206d7a:	57fd                	li	a5,-1
ffffffffc0206d7c:	853a                	mv	a0,a4
ffffffffc0206d7e:	e83e                	sd	a5,16(sp)
ffffffffc0206d80:	b52fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206d84:	8526                	mv	a0,s1
ffffffffc0206d86:	b4cfb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206d8a:	6522                	ld	a0,8(sp)
ffffffffc0206d8c:	1902                	slli	s2,s2,0x20
ffffffffc0206d8e:	10010c93          	addi	s9,sp,256
ffffffffc0206d92:	b40fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206d96:	67c2                	ld	a5,16(sp)
ffffffffc0206d98:	02095913          	srli	s2,s2,0x20
ffffffffc0206d9c:	8a3e                	mv	s4,a5
ffffffffc0206d9e:	b6d9                	j	ffffffffc0206964 <do_execve+0x3c2>
ffffffffc0206da0:	018a3583          	ld	a1,24(s4)
ffffffffc0206da4:	4601                	li	a2,0
ffffffffc0206da6:	854e                	mv	a0,s3
ffffffffc0206da8:	a7dfe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206dac:	87aa                	mv	a5,a0
ffffffffc0206dae:	ed29                	bnez	a0,ffffffffc0206e08 <do_execve+0x866>
ffffffffc0206db0:	8622                	mv	a2,s0
ffffffffc0206db2:	85a6                	mv	a1,s1
ffffffffc0206db4:	854e                	mv	a0,s3
ffffffffc0206db6:	841fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206dba:	86aa                	mv	a3,a0
ffffffffc0206dbc:	faa417e3          	bne	s0,a0,ffffffffc0206d6a <do_execve+0x7c8>
ffffffffc0206dc0:	47e1                	li	a5,24
ffffffffc0206dc2:	02fdd433          	divu	s0,s11,a5
ffffffffc0206dc6:	47dd                	li	a5,23
ffffffffc0206dc8:	8a5a                	mv	s4,s6
ffffffffc0206dca:	4d01                	li	s10,0
ffffffffc0206dcc:	01b7e763          	bltu	a5,s11,ffffffffc0206dda <do_execve+0x838>
ffffffffc0206dd0:	a089                	j	ffffffffc0206e12 <do_execve+0x870>
ffffffffc0206dd2:	0d05                	addi	s10,s10,1
ffffffffc0206dd4:	0a61                	addi	s4,s4,24
ffffffffc0206dd6:	028d7e63          	bgeu	s10,s0,ffffffffc0206e12 <do_execve+0x870>
ffffffffc0206dda:	000a6503          	lwu	a0,0(s4)
ffffffffc0206dde:	00007597          	auipc	a1,0x7
ffffffffc0206de2:	d4a58593          	addi	a1,a1,-694 # ffffffffc020db28 <CSWTCH.79+0x2e0>
ffffffffc0206de6:	9526                	add	a0,a0,s1
ffffffffc0206de8:	2d7040ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc0206dec:	f17d                	bnez	a0,ffffffffc0206dd2 <do_execve+0x830>
ffffffffc0206dee:	008a3403          	ld	s0,8(s4)
ffffffffc0206df2:	855a                	mv	a0,s6
ffffffffc0206df4:	adefb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206df8:	8526                	mv	a0,s1
ffffffffc0206dfa:	ad8fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206dfe:	2c041d63          	bnez	s0,ffffffffc02070d8 <do_execve+0xb36>
ffffffffc0206e02:	10c15683          	lhu	a3,268(sp)
ffffffffc0206e06:	bddd                	j	ffffffffc0206cfc <do_execve+0x75a>
ffffffffc0206e08:	875a                	mv	a4,s6
ffffffffc0206e0a:	6462                	ld	s0,24(sp)
ffffffffc0206e0c:	6b42                	ld	s6,16(sp)
ffffffffc0206e0e:	5902                	lw	s2,32(sp)
ffffffffc0206e10:	b7b5                	j	ffffffffc0206d7c <do_execve+0x7da>
ffffffffc0206e12:	855a                	mv	a0,s6
ffffffffc0206e14:	abefb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206e18:	8526                	mv	a0,s1
ffffffffc0206e1a:	ab8fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206e1e:	10c15683          	lhu	a3,268(sp)
ffffffffc0206e22:	bde9                	j	ffffffffc0206cfc <do_execve+0x75a>
ffffffffc0206e24:	093c                	addi	a5,sp,152
ffffffffc0206e26:	f83e                	sd	a5,48(sp)
ffffffffc0206e28:	b69d                	j	ffffffffc020698e <do_execve+0x3ec>
ffffffffc0206e2a:	6b42                	ld	s6,16(sp)
ffffffffc0206e2c:	844a                	mv	s0,s2
ffffffffc0206e2e:	896a                	mv	s2,s10
ffffffffc0206e30:	1902                	slli	s2,s2,0x20
ffffffffc0206e32:	02095913          	srli	s2,s2,0x20
ffffffffc0206e36:	10010c93          	addi	s9,sp,256
ffffffffc0206e3a:	016c8633          	add	a2,s9,s6
ffffffffc0206e3e:	00391793          	slli	a5,s2,0x3
ffffffffc0206e42:	40f607b3          	sub	a5,a2,a5
ffffffffc0206e46:	ff8b0713          	addi	a4,s6,-8
ffffffffc0206e4a:	0a0c                	addi	a1,sp,272
ffffffffc0206e4c:	567d                	li	a2,-1
ffffffffc0206e4e:	8d26                	mv	s10,s1
ffffffffc0206e50:	95ba                	add	a1,a1,a4
ffffffffc0206e52:	6862                	ld	a6,24(sp)
ffffffffc0206e54:	7482                	ld	s1,32(sp)
ffffffffc0206e56:	ec3e                	sd	a5,24(sp)
ffffffffc0206e58:	00c65793          	srli	a5,a2,0xc
ffffffffc0206e5c:	e42e                	sd	a1,8(sp)
ffffffffc0206e5e:	f03e                	sd	a5,32(sp)
ffffffffc0206e60:	0c0c                	addi	a1,sp,528
ffffffffc0206e62:	fff68793          	addi	a5,a3,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0206e66:	972e                	add	a4,a4,a1
ffffffffc0206e68:	f83e                	sd	a5,48(sp)
ffffffffc0206e6a:	87ca                	mv	a5,s2
ffffffffc0206e6c:	e83a                	sd	a4,16(sp)
ffffffffc0206e6e:	8922                	mv	s2,s0
ffffffffc0206e70:	e4c2                	sd	a6,72(sp)
ffffffffc0206e72:	846a                	mv	s0,s10
ffffffffc0206e74:	e8a6                	sd	s1,80(sp)
ffffffffc0206e76:	8d3e                	mv	s10,a5
ffffffffc0206e78:	67a2                	ld	a5,8(sp)
ffffffffc0206e7a:	6384                	ld	s1,0(a5)
ffffffffc0206e7c:	8526                	mv	a0,s1
ffffffffc0206e7e:	1f9040ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc0206e82:	00150693          	addi	a3,a0,1
ffffffffc0206e86:	8c15                	sub	s0,s0,a3
ffffffffc0206e88:	ecb6                	sd	a3,88(sp)
ffffffffc0206e8a:	7ff007b7          	lui	a5,0x7ff00
ffffffffc0206e8e:	1cf46563          	bltu	s0,a5,ffffffffc0207058 <do_execve+0xab6>
ffffffffc0206e92:	77a2                	ld	a5,40(sp)
ffffffffc0206e94:	4601                	li	a2,0
ffffffffc0206e96:	85a2                	mv	a1,s0
ffffffffc0206e98:	6f88                	ld	a0,24(a5)
ffffffffc0206e9a:	f0cfb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206e9e:	66e6                	ld	a3,88(sp)
ffffffffc0206ea0:	1e050263          	beqz	a0,ffffffffc0207084 <do_execve+0xae2>
ffffffffc0206ea4:	00090717          	auipc	a4,0x90
ffffffffc0206ea8:	a0470713          	addi	a4,a4,-1532 # ffffffffc02968a8 <pages>
ffffffffc0206eac:	630c                	ld	a1,0(a4)
ffffffffc0206eae:	7762                	ld	a4,56(sp)
ffffffffc0206eb0:	000c3603          	ld	a2,0(s8)
ffffffffc0206eb4:	40b507b3          	sub	a5,a0,a1
ffffffffc0206eb8:	8799                	srai	a5,a5,0x6
ffffffffc0206eba:	97ba                	add	a5,a5,a4
ffffffffc0206ebc:	7702                	ld	a4,32(sp)
ffffffffc0206ebe:	00e7f5b3          	and	a1,a5,a4
ffffffffc0206ec2:	07b2                	slli	a5,a5,0xc
ffffffffc0206ec4:	1ec5fd63          	bgeu	a1,a2,ffffffffc02070be <do_execve+0xb1c>
ffffffffc0206ec8:	000bb583          	ld	a1,0(s7)
ffffffffc0206ecc:	7742                	ld	a4,48(sp)
ffffffffc0206ece:	8636                	mv	a2,a3
ffffffffc0206ed0:	97ae                	add	a5,a5,a1
ffffffffc0206ed2:	00e47533          	and	a0,s0,a4
ffffffffc0206ed6:	953e                	add	a0,a0,a5
ffffffffc0206ed8:	85a6                	mv	a1,s1
ffffffffc0206eda:	291040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0206ede:	6742                	ld	a4,16(sp)
ffffffffc0206ee0:	67a2                	ld	a5,8(sp)
ffffffffc0206ee2:	e300                	sd	s0,0(a4)
ffffffffc0206ee4:	1761                	addi	a4,a4,-8
ffffffffc0206ee6:	e83a                	sd	a4,16(sp)
ffffffffc0206ee8:	6762                	ld	a4,24(sp)
ffffffffc0206eea:	17e1                	addi	a5,a5,-8
ffffffffc0206eec:	e43e                	sd	a5,8(sp)
ffffffffc0206eee:	f8f715e3          	bne	a4,a5,ffffffffc0206e78 <do_execve+0x8d6>
ffffffffc0206ef2:	87ea                	mv	a5,s10
ffffffffc0206ef4:	8d22                	mv	s10,s0
ffffffffc0206ef6:	ff0d7713          	andi	a4,s10,-16
ffffffffc0206efa:	844a                	mv	s0,s2
ffffffffc0206efc:	6826                	ld	a6,72(sp)
ffffffffc0206efe:	893e                	mv	s2,a5
ffffffffc0206f00:	008b0793          	addi	a5,s6,8
ffffffffc0206f04:	40f707b3          	sub	a5,a4,a5
ffffffffc0206f08:	21010313          	addi	t1,sp,528
ffffffffc0206f0c:	e43e                	sd	a5,8(sp)
ffffffffc0206f0e:	6d05                	lui	s10,0x1
ffffffffc0206f10:	406787b3          	sub	a5,a5,t1
ffffffffc0206f14:	ec22                	sd	s0,24(sp)
ffffffffc0206f16:	f04a                	sd	s2,32(sp)
ffffffffc0206f18:	64c6                	ld	s1,80(sp)
ffffffffc0206f1a:	e83e                	sd	a5,16(sp)
ffffffffc0206f1c:	1d7d                	addi	s10,s10,-1
ffffffffc0206f1e:	8442                	mv	s0,a6
ffffffffc0206f20:	891a                	mv	s2,t1
ffffffffc0206f22:	a011                	j	ffffffffc0206f26 <do_execve+0x984>
ffffffffc0206f24:	843e                	mv	s0,a5
ffffffffc0206f26:	77a2                	ld	a5,40(sp)
ffffffffc0206f28:	4601                	li	a2,0
ffffffffc0206f2a:	6f88                	ld	a0,24(a5)
ffffffffc0206f2c:	67c2                	ld	a5,16(sp)
ffffffffc0206f2e:	012785b3          	add	a1,a5,s2
ffffffffc0206f32:	f82e                	sd	a1,48(sp)
ffffffffc0206f34:	e72fb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206f38:	75c2                	ld	a1,48(sp)
ffffffffc0206f3a:	20050363          	beqz	a0,ffffffffc0207140 <do_execve+0xb9e>
ffffffffc0206f3e:	00090717          	auipc	a4,0x90
ffffffffc0206f42:	96a70713          	addi	a4,a4,-1686 # ffffffffc02968a8 <pages>
ffffffffc0206f46:	6314                	ld	a3,0(a4)
ffffffffc0206f48:	000c3703          	ld	a4,0(s8)
ffffffffc0206f4c:	40d507b3          	sub	a5,a0,a3
ffffffffc0206f50:	76e2                	ld	a3,56(sp)
ffffffffc0206f52:	8799                	srai	a5,a5,0x6
ffffffffc0206f54:	97b6                	add	a5,a5,a3
ffffffffc0206f56:	56fd                	li	a3,-1
ffffffffc0206f58:	82b1                	srli	a3,a3,0xc
ffffffffc0206f5a:	8efd                	and	a3,a3,a5
ffffffffc0206f5c:	07b2                	slli	a5,a5,0xc
ffffffffc0206f5e:	16e6f063          	bgeu	a3,a4,ffffffffc02070be <do_execve+0xb1c>
ffffffffc0206f62:	000bb703          	ld	a4,0(s7)
ffffffffc0206f66:	01a5f533          	and	a0,a1,s10
ffffffffc0206f6a:	4621                	li	a2,8
ffffffffc0206f6c:	97ba                	add	a5,a5,a4
ffffffffc0206f6e:	85ca                	mv	a1,s2
ffffffffc0206f70:	953e                	add	a0,a0,a5
ffffffffc0206f72:	1f9040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0206f76:	0921                	addi	s2,s2,8
ffffffffc0206f78:	0014079b          	addiw	a5,s0,1
ffffffffc0206f7c:	fa9444e3          	blt	s0,s1,ffffffffc0206f24 <do_execve+0x982>
ffffffffc0206f80:	77a2                	ld	a5,40(sp)
ffffffffc0206f82:	4601                	li	a2,0
ffffffffc0206f84:	6462                	ld	s0,24(sp)
ffffffffc0206f86:	6f88                	ld	a0,24(a5)
ffffffffc0206f88:	67a2                	ld	a5,8(sp)
ffffffffc0206f8a:	7902                	ld	s2,32(sp)
ffffffffc0206f8c:	e502                	sd	zero,136(sp)
ffffffffc0206f8e:	00fb04b3          	add	s1,s6,a5
ffffffffc0206f92:	85a6                	mv	a1,s1
ffffffffc0206f94:	e12fb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206f98:	18050463          	beqz	a0,ffffffffc0207120 <do_execve+0xb7e>
ffffffffc0206f9c:	b6bfe0ef          	jal	ra,ffffffffc0205b06 <page2kva>
ffffffffc0206fa0:	01a4f4b3          	and	s1,s1,s10
ffffffffc0206fa4:	4621                	li	a2,8
ffffffffc0206fa6:	012c                	addi	a1,sp,136
ffffffffc0206fa8:	9526                	add	a0,a0,s1
ffffffffc0206faa:	1c1040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0206fae:	77a2                	ld	a5,40(sp)
ffffffffc0206fb0:	4601                	li	a2,0
ffffffffc0206fb2:	6f88                	ld	a0,24(a5)
ffffffffc0206fb4:	67a2                	ld	a5,8(sp)
ffffffffc0206fb6:	c56e                	sw	s11,136(sp)
ffffffffc0206fb8:	ffc78493          	addi	s1,a5,-4 # 7feffffc <_binary_bin_sfs_img_size+0x7fe8acfc>
ffffffffc0206fbc:	85a6                	mv	a1,s1
ffffffffc0206fbe:	de8fb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206fc2:	12050f63          	beqz	a0,ffffffffc0207100 <do_execve+0xb5e>
ffffffffc0206fc6:	b41fe0ef          	jal	ra,ffffffffc0205b06 <page2kva>
ffffffffc0206fca:	01a4f4b3          	and	s1,s1,s10
ffffffffc0206fce:	4611                	li	a2,4
ffffffffc0206fd0:	012c                	addi	a1,sp,136
ffffffffc0206fd2:	9526                	add	a0,a0,s1
ffffffffc0206fd4:	197040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0206fd8:	77a2                	ld	a5,40(sp)
ffffffffc0206fda:	4705                	li	a4,1
ffffffffc0206fdc:	000ab603          	ld	a2,0(s5)
ffffffffc0206fe0:	db98                	sw	a4,48(a5)
ffffffffc0206fe2:	6722                	ld	a4,8(sp)
ffffffffc0206fe4:	6f94                	ld	a3,24(a5)
ffffffffc0206fe6:	f61c                	sd	a5,40(a2)
ffffffffc0206fe8:	f7c70c13          	addi	s8,a4,-132
ffffffffc0206fec:	c0200737          	lui	a4,0xc0200
ffffffffc0206ff0:	ff0c7c13          	andi	s8,s8,-16
ffffffffc0206ff4:	0ee6ea63          	bltu	a3,a4,ffffffffc02070e8 <do_execve+0xb46>
ffffffffc0206ff8:	000bb703          	ld	a4,0(s7)
ffffffffc0206ffc:	57fd                	li	a5,-1
ffffffffc0206ffe:	03f79d93          	slli	s11,a5,0x3f
ffffffffc0207002:	8e99                	sub	a3,a3,a4
ffffffffc0207004:	00c6d713          	srli	a4,a3,0xc
ffffffffc0207008:	f654                	sd	a3,168(a2)
ffffffffc020700a:	01b76db3          	or	s11,a4,s11
ffffffffc020700e:	180d9073          	csrw	satp,s11
ffffffffc0207012:	12000073          	sfence.vma
ffffffffc0207016:	000ab703          	ld	a4,0(s5)
ffffffffc020701a:	12000613          	li	a2,288
ffffffffc020701e:	4581                	li	a1,0
ffffffffc0207020:	7344                	ld	s1,160(a4)
ffffffffc0207022:	8526                	mv	a0,s1
ffffffffc0207024:	0f5040ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0207028:	67a2                	ld	a5,8(sp)
ffffffffc020702a:	0184b823          	sd	s8,16(s1)
ffffffffc020702e:	e8a0                	sd	s0,80(s1)
ffffffffc0207030:	ecbc                	sd	a5,88(s1)
ffffffffc0207032:	6786                	ld	a5,64(sp)
ffffffffc0207034:	c391                	beqz	a5,ffffffffc0207038 <do_execve+0xa96>
ffffffffc0207036:	ec9c                	sd	a5,24(s1)
ffffffffc0207038:	10002773          	csrr	a4,sstatus
ffffffffc020703c:	edf77713          	andi	a4,a4,-289
ffffffffc0207040:	02076713          	ori	a4,a4,32
ffffffffc0207044:	10e4b023          	sd	a4,256(s1)
ffffffffc0207048:	772e                	ld	a4,232(sp)
ffffffffc020704a:	854e                	mv	a0,s3
ffffffffc020704c:	10e4b423          	sd	a4,264(s1)
ffffffffc0207050:	da2fe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc0207054:	eccff06f          	j	ffffffffc0206720 <do_execve+0x17e>
ffffffffc0207058:	844a                	mv	s0,s2
ffffffffc020705a:	5871                	li	a6,-4
ffffffffc020705c:	896a                	mv	s2,s10
ffffffffc020705e:	b8cd                	j	ffffffffc0206950 <do_execve+0x3ae>
ffffffffc0207060:	6b42                	ld	s6,16(sp)
ffffffffc0207062:	7dc2                	ld	s11,48(sp)
ffffffffc0207064:	64a6                	ld	s1,72(sp)
ffffffffc0207066:	6a46                	ld	s4,80(sp)
ffffffffc0207068:	6462                	ld	s0,24(sp)
ffffffffc020706a:	5902                	lw	s2,32(sp)
ffffffffc020706c:	e082                	sd	zero,64(sp)
ffffffffc020706e:	6522                	ld	a0,8(sp)
ffffffffc0207070:	862fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0207074:	877ff06f          	j	ffffffffc02068ea <do_execve+0x348>
ffffffffc0207078:	00050c9b          	sext.w	s9,a0
ffffffffc020707c:	b0054be3          	bltz	a0,ffffffffc0206b92 <do_execve+0x5f0>
ffffffffc0207080:	5cfd                	li	s9,-1
ffffffffc0207082:	be01                	j	ffffffffc0206b92 <do_execve+0x5f0>
ffffffffc0207084:	00006697          	auipc	a3,0x6
ffffffffc0207088:	07468693          	addi	a3,a3,116 # ffffffffc020d0f8 <default_pmm_manager+0x7d8>
ffffffffc020708c:	00005617          	auipc	a2,0x5
ffffffffc0207090:	d7460613          	addi	a2,a2,-652 # ffffffffc020be00 <commands+0x210>
ffffffffc0207094:	3ae00593          	li	a1,942
ffffffffc0207098:	00007517          	auipc	a0,0x7
ffffffffc020709c:	8a050513          	addi	a0,a0,-1888 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc02070a0:	bfef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02070a4:	86aa                	mv	a3,a0
ffffffffc02070a6:	00006617          	auipc	a2,0x6
ffffffffc02070aa:	8b260613          	addi	a2,a2,-1870 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02070ae:	07100593          	li	a1,113
ffffffffc02070b2:	00006517          	auipc	a0,0x6
ffffffffc02070b6:	8ce50513          	addi	a0,a0,-1842 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02070ba:	be4f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02070be:	86be                	mv	a3,a5
ffffffffc02070c0:	00006617          	auipc	a2,0x6
ffffffffc02070c4:	89860613          	addi	a2,a2,-1896 # ffffffffc020c958 <default_pmm_manager+0x38>
ffffffffc02070c8:	07100593          	li	a1,113
ffffffffc02070cc:	00006517          	auipc	a0,0x6
ffffffffc02070d0:	8b450513          	addi	a0,a0,-1868 # ffffffffc020c980 <default_pmm_manager+0x60>
ffffffffc02070d4:	bcaf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02070d8:	e0a2                	sd	s0,64(sp)
ffffffffc02070da:	6b42                	ld	s6,16(sp)
ffffffffc02070dc:	7dc2                	ld	s11,48(sp)
ffffffffc02070de:	64a6                	ld	s1,72(sp)
ffffffffc02070e0:	6a46                	ld	s4,80(sp)
ffffffffc02070e2:	6462                	ld	s0,24(sp)
ffffffffc02070e4:	5902                	lw	s2,32(sp)
ffffffffc02070e6:	b761                	j	ffffffffc020706e <do_execve+0xacc>
ffffffffc02070e8:	00006617          	auipc	a2,0x6
ffffffffc02070ec:	91860613          	addi	a2,a2,-1768 # ffffffffc020ca00 <default_pmm_manager+0xe0>
ffffffffc02070f0:	3d600593          	li	a1,982
ffffffffc02070f4:	00007517          	auipc	a0,0x7
ffffffffc02070f8:	84450513          	addi	a0,a0,-1980 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc02070fc:	ba2f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207100:	00006697          	auipc	a3,0x6
ffffffffc0207104:	ff868693          	addi	a3,a3,-8 # ffffffffc020d0f8 <default_pmm_manager+0x7d8>
ffffffffc0207108:	00005617          	auipc	a2,0x5
ffffffffc020710c:	cf860613          	addi	a2,a2,-776 # ffffffffc020be00 <commands+0x210>
ffffffffc0207110:	3cb00593          	li	a1,971
ffffffffc0207114:	00007517          	auipc	a0,0x7
ffffffffc0207118:	82450513          	addi	a0,a0,-2012 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020711c:	b82f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207120:	00006697          	auipc	a3,0x6
ffffffffc0207124:	fd868693          	addi	a3,a3,-40 # ffffffffc020d0f8 <default_pmm_manager+0x7d8>
ffffffffc0207128:	00005617          	auipc	a2,0x5
ffffffffc020712c:	cd860613          	addi	a2,a2,-808 # ffffffffc020be00 <commands+0x210>
ffffffffc0207130:	3c300593          	li	a1,963
ffffffffc0207134:	00007517          	auipc	a0,0x7
ffffffffc0207138:	80450513          	addi	a0,a0,-2044 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020713c:	b62f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207140:	00006697          	auipc	a3,0x6
ffffffffc0207144:	fb868693          	addi	a3,a3,-72 # ffffffffc020d0f8 <default_pmm_manager+0x7d8>
ffffffffc0207148:	00005617          	auipc	a2,0x5
ffffffffc020714c:	cb860613          	addi	a2,a2,-840 # ffffffffc020be00 <commands+0x210>
ffffffffc0207150:	3bc00593          	li	a1,956
ffffffffc0207154:	00006517          	auipc	a0,0x6
ffffffffc0207158:	7e450513          	addi	a0,a0,2020 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020715c:	b42f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207160 <user_main>:
ffffffffc0207160:	7179                	addi	sp,sp,-48
ffffffffc0207162:	e84a                	sd	s2,16(sp)
ffffffffc0207164:	0008f917          	auipc	s2,0x8f
ffffffffc0207168:	75c90913          	addi	s2,s2,1884 # ffffffffc02968c0 <current>
ffffffffc020716c:	00093783          	ld	a5,0(s2)
ffffffffc0207170:	00007617          	auipc	a2,0x7
ffffffffc0207174:	a7060613          	addi	a2,a2,-1424 # ffffffffc020dbe0 <CSWTCH.79+0x398>
ffffffffc0207178:	00007517          	auipc	a0,0x7
ffffffffc020717c:	a7050513          	addi	a0,a0,-1424 # ffffffffc020dbe8 <CSWTCH.79+0x3a0>
ffffffffc0207180:	43cc                	lw	a1,4(a5)
ffffffffc0207182:	f406                	sd	ra,40(sp)
ffffffffc0207184:	f022                	sd	s0,32(sp)
ffffffffc0207186:	ec26                	sd	s1,24(sp)
ffffffffc0207188:	e032                	sd	a2,0(sp)
ffffffffc020718a:	e402                	sd	zero,8(sp)
ffffffffc020718c:	81af90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207190:	6782                	ld	a5,0(sp)
ffffffffc0207192:	cfb9                	beqz	a5,ffffffffc02071f0 <user_main+0x90>
ffffffffc0207194:	003c                	addi	a5,sp,8
ffffffffc0207196:	4401                	li	s0,0
ffffffffc0207198:	6398                	ld	a4,0(a5)
ffffffffc020719a:	0405                	addi	s0,s0,1
ffffffffc020719c:	07a1                	addi	a5,a5,8
ffffffffc020719e:	ff6d                	bnez	a4,ffffffffc0207198 <user_main+0x38>
ffffffffc02071a0:	00093783          	ld	a5,0(s2)
ffffffffc02071a4:	12000613          	li	a2,288
ffffffffc02071a8:	6b84                	ld	s1,16(a5)
ffffffffc02071aa:	73cc                	ld	a1,160(a5)
ffffffffc02071ac:	6789                	lui	a5,0x2
ffffffffc02071ae:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc02071b2:	94be                	add	s1,s1,a5
ffffffffc02071b4:	8526                	mv	a0,s1
ffffffffc02071b6:	7b4040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc02071ba:	00093783          	ld	a5,0(s2)
ffffffffc02071be:	860a                	mv	a2,sp
ffffffffc02071c0:	0004059b          	sext.w	a1,s0
ffffffffc02071c4:	f3c4                	sd	s1,160(a5)
ffffffffc02071c6:	00007517          	auipc	a0,0x7
ffffffffc02071ca:	a1a50513          	addi	a0,a0,-1510 # ffffffffc020dbe0 <CSWTCH.79+0x398>
ffffffffc02071ce:	bd4ff0ef          	jal	ra,ffffffffc02065a2 <do_execve>
ffffffffc02071d2:	8126                	mv	sp,s1
ffffffffc02071d4:	910fa06f          	j	ffffffffc02012e4 <__trapret>
ffffffffc02071d8:	00007617          	auipc	a2,0x7
ffffffffc02071dc:	a3860613          	addi	a2,a2,-1480 # ffffffffc020dc10 <CSWTCH.79+0x3c8>
ffffffffc02071e0:	4ff00593          	li	a1,1279
ffffffffc02071e4:	00006517          	auipc	a0,0x6
ffffffffc02071e8:	75450513          	addi	a0,a0,1876 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc02071ec:	ab2f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02071f0:	4401                	li	s0,0
ffffffffc02071f2:	b77d                	j	ffffffffc02071a0 <user_main+0x40>

ffffffffc02071f4 <do_yield>:
ffffffffc02071f4:	0008f797          	auipc	a5,0x8f
ffffffffc02071f8:	6cc7b783          	ld	a5,1740(a5) # ffffffffc02968c0 <current>
ffffffffc02071fc:	4705                	li	a4,1
ffffffffc02071fe:	ef98                	sd	a4,24(a5)
ffffffffc0207200:	4501                	li	a0,0
ffffffffc0207202:	8082                	ret

ffffffffc0207204 <do_wait>:
ffffffffc0207204:	1101                	addi	sp,sp,-32
ffffffffc0207206:	e822                	sd	s0,16(sp)
ffffffffc0207208:	e426                	sd	s1,8(sp)
ffffffffc020720a:	ec06                	sd	ra,24(sp)
ffffffffc020720c:	842e                	mv	s0,a1
ffffffffc020720e:	84aa                	mv	s1,a0
ffffffffc0207210:	c999                	beqz	a1,ffffffffc0207226 <do_wait+0x22>
ffffffffc0207212:	0008f797          	auipc	a5,0x8f
ffffffffc0207216:	6ae7b783          	ld	a5,1710(a5) # ffffffffc02968c0 <current>
ffffffffc020721a:	7788                	ld	a0,40(a5)
ffffffffc020721c:	4685                	li	a3,1
ffffffffc020721e:	4611                	li	a2,4
ffffffffc0207220:	906fd0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc0207224:	c909                	beqz	a0,ffffffffc0207236 <do_wait+0x32>
ffffffffc0207226:	85a2                	mv	a1,s0
ffffffffc0207228:	6442                	ld	s0,16(sp)
ffffffffc020722a:	60e2                	ld	ra,24(sp)
ffffffffc020722c:	8526                	mv	a0,s1
ffffffffc020722e:	64a2                	ld	s1,8(sp)
ffffffffc0207230:	6105                	addi	sp,sp,32
ffffffffc0207232:	84eff06f          	j	ffffffffc0206280 <do_wait.part.0>
ffffffffc0207236:	60e2                	ld	ra,24(sp)
ffffffffc0207238:	6442                	ld	s0,16(sp)
ffffffffc020723a:	64a2                	ld	s1,8(sp)
ffffffffc020723c:	5575                	li	a0,-3
ffffffffc020723e:	6105                	addi	sp,sp,32
ffffffffc0207240:	8082                	ret

ffffffffc0207242 <do_kill>:
ffffffffc0207242:	1141                	addi	sp,sp,-16
ffffffffc0207244:	6789                	lui	a5,0x2
ffffffffc0207246:	e406                	sd	ra,8(sp)
ffffffffc0207248:	e022                	sd	s0,0(sp)
ffffffffc020724a:	fff5071b          	addiw	a4,a0,-1
ffffffffc020724e:	17f9                	addi	a5,a5,-2
ffffffffc0207250:	02e7e963          	bltu	a5,a4,ffffffffc0207282 <do_kill+0x40>
ffffffffc0207254:	842a                	mv	s0,a0
ffffffffc0207256:	45a9                	li	a1,10
ffffffffc0207258:	2501                	sext.w	a0,a0
ffffffffc020725a:	18a040ef          	jal	ra,ffffffffc020b3e4 <hash32>
ffffffffc020725e:	02051793          	slli	a5,a0,0x20
ffffffffc0207262:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0207266:	0008a797          	auipc	a5,0x8a
ffffffffc020726a:	55a78793          	addi	a5,a5,1370 # ffffffffc02917c0 <hash_list>
ffffffffc020726e:	953e                	add	a0,a0,a5
ffffffffc0207270:	87aa                	mv	a5,a0
ffffffffc0207272:	a029                	j	ffffffffc020727c <do_kill+0x3a>
ffffffffc0207274:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0207278:	00870b63          	beq	a4,s0,ffffffffc020728e <do_kill+0x4c>
ffffffffc020727c:	679c                	ld	a5,8(a5)
ffffffffc020727e:	fef51be3          	bne	a0,a5,ffffffffc0207274 <do_kill+0x32>
ffffffffc0207282:	5475                	li	s0,-3
ffffffffc0207284:	60a2                	ld	ra,8(sp)
ffffffffc0207286:	8522                	mv	a0,s0
ffffffffc0207288:	6402                	ld	s0,0(sp)
ffffffffc020728a:	0141                	addi	sp,sp,16
ffffffffc020728c:	8082                	ret
ffffffffc020728e:	fd87a703          	lw	a4,-40(a5)
ffffffffc0207292:	00177693          	andi	a3,a4,1
ffffffffc0207296:	e295                	bnez	a3,ffffffffc02072ba <do_kill+0x78>
ffffffffc0207298:	4bd4                	lw	a3,20(a5)
ffffffffc020729a:	00176713          	ori	a4,a4,1
ffffffffc020729e:	fce7ac23          	sw	a4,-40(a5)
ffffffffc02072a2:	4401                	li	s0,0
ffffffffc02072a4:	fe06d0e3          	bgez	a3,ffffffffc0207284 <do_kill+0x42>
ffffffffc02072a8:	f2878513          	addi	a0,a5,-216
ffffffffc02072ac:	45a000ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc02072b0:	60a2                	ld	ra,8(sp)
ffffffffc02072b2:	8522                	mv	a0,s0
ffffffffc02072b4:	6402                	ld	s0,0(sp)
ffffffffc02072b6:	0141                	addi	sp,sp,16
ffffffffc02072b8:	8082                	ret
ffffffffc02072ba:	545d                	li	s0,-9
ffffffffc02072bc:	b7e1                	j	ffffffffc0207284 <do_kill+0x42>

ffffffffc02072be <proc_init>:
ffffffffc02072be:	1101                	addi	sp,sp,-32
ffffffffc02072c0:	e426                	sd	s1,8(sp)
ffffffffc02072c2:	0008e797          	auipc	a5,0x8e
ffffffffc02072c6:	4fe78793          	addi	a5,a5,1278 # ffffffffc02957c0 <proc_list>
ffffffffc02072ca:	ec06                	sd	ra,24(sp)
ffffffffc02072cc:	e822                	sd	s0,16(sp)
ffffffffc02072ce:	e04a                	sd	s2,0(sp)
ffffffffc02072d0:	0008a497          	auipc	s1,0x8a
ffffffffc02072d4:	4f048493          	addi	s1,s1,1264 # ffffffffc02917c0 <hash_list>
ffffffffc02072d8:	e79c                	sd	a5,8(a5)
ffffffffc02072da:	e39c                	sd	a5,0(a5)
ffffffffc02072dc:	0008e717          	auipc	a4,0x8e
ffffffffc02072e0:	4e470713          	addi	a4,a4,1252 # ffffffffc02957c0 <proc_list>
ffffffffc02072e4:	87a6                	mv	a5,s1
ffffffffc02072e6:	e79c                	sd	a5,8(a5)
ffffffffc02072e8:	e39c                	sd	a5,0(a5)
ffffffffc02072ea:	07c1                	addi	a5,a5,16
ffffffffc02072ec:	fef71de3          	bne	a4,a5,ffffffffc02072e6 <proc_init+0x28>
ffffffffc02072f0:	f7cfe0ef          	jal	ra,ffffffffc0205a6c <alloc_proc>
ffffffffc02072f4:	0008f917          	auipc	s2,0x8f
ffffffffc02072f8:	5d490913          	addi	s2,s2,1492 # ffffffffc02968c8 <idleproc>
ffffffffc02072fc:	00a93023          	sd	a0,0(s2)
ffffffffc0207300:	842a                	mv	s0,a0
ffffffffc0207302:	12050863          	beqz	a0,ffffffffc0207432 <proc_init+0x174>
ffffffffc0207306:	4789                	li	a5,2
ffffffffc0207308:	e11c                	sd	a5,0(a0)
ffffffffc020730a:	0000a797          	auipc	a5,0xa
ffffffffc020730e:	cf678793          	addi	a5,a5,-778 # ffffffffc0211000 <bootstack>
ffffffffc0207312:	e91c                	sd	a5,16(a0)
ffffffffc0207314:	4785                	li	a5,1
ffffffffc0207316:	ed1c                	sd	a5,24(a0)
ffffffffc0207318:	f4ffd0ef          	jal	ra,ffffffffc0205266 <files_create>
ffffffffc020731c:	14a43423          	sd	a0,328(s0)
ffffffffc0207320:	0e050d63          	beqz	a0,ffffffffc020741a <proc_init+0x15c>
ffffffffc0207324:	00093403          	ld	s0,0(s2)
ffffffffc0207328:	4641                	li	a2,16
ffffffffc020732a:	4581                	li	a1,0
ffffffffc020732c:	14843703          	ld	a4,328(s0)
ffffffffc0207330:	0b440413          	addi	s0,s0,180
ffffffffc0207334:	8522                	mv	a0,s0
ffffffffc0207336:	4b1c                	lw	a5,16(a4)
ffffffffc0207338:	2785                	addiw	a5,a5,1
ffffffffc020733a:	cb1c                	sw	a5,16(a4)
ffffffffc020733c:	5dc040ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0207340:	463d                	li	a2,15
ffffffffc0207342:	00007597          	auipc	a1,0x7
ffffffffc0207346:	92e58593          	addi	a1,a1,-1746 # ffffffffc020dc70 <CSWTCH.79+0x428>
ffffffffc020734a:	8522                	mv	a0,s0
ffffffffc020734c:	61e040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc0207350:	0008f717          	auipc	a4,0x8f
ffffffffc0207354:	58870713          	addi	a4,a4,1416 # ffffffffc02968d8 <nr_process>
ffffffffc0207358:	431c                	lw	a5,0(a4)
ffffffffc020735a:	00093683          	ld	a3,0(s2)
ffffffffc020735e:	4601                	li	a2,0
ffffffffc0207360:	2785                	addiw	a5,a5,1
ffffffffc0207362:	4581                	li	a1,0
ffffffffc0207364:	fffff517          	auipc	a0,0xfffff
ffffffffc0207368:	0ee50513          	addi	a0,a0,238 # ffffffffc0206452 <init_main>
ffffffffc020736c:	c31c                	sw	a5,0(a4)
ffffffffc020736e:	0008f797          	auipc	a5,0x8f
ffffffffc0207372:	54d7b923          	sd	a3,1362(a5) # ffffffffc02968c0 <current>
ffffffffc0207376:	d59fe0ef          	jal	ra,ffffffffc02060ce <kernel_thread>
ffffffffc020737a:	842a                	mv	s0,a0
ffffffffc020737c:	08a05363          	blez	a0,ffffffffc0207402 <proc_init+0x144>
ffffffffc0207380:	6789                	lui	a5,0x2
ffffffffc0207382:	fff5071b          	addiw	a4,a0,-1
ffffffffc0207386:	17f9                	addi	a5,a5,-2
ffffffffc0207388:	2501                	sext.w	a0,a0
ffffffffc020738a:	02e7e363          	bltu	a5,a4,ffffffffc02073b0 <proc_init+0xf2>
ffffffffc020738e:	45a9                	li	a1,10
ffffffffc0207390:	054040ef          	jal	ra,ffffffffc020b3e4 <hash32>
ffffffffc0207394:	02051793          	slli	a5,a0,0x20
ffffffffc0207398:	01c7d693          	srli	a3,a5,0x1c
ffffffffc020739c:	96a6                	add	a3,a3,s1
ffffffffc020739e:	87b6                	mv	a5,a3
ffffffffc02073a0:	a029                	j	ffffffffc02073aa <proc_init+0xec>
ffffffffc02073a2:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc02073a6:	04870b63          	beq	a4,s0,ffffffffc02073fc <proc_init+0x13e>
ffffffffc02073aa:	679c                	ld	a5,8(a5)
ffffffffc02073ac:	fef69be3          	bne	a3,a5,ffffffffc02073a2 <proc_init+0xe4>
ffffffffc02073b0:	4781                	li	a5,0
ffffffffc02073b2:	0b478493          	addi	s1,a5,180
ffffffffc02073b6:	4641                	li	a2,16
ffffffffc02073b8:	4581                	li	a1,0
ffffffffc02073ba:	0008f417          	auipc	s0,0x8f
ffffffffc02073be:	51640413          	addi	s0,s0,1302 # ffffffffc02968d0 <initproc>
ffffffffc02073c2:	8526                	mv	a0,s1
ffffffffc02073c4:	e01c                	sd	a5,0(s0)
ffffffffc02073c6:	552040ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc02073ca:	463d                	li	a2,15
ffffffffc02073cc:	00007597          	auipc	a1,0x7
ffffffffc02073d0:	8cc58593          	addi	a1,a1,-1844 # ffffffffc020dc98 <CSWTCH.79+0x450>
ffffffffc02073d4:	8526                	mv	a0,s1
ffffffffc02073d6:	594040ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc02073da:	00093783          	ld	a5,0(s2)
ffffffffc02073de:	c7d1                	beqz	a5,ffffffffc020746a <proc_init+0x1ac>
ffffffffc02073e0:	43dc                	lw	a5,4(a5)
ffffffffc02073e2:	e7c1                	bnez	a5,ffffffffc020746a <proc_init+0x1ac>
ffffffffc02073e4:	601c                	ld	a5,0(s0)
ffffffffc02073e6:	c3b5                	beqz	a5,ffffffffc020744a <proc_init+0x18c>
ffffffffc02073e8:	43d8                	lw	a4,4(a5)
ffffffffc02073ea:	4785                	li	a5,1
ffffffffc02073ec:	04f71f63          	bne	a4,a5,ffffffffc020744a <proc_init+0x18c>
ffffffffc02073f0:	60e2                	ld	ra,24(sp)
ffffffffc02073f2:	6442                	ld	s0,16(sp)
ffffffffc02073f4:	64a2                	ld	s1,8(sp)
ffffffffc02073f6:	6902                	ld	s2,0(sp)
ffffffffc02073f8:	6105                	addi	sp,sp,32
ffffffffc02073fa:	8082                	ret
ffffffffc02073fc:	f2878793          	addi	a5,a5,-216
ffffffffc0207400:	bf4d                	j	ffffffffc02073b2 <proc_init+0xf4>
ffffffffc0207402:	00007617          	auipc	a2,0x7
ffffffffc0207406:	87660613          	addi	a2,a2,-1930 # ffffffffc020dc78 <CSWTCH.79+0x430>
ffffffffc020740a:	54b00593          	li	a1,1355
ffffffffc020740e:	00006517          	auipc	a0,0x6
ffffffffc0207412:	52a50513          	addi	a0,a0,1322 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc0207416:	888f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020741a:	00007617          	auipc	a2,0x7
ffffffffc020741e:	82e60613          	addi	a2,a2,-2002 # ffffffffc020dc48 <CSWTCH.79+0x400>
ffffffffc0207422:	53f00593          	li	a1,1343
ffffffffc0207426:	00006517          	auipc	a0,0x6
ffffffffc020742a:	51250513          	addi	a0,a0,1298 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc020742e:	870f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207432:	00006617          	auipc	a2,0x6
ffffffffc0207436:	7fe60613          	addi	a2,a2,2046 # ffffffffc020dc30 <CSWTCH.79+0x3e8>
ffffffffc020743a:	53500593          	li	a1,1333
ffffffffc020743e:	00006517          	auipc	a0,0x6
ffffffffc0207442:	4fa50513          	addi	a0,a0,1274 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc0207446:	858f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020744a:	00007697          	auipc	a3,0x7
ffffffffc020744e:	87e68693          	addi	a3,a3,-1922 # ffffffffc020dcc8 <CSWTCH.79+0x480>
ffffffffc0207452:	00005617          	auipc	a2,0x5
ffffffffc0207456:	9ae60613          	addi	a2,a2,-1618 # ffffffffc020be00 <commands+0x210>
ffffffffc020745a:	55200593          	li	a1,1362
ffffffffc020745e:	00006517          	auipc	a0,0x6
ffffffffc0207462:	4da50513          	addi	a0,a0,1242 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc0207466:	838f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020746a:	00007697          	auipc	a3,0x7
ffffffffc020746e:	83668693          	addi	a3,a3,-1994 # ffffffffc020dca0 <CSWTCH.79+0x458>
ffffffffc0207472:	00005617          	auipc	a2,0x5
ffffffffc0207476:	98e60613          	addi	a2,a2,-1650 # ffffffffc020be00 <commands+0x210>
ffffffffc020747a:	55100593          	li	a1,1361
ffffffffc020747e:	00006517          	auipc	a0,0x6
ffffffffc0207482:	4ba50513          	addi	a0,a0,1210 # ffffffffc020d938 <CSWTCH.79+0xf0>
ffffffffc0207486:	818f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020748a <cpu_idle>:
ffffffffc020748a:	1141                	addi	sp,sp,-16
ffffffffc020748c:	e022                	sd	s0,0(sp)
ffffffffc020748e:	e406                	sd	ra,8(sp)
ffffffffc0207490:	0008f417          	auipc	s0,0x8f
ffffffffc0207494:	43040413          	addi	s0,s0,1072 # ffffffffc02968c0 <current>
ffffffffc0207498:	6018                	ld	a4,0(s0)
ffffffffc020749a:	6f1c                	ld	a5,24(a4)
ffffffffc020749c:	dffd                	beqz	a5,ffffffffc020749a <cpu_idle+0x10>
ffffffffc020749e:	31a000ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc02074a2:	bfdd                	j	ffffffffc0207498 <cpu_idle+0xe>

ffffffffc02074a4 <lab6_set_priority>:
ffffffffc02074a4:	1141                	addi	sp,sp,-16
ffffffffc02074a6:	e022                	sd	s0,0(sp)
ffffffffc02074a8:	85aa                	mv	a1,a0
ffffffffc02074aa:	842a                	mv	s0,a0
ffffffffc02074ac:	00007517          	auipc	a0,0x7
ffffffffc02074b0:	84450513          	addi	a0,a0,-1980 # ffffffffc020dcf0 <CSWTCH.79+0x4a8>
ffffffffc02074b4:	e406                	sd	ra,8(sp)
ffffffffc02074b6:	cf1f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02074ba:	0008f797          	auipc	a5,0x8f
ffffffffc02074be:	4067b783          	ld	a5,1030(a5) # ffffffffc02968c0 <current>
ffffffffc02074c2:	e801                	bnez	s0,ffffffffc02074d2 <lab6_set_priority+0x2e>
ffffffffc02074c4:	60a2                	ld	ra,8(sp)
ffffffffc02074c6:	6402                	ld	s0,0(sp)
ffffffffc02074c8:	4705                	li	a4,1
ffffffffc02074ca:	14e7a223          	sw	a4,324(a5)
ffffffffc02074ce:	0141                	addi	sp,sp,16
ffffffffc02074d0:	8082                	ret
ffffffffc02074d2:	60a2                	ld	ra,8(sp)
ffffffffc02074d4:	1487a223          	sw	s0,324(a5)
ffffffffc02074d8:	6402                	ld	s0,0(sp)
ffffffffc02074da:	0141                	addi	sp,sp,16
ffffffffc02074dc:	8082                	ret

ffffffffc02074de <do_sleep>:
ffffffffc02074de:	c539                	beqz	a0,ffffffffc020752c <do_sleep+0x4e>
ffffffffc02074e0:	7179                	addi	sp,sp,-48
ffffffffc02074e2:	f022                	sd	s0,32(sp)
ffffffffc02074e4:	f406                	sd	ra,40(sp)
ffffffffc02074e6:	842a                	mv	s0,a0
ffffffffc02074e8:	100027f3          	csrr	a5,sstatus
ffffffffc02074ec:	8b89                	andi	a5,a5,2
ffffffffc02074ee:	e3a9                	bnez	a5,ffffffffc0207530 <do_sleep+0x52>
ffffffffc02074f0:	0008f797          	auipc	a5,0x8f
ffffffffc02074f4:	3d07b783          	ld	a5,976(a5) # ffffffffc02968c0 <current>
ffffffffc02074f8:	0818                	addi	a4,sp,16
ffffffffc02074fa:	c02a                	sw	a0,0(sp)
ffffffffc02074fc:	ec3a                	sd	a4,24(sp)
ffffffffc02074fe:	e83a                	sd	a4,16(sp)
ffffffffc0207500:	e43e                	sd	a5,8(sp)
ffffffffc0207502:	4705                	li	a4,1
ffffffffc0207504:	c398                	sw	a4,0(a5)
ffffffffc0207506:	80000737          	lui	a4,0x80000
ffffffffc020750a:	840a                	mv	s0,sp
ffffffffc020750c:	0709                	addi	a4,a4,2
ffffffffc020750e:	0ee7a623          	sw	a4,236(a5)
ffffffffc0207512:	8522                	mv	a0,s0
ffffffffc0207514:	364000ef          	jal	ra,ffffffffc0207878 <add_timer>
ffffffffc0207518:	2a0000ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc020751c:	8522                	mv	a0,s0
ffffffffc020751e:	422000ef          	jal	ra,ffffffffc0207940 <del_timer>
ffffffffc0207522:	70a2                	ld	ra,40(sp)
ffffffffc0207524:	7402                	ld	s0,32(sp)
ffffffffc0207526:	4501                	li	a0,0
ffffffffc0207528:	6145                	addi	sp,sp,48
ffffffffc020752a:	8082                	ret
ffffffffc020752c:	4501                	li	a0,0
ffffffffc020752e:	8082                	ret
ffffffffc0207530:	f42f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207534:	0008f797          	auipc	a5,0x8f
ffffffffc0207538:	38c7b783          	ld	a5,908(a5) # ffffffffc02968c0 <current>
ffffffffc020753c:	0818                	addi	a4,sp,16
ffffffffc020753e:	c022                	sw	s0,0(sp)
ffffffffc0207540:	e43e                	sd	a5,8(sp)
ffffffffc0207542:	ec3a                	sd	a4,24(sp)
ffffffffc0207544:	e83a                	sd	a4,16(sp)
ffffffffc0207546:	4705                	li	a4,1
ffffffffc0207548:	c398                	sw	a4,0(a5)
ffffffffc020754a:	80000737          	lui	a4,0x80000
ffffffffc020754e:	0709                	addi	a4,a4,2
ffffffffc0207550:	840a                	mv	s0,sp
ffffffffc0207552:	8522                	mv	a0,s0
ffffffffc0207554:	0ee7a623          	sw	a4,236(a5)
ffffffffc0207558:	320000ef          	jal	ra,ffffffffc0207878 <add_timer>
ffffffffc020755c:	f10f90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0207560:	bf65                	j	ffffffffc0207518 <do_sleep+0x3a>

ffffffffc0207562 <switch_to>:
ffffffffc0207562:	00153023          	sd	ra,0(a0)
ffffffffc0207566:	00253423          	sd	sp,8(a0)
ffffffffc020756a:	e900                	sd	s0,16(a0)
ffffffffc020756c:	ed04                	sd	s1,24(a0)
ffffffffc020756e:	03253023          	sd	s2,32(a0)
ffffffffc0207572:	03353423          	sd	s3,40(a0)
ffffffffc0207576:	03453823          	sd	s4,48(a0)
ffffffffc020757a:	03553c23          	sd	s5,56(a0)
ffffffffc020757e:	05653023          	sd	s6,64(a0)
ffffffffc0207582:	05753423          	sd	s7,72(a0)
ffffffffc0207586:	05853823          	sd	s8,80(a0)
ffffffffc020758a:	05953c23          	sd	s9,88(a0)
ffffffffc020758e:	07a53023          	sd	s10,96(a0)
ffffffffc0207592:	07b53423          	sd	s11,104(a0)
ffffffffc0207596:	0005b083          	ld	ra,0(a1)
ffffffffc020759a:	0085b103          	ld	sp,8(a1)
ffffffffc020759e:	6980                	ld	s0,16(a1)
ffffffffc02075a0:	6d84                	ld	s1,24(a1)
ffffffffc02075a2:	0205b903          	ld	s2,32(a1)
ffffffffc02075a6:	0285b983          	ld	s3,40(a1)
ffffffffc02075aa:	0305ba03          	ld	s4,48(a1)
ffffffffc02075ae:	0385ba83          	ld	s5,56(a1)
ffffffffc02075b2:	0405bb03          	ld	s6,64(a1)
ffffffffc02075b6:	0485bb83          	ld	s7,72(a1)
ffffffffc02075ba:	0505bc03          	ld	s8,80(a1)
ffffffffc02075be:	0585bc83          	ld	s9,88(a1)
ffffffffc02075c2:	0605bd03          	ld	s10,96(a1)
ffffffffc02075c6:	0685bd83          	ld	s11,104(a1)
ffffffffc02075ca:	8082                	ret

ffffffffc02075cc <RR_init>:
ffffffffc02075cc:	e508                	sd	a0,8(a0)
ffffffffc02075ce:	e108                	sd	a0,0(a0)
ffffffffc02075d0:	00052823          	sw	zero,16(a0)
ffffffffc02075d4:	8082                	ret

ffffffffc02075d6 <RR_pick_next>:
ffffffffc02075d6:	651c                	ld	a5,8(a0)
ffffffffc02075d8:	00f50563          	beq	a0,a5,ffffffffc02075e2 <RR_pick_next+0xc>
ffffffffc02075dc:	ef078513          	addi	a0,a5,-272
ffffffffc02075e0:	8082                	ret
ffffffffc02075e2:	4501                	li	a0,0
ffffffffc02075e4:	8082                	ret

ffffffffc02075e6 <RR_proc_tick>:
ffffffffc02075e6:	1205a783          	lw	a5,288(a1)
ffffffffc02075ea:	00f05563          	blez	a5,ffffffffc02075f4 <RR_proc_tick+0xe>
ffffffffc02075ee:	37fd                	addiw	a5,a5,-1
ffffffffc02075f0:	12f5a023          	sw	a5,288(a1)
ffffffffc02075f4:	e399                	bnez	a5,ffffffffc02075fa <RR_proc_tick+0x14>
ffffffffc02075f6:	4785                	li	a5,1
ffffffffc02075f8:	ed9c                	sd	a5,24(a1)
ffffffffc02075fa:	8082                	ret

ffffffffc02075fc <RR_dequeue>:
ffffffffc02075fc:	1185b703          	ld	a4,280(a1)
ffffffffc0207600:	11058793          	addi	a5,a1,272
ffffffffc0207604:	02e78363          	beq	a5,a4,ffffffffc020762a <RR_dequeue+0x2e>
ffffffffc0207608:	1085b683          	ld	a3,264(a1)
ffffffffc020760c:	00a69f63          	bne	a3,a0,ffffffffc020762a <RR_dequeue+0x2e>
ffffffffc0207610:	1105b503          	ld	a0,272(a1)
ffffffffc0207614:	4a90                	lw	a2,16(a3)
ffffffffc0207616:	e518                	sd	a4,8(a0)
ffffffffc0207618:	e308                	sd	a0,0(a4)
ffffffffc020761a:	10f5bc23          	sd	a5,280(a1)
ffffffffc020761e:	10f5b823          	sd	a5,272(a1)
ffffffffc0207622:	fff6079b          	addiw	a5,a2,-1
ffffffffc0207626:	ca9c                	sw	a5,16(a3)
ffffffffc0207628:	8082                	ret
ffffffffc020762a:	1141                	addi	sp,sp,-16
ffffffffc020762c:	00006697          	auipc	a3,0x6
ffffffffc0207630:	6dc68693          	addi	a3,a3,1756 # ffffffffc020dd08 <CSWTCH.79+0x4c0>
ffffffffc0207634:	00004617          	auipc	a2,0x4
ffffffffc0207638:	7cc60613          	addi	a2,a2,1996 # ffffffffc020be00 <commands+0x210>
ffffffffc020763c:	03c00593          	li	a1,60
ffffffffc0207640:	00006517          	auipc	a0,0x6
ffffffffc0207644:	70050513          	addi	a0,a0,1792 # ffffffffc020dd40 <CSWTCH.79+0x4f8>
ffffffffc0207648:	e406                	sd	ra,8(sp)
ffffffffc020764a:	e55f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020764e <RR_enqueue>:
ffffffffc020764e:	1185b703          	ld	a4,280(a1)
ffffffffc0207652:	11058793          	addi	a5,a1,272
ffffffffc0207656:	02e79d63          	bne	a5,a4,ffffffffc0207690 <RR_enqueue+0x42>
ffffffffc020765a:	6118                	ld	a4,0(a0)
ffffffffc020765c:	1205a683          	lw	a3,288(a1)
ffffffffc0207660:	e11c                	sd	a5,0(a0)
ffffffffc0207662:	e71c                	sd	a5,8(a4)
ffffffffc0207664:	10a5bc23          	sd	a0,280(a1)
ffffffffc0207668:	10e5b823          	sd	a4,272(a1)
ffffffffc020766c:	495c                	lw	a5,20(a0)
ffffffffc020766e:	ea89                	bnez	a3,ffffffffc0207680 <RR_enqueue+0x32>
ffffffffc0207670:	12f5a023          	sw	a5,288(a1)
ffffffffc0207674:	491c                	lw	a5,16(a0)
ffffffffc0207676:	10a5b423          	sd	a0,264(a1)
ffffffffc020767a:	2785                	addiw	a5,a5,1
ffffffffc020767c:	c91c                	sw	a5,16(a0)
ffffffffc020767e:	8082                	ret
ffffffffc0207680:	fed7c8e3          	blt	a5,a3,ffffffffc0207670 <RR_enqueue+0x22>
ffffffffc0207684:	491c                	lw	a5,16(a0)
ffffffffc0207686:	10a5b423          	sd	a0,264(a1)
ffffffffc020768a:	2785                	addiw	a5,a5,1
ffffffffc020768c:	c91c                	sw	a5,16(a0)
ffffffffc020768e:	8082                	ret
ffffffffc0207690:	1141                	addi	sp,sp,-16
ffffffffc0207692:	00006697          	auipc	a3,0x6
ffffffffc0207696:	6ce68693          	addi	a3,a3,1742 # ffffffffc020dd60 <CSWTCH.79+0x518>
ffffffffc020769a:	00004617          	auipc	a2,0x4
ffffffffc020769e:	76660613          	addi	a2,a2,1894 # ffffffffc020be00 <commands+0x210>
ffffffffc02076a2:	02800593          	li	a1,40
ffffffffc02076a6:	00006517          	auipc	a0,0x6
ffffffffc02076aa:	69a50513          	addi	a0,a0,1690 # ffffffffc020dd40 <CSWTCH.79+0x4f8>
ffffffffc02076ae:	e406                	sd	ra,8(sp)
ffffffffc02076b0:	deff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076b4 <sched_init>:
ffffffffc02076b4:	1141                	addi	sp,sp,-16
ffffffffc02076b6:	0008a717          	auipc	a4,0x8a
ffffffffc02076ba:	96a70713          	addi	a4,a4,-1686 # ffffffffc0291020 <default_sched_class>
ffffffffc02076be:	e022                	sd	s0,0(sp)
ffffffffc02076c0:	e406                	sd	ra,8(sp)
ffffffffc02076c2:	0008e797          	auipc	a5,0x8e
ffffffffc02076c6:	12e78793          	addi	a5,a5,302 # ffffffffc02957f0 <timer_list>
ffffffffc02076ca:	6714                	ld	a3,8(a4)
ffffffffc02076cc:	0008e517          	auipc	a0,0x8e
ffffffffc02076d0:	10450513          	addi	a0,a0,260 # ffffffffc02957d0 <__rq>
ffffffffc02076d4:	e79c                	sd	a5,8(a5)
ffffffffc02076d6:	e39c                	sd	a5,0(a5)
ffffffffc02076d8:	4795                	li	a5,5
ffffffffc02076da:	c95c                	sw	a5,20(a0)
ffffffffc02076dc:	0008f417          	auipc	s0,0x8f
ffffffffc02076e0:	20c40413          	addi	s0,s0,524 # ffffffffc02968e8 <sched_class>
ffffffffc02076e4:	0008f797          	auipc	a5,0x8f
ffffffffc02076e8:	1ea7be23          	sd	a0,508(a5) # ffffffffc02968e0 <rq>
ffffffffc02076ec:	e018                	sd	a4,0(s0)
ffffffffc02076ee:	9682                	jalr	a3
ffffffffc02076f0:	601c                	ld	a5,0(s0)
ffffffffc02076f2:	6402                	ld	s0,0(sp)
ffffffffc02076f4:	60a2                	ld	ra,8(sp)
ffffffffc02076f6:	638c                	ld	a1,0(a5)
ffffffffc02076f8:	00006517          	auipc	a0,0x6
ffffffffc02076fc:	69850513          	addi	a0,a0,1688 # ffffffffc020dd90 <CSWTCH.79+0x548>
ffffffffc0207700:	0141                	addi	sp,sp,16
ffffffffc0207702:	aa5f806f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0207706 <wakeup_proc>:
ffffffffc0207706:	4118                	lw	a4,0(a0)
ffffffffc0207708:	1101                	addi	sp,sp,-32
ffffffffc020770a:	ec06                	sd	ra,24(sp)
ffffffffc020770c:	e822                	sd	s0,16(sp)
ffffffffc020770e:	e426                	sd	s1,8(sp)
ffffffffc0207710:	478d                	li	a5,3
ffffffffc0207712:	08f70363          	beq	a4,a5,ffffffffc0207798 <wakeup_proc+0x92>
ffffffffc0207716:	842a                	mv	s0,a0
ffffffffc0207718:	100027f3          	csrr	a5,sstatus
ffffffffc020771c:	8b89                	andi	a5,a5,2
ffffffffc020771e:	4481                	li	s1,0
ffffffffc0207720:	e7bd                	bnez	a5,ffffffffc020778e <wakeup_proc+0x88>
ffffffffc0207722:	4789                	li	a5,2
ffffffffc0207724:	04f70863          	beq	a4,a5,ffffffffc0207774 <wakeup_proc+0x6e>
ffffffffc0207728:	c01c                	sw	a5,0(s0)
ffffffffc020772a:	0e042623          	sw	zero,236(s0)
ffffffffc020772e:	0008f797          	auipc	a5,0x8f
ffffffffc0207732:	1927b783          	ld	a5,402(a5) # ffffffffc02968c0 <current>
ffffffffc0207736:	02878363          	beq	a5,s0,ffffffffc020775c <wakeup_proc+0x56>
ffffffffc020773a:	0008f797          	auipc	a5,0x8f
ffffffffc020773e:	18e7b783          	ld	a5,398(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207742:	00f40d63          	beq	s0,a5,ffffffffc020775c <wakeup_proc+0x56>
ffffffffc0207746:	0008f797          	auipc	a5,0x8f
ffffffffc020774a:	1a27b783          	ld	a5,418(a5) # ffffffffc02968e8 <sched_class>
ffffffffc020774e:	6b9c                	ld	a5,16(a5)
ffffffffc0207750:	85a2                	mv	a1,s0
ffffffffc0207752:	0008f517          	auipc	a0,0x8f
ffffffffc0207756:	18e53503          	ld	a0,398(a0) # ffffffffc02968e0 <rq>
ffffffffc020775a:	9782                	jalr	a5
ffffffffc020775c:	e491                	bnez	s1,ffffffffc0207768 <wakeup_proc+0x62>
ffffffffc020775e:	60e2                	ld	ra,24(sp)
ffffffffc0207760:	6442                	ld	s0,16(sp)
ffffffffc0207762:	64a2                	ld	s1,8(sp)
ffffffffc0207764:	6105                	addi	sp,sp,32
ffffffffc0207766:	8082                	ret
ffffffffc0207768:	6442                	ld	s0,16(sp)
ffffffffc020776a:	60e2                	ld	ra,24(sp)
ffffffffc020776c:	64a2                	ld	s1,8(sp)
ffffffffc020776e:	6105                	addi	sp,sp,32
ffffffffc0207770:	cfcf906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207774:	00006617          	auipc	a2,0x6
ffffffffc0207778:	66c60613          	addi	a2,a2,1644 # ffffffffc020dde0 <CSWTCH.79+0x598>
ffffffffc020777c:	05200593          	li	a1,82
ffffffffc0207780:	00006517          	auipc	a0,0x6
ffffffffc0207784:	64850513          	addi	a0,a0,1608 # ffffffffc020ddc8 <CSWTCH.79+0x580>
ffffffffc0207788:	d7ff80ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020778c:	bfc1                	j	ffffffffc020775c <wakeup_proc+0x56>
ffffffffc020778e:	ce4f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207792:	4018                	lw	a4,0(s0)
ffffffffc0207794:	4485                	li	s1,1
ffffffffc0207796:	b771                	j	ffffffffc0207722 <wakeup_proc+0x1c>
ffffffffc0207798:	00006697          	auipc	a3,0x6
ffffffffc020779c:	61068693          	addi	a3,a3,1552 # ffffffffc020dda8 <CSWTCH.79+0x560>
ffffffffc02077a0:	00004617          	auipc	a2,0x4
ffffffffc02077a4:	66060613          	addi	a2,a2,1632 # ffffffffc020be00 <commands+0x210>
ffffffffc02077a8:	04300593          	li	a1,67
ffffffffc02077ac:	00006517          	auipc	a0,0x6
ffffffffc02077b0:	61c50513          	addi	a0,a0,1564 # ffffffffc020ddc8 <CSWTCH.79+0x580>
ffffffffc02077b4:	cebf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02077b8 <schedule>:
ffffffffc02077b8:	7179                	addi	sp,sp,-48
ffffffffc02077ba:	f406                	sd	ra,40(sp)
ffffffffc02077bc:	f022                	sd	s0,32(sp)
ffffffffc02077be:	ec26                	sd	s1,24(sp)
ffffffffc02077c0:	e84a                	sd	s2,16(sp)
ffffffffc02077c2:	e44e                	sd	s3,8(sp)
ffffffffc02077c4:	e052                	sd	s4,0(sp)
ffffffffc02077c6:	100027f3          	csrr	a5,sstatus
ffffffffc02077ca:	8b89                	andi	a5,a5,2
ffffffffc02077cc:	4a01                	li	s4,0
ffffffffc02077ce:	e3cd                	bnez	a5,ffffffffc0207870 <schedule+0xb8>
ffffffffc02077d0:	0008f497          	auipc	s1,0x8f
ffffffffc02077d4:	0f048493          	addi	s1,s1,240 # ffffffffc02968c0 <current>
ffffffffc02077d8:	608c                	ld	a1,0(s1)
ffffffffc02077da:	0008f997          	auipc	s3,0x8f
ffffffffc02077de:	10e98993          	addi	s3,s3,270 # ffffffffc02968e8 <sched_class>
ffffffffc02077e2:	0008f917          	auipc	s2,0x8f
ffffffffc02077e6:	0fe90913          	addi	s2,s2,254 # ffffffffc02968e0 <rq>
ffffffffc02077ea:	4194                	lw	a3,0(a1)
ffffffffc02077ec:	0005bc23          	sd	zero,24(a1)
ffffffffc02077f0:	4709                	li	a4,2
ffffffffc02077f2:	0009b783          	ld	a5,0(s3)
ffffffffc02077f6:	00093503          	ld	a0,0(s2)
ffffffffc02077fa:	04e68e63          	beq	a3,a4,ffffffffc0207856 <schedule+0x9e>
ffffffffc02077fe:	739c                	ld	a5,32(a5)
ffffffffc0207800:	9782                	jalr	a5
ffffffffc0207802:	842a                	mv	s0,a0
ffffffffc0207804:	c521                	beqz	a0,ffffffffc020784c <schedule+0x94>
ffffffffc0207806:	0009b783          	ld	a5,0(s3)
ffffffffc020780a:	00093503          	ld	a0,0(s2)
ffffffffc020780e:	85a2                	mv	a1,s0
ffffffffc0207810:	6f9c                	ld	a5,24(a5)
ffffffffc0207812:	9782                	jalr	a5
ffffffffc0207814:	441c                	lw	a5,8(s0)
ffffffffc0207816:	6098                	ld	a4,0(s1)
ffffffffc0207818:	2785                	addiw	a5,a5,1
ffffffffc020781a:	c41c                	sw	a5,8(s0)
ffffffffc020781c:	00870563          	beq	a4,s0,ffffffffc0207826 <schedule+0x6e>
ffffffffc0207820:	8522                	mv	a0,s0
ffffffffc0207822:	bbcfe0ef          	jal	ra,ffffffffc0205bde <proc_run>
ffffffffc0207826:	000a1a63          	bnez	s4,ffffffffc020783a <schedule+0x82>
ffffffffc020782a:	70a2                	ld	ra,40(sp)
ffffffffc020782c:	7402                	ld	s0,32(sp)
ffffffffc020782e:	64e2                	ld	s1,24(sp)
ffffffffc0207830:	6942                	ld	s2,16(sp)
ffffffffc0207832:	69a2                	ld	s3,8(sp)
ffffffffc0207834:	6a02                	ld	s4,0(sp)
ffffffffc0207836:	6145                	addi	sp,sp,48
ffffffffc0207838:	8082                	ret
ffffffffc020783a:	7402                	ld	s0,32(sp)
ffffffffc020783c:	70a2                	ld	ra,40(sp)
ffffffffc020783e:	64e2                	ld	s1,24(sp)
ffffffffc0207840:	6942                	ld	s2,16(sp)
ffffffffc0207842:	69a2                	ld	s3,8(sp)
ffffffffc0207844:	6a02                	ld	s4,0(sp)
ffffffffc0207846:	6145                	addi	sp,sp,48
ffffffffc0207848:	c24f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020784c:	0008f417          	auipc	s0,0x8f
ffffffffc0207850:	07c43403          	ld	s0,124(s0) # ffffffffc02968c8 <idleproc>
ffffffffc0207854:	b7c1                	j	ffffffffc0207814 <schedule+0x5c>
ffffffffc0207856:	0008f717          	auipc	a4,0x8f
ffffffffc020785a:	07273703          	ld	a4,114(a4) # ffffffffc02968c8 <idleproc>
ffffffffc020785e:	fae580e3          	beq	a1,a4,ffffffffc02077fe <schedule+0x46>
ffffffffc0207862:	6b9c                	ld	a5,16(a5)
ffffffffc0207864:	9782                	jalr	a5
ffffffffc0207866:	0009b783          	ld	a5,0(s3)
ffffffffc020786a:	00093503          	ld	a0,0(s2)
ffffffffc020786e:	bf41                	j	ffffffffc02077fe <schedule+0x46>
ffffffffc0207870:	c02f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207874:	4a05                	li	s4,1
ffffffffc0207876:	bfa9                	j	ffffffffc02077d0 <schedule+0x18>

ffffffffc0207878 <add_timer>:
ffffffffc0207878:	1141                	addi	sp,sp,-16
ffffffffc020787a:	e022                	sd	s0,0(sp)
ffffffffc020787c:	e406                	sd	ra,8(sp)
ffffffffc020787e:	842a                	mv	s0,a0
ffffffffc0207880:	100027f3          	csrr	a5,sstatus
ffffffffc0207884:	8b89                	andi	a5,a5,2
ffffffffc0207886:	4501                	li	a0,0
ffffffffc0207888:	eba5                	bnez	a5,ffffffffc02078f8 <add_timer+0x80>
ffffffffc020788a:	401c                	lw	a5,0(s0)
ffffffffc020788c:	cbb5                	beqz	a5,ffffffffc0207900 <add_timer+0x88>
ffffffffc020788e:	6418                	ld	a4,8(s0)
ffffffffc0207890:	cb25                	beqz	a4,ffffffffc0207900 <add_timer+0x88>
ffffffffc0207892:	6c18                	ld	a4,24(s0)
ffffffffc0207894:	01040593          	addi	a1,s0,16
ffffffffc0207898:	08e59463          	bne	a1,a4,ffffffffc0207920 <add_timer+0xa8>
ffffffffc020789c:	0008e617          	auipc	a2,0x8e
ffffffffc02078a0:	f5460613          	addi	a2,a2,-172 # ffffffffc02957f0 <timer_list>
ffffffffc02078a4:	6618                	ld	a4,8(a2)
ffffffffc02078a6:	00c71863          	bne	a4,a2,ffffffffc02078b6 <add_timer+0x3e>
ffffffffc02078aa:	a80d                	j	ffffffffc02078dc <add_timer+0x64>
ffffffffc02078ac:	6718                	ld	a4,8(a4)
ffffffffc02078ae:	9f95                	subw	a5,a5,a3
ffffffffc02078b0:	c01c                	sw	a5,0(s0)
ffffffffc02078b2:	02c70563          	beq	a4,a2,ffffffffc02078dc <add_timer+0x64>
ffffffffc02078b6:	ff072683          	lw	a3,-16(a4)
ffffffffc02078ba:	fed7f9e3          	bgeu	a5,a3,ffffffffc02078ac <add_timer+0x34>
ffffffffc02078be:	40f687bb          	subw	a5,a3,a5
ffffffffc02078c2:	fef72823          	sw	a5,-16(a4)
ffffffffc02078c6:	631c                	ld	a5,0(a4)
ffffffffc02078c8:	e30c                	sd	a1,0(a4)
ffffffffc02078ca:	e78c                	sd	a1,8(a5)
ffffffffc02078cc:	ec18                	sd	a4,24(s0)
ffffffffc02078ce:	e81c                	sd	a5,16(s0)
ffffffffc02078d0:	c105                	beqz	a0,ffffffffc02078f0 <add_timer+0x78>
ffffffffc02078d2:	6402                	ld	s0,0(sp)
ffffffffc02078d4:	60a2                	ld	ra,8(sp)
ffffffffc02078d6:	0141                	addi	sp,sp,16
ffffffffc02078d8:	b94f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02078dc:	0008e717          	auipc	a4,0x8e
ffffffffc02078e0:	f1470713          	addi	a4,a4,-236 # ffffffffc02957f0 <timer_list>
ffffffffc02078e4:	631c                	ld	a5,0(a4)
ffffffffc02078e6:	e30c                	sd	a1,0(a4)
ffffffffc02078e8:	e78c                	sd	a1,8(a5)
ffffffffc02078ea:	ec18                	sd	a4,24(s0)
ffffffffc02078ec:	e81c                	sd	a5,16(s0)
ffffffffc02078ee:	f175                	bnez	a0,ffffffffc02078d2 <add_timer+0x5a>
ffffffffc02078f0:	60a2                	ld	ra,8(sp)
ffffffffc02078f2:	6402                	ld	s0,0(sp)
ffffffffc02078f4:	0141                	addi	sp,sp,16
ffffffffc02078f6:	8082                	ret
ffffffffc02078f8:	b7af90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02078fc:	4505                	li	a0,1
ffffffffc02078fe:	b771                	j	ffffffffc020788a <add_timer+0x12>
ffffffffc0207900:	00006697          	auipc	a3,0x6
ffffffffc0207904:	50068693          	addi	a3,a3,1280 # ffffffffc020de00 <CSWTCH.79+0x5b8>
ffffffffc0207908:	00004617          	auipc	a2,0x4
ffffffffc020790c:	4f860613          	addi	a2,a2,1272 # ffffffffc020be00 <commands+0x210>
ffffffffc0207910:	07a00593          	li	a1,122
ffffffffc0207914:	00006517          	auipc	a0,0x6
ffffffffc0207918:	4b450513          	addi	a0,a0,1204 # ffffffffc020ddc8 <CSWTCH.79+0x580>
ffffffffc020791c:	b83f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207920:	00006697          	auipc	a3,0x6
ffffffffc0207924:	51068693          	addi	a3,a3,1296 # ffffffffc020de30 <CSWTCH.79+0x5e8>
ffffffffc0207928:	00004617          	auipc	a2,0x4
ffffffffc020792c:	4d860613          	addi	a2,a2,1240 # ffffffffc020be00 <commands+0x210>
ffffffffc0207930:	07b00593          	li	a1,123
ffffffffc0207934:	00006517          	auipc	a0,0x6
ffffffffc0207938:	49450513          	addi	a0,a0,1172 # ffffffffc020ddc8 <CSWTCH.79+0x580>
ffffffffc020793c:	b63f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207940 <del_timer>:
ffffffffc0207940:	1101                	addi	sp,sp,-32
ffffffffc0207942:	e822                	sd	s0,16(sp)
ffffffffc0207944:	ec06                	sd	ra,24(sp)
ffffffffc0207946:	e426                	sd	s1,8(sp)
ffffffffc0207948:	842a                	mv	s0,a0
ffffffffc020794a:	100027f3          	csrr	a5,sstatus
ffffffffc020794e:	8b89                	andi	a5,a5,2
ffffffffc0207950:	01050493          	addi	s1,a0,16
ffffffffc0207954:	eb9d                	bnez	a5,ffffffffc020798a <del_timer+0x4a>
ffffffffc0207956:	6d1c                	ld	a5,24(a0)
ffffffffc0207958:	02978463          	beq	a5,s1,ffffffffc0207980 <del_timer+0x40>
ffffffffc020795c:	4114                	lw	a3,0(a0)
ffffffffc020795e:	6918                	ld	a4,16(a0)
ffffffffc0207960:	ce81                	beqz	a3,ffffffffc0207978 <del_timer+0x38>
ffffffffc0207962:	0008e617          	auipc	a2,0x8e
ffffffffc0207966:	e8e60613          	addi	a2,a2,-370 # ffffffffc02957f0 <timer_list>
ffffffffc020796a:	00c78763          	beq	a5,a2,ffffffffc0207978 <del_timer+0x38>
ffffffffc020796e:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207972:	9eb1                	addw	a3,a3,a2
ffffffffc0207974:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207978:	e71c                	sd	a5,8(a4)
ffffffffc020797a:	e398                	sd	a4,0(a5)
ffffffffc020797c:	ec04                	sd	s1,24(s0)
ffffffffc020797e:	e804                	sd	s1,16(s0)
ffffffffc0207980:	60e2                	ld	ra,24(sp)
ffffffffc0207982:	6442                	ld	s0,16(sp)
ffffffffc0207984:	64a2                	ld	s1,8(sp)
ffffffffc0207986:	6105                	addi	sp,sp,32
ffffffffc0207988:	8082                	ret
ffffffffc020798a:	ae8f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020798e:	6c1c                	ld	a5,24(s0)
ffffffffc0207990:	02978463          	beq	a5,s1,ffffffffc02079b8 <del_timer+0x78>
ffffffffc0207994:	4014                	lw	a3,0(s0)
ffffffffc0207996:	6818                	ld	a4,16(s0)
ffffffffc0207998:	ce81                	beqz	a3,ffffffffc02079b0 <del_timer+0x70>
ffffffffc020799a:	0008e617          	auipc	a2,0x8e
ffffffffc020799e:	e5660613          	addi	a2,a2,-426 # ffffffffc02957f0 <timer_list>
ffffffffc02079a2:	00c78763          	beq	a5,a2,ffffffffc02079b0 <del_timer+0x70>
ffffffffc02079a6:	ff07a603          	lw	a2,-16(a5)
ffffffffc02079aa:	9eb1                	addw	a3,a3,a2
ffffffffc02079ac:	fed7a823          	sw	a3,-16(a5)
ffffffffc02079b0:	e71c                	sd	a5,8(a4)
ffffffffc02079b2:	e398                	sd	a4,0(a5)
ffffffffc02079b4:	ec04                	sd	s1,24(s0)
ffffffffc02079b6:	e804                	sd	s1,16(s0)
ffffffffc02079b8:	6442                	ld	s0,16(sp)
ffffffffc02079ba:	60e2                	ld	ra,24(sp)
ffffffffc02079bc:	64a2                	ld	s1,8(sp)
ffffffffc02079be:	6105                	addi	sp,sp,32
ffffffffc02079c0:	aacf906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02079c4 <run_timer_list>:
ffffffffc02079c4:	7139                	addi	sp,sp,-64
ffffffffc02079c6:	fc06                	sd	ra,56(sp)
ffffffffc02079c8:	f822                	sd	s0,48(sp)
ffffffffc02079ca:	f426                	sd	s1,40(sp)
ffffffffc02079cc:	f04a                	sd	s2,32(sp)
ffffffffc02079ce:	ec4e                	sd	s3,24(sp)
ffffffffc02079d0:	e852                	sd	s4,16(sp)
ffffffffc02079d2:	e456                	sd	s5,8(sp)
ffffffffc02079d4:	e05a                	sd	s6,0(sp)
ffffffffc02079d6:	100027f3          	csrr	a5,sstatus
ffffffffc02079da:	8b89                	andi	a5,a5,2
ffffffffc02079dc:	4b01                	li	s6,0
ffffffffc02079de:	efe9                	bnez	a5,ffffffffc0207ab8 <run_timer_list+0xf4>
ffffffffc02079e0:	0008e997          	auipc	s3,0x8e
ffffffffc02079e4:	e1098993          	addi	s3,s3,-496 # ffffffffc02957f0 <timer_list>
ffffffffc02079e8:	0089b403          	ld	s0,8(s3)
ffffffffc02079ec:	07340a63          	beq	s0,s3,ffffffffc0207a60 <run_timer_list+0x9c>
ffffffffc02079f0:	ff042783          	lw	a5,-16(s0)
ffffffffc02079f4:	ff040913          	addi	s2,s0,-16
ffffffffc02079f8:	0e078763          	beqz	a5,ffffffffc0207ae6 <run_timer_list+0x122>
ffffffffc02079fc:	fff7871b          	addiw	a4,a5,-1
ffffffffc0207a00:	fee42823          	sw	a4,-16(s0)
ffffffffc0207a04:	ef31                	bnez	a4,ffffffffc0207a60 <run_timer_list+0x9c>
ffffffffc0207a06:	00006a97          	auipc	s5,0x6
ffffffffc0207a0a:	492a8a93          	addi	s5,s5,1170 # ffffffffc020de98 <CSWTCH.79+0x650>
ffffffffc0207a0e:	00006a17          	auipc	s4,0x6
ffffffffc0207a12:	3baa0a13          	addi	s4,s4,954 # ffffffffc020ddc8 <CSWTCH.79+0x580>
ffffffffc0207a16:	a005                	j	ffffffffc0207a36 <run_timer_list+0x72>
ffffffffc0207a18:	0a07d763          	bgez	a5,ffffffffc0207ac6 <run_timer_list+0x102>
ffffffffc0207a1c:	8526                	mv	a0,s1
ffffffffc0207a1e:	ce9ff0ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc0207a22:	854a                	mv	a0,s2
ffffffffc0207a24:	f1dff0ef          	jal	ra,ffffffffc0207940 <del_timer>
ffffffffc0207a28:	03340c63          	beq	s0,s3,ffffffffc0207a60 <run_timer_list+0x9c>
ffffffffc0207a2c:	ff042783          	lw	a5,-16(s0)
ffffffffc0207a30:	ff040913          	addi	s2,s0,-16
ffffffffc0207a34:	e795                	bnez	a5,ffffffffc0207a60 <run_timer_list+0x9c>
ffffffffc0207a36:	00893483          	ld	s1,8(s2)
ffffffffc0207a3a:	6400                	ld	s0,8(s0)
ffffffffc0207a3c:	0ec4a783          	lw	a5,236(s1)
ffffffffc0207a40:	ffe1                	bnez	a5,ffffffffc0207a18 <run_timer_list+0x54>
ffffffffc0207a42:	40d4                	lw	a3,4(s1)
ffffffffc0207a44:	8656                	mv	a2,s5
ffffffffc0207a46:	0ba00593          	li	a1,186
ffffffffc0207a4a:	8552                	mv	a0,s4
ffffffffc0207a4c:	abbf80ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc0207a50:	8526                	mv	a0,s1
ffffffffc0207a52:	cb5ff0ef          	jal	ra,ffffffffc0207706 <wakeup_proc>
ffffffffc0207a56:	854a                	mv	a0,s2
ffffffffc0207a58:	ee9ff0ef          	jal	ra,ffffffffc0207940 <del_timer>
ffffffffc0207a5c:	fd3418e3          	bne	s0,s3,ffffffffc0207a2c <run_timer_list+0x68>
ffffffffc0207a60:	0008f597          	auipc	a1,0x8f
ffffffffc0207a64:	e605b583          	ld	a1,-416(a1) # ffffffffc02968c0 <current>
ffffffffc0207a68:	c18d                	beqz	a1,ffffffffc0207a8a <run_timer_list+0xc6>
ffffffffc0207a6a:	0008f797          	auipc	a5,0x8f
ffffffffc0207a6e:	e5e7b783          	ld	a5,-418(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207a72:	04f58763          	beq	a1,a5,ffffffffc0207ac0 <run_timer_list+0xfc>
ffffffffc0207a76:	0008f797          	auipc	a5,0x8f
ffffffffc0207a7a:	e727b783          	ld	a5,-398(a5) # ffffffffc02968e8 <sched_class>
ffffffffc0207a7e:	779c                	ld	a5,40(a5)
ffffffffc0207a80:	0008f517          	auipc	a0,0x8f
ffffffffc0207a84:	e6053503          	ld	a0,-416(a0) # ffffffffc02968e0 <rq>
ffffffffc0207a88:	9782                	jalr	a5
ffffffffc0207a8a:	000b1c63          	bnez	s6,ffffffffc0207aa2 <run_timer_list+0xde>
ffffffffc0207a8e:	70e2                	ld	ra,56(sp)
ffffffffc0207a90:	7442                	ld	s0,48(sp)
ffffffffc0207a92:	74a2                	ld	s1,40(sp)
ffffffffc0207a94:	7902                	ld	s2,32(sp)
ffffffffc0207a96:	69e2                	ld	s3,24(sp)
ffffffffc0207a98:	6a42                	ld	s4,16(sp)
ffffffffc0207a9a:	6aa2                	ld	s5,8(sp)
ffffffffc0207a9c:	6b02                	ld	s6,0(sp)
ffffffffc0207a9e:	6121                	addi	sp,sp,64
ffffffffc0207aa0:	8082                	ret
ffffffffc0207aa2:	7442                	ld	s0,48(sp)
ffffffffc0207aa4:	70e2                	ld	ra,56(sp)
ffffffffc0207aa6:	74a2                	ld	s1,40(sp)
ffffffffc0207aa8:	7902                	ld	s2,32(sp)
ffffffffc0207aaa:	69e2                	ld	s3,24(sp)
ffffffffc0207aac:	6a42                	ld	s4,16(sp)
ffffffffc0207aae:	6aa2                	ld	s5,8(sp)
ffffffffc0207ab0:	6b02                	ld	s6,0(sp)
ffffffffc0207ab2:	6121                	addi	sp,sp,64
ffffffffc0207ab4:	9b8f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207ab8:	9baf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207abc:	4b05                	li	s6,1
ffffffffc0207abe:	b70d                	j	ffffffffc02079e0 <run_timer_list+0x1c>
ffffffffc0207ac0:	4785                	li	a5,1
ffffffffc0207ac2:	ed9c                	sd	a5,24(a1)
ffffffffc0207ac4:	b7d9                	j	ffffffffc0207a8a <run_timer_list+0xc6>
ffffffffc0207ac6:	00006697          	auipc	a3,0x6
ffffffffc0207aca:	3aa68693          	addi	a3,a3,938 # ffffffffc020de70 <CSWTCH.79+0x628>
ffffffffc0207ace:	00004617          	auipc	a2,0x4
ffffffffc0207ad2:	33260613          	addi	a2,a2,818 # ffffffffc020be00 <commands+0x210>
ffffffffc0207ad6:	0b600593          	li	a1,182
ffffffffc0207ada:	00006517          	auipc	a0,0x6
ffffffffc0207ade:	2ee50513          	addi	a0,a0,750 # ffffffffc020ddc8 <CSWTCH.79+0x580>
ffffffffc0207ae2:	9bdf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ae6:	00006697          	auipc	a3,0x6
ffffffffc0207aea:	37268693          	addi	a3,a3,882 # ffffffffc020de58 <CSWTCH.79+0x610>
ffffffffc0207aee:	00004617          	auipc	a2,0x4
ffffffffc0207af2:	31260613          	addi	a2,a2,786 # ffffffffc020be00 <commands+0x210>
ffffffffc0207af6:	0ae00593          	li	a1,174
ffffffffc0207afa:	00006517          	auipc	a0,0x6
ffffffffc0207afe:	2ce50513          	addi	a0,a0,718 # ffffffffc020ddc8 <CSWTCH.79+0x580>
ffffffffc0207b02:	99df80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207b06 <sys_getpid>:
ffffffffc0207b06:	0008f797          	auipc	a5,0x8f
ffffffffc0207b0a:	dba7b783          	ld	a5,-582(a5) # ffffffffc02968c0 <current>
ffffffffc0207b0e:	43c8                	lw	a0,4(a5)
ffffffffc0207b10:	8082                	ret

ffffffffc0207b12 <sys_pgdir>:
ffffffffc0207b12:	4501                	li	a0,0
ffffffffc0207b14:	8082                	ret

ffffffffc0207b16 <sys_gettime>:
ffffffffc0207b16:	0008f797          	auipc	a5,0x8f
ffffffffc0207b1a:	d5a7b783          	ld	a5,-678(a5) # ffffffffc0296870 <ticks>
ffffffffc0207b1e:	0027951b          	slliw	a0,a5,0x2
ffffffffc0207b22:	9d3d                	addw	a0,a0,a5
ffffffffc0207b24:	0015151b          	slliw	a0,a0,0x1
ffffffffc0207b28:	8082                	ret

ffffffffc0207b2a <sys_lab6_set_priority>:
ffffffffc0207b2a:	4108                	lw	a0,0(a0)
ffffffffc0207b2c:	1141                	addi	sp,sp,-16
ffffffffc0207b2e:	e406                	sd	ra,8(sp)
ffffffffc0207b30:	975ff0ef          	jal	ra,ffffffffc02074a4 <lab6_set_priority>
ffffffffc0207b34:	60a2                	ld	ra,8(sp)
ffffffffc0207b36:	4501                	li	a0,0
ffffffffc0207b38:	0141                	addi	sp,sp,16
ffffffffc0207b3a:	8082                	ret

ffffffffc0207b3c <sys_dup>:
ffffffffc0207b3c:	450c                	lw	a1,8(a0)
ffffffffc0207b3e:	4108                	lw	a0,0(a0)
ffffffffc0207b40:	f21fd06f          	j	ffffffffc0205a60 <sysfile_dup>

ffffffffc0207b44 <sys_getdirentry>:
ffffffffc0207b44:	650c                	ld	a1,8(a0)
ffffffffc0207b46:	4108                	lw	a0,0(a0)
ffffffffc0207b48:	e29fd06f          	j	ffffffffc0205970 <sysfile_getdirentry>

ffffffffc0207b4c <sys_getcwd>:
ffffffffc0207b4c:	650c                	ld	a1,8(a0)
ffffffffc0207b4e:	6108                	ld	a0,0(a0)
ffffffffc0207b50:	d7dfd06f          	j	ffffffffc02058cc <sysfile_getcwd>

ffffffffc0207b54 <sys_fsync>:
ffffffffc0207b54:	4108                	lw	a0,0(a0)
ffffffffc0207b56:	d73fd06f          	j	ffffffffc02058c8 <sysfile_fsync>

ffffffffc0207b5a <sys_fstat>:
ffffffffc0207b5a:	650c                	ld	a1,8(a0)
ffffffffc0207b5c:	4108                	lw	a0,0(a0)
ffffffffc0207b5e:	ccbfd06f          	j	ffffffffc0205828 <sysfile_fstat>

ffffffffc0207b62 <sys_seek>:
ffffffffc0207b62:	4910                	lw	a2,16(a0)
ffffffffc0207b64:	650c                	ld	a1,8(a0)
ffffffffc0207b66:	4108                	lw	a0,0(a0)
ffffffffc0207b68:	cbdfd06f          	j	ffffffffc0205824 <sysfile_seek>

ffffffffc0207b6c <sys_write>:
ffffffffc0207b6c:	6910                	ld	a2,16(a0)
ffffffffc0207b6e:	650c                	ld	a1,8(a0)
ffffffffc0207b70:	4108                	lw	a0,0(a0)
ffffffffc0207b72:	b99fd06f          	j	ffffffffc020570a <sysfile_write>

ffffffffc0207b76 <sys_read>:
ffffffffc0207b76:	6910                	ld	a2,16(a0)
ffffffffc0207b78:	650c                	ld	a1,8(a0)
ffffffffc0207b7a:	4108                	lw	a0,0(a0)
ffffffffc0207b7c:	a7bfd06f          	j	ffffffffc02055f6 <sysfile_read>

ffffffffc0207b80 <sys_close>:
ffffffffc0207b80:	4108                	lw	a0,0(a0)
ffffffffc0207b82:	a71fd06f          	j	ffffffffc02055f2 <sysfile_close>

ffffffffc0207b86 <sys_open>:
ffffffffc0207b86:	450c                	lw	a1,8(a0)
ffffffffc0207b88:	6108                	ld	a0,0(a0)
ffffffffc0207b8a:	a35fd06f          	j	ffffffffc02055be <sysfile_open>

ffffffffc0207b8e <sys_putc>:
ffffffffc0207b8e:	4108                	lw	a0,0(a0)
ffffffffc0207b90:	1141                	addi	sp,sp,-16
ffffffffc0207b92:	e406                	sd	ra,8(sp)
ffffffffc0207b94:	e4ef80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0207b98:	60a2                	ld	ra,8(sp)
ffffffffc0207b9a:	4501                	li	a0,0
ffffffffc0207b9c:	0141                	addi	sp,sp,16
ffffffffc0207b9e:	8082                	ret

ffffffffc0207ba0 <sys_kill>:
ffffffffc0207ba0:	4108                	lw	a0,0(a0)
ffffffffc0207ba2:	ea0ff06f          	j	ffffffffc0207242 <do_kill>

ffffffffc0207ba6 <sys_sleep>:
ffffffffc0207ba6:	4108                	lw	a0,0(a0)
ffffffffc0207ba8:	937ff06f          	j	ffffffffc02074de <do_sleep>

ffffffffc0207bac <sys_yield>:
ffffffffc0207bac:	e48ff06f          	j	ffffffffc02071f4 <do_yield>

ffffffffc0207bb0 <sys_exec>:
ffffffffc0207bb0:	6910                	ld	a2,16(a0)
ffffffffc0207bb2:	450c                	lw	a1,8(a0)
ffffffffc0207bb4:	6108                	ld	a0,0(a0)
ffffffffc0207bb6:	9edfe06f          	j	ffffffffc02065a2 <do_execve>

ffffffffc0207bba <sys_wait>:
ffffffffc0207bba:	650c                	ld	a1,8(a0)
ffffffffc0207bbc:	4108                	lw	a0,0(a0)
ffffffffc0207bbe:	e46ff06f          	j	ffffffffc0207204 <do_wait>

ffffffffc0207bc2 <sys_fork>:
ffffffffc0207bc2:	0008f797          	auipc	a5,0x8f
ffffffffc0207bc6:	cfe7b783          	ld	a5,-770(a5) # ffffffffc02968c0 <current>
ffffffffc0207bca:	73d0                	ld	a2,160(a5)
ffffffffc0207bcc:	4501                	li	a0,0
ffffffffc0207bce:	6a0c                	ld	a1,16(a2)
ffffffffc0207bd0:	87efe06f          	j	ffffffffc0205c4e <do_fork>

ffffffffc0207bd4 <sys_exit>:
ffffffffc0207bd4:	4108                	lw	a0,0(a0)
ffffffffc0207bd6:	d48fe06f          	j	ffffffffc020611e <do_exit>

ffffffffc0207bda <syscall>:
ffffffffc0207bda:	715d                	addi	sp,sp,-80
ffffffffc0207bdc:	fc26                	sd	s1,56(sp)
ffffffffc0207bde:	0008f497          	auipc	s1,0x8f
ffffffffc0207be2:	ce248493          	addi	s1,s1,-798 # ffffffffc02968c0 <current>
ffffffffc0207be6:	6098                	ld	a4,0(s1)
ffffffffc0207be8:	e0a2                	sd	s0,64(sp)
ffffffffc0207bea:	f84a                	sd	s2,48(sp)
ffffffffc0207bec:	7340                	ld	s0,160(a4)
ffffffffc0207bee:	e486                	sd	ra,72(sp)
ffffffffc0207bf0:	0ff00793          	li	a5,255
ffffffffc0207bf4:	05042903          	lw	s2,80(s0)
ffffffffc0207bf8:	0327ee63          	bltu	a5,s2,ffffffffc0207c34 <syscall+0x5a>
ffffffffc0207bfc:	00391713          	slli	a4,s2,0x3
ffffffffc0207c00:	00006797          	auipc	a5,0x6
ffffffffc0207c04:	30078793          	addi	a5,a5,768 # ffffffffc020df00 <syscalls>
ffffffffc0207c08:	97ba                	add	a5,a5,a4
ffffffffc0207c0a:	639c                	ld	a5,0(a5)
ffffffffc0207c0c:	c785                	beqz	a5,ffffffffc0207c34 <syscall+0x5a>
ffffffffc0207c0e:	6c28                	ld	a0,88(s0)
ffffffffc0207c10:	702c                	ld	a1,96(s0)
ffffffffc0207c12:	7430                	ld	a2,104(s0)
ffffffffc0207c14:	7834                	ld	a3,112(s0)
ffffffffc0207c16:	7c38                	ld	a4,120(s0)
ffffffffc0207c18:	e42a                	sd	a0,8(sp)
ffffffffc0207c1a:	e82e                	sd	a1,16(sp)
ffffffffc0207c1c:	ec32                	sd	a2,24(sp)
ffffffffc0207c1e:	f036                	sd	a3,32(sp)
ffffffffc0207c20:	f43a                	sd	a4,40(sp)
ffffffffc0207c22:	0028                	addi	a0,sp,8
ffffffffc0207c24:	9782                	jalr	a5
ffffffffc0207c26:	60a6                	ld	ra,72(sp)
ffffffffc0207c28:	e828                	sd	a0,80(s0)
ffffffffc0207c2a:	6406                	ld	s0,64(sp)
ffffffffc0207c2c:	74e2                	ld	s1,56(sp)
ffffffffc0207c2e:	7942                	ld	s2,48(sp)
ffffffffc0207c30:	6161                	addi	sp,sp,80
ffffffffc0207c32:	8082                	ret
ffffffffc0207c34:	8522                	mv	a0,s0
ffffffffc0207c36:	b54f90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0207c3a:	609c                	ld	a5,0(s1)
ffffffffc0207c3c:	86ca                	mv	a3,s2
ffffffffc0207c3e:	00006617          	auipc	a2,0x6
ffffffffc0207c42:	27a60613          	addi	a2,a2,634 # ffffffffc020deb8 <CSWTCH.79+0x670>
ffffffffc0207c46:	43d8                	lw	a4,4(a5)
ffffffffc0207c48:	0d800593          	li	a1,216
ffffffffc0207c4c:	0b478793          	addi	a5,a5,180
ffffffffc0207c50:	00006517          	auipc	a0,0x6
ffffffffc0207c54:	29850513          	addi	a0,a0,664 # ffffffffc020dee8 <CSWTCH.79+0x6a0>
ffffffffc0207c58:	847f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207c5c <__alloc_inode>:
ffffffffc0207c5c:	1141                	addi	sp,sp,-16
ffffffffc0207c5e:	e022                	sd	s0,0(sp)
ffffffffc0207c60:	842a                	mv	s0,a0
ffffffffc0207c62:	07800513          	li	a0,120
ffffffffc0207c66:	e406                	sd	ra,8(sp)
ffffffffc0207c68:	bbafa0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0207c6c:	c111                	beqz	a0,ffffffffc0207c70 <__alloc_inode+0x14>
ffffffffc0207c6e:	cd20                	sw	s0,88(a0)
ffffffffc0207c70:	60a2                	ld	ra,8(sp)
ffffffffc0207c72:	6402                	ld	s0,0(sp)
ffffffffc0207c74:	0141                	addi	sp,sp,16
ffffffffc0207c76:	8082                	ret

ffffffffc0207c78 <inode_init>:
ffffffffc0207c78:	4785                	li	a5,1
ffffffffc0207c7a:	06052023          	sw	zero,96(a0)
ffffffffc0207c7e:	f92c                	sd	a1,112(a0)
ffffffffc0207c80:	f530                	sd	a2,104(a0)
ffffffffc0207c82:	cd7c                	sw	a5,92(a0)
ffffffffc0207c84:	8082                	ret

ffffffffc0207c86 <inode_kill>:
ffffffffc0207c86:	4d78                	lw	a4,92(a0)
ffffffffc0207c88:	1141                	addi	sp,sp,-16
ffffffffc0207c8a:	e406                	sd	ra,8(sp)
ffffffffc0207c8c:	e719                	bnez	a4,ffffffffc0207c9a <inode_kill+0x14>
ffffffffc0207c8e:	513c                	lw	a5,96(a0)
ffffffffc0207c90:	e78d                	bnez	a5,ffffffffc0207cba <inode_kill+0x34>
ffffffffc0207c92:	60a2                	ld	ra,8(sp)
ffffffffc0207c94:	0141                	addi	sp,sp,16
ffffffffc0207c96:	c3cfa06f          	j	ffffffffc02020d2 <kfree>
ffffffffc0207c9a:	00007697          	auipc	a3,0x7
ffffffffc0207c9e:	a6668693          	addi	a3,a3,-1434 # ffffffffc020e700 <syscalls+0x800>
ffffffffc0207ca2:	00004617          	auipc	a2,0x4
ffffffffc0207ca6:	15e60613          	addi	a2,a2,350 # ffffffffc020be00 <commands+0x210>
ffffffffc0207caa:	02900593          	li	a1,41
ffffffffc0207cae:	00007517          	auipc	a0,0x7
ffffffffc0207cb2:	a7250513          	addi	a0,a0,-1422 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207cb6:	fe8f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207cba:	00007697          	auipc	a3,0x7
ffffffffc0207cbe:	a7e68693          	addi	a3,a3,-1410 # ffffffffc020e738 <syscalls+0x838>
ffffffffc0207cc2:	00004617          	auipc	a2,0x4
ffffffffc0207cc6:	13e60613          	addi	a2,a2,318 # ffffffffc020be00 <commands+0x210>
ffffffffc0207cca:	02a00593          	li	a1,42
ffffffffc0207cce:	00007517          	auipc	a0,0x7
ffffffffc0207cd2:	a5250513          	addi	a0,a0,-1454 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207cd6:	fc8f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207cda <inode_ref_inc>:
ffffffffc0207cda:	4d7c                	lw	a5,92(a0)
ffffffffc0207cdc:	2785                	addiw	a5,a5,1
ffffffffc0207cde:	cd7c                	sw	a5,92(a0)
ffffffffc0207ce0:	0007851b          	sext.w	a0,a5
ffffffffc0207ce4:	8082                	ret

ffffffffc0207ce6 <inode_open_inc>:
ffffffffc0207ce6:	513c                	lw	a5,96(a0)
ffffffffc0207ce8:	2785                	addiw	a5,a5,1
ffffffffc0207cea:	d13c                	sw	a5,96(a0)
ffffffffc0207cec:	0007851b          	sext.w	a0,a5
ffffffffc0207cf0:	8082                	ret

ffffffffc0207cf2 <inode_check>:
ffffffffc0207cf2:	1141                	addi	sp,sp,-16
ffffffffc0207cf4:	e406                	sd	ra,8(sp)
ffffffffc0207cf6:	c90d                	beqz	a0,ffffffffc0207d28 <inode_check+0x36>
ffffffffc0207cf8:	793c                	ld	a5,112(a0)
ffffffffc0207cfa:	c79d                	beqz	a5,ffffffffc0207d28 <inode_check+0x36>
ffffffffc0207cfc:	6398                	ld	a4,0(a5)
ffffffffc0207cfe:	4625d7b7          	lui	a5,0x4625d
ffffffffc0207d02:	0786                	slli	a5,a5,0x1
ffffffffc0207d04:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc0207d08:	08f71063          	bne	a4,a5,ffffffffc0207d88 <inode_check+0x96>
ffffffffc0207d0c:	4d78                	lw	a4,92(a0)
ffffffffc0207d0e:	513c                	lw	a5,96(a0)
ffffffffc0207d10:	04f74c63          	blt	a4,a5,ffffffffc0207d68 <inode_check+0x76>
ffffffffc0207d14:	0407ca63          	bltz	a5,ffffffffc0207d68 <inode_check+0x76>
ffffffffc0207d18:	66c1                	lui	a3,0x10
ffffffffc0207d1a:	02d75763          	bge	a4,a3,ffffffffc0207d48 <inode_check+0x56>
ffffffffc0207d1e:	02d7d563          	bge	a5,a3,ffffffffc0207d48 <inode_check+0x56>
ffffffffc0207d22:	60a2                	ld	ra,8(sp)
ffffffffc0207d24:	0141                	addi	sp,sp,16
ffffffffc0207d26:	8082                	ret
ffffffffc0207d28:	00007697          	auipc	a3,0x7
ffffffffc0207d2c:	a3068693          	addi	a3,a3,-1488 # ffffffffc020e758 <syscalls+0x858>
ffffffffc0207d30:	00004617          	auipc	a2,0x4
ffffffffc0207d34:	0d060613          	addi	a2,a2,208 # ffffffffc020be00 <commands+0x210>
ffffffffc0207d38:	06e00593          	li	a1,110
ffffffffc0207d3c:	00007517          	auipc	a0,0x7
ffffffffc0207d40:	9e450513          	addi	a0,a0,-1564 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207d44:	f5af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d48:	00007697          	auipc	a3,0x7
ffffffffc0207d4c:	a9068693          	addi	a3,a3,-1392 # ffffffffc020e7d8 <syscalls+0x8d8>
ffffffffc0207d50:	00004617          	auipc	a2,0x4
ffffffffc0207d54:	0b060613          	addi	a2,a2,176 # ffffffffc020be00 <commands+0x210>
ffffffffc0207d58:	07200593          	li	a1,114
ffffffffc0207d5c:	00007517          	auipc	a0,0x7
ffffffffc0207d60:	9c450513          	addi	a0,a0,-1596 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207d64:	f3af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d68:	00007697          	auipc	a3,0x7
ffffffffc0207d6c:	a4068693          	addi	a3,a3,-1472 # ffffffffc020e7a8 <syscalls+0x8a8>
ffffffffc0207d70:	00004617          	auipc	a2,0x4
ffffffffc0207d74:	09060613          	addi	a2,a2,144 # ffffffffc020be00 <commands+0x210>
ffffffffc0207d78:	07100593          	li	a1,113
ffffffffc0207d7c:	00007517          	auipc	a0,0x7
ffffffffc0207d80:	9a450513          	addi	a0,a0,-1628 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207d84:	f1af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d88:	00007697          	auipc	a3,0x7
ffffffffc0207d8c:	9f868693          	addi	a3,a3,-1544 # ffffffffc020e780 <syscalls+0x880>
ffffffffc0207d90:	00004617          	auipc	a2,0x4
ffffffffc0207d94:	07060613          	addi	a2,a2,112 # ffffffffc020be00 <commands+0x210>
ffffffffc0207d98:	06f00593          	li	a1,111
ffffffffc0207d9c:	00007517          	auipc	a0,0x7
ffffffffc0207da0:	98450513          	addi	a0,a0,-1660 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207da4:	efaf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207da8 <inode_ref_dec>:
ffffffffc0207da8:	4d7c                	lw	a5,92(a0)
ffffffffc0207daa:	1101                	addi	sp,sp,-32
ffffffffc0207dac:	ec06                	sd	ra,24(sp)
ffffffffc0207dae:	e822                	sd	s0,16(sp)
ffffffffc0207db0:	e426                	sd	s1,8(sp)
ffffffffc0207db2:	e04a                	sd	s2,0(sp)
ffffffffc0207db4:	06f05e63          	blez	a5,ffffffffc0207e30 <inode_ref_dec+0x88>
ffffffffc0207db8:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207dbc:	cd64                	sw	s1,92(a0)
ffffffffc0207dbe:	842a                	mv	s0,a0
ffffffffc0207dc0:	e09d                	bnez	s1,ffffffffc0207de6 <inode_ref_dec+0x3e>
ffffffffc0207dc2:	793c                	ld	a5,112(a0)
ffffffffc0207dc4:	c7b1                	beqz	a5,ffffffffc0207e10 <inode_ref_dec+0x68>
ffffffffc0207dc6:	0487b903          	ld	s2,72(a5)
ffffffffc0207dca:	04090363          	beqz	s2,ffffffffc0207e10 <inode_ref_dec+0x68>
ffffffffc0207dce:	00007597          	auipc	a1,0x7
ffffffffc0207dd2:	aba58593          	addi	a1,a1,-1350 # ffffffffc020e888 <syscalls+0x988>
ffffffffc0207dd6:	f1dff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0207dda:	8522                	mv	a0,s0
ffffffffc0207ddc:	9902                	jalr	s2
ffffffffc0207dde:	c501                	beqz	a0,ffffffffc0207de6 <inode_ref_dec+0x3e>
ffffffffc0207de0:	57c5                	li	a5,-15
ffffffffc0207de2:	00f51963          	bne	a0,a5,ffffffffc0207df4 <inode_ref_dec+0x4c>
ffffffffc0207de6:	60e2                	ld	ra,24(sp)
ffffffffc0207de8:	6442                	ld	s0,16(sp)
ffffffffc0207dea:	6902                	ld	s2,0(sp)
ffffffffc0207dec:	8526                	mv	a0,s1
ffffffffc0207dee:	64a2                	ld	s1,8(sp)
ffffffffc0207df0:	6105                	addi	sp,sp,32
ffffffffc0207df2:	8082                	ret
ffffffffc0207df4:	85aa                	mv	a1,a0
ffffffffc0207df6:	00007517          	auipc	a0,0x7
ffffffffc0207dfa:	a9a50513          	addi	a0,a0,-1382 # ffffffffc020e890 <syscalls+0x990>
ffffffffc0207dfe:	ba8f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207e02:	60e2                	ld	ra,24(sp)
ffffffffc0207e04:	6442                	ld	s0,16(sp)
ffffffffc0207e06:	6902                	ld	s2,0(sp)
ffffffffc0207e08:	8526                	mv	a0,s1
ffffffffc0207e0a:	64a2                	ld	s1,8(sp)
ffffffffc0207e0c:	6105                	addi	sp,sp,32
ffffffffc0207e0e:	8082                	ret
ffffffffc0207e10:	00007697          	auipc	a3,0x7
ffffffffc0207e14:	a2868693          	addi	a3,a3,-1496 # ffffffffc020e838 <syscalls+0x938>
ffffffffc0207e18:	00004617          	auipc	a2,0x4
ffffffffc0207e1c:	fe860613          	addi	a2,a2,-24 # ffffffffc020be00 <commands+0x210>
ffffffffc0207e20:	04400593          	li	a1,68
ffffffffc0207e24:	00007517          	auipc	a0,0x7
ffffffffc0207e28:	8fc50513          	addi	a0,a0,-1796 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207e2c:	e72f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e30:	00007697          	auipc	a3,0x7
ffffffffc0207e34:	9e868693          	addi	a3,a3,-1560 # ffffffffc020e818 <syscalls+0x918>
ffffffffc0207e38:	00004617          	auipc	a2,0x4
ffffffffc0207e3c:	fc860613          	addi	a2,a2,-56 # ffffffffc020be00 <commands+0x210>
ffffffffc0207e40:	03f00593          	li	a1,63
ffffffffc0207e44:	00007517          	auipc	a0,0x7
ffffffffc0207e48:	8dc50513          	addi	a0,a0,-1828 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207e4c:	e52f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e50 <inode_open_dec>:
ffffffffc0207e50:	513c                	lw	a5,96(a0)
ffffffffc0207e52:	1101                	addi	sp,sp,-32
ffffffffc0207e54:	ec06                	sd	ra,24(sp)
ffffffffc0207e56:	e822                	sd	s0,16(sp)
ffffffffc0207e58:	e426                	sd	s1,8(sp)
ffffffffc0207e5a:	e04a                	sd	s2,0(sp)
ffffffffc0207e5c:	06f05b63          	blez	a5,ffffffffc0207ed2 <inode_open_dec+0x82>
ffffffffc0207e60:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207e64:	d124                	sw	s1,96(a0)
ffffffffc0207e66:	842a                	mv	s0,a0
ffffffffc0207e68:	e085                	bnez	s1,ffffffffc0207e88 <inode_open_dec+0x38>
ffffffffc0207e6a:	793c                	ld	a5,112(a0)
ffffffffc0207e6c:	c3b9                	beqz	a5,ffffffffc0207eb2 <inode_open_dec+0x62>
ffffffffc0207e6e:	0107b903          	ld	s2,16(a5)
ffffffffc0207e72:	04090063          	beqz	s2,ffffffffc0207eb2 <inode_open_dec+0x62>
ffffffffc0207e76:	00007597          	auipc	a1,0x7
ffffffffc0207e7a:	aaa58593          	addi	a1,a1,-1366 # ffffffffc020e920 <syscalls+0xa20>
ffffffffc0207e7e:	e75ff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0207e82:	8522                	mv	a0,s0
ffffffffc0207e84:	9902                	jalr	s2
ffffffffc0207e86:	e901                	bnez	a0,ffffffffc0207e96 <inode_open_dec+0x46>
ffffffffc0207e88:	60e2                	ld	ra,24(sp)
ffffffffc0207e8a:	6442                	ld	s0,16(sp)
ffffffffc0207e8c:	6902                	ld	s2,0(sp)
ffffffffc0207e8e:	8526                	mv	a0,s1
ffffffffc0207e90:	64a2                	ld	s1,8(sp)
ffffffffc0207e92:	6105                	addi	sp,sp,32
ffffffffc0207e94:	8082                	ret
ffffffffc0207e96:	85aa                	mv	a1,a0
ffffffffc0207e98:	00007517          	auipc	a0,0x7
ffffffffc0207e9c:	a9050513          	addi	a0,a0,-1392 # ffffffffc020e928 <syscalls+0xa28>
ffffffffc0207ea0:	b06f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207ea4:	60e2                	ld	ra,24(sp)
ffffffffc0207ea6:	6442                	ld	s0,16(sp)
ffffffffc0207ea8:	6902                	ld	s2,0(sp)
ffffffffc0207eaa:	8526                	mv	a0,s1
ffffffffc0207eac:	64a2                	ld	s1,8(sp)
ffffffffc0207eae:	6105                	addi	sp,sp,32
ffffffffc0207eb0:	8082                	ret
ffffffffc0207eb2:	00007697          	auipc	a3,0x7
ffffffffc0207eb6:	a1e68693          	addi	a3,a3,-1506 # ffffffffc020e8d0 <syscalls+0x9d0>
ffffffffc0207eba:	00004617          	auipc	a2,0x4
ffffffffc0207ebe:	f4660613          	addi	a2,a2,-186 # ffffffffc020be00 <commands+0x210>
ffffffffc0207ec2:	06100593          	li	a1,97
ffffffffc0207ec6:	00007517          	auipc	a0,0x7
ffffffffc0207eca:	85a50513          	addi	a0,a0,-1958 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207ece:	dd0f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ed2:	00007697          	auipc	a3,0x7
ffffffffc0207ed6:	9de68693          	addi	a3,a3,-1570 # ffffffffc020e8b0 <syscalls+0x9b0>
ffffffffc0207eda:	00004617          	auipc	a2,0x4
ffffffffc0207ede:	f2660613          	addi	a2,a2,-218 # ffffffffc020be00 <commands+0x210>
ffffffffc0207ee2:	05c00593          	li	a1,92
ffffffffc0207ee6:	00007517          	auipc	a0,0x7
ffffffffc0207eea:	83a50513          	addi	a0,a0,-1990 # ffffffffc020e720 <syscalls+0x820>
ffffffffc0207eee:	db0f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ef2 <__alloc_fs>:
ffffffffc0207ef2:	1141                	addi	sp,sp,-16
ffffffffc0207ef4:	e022                	sd	s0,0(sp)
ffffffffc0207ef6:	842a                	mv	s0,a0
ffffffffc0207ef8:	0d800513          	li	a0,216
ffffffffc0207efc:	e406                	sd	ra,8(sp)
ffffffffc0207efe:	924fa0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0207f02:	c119                	beqz	a0,ffffffffc0207f08 <__alloc_fs+0x16>
ffffffffc0207f04:	0a852823          	sw	s0,176(a0)
ffffffffc0207f08:	60a2                	ld	ra,8(sp)
ffffffffc0207f0a:	6402                	ld	s0,0(sp)
ffffffffc0207f0c:	0141                	addi	sp,sp,16
ffffffffc0207f0e:	8082                	ret

ffffffffc0207f10 <vfs_init>:
ffffffffc0207f10:	1141                	addi	sp,sp,-16
ffffffffc0207f12:	4585                	li	a1,1
ffffffffc0207f14:	0008e517          	auipc	a0,0x8e
ffffffffc0207f18:	8ec50513          	addi	a0,a0,-1812 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207f1c:	e406                	sd	ra,8(sp)
ffffffffc0207f1e:	ed4fc0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc0207f22:	60a2                	ld	ra,8(sp)
ffffffffc0207f24:	0141                	addi	sp,sp,16
ffffffffc0207f26:	a40d                	j	ffffffffc0208148 <vfs_devlist_init>

ffffffffc0207f28 <vfs_set_bootfs>:
ffffffffc0207f28:	7179                	addi	sp,sp,-48
ffffffffc0207f2a:	f022                	sd	s0,32(sp)
ffffffffc0207f2c:	f406                	sd	ra,40(sp)
ffffffffc0207f2e:	ec26                	sd	s1,24(sp)
ffffffffc0207f30:	e402                	sd	zero,8(sp)
ffffffffc0207f32:	842a                	mv	s0,a0
ffffffffc0207f34:	c915                	beqz	a0,ffffffffc0207f68 <vfs_set_bootfs+0x40>
ffffffffc0207f36:	03a00593          	li	a1,58
ffffffffc0207f3a:	1c9030ef          	jal	ra,ffffffffc020b902 <strchr>
ffffffffc0207f3e:	c135                	beqz	a0,ffffffffc0207fa2 <vfs_set_bootfs+0x7a>
ffffffffc0207f40:	00154783          	lbu	a5,1(a0)
ffffffffc0207f44:	efb9                	bnez	a5,ffffffffc0207fa2 <vfs_set_bootfs+0x7a>
ffffffffc0207f46:	8522                	mv	a0,s0
ffffffffc0207f48:	11f000ef          	jal	ra,ffffffffc0208866 <vfs_chdir>
ffffffffc0207f4c:	842a                	mv	s0,a0
ffffffffc0207f4e:	c519                	beqz	a0,ffffffffc0207f5c <vfs_set_bootfs+0x34>
ffffffffc0207f50:	70a2                	ld	ra,40(sp)
ffffffffc0207f52:	8522                	mv	a0,s0
ffffffffc0207f54:	7402                	ld	s0,32(sp)
ffffffffc0207f56:	64e2                	ld	s1,24(sp)
ffffffffc0207f58:	6145                	addi	sp,sp,48
ffffffffc0207f5a:	8082                	ret
ffffffffc0207f5c:	0028                	addi	a0,sp,8
ffffffffc0207f5e:	013000ef          	jal	ra,ffffffffc0208770 <vfs_get_curdir>
ffffffffc0207f62:	842a                	mv	s0,a0
ffffffffc0207f64:	f575                	bnez	a0,ffffffffc0207f50 <vfs_set_bootfs+0x28>
ffffffffc0207f66:	6422                	ld	s0,8(sp)
ffffffffc0207f68:	0008e517          	auipc	a0,0x8e
ffffffffc0207f6c:	89850513          	addi	a0,a0,-1896 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207f70:	e8cfc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0207f74:	0008f797          	auipc	a5,0x8f
ffffffffc0207f78:	97c78793          	addi	a5,a5,-1668 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207f7c:	6384                	ld	s1,0(a5)
ffffffffc0207f7e:	0008e517          	auipc	a0,0x8e
ffffffffc0207f82:	88250513          	addi	a0,a0,-1918 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207f86:	e380                	sd	s0,0(a5)
ffffffffc0207f88:	4401                	li	s0,0
ffffffffc0207f8a:	e6efc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207f8e:	d0e9                	beqz	s1,ffffffffc0207f50 <vfs_set_bootfs+0x28>
ffffffffc0207f90:	8526                	mv	a0,s1
ffffffffc0207f92:	e17ff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc0207f96:	70a2                	ld	ra,40(sp)
ffffffffc0207f98:	8522                	mv	a0,s0
ffffffffc0207f9a:	7402                	ld	s0,32(sp)
ffffffffc0207f9c:	64e2                	ld	s1,24(sp)
ffffffffc0207f9e:	6145                	addi	sp,sp,48
ffffffffc0207fa0:	8082                	ret
ffffffffc0207fa2:	5475                	li	s0,-3
ffffffffc0207fa4:	b775                	j	ffffffffc0207f50 <vfs_set_bootfs+0x28>

ffffffffc0207fa6 <vfs_get_bootfs>:
ffffffffc0207fa6:	1101                	addi	sp,sp,-32
ffffffffc0207fa8:	e426                	sd	s1,8(sp)
ffffffffc0207faa:	0008f497          	auipc	s1,0x8f
ffffffffc0207fae:	94648493          	addi	s1,s1,-1722 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207fb2:	609c                	ld	a5,0(s1)
ffffffffc0207fb4:	ec06                	sd	ra,24(sp)
ffffffffc0207fb6:	e822                	sd	s0,16(sp)
ffffffffc0207fb8:	c3a1                	beqz	a5,ffffffffc0207ff8 <vfs_get_bootfs+0x52>
ffffffffc0207fba:	842a                	mv	s0,a0
ffffffffc0207fbc:	0008e517          	auipc	a0,0x8e
ffffffffc0207fc0:	84450513          	addi	a0,a0,-1980 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207fc4:	e38fc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0207fc8:	6084                	ld	s1,0(s1)
ffffffffc0207fca:	c08d                	beqz	s1,ffffffffc0207fec <vfs_get_bootfs+0x46>
ffffffffc0207fcc:	8526                	mv	a0,s1
ffffffffc0207fce:	d0dff0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc0207fd2:	0008e517          	auipc	a0,0x8e
ffffffffc0207fd6:	82e50513          	addi	a0,a0,-2002 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207fda:	e1efc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207fde:	4501                	li	a0,0
ffffffffc0207fe0:	e004                	sd	s1,0(s0)
ffffffffc0207fe2:	60e2                	ld	ra,24(sp)
ffffffffc0207fe4:	6442                	ld	s0,16(sp)
ffffffffc0207fe6:	64a2                	ld	s1,8(sp)
ffffffffc0207fe8:	6105                	addi	sp,sp,32
ffffffffc0207fea:	8082                	ret
ffffffffc0207fec:	0008e517          	auipc	a0,0x8e
ffffffffc0207ff0:	81450513          	addi	a0,a0,-2028 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207ff4:	e04fc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207ff8:	5541                	li	a0,-16
ffffffffc0207ffa:	b7e5                	j	ffffffffc0207fe2 <vfs_get_bootfs+0x3c>

ffffffffc0207ffc <vfs_do_add>:
ffffffffc0207ffc:	7139                	addi	sp,sp,-64
ffffffffc0207ffe:	fc06                	sd	ra,56(sp)
ffffffffc0208000:	f822                	sd	s0,48(sp)
ffffffffc0208002:	f426                	sd	s1,40(sp)
ffffffffc0208004:	f04a                	sd	s2,32(sp)
ffffffffc0208006:	ec4e                	sd	s3,24(sp)
ffffffffc0208008:	e852                	sd	s4,16(sp)
ffffffffc020800a:	e456                	sd	s5,8(sp)
ffffffffc020800c:	e05a                	sd	s6,0(sp)
ffffffffc020800e:	0e050b63          	beqz	a0,ffffffffc0208104 <vfs_do_add+0x108>
ffffffffc0208012:	842a                	mv	s0,a0
ffffffffc0208014:	8a2e                	mv	s4,a1
ffffffffc0208016:	8b32                	mv	s6,a2
ffffffffc0208018:	8ab6                	mv	s5,a3
ffffffffc020801a:	c5cd                	beqz	a1,ffffffffc02080c4 <vfs_do_add+0xc8>
ffffffffc020801c:	4db8                	lw	a4,88(a1)
ffffffffc020801e:	6785                	lui	a5,0x1
ffffffffc0208020:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208024:	0af71163          	bne	a4,a5,ffffffffc02080c6 <vfs_do_add+0xca>
ffffffffc0208028:	8522                	mv	a0,s0
ffffffffc020802a:	04d030ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc020802e:	47fd                	li	a5,31
ffffffffc0208030:	0ca7e663          	bltu	a5,a0,ffffffffc02080fc <vfs_do_add+0x100>
ffffffffc0208034:	8522                	mv	a0,s0
ffffffffc0208036:	9bef80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc020803a:	84aa                	mv	s1,a0
ffffffffc020803c:	c171                	beqz	a0,ffffffffc0208100 <vfs_do_add+0x104>
ffffffffc020803e:	03000513          	li	a0,48
ffffffffc0208042:	fe1f90ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0208046:	89aa                	mv	s3,a0
ffffffffc0208048:	c92d                	beqz	a0,ffffffffc02080ba <vfs_do_add+0xbe>
ffffffffc020804a:	0008d517          	auipc	a0,0x8d
ffffffffc020804e:	7de50513          	addi	a0,a0,2014 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0208052:	0008d917          	auipc	s2,0x8d
ffffffffc0208056:	7c690913          	addi	s2,s2,1990 # ffffffffc0295818 <vdev_list>
ffffffffc020805a:	da2fc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020805e:	844a                	mv	s0,s2
ffffffffc0208060:	a039                	j	ffffffffc020806e <vfs_do_add+0x72>
ffffffffc0208062:	fe043503          	ld	a0,-32(s0)
ffffffffc0208066:	85a6                	mv	a1,s1
ffffffffc0208068:	057030ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc020806c:	cd2d                	beqz	a0,ffffffffc02080e6 <vfs_do_add+0xea>
ffffffffc020806e:	6400                	ld	s0,8(s0)
ffffffffc0208070:	ff2419e3          	bne	s0,s2,ffffffffc0208062 <vfs_do_add+0x66>
ffffffffc0208074:	6418                	ld	a4,8(s0)
ffffffffc0208076:	02098793          	addi	a5,s3,32
ffffffffc020807a:	0099b023          	sd	s1,0(s3)
ffffffffc020807e:	0149b423          	sd	s4,8(s3)
ffffffffc0208082:	0159bc23          	sd	s5,24(s3)
ffffffffc0208086:	0169b823          	sd	s6,16(s3)
ffffffffc020808a:	e31c                	sd	a5,0(a4)
ffffffffc020808c:	0289b023          	sd	s0,32(s3)
ffffffffc0208090:	02e9b423          	sd	a4,40(s3)
ffffffffc0208094:	0008d517          	auipc	a0,0x8d
ffffffffc0208098:	79450513          	addi	a0,a0,1940 # ffffffffc0295828 <vdev_list_sem>
ffffffffc020809c:	e41c                	sd	a5,8(s0)
ffffffffc020809e:	4401                	li	s0,0
ffffffffc02080a0:	d58fc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02080a4:	70e2                	ld	ra,56(sp)
ffffffffc02080a6:	8522                	mv	a0,s0
ffffffffc02080a8:	7442                	ld	s0,48(sp)
ffffffffc02080aa:	74a2                	ld	s1,40(sp)
ffffffffc02080ac:	7902                	ld	s2,32(sp)
ffffffffc02080ae:	69e2                	ld	s3,24(sp)
ffffffffc02080b0:	6a42                	ld	s4,16(sp)
ffffffffc02080b2:	6aa2                	ld	s5,8(sp)
ffffffffc02080b4:	6b02                	ld	s6,0(sp)
ffffffffc02080b6:	6121                	addi	sp,sp,64
ffffffffc02080b8:	8082                	ret
ffffffffc02080ba:	5471                	li	s0,-4
ffffffffc02080bc:	8526                	mv	a0,s1
ffffffffc02080be:	814fa0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02080c2:	b7cd                	j	ffffffffc02080a4 <vfs_do_add+0xa8>
ffffffffc02080c4:	d2b5                	beqz	a3,ffffffffc0208028 <vfs_do_add+0x2c>
ffffffffc02080c6:	00007697          	auipc	a3,0x7
ffffffffc02080ca:	8aa68693          	addi	a3,a3,-1878 # ffffffffc020e970 <syscalls+0xa70>
ffffffffc02080ce:	00004617          	auipc	a2,0x4
ffffffffc02080d2:	d3260613          	addi	a2,a2,-718 # ffffffffc020be00 <commands+0x210>
ffffffffc02080d6:	08f00593          	li	a1,143
ffffffffc02080da:	00007517          	auipc	a0,0x7
ffffffffc02080de:	87e50513          	addi	a0,a0,-1922 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc02080e2:	bbcf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02080e6:	0008d517          	auipc	a0,0x8d
ffffffffc02080ea:	74250513          	addi	a0,a0,1858 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02080ee:	d0afc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02080f2:	854e                	mv	a0,s3
ffffffffc02080f4:	fdff90ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02080f8:	5425                	li	s0,-23
ffffffffc02080fa:	b7c9                	j	ffffffffc02080bc <vfs_do_add+0xc0>
ffffffffc02080fc:	5451                	li	s0,-12
ffffffffc02080fe:	b75d                	j	ffffffffc02080a4 <vfs_do_add+0xa8>
ffffffffc0208100:	5471                	li	s0,-4
ffffffffc0208102:	b74d                	j	ffffffffc02080a4 <vfs_do_add+0xa8>
ffffffffc0208104:	00007697          	auipc	a3,0x7
ffffffffc0208108:	84468693          	addi	a3,a3,-1980 # ffffffffc020e948 <syscalls+0xa48>
ffffffffc020810c:	00004617          	auipc	a2,0x4
ffffffffc0208110:	cf460613          	addi	a2,a2,-780 # ffffffffc020be00 <commands+0x210>
ffffffffc0208114:	08e00593          	li	a1,142
ffffffffc0208118:	00007517          	auipc	a0,0x7
ffffffffc020811c:	84050513          	addi	a0,a0,-1984 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc0208120:	b7ef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208124 <find_mount.part.0>:
ffffffffc0208124:	1141                	addi	sp,sp,-16
ffffffffc0208126:	00007697          	auipc	a3,0x7
ffffffffc020812a:	82268693          	addi	a3,a3,-2014 # ffffffffc020e948 <syscalls+0xa48>
ffffffffc020812e:	00004617          	auipc	a2,0x4
ffffffffc0208132:	cd260613          	addi	a2,a2,-814 # ffffffffc020be00 <commands+0x210>
ffffffffc0208136:	0cd00593          	li	a1,205
ffffffffc020813a:	00007517          	auipc	a0,0x7
ffffffffc020813e:	81e50513          	addi	a0,a0,-2018 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc0208142:	e406                	sd	ra,8(sp)
ffffffffc0208144:	b5af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208148 <vfs_devlist_init>:
ffffffffc0208148:	0008d797          	auipc	a5,0x8d
ffffffffc020814c:	6d078793          	addi	a5,a5,1744 # ffffffffc0295818 <vdev_list>
ffffffffc0208150:	4585                	li	a1,1
ffffffffc0208152:	0008d517          	auipc	a0,0x8d
ffffffffc0208156:	6d650513          	addi	a0,a0,1750 # ffffffffc0295828 <vdev_list_sem>
ffffffffc020815a:	e79c                	sd	a5,8(a5)
ffffffffc020815c:	e39c                	sd	a5,0(a5)
ffffffffc020815e:	c94fc06f          	j	ffffffffc02045f2 <sem_init>

ffffffffc0208162 <vfs_cleanup>:
ffffffffc0208162:	1101                	addi	sp,sp,-32
ffffffffc0208164:	e426                	sd	s1,8(sp)
ffffffffc0208166:	0008d497          	auipc	s1,0x8d
ffffffffc020816a:	6b248493          	addi	s1,s1,1714 # ffffffffc0295818 <vdev_list>
ffffffffc020816e:	649c                	ld	a5,8(s1)
ffffffffc0208170:	ec06                	sd	ra,24(sp)
ffffffffc0208172:	e822                	sd	s0,16(sp)
ffffffffc0208174:	02978e63          	beq	a5,s1,ffffffffc02081b0 <vfs_cleanup+0x4e>
ffffffffc0208178:	0008d517          	auipc	a0,0x8d
ffffffffc020817c:	6b050513          	addi	a0,a0,1712 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0208180:	c7cfc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0208184:	6480                	ld	s0,8(s1)
ffffffffc0208186:	00940b63          	beq	s0,s1,ffffffffc020819c <vfs_cleanup+0x3a>
ffffffffc020818a:	ff043783          	ld	a5,-16(s0)
ffffffffc020818e:	853e                	mv	a0,a5
ffffffffc0208190:	c399                	beqz	a5,ffffffffc0208196 <vfs_cleanup+0x34>
ffffffffc0208192:	6bfc                	ld	a5,208(a5)
ffffffffc0208194:	9782                	jalr	a5
ffffffffc0208196:	6400                	ld	s0,8(s0)
ffffffffc0208198:	fe9419e3          	bne	s0,s1,ffffffffc020818a <vfs_cleanup+0x28>
ffffffffc020819c:	6442                	ld	s0,16(sp)
ffffffffc020819e:	60e2                	ld	ra,24(sp)
ffffffffc02081a0:	64a2                	ld	s1,8(sp)
ffffffffc02081a2:	0008d517          	auipc	a0,0x8d
ffffffffc02081a6:	68650513          	addi	a0,a0,1670 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02081aa:	6105                	addi	sp,sp,32
ffffffffc02081ac:	c4cfc06f          	j	ffffffffc02045f8 <up>
ffffffffc02081b0:	60e2                	ld	ra,24(sp)
ffffffffc02081b2:	6442                	ld	s0,16(sp)
ffffffffc02081b4:	64a2                	ld	s1,8(sp)
ffffffffc02081b6:	6105                	addi	sp,sp,32
ffffffffc02081b8:	8082                	ret

ffffffffc02081ba <vfs_get_root>:
ffffffffc02081ba:	7179                	addi	sp,sp,-48
ffffffffc02081bc:	f406                	sd	ra,40(sp)
ffffffffc02081be:	f022                	sd	s0,32(sp)
ffffffffc02081c0:	ec26                	sd	s1,24(sp)
ffffffffc02081c2:	e84a                	sd	s2,16(sp)
ffffffffc02081c4:	e44e                	sd	s3,8(sp)
ffffffffc02081c6:	e052                	sd	s4,0(sp)
ffffffffc02081c8:	c541                	beqz	a0,ffffffffc0208250 <vfs_get_root+0x96>
ffffffffc02081ca:	0008d917          	auipc	s2,0x8d
ffffffffc02081ce:	64e90913          	addi	s2,s2,1614 # ffffffffc0295818 <vdev_list>
ffffffffc02081d2:	00893783          	ld	a5,8(s2)
ffffffffc02081d6:	07278b63          	beq	a5,s2,ffffffffc020824c <vfs_get_root+0x92>
ffffffffc02081da:	89aa                	mv	s3,a0
ffffffffc02081dc:	0008d517          	auipc	a0,0x8d
ffffffffc02081e0:	64c50513          	addi	a0,a0,1612 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02081e4:	8a2e                	mv	s4,a1
ffffffffc02081e6:	844a                	mv	s0,s2
ffffffffc02081e8:	c14fc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc02081ec:	a801                	j	ffffffffc02081fc <vfs_get_root+0x42>
ffffffffc02081ee:	fe043583          	ld	a1,-32(s0)
ffffffffc02081f2:	854e                	mv	a0,s3
ffffffffc02081f4:	6ca030ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc02081f8:	84aa                	mv	s1,a0
ffffffffc02081fa:	c505                	beqz	a0,ffffffffc0208222 <vfs_get_root+0x68>
ffffffffc02081fc:	6400                	ld	s0,8(s0)
ffffffffc02081fe:	ff2418e3          	bne	s0,s2,ffffffffc02081ee <vfs_get_root+0x34>
ffffffffc0208202:	54cd                	li	s1,-13
ffffffffc0208204:	0008d517          	auipc	a0,0x8d
ffffffffc0208208:	62450513          	addi	a0,a0,1572 # ffffffffc0295828 <vdev_list_sem>
ffffffffc020820c:	becfc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0208210:	70a2                	ld	ra,40(sp)
ffffffffc0208212:	7402                	ld	s0,32(sp)
ffffffffc0208214:	6942                	ld	s2,16(sp)
ffffffffc0208216:	69a2                	ld	s3,8(sp)
ffffffffc0208218:	6a02                	ld	s4,0(sp)
ffffffffc020821a:	8526                	mv	a0,s1
ffffffffc020821c:	64e2                	ld	s1,24(sp)
ffffffffc020821e:	6145                	addi	sp,sp,48
ffffffffc0208220:	8082                	ret
ffffffffc0208222:	ff043503          	ld	a0,-16(s0)
ffffffffc0208226:	c519                	beqz	a0,ffffffffc0208234 <vfs_get_root+0x7a>
ffffffffc0208228:	617c                	ld	a5,192(a0)
ffffffffc020822a:	9782                	jalr	a5
ffffffffc020822c:	c519                	beqz	a0,ffffffffc020823a <vfs_get_root+0x80>
ffffffffc020822e:	00aa3023          	sd	a0,0(s4)
ffffffffc0208232:	bfc9                	j	ffffffffc0208204 <vfs_get_root+0x4a>
ffffffffc0208234:	ff843783          	ld	a5,-8(s0)
ffffffffc0208238:	c399                	beqz	a5,ffffffffc020823e <vfs_get_root+0x84>
ffffffffc020823a:	54c9                	li	s1,-14
ffffffffc020823c:	b7e1                	j	ffffffffc0208204 <vfs_get_root+0x4a>
ffffffffc020823e:	fe843503          	ld	a0,-24(s0)
ffffffffc0208242:	a99ff0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc0208246:	fe843503          	ld	a0,-24(s0)
ffffffffc020824a:	b7cd                	j	ffffffffc020822c <vfs_get_root+0x72>
ffffffffc020824c:	54cd                	li	s1,-13
ffffffffc020824e:	b7c9                	j	ffffffffc0208210 <vfs_get_root+0x56>
ffffffffc0208250:	00006697          	auipc	a3,0x6
ffffffffc0208254:	6f868693          	addi	a3,a3,1784 # ffffffffc020e948 <syscalls+0xa48>
ffffffffc0208258:	00004617          	auipc	a2,0x4
ffffffffc020825c:	ba860613          	addi	a2,a2,-1112 # ffffffffc020be00 <commands+0x210>
ffffffffc0208260:	04500593          	li	a1,69
ffffffffc0208264:	00006517          	auipc	a0,0x6
ffffffffc0208268:	6f450513          	addi	a0,a0,1780 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc020826c:	a32f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208270 <vfs_get_devname>:
ffffffffc0208270:	0008d697          	auipc	a3,0x8d
ffffffffc0208274:	5a868693          	addi	a3,a3,1448 # ffffffffc0295818 <vdev_list>
ffffffffc0208278:	87b6                	mv	a5,a3
ffffffffc020827a:	e511                	bnez	a0,ffffffffc0208286 <vfs_get_devname+0x16>
ffffffffc020827c:	a829                	j	ffffffffc0208296 <vfs_get_devname+0x26>
ffffffffc020827e:	ff07b703          	ld	a4,-16(a5)
ffffffffc0208282:	00a70763          	beq	a4,a0,ffffffffc0208290 <vfs_get_devname+0x20>
ffffffffc0208286:	679c                	ld	a5,8(a5)
ffffffffc0208288:	fed79be3          	bne	a5,a3,ffffffffc020827e <vfs_get_devname+0xe>
ffffffffc020828c:	4501                	li	a0,0
ffffffffc020828e:	8082                	ret
ffffffffc0208290:	fe07b503          	ld	a0,-32(a5)
ffffffffc0208294:	8082                	ret
ffffffffc0208296:	1141                	addi	sp,sp,-16
ffffffffc0208298:	00006697          	auipc	a3,0x6
ffffffffc020829c:	73868693          	addi	a3,a3,1848 # ffffffffc020e9d0 <syscalls+0xad0>
ffffffffc02082a0:	00004617          	auipc	a2,0x4
ffffffffc02082a4:	b6060613          	addi	a2,a2,-1184 # ffffffffc020be00 <commands+0x210>
ffffffffc02082a8:	06a00593          	li	a1,106
ffffffffc02082ac:	00006517          	auipc	a0,0x6
ffffffffc02082b0:	6ac50513          	addi	a0,a0,1708 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc02082b4:	e406                	sd	ra,8(sp)
ffffffffc02082b6:	9e8f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02082ba <vfs_add_dev>:
ffffffffc02082ba:	86b2                	mv	a3,a2
ffffffffc02082bc:	4601                	li	a2,0
ffffffffc02082be:	d3fff06f          	j	ffffffffc0207ffc <vfs_do_add>

ffffffffc02082c2 <vfs_mount>:
ffffffffc02082c2:	7179                	addi	sp,sp,-48
ffffffffc02082c4:	e84a                	sd	s2,16(sp)
ffffffffc02082c6:	892a                	mv	s2,a0
ffffffffc02082c8:	0008d517          	auipc	a0,0x8d
ffffffffc02082cc:	56050513          	addi	a0,a0,1376 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02082d0:	e44e                	sd	s3,8(sp)
ffffffffc02082d2:	f406                	sd	ra,40(sp)
ffffffffc02082d4:	f022                	sd	s0,32(sp)
ffffffffc02082d6:	ec26                	sd	s1,24(sp)
ffffffffc02082d8:	89ae                	mv	s3,a1
ffffffffc02082da:	b22fc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc02082de:	08090a63          	beqz	s2,ffffffffc0208372 <vfs_mount+0xb0>
ffffffffc02082e2:	0008d497          	auipc	s1,0x8d
ffffffffc02082e6:	53648493          	addi	s1,s1,1334 # ffffffffc0295818 <vdev_list>
ffffffffc02082ea:	6480                	ld	s0,8(s1)
ffffffffc02082ec:	00941663          	bne	s0,s1,ffffffffc02082f8 <vfs_mount+0x36>
ffffffffc02082f0:	a8ad                	j	ffffffffc020836a <vfs_mount+0xa8>
ffffffffc02082f2:	6400                	ld	s0,8(s0)
ffffffffc02082f4:	06940b63          	beq	s0,s1,ffffffffc020836a <vfs_mount+0xa8>
ffffffffc02082f8:	ff843783          	ld	a5,-8(s0)
ffffffffc02082fc:	dbfd                	beqz	a5,ffffffffc02082f2 <vfs_mount+0x30>
ffffffffc02082fe:	fe043503          	ld	a0,-32(s0)
ffffffffc0208302:	85ca                	mv	a1,s2
ffffffffc0208304:	5ba030ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc0208308:	f56d                	bnez	a0,ffffffffc02082f2 <vfs_mount+0x30>
ffffffffc020830a:	ff043783          	ld	a5,-16(s0)
ffffffffc020830e:	e3a5                	bnez	a5,ffffffffc020836e <vfs_mount+0xac>
ffffffffc0208310:	fe043783          	ld	a5,-32(s0)
ffffffffc0208314:	c3c9                	beqz	a5,ffffffffc0208396 <vfs_mount+0xd4>
ffffffffc0208316:	ff843783          	ld	a5,-8(s0)
ffffffffc020831a:	cfb5                	beqz	a5,ffffffffc0208396 <vfs_mount+0xd4>
ffffffffc020831c:	fe843503          	ld	a0,-24(s0)
ffffffffc0208320:	c939                	beqz	a0,ffffffffc0208376 <vfs_mount+0xb4>
ffffffffc0208322:	4d38                	lw	a4,88(a0)
ffffffffc0208324:	6785                	lui	a5,0x1
ffffffffc0208326:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020832a:	04f71663          	bne	a4,a5,ffffffffc0208376 <vfs_mount+0xb4>
ffffffffc020832e:	ff040593          	addi	a1,s0,-16
ffffffffc0208332:	9982                	jalr	s3
ffffffffc0208334:	84aa                	mv	s1,a0
ffffffffc0208336:	ed01                	bnez	a0,ffffffffc020834e <vfs_mount+0x8c>
ffffffffc0208338:	ff043783          	ld	a5,-16(s0)
ffffffffc020833c:	cfad                	beqz	a5,ffffffffc02083b6 <vfs_mount+0xf4>
ffffffffc020833e:	fe043583          	ld	a1,-32(s0)
ffffffffc0208342:	00006517          	auipc	a0,0x6
ffffffffc0208346:	71e50513          	addi	a0,a0,1822 # ffffffffc020ea60 <syscalls+0xb60>
ffffffffc020834a:	e5df70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020834e:	0008d517          	auipc	a0,0x8d
ffffffffc0208352:	4da50513          	addi	a0,a0,1242 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0208356:	aa2fc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020835a:	70a2                	ld	ra,40(sp)
ffffffffc020835c:	7402                	ld	s0,32(sp)
ffffffffc020835e:	6942                	ld	s2,16(sp)
ffffffffc0208360:	69a2                	ld	s3,8(sp)
ffffffffc0208362:	8526                	mv	a0,s1
ffffffffc0208364:	64e2                	ld	s1,24(sp)
ffffffffc0208366:	6145                	addi	sp,sp,48
ffffffffc0208368:	8082                	ret
ffffffffc020836a:	54cd                	li	s1,-13
ffffffffc020836c:	b7cd                	j	ffffffffc020834e <vfs_mount+0x8c>
ffffffffc020836e:	54c5                	li	s1,-15
ffffffffc0208370:	bff9                	j	ffffffffc020834e <vfs_mount+0x8c>
ffffffffc0208372:	db3ff0ef          	jal	ra,ffffffffc0208124 <find_mount.part.0>
ffffffffc0208376:	00006697          	auipc	a3,0x6
ffffffffc020837a:	69a68693          	addi	a3,a3,1690 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc020837e:	00004617          	auipc	a2,0x4
ffffffffc0208382:	a8260613          	addi	a2,a2,-1406 # ffffffffc020be00 <commands+0x210>
ffffffffc0208386:	0ed00593          	li	a1,237
ffffffffc020838a:	00006517          	auipc	a0,0x6
ffffffffc020838e:	5ce50513          	addi	a0,a0,1486 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc0208392:	90cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208396:	00006697          	auipc	a3,0x6
ffffffffc020839a:	64a68693          	addi	a3,a3,1610 # ffffffffc020e9e0 <syscalls+0xae0>
ffffffffc020839e:	00004617          	auipc	a2,0x4
ffffffffc02083a2:	a6260613          	addi	a2,a2,-1438 # ffffffffc020be00 <commands+0x210>
ffffffffc02083a6:	0eb00593          	li	a1,235
ffffffffc02083aa:	00006517          	auipc	a0,0x6
ffffffffc02083ae:	5ae50513          	addi	a0,a0,1454 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc02083b2:	8ecf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02083b6:	00006697          	auipc	a3,0x6
ffffffffc02083ba:	69268693          	addi	a3,a3,1682 # ffffffffc020ea48 <syscalls+0xb48>
ffffffffc02083be:	00004617          	auipc	a2,0x4
ffffffffc02083c2:	a4260613          	addi	a2,a2,-1470 # ffffffffc020be00 <commands+0x210>
ffffffffc02083c6:	0ef00593          	li	a1,239
ffffffffc02083ca:	00006517          	auipc	a0,0x6
ffffffffc02083ce:	58e50513          	addi	a0,a0,1422 # ffffffffc020e958 <syscalls+0xa58>
ffffffffc02083d2:	8ccf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02083d6 <vfs_open>:
ffffffffc02083d6:	711d                	addi	sp,sp,-96
ffffffffc02083d8:	e4a6                	sd	s1,72(sp)
ffffffffc02083da:	e0ca                	sd	s2,64(sp)
ffffffffc02083dc:	fc4e                	sd	s3,56(sp)
ffffffffc02083de:	ec86                	sd	ra,88(sp)
ffffffffc02083e0:	e8a2                	sd	s0,80(sp)
ffffffffc02083e2:	f852                	sd	s4,48(sp)
ffffffffc02083e4:	f456                	sd	s5,40(sp)
ffffffffc02083e6:	0035f793          	andi	a5,a1,3
ffffffffc02083ea:	84ae                	mv	s1,a1
ffffffffc02083ec:	892a                	mv	s2,a0
ffffffffc02083ee:	89b2                	mv	s3,a2
ffffffffc02083f0:	0e078663          	beqz	a5,ffffffffc02084dc <vfs_open+0x106>
ffffffffc02083f4:	470d                	li	a4,3
ffffffffc02083f6:	0105fa93          	andi	s5,a1,16
ffffffffc02083fa:	0ce78f63          	beq	a5,a4,ffffffffc02084d8 <vfs_open+0x102>
ffffffffc02083fe:	002c                	addi	a1,sp,8
ffffffffc0208400:	854a                	mv	a0,s2
ffffffffc0208402:	2ae000ef          	jal	ra,ffffffffc02086b0 <vfs_lookup>
ffffffffc0208406:	842a                	mv	s0,a0
ffffffffc0208408:	0044fa13          	andi	s4,s1,4
ffffffffc020840c:	e159                	bnez	a0,ffffffffc0208492 <vfs_open+0xbc>
ffffffffc020840e:	00c4f793          	andi	a5,s1,12
ffffffffc0208412:	4731                	li	a4,12
ffffffffc0208414:	0ee78263          	beq	a5,a4,ffffffffc02084f8 <vfs_open+0x122>
ffffffffc0208418:	6422                	ld	s0,8(sp)
ffffffffc020841a:	12040163          	beqz	s0,ffffffffc020853c <vfs_open+0x166>
ffffffffc020841e:	783c                	ld	a5,112(s0)
ffffffffc0208420:	cff1                	beqz	a5,ffffffffc02084fc <vfs_open+0x126>
ffffffffc0208422:	679c                	ld	a5,8(a5)
ffffffffc0208424:	cfe1                	beqz	a5,ffffffffc02084fc <vfs_open+0x126>
ffffffffc0208426:	8522                	mv	a0,s0
ffffffffc0208428:	00006597          	auipc	a1,0x6
ffffffffc020842c:	71858593          	addi	a1,a1,1816 # ffffffffc020eb40 <syscalls+0xc40>
ffffffffc0208430:	8c3ff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0208434:	783c                	ld	a5,112(s0)
ffffffffc0208436:	6522                	ld	a0,8(sp)
ffffffffc0208438:	85a6                	mv	a1,s1
ffffffffc020843a:	679c                	ld	a5,8(a5)
ffffffffc020843c:	9782                	jalr	a5
ffffffffc020843e:	842a                	mv	s0,a0
ffffffffc0208440:	6522                	ld	a0,8(sp)
ffffffffc0208442:	e845                	bnez	s0,ffffffffc02084f2 <vfs_open+0x11c>
ffffffffc0208444:	015a6a33          	or	s4,s4,s5
ffffffffc0208448:	89fff0ef          	jal	ra,ffffffffc0207ce6 <inode_open_inc>
ffffffffc020844c:	020a0663          	beqz	s4,ffffffffc0208478 <vfs_open+0xa2>
ffffffffc0208450:	64a2                	ld	s1,8(sp)
ffffffffc0208452:	c4e9                	beqz	s1,ffffffffc020851c <vfs_open+0x146>
ffffffffc0208454:	78bc                	ld	a5,112(s1)
ffffffffc0208456:	c3f9                	beqz	a5,ffffffffc020851c <vfs_open+0x146>
ffffffffc0208458:	73bc                	ld	a5,96(a5)
ffffffffc020845a:	c3e9                	beqz	a5,ffffffffc020851c <vfs_open+0x146>
ffffffffc020845c:	00006597          	auipc	a1,0x6
ffffffffc0208460:	74458593          	addi	a1,a1,1860 # ffffffffc020eba0 <syscalls+0xca0>
ffffffffc0208464:	8526                	mv	a0,s1
ffffffffc0208466:	88dff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc020846a:	78bc                	ld	a5,112(s1)
ffffffffc020846c:	6522                	ld	a0,8(sp)
ffffffffc020846e:	4581                	li	a1,0
ffffffffc0208470:	73bc                	ld	a5,96(a5)
ffffffffc0208472:	9782                	jalr	a5
ffffffffc0208474:	87aa                	mv	a5,a0
ffffffffc0208476:	e92d                	bnez	a0,ffffffffc02084e8 <vfs_open+0x112>
ffffffffc0208478:	67a2                	ld	a5,8(sp)
ffffffffc020847a:	00f9b023          	sd	a5,0(s3)
ffffffffc020847e:	60e6                	ld	ra,88(sp)
ffffffffc0208480:	8522                	mv	a0,s0
ffffffffc0208482:	6446                	ld	s0,80(sp)
ffffffffc0208484:	64a6                	ld	s1,72(sp)
ffffffffc0208486:	6906                	ld	s2,64(sp)
ffffffffc0208488:	79e2                	ld	s3,56(sp)
ffffffffc020848a:	7a42                	ld	s4,48(sp)
ffffffffc020848c:	7aa2                	ld	s5,40(sp)
ffffffffc020848e:	6125                	addi	sp,sp,96
ffffffffc0208490:	8082                	ret
ffffffffc0208492:	57c1                	li	a5,-16
ffffffffc0208494:	fef515e3          	bne	a0,a5,ffffffffc020847e <vfs_open+0xa8>
ffffffffc0208498:	fe0a03e3          	beqz	s4,ffffffffc020847e <vfs_open+0xa8>
ffffffffc020849c:	0810                	addi	a2,sp,16
ffffffffc020849e:	082c                	addi	a1,sp,24
ffffffffc02084a0:	854a                	mv	a0,s2
ffffffffc02084a2:	2a4000ef          	jal	ra,ffffffffc0208746 <vfs_lookup_parent>
ffffffffc02084a6:	842a                	mv	s0,a0
ffffffffc02084a8:	f979                	bnez	a0,ffffffffc020847e <vfs_open+0xa8>
ffffffffc02084aa:	6462                	ld	s0,24(sp)
ffffffffc02084ac:	c845                	beqz	s0,ffffffffc020855c <vfs_open+0x186>
ffffffffc02084ae:	783c                	ld	a5,112(s0)
ffffffffc02084b0:	c7d5                	beqz	a5,ffffffffc020855c <vfs_open+0x186>
ffffffffc02084b2:	77bc                	ld	a5,104(a5)
ffffffffc02084b4:	c7c5                	beqz	a5,ffffffffc020855c <vfs_open+0x186>
ffffffffc02084b6:	8522                	mv	a0,s0
ffffffffc02084b8:	00006597          	auipc	a1,0x6
ffffffffc02084bc:	62058593          	addi	a1,a1,1568 # ffffffffc020ead8 <syscalls+0xbd8>
ffffffffc02084c0:	833ff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc02084c4:	783c                	ld	a5,112(s0)
ffffffffc02084c6:	65c2                	ld	a1,16(sp)
ffffffffc02084c8:	6562                	ld	a0,24(sp)
ffffffffc02084ca:	77bc                	ld	a5,104(a5)
ffffffffc02084cc:	4034d613          	srai	a2,s1,0x3
ffffffffc02084d0:	0034                	addi	a3,sp,8
ffffffffc02084d2:	8a05                	andi	a2,a2,1
ffffffffc02084d4:	9782                	jalr	a5
ffffffffc02084d6:	b789                	j	ffffffffc0208418 <vfs_open+0x42>
ffffffffc02084d8:	5475                	li	s0,-3
ffffffffc02084da:	b755                	j	ffffffffc020847e <vfs_open+0xa8>
ffffffffc02084dc:	0105fa93          	andi	s5,a1,16
ffffffffc02084e0:	5475                	li	s0,-3
ffffffffc02084e2:	f80a9ee3          	bnez	s5,ffffffffc020847e <vfs_open+0xa8>
ffffffffc02084e6:	bf21                	j	ffffffffc02083fe <vfs_open+0x28>
ffffffffc02084e8:	6522                	ld	a0,8(sp)
ffffffffc02084ea:	843e                	mv	s0,a5
ffffffffc02084ec:	965ff0ef          	jal	ra,ffffffffc0207e50 <inode_open_dec>
ffffffffc02084f0:	6522                	ld	a0,8(sp)
ffffffffc02084f2:	8b7ff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc02084f6:	b761                	j	ffffffffc020847e <vfs_open+0xa8>
ffffffffc02084f8:	5425                	li	s0,-23
ffffffffc02084fa:	b751                	j	ffffffffc020847e <vfs_open+0xa8>
ffffffffc02084fc:	00006697          	auipc	a3,0x6
ffffffffc0208500:	5f468693          	addi	a3,a3,1524 # ffffffffc020eaf0 <syscalls+0xbf0>
ffffffffc0208504:	00004617          	auipc	a2,0x4
ffffffffc0208508:	8fc60613          	addi	a2,a2,-1796 # ffffffffc020be00 <commands+0x210>
ffffffffc020850c:	03300593          	li	a1,51
ffffffffc0208510:	00006517          	auipc	a0,0x6
ffffffffc0208514:	5b050513          	addi	a0,a0,1456 # ffffffffc020eac0 <syscalls+0xbc0>
ffffffffc0208518:	f87f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020851c:	00006697          	auipc	a3,0x6
ffffffffc0208520:	62c68693          	addi	a3,a3,1580 # ffffffffc020eb48 <syscalls+0xc48>
ffffffffc0208524:	00004617          	auipc	a2,0x4
ffffffffc0208528:	8dc60613          	addi	a2,a2,-1828 # ffffffffc020be00 <commands+0x210>
ffffffffc020852c:	03a00593          	li	a1,58
ffffffffc0208530:	00006517          	auipc	a0,0x6
ffffffffc0208534:	59050513          	addi	a0,a0,1424 # ffffffffc020eac0 <syscalls+0xbc0>
ffffffffc0208538:	f67f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020853c:	00006697          	auipc	a3,0x6
ffffffffc0208540:	5a468693          	addi	a3,a3,1444 # ffffffffc020eae0 <syscalls+0xbe0>
ffffffffc0208544:	00004617          	auipc	a2,0x4
ffffffffc0208548:	8bc60613          	addi	a2,a2,-1860 # ffffffffc020be00 <commands+0x210>
ffffffffc020854c:	03100593          	li	a1,49
ffffffffc0208550:	00006517          	auipc	a0,0x6
ffffffffc0208554:	57050513          	addi	a0,a0,1392 # ffffffffc020eac0 <syscalls+0xbc0>
ffffffffc0208558:	f47f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020855c:	00006697          	auipc	a3,0x6
ffffffffc0208560:	51468693          	addi	a3,a3,1300 # ffffffffc020ea70 <syscalls+0xb70>
ffffffffc0208564:	00004617          	auipc	a2,0x4
ffffffffc0208568:	89c60613          	addi	a2,a2,-1892 # ffffffffc020be00 <commands+0x210>
ffffffffc020856c:	02c00593          	li	a1,44
ffffffffc0208570:	00006517          	auipc	a0,0x6
ffffffffc0208574:	55050513          	addi	a0,a0,1360 # ffffffffc020eac0 <syscalls+0xbc0>
ffffffffc0208578:	f27f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020857c <vfs_close>:
ffffffffc020857c:	1141                	addi	sp,sp,-16
ffffffffc020857e:	e406                	sd	ra,8(sp)
ffffffffc0208580:	e022                	sd	s0,0(sp)
ffffffffc0208582:	842a                	mv	s0,a0
ffffffffc0208584:	8cdff0ef          	jal	ra,ffffffffc0207e50 <inode_open_dec>
ffffffffc0208588:	8522                	mv	a0,s0
ffffffffc020858a:	81fff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020858e:	60a2                	ld	ra,8(sp)
ffffffffc0208590:	6402                	ld	s0,0(sp)
ffffffffc0208592:	4501                	li	a0,0
ffffffffc0208594:	0141                	addi	sp,sp,16
ffffffffc0208596:	8082                	ret

ffffffffc0208598 <get_device>:
ffffffffc0208598:	7179                	addi	sp,sp,-48
ffffffffc020859a:	ec26                	sd	s1,24(sp)
ffffffffc020859c:	e84a                	sd	s2,16(sp)
ffffffffc020859e:	f406                	sd	ra,40(sp)
ffffffffc02085a0:	f022                	sd	s0,32(sp)
ffffffffc02085a2:	00054303          	lbu	t1,0(a0)
ffffffffc02085a6:	892e                	mv	s2,a1
ffffffffc02085a8:	84b2                	mv	s1,a2
ffffffffc02085aa:	02030463          	beqz	t1,ffffffffc02085d2 <get_device+0x3a>
ffffffffc02085ae:	00150413          	addi	s0,a0,1
ffffffffc02085b2:	86a2                	mv	a3,s0
ffffffffc02085b4:	879a                	mv	a5,t1
ffffffffc02085b6:	4701                	li	a4,0
ffffffffc02085b8:	03a00813          	li	a6,58
ffffffffc02085bc:	02f00893          	li	a7,47
ffffffffc02085c0:	03078263          	beq	a5,a6,ffffffffc02085e4 <get_device+0x4c>
ffffffffc02085c4:	05178963          	beq	a5,a7,ffffffffc0208616 <get_device+0x7e>
ffffffffc02085c8:	0006c783          	lbu	a5,0(a3)
ffffffffc02085cc:	2705                	addiw	a4,a4,1
ffffffffc02085ce:	0685                	addi	a3,a3,1
ffffffffc02085d0:	fbe5                	bnez	a5,ffffffffc02085c0 <get_device+0x28>
ffffffffc02085d2:	7402                	ld	s0,32(sp)
ffffffffc02085d4:	00a93023          	sd	a0,0(s2)
ffffffffc02085d8:	70a2                	ld	ra,40(sp)
ffffffffc02085da:	6942                	ld	s2,16(sp)
ffffffffc02085dc:	8526                	mv	a0,s1
ffffffffc02085de:	64e2                	ld	s1,24(sp)
ffffffffc02085e0:	6145                	addi	sp,sp,48
ffffffffc02085e2:	a279                	j	ffffffffc0208770 <vfs_get_curdir>
ffffffffc02085e4:	cb15                	beqz	a4,ffffffffc0208618 <get_device+0x80>
ffffffffc02085e6:	00e507b3          	add	a5,a0,a4
ffffffffc02085ea:	0705                	addi	a4,a4,1
ffffffffc02085ec:	00078023          	sb	zero,0(a5)
ffffffffc02085f0:	972a                	add	a4,a4,a0
ffffffffc02085f2:	02f00613          	li	a2,47
ffffffffc02085f6:	00074783          	lbu	a5,0(a4)
ffffffffc02085fa:	86ba                	mv	a3,a4
ffffffffc02085fc:	0705                	addi	a4,a4,1
ffffffffc02085fe:	fec78ce3          	beq	a5,a2,ffffffffc02085f6 <get_device+0x5e>
ffffffffc0208602:	7402                	ld	s0,32(sp)
ffffffffc0208604:	70a2                	ld	ra,40(sp)
ffffffffc0208606:	00d93023          	sd	a3,0(s2)
ffffffffc020860a:	85a6                	mv	a1,s1
ffffffffc020860c:	6942                	ld	s2,16(sp)
ffffffffc020860e:	64e2                	ld	s1,24(sp)
ffffffffc0208610:	6145                	addi	sp,sp,48
ffffffffc0208612:	ba9ff06f          	j	ffffffffc02081ba <vfs_get_root>
ffffffffc0208616:	ff55                	bnez	a4,ffffffffc02085d2 <get_device+0x3a>
ffffffffc0208618:	02f00793          	li	a5,47
ffffffffc020861c:	04f30563          	beq	t1,a5,ffffffffc0208666 <get_device+0xce>
ffffffffc0208620:	03a00793          	li	a5,58
ffffffffc0208624:	06f31663          	bne	t1,a5,ffffffffc0208690 <get_device+0xf8>
ffffffffc0208628:	0028                	addi	a0,sp,8
ffffffffc020862a:	146000ef          	jal	ra,ffffffffc0208770 <vfs_get_curdir>
ffffffffc020862e:	e515                	bnez	a0,ffffffffc020865a <get_device+0xc2>
ffffffffc0208630:	67a2                	ld	a5,8(sp)
ffffffffc0208632:	77a8                	ld	a0,104(a5)
ffffffffc0208634:	cd15                	beqz	a0,ffffffffc0208670 <get_device+0xd8>
ffffffffc0208636:	617c                	ld	a5,192(a0)
ffffffffc0208638:	9782                	jalr	a5
ffffffffc020863a:	87aa                	mv	a5,a0
ffffffffc020863c:	6522                	ld	a0,8(sp)
ffffffffc020863e:	e09c                	sd	a5,0(s1)
ffffffffc0208640:	f68ff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc0208644:	02f00713          	li	a4,47
ffffffffc0208648:	a011                	j	ffffffffc020864c <get_device+0xb4>
ffffffffc020864a:	0405                	addi	s0,s0,1
ffffffffc020864c:	00044783          	lbu	a5,0(s0)
ffffffffc0208650:	fee78de3          	beq	a5,a4,ffffffffc020864a <get_device+0xb2>
ffffffffc0208654:	00893023          	sd	s0,0(s2)
ffffffffc0208658:	4501                	li	a0,0
ffffffffc020865a:	70a2                	ld	ra,40(sp)
ffffffffc020865c:	7402                	ld	s0,32(sp)
ffffffffc020865e:	64e2                	ld	s1,24(sp)
ffffffffc0208660:	6942                	ld	s2,16(sp)
ffffffffc0208662:	6145                	addi	sp,sp,48
ffffffffc0208664:	8082                	ret
ffffffffc0208666:	8526                	mv	a0,s1
ffffffffc0208668:	93fff0ef          	jal	ra,ffffffffc0207fa6 <vfs_get_bootfs>
ffffffffc020866c:	dd61                	beqz	a0,ffffffffc0208644 <get_device+0xac>
ffffffffc020866e:	b7f5                	j	ffffffffc020865a <get_device+0xc2>
ffffffffc0208670:	00006697          	auipc	a3,0x6
ffffffffc0208674:	56868693          	addi	a3,a3,1384 # ffffffffc020ebd8 <syscalls+0xcd8>
ffffffffc0208678:	00003617          	auipc	a2,0x3
ffffffffc020867c:	78860613          	addi	a2,a2,1928 # ffffffffc020be00 <commands+0x210>
ffffffffc0208680:	03900593          	li	a1,57
ffffffffc0208684:	00006517          	auipc	a0,0x6
ffffffffc0208688:	53c50513          	addi	a0,a0,1340 # ffffffffc020ebc0 <syscalls+0xcc0>
ffffffffc020868c:	e13f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208690:	00006697          	auipc	a3,0x6
ffffffffc0208694:	52068693          	addi	a3,a3,1312 # ffffffffc020ebb0 <syscalls+0xcb0>
ffffffffc0208698:	00003617          	auipc	a2,0x3
ffffffffc020869c:	76860613          	addi	a2,a2,1896 # ffffffffc020be00 <commands+0x210>
ffffffffc02086a0:	03300593          	li	a1,51
ffffffffc02086a4:	00006517          	auipc	a0,0x6
ffffffffc02086a8:	51c50513          	addi	a0,a0,1308 # ffffffffc020ebc0 <syscalls+0xcc0>
ffffffffc02086ac:	df3f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02086b0 <vfs_lookup>:
ffffffffc02086b0:	7139                	addi	sp,sp,-64
ffffffffc02086b2:	f426                	sd	s1,40(sp)
ffffffffc02086b4:	0830                	addi	a2,sp,24
ffffffffc02086b6:	84ae                	mv	s1,a1
ffffffffc02086b8:	002c                	addi	a1,sp,8
ffffffffc02086ba:	f822                	sd	s0,48(sp)
ffffffffc02086bc:	fc06                	sd	ra,56(sp)
ffffffffc02086be:	f04a                	sd	s2,32(sp)
ffffffffc02086c0:	e42a                	sd	a0,8(sp)
ffffffffc02086c2:	ed7ff0ef          	jal	ra,ffffffffc0208598 <get_device>
ffffffffc02086c6:	842a                	mv	s0,a0
ffffffffc02086c8:	ed1d                	bnez	a0,ffffffffc0208706 <vfs_lookup+0x56>
ffffffffc02086ca:	67a2                	ld	a5,8(sp)
ffffffffc02086cc:	6962                	ld	s2,24(sp)
ffffffffc02086ce:	0007c783          	lbu	a5,0(a5)
ffffffffc02086d2:	c3a9                	beqz	a5,ffffffffc0208714 <vfs_lookup+0x64>
ffffffffc02086d4:	04090963          	beqz	s2,ffffffffc0208726 <vfs_lookup+0x76>
ffffffffc02086d8:	07093783          	ld	a5,112(s2)
ffffffffc02086dc:	c7a9                	beqz	a5,ffffffffc0208726 <vfs_lookup+0x76>
ffffffffc02086de:	7bbc                	ld	a5,112(a5)
ffffffffc02086e0:	c3b9                	beqz	a5,ffffffffc0208726 <vfs_lookup+0x76>
ffffffffc02086e2:	854a                	mv	a0,s2
ffffffffc02086e4:	00006597          	auipc	a1,0x6
ffffffffc02086e8:	55c58593          	addi	a1,a1,1372 # ffffffffc020ec40 <syscalls+0xd40>
ffffffffc02086ec:	e06ff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc02086f0:	07093783          	ld	a5,112(s2)
ffffffffc02086f4:	65a2                	ld	a1,8(sp)
ffffffffc02086f6:	6562                	ld	a0,24(sp)
ffffffffc02086f8:	7bbc                	ld	a5,112(a5)
ffffffffc02086fa:	8626                	mv	a2,s1
ffffffffc02086fc:	9782                	jalr	a5
ffffffffc02086fe:	842a                	mv	s0,a0
ffffffffc0208700:	6562                	ld	a0,24(sp)
ffffffffc0208702:	ea6ff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc0208706:	70e2                	ld	ra,56(sp)
ffffffffc0208708:	8522                	mv	a0,s0
ffffffffc020870a:	7442                	ld	s0,48(sp)
ffffffffc020870c:	74a2                	ld	s1,40(sp)
ffffffffc020870e:	7902                	ld	s2,32(sp)
ffffffffc0208710:	6121                	addi	sp,sp,64
ffffffffc0208712:	8082                	ret
ffffffffc0208714:	70e2                	ld	ra,56(sp)
ffffffffc0208716:	8522                	mv	a0,s0
ffffffffc0208718:	7442                	ld	s0,48(sp)
ffffffffc020871a:	0124b023          	sd	s2,0(s1)
ffffffffc020871e:	74a2                	ld	s1,40(sp)
ffffffffc0208720:	7902                	ld	s2,32(sp)
ffffffffc0208722:	6121                	addi	sp,sp,64
ffffffffc0208724:	8082                	ret
ffffffffc0208726:	00006697          	auipc	a3,0x6
ffffffffc020872a:	4ca68693          	addi	a3,a3,1226 # ffffffffc020ebf0 <syscalls+0xcf0>
ffffffffc020872e:	00003617          	auipc	a2,0x3
ffffffffc0208732:	6d260613          	addi	a2,a2,1746 # ffffffffc020be00 <commands+0x210>
ffffffffc0208736:	04f00593          	li	a1,79
ffffffffc020873a:	00006517          	auipc	a0,0x6
ffffffffc020873e:	48650513          	addi	a0,a0,1158 # ffffffffc020ebc0 <syscalls+0xcc0>
ffffffffc0208742:	d5df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208746 <vfs_lookup_parent>:
ffffffffc0208746:	7139                	addi	sp,sp,-64
ffffffffc0208748:	f822                	sd	s0,48(sp)
ffffffffc020874a:	f426                	sd	s1,40(sp)
ffffffffc020874c:	842e                	mv	s0,a1
ffffffffc020874e:	84b2                	mv	s1,a2
ffffffffc0208750:	002c                	addi	a1,sp,8
ffffffffc0208752:	0830                	addi	a2,sp,24
ffffffffc0208754:	fc06                	sd	ra,56(sp)
ffffffffc0208756:	e42a                	sd	a0,8(sp)
ffffffffc0208758:	e41ff0ef          	jal	ra,ffffffffc0208598 <get_device>
ffffffffc020875c:	e509                	bnez	a0,ffffffffc0208766 <vfs_lookup_parent+0x20>
ffffffffc020875e:	67a2                	ld	a5,8(sp)
ffffffffc0208760:	e09c                	sd	a5,0(s1)
ffffffffc0208762:	67e2                	ld	a5,24(sp)
ffffffffc0208764:	e01c                	sd	a5,0(s0)
ffffffffc0208766:	70e2                	ld	ra,56(sp)
ffffffffc0208768:	7442                	ld	s0,48(sp)
ffffffffc020876a:	74a2                	ld	s1,40(sp)
ffffffffc020876c:	6121                	addi	sp,sp,64
ffffffffc020876e:	8082                	ret

ffffffffc0208770 <vfs_get_curdir>:
ffffffffc0208770:	0008e797          	auipc	a5,0x8e
ffffffffc0208774:	1507b783          	ld	a5,336(a5) # ffffffffc02968c0 <current>
ffffffffc0208778:	1487b783          	ld	a5,328(a5)
ffffffffc020877c:	1101                	addi	sp,sp,-32
ffffffffc020877e:	e426                	sd	s1,8(sp)
ffffffffc0208780:	6384                	ld	s1,0(a5)
ffffffffc0208782:	ec06                	sd	ra,24(sp)
ffffffffc0208784:	e822                	sd	s0,16(sp)
ffffffffc0208786:	cc81                	beqz	s1,ffffffffc020879e <vfs_get_curdir+0x2e>
ffffffffc0208788:	842a                	mv	s0,a0
ffffffffc020878a:	8526                	mv	a0,s1
ffffffffc020878c:	d4eff0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc0208790:	4501                	li	a0,0
ffffffffc0208792:	e004                	sd	s1,0(s0)
ffffffffc0208794:	60e2                	ld	ra,24(sp)
ffffffffc0208796:	6442                	ld	s0,16(sp)
ffffffffc0208798:	64a2                	ld	s1,8(sp)
ffffffffc020879a:	6105                	addi	sp,sp,32
ffffffffc020879c:	8082                	ret
ffffffffc020879e:	5541                	li	a0,-16
ffffffffc02087a0:	bfd5                	j	ffffffffc0208794 <vfs_get_curdir+0x24>

ffffffffc02087a2 <vfs_set_curdir>:
ffffffffc02087a2:	7139                	addi	sp,sp,-64
ffffffffc02087a4:	f04a                	sd	s2,32(sp)
ffffffffc02087a6:	0008e917          	auipc	s2,0x8e
ffffffffc02087aa:	11a90913          	addi	s2,s2,282 # ffffffffc02968c0 <current>
ffffffffc02087ae:	00093783          	ld	a5,0(s2)
ffffffffc02087b2:	f822                	sd	s0,48(sp)
ffffffffc02087b4:	842a                	mv	s0,a0
ffffffffc02087b6:	1487b503          	ld	a0,328(a5)
ffffffffc02087ba:	ec4e                	sd	s3,24(sp)
ffffffffc02087bc:	fc06                	sd	ra,56(sp)
ffffffffc02087be:	f426                	sd	s1,40(sp)
ffffffffc02087c0:	a9bfc0ef          	jal	ra,ffffffffc020525a <lock_files>
ffffffffc02087c4:	00093783          	ld	a5,0(s2)
ffffffffc02087c8:	1487b503          	ld	a0,328(a5)
ffffffffc02087cc:	00053983          	ld	s3,0(a0)
ffffffffc02087d0:	07340963          	beq	s0,s3,ffffffffc0208842 <vfs_set_curdir+0xa0>
ffffffffc02087d4:	cc39                	beqz	s0,ffffffffc0208832 <vfs_set_curdir+0x90>
ffffffffc02087d6:	783c                	ld	a5,112(s0)
ffffffffc02087d8:	c7bd                	beqz	a5,ffffffffc0208846 <vfs_set_curdir+0xa4>
ffffffffc02087da:	6bbc                	ld	a5,80(a5)
ffffffffc02087dc:	c7ad                	beqz	a5,ffffffffc0208846 <vfs_set_curdir+0xa4>
ffffffffc02087de:	00006597          	auipc	a1,0x6
ffffffffc02087e2:	4d258593          	addi	a1,a1,1234 # ffffffffc020ecb0 <syscalls+0xdb0>
ffffffffc02087e6:	8522                	mv	a0,s0
ffffffffc02087e8:	d0aff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc02087ec:	783c                	ld	a5,112(s0)
ffffffffc02087ee:	006c                	addi	a1,sp,12
ffffffffc02087f0:	8522                	mv	a0,s0
ffffffffc02087f2:	6bbc                	ld	a5,80(a5)
ffffffffc02087f4:	9782                	jalr	a5
ffffffffc02087f6:	84aa                	mv	s1,a0
ffffffffc02087f8:	e901                	bnez	a0,ffffffffc0208808 <vfs_set_curdir+0x66>
ffffffffc02087fa:	47b2                	lw	a5,12(sp)
ffffffffc02087fc:	669d                	lui	a3,0x7
ffffffffc02087fe:	6709                	lui	a4,0x2
ffffffffc0208800:	8ff5                	and	a5,a5,a3
ffffffffc0208802:	54b9                	li	s1,-18
ffffffffc0208804:	02e78063          	beq	a5,a4,ffffffffc0208824 <vfs_set_curdir+0x82>
ffffffffc0208808:	00093783          	ld	a5,0(s2)
ffffffffc020880c:	1487b503          	ld	a0,328(a5)
ffffffffc0208810:	a51fc0ef          	jal	ra,ffffffffc0205260 <unlock_files>
ffffffffc0208814:	70e2                	ld	ra,56(sp)
ffffffffc0208816:	7442                	ld	s0,48(sp)
ffffffffc0208818:	7902                	ld	s2,32(sp)
ffffffffc020881a:	69e2                	ld	s3,24(sp)
ffffffffc020881c:	8526                	mv	a0,s1
ffffffffc020881e:	74a2                	ld	s1,40(sp)
ffffffffc0208820:	6121                	addi	sp,sp,64
ffffffffc0208822:	8082                	ret
ffffffffc0208824:	8522                	mv	a0,s0
ffffffffc0208826:	cb4ff0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc020882a:	00093783          	ld	a5,0(s2)
ffffffffc020882e:	1487b503          	ld	a0,328(a5)
ffffffffc0208832:	e100                	sd	s0,0(a0)
ffffffffc0208834:	4481                	li	s1,0
ffffffffc0208836:	fc098de3          	beqz	s3,ffffffffc0208810 <vfs_set_curdir+0x6e>
ffffffffc020883a:	854e                	mv	a0,s3
ffffffffc020883c:	d6cff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc0208840:	b7e1                	j	ffffffffc0208808 <vfs_set_curdir+0x66>
ffffffffc0208842:	4481                	li	s1,0
ffffffffc0208844:	b7f1                	j	ffffffffc0208810 <vfs_set_curdir+0x6e>
ffffffffc0208846:	00006697          	auipc	a3,0x6
ffffffffc020884a:	40268693          	addi	a3,a3,1026 # ffffffffc020ec48 <syscalls+0xd48>
ffffffffc020884e:	00003617          	auipc	a2,0x3
ffffffffc0208852:	5b260613          	addi	a2,a2,1458 # ffffffffc020be00 <commands+0x210>
ffffffffc0208856:	04300593          	li	a1,67
ffffffffc020885a:	00006517          	auipc	a0,0x6
ffffffffc020885e:	43e50513          	addi	a0,a0,1086 # ffffffffc020ec98 <syscalls+0xd98>
ffffffffc0208862:	c3df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208866 <vfs_chdir>:
ffffffffc0208866:	1101                	addi	sp,sp,-32
ffffffffc0208868:	002c                	addi	a1,sp,8
ffffffffc020886a:	e822                	sd	s0,16(sp)
ffffffffc020886c:	ec06                	sd	ra,24(sp)
ffffffffc020886e:	e43ff0ef          	jal	ra,ffffffffc02086b0 <vfs_lookup>
ffffffffc0208872:	842a                	mv	s0,a0
ffffffffc0208874:	c511                	beqz	a0,ffffffffc0208880 <vfs_chdir+0x1a>
ffffffffc0208876:	60e2                	ld	ra,24(sp)
ffffffffc0208878:	8522                	mv	a0,s0
ffffffffc020887a:	6442                	ld	s0,16(sp)
ffffffffc020887c:	6105                	addi	sp,sp,32
ffffffffc020887e:	8082                	ret
ffffffffc0208880:	6522                	ld	a0,8(sp)
ffffffffc0208882:	f21ff0ef          	jal	ra,ffffffffc02087a2 <vfs_set_curdir>
ffffffffc0208886:	842a                	mv	s0,a0
ffffffffc0208888:	6522                	ld	a0,8(sp)
ffffffffc020888a:	d1eff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020888e:	60e2                	ld	ra,24(sp)
ffffffffc0208890:	8522                	mv	a0,s0
ffffffffc0208892:	6442                	ld	s0,16(sp)
ffffffffc0208894:	6105                	addi	sp,sp,32
ffffffffc0208896:	8082                	ret

ffffffffc0208898 <vfs_getcwd>:
ffffffffc0208898:	0008e797          	auipc	a5,0x8e
ffffffffc020889c:	0287b783          	ld	a5,40(a5) # ffffffffc02968c0 <current>
ffffffffc02088a0:	1487b783          	ld	a5,328(a5)
ffffffffc02088a4:	7179                	addi	sp,sp,-48
ffffffffc02088a6:	ec26                	sd	s1,24(sp)
ffffffffc02088a8:	6384                	ld	s1,0(a5)
ffffffffc02088aa:	f406                	sd	ra,40(sp)
ffffffffc02088ac:	f022                	sd	s0,32(sp)
ffffffffc02088ae:	e84a                	sd	s2,16(sp)
ffffffffc02088b0:	ccbd                	beqz	s1,ffffffffc020892e <vfs_getcwd+0x96>
ffffffffc02088b2:	892a                	mv	s2,a0
ffffffffc02088b4:	8526                	mv	a0,s1
ffffffffc02088b6:	c24ff0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc02088ba:	74a8                	ld	a0,104(s1)
ffffffffc02088bc:	c93d                	beqz	a0,ffffffffc0208932 <vfs_getcwd+0x9a>
ffffffffc02088be:	9b3ff0ef          	jal	ra,ffffffffc0208270 <vfs_get_devname>
ffffffffc02088c2:	842a                	mv	s0,a0
ffffffffc02088c4:	7b3020ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc02088c8:	862a                	mv	a2,a0
ffffffffc02088ca:	85a2                	mv	a1,s0
ffffffffc02088cc:	4701                	li	a4,0
ffffffffc02088ce:	4685                	li	a3,1
ffffffffc02088d0:	854a                	mv	a0,s2
ffffffffc02088d2:	bb3fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc02088d6:	842a                	mv	s0,a0
ffffffffc02088d8:	c919                	beqz	a0,ffffffffc02088ee <vfs_getcwd+0x56>
ffffffffc02088da:	8526                	mv	a0,s1
ffffffffc02088dc:	cccff0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc02088e0:	70a2                	ld	ra,40(sp)
ffffffffc02088e2:	8522                	mv	a0,s0
ffffffffc02088e4:	7402                	ld	s0,32(sp)
ffffffffc02088e6:	64e2                	ld	s1,24(sp)
ffffffffc02088e8:	6942                	ld	s2,16(sp)
ffffffffc02088ea:	6145                	addi	sp,sp,48
ffffffffc02088ec:	8082                	ret
ffffffffc02088ee:	03a00793          	li	a5,58
ffffffffc02088f2:	4701                	li	a4,0
ffffffffc02088f4:	4685                	li	a3,1
ffffffffc02088f6:	4605                	li	a2,1
ffffffffc02088f8:	00f10593          	addi	a1,sp,15
ffffffffc02088fc:	854a                	mv	a0,s2
ffffffffc02088fe:	00f107a3          	sb	a5,15(sp)
ffffffffc0208902:	b83fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc0208906:	842a                	mv	s0,a0
ffffffffc0208908:	f969                	bnez	a0,ffffffffc02088da <vfs_getcwd+0x42>
ffffffffc020890a:	78bc                	ld	a5,112(s1)
ffffffffc020890c:	c3b9                	beqz	a5,ffffffffc0208952 <vfs_getcwd+0xba>
ffffffffc020890e:	7f9c                	ld	a5,56(a5)
ffffffffc0208910:	c3a9                	beqz	a5,ffffffffc0208952 <vfs_getcwd+0xba>
ffffffffc0208912:	00006597          	auipc	a1,0x6
ffffffffc0208916:	3fe58593          	addi	a1,a1,1022 # ffffffffc020ed10 <syscalls+0xe10>
ffffffffc020891a:	8526                	mv	a0,s1
ffffffffc020891c:	bd6ff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0208920:	78bc                	ld	a5,112(s1)
ffffffffc0208922:	85ca                	mv	a1,s2
ffffffffc0208924:	8526                	mv	a0,s1
ffffffffc0208926:	7f9c                	ld	a5,56(a5)
ffffffffc0208928:	9782                	jalr	a5
ffffffffc020892a:	842a                	mv	s0,a0
ffffffffc020892c:	b77d                	j	ffffffffc02088da <vfs_getcwd+0x42>
ffffffffc020892e:	5441                	li	s0,-16
ffffffffc0208930:	bf45                	j	ffffffffc02088e0 <vfs_getcwd+0x48>
ffffffffc0208932:	00006697          	auipc	a3,0x6
ffffffffc0208936:	2a668693          	addi	a3,a3,678 # ffffffffc020ebd8 <syscalls+0xcd8>
ffffffffc020893a:	00003617          	auipc	a2,0x3
ffffffffc020893e:	4c660613          	addi	a2,a2,1222 # ffffffffc020be00 <commands+0x210>
ffffffffc0208942:	06e00593          	li	a1,110
ffffffffc0208946:	00006517          	auipc	a0,0x6
ffffffffc020894a:	35250513          	addi	a0,a0,850 # ffffffffc020ec98 <syscalls+0xd98>
ffffffffc020894e:	b51f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208952:	00006697          	auipc	a3,0x6
ffffffffc0208956:	36668693          	addi	a3,a3,870 # ffffffffc020ecb8 <syscalls+0xdb8>
ffffffffc020895a:	00003617          	auipc	a2,0x3
ffffffffc020895e:	4a660613          	addi	a2,a2,1190 # ffffffffc020be00 <commands+0x210>
ffffffffc0208962:	07800593          	li	a1,120
ffffffffc0208966:	00006517          	auipc	a0,0x6
ffffffffc020896a:	33250513          	addi	a0,a0,818 # ffffffffc020ec98 <syscalls+0xd98>
ffffffffc020896e:	b31f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208972 <dev_lookup>:
ffffffffc0208972:	0005c783          	lbu	a5,0(a1)
ffffffffc0208976:	e385                	bnez	a5,ffffffffc0208996 <dev_lookup+0x24>
ffffffffc0208978:	1101                	addi	sp,sp,-32
ffffffffc020897a:	e822                	sd	s0,16(sp)
ffffffffc020897c:	e426                	sd	s1,8(sp)
ffffffffc020897e:	ec06                	sd	ra,24(sp)
ffffffffc0208980:	84aa                	mv	s1,a0
ffffffffc0208982:	8432                	mv	s0,a2
ffffffffc0208984:	b56ff0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc0208988:	60e2                	ld	ra,24(sp)
ffffffffc020898a:	e004                	sd	s1,0(s0)
ffffffffc020898c:	6442                	ld	s0,16(sp)
ffffffffc020898e:	64a2                	ld	s1,8(sp)
ffffffffc0208990:	4501                	li	a0,0
ffffffffc0208992:	6105                	addi	sp,sp,32
ffffffffc0208994:	8082                	ret
ffffffffc0208996:	5541                	li	a0,-16
ffffffffc0208998:	8082                	ret

ffffffffc020899a <dev_fstat>:
ffffffffc020899a:	1101                	addi	sp,sp,-32
ffffffffc020899c:	e426                	sd	s1,8(sp)
ffffffffc020899e:	84ae                	mv	s1,a1
ffffffffc02089a0:	e822                	sd	s0,16(sp)
ffffffffc02089a2:	02000613          	li	a2,32
ffffffffc02089a6:	842a                	mv	s0,a0
ffffffffc02089a8:	4581                	li	a1,0
ffffffffc02089aa:	8526                	mv	a0,s1
ffffffffc02089ac:	ec06                	sd	ra,24(sp)
ffffffffc02089ae:	76b020ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc02089b2:	c429                	beqz	s0,ffffffffc02089fc <dev_fstat+0x62>
ffffffffc02089b4:	783c                	ld	a5,112(s0)
ffffffffc02089b6:	c3b9                	beqz	a5,ffffffffc02089fc <dev_fstat+0x62>
ffffffffc02089b8:	6bbc                	ld	a5,80(a5)
ffffffffc02089ba:	c3a9                	beqz	a5,ffffffffc02089fc <dev_fstat+0x62>
ffffffffc02089bc:	00006597          	auipc	a1,0x6
ffffffffc02089c0:	2f458593          	addi	a1,a1,756 # ffffffffc020ecb0 <syscalls+0xdb0>
ffffffffc02089c4:	8522                	mv	a0,s0
ffffffffc02089c6:	b2cff0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc02089ca:	783c                	ld	a5,112(s0)
ffffffffc02089cc:	85a6                	mv	a1,s1
ffffffffc02089ce:	8522                	mv	a0,s0
ffffffffc02089d0:	6bbc                	ld	a5,80(a5)
ffffffffc02089d2:	9782                	jalr	a5
ffffffffc02089d4:	ed19                	bnez	a0,ffffffffc02089f2 <dev_fstat+0x58>
ffffffffc02089d6:	4c38                	lw	a4,88(s0)
ffffffffc02089d8:	6785                	lui	a5,0x1
ffffffffc02089da:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02089de:	02f71f63          	bne	a4,a5,ffffffffc0208a1c <dev_fstat+0x82>
ffffffffc02089e2:	6018                	ld	a4,0(s0)
ffffffffc02089e4:	641c                	ld	a5,8(s0)
ffffffffc02089e6:	4685                	li	a3,1
ffffffffc02089e8:	e494                	sd	a3,8(s1)
ffffffffc02089ea:	02e787b3          	mul	a5,a5,a4
ffffffffc02089ee:	e898                	sd	a4,16(s1)
ffffffffc02089f0:	ec9c                	sd	a5,24(s1)
ffffffffc02089f2:	60e2                	ld	ra,24(sp)
ffffffffc02089f4:	6442                	ld	s0,16(sp)
ffffffffc02089f6:	64a2                	ld	s1,8(sp)
ffffffffc02089f8:	6105                	addi	sp,sp,32
ffffffffc02089fa:	8082                	ret
ffffffffc02089fc:	00006697          	auipc	a3,0x6
ffffffffc0208a00:	24c68693          	addi	a3,a3,588 # ffffffffc020ec48 <syscalls+0xd48>
ffffffffc0208a04:	00003617          	auipc	a2,0x3
ffffffffc0208a08:	3fc60613          	addi	a2,a2,1020 # ffffffffc020be00 <commands+0x210>
ffffffffc0208a0c:	04200593          	li	a1,66
ffffffffc0208a10:	00006517          	auipc	a0,0x6
ffffffffc0208a14:	31050513          	addi	a0,a0,784 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208a18:	a87f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208a1c:	00006697          	auipc	a3,0x6
ffffffffc0208a20:	ff468693          	addi	a3,a3,-12 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208a24:	00003617          	auipc	a2,0x3
ffffffffc0208a28:	3dc60613          	addi	a2,a2,988 # ffffffffc020be00 <commands+0x210>
ffffffffc0208a2c:	04500593          	li	a1,69
ffffffffc0208a30:	00006517          	auipc	a0,0x6
ffffffffc0208a34:	2f050513          	addi	a0,a0,752 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208a38:	a67f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a3c <dev_ioctl>:
ffffffffc0208a3c:	c909                	beqz	a0,ffffffffc0208a4e <dev_ioctl+0x12>
ffffffffc0208a3e:	4d34                	lw	a3,88(a0)
ffffffffc0208a40:	6705                	lui	a4,0x1
ffffffffc0208a42:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208a46:	00e69463          	bne	a3,a4,ffffffffc0208a4e <dev_ioctl+0x12>
ffffffffc0208a4a:	751c                	ld	a5,40(a0)
ffffffffc0208a4c:	8782                	jr	a5
ffffffffc0208a4e:	1141                	addi	sp,sp,-16
ffffffffc0208a50:	00006697          	auipc	a3,0x6
ffffffffc0208a54:	fc068693          	addi	a3,a3,-64 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208a58:	00003617          	auipc	a2,0x3
ffffffffc0208a5c:	3a860613          	addi	a2,a2,936 # ffffffffc020be00 <commands+0x210>
ffffffffc0208a60:	03500593          	li	a1,53
ffffffffc0208a64:	00006517          	auipc	a0,0x6
ffffffffc0208a68:	2bc50513          	addi	a0,a0,700 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208a6c:	e406                	sd	ra,8(sp)
ffffffffc0208a6e:	a31f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a72 <dev_tryseek>:
ffffffffc0208a72:	c51d                	beqz	a0,ffffffffc0208aa0 <dev_tryseek+0x2e>
ffffffffc0208a74:	4d38                	lw	a4,88(a0)
ffffffffc0208a76:	6785                	lui	a5,0x1
ffffffffc0208a78:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208a7c:	02f71263          	bne	a4,a5,ffffffffc0208aa0 <dev_tryseek+0x2e>
ffffffffc0208a80:	611c                	ld	a5,0(a0)
ffffffffc0208a82:	cf89                	beqz	a5,ffffffffc0208a9c <dev_tryseek+0x2a>
ffffffffc0208a84:	6518                	ld	a4,8(a0)
ffffffffc0208a86:	02e5f6b3          	remu	a3,a1,a4
ffffffffc0208a8a:	ea89                	bnez	a3,ffffffffc0208a9c <dev_tryseek+0x2a>
ffffffffc0208a8c:	0005c863          	bltz	a1,ffffffffc0208a9c <dev_tryseek+0x2a>
ffffffffc0208a90:	02e787b3          	mul	a5,a5,a4
ffffffffc0208a94:	00f5f463          	bgeu	a1,a5,ffffffffc0208a9c <dev_tryseek+0x2a>
ffffffffc0208a98:	4501                	li	a0,0
ffffffffc0208a9a:	8082                	ret
ffffffffc0208a9c:	5575                	li	a0,-3
ffffffffc0208a9e:	8082                	ret
ffffffffc0208aa0:	1141                	addi	sp,sp,-16
ffffffffc0208aa2:	00006697          	auipc	a3,0x6
ffffffffc0208aa6:	f6e68693          	addi	a3,a3,-146 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208aaa:	00003617          	auipc	a2,0x3
ffffffffc0208aae:	35660613          	addi	a2,a2,854 # ffffffffc020be00 <commands+0x210>
ffffffffc0208ab2:	05f00593          	li	a1,95
ffffffffc0208ab6:	00006517          	auipc	a0,0x6
ffffffffc0208aba:	26a50513          	addi	a0,a0,618 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208abe:	e406                	sd	ra,8(sp)
ffffffffc0208ac0:	9dff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ac4 <dev_gettype>:
ffffffffc0208ac4:	c10d                	beqz	a0,ffffffffc0208ae6 <dev_gettype+0x22>
ffffffffc0208ac6:	4d38                	lw	a4,88(a0)
ffffffffc0208ac8:	6785                	lui	a5,0x1
ffffffffc0208aca:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208ace:	00f71c63          	bne	a4,a5,ffffffffc0208ae6 <dev_gettype+0x22>
ffffffffc0208ad2:	6118                	ld	a4,0(a0)
ffffffffc0208ad4:	6795                	lui	a5,0x5
ffffffffc0208ad6:	c701                	beqz	a4,ffffffffc0208ade <dev_gettype+0x1a>
ffffffffc0208ad8:	c19c                	sw	a5,0(a1)
ffffffffc0208ada:	4501                	li	a0,0
ffffffffc0208adc:	8082                	ret
ffffffffc0208ade:	6791                	lui	a5,0x4
ffffffffc0208ae0:	c19c                	sw	a5,0(a1)
ffffffffc0208ae2:	4501                	li	a0,0
ffffffffc0208ae4:	8082                	ret
ffffffffc0208ae6:	1141                	addi	sp,sp,-16
ffffffffc0208ae8:	00006697          	auipc	a3,0x6
ffffffffc0208aec:	f2868693          	addi	a3,a3,-216 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208af0:	00003617          	auipc	a2,0x3
ffffffffc0208af4:	31060613          	addi	a2,a2,784 # ffffffffc020be00 <commands+0x210>
ffffffffc0208af8:	05300593          	li	a1,83
ffffffffc0208afc:	00006517          	auipc	a0,0x6
ffffffffc0208b00:	22450513          	addi	a0,a0,548 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208b04:	e406                	sd	ra,8(sp)
ffffffffc0208b06:	999f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208b0a <dev_write>:
ffffffffc0208b0a:	c911                	beqz	a0,ffffffffc0208b1e <dev_write+0x14>
ffffffffc0208b0c:	4d34                	lw	a3,88(a0)
ffffffffc0208b0e:	6705                	lui	a4,0x1
ffffffffc0208b10:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208b14:	00e69563          	bne	a3,a4,ffffffffc0208b1e <dev_write+0x14>
ffffffffc0208b18:	711c                	ld	a5,32(a0)
ffffffffc0208b1a:	4605                	li	a2,1
ffffffffc0208b1c:	8782                	jr	a5
ffffffffc0208b1e:	1141                	addi	sp,sp,-16
ffffffffc0208b20:	00006697          	auipc	a3,0x6
ffffffffc0208b24:	ef068693          	addi	a3,a3,-272 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208b28:	00003617          	auipc	a2,0x3
ffffffffc0208b2c:	2d860613          	addi	a2,a2,728 # ffffffffc020be00 <commands+0x210>
ffffffffc0208b30:	02c00593          	li	a1,44
ffffffffc0208b34:	00006517          	auipc	a0,0x6
ffffffffc0208b38:	1ec50513          	addi	a0,a0,492 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208b3c:	e406                	sd	ra,8(sp)
ffffffffc0208b3e:	961f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208b42 <dev_read>:
ffffffffc0208b42:	c911                	beqz	a0,ffffffffc0208b56 <dev_read+0x14>
ffffffffc0208b44:	4d34                	lw	a3,88(a0)
ffffffffc0208b46:	6705                	lui	a4,0x1
ffffffffc0208b48:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208b4c:	00e69563          	bne	a3,a4,ffffffffc0208b56 <dev_read+0x14>
ffffffffc0208b50:	711c                	ld	a5,32(a0)
ffffffffc0208b52:	4601                	li	a2,0
ffffffffc0208b54:	8782                	jr	a5
ffffffffc0208b56:	1141                	addi	sp,sp,-16
ffffffffc0208b58:	00006697          	auipc	a3,0x6
ffffffffc0208b5c:	eb868693          	addi	a3,a3,-328 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208b60:	00003617          	auipc	a2,0x3
ffffffffc0208b64:	2a060613          	addi	a2,a2,672 # ffffffffc020be00 <commands+0x210>
ffffffffc0208b68:	02300593          	li	a1,35
ffffffffc0208b6c:	00006517          	auipc	a0,0x6
ffffffffc0208b70:	1b450513          	addi	a0,a0,436 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208b74:	e406                	sd	ra,8(sp)
ffffffffc0208b76:	929f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208b7a <dev_close>:
ffffffffc0208b7a:	c909                	beqz	a0,ffffffffc0208b8c <dev_close+0x12>
ffffffffc0208b7c:	4d34                	lw	a3,88(a0)
ffffffffc0208b7e:	6705                	lui	a4,0x1
ffffffffc0208b80:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208b84:	00e69463          	bne	a3,a4,ffffffffc0208b8c <dev_close+0x12>
ffffffffc0208b88:	6d1c                	ld	a5,24(a0)
ffffffffc0208b8a:	8782                	jr	a5
ffffffffc0208b8c:	1141                	addi	sp,sp,-16
ffffffffc0208b8e:	00006697          	auipc	a3,0x6
ffffffffc0208b92:	e8268693          	addi	a3,a3,-382 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208b96:	00003617          	auipc	a2,0x3
ffffffffc0208b9a:	26a60613          	addi	a2,a2,618 # ffffffffc020be00 <commands+0x210>
ffffffffc0208b9e:	45e9                	li	a1,26
ffffffffc0208ba0:	00006517          	auipc	a0,0x6
ffffffffc0208ba4:	18050513          	addi	a0,a0,384 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208ba8:	e406                	sd	ra,8(sp)
ffffffffc0208baa:	8f5f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208bae <dev_open>:
ffffffffc0208bae:	03c5f713          	andi	a4,a1,60
ffffffffc0208bb2:	eb11                	bnez	a4,ffffffffc0208bc6 <dev_open+0x18>
ffffffffc0208bb4:	c919                	beqz	a0,ffffffffc0208bca <dev_open+0x1c>
ffffffffc0208bb6:	4d34                	lw	a3,88(a0)
ffffffffc0208bb8:	6705                	lui	a4,0x1
ffffffffc0208bba:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208bbe:	00e69663          	bne	a3,a4,ffffffffc0208bca <dev_open+0x1c>
ffffffffc0208bc2:	691c                	ld	a5,16(a0)
ffffffffc0208bc4:	8782                	jr	a5
ffffffffc0208bc6:	5575                	li	a0,-3
ffffffffc0208bc8:	8082                	ret
ffffffffc0208bca:	1141                	addi	sp,sp,-16
ffffffffc0208bcc:	00006697          	auipc	a3,0x6
ffffffffc0208bd0:	e4468693          	addi	a3,a3,-444 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208bd4:	00003617          	auipc	a2,0x3
ffffffffc0208bd8:	22c60613          	addi	a2,a2,556 # ffffffffc020be00 <commands+0x210>
ffffffffc0208bdc:	45c5                	li	a1,17
ffffffffc0208bde:	00006517          	auipc	a0,0x6
ffffffffc0208be2:	14250513          	addi	a0,a0,322 # ffffffffc020ed20 <syscalls+0xe20>
ffffffffc0208be6:	e406                	sd	ra,8(sp)
ffffffffc0208be8:	8b7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208bec <dev_init>:
ffffffffc0208bec:	1141                	addi	sp,sp,-16
ffffffffc0208bee:	e406                	sd	ra,8(sp)
ffffffffc0208bf0:	542000ef          	jal	ra,ffffffffc0209132 <dev_init_stdin>
ffffffffc0208bf4:	65a000ef          	jal	ra,ffffffffc020924e <dev_init_stdout>
ffffffffc0208bf8:	60a2                	ld	ra,8(sp)
ffffffffc0208bfa:	0141                	addi	sp,sp,16
ffffffffc0208bfc:	a439                	j	ffffffffc0208e0a <dev_init_disk0>

ffffffffc0208bfe <dev_create_inode>:
ffffffffc0208bfe:	6505                	lui	a0,0x1
ffffffffc0208c00:	1141                	addi	sp,sp,-16
ffffffffc0208c02:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208c06:	e022                	sd	s0,0(sp)
ffffffffc0208c08:	e406                	sd	ra,8(sp)
ffffffffc0208c0a:	852ff0ef          	jal	ra,ffffffffc0207c5c <__alloc_inode>
ffffffffc0208c0e:	842a                	mv	s0,a0
ffffffffc0208c10:	c901                	beqz	a0,ffffffffc0208c20 <dev_create_inode+0x22>
ffffffffc0208c12:	4601                	li	a2,0
ffffffffc0208c14:	00006597          	auipc	a1,0x6
ffffffffc0208c18:	12458593          	addi	a1,a1,292 # ffffffffc020ed38 <dev_node_ops>
ffffffffc0208c1c:	85cff0ef          	jal	ra,ffffffffc0207c78 <inode_init>
ffffffffc0208c20:	60a2                	ld	ra,8(sp)
ffffffffc0208c22:	8522                	mv	a0,s0
ffffffffc0208c24:	6402                	ld	s0,0(sp)
ffffffffc0208c26:	0141                	addi	sp,sp,16
ffffffffc0208c28:	8082                	ret

ffffffffc0208c2a <disk0_open>:
ffffffffc0208c2a:	4501                	li	a0,0
ffffffffc0208c2c:	8082                	ret

ffffffffc0208c2e <disk0_close>:
ffffffffc0208c2e:	4501                	li	a0,0
ffffffffc0208c30:	8082                	ret

ffffffffc0208c32 <disk0_ioctl>:
ffffffffc0208c32:	5531                	li	a0,-20
ffffffffc0208c34:	8082                	ret

ffffffffc0208c36 <disk0_io>:
ffffffffc0208c36:	659c                	ld	a5,8(a1)
ffffffffc0208c38:	7159                	addi	sp,sp,-112
ffffffffc0208c3a:	eca6                	sd	s1,88(sp)
ffffffffc0208c3c:	f45e                	sd	s7,40(sp)
ffffffffc0208c3e:	6d84                	ld	s1,24(a1)
ffffffffc0208c40:	6b85                	lui	s7,0x1
ffffffffc0208c42:	1bfd                	addi	s7,s7,-1
ffffffffc0208c44:	e4ce                	sd	s3,72(sp)
ffffffffc0208c46:	43f7d993          	srai	s3,a5,0x3f
ffffffffc0208c4a:	0179f9b3          	and	s3,s3,s7
ffffffffc0208c4e:	99be                	add	s3,s3,a5
ffffffffc0208c50:	8fc5                	or	a5,a5,s1
ffffffffc0208c52:	f486                	sd	ra,104(sp)
ffffffffc0208c54:	f0a2                	sd	s0,96(sp)
ffffffffc0208c56:	e8ca                	sd	s2,80(sp)
ffffffffc0208c58:	e0d2                	sd	s4,64(sp)
ffffffffc0208c5a:	fc56                	sd	s5,56(sp)
ffffffffc0208c5c:	f85a                	sd	s6,48(sp)
ffffffffc0208c5e:	f062                	sd	s8,32(sp)
ffffffffc0208c60:	ec66                	sd	s9,24(sp)
ffffffffc0208c62:	e86a                	sd	s10,16(sp)
ffffffffc0208c64:	0177f7b3          	and	a5,a5,s7
ffffffffc0208c68:	10079d63          	bnez	a5,ffffffffc0208d82 <disk0_io+0x14c>
ffffffffc0208c6c:	40c9d993          	srai	s3,s3,0xc
ffffffffc0208c70:	00c4d713          	srli	a4,s1,0xc
ffffffffc0208c74:	2981                	sext.w	s3,s3
ffffffffc0208c76:	2701                	sext.w	a4,a4
ffffffffc0208c78:	00e987bb          	addw	a5,s3,a4
ffffffffc0208c7c:	6114                	ld	a3,0(a0)
ffffffffc0208c7e:	1782                	slli	a5,a5,0x20
ffffffffc0208c80:	9381                	srli	a5,a5,0x20
ffffffffc0208c82:	10f6e063          	bltu	a3,a5,ffffffffc0208d82 <disk0_io+0x14c>
ffffffffc0208c86:	4501                	li	a0,0
ffffffffc0208c88:	ef19                	bnez	a4,ffffffffc0208ca6 <disk0_io+0x70>
ffffffffc0208c8a:	70a6                	ld	ra,104(sp)
ffffffffc0208c8c:	7406                	ld	s0,96(sp)
ffffffffc0208c8e:	64e6                	ld	s1,88(sp)
ffffffffc0208c90:	6946                	ld	s2,80(sp)
ffffffffc0208c92:	69a6                	ld	s3,72(sp)
ffffffffc0208c94:	6a06                	ld	s4,64(sp)
ffffffffc0208c96:	7ae2                	ld	s5,56(sp)
ffffffffc0208c98:	7b42                	ld	s6,48(sp)
ffffffffc0208c9a:	7ba2                	ld	s7,40(sp)
ffffffffc0208c9c:	7c02                	ld	s8,32(sp)
ffffffffc0208c9e:	6ce2                	ld	s9,24(sp)
ffffffffc0208ca0:	6d42                	ld	s10,16(sp)
ffffffffc0208ca2:	6165                	addi	sp,sp,112
ffffffffc0208ca4:	8082                	ret
ffffffffc0208ca6:	0008d517          	auipc	a0,0x8d
ffffffffc0208caa:	b9a50513          	addi	a0,a0,-1126 # ffffffffc0295840 <disk0_sem>
ffffffffc0208cae:	8b2e                	mv	s6,a1
ffffffffc0208cb0:	8c32                	mv	s8,a2
ffffffffc0208cb2:	0008ea97          	auipc	s5,0x8e
ffffffffc0208cb6:	c46a8a93          	addi	s5,s5,-954 # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208cba:	943fb0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0208cbe:	6c91                	lui	s9,0x4
ffffffffc0208cc0:	e4b9                	bnez	s1,ffffffffc0208d0e <disk0_io+0xd8>
ffffffffc0208cc2:	a845                	j	ffffffffc0208d72 <disk0_io+0x13c>
ffffffffc0208cc4:	00c4d413          	srli	s0,s1,0xc
ffffffffc0208cc8:	0034169b          	slliw	a3,s0,0x3
ffffffffc0208ccc:	00068d1b          	sext.w	s10,a3
ffffffffc0208cd0:	1682                	slli	a3,a3,0x20
ffffffffc0208cd2:	2401                	sext.w	s0,s0
ffffffffc0208cd4:	9281                	srli	a3,a3,0x20
ffffffffc0208cd6:	8926                	mv	s2,s1
ffffffffc0208cd8:	00399a1b          	slliw	s4,s3,0x3
ffffffffc0208cdc:	862e                	mv	a2,a1
ffffffffc0208cde:	4509                	li	a0,2
ffffffffc0208ce0:	85d2                	mv	a1,s4
ffffffffc0208ce2:	e5ff70ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0208ce6:	e165                	bnez	a0,ffffffffc0208dc6 <disk0_io+0x190>
ffffffffc0208ce8:	000ab583          	ld	a1,0(s5)
ffffffffc0208cec:	0038                	addi	a4,sp,8
ffffffffc0208cee:	4685                	li	a3,1
ffffffffc0208cf0:	864a                	mv	a2,s2
ffffffffc0208cf2:	855a                	mv	a0,s6
ffffffffc0208cf4:	f90fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc0208cf8:	67a2                	ld	a5,8(sp)
ffffffffc0208cfa:	09279663          	bne	a5,s2,ffffffffc0208d86 <disk0_io+0x150>
ffffffffc0208cfe:	017977b3          	and	a5,s2,s7
ffffffffc0208d02:	e3d1                	bnez	a5,ffffffffc0208d86 <disk0_io+0x150>
ffffffffc0208d04:	412484b3          	sub	s1,s1,s2
ffffffffc0208d08:	013409bb          	addw	s3,s0,s3
ffffffffc0208d0c:	c0bd                	beqz	s1,ffffffffc0208d72 <disk0_io+0x13c>
ffffffffc0208d0e:	000ab583          	ld	a1,0(s5)
ffffffffc0208d12:	000c1b63          	bnez	s8,ffffffffc0208d28 <disk0_io+0xf2>
ffffffffc0208d16:	fb94e7e3          	bltu	s1,s9,ffffffffc0208cc4 <disk0_io+0x8e>
ffffffffc0208d1a:	02000693          	li	a3,32
ffffffffc0208d1e:	02000d13          	li	s10,32
ffffffffc0208d22:	4411                	li	s0,4
ffffffffc0208d24:	6911                	lui	s2,0x4
ffffffffc0208d26:	bf4d                	j	ffffffffc0208cd8 <disk0_io+0xa2>
ffffffffc0208d28:	0038                	addi	a4,sp,8
ffffffffc0208d2a:	4681                	li	a3,0
ffffffffc0208d2c:	6611                	lui	a2,0x4
ffffffffc0208d2e:	855a                	mv	a0,s6
ffffffffc0208d30:	f54fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc0208d34:	6422                	ld	s0,8(sp)
ffffffffc0208d36:	c825                	beqz	s0,ffffffffc0208da6 <disk0_io+0x170>
ffffffffc0208d38:	0684e763          	bltu	s1,s0,ffffffffc0208da6 <disk0_io+0x170>
ffffffffc0208d3c:	017477b3          	and	a5,s0,s7
ffffffffc0208d40:	e3bd                	bnez	a5,ffffffffc0208da6 <disk0_io+0x170>
ffffffffc0208d42:	8031                	srli	s0,s0,0xc
ffffffffc0208d44:	0034179b          	slliw	a5,s0,0x3
ffffffffc0208d48:	000ab603          	ld	a2,0(s5)
ffffffffc0208d4c:	0039991b          	slliw	s2,s3,0x3
ffffffffc0208d50:	02079693          	slli	a3,a5,0x20
ffffffffc0208d54:	9281                	srli	a3,a3,0x20
ffffffffc0208d56:	85ca                	mv	a1,s2
ffffffffc0208d58:	4509                	li	a0,2
ffffffffc0208d5a:	2401                	sext.w	s0,s0
ffffffffc0208d5c:	00078a1b          	sext.w	s4,a5
ffffffffc0208d60:	e77f70ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc0208d64:	e151                	bnez	a0,ffffffffc0208de8 <disk0_io+0x1b2>
ffffffffc0208d66:	6922                	ld	s2,8(sp)
ffffffffc0208d68:	013409bb          	addw	s3,s0,s3
ffffffffc0208d6c:	412484b3          	sub	s1,s1,s2
ffffffffc0208d70:	fcd9                	bnez	s1,ffffffffc0208d0e <disk0_io+0xd8>
ffffffffc0208d72:	0008d517          	auipc	a0,0x8d
ffffffffc0208d76:	ace50513          	addi	a0,a0,-1330 # ffffffffc0295840 <disk0_sem>
ffffffffc0208d7a:	87ffb0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0208d7e:	4501                	li	a0,0
ffffffffc0208d80:	b729                	j	ffffffffc0208c8a <disk0_io+0x54>
ffffffffc0208d82:	5575                	li	a0,-3
ffffffffc0208d84:	b719                	j	ffffffffc0208c8a <disk0_io+0x54>
ffffffffc0208d86:	00006697          	auipc	a3,0x6
ffffffffc0208d8a:	12a68693          	addi	a3,a3,298 # ffffffffc020eeb0 <dev_node_ops+0x178>
ffffffffc0208d8e:	00003617          	auipc	a2,0x3
ffffffffc0208d92:	07260613          	addi	a2,a2,114 # ffffffffc020be00 <commands+0x210>
ffffffffc0208d96:	06200593          	li	a1,98
ffffffffc0208d9a:	00006517          	auipc	a0,0x6
ffffffffc0208d9e:	05e50513          	addi	a0,a0,94 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208da2:	efcf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208da6:	00006697          	auipc	a3,0x6
ffffffffc0208daa:	01268693          	addi	a3,a3,18 # ffffffffc020edb8 <dev_node_ops+0x80>
ffffffffc0208dae:	00003617          	auipc	a2,0x3
ffffffffc0208db2:	05260613          	addi	a2,a2,82 # ffffffffc020be00 <commands+0x210>
ffffffffc0208db6:	05700593          	li	a1,87
ffffffffc0208dba:	00006517          	auipc	a0,0x6
ffffffffc0208dbe:	03e50513          	addi	a0,a0,62 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208dc2:	edcf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208dc6:	88aa                	mv	a7,a0
ffffffffc0208dc8:	886a                	mv	a6,s10
ffffffffc0208dca:	87a2                	mv	a5,s0
ffffffffc0208dcc:	8752                	mv	a4,s4
ffffffffc0208dce:	86ce                	mv	a3,s3
ffffffffc0208dd0:	00006617          	auipc	a2,0x6
ffffffffc0208dd4:	09860613          	addi	a2,a2,152 # ffffffffc020ee68 <dev_node_ops+0x130>
ffffffffc0208dd8:	02d00593          	li	a1,45
ffffffffc0208ddc:	00006517          	auipc	a0,0x6
ffffffffc0208de0:	01c50513          	addi	a0,a0,28 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208de4:	ebaf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208de8:	88aa                	mv	a7,a0
ffffffffc0208dea:	8852                	mv	a6,s4
ffffffffc0208dec:	87a2                	mv	a5,s0
ffffffffc0208dee:	874a                	mv	a4,s2
ffffffffc0208df0:	86ce                	mv	a3,s3
ffffffffc0208df2:	00006617          	auipc	a2,0x6
ffffffffc0208df6:	02660613          	addi	a2,a2,38 # ffffffffc020ee18 <dev_node_ops+0xe0>
ffffffffc0208dfa:	03700593          	li	a1,55
ffffffffc0208dfe:	00006517          	auipc	a0,0x6
ffffffffc0208e02:	ffa50513          	addi	a0,a0,-6 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208e06:	e98f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e0a <dev_init_disk0>:
ffffffffc0208e0a:	1101                	addi	sp,sp,-32
ffffffffc0208e0c:	ec06                	sd	ra,24(sp)
ffffffffc0208e0e:	e822                	sd	s0,16(sp)
ffffffffc0208e10:	e426                	sd	s1,8(sp)
ffffffffc0208e12:	dedff0ef          	jal	ra,ffffffffc0208bfe <dev_create_inode>
ffffffffc0208e16:	c541                	beqz	a0,ffffffffc0208e9e <dev_init_disk0+0x94>
ffffffffc0208e18:	4d38                	lw	a4,88(a0)
ffffffffc0208e1a:	6485                	lui	s1,0x1
ffffffffc0208e1c:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208e20:	842a                	mv	s0,a0
ffffffffc0208e22:	0cf71f63          	bne	a4,a5,ffffffffc0208f00 <dev_init_disk0+0xf6>
ffffffffc0208e26:	4509                	li	a0,2
ffffffffc0208e28:	ccdf70ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc0208e2c:	cd55                	beqz	a0,ffffffffc0208ee8 <dev_init_disk0+0xde>
ffffffffc0208e2e:	4509                	li	a0,2
ffffffffc0208e30:	ce9f70ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc0208e34:	00355793          	srli	a5,a0,0x3
ffffffffc0208e38:	e01c                	sd	a5,0(s0)
ffffffffc0208e3a:	00000797          	auipc	a5,0x0
ffffffffc0208e3e:	df078793          	addi	a5,a5,-528 # ffffffffc0208c2a <disk0_open>
ffffffffc0208e42:	e81c                	sd	a5,16(s0)
ffffffffc0208e44:	00000797          	auipc	a5,0x0
ffffffffc0208e48:	dea78793          	addi	a5,a5,-534 # ffffffffc0208c2e <disk0_close>
ffffffffc0208e4c:	ec1c                	sd	a5,24(s0)
ffffffffc0208e4e:	00000797          	auipc	a5,0x0
ffffffffc0208e52:	de878793          	addi	a5,a5,-536 # ffffffffc0208c36 <disk0_io>
ffffffffc0208e56:	f01c                	sd	a5,32(s0)
ffffffffc0208e58:	00000797          	auipc	a5,0x0
ffffffffc0208e5c:	dda78793          	addi	a5,a5,-550 # ffffffffc0208c32 <disk0_ioctl>
ffffffffc0208e60:	f41c                	sd	a5,40(s0)
ffffffffc0208e62:	4585                	li	a1,1
ffffffffc0208e64:	0008d517          	auipc	a0,0x8d
ffffffffc0208e68:	9dc50513          	addi	a0,a0,-1572 # ffffffffc0295840 <disk0_sem>
ffffffffc0208e6c:	e404                	sd	s1,8(s0)
ffffffffc0208e6e:	f84fb0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc0208e72:	6511                	lui	a0,0x4
ffffffffc0208e74:	9aef90ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0208e78:	0008e797          	auipc	a5,0x8e
ffffffffc0208e7c:	a8a7b023          	sd	a0,-1408(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208e80:	c921                	beqz	a0,ffffffffc0208ed0 <dev_init_disk0+0xc6>
ffffffffc0208e82:	4605                	li	a2,1
ffffffffc0208e84:	85a2                	mv	a1,s0
ffffffffc0208e86:	00006517          	auipc	a0,0x6
ffffffffc0208e8a:	0ba50513          	addi	a0,a0,186 # ffffffffc020ef40 <dev_node_ops+0x208>
ffffffffc0208e8e:	c2cff0ef          	jal	ra,ffffffffc02082ba <vfs_add_dev>
ffffffffc0208e92:	e115                	bnez	a0,ffffffffc0208eb6 <dev_init_disk0+0xac>
ffffffffc0208e94:	60e2                	ld	ra,24(sp)
ffffffffc0208e96:	6442                	ld	s0,16(sp)
ffffffffc0208e98:	64a2                	ld	s1,8(sp)
ffffffffc0208e9a:	6105                	addi	sp,sp,32
ffffffffc0208e9c:	8082                	ret
ffffffffc0208e9e:	00006617          	auipc	a2,0x6
ffffffffc0208ea2:	04260613          	addi	a2,a2,66 # ffffffffc020eee0 <dev_node_ops+0x1a8>
ffffffffc0208ea6:	08700593          	li	a1,135
ffffffffc0208eaa:	00006517          	auipc	a0,0x6
ffffffffc0208eae:	f4e50513          	addi	a0,a0,-178 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208eb2:	decf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208eb6:	86aa                	mv	a3,a0
ffffffffc0208eb8:	00006617          	auipc	a2,0x6
ffffffffc0208ebc:	09060613          	addi	a2,a2,144 # ffffffffc020ef48 <dev_node_ops+0x210>
ffffffffc0208ec0:	08d00593          	li	a1,141
ffffffffc0208ec4:	00006517          	auipc	a0,0x6
ffffffffc0208ec8:	f3450513          	addi	a0,a0,-204 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208ecc:	dd2f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208ed0:	00006617          	auipc	a2,0x6
ffffffffc0208ed4:	05060613          	addi	a2,a2,80 # ffffffffc020ef20 <dev_node_ops+0x1e8>
ffffffffc0208ed8:	07f00593          	li	a1,127
ffffffffc0208edc:	00006517          	auipc	a0,0x6
ffffffffc0208ee0:	f1c50513          	addi	a0,a0,-228 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208ee4:	dbaf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208ee8:	00006617          	auipc	a2,0x6
ffffffffc0208eec:	01860613          	addi	a2,a2,24 # ffffffffc020ef00 <dev_node_ops+0x1c8>
ffffffffc0208ef0:	07300593          	li	a1,115
ffffffffc0208ef4:	00006517          	auipc	a0,0x6
ffffffffc0208ef8:	f0450513          	addi	a0,a0,-252 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208efc:	da2f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208f00:	00006697          	auipc	a3,0x6
ffffffffc0208f04:	b1068693          	addi	a3,a3,-1264 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc0208f08:	00003617          	auipc	a2,0x3
ffffffffc0208f0c:	ef860613          	addi	a2,a2,-264 # ffffffffc020be00 <commands+0x210>
ffffffffc0208f10:	08900593          	li	a1,137
ffffffffc0208f14:	00006517          	auipc	a0,0x6
ffffffffc0208f18:	ee450513          	addi	a0,a0,-284 # ffffffffc020edf8 <dev_node_ops+0xc0>
ffffffffc0208f1c:	d82f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f20 <stdin_open>:
ffffffffc0208f20:	4501                	li	a0,0
ffffffffc0208f22:	e191                	bnez	a1,ffffffffc0208f26 <stdin_open+0x6>
ffffffffc0208f24:	8082                	ret
ffffffffc0208f26:	5575                	li	a0,-3
ffffffffc0208f28:	8082                	ret

ffffffffc0208f2a <stdin_close>:
ffffffffc0208f2a:	4501                	li	a0,0
ffffffffc0208f2c:	8082                	ret

ffffffffc0208f2e <stdin_ioctl>:
ffffffffc0208f2e:	5575                	li	a0,-3
ffffffffc0208f30:	8082                	ret

ffffffffc0208f32 <stdin_io>:
ffffffffc0208f32:	7135                	addi	sp,sp,-160
ffffffffc0208f34:	ed06                	sd	ra,152(sp)
ffffffffc0208f36:	e922                	sd	s0,144(sp)
ffffffffc0208f38:	e526                	sd	s1,136(sp)
ffffffffc0208f3a:	e14a                	sd	s2,128(sp)
ffffffffc0208f3c:	fcce                	sd	s3,120(sp)
ffffffffc0208f3e:	f8d2                	sd	s4,112(sp)
ffffffffc0208f40:	f4d6                	sd	s5,104(sp)
ffffffffc0208f42:	f0da                	sd	s6,96(sp)
ffffffffc0208f44:	ecde                	sd	s7,88(sp)
ffffffffc0208f46:	e8e2                	sd	s8,80(sp)
ffffffffc0208f48:	e4e6                	sd	s9,72(sp)
ffffffffc0208f4a:	e0ea                	sd	s10,64(sp)
ffffffffc0208f4c:	fc6e                	sd	s11,56(sp)
ffffffffc0208f4e:	14061163          	bnez	a2,ffffffffc0209090 <stdin_io+0x15e>
ffffffffc0208f52:	0005bd83          	ld	s11,0(a1)
ffffffffc0208f56:	0185bd03          	ld	s10,24(a1)
ffffffffc0208f5a:	8b2e                	mv	s6,a1
ffffffffc0208f5c:	100027f3          	csrr	a5,sstatus
ffffffffc0208f60:	8b89                	andi	a5,a5,2
ffffffffc0208f62:	10079e63          	bnez	a5,ffffffffc020907e <stdin_io+0x14c>
ffffffffc0208f66:	4401                	li	s0,0
ffffffffc0208f68:	100d0963          	beqz	s10,ffffffffc020907a <stdin_io+0x148>
ffffffffc0208f6c:	0008e997          	auipc	s3,0x8e
ffffffffc0208f70:	99498993          	addi	s3,s3,-1644 # ffffffffc0296900 <p_rpos>
ffffffffc0208f74:	0009b783          	ld	a5,0(s3)
ffffffffc0208f78:	800004b7          	lui	s1,0x80000
ffffffffc0208f7c:	6c85                	lui	s9,0x1
ffffffffc0208f7e:	4a81                	li	s5,0
ffffffffc0208f80:	0008ea17          	auipc	s4,0x8e
ffffffffc0208f84:	988a0a13          	addi	s4,s4,-1656 # ffffffffc0296908 <p_wpos>
ffffffffc0208f88:	0491                	addi	s1,s1,4
ffffffffc0208f8a:	0008d917          	auipc	s2,0x8d
ffffffffc0208f8e:	8ce90913          	addi	s2,s2,-1842 # ffffffffc0295858 <__wait_queue>
ffffffffc0208f92:	1cfd                	addi	s9,s9,-1
ffffffffc0208f94:	000a3703          	ld	a4,0(s4)
ffffffffc0208f98:	000a8c1b          	sext.w	s8,s5
ffffffffc0208f9c:	8be2                	mv	s7,s8
ffffffffc0208f9e:	02e7d763          	bge	a5,a4,ffffffffc0208fcc <stdin_io+0x9a>
ffffffffc0208fa2:	a859                	j	ffffffffc0209038 <stdin_io+0x106>
ffffffffc0208fa4:	815fe0ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc0208fa8:	100027f3          	csrr	a5,sstatus
ffffffffc0208fac:	8b89                	andi	a5,a5,2
ffffffffc0208fae:	4401                	li	s0,0
ffffffffc0208fb0:	ef8d                	bnez	a5,ffffffffc0208fea <stdin_io+0xb8>
ffffffffc0208fb2:	0028                	addi	a0,sp,8
ffffffffc0208fb4:	edafb0ef          	jal	ra,ffffffffc020468e <wait_in_queue>
ffffffffc0208fb8:	e121                	bnez	a0,ffffffffc0208ff8 <stdin_io+0xc6>
ffffffffc0208fba:	47c2                	lw	a5,16(sp)
ffffffffc0208fbc:	04979563          	bne	a5,s1,ffffffffc0209006 <stdin_io+0xd4>
ffffffffc0208fc0:	0009b783          	ld	a5,0(s3)
ffffffffc0208fc4:	000a3703          	ld	a4,0(s4)
ffffffffc0208fc8:	06e7c863          	blt	a5,a4,ffffffffc0209038 <stdin_io+0x106>
ffffffffc0208fcc:	8626                	mv	a2,s1
ffffffffc0208fce:	002c                	addi	a1,sp,8
ffffffffc0208fd0:	854a                	mv	a0,s2
ffffffffc0208fd2:	fe6fb0ef          	jal	ra,ffffffffc02047b8 <wait_current_set>
ffffffffc0208fd6:	d479                	beqz	s0,ffffffffc0208fa4 <stdin_io+0x72>
ffffffffc0208fd8:	c95f70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208fdc:	fdcfe0ef          	jal	ra,ffffffffc02077b8 <schedule>
ffffffffc0208fe0:	100027f3          	csrr	a5,sstatus
ffffffffc0208fe4:	8b89                	andi	a5,a5,2
ffffffffc0208fe6:	4401                	li	s0,0
ffffffffc0208fe8:	d7e9                	beqz	a5,ffffffffc0208fb2 <stdin_io+0x80>
ffffffffc0208fea:	c89f70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208fee:	0028                	addi	a0,sp,8
ffffffffc0208ff0:	4405                	li	s0,1
ffffffffc0208ff2:	e9cfb0ef          	jal	ra,ffffffffc020468e <wait_in_queue>
ffffffffc0208ff6:	d171                	beqz	a0,ffffffffc0208fba <stdin_io+0x88>
ffffffffc0208ff8:	002c                	addi	a1,sp,8
ffffffffc0208ffa:	854a                	mv	a0,s2
ffffffffc0208ffc:	e38fb0ef          	jal	ra,ffffffffc0204634 <wait_queue_del>
ffffffffc0209000:	47c2                	lw	a5,16(sp)
ffffffffc0209002:	fa978fe3          	beq	a5,s1,ffffffffc0208fc0 <stdin_io+0x8e>
ffffffffc0209006:	e435                	bnez	s0,ffffffffc0209072 <stdin_io+0x140>
ffffffffc0209008:	060b8963          	beqz	s7,ffffffffc020907a <stdin_io+0x148>
ffffffffc020900c:	018b3783          	ld	a5,24(s6)
ffffffffc0209010:	41578ab3          	sub	s5,a5,s5
ffffffffc0209014:	015b3c23          	sd	s5,24(s6)
ffffffffc0209018:	60ea                	ld	ra,152(sp)
ffffffffc020901a:	644a                	ld	s0,144(sp)
ffffffffc020901c:	64aa                	ld	s1,136(sp)
ffffffffc020901e:	690a                	ld	s2,128(sp)
ffffffffc0209020:	79e6                	ld	s3,120(sp)
ffffffffc0209022:	7a46                	ld	s4,112(sp)
ffffffffc0209024:	7aa6                	ld	s5,104(sp)
ffffffffc0209026:	7b06                	ld	s6,96(sp)
ffffffffc0209028:	6c46                	ld	s8,80(sp)
ffffffffc020902a:	6ca6                	ld	s9,72(sp)
ffffffffc020902c:	6d06                	ld	s10,64(sp)
ffffffffc020902e:	7de2                	ld	s11,56(sp)
ffffffffc0209030:	855e                	mv	a0,s7
ffffffffc0209032:	6be6                	ld	s7,88(sp)
ffffffffc0209034:	610d                	addi	sp,sp,160
ffffffffc0209036:	8082                	ret
ffffffffc0209038:	43f7d713          	srai	a4,a5,0x3f
ffffffffc020903c:	03475693          	srli	a3,a4,0x34
ffffffffc0209040:	00d78733          	add	a4,a5,a3
ffffffffc0209044:	01977733          	and	a4,a4,s9
ffffffffc0209048:	8f15                	sub	a4,a4,a3
ffffffffc020904a:	0008d697          	auipc	a3,0x8d
ffffffffc020904e:	81e68693          	addi	a3,a3,-2018 # ffffffffc0295868 <stdin_buffer>
ffffffffc0209052:	9736                	add	a4,a4,a3
ffffffffc0209054:	00074683          	lbu	a3,0(a4)
ffffffffc0209058:	0785                	addi	a5,a5,1
ffffffffc020905a:	015d8733          	add	a4,s11,s5
ffffffffc020905e:	00d70023          	sb	a3,0(a4)
ffffffffc0209062:	00f9b023          	sd	a5,0(s3)
ffffffffc0209066:	0a85                	addi	s5,s5,1
ffffffffc0209068:	001c0b9b          	addiw	s7,s8,1
ffffffffc020906c:	f3aae4e3          	bltu	s5,s10,ffffffffc0208f94 <stdin_io+0x62>
ffffffffc0209070:	dc51                	beqz	s0,ffffffffc020900c <stdin_io+0xda>
ffffffffc0209072:	bfbf70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0209076:	f80b9be3          	bnez	s7,ffffffffc020900c <stdin_io+0xda>
ffffffffc020907a:	4b81                	li	s7,0
ffffffffc020907c:	bf71                	j	ffffffffc0209018 <stdin_io+0xe6>
ffffffffc020907e:	bf5f70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0209082:	4405                	li	s0,1
ffffffffc0209084:	ee0d14e3          	bnez	s10,ffffffffc0208f6c <stdin_io+0x3a>
ffffffffc0209088:	be5f70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020908c:	4b81                	li	s7,0
ffffffffc020908e:	b769                	j	ffffffffc0209018 <stdin_io+0xe6>
ffffffffc0209090:	5bf5                	li	s7,-3
ffffffffc0209092:	b759                	j	ffffffffc0209018 <stdin_io+0xe6>

ffffffffc0209094 <dev_stdin_write>:
ffffffffc0209094:	e111                	bnez	a0,ffffffffc0209098 <dev_stdin_write+0x4>
ffffffffc0209096:	8082                	ret
ffffffffc0209098:	1101                	addi	sp,sp,-32
ffffffffc020909a:	e822                	sd	s0,16(sp)
ffffffffc020909c:	ec06                	sd	ra,24(sp)
ffffffffc020909e:	e426                	sd	s1,8(sp)
ffffffffc02090a0:	842a                	mv	s0,a0
ffffffffc02090a2:	100027f3          	csrr	a5,sstatus
ffffffffc02090a6:	8b89                	andi	a5,a5,2
ffffffffc02090a8:	4481                	li	s1,0
ffffffffc02090aa:	e3c1                	bnez	a5,ffffffffc020912a <dev_stdin_write+0x96>
ffffffffc02090ac:	0008e597          	auipc	a1,0x8e
ffffffffc02090b0:	85c58593          	addi	a1,a1,-1956 # ffffffffc0296908 <p_wpos>
ffffffffc02090b4:	6198                	ld	a4,0(a1)
ffffffffc02090b6:	6605                	lui	a2,0x1
ffffffffc02090b8:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc02090bc:	43f75693          	srai	a3,a4,0x3f
ffffffffc02090c0:	92d1                	srli	a3,a3,0x34
ffffffffc02090c2:	00d707b3          	add	a5,a4,a3
ffffffffc02090c6:	8fe9                	and	a5,a5,a0
ffffffffc02090c8:	8f95                	sub	a5,a5,a3
ffffffffc02090ca:	0008c697          	auipc	a3,0x8c
ffffffffc02090ce:	79e68693          	addi	a3,a3,1950 # ffffffffc0295868 <stdin_buffer>
ffffffffc02090d2:	97b6                	add	a5,a5,a3
ffffffffc02090d4:	00878023          	sb	s0,0(a5)
ffffffffc02090d8:	0008e797          	auipc	a5,0x8e
ffffffffc02090dc:	8287b783          	ld	a5,-2008(a5) # ffffffffc0296900 <p_rpos>
ffffffffc02090e0:	40f707b3          	sub	a5,a4,a5
ffffffffc02090e4:	00c7d463          	bge	a5,a2,ffffffffc02090ec <dev_stdin_write+0x58>
ffffffffc02090e8:	0705                	addi	a4,a4,1
ffffffffc02090ea:	e198                	sd	a4,0(a1)
ffffffffc02090ec:	0008c517          	auipc	a0,0x8c
ffffffffc02090f0:	76c50513          	addi	a0,a0,1900 # ffffffffc0295858 <__wait_queue>
ffffffffc02090f4:	d8efb0ef          	jal	ra,ffffffffc0204682 <wait_queue_empty>
ffffffffc02090f8:	cd09                	beqz	a0,ffffffffc0209112 <dev_stdin_write+0x7e>
ffffffffc02090fa:	e491                	bnez	s1,ffffffffc0209106 <dev_stdin_write+0x72>
ffffffffc02090fc:	60e2                	ld	ra,24(sp)
ffffffffc02090fe:	6442                	ld	s0,16(sp)
ffffffffc0209100:	64a2                	ld	s1,8(sp)
ffffffffc0209102:	6105                	addi	sp,sp,32
ffffffffc0209104:	8082                	ret
ffffffffc0209106:	6442                	ld	s0,16(sp)
ffffffffc0209108:	60e2                	ld	ra,24(sp)
ffffffffc020910a:	64a2                	ld	s1,8(sp)
ffffffffc020910c:	6105                	addi	sp,sp,32
ffffffffc020910e:	b5ff706f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0209112:	800005b7          	lui	a1,0x80000
ffffffffc0209116:	4605                	li	a2,1
ffffffffc0209118:	0591                	addi	a1,a1,4
ffffffffc020911a:	0008c517          	auipc	a0,0x8c
ffffffffc020911e:	73e50513          	addi	a0,a0,1854 # ffffffffc0295858 <__wait_queue>
ffffffffc0209122:	dc8fb0ef          	jal	ra,ffffffffc02046ea <wakeup_queue>
ffffffffc0209126:	d8f9                	beqz	s1,ffffffffc02090fc <dev_stdin_write+0x68>
ffffffffc0209128:	bff9                	j	ffffffffc0209106 <dev_stdin_write+0x72>
ffffffffc020912a:	b49f70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020912e:	4485                	li	s1,1
ffffffffc0209130:	bfb5                	j	ffffffffc02090ac <dev_stdin_write+0x18>

ffffffffc0209132 <dev_init_stdin>:
ffffffffc0209132:	1141                	addi	sp,sp,-16
ffffffffc0209134:	e406                	sd	ra,8(sp)
ffffffffc0209136:	e022                	sd	s0,0(sp)
ffffffffc0209138:	ac7ff0ef          	jal	ra,ffffffffc0208bfe <dev_create_inode>
ffffffffc020913c:	c93d                	beqz	a0,ffffffffc02091b2 <dev_init_stdin+0x80>
ffffffffc020913e:	4d38                	lw	a4,88(a0)
ffffffffc0209140:	6785                	lui	a5,0x1
ffffffffc0209142:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0209146:	842a                	mv	s0,a0
ffffffffc0209148:	08f71e63          	bne	a4,a5,ffffffffc02091e4 <dev_init_stdin+0xb2>
ffffffffc020914c:	4785                	li	a5,1
ffffffffc020914e:	e41c                	sd	a5,8(s0)
ffffffffc0209150:	00000797          	auipc	a5,0x0
ffffffffc0209154:	dd078793          	addi	a5,a5,-560 # ffffffffc0208f20 <stdin_open>
ffffffffc0209158:	e81c                	sd	a5,16(s0)
ffffffffc020915a:	00000797          	auipc	a5,0x0
ffffffffc020915e:	dd078793          	addi	a5,a5,-560 # ffffffffc0208f2a <stdin_close>
ffffffffc0209162:	ec1c                	sd	a5,24(s0)
ffffffffc0209164:	00000797          	auipc	a5,0x0
ffffffffc0209168:	dce78793          	addi	a5,a5,-562 # ffffffffc0208f32 <stdin_io>
ffffffffc020916c:	f01c                	sd	a5,32(s0)
ffffffffc020916e:	00000797          	auipc	a5,0x0
ffffffffc0209172:	dc078793          	addi	a5,a5,-576 # ffffffffc0208f2e <stdin_ioctl>
ffffffffc0209176:	f41c                	sd	a5,40(s0)
ffffffffc0209178:	0008c517          	auipc	a0,0x8c
ffffffffc020917c:	6e050513          	addi	a0,a0,1760 # ffffffffc0295858 <__wait_queue>
ffffffffc0209180:	00043023          	sd	zero,0(s0)
ffffffffc0209184:	0008d797          	auipc	a5,0x8d
ffffffffc0209188:	7807b223          	sd	zero,1924(a5) # ffffffffc0296908 <p_wpos>
ffffffffc020918c:	0008d797          	auipc	a5,0x8d
ffffffffc0209190:	7607ba23          	sd	zero,1908(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0209194:	c9afb0ef          	jal	ra,ffffffffc020462e <wait_queue_init>
ffffffffc0209198:	4601                	li	a2,0
ffffffffc020919a:	85a2                	mv	a1,s0
ffffffffc020919c:	00006517          	auipc	a0,0x6
ffffffffc02091a0:	e0c50513          	addi	a0,a0,-500 # ffffffffc020efa8 <dev_node_ops+0x270>
ffffffffc02091a4:	916ff0ef          	jal	ra,ffffffffc02082ba <vfs_add_dev>
ffffffffc02091a8:	e10d                	bnez	a0,ffffffffc02091ca <dev_init_stdin+0x98>
ffffffffc02091aa:	60a2                	ld	ra,8(sp)
ffffffffc02091ac:	6402                	ld	s0,0(sp)
ffffffffc02091ae:	0141                	addi	sp,sp,16
ffffffffc02091b0:	8082                	ret
ffffffffc02091b2:	00006617          	auipc	a2,0x6
ffffffffc02091b6:	db660613          	addi	a2,a2,-586 # ffffffffc020ef68 <dev_node_ops+0x230>
ffffffffc02091ba:	07500593          	li	a1,117
ffffffffc02091be:	00006517          	auipc	a0,0x6
ffffffffc02091c2:	dca50513          	addi	a0,a0,-566 # ffffffffc020ef88 <dev_node_ops+0x250>
ffffffffc02091c6:	ad8f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02091ca:	86aa                	mv	a3,a0
ffffffffc02091cc:	00006617          	auipc	a2,0x6
ffffffffc02091d0:	de460613          	addi	a2,a2,-540 # ffffffffc020efb0 <dev_node_ops+0x278>
ffffffffc02091d4:	07b00593          	li	a1,123
ffffffffc02091d8:	00006517          	auipc	a0,0x6
ffffffffc02091dc:	db050513          	addi	a0,a0,-592 # ffffffffc020ef88 <dev_node_ops+0x250>
ffffffffc02091e0:	abef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02091e4:	00006697          	auipc	a3,0x6
ffffffffc02091e8:	82c68693          	addi	a3,a3,-2004 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc02091ec:	00003617          	auipc	a2,0x3
ffffffffc02091f0:	c1460613          	addi	a2,a2,-1004 # ffffffffc020be00 <commands+0x210>
ffffffffc02091f4:	07700593          	li	a1,119
ffffffffc02091f8:	00006517          	auipc	a0,0x6
ffffffffc02091fc:	d9050513          	addi	a0,a0,-624 # ffffffffc020ef88 <dev_node_ops+0x250>
ffffffffc0209200:	a9ef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209204 <stdout_open>:
ffffffffc0209204:	4785                	li	a5,1
ffffffffc0209206:	4501                	li	a0,0
ffffffffc0209208:	00f59363          	bne	a1,a5,ffffffffc020920e <stdout_open+0xa>
ffffffffc020920c:	8082                	ret
ffffffffc020920e:	5575                	li	a0,-3
ffffffffc0209210:	8082                	ret

ffffffffc0209212 <stdout_close>:
ffffffffc0209212:	4501                	li	a0,0
ffffffffc0209214:	8082                	ret

ffffffffc0209216 <stdout_ioctl>:
ffffffffc0209216:	5575                	li	a0,-3
ffffffffc0209218:	8082                	ret

ffffffffc020921a <stdout_io>:
ffffffffc020921a:	ca05                	beqz	a2,ffffffffc020924a <stdout_io+0x30>
ffffffffc020921c:	6d9c                	ld	a5,24(a1)
ffffffffc020921e:	1101                	addi	sp,sp,-32
ffffffffc0209220:	e822                	sd	s0,16(sp)
ffffffffc0209222:	e426                	sd	s1,8(sp)
ffffffffc0209224:	ec06                	sd	ra,24(sp)
ffffffffc0209226:	6180                	ld	s0,0(a1)
ffffffffc0209228:	84ae                	mv	s1,a1
ffffffffc020922a:	cb91                	beqz	a5,ffffffffc020923e <stdout_io+0x24>
ffffffffc020922c:	00044503          	lbu	a0,0(s0)
ffffffffc0209230:	0405                	addi	s0,s0,1
ffffffffc0209232:	fb1f60ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0209236:	6c9c                	ld	a5,24(s1)
ffffffffc0209238:	17fd                	addi	a5,a5,-1
ffffffffc020923a:	ec9c                	sd	a5,24(s1)
ffffffffc020923c:	fbe5                	bnez	a5,ffffffffc020922c <stdout_io+0x12>
ffffffffc020923e:	60e2                	ld	ra,24(sp)
ffffffffc0209240:	6442                	ld	s0,16(sp)
ffffffffc0209242:	64a2                	ld	s1,8(sp)
ffffffffc0209244:	4501                	li	a0,0
ffffffffc0209246:	6105                	addi	sp,sp,32
ffffffffc0209248:	8082                	ret
ffffffffc020924a:	5575                	li	a0,-3
ffffffffc020924c:	8082                	ret

ffffffffc020924e <dev_init_stdout>:
ffffffffc020924e:	1141                	addi	sp,sp,-16
ffffffffc0209250:	e406                	sd	ra,8(sp)
ffffffffc0209252:	9adff0ef          	jal	ra,ffffffffc0208bfe <dev_create_inode>
ffffffffc0209256:	c939                	beqz	a0,ffffffffc02092ac <dev_init_stdout+0x5e>
ffffffffc0209258:	4d38                	lw	a4,88(a0)
ffffffffc020925a:	6785                	lui	a5,0x1
ffffffffc020925c:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0209260:	85aa                	mv	a1,a0
ffffffffc0209262:	06f71e63          	bne	a4,a5,ffffffffc02092de <dev_init_stdout+0x90>
ffffffffc0209266:	4785                	li	a5,1
ffffffffc0209268:	e51c                	sd	a5,8(a0)
ffffffffc020926a:	00000797          	auipc	a5,0x0
ffffffffc020926e:	f9a78793          	addi	a5,a5,-102 # ffffffffc0209204 <stdout_open>
ffffffffc0209272:	e91c                	sd	a5,16(a0)
ffffffffc0209274:	00000797          	auipc	a5,0x0
ffffffffc0209278:	f9e78793          	addi	a5,a5,-98 # ffffffffc0209212 <stdout_close>
ffffffffc020927c:	ed1c                	sd	a5,24(a0)
ffffffffc020927e:	00000797          	auipc	a5,0x0
ffffffffc0209282:	f9c78793          	addi	a5,a5,-100 # ffffffffc020921a <stdout_io>
ffffffffc0209286:	f11c                	sd	a5,32(a0)
ffffffffc0209288:	00000797          	auipc	a5,0x0
ffffffffc020928c:	f8e78793          	addi	a5,a5,-114 # ffffffffc0209216 <stdout_ioctl>
ffffffffc0209290:	00053023          	sd	zero,0(a0)
ffffffffc0209294:	f51c                	sd	a5,40(a0)
ffffffffc0209296:	4601                	li	a2,0
ffffffffc0209298:	00006517          	auipc	a0,0x6
ffffffffc020929c:	d7850513          	addi	a0,a0,-648 # ffffffffc020f010 <dev_node_ops+0x2d8>
ffffffffc02092a0:	81aff0ef          	jal	ra,ffffffffc02082ba <vfs_add_dev>
ffffffffc02092a4:	e105                	bnez	a0,ffffffffc02092c4 <dev_init_stdout+0x76>
ffffffffc02092a6:	60a2                	ld	ra,8(sp)
ffffffffc02092a8:	0141                	addi	sp,sp,16
ffffffffc02092aa:	8082                	ret
ffffffffc02092ac:	00006617          	auipc	a2,0x6
ffffffffc02092b0:	d2460613          	addi	a2,a2,-732 # ffffffffc020efd0 <dev_node_ops+0x298>
ffffffffc02092b4:	03700593          	li	a1,55
ffffffffc02092b8:	00006517          	auipc	a0,0x6
ffffffffc02092bc:	d3850513          	addi	a0,a0,-712 # ffffffffc020eff0 <dev_node_ops+0x2b8>
ffffffffc02092c0:	9def70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02092c4:	86aa                	mv	a3,a0
ffffffffc02092c6:	00006617          	auipc	a2,0x6
ffffffffc02092ca:	d5260613          	addi	a2,a2,-686 # ffffffffc020f018 <dev_node_ops+0x2e0>
ffffffffc02092ce:	03d00593          	li	a1,61
ffffffffc02092d2:	00006517          	auipc	a0,0x6
ffffffffc02092d6:	d1e50513          	addi	a0,a0,-738 # ffffffffc020eff0 <dev_node_ops+0x2b8>
ffffffffc02092da:	9c4f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02092de:	00005697          	auipc	a3,0x5
ffffffffc02092e2:	73268693          	addi	a3,a3,1842 # ffffffffc020ea10 <syscalls+0xb10>
ffffffffc02092e6:	00003617          	auipc	a2,0x3
ffffffffc02092ea:	b1a60613          	addi	a2,a2,-1254 # ffffffffc020be00 <commands+0x210>
ffffffffc02092ee:	03900593          	li	a1,57
ffffffffc02092f2:	00006517          	auipc	a0,0x6
ffffffffc02092f6:	cfe50513          	addi	a0,a0,-770 # ffffffffc020eff0 <dev_node_ops+0x2b8>
ffffffffc02092fa:	9a4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02092fe <bitmap_translate.part.0>:
ffffffffc02092fe:	1141                	addi	sp,sp,-16
ffffffffc0209300:	00006697          	auipc	a3,0x6
ffffffffc0209304:	d3868693          	addi	a3,a3,-712 # ffffffffc020f038 <dev_node_ops+0x300>
ffffffffc0209308:	00003617          	auipc	a2,0x3
ffffffffc020930c:	af860613          	addi	a2,a2,-1288 # ffffffffc020be00 <commands+0x210>
ffffffffc0209310:	04c00593          	li	a1,76
ffffffffc0209314:	00006517          	auipc	a0,0x6
ffffffffc0209318:	d3c50513          	addi	a0,a0,-708 # ffffffffc020f050 <dev_node_ops+0x318>
ffffffffc020931c:	e406                	sd	ra,8(sp)
ffffffffc020931e:	980f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209322 <bitmap_create>:
ffffffffc0209322:	7139                	addi	sp,sp,-64
ffffffffc0209324:	fc06                	sd	ra,56(sp)
ffffffffc0209326:	f822                	sd	s0,48(sp)
ffffffffc0209328:	f426                	sd	s1,40(sp)
ffffffffc020932a:	f04a                	sd	s2,32(sp)
ffffffffc020932c:	ec4e                	sd	s3,24(sp)
ffffffffc020932e:	e852                	sd	s4,16(sp)
ffffffffc0209330:	e456                	sd	s5,8(sp)
ffffffffc0209332:	c14d                	beqz	a0,ffffffffc02093d4 <bitmap_create+0xb2>
ffffffffc0209334:	842a                	mv	s0,a0
ffffffffc0209336:	4541                	li	a0,16
ffffffffc0209338:	cebf80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020933c:	84aa                	mv	s1,a0
ffffffffc020933e:	cd25                	beqz	a0,ffffffffc02093b6 <bitmap_create+0x94>
ffffffffc0209340:	02041a13          	slli	s4,s0,0x20
ffffffffc0209344:	020a5a13          	srli	s4,s4,0x20
ffffffffc0209348:	01fa0793          	addi	a5,s4,31
ffffffffc020934c:	0057d993          	srli	s3,a5,0x5
ffffffffc0209350:	00299a93          	slli	s5,s3,0x2
ffffffffc0209354:	8556                	mv	a0,s5
ffffffffc0209356:	894e                	mv	s2,s3
ffffffffc0209358:	ccbf80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020935c:	c53d                	beqz	a0,ffffffffc02093ca <bitmap_create+0xa8>
ffffffffc020935e:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0209362:	c080                	sw	s0,0(s1)
ffffffffc0209364:	8656                	mv	a2,s5
ffffffffc0209366:	0ff00593          	li	a1,255
ffffffffc020936a:	5ae020ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc020936e:	e488                	sd	a0,8(s1)
ffffffffc0209370:	0996                	slli	s3,s3,0x5
ffffffffc0209372:	053a0263          	beq	s4,s3,ffffffffc02093b6 <bitmap_create+0x94>
ffffffffc0209376:	fff9079b          	addiw	a5,s2,-1
ffffffffc020937a:	0057969b          	slliw	a3,a5,0x5
ffffffffc020937e:	0054561b          	srliw	a2,s0,0x5
ffffffffc0209382:	40d4073b          	subw	a4,s0,a3
ffffffffc0209386:	0054541b          	srliw	s0,s0,0x5
ffffffffc020938a:	08f61463          	bne	a2,a5,ffffffffc0209412 <bitmap_create+0xf0>
ffffffffc020938e:	fff7069b          	addiw	a3,a4,-1
ffffffffc0209392:	47f9                	li	a5,30
ffffffffc0209394:	04d7ef63          	bltu	a5,a3,ffffffffc02093f2 <bitmap_create+0xd0>
ffffffffc0209398:	1402                	slli	s0,s0,0x20
ffffffffc020939a:	8079                	srli	s0,s0,0x1e
ffffffffc020939c:	9522                	add	a0,a0,s0
ffffffffc020939e:	411c                	lw	a5,0(a0)
ffffffffc02093a0:	4585                	li	a1,1
ffffffffc02093a2:	02000613          	li	a2,32
ffffffffc02093a6:	00e596bb          	sllw	a3,a1,a4
ffffffffc02093aa:	8fb5                	xor	a5,a5,a3
ffffffffc02093ac:	2705                	addiw	a4,a4,1
ffffffffc02093ae:	2781                	sext.w	a5,a5
ffffffffc02093b0:	fec71be3          	bne	a4,a2,ffffffffc02093a6 <bitmap_create+0x84>
ffffffffc02093b4:	c11c                	sw	a5,0(a0)
ffffffffc02093b6:	70e2                	ld	ra,56(sp)
ffffffffc02093b8:	7442                	ld	s0,48(sp)
ffffffffc02093ba:	7902                	ld	s2,32(sp)
ffffffffc02093bc:	69e2                	ld	s3,24(sp)
ffffffffc02093be:	6a42                	ld	s4,16(sp)
ffffffffc02093c0:	6aa2                	ld	s5,8(sp)
ffffffffc02093c2:	8526                	mv	a0,s1
ffffffffc02093c4:	74a2                	ld	s1,40(sp)
ffffffffc02093c6:	6121                	addi	sp,sp,64
ffffffffc02093c8:	8082                	ret
ffffffffc02093ca:	8526                	mv	a0,s1
ffffffffc02093cc:	d07f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02093d0:	4481                	li	s1,0
ffffffffc02093d2:	b7d5                	j	ffffffffc02093b6 <bitmap_create+0x94>
ffffffffc02093d4:	00006697          	auipc	a3,0x6
ffffffffc02093d8:	c9468693          	addi	a3,a3,-876 # ffffffffc020f068 <dev_node_ops+0x330>
ffffffffc02093dc:	00003617          	auipc	a2,0x3
ffffffffc02093e0:	a2460613          	addi	a2,a2,-1500 # ffffffffc020be00 <commands+0x210>
ffffffffc02093e4:	45d5                	li	a1,21
ffffffffc02093e6:	00006517          	auipc	a0,0x6
ffffffffc02093ea:	c6a50513          	addi	a0,a0,-918 # ffffffffc020f050 <dev_node_ops+0x318>
ffffffffc02093ee:	8b0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02093f2:	00006697          	auipc	a3,0x6
ffffffffc02093f6:	cb668693          	addi	a3,a3,-842 # ffffffffc020f0a8 <dev_node_ops+0x370>
ffffffffc02093fa:	00003617          	auipc	a2,0x3
ffffffffc02093fe:	a0660613          	addi	a2,a2,-1530 # ffffffffc020be00 <commands+0x210>
ffffffffc0209402:	02b00593          	li	a1,43
ffffffffc0209406:	00006517          	auipc	a0,0x6
ffffffffc020940a:	c4a50513          	addi	a0,a0,-950 # ffffffffc020f050 <dev_node_ops+0x318>
ffffffffc020940e:	890f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209412:	00006697          	auipc	a3,0x6
ffffffffc0209416:	c7e68693          	addi	a3,a3,-898 # ffffffffc020f090 <dev_node_ops+0x358>
ffffffffc020941a:	00003617          	auipc	a2,0x3
ffffffffc020941e:	9e660613          	addi	a2,a2,-1562 # ffffffffc020be00 <commands+0x210>
ffffffffc0209422:	02a00593          	li	a1,42
ffffffffc0209426:	00006517          	auipc	a0,0x6
ffffffffc020942a:	c2a50513          	addi	a0,a0,-982 # ffffffffc020f050 <dev_node_ops+0x318>
ffffffffc020942e:	870f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209432 <bitmap_alloc>:
ffffffffc0209432:	4150                	lw	a2,4(a0)
ffffffffc0209434:	651c                	ld	a5,8(a0)
ffffffffc0209436:	c231                	beqz	a2,ffffffffc020947a <bitmap_alloc+0x48>
ffffffffc0209438:	4701                	li	a4,0
ffffffffc020943a:	a029                	j	ffffffffc0209444 <bitmap_alloc+0x12>
ffffffffc020943c:	2705                	addiw	a4,a4,1
ffffffffc020943e:	0791                	addi	a5,a5,4
ffffffffc0209440:	02e60d63          	beq	a2,a4,ffffffffc020947a <bitmap_alloc+0x48>
ffffffffc0209444:	4394                	lw	a3,0(a5)
ffffffffc0209446:	dafd                	beqz	a3,ffffffffc020943c <bitmap_alloc+0xa>
ffffffffc0209448:	4501                	li	a0,0
ffffffffc020944a:	4885                	li	a7,1
ffffffffc020944c:	8e36                	mv	t3,a3
ffffffffc020944e:	02000313          	li	t1,32
ffffffffc0209452:	a021                	j	ffffffffc020945a <bitmap_alloc+0x28>
ffffffffc0209454:	2505                	addiw	a0,a0,1
ffffffffc0209456:	02650463          	beq	a0,t1,ffffffffc020947e <bitmap_alloc+0x4c>
ffffffffc020945a:	00a8983b          	sllw	a6,a7,a0
ffffffffc020945e:	0106f633          	and	a2,a3,a6
ffffffffc0209462:	2601                	sext.w	a2,a2
ffffffffc0209464:	da65                	beqz	a2,ffffffffc0209454 <bitmap_alloc+0x22>
ffffffffc0209466:	010e4833          	xor	a6,t3,a6
ffffffffc020946a:	0057171b          	slliw	a4,a4,0x5
ffffffffc020946e:	9f29                	addw	a4,a4,a0
ffffffffc0209470:	0107a023          	sw	a6,0(a5)
ffffffffc0209474:	c198                	sw	a4,0(a1)
ffffffffc0209476:	4501                	li	a0,0
ffffffffc0209478:	8082                	ret
ffffffffc020947a:	5571                	li	a0,-4
ffffffffc020947c:	8082                	ret
ffffffffc020947e:	1141                	addi	sp,sp,-16
ffffffffc0209480:	00004697          	auipc	a3,0x4
ffffffffc0209484:	a3868693          	addi	a3,a3,-1480 # ffffffffc020ceb8 <default_pmm_manager+0x598>
ffffffffc0209488:	00003617          	auipc	a2,0x3
ffffffffc020948c:	97860613          	addi	a2,a2,-1672 # ffffffffc020be00 <commands+0x210>
ffffffffc0209490:	04300593          	li	a1,67
ffffffffc0209494:	00006517          	auipc	a0,0x6
ffffffffc0209498:	bbc50513          	addi	a0,a0,-1092 # ffffffffc020f050 <dev_node_ops+0x318>
ffffffffc020949c:	e406                	sd	ra,8(sp)
ffffffffc020949e:	800f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02094a2 <bitmap_test>:
ffffffffc02094a2:	411c                	lw	a5,0(a0)
ffffffffc02094a4:	00f5ff63          	bgeu	a1,a5,ffffffffc02094c2 <bitmap_test+0x20>
ffffffffc02094a8:	651c                	ld	a5,8(a0)
ffffffffc02094aa:	0055d71b          	srliw	a4,a1,0x5
ffffffffc02094ae:	070a                	slli	a4,a4,0x2
ffffffffc02094b0:	97ba                	add	a5,a5,a4
ffffffffc02094b2:	4388                	lw	a0,0(a5)
ffffffffc02094b4:	4785                	li	a5,1
ffffffffc02094b6:	00b795bb          	sllw	a1,a5,a1
ffffffffc02094ba:	8d6d                	and	a0,a0,a1
ffffffffc02094bc:	1502                	slli	a0,a0,0x20
ffffffffc02094be:	9101                	srli	a0,a0,0x20
ffffffffc02094c0:	8082                	ret
ffffffffc02094c2:	1141                	addi	sp,sp,-16
ffffffffc02094c4:	e406                	sd	ra,8(sp)
ffffffffc02094c6:	e39ff0ef          	jal	ra,ffffffffc02092fe <bitmap_translate.part.0>

ffffffffc02094ca <bitmap_free>:
ffffffffc02094ca:	411c                	lw	a5,0(a0)
ffffffffc02094cc:	1141                	addi	sp,sp,-16
ffffffffc02094ce:	e406                	sd	ra,8(sp)
ffffffffc02094d0:	02f5f463          	bgeu	a1,a5,ffffffffc02094f8 <bitmap_free+0x2e>
ffffffffc02094d4:	651c                	ld	a5,8(a0)
ffffffffc02094d6:	0055d71b          	srliw	a4,a1,0x5
ffffffffc02094da:	070a                	slli	a4,a4,0x2
ffffffffc02094dc:	97ba                	add	a5,a5,a4
ffffffffc02094de:	4398                	lw	a4,0(a5)
ffffffffc02094e0:	4685                	li	a3,1
ffffffffc02094e2:	00b695bb          	sllw	a1,a3,a1
ffffffffc02094e6:	00b776b3          	and	a3,a4,a1
ffffffffc02094ea:	2681                	sext.w	a3,a3
ffffffffc02094ec:	ea81                	bnez	a3,ffffffffc02094fc <bitmap_free+0x32>
ffffffffc02094ee:	60a2                	ld	ra,8(sp)
ffffffffc02094f0:	8f4d                	or	a4,a4,a1
ffffffffc02094f2:	c398                	sw	a4,0(a5)
ffffffffc02094f4:	0141                	addi	sp,sp,16
ffffffffc02094f6:	8082                	ret
ffffffffc02094f8:	e07ff0ef          	jal	ra,ffffffffc02092fe <bitmap_translate.part.0>
ffffffffc02094fc:	00006697          	auipc	a3,0x6
ffffffffc0209500:	bd468693          	addi	a3,a3,-1068 # ffffffffc020f0d0 <dev_node_ops+0x398>
ffffffffc0209504:	00003617          	auipc	a2,0x3
ffffffffc0209508:	8fc60613          	addi	a2,a2,-1796 # ffffffffc020be00 <commands+0x210>
ffffffffc020950c:	05f00593          	li	a1,95
ffffffffc0209510:	00006517          	auipc	a0,0x6
ffffffffc0209514:	b4050513          	addi	a0,a0,-1216 # ffffffffc020f050 <dev_node_ops+0x318>
ffffffffc0209518:	f87f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020951c <bitmap_destroy>:
ffffffffc020951c:	1141                	addi	sp,sp,-16
ffffffffc020951e:	e022                	sd	s0,0(sp)
ffffffffc0209520:	842a                	mv	s0,a0
ffffffffc0209522:	6508                	ld	a0,8(a0)
ffffffffc0209524:	e406                	sd	ra,8(sp)
ffffffffc0209526:	badf80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020952a:	8522                	mv	a0,s0
ffffffffc020952c:	6402                	ld	s0,0(sp)
ffffffffc020952e:	60a2                	ld	ra,8(sp)
ffffffffc0209530:	0141                	addi	sp,sp,16
ffffffffc0209532:	ba1f806f          	j	ffffffffc02020d2 <kfree>

ffffffffc0209536 <bitmap_getdata>:
ffffffffc0209536:	c589                	beqz	a1,ffffffffc0209540 <bitmap_getdata+0xa>
ffffffffc0209538:	00456783          	lwu	a5,4(a0)
ffffffffc020953c:	078a                	slli	a5,a5,0x2
ffffffffc020953e:	e19c                	sd	a5,0(a1)
ffffffffc0209540:	6508                	ld	a0,8(a0)
ffffffffc0209542:	8082                	ret

ffffffffc0209544 <sfs_init>:
ffffffffc0209544:	1141                	addi	sp,sp,-16
ffffffffc0209546:	00006517          	auipc	a0,0x6
ffffffffc020954a:	9fa50513          	addi	a0,a0,-1542 # ffffffffc020ef40 <dev_node_ops+0x208>
ffffffffc020954e:	e406                	sd	ra,8(sp)
ffffffffc0209550:	554000ef          	jal	ra,ffffffffc0209aa4 <sfs_mount>
ffffffffc0209554:	e501                	bnez	a0,ffffffffc020955c <sfs_init+0x18>
ffffffffc0209556:	60a2                	ld	ra,8(sp)
ffffffffc0209558:	0141                	addi	sp,sp,16
ffffffffc020955a:	8082                	ret
ffffffffc020955c:	86aa                	mv	a3,a0
ffffffffc020955e:	00006617          	auipc	a2,0x6
ffffffffc0209562:	b8260613          	addi	a2,a2,-1150 # ffffffffc020f0e0 <dev_node_ops+0x3a8>
ffffffffc0209566:	45c1                	li	a1,16
ffffffffc0209568:	00006517          	auipc	a0,0x6
ffffffffc020956c:	b9850513          	addi	a0,a0,-1128 # ffffffffc020f100 <dev_node_ops+0x3c8>
ffffffffc0209570:	f2ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209574 <sfs_unmount>:
ffffffffc0209574:	1141                	addi	sp,sp,-16
ffffffffc0209576:	e406                	sd	ra,8(sp)
ffffffffc0209578:	e022                	sd	s0,0(sp)
ffffffffc020957a:	cd1d                	beqz	a0,ffffffffc02095b8 <sfs_unmount+0x44>
ffffffffc020957c:	0b052783          	lw	a5,176(a0)
ffffffffc0209580:	842a                	mv	s0,a0
ffffffffc0209582:	eb9d                	bnez	a5,ffffffffc02095b8 <sfs_unmount+0x44>
ffffffffc0209584:	7158                	ld	a4,160(a0)
ffffffffc0209586:	09850793          	addi	a5,a0,152
ffffffffc020958a:	02f71563          	bne	a4,a5,ffffffffc02095b4 <sfs_unmount+0x40>
ffffffffc020958e:	613c                	ld	a5,64(a0)
ffffffffc0209590:	e7a1                	bnez	a5,ffffffffc02095d8 <sfs_unmount+0x64>
ffffffffc0209592:	7d08                	ld	a0,56(a0)
ffffffffc0209594:	f89ff0ef          	jal	ra,ffffffffc020951c <bitmap_destroy>
ffffffffc0209598:	6428                	ld	a0,72(s0)
ffffffffc020959a:	b39f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020959e:	7448                	ld	a0,168(s0)
ffffffffc02095a0:	b33f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02095a4:	8522                	mv	a0,s0
ffffffffc02095a6:	b2df80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02095aa:	4501                	li	a0,0
ffffffffc02095ac:	60a2                	ld	ra,8(sp)
ffffffffc02095ae:	6402                	ld	s0,0(sp)
ffffffffc02095b0:	0141                	addi	sp,sp,16
ffffffffc02095b2:	8082                	ret
ffffffffc02095b4:	5545                	li	a0,-15
ffffffffc02095b6:	bfdd                	j	ffffffffc02095ac <sfs_unmount+0x38>
ffffffffc02095b8:	00006697          	auipc	a3,0x6
ffffffffc02095bc:	b6068693          	addi	a3,a3,-1184 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc02095c0:	00003617          	auipc	a2,0x3
ffffffffc02095c4:	84060613          	addi	a2,a2,-1984 # ffffffffc020be00 <commands+0x210>
ffffffffc02095c8:	04100593          	li	a1,65
ffffffffc02095cc:	00006517          	auipc	a0,0x6
ffffffffc02095d0:	b7c50513          	addi	a0,a0,-1156 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc02095d4:	ecbf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02095d8:	00006697          	auipc	a3,0x6
ffffffffc02095dc:	b8868693          	addi	a3,a3,-1144 # ffffffffc020f160 <dev_node_ops+0x428>
ffffffffc02095e0:	00003617          	auipc	a2,0x3
ffffffffc02095e4:	82060613          	addi	a2,a2,-2016 # ffffffffc020be00 <commands+0x210>
ffffffffc02095e8:	04500593          	li	a1,69
ffffffffc02095ec:	00006517          	auipc	a0,0x6
ffffffffc02095f0:	b5c50513          	addi	a0,a0,-1188 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc02095f4:	eabf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02095f8 <sfs_cleanup>:
ffffffffc02095f8:	1101                	addi	sp,sp,-32
ffffffffc02095fa:	ec06                	sd	ra,24(sp)
ffffffffc02095fc:	e822                	sd	s0,16(sp)
ffffffffc02095fe:	e426                	sd	s1,8(sp)
ffffffffc0209600:	e04a                	sd	s2,0(sp)
ffffffffc0209602:	c525                	beqz	a0,ffffffffc020966a <sfs_cleanup+0x72>
ffffffffc0209604:	0b052783          	lw	a5,176(a0)
ffffffffc0209608:	84aa                	mv	s1,a0
ffffffffc020960a:	e3a5                	bnez	a5,ffffffffc020966a <sfs_cleanup+0x72>
ffffffffc020960c:	4158                	lw	a4,4(a0)
ffffffffc020960e:	4514                	lw	a3,8(a0)
ffffffffc0209610:	00c50913          	addi	s2,a0,12
ffffffffc0209614:	85ca                	mv	a1,s2
ffffffffc0209616:	40d7063b          	subw	a2,a4,a3
ffffffffc020961a:	00006517          	auipc	a0,0x6
ffffffffc020961e:	b5e50513          	addi	a0,a0,-1186 # ffffffffc020f178 <dev_node_ops+0x440>
ffffffffc0209622:	b85f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209626:	02000413          	li	s0,32
ffffffffc020962a:	a019                	j	ffffffffc0209630 <sfs_cleanup+0x38>
ffffffffc020962c:	347d                	addiw	s0,s0,-1
ffffffffc020962e:	c819                	beqz	s0,ffffffffc0209644 <sfs_cleanup+0x4c>
ffffffffc0209630:	7cdc                	ld	a5,184(s1)
ffffffffc0209632:	8526                	mv	a0,s1
ffffffffc0209634:	9782                	jalr	a5
ffffffffc0209636:	f97d                	bnez	a0,ffffffffc020962c <sfs_cleanup+0x34>
ffffffffc0209638:	60e2                	ld	ra,24(sp)
ffffffffc020963a:	6442                	ld	s0,16(sp)
ffffffffc020963c:	64a2                	ld	s1,8(sp)
ffffffffc020963e:	6902                	ld	s2,0(sp)
ffffffffc0209640:	6105                	addi	sp,sp,32
ffffffffc0209642:	8082                	ret
ffffffffc0209644:	6442                	ld	s0,16(sp)
ffffffffc0209646:	60e2                	ld	ra,24(sp)
ffffffffc0209648:	64a2                	ld	s1,8(sp)
ffffffffc020964a:	86ca                	mv	a3,s2
ffffffffc020964c:	6902                	ld	s2,0(sp)
ffffffffc020964e:	872a                	mv	a4,a0
ffffffffc0209650:	00006617          	auipc	a2,0x6
ffffffffc0209654:	b4860613          	addi	a2,a2,-1208 # ffffffffc020f198 <dev_node_ops+0x460>
ffffffffc0209658:	05f00593          	li	a1,95
ffffffffc020965c:	00006517          	auipc	a0,0x6
ffffffffc0209660:	aec50513          	addi	a0,a0,-1300 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc0209664:	6105                	addi	sp,sp,32
ffffffffc0209666:	ea1f606f          	j	ffffffffc0200506 <__warn>
ffffffffc020966a:	00006697          	auipc	a3,0x6
ffffffffc020966e:	aae68693          	addi	a3,a3,-1362 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc0209672:	00002617          	auipc	a2,0x2
ffffffffc0209676:	78e60613          	addi	a2,a2,1934 # ffffffffc020be00 <commands+0x210>
ffffffffc020967a:	05400593          	li	a1,84
ffffffffc020967e:	00006517          	auipc	a0,0x6
ffffffffc0209682:	aca50513          	addi	a0,a0,-1334 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc0209686:	e19f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020968a <sfs_sync>:
ffffffffc020968a:	7179                	addi	sp,sp,-48
ffffffffc020968c:	f406                	sd	ra,40(sp)
ffffffffc020968e:	f022                	sd	s0,32(sp)
ffffffffc0209690:	ec26                	sd	s1,24(sp)
ffffffffc0209692:	e84a                	sd	s2,16(sp)
ffffffffc0209694:	e44e                	sd	s3,8(sp)
ffffffffc0209696:	e052                	sd	s4,0(sp)
ffffffffc0209698:	cd4d                	beqz	a0,ffffffffc0209752 <sfs_sync+0xc8>
ffffffffc020969a:	0b052783          	lw	a5,176(a0)
ffffffffc020969e:	8a2a                	mv	s4,a0
ffffffffc02096a0:	ebcd                	bnez	a5,ffffffffc0209752 <sfs_sync+0xc8>
ffffffffc02096a2:	523010ef          	jal	ra,ffffffffc020b3c4 <lock_sfs_fs>
ffffffffc02096a6:	0a0a3403          	ld	s0,160(s4)
ffffffffc02096aa:	098a0913          	addi	s2,s4,152
ffffffffc02096ae:	02890763          	beq	s2,s0,ffffffffc02096dc <sfs_sync+0x52>
ffffffffc02096b2:	00004997          	auipc	s3,0x4
ffffffffc02096b6:	10e98993          	addi	s3,s3,270 # ffffffffc020d7c0 <default_pmm_manager+0xea0>
ffffffffc02096ba:	7c1c                	ld	a5,56(s0)
ffffffffc02096bc:	fc840493          	addi	s1,s0,-56
ffffffffc02096c0:	cbb5                	beqz	a5,ffffffffc0209734 <sfs_sync+0xaa>
ffffffffc02096c2:	7b9c                	ld	a5,48(a5)
ffffffffc02096c4:	cba5                	beqz	a5,ffffffffc0209734 <sfs_sync+0xaa>
ffffffffc02096c6:	85ce                	mv	a1,s3
ffffffffc02096c8:	8526                	mv	a0,s1
ffffffffc02096ca:	e28fe0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc02096ce:	7c1c                	ld	a5,56(s0)
ffffffffc02096d0:	8526                	mv	a0,s1
ffffffffc02096d2:	7b9c                	ld	a5,48(a5)
ffffffffc02096d4:	9782                	jalr	a5
ffffffffc02096d6:	6400                	ld	s0,8(s0)
ffffffffc02096d8:	fe8911e3          	bne	s2,s0,ffffffffc02096ba <sfs_sync+0x30>
ffffffffc02096dc:	8552                	mv	a0,s4
ffffffffc02096de:	4f7010ef          	jal	ra,ffffffffc020b3d4 <unlock_sfs_fs>
ffffffffc02096e2:	040a3783          	ld	a5,64(s4)
ffffffffc02096e6:	4501                	li	a0,0
ffffffffc02096e8:	eb89                	bnez	a5,ffffffffc02096fa <sfs_sync+0x70>
ffffffffc02096ea:	70a2                	ld	ra,40(sp)
ffffffffc02096ec:	7402                	ld	s0,32(sp)
ffffffffc02096ee:	64e2                	ld	s1,24(sp)
ffffffffc02096f0:	6942                	ld	s2,16(sp)
ffffffffc02096f2:	69a2                	ld	s3,8(sp)
ffffffffc02096f4:	6a02                	ld	s4,0(sp)
ffffffffc02096f6:	6145                	addi	sp,sp,48
ffffffffc02096f8:	8082                	ret
ffffffffc02096fa:	040a3023          	sd	zero,64(s4)
ffffffffc02096fe:	8552                	mv	a0,s4
ffffffffc0209700:	3a9010ef          	jal	ra,ffffffffc020b2a8 <sfs_sync_super>
ffffffffc0209704:	cd01                	beqz	a0,ffffffffc020971c <sfs_sync+0x92>
ffffffffc0209706:	70a2                	ld	ra,40(sp)
ffffffffc0209708:	7402                	ld	s0,32(sp)
ffffffffc020970a:	4785                	li	a5,1
ffffffffc020970c:	04fa3023          	sd	a5,64(s4)
ffffffffc0209710:	64e2                	ld	s1,24(sp)
ffffffffc0209712:	6942                	ld	s2,16(sp)
ffffffffc0209714:	69a2                	ld	s3,8(sp)
ffffffffc0209716:	6a02                	ld	s4,0(sp)
ffffffffc0209718:	6145                	addi	sp,sp,48
ffffffffc020971a:	8082                	ret
ffffffffc020971c:	8552                	mv	a0,s4
ffffffffc020971e:	3d1010ef          	jal	ra,ffffffffc020b2ee <sfs_sync_freemap>
ffffffffc0209722:	f175                	bnez	a0,ffffffffc0209706 <sfs_sync+0x7c>
ffffffffc0209724:	70a2                	ld	ra,40(sp)
ffffffffc0209726:	7402                	ld	s0,32(sp)
ffffffffc0209728:	64e2                	ld	s1,24(sp)
ffffffffc020972a:	6942                	ld	s2,16(sp)
ffffffffc020972c:	69a2                	ld	s3,8(sp)
ffffffffc020972e:	6a02                	ld	s4,0(sp)
ffffffffc0209730:	6145                	addi	sp,sp,48
ffffffffc0209732:	8082                	ret
ffffffffc0209734:	00004697          	auipc	a3,0x4
ffffffffc0209738:	03c68693          	addi	a3,a3,60 # ffffffffc020d770 <default_pmm_manager+0xe50>
ffffffffc020973c:	00002617          	auipc	a2,0x2
ffffffffc0209740:	6c460613          	addi	a2,a2,1732 # ffffffffc020be00 <commands+0x210>
ffffffffc0209744:	45ed                	li	a1,27
ffffffffc0209746:	00006517          	auipc	a0,0x6
ffffffffc020974a:	a0250513          	addi	a0,a0,-1534 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc020974e:	d51f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209752:	00006697          	auipc	a3,0x6
ffffffffc0209756:	9c668693          	addi	a3,a3,-1594 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc020975a:	00002617          	auipc	a2,0x2
ffffffffc020975e:	6a660613          	addi	a2,a2,1702 # ffffffffc020be00 <commands+0x210>
ffffffffc0209762:	45d5                	li	a1,21
ffffffffc0209764:	00006517          	auipc	a0,0x6
ffffffffc0209768:	9e450513          	addi	a0,a0,-1564 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc020976c:	d33f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209770 <sfs_get_root>:
ffffffffc0209770:	1101                	addi	sp,sp,-32
ffffffffc0209772:	ec06                	sd	ra,24(sp)
ffffffffc0209774:	cd09                	beqz	a0,ffffffffc020978e <sfs_get_root+0x1e>
ffffffffc0209776:	0b052783          	lw	a5,176(a0)
ffffffffc020977a:	eb91                	bnez	a5,ffffffffc020978e <sfs_get_root+0x1e>
ffffffffc020977c:	4605                	li	a2,1
ffffffffc020977e:	002c                	addi	a1,sp,8
ffffffffc0209780:	35a010ef          	jal	ra,ffffffffc020aada <sfs_load_inode>
ffffffffc0209784:	e50d                	bnez	a0,ffffffffc02097ae <sfs_get_root+0x3e>
ffffffffc0209786:	60e2                	ld	ra,24(sp)
ffffffffc0209788:	6522                	ld	a0,8(sp)
ffffffffc020978a:	6105                	addi	sp,sp,32
ffffffffc020978c:	8082                	ret
ffffffffc020978e:	00006697          	auipc	a3,0x6
ffffffffc0209792:	98a68693          	addi	a3,a3,-1654 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc0209796:	00002617          	auipc	a2,0x2
ffffffffc020979a:	66a60613          	addi	a2,a2,1642 # ffffffffc020be00 <commands+0x210>
ffffffffc020979e:	03600593          	li	a1,54
ffffffffc02097a2:	00006517          	auipc	a0,0x6
ffffffffc02097a6:	9a650513          	addi	a0,a0,-1626 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc02097aa:	cf5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097ae:	86aa                	mv	a3,a0
ffffffffc02097b0:	00006617          	auipc	a2,0x6
ffffffffc02097b4:	a0860613          	addi	a2,a2,-1528 # ffffffffc020f1b8 <dev_node_ops+0x480>
ffffffffc02097b8:	03700593          	li	a1,55
ffffffffc02097bc:	00006517          	auipc	a0,0x6
ffffffffc02097c0:	98c50513          	addi	a0,a0,-1652 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc02097c4:	cdbf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02097c8 <sfs_do_mount>:
ffffffffc02097c8:	6518                	ld	a4,8(a0)
ffffffffc02097ca:	7171                	addi	sp,sp,-176
ffffffffc02097cc:	f506                	sd	ra,168(sp)
ffffffffc02097ce:	f122                	sd	s0,160(sp)
ffffffffc02097d0:	ed26                	sd	s1,152(sp)
ffffffffc02097d2:	e94a                	sd	s2,144(sp)
ffffffffc02097d4:	e54e                	sd	s3,136(sp)
ffffffffc02097d6:	e152                	sd	s4,128(sp)
ffffffffc02097d8:	fcd6                	sd	s5,120(sp)
ffffffffc02097da:	f8da                	sd	s6,112(sp)
ffffffffc02097dc:	f4de                	sd	s7,104(sp)
ffffffffc02097de:	f0e2                	sd	s8,96(sp)
ffffffffc02097e0:	ece6                	sd	s9,88(sp)
ffffffffc02097e2:	e8ea                	sd	s10,80(sp)
ffffffffc02097e4:	e4ee                	sd	s11,72(sp)
ffffffffc02097e6:	6785                	lui	a5,0x1
ffffffffc02097e8:	24f71663          	bne	a4,a5,ffffffffc0209a34 <sfs_do_mount+0x26c>
ffffffffc02097ec:	892a                	mv	s2,a0
ffffffffc02097ee:	4501                	li	a0,0
ffffffffc02097f0:	8aae                	mv	s5,a1
ffffffffc02097f2:	f00fe0ef          	jal	ra,ffffffffc0207ef2 <__alloc_fs>
ffffffffc02097f6:	842a                	mv	s0,a0
ffffffffc02097f8:	24050463          	beqz	a0,ffffffffc0209a40 <sfs_do_mount+0x278>
ffffffffc02097fc:	0b052b03          	lw	s6,176(a0)
ffffffffc0209800:	260b1263          	bnez	s6,ffffffffc0209a64 <sfs_do_mount+0x29c>
ffffffffc0209804:	03253823          	sd	s2,48(a0)
ffffffffc0209808:	6505                	lui	a0,0x1
ffffffffc020980a:	819f80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020980e:	e428                	sd	a0,72(s0)
ffffffffc0209810:	84aa                	mv	s1,a0
ffffffffc0209812:	16050363          	beqz	a0,ffffffffc0209978 <sfs_do_mount+0x1b0>
ffffffffc0209816:	85aa                	mv	a1,a0
ffffffffc0209818:	4681                	li	a3,0
ffffffffc020981a:	6605                	lui	a2,0x1
ffffffffc020981c:	1008                	addi	a0,sp,32
ffffffffc020981e:	c5dfb0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0209822:	02093783          	ld	a5,32(s2)
ffffffffc0209826:	85aa                	mv	a1,a0
ffffffffc0209828:	4601                	li	a2,0
ffffffffc020982a:	854a                	mv	a0,s2
ffffffffc020982c:	9782                	jalr	a5
ffffffffc020982e:	8a2a                	mv	s4,a0
ffffffffc0209830:	10051e63          	bnez	a0,ffffffffc020994c <sfs_do_mount+0x184>
ffffffffc0209834:	408c                	lw	a1,0(s1)
ffffffffc0209836:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc020983a:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc020983e:	14c59863          	bne	a1,a2,ffffffffc020998e <sfs_do_mount+0x1c6>
ffffffffc0209842:	40dc                	lw	a5,4(s1)
ffffffffc0209844:	00093603          	ld	a2,0(s2)
ffffffffc0209848:	02079713          	slli	a4,a5,0x20
ffffffffc020984c:	9301                	srli	a4,a4,0x20
ffffffffc020984e:	12e66763          	bltu	a2,a4,ffffffffc020997c <sfs_do_mount+0x1b4>
ffffffffc0209852:	020485a3          	sb	zero,43(s1)
ffffffffc0209856:	0084af03          	lw	t5,8(s1)
ffffffffc020985a:	00c4ae83          	lw	t4,12(s1)
ffffffffc020985e:	0104ae03          	lw	t3,16(s1)
ffffffffc0209862:	0144a303          	lw	t1,20(s1)
ffffffffc0209866:	0184a883          	lw	a7,24(s1)
ffffffffc020986a:	01c4a803          	lw	a6,28(s1)
ffffffffc020986e:	5090                	lw	a2,32(s1)
ffffffffc0209870:	50d4                	lw	a3,36(s1)
ffffffffc0209872:	5498                	lw	a4,40(s1)
ffffffffc0209874:	6511                	lui	a0,0x4
ffffffffc0209876:	c00c                	sw	a1,0(s0)
ffffffffc0209878:	c05c                	sw	a5,4(s0)
ffffffffc020987a:	01e42423          	sw	t5,8(s0)
ffffffffc020987e:	01d42623          	sw	t4,12(s0)
ffffffffc0209882:	01c42823          	sw	t3,16(s0)
ffffffffc0209886:	00642a23          	sw	t1,20(s0)
ffffffffc020988a:	01142c23          	sw	a7,24(s0)
ffffffffc020988e:	01042e23          	sw	a6,28(s0)
ffffffffc0209892:	d010                	sw	a2,32(s0)
ffffffffc0209894:	d054                	sw	a3,36(s0)
ffffffffc0209896:	d418                	sw	a4,40(s0)
ffffffffc0209898:	f8af80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020989c:	f448                	sd	a0,168(s0)
ffffffffc020989e:	8c2a                	mv	s8,a0
ffffffffc02098a0:	18050c63          	beqz	a0,ffffffffc0209a38 <sfs_do_mount+0x270>
ffffffffc02098a4:	6711                	lui	a4,0x4
ffffffffc02098a6:	87aa                	mv	a5,a0
ffffffffc02098a8:	972a                	add	a4,a4,a0
ffffffffc02098aa:	e79c                	sd	a5,8(a5)
ffffffffc02098ac:	e39c                	sd	a5,0(a5)
ffffffffc02098ae:	07c1                	addi	a5,a5,16
ffffffffc02098b0:	fee79de3          	bne	a5,a4,ffffffffc02098aa <sfs_do_mount+0xe2>
ffffffffc02098b4:	0044eb83          	lwu	s7,4(s1)
ffffffffc02098b8:	67a1                	lui	a5,0x8
ffffffffc02098ba:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc02098be:	9bce                	add	s7,s7,s3
ffffffffc02098c0:	77e1                	lui	a5,0xffff8
ffffffffc02098c2:	00fbfbb3          	and	s7,s7,a5
ffffffffc02098c6:	2b81                	sext.w	s7,s7
ffffffffc02098c8:	855e                	mv	a0,s7
ffffffffc02098ca:	a59ff0ef          	jal	ra,ffffffffc0209322 <bitmap_create>
ffffffffc02098ce:	fc08                	sd	a0,56(s0)
ffffffffc02098d0:	8d2a                	mv	s10,a0
ffffffffc02098d2:	14050f63          	beqz	a0,ffffffffc0209a30 <sfs_do_mount+0x268>
ffffffffc02098d6:	0044e783          	lwu	a5,4(s1)
ffffffffc02098da:	082c                	addi	a1,sp,24
ffffffffc02098dc:	97ce                	add	a5,a5,s3
ffffffffc02098de:	00f7d713          	srli	a4,a5,0xf
ffffffffc02098e2:	e43a                	sd	a4,8(sp)
ffffffffc02098e4:	40f7d993          	srai	s3,a5,0xf
ffffffffc02098e8:	c4fff0ef          	jal	ra,ffffffffc0209536 <bitmap_getdata>
ffffffffc02098ec:	14050c63          	beqz	a0,ffffffffc0209a44 <sfs_do_mount+0x27c>
ffffffffc02098f0:	00c9979b          	slliw	a5,s3,0xc
ffffffffc02098f4:	66e2                	ld	a3,24(sp)
ffffffffc02098f6:	1782                	slli	a5,a5,0x20
ffffffffc02098f8:	9381                	srli	a5,a5,0x20
ffffffffc02098fa:	14d79563          	bne	a5,a3,ffffffffc0209a44 <sfs_do_mount+0x27c>
ffffffffc02098fe:	6722                	ld	a4,8(sp)
ffffffffc0209900:	6d89                	lui	s11,0x2
ffffffffc0209902:	89aa                	mv	s3,a0
ffffffffc0209904:	00c71c93          	slli	s9,a4,0xc
ffffffffc0209908:	9caa                	add	s9,s9,a0
ffffffffc020990a:	40ad8dbb          	subw	s11,s11,a0
ffffffffc020990e:	e711                	bnez	a4,ffffffffc020991a <sfs_do_mount+0x152>
ffffffffc0209910:	a079                	j	ffffffffc020999e <sfs_do_mount+0x1d6>
ffffffffc0209912:	6785                	lui	a5,0x1
ffffffffc0209914:	99be                	add	s3,s3,a5
ffffffffc0209916:	093c8463          	beq	s9,s3,ffffffffc020999e <sfs_do_mount+0x1d6>
ffffffffc020991a:	013d86bb          	addw	a3,s11,s3
ffffffffc020991e:	1682                	slli	a3,a3,0x20
ffffffffc0209920:	6605                	lui	a2,0x1
ffffffffc0209922:	85ce                	mv	a1,s3
ffffffffc0209924:	9281                	srli	a3,a3,0x20
ffffffffc0209926:	1008                	addi	a0,sp,32
ffffffffc0209928:	b53fb0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc020992c:	02093783          	ld	a5,32(s2)
ffffffffc0209930:	85aa                	mv	a1,a0
ffffffffc0209932:	4601                	li	a2,0
ffffffffc0209934:	854a                	mv	a0,s2
ffffffffc0209936:	9782                	jalr	a5
ffffffffc0209938:	dd69                	beqz	a0,ffffffffc0209912 <sfs_do_mount+0x14a>
ffffffffc020993a:	e42a                	sd	a0,8(sp)
ffffffffc020993c:	856a                	mv	a0,s10
ffffffffc020993e:	bdfff0ef          	jal	ra,ffffffffc020951c <bitmap_destroy>
ffffffffc0209942:	67a2                	ld	a5,8(sp)
ffffffffc0209944:	8a3e                	mv	s4,a5
ffffffffc0209946:	8562                	mv	a0,s8
ffffffffc0209948:	f8af80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020994c:	8526                	mv	a0,s1
ffffffffc020994e:	f84f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209952:	8522                	mv	a0,s0
ffffffffc0209954:	f7ef80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209958:	70aa                	ld	ra,168(sp)
ffffffffc020995a:	740a                	ld	s0,160(sp)
ffffffffc020995c:	64ea                	ld	s1,152(sp)
ffffffffc020995e:	694a                	ld	s2,144(sp)
ffffffffc0209960:	69aa                	ld	s3,136(sp)
ffffffffc0209962:	7ae6                	ld	s5,120(sp)
ffffffffc0209964:	7b46                	ld	s6,112(sp)
ffffffffc0209966:	7ba6                	ld	s7,104(sp)
ffffffffc0209968:	7c06                	ld	s8,96(sp)
ffffffffc020996a:	6ce6                	ld	s9,88(sp)
ffffffffc020996c:	6d46                	ld	s10,80(sp)
ffffffffc020996e:	6da6                	ld	s11,72(sp)
ffffffffc0209970:	8552                	mv	a0,s4
ffffffffc0209972:	6a0a                	ld	s4,128(sp)
ffffffffc0209974:	614d                	addi	sp,sp,176
ffffffffc0209976:	8082                	ret
ffffffffc0209978:	5a71                	li	s4,-4
ffffffffc020997a:	bfe1                	j	ffffffffc0209952 <sfs_do_mount+0x18a>
ffffffffc020997c:	85be                	mv	a1,a5
ffffffffc020997e:	00006517          	auipc	a0,0x6
ffffffffc0209982:	89250513          	addi	a0,a0,-1902 # ffffffffc020f210 <dev_node_ops+0x4d8>
ffffffffc0209986:	821f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020998a:	5a75                	li	s4,-3
ffffffffc020998c:	b7c1                	j	ffffffffc020994c <sfs_do_mount+0x184>
ffffffffc020998e:	00006517          	auipc	a0,0x6
ffffffffc0209992:	84a50513          	addi	a0,a0,-1974 # ffffffffc020f1d8 <dev_node_ops+0x4a0>
ffffffffc0209996:	811f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020999a:	5a75                	li	s4,-3
ffffffffc020999c:	bf45                	j	ffffffffc020994c <sfs_do_mount+0x184>
ffffffffc020999e:	00442903          	lw	s2,4(s0)
ffffffffc02099a2:	4481                	li	s1,0
ffffffffc02099a4:	080b8c63          	beqz	s7,ffffffffc0209a3c <sfs_do_mount+0x274>
ffffffffc02099a8:	85a6                	mv	a1,s1
ffffffffc02099aa:	856a                	mv	a0,s10
ffffffffc02099ac:	af7ff0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc02099b0:	c111                	beqz	a0,ffffffffc02099b4 <sfs_do_mount+0x1ec>
ffffffffc02099b2:	2b05                	addiw	s6,s6,1
ffffffffc02099b4:	2485                	addiw	s1,s1,1
ffffffffc02099b6:	fe9b99e3          	bne	s7,s1,ffffffffc02099a8 <sfs_do_mount+0x1e0>
ffffffffc02099ba:	441c                	lw	a5,8(s0)
ffffffffc02099bc:	0d679463          	bne	a5,s6,ffffffffc0209a84 <sfs_do_mount+0x2bc>
ffffffffc02099c0:	4585                	li	a1,1
ffffffffc02099c2:	05040513          	addi	a0,s0,80
ffffffffc02099c6:	04043023          	sd	zero,64(s0)
ffffffffc02099ca:	c29fa0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc02099ce:	4585                	li	a1,1
ffffffffc02099d0:	06840513          	addi	a0,s0,104
ffffffffc02099d4:	c1ffa0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc02099d8:	4585                	li	a1,1
ffffffffc02099da:	08040513          	addi	a0,s0,128
ffffffffc02099de:	c15fa0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc02099e2:	09840793          	addi	a5,s0,152
ffffffffc02099e6:	f05c                	sd	a5,160(s0)
ffffffffc02099e8:	ec5c                	sd	a5,152(s0)
ffffffffc02099ea:	874a                	mv	a4,s2
ffffffffc02099ec:	86da                	mv	a3,s6
ffffffffc02099ee:	4169063b          	subw	a2,s2,s6
ffffffffc02099f2:	00c40593          	addi	a1,s0,12
ffffffffc02099f6:	00006517          	auipc	a0,0x6
ffffffffc02099fa:	8aa50513          	addi	a0,a0,-1878 # ffffffffc020f2a0 <dev_node_ops+0x568>
ffffffffc02099fe:	fa8f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209a02:	00000797          	auipc	a5,0x0
ffffffffc0209a06:	c8878793          	addi	a5,a5,-888 # ffffffffc020968a <sfs_sync>
ffffffffc0209a0a:	fc5c                	sd	a5,184(s0)
ffffffffc0209a0c:	00000797          	auipc	a5,0x0
ffffffffc0209a10:	d6478793          	addi	a5,a5,-668 # ffffffffc0209770 <sfs_get_root>
ffffffffc0209a14:	e07c                	sd	a5,192(s0)
ffffffffc0209a16:	00000797          	auipc	a5,0x0
ffffffffc0209a1a:	b5e78793          	addi	a5,a5,-1186 # ffffffffc0209574 <sfs_unmount>
ffffffffc0209a1e:	e47c                	sd	a5,200(s0)
ffffffffc0209a20:	00000797          	auipc	a5,0x0
ffffffffc0209a24:	bd878793          	addi	a5,a5,-1064 # ffffffffc02095f8 <sfs_cleanup>
ffffffffc0209a28:	e87c                	sd	a5,208(s0)
ffffffffc0209a2a:	008ab023          	sd	s0,0(s5)
ffffffffc0209a2e:	b72d                	j	ffffffffc0209958 <sfs_do_mount+0x190>
ffffffffc0209a30:	5a71                	li	s4,-4
ffffffffc0209a32:	bf11                	j	ffffffffc0209946 <sfs_do_mount+0x17e>
ffffffffc0209a34:	5a49                	li	s4,-14
ffffffffc0209a36:	b70d                	j	ffffffffc0209958 <sfs_do_mount+0x190>
ffffffffc0209a38:	5a71                	li	s4,-4
ffffffffc0209a3a:	bf09                	j	ffffffffc020994c <sfs_do_mount+0x184>
ffffffffc0209a3c:	4b01                	li	s6,0
ffffffffc0209a3e:	bfb5                	j	ffffffffc02099ba <sfs_do_mount+0x1f2>
ffffffffc0209a40:	5a71                	li	s4,-4
ffffffffc0209a42:	bf19                	j	ffffffffc0209958 <sfs_do_mount+0x190>
ffffffffc0209a44:	00005697          	auipc	a3,0x5
ffffffffc0209a48:	7fc68693          	addi	a3,a3,2044 # ffffffffc020f240 <dev_node_ops+0x508>
ffffffffc0209a4c:	00002617          	auipc	a2,0x2
ffffffffc0209a50:	3b460613          	addi	a2,a2,948 # ffffffffc020be00 <commands+0x210>
ffffffffc0209a54:	08300593          	li	a1,131
ffffffffc0209a58:	00005517          	auipc	a0,0x5
ffffffffc0209a5c:	6f050513          	addi	a0,a0,1776 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc0209a60:	a3ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a64:	00005697          	auipc	a3,0x5
ffffffffc0209a68:	6b468693          	addi	a3,a3,1716 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc0209a6c:	00002617          	auipc	a2,0x2
ffffffffc0209a70:	39460613          	addi	a2,a2,916 # ffffffffc020be00 <commands+0x210>
ffffffffc0209a74:	0a300593          	li	a1,163
ffffffffc0209a78:	00005517          	auipc	a0,0x5
ffffffffc0209a7c:	6d050513          	addi	a0,a0,1744 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc0209a80:	a1ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a84:	00005697          	auipc	a3,0x5
ffffffffc0209a88:	7ec68693          	addi	a3,a3,2028 # ffffffffc020f270 <dev_node_ops+0x538>
ffffffffc0209a8c:	00002617          	auipc	a2,0x2
ffffffffc0209a90:	37460613          	addi	a2,a2,884 # ffffffffc020be00 <commands+0x210>
ffffffffc0209a94:	0e000593          	li	a1,224
ffffffffc0209a98:	00005517          	auipc	a0,0x5
ffffffffc0209a9c:	6b050513          	addi	a0,a0,1712 # ffffffffc020f148 <dev_node_ops+0x410>
ffffffffc0209aa0:	9fff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209aa4 <sfs_mount>:
ffffffffc0209aa4:	00000597          	auipc	a1,0x0
ffffffffc0209aa8:	d2458593          	addi	a1,a1,-732 # ffffffffc02097c8 <sfs_do_mount>
ffffffffc0209aac:	817fe06f          	j	ffffffffc02082c2 <vfs_mount>

ffffffffc0209ab0 <sfs_opendir>:
ffffffffc0209ab0:	0235f593          	andi	a1,a1,35
ffffffffc0209ab4:	4501                	li	a0,0
ffffffffc0209ab6:	e191                	bnez	a1,ffffffffc0209aba <sfs_opendir+0xa>
ffffffffc0209ab8:	8082                	ret
ffffffffc0209aba:	553d                	li	a0,-17
ffffffffc0209abc:	8082                	ret

ffffffffc0209abe <sfs_openfile>:
ffffffffc0209abe:	4501                	li	a0,0
ffffffffc0209ac0:	8082                	ret

ffffffffc0209ac2 <sfs_gettype>:
ffffffffc0209ac2:	1141                	addi	sp,sp,-16
ffffffffc0209ac4:	e406                	sd	ra,8(sp)
ffffffffc0209ac6:	c939                	beqz	a0,ffffffffc0209b1c <sfs_gettype+0x5a>
ffffffffc0209ac8:	4d34                	lw	a3,88(a0)
ffffffffc0209aca:	6785                	lui	a5,0x1
ffffffffc0209acc:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209ad0:	04e69663          	bne	a3,a4,ffffffffc0209b1c <sfs_gettype+0x5a>
ffffffffc0209ad4:	6114                	ld	a3,0(a0)
ffffffffc0209ad6:	4709                	li	a4,2
ffffffffc0209ad8:	0046d683          	lhu	a3,4(a3)
ffffffffc0209adc:	02e68a63          	beq	a3,a4,ffffffffc0209b10 <sfs_gettype+0x4e>
ffffffffc0209ae0:	470d                	li	a4,3
ffffffffc0209ae2:	02e68163          	beq	a3,a4,ffffffffc0209b04 <sfs_gettype+0x42>
ffffffffc0209ae6:	4705                	li	a4,1
ffffffffc0209ae8:	00e68f63          	beq	a3,a4,ffffffffc0209b06 <sfs_gettype+0x44>
ffffffffc0209aec:	00006617          	auipc	a2,0x6
ffffffffc0209af0:	82460613          	addi	a2,a2,-2012 # ffffffffc020f310 <dev_node_ops+0x5d8>
ffffffffc0209af4:	39500593          	li	a1,917
ffffffffc0209af8:	00006517          	auipc	a0,0x6
ffffffffc0209afc:	80050513          	addi	a0,a0,-2048 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209b00:	99ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b04:	678d                	lui	a5,0x3
ffffffffc0209b06:	60a2                	ld	ra,8(sp)
ffffffffc0209b08:	c19c                	sw	a5,0(a1)
ffffffffc0209b0a:	4501                	li	a0,0
ffffffffc0209b0c:	0141                	addi	sp,sp,16
ffffffffc0209b0e:	8082                	ret
ffffffffc0209b10:	60a2                	ld	ra,8(sp)
ffffffffc0209b12:	6789                	lui	a5,0x2
ffffffffc0209b14:	c19c                	sw	a5,0(a1)
ffffffffc0209b16:	4501                	li	a0,0
ffffffffc0209b18:	0141                	addi	sp,sp,16
ffffffffc0209b1a:	8082                	ret
ffffffffc0209b1c:	00005697          	auipc	a3,0x5
ffffffffc0209b20:	7a468693          	addi	a3,a3,1956 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc0209b24:	00002617          	auipc	a2,0x2
ffffffffc0209b28:	2dc60613          	addi	a2,a2,732 # ffffffffc020be00 <commands+0x210>
ffffffffc0209b2c:	38900593          	li	a1,905
ffffffffc0209b30:	00005517          	auipc	a0,0x5
ffffffffc0209b34:	7c850513          	addi	a0,a0,1992 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209b38:	967f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209b3c <sfs_fsync>:
ffffffffc0209b3c:	7179                	addi	sp,sp,-48
ffffffffc0209b3e:	ec26                	sd	s1,24(sp)
ffffffffc0209b40:	7524                	ld	s1,104(a0)
ffffffffc0209b42:	f406                	sd	ra,40(sp)
ffffffffc0209b44:	f022                	sd	s0,32(sp)
ffffffffc0209b46:	e84a                	sd	s2,16(sp)
ffffffffc0209b48:	e44e                	sd	s3,8(sp)
ffffffffc0209b4a:	c4bd                	beqz	s1,ffffffffc0209bb8 <sfs_fsync+0x7c>
ffffffffc0209b4c:	0b04a783          	lw	a5,176(s1)
ffffffffc0209b50:	e7a5                	bnez	a5,ffffffffc0209bb8 <sfs_fsync+0x7c>
ffffffffc0209b52:	4d38                	lw	a4,88(a0)
ffffffffc0209b54:	6785                	lui	a5,0x1
ffffffffc0209b56:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209b5a:	842a                	mv	s0,a0
ffffffffc0209b5c:	06f71e63          	bne	a4,a5,ffffffffc0209bd8 <sfs_fsync+0x9c>
ffffffffc0209b60:	691c                	ld	a5,16(a0)
ffffffffc0209b62:	4901                	li	s2,0
ffffffffc0209b64:	eb89                	bnez	a5,ffffffffc0209b76 <sfs_fsync+0x3a>
ffffffffc0209b66:	70a2                	ld	ra,40(sp)
ffffffffc0209b68:	7402                	ld	s0,32(sp)
ffffffffc0209b6a:	64e2                	ld	s1,24(sp)
ffffffffc0209b6c:	69a2                	ld	s3,8(sp)
ffffffffc0209b6e:	854a                	mv	a0,s2
ffffffffc0209b70:	6942                	ld	s2,16(sp)
ffffffffc0209b72:	6145                	addi	sp,sp,48
ffffffffc0209b74:	8082                	ret
ffffffffc0209b76:	02050993          	addi	s3,a0,32
ffffffffc0209b7a:	854e                	mv	a0,s3
ffffffffc0209b7c:	a81fa0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0209b80:	681c                	ld	a5,16(s0)
ffffffffc0209b82:	ef81                	bnez	a5,ffffffffc0209b9a <sfs_fsync+0x5e>
ffffffffc0209b84:	854e                	mv	a0,s3
ffffffffc0209b86:	a73fa0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0209b8a:	70a2                	ld	ra,40(sp)
ffffffffc0209b8c:	7402                	ld	s0,32(sp)
ffffffffc0209b8e:	64e2                	ld	s1,24(sp)
ffffffffc0209b90:	69a2                	ld	s3,8(sp)
ffffffffc0209b92:	854a                	mv	a0,s2
ffffffffc0209b94:	6942                	ld	s2,16(sp)
ffffffffc0209b96:	6145                	addi	sp,sp,48
ffffffffc0209b98:	8082                	ret
ffffffffc0209b9a:	4414                	lw	a3,8(s0)
ffffffffc0209b9c:	600c                	ld	a1,0(s0)
ffffffffc0209b9e:	00043823          	sd	zero,16(s0)
ffffffffc0209ba2:	4701                	li	a4,0
ffffffffc0209ba4:	04000613          	li	a2,64
ffffffffc0209ba8:	8526                	mv	a0,s1
ffffffffc0209baa:	66a010ef          	jal	ra,ffffffffc020b214 <sfs_wbuf>
ffffffffc0209bae:	892a                	mv	s2,a0
ffffffffc0209bb0:	d971                	beqz	a0,ffffffffc0209b84 <sfs_fsync+0x48>
ffffffffc0209bb2:	4785                	li	a5,1
ffffffffc0209bb4:	e81c                	sd	a5,16(s0)
ffffffffc0209bb6:	b7f9                	j	ffffffffc0209b84 <sfs_fsync+0x48>
ffffffffc0209bb8:	00005697          	auipc	a3,0x5
ffffffffc0209bbc:	56068693          	addi	a3,a3,1376 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc0209bc0:	00002617          	auipc	a2,0x2
ffffffffc0209bc4:	24060613          	addi	a2,a2,576 # ffffffffc020be00 <commands+0x210>
ffffffffc0209bc8:	2cd00593          	li	a1,717
ffffffffc0209bcc:	00005517          	auipc	a0,0x5
ffffffffc0209bd0:	72c50513          	addi	a0,a0,1836 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209bd4:	8cbf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bd8:	00005697          	auipc	a3,0x5
ffffffffc0209bdc:	6e868693          	addi	a3,a3,1768 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc0209be0:	00002617          	auipc	a2,0x2
ffffffffc0209be4:	22060613          	addi	a2,a2,544 # ffffffffc020be00 <commands+0x210>
ffffffffc0209be8:	2ce00593          	li	a1,718
ffffffffc0209bec:	00005517          	auipc	a0,0x5
ffffffffc0209bf0:	70c50513          	addi	a0,a0,1804 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209bf4:	8abf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209bf8 <sfs_fstat>:
ffffffffc0209bf8:	1101                	addi	sp,sp,-32
ffffffffc0209bfa:	e426                	sd	s1,8(sp)
ffffffffc0209bfc:	84ae                	mv	s1,a1
ffffffffc0209bfe:	e822                	sd	s0,16(sp)
ffffffffc0209c00:	02000613          	li	a2,32
ffffffffc0209c04:	842a                	mv	s0,a0
ffffffffc0209c06:	4581                	li	a1,0
ffffffffc0209c08:	8526                	mv	a0,s1
ffffffffc0209c0a:	ec06                	sd	ra,24(sp)
ffffffffc0209c0c:	50d010ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc0209c10:	c439                	beqz	s0,ffffffffc0209c5e <sfs_fstat+0x66>
ffffffffc0209c12:	783c                	ld	a5,112(s0)
ffffffffc0209c14:	c7a9                	beqz	a5,ffffffffc0209c5e <sfs_fstat+0x66>
ffffffffc0209c16:	6bbc                	ld	a5,80(a5)
ffffffffc0209c18:	c3b9                	beqz	a5,ffffffffc0209c5e <sfs_fstat+0x66>
ffffffffc0209c1a:	00005597          	auipc	a1,0x5
ffffffffc0209c1e:	09658593          	addi	a1,a1,150 # ffffffffc020ecb0 <syscalls+0xdb0>
ffffffffc0209c22:	8522                	mv	a0,s0
ffffffffc0209c24:	8cefe0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0209c28:	783c                	ld	a5,112(s0)
ffffffffc0209c2a:	85a6                	mv	a1,s1
ffffffffc0209c2c:	8522                	mv	a0,s0
ffffffffc0209c2e:	6bbc                	ld	a5,80(a5)
ffffffffc0209c30:	9782                	jalr	a5
ffffffffc0209c32:	e10d                	bnez	a0,ffffffffc0209c54 <sfs_fstat+0x5c>
ffffffffc0209c34:	4c38                	lw	a4,88(s0)
ffffffffc0209c36:	6785                	lui	a5,0x1
ffffffffc0209c38:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209c3c:	04f71163          	bne	a4,a5,ffffffffc0209c7e <sfs_fstat+0x86>
ffffffffc0209c40:	601c                	ld	a5,0(s0)
ffffffffc0209c42:	0067d683          	lhu	a3,6(a5)
ffffffffc0209c46:	0087e703          	lwu	a4,8(a5)
ffffffffc0209c4a:	0007e783          	lwu	a5,0(a5)
ffffffffc0209c4e:	e494                	sd	a3,8(s1)
ffffffffc0209c50:	e898                	sd	a4,16(s1)
ffffffffc0209c52:	ec9c                	sd	a5,24(s1)
ffffffffc0209c54:	60e2                	ld	ra,24(sp)
ffffffffc0209c56:	6442                	ld	s0,16(sp)
ffffffffc0209c58:	64a2                	ld	s1,8(sp)
ffffffffc0209c5a:	6105                	addi	sp,sp,32
ffffffffc0209c5c:	8082                	ret
ffffffffc0209c5e:	00005697          	auipc	a3,0x5
ffffffffc0209c62:	fea68693          	addi	a3,a3,-22 # ffffffffc020ec48 <syscalls+0xd48>
ffffffffc0209c66:	00002617          	auipc	a2,0x2
ffffffffc0209c6a:	19a60613          	addi	a2,a2,410 # ffffffffc020be00 <commands+0x210>
ffffffffc0209c6e:	2be00593          	li	a1,702
ffffffffc0209c72:	00005517          	auipc	a0,0x5
ffffffffc0209c76:	68650513          	addi	a0,a0,1670 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209c7a:	825f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c7e:	00005697          	auipc	a3,0x5
ffffffffc0209c82:	64268693          	addi	a3,a3,1602 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc0209c86:	00002617          	auipc	a2,0x2
ffffffffc0209c8a:	17a60613          	addi	a2,a2,378 # ffffffffc020be00 <commands+0x210>
ffffffffc0209c8e:	2c100593          	li	a1,705
ffffffffc0209c92:	00005517          	auipc	a0,0x5
ffffffffc0209c96:	66650513          	addi	a0,a0,1638 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209c9a:	805f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c9e <sfs_tryseek>:
ffffffffc0209c9e:	080007b7          	lui	a5,0x8000
ffffffffc0209ca2:	04f5fd63          	bgeu	a1,a5,ffffffffc0209cfc <sfs_tryseek+0x5e>
ffffffffc0209ca6:	1101                	addi	sp,sp,-32
ffffffffc0209ca8:	e822                	sd	s0,16(sp)
ffffffffc0209caa:	ec06                	sd	ra,24(sp)
ffffffffc0209cac:	e426                	sd	s1,8(sp)
ffffffffc0209cae:	842a                	mv	s0,a0
ffffffffc0209cb0:	c921                	beqz	a0,ffffffffc0209d00 <sfs_tryseek+0x62>
ffffffffc0209cb2:	4d38                	lw	a4,88(a0)
ffffffffc0209cb4:	6785                	lui	a5,0x1
ffffffffc0209cb6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209cba:	04f71363          	bne	a4,a5,ffffffffc0209d00 <sfs_tryseek+0x62>
ffffffffc0209cbe:	611c                	ld	a5,0(a0)
ffffffffc0209cc0:	84ae                	mv	s1,a1
ffffffffc0209cc2:	0007e783          	lwu	a5,0(a5)
ffffffffc0209cc6:	02b7d563          	bge	a5,a1,ffffffffc0209cf0 <sfs_tryseek+0x52>
ffffffffc0209cca:	793c                	ld	a5,112(a0)
ffffffffc0209ccc:	cbb1                	beqz	a5,ffffffffc0209d20 <sfs_tryseek+0x82>
ffffffffc0209cce:	73bc                	ld	a5,96(a5)
ffffffffc0209cd0:	cba1                	beqz	a5,ffffffffc0209d20 <sfs_tryseek+0x82>
ffffffffc0209cd2:	00005597          	auipc	a1,0x5
ffffffffc0209cd6:	ece58593          	addi	a1,a1,-306 # ffffffffc020eba0 <syscalls+0xca0>
ffffffffc0209cda:	818fe0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0209cde:	783c                	ld	a5,112(s0)
ffffffffc0209ce0:	8522                	mv	a0,s0
ffffffffc0209ce2:	6442                	ld	s0,16(sp)
ffffffffc0209ce4:	60e2                	ld	ra,24(sp)
ffffffffc0209ce6:	73bc                	ld	a5,96(a5)
ffffffffc0209ce8:	85a6                	mv	a1,s1
ffffffffc0209cea:	64a2                	ld	s1,8(sp)
ffffffffc0209cec:	6105                	addi	sp,sp,32
ffffffffc0209cee:	8782                	jr	a5
ffffffffc0209cf0:	60e2                	ld	ra,24(sp)
ffffffffc0209cf2:	6442                	ld	s0,16(sp)
ffffffffc0209cf4:	64a2                	ld	s1,8(sp)
ffffffffc0209cf6:	4501                	li	a0,0
ffffffffc0209cf8:	6105                	addi	sp,sp,32
ffffffffc0209cfa:	8082                	ret
ffffffffc0209cfc:	5575                	li	a0,-3
ffffffffc0209cfe:	8082                	ret
ffffffffc0209d00:	00005697          	auipc	a3,0x5
ffffffffc0209d04:	5c068693          	addi	a3,a3,1472 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc0209d08:	00002617          	auipc	a2,0x2
ffffffffc0209d0c:	0f860613          	addi	a2,a2,248 # ffffffffc020be00 <commands+0x210>
ffffffffc0209d10:	3a000593          	li	a1,928
ffffffffc0209d14:	00005517          	auipc	a0,0x5
ffffffffc0209d18:	5e450513          	addi	a0,a0,1508 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209d1c:	f82f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d20:	00005697          	auipc	a3,0x5
ffffffffc0209d24:	e2868693          	addi	a3,a3,-472 # ffffffffc020eb48 <syscalls+0xc48>
ffffffffc0209d28:	00002617          	auipc	a2,0x2
ffffffffc0209d2c:	0d860613          	addi	a2,a2,216 # ffffffffc020be00 <commands+0x210>
ffffffffc0209d30:	3a200593          	li	a1,930
ffffffffc0209d34:	00005517          	auipc	a0,0x5
ffffffffc0209d38:	5c450513          	addi	a0,a0,1476 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209d3c:	f62f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209d40 <sfs_close>:
ffffffffc0209d40:	1141                	addi	sp,sp,-16
ffffffffc0209d42:	e406                	sd	ra,8(sp)
ffffffffc0209d44:	e022                	sd	s0,0(sp)
ffffffffc0209d46:	c11d                	beqz	a0,ffffffffc0209d6c <sfs_close+0x2c>
ffffffffc0209d48:	793c                	ld	a5,112(a0)
ffffffffc0209d4a:	842a                	mv	s0,a0
ffffffffc0209d4c:	c385                	beqz	a5,ffffffffc0209d6c <sfs_close+0x2c>
ffffffffc0209d4e:	7b9c                	ld	a5,48(a5)
ffffffffc0209d50:	cf91                	beqz	a5,ffffffffc0209d6c <sfs_close+0x2c>
ffffffffc0209d52:	00004597          	auipc	a1,0x4
ffffffffc0209d56:	a6e58593          	addi	a1,a1,-1426 # ffffffffc020d7c0 <default_pmm_manager+0xea0>
ffffffffc0209d5a:	f99fd0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0209d5e:	783c                	ld	a5,112(s0)
ffffffffc0209d60:	8522                	mv	a0,s0
ffffffffc0209d62:	6402                	ld	s0,0(sp)
ffffffffc0209d64:	60a2                	ld	ra,8(sp)
ffffffffc0209d66:	7b9c                	ld	a5,48(a5)
ffffffffc0209d68:	0141                	addi	sp,sp,16
ffffffffc0209d6a:	8782                	jr	a5
ffffffffc0209d6c:	00004697          	auipc	a3,0x4
ffffffffc0209d70:	a0468693          	addi	a3,a3,-1532 # ffffffffc020d770 <default_pmm_manager+0xe50>
ffffffffc0209d74:	00002617          	auipc	a2,0x2
ffffffffc0209d78:	08c60613          	addi	a2,a2,140 # ffffffffc020be00 <commands+0x210>
ffffffffc0209d7c:	21c00593          	li	a1,540
ffffffffc0209d80:	00005517          	auipc	a0,0x5
ffffffffc0209d84:	57850513          	addi	a0,a0,1400 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209d88:	f16f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209d8c <sfs_io.part.0>:
ffffffffc0209d8c:	1141                	addi	sp,sp,-16
ffffffffc0209d8e:	00005697          	auipc	a3,0x5
ffffffffc0209d92:	53268693          	addi	a3,a3,1330 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc0209d96:	00002617          	auipc	a2,0x2
ffffffffc0209d9a:	06a60613          	addi	a2,a2,106 # ffffffffc020be00 <commands+0x210>
ffffffffc0209d9e:	29d00593          	li	a1,669
ffffffffc0209da2:	00005517          	auipc	a0,0x5
ffffffffc0209da6:	55650513          	addi	a0,a0,1366 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209daa:	e406                	sd	ra,8(sp)
ffffffffc0209dac:	ef2f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209db0 <sfs_block_free>:
ffffffffc0209db0:	1101                	addi	sp,sp,-32
ffffffffc0209db2:	e426                	sd	s1,8(sp)
ffffffffc0209db4:	ec06                	sd	ra,24(sp)
ffffffffc0209db6:	e822                	sd	s0,16(sp)
ffffffffc0209db8:	4154                	lw	a3,4(a0)
ffffffffc0209dba:	84ae                	mv	s1,a1
ffffffffc0209dbc:	c595                	beqz	a1,ffffffffc0209de8 <sfs_block_free+0x38>
ffffffffc0209dbe:	02d5f563          	bgeu	a1,a3,ffffffffc0209de8 <sfs_block_free+0x38>
ffffffffc0209dc2:	842a                	mv	s0,a0
ffffffffc0209dc4:	7d08                	ld	a0,56(a0)
ffffffffc0209dc6:	edcff0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc0209dca:	ed05                	bnez	a0,ffffffffc0209e02 <sfs_block_free+0x52>
ffffffffc0209dcc:	7c08                	ld	a0,56(s0)
ffffffffc0209dce:	85a6                	mv	a1,s1
ffffffffc0209dd0:	efaff0ef          	jal	ra,ffffffffc02094ca <bitmap_free>
ffffffffc0209dd4:	441c                	lw	a5,8(s0)
ffffffffc0209dd6:	4705                	li	a4,1
ffffffffc0209dd8:	60e2                	ld	ra,24(sp)
ffffffffc0209dda:	2785                	addiw	a5,a5,1
ffffffffc0209ddc:	e038                	sd	a4,64(s0)
ffffffffc0209dde:	c41c                	sw	a5,8(s0)
ffffffffc0209de0:	6442                	ld	s0,16(sp)
ffffffffc0209de2:	64a2                	ld	s1,8(sp)
ffffffffc0209de4:	6105                	addi	sp,sp,32
ffffffffc0209de6:	8082                	ret
ffffffffc0209de8:	8726                	mv	a4,s1
ffffffffc0209dea:	00005617          	auipc	a2,0x5
ffffffffc0209dee:	53e60613          	addi	a2,a2,1342 # ffffffffc020f328 <dev_node_ops+0x5f0>
ffffffffc0209df2:	05300593          	li	a1,83
ffffffffc0209df6:	00005517          	auipc	a0,0x5
ffffffffc0209dfa:	50250513          	addi	a0,a0,1282 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209dfe:	ea0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e02:	00005697          	auipc	a3,0x5
ffffffffc0209e06:	55e68693          	addi	a3,a3,1374 # ffffffffc020f360 <dev_node_ops+0x628>
ffffffffc0209e0a:	00002617          	auipc	a2,0x2
ffffffffc0209e0e:	ff660613          	addi	a2,a2,-10 # ffffffffc020be00 <commands+0x210>
ffffffffc0209e12:	06a00593          	li	a1,106
ffffffffc0209e16:	00005517          	auipc	a0,0x5
ffffffffc0209e1a:	4e250513          	addi	a0,a0,1250 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209e1e:	e80f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209e22 <sfs_reclaim>:
ffffffffc0209e22:	1101                	addi	sp,sp,-32
ffffffffc0209e24:	e426                	sd	s1,8(sp)
ffffffffc0209e26:	7524                	ld	s1,104(a0)
ffffffffc0209e28:	ec06                	sd	ra,24(sp)
ffffffffc0209e2a:	e822                	sd	s0,16(sp)
ffffffffc0209e2c:	e04a                	sd	s2,0(sp)
ffffffffc0209e2e:	0e048a63          	beqz	s1,ffffffffc0209f22 <sfs_reclaim+0x100>
ffffffffc0209e32:	0b04a783          	lw	a5,176(s1)
ffffffffc0209e36:	0e079663          	bnez	a5,ffffffffc0209f22 <sfs_reclaim+0x100>
ffffffffc0209e3a:	4d38                	lw	a4,88(a0)
ffffffffc0209e3c:	6785                	lui	a5,0x1
ffffffffc0209e3e:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209e42:	842a                	mv	s0,a0
ffffffffc0209e44:	10f71f63          	bne	a4,a5,ffffffffc0209f62 <sfs_reclaim+0x140>
ffffffffc0209e48:	8526                	mv	a0,s1
ffffffffc0209e4a:	57a010ef          	jal	ra,ffffffffc020b3c4 <lock_sfs_fs>
ffffffffc0209e4e:	4c1c                	lw	a5,24(s0)
ffffffffc0209e50:	0ef05963          	blez	a5,ffffffffc0209f42 <sfs_reclaim+0x120>
ffffffffc0209e54:	fff7871b          	addiw	a4,a5,-1
ffffffffc0209e58:	cc18                	sw	a4,24(s0)
ffffffffc0209e5a:	eb59                	bnez	a4,ffffffffc0209ef0 <sfs_reclaim+0xce>
ffffffffc0209e5c:	05c42903          	lw	s2,92(s0)
ffffffffc0209e60:	08091863          	bnez	s2,ffffffffc0209ef0 <sfs_reclaim+0xce>
ffffffffc0209e64:	601c                	ld	a5,0(s0)
ffffffffc0209e66:	0067d783          	lhu	a5,6(a5)
ffffffffc0209e6a:	e785                	bnez	a5,ffffffffc0209e92 <sfs_reclaim+0x70>
ffffffffc0209e6c:	783c                	ld	a5,112(s0)
ffffffffc0209e6e:	10078a63          	beqz	a5,ffffffffc0209f82 <sfs_reclaim+0x160>
ffffffffc0209e72:	73bc                	ld	a5,96(a5)
ffffffffc0209e74:	10078763          	beqz	a5,ffffffffc0209f82 <sfs_reclaim+0x160>
ffffffffc0209e78:	00005597          	auipc	a1,0x5
ffffffffc0209e7c:	d2858593          	addi	a1,a1,-728 # ffffffffc020eba0 <syscalls+0xca0>
ffffffffc0209e80:	8522                	mv	a0,s0
ffffffffc0209e82:	e71fd0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0209e86:	783c                	ld	a5,112(s0)
ffffffffc0209e88:	4581                	li	a1,0
ffffffffc0209e8a:	8522                	mv	a0,s0
ffffffffc0209e8c:	73bc                	ld	a5,96(a5)
ffffffffc0209e8e:	9782                	jalr	a5
ffffffffc0209e90:	e559                	bnez	a0,ffffffffc0209f1e <sfs_reclaim+0xfc>
ffffffffc0209e92:	681c                	ld	a5,16(s0)
ffffffffc0209e94:	c39d                	beqz	a5,ffffffffc0209eba <sfs_reclaim+0x98>
ffffffffc0209e96:	783c                	ld	a5,112(s0)
ffffffffc0209e98:	10078563          	beqz	a5,ffffffffc0209fa2 <sfs_reclaim+0x180>
ffffffffc0209e9c:	7b9c                	ld	a5,48(a5)
ffffffffc0209e9e:	10078263          	beqz	a5,ffffffffc0209fa2 <sfs_reclaim+0x180>
ffffffffc0209ea2:	8522                	mv	a0,s0
ffffffffc0209ea4:	00004597          	auipc	a1,0x4
ffffffffc0209ea8:	91c58593          	addi	a1,a1,-1764 # ffffffffc020d7c0 <default_pmm_manager+0xea0>
ffffffffc0209eac:	e47fd0ef          	jal	ra,ffffffffc0207cf2 <inode_check>
ffffffffc0209eb0:	783c                	ld	a5,112(s0)
ffffffffc0209eb2:	8522                	mv	a0,s0
ffffffffc0209eb4:	7b9c                	ld	a5,48(a5)
ffffffffc0209eb6:	9782                	jalr	a5
ffffffffc0209eb8:	e13d                	bnez	a0,ffffffffc0209f1e <sfs_reclaim+0xfc>
ffffffffc0209eba:	7c18                	ld	a4,56(s0)
ffffffffc0209ebc:	603c                	ld	a5,64(s0)
ffffffffc0209ebe:	8526                	mv	a0,s1
ffffffffc0209ec0:	e71c                	sd	a5,8(a4)
ffffffffc0209ec2:	e398                	sd	a4,0(a5)
ffffffffc0209ec4:	6438                	ld	a4,72(s0)
ffffffffc0209ec6:	683c                	ld	a5,80(s0)
ffffffffc0209ec8:	e71c                	sd	a5,8(a4)
ffffffffc0209eca:	e398                	sd	a4,0(a5)
ffffffffc0209ecc:	508010ef          	jal	ra,ffffffffc020b3d4 <unlock_sfs_fs>
ffffffffc0209ed0:	6008                	ld	a0,0(s0)
ffffffffc0209ed2:	00655783          	lhu	a5,6(a0)
ffffffffc0209ed6:	cb85                	beqz	a5,ffffffffc0209f06 <sfs_reclaim+0xe4>
ffffffffc0209ed8:	9faf80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209edc:	8522                	mv	a0,s0
ffffffffc0209ede:	da9fd0ef          	jal	ra,ffffffffc0207c86 <inode_kill>
ffffffffc0209ee2:	60e2                	ld	ra,24(sp)
ffffffffc0209ee4:	6442                	ld	s0,16(sp)
ffffffffc0209ee6:	64a2                	ld	s1,8(sp)
ffffffffc0209ee8:	854a                	mv	a0,s2
ffffffffc0209eea:	6902                	ld	s2,0(sp)
ffffffffc0209eec:	6105                	addi	sp,sp,32
ffffffffc0209eee:	8082                	ret
ffffffffc0209ef0:	5945                	li	s2,-15
ffffffffc0209ef2:	8526                	mv	a0,s1
ffffffffc0209ef4:	4e0010ef          	jal	ra,ffffffffc020b3d4 <unlock_sfs_fs>
ffffffffc0209ef8:	60e2                	ld	ra,24(sp)
ffffffffc0209efa:	6442                	ld	s0,16(sp)
ffffffffc0209efc:	64a2                	ld	s1,8(sp)
ffffffffc0209efe:	854a                	mv	a0,s2
ffffffffc0209f00:	6902                	ld	s2,0(sp)
ffffffffc0209f02:	6105                	addi	sp,sp,32
ffffffffc0209f04:	8082                	ret
ffffffffc0209f06:	440c                	lw	a1,8(s0)
ffffffffc0209f08:	8526                	mv	a0,s1
ffffffffc0209f0a:	ea7ff0ef          	jal	ra,ffffffffc0209db0 <sfs_block_free>
ffffffffc0209f0e:	6008                	ld	a0,0(s0)
ffffffffc0209f10:	5d4c                	lw	a1,60(a0)
ffffffffc0209f12:	d1f9                	beqz	a1,ffffffffc0209ed8 <sfs_reclaim+0xb6>
ffffffffc0209f14:	8526                	mv	a0,s1
ffffffffc0209f16:	e9bff0ef          	jal	ra,ffffffffc0209db0 <sfs_block_free>
ffffffffc0209f1a:	6008                	ld	a0,0(s0)
ffffffffc0209f1c:	bf75                	j	ffffffffc0209ed8 <sfs_reclaim+0xb6>
ffffffffc0209f1e:	892a                	mv	s2,a0
ffffffffc0209f20:	bfc9                	j	ffffffffc0209ef2 <sfs_reclaim+0xd0>
ffffffffc0209f22:	00005697          	auipc	a3,0x5
ffffffffc0209f26:	1f668693          	addi	a3,a3,502 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc0209f2a:	00002617          	auipc	a2,0x2
ffffffffc0209f2e:	ed660613          	addi	a2,a2,-298 # ffffffffc020be00 <commands+0x210>
ffffffffc0209f32:	35e00593          	li	a1,862
ffffffffc0209f36:	00005517          	auipc	a0,0x5
ffffffffc0209f3a:	3c250513          	addi	a0,a0,962 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209f3e:	d60f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f42:	00005697          	auipc	a3,0x5
ffffffffc0209f46:	43e68693          	addi	a3,a3,1086 # ffffffffc020f380 <dev_node_ops+0x648>
ffffffffc0209f4a:	00002617          	auipc	a2,0x2
ffffffffc0209f4e:	eb660613          	addi	a2,a2,-330 # ffffffffc020be00 <commands+0x210>
ffffffffc0209f52:	36400593          	li	a1,868
ffffffffc0209f56:	00005517          	auipc	a0,0x5
ffffffffc0209f5a:	3a250513          	addi	a0,a0,930 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209f5e:	d40f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f62:	00005697          	auipc	a3,0x5
ffffffffc0209f66:	35e68693          	addi	a3,a3,862 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc0209f6a:	00002617          	auipc	a2,0x2
ffffffffc0209f6e:	e9660613          	addi	a2,a2,-362 # ffffffffc020be00 <commands+0x210>
ffffffffc0209f72:	35f00593          	li	a1,863
ffffffffc0209f76:	00005517          	auipc	a0,0x5
ffffffffc0209f7a:	38250513          	addi	a0,a0,898 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209f7e:	d20f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f82:	00005697          	auipc	a3,0x5
ffffffffc0209f86:	bc668693          	addi	a3,a3,-1082 # ffffffffc020eb48 <syscalls+0xc48>
ffffffffc0209f8a:	00002617          	auipc	a2,0x2
ffffffffc0209f8e:	e7660613          	addi	a2,a2,-394 # ffffffffc020be00 <commands+0x210>
ffffffffc0209f92:	36900593          	li	a1,873
ffffffffc0209f96:	00005517          	auipc	a0,0x5
ffffffffc0209f9a:	36250513          	addi	a0,a0,866 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209f9e:	d00f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209fa2:	00003697          	auipc	a3,0x3
ffffffffc0209fa6:	7ce68693          	addi	a3,a3,1998 # ffffffffc020d770 <default_pmm_manager+0xe50>
ffffffffc0209faa:	00002617          	auipc	a2,0x2
ffffffffc0209fae:	e5660613          	addi	a2,a2,-426 # ffffffffc020be00 <commands+0x210>
ffffffffc0209fb2:	36e00593          	li	a1,878
ffffffffc0209fb6:	00005517          	auipc	a0,0x5
ffffffffc0209fba:	34250513          	addi	a0,a0,834 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc0209fbe:	ce0f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209fc2 <sfs_block_alloc>:
ffffffffc0209fc2:	1101                	addi	sp,sp,-32
ffffffffc0209fc4:	e822                	sd	s0,16(sp)
ffffffffc0209fc6:	842a                	mv	s0,a0
ffffffffc0209fc8:	7d08                	ld	a0,56(a0)
ffffffffc0209fca:	e426                	sd	s1,8(sp)
ffffffffc0209fcc:	ec06                	sd	ra,24(sp)
ffffffffc0209fce:	84ae                	mv	s1,a1
ffffffffc0209fd0:	c62ff0ef          	jal	ra,ffffffffc0209432 <bitmap_alloc>
ffffffffc0209fd4:	e90d                	bnez	a0,ffffffffc020a006 <sfs_block_alloc+0x44>
ffffffffc0209fd6:	441c                	lw	a5,8(s0)
ffffffffc0209fd8:	cbad                	beqz	a5,ffffffffc020a04a <sfs_block_alloc+0x88>
ffffffffc0209fda:	37fd                	addiw	a5,a5,-1
ffffffffc0209fdc:	c41c                	sw	a5,8(s0)
ffffffffc0209fde:	408c                	lw	a1,0(s1)
ffffffffc0209fe0:	4785                	li	a5,1
ffffffffc0209fe2:	e03c                	sd	a5,64(s0)
ffffffffc0209fe4:	4054                	lw	a3,4(s0)
ffffffffc0209fe6:	c58d                	beqz	a1,ffffffffc020a010 <sfs_block_alloc+0x4e>
ffffffffc0209fe8:	02d5f463          	bgeu	a1,a3,ffffffffc020a010 <sfs_block_alloc+0x4e>
ffffffffc0209fec:	7c08                	ld	a0,56(s0)
ffffffffc0209fee:	cb4ff0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc0209ff2:	ed05                	bnez	a0,ffffffffc020a02a <sfs_block_alloc+0x68>
ffffffffc0209ff4:	8522                	mv	a0,s0
ffffffffc0209ff6:	6442                	ld	s0,16(sp)
ffffffffc0209ff8:	408c                	lw	a1,0(s1)
ffffffffc0209ffa:	60e2                	ld	ra,24(sp)
ffffffffc0209ffc:	64a2                	ld	s1,8(sp)
ffffffffc0209ffe:	4605                	li	a2,1
ffffffffc020a000:	6105                	addi	sp,sp,32
ffffffffc020a002:	3620106f          	j	ffffffffc020b364 <sfs_clear_block>
ffffffffc020a006:	60e2                	ld	ra,24(sp)
ffffffffc020a008:	6442                	ld	s0,16(sp)
ffffffffc020a00a:	64a2                	ld	s1,8(sp)
ffffffffc020a00c:	6105                	addi	sp,sp,32
ffffffffc020a00e:	8082                	ret
ffffffffc020a010:	872e                	mv	a4,a1
ffffffffc020a012:	00005617          	auipc	a2,0x5
ffffffffc020a016:	31660613          	addi	a2,a2,790 # ffffffffc020f328 <dev_node_ops+0x5f0>
ffffffffc020a01a:	05300593          	li	a1,83
ffffffffc020a01e:	00005517          	auipc	a0,0x5
ffffffffc020a022:	2da50513          	addi	a0,a0,730 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a026:	c78f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a02a:	00005697          	auipc	a3,0x5
ffffffffc020a02e:	38e68693          	addi	a3,a3,910 # ffffffffc020f3b8 <dev_node_ops+0x680>
ffffffffc020a032:	00002617          	auipc	a2,0x2
ffffffffc020a036:	dce60613          	addi	a2,a2,-562 # ffffffffc020be00 <commands+0x210>
ffffffffc020a03a:	06100593          	li	a1,97
ffffffffc020a03e:	00005517          	auipc	a0,0x5
ffffffffc020a042:	2ba50513          	addi	a0,a0,698 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a046:	c58f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a04a:	00005697          	auipc	a3,0x5
ffffffffc020a04e:	34e68693          	addi	a3,a3,846 # ffffffffc020f398 <dev_node_ops+0x660>
ffffffffc020a052:	00002617          	auipc	a2,0x2
ffffffffc020a056:	dae60613          	addi	a2,a2,-594 # ffffffffc020be00 <commands+0x210>
ffffffffc020a05a:	05f00593          	li	a1,95
ffffffffc020a05e:	00005517          	auipc	a0,0x5
ffffffffc020a062:	29a50513          	addi	a0,a0,666 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a066:	c38f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a06a <sfs_bmap_load_nolock>:
ffffffffc020a06a:	7159                	addi	sp,sp,-112
ffffffffc020a06c:	f85a                	sd	s6,48(sp)
ffffffffc020a06e:	0005bb03          	ld	s6,0(a1)
ffffffffc020a072:	f45e                	sd	s7,40(sp)
ffffffffc020a074:	f486                	sd	ra,104(sp)
ffffffffc020a076:	008b2b83          	lw	s7,8(s6)
ffffffffc020a07a:	f0a2                	sd	s0,96(sp)
ffffffffc020a07c:	eca6                	sd	s1,88(sp)
ffffffffc020a07e:	e8ca                	sd	s2,80(sp)
ffffffffc020a080:	e4ce                	sd	s3,72(sp)
ffffffffc020a082:	e0d2                	sd	s4,64(sp)
ffffffffc020a084:	fc56                	sd	s5,56(sp)
ffffffffc020a086:	f062                	sd	s8,32(sp)
ffffffffc020a088:	ec66                	sd	s9,24(sp)
ffffffffc020a08a:	18cbe363          	bltu	s7,a2,ffffffffc020a210 <sfs_bmap_load_nolock+0x1a6>
ffffffffc020a08e:	47ad                	li	a5,11
ffffffffc020a090:	8aae                	mv	s5,a1
ffffffffc020a092:	8432                	mv	s0,a2
ffffffffc020a094:	84aa                	mv	s1,a0
ffffffffc020a096:	89b6                	mv	s3,a3
ffffffffc020a098:	04c7f563          	bgeu	a5,a2,ffffffffc020a0e2 <sfs_bmap_load_nolock+0x78>
ffffffffc020a09c:	ff46071b          	addiw	a4,a2,-12
ffffffffc020a0a0:	0007069b          	sext.w	a3,a4
ffffffffc020a0a4:	3ff00793          	li	a5,1023
ffffffffc020a0a8:	1ad7e163          	bltu	a5,a3,ffffffffc020a24a <sfs_bmap_load_nolock+0x1e0>
ffffffffc020a0ac:	03cb2a03          	lw	s4,60(s6)
ffffffffc020a0b0:	02071793          	slli	a5,a4,0x20
ffffffffc020a0b4:	c602                	sw	zero,12(sp)
ffffffffc020a0b6:	c452                	sw	s4,8(sp)
ffffffffc020a0b8:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc020a0bc:	0e0a1e63          	bnez	s4,ffffffffc020a1b8 <sfs_bmap_load_nolock+0x14e>
ffffffffc020a0c0:	0acb8663          	beq	s7,a2,ffffffffc020a16c <sfs_bmap_load_nolock+0x102>
ffffffffc020a0c4:	4a01                	li	s4,0
ffffffffc020a0c6:	40d4                	lw	a3,4(s1)
ffffffffc020a0c8:	8752                	mv	a4,s4
ffffffffc020a0ca:	00005617          	auipc	a2,0x5
ffffffffc020a0ce:	25e60613          	addi	a2,a2,606 # ffffffffc020f328 <dev_node_ops+0x5f0>
ffffffffc020a0d2:	05300593          	li	a1,83
ffffffffc020a0d6:	00005517          	auipc	a0,0x5
ffffffffc020a0da:	22250513          	addi	a0,a0,546 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a0de:	bc0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0e2:	02061793          	slli	a5,a2,0x20
ffffffffc020a0e6:	01e7da13          	srli	s4,a5,0x1e
ffffffffc020a0ea:	9a5a                	add	s4,s4,s6
ffffffffc020a0ec:	00ca2583          	lw	a1,12(s4)
ffffffffc020a0f0:	c22e                	sw	a1,4(sp)
ffffffffc020a0f2:	ed99                	bnez	a1,ffffffffc020a110 <sfs_bmap_load_nolock+0xa6>
ffffffffc020a0f4:	fccb98e3          	bne	s7,a2,ffffffffc020a0c4 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a0f8:	004c                	addi	a1,sp,4
ffffffffc020a0fa:	ec9ff0ef          	jal	ra,ffffffffc0209fc2 <sfs_block_alloc>
ffffffffc020a0fe:	892a                	mv	s2,a0
ffffffffc020a100:	e921                	bnez	a0,ffffffffc020a150 <sfs_bmap_load_nolock+0xe6>
ffffffffc020a102:	4592                	lw	a1,4(sp)
ffffffffc020a104:	4705                	li	a4,1
ffffffffc020a106:	00ba2623          	sw	a1,12(s4)
ffffffffc020a10a:	00eab823          	sd	a4,16(s5)
ffffffffc020a10e:	d9dd                	beqz	a1,ffffffffc020a0c4 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a110:	40d4                	lw	a3,4(s1)
ffffffffc020a112:	10d5ff63          	bgeu	a1,a3,ffffffffc020a230 <sfs_bmap_load_nolock+0x1c6>
ffffffffc020a116:	7c88                	ld	a0,56(s1)
ffffffffc020a118:	b8aff0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc020a11c:	18051363          	bnez	a0,ffffffffc020a2a2 <sfs_bmap_load_nolock+0x238>
ffffffffc020a120:	4a12                	lw	s4,4(sp)
ffffffffc020a122:	fa0a02e3          	beqz	s4,ffffffffc020a0c6 <sfs_bmap_load_nolock+0x5c>
ffffffffc020a126:	40dc                	lw	a5,4(s1)
ffffffffc020a128:	f8fa7fe3          	bgeu	s4,a5,ffffffffc020a0c6 <sfs_bmap_load_nolock+0x5c>
ffffffffc020a12c:	7c88                	ld	a0,56(s1)
ffffffffc020a12e:	85d2                	mv	a1,s4
ffffffffc020a130:	b72ff0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc020a134:	12051763          	bnez	a0,ffffffffc020a262 <sfs_bmap_load_nolock+0x1f8>
ffffffffc020a138:	008b9763          	bne	s7,s0,ffffffffc020a146 <sfs_bmap_load_nolock+0xdc>
ffffffffc020a13c:	008b2783          	lw	a5,8(s6)
ffffffffc020a140:	2785                	addiw	a5,a5,1
ffffffffc020a142:	00fb2423          	sw	a5,8(s6)
ffffffffc020a146:	4901                	li	s2,0
ffffffffc020a148:	00098463          	beqz	s3,ffffffffc020a150 <sfs_bmap_load_nolock+0xe6>
ffffffffc020a14c:	0149a023          	sw	s4,0(s3)
ffffffffc020a150:	70a6                	ld	ra,104(sp)
ffffffffc020a152:	7406                	ld	s0,96(sp)
ffffffffc020a154:	64e6                	ld	s1,88(sp)
ffffffffc020a156:	69a6                	ld	s3,72(sp)
ffffffffc020a158:	6a06                	ld	s4,64(sp)
ffffffffc020a15a:	7ae2                	ld	s5,56(sp)
ffffffffc020a15c:	7b42                	ld	s6,48(sp)
ffffffffc020a15e:	7ba2                	ld	s7,40(sp)
ffffffffc020a160:	7c02                	ld	s8,32(sp)
ffffffffc020a162:	6ce2                	ld	s9,24(sp)
ffffffffc020a164:	854a                	mv	a0,s2
ffffffffc020a166:	6946                	ld	s2,80(sp)
ffffffffc020a168:	6165                	addi	sp,sp,112
ffffffffc020a16a:	8082                	ret
ffffffffc020a16c:	002c                	addi	a1,sp,8
ffffffffc020a16e:	e55ff0ef          	jal	ra,ffffffffc0209fc2 <sfs_block_alloc>
ffffffffc020a172:	892a                	mv	s2,a0
ffffffffc020a174:	00c10c93          	addi	s9,sp,12
ffffffffc020a178:	fd61                	bnez	a0,ffffffffc020a150 <sfs_bmap_load_nolock+0xe6>
ffffffffc020a17a:	85e6                	mv	a1,s9
ffffffffc020a17c:	8526                	mv	a0,s1
ffffffffc020a17e:	e45ff0ef          	jal	ra,ffffffffc0209fc2 <sfs_block_alloc>
ffffffffc020a182:	892a                	mv	s2,a0
ffffffffc020a184:	e925                	bnez	a0,ffffffffc020a1f4 <sfs_bmap_load_nolock+0x18a>
ffffffffc020a186:	46a2                	lw	a3,8(sp)
ffffffffc020a188:	85e6                	mv	a1,s9
ffffffffc020a18a:	8762                	mv	a4,s8
ffffffffc020a18c:	4611                	li	a2,4
ffffffffc020a18e:	8526                	mv	a0,s1
ffffffffc020a190:	084010ef          	jal	ra,ffffffffc020b214 <sfs_wbuf>
ffffffffc020a194:	45b2                	lw	a1,12(sp)
ffffffffc020a196:	892a                	mv	s2,a0
ffffffffc020a198:	e939                	bnez	a0,ffffffffc020a1ee <sfs_bmap_load_nolock+0x184>
ffffffffc020a19a:	03cb2683          	lw	a3,60(s6)
ffffffffc020a19e:	4722                	lw	a4,8(sp)
ffffffffc020a1a0:	c22e                	sw	a1,4(sp)
ffffffffc020a1a2:	f6d706e3          	beq	a4,a3,ffffffffc020a10e <sfs_bmap_load_nolock+0xa4>
ffffffffc020a1a6:	eef1                	bnez	a3,ffffffffc020a282 <sfs_bmap_load_nolock+0x218>
ffffffffc020a1a8:	02eb2e23          	sw	a4,60(s6)
ffffffffc020a1ac:	4705                	li	a4,1
ffffffffc020a1ae:	00eab823          	sd	a4,16(s5)
ffffffffc020a1b2:	f00589e3          	beqz	a1,ffffffffc020a0c4 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a1b6:	bfa9                	j	ffffffffc020a110 <sfs_bmap_load_nolock+0xa6>
ffffffffc020a1b8:	00c10c93          	addi	s9,sp,12
ffffffffc020a1bc:	8762                	mv	a4,s8
ffffffffc020a1be:	86d2                	mv	a3,s4
ffffffffc020a1c0:	4611                	li	a2,4
ffffffffc020a1c2:	85e6                	mv	a1,s9
ffffffffc020a1c4:	7d1000ef          	jal	ra,ffffffffc020b194 <sfs_rbuf>
ffffffffc020a1c8:	892a                	mv	s2,a0
ffffffffc020a1ca:	f159                	bnez	a0,ffffffffc020a150 <sfs_bmap_load_nolock+0xe6>
ffffffffc020a1cc:	45b2                	lw	a1,12(sp)
ffffffffc020a1ce:	e995                	bnez	a1,ffffffffc020a202 <sfs_bmap_load_nolock+0x198>
ffffffffc020a1d0:	fa8b85e3          	beq	s7,s0,ffffffffc020a17a <sfs_bmap_load_nolock+0x110>
ffffffffc020a1d4:	03cb2703          	lw	a4,60(s6)
ffffffffc020a1d8:	47a2                	lw	a5,8(sp)
ffffffffc020a1da:	c202                	sw	zero,4(sp)
ffffffffc020a1dc:	eee784e3          	beq	a5,a4,ffffffffc020a0c4 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a1e0:	e34d                	bnez	a4,ffffffffc020a282 <sfs_bmap_load_nolock+0x218>
ffffffffc020a1e2:	02fb2e23          	sw	a5,60(s6)
ffffffffc020a1e6:	4785                	li	a5,1
ffffffffc020a1e8:	00fab823          	sd	a5,16(s5)
ffffffffc020a1ec:	bde1                	j	ffffffffc020a0c4 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a1ee:	8526                	mv	a0,s1
ffffffffc020a1f0:	bc1ff0ef          	jal	ra,ffffffffc0209db0 <sfs_block_free>
ffffffffc020a1f4:	45a2                	lw	a1,8(sp)
ffffffffc020a1f6:	f4ba0de3          	beq	s4,a1,ffffffffc020a150 <sfs_bmap_load_nolock+0xe6>
ffffffffc020a1fa:	8526                	mv	a0,s1
ffffffffc020a1fc:	bb5ff0ef          	jal	ra,ffffffffc0209db0 <sfs_block_free>
ffffffffc020a200:	bf81                	j	ffffffffc020a150 <sfs_bmap_load_nolock+0xe6>
ffffffffc020a202:	03cb2683          	lw	a3,60(s6)
ffffffffc020a206:	4722                	lw	a4,8(sp)
ffffffffc020a208:	c22e                	sw	a1,4(sp)
ffffffffc020a20a:	f8e69ee3          	bne	a3,a4,ffffffffc020a1a6 <sfs_bmap_load_nolock+0x13c>
ffffffffc020a20e:	b709                	j	ffffffffc020a110 <sfs_bmap_load_nolock+0xa6>
ffffffffc020a210:	00005697          	auipc	a3,0x5
ffffffffc020a214:	1d068693          	addi	a3,a3,464 # ffffffffc020f3e0 <dev_node_ops+0x6a8>
ffffffffc020a218:	00002617          	auipc	a2,0x2
ffffffffc020a21c:	be860613          	addi	a2,a2,-1048 # ffffffffc020be00 <commands+0x210>
ffffffffc020a220:	16400593          	li	a1,356
ffffffffc020a224:	00005517          	auipc	a0,0x5
ffffffffc020a228:	0d450513          	addi	a0,a0,212 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a22c:	a72f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a230:	872e                	mv	a4,a1
ffffffffc020a232:	00005617          	auipc	a2,0x5
ffffffffc020a236:	0f660613          	addi	a2,a2,246 # ffffffffc020f328 <dev_node_ops+0x5f0>
ffffffffc020a23a:	05300593          	li	a1,83
ffffffffc020a23e:	00005517          	auipc	a0,0x5
ffffffffc020a242:	0ba50513          	addi	a0,a0,186 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a246:	a58f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a24a:	00005617          	auipc	a2,0x5
ffffffffc020a24e:	1c660613          	addi	a2,a2,454 # ffffffffc020f410 <dev_node_ops+0x6d8>
ffffffffc020a252:	11e00593          	li	a1,286
ffffffffc020a256:	00005517          	auipc	a0,0x5
ffffffffc020a25a:	0a250513          	addi	a0,a0,162 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a25e:	a40f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a262:	00005697          	auipc	a3,0x5
ffffffffc020a266:	0fe68693          	addi	a3,a3,254 # ffffffffc020f360 <dev_node_ops+0x628>
ffffffffc020a26a:	00002617          	auipc	a2,0x2
ffffffffc020a26e:	b9660613          	addi	a2,a2,-1130 # ffffffffc020be00 <commands+0x210>
ffffffffc020a272:	16b00593          	li	a1,363
ffffffffc020a276:	00005517          	auipc	a0,0x5
ffffffffc020a27a:	08250513          	addi	a0,a0,130 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a27e:	a20f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a282:	00005697          	auipc	a3,0x5
ffffffffc020a286:	17668693          	addi	a3,a3,374 # ffffffffc020f3f8 <dev_node_ops+0x6c0>
ffffffffc020a28a:	00002617          	auipc	a2,0x2
ffffffffc020a28e:	b7660613          	addi	a2,a2,-1162 # ffffffffc020be00 <commands+0x210>
ffffffffc020a292:	11800593          	li	a1,280
ffffffffc020a296:	00005517          	auipc	a0,0x5
ffffffffc020a29a:	06250513          	addi	a0,a0,98 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a29e:	a00f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a2a2:	00005697          	auipc	a3,0x5
ffffffffc020a2a6:	19e68693          	addi	a3,a3,414 # ffffffffc020f440 <dev_node_ops+0x708>
ffffffffc020a2aa:	00002617          	auipc	a2,0x2
ffffffffc020a2ae:	b5660613          	addi	a2,a2,-1194 # ffffffffc020be00 <commands+0x210>
ffffffffc020a2b2:	12100593          	li	a1,289
ffffffffc020a2b6:	00005517          	auipc	a0,0x5
ffffffffc020a2ba:	04250513          	addi	a0,a0,66 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a2be:	9e0f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a2c2 <sfs_io_nolock>:
ffffffffc020a2c2:	7119                	addi	sp,sp,-128
ffffffffc020a2c4:	e4d6                	sd	s5,72(sp)
ffffffffc020a2c6:	8aae                	mv	s5,a1
ffffffffc020a2c8:	618c                	ld	a1,0(a1)
ffffffffc020a2ca:	fc86                	sd	ra,120(sp)
ffffffffc020a2cc:	f8a2                	sd	s0,112(sp)
ffffffffc020a2ce:	0045d883          	lhu	a7,4(a1)
ffffffffc020a2d2:	f4a6                	sd	s1,104(sp)
ffffffffc020a2d4:	f0ca                	sd	s2,96(sp)
ffffffffc020a2d6:	ecce                	sd	s3,88(sp)
ffffffffc020a2d8:	e8d2                	sd	s4,80(sp)
ffffffffc020a2da:	e0da                	sd	s6,64(sp)
ffffffffc020a2dc:	fc5e                	sd	s7,56(sp)
ffffffffc020a2de:	f862                	sd	s8,48(sp)
ffffffffc020a2e0:	f466                	sd	s9,40(sp)
ffffffffc020a2e2:	f06a                	sd	s10,32(sp)
ffffffffc020a2e4:	ec6e                	sd	s11,24(sp)
ffffffffc020a2e6:	4809                	li	a6,2
ffffffffc020a2e8:	19088163          	beq	a7,a6,ffffffffc020a46a <sfs_io_nolock+0x1a8>
ffffffffc020a2ec:	00073b03          	ld	s6,0(a4) # 4000 <_binary_bin_swap_img_size-0x3d00>
ffffffffc020a2f0:	8bba                	mv	s7,a4
ffffffffc020a2f2:	000bb023          	sd	zero,0(s7) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020a2f6:	08000737          	lui	a4,0x8000
ffffffffc020a2fa:	8d36                	mv	s10,a3
ffffffffc020a2fc:	8a36                	mv	s4,a3
ffffffffc020a2fe:	9b36                	add	s6,s6,a3
ffffffffc020a300:	16e6f363          	bgeu	a3,a4,ffffffffc020a466 <sfs_io_nolock+0x1a4>
ffffffffc020a304:	16db4163          	blt	s6,a3,ffffffffc020a466 <sfs_io_nolock+0x1a4>
ffffffffc020a308:	892a                	mv	s2,a0
ffffffffc020a30a:	4501                	li	a0,0
ffffffffc020a30c:	0d668963          	beq	a3,s6,ffffffffc020a3de <sfs_io_nolock+0x11c>
ffffffffc020a310:	8db2                	mv	s11,a2
ffffffffc020a312:	01677463          	bgeu	a4,s6,ffffffffc020a31a <sfs_io_nolock+0x58>
ffffffffc020a316:	08000b37          	lui	s6,0x8000
ffffffffc020a31a:	c3ed                	beqz	a5,ffffffffc020a3fc <sfs_io_nolock+0x13a>
ffffffffc020a31c:	00001c17          	auipc	s8,0x1
ffffffffc020a320:	e18c0c13          	addi	s8,s8,-488 # ffffffffc020b134 <sfs_wblock>
ffffffffc020a324:	00001c97          	auipc	s9,0x1
ffffffffc020a328:	ef0c8c93          	addi	s9,s9,-272 # ffffffffc020b214 <sfs_wbuf>
ffffffffc020a32c:	6785                	lui	a5,0x1
ffffffffc020a32e:	fff78493          	addi	s1,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc020a332:	40cd5413          	srai	s0,s10,0xc
ffffffffc020a336:	009d74b3          	and	s1,s10,s1
ffffffffc020a33a:	2401                	sext.w	s0,s0
ffffffffc020a33c:	89a6                	mv	s3,s1
ffffffffc020a33e:	c89d                	beqz	s1,ffffffffc020a374 <sfs_io_nolock+0xb2>
ffffffffc020a340:	40cb5713          	srai	a4,s6,0xc
ffffffffc020a344:	2701                	sext.w	a4,a4
ffffffffc020a346:	41ab09b3          	sub	s3,s6,s10
ffffffffc020a34a:	00870463          	beq	a4,s0,ffffffffc020a352 <sfs_io_nolock+0x90>
ffffffffc020a34e:	409789b3          	sub	s3,a5,s1
ffffffffc020a352:	0074                	addi	a3,sp,12
ffffffffc020a354:	8622                	mv	a2,s0
ffffffffc020a356:	85d6                	mv	a1,s5
ffffffffc020a358:	854a                	mv	a0,s2
ffffffffc020a35a:	d11ff0ef          	jal	ra,ffffffffc020a06a <sfs_bmap_load_nolock>
ffffffffc020a35e:	e969                	bnez	a0,ffffffffc020a430 <sfs_io_nolock+0x16e>
ffffffffc020a360:	46b2                	lw	a3,12(sp)
ffffffffc020a362:	8726                	mv	a4,s1
ffffffffc020a364:	864e                	mv	a2,s3
ffffffffc020a366:	85ee                	mv	a1,s11
ffffffffc020a368:	854a                	mv	a0,s2
ffffffffc020a36a:	9c82                	jalr	s9
ffffffffc020a36c:	e171                	bnez	a0,ffffffffc020a430 <sfs_io_nolock+0x16e>
ffffffffc020a36e:	9dce                	add	s11,s11,s3
ffffffffc020a370:	9d4e                	add	s10,s10,s3
ffffffffc020a372:	2405                	addiw	s0,s0,1
ffffffffc020a374:	6785                	lui	a5,0x1
ffffffffc020a376:	fff78713          	addi	a4,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc020a37a:	976a                	add	a4,a4,s10
ffffffffc020a37c:	0b675c63          	bge	a4,s6,ffffffffc020a434 <sfs_io_nolock+0x172>
ffffffffc020a380:	40fb0a33          	sub	s4,s6,a5
ffffffffc020a384:	41aa0a33          	sub	s4,s4,s10
ffffffffc020a388:	00ca5a13          	srli	s4,s4,0xc
ffffffffc020a38c:	0a05                	addi	s4,s4,1
ffffffffc020a38e:	0a32                	slli	s4,s4,0xc
ffffffffc020a390:	9a6e                	add	s4,s4,s11
ffffffffc020a392:	6485                	lui	s1,0x1
ffffffffc020a394:	a829                	j	ffffffffc020a3ae <sfs_io_nolock+0xec>
ffffffffc020a396:	4632                	lw	a2,12(sp)
ffffffffc020a398:	4685                	li	a3,1
ffffffffc020a39a:	85ee                	mv	a1,s11
ffffffffc020a39c:	854a                	mv	a0,s2
ffffffffc020a39e:	9c02                	jalr	s8
ffffffffc020a3a0:	ed11                	bnez	a0,ffffffffc020a3bc <sfs_io_nolock+0xfa>
ffffffffc020a3a2:	9da6                	add	s11,s11,s1
ffffffffc020a3a4:	9d26                	add	s10,s10,s1
ffffffffc020a3a6:	99a6                	add	s3,s3,s1
ffffffffc020a3a8:	2405                	addiw	s0,s0,1
ffffffffc020a3aa:	09ba0663          	beq	s4,s11,ffffffffc020a436 <sfs_io_nolock+0x174>
ffffffffc020a3ae:	0074                	addi	a3,sp,12
ffffffffc020a3b0:	8622                	mv	a2,s0
ffffffffc020a3b2:	85d6                	mv	a1,s5
ffffffffc020a3b4:	854a                	mv	a0,s2
ffffffffc020a3b6:	cb5ff0ef          	jal	ra,ffffffffc020a06a <sfs_bmap_load_nolock>
ffffffffc020a3ba:	dd71                	beqz	a0,ffffffffc020a396 <sfs_io_nolock+0xd4>
ffffffffc020a3bc:	01a98a33          	add	s4,s3,s10
ffffffffc020a3c0:	000ab783          	ld	a5,0(s5)
ffffffffc020a3c4:	013bb023          	sd	s3,0(s7)
ffffffffc020a3c8:	0007e703          	lwu	a4,0(a5)
ffffffffc020a3cc:	01477963          	bgeu	a4,s4,ffffffffc020a3de <sfs_io_nolock+0x11c>
ffffffffc020a3d0:	013d09bb          	addw	s3,s10,s3
ffffffffc020a3d4:	0137a023          	sw	s3,0(a5)
ffffffffc020a3d8:	4785                	li	a5,1
ffffffffc020a3da:	00fab823          	sd	a5,16(s5)
ffffffffc020a3de:	70e6                	ld	ra,120(sp)
ffffffffc020a3e0:	7446                	ld	s0,112(sp)
ffffffffc020a3e2:	74a6                	ld	s1,104(sp)
ffffffffc020a3e4:	7906                	ld	s2,96(sp)
ffffffffc020a3e6:	69e6                	ld	s3,88(sp)
ffffffffc020a3e8:	6a46                	ld	s4,80(sp)
ffffffffc020a3ea:	6aa6                	ld	s5,72(sp)
ffffffffc020a3ec:	6b06                	ld	s6,64(sp)
ffffffffc020a3ee:	7be2                	ld	s7,56(sp)
ffffffffc020a3f0:	7c42                	ld	s8,48(sp)
ffffffffc020a3f2:	7ca2                	ld	s9,40(sp)
ffffffffc020a3f4:	7d02                	ld	s10,32(sp)
ffffffffc020a3f6:	6de2                	ld	s11,24(sp)
ffffffffc020a3f8:	6109                	addi	sp,sp,128
ffffffffc020a3fa:	8082                	ret
ffffffffc020a3fc:	0005e783          	lwu	a5,0(a1)
ffffffffc020a400:	4501                	li	a0,0
ffffffffc020a402:	fcfd5ee3          	bge	s10,a5,ffffffffc020a3de <sfs_io_nolock+0x11c>
ffffffffc020a406:	0167cb63          	blt	a5,s6,ffffffffc020a41c <sfs_io_nolock+0x15a>
ffffffffc020a40a:	00001c17          	auipc	s8,0x1
ffffffffc020a40e:	ccac0c13          	addi	s8,s8,-822 # ffffffffc020b0d4 <sfs_rblock>
ffffffffc020a412:	00001c97          	auipc	s9,0x1
ffffffffc020a416:	d82c8c93          	addi	s9,s9,-638 # ffffffffc020b194 <sfs_rbuf>
ffffffffc020a41a:	bf09                	j	ffffffffc020a32c <sfs_io_nolock+0x6a>
ffffffffc020a41c:	8b3e                	mv	s6,a5
ffffffffc020a41e:	00001c17          	auipc	s8,0x1
ffffffffc020a422:	cb6c0c13          	addi	s8,s8,-842 # ffffffffc020b0d4 <sfs_rblock>
ffffffffc020a426:	00001c97          	auipc	s9,0x1
ffffffffc020a42a:	d6ec8c93          	addi	s9,s9,-658 # ffffffffc020b194 <sfs_rbuf>
ffffffffc020a42e:	bdfd                	j	ffffffffc020a32c <sfs_io_nolock+0x6a>
ffffffffc020a430:	4981                	li	s3,0
ffffffffc020a432:	b779                	j	ffffffffc020a3c0 <sfs_io_nolock+0xfe>
ffffffffc020a434:	8a6e                	mv	s4,s11
ffffffffc020a436:	016d4663          	blt	s10,s6,ffffffffc020a442 <sfs_io_nolock+0x180>
ffffffffc020a43a:	01a98a33          	add	s4,s3,s10
ffffffffc020a43e:	4501                	li	a0,0
ffffffffc020a440:	b741                	j	ffffffffc020a3c0 <sfs_io_nolock+0xfe>
ffffffffc020a442:	0074                	addi	a3,sp,12
ffffffffc020a444:	8622                	mv	a2,s0
ffffffffc020a446:	85d6                	mv	a1,s5
ffffffffc020a448:	854a                	mv	a0,s2
ffffffffc020a44a:	c21ff0ef          	jal	ra,ffffffffc020a06a <sfs_bmap_load_nolock>
ffffffffc020a44e:	f53d                	bnez	a0,ffffffffc020a3bc <sfs_io_nolock+0xfa>
ffffffffc020a450:	46b2                	lw	a3,12(sp)
ffffffffc020a452:	41ab0b33          	sub	s6,s6,s10
ffffffffc020a456:	4701                	li	a4,0
ffffffffc020a458:	865a                	mv	a2,s6
ffffffffc020a45a:	85d2                	mv	a1,s4
ffffffffc020a45c:	854a                	mv	a0,s2
ffffffffc020a45e:	9c82                	jalr	s9
ffffffffc020a460:	fd31                	bnez	a0,ffffffffc020a3bc <sfs_io_nolock+0xfa>
ffffffffc020a462:	99da                	add	s3,s3,s6
ffffffffc020a464:	bfa1                	j	ffffffffc020a3bc <sfs_io_nolock+0xfa>
ffffffffc020a466:	5575                	li	a0,-3
ffffffffc020a468:	bf9d                	j	ffffffffc020a3de <sfs_io_nolock+0x11c>
ffffffffc020a46a:	00005697          	auipc	a3,0x5
ffffffffc020a46e:	ffe68693          	addi	a3,a3,-2 # ffffffffc020f468 <dev_node_ops+0x730>
ffffffffc020a472:	00002617          	auipc	a2,0x2
ffffffffc020a476:	98e60613          	addi	a2,a2,-1650 # ffffffffc020be00 <commands+0x210>
ffffffffc020a47a:	22b00593          	li	a1,555
ffffffffc020a47e:	00005517          	auipc	a0,0x5
ffffffffc020a482:	e7a50513          	addi	a0,a0,-390 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a486:	818f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a48a <sfs_read>:
ffffffffc020a48a:	7139                	addi	sp,sp,-64
ffffffffc020a48c:	f04a                	sd	s2,32(sp)
ffffffffc020a48e:	06853903          	ld	s2,104(a0)
ffffffffc020a492:	fc06                	sd	ra,56(sp)
ffffffffc020a494:	f822                	sd	s0,48(sp)
ffffffffc020a496:	f426                	sd	s1,40(sp)
ffffffffc020a498:	ec4e                	sd	s3,24(sp)
ffffffffc020a49a:	04090f63          	beqz	s2,ffffffffc020a4f8 <sfs_read+0x6e>
ffffffffc020a49e:	0b092783          	lw	a5,176(s2)
ffffffffc020a4a2:	ebb9                	bnez	a5,ffffffffc020a4f8 <sfs_read+0x6e>
ffffffffc020a4a4:	4d38                	lw	a4,88(a0)
ffffffffc020a4a6:	6785                	lui	a5,0x1
ffffffffc020a4a8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a4ac:	842a                	mv	s0,a0
ffffffffc020a4ae:	06f71563          	bne	a4,a5,ffffffffc020a518 <sfs_read+0x8e>
ffffffffc020a4b2:	02050993          	addi	s3,a0,32
ffffffffc020a4b6:	854e                	mv	a0,s3
ffffffffc020a4b8:	84ae                	mv	s1,a1
ffffffffc020a4ba:	942fa0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a4be:	0184b803          	ld	a6,24(s1) # 1018 <_binary_bin_swap_img_size-0x6ce8>
ffffffffc020a4c2:	6494                	ld	a3,8(s1)
ffffffffc020a4c4:	6090                	ld	a2,0(s1)
ffffffffc020a4c6:	85a2                	mv	a1,s0
ffffffffc020a4c8:	4781                	li	a5,0
ffffffffc020a4ca:	0038                	addi	a4,sp,8
ffffffffc020a4cc:	854a                	mv	a0,s2
ffffffffc020a4ce:	e442                	sd	a6,8(sp)
ffffffffc020a4d0:	df3ff0ef          	jal	ra,ffffffffc020a2c2 <sfs_io_nolock>
ffffffffc020a4d4:	65a2                	ld	a1,8(sp)
ffffffffc020a4d6:	842a                	mv	s0,a0
ffffffffc020a4d8:	ed81                	bnez	a1,ffffffffc020a4f0 <sfs_read+0x66>
ffffffffc020a4da:	854e                	mv	a0,s3
ffffffffc020a4dc:	91cfa0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a4e0:	70e2                	ld	ra,56(sp)
ffffffffc020a4e2:	8522                	mv	a0,s0
ffffffffc020a4e4:	7442                	ld	s0,48(sp)
ffffffffc020a4e6:	74a2                	ld	s1,40(sp)
ffffffffc020a4e8:	7902                	ld	s2,32(sp)
ffffffffc020a4ea:	69e2                	ld	s3,24(sp)
ffffffffc020a4ec:	6121                	addi	sp,sp,64
ffffffffc020a4ee:	8082                	ret
ffffffffc020a4f0:	8526                	mv	a0,s1
ffffffffc020a4f2:	ffffa0ef          	jal	ra,ffffffffc02054f0 <iobuf_skip>
ffffffffc020a4f6:	b7d5                	j	ffffffffc020a4da <sfs_read+0x50>
ffffffffc020a4f8:	00005697          	auipc	a3,0x5
ffffffffc020a4fc:	c2068693          	addi	a3,a3,-992 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc020a500:	00002617          	auipc	a2,0x2
ffffffffc020a504:	90060613          	addi	a2,a2,-1792 # ffffffffc020be00 <commands+0x210>
ffffffffc020a508:	29c00593          	li	a1,668
ffffffffc020a50c:	00005517          	auipc	a0,0x5
ffffffffc020a510:	dec50513          	addi	a0,a0,-532 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a514:	f8bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a518:	875ff0ef          	jal	ra,ffffffffc0209d8c <sfs_io.part.0>

ffffffffc020a51c <sfs_write>:
ffffffffc020a51c:	7139                	addi	sp,sp,-64
ffffffffc020a51e:	f04a                	sd	s2,32(sp)
ffffffffc020a520:	06853903          	ld	s2,104(a0)
ffffffffc020a524:	fc06                	sd	ra,56(sp)
ffffffffc020a526:	f822                	sd	s0,48(sp)
ffffffffc020a528:	f426                	sd	s1,40(sp)
ffffffffc020a52a:	ec4e                	sd	s3,24(sp)
ffffffffc020a52c:	04090f63          	beqz	s2,ffffffffc020a58a <sfs_write+0x6e>
ffffffffc020a530:	0b092783          	lw	a5,176(s2)
ffffffffc020a534:	ebb9                	bnez	a5,ffffffffc020a58a <sfs_write+0x6e>
ffffffffc020a536:	4d38                	lw	a4,88(a0)
ffffffffc020a538:	6785                	lui	a5,0x1
ffffffffc020a53a:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a53e:	842a                	mv	s0,a0
ffffffffc020a540:	06f71563          	bne	a4,a5,ffffffffc020a5aa <sfs_write+0x8e>
ffffffffc020a544:	02050993          	addi	s3,a0,32
ffffffffc020a548:	854e                	mv	a0,s3
ffffffffc020a54a:	84ae                	mv	s1,a1
ffffffffc020a54c:	8b0fa0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a550:	0184b803          	ld	a6,24(s1)
ffffffffc020a554:	6494                	ld	a3,8(s1)
ffffffffc020a556:	6090                	ld	a2,0(s1)
ffffffffc020a558:	85a2                	mv	a1,s0
ffffffffc020a55a:	4785                	li	a5,1
ffffffffc020a55c:	0038                	addi	a4,sp,8
ffffffffc020a55e:	854a                	mv	a0,s2
ffffffffc020a560:	e442                	sd	a6,8(sp)
ffffffffc020a562:	d61ff0ef          	jal	ra,ffffffffc020a2c2 <sfs_io_nolock>
ffffffffc020a566:	65a2                	ld	a1,8(sp)
ffffffffc020a568:	842a                	mv	s0,a0
ffffffffc020a56a:	ed81                	bnez	a1,ffffffffc020a582 <sfs_write+0x66>
ffffffffc020a56c:	854e                	mv	a0,s3
ffffffffc020a56e:	88afa0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a572:	70e2                	ld	ra,56(sp)
ffffffffc020a574:	8522                	mv	a0,s0
ffffffffc020a576:	7442                	ld	s0,48(sp)
ffffffffc020a578:	74a2                	ld	s1,40(sp)
ffffffffc020a57a:	7902                	ld	s2,32(sp)
ffffffffc020a57c:	69e2                	ld	s3,24(sp)
ffffffffc020a57e:	6121                	addi	sp,sp,64
ffffffffc020a580:	8082                	ret
ffffffffc020a582:	8526                	mv	a0,s1
ffffffffc020a584:	f6dfa0ef          	jal	ra,ffffffffc02054f0 <iobuf_skip>
ffffffffc020a588:	b7d5                	j	ffffffffc020a56c <sfs_write+0x50>
ffffffffc020a58a:	00005697          	auipc	a3,0x5
ffffffffc020a58e:	b8e68693          	addi	a3,a3,-1138 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc020a592:	00002617          	auipc	a2,0x2
ffffffffc020a596:	86e60613          	addi	a2,a2,-1938 # ffffffffc020be00 <commands+0x210>
ffffffffc020a59a:	29c00593          	li	a1,668
ffffffffc020a59e:	00005517          	auipc	a0,0x5
ffffffffc020a5a2:	d5a50513          	addi	a0,a0,-678 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a5a6:	ef9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a5aa:	fe2ff0ef          	jal	ra,ffffffffc0209d8c <sfs_io.part.0>

ffffffffc020a5ae <sfs_dirent_read_nolock>:
ffffffffc020a5ae:	6198                	ld	a4,0(a1)
ffffffffc020a5b0:	7179                	addi	sp,sp,-48
ffffffffc020a5b2:	f406                	sd	ra,40(sp)
ffffffffc020a5b4:	00475883          	lhu	a7,4(a4) # 8000004 <_binary_bin_sfs_img_size+0x7f8ad04>
ffffffffc020a5b8:	f022                	sd	s0,32(sp)
ffffffffc020a5ba:	ec26                	sd	s1,24(sp)
ffffffffc020a5bc:	4809                	li	a6,2
ffffffffc020a5be:	05089b63          	bne	a7,a6,ffffffffc020a614 <sfs_dirent_read_nolock+0x66>
ffffffffc020a5c2:	4718                	lw	a4,8(a4)
ffffffffc020a5c4:	87b2                	mv	a5,a2
ffffffffc020a5c6:	2601                	sext.w	a2,a2
ffffffffc020a5c8:	04e7f663          	bgeu	a5,a4,ffffffffc020a614 <sfs_dirent_read_nolock+0x66>
ffffffffc020a5cc:	84b6                	mv	s1,a3
ffffffffc020a5ce:	0074                	addi	a3,sp,12
ffffffffc020a5d0:	842a                	mv	s0,a0
ffffffffc020a5d2:	a99ff0ef          	jal	ra,ffffffffc020a06a <sfs_bmap_load_nolock>
ffffffffc020a5d6:	c511                	beqz	a0,ffffffffc020a5e2 <sfs_dirent_read_nolock+0x34>
ffffffffc020a5d8:	70a2                	ld	ra,40(sp)
ffffffffc020a5da:	7402                	ld	s0,32(sp)
ffffffffc020a5dc:	64e2                	ld	s1,24(sp)
ffffffffc020a5de:	6145                	addi	sp,sp,48
ffffffffc020a5e0:	8082                	ret
ffffffffc020a5e2:	45b2                	lw	a1,12(sp)
ffffffffc020a5e4:	4054                	lw	a3,4(s0)
ffffffffc020a5e6:	c5b9                	beqz	a1,ffffffffc020a634 <sfs_dirent_read_nolock+0x86>
ffffffffc020a5e8:	04d5f663          	bgeu	a1,a3,ffffffffc020a634 <sfs_dirent_read_nolock+0x86>
ffffffffc020a5ec:	7c08                	ld	a0,56(s0)
ffffffffc020a5ee:	eb5fe0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc020a5f2:	ed31                	bnez	a0,ffffffffc020a64e <sfs_dirent_read_nolock+0xa0>
ffffffffc020a5f4:	46b2                	lw	a3,12(sp)
ffffffffc020a5f6:	4701                	li	a4,0
ffffffffc020a5f8:	10400613          	li	a2,260
ffffffffc020a5fc:	85a6                	mv	a1,s1
ffffffffc020a5fe:	8522                	mv	a0,s0
ffffffffc020a600:	395000ef          	jal	ra,ffffffffc020b194 <sfs_rbuf>
ffffffffc020a604:	f971                	bnez	a0,ffffffffc020a5d8 <sfs_dirent_read_nolock+0x2a>
ffffffffc020a606:	100481a3          	sb	zero,259(s1)
ffffffffc020a60a:	70a2                	ld	ra,40(sp)
ffffffffc020a60c:	7402                	ld	s0,32(sp)
ffffffffc020a60e:	64e2                	ld	s1,24(sp)
ffffffffc020a610:	6145                	addi	sp,sp,48
ffffffffc020a612:	8082                	ret
ffffffffc020a614:	00005697          	auipc	a3,0x5
ffffffffc020a618:	e7468693          	addi	a3,a3,-396 # ffffffffc020f488 <dev_node_ops+0x750>
ffffffffc020a61c:	00001617          	auipc	a2,0x1
ffffffffc020a620:	7e460613          	addi	a2,a2,2020 # ffffffffc020be00 <commands+0x210>
ffffffffc020a624:	18e00593          	li	a1,398
ffffffffc020a628:	00005517          	auipc	a0,0x5
ffffffffc020a62c:	cd050513          	addi	a0,a0,-816 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a630:	e6ff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a634:	872e                	mv	a4,a1
ffffffffc020a636:	00005617          	auipc	a2,0x5
ffffffffc020a63a:	cf260613          	addi	a2,a2,-782 # ffffffffc020f328 <dev_node_ops+0x5f0>
ffffffffc020a63e:	05300593          	li	a1,83
ffffffffc020a642:	00005517          	auipc	a0,0x5
ffffffffc020a646:	cb650513          	addi	a0,a0,-842 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a64a:	e55f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a64e:	00005697          	auipc	a3,0x5
ffffffffc020a652:	d1268693          	addi	a3,a3,-750 # ffffffffc020f360 <dev_node_ops+0x628>
ffffffffc020a656:	00001617          	auipc	a2,0x1
ffffffffc020a65a:	7aa60613          	addi	a2,a2,1962 # ffffffffc020be00 <commands+0x210>
ffffffffc020a65e:	19500593          	li	a1,405
ffffffffc020a662:	00005517          	auipc	a0,0x5
ffffffffc020a666:	c9650513          	addi	a0,a0,-874 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a66a:	e35f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a66e <sfs_getdirentry>:
ffffffffc020a66e:	715d                	addi	sp,sp,-80
ffffffffc020a670:	ec56                	sd	s5,24(sp)
ffffffffc020a672:	8aaa                	mv	s5,a0
ffffffffc020a674:	10400513          	li	a0,260
ffffffffc020a678:	e85a                	sd	s6,16(sp)
ffffffffc020a67a:	e486                	sd	ra,72(sp)
ffffffffc020a67c:	e0a2                	sd	s0,64(sp)
ffffffffc020a67e:	fc26                	sd	s1,56(sp)
ffffffffc020a680:	f84a                	sd	s2,48(sp)
ffffffffc020a682:	f44e                	sd	s3,40(sp)
ffffffffc020a684:	f052                	sd	s4,32(sp)
ffffffffc020a686:	e45e                	sd	s7,8(sp)
ffffffffc020a688:	e062                	sd	s8,0(sp)
ffffffffc020a68a:	8b2e                	mv	s6,a1
ffffffffc020a68c:	997f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020a690:	cd61                	beqz	a0,ffffffffc020a768 <sfs_getdirentry+0xfa>
ffffffffc020a692:	068abb83          	ld	s7,104(s5)
ffffffffc020a696:	0c0b8b63          	beqz	s7,ffffffffc020a76c <sfs_getdirentry+0xfe>
ffffffffc020a69a:	0b0ba783          	lw	a5,176(s7)
ffffffffc020a69e:	e7f9                	bnez	a5,ffffffffc020a76c <sfs_getdirentry+0xfe>
ffffffffc020a6a0:	058aa703          	lw	a4,88(s5)
ffffffffc020a6a4:	6785                	lui	a5,0x1
ffffffffc020a6a6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a6aa:	0ef71163          	bne	a4,a5,ffffffffc020a78c <sfs_getdirentry+0x11e>
ffffffffc020a6ae:	008b3983          	ld	s3,8(s6) # 8000008 <_binary_bin_sfs_img_size+0x7f8ad08>
ffffffffc020a6b2:	892a                	mv	s2,a0
ffffffffc020a6b4:	0a09c163          	bltz	s3,ffffffffc020a756 <sfs_getdirentry+0xe8>
ffffffffc020a6b8:	0ff9f793          	zext.b	a5,s3
ffffffffc020a6bc:	efc9                	bnez	a5,ffffffffc020a756 <sfs_getdirentry+0xe8>
ffffffffc020a6be:	000ab783          	ld	a5,0(s5)
ffffffffc020a6c2:	0089d993          	srli	s3,s3,0x8
ffffffffc020a6c6:	2981                	sext.w	s3,s3
ffffffffc020a6c8:	479c                	lw	a5,8(a5)
ffffffffc020a6ca:	0937eb63          	bltu	a5,s3,ffffffffc020a760 <sfs_getdirentry+0xf2>
ffffffffc020a6ce:	020a8c13          	addi	s8,s5,32
ffffffffc020a6d2:	8562                	mv	a0,s8
ffffffffc020a6d4:	f29f90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a6d8:	000ab783          	ld	a5,0(s5)
ffffffffc020a6dc:	0087aa03          	lw	s4,8(a5)
ffffffffc020a6e0:	07405663          	blez	s4,ffffffffc020a74c <sfs_getdirentry+0xde>
ffffffffc020a6e4:	4481                	li	s1,0
ffffffffc020a6e6:	a811                	j	ffffffffc020a6fa <sfs_getdirentry+0x8c>
ffffffffc020a6e8:	00092783          	lw	a5,0(s2)
ffffffffc020a6ec:	c781                	beqz	a5,ffffffffc020a6f4 <sfs_getdirentry+0x86>
ffffffffc020a6ee:	02098263          	beqz	s3,ffffffffc020a712 <sfs_getdirentry+0xa4>
ffffffffc020a6f2:	39fd                	addiw	s3,s3,-1
ffffffffc020a6f4:	2485                	addiw	s1,s1,1
ffffffffc020a6f6:	049a0b63          	beq	s4,s1,ffffffffc020a74c <sfs_getdirentry+0xde>
ffffffffc020a6fa:	86ca                	mv	a3,s2
ffffffffc020a6fc:	8626                	mv	a2,s1
ffffffffc020a6fe:	85d6                	mv	a1,s5
ffffffffc020a700:	855e                	mv	a0,s7
ffffffffc020a702:	eadff0ef          	jal	ra,ffffffffc020a5ae <sfs_dirent_read_nolock>
ffffffffc020a706:	842a                	mv	s0,a0
ffffffffc020a708:	d165                	beqz	a0,ffffffffc020a6e8 <sfs_getdirentry+0x7a>
ffffffffc020a70a:	8562                	mv	a0,s8
ffffffffc020a70c:	eedf90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a710:	a831                	j	ffffffffc020a72c <sfs_getdirentry+0xbe>
ffffffffc020a712:	8562                	mv	a0,s8
ffffffffc020a714:	ee5f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a718:	4701                	li	a4,0
ffffffffc020a71a:	4685                	li	a3,1
ffffffffc020a71c:	10000613          	li	a2,256
ffffffffc020a720:	00490593          	addi	a1,s2,4
ffffffffc020a724:	855a                	mv	a0,s6
ffffffffc020a726:	d5ffa0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc020a72a:	842a                	mv	s0,a0
ffffffffc020a72c:	854a                	mv	a0,s2
ffffffffc020a72e:	9a5f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a732:	60a6                	ld	ra,72(sp)
ffffffffc020a734:	8522                	mv	a0,s0
ffffffffc020a736:	6406                	ld	s0,64(sp)
ffffffffc020a738:	74e2                	ld	s1,56(sp)
ffffffffc020a73a:	7942                	ld	s2,48(sp)
ffffffffc020a73c:	79a2                	ld	s3,40(sp)
ffffffffc020a73e:	7a02                	ld	s4,32(sp)
ffffffffc020a740:	6ae2                	ld	s5,24(sp)
ffffffffc020a742:	6b42                	ld	s6,16(sp)
ffffffffc020a744:	6ba2                	ld	s7,8(sp)
ffffffffc020a746:	6c02                	ld	s8,0(sp)
ffffffffc020a748:	6161                	addi	sp,sp,80
ffffffffc020a74a:	8082                	ret
ffffffffc020a74c:	8562                	mv	a0,s8
ffffffffc020a74e:	5441                	li	s0,-16
ffffffffc020a750:	ea9f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a754:	bfe1                	j	ffffffffc020a72c <sfs_getdirentry+0xbe>
ffffffffc020a756:	854a                	mv	a0,s2
ffffffffc020a758:	97bf70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a75c:	5475                	li	s0,-3
ffffffffc020a75e:	bfd1                	j	ffffffffc020a732 <sfs_getdirentry+0xc4>
ffffffffc020a760:	973f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a764:	5441                	li	s0,-16
ffffffffc020a766:	b7f1                	j	ffffffffc020a732 <sfs_getdirentry+0xc4>
ffffffffc020a768:	5471                	li	s0,-4
ffffffffc020a76a:	b7e1                	j	ffffffffc020a732 <sfs_getdirentry+0xc4>
ffffffffc020a76c:	00005697          	auipc	a3,0x5
ffffffffc020a770:	9ac68693          	addi	a3,a3,-1620 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc020a774:	00001617          	auipc	a2,0x1
ffffffffc020a778:	68c60613          	addi	a2,a2,1676 # ffffffffc020be00 <commands+0x210>
ffffffffc020a77c:	34000593          	li	a1,832
ffffffffc020a780:	00005517          	auipc	a0,0x5
ffffffffc020a784:	b7850513          	addi	a0,a0,-1160 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a788:	d17f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a78c:	00005697          	auipc	a3,0x5
ffffffffc020a790:	b3468693          	addi	a3,a3,-1228 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc020a794:	00001617          	auipc	a2,0x1
ffffffffc020a798:	66c60613          	addi	a2,a2,1644 # ffffffffc020be00 <commands+0x210>
ffffffffc020a79c:	34100593          	li	a1,833
ffffffffc020a7a0:	00005517          	auipc	a0,0x5
ffffffffc020a7a4:	b5850513          	addi	a0,a0,-1192 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a7a8:	cf7f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a7ac <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a7ac:	715d                	addi	sp,sp,-80
ffffffffc020a7ae:	f052                	sd	s4,32(sp)
ffffffffc020a7b0:	8a2a                	mv	s4,a0
ffffffffc020a7b2:	8532                	mv	a0,a2
ffffffffc020a7b4:	f44e                	sd	s3,40(sp)
ffffffffc020a7b6:	e85a                	sd	s6,16(sp)
ffffffffc020a7b8:	e45e                	sd	s7,8(sp)
ffffffffc020a7ba:	e486                	sd	ra,72(sp)
ffffffffc020a7bc:	e0a2                	sd	s0,64(sp)
ffffffffc020a7be:	fc26                	sd	s1,56(sp)
ffffffffc020a7c0:	f84a                	sd	s2,48(sp)
ffffffffc020a7c2:	ec56                	sd	s5,24(sp)
ffffffffc020a7c4:	e062                	sd	s8,0(sp)
ffffffffc020a7c6:	8b32                	mv	s6,a2
ffffffffc020a7c8:	89ae                	mv	s3,a1
ffffffffc020a7ca:	8bb6                	mv	s7,a3
ffffffffc020a7cc:	0aa010ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc020a7d0:	0ff00793          	li	a5,255
ffffffffc020a7d4:	06a7ef63          	bltu	a5,a0,ffffffffc020a852 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a7d8:	10400513          	li	a0,260
ffffffffc020a7dc:	847f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020a7e0:	892a                	mv	s2,a0
ffffffffc020a7e2:	c535                	beqz	a0,ffffffffc020a84e <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a7e4:	0009b783          	ld	a5,0(s3)
ffffffffc020a7e8:	0087aa83          	lw	s5,8(a5)
ffffffffc020a7ec:	05505a63          	blez	s5,ffffffffc020a840 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a7f0:	4481                	li	s1,0
ffffffffc020a7f2:	00450c13          	addi	s8,a0,4
ffffffffc020a7f6:	a829                	j	ffffffffc020a810 <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a7f8:	00092783          	lw	a5,0(s2)
ffffffffc020a7fc:	c799                	beqz	a5,ffffffffc020a80a <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a7fe:	85e2                	mv	a1,s8
ffffffffc020a800:	855a                	mv	a0,s6
ffffffffc020a802:	0bc010ef          	jal	ra,ffffffffc020b8be <strcmp>
ffffffffc020a806:	842a                	mv	s0,a0
ffffffffc020a808:	cd15                	beqz	a0,ffffffffc020a844 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a80a:	2485                	addiw	s1,s1,1
ffffffffc020a80c:	029a8a63          	beq	s5,s1,ffffffffc020a840 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a810:	86ca                	mv	a3,s2
ffffffffc020a812:	8626                	mv	a2,s1
ffffffffc020a814:	85ce                	mv	a1,s3
ffffffffc020a816:	8552                	mv	a0,s4
ffffffffc020a818:	d97ff0ef          	jal	ra,ffffffffc020a5ae <sfs_dirent_read_nolock>
ffffffffc020a81c:	842a                	mv	s0,a0
ffffffffc020a81e:	dd69                	beqz	a0,ffffffffc020a7f8 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a820:	854a                	mv	a0,s2
ffffffffc020a822:	8b1f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a826:	60a6                	ld	ra,72(sp)
ffffffffc020a828:	8522                	mv	a0,s0
ffffffffc020a82a:	6406                	ld	s0,64(sp)
ffffffffc020a82c:	74e2                	ld	s1,56(sp)
ffffffffc020a82e:	7942                	ld	s2,48(sp)
ffffffffc020a830:	79a2                	ld	s3,40(sp)
ffffffffc020a832:	7a02                	ld	s4,32(sp)
ffffffffc020a834:	6ae2                	ld	s5,24(sp)
ffffffffc020a836:	6b42                	ld	s6,16(sp)
ffffffffc020a838:	6ba2                	ld	s7,8(sp)
ffffffffc020a83a:	6c02                	ld	s8,0(sp)
ffffffffc020a83c:	6161                	addi	sp,sp,80
ffffffffc020a83e:	8082                	ret
ffffffffc020a840:	5441                	li	s0,-16
ffffffffc020a842:	bff9                	j	ffffffffc020a820 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a844:	00092783          	lw	a5,0(s2)
ffffffffc020a848:	00fba023          	sw	a5,0(s7)
ffffffffc020a84c:	bfd1                	j	ffffffffc020a820 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a84e:	5471                	li	s0,-4
ffffffffc020a850:	bfd9                	j	ffffffffc020a826 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a852:	00005697          	auipc	a3,0x5
ffffffffc020a856:	c8668693          	addi	a3,a3,-890 # ffffffffc020f4d8 <dev_node_ops+0x7a0>
ffffffffc020a85a:	00001617          	auipc	a2,0x1
ffffffffc020a85e:	5a660613          	addi	a2,a2,1446 # ffffffffc020be00 <commands+0x210>
ffffffffc020a862:	1ba00593          	li	a1,442
ffffffffc020a866:	00005517          	auipc	a0,0x5
ffffffffc020a86a:	a9250513          	addi	a0,a0,-1390 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020a86e:	c31f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a872 <sfs_truncfile>:
ffffffffc020a872:	7175                	addi	sp,sp,-144
ffffffffc020a874:	e506                	sd	ra,136(sp)
ffffffffc020a876:	e122                	sd	s0,128(sp)
ffffffffc020a878:	fca6                	sd	s1,120(sp)
ffffffffc020a87a:	f8ca                	sd	s2,112(sp)
ffffffffc020a87c:	f4ce                	sd	s3,104(sp)
ffffffffc020a87e:	f0d2                	sd	s4,96(sp)
ffffffffc020a880:	ecd6                	sd	s5,88(sp)
ffffffffc020a882:	e8da                	sd	s6,80(sp)
ffffffffc020a884:	e4de                	sd	s7,72(sp)
ffffffffc020a886:	e0e2                	sd	s8,64(sp)
ffffffffc020a888:	fc66                	sd	s9,56(sp)
ffffffffc020a88a:	f86a                	sd	s10,48(sp)
ffffffffc020a88c:	f46e                	sd	s11,40(sp)
ffffffffc020a88e:	080007b7          	lui	a5,0x8000
ffffffffc020a892:	16b7e463          	bltu	a5,a1,ffffffffc020a9fa <sfs_truncfile+0x188>
ffffffffc020a896:	06853c83          	ld	s9,104(a0)
ffffffffc020a89a:	89aa                	mv	s3,a0
ffffffffc020a89c:	160c8163          	beqz	s9,ffffffffc020a9fe <sfs_truncfile+0x18c>
ffffffffc020a8a0:	0b0ca783          	lw	a5,176(s9)
ffffffffc020a8a4:	14079d63          	bnez	a5,ffffffffc020a9fe <sfs_truncfile+0x18c>
ffffffffc020a8a8:	4d38                	lw	a4,88(a0)
ffffffffc020a8aa:	6405                	lui	s0,0x1
ffffffffc020a8ac:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a8b0:	16f71763          	bne	a4,a5,ffffffffc020aa1e <sfs_truncfile+0x1ac>
ffffffffc020a8b4:	00053a83          	ld	s5,0(a0)
ffffffffc020a8b8:	147d                	addi	s0,s0,-1
ffffffffc020a8ba:	942e                	add	s0,s0,a1
ffffffffc020a8bc:	000ae783          	lwu	a5,0(s5)
ffffffffc020a8c0:	8031                	srli	s0,s0,0xc
ffffffffc020a8c2:	8a2e                	mv	s4,a1
ffffffffc020a8c4:	2401                	sext.w	s0,s0
ffffffffc020a8c6:	02b79763          	bne	a5,a1,ffffffffc020a8f4 <sfs_truncfile+0x82>
ffffffffc020a8ca:	008aa783          	lw	a5,8(s5)
ffffffffc020a8ce:	4901                	li	s2,0
ffffffffc020a8d0:	18879763          	bne	a5,s0,ffffffffc020aa5e <sfs_truncfile+0x1ec>
ffffffffc020a8d4:	60aa                	ld	ra,136(sp)
ffffffffc020a8d6:	640a                	ld	s0,128(sp)
ffffffffc020a8d8:	74e6                	ld	s1,120(sp)
ffffffffc020a8da:	79a6                	ld	s3,104(sp)
ffffffffc020a8dc:	7a06                	ld	s4,96(sp)
ffffffffc020a8de:	6ae6                	ld	s5,88(sp)
ffffffffc020a8e0:	6b46                	ld	s6,80(sp)
ffffffffc020a8e2:	6ba6                	ld	s7,72(sp)
ffffffffc020a8e4:	6c06                	ld	s8,64(sp)
ffffffffc020a8e6:	7ce2                	ld	s9,56(sp)
ffffffffc020a8e8:	7d42                	ld	s10,48(sp)
ffffffffc020a8ea:	7da2                	ld	s11,40(sp)
ffffffffc020a8ec:	854a                	mv	a0,s2
ffffffffc020a8ee:	7946                	ld	s2,112(sp)
ffffffffc020a8f0:	6149                	addi	sp,sp,144
ffffffffc020a8f2:	8082                	ret
ffffffffc020a8f4:	02050b13          	addi	s6,a0,32
ffffffffc020a8f8:	855a                	mv	a0,s6
ffffffffc020a8fa:	d03f90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a8fe:	008aa483          	lw	s1,8(s5)
ffffffffc020a902:	0a84e663          	bltu	s1,s0,ffffffffc020a9ae <sfs_truncfile+0x13c>
ffffffffc020a906:	0c947163          	bgeu	s0,s1,ffffffffc020a9c8 <sfs_truncfile+0x156>
ffffffffc020a90a:	4dad                	li	s11,11
ffffffffc020a90c:	4b85                	li	s7,1
ffffffffc020a90e:	a09d                	j	ffffffffc020a974 <sfs_truncfile+0x102>
ffffffffc020a910:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a914:	0009079b          	sext.w	a5,s2
ffffffffc020a918:	3ff00713          	li	a4,1023
ffffffffc020a91c:	04f76563          	bltu	a4,a5,ffffffffc020a966 <sfs_truncfile+0xf4>
ffffffffc020a920:	03cd2c03          	lw	s8,60(s10) # 103c <_binary_bin_swap_img_size-0x6cc4>
ffffffffc020a924:	040c0163          	beqz	s8,ffffffffc020a966 <sfs_truncfile+0xf4>
ffffffffc020a928:	004ca783          	lw	a5,4(s9)
ffffffffc020a92c:	18fc7963          	bgeu	s8,a5,ffffffffc020aabe <sfs_truncfile+0x24c>
ffffffffc020a930:	038cb503          	ld	a0,56(s9)
ffffffffc020a934:	85e2                	mv	a1,s8
ffffffffc020a936:	b6dfe0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc020a93a:	16051263          	bnez	a0,ffffffffc020aa9e <sfs_truncfile+0x22c>
ffffffffc020a93e:	02091793          	slli	a5,s2,0x20
ffffffffc020a942:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a946:	86e2                	mv	a3,s8
ffffffffc020a948:	4611                	li	a2,4
ffffffffc020a94a:	082c                	addi	a1,sp,24
ffffffffc020a94c:	8566                	mv	a0,s9
ffffffffc020a94e:	e43a                	sd	a4,8(sp)
ffffffffc020a950:	ce02                	sw	zero,28(sp)
ffffffffc020a952:	043000ef          	jal	ra,ffffffffc020b194 <sfs_rbuf>
ffffffffc020a956:	892a                	mv	s2,a0
ffffffffc020a958:	e141                	bnez	a0,ffffffffc020a9d8 <sfs_truncfile+0x166>
ffffffffc020a95a:	47e2                	lw	a5,24(sp)
ffffffffc020a95c:	6722                	ld	a4,8(sp)
ffffffffc020a95e:	e3c9                	bnez	a5,ffffffffc020a9e0 <sfs_truncfile+0x16e>
ffffffffc020a960:	008d2603          	lw	a2,8(s10)
ffffffffc020a964:	367d                	addiw	a2,a2,-1
ffffffffc020a966:	00cd2423          	sw	a2,8(s10)
ffffffffc020a96a:	0179b823          	sd	s7,16(s3)
ffffffffc020a96e:	34fd                	addiw	s1,s1,-1
ffffffffc020a970:	04940a63          	beq	s0,s1,ffffffffc020a9c4 <sfs_truncfile+0x152>
ffffffffc020a974:	0009bd03          	ld	s10,0(s3)
ffffffffc020a978:	008d2703          	lw	a4,8(s10)
ffffffffc020a97c:	c369                	beqz	a4,ffffffffc020aa3e <sfs_truncfile+0x1cc>
ffffffffc020a97e:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a982:	0007861b          	sext.w	a2,a5
ffffffffc020a986:	f8cde5e3          	bltu	s11,a2,ffffffffc020a910 <sfs_truncfile+0x9e>
ffffffffc020a98a:	02079713          	slli	a4,a5,0x20
ffffffffc020a98e:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a992:	00fd0933          	add	s2,s10,a5
ffffffffc020a996:	00c92583          	lw	a1,12(s2)
ffffffffc020a99a:	d5f1                	beqz	a1,ffffffffc020a966 <sfs_truncfile+0xf4>
ffffffffc020a99c:	8566                	mv	a0,s9
ffffffffc020a99e:	c12ff0ef          	jal	ra,ffffffffc0209db0 <sfs_block_free>
ffffffffc020a9a2:	00092623          	sw	zero,12(s2)
ffffffffc020a9a6:	008d2603          	lw	a2,8(s10)
ffffffffc020a9aa:	367d                	addiw	a2,a2,-1
ffffffffc020a9ac:	bf6d                	j	ffffffffc020a966 <sfs_truncfile+0xf4>
ffffffffc020a9ae:	4681                	li	a3,0
ffffffffc020a9b0:	8626                	mv	a2,s1
ffffffffc020a9b2:	85ce                	mv	a1,s3
ffffffffc020a9b4:	8566                	mv	a0,s9
ffffffffc020a9b6:	eb4ff0ef          	jal	ra,ffffffffc020a06a <sfs_bmap_load_nolock>
ffffffffc020a9ba:	892a                	mv	s2,a0
ffffffffc020a9bc:	ed11                	bnez	a0,ffffffffc020a9d8 <sfs_truncfile+0x166>
ffffffffc020a9be:	2485                	addiw	s1,s1,1
ffffffffc020a9c0:	fe9417e3          	bne	s0,s1,ffffffffc020a9ae <sfs_truncfile+0x13c>
ffffffffc020a9c4:	008aa483          	lw	s1,8(s5)
ffffffffc020a9c8:	0a941b63          	bne	s0,s1,ffffffffc020aa7e <sfs_truncfile+0x20c>
ffffffffc020a9cc:	014aa023          	sw	s4,0(s5)
ffffffffc020a9d0:	4785                	li	a5,1
ffffffffc020a9d2:	00f9b823          	sd	a5,16(s3)
ffffffffc020a9d6:	4901                	li	s2,0
ffffffffc020a9d8:	855a                	mv	a0,s6
ffffffffc020a9da:	c1ff90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a9de:	bddd                	j	ffffffffc020a8d4 <sfs_truncfile+0x62>
ffffffffc020a9e0:	86e2                	mv	a3,s8
ffffffffc020a9e2:	4611                	li	a2,4
ffffffffc020a9e4:	086c                	addi	a1,sp,28
ffffffffc020a9e6:	8566                	mv	a0,s9
ffffffffc020a9e8:	02d000ef          	jal	ra,ffffffffc020b214 <sfs_wbuf>
ffffffffc020a9ec:	892a                	mv	s2,a0
ffffffffc020a9ee:	f56d                	bnez	a0,ffffffffc020a9d8 <sfs_truncfile+0x166>
ffffffffc020a9f0:	45e2                	lw	a1,24(sp)
ffffffffc020a9f2:	8566                	mv	a0,s9
ffffffffc020a9f4:	bbcff0ef          	jal	ra,ffffffffc0209db0 <sfs_block_free>
ffffffffc020a9f8:	b7a5                	j	ffffffffc020a960 <sfs_truncfile+0xee>
ffffffffc020a9fa:	5975                	li	s2,-3
ffffffffc020a9fc:	bde1                	j	ffffffffc020a8d4 <sfs_truncfile+0x62>
ffffffffc020a9fe:	00004697          	auipc	a3,0x4
ffffffffc020aa02:	71a68693          	addi	a3,a3,1818 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc020aa06:	00001617          	auipc	a2,0x1
ffffffffc020aa0a:	3fa60613          	addi	a2,a2,1018 # ffffffffc020be00 <commands+0x210>
ffffffffc020aa0e:	3af00593          	li	a1,943
ffffffffc020aa12:	00005517          	auipc	a0,0x5
ffffffffc020aa16:	8e650513          	addi	a0,a0,-1818 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020aa1a:	a85f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa1e:	00005697          	auipc	a3,0x5
ffffffffc020aa22:	8a268693          	addi	a3,a3,-1886 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc020aa26:	00001617          	auipc	a2,0x1
ffffffffc020aa2a:	3da60613          	addi	a2,a2,986 # ffffffffc020be00 <commands+0x210>
ffffffffc020aa2e:	3b000593          	li	a1,944
ffffffffc020aa32:	00005517          	auipc	a0,0x5
ffffffffc020aa36:	8c650513          	addi	a0,a0,-1850 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020aa3a:	a65f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa3e:	00005697          	auipc	a3,0x5
ffffffffc020aa42:	ada68693          	addi	a3,a3,-1318 # ffffffffc020f518 <dev_node_ops+0x7e0>
ffffffffc020aa46:	00001617          	auipc	a2,0x1
ffffffffc020aa4a:	3ba60613          	addi	a2,a2,954 # ffffffffc020be00 <commands+0x210>
ffffffffc020aa4e:	17b00593          	li	a1,379
ffffffffc020aa52:	00005517          	auipc	a0,0x5
ffffffffc020aa56:	8a650513          	addi	a0,a0,-1882 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020aa5a:	a45f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa5e:	00005697          	auipc	a3,0x5
ffffffffc020aa62:	aa268693          	addi	a3,a3,-1374 # ffffffffc020f500 <dev_node_ops+0x7c8>
ffffffffc020aa66:	00001617          	auipc	a2,0x1
ffffffffc020aa6a:	39a60613          	addi	a2,a2,922 # ffffffffc020be00 <commands+0x210>
ffffffffc020aa6e:	3b700593          	li	a1,951
ffffffffc020aa72:	00005517          	auipc	a0,0x5
ffffffffc020aa76:	88650513          	addi	a0,a0,-1914 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020aa7a:	a25f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa7e:	00005697          	auipc	a3,0x5
ffffffffc020aa82:	aea68693          	addi	a3,a3,-1302 # ffffffffc020f568 <dev_node_ops+0x830>
ffffffffc020aa86:	00001617          	auipc	a2,0x1
ffffffffc020aa8a:	37a60613          	addi	a2,a2,890 # ffffffffc020be00 <commands+0x210>
ffffffffc020aa8e:	3d000593          	li	a1,976
ffffffffc020aa92:	00005517          	auipc	a0,0x5
ffffffffc020aa96:	86650513          	addi	a0,a0,-1946 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020aa9a:	a05f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa9e:	00005697          	auipc	a3,0x5
ffffffffc020aaa2:	a9268693          	addi	a3,a3,-1390 # ffffffffc020f530 <dev_node_ops+0x7f8>
ffffffffc020aaa6:	00001617          	auipc	a2,0x1
ffffffffc020aaaa:	35a60613          	addi	a2,a2,858 # ffffffffc020be00 <commands+0x210>
ffffffffc020aaae:	12b00593          	li	a1,299
ffffffffc020aab2:	00005517          	auipc	a0,0x5
ffffffffc020aab6:	84650513          	addi	a0,a0,-1978 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020aaba:	9e5f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aabe:	8762                	mv	a4,s8
ffffffffc020aac0:	86be                	mv	a3,a5
ffffffffc020aac2:	00005617          	auipc	a2,0x5
ffffffffc020aac6:	86660613          	addi	a2,a2,-1946 # ffffffffc020f328 <dev_node_ops+0x5f0>
ffffffffc020aaca:	05300593          	li	a1,83
ffffffffc020aace:	00005517          	auipc	a0,0x5
ffffffffc020aad2:	82a50513          	addi	a0,a0,-2006 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020aad6:	9c9f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aada <sfs_load_inode>:
ffffffffc020aada:	7139                	addi	sp,sp,-64
ffffffffc020aadc:	fc06                	sd	ra,56(sp)
ffffffffc020aade:	f822                	sd	s0,48(sp)
ffffffffc020aae0:	f426                	sd	s1,40(sp)
ffffffffc020aae2:	f04a                	sd	s2,32(sp)
ffffffffc020aae4:	84b2                	mv	s1,a2
ffffffffc020aae6:	892a                	mv	s2,a0
ffffffffc020aae8:	ec4e                	sd	s3,24(sp)
ffffffffc020aaea:	e852                	sd	s4,16(sp)
ffffffffc020aaec:	89ae                	mv	s3,a1
ffffffffc020aaee:	e456                	sd	s5,8(sp)
ffffffffc020aaf0:	0d5000ef          	jal	ra,ffffffffc020b3c4 <lock_sfs_fs>
ffffffffc020aaf4:	45a9                	li	a1,10
ffffffffc020aaf6:	8526                	mv	a0,s1
ffffffffc020aaf8:	0a893403          	ld	s0,168(s2)
ffffffffc020aafc:	0e9000ef          	jal	ra,ffffffffc020b3e4 <hash32>
ffffffffc020ab00:	02051793          	slli	a5,a0,0x20
ffffffffc020ab04:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020ab08:	9722                	add	a4,a4,s0
ffffffffc020ab0a:	843a                	mv	s0,a4
ffffffffc020ab0c:	a029                	j	ffffffffc020ab16 <sfs_load_inode+0x3c>
ffffffffc020ab0e:	fc042783          	lw	a5,-64(s0)
ffffffffc020ab12:	10978863          	beq	a5,s1,ffffffffc020ac22 <sfs_load_inode+0x148>
ffffffffc020ab16:	6400                	ld	s0,8(s0)
ffffffffc020ab18:	fe871be3          	bne	a4,s0,ffffffffc020ab0e <sfs_load_inode+0x34>
ffffffffc020ab1c:	04000513          	li	a0,64
ffffffffc020ab20:	d02f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020ab24:	8aaa                	mv	s5,a0
ffffffffc020ab26:	16050563          	beqz	a0,ffffffffc020ac90 <sfs_load_inode+0x1b6>
ffffffffc020ab2a:	00492683          	lw	a3,4(s2)
ffffffffc020ab2e:	18048363          	beqz	s1,ffffffffc020acb4 <sfs_load_inode+0x1da>
ffffffffc020ab32:	18d4f163          	bgeu	s1,a3,ffffffffc020acb4 <sfs_load_inode+0x1da>
ffffffffc020ab36:	03893503          	ld	a0,56(s2)
ffffffffc020ab3a:	85a6                	mv	a1,s1
ffffffffc020ab3c:	967fe0ef          	jal	ra,ffffffffc02094a2 <bitmap_test>
ffffffffc020ab40:	18051763          	bnez	a0,ffffffffc020acce <sfs_load_inode+0x1f4>
ffffffffc020ab44:	4701                	li	a4,0
ffffffffc020ab46:	86a6                	mv	a3,s1
ffffffffc020ab48:	04000613          	li	a2,64
ffffffffc020ab4c:	85d6                	mv	a1,s5
ffffffffc020ab4e:	854a                	mv	a0,s2
ffffffffc020ab50:	644000ef          	jal	ra,ffffffffc020b194 <sfs_rbuf>
ffffffffc020ab54:	842a                	mv	s0,a0
ffffffffc020ab56:	0e051563          	bnez	a0,ffffffffc020ac40 <sfs_load_inode+0x166>
ffffffffc020ab5a:	006ad783          	lhu	a5,6(s5)
ffffffffc020ab5e:	12078b63          	beqz	a5,ffffffffc020ac94 <sfs_load_inode+0x1ba>
ffffffffc020ab62:	6405                	lui	s0,0x1
ffffffffc020ab64:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ab68:	8f4fd0ef          	jal	ra,ffffffffc0207c5c <__alloc_inode>
ffffffffc020ab6c:	8a2a                	mv	s4,a0
ffffffffc020ab6e:	c961                	beqz	a0,ffffffffc020ac3e <sfs_load_inode+0x164>
ffffffffc020ab70:	004ad683          	lhu	a3,4(s5)
ffffffffc020ab74:	4785                	li	a5,1
ffffffffc020ab76:	0cf69c63          	bne	a3,a5,ffffffffc020ac4e <sfs_load_inode+0x174>
ffffffffc020ab7a:	864a                	mv	a2,s2
ffffffffc020ab7c:	00005597          	auipc	a1,0x5
ffffffffc020ab80:	afc58593          	addi	a1,a1,-1284 # ffffffffc020f678 <sfs_node_fileops>
ffffffffc020ab84:	8f4fd0ef          	jal	ra,ffffffffc0207c78 <inode_init>
ffffffffc020ab88:	058a2783          	lw	a5,88(s4)
ffffffffc020ab8c:	23540413          	addi	s0,s0,565
ffffffffc020ab90:	0e879063          	bne	a5,s0,ffffffffc020ac70 <sfs_load_inode+0x196>
ffffffffc020ab94:	4785                	li	a5,1
ffffffffc020ab96:	00fa2c23          	sw	a5,24(s4)
ffffffffc020ab9a:	015a3023          	sd	s5,0(s4)
ffffffffc020ab9e:	009a2423          	sw	s1,8(s4)
ffffffffc020aba2:	000a3823          	sd	zero,16(s4)
ffffffffc020aba6:	4585                	li	a1,1
ffffffffc020aba8:	020a0513          	addi	a0,s4,32
ffffffffc020abac:	a47f90ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc020abb0:	058a2703          	lw	a4,88(s4)
ffffffffc020abb4:	6785                	lui	a5,0x1
ffffffffc020abb6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020abba:	14f71663          	bne	a4,a5,ffffffffc020ad06 <sfs_load_inode+0x22c>
ffffffffc020abbe:	0a093703          	ld	a4,160(s2)
ffffffffc020abc2:	038a0793          	addi	a5,s4,56
ffffffffc020abc6:	008a2503          	lw	a0,8(s4)
ffffffffc020abca:	e31c                	sd	a5,0(a4)
ffffffffc020abcc:	0af93023          	sd	a5,160(s2)
ffffffffc020abd0:	09890793          	addi	a5,s2,152
ffffffffc020abd4:	0a893403          	ld	s0,168(s2)
ffffffffc020abd8:	45a9                	li	a1,10
ffffffffc020abda:	04ea3023          	sd	a4,64(s4)
ffffffffc020abde:	02fa3c23          	sd	a5,56(s4)
ffffffffc020abe2:	003000ef          	jal	ra,ffffffffc020b3e4 <hash32>
ffffffffc020abe6:	02051713          	slli	a4,a0,0x20
ffffffffc020abea:	01c75793          	srli	a5,a4,0x1c
ffffffffc020abee:	97a2                	add	a5,a5,s0
ffffffffc020abf0:	6798                	ld	a4,8(a5)
ffffffffc020abf2:	048a0693          	addi	a3,s4,72
ffffffffc020abf6:	e314                	sd	a3,0(a4)
ffffffffc020abf8:	e794                	sd	a3,8(a5)
ffffffffc020abfa:	04ea3823          	sd	a4,80(s4)
ffffffffc020abfe:	04fa3423          	sd	a5,72(s4)
ffffffffc020ac02:	854a                	mv	a0,s2
ffffffffc020ac04:	7d0000ef          	jal	ra,ffffffffc020b3d4 <unlock_sfs_fs>
ffffffffc020ac08:	4401                	li	s0,0
ffffffffc020ac0a:	0149b023          	sd	s4,0(s3)
ffffffffc020ac0e:	70e2                	ld	ra,56(sp)
ffffffffc020ac10:	8522                	mv	a0,s0
ffffffffc020ac12:	7442                	ld	s0,48(sp)
ffffffffc020ac14:	74a2                	ld	s1,40(sp)
ffffffffc020ac16:	7902                	ld	s2,32(sp)
ffffffffc020ac18:	69e2                	ld	s3,24(sp)
ffffffffc020ac1a:	6a42                	ld	s4,16(sp)
ffffffffc020ac1c:	6aa2                	ld	s5,8(sp)
ffffffffc020ac1e:	6121                	addi	sp,sp,64
ffffffffc020ac20:	8082                	ret
ffffffffc020ac22:	fb840a13          	addi	s4,s0,-72
ffffffffc020ac26:	8552                	mv	a0,s4
ffffffffc020ac28:	8b2fd0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc020ac2c:	4785                	li	a5,1
ffffffffc020ac2e:	fcf51ae3          	bne	a0,a5,ffffffffc020ac02 <sfs_load_inode+0x128>
ffffffffc020ac32:	fd042783          	lw	a5,-48(s0)
ffffffffc020ac36:	2785                	addiw	a5,a5,1
ffffffffc020ac38:	fcf42823          	sw	a5,-48(s0)
ffffffffc020ac3c:	b7d9                	j	ffffffffc020ac02 <sfs_load_inode+0x128>
ffffffffc020ac3e:	5471                	li	s0,-4
ffffffffc020ac40:	8556                	mv	a0,s5
ffffffffc020ac42:	c90f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020ac46:	854a                	mv	a0,s2
ffffffffc020ac48:	78c000ef          	jal	ra,ffffffffc020b3d4 <unlock_sfs_fs>
ffffffffc020ac4c:	b7c9                	j	ffffffffc020ac0e <sfs_load_inode+0x134>
ffffffffc020ac4e:	4789                	li	a5,2
ffffffffc020ac50:	08f69f63          	bne	a3,a5,ffffffffc020acee <sfs_load_inode+0x214>
ffffffffc020ac54:	864a                	mv	a2,s2
ffffffffc020ac56:	00005597          	auipc	a1,0x5
ffffffffc020ac5a:	9a258593          	addi	a1,a1,-1630 # ffffffffc020f5f8 <sfs_node_dirops>
ffffffffc020ac5e:	81afd0ef          	jal	ra,ffffffffc0207c78 <inode_init>
ffffffffc020ac62:	058a2703          	lw	a4,88(s4)
ffffffffc020ac66:	6785                	lui	a5,0x1
ffffffffc020ac68:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ac6c:	f2f704e3          	beq	a4,a5,ffffffffc020ab94 <sfs_load_inode+0xba>
ffffffffc020ac70:	00004697          	auipc	a3,0x4
ffffffffc020ac74:	65068693          	addi	a3,a3,1616 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc020ac78:	00001617          	auipc	a2,0x1
ffffffffc020ac7c:	18860613          	addi	a2,a2,392 # ffffffffc020be00 <commands+0x210>
ffffffffc020ac80:	07700593          	li	a1,119
ffffffffc020ac84:	00004517          	auipc	a0,0x4
ffffffffc020ac88:	67450513          	addi	a0,a0,1652 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020ac8c:	813f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ac90:	5471                	li	s0,-4
ffffffffc020ac92:	bf55                	j	ffffffffc020ac46 <sfs_load_inode+0x16c>
ffffffffc020ac94:	00005697          	auipc	a3,0x5
ffffffffc020ac98:	8ec68693          	addi	a3,a3,-1812 # ffffffffc020f580 <dev_node_ops+0x848>
ffffffffc020ac9c:	00001617          	auipc	a2,0x1
ffffffffc020aca0:	16460613          	addi	a2,a2,356 # ffffffffc020be00 <commands+0x210>
ffffffffc020aca4:	0ad00593          	li	a1,173
ffffffffc020aca8:	00004517          	auipc	a0,0x4
ffffffffc020acac:	65050513          	addi	a0,a0,1616 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020acb0:	feef50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020acb4:	8726                	mv	a4,s1
ffffffffc020acb6:	00004617          	auipc	a2,0x4
ffffffffc020acba:	67260613          	addi	a2,a2,1650 # ffffffffc020f328 <dev_node_ops+0x5f0>
ffffffffc020acbe:	05300593          	li	a1,83
ffffffffc020acc2:	00004517          	auipc	a0,0x4
ffffffffc020acc6:	63650513          	addi	a0,a0,1590 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020acca:	fd4f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020acce:	00004697          	auipc	a3,0x4
ffffffffc020acd2:	69268693          	addi	a3,a3,1682 # ffffffffc020f360 <dev_node_ops+0x628>
ffffffffc020acd6:	00001617          	auipc	a2,0x1
ffffffffc020acda:	12a60613          	addi	a2,a2,298 # ffffffffc020be00 <commands+0x210>
ffffffffc020acde:	0a800593          	li	a1,168
ffffffffc020ace2:	00004517          	auipc	a0,0x4
ffffffffc020ace6:	61650513          	addi	a0,a0,1558 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020acea:	fb4f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020acee:	00004617          	auipc	a2,0x4
ffffffffc020acf2:	62260613          	addi	a2,a2,1570 # ffffffffc020f310 <dev_node_ops+0x5d8>
ffffffffc020acf6:	02e00593          	li	a1,46
ffffffffc020acfa:	00004517          	auipc	a0,0x4
ffffffffc020acfe:	5fe50513          	addi	a0,a0,1534 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020ad02:	f9cf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ad06:	00004697          	auipc	a3,0x4
ffffffffc020ad0a:	5ba68693          	addi	a3,a3,1466 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc020ad0e:	00001617          	auipc	a2,0x1
ffffffffc020ad12:	0f260613          	addi	a2,a2,242 # ffffffffc020be00 <commands+0x210>
ffffffffc020ad16:	0b100593          	li	a1,177
ffffffffc020ad1a:	00004517          	auipc	a0,0x4
ffffffffc020ad1e:	5de50513          	addi	a0,a0,1502 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020ad22:	f7cf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ad26 <sfs_lookup>:
ffffffffc020ad26:	7139                	addi	sp,sp,-64
ffffffffc020ad28:	ec4e                	sd	s3,24(sp)
ffffffffc020ad2a:	06853983          	ld	s3,104(a0)
ffffffffc020ad2e:	fc06                	sd	ra,56(sp)
ffffffffc020ad30:	f822                	sd	s0,48(sp)
ffffffffc020ad32:	f426                	sd	s1,40(sp)
ffffffffc020ad34:	f04a                	sd	s2,32(sp)
ffffffffc020ad36:	e852                	sd	s4,16(sp)
ffffffffc020ad38:	0a098c63          	beqz	s3,ffffffffc020adf0 <sfs_lookup+0xca>
ffffffffc020ad3c:	0b09a783          	lw	a5,176(s3)
ffffffffc020ad40:	ebc5                	bnez	a5,ffffffffc020adf0 <sfs_lookup+0xca>
ffffffffc020ad42:	0005c783          	lbu	a5,0(a1)
ffffffffc020ad46:	84ae                	mv	s1,a1
ffffffffc020ad48:	c7c1                	beqz	a5,ffffffffc020add0 <sfs_lookup+0xaa>
ffffffffc020ad4a:	02f00713          	li	a4,47
ffffffffc020ad4e:	08e78163          	beq	a5,a4,ffffffffc020add0 <sfs_lookup+0xaa>
ffffffffc020ad52:	842a                	mv	s0,a0
ffffffffc020ad54:	8a32                	mv	s4,a2
ffffffffc020ad56:	f85fc0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc020ad5a:	4c38                	lw	a4,88(s0)
ffffffffc020ad5c:	6785                	lui	a5,0x1
ffffffffc020ad5e:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ad62:	0af71763          	bne	a4,a5,ffffffffc020ae10 <sfs_lookup+0xea>
ffffffffc020ad66:	6018                	ld	a4,0(s0)
ffffffffc020ad68:	4789                	li	a5,2
ffffffffc020ad6a:	00475703          	lhu	a4,4(a4)
ffffffffc020ad6e:	04f71c63          	bne	a4,a5,ffffffffc020adc6 <sfs_lookup+0xa0>
ffffffffc020ad72:	02040913          	addi	s2,s0,32
ffffffffc020ad76:	854a                	mv	a0,s2
ffffffffc020ad78:	885f90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020ad7c:	8626                	mv	a2,s1
ffffffffc020ad7e:	0054                	addi	a3,sp,4
ffffffffc020ad80:	85a2                	mv	a1,s0
ffffffffc020ad82:	854e                	mv	a0,s3
ffffffffc020ad84:	a29ff0ef          	jal	ra,ffffffffc020a7ac <sfs_dirent_search_nolock.constprop.0>
ffffffffc020ad88:	84aa                	mv	s1,a0
ffffffffc020ad8a:	854a                	mv	a0,s2
ffffffffc020ad8c:	86df90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020ad90:	cc89                	beqz	s1,ffffffffc020adaa <sfs_lookup+0x84>
ffffffffc020ad92:	8522                	mv	a0,s0
ffffffffc020ad94:	814fd0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020ad98:	70e2                	ld	ra,56(sp)
ffffffffc020ad9a:	7442                	ld	s0,48(sp)
ffffffffc020ad9c:	7902                	ld	s2,32(sp)
ffffffffc020ad9e:	69e2                	ld	s3,24(sp)
ffffffffc020ada0:	6a42                	ld	s4,16(sp)
ffffffffc020ada2:	8526                	mv	a0,s1
ffffffffc020ada4:	74a2                	ld	s1,40(sp)
ffffffffc020ada6:	6121                	addi	sp,sp,64
ffffffffc020ada8:	8082                	ret
ffffffffc020adaa:	4612                	lw	a2,4(sp)
ffffffffc020adac:	002c                	addi	a1,sp,8
ffffffffc020adae:	854e                	mv	a0,s3
ffffffffc020adb0:	d2bff0ef          	jal	ra,ffffffffc020aada <sfs_load_inode>
ffffffffc020adb4:	84aa                	mv	s1,a0
ffffffffc020adb6:	8522                	mv	a0,s0
ffffffffc020adb8:	ff1fc0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020adbc:	fcf1                	bnez	s1,ffffffffc020ad98 <sfs_lookup+0x72>
ffffffffc020adbe:	67a2                	ld	a5,8(sp)
ffffffffc020adc0:	00fa3023          	sd	a5,0(s4)
ffffffffc020adc4:	bfd1                	j	ffffffffc020ad98 <sfs_lookup+0x72>
ffffffffc020adc6:	8522                	mv	a0,s0
ffffffffc020adc8:	fe1fc0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020adcc:	54b9                	li	s1,-18
ffffffffc020adce:	b7e9                	j	ffffffffc020ad98 <sfs_lookup+0x72>
ffffffffc020add0:	00004697          	auipc	a3,0x4
ffffffffc020add4:	7c868693          	addi	a3,a3,1992 # ffffffffc020f598 <dev_node_ops+0x860>
ffffffffc020add8:	00001617          	auipc	a2,0x1
ffffffffc020addc:	02860613          	addi	a2,a2,40 # ffffffffc020be00 <commands+0x210>
ffffffffc020ade0:	3e100593          	li	a1,993
ffffffffc020ade4:	00004517          	auipc	a0,0x4
ffffffffc020ade8:	51450513          	addi	a0,a0,1300 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020adec:	eb2f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020adf0:	00004697          	auipc	a3,0x4
ffffffffc020adf4:	32868693          	addi	a3,a3,808 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc020adf8:	00001617          	auipc	a2,0x1
ffffffffc020adfc:	00860613          	addi	a2,a2,8 # ffffffffc020be00 <commands+0x210>
ffffffffc020ae00:	3e000593          	li	a1,992
ffffffffc020ae04:	00004517          	auipc	a0,0x4
ffffffffc020ae08:	4f450513          	addi	a0,a0,1268 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020ae0c:	e92f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ae10:	00004697          	auipc	a3,0x4
ffffffffc020ae14:	4b068693          	addi	a3,a3,1200 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc020ae18:	00001617          	auipc	a2,0x1
ffffffffc020ae1c:	fe860613          	addi	a2,a2,-24 # ffffffffc020be00 <commands+0x210>
ffffffffc020ae20:	3e300593          	li	a1,995
ffffffffc020ae24:	00004517          	auipc	a0,0x4
ffffffffc020ae28:	4d450513          	addi	a0,a0,1236 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020ae2c:	e72f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ae30 <sfs_namefile>:
ffffffffc020ae30:	6d98                	ld	a4,24(a1)
ffffffffc020ae32:	7175                	addi	sp,sp,-144
ffffffffc020ae34:	e506                	sd	ra,136(sp)
ffffffffc020ae36:	e122                	sd	s0,128(sp)
ffffffffc020ae38:	fca6                	sd	s1,120(sp)
ffffffffc020ae3a:	f8ca                	sd	s2,112(sp)
ffffffffc020ae3c:	f4ce                	sd	s3,104(sp)
ffffffffc020ae3e:	f0d2                	sd	s4,96(sp)
ffffffffc020ae40:	ecd6                	sd	s5,88(sp)
ffffffffc020ae42:	e8da                	sd	s6,80(sp)
ffffffffc020ae44:	e4de                	sd	s7,72(sp)
ffffffffc020ae46:	e0e2                	sd	s8,64(sp)
ffffffffc020ae48:	fc66                	sd	s9,56(sp)
ffffffffc020ae4a:	f86a                	sd	s10,48(sp)
ffffffffc020ae4c:	f46e                	sd	s11,40(sp)
ffffffffc020ae4e:	e42e                	sd	a1,8(sp)
ffffffffc020ae50:	4789                	li	a5,2
ffffffffc020ae52:	1ae7f363          	bgeu	a5,a4,ffffffffc020aff8 <sfs_namefile+0x1c8>
ffffffffc020ae56:	89aa                	mv	s3,a0
ffffffffc020ae58:	10400513          	li	a0,260
ffffffffc020ae5c:	9c6f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020ae60:	842a                	mv	s0,a0
ffffffffc020ae62:	18050b63          	beqz	a0,ffffffffc020aff8 <sfs_namefile+0x1c8>
ffffffffc020ae66:	0689b483          	ld	s1,104(s3)
ffffffffc020ae6a:	1e048963          	beqz	s1,ffffffffc020b05c <sfs_namefile+0x22c>
ffffffffc020ae6e:	0b04a783          	lw	a5,176(s1)
ffffffffc020ae72:	1e079563          	bnez	a5,ffffffffc020b05c <sfs_namefile+0x22c>
ffffffffc020ae76:	0589ac83          	lw	s9,88(s3)
ffffffffc020ae7a:	6785                	lui	a5,0x1
ffffffffc020ae7c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ae80:	1afc9e63          	bne	s9,a5,ffffffffc020b03c <sfs_namefile+0x20c>
ffffffffc020ae84:	6722                	ld	a4,8(sp)
ffffffffc020ae86:	854e                	mv	a0,s3
ffffffffc020ae88:	8ace                	mv	s5,s3
ffffffffc020ae8a:	6f1c                	ld	a5,24(a4)
ffffffffc020ae8c:	00073b03          	ld	s6,0(a4)
ffffffffc020ae90:	02098a13          	addi	s4,s3,32
ffffffffc020ae94:	ffe78b93          	addi	s7,a5,-2
ffffffffc020ae98:	9b3e                	add	s6,s6,a5
ffffffffc020ae9a:	00004d17          	auipc	s10,0x4
ffffffffc020ae9e:	71ed0d13          	addi	s10,s10,1822 # ffffffffc020f5b8 <dev_node_ops+0x880>
ffffffffc020aea2:	e39fc0ef          	jal	ra,ffffffffc0207cda <inode_ref_inc>
ffffffffc020aea6:	00440c13          	addi	s8,s0,4
ffffffffc020aeaa:	e066                	sd	s9,0(sp)
ffffffffc020aeac:	8552                	mv	a0,s4
ffffffffc020aeae:	f4ef90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020aeb2:	0854                	addi	a3,sp,20
ffffffffc020aeb4:	866a                	mv	a2,s10
ffffffffc020aeb6:	85d6                	mv	a1,s5
ffffffffc020aeb8:	8526                	mv	a0,s1
ffffffffc020aeba:	8f3ff0ef          	jal	ra,ffffffffc020a7ac <sfs_dirent_search_nolock.constprop.0>
ffffffffc020aebe:	8daa                	mv	s11,a0
ffffffffc020aec0:	8552                	mv	a0,s4
ffffffffc020aec2:	f36f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020aec6:	020d8863          	beqz	s11,ffffffffc020aef6 <sfs_namefile+0xc6>
ffffffffc020aeca:	854e                	mv	a0,s3
ffffffffc020aecc:	eddfc0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020aed0:	8522                	mv	a0,s0
ffffffffc020aed2:	a00f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020aed6:	60aa                	ld	ra,136(sp)
ffffffffc020aed8:	640a                	ld	s0,128(sp)
ffffffffc020aeda:	74e6                	ld	s1,120(sp)
ffffffffc020aedc:	7946                	ld	s2,112(sp)
ffffffffc020aede:	79a6                	ld	s3,104(sp)
ffffffffc020aee0:	7a06                	ld	s4,96(sp)
ffffffffc020aee2:	6ae6                	ld	s5,88(sp)
ffffffffc020aee4:	6b46                	ld	s6,80(sp)
ffffffffc020aee6:	6ba6                	ld	s7,72(sp)
ffffffffc020aee8:	6c06                	ld	s8,64(sp)
ffffffffc020aeea:	7ce2                	ld	s9,56(sp)
ffffffffc020aeec:	7d42                	ld	s10,48(sp)
ffffffffc020aeee:	856e                	mv	a0,s11
ffffffffc020aef0:	7da2                	ld	s11,40(sp)
ffffffffc020aef2:	6149                	addi	sp,sp,144
ffffffffc020aef4:	8082                	ret
ffffffffc020aef6:	4652                	lw	a2,20(sp)
ffffffffc020aef8:	082c                	addi	a1,sp,24
ffffffffc020aefa:	8526                	mv	a0,s1
ffffffffc020aefc:	bdfff0ef          	jal	ra,ffffffffc020aada <sfs_load_inode>
ffffffffc020af00:	8daa                	mv	s11,a0
ffffffffc020af02:	f561                	bnez	a0,ffffffffc020aeca <sfs_namefile+0x9a>
ffffffffc020af04:	854e                	mv	a0,s3
ffffffffc020af06:	008aa903          	lw	s2,8(s5)
ffffffffc020af0a:	e9ffc0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020af0e:	6ce2                	ld	s9,24(sp)
ffffffffc020af10:	0b3c8463          	beq	s9,s3,ffffffffc020afb8 <sfs_namefile+0x188>
ffffffffc020af14:	100c8463          	beqz	s9,ffffffffc020b01c <sfs_namefile+0x1ec>
ffffffffc020af18:	058ca703          	lw	a4,88(s9)
ffffffffc020af1c:	6782                	ld	a5,0(sp)
ffffffffc020af1e:	0ef71f63          	bne	a4,a5,ffffffffc020b01c <sfs_namefile+0x1ec>
ffffffffc020af22:	008ca703          	lw	a4,8(s9)
ffffffffc020af26:	8ae6                	mv	s5,s9
ffffffffc020af28:	0d270a63          	beq	a4,s2,ffffffffc020affc <sfs_namefile+0x1cc>
ffffffffc020af2c:	000cb703          	ld	a4,0(s9)
ffffffffc020af30:	4789                	li	a5,2
ffffffffc020af32:	00475703          	lhu	a4,4(a4)
ffffffffc020af36:	0cf71363          	bne	a4,a5,ffffffffc020affc <sfs_namefile+0x1cc>
ffffffffc020af3a:	020c8a13          	addi	s4,s9,32
ffffffffc020af3e:	8552                	mv	a0,s4
ffffffffc020af40:	ebcf90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020af44:	000cb703          	ld	a4,0(s9)
ffffffffc020af48:	00872983          	lw	s3,8(a4)
ffffffffc020af4c:	01304963          	bgtz	s3,ffffffffc020af5e <sfs_namefile+0x12e>
ffffffffc020af50:	a899                	j	ffffffffc020afa6 <sfs_namefile+0x176>
ffffffffc020af52:	4018                	lw	a4,0(s0)
ffffffffc020af54:	01270e63          	beq	a4,s2,ffffffffc020af70 <sfs_namefile+0x140>
ffffffffc020af58:	2d85                	addiw	s11,s11,1
ffffffffc020af5a:	05b98663          	beq	s3,s11,ffffffffc020afa6 <sfs_namefile+0x176>
ffffffffc020af5e:	86a2                	mv	a3,s0
ffffffffc020af60:	866e                	mv	a2,s11
ffffffffc020af62:	85e6                	mv	a1,s9
ffffffffc020af64:	8526                	mv	a0,s1
ffffffffc020af66:	e48ff0ef          	jal	ra,ffffffffc020a5ae <sfs_dirent_read_nolock>
ffffffffc020af6a:	872a                	mv	a4,a0
ffffffffc020af6c:	d17d                	beqz	a0,ffffffffc020af52 <sfs_namefile+0x122>
ffffffffc020af6e:	a82d                	j	ffffffffc020afa8 <sfs_namefile+0x178>
ffffffffc020af70:	8552                	mv	a0,s4
ffffffffc020af72:	e86f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020af76:	8562                	mv	a0,s8
ffffffffc020af78:	0ff000ef          	jal	ra,ffffffffc020b876 <strlen>
ffffffffc020af7c:	00150793          	addi	a5,a0,1
ffffffffc020af80:	862a                	mv	a2,a0
ffffffffc020af82:	06fbe863          	bltu	s7,a5,ffffffffc020aff2 <sfs_namefile+0x1c2>
ffffffffc020af86:	fff64913          	not	s2,a2
ffffffffc020af8a:	995a                	add	s2,s2,s6
ffffffffc020af8c:	85e2                	mv	a1,s8
ffffffffc020af8e:	854a                	mv	a0,s2
ffffffffc020af90:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020af94:	1d7000ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc020af98:	02f00793          	li	a5,47
ffffffffc020af9c:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020afa0:	89e6                	mv	s3,s9
ffffffffc020afa2:	8b4a                	mv	s6,s2
ffffffffc020afa4:	b721                	j	ffffffffc020aeac <sfs_namefile+0x7c>
ffffffffc020afa6:	5741                	li	a4,-16
ffffffffc020afa8:	8552                	mv	a0,s4
ffffffffc020afaa:	e03a                	sd	a4,0(sp)
ffffffffc020afac:	e4cf90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020afb0:	6702                	ld	a4,0(sp)
ffffffffc020afb2:	89e6                	mv	s3,s9
ffffffffc020afb4:	8dba                	mv	s11,a4
ffffffffc020afb6:	bf11                	j	ffffffffc020aeca <sfs_namefile+0x9a>
ffffffffc020afb8:	854e                	mv	a0,s3
ffffffffc020afba:	deffc0ef          	jal	ra,ffffffffc0207da8 <inode_ref_dec>
ffffffffc020afbe:	64a2                	ld	s1,8(sp)
ffffffffc020afc0:	85da                	mv	a1,s6
ffffffffc020afc2:	6c98                	ld	a4,24(s1)
ffffffffc020afc4:	6088                	ld	a0,0(s1)
ffffffffc020afc6:	1779                	addi	a4,a4,-2
ffffffffc020afc8:	41770bb3          	sub	s7,a4,s7
ffffffffc020afcc:	865e                	mv	a2,s7
ffffffffc020afce:	0505                	addi	a0,a0,1
ffffffffc020afd0:	15b000ef          	jal	ra,ffffffffc020b92a <memmove>
ffffffffc020afd4:	02f00713          	li	a4,47
ffffffffc020afd8:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020afdc:	955e                	add	a0,a0,s7
ffffffffc020afde:	00050023          	sb	zero,0(a0)
ffffffffc020afe2:	85de                	mv	a1,s7
ffffffffc020afe4:	8526                	mv	a0,s1
ffffffffc020afe6:	d0afa0ef          	jal	ra,ffffffffc02054f0 <iobuf_skip>
ffffffffc020afea:	8522                	mv	a0,s0
ffffffffc020afec:	8e6f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020aff0:	b5dd                	j	ffffffffc020aed6 <sfs_namefile+0xa6>
ffffffffc020aff2:	89e6                	mv	s3,s9
ffffffffc020aff4:	5df1                	li	s11,-4
ffffffffc020aff6:	bdd1                	j	ffffffffc020aeca <sfs_namefile+0x9a>
ffffffffc020aff8:	5df1                	li	s11,-4
ffffffffc020affa:	bdf1                	j	ffffffffc020aed6 <sfs_namefile+0xa6>
ffffffffc020affc:	00004697          	auipc	a3,0x4
ffffffffc020b000:	5c468693          	addi	a3,a3,1476 # ffffffffc020f5c0 <dev_node_ops+0x888>
ffffffffc020b004:	00001617          	auipc	a2,0x1
ffffffffc020b008:	dfc60613          	addi	a2,a2,-516 # ffffffffc020be00 <commands+0x210>
ffffffffc020b00c:	2ff00593          	li	a1,767
ffffffffc020b010:	00004517          	auipc	a0,0x4
ffffffffc020b014:	2e850513          	addi	a0,a0,744 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020b018:	c86f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020b01c:	00004697          	auipc	a3,0x4
ffffffffc020b020:	2a468693          	addi	a3,a3,676 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc020b024:	00001617          	auipc	a2,0x1
ffffffffc020b028:	ddc60613          	addi	a2,a2,-548 # ffffffffc020be00 <commands+0x210>
ffffffffc020b02c:	2fe00593          	li	a1,766
ffffffffc020b030:	00004517          	auipc	a0,0x4
ffffffffc020b034:	2c850513          	addi	a0,a0,712 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020b038:	c66f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020b03c:	00004697          	auipc	a3,0x4
ffffffffc020b040:	28468693          	addi	a3,a3,644 # ffffffffc020f2c0 <dev_node_ops+0x588>
ffffffffc020b044:	00001617          	auipc	a2,0x1
ffffffffc020b048:	dbc60613          	addi	a2,a2,-580 # ffffffffc020be00 <commands+0x210>
ffffffffc020b04c:	2eb00593          	li	a1,747
ffffffffc020b050:	00004517          	auipc	a0,0x4
ffffffffc020b054:	2a850513          	addi	a0,a0,680 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020b058:	c46f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020b05c:	00004697          	auipc	a3,0x4
ffffffffc020b060:	0bc68693          	addi	a3,a3,188 # ffffffffc020f118 <dev_node_ops+0x3e0>
ffffffffc020b064:	00001617          	auipc	a2,0x1
ffffffffc020b068:	d9c60613          	addi	a2,a2,-612 # ffffffffc020be00 <commands+0x210>
ffffffffc020b06c:	2ea00593          	li	a1,746
ffffffffc020b070:	00004517          	auipc	a0,0x4
ffffffffc020b074:	28850513          	addi	a0,a0,648 # ffffffffc020f2f8 <dev_node_ops+0x5c0>
ffffffffc020b078:	c26f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020b07c <sfs_rwblock_nolock>:
ffffffffc020b07c:	7139                	addi	sp,sp,-64
ffffffffc020b07e:	f822                	sd	s0,48(sp)
ffffffffc020b080:	f426                	sd	s1,40(sp)
ffffffffc020b082:	fc06                	sd	ra,56(sp)
ffffffffc020b084:	842a                	mv	s0,a0
ffffffffc020b086:	84b6                	mv	s1,a3
ffffffffc020b088:	e211                	bnez	a2,ffffffffc020b08c <sfs_rwblock_nolock+0x10>
ffffffffc020b08a:	e715                	bnez	a4,ffffffffc020b0b6 <sfs_rwblock_nolock+0x3a>
ffffffffc020b08c:	405c                	lw	a5,4(s0)
ffffffffc020b08e:	02f67463          	bgeu	a2,a5,ffffffffc020b0b6 <sfs_rwblock_nolock+0x3a>
ffffffffc020b092:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020b096:	1682                	slli	a3,a3,0x20
ffffffffc020b098:	6605                	lui	a2,0x1
ffffffffc020b09a:	9281                	srli	a3,a3,0x20
ffffffffc020b09c:	850a                	mv	a0,sp
ffffffffc020b09e:	bdcfa0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc020b0a2:	85aa                	mv	a1,a0
ffffffffc020b0a4:	7808                	ld	a0,48(s0)
ffffffffc020b0a6:	8626                	mv	a2,s1
ffffffffc020b0a8:	7118                	ld	a4,32(a0)
ffffffffc020b0aa:	9702                	jalr	a4
ffffffffc020b0ac:	70e2                	ld	ra,56(sp)
ffffffffc020b0ae:	7442                	ld	s0,48(sp)
ffffffffc020b0b0:	74a2                	ld	s1,40(sp)
ffffffffc020b0b2:	6121                	addi	sp,sp,64
ffffffffc020b0b4:	8082                	ret
ffffffffc020b0b6:	00004697          	auipc	a3,0x4
ffffffffc020b0ba:	64268693          	addi	a3,a3,1602 # ffffffffc020f6f8 <sfs_node_fileops+0x80>
ffffffffc020b0be:	00001617          	auipc	a2,0x1
ffffffffc020b0c2:	d4260613          	addi	a2,a2,-702 # ffffffffc020be00 <commands+0x210>
ffffffffc020b0c6:	45d5                	li	a1,21
ffffffffc020b0c8:	00004517          	auipc	a0,0x4
ffffffffc020b0cc:	66850513          	addi	a0,a0,1640 # ffffffffc020f730 <sfs_node_fileops+0xb8>
ffffffffc020b0d0:	bcef50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020b0d4 <sfs_rblock>:
ffffffffc020b0d4:	7139                	addi	sp,sp,-64
ffffffffc020b0d6:	ec4e                	sd	s3,24(sp)
ffffffffc020b0d8:	89b6                	mv	s3,a3
ffffffffc020b0da:	f822                	sd	s0,48(sp)
ffffffffc020b0dc:	f04a                	sd	s2,32(sp)
ffffffffc020b0de:	e852                	sd	s4,16(sp)
ffffffffc020b0e0:	fc06                	sd	ra,56(sp)
ffffffffc020b0e2:	f426                	sd	s1,40(sp)
ffffffffc020b0e4:	e456                	sd	s5,8(sp)
ffffffffc020b0e6:	8a2a                	mv	s4,a0
ffffffffc020b0e8:	892e                	mv	s2,a1
ffffffffc020b0ea:	8432                	mv	s0,a2
ffffffffc020b0ec:	2e0000ef          	jal	ra,ffffffffc020b3cc <lock_sfs_io>
ffffffffc020b0f0:	04098063          	beqz	s3,ffffffffc020b130 <sfs_rblock+0x5c>
ffffffffc020b0f4:	013409bb          	addw	s3,s0,s3
ffffffffc020b0f8:	6a85                	lui	s5,0x1
ffffffffc020b0fa:	a021                	j	ffffffffc020b102 <sfs_rblock+0x2e>
ffffffffc020b0fc:	9956                	add	s2,s2,s5
ffffffffc020b0fe:	02898963          	beq	s3,s0,ffffffffc020b130 <sfs_rblock+0x5c>
ffffffffc020b102:	8622                	mv	a2,s0
ffffffffc020b104:	85ca                	mv	a1,s2
ffffffffc020b106:	4705                	li	a4,1
ffffffffc020b108:	4681                	li	a3,0
ffffffffc020b10a:	8552                	mv	a0,s4
ffffffffc020b10c:	f71ff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b110:	84aa                	mv	s1,a0
ffffffffc020b112:	2405                	addiw	s0,s0,1
ffffffffc020b114:	d565                	beqz	a0,ffffffffc020b0fc <sfs_rblock+0x28>
ffffffffc020b116:	8552                	mv	a0,s4
ffffffffc020b118:	2c4000ef          	jal	ra,ffffffffc020b3dc <unlock_sfs_io>
ffffffffc020b11c:	70e2                	ld	ra,56(sp)
ffffffffc020b11e:	7442                	ld	s0,48(sp)
ffffffffc020b120:	7902                	ld	s2,32(sp)
ffffffffc020b122:	69e2                	ld	s3,24(sp)
ffffffffc020b124:	6a42                	ld	s4,16(sp)
ffffffffc020b126:	6aa2                	ld	s5,8(sp)
ffffffffc020b128:	8526                	mv	a0,s1
ffffffffc020b12a:	74a2                	ld	s1,40(sp)
ffffffffc020b12c:	6121                	addi	sp,sp,64
ffffffffc020b12e:	8082                	ret
ffffffffc020b130:	4481                	li	s1,0
ffffffffc020b132:	b7d5                	j	ffffffffc020b116 <sfs_rblock+0x42>

ffffffffc020b134 <sfs_wblock>:
ffffffffc020b134:	7139                	addi	sp,sp,-64
ffffffffc020b136:	ec4e                	sd	s3,24(sp)
ffffffffc020b138:	89b6                	mv	s3,a3
ffffffffc020b13a:	f822                	sd	s0,48(sp)
ffffffffc020b13c:	f04a                	sd	s2,32(sp)
ffffffffc020b13e:	e852                	sd	s4,16(sp)
ffffffffc020b140:	fc06                	sd	ra,56(sp)
ffffffffc020b142:	f426                	sd	s1,40(sp)
ffffffffc020b144:	e456                	sd	s5,8(sp)
ffffffffc020b146:	8a2a                	mv	s4,a0
ffffffffc020b148:	892e                	mv	s2,a1
ffffffffc020b14a:	8432                	mv	s0,a2
ffffffffc020b14c:	280000ef          	jal	ra,ffffffffc020b3cc <lock_sfs_io>
ffffffffc020b150:	04098063          	beqz	s3,ffffffffc020b190 <sfs_wblock+0x5c>
ffffffffc020b154:	013409bb          	addw	s3,s0,s3
ffffffffc020b158:	6a85                	lui	s5,0x1
ffffffffc020b15a:	a021                	j	ffffffffc020b162 <sfs_wblock+0x2e>
ffffffffc020b15c:	9956                	add	s2,s2,s5
ffffffffc020b15e:	02898963          	beq	s3,s0,ffffffffc020b190 <sfs_wblock+0x5c>
ffffffffc020b162:	8622                	mv	a2,s0
ffffffffc020b164:	85ca                	mv	a1,s2
ffffffffc020b166:	4705                	li	a4,1
ffffffffc020b168:	4685                	li	a3,1
ffffffffc020b16a:	8552                	mv	a0,s4
ffffffffc020b16c:	f11ff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b170:	84aa                	mv	s1,a0
ffffffffc020b172:	2405                	addiw	s0,s0,1
ffffffffc020b174:	d565                	beqz	a0,ffffffffc020b15c <sfs_wblock+0x28>
ffffffffc020b176:	8552                	mv	a0,s4
ffffffffc020b178:	264000ef          	jal	ra,ffffffffc020b3dc <unlock_sfs_io>
ffffffffc020b17c:	70e2                	ld	ra,56(sp)
ffffffffc020b17e:	7442                	ld	s0,48(sp)
ffffffffc020b180:	7902                	ld	s2,32(sp)
ffffffffc020b182:	69e2                	ld	s3,24(sp)
ffffffffc020b184:	6a42                	ld	s4,16(sp)
ffffffffc020b186:	6aa2                	ld	s5,8(sp)
ffffffffc020b188:	8526                	mv	a0,s1
ffffffffc020b18a:	74a2                	ld	s1,40(sp)
ffffffffc020b18c:	6121                	addi	sp,sp,64
ffffffffc020b18e:	8082                	ret
ffffffffc020b190:	4481                	li	s1,0
ffffffffc020b192:	b7d5                	j	ffffffffc020b176 <sfs_wblock+0x42>

ffffffffc020b194 <sfs_rbuf>:
ffffffffc020b194:	7179                	addi	sp,sp,-48
ffffffffc020b196:	f406                	sd	ra,40(sp)
ffffffffc020b198:	f022                	sd	s0,32(sp)
ffffffffc020b19a:	ec26                	sd	s1,24(sp)
ffffffffc020b19c:	e84a                	sd	s2,16(sp)
ffffffffc020b19e:	e44e                	sd	s3,8(sp)
ffffffffc020b1a0:	e052                	sd	s4,0(sp)
ffffffffc020b1a2:	6785                	lui	a5,0x1
ffffffffc020b1a4:	04f77863          	bgeu	a4,a5,ffffffffc020b1f4 <sfs_rbuf+0x60>
ffffffffc020b1a8:	84ba                	mv	s1,a4
ffffffffc020b1aa:	9732                	add	a4,a4,a2
ffffffffc020b1ac:	89b2                	mv	s3,a2
ffffffffc020b1ae:	04e7e363          	bltu	a5,a4,ffffffffc020b1f4 <sfs_rbuf+0x60>
ffffffffc020b1b2:	8936                	mv	s2,a3
ffffffffc020b1b4:	842a                	mv	s0,a0
ffffffffc020b1b6:	8a2e                	mv	s4,a1
ffffffffc020b1b8:	214000ef          	jal	ra,ffffffffc020b3cc <lock_sfs_io>
ffffffffc020b1bc:	642c                	ld	a1,72(s0)
ffffffffc020b1be:	864a                	mv	a2,s2
ffffffffc020b1c0:	4705                	li	a4,1
ffffffffc020b1c2:	4681                	li	a3,0
ffffffffc020b1c4:	8522                	mv	a0,s0
ffffffffc020b1c6:	eb7ff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b1ca:	892a                	mv	s2,a0
ffffffffc020b1cc:	cd09                	beqz	a0,ffffffffc020b1e6 <sfs_rbuf+0x52>
ffffffffc020b1ce:	8522                	mv	a0,s0
ffffffffc020b1d0:	20c000ef          	jal	ra,ffffffffc020b3dc <unlock_sfs_io>
ffffffffc020b1d4:	70a2                	ld	ra,40(sp)
ffffffffc020b1d6:	7402                	ld	s0,32(sp)
ffffffffc020b1d8:	64e2                	ld	s1,24(sp)
ffffffffc020b1da:	69a2                	ld	s3,8(sp)
ffffffffc020b1dc:	6a02                	ld	s4,0(sp)
ffffffffc020b1de:	854a                	mv	a0,s2
ffffffffc020b1e0:	6942                	ld	s2,16(sp)
ffffffffc020b1e2:	6145                	addi	sp,sp,48
ffffffffc020b1e4:	8082                	ret
ffffffffc020b1e6:	642c                	ld	a1,72(s0)
ffffffffc020b1e8:	864e                	mv	a2,s3
ffffffffc020b1ea:	8552                	mv	a0,s4
ffffffffc020b1ec:	95a6                	add	a1,a1,s1
ffffffffc020b1ee:	77c000ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc020b1f2:	bff1                	j	ffffffffc020b1ce <sfs_rbuf+0x3a>
ffffffffc020b1f4:	00004697          	auipc	a3,0x4
ffffffffc020b1f8:	55468693          	addi	a3,a3,1364 # ffffffffc020f748 <sfs_node_fileops+0xd0>
ffffffffc020b1fc:	00001617          	auipc	a2,0x1
ffffffffc020b200:	c0460613          	addi	a2,a2,-1020 # ffffffffc020be00 <commands+0x210>
ffffffffc020b204:	05500593          	li	a1,85
ffffffffc020b208:	00004517          	auipc	a0,0x4
ffffffffc020b20c:	52850513          	addi	a0,a0,1320 # ffffffffc020f730 <sfs_node_fileops+0xb8>
ffffffffc020b210:	a8ef50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020b214 <sfs_wbuf>:
ffffffffc020b214:	7139                	addi	sp,sp,-64
ffffffffc020b216:	fc06                	sd	ra,56(sp)
ffffffffc020b218:	f822                	sd	s0,48(sp)
ffffffffc020b21a:	f426                	sd	s1,40(sp)
ffffffffc020b21c:	f04a                	sd	s2,32(sp)
ffffffffc020b21e:	ec4e                	sd	s3,24(sp)
ffffffffc020b220:	e852                	sd	s4,16(sp)
ffffffffc020b222:	e456                	sd	s5,8(sp)
ffffffffc020b224:	6785                	lui	a5,0x1
ffffffffc020b226:	06f77163          	bgeu	a4,a5,ffffffffc020b288 <sfs_wbuf+0x74>
ffffffffc020b22a:	893a                	mv	s2,a4
ffffffffc020b22c:	9732                	add	a4,a4,a2
ffffffffc020b22e:	8a32                	mv	s4,a2
ffffffffc020b230:	04e7ec63          	bltu	a5,a4,ffffffffc020b288 <sfs_wbuf+0x74>
ffffffffc020b234:	842a                	mv	s0,a0
ffffffffc020b236:	89b6                	mv	s3,a3
ffffffffc020b238:	8aae                	mv	s5,a1
ffffffffc020b23a:	192000ef          	jal	ra,ffffffffc020b3cc <lock_sfs_io>
ffffffffc020b23e:	642c                	ld	a1,72(s0)
ffffffffc020b240:	4705                	li	a4,1
ffffffffc020b242:	4681                	li	a3,0
ffffffffc020b244:	864e                	mv	a2,s3
ffffffffc020b246:	8522                	mv	a0,s0
ffffffffc020b248:	e35ff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b24c:	84aa                	mv	s1,a0
ffffffffc020b24e:	cd11                	beqz	a0,ffffffffc020b26a <sfs_wbuf+0x56>
ffffffffc020b250:	8522                	mv	a0,s0
ffffffffc020b252:	18a000ef          	jal	ra,ffffffffc020b3dc <unlock_sfs_io>
ffffffffc020b256:	70e2                	ld	ra,56(sp)
ffffffffc020b258:	7442                	ld	s0,48(sp)
ffffffffc020b25a:	7902                	ld	s2,32(sp)
ffffffffc020b25c:	69e2                	ld	s3,24(sp)
ffffffffc020b25e:	6a42                	ld	s4,16(sp)
ffffffffc020b260:	6aa2                	ld	s5,8(sp)
ffffffffc020b262:	8526                	mv	a0,s1
ffffffffc020b264:	74a2                	ld	s1,40(sp)
ffffffffc020b266:	6121                	addi	sp,sp,64
ffffffffc020b268:	8082                	ret
ffffffffc020b26a:	6428                	ld	a0,72(s0)
ffffffffc020b26c:	8652                	mv	a2,s4
ffffffffc020b26e:	85d6                	mv	a1,s5
ffffffffc020b270:	954a                	add	a0,a0,s2
ffffffffc020b272:	6f8000ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc020b276:	642c                	ld	a1,72(s0)
ffffffffc020b278:	4705                	li	a4,1
ffffffffc020b27a:	4685                	li	a3,1
ffffffffc020b27c:	864e                	mv	a2,s3
ffffffffc020b27e:	8522                	mv	a0,s0
ffffffffc020b280:	dfdff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b284:	84aa                	mv	s1,a0
ffffffffc020b286:	b7e9                	j	ffffffffc020b250 <sfs_wbuf+0x3c>
ffffffffc020b288:	00004697          	auipc	a3,0x4
ffffffffc020b28c:	4c068693          	addi	a3,a3,1216 # ffffffffc020f748 <sfs_node_fileops+0xd0>
ffffffffc020b290:	00001617          	auipc	a2,0x1
ffffffffc020b294:	b7060613          	addi	a2,a2,-1168 # ffffffffc020be00 <commands+0x210>
ffffffffc020b298:	06b00593          	li	a1,107
ffffffffc020b29c:	00004517          	auipc	a0,0x4
ffffffffc020b2a0:	49450513          	addi	a0,a0,1172 # ffffffffc020f730 <sfs_node_fileops+0xb8>
ffffffffc020b2a4:	9faf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020b2a8 <sfs_sync_super>:
ffffffffc020b2a8:	1101                	addi	sp,sp,-32
ffffffffc020b2aa:	ec06                	sd	ra,24(sp)
ffffffffc020b2ac:	e822                	sd	s0,16(sp)
ffffffffc020b2ae:	e426                	sd	s1,8(sp)
ffffffffc020b2b0:	842a                	mv	s0,a0
ffffffffc020b2b2:	11a000ef          	jal	ra,ffffffffc020b3cc <lock_sfs_io>
ffffffffc020b2b6:	6428                	ld	a0,72(s0)
ffffffffc020b2b8:	6605                	lui	a2,0x1
ffffffffc020b2ba:	4581                	li	a1,0
ffffffffc020b2bc:	65c000ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc020b2c0:	6428                	ld	a0,72(s0)
ffffffffc020b2c2:	85a2                	mv	a1,s0
ffffffffc020b2c4:	02c00613          	li	a2,44
ffffffffc020b2c8:	6a2000ef          	jal	ra,ffffffffc020b96a <memcpy>
ffffffffc020b2cc:	642c                	ld	a1,72(s0)
ffffffffc020b2ce:	4701                	li	a4,0
ffffffffc020b2d0:	4685                	li	a3,1
ffffffffc020b2d2:	4601                	li	a2,0
ffffffffc020b2d4:	8522                	mv	a0,s0
ffffffffc020b2d6:	da7ff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b2da:	84aa                	mv	s1,a0
ffffffffc020b2dc:	8522                	mv	a0,s0
ffffffffc020b2de:	0fe000ef          	jal	ra,ffffffffc020b3dc <unlock_sfs_io>
ffffffffc020b2e2:	60e2                	ld	ra,24(sp)
ffffffffc020b2e4:	6442                	ld	s0,16(sp)
ffffffffc020b2e6:	8526                	mv	a0,s1
ffffffffc020b2e8:	64a2                	ld	s1,8(sp)
ffffffffc020b2ea:	6105                	addi	sp,sp,32
ffffffffc020b2ec:	8082                	ret

ffffffffc020b2ee <sfs_sync_freemap>:
ffffffffc020b2ee:	7139                	addi	sp,sp,-64
ffffffffc020b2f0:	ec4e                	sd	s3,24(sp)
ffffffffc020b2f2:	e852                	sd	s4,16(sp)
ffffffffc020b2f4:	00456983          	lwu	s3,4(a0)
ffffffffc020b2f8:	8a2a                	mv	s4,a0
ffffffffc020b2fa:	7d08                	ld	a0,56(a0)
ffffffffc020b2fc:	67a1                	lui	a5,0x8
ffffffffc020b2fe:	17fd                	addi	a5,a5,-1
ffffffffc020b300:	4581                	li	a1,0
ffffffffc020b302:	f822                	sd	s0,48(sp)
ffffffffc020b304:	fc06                	sd	ra,56(sp)
ffffffffc020b306:	f426                	sd	s1,40(sp)
ffffffffc020b308:	f04a                	sd	s2,32(sp)
ffffffffc020b30a:	e456                	sd	s5,8(sp)
ffffffffc020b30c:	99be                	add	s3,s3,a5
ffffffffc020b30e:	a28fe0ef          	jal	ra,ffffffffc0209536 <bitmap_getdata>
ffffffffc020b312:	00f9d993          	srli	s3,s3,0xf
ffffffffc020b316:	842a                	mv	s0,a0
ffffffffc020b318:	8552                	mv	a0,s4
ffffffffc020b31a:	0b2000ef          	jal	ra,ffffffffc020b3cc <lock_sfs_io>
ffffffffc020b31e:	04098163          	beqz	s3,ffffffffc020b360 <sfs_sync_freemap+0x72>
ffffffffc020b322:	09b2                	slli	s3,s3,0xc
ffffffffc020b324:	99a2                	add	s3,s3,s0
ffffffffc020b326:	4909                	li	s2,2
ffffffffc020b328:	6a85                	lui	s5,0x1
ffffffffc020b32a:	a021                	j	ffffffffc020b332 <sfs_sync_freemap+0x44>
ffffffffc020b32c:	2905                	addiw	s2,s2,1
ffffffffc020b32e:	02898963          	beq	s3,s0,ffffffffc020b360 <sfs_sync_freemap+0x72>
ffffffffc020b332:	85a2                	mv	a1,s0
ffffffffc020b334:	864a                	mv	a2,s2
ffffffffc020b336:	4705                	li	a4,1
ffffffffc020b338:	4685                	li	a3,1
ffffffffc020b33a:	8552                	mv	a0,s4
ffffffffc020b33c:	d41ff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b340:	84aa                	mv	s1,a0
ffffffffc020b342:	9456                	add	s0,s0,s5
ffffffffc020b344:	d565                	beqz	a0,ffffffffc020b32c <sfs_sync_freemap+0x3e>
ffffffffc020b346:	8552                	mv	a0,s4
ffffffffc020b348:	094000ef          	jal	ra,ffffffffc020b3dc <unlock_sfs_io>
ffffffffc020b34c:	70e2                	ld	ra,56(sp)
ffffffffc020b34e:	7442                	ld	s0,48(sp)
ffffffffc020b350:	7902                	ld	s2,32(sp)
ffffffffc020b352:	69e2                	ld	s3,24(sp)
ffffffffc020b354:	6a42                	ld	s4,16(sp)
ffffffffc020b356:	6aa2                	ld	s5,8(sp)
ffffffffc020b358:	8526                	mv	a0,s1
ffffffffc020b35a:	74a2                	ld	s1,40(sp)
ffffffffc020b35c:	6121                	addi	sp,sp,64
ffffffffc020b35e:	8082                	ret
ffffffffc020b360:	4481                	li	s1,0
ffffffffc020b362:	b7d5                	j	ffffffffc020b346 <sfs_sync_freemap+0x58>

ffffffffc020b364 <sfs_clear_block>:
ffffffffc020b364:	7179                	addi	sp,sp,-48
ffffffffc020b366:	f022                	sd	s0,32(sp)
ffffffffc020b368:	e84a                	sd	s2,16(sp)
ffffffffc020b36a:	e44e                	sd	s3,8(sp)
ffffffffc020b36c:	f406                	sd	ra,40(sp)
ffffffffc020b36e:	89b2                	mv	s3,a2
ffffffffc020b370:	ec26                	sd	s1,24(sp)
ffffffffc020b372:	892a                	mv	s2,a0
ffffffffc020b374:	842e                	mv	s0,a1
ffffffffc020b376:	056000ef          	jal	ra,ffffffffc020b3cc <lock_sfs_io>
ffffffffc020b37a:	04893503          	ld	a0,72(s2)
ffffffffc020b37e:	6605                	lui	a2,0x1
ffffffffc020b380:	4581                	li	a1,0
ffffffffc020b382:	596000ef          	jal	ra,ffffffffc020b918 <memset>
ffffffffc020b386:	02098d63          	beqz	s3,ffffffffc020b3c0 <sfs_clear_block+0x5c>
ffffffffc020b38a:	013409bb          	addw	s3,s0,s3
ffffffffc020b38e:	a019                	j	ffffffffc020b394 <sfs_clear_block+0x30>
ffffffffc020b390:	02898863          	beq	s3,s0,ffffffffc020b3c0 <sfs_clear_block+0x5c>
ffffffffc020b394:	04893583          	ld	a1,72(s2)
ffffffffc020b398:	8622                	mv	a2,s0
ffffffffc020b39a:	4705                	li	a4,1
ffffffffc020b39c:	4685                	li	a3,1
ffffffffc020b39e:	854a                	mv	a0,s2
ffffffffc020b3a0:	cddff0ef          	jal	ra,ffffffffc020b07c <sfs_rwblock_nolock>
ffffffffc020b3a4:	84aa                	mv	s1,a0
ffffffffc020b3a6:	2405                	addiw	s0,s0,1
ffffffffc020b3a8:	d565                	beqz	a0,ffffffffc020b390 <sfs_clear_block+0x2c>
ffffffffc020b3aa:	854a                	mv	a0,s2
ffffffffc020b3ac:	030000ef          	jal	ra,ffffffffc020b3dc <unlock_sfs_io>
ffffffffc020b3b0:	70a2                	ld	ra,40(sp)
ffffffffc020b3b2:	7402                	ld	s0,32(sp)
ffffffffc020b3b4:	6942                	ld	s2,16(sp)
ffffffffc020b3b6:	69a2                	ld	s3,8(sp)
ffffffffc020b3b8:	8526                	mv	a0,s1
ffffffffc020b3ba:	64e2                	ld	s1,24(sp)
ffffffffc020b3bc:	6145                	addi	sp,sp,48
ffffffffc020b3be:	8082                	ret
ffffffffc020b3c0:	4481                	li	s1,0
ffffffffc020b3c2:	b7e5                	j	ffffffffc020b3aa <sfs_clear_block+0x46>

ffffffffc020b3c4 <lock_sfs_fs>:
ffffffffc020b3c4:	05050513          	addi	a0,a0,80
ffffffffc020b3c8:	a34f906f          	j	ffffffffc02045fc <down>

ffffffffc020b3cc <lock_sfs_io>:
ffffffffc020b3cc:	06850513          	addi	a0,a0,104
ffffffffc020b3d0:	a2cf906f          	j	ffffffffc02045fc <down>

ffffffffc020b3d4 <unlock_sfs_fs>:
ffffffffc020b3d4:	05050513          	addi	a0,a0,80
ffffffffc020b3d8:	a20f906f          	j	ffffffffc02045f8 <up>

ffffffffc020b3dc <unlock_sfs_io>:
ffffffffc020b3dc:	06850513          	addi	a0,a0,104
ffffffffc020b3e0:	a18f906f          	j	ffffffffc02045f8 <up>

ffffffffc020b3e4 <hash32>:
ffffffffc020b3e4:	9e3707b7          	lui	a5,0x9e370
ffffffffc020b3e8:	2785                	addiw	a5,a5,1
ffffffffc020b3ea:	02a7853b          	mulw	a0,a5,a0
ffffffffc020b3ee:	02000793          	li	a5,32
ffffffffc020b3f2:	9f8d                	subw	a5,a5,a1
ffffffffc020b3f4:	00f5553b          	srlw	a0,a0,a5
ffffffffc020b3f8:	8082                	ret

ffffffffc020b3fa <printnum>:
ffffffffc020b3fa:	02071893          	slli	a7,a4,0x20
ffffffffc020b3fe:	7139                	addi	sp,sp,-64
ffffffffc020b400:	0208d893          	srli	a7,a7,0x20
ffffffffc020b404:	e456                	sd	s5,8(sp)
ffffffffc020b406:	0316fab3          	remu	s5,a3,a7
ffffffffc020b40a:	f822                	sd	s0,48(sp)
ffffffffc020b40c:	f426                	sd	s1,40(sp)
ffffffffc020b40e:	f04a                	sd	s2,32(sp)
ffffffffc020b410:	ec4e                	sd	s3,24(sp)
ffffffffc020b412:	fc06                	sd	ra,56(sp)
ffffffffc020b414:	e852                	sd	s4,16(sp)
ffffffffc020b416:	84aa                	mv	s1,a0
ffffffffc020b418:	89ae                	mv	s3,a1
ffffffffc020b41a:	8932                	mv	s2,a2
ffffffffc020b41c:	fff7841b          	addiw	s0,a5,-1
ffffffffc020b420:	2a81                	sext.w	s5,s5
ffffffffc020b422:	0516f163          	bgeu	a3,a7,ffffffffc020b464 <printnum+0x6a>
ffffffffc020b426:	8a42                	mv	s4,a6
ffffffffc020b428:	00805863          	blez	s0,ffffffffc020b438 <printnum+0x3e>
ffffffffc020b42c:	347d                	addiw	s0,s0,-1
ffffffffc020b42e:	864e                	mv	a2,s3
ffffffffc020b430:	85ca                	mv	a1,s2
ffffffffc020b432:	8552                	mv	a0,s4
ffffffffc020b434:	9482                	jalr	s1
ffffffffc020b436:	f87d                	bnez	s0,ffffffffc020b42c <printnum+0x32>
ffffffffc020b438:	1a82                	slli	s5,s5,0x20
ffffffffc020b43a:	00004797          	auipc	a5,0x4
ffffffffc020b43e:	35678793          	addi	a5,a5,854 # ffffffffc020f790 <sfs_node_fileops+0x118>
ffffffffc020b442:	020ada93          	srli	s5,s5,0x20
ffffffffc020b446:	9abe                	add	s5,s5,a5
ffffffffc020b448:	7442                	ld	s0,48(sp)
ffffffffc020b44a:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020b44e:	70e2                	ld	ra,56(sp)
ffffffffc020b450:	6a42                	ld	s4,16(sp)
ffffffffc020b452:	6aa2                	ld	s5,8(sp)
ffffffffc020b454:	864e                	mv	a2,s3
ffffffffc020b456:	85ca                	mv	a1,s2
ffffffffc020b458:	69e2                	ld	s3,24(sp)
ffffffffc020b45a:	7902                	ld	s2,32(sp)
ffffffffc020b45c:	87a6                	mv	a5,s1
ffffffffc020b45e:	74a2                	ld	s1,40(sp)
ffffffffc020b460:	6121                	addi	sp,sp,64
ffffffffc020b462:	8782                	jr	a5
ffffffffc020b464:	0316d6b3          	divu	a3,a3,a7
ffffffffc020b468:	87a2                	mv	a5,s0
ffffffffc020b46a:	f91ff0ef          	jal	ra,ffffffffc020b3fa <printnum>
ffffffffc020b46e:	b7e9                	j	ffffffffc020b438 <printnum+0x3e>

ffffffffc020b470 <sprintputch>:
ffffffffc020b470:	499c                	lw	a5,16(a1)
ffffffffc020b472:	6198                	ld	a4,0(a1)
ffffffffc020b474:	6594                	ld	a3,8(a1)
ffffffffc020b476:	2785                	addiw	a5,a5,1
ffffffffc020b478:	c99c                	sw	a5,16(a1)
ffffffffc020b47a:	00d77763          	bgeu	a4,a3,ffffffffc020b488 <sprintputch+0x18>
ffffffffc020b47e:	00170793          	addi	a5,a4,1
ffffffffc020b482:	e19c                	sd	a5,0(a1)
ffffffffc020b484:	00a70023          	sb	a0,0(a4)
ffffffffc020b488:	8082                	ret

ffffffffc020b48a <vprintfmt>:
ffffffffc020b48a:	7119                	addi	sp,sp,-128
ffffffffc020b48c:	f4a6                	sd	s1,104(sp)
ffffffffc020b48e:	f0ca                	sd	s2,96(sp)
ffffffffc020b490:	ecce                	sd	s3,88(sp)
ffffffffc020b492:	e8d2                	sd	s4,80(sp)
ffffffffc020b494:	e4d6                	sd	s5,72(sp)
ffffffffc020b496:	e0da                	sd	s6,64(sp)
ffffffffc020b498:	fc5e                	sd	s7,56(sp)
ffffffffc020b49a:	ec6e                	sd	s11,24(sp)
ffffffffc020b49c:	fc86                	sd	ra,120(sp)
ffffffffc020b49e:	f8a2                	sd	s0,112(sp)
ffffffffc020b4a0:	f862                	sd	s8,48(sp)
ffffffffc020b4a2:	f466                	sd	s9,40(sp)
ffffffffc020b4a4:	f06a                	sd	s10,32(sp)
ffffffffc020b4a6:	89aa                	mv	s3,a0
ffffffffc020b4a8:	892e                	mv	s2,a1
ffffffffc020b4aa:	84b2                	mv	s1,a2
ffffffffc020b4ac:	8db6                	mv	s11,a3
ffffffffc020b4ae:	8aba                	mv	s5,a4
ffffffffc020b4b0:	02500a13          	li	s4,37
ffffffffc020b4b4:	5bfd                	li	s7,-1
ffffffffc020b4b6:	00004b17          	auipc	s6,0x4
ffffffffc020b4ba:	306b0b13          	addi	s6,s6,774 # ffffffffc020f7bc <sfs_node_fileops+0x144>
ffffffffc020b4be:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020b4c2:	001d8413          	addi	s0,s11,1
ffffffffc020b4c6:	01450b63          	beq	a0,s4,ffffffffc020b4dc <vprintfmt+0x52>
ffffffffc020b4ca:	c129                	beqz	a0,ffffffffc020b50c <vprintfmt+0x82>
ffffffffc020b4cc:	864a                	mv	a2,s2
ffffffffc020b4ce:	85a6                	mv	a1,s1
ffffffffc020b4d0:	0405                	addi	s0,s0,1
ffffffffc020b4d2:	9982                	jalr	s3
ffffffffc020b4d4:	fff44503          	lbu	a0,-1(s0)
ffffffffc020b4d8:	ff4519e3          	bne	a0,s4,ffffffffc020b4ca <vprintfmt+0x40>
ffffffffc020b4dc:	00044583          	lbu	a1,0(s0)
ffffffffc020b4e0:	02000813          	li	a6,32
ffffffffc020b4e4:	4d01                	li	s10,0
ffffffffc020b4e6:	4301                	li	t1,0
ffffffffc020b4e8:	5cfd                	li	s9,-1
ffffffffc020b4ea:	5c7d                	li	s8,-1
ffffffffc020b4ec:	05500513          	li	a0,85
ffffffffc020b4f0:	48a5                	li	a7,9
ffffffffc020b4f2:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b4f6:	0ff67613          	zext.b	a2,a2
ffffffffc020b4fa:	00140d93          	addi	s11,s0,1
ffffffffc020b4fe:	04c56263          	bltu	a0,a2,ffffffffc020b542 <vprintfmt+0xb8>
ffffffffc020b502:	060a                	slli	a2,a2,0x2
ffffffffc020b504:	965a                	add	a2,a2,s6
ffffffffc020b506:	4214                	lw	a3,0(a2)
ffffffffc020b508:	96da                	add	a3,a3,s6
ffffffffc020b50a:	8682                	jr	a3
ffffffffc020b50c:	70e6                	ld	ra,120(sp)
ffffffffc020b50e:	7446                	ld	s0,112(sp)
ffffffffc020b510:	74a6                	ld	s1,104(sp)
ffffffffc020b512:	7906                	ld	s2,96(sp)
ffffffffc020b514:	69e6                	ld	s3,88(sp)
ffffffffc020b516:	6a46                	ld	s4,80(sp)
ffffffffc020b518:	6aa6                	ld	s5,72(sp)
ffffffffc020b51a:	6b06                	ld	s6,64(sp)
ffffffffc020b51c:	7be2                	ld	s7,56(sp)
ffffffffc020b51e:	7c42                	ld	s8,48(sp)
ffffffffc020b520:	7ca2                	ld	s9,40(sp)
ffffffffc020b522:	7d02                	ld	s10,32(sp)
ffffffffc020b524:	6de2                	ld	s11,24(sp)
ffffffffc020b526:	6109                	addi	sp,sp,128
ffffffffc020b528:	8082                	ret
ffffffffc020b52a:	882e                	mv	a6,a1
ffffffffc020b52c:	00144583          	lbu	a1,1(s0)
ffffffffc020b530:	846e                	mv	s0,s11
ffffffffc020b532:	00140d93          	addi	s11,s0,1
ffffffffc020b536:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b53a:	0ff67613          	zext.b	a2,a2
ffffffffc020b53e:	fcc572e3          	bgeu	a0,a2,ffffffffc020b502 <vprintfmt+0x78>
ffffffffc020b542:	864a                	mv	a2,s2
ffffffffc020b544:	85a6                	mv	a1,s1
ffffffffc020b546:	02500513          	li	a0,37
ffffffffc020b54a:	9982                	jalr	s3
ffffffffc020b54c:	fff44783          	lbu	a5,-1(s0)
ffffffffc020b550:	8da2                	mv	s11,s0
ffffffffc020b552:	f74786e3          	beq	a5,s4,ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b556:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020b55a:	1dfd                	addi	s11,s11,-1
ffffffffc020b55c:	ff479de3          	bne	a5,s4,ffffffffc020b556 <vprintfmt+0xcc>
ffffffffc020b560:	bfb9                	j	ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b562:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b566:	00144583          	lbu	a1,1(s0)
ffffffffc020b56a:	846e                	mv	s0,s11
ffffffffc020b56c:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b570:	0005861b          	sext.w	a2,a1
ffffffffc020b574:	02d8e463          	bltu	a7,a3,ffffffffc020b59c <vprintfmt+0x112>
ffffffffc020b578:	00144583          	lbu	a1,1(s0)
ffffffffc020b57c:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b580:	0196873b          	addw	a4,a3,s9
ffffffffc020b584:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b588:	9f31                	addw	a4,a4,a2
ffffffffc020b58a:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b58e:	0405                	addi	s0,s0,1
ffffffffc020b590:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b594:	0005861b          	sext.w	a2,a1
ffffffffc020b598:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b578 <vprintfmt+0xee>
ffffffffc020b59c:	f40c5be3          	bgez	s8,ffffffffc020b4f2 <vprintfmt+0x68>
ffffffffc020b5a0:	8c66                	mv	s8,s9
ffffffffc020b5a2:	5cfd                	li	s9,-1
ffffffffc020b5a4:	b7b9                	j	ffffffffc020b4f2 <vprintfmt+0x68>
ffffffffc020b5a6:	fffc4693          	not	a3,s8
ffffffffc020b5aa:	96fd                	srai	a3,a3,0x3f
ffffffffc020b5ac:	00dc77b3          	and	a5,s8,a3
ffffffffc020b5b0:	00144583          	lbu	a1,1(s0)
ffffffffc020b5b4:	00078c1b          	sext.w	s8,a5
ffffffffc020b5b8:	846e                	mv	s0,s11
ffffffffc020b5ba:	bf25                	j	ffffffffc020b4f2 <vprintfmt+0x68>
ffffffffc020b5bc:	000aac83          	lw	s9,0(s5)
ffffffffc020b5c0:	00144583          	lbu	a1,1(s0)
ffffffffc020b5c4:	0aa1                	addi	s5,s5,8
ffffffffc020b5c6:	846e                	mv	s0,s11
ffffffffc020b5c8:	bfd1                	j	ffffffffc020b59c <vprintfmt+0x112>
ffffffffc020b5ca:	4705                	li	a4,1
ffffffffc020b5cc:	008a8613          	addi	a2,s5,8
ffffffffc020b5d0:	00674463          	blt	a4,t1,ffffffffc020b5d8 <vprintfmt+0x14e>
ffffffffc020b5d4:	1c030c63          	beqz	t1,ffffffffc020b7ac <vprintfmt+0x322>
ffffffffc020b5d8:	000ab683          	ld	a3,0(s5)
ffffffffc020b5dc:	4741                	li	a4,16
ffffffffc020b5de:	8ab2                	mv	s5,a2
ffffffffc020b5e0:	2801                	sext.w	a6,a6
ffffffffc020b5e2:	87e2                	mv	a5,s8
ffffffffc020b5e4:	8626                	mv	a2,s1
ffffffffc020b5e6:	85ca                	mv	a1,s2
ffffffffc020b5e8:	854e                	mv	a0,s3
ffffffffc020b5ea:	e11ff0ef          	jal	ra,ffffffffc020b3fa <printnum>
ffffffffc020b5ee:	bdc1                	j	ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b5f0:	000aa503          	lw	a0,0(s5)
ffffffffc020b5f4:	864a                	mv	a2,s2
ffffffffc020b5f6:	85a6                	mv	a1,s1
ffffffffc020b5f8:	0aa1                	addi	s5,s5,8
ffffffffc020b5fa:	9982                	jalr	s3
ffffffffc020b5fc:	b5c9                	j	ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b5fe:	4705                	li	a4,1
ffffffffc020b600:	008a8613          	addi	a2,s5,8
ffffffffc020b604:	00674463          	blt	a4,t1,ffffffffc020b60c <vprintfmt+0x182>
ffffffffc020b608:	18030d63          	beqz	t1,ffffffffc020b7a2 <vprintfmt+0x318>
ffffffffc020b60c:	000ab683          	ld	a3,0(s5)
ffffffffc020b610:	4729                	li	a4,10
ffffffffc020b612:	8ab2                	mv	s5,a2
ffffffffc020b614:	b7f1                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b616:	00144583          	lbu	a1,1(s0)
ffffffffc020b61a:	4d05                	li	s10,1
ffffffffc020b61c:	846e                	mv	s0,s11
ffffffffc020b61e:	bdd1                	j	ffffffffc020b4f2 <vprintfmt+0x68>
ffffffffc020b620:	864a                	mv	a2,s2
ffffffffc020b622:	85a6                	mv	a1,s1
ffffffffc020b624:	02500513          	li	a0,37
ffffffffc020b628:	9982                	jalr	s3
ffffffffc020b62a:	bd51                	j	ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b62c:	00144583          	lbu	a1,1(s0)
ffffffffc020b630:	2305                	addiw	t1,t1,1
ffffffffc020b632:	846e                	mv	s0,s11
ffffffffc020b634:	bd7d                	j	ffffffffc020b4f2 <vprintfmt+0x68>
ffffffffc020b636:	4705                	li	a4,1
ffffffffc020b638:	008a8613          	addi	a2,s5,8
ffffffffc020b63c:	00674463          	blt	a4,t1,ffffffffc020b644 <vprintfmt+0x1ba>
ffffffffc020b640:	14030c63          	beqz	t1,ffffffffc020b798 <vprintfmt+0x30e>
ffffffffc020b644:	000ab683          	ld	a3,0(s5)
ffffffffc020b648:	4721                	li	a4,8
ffffffffc020b64a:	8ab2                	mv	s5,a2
ffffffffc020b64c:	bf51                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b64e:	03000513          	li	a0,48
ffffffffc020b652:	864a                	mv	a2,s2
ffffffffc020b654:	85a6                	mv	a1,s1
ffffffffc020b656:	e042                	sd	a6,0(sp)
ffffffffc020b658:	9982                	jalr	s3
ffffffffc020b65a:	864a                	mv	a2,s2
ffffffffc020b65c:	85a6                	mv	a1,s1
ffffffffc020b65e:	07800513          	li	a0,120
ffffffffc020b662:	9982                	jalr	s3
ffffffffc020b664:	0aa1                	addi	s5,s5,8
ffffffffc020b666:	6802                	ld	a6,0(sp)
ffffffffc020b668:	4741                	li	a4,16
ffffffffc020b66a:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b66e:	bf8d                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b670:	000ab403          	ld	s0,0(s5)
ffffffffc020b674:	008a8793          	addi	a5,s5,8
ffffffffc020b678:	e03e                	sd	a5,0(sp)
ffffffffc020b67a:	14040c63          	beqz	s0,ffffffffc020b7d2 <vprintfmt+0x348>
ffffffffc020b67e:	11805063          	blez	s8,ffffffffc020b77e <vprintfmt+0x2f4>
ffffffffc020b682:	02d00693          	li	a3,45
ffffffffc020b686:	0cd81963          	bne	a6,a3,ffffffffc020b758 <vprintfmt+0x2ce>
ffffffffc020b68a:	00044683          	lbu	a3,0(s0)
ffffffffc020b68e:	0006851b          	sext.w	a0,a3
ffffffffc020b692:	ce8d                	beqz	a3,ffffffffc020b6cc <vprintfmt+0x242>
ffffffffc020b694:	00140a93          	addi	s5,s0,1
ffffffffc020b698:	05e00413          	li	s0,94
ffffffffc020b69c:	000cc563          	bltz	s9,ffffffffc020b6a6 <vprintfmt+0x21c>
ffffffffc020b6a0:	3cfd                	addiw	s9,s9,-1
ffffffffc020b6a2:	037c8363          	beq	s9,s7,ffffffffc020b6c8 <vprintfmt+0x23e>
ffffffffc020b6a6:	864a                	mv	a2,s2
ffffffffc020b6a8:	85a6                	mv	a1,s1
ffffffffc020b6aa:	100d0663          	beqz	s10,ffffffffc020b7b6 <vprintfmt+0x32c>
ffffffffc020b6ae:	3681                	addiw	a3,a3,-32
ffffffffc020b6b0:	10d47363          	bgeu	s0,a3,ffffffffc020b7b6 <vprintfmt+0x32c>
ffffffffc020b6b4:	03f00513          	li	a0,63
ffffffffc020b6b8:	9982                	jalr	s3
ffffffffc020b6ba:	000ac683          	lbu	a3,0(s5)
ffffffffc020b6be:	3c7d                	addiw	s8,s8,-1
ffffffffc020b6c0:	0a85                	addi	s5,s5,1
ffffffffc020b6c2:	0006851b          	sext.w	a0,a3
ffffffffc020b6c6:	faf9                	bnez	a3,ffffffffc020b69c <vprintfmt+0x212>
ffffffffc020b6c8:	01805a63          	blez	s8,ffffffffc020b6dc <vprintfmt+0x252>
ffffffffc020b6cc:	3c7d                	addiw	s8,s8,-1
ffffffffc020b6ce:	864a                	mv	a2,s2
ffffffffc020b6d0:	85a6                	mv	a1,s1
ffffffffc020b6d2:	02000513          	li	a0,32
ffffffffc020b6d6:	9982                	jalr	s3
ffffffffc020b6d8:	fe0c1ae3          	bnez	s8,ffffffffc020b6cc <vprintfmt+0x242>
ffffffffc020b6dc:	6a82                	ld	s5,0(sp)
ffffffffc020b6de:	b3c5                	j	ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b6e0:	4705                	li	a4,1
ffffffffc020b6e2:	008a8d13          	addi	s10,s5,8
ffffffffc020b6e6:	00674463          	blt	a4,t1,ffffffffc020b6ee <vprintfmt+0x264>
ffffffffc020b6ea:	0a030463          	beqz	t1,ffffffffc020b792 <vprintfmt+0x308>
ffffffffc020b6ee:	000ab403          	ld	s0,0(s5)
ffffffffc020b6f2:	0c044463          	bltz	s0,ffffffffc020b7ba <vprintfmt+0x330>
ffffffffc020b6f6:	86a2                	mv	a3,s0
ffffffffc020b6f8:	8aea                	mv	s5,s10
ffffffffc020b6fa:	4729                	li	a4,10
ffffffffc020b6fc:	b5d5                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b6fe:	000aa783          	lw	a5,0(s5)
ffffffffc020b702:	46e1                	li	a3,24
ffffffffc020b704:	0aa1                	addi	s5,s5,8
ffffffffc020b706:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b70a:	8fb9                	xor	a5,a5,a4
ffffffffc020b70c:	40e7873b          	subw	a4,a5,a4
ffffffffc020b710:	02e6c663          	blt	a3,a4,ffffffffc020b73c <vprintfmt+0x2b2>
ffffffffc020b714:	00371793          	slli	a5,a4,0x3
ffffffffc020b718:	00004697          	auipc	a3,0x4
ffffffffc020b71c:	3d868693          	addi	a3,a3,984 # ffffffffc020faf0 <error_string>
ffffffffc020b720:	97b6                	add	a5,a5,a3
ffffffffc020b722:	639c                	ld	a5,0(a5)
ffffffffc020b724:	cf81                	beqz	a5,ffffffffc020b73c <vprintfmt+0x2b2>
ffffffffc020b726:	873e                	mv	a4,a5
ffffffffc020b728:	00000697          	auipc	a3,0x0
ffffffffc020b72c:	28868693          	addi	a3,a3,648 # ffffffffc020b9b0 <etext+0x2e>
ffffffffc020b730:	8626                	mv	a2,s1
ffffffffc020b732:	85ca                	mv	a1,s2
ffffffffc020b734:	854e                	mv	a0,s3
ffffffffc020b736:	0d4000ef          	jal	ra,ffffffffc020b80a <printfmt>
ffffffffc020b73a:	b351                	j	ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b73c:	00004697          	auipc	a3,0x4
ffffffffc020b740:	07468693          	addi	a3,a3,116 # ffffffffc020f7b0 <sfs_node_fileops+0x138>
ffffffffc020b744:	8626                	mv	a2,s1
ffffffffc020b746:	85ca                	mv	a1,s2
ffffffffc020b748:	854e                	mv	a0,s3
ffffffffc020b74a:	0c0000ef          	jal	ra,ffffffffc020b80a <printfmt>
ffffffffc020b74e:	bb85                	j	ffffffffc020b4be <vprintfmt+0x34>
ffffffffc020b750:	00004417          	auipc	s0,0x4
ffffffffc020b754:	05840413          	addi	s0,s0,88 # ffffffffc020f7a8 <sfs_node_fileops+0x130>
ffffffffc020b758:	85e6                	mv	a1,s9
ffffffffc020b75a:	8522                	mv	a0,s0
ffffffffc020b75c:	e442                	sd	a6,8(sp)
ffffffffc020b75e:	132000ef          	jal	ra,ffffffffc020b890 <strnlen>
ffffffffc020b762:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b766:	01805c63          	blez	s8,ffffffffc020b77e <vprintfmt+0x2f4>
ffffffffc020b76a:	6822                	ld	a6,8(sp)
ffffffffc020b76c:	00080a9b          	sext.w	s5,a6
ffffffffc020b770:	3c7d                	addiw	s8,s8,-1
ffffffffc020b772:	864a                	mv	a2,s2
ffffffffc020b774:	85a6                	mv	a1,s1
ffffffffc020b776:	8556                	mv	a0,s5
ffffffffc020b778:	9982                	jalr	s3
ffffffffc020b77a:	fe0c1be3          	bnez	s8,ffffffffc020b770 <vprintfmt+0x2e6>
ffffffffc020b77e:	00044683          	lbu	a3,0(s0)
ffffffffc020b782:	00140a93          	addi	s5,s0,1
ffffffffc020b786:	0006851b          	sext.w	a0,a3
ffffffffc020b78a:	daa9                	beqz	a3,ffffffffc020b6dc <vprintfmt+0x252>
ffffffffc020b78c:	05e00413          	li	s0,94
ffffffffc020b790:	b731                	j	ffffffffc020b69c <vprintfmt+0x212>
ffffffffc020b792:	000aa403          	lw	s0,0(s5)
ffffffffc020b796:	bfb1                	j	ffffffffc020b6f2 <vprintfmt+0x268>
ffffffffc020b798:	000ae683          	lwu	a3,0(s5)
ffffffffc020b79c:	4721                	li	a4,8
ffffffffc020b79e:	8ab2                	mv	s5,a2
ffffffffc020b7a0:	b581                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b7a2:	000ae683          	lwu	a3,0(s5)
ffffffffc020b7a6:	4729                	li	a4,10
ffffffffc020b7a8:	8ab2                	mv	s5,a2
ffffffffc020b7aa:	bd1d                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b7ac:	000ae683          	lwu	a3,0(s5)
ffffffffc020b7b0:	4741                	li	a4,16
ffffffffc020b7b2:	8ab2                	mv	s5,a2
ffffffffc020b7b4:	b535                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b7b6:	9982                	jalr	s3
ffffffffc020b7b8:	b709                	j	ffffffffc020b6ba <vprintfmt+0x230>
ffffffffc020b7ba:	864a                	mv	a2,s2
ffffffffc020b7bc:	85a6                	mv	a1,s1
ffffffffc020b7be:	02d00513          	li	a0,45
ffffffffc020b7c2:	e042                	sd	a6,0(sp)
ffffffffc020b7c4:	9982                	jalr	s3
ffffffffc020b7c6:	6802                	ld	a6,0(sp)
ffffffffc020b7c8:	8aea                	mv	s5,s10
ffffffffc020b7ca:	408006b3          	neg	a3,s0
ffffffffc020b7ce:	4729                	li	a4,10
ffffffffc020b7d0:	bd01                	j	ffffffffc020b5e0 <vprintfmt+0x156>
ffffffffc020b7d2:	03805163          	blez	s8,ffffffffc020b7f4 <vprintfmt+0x36a>
ffffffffc020b7d6:	02d00693          	li	a3,45
ffffffffc020b7da:	f6d81be3          	bne	a6,a3,ffffffffc020b750 <vprintfmt+0x2c6>
ffffffffc020b7de:	00004417          	auipc	s0,0x4
ffffffffc020b7e2:	fca40413          	addi	s0,s0,-54 # ffffffffc020f7a8 <sfs_node_fileops+0x130>
ffffffffc020b7e6:	02800693          	li	a3,40
ffffffffc020b7ea:	02800513          	li	a0,40
ffffffffc020b7ee:	00140a93          	addi	s5,s0,1
ffffffffc020b7f2:	b55d                	j	ffffffffc020b698 <vprintfmt+0x20e>
ffffffffc020b7f4:	00004a97          	auipc	s5,0x4
ffffffffc020b7f8:	fb5a8a93          	addi	s5,s5,-75 # ffffffffc020f7a9 <sfs_node_fileops+0x131>
ffffffffc020b7fc:	02800513          	li	a0,40
ffffffffc020b800:	02800693          	li	a3,40
ffffffffc020b804:	05e00413          	li	s0,94
ffffffffc020b808:	bd51                	j	ffffffffc020b69c <vprintfmt+0x212>

ffffffffc020b80a <printfmt>:
ffffffffc020b80a:	7139                	addi	sp,sp,-64
ffffffffc020b80c:	02010313          	addi	t1,sp,32
ffffffffc020b810:	f03a                	sd	a4,32(sp)
ffffffffc020b812:	871a                	mv	a4,t1
ffffffffc020b814:	ec06                	sd	ra,24(sp)
ffffffffc020b816:	f43e                	sd	a5,40(sp)
ffffffffc020b818:	f842                	sd	a6,48(sp)
ffffffffc020b81a:	fc46                	sd	a7,56(sp)
ffffffffc020b81c:	e41a                	sd	t1,8(sp)
ffffffffc020b81e:	c6dff0ef          	jal	ra,ffffffffc020b48a <vprintfmt>
ffffffffc020b822:	60e2                	ld	ra,24(sp)
ffffffffc020b824:	6121                	addi	sp,sp,64
ffffffffc020b826:	8082                	ret

ffffffffc020b828 <snprintf>:
ffffffffc020b828:	711d                	addi	sp,sp,-96
ffffffffc020b82a:	15fd                	addi	a1,a1,-1
ffffffffc020b82c:	03810313          	addi	t1,sp,56
ffffffffc020b830:	95aa                	add	a1,a1,a0
ffffffffc020b832:	f406                	sd	ra,40(sp)
ffffffffc020b834:	fc36                	sd	a3,56(sp)
ffffffffc020b836:	e0ba                	sd	a4,64(sp)
ffffffffc020b838:	e4be                	sd	a5,72(sp)
ffffffffc020b83a:	e8c2                	sd	a6,80(sp)
ffffffffc020b83c:	ecc6                	sd	a7,88(sp)
ffffffffc020b83e:	e01a                	sd	t1,0(sp)
ffffffffc020b840:	e42a                	sd	a0,8(sp)
ffffffffc020b842:	e82e                	sd	a1,16(sp)
ffffffffc020b844:	cc02                	sw	zero,24(sp)
ffffffffc020b846:	c515                	beqz	a0,ffffffffc020b872 <snprintf+0x4a>
ffffffffc020b848:	02a5e563          	bltu	a1,a0,ffffffffc020b872 <snprintf+0x4a>
ffffffffc020b84c:	75dd                	lui	a1,0xffff7
ffffffffc020b84e:	86b2                	mv	a3,a2
ffffffffc020b850:	00000517          	auipc	a0,0x0
ffffffffc020b854:	c2050513          	addi	a0,a0,-992 # ffffffffc020b470 <sprintputch>
ffffffffc020b858:	871a                	mv	a4,t1
ffffffffc020b85a:	0030                	addi	a2,sp,8
ffffffffc020b85c:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b860:	c2bff0ef          	jal	ra,ffffffffc020b48a <vprintfmt>
ffffffffc020b864:	67a2                	ld	a5,8(sp)
ffffffffc020b866:	00078023          	sb	zero,0(a5)
ffffffffc020b86a:	4562                	lw	a0,24(sp)
ffffffffc020b86c:	70a2                	ld	ra,40(sp)
ffffffffc020b86e:	6125                	addi	sp,sp,96
ffffffffc020b870:	8082                	ret
ffffffffc020b872:	5575                	li	a0,-3
ffffffffc020b874:	bfe5                	j	ffffffffc020b86c <snprintf+0x44>

ffffffffc020b876 <strlen>:
ffffffffc020b876:	00054783          	lbu	a5,0(a0)
ffffffffc020b87a:	872a                	mv	a4,a0
ffffffffc020b87c:	4501                	li	a0,0
ffffffffc020b87e:	cb81                	beqz	a5,ffffffffc020b88e <strlen+0x18>
ffffffffc020b880:	0505                	addi	a0,a0,1
ffffffffc020b882:	00a707b3          	add	a5,a4,a0
ffffffffc020b886:	0007c783          	lbu	a5,0(a5)
ffffffffc020b88a:	fbfd                	bnez	a5,ffffffffc020b880 <strlen+0xa>
ffffffffc020b88c:	8082                	ret
ffffffffc020b88e:	8082                	ret

ffffffffc020b890 <strnlen>:
ffffffffc020b890:	4781                	li	a5,0
ffffffffc020b892:	e589                	bnez	a1,ffffffffc020b89c <strnlen+0xc>
ffffffffc020b894:	a811                	j	ffffffffc020b8a8 <strnlen+0x18>
ffffffffc020b896:	0785                	addi	a5,a5,1
ffffffffc020b898:	00f58863          	beq	a1,a5,ffffffffc020b8a8 <strnlen+0x18>
ffffffffc020b89c:	00f50733          	add	a4,a0,a5
ffffffffc020b8a0:	00074703          	lbu	a4,0(a4)
ffffffffc020b8a4:	fb6d                	bnez	a4,ffffffffc020b896 <strnlen+0x6>
ffffffffc020b8a6:	85be                	mv	a1,a5
ffffffffc020b8a8:	852e                	mv	a0,a1
ffffffffc020b8aa:	8082                	ret

ffffffffc020b8ac <strcpy>:
ffffffffc020b8ac:	87aa                	mv	a5,a0
ffffffffc020b8ae:	0005c703          	lbu	a4,0(a1)
ffffffffc020b8b2:	0785                	addi	a5,a5,1
ffffffffc020b8b4:	0585                	addi	a1,a1,1
ffffffffc020b8b6:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b8ba:	fb75                	bnez	a4,ffffffffc020b8ae <strcpy+0x2>
ffffffffc020b8bc:	8082                	ret

ffffffffc020b8be <strcmp>:
ffffffffc020b8be:	00054783          	lbu	a5,0(a0)
ffffffffc020b8c2:	0005c703          	lbu	a4,0(a1)
ffffffffc020b8c6:	cb89                	beqz	a5,ffffffffc020b8d8 <strcmp+0x1a>
ffffffffc020b8c8:	0505                	addi	a0,a0,1
ffffffffc020b8ca:	0585                	addi	a1,a1,1
ffffffffc020b8cc:	fee789e3          	beq	a5,a4,ffffffffc020b8be <strcmp>
ffffffffc020b8d0:	0007851b          	sext.w	a0,a5
ffffffffc020b8d4:	9d19                	subw	a0,a0,a4
ffffffffc020b8d6:	8082                	ret
ffffffffc020b8d8:	4501                	li	a0,0
ffffffffc020b8da:	bfed                	j	ffffffffc020b8d4 <strcmp+0x16>

ffffffffc020b8dc <strncmp>:
ffffffffc020b8dc:	c20d                	beqz	a2,ffffffffc020b8fe <strncmp+0x22>
ffffffffc020b8de:	962e                	add	a2,a2,a1
ffffffffc020b8e0:	a031                	j	ffffffffc020b8ec <strncmp+0x10>
ffffffffc020b8e2:	0505                	addi	a0,a0,1
ffffffffc020b8e4:	00e79a63          	bne	a5,a4,ffffffffc020b8f8 <strncmp+0x1c>
ffffffffc020b8e8:	00b60b63          	beq	a2,a1,ffffffffc020b8fe <strncmp+0x22>
ffffffffc020b8ec:	00054783          	lbu	a5,0(a0)
ffffffffc020b8f0:	0585                	addi	a1,a1,1
ffffffffc020b8f2:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b8f6:	f7f5                	bnez	a5,ffffffffc020b8e2 <strncmp+0x6>
ffffffffc020b8f8:	40e7853b          	subw	a0,a5,a4
ffffffffc020b8fc:	8082                	ret
ffffffffc020b8fe:	4501                	li	a0,0
ffffffffc020b900:	8082                	ret

ffffffffc020b902 <strchr>:
ffffffffc020b902:	00054783          	lbu	a5,0(a0)
ffffffffc020b906:	c799                	beqz	a5,ffffffffc020b914 <strchr+0x12>
ffffffffc020b908:	00f58763          	beq	a1,a5,ffffffffc020b916 <strchr+0x14>
ffffffffc020b90c:	00154783          	lbu	a5,1(a0)
ffffffffc020b910:	0505                	addi	a0,a0,1
ffffffffc020b912:	fbfd                	bnez	a5,ffffffffc020b908 <strchr+0x6>
ffffffffc020b914:	4501                	li	a0,0
ffffffffc020b916:	8082                	ret

ffffffffc020b918 <memset>:
ffffffffc020b918:	ca01                	beqz	a2,ffffffffc020b928 <memset+0x10>
ffffffffc020b91a:	962a                	add	a2,a2,a0
ffffffffc020b91c:	87aa                	mv	a5,a0
ffffffffc020b91e:	0785                	addi	a5,a5,1
ffffffffc020b920:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b924:	fec79de3          	bne	a5,a2,ffffffffc020b91e <memset+0x6>
ffffffffc020b928:	8082                	ret

ffffffffc020b92a <memmove>:
ffffffffc020b92a:	02a5f263          	bgeu	a1,a0,ffffffffc020b94e <memmove+0x24>
ffffffffc020b92e:	00c587b3          	add	a5,a1,a2
ffffffffc020b932:	00f57e63          	bgeu	a0,a5,ffffffffc020b94e <memmove+0x24>
ffffffffc020b936:	00c50733          	add	a4,a0,a2
ffffffffc020b93a:	c615                	beqz	a2,ffffffffc020b966 <memmove+0x3c>
ffffffffc020b93c:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b940:	17fd                	addi	a5,a5,-1
ffffffffc020b942:	177d                	addi	a4,a4,-1
ffffffffc020b944:	00d70023          	sb	a3,0(a4)
ffffffffc020b948:	fef59ae3          	bne	a1,a5,ffffffffc020b93c <memmove+0x12>
ffffffffc020b94c:	8082                	ret
ffffffffc020b94e:	00c586b3          	add	a3,a1,a2
ffffffffc020b952:	87aa                	mv	a5,a0
ffffffffc020b954:	ca11                	beqz	a2,ffffffffc020b968 <memmove+0x3e>
ffffffffc020b956:	0005c703          	lbu	a4,0(a1)
ffffffffc020b95a:	0585                	addi	a1,a1,1
ffffffffc020b95c:	0785                	addi	a5,a5,1
ffffffffc020b95e:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b962:	fed59ae3          	bne	a1,a3,ffffffffc020b956 <memmove+0x2c>
ffffffffc020b966:	8082                	ret
ffffffffc020b968:	8082                	ret

ffffffffc020b96a <memcpy>:
ffffffffc020b96a:	ca19                	beqz	a2,ffffffffc020b980 <memcpy+0x16>
ffffffffc020b96c:	962e                	add	a2,a2,a1
ffffffffc020b96e:	87aa                	mv	a5,a0
ffffffffc020b970:	0005c703          	lbu	a4,0(a1)
ffffffffc020b974:	0585                	addi	a1,a1,1
ffffffffc020b976:	0785                	addi	a5,a5,1
ffffffffc020b978:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b97c:	fec59ae3          	bne	a1,a2,ffffffffc020b970 <memcpy+0x6>
ffffffffc020b980:	8082                	ret
