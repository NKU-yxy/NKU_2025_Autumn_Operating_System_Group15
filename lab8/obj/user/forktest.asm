
obj/__user_forktest.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	a29d                	j	80018a <sys_open>

0000000000800026 <close>:
  800026:	a2bd                	j	800194 <sys_close>

0000000000800028 <dup2>:
  800028:	aa95                	j	80019c <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	1d6000ef          	jal	ra,800208 <umain>
  800036:	a001                	j	800036 <_start+0xc>

0000000000800038 <__panic>:
  800038:	715d                	addi	sp,sp,-80
  80003a:	8e2e                	mv	t3,a1
  80003c:	e822                	sd	s0,16(sp)
  80003e:	85aa                	mv	a1,a0
  800040:	8432                	mv	s0,a2
  800042:	fc3e                	sd	a5,56(sp)
  800044:	8672                	mv	a2,t3
  800046:	103c                	addi	a5,sp,40
  800048:	00000517          	auipc	a0,0x0
  80004c:	71050513          	addi	a0,a0,1808 # 800758 <main+0xac>
  800050:	ec06                	sd	ra,24(sp)
  800052:	f436                	sd	a3,40(sp)
  800054:	f83a                	sd	a4,48(sp)
  800056:	e0c2                	sd	a6,64(sp)
  800058:	e4c6                	sd	a7,72(sp)
  80005a:	e43e                	sd	a5,8(sp)
  80005c:	0a2000ef          	jal	ra,8000fe <cprintf>
  800060:	65a2                	ld	a1,8(sp)
  800062:	8522                	mv	a0,s0
  800064:	074000ef          	jal	ra,8000d8 <vcprintf>
  800068:	00000517          	auipc	a0,0x0
  80006c:	76850513          	addi	a0,a0,1896 # 8007d0 <main+0x124>
  800070:	08e000ef          	jal	ra,8000fe <cprintf>
  800074:	5559                	li	a0,-10
  800076:	130000ef          	jal	ra,8001a6 <exit>

000000000080007a <__warn>:
  80007a:	715d                	addi	sp,sp,-80
  80007c:	832e                	mv	t1,a1
  80007e:	e822                	sd	s0,16(sp)
  800080:	85aa                	mv	a1,a0
  800082:	8432                	mv	s0,a2
  800084:	fc3e                	sd	a5,56(sp)
  800086:	861a                	mv	a2,t1
  800088:	103c                	addi	a5,sp,40
  80008a:	00000517          	auipc	a0,0x0
  80008e:	6ee50513          	addi	a0,a0,1774 # 800778 <main+0xcc>
  800092:	ec06                	sd	ra,24(sp)
  800094:	f436                	sd	a3,40(sp)
  800096:	f83a                	sd	a4,48(sp)
  800098:	e0c2                	sd	a6,64(sp)
  80009a:	e4c6                	sd	a7,72(sp)
  80009c:	e43e                	sd	a5,8(sp)
  80009e:	060000ef          	jal	ra,8000fe <cprintf>
  8000a2:	65a2                	ld	a1,8(sp)
  8000a4:	8522                	mv	a0,s0
  8000a6:	032000ef          	jal	ra,8000d8 <vcprintf>
  8000aa:	00000517          	auipc	a0,0x0
  8000ae:	72650513          	addi	a0,a0,1830 # 8007d0 <main+0x124>
  8000b2:	04c000ef          	jal	ra,8000fe <cprintf>
  8000b6:	60e2                	ld	ra,24(sp)
  8000b8:	6442                	ld	s0,16(sp)
  8000ba:	6161                	addi	sp,sp,80
  8000bc:	8082                	ret

00000000008000be <cputch>:
  8000be:	1141                	addi	sp,sp,-16
  8000c0:	e022                	sd	s0,0(sp)
  8000c2:	e406                	sd	ra,8(sp)
  8000c4:	842e                	mv	s0,a1
  8000c6:	0be000ef          	jal	ra,800184 <sys_putc>
  8000ca:	401c                	lw	a5,0(s0)
  8000cc:	60a2                	ld	ra,8(sp)
  8000ce:	2785                	addiw	a5,a5,1
  8000d0:	c01c                	sw	a5,0(s0)
  8000d2:	6402                	ld	s0,0(sp)
  8000d4:	0141                	addi	sp,sp,16
  8000d6:	8082                	ret

00000000008000d8 <vcprintf>:
  8000d8:	1101                	addi	sp,sp,-32
  8000da:	872e                	mv	a4,a1
  8000dc:	75dd                	lui	a1,0xffff7
  8000de:	86aa                	mv	a3,a0
  8000e0:	0070                	addi	a2,sp,12
  8000e2:	00000517          	auipc	a0,0x0
  8000e6:	fdc50513          	addi	a0,a0,-36 # 8000be <cputch>
  8000ea:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <__global_pointer$+0xffffffffff7f52d9>
  8000ee:	ec06                	sd	ra,24(sp)
  8000f0:	c602                	sw	zero,12(sp)
  8000f2:	200000ef          	jal	ra,8002f2 <vprintfmt>
  8000f6:	60e2                	ld	ra,24(sp)
  8000f8:	4532                	lw	a0,12(sp)
  8000fa:	6105                	addi	sp,sp,32
  8000fc:	8082                	ret

