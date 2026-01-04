
obj/__user_waitkill.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	aa95                	j	800198 <sys_open>

0000000000800026 <close>:
  800026:	aab5                	j	8001a2 <sys_close>

0000000000800028 <dup2>:
  800028:	a249                	j	8001aa <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	1e6000ef          	jal	ra,800218 <umain>
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
  80004c:	7a850513          	addi	a0,a0,1960 # 8007f0 <main+0xac>
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
  800068:	00001517          	auipc	a0,0x1
  80006c:	c8050513          	addi	a0,a0,-896 # 800ce8 <error_string+0xd0>
  800070:	08e000ef          	jal	ra,8000fe <cprintf>
  800074:	5559                	li	a0,-10
  800076:	13e000ef          	jal	ra,8001b4 <exit>

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
  80008e:	78650513          	addi	a0,a0,1926 # 800810 <main+0xcc>
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
  8000aa:	00001517          	auipc	a0,0x1
  8000ae:	c3e50513          	addi	a0,a0,-962 # 800ce8 <error_string+0xd0>
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
  8000c6:	0cc000ef          	jal	ra,800192 <sys_putc>
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
  8000f2:	210000ef          	jal	ra,800302 <vprintfmt>
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
  80012e:	1d4000ef          	jal	ra,800302 <vprintfmt>
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

0000000000800184 <sys_yield>:
  800184:	4529                	li	a0,10
  800186:	bf55                	j	80013a <syscall>

0000000000800188 <sys_kill>:
  800188:	85aa                	mv	a1,a0
  80018a:	4531                	li	a0,12
  80018c:	b77d                	j	80013a <syscall>

000000000080018e <sys_getpid>:
  80018e:	4549                	li	a0,18
  800190:	b76d                	j	80013a <syscall>

0000000000800192 <sys_putc>:
  800192:	85aa                	mv	a1,a0
  800194:	4579                	li	a0,30
  800196:	b755                	j	80013a <syscall>

0000000000800198 <sys_open>:
  800198:	862e                	mv	a2,a1
  80019a:	85aa                	mv	a1,a0
  80019c:	06400513          	li	a0,100
  8001a0:	bf69                	j	80013a <syscall>

00000000008001a2 <sys_close>:
  8001a2:	85aa                	mv	a1,a0
  8001a4:	06500513          	li	a0,101
  8001a8:	bf49                	j	80013a <syscall>

00000000008001aa <sys_dup>:
  8001aa:	862e                	mv	a2,a1
  8001ac:	85aa                	mv	a1,a0
  8001ae:	08200513          	li	a0,130
  8001b2:	b761                	j	80013a <syscall>

00000000008001b4 <exit>:
  8001b4:	1141                	addi	sp,sp,-16
  8001b6:	e406                	sd	ra,8(sp)
  8001b8:	fbbff0ef          	jal	ra,800172 <sys_exit>
  8001bc:	00000517          	auipc	a0,0x0
  8001c0:	67450513          	addi	a0,a0,1652 # 800830 <main+0xec>
  8001c4:	f3bff0ef          	jal	ra,8000fe <cprintf>
  8001c8:	a001                	j	8001c8 <exit+0x14>

00000000008001ca <fork>:
  8001ca:	b77d                	j	800178 <sys_fork>

00000000008001cc <waitpid>:
  8001cc:	bf45                	j	80017c <sys_wait>

00000000008001ce <yield>:
  8001ce:	bf5d                	j	800184 <sys_yield>

00000000008001d0 <kill>:
  8001d0:	bf65                	j	800188 <sys_kill>

00000000008001d2 <getpid>:
  8001d2:	bf75                	j	80018e <sys_getpid>

00000000008001d4 <initfd>:
  8001d4:	1101                	addi	sp,sp,-32
  8001d6:	87ae                	mv	a5,a1
  8001d8:	e426                	sd	s1,8(sp)
  8001da:	85b2                	mv	a1,a2
  8001dc:	84aa                	mv	s1,a0
  8001de:	853e                	mv	a0,a5
  8001e0:	e822                	sd	s0,16(sp)
  8001e2:	ec06                	sd	ra,24(sp)
  8001e4:	e3dff0ef          	jal	ra,800020 <open>
  8001e8:	842a                	mv	s0,a0
  8001ea:	00054463          	bltz	a0,8001f2 <initfd+0x1e>
  8001ee:	00951863          	bne	a0,s1,8001fe <initfd+0x2a>
  8001f2:	60e2                	ld	ra,24(sp)
  8001f4:	8522                	mv	a0,s0
  8001f6:	6442                	ld	s0,16(sp)
  8001f8:	64a2                	ld	s1,8(sp)
  8001fa:	6105                	addi	sp,sp,32
  8001fc:	8082                	ret
  8001fe:	8526                	mv	a0,s1
  800200:	e27ff0ef          	jal	ra,800026 <close>
  800204:	85a6                	mv	a1,s1
  800206:	8522                	mv	a0,s0
  800208:	e21ff0ef          	jal	ra,800028 <dup2>
  80020c:	84aa                	mv	s1,a0
  80020e:	8522                	mv	a0,s0
  800210:	e17ff0ef          	jal	ra,800026 <close>
  800214:	8426                	mv	s0,s1
  800216:	bff1                	j	8001f2 <initfd+0x1e>

