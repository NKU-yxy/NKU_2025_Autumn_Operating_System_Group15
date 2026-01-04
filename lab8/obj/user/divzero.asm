
obj/__user_divzero.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	aaa9                	j	80017e <sys_open>

0000000000800026 <close>:
  800026:	a28d                	j	800188 <sys_close>

0000000000800028 <dup2>:
  800028:	a2a5                	j	800190 <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	1c2000ef          	jal	ra,8001f4 <umain>
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
  80004c:	68850513          	addi	a0,a0,1672 # 8006d0 <main+0x38>
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
  80006c:	6e050513          	addi	a0,a0,1760 # 800748 <main+0xb0>
  800070:	08e000ef          	jal	ra,8000fe <cprintf>
  800074:	5559                	li	a0,-10
  800076:	124000ef          	jal	ra,80019a <exit>

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
  80008e:	66650513          	addi	a0,a0,1638 # 8006f0 <main+0x58>
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
  8000ae:	69e50513          	addi	a0,a0,1694 # 800748 <main+0xb0>
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
  8000c6:	0b2000ef          	jal	ra,800178 <sys_putc>
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
  8000f2:	1ec000ef          	jal	ra,8002de <vprintfmt>
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
  80012e:	1b0000ef          	jal	ra,8002de <vprintfmt>
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

0000000000800178 <sys_putc>:
  800178:	85aa                	mv	a1,a0
  80017a:	4579                	li	a0,30
  80017c:	bf7d                	j	80013a <syscall>

000000000080017e <sys_open>:
  80017e:	862e                	mv	a2,a1
  800180:	85aa                	mv	a1,a0
  800182:	06400513          	li	a0,100
  800186:	bf55                	j	80013a <syscall>

0000000000800188 <sys_close>:
  800188:	85aa                	mv	a1,a0
  80018a:	06500513          	li	a0,101
  80018e:	b775                	j	80013a <syscall>

0000000000800190 <sys_dup>:
  800190:	862e                	mv	a2,a1
  800192:	85aa                	mv	a1,a0
  800194:	08200513          	li	a0,130
  800198:	b74d                	j	80013a <syscall>

000000000080019a <exit>:
  80019a:	1141                	addi	sp,sp,-16
  80019c:	e406                	sd	ra,8(sp)
  80019e:	fd5ff0ef          	jal	ra,800172 <sys_exit>
  8001a2:	00000517          	auipc	a0,0x0
  8001a6:	56e50513          	addi	a0,a0,1390 # 800710 <main+0x78>
  8001aa:	f55ff0ef          	jal	ra,8000fe <cprintf>
  8001ae:	a001                	j	8001ae <exit+0x14>

00000000008001b0 <initfd>:
  8001b0:	1101                	addi	sp,sp,-32
  8001b2:	87ae                	mv	a5,a1
  8001b4:	e426                	sd	s1,8(sp)
  8001b6:	85b2                	mv	a1,a2
  8001b8:	84aa                	mv	s1,a0
  8001ba:	853e                	mv	a0,a5
  8001bc:	e822                	sd	s0,16(sp)
  8001be:	ec06                	sd	ra,24(sp)
  8001c0:	e61ff0ef          	jal	ra,800020 <open>
  8001c4:	842a                	mv	s0,a0
  8001c6:	00054463          	bltz	a0,8001ce <initfd+0x1e>
  8001ca:	00951863          	bne	a0,s1,8001da <initfd+0x2a>
  8001ce:	60e2                	ld	ra,24(sp)
  8001d0:	8522                	mv	a0,s0
  8001d2:	6442                	ld	s0,16(sp)
  8001d4:	64a2                	ld	s1,8(sp)
  8001d6:	6105                	addi	sp,sp,32
  8001d8:	8082                	ret
  8001da:	8526                	mv	a0,s1
  8001dc:	e4bff0ef          	jal	ra,800026 <close>
  8001e0:	85a6                	mv	a1,s1
  8001e2:	8522                	mv	a0,s0
  8001e4:	e45ff0ef          	jal	ra,800028 <dup2>
  8001e8:	84aa                	mv	s1,a0
  8001ea:	8522                	mv	a0,s0
  8001ec:	e3bff0ef          	jal	ra,800026 <close>
  8001f0:	8426                	mv	s0,s1
  8001f2:	bff1                	j	8001ce <initfd+0x1e>

