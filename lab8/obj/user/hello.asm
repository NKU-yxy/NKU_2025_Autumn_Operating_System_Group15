
obj/__user_hello.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	aa31                	j	800140 <sys_open>

0000000000800026 <close>:
  800026:	a215                	j	80014a <sys_close>

0000000000800028 <dup2>:
  800028:	a22d                	j	800152 <sys_dup>

000000000080002a <_start>:
  80002a:	00001197          	auipc	gp,0x1
  80002e:	7d618193          	addi	gp,gp,2006 # 801800 <__global_pointer$>
  800032:	186000ef          	jal	ra,8001b8 <umain>
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
  80004c:	67050513          	addi	a0,a0,1648 # 8006b8 <main+0x5c>
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
  800068:	00001517          	auipc	a0,0x1
  80006c:	b4050513          	addi	a0,a0,-1216 # 800ba8 <error_string+0xe8>
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
  800084:	0b6000ef          	jal	ra,80013a <sys_putc>
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
  8000b0:	1f2000ef          	jal	ra,8002a2 <vprintfmt>
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
  8000ec:	1b6000ef          	jal	ra,8002a2 <vprintfmt>
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

0000000000800136 <sys_getpid>:
  800136:	4549                	li	a0,18
  800138:	b7c1                	j	8000f8 <syscall>

000000000080013a <sys_putc>:
  80013a:	85aa                	mv	a1,a0
  80013c:	4579                	li	a0,30
  80013e:	bf6d                	j	8000f8 <syscall>

0000000000800140 <sys_open>:
  800140:	862e                	mv	a2,a1
  800142:	85aa                	mv	a1,a0
  800144:	06400513          	li	a0,100
  800148:	bf45                	j	8000f8 <syscall>

000000000080014a <sys_close>:
  80014a:	85aa                	mv	a1,a0
  80014c:	06500513          	li	a0,101
  800150:	b765                	j	8000f8 <syscall>

0000000000800152 <sys_dup>:
  800152:	862e                	mv	a2,a1
  800154:	85aa                	mv	a1,a0
  800156:	08200513          	li	a0,130
  80015a:	bf79                	j	8000f8 <syscall>

000000000080015c <exit>:
  80015c:	1141                	addi	sp,sp,-16
  80015e:	e406                	sd	ra,8(sp)
  800160:	fd1ff0ef          	jal	ra,800130 <sys_exit>
  800164:	00000517          	auipc	a0,0x0
  800168:	57450513          	addi	a0,a0,1396 # 8006d8 <main+0x7c>
  80016c:	f51ff0ef          	jal	ra,8000bc <cprintf>
  800170:	a001                	j	800170 <exit+0x14>

0000000000800172 <getpid>:
  800172:	b7d1                	j	800136 <sys_getpid>

0000000000800174 <initfd>:
  800174:	1101                	addi	sp,sp,-32
  800176:	87ae                	mv	a5,a1
  800178:	e426                	sd	s1,8(sp)
  80017a:	85b2                	mv	a1,a2
  80017c:	84aa                	mv	s1,a0
  80017e:	853e                	mv	a0,a5
  800180:	e822                	sd	s0,16(sp)
  800182:	ec06                	sd	ra,24(sp)
  800184:	e9dff0ef          	jal	ra,800020 <open>
  800188:	842a                	mv	s0,a0
  80018a:	00054463          	bltz	a0,800192 <initfd+0x1e>
  80018e:	00951863          	bne	a0,s1,80019e <initfd+0x2a>
  800192:	60e2                	ld	ra,24(sp)
  800194:	8522                	mv	a0,s0
  800196:	6442                	ld	s0,16(sp)
  800198:	64a2                	ld	s1,8(sp)
  80019a:	6105                	addi	sp,sp,32
  80019c:	8082                	ret
  80019e:	8526                	mv	a0,s1
  8001a0:	e87ff0ef          	jal	ra,800026 <close>
  8001a4:	85a6                	mv	a1,s1
  8001a6:	8522                	mv	a0,s0
  8001a8:	e81ff0ef          	jal	ra,800028 <dup2>
  8001ac:	84aa                	mv	s1,a0
  8001ae:	8522                	mv	a0,s0
  8001b0:	e77ff0ef          	jal	ra,800026 <close>
  8001b4:	8426                	mv	s0,s1
  8001b6:	bff1                	j	800192 <initfd+0x1e>

