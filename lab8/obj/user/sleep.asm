
obj/__user_sleep.out:     file format elf64-littleriscv


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
  800032:	1e4000ef          	jal	ra,800216 <umain>
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
  80004c:	71850513          	addi	a0,a0,1816 # 800760 <main+0x70>
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
  80006c:	77050513          	addi	a0,a0,1904 # 8007d8 <main+0xe8>
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
  80008e:	6f650513          	addi	a0,a0,1782 # 800780 <main+0x90>
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
  8000ae:	72e50513          	addi	a0,a0,1838 # 8007d8 <main+0xe8>
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
  8000c6:	0be000ef          	jal	ra,800184 <sys_putc>
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
  8000f2:	20e000ef          	jal	ra,800300 <vprintfmt>
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
  80012e:	1d2000ef          	jal	ra,800300 <vprintfmt>
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

0000000000800184 <sys_putc>:
  800184:	85aa                	mv	a1,a0
  800186:	4579                	li	a0,30
  800188:	bf4d                	j	80013a <syscall>

000000000080018a <sys_sleep>:
  80018a:	85aa                	mv	a1,a0
  80018c:	452d                	li	a0,11
  80018e:	b775                	j	80013a <syscall>

0000000000800190 <sys_gettime>:
  800190:	4545                	li	a0,17
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
  8001bc:	5e850513          	addi	a0,a0,1512 # 8007a0 <main+0xb0>
  8001c0:	f3fff0ef          	jal	ra,8000fe <cprintf>
  8001c4:	a001                	j	8001c4 <exit+0x14>

00000000008001c6 <fork>:
  8001c6:	bf4d                	j	800178 <sys_fork>

00000000008001c8 <waitpid>:
  8001c8:	bf55                	j	80017c <sys_wait>

00000000008001ca <gettime_msec>:
  8001ca:	b7d9                	j	800190 <sys_gettime>

00000000008001cc <sleep>:
  8001cc:	1502                	slli	a0,a0,0x20
  8001ce:	9101                	srli	a0,a0,0x20
  8001d0:	bf6d                	j	80018a <sys_sleep>

00000000008001d2 <initfd>:
  8001d2:	1101                	addi	sp,sp,-32
  8001d4:	87ae                	mv	a5,a1
  8001d6:	e426                	sd	s1,8(sp)
  8001d8:	85b2                	mv	a1,a2
  8001da:	84aa                	mv	s1,a0
  8001dc:	853e                	mv	a0,a5
  8001de:	e822                	sd	s0,16(sp)
  8001e0:	ec06                	sd	ra,24(sp)
  8001e2:	e3fff0ef          	jal	ra,800020 <open>
  8001e6:	842a                	mv	s0,a0
  8001e8:	00054463          	bltz	a0,8001f0 <initfd+0x1e>
  8001ec:	00951863          	bne	a0,s1,8001fc <initfd+0x2a>
  8001f0:	60e2                	ld	ra,24(sp)
  8001f2:	8522                	mv	a0,s0
  8001f4:	6442                	ld	s0,16(sp)
  8001f6:	64a2                	ld	s1,8(sp)
  8001f8:	6105                	addi	sp,sp,32
  8001fa:	8082                	ret
  8001fc:	8526                	mv	a0,s1
  8001fe:	e29ff0ef          	jal	ra,800026 <close>
  800202:	85a6                	mv	a1,s1
  800204:	8522                	mv	a0,s0
  800206:	e23ff0ef          	jal	ra,800028 <dup2>
  80020a:	84aa                	mv	s1,a0
  80020c:	8522                	mv	a0,s0
  80020e:	e19ff0ef          	jal	ra,800026 <close>
  800212:	8426                	mv	s0,s1
  800214:	bff1                	j	8001f0 <initfd+0x1e>

