
obj/__user_forktree.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	a215                	j	800148 <sys_open>

0000000000800026 <close>:
  800026:	a235                	j	800152 <sys_close>

0000000000800028 <dup2>:
  800028:	aa0d                	j	80015a <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	192000ef          	jal	ra,8001c4 <umain>
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
  80004c:	79050513          	addi	a0,a0,1936 # 8007d8 <main+0x3e>
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
  80006c:	7c850513          	addi	a0,a0,1992 # 800830 <main+0x96>
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
  800084:	0be000ef          	jal	ra,800142 <sys_putc>
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
  8000b0:	218000ef          	jal	ra,8002c8 <vprintfmt>
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
  8000ec:	1dc000ef          	jal	ra,8002c8 <vprintfmt>
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

0000000000800136 <sys_fork>:
  800136:	4509                	li	a0,2
  800138:	b7c1                	j	8000f8 <syscall>

000000000080013a <sys_yield>:
  80013a:	4529                	li	a0,10
  80013c:	bf75                	j	8000f8 <syscall>

000000000080013e <sys_getpid>:
  80013e:	4549                	li	a0,18
  800140:	bf65                	j	8000f8 <syscall>

0000000000800142 <sys_putc>:
  800142:	85aa                	mv	a1,a0
  800144:	4579                	li	a0,30
  800146:	bf4d                	j	8000f8 <syscall>

0000000000800148 <sys_open>:
  800148:	862e                	mv	a2,a1
  80014a:	85aa                	mv	a1,a0
  80014c:	06400513          	li	a0,100
  800150:	b765                	j	8000f8 <syscall>

0000000000800152 <sys_close>:
  800152:	85aa                	mv	a1,a0
  800154:	06500513          	li	a0,101
  800158:	b745                	j	8000f8 <syscall>

000000000080015a <sys_dup>:
  80015a:	862e                	mv	a2,a1
  80015c:	85aa                	mv	a1,a0
  80015e:	08200513          	li	a0,130
  800162:	bf59                	j	8000f8 <syscall>

0000000000800164 <exit>:
  800164:	1141                	addi	sp,sp,-16
  800166:	e406                	sd	ra,8(sp)
  800168:	fc9ff0ef          	jal	ra,800130 <sys_exit>
  80016c:	00000517          	auipc	a0,0x0
  800170:	68c50513          	addi	a0,a0,1676 # 8007f8 <main+0x5e>
  800174:	f49ff0ef          	jal	ra,8000bc <cprintf>
  800178:	a001                	j	800178 <exit+0x14>

000000000080017a <fork>:
  80017a:	bf75                	j	800136 <sys_fork>

000000000080017c <yield>:
  80017c:	bf7d                	j	80013a <sys_yield>

000000000080017e <getpid>:
  80017e:	b7c1                	j	80013e <sys_getpid>

0000000000800180 <initfd>:
  800180:	1101                	addi	sp,sp,-32
  800182:	87ae                	mv	a5,a1
  800184:	e426                	sd	s1,8(sp)
  800186:	85b2                	mv	a1,a2
  800188:	84aa                	mv	s1,a0
  80018a:	853e                	mv	a0,a5
  80018c:	e822                	sd	s0,16(sp)
  80018e:	ec06                	sd	ra,24(sp)
  800190:	e91ff0ef          	jal	ra,800020 <open>
  800194:	842a                	mv	s0,a0
  800196:	00054463          	bltz	a0,80019e <initfd+0x1e>
  80019a:	00951863          	bne	a0,s1,8001aa <initfd+0x2a>
  80019e:	60e2                	ld	ra,24(sp)
  8001a0:	8522                	mv	a0,s0
  8001a2:	6442                	ld	s0,16(sp)
  8001a4:	64a2                	ld	s1,8(sp)
  8001a6:	6105                	addi	sp,sp,32
  8001a8:	8082                	ret
  8001aa:	8526                	mv	a0,s1
  8001ac:	e7bff0ef          	jal	ra,800026 <close>
  8001b0:	85a6                	mv	a1,s1
  8001b2:	8522                	mv	a0,s0
  8001b4:	e75ff0ef          	jal	ra,800028 <dup2>
  8001b8:	84aa                	mv	s1,a0
  8001ba:	8522                	mv	a0,s0
  8001bc:	e6bff0ef          	jal	ra,800026 <close>
  8001c0:	8426                	mv	s0,s1
  8001c2:	bff1                	j	80019e <initfd+0x1e>