0000000000800218 <umain>:
  800218:	1101                	addi	sp,sp,-32
  80021a:	e822                	sd	s0,16(sp)
  80021c:	e426                	sd	s1,8(sp)
  80021e:	842a                	mv	s0,a0
  800220:	84ae                	mv	s1,a1
  800222:	4601                	li	a2,0
  800224:	00000597          	auipc	a1,0x0
  800228:	62458593          	addi	a1,a1,1572 # 800848 <main+0x104>
  80022c:	4501                	li	a0,0
  80022e:	ec06                	sd	ra,24(sp)
  800230:	fa5ff0ef          	jal	ra,8001d4 <initfd>
  800234:	02054263          	bltz	a0,800258 <umain+0x40>
  800238:	4605                	li	a2,1
  80023a:	00000597          	auipc	a1,0x0
  80023e:	64e58593          	addi	a1,a1,1614 # 800888 <main+0x144>
  800242:	4505                	li	a0,1
  800244:	f91ff0ef          	jal	ra,8001d4 <initfd>
  800248:	02054563          	bltz	a0,800272 <umain+0x5a>
  80024c:	85a6                	mv	a1,s1
  80024e:	8522                	mv	a0,s0
  800250:	4f4000ef          	jal	ra,800744 <main>
  800254:	f61ff0ef          	jal	ra,8001b4 <exit>
  800258:	86aa                	mv	a3,a0
  80025a:	00000617          	auipc	a2,0x0
  80025e:	5f660613          	addi	a2,a2,1526 # 800850 <main+0x10c>
  800262:	45e9                	li	a1,26
  800264:	00000517          	auipc	a0,0x0
  800268:	60c50513          	addi	a0,a0,1548 # 800870 <main+0x12c>
  80026c:	e0fff0ef          	jal	ra,80007a <__warn>
  800270:	b7e1                	j	800238 <umain+0x20>
  800272:	86aa                	mv	a3,a0
  800274:	00000617          	auipc	a2,0x0
  800278:	61c60613          	addi	a2,a2,1564 # 800890 <main+0x14c>
  80027c:	45f5                	li	a1,29
  80027e:	00000517          	auipc	a0,0x0
  800282:	5f250513          	addi	a0,a0,1522 # 800870 <main+0x12c>
  800286:	df5ff0ef          	jal	ra,80007a <__warn>
  80028a:	b7c9                	j	80024c <umain+0x34>

000000000080028c <printnum>:
  80028c:	02071893          	slli	a7,a4,0x20
  800290:	7139                	addi	sp,sp,-64
  800292:	0208d893          	srli	a7,a7,0x20
  800296:	e456                	sd	s5,8(sp)
  800298:	0316fab3          	remu	s5,a3,a7
  80029c:	f822                	sd	s0,48(sp)
  80029e:	f426                	sd	s1,40(sp)
  8002a0:	f04a                	sd	s2,32(sp)
  8002a2:	ec4e                	sd	s3,24(sp)
  8002a4:	fc06                	sd	ra,56(sp)
  8002a6:	e852                	sd	s4,16(sp)
  8002a8:	84aa                	mv	s1,a0
  8002aa:	89ae                	mv	s3,a1
  8002ac:	8932                	mv	s2,a2
  8002ae:	fff7841b          	addiw	s0,a5,-1
  8002b2:	2a81                	sext.w	s5,s5
  8002b4:	0516f163          	bgeu	a3,a7,8002f6 <printnum+0x6a>
  8002b8:	8a42                	mv	s4,a6
  8002ba:	00805863          	blez	s0,8002ca <printnum+0x3e>
  8002be:	347d                	addiw	s0,s0,-1
  8002c0:	864e                	mv	a2,s3
  8002c2:	85ca                	mv	a1,s2
  8002c4:	8552                	mv	a0,s4
  8002c6:	9482                	jalr	s1
  8002c8:	f87d                	bnez	s0,8002be <printnum+0x32>
  8002ca:	1a82                	slli	s5,s5,0x20
  8002cc:	00000797          	auipc	a5,0x0
  8002d0:	5e478793          	addi	a5,a5,1508 # 8008b0 <main+0x16c>
  8002d4:	020ada93          	srli	s5,s5,0x20
  8002d8:	9abe                	add	s5,s5,a5
  8002da:	7442                	ld	s0,48(sp)
  8002dc:	000ac503          	lbu	a0,0(s5)
  8002e0:	70e2                	ld	ra,56(sp)
  8002e2:	6a42                	ld	s4,16(sp)
  8002e4:	6aa2                	ld	s5,8(sp)
  8002e6:	864e                	mv	a2,s3
  8002e8:	85ca                	mv	a1,s2
  8002ea:	69e2                	ld	s3,24(sp)
  8002ec:	7902                	ld	s2,32(sp)
  8002ee:	87a6                	mv	a5,s1
  8002f0:	74a2                	ld	s1,40(sp)
  8002f2:	6121                	addi	sp,sp,64
  8002f4:	8782                	jr	a5
  8002f6:	0316d6b3          	divu	a3,a3,a7
  8002fa:	87a2                	mv	a5,s0
  8002fc:	f91ff0ef          	jal	ra,80028c <printnum>
  800300:	b7e9                	j	8002ca <printnum+0x3e>

