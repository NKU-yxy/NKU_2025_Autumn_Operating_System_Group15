
obj/__user_yield.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	a205                	j	800144 <sys_open>

0000000000800026 <close>:
  800026:	a225                	j	80014e <sys_close>

0000000000800028 <dup2>:
  800028:	a23d                	j	800156 <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	18c000ef          	jal	ra,8001be <umain>
  800036:	a001                	j	800036 <_start+0xc>

0000000000800038 <__warn>:
  800038:	715d                	addi	sp,sp,-80
  80003a:	832e                	mv	t1,a1
  80003c:	e822                	sd	s0,16(sp)
  80003e:	85aa                	mv	a1,a0
  800040:	8432                	mv	s0,a2
  800042:	fc3e                	sd	a5,56(sp)
  800044:	861a                	mv	a2,t1
  800046:	103c                	addi	a5,sp,40
  800048:	00000517          	auipc	a0,0x0
  80004c:	6a850513          	addi	a0,a0,1704 # 8006f0 <main+0x8e>
  800050:	ec06                	sd	ra,24(sp)
  800052:	f436                	sd	a3,40(sp)
  800054:	f83a                	sd	a4,48(sp)
  800056:	e0c2                	sd	a6,64(sp)
  800058:	e4c6                	sd	a7,72(sp)
  80005a:	e43e                	sd	a5,8(sp)
  80005c:	060000ef          	jal	ra,8000bc <cprintf>
  800060:	65a2                	ld	a1,8(sp)
  800062:	8522                	mv	a0,s0
  800064:	032000ef          	jal	ra,800096 <vcprintf>
  800068:	00000517          	auipc	a0,0x0
  80006c:	6e050513          	addi	a0,a0,1760 # 800748 <main+0xe6>
  800070:	04c000ef          	jal	ra,8000bc <cprintf>
  800074:	60e2                	ld	ra,24(sp)
  800076:	6442                	ld	s0,16(sp)
  800078:	6161                	addi	sp,sp,80
  80007a:	8082                	ret

000000000080007c <cputch>:
  80007c:	1141                	addi	sp,sp,-16
  80007e:	e022                	sd	s0,0(sp)
  800080:	e406                	sd	ra,8(sp)
  800082:	842e                	mv	s0,a1
  800084:	0ba000ef          	jal	ra,80013e <sys_putc>
  800088:	401c                	lw	a5,0(s0)
  80008a:	60a2                	ld	ra,8(sp)
  80008c:	2785                	addiw	a5,a5,1
  80008e:	c01c                	sw	a5,0(s0)
  800090:	6402                	ld	s0,0(sp)
  800092:	0141                	addi	sp,sp,16
  800094:	8082                	ret

0000000000800096 <vcprintf>:
  800096:	1101                	addi	sp,sp,-32
  800098:	872e                	mv	a4,a1
  80009a:	75dd                	lui	a1,0xffff7
  80009c:	86aa                	mv	a3,a0
  80009e:	0070                	addi	a2,sp,12
  8000a0:	00000517          	auipc	a0,0x0
  8000a4:	fdc50513          	addi	a0,a0,-36 # 80007c <cputch>
  8000a8:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <__global_pointer$+0xffffffffff7f52d9>
  8000ac:	ec06                	sd	ra,24(sp)
  8000ae:	c602                	sw	zero,12(sp)
  8000b0:	1f8000ef          	jal	ra,8002a8 <vprintfmt>
  8000b4:	60e2                	ld	ra,24(sp)
  8000b6:	4532                	lw	a0,12(sp)
  8000b8:	6105                	addi	sp,sp,32
  8000ba:	8082                	ret

00000000008000bc <cprintf>:
  8000bc:	711d                	addi	sp,sp,-96
  8000be:	02810313          	addi	t1,sp,40
  8000c2:	8e2a                	mv	t3,a0
  8000c4:	f42e                	sd	a1,40(sp)
  8000c6:	75dd                	lui	a1,0xffff7
  8000c8:	f832                	sd	a2,48(sp)
  8000ca:	fc36                	sd	a3,56(sp)
  8000cc:	e0ba                	sd	a4,64(sp)
  8000ce:	00000517          	auipc	a0,0x0
  8000d2:	fae50513          	addi	a0,a0,-82 # 80007c <cputch>
  8000d6:	0050                	addi	a2,sp,4
  8000d8:	871a                	mv	a4,t1
  8000da:	86f2                	mv	a3,t3
  8000dc:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <__global_pointer$+0xffffffffff7f52d9>
  8000e0:	ec06                	sd	ra,24(sp)
  8000e2:	e4be                	sd	a5,72(sp)
  8000e4:	e8c2                	sd	a6,80(sp)
  8000e6:	ecc6                	sd	a7,88(sp)
  8000e8:	e41a                	sd	t1,8(sp)
  8000ea:	c202                	sw	zero,4(sp)
  8000ec:	1bc000ef          	jal	ra,8002a8 <vprintfmt>
  8000f0:	60e2                	ld	ra,24(sp)
  8000f2:	4512                	lw	a0,4(sp)
  8000f4:	6125                	addi	sp,sp,96
  8000f6:	8082                	ret