00000000008000fe <cprintf>:
  8000fe:	711d                	addi	sp,sp,-96
  800100:	02810313          	addi	t1,sp,40
  800104:	8e2a                	mv	t3,a0
  800106:	f42e                	sd	a1,40(sp)
  800108:	75dd                	lui	a1,0xffff7
  80010a:	f832                	sd	a2,48(sp)
  80010c:	fc36                	sd	a3,56(sp)
  80010e:	e0ba                	sd	a4,64(sp)
  800110:	00000517          	auipc	a0,0x0
  800114:	fae50513          	addi	a0,a0,-82 # 8000be <cputch>
  800118:	0050                	addi	a2,sp,4
  80011a:	871a                	mv	a4,t1
  80011c:	86f2                	mv	a3,t3
  80011e:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <__global_pointer$+0xffffffffff7f52d9>
  800122:	ec06                	sd	ra,24(sp)
  800124:	e4be                	sd	a5,72(sp)
  800126:	e8c2                	sd	a6,80(sp)
  800128:	ecc6                	sd	a7,88(sp)
  80012a:	e41a                	sd	t1,8(sp)
  80012c:	c202                	sw	zero,4(sp)
  80012e:	1c4000ef          	jal	ra,8002f2 <vprintfmt>
  800132:	60e2                	ld	ra,24(sp)
  800134:	4512                	lw	a0,4(sp)
  800136:	6125                	addi	sp,sp,96
  800138:	8082                	ret

000000000080013a <syscall>:
  80013a:	7175                	addi	sp,sp,-144
  80013c:	f8ba                	sd	a4,112(sp)
  80013e:	e0ba                	sd	a4,64(sp)
  800140:	0118                	addi	a4,sp,128
  800142:	e42a                	sd	a0,8(sp)
  800144:	ecae                	sd	a1,88(sp)
  800146:	f0b2                	sd	a2,96(sp)
  800148:	f4b6                	sd	a3,104(sp)
  80014a:	fcbe                	sd	a5,120(sp)
  80014c:	e142                	sd	a6,128(sp)
  80014e:	e546                	sd	a7,136(sp)
  800150:	f42e                	sd	a1,40(sp)
  800152:	f832                	sd	a2,48(sp)
  800154:	fc36                	sd	a3,56(sp)
  800156:	f03a                	sd	a4,32(sp)
  800158:	e4be                	sd	a5,72(sp)
  80015a:	4522                	lw	a0,8(sp)
  80015c:	55a2                	lw	a1,40(sp)
  80015e:	5642                	lw	a2,48(sp)
  800160:	56e2                	lw	a3,56(sp)
  800162:	4706                	lw	a4,64(sp)
  800164:	47a6                	lw	a5,72(sp)
  800166:	00000073          	ecall
  80016a:	ce2a                	sw	a0,28(sp)
  80016c:	4572                	lw	a0,28(sp)
  80016e:	6149                	addi	sp,sp,144
  800170:	8082                	ret

0000000000800172 <sys_exit>:
  800172:	85aa                	mv	a1,a0
  800174:	4505                	li	a0,1
  800176:	b7d1                	j	80013a <syscall>

0000000000800178 <sys_fork>:
  800178:	4509                	li	a0,2
  80017a:	b7c1                	j	80013a <syscall>

000000000080017c <sys_wait>:
  80017c:	862e                	mv	a2,a1
  80017e:	85aa                	mv	a1,a0
  800180:	450d                	li	a0,3
  800182:	bf65                	j	80013a <syscall>

0000000000800184 <sys_putc>:
  800184:	85aa                	mv	a1,a0
  800186:	4579                	li	a0,30
  800188:	bf4d                	j	80013a <syscall>

000000000080018a <sys_open>:
  80018a:	862e                	mv	a2,a1
  80018c:	85aa                	mv	a1,a0
  80018e:	06400513          	li	a0,100
  800192:	b765                	j	80013a <syscall>

0000000000800194 <sys_close>:
  800194:	85aa                	mv	a1,a0
  800196:	06500513          	li	a0,101
  80019a:	b745                	j	80013a <syscall>

000000000080019c <sys_dup>:
  80019c:	862e                	mv	a2,a1
  80019e:	85aa                	mv	a1,a0
  8001a0:	08200513          	li	a0,130
  8001a4:	bf59                	j	80013a <syscall>

00000000008001a6 <exit>:
  8001a6:	1141                	addi	sp,sp,-16
  8001a8:	e406                	sd	ra,8(sp)
  8001aa:	fc9ff0ef          	jal	ra,800172 <sys_exit>
  8001ae:	00000517          	auipc	a0,0x0
  8001b2:	5ea50513          	addi	a0,a0,1514 # 800798 <main+0xec>
  8001b6:	f49ff0ef          	jal	ra,8000fe <cprintf>
  8001ba:	a001                	j	8001ba <exit+0x14>

00000000008001bc <fork>:
  8001bc:	bf75                	j	800178 <sys_fork>

00000000008001be <wait>:
  8001be:	4581                	li	a1,0
  8001c0:	4501                	li	a0,0
  8001c2:	bf6d                	j	80017c <sys_wait>

