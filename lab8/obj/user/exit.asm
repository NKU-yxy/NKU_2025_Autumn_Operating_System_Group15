
obj/__user_exit.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	a2ad                	j	80018e <sys_open>

0000000000800026 <close>:
  800026:	aa8d                	j	800198 <sys_close>

0000000000800028 <dup2>:
  800028:	aaa5                	j	8001a0 <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	1de000ef          	jal	ra,800210 <umain>
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
  80004c:	78050513          	addi	a0,a0,1920 # 8007c8 <main+0x114>
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
  80006c:	7d850513          	addi	a0,a0,2008 # 800840 <main+0x18c>
  800070:	08e000ef          	jal	ra,8000fe <cprintf>
  800074:	5559                	li	a0,-10
  800076:	134000ef          	jal	ra,8001aa <exit>

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
  80008e:	75e50513          	addi	a0,a0,1886 # 8007e8 <main+0x134>
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
  8000ae:	79650513          	addi	a0,a0,1942 # 800840 <main+0x18c>
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
  8000c6:	0c2000ef          	jal	ra,800188 <sys_putc>
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
  8000f2:	208000ef          	jal	ra,8002fa <vprintfmt>
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
  80012e:	1cc000ef          	jal	ra,8002fa <vprintfmt>
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

0000000000800188 <sys_putc>:
  800188:	85aa                	mv	a1,a0
  80018a:	4579                	li	a0,30
  80018c:	b77d                	j	80013a <syscall>

000000000080018e <sys_open>:
  80018e:	862e                	mv	a2,a1
  800190:	85aa                	mv	a1,a0
  800192:	06400513          	li	a0,100
  800196:	b755                	j	80013a <syscall>

0000000000800198 <sys_close>:
  800198:	85aa                	mv	a1,a0
  80019a:	06500513          	li	a0,101
  80019e:	bf71                	j	80013a <syscall>

00000000008001a0 <sys_dup>:
  8001a0:	862e                	mv	a2,a1
  8001a2:	85aa                	mv	a1,a0
  8001a4:	08200513          	li	a0,130
  8001a8:	bf49                	j	80013a <syscall>

00000000008001aa <exit>:
  8001aa:	1141                	addi	sp,sp,-16
  8001ac:	e406                	sd	ra,8(sp)
  8001ae:	fc5ff0ef          	jal	ra,800172 <sys_exit>
  8001b2:	00000517          	auipc	a0,0x0
  8001b6:	65650513          	addi	a0,a0,1622 # 800808 <main+0x154>
  8001ba:	f45ff0ef          	jal	ra,8000fe <cprintf>
  8001be:	a001                	j	8001be <exit+0x14>

00000000008001c0 <fork>:
  8001c0:	bf65                	j	800178 <sys_fork>

00000000008001c2 <wait>:
  8001c2:	4581                	li	a1,0
  8001c4:	4501                	li	a0,0
  8001c6:	bf5d                	j	80017c <sys_wait>

00000000008001c8 <waitpid>:
  8001c8:	bf55                	j	80017c <sys_wait>

00000000008001ca <yield>:
  8001ca:	bf6d                	j	800184 <sys_yield>

00000000008001cc <initfd>:
  8001cc:	1101                	addi	sp,sp,-32
  8001ce:	87ae                	mv	a5,a1
  8001d0:	e426                	sd	s1,8(sp)
  8001d2:	85b2                	mv	a1,a2
  8001d4:	84aa                	mv	s1,a0
  8001d6:	853e                	mv	a0,a5
  8001d8:	e822                	sd	s0,16(sp)
  8001da:	ec06                	sd	ra,24(sp)
  8001dc:	e45ff0ef          	jal	ra,800020 <open>
  8001e0:	842a                	mv	s0,a0
  8001e2:	00054463          	bltz	a0,8001ea <initfd+0x1e>
  8001e6:	00951863          	bne	a0,s1,8001f6 <initfd+0x2a>
  8001ea:	60e2                	ld	ra,24(sp)
  8001ec:	8522                	mv	a0,s0
  8001ee:	6442                	ld	s0,16(sp)
  8001f0:	64a2                	ld	s1,8(sp)
  8001f2:	6105                	addi	sp,sp,32
  8001f4:	8082                	ret
  8001f6:	8526                	mv	a0,s1
  8001f8:	e2fff0ef          	jal	ra,800026 <close>
  8001fc:	85a6                	mv	a1,s1
  8001fe:	8522                	mv	a0,s0
  800200:	e29ff0ef          	jal	ra,800028 <dup2>
  800204:	84aa                	mv	s1,a0
  800206:	8522                	mv	a0,s0
  800208:	e1fff0ef          	jal	ra,800026 <close>
  80020c:	8426                	mv	s0,s1
  80020e:	bff1                	j	8001ea <initfd+0x1e>