0000000000800302 <vprintfmt>:
  800302:	7119                	addi	sp,sp,-128
  800304:	f4a6                	sd	s1,104(sp)
  800306:	f0ca                	sd	s2,96(sp)
  800308:	ecce                	sd	s3,88(sp)
  80030a:	e8d2                	sd	s4,80(sp)
  80030c:	e4d6                	sd	s5,72(sp)
  80030e:	e0da                	sd	s6,64(sp)
  800310:	fc5e                	sd	s7,56(sp)
  800312:	ec6e                	sd	s11,24(sp)
  800314:	fc86                	sd	ra,120(sp)
  800316:	f8a2                	sd	s0,112(sp)
  800318:	f862                	sd	s8,48(sp)
  80031a:	f466                	sd	s9,40(sp)
  80031c:	f06a                	sd	s10,32(sp)
  80031e:	89aa                	mv	s3,a0
  800320:	892e                	mv	s2,a1
  800322:	84b2                	mv	s1,a2
  800324:	8db6                	mv	s11,a3
  800326:	8aba                	mv	s5,a4
  800328:	02500a13          	li	s4,37
  80032c:	5bfd                	li	s7,-1
  80032e:	00000b17          	auipc	s6,0x0
  800332:	5b6b0b13          	addi	s6,s6,1462 # 8008e4 <main+0x1a0>
  800336:	000dc503          	lbu	a0,0(s11)
  80033a:	001d8413          	addi	s0,s11,1
  80033e:	01450b63          	beq	a0,s4,800354 <vprintfmt+0x52>
  800342:	c129                	beqz	a0,800384 <vprintfmt+0x82>
  800344:	864a                	mv	a2,s2
  800346:	85a6                	mv	a1,s1
  800348:	0405                	addi	s0,s0,1
  80034a:	9982                	jalr	s3
  80034c:	fff44503          	lbu	a0,-1(s0)
  800350:	ff4519e3          	bne	a0,s4,800342 <vprintfmt+0x40>
  800354:	00044583          	lbu	a1,0(s0)
  800358:	02000813          	li	a6,32
  80035c:	4d01                	li	s10,0
  80035e:	4301                	li	t1,0
  800360:	5cfd                	li	s9,-1
  800362:	5c7d                	li	s8,-1
  800364:	05500513          	li	a0,85
  800368:	48a5                	li	a7,9
  80036a:	fdd5861b          	addiw	a2,a1,-35
  80036e:	0ff67613          	zext.b	a2,a2
  800372:	00140d93          	addi	s11,s0,1
  800376:	04c56263          	bltu	a0,a2,8003ba <vprintfmt+0xb8>
  80037a:	060a                	slli	a2,a2,0x2
  80037c:	965a                	add	a2,a2,s6
  80037e:	4214                	lw	a3,0(a2)
  800380:	96da                	add	a3,a3,s6
  800382:	8682                	jr	a3
  800384:	70e6                	ld	ra,120(sp)
  800386:	7446                	ld	s0,112(sp)
  800388:	74a6                	ld	s1,104(sp)
  80038a:	7906                	ld	s2,96(sp)
  80038c:	69e6                	ld	s3,88(sp)
  80038e:	6a46                	ld	s4,80(sp)
  800390:	6aa6                	ld	s5,72(sp)
  800392:	6b06                	ld	s6,64(sp)
  800394:	7be2                	ld	s7,56(sp)
  800396:	7c42                	ld	s8,48(sp)
  800398:	7ca2                	ld	s9,40(sp)
  80039a:	7d02                	ld	s10,32(sp)
  80039c:	6de2                	ld	s11,24(sp)
  80039e:	6109                	addi	sp,sp,128
  8003a0:	8082                	ret
  8003a2:	882e                	mv	a6,a1
  8003a4:	00144583          	lbu	a1,1(s0)
  8003a8:	846e                	mv	s0,s11
  8003aa:	00140d93          	addi	s11,s0,1
  8003ae:	fdd5861b          	addiw	a2,a1,-35
  8003b2:	0ff67613          	zext.b	a2,a2
  8003b6:	fcc572e3          	bgeu	a0,a2,80037a <vprintfmt+0x78>
  8003ba:	864a                	mv	a2,s2
  8003bc:	85a6                	mv	a1,s1
  8003be:	02500513          	li	a0,37
  8003c2:	9982                	jalr	s3
  8003c4:	fff44783          	lbu	a5,-1(s0)
  8003c8:	8da2                	mv	s11,s0
  8003ca:	f74786e3          	beq	a5,s4,800336 <vprintfmt+0x34>
  8003ce:	ffedc783          	lbu	a5,-2(s11)
  8003d2:	1dfd                	addi	s11,s11,-1
  8003d4:	ff479de3          	bne	a5,s4,8003ce <vprintfmt+0xcc>
  8003d8:	bfb9                	j	800336 <vprintfmt+0x34>
  8003da:	fd058c9b          	addiw	s9,a1,-48
  8003de:	00144583          	lbu	a1,1(s0)
  8003e2:	846e                	mv	s0,s11
  8003e4:	fd05869b          	addiw	a3,a1,-48
  8003e8:	0005861b          	sext.w	a2,a1
  8003ec:	02d8e463          	bltu	a7,a3,800414 <vprintfmt+0x112>
  8003f0:	00144583          	lbu	a1,1(s0)
  8003f4:	002c969b          	slliw	a3,s9,0x2
  8003f8:	0196873b          	addw	a4,a3,s9
  8003fc:	0017171b          	slliw	a4,a4,0x1
  800400:	9f31                	addw	a4,a4,a2
  800402:	fd05869b          	addiw	a3,a1,-48
  800406:	0405                	addi	s0,s0,1
  800408:	fd070c9b          	addiw	s9,a4,-48
  80040c:	0005861b          	sext.w	a2,a1
  800410:	fed8f0e3          	bgeu	a7,a3,8003f0 <vprintfmt+0xee>
  800414:	f40c5be3          	bgez	s8,80036a <vprintfmt+0x68>
  800418:	8c66                	mv	s8,s9
  80041a:	5cfd                	li	s9,-1
  80041c:	b7b9                	j	80036a <vprintfmt+0x68>
  80041e:	fffc4693          	not	a3,s8
  800422:	96fd                	srai	a3,a3,0x3f
  800424:	00dc77b3          	and	a5,s8,a3
  800428:	00144583          	lbu	a1,1(s0)
  80042c:	00078c1b          	sext.w	s8,a5
  800430:	846e                	mv	s0,s11
  800432:	bf25                	j	80036a <vprintfmt+0x68>
  800434:	000aac83          	lw	s9,0(s5)
  800438:	00144583          	lbu	a1,1(s0)
  80043c:	0aa1                	addi	s5,s5,8
  80043e:	846e                	mv	s0,s11
  800440:	bfd1                	j	800414 <vprintfmt+0x112>
  800442:	4705                	li	a4,1
  800444:	008a8613          	addi	a2,s5,8
  800448:	00674463          	blt	a4,t1,800450 <vprintfmt+0x14e>
  80044c:	1c030c63          	beqz	t1,800624 <vprintfmt+0x322>
  800450:	000ab683          	ld	a3,0(s5)
  800454:	4741                	li	a4,16
  800456:	8ab2                	mv	s5,a2
  800458:	2801                	sext.w	a6,a6
  80045a:	87e2                	mv	a5,s8
  80045c:	8626                	mv	a2,s1
  80045e:	85ca                	mv	a1,s2
  800460:	854e                	mv	a0,s3
  800462:	e2bff0ef          	jal	ra,80028c <printnum>
  800466:	bdc1                	j	800336 <vprintfmt+0x34>
  800468:	000aa503          	lw	a0,0(s5)
  80046c:	864a                	mv	a2,s2
  80046e:	85a6                	mv	a1,s1
  800470:	0aa1                	addi	s5,s5,8
  800472:	9982                	jalr	s3
  800474:	b5c9                	j	800336 <vprintfmt+0x34>
  800476:	4705                	li	a4,1
  800478:	008a8613          	addi	a2,s5,8
  80047c:	00674463          	blt	a4,t1,800484 <vprintfmt+0x182>
  800480:	18030d63          	beqz	t1,80061a <vprintfmt+0x318>
  800484:	000ab683          	ld	a3,0(s5)
  800488:	4729                	li	a4,10
  80048a:	8ab2                	mv	s5,a2
  80048c:	b7f1                	j	800458 <vprintfmt+0x156>
  80048e:	00144583          	lbu	a1,1(s0)
  800492:	4d05                	li	s10,1
  800494:	846e                	mv	s0,s11
  800496:	bdd1                	j	80036a <vprintfmt+0x68>
  800498:	864a                	mv	a2,s2
  80049a:	85a6                	mv	a1,s1
  80049c:	02500513          	li	a0,37
  8004a0:	9982                	jalr	s3
  8004a2:	bd51                	j	800336 <vprintfmt+0x34>
  8004a4:	00144583          	lbu	a1,1(s0)
  8004a8:	2305                	addiw	t1,t1,1
  8004aa:	846e                	mv	s0,s11
  8004ac:	bd7d                	j	80036a <vprintfmt+0x68>
  8004ae:	4705                	li	a4,1
  8004b0:	008a8613          	addi	a2,s5,8
  8004b4:	00674463          	blt	a4,t1,8004bc <vprintfmt+0x1ba>
  8004b8:	14030c63          	beqz	t1,800610 <vprintfmt+0x30e>
  8004bc:	000ab683          	ld	a3,0(s5)
  8004c0:	4721                	li	a4,8
  8004c2:	8ab2                	mv	s5,a2
  8004c4:	bf51                	j	800458 <vprintfmt+0x156>
  8004c6:	03000513          	li	a0,48
  8004ca:	864a                	mv	a2,s2
  8004cc:	85a6                	mv	a1,s1
  8004ce:	e042                	sd	a6,0(sp)
  8004d0:	9982                	jalr	s3
  8004d2:	864a                	mv	a2,s2
  8004d4:	85a6                	mv	a1,s1
  8004d6:	07800513          	li	a0,120
  8004da:	9982                	jalr	s3
  8004dc:	0aa1                	addi	s5,s5,8
  8004de:	6802                	ld	a6,0(sp)
  8004e0:	4741                	li	a4,16
  8004e2:	ff8ab683          	ld	a3,-8(s5)
  8004e6:	bf8d                	j	800458 <vprintfmt+0x156>
  8004e8:	000ab403          	ld	s0,0(s5)
  8004ec:	008a8793          	addi	a5,s5,8
  8004f0:	e03e                	sd	a5,0(sp)
  8004f2:	14040c63          	beqz	s0,80064a <vprintfmt+0x348>
  8004f6:	11805063          	blez	s8,8005f6 <vprintfmt+0x2f4>
  8004fa:	02d00693          	li	a3,45
  8004fe:	0cd81963          	bne	a6,a3,8005d0 <vprintfmt+0x2ce>
  800502:	00044683          	lbu	a3,0(s0)
  800506:	0006851b          	sext.w	a0,a3
  80050a:	ce8d                	beqz	a3,800544 <vprintfmt+0x242>
  80050c:	00140a93          	addi	s5,s0,1
  800510:	05e00413          	li	s0,94
  800514:	000cc563          	bltz	s9,80051e <vprintfmt+0x21c>
  800518:	3cfd                	addiw	s9,s9,-1
  80051a:	037c8363          	beq	s9,s7,800540 <vprintfmt+0x23e>
  80051e:	864a                	mv	a2,s2
  800520:	85a6                	mv	a1,s1
  800522:	100d0663          	beqz	s10,80062e <vprintfmt+0x32c>
  800526:	3681                	addiw	a3,a3,-32
  800528:	10d47363          	bgeu	s0,a3,80062e <vprintfmt+0x32c>
  80052c:	03f00513          	li	a0,63
  800530:	9982                	jalr	s3
  800532:	000ac683          	lbu	a3,0(s5)
  800536:	3c7d                	addiw	s8,s8,-1
  800538:	0a85                	addi	s5,s5,1
  80053a:	0006851b          	sext.w	a0,a3
  80053e:	faf9                	bnez	a3,800514 <vprintfmt+0x212>
  800540:	01805a63          	blez	s8,800554 <vprintfmt+0x252>
  800544:	3c7d                	addiw	s8,s8,-1
  800546:	864a                	mv	a2,s2
  800548:	85a6                	mv	a1,s1
  80054a:	02000513          	li	a0,32
  80054e:	9982                	jalr	s3
  800550:	fe0c1ae3          	bnez	s8,800544 <vprintfmt+0x242>
  800554:	6a82                	ld	s5,0(sp)
  800556:	b3c5                	j	800336 <vprintfmt+0x34>
  800558:	4705                	li	a4,1
  80055a:	008a8d13          	addi	s10,s5,8
  80055e:	00674463          	blt	a4,t1,800566 <vprintfmt+0x264>
  800562:	0a030463          	beqz	t1,80060a <vprintfmt+0x308>
  800566:	000ab403          	ld	s0,0(s5)
  80056a:	0c044463          	bltz	s0,800632 <vprintfmt+0x330>
  80056e:	86a2                	mv	a3,s0
  800570:	8aea                	mv	s5,s10
  800572:	4729                	li	a4,10
  800574:	b5d5                	j	800458 <vprintfmt+0x156>
  800576:	000aa783          	lw	a5,0(s5)
  80057a:	46e1                	li	a3,24
  80057c:	0aa1                	addi	s5,s5,8
  80057e:	41f7d71b          	sraiw	a4,a5,0x1f
  800582:	8fb9                	xor	a5,a5,a4
  800584:	40e7873b          	subw	a4,a5,a4
  800588:	02e6c663          	blt	a3,a4,8005b4 <vprintfmt+0x2b2>
  80058c:	00371793          	slli	a5,a4,0x3
  800590:	00000697          	auipc	a3,0x0
  800594:	68868693          	addi	a3,a3,1672 # 800c18 <error_string>
  800598:	97b6                	add	a5,a5,a3
  80059a:	639c                	ld	a5,0(a5)
  80059c:	cf81                	beqz	a5,8005b4 <vprintfmt+0x2b2>
  80059e:	873e                	mv	a4,a5
  8005a0:	00000697          	auipc	a3,0x0
  8005a4:	34068693          	addi	a3,a3,832 # 8008e0 <main+0x19c>
  8005a8:	8626                	mv	a2,s1
  8005aa:	85ca                	mv	a1,s2
  8005ac:	854e                	mv	a0,s3
  8005ae:	0d4000ef          	jal	ra,800682 <printfmt>
  8005b2:	b351                	j	800336 <vprintfmt+0x34>
  8005b4:	00000697          	auipc	a3,0x0
  8005b8:	31c68693          	addi	a3,a3,796 # 8008d0 <main+0x18c>
  8005bc:	8626                	mv	a2,s1
  8005be:	85ca                	mv	a1,s2
  8005c0:	854e                	mv	a0,s3
  8005c2:	0c0000ef          	jal	ra,800682 <printfmt>
  8005c6:	bb85                	j	800336 <vprintfmt+0x34>
  8005c8:	00000417          	auipc	s0,0x0
  8005cc:	30040413          	addi	s0,s0,768 # 8008c8 <main+0x184>
  8005d0:	85e6                	mv	a1,s9
  8005d2:	8522                	mv	a0,s0
  8005d4:	e442                	sd	a6,8(sp)
  8005d6:	0ca000ef          	jal	ra,8006a0 <strnlen>
  8005da:	40ac0c3b          	subw	s8,s8,a0
  8005de:	01805c63          	blez	s8,8005f6 <vprintfmt+0x2f4>
  8005e2:	6822                	ld	a6,8(sp)
  8005e4:	00080a9b          	sext.w	s5,a6
  8005e8:	3c7d                	addiw	s8,s8,-1
  8005ea:	864a                	mv	a2,s2
  8005ec:	85a6                	mv	a1,s1
  8005ee:	8556                	mv	a0,s5
  8005f0:	9982                	jalr	s3
  8005f2:	fe0c1be3          	bnez	s8,8005e8 <vprintfmt+0x2e6>
  8005f6:	00044683          	lbu	a3,0(s0)
  8005fa:	00140a93          	addi	s5,s0,1
  8005fe:	0006851b          	sext.w	a0,a3
  800602:	daa9                	beqz	a3,800554 <vprintfmt+0x252>
  800604:	05e00413          	li	s0,94
  800608:	b731                	j	800514 <vprintfmt+0x212>
  80060a:	000aa403          	lw	s0,0(s5)
  80060e:	bfb1                	j	80056a <vprintfmt+0x268>
  800610:	000ae683          	lwu	a3,0(s5)
  800614:	4721                	li	a4,8
  800616:	8ab2                	mv	s5,a2
  800618:	b581                	j	800458 <vprintfmt+0x156>
  80061a:	000ae683          	lwu	a3,0(s5)
  80061e:	4729                	li	a4,10
  800620:	8ab2                	mv	s5,a2
  800622:	bd1d                	j	800458 <vprintfmt+0x156>
  800624:	000ae683          	lwu	a3,0(s5)
  800628:	4741                	li	a4,16
  80062a:	8ab2                	mv	s5,a2
  80062c:	b535                	j	800458 <vprintfmt+0x156>
  80062e:	9982                	jalr	s3
  800630:	b709                	j	800532 <vprintfmt+0x230>
  800632:	864a                	mv	a2,s2
  800634:	85a6                	mv	a1,s1
  800636:	02d00513          	li	a0,45
  80063a:	e042                	sd	a6,0(sp)
  80063c:	9982                	jalr	s3
  80063e:	6802                	ld	a6,0(sp)
  800640:	8aea                	mv	s5,s10
  800642:	408006b3          	neg	a3,s0
  800646:	4729                	li	a4,10
  800648:	bd01                	j	800458 <vprintfmt+0x156>
  80064a:	03805163          	blez	s8,80066c <vprintfmt+0x36a>
  80064e:	02d00693          	li	a3,45
  800652:	f6d81be3          	bne	a6,a3,8005c8 <vprintfmt+0x2c6>
  800656:	00000417          	auipc	s0,0x0
  80065a:	27240413          	addi	s0,s0,626 # 8008c8 <main+0x184>
  80065e:	02800693          	li	a3,40
  800662:	02800513          	li	a0,40
  800666:	00140a93          	addi	s5,s0,1
  80066a:	b55d                	j	800510 <vprintfmt+0x20e>
  80066c:	00000a97          	auipc	s5,0x0
  800670:	25da8a93          	addi	s5,s5,605 # 8008c9 <main+0x185>
  800674:	02800513          	li	a0,40
  800678:	02800693          	li	a3,40
  80067c:	05e00413          	li	s0,94
  800680:	bd51                	j	800514 <vprintfmt+0x212>

