
obj/__user_priority.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	aab5                	j	8001a0 <sys_open>

0000000000800026 <close>:
  800026:	a251                	j	8001aa <sys_close>

0000000000800028 <dup2>:
  800028:	a269                	j	8001b2 <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	1f4000ef          	jal	ra,800226 <umain>
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
  80004c:	84050513          	addi	a0,a0,-1984 # 800888 <main+0x1ac>
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
  80006c:	89850513          	addi	a0,a0,-1896 # 800900 <main+0x224>
  800070:	08e000ef          	jal	ra,8000fe <cprintf>
  800074:	5559                	li	a0,-10
  800076:	146000ef          	jal	ra,8001bc <exit>

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
  80008e:	81e50513          	addi	a0,a0,-2018 # 8008a8 <main+0x1cc>
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
  8000ae:	85650513          	addi	a0,a0,-1962 # 800900 <main+0x224>
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
  8000f2:	21e000ef          	jal	ra,800310 <vprintfmt>
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
  80012e:	1e2000ef          	jal	ra,800310 <vprintfmt>
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

0000000000800184 <sys_kill>:
  800184:	85aa                	mv	a1,a0
  800186:	4531                	li	a0,12
  800188:	bf4d                	j	80013a <syscall>

000000000080018a <sys_getpid>:
  80018a:	4549                	li	a0,18
  80018c:	b77d                	j	80013a <syscall>

000000000080018e <sys_putc>:
  80018e:	85aa                	mv	a1,a0
  800190:	4579                	li	a0,30
  800192:	b765                	j	80013a <syscall>

0000000000800194 <sys_lab6_set_priority>:
  800194:	85aa                	mv	a1,a0
  800196:	0ff00513          	li	a0,255
  80019a:	b745                	j	80013a <syscall>

000000000080019c <sys_gettime>:
  80019c:	4545                	li	a0,17
  80019e:	bf71                	j	80013a <syscall>

00000000008001a0 <sys_open>:
  8001a0:	862e                	mv	a2,a1
  8001a2:	85aa                	mv	a1,a0
  8001a4:	06400513          	li	a0,100
  8001a8:	bf49                	j	80013a <syscall>

00000000008001aa <sys_close>:
  8001aa:	85aa                	mv	a1,a0
  8001ac:	06500513          	li	a0,101
  8001b0:	b769                	j	80013a <syscall>

00000000008001b2 <sys_dup>:
  8001b2:	862e                	mv	a2,a1
  8001b4:	85aa                	mv	a1,a0
  8001b6:	08200513          	li	a0,130
  8001ba:	b741                	j	80013a <syscall>

00000000008001bc <exit>:
  8001bc:	1141                	addi	sp,sp,-16
  8001be:	e406                	sd	ra,8(sp)
  8001c0:	fb3ff0ef          	jal	ra,800172 <sys_exit>
  8001c4:	00000517          	auipc	a0,0x0
  8001c8:	70450513          	addi	a0,a0,1796 # 8008c8 <main+0x1ec>
  8001cc:	f33ff0ef          	jal	ra,8000fe <cprintf>
  8001d0:	a001                	j	8001d0 <exit+0x14>

00000000008001d2 <fork>:
  8001d2:	b75d                	j	800178 <sys_fork>

00000000008001d4 <waitpid>:
  8001d4:	b765                	j	80017c <sys_wait>

00000000008001d6 <kill>:
  8001d6:	b77d                	j	800184 <sys_kill>

00000000008001d8 <getpid>:
  8001d8:	bf4d                	j	80018a <sys_getpid>

00000000008001da <gettime_msec>:
  8001da:	b7c9                	j	80019c <sys_gettime>

00000000008001dc <lab6_set_priority>:
  8001dc:	1502                	slli	a0,a0,0x20
  8001de:	9101                	srli	a0,a0,0x20
  8001e0:	bf55                	j	800194 <sys_lab6_set_priority>

00000000008001e2 <initfd>:
  8001e2:	1101                	addi	sp,sp,-32
  8001e4:	87ae                	mv	a5,a1
  8001e6:	e426                	sd	s1,8(sp)
  8001e8:	85b2                	mv	a1,a2
  8001ea:	84aa                	mv	s1,a0
  8001ec:	853e                	mv	a0,a5
  8001ee:	e822                	sd	s0,16(sp)
  8001f0:	ec06                	sd	ra,24(sp)
  8001f2:	e2fff0ef          	jal	ra,800020 <open>
  8001f6:	842a                	mv	s0,a0
  8001f8:	00054463          	bltz	a0,800200 <initfd+0x1e>
  8001fc:	00951863          	bne	a0,s1,80020c <initfd+0x2a>
  800200:	60e2                	ld	ra,24(sp)
  800202:	8522                	mv	a0,s0
  800204:	6442                	ld	s0,16(sp)
  800206:	64a2                	ld	s1,8(sp)
  800208:	6105                	addi	sp,sp,32
  80020a:	8082                	ret
  80020c:	8526                	mv	a0,s1
  80020e:	e19ff0ef          	jal	ra,800026 <close>
  800212:	85a6                	mv	a1,s1
  800214:	8522                	mv	a0,s0
  800216:	e13ff0ef          	jal	ra,800028 <dup2>
  80021a:	84aa                	mv	s1,a0
  80021c:	8522                	mv	a0,s0
  80021e:	e09ff0ef          	jal	ra,800026 <close>
  800222:	8426                	mv	s0,s1
  800224:	bff1                	j	800200 <initfd+0x1e>

