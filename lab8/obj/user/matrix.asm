
obj/__user_matrix.out:     file format elf64-littleriscv


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
  800032:	1ea000ef          	jal	ra,80021c <umain>
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
  800048:	00001517          	auipc	a0,0x1
  80004c:	89050513          	addi	a0,a0,-1904 # 8008d8 <main+0xc6>
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
  80006c:	8e850513          	addi	a0,a0,-1816 # 800950 <main+0x13e>
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
  80008a:	00001517          	auipc	a0,0x1
  80008e:	86e50513          	addi	a0,a0,-1938 # 8008f8 <main+0xe6>
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
  8000ae:	8a650513          	addi	a0,a0,-1882 # 800950 <main+0x13e>
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
  8000f2:	214000ef          	jal	ra,800306 <vprintfmt>
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
  80012e:	1d8000ef          	jal	ra,800306 <vprintfmt>
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
  8001c0:	75c50513          	addi	a0,a0,1884 # 800918 <main+0x106>
  8001c4:	f3bff0ef          	jal	ra,8000fe <cprintf>
  8001c8:	a001                	j	8001c8 <exit+0x14>

00000000008001ca <fork>:
  8001ca:	b77d                	j	800178 <sys_fork>

00000000008001cc <wait>:
  8001cc:	4581                	li	a1,0
  8001ce:	4501                	li	a0,0
  8001d0:	b775                	j	80017c <sys_wait>

00000000008001d2 <yield>:
  8001d2:	bf4d                	j	800184 <sys_yield>

00000000008001d4 <kill>:
  8001d4:	bf55                	j	800188 <sys_kill>

00000000008001d6 <getpid>:
  8001d6:	bf65                	j	80018e <sys_getpid>

00000000008001d8 <initfd>:
  8001d8:	1101                	addi	sp,sp,-32
  8001da:	87ae                	mv	a5,a1
  8001dc:	e426                	sd	s1,8(sp)
  8001de:	85b2                	mv	a1,a2
  8001e0:	84aa                	mv	s1,a0
  8001e2:	853e                	mv	a0,a5
  8001e4:	e822                	sd	s0,16(sp)
  8001e6:	ec06                	sd	ra,24(sp)
  8001e8:	e39ff0ef          	jal	ra,800020 <open>
  8001ec:	842a                	mv	s0,a0
  8001ee:	00054463          	bltz	a0,8001f6 <initfd+0x1e>
  8001f2:	00951863          	bne	a0,s1,800202 <initfd+0x2a>
  8001f6:	60e2                	ld	ra,24(sp)
  8001f8:	8522                	mv	a0,s0
  8001fa:	6442                	ld	s0,16(sp)
  8001fc:	64a2                	ld	s1,8(sp)
  8001fe:	6105                	addi	sp,sp,32
  800200:	8082                	ret
  800202:	8526                	mv	a0,s1
  800204:	e23ff0ef          	jal	ra,800026 <close>
  800208:	85a6                	mv	a1,s1
  80020a:	8522                	mv	a0,s0
  80020c:	e1dff0ef          	jal	ra,800028 <dup2>
  800210:	84aa                	mv	s1,a0
  800212:	8522                	mv	a0,s0
  800214:	e13ff0ef          	jal	ra,800026 <close>
  800218:	8426                	mv	s0,s1
  80021a:	bff1                	j	8001f6 <initfd+0x1e>

000000000080021c <umain>:
  80021c:	1101                	addi	sp,sp,-32
  80021e:	e822                	sd	s0,16(sp)
  800220:	e426                	sd	s1,8(sp)
  800222:	842a                	mv	s0,a0
  800224:	84ae                	mv	s1,a1
  800226:	4601                	li	a2,0
  800228:	00000597          	auipc	a1,0x0
  80022c:	70858593          	addi	a1,a1,1800 # 800930 <main+0x11e>
  800230:	4501                	li	a0,0
  800232:	ec06                	sd	ra,24(sp)
  800234:	fa5ff0ef          	jal	ra,8001d8 <initfd>
  800238:	02054263          	bltz	a0,80025c <umain+0x40>
  80023c:	4605                	li	a2,1
  80023e:	00000597          	auipc	a1,0x0
  800242:	73258593          	addi	a1,a1,1842 # 800970 <main+0x15e>
  800246:	4505                	li	a0,1
  800248:	f91ff0ef          	jal	ra,8001d8 <initfd>
  80024c:	02054563          	bltz	a0,800276 <umain+0x5a>
  800250:	85a6                	mv	a1,s1
  800252:	8522                	mv	a0,s0
  800254:	5be000ef          	jal	ra,800812 <main>
  800258:	f5dff0ef          	jal	ra,8001b4 <exit>
  80025c:	86aa                	mv	a3,a0
  80025e:	00000617          	auipc	a2,0x0
  800262:	6da60613          	addi	a2,a2,1754 # 800938 <main+0x126>
  800266:	45e9                	li	a1,26
  800268:	00000517          	auipc	a0,0x0
  80026c:	6f050513          	addi	a0,a0,1776 # 800958 <main+0x146>
  800270:	e0bff0ef          	jal	ra,80007a <__warn>
  800274:	b7e1                	j	80023c <umain+0x20>
  800276:	86aa                	mv	a3,a0
  800278:	00000617          	auipc	a2,0x0
  80027c:	70060613          	addi	a2,a2,1792 # 800978 <main+0x166>
  800280:	45f5                	li	a1,29
  800282:	00000517          	auipc	a0,0x0
  800286:	6d650513          	addi	a0,a0,1750 # 800958 <main+0x146>
  80028a:	df1ff0ef          	jal	ra,80007a <__warn>
  80028e:	b7c9                	j	800250 <umain+0x34>

