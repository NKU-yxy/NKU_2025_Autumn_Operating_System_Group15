
obj/__user_badarg.out:     file format elf64-littleriscv


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
  800032:	1d8000ef          	jal	ra,80020a <umain>
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
  80004c:	75850513          	addi	a0,a0,1880 # 8007a0 <main+0xf2>
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
  80006c:	7b050513          	addi	a0,a0,1968 # 800818 <main+0x16a>
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
  80008e:	73650513          	addi	a0,a0,1846 # 8007c0 <main+0x112>
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
  8000ae:	76e50513          	addi	a0,a0,1902 # 800818 <main+0x16a>
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
  8000f2:	202000ef          	jal	ra,8002f4 <vprintfmt>
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
  80012e:	1c6000ef          	jal	ra,8002f4 <vprintfmt>
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
  8001b6:	62e50513          	addi	a0,a0,1582 # 8007e0 <main+0x132>
  8001ba:	f45ff0ef          	jal	ra,8000fe <cprintf>
  8001be:	a001                	j	8001be <exit+0x14>

00000000008001c0 <fork>:
  8001c0:	bf65                	j	800178 <sys_fork>

00000000008001c2 <waitpid>:
  8001c2:	bf6d                	j	80017c <sys_wait>

00000000008001c4 <yield>:
  8001c4:	b7c1                	j	800184 <sys_yield>

00000000008001c6 <initfd>:
  8001c6:	1101                	addi	sp,sp,-32
  8001c8:	87ae                	mv	a5,a1
  8001ca:	e426                	sd	s1,8(sp)
  8001cc:	85b2                	mv	a1,a2
  8001ce:	84aa                	mv	s1,a0
  8001d0:	853e                	mv	a0,a5
  8001d2:	e822                	sd	s0,16(sp)
  8001d4:	ec06                	sd	ra,24(sp)
  8001d6:	e4bff0ef          	jal	ra,800020 <open>
  8001da:	842a                	mv	s0,a0
  8001dc:	00054463          	bltz	a0,8001e4 <initfd+0x1e>
  8001e0:	00951863          	bne	a0,s1,8001f0 <initfd+0x2a>
  8001e4:	60e2                	ld	ra,24(sp)
  8001e6:	8522                	mv	a0,s0
  8001e8:	6442                	ld	s0,16(sp)
  8001ea:	64a2                	ld	s1,8(sp)
  8001ec:	6105                	addi	sp,sp,32
  8001ee:	8082                	ret
  8001f0:	8526                	mv	a0,s1
  8001f2:	e35ff0ef          	jal	ra,800026 <close>
  8001f6:	85a6                	mv	a1,s1
  8001f8:	8522                	mv	a0,s0
  8001fa:	e2fff0ef          	jal	ra,800028 <dup2>
  8001fe:	84aa                	mv	s1,a0
  800200:	8522                	mv	a0,s0
  800202:	e25ff0ef          	jal	ra,800026 <close>
  800206:	8426                	mv	s0,s1
  800208:	bff1                	j	8001e4 <initfd+0x1e>

000000000080020a <umain>:
  80020a:	1101                	addi	sp,sp,-32
  80020c:	e822                	sd	s0,16(sp)
  80020e:	e426                	sd	s1,8(sp)
  800210:	842a                	mv	s0,a0
  800212:	84ae                	mv	s1,a1
  800214:	4601                	li	a2,0
  800216:	00000597          	auipc	a1,0x0
  80021a:	5e258593          	addi	a1,a1,1506 # 8007f8 <main+0x14a>
  80021e:	4501                	li	a0,0
  800220:	ec06                	sd	ra,24(sp)
  800222:	fa5ff0ef          	jal	ra,8001c6 <initfd>
  800226:	02054263          	bltz	a0,80024a <umain+0x40>
  80022a:	4605                	li	a2,1
  80022c:	00000597          	auipc	a1,0x0
  800230:	60c58593          	addi	a1,a1,1548 # 800838 <main+0x18a>
  800234:	4505                	li	a0,1
  800236:	f91ff0ef          	jal	ra,8001c6 <initfd>
  80023a:	02054563          	bltz	a0,800264 <umain+0x5a>
  80023e:	85a6                	mv	a1,s1
  800240:	8522                	mv	a0,s0
  800242:	46c000ef          	jal	ra,8006ae <main>
  800246:	f65ff0ef          	jal	ra,8001aa <exit>
  80024a:	86aa                	mv	a3,a0
  80024c:	00000617          	auipc	a2,0x0
  800250:	5b460613          	addi	a2,a2,1460 # 800800 <main+0x152>
  800254:	45e9                	li	a1,26
  800256:	00000517          	auipc	a0,0x0
  80025a:	5ca50513          	addi	a0,a0,1482 # 800820 <main+0x172>
  80025e:	e1dff0ef          	jal	ra,80007a <__warn>
  800262:	b7e1                	j	80022a <umain+0x20>
  800264:	86aa                	mv	a3,a0
  800266:	00000617          	auipc	a2,0x0
  80026a:	5da60613          	addi	a2,a2,1498 # 800840 <main+0x192>
  80026e:	45f5                	li	a1,29
  800270:	00000517          	auipc	a0,0x0
  800274:	5b050513          	addi	a0,a0,1456 # 800820 <main+0x172>
  800278:	e03ff0ef          	jal	ra,80007a <__warn>
  80027c:	b7c9                	j	80023e <umain+0x34>