00000000008001c4 <umain>:
  8001c4:	1101                	addi	sp,sp,-32
  8001c6:	e822                	sd	s0,16(sp)
  8001c8:	e426                	sd	s1,8(sp)
  8001ca:	842a                	mv	s0,a0
  8001cc:	84ae                	mv	s1,a1
  8001ce:	4601                	li	a2,0
  8001d0:	00000597          	auipc	a1,0x0
  8001d4:	64058593          	addi	a1,a1,1600 # 800810 <main+0x76>
  8001d8:	4501                	li	a0,0
  8001da:	ec06                	sd	ra,24(sp)
  8001dc:	fa5ff0ef          	jal	ra,800180 <initfd>
  8001e0:	02054263          	bltz	a0,800204 <umain+0x40>
  8001e4:	4605                	li	a2,1
  8001e6:	00000597          	auipc	a1,0x0
  8001ea:	66a58593          	addi	a1,a1,1642 # 800850 <main+0xb6>
  8001ee:	4505                	li	a0,1
  8001f0:	f91ff0ef          	jal	ra,800180 <initfd>
  8001f4:	02054563          	bltz	a0,80021e <umain+0x5a>
  8001f8:	85a6                	mv	a1,s1
  8001fa:	8522                	mv	a0,s0
  8001fc:	59e000ef          	jal	ra,80079a <main>
  800200:	f65ff0ef          	jal	ra,800164 <exit>
  800204:	86aa                	mv	a3,a0
  800206:	00000617          	auipc	a2,0x0
  80020a:	61260613          	addi	a2,a2,1554 # 800818 <main+0x7e>
  80020e:	45e9                	li	a1,26
  800210:	00000517          	auipc	a0,0x0
  800214:	62850513          	addi	a0,a0,1576 # 800838 <main+0x9e>
  800218:	e21ff0ef          	jal	ra,800038 <__warn>
  80021c:	b7e1                	j	8001e4 <umain+0x20>
  80021e:	86aa                	mv	a3,a0
  800220:	00000617          	auipc	a2,0x0
  800224:	63860613          	addi	a2,a2,1592 # 800858 <main+0xbe>
  800228:	45f5                	li	a1,29
  80022a:	00000517          	auipc	a0,0x0
  80022e:	60e50513          	addi	a0,a0,1550 # 800838 <main+0x9e>
  800232:	e07ff0ef          	jal	ra,800038 <__warn>
  800236:	b7c9                	j	8001f8 <umain+0x34>

0000000000800238 <printnum>:
  800238:	02071893          	slli	a7,a4,0x20
  80023c:	7139                	addi	sp,sp,-64
  80023e:	0208d893          	srli	a7,a7,0x20
  800242:	e456                	sd	s5,8(sp)
  800244:	0316fab3          	remu	s5,a3,a7
  800248:	f822                	sd	s0,48(sp)
  80024a:	f426                	sd	s1,40(sp)
  80024c:	f04a                	sd	s2,32(sp)
  80024e:	ec4e                	sd	s3,24(sp)
  800250:	fc06                	sd	ra,56(sp)
  800252:	e852                	sd	s4,16(sp)
  800254:	84aa                	mv	s1,a0
  800256:	89ae                	mv	s3,a1
  800258:	8932                	mv	s2,a2
  80025a:	fff7841b          	addiw	s0,a5,-1
  80025e:	2a81                	sext.w	s5,s5
  800260:	0516f163          	bgeu	a3,a7,8002a2 <printnum+0x6a>
  800264:	8a42                	mv	s4,a6
  800266:	00805863          	blez	s0,800276 <printnum+0x3e>
  80026a:	347d                	addiw	s0,s0,-1
  80026c:	864e                	mv	a2,s3
  80026e:	85ca                	mv	a1,s2
  800270:	8552                	mv	a0,s4
  800272:	9482                	jalr	s1
  800274:	f87d                	bnez	s0,80026a <printnum+0x32>
  800276:	1a82                	slli	s5,s5,0x20
  800278:	00000797          	auipc	a5,0x0
  80027c:	60078793          	addi	a5,a5,1536 # 800878 <main+0xde>
  800280:	020ada93          	srli	s5,s5,0x20
  800284:	9abe                	add	s5,s5,a5
  800286:	7442                	ld	s0,48(sp)
  800288:	000ac503          	lbu	a0,0(s5)
  80028c:	70e2                	ld	ra,56(sp)
  80028e:	6a42                	ld	s4,16(sp)
  800290:	6aa2                	ld	s5,8(sp)
  800292:	864e                	mv	a2,s3
  800294:	85ca                	mv	a1,s2
  800296:	69e2                	ld	s3,24(sp)
  800298:	7902                	ld	s2,32(sp)
  80029a:	87a6                	mv	a5,s1
  80029c:	74a2                	ld	s1,40(sp)
  80029e:	6121                	addi	sp,sp,64
  8002a0:	8782                	jr	a5
  8002a2:	0316d6b3          	divu	a3,a3,a7
  8002a6:	87a2                	mv	a5,s0
  8002a8:	f91ff0ef          	jal	ra,800238 <printnum>
  8002ac:	b7e9                	j	800276 <printnum+0x3e>