00000000008001c4 <initfd>:
  8001c4:	1101                	addi	sp,sp,-32
  8001c6:	87ae                	mv	a5,a1
  8001c8:	e426                	sd	s1,8(sp)
  8001ca:	85b2                	mv	a1,a2
  8001cc:	84aa                	mv	s1,a0
  8001ce:	853e                	mv	a0,a5
  8001d0:	e822                	sd	s0,16(sp)
  8001d2:	ec06                	sd	ra,24(sp)
  8001d4:	e4dff0ef          	jal	ra,800020 <open>
  8001d8:	842a                	mv	s0,a0
  8001da:	00054463          	bltz	a0,8001e2 <initfd+0x1e>
  8001de:	00951863          	bne	a0,s1,8001ee <initfd+0x2a>
  8001e2:	60e2                	ld	ra,24(sp)
  8001e4:	8522                	mv	a0,s0
  8001e6:	6442                	ld	s0,16(sp)
  8001e8:	64a2                	ld	s1,8(sp)
  8001ea:	6105                	addi	sp,sp,32
  8001ec:	8082                	ret
  8001ee:	8526                	mv	a0,s1
  8001f0:	e37ff0ef          	jal	ra,800026 <close>
  8001f4:	85a6                	mv	a1,s1
  8001f6:	8522                	mv	a0,s0
  8001f8:	e31ff0ef          	jal	ra,800028 <dup2>
  8001fc:	84aa                	mv	s1,a0
  8001fe:	8522                	mv	a0,s0
  800200:	e27ff0ef          	jal	ra,800026 <close>
  800204:	8426                	mv	s0,s1
  800206:	bff1                	j	8001e2 <initfd+0x1e>

0000000000800208 <umain>:
  800208:	1101                	addi	sp,sp,-32
  80020a:	e822                	sd	s0,16(sp)
  80020c:	e426                	sd	s1,8(sp)
  80020e:	842a                	mv	s0,a0
  800210:	84ae                	mv	s1,a1
  800212:	4601                	li	a2,0
  800214:	00000597          	auipc	a1,0x0
  800218:	59c58593          	addi	a1,a1,1436 # 8007b0 <main+0x104>
  80021c:	4501                	li	a0,0
  80021e:	ec06                	sd	ra,24(sp)
  800220:	fa5ff0ef          	jal	ra,8001c4 <initfd>
  800224:	02054263          	bltz	a0,800248 <umain+0x40>
  800228:	4605                	li	a2,1
  80022a:	00000597          	auipc	a1,0x0
  80022e:	5c658593          	addi	a1,a1,1478 # 8007f0 <main+0x144>
  800232:	4505                	li	a0,1
  800234:	f91ff0ef          	jal	ra,8001c4 <initfd>
  800238:	02054563          	bltz	a0,800262 <umain+0x5a>
  80023c:	85a6                	mv	a1,s1
  80023e:	8522                	mv	a0,s0
  800240:	46c000ef          	jal	ra,8006ac <main>
  800244:	f63ff0ef          	jal	ra,8001a6 <exit>
  800248:	86aa                	mv	a3,a0
  80024a:	00000617          	auipc	a2,0x0
  80024e:	56e60613          	addi	a2,a2,1390 # 8007b8 <main+0x10c>
  800252:	45e9                	li	a1,26
  800254:	00000517          	auipc	a0,0x0
  800258:	58450513          	addi	a0,a0,1412 # 8007d8 <main+0x12c>
  80025c:	e1fff0ef          	jal	ra,80007a <__warn>
  800260:	b7e1                	j	800228 <umain+0x20>
  800262:	86aa                	mv	a3,a0
  800264:	00000617          	auipc	a2,0x0
  800268:	59460613          	addi	a2,a2,1428 # 8007f8 <main+0x14c>
  80026c:	45f5                	li	a1,29
  80026e:	00000517          	auipc	a0,0x0
  800272:	56a50513          	addi	a0,a0,1386 # 8007d8 <main+0x12c>
  800276:	e05ff0ef          	jal	ra,80007a <__warn>
  80027a:	b7c9                	j	80023c <umain+0x34>