00000000008001b8 <umain>:
  8001b8:	1101                	addi	sp,sp,-32
  8001ba:	e822                	sd	s0,16(sp)
  8001bc:	e426                	sd	s1,8(sp)
  8001be:	842a                	mv	s0,a0
  8001c0:	84ae                	mv	s1,a1
  8001c2:	4601                	li	a2,0
  8001c4:	00000597          	auipc	a1,0x0
  8001c8:	52c58593          	addi	a1,a1,1324 # 8006f0 <main+0x94>
  8001cc:	4501                	li	a0,0
  8001ce:	ec06                	sd	ra,24(sp)
  8001d0:	fa5ff0ef          	jal	ra,800174 <initfd>
  8001d4:	02054263          	bltz	a0,8001f8 <umain+0x40>
  8001d8:	4605                	li	a2,1
  8001da:	00000597          	auipc	a1,0x0
  8001de:	55658593          	addi	a1,a1,1366 # 800730 <main+0xd4>
  8001e2:	4505                	li	a0,1
  8001e4:	f91ff0ef          	jal	ra,800174 <initfd>
  8001e8:	02054563          	bltz	a0,800212 <umain+0x5a>
  8001ec:	85a6                	mv	a1,s1
  8001ee:	8522                	mv	a0,s0
  8001f0:	46c000ef          	jal	ra,80065c <main>
  8001f4:	f69ff0ef          	jal	ra,80015c <exit>
  8001f8:	86aa                	mv	a3,a0
  8001fa:	00000617          	auipc	a2,0x0
  8001fe:	4fe60613          	addi	a2,a2,1278 # 8006f8 <main+0x9c>
  800202:	45e9                	li	a1,26
  800204:	00000517          	auipc	a0,0x0
  800208:	51450513          	addi	a0,a0,1300 # 800718 <main+0xbc>
  80020c:	e2dff0ef          	jal	ra,800038 <__warn>
  800210:	b7e1                	j	8001d8 <umain+0x20>
  800212:	86aa                	mv	a3,a0
  800214:	00000617          	auipc	a2,0x0
  800218:	52460613          	addi	a2,a2,1316 # 800738 <main+0xdc>
  80021c:	45f5                	li	a1,29
  80021e:	00000517          	auipc	a0,0x0
  800222:	4fa50513          	addi	a0,a0,1274 # 800718 <main+0xbc>
  800226:	e13ff0ef          	jal	ra,800038 <__warn>
  80022a:	b7c9                	j	8001ec <umain+0x34>