00000000008000f8 <syscall>:
  8000f8:	7175                	addi	sp,sp,-144
  8000fa:	f8ba                	sd	a4,112(sp)
  8000fc:	e0ba                	sd	a4,64(sp)
  8000fe:	0118                	addi	a4,sp,128
  800100:	e42a                	sd	a0,8(sp)
  800102:	ecae                	sd	a1,88(sp)
  800104:	f0b2                	sd	a2,96(sp)
  800106:	f4b6                	sd	a3,104(sp)
  800108:	fcbe                	sd	a5,120(sp)
  80010a:	e142                	sd	a6,128(sp)
  80010c:	e546                	sd	a7,136(sp)
  80010e:	f42e                	sd	a1,40(sp)
  800110:	f832                	sd	a2,48(sp)
  800112:	fc36                	sd	a3,56(sp)
  800114:	f03a                	sd	a4,32(sp)
  800116:	e4be                	sd	a5,72(sp)
  800118:	4522                	lw	a0,8(sp)
  80011a:	55a2                	lw	a1,40(sp)
  80011c:	5642                	lw	a2,48(sp)
  80011e:	56e2                	lw	a3,56(sp)
  800120:	4706                	lw	a4,64(sp)
  800122:	47a6                	lw	a5,72(sp)
  800124:	00000073          	ecall
  800128:	ce2a                	sw	a0,28(sp)
  80012a:	4572                	lw	a0,28(sp)
  80012c:	6149                	addi	sp,sp,144
  80012e:	8082                	ret

0000000000800130 <sys_exit>:
  800130:	85aa                	mv	a1,a0
  800132:	4505                	li	a0,1
  800134:	b7d1                	j	8000f8 <syscall>

0000000000800136 <sys_yield>:
  800136:	4529                	li	a0,10
  800138:	b7c1                	j	8000f8 <syscall>

000000000080013a <sys_getpid>:
  80013a:	4549                	li	a0,18
  80013c:	bf75                	j	8000f8 <syscall>

000000000080013e <sys_putc>:
  80013e:	85aa                	mv	a1,a0
  800140:	4579                	li	a0,30
  800142:	bf5d                	j	8000f8 <syscall>

0000000000800144 <sys_open>:
  800144:	862e                	mv	a2,a1
  800146:	85aa                	mv	a1,a0
  800148:	06400513          	li	a0,100
  80014c:	b775                	j	8000f8 <syscall>

000000000080014e <sys_close>:
  80014e:	85aa                	mv	a1,a0
  800150:	06500513          	li	a0,101
  800154:	b755                	j	8000f8 <syscall>

0000000000800156 <sys_dup>:
  800156:	862e                	mv	a2,a1
  800158:	85aa                	mv	a1,a0
  80015a:	08200513          	li	a0,130
  80015e:	bf69                	j	8000f8 <syscall>

0000000000800160 <exit>:
  800160:	1141                	addi	sp,sp,-16
  800162:	e406                	sd	ra,8(sp)
  800164:	fcdff0ef          	jal	ra,800130 <sys_exit>
  800168:	00000517          	auipc	a0,0x0
  80016c:	5a850513          	addi	a0,a0,1448 # 800710 <main+0xae>
  800170:	f4dff0ef          	jal	ra,8000bc <cprintf>
  800174:	a001                	j	800174 <exit+0x14>

0000000000800176 <yield>:
  800176:	b7c1                	j	800136 <sys_yield>

0000000000800178 <getpid>:
  800178:	b7c9                	j	80013a <sys_getpid>

000000000080017a <initfd>:
  80017a:	1101                	addi	sp,sp,-32
  80017c:	87ae                	mv	a5,a1
  80017e:	e426                	sd	s1,8(sp)
  800180:	85b2                	mv	a1,a2
  800182:	84aa                	mv	s1,a0
  800184:	853e                	mv	a0,a5
  800186:	e822                	sd	s0,16(sp)
  800188:	ec06                	sd	ra,24(sp)
  80018a:	e97ff0ef          	jal	ra,800020 <open>
  80018e:	842a                	mv	s0,a0
  800190:	00054463          	bltz	a0,800198 <initfd+0x1e>
  800194:	00951863          	bne	a0,s1,8001a4 <initfd+0x2a>
  800198:	60e2                	ld	ra,24(sp)
  80019a:	8522                	mv	a0,s0
  80019c:	6442                	ld	s0,16(sp)
  80019e:	64a2                	ld	s1,8(sp)
  8001a0:	6105                	addi	sp,sp,32
  8001a2:	8082                	ret
  8001a4:	8526                	mv	a0,s1
  8001a6:	e81ff0ef          	jal	ra,800026 <close>
  8001aa:	85a6                	mv	a1,s1
  8001ac:	8522                	mv	a0,s0
  8001ae:	e7bff0ef          	jal	ra,800028 <dup2>
  8001b2:	84aa                	mv	s1,a0
  8001b4:	8522                	mv	a0,s0
  8001b6:	e71ff0ef          	jal	ra,800026 <close>
  8001ba:	8426                	mv	s0,s1
  8001bc:	bff1                	j	800198 <initfd+0x1e>

