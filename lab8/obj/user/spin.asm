
obj/__user_spin.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	aa85                	j	800194 <sys_open>

0000000000800026 <close>:
  800026:	aaa5                	j	80019e <sys_close>

0000000000800028 <dup2>:
  800028:	aabd                	j	8001a6 <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	1e0000ef          	jal	ra,800212 <umain>
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
  80004c:	74050513          	addi	a0,a0,1856 # 800788 <main+0xd2>
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
  80006c:	79850513          	addi	a0,a0,1944 # 800800 <main+0x14a>
  800070:	08e000ef          	jal	ra,8000fe <cprintf>
  800074:	5559                	li	a0,-10
  800076:	13a000ef          	jal	ra,8001b0 <exit>

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
  80008e:	71e50513          	addi	a0,a0,1822 # 8007a8 <main+0xf2>
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
  8000ae:	75650513          	addi	a0,a0,1878 # 800800 <main+0x14a>
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
  8000c6:	0c8000ef          	jal	ra,80018e <sys_putc>
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
  8000f2:	20a000ef          	jal	ra,8002fc <vprintfmt>
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
  80012e:	1ce000ef          	jal	ra,8002fc <vprintfmt>
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

000000000080018e <sys_putc>:
  80018e:	85aa                	mv	a1,a0
  800190:	4579                	li	a0,30
  800192:	b765                	j	80013a <syscall>

0000000000800194 <sys_open>:
  800194:	862e                	mv	a2,a1
  800196:	85aa                	mv	a1,a0
  800198:	06400513          	li	a0,100
  80019c:	bf79                	j	80013a <syscall>

000000000080019e <sys_close>:
  80019e:	85aa                	mv	a1,a0
  8001a0:	06500513          	li	a0,101
  8001a4:	bf59                	j	80013a <syscall>

00000000008001a6 <sys_dup>:
  8001a6:	862e                	mv	a2,a1
  8001a8:	85aa                	mv	a1,a0
  8001aa:	08200513          	li	a0,130
  8001ae:	b771                	j	80013a <syscall>

00000000008001b0 <exit>:
  8001b0:	1141                	addi	sp,sp,-16
  8001b2:	e406                	sd	ra,8(sp)
  8001b4:	fbfff0ef          	jal	ra,800172 <sys_exit>
  8001b8:	00000517          	auipc	a0,0x0
  8001bc:	61050513          	addi	a0,a0,1552 # 8007c8 <main+0x112>
  8001c0:	f3fff0ef          	jal	ra,8000fe <cprintf>
  8001c4:	a001                	j	8001c4 <exit+0x14>

00000000008001c6 <fork>:
  8001c6:	bf4d                	j	800178 <sys_fork>

00000000008001c8 <waitpid>:
  8001c8:	bf55                	j	80017c <sys_wait>

00000000008001ca <yield>:
  8001ca:	bf6d                	j	800184 <sys_yield>

00000000008001cc <kill>:
  8001cc:	bf75                	j	800188 <sys_kill>

00000000008001ce <initfd>:
  8001ce:	1101                	addi	sp,sp,-32
  8001d0:	87ae                	mv	a5,a1
  8001d2:	e426                	sd	s1,8(sp)
  8001d4:	85b2                	mv	a1,a2
  8001d6:	84aa                	mv	s1,a0
  8001d8:	853e                	mv	a0,a5
  8001da:	e822                	sd	s0,16(sp)
  8001dc:	ec06                	sd	ra,24(sp)
  8001de:	e43ff0ef          	jal	ra,800020 <open>
  8001e2:	842a                	mv	s0,a0
  8001e4:	00054463          	bltz	a0,8001ec <initfd+0x1e>
  8001e8:	00951863          	bne	a0,s1,8001f8 <initfd+0x2a>
  8001ec:	60e2                	ld	ra,24(sp)
  8001ee:	8522                	mv	a0,s0
  8001f0:	6442                	ld	s0,16(sp)
  8001f2:	64a2                	ld	s1,8(sp)
  8001f4:	6105                	addi	sp,sp,32
  8001f6:	8082                	ret
  8001f8:	8526                	mv	a0,s1
  8001fa:	e2dff0ef          	jal	ra,800026 <close>
  8001fe:	85a6                	mv	a1,s1
  800200:	8522                	mv	a0,s0
  800202:	e27ff0ef          	jal	ra,800028 <dup2>
  800206:	84aa                	mv	s1,a0
  800208:	8522                	mv	a0,s0
  80020a:	e1dff0ef          	jal	ra,800026 <close>
  80020e:	8426                	mv	s0,s1
  800210:	bff1                	j	8001ec <initfd+0x1e>