0000000000800210 <umain>:
  800210:	1101                	addi	sp,sp,-32
  800212:	e822                	sd	s0,16(sp)
  800214:	e426                	sd	s1,8(sp)
  800216:	842a                	mv	s0,a0
  800218:	84ae                	mv	s1,a1
  80021a:	4601                	li	a2,0
  80021c:	00000597          	auipc	a1,0x0
  800220:	60458593          	addi	a1,a1,1540 # 800820 <main+0x16c>
  800224:	4501                	li	a0,0
  800226:	ec06                	sd	ra,24(sp)
  800228:	fa5ff0ef          	jal	ra,8001cc <initfd>
  80022c:	02054263          	bltz	a0,800250 <umain+0x40>
  800230:	4605                	li	a2,1
  800232:	00000597          	auipc	a1,0x0
  800236:	62e58593          	addi	a1,a1,1582 # 800860 <main+0x1ac>
  80023a:	4505                	li	a0,1
  80023c:	f91ff0ef          	jal	ra,8001cc <initfd>
  800240:	02054563          	bltz	a0,80026a <umain+0x5a>
  800244:	85a6                	mv	a1,s1
  800246:	8522                	mv	a0,s0
  800248:	46c000ef          	jal	ra,8006b4 <main>
  80024c:	f5fff0ef          	jal	ra,8001aa <exit>
  800250:	86aa                	mv	a3,a0
  800252:	00000617          	auipc	a2,0x0
  800256:	5d660613          	addi	a2,a2,1494 # 800828 <main+0x174>
  80025a:	45e9                	li	a1,26
  80025c:	00000517          	auipc	a0,0x0
  800260:	5ec50513          	addi	a0,a0,1516 # 800848 <main+0x194>
  800264:	e17ff0ef          	jal	ra,80007a <__warn>
  800268:	b7e1                	j	800230 <umain+0x20>
  80026a:	86aa                	mv	a3,a0
  80026c:	00000617          	auipc	a2,0x0
  800270:	5fc60613          	addi	a2,a2,1532 # 800868 <main+0x1b4>
  800274:	45f5                	li	a1,29
  800276:	00000517          	auipc	a0,0x0
  80027a:	5d250513          	addi	a0,a0,1490 # 800848 <main+0x194>
  80027e:	dfdff0ef          	jal	ra,80007a <__warn>
  800282:	b7c9                	j	800244 <umain+0x34>

0000000000800284 <printnum>:
  800284:	02071893          	slli	a7,a4,0x20
  800288:	7139                	addi	sp,sp,-64
  80028a:	0208d893          	srli	a7,a7,0x20
  80028e:	e456                	sd	s5,8(sp)
  800290:	0316fab3          	remu	s5,a3,a7
  800294:	f822                	sd	s0,48(sp)
  800296:	f426                	sd	s1,40(sp)
  800298:	f04a                	sd	s2,32(sp)
  80029a:	ec4e                	sd	s3,24(sp)
  80029c:	fc06                	sd	ra,56(sp)
  80029e:	e852                	sd	s4,16(sp)
  8002a0:	84aa                	mv	s1,a0
  8002a2:	89ae                	mv	s3,a1
  8002a4:	8932                	mv	s2,a2
  8002a6:	fff7841b          	addiw	s0,a5,-1
  8002aa:	2a81                	sext.w	s5,s5
  8002ac:	0516f163          	bgeu	a3,a7,8002ee <printnum+0x6a>
  8002b0:	8a42                	mv	s4,a6
  8002b2:	00805863          	blez	s0,8002c2 <printnum+0x3e>
  8002b6:	347d                	addiw	s0,s0,-1
  8002b8:	864e                	mv	a2,s3
  8002ba:	85ca                	mv	a1,s2
  8002bc:	8552                	mv	a0,s4
  8002be:	9482                	jalr	s1
  8002c0:	f87d                	bnez	s0,8002b6 <printnum+0x32>
  8002c2:	1a82                	slli	s5,s5,0x20
  8002c4:	00000797          	auipc	a5,0x0
  8002c8:	5c478793          	addi	a5,a5,1476 # 800888 <main+0x1d4>
  8002cc:	020ada93          	srli	s5,s5,0x20
  8002d0:	9abe                	add	s5,s5,a5
  8002d2:	7442                	ld	s0,48(sp)
  8002d4:	000ac503          	lbu	a0,0(s5)
  8002d8:	70e2                	ld	ra,56(sp)
  8002da:	6a42                	ld	s4,16(sp)
  8002dc:	6aa2                	ld	s5,8(sp)
  8002de:	864e                	mv	a2,s3
  8002e0:	85ca                	mv	a1,s2
  8002e2:	69e2                	ld	s3,24(sp)
  8002e4:	7902                	ld	s2,32(sp)
  8002e6:	87a6                	mv	a5,s1
  8002e8:	74a2                	ld	s1,40(sp)
  8002ea:	6121                	addi	sp,sp,64
  8002ec:	8782                	jr	a5
  8002ee:	0316d6b3          	divu	a3,a3,a7
  8002f2:	87a2                	mv	a5,s0
  8002f4:	f91ff0ef          	jal	ra,800284 <printnum>
  8002f8:	b7e9                	j	8002c2 <printnum+0x3e>