000000000080027e <printnum>:
  80027e:	02071893          	slli	a7,a4,0x20
  800282:	7139                	addi	sp,sp,-64
  800284:	0208d893          	srli	a7,a7,0x20
  800288:	e456                	sd	s5,8(sp)
  80028a:	0316fab3          	remu	s5,a3,a7
  80028e:	f822                	sd	s0,48(sp)
  800290:	f426                	sd	s1,40(sp)
  800292:	f04a                	sd	s2,32(sp)
  800294:	ec4e                	sd	s3,24(sp)
  800296:	fc06                	sd	ra,56(sp)
  800298:	e852                	sd	s4,16(sp)
  80029a:	84aa                	mv	s1,a0
  80029c:	89ae                	mv	s3,a1
  80029e:	8932                	mv	s2,a2
  8002a0:	fff7841b          	addiw	s0,a5,-1
  8002a4:	2a81                	sext.w	s5,s5
  8002a6:	0516f163          	bgeu	a3,a7,8002e8 <printnum+0x6a>
  8002aa:	8a42                	mv	s4,a6
  8002ac:	00805863          	blez	s0,8002bc <printnum+0x3e>
  8002b0:	347d                	addiw	s0,s0,-1
  8002b2:	864e                	mv	a2,s3
  8002b4:	85ca                	mv	a1,s2
  8002b6:	8552                	mv	a0,s4
  8002b8:	9482                	jalr	s1
  8002ba:	f87d                	bnez	s0,8002b0 <printnum+0x32>
  8002bc:	1a82                	slli	s5,s5,0x20
  8002be:	00000797          	auipc	a5,0x0
  8002c2:	5a278793          	addi	a5,a5,1442 # 800860 <main+0x1b2>
  8002c6:	020ada93          	srli	s5,s5,0x20
  8002ca:	9abe                	add	s5,s5,a5
  8002cc:	7442                	ld	s0,48(sp)
  8002ce:	000ac503          	lbu	a0,0(s5)
  8002d2:	70e2                	ld	ra,56(sp)
  8002d4:	6a42                	ld	s4,16(sp)
  8002d6:	6aa2                	ld	s5,8(sp)
  8002d8:	864e                	mv	a2,s3
  8002da:	85ca                	mv	a1,s2
  8002dc:	69e2                	ld	s3,24(sp)
  8002de:	7902                	ld	s2,32(sp)
  8002e0:	87a6                	mv	a5,s1
  8002e2:	74a2                	ld	s1,40(sp)
  8002e4:	6121                	addi	sp,sp,64
  8002e6:	8782                	jr	a5
  8002e8:	0316d6b3          	divu	a3,a3,a7
  8002ec:	87a2                	mv	a5,s0
  8002ee:	f91ff0ef          	jal	ra,80027e <printnum>
  8002f2:	b7e9                	j	8002bc <printnum+0x3e>