00000000008001be <umain>:
  8001be:	1101                	addi	sp,sp,-32
  8001c0:	e822                	sd	s0,16(sp)
  8001c2:	e426                	sd	s1,8(sp)
  8001c4:	842a                	mv	s0,a0
  8001c6:	84ae                	mv	s1,a1
  8001c8:	4601                	li	a2,0
  8001ca:	00000597          	auipc	a1,0x0
  8001ce:	55e58593          	addi	a1,a1,1374 # 800728 <main+0xc6>
  8001d2:	4501                	li	a0,0
  8001d4:	ec06                	sd	ra,24(sp)
  8001d6:	fa5ff0ef          	jal	ra,80017a <initfd>
  8001da:	02054263          	bltz	a0,8001fe <umain+0x40>
  8001de:	4605                	li	a2,1
  8001e0:	00000597          	auipc	a1,0x0
  8001e4:	58858593          	addi	a1,a1,1416 # 800768 <main+0x106>
  8001e8:	4505                	li	a0,1
  8001ea:	f91ff0ef          	jal	ra,80017a <initfd>
  8001ee:	02054563          	bltz	a0,800218 <umain+0x5a>
  8001f2:	85a6                	mv	a1,s1
  8001f4:	8522                	mv	a0,s0
  8001f6:	46c000ef          	jal	ra,800662 <main>
  8001fa:	f67ff0ef          	jal	ra,800160 <exit>
  8001fe:	86aa                	mv	a3,a0
  800200:	00000617          	auipc	a2,0x0
  800204:	53060613          	addi	a2,a2,1328 # 800730 <main+0xce>
  800208:	45e9                	li	a1,26
  80020a:	00000517          	auipc	a0,0x0
  80020e:	54650513          	addi	a0,a0,1350 # 800750 <main+0xee>
  800212:	e27ff0ef          	jal	ra,800038 <__warn>
  800216:	b7e1                	j	8001de <umain+0x20>
  800218:	86aa                	mv	a3,a0
  80021a:	00000617          	auipc	a2,0x0
  80021e:	55660613          	addi	a2,a2,1366 # 800770 <main+0x10e>
  800222:	45f5                	li	a1,29
  800224:	00000517          	auipc	a0,0x0
  800228:	52c50513          	addi	a0,a0,1324 # 800750 <main+0xee>
  80022c:	e0dff0ef          	jal	ra,800038 <__warn>
  800230:	b7c9                	j	8001f2 <umain+0x34>

0000000000800232 <printnum>:
  800232:	02071893          	slli	a7,a4,0x20
  800236:	7139                	addi	sp,sp,-64
  800238:	0208d893          	srli	a7,a7,0x20
  80023c:	e456                	sd	s5,8(sp)
  80023e:	0316fab3          	remu	s5,a3,a7
  800242:	f822                	sd	s0,48(sp)
  800244:	f426                	sd	s1,40(sp)
  800246:	f04a                	sd	s2,32(sp)
  800248:	ec4e                	sd	s3,24(sp)
  80024a:	fc06                	sd	ra,56(sp)
  80024c:	e852                	sd	s4,16(sp)
  80024e:	84aa                	mv	s1,a0
  800250:	89ae                	mv	s3,a1
  800252:	8932                	mv	s2,a2
  800254:	fff7841b          	addiw	s0,a5,-1
  800258:	2a81                	sext.w	s5,s5
  80025a:	0516f163          	bgeu	a3,a7,80029c <printnum+0x6a>
  80025e:	8a42                	mv	s4,a6
  800260:	00805863          	blez	s0,800270 <printnum+0x3e>
  800264:	347d                	addiw	s0,s0,-1
  800266:	864e                	mv	a2,s3
  800268:	85ca                	mv	a1,s2
  80026a:	8552                	mv	a0,s4
  80026c:	9482                	jalr	s1
  80026e:	f87d                	bnez	s0,800264 <printnum+0x32>
  800270:	1a82                	slli	s5,s5,0x20
  800272:	00000797          	auipc	a5,0x0
  800276:	51e78793          	addi	a5,a5,1310 # 800790 <main+0x12e>
  80027a:	020ada93          	srli	s5,s5,0x20
  80027e:	9abe                	add	s5,s5,a5
  800280:	7442                	ld	s0,48(sp)
  800282:	000ac503          	lbu	a0,0(s5)
  800286:	70e2                	ld	ra,56(sp)
  800288:	6a42                	ld	s4,16(sp)
  80028a:	6aa2                	ld	s5,8(sp)
  80028c:	864e                	mv	a2,s3
  80028e:	85ca                	mv	a1,s2
  800290:	69e2                	ld	s3,24(sp)
  800292:	7902                	ld	s2,32(sp)
  800294:	87a6                	mv	a5,s1
  800296:	74a2                	ld	s1,40(sp)
  800298:	6121                	addi	sp,sp,64
  80029a:	8782                	jr	a5
  80029c:	0316d6b3          	divu	a3,a3,a7
  8002a0:	87a2                	mv	a5,s0
  8002a2:	f91ff0ef          	jal	ra,800232 <printnum>
  8002a6:	b7e9                	j	800270 <printnum+0x3e>

