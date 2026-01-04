
obj/__user_faultread.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	aa21                	j	80013c <sys_open>

0000000000800026 <close>:
  800026:	a205                	j	800146 <sys_close>

0000000000800028 <dup2>:
  800028:	a21d                	j	80014e <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	180000ef          	jal	ra,8001b2 <umain>
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
  80004c:	63850513          	addi	a0,a0,1592 # 800680 <main+0x2a>
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
  80006c:	67050513          	addi	a0,a0,1648 # 8006d8 <main+0x82>
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
  800084:	0b2000ef          	jal	ra,800136 <sys_putc>
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
  8000b0:	1ec000ef          	jal	ra,80029c <vprintfmt>
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
  8000ec:	1b0000ef          	jal	ra,80029c <vprintfmt>
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

0000000000800136 <sys_putc>:
  800136:	85aa                	mv	a1,a0
  800138:	4579                	li	a0,30
  80013a:	bf7d                	j	8000f8 <syscall>

000000000080013c <sys_open>:
  80013c:	862e                	mv	a2,a1
  80013e:	85aa                	mv	a1,a0
  800140:	06400513          	li	a0,100
  800144:	bf55                	j	8000f8 <syscall>

0000000000800146 <sys_close>:
  800146:	85aa                	mv	a1,a0
  800148:	06500513          	li	a0,101
  80014c:	b775                	j	8000f8 <syscall>

000000000080014e <sys_dup>:
  80014e:	862e                	mv	a2,a1
  800150:	85aa                	mv	a1,a0
  800152:	08200513          	li	a0,130
  800156:	b74d                	j	8000f8 <syscall>

0000000000800158 <exit>:
  800158:	1141                	addi	sp,sp,-16
  80015a:	e406                	sd	ra,8(sp)
  80015c:	fd5ff0ef          	jal	ra,800130 <sys_exit>
  800160:	00000517          	auipc	a0,0x0
  800164:	54050513          	addi	a0,a0,1344 # 8006a0 <main+0x4a>
  800168:	f55ff0ef          	jal	ra,8000bc <cprintf>
  80016c:	a001                	j	80016c <exit+0x14>

000000000080016e <initfd>:
  80016e:	1101                	addi	sp,sp,-32
  800170:	87ae                	mv	a5,a1
  800172:	e426                	sd	s1,8(sp)
  800174:	85b2                	mv	a1,a2
  800176:	84aa                	mv	s1,a0
  800178:	853e                	mv	a0,a5
  80017a:	e822                	sd	s0,16(sp)
  80017c:	ec06                	sd	ra,24(sp)
  80017e:	ea3ff0ef          	jal	ra,800020 <open>
  800182:	842a                	mv	s0,a0
  800184:	00054463          	bltz	a0,80018c <initfd+0x1e>
  800188:	00951863          	bne	a0,s1,800198 <initfd+0x2a>
  80018c:	60e2                	ld	ra,24(sp)
  80018e:	8522                	mv	a0,s0
  800190:	6442                	ld	s0,16(sp)
  800192:	64a2                	ld	s1,8(sp)
  800194:	6105                	addi	sp,sp,32
  800196:	8082                	ret
  800198:	8526                	mv	a0,s1
  80019a:	e8dff0ef          	jal	ra,800026 <close>
  80019e:	85a6                	mv	a1,s1
  8001a0:	8522                	mv	a0,s0
  8001a2:	e87ff0ef          	jal	ra,800028 <dup2>
  8001a6:	84aa                	mv	s1,a0
  8001a8:	8522                	mv	a0,s0
  8001aa:	e7dff0ef          	jal	ra,800026 <close>
  8001ae:	8426                	mv	s0,s1
  8001b0:	bff1                	j	80018c <initfd+0x1e>