00000000008001f4 <umain>:
  8001f4:	1101                	addi	sp,sp,-32
  8001f6:	e822                	sd	s0,16(sp)
  8001f8:	e426                	sd	s1,8(sp)
  8001fa:	842a                	mv	s0,a0
  8001fc:	84ae                	mv	s1,a1
  8001fe:	4601                	li	a2,0
  800200:	00000597          	auipc	a1,0x0
  800204:	52858593          	addi	a1,a1,1320 # 800728 <main+0x90>
  800208:	4501                	li	a0,0
  80020a:	ec06                	sd	ra,24(sp)
  80020c:	fa5ff0ef          	jal	ra,8001b0 <initfd>
  800210:	02054263          	bltz	a0,800234 <umain+0x40>
  800214:	4605                	li	a2,1
  800216:	00000597          	auipc	a1,0x0
  80021a:	55258593          	addi	a1,a1,1362 # 800768 <main+0xd0>
  80021e:	4505                	li	a0,1
  800220:	f91ff0ef          	jal	ra,8001b0 <initfd>
  800224:	02054563          	bltz	a0,80024e <umain+0x5a>
  800228:	85a6                	mv	a1,s1
  80022a:	8522                	mv	a0,s0
  80022c:	46c000ef          	jal	ra,800698 <main>
  800230:	f6bff0ef          	jal	ra,80019a <exit>
  800234:	86aa                	mv	a3,a0
  800236:	00000617          	auipc	a2,0x0
  80023a:	4fa60613          	addi	a2,a2,1274 # 800730 <main+0x98>
  80023e:	45e9                	li	a1,26
  800240:	00000517          	auipc	a0,0x0
  800244:	51050513          	addi	a0,a0,1296 # 800750 <main+0xb8>
  800248:	e33ff0ef          	jal	ra,80007a <__warn>
  80024c:	b7e1                	j	800214 <umain+0x20>
  80024e:	86aa                	mv	a3,a0
  800250:	00000617          	auipc	a2,0x0
  800254:	52060613          	addi	a2,a2,1312 # 800770 <main+0xd8>
  800258:	45f5                	li	a1,29
  80025a:	00000517          	auipc	a0,0x0
  80025e:	4f650513          	addi	a0,a0,1270 # 800750 <main+0xb8>
  800262:	e19ff0ef          	jal	ra,80007a <__warn>
  800266:	b7c9                	j	800228 <umain+0x34>