0000000000800290 <printnum>:
  800290:	02071893          	slli	a7,a4,0x20
  800294:	7139                	addi	sp,sp,-64
  800296:	0208d893          	srli	a7,a7,0x20
  80029a:	e456                	sd	s5,8(sp)
  80029c:	0316fab3          	remu	s5,a3,a7
  8002a0:	f822                	sd	s0,48(sp)
  8002a2:	f426                	sd	s1,40(sp)
  8002a4:	f04a                	sd	s2,32(sp)
  8002a6:	ec4e                	sd	s3,24(sp)
  8002a8:	fc06                	sd	ra,56(sp)
  8002aa:	e852                	sd	s4,16(sp)
  8002ac:	84aa                	mv	s1,a0
  8002ae:	89ae                	mv	s3,a1
  8002b0:	8932                	mv	s2,a2
  8002b2:	fff7841b          	addiw	s0,a5,-1
  8002b6:	2a81                	sext.w	s5,s5
  8002b8:	0516f163          	bgeu	a3,a7,8002fa <printnum+0x6a>
  8002bc:	8a42                	mv	s4,a6
  8002be:	00805863          	blez	s0,8002ce <printnum+0x3e>
  8002c2:	347d                	addiw	s0,s0,-1
  8002c4:	864e                	mv	a2,s3
  8002c6:	85ca                	mv	a1,s2
  8002c8:	8552                	mv	a0,s4
  8002ca:	9482                	jalr	s1
  8002cc:	f87d                	bnez	s0,8002c2 <printnum+0x32>
  8002ce:	1a82                	slli	s5,s5,0x20
  8002d0:	00000797          	auipc	a5,0x0
  8002d4:	6c878793          	addi	a5,a5,1736 # 800998 <main+0x186>
  8002d8:	020ada93          	srli	s5,s5,0x20
  8002dc:	9abe                	add	s5,s5,a5
  8002de:	7442                	ld	s0,48(sp)
  8002e0:	000ac503          	lbu	a0,0(s5)
  8002e4:	70e2                	ld	ra,56(sp)
  8002e6:	6a42                	ld	s4,16(sp)
  8002e8:	6aa2                	ld	s5,8(sp)
  8002ea:	864e                	mv	a2,s3
  8002ec:	85ca                	mv	a1,s2
  8002ee:	69e2                	ld	s3,24(sp)
  8002f0:	7902                	ld	s2,32(sp)
  8002f2:	87a6                	mv	a5,s1
  8002f4:	74a2                	ld	s1,40(sp)
  8002f6:	6121                	addi	sp,sp,64
  8002f8:	8782                	jr	a5
  8002fa:	0316d6b3          	divu	a3,a3,a7
  8002fe:	87a2                	mv	a5,s0
  800300:	f91ff0ef          	jal	ra,800290 <printnum>
  800304:	b7e9                	j	8002ce <printnum+0x3e>