00000000008002ae <sprintputch>:
  8002ae:	499c                	lw	a5,16(a1)
  8002b0:	6198                	ld	a4,0(a1)
  8002b2:	6594                	ld	a3,8(a1)
  8002b4:	2785                	addiw	a5,a5,1
  8002b6:	c99c                	sw	a5,16(a1)
  8002b8:	00d77763          	bgeu	a4,a3,8002c6 <sprintputch+0x18>
  8002bc:	00170793          	addi	a5,a4,1
  8002c0:	e19c                	sd	a5,0(a1)
  8002c2:	00a70023          	sb	a0,0(a4)
  8002c6:	8082                	ret

00000000008002c8 <vprintfmt>:
  8002c8:	7119                	addi	sp,sp,-128
  8002ca:	f4a6                	sd	s1,104(sp)
  8002cc:	f0ca                	sd	s2,96(sp)
  8002ce:	ecce                	sd	s3,88(sp)
  8002d0:	e8d2                	sd	s4,80(sp)
  8002d2:	e4d6                	sd	s5,72(sp)
  8002d4:	e0da                	sd	s6,64(sp)
  8002d6:	fc5e                	sd	s7,56(sp)
  8002d8:	ec6e                	sd	s11,24(sp)
  8002da:	fc86                	sd	ra,120(sp)
  8002dc:	f8a2                	sd	s0,112(sp)
  8002de:	f862                	sd	s8,48(sp)
  8002e0:	f466                	sd	s9,40(sp)
  8002e2:	f06a                	sd	s10,32(sp)
  8002e4:	89aa                	mv	s3,a0
  8002e6:	892e                	mv	s2,a1
  8002e8:	84b2                	mv	s1,a2
  8002ea:	8db6                	mv	s11,a3
  8002ec:	8aba                	mv	s5,a4
  8002ee:	02500a13          	li	s4,37
  8002f2:	5bfd                	li	s7,-1
  8002f4:	00000b17          	auipc	s6,0x0
  8002f8:	5b8b0b13          	addi	s6,s6,1464 # 8008ac <main+0x112>
  8002fc:	000dc503          	lbu	a0,0(s11)
  800300:	001d8413          	addi	s0,s11,1
  800304:	01450b63          	beq	a0,s4,80031a <vprintfmt+0x52>
  800308:	c129                	beqz	a0,80034a <vprintfmt+0x82>
  80030a:	864a                	mv	a2,s2
  80030c:	85a6                	mv	a1,s1
  80030e:	0405                	addi	s0,s0,1
  800310:	9982                	jalr	s3
  800312:	fff44503          	lbu	a0,-1(s0)
  800316:	ff4519e3          	bne	a0,s4,800308 <vprintfmt+0x40>
  80031a:	00044583          	lbu	a1,0(s0)
  80031e:	02000813          	li	a6,32
  800322:	4d01                	li	s10,0
  800324:	4301                	li	t1,0
  800326:	5cfd                	li	s9,-1
  800328:	5c7d                	li	s8,-1
  80032a:	05500513          	li	a0,85
  80032e:	48a5                	li	a7,9
  800330:	fdd5861b          	addiw	a2,a1,-35
  800334:	0ff67613          	zext.b	a2,a2
  800338:	00140d93          	addi	s11,s0,1
  80033c:	04c56263          	bltu	a0,a2,800380 <vprintfmt+0xb8>
  800340:	060a                	slli	a2,a2,0x2
  800342:	965a                	add	a2,a2,s6
  800344:	4214                	lw	a3,0(a2)
  800346:	96da                	add	a3,a3,s6
  800348:	8682                	jr	a3
  80034a:	70e6                	ld	ra,120(sp)
  80034c:	7446                	ld	s0,112(sp)
  80034e:	74a6                	ld	s1,104(sp)
  800350:	7906                	ld	s2,96(sp)
  800352:	69e6                	ld	s3,88(sp)
  800354:	6a46                	ld	s4,80(sp)
  800356:	6aa6                	ld	s5,72(sp)
  800358:	6b06                	ld	s6,64(sp)
  80035a:	7be2                	ld	s7,56(sp)
  80035c:	7c42                	ld	s8,48(sp)
  80035e:	7ca2                	ld	s9,40(sp)
  800360:	7d02                	ld	s10,32(sp)
  800362:	6de2                	ld	s11,24(sp)
  800364:	6109                	addi	sp,sp,128
  800366:	8082                	ret
  800368:	882e                	mv	a6,a1
  80036a:	00144583          	lbu	a1,1(s0)
  80036e:	846e                	mv	s0,s11
  800370:	00140d93          	addi	s11,s0,1
  800374:	fdd5861b          	addiw	a2,a1,-35
  800378:	0ff67613          	zext.b	a2,a2
  80037c:	fcc572e3          	bgeu	a0,a2,800340 <vprintfmt+0x78>
  800380:	864a                	mv	a2,s2
  800382:	85a6                	mv	a1,s1
  800384:	02500513          	li	a0,37
  800388:	9982                	jalr	s3
  80038a:	fff44783          	lbu	a5,-1(s0)
  80038e:	8da2                	mv	s11,s0
  800390:	f74786e3          	beq	a5,s4,8002fc <vprintfmt+0x34>
  800394:	ffedc783          	lbu	a5,-2(s11)
  800398:	1dfd                	addi	s11,s11,-1
  80039a:	ff479de3          	bne	a5,s4,800394 <vprintfmt+0xcc>
  80039e:	bfb9                	j	8002fc <vprintfmt+0x34>
  8003a0:	fd058c9b          	addiw	s9,a1,-48
  8003a4:	00144583          	lbu	a1,1(s0)
  8003a8:	846e                	mv	s0,s11
  8003aa:	fd05869b          	addiw	a3,a1,-48
  8003ae:	0005861b          	sext.w	a2,a1
  8003b2:	02d8e463          	bltu	a7,a3,8003da <vprintfmt+0x112>
  8003b6:	00144583          	lbu	a1,1(s0)
  8003ba:	002c969b          	slliw	a3,s9,0x2
  8003be:	0196873b          	addw	a4,a3,s9
  8003c2:	0017171b          	slliw	a4,a4,0x1
  8003c6:	9f31                	addw	a4,a4,a2
  8003c8:	fd05869b          	addiw	a3,a1,-48
  8003cc:	0405                	addi	s0,s0,1
  8003ce:	fd070c9b          	addiw	s9,a4,-48
  8003d2:	0005861b          	sext.w	a2,a1
  8003d6:	fed8f0e3          	bgeu	a7,a3,8003b6 <vprintfmt+0xee>
  8003da:	f40c5be3          	bgez	s8,800330 <vprintfmt+0x68>
  8003de:	8c66                	mv	s8,s9
  8003e0:	5cfd                	li	s9,-1
  8003e2:	b7b9                	j	800330 <vprintfmt+0x68>
  8003e4:	fffc4693          	not	a3,s8
  8003e8:	96fd                	srai	a3,a3,0x3f
  8003ea:	00dc77b3          	and	a5,s8,a3
  8003ee:	00144583          	lbu	a1,1(s0)
  8003f2:	00078c1b          	sext.w	s8,a5
  8003f6:	846e                	mv	s0,s11
  8003f8:	bf25                	j	800330 <vprintfmt+0x68>
  8003fa:	000aac83          	lw	s9,0(s5)
  8003fe:	00144583          	lbu	a1,1(s0)
  800402:	0aa1                	addi	s5,s5,8
  800404:	846e                	mv	s0,s11
  800406:	bfd1                	j	8003da <vprintfmt+0x112>
  800408:	4705                	li	a4,1
  80040a:	008a8613          	addi	a2,s5,8
  80040e:	00674463          	blt	a4,t1,800416 <vprintfmt+0x14e>
  800412:	1c030c63          	beqz	t1,8005ea <vprintfmt+0x322>
  800416:	000ab683          	ld	a3,0(s5)
  80041a:	4741                	li	a4,16
  80041c:	8ab2                	mv	s5,a2
  80041e:	2801                	sext.w	a6,a6
  800420:	87e2                	mv	a5,s8
  800422:	8626                	mv	a2,s1
  800424:	85ca                	mv	a1,s2
  800426:	854e                	mv	a0,s3
  800428:	e11ff0ef          	jal	ra,800238 <printnum>
  80042c:	bdc1                	j	8002fc <vprintfmt+0x34>
  80042e:	000aa503          	lw	a0,0(s5)
  800432:	864a                	mv	a2,s2
  800434:	85a6                	mv	a1,s1
  800436:	0aa1                	addi	s5,s5,8
  800438:	9982                	jalr	s3
  80043a:	b5c9                	j	8002fc <vprintfmt+0x34>
  80043c:	4705                	li	a4,1
  80043e:	008a8613          	addi	a2,s5,8
  800442:	00674463          	blt	a4,t1,80044a <vprintfmt+0x182>
  800446:	18030d63          	beqz	t1,8005e0 <vprintfmt+0x318>
  80044a:	000ab683          	ld	a3,0(s5)
  80044e:	4729                	li	a4,10
  800450:	8ab2                	mv	s5,a2
  800452:	b7f1                	j	80041e <vprintfmt+0x156>
  800454:	00144583          	lbu	a1,1(s0)
  800458:	4d05                	li	s10,1
  80045a:	846e                	mv	s0,s11
  80045c:	bdd1                	j	800330 <vprintfmt+0x68>
  80045e:	864a                	mv	a2,s2
  800460:	85a6                	mv	a1,s1
  800462:	02500513          	li	a0,37
  800466:	9982                	jalr	s3
  800468:	bd51                	j	8002fc <vprintfmt+0x34>
  80046a:	00144583          	lbu	a1,1(s0)
  80046e:	2305                	addiw	t1,t1,1
  800470:	846e                	mv	s0,s11
  800472:	bd7d                	j	800330 <vprintfmt+0x68>
  800474:	4705                	li	a4,1
  800476:	008a8613          	addi	a2,s5,8
  80047a:	00674463          	blt	a4,t1,800482 <vprintfmt+0x1ba>
  80047e:	14030c63          	beqz	t1,8005d6 <vprintfmt+0x30e>
  800482:	000ab683          	ld	a3,0(s5)
  800486:	4721                	li	a4,8
  800488:	8ab2                	mv	s5,a2
  80048a:	bf51                	j	80041e <vprintfmt+0x156>
  80048c:	03000513          	li	a0,48
  800490:	864a                	mv	a2,s2
  800492:	85a6                	mv	a1,s1
  800494:	e042                	sd	a6,0(sp)
  800496:	9982                	jalr	s3
  800498:	864a                	mv	a2,s2
  80049a:	85a6                	mv	a1,s1
  80049c:	07800513          	li	a0,120
  8004a0:	9982                	jalr	s3
  8004a2:	0aa1                	addi	s5,s5,8
  8004a4:	6802                	ld	a6,0(sp)
  8004a6:	4741                	li	a4,16
  8004a8:	ff8ab683          	ld	a3,-8(s5)
  8004ac:	bf8d                	j	80041e <vprintfmt+0x156>
  8004ae:	000ab403          	ld	s0,0(s5)
  8004b2:	008a8793          	addi	a5,s5,8
  8004b6:	e03e                	sd	a5,0(sp)
  8004b8:	14040c63          	beqz	s0,800610 <vprintfmt+0x348>
  8004bc:	11805063          	blez	s8,8005bc <vprintfmt+0x2f4>
  8004c0:	02d00693          	li	a3,45
  8004c4:	0cd81963          	bne	a6,a3,800596 <vprintfmt+0x2ce>
  8004c8:	00044683          	lbu	a3,0(s0)
  8004cc:	0006851b          	sext.w	a0,a3
  8004d0:	ce8d                	beqz	a3,80050a <vprintfmt+0x242>
  8004d2:	00140a93          	addi	s5,s0,1
  8004d6:	05e00413          	li	s0,94
  8004da:	000cc563          	bltz	s9,8004e4 <vprintfmt+0x21c>
  8004de:	3cfd                	addiw	s9,s9,-1
  8004e0:	037c8363          	beq	s9,s7,800506 <vprintfmt+0x23e>
  8004e4:	864a                	mv	a2,s2
  8004e6:	85a6                	mv	a1,s1
  8004e8:	100d0663          	beqz	s10,8005f4 <vprintfmt+0x32c>
  8004ec:	3681                	addiw	a3,a3,-32
  8004ee:	10d47363          	bgeu	s0,a3,8005f4 <vprintfmt+0x32c>
  8004f2:	03f00513          	li	a0,63
  8004f6:	9982                	jalr	s3
  8004f8:	000ac683          	lbu	a3,0(s5)
  8004fc:	3c7d                	addiw	s8,s8,-1
  8004fe:	0a85                	addi	s5,s5,1
  800500:	0006851b          	sext.w	a0,a3
  800504:	faf9                	bnez	a3,8004da <vprintfmt+0x212>
  800506:	01805a63          	blez	s8,80051a <vprintfmt+0x252>
  80050a:	3c7d                	addiw	s8,s8,-1
  80050c:	864a                	mv	a2,s2
  80050e:	85a6                	mv	a1,s1
  800510:	02000513          	li	a0,32
  800514:	9982                	jalr	s3
  800516:	fe0c1ae3          	bnez	s8,80050a <vprintfmt+0x242>
  80051a:	6a82                	ld	s5,0(sp)
  80051c:	b3c5                	j	8002fc <vprintfmt+0x34>
  80051e:	4705                	li	a4,1
  800520:	008a8d13          	addi	s10,s5,8
  800524:	00674463          	blt	a4,t1,80052c <vprintfmt+0x264>
  800528:	0a030463          	beqz	t1,8005d0 <vprintfmt+0x308>
  80052c:	000ab403          	ld	s0,0(s5)
  800530:	0c044463          	bltz	s0,8005f8 <vprintfmt+0x330>
  800534:	86a2                	mv	a3,s0
  800536:	8aea                	mv	s5,s10
  800538:	4729                	li	a4,10
  80053a:	b5d5                	j	80041e <vprintfmt+0x156>
  80053c:	000aa783          	lw	a5,0(s5)
  800540:	46e1                	li	a3,24
  800542:	0aa1                	addi	s5,s5,8
  800544:	41f7d71b          	sraiw	a4,a5,0x1f
  800548:	8fb9                	xor	a5,a5,a4
  80054a:	40e7873b          	subw	a4,a5,a4
  80054e:	02e6c663          	blt	a3,a4,80057a <vprintfmt+0x2b2>
  800552:	00371793          	slli	a5,a4,0x3
  800556:	00000697          	auipc	a3,0x0
  80055a:	68a68693          	addi	a3,a3,1674 # 800be0 <error_string>
  80055e:	97b6                	add	a5,a5,a3
  800560:	639c                	ld	a5,0(a5)
  800562:	cf81                	beqz	a5,80057a <vprintfmt+0x2b2>
  800564:	873e                	mv	a4,a5
  800566:	00000697          	auipc	a3,0x0
  80056a:	34268693          	addi	a3,a3,834 # 8008a8 <main+0x10e>
  80056e:	8626                	mv	a2,s1
  800570:	85ca                	mv	a1,s2
  800572:	854e                	mv	a0,s3
  800574:	0d4000ef          	jal	ra,800648 <printfmt>
  800578:	b351                	j	8002fc <vprintfmt+0x34>
  80057a:	00000697          	auipc	a3,0x0
  80057e:	31e68693          	addi	a3,a3,798 # 800898 <main+0xfe>
  800582:	8626                	mv	a2,s1
  800584:	85ca                	mv	a1,s2
  800586:	854e                	mv	a0,s3
  800588:	0c0000ef          	jal	ra,800648 <printfmt>
  80058c:	bb85                	j	8002fc <vprintfmt+0x34>
  80058e:	00000417          	auipc	s0,0x0
  800592:	30240413          	addi	s0,s0,770 # 800890 <main+0xf6>
  800596:	85e6                	mv	a1,s9
  800598:	8522                	mv	a0,s0
  80059a:	e442                	sd	a6,8(sp)
  80059c:	132000ef          	jal	ra,8006ce <strnlen>
  8005a0:	40ac0c3b          	subw	s8,s8,a0
  8005a4:	01805c63          	blez	s8,8005bc <vprintfmt+0x2f4>
  8005a8:	6822                	ld	a6,8(sp)
  8005aa:	00080a9b          	sext.w	s5,a6
  8005ae:	3c7d                	addiw	s8,s8,-1
  8005b0:	864a                	mv	a2,s2
  8005b2:	85a6                	mv	a1,s1
  8005b4:	8556                	mv	a0,s5
  8005b6:	9982                	jalr	s3
  8005b8:	fe0c1be3          	bnez	s8,8005ae <vprintfmt+0x2e6>
  8005bc:	00044683          	lbu	a3,0(s0)
  8005c0:	00140a93          	addi	s5,s0,1
  8005c4:	0006851b          	sext.w	a0,a3
  8005c8:	daa9                	beqz	a3,80051a <vprintfmt+0x252>
  8005ca:	05e00413          	li	s0,94
  8005ce:	b731                	j	8004da <vprintfmt+0x212>
  8005d0:	000aa403          	lw	s0,0(s5)
  8005d4:	bfb1                	j	800530 <vprintfmt+0x268>
  8005d6:	000ae683          	lwu	a3,0(s5)
  8005da:	4721                	li	a4,8
  8005dc:	8ab2                	mv	s5,a2
  8005de:	b581                	j	80041e <vprintfmt+0x156>
  8005e0:	000ae683          	lwu	a3,0(s5)
  8005e4:	4729                	li	a4,10
  8005e6:	8ab2                	mv	s5,a2
  8005e8:	bd1d                	j	80041e <vprintfmt+0x156>
  8005ea:	000ae683          	lwu	a3,0(s5)
  8005ee:	4741                	li	a4,16
  8005f0:	8ab2                	mv	s5,a2
  8005f2:	b535                	j	80041e <vprintfmt+0x156>
  8005f4:	9982                	jalr	s3
  8005f6:	b709                	j	8004f8 <vprintfmt+0x230>
  8005f8:	864a                	mv	a2,s2
  8005fa:	85a6                	mv	a1,s1
  8005fc:	02d00513          	li	a0,45
  800600:	e042                	sd	a6,0(sp)
  800602:	9982                	jalr	s3
  800604:	6802                	ld	a6,0(sp)
  800606:	8aea                	mv	s5,s10
  800608:	408006b3          	neg	a3,s0
  80060c:	4729                	li	a4,10
  80060e:	bd01                	j	80041e <vprintfmt+0x156>
  800610:	03805163          	blez	s8,800632 <vprintfmt+0x36a>
  800614:	02d00693          	li	a3,45
  800618:	f6d81be3          	bne	a6,a3,80058e <vprintfmt+0x2c6>
  80061c:	00000417          	auipc	s0,0x0
  800620:	27440413          	addi	s0,s0,628 # 800890 <main+0xf6>
  800624:	02800693          	li	a3,40
  800628:	02800513          	li	a0,40
  80062c:	00140a93          	addi	s5,s0,1
  800630:	b55d                	j	8004d6 <vprintfmt+0x20e>
  800632:	00000a97          	auipc	s5,0x0
  800636:	25fa8a93          	addi	s5,s5,607 # 800891 <main+0xf7>
  80063a:	02800513          	li	a0,40
  80063e:	02800693          	li	a3,40
  800642:	05e00413          	li	s0,94
  800646:	bd51                	j	8004da <vprintfmt+0x212>