0000000000800268 <printnum>:
  800268:	02071893          	slli	a7,a4,0x20
  80026c:	7139                	addi	sp,sp,-64
  80026e:	0208d893          	srli	a7,a7,0x20
  800272:	e456                	sd	s5,8(sp)
  800274:	0316fab3          	remu	s5,a3,a7
  800278:	f822                	sd	s0,48(sp)
  80027a:	f426                	sd	s1,40(sp)
  80027c:	f04a                	sd	s2,32(sp)
  80027e:	ec4e                	sd	s3,24(sp)
  800280:	fc06                	sd	ra,56(sp)
  800282:	e852                	sd	s4,16(sp)
  800284:	84aa                	mv	s1,a0
  800286:	89ae                	mv	s3,a1
  800288:	8932                	mv	s2,a2
  80028a:	fff7841b          	addiw	s0,a5,-1
  80028e:	2a81                	sext.w	s5,s5
  800290:	0516f163          	bgeu	a3,a7,8002d2 <printnum+0x6a>
  800294:	8a42                	mv	s4,a6
  800296:	00805863          	blez	s0,8002a6 <printnum+0x3e>
  80029a:	347d                	addiw	s0,s0,-1
  80029c:	864e                	mv	a2,s3
  80029e:	85ca                	mv	a1,s2
  8002a0:	8552                	mv	a0,s4
  8002a2:	9482                	jalr	s1
  8002a4:	f87d                	bnez	s0,80029a <printnum+0x32>
  8002a6:	1a82                	slli	s5,s5,0x20
  8002a8:	00000797          	auipc	a5,0x0
  8002ac:	4e878793          	addi	a5,a5,1256 # 800790 <main+0xf8>
  8002b0:	020ada93          	srli	s5,s5,0x20
  8002b4:	9abe                	add	s5,s5,a5
  8002b6:	7442                	ld	s0,48(sp)
  8002b8:	000ac503          	lbu	a0,0(s5)
  8002bc:	70e2                	ld	ra,56(sp)
  8002be:	6a42                	ld	s4,16(sp)
  8002c0:	6aa2                	ld	s5,8(sp)
  8002c2:	864e                	mv	a2,s3
  8002c4:	85ca                	mv	a1,s2
  8002c6:	69e2                	ld	s3,24(sp)
  8002c8:	7902                	ld	s2,32(sp)
  8002ca:	87a6                	mv	a5,s1
  8002cc:	74a2                	ld	s1,40(sp)
  8002ce:	6121                	addi	sp,sp,64
  8002d0:	8782                	jr	a5
  8002d2:	0316d6b3          	divu	a3,a3,a7
  8002d6:	87a2                	mv	a5,s0
  8002d8:	f91ff0ef          	jal	ra,800268 <printnum>
  8002dc:	b7e9                	j	8002a6 <printnum+0x3e>