0000000000800306 <vprintfmt>:
  800306:	7119                	addi	sp,sp,-128
  800308:	f4a6                	sd	s1,104(sp)
  80030a:	f0ca                	sd	s2,96(sp)
  80030c:	ecce                	sd	s3,88(sp)
  80030e:	e8d2                	sd	s4,80(sp)
  800310:	e4d6                	sd	s5,72(sp)
  800312:	e0da                	sd	s6,64(sp)
  800314:	fc5e                	sd	s7,56(sp)
  800316:	ec6e                	sd	s11,24(sp)
  800318:	fc86                	sd	ra,120(sp)
  80031a:	f8a2                	sd	s0,112(sp)
  80031c:	f862                	sd	s8,48(sp)
  80031e:	f466                	sd	s9,40(sp)
  800320:	f06a                	sd	s10,32(sp)
  800322:	89aa                	mv	s3,a0
  800324:	892e                	mv	s2,a1
  800326:	84b2                	mv	s1,a2
  800328:	8db6                	mv	s11,a3
  80032a:	8aba                	mv	s5,a4
  80032c:	02500a13          	li	s4,37
  800330:	5bfd                	li	s7,-1
  800332:	00000b17          	auipc	s6,0x0
  800336:	69ab0b13          	addi	s6,s6,1690 # 8009cc <main+0x1ba>
  80033a:	000dc503          	lbu	a0,0(s11)
  80033e:	001d8413          	addi	s0,s11,1
  800342:	01450b63          	beq	a0,s4,800358 <vprintfmt+0x52>
  800346:	c129                	beqz	a0,800388 <vprintfmt+0x82>
  800348:	864a                	mv	a2,s2
  80034a:	85a6                	mv	a1,s1
  80034c:	0405                	addi	s0,s0,1
  80034e:	9982                	jalr	s3
  800350:	fff44503          	lbu	a0,-1(s0)
  800354:	ff4519e3          	bne	a0,s4,800346 <vprintfmt+0x40>
  800358:	00044583          	lbu	a1,0(s0)
  80035c:	02000813          	li	a6,32
  800360:	4d01                	li	s10,0
  800362:	4301                	li	t1,0
  800364:	5cfd                	li	s9,-1
  800366:	5c7d                	li	s8,-1
  800368:	05500513          	li	a0,85
  80036c:	48a5                	li	a7,9
  80036e:	fdd5861b          	addiw	a2,a1,-35
  800372:	0ff67613          	zext.b	a2,a2
  800376:	00140d93          	addi	s11,s0,1
  80037a:	04c56263          	bltu	a0,a2,8003be <vprintfmt+0xb8>
  80037e:	060a                	slli	a2,a2,0x2
  800380:	965a                	add	a2,a2,s6
  800382:	4214                	lw	a3,0(a2)
  800384:	96da                	add	a3,a3,s6
  800386:	8682                	jr	a3
  800388:	70e6                	ld	ra,120(sp)
  80038a:	7446                	ld	s0,112(sp)
  80038c:	74a6                	ld	s1,104(sp)
  80038e:	7906                	ld	s2,96(sp)
  800390:	69e6                	ld	s3,88(sp)
  800392:	6a46                	ld	s4,80(sp)
  800394:	6aa6                	ld	s5,72(sp)
  800396:	6b06                	ld	s6,64(sp)
  800398:	7be2                	ld	s7,56(sp)
  80039a:	7c42                	ld	s8,48(sp)
  80039c:	7ca2                	ld	s9,40(sp)
  80039e:	7d02                	ld	s10,32(sp)
  8003a0:	6de2                	ld	s11,24(sp)
  8003a2:	6109                	addi	sp,sp,128
  8003a4:	8082                	ret
  8003a6:	882e                	mv	a6,a1
  8003a8:	00144583          	lbu	a1,1(s0)
  8003ac:	846e                	mv	s0,s11
  8003ae:	00140d93          	addi	s11,s0,1
  8003b2:	fdd5861b          	addiw	a2,a1,-35
  8003b6:	0ff67613          	zext.b	a2,a2
  8003ba:	fcc572e3          	bgeu	a0,a2,80037e <vprintfmt+0x78>
  8003be:	864a                	mv	a2,s2
  8003c0:	85a6                	mv	a1,s1
  8003c2:	02500513          	li	a0,37
  8003c6:	9982                	jalr	s3
  8003c8:	fff44783          	lbu	a5,-1(s0)
  8003cc:	8da2                	mv	s11,s0
  8003ce:	f74786e3          	beq	a5,s4,80033a <vprintfmt+0x34>
  8003d2:	ffedc783          	lbu	a5,-2(s11)
  8003d6:	1dfd                	addi	s11,s11,-1
  8003d8:	ff479de3          	bne	a5,s4,8003d2 <vprintfmt+0xcc>
  8003dc:	bfb9                	j	80033a <vprintfmt+0x34>
  8003de:	fd058c9b          	addiw	s9,a1,-48
  8003e2:	00144583          	lbu	a1,1(s0)
  8003e6:	846e                	mv	s0,s11
  8003e8:	fd05869b          	addiw	a3,a1,-48
  8003ec:	0005861b          	sext.w	a2,a1
  8003f0:	02d8e463          	bltu	a7,a3,800418 <vprintfmt+0x112>
  8003f4:	00144583          	lbu	a1,1(s0)
  8003f8:	002c969b          	slliw	a3,s9,0x2
  8003fc:	0196873b          	addw	a4,a3,s9
  800400:	0017171b          	slliw	a4,a4,0x1
  800404:	9f31                	addw	a4,a4,a2
  800406:	fd05869b          	addiw	a3,a1,-48
  80040a:	0405                	addi	s0,s0,1
  80040c:	fd070c9b          	addiw	s9,a4,-48
  800410:	0005861b          	sext.w	a2,a1
  800414:	fed8f0e3          	bgeu	a7,a3,8003f4 <vprintfmt+0xee>
  800418:	f40c5be3          	bgez	s8,80036e <vprintfmt+0x68>
  80041c:	8c66                	mv	s8,s9
  80041e:	5cfd                	li	s9,-1
  800420:	b7b9                	j	80036e <vprintfmt+0x68>
  800422:	fffc4693          	not	a3,s8
  800426:	96fd                	srai	a3,a3,0x3f
  800428:	00dc77b3          	and	a5,s8,a3
  80042c:	00144583          	lbu	a1,1(s0)
  800430:	00078c1b          	sext.w	s8,a5
  800434:	846e                	mv	s0,s11
  800436:	bf25                	j	80036e <vprintfmt+0x68>
  800438:	000aac83          	lw	s9,0(s5)
  80043c:	00144583          	lbu	a1,1(s0)
  800440:	0aa1                	addi	s5,s5,8
  800442:	846e                	mv	s0,s11
  800444:	bfd1                	j	800418 <vprintfmt+0x112>
  800446:	4705                	li	a4,1
  800448:	008a8613          	addi	a2,s5,8
  80044c:	00674463          	blt	a4,t1,800454 <vprintfmt+0x14e>
  800450:	1c030c63          	beqz	t1,800628 <vprintfmt+0x322>
  800454:	000ab683          	ld	a3,0(s5)
  800458:	4741                	li	a4,16
  80045a:	8ab2                	mv	s5,a2
  80045c:	2801                	sext.w	a6,a6
  80045e:	87e2                	mv	a5,s8
  800460:	8626                	mv	a2,s1
  800462:	85ca                	mv	a1,s2
  800464:	854e                	mv	a0,s3
  800466:	e2bff0ef          	jal	ra,800290 <printnum>
  80046a:	bdc1                	j	80033a <vprintfmt+0x34>
  80046c:	000aa503          	lw	a0,0(s5)
  800470:	864a                	mv	a2,s2
  800472:	85a6                	mv	a1,s1
  800474:	0aa1                	addi	s5,s5,8
  800476:	9982                	jalr	s3
  800478:	b5c9                	j	80033a <vprintfmt+0x34>
  80047a:	4705                	li	a4,1
  80047c:	008a8613          	addi	a2,s5,8
  800480:	00674463          	blt	a4,t1,800488 <vprintfmt+0x182>
  800484:	18030d63          	beqz	t1,80061e <vprintfmt+0x318>
  800488:	000ab683          	ld	a3,0(s5)
  80048c:	4729                	li	a4,10
  80048e:	8ab2                	mv	s5,a2
  800490:	b7f1                	j	80045c <vprintfmt+0x156>
  800492:	00144583          	lbu	a1,1(s0)
  800496:	4d05                	li	s10,1
  800498:	846e                	mv	s0,s11
  80049a:	bdd1                	j	80036e <vprintfmt+0x68>
  80049c:	864a                	mv	a2,s2
  80049e:	85a6                	mv	a1,s1
  8004a0:	02500513          	li	a0,37
  8004a4:	9982                	jalr	s3
  8004a6:	bd51                	j	80033a <vprintfmt+0x34>
  8004a8:	00144583          	lbu	a1,1(s0)
  8004ac:	2305                	addiw	t1,t1,1
  8004ae:	846e                	mv	s0,s11
  8004b0:	bd7d                	j	80036e <vprintfmt+0x68>
  8004b2:	4705                	li	a4,1
  8004b4:	008a8613          	addi	a2,s5,8
  8004b8:	00674463          	blt	a4,t1,8004c0 <vprintfmt+0x1ba>
  8004bc:	14030c63          	beqz	t1,800614 <vprintfmt+0x30e>
  8004c0:	000ab683          	ld	a3,0(s5)
  8004c4:	4721                	li	a4,8
  8004c6:	8ab2                	mv	s5,a2
  8004c8:	bf51                	j	80045c <vprintfmt+0x156>
  8004ca:	03000513          	li	a0,48
  8004ce:	864a                	mv	a2,s2
  8004d0:	85a6                	mv	a1,s1
  8004d2:	e042                	sd	a6,0(sp)
  8004d4:	9982                	jalr	s3
  8004d6:	864a                	mv	a2,s2
  8004d8:	85a6                	mv	a1,s1
  8004da:	07800513          	li	a0,120
  8004de:	9982                	jalr	s3
  8004e0:	0aa1                	addi	s5,s5,8
  8004e2:	6802                	ld	a6,0(sp)
  8004e4:	4741                	li	a4,16
  8004e6:	ff8ab683          	ld	a3,-8(s5)
  8004ea:	bf8d                	j	80045c <vprintfmt+0x156>
  8004ec:	000ab403          	ld	s0,0(s5)
  8004f0:	008a8793          	addi	a5,s5,8
  8004f4:	e03e                	sd	a5,0(sp)
  8004f6:	14040c63          	beqz	s0,80064e <vprintfmt+0x348>
  8004fa:	11805063          	blez	s8,8005fa <vprintfmt+0x2f4>
  8004fe:	02d00693          	li	a3,45
  800502:	0cd81963          	bne	a6,a3,8005d4 <vprintfmt+0x2ce>
  800506:	00044683          	lbu	a3,0(s0)
  80050a:	0006851b          	sext.w	a0,a3
  80050e:	ce8d                	beqz	a3,800548 <vprintfmt+0x242>
  800510:	00140a93          	addi	s5,s0,1
  800514:	05e00413          	li	s0,94
  800518:	000cc563          	bltz	s9,800522 <vprintfmt+0x21c>
  80051c:	3cfd                	addiw	s9,s9,-1
  80051e:	037c8363          	beq	s9,s7,800544 <vprintfmt+0x23e>
  800522:	864a                	mv	a2,s2
  800524:	85a6                	mv	a1,s1
  800526:	100d0663          	beqz	s10,800632 <vprintfmt+0x32c>
  80052a:	3681                	addiw	a3,a3,-32
  80052c:	10d47363          	bgeu	s0,a3,800632 <vprintfmt+0x32c>
  800530:	03f00513          	li	a0,63
  800534:	9982                	jalr	s3
  800536:	000ac683          	lbu	a3,0(s5)
  80053a:	3c7d                	addiw	s8,s8,-1
  80053c:	0a85                	addi	s5,s5,1
  80053e:	0006851b          	sext.w	a0,a3
  800542:	faf9                	bnez	a3,800518 <vprintfmt+0x212>
  800544:	01805a63          	blez	s8,800558 <vprintfmt+0x252>
  800548:	3c7d                	addiw	s8,s8,-1
  80054a:	864a                	mv	a2,s2
  80054c:	85a6                	mv	a1,s1
  80054e:	02000513          	li	a0,32
  800552:	9982                	jalr	s3
  800554:	fe0c1ae3          	bnez	s8,800548 <vprintfmt+0x242>
  800558:	6a82                	ld	s5,0(sp)
  80055a:	b3c5                	j	80033a <vprintfmt+0x34>
  80055c:	4705                	li	a4,1
  80055e:	008a8d13          	addi	s10,s5,8
  800562:	00674463          	blt	a4,t1,80056a <vprintfmt+0x264>
  800566:	0a030463          	beqz	t1,80060e <vprintfmt+0x308>
  80056a:	000ab403          	ld	s0,0(s5)
  80056e:	0c044463          	bltz	s0,800636 <vprintfmt+0x330>
  800572:	86a2                	mv	a3,s0
  800574:	8aea                	mv	s5,s10
  800576:	4729                	li	a4,10
  800578:	b5d5                	j	80045c <vprintfmt+0x156>
  80057a:	000aa783          	lw	a5,0(s5)
  80057e:	46e1                	li	a3,24
  800580:	0aa1                	addi	s5,s5,8
  800582:	41f7d71b          	sraiw	a4,a5,0x1f
  800586:	8fb9                	xor	a5,a5,a4
  800588:	40e7873b          	subw	a4,a5,a4
  80058c:	02e6c663          	blt	a3,a4,8005b8 <vprintfmt+0x2b2>
  800590:	00371793          	slli	a5,a4,0x3
  800594:	00000697          	auipc	a3,0x0
  800598:	76c68693          	addi	a3,a3,1900 # 800d00 <error_string>
  80059c:	97b6                	add	a5,a5,a3
  80059e:	639c                	ld	a5,0(a5)
  8005a0:	cf81                	beqz	a5,8005b8 <vprintfmt+0x2b2>
  8005a2:	873e                	mv	a4,a5
  8005a4:	00000697          	auipc	a3,0x0
  8005a8:	42468693          	addi	a3,a3,1060 # 8009c8 <main+0x1b6>
  8005ac:	8626                	mv	a2,s1
  8005ae:	85ca                	mv	a1,s2
  8005b0:	854e                	mv	a0,s3
  8005b2:	0d4000ef          	jal	ra,800686 <printfmt>
  8005b6:	b351                	j	80033a <vprintfmt+0x34>
  8005b8:	00000697          	auipc	a3,0x0
  8005bc:	40068693          	addi	a3,a3,1024 # 8009b8 <main+0x1a6>
  8005c0:	8626                	mv	a2,s1
  8005c2:	85ca                	mv	a1,s2
  8005c4:	854e                	mv	a0,s3
  8005c6:	0c0000ef          	jal	ra,800686 <printfmt>
  8005ca:	bb85                	j	80033a <vprintfmt+0x34>
  8005cc:	00000417          	auipc	s0,0x0
  8005d0:	3e440413          	addi	s0,s0,996 # 8009b0 <main+0x19e>
  8005d4:	85e6                	mv	a1,s9
  8005d6:	8522                	mv	a0,s0
  8005d8:	e442                	sd	a6,8(sp)
  8005da:	10a000ef          	jal	ra,8006e4 <strnlen>
  8005de:	40ac0c3b          	subw	s8,s8,a0
  8005e2:	01805c63          	blez	s8,8005fa <vprintfmt+0x2f4>
  8005e6:	6822                	ld	a6,8(sp)
  8005e8:	00080a9b          	sext.w	s5,a6
  8005ec:	3c7d                	addiw	s8,s8,-1
  8005ee:	864a                	mv	a2,s2
  8005f0:	85a6                	mv	a1,s1
  8005f2:	8556                	mv	a0,s5
  8005f4:	9982                	jalr	s3
  8005f6:	fe0c1be3          	bnez	s8,8005ec <vprintfmt+0x2e6>
  8005fa:	00044683          	lbu	a3,0(s0)
  8005fe:	00140a93          	addi	s5,s0,1
  800602:	0006851b          	sext.w	a0,a3
  800606:	daa9                	beqz	a3,800558 <vprintfmt+0x252>
  800608:	05e00413          	li	s0,94
  80060c:	b731                	j	800518 <vprintfmt+0x212>
  80060e:	000aa403          	lw	s0,0(s5)
  800612:	bfb1                	j	80056e <vprintfmt+0x268>
  800614:	000ae683          	lwu	a3,0(s5)
  800618:	4721                	li	a4,8
  80061a:	8ab2                	mv	s5,a2
  80061c:	b581                	j	80045c <vprintfmt+0x156>
  80061e:	000ae683          	lwu	a3,0(s5)
  800622:	4729                	li	a4,10
  800624:	8ab2                	mv	s5,a2
  800626:	bd1d                	j	80045c <vprintfmt+0x156>
  800628:	000ae683          	lwu	a3,0(s5)
  80062c:	4741                	li	a4,16
  80062e:	8ab2                	mv	s5,a2
  800630:	b535                	j	80045c <vprintfmt+0x156>
  800632:	9982                	jalr	s3
  800634:	b709                	j	800536 <vprintfmt+0x230>
  800636:	864a                	mv	a2,s2
  800638:	85a6                	mv	a1,s1
  80063a:	02d00513          	li	a0,45
  80063e:	e042                	sd	a6,0(sp)
  800640:	9982                	jalr	s3
  800642:	6802                	ld	a6,0(sp)
  800644:	8aea                	mv	s5,s10
  800646:	408006b3          	neg	a3,s0
  80064a:	4729                	li	a4,10
  80064c:	bd01                	j	80045c <vprintfmt+0x156>
  80064e:	03805163          	blez	s8,800670 <vprintfmt+0x36a>
  800652:	02d00693          	li	a3,45
  800656:	f6d81be3          	bne	a6,a3,8005cc <vprintfmt+0x2c6>
  80065a:	00000417          	auipc	s0,0x0
  80065e:	35640413          	addi	s0,s0,854 # 8009b0 <main+0x19e>
  800662:	02800693          	li	a3,40
  800666:	02800513          	li	a0,40
  80066a:	00140a93          	addi	s5,s0,1
  80066e:	b55d                	j	800514 <vprintfmt+0x20e>
  800670:	00000a97          	auipc	s5,0x0
  800674:	341a8a93          	addi	s5,s5,833 # 8009b1 <main+0x19f>
  800678:	02800513          	li	a0,40
  80067c:	02800693          	li	a3,40
  800680:	05e00413          	li	s0,94
  800684:	bd51                	j	800518 <vprintfmt+0x212>