0000000000800682 <printfmt>:
  800682:	7139                	addi	sp,sp,-64
  800684:	02010313          	addi	t1,sp,32
  800688:	f03a                	sd	a4,32(sp)
  80068a:	871a                	mv	a4,t1
  80068c:	ec06                	sd	ra,24(sp)
  80068e:	f43e                	sd	a5,40(sp)
  800690:	f842                	sd	a6,48(sp)
  800692:	fc46                	sd	a7,56(sp)
  800694:	e41a                	sd	t1,8(sp)
  800696:	c6dff0ef          	jal	ra,800302 <vprintfmt>
  80069a:	60e2                	ld	ra,24(sp)
  80069c:	6121                	addi	sp,sp,64
  80069e:	8082                	ret

00000000008006a0 <strnlen>:
  8006a0:	4781                	li	a5,0
  8006a2:	e589                	bnez	a1,8006ac <strnlen+0xc>
  8006a4:	a811                	j	8006b8 <strnlen+0x18>
  8006a6:	0785                	addi	a5,a5,1
  8006a8:	00f58863          	beq	a1,a5,8006b8 <strnlen+0x18>
  8006ac:	00f50733          	add	a4,a0,a5
  8006b0:	00074703          	lbu	a4,0(a4)
  8006b4:	fb6d                	bnez	a4,8006a6 <strnlen+0x6>
  8006b6:	85be                	mv	a1,a5
  8006b8:	852e                	mv	a0,a1
  8006ba:	8082                	ret