0000000000800648 <printfmt>:
  800648:	7139                	addi	sp,sp,-64
  80064a:	02010313          	addi	t1,sp,32
  80064e:	f03a                	sd	a4,32(sp)
  800650:	871a                	mv	a4,t1
  800652:	ec06                	sd	ra,24(sp)
  800654:	f43e                	sd	a5,40(sp)
  800656:	f842                	sd	a6,48(sp)
  800658:	fc46                	sd	a7,56(sp)
  80065a:	e41a                	sd	t1,8(sp)
  80065c:	c6dff0ef          	jal	ra,8002c8 <vprintfmt>
  800660:	60e2                	ld	ra,24(sp)
  800662:	6121                	addi	sp,sp,64
  800664:	8082                	ret

0000000000800666 <snprintf>:
  800666:	711d                	addi	sp,sp,-96
  800668:	15fd                	addi	a1,a1,-1
  80066a:	03810313          	addi	t1,sp,56
  80066e:	95aa                	add	a1,a1,a0
  800670:	f406                	sd	ra,40(sp)
  800672:	fc36                	sd	a3,56(sp)
  800674:	e0ba                	sd	a4,64(sp)
  800676:	e4be                	sd	a5,72(sp)
  800678:	e8c2                	sd	a6,80(sp)
  80067a:	ecc6                	sd	a7,88(sp)
  80067c:	e01a                	sd	t1,0(sp)
  80067e:	e42a                	sd	a0,8(sp)
  800680:	e82e                	sd	a1,16(sp)
  800682:	cc02                	sw	zero,24(sp)
  800684:	c515                	beqz	a0,8006b0 <snprintf+0x4a>
  800686:	02a5e563          	bltu	a1,a0,8006b0 <snprintf+0x4a>
  80068a:	75dd                	lui	a1,0xffff7
  80068c:	86b2                	mv	a3,a2
  80068e:	00000517          	auipc	a0,0x0
  800692:	c2050513          	addi	a0,a0,-992 # 8002ae <sprintputch>
  800696:	871a                	mv	a4,t1
  800698:	0030                	addi	a2,sp,8
  80069a:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <__global_pointer$+0xffffffffff7f52d9>
  80069e:	c2bff0ef          	jal	ra,8002c8 <vprintfmt>
  8006a2:	67a2                	ld	a5,8(sp)
  8006a4:	00078023          	sb	zero,0(a5)
  8006a8:	4562                	lw	a0,24(sp)
  8006aa:	70a2                	ld	ra,40(sp)
  8006ac:	6125                	addi	sp,sp,96
  8006ae:	8082                	ret
  8006b0:	5575                	li	a0,-3
  8006b2:	bfe5                	j	8006aa <snprintf+0x44>