000000000080027c <printnum>:
  80027c:	02071893          	slli	a7,a4,0x20
  800280:	7139                	addi	sp,sp,-64
  800282:	0208d893          	srli	a7,a7,0x20
  800286:	e456                	sd	s5,8(sp)
  800288:	0316fab3          	remu	s5,a3,a7
  80028c:	f822                	sd	s0,48(sp)
  80028e:	f426                	sd	s1,40(sp)
  800290:	f04a                	sd	s2,32(sp)
  800292:	ec4e                	sd	s3,24(sp)
  800294:	fc06                	sd	ra,56(sp)
  800296:	e852                	sd	s4,16(sp)
  800298:	84aa                	mv	s1,a0
  80029a:	89ae                	mv	s3,a1
  80029c:	8932                	mv	s2,a2
  80029e:	fff7841b          	addiw	s0,a5,-1
  8002a2:	2a81                	sext.w	s5,s5
  8002a4:	0516f163          	bgeu	a3,a7,8002e6 <printnum+0x6a>
  8002a8:	8a42                	mv	s4,a6
  8002aa:	00805863          	blez	s0,8002ba <printnum+0x3e>
  8002ae:	347d                	addiw	s0,s0,-1
  8002b0:	864e                	mv	a2,s3
  8002b2:	85ca                	mv	a1,s2
  8002b4:	8552                	mv	a0,s4
  8002b6:	9482                	jalr	s1
  8002b8:	f87d                	bnez	s0,8002ae <printnum+0x32>
  8002ba:	1a82                	slli	s5,s5,0x20
  8002bc:	00000797          	auipc	a5,0x0
  8002c0:	55c78793          	addi	a5,a5,1372 # 800818 <main+0x16c>
  8002c4:	020ada93          	srli	s5,s5,0x20
  8002c8:	9abe                	add	s5,s5,a5
  8002ca:	7442                	ld	s0,48(sp)
  8002cc:	000ac503          	lbu	a0,0(s5)
  8002d0:	70e2                	ld	ra,56(sp)
  8002d2:	6a42                	ld	s4,16(sp)
  8002d4:	6aa2                	ld	s5,8(sp)
  8002d6:	864e                	mv	a2,s3
  8002d8:	85ca                	mv	a1,s2
  8002da:	69e2                	ld	s3,24(sp)
  8002dc:	7902                	ld	s2,32(sp)
  8002de:	87a6                	mv	a5,s1
  8002e0:	74a2                	ld	s1,40(sp)
  8002e2:	6121                	addi	sp,sp,64
  8002e4:	8782                	jr	a5
  8002e6:	0316d6b3          	divu	a3,a3,a7
  8002ea:	87a2                	mv	a5,s0
  8002ec:	f91ff0ef          	jal	ra,80027c <printnum>
  8002f0:	b7e9                	j	8002ba <printnum+0x3e>