00000000008002fa <vprintfmt>:
  8002fa:	7119                	addi	sp,sp,-128
  8002fc:	f4a6                	sd	s1,104(sp)
  8002fe:	f0ca                	sd	s2,96(sp)
  800300:	ecce                	sd	s3,88(sp)
  800302:	e8d2                	sd	s4,80(sp)
  800304:	e4d6                	sd	s5,72(sp)
  800306:	e0da                	sd	s6,64(sp)
  800308:	fc5e                	sd	s7,56(sp)
  80030a:	ec6e                	sd	s11,24(sp)
  80030c:	fc86                	sd	ra,120(sp)
  80030e:	f8a2                	sd	s0,112(sp)
  800310:	f862                	sd	s8,48(sp)
  800312:	f466                	sd	s9,40(sp)
  800314:	f06a                	sd	s10,32(sp)
  800316:	89aa                	mv	s3,a0
  800318:	892e                	mv	s2,a1
  80031a:	84b2                	mv	s1,a2
  80031c:	8db6                	mv	s11,a3
  80031e:	8aba                	mv	s5,a4
  800320:	02500a13          	li	s4,37
  800324:	5bfd                	li	s7,-1
  800326:	00000b17          	auipc	s6,0x0
  80032a:	596b0b13          	addi	s6,s6,1430 # 8008bc <main+0x208>
  80032e:	000dc503          	lbu	a0,0(s11)
  800332:	001d8413          	addi	s0,s11,1
  800336:	01450b63          	beq	a0,s4,80034c <vprintfmt+0x52>
  80033a:	c129                	beqz	a0,80037c <vprintfmt+0x82>
  80033c:	864a                	mv	a2,s2
  80033e:	85a6                	mv	a1,s1
  800340:	0405                	addi	s0,s0,1
  800342:	9982                	jalr	s3
  800344:	fff44503          	lbu	a0,-1(s0)
  800348:	ff4519e3          	bne	a0,s4,80033a <vprintfmt+0x40>
  80034c:	00044583          	lbu	a1,0(s0)
  800350:	02000813          	li	a6,32
  800354:	4d01                	li	s10,0
  800356:	4301                	li	t1,0
  800358:	5cfd                	li	s9,-1
  80035a:	5c7d                	li	s8,-1
  80035c:	05500513          	li	a0,85
  800360:	48a5                	li	a7,9
  800362:	fdd5861b          	addiw	a2,a1,-35
  800366:	0ff67613          	zext.b	a2,a2
  80036a:	00140d93          	addi	s11,s0,1
  80036e:	04c56263          	bltu	a0,a2,8003b2 <vprintfmt+0xb8>
  800372:	060a                	slli	a2,a2,0x2
  800374:	965a                	add	a2,a2,s6
  800376:	4214                	lw	a3,0(a2)
  800378:	96da                	add	a3,a3,s6
  80037a:	8682                	jr	a3
  80037c:	70e6                	ld	ra,120(sp)
  80037e:	7446                	ld	s0,112(sp)
  800380:	74a6                	ld	s1,104(sp)
  800382:	7906                	ld	s2,96(sp)
  800384:	69e6                	ld	s3,88(sp)
  800386:	6a46                	ld	s4,80(sp)
  800388:	6aa6                	ld	s5,72(sp)
  80038a:	6b06                	ld	s6,64(sp)
  80038c:	7be2                	ld	s7,56(sp)
  80038e:	7c42                	ld	s8,48(sp)
  800390:	7ca2                	ld	s9,40(sp)
  800392:	7d02                	ld	s10,32(sp)
  800394:	6de2                	ld	s11,24(sp)
  800396:	6109                	addi	sp,sp,128
  800398:	8082                	ret
  80039a:	882e                	mv	a6,a1
  80039c:	00144583          	lbu	a1,1(s0)
  8003a0:	846e                	mv	s0,s11
  8003a2:	00140d93          	addi	s11,s0,1
  8003a6:	fdd5861b          	addiw	a2,a1,-35
  8003aa:	0ff67613          	zext.b	a2,a2
  8003ae:	fcc572e3          	bgeu	a0,a2,800372 <vprintfmt+0x78>
  8003b2:	864a                	mv	a2,s2
  8003b4:	85a6                	mv	a1,s1
  8003b6:	02500513          	li	a0,37
  8003ba:	9982                	jalr	s3
  8003bc:	fff44783          	lbu	a5,-1(s0)
  8003c0:	8da2                	mv	s11,s0
  8003c2:	f74786e3          	beq	a5,s4,80032e <vprintfmt+0x34>
  8003c6:	ffedc783          	lbu	a5,-2(s11)
  8003ca:	1dfd                	addi	s11,s11,-1
  8003cc:	ff479de3          	bne	a5,s4,8003c6 <vprintfmt+0xcc>
  8003d0:	bfb9                	j	80032e <vprintfmt+0x34>
  8003d2:	fd058c9b          	addiw	s9,a1,-48
  8003d6:	00144583          	lbu	a1,1(s0)
  8003da:	846e                	mv	s0,s11
  8003dc:	fd05869b          	addiw	a3,a1,-48
  8003e0:	0005861b          	sext.w	a2,a1
  8003e4:	02d8e463          	bltu	a7,a3,80040c <vprintfmt+0x112>
  8003e8:	00144583          	lbu	a1,1(s0)
  8003ec:	002c969b          	slliw	a3,s9,0x2
  8003f0:	0196873b          	addw	a4,a3,s9
  8003f4:	0017171b          	slliw	a4,a4,0x1
  8003f8:	9f31                	addw	a4,a4,a2
  8003fa:	fd05869b          	addiw	a3,a1,-48
  8003fe:	0405                	addi	s0,s0,1
  800400:	fd070c9b          	addiw	s9,a4,-48
  800404:	0005861b          	sext.w	a2,a1
  800408:	fed8f0e3          	bgeu	a7,a3,8003e8 <vprintfmt+0xee>
  80040c:	f40c5be3          	bgez	s8,800362 <vprintfmt+0x68>
  800410:	8c66                	mv	s8,s9
  800412:	5cfd                	li	s9,-1
  800414:	b7b9                	j	800362 <vprintfmt+0x68>
  800416:	fffc4693          	not	a3,s8
  80041a:	96fd                	srai	a3,a3,0x3f
  80041c:	00dc77b3          	and	a5,s8,a3
  800420:	00144583          	lbu	a1,1(s0)
  800424:	00078c1b          	sext.w	s8,a5
  800428:	846e                	mv	s0,s11
  80042a:	bf25                	j	800362 <vprintfmt+0x68>
  80042c:	000aac83          	lw	s9,0(s5)
  800430:	00144583          	lbu	a1,1(s0)
  800434:	0aa1                	addi	s5,s5,8
  800436:	846e                	mv	s0,s11
  800438:	bfd1                	j	80040c <vprintfmt+0x112>
  80043a:	4705                	li	a4,1
  80043c:	008a8613          	addi	a2,s5,8
  800440:	00674463          	blt	a4,t1,800448 <vprintfmt+0x14e>
  800444:	1c030c63          	beqz	t1,80061c <vprintfmt+0x322>
  800448:	000ab683          	ld	a3,0(s5)
  80044c:	4741                	li	a4,16
  80044e:	8ab2                	mv	s5,a2
  800450:	2801                	sext.w	a6,a6
  800452:	87e2                	mv	a5,s8
  800454:	8626                	mv	a2,s1
  800456:	85ca                	mv	a1,s2
  800458:	854e                	mv	a0,s3
  80045a:	e2bff0ef          	jal	ra,800284 <printnum>
  80045e:	bdc1                	j	80032e <vprintfmt+0x34>
  800460:	000aa503          	lw	a0,0(s5)
  800464:	864a                	mv	a2,s2
  800466:	85a6                	mv	a1,s1
  800468:	0aa1                	addi	s5,s5,8
  80046a:	9982                	jalr	s3
  80046c:	b5c9                	j	80032e <vprintfmt+0x34>
  80046e:	4705                	li	a4,1
  800470:	008a8613          	addi	a2,s5,8
  800474:	00674463          	blt	a4,t1,80047c <vprintfmt+0x182>
  800478:	18030d63          	beqz	t1,800612 <vprintfmt+0x318>
  80047c:	000ab683          	ld	a3,0(s5)
  800480:	4729                	li	a4,10
  800482:	8ab2                	mv	s5,a2
  800484:	b7f1                	j	800450 <vprintfmt+0x156>
  800486:	00144583          	lbu	a1,1(s0)
  80048a:	4d05                	li	s10,1
  80048c:	846e                	mv	s0,s11
  80048e:	bdd1                	j	800362 <vprintfmt+0x68>
  800490:	864a                	mv	a2,s2
  800492:	85a6                	mv	a1,s1
  800494:	02500513          	li	a0,37
  800498:	9982                	jalr	s3
  80049a:	bd51                	j	80032e <vprintfmt+0x34>
  80049c:	00144583          	lbu	a1,1(s0)
  8004a0:	2305                	addiw	t1,t1,1
  8004a2:	846e                	mv	s0,s11
  8004a4:	bd7d                	j	800362 <vprintfmt+0x68>
  8004a6:	4705                	li	a4,1
  8004a8:	008a8613          	addi	a2,s5,8
  8004ac:	00674463          	blt	a4,t1,8004b4 <vprintfmt+0x1ba>
  8004b0:	14030c63          	beqz	t1,800608 <vprintfmt+0x30e>
  8004b4:	000ab683          	ld	a3,0(s5)
  8004b8:	4721                	li	a4,8
  8004ba:	8ab2                	mv	s5,a2
  8004bc:	bf51                	j	800450 <vprintfmt+0x156>
  8004be:	03000513          	li	a0,48
  8004c2:	864a                	mv	a2,s2
  8004c4:	85a6                	mv	a1,s1
  8004c6:	e042                	sd	a6,0(sp)
  8004c8:	9982                	jalr	s3
  8004ca:	864a                	mv	a2,s2
  8004cc:	85a6                	mv	a1,s1
  8004ce:	07800513          	li	a0,120
  8004d2:	9982                	jalr	s3
  8004d4:	0aa1                	addi	s5,s5,8
  8004d6:	6802                	ld	a6,0(sp)
  8004d8:	4741                	li	a4,16
  8004da:	ff8ab683          	ld	a3,-8(s5)
  8004de:	bf8d                	j	800450 <vprintfmt+0x156>
  8004e0:	000ab403          	ld	s0,0(s5)
  8004e4:	008a8793          	addi	a5,s5,8
  8004e8:	e03e                	sd	a5,0(sp)
  8004ea:	14040c63          	beqz	s0,800642 <vprintfmt+0x348>
  8004ee:	11805063          	blez	s8,8005ee <vprintfmt+0x2f4>
  8004f2:	02d00693          	li	a3,45
  8004f6:	0cd81963          	bne	a6,a3,8005c8 <vprintfmt+0x2ce>
  8004fa:	00044683          	lbu	a3,0(s0)
  8004fe:	0006851b          	sext.w	a0,a3
  800502:	ce8d                	beqz	a3,80053c <vprintfmt+0x242>
  800504:	00140a93          	addi	s5,s0,1
  800508:	05e00413          	li	s0,94
  80050c:	000cc563          	bltz	s9,800516 <vprintfmt+0x21c>
  800510:	3cfd                	addiw	s9,s9,-1
  800512:	037c8363          	beq	s9,s7,800538 <vprintfmt+0x23e>
  800516:	864a                	mv	a2,s2
  800518:	85a6                	mv	a1,s1
  80051a:	100d0663          	beqz	s10,800626 <vprintfmt+0x32c>
  80051e:	3681                	addiw	a3,a3,-32
  800520:	10d47363          	bgeu	s0,a3,800626 <vprintfmt+0x32c>
  800524:	03f00513          	li	a0,63
  800528:	9982                	jalr	s3
  80052a:	000ac683          	lbu	a3,0(s5)
  80052e:	3c7d                	addiw	s8,s8,-1
  800530:	0a85                	addi	s5,s5,1
  800532:	0006851b          	sext.w	a0,a3
  800536:	faf9                	bnez	a3,80050c <vprintfmt+0x212>
  800538:	01805a63          	blez	s8,80054c <vprintfmt+0x252>
  80053c:	3c7d                	addiw	s8,s8,-1
  80053e:	864a                	mv	a2,s2
  800540:	85a6                	mv	a1,s1
  800542:	02000513          	li	a0,32
  800546:	9982                	jalr	s3
  800548:	fe0c1ae3          	bnez	s8,80053c <vprintfmt+0x242>
  80054c:	6a82                	ld	s5,0(sp)
  80054e:	b3c5                	j	80032e <vprintfmt+0x34>
  800550:	4705                	li	a4,1
  800552:	008a8d13          	addi	s10,s5,8
  800556:	00674463          	blt	a4,t1,80055e <vprintfmt+0x264>
  80055a:	0a030463          	beqz	t1,800602 <vprintfmt+0x308>
  80055e:	000ab403          	ld	s0,0(s5)
  800562:	0c044463          	bltz	s0,80062a <vprintfmt+0x330>
  800566:	86a2                	mv	a3,s0
  800568:	8aea                	mv	s5,s10
  80056a:	4729                	li	a4,10
  80056c:	b5d5                	j	800450 <vprintfmt+0x156>
  80056e:	000aa783          	lw	a5,0(s5)
  800572:	46e1                	li	a3,24
  800574:	0aa1                	addi	s5,s5,8
  800576:	41f7d71b          	sraiw	a4,a5,0x1f
  80057a:	8fb9                	xor	a5,a5,a4
  80057c:	40e7873b          	subw	a4,a5,a4
  800580:	02e6c663          	blt	a3,a4,8005ac <vprintfmt+0x2b2>
  800584:	00371793          	slli	a5,a4,0x3
  800588:	00000697          	auipc	a3,0x0
  80058c:	66868693          	addi	a3,a3,1640 # 800bf0 <error_string>
  800590:	97b6                	add	a5,a5,a3
  800592:	639c                	ld	a5,0(a5)
  800594:	cf81                	beqz	a5,8005ac <vprintfmt+0x2b2>
  800596:	873e                	mv	a4,a5
  800598:	00000697          	auipc	a3,0x0
  80059c:	32068693          	addi	a3,a3,800 # 8008b8 <main+0x204>
  8005a0:	8626                	mv	a2,s1
  8005a2:	85ca                	mv	a1,s2
  8005a4:	854e                	mv	a0,s3
  8005a6:	0d4000ef          	jal	ra,80067a <printfmt>
  8005aa:	b351                	j	80032e <vprintfmt+0x34>
  8005ac:	00000697          	auipc	a3,0x0
  8005b0:	2fc68693          	addi	a3,a3,764 # 8008a8 <main+0x1f4>
  8005b4:	8626                	mv	a2,s1
  8005b6:	85ca                	mv	a1,s2
  8005b8:	854e                	mv	a0,s3
  8005ba:	0c0000ef          	jal	ra,80067a <printfmt>
  8005be:	bb85                	j	80032e <vprintfmt+0x34>
  8005c0:	00000417          	auipc	s0,0x0
  8005c4:	2e040413          	addi	s0,s0,736 # 8008a0 <main+0x1ec>
  8005c8:	85e6                	mv	a1,s9
  8005ca:	8522                	mv	a0,s0
  8005cc:	e442                	sd	a6,8(sp)
  8005ce:	0ca000ef          	jal	ra,800698 <strnlen>
  8005d2:	40ac0c3b          	subw	s8,s8,a0
  8005d6:	01805c63          	blez	s8,8005ee <vprintfmt+0x2f4>
  8005da:	6822                	ld	a6,8(sp)
  8005dc:	00080a9b          	sext.w	s5,a6
  8005e0:	3c7d                	addiw	s8,s8,-1
  8005e2:	864a                	mv	a2,s2
  8005e4:	85a6                	mv	a1,s1
  8005e6:	8556                	mv	a0,s5
  8005e8:	9982                	jalr	s3
  8005ea:	fe0c1be3          	bnez	s8,8005e0 <vprintfmt+0x2e6>
  8005ee:	00044683          	lbu	a3,0(s0)
  8005f2:	00140a93          	addi	s5,s0,1
  8005f6:	0006851b          	sext.w	a0,a3
  8005fa:	daa9                	beqz	a3,80054c <vprintfmt+0x252>
  8005fc:	05e00413          	li	s0,94
  800600:	b731                	j	80050c <vprintfmt+0x212>
  800602:	000aa403          	lw	s0,0(s5)
  800606:	bfb1                	j	800562 <vprintfmt+0x268>
  800608:	000ae683          	lwu	a3,0(s5)
  80060c:	4721                	li	a4,8
  80060e:	8ab2                	mv	s5,a2
  800610:	b581                	j	800450 <vprintfmt+0x156>
  800612:	000ae683          	lwu	a3,0(s5)
  800616:	4729                	li	a4,10
  800618:	8ab2                	mv	s5,a2
  80061a:	bd1d                	j	800450 <vprintfmt+0x156>
  80061c:	000ae683          	lwu	a3,0(s5)
  800620:	4741                	li	a4,16
  800622:	8ab2                	mv	s5,a2
  800624:	b535                	j	800450 <vprintfmt+0x156>
  800626:	9982                	jalr	s3
  800628:	b709                	j	80052a <vprintfmt+0x230>
  80062a:	864a                	mv	a2,s2
  80062c:	85a6                	mv	a1,s1
  80062e:	02d00513          	li	a0,45
  800632:	e042                	sd	a6,0(sp)
  800634:	9982                	jalr	s3
  800636:	6802                	ld	a6,0(sp)
  800638:	8aea                	mv	s5,s10
  80063a:	408006b3          	neg	a3,s0
  80063e:	4729                	li	a4,10
  800640:	bd01                	j	800450 <vprintfmt+0x156>
  800642:	03805163          	blez	s8,800664 <vprintfmt+0x36a>
  800646:	02d00693          	li	a3,45
  80064a:	f6d81be3          	bne	a6,a3,8005c0 <vprintfmt+0x2c6>
  80064e:	00000417          	auipc	s0,0x0
  800652:	25240413          	addi	s0,s0,594 # 8008a0 <main+0x1ec>
  800656:	02800693          	li	a3,40
  80065a:	02800513          	li	a0,40
  80065e:	00140a93          	addi	s5,s0,1
  800662:	b55d                	j	800508 <vprintfmt+0x20e>
  800664:	00000a97          	auipc	s5,0x0
  800668:	23da8a93          	addi	s5,s5,573 # 8008a1 <main+0x1ed>
  80066c:	02800513          	li	a0,40
  800670:	02800693          	li	a3,40
  800674:	05e00413          	li	s0,94
  800678:	bd51                	j	80050c <vprintfmt+0x212>