000000000080022c <printnum>:
  80022c:	02071893          	slli	a7,a4,0x20
  800230:	7139                	addi	sp,sp,-64
  800232:	0208d893          	srli	a7,a7,0x20
  800236:	e456                	sd	s5,8(sp)
  800238:	0316fab3          	remu	s5,a3,a7
  80023c:	f822                	sd	s0,48(sp)
  80023e:	f426                	sd	s1,40(sp)
  800240:	f04a                	sd	s2,32(sp)
  800242:	ec4e                	sd	s3,24(sp)
  800244:	fc06                	sd	ra,56(sp)
  800246:	e852                	sd	s4,16(sp)
  800248:	84aa                	mv	s1,a0
  80024a:	89ae                	mv	s3,a1
  80024c:	8932                	mv	s2,a2
  80024e:	fff7841b          	addiw	s0,a5,-1
  800252:	2a81                	sext.w	s5,s5
  800254:	0516f163          	bgeu	a3,a7,800296 <printnum+0x6a>
  800258:	8a42                	mv	s4,a6
  80025a:	00805863          	blez	s0,80026a <printnum+0x3e>
  80025e:	347d                	addiw	s0,s0,-1
  800260:	864e                	mv	a2,s3
  800262:	85ca                	mv	a1,s2
  800264:	8552                	mv	a0,s4
  800266:	9482                	jalr	s1
  800268:	f87d                	bnez	s0,80025e <printnum+0x32>
  80026a:	1a82                	slli	s5,s5,0x20
  80026c:	00000797          	auipc	a5,0x0
  800270:	4ec78793          	addi	a5,a5,1260 # 800758 <main+0xfc>
  800274:	020ada93          	srli	s5,s5,0x20
  800278:	9abe                	add	s5,s5,a5
  80027a:	7442                	ld	s0,48(sp)
  80027c:	000ac503          	lbu	a0,0(s5)
  800280:	70e2                	ld	ra,56(sp)
  800282:	6a42                	ld	s4,16(sp)
  800284:	6aa2                	ld	s5,8(sp)
  800286:	864e                	mv	a2,s3
  800288:	85ca                	mv	a1,s2
  80028a:	69e2                	ld	s3,24(sp)
  80028c:	7902                	ld	s2,32(sp)
  80028e:	87a6                	mv	a5,s1
  800290:	74a2                	ld	s1,40(sp)
  800292:	6121                	addi	sp,sp,64
  800294:	8782                	jr	a5
  800296:	0316d6b3          	divu	a3,a3,a7
  80029a:	87a2                	mv	a5,s0
  80029c:	f91ff0ef          	jal	ra,80022c <printnum>
  8002a0:	b7e9                	j	80026a <printnum+0x3e>