0000000000800212 <umain>:
  800212:	1101                	addi	sp,sp,-32
  800214:	e822                	sd	s0,16(sp)
  800216:	e426                	sd	s1,8(sp)
  800218:	842a                	mv	s0,a0
  80021a:	84ae                	mv	s1,a1
  80021c:	4601                	li	a2,0
  80021e:	00000597          	auipc	a1,0x0
  800222:	5c258593          	addi	a1,a1,1474 # 8007e0 <main+0x12a>
  800226:	4501                	li	a0,0
  800228:	ec06                	sd	ra,24(sp)
  80022a:	fa5ff0ef          	jal	ra,8001ce <initfd>
  80022e:	02054263          	bltz	a0,800252 <umain+0x40>
  800232:	4605                	li	a2,1
  800234:	00000597          	auipc	a1,0x0
  800238:	5ec58593          	addi	a1,a1,1516 # 800820 <main+0x16a>
  80023c:	4505                	li	a0,1
  80023e:	f91ff0ef          	jal	ra,8001ce <initfd>
  800242:	02054563          	bltz	a0,80026c <umain+0x5a>
  800246:	85a6                	mv	a1,s1
  800248:	8522                	mv	a0,s0
  80024a:	46c000ef          	jal	ra,8006b6 <main>
  80024e:	f63ff0ef          	jal	ra,8001b0 <exit>
  800252:	86aa                	mv	a3,a0
  800254:	00000617          	auipc	a2,0x0
  800258:	59460613          	addi	a2,a2,1428 # 8007e8 <main+0x132>
  80025c:	45e9                	li	a1,26
  80025e:	00000517          	auipc	a0,0x0
  800262:	5aa50513          	addi	a0,a0,1450 # 800808 <main+0x152>
  800266:	e15ff0ef          	jal	ra,80007a <__warn>
  80026a:	b7e1                	j	800232 <umain+0x20>
  80026c:	86aa                	mv	a3,a0
  80026e:	00000617          	auipc	a2,0x0
  800272:	5ba60613          	addi	a2,a2,1466 # 800828 <main+0x172>
  800276:	45f5                	li	a1,29
  800278:	00000517          	auipc	a0,0x0
  80027c:	59050513          	addi	a0,a0,1424 # 800808 <main+0x152>
  800280:	dfbff0ef          	jal	ra,80007a <__warn>
  800284:	b7c9                	j	800246 <umain+0x34>

0000000000800286 <printnum>:
  800286:	02071893          	slli	a7,a4,0x20
  80028a:	7139                	addi	sp,sp,-64
  80028c:	0208d893          	srli	a7,a7,0x20
  800290:	e456                	sd	s5,8(sp)
  800292:	0316fab3          	remu	s5,a3,a7
  800296:	f822                	sd	s0,48(sp)
  800298:	f426                	sd	s1,40(sp)
  80029a:	f04a                	sd	s2,32(sp)
  80029c:	ec4e                	sd	s3,24(sp)
  80029e:	fc06                	sd	ra,56(sp)
  8002a0:	e852                	sd	s4,16(sp)
  8002a2:	84aa                	mv	s1,a0
  8002a4:	89ae                	mv	s3,a1
  8002a6:	8932                	mv	s2,a2
  8002a8:	fff7841b          	addiw	s0,a5,-1
  8002ac:	2a81                	sext.w	s5,s5
  8002ae:	0516f163          	bgeu	a3,a7,8002f0 <printnum+0x6a>
  8002b2:	8a42                	mv	s4,a6
  8002b4:	00805863          	blez	s0,8002c4 <printnum+0x3e>
  8002b8:	347d                	addiw	s0,s0,-1
  8002ba:	864e                	mv	a2,s3
  8002bc:	85ca                	mv	a1,s2
  8002be:	8552                	mv	a0,s4
  8002c0:	9482                	jalr	s1
  8002c2:	f87d                	bnez	s0,8002b8 <printnum+0x32>
  8002c4:	1a82                	slli	s5,s5,0x20
  8002c6:	00000797          	auipc	a5,0x0
  8002ca:	58278793          	addi	a5,a5,1410 # 800848 <main+0x192>
  8002ce:	020ada93          	srli	s5,s5,0x20
  8002d2:	9abe                	add	s5,s5,a5
  8002d4:	7442                	ld	s0,48(sp)
  8002d6:	000ac503          	lbu	a0,0(s5)
  8002da:	70e2                	ld	ra,56(sp)
  8002dc:	6a42                	ld	s4,16(sp)
  8002de:	6aa2                	ld	s5,8(sp)
  8002e0:	864e                	mv	a2,s3
  8002e2:	85ca                	mv	a1,s2
  8002e4:	69e2                	ld	s3,24(sp)
  8002e6:	7902                	ld	s2,32(sp)
  8002e8:	87a6                	mv	a5,s1
  8002ea:	74a2                	ld	s1,40(sp)
  8002ec:	6121                	addi	sp,sp,64
  8002ee:	8782                	jr	a5
  8002f0:	0316d6b3          	divu	a3,a3,a7
  8002f4:	87a2                	mv	a5,s0
  8002f6:	f91ff0ef          	jal	ra,800286 <printnum>
  8002fa:	b7e9                	j	8002c4 <printnum+0x3e>