00000000008002a8 <vprintfmt>:
  8002a8:	7119                	addi	sp,sp,-128
  8002aa:	f4a6                	sd	s1,104(sp)
  8002ac:	f0ca                	sd	s2,96(sp)
  8002ae:	ecce                	sd	s3,88(sp)
  8002b0:	e8d2                	sd	s4,80(sp)
  8002b2:	e4d6                	sd	s5,72(sp)
  8002b4:	e0da                	sd	s6,64(sp)
  8002b6:	fc5e                	sd	s7,56(sp)
  8002b8:	ec6e                	sd	s11,24(sp)
  8002ba:	fc86                	sd	ra,120(sp)
  8002bc:	f8a2                	sd	s0,112(sp)
  8002be:	f862                	sd	s8,48(sp)
  8002c0:	f466                	sd	s9,40(sp)
  8002c2:	f06a                	sd	s10,32(sp)
  8002c4:	89aa                	mv	s3,a0
  8002c6:	892e                	mv	s2,a1
  8002c8:	84b2                	mv	s1,a2
  8002ca:	8db6                	mv	s11,a3
  8002cc:	8aba                	mv	s5,a4
  8002ce:	02500a13          	li	s4,37
  8002d2:	5bfd                	li	s7,-1
  8002d4:	00000b17          	auipc	s6,0x0
  8002d8:	4f0b0b13          	addi	s6,s6,1264 # 8007c4 <main+0x162>
  8002dc:	000dc503          	lbu	a0,0(s11)
  8002e0:	001d8413          	addi	s0,s11,1
  8002e4:	01450b63          	beq	a0,s4,8002fa <vprintfmt+0x52>
  8002e8:	c129                	beqz	a0,80032a <vprintfmt+0x82>
  8002ea:	864a                	mv	a2,s2
  8002ec:	85a6                	mv	a1,s1
  8002ee:	0405                	addi	s0,s0,1
  8002f0:	9982                	jalr	s3
  8002f2:	fff44503          	lbu	a0,-1(s0)
  8002f6:	ff4519e3          	bne	a0,s4,8002e8 <vprintfmt+0x40>
  8002fa:	00044583          	lbu	a1,0(s0)
  8002fe:	02000813          	li	a6,32
  800302:	4d01                	li	s10,0
  800304:	4301                	li	t1,0
  800306:	5cfd                	li	s9,-1
  800308:	5c7d                	li	s8,-1
  80030a:	05500513          	li	a0,85
  80030e:	48a5                	li	a7,9
  800310:	fdd5861b          	addiw	a2,a1,-35
  800314:	0ff67613          	zext.b	a2,a2
  800318:	00140d93          	addi	s11,s0,1
  80031c:	04c56263          	bltu	a0,a2,800360 <vprintfmt+0xb8>
  800320:	060a                	slli	a2,a2,0x2
  800322:	965a                	add	a2,a2,s6
  800324:	4214                	lw	a3,0(a2)
  800326:	96da                	add	a3,a3,s6
  800328:	8682                	jr	a3
  80032a:	70e6                	ld	ra,120(sp)
  80032c:	7446                	ld	s0,112(sp)
  80032e:	74a6                	ld	s1,104(sp)
  800330:	7906                	ld	s2,96(sp)
  800332:	69e6                	ld	s3,88(sp)
  800334:	6a46                	ld	s4,80(sp)
  800336:	6aa6                	ld	s5,72(sp)
  800338:	6b06                	ld	s6,64(sp)
  80033a:	7be2                	ld	s7,56(sp)
  80033c:	7c42                	ld	s8,48(sp)
  80033e:	7ca2                	ld	s9,40(sp)
  800340:	7d02                	ld	s10,32(sp)
  800342:	6de2                	ld	s11,24(sp)
  800344:	6109                	addi	sp,sp,128
  800346:	8082                	ret
  800348:	882e                	mv	a6,a1
  80034a:	00144583          	lbu	a1,1(s0)
  80034e:	846e                	mv	s0,s11
  800350:	00140d93          	addi	s11,s0,1
  800354:	fdd5861b          	addiw	a2,a1,-35
  800358:	0ff67613          	zext.b	a2,a2
  80035c:	fcc572e3          	bgeu	a0,a2,800320 <vprintfmt+0x78>
  800360:	864a                	mv	a2,s2
  800362:	85a6                	mv	a1,s1
  800364:	02500513          	li	a0,37
  800368:	9982                	jalr	s3
  80036a:	fff44783          	lbu	a5,-1(s0)
  80036e:	8da2                	mv	s11,s0
  800370:	f74786e3          	beq	a5,s4,8002dc <vprintfmt+0x34>
  800374:	ffedc783          	lbu	a5,-2(s11)
  800378:	1dfd                	addi	s11,s11,-1
  80037a:	ff479de3          	bne	a5,s4,800374 <vprintfmt+0xcc>
  80037e:	bfb9                	j	8002dc <vprintfmt+0x34>
  800380:	fd058c9b          	addiw	s9,a1,-48
  800384:	00144583          	lbu	a1,1(s0)
  800388:	846e                	mv	s0,s11
  80038a:	fd05869b          	addiw	a3,a1,-48
  80038e:	0005861b          	sext.w	a2,a1
  800392:	02d8e463          	bltu	a7,a3,8003ba <vprintfmt+0x112>
  800396:	00144583          	lbu	a1,1(s0)
  80039a:	002c969b          	slliw	a3,s9,0x2
  80039e:	0196873b          	addw	a4,a3,s9
  8003a2:	0017171b          	slliw	a4,a4,0x1
  8003a6:	9f31                	addw	a4,a4,a2
  8003a8:	fd05869b          	addiw	a3,a1,-48
  8003ac:	0405                	addi	s0,s0,1
  8003ae:	fd070c9b          	addiw	s9,a4,-48
  8003b2:	0005861b          	sext.w	a2,a1
  8003b6:	fed8f0e3          	bgeu	a7,a3,800396 <vprintfmt+0xee>
  8003ba:	f40c5be3          	bgez	s8,800310 <vprintfmt+0x68>
  8003be:	8c66                	mv	s8,s9
  8003c0:	5cfd                	li	s9,-1
  8003c2:	b7b9                	j	800310 <vprintfmt+0x68>
  8003c4:	fffc4693          	not	a3,s8
  8003c8:	96fd                	srai	a3,a3,0x3f
  8003ca:	00dc77b3          	and	a5,s8,a3
  8003ce:	00144583          	lbu	a1,1(s0)
  8003d2:	00078c1b          	sext.w	s8,a5
  8003d6:	846e                	mv	s0,s11
  8003d8:	bf25                	j	800310 <vprintfmt+0x68>
  8003da:	000aac83          	lw	s9,0(s5)
  8003de:	00144583          	lbu	a1,1(s0)
  8003e2:	0aa1                	addi	s5,s5,8
  8003e4:	846e                	mv	s0,s11
  8003e6:	bfd1                	j	8003ba <vprintfmt+0x112>
  8003e8:	4705                	li	a4,1
  8003ea:	008a8613          	addi	a2,s5,8
  8003ee:	00674463          	blt	a4,t1,8003f6 <vprintfmt+0x14e>
  8003f2:	1c030c63          	beqz	t1,8005ca <vprintfmt+0x322>
  8003f6:	000ab683          	ld	a3,0(s5)
  8003fa:	4741                	li	a4,16
  8003fc:	8ab2                	mv	s5,a2
  8003fe:	2801                	sext.w	a6,a6
  800400:	87e2                	mv	a5,s8
  800402:	8626                	mv	a2,s1
  800404:	85ca                	mv	a1,s2
  800406:	854e                	mv	a0,s3
  800408:	e2bff0ef          	jal	ra,800232 <printnum>
  80040c:	bdc1                	j	8002dc <vprintfmt+0x34>
  80040e:	000aa503          	lw	a0,0(s5)
  800412:	864a                	mv	a2,s2
  800414:	85a6                	mv	a1,s1
  800416:	0aa1                	addi	s5,s5,8
  800418:	9982                	jalr	s3
  80041a:	b5c9                	j	8002dc <vprintfmt+0x34>
  80041c:	4705                	li	a4,1
  80041e:	008a8613          	addi	a2,s5,8
  800422:	00674463          	blt	a4,t1,80042a <vprintfmt+0x182>
  800426:	18030d63          	beqz	t1,8005c0 <vprintfmt+0x318>
  80042a:	000ab683          	ld	a3,0(s5)
  80042e:	4729                	li	a4,10
  800430:	8ab2                	mv	s5,a2
  800432:	b7f1                	j	8003fe <vprintfmt+0x156>
  800434:	00144583          	lbu	a1,1(s0)
  800438:	4d05                	li	s10,1
  80043a:	846e                	mv	s0,s11
  80043c:	bdd1                	j	800310 <vprintfmt+0x68>
  80043e:	864a                	mv	a2,s2
  800440:	85a6                	mv	a1,s1
  800442:	02500513          	li	a0,37
  800446:	9982                	jalr	s3
  800448:	bd51                	j	8002dc <vprintfmt+0x34>
  80044a:	00144583          	lbu	a1,1(s0)
  80044e:	2305                	addiw	t1,t1,1
  800450:	846e                	mv	s0,s11
  800452:	bd7d                	j	800310 <vprintfmt+0x68>
  800454:	4705                	li	a4,1
  800456:	008a8613          	addi	a2,s5,8
  80045a:	00674463          	blt	a4,t1,800462 <vprintfmt+0x1ba>
  80045e:	14030c63          	beqz	t1,8005b6 <vprintfmt+0x30e>
  800462:	000ab683          	ld	a3,0(s5)
  800466:	4721                	li	a4,8
  800468:	8ab2                	mv	s5,a2
  80046a:	bf51                	j	8003fe <vprintfmt+0x156>
  80046c:	03000513          	li	a0,48
  800470:	864a                	mv	a2,s2
  800472:	85a6                	mv	a1,s1
  800474:	e042                	sd	a6,0(sp)
  800476:	9982                	jalr	s3
  800478:	864a                	mv	a2,s2
  80047a:	85a6                	mv	a1,s1
  80047c:	07800513          	li	a0,120
  800480:	9982                	jalr	s3
  800482:	0aa1                	addi	s5,s5,8
  800484:	6802                	ld	a6,0(sp)
  800486:	4741                	li	a4,16
  800488:	ff8ab683          	ld	a3,-8(s5)
  80048c:	bf8d                	j	8003fe <vprintfmt+0x156>
  80048e:	000ab403          	ld	s0,0(s5)
  800492:	008a8793          	addi	a5,s5,8
  800496:	e03e                	sd	a5,0(sp)
  800498:	14040c63          	beqz	s0,8005f0 <vprintfmt+0x348>
  80049c:	11805063          	blez	s8,80059c <vprintfmt+0x2f4>
  8004a0:	02d00693          	li	a3,45
  8004a4:	0cd81963          	bne	a6,a3,800576 <vprintfmt+0x2ce>
  8004a8:	00044683          	lbu	a3,0(s0)
  8004ac:	0006851b          	sext.w	a0,a3
  8004b0:	ce8d                	beqz	a3,8004ea <vprintfmt+0x242>
  8004b2:	00140a93          	addi	s5,s0,1
  8004b6:	05e00413          	li	s0,94
  8004ba:	000cc563          	bltz	s9,8004c4 <vprintfmt+0x21c>
  8004be:	3cfd                	addiw	s9,s9,-1
  8004c0:	037c8363          	beq	s9,s7,8004e6 <vprintfmt+0x23e>
  8004c4:	864a                	mv	a2,s2
  8004c6:	85a6                	mv	a1,s1
  8004c8:	100d0663          	beqz	s10,8005d4 <vprintfmt+0x32c>
  8004cc:	3681                	addiw	a3,a3,-32
  8004ce:	10d47363          	bgeu	s0,a3,8005d4 <vprintfmt+0x32c>
  8004d2:	03f00513          	li	a0,63
  8004d6:	9982                	jalr	s3
  8004d8:	000ac683          	lbu	a3,0(s5)
  8004dc:	3c7d                	addiw	s8,s8,-1
  8004de:	0a85                	addi	s5,s5,1
  8004e0:	0006851b          	sext.w	a0,a3
  8004e4:	faf9                	bnez	a3,8004ba <vprintfmt+0x212>
  8004e6:	01805a63          	blez	s8,8004fa <vprintfmt+0x252>
  8004ea:	3c7d                	addiw	s8,s8,-1
  8004ec:	864a                	mv	a2,s2
  8004ee:	85a6                	mv	a1,s1
  8004f0:	02000513          	li	a0,32
  8004f4:	9982                	jalr	s3
  8004f6:	fe0c1ae3          	bnez	s8,8004ea <vprintfmt+0x242>
  8004fa:	6a82                	ld	s5,0(sp)
  8004fc:	b3c5                	j	8002dc <vprintfmt+0x34>
  8004fe:	4705                	li	a4,1
  800500:	008a8d13          	addi	s10,s5,8
  800504:	00674463          	blt	a4,t1,80050c <vprintfmt+0x264>
  800508:	0a030463          	beqz	t1,8005b0 <vprintfmt+0x308>
  80050c:	000ab403          	ld	s0,0(s5)
  800510:	0c044463          	bltz	s0,8005d8 <vprintfmt+0x330>
  800514:	86a2                	mv	a3,s0
  800516:	8aea                	mv	s5,s10
  800518:	4729                	li	a4,10
  80051a:	b5d5                	j	8003fe <vprintfmt+0x156>
  80051c:	000aa783          	lw	a5,0(s5)
  800520:	46e1                	li	a3,24
  800522:	0aa1                	addi	s5,s5,8
  800524:	41f7d71b          	sraiw	a4,a5,0x1f
  800528:	8fb9                	xor	a5,a5,a4
  80052a:	40e7873b          	subw	a4,a5,a4
  80052e:	02e6c663          	blt	a3,a4,80055a <vprintfmt+0x2b2>
  800532:	00371793          	slli	a5,a4,0x3
  800536:	00000697          	auipc	a3,0x0
  80053a:	5c268693          	addi	a3,a3,1474 # 800af8 <error_string>
  80053e:	97b6                	add	a5,a5,a3
  800540:	639c                	ld	a5,0(a5)
  800542:	cf81                	beqz	a5,80055a <vprintfmt+0x2b2>
  800544:	873e                	mv	a4,a5
  800546:	00000697          	auipc	a3,0x0
  80054a:	27a68693          	addi	a3,a3,634 # 8007c0 <main+0x15e>
  80054e:	8626                	mv	a2,s1
  800550:	85ca                	mv	a1,s2
  800552:	854e                	mv	a0,s3
  800554:	0d4000ef          	jal	ra,800628 <printfmt>
  800558:	b351                	j	8002dc <vprintfmt+0x34>
  80055a:	00000697          	auipc	a3,0x0
  80055e:	25668693          	addi	a3,a3,598 # 8007b0 <main+0x14e>
  800562:	8626                	mv	a2,s1
  800564:	85ca                	mv	a1,s2
  800566:	854e                	mv	a0,s3
  800568:	0c0000ef          	jal	ra,800628 <printfmt>
  80056c:	bb85                	j	8002dc <vprintfmt+0x34>
  80056e:	00000417          	auipc	s0,0x0
  800572:	23a40413          	addi	s0,s0,570 # 8007a8 <main+0x146>
  800576:	85e6                	mv	a1,s9
  800578:	8522                	mv	a0,s0
  80057a:	e442                	sd	a6,8(sp)
  80057c:	0ca000ef          	jal	ra,800646 <strnlen>
  800580:	40ac0c3b          	subw	s8,s8,a0
  800584:	01805c63          	blez	s8,80059c <vprintfmt+0x2f4>
  800588:	6822                	ld	a6,8(sp)
  80058a:	00080a9b          	sext.w	s5,a6
  80058e:	3c7d                	addiw	s8,s8,-1
  800590:	864a                	mv	a2,s2
  800592:	85a6                	mv	a1,s1
  800594:	8556                	mv	a0,s5
  800596:	9982                	jalr	s3
  800598:	fe0c1be3          	bnez	s8,80058e <vprintfmt+0x2e6>
  80059c:	00044683          	lbu	a3,0(s0)
  8005a0:	00140a93          	addi	s5,s0,1
  8005a4:	0006851b          	sext.w	a0,a3
  8005a8:	daa9                	beqz	a3,8004fa <vprintfmt+0x252>
  8005aa:	05e00413          	li	s0,94
  8005ae:	b731                	j	8004ba <vprintfmt+0x212>
  8005b0:	000aa403          	lw	s0,0(s5)
  8005b4:	bfb1                	j	800510 <vprintfmt+0x268>
  8005b6:	000ae683          	lwu	a3,0(s5)
  8005ba:	4721                	li	a4,8
  8005bc:	8ab2                	mv	s5,a2
  8005be:	b581                	j	8003fe <vprintfmt+0x156>
  8005c0:	000ae683          	lwu	a3,0(s5)
  8005c4:	4729                	li	a4,10
  8005c6:	8ab2                	mv	s5,a2
  8005c8:	bd1d                	j	8003fe <vprintfmt+0x156>
  8005ca:	000ae683          	lwu	a3,0(s5)
  8005ce:	4741                	li	a4,16
  8005d0:	8ab2                	mv	s5,a2
  8005d2:	b535                	j	8003fe <vprintfmt+0x156>
  8005d4:	9982                	jalr	s3
  8005d6:	b709                	j	8004d8 <vprintfmt+0x230>
  8005d8:	864a                	mv	a2,s2
  8005da:	85a6                	mv	a1,s1
  8005dc:	02d00513          	li	a0,45
  8005e0:	e042                	sd	a6,0(sp)
  8005e2:	9982                	jalr	s3
  8005e4:	6802                	ld	a6,0(sp)
  8005e6:	8aea                	mv	s5,s10
  8005e8:	408006b3          	neg	a3,s0
  8005ec:	4729                	li	a4,10
  8005ee:	bd01                	j	8003fe <vprintfmt+0x156>
  8005f0:	03805163          	blez	s8,800612 <vprintfmt+0x36a>
  8005f4:	02d00693          	li	a3,45
  8005f8:	f6d81be3          	bne	a6,a3,80056e <vprintfmt+0x2c6>
  8005fc:	00000417          	auipc	s0,0x0
  800600:	1ac40413          	addi	s0,s0,428 # 8007a8 <main+0x146>
  800604:	02800693          	li	a3,40
  800608:	02800513          	li	a0,40
  80060c:	00140a93          	addi	s5,s0,1
  800610:	b55d                	j	8004b6 <vprintfmt+0x20e>
  800612:	00000a97          	auipc	s5,0x0
  800616:	197a8a93          	addi	s5,s5,407 # 8007a9 <main+0x147>
  80061a:	02800513          	li	a0,40
  80061e:	02800693          	li	a3,40
  800622:	05e00413          	li	s0,94
  800626:	bd51                	j	8004ba <vprintfmt+0x212>