00000000008006b4 <strlen>:
  8006b4:	00054783          	lbu	a5,0(a0)
  8006b8:	872a                	mv	a4,a0
  8006ba:	4501                	li	a0,0
  8006bc:	cb81                	beqz	a5,8006cc <strlen+0x18>
  8006be:	0505                	addi	a0,a0,1
  8006c0:	00a707b3          	add	a5,a4,a0
  8006c4:	0007c783          	lbu	a5,0(a5)
  8006c8:	fbfd                	bnez	a5,8006be <strlen+0xa>
  8006ca:	8082                	ret
  8006cc:	8082                	ret

00000000008006ce <strnlen>:
  8006ce:	4781                	li	a5,0
  8006d0:	e589                	bnez	a1,8006da <strnlen+0xc>
  8006d2:	a811                	j	8006e6 <strnlen+0x18>
  8006d4:	0785                	addi	a5,a5,1
  8006d6:	00f58863          	beq	a1,a5,8006e6 <strnlen+0x18>
  8006da:	00f50733          	add	a4,a0,a5
  8006de:	00074703          	lbu	a4,0(a4)
  8006e2:	fb6d                	bnez	a4,8006d4 <strnlen+0x6>
  8006e4:	85be                	mv	a1,a5
  8006e6:	852e                	mv	a0,a1
  8006e8:	8082                	ret