00000000008002f4 <vprintfmt>:
  8002f4:	7119                	addi	sp,sp,-128
  8002f6:	f4a6                	sd	s1,104(sp)
  8002f8:	f0ca                	sd	s2,96(sp)
  8002fa:	ecce                	sd	s3,88(sp)
  8002fc:	e8d2                	sd	s4,80(sp)
  8002fe:	e4d6                	sd	s5,72(sp)
  800300:	e0da                	sd	s6,64(sp)
  800302:	fc5e                	sd	s7,56(sp)
  800304:	ec6e                	sd	s11,24(sp)
  800306:	fc86                	sd	ra,120(sp)
  800308:	f8a2                	sd	s0,112(sp)
  80030a:	f862                	sd	s8,48(sp)
  80030c:	f466                	sd	s9,40(sp)
  80030e:	f06a                	sd	s10,32(sp)
  800310:	89aa                	mv	s3,a0
  800312:	892e                	mv	s2,a1
  800314:	84b2                	mv	s1,a2
  800316:	8db6                	mv	s11,a3
  800318:	8aba                	mv	s5,a4
  80031a:	02500a13          	li	s4,37
  80031e:	5bfd                	li	s7,-1
  800320:	00000b17          	auipc	s6,0x0
  800324:	574b0b13          	addi	s6,s6,1396 # 800894 <main+0x1e6>
  800328:	000dc503          	lbu	a0,0(s11)
  80032c:	001d8413          	addi	s0,s11,1
  800330:	01450b63          	beq	a0,s4,800346 <vprintfmt+0x52>
  800334:	c129                	beqz	a0,800376 <vprintfmt+0x82>
  800336:	864a                	mv	a2,s2
  800338:	85a6                	mv	a1,s1
  80033a:	0405                	addi	s0,s0,1
  80033c:	9982                	jalr	s3
  80033e:	fff44503          	lbu	a0,-1(s0)
  800342:	ff4519e3          	bne	a0,s4,800334 <vprintfmt+0x40>
  800346:	00044583          	lbu	a1,0(s0)
  80034a:	02000813          	li	a6,32
  80034e:	4d01                	li	s10,0
  800350:	4301                	li	t1,0
  800352:	5cfd                	li	s9,-1
  800354:	5c7d                	li	s8,-1
  800356:	05500513          	li	a0,85
  80035a:	48a5                	li	a7,9
  80035c:	fdd5861b          	addiw	a2,a1,-35
  800360:	0ff67613          	zext.b	a2,a2
  800364:	00140d93          	addi	s11,s0,1
  800368:	04c56263          	bltu	a0,a2,8003ac <vprintfmt+0xb8>
  80036c:	060a                	slli	a2,a2,0x2
  80036e:	965a                	add	a2,a2,s6
  800370:	4214                	lw	a3,0(a2)
  800372:	96da                	add	a3,a3,s6
  800374:	8682                	jr	a3
  800376:	70e6                	ld	ra,120(sp)
  800378:	7446                	ld	s0,112(sp)
  80037a:	74a6                	ld	s1,104(sp)
  80037c:	7906                	ld	s2,96(sp)
  80037e:	69e6                	ld	s3,88(sp)
  800380:	6a46                	ld	s4,80(sp)
  800382:	6aa6                	ld	s5,72(sp)
  800384:	6b06                	ld	s6,64(sp)
  800386:	7be2                	ld	s7,56(sp)
  800388:	7c42                	ld	s8,48(sp)
  80038a:	7ca2                	ld	s9,40(sp)
  80038c:	7d02                	ld	s10,32(sp)
  80038e:	6de2                	ld	s11,24(sp)
  800390:	6109                	addi	sp,sp,128
  800392:	8082                	ret
  800394:	882e                	mv	a6,a1
  800396:	00144583          	lbu	a1,1(s0)
  80039a:	846e                	mv	s0,s11
  80039c:	00140d93          	addi	s11,s0,1
  8003a0:	fdd5861b          	addiw	a2,a1,-35
  8003a4:	0ff67613          	zext.b	a2,a2
  8003a8:	fcc572e3          	bgeu	a0,a2,80036c <vprintfmt+0x78>
  8003ac:	864a                	mv	a2,s2
  8003ae:	85a6                	mv	a1,s1
  8003b0:	02500513          	li	a0,37
  8003b4:	9982                	jalr	s3
  8003b6:	fff44783          	lbu	a5,-1(s0)
  8003ba:	8da2                	mv	s11,s0
  8003bc:	f74786e3          	beq	a5,s4,800328 <vprintfmt+0x34>
  8003c0:	ffedc783          	lbu	a5,-2(s11)
  8003c4:	1dfd                	addi	s11,s11,-1
  8003c6:	ff479de3          	bne	a5,s4,8003c0 <vprintfmt+0xcc>
  8003ca:	bfb9                	j	800328 <vprintfmt+0x34>
  8003cc:	fd058c9b          	addiw	s9,a1,-48
  8003d0:	00144583          	lbu	a1,1(s0)
  8003d4:	846e                	mv	s0,s11
  8003d6:	fd05869b          	addiw	a3,a1,-48
  8003da:	0005861b          	sext.w	a2,a1
  8003de:	02d8e463          	bltu	a7,a3,800406 <vprintfmt+0x112>
  8003e2:	00144583          	lbu	a1,1(s0)
  8003e6:	002c969b          	slliw	a3,s9,0x2
  8003ea:	0196873b          	addw	a4,a3,s9
  8003ee:	0017171b          	slliw	a4,a4,0x1
  8003f2:	9f31                	addw	a4,a4,a2
  8003f4:	fd05869b          	addiw	a3,a1,-48
  8003f8:	0405                	addi	s0,s0,1
  8003fa:	fd070c9b          	addiw	s9,a4,-48
  8003fe:	0005861b          	sext.w	a2,a1
  800402:	fed8f0e3          	bgeu	a7,a3,8003e2 <vprintfmt+0xee>
  800406:	f40c5be3          	bgez	s8,80035c <vprintfmt+0x68>
  80040a:	8c66                	mv	s8,s9
  80040c:	5cfd                	li	s9,-1
  80040e:	b7b9                	j	80035c <vprintfmt+0x68>
  800410:	fffc4693          	not	a3,s8
  800414:	96fd                	srai	a3,a3,0x3f
  800416:	00dc77b3          	and	a5,s8,a3
  80041a:	00144583          	lbu	a1,1(s0)
  80041e:	00078c1b          	sext.w	s8,a5
  800422:	846e                	mv	s0,s11
  800424:	bf25                	j	80035c <vprintfmt+0x68>
  800426:	000aac83          	lw	s9,0(s5)
  80042a:	00144583          	lbu	a1,1(s0)
  80042e:	0aa1                	addi	s5,s5,8
  800430:	846e                	mv	s0,s11
  800432:	bfd1                	j	800406 <vprintfmt+0x112>
  800434:	4705                	li	a4,1
  800436:	008a8613          	addi	a2,s5,8
  80043a:	00674463          	blt	a4,t1,800442 <vprintfmt+0x14e>
  80043e:	1c030c63          	beqz	t1,800616 <vprintfmt+0x322>
  800442:	000ab683          	ld	a3,0(s5)
  800446:	4741                	li	a4,16
  800448:	8ab2                	mv	s5,a2
  80044a:	2801                	sext.w	a6,a6
  80044c:	87e2                	mv	a5,s8
  80044e:	8626                	mv	a2,s1
  800450:	85ca                	mv	a1,s2
  800452:	854e                	mv	a0,s3
  800454:	e2bff0ef          	jal	ra,80027e <printnum>
  800458:	bdc1                	j	800328 <vprintfmt+0x34>
  80045a:	000aa503          	lw	a0,0(s5)
  80045e:	864a                	mv	a2,s2
  800460:	85a6                	mv	a1,s1
  800462:	0aa1                	addi	s5,s5,8
  800464:	9982                	jalr	s3
  800466:	b5c9                	j	800328 <vprintfmt+0x34>
  800468:	4705                	li	a4,1
  80046a:	008a8613          	addi	a2,s5,8
  80046e:	00674463          	blt	a4,t1,800476 <vprintfmt+0x182>
  800472:	18030d63          	beqz	t1,80060c <vprintfmt+0x318>
  800476:	000ab683          	ld	a3,0(s5)
  80047a:	4729                	li	a4,10
  80047c:	8ab2                	mv	s5,a2
  80047e:	b7f1                	j	80044a <vprintfmt+0x156>
  800480:	00144583          	lbu	a1,1(s0)
  800484:	4d05                	li	s10,1
  800486:	846e                	mv	s0,s11
  800488:	bdd1                	j	80035c <vprintfmt+0x68>
  80048a:	864a                	mv	a2,s2
  80048c:	85a6                	mv	a1,s1
  80048e:	02500513          	li	a0,37
  800492:	9982                	jalr	s3
  800494:	bd51                	j	800328 <vprintfmt+0x34>
  800496:	00144583          	lbu	a1,1(s0)
  80049a:	2305                	addiw	t1,t1,1
  80049c:	846e                	mv	s0,s11
  80049e:	bd7d                	j	80035c <vprintfmt+0x68>
  8004a0:	4705                	li	a4,1
  8004a2:	008a8613          	addi	a2,s5,8
  8004a6:	00674463          	blt	a4,t1,8004ae <vprintfmt+0x1ba>
  8004aa:	14030c63          	beqz	t1,800602 <vprintfmt+0x30e>
  8004ae:	000ab683          	ld	a3,0(s5)
  8004b2:	4721                	li	a4,8
  8004b4:	8ab2                	mv	s5,a2
  8004b6:	bf51                	j	80044a <vprintfmt+0x156>
  8004b8:	03000513          	li	a0,48
  8004bc:	864a                	mv	a2,s2
  8004be:	85a6                	mv	a1,s1
  8004c0:	e042                	sd	a6,0(sp)
  8004c2:	9982                	jalr	s3
  8004c4:	864a                	mv	a2,s2
  8004c6:	85a6                	mv	a1,s1
  8004c8:	07800513          	li	a0,120
  8004cc:	9982                	jalr	s3
  8004ce:	0aa1                	addi	s5,s5,8
  8004d0:	6802                	ld	a6,0(sp)
  8004d2:	4741                	li	a4,16
  8004d4:	ff8ab683          	ld	a3,-8(s5)
  8004d8:	bf8d                	j	80044a <vprintfmt+0x156>
  8004da:	000ab403          	ld	s0,0(s5)
  8004de:	008a8793          	addi	a5,s5,8
  8004e2:	e03e                	sd	a5,0(sp)
  8004e4:	14040c63          	beqz	s0,80063c <vprintfmt+0x348>
  8004e8:	11805063          	blez	s8,8005e8 <vprintfmt+0x2f4>
  8004ec:	02d00693          	li	a3,45
  8004f0:	0cd81963          	bne	a6,a3,8005c2 <vprintfmt+0x2ce>
  8004f4:	00044683          	lbu	a3,0(s0)
  8004f8:	0006851b          	sext.w	a0,a3
  8004fc:	ce8d                	beqz	a3,800536 <vprintfmt+0x242>
  8004fe:	00140a93          	addi	s5,s0,1
  800502:	05e00413          	li	s0,94
  800506:	000cc563          	bltz	s9,800510 <vprintfmt+0x21c>
  80050a:	3cfd                	addiw	s9,s9,-1
  80050c:	037c8363          	beq	s9,s7,800532 <vprintfmt+0x23e>
  800510:	864a                	mv	a2,s2
  800512:	85a6                	mv	a1,s1
  800514:	100d0663          	beqz	s10,800620 <vprintfmt+0x32c>
  800518:	3681                	addiw	a3,a3,-32
  80051a:	10d47363          	bgeu	s0,a3,800620 <vprintfmt+0x32c>
  80051e:	03f00513          	li	a0,63
  800522:	9982                	jalr	s3
  800524:	000ac683          	lbu	a3,0(s5)
  800528:	3c7d                	addiw	s8,s8,-1
  80052a:	0a85                	addi	s5,s5,1
  80052c:	0006851b          	sext.w	a0,a3
  800530:	faf9                	bnez	a3,800506 <vprintfmt+0x212>
  800532:	01805a63          	blez	s8,800546 <vprintfmt+0x252>
  800536:	3c7d                	addiw	s8,s8,-1
  800538:	864a                	mv	a2,s2
  80053a:	85a6                	mv	a1,s1
  80053c:	02000513          	li	a0,32
  800540:	9982                	jalr	s3
  800542:	fe0c1ae3          	bnez	s8,800536 <vprintfmt+0x242>
  800546:	6a82                	ld	s5,0(sp)
  800548:	b3c5                	j	800328 <vprintfmt+0x34>
  80054a:	4705                	li	a4,1
  80054c:	008a8d13          	addi	s10,s5,8
  800550:	00674463          	blt	a4,t1,800558 <vprintfmt+0x264>
  800554:	0a030463          	beqz	t1,8005fc <vprintfmt+0x308>
  800558:	000ab403          	ld	s0,0(s5)
  80055c:	0c044463          	bltz	s0,800624 <vprintfmt+0x330>
  800560:	86a2                	mv	a3,s0
  800562:	8aea                	mv	s5,s10
  800564:	4729                	li	a4,10
  800566:	b5d5                	j	80044a <vprintfmt+0x156>
  800568:	000aa783          	lw	a5,0(s5)
  80056c:	46e1                	li	a3,24
  80056e:	0aa1                	addi	s5,s5,8
  800570:	41f7d71b          	sraiw	a4,a5,0x1f
  800574:	8fb9                	xor	a5,a5,a4
  800576:	40e7873b          	subw	a4,a5,a4
  80057a:	02e6c663          	blt	a3,a4,8005a6 <vprintfmt+0x2b2>
  80057e:	00371793          	slli	a5,a4,0x3
  800582:	00000697          	auipc	a3,0x0
  800586:	64668693          	addi	a3,a3,1606 # 800bc8 <error_string>
  80058a:	97b6                	add	a5,a5,a3
  80058c:	639c                	ld	a5,0(a5)
  80058e:	cf81                	beqz	a5,8005a6 <vprintfmt+0x2b2>
  800590:	873e                	mv	a4,a5
  800592:	00000697          	auipc	a3,0x0
  800596:	2fe68693          	addi	a3,a3,766 # 800890 <main+0x1e2>
  80059a:	8626                	mv	a2,s1
  80059c:	85ca                	mv	a1,s2
  80059e:	854e                	mv	a0,s3
  8005a0:	0d4000ef          	jal	ra,800674 <printfmt>
  8005a4:	b351                	j	800328 <vprintfmt+0x34>
  8005a6:	00000697          	auipc	a3,0x0
  8005aa:	2da68693          	addi	a3,a3,730 # 800880 <main+0x1d2>
  8005ae:	8626                	mv	a2,s1
  8005b0:	85ca                	mv	a1,s2
  8005b2:	854e                	mv	a0,s3
  8005b4:	0c0000ef          	jal	ra,800674 <printfmt>
  8005b8:	bb85                	j	800328 <vprintfmt+0x34>
  8005ba:	00000417          	auipc	s0,0x0
  8005be:	2be40413          	addi	s0,s0,702 # 800878 <main+0x1ca>
  8005c2:	85e6                	mv	a1,s9
  8005c4:	8522                	mv	a0,s0
  8005c6:	e442                	sd	a6,8(sp)
  8005c8:	0ca000ef          	jal	ra,800692 <strnlen>
  8005cc:	40ac0c3b          	subw	s8,s8,a0
  8005d0:	01805c63          	blez	s8,8005e8 <vprintfmt+0x2f4>
  8005d4:	6822                	ld	a6,8(sp)
  8005d6:	00080a9b          	sext.w	s5,a6
  8005da:	3c7d                	addiw	s8,s8,-1
  8005dc:	864a                	mv	a2,s2
  8005de:	85a6                	mv	a1,s1
  8005e0:	8556                	mv	a0,s5
  8005e2:	9982                	jalr	s3
  8005e4:	fe0c1be3          	bnez	s8,8005da <vprintfmt+0x2e6>
  8005e8:	00044683          	lbu	a3,0(s0)
  8005ec:	00140a93          	addi	s5,s0,1
  8005f0:	0006851b          	sext.w	a0,a3
  8005f4:	daa9                	beqz	a3,800546 <vprintfmt+0x252>
  8005f6:	05e00413          	li	s0,94
  8005fa:	b731                	j	800506 <vprintfmt+0x212>
  8005fc:	000aa403          	lw	s0,0(s5)
  800600:	bfb1                	j	80055c <vprintfmt+0x268>
  800602:	000ae683          	lwu	a3,0(s5)
  800606:	4721                	li	a4,8
  800608:	8ab2                	mv	s5,a2
  80060a:	b581                	j	80044a <vprintfmt+0x156>
  80060c:	000ae683          	lwu	a3,0(s5)
  800610:	4729                	li	a4,10
  800612:	8ab2                	mv	s5,a2
  800614:	bd1d                	j	80044a <vprintfmt+0x156>
  800616:	000ae683          	lwu	a3,0(s5)
  80061a:	4741                	li	a4,16
  80061c:	8ab2                	mv	s5,a2
  80061e:	b535                	j	80044a <vprintfmt+0x156>
  800620:	9982                	jalr	s3
  800622:	b709                	j	800524 <vprintfmt+0x230>
  800624:	864a                	mv	a2,s2
  800626:	85a6                	mv	a1,s1
  800628:	02d00513          	li	a0,45
  80062c:	e042                	sd	a6,0(sp)
  80062e:	9982                	jalr	s3
  800630:	6802                	ld	a6,0(sp)
  800632:	8aea                	mv	s5,s10
  800634:	408006b3          	neg	a3,s0
  800638:	4729                	li	a4,10
  80063a:	bd01                	j	80044a <vprintfmt+0x156>
  80063c:	03805163          	blez	s8,80065e <vprintfmt+0x36a>
  800640:	02d00693          	li	a3,45
  800644:	f6d81be3          	bne	a6,a3,8005ba <vprintfmt+0x2c6>
  800648:	00000417          	auipc	s0,0x0
  80064c:	23040413          	addi	s0,s0,560 # 800878 <main+0x1ca>
  800650:	02800693          	li	a3,40
  800654:	02800513          	li	a0,40
  800658:	00140a93          	addi	s5,s0,1
  80065c:	b55d                	j	800502 <vprintfmt+0x20e>
  80065e:	00000a97          	auipc	s5,0x0
  800662:	21ba8a93          	addi	s5,s5,539 # 800879 <main+0x1cb>
  800666:	02800513          	li	a0,40
  80066a:	02800693          	li	a3,40
  80066e:	05e00413          	li	s0,94
  800672:	bd51                	j	800506 <vprintfmt+0x212>