00000000008001b2 <umain>:
  8001b2:	1101                	addi	sp,sp,-32
  8001b4:	e822                	sd	s0,16(sp)
  8001b6:	e426                	sd	s1,8(sp)
  8001b8:	842a                	mv	s0,a0
  8001ba:	84ae                	mv	s1,a1
  8001bc:	4601                	li	a2,0
  8001be:	00000597          	auipc	a1,0x0
  8001c2:	4fa58593          	addi	a1,a1,1274 # 8006b8 <main+0x62>
  8001c6:	4501                	li	a0,0
  8001c8:	ec06                	sd	ra,24(sp)
  8001ca:	fa5ff0ef          	jal	ra,80016e <initfd>
  8001ce:	02054263          	bltz	a0,8001f2 <umain+0x40>
  8001d2:	4605                	li	a2,1
  8001d4:	00000597          	auipc	a1,0x0
  8001d8:	52458593          	addi	a1,a1,1316 # 8006f8 <main+0xa2>
  8001dc:	4505                	li	a0,1
  8001de:	f91ff0ef          	jal	ra,80016e <initfd>
  8001e2:	02054563          	bltz	a0,80020c <umain+0x5a>
  8001e6:	85a6                	mv	a1,s1
  8001e8:	8522                	mv	a0,s0
  8001ea:	46c000ef          	jal	ra,800656 <main>
  8001ee:	f6bff0ef          	jal	ra,800158 <exit>
  8001f2:	86aa                	mv	a3,a0
  8001f4:	00000617          	auipc	a2,0x0
  8001f8:	4cc60613          	addi	a2,a2,1228 # 8006c0 <main+0x6a>
  8001fc:	45e9                	li	a1,26
  8001fe:	00000517          	auipc	a0,0x0
  800202:	4e250513          	addi	a0,a0,1250 # 8006e0 <main+0x8a>
  800206:	e33ff0ef          	jal	ra,800038 <__warn>
  80020a:	b7e1                	j	8001d2 <umain+0x20>
  80020c:	86aa                	mv	a3,a0
  80020e:	00000617          	auipc	a2,0x0
  800212:	4f260613          	addi	a2,a2,1266 # 800700 <main+0xaa>
  800216:	45f5                	li	a1,29
  800218:	00000517          	auipc	a0,0x0
  80021c:	4c850513          	addi	a0,a0,1224 # 8006e0 <main+0x8a>
  800220:	e19ff0ef          	jal	ra,800038 <__warn>
  800224:	b7c9                	j	8001e6 <umain+0x34>

0000000000800226 <printnum>:
  800226:	02071893          	slli	a7,a4,0x20
  80022a:	7139                	addi	sp,sp,-64
  80022c:	0208d893          	srli	a7,a7,0x20
  800230:	e456                	sd	s5,8(sp)
  800232:	0316fab3          	remu	s5,a3,a7
  800236:	f822                	sd	s0,48(sp)
  800238:	f426                	sd	s1,40(sp)
  80023a:	f04a                	sd	s2,32(sp)
  80023c:	ec4e                	sd	s3,24(sp)
  80023e:	fc06                	sd	ra,56(sp)
  800240:	e852                	sd	s4,16(sp)
  800242:	84aa                	mv	s1,a0
  800244:	89ae                	mv	s3,a1
  800246:	8932                	mv	s2,a2
  800248:	fff7841b          	addiw	s0,a5,-1
  80024c:	2a81                	sext.w	s5,s5
  80024e:	0516f163          	bgeu	a3,a7,800290 <printnum+0x6a>
  800252:	8a42                	mv	s4,a6
  800254:	00805863          	blez	s0,800264 <printnum+0x3e>
  800258:	347d                	addiw	s0,s0,-1
  80025a:	864e                	mv	a2,s3
  80025c:	85ca                	mv	a1,s2
  80025e:	8552                	mv	a0,s4
  800260:	9482                	jalr	s1
  800262:	f87d                	bnez	s0,800258 <printnum+0x32>
  800264:	1a82                	slli	s5,s5,0x20
  800266:	00000797          	auipc	a5,0x0
  80026a:	4ba78793          	addi	a5,a5,1210 # 800720 <main+0xca>
  80026e:	020ada93          	srli	s5,s5,0x20
  800272:	9abe                	add	s5,s5,a5
  800274:	7442                	ld	s0,48(sp)
  800276:	000ac503          	lbu	a0,0(s5)
  80027a:	70e2                	ld	ra,56(sp)
  80027c:	6a42                	ld	s4,16(sp)
  80027e:	6aa2                	ld	s5,8(sp)
  800280:	864e                	mv	a2,s3
  800282:	85ca                	mv	a1,s2
  800284:	69e2                	ld	s3,24(sp)
  800286:	7902                	ld	s2,32(sp)
  800288:	87a6                	mv	a5,s1
  80028a:	74a2                	ld	s1,40(sp)
  80028c:	6121                	addi	sp,sp,64
  80028e:	8782                	jr	a5
  800290:	0316d6b3          	divu	a3,a3,a7
  800294:	87a2                	mv	a5,s0
  800296:	f91ff0ef          	jal	ra,800226 <printnum>
  80029a:	b7e9                	j	800264 <printnum+0x3e>