0000000000800686 <printfmt>:
  800686:	7139                	addi	sp,sp,-64
  800688:	02010313          	addi	t1,sp,32
  80068c:	f03a                	sd	a4,32(sp)
  80068e:	871a                	mv	a4,t1
  800690:	ec06                	sd	ra,24(sp)
  800692:	f43e                	sd	a5,40(sp)
  800694:	f842                	sd	a6,48(sp)
  800696:	fc46                	sd	a7,56(sp)
  800698:	e41a                	sd	t1,8(sp)
  80069a:	c6dff0ef          	jal	ra,800306 <vprintfmt>
  80069e:	60e2                	ld	ra,24(sp)
  8006a0:	6121                	addi	sp,sp,64
  8006a2:	8082                	ret

00000000008006a4 <rand>:
  8006a4:	00001697          	auipc	a3,0x1
  8006a8:	95c68693          	addi	a3,a3,-1700 # 801000 <next>
  8006ac:	629c                	ld	a5,0(a3)
  8006ae:	00000717          	auipc	a4,0x0
  8006b2:	79a73703          	ld	a4,1946(a4) # 800e48 <error_string+0x148>
  8006b6:	02e787b3          	mul	a5,a5,a4
  8006ba:	80000737          	lui	a4,0x80000
  8006be:	fff74713          	not	a4,a4
  8006c2:	07ad                	addi	a5,a5,11
  8006c4:	07c2                	slli	a5,a5,0x10
  8006c6:	83c1                	srli	a5,a5,0x10
  8006c8:	00c7d513          	srli	a0,a5,0xc
  8006cc:	02e57533          	remu	a0,a0,a4
  8006d0:	e29c                	sd	a5,0(a3)
  8006d2:	2505                	addiw	a0,a0,1
  8006d4:	8082                	ret