00000000008002de <vprintfmt>:
  8002de:	7119                	addi	sp,sp,-128
  8002e0:	f4a6                	sd	s1,104(sp)
  8002e2:	f0ca                	sd	s2,96(sp)
  8002e4:	ecce                	sd	s3,88(sp)
  8002e6:	e8d2                	sd	s4,80(sp)
  8002e8:	e4d6                	sd	s5,72(sp)
  8002ea:	e0da                	sd	s6,64(sp)
  8002ec:	fc5e                	sd	s7,56(sp)
  8002ee:	ec6e                	sd	s11,24(sp)
  8002f0:	fc86                	sd	ra,120(sp)
  8002f2:	f8a2                	sd	s0,112(sp)
  8002f4:	f862                	sd	s8,48(sp)
  8002f6:	f466                	sd	s9,40(sp)
  8002f8:	f06a                	sd	s10,32(sp)
  8002fa:	89aa                	mv	s3,a0
  8002fc:	892e                	mv	s2,a1
  8002fe:	84b2                	mv	s1,a2
  800300:	8db6                	mv	s11,a3
  800302:	8aba                	mv	s5,a4
  800304:	02500a13          	li	s4,37
  800308:	5bfd                	li	s7,-1
  80030a:	00000b17          	auipc	s6,0x0
  80030e:	4bab0b13          	addi	s6,s6,1210 # 8007c4 <main+0x12c>
  800312:	000dc503          	lbu	a0,0(s11)
  800316:	001d8413          	addi	s0,s11,1
  80031a:	01450b63          	beq	a0,s4,800330 <vprintfmt+0x52>
  80031e:	c129                	beqz	a0,800360 <vprintfmt+0x82>
  800320:	864a                	mv	a2,s2
  800322:	85a6                	mv	a1,s1
  800324:	0405                	addi	s0,s0,1
  800326:	9982                	jalr	s3
  800328:	fff44503          	lbu	a0,-1(s0)
  80032c:	ff4519e3          	bne	a0,s4,80031e <vprintfmt+0x40>
  800330:	00044583          	lbu	a1,0(s0)
  800334:	02000813          	li	a6,32
  800338:	4d01                	li	s10,0
  80033a:	4301                	li	t1,0
  80033c:	5cfd                	li	s9,-1
  80033e:	5c7d                	li	s8,-1
  800340:	05500513          	li	a0,85
  800344:	48a5                	li	a7,9
  800346:	fdd5861b          	addiw	a2,a1,-35
  80034a:	0ff67613          	zext.b	a2,a2
  80034e:	00140d93          	addi	s11,s0,1
  800352:	04c56263          	bltu	a0,a2,800396 <vprintfmt+0xb8>
  800356:	060a                	slli	a2,a2,0x2
  800358:	965a                	add	a2,a2,s6
  80035a:	4214                	lw	a3,0(a2)
  80035c:	96da                	add	a3,a3,s6
  80035e:	8682                	jr	a3
  800360:	70e6                	ld	ra,120(sp)
  800362:	7446                	ld	s0,112(sp)
  800364:	74a6                	ld	s1,104(sp)
  800366:	7906                	ld	s2,96(sp)
  800368:	69e6                	ld	s3,88(sp)
  80036a:	6a46                	ld	s4,80(sp)
  80036c:	6aa6                	ld	s5,72(sp)
  80036e:	6b06                	ld	s6,64(sp)
  800370:	7be2                	ld	s7,56(sp)
  800372:	7c42                	ld	s8,48(sp)
  800374:	7ca2                	ld	s9,40(sp)
  800376:	7d02                	ld	s10,32(sp)
  800378:	6de2                	ld	s11,24(sp)
  80037a:	6109                	addi	sp,sp,128
  80037c:	8082                	ret
  80037e:	882e                	mv	a6,a1
  800380:	00144583          	lbu	a1,1(s0)
  800384:	846e                	mv	s0,s11
  800386:	00140d93          	addi	s11,s0,1
  80038a:	fdd5861b          	addiw	a2,a1,-35
  80038e:	0ff67613          	zext.b	a2,a2
  800392:	fcc572e3          	bgeu	a0,a2,800356 <vprintfmt+0x78>
  800396:	864a                	mv	a2,s2
  800398:	85a6                	mv	a1,s1
  80039a:	02500513          	li	a0,37
  80039e:	9982                	jalr	s3
  8003a0:	fff44783          	lbu	a5,-1(s0)
  8003a4:	8da2                	mv	s11,s0
  8003a6:	f74786e3          	beq	a5,s4,800312 <vprintfmt+0x34>
  8003aa:	ffedc783          	lbu	a5,-2(s11)
  8003ae:	1dfd                	addi	s11,s11,-1
  8003b0:	ff479de3          	bne	a5,s4,8003aa <vprintfmt+0xcc>
  8003b4:	bfb9                	j	800312 <vprintfmt+0x34>
  8003b6:	fd058c9b          	addiw	s9,a1,-48
  8003ba:	00144583          	lbu	a1,1(s0)
  8003be:	846e                	mv	s0,s11
  8003c0:	fd05869b          	addiw	a3,a1,-48
  8003c4:	0005861b          	sext.w	a2,a1
  8003c8:	02d8e463          	bltu	a7,a3,8003f0 <vprintfmt+0x112>
  8003cc:	00144583          	lbu	a1,1(s0)
  8003d0:	002c969b          	slliw	a3,s9,0x2
  8003d4:	0196873b          	addw	a4,a3,s9
  8003d8:	0017171b          	slliw	a4,a4,0x1
  8003dc:	9f31                	addw	a4,a4,a2
  8003de:	fd05869b          	addiw	a3,a1,-48
  8003e2:	0405                	addi	s0,s0,1
  8003e4:	fd070c9b          	addiw	s9,a4,-48
  8003e8:	0005861b          	sext.w	a2,a1
  8003ec:	fed8f0e3          	bgeu	a7,a3,8003cc <vprintfmt+0xee>
  8003f0:	f40c5be3          	bgez	s8,800346 <vprintfmt+0x68>
  8003f4:	8c66                	mv	s8,s9
  8003f6:	5cfd                	li	s9,-1
  8003f8:	b7b9                	j	800346 <vprintfmt+0x68>
  8003fa:	fffc4693          	not	a3,s8
  8003fe:	96fd                	srai	a3,a3,0x3f
  800400:	00dc77b3          	and	a5,s8,a3
  800404:	00144583          	lbu	a1,1(s0)
  800408:	00078c1b          	sext.w	s8,a5
  80040c:	846e                	mv	s0,s11
  80040e:	bf25                	j	800346 <vprintfmt+0x68>
  800410:	000aac83          	lw	s9,0(s5)
  800414:	00144583          	lbu	a1,1(s0)
  800418:	0aa1                	addi	s5,s5,8
  80041a:	846e                	mv	s0,s11
  80041c:	bfd1                	j	8003f0 <vprintfmt+0x112>
  80041e:	4705                	li	a4,1
  800420:	008a8613          	addi	a2,s5,8
  800424:	00674463          	blt	a4,t1,80042c <vprintfmt+0x14e>
  800428:	1c030c63          	beqz	t1,800600 <vprintfmt+0x322>
  80042c:	000ab683          	ld	a3,0(s5)
  800430:	4741                	li	a4,16
  800432:	8ab2                	mv	s5,a2
  800434:	2801                	sext.w	a6,a6
  800436:	87e2                	mv	a5,s8
  800438:	8626                	mv	a2,s1
  80043a:	85ca                	mv	a1,s2
  80043c:	854e                	mv	a0,s3
  80043e:	e2bff0ef          	jal	ra,800268 <printnum>
  800442:	bdc1                	j	800312 <vprintfmt+0x34>
  800444:	000aa503          	lw	a0,0(s5)
  800448:	864a                	mv	a2,s2
  80044a:	85a6                	mv	a1,s1
  80044c:	0aa1                	addi	s5,s5,8
  80044e:	9982                	jalr	s3
  800450:	b5c9                	j	800312 <vprintfmt+0x34>
  800452:	4705                	li	a4,1
  800454:	008a8613          	addi	a2,s5,8
  800458:	00674463          	blt	a4,t1,800460 <vprintfmt+0x182>
  80045c:	18030d63          	beqz	t1,8005f6 <vprintfmt+0x318>
  800460:	000ab683          	ld	a3,0(s5)
  800464:	4729                	li	a4,10
  800466:	8ab2                	mv	s5,a2
  800468:	b7f1                	j	800434 <vprintfmt+0x156>
  80046a:	00144583          	lbu	a1,1(s0)
  80046e:	4d05                	li	s10,1
  800470:	846e                	mv	s0,s11
  800472:	bdd1                	j	800346 <vprintfmt+0x68>
  800474:	864a                	mv	a2,s2
  800476:	85a6                	mv	a1,s1
  800478:	02500513          	li	a0,37
  80047c:	9982                	jalr	s3
  80047e:	bd51                	j	800312 <vprintfmt+0x34>
  800480:	00144583          	lbu	a1,1(s0)
  800484:	2305                	addiw	t1,t1,1
  800486:	846e                	mv	s0,s11
  800488:	bd7d                	j	800346 <vprintfmt+0x68>
  80048a:	4705                	li	a4,1
  80048c:	008a8613          	addi	a2,s5,8
  800490:	00674463          	blt	a4,t1,800498 <vprintfmt+0x1ba>
  800494:	14030c63          	beqz	t1,8005ec <vprintfmt+0x30e>
  800498:	000ab683          	ld	a3,0(s5)
  80049c:	4721                	li	a4,8
  80049e:	8ab2                	mv	s5,a2
  8004a0:	bf51                	j	800434 <vprintfmt+0x156>
  8004a2:	03000513          	li	a0,48
  8004a6:	864a                	mv	a2,s2
  8004a8:	85a6                	mv	a1,s1
  8004aa:	e042                	sd	a6,0(sp)
  8004ac:	9982                	jalr	s3
  8004ae:	864a                	mv	a2,s2
  8004b0:	85a6                	mv	a1,s1
  8004b2:	07800513          	li	a0,120
  8004b6:	9982                	jalr	s3
  8004b8:	0aa1                	addi	s5,s5,8
  8004ba:	6802                	ld	a6,0(sp)
  8004bc:	4741                	li	a4,16
  8004be:	ff8ab683          	ld	a3,-8(s5)
  8004c2:	bf8d                	j	800434 <vprintfmt+0x156>
  8004c4:	000ab403          	ld	s0,0(s5)
  8004c8:	008a8793          	addi	a5,s5,8
  8004cc:	e03e                	sd	a5,0(sp)
  8004ce:	14040c63          	beqz	s0,800626 <vprintfmt+0x348>
  8004d2:	11805063          	blez	s8,8005d2 <vprintfmt+0x2f4>
  8004d6:	02d00693          	li	a3,45
  8004da:	0cd81963          	bne	a6,a3,8005ac <vprintfmt+0x2ce>
  8004de:	00044683          	lbu	a3,0(s0)
  8004e2:	0006851b          	sext.w	a0,a3
  8004e6:	ce8d                	beqz	a3,800520 <vprintfmt+0x242>
  8004e8:	00140a93          	addi	s5,s0,1
  8004ec:	05e00413          	li	s0,94
  8004f0:	000cc563          	bltz	s9,8004fa <vprintfmt+0x21c>
  8004f4:	3cfd                	addiw	s9,s9,-1
  8004f6:	037c8363          	beq	s9,s7,80051c <vprintfmt+0x23e>
  8004fa:	864a                	mv	a2,s2
  8004fc:	85a6                	mv	a1,s1
  8004fe:	100d0663          	beqz	s10,80060a <vprintfmt+0x32c>
  800502:	3681                	addiw	a3,a3,-32
  800504:	10d47363          	bgeu	s0,a3,80060a <vprintfmt+0x32c>
  800508:	03f00513          	li	a0,63
  80050c:	9982                	jalr	s3
  80050e:	000ac683          	lbu	a3,0(s5)
  800512:	3c7d                	addiw	s8,s8,-1
  800514:	0a85                	addi	s5,s5,1
  800516:	0006851b          	sext.w	a0,a3
  80051a:	faf9                	bnez	a3,8004f0 <vprintfmt+0x212>
  80051c:	01805a63          	blez	s8,800530 <vprintfmt+0x252>
  800520:	3c7d                	addiw	s8,s8,-1
  800522:	864a                	mv	a2,s2
  800524:	85a6                	mv	a1,s1
  800526:	02000513          	li	a0,32
  80052a:	9982                	jalr	s3
  80052c:	fe0c1ae3          	bnez	s8,800520 <vprintfmt+0x242>
  800530:	6a82                	ld	s5,0(sp)
  800532:	b3c5                	j	800312 <vprintfmt+0x34>
  800534:	4705                	li	a4,1
  800536:	008a8d13          	addi	s10,s5,8
  80053a:	00674463          	blt	a4,t1,800542 <vprintfmt+0x264>
  80053e:	0a030463          	beqz	t1,8005e6 <vprintfmt+0x308>
  800542:	000ab403          	ld	s0,0(s5)
  800546:	0c044463          	bltz	s0,80060e <vprintfmt+0x330>
  80054a:	86a2                	mv	a3,s0
  80054c:	8aea                	mv	s5,s10
  80054e:	4729                	li	a4,10
  800550:	b5d5                	j	800434 <vprintfmt+0x156>
  800552:	000aa783          	lw	a5,0(s5)
  800556:	46e1                	li	a3,24
  800558:	0aa1                	addi	s5,s5,8
  80055a:	41f7d71b          	sraiw	a4,a5,0x1f
  80055e:	8fb9                	xor	a5,a5,a4
  800560:	40e7873b          	subw	a4,a5,a4
  800564:	02e6c663          	blt	a3,a4,800590 <vprintfmt+0x2b2>
  800568:	00371793          	slli	a5,a4,0x3
  80056c:	00000697          	auipc	a3,0x0
  800570:	58c68693          	addi	a3,a3,1420 # 800af8 <error_string>
  800574:	97b6                	add	a5,a5,a3
  800576:	639c                	ld	a5,0(a5)
  800578:	cf81                	beqz	a5,800590 <vprintfmt+0x2b2>
  80057a:	873e                	mv	a4,a5
  80057c:	00000697          	auipc	a3,0x0
  800580:	24468693          	addi	a3,a3,580 # 8007c0 <main+0x128>
  800584:	8626                	mv	a2,s1
  800586:	85ca                	mv	a1,s2
  800588:	854e                	mv	a0,s3
  80058a:	0d4000ef          	jal	ra,80065e <printfmt>
  80058e:	b351                	j	800312 <vprintfmt+0x34>
  800590:	00000697          	auipc	a3,0x0
  800594:	22068693          	addi	a3,a3,544 # 8007b0 <main+0x118>
  800598:	8626                	mv	a2,s1
  80059a:	85ca                	mv	a1,s2
  80059c:	854e                	mv	a0,s3
  80059e:	0c0000ef          	jal	ra,80065e <printfmt>
  8005a2:	bb85                	j	800312 <vprintfmt+0x34>
  8005a4:	00000417          	auipc	s0,0x0
  8005a8:	20440413          	addi	s0,s0,516 # 8007a8 <main+0x110>
  8005ac:	85e6                	mv	a1,s9
  8005ae:	8522                	mv	a0,s0
  8005b0:	e442                	sd	a6,8(sp)
  8005b2:	0ca000ef          	jal	ra,80067c <strnlen>
  8005b6:	40ac0c3b          	subw	s8,s8,a0
  8005ba:	01805c63          	blez	s8,8005d2 <vprintfmt+0x2f4>
  8005be:	6822                	ld	a6,8(sp)
  8005c0:	00080a9b          	sext.w	s5,a6
  8005c4:	3c7d                	addiw	s8,s8,-1
  8005c6:	864a                	mv	a2,s2
  8005c8:	85a6                	mv	a1,s1
  8005ca:	8556                	mv	a0,s5
  8005cc:	9982                	jalr	s3
  8005ce:	fe0c1be3          	bnez	s8,8005c4 <vprintfmt+0x2e6>
  8005d2:	00044683          	lbu	a3,0(s0)
  8005d6:	00140a93          	addi	s5,s0,1
  8005da:	0006851b          	sext.w	a0,a3
  8005de:	daa9                	beqz	a3,800530 <vprintfmt+0x252>
  8005e0:	05e00413          	li	s0,94
  8005e4:	b731                	j	8004f0 <vprintfmt+0x212>
  8005e6:	000aa403          	lw	s0,0(s5)
  8005ea:	bfb1                	j	800546 <vprintfmt+0x268>
  8005ec:	000ae683          	lwu	a3,0(s5)
  8005f0:	4721                	li	a4,8
  8005f2:	8ab2                	mv	s5,a2
  8005f4:	b581                	j	800434 <vprintfmt+0x156>
  8005f6:	000ae683          	lwu	a3,0(s5)
  8005fa:	4729                	li	a4,10
  8005fc:	8ab2                	mv	s5,a2
  8005fe:	bd1d                	j	800434 <vprintfmt+0x156>
  800600:	000ae683          	lwu	a3,0(s5)
  800604:	4741                	li	a4,16
  800606:	8ab2                	mv	s5,a2
  800608:	b535                	j	800434 <vprintfmt+0x156>
  80060a:	9982                	jalr	s3
  80060c:	b709                	j	80050e <vprintfmt+0x230>
  80060e:	864a                	mv	a2,s2
  800610:	85a6                	mv	a1,s1
  800612:	02d00513          	li	a0,45
  800616:	e042                	sd	a6,0(sp)
  800618:	9982                	jalr	s3
  80061a:	6802                	ld	a6,0(sp)
  80061c:	8aea                	mv	s5,s10
  80061e:	408006b3          	neg	a3,s0
  800622:	4729                	li	a4,10
  800624:	bd01                	j	800434 <vprintfmt+0x156>
  800626:	03805163          	blez	s8,800648 <vprintfmt+0x36a>
  80062a:	02d00693          	li	a3,45
  80062e:	f6d81be3          	bne	a6,a3,8005a4 <vprintfmt+0x2c6>
  800632:	00000417          	auipc	s0,0x0
  800636:	17640413          	addi	s0,s0,374 # 8007a8 <main+0x110>
  80063a:	02800693          	li	a3,40
  80063e:	02800513          	li	a0,40
  800642:	00140a93          	addi	s5,s0,1
  800646:	b55d                	j	8004ec <vprintfmt+0x20e>
  800648:	00000a97          	auipc	s5,0x0
  80064c:	161a8a93          	addi	s5,s5,353 # 8007a9 <main+0x111>
  800650:	02800513          	li	a0,40
  800654:	02800693          	li	a3,40
  800658:	05e00413          	li	s0,94
  80065c:	bd51                	j	8004f0 <vprintfmt+0x212>