000000000080067a <printfmt>:
  80067a:	7139                	addi	sp,sp,-64
  80067c:	02010313          	addi	t1,sp,32
  800680:	f03a                	sd	a4,32(sp)
  800682:	871a                	mv	a4,t1
  800684:	ec06                	sd	ra,24(sp)
  800686:	f43e                	sd	a5,40(sp)
  800688:	f842                	sd	a6,48(sp)
  80068a:	fc46                	sd	a7,56(sp)
  80068c:	e41a                	sd	t1,8(sp)
  80068e:	c6dff0ef          	jal	ra,8002fa <vprintfmt>
  800692:	60e2                	ld	ra,24(sp)
  800694:	6121                	addi	sp,sp,64
  800696:	8082                	ret

0000000000800698 <strnlen>:
  800698:	4781                	li	a5,0
  80069a:	e589                	bnez	a1,8006a4 <strnlen+0xc>
  80069c:	a811                	j	8006b0 <strnlen+0x18>
  80069e:	0785                	addi	a5,a5,1
  8006a0:	00f58863          	beq	a1,a5,8006b0 <strnlen+0x18>
  8006a4:	00f50733          	add	a4,a0,a5
  8006a8:	00074703          	lbu	a4,0(a4)
  8006ac:	fb6d                	bnez	a4,80069e <strnlen+0x6>
  8006ae:	85be                	mv	a1,a5
  8006b0:	852e                	mv	a0,a1
  8006b2:	8082                	ret