0000000000800628 <printfmt>:
  800628:	7139                	addi	sp,sp,-64
  80062a:	02010313          	addi	t1,sp,32
  80062e:	f03a                	sd	a4,32(sp)
  800630:	871a                	mv	a4,t1
  800632:	ec06                	sd	ra,24(sp)
  800634:	f43e                	sd	a5,40(sp)
  800636:	f842                	sd	a6,48(sp)
  800638:	fc46                	sd	a7,56(sp)
  80063a:	e41a                	sd	t1,8(sp)
  80063c:	c6dff0ef          	jal	ra,8002a8 <vprintfmt>
  800640:	60e2                	ld	ra,24(sp)
  800642:	6121                	addi	sp,sp,64
  800644:	8082                	ret

0000000000800646 <strnlen>:
  800646:	4781                	li	a5,0
  800648:	e589                	bnez	a1,800652 <strnlen+0xc>
  80064a:	a811                	j	80065e <strnlen+0x18>
  80064c:	0785                	addi	a5,a5,1
  80064e:	00f58863          	beq	a1,a5,80065e <strnlen+0x18>
  800652:	00f50733          	add	a4,a0,a5
  800656:	00074703          	lbu	a4,0(a4)
  80065a:	fb6d                	bnez	a4,80064c <strnlen+0x6>
  80065c:	85be                	mv	a1,a5
  80065e:	852e                	mv	a0,a1
  800660:	8082                	ret