00000000008006bc <do_yield>:
  8006bc:	1141                	addi	sp,sp,-16
  8006be:	e406                	sd	ra,8(sp)
  8006c0:	b0fff0ef          	jal	ra,8001ce <yield>
  8006c4:	b0bff0ef          	jal	ra,8001ce <yield>
  8006c8:	b07ff0ef          	jal	ra,8001ce <yield>
  8006cc:	b03ff0ef          	jal	ra,8001ce <yield>
  8006d0:	affff0ef          	jal	ra,8001ce <yield>
  8006d4:	60a2                	ld	ra,8(sp)
  8006d6:	0141                	addi	sp,sp,16
  8006d8:	bcdd                	j	8001ce <yield>

00000000008006da <loop>:
  8006da:	1141                	addi	sp,sp,-16
  8006dc:	00000517          	auipc	a0,0x0
  8006e0:	60450513          	addi	a0,a0,1540 # 800ce0 <error_string+0xc8>
  8006e4:	e406                	sd	ra,8(sp)
  8006e6:	a19ff0ef          	jal	ra,8000fe <cprintf>
  8006ea:	a001                	j	8006ea <loop+0x10>

00000000008006ec <work>:
  8006ec:	1141                	addi	sp,sp,-16
  8006ee:	00000517          	auipc	a0,0x0
  8006f2:	60250513          	addi	a0,a0,1538 # 800cf0 <error_string+0xd8>
  8006f6:	e406                	sd	ra,8(sp)
  8006f8:	a07ff0ef          	jal	ra,8000fe <cprintf>
  8006fc:	fc1ff0ef          	jal	ra,8006bc <do_yield>
  800700:	00001517          	auipc	a0,0x1
  800704:	90052503          	lw	a0,-1792(a0) # 801000 <parent>
  800708:	ac9ff0ef          	jal	ra,8001d0 <kill>
  80070c:	e105                	bnez	a0,80072c <work+0x40>
  80070e:	00000517          	auipc	a0,0x0
  800712:	5f250513          	addi	a0,a0,1522 # 800d00 <error_string+0xe8>
  800716:	9e9ff0ef          	jal	ra,8000fe <cprintf>
  80071a:	fa3ff0ef          	jal	ra,8006bc <do_yield>
  80071e:	00001517          	auipc	a0,0x1
  800722:	8e652503          	lw	a0,-1818(a0) # 801004 <pid1>
  800726:	aabff0ef          	jal	ra,8001d0 <kill>
  80072a:	c501                	beqz	a0,800732 <work+0x46>
  80072c:	557d                	li	a0,-1
  80072e:	a87ff0ef          	jal	ra,8001b4 <exit>
  800732:	00000517          	auipc	a0,0x0
  800736:	5e650513          	addi	a0,a0,1510 # 800d18 <error_string+0x100>
  80073a:	9c5ff0ef          	jal	ra,8000fe <cprintf>
  80073e:	4501                	li	a0,0
  800740:	a75ff0ef          	jal	ra,8001b4 <exit>