00000000008002a2 <vprintfmt>:
  8002a2:	7119                	addi	sp,sp,-128
  8002a4:	f4a6                	sd	s1,104(sp)
  8002a6:	f0ca                	sd	s2,96(sp)
  8002a8:	ecce                	sd	s3,88(sp)
  8002aa:	e8d2                	sd	s4,80(sp)
  8002ac:	e4d6                	sd	s5,72(sp)
  8002ae:	e0da                	sd	s6,64(sp)
  8002b0:	fc5e                	sd	s7,56(sp)
  8002b2:	ec6e                	sd	s11,24(sp)
  8002b4:	fc86                	sd	ra,120(sp)
  8002b6:	f8a2                	sd	s0,112(sp)
  8002b8:	f862                	sd	s8,48(sp)
  8002ba:	f466                	sd	s9,40(sp)
  8002bc:	f06a                	sd	s10,32(sp)
  8002be:	89aa                	mv	s3,a0
  8002c0:	892e                	mv	s2,a1
  8002c2:	84b2                	mv	s1,a2
  8002c4:	8db6                	mv	s11,a3
  8002c6:	8aba                	mv	s5,a4
  8002c8:	02500a13          	li	s4,37
  8002cc:	5bfd                	li	s7,-1
  8002ce:	00000b17          	auipc	s6,0x0
  8002d2:	4beb0b13          	addi	s6,s6,1214 # 80078c <main+0x130>
  8002d6:	000dc503          	lbu	a0,0(s11)
  8002da:	001d8413          	addi	s0,s11,1
  8002de:	01450b63          	beq	a0,s4,8002f4 <vprintfmt+0x52>
  8002e2:	c129                	beqz	a0,800324 <vprintfmt+0x82>
  8002e4:	864a                	mv	a2,s2
  8002e6:	85a6                	mv	a1,s1
  8002e8:	0405                	addi	s0,s0,1
  8002ea:	9982                	jalr	s3
  8002ec:	fff44503          	lbu	a0,-1(s0)
  8002f0:	ff4519e3          	bne	a0,s4,8002e2 <vprintfmt+0x40>
  8002f4:	00044583          	lbu	a1,0(s0)
  8002f8:	02000813          	li	a6,32
  8002fc:	4d01                	li	s10,0
  8002fe:	4301                	li	t1,0
  800300:	5cfd                	li	s9,-1
  800302:	5c7d                	li	s8,-1
  800304:	05500513          	li	a0,85
  800308:	48a5                	li	a7,9
  80030a:	fdd5861b          	addiw	a2,a1,-35
  80030e:	0ff67613          	zext.b	a2,a2
  800312:	00140d93          	addi	s11,s0,1
  800316:	04c56263          	bltu	a0,a2,80035a <vprintfmt+0xb8>
  80031a:	060a                	slli	a2,a2,0x2
  80031c:	965a                	add	a2,a2,s6
  80031e:	4214                	lw	a3,0(a2)
  800320:	96da                	add	a3,a3,s6
  800322:	8682                	jr	a3
  800324:	70e6                	ld	ra,120(sp)
  800326:	7446                	ld	s0,112(sp)
  800328:	74a6                	ld	s1,104(sp)
  80032a:	7906                	ld	s2,96(sp)
  80032c:	69e6                	ld	s3,88(sp)
  80032e:	6a46                	ld	s4,80(sp)
  800330:	6aa6                	ld	s5,72(sp)
  800332:	6b06                	ld	s6,64(sp)
  800334:	7be2                	ld	s7,56(sp)
  800336:	7c42                	ld	s8,48(sp)
  800338:	7ca2                	ld	s9,40(sp)
  80033a:	7d02                	ld	s10,32(sp)
  80033c:	6de2                	ld	s11,24(sp)
  80033e:	6109                	addi	sp,sp,128
  800340:	8082                	ret
  800342:	882e                	mv	a6,a1
  800344:	00144583          	lbu	a1,1(s0)
  800348:	846e                	mv	s0,s11
  80034a:	00140d93          	addi	s11,s0,1
  80034e:	fdd5861b          	addiw	a2,a1,-35
  800352:	0ff67613          	zext.b	a2,a2
  800356:	fcc572e3          	bgeu	a0,a2,80031a <vprintfmt+0x78>
  80035a:	864a                	mv	a2,s2
  80035c:	85a6                	mv	a1,s1
  80035e:	02500513          	li	a0,37
  800362:	9982                	jalr	s3
  800364:	fff44783          	lbu	a5,-1(s0)
  800368:	8da2                	mv	s11,s0
  80036a:	f74786e3          	beq	a5,s4,8002d6 <vprintfmt+0x34>
  80036e:	ffedc783          	lbu	a5,-2(s11)
  800372:	1dfd                	addi	s11,s11,-1
  800374:	ff479de3          	bne	a5,s4,80036e <vprintfmt+0xcc>
  800378:	bfb9                	j	8002d6 <vprintfmt+0x34>
  80037a:	fd058c9b          	addiw	s9,a1,-48
  80037e:	00144583          	lbu	a1,1(s0)
  800382:	846e                	mv	s0,s11
  800384:	fd05869b          	addiw	a3,a1,-48
  800388:	0005861b          	sext.w	a2,a1
  80038c:	02d8e463          	bltu	a7,a3,8003b4 <vprintfmt+0x112>
  800390:	00144583          	lbu	a1,1(s0)
  800394:	002c969b          	slliw	a3,s9,0x2
  800398:	0196873b          	addw	a4,a3,s9
  80039c:	0017171b          	slliw	a4,a4,0x1
  8003a0:	9f31                	addw	a4,a4,a2
  8003a2:	fd05869b          	addiw	a3,a1,-48
  8003a6:	0405                	addi	s0,s0,1
  8003a8:	fd070c9b          	addiw	s9,a4,-48
  8003ac:	0005861b          	sext.w	a2,a1
  8003b0:	fed8f0e3          	bgeu	a7,a3,800390 <vprintfmt+0xee>
  8003b4:	f40c5be3          	bgez	s8,80030a <vprintfmt+0x68>
  8003b8:	8c66                	mv	s8,s9
  8003ba:	5cfd                	li	s9,-1
  8003bc:	b7b9                	j	80030a <vprintfmt+0x68>
  8003be:	fffc4693          	not	a3,s8
  8003c2:	96fd                	srai	a3,a3,0x3f
  8003c4:	00dc77b3          	and	a5,s8,a3
  8003c8:	00144583          	lbu	a1,1(s0)
  8003cc:	00078c1b          	sext.w	s8,a5
  8003d0:	846e                	mv	s0,s11
  8003d2:	bf25                	j	80030a <vprintfmt+0x68>
  8003d4:	000aac83          	lw	s9,0(s5)
  8003d8:	00144583          	lbu	a1,1(s0)
  8003dc:	0aa1                	addi	s5,s5,8
  8003de:	846e                	mv	s0,s11
  8003e0:	bfd1                	j	8003b4 <vprintfmt+0x112>
  8003e2:	4705                	li	a4,1
  8003e4:	008a8613          	addi	a2,s5,8
  8003e8:	00674463          	blt	a4,t1,8003f0 <vprintfmt+0x14e>
  8003ec:	1c030c63          	beqz	t1,8005c4 <vprintfmt+0x322>
  8003f0:	000ab683          	ld	a3,0(s5)
  8003f4:	4741                	li	a4,16
  8003f6:	8ab2                	mv	s5,a2
  8003f8:	2801                	sext.w	a6,a6
  8003fa:	87e2                	mv	a5,s8
  8003fc:	8626                	mv	a2,s1
  8003fe:	85ca                	mv	a1,s2
  800400:	854e                	mv	a0,s3
  800402:	e2bff0ef          	jal	ra,80022c <printnum>
  800406:	bdc1                	j	8002d6 <vprintfmt+0x34>
  800408:	000aa503          	lw	a0,0(s5)
  80040c:	864a                	mv	a2,s2
  80040e:	85a6                	mv	a1,s1
  800410:	0aa1                	addi	s5,s5,8
  800412:	9982                	jalr	s3
  800414:	b5c9                	j	8002d6 <vprintfmt+0x34>
  800416:	4705                	li	a4,1
  800418:	008a8613          	addi	a2,s5,8
  80041c:	00674463          	blt	a4,t1,800424 <vprintfmt+0x182>
  800420:	18030d63          	beqz	t1,8005ba <vprintfmt+0x318>
  800424:	000ab683          	ld	a3,0(s5)
  800428:	4729                	li	a4,10
  80042a:	8ab2                	mv	s5,a2
  80042c:	b7f1                	j	8003f8 <vprintfmt+0x156>
  80042e:	00144583          	lbu	a1,1(s0)
  800432:	4d05                	li	s10,1
  800434:	846e                	mv	s0,s11
  800436:	bdd1                	j	80030a <vprintfmt+0x68>
  800438:	864a                	mv	a2,s2
  80043a:	85a6                	mv	a1,s1
  80043c:	02500513          	li	a0,37
  800440:	9982                	jalr	s3
  800442:	bd51                	j	8002d6 <vprintfmt+0x34>
  800444:	00144583          	lbu	a1,1(s0)
  800448:	2305                	addiw	t1,t1,1
  80044a:	846e                	mv	s0,s11
  80044c:	bd7d                	j	80030a <vprintfmt+0x68>
  80044e:	4705                	li	a4,1
  800450:	008a8613          	addi	a2,s5,8
  800454:	00674463          	blt	a4,t1,80045c <vprintfmt+0x1ba>
  800458:	14030c63          	beqz	t1,8005b0 <vprintfmt+0x30e>
  80045c:	000ab683          	ld	a3,0(s5)
  800460:	4721                	li	a4,8
  800462:	8ab2                	mv	s5,a2
  800464:	bf51                	j	8003f8 <vprintfmt+0x156>
  800466:	03000513          	li	a0,48
  80046a:	864a                	mv	a2,s2
  80046c:	85a6                	mv	a1,s1
  80046e:	e042                	sd	a6,0(sp)
  800470:	9982                	jalr	s3
  800472:	864a                	mv	a2,s2
  800474:	85a6                	mv	a1,s1
  800476:	07800513          	li	a0,120
  80047a:	9982                	jalr	s3
  80047c:	0aa1                	addi	s5,s5,8
  80047e:	6802                	ld	a6,0(sp)
  800480:	4741                	li	a4,16
  800482:	ff8ab683          	ld	a3,-8(s5)
  800486:	bf8d                	j	8003f8 <vprintfmt+0x156>
  800488:	000ab403          	ld	s0,0(s5)
  80048c:	008a8793          	addi	a5,s5,8
  800490:	e03e                	sd	a5,0(sp)
  800492:	14040c63          	beqz	s0,8005ea <vprintfmt+0x348>
  800496:	11805063          	blez	s8,800596 <vprintfmt+0x2f4>
  80049a:	02d00693          	li	a3,45
  80049e:	0cd81963          	bne	a6,a3,800570 <vprintfmt+0x2ce>
  8004a2:	00044683          	lbu	a3,0(s0)
  8004a6:	0006851b          	sext.w	a0,a3
  8004aa:	ce8d                	beqz	a3,8004e4 <vprintfmt+0x242>
  8004ac:	00140a93          	addi	s5,s0,1
  8004b0:	05e00413          	li	s0,94
  8004b4:	000cc563          	bltz	s9,8004be <vprintfmt+0x21c>
  8004b8:	3cfd                	addiw	s9,s9,-1
  8004ba:	037c8363          	beq	s9,s7,8004e0 <vprintfmt+0x23e>
  8004be:	864a                	mv	a2,s2
  8004c0:	85a6                	mv	a1,s1
  8004c2:	100d0663          	beqz	s10,8005ce <vprintfmt+0x32c>
  8004c6:	3681                	addiw	a3,a3,-32
  8004c8:	10d47363          	bgeu	s0,a3,8005ce <vprintfmt+0x32c>
  8004cc:	03f00513          	li	a0,63
  8004d0:	9982                	jalr	s3
  8004d2:	000ac683          	lbu	a3,0(s5)
  8004d6:	3c7d                	addiw	s8,s8,-1
  8004d8:	0a85                	addi	s5,s5,1
  8004da:	0006851b          	sext.w	a0,a3
  8004de:	faf9                	bnez	a3,8004b4 <vprintfmt+0x212>
  8004e0:	01805a63          	blez	s8,8004f4 <vprintfmt+0x252>
  8004e4:	3c7d                	addiw	s8,s8,-1
  8004e6:	864a                	mv	a2,s2
  8004e8:	85a6                	mv	a1,s1
  8004ea:	02000513          	li	a0,32
  8004ee:	9982                	jalr	s3
  8004f0:	fe0c1ae3          	bnez	s8,8004e4 <vprintfmt+0x242>
  8004f4:	6a82                	ld	s5,0(sp)
  8004f6:	b3c5                	j	8002d6 <vprintfmt+0x34>
  8004f8:	4705                	li	a4,1
  8004fa:	008a8d13          	addi	s10,s5,8
  8004fe:	00674463          	blt	a4,t1,800506 <vprintfmt+0x264>
  800502:	0a030463          	beqz	t1,8005aa <vprintfmt+0x308>
  800506:	000ab403          	ld	s0,0(s5)
  80050a:	0c044463          	bltz	s0,8005d2 <vprintfmt+0x330>
  80050e:	86a2                	mv	a3,s0
  800510:	8aea                	mv	s5,s10
  800512:	4729                	li	a4,10
  800514:	b5d5                	j	8003f8 <vprintfmt+0x156>
  800516:	000aa783          	lw	a5,0(s5)
  80051a:	46e1                	li	a3,24
  80051c:	0aa1                	addi	s5,s5,8
  80051e:	41f7d71b          	sraiw	a4,a5,0x1f
  800522:	8fb9                	xor	a5,a5,a4
  800524:	40e7873b          	subw	a4,a5,a4
  800528:	02e6c663          	blt	a3,a4,800554 <vprintfmt+0x2b2>
  80052c:	00371793          	slli	a5,a4,0x3
  800530:	00000697          	auipc	a3,0x0
  800534:	59068693          	addi	a3,a3,1424 # 800ac0 <error_string>
  800538:	97b6                	add	a5,a5,a3
  80053a:	639c                	ld	a5,0(a5)
  80053c:	cf81                	beqz	a5,800554 <vprintfmt+0x2b2>
  80053e:	873e                	mv	a4,a5
  800540:	00000697          	auipc	a3,0x0
  800544:	24868693          	addi	a3,a3,584 # 800788 <main+0x12c>
  800548:	8626                	mv	a2,s1
  80054a:	85ca                	mv	a1,s2
  80054c:	854e                	mv	a0,s3
  80054e:	0d4000ef          	jal	ra,800622 <printfmt>
  800552:	b351                	j	8002d6 <vprintfmt+0x34>
  800554:	00000697          	auipc	a3,0x0
  800558:	22468693          	addi	a3,a3,548 # 800778 <main+0x11c>
  80055c:	8626                	mv	a2,s1
  80055e:	85ca                	mv	a1,s2
  800560:	854e                	mv	a0,s3
  800562:	0c0000ef          	jal	ra,800622 <printfmt>
  800566:	bb85                	j	8002d6 <vprintfmt+0x34>
  800568:	00000417          	auipc	s0,0x0
  80056c:	20840413          	addi	s0,s0,520 # 800770 <main+0x114>
  800570:	85e6                	mv	a1,s9
  800572:	8522                	mv	a0,s0
  800574:	e442                	sd	a6,8(sp)
  800576:	0ca000ef          	jal	ra,800640 <strnlen>
  80057a:	40ac0c3b          	subw	s8,s8,a0
  80057e:	01805c63          	blez	s8,800596 <vprintfmt+0x2f4>
  800582:	6822                	ld	a6,8(sp)
  800584:	00080a9b          	sext.w	s5,a6
  800588:	3c7d                	addiw	s8,s8,-1
  80058a:	864a                	mv	a2,s2
  80058c:	85a6                	mv	a1,s1
  80058e:	8556                	mv	a0,s5
  800590:	9982                	jalr	s3
  800592:	fe0c1be3          	bnez	s8,800588 <vprintfmt+0x2e6>
  800596:	00044683          	lbu	a3,0(s0)
  80059a:	00140a93          	addi	s5,s0,1
  80059e:	0006851b          	sext.w	a0,a3
  8005a2:	daa9                	beqz	a3,8004f4 <vprintfmt+0x252>
  8005a4:	05e00413          	li	s0,94
  8005a8:	b731                	j	8004b4 <vprintfmt+0x212>
  8005aa:	000aa403          	lw	s0,0(s5)
  8005ae:	bfb1                	j	80050a <vprintfmt+0x268>
  8005b0:	000ae683          	lwu	a3,0(s5)
  8005b4:	4721                	li	a4,8
  8005b6:	8ab2                	mv	s5,a2
  8005b8:	b581                	j	8003f8 <vprintfmt+0x156>
  8005ba:	000ae683          	lwu	a3,0(s5)
  8005be:	4729                	li	a4,10
  8005c0:	8ab2                	mv	s5,a2
  8005c2:	bd1d                	j	8003f8 <vprintfmt+0x156>
  8005c4:	000ae683          	lwu	a3,0(s5)
  8005c8:	4741                	li	a4,16
  8005ca:	8ab2                	mv	s5,a2
  8005cc:	b535                	j	8003f8 <vprintfmt+0x156>
  8005ce:	9982                	jalr	s3
  8005d0:	b709                	j	8004d2 <vprintfmt+0x230>
  8005d2:	864a                	mv	a2,s2
  8005d4:	85a6                	mv	a1,s1
  8005d6:	02d00513          	li	a0,45
  8005da:	e042                	sd	a6,0(sp)
  8005dc:	9982                	jalr	s3
  8005de:	6802                	ld	a6,0(sp)
  8005e0:	8aea                	mv	s5,s10
  8005e2:	408006b3          	neg	a3,s0
  8005e6:	4729                	li	a4,10
  8005e8:	bd01                	j	8003f8 <vprintfmt+0x156>
  8005ea:	03805163          	blez	s8,80060c <vprintfmt+0x36a>
  8005ee:	02d00693          	li	a3,45
  8005f2:	f6d81be3          	bne	a6,a3,800568 <vprintfmt+0x2c6>
  8005f6:	00000417          	auipc	s0,0x0
  8005fa:	17a40413          	addi	s0,s0,378 # 800770 <main+0x114>
  8005fe:	02800693          	li	a3,40
  800602:	02800513          	li	a0,40
  800606:	00140a93          	addi	s5,s0,1
  80060a:	b55d                	j	8004b0 <vprintfmt+0x20e>
  80060c:	00000a97          	auipc	s5,0x0
  800610:	165a8a93          	addi	s5,s5,357 # 800771 <main+0x115>
  800614:	02800513          	li	a0,40
  800618:	02800693          	li	a3,40
  80061c:	05e00413          	li	s0,94
  800620:	bd51                	j	8004b4 <vprintfmt+0x212>