00000000008002fc <vprintfmt>:
  8002fc:	7119                	addi	sp,sp,-128
  8002fe:	f4a6                	sd	s1,104(sp)
  800300:	f0ca                	sd	s2,96(sp)
  800302:	ecce                	sd	s3,88(sp)
  800304:	e8d2                	sd	s4,80(sp)
  800306:	e4d6                	sd	s5,72(sp)
  800308:	e0da                	sd	s6,64(sp)
  80030a:	fc5e                	sd	s7,56(sp)
  80030c:	ec6e                	sd	s11,24(sp)
  80030e:	fc86                	sd	ra,120(sp)
  800310:	f8a2                	sd	s0,112(sp)
  800312:	f862                	sd	s8,48(sp)
  800314:	f466                	sd	s9,40(sp)
  800316:	f06a                	sd	s10,32(sp)
  800318:	89aa                	mv	s3,a0
  80031a:	892e                	mv	s2,a1
  80031c:	84b2                	mv	s1,a2
  80031e:	8db6                	mv	s11,a3
  800320:	8aba                	mv	s5,a4
  800322:	02500a13          	li	s4,37
  800326:	5bfd                	li	s7,-1
  800328:	00000b17          	auipc	s6,0x0
  80032c:	554b0b13          	addi	s6,s6,1364 # 80087c <main+0x1c6>
  800330:	000dc503          	lbu	a0,0(s11)
  800334:	001d8413          	addi	s0,s11,1
  800338:	01450b63          	beq	a0,s4,80034e <vprintfmt+0x52>
  80033c:	c129                	beqz	a0,80037e <vprintfmt+0x82>
  80033e:	864a                	mv	a2,s2
  800340:	85a6                	mv	a1,s1
  800342:	0405                	addi	s0,s0,1
  800344:	9982                	jalr	s3
  800346:	fff44503          	lbu	a0,-1(s0)
  80034a:	ff4519e3          	bne	a0,s4,80033c <vprintfmt+0x40>
  80034e:	00044583          	lbu	a1,0(s0)
  800352:	02000813          	li	a6,32
  800356:	4d01                	li	s10,0
  800358:	4301                	li	t1,0
  80035a:	5cfd                	li	s9,-1
  80035c:	5c7d                	li	s8,-1
  80035e:	05500513          	li	a0,85
  800362:	48a5                	li	a7,9
  800364:	fdd5861b          	addiw	a2,a1,-35
  800368:	0ff67613          	zext.b	a2,a2
  80036c:	00140d93          	addi	s11,s0,1
  800370:	04c56263          	bltu	a0,a2,8003b4 <vprintfmt+0xb8>
  800374:	060a                	slli	a2,a2,0x2
  800376:	965a                	add	a2,a2,s6
  800378:	4214                	lw	a3,0(a2)
  80037a:	96da                	add	a3,a3,s6
  80037c:	8682                	jr	a3
  80037e:	70e6                	ld	ra,120(sp)
  800380:	7446                	ld	s0,112(sp)
  800382:	74a6                	ld	s1,104(sp)
  800384:	7906                	ld	s2,96(sp)
  800386:	69e6                	ld	s3,88(sp)
  800388:	6a46                	ld	s4,80(sp)
  80038a:	6aa6                	ld	s5,72(sp)
  80038c:	6b06                	ld	s6,64(sp)
  80038e:	7be2                	ld	s7,56(sp)
  800390:	7c42                	ld	s8,48(sp)
  800392:	7ca2                	ld	s9,40(sp)
  800394:	7d02                	ld	s10,32(sp)
  800396:	6de2                	ld	s11,24(sp)
  800398:	6109                	addi	sp,sp,128
  80039a:	8082                	ret
  80039c:	882e                	mv	a6,a1
  80039e:	00144583          	lbu	a1,1(s0)
  8003a2:	846e                	mv	s0,s11
  8003a4:	00140d93          	addi	s11,s0,1
  8003a8:	fdd5861b          	addiw	a2,a1,-35
  8003ac:	0ff67613          	zext.b	a2,a2
  8003b0:	fcc572e3          	bgeu	a0,a2,800374 <vprintfmt+0x78>
  8003b4:	864a                	mv	a2,s2
  8003b6:	85a6                	mv	a1,s1
  8003b8:	02500513          	li	a0,37
  8003bc:	9982                	jalr	s3
  8003be:	fff44783          	lbu	a5,-1(s0)
  8003c2:	8da2                	mv	s11,s0
  8003c4:	f74786e3          	beq	a5,s4,800330 <vprintfmt+0x34>
  8003c8:	ffedc783          	lbu	a5,-2(s11)
  8003cc:	1dfd                	addi	s11,s11,-1
  8003ce:	ff479de3          	bne	a5,s4,8003c8 <vprintfmt+0xcc>
  8003d2:	bfb9                	j	800330 <vprintfmt+0x34>
  8003d4:	fd058c9b          	addiw	s9,a1,-48
  8003d8:	00144583          	lbu	a1,1(s0)
  8003dc:	846e                	mv	s0,s11
  8003de:	fd05869b          	addiw	a3,a1,-48
  8003e2:	0005861b          	sext.w	a2,a1
  8003e6:	02d8e463          	bltu	a7,a3,80040e <vprintfmt+0x112>
  8003ea:	00144583          	lbu	a1,1(s0)
  8003ee:	002c969b          	slliw	a3,s9,0x2
  8003f2:	0196873b          	addw	a4,a3,s9
  8003f6:	0017171b          	slliw	a4,a4,0x1
  8003fa:	9f31                	addw	a4,a4,a2
  8003fc:	fd05869b          	addiw	a3,a1,-48
  800400:	0405                	addi	s0,s0,1
  800402:	fd070c9b          	addiw	s9,a4,-48
  800406:	0005861b          	sext.w	a2,a1
  80040a:	fed8f0e3          	bgeu	a7,a3,8003ea <vprintfmt+0xee>
  80040e:	f40c5be3          	bgez	s8,800364 <vprintfmt+0x68>
  800412:	8c66                	mv	s8,s9
  800414:	5cfd                	li	s9,-1
  800416:	b7b9                	j	800364 <vprintfmt+0x68>
  800418:	fffc4693          	not	a3,s8
  80041c:	96fd                	srai	a3,a3,0x3f
  80041e:	00dc77b3          	and	a5,s8,a3
  800422:	00144583          	lbu	a1,1(s0)
  800426:	00078c1b          	sext.w	s8,a5
  80042a:	846e                	mv	s0,s11
  80042c:	bf25                	j	800364 <vprintfmt+0x68>
  80042e:	000aac83          	lw	s9,0(s5)
  800432:	00144583          	lbu	a1,1(s0)
  800436:	0aa1                	addi	s5,s5,8
  800438:	846e                	mv	s0,s11
  80043a:	bfd1                	j	80040e <vprintfmt+0x112>
  80043c:	4705                	li	a4,1
  80043e:	008a8613          	addi	a2,s5,8
  800442:	00674463          	blt	a4,t1,80044a <vprintfmt+0x14e>
  800446:	1c030c63          	beqz	t1,80061e <vprintfmt+0x322>
  80044a:	000ab683          	ld	a3,0(s5)
  80044e:	4741                	li	a4,16
  800450:	8ab2                	mv	s5,a2
  800452:	2801                	sext.w	a6,a6
  800454:	87e2                	mv	a5,s8
  800456:	8626                	mv	a2,s1
  800458:	85ca                	mv	a1,s2
  80045a:	854e                	mv	a0,s3
  80045c:	e2bff0ef          	jal	ra,800286 <printnum>
  800460:	bdc1                	j	800330 <vprintfmt+0x34>
  800462:	000aa503          	lw	a0,0(s5)
  800466:	864a                	mv	a2,s2
  800468:	85a6                	mv	a1,s1
  80046a:	0aa1                	addi	s5,s5,8
  80046c:	9982                	jalr	s3
  80046e:	b5c9                	j	800330 <vprintfmt+0x34>
  800470:	4705                	li	a4,1
  800472:	008a8613          	addi	a2,s5,8
  800476:	00674463          	blt	a4,t1,80047e <vprintfmt+0x182>
  80047a:	18030d63          	beqz	t1,800614 <vprintfmt+0x318>
  80047e:	000ab683          	ld	a3,0(s5)
  800482:	4729                	li	a4,10
  800484:	8ab2                	mv	s5,a2
  800486:	b7f1                	j	800452 <vprintfmt+0x156>
  800488:	00144583          	lbu	a1,1(s0)
  80048c:	4d05                	li	s10,1
  80048e:	846e                	mv	s0,s11
  800490:	bdd1                	j	800364 <vprintfmt+0x68>
  800492:	864a                	mv	a2,s2
  800494:	85a6                	mv	a1,s1
  800496:	02500513          	li	a0,37
  80049a:	9982                	jalr	s3
  80049c:	bd51                	j	800330 <vprintfmt+0x34>
  80049e:	00144583          	lbu	a1,1(s0)
  8004a2:	2305                	addiw	t1,t1,1
  8004a4:	846e                	mv	s0,s11
  8004a6:	bd7d                	j	800364 <vprintfmt+0x68>
  8004a8:	4705                	li	a4,1
  8004aa:	008a8613          	addi	a2,s5,8
  8004ae:	00674463          	blt	a4,t1,8004b6 <vprintfmt+0x1ba>
  8004b2:	14030c63          	beqz	t1,80060a <vprintfmt+0x30e>
  8004b6:	000ab683          	ld	a3,0(s5)
  8004ba:	4721                	li	a4,8
  8004bc:	8ab2                	mv	s5,a2
  8004be:	bf51                	j	800452 <vprintfmt+0x156>
  8004c0:	03000513          	li	a0,48
  8004c4:	864a                	mv	a2,s2
  8004c6:	85a6                	mv	a1,s1
  8004c8:	e042                	sd	a6,0(sp)
  8004ca:	9982                	jalr	s3
  8004cc:	864a                	mv	a2,s2
  8004ce:	85a6                	mv	a1,s1
  8004d0:	07800513          	li	a0,120
  8004d4:	9982                	jalr	s3
  8004d6:	0aa1                	addi	s5,s5,8
  8004d8:	6802                	ld	a6,0(sp)
  8004da:	4741                	li	a4,16
  8004dc:	ff8ab683          	ld	a3,-8(s5)
  8004e0:	bf8d                	j	800452 <vprintfmt+0x156>
  8004e2:	000ab403          	ld	s0,0(s5)
  8004e6:	008a8793          	addi	a5,s5,8
  8004ea:	e03e                	sd	a5,0(sp)
  8004ec:	14040c63          	beqz	s0,800644 <vprintfmt+0x348>
  8004f0:	11805063          	blez	s8,8005f0 <vprintfmt+0x2f4>
  8004f4:	02d00693          	li	a3,45
  8004f8:	0cd81963          	bne	a6,a3,8005ca <vprintfmt+0x2ce>
  8004fc:	00044683          	lbu	a3,0(s0)
  800500:	0006851b          	sext.w	a0,a3
  800504:	ce8d                	beqz	a3,80053e <vprintfmt+0x242>
  800506:	00140a93          	addi	s5,s0,1
  80050a:	05e00413          	li	s0,94
  80050e:	000cc563          	bltz	s9,800518 <vprintfmt+0x21c>
  800512:	3cfd                	addiw	s9,s9,-1
  800514:	037c8363          	beq	s9,s7,80053a <vprintfmt+0x23e>
  800518:	864a                	mv	a2,s2
  80051a:	85a6                	mv	a1,s1
  80051c:	100d0663          	beqz	s10,800628 <vprintfmt+0x32c>
  800520:	3681                	addiw	a3,a3,-32
  800522:	10d47363          	bgeu	s0,a3,800628 <vprintfmt+0x32c>
  800526:	03f00513          	li	a0,63
  80052a:	9982                	jalr	s3
  80052c:	000ac683          	lbu	a3,0(s5)
  800530:	3c7d                	addiw	s8,s8,-1
  800532:	0a85                	addi	s5,s5,1
  800534:	0006851b          	sext.w	a0,a3
  800538:	faf9                	bnez	a3,80050e <vprintfmt+0x212>
  80053a:	01805a63          	blez	s8,80054e <vprintfmt+0x252>
  80053e:	3c7d                	addiw	s8,s8,-1
  800540:	864a                	mv	a2,s2
  800542:	85a6                	mv	a1,s1
  800544:	02000513          	li	a0,32
  800548:	9982                	jalr	s3
  80054a:	fe0c1ae3          	bnez	s8,80053e <vprintfmt+0x242>
  80054e:	6a82                	ld	s5,0(sp)
  800550:	b3c5                	j	800330 <vprintfmt+0x34>
  800552:	4705                	li	a4,1
  800554:	008a8d13          	addi	s10,s5,8
  800558:	00674463          	blt	a4,t1,800560 <vprintfmt+0x264>
  80055c:	0a030463          	beqz	t1,800604 <vprintfmt+0x308>
  800560:	000ab403          	ld	s0,0(s5)
  800564:	0c044463          	bltz	s0,80062c <vprintfmt+0x330>
  800568:	86a2                	mv	a3,s0
  80056a:	8aea                	mv	s5,s10
  80056c:	4729                	li	a4,10
  80056e:	b5d5                	j	800452 <vprintfmt+0x156>
  800570:	000aa783          	lw	a5,0(s5)
  800574:	46e1                	li	a3,24
  800576:	0aa1                	addi	s5,s5,8
  800578:	41f7d71b          	sraiw	a4,a5,0x1f
  80057c:	8fb9                	xor	a5,a5,a4
  80057e:	40e7873b          	subw	a4,a5,a4
  800582:	02e6c663          	blt	a3,a4,8005ae <vprintfmt+0x2b2>
  800586:	00371793          	slli	a5,a4,0x3
  80058a:	00000697          	auipc	a3,0x0
  80058e:	62668693          	addi	a3,a3,1574 # 800bb0 <error_string>
  800592:	97b6                	add	a5,a5,a3
  800594:	639c                	ld	a5,0(a5)
  800596:	cf81                	beqz	a5,8005ae <vprintfmt+0x2b2>
  800598:	873e                	mv	a4,a5
  80059a:	00000697          	auipc	a3,0x0
  80059e:	2de68693          	addi	a3,a3,734 # 800878 <main+0x1c2>
  8005a2:	8626                	mv	a2,s1
  8005a4:	85ca                	mv	a1,s2
  8005a6:	854e                	mv	a0,s3
  8005a8:	0d4000ef          	jal	ra,80067c <printfmt>
  8005ac:	b351                	j	800330 <vprintfmt+0x34>
  8005ae:	00000697          	auipc	a3,0x0
  8005b2:	2ba68693          	addi	a3,a3,698 # 800868 <main+0x1b2>
  8005b6:	8626                	mv	a2,s1
  8005b8:	85ca                	mv	a1,s2
  8005ba:	854e                	mv	a0,s3
  8005bc:	0c0000ef          	jal	ra,80067c <printfmt>
  8005c0:	bb85                	j	800330 <vprintfmt+0x34>
  8005c2:	00000417          	auipc	s0,0x0
  8005c6:	29e40413          	addi	s0,s0,670 # 800860 <main+0x1aa>
  8005ca:	85e6                	mv	a1,s9
  8005cc:	8522                	mv	a0,s0
  8005ce:	e442                	sd	a6,8(sp)
  8005d0:	0ca000ef          	jal	ra,80069a <strnlen>
  8005d4:	40ac0c3b          	subw	s8,s8,a0
  8005d8:	01805c63          	blez	s8,8005f0 <vprintfmt+0x2f4>
  8005dc:	6822                	ld	a6,8(sp)
  8005de:	00080a9b          	sext.w	s5,a6
  8005e2:	3c7d                	addiw	s8,s8,-1
  8005e4:	864a                	mv	a2,s2
  8005e6:	85a6                	mv	a1,s1
  8005e8:	8556                	mv	a0,s5
  8005ea:	9982                	jalr	s3
  8005ec:	fe0c1be3          	bnez	s8,8005e2 <vprintfmt+0x2e6>
  8005f0:	00044683          	lbu	a3,0(s0)
  8005f4:	00140a93          	addi	s5,s0,1
  8005f8:	0006851b          	sext.w	a0,a3
  8005fc:	daa9                	beqz	a3,80054e <vprintfmt+0x252>
  8005fe:	05e00413          	li	s0,94
  800602:	b731                	j	80050e <vprintfmt+0x212>
  800604:	000aa403          	lw	s0,0(s5)
  800608:	bfb1                	j	800564 <vprintfmt+0x268>
  80060a:	000ae683          	lwu	a3,0(s5)
  80060e:	4721                	li	a4,8
  800610:	8ab2                	mv	s5,a2
  800612:	b581                	j	800452 <vprintfmt+0x156>
  800614:	000ae683          	lwu	a3,0(s5)
  800618:	4729                	li	a4,10
  80061a:	8ab2                	mv	s5,a2
  80061c:	bd1d                	j	800452 <vprintfmt+0x156>
  80061e:	000ae683          	lwu	a3,0(s5)
  800622:	4741                	li	a4,16
  800624:	8ab2                	mv	s5,a2
  800626:	b535                	j	800452 <vprintfmt+0x156>
  800628:	9982                	jalr	s3
  80062a:	b709                	j	80052c <vprintfmt+0x230>
  80062c:	864a                	mv	a2,s2
  80062e:	85a6                	mv	a1,s1
  800630:	02d00513          	li	a0,45
  800634:	e042                	sd	a6,0(sp)
  800636:	9982                	jalr	s3
  800638:	6802                	ld	a6,0(sp)
  80063a:	8aea                	mv	s5,s10
  80063c:	408006b3          	neg	a3,s0
  800640:	4729                	li	a4,10
  800642:	bd01                	j	800452 <vprintfmt+0x156>
  800644:	03805163          	blez	s8,800666 <vprintfmt+0x36a>
  800648:	02d00693          	li	a3,45
  80064c:	f6d81be3          	bne	a6,a3,8005c2 <vprintfmt+0x2c6>
  800650:	00000417          	auipc	s0,0x0
  800654:	21040413          	addi	s0,s0,528 # 800860 <main+0x1aa>
  800658:	02800693          	li	a3,40
  80065c:	02800513          	li	a0,40
  800660:	00140a93          	addi	s5,s0,1
  800664:	b55d                	j	80050a <vprintfmt+0x20e>
  800666:	00000a97          	auipc	s5,0x0
  80066a:	1fba8a93          	addi	s5,s5,507 # 800861 <main+0x1ab>
  80066e:	02800513          	li	a0,40
  800672:	02800693          	li	a3,40
  800676:	05e00413          	li	s0,94
  80067a:	bd51                	j	80050e <vprintfmt+0x212>