00000000008002f2 <vprintfmt>:
  8002f2:	7119                	addi	sp,sp,-128
  8002f4:	f4a6                	sd	s1,104(sp)
  8002f6:	f0ca                	sd	s2,96(sp)
  8002f8:	ecce                	sd	s3,88(sp)
  8002fa:	e8d2                	sd	s4,80(sp)
  8002fc:	e4d6                	sd	s5,72(sp)
  8002fe:	e0da                	sd	s6,64(sp)
  800300:	fc5e                	sd	s7,56(sp)
  800302:	ec6e                	sd	s11,24(sp)
  800304:	fc86                	sd	ra,120(sp)
  800306:	f8a2                	sd	s0,112(sp)
  800308:	f862                	sd	s8,48(sp)
  80030a:	f466                	sd	s9,40(sp)
  80030c:	f06a                	sd	s10,32(sp)
  80030e:	89aa                	mv	s3,a0
  800310:	892e                	mv	s2,a1
  800312:	84b2                	mv	s1,a2
  800314:	8db6                	mv	s11,a3
  800316:	8aba                	mv	s5,a4
  800318:	02500a13          	li	s4,37
  80031c:	5bfd                	li	s7,-1
  80031e:	00000b17          	auipc	s6,0x0
  800322:	52eb0b13          	addi	s6,s6,1326 # 80084c <main+0x1a0>
  800326:	000dc503          	lbu	a0,0(s11)
  80032a:	001d8413          	addi	s0,s11,1
  80032e:	01450b63          	beq	a0,s4,800344 <vprintfmt+0x52>
  800332:	c129                	beqz	a0,800374 <vprintfmt+0x82>
  800334:	864a                	mv	a2,s2
  800336:	85a6                	mv	a1,s1
  800338:	0405                	addi	s0,s0,1
  80033a:	9982                	jalr	s3
  80033c:	fff44503          	lbu	a0,-1(s0)
  800340:	ff4519e3          	bne	a0,s4,800332 <vprintfmt+0x40>
  800344:	00044583          	lbu	a1,0(s0)
  800348:	02000813          	li	a6,32
  80034c:	4d01                	li	s10,0
  80034e:	4301                	li	t1,0
  800350:	5cfd                	li	s9,-1
  800352:	5c7d                	li	s8,-1
  800354:	05500513          	li	a0,85
  800358:	48a5                	li	a7,9
  80035a:	fdd5861b          	addiw	a2,a1,-35
  80035e:	0ff67613          	zext.b	a2,a2
  800362:	00140d93          	addi	s11,s0,1
  800366:	04c56263          	bltu	a0,a2,8003aa <vprintfmt+0xb8>
  80036a:	060a                	slli	a2,a2,0x2
  80036c:	965a                	add	a2,a2,s6
  80036e:	4214                	lw	a3,0(a2)
  800370:	96da                	add	a3,a3,s6
  800372:	8682                	jr	a3
  800374:	70e6                	ld	ra,120(sp)
  800376:	7446                	ld	s0,112(sp)
  800378:	74a6                	ld	s1,104(sp)
  80037a:	7906                	ld	s2,96(sp)
  80037c:	69e6                	ld	s3,88(sp)
  80037e:	6a46                	ld	s4,80(sp)
  800380:	6aa6                	ld	s5,72(sp)
  800382:	6b06                	ld	s6,64(sp)
  800384:	7be2                	ld	s7,56(sp)
  800386:	7c42                	ld	s8,48(sp)
  800388:	7ca2                	ld	s9,40(sp)
  80038a:	7d02                	ld	s10,32(sp)
  80038c:	6de2                	ld	s11,24(sp)
  80038e:	6109                	addi	sp,sp,128
  800390:	8082                	ret
  800392:	882e                	mv	a6,a1
  800394:	00144583          	lbu	a1,1(s0)
  800398:	846e                	mv	s0,s11
  80039a:	00140d93          	addi	s11,s0,1
  80039e:	fdd5861b          	addiw	a2,a1,-35
  8003a2:	0ff67613          	zext.b	a2,a2
  8003a6:	fcc572e3          	bgeu	a0,a2,80036a <vprintfmt+0x78>
  8003aa:	864a                	mv	a2,s2
  8003ac:	85a6                	mv	a1,s1
  8003ae:	02500513          	li	a0,37
  8003b2:	9982                	jalr	s3
  8003b4:	fff44783          	lbu	a5,-1(s0)
  8003b8:	8da2                	mv	s11,s0
  8003ba:	f74786e3          	beq	a5,s4,800326 <vprintfmt+0x34>
  8003be:	ffedc783          	lbu	a5,-2(s11)
  8003c2:	1dfd                	addi	s11,s11,-1
  8003c4:	ff479de3          	bne	a5,s4,8003be <vprintfmt+0xcc>
  8003c8:	bfb9                	j	800326 <vprintfmt+0x34>
  8003ca:	fd058c9b          	addiw	s9,a1,-48
  8003ce:	00144583          	lbu	a1,1(s0)
  8003d2:	846e                	mv	s0,s11
  8003d4:	fd05869b          	addiw	a3,a1,-48
  8003d8:	0005861b          	sext.w	a2,a1
  8003dc:	02d8e463          	bltu	a7,a3,800404 <vprintfmt+0x112>
  8003e0:	00144583          	lbu	a1,1(s0)
  8003e4:	002c969b          	slliw	a3,s9,0x2
  8003e8:	0196873b          	addw	a4,a3,s9
  8003ec:	0017171b          	slliw	a4,a4,0x1
  8003f0:	9f31                	addw	a4,a4,a2
  8003f2:	fd05869b          	addiw	a3,a1,-48
  8003f6:	0405                	addi	s0,s0,1
  8003f8:	fd070c9b          	addiw	s9,a4,-48
  8003fc:	0005861b          	sext.w	a2,a1
  800400:	fed8f0e3          	bgeu	a7,a3,8003e0 <vprintfmt+0xee>
  800404:	f40c5be3          	bgez	s8,80035a <vprintfmt+0x68>
  800408:	8c66                	mv	s8,s9
  80040a:	5cfd                	li	s9,-1
  80040c:	b7b9                	j	80035a <vprintfmt+0x68>
  80040e:	fffc4693          	not	a3,s8
  800412:	96fd                	srai	a3,a3,0x3f
  800414:	00dc77b3          	and	a5,s8,a3
  800418:	00144583          	lbu	a1,1(s0)
  80041c:	00078c1b          	sext.w	s8,a5
  800420:	846e                	mv	s0,s11
  800422:	bf25                	j	80035a <vprintfmt+0x68>
  800424:	000aac83          	lw	s9,0(s5)
  800428:	00144583          	lbu	a1,1(s0)
  80042c:	0aa1                	addi	s5,s5,8
  80042e:	846e                	mv	s0,s11
  800430:	bfd1                	j	800404 <vprintfmt+0x112>
  800432:	4705                	li	a4,1
  800434:	008a8613          	addi	a2,s5,8
  800438:	00674463          	blt	a4,t1,800440 <vprintfmt+0x14e>
  80043c:	1c030c63          	beqz	t1,800614 <vprintfmt+0x322>
  800440:	000ab683          	ld	a3,0(s5)
  800444:	4741                	li	a4,16
  800446:	8ab2                	mv	s5,a2
  800448:	2801                	sext.w	a6,a6
  80044a:	87e2                	mv	a5,s8
  80044c:	8626                	mv	a2,s1
  80044e:	85ca                	mv	a1,s2
  800450:	854e                	mv	a0,s3
  800452:	e2bff0ef          	jal	ra,80027c <printnum>
  800456:	bdc1                	j	800326 <vprintfmt+0x34>
  800458:	000aa503          	lw	a0,0(s5)
  80045c:	864a                	mv	a2,s2
  80045e:	85a6                	mv	a1,s1
  800460:	0aa1                	addi	s5,s5,8
  800462:	9982                	jalr	s3
  800464:	b5c9                	j	800326 <vprintfmt+0x34>
  800466:	4705                	li	a4,1
  800468:	008a8613          	addi	a2,s5,8
  80046c:	00674463          	blt	a4,t1,800474 <vprintfmt+0x182>
  800470:	18030d63          	beqz	t1,80060a <vprintfmt+0x318>
  800474:	000ab683          	ld	a3,0(s5)
  800478:	4729                	li	a4,10
  80047a:	8ab2                	mv	s5,a2
  80047c:	b7f1                	j	800448 <vprintfmt+0x156>
  80047e:	00144583          	lbu	a1,1(s0)
  800482:	4d05                	li	s10,1
  800484:	846e                	mv	s0,s11
  800486:	bdd1                	j	80035a <vprintfmt+0x68>
  800488:	864a                	mv	a2,s2
  80048a:	85a6                	mv	a1,s1
  80048c:	02500513          	li	a0,37
  800490:	9982                	jalr	s3
  800492:	bd51                	j	800326 <vprintfmt+0x34>
  800494:	00144583          	lbu	a1,1(s0)
  800498:	2305                	addiw	t1,t1,1
  80049a:	846e                	mv	s0,s11
  80049c:	bd7d                	j	80035a <vprintfmt+0x68>
  80049e:	4705                	li	a4,1
  8004a0:	008a8613          	addi	a2,s5,8
  8004a4:	00674463          	blt	a4,t1,8004ac <vprintfmt+0x1ba>
  8004a8:	14030c63          	beqz	t1,800600 <vprintfmt+0x30e>
  8004ac:	000ab683          	ld	a3,0(s5)
  8004b0:	4721                	li	a4,8
  8004b2:	8ab2                	mv	s5,a2
  8004b4:	bf51                	j	800448 <vprintfmt+0x156>
  8004b6:	03000513          	li	a0,48
  8004ba:	864a                	mv	a2,s2
  8004bc:	85a6                	mv	a1,s1
  8004be:	e042                	sd	a6,0(sp)
  8004c0:	9982                	jalr	s3
  8004c2:	864a                	mv	a2,s2
  8004c4:	85a6                	mv	a1,s1
  8004c6:	07800513          	li	a0,120
  8004ca:	9982                	jalr	s3
  8004cc:	0aa1                	addi	s5,s5,8
  8004ce:	6802                	ld	a6,0(sp)
  8004d0:	4741                	li	a4,16
  8004d2:	ff8ab683          	ld	a3,-8(s5)
  8004d6:	bf8d                	j	800448 <vprintfmt+0x156>
  8004d8:	000ab403          	ld	s0,0(s5)
  8004dc:	008a8793          	addi	a5,s5,8
  8004e0:	e03e                	sd	a5,0(sp)
  8004e2:	14040c63          	beqz	s0,80063a <vprintfmt+0x348>
  8004e6:	11805063          	blez	s8,8005e6 <vprintfmt+0x2f4>
  8004ea:	02d00693          	li	a3,45
  8004ee:	0cd81963          	bne	a6,a3,8005c0 <vprintfmt+0x2ce>
  8004f2:	00044683          	lbu	a3,0(s0)
  8004f6:	0006851b          	sext.w	a0,a3
  8004fa:	ce8d                	beqz	a3,800534 <vprintfmt+0x242>
  8004fc:	00140a93          	addi	s5,s0,1
  800500:	05e00413          	li	s0,94
  800504:	000cc563          	bltz	s9,80050e <vprintfmt+0x21c>
  800508:	3cfd                	addiw	s9,s9,-1
  80050a:	037c8363          	beq	s9,s7,800530 <vprintfmt+0x23e>
  80050e:	864a                	mv	a2,s2
  800510:	85a6                	mv	a1,s1
  800512:	100d0663          	beqz	s10,80061e <vprintfmt+0x32c>
  800516:	3681                	addiw	a3,a3,-32
  800518:	10d47363          	bgeu	s0,a3,80061e <vprintfmt+0x32c>
  80051c:	03f00513          	li	a0,63
  800520:	9982                	jalr	s3
  800522:	000ac683          	lbu	a3,0(s5)
  800526:	3c7d                	addiw	s8,s8,-1
  800528:	0a85                	addi	s5,s5,1
  80052a:	0006851b          	sext.w	a0,a3
  80052e:	faf9                	bnez	a3,800504 <vprintfmt+0x212>
  800530:	01805a63          	blez	s8,800544 <vprintfmt+0x252>
  800534:	3c7d                	addiw	s8,s8,-1
  800536:	864a                	mv	a2,s2
  800538:	85a6                	mv	a1,s1
  80053a:	02000513          	li	a0,32
  80053e:	9982                	jalr	s3
  800540:	fe0c1ae3          	bnez	s8,800534 <vprintfmt+0x242>
  800544:	6a82                	ld	s5,0(sp)
  800546:	b3c5                	j	800326 <vprintfmt+0x34>
  800548:	4705                	li	a4,1
  80054a:	008a8d13          	addi	s10,s5,8
  80054e:	00674463          	blt	a4,t1,800556 <vprintfmt+0x264>
  800552:	0a030463          	beqz	t1,8005fa <vprintfmt+0x308>
  800556:	000ab403          	ld	s0,0(s5)
  80055a:	0c044463          	bltz	s0,800622 <vprintfmt+0x330>
  80055e:	86a2                	mv	a3,s0
  800560:	8aea                	mv	s5,s10
  800562:	4729                	li	a4,10
  800564:	b5d5                	j	800448 <vprintfmt+0x156>
  800566:	000aa783          	lw	a5,0(s5)
  80056a:	46e1                	li	a3,24
  80056c:	0aa1                	addi	s5,s5,8
  80056e:	41f7d71b          	sraiw	a4,a5,0x1f
  800572:	8fb9                	xor	a5,a5,a4
  800574:	40e7873b          	subw	a4,a5,a4
  800578:	02e6c663          	blt	a3,a4,8005a4 <vprintfmt+0x2b2>
  80057c:	00371793          	slli	a5,a4,0x3
  800580:	00000697          	auipc	a3,0x0
  800584:	60068693          	addi	a3,a3,1536 # 800b80 <error_string>
  800588:	97b6                	add	a5,a5,a3
  80058a:	639c                	ld	a5,0(a5)
  80058c:	cf81                	beqz	a5,8005a4 <vprintfmt+0x2b2>
  80058e:	873e                	mv	a4,a5
  800590:	00000697          	auipc	a3,0x0
  800594:	2b868693          	addi	a3,a3,696 # 800848 <main+0x19c>
  800598:	8626                	mv	a2,s1
  80059a:	85ca                	mv	a1,s2
  80059c:	854e                	mv	a0,s3
  80059e:	0d4000ef          	jal	ra,800672 <printfmt>
  8005a2:	b351                	j	800326 <vprintfmt+0x34>
  8005a4:	00000697          	auipc	a3,0x0
  8005a8:	29468693          	addi	a3,a3,660 # 800838 <main+0x18c>
  8005ac:	8626                	mv	a2,s1
  8005ae:	85ca                	mv	a1,s2
  8005b0:	854e                	mv	a0,s3
  8005b2:	0c0000ef          	jal	ra,800672 <printfmt>
  8005b6:	bb85                	j	800326 <vprintfmt+0x34>
  8005b8:	00000417          	auipc	s0,0x0
  8005bc:	27840413          	addi	s0,s0,632 # 800830 <main+0x184>
  8005c0:	85e6                	mv	a1,s9
  8005c2:	8522                	mv	a0,s0
  8005c4:	e442                	sd	a6,8(sp)
  8005c6:	0ca000ef          	jal	ra,800690 <strnlen>
  8005ca:	40ac0c3b          	subw	s8,s8,a0
  8005ce:	01805c63          	blez	s8,8005e6 <vprintfmt+0x2f4>
  8005d2:	6822                	ld	a6,8(sp)
  8005d4:	00080a9b          	sext.w	s5,a6
  8005d8:	3c7d                	addiw	s8,s8,-1
  8005da:	864a                	mv	a2,s2
  8005dc:	85a6                	mv	a1,s1
  8005de:	8556                	mv	a0,s5
  8005e0:	9982                	jalr	s3
  8005e2:	fe0c1be3          	bnez	s8,8005d8 <vprintfmt+0x2e6>
  8005e6:	00044683          	lbu	a3,0(s0)
  8005ea:	00140a93          	addi	s5,s0,1
  8005ee:	0006851b          	sext.w	a0,a3
  8005f2:	daa9                	beqz	a3,800544 <vprintfmt+0x252>
  8005f4:	05e00413          	li	s0,94
  8005f8:	b731                	j	800504 <vprintfmt+0x212>
  8005fa:	000aa403          	lw	s0,0(s5)
  8005fe:	bfb1                	j	80055a <vprintfmt+0x268>
  800600:	000ae683          	lwu	a3,0(s5)
  800604:	4721                	li	a4,8
  800606:	8ab2                	mv	s5,a2
  800608:	b581                	j	800448 <vprintfmt+0x156>
  80060a:	000ae683          	lwu	a3,0(s5)
  80060e:	4729                	li	a4,10
  800610:	8ab2                	mv	s5,a2
  800612:	bd1d                	j	800448 <vprintfmt+0x156>
  800614:	000ae683          	lwu	a3,0(s5)
  800618:	4741                	li	a4,16
  80061a:	8ab2                	mv	s5,a2
  80061c:	b535                	j	800448 <vprintfmt+0x156>
  80061e:	9982                	jalr	s3
  800620:	b709                	j	800522 <vprintfmt+0x230>
  800622:	864a                	mv	a2,s2
  800624:	85a6                	mv	a1,s1
  800626:	02d00513          	li	a0,45
  80062a:	e042                	sd	a6,0(sp)
  80062c:	9982                	jalr	s3
  80062e:	6802                	ld	a6,0(sp)
  800630:	8aea                	mv	s5,s10
  800632:	408006b3          	neg	a3,s0
  800636:	4729                	li	a4,10
  800638:	bd01                	j	800448 <vprintfmt+0x156>
  80063a:	03805163          	blez	s8,80065c <vprintfmt+0x36a>
  80063e:	02d00693          	li	a3,45
  800642:	f6d81be3          	bne	a6,a3,8005b8 <vprintfmt+0x2c6>
  800646:	00000417          	auipc	s0,0x0
  80064a:	1ea40413          	addi	s0,s0,490 # 800830 <main+0x184>
  80064e:	02800693          	li	a3,40
  800652:	02800513          	li	a0,40
  800656:	00140a93          	addi	s5,s0,1
  80065a:	b55d                	j	800500 <vprintfmt+0x20e>
  80065c:	00000a97          	auipc	s5,0x0
  800660:	1d5a8a93          	addi	s5,s5,469 # 800831 <main+0x185>
  800664:	02800513          	li	a0,40
  800668:	02800693          	li	a3,40
  80066c:	05e00413          	li	s0,94
  800670:	bd51                	j	800504 <vprintfmt+0x212>