0000000000800216 <umain>:
  800216:	1101                	addi	sp,sp,-32
  800218:	e822                	sd	s0,16(sp)
  80021a:	e426                	sd	s1,8(sp)
  80021c:	842a                	mv	s0,a0
  80021e:	84ae                	mv	s1,a1
  800220:	4601                	li	a2,0
  800222:	00000597          	auipc	a1,0x0
  800226:	59658593          	addi	a1,a1,1430 # 8007b8 <main+0xc8>
  80022a:	4501                	li	a0,0
  80022c:	ec06                	sd	ra,24(sp)
  80022e:	fa5ff0ef          	jal	ra,8001d2 <initfd>
  800232:	02054263          	bltz	a0,800256 <umain+0x40>
  800236:	4605                	li	a2,1
  800238:	00000597          	auipc	a1,0x0
  80023c:	5c058593          	addi	a1,a1,1472 # 8007f8 <main+0x108>
  800240:	4505                	li	a0,1
  800242:	f91ff0ef          	jal	ra,8001d2 <initfd>
  800246:	02054563          	bltz	a0,800270 <umain+0x5a>
  80024a:	85a6                	mv	a1,s1
  80024c:	8522                	mv	a0,s0
  80024e:	4a2000ef          	jal	ra,8006f0 <main>
  800252:	f5fff0ef          	jal	ra,8001b0 <exit>
  800256:	86aa                	mv	a3,a0
  800258:	00000617          	auipc	a2,0x0
  80025c:	56860613          	addi	a2,a2,1384 # 8007c0 <main+0xd0>
  800260:	45e9                	li	a1,26
  800262:	00000517          	auipc	a0,0x0
  800266:	57e50513          	addi	a0,a0,1406 # 8007e0 <main+0xf0>
  80026a:	e11ff0ef          	jal	ra,80007a <__warn>
  80026e:	b7e1                	j	800236 <umain+0x20>
  800270:	86aa                	mv	a3,a0
  800272:	00000617          	auipc	a2,0x0
  800276:	58e60613          	addi	a2,a2,1422 # 800800 <main+0x110>
  80027a:	45f5                	li	a1,29
  80027c:	00000517          	auipc	a0,0x0
  800280:	56450513          	addi	a0,a0,1380 # 8007e0 <main+0xf0>
  800284:	df7ff0ef          	jal	ra,80007a <__warn>
  800288:	b7c9                	j	80024a <umain+0x34>

000000000080028a <printnum>:
  80028a:	02071893          	slli	a7,a4,0x20
  80028e:	7139                	addi	sp,sp,-64
  800290:	0208d893          	srli	a7,a7,0x20
  800294:	e456                	sd	s5,8(sp)
  800296:	0316fab3          	remu	s5,a3,a7
  80029a:	f822                	sd	s0,48(sp)
  80029c:	f426                	sd	s1,40(sp)
  80029e:	f04a                	sd	s2,32(sp)
  8002a0:	ec4e                	sd	s3,24(sp)
  8002a2:	fc06                	sd	ra,56(sp)
  8002a4:	e852                	sd	s4,16(sp)
  8002a6:	84aa                	mv	s1,a0
  8002a8:	89ae                	mv	s3,a1
  8002aa:	8932                	mv	s2,a2
  8002ac:	fff7841b          	addiw	s0,a5,-1
  8002b0:	2a81                	sext.w	s5,s5
  8002b2:	0516f163          	bgeu	a3,a7,8002f4 <printnum+0x6a>
  8002b6:	8a42                	mv	s4,a6
  8002b8:	00805863          	blez	s0,8002c8 <printnum+0x3e>
  8002bc:	347d                	addiw	s0,s0,-1
  8002be:	864e                	mv	a2,s3
  8002c0:	85ca                	mv	a1,s2
  8002c2:	8552                	mv	a0,s4
  8002c4:	9482                	jalr	s1
  8002c6:	f87d                	bnez	s0,8002bc <printnum+0x32>
  8002c8:	1a82                	slli	s5,s5,0x20
  8002ca:	00000797          	auipc	a5,0x0
  8002ce:	55678793          	addi	a5,a5,1366 # 800820 <main+0x130>
  8002d2:	020ada93          	srli	s5,s5,0x20
  8002d6:	9abe                	add	s5,s5,a5
  8002d8:	7442                	ld	s0,48(sp)
  8002da:	000ac503          	lbu	a0,0(s5)
  8002de:	70e2                	ld	ra,56(sp)
  8002e0:	6a42                	ld	s4,16(sp)
  8002e2:	6aa2                	ld	s5,8(sp)
  8002e4:	864e                	mv	a2,s3
  8002e6:	85ca                	mv	a1,s2
  8002e8:	69e2                	ld	s3,24(sp)
  8002ea:	7902                	ld	s2,32(sp)
  8002ec:	87a6                	mv	a5,s1
  8002ee:	74a2                	ld	s1,40(sp)
  8002f0:	6121                	addi	sp,sp,64
  8002f2:	8782                	jr	a5
  8002f4:	0316d6b3          	divu	a3,a3,a7
  8002f8:	87a2                	mv	a5,s0
  8002fa:	f91ff0ef          	jal	ra,80028a <printnum>
  8002fe:	b7e9                	j	8002c8 <printnum+0x3e>