00000000008006ea <forktree>:
  8006ea:	1101                	addi	sp,sp,-32
  8006ec:	ec06                	sd	ra,24(sp)
  8006ee:	e822                	sd	s0,16(sp)
  8006f0:	842a                	mv	s0,a0
  8006f2:	a8dff0ef          	jal	ra,80017e <getpid>
  8006f6:	85aa                	mv	a1,a0
  8006f8:	8622                	mv	a2,s0
  8006fa:	00000517          	auipc	a0,0x0
  8006fe:	5ae50513          	addi	a0,a0,1454 # 800ca8 <error_string+0xc8>
  800702:	9bbff0ef          	jal	ra,8000bc <cprintf>
  800706:	03000593          	li	a1,48
  80070a:	8522                	mv	a0,s0
  80070c:	044000ef          	jal	ra,800750 <forkchild>
  800710:	8522                	mv	a0,s0
  800712:	fa3ff0ef          	jal	ra,8006b4 <strlen>
  800716:	4789                	li	a5,2
  800718:	00a7f663          	bgeu	a5,a0,800724 <forktree+0x3a>
  80071c:	60e2                	ld	ra,24(sp)
  80071e:	6442                	ld	s0,16(sp)
  800720:	6105                	addi	sp,sp,32
  800722:	8082                	ret
  800724:	03100713          	li	a4,49
  800728:	86a2                	mv	a3,s0
  80072a:	00000617          	auipc	a2,0x0
  80072e:	59660613          	addi	a2,a2,1430 # 800cc0 <error_string+0xe0>
  800732:	4591                	li	a1,4
  800734:	0028                	addi	a0,sp,8
  800736:	f31ff0ef          	jal	ra,800666 <snprintf>
  80073a:	a41ff0ef          	jal	ra,80017a <fork>
  80073e:	fd79                	bnez	a0,80071c <forktree+0x32>
  800740:	0028                	addi	a0,sp,8
  800742:	fa9ff0ef          	jal	ra,8006ea <forktree>
  800746:	a37ff0ef          	jal	ra,80017c <yield>
  80074a:	4501                	li	a0,0
  80074c:	a19ff0ef          	jal	ra,800164 <exit>