00000000008006d6 <srand>:
  8006d6:	1502                	slli	a0,a0,0x20
  8006d8:	9101                	srli	a0,a0,0x20
  8006da:	00001797          	auipc	a5,0x1
  8006de:	92a7b323          	sd	a0,-1754(a5) # 801000 <next>
  8006e2:	8082                	ret

00000000008006e4 <strnlen>:
  8006e4:	4781                	li	a5,0
  8006e6:	e589                	bnez	a1,8006f0 <strnlen+0xc>
  8006e8:	a811                	j	8006fc <strnlen+0x18>
  8006ea:	0785                	addi	a5,a5,1
  8006ec:	00f58863          	beq	a1,a5,8006fc <strnlen+0x18>
  8006f0:	00f50733          	add	a4,a0,a5
  8006f4:	00074703          	lbu	a4,0(a4) # ffffffff80000000 <__global_pointer$+0xffffffff7f7fe800>
  8006f8:	fb6d                	bnez	a4,8006ea <strnlen+0x6>
  8006fa:	85be                	mv	a1,a5
  8006fc:	852e                	mv	a0,a1
  8006fe:	8082                	ret

0000000000800700 <memset>:
  800700:	ca01                	beqz	a2,800710 <memset+0x10>
  800702:	962a                	add	a2,a2,a0
  800704:	87aa                	mv	a5,a0
  800706:	0785                	addi	a5,a5,1
  800708:	feb78fa3          	sb	a1,-1(a5)
  80070c:	fec79de3          	bne	a5,a2,800706 <memset+0x6>
  800710:	8082                	ret