0000000000800300 <vprintfmt>:
  800300:	7119                	addi	sp,sp,-128
  800302:	f4a6                	sd	s1,104(sp)
  800304:	f0ca                	sd	s2,96(sp)
  800306:	ecce                	sd	s3,88(sp)
  800308:	e8d2                	sd	s4,80(sp)
  80030a:	e4d6                	sd	s5,72(sp)
  80030c:	e0da                	sd	s6,64(sp)
  80030e:	fc5e                	sd	s7,56(sp)
  800310:	ec6e                	sd	s11,24(sp)
  800312:	fc86                	sd	ra,120(sp)
  800314:	f8a2                	sd	s0,112(sp)
  800316:	f862                	sd	s8,48(sp)
  800318:	f466                	sd	s9,40(sp)
  80031a:	f06a                	sd	s10,32(sp)
  80031c:	89aa                	mv	s3,a0
  80031e:	892e                	mv	s2,a1
  800320:	84b2                	mv	s1,a2
  800322:	8db6                	mv	s11,a3
  800324:	8aba                	mv	s5,a4
  800326:	02500a13          	li	s4,37
  80032a:	5bfd                	li	s7,-1
  80032c:	00000b17          	auipc	s6,0x0
  800330:	528b0b13          	addi	s6,s6,1320 # 800854 <main+0x164>
  800334:	000dc503          	lbu	a0,0(s11)
  800338:	001d8413          	addi	s0,s11,1
  80033c:	01450b63          	beq	a0,s4,800352 <vprintfmt+0x52>
  800340:	c129                	beqz	a0,800382 <vprintfmt+0x82>
  800342:	864a                	mv	a2,s2
  800344:	85a6                	mv	a1,s1
  800346:	0405                	addi	s0,s0,1
  800348:	9982                	jalr	s3
  80034a:	fff44503          	lbu	a0,-1(s0)
  80034e:	ff4519e3          	bne	a0,s4,800340 <vprintfmt+0x40>
  800352:	00044583          	lbu	a1,0(s0)
  800356:	02000813          	li	a6,32
  80035a:	4d01                	li	s10,0
  80035c:	4301                	li	t1,0
  80035e:	5cfd                	li	s9,-1
  800360:	5c7d                	li	s8,-1
  800362:	05500513          	li	a0,85
  800366:	48a5                	li	a7,9
  800368:	fdd5861b          	addiw	a2,a1,-35
  80036c:	0ff67613          	zext.b	a2,a2
  800370:	00140d93          	addi	s11,s0,1
  800374:	04c56263          	bltu	a0,a2,8003b8 <vprintfmt+0xb8>
  800378:	060a                	slli	a2,a2,0x2
  80037a:	965a                	add	a2,a2,s6
  80037c:	4214                	lw	a3,0(a2)
  80037e:	96da                	add	a3,a3,s6
  800380:	8682                	jr	a3
  800382:	70e6                	ld	ra,120(sp)
  800384:	7446                	ld	s0,112(sp)
  800386:	74a6                	ld	s1,104(sp)
  800388:	7906                	ld	s2,96(sp)
  80038a:	69e6                	ld	s3,88(sp)
  80038c:	6a46                	ld	s4,80(sp)
  80038e:	6aa6                	ld	s5,72(sp)
  800390:	6b06                	ld	s6,64(sp)
  800392:	7be2                	ld	s7,56(sp)
  800394:	7c42                	ld	s8,48(sp)
  800396:	7ca2                	ld	s9,40(sp)
  800398:	7d02                	ld	s10,32(sp)
  80039a:	6de2                	ld	s11,24(sp)
  80039c:	6109                	addi	sp,sp,128
  80039e:	8082                	ret
  8003a0:	882e                	mv	a6,a1
  8003a2:	00144583          	lbu	a1,1(s0)
  8003a6:	846e                	mv	s0,s11
  8003a8:	00140d93          	addi	s11,s0,1
  8003ac:	fdd5861b          	addiw	a2,a1,-35
  8003b0:	0ff67613          	zext.b	a2,a2
  8003b4:	fcc572e3          	bgeu	a0,a2,800378 <vprintfmt+0x78>
  8003b8:	864a                	mv	a2,s2
  8003ba:	85a6                	mv	a1,s1
  8003bc:	02500513          	li	a0,37
  8003c0:	9982                	jalr	s3
  8003c2:	fff44783          	lbu	a5,-1(s0)
  8003c6:	8da2                	mv	s11,s0
  8003c8:	f74786e3          	beq	a5,s4,800334 <vprintfmt+0x34>
  8003cc:	ffedc783          	lbu	a5,-2(s11)
  8003d0:	1dfd                	addi	s11,s11,-1
  8003d2:	ff479de3          	bne	a5,s4,8003cc <vprintfmt+0xcc>
  8003d6:	bfb9                	j	800334 <vprintfmt+0x34>
  8003d8:	fd058c9b          	addiw	s9,a1,-48
  8003dc:	00144583          	lbu	a1,1(s0)
  8003e0:	846e                	mv	s0,s11
  8003e2:	fd05869b          	addiw	a3,a1,-48
  8003e6:	0005861b          	sext.w	a2,a1
  8003ea:	02d8e463          	bltu	a7,a3,800412 <vprintfmt+0x112>
  8003ee:	00144583          	lbu	a1,1(s0)
  8003f2:	002c969b          	slliw	a3,s9,0x2
  8003f6:	0196873b          	addw	a4,a3,s9
  8003fa:	0017171b          	slliw	a4,a4,0x1
  8003fe:	9f31                	addw	a4,a4,a2
  800400:	fd05869b          	addiw	a3,a1,-48
  800404:	0405                	addi	s0,s0,1
  800406:	fd070c9b          	addiw	s9,a4,-48
  80040a:	0005861b          	sext.w	a2,a1
  80040e:	fed8f0e3          	bgeu	a7,a3,8003ee <vprintfmt+0xee>
  800412:	f40c5be3          	bgez	s8,800368 <vprintfmt+0x68>
  800416:	8c66                	mv	s8,s9
  800418:	5cfd                	li	s9,-1
  80041a:	b7b9                	j	800368 <vprintfmt+0x68>
  80041c:	fffc4693          	not	a3,s8
  800420:	96fd                	srai	a3,a3,0x3f
  800422:	00dc77b3          	and	a5,s8,a3
  800426:	00144583          	lbu	a1,1(s0)
  80042a:	00078c1b          	sext.w	s8,a5
  80042e:	846e                	mv	s0,s11
  800430:	bf25                	j	800368 <vprintfmt+0x68>
  800432:	000aac83          	lw	s9,0(s5)
  800436:	00144583          	lbu	a1,1(s0)
  80043a:	0aa1                	addi	s5,s5,8
  80043c:	846e                	mv	s0,s11
  80043e:	bfd1                	j	800412 <vprintfmt+0x112>
  800440:	4705                	li	a4,1
  800442:	008a8613          	addi	a2,s5,8
  800446:	00674463          	blt	a4,t1,80044e <vprintfmt+0x14e>
  80044a:	1c030c63          	beqz	t1,800622 <vprintfmt+0x322>
  80044e:	000ab683          	ld	a3,0(s5)
  800452:	4741                	li	a4,16
  800454:	8ab2                	mv	s5,a2
  800456:	2801                	sext.w	a6,a6
  800458:	87e2                	mv	a5,s8
  80045a:	8626                	mv	a2,s1
  80045c:	85ca                	mv	a1,s2
  80045e:	854e                	mv	a0,s3
  800460:	e2bff0ef          	jal	ra,80028a <printnum>
  800464:	bdc1                	j	800334 <vprintfmt+0x34>
  800466:	000aa503          	lw	a0,0(s5)
  80046a:	864a                	mv	a2,s2
  80046c:	85a6                	mv	a1,s1
  80046e:	0aa1                	addi	s5,s5,8
  800470:	9982                	jalr	s3
  800472:	b5c9                	j	800334 <vprintfmt+0x34>
  800474:	4705                	li	a4,1
  800476:	008a8613          	addi	a2,s5,8
  80047a:	00674463          	blt	a4,t1,800482 <vprintfmt+0x182>
  80047e:	18030d63          	beqz	t1,800618 <vprintfmt+0x318>
  800482:	000ab683          	ld	a3,0(s5)
  800486:	4729                	li	a4,10
  800488:	8ab2                	mv	s5,a2
  80048a:	b7f1                	j	800456 <vprintfmt+0x156>
  80048c:	00144583          	lbu	a1,1(s0)
  800490:	4d05                	li	s10,1
  800492:	846e                	mv	s0,s11
  800494:	bdd1                	j	800368 <vprintfmt+0x68>
  800496:	864a                	mv	a2,s2
  800498:	85a6                	mv	a1,s1
  80049a:	02500513          	li	a0,37
  80049e:	9982                	jalr	s3
  8004a0:	bd51                	j	800334 <vprintfmt+0x34>
  8004a2:	00144583          	lbu	a1,1(s0)
  8004a6:	2305                	addiw	t1,t1,1
  8004a8:	846e                	mv	s0,s11
  8004aa:	bd7d                	j	800368 <vprintfmt+0x68>
  8004ac:	4705                	li	a4,1
  8004ae:	008a8613          	addi	a2,s5,8
  8004b2:	00674463          	blt	a4,t1,8004ba <vprintfmt+0x1ba>
  8004b6:	14030c63          	beqz	t1,80060e <vprintfmt+0x30e>
  8004ba:	000ab683          	ld	a3,0(s5)
  8004be:	4721                	li	a4,8
  8004c0:	8ab2                	mv	s5,a2
  8004c2:	bf51                	j	800456 <vprintfmt+0x156>
  8004c4:	03000513          	li	a0,48
  8004c8:	864a                	mv	a2,s2
  8004ca:	85a6                	mv	a1,s1
  8004cc:	e042                	sd	a6,0(sp)
  8004ce:	9982                	jalr	s3
  8004d0:	864a                	mv	a2,s2
  8004d2:	85a6                	mv	a1,s1
  8004d4:	07800513          	li	a0,120
  8004d8:	9982                	jalr	s3
  8004da:	0aa1                	addi	s5,s5,8
  8004dc:	6802                	ld	a6,0(sp)
  8004de:	4741                	li	a4,16
  8004e0:	ff8ab683          	ld	a3,-8(s5)
  8004e4:	bf8d                	j	800456 <vprintfmt+0x156>
  8004e6:	000ab403          	ld	s0,0(s5)
  8004ea:	008a8793          	addi	a5,s5,8
  8004ee:	e03e                	sd	a5,0(sp)
  8004f0:	14040c63          	beqz	s0,800648 <vprintfmt+0x348>
  8004f4:	11805063          	blez	s8,8005f4 <vprintfmt+0x2f4>
  8004f8:	02d00693          	li	a3,45
  8004fc:	0cd81963          	bne	a6,a3,8005ce <vprintfmt+0x2ce>
  800500:	00044683          	lbu	a3,0(s0)
  800504:	0006851b          	sext.w	a0,a3
  800508:	ce8d                	beqz	a3,800542 <vprintfmt+0x242>
  80050a:	00140a93          	addi	s5,s0,1
  80050e:	05e00413          	li	s0,94
  800512:	000cc563          	bltz	s9,80051c <vprintfmt+0x21c>
  800516:	3cfd                	addiw	s9,s9,-1
  800518:	037c8363          	beq	s9,s7,80053e <vprintfmt+0x23e>
  80051c:	864a                	mv	a2,s2
  80051e:	85a6                	mv	a1,s1
  800520:	100d0663          	beqz	s10,80062c <vprintfmt+0x32c>
  800524:	3681                	addiw	a3,a3,-32
  800526:	10d47363          	bgeu	s0,a3,80062c <vprintfmt+0x32c>
  80052a:	03f00513          	li	a0,63
  80052e:	9982                	jalr	s3
  800530:	000ac683          	lbu	a3,0(s5)
  800534:	3c7d                	addiw	s8,s8,-1
  800536:	0a85                	addi	s5,s5,1
  800538:	0006851b          	sext.w	a0,a3
  80053c:	faf9                	bnez	a3,800512 <vprintfmt+0x212>
  80053e:	01805a63          	blez	s8,800552 <vprintfmt+0x252>
  800542:	3c7d                	addiw	s8,s8,-1
  800544:	864a                	mv	a2,s2
  800546:	85a6                	mv	a1,s1
  800548:	02000513          	li	a0,32
  80054c:	9982                	jalr	s3
  80054e:	fe0c1ae3          	bnez	s8,800542 <vprintfmt+0x242>
  800552:	6a82                	ld	s5,0(sp)
  800554:	b3c5                	j	800334 <vprintfmt+0x34>
  800556:	4705                	li	a4,1
  800558:	008a8d13          	addi	s10,s5,8
  80055c:	00674463          	blt	a4,t1,800564 <vprintfmt+0x264>
  800560:	0a030463          	beqz	t1,800608 <vprintfmt+0x308>
  800564:	000ab403          	ld	s0,0(s5)
  800568:	0c044463          	bltz	s0,800630 <vprintfmt+0x330>
  80056c:	86a2                	mv	a3,s0
  80056e:	8aea                	mv	s5,s10
  800570:	4729                	li	a4,10
  800572:	b5d5                	j	800456 <vprintfmt+0x156>
  800574:	000aa783          	lw	a5,0(s5)
  800578:	46e1                	li	a3,24
  80057a:	0aa1                	addi	s5,s5,8
  80057c:	41f7d71b          	sraiw	a4,a5,0x1f
  800580:	8fb9                	xor	a5,a5,a4
  800582:	40e7873b          	subw	a4,a5,a4
  800586:	02e6c663          	blt	a3,a4,8005b2 <vprintfmt+0x2b2>
  80058a:	00371793          	slli	a5,a4,0x3
  80058e:	00000697          	auipc	a3,0x0
  800592:	5fa68693          	addi	a3,a3,1530 # 800b88 <error_string>
  800596:	97b6                	add	a5,a5,a3
  800598:	639c                	ld	a5,0(a5)
  80059a:	cf81                	beqz	a5,8005b2 <vprintfmt+0x2b2>
  80059c:	873e                	mv	a4,a5
  80059e:	00000697          	auipc	a3,0x0
  8005a2:	2b268693          	addi	a3,a3,690 # 800850 <main+0x160>
  8005a6:	8626                	mv	a2,s1
  8005a8:	85ca                	mv	a1,s2
  8005aa:	854e                	mv	a0,s3
  8005ac:	0d4000ef          	jal	ra,800680 <printfmt>
  8005b0:	b351                	j	800334 <vprintfmt+0x34>
  8005b2:	00000697          	auipc	a3,0x0
  8005b6:	28e68693          	addi	a3,a3,654 # 800840 <main+0x150>
  8005ba:	8626                	mv	a2,s1
  8005bc:	85ca                	mv	a1,s2
  8005be:	854e                	mv	a0,s3
  8005c0:	0c0000ef          	jal	ra,800680 <printfmt>
  8005c4:	bb85                	j	800334 <vprintfmt+0x34>
  8005c6:	00000417          	auipc	s0,0x0
  8005ca:	27240413          	addi	s0,s0,626 # 800838 <main+0x148>
  8005ce:	85e6                	mv	a1,s9
  8005d0:	8522                	mv	a0,s0
  8005d2:	e442                	sd	a6,8(sp)
  8005d4:	0ca000ef          	jal	ra,80069e <strnlen>
  8005d8:	40ac0c3b          	subw	s8,s8,a0
  8005dc:	01805c63          	blez	s8,8005f4 <vprintfmt+0x2f4>
  8005e0:	6822                	ld	a6,8(sp)
  8005e2:	00080a9b          	sext.w	s5,a6
  8005e6:	3c7d                	addiw	s8,s8,-1
  8005e8:	864a                	mv	a2,s2
  8005ea:	85a6                	mv	a1,s1
  8005ec:	8556                	mv	a0,s5
  8005ee:	9982                	jalr	s3
  8005f0:	fe0c1be3          	bnez	s8,8005e6 <vprintfmt+0x2e6>
  8005f4:	00044683          	lbu	a3,0(s0)
  8005f8:	00140a93          	addi	s5,s0,1
  8005fc:	0006851b          	sext.w	a0,a3
  800600:	daa9                	beqz	a3,800552 <vprintfmt+0x252>
  800602:	05e00413          	li	s0,94
  800606:	b731                	j	800512 <vprintfmt+0x212>
  800608:	000aa403          	lw	s0,0(s5)
  80060c:	bfb1                	j	800568 <vprintfmt+0x268>
  80060e:	000ae683          	lwu	a3,0(s5)
  800612:	4721                	li	a4,8
  800614:	8ab2                	mv	s5,a2
  800616:	b581                	j	800456 <vprintfmt+0x156>
  800618:	000ae683          	lwu	a3,0(s5)
  80061c:	4729                	li	a4,10
  80061e:	8ab2                	mv	s5,a2
  800620:	bd1d                	j	800456 <vprintfmt+0x156>
  800622:	000ae683          	lwu	a3,0(s5)
  800626:	4741                	li	a4,16
  800628:	8ab2                	mv	s5,a2
  80062a:	b535                	j	800456 <vprintfmt+0x156>
  80062c:	9982                	jalr	s3
  80062e:	b709                	j	800530 <vprintfmt+0x230>
  800630:	864a                	mv	a2,s2
  800632:	85a6                	mv	a1,s1
  800634:	02d00513          	li	a0,45
  800638:	e042                	sd	a6,0(sp)
  80063a:	9982                	jalr	s3
  80063c:	6802                	ld	a6,0(sp)
  80063e:	8aea                	mv	s5,s10
  800640:	408006b3          	neg	a3,s0
  800644:	4729                	li	a4,10
  800646:	bd01                	j	800456 <vprintfmt+0x156>
  800648:	03805163          	blez	s8,80066a <vprintfmt+0x36a>
  80064c:	02d00693          	li	a3,45
  800650:	f6d81be3          	bne	a6,a3,8005c6 <vprintfmt+0x2c6>
  800654:	00000417          	auipc	s0,0x0
  800658:	1e440413          	addi	s0,s0,484 # 800838 <main+0x148>
  80065c:	02800693          	li	a3,40
  800660:	02800513          	li	a0,40
  800664:	00140a93          	addi	s5,s0,1
  800668:	b55d                	j	80050e <vprintfmt+0x20e>
  80066a:	00000a97          	auipc	s5,0x0
  80066e:	1cfa8a93          	addi	s5,s5,463 # 800839 <main+0x149>
  800672:	02800513          	li	a0,40
  800676:	02800693          	li	a3,40
  80067a:	05e00413          	li	s0,94
  80067e:	bd51                	j	800512 <vprintfmt+0x212>