0000000000800674 <printfmt>:
  800674:	7139                	addi	sp,sp,-64
  800676:	02010313          	addi	t1,sp,32
  80067a:	f03a                	sd	a4,32(sp)
  80067c:	871a                	mv	a4,t1
  80067e:	ec06                	sd	ra,24(sp)
  800680:	f43e                	sd	a5,40(sp)
  800682:	f842                	sd	a6,48(sp)
  800684:	fc46                	sd	a7,56(sp)
  800686:	e41a                	sd	t1,8(sp)
  800688:	c6dff0ef          	jal	ra,8002f4 <vprintfmt>
  80068c:	60e2                	ld	ra,24(sp)
  80068e:	6121                	addi	sp,sp,64
  800690:	8082                	ret

0000000000800692 <strnlen>:
  800692:	4781                	li	a5,0
  800694:	e589                	bnez	a1,80069e <strnlen+0xc>
  800696:	a811                	j	8006aa <strnlen+0x18>
  800698:	0785                	addi	a5,a5,1
  80069a:	00f58863          	beq	a1,a5,8006aa <strnlen+0x18>
  80069e:	00f50733          	add	a4,a0,a5
  8006a2:	00074703          	lbu	a4,0(a4)
  8006a6:	fb6d                	bnez	a4,800698 <strnlen+0x6>
  8006a8:	85be                	mv	a1,a5
  8006aa:	852e                	mv	a0,a1
  8006ac:	8082                	ret