0000000000800226 <umain>:
  800226:	1101                	addi	sp,sp,-32
  800228:	e822                	sd	s0,16(sp)
  80022a:	e426                	sd	s1,8(sp)
  80022c:	842a                	mv	s0,a0
  80022e:	84ae                	mv	s1,a1
  800230:	4601                	li	a2,0
  800232:	00000597          	auipc	a1,0x0
  800236:	6ae58593          	addi	a1,a1,1710 # 8008e0 <main+0x204>
  80023a:	4501                	li	a0,0
  80023c:	ec06                	sd	ra,24(sp)
  80023e:	fa5ff0ef          	jal	ra,8001e2 <initfd>
  800242:	02054263          	bltz	a0,800266 <umain+0x40>
  800246:	4605                	li	a2,1
  800248:	00000597          	auipc	a1,0x0
  80024c:	6d858593          	addi	a1,a1,1752 # 800920 <main+0x244>
  800250:	4505                	li	a0,1
  800252:	f91ff0ef          	jal	ra,8001e2 <initfd>
  800256:	02054563          	bltz	a0,800280 <umain+0x5a>
  80025a:	85a6                	mv	a1,s1
  80025c:	8522                	mv	a0,s0
  80025e:	47e000ef          	jal	ra,8006dc <main>
  800262:	f5bff0ef          	jal	ra,8001bc <exit>
  800266:	86aa                	mv	a3,a0
  800268:	00000617          	auipc	a2,0x0
  80026c:	68060613          	addi	a2,a2,1664 # 8008e8 <main+0x20c>
  800270:	45e9                	li	a1,26
  800272:	00000517          	auipc	a0,0x0
  800276:	69650513          	addi	a0,a0,1686 # 800908 <main+0x22c>
  80027a:	e01ff0ef          	jal	ra,80007a <__warn>
  80027e:	b7e1                	j	800246 <umain+0x20>
  800280:	86aa                	mv	a3,a0
  800282:	00000617          	auipc	a2,0x0
  800286:	6a660613          	addi	a2,a2,1702 # 800928 <main+0x24c>
  80028a:	45f5                	li	a1,29
  80028c:	00000517          	auipc	a0,0x0
  800290:	67c50513          	addi	a0,a0,1660 # 800908 <main+0x22c>
  800294:	de7ff0ef          	jal	ra,80007a <__warn>
  800298:	b7c9                	j	80025a <umain+0x34>

000000000080029a <printnum>:
  80029a:	02071893          	slli	a7,a4,0x20
  80029e:	7139                	addi	sp,sp,-64
  8002a0:	0208d893          	srli	a7,a7,0x20
  8002a4:	e456                	sd	s5,8(sp)
  8002a6:	0316fab3          	remu	s5,a3,a7
  8002aa:	f822                	sd	s0,48(sp)
  8002ac:	f426                	sd	s1,40(sp)
  8002ae:	f04a                	sd	s2,32(sp)
  8002b0:	ec4e                	sd	s3,24(sp)
  8002b2:	fc06                	sd	ra,56(sp)
  8002b4:	e852                	sd	s4,16(sp)
  8002b6:	84aa                	mv	s1,a0
  8002b8:	89ae                	mv	s3,a1
  8002ba:	8932                	mv	s2,a2
  8002bc:	fff7841b          	addiw	s0,a5,-1
  8002c0:	2a81                	sext.w	s5,s5
  8002c2:	0516f163          	bgeu	a3,a7,800304 <printnum+0x6a>
  8002c6:	8a42                	mv	s4,a6
  8002c8:	00805863          	blez	s0,8002d8 <printnum+0x3e>
  8002cc:	347d                	addiw	s0,s0,-1
  8002ce:	864e                	mv	a2,s3
  8002d0:	85ca                	mv	a1,s2
  8002d2:	8552                	mv	a0,s4
  8002d4:	9482                	jalr	s1
  8002d6:	f87d                	bnez	s0,8002cc <printnum+0x32>
  8002d8:	1a82                	slli	s5,s5,0x20
  8002da:	00000797          	auipc	a5,0x0
  8002de:	66e78793          	addi	a5,a5,1646 # 800948 <main+0x26c>
  8002e2:	020ada93          	srli	s5,s5,0x20
  8002e6:	9abe                	add	s5,s5,a5
  8002e8:	7442                	ld	s0,48(sp)
  8002ea:	000ac503          	lbu	a0,0(s5)
  8002ee:	70e2                	ld	ra,56(sp)
  8002f0:	6a42                	ld	s4,16(sp)
  8002f2:	6aa2                	ld	s5,8(sp)
  8002f4:	864e                	mv	a2,s3
  8002f6:	85ca                	mv	a1,s2
  8002f8:	69e2                	ld	s3,24(sp)
  8002fa:	7902                	ld	s2,32(sp)
  8002fc:	87a6                	mv	a5,s1
  8002fe:	74a2                	ld	s1,40(sp)
  800300:	6121                	addi	sp,sp,64
  800302:	8782                	jr	a5
  800304:	0316d6b3          	divu	a3,a3,a7
  800308:	87a2                	mv	a5,s0
  80030a:	f91ff0ef          	jal	ra,80029a <printnum>
  80030e:	b7e9                	j	8002d8 <printnum+0x3e>