0000000000800750 <forkchild>:
  800750:	7179                	addi	sp,sp,-48
  800752:	f022                	sd	s0,32(sp)
  800754:	ec26                	sd	s1,24(sp)
  800756:	f406                	sd	ra,40(sp)
  800758:	842a                	mv	s0,a0
  80075a:	84ae                	mv	s1,a1
  80075c:	f59ff0ef          	jal	ra,8006b4 <strlen>
  800760:	4789                	li	a5,2
  800762:	00a7f763          	bgeu	a5,a0,800770 <forkchild+0x20>
  800766:	70a2                	ld	ra,40(sp)
  800768:	7402                	ld	s0,32(sp)
  80076a:	64e2                	ld	s1,24(sp)
  80076c:	6145                	addi	sp,sp,48
  80076e:	8082                	ret
  800770:	8726                	mv	a4,s1
  800772:	86a2                	mv	a3,s0
  800774:	00000617          	auipc	a2,0x0
  800778:	54c60613          	addi	a2,a2,1356 # 800cc0 <error_string+0xe0>
  80077c:	4591                	li	a1,4
  80077e:	0028                	addi	a0,sp,8
  800780:	ee7ff0ef          	jal	ra,800666 <snprintf>
  800784:	9f7ff0ef          	jal	ra,80017a <fork>
  800788:	fd79                	bnez	a0,800766 <forkchild+0x16>
  80078a:	0028                	addi	a0,sp,8
  80078c:	f5fff0ef          	jal	ra,8006ea <forktree>
  800790:	9edff0ef          	jal	ra,80017c <yield>
  800794:	4501                	li	a0,0
  800796:	9cfff0ef          	jal	ra,800164 <exit>

000000000080079a <main>:
  80079a:	1141                	addi	sp,sp,-16
  80079c:	00000517          	auipc	a0,0x0
  8007a0:	51c50513          	addi	a0,a0,1308 # 800cb8 <error_string+0xd8>
  8007a4:	e406                	sd	ra,8(sp)
  8007a6:	f45ff0ef          	jal	ra,8006ea <forktree>
  8007aa:	60a2                	ld	ra,8(sp)
  8007ac:	4501                	li	a0,0
  8007ae:	0141                	addi	sp,sp,16
  8007b0:	8082                	ret