000000000080029c <vprintfmt>:
  80029c:	7119                	addi	sp,sp,-128
  80029e:	f4a6                	sd	s1,104(sp)
  8002a0:	f0ca                	sd	s2,96(sp)
  8002a2:	ecce                	sd	s3,88(sp)
  8002a4:	e8d2                	sd	s4,80(sp)
  8002a6:	e4d6                	sd	s5,72(sp)
  8002a8:	e0da                	sd	s6,64(sp)
  8002aa:	fc5e                	sd	s7,56(sp)
  8002ac:	ec6e                	sd	s11,24(sp)
  8002ae:	fc86                	sd	ra,120(sp)
  8002b0:	f8a2                	sd	s0,112(sp)
  8002b2:	f862                	sd	s8,48(sp)
  8002b4:	f466                	sd	s9,40(sp)
  8002b6:	f06a                	sd	s10,32(sp)
  8002b8:	89aa                	mv	s3,a0
  8002ba:	892e                	mv	s2,a1
  8002bc:	84b2                	mv	s1,a2
  8002be:	8db6                	mv	s11,a3
  8002c0:	8aba                	mv	s5,a4
  8002c2:	02500a13          	li	s4,37
  8002c6:	5bfd                	li	s7,-1
  8002c8:	00000b17          	auipc	s6,0x0
  8002cc:	48cb0b13          	addi	s6,s6,1164 # 800754 <main+0xfe>
  8002d0:	000dc503          	lbu	a0,0(s11)
  8002d4:	001d8413          	addi	s0,s11,1
  8002d8:	01450b63          	beq	a0,s4,8002ee <vprintfmt+0x52>
  8002dc:	c129                	beqz	a0,80031e <vprintfmt+0x82>
  8002de:	864a                	mv	a2,s2
  8002e0:	85a6                	mv	a1,s1
  8002e2:	0405                	addi	s0,s0,1
  8002e4:	9982                	jalr	s3
  8002e6:	fff44503          	lbu	a0,-1(s0)
  8002ea:	ff4519e3          	bne	a0,s4,8002dc <vprintfmt+0x40>
  8002ee:	00044583          	lbu	a1,0(s0)
  8002f2:	02000813          	li	a6,32
  8002f6:	4d01                	li	s10,0
  8002f8:	4301                	li	t1,0
  8002fa:	5cfd                	li	s9,-1
  8002fc:	5c7d                	li	s8,-1
  8002fe:	05500513          	li	a0,85
  800302:	48a5                	li	a7,9
  800304:	fdd5861b          	addiw	a2,a1,-35
  800308:	0ff67613          	zext.b	a2,a2
  80030c:	00140d93          	addi	s11,s0,1
  800310:	04c56263          	bltu	a0,a2,800354 <vprintfmt+0xb8>
  800314:	060a                	slli	a2,a2,0x2
  800316:	965a                	add	a2,a2,s6
  800318:	4214                	lw	a3,0(a2)
  80031a:	96da                	add	a3,a3,s6
  80031c:	8682                	jr	a3
  80031e:	70e6                	ld	ra,120(sp)
  800320:	7446                	ld	s0,112(sp)
  800322:	74a6                	ld	s1,104(sp)
  800324:	7906                	ld	s2,96(sp)
  800326:	69e6                	ld	s3,88(sp)
  800328:	6a46                	ld	s4,80(sp)
  80032a:	6aa6                	ld	s5,72(sp)
  80032c:	6b06                	ld	s6,64(sp)
  80032e:	7be2                	ld	s7,56(sp)
  800330:	7c42                	ld	s8,48(sp)
  800332:	7ca2                	ld	s9,40(sp)
  800334:	7d02                	ld	s10,32(sp)
  800336:	6de2                	ld	s11,24(sp)
  800338:	6109                	addi	sp,sp,128
  80033a:	8082                	ret
  80033c:	882e                	mv	a6,a1
  80033e:	00144583          	lbu	a1,1(s0)
  800342:	846e                	mv	s0,s11
  800344:	00140d93          	addi	s11,s0,1
  800348:	fdd5861b          	addiw	a2,a1,-35
  80034c:	0ff67613          	zext.b	a2,a2
  800350:	fcc572e3          	bgeu	a0,a2,800314 <vprintfmt+0x78>
  800354:	864a                	mv	a2,s2
  800356:	85a6                	mv	a1,s1
  800358:	02500513          	li	a0,37
  80035c:	9982                	jalr	s3
  80035e:	fff44783          	lbu	a5,-1(s0)
  800362:	8da2                	mv	s11,s0
  800364:	f74786e3          	beq	a5,s4,8002d0 <vprintfmt+0x34>
  800368:	ffedc783          	lbu	a5,-2(s11)
  80036c:	1dfd                	addi	s11,s11,-1
  80036e:	ff479de3          	bne	a5,s4,800368 <vprintfmt+0xcc>
  800372:	bfb9                	j	8002d0 <vprintfmt+0x34>
  800374:	fd058c9b          	addiw	s9,a1,-48
  800378:	00144583          	lbu	a1,1(s0)
  80037c:	846e                	mv	s0,s11
  80037e:	fd05869b          	addiw	a3,a1,-48
  800382:	0005861b          	sext.w	a2,a1
  800386:	02d8e463          	bltu	a7,a3,8003ae <vprintfmt+0x112>
  80038a:	00144583          	lbu	a1,1(s0)
  80038e:	002c969b          	slliw	a3,s9,0x2
  800392:	0196873b          	addw	a4,a3,s9
  800396:	0017171b          	slliw	a4,a4,0x1
  80039a:	9f31                	addw	a4,a4,a2
  80039c:	fd05869b          	addiw	a3,a1,-48
  8003a0:	0405                	addi	s0,s0,1
  8003a2:	fd070c9b          	addiw	s9,a4,-48
  8003a6:	0005861b          	sext.w	a2,a1
  8003aa:	fed8f0e3          	bgeu	a7,a3,80038a <vprintfmt+0xee>
  8003ae:	f40c5be3          	bgez	s8,800304 <vprintfmt+0x68>
  8003b2:	8c66                	mv	s8,s9
  8003b4:	5cfd                	li	s9,-1
  8003b6:	b7b9                	j	800304 <vprintfmt+0x68>
  8003b8:	fffc4693          	not	a3,s8
  8003bc:	96fd                	srai	a3,a3,0x3f
  8003be:	00dc77b3          	and	a5,s8,a3
  8003c2:	00144583          	lbu	a1,1(s0)
  8003c6:	00078c1b          	sext.w	s8,a5
  8003ca:	846e                	mv	s0,s11
  8003cc:	bf25                	j	800304 <vprintfmt+0x68>
  8003ce:	000aac83          	lw	s9,0(s5)
  8003d2:	00144583          	lbu	a1,1(s0)
  8003d6:	0aa1                	addi	s5,s5,8
  8003d8:	846e                	mv	s0,s11
  8003da:	bfd1                	j	8003ae <vprintfmt+0x112>
  8003dc:	4705                	li	a4,1
  8003de:	008a8613          	addi	a2,s5,8
  8003e2:	00674463          	blt	a4,t1,8003ea <vprintfmt+0x14e>
  8003e6:	1c030c63          	beqz	t1,8005be <vprintfmt+0x322>
  8003ea:	000ab683          	ld	a3,0(s5)
  8003ee:	4741                	li	a4,16
  8003f0:	8ab2                	mv	s5,a2
  8003f2:	2801                	sext.w	a6,a6
  8003f4:	87e2                	mv	a5,s8
  8003f6:	8626                	mv	a2,s1
  8003f8:	85ca                	mv	a1,s2
  8003fa:	854e                	mv	a0,s3
  8003fc:	e2bff0ef          	jal	ra,800226 <printnum>
  800400:	bdc1                	j	8002d0 <vprintfmt+0x34>
  800402:	000aa503          	lw	a0,0(s5)
  800406:	864a                	mv	a2,s2
  800408:	85a6                	mv	a1,s1
  80040a:	0aa1                	addi	s5,s5,8
  80040c:	9982                	jalr	s3
  80040e:	b5c9                	j	8002d0 <vprintfmt+0x34>
  800410:	4705                	li	a4,1
  800412:	008a8613          	addi	a2,s5,8
  800416:	00674463          	blt	a4,t1,80041e <vprintfmt+0x182>
  80041a:	18030d63          	beqz	t1,8005b4 <vprintfmt+0x318>
  80041e:	000ab683          	ld	a3,0(s5)
  800422:	4729                	li	a4,10
  800424:	8ab2                	mv	s5,a2
  800426:	b7f1                	j	8003f2 <vprintfmt+0x156>
  800428:	00144583          	lbu	a1,1(s0)
  80042c:	4d05                	li	s10,1
  80042e:	846e                	mv	s0,s11
  800430:	bdd1                	j	800304 <vprintfmt+0x68>
  800432:	864a                	mv	a2,s2
  800434:	85a6                	mv	a1,s1
  800436:	02500513          	li	a0,37
  80043a:	9982                	jalr	s3
  80043c:	bd51                	j	8002d0 <vprintfmt+0x34>
  80043e:	00144583          	lbu	a1,1(s0)
  800442:	2305                	addiw	t1,t1,1
  800444:	846e                	mv	s0,s11
  800446:	bd7d                	j	800304 <vprintfmt+0x68>
  800448:	4705                	li	a4,1
  80044a:	008a8613          	addi	a2,s5,8
  80044e:	00674463          	blt	a4,t1,800456 <vprintfmt+0x1ba>
  800452:	14030c63          	beqz	t1,8005aa <vprintfmt+0x30e>
  800456:	000ab683          	ld	a3,0(s5)
  80045a:	4721                	li	a4,8
  80045c:	8ab2                	mv	s5,a2
  80045e:	bf51                	j	8003f2 <vprintfmt+0x156>
  800460:	03000513          	li	a0,48
  800464:	864a                	mv	a2,s2
  800466:	85a6                	mv	a1,s1
  800468:	e042                	sd	a6,0(sp)
  80046a:	9982                	jalr	s3
  80046c:	864a                	mv	a2,s2
  80046e:	85a6                	mv	a1,s1
  800470:	07800513          	li	a0,120
  800474:	9982                	jalr	s3
  800476:	0aa1                	addi	s5,s5,8
  800478:	6802                	ld	a6,0(sp)
  80047a:	4741                	li	a4,16
  80047c:	ff8ab683          	ld	a3,-8(s5)
  800480:	bf8d                	j	8003f2 <vprintfmt+0x156>
  800482:	000ab403          	ld	s0,0(s5)
  800486:	008a8793          	addi	a5,s5,8
  80048a:	e03e                	sd	a5,0(sp)
  80048c:	14040c63          	beqz	s0,8005e4 <vprintfmt+0x348>
  800490:	11805063          	blez	s8,800590 <vprintfmt+0x2f4>
  800494:	02d00693          	li	a3,45
  800498:	0cd81963          	bne	a6,a3,80056a <vprintfmt+0x2ce>
  80049c:	00044683          	lbu	a3,0(s0)
  8004a0:	0006851b          	sext.w	a0,a3
  8004a4:	ce8d                	beqz	a3,8004de <vprintfmt+0x242>
  8004a6:	00140a93          	addi	s5,s0,1
  8004aa:	05e00413          	li	s0,94
  8004ae:	000cc563          	bltz	s9,8004b8 <vprintfmt+0x21c>
  8004b2:	3cfd                	addiw	s9,s9,-1
  8004b4:	037c8363          	beq	s9,s7,8004da <vprintfmt+0x23e>
  8004b8:	864a                	mv	a2,s2
  8004ba:	85a6                	mv	a1,s1
  8004bc:	100d0663          	beqz	s10,8005c8 <vprintfmt+0x32c>
  8004c0:	3681                	addiw	a3,a3,-32
  8004c2:	10d47363          	bgeu	s0,a3,8005c8 <vprintfmt+0x32c>
  8004c6:	03f00513          	li	a0,63
  8004ca:	9982                	jalr	s3
  8004cc:	000ac683          	lbu	a3,0(s5)
  8004d0:	3c7d                	addiw	s8,s8,-1
  8004d2:	0a85                	addi	s5,s5,1
  8004d4:	0006851b          	sext.w	a0,a3
  8004d8:	faf9                	bnez	a3,8004ae <vprintfmt+0x212>
  8004da:	01805a63          	blez	s8,8004ee <vprintfmt+0x252>
  8004de:	3c7d                	addiw	s8,s8,-1
  8004e0:	864a                	mv	a2,s2
  8004e2:	85a6                	mv	a1,s1
  8004e4:	02000513          	li	a0,32
  8004e8:	9982                	jalr	s3
  8004ea:	fe0c1ae3          	bnez	s8,8004de <vprintfmt+0x242>
  8004ee:	6a82                	ld	s5,0(sp)
  8004f0:	b3c5                	j	8002d0 <vprintfmt+0x34>
  8004f2:	4705                	li	a4,1
  8004f4:	008a8d13          	addi	s10,s5,8
  8004f8:	00674463          	blt	a4,t1,800500 <vprintfmt+0x264>
  8004fc:	0a030463          	beqz	t1,8005a4 <vprintfmt+0x308>
  800500:	000ab403          	ld	s0,0(s5)
  800504:	0c044463          	bltz	s0,8005cc <vprintfmt+0x330>
  800508:	86a2                	mv	a3,s0
  80050a:	8aea                	mv	s5,s10
  80050c:	4729                	li	a4,10
  80050e:	b5d5                	j	8003f2 <vprintfmt+0x156>
  800510:	000aa783          	lw	a5,0(s5)
  800514:	46e1                	li	a3,24
  800516:	0aa1                	addi	s5,s5,8
  800518:	41f7d71b          	sraiw	a4,a5,0x1f
  80051c:	8fb9                	xor	a5,a5,a4
  80051e:	40e7873b          	subw	a4,a5,a4
  800522:	02e6c663          	blt	a3,a4,80054e <vprintfmt+0x2b2>
  800526:	00371793          	slli	a5,a4,0x3
  80052a:	00000697          	auipc	a3,0x0
  80052e:	55e68693          	addi	a3,a3,1374 # 800a88 <error_string>
  800532:	97b6                	add	a5,a5,a3
  800534:	639c                	ld	a5,0(a5)
  800536:	cf81                	beqz	a5,80054e <vprintfmt+0x2b2>
  800538:	873e                	mv	a4,a5
  80053a:	00000697          	auipc	a3,0x0
  80053e:	21668693          	addi	a3,a3,534 # 800750 <main+0xfa>
  800542:	8626                	mv	a2,s1
  800544:	85ca                	mv	a1,s2
  800546:	854e                	mv	a0,s3
  800548:	0d4000ef          	jal	ra,80061c <printfmt>
  80054c:	b351                	j	8002d0 <vprintfmt+0x34>
  80054e:	00000697          	auipc	a3,0x0
  800552:	1f268693          	addi	a3,a3,498 # 800740 <main+0xea>
  800556:	8626                	mv	a2,s1
  800558:	85ca                	mv	a1,s2
  80055a:	854e                	mv	a0,s3
  80055c:	0c0000ef          	jal	ra,80061c <printfmt>
  800560:	bb85                	j	8002d0 <vprintfmt+0x34>
  800562:	00000417          	auipc	s0,0x0
  800566:	1d640413          	addi	s0,s0,470 # 800738 <main+0xe2>
  80056a:	85e6                	mv	a1,s9
  80056c:	8522                	mv	a0,s0
  80056e:	e442                	sd	a6,8(sp)
  800570:	0ca000ef          	jal	ra,80063a <strnlen>
  800574:	40ac0c3b          	subw	s8,s8,a0
  800578:	01805c63          	blez	s8,800590 <vprintfmt+0x2f4>
  80057c:	6822                	ld	a6,8(sp)
  80057e:	00080a9b          	sext.w	s5,a6
  800582:	3c7d                	addiw	s8,s8,-1
  800584:	864a                	mv	a2,s2
  800586:	85a6                	mv	a1,s1
  800588:	8556                	mv	a0,s5
  80058a:	9982                	jalr	s3
  80058c:	fe0c1be3          	bnez	s8,800582 <vprintfmt+0x2e6>
  800590:	00044683          	lbu	a3,0(s0)
  800594:	00140a93          	addi	s5,s0,1
  800598:	0006851b          	sext.w	a0,a3
  80059c:	daa9                	beqz	a3,8004ee <vprintfmt+0x252>
  80059e:	05e00413          	li	s0,94
  8005a2:	b731                	j	8004ae <vprintfmt+0x212>
  8005a4:	000aa403          	lw	s0,0(s5)
  8005a8:	bfb1                	j	800504 <vprintfmt+0x268>
  8005aa:	000ae683          	lwu	a3,0(s5)
  8005ae:	4721                	li	a4,8
  8005b0:	8ab2                	mv	s5,a2
  8005b2:	b581                	j	8003f2 <vprintfmt+0x156>
  8005b4:	000ae683          	lwu	a3,0(s5)
  8005b8:	4729                	li	a4,10
  8005ba:	8ab2                	mv	s5,a2
  8005bc:	bd1d                	j	8003f2 <vprintfmt+0x156>
  8005be:	000ae683          	lwu	a3,0(s5)
  8005c2:	4741                	li	a4,16
  8005c4:	8ab2                	mv	s5,a2
  8005c6:	b535                	j	8003f2 <vprintfmt+0x156>
  8005c8:	9982                	jalr	s3
  8005ca:	b709                	j	8004cc <vprintfmt+0x230>
  8005cc:	864a                	mv	a2,s2
  8005ce:	85a6                	mv	a1,s1
  8005d0:	02d00513          	li	a0,45
  8005d4:	e042                	sd	a6,0(sp)
  8005d6:	9982                	jalr	s3
  8005d8:	6802                	ld	a6,0(sp)
  8005da:	8aea                	mv	s5,s10
  8005dc:	408006b3          	neg	a3,s0
  8005e0:	4729                	li	a4,10
  8005e2:	bd01                	j	8003f2 <vprintfmt+0x156>
  8005e4:	03805163          	blez	s8,800606 <vprintfmt+0x36a>
  8005e8:	02d00693          	li	a3,45
  8005ec:	f6d81be3          	bne	a6,a3,800562 <vprintfmt+0x2c6>
  8005f0:	00000417          	auipc	s0,0x0
  8005f4:	14840413          	addi	s0,s0,328 # 800738 <main+0xe2>
  8005f8:	02800693          	li	a3,40
  8005fc:	02800513          	li	a0,40
  800600:	00140a93          	addi	s5,s0,1
  800604:	b55d                	j	8004aa <vprintfmt+0x20e>
  800606:	00000a97          	auipc	s5,0x0
  80060a:	133a8a93          	addi	s5,s5,307 # 800739 <main+0xe3>
  80060e:	02800513          	li	a0,40
  800612:	02800693          	li	a3,40
  800616:	05e00413          	li	s0,94
  80061a:	bd51                	j	8004ae <vprintfmt+0x212>