0000000000800622 <printfmt>:
  800622:	7139                	addi	sp,sp,-64
  800624:	02010313          	addi	t1,sp,32
  800628:	f03a                	sd	a4,32(sp)
  80062a:	871a                	mv	a4,t1
  80062c:	ec06                	sd	ra,24(sp)
  80062e:	f43e                	sd	a5,40(sp)
  800630:	f842                	sd	a6,48(sp)
  800632:	fc46                	sd	a7,56(sp)
  800634:	e41a                	sd	t1,8(sp)
  800636:	c6dff0ef          	jal	ra,8002a2 <vprintfmt>
  80063a:	60e2                	ld	ra,24(sp)
  80063c:	6121                	addi	sp,sp,64
  80063e:	8082                	ret

0000000000800640 <strnlen>:
  800640:	4781                	li	a5,0
  800642:	e589                	bnez	a1,80064c <strnlen+0xc>
  800644:	a811                	j	800658 <strnlen+0x18>
  800646:	0785                	addi	a5,a5,1
  800648:	00f58863          	beq	a1,a5,800658 <strnlen+0x18>
  80064c:	00f50733          	add	a4,a0,a5
  800650:	00074703          	lbu	a4,0(a4)
  800654:	fb6d                	bnez	a4,800646 <strnlen+0x6>
  800656:	85be                	mv	a1,a5
  800658:	852e                	mv	a0,a1
  80065a:	8082                	ret

000000000080065c <main>:
  80065c:	1141                	addi	sp,sp,-16
  80065e:	00000517          	auipc	a0,0x0
  800662:	52a50513          	addi	a0,a0,1322 # 800b88 <error_string+0xc8>
  800666:	e406                	sd	ra,8(sp)
  800668:	a55ff0ef          	jal	ra,8000bc <cprintf>
  80066c:	b07ff0ef          	jal	ra,800172 <getpid>
  800670:	85aa                	mv	a1,a0
  800672:	00000517          	auipc	a0,0x0
  800676:	52650513          	addi	a0,a0,1318 # 800b98 <error_string+0xd8>
  80067a:	a43ff0ef          	jal	ra,8000bc <cprintf>
  80067e:	00000517          	auipc	a0,0x0
  800682:	53250513          	addi	a0,a0,1330 # 800bb0 <error_string+0xf0>
  800686:	a37ff0ef          	jal	ra,8000bc <cprintf>
  80068a:	60a2                	ld	ra,8(sp)
  80068c:	4501                	li	a0,0
  80068e:	0141                	addi	sp,sp,16
  800690:	8082                	ret