0000000000800680 <printfmt>:
  800680:	7139                	addi	sp,sp,-64
  800682:	02010313          	addi	t1,sp,32
  800686:	f03a                	sd	a4,32(sp)
  800688:	871a                	mv	a4,t1
  80068a:	ec06                	sd	ra,24(sp)
  80068c:	f43e                	sd	a5,40(sp)
  80068e:	f842                	sd	a6,48(sp)
  800690:	fc46                	sd	a7,56(sp)
  800692:	e41a                	sd	t1,8(sp)
  800694:	c6dff0ef          	jal	ra,800300 <vprintfmt>
  800698:	60e2                	ld	ra,24(sp)
  80069a:	6121                	addi	sp,sp,64
  80069c:	8082                	ret

000000000080069e <strnlen>:
  80069e:	4781                	li	a5,0
  8006a0:	e589                	bnez	a1,8006aa <strnlen+0xc>
  8006a2:	a811                	j	8006b6 <strnlen+0x18>
  8006a4:	0785                	addi	a5,a5,1
  8006a6:	00f58863          	beq	a1,a5,8006b6 <strnlen+0x18>
  8006aa:	00f50733          	add	a4,a0,a5
  8006ae:	00074703          	lbu	a4,0(a4)
  8006b2:	fb6d                	bnez	a4,8006a4 <strnlen+0x6>
  8006b4:	85be                	mv	a1,a5
  8006b6:	852e                	mv	a0,a1
  8006b8:	8082                	ret