0000000000800672 <printfmt>:
  800672:	7139                	addi	sp,sp,-64
  800674:	02010313          	addi	t1,sp,32
  800678:	f03a                	sd	a4,32(sp)
  80067a:	871a                	mv	a4,t1
  80067c:	ec06                	sd	ra,24(sp)
  80067e:	f43e                	sd	a5,40(sp)
  800680:	f842                	sd	a6,48(sp)
  800682:	fc46                	sd	a7,56(sp)
  800684:	e41a                	sd	t1,8(sp)
  800686:	c6dff0ef          	jal	ra,8002f2 <vprintfmt>
  80068a:	60e2                	ld	ra,24(sp)
  80068c:	6121                	addi	sp,sp,64
  80068e:	8082                	ret

0000000000800690 <strnlen>:
  800690:	4781                	li	a5,0
  800692:	e589                	bnez	a1,80069c <strnlen+0xc>
  800694:	a811                	j	8006a8 <strnlen+0x18>
  800696:	0785                	addi	a5,a5,1
  800698:	00f58863          	beq	a1,a5,8006a8 <strnlen+0x18>
  80069c:	00f50733          	add	a4,a0,a5
  8006a0:	00074703          	lbu	a4,0(a4)
  8006a4:	fb6d                	bnez	a4,800696 <strnlen+0x6>
  8006a6:	85be                	mv	a1,a5
  8006a8:	852e                	mv	a0,a1
  8006aa:	8082                	ret