0000000000800310 <vprintfmt>:
  800310:	7119                	addi	sp,sp,-128
  800312:	f4a6                	sd	s1,104(sp)
  800314:	f0ca                	sd	s2,96(sp)
  800316:	ecce                	sd	s3,88(sp)
  800318:	e8d2                	sd	s4,80(sp)
  80031a:	e4d6                	sd	s5,72(sp)
  80031c:	e0da                	sd	s6,64(sp)
  80031e:	fc5e                	sd	s7,56(sp)
  800320:	ec6e                	sd	s11,24(sp)
  800322:	fc86                	sd	ra,120(sp)
  800324:	f8a2                	sd	s0,112(sp)
  800326:	f862                	sd	s8,48(sp)
  800328:	f466                	sd	s9,40(sp)
  80032a:	f06a                	sd	s10,32(sp)
  80032c:	89aa                	mv	s3,a0
  80032e:	892e                	mv	s2,a1
  800330:	84b2                	mv	s1,a2
  800332:	8db6                	mv	s11,a3
  800334:	8aba                	mv	s5,a4
  800336:	02500a13          	li	s4,37
  80033a:	5bfd                	li	s7,-1
  80033c:	00000b17          	auipc	s6,0x0
  800340:	640b0b13          	addi	s6,s6,1600 # 80097c <main+0x2a0>
  800344:	000dc503          	lbu	a0,0(s11)
  800348:	001d8413          	addi	s0,s11,1
  80034c:	01450b63          	beq	a0,s4,800362 <vprintfmt+0x52>
  800350:	c129                	beqz	a0,800392 <vprintfmt+0x82>
  800352:	864a                	mv	a2,s2
  800354:	85a6                	mv	a1,s1
  800356:	0405                	addi	s0,s0,1
  800358:	9982                	jalr	s3
  80035a:	fff44503          	lbu	a0,-1(s0)
  80035e:	ff4519e3          	bne	a0,s4,800350 <vprintfmt+0x40>
  800362:	00044583          	lbu	a1,0(s0)
  800366:	02000813          	li	a6,32
  80036a:	4d01                	li	s10,0
  80036c:	4301                	li	t1,0
  80036e:	5cfd                	li	s9,-1
  800370:	5c7d                	li	s8,-1
  800372:	05500513          	li	a0,85
  800376:	48a5                	li	a7,9
  800378:	fdd5861b          	addiw	a2,a1,-35
  80037c:	0ff67613          	zext.b	a2,a2
  800380:	00140d93          	addi	s11,s0,1
  800384:	04c56263          	bltu	a0,a2,8003c8 <vprintfmt+0xb8>
  800388:	060a                	slli	a2,a2,0x2
  80038a:	965a                	add	a2,a2,s6
  80038c:	4214                	lw	a3,0(a2)
  80038e:	96da                	add	a3,a3,s6
  800390:	8682                	jr	a3
  800392:	70e6                	ld	ra,120(sp)
  800394:	7446                	ld	s0,112(sp)
  800396:	74a6                	ld	s1,104(sp)
  800398:	7906                	ld	s2,96(sp)
  80039a:	69e6                	ld	s3,88(sp)
  80039c:	6a46                	ld	s4,80(sp)
  80039e:	6aa6                	ld	s5,72(sp)
  8003a0:	6b06                	ld	s6,64(sp)
  8003a2:	7be2                	ld	s7,56(sp)
  8003a4:	7c42                	ld	s8,48(sp)
  8003a6:	7ca2                	ld	s9,40(sp)
  8003a8:	7d02                	ld	s10,32(sp)
  8003aa:	6de2                	ld	s11,24(sp)
  8003ac:	6109                	addi	sp,sp,128
  8003ae:	8082                	ret
  8003b0:	882e                	mv	a6,a1
  8003b2:	00144583          	lbu	a1,1(s0)
  8003b6:	846e                	mv	s0,s11
  8003b8:	00140d93          	addi	s11,s0,1
  8003bc:	fdd5861b          	addiw	a2,a1,-35
  8003c0:	0ff67613          	zext.b	a2,a2
  8003c4:	fcc572e3          	bgeu	a0,a2,800388 <vprintfmt+0x78>
  8003c8:	864a                	mv	a2,s2
  8003ca:	85a6                	mv	a1,s1
  8003cc:	02500513          	li	a0,37
  8003d0:	9982                	jalr	s3
  8003d2:	fff44783          	lbu	a5,-1(s0)
  8003d6:	8da2                	mv	s11,s0
  8003d8:	f74786e3          	beq	a5,s4,800344 <vprintfmt+0x34>
  8003dc:	ffedc783          	lbu	a5,-2(s11)
  8003e0:	1dfd                	addi	s11,s11,-1
  8003e2:	ff479de3          	bne	a5,s4,8003dc <vprintfmt+0xcc>
  8003e6:	bfb9                	j	800344 <vprintfmt+0x34>
  8003e8:	fd058c9b          	addiw	s9,a1,-48
  8003ec:	00144583          	lbu	a1,1(s0)
  8003f0:	846e                	mv	s0,s11
  8003f2:	fd05869b          	addiw	a3,a1,-48
  8003f6:	0005861b          	sext.w	a2,a1
  8003fa:	02d8e463          	bltu	a7,a3,800422 <vprintfmt+0x112>
  8003fe:	00144583          	lbu	a1,1(s0)
  800402:	002c969b          	slliw	a3,s9,0x2
  800406:	0196873b          	addw	a4,a3,s9
  80040a:	0017171b          	slliw	a4,a4,0x1
  80040e:	9f31                	addw	a4,a4,a2
  800410:	fd05869b          	addiw	a3,a1,-48
  800414:	0405                	addi	s0,s0,1
  800416:	fd070c9b          	addiw	s9,a4,-48
  80041a:	0005861b          	sext.w	a2,a1
  80041e:	fed8f0e3          	bgeu	a7,a3,8003fe <vprintfmt+0xee>
  800422:	f40c5be3          	bgez	s8,800378 <vprintfmt+0x68>
  800426:	8c66                	mv	s8,s9
  800428:	5cfd                	li	s9,-1
  80042a:	b7b9                	j	800378 <vprintfmt+0x68>
  80042c:	fffc4693          	not	a3,s8
  800430:	96fd                	srai	a3,a3,0x3f
  800432:	00dc77b3          	and	a5,s8,a3
  800436:	00144583          	lbu	a1,1(s0)
  80043a:	00078c1b          	sext.w	s8,a5
  80043e:	846e                	mv	s0,s11
  800440:	bf25                	j	800378 <vprintfmt+0x68>
  800442:	000aac83          	lw	s9,0(s5)
  800446:	00144583          	lbu	a1,1(s0)
  80044a:	0aa1                	addi	s5,s5,8
  80044c:	846e                	mv	s0,s11
  80044e:	bfd1                	j	800422 <vprintfmt+0x112>
  800450:	4705                	li	a4,1
  800452:	008a8613          	addi	a2,s5,8
  800456:	00674463          	blt	a4,t1,80045e <vprintfmt+0x14e>
  80045a:	1c030c63          	beqz	t1,800632 <vprintfmt+0x322>
  80045e:	000ab683          	ld	a3,0(s5)
  800462:	4741                	li	a4,16
  800464:	8ab2                	mv	s5,a2
  800466:	2801                	sext.w	a6,a6
  800468:	87e2                	mv	a5,s8
  80046a:	8626                	mv	a2,s1
  80046c:	85ca                	mv	a1,s2
  80046e:	854e                	mv	a0,s3
  800470:	e2bff0ef          	jal	ra,80029a <printnum>
  800474:	bdc1                	j	800344 <vprintfmt+0x34>
  800476:	000aa503          	lw	a0,0(s5)
  80047a:	864a                	mv	a2,s2
  80047c:	85a6                	mv	a1,s1
  80047e:	0aa1                	addi	s5,s5,8
  800480:	9982                	jalr	s3
  800482:	b5c9                	j	800344 <vprintfmt+0x34>
  800484:	4705                	li	a4,1
  800486:	008a8613          	addi	a2,s5,8
  80048a:	00674463          	blt	a4,t1,800492 <vprintfmt+0x182>
  80048e:	18030d63          	beqz	t1,800628 <vprintfmt+0x318>
  800492:	000ab683          	ld	a3,0(s5)
  800496:	4729                	li	a4,10
  800498:	8ab2                	mv	s5,a2
  80049a:	b7f1                	j	800466 <vprintfmt+0x156>
  80049c:	00144583          	lbu	a1,1(s0)
  8004a0:	4d05                	li	s10,1
  8004a2:	846e                	mv	s0,s11
  8004a4:	bdd1                	j	800378 <vprintfmt+0x68>
  8004a6:	864a                	mv	a2,s2
  8004a8:	85a6                	mv	a1,s1
  8004aa:	02500513          	li	a0,37
  8004ae:	9982                	jalr	s3
  8004b0:	bd51                	j	800344 <vprintfmt+0x34>
  8004b2:	00144583          	lbu	a1,1(s0)
  8004b6:	2305                	addiw	t1,t1,1
  8004b8:	846e                	mv	s0,s11
  8004ba:	bd7d                	j	800378 <vprintfmt+0x68>
  8004bc:	4705                	li	a4,1
  8004be:	008a8613          	addi	a2,s5,8
  8004c2:	00674463          	blt	a4,t1,8004ca <vprintfmt+0x1ba>
  8004c6:	14030c63          	beqz	t1,80061e <vprintfmt+0x30e>
  8004ca:	000ab683          	ld	a3,0(s5)
  8004ce:	4721                	li	a4,8
  8004d0:	8ab2                	mv	s5,a2
  8004d2:	bf51                	j	800466 <vprintfmt+0x156>
  8004d4:	03000513          	li	a0,48
  8004d8:	864a                	mv	a2,s2
  8004da:	85a6                	mv	a1,s1
  8004dc:	e042                	sd	a6,0(sp)
  8004de:	9982                	jalr	s3
  8004e0:	864a                	mv	a2,s2
  8004e2:	85a6                	mv	a1,s1
  8004e4:	07800513          	li	a0,120
  8004e8:	9982                	jalr	s3
  8004ea:	0aa1                	addi	s5,s5,8
  8004ec:	6802                	ld	a6,0(sp)
  8004ee:	4741                	li	a4,16
  8004f0:	ff8ab683          	ld	a3,-8(s5)
  8004f4:	bf8d                	j	800466 <vprintfmt+0x156>
  8004f6:	000ab403          	ld	s0,0(s5)
  8004fa:	008a8793          	addi	a5,s5,8
  8004fe:	e03e                	sd	a5,0(sp)
  800500:	14040c63          	beqz	s0,800658 <vprintfmt+0x348>
  800504:	11805063          	blez	s8,800604 <vprintfmt+0x2f4>
  800508:	02d00693          	li	a3,45
  80050c:	0cd81963          	bne	a6,a3,8005de <vprintfmt+0x2ce>
  800510:	00044683          	lbu	a3,0(s0)
  800514:	0006851b          	sext.w	a0,a3
  800518:	ce8d                	beqz	a3,800552 <vprintfmt+0x242>
  80051a:	00140a93          	addi	s5,s0,1
  80051e:	05e00413          	li	s0,94
  800522:	000cc563          	bltz	s9,80052c <vprintfmt+0x21c>
  800526:	3cfd                	addiw	s9,s9,-1
  800528:	037c8363          	beq	s9,s7,80054e <vprintfmt+0x23e>
  80052c:	864a                	mv	a2,s2
  80052e:	85a6                	mv	a1,s1
  800530:	100d0663          	beqz	s10,80063c <vprintfmt+0x32c>
  800534:	3681                	addiw	a3,a3,-32
  800536:	10d47363          	bgeu	s0,a3,80063c <vprintfmt+0x32c>
  80053a:	03f00513          	li	a0,63
  80053e:	9982                	jalr	s3
  800540:	000ac683          	lbu	a3,0(s5)
  800544:	3c7d                	addiw	s8,s8,-1
  800546:	0a85                	addi	s5,s5,1
  800548:	0006851b          	sext.w	a0,a3
  80054c:	faf9                	bnez	a3,800522 <vprintfmt+0x212>
  80054e:	01805a63          	blez	s8,800562 <vprintfmt+0x252>
  800552:	3c7d                	addiw	s8,s8,-1
  800554:	864a                	mv	a2,s2
  800556:	85a6                	mv	a1,s1
  800558:	02000513          	li	a0,32
  80055c:	9982                	jalr	s3
  80055e:	fe0c1ae3          	bnez	s8,800552 <vprintfmt+0x242>
  800562:	6a82                	ld	s5,0(sp)
  800564:	b3c5                	j	800344 <vprintfmt+0x34>
  800566:	4705                	li	a4,1
  800568:	008a8d13          	addi	s10,s5,8
  80056c:	00674463          	blt	a4,t1,800574 <vprintfmt+0x264>
  800570:	0a030463          	beqz	t1,800618 <vprintfmt+0x308>
  800574:	000ab403          	ld	s0,0(s5)
  800578:	0c044463          	bltz	s0,800640 <vprintfmt+0x330>
  80057c:	86a2                	mv	a3,s0
  80057e:	8aea                	mv	s5,s10
  800580:	4729                	li	a4,10
  800582:	b5d5                	j	800466 <vprintfmt+0x156>
  800584:	000aa783          	lw	a5,0(s5)
  800588:	46e1                	li	a3,24
  80058a:	0aa1                	addi	s5,s5,8
  80058c:	41f7d71b          	sraiw	a4,a5,0x1f
  800590:	8fb9                	xor	a5,a5,a4
  800592:	40e7873b          	subw	a4,a5,a4
  800596:	02e6c663          	blt	a3,a4,8005c2 <vprintfmt+0x2b2>
  80059a:	00371793          	slli	a5,a4,0x3
  80059e:	00000697          	auipc	a3,0x0
  8005a2:	71268693          	addi	a3,a3,1810 # 800cb0 <error_string>
  8005a6:	97b6                	add	a5,a5,a3
  8005a8:	639c                	ld	a5,0(a5)
  8005aa:	cf81                	beqz	a5,8005c2 <vprintfmt+0x2b2>
  8005ac:	873e                	mv	a4,a5
  8005ae:	00000697          	auipc	a3,0x0
  8005b2:	3ca68693          	addi	a3,a3,970 # 800978 <main+0x29c>
  8005b6:	8626                	mv	a2,s1
  8005b8:	85ca                	mv	a1,s2
  8005ba:	854e                	mv	a0,s3
  8005bc:	0d4000ef          	jal	ra,800690 <printfmt>
  8005c0:	b351                	j	800344 <vprintfmt+0x34>
  8005c2:	00000697          	auipc	a3,0x0
  8005c6:	3a668693          	addi	a3,a3,934 # 800968 <main+0x28c>
  8005ca:	8626                	mv	a2,s1
  8005cc:	85ca                	mv	a1,s2
  8005ce:	854e                	mv	a0,s3
  8005d0:	0c0000ef          	jal	ra,800690 <printfmt>
  8005d4:	bb85                	j	800344 <vprintfmt+0x34>
  8005d6:	00000417          	auipc	s0,0x0
  8005da:	38a40413          	addi	s0,s0,906 # 800960 <main+0x284>
  8005de:	85e6                	mv	a1,s9
  8005e0:	8522                	mv	a0,s0
  8005e2:	e442                	sd	a6,8(sp)
  8005e4:	0ca000ef          	jal	ra,8006ae <strnlen>
  8005e8:	40ac0c3b          	subw	s8,s8,a0
  8005ec:	01805c63          	blez	s8,800604 <vprintfmt+0x2f4>
  8005f0:	6822                	ld	a6,8(sp)
  8005f2:	00080a9b          	sext.w	s5,a6
  8005f6:	3c7d                	addiw	s8,s8,-1
  8005f8:	864a                	mv	a2,s2
  8005fa:	85a6                	mv	a1,s1
  8005fc:	8556                	mv	a0,s5
  8005fe:	9982                	jalr	s3
  800600:	fe0c1be3          	bnez	s8,8005f6 <vprintfmt+0x2e6>
  800604:	00044683          	lbu	a3,0(s0)
  800608:	00140a93          	addi	s5,s0,1
  80060c:	0006851b          	sext.w	a0,a3
  800610:	daa9                	beqz	a3,800562 <vprintfmt+0x252>
  800612:	05e00413          	li	s0,94
  800616:	b731                	j	800522 <vprintfmt+0x212>
  800618:	000aa403          	lw	s0,0(s5)
  80061c:	bfb1                	j	800578 <vprintfmt+0x268>
  80061e:	000ae683          	lwu	a3,0(s5)
  800622:	4721                	li	a4,8
  800624:	8ab2                	mv	s5,a2
  800626:	b581                	j	800466 <vprintfmt+0x156>
  800628:	000ae683          	lwu	a3,0(s5)
  80062c:	4729                	li	a4,10
  80062e:	8ab2                	mv	s5,a2
  800630:	bd1d                	j	800466 <vprintfmt+0x156>
  800632:	000ae683          	lwu	a3,0(s5)
  800636:	4741                	li	a4,16
  800638:	8ab2                	mv	s5,a2
  80063a:	b535                	j	800466 <vprintfmt+0x156>
  80063c:	9982                	jalr	s3
  80063e:	b709                	j	800540 <vprintfmt+0x230>
  800640:	864a                	mv	a2,s2
  800642:	85a6                	mv	a1,s1
  800644:	02d00513          	li	a0,45
  800648:	e042                	sd	a6,0(sp)
  80064a:	9982                	jalr	s3
  80064c:	6802                	ld	a6,0(sp)
  80064e:	8aea                	mv	s5,s10
  800650:	408006b3          	neg	a3,s0
  800654:	4729                	li	a4,10
  800656:	bd01                	j	800466 <vprintfmt+0x156>
  800658:	03805163          	blez	s8,80067a <vprintfmt+0x36a>
  80065c:	02d00693          	li	a3,45
  800660:	f6d81be3          	bne	a6,a3,8005d6 <vprintfmt+0x2c6>
  800664:	00000417          	auipc	s0,0x0
  800668:	2fc40413          	addi	s0,s0,764 # 800960 <main+0x284>
  80066c:	02800693          	li	a3,40
  800670:	02800513          	li	a0,40
  800674:	00140a93          	addi	s5,s0,1
  800678:	b55d                	j	80051e <vprintfmt+0x20e>
  80067a:	00000a97          	auipc	s5,0x0
  80067e:	2e7a8a93          	addi	s5,s5,743 # 800961 <main+0x285>
  800682:	02800513          	li	a0,40
  800686:	02800693          	li	a3,40
  80068a:	05e00413          	li	s0,94
  80068e:	bd51                	j	800522 <vprintfmt+0x212>