000000000080065e <printfmt>:
  80065e:	7139                	addi	sp,sp,-64
  800660:	02010313          	addi	t1,sp,32
  800664:	f03a                	sd	a4,32(sp)
  800666:	871a                	mv	a4,t1
  800668:	ec06                	sd	ra,24(sp)
  80066a:	f43e                	sd	a5,40(sp)
  80066c:	f842                	sd	a6,48(sp)
  80066e:	fc46                	sd	a7,56(sp)
  800670:	e41a                	sd	t1,8(sp)
  800672:	c6dff0ef          	jal	ra,8002de <vprintfmt>
  800676:	60e2                	ld	ra,24(sp)
  800678:	6121                	addi	sp,sp,64
  80067a:	8082                	ret

000000000080067c <strnlen>:
  80067c:	4781                	li	a5,0
  80067e:	e589                	bnez	a1,800688 <strnlen+0xc>
  800680:	a811                	j	800694 <strnlen+0x18>
  800682:	0785                	addi	a5,a5,1
  800684:	00f58863          	beq	a1,a5,800694 <strnlen+0x18>
  800688:	00f50733          	add	a4,a0,a5
  80068c:	00074703          	lbu	a4,0(a4)
  800690:	fb6d                	bnez	a4,800682 <strnlen+0x6>
  800692:	85be                	mv	a1,a5
  800694:	852e                	mv	a0,a1
  800696:	8082                	ret

0000000000800698 <main>:
  800698:	00001797          	auipc	a5,0x1
  80069c:	9687a783          	lw	a5,-1688(a5) # 801000 <zero>
  8006a0:	4585                	li	a1,1
  8006a2:	02f5c5bb          	divw	a1,a1,a5
  8006a6:	1141                	addi	sp,sp,-16
  8006a8:	00000517          	auipc	a0,0x0
  8006ac:	51850513          	addi	a0,a0,1304 # 800bc0 <error_string+0xc8>
  8006b0:	e406                	sd	ra,8(sp)
  8006b2:	a4dff0ef          	jal	ra,8000fe <cprintf>
  8006b6:	00000617          	auipc	a2,0x0
  8006ba:	51a60613          	addi	a2,a2,1306 # 800bd0 <error_string+0xd8>
  8006be:	45a5                	li	a1,9
  8006c0:	00000517          	auipc	a0,0x0
  8006c4:	52050513          	addi	a0,a0,1312 # 800be0 <error_string+0xe8>
  8006c8:	971ff0ef          	jal	ra,800038 <__panic>