00000000008006ba <sleepy>:
  8006ba:	1101                	addi	sp,sp,-32
  8006bc:	e822                	sd	s0,16(sp)
  8006be:	e426                	sd	s1,8(sp)
  8006c0:	e04a                	sd	s2,0(sp)
  8006c2:	ec06                	sd	ra,24(sp)
  8006c4:	4401                	li	s0,0
  8006c6:	00000917          	auipc	s2,0x0
  8006ca:	58a90913          	addi	s2,s2,1418 # 800c50 <error_string+0xc8>
  8006ce:	44a9                	li	s1,10
  8006d0:	06400513          	li	a0,100
  8006d4:	af9ff0ef          	jal	ra,8001cc <sleep>
  8006d8:	2405                	addiw	s0,s0,1
  8006da:	06400613          	li	a2,100
  8006de:	85a2                	mv	a1,s0
  8006e0:	854a                	mv	a0,s2
  8006e2:	a1dff0ef          	jal	ra,8000fe <cprintf>
  8006e6:	fe9415e3          	bne	s0,s1,8006d0 <sleepy+0x16>
  8006ea:	4501                	li	a0,0
  8006ec:	ac5ff0ef          	jal	ra,8001b0 <exit>

00000000008006f0 <main>:
  8006f0:	1101                	addi	sp,sp,-32
  8006f2:	e822                	sd	s0,16(sp)
  8006f4:	ec06                	sd	ra,24(sp)
  8006f6:	ad5ff0ef          	jal	ra,8001ca <gettime_msec>
  8006fa:	0005041b          	sext.w	s0,a0
  8006fe:	ac9ff0ef          	jal	ra,8001c6 <fork>
  800702:	cd21                	beqz	a0,80075a <main+0x6a>
  800704:	006c                	addi	a1,sp,12
  800706:	ac3ff0ef          	jal	ra,8001c8 <waitpid>
  80070a:	47b2                	lw	a5,12(sp)
  80070c:	8fc9                	or	a5,a5,a0
  80070e:	2781                	sext.w	a5,a5
  800710:	e795                	bnez	a5,80073c <main+0x4c>
  800712:	ab9ff0ef          	jal	ra,8001ca <gettime_msec>
  800716:	408505bb          	subw	a1,a0,s0
  80071a:	00000517          	auipc	a0,0x0
  80071e:	5ae50513          	addi	a0,a0,1454 # 800cc8 <error_string+0x140>
  800722:	9ddff0ef          	jal	ra,8000fe <cprintf>
  800726:	00000517          	auipc	a0,0x0
  80072a:	5ba50513          	addi	a0,a0,1466 # 800ce0 <error_string+0x158>
  80072e:	9d1ff0ef          	jal	ra,8000fe <cprintf>
  800732:	60e2                	ld	ra,24(sp)
  800734:	6442                	ld	s0,16(sp)
  800736:	4501                	li	a0,0
  800738:	6105                	addi	sp,sp,32
  80073a:	8082                	ret
  80073c:	00000697          	auipc	a3,0x0
  800740:	52c68693          	addi	a3,a3,1324 # 800c68 <error_string+0xe0>
  800744:	00000617          	auipc	a2,0x0
  800748:	55c60613          	addi	a2,a2,1372 # 800ca0 <error_string+0x118>
  80074c:	45dd                	li	a1,23
  80074e:	00000517          	auipc	a0,0x0
  800752:	56a50513          	addi	a0,a0,1386 # 800cb8 <error_string+0x130>
  800756:	8e3ff0ef          	jal	ra,800038 <__panic>
  80075a:	f61ff0ef          	jal	ra,8006ba <sleepy>