0000000000800712 <work>:
  800712:	7179                	addi	sp,sp,-48
  800714:	ec26                	sd	s1,24(sp)
  800716:	80818493          	addi	s1,gp,-2040 # 801008 <mata>
  80071a:	f022                	sd	s0,32(sp)
  80071c:	e84a                	sd	s2,16(sp)
  80071e:	e44e                	sd	s3,8(sp)
  800720:	f406                	sd	ra,40(sp)
  800722:	89aa                	mv	s3,a0
  800724:	99818913          	addi	s2,gp,-1640 # 801198 <matb>
  800728:	9c018593          	addi	a1,gp,-1600 # 8011c0 <matb+0x28>
  80072c:	b5018413          	addi	s0,gp,-1200 # 801350 <matc+0x28>
  800730:	8626                	mv	a2,s1
  800732:	4685                	li	a3,1
  800734:	fd858793          	addi	a5,a1,-40
  800738:	8732                	mv	a4,a2
  80073a:	c394                	sw	a3,0(a5)
  80073c:	c314                	sw	a3,0(a4)
  80073e:	0791                	addi	a5,a5,4
  800740:	0711                	addi	a4,a4,4
  800742:	feb79ce3          	bne	a5,a1,80073a <work+0x28>
  800746:	02878593          	addi	a1,a5,40
  80074a:	02860613          	addi	a2,a2,40
  80074e:	fe8593e3          	bne	a1,s0,800734 <work+0x22>
  800752:	a81ff0ef          	jal	ra,8001d2 <yield>
  800756:	a81ff0ef          	jal	ra,8001d6 <getpid>
  80075a:	85aa                	mv	a1,a0
  80075c:	864e                	mv	a2,s3
  80075e:	00000517          	auipc	a0,0x0
  800762:	66a50513          	addi	a0,a0,1642 # 800dc8 <error_string+0xc8>
  800766:	999ff0ef          	jal	ra,8000fe <cprintf>
  80076a:	fff9839b          	addiw	t2,s3,-1
  80076e:	cb818293          	addi	t0,gp,-840 # 8014b8 <matc+0x190>
  800772:	99818f93          	addi	t6,gp,-1640 # 801198 <matb>
  800776:	b2818f13          	addi	t5,gp,-1240 # 801328 <matc>
  80077a:	02800e13          	li	t3,40
  80077e:	50fd                	li	ra,-1
  800780:	06098d63          	beqz	s3,8007fa <work+0xe8>
  800784:	b2818893          	addi	a7,gp,-1240 # 801328 <matc>
  800788:	8ec6                	mv	t4,a7
  80078a:	8326                	mv	t1,s1
  80078c:	857a                	mv	a0,t5
  80078e:	8876                	mv	a6,t4
  800790:	e7050793          	addi	a5,a0,-400
  800794:	869a                	mv	a3,t1
  800796:	4601                	li	a2,0
  800798:	4298                	lw	a4,0(a3)
  80079a:	438c                	lw	a1,0(a5)
  80079c:	02878793          	addi	a5,a5,40
  8007a0:	0691                	addi	a3,a3,4
  8007a2:	02b7073b          	mulw	a4,a4,a1
  8007a6:	9e39                	addw	a2,a2,a4
  8007a8:	fea798e3          	bne	a5,a0,800798 <work+0x86>
  8007ac:	00c82023          	sw	a2,0(a6)
  8007b0:	00478513          	addi	a0,a5,4
  8007b4:	0811                	addi	a6,a6,4
  8007b6:	fc851de3          	bne	a0,s0,800790 <work+0x7e>
  8007ba:	02830313          	addi	t1,t1,40
  8007be:	028e8e93          	addi	t4,t4,40
  8007c2:	fc6f95e3          	bne	t6,t1,80078c <work+0x7a>
  8007c6:	8526                	mv	a0,s1
  8007c8:	85ca                	mv	a1,s2
  8007ca:	4781                	li	a5,0
  8007cc:	00f88733          	add	a4,a7,a5
  8007d0:	4318                	lw	a4,0(a4)
  8007d2:	00f58633          	add	a2,a1,a5
  8007d6:	00f506b3          	add	a3,a0,a5
  8007da:	c218                	sw	a4,0(a2)
  8007dc:	c298                	sw	a4,0(a3)
  8007de:	0791                	addi	a5,a5,4
  8007e0:	ffc796e3          	bne	a5,t3,8007cc <work+0xba>
  8007e4:	02888893          	addi	a7,a7,40
  8007e8:	02858593          	addi	a1,a1,40
  8007ec:	02850513          	addi	a0,a0,40
  8007f0:	fc589de3          	bne	a7,t0,8007ca <work+0xb8>
  8007f4:	33fd                	addiw	t2,t2,-1
  8007f6:	f81397e3          	bne	t2,ra,800784 <work+0x72>
  8007fa:	9ddff0ef          	jal	ra,8001d6 <getpid>
  8007fe:	85aa                	mv	a1,a0
  800800:	00000517          	auipc	a0,0x0
  800804:	5e850513          	addi	a0,a0,1512 # 800de8 <error_string+0xe8>
  800808:	8f7ff0ef          	jal	ra,8000fe <cprintf>
  80080c:	4501                	li	a0,0
  80080e:	9a7ff0ef          	jal	ra,8001b4 <exit>

