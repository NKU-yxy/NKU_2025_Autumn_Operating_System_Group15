
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
ffffffffc0200062:	7b80b0ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000c597          	auipc	a1,0xc
ffffffffc020006e:	81e58593          	addi	a1,a1,-2018 # ffffffffc020b888 <etext+0x4>
ffffffffc0200072:	0000c517          	auipc	a0,0xc
ffffffffc0200076:	83650513          	addi	a0,a0,-1994 # ffffffffc020b8a8 <etext+0x24>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	2df020ef          	jal	ra,ffffffffc0202b64 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	76b030ef          	jal	ra,ffffffffc0203ffc <vmm_init>
ffffffffc0200096:	50c070ef          	jal	ra,ffffffffc02075a2 <sched_init>
ffffffffc020009a:	112070ef          	jal	ra,ffffffffc02071ac <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	1a0050ef          	jal	ra,ffffffffc0205242 <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	2ca070ef          	jal	ra,ffffffffc0207378 <cpu_idle>

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
ffffffffc02000c8:	0000b517          	auipc	a0,0xb
ffffffffc02000cc:	7e850513          	addi	a0,a0,2024 # ffffffffc020b8b0 <etext+0x2c>
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
ffffffffc020019a:	1f20b0ef          	jal	ra,ffffffffc020b38c <vprintfmt>
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
ffffffffc02001d6:	1b60b0ef          	jal	ra,ffffffffc020b38c <vprintfmt>
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
ffffffffc0200200:	5780b0ef          	jal	ra,ffffffffc020b778 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	61b010ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	6560b0ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc0200232:	68a50513          	addi	a0,a0,1674 # ffffffffc020b8b8 <etext+0x34>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	69450513          	addi	a0,a0,1684 # ffffffffc020b8d8 <etext+0x54>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	63458593          	addi	a1,a1,1588 # ffffffffc020b884 <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	6a050513          	addi	a0,a0,1696 # ffffffffc020b8f8 <etext+0x74>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	6ac50513          	addi	a0,a0,1708 # ffffffffc020b918 <etext+0x94>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	6b850513          	addi	a0,a0,1720 # ffffffffc020b938 <etext+0xb4>
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
ffffffffc02002b2:	6aa50513          	addi	a0,a0,1706 # ffffffffc020b958 <etext+0xd4>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	6cc60613          	addi	a2,a2,1740 # ffffffffc020b988 <etext+0x104>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	6d850513          	addi	a0,a0,1752 # ffffffffc020b9a0 <etext+0x11c>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	6e060613          	addi	a2,a2,1760 # ffffffffc020b9b8 <etext+0x134>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	6f858593          	addi	a1,a1,1784 # ffffffffc020b9d8 <etext+0x154>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	6f850513          	addi	a0,a0,1784 # ffffffffc020b9e0 <etext+0x15c>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	6fa60613          	addi	a2,a2,1786 # ffffffffc020b9f0 <etext+0x16c>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	71a58593          	addi	a1,a1,1818 # ffffffffc020ba18 <etext+0x194>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	6da50513          	addi	a0,a0,1754 # ffffffffc020b9e0 <etext+0x15c>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	71660613          	addi	a2,a2,1814 # ffffffffc020ba28 <etext+0x1a4>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	72e58593          	addi	a1,a1,1838 # ffffffffc020ba48 <etext+0x1c4>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	6be50513          	addi	a0,a0,1726 # ffffffffc020b9e0 <etext+0x15c>
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
ffffffffc0200360:	6fc50513          	addi	a0,a0,1788 # ffffffffc020ba58 <etext+0x1d4>
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
ffffffffc020037e:	0000b517          	auipc	a0,0xb
ffffffffc0200382:	70250513          	addi	a0,a0,1794 # ffffffffc020ba80 <etext+0x1fc>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	75cc0c13          	addi	s8,s8,1884 # ffffffffc020baf0 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	70c90913          	addi	s2,s2,1804 # ffffffffc020baa8 <etext+0x224>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	70c48493          	addi	s1,s1,1804 # ffffffffc020bab0 <etext+0x22c>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	70ab0b13          	addi	s6,s6,1802 # ffffffffc020bab8 <etext+0x234>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	622a0a13          	addi	s4,s4,1570 # ffffffffc020b9d8 <etext+0x154>
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
ffffffffc02003d8:	0000bd17          	auipc	s10,0xb
ffffffffc02003dc:	718d0d13          	addi	s10,s10,1816 # ffffffffc020baf0 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	3da0b0ef          	jal	ra,ffffffffc020b7c0 <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	3c60b0ef          	jal	ra,ffffffffc020b7c0 <strcmp>
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
ffffffffc0200438:	3cc0b0ef          	jal	ra,ffffffffc020b804 <strchr>
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
ffffffffc0200476:	38e0b0ef          	jal	ra,ffffffffc020b804 <strchr>
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
ffffffffc0200494:	64850513          	addi	a0,a0,1608 # ffffffffc020bad8 <etext+0x254>
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
ffffffffc02004d0:	66c50513          	addi	a0,a0,1644 # ffffffffc020bb38 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000d517          	auipc	a0,0xd
ffffffffc02004e6:	94e50513          	addi	a0,a0,-1714 # ffffffffc020ce30 <default_pmm_manager+0x610>
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
ffffffffc020051a:	64250513          	addi	a0,a0,1602 # ffffffffc020bb58 <commands+0x68>
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
ffffffffc020053a:	8fa50513          	addi	a0,a0,-1798 # ffffffffc020ce30 <default_pmm_manager+0x610>
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
ffffffffc020056c:	61050513          	addi	a0,a0,1552 # ffffffffc020bb78 <commands+0x88>
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
ffffffffc02006b2:	4ea50513          	addi	a0,a0,1258 # ffffffffc020bb98 <commands+0xa8>
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
ffffffffc02006e0:	4cc50513          	addi	a0,a0,1228 # ffffffffc020bba8 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	4c650513          	addi	a0,a0,1222 # ffffffffc020bbb8 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	4ce50513          	addi	a0,a0,1230 # ffffffffc020bbd0 <commands+0xe0>
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
ffffffffc02007c0:	46490913          	addi	s2,s2,1124 # ffffffffc020bc20 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	44e48493          	addi	s1,s1,1102 # ffffffffc020bc18 <commands+0x128>
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
ffffffffc0200822:	47a50513          	addi	a0,a0,1146 # ffffffffc020bc98 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	4a650513          	addi	a0,a0,1190 # ffffffffc020bcd0 <commands+0x1e0>
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
ffffffffc020086e:	38650513          	addi	a0,a0,902 # ffffffffc020bbf0 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	7010a0ef          	jal	ra,ffffffffc020b778 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	7590a0ef          	jal	ra,ffffffffc020b7de <strncmp>
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
ffffffffc020091c:	6a50a0ef          	jal	ra,ffffffffc020b7c0 <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	2f850513          	addi	a0,a0,760 # ffffffffc020bc28 <commands+0x138>
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
ffffffffc0200a02:	24a50513          	addi	a0,a0,586 # ffffffffc020bc48 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	25050513          	addi	a0,a0,592 # ffffffffc020bc60 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	25e50513          	addi	a0,a0,606 # ffffffffc020bc80 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	2a250513          	addi	a0,a0,674 # ffffffffc020bcd0 <commands+0x1e0>
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
ffffffffc0200abc:	23068693          	addi	a3,a3,560 # ffffffffc020bce8 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	24060613          	addi	a2,a2,576 # ffffffffc020bd00 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	24e50513          	addi	a0,a0,590 # ffffffffc020bd18 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	25a68693          	addi	a3,a3,602 # ffffffffc020bd30 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	22260613          	addi	a2,a2,546 # ffffffffc020bd00 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	23050513          	addi	a0,a0,560 # ffffffffc020bd18 <commands+0x228>
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
ffffffffc0200b9a:	1b268693          	addi	a3,a3,434 # ffffffffc020bd48 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	16260613          	addi	a2,a2,354 # ffffffffc020bd00 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	16e50513          	addi	a0,a0,366 # ffffffffc020bd18 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	1ba68693          	addi	a3,a3,442 # ffffffffc020bd70 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	14260613          	addi	a2,a2,322 # ffffffffc020bd00 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	14e50513          	addi	a0,a0,334 # ffffffffc020bd18 <commands+0x228>
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
ffffffffc0200c30:	11c68693          	addi	a3,a3,284 # ffffffffc020bd48 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	0cc60613          	addi	a2,a2,204 # ffffffffc020bd00 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	0d850513          	addi	a0,a0,216 # ffffffffc020bd18 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	12468693          	addi	a3,a3,292 # ffffffffc020bd70 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	0ac60613          	addi	a2,a2,172 # ffffffffc020bd00 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	0b850513          	addi	a0,a0,184 # ffffffffc020bd18 <commands+0x228>
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
ffffffffc0200c98:	3d50a0ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc0200cc2:	3ab0a0ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc0200ce4:	3370a0ef          	jal	ra,ffffffffc020b81a <memset>
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
ffffffffc0200d16:	0b650513          	addi	a0,a0,182 # ffffffffc020bdc8 <commands+0x2d8>
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
ffffffffc0200d38:	0ec58593          	addi	a1,a1,236 # ffffffffc020be20 <commands+0x330>
ffffffffc0200d3c:	2730a0ef          	jal	ra,ffffffffc020b7ae <strcpy>
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
ffffffffc0200d80:	03450513          	addi	a0,a0,52 # ffffffffc020bdb0 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	06660613          	addi	a2,a2,102 # ffffffffc020bdf0 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	07250513          	addi	a0,a0,114 # ffffffffc020be08 <commands+0x318>
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
ffffffffc0200dc8:	06c50513          	addi	a0,a0,108 # ffffffffc020be30 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	07450513          	addi	a0,a0,116 # ffffffffc020be48 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	07e50513          	addi	a0,a0,126 # ffffffffc020be60 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	08850513          	addi	a0,a0,136 # ffffffffc020be78 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	09250513          	addi	a0,a0,146 # ffffffffc020be90 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	09c50513          	addi	a0,a0,156 # ffffffffc020bea8 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	0a650513          	addi	a0,a0,166 # ffffffffc020bec0 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	0b050513          	addi	a0,a0,176 # ffffffffc020bed8 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	0ba50513          	addi	a0,a0,186 # ffffffffc020bef0 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	0c450513          	addi	a0,a0,196 # ffffffffc020bf08 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	0ce50513          	addi	a0,a0,206 # ffffffffc020bf20 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	0d850513          	addi	a0,a0,216 # ffffffffc020bf38 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	0e250513          	addi	a0,a0,226 # ffffffffc020bf50 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	0ec50513          	addi	a0,a0,236 # ffffffffc020bf68 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	0f650513          	addi	a0,a0,246 # ffffffffc020bf80 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	10050513          	addi	a0,a0,256 # ffffffffc020bf98 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	10a50513          	addi	a0,a0,266 # ffffffffc020bfb0 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	11450513          	addi	a0,a0,276 # ffffffffc020bfc8 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	11e50513          	addi	a0,a0,286 # ffffffffc020bfe0 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	12850513          	addi	a0,a0,296 # ffffffffc020bff8 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	13250513          	addi	a0,a0,306 # ffffffffc020c010 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	13c50513          	addi	a0,a0,316 # ffffffffc020c028 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	14650513          	addi	a0,a0,326 # ffffffffc020c040 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	15050513          	addi	a0,a0,336 # ffffffffc020c058 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	15a50513          	addi	a0,a0,346 # ffffffffc020c070 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	16450513          	addi	a0,a0,356 # ffffffffc020c088 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	16e50513          	addi	a0,a0,366 # ffffffffc020c0a0 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	17850513          	addi	a0,a0,376 # ffffffffc020c0b8 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	18250513          	addi	a0,a0,386 # ffffffffc020c0d0 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	18c50513          	addi	a0,a0,396 # ffffffffc020c0e8 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	19650513          	addi	a0,a0,406 # ffffffffc020c100 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	19c50513          	addi	a0,a0,412 # ffffffffc020c118 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	19e50513          	addi	a0,a0,414 # ffffffffc020c130 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	19e50513          	addi	a0,a0,414 # ffffffffc020c148 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	1a650513          	addi	a0,a0,422 # ffffffffc020c160 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	1ae50513          	addi	a0,a0,430 # ffffffffc020c178 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	1aa50513          	addi	a0,a0,426 # ffffffffc020c188 <commands+0x698>
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
ffffffffc020103c:	1c050513          	addi	a0,a0,448 # ffffffffc020c1f8 <commands+0x708>
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
ffffffffc0201064:	17060613          	addi	a2,a2,368 # ffffffffc020c1d0 <commands+0x6e0>
ffffffffc0201068:	06c00593          	li	a1,108
ffffffffc020106c:	0000b517          	auipc	a0,0xb
ffffffffc0201070:	14c50513          	addi	a0,a0,332 # ffffffffc020c1b8 <commands+0x6c8>
ffffffffc0201074:	c2aff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201078:	f13ff0ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc020107c:	0000b617          	auipc	a2,0xb
ffffffffc0201080:	12460613          	addi	a2,a2,292 # ffffffffc020c1a0 <commands+0x6b0>
ffffffffc0201084:	06700593          	li	a1,103
ffffffffc0201088:	0000b517          	auipc	a0,0xb
ffffffffc020108c:	13050513          	addi	a0,a0,304 # ffffffffc020c1b8 <commands+0x6c8>
ffffffffc0201090:	c0eff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201094 <interrupt_handler>:
ffffffffc0201094:	11853783          	ld	a5,280(a0)
ffffffffc0201098:	472d                	li	a4,11
ffffffffc020109a:	0786                	slli	a5,a5,0x1
ffffffffc020109c:	8385                	srli	a5,a5,0x1
ffffffffc020109e:	06f76c63          	bltu	a4,a5,ffffffffc0201116 <interrupt_handler+0x82>
ffffffffc02010a2:	0000b717          	auipc	a4,0xb
ffffffffc02010a6:	23670713          	addi	a4,a4,566 # ffffffffc020c2d8 <commands+0x7e8>
ffffffffc02010aa:	078a                	slli	a5,a5,0x2
ffffffffc02010ac:	97ba                	add	a5,a5,a4
ffffffffc02010ae:	439c                	lw	a5,0(a5)
ffffffffc02010b0:	97ba                	add	a5,a5,a4
ffffffffc02010b2:	8782                	jr	a5
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	1e450513          	addi	a0,a0,484 # ffffffffc020c298 <commands+0x7a8>
ffffffffc02010bc:	8eaff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c0:	0000b517          	auipc	a0,0xb
ffffffffc02010c4:	1b850513          	addi	a0,a0,440 # ffffffffc020c278 <commands+0x788>
ffffffffc02010c8:	8deff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010cc:	0000b517          	auipc	a0,0xb
ffffffffc02010d0:	16c50513          	addi	a0,a0,364 # ffffffffc020c238 <commands+0x748>
ffffffffc02010d4:	8d2ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010d8:	0000b517          	auipc	a0,0xb
ffffffffc02010dc:	18050513          	addi	a0,a0,384 # ffffffffc020c258 <commands+0x768>
ffffffffc02010e0:	8c6ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010e4:	1141                	addi	sp,sp,-16
ffffffffc02010e6:	e406                	sd	ra,8(sp)
ffffffffc02010e8:	c92ff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc02010ec:	00095717          	auipc	a4,0x95
ffffffffc02010f0:	78470713          	addi	a4,a4,1924 # ffffffffc0296870 <ticks>
ffffffffc02010f4:	631c                	ld	a5,0(a4)
ffffffffc02010f6:	0785                	addi	a5,a5,1
ffffffffc02010f8:	e31c                	sd	a5,0(a4)
ffffffffc02010fa:	7b8060ef          	jal	ra,ffffffffc02078b2 <run_timer_list>
ffffffffc02010fe:	cf6ff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc0201102:	60a2                	ld	ra,8(sp)
ffffffffc0201104:	0141                	addi	sp,sp,16
ffffffffc0201106:	67d0706f          	j	ffffffffc0208f82 <dev_stdin_write>
ffffffffc020110a:	0000b517          	auipc	a0,0xb
ffffffffc020110e:	1ae50513          	addi	a0,a0,430 # ffffffffc020c2b8 <commands+0x7c8>
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
ffffffffc020112e:	30e70713          	addi	a4,a4,782 # ffffffffc020c438 <commands+0x948>
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
ffffffffc0201148:	29450513          	addi	a0,a0,660 # ffffffffc020c3d8 <commands+0x8e8>
ffffffffc020114c:	85aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201150:	10843783          	ld	a5,264(s0)
ffffffffc0201154:	60a2                	ld	ra,8(sp)
ffffffffc0201156:	0791                	addi	a5,a5,4
ffffffffc0201158:	10f43423          	sd	a5,264(s0)
ffffffffc020115c:	6402                	ld	s0,0(sp)
ffffffffc020115e:	0141                	addi	sp,sp,16
ffffffffc0201160:	1690606f          	j	ffffffffc0207ac8 <syscall>
ffffffffc0201164:	0000b517          	auipc	a0,0xb
ffffffffc0201168:	1a450513          	addi	a0,a0,420 # ffffffffc020c308 <commands+0x818>
ffffffffc020116c:	6402                	ld	s0,0(sp)
ffffffffc020116e:	60a2                	ld	ra,8(sp)
ffffffffc0201170:	0141                	addi	sp,sp,16
ffffffffc0201172:	834ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201176:	0000b517          	auipc	a0,0xb
ffffffffc020117a:	1b250513          	addi	a0,a0,434 # ffffffffc020c328 <commands+0x838>
ffffffffc020117e:	b7fd                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc0201180:	0000b517          	auipc	a0,0xb
ffffffffc0201184:	1c850513          	addi	a0,a0,456 # ffffffffc020c348 <commands+0x858>
ffffffffc0201188:	b7d5                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc020118a:	0000b517          	auipc	a0,0xb
ffffffffc020118e:	28e50513          	addi	a0,a0,654 # ffffffffc020c418 <commands+0x928>
ffffffffc0201192:	bfe9                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc0201194:	0000b517          	auipc	a0,0xb
ffffffffc0201198:	26450513          	addi	a0,a0,612 # ffffffffc020c3f8 <commands+0x908>
ffffffffc020119c:	bfc1                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc020119e:	0000b517          	auipc	a0,0xb
ffffffffc02011a2:	22250513          	addi	a0,a0,546 # ffffffffc020c3c0 <commands+0x8d0>
ffffffffc02011a6:	b7d9                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011a8:	0000b517          	auipc	a0,0xb
ffffffffc02011ac:	1b850513          	addi	a0,a0,440 # ffffffffc020c360 <commands+0x870>
ffffffffc02011b0:	bf75                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011b2:	0000b517          	auipc	a0,0xb
ffffffffc02011b6:	1be50513          	addi	a0,a0,446 # ffffffffc020c370 <commands+0x880>
ffffffffc02011ba:	bf4d                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011bc:	0000b517          	auipc	a0,0xb
ffffffffc02011c0:	1d450513          	addi	a0,a0,468 # ffffffffc020c390 <commands+0x8a0>
ffffffffc02011c4:	b765                	j	ffffffffc020116c <exception_handler+0x54>
ffffffffc02011c6:	8522                	mv	a0,s0
ffffffffc02011c8:	6402                	ld	s0,0(sp)
ffffffffc02011ca:	60a2                	ld	ra,8(sp)
ffffffffc02011cc:	0141                	addi	sp,sp,16
ffffffffc02011ce:	bb75                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc02011d0:	0000b617          	auipc	a2,0xb
ffffffffc02011d4:	1d860613          	addi	a2,a2,472 # ffffffffc020c3a8 <commands+0x8b8>
ffffffffc02011d8:	0c800593          	li	a1,200
ffffffffc02011dc:	0000b517          	auipc	a0,0xb
ffffffffc02011e0:	fdc50513          	addi	a0,a0,-36 # ffffffffc020c1b8 <commands+0x6c8>
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
ffffffffc0201264:	4420606f          	j	ffffffffc02076a6 <schedule>
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
ffffffffc02013fe:	61e63603          	ld	a2,1566(a2) # ffffffffc020fa18 <nbase>
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
ffffffffc0201644:	e3868693          	addi	a3,a3,-456 # ffffffffc020c478 <commands+0x988>
ffffffffc0201648:	0000a617          	auipc	a2,0xa
ffffffffc020164c:	6b860613          	addi	a2,a2,1720 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201650:	0ef00593          	li	a1,239
ffffffffc0201654:	0000b517          	auipc	a0,0xb
ffffffffc0201658:	e3450513          	addi	a0,a0,-460 # ffffffffc020c488 <commands+0x998>
ffffffffc020165c:	e43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201660:	0000b697          	auipc	a3,0xb
ffffffffc0201664:	ec068693          	addi	a3,a3,-320 # ffffffffc020c520 <commands+0xa30>
ffffffffc0201668:	0000a617          	auipc	a2,0xa
ffffffffc020166c:	69860613          	addi	a2,a2,1688 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201670:	0bc00593          	li	a1,188
ffffffffc0201674:	0000b517          	auipc	a0,0xb
ffffffffc0201678:	e1450513          	addi	a0,a0,-492 # ffffffffc020c488 <commands+0x998>
ffffffffc020167c:	e23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201680:	0000b697          	auipc	a3,0xb
ffffffffc0201684:	ec868693          	addi	a3,a3,-312 # ffffffffc020c548 <commands+0xa58>
ffffffffc0201688:	0000a617          	auipc	a2,0xa
ffffffffc020168c:	67860613          	addi	a2,a2,1656 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201690:	0bd00593          	li	a1,189
ffffffffc0201694:	0000b517          	auipc	a0,0xb
ffffffffc0201698:	df450513          	addi	a0,a0,-524 # ffffffffc020c488 <commands+0x998>
ffffffffc020169c:	e03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016a0:	0000b697          	auipc	a3,0xb
ffffffffc02016a4:	ee868693          	addi	a3,a3,-280 # ffffffffc020c588 <commands+0xa98>
ffffffffc02016a8:	0000a617          	auipc	a2,0xa
ffffffffc02016ac:	65860613          	addi	a2,a2,1624 # ffffffffc020bd00 <commands+0x210>
ffffffffc02016b0:	0bf00593          	li	a1,191
ffffffffc02016b4:	0000b517          	auipc	a0,0xb
ffffffffc02016b8:	dd450513          	addi	a0,a0,-556 # ffffffffc020c488 <commands+0x998>
ffffffffc02016bc:	de3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016c0:	0000b697          	auipc	a3,0xb
ffffffffc02016c4:	f5068693          	addi	a3,a3,-176 # ffffffffc020c610 <commands+0xb20>
ffffffffc02016c8:	0000a617          	auipc	a2,0xa
ffffffffc02016cc:	63860613          	addi	a2,a2,1592 # ffffffffc020bd00 <commands+0x210>
ffffffffc02016d0:	0d800593          	li	a1,216
ffffffffc02016d4:	0000b517          	auipc	a0,0xb
ffffffffc02016d8:	db450513          	addi	a0,a0,-588 # ffffffffc020c488 <commands+0x998>
ffffffffc02016dc:	dc3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016e0:	0000b697          	auipc	a3,0xb
ffffffffc02016e4:	de068693          	addi	a3,a3,-544 # ffffffffc020c4c0 <commands+0x9d0>
ffffffffc02016e8:	0000a617          	auipc	a2,0xa
ffffffffc02016ec:	61860613          	addi	a2,a2,1560 # ffffffffc020bd00 <commands+0x210>
ffffffffc02016f0:	0d100593          	li	a1,209
ffffffffc02016f4:	0000b517          	auipc	a0,0xb
ffffffffc02016f8:	d9450513          	addi	a0,a0,-620 # ffffffffc020c488 <commands+0x998>
ffffffffc02016fc:	da3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201700:	0000b697          	auipc	a3,0xb
ffffffffc0201704:	f0068693          	addi	a3,a3,-256 # ffffffffc020c600 <commands+0xb10>
ffffffffc0201708:	0000a617          	auipc	a2,0xa
ffffffffc020170c:	5f860613          	addi	a2,a2,1528 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201710:	0cf00593          	li	a1,207
ffffffffc0201714:	0000b517          	auipc	a0,0xb
ffffffffc0201718:	d7450513          	addi	a0,a0,-652 # ffffffffc020c488 <commands+0x998>
ffffffffc020171c:	d83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201720:	0000b697          	auipc	a3,0xb
ffffffffc0201724:	ec868693          	addi	a3,a3,-312 # ffffffffc020c5e8 <commands+0xaf8>
ffffffffc0201728:	0000a617          	auipc	a2,0xa
ffffffffc020172c:	5d860613          	addi	a2,a2,1496 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201730:	0ca00593          	li	a1,202
ffffffffc0201734:	0000b517          	auipc	a0,0xb
ffffffffc0201738:	d5450513          	addi	a0,a0,-684 # ffffffffc020c488 <commands+0x998>
ffffffffc020173c:	d63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201740:	0000b697          	auipc	a3,0xb
ffffffffc0201744:	e8868693          	addi	a3,a3,-376 # ffffffffc020c5c8 <commands+0xad8>
ffffffffc0201748:	0000a617          	auipc	a2,0xa
ffffffffc020174c:	5b860613          	addi	a2,a2,1464 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201750:	0c100593          	li	a1,193
ffffffffc0201754:	0000b517          	auipc	a0,0xb
ffffffffc0201758:	d3450513          	addi	a0,a0,-716 # ffffffffc020c488 <commands+0x998>
ffffffffc020175c:	d43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201760:	0000b697          	auipc	a3,0xb
ffffffffc0201764:	ef868693          	addi	a3,a3,-264 # ffffffffc020c658 <commands+0xb68>
ffffffffc0201768:	0000a617          	auipc	a2,0xa
ffffffffc020176c:	59860613          	addi	a2,a2,1432 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201770:	0f700593          	li	a1,247
ffffffffc0201774:	0000b517          	auipc	a0,0xb
ffffffffc0201778:	d1450513          	addi	a0,a0,-748 # ffffffffc020c488 <commands+0x998>
ffffffffc020177c:	d23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201780:	0000b697          	auipc	a3,0xb
ffffffffc0201784:	ec868693          	addi	a3,a3,-312 # ffffffffc020c648 <commands+0xb58>
ffffffffc0201788:	0000a617          	auipc	a2,0xa
ffffffffc020178c:	57860613          	addi	a2,a2,1400 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201790:	0de00593          	li	a1,222
ffffffffc0201794:	0000b517          	auipc	a0,0xb
ffffffffc0201798:	cf450513          	addi	a0,a0,-780 # ffffffffc020c488 <commands+0x998>
ffffffffc020179c:	d03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017a0:	0000b697          	auipc	a3,0xb
ffffffffc02017a4:	e4868693          	addi	a3,a3,-440 # ffffffffc020c5e8 <commands+0xaf8>
ffffffffc02017a8:	0000a617          	auipc	a2,0xa
ffffffffc02017ac:	55860613          	addi	a2,a2,1368 # ffffffffc020bd00 <commands+0x210>
ffffffffc02017b0:	0dc00593          	li	a1,220
ffffffffc02017b4:	0000b517          	auipc	a0,0xb
ffffffffc02017b8:	cd450513          	addi	a0,a0,-812 # ffffffffc020c488 <commands+0x998>
ffffffffc02017bc:	ce3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017c0:	0000b697          	auipc	a3,0xb
ffffffffc02017c4:	e6868693          	addi	a3,a3,-408 # ffffffffc020c628 <commands+0xb38>
ffffffffc02017c8:	0000a617          	auipc	a2,0xa
ffffffffc02017cc:	53860613          	addi	a2,a2,1336 # ffffffffc020bd00 <commands+0x210>
ffffffffc02017d0:	0db00593          	li	a1,219
ffffffffc02017d4:	0000b517          	auipc	a0,0xb
ffffffffc02017d8:	cb450513          	addi	a0,a0,-844 # ffffffffc020c488 <commands+0x998>
ffffffffc02017dc:	cc3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017e0:	0000b697          	auipc	a3,0xb
ffffffffc02017e4:	ce068693          	addi	a3,a3,-800 # ffffffffc020c4c0 <commands+0x9d0>
ffffffffc02017e8:	0000a617          	auipc	a2,0xa
ffffffffc02017ec:	51860613          	addi	a2,a2,1304 # ffffffffc020bd00 <commands+0x210>
ffffffffc02017f0:	0b800593          	li	a1,184
ffffffffc02017f4:	0000b517          	auipc	a0,0xb
ffffffffc02017f8:	c9450513          	addi	a0,a0,-876 # ffffffffc020c488 <commands+0x998>
ffffffffc02017fc:	ca3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201800:	0000b697          	auipc	a3,0xb
ffffffffc0201804:	de868693          	addi	a3,a3,-536 # ffffffffc020c5e8 <commands+0xaf8>
ffffffffc0201808:	0000a617          	auipc	a2,0xa
ffffffffc020180c:	4f860613          	addi	a2,a2,1272 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201810:	0d500593          	li	a1,213
ffffffffc0201814:	0000b517          	auipc	a0,0xb
ffffffffc0201818:	c7450513          	addi	a0,a0,-908 # ffffffffc020c488 <commands+0x998>
ffffffffc020181c:	c83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201820:	0000b697          	auipc	a3,0xb
ffffffffc0201824:	ce068693          	addi	a3,a3,-800 # ffffffffc020c500 <commands+0xa10>
ffffffffc0201828:	0000a617          	auipc	a2,0xa
ffffffffc020182c:	4d860613          	addi	a2,a2,1240 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201830:	0d300593          	li	a1,211
ffffffffc0201834:	0000b517          	auipc	a0,0xb
ffffffffc0201838:	c5450513          	addi	a0,a0,-940 # ffffffffc020c488 <commands+0x998>
ffffffffc020183c:	c63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201840:	0000b697          	auipc	a3,0xb
ffffffffc0201844:	ca068693          	addi	a3,a3,-864 # ffffffffc020c4e0 <commands+0x9f0>
ffffffffc0201848:	0000a617          	auipc	a2,0xa
ffffffffc020184c:	4b860613          	addi	a2,a2,1208 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201850:	0d200593          	li	a1,210
ffffffffc0201854:	0000b517          	auipc	a0,0xb
ffffffffc0201858:	c3450513          	addi	a0,a0,-972 # ffffffffc020c488 <commands+0x998>
ffffffffc020185c:	c43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201860:	0000b697          	auipc	a3,0xb
ffffffffc0201864:	ca068693          	addi	a3,a3,-864 # ffffffffc020c500 <commands+0xa10>
ffffffffc0201868:	0000a617          	auipc	a2,0xa
ffffffffc020186c:	49860613          	addi	a2,a2,1176 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201870:	0ba00593          	li	a1,186
ffffffffc0201874:	0000b517          	auipc	a0,0xb
ffffffffc0201878:	c1450513          	addi	a0,a0,-1004 # ffffffffc020c488 <commands+0x998>
ffffffffc020187c:	c23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201880:	0000b697          	auipc	a3,0xb
ffffffffc0201884:	f2868693          	addi	a3,a3,-216 # ffffffffc020c7a8 <commands+0xcb8>
ffffffffc0201888:	0000a617          	auipc	a2,0xa
ffffffffc020188c:	47860613          	addi	a2,a2,1144 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201890:	12400593          	li	a1,292
ffffffffc0201894:	0000b517          	auipc	a0,0xb
ffffffffc0201898:	bf450513          	addi	a0,a0,-1036 # ffffffffc020c488 <commands+0x998>
ffffffffc020189c:	c03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018a0:	0000b697          	auipc	a3,0xb
ffffffffc02018a4:	da868693          	addi	a3,a3,-600 # ffffffffc020c648 <commands+0xb58>
ffffffffc02018a8:	0000a617          	auipc	a2,0xa
ffffffffc02018ac:	45860613          	addi	a2,a2,1112 # ffffffffc020bd00 <commands+0x210>
ffffffffc02018b0:	11900593          	li	a1,281
ffffffffc02018b4:	0000b517          	auipc	a0,0xb
ffffffffc02018b8:	bd450513          	addi	a0,a0,-1068 # ffffffffc020c488 <commands+0x998>
ffffffffc02018bc:	be3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018c0:	0000b697          	auipc	a3,0xb
ffffffffc02018c4:	d2868693          	addi	a3,a3,-728 # ffffffffc020c5e8 <commands+0xaf8>
ffffffffc02018c8:	0000a617          	auipc	a2,0xa
ffffffffc02018cc:	43860613          	addi	a2,a2,1080 # ffffffffc020bd00 <commands+0x210>
ffffffffc02018d0:	11700593          	li	a1,279
ffffffffc02018d4:	0000b517          	auipc	a0,0xb
ffffffffc02018d8:	bb450513          	addi	a0,a0,-1100 # ffffffffc020c488 <commands+0x998>
ffffffffc02018dc:	bc3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018e0:	0000b697          	auipc	a3,0xb
ffffffffc02018e4:	cc868693          	addi	a3,a3,-824 # ffffffffc020c5a8 <commands+0xab8>
ffffffffc02018e8:	0000a617          	auipc	a2,0xa
ffffffffc02018ec:	41860613          	addi	a2,a2,1048 # ffffffffc020bd00 <commands+0x210>
ffffffffc02018f0:	0c000593          	li	a1,192
ffffffffc02018f4:	0000b517          	auipc	a0,0xb
ffffffffc02018f8:	b9450513          	addi	a0,a0,-1132 # ffffffffc020c488 <commands+0x998>
ffffffffc02018fc:	ba3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201900:	0000b697          	auipc	a3,0xb
ffffffffc0201904:	e6868693          	addi	a3,a3,-408 # ffffffffc020c768 <commands+0xc78>
ffffffffc0201908:	0000a617          	auipc	a2,0xa
ffffffffc020190c:	3f860613          	addi	a2,a2,1016 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201910:	11100593          	li	a1,273
ffffffffc0201914:	0000b517          	auipc	a0,0xb
ffffffffc0201918:	b7450513          	addi	a0,a0,-1164 # ffffffffc020c488 <commands+0x998>
ffffffffc020191c:	b83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201920:	0000b697          	auipc	a3,0xb
ffffffffc0201924:	e2868693          	addi	a3,a3,-472 # ffffffffc020c748 <commands+0xc58>
ffffffffc0201928:	0000a617          	auipc	a2,0xa
ffffffffc020192c:	3d860613          	addi	a2,a2,984 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201930:	10f00593          	li	a1,271
ffffffffc0201934:	0000b517          	auipc	a0,0xb
ffffffffc0201938:	b5450513          	addi	a0,a0,-1196 # ffffffffc020c488 <commands+0x998>
ffffffffc020193c:	b63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201940:	0000b697          	auipc	a3,0xb
ffffffffc0201944:	de068693          	addi	a3,a3,-544 # ffffffffc020c720 <commands+0xc30>
ffffffffc0201948:	0000a617          	auipc	a2,0xa
ffffffffc020194c:	3b860613          	addi	a2,a2,952 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201950:	10d00593          	li	a1,269
ffffffffc0201954:	0000b517          	auipc	a0,0xb
ffffffffc0201958:	b3450513          	addi	a0,a0,-1228 # ffffffffc020c488 <commands+0x998>
ffffffffc020195c:	b43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201960:	0000b697          	auipc	a3,0xb
ffffffffc0201964:	d9868693          	addi	a3,a3,-616 # ffffffffc020c6f8 <commands+0xc08>
ffffffffc0201968:	0000a617          	auipc	a2,0xa
ffffffffc020196c:	39860613          	addi	a2,a2,920 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201970:	10c00593          	li	a1,268
ffffffffc0201974:	0000b517          	auipc	a0,0xb
ffffffffc0201978:	b1450513          	addi	a0,a0,-1260 # ffffffffc020c488 <commands+0x998>
ffffffffc020197c:	b23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201980:	0000b697          	auipc	a3,0xb
ffffffffc0201984:	d6868693          	addi	a3,a3,-664 # ffffffffc020c6e8 <commands+0xbf8>
ffffffffc0201988:	0000a617          	auipc	a2,0xa
ffffffffc020198c:	37860613          	addi	a2,a2,888 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201990:	10700593          	li	a1,263
ffffffffc0201994:	0000b517          	auipc	a0,0xb
ffffffffc0201998:	af450513          	addi	a0,a0,-1292 # ffffffffc020c488 <commands+0x998>
ffffffffc020199c:	b03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019a0:	0000b697          	auipc	a3,0xb
ffffffffc02019a4:	c4868693          	addi	a3,a3,-952 # ffffffffc020c5e8 <commands+0xaf8>
ffffffffc02019a8:	0000a617          	auipc	a2,0xa
ffffffffc02019ac:	35860613          	addi	a2,a2,856 # ffffffffc020bd00 <commands+0x210>
ffffffffc02019b0:	10600593          	li	a1,262
ffffffffc02019b4:	0000b517          	auipc	a0,0xb
ffffffffc02019b8:	ad450513          	addi	a0,a0,-1324 # ffffffffc020c488 <commands+0x998>
ffffffffc02019bc:	ae3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019c0:	0000b697          	auipc	a3,0xb
ffffffffc02019c4:	d0868693          	addi	a3,a3,-760 # ffffffffc020c6c8 <commands+0xbd8>
ffffffffc02019c8:	0000a617          	auipc	a2,0xa
ffffffffc02019cc:	33860613          	addi	a2,a2,824 # ffffffffc020bd00 <commands+0x210>
ffffffffc02019d0:	10500593          	li	a1,261
ffffffffc02019d4:	0000b517          	auipc	a0,0xb
ffffffffc02019d8:	ab450513          	addi	a0,a0,-1356 # ffffffffc020c488 <commands+0x998>
ffffffffc02019dc:	ac3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019e0:	0000b697          	auipc	a3,0xb
ffffffffc02019e4:	cb868693          	addi	a3,a3,-840 # ffffffffc020c698 <commands+0xba8>
ffffffffc02019e8:	0000a617          	auipc	a2,0xa
ffffffffc02019ec:	31860613          	addi	a2,a2,792 # ffffffffc020bd00 <commands+0x210>
ffffffffc02019f0:	10400593          	li	a1,260
ffffffffc02019f4:	0000b517          	auipc	a0,0xb
ffffffffc02019f8:	a9450513          	addi	a0,a0,-1388 # ffffffffc020c488 <commands+0x998>
ffffffffc02019fc:	aa3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a00:	0000b697          	auipc	a3,0xb
ffffffffc0201a04:	c8068693          	addi	a3,a3,-896 # ffffffffc020c680 <commands+0xb90>
ffffffffc0201a08:	0000a617          	auipc	a2,0xa
ffffffffc0201a0c:	2f860613          	addi	a2,a2,760 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201a10:	10300593          	li	a1,259
ffffffffc0201a14:	0000b517          	auipc	a0,0xb
ffffffffc0201a18:	a7450513          	addi	a0,a0,-1420 # ffffffffc020c488 <commands+0x998>
ffffffffc0201a1c:	a83fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a20:	0000b697          	auipc	a3,0xb
ffffffffc0201a24:	bc868693          	addi	a3,a3,-1080 # ffffffffc020c5e8 <commands+0xaf8>
ffffffffc0201a28:	0000a617          	auipc	a2,0xa
ffffffffc0201a2c:	2d860613          	addi	a2,a2,728 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201a30:	0fd00593          	li	a1,253
ffffffffc0201a34:	0000b517          	auipc	a0,0xb
ffffffffc0201a38:	a5450513          	addi	a0,a0,-1452 # ffffffffc020c488 <commands+0x998>
ffffffffc0201a3c:	a63fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a40:	0000b697          	auipc	a3,0xb
ffffffffc0201a44:	c2868693          	addi	a3,a3,-984 # ffffffffc020c668 <commands+0xb78>
ffffffffc0201a48:	0000a617          	auipc	a2,0xa
ffffffffc0201a4c:	2b860613          	addi	a2,a2,696 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201a50:	0f800593          	li	a1,248
ffffffffc0201a54:	0000b517          	auipc	a0,0xb
ffffffffc0201a58:	a3450513          	addi	a0,a0,-1484 # ffffffffc020c488 <commands+0x998>
ffffffffc0201a5c:	a43fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a60:	0000b697          	auipc	a3,0xb
ffffffffc0201a64:	d2868693          	addi	a3,a3,-728 # ffffffffc020c788 <commands+0xc98>
ffffffffc0201a68:	0000a617          	auipc	a2,0xa
ffffffffc0201a6c:	29860613          	addi	a2,a2,664 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201a70:	11600593          	li	a1,278
ffffffffc0201a74:	0000b517          	auipc	a0,0xb
ffffffffc0201a78:	a1450513          	addi	a0,a0,-1516 # ffffffffc020c488 <commands+0x998>
ffffffffc0201a7c:	a23fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a80:	0000b697          	auipc	a3,0xb
ffffffffc0201a84:	d3868693          	addi	a3,a3,-712 # ffffffffc020c7b8 <commands+0xcc8>
ffffffffc0201a88:	0000a617          	auipc	a2,0xa
ffffffffc0201a8c:	27860613          	addi	a2,a2,632 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201a90:	12500593          	li	a1,293
ffffffffc0201a94:	0000b517          	auipc	a0,0xb
ffffffffc0201a98:	9f450513          	addi	a0,a0,-1548 # ffffffffc020c488 <commands+0x998>
ffffffffc0201a9c:	a03fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201aa0:	0000b697          	auipc	a3,0xb
ffffffffc0201aa4:	a0068693          	addi	a3,a3,-1536 # ffffffffc020c4a0 <commands+0x9b0>
ffffffffc0201aa8:	0000a617          	auipc	a2,0xa
ffffffffc0201aac:	25860613          	addi	a2,a2,600 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201ab0:	0f200593          	li	a1,242
ffffffffc0201ab4:	0000b517          	auipc	a0,0xb
ffffffffc0201ab8:	9d450513          	addi	a0,a0,-1580 # ffffffffc020c488 <commands+0x998>
ffffffffc0201abc:	9e3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201ac0:	0000b697          	auipc	a3,0xb
ffffffffc0201ac4:	a2068693          	addi	a3,a3,-1504 # ffffffffc020c4e0 <commands+0x9f0>
ffffffffc0201ac8:	0000a617          	auipc	a2,0xa
ffffffffc0201acc:	23860613          	addi	a2,a2,568 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201ad0:	0b900593          	li	a1,185
ffffffffc0201ad4:	0000b517          	auipc	a0,0xb
ffffffffc0201ad8:	9b450513          	addi	a0,a0,-1612 # ffffffffc020c488 <commands+0x998>
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
ffffffffc0201c10:	bc468693          	addi	a3,a3,-1084 # ffffffffc020c7d0 <commands+0xce0>
ffffffffc0201c14:	0000a617          	auipc	a2,0xa
ffffffffc0201c18:	0ec60613          	addi	a2,a2,236 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201c1c:	08200593          	li	a1,130
ffffffffc0201c20:	0000b517          	auipc	a0,0xb
ffffffffc0201c24:	86850513          	addi	a0,a0,-1944 # ffffffffc020c488 <commands+0x998>
ffffffffc0201c28:	877fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201c2c:	0000b697          	auipc	a3,0xb
ffffffffc0201c30:	b9c68693          	addi	a3,a3,-1124 # ffffffffc020c7c8 <commands+0xcd8>
ffffffffc0201c34:	0000a617          	auipc	a2,0xa
ffffffffc0201c38:	0cc60613          	addi	a2,a2,204 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201c3c:	07f00593          	li	a1,127
ffffffffc0201c40:	0000b517          	auipc	a0,0xb
ffffffffc0201c44:	84850513          	addi	a0,a0,-1976 # ffffffffc020c488 <commands+0x998>
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
ffffffffc0201ce2:	aea68693          	addi	a3,a3,-1302 # ffffffffc020c7c8 <commands+0xcd8>
ffffffffc0201ce6:	0000a617          	auipc	a2,0xa
ffffffffc0201cea:	01a60613          	addi	a2,a2,26 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201cee:	06100593          	li	a1,97
ffffffffc0201cf2:	0000a517          	auipc	a0,0xa
ffffffffc0201cf6:	79650513          	addi	a0,a0,1942 # ffffffffc020c488 <commands+0x998>
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
ffffffffc0201db4:	a4868693          	addi	a3,a3,-1464 # ffffffffc020c7f8 <commands+0xd08>
ffffffffc0201db8:	0000a617          	auipc	a2,0xa
ffffffffc0201dbc:	f4860613          	addi	a2,a2,-184 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201dc0:	04800593          	li	a1,72
ffffffffc0201dc4:	0000a517          	auipc	a0,0xa
ffffffffc0201dc8:	6c450513          	addi	a0,a0,1732 # ffffffffc020c488 <commands+0x998>
ffffffffc0201dcc:	ed2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201dd0:	0000b697          	auipc	a3,0xb
ffffffffc0201dd4:	9f868693          	addi	a3,a3,-1544 # ffffffffc020c7c8 <commands+0xcd8>
ffffffffc0201dd8:	0000a617          	auipc	a2,0xa
ffffffffc0201ddc:	f2860613          	addi	a2,a2,-216 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201de0:	04500593          	li	a1,69
ffffffffc0201de4:	0000a517          	auipc	a0,0xa
ffffffffc0201de8:	6a450513          	addi	a0,a0,1700 # ffffffffc020c488 <commands+0x998>
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
ffffffffc0201ec4:	b586b683          	ld	a3,-1192(a3) # ffffffffc020fa18 <nbase>
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
ffffffffc0201ef4:	96860613          	addi	a2,a2,-1688 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc0201ef8:	07100593          	li	a1,113
ffffffffc0201efc:	0000b517          	auipc	a0,0xb
ffffffffc0201f00:	98450513          	addi	a0,a0,-1660 # ffffffffc020c880 <default_pmm_manager+0x60>
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
ffffffffc0201fe2:	8b268693          	addi	a3,a3,-1870 # ffffffffc020c890 <default_pmm_manager+0x70>
ffffffffc0201fe6:	0000a617          	auipc	a2,0xa
ffffffffc0201fea:	d1a60613          	addi	a2,a2,-742 # ffffffffc020bd00 <commands+0x210>
ffffffffc0201fee:	06300593          	li	a1,99
ffffffffc0201ff2:	0000b517          	auipc	a0,0xb
ffffffffc0201ff6:	8be50513          	addi	a0,a0,-1858 # ffffffffc020c8b0 <default_pmm_manager+0x90>
ffffffffc0201ffa:	ca4fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201ffe <kmalloc_init>:
ffffffffc0201ffe:	1141                	addi	sp,sp,-16
ffffffffc0202000:	0000b517          	auipc	a0,0xb
ffffffffc0202004:	8c850513          	addi	a0,a0,-1848 # ffffffffc020c8c8 <default_pmm_manager+0xa8>
ffffffffc0202008:	e406                	sd	ra,8(sp)
ffffffffc020200a:	99cfe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020200e:	60a2                	ld	ra,8(sp)
ffffffffc0202010:	0000b517          	auipc	a0,0xb
ffffffffc0202014:	8d050513          	addi	a0,a0,-1840 # ffffffffc020c8e0 <default_pmm_manager+0xc0>
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
ffffffffc020213c:	8e053503          	ld	a0,-1824(a0) # ffffffffc020fa18 <nbase>
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
ffffffffc0202196:	0000a617          	auipc	a2,0xa
ffffffffc020219a:	79260613          	addi	a2,a2,1938 # ffffffffc020c928 <default_pmm_manager+0x108>
ffffffffc020219e:	06900593          	li	a1,105
ffffffffc02021a2:	0000a517          	auipc	a0,0xa
ffffffffc02021a6:	6de50513          	addi	a0,a0,1758 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc02021aa:	af4fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02021ae:	86a2                	mv	a3,s0
ffffffffc02021b0:	0000a617          	auipc	a2,0xa
ffffffffc02021b4:	75060613          	addi	a2,a2,1872 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc02021b8:	07700593          	li	a1,119
ffffffffc02021bc:	0000a517          	auipc	a0,0xa
ffffffffc02021c0:	6c450513          	addi	a0,a0,1732 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc02021c4:	adafe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02021c8 <pa2page.part.0>:
ffffffffc02021c8:	1141                	addi	sp,sp,-16
ffffffffc02021ca:	0000a617          	auipc	a2,0xa
ffffffffc02021ce:	75e60613          	addi	a2,a2,1886 # ffffffffc020c928 <default_pmm_manager+0x108>
ffffffffc02021d2:	06900593          	li	a1,105
ffffffffc02021d6:	0000a517          	auipc	a0,0xa
ffffffffc02021da:	6aa50513          	addi	a0,a0,1706 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc02021de:	e406                	sd	ra,8(sp)
ffffffffc02021e0:	abefe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02021e4 <pte2page.part.0>:
ffffffffc02021e4:	1141                	addi	sp,sp,-16
ffffffffc02021e6:	0000a617          	auipc	a2,0xa
ffffffffc02021ea:	76260613          	addi	a2,a2,1890 # ffffffffc020c948 <default_pmm_manager+0x128>
ffffffffc02021ee:	07f00593          	li	a1,127
ffffffffc02021f2:	0000a517          	auipc	a0,0xa
ffffffffc02021f6:	68e50513          	addi	a0,a0,1678 # ffffffffc020c880 <default_pmm_manager+0x60>
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
ffffffffc0202350:	4ca090ef          	jal	ra,ffffffffc020b81a <memset>
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
ffffffffc02023f2:	428090ef          	jal	ra,ffffffffc020b81a <memset>
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
ffffffffc0202480:	3dc60613          	addi	a2,a2,988 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc0202484:	13200593          	li	a1,306
ffffffffc0202488:	0000a517          	auipc	a0,0xa
ffffffffc020248c:	4e850513          	addi	a0,a0,1256 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0202490:	80efe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202494:	0000a617          	auipc	a2,0xa
ffffffffc0202498:	3c460613          	addi	a2,a2,964 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc020249c:	12500593          	li	a1,293
ffffffffc02024a0:	0000a517          	auipc	a0,0xa
ffffffffc02024a4:	4d050513          	addi	a0,a0,1232 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02024a8:	ff7fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024ac:	86aa                	mv	a3,a0
ffffffffc02024ae:	0000a617          	auipc	a2,0xa
ffffffffc02024b2:	3aa60613          	addi	a2,a2,938 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc02024b6:	12100593          	li	a1,289
ffffffffc02024ba:	0000a517          	auipc	a0,0xa
ffffffffc02024be:	4b650513          	addi	a0,a0,1206 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02024c2:	fddfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024c6:	86aa                	mv	a3,a0
ffffffffc02024c8:	0000a617          	auipc	a2,0xa
ffffffffc02024cc:	39060613          	addi	a2,a2,912 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc02024d0:	12f00593          	li	a1,303
ffffffffc02024d4:	0000a517          	auipc	a0,0xa
ffffffffc02024d8:	49c50513          	addi	a0,a0,1180 # ffffffffc020c970 <default_pmm_manager+0x150>
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
ffffffffc020256a:	43268693          	addi	a3,a3,1074 # ffffffffc020c998 <default_pmm_manager+0x178>
ffffffffc020256e:	00009617          	auipc	a2,0x9
ffffffffc0202572:	79260613          	addi	a2,a2,1938 # ffffffffc020bd00 <commands+0x210>
ffffffffc0202576:	09c00593          	li	a1,156
ffffffffc020257a:	0000a517          	auipc	a0,0xa
ffffffffc020257e:	3f650513          	addi	a0,a0,1014 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0202582:	f1dfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202586:	0000a697          	auipc	a3,0xa
ffffffffc020258a:	3fa68693          	addi	a3,a3,1018 # ffffffffc020c980 <default_pmm_manager+0x160>
ffffffffc020258e:	00009617          	auipc	a2,0x9
ffffffffc0202592:	77260613          	addi	a2,a2,1906 # ffffffffc020bd00 <commands+0x210>
ffffffffc0202596:	09500593          	li	a1,149
ffffffffc020259a:	0000a517          	auipc	a0,0xa
ffffffffc020259e:	3d650513          	addi	a0,a0,982 # ffffffffc020c970 <default_pmm_manager+0x150>
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
ffffffffc0202700:	2ac68693          	addi	a3,a3,684 # ffffffffc020c9a8 <default_pmm_manager+0x188>
ffffffffc0202704:	00009617          	auipc	a2,0x9
ffffffffc0202708:	5fc60613          	addi	a2,a2,1532 # ffffffffc020bd00 <commands+0x210>
ffffffffc020270c:	15a00593          	li	a1,346
ffffffffc0202710:	0000a517          	auipc	a0,0xa
ffffffffc0202714:	26050513          	addi	a0,a0,608 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0202718:	d87fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020271c:	0000a697          	auipc	a3,0xa
ffffffffc0202720:	2bc68693          	addi	a3,a3,700 # ffffffffc020c9d8 <default_pmm_manager+0x1b8>
ffffffffc0202724:	00009617          	auipc	a2,0x9
ffffffffc0202728:	5dc60613          	addi	a2,a2,1500 # ffffffffc020bd00 <commands+0x210>
ffffffffc020272c:	15b00593          	li	a1,347
ffffffffc0202730:	0000a517          	auipc	a0,0xa
ffffffffc0202734:	24050513          	addi	a0,a0,576 # ffffffffc020c970 <default_pmm_manager+0x150>
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
ffffffffc020297a:	03268693          	addi	a3,a3,50 # ffffffffc020c9a8 <default_pmm_manager+0x188>
ffffffffc020297e:	00009617          	auipc	a2,0x9
ffffffffc0202982:	38260613          	addi	a2,a2,898 # ffffffffc020bd00 <commands+0x210>
ffffffffc0202986:	16f00593          	li	a1,367
ffffffffc020298a:	0000a517          	auipc	a0,0xa
ffffffffc020298e:	fe650513          	addi	a0,a0,-26 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0202992:	b0dfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202996:	0000a617          	auipc	a2,0xa
ffffffffc020299a:	ec260613          	addi	a2,a2,-318 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc020299e:	07100593          	li	a1,113
ffffffffc02029a2:	0000a517          	auipc	a0,0xa
ffffffffc02029a6:	ede50513          	addi	a0,a0,-290 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc02029aa:	af5fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02029ae:	81bff0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>
ffffffffc02029b2:	0000a697          	auipc	a3,0xa
ffffffffc02029b6:	02668693          	addi	a3,a3,38 # ffffffffc020c9d8 <default_pmm_manager+0x1b8>
ffffffffc02029ba:	00009617          	auipc	a2,0x9
ffffffffc02029be:	34660613          	addi	a2,a2,838 # ffffffffc020bd00 <commands+0x210>
ffffffffc02029c2:	17000593          	li	a1,368
ffffffffc02029c6:	0000a517          	auipc	a0,0xa
ffffffffc02029ca:	faa50513          	addi	a0,a0,-86 # ffffffffc020c970 <default_pmm_manager+0x150>
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
ffffffffc0202b68:	cbc78793          	addi	a5,a5,-836 # ffffffffc020c820 <default_pmm_manager>
ffffffffc0202b6c:	638c                	ld	a1,0(a5)
ffffffffc0202b6e:	7159                	addi	sp,sp,-112
ffffffffc0202b70:	f85a                	sd	s6,48(sp)
ffffffffc0202b72:	0000a517          	auipc	a0,0xa
ffffffffc0202b76:	e7e50513          	addi	a0,a0,-386 # ffffffffc020c9f0 <default_pmm_manager+0x1d0>
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
ffffffffc0202bca:	e6250513          	addi	a0,a0,-414 # ffffffffc020ca28 <default_pmm_manager+0x208>
ffffffffc0202bce:	dd8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bd2:	00990433          	add	s0,s2,s1
ffffffffc0202bd6:	fff40693          	addi	a3,s0,-1
ffffffffc0202bda:	864a                	mv	a2,s2
ffffffffc0202bdc:	85a6                	mv	a1,s1
ffffffffc0202bde:	0000a517          	auipc	a0,0xa
ffffffffc0202be2:	e6250513          	addi	a0,a0,-414 # ffffffffc020ca40 <default_pmm_manager+0x220>
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
ffffffffc0202c6a:	e0250513          	addi	a0,a0,-510 # ffffffffc020ca68 <default_pmm_manager+0x248>
ffffffffc0202c6e:	d38fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202c72:	000b3783          	ld	a5,0(s6)
ffffffffc0202c76:	7b9c                	ld	a5,48(a5)
ffffffffc0202c78:	9782                	jalr	a5
ffffffffc0202c7a:	0000a517          	auipc	a0,0xa
ffffffffc0202c7e:	e0650513          	addi	a0,a0,-506 # ffffffffc020ca80 <default_pmm_manager+0x260>
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
ffffffffc0202ccc:	34f080ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc0202cd0:	0009b683          	ld	a3,0(s3)
ffffffffc0202cd4:	77fd                	lui	a5,0xfffff
ffffffffc0202cd6:	0000a917          	auipc	s2,0xa
ffffffffc0202cda:	bad90913          	addi	s2,s2,-1107 # ffffffffc020c883 <default_pmm_manager+0x63>
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
ffffffffc0202d4e:	d7650513          	addi	a0,a0,-650 # ffffffffc020cac0 <default_pmm_manager+0x2a0>
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
ffffffffc0202ff6:	e2650513          	addi	a0,a0,-474 # ffffffffc020ce18 <default_pmm_manager+0x5f8>
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
ffffffffc02030ba:	eaa58593          	addi	a1,a1,-342 # ffffffffc020cf60 <default_pmm_manager+0x740>
ffffffffc02030be:	10000513          	li	a0,256
ffffffffc02030c2:	6ec080ef          	jal	ra,ffffffffc020b7ae <strcpy>
ffffffffc02030c6:	10040593          	addi	a1,s0,256
ffffffffc02030ca:	10000513          	li	a0,256
ffffffffc02030ce:	6f2080ef          	jal	ra,ffffffffc020b7c0 <strcmp>
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
ffffffffc0203104:	674080ef          	jal	ra,ffffffffc020b778 <strlen>
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
ffffffffc02031c8:	e1450513          	addi	a0,a0,-492 # ffffffffc020cfd8 <default_pmm_manager+0x7b8>
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
ffffffffc020335a:	4c0080ef          	jal	ra,ffffffffc020b81a <memset>
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
ffffffffc02033ac:	00009517          	auipc	a0,0x9
ffffffffc02033b0:	73c50513          	addi	a0,a0,1852 # ffffffffc020cae8 <default_pmm_manager+0x2c8>
ffffffffc02033b4:	df3fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02033b8:	ba4d                	j	ffffffffc0202d6a <pmm_init+0x206>
ffffffffc02033ba:	0000a697          	auipc	a3,0xa
ffffffffc02033be:	a7e68693          	addi	a3,a3,-1410 # ffffffffc020ce38 <default_pmm_manager+0x618>
ffffffffc02033c2:	00009617          	auipc	a2,0x9
ffffffffc02033c6:	93e60613          	addi	a2,a2,-1730 # ffffffffc020bd00 <commands+0x210>
ffffffffc02033ca:	28800593          	li	a1,648
ffffffffc02033ce:	00009517          	auipc	a0,0x9
ffffffffc02033d2:	5a250513          	addi	a0,a0,1442 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02033d6:	8c8fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033da:	86a2                	mv	a3,s0
ffffffffc02033dc:	00009617          	auipc	a2,0x9
ffffffffc02033e0:	47c60613          	addi	a2,a2,1148 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc02033e4:	28800593          	li	a1,648
ffffffffc02033e8:	00009517          	auipc	a0,0x9
ffffffffc02033ec:	58850513          	addi	a0,a0,1416 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02033f0:	8aefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033f4:	0000a697          	auipc	a3,0xa
ffffffffc02033f8:	a8468693          	addi	a3,a3,-1404 # ffffffffc020ce78 <default_pmm_manager+0x658>
ffffffffc02033fc:	00009617          	auipc	a2,0x9
ffffffffc0203400:	90460613          	addi	a2,a2,-1788 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203404:	28900593          	li	a1,649
ffffffffc0203408:	00009517          	auipc	a0,0x9
ffffffffc020340c:	56850513          	addi	a0,a0,1384 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203410:	88efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203414:	db5fe0ef          	jal	ra,ffffffffc02021c8 <pa2page.part.0>
ffffffffc0203418:	0000a697          	auipc	a3,0xa
ffffffffc020341c:	88868693          	addi	a3,a3,-1912 # ffffffffc020cca0 <default_pmm_manager+0x480>
ffffffffc0203420:	00009617          	auipc	a2,0x9
ffffffffc0203424:	8e060613          	addi	a2,a2,-1824 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203428:	26500593          	li	a1,613
ffffffffc020342c:	00009517          	auipc	a0,0x9
ffffffffc0203430:	54450513          	addi	a0,a0,1348 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203434:	86afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203438:	0000a697          	auipc	a3,0xa
ffffffffc020343c:	ac868693          	addi	a3,a3,-1336 # ffffffffc020cf00 <default_pmm_manager+0x6e0>
ffffffffc0203440:	00009617          	auipc	a2,0x9
ffffffffc0203444:	8c060613          	addi	a2,a2,-1856 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203448:	29200593          	li	a1,658
ffffffffc020344c:	00009517          	auipc	a0,0x9
ffffffffc0203450:	52450513          	addi	a0,a0,1316 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203454:	84afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203458:	0000a697          	auipc	a3,0xa
ffffffffc020345c:	96868693          	addi	a3,a3,-1688 # ffffffffc020cdc0 <default_pmm_manager+0x5a0>
ffffffffc0203460:	00009617          	auipc	a2,0x9
ffffffffc0203464:	8a060613          	addi	a2,a2,-1888 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203468:	27100593          	li	a1,625
ffffffffc020346c:	00009517          	auipc	a0,0x9
ffffffffc0203470:	50450513          	addi	a0,a0,1284 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203474:	82afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203478:	0000a697          	auipc	a3,0xa
ffffffffc020347c:	91868693          	addi	a3,a3,-1768 # ffffffffc020cd90 <default_pmm_manager+0x570>
ffffffffc0203480:	00009617          	auipc	a2,0x9
ffffffffc0203484:	88060613          	addi	a2,a2,-1920 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203488:	26700593          	li	a1,615
ffffffffc020348c:	00009517          	auipc	a0,0x9
ffffffffc0203490:	4e450513          	addi	a0,a0,1252 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203494:	80afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203498:	00009697          	auipc	a3,0x9
ffffffffc020349c:	76868693          	addi	a3,a3,1896 # ffffffffc020cc00 <default_pmm_manager+0x3e0>
ffffffffc02034a0:	00009617          	auipc	a2,0x9
ffffffffc02034a4:	86060613          	addi	a2,a2,-1952 # ffffffffc020bd00 <commands+0x210>
ffffffffc02034a8:	26600593          	li	a1,614
ffffffffc02034ac:	00009517          	auipc	a0,0x9
ffffffffc02034b0:	4c450513          	addi	a0,a0,1220 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02034b4:	febfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034b8:	0000a697          	auipc	a3,0xa
ffffffffc02034bc:	8c068693          	addi	a3,a3,-1856 # ffffffffc020cd78 <default_pmm_manager+0x558>
ffffffffc02034c0:	00009617          	auipc	a2,0x9
ffffffffc02034c4:	84060613          	addi	a2,a2,-1984 # ffffffffc020bd00 <commands+0x210>
ffffffffc02034c8:	26b00593          	li	a1,619
ffffffffc02034cc:	00009517          	auipc	a0,0x9
ffffffffc02034d0:	4a450513          	addi	a0,a0,1188 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02034d4:	fcbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034d8:	00009697          	auipc	a3,0x9
ffffffffc02034dc:	74068693          	addi	a3,a3,1856 # ffffffffc020cc18 <default_pmm_manager+0x3f8>
ffffffffc02034e0:	00009617          	auipc	a2,0x9
ffffffffc02034e4:	82060613          	addi	a2,a2,-2016 # ffffffffc020bd00 <commands+0x210>
ffffffffc02034e8:	26a00593          	li	a1,618
ffffffffc02034ec:	00009517          	auipc	a0,0x9
ffffffffc02034f0:	48450513          	addi	a0,a0,1156 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02034f4:	fabfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034f8:	0000a697          	auipc	a3,0xa
ffffffffc02034fc:	99868693          	addi	a3,a3,-1640 # ffffffffc020ce90 <default_pmm_manager+0x670>
ffffffffc0203500:	00009617          	auipc	a2,0x9
ffffffffc0203504:	80060613          	addi	a2,a2,-2048 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203508:	28c00593          	li	a1,652
ffffffffc020350c:	00009517          	auipc	a0,0x9
ffffffffc0203510:	46450513          	addi	a0,a0,1124 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203514:	f8bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203518:	0000a697          	auipc	a3,0xa
ffffffffc020351c:	9d068693          	addi	a3,a3,-1584 # ffffffffc020cee8 <default_pmm_manager+0x6c8>
ffffffffc0203520:	00008617          	auipc	a2,0x8
ffffffffc0203524:	7e060613          	addi	a2,a2,2016 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203528:	29100593          	li	a1,657
ffffffffc020352c:	00009517          	auipc	a0,0x9
ffffffffc0203530:	44450513          	addi	a0,a0,1092 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203534:	f6bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203538:	0000a697          	auipc	a3,0xa
ffffffffc020353c:	97068693          	addi	a3,a3,-1680 # ffffffffc020cea8 <default_pmm_manager+0x688>
ffffffffc0203540:	00008617          	auipc	a2,0x8
ffffffffc0203544:	7c060613          	addi	a2,a2,1984 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203548:	29000593          	li	a1,656
ffffffffc020354c:	00009517          	auipc	a0,0x9
ffffffffc0203550:	42450513          	addi	a0,a0,1060 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203554:	f4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203558:	0000a697          	auipc	a3,0xa
ffffffffc020355c:	a5868693          	addi	a3,a3,-1448 # ffffffffc020cfb0 <default_pmm_manager+0x790>
ffffffffc0203560:	00008617          	auipc	a2,0x8
ffffffffc0203564:	7a060613          	addi	a2,a2,1952 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203568:	29a00593          	li	a1,666
ffffffffc020356c:	00009517          	auipc	a0,0x9
ffffffffc0203570:	40450513          	addi	a0,a0,1028 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203574:	f2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203578:	0000a697          	auipc	a3,0xa
ffffffffc020357c:	a0068693          	addi	a3,a3,-1536 # ffffffffc020cf78 <default_pmm_manager+0x758>
ffffffffc0203580:	00008617          	auipc	a2,0x8
ffffffffc0203584:	78060613          	addi	a2,a2,1920 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203588:	29700593          	li	a1,663
ffffffffc020358c:	00009517          	auipc	a0,0x9
ffffffffc0203590:	3e450513          	addi	a0,a0,996 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203594:	f0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203598:	0000a697          	auipc	a3,0xa
ffffffffc020359c:	9b068693          	addi	a3,a3,-1616 # ffffffffc020cf48 <default_pmm_manager+0x728>
ffffffffc02035a0:	00008617          	auipc	a2,0x8
ffffffffc02035a4:	76060613          	addi	a2,a2,1888 # ffffffffc020bd00 <commands+0x210>
ffffffffc02035a8:	29300593          	li	a1,659
ffffffffc02035ac:	00009517          	auipc	a0,0x9
ffffffffc02035b0:	3c450513          	addi	a0,a0,964 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02035b4:	eebfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b8:	86a2                	mv	a3,s0
ffffffffc02035ba:	00009617          	auipc	a2,0x9
ffffffffc02035be:	34660613          	addi	a2,a2,838 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc02035c2:	0dc00593          	li	a1,220
ffffffffc02035c6:	00009517          	auipc	a0,0x9
ffffffffc02035ca:	3aa50513          	addi	a0,a0,938 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02035ce:	ed1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035d2:	86ae                	mv	a3,a1
ffffffffc02035d4:	00009617          	auipc	a2,0x9
ffffffffc02035d8:	32c60613          	addi	a2,a2,812 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc02035dc:	0db00593          	li	a1,219
ffffffffc02035e0:	00009517          	auipc	a0,0x9
ffffffffc02035e4:	39050513          	addi	a0,a0,912 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02035e8:	eb7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035ec:	00009697          	auipc	a3,0x9
ffffffffc02035f0:	54468693          	addi	a3,a3,1348 # ffffffffc020cb30 <default_pmm_manager+0x310>
ffffffffc02035f4:	00008617          	auipc	a2,0x8
ffffffffc02035f8:	70c60613          	addi	a2,a2,1804 # ffffffffc020bd00 <commands+0x210>
ffffffffc02035fc:	24a00593          	li	a1,586
ffffffffc0203600:	00009517          	auipc	a0,0x9
ffffffffc0203604:	37050513          	addi	a0,a0,880 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203608:	e97fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020360c:	00009697          	auipc	a3,0x9
ffffffffc0203610:	50468693          	addi	a3,a3,1284 # ffffffffc020cb10 <default_pmm_manager+0x2f0>
ffffffffc0203614:	00008617          	auipc	a2,0x8
ffffffffc0203618:	6ec60613          	addi	a2,a2,1772 # ffffffffc020bd00 <commands+0x210>
ffffffffc020361c:	24900593          	li	a1,585
ffffffffc0203620:	00009517          	auipc	a0,0x9
ffffffffc0203624:	35050513          	addi	a0,a0,848 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203628:	e77fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020362c:	00009617          	auipc	a2,0x9
ffffffffc0203630:	47460613          	addi	a2,a2,1140 # ffffffffc020caa0 <default_pmm_manager+0x280>
ffffffffc0203634:	0aa00593          	li	a1,170
ffffffffc0203638:	00009517          	auipc	a0,0x9
ffffffffc020363c:	33850513          	addi	a0,a0,824 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203640:	e5ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203644:	00009617          	auipc	a2,0x9
ffffffffc0203648:	3c460613          	addi	a2,a2,964 # ffffffffc020ca08 <default_pmm_manager+0x1e8>
ffffffffc020364c:	06500593          	li	a1,101
ffffffffc0203650:	00009517          	auipc	a0,0x9
ffffffffc0203654:	32050513          	addi	a0,a0,800 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203658:	e47fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020365c:	00009697          	auipc	a3,0x9
ffffffffc0203660:	79468693          	addi	a3,a3,1940 # ffffffffc020cdf0 <default_pmm_manager+0x5d0>
ffffffffc0203664:	00008617          	auipc	a2,0x8
ffffffffc0203668:	69c60613          	addi	a2,a2,1692 # ffffffffc020bd00 <commands+0x210>
ffffffffc020366c:	2a300593          	li	a1,675
ffffffffc0203670:	00009517          	auipc	a0,0x9
ffffffffc0203674:	30050513          	addi	a0,a0,768 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203678:	e27fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020367c:	00009697          	auipc	a3,0x9
ffffffffc0203680:	5b468693          	addi	a3,a3,1460 # ffffffffc020cc30 <default_pmm_manager+0x410>
ffffffffc0203684:	00008617          	auipc	a2,0x8
ffffffffc0203688:	67c60613          	addi	a2,a2,1660 # ffffffffc020bd00 <commands+0x210>
ffffffffc020368c:	25800593          	li	a1,600
ffffffffc0203690:	00009517          	auipc	a0,0x9
ffffffffc0203694:	2e050513          	addi	a0,a0,736 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203698:	e07fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020369c:	86d6                	mv	a3,s5
ffffffffc020369e:	00009617          	auipc	a2,0x9
ffffffffc02036a2:	1ba60613          	addi	a2,a2,442 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc02036a6:	25700593          	li	a1,599
ffffffffc02036aa:	00009517          	auipc	a0,0x9
ffffffffc02036ae:	2c650513          	addi	a0,a0,710 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02036b2:	dedfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036b6:	00009697          	auipc	a3,0x9
ffffffffc02036ba:	6c268693          	addi	a3,a3,1730 # ffffffffc020cd78 <default_pmm_manager+0x558>
ffffffffc02036be:	00008617          	auipc	a2,0x8
ffffffffc02036c2:	64260613          	addi	a2,a2,1602 # ffffffffc020bd00 <commands+0x210>
ffffffffc02036c6:	26400593          	li	a1,612
ffffffffc02036ca:	00009517          	auipc	a0,0x9
ffffffffc02036ce:	2a650513          	addi	a0,a0,678 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02036d2:	dcdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036d6:	00009697          	auipc	a3,0x9
ffffffffc02036da:	68a68693          	addi	a3,a3,1674 # ffffffffc020cd60 <default_pmm_manager+0x540>
ffffffffc02036de:	00008617          	auipc	a2,0x8
ffffffffc02036e2:	62260613          	addi	a2,a2,1570 # ffffffffc020bd00 <commands+0x210>
ffffffffc02036e6:	26300593          	li	a1,611
ffffffffc02036ea:	00009517          	auipc	a0,0x9
ffffffffc02036ee:	28650513          	addi	a0,a0,646 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02036f2:	dadfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036f6:	00009697          	auipc	a3,0x9
ffffffffc02036fa:	63a68693          	addi	a3,a3,1594 # ffffffffc020cd30 <default_pmm_manager+0x510>
ffffffffc02036fe:	00008617          	auipc	a2,0x8
ffffffffc0203702:	60260613          	addi	a2,a2,1538 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203706:	26200593          	li	a1,610
ffffffffc020370a:	00009517          	auipc	a0,0x9
ffffffffc020370e:	26650513          	addi	a0,a0,614 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203712:	d8dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203716:	00009697          	auipc	a3,0x9
ffffffffc020371a:	60268693          	addi	a3,a3,1538 # ffffffffc020cd18 <default_pmm_manager+0x4f8>
ffffffffc020371e:	00008617          	auipc	a2,0x8
ffffffffc0203722:	5e260613          	addi	a2,a2,1506 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203726:	26000593          	li	a1,608
ffffffffc020372a:	00009517          	auipc	a0,0x9
ffffffffc020372e:	24650513          	addi	a0,a0,582 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203732:	d6dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203736:	00009697          	auipc	a3,0x9
ffffffffc020373a:	5c268693          	addi	a3,a3,1474 # ffffffffc020ccf8 <default_pmm_manager+0x4d8>
ffffffffc020373e:	00008617          	auipc	a2,0x8
ffffffffc0203742:	5c260613          	addi	a2,a2,1474 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203746:	25f00593          	li	a1,607
ffffffffc020374a:	00009517          	auipc	a0,0x9
ffffffffc020374e:	22650513          	addi	a0,a0,550 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203752:	d4dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203756:	00009697          	auipc	a3,0x9
ffffffffc020375a:	59268693          	addi	a3,a3,1426 # ffffffffc020cce8 <default_pmm_manager+0x4c8>
ffffffffc020375e:	00008617          	auipc	a2,0x8
ffffffffc0203762:	5a260613          	addi	a2,a2,1442 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203766:	25e00593          	li	a1,606
ffffffffc020376a:	00009517          	auipc	a0,0x9
ffffffffc020376e:	20650513          	addi	a0,a0,518 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203772:	d2dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203776:	00009697          	auipc	a3,0x9
ffffffffc020377a:	56268693          	addi	a3,a3,1378 # ffffffffc020ccd8 <default_pmm_manager+0x4b8>
ffffffffc020377e:	00008617          	auipc	a2,0x8
ffffffffc0203782:	58260613          	addi	a2,a2,1410 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203786:	25d00593          	li	a1,605
ffffffffc020378a:	00009517          	auipc	a0,0x9
ffffffffc020378e:	1e650513          	addi	a0,a0,486 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203792:	d0dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203796:	00009697          	auipc	a3,0x9
ffffffffc020379a:	50a68693          	addi	a3,a3,1290 # ffffffffc020cca0 <default_pmm_manager+0x480>
ffffffffc020379e:	00008617          	auipc	a2,0x8
ffffffffc02037a2:	56260613          	addi	a2,a2,1378 # ffffffffc020bd00 <commands+0x210>
ffffffffc02037a6:	25c00593          	li	a1,604
ffffffffc02037aa:	00009517          	auipc	a0,0x9
ffffffffc02037ae:	1c650513          	addi	a0,a0,454 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02037b2:	cedfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037b6:	00009697          	auipc	a3,0x9
ffffffffc02037ba:	63a68693          	addi	a3,a3,1594 # ffffffffc020cdf0 <default_pmm_manager+0x5d0>
ffffffffc02037be:	00008617          	auipc	a2,0x8
ffffffffc02037c2:	54260613          	addi	a2,a2,1346 # ffffffffc020bd00 <commands+0x210>
ffffffffc02037c6:	27900593          	li	a1,633
ffffffffc02037ca:	00009517          	auipc	a0,0x9
ffffffffc02037ce:	1a650513          	addi	a0,a0,422 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02037d2:	ccdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037d6:	00009617          	auipc	a2,0x9
ffffffffc02037da:	08260613          	addi	a2,a2,130 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc02037de:	07100593          	li	a1,113
ffffffffc02037e2:	00009517          	auipc	a0,0x9
ffffffffc02037e6:	09e50513          	addi	a0,a0,158 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc02037ea:	cb5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037ee:	86a2                	mv	a3,s0
ffffffffc02037f0:	00009617          	auipc	a2,0x9
ffffffffc02037f4:	11060613          	addi	a2,a2,272 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc02037f8:	0ca00593          	li	a1,202
ffffffffc02037fc:	00009517          	auipc	a0,0x9
ffffffffc0203800:	17450513          	addi	a0,a0,372 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203804:	c9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203808:	00009617          	auipc	a2,0x9
ffffffffc020380c:	0f860613          	addi	a2,a2,248 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc0203810:	08100593          	li	a1,129
ffffffffc0203814:	00009517          	auipc	a0,0x9
ffffffffc0203818:	15c50513          	addi	a0,a0,348 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc020381c:	c83fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203820:	00009697          	auipc	a3,0x9
ffffffffc0203824:	44068693          	addi	a3,a3,1088 # ffffffffc020cc60 <default_pmm_manager+0x440>
ffffffffc0203828:	00008617          	auipc	a2,0x8
ffffffffc020382c:	4d860613          	addi	a2,a2,1240 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203830:	25b00593          	li	a1,603
ffffffffc0203834:	00009517          	auipc	a0,0x9
ffffffffc0203838:	13c50513          	addi	a0,a0,316 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc020383c:	c63fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203840:	00009697          	auipc	a3,0x9
ffffffffc0203844:	36068693          	addi	a3,a3,864 # ffffffffc020cba0 <default_pmm_manager+0x380>
ffffffffc0203848:	00008617          	auipc	a2,0x8
ffffffffc020384c:	4b860613          	addi	a2,a2,1208 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203850:	24f00593          	li	a1,591
ffffffffc0203854:	00009517          	auipc	a0,0x9
ffffffffc0203858:	11c50513          	addi	a0,a0,284 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc020385c:	c43fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203860:	985fe0ef          	jal	ra,ffffffffc02021e4 <pte2page.part.0>
ffffffffc0203864:	00009697          	auipc	a3,0x9
ffffffffc0203868:	36c68693          	addi	a3,a3,876 # ffffffffc020cbd0 <default_pmm_manager+0x3b0>
ffffffffc020386c:	00008617          	auipc	a2,0x8
ffffffffc0203870:	49460613          	addi	a2,a2,1172 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203874:	25200593          	li	a1,594
ffffffffc0203878:	00009517          	auipc	a0,0x9
ffffffffc020387c:	0f850513          	addi	a0,a0,248 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203880:	c1ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203884:	00009697          	auipc	a3,0x9
ffffffffc0203888:	2ec68693          	addi	a3,a3,748 # ffffffffc020cb70 <default_pmm_manager+0x350>
ffffffffc020388c:	00008617          	auipc	a2,0x8
ffffffffc0203890:	47460613          	addi	a2,a2,1140 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203894:	24b00593          	li	a1,587
ffffffffc0203898:	00009517          	auipc	a0,0x9
ffffffffc020389c:	0d850513          	addi	a0,a0,216 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02038a0:	bfffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a4:	00009697          	auipc	a3,0x9
ffffffffc02038a8:	35c68693          	addi	a3,a3,860 # ffffffffc020cc00 <default_pmm_manager+0x3e0>
ffffffffc02038ac:	00008617          	auipc	a2,0x8
ffffffffc02038b0:	45460613          	addi	a2,a2,1108 # ffffffffc020bd00 <commands+0x210>
ffffffffc02038b4:	25300593          	li	a1,595
ffffffffc02038b8:	00009517          	auipc	a0,0x9
ffffffffc02038bc:	0b850513          	addi	a0,a0,184 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02038c0:	bdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038c4:	00009617          	auipc	a2,0x9
ffffffffc02038c8:	f9460613          	addi	a2,a2,-108 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc02038cc:	25600593          	li	a1,598
ffffffffc02038d0:	00009517          	auipc	a0,0x9
ffffffffc02038d4:	0a050513          	addi	a0,a0,160 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02038d8:	bc7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038dc:	00009697          	auipc	a3,0x9
ffffffffc02038e0:	33c68693          	addi	a3,a3,828 # ffffffffc020cc18 <default_pmm_manager+0x3f8>
ffffffffc02038e4:	00008617          	auipc	a2,0x8
ffffffffc02038e8:	41c60613          	addi	a2,a2,1052 # ffffffffc020bd00 <commands+0x210>
ffffffffc02038ec:	25400593          	li	a1,596
ffffffffc02038f0:	00009517          	auipc	a0,0x9
ffffffffc02038f4:	08050513          	addi	a0,a0,128 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc02038f8:	ba7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038fc:	86ca                	mv	a3,s2
ffffffffc02038fe:	00009617          	auipc	a2,0x9
ffffffffc0203902:	00260613          	addi	a2,a2,2 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc0203906:	0c600593          	li	a1,198
ffffffffc020390a:	00009517          	auipc	a0,0x9
ffffffffc020390e:	06650513          	addi	a0,a0,102 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203912:	b8dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203916:	00009697          	auipc	a3,0x9
ffffffffc020391a:	46268693          	addi	a3,a3,1122 # ffffffffc020cd78 <default_pmm_manager+0x558>
ffffffffc020391e:	00008617          	auipc	a2,0x8
ffffffffc0203922:	3e260613          	addi	a2,a2,994 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203926:	26f00593          	li	a1,623
ffffffffc020392a:	00009517          	auipc	a0,0x9
ffffffffc020392e:	04650513          	addi	a0,a0,70 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203932:	b6dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203936:	00009697          	auipc	a3,0x9
ffffffffc020393a:	47268693          	addi	a3,a3,1138 # ffffffffc020cda8 <default_pmm_manager+0x588>
ffffffffc020393e:	00008617          	auipc	a2,0x8
ffffffffc0203942:	3c260613          	addi	a2,a2,962 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203946:	26e00593          	li	a1,622
ffffffffc020394a:	00009517          	auipc	a0,0x9
ffffffffc020394e:	02650513          	addi	a0,a0,38 # ffffffffc020c970 <default_pmm_manager+0x150>
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
ffffffffc0203a8a:	5e3070ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc0203a8e:	86a6                	mv	a3,s1
ffffffffc0203a90:	8622                	mv	a2,s0
ffffffffc0203a92:	85ea                	mv	a1,s10
ffffffffc0203a94:	8556                	mv	a0,s5
ffffffffc0203a96:	fd9fe0ef          	jal	ra,ffffffffc0202a6e <page_insert>
ffffffffc0203a9a:	d915                	beqz	a0,ffffffffc02039ce <copy_range+0x78>
ffffffffc0203a9c:	00009697          	auipc	a3,0x9
ffffffffc0203aa0:	57c68693          	addi	a3,a3,1404 # ffffffffc020d018 <default_pmm_manager+0x7f8>
ffffffffc0203aa4:	00008617          	auipc	a2,0x8
ffffffffc0203aa8:	25c60613          	addi	a2,a2,604 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203aac:	1e700593          	li	a1,487
ffffffffc0203ab0:	00009517          	auipc	a0,0x9
ffffffffc0203ab4:	ec050513          	addi	a0,a0,-320 # ffffffffc020c970 <default_pmm_manager+0x150>
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
ffffffffc0203af2:	d6a60613          	addi	a2,a2,-662 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc0203af6:	07100593          	li	a1,113
ffffffffc0203afa:	00009517          	auipc	a0,0x9
ffffffffc0203afe:	d8650513          	addi	a0,a0,-634 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0203b02:	99dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b06:	00009697          	auipc	a3,0x9
ffffffffc0203b0a:	4f268693          	addi	a3,a3,1266 # ffffffffc020cff8 <default_pmm_manager+0x7d8>
ffffffffc0203b0e:	00008617          	auipc	a2,0x8
ffffffffc0203b12:	1f260613          	addi	a2,a2,498 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203b16:	1ce00593          	li	a1,462
ffffffffc0203b1a:	00009517          	auipc	a0,0x9
ffffffffc0203b1e:	e5650513          	addi	a0,a0,-426 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203b22:	97dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b26:	00009697          	auipc	a3,0x9
ffffffffc0203b2a:	eb268693          	addi	a3,a3,-334 # ffffffffc020c9d8 <default_pmm_manager+0x1b8>
ffffffffc0203b2e:	00008617          	auipc	a2,0x8
ffffffffc0203b32:	1d260613          	addi	a2,a2,466 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203b36:	1b600593          	li	a1,438
ffffffffc0203b3a:	00009517          	auipc	a0,0x9
ffffffffc0203b3e:	e3650513          	addi	a0,a0,-458 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203b42:	95dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b46:	00009697          	auipc	a3,0x9
ffffffffc0203b4a:	4c268693          	addi	a3,a3,1218 # ffffffffc020d008 <default_pmm_manager+0x7e8>
ffffffffc0203b4e:	00008617          	auipc	a2,0x8
ffffffffc0203b52:	1b260613          	addi	a2,a2,434 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203b56:	1cf00593          	li	a1,463
ffffffffc0203b5a:	00009517          	auipc	a0,0x9
ffffffffc0203b5e:	e1650513          	addi	a0,a0,-490 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203b62:	93dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b66:	00009617          	auipc	a2,0x9
ffffffffc0203b6a:	dc260613          	addi	a2,a2,-574 # ffffffffc020c928 <default_pmm_manager+0x108>
ffffffffc0203b6e:	06900593          	li	a1,105
ffffffffc0203b72:	00009517          	auipc	a0,0x9
ffffffffc0203b76:	d0e50513          	addi	a0,a0,-754 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0203b7a:	925fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b7e:	00009617          	auipc	a2,0x9
ffffffffc0203b82:	dca60613          	addi	a2,a2,-566 # ffffffffc020c948 <default_pmm_manager+0x128>
ffffffffc0203b86:	07f00593          	li	a1,127
ffffffffc0203b8a:	00009517          	auipc	a0,0x9
ffffffffc0203b8e:	cf650513          	addi	a0,a0,-778 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0203b92:	90dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b96:	00009697          	auipc	a3,0x9
ffffffffc0203b9a:	e1268693          	addi	a3,a3,-494 # ffffffffc020c9a8 <default_pmm_manager+0x188>
ffffffffc0203b9e:	00008617          	auipc	a2,0x8
ffffffffc0203ba2:	16260613          	addi	a2,a2,354 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203ba6:	1b500593          	li	a1,437
ffffffffc0203baa:	00009517          	auipc	a0,0x9
ffffffffc0203bae:	dc650513          	addi	a0,a0,-570 # ffffffffc020c970 <default_pmm_manager+0x150>
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
ffffffffc0203c5c:	3d068693          	addi	a3,a3,976 # ffffffffc020d028 <default_pmm_manager+0x808>
ffffffffc0203c60:	00008617          	auipc	a2,0x8
ffffffffc0203c64:	0a060613          	addi	a2,a2,160 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203c68:	23000593          	li	a1,560
ffffffffc0203c6c:	00009517          	auipc	a0,0x9
ffffffffc0203c70:	d0450513          	addi	a0,a0,-764 # ffffffffc020c970 <default_pmm_manager+0x150>
ffffffffc0203c74:	82bfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c78 <check_vma_overlap.part.0>:
ffffffffc0203c78:	1141                	addi	sp,sp,-16
ffffffffc0203c7a:	00009697          	auipc	a3,0x9
ffffffffc0203c7e:	3c668693          	addi	a3,a3,966 # ffffffffc020d040 <default_pmm_manager+0x820>
ffffffffc0203c82:	00008617          	auipc	a2,0x8
ffffffffc0203c86:	07e60613          	addi	a2,a2,126 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203c8a:	07400593          	li	a1,116
ffffffffc0203c8e:	00009517          	auipc	a0,0x9
ffffffffc0203c92:	3d250513          	addi	a0,a0,978 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc0203d8e:	2e668693          	addi	a3,a3,742 # ffffffffc020d070 <default_pmm_manager+0x850>
ffffffffc0203d92:	00008617          	auipc	a2,0x8
ffffffffc0203d96:	f6e60613          	addi	a2,a2,-146 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203d9a:	07a00593          	li	a1,122
ffffffffc0203d9e:	00009517          	auipc	a0,0x9
ffffffffc0203da2:	2c250513          	addi	a0,a0,706 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0203da6:	ef8fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203daa:	00009697          	auipc	a3,0x9
ffffffffc0203dae:	30668693          	addi	a3,a3,774 # ffffffffc020d0b0 <default_pmm_manager+0x890>
ffffffffc0203db2:	00008617          	auipc	a2,0x8
ffffffffc0203db6:	f4e60613          	addi	a2,a2,-178 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203dba:	07300593          	li	a1,115
ffffffffc0203dbe:	00009517          	auipc	a0,0x9
ffffffffc0203dc2:	2a250513          	addi	a0,a0,674 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0203dc6:	ed8fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203dca:	00009697          	auipc	a3,0x9
ffffffffc0203dce:	2c668693          	addi	a3,a3,710 # ffffffffc020d090 <default_pmm_manager+0x870>
ffffffffc0203dd2:	00008617          	auipc	a2,0x8
ffffffffc0203dd6:	f2e60613          	addi	a2,a2,-210 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203dda:	07200593          	li	a1,114
ffffffffc0203dde:	00009517          	auipc	a0,0x9
ffffffffc0203de2:	28250513          	addi	a0,a0,642 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc0203e20:	2b468693          	addi	a3,a3,692 # ffffffffc020d0d0 <default_pmm_manager+0x8b0>
ffffffffc0203e24:	00008617          	auipc	a2,0x8
ffffffffc0203e28:	edc60613          	addi	a2,a2,-292 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203e2c:	09e00593          	li	a1,158
ffffffffc0203e30:	00009517          	auipc	a0,0x9
ffffffffc0203e34:	23050513          	addi	a0,a0,560 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc0203ed0:	21c68693          	addi	a3,a3,540 # ffffffffc020d0e8 <default_pmm_manager+0x8c8>
ffffffffc0203ed4:	00008617          	auipc	a2,0x8
ffffffffc0203ed8:	e2c60613          	addi	a2,a2,-468 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203edc:	0b300593          	li	a1,179
ffffffffc0203ee0:	00009517          	auipc	a0,0x9
ffffffffc0203ee4:	18050513          	addi	a0,a0,384 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc0203f6a:	19268693          	addi	a3,a3,402 # ffffffffc020d0f8 <default_pmm_manager+0x8d8>
ffffffffc0203f6e:	00008617          	auipc	a2,0x8
ffffffffc0203f72:	d9260613          	addi	a2,a2,-622 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203f76:	0cf00593          	li	a1,207
ffffffffc0203f7a:	00009517          	auipc	a0,0x9
ffffffffc0203f7e:	0e650513          	addi	a0,a0,230 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc0203fe0:	13c68693          	addi	a3,a3,316 # ffffffffc020d118 <default_pmm_manager+0x8f8>
ffffffffc0203fe4:	00008617          	auipc	a2,0x8
ffffffffc0203fe8:	d1c60613          	addi	a2,a2,-740 # ffffffffc020bd00 <commands+0x210>
ffffffffc0203fec:	0e800593          	li	a1,232
ffffffffc0203ff0:	00009517          	auipc	a0,0x9
ffffffffc0203ff4:	07050513          	addi	a0,a0,112 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc0204068:	24c68693          	addi	a3,a3,588 # ffffffffc020d2b0 <default_pmm_manager+0xa90>
ffffffffc020406c:	00008617          	auipc	a2,0x8
ffffffffc0204070:	c9460613          	addi	a2,a2,-876 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204074:	12c00593          	li	a1,300
ffffffffc0204078:	00009517          	auipc	a0,0x9
ffffffffc020407c:	fe850513          	addi	a0,a0,-24 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc02040b6:	1fe68693          	addi	a3,a3,510 # ffffffffc020d2b0 <default_pmm_manager+0xa90>
ffffffffc02040ba:	00008617          	auipc	a2,0x8
ffffffffc02040be:	c4660613          	addi	a2,a2,-954 # ffffffffc020bd00 <commands+0x210>
ffffffffc02040c2:	13300593          	li	a1,307
ffffffffc02040c6:	00009517          	auipc	a0,0x9
ffffffffc02040ca:	f9a50513          	addi	a0,a0,-102 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc020418a:	0b250513          	addi	a0,a0,178 # ffffffffc020d238 <default_pmm_manager+0xa18>
ffffffffc020418e:	818fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204192:	00009697          	auipc	a3,0x9
ffffffffc0204196:	0ce68693          	addi	a3,a3,206 # ffffffffc020d260 <default_pmm_manager+0xa40>
ffffffffc020419a:	00008617          	auipc	a2,0x8
ffffffffc020419e:	b6660613          	addi	a2,a2,-1178 # ffffffffc020bd00 <commands+0x210>
ffffffffc02041a2:	15900593          	li	a1,345
ffffffffc02041a6:	00009517          	auipc	a0,0x9
ffffffffc02041aa:	eba50513          	addi	a0,a0,-326 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc02041ae:	af0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b2:	147d                	addi	s0,s0,-1
ffffffffc02041b4:	fd2410e3          	bne	s0,s2,ffffffffc0204174 <vmm_init+0x178>
ffffffffc02041b8:	8526                	mv	a0,s1
ffffffffc02041ba:	c31ff0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc02041be:	00009517          	auipc	a0,0x9
ffffffffc02041c2:	0ba50513          	addi	a0,a0,186 # ffffffffc020d278 <default_pmm_manager+0xa58>
ffffffffc02041c6:	fe1fb0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02041ca:	7442                	ld	s0,48(sp)
ffffffffc02041cc:	70e2                	ld	ra,56(sp)
ffffffffc02041ce:	74a2                	ld	s1,40(sp)
ffffffffc02041d0:	7902                	ld	s2,32(sp)
ffffffffc02041d2:	69e2                	ld	s3,24(sp)
ffffffffc02041d4:	6a42                	ld	s4,16(sp)
ffffffffc02041d6:	6aa2                	ld	s5,8(sp)
ffffffffc02041d8:	00009517          	auipc	a0,0x9
ffffffffc02041dc:	0c050513          	addi	a0,a0,192 # ffffffffc020d298 <default_pmm_manager+0xa78>
ffffffffc02041e0:	6121                	addi	sp,sp,64
ffffffffc02041e2:	fc5fb06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02041e6:	00009697          	auipc	a3,0x9
ffffffffc02041ea:	f6a68693          	addi	a3,a3,-150 # ffffffffc020d150 <default_pmm_manager+0x930>
ffffffffc02041ee:	00008617          	auipc	a2,0x8
ffffffffc02041f2:	b1260613          	addi	a2,a2,-1262 # ffffffffc020bd00 <commands+0x210>
ffffffffc02041f6:	13d00593          	li	a1,317
ffffffffc02041fa:	00009517          	auipc	a0,0x9
ffffffffc02041fe:	e6650513          	addi	a0,a0,-410 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0204202:	a9cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204206:	00009697          	auipc	a3,0x9
ffffffffc020420a:	fd268693          	addi	a3,a3,-46 # ffffffffc020d1d8 <default_pmm_manager+0x9b8>
ffffffffc020420e:	00008617          	auipc	a2,0x8
ffffffffc0204212:	af260613          	addi	a2,a2,-1294 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204216:	14e00593          	li	a1,334
ffffffffc020421a:	00009517          	auipc	a0,0x9
ffffffffc020421e:	e4650513          	addi	a0,a0,-442 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0204222:	a7cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204226:	00009697          	auipc	a3,0x9
ffffffffc020422a:	fe268693          	addi	a3,a3,-30 # ffffffffc020d208 <default_pmm_manager+0x9e8>
ffffffffc020422e:	00008617          	auipc	a2,0x8
ffffffffc0204232:	ad260613          	addi	a2,a2,-1326 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204236:	14f00593          	li	a1,335
ffffffffc020423a:	00009517          	auipc	a0,0x9
ffffffffc020423e:	e2650513          	addi	a0,a0,-474 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0204242:	a5cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204246:	00009697          	auipc	a3,0x9
ffffffffc020424a:	ef268693          	addi	a3,a3,-270 # ffffffffc020d138 <default_pmm_manager+0x918>
ffffffffc020424e:	00008617          	auipc	a2,0x8
ffffffffc0204252:	ab260613          	addi	a2,a2,-1358 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204256:	13b00593          	li	a1,315
ffffffffc020425a:	00009517          	auipc	a0,0x9
ffffffffc020425e:	e0650513          	addi	a0,a0,-506 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0204262:	a3cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204266:	00009697          	auipc	a3,0x9
ffffffffc020426a:	f3268693          	addi	a3,a3,-206 # ffffffffc020d198 <default_pmm_manager+0x978>
ffffffffc020426e:	00008617          	auipc	a2,0x8
ffffffffc0204272:	a9260613          	addi	a2,a2,-1390 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204276:	14600593          	li	a1,326
ffffffffc020427a:	00009517          	auipc	a0,0x9
ffffffffc020427e:	de650513          	addi	a0,a0,-538 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0204282:	a1cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204286:	00009697          	auipc	a3,0x9
ffffffffc020428a:	f0268693          	addi	a3,a3,-254 # ffffffffc020d188 <default_pmm_manager+0x968>
ffffffffc020428e:	00008617          	auipc	a2,0x8
ffffffffc0204292:	a7260613          	addi	a2,a2,-1422 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204296:	14400593          	li	a1,324
ffffffffc020429a:	00009517          	auipc	a0,0x9
ffffffffc020429e:	dc650513          	addi	a0,a0,-570 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc02042a2:	9fcfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042a6:	00009697          	auipc	a3,0x9
ffffffffc02042aa:	f0268693          	addi	a3,a3,-254 # ffffffffc020d1a8 <default_pmm_manager+0x988>
ffffffffc02042ae:	00008617          	auipc	a2,0x8
ffffffffc02042b2:	a5260613          	addi	a2,a2,-1454 # ffffffffc020bd00 <commands+0x210>
ffffffffc02042b6:	14800593          	li	a1,328
ffffffffc02042ba:	00009517          	auipc	a0,0x9
ffffffffc02042be:	da650513          	addi	a0,a0,-602 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc02042c2:	9dcfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042c6:	00009697          	auipc	a3,0x9
ffffffffc02042ca:	f0268693          	addi	a3,a3,-254 # ffffffffc020d1c8 <default_pmm_manager+0x9a8>
ffffffffc02042ce:	00008617          	auipc	a2,0x8
ffffffffc02042d2:	a3260613          	addi	a2,a2,-1486 # ffffffffc020bd00 <commands+0x210>
ffffffffc02042d6:	14c00593          	li	a1,332
ffffffffc02042da:	00009517          	auipc	a0,0x9
ffffffffc02042de:	d8650513          	addi	a0,a0,-634 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc02042e2:	9bcfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042e6:	00009697          	auipc	a3,0x9
ffffffffc02042ea:	ed268693          	addi	a3,a3,-302 # ffffffffc020d1b8 <default_pmm_manager+0x998>
ffffffffc02042ee:	00008617          	auipc	a2,0x8
ffffffffc02042f2:	a1260613          	addi	a2,a2,-1518 # ffffffffc020bd00 <commands+0x210>
ffffffffc02042f6:	14a00593          	li	a1,330
ffffffffc02042fa:	00009517          	auipc	a0,0x9
ffffffffc02042fe:	d6650513          	addi	a0,a0,-666 # ffffffffc020d060 <default_pmm_manager+0x840>
ffffffffc0204302:	99cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204306:	00009697          	auipc	a3,0x9
ffffffffc020430a:	de268693          	addi	a3,a3,-542 # ffffffffc020d0e8 <default_pmm_manager+0x8c8>
ffffffffc020430e:	00008617          	auipc	a2,0x8
ffffffffc0204312:	9f260613          	addi	a2,a2,-1550 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204316:	12400593          	li	a1,292
ffffffffc020431a:	00009517          	auipc	a0,0x9
ffffffffc020431e:	d4650513          	addi	a0,a0,-698 # ffffffffc020d060 <default_pmm_manager+0x840>
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
ffffffffc02043dc:	490070ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc020440e:	45e070ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc0204448:	34a070ef          	jal	ra,ffffffffc020b792 <strnlen>
ffffffffc020444c:	87aa                	mv	a5,a0
ffffffffc020444e:	85a6                	mv	a1,s1
ffffffffc0204450:	8552                	mv	a0,s4
ffffffffc0204452:	8622                	mv	a2,s0
ffffffffc0204454:	0487e363          	bltu	a5,s0,ffffffffc020449a <copy_string+0x7a>
ffffffffc0204458:	0329f763          	bgeu	s3,s2,ffffffffc0204486 <copy_string+0x66>
ffffffffc020445c:	410070ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc020449e:	3ce070ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc02044e4:	1c2030ef          	jal	ra,ffffffffc02076a6 <schedule>
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
ffffffffc02045d8:	cec68693          	addi	a3,a3,-788 # ffffffffc020d2c0 <default_pmm_manager+0xaa0>
ffffffffc02045dc:	00007617          	auipc	a2,0x7
ffffffffc02045e0:	72460613          	addi	a2,a2,1828 # ffffffffc020bd00 <commands+0x210>
ffffffffc02045e4:	45e5                	li	a1,25
ffffffffc02045e6:	00009517          	auipc	a0,0x9
ffffffffc02045ea:	d0250513          	addi	a0,a0,-766 # ffffffffc020d2e8 <default_pmm_manager+0xac8>
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
ffffffffc0204612:	cea68693          	addi	a3,a3,-790 # ffffffffc020d2f8 <default_pmm_manager+0xad8>
ffffffffc0204616:	00007617          	auipc	a2,0x7
ffffffffc020461a:	6ea60613          	addi	a2,a2,1770 # ffffffffc020bd00 <commands+0x210>
ffffffffc020461e:	04000593          	li	a1,64
ffffffffc0204622:	00009517          	auipc	a0,0x9
ffffffffc0204626:	cc650513          	addi	a0,a0,-826 # ffffffffc020d2e8 <default_pmm_manager+0xac8>
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
ffffffffc0204656:	d0668693          	addi	a3,a3,-762 # ffffffffc020d358 <default_pmm_manager+0xb38>
ffffffffc020465a:	00007617          	auipc	a2,0x7
ffffffffc020465e:	6a660613          	addi	a2,a2,1702 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204662:	45f1                	li	a1,28
ffffffffc0204664:	00009517          	auipc	a0,0x9
ffffffffc0204668:	cdc50513          	addi	a0,a0,-804 # ffffffffc020d340 <default_pmm_manager+0xb20>
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
ffffffffc02046a2:	7530206f          	j	ffffffffc02075f4 <wakeup_proc>
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
ffffffffc02046c4:	7310206f          	j	ffffffffc02075f4 <wakeup_proc>
ffffffffc02046c8:	1141                	addi	sp,sp,-16
ffffffffc02046ca:	00009697          	auipc	a3,0x9
ffffffffc02046ce:	c8e68693          	addi	a3,a3,-882 # ffffffffc020d358 <default_pmm_manager+0xb38>
ffffffffc02046d2:	00007617          	auipc	a2,0x7
ffffffffc02046d6:	62e60613          	addi	a2,a2,1582 # ffffffffc020bd00 <commands+0x210>
ffffffffc02046da:	45f1                	li	a1,28
ffffffffc02046dc:	00009517          	auipc	a0,0x9
ffffffffc02046e0:	c6450513          	addi	a0,a0,-924 # ffffffffc020d340 <default_pmm_manager+0xb20>
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
ffffffffc020470a:	6eb020ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
ffffffffc020470e:	701c                	ld	a5,32(s0)
ffffffffc0204710:	01840713          	addi	a4,s0,24
ffffffffc0204714:	02e78463          	beq	a5,a4,ffffffffc020473c <wakeup_queue+0x52>
ffffffffc0204718:	6818                	ld	a4,16(s0)
ffffffffc020471a:	02e49163          	bne	s1,a4,ffffffffc020473c <wakeup_queue+0x52>
ffffffffc020471e:	02f48f63          	beq	s1,a5,ffffffffc020475c <wakeup_queue+0x72>
ffffffffc0204722:	fe87b503          	ld	a0,-24(a5)
ffffffffc0204726:	ff27a823          	sw	s2,-16(a5)
ffffffffc020472a:	fe878413          	addi	s0,a5,-24
ffffffffc020472e:	6c7020ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
ffffffffc0204732:	701c                	ld	a5,32(s0)
ffffffffc0204734:	01840713          	addi	a4,s0,24
ffffffffc0204738:	fee790e3          	bne	a5,a4,ffffffffc0204718 <wakeup_queue+0x2e>
ffffffffc020473c:	00009697          	auipc	a3,0x9
ffffffffc0204740:	c1c68693          	addi	a3,a3,-996 # ffffffffc020d358 <default_pmm_manager+0xb38>
ffffffffc0204744:	00007617          	auipc	a2,0x7
ffffffffc0204748:	5bc60613          	addi	a2,a2,1468 # ffffffffc020bd00 <commands+0x210>
ffffffffc020474c:	02200593          	li	a1,34
ffffffffc0204750:	00009517          	auipc	a0,0x9
ffffffffc0204754:	bf050513          	addi	a0,a0,-1040 # ffffffffc020d340 <default_pmm_manager+0xb20>
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
ffffffffc0204784:	671020ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
ffffffffc0204788:	6480                	ld	s0,8(s1)
ffffffffc020478a:	fc8489e3          	beq	s1,s0,ffffffffc020475c <wakeup_queue+0x72>
ffffffffc020478e:	6418                	ld	a4,8(s0)
ffffffffc0204790:	87a2                	mv	a5,s0
ffffffffc0204792:	1421                	addi	s0,s0,-24
ffffffffc0204794:	fce79de3          	bne	a5,a4,ffffffffc020476e <wakeup_queue+0x84>
ffffffffc0204798:	00009697          	auipc	a3,0x9
ffffffffc020479c:	bc068693          	addi	a3,a3,-1088 # ffffffffc020d358 <default_pmm_manager+0xb38>
ffffffffc02047a0:	00007617          	auipc	a2,0x7
ffffffffc02047a4:	56060613          	addi	a2,a2,1376 # ffffffffc020bd00 <commands+0x210>
ffffffffc02047a8:	45f1                	li	a1,28
ffffffffc02047aa:	00009517          	auipc	a0,0x9
ffffffffc02047ae:	b9650513          	addi	a0,a0,-1130 # ffffffffc020d340 <default_pmm_manager+0xb20>
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
ffffffffc02047ec:	bb068693          	addi	a3,a3,-1104 # ffffffffc020d398 <default_pmm_manager+0xb78>
ffffffffc02047f0:	00007617          	auipc	a2,0x7
ffffffffc02047f4:	51060613          	addi	a2,a2,1296 # ffffffffc020bd00 <commands+0x210>
ffffffffc02047f8:	07400593          	li	a1,116
ffffffffc02047fc:	00009517          	auipc	a0,0x9
ffffffffc0204800:	b4450513          	addi	a0,a0,-1212 # ffffffffc020d340 <default_pmm_manager+0xb20>
ffffffffc0204804:	e406                	sd	ra,8(sp)
ffffffffc0204806:	c99fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020480a <get_fd_array.part.0>:
ffffffffc020480a:	1141                	addi	sp,sp,-16
ffffffffc020480c:	00009697          	auipc	a3,0x9
ffffffffc0204810:	b9c68693          	addi	a3,a3,-1124 # ffffffffc020d3a8 <default_pmm_manager+0xb88>
ffffffffc0204814:	00007617          	auipc	a2,0x7
ffffffffc0204818:	4ec60613          	addi	a2,a2,1260 # ffffffffc020bd00 <commands+0x210>
ffffffffc020481c:	45d1                	li	a1,20
ffffffffc020481e:	00009517          	auipc	a0,0x9
ffffffffc0204822:	bba50513          	addi	a0,a0,-1094 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc02048a4:	b4868693          	addi	a3,a3,-1208 # ffffffffc020d3e8 <default_pmm_manager+0xbc8>
ffffffffc02048a8:	00007617          	auipc	a2,0x7
ffffffffc02048ac:	45860613          	addi	a2,a2,1112 # ffffffffc020bd00 <commands+0x210>
ffffffffc02048b0:	03b00593          	li	a1,59
ffffffffc02048b4:	00009517          	auipc	a0,0x9
ffffffffc02048b8:	b2450513          	addi	a0,a0,-1244 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc02048de:	b0e68693          	addi	a3,a3,-1266 # ffffffffc020d3e8 <default_pmm_manager+0xbc8>
ffffffffc02048e2:	00007617          	auipc	a2,0x7
ffffffffc02048e6:	41e60613          	addi	a2,a2,1054 # ffffffffc020bd00 <commands+0x210>
ffffffffc02048ea:	04500593          	li	a1,69
ffffffffc02048ee:	00009517          	auipc	a0,0x9
ffffffffc02048f2:	aea50513          	addi	a0,a0,-1302 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
ffffffffc02048f6:	ba9fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048fa:	7408                	ld	a0,40(s0)
ffffffffc02048fc:	36f030ef          	jal	ra,ffffffffc020846a <vfs_close>
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
ffffffffc0204920:	b0468693          	addi	a3,a3,-1276 # ffffffffc020d420 <default_pmm_manager+0xc00>
ffffffffc0204924:	00007617          	auipc	a2,0x7
ffffffffc0204928:	3dc60613          	addi	a2,a2,988 # ffffffffc020bd00 <commands+0x210>
ffffffffc020492c:	04400593          	li	a1,68
ffffffffc0204930:	00009517          	auipc	a0,0x9
ffffffffc0204934:	aa850513          	addi	a0,a0,-1368 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc020496a:	b2a68693          	addi	a3,a3,-1238 # ffffffffc020d490 <default_pmm_manager+0xc70>
ffffffffc020496e:	00007617          	auipc	a2,0x7
ffffffffc0204972:	39260613          	addi	a2,a2,914 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204976:	05600593          	li	a1,86
ffffffffc020497a:	00009517          	auipc	a0,0x9
ffffffffc020497e:	a5e50513          	addi	a0,a0,-1442 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
ffffffffc0204982:	b1dfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204986:	00009697          	auipc	a3,0x9
ffffffffc020498a:	ad268693          	addi	a3,a3,-1326 # ffffffffc020d458 <default_pmm_manager+0xc38>
ffffffffc020498e:	00007617          	auipc	a2,0x7
ffffffffc0204992:	37260613          	addi	a2,a2,882 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204996:	05500593          	li	a1,85
ffffffffc020499a:	00009517          	auipc	a0,0x9
ffffffffc020499e:	a3e50513          	addi	a0,a0,-1474 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
ffffffffc02049a2:	afdfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02049a6 <fd_array_open.part.0>:
ffffffffc02049a6:	1141                	addi	sp,sp,-16
ffffffffc02049a8:	00009697          	auipc	a3,0x9
ffffffffc02049ac:	b0068693          	addi	a3,a3,-1280 # ffffffffc020d4a8 <default_pmm_manager+0xc88>
ffffffffc02049b0:	00007617          	auipc	a2,0x7
ffffffffc02049b4:	35060613          	addi	a2,a2,848 # ffffffffc020bd00 <commands+0x210>
ffffffffc02049b8:	05f00593          	li	a1,95
ffffffffc02049bc:	00009517          	auipc	a0,0x9
ffffffffc02049c0:	a1c50513          	addi	a0,a0,-1508 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0204a14:	257030ef          	jal	ra,ffffffffc020846a <vfs_close>
ffffffffc0204a18:	60a2                	ld	ra,8(sp)
ffffffffc0204a1a:	00042023          	sw	zero,0(s0)
ffffffffc0204a1e:	6402                	ld	s0,0(sp)
ffffffffc0204a20:	0141                	addi	sp,sp,16
ffffffffc0204a22:	8082                	ret
ffffffffc0204a24:	00009697          	auipc	a3,0x9
ffffffffc0204a28:	a6c68693          	addi	a3,a3,-1428 # ffffffffc020d490 <default_pmm_manager+0xc70>
ffffffffc0204a2c:	00007617          	auipc	a2,0x7
ffffffffc0204a30:	2d460613          	addi	a2,a2,724 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204a34:	06800593          	li	a1,104
ffffffffc0204a38:	00009517          	auipc	a0,0x9
ffffffffc0204a3c:	9a050513          	addi	a0,a0,-1632 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
ffffffffc0204a40:	a5ffb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a44:	00009697          	auipc	a3,0x9
ffffffffc0204a48:	9bc68693          	addi	a3,a3,-1604 # ffffffffc020d400 <default_pmm_manager+0xbe0>
ffffffffc0204a4c:	00007617          	auipc	a2,0x7
ffffffffc0204a50:	2b460613          	addi	a2,a2,692 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204a54:	06700593          	li	a1,103
ffffffffc0204a58:	00009517          	auipc	a0,0x9
ffffffffc0204a5c:	98050513          	addi	a0,a0,-1664 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0204a96:	132030ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc0204a9a:	8526                	mv	a0,s1
ffffffffc0204a9c:	138030ef          	jal	ra,ffffffffc0207bd4 <inode_open_inc>
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
ffffffffc0204ac6:	a1668693          	addi	a3,a3,-1514 # ffffffffc020d4d8 <default_pmm_manager+0xcb8>
ffffffffc0204aca:	00007617          	auipc	a2,0x7
ffffffffc0204ace:	23660613          	addi	a2,a2,566 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204ad2:	07300593          	li	a1,115
ffffffffc0204ad6:	00009517          	auipc	a0,0x9
ffffffffc0204ada:	90250513          	addi	a0,a0,-1790 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0204b58:	bf470713          	addi	a4,a4,-1036 # ffffffffc020d748 <CSWTCH.79>
ffffffffc0204b5c:	892a                	mv	s2,a0
ffffffffc0204b5e:	00009697          	auipc	a3,0x9
ffffffffc0204b62:	bd268693          	addi	a3,a3,-1070 # ffffffffc020d730 <CSWTCH.78>
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
ffffffffc0204b9c:	728030ef          	jal	ra,ffffffffc02082c4 <vfs_open>
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
ffffffffc0204bc2:	9a258593          	addi	a1,a1,-1630 # ffffffffc020d560 <default_pmm_manager+0xd40>
ffffffffc0204bc6:	01a030ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc0204c04:	067030ef          	jal	ra,ffffffffc020846a <vfs_close>
ffffffffc0204c08:	6502                	ld	a0,0(sp)
ffffffffc0204c0a:	cb7ff0ef          	jal	ra,ffffffffc02048c0 <fd_array_free>
ffffffffc0204c0e:	bf9d                	j	ffffffffc0204b84 <file_open+0x4a>
ffffffffc0204c10:	5475                	li	s0,-3
ffffffffc0204c12:	bf8d                	j	ffffffffc0204b84 <file_open+0x4a>
ffffffffc0204c14:	d93ff0ef          	jal	ra,ffffffffc02049a6 <fd_array_open.part.0>
ffffffffc0204c18:	00009697          	auipc	a3,0x9
ffffffffc0204c1c:	8f868693          	addi	a3,a3,-1800 # ffffffffc020d510 <default_pmm_manager+0xcf0>
ffffffffc0204c20:	00007617          	auipc	a2,0x7
ffffffffc0204c24:	0e060613          	addi	a2,a2,224 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204c28:	0b500593          	li	a1,181
ffffffffc0204c2c:	00008517          	auipc	a0,0x8
ffffffffc0204c30:	7ac50513          	addi	a0,a0,1964 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0204d04:	8b858593          	addi	a1,a1,-1864 # ffffffffc020d5b8 <default_pmm_manager+0xd98>
ffffffffc0204d08:	854a                	mv	a0,s2
ffffffffc0204d0a:	6d7020ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc0204d58:	81468693          	addi	a3,a3,-2028 # ffffffffc020d568 <default_pmm_manager+0xd48>
ffffffffc0204d5c:	00007617          	auipc	a2,0x7
ffffffffc0204d60:	fa460613          	addi	a2,a2,-92 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204d64:	0de00593          	li	a1,222
ffffffffc0204d68:	00008517          	auipc	a0,0x8
ffffffffc0204d6c:	67050513          	addi	a0,a0,1648 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0204dea:	82a58593          	addi	a1,a1,-2006 # ffffffffc020d610 <default_pmm_manager+0xdf0>
ffffffffc0204dee:	854a                	mv	a0,s2
ffffffffc0204df0:	5f1020ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc0204e3a:	00008697          	auipc	a3,0x8
ffffffffc0204e3e:	78668693          	addi	a3,a3,1926 # ffffffffc020d5c0 <default_pmm_manager+0xda0>
ffffffffc0204e42:	00007617          	auipc	a2,0x7
ffffffffc0204e46:	ebe60613          	addi	a2,a2,-322 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204e4a:	0f800593          	li	a1,248
ffffffffc0204e4e:	00008517          	auipc	a0,0x8
ffffffffc0204e52:	58a50513          	addi	a0,a0,1418 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0204ed8:	00008597          	auipc	a1,0x8
ffffffffc0204edc:	79058593          	addi	a1,a1,1936 # ffffffffc020d668 <default_pmm_manager+0xe48>
ffffffffc0204ee0:	501020ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc0204f1a:	64a58593          	addi	a1,a1,1610 # ffffffffc020d560 <default_pmm_manager+0xd40>
ffffffffc0204f1e:	4c3020ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc0204f3e:	6de68693          	addi	a3,a3,1758 # ffffffffc020d618 <default_pmm_manager+0xdf8>
ffffffffc0204f42:	00007617          	auipc	a2,0x7
ffffffffc0204f46:	dbe60613          	addi	a2,a2,-578 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204f4a:	11a00593          	li	a1,282
ffffffffc0204f4e:	00008517          	auipc	a0,0x8
ffffffffc0204f52:	48a50513          	addi	a0,a0,1162 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
ffffffffc0204f56:	d48fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204f5a:	00008697          	auipc	a3,0x8
ffffffffc0204f5e:	5b668693          	addi	a3,a3,1462 # ffffffffc020d510 <default_pmm_manager+0xcf0>
ffffffffc0204f62:	00007617          	auipc	a2,0x7
ffffffffc0204f66:	d9e60613          	addi	a2,a2,-610 # ffffffffc020bd00 <commands+0x210>
ffffffffc0204f6a:	11200593          	li	a1,274
ffffffffc0204f6e:	00008517          	auipc	a0,0x8
ffffffffc0204f72:	46a50513          	addi	a0,a0,1130 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0204fda:	58a58593          	addi	a1,a1,1418 # ffffffffc020d560 <default_pmm_manager+0xd40>
ffffffffc0204fde:	403020ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc020501a:	4fa68693          	addi	a3,a3,1274 # ffffffffc020d510 <default_pmm_manager+0xcf0>
ffffffffc020501e:	00007617          	auipc	a2,0x7
ffffffffc0205022:	ce260613          	addi	a2,a2,-798 # ffffffffc020bd00 <commands+0x210>
ffffffffc0205026:	12c00593          	li	a1,300
ffffffffc020502a:	00008517          	auipc	a0,0x8
ffffffffc020502e:	3ae50513          	addi	a0,a0,942 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc020508e:	63658593          	addi	a1,a1,1590 # ffffffffc020d6c0 <default_pmm_manager+0xea0>
ffffffffc0205092:	8526                	mv	a0,s1
ffffffffc0205094:	34d020ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc02050c8:	5ac68693          	addi	a3,a3,1452 # ffffffffc020d670 <default_pmm_manager+0xe50>
ffffffffc02050cc:	00007617          	auipc	a2,0x7
ffffffffc02050d0:	c3460613          	addi	a2,a2,-972 # ffffffffc020bd00 <commands+0x210>
ffffffffc02050d4:	13a00593          	li	a1,314
ffffffffc02050d8:	00008517          	auipc	a0,0x8
ffffffffc02050dc:	30050513          	addi	a0,a0,768 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc020515a:	5ca58593          	addi	a1,a1,1482 # ffffffffc020d720 <default_pmm_manager+0xf00>
ffffffffc020515e:	283020ef          	jal	ra,ffffffffc0207be0 <inode_check>
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
ffffffffc02051ae:	51e68693          	addi	a3,a3,1310 # ffffffffc020d6c8 <default_pmm_manager+0xea8>
ffffffffc02051b2:	00007617          	auipc	a2,0x7
ffffffffc02051b6:	b4e60613          	addi	a2,a2,-1202 # ffffffffc020bd00 <commands+0x210>
ffffffffc02051ba:	14a00593          	li	a1,330
ffffffffc02051be:	00008517          	auipc	a0,0x8
ffffffffc02051c2:	21a50513          	addi	a0,a0,538 # ffffffffc020d3d8 <default_pmm_manager+0xbb8>
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
ffffffffc0205246:	3b9020ef          	jal	ra,ffffffffc0207dfe <vfs_init>
ffffffffc020524a:	091030ef          	jal	ra,ffffffffc0208ada <dev_init>
ffffffffc020524e:	60a2                	ld	ra,8(sp)
ffffffffc0205250:	0141                	addi	sp,sp,16
ffffffffc0205252:	1e00406f          	j	ffffffffc0209432 <sfs_init>

ffffffffc0205256 <fs_cleanup>:
ffffffffc0205256:	5fb0206f          	j	ffffffffc0208050 <vfs_cleanup>

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
ffffffffc02052b4:	1e3020ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
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
ffffffffc02052f6:	4ae68693          	addi	a3,a3,1198 # ffffffffc020d7a0 <CSWTCH.79+0x58>
ffffffffc02052fa:	00007617          	auipc	a2,0x7
ffffffffc02052fe:	a0660613          	addi	a2,a2,-1530 # ffffffffc020bd00 <commands+0x210>
ffffffffc0205302:	03d00593          	li	a1,61
ffffffffc0205306:	00008517          	auipc	a0,0x8
ffffffffc020530a:	48a50513          	addi	a0,a0,1162 # ffffffffc020d790 <CSWTCH.79+0x48>
ffffffffc020530e:	990fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205312:	00008697          	auipc	a3,0x8
ffffffffc0205316:	44e68693          	addi	a3,a3,1102 # ffffffffc020d760 <CSWTCH.79+0x18>
ffffffffc020531a:	00007617          	auipc	a2,0x7
ffffffffc020531e:	9e660613          	addi	a2,a2,-1562 # ffffffffc020bd00 <commands+0x210>
ffffffffc0205322:	03300593          	li	a1,51
ffffffffc0205326:	00008517          	auipc	a0,0x8
ffffffffc020532a:	46a50513          	addi	a0,a0,1130 # ffffffffc020d790 <CSWTCH.79+0x48>
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
ffffffffc0205382:	02a68693          	addi	a3,a3,42 # ffffffffc020d3a8 <default_pmm_manager+0xb88>
ffffffffc0205386:	00007617          	auipc	a2,0x7
ffffffffc020538a:	97a60613          	addi	a2,a2,-1670 # ffffffffc020bd00 <commands+0x210>
ffffffffc020538e:	04500593          	li	a1,69
ffffffffc0205392:	00008517          	auipc	a0,0x8
ffffffffc0205396:	3fe50513          	addi	a0,a0,1022 # ffffffffc020d790 <CSWTCH.79+0x48>
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
ffffffffc02053c4:	005020ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
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
ffffffffc020541a:	ce268693          	addi	a3,a3,-798 # ffffffffc020d0f8 <default_pmm_manager+0x8d8>
ffffffffc020541e:	00007617          	auipc	a2,0x7
ffffffffc0205422:	8e260613          	addi	a2,a2,-1822 # ffffffffc020bd00 <commands+0x210>
ffffffffc0205426:	05300593          	li	a1,83
ffffffffc020542a:	00008517          	auipc	a0,0x8
ffffffffc020542e:	36650513          	addi	a0,a0,870 # ffffffffc020d790 <CSWTCH.79+0x48>
ffffffffc0205432:	86cfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205436:	00008697          	auipc	a3,0x8
ffffffffc020543a:	38268693          	addi	a3,a3,898 # ffffffffc020d7b8 <CSWTCH.79+0x70>
ffffffffc020543e:	00007617          	auipc	a2,0x7
ffffffffc0205442:	8c260613          	addi	a2,a2,-1854 # ffffffffc020bd00 <commands+0x210>
ffffffffc0205446:	05400593          	li	a1,84
ffffffffc020544a:	00008517          	auipc	a0,0x8
ffffffffc020544e:	34650513          	addi	a0,a0,838 # ffffffffc020d790 <CSWTCH.79+0x48>
ffffffffc0205452:	84cfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205456 <iobuf_skip.part.0>:
ffffffffc0205456:	1141                	addi	sp,sp,-16
ffffffffc0205458:	00008697          	auipc	a3,0x8
ffffffffc020545c:	39068693          	addi	a3,a3,912 # ffffffffc020d7e8 <CSWTCH.79+0xa0>
ffffffffc0205460:	00007617          	auipc	a2,0x7
ffffffffc0205464:	8a060613          	addi	a2,a2,-1888 # ffffffffc020bd00 <commands+0x210>
ffffffffc0205468:	04a00593          	li	a1,74
ffffffffc020546c:	00008517          	auipc	a0,0x8
ffffffffc0205470:	39450513          	addi	a0,a0,916 # ffffffffc020d800 <CSWTCH.79+0xb8>
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
ffffffffc02054ae:	37e060ef          	jal	ra,ffffffffc020b82c <memmove>
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
ffffffffc02056ee:	12668693          	addi	a3,a3,294 # ffffffffc020d810 <CSWTCH.79+0xc8>
ffffffffc02056f2:	00006617          	auipc	a2,0x6
ffffffffc02056f6:	60e60613          	addi	a2,a2,1550 # ffffffffc020bd00 <commands+0x210>
ffffffffc02056fa:	05500593          	li	a1,85
ffffffffc02056fe:	00008517          	auipc	a0,0x8
ffffffffc0205702:	12250513          	addi	a0,a0,290 # ffffffffc020d820 <CSWTCH.79+0xd8>
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
ffffffffc0205808:	00c68693          	addi	a3,a3,12 # ffffffffc020d810 <CSWTCH.79+0xc8>
ffffffffc020580c:	00006617          	auipc	a2,0x6
ffffffffc0205810:	4f460613          	addi	a2,a2,1268 # ffffffffc020bd00 <commands+0x210>
ffffffffc0205814:	08a00593          	li	a1,138
ffffffffc0205818:	00008517          	auipc	a0,0x8
ffffffffc020581c:	00850513          	addi	a0,a0,8 # ffffffffc020d820 <CSWTCH.79+0xd8>
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
ffffffffc0205954:	633020ef          	jal	ra,ffffffffc0208786 <vfs_getcwd>
ffffffffc0205958:	842a                	mv	s0,a0
ffffffffc020595a:	b7c1                	j	ffffffffc020591a <sysfile_getcwd+0x4e>
ffffffffc020595c:	8622                	mv	a2,s0
ffffffffc020595e:	4681                	li	a3,0
ffffffffc0205960:	85a6                	mv	a1,s1
ffffffffc0205962:	850a                	mv	a0,sp
ffffffffc0205964:	b17ff0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0205968:	61f020ef          	jal	ra,ffffffffc0208786 <vfs_getcwd>
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
ffffffffc0205aa2:	579050ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc0205aa6:	00091797          	auipc	a5,0x91
ffffffffc0205aaa:	dea7b783          	ld	a5,-534(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205aae:	f45c                	sd	a5,168(s0)
ffffffffc0205ab0:	0a043023          	sd	zero,160(s0)
ffffffffc0205ab4:	0a042823          	sw	zero,176(s0)
ffffffffc0205ab8:	463d                	li	a2,15
ffffffffc0205aba:	4581                	li	a1,0
ffffffffc0205abc:	0b440513          	addi	a0,s0,180
ffffffffc0205ac0:	55b050ef          	jal	ra,ffffffffc020b81a <memset>
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
ffffffffc0205b16:	f066b683          	ld	a3,-250(a3) # ffffffffc020fa18 <nbase>
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
ffffffffc0205b44:	d1860613          	addi	a2,a2,-744 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc0205b48:	07100593          	li	a1,113
ffffffffc0205b4c:	00007517          	auipc	a0,0x7
ffffffffc0205b50:	d3450513          	addi	a0,a0,-716 # ffffffffc020c880 <default_pmm_manager+0x60>
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
ffffffffc0205b90:	e8c6b683          	ld	a3,-372(a3) # ffffffffc020fa18 <nbase>
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
ffffffffc0205bb2:	d5260613          	addi	a2,a2,-686 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc0205bb6:	07700593          	li	a1,119
ffffffffc0205bba:	00007517          	auipc	a0,0x7
ffffffffc0205bbe:	cc650513          	addi	a0,a0,-826 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0205bc2:	8ddfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205bc6:	00007617          	auipc	a2,0x7
ffffffffc0205bca:	d6260613          	addi	a2,a2,-670 # ffffffffc020c928 <default_pmm_manager+0x108>
ffffffffc0205bce:	06900593          	li	a1,105
ffffffffc0205bd2:	00007517          	auipc	a0,0x7
ffffffffc0205bd6:	cae50513          	addi	a0,a0,-850 # ffffffffc020c880 <default_pmm_manager+0x60>
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
ffffffffc0205c20:	031010ef          	jal	ra,ffffffffc0207450 <switch_to>
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
ffffffffc0205cbe:	d5ecbc83          	ld	s9,-674(s9) # ffffffffc020fa18 <nbase>
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
ffffffffc0205e4e:	21f050ef          	jal	ra,ffffffffc020b86c <memcpy>
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
ffffffffc0205ece:	14d050ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc0205ed2:	463d                	li	a2,15
ffffffffc0205ed4:	0b4c0593          	addi	a1,s8,180
ffffffffc0205ed8:	854e                	mv	a0,s3
ffffffffc0205eda:	193050ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc0205ede:	100027f3          	csrr	a5,sstatus
ffffffffc0205ee2:	8b89                	andi	a5,a5,2
ffffffffc0205ee4:	4981                	li	s3,0
ffffffffc0205ee6:	e3f5                	bnez	a5,ffffffffc0205fca <do_fork+0x37c>
ffffffffc0205ee8:	4048                	lw	a0,4(s0)
ffffffffc0205eea:	45a9                	li	a1,10
ffffffffc0205eec:	3fa050ef          	jal	ra,ffffffffc020b2e6 <hash32>
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
ffffffffc0205f42:	6b2010ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
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
ffffffffc0206052:	80a60613          	addi	a2,a2,-2038 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc0206056:	07100593          	li	a1,113
ffffffffc020605a:	00007517          	auipc	a0,0x7
ffffffffc020605e:	82650513          	addi	a0,a0,-2010 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0206062:	c3cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206066:	00007617          	auipc	a2,0x7
ffffffffc020606a:	89a60613          	addi	a2,a2,-1894 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc020606e:	07700593          	li	a1,119
ffffffffc0206072:	00007517          	auipc	a0,0x7
ffffffffc0206076:	80e50513          	addi	a0,a0,-2034 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc020607a:	c24fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020607e:	00007617          	auipc	a2,0x7
ffffffffc0206082:	8aa60613          	addi	a2,a2,-1878 # ffffffffc020c928 <default_pmm_manager+0x108>
ffffffffc0206086:	06900593          	li	a1,105
ffffffffc020608a:	00006517          	auipc	a0,0x6
ffffffffc020608e:	7f650513          	addi	a0,a0,2038 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0206092:	c0cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206096:	00007617          	auipc	a2,0x7
ffffffffc020609a:	86a60613          	addi	a2,a2,-1942 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc020609e:	1b000593          	li	a1,432
ffffffffc02060a2:	00007517          	auipc	a0,0x7
ffffffffc02060a6:	79650513          	addi	a0,a0,1942 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc02060aa:	bf4fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02060ae:	00007697          	auipc	a3,0x7
ffffffffc02060b2:	7a268693          	addi	a3,a3,1954 # ffffffffc020d850 <CSWTCH.79+0x108>
ffffffffc02060b6:	00006617          	auipc	a2,0x6
ffffffffc02060ba:	c4a60613          	addi	a2,a2,-950 # ffffffffc020bd00 <commands+0x210>
ffffffffc02060be:	1d000593          	li	a1,464
ffffffffc02060c2:	00007517          	auipc	a0,0x7
ffffffffc02060c6:	77650513          	addi	a0,a0,1910 # ffffffffc020d838 <CSWTCH.79+0xf0>
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
ffffffffc02060e6:	734050ef          	jal	ra,ffffffffc020b81a <memset>
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
ffffffffc02061f6:	3fe010ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
ffffffffc02061fa:	b7f9                	j	ffffffffc02061c8 <do_exit+0xaa>
ffffffffc02061fc:	020a1263          	bnez	s4,ffffffffc0206220 <do_exit+0x102>
ffffffffc0206200:	4a6010ef          	jal	ra,ffffffffc02076a6 <schedule>
ffffffffc0206204:	601c                	ld	a5,0(s0)
ffffffffc0206206:	00007617          	auipc	a2,0x7
ffffffffc020620a:	68260613          	addi	a2,a2,1666 # ffffffffc020d888 <CSWTCH.79+0x140>
ffffffffc020620e:	28400593          	li	a1,644
ffffffffc0206212:	43d4                	lw	a3,4(a5)
ffffffffc0206214:	00007517          	auipc	a0,0x7
ffffffffc0206218:	62450513          	addi	a0,a0,1572 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020621c:	a82fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206220:	a4dfa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206224:	bff1                	j	ffffffffc0206200 <do_exit+0xe2>
ffffffffc0206226:	876ff0ef          	jal	ra,ffffffffc020529c <files_destroy>
ffffffffc020622a:	b7a5                	j	ffffffffc0206192 <do_exit+0x74>
ffffffffc020622c:	00007617          	auipc	a2,0x7
ffffffffc0206230:	63c60613          	addi	a2,a2,1596 # ffffffffc020d868 <CSWTCH.79+0x120>
ffffffffc0206234:	24f00593          	li	a1,591
ffffffffc0206238:	00007517          	auipc	a0,0x7
ffffffffc020623c:	60050513          	addi	a0,a0,1536 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0206240:	a5efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206244:	854e                	mv	a0,s3
ffffffffc0206246:	d41fd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc020624a:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc020624e:	91bff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc0206252:	854e                	mv	a0,s3
ffffffffc0206254:	b97fd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206258:	b715                	j	ffffffffc020617c <do_exit+0x5e>
ffffffffc020625a:	00007617          	auipc	a2,0x7
ffffffffc020625e:	61e60613          	addi	a2,a2,1566 # ffffffffc020d878 <CSWTCH.79+0x130>
ffffffffc0206262:	25300593          	li	a1,595
ffffffffc0206266:	00007517          	auipc	a0,0x7
ffffffffc020626a:	5d250513          	addi	a0,a0,1490 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020626e:	a30fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206272:	a01fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206276:	4a05                	li	s4,1
ffffffffc0206278:	b73d                	j	ffffffffc02061a6 <do_exit+0x88>
ffffffffc020627a:	37a010ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
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
ffffffffc02062bc:	02a050ef          	jal	ra,ffffffffc020b2e6 <hash32>
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
ffffffffc020631a:	38c010ef          	jal	ra,ffffffffc02076a6 <schedule>
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
ffffffffc02063ce:	64e53503          	ld	a0,1614(a0) # ffffffffc020fa18 <nbase>
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
ffffffffc020640e:	4f660613          	addi	a2,a2,1270 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc0206412:	07700593          	li	a1,119
ffffffffc0206416:	00006517          	auipc	a0,0x6
ffffffffc020641a:	46a50513          	addi	a0,a0,1130 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc020641e:	880fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206422:	00007617          	auipc	a2,0x7
ffffffffc0206426:	48660613          	addi	a2,a2,1158 # ffffffffc020d8a8 <CSWTCH.79+0x160>
ffffffffc020642a:	49100593          	li	a1,1169
ffffffffc020642e:	00007517          	auipc	a0,0x7
ffffffffc0206432:	40a50513          	addi	a0,a0,1034 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0206436:	868fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020643a:	00006617          	auipc	a2,0x6
ffffffffc020643e:	4ee60613          	addi	a2,a2,1262 # ffffffffc020c928 <default_pmm_manager+0x108>
ffffffffc0206442:	06900593          	li	a1,105
ffffffffc0206446:	00006517          	auipc	a0,0x6
ffffffffc020644a:	43a50513          	addi	a0,a0,1082 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc020644e:	850fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206452 <init_main>:
ffffffffc0206452:	1141                	addi	sp,sp,-16
ffffffffc0206454:	00007517          	auipc	a0,0x7
ffffffffc0206458:	47450513          	addi	a0,a0,1140 # ffffffffc020d8c8 <CSWTCH.79+0x180>
ffffffffc020645c:	e406                	sd	ra,8(sp)
ffffffffc020645e:	1b9010ef          	jal	ra,ffffffffc0207e16 <vfs_set_bootfs>
ffffffffc0206462:	e179                	bnez	a0,ffffffffc0206528 <init_main+0xd6>
ffffffffc0206464:	e1bfb0ef          	jal	ra,ffffffffc020227e <nr_free_pages>
ffffffffc0206468:	bb7fb0ef          	jal	ra,ffffffffc020201e <kallocated>
ffffffffc020646c:	4601                	li	a2,0
ffffffffc020646e:	4581                	li	a1,0
ffffffffc0206470:	00001517          	auipc	a0,0x1
ffffffffc0206474:	bde50513          	addi	a0,a0,-1058 # ffffffffc020704e <user_main>
ffffffffc0206478:	c57ff0ef          	jal	ra,ffffffffc02060ce <kernel_thread>
ffffffffc020647c:	00a04563          	bgtz	a0,ffffffffc0206486 <init_main+0x34>
ffffffffc0206480:	a841                	j	ffffffffc0206510 <init_main+0xbe>
ffffffffc0206482:	224010ef          	jal	ra,ffffffffc02076a6 <schedule>
ffffffffc0206486:	4581                	li	a1,0
ffffffffc0206488:	4501                	li	a0,0
ffffffffc020648a:	df7ff0ef          	jal	ra,ffffffffc0206280 <do_wait.part.0>
ffffffffc020648e:	d975                	beqz	a0,ffffffffc0206482 <init_main+0x30>
ffffffffc0206490:	dc7fe0ef          	jal	ra,ffffffffc0205256 <fs_cleanup>
ffffffffc0206494:	00007517          	auipc	a0,0x7
ffffffffc0206498:	47c50513          	addi	a0,a0,1148 # ffffffffc020d910 <CSWTCH.79+0x1c8>
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
ffffffffc02064e0:	51c50513          	addi	a0,a0,1308 # ffffffffc020d9f8 <CSWTCH.79+0x2b0>
ffffffffc02064e4:	cc3f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02064e8:	60a2                	ld	ra,8(sp)
ffffffffc02064ea:	4501                	li	a0,0
ffffffffc02064ec:	0141                	addi	sp,sp,16
ffffffffc02064ee:	8082                	ret
ffffffffc02064f0:	00007697          	auipc	a3,0x7
ffffffffc02064f4:	44868693          	addi	a3,a3,1096 # ffffffffc020d938 <CSWTCH.79+0x1f0>
ffffffffc02064f8:	00006617          	auipc	a2,0x6
ffffffffc02064fc:	80860613          	addi	a2,a2,-2040 # ffffffffc020bd00 <commands+0x210>
ffffffffc0206500:	50700593          	li	a1,1287
ffffffffc0206504:	00007517          	auipc	a0,0x7
ffffffffc0206508:	33450513          	addi	a0,a0,820 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020650c:	f93f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206510:	00007617          	auipc	a2,0x7
ffffffffc0206514:	3e060613          	addi	a2,a2,992 # ffffffffc020d8f0 <CSWTCH.79+0x1a8>
ffffffffc0206518:	4fa00593          	li	a1,1274
ffffffffc020651c:	00007517          	auipc	a0,0x7
ffffffffc0206520:	31c50513          	addi	a0,a0,796 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0206524:	f7bf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206528:	86aa                	mv	a3,a0
ffffffffc020652a:	00007617          	auipc	a2,0x7
ffffffffc020652e:	3a660613          	addi	a2,a2,934 # ffffffffc020d8d0 <CSWTCH.79+0x188>
ffffffffc0206532:	4f200593          	li	a1,1266
ffffffffc0206536:	00007517          	auipc	a0,0x7
ffffffffc020653a:	30250513          	addi	a0,a0,770 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020653e:	f61f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206542:	00007697          	auipc	a3,0x7
ffffffffc0206546:	48668693          	addi	a3,a3,1158 # ffffffffc020d9c8 <CSWTCH.79+0x280>
ffffffffc020654a:	00005617          	auipc	a2,0x5
ffffffffc020654e:	7b660613          	addi	a2,a2,1974 # ffffffffc020bd00 <commands+0x210>
ffffffffc0206552:	50a00593          	li	a1,1290
ffffffffc0206556:	00007517          	auipc	a0,0x7
ffffffffc020655a:	2e250513          	addi	a0,a0,738 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020655e:	f41f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206562:	00007697          	auipc	a3,0x7
ffffffffc0206566:	43668693          	addi	a3,a3,1078 # ffffffffc020d998 <CSWTCH.79+0x250>
ffffffffc020656a:	00005617          	auipc	a2,0x5
ffffffffc020656e:	79660613          	addi	a2,a2,1942 # ffffffffc020bd00 <commands+0x210>
ffffffffc0206572:	50900593          	li	a1,1289
ffffffffc0206576:	00007517          	auipc	a0,0x7
ffffffffc020657a:	2c250513          	addi	a0,a0,706 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020657e:	f21f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206582:	00007697          	auipc	a3,0x7
ffffffffc0206586:	40668693          	addi	a3,a3,1030 # ffffffffc020d988 <CSWTCH.79+0x240>
ffffffffc020658a:	00005617          	auipc	a2,0x5
ffffffffc020658e:	77660613          	addi	a2,a2,1910 # ffffffffc020bd00 <commands+0x210>
ffffffffc0206592:	50800593          	li	a1,1288
ffffffffc0206596:	00007517          	auipc	a0,0x7
ffffffffc020659a:	2a250513          	addi	a0,a0,674 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020659e:	f01f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02065a2 <do_execve>:
ffffffffc02065a2:	ca010113          	addi	sp,sp,-864
ffffffffc02065a6:	33513423          	sd	s5,808(sp)
ffffffffc02065aa:	00090a97          	auipc	s5,0x90
ffffffffc02065ae:	316a8a93          	addi	s5,s5,790 # ffffffffc02968c0 <current>
ffffffffc02065b2:	000ab683          	ld	a3,0(s5)
ffffffffc02065b6:	35213023          	sd	s2,832(sp)
ffffffffc02065ba:	fff5891b          	addiw	s2,a1,-1
ffffffffc02065be:	31813823          	sd	s8,784(sp)
ffffffffc02065c2:	34113c23          	sd	ra,856(sp)
ffffffffc02065c6:	34813823          	sd	s0,848(sp)
ffffffffc02065ca:	34913423          	sd	s1,840(sp)
ffffffffc02065ce:	33313c23          	sd	s3,824(sp)
ffffffffc02065d2:	33413823          	sd	s4,816(sp)
ffffffffc02065d6:	33613023          	sd	s6,800(sp)
ffffffffc02065da:	31713c23          	sd	s7,792(sp)
ffffffffc02065de:	31913423          	sd	s9,776(sp)
ffffffffc02065e2:	31a13023          	sd	s10,768(sp)
ffffffffc02065e6:	2fb13c23          	sd	s11,760(sp)
ffffffffc02065ea:	0009071b          	sext.w	a4,s2
ffffffffc02065ee:	47fd                	li	a5,31
ffffffffc02065f0:	0286bc03          	ld	s8,40(a3)
ffffffffc02065f4:	5ae7e663          	bltu	a5,a4,ffffffffc0206ba0 <do_execve+0x5fe>
ffffffffc02065f8:	842e                	mv	s0,a1
ffffffffc02065fa:	84aa                	mv	s1,a0
ffffffffc02065fc:	8cb2                	mv	s9,a2
ffffffffc02065fe:	4581                	li	a1,0
ffffffffc0206600:	4641                	li	a2,16
ffffffffc0206602:	10a8                	addi	a0,sp,104
ffffffffc0206604:	216050ef          	jal	ra,ffffffffc020b81a <memset>
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
ffffffffc0206628:	10ac                	addi	a1,sp,104
ffffffffc020662a:	8562                	mv	a0,s8
ffffffffc020662c:	df5fd0ef          	jal	ra,ffffffffc0204420 <copy_string>
ffffffffc0206630:	58050063          	beqz	a0,ffffffffc0206bb0 <do_execve+0x60e>
ffffffffc0206634:	00341b13          	slli	s6,s0,0x3
ffffffffc0206638:	4681                	li	a3,0
ffffffffc020663a:	865a                	mv	a2,s6
ffffffffc020663c:	85e6                	mv	a1,s9
ffffffffc020663e:	8562                	mv	a0,s8
ffffffffc0206640:	ce7fd0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc0206644:	8a66                	mv	s4,s9
ffffffffc0206646:	56050163          	beqz	a0,ffffffffc0206ba8 <do_execve+0x606>
ffffffffc020664a:	0f010b93          	addi	s7,sp,240
ffffffffc020664e:	4481                	li	s1,0
ffffffffc0206650:	a011                	j	ffffffffc0206654 <do_execve+0xb2>
ffffffffc0206652:	84ea                	mv	s1,s10
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
ffffffffc0206676:	00148d1b          	addiw	s10,s1,1
ffffffffc020667a:	0ba1                	addi	s7,s7,8
ffffffffc020667c:	0a21                	addi	s4,s4,8
ffffffffc020667e:	fda41ae3          	bne	s0,s10,ffffffffc0206652 <do_execve+0xb0>
ffffffffc0206682:	000cb983          	ld	s3,0(s9)
ffffffffc0206686:	100c0763          	beqz	s8,ffffffffc0206794 <do_execve+0x1f2>
ffffffffc020668a:	038c0513          	addi	a0,s8,56
ffffffffc020668e:	f6bfd0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0206692:	000ab703          	ld	a4,0(s5)
ffffffffc0206696:	040c2823          	sw	zero,80(s8)
ffffffffc020669a:	14873503          	ld	a0,328(a4)
ffffffffc020669e:	c95fe0ef          	jal	ra,ffffffffc0205332 <files_closeall>
ffffffffc02066a2:	4581                	li	a1,0
ffffffffc02066a4:	854e                	mv	a0,s3
ffffffffc02066a6:	f19fe0ef          	jal	ra,ffffffffc02055be <sysfile_open>
ffffffffc02066aa:	8a2a                	mv	s4,a0
ffffffffc02066ac:	10054163          	bltz	a0,ffffffffc02067ae <do_execve+0x20c>
ffffffffc02066b0:	00090717          	auipc	a4,0x90
ffffffffc02066b4:	1e073703          	ld	a4,480(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02066b8:	56fd                	li	a3,-1
ffffffffc02066ba:	16fe                	slli	a3,a3,0x3f
ffffffffc02066bc:	8331                	srli	a4,a4,0xc
ffffffffc02066be:	8f55                	or	a4,a4,a3
ffffffffc02066c0:	18071073          	csrw	satp,a4
ffffffffc02066c4:	030c2703          	lw	a4,48(s8)
ffffffffc02066c8:	fff7069b          	addiw	a3,a4,-1
ffffffffc02066cc:	02dc2823          	sw	a3,48(s8)
ffffffffc02066d0:	18068763          	beqz	a3,ffffffffc020685e <do_execve+0x2bc>
ffffffffc02066d4:	000ab703          	ld	a4,0(s5)
ffffffffc02066d8:	02073423          	sd	zero,40(a4)
ffffffffc02066dc:	4601                	li	a2,0
ffffffffc02066de:	4581                	li	a1,0
ffffffffc02066e0:	8552                	mv	a0,s4
ffffffffc02066e2:	942ff0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc02066e6:	89aa                	mv	s3,a0
ffffffffc02066e8:	0e051f63          	bnez	a0,ffffffffc02067e6 <do_execve+0x244>
ffffffffc02066ec:	04000613          	li	a2,64
ffffffffc02066f0:	190c                	addi	a1,sp,176
ffffffffc02066f2:	8552                	mv	a0,s4
ffffffffc02066f4:	f03fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc02066f8:	04000713          	li	a4,64
ffffffffc02066fc:	8baa                	mv	s7,a0
ffffffffc02066fe:	0ce51f63          	bne	a0,a4,ffffffffc02067dc <do_execve+0x23a>
ffffffffc0206702:	56ca                	lw	a3,176(sp)
ffffffffc0206704:	464c4737          	lui	a4,0x464c4
ffffffffc0206708:	57f70713          	addi	a4,a4,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc020670c:	16e68463          	beq	a3,a4,ffffffffc0206874 <do_execve+0x2d2>
ffffffffc0206710:	8552                	mv	a0,s4
ffffffffc0206712:	1902                	slli	s2,s2,0x20
ffffffffc0206714:	edffe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc0206718:	0e010c93          	addi	s9,sp,224
ffffffffc020671c:	02095913          	srli	s2,s2,0x20
ffffffffc0206720:	147d                	addi	s0,s0,-1
ffffffffc0206722:	040e                	slli	s0,s0,0x3
ffffffffc0206724:	9b66                	add	s6,s6,s9
ffffffffc0206726:	090e                	slli	s2,s2,0x3
ffffffffc0206728:	199c                	addi	a5,sp,240
ffffffffc020672a:	943e                	add	s0,s0,a5
ffffffffc020672c:	412b0b33          	sub	s6,s6,s2
ffffffffc0206730:	6008                	ld	a0,0(s0)
ffffffffc0206732:	1461                	addi	s0,s0,-8
ffffffffc0206734:	99ffb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206738:	fe8b1ce3          	bne	s6,s0,ffffffffc0206730 <do_execve+0x18e>
ffffffffc020673c:	000ab403          	ld	s0,0(s5)
ffffffffc0206740:	4641                	li	a2,16
ffffffffc0206742:	4581                	li	a1,0
ffffffffc0206744:	0b440413          	addi	s0,s0,180
ffffffffc0206748:	8522                	mv	a0,s0
ffffffffc020674a:	0d0050ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc020674e:	463d                	li	a2,15
ffffffffc0206750:	10ac                	addi	a1,sp,104
ffffffffc0206752:	8522                	mv	a0,s0
ffffffffc0206754:	118050ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc0206758:	35813083          	ld	ra,856(sp)
ffffffffc020675c:	35013403          	ld	s0,848(sp)
ffffffffc0206760:	34813483          	ld	s1,840(sp)
ffffffffc0206764:	34013903          	ld	s2,832(sp)
ffffffffc0206768:	33013a03          	ld	s4,816(sp)
ffffffffc020676c:	32813a83          	ld	s5,808(sp)
ffffffffc0206770:	32013b03          	ld	s6,800(sp)
ffffffffc0206774:	31813b83          	ld	s7,792(sp)
ffffffffc0206778:	31013c03          	ld	s8,784(sp)
ffffffffc020677c:	30813c83          	ld	s9,776(sp)
ffffffffc0206780:	30013d03          	ld	s10,768(sp)
ffffffffc0206784:	2f813d83          	ld	s11,760(sp)
ffffffffc0206788:	854e                	mv	a0,s3
ffffffffc020678a:	33813983          	ld	s3,824(sp)
ffffffffc020678e:	36010113          	addi	sp,sp,864
ffffffffc0206792:	8082                	ret
ffffffffc0206794:	000ab703          	ld	a4,0(s5)
ffffffffc0206798:	14873503          	ld	a0,328(a4)
ffffffffc020679c:	b97fe0ef          	jal	ra,ffffffffc0205332 <files_closeall>
ffffffffc02067a0:	4581                	li	a1,0
ffffffffc02067a2:	854e                	mv	a0,s3
ffffffffc02067a4:	e1bfe0ef          	jal	ra,ffffffffc02055be <sysfile_open>
ffffffffc02067a8:	8a2a                	mv	s4,a0
ffffffffc02067aa:	f20559e3          	bgez	a0,ffffffffc02066dc <do_execve+0x13a>
ffffffffc02067ae:	1902                	slli	s2,s2,0x20
ffffffffc02067b0:	0e010c93          	addi	s9,sp,224
ffffffffc02067b4:	02095913          	srli	s2,s2,0x20
ffffffffc02067b8:	147d                	addi	s0,s0,-1
ffffffffc02067ba:	040e                	slli	s0,s0,0x3
ffffffffc02067bc:	016c8733          	add	a4,s9,s6
ffffffffc02067c0:	090e                	slli	s2,s2,0x3
ffffffffc02067c2:	199c                	addi	a5,sp,240
ffffffffc02067c4:	943e                	add	s0,s0,a5
ffffffffc02067c6:	41270933          	sub	s2,a4,s2
ffffffffc02067ca:	6008                	ld	a0,0(s0)
ffffffffc02067cc:	1461                	addi	s0,s0,-8
ffffffffc02067ce:	905fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02067d2:	fe891ce3          	bne	s2,s0,ffffffffc02067ca <do_execve+0x228>
ffffffffc02067d6:	8552                	mv	a0,s4
ffffffffc02067d8:	947ff0ef          	jal	ra,ffffffffc020611e <do_exit>
ffffffffc02067dc:	0005099b          	sext.w	s3,a0
ffffffffc02067e0:	00054363          	bltz	a0,ffffffffc02067e6 <do_execve+0x244>
ffffffffc02067e4:	59fd                	li	s3,-1
ffffffffc02067e6:	1902                	slli	s2,s2,0x20
ffffffffc02067e8:	0e010c93          	addi	s9,sp,224
ffffffffc02067ec:	02095913          	srli	s2,s2,0x20
ffffffffc02067f0:	8552                	mv	a0,s4
ffffffffc02067f2:	e01fe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc02067f6:	8a4e                	mv	s4,s3
ffffffffc02067f8:	b7c1                	j	ffffffffc02067b8 <do_execve+0x216>
ffffffffc02067fa:	59f1                	li	s3,-4
ffffffffc02067fc:	c49d                	beqz	s1,ffffffffc020682a <do_execve+0x288>
ffffffffc02067fe:	00349713          	slli	a4,s1,0x3
ffffffffc0206802:	fff48413          	addi	s0,s1,-1
ffffffffc0206806:	119c                	addi	a5,sp,224
ffffffffc0206808:	34fd                	addiw	s1,s1,-1
ffffffffc020680a:	97ba                	add	a5,a5,a4
ffffffffc020680c:	02049713          	slli	a4,s1,0x20
ffffffffc0206810:	01d75493          	srli	s1,a4,0x1d
ffffffffc0206814:	040e                	slli	s0,s0,0x3
ffffffffc0206816:	1998                	addi	a4,sp,240
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
ffffffffc0206842:	59f5                	li	s3,-3
ffffffffc0206844:	bf65                	j	ffffffffc02067fc <do_execve+0x25a>
ffffffffc0206846:	000ab783          	ld	a5,0(s5)
ffffffffc020684a:	00007617          	auipc	a2,0x7
ffffffffc020684e:	1ce60613          	addi	a2,a2,462 # ffffffffc020da18 <CSWTCH.79+0x2d0>
ffffffffc0206852:	45c1                	li	a1,16
ffffffffc0206854:	43d4                	lw	a3,4(a5)
ffffffffc0206856:	10a8                	addi	a0,sp,104
ffffffffc0206858:	6d3040ef          	jal	ra,ffffffffc020b72a <snprintf>
ffffffffc020685c:	bbe1                	j	ffffffffc0206634 <do_execve+0x92>
ffffffffc020685e:	8562                	mv	a0,s8
ffffffffc0206860:	f26fd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc0206864:	018c3503          	ld	a0,24(s8)
ffffffffc0206868:	b00ff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc020686c:	8562                	mv	a0,s8
ffffffffc020686e:	d7cfd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206872:	b58d                	j	ffffffffc02066d4 <do_execve+0x132>
ffffffffc0206874:	c28fd0ef          	jal	ra,ffffffffc0203c9c <mm_create>
ffffffffc0206878:	e82a                	sd	a0,16(sp)
ffffffffc020687a:	30050263          	beqz	a0,ffffffffc0206b7e <do_execve+0x5dc>
ffffffffc020687e:	4505                	li	a0,1
ffffffffc0206880:	981fb0ef          	jal	ra,ffffffffc0202200 <alloc_pages>
ffffffffc0206884:	2e050a63          	beqz	a0,ffffffffc0206b78 <do_execve+0x5d6>
ffffffffc0206888:	00090797          	auipc	a5,0x90
ffffffffc020688c:	02078793          	addi	a5,a5,32 # ffffffffc02968a8 <pages>
ffffffffc0206890:	6398                	ld	a4,0(a5)
ffffffffc0206892:	00090d97          	auipc	s11,0x90
ffffffffc0206896:	00ed8d93          	addi	s11,s11,14 # ffffffffc02968a0 <npage>
ffffffffc020689a:	00009797          	auipc	a5,0x9
ffffffffc020689e:	17e7b783          	ld	a5,382(a5) # ffffffffc020fa18 <nbase>
ffffffffc02068a2:	40e50733          	sub	a4,a0,a4
ffffffffc02068a6:	8719                	srai	a4,a4,0x6
ffffffffc02068a8:	973e                	add	a4,a4,a5
ffffffffc02068aa:	000db583          	ld	a1,0(s11)
ffffffffc02068ae:	00c71613          	slli	a2,a4,0xc
ffffffffc02068b2:	f43e                	sd	a5,40(sp)
ffffffffc02068b4:	8231                	srli	a2,a2,0xc
ffffffffc02068b6:	00c71693          	slli	a3,a4,0xc
ffffffffc02068ba:	6cb67163          	bgeu	a2,a1,ffffffffc0206f7c <do_execve+0x9da>
ffffffffc02068be:	00090797          	auipc	a5,0x90
ffffffffc02068c2:	ffa78793          	addi	a5,a5,-6 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02068c6:	0007bc03          	ld	s8,0(a5)
ffffffffc02068ca:	6605                	lui	a2,0x1
ffffffffc02068cc:	00090597          	auipc	a1,0x90
ffffffffc02068d0:	fcc5b583          	ld	a1,-52(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc02068d4:	9c36                	add	s8,s8,a3
ffffffffc02068d6:	8562                	mv	a0,s8
ffffffffc02068d8:	795040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc02068dc:	67ee                	ld	a5,216(sp)
ffffffffc02068de:	6742                	ld	a4,16(sp)
ffffffffc02068e0:	f83e                	sd	a5,48(sp)
ffffffffc02068e2:	01873c23          	sd	s8,24(a4)
ffffffffc02068e6:	22079763          	bnez	a5,ffffffffc0206b14 <do_execve+0x572>
ffffffffc02068ea:	0e815703          	lhu	a4,232(sp)
ffffffffc02068ee:	4681                	li	a3,0
ffffffffc02068f0:	4c81                	li	s9,0
ffffffffc02068f2:	cb41                	beqz	a4,ffffffffc0206982 <do_execve+0x3e0>
ffffffffc02068f4:	577d                	li	a4,-1
ffffffffc02068f6:	7c22                	ld	s8,40(sp)
ffffffffc02068f8:	00c75793          	srli	a5,a4,0xc
ffffffffc02068fc:	e4ea                	sd	s10,72(sp)
ffffffffc02068fe:	e43e                	sd	a5,8(sp)
ffffffffc0206900:	8d36                	mv	s10,a3
ffffffffc0206902:	e8a6                	sd	s1,80(sp)
ffffffffc0206904:	ecce                	sd	s3,88(sp)
ffffffffc0206906:	ec22                	sd	s0,24(sp)
ffffffffc0206908:	d04a                	sw	s2,32(sp)
ffffffffc020690a:	65ce                	ld	a1,208(sp)
ffffffffc020690c:	4601                	li	a2,0
ffffffffc020690e:	8552                	mv	a0,s4
ffffffffc0206910:	95e6                	add	a1,a1,s9
ffffffffc0206912:	f13fe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206916:	0e051d63          	bnez	a0,ffffffffc0206a10 <do_execve+0x46e>
ffffffffc020691a:	03800613          	li	a2,56
ffffffffc020691e:	18ac                	addi	a1,sp,120
ffffffffc0206920:	8552                	mv	a0,s4
ffffffffc0206922:	cd5fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206926:	03800793          	li	a5,56
ffffffffc020692a:	02f50c63          	beq	a0,a5,ffffffffc0206962 <do_execve+0x3c0>
ffffffffc020692e:	6462                	ld	s0,24(sp)
ffffffffc0206930:	5902                	lw	s2,32(sp)
ffffffffc0206932:	0005089b          	sext.w	a7,a0
ffffffffc0206936:	00054363          	bltz	a0,ffffffffc020693c <do_execve+0x39a>
ffffffffc020693a:	58fd                	li	a7,-1
ffffffffc020693c:	1902                	slli	s2,s2,0x20
ffffffffc020693e:	0e010c93          	addi	s9,sp,224
ffffffffc0206942:	02095913          	srli	s2,s2,0x20
ffffffffc0206946:	64c2                	ld	s1,16(sp)
ffffffffc0206948:	e446                	sd	a7,8(sp)
ffffffffc020694a:	8526                	mv	a0,s1
ffffffffc020694c:	e3afd0ef          	jal	ra,ffffffffc0203f86 <exit_mmap>
ffffffffc0206950:	68a2                	ld	a7,8(sp)
ffffffffc0206952:	6c88                	ld	a0,24(s1)
ffffffffc0206954:	89c6                	mv	s3,a7
ffffffffc0206956:	a12ff0ef          	jal	ra,ffffffffc0205b68 <put_pgdir.isra.0>
ffffffffc020695a:	6542                	ld	a0,16(sp)
ffffffffc020695c:	c8efd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206960:	bd41                	j	ffffffffc02067f0 <do_execve+0x24e>
ffffffffc0206962:	57e6                	lw	a5,120(sp)
ffffffffc0206964:	4705                	li	a4,1
ffffffffc0206966:	0ae78e63          	beq	a5,a4,ffffffffc0206a22 <do_execve+0x480>
ffffffffc020696a:	0e815783          	lhu	a5,232(sp)
ffffffffc020696e:	2d05                	addiw	s10,s10,1
ffffffffc0206970:	038c8c93          	addi	s9,s9,56
ffffffffc0206974:	f8fd4be3          	blt	s10,a5,ffffffffc020690a <do_execve+0x368>
ffffffffc0206978:	6d26                	ld	s10,72(sp)
ffffffffc020697a:	64c6                	ld	s1,80(sp)
ffffffffc020697c:	69e6                	ld	s3,88(sp)
ffffffffc020697e:	6462                	ld	s0,24(sp)
ffffffffc0206980:	5902                	lw	s2,32(sp)
ffffffffc0206982:	6542                	ld	a0,16(sp)
ffffffffc0206984:	4701                	li	a4,0
ffffffffc0206986:	46ad                	li	a3,11
ffffffffc0206988:	00100637          	lui	a2,0x100
ffffffffc020698c:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0206990:	cacfd0ef          	jal	ra,ffffffffc0203e3c <mm_map>
ffffffffc0206994:	88aa                	mv	a7,a0
ffffffffc0206996:	f15d                	bnez	a0,ffffffffc020693c <do_execve+0x39a>
ffffffffc0206998:	7ff00bb7          	lui	s7,0x7ff00
ffffffffc020699c:	57fd                	li	a5,-1
ffffffffc020699e:	4c05                	li	s8,1
ffffffffc02069a0:	f026                	sd	s1,32(sp)
ffffffffc02069a2:	e422                	sd	s0,8(sp)
ffffffffc02069a4:	84de                	mv	s1,s7
ffffffffc02069a6:	6442                	ld	s0,16(sp)
ffffffffc02069a8:	8bca                	mv	s7,s2
ffffffffc02069aa:	00c7dc93          	srli	s9,a5,0xc
ffffffffc02069ae:	7922                	ld	s2,40(sp)
ffffffffc02069b0:	0c7e                	slli	s8,s8,0x1f
ffffffffc02069b2:	ec2a                	sd	a0,24(sp)
ffffffffc02069b4:	a83d                	j	ffffffffc02069f2 <do_execve+0x450>
ffffffffc02069b6:	00090797          	auipc	a5,0x90
ffffffffc02069ba:	ef278793          	addi	a5,a5,-270 # ffffffffc02968a8 <pages>
ffffffffc02069be:	639c                	ld	a5,0(a5)
ffffffffc02069c0:	000db603          	ld	a2,0(s11)
ffffffffc02069c4:	40f507b3          	sub	a5,a0,a5
ffffffffc02069c8:	8799                	srai	a5,a5,0x6
ffffffffc02069ca:	97ca                	add	a5,a5,s2
ffffffffc02069cc:	0197f5b3          	and	a1,a5,s9
ffffffffc02069d0:	07b2                	slli	a5,a5,0xc
ffffffffc02069d2:	5cc5f163          	bgeu	a1,a2,ffffffffc0206f94 <do_execve+0x9f2>
ffffffffc02069d6:	00090717          	auipc	a4,0x90
ffffffffc02069da:	ee270713          	addi	a4,a4,-286 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02069de:	6308                	ld	a0,0(a4)
ffffffffc02069e0:	6605                	lui	a2,0x1
ffffffffc02069e2:	4581                	li	a1,0
ffffffffc02069e4:	953e                	add	a0,a0,a5
ffffffffc02069e6:	635040ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc02069ea:	6685                	lui	a3,0x1
ffffffffc02069ec:	94b6                	add	s1,s1,a3
ffffffffc02069ee:	1d848f63          	beq	s1,s8,ffffffffc0206bcc <do_execve+0x62a>
ffffffffc02069f2:	6c08                	ld	a0,24(s0)
ffffffffc02069f4:	4659                	li	a2,22
ffffffffc02069f6:	85a6                	mv	a1,s1
ffffffffc02069f8:	9befd0ef          	jal	ra,ffffffffc0203bb6 <pgdir_alloc_page>
ffffffffc02069fc:	fd4d                	bnez	a0,ffffffffc02069b6 <do_execve+0x414>
ffffffffc02069fe:	895e                	mv	s2,s7
ffffffffc0206a00:	1902                	slli	s2,s2,0x20
ffffffffc0206a02:	6422                	ld	s0,8(sp)
ffffffffc0206a04:	0e010c93          	addi	s9,sp,224
ffffffffc0206a08:	02095913          	srli	s2,s2,0x20
ffffffffc0206a0c:	58f1                	li	a7,-4
ffffffffc0206a0e:	bf25                	j	ffffffffc0206946 <do_execve+0x3a4>
ffffffffc0206a10:	5902                	lw	s2,32(sp)
ffffffffc0206a12:	6462                	ld	s0,24(sp)
ffffffffc0206a14:	88aa                	mv	a7,a0
ffffffffc0206a16:	1902                	slli	s2,s2,0x20
ffffffffc0206a18:	0e010c93          	addi	s9,sp,224
ffffffffc0206a1c:	02095913          	srli	s2,s2,0x20
ffffffffc0206a20:	b71d                	j	ffffffffc0206946 <do_execve+0x3a4>
ffffffffc0206a22:	760a                	ld	a2,160(sp)
ffffffffc0206a24:	67ea                	ld	a5,152(sp)
ffffffffc0206a26:	18f66f63          	bltu	a2,a5,ffffffffc0206bc4 <do_execve+0x622>
ffffffffc0206a2a:	65aa                	ld	a1,136(sp)
ffffffffc0206a2c:	002007b7          	lui	a5,0x200
ffffffffc0206a30:	18f5ea63          	bltu	a1,a5,ffffffffc0206bc4 <do_execve+0x622>
ffffffffc0206a34:	00b607b3          	add	a5,a2,a1
ffffffffc0206a38:	18f5f663          	bgeu	a1,a5,ffffffffc0206bc4 <do_execve+0x622>
ffffffffc0206a3c:	4705                	li	a4,1
ffffffffc0206a3e:	077e                	slli	a4,a4,0x1f
ffffffffc0206a40:	18f76263          	bltu	a4,a5,ffffffffc0206bc4 <do_execve+0x622>
ffffffffc0206a44:	57f6                	lw	a5,124(sp)
ffffffffc0206a46:	49c1                	li	s3,16
ffffffffc0206a48:	0017f693          	andi	a3,a5,1
ffffffffc0206a4c:	c299                	beqz	a3,ffffffffc0206a52 <do_execve+0x4b0>
ffffffffc0206a4e:	49e9                	li	s3,26
ffffffffc0206a50:	4691                	li	a3,4
ffffffffc0206a52:	0027f713          	andi	a4,a5,2
ffffffffc0206a56:	c709                	beqz	a4,ffffffffc0206a60 <do_execve+0x4be>
ffffffffc0206a58:	0026e693          	ori	a3,a3,2
ffffffffc0206a5c:	0069e993          	ori	s3,s3,6
ffffffffc0206a60:	8b91                	andi	a5,a5,4
ffffffffc0206a62:	0e079a63          	bnez	a5,ffffffffc0206b56 <do_execve+0x5b4>
ffffffffc0206a66:	6542                	ld	a0,16(sp)
ffffffffc0206a68:	4701                	li	a4,0
ffffffffc0206a6a:	bd2fd0ef          	jal	ra,ffffffffc0203e3c <mm_map>
ffffffffc0206a6e:	f14d                	bnez	a0,ffffffffc0206a10 <do_execve+0x46e>
ffffffffc0206a70:	642a                	ld	s0,136(sp)
ffffffffc0206a72:	7b8a                	ld	s7,160(sp)
ffffffffc0206a74:	64ea                	ld	s1,152(sp)
ffffffffc0206a76:	9ba2                	add	s7,s7,s0
ffffffffc0206a78:	94a2                	add	s1,s1,s0
ffffffffc0206a7a:	ef7478e3          	bgeu	s0,s7,ffffffffc020696a <do_execve+0x3c8>
ffffffffc0206a7e:	fc66                	sd	s9,56(sp)
ffffffffc0206a80:	6942                	ld	s2,16(sp)
ffffffffc0206a82:	8ca2                	mv	s9,s0
ffffffffc0206a84:	e0ea                	sd	s10,64(sp)
ffffffffc0206a86:	a029                	j	ffffffffc0206a90 <do_execve+0x4ee>
ffffffffc0206a88:	6785                	lui	a5,0x1
ffffffffc0206a8a:	9cbe                	add	s9,s9,a5
ffffffffc0206a8c:	117cf763          	bgeu	s9,s7,ffffffffc0206b9a <do_execve+0x5f8>
ffffffffc0206a90:	01893503          	ld	a0,24(s2) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc0206a94:	864e                	mv	a2,s3
ffffffffc0206a96:	85e6                	mv	a1,s9
ffffffffc0206a98:	91efd0ef          	jal	ra,ffffffffc0203bb6 <pgdir_alloc_page>
ffffffffc0206a9c:	0e050663          	beqz	a0,ffffffffc0206b88 <do_execve+0x5e6>
ffffffffc0206aa0:	00090797          	auipc	a5,0x90
ffffffffc0206aa4:	e0878793          	addi	a5,a5,-504 # ffffffffc02968a8 <pages>
ffffffffc0206aa8:	6394                	ld	a3,0(a5)
ffffffffc0206aaa:	67a2                	ld	a5,8(sp)
ffffffffc0206aac:	000db703          	ld	a4,0(s11)
ffffffffc0206ab0:	8d15                	sub	a0,a0,a3
ffffffffc0206ab2:	8519                	srai	a0,a0,0x6
ffffffffc0206ab4:	9562                	add	a0,a0,s8
ffffffffc0206ab6:	00f576b3          	and	a3,a0,a5
ffffffffc0206aba:	0532                	slli	a0,a0,0xc
ffffffffc0206abc:	4ae6ff63          	bgeu	a3,a4,ffffffffc0206f7a <do_execve+0x9d8>
ffffffffc0206ac0:	00090797          	auipc	a5,0x90
ffffffffc0206ac4:	df878793          	addi	a5,a5,-520 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206ac8:	6380                	ld	s0,0(a5)
ffffffffc0206aca:	6605                	lui	a2,0x1
ffffffffc0206acc:	4581                	li	a1,0
ffffffffc0206ace:	942a                	add	s0,s0,a0
ffffffffc0206ad0:	8522                	mv	a0,s0
ffffffffc0206ad2:	549040ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc0206ad6:	fa9cf9e3          	bgeu	s9,s1,ffffffffc0206a88 <do_execve+0x4e6>
ffffffffc0206ada:	658a                	ld	a1,128(sp)
ffffffffc0206adc:	672a                	ld	a4,136(sp)
ffffffffc0206ade:	4601                	li	a2,0
ffffffffc0206ae0:	8552                	mv	a0,s4
ffffffffc0206ae2:	8d99                	sub	a1,a1,a4
ffffffffc0206ae4:	95e6                	add	a1,a1,s9
ffffffffc0206ae6:	d3ffe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206aea:	f11d                	bnez	a0,ffffffffc0206a10 <do_execve+0x46e>
ffffffffc0206aec:	6785                	lui	a5,0x1
ffffffffc0206aee:	fff78713          	addi	a4,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0206af2:	00ecf5b3          	and	a1,s9,a4
ffffffffc0206af6:	40b78733          	sub	a4,a5,a1
ffffffffc0206afa:	41948d33          	sub	s10,s1,s9
ffffffffc0206afe:	01a77363          	bgeu	a4,s10,ffffffffc0206b04 <do_execve+0x562>
ffffffffc0206b02:	8d3a                	mv	s10,a4
ffffffffc0206b04:	866a                	mv	a2,s10
ffffffffc0206b06:	95a2                	add	a1,a1,s0
ffffffffc0206b08:	8552                	mv	a0,s4
ffffffffc0206b0a:	aedfe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206b0e:	f6ad0de3          	beq	s10,a0,ffffffffc0206a88 <do_execve+0x4e6>
ffffffffc0206b12:	bd31                	j	ffffffffc020692e <do_execve+0x38c>
ffffffffc0206b14:	0ec15c03          	lhu	s8,236(sp)
ffffffffc0206b18:	080c0663          	beqz	s8,ffffffffc0206ba4 <do_execve+0x602>
ffffffffc0206b1c:	0ea15703          	lhu	a4,234(sp)
ffffffffc0206b20:	f802                	sd	zero,48(sp)
ffffffffc0206b22:	dd7714e3          	bne	a4,s7,ffffffffc02068ea <do_execve+0x348>
ffffffffc0206b26:	0c1a                	slli	s8,s8,0x6
ffffffffc0206b28:	8562                	mv	a0,s8
ffffffffc0206b2a:	cf8fb0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0206b2e:	f02a                	sd	a0,32(sp)
ffffffffc0206b30:	c521                	beqz	a0,ffffffffc0206b78 <do_execve+0x5d6>
ffffffffc0206b32:	65ee                	ld	a1,216(sp)
ffffffffc0206b34:	4601                	li	a2,0
ffffffffc0206b36:	8552                	mv	a0,s4
ffffffffc0206b38:	cedfe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206b3c:	8baa                	mv	s7,a0
ffffffffc0206b3e:	2a050d63          	beqz	a0,ffffffffc0206df8 <do_execve+0x856>
ffffffffc0206b42:	7502                	ld	a0,32(sp)
ffffffffc0206b44:	1902                	slli	s2,s2,0x20
ffffffffc0206b46:	89de                	mv	s3,s7
ffffffffc0206b48:	d8afb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206b4c:	0e010c93          	addi	s9,sp,224
ffffffffc0206b50:	02095913          	srli	s2,s2,0x20
ffffffffc0206b54:	b519                	j	ffffffffc020695a <do_execve+0x3b8>
ffffffffc0206b56:	0016e693          	ori	a3,a3,1
ffffffffc0206b5a:	0029e993          	ori	s3,s3,2
ffffffffc0206b5e:	b721                	j	ffffffffc0206a66 <do_execve+0x4c4>
ffffffffc0206b60:	855a                	mv	a0,s6
ffffffffc0206b62:	6462                	ld	s0,24(sp)
ffffffffc0206b64:	6b22                	ld	s6,8(sp)
ffffffffc0206b66:	d6cfb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206b6a:	4501                	li	a0,0
ffffffffc0206b6c:	d66fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206b70:	7502                	ld	a0,32(sp)
ffffffffc0206b72:	8966                	mv	s2,s9
ffffffffc0206b74:	d5efb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206b78:	6542                	ld	a0,16(sp)
ffffffffc0206b7a:	a70fd0ef          	jal	ra,ffffffffc0203dea <mm_destroy>
ffffffffc0206b7e:	8552                	mv	a0,s4
ffffffffc0206b80:	a73fe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc0206b84:	5a71                	li	s4,-4
ffffffffc0206b86:	b125                	j	ffffffffc02067ae <do_execve+0x20c>
ffffffffc0206b88:	5902                	lw	s2,32(sp)
ffffffffc0206b8a:	6462                	ld	s0,24(sp)
ffffffffc0206b8c:	0e010c93          	addi	s9,sp,224
ffffffffc0206b90:	1902                	slli	s2,s2,0x20
ffffffffc0206b92:	02095913          	srli	s2,s2,0x20
ffffffffc0206b96:	58f1                	li	a7,-4
ffffffffc0206b98:	b37d                	j	ffffffffc0206946 <do_execve+0x3a4>
ffffffffc0206b9a:	7ce2                	ld	s9,56(sp)
ffffffffc0206b9c:	6d06                	ld	s10,64(sp)
ffffffffc0206b9e:	b3f1                	j	ffffffffc020696a <do_execve+0x3c8>
ffffffffc0206ba0:	59f5                	li	s3,-3
ffffffffc0206ba2:	be5d                	j	ffffffffc0206758 <do_execve+0x1b6>
ffffffffc0206ba4:	f802                	sd	zero,48(sp)
ffffffffc0206ba6:	b391                	j	ffffffffc02068ea <do_execve+0x348>
ffffffffc0206ba8:	59f5                	li	s3,-3
ffffffffc0206baa:	c80c12e3          	bnez	s8,ffffffffc020682e <do_execve+0x28c>
ffffffffc0206bae:	b66d                	j	ffffffffc0206758 <do_execve+0x1b6>
ffffffffc0206bb0:	fe0c08e3          	beqz	s8,ffffffffc0206ba0 <do_execve+0x5fe>
ffffffffc0206bb4:	038c0513          	addi	a0,s8,56
ffffffffc0206bb8:	a41fd0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0206bbc:	59f5                	li	s3,-3
ffffffffc0206bbe:	040c2823          	sw	zero,80(s8)
ffffffffc0206bc2:	be59                	j	ffffffffc0206758 <do_execve+0x1b6>
ffffffffc0206bc4:	6462                	ld	s0,24(sp)
ffffffffc0206bc6:	5902                	lw	s2,32(sp)
ffffffffc0206bc8:	58f5                	li	a7,-3
ffffffffc0206bca:	bb8d                	j	ffffffffc020693c <do_execve+0x39a>
ffffffffc0206bcc:	895e                	mv	s2,s7
ffffffffc0206bce:	1902                	slli	s2,s2,0x20
ffffffffc0206bd0:	02095913          	srli	s2,s2,0x20
ffffffffc0206bd4:	0e010c93          	addi	s9,sp,224
ffffffffc0206bd8:	016c8633          	add	a2,s9,s6
ffffffffc0206bdc:	00391793          	slli	a5,s2,0x3
ffffffffc0206be0:	40f607b3          	sub	a5,a2,a5
ffffffffc0206be4:	567d                	li	a2,-1
ffffffffc0206be6:	6422                	ld	s0,8(sp)
ffffffffc0206be8:	8ba6                	mv	s7,s1
ffffffffc0206bea:	68e2                	ld	a7,24(sp)
ffffffffc0206bec:	7482                	ld	s1,32(sp)
ffffffffc0206bee:	ff8b0c13          	addi	s8,s6,-8
ffffffffc0206bf2:	1998                	addi	a4,sp,240
ffffffffc0206bf4:	ec3e                	sd	a5,24(sp)
ffffffffc0206bf6:	00c65793          	srli	a5,a2,0xc
ffffffffc0206bfa:	9762                	add	a4,a4,s8
ffffffffc0206bfc:	f03e                	sd	a5,32(sp)
ffffffffc0206bfe:	fff68793          	addi	a5,a3,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0206c02:	e43a                	sd	a4,8(sp)
ffffffffc0206c04:	fc3e                	sd	a5,56(sp)
ffffffffc0206c06:	1b98                	addi	a4,sp,496
ffffffffc0206c08:	87ca                	mv	a5,s2
ffffffffc0206c0a:	9c3a                	add	s8,s8,a4
ffffffffc0206c0c:	8922                	mv	s2,s0
ffffffffc0206c0e:	e0c6                	sd	a7,64(sp)
ffffffffc0206c10:	845e                	mv	s0,s7
ffffffffc0206c12:	e4a6                	sd	s1,72(sp)
ffffffffc0206c14:	8bbe                	mv	s7,a5
ffffffffc0206c16:	67a2                	ld	a5,8(sp)
ffffffffc0206c18:	6384                	ld	s1,0(a5)
ffffffffc0206c1a:	8526                	mv	a0,s1
ffffffffc0206c1c:	35d040ef          	jal	ra,ffffffffc020b778 <strlen>
ffffffffc0206c20:	00150693          	addi	a3,a0,1 # 1001 <_binary_bin_swap_img_size-0x6cff>
ffffffffc0206c24:	8c15                	sub	s0,s0,a3
ffffffffc0206c26:	e8b6                	sd	a3,80(sp)
ffffffffc0206c28:	7ff007b7          	lui	a5,0x7ff00
ffffffffc0206c2c:	3af46163          	bltu	s0,a5,ffffffffc0206fce <do_execve+0xa2c>
ffffffffc0206c30:	67c2                	ld	a5,16(sp)
ffffffffc0206c32:	4601                	li	a2,0
ffffffffc0206c34:	85a2                	mv	a1,s0
ffffffffc0206c36:	6f88                	ld	a0,24(a5)
ffffffffc0206c38:	96ffb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206c3c:	66c6                	ld	a3,80(sp)
ffffffffc0206c3e:	36050863          	beqz	a0,ffffffffc0206fae <do_execve+0xa0c>
ffffffffc0206c42:	00090717          	auipc	a4,0x90
ffffffffc0206c46:	c6670713          	addi	a4,a4,-922 # ffffffffc02968a8 <pages>
ffffffffc0206c4a:	630c                	ld	a1,0(a4)
ffffffffc0206c4c:	7722                	ld	a4,40(sp)
ffffffffc0206c4e:	000db603          	ld	a2,0(s11)
ffffffffc0206c52:	40b507b3          	sub	a5,a0,a1
ffffffffc0206c56:	8799                	srai	a5,a5,0x6
ffffffffc0206c58:	97ba                	add	a5,a5,a4
ffffffffc0206c5a:	7702                	ld	a4,32(sp)
ffffffffc0206c5c:	00e7f5b3          	and	a1,a5,a4
ffffffffc0206c60:	07b2                	slli	a5,a5,0xc
ffffffffc0206c62:	32c5f963          	bgeu	a1,a2,ffffffffc0206f94 <do_execve+0x9f2>
ffffffffc0206c66:	00090717          	auipc	a4,0x90
ffffffffc0206c6a:	c5270713          	addi	a4,a4,-942 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206c6e:	630c                	ld	a1,0(a4)
ffffffffc0206c70:	7762                	ld	a4,56(sp)
ffffffffc0206c72:	8636                	mv	a2,a3
ffffffffc0206c74:	97ae                	add	a5,a5,a1
ffffffffc0206c76:	00e47533          	and	a0,s0,a4
ffffffffc0206c7a:	953e                	add	a0,a0,a5
ffffffffc0206c7c:	85a6                	mv	a1,s1
ffffffffc0206c7e:	3ef040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc0206c82:	67a2                	ld	a5,8(sp)
ffffffffc0206c84:	6762                	ld	a4,24(sp)
ffffffffc0206c86:	008c3023          	sd	s0,0(s8)
ffffffffc0206c8a:	17e1                	addi	a5,a5,-8
ffffffffc0206c8c:	e43e                	sd	a5,8(sp)
ffffffffc0206c8e:	1c61                	addi	s8,s8,-8
ffffffffc0206c90:	f8e793e3          	bne	a5,a4,ffffffffc0206c16 <do_execve+0x674>
ffffffffc0206c94:	87de                	mv	a5,s7
ffffffffc0206c96:	8ba2                	mv	s7,s0
ffffffffc0206c98:	ff0bf813          	andi	a6,s7,-16
ffffffffc0206c9c:	6886                	ld	a7,64(sp)
ffffffffc0206c9e:	008b0b93          	addi	s7,s6,8
ffffffffc0206ca2:	41780bb3          	sub	s7,a6,s7
ffffffffc0206ca6:	1f010813          	addi	a6,sp,496
ffffffffc0206caa:	844a                	mv	s0,s2
ffffffffc0206cac:	6c05                	lui	s8,0x1
ffffffffc0206cae:	893e                	mv	s2,a5
ffffffffc0206cb0:	410b87b3          	sub	a5,s7,a6
ffffffffc0206cb4:	ec22                	sd	s0,24(sp)
ffffffffc0206cb6:	f04a                	sd	s2,32(sp)
ffffffffc0206cb8:	64a6                	ld	s1,72(sp)
ffffffffc0206cba:	e43e                	sd	a5,8(sp)
ffffffffc0206cbc:	1c7d                	addi	s8,s8,-1
ffffffffc0206cbe:	8446                	mv	s0,a7
ffffffffc0206cc0:	8942                	mv	s2,a6
ffffffffc0206cc2:	a011                	j	ffffffffc0206cc6 <do_execve+0x724>
ffffffffc0206cc4:	843e                	mv	s0,a5
ffffffffc0206cc6:	67c2                	ld	a5,16(sp)
ffffffffc0206cc8:	4601                	li	a2,0
ffffffffc0206cca:	6f88                	ld	a0,24(a5)
ffffffffc0206ccc:	67a2                	ld	a5,8(sp)
ffffffffc0206cce:	012785b3          	add	a1,a5,s2
ffffffffc0206cd2:	fc2e                	sd	a1,56(sp)
ffffffffc0206cd4:	8d3fb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206cd8:	75e2                	ld	a1,56(sp)
ffffffffc0206cda:	34050a63          	beqz	a0,ffffffffc020702e <do_execve+0xa8c>
ffffffffc0206cde:	00090717          	auipc	a4,0x90
ffffffffc0206ce2:	bca70713          	addi	a4,a4,-1078 # ffffffffc02968a8 <pages>
ffffffffc0206ce6:	6314                	ld	a3,0(a4)
ffffffffc0206ce8:	000db703          	ld	a4,0(s11)
ffffffffc0206cec:	40d507b3          	sub	a5,a0,a3
ffffffffc0206cf0:	76a2                	ld	a3,40(sp)
ffffffffc0206cf2:	8799                	srai	a5,a5,0x6
ffffffffc0206cf4:	97b6                	add	a5,a5,a3
ffffffffc0206cf6:	56fd                	li	a3,-1
ffffffffc0206cf8:	82b1                	srli	a3,a3,0xc
ffffffffc0206cfa:	8efd                	and	a3,a3,a5
ffffffffc0206cfc:	07b2                	slli	a5,a5,0xc
ffffffffc0206cfe:	28e6fb63          	bgeu	a3,a4,ffffffffc0206f94 <do_execve+0x9f2>
ffffffffc0206d02:	00090717          	auipc	a4,0x90
ffffffffc0206d06:	bb670713          	addi	a4,a4,-1098 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206d0a:	6318                	ld	a4,0(a4)
ffffffffc0206d0c:	0185f533          	and	a0,a1,s8
ffffffffc0206d10:	4621                	li	a2,8
ffffffffc0206d12:	97ba                	add	a5,a5,a4
ffffffffc0206d14:	85ca                	mv	a1,s2
ffffffffc0206d16:	953e                	add	a0,a0,a5
ffffffffc0206d18:	355040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc0206d1c:	0921                	addi	s2,s2,8
ffffffffc0206d1e:	0014079b          	addiw	a5,s0,1
ffffffffc0206d22:	fa9441e3          	blt	s0,s1,ffffffffc0206cc4 <do_execve+0x722>
ffffffffc0206d26:	67c2                	ld	a5,16(sp)
ffffffffc0206d28:	017b04b3          	add	s1,s6,s7
ffffffffc0206d2c:	4601                	li	a2,0
ffffffffc0206d2e:	6f88                	ld	a0,24(a5)
ffffffffc0206d30:	85a6                	mv	a1,s1
ffffffffc0206d32:	6462                	ld	s0,24(sp)
ffffffffc0206d34:	7902                	ld	s2,32(sp)
ffffffffc0206d36:	f082                	sd	zero,96(sp)
ffffffffc0206d38:	86ffb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206d3c:	2c050963          	beqz	a0,ffffffffc020700e <do_execve+0xa6c>
ffffffffc0206d40:	dc7fe0ef          	jal	ra,ffffffffc0205b06 <page2kva>
ffffffffc0206d44:	0184f4b3          	and	s1,s1,s8
ffffffffc0206d48:	4621                	li	a2,8
ffffffffc0206d4a:	108c                	addi	a1,sp,96
ffffffffc0206d4c:	9526                	add	a0,a0,s1
ffffffffc0206d4e:	31f040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc0206d52:	67c2                	ld	a5,16(sp)
ffffffffc0206d54:	ffcb8493          	addi	s1,s7,-4 # 7feffffc <_binary_bin_sfs_img_size+0x7fe8acfc>
ffffffffc0206d58:	4601                	li	a2,0
ffffffffc0206d5a:	6f88                	ld	a0,24(a5)
ffffffffc0206d5c:	85a6                	mv	a1,s1
ffffffffc0206d5e:	d0ea                	sw	s10,96(sp)
ffffffffc0206d60:	847fb0ef          	jal	ra,ffffffffc02025a6 <get_page>
ffffffffc0206d64:	28050563          	beqz	a0,ffffffffc0206fee <do_execve+0xa4c>
ffffffffc0206d68:	d9ffe0ef          	jal	ra,ffffffffc0205b06 <page2kva>
ffffffffc0206d6c:	0184f4b3          	and	s1,s1,s8
ffffffffc0206d70:	4611                	li	a2,4
ffffffffc0206d72:	108c                	addi	a1,sp,96
ffffffffc0206d74:	9526                	add	a0,a0,s1
ffffffffc0206d76:	2f7040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc0206d7a:	6742                	ld	a4,16(sp)
ffffffffc0206d7c:	000ab603          	ld	a2,0(s5)
ffffffffc0206d80:	4785                	li	a5,1
ffffffffc0206d82:	6f14                	ld	a3,24(a4)
ffffffffc0206d84:	db1c                	sw	a5,48(a4)
ffffffffc0206d86:	f7cb8c13          	addi	s8,s7,-132
ffffffffc0206d8a:	f618                	sd	a4,40(a2)
ffffffffc0206d8c:	c02007b7          	lui	a5,0xc0200
ffffffffc0206d90:	ff0c7c13          	andi	s8,s8,-16
ffffffffc0206d94:	24f6e163          	bltu	a3,a5,ffffffffc0206fd6 <do_execve+0xa34>
ffffffffc0206d98:	00090797          	auipc	a5,0x90
ffffffffc0206d9c:	b2078793          	addi	a5,a5,-1248 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206da0:	639c                	ld	a5,0(a5)
ffffffffc0206da2:	577d                	li	a4,-1
ffffffffc0206da4:	177e                	slli	a4,a4,0x3f
ffffffffc0206da6:	8e9d                	sub	a3,a3,a5
ffffffffc0206da8:	00c6d793          	srli	a5,a3,0xc
ffffffffc0206dac:	f654                	sd	a3,168(a2)
ffffffffc0206dae:	8fd9                	or	a5,a5,a4
ffffffffc0206db0:	18079073          	csrw	satp,a5
ffffffffc0206db4:	12000073          	sfence.vma
ffffffffc0206db8:	000ab783          	ld	a5,0(s5)
ffffffffc0206dbc:	12000613          	li	a2,288
ffffffffc0206dc0:	4581                	li	a1,0
ffffffffc0206dc2:	73c4                	ld	s1,160(a5)
ffffffffc0206dc4:	8526                	mv	a0,s1
ffffffffc0206dc6:	255040ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc0206dca:	77c2                	ld	a5,48(sp)
ffffffffc0206dcc:	0184b823          	sd	s8,16(s1)
ffffffffc0206dd0:	e8a0                	sd	s0,80(s1)
ffffffffc0206dd2:	0574bc23          	sd	s7,88(s1)
ffffffffc0206dd6:	c391                	beqz	a5,ffffffffc0206dda <do_execve+0x838>
ffffffffc0206dd8:	ec9c                	sd	a5,24(s1)
ffffffffc0206dda:	100027f3          	csrr	a5,sstatus
ffffffffc0206dde:	edf7f793          	andi	a5,a5,-289
ffffffffc0206de2:	0207e793          	ori	a5,a5,32
ffffffffc0206de6:	10f4b023          	sd	a5,256(s1)
ffffffffc0206dea:	67ae                	ld	a5,200(sp)
ffffffffc0206dec:	8552                	mv	a0,s4
ffffffffc0206dee:	10f4b423          	sd	a5,264(s1)
ffffffffc0206df2:	801fe0ef          	jal	ra,ffffffffc02055f2 <sysfile_close>
ffffffffc0206df6:	b22d                	j	ffffffffc0206720 <do_execve+0x17e>
ffffffffc0206df8:	7c82                	ld	s9,32(sp)
ffffffffc0206dfa:	8662                	mv	a2,s8
ffffffffc0206dfc:	8552                	mv	a0,s4
ffffffffc0206dfe:	85e6                	mv	a1,s9
ffffffffc0206e00:	ff6fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206e04:	14ac1d63          	bne	s8,a0,ffffffffc0206f5e <do_execve+0x9bc>
ffffffffc0206e08:	0ec15703          	lhu	a4,236(sp)
ffffffffc0206e0c:	0c91                	addi	s9,s9,4
ffffffffc0206e0e:	863a                	mv	a2,a4
ffffffffc0206e10:	14070263          	beqz	a4,ffffffffc0206f54 <do_execve+0x9b2>
ffffffffc0206e14:	fc26                	sd	s1,56(sp)
ffffffffc0206e16:	e45a                	sd	s6,8(sp)
ffffffffc0206e18:	84e6                	mv	s1,s9
ffffffffc0206e1a:	f86a                	sd	s10,48(sp)
ffffffffc0206e1c:	e0ce                	sd	s3,64(sp)
ffffffffc0206e1e:	ec22                	sd	s0,24(sp)
ffffffffc0206e20:	8cca                	mv	s9,s2
ffffffffc0206e22:	a801                	j	ffffffffc0206e32 <do_execve+0x890>
ffffffffc0206e24:	2b85                	addiw	s7,s7,1
ffffffffc0206e26:	0006079b          	sext.w	a5,a2
ffffffffc0206e2a:	04048493          	addi	s1,s1,64
ffffffffc0206e2e:	10fbdd63          	bge	s7,a5,ffffffffc0206f48 <do_execve+0x9a6>
ffffffffc0206e32:	409c                	lw	a5,0(s1)
ffffffffc0206e34:	4709                	li	a4,2
ffffffffc0206e36:	fee797e3          	bne	a5,a4,ffffffffc0206e24 <do_execve+0x882>
ffffffffc0206e3a:	0344b783          	ld	a5,52(s1)
ffffffffc0206e3e:	4761                	li	a4,24
ffffffffc0206e40:	fee792e3          	bne	a5,a4,ffffffffc0206e24 <do_execve+0x882>
ffffffffc0206e44:	0244e783          	lwu	a5,36(s1)
ffffffffc0206e48:	01c4bd03          	ld	s10,28(s1)
ffffffffc0206e4c:	7702                	ld	a4,32(sp)
ffffffffc0206e4e:	079a                	slli	a5,a5,0x6
ffffffffc0206e50:	856a                	mv	a0,s10
ffffffffc0206e52:	00f70933          	add	s2,a4,a5
ffffffffc0206e56:	02093403          	ld	s0,32(s2)
ffffffffc0206e5a:	9c8fb0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0206e5e:	8b2a                	mv	s6,a0
ffffffffc0206e60:	d00500e3          	beqz	a0,ffffffffc0206b60 <do_execve+0x5be>
ffffffffc0206e64:	8522                	mv	a0,s0
ffffffffc0206e66:	9bcfb0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0206e6a:	8c2a                	mv	s8,a0
ffffffffc0206e6c:	ce050ae3          	beqz	a0,ffffffffc0206b60 <do_execve+0x5be>
ffffffffc0206e70:	0144b583          	ld	a1,20(s1)
ffffffffc0206e74:	4601                	li	a2,0
ffffffffc0206e76:	8552                	mv	a0,s4
ffffffffc0206e78:	9adfe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206e7c:	872a                	mv	a4,a0
ffffffffc0206e7e:	e55d                	bnez	a0,ffffffffc0206f2c <do_execve+0x98a>
ffffffffc0206e80:	866a                	mv	a2,s10
ffffffffc0206e82:	85da                	mv	a1,s6
ffffffffc0206e84:	8552                	mv	a0,s4
ffffffffc0206e86:	f70fe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206e8a:	862a                	mv	a2,a0
ffffffffc0206e8c:	02ad0d63          	beq	s10,a0,ffffffffc0206ec6 <do_execve+0x924>
ffffffffc0206e90:	87da                	mv	a5,s6
ffffffffc0206e92:	6462                	ld	s0,24(sp)
ffffffffc0206e94:	6b22                	ld	s6,8(sp)
ffffffffc0206e96:	8966                	mv	s2,s9
ffffffffc0206e98:	0006071b          	sext.w	a4,a2
ffffffffc0206e9c:	00064363          	bltz	a2,ffffffffc0206ea2 <do_execve+0x900>
ffffffffc0206ea0:	577d                	li	a4,-1
ffffffffc0206ea2:	853e                	mv	a0,a5
ffffffffc0206ea4:	e43a                	sd	a4,8(sp)
ffffffffc0206ea6:	a2cfb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206eaa:	8562                	mv	a0,s8
ffffffffc0206eac:	a26fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206eb0:	7502                	ld	a0,32(sp)
ffffffffc0206eb2:	1902                	slli	s2,s2,0x20
ffffffffc0206eb4:	0e010c93          	addi	s9,sp,224
ffffffffc0206eb8:	a1afb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206ebc:	6722                	ld	a4,8(sp)
ffffffffc0206ebe:	02095913          	srli	s2,s2,0x20
ffffffffc0206ec2:	89ba                	mv	s3,a4
ffffffffc0206ec4:	bc59                	j	ffffffffc020695a <do_execve+0x3b8>
ffffffffc0206ec6:	01893583          	ld	a1,24(s2)
ffffffffc0206eca:	4601                	li	a2,0
ffffffffc0206ecc:	8552                	mv	a0,s4
ffffffffc0206ece:	957fe0ef          	jal	ra,ffffffffc0205824 <sysfile_seek>
ffffffffc0206ed2:	872a                	mv	a4,a0
ffffffffc0206ed4:	ed21                	bnez	a0,ffffffffc0206f2c <do_execve+0x98a>
ffffffffc0206ed6:	8622                	mv	a2,s0
ffffffffc0206ed8:	85e2                	mv	a1,s8
ffffffffc0206eda:	8552                	mv	a0,s4
ffffffffc0206edc:	f1afe0ef          	jal	ra,ffffffffc02055f6 <sysfile_read>
ffffffffc0206ee0:	862a                	mv	a2,a0
ffffffffc0206ee2:	faa417e3          	bne	s0,a0,ffffffffc0206e90 <do_execve+0x8ee>
ffffffffc0206ee6:	47e1                	li	a5,24
ffffffffc0206ee8:	02fd5433          	divu	s0,s10,a5
ffffffffc0206eec:	47dd                	li	a5,23
ffffffffc0206eee:	895a                	mv	s2,s6
ffffffffc0206ef0:	4981                	li	s3,0
ffffffffc0206ef2:	01a7e763          	bltu	a5,s10,ffffffffc0206f00 <do_execve+0x95e>
ffffffffc0206ef6:	a081                	j	ffffffffc0206f36 <do_execve+0x994>
ffffffffc0206ef8:	0985                	addi	s3,s3,1
ffffffffc0206efa:	0961                	addi	s2,s2,24
ffffffffc0206efc:	0289fd63          	bgeu	s3,s0,ffffffffc0206f36 <do_execve+0x994>
ffffffffc0206f00:	00096503          	lwu	a0,0(s2)
ffffffffc0206f04:	00007597          	auipc	a1,0x7
ffffffffc0206f08:	b2458593          	addi	a1,a1,-1244 # ffffffffc020da28 <CSWTCH.79+0x2e0>
ffffffffc0206f0c:	9562                	add	a0,a0,s8
ffffffffc0206f0e:	0b3040ef          	jal	ra,ffffffffc020b7c0 <strcmp>
ffffffffc0206f12:	f17d                	bnez	a0,ffffffffc0206ef8 <do_execve+0x956>
ffffffffc0206f14:	00893403          	ld	s0,8(s2)
ffffffffc0206f18:	855a                	mv	a0,s6
ffffffffc0206f1a:	9b8fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206f1e:	8562                	mv	a0,s8
ffffffffc0206f20:	9b2fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206f24:	e039                	bnez	s0,ffffffffc0206f6a <do_execve+0x9c8>
ffffffffc0206f26:	0ec15603          	lhu	a2,236(sp)
ffffffffc0206f2a:	bded                	j	ffffffffc0206e24 <do_execve+0x882>
ffffffffc0206f2c:	87da                	mv	a5,s6
ffffffffc0206f2e:	6462                	ld	s0,24(sp)
ffffffffc0206f30:	6b22                	ld	s6,8(sp)
ffffffffc0206f32:	8966                	mv	s2,s9
ffffffffc0206f34:	b7bd                	j	ffffffffc0206ea2 <do_execve+0x900>
ffffffffc0206f36:	855a                	mv	a0,s6
ffffffffc0206f38:	99afb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206f3c:	8562                	mv	a0,s8
ffffffffc0206f3e:	994fb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206f42:	0ec15603          	lhu	a2,236(sp)
ffffffffc0206f46:	bdf9                	j	ffffffffc0206e24 <do_execve+0x882>
ffffffffc0206f48:	6b22                	ld	s6,8(sp)
ffffffffc0206f4a:	7d42                	ld	s10,48(sp)
ffffffffc0206f4c:	74e2                	ld	s1,56(sp)
ffffffffc0206f4e:	6986                	ld	s3,64(sp)
ffffffffc0206f50:	6462                	ld	s0,24(sp)
ffffffffc0206f52:	8966                	mv	s2,s9
ffffffffc0206f54:	f802                	sd	zero,48(sp)
ffffffffc0206f56:	7502                	ld	a0,32(sp)
ffffffffc0206f58:	97afb0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0206f5c:	b279                	j	ffffffffc02068ea <do_execve+0x348>
ffffffffc0206f5e:	00050b9b          	sext.w	s7,a0
ffffffffc0206f62:	be0540e3          	bltz	a0,ffffffffc0206b42 <do_execve+0x5a0>
ffffffffc0206f66:	5bfd                	li	s7,-1
ffffffffc0206f68:	bee9                	j	ffffffffc0206b42 <do_execve+0x5a0>
ffffffffc0206f6a:	7d42                	ld	s10,48(sp)
ffffffffc0206f6c:	6b22                	ld	s6,8(sp)
ffffffffc0206f6e:	f822                	sd	s0,48(sp)
ffffffffc0206f70:	74e2                	ld	s1,56(sp)
ffffffffc0206f72:	6986                	ld	s3,64(sp)
ffffffffc0206f74:	6462                	ld	s0,24(sp)
ffffffffc0206f76:	8966                	mv	s2,s9
ffffffffc0206f78:	bff9                	j	ffffffffc0206f56 <do_execve+0x9b4>
ffffffffc0206f7a:	86aa                	mv	a3,a0
ffffffffc0206f7c:	00006617          	auipc	a2,0x6
ffffffffc0206f80:	8dc60613          	addi	a2,a2,-1828 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc0206f84:	07100593          	li	a1,113
ffffffffc0206f88:	00006517          	auipc	a0,0x6
ffffffffc0206f8c:	8f850513          	addi	a0,a0,-1800 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0206f90:	d0ef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206f94:	86be                	mv	a3,a5
ffffffffc0206f96:	00006617          	auipc	a2,0x6
ffffffffc0206f9a:	8c260613          	addi	a2,a2,-1854 # ffffffffc020c858 <default_pmm_manager+0x38>
ffffffffc0206f9e:	07100593          	li	a1,113
ffffffffc0206fa2:	00006517          	auipc	a0,0x6
ffffffffc0206fa6:	8de50513          	addi	a0,a0,-1826 # ffffffffc020c880 <default_pmm_manager+0x60>
ffffffffc0206faa:	cf4f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206fae:	00006697          	auipc	a3,0x6
ffffffffc0206fb2:	04a68693          	addi	a3,a3,74 # ffffffffc020cff8 <default_pmm_manager+0x7d8>
ffffffffc0206fb6:	00005617          	auipc	a2,0x5
ffffffffc0206fba:	d4a60613          	addi	a2,a2,-694 # ffffffffc020bd00 <commands+0x210>
ffffffffc0206fbe:	39700593          	li	a1,919
ffffffffc0206fc2:	00007517          	auipc	a0,0x7
ffffffffc0206fc6:	87650513          	addi	a0,a0,-1930 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0206fca:	cd4f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206fce:	844a                	mv	s0,s2
ffffffffc0206fd0:	58f1                	li	a7,-4
ffffffffc0206fd2:	895e                	mv	s2,s7
ffffffffc0206fd4:	ba8d                	j	ffffffffc0206946 <do_execve+0x3a4>
ffffffffc0206fd6:	00006617          	auipc	a2,0x6
ffffffffc0206fda:	92a60613          	addi	a2,a2,-1750 # ffffffffc020c900 <default_pmm_manager+0xe0>
ffffffffc0206fde:	3bf00593          	li	a1,959
ffffffffc0206fe2:	00007517          	auipc	a0,0x7
ffffffffc0206fe6:	85650513          	addi	a0,a0,-1962 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0206fea:	cb4f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206fee:	00006697          	auipc	a3,0x6
ffffffffc0206ff2:	00a68693          	addi	a3,a3,10 # ffffffffc020cff8 <default_pmm_manager+0x7d8>
ffffffffc0206ff6:	00005617          	auipc	a2,0x5
ffffffffc0206ffa:	d0a60613          	addi	a2,a2,-758 # ffffffffc020bd00 <commands+0x210>
ffffffffc0206ffe:	3b400593          	li	a1,948
ffffffffc0207002:	00007517          	auipc	a0,0x7
ffffffffc0207006:	83650513          	addi	a0,a0,-1994 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020700a:	c94f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020700e:	00006697          	auipc	a3,0x6
ffffffffc0207012:	fea68693          	addi	a3,a3,-22 # ffffffffc020cff8 <default_pmm_manager+0x7d8>
ffffffffc0207016:	00005617          	auipc	a2,0x5
ffffffffc020701a:	cea60613          	addi	a2,a2,-790 # ffffffffc020bd00 <commands+0x210>
ffffffffc020701e:	3ac00593          	li	a1,940
ffffffffc0207022:	00007517          	auipc	a0,0x7
ffffffffc0207026:	81650513          	addi	a0,a0,-2026 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020702a:	c74f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020702e:	00006697          	auipc	a3,0x6
ffffffffc0207032:	fca68693          	addi	a3,a3,-54 # ffffffffc020cff8 <default_pmm_manager+0x7d8>
ffffffffc0207036:	00005617          	auipc	a2,0x5
ffffffffc020703a:	cca60613          	addi	a2,a2,-822 # ffffffffc020bd00 <commands+0x210>
ffffffffc020703e:	3a500593          	li	a1,933
ffffffffc0207042:	00006517          	auipc	a0,0x6
ffffffffc0207046:	7f650513          	addi	a0,a0,2038 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020704a:	c54f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020704e <user_main>:
ffffffffc020704e:	7179                	addi	sp,sp,-48
ffffffffc0207050:	e84a                	sd	s2,16(sp)
ffffffffc0207052:	00090917          	auipc	s2,0x90
ffffffffc0207056:	86e90913          	addi	s2,s2,-1938 # ffffffffc02968c0 <current>
ffffffffc020705a:	00093783          	ld	a5,0(s2)
ffffffffc020705e:	00007617          	auipc	a2,0x7
ffffffffc0207062:	9e260613          	addi	a2,a2,-1566 # ffffffffc020da40 <CSWTCH.79+0x2f8>
ffffffffc0207066:	00007517          	auipc	a0,0x7
ffffffffc020706a:	9e250513          	addi	a0,a0,-1566 # ffffffffc020da48 <CSWTCH.79+0x300>
ffffffffc020706e:	43cc                	lw	a1,4(a5)
ffffffffc0207070:	f406                	sd	ra,40(sp)
ffffffffc0207072:	f022                	sd	s0,32(sp)
ffffffffc0207074:	ec26                	sd	s1,24(sp)
ffffffffc0207076:	e032                	sd	a2,0(sp)
ffffffffc0207078:	e402                	sd	zero,8(sp)
ffffffffc020707a:	92cf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020707e:	6782                	ld	a5,0(sp)
ffffffffc0207080:	cfb9                	beqz	a5,ffffffffc02070de <user_main+0x90>
ffffffffc0207082:	003c                	addi	a5,sp,8
ffffffffc0207084:	4401                	li	s0,0
ffffffffc0207086:	6398                	ld	a4,0(a5)
ffffffffc0207088:	0405                	addi	s0,s0,1
ffffffffc020708a:	07a1                	addi	a5,a5,8
ffffffffc020708c:	ff6d                	bnez	a4,ffffffffc0207086 <user_main+0x38>
ffffffffc020708e:	00093783          	ld	a5,0(s2)
ffffffffc0207092:	12000613          	li	a2,288
ffffffffc0207096:	6b84                	ld	s1,16(a5)
ffffffffc0207098:	73cc                	ld	a1,160(a5)
ffffffffc020709a:	6789                	lui	a5,0x2
ffffffffc020709c:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc02070a0:	94be                	add	s1,s1,a5
ffffffffc02070a2:	8526                	mv	a0,s1
ffffffffc02070a4:	7c8040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc02070a8:	00093783          	ld	a5,0(s2)
ffffffffc02070ac:	860a                	mv	a2,sp
ffffffffc02070ae:	0004059b          	sext.w	a1,s0
ffffffffc02070b2:	f3c4                	sd	s1,160(a5)
ffffffffc02070b4:	00007517          	auipc	a0,0x7
ffffffffc02070b8:	98c50513          	addi	a0,a0,-1652 # ffffffffc020da40 <CSWTCH.79+0x2f8>
ffffffffc02070bc:	ce6ff0ef          	jal	ra,ffffffffc02065a2 <do_execve>
ffffffffc02070c0:	8126                	mv	sp,s1
ffffffffc02070c2:	a22fa06f          	j	ffffffffc02012e4 <__trapret>
ffffffffc02070c6:	00007617          	auipc	a2,0x7
ffffffffc02070ca:	9aa60613          	addi	a2,a2,-1622 # ffffffffc020da70 <CSWTCH.79+0x328>
ffffffffc02070ce:	4e800593          	li	a1,1256
ffffffffc02070d2:	00006517          	auipc	a0,0x6
ffffffffc02070d6:	76650513          	addi	a0,a0,1894 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc02070da:	bc4f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02070de:	4401                	li	s0,0
ffffffffc02070e0:	b77d                	j	ffffffffc020708e <user_main+0x40>

ffffffffc02070e2 <do_yield>:
ffffffffc02070e2:	0008f797          	auipc	a5,0x8f
ffffffffc02070e6:	7de7b783          	ld	a5,2014(a5) # ffffffffc02968c0 <current>
ffffffffc02070ea:	4705                	li	a4,1
ffffffffc02070ec:	ef98                	sd	a4,24(a5)
ffffffffc02070ee:	4501                	li	a0,0
ffffffffc02070f0:	8082                	ret

ffffffffc02070f2 <do_wait>:
ffffffffc02070f2:	1101                	addi	sp,sp,-32
ffffffffc02070f4:	e822                	sd	s0,16(sp)
ffffffffc02070f6:	e426                	sd	s1,8(sp)
ffffffffc02070f8:	ec06                	sd	ra,24(sp)
ffffffffc02070fa:	842e                	mv	s0,a1
ffffffffc02070fc:	84aa                	mv	s1,a0
ffffffffc02070fe:	c999                	beqz	a1,ffffffffc0207114 <do_wait+0x22>
ffffffffc0207100:	0008f797          	auipc	a5,0x8f
ffffffffc0207104:	7c07b783          	ld	a5,1984(a5) # ffffffffc02968c0 <current>
ffffffffc0207108:	7788                	ld	a0,40(a5)
ffffffffc020710a:	4685                	li	a3,1
ffffffffc020710c:	4611                	li	a2,4
ffffffffc020710e:	a18fd0ef          	jal	ra,ffffffffc0204326 <user_mem_check>
ffffffffc0207112:	c909                	beqz	a0,ffffffffc0207124 <do_wait+0x32>
ffffffffc0207114:	85a2                	mv	a1,s0
ffffffffc0207116:	6442                	ld	s0,16(sp)
ffffffffc0207118:	60e2                	ld	ra,24(sp)
ffffffffc020711a:	8526                	mv	a0,s1
ffffffffc020711c:	64a2                	ld	s1,8(sp)
ffffffffc020711e:	6105                	addi	sp,sp,32
ffffffffc0207120:	960ff06f          	j	ffffffffc0206280 <do_wait.part.0>
ffffffffc0207124:	60e2                	ld	ra,24(sp)
ffffffffc0207126:	6442                	ld	s0,16(sp)
ffffffffc0207128:	64a2                	ld	s1,8(sp)
ffffffffc020712a:	5575                	li	a0,-3
ffffffffc020712c:	6105                	addi	sp,sp,32
ffffffffc020712e:	8082                	ret

ffffffffc0207130 <do_kill>:
ffffffffc0207130:	1141                	addi	sp,sp,-16
ffffffffc0207132:	6789                	lui	a5,0x2
ffffffffc0207134:	e406                	sd	ra,8(sp)
ffffffffc0207136:	e022                	sd	s0,0(sp)
ffffffffc0207138:	fff5071b          	addiw	a4,a0,-1
ffffffffc020713c:	17f9                	addi	a5,a5,-2
ffffffffc020713e:	02e7e963          	bltu	a5,a4,ffffffffc0207170 <do_kill+0x40>
ffffffffc0207142:	842a                	mv	s0,a0
ffffffffc0207144:	45a9                	li	a1,10
ffffffffc0207146:	2501                	sext.w	a0,a0
ffffffffc0207148:	19e040ef          	jal	ra,ffffffffc020b2e6 <hash32>
ffffffffc020714c:	02051793          	slli	a5,a0,0x20
ffffffffc0207150:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0207154:	0008a797          	auipc	a5,0x8a
ffffffffc0207158:	66c78793          	addi	a5,a5,1644 # ffffffffc02917c0 <hash_list>
ffffffffc020715c:	953e                	add	a0,a0,a5
ffffffffc020715e:	87aa                	mv	a5,a0
ffffffffc0207160:	a029                	j	ffffffffc020716a <do_kill+0x3a>
ffffffffc0207162:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0207166:	00870b63          	beq	a4,s0,ffffffffc020717c <do_kill+0x4c>
ffffffffc020716a:	679c                	ld	a5,8(a5)
ffffffffc020716c:	fef51be3          	bne	a0,a5,ffffffffc0207162 <do_kill+0x32>
ffffffffc0207170:	5475                	li	s0,-3
ffffffffc0207172:	60a2                	ld	ra,8(sp)
ffffffffc0207174:	8522                	mv	a0,s0
ffffffffc0207176:	6402                	ld	s0,0(sp)
ffffffffc0207178:	0141                	addi	sp,sp,16
ffffffffc020717a:	8082                	ret
ffffffffc020717c:	fd87a703          	lw	a4,-40(a5)
ffffffffc0207180:	00177693          	andi	a3,a4,1
ffffffffc0207184:	e295                	bnez	a3,ffffffffc02071a8 <do_kill+0x78>
ffffffffc0207186:	4bd4                	lw	a3,20(a5)
ffffffffc0207188:	00176713          	ori	a4,a4,1
ffffffffc020718c:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0207190:	4401                	li	s0,0
ffffffffc0207192:	fe06d0e3          	bgez	a3,ffffffffc0207172 <do_kill+0x42>
ffffffffc0207196:	f2878513          	addi	a0,a5,-216
ffffffffc020719a:	45a000ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
ffffffffc020719e:	60a2                	ld	ra,8(sp)
ffffffffc02071a0:	8522                	mv	a0,s0
ffffffffc02071a2:	6402                	ld	s0,0(sp)
ffffffffc02071a4:	0141                	addi	sp,sp,16
ffffffffc02071a6:	8082                	ret
ffffffffc02071a8:	545d                	li	s0,-9
ffffffffc02071aa:	b7e1                	j	ffffffffc0207172 <do_kill+0x42>

ffffffffc02071ac <proc_init>:
ffffffffc02071ac:	1101                	addi	sp,sp,-32
ffffffffc02071ae:	e426                	sd	s1,8(sp)
ffffffffc02071b0:	0008e797          	auipc	a5,0x8e
ffffffffc02071b4:	61078793          	addi	a5,a5,1552 # ffffffffc02957c0 <proc_list>
ffffffffc02071b8:	ec06                	sd	ra,24(sp)
ffffffffc02071ba:	e822                	sd	s0,16(sp)
ffffffffc02071bc:	e04a                	sd	s2,0(sp)
ffffffffc02071be:	0008a497          	auipc	s1,0x8a
ffffffffc02071c2:	60248493          	addi	s1,s1,1538 # ffffffffc02917c0 <hash_list>
ffffffffc02071c6:	e79c                	sd	a5,8(a5)
ffffffffc02071c8:	e39c                	sd	a5,0(a5)
ffffffffc02071ca:	0008e717          	auipc	a4,0x8e
ffffffffc02071ce:	5f670713          	addi	a4,a4,1526 # ffffffffc02957c0 <proc_list>
ffffffffc02071d2:	87a6                	mv	a5,s1
ffffffffc02071d4:	e79c                	sd	a5,8(a5)
ffffffffc02071d6:	e39c                	sd	a5,0(a5)
ffffffffc02071d8:	07c1                	addi	a5,a5,16
ffffffffc02071da:	fef71de3          	bne	a4,a5,ffffffffc02071d4 <proc_init+0x28>
ffffffffc02071de:	88ffe0ef          	jal	ra,ffffffffc0205a6c <alloc_proc>
ffffffffc02071e2:	0008f917          	auipc	s2,0x8f
ffffffffc02071e6:	6e690913          	addi	s2,s2,1766 # ffffffffc02968c8 <idleproc>
ffffffffc02071ea:	00a93023          	sd	a0,0(s2)
ffffffffc02071ee:	842a                	mv	s0,a0
ffffffffc02071f0:	12050863          	beqz	a0,ffffffffc0207320 <proc_init+0x174>
ffffffffc02071f4:	4789                	li	a5,2
ffffffffc02071f6:	e11c                	sd	a5,0(a0)
ffffffffc02071f8:	0000a797          	auipc	a5,0xa
ffffffffc02071fc:	e0878793          	addi	a5,a5,-504 # ffffffffc0211000 <bootstack>
ffffffffc0207200:	e91c                	sd	a5,16(a0)
ffffffffc0207202:	4785                	li	a5,1
ffffffffc0207204:	ed1c                	sd	a5,24(a0)
ffffffffc0207206:	860fe0ef          	jal	ra,ffffffffc0205266 <files_create>
ffffffffc020720a:	14a43423          	sd	a0,328(s0)
ffffffffc020720e:	0e050d63          	beqz	a0,ffffffffc0207308 <proc_init+0x15c>
ffffffffc0207212:	00093403          	ld	s0,0(s2)
ffffffffc0207216:	4641                	li	a2,16
ffffffffc0207218:	4581                	li	a1,0
ffffffffc020721a:	14843703          	ld	a4,328(s0)
ffffffffc020721e:	0b440413          	addi	s0,s0,180
ffffffffc0207222:	8522                	mv	a0,s0
ffffffffc0207224:	4b1c                	lw	a5,16(a4)
ffffffffc0207226:	2785                	addiw	a5,a5,1
ffffffffc0207228:	cb1c                	sw	a5,16(a4)
ffffffffc020722a:	5f0040ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc020722e:	463d                	li	a2,15
ffffffffc0207230:	00007597          	auipc	a1,0x7
ffffffffc0207234:	8a058593          	addi	a1,a1,-1888 # ffffffffc020dad0 <CSWTCH.79+0x388>
ffffffffc0207238:	8522                	mv	a0,s0
ffffffffc020723a:	632040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc020723e:	0008f717          	auipc	a4,0x8f
ffffffffc0207242:	69a70713          	addi	a4,a4,1690 # ffffffffc02968d8 <nr_process>
ffffffffc0207246:	431c                	lw	a5,0(a4)
ffffffffc0207248:	00093683          	ld	a3,0(s2)
ffffffffc020724c:	4601                	li	a2,0
ffffffffc020724e:	2785                	addiw	a5,a5,1
ffffffffc0207250:	4581                	li	a1,0
ffffffffc0207252:	fffff517          	auipc	a0,0xfffff
ffffffffc0207256:	20050513          	addi	a0,a0,512 # ffffffffc0206452 <init_main>
ffffffffc020725a:	c31c                	sw	a5,0(a4)
ffffffffc020725c:	0008f797          	auipc	a5,0x8f
ffffffffc0207260:	66d7b223          	sd	a3,1636(a5) # ffffffffc02968c0 <current>
ffffffffc0207264:	e6bfe0ef          	jal	ra,ffffffffc02060ce <kernel_thread>
ffffffffc0207268:	842a                	mv	s0,a0
ffffffffc020726a:	08a05363          	blez	a0,ffffffffc02072f0 <proc_init+0x144>
ffffffffc020726e:	6789                	lui	a5,0x2
ffffffffc0207270:	fff5071b          	addiw	a4,a0,-1
ffffffffc0207274:	17f9                	addi	a5,a5,-2
ffffffffc0207276:	2501                	sext.w	a0,a0
ffffffffc0207278:	02e7e363          	bltu	a5,a4,ffffffffc020729e <proc_init+0xf2>
ffffffffc020727c:	45a9                	li	a1,10
ffffffffc020727e:	068040ef          	jal	ra,ffffffffc020b2e6 <hash32>
ffffffffc0207282:	02051793          	slli	a5,a0,0x20
ffffffffc0207286:	01c7d693          	srli	a3,a5,0x1c
ffffffffc020728a:	96a6                	add	a3,a3,s1
ffffffffc020728c:	87b6                	mv	a5,a3
ffffffffc020728e:	a029                	j	ffffffffc0207298 <proc_init+0xec>
ffffffffc0207290:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0207294:	04870b63          	beq	a4,s0,ffffffffc02072ea <proc_init+0x13e>
ffffffffc0207298:	679c                	ld	a5,8(a5)
ffffffffc020729a:	fef69be3          	bne	a3,a5,ffffffffc0207290 <proc_init+0xe4>
ffffffffc020729e:	4781                	li	a5,0
ffffffffc02072a0:	0b478493          	addi	s1,a5,180
ffffffffc02072a4:	4641                	li	a2,16
ffffffffc02072a6:	4581                	li	a1,0
ffffffffc02072a8:	0008f417          	auipc	s0,0x8f
ffffffffc02072ac:	62840413          	addi	s0,s0,1576 # ffffffffc02968d0 <initproc>
ffffffffc02072b0:	8526                	mv	a0,s1
ffffffffc02072b2:	e01c                	sd	a5,0(s0)
ffffffffc02072b4:	566040ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc02072b8:	463d                	li	a2,15
ffffffffc02072ba:	00007597          	auipc	a1,0x7
ffffffffc02072be:	83e58593          	addi	a1,a1,-1986 # ffffffffc020daf8 <CSWTCH.79+0x3b0>
ffffffffc02072c2:	8526                	mv	a0,s1
ffffffffc02072c4:	5a8040ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc02072c8:	00093783          	ld	a5,0(s2)
ffffffffc02072cc:	c7d1                	beqz	a5,ffffffffc0207358 <proc_init+0x1ac>
ffffffffc02072ce:	43dc                	lw	a5,4(a5)
ffffffffc02072d0:	e7c1                	bnez	a5,ffffffffc0207358 <proc_init+0x1ac>
ffffffffc02072d2:	601c                	ld	a5,0(s0)
ffffffffc02072d4:	c3b5                	beqz	a5,ffffffffc0207338 <proc_init+0x18c>
ffffffffc02072d6:	43d8                	lw	a4,4(a5)
ffffffffc02072d8:	4785                	li	a5,1
ffffffffc02072da:	04f71f63          	bne	a4,a5,ffffffffc0207338 <proc_init+0x18c>
ffffffffc02072de:	60e2                	ld	ra,24(sp)
ffffffffc02072e0:	6442                	ld	s0,16(sp)
ffffffffc02072e2:	64a2                	ld	s1,8(sp)
ffffffffc02072e4:	6902                	ld	s2,0(sp)
ffffffffc02072e6:	6105                	addi	sp,sp,32
ffffffffc02072e8:	8082                	ret
ffffffffc02072ea:	f2878793          	addi	a5,a5,-216
ffffffffc02072ee:	bf4d                	j	ffffffffc02072a0 <proc_init+0xf4>
ffffffffc02072f0:	00006617          	auipc	a2,0x6
ffffffffc02072f4:	7e860613          	addi	a2,a2,2024 # ffffffffc020dad8 <CSWTCH.79+0x390>
ffffffffc02072f8:	53400593          	li	a1,1332
ffffffffc02072fc:	00006517          	auipc	a0,0x6
ffffffffc0207300:	53c50513          	addi	a0,a0,1340 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0207304:	99af90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207308:	00006617          	auipc	a2,0x6
ffffffffc020730c:	7a060613          	addi	a2,a2,1952 # ffffffffc020daa8 <CSWTCH.79+0x360>
ffffffffc0207310:	52800593          	li	a1,1320
ffffffffc0207314:	00006517          	auipc	a0,0x6
ffffffffc0207318:	52450513          	addi	a0,a0,1316 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc020731c:	982f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207320:	00006617          	auipc	a2,0x6
ffffffffc0207324:	77060613          	addi	a2,a2,1904 # ffffffffc020da90 <CSWTCH.79+0x348>
ffffffffc0207328:	51e00593          	li	a1,1310
ffffffffc020732c:	00006517          	auipc	a0,0x6
ffffffffc0207330:	50c50513          	addi	a0,a0,1292 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0207334:	96af90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207338:	00006697          	auipc	a3,0x6
ffffffffc020733c:	7f068693          	addi	a3,a3,2032 # ffffffffc020db28 <CSWTCH.79+0x3e0>
ffffffffc0207340:	00005617          	auipc	a2,0x5
ffffffffc0207344:	9c060613          	addi	a2,a2,-1600 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207348:	53b00593          	li	a1,1339
ffffffffc020734c:	00006517          	auipc	a0,0x6
ffffffffc0207350:	4ec50513          	addi	a0,a0,1260 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0207354:	94af90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207358:	00006697          	auipc	a3,0x6
ffffffffc020735c:	7a868693          	addi	a3,a3,1960 # ffffffffc020db00 <CSWTCH.79+0x3b8>
ffffffffc0207360:	00005617          	auipc	a2,0x5
ffffffffc0207364:	9a060613          	addi	a2,a2,-1632 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207368:	53a00593          	li	a1,1338
ffffffffc020736c:	00006517          	auipc	a0,0x6
ffffffffc0207370:	4cc50513          	addi	a0,a0,1228 # ffffffffc020d838 <CSWTCH.79+0xf0>
ffffffffc0207374:	92af90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207378 <cpu_idle>:
ffffffffc0207378:	1141                	addi	sp,sp,-16
ffffffffc020737a:	e022                	sd	s0,0(sp)
ffffffffc020737c:	e406                	sd	ra,8(sp)
ffffffffc020737e:	0008f417          	auipc	s0,0x8f
ffffffffc0207382:	54240413          	addi	s0,s0,1346 # ffffffffc02968c0 <current>
ffffffffc0207386:	6018                	ld	a4,0(s0)
ffffffffc0207388:	6f1c                	ld	a5,24(a4)
ffffffffc020738a:	dffd                	beqz	a5,ffffffffc0207388 <cpu_idle+0x10>
ffffffffc020738c:	31a000ef          	jal	ra,ffffffffc02076a6 <schedule>
ffffffffc0207390:	bfdd                	j	ffffffffc0207386 <cpu_idle+0xe>

ffffffffc0207392 <lab6_set_priority>:
ffffffffc0207392:	1141                	addi	sp,sp,-16
ffffffffc0207394:	e022                	sd	s0,0(sp)
ffffffffc0207396:	85aa                	mv	a1,a0
ffffffffc0207398:	842a                	mv	s0,a0
ffffffffc020739a:	00006517          	auipc	a0,0x6
ffffffffc020739e:	7b650513          	addi	a0,a0,1974 # ffffffffc020db50 <CSWTCH.79+0x408>
ffffffffc02073a2:	e406                	sd	ra,8(sp)
ffffffffc02073a4:	e03f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02073a8:	0008f797          	auipc	a5,0x8f
ffffffffc02073ac:	5187b783          	ld	a5,1304(a5) # ffffffffc02968c0 <current>
ffffffffc02073b0:	e801                	bnez	s0,ffffffffc02073c0 <lab6_set_priority+0x2e>
ffffffffc02073b2:	60a2                	ld	ra,8(sp)
ffffffffc02073b4:	6402                	ld	s0,0(sp)
ffffffffc02073b6:	4705                	li	a4,1
ffffffffc02073b8:	14e7a223          	sw	a4,324(a5)
ffffffffc02073bc:	0141                	addi	sp,sp,16
ffffffffc02073be:	8082                	ret
ffffffffc02073c0:	60a2                	ld	ra,8(sp)
ffffffffc02073c2:	1487a223          	sw	s0,324(a5)
ffffffffc02073c6:	6402                	ld	s0,0(sp)
ffffffffc02073c8:	0141                	addi	sp,sp,16
ffffffffc02073ca:	8082                	ret

ffffffffc02073cc <do_sleep>:
ffffffffc02073cc:	c539                	beqz	a0,ffffffffc020741a <do_sleep+0x4e>
ffffffffc02073ce:	7179                	addi	sp,sp,-48
ffffffffc02073d0:	f022                	sd	s0,32(sp)
ffffffffc02073d2:	f406                	sd	ra,40(sp)
ffffffffc02073d4:	842a                	mv	s0,a0
ffffffffc02073d6:	100027f3          	csrr	a5,sstatus
ffffffffc02073da:	8b89                	andi	a5,a5,2
ffffffffc02073dc:	e3a9                	bnez	a5,ffffffffc020741e <do_sleep+0x52>
ffffffffc02073de:	0008f797          	auipc	a5,0x8f
ffffffffc02073e2:	4e27b783          	ld	a5,1250(a5) # ffffffffc02968c0 <current>
ffffffffc02073e6:	0818                	addi	a4,sp,16
ffffffffc02073e8:	c02a                	sw	a0,0(sp)
ffffffffc02073ea:	ec3a                	sd	a4,24(sp)
ffffffffc02073ec:	e83a                	sd	a4,16(sp)
ffffffffc02073ee:	e43e                	sd	a5,8(sp)
ffffffffc02073f0:	4705                	li	a4,1
ffffffffc02073f2:	c398                	sw	a4,0(a5)
ffffffffc02073f4:	80000737          	lui	a4,0x80000
ffffffffc02073f8:	840a                	mv	s0,sp
ffffffffc02073fa:	0709                	addi	a4,a4,2
ffffffffc02073fc:	0ee7a623          	sw	a4,236(a5)
ffffffffc0207400:	8522                	mv	a0,s0
ffffffffc0207402:	364000ef          	jal	ra,ffffffffc0207766 <add_timer>
ffffffffc0207406:	2a0000ef          	jal	ra,ffffffffc02076a6 <schedule>
ffffffffc020740a:	8522                	mv	a0,s0
ffffffffc020740c:	422000ef          	jal	ra,ffffffffc020782e <del_timer>
ffffffffc0207410:	70a2                	ld	ra,40(sp)
ffffffffc0207412:	7402                	ld	s0,32(sp)
ffffffffc0207414:	4501                	li	a0,0
ffffffffc0207416:	6145                	addi	sp,sp,48
ffffffffc0207418:	8082                	ret
ffffffffc020741a:	4501                	li	a0,0
ffffffffc020741c:	8082                	ret
ffffffffc020741e:	855f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207422:	0008f797          	auipc	a5,0x8f
ffffffffc0207426:	49e7b783          	ld	a5,1182(a5) # ffffffffc02968c0 <current>
ffffffffc020742a:	0818                	addi	a4,sp,16
ffffffffc020742c:	c022                	sw	s0,0(sp)
ffffffffc020742e:	e43e                	sd	a5,8(sp)
ffffffffc0207430:	ec3a                	sd	a4,24(sp)
ffffffffc0207432:	e83a                	sd	a4,16(sp)
ffffffffc0207434:	4705                	li	a4,1
ffffffffc0207436:	c398                	sw	a4,0(a5)
ffffffffc0207438:	80000737          	lui	a4,0x80000
ffffffffc020743c:	0709                	addi	a4,a4,2
ffffffffc020743e:	840a                	mv	s0,sp
ffffffffc0207440:	8522                	mv	a0,s0
ffffffffc0207442:	0ee7a623          	sw	a4,236(a5)
ffffffffc0207446:	320000ef          	jal	ra,ffffffffc0207766 <add_timer>
ffffffffc020744a:	823f90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020744e:	bf65                	j	ffffffffc0207406 <do_sleep+0x3a>

ffffffffc0207450 <switch_to>:
ffffffffc0207450:	00153023          	sd	ra,0(a0)
ffffffffc0207454:	00253423          	sd	sp,8(a0)
ffffffffc0207458:	e900                	sd	s0,16(a0)
ffffffffc020745a:	ed04                	sd	s1,24(a0)
ffffffffc020745c:	03253023          	sd	s2,32(a0)
ffffffffc0207460:	03353423          	sd	s3,40(a0)
ffffffffc0207464:	03453823          	sd	s4,48(a0)
ffffffffc0207468:	03553c23          	sd	s5,56(a0)
ffffffffc020746c:	05653023          	sd	s6,64(a0)
ffffffffc0207470:	05753423          	sd	s7,72(a0)
ffffffffc0207474:	05853823          	sd	s8,80(a0)
ffffffffc0207478:	05953c23          	sd	s9,88(a0)
ffffffffc020747c:	07a53023          	sd	s10,96(a0)
ffffffffc0207480:	07b53423          	sd	s11,104(a0)
ffffffffc0207484:	0005b083          	ld	ra,0(a1)
ffffffffc0207488:	0085b103          	ld	sp,8(a1)
ffffffffc020748c:	6980                	ld	s0,16(a1)
ffffffffc020748e:	6d84                	ld	s1,24(a1)
ffffffffc0207490:	0205b903          	ld	s2,32(a1)
ffffffffc0207494:	0285b983          	ld	s3,40(a1)
ffffffffc0207498:	0305ba03          	ld	s4,48(a1)
ffffffffc020749c:	0385ba83          	ld	s5,56(a1)
ffffffffc02074a0:	0405bb03          	ld	s6,64(a1)
ffffffffc02074a4:	0485bb83          	ld	s7,72(a1)
ffffffffc02074a8:	0505bc03          	ld	s8,80(a1)
ffffffffc02074ac:	0585bc83          	ld	s9,88(a1)
ffffffffc02074b0:	0605bd03          	ld	s10,96(a1)
ffffffffc02074b4:	0685bd83          	ld	s11,104(a1)
ffffffffc02074b8:	8082                	ret

ffffffffc02074ba <RR_init>:
ffffffffc02074ba:	e508                	sd	a0,8(a0)
ffffffffc02074bc:	e108                	sd	a0,0(a0)
ffffffffc02074be:	00052823          	sw	zero,16(a0)
ffffffffc02074c2:	8082                	ret

ffffffffc02074c4 <RR_pick_next>:
ffffffffc02074c4:	651c                	ld	a5,8(a0)
ffffffffc02074c6:	00f50563          	beq	a0,a5,ffffffffc02074d0 <RR_pick_next+0xc>
ffffffffc02074ca:	ef078513          	addi	a0,a5,-272
ffffffffc02074ce:	8082                	ret
ffffffffc02074d0:	4501                	li	a0,0
ffffffffc02074d2:	8082                	ret

ffffffffc02074d4 <RR_proc_tick>:
ffffffffc02074d4:	1205a783          	lw	a5,288(a1)
ffffffffc02074d8:	00f05563          	blez	a5,ffffffffc02074e2 <RR_proc_tick+0xe>
ffffffffc02074dc:	37fd                	addiw	a5,a5,-1
ffffffffc02074de:	12f5a023          	sw	a5,288(a1)
ffffffffc02074e2:	e399                	bnez	a5,ffffffffc02074e8 <RR_proc_tick+0x14>
ffffffffc02074e4:	4785                	li	a5,1
ffffffffc02074e6:	ed9c                	sd	a5,24(a1)
ffffffffc02074e8:	8082                	ret

ffffffffc02074ea <RR_dequeue>:
ffffffffc02074ea:	1185b703          	ld	a4,280(a1)
ffffffffc02074ee:	11058793          	addi	a5,a1,272
ffffffffc02074f2:	02e78363          	beq	a5,a4,ffffffffc0207518 <RR_dequeue+0x2e>
ffffffffc02074f6:	1085b683          	ld	a3,264(a1)
ffffffffc02074fa:	00a69f63          	bne	a3,a0,ffffffffc0207518 <RR_dequeue+0x2e>
ffffffffc02074fe:	1105b503          	ld	a0,272(a1)
ffffffffc0207502:	4a90                	lw	a2,16(a3)
ffffffffc0207504:	e518                	sd	a4,8(a0)
ffffffffc0207506:	e308                	sd	a0,0(a4)
ffffffffc0207508:	10f5bc23          	sd	a5,280(a1)
ffffffffc020750c:	10f5b823          	sd	a5,272(a1)
ffffffffc0207510:	fff6079b          	addiw	a5,a2,-1
ffffffffc0207514:	ca9c                	sw	a5,16(a3)
ffffffffc0207516:	8082                	ret
ffffffffc0207518:	1141                	addi	sp,sp,-16
ffffffffc020751a:	00006697          	auipc	a3,0x6
ffffffffc020751e:	64e68693          	addi	a3,a3,1614 # ffffffffc020db68 <CSWTCH.79+0x420>
ffffffffc0207522:	00004617          	auipc	a2,0x4
ffffffffc0207526:	7de60613          	addi	a2,a2,2014 # ffffffffc020bd00 <commands+0x210>
ffffffffc020752a:	03c00593          	li	a1,60
ffffffffc020752e:	00006517          	auipc	a0,0x6
ffffffffc0207532:	67250513          	addi	a0,a0,1650 # ffffffffc020dba0 <CSWTCH.79+0x458>
ffffffffc0207536:	e406                	sd	ra,8(sp)
ffffffffc0207538:	f67f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020753c <RR_enqueue>:
ffffffffc020753c:	1185b703          	ld	a4,280(a1)
ffffffffc0207540:	11058793          	addi	a5,a1,272
ffffffffc0207544:	02e79d63          	bne	a5,a4,ffffffffc020757e <RR_enqueue+0x42>
ffffffffc0207548:	6118                	ld	a4,0(a0)
ffffffffc020754a:	1205a683          	lw	a3,288(a1)
ffffffffc020754e:	e11c                	sd	a5,0(a0)
ffffffffc0207550:	e71c                	sd	a5,8(a4)
ffffffffc0207552:	10a5bc23          	sd	a0,280(a1)
ffffffffc0207556:	10e5b823          	sd	a4,272(a1)
ffffffffc020755a:	495c                	lw	a5,20(a0)
ffffffffc020755c:	ea89                	bnez	a3,ffffffffc020756e <RR_enqueue+0x32>
ffffffffc020755e:	12f5a023          	sw	a5,288(a1)
ffffffffc0207562:	491c                	lw	a5,16(a0)
ffffffffc0207564:	10a5b423          	sd	a0,264(a1)
ffffffffc0207568:	2785                	addiw	a5,a5,1
ffffffffc020756a:	c91c                	sw	a5,16(a0)
ffffffffc020756c:	8082                	ret
ffffffffc020756e:	fed7c8e3          	blt	a5,a3,ffffffffc020755e <RR_enqueue+0x22>
ffffffffc0207572:	491c                	lw	a5,16(a0)
ffffffffc0207574:	10a5b423          	sd	a0,264(a1)
ffffffffc0207578:	2785                	addiw	a5,a5,1
ffffffffc020757a:	c91c                	sw	a5,16(a0)
ffffffffc020757c:	8082                	ret
ffffffffc020757e:	1141                	addi	sp,sp,-16
ffffffffc0207580:	00006697          	auipc	a3,0x6
ffffffffc0207584:	64068693          	addi	a3,a3,1600 # ffffffffc020dbc0 <CSWTCH.79+0x478>
ffffffffc0207588:	00004617          	auipc	a2,0x4
ffffffffc020758c:	77860613          	addi	a2,a2,1912 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207590:	02800593          	li	a1,40
ffffffffc0207594:	00006517          	auipc	a0,0x6
ffffffffc0207598:	60c50513          	addi	a0,a0,1548 # ffffffffc020dba0 <CSWTCH.79+0x458>
ffffffffc020759c:	e406                	sd	ra,8(sp)
ffffffffc020759e:	f01f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02075a2 <sched_init>:
ffffffffc02075a2:	1141                	addi	sp,sp,-16
ffffffffc02075a4:	0008a717          	auipc	a4,0x8a
ffffffffc02075a8:	a7c70713          	addi	a4,a4,-1412 # ffffffffc0291020 <default_sched_class>
ffffffffc02075ac:	e022                	sd	s0,0(sp)
ffffffffc02075ae:	e406                	sd	ra,8(sp)
ffffffffc02075b0:	0008e797          	auipc	a5,0x8e
ffffffffc02075b4:	24078793          	addi	a5,a5,576 # ffffffffc02957f0 <timer_list>
ffffffffc02075b8:	6714                	ld	a3,8(a4)
ffffffffc02075ba:	0008e517          	auipc	a0,0x8e
ffffffffc02075be:	21650513          	addi	a0,a0,534 # ffffffffc02957d0 <__rq>
ffffffffc02075c2:	e79c                	sd	a5,8(a5)
ffffffffc02075c4:	e39c                	sd	a5,0(a5)
ffffffffc02075c6:	4795                	li	a5,5
ffffffffc02075c8:	c95c                	sw	a5,20(a0)
ffffffffc02075ca:	0008f417          	auipc	s0,0x8f
ffffffffc02075ce:	31e40413          	addi	s0,s0,798 # ffffffffc02968e8 <sched_class>
ffffffffc02075d2:	0008f797          	auipc	a5,0x8f
ffffffffc02075d6:	30a7b723          	sd	a0,782(a5) # ffffffffc02968e0 <rq>
ffffffffc02075da:	e018                	sd	a4,0(s0)
ffffffffc02075dc:	9682                	jalr	a3
ffffffffc02075de:	601c                	ld	a5,0(s0)
ffffffffc02075e0:	6402                	ld	s0,0(sp)
ffffffffc02075e2:	60a2                	ld	ra,8(sp)
ffffffffc02075e4:	638c                	ld	a1,0(a5)
ffffffffc02075e6:	00006517          	auipc	a0,0x6
ffffffffc02075ea:	60a50513          	addi	a0,a0,1546 # ffffffffc020dbf0 <CSWTCH.79+0x4a8>
ffffffffc02075ee:	0141                	addi	sp,sp,16
ffffffffc02075f0:	bb7f806f          	j	ffffffffc02001a6 <cprintf>

ffffffffc02075f4 <wakeup_proc>:
ffffffffc02075f4:	4118                	lw	a4,0(a0)
ffffffffc02075f6:	1101                	addi	sp,sp,-32
ffffffffc02075f8:	ec06                	sd	ra,24(sp)
ffffffffc02075fa:	e822                	sd	s0,16(sp)
ffffffffc02075fc:	e426                	sd	s1,8(sp)
ffffffffc02075fe:	478d                	li	a5,3
ffffffffc0207600:	08f70363          	beq	a4,a5,ffffffffc0207686 <wakeup_proc+0x92>
ffffffffc0207604:	842a                	mv	s0,a0
ffffffffc0207606:	100027f3          	csrr	a5,sstatus
ffffffffc020760a:	8b89                	andi	a5,a5,2
ffffffffc020760c:	4481                	li	s1,0
ffffffffc020760e:	e7bd                	bnez	a5,ffffffffc020767c <wakeup_proc+0x88>
ffffffffc0207610:	4789                	li	a5,2
ffffffffc0207612:	04f70863          	beq	a4,a5,ffffffffc0207662 <wakeup_proc+0x6e>
ffffffffc0207616:	c01c                	sw	a5,0(s0)
ffffffffc0207618:	0e042623          	sw	zero,236(s0)
ffffffffc020761c:	0008f797          	auipc	a5,0x8f
ffffffffc0207620:	2a47b783          	ld	a5,676(a5) # ffffffffc02968c0 <current>
ffffffffc0207624:	02878363          	beq	a5,s0,ffffffffc020764a <wakeup_proc+0x56>
ffffffffc0207628:	0008f797          	auipc	a5,0x8f
ffffffffc020762c:	2a07b783          	ld	a5,672(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207630:	00f40d63          	beq	s0,a5,ffffffffc020764a <wakeup_proc+0x56>
ffffffffc0207634:	0008f797          	auipc	a5,0x8f
ffffffffc0207638:	2b47b783          	ld	a5,692(a5) # ffffffffc02968e8 <sched_class>
ffffffffc020763c:	6b9c                	ld	a5,16(a5)
ffffffffc020763e:	85a2                	mv	a1,s0
ffffffffc0207640:	0008f517          	auipc	a0,0x8f
ffffffffc0207644:	2a053503          	ld	a0,672(a0) # ffffffffc02968e0 <rq>
ffffffffc0207648:	9782                	jalr	a5
ffffffffc020764a:	e491                	bnez	s1,ffffffffc0207656 <wakeup_proc+0x62>
ffffffffc020764c:	60e2                	ld	ra,24(sp)
ffffffffc020764e:	6442                	ld	s0,16(sp)
ffffffffc0207650:	64a2                	ld	s1,8(sp)
ffffffffc0207652:	6105                	addi	sp,sp,32
ffffffffc0207654:	8082                	ret
ffffffffc0207656:	6442                	ld	s0,16(sp)
ffffffffc0207658:	60e2                	ld	ra,24(sp)
ffffffffc020765a:	64a2                	ld	s1,8(sp)
ffffffffc020765c:	6105                	addi	sp,sp,32
ffffffffc020765e:	e0ef906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207662:	00006617          	auipc	a2,0x6
ffffffffc0207666:	5de60613          	addi	a2,a2,1502 # ffffffffc020dc40 <CSWTCH.79+0x4f8>
ffffffffc020766a:	05200593          	li	a1,82
ffffffffc020766e:	00006517          	auipc	a0,0x6
ffffffffc0207672:	5ba50513          	addi	a0,a0,1466 # ffffffffc020dc28 <CSWTCH.79+0x4e0>
ffffffffc0207676:	e91f80ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020767a:	bfc1                	j	ffffffffc020764a <wakeup_proc+0x56>
ffffffffc020767c:	df6f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207680:	4018                	lw	a4,0(s0)
ffffffffc0207682:	4485                	li	s1,1
ffffffffc0207684:	b771                	j	ffffffffc0207610 <wakeup_proc+0x1c>
ffffffffc0207686:	00006697          	auipc	a3,0x6
ffffffffc020768a:	58268693          	addi	a3,a3,1410 # ffffffffc020dc08 <CSWTCH.79+0x4c0>
ffffffffc020768e:	00004617          	auipc	a2,0x4
ffffffffc0207692:	67260613          	addi	a2,a2,1650 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207696:	04300593          	li	a1,67
ffffffffc020769a:	00006517          	auipc	a0,0x6
ffffffffc020769e:	58e50513          	addi	a0,a0,1422 # ffffffffc020dc28 <CSWTCH.79+0x4e0>
ffffffffc02076a2:	dfdf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076a6 <schedule>:
ffffffffc02076a6:	7179                	addi	sp,sp,-48
ffffffffc02076a8:	f406                	sd	ra,40(sp)
ffffffffc02076aa:	f022                	sd	s0,32(sp)
ffffffffc02076ac:	ec26                	sd	s1,24(sp)
ffffffffc02076ae:	e84a                	sd	s2,16(sp)
ffffffffc02076b0:	e44e                	sd	s3,8(sp)
ffffffffc02076b2:	e052                	sd	s4,0(sp)
ffffffffc02076b4:	100027f3          	csrr	a5,sstatus
ffffffffc02076b8:	8b89                	andi	a5,a5,2
ffffffffc02076ba:	4a01                	li	s4,0
ffffffffc02076bc:	e3cd                	bnez	a5,ffffffffc020775e <schedule+0xb8>
ffffffffc02076be:	0008f497          	auipc	s1,0x8f
ffffffffc02076c2:	20248493          	addi	s1,s1,514 # ffffffffc02968c0 <current>
ffffffffc02076c6:	608c                	ld	a1,0(s1)
ffffffffc02076c8:	0008f997          	auipc	s3,0x8f
ffffffffc02076cc:	22098993          	addi	s3,s3,544 # ffffffffc02968e8 <sched_class>
ffffffffc02076d0:	0008f917          	auipc	s2,0x8f
ffffffffc02076d4:	21090913          	addi	s2,s2,528 # ffffffffc02968e0 <rq>
ffffffffc02076d8:	4194                	lw	a3,0(a1)
ffffffffc02076da:	0005bc23          	sd	zero,24(a1)
ffffffffc02076de:	4709                	li	a4,2
ffffffffc02076e0:	0009b783          	ld	a5,0(s3)
ffffffffc02076e4:	00093503          	ld	a0,0(s2)
ffffffffc02076e8:	04e68e63          	beq	a3,a4,ffffffffc0207744 <schedule+0x9e>
ffffffffc02076ec:	739c                	ld	a5,32(a5)
ffffffffc02076ee:	9782                	jalr	a5
ffffffffc02076f0:	842a                	mv	s0,a0
ffffffffc02076f2:	c521                	beqz	a0,ffffffffc020773a <schedule+0x94>
ffffffffc02076f4:	0009b783          	ld	a5,0(s3)
ffffffffc02076f8:	00093503          	ld	a0,0(s2)
ffffffffc02076fc:	85a2                	mv	a1,s0
ffffffffc02076fe:	6f9c                	ld	a5,24(a5)
ffffffffc0207700:	9782                	jalr	a5
ffffffffc0207702:	441c                	lw	a5,8(s0)
ffffffffc0207704:	6098                	ld	a4,0(s1)
ffffffffc0207706:	2785                	addiw	a5,a5,1
ffffffffc0207708:	c41c                	sw	a5,8(s0)
ffffffffc020770a:	00870563          	beq	a4,s0,ffffffffc0207714 <schedule+0x6e>
ffffffffc020770e:	8522                	mv	a0,s0
ffffffffc0207710:	ccefe0ef          	jal	ra,ffffffffc0205bde <proc_run>
ffffffffc0207714:	000a1a63          	bnez	s4,ffffffffc0207728 <schedule+0x82>
ffffffffc0207718:	70a2                	ld	ra,40(sp)
ffffffffc020771a:	7402                	ld	s0,32(sp)
ffffffffc020771c:	64e2                	ld	s1,24(sp)
ffffffffc020771e:	6942                	ld	s2,16(sp)
ffffffffc0207720:	69a2                	ld	s3,8(sp)
ffffffffc0207722:	6a02                	ld	s4,0(sp)
ffffffffc0207724:	6145                	addi	sp,sp,48
ffffffffc0207726:	8082                	ret
ffffffffc0207728:	7402                	ld	s0,32(sp)
ffffffffc020772a:	70a2                	ld	ra,40(sp)
ffffffffc020772c:	64e2                	ld	s1,24(sp)
ffffffffc020772e:	6942                	ld	s2,16(sp)
ffffffffc0207730:	69a2                	ld	s3,8(sp)
ffffffffc0207732:	6a02                	ld	s4,0(sp)
ffffffffc0207734:	6145                	addi	sp,sp,48
ffffffffc0207736:	d36f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020773a:	0008f417          	auipc	s0,0x8f
ffffffffc020773e:	18e43403          	ld	s0,398(s0) # ffffffffc02968c8 <idleproc>
ffffffffc0207742:	b7c1                	j	ffffffffc0207702 <schedule+0x5c>
ffffffffc0207744:	0008f717          	auipc	a4,0x8f
ffffffffc0207748:	18473703          	ld	a4,388(a4) # ffffffffc02968c8 <idleproc>
ffffffffc020774c:	fae580e3          	beq	a1,a4,ffffffffc02076ec <schedule+0x46>
ffffffffc0207750:	6b9c                	ld	a5,16(a5)
ffffffffc0207752:	9782                	jalr	a5
ffffffffc0207754:	0009b783          	ld	a5,0(s3)
ffffffffc0207758:	00093503          	ld	a0,0(s2)
ffffffffc020775c:	bf41                	j	ffffffffc02076ec <schedule+0x46>
ffffffffc020775e:	d14f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207762:	4a05                	li	s4,1
ffffffffc0207764:	bfa9                	j	ffffffffc02076be <schedule+0x18>

ffffffffc0207766 <add_timer>:
ffffffffc0207766:	1141                	addi	sp,sp,-16
ffffffffc0207768:	e022                	sd	s0,0(sp)
ffffffffc020776a:	e406                	sd	ra,8(sp)
ffffffffc020776c:	842a                	mv	s0,a0
ffffffffc020776e:	100027f3          	csrr	a5,sstatus
ffffffffc0207772:	8b89                	andi	a5,a5,2
ffffffffc0207774:	4501                	li	a0,0
ffffffffc0207776:	eba5                	bnez	a5,ffffffffc02077e6 <add_timer+0x80>
ffffffffc0207778:	401c                	lw	a5,0(s0)
ffffffffc020777a:	cbb5                	beqz	a5,ffffffffc02077ee <add_timer+0x88>
ffffffffc020777c:	6418                	ld	a4,8(s0)
ffffffffc020777e:	cb25                	beqz	a4,ffffffffc02077ee <add_timer+0x88>
ffffffffc0207780:	6c18                	ld	a4,24(s0)
ffffffffc0207782:	01040593          	addi	a1,s0,16
ffffffffc0207786:	08e59463          	bne	a1,a4,ffffffffc020780e <add_timer+0xa8>
ffffffffc020778a:	0008e617          	auipc	a2,0x8e
ffffffffc020778e:	06660613          	addi	a2,a2,102 # ffffffffc02957f0 <timer_list>
ffffffffc0207792:	6618                	ld	a4,8(a2)
ffffffffc0207794:	00c71863          	bne	a4,a2,ffffffffc02077a4 <add_timer+0x3e>
ffffffffc0207798:	a80d                	j	ffffffffc02077ca <add_timer+0x64>
ffffffffc020779a:	6718                	ld	a4,8(a4)
ffffffffc020779c:	9f95                	subw	a5,a5,a3
ffffffffc020779e:	c01c                	sw	a5,0(s0)
ffffffffc02077a0:	02c70563          	beq	a4,a2,ffffffffc02077ca <add_timer+0x64>
ffffffffc02077a4:	ff072683          	lw	a3,-16(a4)
ffffffffc02077a8:	fed7f9e3          	bgeu	a5,a3,ffffffffc020779a <add_timer+0x34>
ffffffffc02077ac:	40f687bb          	subw	a5,a3,a5
ffffffffc02077b0:	fef72823          	sw	a5,-16(a4)
ffffffffc02077b4:	631c                	ld	a5,0(a4)
ffffffffc02077b6:	e30c                	sd	a1,0(a4)
ffffffffc02077b8:	e78c                	sd	a1,8(a5)
ffffffffc02077ba:	ec18                	sd	a4,24(s0)
ffffffffc02077bc:	e81c                	sd	a5,16(s0)
ffffffffc02077be:	c105                	beqz	a0,ffffffffc02077de <add_timer+0x78>
ffffffffc02077c0:	6402                	ld	s0,0(sp)
ffffffffc02077c2:	60a2                	ld	ra,8(sp)
ffffffffc02077c4:	0141                	addi	sp,sp,16
ffffffffc02077c6:	ca6f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02077ca:	0008e717          	auipc	a4,0x8e
ffffffffc02077ce:	02670713          	addi	a4,a4,38 # ffffffffc02957f0 <timer_list>
ffffffffc02077d2:	631c                	ld	a5,0(a4)
ffffffffc02077d4:	e30c                	sd	a1,0(a4)
ffffffffc02077d6:	e78c                	sd	a1,8(a5)
ffffffffc02077d8:	ec18                	sd	a4,24(s0)
ffffffffc02077da:	e81c                	sd	a5,16(s0)
ffffffffc02077dc:	f175                	bnez	a0,ffffffffc02077c0 <add_timer+0x5a>
ffffffffc02077de:	60a2                	ld	ra,8(sp)
ffffffffc02077e0:	6402                	ld	s0,0(sp)
ffffffffc02077e2:	0141                	addi	sp,sp,16
ffffffffc02077e4:	8082                	ret
ffffffffc02077e6:	c8cf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02077ea:	4505                	li	a0,1
ffffffffc02077ec:	b771                	j	ffffffffc0207778 <add_timer+0x12>
ffffffffc02077ee:	00006697          	auipc	a3,0x6
ffffffffc02077f2:	47268693          	addi	a3,a3,1138 # ffffffffc020dc60 <CSWTCH.79+0x518>
ffffffffc02077f6:	00004617          	auipc	a2,0x4
ffffffffc02077fa:	50a60613          	addi	a2,a2,1290 # ffffffffc020bd00 <commands+0x210>
ffffffffc02077fe:	07a00593          	li	a1,122
ffffffffc0207802:	00006517          	auipc	a0,0x6
ffffffffc0207806:	42650513          	addi	a0,a0,1062 # ffffffffc020dc28 <CSWTCH.79+0x4e0>
ffffffffc020780a:	c95f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020780e:	00006697          	auipc	a3,0x6
ffffffffc0207812:	48268693          	addi	a3,a3,1154 # ffffffffc020dc90 <CSWTCH.79+0x548>
ffffffffc0207816:	00004617          	auipc	a2,0x4
ffffffffc020781a:	4ea60613          	addi	a2,a2,1258 # ffffffffc020bd00 <commands+0x210>
ffffffffc020781e:	07b00593          	li	a1,123
ffffffffc0207822:	00006517          	auipc	a0,0x6
ffffffffc0207826:	40650513          	addi	a0,a0,1030 # ffffffffc020dc28 <CSWTCH.79+0x4e0>
ffffffffc020782a:	c75f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020782e <del_timer>:
ffffffffc020782e:	1101                	addi	sp,sp,-32
ffffffffc0207830:	e822                	sd	s0,16(sp)
ffffffffc0207832:	ec06                	sd	ra,24(sp)
ffffffffc0207834:	e426                	sd	s1,8(sp)
ffffffffc0207836:	842a                	mv	s0,a0
ffffffffc0207838:	100027f3          	csrr	a5,sstatus
ffffffffc020783c:	8b89                	andi	a5,a5,2
ffffffffc020783e:	01050493          	addi	s1,a0,16
ffffffffc0207842:	eb9d                	bnez	a5,ffffffffc0207878 <del_timer+0x4a>
ffffffffc0207844:	6d1c                	ld	a5,24(a0)
ffffffffc0207846:	02978463          	beq	a5,s1,ffffffffc020786e <del_timer+0x40>
ffffffffc020784a:	4114                	lw	a3,0(a0)
ffffffffc020784c:	6918                	ld	a4,16(a0)
ffffffffc020784e:	ce81                	beqz	a3,ffffffffc0207866 <del_timer+0x38>
ffffffffc0207850:	0008e617          	auipc	a2,0x8e
ffffffffc0207854:	fa060613          	addi	a2,a2,-96 # ffffffffc02957f0 <timer_list>
ffffffffc0207858:	00c78763          	beq	a5,a2,ffffffffc0207866 <del_timer+0x38>
ffffffffc020785c:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207860:	9eb1                	addw	a3,a3,a2
ffffffffc0207862:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207866:	e71c                	sd	a5,8(a4)
ffffffffc0207868:	e398                	sd	a4,0(a5)
ffffffffc020786a:	ec04                	sd	s1,24(s0)
ffffffffc020786c:	e804                	sd	s1,16(s0)
ffffffffc020786e:	60e2                	ld	ra,24(sp)
ffffffffc0207870:	6442                	ld	s0,16(sp)
ffffffffc0207872:	64a2                	ld	s1,8(sp)
ffffffffc0207874:	6105                	addi	sp,sp,32
ffffffffc0207876:	8082                	ret
ffffffffc0207878:	bfaf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020787c:	6c1c                	ld	a5,24(s0)
ffffffffc020787e:	02978463          	beq	a5,s1,ffffffffc02078a6 <del_timer+0x78>
ffffffffc0207882:	4014                	lw	a3,0(s0)
ffffffffc0207884:	6818                	ld	a4,16(s0)
ffffffffc0207886:	ce81                	beqz	a3,ffffffffc020789e <del_timer+0x70>
ffffffffc0207888:	0008e617          	auipc	a2,0x8e
ffffffffc020788c:	f6860613          	addi	a2,a2,-152 # ffffffffc02957f0 <timer_list>
ffffffffc0207890:	00c78763          	beq	a5,a2,ffffffffc020789e <del_timer+0x70>
ffffffffc0207894:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207898:	9eb1                	addw	a3,a3,a2
ffffffffc020789a:	fed7a823          	sw	a3,-16(a5)
ffffffffc020789e:	e71c                	sd	a5,8(a4)
ffffffffc02078a0:	e398                	sd	a4,0(a5)
ffffffffc02078a2:	ec04                	sd	s1,24(s0)
ffffffffc02078a4:	e804                	sd	s1,16(s0)
ffffffffc02078a6:	6442                	ld	s0,16(sp)
ffffffffc02078a8:	60e2                	ld	ra,24(sp)
ffffffffc02078aa:	64a2                	ld	s1,8(sp)
ffffffffc02078ac:	6105                	addi	sp,sp,32
ffffffffc02078ae:	bbef906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02078b2 <run_timer_list>:
ffffffffc02078b2:	7139                	addi	sp,sp,-64
ffffffffc02078b4:	fc06                	sd	ra,56(sp)
ffffffffc02078b6:	f822                	sd	s0,48(sp)
ffffffffc02078b8:	f426                	sd	s1,40(sp)
ffffffffc02078ba:	f04a                	sd	s2,32(sp)
ffffffffc02078bc:	ec4e                	sd	s3,24(sp)
ffffffffc02078be:	e852                	sd	s4,16(sp)
ffffffffc02078c0:	e456                	sd	s5,8(sp)
ffffffffc02078c2:	e05a                	sd	s6,0(sp)
ffffffffc02078c4:	100027f3          	csrr	a5,sstatus
ffffffffc02078c8:	8b89                	andi	a5,a5,2
ffffffffc02078ca:	4b01                	li	s6,0
ffffffffc02078cc:	efe9                	bnez	a5,ffffffffc02079a6 <run_timer_list+0xf4>
ffffffffc02078ce:	0008e997          	auipc	s3,0x8e
ffffffffc02078d2:	f2298993          	addi	s3,s3,-222 # ffffffffc02957f0 <timer_list>
ffffffffc02078d6:	0089b403          	ld	s0,8(s3)
ffffffffc02078da:	07340a63          	beq	s0,s3,ffffffffc020794e <run_timer_list+0x9c>
ffffffffc02078de:	ff042783          	lw	a5,-16(s0)
ffffffffc02078e2:	ff040913          	addi	s2,s0,-16
ffffffffc02078e6:	0e078763          	beqz	a5,ffffffffc02079d4 <run_timer_list+0x122>
ffffffffc02078ea:	fff7871b          	addiw	a4,a5,-1
ffffffffc02078ee:	fee42823          	sw	a4,-16(s0)
ffffffffc02078f2:	ef31                	bnez	a4,ffffffffc020794e <run_timer_list+0x9c>
ffffffffc02078f4:	00006a97          	auipc	s5,0x6
ffffffffc02078f8:	404a8a93          	addi	s5,s5,1028 # ffffffffc020dcf8 <CSWTCH.79+0x5b0>
ffffffffc02078fc:	00006a17          	auipc	s4,0x6
ffffffffc0207900:	32ca0a13          	addi	s4,s4,812 # ffffffffc020dc28 <CSWTCH.79+0x4e0>
ffffffffc0207904:	a005                	j	ffffffffc0207924 <run_timer_list+0x72>
ffffffffc0207906:	0a07d763          	bgez	a5,ffffffffc02079b4 <run_timer_list+0x102>
ffffffffc020790a:	8526                	mv	a0,s1
ffffffffc020790c:	ce9ff0ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
ffffffffc0207910:	854a                	mv	a0,s2
ffffffffc0207912:	f1dff0ef          	jal	ra,ffffffffc020782e <del_timer>
ffffffffc0207916:	03340c63          	beq	s0,s3,ffffffffc020794e <run_timer_list+0x9c>
ffffffffc020791a:	ff042783          	lw	a5,-16(s0)
ffffffffc020791e:	ff040913          	addi	s2,s0,-16
ffffffffc0207922:	e795                	bnez	a5,ffffffffc020794e <run_timer_list+0x9c>
ffffffffc0207924:	00893483          	ld	s1,8(s2)
ffffffffc0207928:	6400                	ld	s0,8(s0)
ffffffffc020792a:	0ec4a783          	lw	a5,236(s1)
ffffffffc020792e:	ffe1                	bnez	a5,ffffffffc0207906 <run_timer_list+0x54>
ffffffffc0207930:	40d4                	lw	a3,4(s1)
ffffffffc0207932:	8656                	mv	a2,s5
ffffffffc0207934:	0ba00593          	li	a1,186
ffffffffc0207938:	8552                	mv	a0,s4
ffffffffc020793a:	bcdf80ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020793e:	8526                	mv	a0,s1
ffffffffc0207940:	cb5ff0ef          	jal	ra,ffffffffc02075f4 <wakeup_proc>
ffffffffc0207944:	854a                	mv	a0,s2
ffffffffc0207946:	ee9ff0ef          	jal	ra,ffffffffc020782e <del_timer>
ffffffffc020794a:	fd3418e3          	bne	s0,s3,ffffffffc020791a <run_timer_list+0x68>
ffffffffc020794e:	0008f597          	auipc	a1,0x8f
ffffffffc0207952:	f725b583          	ld	a1,-142(a1) # ffffffffc02968c0 <current>
ffffffffc0207956:	c18d                	beqz	a1,ffffffffc0207978 <run_timer_list+0xc6>
ffffffffc0207958:	0008f797          	auipc	a5,0x8f
ffffffffc020795c:	f707b783          	ld	a5,-144(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207960:	04f58763          	beq	a1,a5,ffffffffc02079ae <run_timer_list+0xfc>
ffffffffc0207964:	0008f797          	auipc	a5,0x8f
ffffffffc0207968:	f847b783          	ld	a5,-124(a5) # ffffffffc02968e8 <sched_class>
ffffffffc020796c:	779c                	ld	a5,40(a5)
ffffffffc020796e:	0008f517          	auipc	a0,0x8f
ffffffffc0207972:	f7253503          	ld	a0,-142(a0) # ffffffffc02968e0 <rq>
ffffffffc0207976:	9782                	jalr	a5
ffffffffc0207978:	000b1c63          	bnez	s6,ffffffffc0207990 <run_timer_list+0xde>
ffffffffc020797c:	70e2                	ld	ra,56(sp)
ffffffffc020797e:	7442                	ld	s0,48(sp)
ffffffffc0207980:	74a2                	ld	s1,40(sp)
ffffffffc0207982:	7902                	ld	s2,32(sp)
ffffffffc0207984:	69e2                	ld	s3,24(sp)
ffffffffc0207986:	6a42                	ld	s4,16(sp)
ffffffffc0207988:	6aa2                	ld	s5,8(sp)
ffffffffc020798a:	6b02                	ld	s6,0(sp)
ffffffffc020798c:	6121                	addi	sp,sp,64
ffffffffc020798e:	8082                	ret
ffffffffc0207990:	7442                	ld	s0,48(sp)
ffffffffc0207992:	70e2                	ld	ra,56(sp)
ffffffffc0207994:	74a2                	ld	s1,40(sp)
ffffffffc0207996:	7902                	ld	s2,32(sp)
ffffffffc0207998:	69e2                	ld	s3,24(sp)
ffffffffc020799a:	6a42                	ld	s4,16(sp)
ffffffffc020799c:	6aa2                	ld	s5,8(sp)
ffffffffc020799e:	6b02                	ld	s6,0(sp)
ffffffffc02079a0:	6121                	addi	sp,sp,64
ffffffffc02079a2:	acaf906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02079a6:	accf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02079aa:	4b05                	li	s6,1
ffffffffc02079ac:	b70d                	j	ffffffffc02078ce <run_timer_list+0x1c>
ffffffffc02079ae:	4785                	li	a5,1
ffffffffc02079b0:	ed9c                	sd	a5,24(a1)
ffffffffc02079b2:	b7d9                	j	ffffffffc0207978 <run_timer_list+0xc6>
ffffffffc02079b4:	00006697          	auipc	a3,0x6
ffffffffc02079b8:	31c68693          	addi	a3,a3,796 # ffffffffc020dcd0 <CSWTCH.79+0x588>
ffffffffc02079bc:	00004617          	auipc	a2,0x4
ffffffffc02079c0:	34460613          	addi	a2,a2,836 # ffffffffc020bd00 <commands+0x210>
ffffffffc02079c4:	0b600593          	li	a1,182
ffffffffc02079c8:	00006517          	auipc	a0,0x6
ffffffffc02079cc:	26050513          	addi	a0,a0,608 # ffffffffc020dc28 <CSWTCH.79+0x4e0>
ffffffffc02079d0:	acff80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02079d4:	00006697          	auipc	a3,0x6
ffffffffc02079d8:	2e468693          	addi	a3,a3,740 # ffffffffc020dcb8 <CSWTCH.79+0x570>
ffffffffc02079dc:	00004617          	auipc	a2,0x4
ffffffffc02079e0:	32460613          	addi	a2,a2,804 # ffffffffc020bd00 <commands+0x210>
ffffffffc02079e4:	0ae00593          	li	a1,174
ffffffffc02079e8:	00006517          	auipc	a0,0x6
ffffffffc02079ec:	24050513          	addi	a0,a0,576 # ffffffffc020dc28 <CSWTCH.79+0x4e0>
ffffffffc02079f0:	aaff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02079f4 <sys_getpid>:
ffffffffc02079f4:	0008f797          	auipc	a5,0x8f
ffffffffc02079f8:	ecc7b783          	ld	a5,-308(a5) # ffffffffc02968c0 <current>
ffffffffc02079fc:	43c8                	lw	a0,4(a5)
ffffffffc02079fe:	8082                	ret

ffffffffc0207a00 <sys_pgdir>:
ffffffffc0207a00:	4501                	li	a0,0
ffffffffc0207a02:	8082                	ret

ffffffffc0207a04 <sys_gettime>:
ffffffffc0207a04:	0008f797          	auipc	a5,0x8f
ffffffffc0207a08:	e6c7b783          	ld	a5,-404(a5) # ffffffffc0296870 <ticks>
ffffffffc0207a0c:	0027951b          	slliw	a0,a5,0x2
ffffffffc0207a10:	9d3d                	addw	a0,a0,a5
ffffffffc0207a12:	0015151b          	slliw	a0,a0,0x1
ffffffffc0207a16:	8082                	ret

ffffffffc0207a18 <sys_lab6_set_priority>:
ffffffffc0207a18:	4108                	lw	a0,0(a0)
ffffffffc0207a1a:	1141                	addi	sp,sp,-16
ffffffffc0207a1c:	e406                	sd	ra,8(sp)
ffffffffc0207a1e:	975ff0ef          	jal	ra,ffffffffc0207392 <lab6_set_priority>
ffffffffc0207a22:	60a2                	ld	ra,8(sp)
ffffffffc0207a24:	4501                	li	a0,0
ffffffffc0207a26:	0141                	addi	sp,sp,16
ffffffffc0207a28:	8082                	ret

ffffffffc0207a2a <sys_dup>:
ffffffffc0207a2a:	450c                	lw	a1,8(a0)
ffffffffc0207a2c:	4108                	lw	a0,0(a0)
ffffffffc0207a2e:	832fe06f          	j	ffffffffc0205a60 <sysfile_dup>

ffffffffc0207a32 <sys_getdirentry>:
ffffffffc0207a32:	650c                	ld	a1,8(a0)
ffffffffc0207a34:	4108                	lw	a0,0(a0)
ffffffffc0207a36:	f3bfd06f          	j	ffffffffc0205970 <sysfile_getdirentry>

ffffffffc0207a3a <sys_getcwd>:
ffffffffc0207a3a:	650c                	ld	a1,8(a0)
ffffffffc0207a3c:	6108                	ld	a0,0(a0)
ffffffffc0207a3e:	e8ffd06f          	j	ffffffffc02058cc <sysfile_getcwd>

ffffffffc0207a42 <sys_fsync>:
ffffffffc0207a42:	4108                	lw	a0,0(a0)
ffffffffc0207a44:	e85fd06f          	j	ffffffffc02058c8 <sysfile_fsync>

ffffffffc0207a48 <sys_fstat>:
ffffffffc0207a48:	650c                	ld	a1,8(a0)
ffffffffc0207a4a:	4108                	lw	a0,0(a0)
ffffffffc0207a4c:	dddfd06f          	j	ffffffffc0205828 <sysfile_fstat>

ffffffffc0207a50 <sys_seek>:
ffffffffc0207a50:	4910                	lw	a2,16(a0)
ffffffffc0207a52:	650c                	ld	a1,8(a0)
ffffffffc0207a54:	4108                	lw	a0,0(a0)
ffffffffc0207a56:	dcffd06f          	j	ffffffffc0205824 <sysfile_seek>

ffffffffc0207a5a <sys_write>:
ffffffffc0207a5a:	6910                	ld	a2,16(a0)
ffffffffc0207a5c:	650c                	ld	a1,8(a0)
ffffffffc0207a5e:	4108                	lw	a0,0(a0)
ffffffffc0207a60:	cabfd06f          	j	ffffffffc020570a <sysfile_write>

ffffffffc0207a64 <sys_read>:
ffffffffc0207a64:	6910                	ld	a2,16(a0)
ffffffffc0207a66:	650c                	ld	a1,8(a0)
ffffffffc0207a68:	4108                	lw	a0,0(a0)
ffffffffc0207a6a:	b8dfd06f          	j	ffffffffc02055f6 <sysfile_read>

ffffffffc0207a6e <sys_close>:
ffffffffc0207a6e:	4108                	lw	a0,0(a0)
ffffffffc0207a70:	b83fd06f          	j	ffffffffc02055f2 <sysfile_close>

ffffffffc0207a74 <sys_open>:
ffffffffc0207a74:	450c                	lw	a1,8(a0)
ffffffffc0207a76:	6108                	ld	a0,0(a0)
ffffffffc0207a78:	b47fd06f          	j	ffffffffc02055be <sysfile_open>

ffffffffc0207a7c <sys_putc>:
ffffffffc0207a7c:	4108                	lw	a0,0(a0)
ffffffffc0207a7e:	1141                	addi	sp,sp,-16
ffffffffc0207a80:	e406                	sd	ra,8(sp)
ffffffffc0207a82:	f60f80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0207a86:	60a2                	ld	ra,8(sp)
ffffffffc0207a88:	4501                	li	a0,0
ffffffffc0207a8a:	0141                	addi	sp,sp,16
ffffffffc0207a8c:	8082                	ret

ffffffffc0207a8e <sys_kill>:
ffffffffc0207a8e:	4108                	lw	a0,0(a0)
ffffffffc0207a90:	ea0ff06f          	j	ffffffffc0207130 <do_kill>

ffffffffc0207a94 <sys_sleep>:
ffffffffc0207a94:	4108                	lw	a0,0(a0)
ffffffffc0207a96:	937ff06f          	j	ffffffffc02073cc <do_sleep>

ffffffffc0207a9a <sys_yield>:
ffffffffc0207a9a:	e48ff06f          	j	ffffffffc02070e2 <do_yield>

ffffffffc0207a9e <sys_exec>:
ffffffffc0207a9e:	6910                	ld	a2,16(a0)
ffffffffc0207aa0:	450c                	lw	a1,8(a0)
ffffffffc0207aa2:	6108                	ld	a0,0(a0)
ffffffffc0207aa4:	afffe06f          	j	ffffffffc02065a2 <do_execve>

ffffffffc0207aa8 <sys_wait>:
ffffffffc0207aa8:	650c                	ld	a1,8(a0)
ffffffffc0207aaa:	4108                	lw	a0,0(a0)
ffffffffc0207aac:	e46ff06f          	j	ffffffffc02070f2 <do_wait>

ffffffffc0207ab0 <sys_fork>:
ffffffffc0207ab0:	0008f797          	auipc	a5,0x8f
ffffffffc0207ab4:	e107b783          	ld	a5,-496(a5) # ffffffffc02968c0 <current>
ffffffffc0207ab8:	73d0                	ld	a2,160(a5)
ffffffffc0207aba:	4501                	li	a0,0
ffffffffc0207abc:	6a0c                	ld	a1,16(a2)
ffffffffc0207abe:	990fe06f          	j	ffffffffc0205c4e <do_fork>

ffffffffc0207ac2 <sys_exit>:
ffffffffc0207ac2:	4108                	lw	a0,0(a0)
ffffffffc0207ac4:	e5afe06f          	j	ffffffffc020611e <do_exit>

ffffffffc0207ac8 <syscall>:
ffffffffc0207ac8:	715d                	addi	sp,sp,-80
ffffffffc0207aca:	fc26                	sd	s1,56(sp)
ffffffffc0207acc:	0008f497          	auipc	s1,0x8f
ffffffffc0207ad0:	df448493          	addi	s1,s1,-524 # ffffffffc02968c0 <current>
ffffffffc0207ad4:	6098                	ld	a4,0(s1)
ffffffffc0207ad6:	e0a2                	sd	s0,64(sp)
ffffffffc0207ad8:	f84a                	sd	s2,48(sp)
ffffffffc0207ada:	7340                	ld	s0,160(a4)
ffffffffc0207adc:	e486                	sd	ra,72(sp)
ffffffffc0207ade:	0ff00793          	li	a5,255
ffffffffc0207ae2:	05042903          	lw	s2,80(s0)
ffffffffc0207ae6:	0327ee63          	bltu	a5,s2,ffffffffc0207b22 <syscall+0x5a>
ffffffffc0207aea:	00391713          	slli	a4,s2,0x3
ffffffffc0207aee:	00006797          	auipc	a5,0x6
ffffffffc0207af2:	27278793          	addi	a5,a5,626 # ffffffffc020dd60 <syscalls>
ffffffffc0207af6:	97ba                	add	a5,a5,a4
ffffffffc0207af8:	639c                	ld	a5,0(a5)
ffffffffc0207afa:	c785                	beqz	a5,ffffffffc0207b22 <syscall+0x5a>
ffffffffc0207afc:	6c28                	ld	a0,88(s0)
ffffffffc0207afe:	702c                	ld	a1,96(s0)
ffffffffc0207b00:	7430                	ld	a2,104(s0)
ffffffffc0207b02:	7834                	ld	a3,112(s0)
ffffffffc0207b04:	7c38                	ld	a4,120(s0)
ffffffffc0207b06:	e42a                	sd	a0,8(sp)
ffffffffc0207b08:	e82e                	sd	a1,16(sp)
ffffffffc0207b0a:	ec32                	sd	a2,24(sp)
ffffffffc0207b0c:	f036                	sd	a3,32(sp)
ffffffffc0207b0e:	f43a                	sd	a4,40(sp)
ffffffffc0207b10:	0028                	addi	a0,sp,8
ffffffffc0207b12:	9782                	jalr	a5
ffffffffc0207b14:	60a6                	ld	ra,72(sp)
ffffffffc0207b16:	e828                	sd	a0,80(s0)
ffffffffc0207b18:	6406                	ld	s0,64(sp)
ffffffffc0207b1a:	74e2                	ld	s1,56(sp)
ffffffffc0207b1c:	7942                	ld	s2,48(sp)
ffffffffc0207b1e:	6161                	addi	sp,sp,80
ffffffffc0207b20:	8082                	ret
ffffffffc0207b22:	8522                	mv	a0,s0
ffffffffc0207b24:	c66f90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0207b28:	609c                	ld	a5,0(s1)
ffffffffc0207b2a:	86ca                	mv	a3,s2
ffffffffc0207b2c:	00006617          	auipc	a2,0x6
ffffffffc0207b30:	1ec60613          	addi	a2,a2,492 # ffffffffc020dd18 <CSWTCH.79+0x5d0>
ffffffffc0207b34:	43d8                	lw	a4,4(a5)
ffffffffc0207b36:	0d800593          	li	a1,216
ffffffffc0207b3a:	0b478793          	addi	a5,a5,180
ffffffffc0207b3e:	00006517          	auipc	a0,0x6
ffffffffc0207b42:	20a50513          	addi	a0,a0,522 # ffffffffc020dd48 <CSWTCH.79+0x600>
ffffffffc0207b46:	959f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207b4a <__alloc_inode>:
ffffffffc0207b4a:	1141                	addi	sp,sp,-16
ffffffffc0207b4c:	e022                	sd	s0,0(sp)
ffffffffc0207b4e:	842a                	mv	s0,a0
ffffffffc0207b50:	07800513          	li	a0,120
ffffffffc0207b54:	e406                	sd	ra,8(sp)
ffffffffc0207b56:	cccfa0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0207b5a:	c111                	beqz	a0,ffffffffc0207b5e <__alloc_inode+0x14>
ffffffffc0207b5c:	cd20                	sw	s0,88(a0)
ffffffffc0207b5e:	60a2                	ld	ra,8(sp)
ffffffffc0207b60:	6402                	ld	s0,0(sp)
ffffffffc0207b62:	0141                	addi	sp,sp,16
ffffffffc0207b64:	8082                	ret

ffffffffc0207b66 <inode_init>:
ffffffffc0207b66:	4785                	li	a5,1
ffffffffc0207b68:	06052023          	sw	zero,96(a0)
ffffffffc0207b6c:	f92c                	sd	a1,112(a0)
ffffffffc0207b6e:	f530                	sd	a2,104(a0)
ffffffffc0207b70:	cd7c                	sw	a5,92(a0)
ffffffffc0207b72:	8082                	ret

ffffffffc0207b74 <inode_kill>:
ffffffffc0207b74:	4d78                	lw	a4,92(a0)
ffffffffc0207b76:	1141                	addi	sp,sp,-16
ffffffffc0207b78:	e406                	sd	ra,8(sp)
ffffffffc0207b7a:	e719                	bnez	a4,ffffffffc0207b88 <inode_kill+0x14>
ffffffffc0207b7c:	513c                	lw	a5,96(a0)
ffffffffc0207b7e:	e78d                	bnez	a5,ffffffffc0207ba8 <inode_kill+0x34>
ffffffffc0207b80:	60a2                	ld	ra,8(sp)
ffffffffc0207b82:	0141                	addi	sp,sp,16
ffffffffc0207b84:	d4efa06f          	j	ffffffffc02020d2 <kfree>
ffffffffc0207b88:	00007697          	auipc	a3,0x7
ffffffffc0207b8c:	9d868693          	addi	a3,a3,-1576 # ffffffffc020e560 <syscalls+0x800>
ffffffffc0207b90:	00004617          	auipc	a2,0x4
ffffffffc0207b94:	17060613          	addi	a2,a2,368 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207b98:	02900593          	li	a1,41
ffffffffc0207b9c:	00007517          	auipc	a0,0x7
ffffffffc0207ba0:	9e450513          	addi	a0,a0,-1564 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207ba4:	8fbf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ba8:	00007697          	auipc	a3,0x7
ffffffffc0207bac:	9f068693          	addi	a3,a3,-1552 # ffffffffc020e598 <syscalls+0x838>
ffffffffc0207bb0:	00004617          	auipc	a2,0x4
ffffffffc0207bb4:	15060613          	addi	a2,a2,336 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207bb8:	02a00593          	li	a1,42
ffffffffc0207bbc:	00007517          	auipc	a0,0x7
ffffffffc0207bc0:	9c450513          	addi	a0,a0,-1596 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207bc4:	8dbf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207bc8 <inode_ref_inc>:
ffffffffc0207bc8:	4d7c                	lw	a5,92(a0)
ffffffffc0207bca:	2785                	addiw	a5,a5,1
ffffffffc0207bcc:	cd7c                	sw	a5,92(a0)
ffffffffc0207bce:	0007851b          	sext.w	a0,a5
ffffffffc0207bd2:	8082                	ret

ffffffffc0207bd4 <inode_open_inc>:
ffffffffc0207bd4:	513c                	lw	a5,96(a0)
ffffffffc0207bd6:	2785                	addiw	a5,a5,1
ffffffffc0207bd8:	d13c                	sw	a5,96(a0)
ffffffffc0207bda:	0007851b          	sext.w	a0,a5
ffffffffc0207bde:	8082                	ret

ffffffffc0207be0 <inode_check>:
ffffffffc0207be0:	1141                	addi	sp,sp,-16
ffffffffc0207be2:	e406                	sd	ra,8(sp)
ffffffffc0207be4:	c90d                	beqz	a0,ffffffffc0207c16 <inode_check+0x36>
ffffffffc0207be6:	793c                	ld	a5,112(a0)
ffffffffc0207be8:	c79d                	beqz	a5,ffffffffc0207c16 <inode_check+0x36>
ffffffffc0207bea:	6398                	ld	a4,0(a5)
ffffffffc0207bec:	4625d7b7          	lui	a5,0x4625d
ffffffffc0207bf0:	0786                	slli	a5,a5,0x1
ffffffffc0207bf2:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc0207bf6:	08f71063          	bne	a4,a5,ffffffffc0207c76 <inode_check+0x96>
ffffffffc0207bfa:	4d78                	lw	a4,92(a0)
ffffffffc0207bfc:	513c                	lw	a5,96(a0)
ffffffffc0207bfe:	04f74c63          	blt	a4,a5,ffffffffc0207c56 <inode_check+0x76>
ffffffffc0207c02:	0407ca63          	bltz	a5,ffffffffc0207c56 <inode_check+0x76>
ffffffffc0207c06:	66c1                	lui	a3,0x10
ffffffffc0207c08:	02d75763          	bge	a4,a3,ffffffffc0207c36 <inode_check+0x56>
ffffffffc0207c0c:	02d7d563          	bge	a5,a3,ffffffffc0207c36 <inode_check+0x56>
ffffffffc0207c10:	60a2                	ld	ra,8(sp)
ffffffffc0207c12:	0141                	addi	sp,sp,16
ffffffffc0207c14:	8082                	ret
ffffffffc0207c16:	00007697          	auipc	a3,0x7
ffffffffc0207c1a:	9a268693          	addi	a3,a3,-1630 # ffffffffc020e5b8 <syscalls+0x858>
ffffffffc0207c1e:	00004617          	auipc	a2,0x4
ffffffffc0207c22:	0e260613          	addi	a2,a2,226 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207c26:	06e00593          	li	a1,110
ffffffffc0207c2a:	00007517          	auipc	a0,0x7
ffffffffc0207c2e:	95650513          	addi	a0,a0,-1706 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207c32:	86df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207c36:	00007697          	auipc	a3,0x7
ffffffffc0207c3a:	a0268693          	addi	a3,a3,-1534 # ffffffffc020e638 <syscalls+0x8d8>
ffffffffc0207c3e:	00004617          	auipc	a2,0x4
ffffffffc0207c42:	0c260613          	addi	a2,a2,194 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207c46:	07200593          	li	a1,114
ffffffffc0207c4a:	00007517          	auipc	a0,0x7
ffffffffc0207c4e:	93650513          	addi	a0,a0,-1738 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207c52:	84df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207c56:	00007697          	auipc	a3,0x7
ffffffffc0207c5a:	9b268693          	addi	a3,a3,-1614 # ffffffffc020e608 <syscalls+0x8a8>
ffffffffc0207c5e:	00004617          	auipc	a2,0x4
ffffffffc0207c62:	0a260613          	addi	a2,a2,162 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207c66:	07100593          	li	a1,113
ffffffffc0207c6a:	00007517          	auipc	a0,0x7
ffffffffc0207c6e:	91650513          	addi	a0,a0,-1770 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207c72:	82df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207c76:	00007697          	auipc	a3,0x7
ffffffffc0207c7a:	96a68693          	addi	a3,a3,-1686 # ffffffffc020e5e0 <syscalls+0x880>
ffffffffc0207c7e:	00004617          	auipc	a2,0x4
ffffffffc0207c82:	08260613          	addi	a2,a2,130 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207c86:	06f00593          	li	a1,111
ffffffffc0207c8a:	00007517          	auipc	a0,0x7
ffffffffc0207c8e:	8f650513          	addi	a0,a0,-1802 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207c92:	80df80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207c96 <inode_ref_dec>:
ffffffffc0207c96:	4d7c                	lw	a5,92(a0)
ffffffffc0207c98:	1101                	addi	sp,sp,-32
ffffffffc0207c9a:	ec06                	sd	ra,24(sp)
ffffffffc0207c9c:	e822                	sd	s0,16(sp)
ffffffffc0207c9e:	e426                	sd	s1,8(sp)
ffffffffc0207ca0:	e04a                	sd	s2,0(sp)
ffffffffc0207ca2:	06f05e63          	blez	a5,ffffffffc0207d1e <inode_ref_dec+0x88>
ffffffffc0207ca6:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207caa:	cd64                	sw	s1,92(a0)
ffffffffc0207cac:	842a                	mv	s0,a0
ffffffffc0207cae:	e09d                	bnez	s1,ffffffffc0207cd4 <inode_ref_dec+0x3e>
ffffffffc0207cb0:	793c                	ld	a5,112(a0)
ffffffffc0207cb2:	c7b1                	beqz	a5,ffffffffc0207cfe <inode_ref_dec+0x68>
ffffffffc0207cb4:	0487b903          	ld	s2,72(a5)
ffffffffc0207cb8:	04090363          	beqz	s2,ffffffffc0207cfe <inode_ref_dec+0x68>
ffffffffc0207cbc:	00007597          	auipc	a1,0x7
ffffffffc0207cc0:	a2c58593          	addi	a1,a1,-1492 # ffffffffc020e6e8 <syscalls+0x988>
ffffffffc0207cc4:	f1dff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0207cc8:	8522                	mv	a0,s0
ffffffffc0207cca:	9902                	jalr	s2
ffffffffc0207ccc:	c501                	beqz	a0,ffffffffc0207cd4 <inode_ref_dec+0x3e>
ffffffffc0207cce:	57c5                	li	a5,-15
ffffffffc0207cd0:	00f51963          	bne	a0,a5,ffffffffc0207ce2 <inode_ref_dec+0x4c>
ffffffffc0207cd4:	60e2                	ld	ra,24(sp)
ffffffffc0207cd6:	6442                	ld	s0,16(sp)
ffffffffc0207cd8:	6902                	ld	s2,0(sp)
ffffffffc0207cda:	8526                	mv	a0,s1
ffffffffc0207cdc:	64a2                	ld	s1,8(sp)
ffffffffc0207cde:	6105                	addi	sp,sp,32
ffffffffc0207ce0:	8082                	ret
ffffffffc0207ce2:	85aa                	mv	a1,a0
ffffffffc0207ce4:	00007517          	auipc	a0,0x7
ffffffffc0207ce8:	a0c50513          	addi	a0,a0,-1524 # ffffffffc020e6f0 <syscalls+0x990>
ffffffffc0207cec:	cbaf80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207cf0:	60e2                	ld	ra,24(sp)
ffffffffc0207cf2:	6442                	ld	s0,16(sp)
ffffffffc0207cf4:	6902                	ld	s2,0(sp)
ffffffffc0207cf6:	8526                	mv	a0,s1
ffffffffc0207cf8:	64a2                	ld	s1,8(sp)
ffffffffc0207cfa:	6105                	addi	sp,sp,32
ffffffffc0207cfc:	8082                	ret
ffffffffc0207cfe:	00007697          	auipc	a3,0x7
ffffffffc0207d02:	99a68693          	addi	a3,a3,-1638 # ffffffffc020e698 <syscalls+0x938>
ffffffffc0207d06:	00004617          	auipc	a2,0x4
ffffffffc0207d0a:	ffa60613          	addi	a2,a2,-6 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207d0e:	04400593          	li	a1,68
ffffffffc0207d12:	00007517          	auipc	a0,0x7
ffffffffc0207d16:	86e50513          	addi	a0,a0,-1938 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207d1a:	f84f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d1e:	00007697          	auipc	a3,0x7
ffffffffc0207d22:	95a68693          	addi	a3,a3,-1702 # ffffffffc020e678 <syscalls+0x918>
ffffffffc0207d26:	00004617          	auipc	a2,0x4
ffffffffc0207d2a:	fda60613          	addi	a2,a2,-38 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207d2e:	03f00593          	li	a1,63
ffffffffc0207d32:	00007517          	auipc	a0,0x7
ffffffffc0207d36:	84e50513          	addi	a0,a0,-1970 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207d3a:	f64f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d3e <inode_open_dec>:
ffffffffc0207d3e:	513c                	lw	a5,96(a0)
ffffffffc0207d40:	1101                	addi	sp,sp,-32
ffffffffc0207d42:	ec06                	sd	ra,24(sp)
ffffffffc0207d44:	e822                	sd	s0,16(sp)
ffffffffc0207d46:	e426                	sd	s1,8(sp)
ffffffffc0207d48:	e04a                	sd	s2,0(sp)
ffffffffc0207d4a:	06f05b63          	blez	a5,ffffffffc0207dc0 <inode_open_dec+0x82>
ffffffffc0207d4e:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207d52:	d124                	sw	s1,96(a0)
ffffffffc0207d54:	842a                	mv	s0,a0
ffffffffc0207d56:	e085                	bnez	s1,ffffffffc0207d76 <inode_open_dec+0x38>
ffffffffc0207d58:	793c                	ld	a5,112(a0)
ffffffffc0207d5a:	c3b9                	beqz	a5,ffffffffc0207da0 <inode_open_dec+0x62>
ffffffffc0207d5c:	0107b903          	ld	s2,16(a5)
ffffffffc0207d60:	04090063          	beqz	s2,ffffffffc0207da0 <inode_open_dec+0x62>
ffffffffc0207d64:	00007597          	auipc	a1,0x7
ffffffffc0207d68:	a1c58593          	addi	a1,a1,-1508 # ffffffffc020e780 <syscalls+0xa20>
ffffffffc0207d6c:	e75ff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0207d70:	8522                	mv	a0,s0
ffffffffc0207d72:	9902                	jalr	s2
ffffffffc0207d74:	e901                	bnez	a0,ffffffffc0207d84 <inode_open_dec+0x46>
ffffffffc0207d76:	60e2                	ld	ra,24(sp)
ffffffffc0207d78:	6442                	ld	s0,16(sp)
ffffffffc0207d7a:	6902                	ld	s2,0(sp)
ffffffffc0207d7c:	8526                	mv	a0,s1
ffffffffc0207d7e:	64a2                	ld	s1,8(sp)
ffffffffc0207d80:	6105                	addi	sp,sp,32
ffffffffc0207d82:	8082                	ret
ffffffffc0207d84:	85aa                	mv	a1,a0
ffffffffc0207d86:	00007517          	auipc	a0,0x7
ffffffffc0207d8a:	a0250513          	addi	a0,a0,-1534 # ffffffffc020e788 <syscalls+0xa28>
ffffffffc0207d8e:	c18f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207d92:	60e2                	ld	ra,24(sp)
ffffffffc0207d94:	6442                	ld	s0,16(sp)
ffffffffc0207d96:	6902                	ld	s2,0(sp)
ffffffffc0207d98:	8526                	mv	a0,s1
ffffffffc0207d9a:	64a2                	ld	s1,8(sp)
ffffffffc0207d9c:	6105                	addi	sp,sp,32
ffffffffc0207d9e:	8082                	ret
ffffffffc0207da0:	00007697          	auipc	a3,0x7
ffffffffc0207da4:	99068693          	addi	a3,a3,-1648 # ffffffffc020e730 <syscalls+0x9d0>
ffffffffc0207da8:	00004617          	auipc	a2,0x4
ffffffffc0207dac:	f5860613          	addi	a2,a2,-168 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207db0:	06100593          	li	a1,97
ffffffffc0207db4:	00006517          	auipc	a0,0x6
ffffffffc0207db8:	7cc50513          	addi	a0,a0,1996 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207dbc:	ee2f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207dc0:	00007697          	auipc	a3,0x7
ffffffffc0207dc4:	95068693          	addi	a3,a3,-1712 # ffffffffc020e710 <syscalls+0x9b0>
ffffffffc0207dc8:	00004617          	auipc	a2,0x4
ffffffffc0207dcc:	f3860613          	addi	a2,a2,-200 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207dd0:	05c00593          	li	a1,92
ffffffffc0207dd4:	00006517          	auipc	a0,0x6
ffffffffc0207dd8:	7ac50513          	addi	a0,a0,1964 # ffffffffc020e580 <syscalls+0x820>
ffffffffc0207ddc:	ec2f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207de0 <__alloc_fs>:
ffffffffc0207de0:	1141                	addi	sp,sp,-16
ffffffffc0207de2:	e022                	sd	s0,0(sp)
ffffffffc0207de4:	842a                	mv	s0,a0
ffffffffc0207de6:	0d800513          	li	a0,216
ffffffffc0207dea:	e406                	sd	ra,8(sp)
ffffffffc0207dec:	a36fa0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0207df0:	c119                	beqz	a0,ffffffffc0207df6 <__alloc_fs+0x16>
ffffffffc0207df2:	0a852823          	sw	s0,176(a0)
ffffffffc0207df6:	60a2                	ld	ra,8(sp)
ffffffffc0207df8:	6402                	ld	s0,0(sp)
ffffffffc0207dfa:	0141                	addi	sp,sp,16
ffffffffc0207dfc:	8082                	ret

ffffffffc0207dfe <vfs_init>:
ffffffffc0207dfe:	1141                	addi	sp,sp,-16
ffffffffc0207e00:	4585                	li	a1,1
ffffffffc0207e02:	0008e517          	auipc	a0,0x8e
ffffffffc0207e06:	9fe50513          	addi	a0,a0,-1538 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207e0a:	e406                	sd	ra,8(sp)
ffffffffc0207e0c:	fe6fc0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc0207e10:	60a2                	ld	ra,8(sp)
ffffffffc0207e12:	0141                	addi	sp,sp,16
ffffffffc0207e14:	a40d                	j	ffffffffc0208036 <vfs_devlist_init>

ffffffffc0207e16 <vfs_set_bootfs>:
ffffffffc0207e16:	7179                	addi	sp,sp,-48
ffffffffc0207e18:	f022                	sd	s0,32(sp)
ffffffffc0207e1a:	f406                	sd	ra,40(sp)
ffffffffc0207e1c:	ec26                	sd	s1,24(sp)
ffffffffc0207e1e:	e402                	sd	zero,8(sp)
ffffffffc0207e20:	842a                	mv	s0,a0
ffffffffc0207e22:	c915                	beqz	a0,ffffffffc0207e56 <vfs_set_bootfs+0x40>
ffffffffc0207e24:	03a00593          	li	a1,58
ffffffffc0207e28:	1dd030ef          	jal	ra,ffffffffc020b804 <strchr>
ffffffffc0207e2c:	c135                	beqz	a0,ffffffffc0207e90 <vfs_set_bootfs+0x7a>
ffffffffc0207e2e:	00154783          	lbu	a5,1(a0)
ffffffffc0207e32:	efb9                	bnez	a5,ffffffffc0207e90 <vfs_set_bootfs+0x7a>
ffffffffc0207e34:	8522                	mv	a0,s0
ffffffffc0207e36:	11f000ef          	jal	ra,ffffffffc0208754 <vfs_chdir>
ffffffffc0207e3a:	842a                	mv	s0,a0
ffffffffc0207e3c:	c519                	beqz	a0,ffffffffc0207e4a <vfs_set_bootfs+0x34>
ffffffffc0207e3e:	70a2                	ld	ra,40(sp)
ffffffffc0207e40:	8522                	mv	a0,s0
ffffffffc0207e42:	7402                	ld	s0,32(sp)
ffffffffc0207e44:	64e2                	ld	s1,24(sp)
ffffffffc0207e46:	6145                	addi	sp,sp,48
ffffffffc0207e48:	8082                	ret
ffffffffc0207e4a:	0028                	addi	a0,sp,8
ffffffffc0207e4c:	013000ef          	jal	ra,ffffffffc020865e <vfs_get_curdir>
ffffffffc0207e50:	842a                	mv	s0,a0
ffffffffc0207e52:	f575                	bnez	a0,ffffffffc0207e3e <vfs_set_bootfs+0x28>
ffffffffc0207e54:	6422                	ld	s0,8(sp)
ffffffffc0207e56:	0008e517          	auipc	a0,0x8e
ffffffffc0207e5a:	9aa50513          	addi	a0,a0,-1622 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207e5e:	f9efc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0207e62:	0008f797          	auipc	a5,0x8f
ffffffffc0207e66:	a8e78793          	addi	a5,a5,-1394 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207e6a:	6384                	ld	s1,0(a5)
ffffffffc0207e6c:	0008e517          	auipc	a0,0x8e
ffffffffc0207e70:	99450513          	addi	a0,a0,-1644 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207e74:	e380                	sd	s0,0(a5)
ffffffffc0207e76:	4401                	li	s0,0
ffffffffc0207e78:	f80fc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207e7c:	d0e9                	beqz	s1,ffffffffc0207e3e <vfs_set_bootfs+0x28>
ffffffffc0207e7e:	8526                	mv	a0,s1
ffffffffc0207e80:	e17ff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc0207e84:	70a2                	ld	ra,40(sp)
ffffffffc0207e86:	8522                	mv	a0,s0
ffffffffc0207e88:	7402                	ld	s0,32(sp)
ffffffffc0207e8a:	64e2                	ld	s1,24(sp)
ffffffffc0207e8c:	6145                	addi	sp,sp,48
ffffffffc0207e8e:	8082                	ret
ffffffffc0207e90:	5475                	li	s0,-3
ffffffffc0207e92:	b775                	j	ffffffffc0207e3e <vfs_set_bootfs+0x28>

ffffffffc0207e94 <vfs_get_bootfs>:
ffffffffc0207e94:	1101                	addi	sp,sp,-32
ffffffffc0207e96:	e426                	sd	s1,8(sp)
ffffffffc0207e98:	0008f497          	auipc	s1,0x8f
ffffffffc0207e9c:	a5848493          	addi	s1,s1,-1448 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207ea0:	609c                	ld	a5,0(s1)
ffffffffc0207ea2:	ec06                	sd	ra,24(sp)
ffffffffc0207ea4:	e822                	sd	s0,16(sp)
ffffffffc0207ea6:	c3a1                	beqz	a5,ffffffffc0207ee6 <vfs_get_bootfs+0x52>
ffffffffc0207ea8:	842a                	mv	s0,a0
ffffffffc0207eaa:	0008e517          	auipc	a0,0x8e
ffffffffc0207eae:	95650513          	addi	a0,a0,-1706 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207eb2:	f4afc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0207eb6:	6084                	ld	s1,0(s1)
ffffffffc0207eb8:	c08d                	beqz	s1,ffffffffc0207eda <vfs_get_bootfs+0x46>
ffffffffc0207eba:	8526                	mv	a0,s1
ffffffffc0207ebc:	d0dff0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc0207ec0:	0008e517          	auipc	a0,0x8e
ffffffffc0207ec4:	94050513          	addi	a0,a0,-1728 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207ec8:	f30fc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207ecc:	4501                	li	a0,0
ffffffffc0207ece:	e004                	sd	s1,0(s0)
ffffffffc0207ed0:	60e2                	ld	ra,24(sp)
ffffffffc0207ed2:	6442                	ld	s0,16(sp)
ffffffffc0207ed4:	64a2                	ld	s1,8(sp)
ffffffffc0207ed6:	6105                	addi	sp,sp,32
ffffffffc0207ed8:	8082                	ret
ffffffffc0207eda:	0008e517          	auipc	a0,0x8e
ffffffffc0207ede:	92650513          	addi	a0,a0,-1754 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207ee2:	f16fc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207ee6:	5541                	li	a0,-16
ffffffffc0207ee8:	b7e5                	j	ffffffffc0207ed0 <vfs_get_bootfs+0x3c>

ffffffffc0207eea <vfs_do_add>:
ffffffffc0207eea:	7139                	addi	sp,sp,-64
ffffffffc0207eec:	fc06                	sd	ra,56(sp)
ffffffffc0207eee:	f822                	sd	s0,48(sp)
ffffffffc0207ef0:	f426                	sd	s1,40(sp)
ffffffffc0207ef2:	f04a                	sd	s2,32(sp)
ffffffffc0207ef4:	ec4e                	sd	s3,24(sp)
ffffffffc0207ef6:	e852                	sd	s4,16(sp)
ffffffffc0207ef8:	e456                	sd	s5,8(sp)
ffffffffc0207efa:	e05a                	sd	s6,0(sp)
ffffffffc0207efc:	0e050b63          	beqz	a0,ffffffffc0207ff2 <vfs_do_add+0x108>
ffffffffc0207f00:	842a                	mv	s0,a0
ffffffffc0207f02:	8a2e                	mv	s4,a1
ffffffffc0207f04:	8b32                	mv	s6,a2
ffffffffc0207f06:	8ab6                	mv	s5,a3
ffffffffc0207f08:	c5cd                	beqz	a1,ffffffffc0207fb2 <vfs_do_add+0xc8>
ffffffffc0207f0a:	4db8                	lw	a4,88(a1)
ffffffffc0207f0c:	6785                	lui	a5,0x1
ffffffffc0207f0e:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207f12:	0af71163          	bne	a4,a5,ffffffffc0207fb4 <vfs_do_add+0xca>
ffffffffc0207f16:	8522                	mv	a0,s0
ffffffffc0207f18:	061030ef          	jal	ra,ffffffffc020b778 <strlen>
ffffffffc0207f1c:	47fd                	li	a5,31
ffffffffc0207f1e:	0ca7e663          	bltu	a5,a0,ffffffffc0207fea <vfs_do_add+0x100>
ffffffffc0207f22:	8522                	mv	a0,s0
ffffffffc0207f24:	ad0f80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0207f28:	84aa                	mv	s1,a0
ffffffffc0207f2a:	c171                	beqz	a0,ffffffffc0207fee <vfs_do_add+0x104>
ffffffffc0207f2c:	03000513          	li	a0,48
ffffffffc0207f30:	8f2fa0ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0207f34:	89aa                	mv	s3,a0
ffffffffc0207f36:	c92d                	beqz	a0,ffffffffc0207fa8 <vfs_do_add+0xbe>
ffffffffc0207f38:	0008e517          	auipc	a0,0x8e
ffffffffc0207f3c:	8f050513          	addi	a0,a0,-1808 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207f40:	0008e917          	auipc	s2,0x8e
ffffffffc0207f44:	8d890913          	addi	s2,s2,-1832 # ffffffffc0295818 <vdev_list>
ffffffffc0207f48:	eb4fc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0207f4c:	844a                	mv	s0,s2
ffffffffc0207f4e:	a039                	j	ffffffffc0207f5c <vfs_do_add+0x72>
ffffffffc0207f50:	fe043503          	ld	a0,-32(s0)
ffffffffc0207f54:	85a6                	mv	a1,s1
ffffffffc0207f56:	06b030ef          	jal	ra,ffffffffc020b7c0 <strcmp>
ffffffffc0207f5a:	cd2d                	beqz	a0,ffffffffc0207fd4 <vfs_do_add+0xea>
ffffffffc0207f5c:	6400                	ld	s0,8(s0)
ffffffffc0207f5e:	ff2419e3          	bne	s0,s2,ffffffffc0207f50 <vfs_do_add+0x66>
ffffffffc0207f62:	6418                	ld	a4,8(s0)
ffffffffc0207f64:	02098793          	addi	a5,s3,32
ffffffffc0207f68:	0099b023          	sd	s1,0(s3)
ffffffffc0207f6c:	0149b423          	sd	s4,8(s3)
ffffffffc0207f70:	0159bc23          	sd	s5,24(s3)
ffffffffc0207f74:	0169b823          	sd	s6,16(s3)
ffffffffc0207f78:	e31c                	sd	a5,0(a4)
ffffffffc0207f7a:	0289b023          	sd	s0,32(s3)
ffffffffc0207f7e:	02e9b423          	sd	a4,40(s3)
ffffffffc0207f82:	0008e517          	auipc	a0,0x8e
ffffffffc0207f86:	8a650513          	addi	a0,a0,-1882 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207f8a:	e41c                	sd	a5,8(s0)
ffffffffc0207f8c:	4401                	li	s0,0
ffffffffc0207f8e:	e6afc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207f92:	70e2                	ld	ra,56(sp)
ffffffffc0207f94:	8522                	mv	a0,s0
ffffffffc0207f96:	7442                	ld	s0,48(sp)
ffffffffc0207f98:	74a2                	ld	s1,40(sp)
ffffffffc0207f9a:	7902                	ld	s2,32(sp)
ffffffffc0207f9c:	69e2                	ld	s3,24(sp)
ffffffffc0207f9e:	6a42                	ld	s4,16(sp)
ffffffffc0207fa0:	6aa2                	ld	s5,8(sp)
ffffffffc0207fa2:	6b02                	ld	s6,0(sp)
ffffffffc0207fa4:	6121                	addi	sp,sp,64
ffffffffc0207fa6:	8082                	ret
ffffffffc0207fa8:	5471                	li	s0,-4
ffffffffc0207faa:	8526                	mv	a0,s1
ffffffffc0207fac:	926fa0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0207fb0:	b7cd                	j	ffffffffc0207f92 <vfs_do_add+0xa8>
ffffffffc0207fb2:	d2b5                	beqz	a3,ffffffffc0207f16 <vfs_do_add+0x2c>
ffffffffc0207fb4:	00007697          	auipc	a3,0x7
ffffffffc0207fb8:	81c68693          	addi	a3,a3,-2020 # ffffffffc020e7d0 <syscalls+0xa70>
ffffffffc0207fbc:	00004617          	auipc	a2,0x4
ffffffffc0207fc0:	d4460613          	addi	a2,a2,-700 # ffffffffc020bd00 <commands+0x210>
ffffffffc0207fc4:	08f00593          	li	a1,143
ffffffffc0207fc8:	00006517          	auipc	a0,0x6
ffffffffc0207fcc:	7f050513          	addi	a0,a0,2032 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc0207fd0:	ccef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fd4:	0008e517          	auipc	a0,0x8e
ffffffffc0207fd8:	85450513          	addi	a0,a0,-1964 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207fdc:	e1cfc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0207fe0:	854e                	mv	a0,s3
ffffffffc0207fe2:	8f0fa0ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0207fe6:	5425                	li	s0,-23
ffffffffc0207fe8:	b7c9                	j	ffffffffc0207faa <vfs_do_add+0xc0>
ffffffffc0207fea:	5451                	li	s0,-12
ffffffffc0207fec:	b75d                	j	ffffffffc0207f92 <vfs_do_add+0xa8>
ffffffffc0207fee:	5471                	li	s0,-4
ffffffffc0207ff0:	b74d                	j	ffffffffc0207f92 <vfs_do_add+0xa8>
ffffffffc0207ff2:	00006697          	auipc	a3,0x6
ffffffffc0207ff6:	7b668693          	addi	a3,a3,1974 # ffffffffc020e7a8 <syscalls+0xa48>
ffffffffc0207ffa:	00004617          	auipc	a2,0x4
ffffffffc0207ffe:	d0660613          	addi	a2,a2,-762 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208002:	08e00593          	li	a1,142
ffffffffc0208006:	00006517          	auipc	a0,0x6
ffffffffc020800a:	7b250513          	addi	a0,a0,1970 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc020800e:	c90f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208012 <find_mount.part.0>:
ffffffffc0208012:	1141                	addi	sp,sp,-16
ffffffffc0208014:	00006697          	auipc	a3,0x6
ffffffffc0208018:	79468693          	addi	a3,a3,1940 # ffffffffc020e7a8 <syscalls+0xa48>
ffffffffc020801c:	00004617          	auipc	a2,0x4
ffffffffc0208020:	ce460613          	addi	a2,a2,-796 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208024:	0cd00593          	li	a1,205
ffffffffc0208028:	00006517          	auipc	a0,0x6
ffffffffc020802c:	79050513          	addi	a0,a0,1936 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc0208030:	e406                	sd	ra,8(sp)
ffffffffc0208032:	c6cf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208036 <vfs_devlist_init>:
ffffffffc0208036:	0008d797          	auipc	a5,0x8d
ffffffffc020803a:	7e278793          	addi	a5,a5,2018 # ffffffffc0295818 <vdev_list>
ffffffffc020803e:	4585                	li	a1,1
ffffffffc0208040:	0008d517          	auipc	a0,0x8d
ffffffffc0208044:	7e850513          	addi	a0,a0,2024 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0208048:	e79c                	sd	a5,8(a5)
ffffffffc020804a:	e39c                	sd	a5,0(a5)
ffffffffc020804c:	da6fc06f          	j	ffffffffc02045f2 <sem_init>

ffffffffc0208050 <vfs_cleanup>:
ffffffffc0208050:	1101                	addi	sp,sp,-32
ffffffffc0208052:	e426                	sd	s1,8(sp)
ffffffffc0208054:	0008d497          	auipc	s1,0x8d
ffffffffc0208058:	7c448493          	addi	s1,s1,1988 # ffffffffc0295818 <vdev_list>
ffffffffc020805c:	649c                	ld	a5,8(s1)
ffffffffc020805e:	ec06                	sd	ra,24(sp)
ffffffffc0208060:	e822                	sd	s0,16(sp)
ffffffffc0208062:	02978e63          	beq	a5,s1,ffffffffc020809e <vfs_cleanup+0x4e>
ffffffffc0208066:	0008d517          	auipc	a0,0x8d
ffffffffc020806a:	7c250513          	addi	a0,a0,1986 # ffffffffc0295828 <vdev_list_sem>
ffffffffc020806e:	d8efc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0208072:	6480                	ld	s0,8(s1)
ffffffffc0208074:	00940b63          	beq	s0,s1,ffffffffc020808a <vfs_cleanup+0x3a>
ffffffffc0208078:	ff043783          	ld	a5,-16(s0)
ffffffffc020807c:	853e                	mv	a0,a5
ffffffffc020807e:	c399                	beqz	a5,ffffffffc0208084 <vfs_cleanup+0x34>
ffffffffc0208080:	6bfc                	ld	a5,208(a5)
ffffffffc0208082:	9782                	jalr	a5
ffffffffc0208084:	6400                	ld	s0,8(s0)
ffffffffc0208086:	fe9419e3          	bne	s0,s1,ffffffffc0208078 <vfs_cleanup+0x28>
ffffffffc020808a:	6442                	ld	s0,16(sp)
ffffffffc020808c:	60e2                	ld	ra,24(sp)
ffffffffc020808e:	64a2                	ld	s1,8(sp)
ffffffffc0208090:	0008d517          	auipc	a0,0x8d
ffffffffc0208094:	79850513          	addi	a0,a0,1944 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0208098:	6105                	addi	sp,sp,32
ffffffffc020809a:	d5efc06f          	j	ffffffffc02045f8 <up>
ffffffffc020809e:	60e2                	ld	ra,24(sp)
ffffffffc02080a0:	6442                	ld	s0,16(sp)
ffffffffc02080a2:	64a2                	ld	s1,8(sp)
ffffffffc02080a4:	6105                	addi	sp,sp,32
ffffffffc02080a6:	8082                	ret

ffffffffc02080a8 <vfs_get_root>:
ffffffffc02080a8:	7179                	addi	sp,sp,-48
ffffffffc02080aa:	f406                	sd	ra,40(sp)
ffffffffc02080ac:	f022                	sd	s0,32(sp)
ffffffffc02080ae:	ec26                	sd	s1,24(sp)
ffffffffc02080b0:	e84a                	sd	s2,16(sp)
ffffffffc02080b2:	e44e                	sd	s3,8(sp)
ffffffffc02080b4:	e052                	sd	s4,0(sp)
ffffffffc02080b6:	c541                	beqz	a0,ffffffffc020813e <vfs_get_root+0x96>
ffffffffc02080b8:	0008d917          	auipc	s2,0x8d
ffffffffc02080bc:	76090913          	addi	s2,s2,1888 # ffffffffc0295818 <vdev_list>
ffffffffc02080c0:	00893783          	ld	a5,8(s2)
ffffffffc02080c4:	07278b63          	beq	a5,s2,ffffffffc020813a <vfs_get_root+0x92>
ffffffffc02080c8:	89aa                	mv	s3,a0
ffffffffc02080ca:	0008d517          	auipc	a0,0x8d
ffffffffc02080ce:	75e50513          	addi	a0,a0,1886 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02080d2:	8a2e                	mv	s4,a1
ffffffffc02080d4:	844a                	mv	s0,s2
ffffffffc02080d6:	d26fc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc02080da:	a801                	j	ffffffffc02080ea <vfs_get_root+0x42>
ffffffffc02080dc:	fe043583          	ld	a1,-32(s0)
ffffffffc02080e0:	854e                	mv	a0,s3
ffffffffc02080e2:	6de030ef          	jal	ra,ffffffffc020b7c0 <strcmp>
ffffffffc02080e6:	84aa                	mv	s1,a0
ffffffffc02080e8:	c505                	beqz	a0,ffffffffc0208110 <vfs_get_root+0x68>
ffffffffc02080ea:	6400                	ld	s0,8(s0)
ffffffffc02080ec:	ff2418e3          	bne	s0,s2,ffffffffc02080dc <vfs_get_root+0x34>
ffffffffc02080f0:	54cd                	li	s1,-13
ffffffffc02080f2:	0008d517          	auipc	a0,0x8d
ffffffffc02080f6:	73650513          	addi	a0,a0,1846 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02080fa:	cfefc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc02080fe:	70a2                	ld	ra,40(sp)
ffffffffc0208100:	7402                	ld	s0,32(sp)
ffffffffc0208102:	6942                	ld	s2,16(sp)
ffffffffc0208104:	69a2                	ld	s3,8(sp)
ffffffffc0208106:	6a02                	ld	s4,0(sp)
ffffffffc0208108:	8526                	mv	a0,s1
ffffffffc020810a:	64e2                	ld	s1,24(sp)
ffffffffc020810c:	6145                	addi	sp,sp,48
ffffffffc020810e:	8082                	ret
ffffffffc0208110:	ff043503          	ld	a0,-16(s0)
ffffffffc0208114:	c519                	beqz	a0,ffffffffc0208122 <vfs_get_root+0x7a>
ffffffffc0208116:	617c                	ld	a5,192(a0)
ffffffffc0208118:	9782                	jalr	a5
ffffffffc020811a:	c519                	beqz	a0,ffffffffc0208128 <vfs_get_root+0x80>
ffffffffc020811c:	00aa3023          	sd	a0,0(s4)
ffffffffc0208120:	bfc9                	j	ffffffffc02080f2 <vfs_get_root+0x4a>
ffffffffc0208122:	ff843783          	ld	a5,-8(s0)
ffffffffc0208126:	c399                	beqz	a5,ffffffffc020812c <vfs_get_root+0x84>
ffffffffc0208128:	54c9                	li	s1,-14
ffffffffc020812a:	b7e1                	j	ffffffffc02080f2 <vfs_get_root+0x4a>
ffffffffc020812c:	fe843503          	ld	a0,-24(s0)
ffffffffc0208130:	a99ff0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc0208134:	fe843503          	ld	a0,-24(s0)
ffffffffc0208138:	b7cd                	j	ffffffffc020811a <vfs_get_root+0x72>
ffffffffc020813a:	54cd                	li	s1,-13
ffffffffc020813c:	b7c9                	j	ffffffffc02080fe <vfs_get_root+0x56>
ffffffffc020813e:	00006697          	auipc	a3,0x6
ffffffffc0208142:	66a68693          	addi	a3,a3,1642 # ffffffffc020e7a8 <syscalls+0xa48>
ffffffffc0208146:	00004617          	auipc	a2,0x4
ffffffffc020814a:	bba60613          	addi	a2,a2,-1094 # ffffffffc020bd00 <commands+0x210>
ffffffffc020814e:	04500593          	li	a1,69
ffffffffc0208152:	00006517          	auipc	a0,0x6
ffffffffc0208156:	66650513          	addi	a0,a0,1638 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc020815a:	b44f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020815e <vfs_get_devname>:
ffffffffc020815e:	0008d697          	auipc	a3,0x8d
ffffffffc0208162:	6ba68693          	addi	a3,a3,1722 # ffffffffc0295818 <vdev_list>
ffffffffc0208166:	87b6                	mv	a5,a3
ffffffffc0208168:	e511                	bnez	a0,ffffffffc0208174 <vfs_get_devname+0x16>
ffffffffc020816a:	a829                	j	ffffffffc0208184 <vfs_get_devname+0x26>
ffffffffc020816c:	ff07b703          	ld	a4,-16(a5)
ffffffffc0208170:	00a70763          	beq	a4,a0,ffffffffc020817e <vfs_get_devname+0x20>
ffffffffc0208174:	679c                	ld	a5,8(a5)
ffffffffc0208176:	fed79be3          	bne	a5,a3,ffffffffc020816c <vfs_get_devname+0xe>
ffffffffc020817a:	4501                	li	a0,0
ffffffffc020817c:	8082                	ret
ffffffffc020817e:	fe07b503          	ld	a0,-32(a5)
ffffffffc0208182:	8082                	ret
ffffffffc0208184:	1141                	addi	sp,sp,-16
ffffffffc0208186:	00006697          	auipc	a3,0x6
ffffffffc020818a:	6aa68693          	addi	a3,a3,1706 # ffffffffc020e830 <syscalls+0xad0>
ffffffffc020818e:	00004617          	auipc	a2,0x4
ffffffffc0208192:	b7260613          	addi	a2,a2,-1166 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208196:	06a00593          	li	a1,106
ffffffffc020819a:	00006517          	auipc	a0,0x6
ffffffffc020819e:	61e50513          	addi	a0,a0,1566 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc02081a2:	e406                	sd	ra,8(sp)
ffffffffc02081a4:	afaf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02081a8 <vfs_add_dev>:
ffffffffc02081a8:	86b2                	mv	a3,a2
ffffffffc02081aa:	4601                	li	a2,0
ffffffffc02081ac:	d3fff06f          	j	ffffffffc0207eea <vfs_do_add>

ffffffffc02081b0 <vfs_mount>:
ffffffffc02081b0:	7179                	addi	sp,sp,-48
ffffffffc02081b2:	e84a                	sd	s2,16(sp)
ffffffffc02081b4:	892a                	mv	s2,a0
ffffffffc02081b6:	0008d517          	auipc	a0,0x8d
ffffffffc02081ba:	67250513          	addi	a0,a0,1650 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02081be:	e44e                	sd	s3,8(sp)
ffffffffc02081c0:	f406                	sd	ra,40(sp)
ffffffffc02081c2:	f022                	sd	s0,32(sp)
ffffffffc02081c4:	ec26                	sd	s1,24(sp)
ffffffffc02081c6:	89ae                	mv	s3,a1
ffffffffc02081c8:	c34fc0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc02081cc:	08090a63          	beqz	s2,ffffffffc0208260 <vfs_mount+0xb0>
ffffffffc02081d0:	0008d497          	auipc	s1,0x8d
ffffffffc02081d4:	64848493          	addi	s1,s1,1608 # ffffffffc0295818 <vdev_list>
ffffffffc02081d8:	6480                	ld	s0,8(s1)
ffffffffc02081da:	00941663          	bne	s0,s1,ffffffffc02081e6 <vfs_mount+0x36>
ffffffffc02081de:	a8ad                	j	ffffffffc0208258 <vfs_mount+0xa8>
ffffffffc02081e0:	6400                	ld	s0,8(s0)
ffffffffc02081e2:	06940b63          	beq	s0,s1,ffffffffc0208258 <vfs_mount+0xa8>
ffffffffc02081e6:	ff843783          	ld	a5,-8(s0)
ffffffffc02081ea:	dbfd                	beqz	a5,ffffffffc02081e0 <vfs_mount+0x30>
ffffffffc02081ec:	fe043503          	ld	a0,-32(s0)
ffffffffc02081f0:	85ca                	mv	a1,s2
ffffffffc02081f2:	5ce030ef          	jal	ra,ffffffffc020b7c0 <strcmp>
ffffffffc02081f6:	f56d                	bnez	a0,ffffffffc02081e0 <vfs_mount+0x30>
ffffffffc02081f8:	ff043783          	ld	a5,-16(s0)
ffffffffc02081fc:	e3a5                	bnez	a5,ffffffffc020825c <vfs_mount+0xac>
ffffffffc02081fe:	fe043783          	ld	a5,-32(s0)
ffffffffc0208202:	c3c9                	beqz	a5,ffffffffc0208284 <vfs_mount+0xd4>
ffffffffc0208204:	ff843783          	ld	a5,-8(s0)
ffffffffc0208208:	cfb5                	beqz	a5,ffffffffc0208284 <vfs_mount+0xd4>
ffffffffc020820a:	fe843503          	ld	a0,-24(s0)
ffffffffc020820e:	c939                	beqz	a0,ffffffffc0208264 <vfs_mount+0xb4>
ffffffffc0208210:	4d38                	lw	a4,88(a0)
ffffffffc0208212:	6785                	lui	a5,0x1
ffffffffc0208214:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208218:	04f71663          	bne	a4,a5,ffffffffc0208264 <vfs_mount+0xb4>
ffffffffc020821c:	ff040593          	addi	a1,s0,-16
ffffffffc0208220:	9982                	jalr	s3
ffffffffc0208222:	84aa                	mv	s1,a0
ffffffffc0208224:	ed01                	bnez	a0,ffffffffc020823c <vfs_mount+0x8c>
ffffffffc0208226:	ff043783          	ld	a5,-16(s0)
ffffffffc020822a:	cfad                	beqz	a5,ffffffffc02082a4 <vfs_mount+0xf4>
ffffffffc020822c:	fe043583          	ld	a1,-32(s0)
ffffffffc0208230:	00006517          	auipc	a0,0x6
ffffffffc0208234:	69050513          	addi	a0,a0,1680 # ffffffffc020e8c0 <syscalls+0xb60>
ffffffffc0208238:	f6ff70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020823c:	0008d517          	auipc	a0,0x8d
ffffffffc0208240:	5ec50513          	addi	a0,a0,1516 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0208244:	bb4fc0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0208248:	70a2                	ld	ra,40(sp)
ffffffffc020824a:	7402                	ld	s0,32(sp)
ffffffffc020824c:	6942                	ld	s2,16(sp)
ffffffffc020824e:	69a2                	ld	s3,8(sp)
ffffffffc0208250:	8526                	mv	a0,s1
ffffffffc0208252:	64e2                	ld	s1,24(sp)
ffffffffc0208254:	6145                	addi	sp,sp,48
ffffffffc0208256:	8082                	ret
ffffffffc0208258:	54cd                	li	s1,-13
ffffffffc020825a:	b7cd                	j	ffffffffc020823c <vfs_mount+0x8c>
ffffffffc020825c:	54c5                	li	s1,-15
ffffffffc020825e:	bff9                	j	ffffffffc020823c <vfs_mount+0x8c>
ffffffffc0208260:	db3ff0ef          	jal	ra,ffffffffc0208012 <find_mount.part.0>
ffffffffc0208264:	00006697          	auipc	a3,0x6
ffffffffc0208268:	60c68693          	addi	a3,a3,1548 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc020826c:	00004617          	auipc	a2,0x4
ffffffffc0208270:	a9460613          	addi	a2,a2,-1388 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208274:	0ed00593          	li	a1,237
ffffffffc0208278:	00006517          	auipc	a0,0x6
ffffffffc020827c:	54050513          	addi	a0,a0,1344 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc0208280:	a1ef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208284:	00006697          	auipc	a3,0x6
ffffffffc0208288:	5bc68693          	addi	a3,a3,1468 # ffffffffc020e840 <syscalls+0xae0>
ffffffffc020828c:	00004617          	auipc	a2,0x4
ffffffffc0208290:	a7460613          	addi	a2,a2,-1420 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208294:	0eb00593          	li	a1,235
ffffffffc0208298:	00006517          	auipc	a0,0x6
ffffffffc020829c:	52050513          	addi	a0,a0,1312 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc02082a0:	9fef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082a4:	00006697          	auipc	a3,0x6
ffffffffc02082a8:	60468693          	addi	a3,a3,1540 # ffffffffc020e8a8 <syscalls+0xb48>
ffffffffc02082ac:	00004617          	auipc	a2,0x4
ffffffffc02082b0:	a5460613          	addi	a2,a2,-1452 # ffffffffc020bd00 <commands+0x210>
ffffffffc02082b4:	0ef00593          	li	a1,239
ffffffffc02082b8:	00006517          	auipc	a0,0x6
ffffffffc02082bc:	50050513          	addi	a0,a0,1280 # ffffffffc020e7b8 <syscalls+0xa58>
ffffffffc02082c0:	9def80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02082c4 <vfs_open>:
ffffffffc02082c4:	711d                	addi	sp,sp,-96
ffffffffc02082c6:	e4a6                	sd	s1,72(sp)
ffffffffc02082c8:	e0ca                	sd	s2,64(sp)
ffffffffc02082ca:	fc4e                	sd	s3,56(sp)
ffffffffc02082cc:	ec86                	sd	ra,88(sp)
ffffffffc02082ce:	e8a2                	sd	s0,80(sp)
ffffffffc02082d0:	f852                	sd	s4,48(sp)
ffffffffc02082d2:	f456                	sd	s5,40(sp)
ffffffffc02082d4:	0035f793          	andi	a5,a1,3
ffffffffc02082d8:	84ae                	mv	s1,a1
ffffffffc02082da:	892a                	mv	s2,a0
ffffffffc02082dc:	89b2                	mv	s3,a2
ffffffffc02082de:	0e078663          	beqz	a5,ffffffffc02083ca <vfs_open+0x106>
ffffffffc02082e2:	470d                	li	a4,3
ffffffffc02082e4:	0105fa93          	andi	s5,a1,16
ffffffffc02082e8:	0ce78f63          	beq	a5,a4,ffffffffc02083c6 <vfs_open+0x102>
ffffffffc02082ec:	002c                	addi	a1,sp,8
ffffffffc02082ee:	854a                	mv	a0,s2
ffffffffc02082f0:	2ae000ef          	jal	ra,ffffffffc020859e <vfs_lookup>
ffffffffc02082f4:	842a                	mv	s0,a0
ffffffffc02082f6:	0044fa13          	andi	s4,s1,4
ffffffffc02082fa:	e159                	bnez	a0,ffffffffc0208380 <vfs_open+0xbc>
ffffffffc02082fc:	00c4f793          	andi	a5,s1,12
ffffffffc0208300:	4731                	li	a4,12
ffffffffc0208302:	0ee78263          	beq	a5,a4,ffffffffc02083e6 <vfs_open+0x122>
ffffffffc0208306:	6422                	ld	s0,8(sp)
ffffffffc0208308:	12040163          	beqz	s0,ffffffffc020842a <vfs_open+0x166>
ffffffffc020830c:	783c                	ld	a5,112(s0)
ffffffffc020830e:	cff1                	beqz	a5,ffffffffc02083ea <vfs_open+0x126>
ffffffffc0208310:	679c                	ld	a5,8(a5)
ffffffffc0208312:	cfe1                	beqz	a5,ffffffffc02083ea <vfs_open+0x126>
ffffffffc0208314:	8522                	mv	a0,s0
ffffffffc0208316:	00006597          	auipc	a1,0x6
ffffffffc020831a:	68a58593          	addi	a1,a1,1674 # ffffffffc020e9a0 <syscalls+0xc40>
ffffffffc020831e:	8c3ff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0208322:	783c                	ld	a5,112(s0)
ffffffffc0208324:	6522                	ld	a0,8(sp)
ffffffffc0208326:	85a6                	mv	a1,s1
ffffffffc0208328:	679c                	ld	a5,8(a5)
ffffffffc020832a:	9782                	jalr	a5
ffffffffc020832c:	842a                	mv	s0,a0
ffffffffc020832e:	6522                	ld	a0,8(sp)
ffffffffc0208330:	e845                	bnez	s0,ffffffffc02083e0 <vfs_open+0x11c>
ffffffffc0208332:	015a6a33          	or	s4,s4,s5
ffffffffc0208336:	89fff0ef          	jal	ra,ffffffffc0207bd4 <inode_open_inc>
ffffffffc020833a:	020a0663          	beqz	s4,ffffffffc0208366 <vfs_open+0xa2>
ffffffffc020833e:	64a2                	ld	s1,8(sp)
ffffffffc0208340:	c4e9                	beqz	s1,ffffffffc020840a <vfs_open+0x146>
ffffffffc0208342:	78bc                	ld	a5,112(s1)
ffffffffc0208344:	c3f9                	beqz	a5,ffffffffc020840a <vfs_open+0x146>
ffffffffc0208346:	73bc                	ld	a5,96(a5)
ffffffffc0208348:	c3e9                	beqz	a5,ffffffffc020840a <vfs_open+0x146>
ffffffffc020834a:	00006597          	auipc	a1,0x6
ffffffffc020834e:	6b658593          	addi	a1,a1,1718 # ffffffffc020ea00 <syscalls+0xca0>
ffffffffc0208352:	8526                	mv	a0,s1
ffffffffc0208354:	88dff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0208358:	78bc                	ld	a5,112(s1)
ffffffffc020835a:	6522                	ld	a0,8(sp)
ffffffffc020835c:	4581                	li	a1,0
ffffffffc020835e:	73bc                	ld	a5,96(a5)
ffffffffc0208360:	9782                	jalr	a5
ffffffffc0208362:	87aa                	mv	a5,a0
ffffffffc0208364:	e92d                	bnez	a0,ffffffffc02083d6 <vfs_open+0x112>
ffffffffc0208366:	67a2                	ld	a5,8(sp)
ffffffffc0208368:	00f9b023          	sd	a5,0(s3)
ffffffffc020836c:	60e6                	ld	ra,88(sp)
ffffffffc020836e:	8522                	mv	a0,s0
ffffffffc0208370:	6446                	ld	s0,80(sp)
ffffffffc0208372:	64a6                	ld	s1,72(sp)
ffffffffc0208374:	6906                	ld	s2,64(sp)
ffffffffc0208376:	79e2                	ld	s3,56(sp)
ffffffffc0208378:	7a42                	ld	s4,48(sp)
ffffffffc020837a:	7aa2                	ld	s5,40(sp)
ffffffffc020837c:	6125                	addi	sp,sp,96
ffffffffc020837e:	8082                	ret
ffffffffc0208380:	57c1                	li	a5,-16
ffffffffc0208382:	fef515e3          	bne	a0,a5,ffffffffc020836c <vfs_open+0xa8>
ffffffffc0208386:	fe0a03e3          	beqz	s4,ffffffffc020836c <vfs_open+0xa8>
ffffffffc020838a:	0810                	addi	a2,sp,16
ffffffffc020838c:	082c                	addi	a1,sp,24
ffffffffc020838e:	854a                	mv	a0,s2
ffffffffc0208390:	2a4000ef          	jal	ra,ffffffffc0208634 <vfs_lookup_parent>
ffffffffc0208394:	842a                	mv	s0,a0
ffffffffc0208396:	f979                	bnez	a0,ffffffffc020836c <vfs_open+0xa8>
ffffffffc0208398:	6462                	ld	s0,24(sp)
ffffffffc020839a:	c845                	beqz	s0,ffffffffc020844a <vfs_open+0x186>
ffffffffc020839c:	783c                	ld	a5,112(s0)
ffffffffc020839e:	c7d5                	beqz	a5,ffffffffc020844a <vfs_open+0x186>
ffffffffc02083a0:	77bc                	ld	a5,104(a5)
ffffffffc02083a2:	c7c5                	beqz	a5,ffffffffc020844a <vfs_open+0x186>
ffffffffc02083a4:	8522                	mv	a0,s0
ffffffffc02083a6:	00006597          	auipc	a1,0x6
ffffffffc02083aa:	59258593          	addi	a1,a1,1426 # ffffffffc020e938 <syscalls+0xbd8>
ffffffffc02083ae:	833ff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc02083b2:	783c                	ld	a5,112(s0)
ffffffffc02083b4:	65c2                	ld	a1,16(sp)
ffffffffc02083b6:	6562                	ld	a0,24(sp)
ffffffffc02083b8:	77bc                	ld	a5,104(a5)
ffffffffc02083ba:	4034d613          	srai	a2,s1,0x3
ffffffffc02083be:	0034                	addi	a3,sp,8
ffffffffc02083c0:	8a05                	andi	a2,a2,1
ffffffffc02083c2:	9782                	jalr	a5
ffffffffc02083c4:	b789                	j	ffffffffc0208306 <vfs_open+0x42>
ffffffffc02083c6:	5475                	li	s0,-3
ffffffffc02083c8:	b755                	j	ffffffffc020836c <vfs_open+0xa8>
ffffffffc02083ca:	0105fa93          	andi	s5,a1,16
ffffffffc02083ce:	5475                	li	s0,-3
ffffffffc02083d0:	f80a9ee3          	bnez	s5,ffffffffc020836c <vfs_open+0xa8>
ffffffffc02083d4:	bf21                	j	ffffffffc02082ec <vfs_open+0x28>
ffffffffc02083d6:	6522                	ld	a0,8(sp)
ffffffffc02083d8:	843e                	mv	s0,a5
ffffffffc02083da:	965ff0ef          	jal	ra,ffffffffc0207d3e <inode_open_dec>
ffffffffc02083de:	6522                	ld	a0,8(sp)
ffffffffc02083e0:	8b7ff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc02083e4:	b761                	j	ffffffffc020836c <vfs_open+0xa8>
ffffffffc02083e6:	5425                	li	s0,-23
ffffffffc02083e8:	b751                	j	ffffffffc020836c <vfs_open+0xa8>
ffffffffc02083ea:	00006697          	auipc	a3,0x6
ffffffffc02083ee:	56668693          	addi	a3,a3,1382 # ffffffffc020e950 <syscalls+0xbf0>
ffffffffc02083f2:	00004617          	auipc	a2,0x4
ffffffffc02083f6:	90e60613          	addi	a2,a2,-1778 # ffffffffc020bd00 <commands+0x210>
ffffffffc02083fa:	03300593          	li	a1,51
ffffffffc02083fe:	00006517          	auipc	a0,0x6
ffffffffc0208402:	52250513          	addi	a0,a0,1314 # ffffffffc020e920 <syscalls+0xbc0>
ffffffffc0208406:	898f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020840a:	00006697          	auipc	a3,0x6
ffffffffc020840e:	59e68693          	addi	a3,a3,1438 # ffffffffc020e9a8 <syscalls+0xc48>
ffffffffc0208412:	00004617          	auipc	a2,0x4
ffffffffc0208416:	8ee60613          	addi	a2,a2,-1810 # ffffffffc020bd00 <commands+0x210>
ffffffffc020841a:	03a00593          	li	a1,58
ffffffffc020841e:	00006517          	auipc	a0,0x6
ffffffffc0208422:	50250513          	addi	a0,a0,1282 # ffffffffc020e920 <syscalls+0xbc0>
ffffffffc0208426:	878f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020842a:	00006697          	auipc	a3,0x6
ffffffffc020842e:	51668693          	addi	a3,a3,1302 # ffffffffc020e940 <syscalls+0xbe0>
ffffffffc0208432:	00004617          	auipc	a2,0x4
ffffffffc0208436:	8ce60613          	addi	a2,a2,-1842 # ffffffffc020bd00 <commands+0x210>
ffffffffc020843a:	03100593          	li	a1,49
ffffffffc020843e:	00006517          	auipc	a0,0x6
ffffffffc0208442:	4e250513          	addi	a0,a0,1250 # ffffffffc020e920 <syscalls+0xbc0>
ffffffffc0208446:	858f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020844a:	00006697          	auipc	a3,0x6
ffffffffc020844e:	48668693          	addi	a3,a3,1158 # ffffffffc020e8d0 <syscalls+0xb70>
ffffffffc0208452:	00004617          	auipc	a2,0x4
ffffffffc0208456:	8ae60613          	addi	a2,a2,-1874 # ffffffffc020bd00 <commands+0x210>
ffffffffc020845a:	02c00593          	li	a1,44
ffffffffc020845e:	00006517          	auipc	a0,0x6
ffffffffc0208462:	4c250513          	addi	a0,a0,1218 # ffffffffc020e920 <syscalls+0xbc0>
ffffffffc0208466:	838f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020846a <vfs_close>:
ffffffffc020846a:	1141                	addi	sp,sp,-16
ffffffffc020846c:	e406                	sd	ra,8(sp)
ffffffffc020846e:	e022                	sd	s0,0(sp)
ffffffffc0208470:	842a                	mv	s0,a0
ffffffffc0208472:	8cdff0ef          	jal	ra,ffffffffc0207d3e <inode_open_dec>
ffffffffc0208476:	8522                	mv	a0,s0
ffffffffc0208478:	81fff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020847c:	60a2                	ld	ra,8(sp)
ffffffffc020847e:	6402                	ld	s0,0(sp)
ffffffffc0208480:	4501                	li	a0,0
ffffffffc0208482:	0141                	addi	sp,sp,16
ffffffffc0208484:	8082                	ret

ffffffffc0208486 <get_device>:
ffffffffc0208486:	7179                	addi	sp,sp,-48
ffffffffc0208488:	ec26                	sd	s1,24(sp)
ffffffffc020848a:	e84a                	sd	s2,16(sp)
ffffffffc020848c:	f406                	sd	ra,40(sp)
ffffffffc020848e:	f022                	sd	s0,32(sp)
ffffffffc0208490:	00054303          	lbu	t1,0(a0)
ffffffffc0208494:	892e                	mv	s2,a1
ffffffffc0208496:	84b2                	mv	s1,a2
ffffffffc0208498:	02030463          	beqz	t1,ffffffffc02084c0 <get_device+0x3a>
ffffffffc020849c:	00150413          	addi	s0,a0,1
ffffffffc02084a0:	86a2                	mv	a3,s0
ffffffffc02084a2:	879a                	mv	a5,t1
ffffffffc02084a4:	4701                	li	a4,0
ffffffffc02084a6:	03a00813          	li	a6,58
ffffffffc02084aa:	02f00893          	li	a7,47
ffffffffc02084ae:	03078263          	beq	a5,a6,ffffffffc02084d2 <get_device+0x4c>
ffffffffc02084b2:	05178963          	beq	a5,a7,ffffffffc0208504 <get_device+0x7e>
ffffffffc02084b6:	0006c783          	lbu	a5,0(a3)
ffffffffc02084ba:	2705                	addiw	a4,a4,1
ffffffffc02084bc:	0685                	addi	a3,a3,1
ffffffffc02084be:	fbe5                	bnez	a5,ffffffffc02084ae <get_device+0x28>
ffffffffc02084c0:	7402                	ld	s0,32(sp)
ffffffffc02084c2:	00a93023          	sd	a0,0(s2)
ffffffffc02084c6:	70a2                	ld	ra,40(sp)
ffffffffc02084c8:	6942                	ld	s2,16(sp)
ffffffffc02084ca:	8526                	mv	a0,s1
ffffffffc02084cc:	64e2                	ld	s1,24(sp)
ffffffffc02084ce:	6145                	addi	sp,sp,48
ffffffffc02084d0:	a279                	j	ffffffffc020865e <vfs_get_curdir>
ffffffffc02084d2:	cb15                	beqz	a4,ffffffffc0208506 <get_device+0x80>
ffffffffc02084d4:	00e507b3          	add	a5,a0,a4
ffffffffc02084d8:	0705                	addi	a4,a4,1
ffffffffc02084da:	00078023          	sb	zero,0(a5)
ffffffffc02084de:	972a                	add	a4,a4,a0
ffffffffc02084e0:	02f00613          	li	a2,47
ffffffffc02084e4:	00074783          	lbu	a5,0(a4)
ffffffffc02084e8:	86ba                	mv	a3,a4
ffffffffc02084ea:	0705                	addi	a4,a4,1
ffffffffc02084ec:	fec78ce3          	beq	a5,a2,ffffffffc02084e4 <get_device+0x5e>
ffffffffc02084f0:	7402                	ld	s0,32(sp)
ffffffffc02084f2:	70a2                	ld	ra,40(sp)
ffffffffc02084f4:	00d93023          	sd	a3,0(s2)
ffffffffc02084f8:	85a6                	mv	a1,s1
ffffffffc02084fa:	6942                	ld	s2,16(sp)
ffffffffc02084fc:	64e2                	ld	s1,24(sp)
ffffffffc02084fe:	6145                	addi	sp,sp,48
ffffffffc0208500:	ba9ff06f          	j	ffffffffc02080a8 <vfs_get_root>
ffffffffc0208504:	ff55                	bnez	a4,ffffffffc02084c0 <get_device+0x3a>
ffffffffc0208506:	02f00793          	li	a5,47
ffffffffc020850a:	04f30563          	beq	t1,a5,ffffffffc0208554 <get_device+0xce>
ffffffffc020850e:	03a00793          	li	a5,58
ffffffffc0208512:	06f31663          	bne	t1,a5,ffffffffc020857e <get_device+0xf8>
ffffffffc0208516:	0028                	addi	a0,sp,8
ffffffffc0208518:	146000ef          	jal	ra,ffffffffc020865e <vfs_get_curdir>
ffffffffc020851c:	e515                	bnez	a0,ffffffffc0208548 <get_device+0xc2>
ffffffffc020851e:	67a2                	ld	a5,8(sp)
ffffffffc0208520:	77a8                	ld	a0,104(a5)
ffffffffc0208522:	cd15                	beqz	a0,ffffffffc020855e <get_device+0xd8>
ffffffffc0208524:	617c                	ld	a5,192(a0)
ffffffffc0208526:	9782                	jalr	a5
ffffffffc0208528:	87aa                	mv	a5,a0
ffffffffc020852a:	6522                	ld	a0,8(sp)
ffffffffc020852c:	e09c                	sd	a5,0(s1)
ffffffffc020852e:	f68ff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc0208532:	02f00713          	li	a4,47
ffffffffc0208536:	a011                	j	ffffffffc020853a <get_device+0xb4>
ffffffffc0208538:	0405                	addi	s0,s0,1
ffffffffc020853a:	00044783          	lbu	a5,0(s0)
ffffffffc020853e:	fee78de3          	beq	a5,a4,ffffffffc0208538 <get_device+0xb2>
ffffffffc0208542:	00893023          	sd	s0,0(s2)
ffffffffc0208546:	4501                	li	a0,0
ffffffffc0208548:	70a2                	ld	ra,40(sp)
ffffffffc020854a:	7402                	ld	s0,32(sp)
ffffffffc020854c:	64e2                	ld	s1,24(sp)
ffffffffc020854e:	6942                	ld	s2,16(sp)
ffffffffc0208550:	6145                	addi	sp,sp,48
ffffffffc0208552:	8082                	ret
ffffffffc0208554:	8526                	mv	a0,s1
ffffffffc0208556:	93fff0ef          	jal	ra,ffffffffc0207e94 <vfs_get_bootfs>
ffffffffc020855a:	dd61                	beqz	a0,ffffffffc0208532 <get_device+0xac>
ffffffffc020855c:	b7f5                	j	ffffffffc0208548 <get_device+0xc2>
ffffffffc020855e:	00006697          	auipc	a3,0x6
ffffffffc0208562:	4da68693          	addi	a3,a3,1242 # ffffffffc020ea38 <syscalls+0xcd8>
ffffffffc0208566:	00003617          	auipc	a2,0x3
ffffffffc020856a:	79a60613          	addi	a2,a2,1946 # ffffffffc020bd00 <commands+0x210>
ffffffffc020856e:	03900593          	li	a1,57
ffffffffc0208572:	00006517          	auipc	a0,0x6
ffffffffc0208576:	4ae50513          	addi	a0,a0,1198 # ffffffffc020ea20 <syscalls+0xcc0>
ffffffffc020857a:	f25f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020857e:	00006697          	auipc	a3,0x6
ffffffffc0208582:	49268693          	addi	a3,a3,1170 # ffffffffc020ea10 <syscalls+0xcb0>
ffffffffc0208586:	00003617          	auipc	a2,0x3
ffffffffc020858a:	77a60613          	addi	a2,a2,1914 # ffffffffc020bd00 <commands+0x210>
ffffffffc020858e:	03300593          	li	a1,51
ffffffffc0208592:	00006517          	auipc	a0,0x6
ffffffffc0208596:	48e50513          	addi	a0,a0,1166 # ffffffffc020ea20 <syscalls+0xcc0>
ffffffffc020859a:	f05f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020859e <vfs_lookup>:
ffffffffc020859e:	7139                	addi	sp,sp,-64
ffffffffc02085a0:	f426                	sd	s1,40(sp)
ffffffffc02085a2:	0830                	addi	a2,sp,24
ffffffffc02085a4:	84ae                	mv	s1,a1
ffffffffc02085a6:	002c                	addi	a1,sp,8
ffffffffc02085a8:	f822                	sd	s0,48(sp)
ffffffffc02085aa:	fc06                	sd	ra,56(sp)
ffffffffc02085ac:	f04a                	sd	s2,32(sp)
ffffffffc02085ae:	e42a                	sd	a0,8(sp)
ffffffffc02085b0:	ed7ff0ef          	jal	ra,ffffffffc0208486 <get_device>
ffffffffc02085b4:	842a                	mv	s0,a0
ffffffffc02085b6:	ed1d                	bnez	a0,ffffffffc02085f4 <vfs_lookup+0x56>
ffffffffc02085b8:	67a2                	ld	a5,8(sp)
ffffffffc02085ba:	6962                	ld	s2,24(sp)
ffffffffc02085bc:	0007c783          	lbu	a5,0(a5)
ffffffffc02085c0:	c3a9                	beqz	a5,ffffffffc0208602 <vfs_lookup+0x64>
ffffffffc02085c2:	04090963          	beqz	s2,ffffffffc0208614 <vfs_lookup+0x76>
ffffffffc02085c6:	07093783          	ld	a5,112(s2)
ffffffffc02085ca:	c7a9                	beqz	a5,ffffffffc0208614 <vfs_lookup+0x76>
ffffffffc02085cc:	7bbc                	ld	a5,112(a5)
ffffffffc02085ce:	c3b9                	beqz	a5,ffffffffc0208614 <vfs_lookup+0x76>
ffffffffc02085d0:	854a                	mv	a0,s2
ffffffffc02085d2:	00006597          	auipc	a1,0x6
ffffffffc02085d6:	4ce58593          	addi	a1,a1,1230 # ffffffffc020eaa0 <syscalls+0xd40>
ffffffffc02085da:	e06ff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc02085de:	07093783          	ld	a5,112(s2)
ffffffffc02085e2:	65a2                	ld	a1,8(sp)
ffffffffc02085e4:	6562                	ld	a0,24(sp)
ffffffffc02085e6:	7bbc                	ld	a5,112(a5)
ffffffffc02085e8:	8626                	mv	a2,s1
ffffffffc02085ea:	9782                	jalr	a5
ffffffffc02085ec:	842a                	mv	s0,a0
ffffffffc02085ee:	6562                	ld	a0,24(sp)
ffffffffc02085f0:	ea6ff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc02085f4:	70e2                	ld	ra,56(sp)
ffffffffc02085f6:	8522                	mv	a0,s0
ffffffffc02085f8:	7442                	ld	s0,48(sp)
ffffffffc02085fa:	74a2                	ld	s1,40(sp)
ffffffffc02085fc:	7902                	ld	s2,32(sp)
ffffffffc02085fe:	6121                	addi	sp,sp,64
ffffffffc0208600:	8082                	ret
ffffffffc0208602:	70e2                	ld	ra,56(sp)
ffffffffc0208604:	8522                	mv	a0,s0
ffffffffc0208606:	7442                	ld	s0,48(sp)
ffffffffc0208608:	0124b023          	sd	s2,0(s1)
ffffffffc020860c:	74a2                	ld	s1,40(sp)
ffffffffc020860e:	7902                	ld	s2,32(sp)
ffffffffc0208610:	6121                	addi	sp,sp,64
ffffffffc0208612:	8082                	ret
ffffffffc0208614:	00006697          	auipc	a3,0x6
ffffffffc0208618:	43c68693          	addi	a3,a3,1084 # ffffffffc020ea50 <syscalls+0xcf0>
ffffffffc020861c:	00003617          	auipc	a2,0x3
ffffffffc0208620:	6e460613          	addi	a2,a2,1764 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208624:	04f00593          	li	a1,79
ffffffffc0208628:	00006517          	auipc	a0,0x6
ffffffffc020862c:	3f850513          	addi	a0,a0,1016 # ffffffffc020ea20 <syscalls+0xcc0>
ffffffffc0208630:	e6ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208634 <vfs_lookup_parent>:
ffffffffc0208634:	7139                	addi	sp,sp,-64
ffffffffc0208636:	f822                	sd	s0,48(sp)
ffffffffc0208638:	f426                	sd	s1,40(sp)
ffffffffc020863a:	842e                	mv	s0,a1
ffffffffc020863c:	84b2                	mv	s1,a2
ffffffffc020863e:	002c                	addi	a1,sp,8
ffffffffc0208640:	0830                	addi	a2,sp,24
ffffffffc0208642:	fc06                	sd	ra,56(sp)
ffffffffc0208644:	e42a                	sd	a0,8(sp)
ffffffffc0208646:	e41ff0ef          	jal	ra,ffffffffc0208486 <get_device>
ffffffffc020864a:	e509                	bnez	a0,ffffffffc0208654 <vfs_lookup_parent+0x20>
ffffffffc020864c:	67a2                	ld	a5,8(sp)
ffffffffc020864e:	e09c                	sd	a5,0(s1)
ffffffffc0208650:	67e2                	ld	a5,24(sp)
ffffffffc0208652:	e01c                	sd	a5,0(s0)
ffffffffc0208654:	70e2                	ld	ra,56(sp)
ffffffffc0208656:	7442                	ld	s0,48(sp)
ffffffffc0208658:	74a2                	ld	s1,40(sp)
ffffffffc020865a:	6121                	addi	sp,sp,64
ffffffffc020865c:	8082                	ret

ffffffffc020865e <vfs_get_curdir>:
ffffffffc020865e:	0008e797          	auipc	a5,0x8e
ffffffffc0208662:	2627b783          	ld	a5,610(a5) # ffffffffc02968c0 <current>
ffffffffc0208666:	1487b783          	ld	a5,328(a5)
ffffffffc020866a:	1101                	addi	sp,sp,-32
ffffffffc020866c:	e426                	sd	s1,8(sp)
ffffffffc020866e:	6384                	ld	s1,0(a5)
ffffffffc0208670:	ec06                	sd	ra,24(sp)
ffffffffc0208672:	e822                	sd	s0,16(sp)
ffffffffc0208674:	cc81                	beqz	s1,ffffffffc020868c <vfs_get_curdir+0x2e>
ffffffffc0208676:	842a                	mv	s0,a0
ffffffffc0208678:	8526                	mv	a0,s1
ffffffffc020867a:	d4eff0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc020867e:	4501                	li	a0,0
ffffffffc0208680:	e004                	sd	s1,0(s0)
ffffffffc0208682:	60e2                	ld	ra,24(sp)
ffffffffc0208684:	6442                	ld	s0,16(sp)
ffffffffc0208686:	64a2                	ld	s1,8(sp)
ffffffffc0208688:	6105                	addi	sp,sp,32
ffffffffc020868a:	8082                	ret
ffffffffc020868c:	5541                	li	a0,-16
ffffffffc020868e:	bfd5                	j	ffffffffc0208682 <vfs_get_curdir+0x24>

ffffffffc0208690 <vfs_set_curdir>:
ffffffffc0208690:	7139                	addi	sp,sp,-64
ffffffffc0208692:	f04a                	sd	s2,32(sp)
ffffffffc0208694:	0008e917          	auipc	s2,0x8e
ffffffffc0208698:	22c90913          	addi	s2,s2,556 # ffffffffc02968c0 <current>
ffffffffc020869c:	00093783          	ld	a5,0(s2)
ffffffffc02086a0:	f822                	sd	s0,48(sp)
ffffffffc02086a2:	842a                	mv	s0,a0
ffffffffc02086a4:	1487b503          	ld	a0,328(a5)
ffffffffc02086a8:	ec4e                	sd	s3,24(sp)
ffffffffc02086aa:	fc06                	sd	ra,56(sp)
ffffffffc02086ac:	f426                	sd	s1,40(sp)
ffffffffc02086ae:	badfc0ef          	jal	ra,ffffffffc020525a <lock_files>
ffffffffc02086b2:	00093783          	ld	a5,0(s2)
ffffffffc02086b6:	1487b503          	ld	a0,328(a5)
ffffffffc02086ba:	00053983          	ld	s3,0(a0)
ffffffffc02086be:	07340963          	beq	s0,s3,ffffffffc0208730 <vfs_set_curdir+0xa0>
ffffffffc02086c2:	cc39                	beqz	s0,ffffffffc0208720 <vfs_set_curdir+0x90>
ffffffffc02086c4:	783c                	ld	a5,112(s0)
ffffffffc02086c6:	c7bd                	beqz	a5,ffffffffc0208734 <vfs_set_curdir+0xa4>
ffffffffc02086c8:	6bbc                	ld	a5,80(a5)
ffffffffc02086ca:	c7ad                	beqz	a5,ffffffffc0208734 <vfs_set_curdir+0xa4>
ffffffffc02086cc:	00006597          	auipc	a1,0x6
ffffffffc02086d0:	44458593          	addi	a1,a1,1092 # ffffffffc020eb10 <syscalls+0xdb0>
ffffffffc02086d4:	8522                	mv	a0,s0
ffffffffc02086d6:	d0aff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc02086da:	783c                	ld	a5,112(s0)
ffffffffc02086dc:	006c                	addi	a1,sp,12
ffffffffc02086de:	8522                	mv	a0,s0
ffffffffc02086e0:	6bbc                	ld	a5,80(a5)
ffffffffc02086e2:	9782                	jalr	a5
ffffffffc02086e4:	84aa                	mv	s1,a0
ffffffffc02086e6:	e901                	bnez	a0,ffffffffc02086f6 <vfs_set_curdir+0x66>
ffffffffc02086e8:	47b2                	lw	a5,12(sp)
ffffffffc02086ea:	669d                	lui	a3,0x7
ffffffffc02086ec:	6709                	lui	a4,0x2
ffffffffc02086ee:	8ff5                	and	a5,a5,a3
ffffffffc02086f0:	54b9                	li	s1,-18
ffffffffc02086f2:	02e78063          	beq	a5,a4,ffffffffc0208712 <vfs_set_curdir+0x82>
ffffffffc02086f6:	00093783          	ld	a5,0(s2)
ffffffffc02086fa:	1487b503          	ld	a0,328(a5)
ffffffffc02086fe:	b63fc0ef          	jal	ra,ffffffffc0205260 <unlock_files>
ffffffffc0208702:	70e2                	ld	ra,56(sp)
ffffffffc0208704:	7442                	ld	s0,48(sp)
ffffffffc0208706:	7902                	ld	s2,32(sp)
ffffffffc0208708:	69e2                	ld	s3,24(sp)
ffffffffc020870a:	8526                	mv	a0,s1
ffffffffc020870c:	74a2                	ld	s1,40(sp)
ffffffffc020870e:	6121                	addi	sp,sp,64
ffffffffc0208710:	8082                	ret
ffffffffc0208712:	8522                	mv	a0,s0
ffffffffc0208714:	cb4ff0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc0208718:	00093783          	ld	a5,0(s2)
ffffffffc020871c:	1487b503          	ld	a0,328(a5)
ffffffffc0208720:	e100                	sd	s0,0(a0)
ffffffffc0208722:	4481                	li	s1,0
ffffffffc0208724:	fc098de3          	beqz	s3,ffffffffc02086fe <vfs_set_curdir+0x6e>
ffffffffc0208728:	854e                	mv	a0,s3
ffffffffc020872a:	d6cff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020872e:	b7e1                	j	ffffffffc02086f6 <vfs_set_curdir+0x66>
ffffffffc0208730:	4481                	li	s1,0
ffffffffc0208732:	b7f1                	j	ffffffffc02086fe <vfs_set_curdir+0x6e>
ffffffffc0208734:	00006697          	auipc	a3,0x6
ffffffffc0208738:	37468693          	addi	a3,a3,884 # ffffffffc020eaa8 <syscalls+0xd48>
ffffffffc020873c:	00003617          	auipc	a2,0x3
ffffffffc0208740:	5c460613          	addi	a2,a2,1476 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208744:	04300593          	li	a1,67
ffffffffc0208748:	00006517          	auipc	a0,0x6
ffffffffc020874c:	3b050513          	addi	a0,a0,944 # ffffffffc020eaf8 <syscalls+0xd98>
ffffffffc0208750:	d4ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208754 <vfs_chdir>:
ffffffffc0208754:	1101                	addi	sp,sp,-32
ffffffffc0208756:	002c                	addi	a1,sp,8
ffffffffc0208758:	e822                	sd	s0,16(sp)
ffffffffc020875a:	ec06                	sd	ra,24(sp)
ffffffffc020875c:	e43ff0ef          	jal	ra,ffffffffc020859e <vfs_lookup>
ffffffffc0208760:	842a                	mv	s0,a0
ffffffffc0208762:	c511                	beqz	a0,ffffffffc020876e <vfs_chdir+0x1a>
ffffffffc0208764:	60e2                	ld	ra,24(sp)
ffffffffc0208766:	8522                	mv	a0,s0
ffffffffc0208768:	6442                	ld	s0,16(sp)
ffffffffc020876a:	6105                	addi	sp,sp,32
ffffffffc020876c:	8082                	ret
ffffffffc020876e:	6522                	ld	a0,8(sp)
ffffffffc0208770:	f21ff0ef          	jal	ra,ffffffffc0208690 <vfs_set_curdir>
ffffffffc0208774:	842a                	mv	s0,a0
ffffffffc0208776:	6522                	ld	a0,8(sp)
ffffffffc0208778:	d1eff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020877c:	60e2                	ld	ra,24(sp)
ffffffffc020877e:	8522                	mv	a0,s0
ffffffffc0208780:	6442                	ld	s0,16(sp)
ffffffffc0208782:	6105                	addi	sp,sp,32
ffffffffc0208784:	8082                	ret

ffffffffc0208786 <vfs_getcwd>:
ffffffffc0208786:	0008e797          	auipc	a5,0x8e
ffffffffc020878a:	13a7b783          	ld	a5,314(a5) # ffffffffc02968c0 <current>
ffffffffc020878e:	1487b783          	ld	a5,328(a5)
ffffffffc0208792:	7179                	addi	sp,sp,-48
ffffffffc0208794:	ec26                	sd	s1,24(sp)
ffffffffc0208796:	6384                	ld	s1,0(a5)
ffffffffc0208798:	f406                	sd	ra,40(sp)
ffffffffc020879a:	f022                	sd	s0,32(sp)
ffffffffc020879c:	e84a                	sd	s2,16(sp)
ffffffffc020879e:	ccbd                	beqz	s1,ffffffffc020881c <vfs_getcwd+0x96>
ffffffffc02087a0:	892a                	mv	s2,a0
ffffffffc02087a2:	8526                	mv	a0,s1
ffffffffc02087a4:	c24ff0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc02087a8:	74a8                	ld	a0,104(s1)
ffffffffc02087aa:	c93d                	beqz	a0,ffffffffc0208820 <vfs_getcwd+0x9a>
ffffffffc02087ac:	9b3ff0ef          	jal	ra,ffffffffc020815e <vfs_get_devname>
ffffffffc02087b0:	842a                	mv	s0,a0
ffffffffc02087b2:	7c7020ef          	jal	ra,ffffffffc020b778 <strlen>
ffffffffc02087b6:	862a                	mv	a2,a0
ffffffffc02087b8:	85a2                	mv	a1,s0
ffffffffc02087ba:	4701                	li	a4,0
ffffffffc02087bc:	4685                	li	a3,1
ffffffffc02087be:	854a                	mv	a0,s2
ffffffffc02087c0:	cc5fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc02087c4:	842a                	mv	s0,a0
ffffffffc02087c6:	c919                	beqz	a0,ffffffffc02087dc <vfs_getcwd+0x56>
ffffffffc02087c8:	8526                	mv	a0,s1
ffffffffc02087ca:	cccff0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc02087ce:	70a2                	ld	ra,40(sp)
ffffffffc02087d0:	8522                	mv	a0,s0
ffffffffc02087d2:	7402                	ld	s0,32(sp)
ffffffffc02087d4:	64e2                	ld	s1,24(sp)
ffffffffc02087d6:	6942                	ld	s2,16(sp)
ffffffffc02087d8:	6145                	addi	sp,sp,48
ffffffffc02087da:	8082                	ret
ffffffffc02087dc:	03a00793          	li	a5,58
ffffffffc02087e0:	4701                	li	a4,0
ffffffffc02087e2:	4685                	li	a3,1
ffffffffc02087e4:	4605                	li	a2,1
ffffffffc02087e6:	00f10593          	addi	a1,sp,15
ffffffffc02087ea:	854a                	mv	a0,s2
ffffffffc02087ec:	00f107a3          	sb	a5,15(sp)
ffffffffc02087f0:	c95fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc02087f4:	842a                	mv	s0,a0
ffffffffc02087f6:	f969                	bnez	a0,ffffffffc02087c8 <vfs_getcwd+0x42>
ffffffffc02087f8:	78bc                	ld	a5,112(s1)
ffffffffc02087fa:	c3b9                	beqz	a5,ffffffffc0208840 <vfs_getcwd+0xba>
ffffffffc02087fc:	7f9c                	ld	a5,56(a5)
ffffffffc02087fe:	c3a9                	beqz	a5,ffffffffc0208840 <vfs_getcwd+0xba>
ffffffffc0208800:	00006597          	auipc	a1,0x6
ffffffffc0208804:	37058593          	addi	a1,a1,880 # ffffffffc020eb70 <syscalls+0xe10>
ffffffffc0208808:	8526                	mv	a0,s1
ffffffffc020880a:	bd6ff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc020880e:	78bc                	ld	a5,112(s1)
ffffffffc0208810:	85ca                	mv	a1,s2
ffffffffc0208812:	8526                	mv	a0,s1
ffffffffc0208814:	7f9c                	ld	a5,56(a5)
ffffffffc0208816:	9782                	jalr	a5
ffffffffc0208818:	842a                	mv	s0,a0
ffffffffc020881a:	b77d                	j	ffffffffc02087c8 <vfs_getcwd+0x42>
ffffffffc020881c:	5441                	li	s0,-16
ffffffffc020881e:	bf45                	j	ffffffffc02087ce <vfs_getcwd+0x48>
ffffffffc0208820:	00006697          	auipc	a3,0x6
ffffffffc0208824:	21868693          	addi	a3,a3,536 # ffffffffc020ea38 <syscalls+0xcd8>
ffffffffc0208828:	00003617          	auipc	a2,0x3
ffffffffc020882c:	4d860613          	addi	a2,a2,1240 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208830:	06e00593          	li	a1,110
ffffffffc0208834:	00006517          	auipc	a0,0x6
ffffffffc0208838:	2c450513          	addi	a0,a0,708 # ffffffffc020eaf8 <syscalls+0xd98>
ffffffffc020883c:	c63f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208840:	00006697          	auipc	a3,0x6
ffffffffc0208844:	2d868693          	addi	a3,a3,728 # ffffffffc020eb18 <syscalls+0xdb8>
ffffffffc0208848:	00003617          	auipc	a2,0x3
ffffffffc020884c:	4b860613          	addi	a2,a2,1208 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208850:	07800593          	li	a1,120
ffffffffc0208854:	00006517          	auipc	a0,0x6
ffffffffc0208858:	2a450513          	addi	a0,a0,676 # ffffffffc020eaf8 <syscalls+0xd98>
ffffffffc020885c:	c43f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208860 <dev_lookup>:
ffffffffc0208860:	0005c783          	lbu	a5,0(a1)
ffffffffc0208864:	e385                	bnez	a5,ffffffffc0208884 <dev_lookup+0x24>
ffffffffc0208866:	1101                	addi	sp,sp,-32
ffffffffc0208868:	e822                	sd	s0,16(sp)
ffffffffc020886a:	e426                	sd	s1,8(sp)
ffffffffc020886c:	ec06                	sd	ra,24(sp)
ffffffffc020886e:	84aa                	mv	s1,a0
ffffffffc0208870:	8432                	mv	s0,a2
ffffffffc0208872:	b56ff0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc0208876:	60e2                	ld	ra,24(sp)
ffffffffc0208878:	e004                	sd	s1,0(s0)
ffffffffc020887a:	6442                	ld	s0,16(sp)
ffffffffc020887c:	64a2                	ld	s1,8(sp)
ffffffffc020887e:	4501                	li	a0,0
ffffffffc0208880:	6105                	addi	sp,sp,32
ffffffffc0208882:	8082                	ret
ffffffffc0208884:	5541                	li	a0,-16
ffffffffc0208886:	8082                	ret

ffffffffc0208888 <dev_fstat>:
ffffffffc0208888:	1101                	addi	sp,sp,-32
ffffffffc020888a:	e426                	sd	s1,8(sp)
ffffffffc020888c:	84ae                	mv	s1,a1
ffffffffc020888e:	e822                	sd	s0,16(sp)
ffffffffc0208890:	02000613          	li	a2,32
ffffffffc0208894:	842a                	mv	s0,a0
ffffffffc0208896:	4581                	li	a1,0
ffffffffc0208898:	8526                	mv	a0,s1
ffffffffc020889a:	ec06                	sd	ra,24(sp)
ffffffffc020889c:	77f020ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc02088a0:	c429                	beqz	s0,ffffffffc02088ea <dev_fstat+0x62>
ffffffffc02088a2:	783c                	ld	a5,112(s0)
ffffffffc02088a4:	c3b9                	beqz	a5,ffffffffc02088ea <dev_fstat+0x62>
ffffffffc02088a6:	6bbc                	ld	a5,80(a5)
ffffffffc02088a8:	c3a9                	beqz	a5,ffffffffc02088ea <dev_fstat+0x62>
ffffffffc02088aa:	00006597          	auipc	a1,0x6
ffffffffc02088ae:	26658593          	addi	a1,a1,614 # ffffffffc020eb10 <syscalls+0xdb0>
ffffffffc02088b2:	8522                	mv	a0,s0
ffffffffc02088b4:	b2cff0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc02088b8:	783c                	ld	a5,112(s0)
ffffffffc02088ba:	85a6                	mv	a1,s1
ffffffffc02088bc:	8522                	mv	a0,s0
ffffffffc02088be:	6bbc                	ld	a5,80(a5)
ffffffffc02088c0:	9782                	jalr	a5
ffffffffc02088c2:	ed19                	bnez	a0,ffffffffc02088e0 <dev_fstat+0x58>
ffffffffc02088c4:	4c38                	lw	a4,88(s0)
ffffffffc02088c6:	6785                	lui	a5,0x1
ffffffffc02088c8:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02088cc:	02f71f63          	bne	a4,a5,ffffffffc020890a <dev_fstat+0x82>
ffffffffc02088d0:	6018                	ld	a4,0(s0)
ffffffffc02088d2:	641c                	ld	a5,8(s0)
ffffffffc02088d4:	4685                	li	a3,1
ffffffffc02088d6:	e494                	sd	a3,8(s1)
ffffffffc02088d8:	02e787b3          	mul	a5,a5,a4
ffffffffc02088dc:	e898                	sd	a4,16(s1)
ffffffffc02088de:	ec9c                	sd	a5,24(s1)
ffffffffc02088e0:	60e2                	ld	ra,24(sp)
ffffffffc02088e2:	6442                	ld	s0,16(sp)
ffffffffc02088e4:	64a2                	ld	s1,8(sp)
ffffffffc02088e6:	6105                	addi	sp,sp,32
ffffffffc02088e8:	8082                	ret
ffffffffc02088ea:	00006697          	auipc	a3,0x6
ffffffffc02088ee:	1be68693          	addi	a3,a3,446 # ffffffffc020eaa8 <syscalls+0xd48>
ffffffffc02088f2:	00003617          	auipc	a2,0x3
ffffffffc02088f6:	40e60613          	addi	a2,a2,1038 # ffffffffc020bd00 <commands+0x210>
ffffffffc02088fa:	04200593          	li	a1,66
ffffffffc02088fe:	00006517          	auipc	a0,0x6
ffffffffc0208902:	28250513          	addi	a0,a0,642 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc0208906:	b99f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020890a:	00006697          	auipc	a3,0x6
ffffffffc020890e:	f6668693          	addi	a3,a3,-154 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208912:	00003617          	auipc	a2,0x3
ffffffffc0208916:	3ee60613          	addi	a2,a2,1006 # ffffffffc020bd00 <commands+0x210>
ffffffffc020891a:	04500593          	li	a1,69
ffffffffc020891e:	00006517          	auipc	a0,0x6
ffffffffc0208922:	26250513          	addi	a0,a0,610 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc0208926:	b79f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020892a <dev_ioctl>:
ffffffffc020892a:	c909                	beqz	a0,ffffffffc020893c <dev_ioctl+0x12>
ffffffffc020892c:	4d34                	lw	a3,88(a0)
ffffffffc020892e:	6705                	lui	a4,0x1
ffffffffc0208930:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208934:	00e69463          	bne	a3,a4,ffffffffc020893c <dev_ioctl+0x12>
ffffffffc0208938:	751c                	ld	a5,40(a0)
ffffffffc020893a:	8782                	jr	a5
ffffffffc020893c:	1141                	addi	sp,sp,-16
ffffffffc020893e:	00006697          	auipc	a3,0x6
ffffffffc0208942:	f3268693          	addi	a3,a3,-206 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208946:	00003617          	auipc	a2,0x3
ffffffffc020894a:	3ba60613          	addi	a2,a2,954 # ffffffffc020bd00 <commands+0x210>
ffffffffc020894e:	03500593          	li	a1,53
ffffffffc0208952:	00006517          	auipc	a0,0x6
ffffffffc0208956:	22e50513          	addi	a0,a0,558 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc020895a:	e406                	sd	ra,8(sp)
ffffffffc020895c:	b43f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208960 <dev_tryseek>:
ffffffffc0208960:	c51d                	beqz	a0,ffffffffc020898e <dev_tryseek+0x2e>
ffffffffc0208962:	4d38                	lw	a4,88(a0)
ffffffffc0208964:	6785                	lui	a5,0x1
ffffffffc0208966:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020896a:	02f71263          	bne	a4,a5,ffffffffc020898e <dev_tryseek+0x2e>
ffffffffc020896e:	611c                	ld	a5,0(a0)
ffffffffc0208970:	cf89                	beqz	a5,ffffffffc020898a <dev_tryseek+0x2a>
ffffffffc0208972:	6518                	ld	a4,8(a0)
ffffffffc0208974:	02e5f6b3          	remu	a3,a1,a4
ffffffffc0208978:	ea89                	bnez	a3,ffffffffc020898a <dev_tryseek+0x2a>
ffffffffc020897a:	0005c863          	bltz	a1,ffffffffc020898a <dev_tryseek+0x2a>
ffffffffc020897e:	02e787b3          	mul	a5,a5,a4
ffffffffc0208982:	00f5f463          	bgeu	a1,a5,ffffffffc020898a <dev_tryseek+0x2a>
ffffffffc0208986:	4501                	li	a0,0
ffffffffc0208988:	8082                	ret
ffffffffc020898a:	5575                	li	a0,-3
ffffffffc020898c:	8082                	ret
ffffffffc020898e:	1141                	addi	sp,sp,-16
ffffffffc0208990:	00006697          	auipc	a3,0x6
ffffffffc0208994:	ee068693          	addi	a3,a3,-288 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208998:	00003617          	auipc	a2,0x3
ffffffffc020899c:	36860613          	addi	a2,a2,872 # ffffffffc020bd00 <commands+0x210>
ffffffffc02089a0:	05f00593          	li	a1,95
ffffffffc02089a4:	00006517          	auipc	a0,0x6
ffffffffc02089a8:	1dc50513          	addi	a0,a0,476 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc02089ac:	e406                	sd	ra,8(sp)
ffffffffc02089ae:	af1f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02089b2 <dev_gettype>:
ffffffffc02089b2:	c10d                	beqz	a0,ffffffffc02089d4 <dev_gettype+0x22>
ffffffffc02089b4:	4d38                	lw	a4,88(a0)
ffffffffc02089b6:	6785                	lui	a5,0x1
ffffffffc02089b8:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02089bc:	00f71c63          	bne	a4,a5,ffffffffc02089d4 <dev_gettype+0x22>
ffffffffc02089c0:	6118                	ld	a4,0(a0)
ffffffffc02089c2:	6795                	lui	a5,0x5
ffffffffc02089c4:	c701                	beqz	a4,ffffffffc02089cc <dev_gettype+0x1a>
ffffffffc02089c6:	c19c                	sw	a5,0(a1)
ffffffffc02089c8:	4501                	li	a0,0
ffffffffc02089ca:	8082                	ret
ffffffffc02089cc:	6791                	lui	a5,0x4
ffffffffc02089ce:	c19c                	sw	a5,0(a1)
ffffffffc02089d0:	4501                	li	a0,0
ffffffffc02089d2:	8082                	ret
ffffffffc02089d4:	1141                	addi	sp,sp,-16
ffffffffc02089d6:	00006697          	auipc	a3,0x6
ffffffffc02089da:	e9a68693          	addi	a3,a3,-358 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc02089de:	00003617          	auipc	a2,0x3
ffffffffc02089e2:	32260613          	addi	a2,a2,802 # ffffffffc020bd00 <commands+0x210>
ffffffffc02089e6:	05300593          	li	a1,83
ffffffffc02089ea:	00006517          	auipc	a0,0x6
ffffffffc02089ee:	19650513          	addi	a0,a0,406 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc02089f2:	e406                	sd	ra,8(sp)
ffffffffc02089f4:	aabf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02089f8 <dev_write>:
ffffffffc02089f8:	c911                	beqz	a0,ffffffffc0208a0c <dev_write+0x14>
ffffffffc02089fa:	4d34                	lw	a3,88(a0)
ffffffffc02089fc:	6705                	lui	a4,0x1
ffffffffc02089fe:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208a02:	00e69563          	bne	a3,a4,ffffffffc0208a0c <dev_write+0x14>
ffffffffc0208a06:	711c                	ld	a5,32(a0)
ffffffffc0208a08:	4605                	li	a2,1
ffffffffc0208a0a:	8782                	jr	a5
ffffffffc0208a0c:	1141                	addi	sp,sp,-16
ffffffffc0208a0e:	00006697          	auipc	a3,0x6
ffffffffc0208a12:	e6268693          	addi	a3,a3,-414 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208a16:	00003617          	auipc	a2,0x3
ffffffffc0208a1a:	2ea60613          	addi	a2,a2,746 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208a1e:	02c00593          	li	a1,44
ffffffffc0208a22:	00006517          	auipc	a0,0x6
ffffffffc0208a26:	15e50513          	addi	a0,a0,350 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc0208a2a:	e406                	sd	ra,8(sp)
ffffffffc0208a2c:	a73f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a30 <dev_read>:
ffffffffc0208a30:	c911                	beqz	a0,ffffffffc0208a44 <dev_read+0x14>
ffffffffc0208a32:	4d34                	lw	a3,88(a0)
ffffffffc0208a34:	6705                	lui	a4,0x1
ffffffffc0208a36:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208a3a:	00e69563          	bne	a3,a4,ffffffffc0208a44 <dev_read+0x14>
ffffffffc0208a3e:	711c                	ld	a5,32(a0)
ffffffffc0208a40:	4601                	li	a2,0
ffffffffc0208a42:	8782                	jr	a5
ffffffffc0208a44:	1141                	addi	sp,sp,-16
ffffffffc0208a46:	00006697          	auipc	a3,0x6
ffffffffc0208a4a:	e2a68693          	addi	a3,a3,-470 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208a4e:	00003617          	auipc	a2,0x3
ffffffffc0208a52:	2b260613          	addi	a2,a2,690 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208a56:	02300593          	li	a1,35
ffffffffc0208a5a:	00006517          	auipc	a0,0x6
ffffffffc0208a5e:	12650513          	addi	a0,a0,294 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc0208a62:	e406                	sd	ra,8(sp)
ffffffffc0208a64:	a3bf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a68 <dev_close>:
ffffffffc0208a68:	c909                	beqz	a0,ffffffffc0208a7a <dev_close+0x12>
ffffffffc0208a6a:	4d34                	lw	a3,88(a0)
ffffffffc0208a6c:	6705                	lui	a4,0x1
ffffffffc0208a6e:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208a72:	00e69463          	bne	a3,a4,ffffffffc0208a7a <dev_close+0x12>
ffffffffc0208a76:	6d1c                	ld	a5,24(a0)
ffffffffc0208a78:	8782                	jr	a5
ffffffffc0208a7a:	1141                	addi	sp,sp,-16
ffffffffc0208a7c:	00006697          	auipc	a3,0x6
ffffffffc0208a80:	df468693          	addi	a3,a3,-524 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208a84:	00003617          	auipc	a2,0x3
ffffffffc0208a88:	27c60613          	addi	a2,a2,636 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208a8c:	45e9                	li	a1,26
ffffffffc0208a8e:	00006517          	auipc	a0,0x6
ffffffffc0208a92:	0f250513          	addi	a0,a0,242 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc0208a96:	e406                	sd	ra,8(sp)
ffffffffc0208a98:	a07f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a9c <dev_open>:
ffffffffc0208a9c:	03c5f713          	andi	a4,a1,60
ffffffffc0208aa0:	eb11                	bnez	a4,ffffffffc0208ab4 <dev_open+0x18>
ffffffffc0208aa2:	c919                	beqz	a0,ffffffffc0208ab8 <dev_open+0x1c>
ffffffffc0208aa4:	4d34                	lw	a3,88(a0)
ffffffffc0208aa6:	6705                	lui	a4,0x1
ffffffffc0208aa8:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208aac:	00e69663          	bne	a3,a4,ffffffffc0208ab8 <dev_open+0x1c>
ffffffffc0208ab0:	691c                	ld	a5,16(a0)
ffffffffc0208ab2:	8782                	jr	a5
ffffffffc0208ab4:	5575                	li	a0,-3
ffffffffc0208ab6:	8082                	ret
ffffffffc0208ab8:	1141                	addi	sp,sp,-16
ffffffffc0208aba:	00006697          	auipc	a3,0x6
ffffffffc0208abe:	db668693          	addi	a3,a3,-586 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208ac2:	00003617          	auipc	a2,0x3
ffffffffc0208ac6:	23e60613          	addi	a2,a2,574 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208aca:	45c5                	li	a1,17
ffffffffc0208acc:	00006517          	auipc	a0,0x6
ffffffffc0208ad0:	0b450513          	addi	a0,a0,180 # ffffffffc020eb80 <syscalls+0xe20>
ffffffffc0208ad4:	e406                	sd	ra,8(sp)
ffffffffc0208ad6:	9c9f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ada <dev_init>:
ffffffffc0208ada:	1141                	addi	sp,sp,-16
ffffffffc0208adc:	e406                	sd	ra,8(sp)
ffffffffc0208ade:	542000ef          	jal	ra,ffffffffc0209020 <dev_init_stdin>
ffffffffc0208ae2:	65a000ef          	jal	ra,ffffffffc020913c <dev_init_stdout>
ffffffffc0208ae6:	60a2                	ld	ra,8(sp)
ffffffffc0208ae8:	0141                	addi	sp,sp,16
ffffffffc0208aea:	a439                	j	ffffffffc0208cf8 <dev_init_disk0>

ffffffffc0208aec <dev_create_inode>:
ffffffffc0208aec:	6505                	lui	a0,0x1
ffffffffc0208aee:	1141                	addi	sp,sp,-16
ffffffffc0208af0:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208af4:	e022                	sd	s0,0(sp)
ffffffffc0208af6:	e406                	sd	ra,8(sp)
ffffffffc0208af8:	852ff0ef          	jal	ra,ffffffffc0207b4a <__alloc_inode>
ffffffffc0208afc:	842a                	mv	s0,a0
ffffffffc0208afe:	c901                	beqz	a0,ffffffffc0208b0e <dev_create_inode+0x22>
ffffffffc0208b00:	4601                	li	a2,0
ffffffffc0208b02:	00006597          	auipc	a1,0x6
ffffffffc0208b06:	09658593          	addi	a1,a1,150 # ffffffffc020eb98 <dev_node_ops>
ffffffffc0208b0a:	85cff0ef          	jal	ra,ffffffffc0207b66 <inode_init>
ffffffffc0208b0e:	60a2                	ld	ra,8(sp)
ffffffffc0208b10:	8522                	mv	a0,s0
ffffffffc0208b12:	6402                	ld	s0,0(sp)
ffffffffc0208b14:	0141                	addi	sp,sp,16
ffffffffc0208b16:	8082                	ret

ffffffffc0208b18 <disk0_open>:
ffffffffc0208b18:	4501                	li	a0,0
ffffffffc0208b1a:	8082                	ret

ffffffffc0208b1c <disk0_close>:
ffffffffc0208b1c:	4501                	li	a0,0
ffffffffc0208b1e:	8082                	ret

ffffffffc0208b20 <disk0_ioctl>:
ffffffffc0208b20:	5531                	li	a0,-20
ffffffffc0208b22:	8082                	ret

ffffffffc0208b24 <disk0_io>:
ffffffffc0208b24:	659c                	ld	a5,8(a1)
ffffffffc0208b26:	7159                	addi	sp,sp,-112
ffffffffc0208b28:	eca6                	sd	s1,88(sp)
ffffffffc0208b2a:	f45e                	sd	s7,40(sp)
ffffffffc0208b2c:	6d84                	ld	s1,24(a1)
ffffffffc0208b2e:	6b85                	lui	s7,0x1
ffffffffc0208b30:	1bfd                	addi	s7,s7,-1
ffffffffc0208b32:	e4ce                	sd	s3,72(sp)
ffffffffc0208b34:	43f7d993          	srai	s3,a5,0x3f
ffffffffc0208b38:	0179f9b3          	and	s3,s3,s7
ffffffffc0208b3c:	99be                	add	s3,s3,a5
ffffffffc0208b3e:	8fc5                	or	a5,a5,s1
ffffffffc0208b40:	f486                	sd	ra,104(sp)
ffffffffc0208b42:	f0a2                	sd	s0,96(sp)
ffffffffc0208b44:	e8ca                	sd	s2,80(sp)
ffffffffc0208b46:	e0d2                	sd	s4,64(sp)
ffffffffc0208b48:	fc56                	sd	s5,56(sp)
ffffffffc0208b4a:	f85a                	sd	s6,48(sp)
ffffffffc0208b4c:	f062                	sd	s8,32(sp)
ffffffffc0208b4e:	ec66                	sd	s9,24(sp)
ffffffffc0208b50:	e86a                	sd	s10,16(sp)
ffffffffc0208b52:	0177f7b3          	and	a5,a5,s7
ffffffffc0208b56:	10079d63          	bnez	a5,ffffffffc0208c70 <disk0_io+0x14c>
ffffffffc0208b5a:	40c9d993          	srai	s3,s3,0xc
ffffffffc0208b5e:	00c4d713          	srli	a4,s1,0xc
ffffffffc0208b62:	2981                	sext.w	s3,s3
ffffffffc0208b64:	2701                	sext.w	a4,a4
ffffffffc0208b66:	00e987bb          	addw	a5,s3,a4
ffffffffc0208b6a:	6114                	ld	a3,0(a0)
ffffffffc0208b6c:	1782                	slli	a5,a5,0x20
ffffffffc0208b6e:	9381                	srli	a5,a5,0x20
ffffffffc0208b70:	10f6e063          	bltu	a3,a5,ffffffffc0208c70 <disk0_io+0x14c>
ffffffffc0208b74:	4501                	li	a0,0
ffffffffc0208b76:	ef19                	bnez	a4,ffffffffc0208b94 <disk0_io+0x70>
ffffffffc0208b78:	70a6                	ld	ra,104(sp)
ffffffffc0208b7a:	7406                	ld	s0,96(sp)
ffffffffc0208b7c:	64e6                	ld	s1,88(sp)
ffffffffc0208b7e:	6946                	ld	s2,80(sp)
ffffffffc0208b80:	69a6                	ld	s3,72(sp)
ffffffffc0208b82:	6a06                	ld	s4,64(sp)
ffffffffc0208b84:	7ae2                	ld	s5,56(sp)
ffffffffc0208b86:	7b42                	ld	s6,48(sp)
ffffffffc0208b88:	7ba2                	ld	s7,40(sp)
ffffffffc0208b8a:	7c02                	ld	s8,32(sp)
ffffffffc0208b8c:	6ce2                	ld	s9,24(sp)
ffffffffc0208b8e:	6d42                	ld	s10,16(sp)
ffffffffc0208b90:	6165                	addi	sp,sp,112
ffffffffc0208b92:	8082                	ret
ffffffffc0208b94:	0008d517          	auipc	a0,0x8d
ffffffffc0208b98:	cac50513          	addi	a0,a0,-852 # ffffffffc0295840 <disk0_sem>
ffffffffc0208b9c:	8b2e                	mv	s6,a1
ffffffffc0208b9e:	8c32                	mv	s8,a2
ffffffffc0208ba0:	0008ea97          	auipc	s5,0x8e
ffffffffc0208ba4:	d58a8a93          	addi	s5,s5,-680 # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208ba8:	a55fb0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0208bac:	6c91                	lui	s9,0x4
ffffffffc0208bae:	e4b9                	bnez	s1,ffffffffc0208bfc <disk0_io+0xd8>
ffffffffc0208bb0:	a845                	j	ffffffffc0208c60 <disk0_io+0x13c>
ffffffffc0208bb2:	00c4d413          	srli	s0,s1,0xc
ffffffffc0208bb6:	0034169b          	slliw	a3,s0,0x3
ffffffffc0208bba:	00068d1b          	sext.w	s10,a3
ffffffffc0208bbe:	1682                	slli	a3,a3,0x20
ffffffffc0208bc0:	2401                	sext.w	s0,s0
ffffffffc0208bc2:	9281                	srli	a3,a3,0x20
ffffffffc0208bc4:	8926                	mv	s2,s1
ffffffffc0208bc6:	00399a1b          	slliw	s4,s3,0x3
ffffffffc0208bca:	862e                	mv	a2,a1
ffffffffc0208bcc:	4509                	li	a0,2
ffffffffc0208bce:	85d2                	mv	a1,s4
ffffffffc0208bd0:	f71f70ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0208bd4:	e165                	bnez	a0,ffffffffc0208cb4 <disk0_io+0x190>
ffffffffc0208bd6:	000ab583          	ld	a1,0(s5)
ffffffffc0208bda:	0038                	addi	a4,sp,8
ffffffffc0208bdc:	4685                	li	a3,1
ffffffffc0208bde:	864a                	mv	a2,s2
ffffffffc0208be0:	855a                	mv	a0,s6
ffffffffc0208be2:	8a3fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc0208be6:	67a2                	ld	a5,8(sp)
ffffffffc0208be8:	09279663          	bne	a5,s2,ffffffffc0208c74 <disk0_io+0x150>
ffffffffc0208bec:	017977b3          	and	a5,s2,s7
ffffffffc0208bf0:	e3d1                	bnez	a5,ffffffffc0208c74 <disk0_io+0x150>
ffffffffc0208bf2:	412484b3          	sub	s1,s1,s2
ffffffffc0208bf6:	013409bb          	addw	s3,s0,s3
ffffffffc0208bfa:	c0bd                	beqz	s1,ffffffffc0208c60 <disk0_io+0x13c>
ffffffffc0208bfc:	000ab583          	ld	a1,0(s5)
ffffffffc0208c00:	000c1b63          	bnez	s8,ffffffffc0208c16 <disk0_io+0xf2>
ffffffffc0208c04:	fb94e7e3          	bltu	s1,s9,ffffffffc0208bb2 <disk0_io+0x8e>
ffffffffc0208c08:	02000693          	li	a3,32
ffffffffc0208c0c:	02000d13          	li	s10,32
ffffffffc0208c10:	4411                	li	s0,4
ffffffffc0208c12:	6911                	lui	s2,0x4
ffffffffc0208c14:	bf4d                	j	ffffffffc0208bc6 <disk0_io+0xa2>
ffffffffc0208c16:	0038                	addi	a4,sp,8
ffffffffc0208c18:	4681                	li	a3,0
ffffffffc0208c1a:	6611                	lui	a2,0x4
ffffffffc0208c1c:	855a                	mv	a0,s6
ffffffffc0208c1e:	867fc0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc0208c22:	6422                	ld	s0,8(sp)
ffffffffc0208c24:	c825                	beqz	s0,ffffffffc0208c94 <disk0_io+0x170>
ffffffffc0208c26:	0684e763          	bltu	s1,s0,ffffffffc0208c94 <disk0_io+0x170>
ffffffffc0208c2a:	017477b3          	and	a5,s0,s7
ffffffffc0208c2e:	e3bd                	bnez	a5,ffffffffc0208c94 <disk0_io+0x170>
ffffffffc0208c30:	8031                	srli	s0,s0,0xc
ffffffffc0208c32:	0034179b          	slliw	a5,s0,0x3
ffffffffc0208c36:	000ab603          	ld	a2,0(s5)
ffffffffc0208c3a:	0039991b          	slliw	s2,s3,0x3
ffffffffc0208c3e:	02079693          	slli	a3,a5,0x20
ffffffffc0208c42:	9281                	srli	a3,a3,0x20
ffffffffc0208c44:	85ca                	mv	a1,s2
ffffffffc0208c46:	4509                	li	a0,2
ffffffffc0208c48:	2401                	sext.w	s0,s0
ffffffffc0208c4a:	00078a1b          	sext.w	s4,a5
ffffffffc0208c4e:	f89f70ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc0208c52:	e151                	bnez	a0,ffffffffc0208cd6 <disk0_io+0x1b2>
ffffffffc0208c54:	6922                	ld	s2,8(sp)
ffffffffc0208c56:	013409bb          	addw	s3,s0,s3
ffffffffc0208c5a:	412484b3          	sub	s1,s1,s2
ffffffffc0208c5e:	fcd9                	bnez	s1,ffffffffc0208bfc <disk0_io+0xd8>
ffffffffc0208c60:	0008d517          	auipc	a0,0x8d
ffffffffc0208c64:	be050513          	addi	a0,a0,-1056 # ffffffffc0295840 <disk0_sem>
ffffffffc0208c68:	991fb0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0208c6c:	4501                	li	a0,0
ffffffffc0208c6e:	b729                	j	ffffffffc0208b78 <disk0_io+0x54>
ffffffffc0208c70:	5575                	li	a0,-3
ffffffffc0208c72:	b719                	j	ffffffffc0208b78 <disk0_io+0x54>
ffffffffc0208c74:	00006697          	auipc	a3,0x6
ffffffffc0208c78:	09c68693          	addi	a3,a3,156 # ffffffffc020ed10 <dev_node_ops+0x178>
ffffffffc0208c7c:	00003617          	auipc	a2,0x3
ffffffffc0208c80:	08460613          	addi	a2,a2,132 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208c84:	06200593          	li	a1,98
ffffffffc0208c88:	00006517          	auipc	a0,0x6
ffffffffc0208c8c:	fd050513          	addi	a0,a0,-48 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208c90:	80ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c94:	00006697          	auipc	a3,0x6
ffffffffc0208c98:	f8468693          	addi	a3,a3,-124 # ffffffffc020ec18 <dev_node_ops+0x80>
ffffffffc0208c9c:	00003617          	auipc	a2,0x3
ffffffffc0208ca0:	06460613          	addi	a2,a2,100 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208ca4:	05700593          	li	a1,87
ffffffffc0208ca8:	00006517          	auipc	a0,0x6
ffffffffc0208cac:	fb050513          	addi	a0,a0,-80 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208cb0:	feef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208cb4:	88aa                	mv	a7,a0
ffffffffc0208cb6:	886a                	mv	a6,s10
ffffffffc0208cb8:	87a2                	mv	a5,s0
ffffffffc0208cba:	8752                	mv	a4,s4
ffffffffc0208cbc:	86ce                	mv	a3,s3
ffffffffc0208cbe:	00006617          	auipc	a2,0x6
ffffffffc0208cc2:	00a60613          	addi	a2,a2,10 # ffffffffc020ecc8 <dev_node_ops+0x130>
ffffffffc0208cc6:	02d00593          	li	a1,45
ffffffffc0208cca:	00006517          	auipc	a0,0x6
ffffffffc0208cce:	f8e50513          	addi	a0,a0,-114 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208cd2:	fccf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208cd6:	88aa                	mv	a7,a0
ffffffffc0208cd8:	8852                	mv	a6,s4
ffffffffc0208cda:	87a2                	mv	a5,s0
ffffffffc0208cdc:	874a                	mv	a4,s2
ffffffffc0208cde:	86ce                	mv	a3,s3
ffffffffc0208ce0:	00006617          	auipc	a2,0x6
ffffffffc0208ce4:	f9860613          	addi	a2,a2,-104 # ffffffffc020ec78 <dev_node_ops+0xe0>
ffffffffc0208ce8:	03700593          	li	a1,55
ffffffffc0208cec:	00006517          	auipc	a0,0x6
ffffffffc0208cf0:	f6c50513          	addi	a0,a0,-148 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208cf4:	faaf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208cf8 <dev_init_disk0>:
ffffffffc0208cf8:	1101                	addi	sp,sp,-32
ffffffffc0208cfa:	ec06                	sd	ra,24(sp)
ffffffffc0208cfc:	e822                	sd	s0,16(sp)
ffffffffc0208cfe:	e426                	sd	s1,8(sp)
ffffffffc0208d00:	dedff0ef          	jal	ra,ffffffffc0208aec <dev_create_inode>
ffffffffc0208d04:	c541                	beqz	a0,ffffffffc0208d8c <dev_init_disk0+0x94>
ffffffffc0208d06:	4d38                	lw	a4,88(a0)
ffffffffc0208d08:	6485                	lui	s1,0x1
ffffffffc0208d0a:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208d0e:	842a                	mv	s0,a0
ffffffffc0208d10:	0cf71f63          	bne	a4,a5,ffffffffc0208dee <dev_init_disk0+0xf6>
ffffffffc0208d14:	4509                	li	a0,2
ffffffffc0208d16:	ddff70ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc0208d1a:	cd55                	beqz	a0,ffffffffc0208dd6 <dev_init_disk0+0xde>
ffffffffc0208d1c:	4509                	li	a0,2
ffffffffc0208d1e:	dfbf70ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc0208d22:	00355793          	srli	a5,a0,0x3
ffffffffc0208d26:	e01c                	sd	a5,0(s0)
ffffffffc0208d28:	00000797          	auipc	a5,0x0
ffffffffc0208d2c:	df078793          	addi	a5,a5,-528 # ffffffffc0208b18 <disk0_open>
ffffffffc0208d30:	e81c                	sd	a5,16(s0)
ffffffffc0208d32:	00000797          	auipc	a5,0x0
ffffffffc0208d36:	dea78793          	addi	a5,a5,-534 # ffffffffc0208b1c <disk0_close>
ffffffffc0208d3a:	ec1c                	sd	a5,24(s0)
ffffffffc0208d3c:	00000797          	auipc	a5,0x0
ffffffffc0208d40:	de878793          	addi	a5,a5,-536 # ffffffffc0208b24 <disk0_io>
ffffffffc0208d44:	f01c                	sd	a5,32(s0)
ffffffffc0208d46:	00000797          	auipc	a5,0x0
ffffffffc0208d4a:	dda78793          	addi	a5,a5,-550 # ffffffffc0208b20 <disk0_ioctl>
ffffffffc0208d4e:	f41c                	sd	a5,40(s0)
ffffffffc0208d50:	4585                	li	a1,1
ffffffffc0208d52:	0008d517          	auipc	a0,0x8d
ffffffffc0208d56:	aee50513          	addi	a0,a0,-1298 # ffffffffc0295840 <disk0_sem>
ffffffffc0208d5a:	e404                	sd	s1,8(s0)
ffffffffc0208d5c:	897fb0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc0208d60:	6511                	lui	a0,0x4
ffffffffc0208d62:	ac0f90ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc0208d66:	0008e797          	auipc	a5,0x8e
ffffffffc0208d6a:	b8a7b923          	sd	a0,-1134(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208d6e:	c921                	beqz	a0,ffffffffc0208dbe <dev_init_disk0+0xc6>
ffffffffc0208d70:	4605                	li	a2,1
ffffffffc0208d72:	85a2                	mv	a1,s0
ffffffffc0208d74:	00006517          	auipc	a0,0x6
ffffffffc0208d78:	02c50513          	addi	a0,a0,44 # ffffffffc020eda0 <dev_node_ops+0x208>
ffffffffc0208d7c:	c2cff0ef          	jal	ra,ffffffffc02081a8 <vfs_add_dev>
ffffffffc0208d80:	e115                	bnez	a0,ffffffffc0208da4 <dev_init_disk0+0xac>
ffffffffc0208d82:	60e2                	ld	ra,24(sp)
ffffffffc0208d84:	6442                	ld	s0,16(sp)
ffffffffc0208d86:	64a2                	ld	s1,8(sp)
ffffffffc0208d88:	6105                	addi	sp,sp,32
ffffffffc0208d8a:	8082                	ret
ffffffffc0208d8c:	00006617          	auipc	a2,0x6
ffffffffc0208d90:	fb460613          	addi	a2,a2,-76 # ffffffffc020ed40 <dev_node_ops+0x1a8>
ffffffffc0208d94:	08700593          	li	a1,135
ffffffffc0208d98:	00006517          	auipc	a0,0x6
ffffffffc0208d9c:	ec050513          	addi	a0,a0,-320 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208da0:	efef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208da4:	86aa                	mv	a3,a0
ffffffffc0208da6:	00006617          	auipc	a2,0x6
ffffffffc0208daa:	00260613          	addi	a2,a2,2 # ffffffffc020eda8 <dev_node_ops+0x210>
ffffffffc0208dae:	08d00593          	li	a1,141
ffffffffc0208db2:	00006517          	auipc	a0,0x6
ffffffffc0208db6:	ea650513          	addi	a0,a0,-346 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208dba:	ee4f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208dbe:	00006617          	auipc	a2,0x6
ffffffffc0208dc2:	fc260613          	addi	a2,a2,-62 # ffffffffc020ed80 <dev_node_ops+0x1e8>
ffffffffc0208dc6:	07f00593          	li	a1,127
ffffffffc0208dca:	00006517          	auipc	a0,0x6
ffffffffc0208dce:	e8e50513          	addi	a0,a0,-370 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208dd2:	eccf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208dd6:	00006617          	auipc	a2,0x6
ffffffffc0208dda:	f8a60613          	addi	a2,a2,-118 # ffffffffc020ed60 <dev_node_ops+0x1c8>
ffffffffc0208dde:	07300593          	li	a1,115
ffffffffc0208de2:	00006517          	auipc	a0,0x6
ffffffffc0208de6:	e7650513          	addi	a0,a0,-394 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208dea:	eb4f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208dee:	00006697          	auipc	a3,0x6
ffffffffc0208df2:	a8268693          	addi	a3,a3,-1406 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc0208df6:	00003617          	auipc	a2,0x3
ffffffffc0208dfa:	f0a60613          	addi	a2,a2,-246 # ffffffffc020bd00 <commands+0x210>
ffffffffc0208dfe:	08900593          	li	a1,137
ffffffffc0208e02:	00006517          	auipc	a0,0x6
ffffffffc0208e06:	e5650513          	addi	a0,a0,-426 # ffffffffc020ec58 <dev_node_ops+0xc0>
ffffffffc0208e0a:	e94f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e0e <stdin_open>:
ffffffffc0208e0e:	4501                	li	a0,0
ffffffffc0208e10:	e191                	bnez	a1,ffffffffc0208e14 <stdin_open+0x6>
ffffffffc0208e12:	8082                	ret
ffffffffc0208e14:	5575                	li	a0,-3
ffffffffc0208e16:	8082                	ret

ffffffffc0208e18 <stdin_close>:
ffffffffc0208e18:	4501                	li	a0,0
ffffffffc0208e1a:	8082                	ret

ffffffffc0208e1c <stdin_ioctl>:
ffffffffc0208e1c:	5575                	li	a0,-3
ffffffffc0208e1e:	8082                	ret

ffffffffc0208e20 <stdin_io>:
ffffffffc0208e20:	7135                	addi	sp,sp,-160
ffffffffc0208e22:	ed06                	sd	ra,152(sp)
ffffffffc0208e24:	e922                	sd	s0,144(sp)
ffffffffc0208e26:	e526                	sd	s1,136(sp)
ffffffffc0208e28:	e14a                	sd	s2,128(sp)
ffffffffc0208e2a:	fcce                	sd	s3,120(sp)
ffffffffc0208e2c:	f8d2                	sd	s4,112(sp)
ffffffffc0208e2e:	f4d6                	sd	s5,104(sp)
ffffffffc0208e30:	f0da                	sd	s6,96(sp)
ffffffffc0208e32:	ecde                	sd	s7,88(sp)
ffffffffc0208e34:	e8e2                	sd	s8,80(sp)
ffffffffc0208e36:	e4e6                	sd	s9,72(sp)
ffffffffc0208e38:	e0ea                	sd	s10,64(sp)
ffffffffc0208e3a:	fc6e                	sd	s11,56(sp)
ffffffffc0208e3c:	14061163          	bnez	a2,ffffffffc0208f7e <stdin_io+0x15e>
ffffffffc0208e40:	0005bd83          	ld	s11,0(a1)
ffffffffc0208e44:	0185bd03          	ld	s10,24(a1)
ffffffffc0208e48:	8b2e                	mv	s6,a1
ffffffffc0208e4a:	100027f3          	csrr	a5,sstatus
ffffffffc0208e4e:	8b89                	andi	a5,a5,2
ffffffffc0208e50:	10079e63          	bnez	a5,ffffffffc0208f6c <stdin_io+0x14c>
ffffffffc0208e54:	4401                	li	s0,0
ffffffffc0208e56:	100d0963          	beqz	s10,ffffffffc0208f68 <stdin_io+0x148>
ffffffffc0208e5a:	0008e997          	auipc	s3,0x8e
ffffffffc0208e5e:	aa698993          	addi	s3,s3,-1370 # ffffffffc0296900 <p_rpos>
ffffffffc0208e62:	0009b783          	ld	a5,0(s3)
ffffffffc0208e66:	800004b7          	lui	s1,0x80000
ffffffffc0208e6a:	6c85                	lui	s9,0x1
ffffffffc0208e6c:	4a81                	li	s5,0
ffffffffc0208e6e:	0008ea17          	auipc	s4,0x8e
ffffffffc0208e72:	a9aa0a13          	addi	s4,s4,-1382 # ffffffffc0296908 <p_wpos>
ffffffffc0208e76:	0491                	addi	s1,s1,4
ffffffffc0208e78:	0008d917          	auipc	s2,0x8d
ffffffffc0208e7c:	9e090913          	addi	s2,s2,-1568 # ffffffffc0295858 <__wait_queue>
ffffffffc0208e80:	1cfd                	addi	s9,s9,-1
ffffffffc0208e82:	000a3703          	ld	a4,0(s4)
ffffffffc0208e86:	000a8c1b          	sext.w	s8,s5
ffffffffc0208e8a:	8be2                	mv	s7,s8
ffffffffc0208e8c:	02e7d763          	bge	a5,a4,ffffffffc0208eba <stdin_io+0x9a>
ffffffffc0208e90:	a859                	j	ffffffffc0208f26 <stdin_io+0x106>
ffffffffc0208e92:	815fe0ef          	jal	ra,ffffffffc02076a6 <schedule>
ffffffffc0208e96:	100027f3          	csrr	a5,sstatus
ffffffffc0208e9a:	8b89                	andi	a5,a5,2
ffffffffc0208e9c:	4401                	li	s0,0
ffffffffc0208e9e:	ef8d                	bnez	a5,ffffffffc0208ed8 <stdin_io+0xb8>
ffffffffc0208ea0:	0028                	addi	a0,sp,8
ffffffffc0208ea2:	fecfb0ef          	jal	ra,ffffffffc020468e <wait_in_queue>
ffffffffc0208ea6:	e121                	bnez	a0,ffffffffc0208ee6 <stdin_io+0xc6>
ffffffffc0208ea8:	47c2                	lw	a5,16(sp)
ffffffffc0208eaa:	04979563          	bne	a5,s1,ffffffffc0208ef4 <stdin_io+0xd4>
ffffffffc0208eae:	0009b783          	ld	a5,0(s3)
ffffffffc0208eb2:	000a3703          	ld	a4,0(s4)
ffffffffc0208eb6:	06e7c863          	blt	a5,a4,ffffffffc0208f26 <stdin_io+0x106>
ffffffffc0208eba:	8626                	mv	a2,s1
ffffffffc0208ebc:	002c                	addi	a1,sp,8
ffffffffc0208ebe:	854a                	mv	a0,s2
ffffffffc0208ec0:	8f9fb0ef          	jal	ra,ffffffffc02047b8 <wait_current_set>
ffffffffc0208ec4:	d479                	beqz	s0,ffffffffc0208e92 <stdin_io+0x72>
ffffffffc0208ec6:	da7f70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208eca:	fdcfe0ef          	jal	ra,ffffffffc02076a6 <schedule>
ffffffffc0208ece:	100027f3          	csrr	a5,sstatus
ffffffffc0208ed2:	8b89                	andi	a5,a5,2
ffffffffc0208ed4:	4401                	li	s0,0
ffffffffc0208ed6:	d7e9                	beqz	a5,ffffffffc0208ea0 <stdin_io+0x80>
ffffffffc0208ed8:	d9bf70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208edc:	0028                	addi	a0,sp,8
ffffffffc0208ede:	4405                	li	s0,1
ffffffffc0208ee0:	faefb0ef          	jal	ra,ffffffffc020468e <wait_in_queue>
ffffffffc0208ee4:	d171                	beqz	a0,ffffffffc0208ea8 <stdin_io+0x88>
ffffffffc0208ee6:	002c                	addi	a1,sp,8
ffffffffc0208ee8:	854a                	mv	a0,s2
ffffffffc0208eea:	f4afb0ef          	jal	ra,ffffffffc0204634 <wait_queue_del>
ffffffffc0208eee:	47c2                	lw	a5,16(sp)
ffffffffc0208ef0:	fa978fe3          	beq	a5,s1,ffffffffc0208eae <stdin_io+0x8e>
ffffffffc0208ef4:	e435                	bnez	s0,ffffffffc0208f60 <stdin_io+0x140>
ffffffffc0208ef6:	060b8963          	beqz	s7,ffffffffc0208f68 <stdin_io+0x148>
ffffffffc0208efa:	018b3783          	ld	a5,24(s6)
ffffffffc0208efe:	41578ab3          	sub	s5,a5,s5
ffffffffc0208f02:	015b3c23          	sd	s5,24(s6)
ffffffffc0208f06:	60ea                	ld	ra,152(sp)
ffffffffc0208f08:	644a                	ld	s0,144(sp)
ffffffffc0208f0a:	64aa                	ld	s1,136(sp)
ffffffffc0208f0c:	690a                	ld	s2,128(sp)
ffffffffc0208f0e:	79e6                	ld	s3,120(sp)
ffffffffc0208f10:	7a46                	ld	s4,112(sp)
ffffffffc0208f12:	7aa6                	ld	s5,104(sp)
ffffffffc0208f14:	7b06                	ld	s6,96(sp)
ffffffffc0208f16:	6c46                	ld	s8,80(sp)
ffffffffc0208f18:	6ca6                	ld	s9,72(sp)
ffffffffc0208f1a:	6d06                	ld	s10,64(sp)
ffffffffc0208f1c:	7de2                	ld	s11,56(sp)
ffffffffc0208f1e:	855e                	mv	a0,s7
ffffffffc0208f20:	6be6                	ld	s7,88(sp)
ffffffffc0208f22:	610d                	addi	sp,sp,160
ffffffffc0208f24:	8082                	ret
ffffffffc0208f26:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208f2a:	03475693          	srli	a3,a4,0x34
ffffffffc0208f2e:	00d78733          	add	a4,a5,a3
ffffffffc0208f32:	01977733          	and	a4,a4,s9
ffffffffc0208f36:	8f15                	sub	a4,a4,a3
ffffffffc0208f38:	0008d697          	auipc	a3,0x8d
ffffffffc0208f3c:	93068693          	addi	a3,a3,-1744 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208f40:	9736                	add	a4,a4,a3
ffffffffc0208f42:	00074683          	lbu	a3,0(a4)
ffffffffc0208f46:	0785                	addi	a5,a5,1
ffffffffc0208f48:	015d8733          	add	a4,s11,s5
ffffffffc0208f4c:	00d70023          	sb	a3,0(a4)
ffffffffc0208f50:	00f9b023          	sd	a5,0(s3)
ffffffffc0208f54:	0a85                	addi	s5,s5,1
ffffffffc0208f56:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208f5a:	f3aae4e3          	bltu	s5,s10,ffffffffc0208e82 <stdin_io+0x62>
ffffffffc0208f5e:	dc51                	beqz	s0,ffffffffc0208efa <stdin_io+0xda>
ffffffffc0208f60:	d0df70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208f64:	f80b9be3          	bnez	s7,ffffffffc0208efa <stdin_io+0xda>
ffffffffc0208f68:	4b81                	li	s7,0
ffffffffc0208f6a:	bf71                	j	ffffffffc0208f06 <stdin_io+0xe6>
ffffffffc0208f6c:	d07f70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208f70:	4405                	li	s0,1
ffffffffc0208f72:	ee0d14e3          	bnez	s10,ffffffffc0208e5a <stdin_io+0x3a>
ffffffffc0208f76:	cf7f70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208f7a:	4b81                	li	s7,0
ffffffffc0208f7c:	b769                	j	ffffffffc0208f06 <stdin_io+0xe6>
ffffffffc0208f7e:	5bf5                	li	s7,-3
ffffffffc0208f80:	b759                	j	ffffffffc0208f06 <stdin_io+0xe6>

ffffffffc0208f82 <dev_stdin_write>:
ffffffffc0208f82:	e111                	bnez	a0,ffffffffc0208f86 <dev_stdin_write+0x4>
ffffffffc0208f84:	8082                	ret
ffffffffc0208f86:	1101                	addi	sp,sp,-32
ffffffffc0208f88:	e822                	sd	s0,16(sp)
ffffffffc0208f8a:	ec06                	sd	ra,24(sp)
ffffffffc0208f8c:	e426                	sd	s1,8(sp)
ffffffffc0208f8e:	842a                	mv	s0,a0
ffffffffc0208f90:	100027f3          	csrr	a5,sstatus
ffffffffc0208f94:	8b89                	andi	a5,a5,2
ffffffffc0208f96:	4481                	li	s1,0
ffffffffc0208f98:	e3c1                	bnez	a5,ffffffffc0209018 <dev_stdin_write+0x96>
ffffffffc0208f9a:	0008e597          	auipc	a1,0x8e
ffffffffc0208f9e:	96e58593          	addi	a1,a1,-1682 # ffffffffc0296908 <p_wpos>
ffffffffc0208fa2:	6198                	ld	a4,0(a1)
ffffffffc0208fa4:	6605                	lui	a2,0x1
ffffffffc0208fa6:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0208faa:	43f75693          	srai	a3,a4,0x3f
ffffffffc0208fae:	92d1                	srli	a3,a3,0x34
ffffffffc0208fb0:	00d707b3          	add	a5,a4,a3
ffffffffc0208fb4:	8fe9                	and	a5,a5,a0
ffffffffc0208fb6:	8f95                	sub	a5,a5,a3
ffffffffc0208fb8:	0008d697          	auipc	a3,0x8d
ffffffffc0208fbc:	8b068693          	addi	a3,a3,-1872 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208fc0:	97b6                	add	a5,a5,a3
ffffffffc0208fc2:	00878023          	sb	s0,0(a5)
ffffffffc0208fc6:	0008e797          	auipc	a5,0x8e
ffffffffc0208fca:	93a7b783          	ld	a5,-1734(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208fce:	40f707b3          	sub	a5,a4,a5
ffffffffc0208fd2:	00c7d463          	bge	a5,a2,ffffffffc0208fda <dev_stdin_write+0x58>
ffffffffc0208fd6:	0705                	addi	a4,a4,1
ffffffffc0208fd8:	e198                	sd	a4,0(a1)
ffffffffc0208fda:	0008d517          	auipc	a0,0x8d
ffffffffc0208fde:	87e50513          	addi	a0,a0,-1922 # ffffffffc0295858 <__wait_queue>
ffffffffc0208fe2:	ea0fb0ef          	jal	ra,ffffffffc0204682 <wait_queue_empty>
ffffffffc0208fe6:	cd09                	beqz	a0,ffffffffc0209000 <dev_stdin_write+0x7e>
ffffffffc0208fe8:	e491                	bnez	s1,ffffffffc0208ff4 <dev_stdin_write+0x72>
ffffffffc0208fea:	60e2                	ld	ra,24(sp)
ffffffffc0208fec:	6442                	ld	s0,16(sp)
ffffffffc0208fee:	64a2                	ld	s1,8(sp)
ffffffffc0208ff0:	6105                	addi	sp,sp,32
ffffffffc0208ff2:	8082                	ret
ffffffffc0208ff4:	6442                	ld	s0,16(sp)
ffffffffc0208ff6:	60e2                	ld	ra,24(sp)
ffffffffc0208ff8:	64a2                	ld	s1,8(sp)
ffffffffc0208ffa:	6105                	addi	sp,sp,32
ffffffffc0208ffc:	c71f706f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0209000:	800005b7          	lui	a1,0x80000
ffffffffc0209004:	4605                	li	a2,1
ffffffffc0209006:	0591                	addi	a1,a1,4
ffffffffc0209008:	0008d517          	auipc	a0,0x8d
ffffffffc020900c:	85050513          	addi	a0,a0,-1968 # ffffffffc0295858 <__wait_queue>
ffffffffc0209010:	edafb0ef          	jal	ra,ffffffffc02046ea <wakeup_queue>
ffffffffc0209014:	d8f9                	beqz	s1,ffffffffc0208fea <dev_stdin_write+0x68>
ffffffffc0209016:	bff9                	j	ffffffffc0208ff4 <dev_stdin_write+0x72>
ffffffffc0209018:	c5bf70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020901c:	4485                	li	s1,1
ffffffffc020901e:	bfb5                	j	ffffffffc0208f9a <dev_stdin_write+0x18>

ffffffffc0209020 <dev_init_stdin>:
ffffffffc0209020:	1141                	addi	sp,sp,-16
ffffffffc0209022:	e406                	sd	ra,8(sp)
ffffffffc0209024:	e022                	sd	s0,0(sp)
ffffffffc0209026:	ac7ff0ef          	jal	ra,ffffffffc0208aec <dev_create_inode>
ffffffffc020902a:	c93d                	beqz	a0,ffffffffc02090a0 <dev_init_stdin+0x80>
ffffffffc020902c:	4d38                	lw	a4,88(a0)
ffffffffc020902e:	6785                	lui	a5,0x1
ffffffffc0209030:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0209034:	842a                	mv	s0,a0
ffffffffc0209036:	08f71e63          	bne	a4,a5,ffffffffc02090d2 <dev_init_stdin+0xb2>
ffffffffc020903a:	4785                	li	a5,1
ffffffffc020903c:	e41c                	sd	a5,8(s0)
ffffffffc020903e:	00000797          	auipc	a5,0x0
ffffffffc0209042:	dd078793          	addi	a5,a5,-560 # ffffffffc0208e0e <stdin_open>
ffffffffc0209046:	e81c                	sd	a5,16(s0)
ffffffffc0209048:	00000797          	auipc	a5,0x0
ffffffffc020904c:	dd078793          	addi	a5,a5,-560 # ffffffffc0208e18 <stdin_close>
ffffffffc0209050:	ec1c                	sd	a5,24(s0)
ffffffffc0209052:	00000797          	auipc	a5,0x0
ffffffffc0209056:	dce78793          	addi	a5,a5,-562 # ffffffffc0208e20 <stdin_io>
ffffffffc020905a:	f01c                	sd	a5,32(s0)
ffffffffc020905c:	00000797          	auipc	a5,0x0
ffffffffc0209060:	dc078793          	addi	a5,a5,-576 # ffffffffc0208e1c <stdin_ioctl>
ffffffffc0209064:	f41c                	sd	a5,40(s0)
ffffffffc0209066:	0008c517          	auipc	a0,0x8c
ffffffffc020906a:	7f250513          	addi	a0,a0,2034 # ffffffffc0295858 <__wait_queue>
ffffffffc020906e:	00043023          	sd	zero,0(s0)
ffffffffc0209072:	0008e797          	auipc	a5,0x8e
ffffffffc0209076:	8807bb23          	sd	zero,-1898(a5) # ffffffffc0296908 <p_wpos>
ffffffffc020907a:	0008e797          	auipc	a5,0x8e
ffffffffc020907e:	8807b323          	sd	zero,-1914(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0209082:	dacfb0ef          	jal	ra,ffffffffc020462e <wait_queue_init>
ffffffffc0209086:	4601                	li	a2,0
ffffffffc0209088:	85a2                	mv	a1,s0
ffffffffc020908a:	00006517          	auipc	a0,0x6
ffffffffc020908e:	d7e50513          	addi	a0,a0,-642 # ffffffffc020ee08 <dev_node_ops+0x270>
ffffffffc0209092:	916ff0ef          	jal	ra,ffffffffc02081a8 <vfs_add_dev>
ffffffffc0209096:	e10d                	bnez	a0,ffffffffc02090b8 <dev_init_stdin+0x98>
ffffffffc0209098:	60a2                	ld	ra,8(sp)
ffffffffc020909a:	6402                	ld	s0,0(sp)
ffffffffc020909c:	0141                	addi	sp,sp,16
ffffffffc020909e:	8082                	ret
ffffffffc02090a0:	00006617          	auipc	a2,0x6
ffffffffc02090a4:	d2860613          	addi	a2,a2,-728 # ffffffffc020edc8 <dev_node_ops+0x230>
ffffffffc02090a8:	07500593          	li	a1,117
ffffffffc02090ac:	00006517          	auipc	a0,0x6
ffffffffc02090b0:	d3c50513          	addi	a0,a0,-708 # ffffffffc020ede8 <dev_node_ops+0x250>
ffffffffc02090b4:	beaf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02090b8:	86aa                	mv	a3,a0
ffffffffc02090ba:	00006617          	auipc	a2,0x6
ffffffffc02090be:	d5660613          	addi	a2,a2,-682 # ffffffffc020ee10 <dev_node_ops+0x278>
ffffffffc02090c2:	07b00593          	li	a1,123
ffffffffc02090c6:	00006517          	auipc	a0,0x6
ffffffffc02090ca:	d2250513          	addi	a0,a0,-734 # ffffffffc020ede8 <dev_node_ops+0x250>
ffffffffc02090ce:	bd0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02090d2:	00005697          	auipc	a3,0x5
ffffffffc02090d6:	79e68693          	addi	a3,a3,1950 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc02090da:	00003617          	auipc	a2,0x3
ffffffffc02090de:	c2660613          	addi	a2,a2,-986 # ffffffffc020bd00 <commands+0x210>
ffffffffc02090e2:	07700593          	li	a1,119
ffffffffc02090e6:	00006517          	auipc	a0,0x6
ffffffffc02090ea:	d0250513          	addi	a0,a0,-766 # ffffffffc020ede8 <dev_node_ops+0x250>
ffffffffc02090ee:	bb0f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02090f2 <stdout_open>:
ffffffffc02090f2:	4785                	li	a5,1
ffffffffc02090f4:	4501                	li	a0,0
ffffffffc02090f6:	00f59363          	bne	a1,a5,ffffffffc02090fc <stdout_open+0xa>
ffffffffc02090fa:	8082                	ret
ffffffffc02090fc:	5575                	li	a0,-3
ffffffffc02090fe:	8082                	ret

ffffffffc0209100 <stdout_close>:
ffffffffc0209100:	4501                	li	a0,0
ffffffffc0209102:	8082                	ret

ffffffffc0209104 <stdout_ioctl>:
ffffffffc0209104:	5575                	li	a0,-3
ffffffffc0209106:	8082                	ret

ffffffffc0209108 <stdout_io>:
ffffffffc0209108:	ca05                	beqz	a2,ffffffffc0209138 <stdout_io+0x30>
ffffffffc020910a:	6d9c                	ld	a5,24(a1)
ffffffffc020910c:	1101                	addi	sp,sp,-32
ffffffffc020910e:	e822                	sd	s0,16(sp)
ffffffffc0209110:	e426                	sd	s1,8(sp)
ffffffffc0209112:	ec06                	sd	ra,24(sp)
ffffffffc0209114:	6180                	ld	s0,0(a1)
ffffffffc0209116:	84ae                	mv	s1,a1
ffffffffc0209118:	cb91                	beqz	a5,ffffffffc020912c <stdout_io+0x24>
ffffffffc020911a:	00044503          	lbu	a0,0(s0)
ffffffffc020911e:	0405                	addi	s0,s0,1
ffffffffc0209120:	8c2f70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0209124:	6c9c                	ld	a5,24(s1)
ffffffffc0209126:	17fd                	addi	a5,a5,-1
ffffffffc0209128:	ec9c                	sd	a5,24(s1)
ffffffffc020912a:	fbe5                	bnez	a5,ffffffffc020911a <stdout_io+0x12>
ffffffffc020912c:	60e2                	ld	ra,24(sp)
ffffffffc020912e:	6442                	ld	s0,16(sp)
ffffffffc0209130:	64a2                	ld	s1,8(sp)
ffffffffc0209132:	4501                	li	a0,0
ffffffffc0209134:	6105                	addi	sp,sp,32
ffffffffc0209136:	8082                	ret
ffffffffc0209138:	5575                	li	a0,-3
ffffffffc020913a:	8082                	ret

ffffffffc020913c <dev_init_stdout>:
ffffffffc020913c:	1141                	addi	sp,sp,-16
ffffffffc020913e:	e406                	sd	ra,8(sp)
ffffffffc0209140:	9adff0ef          	jal	ra,ffffffffc0208aec <dev_create_inode>
ffffffffc0209144:	c939                	beqz	a0,ffffffffc020919a <dev_init_stdout+0x5e>
ffffffffc0209146:	4d38                	lw	a4,88(a0)
ffffffffc0209148:	6785                	lui	a5,0x1
ffffffffc020914a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020914e:	85aa                	mv	a1,a0
ffffffffc0209150:	06f71e63          	bne	a4,a5,ffffffffc02091cc <dev_init_stdout+0x90>
ffffffffc0209154:	4785                	li	a5,1
ffffffffc0209156:	e51c                	sd	a5,8(a0)
ffffffffc0209158:	00000797          	auipc	a5,0x0
ffffffffc020915c:	f9a78793          	addi	a5,a5,-102 # ffffffffc02090f2 <stdout_open>
ffffffffc0209160:	e91c                	sd	a5,16(a0)
ffffffffc0209162:	00000797          	auipc	a5,0x0
ffffffffc0209166:	f9e78793          	addi	a5,a5,-98 # ffffffffc0209100 <stdout_close>
ffffffffc020916a:	ed1c                	sd	a5,24(a0)
ffffffffc020916c:	00000797          	auipc	a5,0x0
ffffffffc0209170:	f9c78793          	addi	a5,a5,-100 # ffffffffc0209108 <stdout_io>
ffffffffc0209174:	f11c                	sd	a5,32(a0)
ffffffffc0209176:	00000797          	auipc	a5,0x0
ffffffffc020917a:	f8e78793          	addi	a5,a5,-114 # ffffffffc0209104 <stdout_ioctl>
ffffffffc020917e:	00053023          	sd	zero,0(a0)
ffffffffc0209182:	f51c                	sd	a5,40(a0)
ffffffffc0209184:	4601                	li	a2,0
ffffffffc0209186:	00006517          	auipc	a0,0x6
ffffffffc020918a:	cea50513          	addi	a0,a0,-790 # ffffffffc020ee70 <dev_node_ops+0x2d8>
ffffffffc020918e:	81aff0ef          	jal	ra,ffffffffc02081a8 <vfs_add_dev>
ffffffffc0209192:	e105                	bnez	a0,ffffffffc02091b2 <dev_init_stdout+0x76>
ffffffffc0209194:	60a2                	ld	ra,8(sp)
ffffffffc0209196:	0141                	addi	sp,sp,16
ffffffffc0209198:	8082                	ret
ffffffffc020919a:	00006617          	auipc	a2,0x6
ffffffffc020919e:	c9660613          	addi	a2,a2,-874 # ffffffffc020ee30 <dev_node_ops+0x298>
ffffffffc02091a2:	03700593          	li	a1,55
ffffffffc02091a6:	00006517          	auipc	a0,0x6
ffffffffc02091aa:	caa50513          	addi	a0,a0,-854 # ffffffffc020ee50 <dev_node_ops+0x2b8>
ffffffffc02091ae:	af0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02091b2:	86aa                	mv	a3,a0
ffffffffc02091b4:	00006617          	auipc	a2,0x6
ffffffffc02091b8:	cc460613          	addi	a2,a2,-828 # ffffffffc020ee78 <dev_node_ops+0x2e0>
ffffffffc02091bc:	03d00593          	li	a1,61
ffffffffc02091c0:	00006517          	auipc	a0,0x6
ffffffffc02091c4:	c9050513          	addi	a0,a0,-880 # ffffffffc020ee50 <dev_node_ops+0x2b8>
ffffffffc02091c8:	ad6f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02091cc:	00005697          	auipc	a3,0x5
ffffffffc02091d0:	6a468693          	addi	a3,a3,1700 # ffffffffc020e870 <syscalls+0xb10>
ffffffffc02091d4:	00003617          	auipc	a2,0x3
ffffffffc02091d8:	b2c60613          	addi	a2,a2,-1236 # ffffffffc020bd00 <commands+0x210>
ffffffffc02091dc:	03900593          	li	a1,57
ffffffffc02091e0:	00006517          	auipc	a0,0x6
ffffffffc02091e4:	c7050513          	addi	a0,a0,-912 # ffffffffc020ee50 <dev_node_ops+0x2b8>
ffffffffc02091e8:	ab6f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02091ec <bitmap_translate.part.0>:
ffffffffc02091ec:	1141                	addi	sp,sp,-16
ffffffffc02091ee:	00006697          	auipc	a3,0x6
ffffffffc02091f2:	caa68693          	addi	a3,a3,-854 # ffffffffc020ee98 <dev_node_ops+0x300>
ffffffffc02091f6:	00003617          	auipc	a2,0x3
ffffffffc02091fa:	b0a60613          	addi	a2,a2,-1270 # ffffffffc020bd00 <commands+0x210>
ffffffffc02091fe:	04c00593          	li	a1,76
ffffffffc0209202:	00006517          	auipc	a0,0x6
ffffffffc0209206:	cae50513          	addi	a0,a0,-850 # ffffffffc020eeb0 <dev_node_ops+0x318>
ffffffffc020920a:	e406                	sd	ra,8(sp)
ffffffffc020920c:	a92f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209210 <bitmap_create>:
ffffffffc0209210:	7139                	addi	sp,sp,-64
ffffffffc0209212:	fc06                	sd	ra,56(sp)
ffffffffc0209214:	f822                	sd	s0,48(sp)
ffffffffc0209216:	f426                	sd	s1,40(sp)
ffffffffc0209218:	f04a                	sd	s2,32(sp)
ffffffffc020921a:	ec4e                	sd	s3,24(sp)
ffffffffc020921c:	e852                	sd	s4,16(sp)
ffffffffc020921e:	e456                	sd	s5,8(sp)
ffffffffc0209220:	c14d                	beqz	a0,ffffffffc02092c2 <bitmap_create+0xb2>
ffffffffc0209222:	842a                	mv	s0,a0
ffffffffc0209224:	4541                	li	a0,16
ffffffffc0209226:	dfdf80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020922a:	84aa                	mv	s1,a0
ffffffffc020922c:	cd25                	beqz	a0,ffffffffc02092a4 <bitmap_create+0x94>
ffffffffc020922e:	02041a13          	slli	s4,s0,0x20
ffffffffc0209232:	020a5a13          	srli	s4,s4,0x20
ffffffffc0209236:	01fa0793          	addi	a5,s4,31
ffffffffc020923a:	0057d993          	srli	s3,a5,0x5
ffffffffc020923e:	00299a93          	slli	s5,s3,0x2
ffffffffc0209242:	8556                	mv	a0,s5
ffffffffc0209244:	894e                	mv	s2,s3
ffffffffc0209246:	dddf80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020924a:	c53d                	beqz	a0,ffffffffc02092b8 <bitmap_create+0xa8>
ffffffffc020924c:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0209250:	c080                	sw	s0,0(s1)
ffffffffc0209252:	8656                	mv	a2,s5
ffffffffc0209254:	0ff00593          	li	a1,255
ffffffffc0209258:	5c2020ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc020925c:	e488                	sd	a0,8(s1)
ffffffffc020925e:	0996                	slli	s3,s3,0x5
ffffffffc0209260:	053a0263          	beq	s4,s3,ffffffffc02092a4 <bitmap_create+0x94>
ffffffffc0209264:	fff9079b          	addiw	a5,s2,-1
ffffffffc0209268:	0057969b          	slliw	a3,a5,0x5
ffffffffc020926c:	0054561b          	srliw	a2,s0,0x5
ffffffffc0209270:	40d4073b          	subw	a4,s0,a3
ffffffffc0209274:	0054541b          	srliw	s0,s0,0x5
ffffffffc0209278:	08f61463          	bne	a2,a5,ffffffffc0209300 <bitmap_create+0xf0>
ffffffffc020927c:	fff7069b          	addiw	a3,a4,-1
ffffffffc0209280:	47f9                	li	a5,30
ffffffffc0209282:	04d7ef63          	bltu	a5,a3,ffffffffc02092e0 <bitmap_create+0xd0>
ffffffffc0209286:	1402                	slli	s0,s0,0x20
ffffffffc0209288:	8079                	srli	s0,s0,0x1e
ffffffffc020928a:	9522                	add	a0,a0,s0
ffffffffc020928c:	411c                	lw	a5,0(a0)
ffffffffc020928e:	4585                	li	a1,1
ffffffffc0209290:	02000613          	li	a2,32
ffffffffc0209294:	00e596bb          	sllw	a3,a1,a4
ffffffffc0209298:	8fb5                	xor	a5,a5,a3
ffffffffc020929a:	2705                	addiw	a4,a4,1
ffffffffc020929c:	2781                	sext.w	a5,a5
ffffffffc020929e:	fec71be3          	bne	a4,a2,ffffffffc0209294 <bitmap_create+0x84>
ffffffffc02092a2:	c11c                	sw	a5,0(a0)
ffffffffc02092a4:	70e2                	ld	ra,56(sp)
ffffffffc02092a6:	7442                	ld	s0,48(sp)
ffffffffc02092a8:	7902                	ld	s2,32(sp)
ffffffffc02092aa:	69e2                	ld	s3,24(sp)
ffffffffc02092ac:	6a42                	ld	s4,16(sp)
ffffffffc02092ae:	6aa2                	ld	s5,8(sp)
ffffffffc02092b0:	8526                	mv	a0,s1
ffffffffc02092b2:	74a2                	ld	s1,40(sp)
ffffffffc02092b4:	6121                	addi	sp,sp,64
ffffffffc02092b6:	8082                	ret
ffffffffc02092b8:	8526                	mv	a0,s1
ffffffffc02092ba:	e19f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc02092be:	4481                	li	s1,0
ffffffffc02092c0:	b7d5                	j	ffffffffc02092a4 <bitmap_create+0x94>
ffffffffc02092c2:	00006697          	auipc	a3,0x6
ffffffffc02092c6:	c0668693          	addi	a3,a3,-1018 # ffffffffc020eec8 <dev_node_ops+0x330>
ffffffffc02092ca:	00003617          	auipc	a2,0x3
ffffffffc02092ce:	a3660613          	addi	a2,a2,-1482 # ffffffffc020bd00 <commands+0x210>
ffffffffc02092d2:	45d5                	li	a1,21
ffffffffc02092d4:	00006517          	auipc	a0,0x6
ffffffffc02092d8:	bdc50513          	addi	a0,a0,-1060 # ffffffffc020eeb0 <dev_node_ops+0x318>
ffffffffc02092dc:	9c2f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02092e0:	00006697          	auipc	a3,0x6
ffffffffc02092e4:	c2868693          	addi	a3,a3,-984 # ffffffffc020ef08 <dev_node_ops+0x370>
ffffffffc02092e8:	00003617          	auipc	a2,0x3
ffffffffc02092ec:	a1860613          	addi	a2,a2,-1512 # ffffffffc020bd00 <commands+0x210>
ffffffffc02092f0:	02b00593          	li	a1,43
ffffffffc02092f4:	00006517          	auipc	a0,0x6
ffffffffc02092f8:	bbc50513          	addi	a0,a0,-1092 # ffffffffc020eeb0 <dev_node_ops+0x318>
ffffffffc02092fc:	9a2f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209300:	00006697          	auipc	a3,0x6
ffffffffc0209304:	bf068693          	addi	a3,a3,-1040 # ffffffffc020eef0 <dev_node_ops+0x358>
ffffffffc0209308:	00003617          	auipc	a2,0x3
ffffffffc020930c:	9f860613          	addi	a2,a2,-1544 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209310:	02a00593          	li	a1,42
ffffffffc0209314:	00006517          	auipc	a0,0x6
ffffffffc0209318:	b9c50513          	addi	a0,a0,-1124 # ffffffffc020eeb0 <dev_node_ops+0x318>
ffffffffc020931c:	982f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209320 <bitmap_alloc>:
ffffffffc0209320:	4150                	lw	a2,4(a0)
ffffffffc0209322:	651c                	ld	a5,8(a0)
ffffffffc0209324:	c231                	beqz	a2,ffffffffc0209368 <bitmap_alloc+0x48>
ffffffffc0209326:	4701                	li	a4,0
ffffffffc0209328:	a029                	j	ffffffffc0209332 <bitmap_alloc+0x12>
ffffffffc020932a:	2705                	addiw	a4,a4,1
ffffffffc020932c:	0791                	addi	a5,a5,4
ffffffffc020932e:	02e60d63          	beq	a2,a4,ffffffffc0209368 <bitmap_alloc+0x48>
ffffffffc0209332:	4394                	lw	a3,0(a5)
ffffffffc0209334:	dafd                	beqz	a3,ffffffffc020932a <bitmap_alloc+0xa>
ffffffffc0209336:	4501                	li	a0,0
ffffffffc0209338:	4885                	li	a7,1
ffffffffc020933a:	8e36                	mv	t3,a3
ffffffffc020933c:	02000313          	li	t1,32
ffffffffc0209340:	a021                	j	ffffffffc0209348 <bitmap_alloc+0x28>
ffffffffc0209342:	2505                	addiw	a0,a0,1
ffffffffc0209344:	02650463          	beq	a0,t1,ffffffffc020936c <bitmap_alloc+0x4c>
ffffffffc0209348:	00a8983b          	sllw	a6,a7,a0
ffffffffc020934c:	0106f633          	and	a2,a3,a6
ffffffffc0209350:	2601                	sext.w	a2,a2
ffffffffc0209352:	da65                	beqz	a2,ffffffffc0209342 <bitmap_alloc+0x22>
ffffffffc0209354:	010e4833          	xor	a6,t3,a6
ffffffffc0209358:	0057171b          	slliw	a4,a4,0x5
ffffffffc020935c:	9f29                	addw	a4,a4,a0
ffffffffc020935e:	0107a023          	sw	a6,0(a5)
ffffffffc0209362:	c198                	sw	a4,0(a1)
ffffffffc0209364:	4501                	li	a0,0
ffffffffc0209366:	8082                	ret
ffffffffc0209368:	5571                	li	a0,-4
ffffffffc020936a:	8082                	ret
ffffffffc020936c:	1141                	addi	sp,sp,-16
ffffffffc020936e:	00004697          	auipc	a3,0x4
ffffffffc0209372:	a4a68693          	addi	a3,a3,-1462 # ffffffffc020cdb8 <default_pmm_manager+0x598>
ffffffffc0209376:	00003617          	auipc	a2,0x3
ffffffffc020937a:	98a60613          	addi	a2,a2,-1654 # ffffffffc020bd00 <commands+0x210>
ffffffffc020937e:	04300593          	li	a1,67
ffffffffc0209382:	00006517          	auipc	a0,0x6
ffffffffc0209386:	b2e50513          	addi	a0,a0,-1234 # ffffffffc020eeb0 <dev_node_ops+0x318>
ffffffffc020938a:	e406                	sd	ra,8(sp)
ffffffffc020938c:	912f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209390 <bitmap_test>:
ffffffffc0209390:	411c                	lw	a5,0(a0)
ffffffffc0209392:	00f5ff63          	bgeu	a1,a5,ffffffffc02093b0 <bitmap_test+0x20>
ffffffffc0209396:	651c                	ld	a5,8(a0)
ffffffffc0209398:	0055d71b          	srliw	a4,a1,0x5
ffffffffc020939c:	070a                	slli	a4,a4,0x2
ffffffffc020939e:	97ba                	add	a5,a5,a4
ffffffffc02093a0:	4388                	lw	a0,0(a5)
ffffffffc02093a2:	4785                	li	a5,1
ffffffffc02093a4:	00b795bb          	sllw	a1,a5,a1
ffffffffc02093a8:	8d6d                	and	a0,a0,a1
ffffffffc02093aa:	1502                	slli	a0,a0,0x20
ffffffffc02093ac:	9101                	srli	a0,a0,0x20
ffffffffc02093ae:	8082                	ret
ffffffffc02093b0:	1141                	addi	sp,sp,-16
ffffffffc02093b2:	e406                	sd	ra,8(sp)
ffffffffc02093b4:	e39ff0ef          	jal	ra,ffffffffc02091ec <bitmap_translate.part.0>

ffffffffc02093b8 <bitmap_free>:
ffffffffc02093b8:	411c                	lw	a5,0(a0)
ffffffffc02093ba:	1141                	addi	sp,sp,-16
ffffffffc02093bc:	e406                	sd	ra,8(sp)
ffffffffc02093be:	02f5f463          	bgeu	a1,a5,ffffffffc02093e6 <bitmap_free+0x2e>
ffffffffc02093c2:	651c                	ld	a5,8(a0)
ffffffffc02093c4:	0055d71b          	srliw	a4,a1,0x5
ffffffffc02093c8:	070a                	slli	a4,a4,0x2
ffffffffc02093ca:	97ba                	add	a5,a5,a4
ffffffffc02093cc:	4398                	lw	a4,0(a5)
ffffffffc02093ce:	4685                	li	a3,1
ffffffffc02093d0:	00b695bb          	sllw	a1,a3,a1
ffffffffc02093d4:	00b776b3          	and	a3,a4,a1
ffffffffc02093d8:	2681                	sext.w	a3,a3
ffffffffc02093da:	ea81                	bnez	a3,ffffffffc02093ea <bitmap_free+0x32>
ffffffffc02093dc:	60a2                	ld	ra,8(sp)
ffffffffc02093de:	8f4d                	or	a4,a4,a1
ffffffffc02093e0:	c398                	sw	a4,0(a5)
ffffffffc02093e2:	0141                	addi	sp,sp,16
ffffffffc02093e4:	8082                	ret
ffffffffc02093e6:	e07ff0ef          	jal	ra,ffffffffc02091ec <bitmap_translate.part.0>
ffffffffc02093ea:	00006697          	auipc	a3,0x6
ffffffffc02093ee:	b4668693          	addi	a3,a3,-1210 # ffffffffc020ef30 <dev_node_ops+0x398>
ffffffffc02093f2:	00003617          	auipc	a2,0x3
ffffffffc02093f6:	90e60613          	addi	a2,a2,-1778 # ffffffffc020bd00 <commands+0x210>
ffffffffc02093fa:	05f00593          	li	a1,95
ffffffffc02093fe:	00006517          	auipc	a0,0x6
ffffffffc0209402:	ab250513          	addi	a0,a0,-1358 # ffffffffc020eeb0 <dev_node_ops+0x318>
ffffffffc0209406:	898f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020940a <bitmap_destroy>:
ffffffffc020940a:	1141                	addi	sp,sp,-16
ffffffffc020940c:	e022                	sd	s0,0(sp)
ffffffffc020940e:	842a                	mv	s0,a0
ffffffffc0209410:	6508                	ld	a0,8(a0)
ffffffffc0209412:	e406                	sd	ra,8(sp)
ffffffffc0209414:	cbff80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209418:	8522                	mv	a0,s0
ffffffffc020941a:	6402                	ld	s0,0(sp)
ffffffffc020941c:	60a2                	ld	ra,8(sp)
ffffffffc020941e:	0141                	addi	sp,sp,16
ffffffffc0209420:	cb3f806f          	j	ffffffffc02020d2 <kfree>

ffffffffc0209424 <bitmap_getdata>:
ffffffffc0209424:	c589                	beqz	a1,ffffffffc020942e <bitmap_getdata+0xa>
ffffffffc0209426:	00456783          	lwu	a5,4(a0)
ffffffffc020942a:	078a                	slli	a5,a5,0x2
ffffffffc020942c:	e19c                	sd	a5,0(a1)
ffffffffc020942e:	6508                	ld	a0,8(a0)
ffffffffc0209430:	8082                	ret

ffffffffc0209432 <sfs_init>:
ffffffffc0209432:	1141                	addi	sp,sp,-16
ffffffffc0209434:	00006517          	auipc	a0,0x6
ffffffffc0209438:	96c50513          	addi	a0,a0,-1684 # ffffffffc020eda0 <dev_node_ops+0x208>
ffffffffc020943c:	e406                	sd	ra,8(sp)
ffffffffc020943e:	554000ef          	jal	ra,ffffffffc0209992 <sfs_mount>
ffffffffc0209442:	e501                	bnez	a0,ffffffffc020944a <sfs_init+0x18>
ffffffffc0209444:	60a2                	ld	ra,8(sp)
ffffffffc0209446:	0141                	addi	sp,sp,16
ffffffffc0209448:	8082                	ret
ffffffffc020944a:	86aa                	mv	a3,a0
ffffffffc020944c:	00006617          	auipc	a2,0x6
ffffffffc0209450:	af460613          	addi	a2,a2,-1292 # ffffffffc020ef40 <dev_node_ops+0x3a8>
ffffffffc0209454:	45c1                	li	a1,16
ffffffffc0209456:	00006517          	auipc	a0,0x6
ffffffffc020945a:	b0a50513          	addi	a0,a0,-1270 # ffffffffc020ef60 <dev_node_ops+0x3c8>
ffffffffc020945e:	840f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209462 <sfs_unmount>:
ffffffffc0209462:	1141                	addi	sp,sp,-16
ffffffffc0209464:	e406                	sd	ra,8(sp)
ffffffffc0209466:	e022                	sd	s0,0(sp)
ffffffffc0209468:	cd1d                	beqz	a0,ffffffffc02094a6 <sfs_unmount+0x44>
ffffffffc020946a:	0b052783          	lw	a5,176(a0)
ffffffffc020946e:	842a                	mv	s0,a0
ffffffffc0209470:	eb9d                	bnez	a5,ffffffffc02094a6 <sfs_unmount+0x44>
ffffffffc0209472:	7158                	ld	a4,160(a0)
ffffffffc0209474:	09850793          	addi	a5,a0,152
ffffffffc0209478:	02f71563          	bne	a4,a5,ffffffffc02094a2 <sfs_unmount+0x40>
ffffffffc020947c:	613c                	ld	a5,64(a0)
ffffffffc020947e:	e7a1                	bnez	a5,ffffffffc02094c6 <sfs_unmount+0x64>
ffffffffc0209480:	7d08                	ld	a0,56(a0)
ffffffffc0209482:	f89ff0ef          	jal	ra,ffffffffc020940a <bitmap_destroy>
ffffffffc0209486:	6428                	ld	a0,72(s0)
ffffffffc0209488:	c4bf80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020948c:	7448                	ld	a0,168(s0)
ffffffffc020948e:	c45f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209492:	8522                	mv	a0,s0
ffffffffc0209494:	c3ff80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209498:	4501                	li	a0,0
ffffffffc020949a:	60a2                	ld	ra,8(sp)
ffffffffc020949c:	6402                	ld	s0,0(sp)
ffffffffc020949e:	0141                	addi	sp,sp,16
ffffffffc02094a0:	8082                	ret
ffffffffc02094a2:	5545                	li	a0,-15
ffffffffc02094a4:	bfdd                	j	ffffffffc020949a <sfs_unmount+0x38>
ffffffffc02094a6:	00006697          	auipc	a3,0x6
ffffffffc02094aa:	ad268693          	addi	a3,a3,-1326 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc02094ae:	00003617          	auipc	a2,0x3
ffffffffc02094b2:	85260613          	addi	a2,a2,-1966 # ffffffffc020bd00 <commands+0x210>
ffffffffc02094b6:	04100593          	li	a1,65
ffffffffc02094ba:	00006517          	auipc	a0,0x6
ffffffffc02094be:	aee50513          	addi	a0,a0,-1298 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc02094c2:	fddf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02094c6:	00006697          	auipc	a3,0x6
ffffffffc02094ca:	afa68693          	addi	a3,a3,-1286 # ffffffffc020efc0 <dev_node_ops+0x428>
ffffffffc02094ce:	00003617          	auipc	a2,0x3
ffffffffc02094d2:	83260613          	addi	a2,a2,-1998 # ffffffffc020bd00 <commands+0x210>
ffffffffc02094d6:	04500593          	li	a1,69
ffffffffc02094da:	00006517          	auipc	a0,0x6
ffffffffc02094de:	ace50513          	addi	a0,a0,-1330 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc02094e2:	fbdf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02094e6 <sfs_cleanup>:
ffffffffc02094e6:	1101                	addi	sp,sp,-32
ffffffffc02094e8:	ec06                	sd	ra,24(sp)
ffffffffc02094ea:	e822                	sd	s0,16(sp)
ffffffffc02094ec:	e426                	sd	s1,8(sp)
ffffffffc02094ee:	e04a                	sd	s2,0(sp)
ffffffffc02094f0:	c525                	beqz	a0,ffffffffc0209558 <sfs_cleanup+0x72>
ffffffffc02094f2:	0b052783          	lw	a5,176(a0)
ffffffffc02094f6:	84aa                	mv	s1,a0
ffffffffc02094f8:	e3a5                	bnez	a5,ffffffffc0209558 <sfs_cleanup+0x72>
ffffffffc02094fa:	4158                	lw	a4,4(a0)
ffffffffc02094fc:	4514                	lw	a3,8(a0)
ffffffffc02094fe:	00c50913          	addi	s2,a0,12
ffffffffc0209502:	85ca                	mv	a1,s2
ffffffffc0209504:	40d7063b          	subw	a2,a4,a3
ffffffffc0209508:	00006517          	auipc	a0,0x6
ffffffffc020950c:	ad050513          	addi	a0,a0,-1328 # ffffffffc020efd8 <dev_node_ops+0x440>
ffffffffc0209510:	c97f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209514:	02000413          	li	s0,32
ffffffffc0209518:	a019                	j	ffffffffc020951e <sfs_cleanup+0x38>
ffffffffc020951a:	347d                	addiw	s0,s0,-1
ffffffffc020951c:	c819                	beqz	s0,ffffffffc0209532 <sfs_cleanup+0x4c>
ffffffffc020951e:	7cdc                	ld	a5,184(s1)
ffffffffc0209520:	8526                	mv	a0,s1
ffffffffc0209522:	9782                	jalr	a5
ffffffffc0209524:	f97d                	bnez	a0,ffffffffc020951a <sfs_cleanup+0x34>
ffffffffc0209526:	60e2                	ld	ra,24(sp)
ffffffffc0209528:	6442                	ld	s0,16(sp)
ffffffffc020952a:	64a2                	ld	s1,8(sp)
ffffffffc020952c:	6902                	ld	s2,0(sp)
ffffffffc020952e:	6105                	addi	sp,sp,32
ffffffffc0209530:	8082                	ret
ffffffffc0209532:	6442                	ld	s0,16(sp)
ffffffffc0209534:	60e2                	ld	ra,24(sp)
ffffffffc0209536:	64a2                	ld	s1,8(sp)
ffffffffc0209538:	86ca                	mv	a3,s2
ffffffffc020953a:	6902                	ld	s2,0(sp)
ffffffffc020953c:	872a                	mv	a4,a0
ffffffffc020953e:	00006617          	auipc	a2,0x6
ffffffffc0209542:	aba60613          	addi	a2,a2,-1350 # ffffffffc020eff8 <dev_node_ops+0x460>
ffffffffc0209546:	05f00593          	li	a1,95
ffffffffc020954a:	00006517          	auipc	a0,0x6
ffffffffc020954e:	a5e50513          	addi	a0,a0,-1442 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc0209552:	6105                	addi	sp,sp,32
ffffffffc0209554:	fb3f606f          	j	ffffffffc0200506 <__warn>
ffffffffc0209558:	00006697          	auipc	a3,0x6
ffffffffc020955c:	a2068693          	addi	a3,a3,-1504 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc0209560:	00002617          	auipc	a2,0x2
ffffffffc0209564:	7a060613          	addi	a2,a2,1952 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209568:	05400593          	li	a1,84
ffffffffc020956c:	00006517          	auipc	a0,0x6
ffffffffc0209570:	a3c50513          	addi	a0,a0,-1476 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc0209574:	f2bf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209578 <sfs_sync>:
ffffffffc0209578:	7179                	addi	sp,sp,-48
ffffffffc020957a:	f406                	sd	ra,40(sp)
ffffffffc020957c:	f022                	sd	s0,32(sp)
ffffffffc020957e:	ec26                	sd	s1,24(sp)
ffffffffc0209580:	e84a                	sd	s2,16(sp)
ffffffffc0209582:	e44e                	sd	s3,8(sp)
ffffffffc0209584:	e052                	sd	s4,0(sp)
ffffffffc0209586:	cd4d                	beqz	a0,ffffffffc0209640 <sfs_sync+0xc8>
ffffffffc0209588:	0b052783          	lw	a5,176(a0)
ffffffffc020958c:	8a2a                	mv	s4,a0
ffffffffc020958e:	ebcd                	bnez	a5,ffffffffc0209640 <sfs_sync+0xc8>
ffffffffc0209590:	537010ef          	jal	ra,ffffffffc020b2c6 <lock_sfs_fs>
ffffffffc0209594:	0a0a3403          	ld	s0,160(s4)
ffffffffc0209598:	098a0913          	addi	s2,s4,152
ffffffffc020959c:	02890763          	beq	s2,s0,ffffffffc02095ca <sfs_sync+0x52>
ffffffffc02095a0:	00004997          	auipc	s3,0x4
ffffffffc02095a4:	12098993          	addi	s3,s3,288 # ffffffffc020d6c0 <default_pmm_manager+0xea0>
ffffffffc02095a8:	7c1c                	ld	a5,56(s0)
ffffffffc02095aa:	fc840493          	addi	s1,s0,-56
ffffffffc02095ae:	cbb5                	beqz	a5,ffffffffc0209622 <sfs_sync+0xaa>
ffffffffc02095b0:	7b9c                	ld	a5,48(a5)
ffffffffc02095b2:	cba5                	beqz	a5,ffffffffc0209622 <sfs_sync+0xaa>
ffffffffc02095b4:	85ce                	mv	a1,s3
ffffffffc02095b6:	8526                	mv	a0,s1
ffffffffc02095b8:	e28fe0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc02095bc:	7c1c                	ld	a5,56(s0)
ffffffffc02095be:	8526                	mv	a0,s1
ffffffffc02095c0:	7b9c                	ld	a5,48(a5)
ffffffffc02095c2:	9782                	jalr	a5
ffffffffc02095c4:	6400                	ld	s0,8(s0)
ffffffffc02095c6:	fe8911e3          	bne	s2,s0,ffffffffc02095a8 <sfs_sync+0x30>
ffffffffc02095ca:	8552                	mv	a0,s4
ffffffffc02095cc:	50b010ef          	jal	ra,ffffffffc020b2d6 <unlock_sfs_fs>
ffffffffc02095d0:	040a3783          	ld	a5,64(s4)
ffffffffc02095d4:	4501                	li	a0,0
ffffffffc02095d6:	eb89                	bnez	a5,ffffffffc02095e8 <sfs_sync+0x70>
ffffffffc02095d8:	70a2                	ld	ra,40(sp)
ffffffffc02095da:	7402                	ld	s0,32(sp)
ffffffffc02095dc:	64e2                	ld	s1,24(sp)
ffffffffc02095de:	6942                	ld	s2,16(sp)
ffffffffc02095e0:	69a2                	ld	s3,8(sp)
ffffffffc02095e2:	6a02                	ld	s4,0(sp)
ffffffffc02095e4:	6145                	addi	sp,sp,48
ffffffffc02095e6:	8082                	ret
ffffffffc02095e8:	040a3023          	sd	zero,64(s4)
ffffffffc02095ec:	8552                	mv	a0,s4
ffffffffc02095ee:	3bd010ef          	jal	ra,ffffffffc020b1aa <sfs_sync_super>
ffffffffc02095f2:	cd01                	beqz	a0,ffffffffc020960a <sfs_sync+0x92>
ffffffffc02095f4:	70a2                	ld	ra,40(sp)
ffffffffc02095f6:	7402                	ld	s0,32(sp)
ffffffffc02095f8:	4785                	li	a5,1
ffffffffc02095fa:	04fa3023          	sd	a5,64(s4)
ffffffffc02095fe:	64e2                	ld	s1,24(sp)
ffffffffc0209600:	6942                	ld	s2,16(sp)
ffffffffc0209602:	69a2                	ld	s3,8(sp)
ffffffffc0209604:	6a02                	ld	s4,0(sp)
ffffffffc0209606:	6145                	addi	sp,sp,48
ffffffffc0209608:	8082                	ret
ffffffffc020960a:	8552                	mv	a0,s4
ffffffffc020960c:	3e5010ef          	jal	ra,ffffffffc020b1f0 <sfs_sync_freemap>
ffffffffc0209610:	f175                	bnez	a0,ffffffffc02095f4 <sfs_sync+0x7c>
ffffffffc0209612:	70a2                	ld	ra,40(sp)
ffffffffc0209614:	7402                	ld	s0,32(sp)
ffffffffc0209616:	64e2                	ld	s1,24(sp)
ffffffffc0209618:	6942                	ld	s2,16(sp)
ffffffffc020961a:	69a2                	ld	s3,8(sp)
ffffffffc020961c:	6a02                	ld	s4,0(sp)
ffffffffc020961e:	6145                	addi	sp,sp,48
ffffffffc0209620:	8082                	ret
ffffffffc0209622:	00004697          	auipc	a3,0x4
ffffffffc0209626:	04e68693          	addi	a3,a3,78 # ffffffffc020d670 <default_pmm_manager+0xe50>
ffffffffc020962a:	00002617          	auipc	a2,0x2
ffffffffc020962e:	6d660613          	addi	a2,a2,1750 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209632:	45ed                	li	a1,27
ffffffffc0209634:	00006517          	auipc	a0,0x6
ffffffffc0209638:	97450513          	addi	a0,a0,-1676 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc020963c:	e63f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209640:	00006697          	auipc	a3,0x6
ffffffffc0209644:	93868693          	addi	a3,a3,-1736 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc0209648:	00002617          	auipc	a2,0x2
ffffffffc020964c:	6b860613          	addi	a2,a2,1720 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209650:	45d5                	li	a1,21
ffffffffc0209652:	00006517          	auipc	a0,0x6
ffffffffc0209656:	95650513          	addi	a0,a0,-1706 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc020965a:	e45f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020965e <sfs_get_root>:
ffffffffc020965e:	1101                	addi	sp,sp,-32
ffffffffc0209660:	ec06                	sd	ra,24(sp)
ffffffffc0209662:	cd09                	beqz	a0,ffffffffc020967c <sfs_get_root+0x1e>
ffffffffc0209664:	0b052783          	lw	a5,176(a0)
ffffffffc0209668:	eb91                	bnez	a5,ffffffffc020967c <sfs_get_root+0x1e>
ffffffffc020966a:	4605                	li	a2,1
ffffffffc020966c:	002c                	addi	a1,sp,8
ffffffffc020966e:	36e010ef          	jal	ra,ffffffffc020a9dc <sfs_load_inode>
ffffffffc0209672:	e50d                	bnez	a0,ffffffffc020969c <sfs_get_root+0x3e>
ffffffffc0209674:	60e2                	ld	ra,24(sp)
ffffffffc0209676:	6522                	ld	a0,8(sp)
ffffffffc0209678:	6105                	addi	sp,sp,32
ffffffffc020967a:	8082                	ret
ffffffffc020967c:	00006697          	auipc	a3,0x6
ffffffffc0209680:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc0209684:	00002617          	auipc	a2,0x2
ffffffffc0209688:	67c60613          	addi	a2,a2,1660 # ffffffffc020bd00 <commands+0x210>
ffffffffc020968c:	03600593          	li	a1,54
ffffffffc0209690:	00006517          	auipc	a0,0x6
ffffffffc0209694:	91850513          	addi	a0,a0,-1768 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc0209698:	e07f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020969c:	86aa                	mv	a3,a0
ffffffffc020969e:	00006617          	auipc	a2,0x6
ffffffffc02096a2:	97a60613          	addi	a2,a2,-1670 # ffffffffc020f018 <dev_node_ops+0x480>
ffffffffc02096a6:	03700593          	li	a1,55
ffffffffc02096aa:	00006517          	auipc	a0,0x6
ffffffffc02096ae:	8fe50513          	addi	a0,a0,-1794 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc02096b2:	dedf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02096b6 <sfs_do_mount>:
ffffffffc02096b6:	6518                	ld	a4,8(a0)
ffffffffc02096b8:	7171                	addi	sp,sp,-176
ffffffffc02096ba:	f506                	sd	ra,168(sp)
ffffffffc02096bc:	f122                	sd	s0,160(sp)
ffffffffc02096be:	ed26                	sd	s1,152(sp)
ffffffffc02096c0:	e94a                	sd	s2,144(sp)
ffffffffc02096c2:	e54e                	sd	s3,136(sp)
ffffffffc02096c4:	e152                	sd	s4,128(sp)
ffffffffc02096c6:	fcd6                	sd	s5,120(sp)
ffffffffc02096c8:	f8da                	sd	s6,112(sp)
ffffffffc02096ca:	f4de                	sd	s7,104(sp)
ffffffffc02096cc:	f0e2                	sd	s8,96(sp)
ffffffffc02096ce:	ece6                	sd	s9,88(sp)
ffffffffc02096d0:	e8ea                	sd	s10,80(sp)
ffffffffc02096d2:	e4ee                	sd	s11,72(sp)
ffffffffc02096d4:	6785                	lui	a5,0x1
ffffffffc02096d6:	24f71663          	bne	a4,a5,ffffffffc0209922 <sfs_do_mount+0x26c>
ffffffffc02096da:	892a                	mv	s2,a0
ffffffffc02096dc:	4501                	li	a0,0
ffffffffc02096de:	8aae                	mv	s5,a1
ffffffffc02096e0:	f00fe0ef          	jal	ra,ffffffffc0207de0 <__alloc_fs>
ffffffffc02096e4:	842a                	mv	s0,a0
ffffffffc02096e6:	24050463          	beqz	a0,ffffffffc020992e <sfs_do_mount+0x278>
ffffffffc02096ea:	0b052b03          	lw	s6,176(a0)
ffffffffc02096ee:	260b1263          	bnez	s6,ffffffffc0209952 <sfs_do_mount+0x29c>
ffffffffc02096f2:	03253823          	sd	s2,48(a0)
ffffffffc02096f6:	6505                	lui	a0,0x1
ffffffffc02096f8:	92bf80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc02096fc:	e428                	sd	a0,72(s0)
ffffffffc02096fe:	84aa                	mv	s1,a0
ffffffffc0209700:	16050363          	beqz	a0,ffffffffc0209866 <sfs_do_mount+0x1b0>
ffffffffc0209704:	85aa                	mv	a1,a0
ffffffffc0209706:	4681                	li	a3,0
ffffffffc0209708:	6605                	lui	a2,0x1
ffffffffc020970a:	1008                	addi	a0,sp,32
ffffffffc020970c:	d6ffb0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc0209710:	02093783          	ld	a5,32(s2)
ffffffffc0209714:	85aa                	mv	a1,a0
ffffffffc0209716:	4601                	li	a2,0
ffffffffc0209718:	854a                	mv	a0,s2
ffffffffc020971a:	9782                	jalr	a5
ffffffffc020971c:	8a2a                	mv	s4,a0
ffffffffc020971e:	10051e63          	bnez	a0,ffffffffc020983a <sfs_do_mount+0x184>
ffffffffc0209722:	408c                	lw	a1,0(s1)
ffffffffc0209724:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc0209728:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc020972c:	14c59863          	bne	a1,a2,ffffffffc020987c <sfs_do_mount+0x1c6>
ffffffffc0209730:	40dc                	lw	a5,4(s1)
ffffffffc0209732:	00093603          	ld	a2,0(s2)
ffffffffc0209736:	02079713          	slli	a4,a5,0x20
ffffffffc020973a:	9301                	srli	a4,a4,0x20
ffffffffc020973c:	12e66763          	bltu	a2,a4,ffffffffc020986a <sfs_do_mount+0x1b4>
ffffffffc0209740:	020485a3          	sb	zero,43(s1)
ffffffffc0209744:	0084af03          	lw	t5,8(s1)
ffffffffc0209748:	00c4ae83          	lw	t4,12(s1)
ffffffffc020974c:	0104ae03          	lw	t3,16(s1)
ffffffffc0209750:	0144a303          	lw	t1,20(s1)
ffffffffc0209754:	0184a883          	lw	a7,24(s1)
ffffffffc0209758:	01c4a803          	lw	a6,28(s1)
ffffffffc020975c:	5090                	lw	a2,32(s1)
ffffffffc020975e:	50d4                	lw	a3,36(s1)
ffffffffc0209760:	5498                	lw	a4,40(s1)
ffffffffc0209762:	6511                	lui	a0,0x4
ffffffffc0209764:	c00c                	sw	a1,0(s0)
ffffffffc0209766:	c05c                	sw	a5,4(s0)
ffffffffc0209768:	01e42423          	sw	t5,8(s0)
ffffffffc020976c:	01d42623          	sw	t4,12(s0)
ffffffffc0209770:	01c42823          	sw	t3,16(s0)
ffffffffc0209774:	00642a23          	sw	t1,20(s0)
ffffffffc0209778:	01142c23          	sw	a7,24(s0)
ffffffffc020977c:	01042e23          	sw	a6,28(s0)
ffffffffc0209780:	d010                	sw	a2,32(s0)
ffffffffc0209782:	d054                	sw	a3,36(s0)
ffffffffc0209784:	d418                	sw	a4,40(s0)
ffffffffc0209786:	89df80ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020978a:	f448                	sd	a0,168(s0)
ffffffffc020978c:	8c2a                	mv	s8,a0
ffffffffc020978e:	18050c63          	beqz	a0,ffffffffc0209926 <sfs_do_mount+0x270>
ffffffffc0209792:	6711                	lui	a4,0x4
ffffffffc0209794:	87aa                	mv	a5,a0
ffffffffc0209796:	972a                	add	a4,a4,a0
ffffffffc0209798:	e79c                	sd	a5,8(a5)
ffffffffc020979a:	e39c                	sd	a5,0(a5)
ffffffffc020979c:	07c1                	addi	a5,a5,16
ffffffffc020979e:	fee79de3          	bne	a5,a4,ffffffffc0209798 <sfs_do_mount+0xe2>
ffffffffc02097a2:	0044eb83          	lwu	s7,4(s1)
ffffffffc02097a6:	67a1                	lui	a5,0x8
ffffffffc02097a8:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc02097ac:	9bce                	add	s7,s7,s3
ffffffffc02097ae:	77e1                	lui	a5,0xffff8
ffffffffc02097b0:	00fbfbb3          	and	s7,s7,a5
ffffffffc02097b4:	2b81                	sext.w	s7,s7
ffffffffc02097b6:	855e                	mv	a0,s7
ffffffffc02097b8:	a59ff0ef          	jal	ra,ffffffffc0209210 <bitmap_create>
ffffffffc02097bc:	fc08                	sd	a0,56(s0)
ffffffffc02097be:	8d2a                	mv	s10,a0
ffffffffc02097c0:	14050f63          	beqz	a0,ffffffffc020991e <sfs_do_mount+0x268>
ffffffffc02097c4:	0044e783          	lwu	a5,4(s1)
ffffffffc02097c8:	082c                	addi	a1,sp,24
ffffffffc02097ca:	97ce                	add	a5,a5,s3
ffffffffc02097cc:	00f7d713          	srli	a4,a5,0xf
ffffffffc02097d0:	e43a                	sd	a4,8(sp)
ffffffffc02097d2:	40f7d993          	srai	s3,a5,0xf
ffffffffc02097d6:	c4fff0ef          	jal	ra,ffffffffc0209424 <bitmap_getdata>
ffffffffc02097da:	14050c63          	beqz	a0,ffffffffc0209932 <sfs_do_mount+0x27c>
ffffffffc02097de:	00c9979b          	slliw	a5,s3,0xc
ffffffffc02097e2:	66e2                	ld	a3,24(sp)
ffffffffc02097e4:	1782                	slli	a5,a5,0x20
ffffffffc02097e6:	9381                	srli	a5,a5,0x20
ffffffffc02097e8:	14d79563          	bne	a5,a3,ffffffffc0209932 <sfs_do_mount+0x27c>
ffffffffc02097ec:	6722                	ld	a4,8(sp)
ffffffffc02097ee:	6d89                	lui	s11,0x2
ffffffffc02097f0:	89aa                	mv	s3,a0
ffffffffc02097f2:	00c71c93          	slli	s9,a4,0xc
ffffffffc02097f6:	9caa                	add	s9,s9,a0
ffffffffc02097f8:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02097fc:	e711                	bnez	a4,ffffffffc0209808 <sfs_do_mount+0x152>
ffffffffc02097fe:	a079                	j	ffffffffc020988c <sfs_do_mount+0x1d6>
ffffffffc0209800:	6785                	lui	a5,0x1
ffffffffc0209802:	99be                	add	s3,s3,a5
ffffffffc0209804:	093c8463          	beq	s9,s3,ffffffffc020988c <sfs_do_mount+0x1d6>
ffffffffc0209808:	013d86bb          	addw	a3,s11,s3
ffffffffc020980c:	1682                	slli	a3,a3,0x20
ffffffffc020980e:	6605                	lui	a2,0x1
ffffffffc0209810:	85ce                	mv	a1,s3
ffffffffc0209812:	9281                	srli	a3,a3,0x20
ffffffffc0209814:	1008                	addi	a0,sp,32
ffffffffc0209816:	c65fb0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc020981a:	02093783          	ld	a5,32(s2)
ffffffffc020981e:	85aa                	mv	a1,a0
ffffffffc0209820:	4601                	li	a2,0
ffffffffc0209822:	854a                	mv	a0,s2
ffffffffc0209824:	9782                	jalr	a5
ffffffffc0209826:	dd69                	beqz	a0,ffffffffc0209800 <sfs_do_mount+0x14a>
ffffffffc0209828:	e42a                	sd	a0,8(sp)
ffffffffc020982a:	856a                	mv	a0,s10
ffffffffc020982c:	bdfff0ef          	jal	ra,ffffffffc020940a <bitmap_destroy>
ffffffffc0209830:	67a2                	ld	a5,8(sp)
ffffffffc0209832:	8a3e                	mv	s4,a5
ffffffffc0209834:	8562                	mv	a0,s8
ffffffffc0209836:	89df80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020983a:	8526                	mv	a0,s1
ffffffffc020983c:	897f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209840:	8522                	mv	a0,s0
ffffffffc0209842:	891f80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209846:	70aa                	ld	ra,168(sp)
ffffffffc0209848:	740a                	ld	s0,160(sp)
ffffffffc020984a:	64ea                	ld	s1,152(sp)
ffffffffc020984c:	694a                	ld	s2,144(sp)
ffffffffc020984e:	69aa                	ld	s3,136(sp)
ffffffffc0209850:	7ae6                	ld	s5,120(sp)
ffffffffc0209852:	7b46                	ld	s6,112(sp)
ffffffffc0209854:	7ba6                	ld	s7,104(sp)
ffffffffc0209856:	7c06                	ld	s8,96(sp)
ffffffffc0209858:	6ce6                	ld	s9,88(sp)
ffffffffc020985a:	6d46                	ld	s10,80(sp)
ffffffffc020985c:	6da6                	ld	s11,72(sp)
ffffffffc020985e:	8552                	mv	a0,s4
ffffffffc0209860:	6a0a                	ld	s4,128(sp)
ffffffffc0209862:	614d                	addi	sp,sp,176
ffffffffc0209864:	8082                	ret
ffffffffc0209866:	5a71                	li	s4,-4
ffffffffc0209868:	bfe1                	j	ffffffffc0209840 <sfs_do_mount+0x18a>
ffffffffc020986a:	85be                	mv	a1,a5
ffffffffc020986c:	00006517          	auipc	a0,0x6
ffffffffc0209870:	80450513          	addi	a0,a0,-2044 # ffffffffc020f070 <dev_node_ops+0x4d8>
ffffffffc0209874:	933f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209878:	5a75                	li	s4,-3
ffffffffc020987a:	b7c1                	j	ffffffffc020983a <sfs_do_mount+0x184>
ffffffffc020987c:	00005517          	auipc	a0,0x5
ffffffffc0209880:	7bc50513          	addi	a0,a0,1980 # ffffffffc020f038 <dev_node_ops+0x4a0>
ffffffffc0209884:	923f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209888:	5a75                	li	s4,-3
ffffffffc020988a:	bf45                	j	ffffffffc020983a <sfs_do_mount+0x184>
ffffffffc020988c:	00442903          	lw	s2,4(s0)
ffffffffc0209890:	4481                	li	s1,0
ffffffffc0209892:	080b8c63          	beqz	s7,ffffffffc020992a <sfs_do_mount+0x274>
ffffffffc0209896:	85a6                	mv	a1,s1
ffffffffc0209898:	856a                	mv	a0,s10
ffffffffc020989a:	af7ff0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc020989e:	c111                	beqz	a0,ffffffffc02098a2 <sfs_do_mount+0x1ec>
ffffffffc02098a0:	2b05                	addiw	s6,s6,1
ffffffffc02098a2:	2485                	addiw	s1,s1,1
ffffffffc02098a4:	fe9b99e3          	bne	s7,s1,ffffffffc0209896 <sfs_do_mount+0x1e0>
ffffffffc02098a8:	441c                	lw	a5,8(s0)
ffffffffc02098aa:	0d679463          	bne	a5,s6,ffffffffc0209972 <sfs_do_mount+0x2bc>
ffffffffc02098ae:	4585                	li	a1,1
ffffffffc02098b0:	05040513          	addi	a0,s0,80
ffffffffc02098b4:	04043023          	sd	zero,64(s0)
ffffffffc02098b8:	d3bfa0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc02098bc:	4585                	li	a1,1
ffffffffc02098be:	06840513          	addi	a0,s0,104
ffffffffc02098c2:	d31fa0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc02098c6:	4585                	li	a1,1
ffffffffc02098c8:	08040513          	addi	a0,s0,128
ffffffffc02098cc:	d27fa0ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc02098d0:	09840793          	addi	a5,s0,152
ffffffffc02098d4:	f05c                	sd	a5,160(s0)
ffffffffc02098d6:	ec5c                	sd	a5,152(s0)
ffffffffc02098d8:	874a                	mv	a4,s2
ffffffffc02098da:	86da                	mv	a3,s6
ffffffffc02098dc:	4169063b          	subw	a2,s2,s6
ffffffffc02098e0:	00c40593          	addi	a1,s0,12
ffffffffc02098e4:	00006517          	auipc	a0,0x6
ffffffffc02098e8:	81c50513          	addi	a0,a0,-2020 # ffffffffc020f100 <dev_node_ops+0x568>
ffffffffc02098ec:	8bbf60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02098f0:	00000797          	auipc	a5,0x0
ffffffffc02098f4:	c8878793          	addi	a5,a5,-888 # ffffffffc0209578 <sfs_sync>
ffffffffc02098f8:	fc5c                	sd	a5,184(s0)
ffffffffc02098fa:	00000797          	auipc	a5,0x0
ffffffffc02098fe:	d6478793          	addi	a5,a5,-668 # ffffffffc020965e <sfs_get_root>
ffffffffc0209902:	e07c                	sd	a5,192(s0)
ffffffffc0209904:	00000797          	auipc	a5,0x0
ffffffffc0209908:	b5e78793          	addi	a5,a5,-1186 # ffffffffc0209462 <sfs_unmount>
ffffffffc020990c:	e47c                	sd	a5,200(s0)
ffffffffc020990e:	00000797          	auipc	a5,0x0
ffffffffc0209912:	bd878793          	addi	a5,a5,-1064 # ffffffffc02094e6 <sfs_cleanup>
ffffffffc0209916:	e87c                	sd	a5,208(s0)
ffffffffc0209918:	008ab023          	sd	s0,0(s5)
ffffffffc020991c:	b72d                	j	ffffffffc0209846 <sfs_do_mount+0x190>
ffffffffc020991e:	5a71                	li	s4,-4
ffffffffc0209920:	bf11                	j	ffffffffc0209834 <sfs_do_mount+0x17e>
ffffffffc0209922:	5a49                	li	s4,-14
ffffffffc0209924:	b70d                	j	ffffffffc0209846 <sfs_do_mount+0x190>
ffffffffc0209926:	5a71                	li	s4,-4
ffffffffc0209928:	bf09                	j	ffffffffc020983a <sfs_do_mount+0x184>
ffffffffc020992a:	4b01                	li	s6,0
ffffffffc020992c:	bfb5                	j	ffffffffc02098a8 <sfs_do_mount+0x1f2>
ffffffffc020992e:	5a71                	li	s4,-4
ffffffffc0209930:	bf19                	j	ffffffffc0209846 <sfs_do_mount+0x190>
ffffffffc0209932:	00005697          	auipc	a3,0x5
ffffffffc0209936:	76e68693          	addi	a3,a3,1902 # ffffffffc020f0a0 <dev_node_ops+0x508>
ffffffffc020993a:	00002617          	auipc	a2,0x2
ffffffffc020993e:	3c660613          	addi	a2,a2,966 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209942:	08300593          	li	a1,131
ffffffffc0209946:	00005517          	auipc	a0,0x5
ffffffffc020994a:	66250513          	addi	a0,a0,1634 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc020994e:	b51f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209952:	00005697          	auipc	a3,0x5
ffffffffc0209956:	62668693          	addi	a3,a3,1574 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc020995a:	00002617          	auipc	a2,0x2
ffffffffc020995e:	3a660613          	addi	a2,a2,934 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209962:	0a300593          	li	a1,163
ffffffffc0209966:	00005517          	auipc	a0,0x5
ffffffffc020996a:	64250513          	addi	a0,a0,1602 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc020996e:	b31f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209972:	00005697          	auipc	a3,0x5
ffffffffc0209976:	75e68693          	addi	a3,a3,1886 # ffffffffc020f0d0 <dev_node_ops+0x538>
ffffffffc020997a:	00002617          	auipc	a2,0x2
ffffffffc020997e:	38660613          	addi	a2,a2,902 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209982:	0e000593          	li	a1,224
ffffffffc0209986:	00005517          	auipc	a0,0x5
ffffffffc020998a:	62250513          	addi	a0,a0,1570 # ffffffffc020efa8 <dev_node_ops+0x410>
ffffffffc020998e:	b11f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209992 <sfs_mount>:
ffffffffc0209992:	00000597          	auipc	a1,0x0
ffffffffc0209996:	d2458593          	addi	a1,a1,-732 # ffffffffc02096b6 <sfs_do_mount>
ffffffffc020999a:	817fe06f          	j	ffffffffc02081b0 <vfs_mount>

ffffffffc020999e <sfs_opendir>:
ffffffffc020999e:	0235f593          	andi	a1,a1,35
ffffffffc02099a2:	4501                	li	a0,0
ffffffffc02099a4:	e191                	bnez	a1,ffffffffc02099a8 <sfs_opendir+0xa>
ffffffffc02099a6:	8082                	ret
ffffffffc02099a8:	553d                	li	a0,-17
ffffffffc02099aa:	8082                	ret

ffffffffc02099ac <sfs_openfile>:
ffffffffc02099ac:	4501                	li	a0,0
ffffffffc02099ae:	8082                	ret

ffffffffc02099b0 <sfs_gettype>:
ffffffffc02099b0:	1141                	addi	sp,sp,-16
ffffffffc02099b2:	e406                	sd	ra,8(sp)
ffffffffc02099b4:	c939                	beqz	a0,ffffffffc0209a0a <sfs_gettype+0x5a>
ffffffffc02099b6:	4d34                	lw	a3,88(a0)
ffffffffc02099b8:	6785                	lui	a5,0x1
ffffffffc02099ba:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02099be:	04e69663          	bne	a3,a4,ffffffffc0209a0a <sfs_gettype+0x5a>
ffffffffc02099c2:	6114                	ld	a3,0(a0)
ffffffffc02099c4:	4709                	li	a4,2
ffffffffc02099c6:	0046d683          	lhu	a3,4(a3)
ffffffffc02099ca:	02e68a63          	beq	a3,a4,ffffffffc02099fe <sfs_gettype+0x4e>
ffffffffc02099ce:	470d                	li	a4,3
ffffffffc02099d0:	02e68163          	beq	a3,a4,ffffffffc02099f2 <sfs_gettype+0x42>
ffffffffc02099d4:	4705                	li	a4,1
ffffffffc02099d6:	00e68f63          	beq	a3,a4,ffffffffc02099f4 <sfs_gettype+0x44>
ffffffffc02099da:	00005617          	auipc	a2,0x5
ffffffffc02099de:	79660613          	addi	a2,a2,1942 # ffffffffc020f170 <dev_node_ops+0x5d8>
ffffffffc02099e2:	39900593          	li	a1,921
ffffffffc02099e6:	00005517          	auipc	a0,0x5
ffffffffc02099ea:	77250513          	addi	a0,a0,1906 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc02099ee:	ab1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02099f2:	678d                	lui	a5,0x3
ffffffffc02099f4:	60a2                	ld	ra,8(sp)
ffffffffc02099f6:	c19c                	sw	a5,0(a1)
ffffffffc02099f8:	4501                	li	a0,0
ffffffffc02099fa:	0141                	addi	sp,sp,16
ffffffffc02099fc:	8082                	ret
ffffffffc02099fe:	60a2                	ld	ra,8(sp)
ffffffffc0209a00:	6789                	lui	a5,0x2
ffffffffc0209a02:	c19c                	sw	a5,0(a1)
ffffffffc0209a04:	4501                	li	a0,0
ffffffffc0209a06:	0141                	addi	sp,sp,16
ffffffffc0209a08:	8082                	ret
ffffffffc0209a0a:	00005697          	auipc	a3,0x5
ffffffffc0209a0e:	71668693          	addi	a3,a3,1814 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc0209a12:	00002617          	auipc	a2,0x2
ffffffffc0209a16:	2ee60613          	addi	a2,a2,750 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209a1a:	38d00593          	li	a1,909
ffffffffc0209a1e:	00005517          	auipc	a0,0x5
ffffffffc0209a22:	73a50513          	addi	a0,a0,1850 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209a26:	a79f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209a2a <sfs_fsync>:
ffffffffc0209a2a:	7179                	addi	sp,sp,-48
ffffffffc0209a2c:	ec26                	sd	s1,24(sp)
ffffffffc0209a2e:	7524                	ld	s1,104(a0)
ffffffffc0209a30:	f406                	sd	ra,40(sp)
ffffffffc0209a32:	f022                	sd	s0,32(sp)
ffffffffc0209a34:	e84a                	sd	s2,16(sp)
ffffffffc0209a36:	e44e                	sd	s3,8(sp)
ffffffffc0209a38:	c4bd                	beqz	s1,ffffffffc0209aa6 <sfs_fsync+0x7c>
ffffffffc0209a3a:	0b04a783          	lw	a5,176(s1)
ffffffffc0209a3e:	e7a5                	bnez	a5,ffffffffc0209aa6 <sfs_fsync+0x7c>
ffffffffc0209a40:	4d38                	lw	a4,88(a0)
ffffffffc0209a42:	6785                	lui	a5,0x1
ffffffffc0209a44:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209a48:	842a                	mv	s0,a0
ffffffffc0209a4a:	06f71e63          	bne	a4,a5,ffffffffc0209ac6 <sfs_fsync+0x9c>
ffffffffc0209a4e:	691c                	ld	a5,16(a0)
ffffffffc0209a50:	4901                	li	s2,0
ffffffffc0209a52:	eb89                	bnez	a5,ffffffffc0209a64 <sfs_fsync+0x3a>
ffffffffc0209a54:	70a2                	ld	ra,40(sp)
ffffffffc0209a56:	7402                	ld	s0,32(sp)
ffffffffc0209a58:	64e2                	ld	s1,24(sp)
ffffffffc0209a5a:	69a2                	ld	s3,8(sp)
ffffffffc0209a5c:	854a                	mv	a0,s2
ffffffffc0209a5e:	6942                	ld	s2,16(sp)
ffffffffc0209a60:	6145                	addi	sp,sp,48
ffffffffc0209a62:	8082                	ret
ffffffffc0209a64:	02050993          	addi	s3,a0,32
ffffffffc0209a68:	854e                	mv	a0,s3
ffffffffc0209a6a:	b93fa0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc0209a6e:	681c                	ld	a5,16(s0)
ffffffffc0209a70:	ef81                	bnez	a5,ffffffffc0209a88 <sfs_fsync+0x5e>
ffffffffc0209a72:	854e                	mv	a0,s3
ffffffffc0209a74:	b85fa0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc0209a78:	70a2                	ld	ra,40(sp)
ffffffffc0209a7a:	7402                	ld	s0,32(sp)
ffffffffc0209a7c:	64e2                	ld	s1,24(sp)
ffffffffc0209a7e:	69a2                	ld	s3,8(sp)
ffffffffc0209a80:	854a                	mv	a0,s2
ffffffffc0209a82:	6942                	ld	s2,16(sp)
ffffffffc0209a84:	6145                	addi	sp,sp,48
ffffffffc0209a86:	8082                	ret
ffffffffc0209a88:	4414                	lw	a3,8(s0)
ffffffffc0209a8a:	600c                	ld	a1,0(s0)
ffffffffc0209a8c:	00043823          	sd	zero,16(s0)
ffffffffc0209a90:	4701                	li	a4,0
ffffffffc0209a92:	04000613          	li	a2,64
ffffffffc0209a96:	8526                	mv	a0,s1
ffffffffc0209a98:	67e010ef          	jal	ra,ffffffffc020b116 <sfs_wbuf>
ffffffffc0209a9c:	892a                	mv	s2,a0
ffffffffc0209a9e:	d971                	beqz	a0,ffffffffc0209a72 <sfs_fsync+0x48>
ffffffffc0209aa0:	4785                	li	a5,1
ffffffffc0209aa2:	e81c                	sd	a5,16(s0)
ffffffffc0209aa4:	b7f9                	j	ffffffffc0209a72 <sfs_fsync+0x48>
ffffffffc0209aa6:	00005697          	auipc	a3,0x5
ffffffffc0209aaa:	4d268693          	addi	a3,a3,1234 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc0209aae:	00002617          	auipc	a2,0x2
ffffffffc0209ab2:	25260613          	addi	a2,a2,594 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209ab6:	2d100593          	li	a1,721
ffffffffc0209aba:	00005517          	auipc	a0,0x5
ffffffffc0209abe:	69e50513          	addi	a0,a0,1694 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209ac2:	9ddf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209ac6:	00005697          	auipc	a3,0x5
ffffffffc0209aca:	65a68693          	addi	a3,a3,1626 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc0209ace:	00002617          	auipc	a2,0x2
ffffffffc0209ad2:	23260613          	addi	a2,a2,562 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209ad6:	2d200593          	li	a1,722
ffffffffc0209ada:	00005517          	auipc	a0,0x5
ffffffffc0209ade:	67e50513          	addi	a0,a0,1662 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209ae2:	9bdf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209ae6 <sfs_fstat>:
ffffffffc0209ae6:	1101                	addi	sp,sp,-32
ffffffffc0209ae8:	e426                	sd	s1,8(sp)
ffffffffc0209aea:	84ae                	mv	s1,a1
ffffffffc0209aec:	e822                	sd	s0,16(sp)
ffffffffc0209aee:	02000613          	li	a2,32
ffffffffc0209af2:	842a                	mv	s0,a0
ffffffffc0209af4:	4581                	li	a1,0
ffffffffc0209af6:	8526                	mv	a0,s1
ffffffffc0209af8:	ec06                	sd	ra,24(sp)
ffffffffc0209afa:	521010ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc0209afe:	c439                	beqz	s0,ffffffffc0209b4c <sfs_fstat+0x66>
ffffffffc0209b00:	783c                	ld	a5,112(s0)
ffffffffc0209b02:	c7a9                	beqz	a5,ffffffffc0209b4c <sfs_fstat+0x66>
ffffffffc0209b04:	6bbc                	ld	a5,80(a5)
ffffffffc0209b06:	c3b9                	beqz	a5,ffffffffc0209b4c <sfs_fstat+0x66>
ffffffffc0209b08:	00005597          	auipc	a1,0x5
ffffffffc0209b0c:	00858593          	addi	a1,a1,8 # ffffffffc020eb10 <syscalls+0xdb0>
ffffffffc0209b10:	8522                	mv	a0,s0
ffffffffc0209b12:	8cefe0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0209b16:	783c                	ld	a5,112(s0)
ffffffffc0209b18:	85a6                	mv	a1,s1
ffffffffc0209b1a:	8522                	mv	a0,s0
ffffffffc0209b1c:	6bbc                	ld	a5,80(a5)
ffffffffc0209b1e:	9782                	jalr	a5
ffffffffc0209b20:	e10d                	bnez	a0,ffffffffc0209b42 <sfs_fstat+0x5c>
ffffffffc0209b22:	4c38                	lw	a4,88(s0)
ffffffffc0209b24:	6785                	lui	a5,0x1
ffffffffc0209b26:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209b2a:	04f71163          	bne	a4,a5,ffffffffc0209b6c <sfs_fstat+0x86>
ffffffffc0209b2e:	601c                	ld	a5,0(s0)
ffffffffc0209b30:	0067d683          	lhu	a3,6(a5)
ffffffffc0209b34:	0087e703          	lwu	a4,8(a5)
ffffffffc0209b38:	0007e783          	lwu	a5,0(a5)
ffffffffc0209b3c:	e494                	sd	a3,8(s1)
ffffffffc0209b3e:	e898                	sd	a4,16(s1)
ffffffffc0209b40:	ec9c                	sd	a5,24(s1)
ffffffffc0209b42:	60e2                	ld	ra,24(sp)
ffffffffc0209b44:	6442                	ld	s0,16(sp)
ffffffffc0209b46:	64a2                	ld	s1,8(sp)
ffffffffc0209b48:	6105                	addi	sp,sp,32
ffffffffc0209b4a:	8082                	ret
ffffffffc0209b4c:	00005697          	auipc	a3,0x5
ffffffffc0209b50:	f5c68693          	addi	a3,a3,-164 # ffffffffc020eaa8 <syscalls+0xd48>
ffffffffc0209b54:	00002617          	auipc	a2,0x2
ffffffffc0209b58:	1ac60613          	addi	a2,a2,428 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209b5c:	2c200593          	li	a1,706
ffffffffc0209b60:	00005517          	auipc	a0,0x5
ffffffffc0209b64:	5f850513          	addi	a0,a0,1528 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209b68:	937f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b6c:	00005697          	auipc	a3,0x5
ffffffffc0209b70:	5b468693          	addi	a3,a3,1460 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc0209b74:	00002617          	auipc	a2,0x2
ffffffffc0209b78:	18c60613          	addi	a2,a2,396 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209b7c:	2c500593          	li	a1,709
ffffffffc0209b80:	00005517          	auipc	a0,0x5
ffffffffc0209b84:	5d850513          	addi	a0,a0,1496 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209b88:	917f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209b8c <sfs_tryseek>:
ffffffffc0209b8c:	080007b7          	lui	a5,0x8000
ffffffffc0209b90:	04f5fd63          	bgeu	a1,a5,ffffffffc0209bea <sfs_tryseek+0x5e>
ffffffffc0209b94:	1101                	addi	sp,sp,-32
ffffffffc0209b96:	e822                	sd	s0,16(sp)
ffffffffc0209b98:	ec06                	sd	ra,24(sp)
ffffffffc0209b9a:	e426                	sd	s1,8(sp)
ffffffffc0209b9c:	842a                	mv	s0,a0
ffffffffc0209b9e:	c921                	beqz	a0,ffffffffc0209bee <sfs_tryseek+0x62>
ffffffffc0209ba0:	4d38                	lw	a4,88(a0)
ffffffffc0209ba2:	6785                	lui	a5,0x1
ffffffffc0209ba4:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209ba8:	04f71363          	bne	a4,a5,ffffffffc0209bee <sfs_tryseek+0x62>
ffffffffc0209bac:	611c                	ld	a5,0(a0)
ffffffffc0209bae:	84ae                	mv	s1,a1
ffffffffc0209bb0:	0007e783          	lwu	a5,0(a5)
ffffffffc0209bb4:	02b7d563          	bge	a5,a1,ffffffffc0209bde <sfs_tryseek+0x52>
ffffffffc0209bb8:	793c                	ld	a5,112(a0)
ffffffffc0209bba:	cbb1                	beqz	a5,ffffffffc0209c0e <sfs_tryseek+0x82>
ffffffffc0209bbc:	73bc                	ld	a5,96(a5)
ffffffffc0209bbe:	cba1                	beqz	a5,ffffffffc0209c0e <sfs_tryseek+0x82>
ffffffffc0209bc0:	00005597          	auipc	a1,0x5
ffffffffc0209bc4:	e4058593          	addi	a1,a1,-448 # ffffffffc020ea00 <syscalls+0xca0>
ffffffffc0209bc8:	818fe0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0209bcc:	783c                	ld	a5,112(s0)
ffffffffc0209bce:	8522                	mv	a0,s0
ffffffffc0209bd0:	6442                	ld	s0,16(sp)
ffffffffc0209bd2:	60e2                	ld	ra,24(sp)
ffffffffc0209bd4:	73bc                	ld	a5,96(a5)
ffffffffc0209bd6:	85a6                	mv	a1,s1
ffffffffc0209bd8:	64a2                	ld	s1,8(sp)
ffffffffc0209bda:	6105                	addi	sp,sp,32
ffffffffc0209bdc:	8782                	jr	a5
ffffffffc0209bde:	60e2                	ld	ra,24(sp)
ffffffffc0209be0:	6442                	ld	s0,16(sp)
ffffffffc0209be2:	64a2                	ld	s1,8(sp)
ffffffffc0209be4:	4501                	li	a0,0
ffffffffc0209be6:	6105                	addi	sp,sp,32
ffffffffc0209be8:	8082                	ret
ffffffffc0209bea:	5575                	li	a0,-3
ffffffffc0209bec:	8082                	ret
ffffffffc0209bee:	00005697          	auipc	a3,0x5
ffffffffc0209bf2:	53268693          	addi	a3,a3,1330 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc0209bf6:	00002617          	auipc	a2,0x2
ffffffffc0209bfa:	10a60613          	addi	a2,a2,266 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209bfe:	3a400593          	li	a1,932
ffffffffc0209c02:	00005517          	auipc	a0,0x5
ffffffffc0209c06:	55650513          	addi	a0,a0,1366 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209c0a:	895f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c0e:	00005697          	auipc	a3,0x5
ffffffffc0209c12:	d9a68693          	addi	a3,a3,-614 # ffffffffc020e9a8 <syscalls+0xc48>
ffffffffc0209c16:	00002617          	auipc	a2,0x2
ffffffffc0209c1a:	0ea60613          	addi	a2,a2,234 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209c1e:	3a600593          	li	a1,934
ffffffffc0209c22:	00005517          	auipc	a0,0x5
ffffffffc0209c26:	53650513          	addi	a0,a0,1334 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209c2a:	875f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c2e <sfs_close>:
ffffffffc0209c2e:	1141                	addi	sp,sp,-16
ffffffffc0209c30:	e406                	sd	ra,8(sp)
ffffffffc0209c32:	e022                	sd	s0,0(sp)
ffffffffc0209c34:	c11d                	beqz	a0,ffffffffc0209c5a <sfs_close+0x2c>
ffffffffc0209c36:	793c                	ld	a5,112(a0)
ffffffffc0209c38:	842a                	mv	s0,a0
ffffffffc0209c3a:	c385                	beqz	a5,ffffffffc0209c5a <sfs_close+0x2c>
ffffffffc0209c3c:	7b9c                	ld	a5,48(a5)
ffffffffc0209c3e:	cf91                	beqz	a5,ffffffffc0209c5a <sfs_close+0x2c>
ffffffffc0209c40:	00004597          	auipc	a1,0x4
ffffffffc0209c44:	a8058593          	addi	a1,a1,-1408 # ffffffffc020d6c0 <default_pmm_manager+0xea0>
ffffffffc0209c48:	f99fd0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0209c4c:	783c                	ld	a5,112(s0)
ffffffffc0209c4e:	8522                	mv	a0,s0
ffffffffc0209c50:	6402                	ld	s0,0(sp)
ffffffffc0209c52:	60a2                	ld	ra,8(sp)
ffffffffc0209c54:	7b9c                	ld	a5,48(a5)
ffffffffc0209c56:	0141                	addi	sp,sp,16
ffffffffc0209c58:	8782                	jr	a5
ffffffffc0209c5a:	00004697          	auipc	a3,0x4
ffffffffc0209c5e:	a1668693          	addi	a3,a3,-1514 # ffffffffc020d670 <default_pmm_manager+0xe50>
ffffffffc0209c62:	00002617          	auipc	a2,0x2
ffffffffc0209c66:	09e60613          	addi	a2,a2,158 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209c6a:	21c00593          	li	a1,540
ffffffffc0209c6e:	00005517          	auipc	a0,0x5
ffffffffc0209c72:	4ea50513          	addi	a0,a0,1258 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209c76:	829f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c7a <sfs_io.part.0>:
ffffffffc0209c7a:	1141                	addi	sp,sp,-16
ffffffffc0209c7c:	00005697          	auipc	a3,0x5
ffffffffc0209c80:	4a468693          	addi	a3,a3,1188 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc0209c84:	00002617          	auipc	a2,0x2
ffffffffc0209c88:	07c60613          	addi	a2,a2,124 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209c8c:	2a100593          	li	a1,673
ffffffffc0209c90:	00005517          	auipc	a0,0x5
ffffffffc0209c94:	4c850513          	addi	a0,a0,1224 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209c98:	e406                	sd	ra,8(sp)
ffffffffc0209c9a:	805f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c9e <sfs_block_free>:
ffffffffc0209c9e:	1101                	addi	sp,sp,-32
ffffffffc0209ca0:	e426                	sd	s1,8(sp)
ffffffffc0209ca2:	ec06                	sd	ra,24(sp)
ffffffffc0209ca4:	e822                	sd	s0,16(sp)
ffffffffc0209ca6:	4154                	lw	a3,4(a0)
ffffffffc0209ca8:	84ae                	mv	s1,a1
ffffffffc0209caa:	c595                	beqz	a1,ffffffffc0209cd6 <sfs_block_free+0x38>
ffffffffc0209cac:	02d5f563          	bgeu	a1,a3,ffffffffc0209cd6 <sfs_block_free+0x38>
ffffffffc0209cb0:	842a                	mv	s0,a0
ffffffffc0209cb2:	7d08                	ld	a0,56(a0)
ffffffffc0209cb4:	edcff0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc0209cb8:	ed05                	bnez	a0,ffffffffc0209cf0 <sfs_block_free+0x52>
ffffffffc0209cba:	7c08                	ld	a0,56(s0)
ffffffffc0209cbc:	85a6                	mv	a1,s1
ffffffffc0209cbe:	efaff0ef          	jal	ra,ffffffffc02093b8 <bitmap_free>
ffffffffc0209cc2:	441c                	lw	a5,8(s0)
ffffffffc0209cc4:	4705                	li	a4,1
ffffffffc0209cc6:	60e2                	ld	ra,24(sp)
ffffffffc0209cc8:	2785                	addiw	a5,a5,1
ffffffffc0209cca:	e038                	sd	a4,64(s0)
ffffffffc0209ccc:	c41c                	sw	a5,8(s0)
ffffffffc0209cce:	6442                	ld	s0,16(sp)
ffffffffc0209cd0:	64a2                	ld	s1,8(sp)
ffffffffc0209cd2:	6105                	addi	sp,sp,32
ffffffffc0209cd4:	8082                	ret
ffffffffc0209cd6:	8726                	mv	a4,s1
ffffffffc0209cd8:	00005617          	auipc	a2,0x5
ffffffffc0209cdc:	4b060613          	addi	a2,a2,1200 # ffffffffc020f188 <dev_node_ops+0x5f0>
ffffffffc0209ce0:	05300593          	li	a1,83
ffffffffc0209ce4:	00005517          	auipc	a0,0x5
ffffffffc0209ce8:	47450513          	addi	a0,a0,1140 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209cec:	fb2f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cf0:	00005697          	auipc	a3,0x5
ffffffffc0209cf4:	4d068693          	addi	a3,a3,1232 # ffffffffc020f1c0 <dev_node_ops+0x628>
ffffffffc0209cf8:	00002617          	auipc	a2,0x2
ffffffffc0209cfc:	00860613          	addi	a2,a2,8 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209d00:	06a00593          	li	a1,106
ffffffffc0209d04:	00005517          	auipc	a0,0x5
ffffffffc0209d08:	45450513          	addi	a0,a0,1108 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209d0c:	f92f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209d10 <sfs_reclaim>:
ffffffffc0209d10:	1101                	addi	sp,sp,-32
ffffffffc0209d12:	e426                	sd	s1,8(sp)
ffffffffc0209d14:	7524                	ld	s1,104(a0)
ffffffffc0209d16:	ec06                	sd	ra,24(sp)
ffffffffc0209d18:	e822                	sd	s0,16(sp)
ffffffffc0209d1a:	e04a                	sd	s2,0(sp)
ffffffffc0209d1c:	0e048a63          	beqz	s1,ffffffffc0209e10 <sfs_reclaim+0x100>
ffffffffc0209d20:	0b04a783          	lw	a5,176(s1)
ffffffffc0209d24:	0e079663          	bnez	a5,ffffffffc0209e10 <sfs_reclaim+0x100>
ffffffffc0209d28:	4d38                	lw	a4,88(a0)
ffffffffc0209d2a:	6785                	lui	a5,0x1
ffffffffc0209d2c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209d30:	842a                	mv	s0,a0
ffffffffc0209d32:	10f71f63          	bne	a4,a5,ffffffffc0209e50 <sfs_reclaim+0x140>
ffffffffc0209d36:	8526                	mv	a0,s1
ffffffffc0209d38:	58e010ef          	jal	ra,ffffffffc020b2c6 <lock_sfs_fs>
ffffffffc0209d3c:	4c1c                	lw	a5,24(s0)
ffffffffc0209d3e:	0ef05963          	blez	a5,ffffffffc0209e30 <sfs_reclaim+0x120>
ffffffffc0209d42:	fff7871b          	addiw	a4,a5,-1
ffffffffc0209d46:	cc18                	sw	a4,24(s0)
ffffffffc0209d48:	eb59                	bnez	a4,ffffffffc0209dde <sfs_reclaim+0xce>
ffffffffc0209d4a:	05c42903          	lw	s2,92(s0)
ffffffffc0209d4e:	08091863          	bnez	s2,ffffffffc0209dde <sfs_reclaim+0xce>
ffffffffc0209d52:	601c                	ld	a5,0(s0)
ffffffffc0209d54:	0067d783          	lhu	a5,6(a5)
ffffffffc0209d58:	e785                	bnez	a5,ffffffffc0209d80 <sfs_reclaim+0x70>
ffffffffc0209d5a:	783c                	ld	a5,112(s0)
ffffffffc0209d5c:	10078a63          	beqz	a5,ffffffffc0209e70 <sfs_reclaim+0x160>
ffffffffc0209d60:	73bc                	ld	a5,96(a5)
ffffffffc0209d62:	10078763          	beqz	a5,ffffffffc0209e70 <sfs_reclaim+0x160>
ffffffffc0209d66:	00005597          	auipc	a1,0x5
ffffffffc0209d6a:	c9a58593          	addi	a1,a1,-870 # ffffffffc020ea00 <syscalls+0xca0>
ffffffffc0209d6e:	8522                	mv	a0,s0
ffffffffc0209d70:	e71fd0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0209d74:	783c                	ld	a5,112(s0)
ffffffffc0209d76:	4581                	li	a1,0
ffffffffc0209d78:	8522                	mv	a0,s0
ffffffffc0209d7a:	73bc                	ld	a5,96(a5)
ffffffffc0209d7c:	9782                	jalr	a5
ffffffffc0209d7e:	e559                	bnez	a0,ffffffffc0209e0c <sfs_reclaim+0xfc>
ffffffffc0209d80:	681c                	ld	a5,16(s0)
ffffffffc0209d82:	c39d                	beqz	a5,ffffffffc0209da8 <sfs_reclaim+0x98>
ffffffffc0209d84:	783c                	ld	a5,112(s0)
ffffffffc0209d86:	10078563          	beqz	a5,ffffffffc0209e90 <sfs_reclaim+0x180>
ffffffffc0209d8a:	7b9c                	ld	a5,48(a5)
ffffffffc0209d8c:	10078263          	beqz	a5,ffffffffc0209e90 <sfs_reclaim+0x180>
ffffffffc0209d90:	8522                	mv	a0,s0
ffffffffc0209d92:	00004597          	auipc	a1,0x4
ffffffffc0209d96:	92e58593          	addi	a1,a1,-1746 # ffffffffc020d6c0 <default_pmm_manager+0xea0>
ffffffffc0209d9a:	e47fd0ef          	jal	ra,ffffffffc0207be0 <inode_check>
ffffffffc0209d9e:	783c                	ld	a5,112(s0)
ffffffffc0209da0:	8522                	mv	a0,s0
ffffffffc0209da2:	7b9c                	ld	a5,48(a5)
ffffffffc0209da4:	9782                	jalr	a5
ffffffffc0209da6:	e13d                	bnez	a0,ffffffffc0209e0c <sfs_reclaim+0xfc>
ffffffffc0209da8:	7c18                	ld	a4,56(s0)
ffffffffc0209daa:	603c                	ld	a5,64(s0)
ffffffffc0209dac:	8526                	mv	a0,s1
ffffffffc0209dae:	e71c                	sd	a5,8(a4)
ffffffffc0209db0:	e398                	sd	a4,0(a5)
ffffffffc0209db2:	6438                	ld	a4,72(s0)
ffffffffc0209db4:	683c                	ld	a5,80(s0)
ffffffffc0209db6:	e71c                	sd	a5,8(a4)
ffffffffc0209db8:	e398                	sd	a4,0(a5)
ffffffffc0209dba:	51c010ef          	jal	ra,ffffffffc020b2d6 <unlock_sfs_fs>
ffffffffc0209dbe:	6008                	ld	a0,0(s0)
ffffffffc0209dc0:	00655783          	lhu	a5,6(a0)
ffffffffc0209dc4:	cb85                	beqz	a5,ffffffffc0209df4 <sfs_reclaim+0xe4>
ffffffffc0209dc6:	b0cf80ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc0209dca:	8522                	mv	a0,s0
ffffffffc0209dcc:	da9fd0ef          	jal	ra,ffffffffc0207b74 <inode_kill>
ffffffffc0209dd0:	60e2                	ld	ra,24(sp)
ffffffffc0209dd2:	6442                	ld	s0,16(sp)
ffffffffc0209dd4:	64a2                	ld	s1,8(sp)
ffffffffc0209dd6:	854a                	mv	a0,s2
ffffffffc0209dd8:	6902                	ld	s2,0(sp)
ffffffffc0209dda:	6105                	addi	sp,sp,32
ffffffffc0209ddc:	8082                	ret
ffffffffc0209dde:	5945                	li	s2,-15
ffffffffc0209de0:	8526                	mv	a0,s1
ffffffffc0209de2:	4f4010ef          	jal	ra,ffffffffc020b2d6 <unlock_sfs_fs>
ffffffffc0209de6:	60e2                	ld	ra,24(sp)
ffffffffc0209de8:	6442                	ld	s0,16(sp)
ffffffffc0209dea:	64a2                	ld	s1,8(sp)
ffffffffc0209dec:	854a                	mv	a0,s2
ffffffffc0209dee:	6902                	ld	s2,0(sp)
ffffffffc0209df0:	6105                	addi	sp,sp,32
ffffffffc0209df2:	8082                	ret
ffffffffc0209df4:	440c                	lw	a1,8(s0)
ffffffffc0209df6:	8526                	mv	a0,s1
ffffffffc0209df8:	ea7ff0ef          	jal	ra,ffffffffc0209c9e <sfs_block_free>
ffffffffc0209dfc:	6008                	ld	a0,0(s0)
ffffffffc0209dfe:	5d4c                	lw	a1,60(a0)
ffffffffc0209e00:	d1f9                	beqz	a1,ffffffffc0209dc6 <sfs_reclaim+0xb6>
ffffffffc0209e02:	8526                	mv	a0,s1
ffffffffc0209e04:	e9bff0ef          	jal	ra,ffffffffc0209c9e <sfs_block_free>
ffffffffc0209e08:	6008                	ld	a0,0(s0)
ffffffffc0209e0a:	bf75                	j	ffffffffc0209dc6 <sfs_reclaim+0xb6>
ffffffffc0209e0c:	892a                	mv	s2,a0
ffffffffc0209e0e:	bfc9                	j	ffffffffc0209de0 <sfs_reclaim+0xd0>
ffffffffc0209e10:	00005697          	auipc	a3,0x5
ffffffffc0209e14:	16868693          	addi	a3,a3,360 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc0209e18:	00002617          	auipc	a2,0x2
ffffffffc0209e1c:	ee860613          	addi	a2,a2,-280 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209e20:	36200593          	li	a1,866
ffffffffc0209e24:	00005517          	auipc	a0,0x5
ffffffffc0209e28:	33450513          	addi	a0,a0,820 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209e2c:	e72f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e30:	00005697          	auipc	a3,0x5
ffffffffc0209e34:	3b068693          	addi	a3,a3,944 # ffffffffc020f1e0 <dev_node_ops+0x648>
ffffffffc0209e38:	00002617          	auipc	a2,0x2
ffffffffc0209e3c:	ec860613          	addi	a2,a2,-312 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209e40:	36800593          	li	a1,872
ffffffffc0209e44:	00005517          	auipc	a0,0x5
ffffffffc0209e48:	31450513          	addi	a0,a0,788 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209e4c:	e52f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e50:	00005697          	auipc	a3,0x5
ffffffffc0209e54:	2d068693          	addi	a3,a3,720 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc0209e58:	00002617          	auipc	a2,0x2
ffffffffc0209e5c:	ea860613          	addi	a2,a2,-344 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209e60:	36300593          	li	a1,867
ffffffffc0209e64:	00005517          	auipc	a0,0x5
ffffffffc0209e68:	2f450513          	addi	a0,a0,756 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209e6c:	e32f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e70:	00005697          	auipc	a3,0x5
ffffffffc0209e74:	b3868693          	addi	a3,a3,-1224 # ffffffffc020e9a8 <syscalls+0xc48>
ffffffffc0209e78:	00002617          	auipc	a2,0x2
ffffffffc0209e7c:	e8860613          	addi	a2,a2,-376 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209e80:	36d00593          	li	a1,877
ffffffffc0209e84:	00005517          	auipc	a0,0x5
ffffffffc0209e88:	2d450513          	addi	a0,a0,724 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209e8c:	e12f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e90:	00003697          	auipc	a3,0x3
ffffffffc0209e94:	7e068693          	addi	a3,a3,2016 # ffffffffc020d670 <default_pmm_manager+0xe50>
ffffffffc0209e98:	00002617          	auipc	a2,0x2
ffffffffc0209e9c:	e6860613          	addi	a2,a2,-408 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209ea0:	37200593          	li	a1,882
ffffffffc0209ea4:	00005517          	auipc	a0,0x5
ffffffffc0209ea8:	2b450513          	addi	a0,a0,692 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209eac:	df2f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209eb0 <sfs_block_alloc>:
ffffffffc0209eb0:	1101                	addi	sp,sp,-32
ffffffffc0209eb2:	e822                	sd	s0,16(sp)
ffffffffc0209eb4:	842a                	mv	s0,a0
ffffffffc0209eb6:	7d08                	ld	a0,56(a0)
ffffffffc0209eb8:	e426                	sd	s1,8(sp)
ffffffffc0209eba:	ec06                	sd	ra,24(sp)
ffffffffc0209ebc:	84ae                	mv	s1,a1
ffffffffc0209ebe:	c62ff0ef          	jal	ra,ffffffffc0209320 <bitmap_alloc>
ffffffffc0209ec2:	e90d                	bnez	a0,ffffffffc0209ef4 <sfs_block_alloc+0x44>
ffffffffc0209ec4:	441c                	lw	a5,8(s0)
ffffffffc0209ec6:	cbad                	beqz	a5,ffffffffc0209f38 <sfs_block_alloc+0x88>
ffffffffc0209ec8:	37fd                	addiw	a5,a5,-1
ffffffffc0209eca:	c41c                	sw	a5,8(s0)
ffffffffc0209ecc:	408c                	lw	a1,0(s1)
ffffffffc0209ece:	4785                	li	a5,1
ffffffffc0209ed0:	e03c                	sd	a5,64(s0)
ffffffffc0209ed2:	4054                	lw	a3,4(s0)
ffffffffc0209ed4:	c58d                	beqz	a1,ffffffffc0209efe <sfs_block_alloc+0x4e>
ffffffffc0209ed6:	02d5f463          	bgeu	a1,a3,ffffffffc0209efe <sfs_block_alloc+0x4e>
ffffffffc0209eda:	7c08                	ld	a0,56(s0)
ffffffffc0209edc:	cb4ff0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc0209ee0:	ed05                	bnez	a0,ffffffffc0209f18 <sfs_block_alloc+0x68>
ffffffffc0209ee2:	8522                	mv	a0,s0
ffffffffc0209ee4:	6442                	ld	s0,16(sp)
ffffffffc0209ee6:	408c                	lw	a1,0(s1)
ffffffffc0209ee8:	60e2                	ld	ra,24(sp)
ffffffffc0209eea:	64a2                	ld	s1,8(sp)
ffffffffc0209eec:	4605                	li	a2,1
ffffffffc0209eee:	6105                	addi	sp,sp,32
ffffffffc0209ef0:	3760106f          	j	ffffffffc020b266 <sfs_clear_block>
ffffffffc0209ef4:	60e2                	ld	ra,24(sp)
ffffffffc0209ef6:	6442                	ld	s0,16(sp)
ffffffffc0209ef8:	64a2                	ld	s1,8(sp)
ffffffffc0209efa:	6105                	addi	sp,sp,32
ffffffffc0209efc:	8082                	ret
ffffffffc0209efe:	872e                	mv	a4,a1
ffffffffc0209f00:	00005617          	auipc	a2,0x5
ffffffffc0209f04:	28860613          	addi	a2,a2,648 # ffffffffc020f188 <dev_node_ops+0x5f0>
ffffffffc0209f08:	05300593          	li	a1,83
ffffffffc0209f0c:	00005517          	auipc	a0,0x5
ffffffffc0209f10:	24c50513          	addi	a0,a0,588 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209f14:	d8af60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f18:	00005697          	auipc	a3,0x5
ffffffffc0209f1c:	30068693          	addi	a3,a3,768 # ffffffffc020f218 <dev_node_ops+0x680>
ffffffffc0209f20:	00002617          	auipc	a2,0x2
ffffffffc0209f24:	de060613          	addi	a2,a2,-544 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209f28:	06100593          	li	a1,97
ffffffffc0209f2c:	00005517          	auipc	a0,0x5
ffffffffc0209f30:	22c50513          	addi	a0,a0,556 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209f34:	d6af60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f38:	00005697          	auipc	a3,0x5
ffffffffc0209f3c:	2c068693          	addi	a3,a3,704 # ffffffffc020f1f8 <dev_node_ops+0x660>
ffffffffc0209f40:	00002617          	auipc	a2,0x2
ffffffffc0209f44:	dc060613          	addi	a2,a2,-576 # ffffffffc020bd00 <commands+0x210>
ffffffffc0209f48:	05f00593          	li	a1,95
ffffffffc0209f4c:	00005517          	auipc	a0,0x5
ffffffffc0209f50:	20c50513          	addi	a0,a0,524 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209f54:	d4af60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209f58 <sfs_bmap_load_nolock>:
ffffffffc0209f58:	7159                	addi	sp,sp,-112
ffffffffc0209f5a:	f85a                	sd	s6,48(sp)
ffffffffc0209f5c:	0005bb03          	ld	s6,0(a1)
ffffffffc0209f60:	f45e                	sd	s7,40(sp)
ffffffffc0209f62:	f486                	sd	ra,104(sp)
ffffffffc0209f64:	008b2b83          	lw	s7,8(s6)
ffffffffc0209f68:	f0a2                	sd	s0,96(sp)
ffffffffc0209f6a:	eca6                	sd	s1,88(sp)
ffffffffc0209f6c:	e8ca                	sd	s2,80(sp)
ffffffffc0209f6e:	e4ce                	sd	s3,72(sp)
ffffffffc0209f70:	e0d2                	sd	s4,64(sp)
ffffffffc0209f72:	fc56                	sd	s5,56(sp)
ffffffffc0209f74:	f062                	sd	s8,32(sp)
ffffffffc0209f76:	ec66                	sd	s9,24(sp)
ffffffffc0209f78:	18cbe363          	bltu	s7,a2,ffffffffc020a0fe <sfs_bmap_load_nolock+0x1a6>
ffffffffc0209f7c:	47ad                	li	a5,11
ffffffffc0209f7e:	8aae                	mv	s5,a1
ffffffffc0209f80:	8432                	mv	s0,a2
ffffffffc0209f82:	84aa                	mv	s1,a0
ffffffffc0209f84:	89b6                	mv	s3,a3
ffffffffc0209f86:	04c7f563          	bgeu	a5,a2,ffffffffc0209fd0 <sfs_bmap_load_nolock+0x78>
ffffffffc0209f8a:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209f8e:	0007069b          	sext.w	a3,a4
ffffffffc0209f92:	3ff00793          	li	a5,1023
ffffffffc0209f96:	1ad7e163          	bltu	a5,a3,ffffffffc020a138 <sfs_bmap_load_nolock+0x1e0>
ffffffffc0209f9a:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209f9e:	02071793          	slli	a5,a4,0x20
ffffffffc0209fa2:	c602                	sw	zero,12(sp)
ffffffffc0209fa4:	c452                	sw	s4,8(sp)
ffffffffc0209fa6:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0209faa:	0e0a1e63          	bnez	s4,ffffffffc020a0a6 <sfs_bmap_load_nolock+0x14e>
ffffffffc0209fae:	0acb8663          	beq	s7,a2,ffffffffc020a05a <sfs_bmap_load_nolock+0x102>
ffffffffc0209fb2:	4a01                	li	s4,0
ffffffffc0209fb4:	40d4                	lw	a3,4(s1)
ffffffffc0209fb6:	8752                	mv	a4,s4
ffffffffc0209fb8:	00005617          	auipc	a2,0x5
ffffffffc0209fbc:	1d060613          	addi	a2,a2,464 # ffffffffc020f188 <dev_node_ops+0x5f0>
ffffffffc0209fc0:	05300593          	li	a1,83
ffffffffc0209fc4:	00005517          	auipc	a0,0x5
ffffffffc0209fc8:	19450513          	addi	a0,a0,404 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc0209fcc:	cd2f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209fd0:	02061793          	slli	a5,a2,0x20
ffffffffc0209fd4:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209fd8:	9a5a                	add	s4,s4,s6
ffffffffc0209fda:	00ca2583          	lw	a1,12(s4)
ffffffffc0209fde:	c22e                	sw	a1,4(sp)
ffffffffc0209fe0:	ed99                	bnez	a1,ffffffffc0209ffe <sfs_bmap_load_nolock+0xa6>
ffffffffc0209fe2:	fccb98e3          	bne	s7,a2,ffffffffc0209fb2 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209fe6:	004c                	addi	a1,sp,4
ffffffffc0209fe8:	ec9ff0ef          	jal	ra,ffffffffc0209eb0 <sfs_block_alloc>
ffffffffc0209fec:	892a                	mv	s2,a0
ffffffffc0209fee:	e921                	bnez	a0,ffffffffc020a03e <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ff0:	4592                	lw	a1,4(sp)
ffffffffc0209ff2:	4705                	li	a4,1
ffffffffc0209ff4:	00ba2623          	sw	a1,12(s4)
ffffffffc0209ff8:	00eab823          	sd	a4,16(s5)
ffffffffc0209ffc:	d9dd                	beqz	a1,ffffffffc0209fb2 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209ffe:	40d4                	lw	a3,4(s1)
ffffffffc020a000:	10d5ff63          	bgeu	a1,a3,ffffffffc020a11e <sfs_bmap_load_nolock+0x1c6>
ffffffffc020a004:	7c88                	ld	a0,56(s1)
ffffffffc020a006:	b8aff0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc020a00a:	18051363          	bnez	a0,ffffffffc020a190 <sfs_bmap_load_nolock+0x238>
ffffffffc020a00e:	4a12                	lw	s4,4(sp)
ffffffffc020a010:	fa0a02e3          	beqz	s4,ffffffffc0209fb4 <sfs_bmap_load_nolock+0x5c>
ffffffffc020a014:	40dc                	lw	a5,4(s1)
ffffffffc020a016:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209fb4 <sfs_bmap_load_nolock+0x5c>
ffffffffc020a01a:	7c88                	ld	a0,56(s1)
ffffffffc020a01c:	85d2                	mv	a1,s4
ffffffffc020a01e:	b72ff0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc020a022:	12051763          	bnez	a0,ffffffffc020a150 <sfs_bmap_load_nolock+0x1f8>
ffffffffc020a026:	008b9763          	bne	s7,s0,ffffffffc020a034 <sfs_bmap_load_nolock+0xdc>
ffffffffc020a02a:	008b2783          	lw	a5,8(s6)
ffffffffc020a02e:	2785                	addiw	a5,a5,1
ffffffffc020a030:	00fb2423          	sw	a5,8(s6)
ffffffffc020a034:	4901                	li	s2,0
ffffffffc020a036:	00098463          	beqz	s3,ffffffffc020a03e <sfs_bmap_load_nolock+0xe6>
ffffffffc020a03a:	0149a023          	sw	s4,0(s3)
ffffffffc020a03e:	70a6                	ld	ra,104(sp)
ffffffffc020a040:	7406                	ld	s0,96(sp)
ffffffffc020a042:	64e6                	ld	s1,88(sp)
ffffffffc020a044:	69a6                	ld	s3,72(sp)
ffffffffc020a046:	6a06                	ld	s4,64(sp)
ffffffffc020a048:	7ae2                	ld	s5,56(sp)
ffffffffc020a04a:	7b42                	ld	s6,48(sp)
ffffffffc020a04c:	7ba2                	ld	s7,40(sp)
ffffffffc020a04e:	7c02                	ld	s8,32(sp)
ffffffffc020a050:	6ce2                	ld	s9,24(sp)
ffffffffc020a052:	854a                	mv	a0,s2
ffffffffc020a054:	6946                	ld	s2,80(sp)
ffffffffc020a056:	6165                	addi	sp,sp,112
ffffffffc020a058:	8082                	ret
ffffffffc020a05a:	002c                	addi	a1,sp,8
ffffffffc020a05c:	e55ff0ef          	jal	ra,ffffffffc0209eb0 <sfs_block_alloc>
ffffffffc020a060:	892a                	mv	s2,a0
ffffffffc020a062:	00c10c93          	addi	s9,sp,12
ffffffffc020a066:	fd61                	bnez	a0,ffffffffc020a03e <sfs_bmap_load_nolock+0xe6>
ffffffffc020a068:	85e6                	mv	a1,s9
ffffffffc020a06a:	8526                	mv	a0,s1
ffffffffc020a06c:	e45ff0ef          	jal	ra,ffffffffc0209eb0 <sfs_block_alloc>
ffffffffc020a070:	892a                	mv	s2,a0
ffffffffc020a072:	e925                	bnez	a0,ffffffffc020a0e2 <sfs_bmap_load_nolock+0x18a>
ffffffffc020a074:	46a2                	lw	a3,8(sp)
ffffffffc020a076:	85e6                	mv	a1,s9
ffffffffc020a078:	8762                	mv	a4,s8
ffffffffc020a07a:	4611                	li	a2,4
ffffffffc020a07c:	8526                	mv	a0,s1
ffffffffc020a07e:	098010ef          	jal	ra,ffffffffc020b116 <sfs_wbuf>
ffffffffc020a082:	45b2                	lw	a1,12(sp)
ffffffffc020a084:	892a                	mv	s2,a0
ffffffffc020a086:	e939                	bnez	a0,ffffffffc020a0dc <sfs_bmap_load_nolock+0x184>
ffffffffc020a088:	03cb2683          	lw	a3,60(s6)
ffffffffc020a08c:	4722                	lw	a4,8(sp)
ffffffffc020a08e:	c22e                	sw	a1,4(sp)
ffffffffc020a090:	f6d706e3          	beq	a4,a3,ffffffffc0209ffc <sfs_bmap_load_nolock+0xa4>
ffffffffc020a094:	eef1                	bnez	a3,ffffffffc020a170 <sfs_bmap_load_nolock+0x218>
ffffffffc020a096:	02eb2e23          	sw	a4,60(s6)
ffffffffc020a09a:	4705                	li	a4,1
ffffffffc020a09c:	00eab823          	sd	a4,16(s5)
ffffffffc020a0a0:	f00589e3          	beqz	a1,ffffffffc0209fb2 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a0a4:	bfa9                	j	ffffffffc0209ffe <sfs_bmap_load_nolock+0xa6>
ffffffffc020a0a6:	00c10c93          	addi	s9,sp,12
ffffffffc020a0aa:	8762                	mv	a4,s8
ffffffffc020a0ac:	86d2                	mv	a3,s4
ffffffffc020a0ae:	4611                	li	a2,4
ffffffffc020a0b0:	85e6                	mv	a1,s9
ffffffffc020a0b2:	7e5000ef          	jal	ra,ffffffffc020b096 <sfs_rbuf>
ffffffffc020a0b6:	892a                	mv	s2,a0
ffffffffc020a0b8:	f159                	bnez	a0,ffffffffc020a03e <sfs_bmap_load_nolock+0xe6>
ffffffffc020a0ba:	45b2                	lw	a1,12(sp)
ffffffffc020a0bc:	e995                	bnez	a1,ffffffffc020a0f0 <sfs_bmap_load_nolock+0x198>
ffffffffc020a0be:	fa8b85e3          	beq	s7,s0,ffffffffc020a068 <sfs_bmap_load_nolock+0x110>
ffffffffc020a0c2:	03cb2703          	lw	a4,60(s6)
ffffffffc020a0c6:	47a2                	lw	a5,8(sp)
ffffffffc020a0c8:	c202                	sw	zero,4(sp)
ffffffffc020a0ca:	eee784e3          	beq	a5,a4,ffffffffc0209fb2 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a0ce:	e34d                	bnez	a4,ffffffffc020a170 <sfs_bmap_load_nolock+0x218>
ffffffffc020a0d0:	02fb2e23          	sw	a5,60(s6)
ffffffffc020a0d4:	4785                	li	a5,1
ffffffffc020a0d6:	00fab823          	sd	a5,16(s5)
ffffffffc020a0da:	bde1                	j	ffffffffc0209fb2 <sfs_bmap_load_nolock+0x5a>
ffffffffc020a0dc:	8526                	mv	a0,s1
ffffffffc020a0de:	bc1ff0ef          	jal	ra,ffffffffc0209c9e <sfs_block_free>
ffffffffc020a0e2:	45a2                	lw	a1,8(sp)
ffffffffc020a0e4:	f4ba0de3          	beq	s4,a1,ffffffffc020a03e <sfs_bmap_load_nolock+0xe6>
ffffffffc020a0e8:	8526                	mv	a0,s1
ffffffffc020a0ea:	bb5ff0ef          	jal	ra,ffffffffc0209c9e <sfs_block_free>
ffffffffc020a0ee:	bf81                	j	ffffffffc020a03e <sfs_bmap_load_nolock+0xe6>
ffffffffc020a0f0:	03cb2683          	lw	a3,60(s6)
ffffffffc020a0f4:	4722                	lw	a4,8(sp)
ffffffffc020a0f6:	c22e                	sw	a1,4(sp)
ffffffffc020a0f8:	f8e69ee3          	bne	a3,a4,ffffffffc020a094 <sfs_bmap_load_nolock+0x13c>
ffffffffc020a0fc:	b709                	j	ffffffffc0209ffe <sfs_bmap_load_nolock+0xa6>
ffffffffc020a0fe:	00005697          	auipc	a3,0x5
ffffffffc020a102:	14268693          	addi	a3,a3,322 # ffffffffc020f240 <dev_node_ops+0x6a8>
ffffffffc020a106:	00002617          	auipc	a2,0x2
ffffffffc020a10a:	bfa60613          	addi	a2,a2,-1030 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a10e:	16400593          	li	a1,356
ffffffffc020a112:	00005517          	auipc	a0,0x5
ffffffffc020a116:	04650513          	addi	a0,a0,70 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a11a:	b84f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a11e:	872e                	mv	a4,a1
ffffffffc020a120:	00005617          	auipc	a2,0x5
ffffffffc020a124:	06860613          	addi	a2,a2,104 # ffffffffc020f188 <dev_node_ops+0x5f0>
ffffffffc020a128:	05300593          	li	a1,83
ffffffffc020a12c:	00005517          	auipc	a0,0x5
ffffffffc020a130:	02c50513          	addi	a0,a0,44 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a134:	b6af60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a138:	00005617          	auipc	a2,0x5
ffffffffc020a13c:	13860613          	addi	a2,a2,312 # ffffffffc020f270 <dev_node_ops+0x6d8>
ffffffffc020a140:	11e00593          	li	a1,286
ffffffffc020a144:	00005517          	auipc	a0,0x5
ffffffffc020a148:	01450513          	addi	a0,a0,20 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a14c:	b52f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a150:	00005697          	auipc	a3,0x5
ffffffffc020a154:	07068693          	addi	a3,a3,112 # ffffffffc020f1c0 <dev_node_ops+0x628>
ffffffffc020a158:	00002617          	auipc	a2,0x2
ffffffffc020a15c:	ba860613          	addi	a2,a2,-1112 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a160:	16b00593          	li	a1,363
ffffffffc020a164:	00005517          	auipc	a0,0x5
ffffffffc020a168:	ff450513          	addi	a0,a0,-12 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a16c:	b32f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a170:	00005697          	auipc	a3,0x5
ffffffffc020a174:	0e868693          	addi	a3,a3,232 # ffffffffc020f258 <dev_node_ops+0x6c0>
ffffffffc020a178:	00002617          	auipc	a2,0x2
ffffffffc020a17c:	b8860613          	addi	a2,a2,-1144 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a180:	11800593          	li	a1,280
ffffffffc020a184:	00005517          	auipc	a0,0x5
ffffffffc020a188:	fd450513          	addi	a0,a0,-44 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a18c:	b12f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a190:	00005697          	auipc	a3,0x5
ffffffffc020a194:	11068693          	addi	a3,a3,272 # ffffffffc020f2a0 <dev_node_ops+0x708>
ffffffffc020a198:	00002617          	auipc	a2,0x2
ffffffffc020a19c:	b6860613          	addi	a2,a2,-1176 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a1a0:	12100593          	li	a1,289
ffffffffc020a1a4:	00005517          	auipc	a0,0x5
ffffffffc020a1a8:	fb450513          	addi	a0,a0,-76 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a1ac:	af2f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a1b0 <sfs_io_nolock>:
ffffffffc020a1b0:	7135                	addi	sp,sp,-160
ffffffffc020a1b2:	fcce                	sd	s3,120(sp)
ffffffffc020a1b4:	89ae                	mv	s3,a1
ffffffffc020a1b6:	618c                	ld	a1,0(a1)
ffffffffc020a1b8:	ed06                	sd	ra,152(sp)
ffffffffc020a1ba:	e922                	sd	s0,144(sp)
ffffffffc020a1bc:	0045d303          	lhu	t1,4(a1)
ffffffffc020a1c0:	e526                	sd	s1,136(sp)
ffffffffc020a1c2:	e14a                	sd	s2,128(sp)
ffffffffc020a1c4:	f8d2                	sd	s4,112(sp)
ffffffffc020a1c6:	f4d6                	sd	s5,104(sp)
ffffffffc020a1c8:	f0da                	sd	s6,96(sp)
ffffffffc020a1ca:	ecde                	sd	s7,88(sp)
ffffffffc020a1cc:	e8e2                	sd	s8,80(sp)
ffffffffc020a1ce:	e4e6                	sd	s9,72(sp)
ffffffffc020a1d0:	e0ea                	sd	s10,64(sp)
ffffffffc020a1d2:	fc6e                	sd	s11,56(sp)
ffffffffc020a1d4:	4889                	li	a7,2
ffffffffc020a1d6:	e43e                	sd	a5,8(sp)
ffffffffc020a1d8:	19130a63          	beq	t1,a7,ffffffffc020a36c <sfs_io_nolock+0x1bc>
ffffffffc020a1dc:	00073a83          	ld	s5,0(a4) # 4000 <_binary_bin_swap_img_size-0x3d00>
ffffffffc020a1e0:	080007b7          	lui	a5,0x8000
ffffffffc020a1e4:	00073023          	sd	zero,0(a4)
ffffffffc020a1e8:	e836                	sd	a3,16(sp)
ffffffffc020a1ea:	8db6                	mv	s11,a3
ffffffffc020a1ec:	8bba                	mv	s7,a4
ffffffffc020a1ee:	9ab6                	add	s5,s5,a3
ffffffffc020a1f0:	16f6fc63          	bgeu	a3,a5,ffffffffc020a368 <sfs_io_nolock+0x1b8>
ffffffffc020a1f4:	16daca63          	blt	s5,a3,ffffffffc020a368 <sfs_io_nolock+0x1b8>
ffffffffc020a1f8:	84aa                	mv	s1,a0
ffffffffc020a1fa:	4501                	li	a0,0
ffffffffc020a1fc:	0f568263          	beq	a3,s5,ffffffffc020a2e0 <sfs_io_nolock+0x130>
ffffffffc020a200:	8a32                	mv	s4,a2
ffffffffc020a202:	0157f463          	bgeu	a5,s5,ffffffffc020a20a <sfs_io_nolock+0x5a>
ffffffffc020a206:	08000ab7          	lui	s5,0x8000
ffffffffc020a20a:	67a2                	ld	a5,8(sp)
ffffffffc020a20c:	cbed                	beqz	a5,ffffffffc020a2fe <sfs_io_nolock+0x14e>
ffffffffc020a20e:	00001797          	auipc	a5,0x1
ffffffffc020a212:	f0878793          	addi	a5,a5,-248 # ffffffffc020b116 <sfs_wbuf>
ffffffffc020a216:	00001c17          	auipc	s8,0x1
ffffffffc020a21a:	e20c0c13          	addi	s8,s8,-480 # ffffffffc020b036 <sfs_wblock>
ffffffffc020a21e:	ec3e                	sd	a5,24(sp)
ffffffffc020a220:	6785                	lui	a5,0x1
ffffffffc020a222:	fff78b13          	addi	s6,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc020a226:	40cdd413          	srai	s0,s11,0xc
ffffffffc020a22a:	016dfb33          	and	s6,s11,s6
ffffffffc020a22e:	2401                	sext.w	s0,s0
ffffffffc020a230:	895a                	mv	s2,s6
ffffffffc020a232:	020b0d63          	beqz	s6,ffffffffc020a26c <sfs_io_nolock+0xbc>
ffffffffc020a236:	40cad713          	srai	a4,s5,0xc
ffffffffc020a23a:	2701                	sext.w	a4,a4
ffffffffc020a23c:	41ba8933          	sub	s2,s5,s11
ffffffffc020a240:	00870463          	beq	a4,s0,ffffffffc020a248 <sfs_io_nolock+0x98>
ffffffffc020a244:	41678933          	sub	s2,a5,s6
ffffffffc020a248:	1074                	addi	a3,sp,44
ffffffffc020a24a:	8622                	mv	a2,s0
ffffffffc020a24c:	85ce                	mv	a1,s3
ffffffffc020a24e:	8526                	mv	a0,s1
ffffffffc020a250:	d09ff0ef          	jal	ra,ffffffffc0209f58 <sfs_bmap_load_nolock>
ffffffffc020a254:	e16d                	bnez	a0,ffffffffc020a336 <sfs_io_nolock+0x186>
ffffffffc020a256:	56b2                	lw	a3,44(sp)
ffffffffc020a258:	67e2                	ld	a5,24(sp)
ffffffffc020a25a:	875a                	mv	a4,s6
ffffffffc020a25c:	864a                	mv	a2,s2
ffffffffc020a25e:	85d2                	mv	a1,s4
ffffffffc020a260:	8526                	mv	a0,s1
ffffffffc020a262:	9782                	jalr	a5
ffffffffc020a264:	e969                	bnez	a0,ffffffffc020a336 <sfs_io_nolock+0x186>
ffffffffc020a266:	9a4a                	add	s4,s4,s2
ffffffffc020a268:	9dca                	add	s11,s11,s2
ffffffffc020a26a:	2405                	addiw	s0,s0,1
ffffffffc020a26c:	6785                	lui	a5,0x1
ffffffffc020a26e:	fff78713          	addi	a4,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc020a272:	976e                	add	a4,a4,s11
ffffffffc020a274:	0d575463          	bge	a4,s5,ffffffffc020a33c <sfs_io_nolock+0x18c>
ffffffffc020a278:	40fa8733          	sub	a4,s5,a5
ffffffffc020a27c:	41b70733          	sub	a4,a4,s11
ffffffffc020a280:	8331                	srli	a4,a4,0xc
ffffffffc020a282:	0705                	addi	a4,a4,1
ffffffffc020a284:	8d52                	mv	s10,s4
ffffffffc020a286:	0732                	slli	a4,a4,0xc
ffffffffc020a288:	9a3a                	add	s4,s4,a4
ffffffffc020a28a:	6b05                	lui	s6,0x1
ffffffffc020a28c:	41ad8cb3          	sub	s9,s11,s10
ffffffffc020a290:	a831                	j	ffffffffc020a2ac <sfs_io_nolock+0xfc>
ffffffffc020a292:	5632                	lw	a2,44(sp)
ffffffffc020a294:	4685                	li	a3,1
ffffffffc020a296:	85ea                	mv	a1,s10
ffffffffc020a298:	8526                	mv	a0,s1
ffffffffc020a29a:	9c02                	jalr	s8
ffffffffc020a29c:	ed19                	bnez	a0,ffffffffc020a2ba <sfs_io_nolock+0x10a>
ffffffffc020a29e:	9d5a                	add	s10,s10,s6
ffffffffc020a2a0:	019d0db3          	add	s11,s10,s9
ffffffffc020a2a4:	995a                	add	s2,s2,s6
ffffffffc020a2a6:	2405                	addiw	s0,s0,1
ffffffffc020a2a8:	094d0a63          	beq	s10,s4,ffffffffc020a33c <sfs_io_nolock+0x18c>
ffffffffc020a2ac:	1074                	addi	a3,sp,44
ffffffffc020a2ae:	8622                	mv	a2,s0
ffffffffc020a2b0:	85ce                	mv	a1,s3
ffffffffc020a2b2:	8526                	mv	a0,s1
ffffffffc020a2b4:	ca5ff0ef          	jal	ra,ffffffffc0209f58 <sfs_bmap_load_nolock>
ffffffffc020a2b8:	dd69                	beqz	a0,ffffffffc020a292 <sfs_io_nolock+0xe2>
ffffffffc020a2ba:	67a2                	ld	a5,8(sp)
ffffffffc020a2bc:	012bb023          	sd	s2,0(s7) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020a2c0:	c385                	beqz	a5,ffffffffc020a2e0 <sfs_io_nolock+0x130>
ffffffffc020a2c2:	00090f63          	beqz	s2,ffffffffc020a2e0 <sfs_io_nolock+0x130>
ffffffffc020a2c6:	6742                	ld	a4,16(sp)
ffffffffc020a2c8:	0009b783          	ld	a5,0(s3)
ffffffffc020a2cc:	993a                	add	s2,s2,a4
ffffffffc020a2ce:	0007e703          	lwu	a4,0(a5)
ffffffffc020a2d2:	01275763          	bge	a4,s2,ffffffffc020a2e0 <sfs_io_nolock+0x130>
ffffffffc020a2d6:	0127a023          	sw	s2,0(a5)
ffffffffc020a2da:	4785                	li	a5,1
ffffffffc020a2dc:	00f9b823          	sd	a5,16(s3)
ffffffffc020a2e0:	60ea                	ld	ra,152(sp)
ffffffffc020a2e2:	644a                	ld	s0,144(sp)
ffffffffc020a2e4:	64aa                	ld	s1,136(sp)
ffffffffc020a2e6:	690a                	ld	s2,128(sp)
ffffffffc020a2e8:	79e6                	ld	s3,120(sp)
ffffffffc020a2ea:	7a46                	ld	s4,112(sp)
ffffffffc020a2ec:	7aa6                	ld	s5,104(sp)
ffffffffc020a2ee:	7b06                	ld	s6,96(sp)
ffffffffc020a2f0:	6be6                	ld	s7,88(sp)
ffffffffc020a2f2:	6c46                	ld	s8,80(sp)
ffffffffc020a2f4:	6ca6                	ld	s9,72(sp)
ffffffffc020a2f6:	6d06                	ld	s10,64(sp)
ffffffffc020a2f8:	7de2                	ld	s11,56(sp)
ffffffffc020a2fa:	610d                	addi	sp,sp,160
ffffffffc020a2fc:	8082                	ret
ffffffffc020a2fe:	0005e783          	lwu	a5,0(a1)
ffffffffc020a302:	4501                	li	a0,0
ffffffffc020a304:	fcfddee3          	bge	s11,a5,ffffffffc020a2e0 <sfs_io_nolock+0x130>
ffffffffc020a308:	0157cc63          	blt	a5,s5,ffffffffc020a320 <sfs_io_nolock+0x170>
ffffffffc020a30c:	00001797          	auipc	a5,0x1
ffffffffc020a310:	d8a78793          	addi	a5,a5,-630 # ffffffffc020b096 <sfs_rbuf>
ffffffffc020a314:	00001c17          	auipc	s8,0x1
ffffffffc020a318:	cc2c0c13          	addi	s8,s8,-830 # ffffffffc020afd6 <sfs_rblock>
ffffffffc020a31c:	ec3e                	sd	a5,24(sp)
ffffffffc020a31e:	b709                	j	ffffffffc020a220 <sfs_io_nolock+0x70>
ffffffffc020a320:	8abe                	mv	s5,a5
ffffffffc020a322:	00001797          	auipc	a5,0x1
ffffffffc020a326:	d7478793          	addi	a5,a5,-652 # ffffffffc020b096 <sfs_rbuf>
ffffffffc020a32a:	00001c17          	auipc	s8,0x1
ffffffffc020a32e:	cacc0c13          	addi	s8,s8,-852 # ffffffffc020afd6 <sfs_rblock>
ffffffffc020a332:	ec3e                	sd	a5,24(sp)
ffffffffc020a334:	b5f5                	j	ffffffffc020a220 <sfs_io_nolock+0x70>
ffffffffc020a336:	000bb023          	sd	zero,0(s7)
ffffffffc020a33a:	b75d                	j	ffffffffc020a2e0 <sfs_io_nolock+0x130>
ffffffffc020a33c:	4501                	li	a0,0
ffffffffc020a33e:	f75ddee3          	bge	s11,s5,ffffffffc020a2ba <sfs_io_nolock+0x10a>
ffffffffc020a342:	1074                	addi	a3,sp,44
ffffffffc020a344:	8622                	mv	a2,s0
ffffffffc020a346:	85ce                	mv	a1,s3
ffffffffc020a348:	8526                	mv	a0,s1
ffffffffc020a34a:	c0fff0ef          	jal	ra,ffffffffc0209f58 <sfs_bmap_load_nolock>
ffffffffc020a34e:	f535                	bnez	a0,ffffffffc020a2ba <sfs_io_nolock+0x10a>
ffffffffc020a350:	56b2                	lw	a3,44(sp)
ffffffffc020a352:	67e2                	ld	a5,24(sp)
ffffffffc020a354:	41ba8ab3          	sub	s5,s5,s11
ffffffffc020a358:	4701                	li	a4,0
ffffffffc020a35a:	8656                	mv	a2,s5
ffffffffc020a35c:	85d2                	mv	a1,s4
ffffffffc020a35e:	8526                	mv	a0,s1
ffffffffc020a360:	9782                	jalr	a5
ffffffffc020a362:	fd21                	bnez	a0,ffffffffc020a2ba <sfs_io_nolock+0x10a>
ffffffffc020a364:	9956                	add	s2,s2,s5
ffffffffc020a366:	bf91                	j	ffffffffc020a2ba <sfs_io_nolock+0x10a>
ffffffffc020a368:	5575                	li	a0,-3
ffffffffc020a36a:	bf9d                	j	ffffffffc020a2e0 <sfs_io_nolock+0x130>
ffffffffc020a36c:	00005697          	auipc	a3,0x5
ffffffffc020a370:	f5c68693          	addi	a3,a3,-164 # ffffffffc020f2c8 <dev_node_ops+0x730>
ffffffffc020a374:	00002617          	auipc	a2,0x2
ffffffffc020a378:	98c60613          	addi	a2,a2,-1652 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a37c:	22b00593          	li	a1,555
ffffffffc020a380:	00005517          	auipc	a0,0x5
ffffffffc020a384:	dd850513          	addi	a0,a0,-552 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a388:	916f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a38c <sfs_read>:
ffffffffc020a38c:	7139                	addi	sp,sp,-64
ffffffffc020a38e:	f04a                	sd	s2,32(sp)
ffffffffc020a390:	06853903          	ld	s2,104(a0)
ffffffffc020a394:	fc06                	sd	ra,56(sp)
ffffffffc020a396:	f822                	sd	s0,48(sp)
ffffffffc020a398:	f426                	sd	s1,40(sp)
ffffffffc020a39a:	ec4e                	sd	s3,24(sp)
ffffffffc020a39c:	04090f63          	beqz	s2,ffffffffc020a3fa <sfs_read+0x6e>
ffffffffc020a3a0:	0b092783          	lw	a5,176(s2)
ffffffffc020a3a4:	ebb9                	bnez	a5,ffffffffc020a3fa <sfs_read+0x6e>
ffffffffc020a3a6:	4d38                	lw	a4,88(a0)
ffffffffc020a3a8:	6785                	lui	a5,0x1
ffffffffc020a3aa:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a3ae:	842a                	mv	s0,a0
ffffffffc020a3b0:	06f71563          	bne	a4,a5,ffffffffc020a41a <sfs_read+0x8e>
ffffffffc020a3b4:	02050993          	addi	s3,a0,32
ffffffffc020a3b8:	854e                	mv	a0,s3
ffffffffc020a3ba:	84ae                	mv	s1,a1
ffffffffc020a3bc:	a40fa0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a3c0:	0184b803          	ld	a6,24(s1)
ffffffffc020a3c4:	6494                	ld	a3,8(s1)
ffffffffc020a3c6:	6090                	ld	a2,0(s1)
ffffffffc020a3c8:	85a2                	mv	a1,s0
ffffffffc020a3ca:	4781                	li	a5,0
ffffffffc020a3cc:	0038                	addi	a4,sp,8
ffffffffc020a3ce:	854a                	mv	a0,s2
ffffffffc020a3d0:	e442                	sd	a6,8(sp)
ffffffffc020a3d2:	ddfff0ef          	jal	ra,ffffffffc020a1b0 <sfs_io_nolock>
ffffffffc020a3d6:	65a2                	ld	a1,8(sp)
ffffffffc020a3d8:	842a                	mv	s0,a0
ffffffffc020a3da:	ed81                	bnez	a1,ffffffffc020a3f2 <sfs_read+0x66>
ffffffffc020a3dc:	854e                	mv	a0,s3
ffffffffc020a3de:	a1afa0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a3e2:	70e2                	ld	ra,56(sp)
ffffffffc020a3e4:	8522                	mv	a0,s0
ffffffffc020a3e6:	7442                	ld	s0,48(sp)
ffffffffc020a3e8:	74a2                	ld	s1,40(sp)
ffffffffc020a3ea:	7902                	ld	s2,32(sp)
ffffffffc020a3ec:	69e2                	ld	s3,24(sp)
ffffffffc020a3ee:	6121                	addi	sp,sp,64
ffffffffc020a3f0:	8082                	ret
ffffffffc020a3f2:	8526                	mv	a0,s1
ffffffffc020a3f4:	8fcfb0ef          	jal	ra,ffffffffc02054f0 <iobuf_skip>
ffffffffc020a3f8:	b7d5                	j	ffffffffc020a3dc <sfs_read+0x50>
ffffffffc020a3fa:	00005697          	auipc	a3,0x5
ffffffffc020a3fe:	b7e68693          	addi	a3,a3,-1154 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc020a402:	00002617          	auipc	a2,0x2
ffffffffc020a406:	8fe60613          	addi	a2,a2,-1794 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a40a:	2a000593          	li	a1,672
ffffffffc020a40e:	00005517          	auipc	a0,0x5
ffffffffc020a412:	d4a50513          	addi	a0,a0,-694 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a416:	888f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a41a:	861ff0ef          	jal	ra,ffffffffc0209c7a <sfs_io.part.0>

ffffffffc020a41e <sfs_write>:
ffffffffc020a41e:	7139                	addi	sp,sp,-64
ffffffffc020a420:	f04a                	sd	s2,32(sp)
ffffffffc020a422:	06853903          	ld	s2,104(a0)
ffffffffc020a426:	fc06                	sd	ra,56(sp)
ffffffffc020a428:	f822                	sd	s0,48(sp)
ffffffffc020a42a:	f426                	sd	s1,40(sp)
ffffffffc020a42c:	ec4e                	sd	s3,24(sp)
ffffffffc020a42e:	04090f63          	beqz	s2,ffffffffc020a48c <sfs_write+0x6e>
ffffffffc020a432:	0b092783          	lw	a5,176(s2)
ffffffffc020a436:	ebb9                	bnez	a5,ffffffffc020a48c <sfs_write+0x6e>
ffffffffc020a438:	4d38                	lw	a4,88(a0)
ffffffffc020a43a:	6785                	lui	a5,0x1
ffffffffc020a43c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a440:	842a                	mv	s0,a0
ffffffffc020a442:	06f71563          	bne	a4,a5,ffffffffc020a4ac <sfs_write+0x8e>
ffffffffc020a446:	02050993          	addi	s3,a0,32
ffffffffc020a44a:	854e                	mv	a0,s3
ffffffffc020a44c:	84ae                	mv	s1,a1
ffffffffc020a44e:	9aefa0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a452:	0184b803          	ld	a6,24(s1)
ffffffffc020a456:	6494                	ld	a3,8(s1)
ffffffffc020a458:	6090                	ld	a2,0(s1)
ffffffffc020a45a:	85a2                	mv	a1,s0
ffffffffc020a45c:	4785                	li	a5,1
ffffffffc020a45e:	0038                	addi	a4,sp,8
ffffffffc020a460:	854a                	mv	a0,s2
ffffffffc020a462:	e442                	sd	a6,8(sp)
ffffffffc020a464:	d4dff0ef          	jal	ra,ffffffffc020a1b0 <sfs_io_nolock>
ffffffffc020a468:	65a2                	ld	a1,8(sp)
ffffffffc020a46a:	842a                	mv	s0,a0
ffffffffc020a46c:	ed81                	bnez	a1,ffffffffc020a484 <sfs_write+0x66>
ffffffffc020a46e:	854e                	mv	a0,s3
ffffffffc020a470:	988fa0ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a474:	70e2                	ld	ra,56(sp)
ffffffffc020a476:	8522                	mv	a0,s0
ffffffffc020a478:	7442                	ld	s0,48(sp)
ffffffffc020a47a:	74a2                	ld	s1,40(sp)
ffffffffc020a47c:	7902                	ld	s2,32(sp)
ffffffffc020a47e:	69e2                	ld	s3,24(sp)
ffffffffc020a480:	6121                	addi	sp,sp,64
ffffffffc020a482:	8082                	ret
ffffffffc020a484:	8526                	mv	a0,s1
ffffffffc020a486:	86afb0ef          	jal	ra,ffffffffc02054f0 <iobuf_skip>
ffffffffc020a48a:	b7d5                	j	ffffffffc020a46e <sfs_write+0x50>
ffffffffc020a48c:	00005697          	auipc	a3,0x5
ffffffffc020a490:	aec68693          	addi	a3,a3,-1300 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc020a494:	00002617          	auipc	a2,0x2
ffffffffc020a498:	86c60613          	addi	a2,a2,-1940 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a49c:	2a000593          	li	a1,672
ffffffffc020a4a0:	00005517          	auipc	a0,0x5
ffffffffc020a4a4:	cb850513          	addi	a0,a0,-840 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a4a8:	ff7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a4ac:	fceff0ef          	jal	ra,ffffffffc0209c7a <sfs_io.part.0>

ffffffffc020a4b0 <sfs_dirent_read_nolock>:
ffffffffc020a4b0:	6198                	ld	a4,0(a1)
ffffffffc020a4b2:	7179                	addi	sp,sp,-48
ffffffffc020a4b4:	f406                	sd	ra,40(sp)
ffffffffc020a4b6:	00475883          	lhu	a7,4(a4)
ffffffffc020a4ba:	f022                	sd	s0,32(sp)
ffffffffc020a4bc:	ec26                	sd	s1,24(sp)
ffffffffc020a4be:	4809                	li	a6,2
ffffffffc020a4c0:	05089b63          	bne	a7,a6,ffffffffc020a516 <sfs_dirent_read_nolock+0x66>
ffffffffc020a4c4:	4718                	lw	a4,8(a4)
ffffffffc020a4c6:	87b2                	mv	a5,a2
ffffffffc020a4c8:	2601                	sext.w	a2,a2
ffffffffc020a4ca:	04e7f663          	bgeu	a5,a4,ffffffffc020a516 <sfs_dirent_read_nolock+0x66>
ffffffffc020a4ce:	84b6                	mv	s1,a3
ffffffffc020a4d0:	0074                	addi	a3,sp,12
ffffffffc020a4d2:	842a                	mv	s0,a0
ffffffffc020a4d4:	a85ff0ef          	jal	ra,ffffffffc0209f58 <sfs_bmap_load_nolock>
ffffffffc020a4d8:	c511                	beqz	a0,ffffffffc020a4e4 <sfs_dirent_read_nolock+0x34>
ffffffffc020a4da:	70a2                	ld	ra,40(sp)
ffffffffc020a4dc:	7402                	ld	s0,32(sp)
ffffffffc020a4de:	64e2                	ld	s1,24(sp)
ffffffffc020a4e0:	6145                	addi	sp,sp,48
ffffffffc020a4e2:	8082                	ret
ffffffffc020a4e4:	45b2                	lw	a1,12(sp)
ffffffffc020a4e6:	4054                	lw	a3,4(s0)
ffffffffc020a4e8:	c5b9                	beqz	a1,ffffffffc020a536 <sfs_dirent_read_nolock+0x86>
ffffffffc020a4ea:	04d5f663          	bgeu	a1,a3,ffffffffc020a536 <sfs_dirent_read_nolock+0x86>
ffffffffc020a4ee:	7c08                	ld	a0,56(s0)
ffffffffc020a4f0:	ea1fe0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc020a4f4:	ed31                	bnez	a0,ffffffffc020a550 <sfs_dirent_read_nolock+0xa0>
ffffffffc020a4f6:	46b2                	lw	a3,12(sp)
ffffffffc020a4f8:	4701                	li	a4,0
ffffffffc020a4fa:	10400613          	li	a2,260
ffffffffc020a4fe:	85a6                	mv	a1,s1
ffffffffc020a500:	8522                	mv	a0,s0
ffffffffc020a502:	395000ef          	jal	ra,ffffffffc020b096 <sfs_rbuf>
ffffffffc020a506:	f971                	bnez	a0,ffffffffc020a4da <sfs_dirent_read_nolock+0x2a>
ffffffffc020a508:	100481a3          	sb	zero,259(s1)
ffffffffc020a50c:	70a2                	ld	ra,40(sp)
ffffffffc020a50e:	7402                	ld	s0,32(sp)
ffffffffc020a510:	64e2                	ld	s1,24(sp)
ffffffffc020a512:	6145                	addi	sp,sp,48
ffffffffc020a514:	8082                	ret
ffffffffc020a516:	00005697          	auipc	a3,0x5
ffffffffc020a51a:	dd268693          	addi	a3,a3,-558 # ffffffffc020f2e8 <dev_node_ops+0x750>
ffffffffc020a51e:	00001617          	auipc	a2,0x1
ffffffffc020a522:	7e260613          	addi	a2,a2,2018 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a526:	18e00593          	li	a1,398
ffffffffc020a52a:	00005517          	auipc	a0,0x5
ffffffffc020a52e:	c2e50513          	addi	a0,a0,-978 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a532:	f6df50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a536:	872e                	mv	a4,a1
ffffffffc020a538:	00005617          	auipc	a2,0x5
ffffffffc020a53c:	c5060613          	addi	a2,a2,-944 # ffffffffc020f188 <dev_node_ops+0x5f0>
ffffffffc020a540:	05300593          	li	a1,83
ffffffffc020a544:	00005517          	auipc	a0,0x5
ffffffffc020a548:	c1450513          	addi	a0,a0,-1004 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a54c:	f53f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a550:	00005697          	auipc	a3,0x5
ffffffffc020a554:	c7068693          	addi	a3,a3,-912 # ffffffffc020f1c0 <dev_node_ops+0x628>
ffffffffc020a558:	00001617          	auipc	a2,0x1
ffffffffc020a55c:	7a860613          	addi	a2,a2,1960 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a560:	19500593          	li	a1,405
ffffffffc020a564:	00005517          	auipc	a0,0x5
ffffffffc020a568:	bf450513          	addi	a0,a0,-1036 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a56c:	f33f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a570 <sfs_getdirentry>:
ffffffffc020a570:	715d                	addi	sp,sp,-80
ffffffffc020a572:	ec56                	sd	s5,24(sp)
ffffffffc020a574:	8aaa                	mv	s5,a0
ffffffffc020a576:	10400513          	li	a0,260
ffffffffc020a57a:	e85a                	sd	s6,16(sp)
ffffffffc020a57c:	e486                	sd	ra,72(sp)
ffffffffc020a57e:	e0a2                	sd	s0,64(sp)
ffffffffc020a580:	fc26                	sd	s1,56(sp)
ffffffffc020a582:	f84a                	sd	s2,48(sp)
ffffffffc020a584:	f44e                	sd	s3,40(sp)
ffffffffc020a586:	f052                	sd	s4,32(sp)
ffffffffc020a588:	e45e                	sd	s7,8(sp)
ffffffffc020a58a:	e062                	sd	s8,0(sp)
ffffffffc020a58c:	8b2e                	mv	s6,a1
ffffffffc020a58e:	a95f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020a592:	cd61                	beqz	a0,ffffffffc020a66a <sfs_getdirentry+0xfa>
ffffffffc020a594:	068abb83          	ld	s7,104(s5) # 8000068 <_binary_bin_sfs_img_size+0x7f8ad68>
ffffffffc020a598:	0c0b8b63          	beqz	s7,ffffffffc020a66e <sfs_getdirentry+0xfe>
ffffffffc020a59c:	0b0ba783          	lw	a5,176(s7)
ffffffffc020a5a0:	e7f9                	bnez	a5,ffffffffc020a66e <sfs_getdirentry+0xfe>
ffffffffc020a5a2:	058aa703          	lw	a4,88(s5)
ffffffffc020a5a6:	6785                	lui	a5,0x1
ffffffffc020a5a8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a5ac:	0ef71163          	bne	a4,a5,ffffffffc020a68e <sfs_getdirentry+0x11e>
ffffffffc020a5b0:	008b3983          	ld	s3,8(s6) # 1008 <_binary_bin_swap_img_size-0x6cf8>
ffffffffc020a5b4:	892a                	mv	s2,a0
ffffffffc020a5b6:	0a09c163          	bltz	s3,ffffffffc020a658 <sfs_getdirentry+0xe8>
ffffffffc020a5ba:	0ff9f793          	zext.b	a5,s3
ffffffffc020a5be:	efc9                	bnez	a5,ffffffffc020a658 <sfs_getdirentry+0xe8>
ffffffffc020a5c0:	000ab783          	ld	a5,0(s5)
ffffffffc020a5c4:	0089d993          	srli	s3,s3,0x8
ffffffffc020a5c8:	2981                	sext.w	s3,s3
ffffffffc020a5ca:	479c                	lw	a5,8(a5)
ffffffffc020a5cc:	0937eb63          	bltu	a5,s3,ffffffffc020a662 <sfs_getdirentry+0xf2>
ffffffffc020a5d0:	020a8c13          	addi	s8,s5,32
ffffffffc020a5d4:	8562                	mv	a0,s8
ffffffffc020a5d6:	826fa0ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a5da:	000ab783          	ld	a5,0(s5)
ffffffffc020a5de:	0087aa03          	lw	s4,8(a5)
ffffffffc020a5e2:	07405663          	blez	s4,ffffffffc020a64e <sfs_getdirentry+0xde>
ffffffffc020a5e6:	4481                	li	s1,0
ffffffffc020a5e8:	a811                	j	ffffffffc020a5fc <sfs_getdirentry+0x8c>
ffffffffc020a5ea:	00092783          	lw	a5,0(s2)
ffffffffc020a5ee:	c781                	beqz	a5,ffffffffc020a5f6 <sfs_getdirentry+0x86>
ffffffffc020a5f0:	02098263          	beqz	s3,ffffffffc020a614 <sfs_getdirentry+0xa4>
ffffffffc020a5f4:	39fd                	addiw	s3,s3,-1
ffffffffc020a5f6:	2485                	addiw	s1,s1,1
ffffffffc020a5f8:	049a0b63          	beq	s4,s1,ffffffffc020a64e <sfs_getdirentry+0xde>
ffffffffc020a5fc:	86ca                	mv	a3,s2
ffffffffc020a5fe:	8626                	mv	a2,s1
ffffffffc020a600:	85d6                	mv	a1,s5
ffffffffc020a602:	855e                	mv	a0,s7
ffffffffc020a604:	eadff0ef          	jal	ra,ffffffffc020a4b0 <sfs_dirent_read_nolock>
ffffffffc020a608:	842a                	mv	s0,a0
ffffffffc020a60a:	d165                	beqz	a0,ffffffffc020a5ea <sfs_getdirentry+0x7a>
ffffffffc020a60c:	8562                	mv	a0,s8
ffffffffc020a60e:	febf90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a612:	a831                	j	ffffffffc020a62e <sfs_getdirentry+0xbe>
ffffffffc020a614:	8562                	mv	a0,s8
ffffffffc020a616:	fe3f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a61a:	4701                	li	a4,0
ffffffffc020a61c:	4685                	li	a3,1
ffffffffc020a61e:	10000613          	li	a2,256
ffffffffc020a622:	00490593          	addi	a1,s2,4
ffffffffc020a626:	855a                	mv	a0,s6
ffffffffc020a628:	e5dfa0ef          	jal	ra,ffffffffc0205484 <iobuf_move>
ffffffffc020a62c:	842a                	mv	s0,a0
ffffffffc020a62e:	854a                	mv	a0,s2
ffffffffc020a630:	aa3f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a634:	60a6                	ld	ra,72(sp)
ffffffffc020a636:	8522                	mv	a0,s0
ffffffffc020a638:	6406                	ld	s0,64(sp)
ffffffffc020a63a:	74e2                	ld	s1,56(sp)
ffffffffc020a63c:	7942                	ld	s2,48(sp)
ffffffffc020a63e:	79a2                	ld	s3,40(sp)
ffffffffc020a640:	7a02                	ld	s4,32(sp)
ffffffffc020a642:	6ae2                	ld	s5,24(sp)
ffffffffc020a644:	6b42                	ld	s6,16(sp)
ffffffffc020a646:	6ba2                	ld	s7,8(sp)
ffffffffc020a648:	6c02                	ld	s8,0(sp)
ffffffffc020a64a:	6161                	addi	sp,sp,80
ffffffffc020a64c:	8082                	ret
ffffffffc020a64e:	8562                	mv	a0,s8
ffffffffc020a650:	5441                	li	s0,-16
ffffffffc020a652:	fa7f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a656:	bfe1                	j	ffffffffc020a62e <sfs_getdirentry+0xbe>
ffffffffc020a658:	854a                	mv	a0,s2
ffffffffc020a65a:	a79f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a65e:	5475                	li	s0,-3
ffffffffc020a660:	bfd1                	j	ffffffffc020a634 <sfs_getdirentry+0xc4>
ffffffffc020a662:	a71f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a666:	5441                	li	s0,-16
ffffffffc020a668:	b7f1                	j	ffffffffc020a634 <sfs_getdirentry+0xc4>
ffffffffc020a66a:	5471                	li	s0,-4
ffffffffc020a66c:	b7e1                	j	ffffffffc020a634 <sfs_getdirentry+0xc4>
ffffffffc020a66e:	00005697          	auipc	a3,0x5
ffffffffc020a672:	90a68693          	addi	a3,a3,-1782 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc020a676:	00001617          	auipc	a2,0x1
ffffffffc020a67a:	68a60613          	addi	a2,a2,1674 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a67e:	34400593          	li	a1,836
ffffffffc020a682:	00005517          	auipc	a0,0x5
ffffffffc020a686:	ad650513          	addi	a0,a0,-1322 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a68a:	e15f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a68e:	00005697          	auipc	a3,0x5
ffffffffc020a692:	a9268693          	addi	a3,a3,-1390 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc020a696:	00001617          	auipc	a2,0x1
ffffffffc020a69a:	66a60613          	addi	a2,a2,1642 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a69e:	34500593          	li	a1,837
ffffffffc020a6a2:	00005517          	auipc	a0,0x5
ffffffffc020a6a6:	ab650513          	addi	a0,a0,-1354 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a6aa:	df5f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a6ae <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a6ae:	715d                	addi	sp,sp,-80
ffffffffc020a6b0:	f052                	sd	s4,32(sp)
ffffffffc020a6b2:	8a2a                	mv	s4,a0
ffffffffc020a6b4:	8532                	mv	a0,a2
ffffffffc020a6b6:	f44e                	sd	s3,40(sp)
ffffffffc020a6b8:	e85a                	sd	s6,16(sp)
ffffffffc020a6ba:	e45e                	sd	s7,8(sp)
ffffffffc020a6bc:	e486                	sd	ra,72(sp)
ffffffffc020a6be:	e0a2                	sd	s0,64(sp)
ffffffffc020a6c0:	fc26                	sd	s1,56(sp)
ffffffffc020a6c2:	f84a                	sd	s2,48(sp)
ffffffffc020a6c4:	ec56                	sd	s5,24(sp)
ffffffffc020a6c6:	e062                	sd	s8,0(sp)
ffffffffc020a6c8:	8b32                	mv	s6,a2
ffffffffc020a6ca:	89ae                	mv	s3,a1
ffffffffc020a6cc:	8bb6                	mv	s7,a3
ffffffffc020a6ce:	0aa010ef          	jal	ra,ffffffffc020b778 <strlen>
ffffffffc020a6d2:	0ff00793          	li	a5,255
ffffffffc020a6d6:	06a7ef63          	bltu	a5,a0,ffffffffc020a754 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a6da:	10400513          	li	a0,260
ffffffffc020a6de:	945f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020a6e2:	892a                	mv	s2,a0
ffffffffc020a6e4:	c535                	beqz	a0,ffffffffc020a750 <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a6e6:	0009b783          	ld	a5,0(s3)
ffffffffc020a6ea:	0087aa83          	lw	s5,8(a5)
ffffffffc020a6ee:	05505a63          	blez	s5,ffffffffc020a742 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a6f2:	4481                	li	s1,0
ffffffffc020a6f4:	00450c13          	addi	s8,a0,4
ffffffffc020a6f8:	a829                	j	ffffffffc020a712 <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a6fa:	00092783          	lw	a5,0(s2)
ffffffffc020a6fe:	c799                	beqz	a5,ffffffffc020a70c <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a700:	85e2                	mv	a1,s8
ffffffffc020a702:	855a                	mv	a0,s6
ffffffffc020a704:	0bc010ef          	jal	ra,ffffffffc020b7c0 <strcmp>
ffffffffc020a708:	842a                	mv	s0,a0
ffffffffc020a70a:	cd15                	beqz	a0,ffffffffc020a746 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a70c:	2485                	addiw	s1,s1,1
ffffffffc020a70e:	029a8a63          	beq	s5,s1,ffffffffc020a742 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a712:	86ca                	mv	a3,s2
ffffffffc020a714:	8626                	mv	a2,s1
ffffffffc020a716:	85ce                	mv	a1,s3
ffffffffc020a718:	8552                	mv	a0,s4
ffffffffc020a71a:	d97ff0ef          	jal	ra,ffffffffc020a4b0 <sfs_dirent_read_nolock>
ffffffffc020a71e:	842a                	mv	s0,a0
ffffffffc020a720:	dd69                	beqz	a0,ffffffffc020a6fa <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a722:	854a                	mv	a0,s2
ffffffffc020a724:	9aff70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020a728:	60a6                	ld	ra,72(sp)
ffffffffc020a72a:	8522                	mv	a0,s0
ffffffffc020a72c:	6406                	ld	s0,64(sp)
ffffffffc020a72e:	74e2                	ld	s1,56(sp)
ffffffffc020a730:	7942                	ld	s2,48(sp)
ffffffffc020a732:	79a2                	ld	s3,40(sp)
ffffffffc020a734:	7a02                	ld	s4,32(sp)
ffffffffc020a736:	6ae2                	ld	s5,24(sp)
ffffffffc020a738:	6b42                	ld	s6,16(sp)
ffffffffc020a73a:	6ba2                	ld	s7,8(sp)
ffffffffc020a73c:	6c02                	ld	s8,0(sp)
ffffffffc020a73e:	6161                	addi	sp,sp,80
ffffffffc020a740:	8082                	ret
ffffffffc020a742:	5441                	li	s0,-16
ffffffffc020a744:	bff9                	j	ffffffffc020a722 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a746:	00092783          	lw	a5,0(s2)
ffffffffc020a74a:	00fba023          	sw	a5,0(s7)
ffffffffc020a74e:	bfd1                	j	ffffffffc020a722 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a750:	5471                	li	s0,-4
ffffffffc020a752:	bfd9                	j	ffffffffc020a728 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a754:	00005697          	auipc	a3,0x5
ffffffffc020a758:	be468693          	addi	a3,a3,-1052 # ffffffffc020f338 <dev_node_ops+0x7a0>
ffffffffc020a75c:	00001617          	auipc	a2,0x1
ffffffffc020a760:	5a460613          	addi	a2,a2,1444 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a764:	1ba00593          	li	a1,442
ffffffffc020a768:	00005517          	auipc	a0,0x5
ffffffffc020a76c:	9f050513          	addi	a0,a0,-1552 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a770:	d2ff50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a774 <sfs_truncfile>:
ffffffffc020a774:	7175                	addi	sp,sp,-144
ffffffffc020a776:	e506                	sd	ra,136(sp)
ffffffffc020a778:	e122                	sd	s0,128(sp)
ffffffffc020a77a:	fca6                	sd	s1,120(sp)
ffffffffc020a77c:	f8ca                	sd	s2,112(sp)
ffffffffc020a77e:	f4ce                	sd	s3,104(sp)
ffffffffc020a780:	f0d2                	sd	s4,96(sp)
ffffffffc020a782:	ecd6                	sd	s5,88(sp)
ffffffffc020a784:	e8da                	sd	s6,80(sp)
ffffffffc020a786:	e4de                	sd	s7,72(sp)
ffffffffc020a788:	e0e2                	sd	s8,64(sp)
ffffffffc020a78a:	fc66                	sd	s9,56(sp)
ffffffffc020a78c:	f86a                	sd	s10,48(sp)
ffffffffc020a78e:	f46e                	sd	s11,40(sp)
ffffffffc020a790:	080007b7          	lui	a5,0x8000
ffffffffc020a794:	16b7e463          	bltu	a5,a1,ffffffffc020a8fc <sfs_truncfile+0x188>
ffffffffc020a798:	06853c83          	ld	s9,104(a0)
ffffffffc020a79c:	89aa                	mv	s3,a0
ffffffffc020a79e:	160c8163          	beqz	s9,ffffffffc020a900 <sfs_truncfile+0x18c>
ffffffffc020a7a2:	0b0ca783          	lw	a5,176(s9) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a7a6:	14079d63          	bnez	a5,ffffffffc020a900 <sfs_truncfile+0x18c>
ffffffffc020a7aa:	4d38                	lw	a4,88(a0)
ffffffffc020a7ac:	6405                	lui	s0,0x1
ffffffffc020a7ae:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a7b2:	16f71763          	bne	a4,a5,ffffffffc020a920 <sfs_truncfile+0x1ac>
ffffffffc020a7b6:	00053a83          	ld	s5,0(a0)
ffffffffc020a7ba:	147d                	addi	s0,s0,-1
ffffffffc020a7bc:	942e                	add	s0,s0,a1
ffffffffc020a7be:	000ae783          	lwu	a5,0(s5)
ffffffffc020a7c2:	8031                	srli	s0,s0,0xc
ffffffffc020a7c4:	8a2e                	mv	s4,a1
ffffffffc020a7c6:	2401                	sext.w	s0,s0
ffffffffc020a7c8:	02b79763          	bne	a5,a1,ffffffffc020a7f6 <sfs_truncfile+0x82>
ffffffffc020a7cc:	008aa783          	lw	a5,8(s5)
ffffffffc020a7d0:	4901                	li	s2,0
ffffffffc020a7d2:	18879763          	bne	a5,s0,ffffffffc020a960 <sfs_truncfile+0x1ec>
ffffffffc020a7d6:	60aa                	ld	ra,136(sp)
ffffffffc020a7d8:	640a                	ld	s0,128(sp)
ffffffffc020a7da:	74e6                	ld	s1,120(sp)
ffffffffc020a7dc:	79a6                	ld	s3,104(sp)
ffffffffc020a7de:	7a06                	ld	s4,96(sp)
ffffffffc020a7e0:	6ae6                	ld	s5,88(sp)
ffffffffc020a7e2:	6b46                	ld	s6,80(sp)
ffffffffc020a7e4:	6ba6                	ld	s7,72(sp)
ffffffffc020a7e6:	6c06                	ld	s8,64(sp)
ffffffffc020a7e8:	7ce2                	ld	s9,56(sp)
ffffffffc020a7ea:	7d42                	ld	s10,48(sp)
ffffffffc020a7ec:	7da2                	ld	s11,40(sp)
ffffffffc020a7ee:	854a                	mv	a0,s2
ffffffffc020a7f0:	7946                	ld	s2,112(sp)
ffffffffc020a7f2:	6149                	addi	sp,sp,144
ffffffffc020a7f4:	8082                	ret
ffffffffc020a7f6:	02050b13          	addi	s6,a0,32
ffffffffc020a7fa:	855a                	mv	a0,s6
ffffffffc020a7fc:	e01f90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020a800:	008aa483          	lw	s1,8(s5)
ffffffffc020a804:	0a84e663          	bltu	s1,s0,ffffffffc020a8b0 <sfs_truncfile+0x13c>
ffffffffc020a808:	0c947163          	bgeu	s0,s1,ffffffffc020a8ca <sfs_truncfile+0x156>
ffffffffc020a80c:	4dad                	li	s11,11
ffffffffc020a80e:	4b85                	li	s7,1
ffffffffc020a810:	a09d                	j	ffffffffc020a876 <sfs_truncfile+0x102>
ffffffffc020a812:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a816:	0009079b          	sext.w	a5,s2
ffffffffc020a81a:	3ff00713          	li	a4,1023
ffffffffc020a81e:	04f76563          	bltu	a4,a5,ffffffffc020a868 <sfs_truncfile+0xf4>
ffffffffc020a822:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a826:	040c0163          	beqz	s8,ffffffffc020a868 <sfs_truncfile+0xf4>
ffffffffc020a82a:	004ca783          	lw	a5,4(s9)
ffffffffc020a82e:	18fc7963          	bgeu	s8,a5,ffffffffc020a9c0 <sfs_truncfile+0x24c>
ffffffffc020a832:	038cb503          	ld	a0,56(s9)
ffffffffc020a836:	85e2                	mv	a1,s8
ffffffffc020a838:	b59fe0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc020a83c:	16051263          	bnez	a0,ffffffffc020a9a0 <sfs_truncfile+0x22c>
ffffffffc020a840:	02091793          	slli	a5,s2,0x20
ffffffffc020a844:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a848:	86e2                	mv	a3,s8
ffffffffc020a84a:	4611                	li	a2,4
ffffffffc020a84c:	082c                	addi	a1,sp,24
ffffffffc020a84e:	8566                	mv	a0,s9
ffffffffc020a850:	e43a                	sd	a4,8(sp)
ffffffffc020a852:	ce02                	sw	zero,28(sp)
ffffffffc020a854:	043000ef          	jal	ra,ffffffffc020b096 <sfs_rbuf>
ffffffffc020a858:	892a                	mv	s2,a0
ffffffffc020a85a:	e141                	bnez	a0,ffffffffc020a8da <sfs_truncfile+0x166>
ffffffffc020a85c:	47e2                	lw	a5,24(sp)
ffffffffc020a85e:	6722                	ld	a4,8(sp)
ffffffffc020a860:	e3c9                	bnez	a5,ffffffffc020a8e2 <sfs_truncfile+0x16e>
ffffffffc020a862:	008d2603          	lw	a2,8(s10)
ffffffffc020a866:	367d                	addiw	a2,a2,-1
ffffffffc020a868:	00cd2423          	sw	a2,8(s10)
ffffffffc020a86c:	0179b823          	sd	s7,16(s3)
ffffffffc020a870:	34fd                	addiw	s1,s1,-1
ffffffffc020a872:	04940a63          	beq	s0,s1,ffffffffc020a8c6 <sfs_truncfile+0x152>
ffffffffc020a876:	0009bd03          	ld	s10,0(s3)
ffffffffc020a87a:	008d2703          	lw	a4,8(s10)
ffffffffc020a87e:	c369                	beqz	a4,ffffffffc020a940 <sfs_truncfile+0x1cc>
ffffffffc020a880:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a884:	0007861b          	sext.w	a2,a5
ffffffffc020a888:	f8cde5e3          	bltu	s11,a2,ffffffffc020a812 <sfs_truncfile+0x9e>
ffffffffc020a88c:	02079713          	slli	a4,a5,0x20
ffffffffc020a890:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a894:	00fd0933          	add	s2,s10,a5
ffffffffc020a898:	00c92583          	lw	a1,12(s2)
ffffffffc020a89c:	d5f1                	beqz	a1,ffffffffc020a868 <sfs_truncfile+0xf4>
ffffffffc020a89e:	8566                	mv	a0,s9
ffffffffc020a8a0:	bfeff0ef          	jal	ra,ffffffffc0209c9e <sfs_block_free>
ffffffffc020a8a4:	00092623          	sw	zero,12(s2)
ffffffffc020a8a8:	008d2603          	lw	a2,8(s10)
ffffffffc020a8ac:	367d                	addiw	a2,a2,-1
ffffffffc020a8ae:	bf6d                	j	ffffffffc020a868 <sfs_truncfile+0xf4>
ffffffffc020a8b0:	4681                	li	a3,0
ffffffffc020a8b2:	8626                	mv	a2,s1
ffffffffc020a8b4:	85ce                	mv	a1,s3
ffffffffc020a8b6:	8566                	mv	a0,s9
ffffffffc020a8b8:	ea0ff0ef          	jal	ra,ffffffffc0209f58 <sfs_bmap_load_nolock>
ffffffffc020a8bc:	892a                	mv	s2,a0
ffffffffc020a8be:	ed11                	bnez	a0,ffffffffc020a8da <sfs_truncfile+0x166>
ffffffffc020a8c0:	2485                	addiw	s1,s1,1
ffffffffc020a8c2:	fe9417e3          	bne	s0,s1,ffffffffc020a8b0 <sfs_truncfile+0x13c>
ffffffffc020a8c6:	008aa483          	lw	s1,8(s5)
ffffffffc020a8ca:	0a941b63          	bne	s0,s1,ffffffffc020a980 <sfs_truncfile+0x20c>
ffffffffc020a8ce:	014aa023          	sw	s4,0(s5)
ffffffffc020a8d2:	4785                	li	a5,1
ffffffffc020a8d4:	00f9b823          	sd	a5,16(s3)
ffffffffc020a8d8:	4901                	li	s2,0
ffffffffc020a8da:	855a                	mv	a0,s6
ffffffffc020a8dc:	d1df90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020a8e0:	bddd                	j	ffffffffc020a7d6 <sfs_truncfile+0x62>
ffffffffc020a8e2:	86e2                	mv	a3,s8
ffffffffc020a8e4:	4611                	li	a2,4
ffffffffc020a8e6:	086c                	addi	a1,sp,28
ffffffffc020a8e8:	8566                	mv	a0,s9
ffffffffc020a8ea:	02d000ef          	jal	ra,ffffffffc020b116 <sfs_wbuf>
ffffffffc020a8ee:	892a                	mv	s2,a0
ffffffffc020a8f0:	f56d                	bnez	a0,ffffffffc020a8da <sfs_truncfile+0x166>
ffffffffc020a8f2:	45e2                	lw	a1,24(sp)
ffffffffc020a8f4:	8566                	mv	a0,s9
ffffffffc020a8f6:	ba8ff0ef          	jal	ra,ffffffffc0209c9e <sfs_block_free>
ffffffffc020a8fa:	b7a5                	j	ffffffffc020a862 <sfs_truncfile+0xee>
ffffffffc020a8fc:	5975                	li	s2,-3
ffffffffc020a8fe:	bde1                	j	ffffffffc020a7d6 <sfs_truncfile+0x62>
ffffffffc020a900:	00004697          	auipc	a3,0x4
ffffffffc020a904:	67868693          	addi	a3,a3,1656 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc020a908:	00001617          	auipc	a2,0x1
ffffffffc020a90c:	3f860613          	addi	a2,a2,1016 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a910:	3b300593          	li	a1,947
ffffffffc020a914:	00005517          	auipc	a0,0x5
ffffffffc020a918:	84450513          	addi	a0,a0,-1980 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a91c:	b83f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a920:	00005697          	auipc	a3,0x5
ffffffffc020a924:	80068693          	addi	a3,a3,-2048 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc020a928:	00001617          	auipc	a2,0x1
ffffffffc020a92c:	3d860613          	addi	a2,a2,984 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a930:	3b400593          	li	a1,948
ffffffffc020a934:	00005517          	auipc	a0,0x5
ffffffffc020a938:	82450513          	addi	a0,a0,-2012 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a93c:	b63f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a940:	00005697          	auipc	a3,0x5
ffffffffc020a944:	a3868693          	addi	a3,a3,-1480 # ffffffffc020f378 <dev_node_ops+0x7e0>
ffffffffc020a948:	00001617          	auipc	a2,0x1
ffffffffc020a94c:	3b860613          	addi	a2,a2,952 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a950:	17b00593          	li	a1,379
ffffffffc020a954:	00005517          	auipc	a0,0x5
ffffffffc020a958:	80450513          	addi	a0,a0,-2044 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a95c:	b43f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a960:	00005697          	auipc	a3,0x5
ffffffffc020a964:	a0068693          	addi	a3,a3,-1536 # ffffffffc020f360 <dev_node_ops+0x7c8>
ffffffffc020a968:	00001617          	auipc	a2,0x1
ffffffffc020a96c:	39860613          	addi	a2,a2,920 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a970:	3bb00593          	li	a1,955
ffffffffc020a974:	00004517          	auipc	a0,0x4
ffffffffc020a978:	7e450513          	addi	a0,a0,2020 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a97c:	b23f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a980:	00005697          	auipc	a3,0x5
ffffffffc020a984:	a4868693          	addi	a3,a3,-1464 # ffffffffc020f3c8 <dev_node_ops+0x830>
ffffffffc020a988:	00001617          	auipc	a2,0x1
ffffffffc020a98c:	37860613          	addi	a2,a2,888 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a990:	3d400593          	li	a1,980
ffffffffc020a994:	00004517          	auipc	a0,0x4
ffffffffc020a998:	7c450513          	addi	a0,a0,1988 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a99c:	b03f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a9a0:	00005697          	auipc	a3,0x5
ffffffffc020a9a4:	9f068693          	addi	a3,a3,-1552 # ffffffffc020f390 <dev_node_ops+0x7f8>
ffffffffc020a9a8:	00001617          	auipc	a2,0x1
ffffffffc020a9ac:	35860613          	addi	a2,a2,856 # ffffffffc020bd00 <commands+0x210>
ffffffffc020a9b0:	12b00593          	li	a1,299
ffffffffc020a9b4:	00004517          	auipc	a0,0x4
ffffffffc020a9b8:	7a450513          	addi	a0,a0,1956 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a9bc:	ae3f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a9c0:	8762                	mv	a4,s8
ffffffffc020a9c2:	86be                	mv	a3,a5
ffffffffc020a9c4:	00004617          	auipc	a2,0x4
ffffffffc020a9c8:	7c460613          	addi	a2,a2,1988 # ffffffffc020f188 <dev_node_ops+0x5f0>
ffffffffc020a9cc:	05300593          	li	a1,83
ffffffffc020a9d0:	00004517          	auipc	a0,0x4
ffffffffc020a9d4:	78850513          	addi	a0,a0,1928 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020a9d8:	ac7f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a9dc <sfs_load_inode>:
ffffffffc020a9dc:	7139                	addi	sp,sp,-64
ffffffffc020a9de:	fc06                	sd	ra,56(sp)
ffffffffc020a9e0:	f822                	sd	s0,48(sp)
ffffffffc020a9e2:	f426                	sd	s1,40(sp)
ffffffffc020a9e4:	f04a                	sd	s2,32(sp)
ffffffffc020a9e6:	84b2                	mv	s1,a2
ffffffffc020a9e8:	892a                	mv	s2,a0
ffffffffc020a9ea:	ec4e                	sd	s3,24(sp)
ffffffffc020a9ec:	e852                	sd	s4,16(sp)
ffffffffc020a9ee:	89ae                	mv	s3,a1
ffffffffc020a9f0:	e456                	sd	s5,8(sp)
ffffffffc020a9f2:	0d5000ef          	jal	ra,ffffffffc020b2c6 <lock_sfs_fs>
ffffffffc020a9f6:	45a9                	li	a1,10
ffffffffc020a9f8:	8526                	mv	a0,s1
ffffffffc020a9fa:	0a893403          	ld	s0,168(s2)
ffffffffc020a9fe:	0e9000ef          	jal	ra,ffffffffc020b2e6 <hash32>
ffffffffc020aa02:	02051793          	slli	a5,a0,0x20
ffffffffc020aa06:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020aa0a:	9722                	add	a4,a4,s0
ffffffffc020aa0c:	843a                	mv	s0,a4
ffffffffc020aa0e:	a029                	j	ffffffffc020aa18 <sfs_load_inode+0x3c>
ffffffffc020aa10:	fc042783          	lw	a5,-64(s0)
ffffffffc020aa14:	10978863          	beq	a5,s1,ffffffffc020ab24 <sfs_load_inode+0x148>
ffffffffc020aa18:	6400                	ld	s0,8(s0)
ffffffffc020aa1a:	fe871be3          	bne	a4,s0,ffffffffc020aa10 <sfs_load_inode+0x34>
ffffffffc020aa1e:	04000513          	li	a0,64
ffffffffc020aa22:	e00f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020aa26:	8aaa                	mv	s5,a0
ffffffffc020aa28:	16050563          	beqz	a0,ffffffffc020ab92 <sfs_load_inode+0x1b6>
ffffffffc020aa2c:	00492683          	lw	a3,4(s2)
ffffffffc020aa30:	18048363          	beqz	s1,ffffffffc020abb6 <sfs_load_inode+0x1da>
ffffffffc020aa34:	18d4f163          	bgeu	s1,a3,ffffffffc020abb6 <sfs_load_inode+0x1da>
ffffffffc020aa38:	03893503          	ld	a0,56(s2)
ffffffffc020aa3c:	85a6                	mv	a1,s1
ffffffffc020aa3e:	953fe0ef          	jal	ra,ffffffffc0209390 <bitmap_test>
ffffffffc020aa42:	18051763          	bnez	a0,ffffffffc020abd0 <sfs_load_inode+0x1f4>
ffffffffc020aa46:	4701                	li	a4,0
ffffffffc020aa48:	86a6                	mv	a3,s1
ffffffffc020aa4a:	04000613          	li	a2,64
ffffffffc020aa4e:	85d6                	mv	a1,s5
ffffffffc020aa50:	854a                	mv	a0,s2
ffffffffc020aa52:	644000ef          	jal	ra,ffffffffc020b096 <sfs_rbuf>
ffffffffc020aa56:	842a                	mv	s0,a0
ffffffffc020aa58:	0e051563          	bnez	a0,ffffffffc020ab42 <sfs_load_inode+0x166>
ffffffffc020aa5c:	006ad783          	lhu	a5,6(s5)
ffffffffc020aa60:	12078b63          	beqz	a5,ffffffffc020ab96 <sfs_load_inode+0x1ba>
ffffffffc020aa64:	6405                	lui	s0,0x1
ffffffffc020aa66:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020aa6a:	8e0fd0ef          	jal	ra,ffffffffc0207b4a <__alloc_inode>
ffffffffc020aa6e:	8a2a                	mv	s4,a0
ffffffffc020aa70:	c961                	beqz	a0,ffffffffc020ab40 <sfs_load_inode+0x164>
ffffffffc020aa72:	004ad683          	lhu	a3,4(s5)
ffffffffc020aa76:	4785                	li	a5,1
ffffffffc020aa78:	0cf69c63          	bne	a3,a5,ffffffffc020ab50 <sfs_load_inode+0x174>
ffffffffc020aa7c:	864a                	mv	a2,s2
ffffffffc020aa7e:	00005597          	auipc	a1,0x5
ffffffffc020aa82:	a5a58593          	addi	a1,a1,-1446 # ffffffffc020f4d8 <sfs_node_fileops>
ffffffffc020aa86:	8e0fd0ef          	jal	ra,ffffffffc0207b66 <inode_init>
ffffffffc020aa8a:	058a2783          	lw	a5,88(s4)
ffffffffc020aa8e:	23540413          	addi	s0,s0,565
ffffffffc020aa92:	0e879063          	bne	a5,s0,ffffffffc020ab72 <sfs_load_inode+0x196>
ffffffffc020aa96:	4785                	li	a5,1
ffffffffc020aa98:	00fa2c23          	sw	a5,24(s4)
ffffffffc020aa9c:	015a3023          	sd	s5,0(s4)
ffffffffc020aaa0:	009a2423          	sw	s1,8(s4)
ffffffffc020aaa4:	000a3823          	sd	zero,16(s4)
ffffffffc020aaa8:	4585                	li	a1,1
ffffffffc020aaaa:	020a0513          	addi	a0,s4,32
ffffffffc020aaae:	b45f90ef          	jal	ra,ffffffffc02045f2 <sem_init>
ffffffffc020aab2:	058a2703          	lw	a4,88(s4)
ffffffffc020aab6:	6785                	lui	a5,0x1
ffffffffc020aab8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020aabc:	14f71663          	bne	a4,a5,ffffffffc020ac08 <sfs_load_inode+0x22c>
ffffffffc020aac0:	0a093703          	ld	a4,160(s2)
ffffffffc020aac4:	038a0793          	addi	a5,s4,56
ffffffffc020aac8:	008a2503          	lw	a0,8(s4)
ffffffffc020aacc:	e31c                	sd	a5,0(a4)
ffffffffc020aace:	0af93023          	sd	a5,160(s2)
ffffffffc020aad2:	09890793          	addi	a5,s2,152
ffffffffc020aad6:	0a893403          	ld	s0,168(s2)
ffffffffc020aada:	45a9                	li	a1,10
ffffffffc020aadc:	04ea3023          	sd	a4,64(s4)
ffffffffc020aae0:	02fa3c23          	sd	a5,56(s4)
ffffffffc020aae4:	003000ef          	jal	ra,ffffffffc020b2e6 <hash32>
ffffffffc020aae8:	02051713          	slli	a4,a0,0x20
ffffffffc020aaec:	01c75793          	srli	a5,a4,0x1c
ffffffffc020aaf0:	97a2                	add	a5,a5,s0
ffffffffc020aaf2:	6798                	ld	a4,8(a5)
ffffffffc020aaf4:	048a0693          	addi	a3,s4,72
ffffffffc020aaf8:	e314                	sd	a3,0(a4)
ffffffffc020aafa:	e794                	sd	a3,8(a5)
ffffffffc020aafc:	04ea3823          	sd	a4,80(s4)
ffffffffc020ab00:	04fa3423          	sd	a5,72(s4)
ffffffffc020ab04:	854a                	mv	a0,s2
ffffffffc020ab06:	7d0000ef          	jal	ra,ffffffffc020b2d6 <unlock_sfs_fs>
ffffffffc020ab0a:	4401                	li	s0,0
ffffffffc020ab0c:	0149b023          	sd	s4,0(s3)
ffffffffc020ab10:	70e2                	ld	ra,56(sp)
ffffffffc020ab12:	8522                	mv	a0,s0
ffffffffc020ab14:	7442                	ld	s0,48(sp)
ffffffffc020ab16:	74a2                	ld	s1,40(sp)
ffffffffc020ab18:	7902                	ld	s2,32(sp)
ffffffffc020ab1a:	69e2                	ld	s3,24(sp)
ffffffffc020ab1c:	6a42                	ld	s4,16(sp)
ffffffffc020ab1e:	6aa2                	ld	s5,8(sp)
ffffffffc020ab20:	6121                	addi	sp,sp,64
ffffffffc020ab22:	8082                	ret
ffffffffc020ab24:	fb840a13          	addi	s4,s0,-72
ffffffffc020ab28:	8552                	mv	a0,s4
ffffffffc020ab2a:	89efd0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc020ab2e:	4785                	li	a5,1
ffffffffc020ab30:	fcf51ae3          	bne	a0,a5,ffffffffc020ab04 <sfs_load_inode+0x128>
ffffffffc020ab34:	fd042783          	lw	a5,-48(s0)
ffffffffc020ab38:	2785                	addiw	a5,a5,1
ffffffffc020ab3a:	fcf42823          	sw	a5,-48(s0)
ffffffffc020ab3e:	b7d9                	j	ffffffffc020ab04 <sfs_load_inode+0x128>
ffffffffc020ab40:	5471                	li	s0,-4
ffffffffc020ab42:	8556                	mv	a0,s5
ffffffffc020ab44:	d8ef70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020ab48:	854a                	mv	a0,s2
ffffffffc020ab4a:	78c000ef          	jal	ra,ffffffffc020b2d6 <unlock_sfs_fs>
ffffffffc020ab4e:	b7c9                	j	ffffffffc020ab10 <sfs_load_inode+0x134>
ffffffffc020ab50:	4789                	li	a5,2
ffffffffc020ab52:	08f69f63          	bne	a3,a5,ffffffffc020abf0 <sfs_load_inode+0x214>
ffffffffc020ab56:	864a                	mv	a2,s2
ffffffffc020ab58:	00005597          	auipc	a1,0x5
ffffffffc020ab5c:	90058593          	addi	a1,a1,-1792 # ffffffffc020f458 <sfs_node_dirops>
ffffffffc020ab60:	806fd0ef          	jal	ra,ffffffffc0207b66 <inode_init>
ffffffffc020ab64:	058a2703          	lw	a4,88(s4)
ffffffffc020ab68:	6785                	lui	a5,0x1
ffffffffc020ab6a:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ab6e:	f2f704e3          	beq	a4,a5,ffffffffc020aa96 <sfs_load_inode+0xba>
ffffffffc020ab72:	00004697          	auipc	a3,0x4
ffffffffc020ab76:	5ae68693          	addi	a3,a3,1454 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc020ab7a:	00001617          	auipc	a2,0x1
ffffffffc020ab7e:	18660613          	addi	a2,a2,390 # ffffffffc020bd00 <commands+0x210>
ffffffffc020ab82:	07700593          	li	a1,119
ffffffffc020ab86:	00004517          	auipc	a0,0x4
ffffffffc020ab8a:	5d250513          	addi	a0,a0,1490 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020ab8e:	911f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ab92:	5471                	li	s0,-4
ffffffffc020ab94:	bf55                	j	ffffffffc020ab48 <sfs_load_inode+0x16c>
ffffffffc020ab96:	00005697          	auipc	a3,0x5
ffffffffc020ab9a:	84a68693          	addi	a3,a3,-1974 # ffffffffc020f3e0 <dev_node_ops+0x848>
ffffffffc020ab9e:	00001617          	auipc	a2,0x1
ffffffffc020aba2:	16260613          	addi	a2,a2,354 # ffffffffc020bd00 <commands+0x210>
ffffffffc020aba6:	0ad00593          	li	a1,173
ffffffffc020abaa:	00004517          	auipc	a0,0x4
ffffffffc020abae:	5ae50513          	addi	a0,a0,1454 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020abb2:	8edf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020abb6:	8726                	mv	a4,s1
ffffffffc020abb8:	00004617          	auipc	a2,0x4
ffffffffc020abbc:	5d060613          	addi	a2,a2,1488 # ffffffffc020f188 <dev_node_ops+0x5f0>
ffffffffc020abc0:	05300593          	li	a1,83
ffffffffc020abc4:	00004517          	auipc	a0,0x4
ffffffffc020abc8:	59450513          	addi	a0,a0,1428 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020abcc:	8d3f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020abd0:	00004697          	auipc	a3,0x4
ffffffffc020abd4:	5f068693          	addi	a3,a3,1520 # ffffffffc020f1c0 <dev_node_ops+0x628>
ffffffffc020abd8:	00001617          	auipc	a2,0x1
ffffffffc020abdc:	12860613          	addi	a2,a2,296 # ffffffffc020bd00 <commands+0x210>
ffffffffc020abe0:	0a800593          	li	a1,168
ffffffffc020abe4:	00004517          	auipc	a0,0x4
ffffffffc020abe8:	57450513          	addi	a0,a0,1396 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020abec:	8b3f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020abf0:	00004617          	auipc	a2,0x4
ffffffffc020abf4:	58060613          	addi	a2,a2,1408 # ffffffffc020f170 <dev_node_ops+0x5d8>
ffffffffc020abf8:	02e00593          	li	a1,46
ffffffffc020abfc:	00004517          	auipc	a0,0x4
ffffffffc020ac00:	55c50513          	addi	a0,a0,1372 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020ac04:	89bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ac08:	00004697          	auipc	a3,0x4
ffffffffc020ac0c:	51868693          	addi	a3,a3,1304 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc020ac10:	00001617          	auipc	a2,0x1
ffffffffc020ac14:	0f060613          	addi	a2,a2,240 # ffffffffc020bd00 <commands+0x210>
ffffffffc020ac18:	0b100593          	li	a1,177
ffffffffc020ac1c:	00004517          	auipc	a0,0x4
ffffffffc020ac20:	53c50513          	addi	a0,a0,1340 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020ac24:	87bf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ac28 <sfs_lookup>:
ffffffffc020ac28:	7139                	addi	sp,sp,-64
ffffffffc020ac2a:	ec4e                	sd	s3,24(sp)
ffffffffc020ac2c:	06853983          	ld	s3,104(a0)
ffffffffc020ac30:	fc06                	sd	ra,56(sp)
ffffffffc020ac32:	f822                	sd	s0,48(sp)
ffffffffc020ac34:	f426                	sd	s1,40(sp)
ffffffffc020ac36:	f04a                	sd	s2,32(sp)
ffffffffc020ac38:	e852                	sd	s4,16(sp)
ffffffffc020ac3a:	0a098c63          	beqz	s3,ffffffffc020acf2 <sfs_lookup+0xca>
ffffffffc020ac3e:	0b09a783          	lw	a5,176(s3)
ffffffffc020ac42:	ebc5                	bnez	a5,ffffffffc020acf2 <sfs_lookup+0xca>
ffffffffc020ac44:	0005c783          	lbu	a5,0(a1)
ffffffffc020ac48:	84ae                	mv	s1,a1
ffffffffc020ac4a:	c7c1                	beqz	a5,ffffffffc020acd2 <sfs_lookup+0xaa>
ffffffffc020ac4c:	02f00713          	li	a4,47
ffffffffc020ac50:	08e78163          	beq	a5,a4,ffffffffc020acd2 <sfs_lookup+0xaa>
ffffffffc020ac54:	842a                	mv	s0,a0
ffffffffc020ac56:	8a32                	mv	s4,a2
ffffffffc020ac58:	f71fc0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc020ac5c:	4c38                	lw	a4,88(s0)
ffffffffc020ac5e:	6785                	lui	a5,0x1
ffffffffc020ac60:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ac64:	0af71763          	bne	a4,a5,ffffffffc020ad12 <sfs_lookup+0xea>
ffffffffc020ac68:	6018                	ld	a4,0(s0)
ffffffffc020ac6a:	4789                	li	a5,2
ffffffffc020ac6c:	00475703          	lhu	a4,4(a4)
ffffffffc020ac70:	04f71c63          	bne	a4,a5,ffffffffc020acc8 <sfs_lookup+0xa0>
ffffffffc020ac74:	02040913          	addi	s2,s0,32
ffffffffc020ac78:	854a                	mv	a0,s2
ffffffffc020ac7a:	983f90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020ac7e:	8626                	mv	a2,s1
ffffffffc020ac80:	0054                	addi	a3,sp,4
ffffffffc020ac82:	85a2                	mv	a1,s0
ffffffffc020ac84:	854e                	mv	a0,s3
ffffffffc020ac86:	a29ff0ef          	jal	ra,ffffffffc020a6ae <sfs_dirent_search_nolock.constprop.0>
ffffffffc020ac8a:	84aa                	mv	s1,a0
ffffffffc020ac8c:	854a                	mv	a0,s2
ffffffffc020ac8e:	96bf90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020ac92:	cc89                	beqz	s1,ffffffffc020acac <sfs_lookup+0x84>
ffffffffc020ac94:	8522                	mv	a0,s0
ffffffffc020ac96:	800fd0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020ac9a:	70e2                	ld	ra,56(sp)
ffffffffc020ac9c:	7442                	ld	s0,48(sp)
ffffffffc020ac9e:	7902                	ld	s2,32(sp)
ffffffffc020aca0:	69e2                	ld	s3,24(sp)
ffffffffc020aca2:	6a42                	ld	s4,16(sp)
ffffffffc020aca4:	8526                	mv	a0,s1
ffffffffc020aca6:	74a2                	ld	s1,40(sp)
ffffffffc020aca8:	6121                	addi	sp,sp,64
ffffffffc020acaa:	8082                	ret
ffffffffc020acac:	4612                	lw	a2,4(sp)
ffffffffc020acae:	002c                	addi	a1,sp,8
ffffffffc020acb0:	854e                	mv	a0,s3
ffffffffc020acb2:	d2bff0ef          	jal	ra,ffffffffc020a9dc <sfs_load_inode>
ffffffffc020acb6:	84aa                	mv	s1,a0
ffffffffc020acb8:	8522                	mv	a0,s0
ffffffffc020acba:	fddfc0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020acbe:	fcf1                	bnez	s1,ffffffffc020ac9a <sfs_lookup+0x72>
ffffffffc020acc0:	67a2                	ld	a5,8(sp)
ffffffffc020acc2:	00fa3023          	sd	a5,0(s4)
ffffffffc020acc6:	bfd1                	j	ffffffffc020ac9a <sfs_lookup+0x72>
ffffffffc020acc8:	8522                	mv	a0,s0
ffffffffc020acca:	fcdfc0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020acce:	54b9                	li	s1,-18
ffffffffc020acd0:	b7e9                	j	ffffffffc020ac9a <sfs_lookup+0x72>
ffffffffc020acd2:	00004697          	auipc	a3,0x4
ffffffffc020acd6:	72668693          	addi	a3,a3,1830 # ffffffffc020f3f8 <dev_node_ops+0x860>
ffffffffc020acda:	00001617          	auipc	a2,0x1
ffffffffc020acde:	02660613          	addi	a2,a2,38 # ffffffffc020bd00 <commands+0x210>
ffffffffc020ace2:	3e500593          	li	a1,997
ffffffffc020ace6:	00004517          	auipc	a0,0x4
ffffffffc020acea:	47250513          	addi	a0,a0,1138 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020acee:	fb0f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020acf2:	00004697          	auipc	a3,0x4
ffffffffc020acf6:	28668693          	addi	a3,a3,646 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc020acfa:	00001617          	auipc	a2,0x1
ffffffffc020acfe:	00660613          	addi	a2,a2,6 # ffffffffc020bd00 <commands+0x210>
ffffffffc020ad02:	3e400593          	li	a1,996
ffffffffc020ad06:	00004517          	auipc	a0,0x4
ffffffffc020ad0a:	45250513          	addi	a0,a0,1106 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020ad0e:	f90f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ad12:	00004697          	auipc	a3,0x4
ffffffffc020ad16:	40e68693          	addi	a3,a3,1038 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc020ad1a:	00001617          	auipc	a2,0x1
ffffffffc020ad1e:	fe660613          	addi	a2,a2,-26 # ffffffffc020bd00 <commands+0x210>
ffffffffc020ad22:	3e700593          	li	a1,999
ffffffffc020ad26:	00004517          	auipc	a0,0x4
ffffffffc020ad2a:	43250513          	addi	a0,a0,1074 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020ad2e:	f70f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ad32 <sfs_namefile>:
ffffffffc020ad32:	6d98                	ld	a4,24(a1)
ffffffffc020ad34:	7175                	addi	sp,sp,-144
ffffffffc020ad36:	e506                	sd	ra,136(sp)
ffffffffc020ad38:	e122                	sd	s0,128(sp)
ffffffffc020ad3a:	fca6                	sd	s1,120(sp)
ffffffffc020ad3c:	f8ca                	sd	s2,112(sp)
ffffffffc020ad3e:	f4ce                	sd	s3,104(sp)
ffffffffc020ad40:	f0d2                	sd	s4,96(sp)
ffffffffc020ad42:	ecd6                	sd	s5,88(sp)
ffffffffc020ad44:	e8da                	sd	s6,80(sp)
ffffffffc020ad46:	e4de                	sd	s7,72(sp)
ffffffffc020ad48:	e0e2                	sd	s8,64(sp)
ffffffffc020ad4a:	fc66                	sd	s9,56(sp)
ffffffffc020ad4c:	f86a                	sd	s10,48(sp)
ffffffffc020ad4e:	f46e                	sd	s11,40(sp)
ffffffffc020ad50:	e42e                	sd	a1,8(sp)
ffffffffc020ad52:	4789                	li	a5,2
ffffffffc020ad54:	1ae7f363          	bgeu	a5,a4,ffffffffc020aefa <sfs_namefile+0x1c8>
ffffffffc020ad58:	89aa                	mv	s3,a0
ffffffffc020ad5a:	10400513          	li	a0,260
ffffffffc020ad5e:	ac4f70ef          	jal	ra,ffffffffc0202022 <kmalloc>
ffffffffc020ad62:	842a                	mv	s0,a0
ffffffffc020ad64:	18050b63          	beqz	a0,ffffffffc020aefa <sfs_namefile+0x1c8>
ffffffffc020ad68:	0689b483          	ld	s1,104(s3)
ffffffffc020ad6c:	1e048963          	beqz	s1,ffffffffc020af5e <sfs_namefile+0x22c>
ffffffffc020ad70:	0b04a783          	lw	a5,176(s1)
ffffffffc020ad74:	1e079563          	bnez	a5,ffffffffc020af5e <sfs_namefile+0x22c>
ffffffffc020ad78:	0589ac83          	lw	s9,88(s3)
ffffffffc020ad7c:	6785                	lui	a5,0x1
ffffffffc020ad7e:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ad82:	1afc9e63          	bne	s9,a5,ffffffffc020af3e <sfs_namefile+0x20c>
ffffffffc020ad86:	6722                	ld	a4,8(sp)
ffffffffc020ad88:	854e                	mv	a0,s3
ffffffffc020ad8a:	8ace                	mv	s5,s3
ffffffffc020ad8c:	6f1c                	ld	a5,24(a4)
ffffffffc020ad8e:	00073b03          	ld	s6,0(a4)
ffffffffc020ad92:	02098a13          	addi	s4,s3,32
ffffffffc020ad96:	ffe78b93          	addi	s7,a5,-2
ffffffffc020ad9a:	9b3e                	add	s6,s6,a5
ffffffffc020ad9c:	00004d17          	auipc	s10,0x4
ffffffffc020ada0:	67cd0d13          	addi	s10,s10,1660 # ffffffffc020f418 <dev_node_ops+0x880>
ffffffffc020ada4:	e25fc0ef          	jal	ra,ffffffffc0207bc8 <inode_ref_inc>
ffffffffc020ada8:	00440c13          	addi	s8,s0,4
ffffffffc020adac:	e066                	sd	s9,0(sp)
ffffffffc020adae:	8552                	mv	a0,s4
ffffffffc020adb0:	84df90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020adb4:	0854                	addi	a3,sp,20
ffffffffc020adb6:	866a                	mv	a2,s10
ffffffffc020adb8:	85d6                	mv	a1,s5
ffffffffc020adba:	8526                	mv	a0,s1
ffffffffc020adbc:	8f3ff0ef          	jal	ra,ffffffffc020a6ae <sfs_dirent_search_nolock.constprop.0>
ffffffffc020adc0:	8daa                	mv	s11,a0
ffffffffc020adc2:	8552                	mv	a0,s4
ffffffffc020adc4:	835f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020adc8:	020d8863          	beqz	s11,ffffffffc020adf8 <sfs_namefile+0xc6>
ffffffffc020adcc:	854e                	mv	a0,s3
ffffffffc020adce:	ec9fc0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020add2:	8522                	mv	a0,s0
ffffffffc020add4:	afef70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020add8:	60aa                	ld	ra,136(sp)
ffffffffc020adda:	640a                	ld	s0,128(sp)
ffffffffc020addc:	74e6                	ld	s1,120(sp)
ffffffffc020adde:	7946                	ld	s2,112(sp)
ffffffffc020ade0:	79a6                	ld	s3,104(sp)
ffffffffc020ade2:	7a06                	ld	s4,96(sp)
ffffffffc020ade4:	6ae6                	ld	s5,88(sp)
ffffffffc020ade6:	6b46                	ld	s6,80(sp)
ffffffffc020ade8:	6ba6                	ld	s7,72(sp)
ffffffffc020adea:	6c06                	ld	s8,64(sp)
ffffffffc020adec:	7ce2                	ld	s9,56(sp)
ffffffffc020adee:	7d42                	ld	s10,48(sp)
ffffffffc020adf0:	856e                	mv	a0,s11
ffffffffc020adf2:	7da2                	ld	s11,40(sp)
ffffffffc020adf4:	6149                	addi	sp,sp,144
ffffffffc020adf6:	8082                	ret
ffffffffc020adf8:	4652                	lw	a2,20(sp)
ffffffffc020adfa:	082c                	addi	a1,sp,24
ffffffffc020adfc:	8526                	mv	a0,s1
ffffffffc020adfe:	bdfff0ef          	jal	ra,ffffffffc020a9dc <sfs_load_inode>
ffffffffc020ae02:	8daa                	mv	s11,a0
ffffffffc020ae04:	f561                	bnez	a0,ffffffffc020adcc <sfs_namefile+0x9a>
ffffffffc020ae06:	854e                	mv	a0,s3
ffffffffc020ae08:	008aa903          	lw	s2,8(s5)
ffffffffc020ae0c:	e8bfc0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020ae10:	6ce2                	ld	s9,24(sp)
ffffffffc020ae12:	0b3c8463          	beq	s9,s3,ffffffffc020aeba <sfs_namefile+0x188>
ffffffffc020ae16:	100c8463          	beqz	s9,ffffffffc020af1e <sfs_namefile+0x1ec>
ffffffffc020ae1a:	058ca703          	lw	a4,88(s9)
ffffffffc020ae1e:	6782                	ld	a5,0(sp)
ffffffffc020ae20:	0ef71f63          	bne	a4,a5,ffffffffc020af1e <sfs_namefile+0x1ec>
ffffffffc020ae24:	008ca703          	lw	a4,8(s9)
ffffffffc020ae28:	8ae6                	mv	s5,s9
ffffffffc020ae2a:	0d270a63          	beq	a4,s2,ffffffffc020aefe <sfs_namefile+0x1cc>
ffffffffc020ae2e:	000cb703          	ld	a4,0(s9)
ffffffffc020ae32:	4789                	li	a5,2
ffffffffc020ae34:	00475703          	lhu	a4,4(a4)
ffffffffc020ae38:	0cf71363          	bne	a4,a5,ffffffffc020aefe <sfs_namefile+0x1cc>
ffffffffc020ae3c:	020c8a13          	addi	s4,s9,32
ffffffffc020ae40:	8552                	mv	a0,s4
ffffffffc020ae42:	fbaf90ef          	jal	ra,ffffffffc02045fc <down>
ffffffffc020ae46:	000cb703          	ld	a4,0(s9)
ffffffffc020ae4a:	00872983          	lw	s3,8(a4)
ffffffffc020ae4e:	01304963          	bgtz	s3,ffffffffc020ae60 <sfs_namefile+0x12e>
ffffffffc020ae52:	a899                	j	ffffffffc020aea8 <sfs_namefile+0x176>
ffffffffc020ae54:	4018                	lw	a4,0(s0)
ffffffffc020ae56:	01270e63          	beq	a4,s2,ffffffffc020ae72 <sfs_namefile+0x140>
ffffffffc020ae5a:	2d85                	addiw	s11,s11,1
ffffffffc020ae5c:	05b98663          	beq	s3,s11,ffffffffc020aea8 <sfs_namefile+0x176>
ffffffffc020ae60:	86a2                	mv	a3,s0
ffffffffc020ae62:	866e                	mv	a2,s11
ffffffffc020ae64:	85e6                	mv	a1,s9
ffffffffc020ae66:	8526                	mv	a0,s1
ffffffffc020ae68:	e48ff0ef          	jal	ra,ffffffffc020a4b0 <sfs_dirent_read_nolock>
ffffffffc020ae6c:	872a                	mv	a4,a0
ffffffffc020ae6e:	d17d                	beqz	a0,ffffffffc020ae54 <sfs_namefile+0x122>
ffffffffc020ae70:	a82d                	j	ffffffffc020aeaa <sfs_namefile+0x178>
ffffffffc020ae72:	8552                	mv	a0,s4
ffffffffc020ae74:	f84f90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020ae78:	8562                	mv	a0,s8
ffffffffc020ae7a:	0ff000ef          	jal	ra,ffffffffc020b778 <strlen>
ffffffffc020ae7e:	00150793          	addi	a5,a0,1
ffffffffc020ae82:	862a                	mv	a2,a0
ffffffffc020ae84:	06fbe863          	bltu	s7,a5,ffffffffc020aef4 <sfs_namefile+0x1c2>
ffffffffc020ae88:	fff64913          	not	s2,a2
ffffffffc020ae8c:	995a                	add	s2,s2,s6
ffffffffc020ae8e:	85e2                	mv	a1,s8
ffffffffc020ae90:	854a                	mv	a0,s2
ffffffffc020ae92:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020ae96:	1d7000ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc020ae9a:	02f00793          	li	a5,47
ffffffffc020ae9e:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020aea2:	89e6                	mv	s3,s9
ffffffffc020aea4:	8b4a                	mv	s6,s2
ffffffffc020aea6:	b721                	j	ffffffffc020adae <sfs_namefile+0x7c>
ffffffffc020aea8:	5741                	li	a4,-16
ffffffffc020aeaa:	8552                	mv	a0,s4
ffffffffc020aeac:	e03a                	sd	a4,0(sp)
ffffffffc020aeae:	f4af90ef          	jal	ra,ffffffffc02045f8 <up>
ffffffffc020aeb2:	6702                	ld	a4,0(sp)
ffffffffc020aeb4:	89e6                	mv	s3,s9
ffffffffc020aeb6:	8dba                	mv	s11,a4
ffffffffc020aeb8:	bf11                	j	ffffffffc020adcc <sfs_namefile+0x9a>
ffffffffc020aeba:	854e                	mv	a0,s3
ffffffffc020aebc:	ddbfc0ef          	jal	ra,ffffffffc0207c96 <inode_ref_dec>
ffffffffc020aec0:	64a2                	ld	s1,8(sp)
ffffffffc020aec2:	85da                	mv	a1,s6
ffffffffc020aec4:	6c98                	ld	a4,24(s1)
ffffffffc020aec6:	6088                	ld	a0,0(s1)
ffffffffc020aec8:	1779                	addi	a4,a4,-2
ffffffffc020aeca:	41770bb3          	sub	s7,a4,s7
ffffffffc020aece:	865e                	mv	a2,s7
ffffffffc020aed0:	0505                	addi	a0,a0,1
ffffffffc020aed2:	15b000ef          	jal	ra,ffffffffc020b82c <memmove>
ffffffffc020aed6:	02f00713          	li	a4,47
ffffffffc020aeda:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020aede:	955e                	add	a0,a0,s7
ffffffffc020aee0:	00050023          	sb	zero,0(a0)
ffffffffc020aee4:	85de                	mv	a1,s7
ffffffffc020aee6:	8526                	mv	a0,s1
ffffffffc020aee8:	e08fa0ef          	jal	ra,ffffffffc02054f0 <iobuf_skip>
ffffffffc020aeec:	8522                	mv	a0,s0
ffffffffc020aeee:	9e4f70ef          	jal	ra,ffffffffc02020d2 <kfree>
ffffffffc020aef2:	b5dd                	j	ffffffffc020add8 <sfs_namefile+0xa6>
ffffffffc020aef4:	89e6                	mv	s3,s9
ffffffffc020aef6:	5df1                	li	s11,-4
ffffffffc020aef8:	bdd1                	j	ffffffffc020adcc <sfs_namefile+0x9a>
ffffffffc020aefa:	5df1                	li	s11,-4
ffffffffc020aefc:	bdf1                	j	ffffffffc020add8 <sfs_namefile+0xa6>
ffffffffc020aefe:	00004697          	auipc	a3,0x4
ffffffffc020af02:	52268693          	addi	a3,a3,1314 # ffffffffc020f420 <dev_node_ops+0x888>
ffffffffc020af06:	00001617          	auipc	a2,0x1
ffffffffc020af0a:	dfa60613          	addi	a2,a2,-518 # ffffffffc020bd00 <commands+0x210>
ffffffffc020af0e:	30300593          	li	a1,771
ffffffffc020af12:	00004517          	auipc	a0,0x4
ffffffffc020af16:	24650513          	addi	a0,a0,582 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020af1a:	d84f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020af1e:	00004697          	auipc	a3,0x4
ffffffffc020af22:	20268693          	addi	a3,a3,514 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc020af26:	00001617          	auipc	a2,0x1
ffffffffc020af2a:	dda60613          	addi	a2,a2,-550 # ffffffffc020bd00 <commands+0x210>
ffffffffc020af2e:	30200593          	li	a1,770
ffffffffc020af32:	00004517          	auipc	a0,0x4
ffffffffc020af36:	22650513          	addi	a0,a0,550 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020af3a:	d64f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020af3e:	00004697          	auipc	a3,0x4
ffffffffc020af42:	1e268693          	addi	a3,a3,482 # ffffffffc020f120 <dev_node_ops+0x588>
ffffffffc020af46:	00001617          	auipc	a2,0x1
ffffffffc020af4a:	dba60613          	addi	a2,a2,-582 # ffffffffc020bd00 <commands+0x210>
ffffffffc020af4e:	2ef00593          	li	a1,751
ffffffffc020af52:	00004517          	auipc	a0,0x4
ffffffffc020af56:	20650513          	addi	a0,a0,518 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020af5a:	d44f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020af5e:	00004697          	auipc	a3,0x4
ffffffffc020af62:	01a68693          	addi	a3,a3,26 # ffffffffc020ef78 <dev_node_ops+0x3e0>
ffffffffc020af66:	00001617          	auipc	a2,0x1
ffffffffc020af6a:	d9a60613          	addi	a2,a2,-614 # ffffffffc020bd00 <commands+0x210>
ffffffffc020af6e:	2ee00593          	li	a1,750
ffffffffc020af72:	00004517          	auipc	a0,0x4
ffffffffc020af76:	1e650513          	addi	a0,a0,486 # ffffffffc020f158 <dev_node_ops+0x5c0>
ffffffffc020af7a:	d24f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020af7e <sfs_rwblock_nolock>:
ffffffffc020af7e:	7139                	addi	sp,sp,-64
ffffffffc020af80:	f822                	sd	s0,48(sp)
ffffffffc020af82:	f426                	sd	s1,40(sp)
ffffffffc020af84:	fc06                	sd	ra,56(sp)
ffffffffc020af86:	842a                	mv	s0,a0
ffffffffc020af88:	84b6                	mv	s1,a3
ffffffffc020af8a:	e211                	bnez	a2,ffffffffc020af8e <sfs_rwblock_nolock+0x10>
ffffffffc020af8c:	e715                	bnez	a4,ffffffffc020afb8 <sfs_rwblock_nolock+0x3a>
ffffffffc020af8e:	405c                	lw	a5,4(s0)
ffffffffc020af90:	02f67463          	bgeu	a2,a5,ffffffffc020afb8 <sfs_rwblock_nolock+0x3a>
ffffffffc020af94:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020af98:	1682                	slli	a3,a3,0x20
ffffffffc020af9a:	6605                	lui	a2,0x1
ffffffffc020af9c:	9281                	srli	a3,a3,0x20
ffffffffc020af9e:	850a                	mv	a0,sp
ffffffffc020afa0:	cdafa0ef          	jal	ra,ffffffffc020547a <iobuf_init>
ffffffffc020afa4:	85aa                	mv	a1,a0
ffffffffc020afa6:	7808                	ld	a0,48(s0)
ffffffffc020afa8:	8626                	mv	a2,s1
ffffffffc020afaa:	7118                	ld	a4,32(a0)
ffffffffc020afac:	9702                	jalr	a4
ffffffffc020afae:	70e2                	ld	ra,56(sp)
ffffffffc020afb0:	7442                	ld	s0,48(sp)
ffffffffc020afb2:	74a2                	ld	s1,40(sp)
ffffffffc020afb4:	6121                	addi	sp,sp,64
ffffffffc020afb6:	8082                	ret
ffffffffc020afb8:	00004697          	auipc	a3,0x4
ffffffffc020afbc:	5a068693          	addi	a3,a3,1440 # ffffffffc020f558 <sfs_node_fileops+0x80>
ffffffffc020afc0:	00001617          	auipc	a2,0x1
ffffffffc020afc4:	d4060613          	addi	a2,a2,-704 # ffffffffc020bd00 <commands+0x210>
ffffffffc020afc8:	45d5                	li	a1,21
ffffffffc020afca:	00004517          	auipc	a0,0x4
ffffffffc020afce:	5c650513          	addi	a0,a0,1478 # ffffffffc020f590 <sfs_node_fileops+0xb8>
ffffffffc020afd2:	cccf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020afd6 <sfs_rblock>:
ffffffffc020afd6:	7139                	addi	sp,sp,-64
ffffffffc020afd8:	ec4e                	sd	s3,24(sp)
ffffffffc020afda:	89b6                	mv	s3,a3
ffffffffc020afdc:	f822                	sd	s0,48(sp)
ffffffffc020afde:	f04a                	sd	s2,32(sp)
ffffffffc020afe0:	e852                	sd	s4,16(sp)
ffffffffc020afe2:	fc06                	sd	ra,56(sp)
ffffffffc020afe4:	f426                	sd	s1,40(sp)
ffffffffc020afe6:	e456                	sd	s5,8(sp)
ffffffffc020afe8:	8a2a                	mv	s4,a0
ffffffffc020afea:	892e                	mv	s2,a1
ffffffffc020afec:	8432                	mv	s0,a2
ffffffffc020afee:	2e0000ef          	jal	ra,ffffffffc020b2ce <lock_sfs_io>
ffffffffc020aff2:	04098063          	beqz	s3,ffffffffc020b032 <sfs_rblock+0x5c>
ffffffffc020aff6:	013409bb          	addw	s3,s0,s3
ffffffffc020affa:	6a85                	lui	s5,0x1
ffffffffc020affc:	a021                	j	ffffffffc020b004 <sfs_rblock+0x2e>
ffffffffc020affe:	9956                	add	s2,s2,s5
ffffffffc020b000:	02898963          	beq	s3,s0,ffffffffc020b032 <sfs_rblock+0x5c>
ffffffffc020b004:	8622                	mv	a2,s0
ffffffffc020b006:	85ca                	mv	a1,s2
ffffffffc020b008:	4705                	li	a4,1
ffffffffc020b00a:	4681                	li	a3,0
ffffffffc020b00c:	8552                	mv	a0,s4
ffffffffc020b00e:	f71ff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b012:	84aa                	mv	s1,a0
ffffffffc020b014:	2405                	addiw	s0,s0,1
ffffffffc020b016:	d565                	beqz	a0,ffffffffc020affe <sfs_rblock+0x28>
ffffffffc020b018:	8552                	mv	a0,s4
ffffffffc020b01a:	2c4000ef          	jal	ra,ffffffffc020b2de <unlock_sfs_io>
ffffffffc020b01e:	70e2                	ld	ra,56(sp)
ffffffffc020b020:	7442                	ld	s0,48(sp)
ffffffffc020b022:	7902                	ld	s2,32(sp)
ffffffffc020b024:	69e2                	ld	s3,24(sp)
ffffffffc020b026:	6a42                	ld	s4,16(sp)
ffffffffc020b028:	6aa2                	ld	s5,8(sp)
ffffffffc020b02a:	8526                	mv	a0,s1
ffffffffc020b02c:	74a2                	ld	s1,40(sp)
ffffffffc020b02e:	6121                	addi	sp,sp,64
ffffffffc020b030:	8082                	ret
ffffffffc020b032:	4481                	li	s1,0
ffffffffc020b034:	b7d5                	j	ffffffffc020b018 <sfs_rblock+0x42>

ffffffffc020b036 <sfs_wblock>:
ffffffffc020b036:	7139                	addi	sp,sp,-64
ffffffffc020b038:	ec4e                	sd	s3,24(sp)
ffffffffc020b03a:	89b6                	mv	s3,a3
ffffffffc020b03c:	f822                	sd	s0,48(sp)
ffffffffc020b03e:	f04a                	sd	s2,32(sp)
ffffffffc020b040:	e852                	sd	s4,16(sp)
ffffffffc020b042:	fc06                	sd	ra,56(sp)
ffffffffc020b044:	f426                	sd	s1,40(sp)
ffffffffc020b046:	e456                	sd	s5,8(sp)
ffffffffc020b048:	8a2a                	mv	s4,a0
ffffffffc020b04a:	892e                	mv	s2,a1
ffffffffc020b04c:	8432                	mv	s0,a2
ffffffffc020b04e:	280000ef          	jal	ra,ffffffffc020b2ce <lock_sfs_io>
ffffffffc020b052:	04098063          	beqz	s3,ffffffffc020b092 <sfs_wblock+0x5c>
ffffffffc020b056:	013409bb          	addw	s3,s0,s3
ffffffffc020b05a:	6a85                	lui	s5,0x1
ffffffffc020b05c:	a021                	j	ffffffffc020b064 <sfs_wblock+0x2e>
ffffffffc020b05e:	9956                	add	s2,s2,s5
ffffffffc020b060:	02898963          	beq	s3,s0,ffffffffc020b092 <sfs_wblock+0x5c>
ffffffffc020b064:	8622                	mv	a2,s0
ffffffffc020b066:	85ca                	mv	a1,s2
ffffffffc020b068:	4705                	li	a4,1
ffffffffc020b06a:	4685                	li	a3,1
ffffffffc020b06c:	8552                	mv	a0,s4
ffffffffc020b06e:	f11ff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b072:	84aa                	mv	s1,a0
ffffffffc020b074:	2405                	addiw	s0,s0,1
ffffffffc020b076:	d565                	beqz	a0,ffffffffc020b05e <sfs_wblock+0x28>
ffffffffc020b078:	8552                	mv	a0,s4
ffffffffc020b07a:	264000ef          	jal	ra,ffffffffc020b2de <unlock_sfs_io>
ffffffffc020b07e:	70e2                	ld	ra,56(sp)
ffffffffc020b080:	7442                	ld	s0,48(sp)
ffffffffc020b082:	7902                	ld	s2,32(sp)
ffffffffc020b084:	69e2                	ld	s3,24(sp)
ffffffffc020b086:	6a42                	ld	s4,16(sp)
ffffffffc020b088:	6aa2                	ld	s5,8(sp)
ffffffffc020b08a:	8526                	mv	a0,s1
ffffffffc020b08c:	74a2                	ld	s1,40(sp)
ffffffffc020b08e:	6121                	addi	sp,sp,64
ffffffffc020b090:	8082                	ret
ffffffffc020b092:	4481                	li	s1,0
ffffffffc020b094:	b7d5                	j	ffffffffc020b078 <sfs_wblock+0x42>

ffffffffc020b096 <sfs_rbuf>:
ffffffffc020b096:	7179                	addi	sp,sp,-48
ffffffffc020b098:	f406                	sd	ra,40(sp)
ffffffffc020b09a:	f022                	sd	s0,32(sp)
ffffffffc020b09c:	ec26                	sd	s1,24(sp)
ffffffffc020b09e:	e84a                	sd	s2,16(sp)
ffffffffc020b0a0:	e44e                	sd	s3,8(sp)
ffffffffc020b0a2:	e052                	sd	s4,0(sp)
ffffffffc020b0a4:	6785                	lui	a5,0x1
ffffffffc020b0a6:	04f77863          	bgeu	a4,a5,ffffffffc020b0f6 <sfs_rbuf+0x60>
ffffffffc020b0aa:	84ba                	mv	s1,a4
ffffffffc020b0ac:	9732                	add	a4,a4,a2
ffffffffc020b0ae:	89b2                	mv	s3,a2
ffffffffc020b0b0:	04e7e363          	bltu	a5,a4,ffffffffc020b0f6 <sfs_rbuf+0x60>
ffffffffc020b0b4:	8936                	mv	s2,a3
ffffffffc020b0b6:	842a                	mv	s0,a0
ffffffffc020b0b8:	8a2e                	mv	s4,a1
ffffffffc020b0ba:	214000ef          	jal	ra,ffffffffc020b2ce <lock_sfs_io>
ffffffffc020b0be:	642c                	ld	a1,72(s0)
ffffffffc020b0c0:	864a                	mv	a2,s2
ffffffffc020b0c2:	4705                	li	a4,1
ffffffffc020b0c4:	4681                	li	a3,0
ffffffffc020b0c6:	8522                	mv	a0,s0
ffffffffc020b0c8:	eb7ff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b0cc:	892a                	mv	s2,a0
ffffffffc020b0ce:	cd09                	beqz	a0,ffffffffc020b0e8 <sfs_rbuf+0x52>
ffffffffc020b0d0:	8522                	mv	a0,s0
ffffffffc020b0d2:	20c000ef          	jal	ra,ffffffffc020b2de <unlock_sfs_io>
ffffffffc020b0d6:	70a2                	ld	ra,40(sp)
ffffffffc020b0d8:	7402                	ld	s0,32(sp)
ffffffffc020b0da:	64e2                	ld	s1,24(sp)
ffffffffc020b0dc:	69a2                	ld	s3,8(sp)
ffffffffc020b0de:	6a02                	ld	s4,0(sp)
ffffffffc020b0e0:	854a                	mv	a0,s2
ffffffffc020b0e2:	6942                	ld	s2,16(sp)
ffffffffc020b0e4:	6145                	addi	sp,sp,48
ffffffffc020b0e6:	8082                	ret
ffffffffc020b0e8:	642c                	ld	a1,72(s0)
ffffffffc020b0ea:	864e                	mv	a2,s3
ffffffffc020b0ec:	8552                	mv	a0,s4
ffffffffc020b0ee:	95a6                	add	a1,a1,s1
ffffffffc020b0f0:	77c000ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc020b0f4:	bff1                	j	ffffffffc020b0d0 <sfs_rbuf+0x3a>
ffffffffc020b0f6:	00004697          	auipc	a3,0x4
ffffffffc020b0fa:	4b268693          	addi	a3,a3,1202 # ffffffffc020f5a8 <sfs_node_fileops+0xd0>
ffffffffc020b0fe:	00001617          	auipc	a2,0x1
ffffffffc020b102:	c0260613          	addi	a2,a2,-1022 # ffffffffc020bd00 <commands+0x210>
ffffffffc020b106:	05500593          	li	a1,85
ffffffffc020b10a:	00004517          	auipc	a0,0x4
ffffffffc020b10e:	48650513          	addi	a0,a0,1158 # ffffffffc020f590 <sfs_node_fileops+0xb8>
ffffffffc020b112:	b8cf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020b116 <sfs_wbuf>:
ffffffffc020b116:	7139                	addi	sp,sp,-64
ffffffffc020b118:	fc06                	sd	ra,56(sp)
ffffffffc020b11a:	f822                	sd	s0,48(sp)
ffffffffc020b11c:	f426                	sd	s1,40(sp)
ffffffffc020b11e:	f04a                	sd	s2,32(sp)
ffffffffc020b120:	ec4e                	sd	s3,24(sp)
ffffffffc020b122:	e852                	sd	s4,16(sp)
ffffffffc020b124:	e456                	sd	s5,8(sp)
ffffffffc020b126:	6785                	lui	a5,0x1
ffffffffc020b128:	06f77163          	bgeu	a4,a5,ffffffffc020b18a <sfs_wbuf+0x74>
ffffffffc020b12c:	893a                	mv	s2,a4
ffffffffc020b12e:	9732                	add	a4,a4,a2
ffffffffc020b130:	8a32                	mv	s4,a2
ffffffffc020b132:	04e7ec63          	bltu	a5,a4,ffffffffc020b18a <sfs_wbuf+0x74>
ffffffffc020b136:	842a                	mv	s0,a0
ffffffffc020b138:	89b6                	mv	s3,a3
ffffffffc020b13a:	8aae                	mv	s5,a1
ffffffffc020b13c:	192000ef          	jal	ra,ffffffffc020b2ce <lock_sfs_io>
ffffffffc020b140:	642c                	ld	a1,72(s0)
ffffffffc020b142:	4705                	li	a4,1
ffffffffc020b144:	4681                	li	a3,0
ffffffffc020b146:	864e                	mv	a2,s3
ffffffffc020b148:	8522                	mv	a0,s0
ffffffffc020b14a:	e35ff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b14e:	84aa                	mv	s1,a0
ffffffffc020b150:	cd11                	beqz	a0,ffffffffc020b16c <sfs_wbuf+0x56>
ffffffffc020b152:	8522                	mv	a0,s0
ffffffffc020b154:	18a000ef          	jal	ra,ffffffffc020b2de <unlock_sfs_io>
ffffffffc020b158:	70e2                	ld	ra,56(sp)
ffffffffc020b15a:	7442                	ld	s0,48(sp)
ffffffffc020b15c:	7902                	ld	s2,32(sp)
ffffffffc020b15e:	69e2                	ld	s3,24(sp)
ffffffffc020b160:	6a42                	ld	s4,16(sp)
ffffffffc020b162:	6aa2                	ld	s5,8(sp)
ffffffffc020b164:	8526                	mv	a0,s1
ffffffffc020b166:	74a2                	ld	s1,40(sp)
ffffffffc020b168:	6121                	addi	sp,sp,64
ffffffffc020b16a:	8082                	ret
ffffffffc020b16c:	6428                	ld	a0,72(s0)
ffffffffc020b16e:	8652                	mv	a2,s4
ffffffffc020b170:	85d6                	mv	a1,s5
ffffffffc020b172:	954a                	add	a0,a0,s2
ffffffffc020b174:	6f8000ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc020b178:	642c                	ld	a1,72(s0)
ffffffffc020b17a:	4705                	li	a4,1
ffffffffc020b17c:	4685                	li	a3,1
ffffffffc020b17e:	864e                	mv	a2,s3
ffffffffc020b180:	8522                	mv	a0,s0
ffffffffc020b182:	dfdff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b186:	84aa                	mv	s1,a0
ffffffffc020b188:	b7e9                	j	ffffffffc020b152 <sfs_wbuf+0x3c>
ffffffffc020b18a:	00004697          	auipc	a3,0x4
ffffffffc020b18e:	41e68693          	addi	a3,a3,1054 # ffffffffc020f5a8 <sfs_node_fileops+0xd0>
ffffffffc020b192:	00001617          	auipc	a2,0x1
ffffffffc020b196:	b6e60613          	addi	a2,a2,-1170 # ffffffffc020bd00 <commands+0x210>
ffffffffc020b19a:	06b00593          	li	a1,107
ffffffffc020b19e:	00004517          	auipc	a0,0x4
ffffffffc020b1a2:	3f250513          	addi	a0,a0,1010 # ffffffffc020f590 <sfs_node_fileops+0xb8>
ffffffffc020b1a6:	af8f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020b1aa <sfs_sync_super>:
ffffffffc020b1aa:	1101                	addi	sp,sp,-32
ffffffffc020b1ac:	ec06                	sd	ra,24(sp)
ffffffffc020b1ae:	e822                	sd	s0,16(sp)
ffffffffc020b1b0:	e426                	sd	s1,8(sp)
ffffffffc020b1b2:	842a                	mv	s0,a0
ffffffffc020b1b4:	11a000ef          	jal	ra,ffffffffc020b2ce <lock_sfs_io>
ffffffffc020b1b8:	6428                	ld	a0,72(s0)
ffffffffc020b1ba:	6605                	lui	a2,0x1
ffffffffc020b1bc:	4581                	li	a1,0
ffffffffc020b1be:	65c000ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc020b1c2:	6428                	ld	a0,72(s0)
ffffffffc020b1c4:	85a2                	mv	a1,s0
ffffffffc020b1c6:	02c00613          	li	a2,44
ffffffffc020b1ca:	6a2000ef          	jal	ra,ffffffffc020b86c <memcpy>
ffffffffc020b1ce:	642c                	ld	a1,72(s0)
ffffffffc020b1d0:	4701                	li	a4,0
ffffffffc020b1d2:	4685                	li	a3,1
ffffffffc020b1d4:	4601                	li	a2,0
ffffffffc020b1d6:	8522                	mv	a0,s0
ffffffffc020b1d8:	da7ff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b1dc:	84aa                	mv	s1,a0
ffffffffc020b1de:	8522                	mv	a0,s0
ffffffffc020b1e0:	0fe000ef          	jal	ra,ffffffffc020b2de <unlock_sfs_io>
ffffffffc020b1e4:	60e2                	ld	ra,24(sp)
ffffffffc020b1e6:	6442                	ld	s0,16(sp)
ffffffffc020b1e8:	8526                	mv	a0,s1
ffffffffc020b1ea:	64a2                	ld	s1,8(sp)
ffffffffc020b1ec:	6105                	addi	sp,sp,32
ffffffffc020b1ee:	8082                	ret

ffffffffc020b1f0 <sfs_sync_freemap>:
ffffffffc020b1f0:	7139                	addi	sp,sp,-64
ffffffffc020b1f2:	ec4e                	sd	s3,24(sp)
ffffffffc020b1f4:	e852                	sd	s4,16(sp)
ffffffffc020b1f6:	00456983          	lwu	s3,4(a0)
ffffffffc020b1fa:	8a2a                	mv	s4,a0
ffffffffc020b1fc:	7d08                	ld	a0,56(a0)
ffffffffc020b1fe:	67a1                	lui	a5,0x8
ffffffffc020b200:	17fd                	addi	a5,a5,-1
ffffffffc020b202:	4581                	li	a1,0
ffffffffc020b204:	f822                	sd	s0,48(sp)
ffffffffc020b206:	fc06                	sd	ra,56(sp)
ffffffffc020b208:	f426                	sd	s1,40(sp)
ffffffffc020b20a:	f04a                	sd	s2,32(sp)
ffffffffc020b20c:	e456                	sd	s5,8(sp)
ffffffffc020b20e:	99be                	add	s3,s3,a5
ffffffffc020b210:	a14fe0ef          	jal	ra,ffffffffc0209424 <bitmap_getdata>
ffffffffc020b214:	00f9d993          	srli	s3,s3,0xf
ffffffffc020b218:	842a                	mv	s0,a0
ffffffffc020b21a:	8552                	mv	a0,s4
ffffffffc020b21c:	0b2000ef          	jal	ra,ffffffffc020b2ce <lock_sfs_io>
ffffffffc020b220:	04098163          	beqz	s3,ffffffffc020b262 <sfs_sync_freemap+0x72>
ffffffffc020b224:	09b2                	slli	s3,s3,0xc
ffffffffc020b226:	99a2                	add	s3,s3,s0
ffffffffc020b228:	4909                	li	s2,2
ffffffffc020b22a:	6a85                	lui	s5,0x1
ffffffffc020b22c:	a021                	j	ffffffffc020b234 <sfs_sync_freemap+0x44>
ffffffffc020b22e:	2905                	addiw	s2,s2,1
ffffffffc020b230:	02898963          	beq	s3,s0,ffffffffc020b262 <sfs_sync_freemap+0x72>
ffffffffc020b234:	85a2                	mv	a1,s0
ffffffffc020b236:	864a                	mv	a2,s2
ffffffffc020b238:	4705                	li	a4,1
ffffffffc020b23a:	4685                	li	a3,1
ffffffffc020b23c:	8552                	mv	a0,s4
ffffffffc020b23e:	d41ff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b242:	84aa                	mv	s1,a0
ffffffffc020b244:	9456                	add	s0,s0,s5
ffffffffc020b246:	d565                	beqz	a0,ffffffffc020b22e <sfs_sync_freemap+0x3e>
ffffffffc020b248:	8552                	mv	a0,s4
ffffffffc020b24a:	094000ef          	jal	ra,ffffffffc020b2de <unlock_sfs_io>
ffffffffc020b24e:	70e2                	ld	ra,56(sp)
ffffffffc020b250:	7442                	ld	s0,48(sp)
ffffffffc020b252:	7902                	ld	s2,32(sp)
ffffffffc020b254:	69e2                	ld	s3,24(sp)
ffffffffc020b256:	6a42                	ld	s4,16(sp)
ffffffffc020b258:	6aa2                	ld	s5,8(sp)
ffffffffc020b25a:	8526                	mv	a0,s1
ffffffffc020b25c:	74a2                	ld	s1,40(sp)
ffffffffc020b25e:	6121                	addi	sp,sp,64
ffffffffc020b260:	8082                	ret
ffffffffc020b262:	4481                	li	s1,0
ffffffffc020b264:	b7d5                	j	ffffffffc020b248 <sfs_sync_freemap+0x58>

ffffffffc020b266 <sfs_clear_block>:
ffffffffc020b266:	7179                	addi	sp,sp,-48
ffffffffc020b268:	f022                	sd	s0,32(sp)
ffffffffc020b26a:	e84a                	sd	s2,16(sp)
ffffffffc020b26c:	e44e                	sd	s3,8(sp)
ffffffffc020b26e:	f406                	sd	ra,40(sp)
ffffffffc020b270:	89b2                	mv	s3,a2
ffffffffc020b272:	ec26                	sd	s1,24(sp)
ffffffffc020b274:	892a                	mv	s2,a0
ffffffffc020b276:	842e                	mv	s0,a1
ffffffffc020b278:	056000ef          	jal	ra,ffffffffc020b2ce <lock_sfs_io>
ffffffffc020b27c:	04893503          	ld	a0,72(s2)
ffffffffc020b280:	6605                	lui	a2,0x1
ffffffffc020b282:	4581                	li	a1,0
ffffffffc020b284:	596000ef          	jal	ra,ffffffffc020b81a <memset>
ffffffffc020b288:	02098d63          	beqz	s3,ffffffffc020b2c2 <sfs_clear_block+0x5c>
ffffffffc020b28c:	013409bb          	addw	s3,s0,s3
ffffffffc020b290:	a019                	j	ffffffffc020b296 <sfs_clear_block+0x30>
ffffffffc020b292:	02898863          	beq	s3,s0,ffffffffc020b2c2 <sfs_clear_block+0x5c>
ffffffffc020b296:	04893583          	ld	a1,72(s2)
ffffffffc020b29a:	8622                	mv	a2,s0
ffffffffc020b29c:	4705                	li	a4,1
ffffffffc020b29e:	4685                	li	a3,1
ffffffffc020b2a0:	854a                	mv	a0,s2
ffffffffc020b2a2:	cddff0ef          	jal	ra,ffffffffc020af7e <sfs_rwblock_nolock>
ffffffffc020b2a6:	84aa                	mv	s1,a0
ffffffffc020b2a8:	2405                	addiw	s0,s0,1
ffffffffc020b2aa:	d565                	beqz	a0,ffffffffc020b292 <sfs_clear_block+0x2c>
ffffffffc020b2ac:	854a                	mv	a0,s2
ffffffffc020b2ae:	030000ef          	jal	ra,ffffffffc020b2de <unlock_sfs_io>
ffffffffc020b2b2:	70a2                	ld	ra,40(sp)
ffffffffc020b2b4:	7402                	ld	s0,32(sp)
ffffffffc020b2b6:	6942                	ld	s2,16(sp)
ffffffffc020b2b8:	69a2                	ld	s3,8(sp)
ffffffffc020b2ba:	8526                	mv	a0,s1
ffffffffc020b2bc:	64e2                	ld	s1,24(sp)
ffffffffc020b2be:	6145                	addi	sp,sp,48
ffffffffc020b2c0:	8082                	ret
ffffffffc020b2c2:	4481                	li	s1,0
ffffffffc020b2c4:	b7e5                	j	ffffffffc020b2ac <sfs_clear_block+0x46>

ffffffffc020b2c6 <lock_sfs_fs>:
ffffffffc020b2c6:	05050513          	addi	a0,a0,80
ffffffffc020b2ca:	b32f906f          	j	ffffffffc02045fc <down>

ffffffffc020b2ce <lock_sfs_io>:
ffffffffc020b2ce:	06850513          	addi	a0,a0,104
ffffffffc020b2d2:	b2af906f          	j	ffffffffc02045fc <down>

ffffffffc020b2d6 <unlock_sfs_fs>:
ffffffffc020b2d6:	05050513          	addi	a0,a0,80
ffffffffc020b2da:	b1ef906f          	j	ffffffffc02045f8 <up>

ffffffffc020b2de <unlock_sfs_io>:
ffffffffc020b2de:	06850513          	addi	a0,a0,104
ffffffffc020b2e2:	b16f906f          	j	ffffffffc02045f8 <up>

ffffffffc020b2e6 <hash32>:
ffffffffc020b2e6:	9e3707b7          	lui	a5,0x9e370
ffffffffc020b2ea:	2785                	addiw	a5,a5,1
ffffffffc020b2ec:	02a7853b          	mulw	a0,a5,a0
ffffffffc020b2f0:	02000793          	li	a5,32
ffffffffc020b2f4:	9f8d                	subw	a5,a5,a1
ffffffffc020b2f6:	00f5553b          	srlw	a0,a0,a5
ffffffffc020b2fa:	8082                	ret

ffffffffc020b2fc <printnum>:
ffffffffc020b2fc:	02071893          	slli	a7,a4,0x20
ffffffffc020b300:	7139                	addi	sp,sp,-64
ffffffffc020b302:	0208d893          	srli	a7,a7,0x20
ffffffffc020b306:	e456                	sd	s5,8(sp)
ffffffffc020b308:	0316fab3          	remu	s5,a3,a7
ffffffffc020b30c:	f822                	sd	s0,48(sp)
ffffffffc020b30e:	f426                	sd	s1,40(sp)
ffffffffc020b310:	f04a                	sd	s2,32(sp)
ffffffffc020b312:	ec4e                	sd	s3,24(sp)
ffffffffc020b314:	fc06                	sd	ra,56(sp)
ffffffffc020b316:	e852                	sd	s4,16(sp)
ffffffffc020b318:	84aa                	mv	s1,a0
ffffffffc020b31a:	89ae                	mv	s3,a1
ffffffffc020b31c:	8932                	mv	s2,a2
ffffffffc020b31e:	fff7841b          	addiw	s0,a5,-1
ffffffffc020b322:	2a81                	sext.w	s5,s5
ffffffffc020b324:	0516f163          	bgeu	a3,a7,ffffffffc020b366 <printnum+0x6a>
ffffffffc020b328:	8a42                	mv	s4,a6
ffffffffc020b32a:	00805863          	blez	s0,ffffffffc020b33a <printnum+0x3e>
ffffffffc020b32e:	347d                	addiw	s0,s0,-1
ffffffffc020b330:	864e                	mv	a2,s3
ffffffffc020b332:	85ca                	mv	a1,s2
ffffffffc020b334:	8552                	mv	a0,s4
ffffffffc020b336:	9482                	jalr	s1
ffffffffc020b338:	f87d                	bnez	s0,ffffffffc020b32e <printnum+0x32>
ffffffffc020b33a:	1a82                	slli	s5,s5,0x20
ffffffffc020b33c:	00004797          	auipc	a5,0x4
ffffffffc020b340:	2b478793          	addi	a5,a5,692 # ffffffffc020f5f0 <sfs_node_fileops+0x118>
ffffffffc020b344:	020ada93          	srli	s5,s5,0x20
ffffffffc020b348:	9abe                	add	s5,s5,a5
ffffffffc020b34a:	7442                	ld	s0,48(sp)
ffffffffc020b34c:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020b350:	70e2                	ld	ra,56(sp)
ffffffffc020b352:	6a42                	ld	s4,16(sp)
ffffffffc020b354:	6aa2                	ld	s5,8(sp)
ffffffffc020b356:	864e                	mv	a2,s3
ffffffffc020b358:	85ca                	mv	a1,s2
ffffffffc020b35a:	69e2                	ld	s3,24(sp)
ffffffffc020b35c:	7902                	ld	s2,32(sp)
ffffffffc020b35e:	87a6                	mv	a5,s1
ffffffffc020b360:	74a2                	ld	s1,40(sp)
ffffffffc020b362:	6121                	addi	sp,sp,64
ffffffffc020b364:	8782                	jr	a5
ffffffffc020b366:	0316d6b3          	divu	a3,a3,a7
ffffffffc020b36a:	87a2                	mv	a5,s0
ffffffffc020b36c:	f91ff0ef          	jal	ra,ffffffffc020b2fc <printnum>
ffffffffc020b370:	b7e9                	j	ffffffffc020b33a <printnum+0x3e>

ffffffffc020b372 <sprintputch>:
ffffffffc020b372:	499c                	lw	a5,16(a1)
ffffffffc020b374:	6198                	ld	a4,0(a1)
ffffffffc020b376:	6594                	ld	a3,8(a1)
ffffffffc020b378:	2785                	addiw	a5,a5,1
ffffffffc020b37a:	c99c                	sw	a5,16(a1)
ffffffffc020b37c:	00d77763          	bgeu	a4,a3,ffffffffc020b38a <sprintputch+0x18>
ffffffffc020b380:	00170793          	addi	a5,a4,1
ffffffffc020b384:	e19c                	sd	a5,0(a1)
ffffffffc020b386:	00a70023          	sb	a0,0(a4)
ffffffffc020b38a:	8082                	ret

ffffffffc020b38c <vprintfmt>:
ffffffffc020b38c:	7119                	addi	sp,sp,-128
ffffffffc020b38e:	f4a6                	sd	s1,104(sp)
ffffffffc020b390:	f0ca                	sd	s2,96(sp)
ffffffffc020b392:	ecce                	sd	s3,88(sp)
ffffffffc020b394:	e8d2                	sd	s4,80(sp)
ffffffffc020b396:	e4d6                	sd	s5,72(sp)
ffffffffc020b398:	e0da                	sd	s6,64(sp)
ffffffffc020b39a:	fc5e                	sd	s7,56(sp)
ffffffffc020b39c:	ec6e                	sd	s11,24(sp)
ffffffffc020b39e:	fc86                	sd	ra,120(sp)
ffffffffc020b3a0:	f8a2                	sd	s0,112(sp)
ffffffffc020b3a2:	f862                	sd	s8,48(sp)
ffffffffc020b3a4:	f466                	sd	s9,40(sp)
ffffffffc020b3a6:	f06a                	sd	s10,32(sp)
ffffffffc020b3a8:	89aa                	mv	s3,a0
ffffffffc020b3aa:	892e                	mv	s2,a1
ffffffffc020b3ac:	84b2                	mv	s1,a2
ffffffffc020b3ae:	8db6                	mv	s11,a3
ffffffffc020b3b0:	8aba                	mv	s5,a4
ffffffffc020b3b2:	02500a13          	li	s4,37
ffffffffc020b3b6:	5bfd                	li	s7,-1
ffffffffc020b3b8:	00004b17          	auipc	s6,0x4
ffffffffc020b3bc:	264b0b13          	addi	s6,s6,612 # ffffffffc020f61c <sfs_node_fileops+0x144>
ffffffffc020b3c0:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020b3c4:	001d8413          	addi	s0,s11,1
ffffffffc020b3c8:	01450b63          	beq	a0,s4,ffffffffc020b3de <vprintfmt+0x52>
ffffffffc020b3cc:	c129                	beqz	a0,ffffffffc020b40e <vprintfmt+0x82>
ffffffffc020b3ce:	864a                	mv	a2,s2
ffffffffc020b3d0:	85a6                	mv	a1,s1
ffffffffc020b3d2:	0405                	addi	s0,s0,1
ffffffffc020b3d4:	9982                	jalr	s3
ffffffffc020b3d6:	fff44503          	lbu	a0,-1(s0)
ffffffffc020b3da:	ff4519e3          	bne	a0,s4,ffffffffc020b3cc <vprintfmt+0x40>
ffffffffc020b3de:	00044583          	lbu	a1,0(s0)
ffffffffc020b3e2:	02000813          	li	a6,32
ffffffffc020b3e6:	4d01                	li	s10,0
ffffffffc020b3e8:	4301                	li	t1,0
ffffffffc020b3ea:	5cfd                	li	s9,-1
ffffffffc020b3ec:	5c7d                	li	s8,-1
ffffffffc020b3ee:	05500513          	li	a0,85
ffffffffc020b3f2:	48a5                	li	a7,9
ffffffffc020b3f4:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b3f8:	0ff67613          	zext.b	a2,a2
ffffffffc020b3fc:	00140d93          	addi	s11,s0,1
ffffffffc020b400:	04c56263          	bltu	a0,a2,ffffffffc020b444 <vprintfmt+0xb8>
ffffffffc020b404:	060a                	slli	a2,a2,0x2
ffffffffc020b406:	965a                	add	a2,a2,s6
ffffffffc020b408:	4214                	lw	a3,0(a2)
ffffffffc020b40a:	96da                	add	a3,a3,s6
ffffffffc020b40c:	8682                	jr	a3
ffffffffc020b40e:	70e6                	ld	ra,120(sp)
ffffffffc020b410:	7446                	ld	s0,112(sp)
ffffffffc020b412:	74a6                	ld	s1,104(sp)
ffffffffc020b414:	7906                	ld	s2,96(sp)
ffffffffc020b416:	69e6                	ld	s3,88(sp)
ffffffffc020b418:	6a46                	ld	s4,80(sp)
ffffffffc020b41a:	6aa6                	ld	s5,72(sp)
ffffffffc020b41c:	6b06                	ld	s6,64(sp)
ffffffffc020b41e:	7be2                	ld	s7,56(sp)
ffffffffc020b420:	7c42                	ld	s8,48(sp)
ffffffffc020b422:	7ca2                	ld	s9,40(sp)
ffffffffc020b424:	7d02                	ld	s10,32(sp)
ffffffffc020b426:	6de2                	ld	s11,24(sp)
ffffffffc020b428:	6109                	addi	sp,sp,128
ffffffffc020b42a:	8082                	ret
ffffffffc020b42c:	882e                	mv	a6,a1
ffffffffc020b42e:	00144583          	lbu	a1,1(s0)
ffffffffc020b432:	846e                	mv	s0,s11
ffffffffc020b434:	00140d93          	addi	s11,s0,1
ffffffffc020b438:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b43c:	0ff67613          	zext.b	a2,a2
ffffffffc020b440:	fcc572e3          	bgeu	a0,a2,ffffffffc020b404 <vprintfmt+0x78>
ffffffffc020b444:	864a                	mv	a2,s2
ffffffffc020b446:	85a6                	mv	a1,s1
ffffffffc020b448:	02500513          	li	a0,37
ffffffffc020b44c:	9982                	jalr	s3
ffffffffc020b44e:	fff44783          	lbu	a5,-1(s0)
ffffffffc020b452:	8da2                	mv	s11,s0
ffffffffc020b454:	f74786e3          	beq	a5,s4,ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b458:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020b45c:	1dfd                	addi	s11,s11,-1
ffffffffc020b45e:	ff479de3          	bne	a5,s4,ffffffffc020b458 <vprintfmt+0xcc>
ffffffffc020b462:	bfb9                	j	ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b464:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b468:	00144583          	lbu	a1,1(s0)
ffffffffc020b46c:	846e                	mv	s0,s11
ffffffffc020b46e:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b472:	0005861b          	sext.w	a2,a1
ffffffffc020b476:	02d8e463          	bltu	a7,a3,ffffffffc020b49e <vprintfmt+0x112>
ffffffffc020b47a:	00144583          	lbu	a1,1(s0)
ffffffffc020b47e:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b482:	0196873b          	addw	a4,a3,s9
ffffffffc020b486:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b48a:	9f31                	addw	a4,a4,a2
ffffffffc020b48c:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b490:	0405                	addi	s0,s0,1
ffffffffc020b492:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b496:	0005861b          	sext.w	a2,a1
ffffffffc020b49a:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b47a <vprintfmt+0xee>
ffffffffc020b49e:	f40c5be3          	bgez	s8,ffffffffc020b3f4 <vprintfmt+0x68>
ffffffffc020b4a2:	8c66                	mv	s8,s9
ffffffffc020b4a4:	5cfd                	li	s9,-1
ffffffffc020b4a6:	b7b9                	j	ffffffffc020b3f4 <vprintfmt+0x68>
ffffffffc020b4a8:	fffc4693          	not	a3,s8
ffffffffc020b4ac:	96fd                	srai	a3,a3,0x3f
ffffffffc020b4ae:	00dc77b3          	and	a5,s8,a3
ffffffffc020b4b2:	00144583          	lbu	a1,1(s0)
ffffffffc020b4b6:	00078c1b          	sext.w	s8,a5
ffffffffc020b4ba:	846e                	mv	s0,s11
ffffffffc020b4bc:	bf25                	j	ffffffffc020b3f4 <vprintfmt+0x68>
ffffffffc020b4be:	000aac83          	lw	s9,0(s5)
ffffffffc020b4c2:	00144583          	lbu	a1,1(s0)
ffffffffc020b4c6:	0aa1                	addi	s5,s5,8
ffffffffc020b4c8:	846e                	mv	s0,s11
ffffffffc020b4ca:	bfd1                	j	ffffffffc020b49e <vprintfmt+0x112>
ffffffffc020b4cc:	4705                	li	a4,1
ffffffffc020b4ce:	008a8613          	addi	a2,s5,8
ffffffffc020b4d2:	00674463          	blt	a4,t1,ffffffffc020b4da <vprintfmt+0x14e>
ffffffffc020b4d6:	1c030c63          	beqz	t1,ffffffffc020b6ae <vprintfmt+0x322>
ffffffffc020b4da:	000ab683          	ld	a3,0(s5)
ffffffffc020b4de:	4741                	li	a4,16
ffffffffc020b4e0:	8ab2                	mv	s5,a2
ffffffffc020b4e2:	2801                	sext.w	a6,a6
ffffffffc020b4e4:	87e2                	mv	a5,s8
ffffffffc020b4e6:	8626                	mv	a2,s1
ffffffffc020b4e8:	85ca                	mv	a1,s2
ffffffffc020b4ea:	854e                	mv	a0,s3
ffffffffc020b4ec:	e11ff0ef          	jal	ra,ffffffffc020b2fc <printnum>
ffffffffc020b4f0:	bdc1                	j	ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b4f2:	000aa503          	lw	a0,0(s5)
ffffffffc020b4f6:	864a                	mv	a2,s2
ffffffffc020b4f8:	85a6                	mv	a1,s1
ffffffffc020b4fa:	0aa1                	addi	s5,s5,8
ffffffffc020b4fc:	9982                	jalr	s3
ffffffffc020b4fe:	b5c9                	j	ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b500:	4705                	li	a4,1
ffffffffc020b502:	008a8613          	addi	a2,s5,8
ffffffffc020b506:	00674463          	blt	a4,t1,ffffffffc020b50e <vprintfmt+0x182>
ffffffffc020b50a:	18030d63          	beqz	t1,ffffffffc020b6a4 <vprintfmt+0x318>
ffffffffc020b50e:	000ab683          	ld	a3,0(s5)
ffffffffc020b512:	4729                	li	a4,10
ffffffffc020b514:	8ab2                	mv	s5,a2
ffffffffc020b516:	b7f1                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b518:	00144583          	lbu	a1,1(s0)
ffffffffc020b51c:	4d05                	li	s10,1
ffffffffc020b51e:	846e                	mv	s0,s11
ffffffffc020b520:	bdd1                	j	ffffffffc020b3f4 <vprintfmt+0x68>
ffffffffc020b522:	864a                	mv	a2,s2
ffffffffc020b524:	85a6                	mv	a1,s1
ffffffffc020b526:	02500513          	li	a0,37
ffffffffc020b52a:	9982                	jalr	s3
ffffffffc020b52c:	bd51                	j	ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b52e:	00144583          	lbu	a1,1(s0)
ffffffffc020b532:	2305                	addiw	t1,t1,1
ffffffffc020b534:	846e                	mv	s0,s11
ffffffffc020b536:	bd7d                	j	ffffffffc020b3f4 <vprintfmt+0x68>
ffffffffc020b538:	4705                	li	a4,1
ffffffffc020b53a:	008a8613          	addi	a2,s5,8
ffffffffc020b53e:	00674463          	blt	a4,t1,ffffffffc020b546 <vprintfmt+0x1ba>
ffffffffc020b542:	14030c63          	beqz	t1,ffffffffc020b69a <vprintfmt+0x30e>
ffffffffc020b546:	000ab683          	ld	a3,0(s5)
ffffffffc020b54a:	4721                	li	a4,8
ffffffffc020b54c:	8ab2                	mv	s5,a2
ffffffffc020b54e:	bf51                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b550:	03000513          	li	a0,48
ffffffffc020b554:	864a                	mv	a2,s2
ffffffffc020b556:	85a6                	mv	a1,s1
ffffffffc020b558:	e042                	sd	a6,0(sp)
ffffffffc020b55a:	9982                	jalr	s3
ffffffffc020b55c:	864a                	mv	a2,s2
ffffffffc020b55e:	85a6                	mv	a1,s1
ffffffffc020b560:	07800513          	li	a0,120
ffffffffc020b564:	9982                	jalr	s3
ffffffffc020b566:	0aa1                	addi	s5,s5,8
ffffffffc020b568:	6802                	ld	a6,0(sp)
ffffffffc020b56a:	4741                	li	a4,16
ffffffffc020b56c:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b570:	bf8d                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b572:	000ab403          	ld	s0,0(s5)
ffffffffc020b576:	008a8793          	addi	a5,s5,8
ffffffffc020b57a:	e03e                	sd	a5,0(sp)
ffffffffc020b57c:	14040c63          	beqz	s0,ffffffffc020b6d4 <vprintfmt+0x348>
ffffffffc020b580:	11805063          	blez	s8,ffffffffc020b680 <vprintfmt+0x2f4>
ffffffffc020b584:	02d00693          	li	a3,45
ffffffffc020b588:	0cd81963          	bne	a6,a3,ffffffffc020b65a <vprintfmt+0x2ce>
ffffffffc020b58c:	00044683          	lbu	a3,0(s0)
ffffffffc020b590:	0006851b          	sext.w	a0,a3
ffffffffc020b594:	ce8d                	beqz	a3,ffffffffc020b5ce <vprintfmt+0x242>
ffffffffc020b596:	00140a93          	addi	s5,s0,1
ffffffffc020b59a:	05e00413          	li	s0,94
ffffffffc020b59e:	000cc563          	bltz	s9,ffffffffc020b5a8 <vprintfmt+0x21c>
ffffffffc020b5a2:	3cfd                	addiw	s9,s9,-1
ffffffffc020b5a4:	037c8363          	beq	s9,s7,ffffffffc020b5ca <vprintfmt+0x23e>
ffffffffc020b5a8:	864a                	mv	a2,s2
ffffffffc020b5aa:	85a6                	mv	a1,s1
ffffffffc020b5ac:	100d0663          	beqz	s10,ffffffffc020b6b8 <vprintfmt+0x32c>
ffffffffc020b5b0:	3681                	addiw	a3,a3,-32
ffffffffc020b5b2:	10d47363          	bgeu	s0,a3,ffffffffc020b6b8 <vprintfmt+0x32c>
ffffffffc020b5b6:	03f00513          	li	a0,63
ffffffffc020b5ba:	9982                	jalr	s3
ffffffffc020b5bc:	000ac683          	lbu	a3,0(s5)
ffffffffc020b5c0:	3c7d                	addiw	s8,s8,-1
ffffffffc020b5c2:	0a85                	addi	s5,s5,1
ffffffffc020b5c4:	0006851b          	sext.w	a0,a3
ffffffffc020b5c8:	faf9                	bnez	a3,ffffffffc020b59e <vprintfmt+0x212>
ffffffffc020b5ca:	01805a63          	blez	s8,ffffffffc020b5de <vprintfmt+0x252>
ffffffffc020b5ce:	3c7d                	addiw	s8,s8,-1
ffffffffc020b5d0:	864a                	mv	a2,s2
ffffffffc020b5d2:	85a6                	mv	a1,s1
ffffffffc020b5d4:	02000513          	li	a0,32
ffffffffc020b5d8:	9982                	jalr	s3
ffffffffc020b5da:	fe0c1ae3          	bnez	s8,ffffffffc020b5ce <vprintfmt+0x242>
ffffffffc020b5de:	6a82                	ld	s5,0(sp)
ffffffffc020b5e0:	b3c5                	j	ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b5e2:	4705                	li	a4,1
ffffffffc020b5e4:	008a8d13          	addi	s10,s5,8
ffffffffc020b5e8:	00674463          	blt	a4,t1,ffffffffc020b5f0 <vprintfmt+0x264>
ffffffffc020b5ec:	0a030463          	beqz	t1,ffffffffc020b694 <vprintfmt+0x308>
ffffffffc020b5f0:	000ab403          	ld	s0,0(s5)
ffffffffc020b5f4:	0c044463          	bltz	s0,ffffffffc020b6bc <vprintfmt+0x330>
ffffffffc020b5f8:	86a2                	mv	a3,s0
ffffffffc020b5fa:	8aea                	mv	s5,s10
ffffffffc020b5fc:	4729                	li	a4,10
ffffffffc020b5fe:	b5d5                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b600:	000aa783          	lw	a5,0(s5)
ffffffffc020b604:	46e1                	li	a3,24
ffffffffc020b606:	0aa1                	addi	s5,s5,8
ffffffffc020b608:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b60c:	8fb9                	xor	a5,a5,a4
ffffffffc020b60e:	40e7873b          	subw	a4,a5,a4
ffffffffc020b612:	02e6c663          	blt	a3,a4,ffffffffc020b63e <vprintfmt+0x2b2>
ffffffffc020b616:	00371793          	slli	a5,a4,0x3
ffffffffc020b61a:	00004697          	auipc	a3,0x4
ffffffffc020b61e:	33668693          	addi	a3,a3,822 # ffffffffc020f950 <error_string>
ffffffffc020b622:	97b6                	add	a5,a5,a3
ffffffffc020b624:	639c                	ld	a5,0(a5)
ffffffffc020b626:	cf81                	beqz	a5,ffffffffc020b63e <vprintfmt+0x2b2>
ffffffffc020b628:	873e                	mv	a4,a5
ffffffffc020b62a:	00000697          	auipc	a3,0x0
ffffffffc020b62e:	28668693          	addi	a3,a3,646 # ffffffffc020b8b0 <etext+0x2c>
ffffffffc020b632:	8626                	mv	a2,s1
ffffffffc020b634:	85ca                	mv	a1,s2
ffffffffc020b636:	854e                	mv	a0,s3
ffffffffc020b638:	0d4000ef          	jal	ra,ffffffffc020b70c <printfmt>
ffffffffc020b63c:	b351                	j	ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b63e:	00004697          	auipc	a3,0x4
ffffffffc020b642:	fd268693          	addi	a3,a3,-46 # ffffffffc020f610 <sfs_node_fileops+0x138>
ffffffffc020b646:	8626                	mv	a2,s1
ffffffffc020b648:	85ca                	mv	a1,s2
ffffffffc020b64a:	854e                	mv	a0,s3
ffffffffc020b64c:	0c0000ef          	jal	ra,ffffffffc020b70c <printfmt>
ffffffffc020b650:	bb85                	j	ffffffffc020b3c0 <vprintfmt+0x34>
ffffffffc020b652:	00004417          	auipc	s0,0x4
ffffffffc020b656:	fb640413          	addi	s0,s0,-74 # ffffffffc020f608 <sfs_node_fileops+0x130>
ffffffffc020b65a:	85e6                	mv	a1,s9
ffffffffc020b65c:	8522                	mv	a0,s0
ffffffffc020b65e:	e442                	sd	a6,8(sp)
ffffffffc020b660:	132000ef          	jal	ra,ffffffffc020b792 <strnlen>
ffffffffc020b664:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b668:	01805c63          	blez	s8,ffffffffc020b680 <vprintfmt+0x2f4>
ffffffffc020b66c:	6822                	ld	a6,8(sp)
ffffffffc020b66e:	00080a9b          	sext.w	s5,a6
ffffffffc020b672:	3c7d                	addiw	s8,s8,-1
ffffffffc020b674:	864a                	mv	a2,s2
ffffffffc020b676:	85a6                	mv	a1,s1
ffffffffc020b678:	8556                	mv	a0,s5
ffffffffc020b67a:	9982                	jalr	s3
ffffffffc020b67c:	fe0c1be3          	bnez	s8,ffffffffc020b672 <vprintfmt+0x2e6>
ffffffffc020b680:	00044683          	lbu	a3,0(s0)
ffffffffc020b684:	00140a93          	addi	s5,s0,1
ffffffffc020b688:	0006851b          	sext.w	a0,a3
ffffffffc020b68c:	daa9                	beqz	a3,ffffffffc020b5de <vprintfmt+0x252>
ffffffffc020b68e:	05e00413          	li	s0,94
ffffffffc020b692:	b731                	j	ffffffffc020b59e <vprintfmt+0x212>
ffffffffc020b694:	000aa403          	lw	s0,0(s5)
ffffffffc020b698:	bfb1                	j	ffffffffc020b5f4 <vprintfmt+0x268>
ffffffffc020b69a:	000ae683          	lwu	a3,0(s5)
ffffffffc020b69e:	4721                	li	a4,8
ffffffffc020b6a0:	8ab2                	mv	s5,a2
ffffffffc020b6a2:	b581                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b6a4:	000ae683          	lwu	a3,0(s5)
ffffffffc020b6a8:	4729                	li	a4,10
ffffffffc020b6aa:	8ab2                	mv	s5,a2
ffffffffc020b6ac:	bd1d                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b6ae:	000ae683          	lwu	a3,0(s5)
ffffffffc020b6b2:	4741                	li	a4,16
ffffffffc020b6b4:	8ab2                	mv	s5,a2
ffffffffc020b6b6:	b535                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b6b8:	9982                	jalr	s3
ffffffffc020b6ba:	b709                	j	ffffffffc020b5bc <vprintfmt+0x230>
ffffffffc020b6bc:	864a                	mv	a2,s2
ffffffffc020b6be:	85a6                	mv	a1,s1
ffffffffc020b6c0:	02d00513          	li	a0,45
ffffffffc020b6c4:	e042                	sd	a6,0(sp)
ffffffffc020b6c6:	9982                	jalr	s3
ffffffffc020b6c8:	6802                	ld	a6,0(sp)
ffffffffc020b6ca:	8aea                	mv	s5,s10
ffffffffc020b6cc:	408006b3          	neg	a3,s0
ffffffffc020b6d0:	4729                	li	a4,10
ffffffffc020b6d2:	bd01                	j	ffffffffc020b4e2 <vprintfmt+0x156>
ffffffffc020b6d4:	03805163          	blez	s8,ffffffffc020b6f6 <vprintfmt+0x36a>
ffffffffc020b6d8:	02d00693          	li	a3,45
ffffffffc020b6dc:	f6d81be3          	bne	a6,a3,ffffffffc020b652 <vprintfmt+0x2c6>
ffffffffc020b6e0:	00004417          	auipc	s0,0x4
ffffffffc020b6e4:	f2840413          	addi	s0,s0,-216 # ffffffffc020f608 <sfs_node_fileops+0x130>
ffffffffc020b6e8:	02800693          	li	a3,40
ffffffffc020b6ec:	02800513          	li	a0,40
ffffffffc020b6f0:	00140a93          	addi	s5,s0,1
ffffffffc020b6f4:	b55d                	j	ffffffffc020b59a <vprintfmt+0x20e>
ffffffffc020b6f6:	00004a97          	auipc	s5,0x4
ffffffffc020b6fa:	f13a8a93          	addi	s5,s5,-237 # ffffffffc020f609 <sfs_node_fileops+0x131>
ffffffffc020b6fe:	02800513          	li	a0,40
ffffffffc020b702:	02800693          	li	a3,40
ffffffffc020b706:	05e00413          	li	s0,94
ffffffffc020b70a:	bd51                	j	ffffffffc020b59e <vprintfmt+0x212>

ffffffffc020b70c <printfmt>:
ffffffffc020b70c:	7139                	addi	sp,sp,-64
ffffffffc020b70e:	02010313          	addi	t1,sp,32
ffffffffc020b712:	f03a                	sd	a4,32(sp)
ffffffffc020b714:	871a                	mv	a4,t1
ffffffffc020b716:	ec06                	sd	ra,24(sp)
ffffffffc020b718:	f43e                	sd	a5,40(sp)
ffffffffc020b71a:	f842                	sd	a6,48(sp)
ffffffffc020b71c:	fc46                	sd	a7,56(sp)
ffffffffc020b71e:	e41a                	sd	t1,8(sp)
ffffffffc020b720:	c6dff0ef          	jal	ra,ffffffffc020b38c <vprintfmt>
ffffffffc020b724:	60e2                	ld	ra,24(sp)
ffffffffc020b726:	6121                	addi	sp,sp,64
ffffffffc020b728:	8082                	ret

ffffffffc020b72a <snprintf>:
ffffffffc020b72a:	711d                	addi	sp,sp,-96
ffffffffc020b72c:	15fd                	addi	a1,a1,-1
ffffffffc020b72e:	03810313          	addi	t1,sp,56
ffffffffc020b732:	95aa                	add	a1,a1,a0
ffffffffc020b734:	f406                	sd	ra,40(sp)
ffffffffc020b736:	fc36                	sd	a3,56(sp)
ffffffffc020b738:	e0ba                	sd	a4,64(sp)
ffffffffc020b73a:	e4be                	sd	a5,72(sp)
ffffffffc020b73c:	e8c2                	sd	a6,80(sp)
ffffffffc020b73e:	ecc6                	sd	a7,88(sp)
ffffffffc020b740:	e01a                	sd	t1,0(sp)
ffffffffc020b742:	e42a                	sd	a0,8(sp)
ffffffffc020b744:	e82e                	sd	a1,16(sp)
ffffffffc020b746:	cc02                	sw	zero,24(sp)
ffffffffc020b748:	c515                	beqz	a0,ffffffffc020b774 <snprintf+0x4a>
ffffffffc020b74a:	02a5e563          	bltu	a1,a0,ffffffffc020b774 <snprintf+0x4a>
ffffffffc020b74e:	75dd                	lui	a1,0xffff7
ffffffffc020b750:	86b2                	mv	a3,a2
ffffffffc020b752:	00000517          	auipc	a0,0x0
ffffffffc020b756:	c2050513          	addi	a0,a0,-992 # ffffffffc020b372 <sprintputch>
ffffffffc020b75a:	871a                	mv	a4,t1
ffffffffc020b75c:	0030                	addi	a2,sp,8
ffffffffc020b75e:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b762:	c2bff0ef          	jal	ra,ffffffffc020b38c <vprintfmt>
ffffffffc020b766:	67a2                	ld	a5,8(sp)
ffffffffc020b768:	00078023          	sb	zero,0(a5)
ffffffffc020b76c:	4562                	lw	a0,24(sp)
ffffffffc020b76e:	70a2                	ld	ra,40(sp)
ffffffffc020b770:	6125                	addi	sp,sp,96
ffffffffc020b772:	8082                	ret
ffffffffc020b774:	5575                	li	a0,-3
ffffffffc020b776:	bfe5                	j	ffffffffc020b76e <snprintf+0x44>

ffffffffc020b778 <strlen>:
ffffffffc020b778:	00054783          	lbu	a5,0(a0)
ffffffffc020b77c:	872a                	mv	a4,a0
ffffffffc020b77e:	4501                	li	a0,0
ffffffffc020b780:	cb81                	beqz	a5,ffffffffc020b790 <strlen+0x18>
ffffffffc020b782:	0505                	addi	a0,a0,1
ffffffffc020b784:	00a707b3          	add	a5,a4,a0
ffffffffc020b788:	0007c783          	lbu	a5,0(a5)
ffffffffc020b78c:	fbfd                	bnez	a5,ffffffffc020b782 <strlen+0xa>
ffffffffc020b78e:	8082                	ret
ffffffffc020b790:	8082                	ret

ffffffffc020b792 <strnlen>:
ffffffffc020b792:	4781                	li	a5,0
ffffffffc020b794:	e589                	bnez	a1,ffffffffc020b79e <strnlen+0xc>
ffffffffc020b796:	a811                	j	ffffffffc020b7aa <strnlen+0x18>
ffffffffc020b798:	0785                	addi	a5,a5,1
ffffffffc020b79a:	00f58863          	beq	a1,a5,ffffffffc020b7aa <strnlen+0x18>
ffffffffc020b79e:	00f50733          	add	a4,a0,a5
ffffffffc020b7a2:	00074703          	lbu	a4,0(a4)
ffffffffc020b7a6:	fb6d                	bnez	a4,ffffffffc020b798 <strnlen+0x6>
ffffffffc020b7a8:	85be                	mv	a1,a5
ffffffffc020b7aa:	852e                	mv	a0,a1
ffffffffc020b7ac:	8082                	ret

ffffffffc020b7ae <strcpy>:
ffffffffc020b7ae:	87aa                	mv	a5,a0
ffffffffc020b7b0:	0005c703          	lbu	a4,0(a1)
ffffffffc020b7b4:	0785                	addi	a5,a5,1
ffffffffc020b7b6:	0585                	addi	a1,a1,1
ffffffffc020b7b8:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b7bc:	fb75                	bnez	a4,ffffffffc020b7b0 <strcpy+0x2>
ffffffffc020b7be:	8082                	ret

ffffffffc020b7c0 <strcmp>:
ffffffffc020b7c0:	00054783          	lbu	a5,0(a0)
ffffffffc020b7c4:	0005c703          	lbu	a4,0(a1)
ffffffffc020b7c8:	cb89                	beqz	a5,ffffffffc020b7da <strcmp+0x1a>
ffffffffc020b7ca:	0505                	addi	a0,a0,1
ffffffffc020b7cc:	0585                	addi	a1,a1,1
ffffffffc020b7ce:	fee789e3          	beq	a5,a4,ffffffffc020b7c0 <strcmp>
ffffffffc020b7d2:	0007851b          	sext.w	a0,a5
ffffffffc020b7d6:	9d19                	subw	a0,a0,a4
ffffffffc020b7d8:	8082                	ret
ffffffffc020b7da:	4501                	li	a0,0
ffffffffc020b7dc:	bfed                	j	ffffffffc020b7d6 <strcmp+0x16>

ffffffffc020b7de <strncmp>:
ffffffffc020b7de:	c20d                	beqz	a2,ffffffffc020b800 <strncmp+0x22>
ffffffffc020b7e0:	962e                	add	a2,a2,a1
ffffffffc020b7e2:	a031                	j	ffffffffc020b7ee <strncmp+0x10>
ffffffffc020b7e4:	0505                	addi	a0,a0,1
ffffffffc020b7e6:	00e79a63          	bne	a5,a4,ffffffffc020b7fa <strncmp+0x1c>
ffffffffc020b7ea:	00b60b63          	beq	a2,a1,ffffffffc020b800 <strncmp+0x22>
ffffffffc020b7ee:	00054783          	lbu	a5,0(a0)
ffffffffc020b7f2:	0585                	addi	a1,a1,1
ffffffffc020b7f4:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b7f8:	f7f5                	bnez	a5,ffffffffc020b7e4 <strncmp+0x6>
ffffffffc020b7fa:	40e7853b          	subw	a0,a5,a4
ffffffffc020b7fe:	8082                	ret
ffffffffc020b800:	4501                	li	a0,0
ffffffffc020b802:	8082                	ret

ffffffffc020b804 <strchr>:
ffffffffc020b804:	00054783          	lbu	a5,0(a0)
ffffffffc020b808:	c799                	beqz	a5,ffffffffc020b816 <strchr+0x12>
ffffffffc020b80a:	00f58763          	beq	a1,a5,ffffffffc020b818 <strchr+0x14>
ffffffffc020b80e:	00154783          	lbu	a5,1(a0)
ffffffffc020b812:	0505                	addi	a0,a0,1
ffffffffc020b814:	fbfd                	bnez	a5,ffffffffc020b80a <strchr+0x6>
ffffffffc020b816:	4501                	li	a0,0
ffffffffc020b818:	8082                	ret

ffffffffc020b81a <memset>:
ffffffffc020b81a:	ca01                	beqz	a2,ffffffffc020b82a <memset+0x10>
ffffffffc020b81c:	962a                	add	a2,a2,a0
ffffffffc020b81e:	87aa                	mv	a5,a0
ffffffffc020b820:	0785                	addi	a5,a5,1
ffffffffc020b822:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b826:	fec79de3          	bne	a5,a2,ffffffffc020b820 <memset+0x6>
ffffffffc020b82a:	8082                	ret

ffffffffc020b82c <memmove>:
ffffffffc020b82c:	02a5f263          	bgeu	a1,a0,ffffffffc020b850 <memmove+0x24>
ffffffffc020b830:	00c587b3          	add	a5,a1,a2
ffffffffc020b834:	00f57e63          	bgeu	a0,a5,ffffffffc020b850 <memmove+0x24>
ffffffffc020b838:	00c50733          	add	a4,a0,a2
ffffffffc020b83c:	c615                	beqz	a2,ffffffffc020b868 <memmove+0x3c>
ffffffffc020b83e:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b842:	17fd                	addi	a5,a5,-1
ffffffffc020b844:	177d                	addi	a4,a4,-1
ffffffffc020b846:	00d70023          	sb	a3,0(a4)
ffffffffc020b84a:	fef59ae3          	bne	a1,a5,ffffffffc020b83e <memmove+0x12>
ffffffffc020b84e:	8082                	ret
ffffffffc020b850:	00c586b3          	add	a3,a1,a2
ffffffffc020b854:	87aa                	mv	a5,a0
ffffffffc020b856:	ca11                	beqz	a2,ffffffffc020b86a <memmove+0x3e>
ffffffffc020b858:	0005c703          	lbu	a4,0(a1)
ffffffffc020b85c:	0585                	addi	a1,a1,1
ffffffffc020b85e:	0785                	addi	a5,a5,1
ffffffffc020b860:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b864:	fed59ae3          	bne	a1,a3,ffffffffc020b858 <memmove+0x2c>
ffffffffc020b868:	8082                	ret
ffffffffc020b86a:	8082                	ret

ffffffffc020b86c <memcpy>:
ffffffffc020b86c:	ca19                	beqz	a2,ffffffffc020b882 <memcpy+0x16>
ffffffffc020b86e:	962e                	add	a2,a2,a1
ffffffffc020b870:	87aa                	mv	a5,a0
ffffffffc020b872:	0005c703          	lbu	a4,0(a1)
ffffffffc020b876:	0585                	addi	a1,a1,1
ffffffffc020b878:	0785                	addi	a5,a5,1
ffffffffc020b87a:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b87e:	fec59ae3          	bne	a1,a2,ffffffffc020b872 <memcpy+0x6>
ffffffffc020b882:	8082                	ret