000000000080067c <printfmt>:
  80067c:	7139                	addi	sp,sp,-64
  80067e:	02010313          	addi	t1,sp,32
  800682:	f03a                	sd	a4,32(sp)
  800684:	871a                	mv	a4,t1
  800686:	ec06                	sd	ra,24(sp)
  800688:	f43e                	sd	a5,40(sp)
  80068a:	f842                	sd	a6,48(sp)
  80068c:	fc46                	sd	a7,56(sp)
  80068e:	e41a                	sd	t1,8(sp)
  800690:	c6dff0ef          	jal	ra,8002fc <vprintfmt>
  800694:	60e2                	ld	ra,24(sp)
  800696:	6121                	addi	sp,sp,64
  800698:	8082                	ret

000000000080069a <strnlen>:
  80069a:	4781                	li	a5,0
  80069c:	e589                	bnez	a1,8006a6 <strnlen+0xc>
  80069e:	a811                	j	8006b2 <strnlen+0x18>
  8006a0:	0785                	addi	a5,a5,1
  8006a2:	00f58863          	beq	a1,a5,8006b2 <strnlen+0x18>
  8006a6:	00f50733          	add	a4,a0,a5
  8006aa:	00074703          	lbu	a4,0(a4)
  8006ae:	fb6d                	bnez	a4,8006a0 <strnlen+0x6>
  8006b0:	85be                	mv	a1,a5
  8006b2:	852e                	mv	a0,a1
  8006b4:	8082                	ret