0000000000800744 <main>:
  800744:	1141                	addi	sp,sp,-16
  800746:	e406                	sd	ra,8(sp)
  800748:	e022                	sd	s0,0(sp)
  80074a:	a89ff0ef          	jal	ra,8001d2 <getpid>
  80074e:	00001797          	auipc	a5,0x1
  800752:	8aa7a923          	sw	a0,-1870(a5) # 801000 <parent>
  800756:	00001417          	auipc	s0,0x1
  80075a:	8ae40413          	addi	s0,s0,-1874 # 801004 <pid1>
  80075e:	a6dff0ef          	jal	ra,8001ca <fork>
  800762:	c008                	sw	a0,0(s0)
  800764:	c12d                	beqz	a0,8007c6 <main+0x82>
  800766:	04a05063          	blez	a0,8007a6 <main+0x62>
  80076a:	a61ff0ef          	jal	ra,8001ca <fork>
  80076e:	80a1a423          	sw	a0,-2040(gp) # 801008 <pid2>
  800772:	c93d                	beqz	a0,8007e8 <main+0xa4>
  800774:	04a05b63          	blez	a0,8007ca <main+0x86>
  800778:	00000517          	auipc	a0,0x0
  80077c:	5f050513          	addi	a0,a0,1520 # 800d68 <error_string+0x150>
  800780:	97fff0ef          	jal	ra,8000fe <cprintf>
  800784:	4008                	lw	a0,0(s0)
  800786:	4581                	li	a1,0
  800788:	a45ff0ef          	jal	ra,8001cc <waitpid>
  80078c:	4014                	lw	a3,0(s0)
  80078e:	00000617          	auipc	a2,0x0
  800792:	5ea60613          	addi	a2,a2,1514 # 800d78 <error_string+0x160>
  800796:	03400593          	li	a1,52
  80079a:	00000517          	auipc	a0,0x0
  80079e:	5be50513          	addi	a0,a0,1470 # 800d58 <error_string+0x140>
  8007a2:	897ff0ef          	jal	ra,800038 <__panic>
  8007a6:	00000697          	auipc	a3,0x0
  8007aa:	58a68693          	addi	a3,a3,1418 # 800d30 <error_string+0x118>
  8007ae:	00000617          	auipc	a2,0x0
  8007b2:	59260613          	addi	a2,a2,1426 # 800d40 <error_string+0x128>
  8007b6:	02c00593          	li	a1,44
  8007ba:	00000517          	auipc	a0,0x0
  8007be:	59e50513          	addi	a0,a0,1438 # 800d58 <error_string+0x140>
  8007c2:	877ff0ef          	jal	ra,800038 <__panic>
  8007c6:	f15ff0ef          	jal	ra,8006da <loop>
  8007ca:	4008                	lw	a0,0(s0)
  8007cc:	a05ff0ef          	jal	ra,8001d0 <kill>
  8007d0:	00000617          	auipc	a2,0x0
  8007d4:	5c060613          	addi	a2,a2,1472 # 800d90 <error_string+0x178>
  8007d8:	03900593          	li	a1,57
  8007dc:	00000517          	auipc	a0,0x0
  8007e0:	57c50513          	addi	a0,a0,1404 # 800d58 <error_string+0x140>
  8007e4:	855ff0ef          	jal	ra,800038 <__panic>
  8007e8:	f05ff0ef          	jal	ra,8006ec <work>