0000000000800812 <main>:
  800812:	7175                	addi	sp,sp,-144
  800814:	f4ce                	sd	s3,104(sp)
  800816:	05400613          	li	a2,84
  80081a:	4581                	li	a1,0
  80081c:	0028                	addi	a0,sp,8
  80081e:	00810993          	addi	s3,sp,8
  800822:	e122                	sd	s0,128(sp)
  800824:	fca6                	sd	s1,120(sp)
  800826:	f8ca                	sd	s2,112(sp)
  800828:	e506                	sd	ra,136(sp)
  80082a:	84ce                	mv	s1,s3
  80082c:	ed5ff0ef          	jal	ra,800700 <memset>
  800830:	4401                	li	s0,0
  800832:	4955                	li	s2,21
  800834:	997ff0ef          	jal	ra,8001ca <fork>
  800838:	c088                	sw	a0,0(s1)
  80083a:	cd2d                	beqz	a0,8008b4 <main+0xa2>
  80083c:	04054663          	bltz	a0,800888 <main+0x76>
  800840:	2405                	addiw	s0,s0,1
  800842:	0491                	addi	s1,s1,4
  800844:	ff2418e3          	bne	s0,s2,800834 <main+0x22>
  800848:	00000517          	auipc	a0,0x0
  80084c:	5b050513          	addi	a0,a0,1456 # 800df8 <error_string+0xf8>
  800850:	8afff0ef          	jal	ra,8000fe <cprintf>
  800854:	4455                	li	s0,21
  800856:	977ff0ef          	jal	ra,8001cc <wait>
  80085a:	e10d                	bnez	a0,80087c <main+0x6a>
  80085c:	347d                	addiw	s0,s0,-1
  80085e:	fc65                	bnez	s0,800856 <main+0x44>
  800860:	00000517          	auipc	a0,0x0
  800864:	5b850513          	addi	a0,a0,1464 # 800e18 <error_string+0x118>
  800868:	897ff0ef          	jal	ra,8000fe <cprintf>
  80086c:	60aa                	ld	ra,136(sp)
  80086e:	640a                	ld	s0,128(sp)
  800870:	74e6                	ld	s1,120(sp)
  800872:	7946                	ld	s2,112(sp)
  800874:	79a6                	ld	s3,104(sp)
  800876:	4501                	li	a0,0
  800878:	6149                	addi	sp,sp,144
  80087a:	8082                	ret
  80087c:	00000517          	auipc	a0,0x0
  800880:	58c50513          	addi	a0,a0,1420 # 800e08 <error_string+0x108>
  800884:	87bff0ef          	jal	ra,8000fe <cprintf>
  800888:	08e0                	addi	s0,sp,92
  80088a:	0009a503          	lw	a0,0(s3)
  80088e:	00a05463          	blez	a0,800896 <main+0x84>
  800892:	943ff0ef          	jal	ra,8001d4 <kill>
  800896:	0991                	addi	s3,s3,4
  800898:	fe8999e3          	bne	s3,s0,80088a <main+0x78>
  80089c:	00000617          	auipc	a2,0x0
  8008a0:	58c60613          	addi	a2,a2,1420 # 800e28 <error_string+0x128>
  8008a4:	05200593          	li	a1,82
  8008a8:	00000517          	auipc	a0,0x0
  8008ac:	59050513          	addi	a0,a0,1424 # 800e38 <error_string+0x138>
  8008b0:	f88ff0ef          	jal	ra,800038 <__panic>
  8008b4:	0284053b          	mulw	a0,s0,s0
  8008b8:	e1fff0ef          	jal	ra,8006d6 <srand>
  8008bc:	de9ff0ef          	jal	ra,8006a4 <rand>
  8008c0:	47d5                	li	a5,21
  8008c2:	02f577bb          	remuw	a5,a0,a5
  8008c6:	06400513          	li	a0,100
  8008ca:	02f787bb          	mulw	a5,a5,a5
  8008ce:	27a9                	addiw	a5,a5,10
  8008d0:	02f5053b          	mulw	a0,a0,a5
  8008d4:	e3fff0ef          	jal	ra,800712 <work>