000000000080061c <printfmt>:
  80061c:	7139                	addi	sp,sp,-64
  80061e:	02010313          	addi	t1,sp,32
  800622:	f03a                	sd	a4,32(sp)
  800624:	871a                	mv	a4,t1
  800626:	ec06                	sd	ra,24(sp)
  800628:	f43e                	sd	a5,40(sp)
  80062a:	f842                	sd	a6,48(sp)
  80062c:	fc46                	sd	a7,56(sp)
  80062e:	e41a                	sd	t1,8(sp)
  800630:	c6dff0ef          	jal	ra,80029c <vprintfmt>
  800634:	60e2                	ld	ra,24(sp)
  800636:	6121                	addi	sp,sp,64
  800638:	8082                	ret

000000000080063a <strnlen>:
  80063a:	4781                	li	a5,0
  80063c:	e589                	bnez	a1,800646 <strnlen+0xc>
  80063e:	a811                	j	800652 <strnlen+0x18>
  800640:	0785                	addi	a5,a5,1
  800642:	00f58863          	beq	a1,a5,800652 <strnlen+0x18>
  800646:	00f50733          	add	a4,a0,a5
  80064a:	00074703          	lbu	a4,0(a4)
  80064e:	fb6d                	bnez	a4,800640 <strnlen+0x6>
  800650:	85be                	mv	a1,a5
  800652:	852e                	mv	a0,a1
  800654:	8082                	ret

0000000000800656 <main>:
  800656:	00002783          	lw	a5,0(zero) # 0 <open-0x800020>
  80065a:	9002                	ebreak