0000000000800690 <printfmt>:
  800690:	7139                	addi	sp,sp,-64
  800692:	02010313          	addi	t1,sp,32
  800696:	f03a                	sd	a4,32(sp)
  800698:	871a                	mv	a4,t1
  80069a:	ec06                	sd	ra,24(sp)
  80069c:	f43e                	sd	a5,40(sp)
  80069e:	f842                	sd	a6,48(sp)
  8006a0:	fc46                	sd	a7,56(sp)
  8006a2:	e41a                	sd	t1,8(sp)
  8006a4:	c6dff0ef          	jal	ra,800310 <vprintfmt>
  8006a8:	60e2                	ld	ra,24(sp)
  8006aa:	6121                	addi	sp,sp,64
  8006ac:	8082                	ret

00000000008006ae <strnlen>:
  8006ae:	4781                	li	a5,0
  8006b0:	e589                	bnez	a1,8006ba <strnlen+0xc>
  8006b2:	a811                	j	8006c6 <strnlen+0x18>
  8006b4:	0785                	addi	a5,a5,1
  8006b6:	00f58863          	beq	a1,a5,8006c6 <strnlen+0x18>
  8006ba:	00f50733          	add	a4,a0,a5
  8006be:	00074703          	lbu	a4,0(a4)
  8006c2:	fb6d                	bnez	a4,8006b4 <strnlen+0x6>
  8006c4:	85be                	mv	a1,a5
  8006c6:	852e                	mv	a0,a1
  8006c8:	8082                	ret