0000000000800662 <main>:
  800662:	1101                	addi	sp,sp,-32
  800664:	ec06                	sd	ra,24(sp)
  800666:	e822                	sd	s0,16(sp)
  800668:	e426                	sd	s1,8(sp)
  80066a:	e04a                	sd	s2,0(sp)
  80066c:	b0dff0ef          	jal	ra,800178 <getpid>
  800670:	85aa                	mv	a1,a0
  800672:	00000517          	auipc	a0,0x0
  800676:	54e50513          	addi	a0,a0,1358 # 800bc0 <error_string+0xc8>
  80067a:	a43ff0ef          	jal	ra,8000bc <cprintf>
  80067e:	4401                	li	s0,0
  800680:	00000917          	auipc	s2,0x0
  800684:	56090913          	addi	s2,s2,1376 # 800be0 <error_string+0xe8>
  800688:	4495                	li	s1,5
  80068a:	aedff0ef          	jal	ra,800176 <yield>
  80068e:	aebff0ef          	jal	ra,800178 <getpid>
  800692:	85aa                	mv	a1,a0
  800694:	8622                	mv	a2,s0
  800696:	854a                	mv	a0,s2
  800698:	2405                	addiw	s0,s0,1
  80069a:	a23ff0ef          	jal	ra,8000bc <cprintf>
  80069e:	fe9416e3          	bne	s0,s1,80068a <main+0x28>
  8006a2:	ad7ff0ef          	jal	ra,800178 <getpid>
  8006a6:	85aa                	mv	a1,a0
  8006a8:	00000517          	auipc	a0,0x0
  8006ac:	56050513          	addi	a0,a0,1376 # 800c08 <error_string+0x110>
  8006b0:	a0dff0ef          	jal	ra,8000bc <cprintf>
  8006b4:	00000517          	auipc	a0,0x0
  8006b8:	57450513          	addi	a0,a0,1396 # 800c28 <error_string+0x130>
  8006bc:	a01ff0ef          	jal	ra,8000bc <cprintf>
  8006c0:	60e2                	ld	ra,24(sp)
  8006c2:	6442                	ld	s0,16(sp)
  8006c4:	64a2                	ld	s1,8(sp)
  8006c6:	6902                	ld	s2,0(sp)
  8006c8:	4501                	li	a0,0
  8006ca:	6105                	addi	sp,sp,32
  8006cc:	8082                	ret