00000000008006ac <main>:
  8006ac:	1101                	addi	sp,sp,-32
  8006ae:	e822                	sd	s0,16(sp)
  8006b0:	e426                	sd	s1,8(sp)
  8006b2:	ec06                	sd	ra,24(sp)
  8006b4:	4401                	li	s0,0
  8006b6:	02000493          	li	s1,32
  8006ba:	b03ff0ef          	jal	ra,8001bc <fork>
  8006be:	cd05                	beqz	a0,8006f6 <main+0x4a>
  8006c0:	06a05063          	blez	a0,800720 <main+0x74>
  8006c4:	2405                	addiw	s0,s0,1
  8006c6:	fe941ae3          	bne	s0,s1,8006ba <main+0xe>
  8006ca:	02000413          	li	s0,32
  8006ce:	af1ff0ef          	jal	ra,8001be <wait>
  8006d2:	ed05                	bnez	a0,80070a <main+0x5e>
  8006d4:	347d                	addiw	s0,s0,-1
  8006d6:	fc65                	bnez	s0,8006ce <main+0x22>
  8006d8:	ae7ff0ef          	jal	ra,8001be <wait>
  8006dc:	c12d                	beqz	a0,80073e <main+0x92>
  8006de:	00000517          	auipc	a0,0x0
  8006e2:	5da50513          	addi	a0,a0,1498 # 800cb8 <error_string+0x138>
  8006e6:	a19ff0ef          	jal	ra,8000fe <cprintf>
  8006ea:	60e2                	ld	ra,24(sp)
  8006ec:	6442                	ld	s0,16(sp)
  8006ee:	64a2                	ld	s1,8(sp)
  8006f0:	4501                	li	a0,0
  8006f2:	6105                	addi	sp,sp,32
  8006f4:	8082                	ret
  8006f6:	85a2                	mv	a1,s0
  8006f8:	00000517          	auipc	a0,0x0
  8006fc:	55050513          	addi	a0,a0,1360 # 800c48 <error_string+0xc8>
  800700:	9ffff0ef          	jal	ra,8000fe <cprintf>
  800704:	4501                	li	a0,0
  800706:	aa1ff0ef          	jal	ra,8001a6 <exit>
  80070a:	00000617          	auipc	a2,0x0
  80070e:	57e60613          	addi	a2,a2,1406 # 800c88 <error_string+0x108>
  800712:	45dd                	li	a1,23
  800714:	00000517          	auipc	a0,0x0
  800718:	56450513          	addi	a0,a0,1380 # 800c78 <error_string+0xf8>
  80071c:	91dff0ef          	jal	ra,800038 <__panic>
  800720:	00000697          	auipc	a3,0x0
  800724:	53868693          	addi	a3,a3,1336 # 800c58 <error_string+0xd8>
  800728:	00000617          	auipc	a2,0x0
  80072c:	53860613          	addi	a2,a2,1336 # 800c60 <error_string+0xe0>
  800730:	45b9                	li	a1,14
  800732:	00000517          	auipc	a0,0x0
  800736:	54650513          	addi	a0,a0,1350 # 800c78 <error_string+0xf8>
  80073a:	8ffff0ef          	jal	ra,800038 <__panic>
  80073e:	00000617          	auipc	a2,0x0
  800742:	56260613          	addi	a2,a2,1378 # 800ca0 <error_string+0x120>
  800746:	45f1                	li	a1,28
  800748:	00000517          	auipc	a0,0x0
  80074c:	53050513          	addi	a0,a0,1328 # 800c78 <error_string+0xf8>
  800750:	8e9ff0ef          	jal	ra,800038 <__panic>