00000000008006ca <memset>:
  8006ca:	ca01                	beqz	a2,8006da <memset+0x10>
  8006cc:	962a                	add	a2,a2,a0
  8006ce:	87aa                	mv	a5,a0
  8006d0:	0785                	addi	a5,a5,1
  8006d2:	feb78fa3          	sb	a1,-1(a5)
  8006d6:	fec79de3          	bne	a5,a2,8006d0 <memset+0x6>
  8006da:	8082                	ret

00000000008006dc <main>:
  8006dc:	711d                	addi	sp,sp,-96
  8006de:	4651                	li	a2,20
  8006e0:	4581                	li	a1,0
  8006e2:	81818513          	addi	a0,gp,-2024 # 801018 <pids>
  8006e6:	ec86                	sd	ra,88(sp)
  8006e8:	e8a2                	sd	s0,80(sp)
  8006ea:	e4a6                	sd	s1,72(sp)
  8006ec:	e0ca                	sd	s2,64(sp)
  8006ee:	fc4e                	sd	s3,56(sp)
  8006f0:	f852                	sd	s4,48(sp)
  8006f2:	f456                	sd	s5,40(sp)
  8006f4:	f05a                	sd	s6,32(sp)
  8006f6:	ec5e                	sd	s7,24(sp)
  8006f8:	fd3ff0ef          	jal	ra,8006ca <memset>
  8006fc:	4519                	li	a0,6
  8006fe:	00001a97          	auipc	s5,0x1
  800702:	902a8a93          	addi	s5,s5,-1790 # 801000 <acc>
  800706:	81818913          	addi	s2,gp,-2024 # 801018 <pids>
  80070a:	ad3ff0ef          	jal	ra,8001dc <lab6_set_priority>
  80070e:	89d6                	mv	s3,s5
  800710:	84ca                	mv	s1,s2
  800712:	4401                	li	s0,0
  800714:	4a15                	li	s4,5
  800716:	0009a023          	sw	zero,0(s3)
  80071a:	ab9ff0ef          	jal	ra,8001d2 <fork>
  80071e:	c088                	sw	a0,0(s1)
  800720:	c569                	beqz	a0,8007ea <main+0x10e>
  800722:	12054963          	bltz	a0,800854 <main+0x178>
  800726:	2405                	addiw	s0,s0,1
  800728:	0991                	addi	s3,s3,4
  80072a:	0491                	addi	s1,s1,4
  80072c:	ff4415e3          	bne	s0,s4,800716 <main+0x3a>
  800730:	83018493          	addi	s1,gp,-2000 # 801030 <status>
  800734:	00000517          	auipc	a0,0x0
  800738:	66450513          	addi	a0,a0,1636 # 800d98 <error_string+0xe8>
  80073c:	9c3ff0ef          	jal	ra,8000fe <cprintf>
  800740:	84418993          	addi	s3,gp,-1980 # 801044 <status+0x14>
  800744:	8a26                	mv	s4,s1
  800746:	8426                	mv	s0,s1
  800748:	00000b97          	auipc	s7,0x0
  80074c:	678b8b93          	addi	s7,s7,1656 # 800dc0 <error_string+0x110>
  800750:	00092503          	lw	a0,0(s2)
  800754:	85a2                	mv	a1,s0
  800756:	00042023          	sw	zero,0(s0)
  80075a:	a7bff0ef          	jal	ra,8001d4 <waitpid>
  80075e:	00092a83          	lw	s5,0(s2)
  800762:	00042b03          	lw	s6,0(s0)
  800766:	a75ff0ef          	jal	ra,8001da <gettime_msec>
  80076a:	0005069b          	sext.w	a3,a0
  80076e:	865a                	mv	a2,s6
  800770:	85d6                	mv	a1,s5
  800772:	855e                	mv	a0,s7
  800774:	0411                	addi	s0,s0,4
  800776:	989ff0ef          	jal	ra,8000fe <cprintf>
  80077a:	0911                	addi	s2,s2,4
  80077c:	fd341ae3          	bne	s0,s3,800750 <main+0x74>
  800780:	00000517          	auipc	a0,0x0
  800784:	66050513          	addi	a0,a0,1632 # 800de0 <error_string+0x130>
  800788:	977ff0ef          	jal	ra,8000fe <cprintf>
  80078c:	00000517          	auipc	a0,0x0
  800790:	66c50513          	addi	a0,a0,1644 # 800df8 <error_string+0x148>
  800794:	96bff0ef          	jal	ra,8000fe <cprintf>
  800798:	00000417          	auipc	s0,0x0
  80079c:	68040413          	addi	s0,s0,1664 # 800e18 <error_string+0x168>
  8007a0:	408c                	lw	a1,0(s1)
  8007a2:	000a2783          	lw	a5,0(s4)
  8007a6:	0491                	addi	s1,s1,4
  8007a8:	0015959b          	slliw	a1,a1,0x1
  8007ac:	02f5c5bb          	divw	a1,a1,a5
  8007b0:	8522                	mv	a0,s0
  8007b2:	2585                	addiw	a1,a1,1
  8007b4:	01f5d79b          	srliw	a5,a1,0x1f
  8007b8:	9dbd                	addw	a1,a1,a5
  8007ba:	4015d59b          	sraiw	a1,a1,0x1
  8007be:	941ff0ef          	jal	ra,8000fe <cprintf>
  8007c2:	fd349fe3          	bne	s1,s3,8007a0 <main+0xc4>
  8007c6:	00000517          	auipc	a0,0x0
  8007ca:	13a50513          	addi	a0,a0,314 # 800900 <main+0x224>
  8007ce:	931ff0ef          	jal	ra,8000fe <cprintf>
  8007d2:	60e6                	ld	ra,88(sp)
  8007d4:	6446                	ld	s0,80(sp)
  8007d6:	64a6                	ld	s1,72(sp)
  8007d8:	6906                	ld	s2,64(sp)
  8007da:	79e2                	ld	s3,56(sp)
  8007dc:	7a42                	ld	s4,48(sp)
  8007de:	7aa2                	ld	s5,40(sp)
  8007e0:	7b02                	ld	s6,32(sp)
  8007e2:	6be2                	ld	s7,24(sp)
  8007e4:	4501                	li	a0,0
  8007e6:	6125                	addi	sp,sp,96
  8007e8:	8082                	ret
  8007ea:	0014051b          	addiw	a0,s0,1
  8007ee:	040a                	slli	s0,s0,0x2
  8007f0:	9456                	add	s0,s0,s5
  8007f2:	6485                	lui	s1,0x1
  8007f4:	6989                	lui	s3,0x2
  8007f6:	9e7ff0ef          	jal	ra,8001dc <lab6_set_priority>
  8007fa:	fa04849b          	addiw	s1,s1,-96
  8007fe:	00042023          	sw	zero,0(s0)
  800802:	71098993          	addi	s3,s3,1808 # 2710 <open-0x7fd910>
  800806:	4014                	lw	a3,0(s0)
  800808:	2685                	addiw	a3,a3,1
  80080a:	0c800713          	li	a4,200
  80080e:	47b2                	lw	a5,12(sp)
  800810:	377d                	addiw	a4,a4,-1
  800812:	2781                	sext.w	a5,a5
  800814:	0017b793          	seqz	a5,a5
  800818:	c63e                	sw	a5,12(sp)
  80081a:	fb75                	bnez	a4,80080e <main+0x132>
  80081c:	0296f7bb          	remuw	a5,a3,s1
  800820:	0016871b          	addiw	a4,a3,1
  800824:	c399                	beqz	a5,80082a <main+0x14e>
  800826:	86ba                	mv	a3,a4
  800828:	b7cd                	j	80080a <main+0x12e>
  80082a:	c014                	sw	a3,0(s0)
  80082c:	9afff0ef          	jal	ra,8001da <gettime_msec>
  800830:	0005091b          	sext.w	s2,a0
  800834:	fd29d9e3          	bge	s3,s2,800806 <main+0x12a>
  800838:	9a1ff0ef          	jal	ra,8001d8 <getpid>
  80083c:	4010                	lw	a2,0(s0)
  80083e:	85aa                	mv	a1,a0
  800840:	86ca                	mv	a3,s2
  800842:	00000517          	auipc	a0,0x0
  800846:	53650513          	addi	a0,a0,1334 # 800d78 <error_string+0xc8>
  80084a:	8b5ff0ef          	jal	ra,8000fe <cprintf>
  80084e:	4008                	lw	a0,0(s0)
  800850:	96dff0ef          	jal	ra,8001bc <exit>
  800854:	82c18413          	addi	s0,gp,-2004 # 80102c <pids+0x14>
  800858:	00092503          	lw	a0,0(s2)
  80085c:	00a05463          	blez	a0,800864 <main+0x188>
  800860:	977ff0ef          	jal	ra,8001d6 <kill>
  800864:	0911                	addi	s2,s2,4
  800866:	ff2419e3          	bne	s0,s2,800858 <main+0x17c>
  80086a:	00000617          	auipc	a2,0x0
  80086e:	5b660613          	addi	a2,a2,1462 # 800e20 <error_string+0x170>
  800872:	04b00593          	li	a1,75
  800876:	00000517          	auipc	a0,0x0
  80087a:	5ba50513          	addi	a0,a0,1466 # 800e30 <error_string+0x180>
  80087e:	fbaff0ef          	jal	ra,800038 <__panic>