00000000008006b6 <main>:
  8006b6:	1141                	addi	sp,sp,-16
  8006b8:	00000517          	auipc	a0,0x0
  8006bc:	5c050513          	addi	a0,a0,1472 # 800c78 <error_string+0xc8>
  8006c0:	e406                	sd	ra,8(sp)
  8006c2:	e022                	sd	s0,0(sp)
  8006c4:	a3bff0ef          	jal	ra,8000fe <cprintf>
  8006c8:	affff0ef          	jal	ra,8001c6 <fork>
  8006cc:	e901                	bnez	a0,8006dc <main+0x26>
  8006ce:	00000517          	auipc	a0,0x0
  8006d2:	5d250513          	addi	a0,a0,1490 # 800ca0 <error_string+0xf0>
  8006d6:	a29ff0ef          	jal	ra,8000fe <cprintf>
  8006da:	a001                	j	8006da <main+0x24>
  8006dc:	842a                	mv	s0,a0
  8006de:	00000517          	auipc	a0,0x0
  8006e2:	5e250513          	addi	a0,a0,1506 # 800cc0 <error_string+0x110>
  8006e6:	a19ff0ef          	jal	ra,8000fe <cprintf>
  8006ea:	ae1ff0ef          	jal	ra,8001ca <yield>
  8006ee:	addff0ef          	jal	ra,8001ca <yield>
  8006f2:	ad9ff0ef          	jal	ra,8001ca <yield>
  8006f6:	00000517          	auipc	a0,0x0
  8006fa:	5f250513          	addi	a0,a0,1522 # 800ce8 <error_string+0x138>
  8006fe:	a01ff0ef          	jal	ra,8000fe <cprintf>
  800702:	8522                	mv	a0,s0
  800704:	ac9ff0ef          	jal	ra,8001cc <kill>
  800708:	ed31                	bnez	a0,800764 <main+0xae>
  80070a:	4581                	li	a1,0
  80070c:	00000517          	auipc	a0,0x0
  800710:	64450513          	addi	a0,a0,1604 # 800d50 <error_string+0x1a0>
  800714:	9ebff0ef          	jal	ra,8000fe <cprintf>
  800718:	4581                	li	a1,0
  80071a:	8522                	mv	a0,s0
  80071c:	aadff0ef          	jal	ra,8001c8 <waitpid>
  800720:	e11d                	bnez	a0,800746 <main+0x90>
  800722:	4581                	li	a1,0
  800724:	00000517          	auipc	a0,0x0
  800728:	66450513          	addi	a0,a0,1636 # 800d88 <error_string+0x1d8>
  80072c:	9d3ff0ef          	jal	ra,8000fe <cprintf>
  800730:	00000517          	auipc	a0,0x0
  800734:	67050513          	addi	a0,a0,1648 # 800da0 <error_string+0x1f0>
  800738:	9c7ff0ef          	jal	ra,8000fe <cprintf>
  80073c:	60a2                	ld	ra,8(sp)
  80073e:	6402                	ld	s0,0(sp)
  800740:	4501                	li	a0,0
  800742:	0141                	addi	sp,sp,16
  800744:	8082                	ret
  800746:	00000697          	auipc	a3,0x0
  80074a:	62268693          	addi	a3,a3,1570 # 800d68 <error_string+0x1b8>
  80074e:	00000617          	auipc	a2,0x0
  800752:	5da60613          	addi	a2,a2,1498 # 800d28 <error_string+0x178>
  800756:	45dd                	li	a1,23
  800758:	00000517          	auipc	a0,0x0
  80075c:	5e850513          	addi	a0,a0,1512 # 800d40 <error_string+0x190>
  800760:	8d9ff0ef          	jal	ra,800038 <__panic>
  800764:	00000697          	auipc	a3,0x0
  800768:	5ac68693          	addi	a3,a3,1452 # 800d10 <error_string+0x160>
  80076c:	00000617          	auipc	a2,0x0
  800770:	5bc60613          	addi	a2,a2,1468 # 800d28 <error_string+0x178>
  800774:	45d1                	li	a1,20
  800776:	00000517          	auipc	a0,0x0
  80077a:	5ca50513          	addi	a0,a0,1482 # 800d40 <error_string+0x190>
  80077e:	8bbff0ef          	jal	ra,800038 <__panic>