00000000008006b4 <main>:
  8006b4:	1101                	addi	sp,sp,-32
  8006b6:	00000517          	auipc	a0,0x0
  8006ba:	60250513          	addi	a0,a0,1538 # 800cb8 <error_string+0xc8>
  8006be:	ec06                	sd	ra,24(sp)
  8006c0:	e822                	sd	s0,16(sp)
  8006c2:	a3dff0ef          	jal	ra,8000fe <cprintf>
  8006c6:	afbff0ef          	jal	ra,8001c0 <fork>
  8006ca:	c561                	beqz	a0,800792 <main+0xde>
  8006cc:	842a                	mv	s0,a0
  8006ce:	85aa                	mv	a1,a0
  8006d0:	00000517          	auipc	a0,0x0
  8006d4:	62850513          	addi	a0,a0,1576 # 800cf8 <error_string+0x108>
  8006d8:	a27ff0ef          	jal	ra,8000fe <cprintf>
  8006dc:	08805c63          	blez	s0,800774 <main+0xc0>
  8006e0:	00000517          	auipc	a0,0x0
  8006e4:	67050513          	addi	a0,a0,1648 # 800d50 <error_string+0x160>
  8006e8:	a17ff0ef          	jal	ra,8000fe <cprintf>
  8006ec:	006c                	addi	a1,sp,12
  8006ee:	8522                	mv	a0,s0
  8006f0:	ad9ff0ef          	jal	ra,8001c8 <waitpid>
  8006f4:	e131                	bnez	a0,800738 <main+0x84>
  8006f6:	4732                	lw	a4,12(sp)
  8006f8:	00001797          	auipc	a5,0x1
  8006fc:	9087a783          	lw	a5,-1784(a5) # 801000 <magic>
  800700:	02f71c63          	bne	a4,a5,800738 <main+0x84>
  800704:	006c                	addi	a1,sp,12
  800706:	8522                	mv	a0,s0
  800708:	ac1ff0ef          	jal	ra,8001c8 <waitpid>
  80070c:	c529                	beqz	a0,800756 <main+0xa2>
  80070e:	ab5ff0ef          	jal	ra,8001c2 <wait>
  800712:	c131                	beqz	a0,800756 <main+0xa2>
  800714:	85a2                	mv	a1,s0
  800716:	00000517          	auipc	a0,0x0
  80071a:	6b250513          	addi	a0,a0,1714 # 800dc8 <error_string+0x1d8>
  80071e:	9e1ff0ef          	jal	ra,8000fe <cprintf>
  800722:	00000517          	auipc	a0,0x0
  800726:	6b650513          	addi	a0,a0,1718 # 800dd8 <error_string+0x1e8>
  80072a:	9d5ff0ef          	jal	ra,8000fe <cprintf>
  80072e:	60e2                	ld	ra,24(sp)
  800730:	6442                	ld	s0,16(sp)
  800732:	4501                	li	a0,0
  800734:	6105                	addi	sp,sp,32
  800736:	8082                	ret
  800738:	00000697          	auipc	a3,0x0
  80073c:	63868693          	addi	a3,a3,1592 # 800d70 <error_string+0x180>
  800740:	00000617          	auipc	a2,0x0
  800744:	5e860613          	addi	a2,a2,1512 # 800d28 <error_string+0x138>
  800748:	45ed                	li	a1,27
  80074a:	00000517          	auipc	a0,0x0
  80074e:	5f650513          	addi	a0,a0,1526 # 800d40 <error_string+0x150>
  800752:	8e7ff0ef          	jal	ra,800038 <__panic>
  800756:	00000697          	auipc	a3,0x0
  80075a:	64a68693          	addi	a3,a3,1610 # 800da0 <error_string+0x1b0>
  80075e:	00000617          	auipc	a2,0x0
  800762:	5ca60613          	addi	a2,a2,1482 # 800d28 <error_string+0x138>
  800766:	45f1                	li	a1,28
  800768:	00000517          	auipc	a0,0x0
  80076c:	5d850513          	addi	a0,a0,1496 # 800d40 <error_string+0x150>
  800770:	8c9ff0ef          	jal	ra,800038 <__panic>
  800774:	00000697          	auipc	a3,0x0
  800778:	5ac68693          	addi	a3,a3,1452 # 800d20 <error_string+0x130>
  80077c:	00000617          	auipc	a2,0x0
  800780:	5ac60613          	addi	a2,a2,1452 # 800d28 <error_string+0x138>
  800784:	45e1                	li	a1,24
  800786:	00000517          	auipc	a0,0x0
  80078a:	5ba50513          	addi	a0,a0,1466 # 800d40 <error_string+0x150>
  80078e:	8abff0ef          	jal	ra,800038 <__panic>
  800792:	00000517          	auipc	a0,0x0
  800796:	54e50513          	addi	a0,a0,1358 # 800ce0 <error_string+0xf0>
  80079a:	965ff0ef          	jal	ra,8000fe <cprintf>
  80079e:	a2dff0ef          	jal	ra,8001ca <yield>
  8007a2:	a29ff0ef          	jal	ra,8001ca <yield>
  8007a6:	a25ff0ef          	jal	ra,8001ca <yield>
  8007aa:	a21ff0ef          	jal	ra,8001ca <yield>
  8007ae:	a1dff0ef          	jal	ra,8001ca <yield>
  8007b2:	a19ff0ef          	jal	ra,8001ca <yield>
  8007b6:	a15ff0ef          	jal	ra,8001ca <yield>
  8007ba:	00001517          	auipc	a0,0x1
  8007be:	84652503          	lw	a0,-1978(a0) # 801000 <magic>
  8007c2:	9e9ff0ef          	jal	ra,8001aa <exit>