00000000008006ae <main>:
  8006ae:	1101                	addi	sp,sp,-32
  8006b0:	ec06                	sd	ra,24(sp)
  8006b2:	e822                	sd	s0,16(sp)
  8006b4:	b0dff0ef          	jal	ra,8001c0 <fork>
  8006b8:	c169                	beqz	a0,80077a <main+0xcc>
  8006ba:	842a                	mv	s0,a0
  8006bc:	0aa05063          	blez	a0,80075c <main+0xae>
  8006c0:	4581                	li	a1,0
  8006c2:	557d                	li	a0,-1
  8006c4:	affff0ef          	jal	ra,8001c2 <waitpid>
  8006c8:	c93d                	beqz	a0,80073e <main+0x90>
  8006ca:	458d                	li	a1,3
  8006cc:	05fa                	slli	a1,a1,0x1e
  8006ce:	8522                	mv	a0,s0
  8006d0:	af3ff0ef          	jal	ra,8001c2 <waitpid>
  8006d4:	c531                	beqz	a0,800720 <main+0x72>
  8006d6:	006c                	addi	a1,sp,12
  8006d8:	8522                	mv	a0,s0
  8006da:	ae9ff0ef          	jal	ra,8001c2 <waitpid>
  8006de:	e115                	bnez	a0,800702 <main+0x54>
  8006e0:	4732                	lw	a4,12(sp)
  8006e2:	67b1                	lui	a5,0xc
  8006e4:	eaf78793          	addi	a5,a5,-337 # beaf <open-0x7f4171>
  8006e8:	00f71d63          	bne	a4,a5,800702 <main+0x54>
  8006ec:	00000517          	auipc	a0,0x0
  8006f0:	65c50513          	addi	a0,a0,1628 # 800d48 <error_string+0x180>
  8006f4:	a0bff0ef          	jal	ra,8000fe <cprintf>
  8006f8:	60e2                	ld	ra,24(sp)
  8006fa:	6442                	ld	s0,16(sp)
  8006fc:	4501                	li	a0,0
  8006fe:	6105                	addi	sp,sp,32
  800700:	8082                	ret
  800702:	00000697          	auipc	a3,0x0
  800706:	60e68693          	addi	a3,a3,1550 # 800d10 <error_string+0x148>
  80070a:	00000617          	auipc	a2,0x0
  80070e:	59e60613          	addi	a2,a2,1438 # 800ca8 <error_string+0xe0>
  800712:	45c9                	li	a1,18
  800714:	00000517          	auipc	a0,0x0
  800718:	5ac50513          	addi	a0,a0,1452 # 800cc0 <error_string+0xf8>
  80071c:	91dff0ef          	jal	ra,800038 <__panic>
  800720:	00000697          	auipc	a3,0x0
  800724:	5c868693          	addi	a3,a3,1480 # 800ce8 <error_string+0x120>
  800728:	00000617          	auipc	a2,0x0
  80072c:	58060613          	addi	a2,a2,1408 # 800ca8 <error_string+0xe0>
  800730:	45c5                	li	a1,17
  800732:	00000517          	auipc	a0,0x0
  800736:	58e50513          	addi	a0,a0,1422 # 800cc0 <error_string+0xf8>
  80073a:	8ffff0ef          	jal	ra,800038 <__panic>
  80073e:	00000697          	auipc	a3,0x0
  800742:	59268693          	addi	a3,a3,1426 # 800cd0 <error_string+0x108>
  800746:	00000617          	auipc	a2,0x0
  80074a:	56260613          	addi	a2,a2,1378 # 800ca8 <error_string+0xe0>
  80074e:	45c1                	li	a1,16
  800750:	00000517          	auipc	a0,0x0
  800754:	57050513          	addi	a0,a0,1392 # 800cc0 <error_string+0xf8>
  800758:	8e1ff0ef          	jal	ra,800038 <__panic>
  80075c:	00000697          	auipc	a3,0x0
  800760:	54468693          	addi	a3,a3,1348 # 800ca0 <error_string+0xd8>
  800764:	00000617          	auipc	a2,0x0
  800768:	54460613          	addi	a2,a2,1348 # 800ca8 <error_string+0xe0>
  80076c:	45bd                	li	a1,15
  80076e:	00000517          	auipc	a0,0x0
  800772:	55250513          	addi	a0,a0,1362 # 800cc0 <error_string+0xf8>
  800776:	8c3ff0ef          	jal	ra,800038 <__panic>
  80077a:	00000517          	auipc	a0,0x0
  80077e:	51650513          	addi	a0,a0,1302 # 800c90 <error_string+0xc8>
  800782:	97dff0ef          	jal	ra,8000fe <cprintf>
  800786:	4429                	li	s0,10
  800788:	347d                	addiw	s0,s0,-1
  80078a:	a3bff0ef          	jal	ra,8001c4 <yield>
  80078e:	fc6d                	bnez	s0,800788 <main+0xda>
  800790:	6531                	lui	a0,0xc
  800792:	eaf50513          	addi	a0,a0,-337 # beaf <open-0x7f4171>
  800796:	a15ff0ef          	jal	ra,8001aa <exit>
