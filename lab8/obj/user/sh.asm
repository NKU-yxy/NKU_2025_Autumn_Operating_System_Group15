
obj/__user_sh.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	ac11                	j	800238 <sys_open>

0000000000800026 <close>:
  800026:	ac31                	j	800242 <sys_close>

0000000000800028 <read>:
  800028:	a40d                	j	80024a <sys_read>

000000000080002a <write>:
  80002a:	a435                	j	800256 <sys_write>

000000000080002c <dup2>:
  80002c:	ac1d                	j	800262 <sys_dup>

000000000080002e <_start>:
  80002e:	00002197          	auipc	gp,0x2
  800032:	7d218193          	addi	gp,gp,2002 # 802800 <__global_pointer$>
  800036:	2ae000ef          	jal	ra,8002e4 <umain>
  80003a:	a001                	j	80003a <_start+0xc>

000000000080003c <__panic>:
  80003c:	715d                	addi	sp,sp,-80
  80003e:	8e2e                	mv	t3,a1
  800040:	e822                	sd	s0,16(sp)
  800042:	85aa                	mv	a1,a0
  800044:	8432                	mv	s0,a2
  800046:	fc3e                	sd	a5,56(sp)
  800048:	8672                	mv	a2,t3
  80004a:	103c                	addi	a5,sp,40
  80004c:	00001517          	auipc	a0,0x1
  800050:	d1c50513          	addi	a0,a0,-740 # 800d68 <main+0xce>
  800054:	ec06                	sd	ra,24(sp)
  800056:	f436                	sd	a3,40(sp)
  800058:	f83a                	sd	a4,48(sp)
  80005a:	e0c2                	sd	a6,64(sp)
  80005c:	e4c6                	sd	a7,72(sp)
  80005e:	e43e                	sd	a5,8(sp)
  800060:	0cc000ef          	jal	ra,80012c <cprintf>
  800064:	65a2                	ld	a1,8(sp)
  800066:	8522                	mv	a0,s0
  800068:	09e000ef          	jal	ra,800106 <vcprintf>
  80006c:	00001517          	auipc	a0,0x1
  800070:	d7450513          	addi	a0,a0,-652 # 800de0 <main+0x146>
  800074:	0b8000ef          	jal	ra,80012c <cprintf>
  800078:	5559                	li	a0,-10
  80007a:	1f2000ef          	jal	ra,80026c <exit>

000000000080007e <__warn>:
  80007e:	715d                	addi	sp,sp,-80
  800080:	832e                	mv	t1,a1
  800082:	e822                	sd	s0,16(sp)
  800084:	85aa                	mv	a1,a0
  800086:	8432                	mv	s0,a2
  800088:	fc3e                	sd	a5,56(sp)
  80008a:	861a                	mv	a2,t1
  80008c:	103c                	addi	a5,sp,40
  80008e:	00001517          	auipc	a0,0x1
  800092:	cfa50513          	addi	a0,a0,-774 # 800d88 <main+0xee>
  800096:	ec06                	sd	ra,24(sp)
  800098:	f436                	sd	a3,40(sp)
  80009a:	f83a                	sd	a4,48(sp)
  80009c:	e0c2                	sd	a6,64(sp)
  80009e:	e4c6                	sd	a7,72(sp)
  8000a0:	e43e                	sd	a5,8(sp)
  8000a2:	08a000ef          	jal	ra,80012c <cprintf>
  8000a6:	65a2                	ld	a1,8(sp)
  8000a8:	8522                	mv	a0,s0
  8000aa:	05c000ef          	jal	ra,800106 <vcprintf>
  8000ae:	00001517          	auipc	a0,0x1
  8000b2:	d3250513          	addi	a0,a0,-718 # 800de0 <main+0x146>
  8000b6:	076000ef          	jal	ra,80012c <cprintf>
  8000ba:	60e2                	ld	ra,24(sp)
  8000bc:	6442                	ld	s0,16(sp)
  8000be:	6161                	addi	sp,sp,80
  8000c0:	8082                	ret

00000000008000c2 <cputch>:
  8000c2:	1141                	addi	sp,sp,-16
  8000c4:	e022                	sd	s0,0(sp)
  8000c6:	e406                	sd	ra,8(sp)
  8000c8:	842e                	mv	s0,a1
  8000ca:	15e000ef          	jal	ra,800228 <sys_putc>
  8000ce:	401c                	lw	a5,0(s0)
  8000d0:	60a2                	ld	ra,8(sp)
  8000d2:	2785                	addiw	a5,a5,1
  8000d4:	c01c                	sw	a5,0(s0)
  8000d6:	6402                	ld	s0,0(sp)
  8000d8:	0141                	addi	sp,sp,16
  8000da:	8082                	ret

00000000008000dc <fputch>:
  8000dc:	1101                	addi	sp,sp,-32
  8000de:	8732                	mv	a4,a2
  8000e0:	e822                	sd	s0,16(sp)
  8000e2:	87aa                	mv	a5,a0
  8000e4:	842e                	mv	s0,a1
  8000e6:	4605                	li	a2,1
  8000e8:	00f10593          	addi	a1,sp,15
  8000ec:	853a                	mv	a0,a4
  8000ee:	ec06                	sd	ra,24(sp)
  8000f0:	00f107a3          	sb	a5,15(sp)
  8000f4:	f37ff0ef          	jal	ra,80002a <write>
  8000f8:	401c                	lw	a5,0(s0)
  8000fa:	60e2                	ld	ra,24(sp)
  8000fc:	2785                	addiw	a5,a5,1
  8000fe:	c01c                	sw	a5,0(s0)
  800100:	6442                	ld	s0,16(sp)
  800102:	6105                	addi	sp,sp,32
  800104:	8082                	ret

0000000000800106 <vcprintf>:
  800106:	1101                	addi	sp,sp,-32
  800108:	872e                	mv	a4,a1
  80010a:	75dd                	lui	a1,0xffff7
  80010c:	86aa                	mv	a3,a0
  80010e:	0070                	addi	a2,sp,12
  800110:	00000517          	auipc	a0,0x0
  800114:	fb250513          	addi	a0,a0,-78 # 8000c2 <cputch>
  800118:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <shcwd+0xffffffffff7f29d1>
  80011c:	ec06                	sd	ra,24(sp)
  80011e:	c602                	sw	zero,12(sp)
  800120:	2c8000ef          	jal	ra,8003e8 <vprintfmt>
  800124:	60e2                	ld	ra,24(sp)
  800126:	4532                	lw	a0,12(sp)
  800128:	6105                	addi	sp,sp,32
  80012a:	8082                	ret

000000000080012c <cprintf>:
  80012c:	711d                	addi	sp,sp,-96
  80012e:	02810313          	addi	t1,sp,40
  800132:	8e2a                	mv	t3,a0
  800134:	f42e                	sd	a1,40(sp)
  800136:	75dd                	lui	a1,0xffff7
  800138:	f832                	sd	a2,48(sp)
  80013a:	fc36                	sd	a3,56(sp)
  80013c:	e0ba                	sd	a4,64(sp)
  80013e:	00000517          	auipc	a0,0x0
  800142:	f8450513          	addi	a0,a0,-124 # 8000c2 <cputch>
  800146:	0050                	addi	a2,sp,4
  800148:	871a                	mv	a4,t1
  80014a:	86f2                	mv	a3,t3
  80014c:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <shcwd+0xffffffffff7f29d1>
  800150:	ec06                	sd	ra,24(sp)
  800152:	e4be                	sd	a5,72(sp)
  800154:	e8c2                	sd	a6,80(sp)
  800156:	ecc6                	sd	a7,88(sp)
  800158:	e41a                	sd	t1,8(sp)
  80015a:	c202                	sw	zero,4(sp)
  80015c:	28c000ef          	jal	ra,8003e8 <vprintfmt>
  800160:	60e2                	ld	ra,24(sp)
  800162:	4512                	lw	a0,4(sp)
  800164:	6125                	addi	sp,sp,96
  800166:	8082                	ret

0000000000800168 <cputs>:
  800168:	1101                	addi	sp,sp,-32
  80016a:	e822                	sd	s0,16(sp)
  80016c:	ec06                	sd	ra,24(sp)
  80016e:	e426                	sd	s1,8(sp)
  800170:	842a                	mv	s0,a0
  800172:	00054503          	lbu	a0,0(a0)
  800176:	c51d                	beqz	a0,8001a4 <cputs+0x3c>
  800178:	0405                	addi	s0,s0,1
  80017a:	4485                	li	s1,1
  80017c:	9c81                	subw	s1,s1,s0
  80017e:	0aa000ef          	jal	ra,800228 <sys_putc>
  800182:	00044503          	lbu	a0,0(s0)
  800186:	008487bb          	addw	a5,s1,s0
  80018a:	0405                	addi	s0,s0,1
  80018c:	f96d                	bnez	a0,80017e <cputs+0x16>
  80018e:	0017841b          	addiw	s0,a5,1
  800192:	4529                	li	a0,10
  800194:	094000ef          	jal	ra,800228 <sys_putc>
  800198:	60e2                	ld	ra,24(sp)
  80019a:	8522                	mv	a0,s0
  80019c:	6442                	ld	s0,16(sp)
  80019e:	64a2                	ld	s1,8(sp)
  8001a0:	6105                	addi	sp,sp,32
  8001a2:	8082                	ret
  8001a4:	4405                	li	s0,1
  8001a6:	b7f5                	j	800192 <cputs+0x2a>

00000000008001a8 <fprintf>:
  8001a8:	715d                	addi	sp,sp,-80
  8001aa:	02010313          	addi	t1,sp,32
  8001ae:	8e2a                	mv	t3,a0
  8001b0:	f032                	sd	a2,32(sp)
  8001b2:	f436                	sd	a3,40(sp)
  8001b4:	f83a                	sd	a4,48(sp)
  8001b6:	00000517          	auipc	a0,0x0
  8001ba:	f2650513          	addi	a0,a0,-218 # 8000dc <fputch>
  8001be:	86ae                	mv	a3,a1
  8001c0:	0050                	addi	a2,sp,4
  8001c2:	871a                	mv	a4,t1
  8001c4:	85f2                	mv	a1,t3
  8001c6:	ec06                	sd	ra,24(sp)
  8001c8:	fc3e                	sd	a5,56(sp)
  8001ca:	e0c2                	sd	a6,64(sp)
  8001cc:	e4c6                	sd	a7,72(sp)
  8001ce:	e41a                	sd	t1,8(sp)
  8001d0:	c202                	sw	zero,4(sp)
  8001d2:	216000ef          	jal	ra,8003e8 <vprintfmt>
  8001d6:	60e2                	ld	ra,24(sp)
  8001d8:	4512                	lw	a0,4(sp)
  8001da:	6161                	addi	sp,sp,80
  8001dc:	8082                	ret

00000000008001de <syscall>:
  8001de:	7175                	addi	sp,sp,-144
  8001e0:	f8ba                	sd	a4,112(sp)
  8001e2:	e0ba                	sd	a4,64(sp)
  8001e4:	0118                	addi	a4,sp,128
  8001e6:	e42a                	sd	a0,8(sp)
  8001e8:	ecae                	sd	a1,88(sp)
  8001ea:	f0b2                	sd	a2,96(sp)
  8001ec:	f4b6                	sd	a3,104(sp)
  8001ee:	fcbe                	sd	a5,120(sp)
  8001f0:	e142                	sd	a6,128(sp)
  8001f2:	e546                	sd	a7,136(sp)
  8001f4:	f42e                	sd	a1,40(sp)
  8001f6:	f832                	sd	a2,48(sp)
  8001f8:	fc36                	sd	a3,56(sp)
  8001fa:	f03a                	sd	a4,32(sp)
  8001fc:	e4be                	sd	a5,72(sp)
  8001fe:	4522                	lw	a0,8(sp)
  800200:	55a2                	lw	a1,40(sp)
  800202:	5642                	lw	a2,48(sp)
  800204:	56e2                	lw	a3,56(sp)
  800206:	4706                	lw	a4,64(sp)
  800208:	47a6                	lw	a5,72(sp)
  80020a:	00000073          	ecall
  80020e:	ce2a                	sw	a0,28(sp)
  800210:	4572                	lw	a0,28(sp)
  800212:	6149                	addi	sp,sp,144
  800214:	8082                	ret

0000000000800216 <sys_exit>:
  800216:	85aa                	mv	a1,a0
  800218:	4505                	li	a0,1
  80021a:	b7d1                	j	8001de <syscall>

000000000080021c <sys_fork>:
  80021c:	4509                	li	a0,2
  80021e:	b7c1                	j	8001de <syscall>

0000000000800220 <sys_wait>:
  800220:	862e                	mv	a2,a1
  800222:	85aa                	mv	a1,a0
  800224:	450d                	li	a0,3
  800226:	bf65                	j	8001de <syscall>

0000000000800228 <sys_putc>:
  800228:	85aa                	mv	a1,a0
  80022a:	4579                	li	a0,30
  80022c:	bf4d                	j	8001de <syscall>

000000000080022e <sys_exec>:
  80022e:	86b2                	mv	a3,a2
  800230:	862e                	mv	a2,a1
  800232:	85aa                	mv	a1,a0
  800234:	4511                	li	a0,4
  800236:	b765                	j	8001de <syscall>

0000000000800238 <sys_open>:
  800238:	862e                	mv	a2,a1
  80023a:	85aa                	mv	a1,a0
  80023c:	06400513          	li	a0,100
  800240:	bf79                	j	8001de <syscall>

0000000000800242 <sys_close>:
  800242:	85aa                	mv	a1,a0
  800244:	06500513          	li	a0,101
  800248:	bf59                	j	8001de <syscall>

000000000080024a <sys_read>:
  80024a:	86b2                	mv	a3,a2
  80024c:	862e                	mv	a2,a1
  80024e:	85aa                	mv	a1,a0
  800250:	06600513          	li	a0,102
  800254:	b769                	j	8001de <syscall>

0000000000800256 <sys_write>:
  800256:	86b2                	mv	a3,a2
  800258:	862e                	mv	a2,a1
  80025a:	85aa                	mv	a1,a0
  80025c:	06700513          	li	a0,103
  800260:	bfbd                	j	8001de <syscall>

0000000000800262 <sys_dup>:
  800262:	862e                	mv	a2,a1
  800264:	85aa                	mv	a1,a0
  800266:	08200513          	li	a0,130
  80026a:	bf95                	j	8001de <syscall>

000000000080026c <exit>:
  80026c:	1141                	addi	sp,sp,-16
  80026e:	e406                	sd	ra,8(sp)
  800270:	fa7ff0ef          	jal	ra,800216 <sys_exit>
  800274:	00001517          	auipc	a0,0x1
  800278:	b3450513          	addi	a0,a0,-1228 # 800da8 <main+0x10e>
  80027c:	eb1ff0ef          	jal	ra,80012c <cprintf>
  800280:	a001                	j	800280 <exit+0x14>

0000000000800282 <fork>:
  800282:	bf69                	j	80021c <sys_fork>

0000000000800284 <waitpid>:
  800284:	bf71                	j	800220 <sys_wait>

0000000000800286 <__exec>:
  800286:	619c                	ld	a5,0(a1)
  800288:	862e                	mv	a2,a1
  80028a:	cb89                	beqz	a5,80029c <__exec+0x16>
  80028c:	00858793          	addi	a5,a1,8
  800290:	4581                	li	a1,0
  800292:	6398                	ld	a4,0(a5)
  800294:	2585                	addiw	a1,a1,1
  800296:	07a1                	addi	a5,a5,8
  800298:	ff6d                	bnez	a4,800292 <__exec+0xc>
  80029a:	bf51                	j	80022e <sys_exec>
  80029c:	4581                	li	a1,0
  80029e:	bf41                	j	80022e <sys_exec>

00000000008002a0 <initfd>:
  8002a0:	1101                	addi	sp,sp,-32
  8002a2:	87ae                	mv	a5,a1
  8002a4:	e426                	sd	s1,8(sp)
  8002a6:	85b2                	mv	a1,a2
  8002a8:	84aa                	mv	s1,a0
  8002aa:	853e                	mv	a0,a5
  8002ac:	e822                	sd	s0,16(sp)
  8002ae:	ec06                	sd	ra,24(sp)
  8002b0:	d71ff0ef          	jal	ra,800020 <open>
  8002b4:	842a                	mv	s0,a0
  8002b6:	00054463          	bltz	a0,8002be <initfd+0x1e>
  8002ba:	00951863          	bne	a0,s1,8002ca <initfd+0x2a>
  8002be:	60e2                	ld	ra,24(sp)
  8002c0:	8522                	mv	a0,s0
  8002c2:	6442                	ld	s0,16(sp)
  8002c4:	64a2                	ld	s1,8(sp)
  8002c6:	6105                	addi	sp,sp,32
  8002c8:	8082                	ret
  8002ca:	8526                	mv	a0,s1
  8002cc:	d5bff0ef          	jal	ra,800026 <close>
  8002d0:	85a6                	mv	a1,s1
  8002d2:	8522                	mv	a0,s0
  8002d4:	d59ff0ef          	jal	ra,80002c <dup2>
  8002d8:	84aa                	mv	s1,a0
  8002da:	8522                	mv	a0,s0
  8002dc:	d4bff0ef          	jal	ra,800026 <close>
  8002e0:	8426                	mv	s0,s1
  8002e2:	bff1                	j	8002be <initfd+0x1e>

00000000008002e4 <umain>:
  8002e4:	1101                	addi	sp,sp,-32
  8002e6:	e822                	sd	s0,16(sp)
  8002e8:	e426                	sd	s1,8(sp)
  8002ea:	842a                	mv	s0,a0
  8002ec:	84ae                	mv	s1,a1
  8002ee:	4601                	li	a2,0
  8002f0:	00001597          	auipc	a1,0x1
  8002f4:	ad058593          	addi	a1,a1,-1328 # 800dc0 <main+0x126>
  8002f8:	4501                	li	a0,0
  8002fa:	ec06                	sd	ra,24(sp)
  8002fc:	fa5ff0ef          	jal	ra,8002a0 <initfd>
  800300:	02054263          	bltz	a0,800324 <umain+0x40>
  800304:	4605                	li	a2,1
  800306:	00001597          	auipc	a1,0x1
  80030a:	afa58593          	addi	a1,a1,-1286 # 800e00 <main+0x166>
  80030e:	4505                	li	a0,1
  800310:	f91ff0ef          	jal	ra,8002a0 <initfd>
  800314:	02054563          	bltz	a0,80033e <umain+0x5a>
  800318:	85a6                	mv	a1,s1
  80031a:	8522                	mv	a0,s0
  80031c:	17f000ef          	jal	ra,800c9a <main>
  800320:	f4dff0ef          	jal	ra,80026c <exit>
  800324:	86aa                	mv	a3,a0
  800326:	00001617          	auipc	a2,0x1
  80032a:	aa260613          	addi	a2,a2,-1374 # 800dc8 <main+0x12e>
  80032e:	45e9                	li	a1,26
  800330:	00001517          	auipc	a0,0x1
  800334:	ab850513          	addi	a0,a0,-1352 # 800de8 <main+0x14e>
  800338:	d47ff0ef          	jal	ra,80007e <__warn>
  80033c:	b7e1                	j	800304 <umain+0x20>
  80033e:	86aa                	mv	a3,a0
  800340:	00001617          	auipc	a2,0x1
  800344:	ac860613          	addi	a2,a2,-1336 # 800e08 <main+0x16e>
  800348:	45f5                	li	a1,29
  80034a:	00001517          	auipc	a0,0x1
  80034e:	a9e50513          	addi	a0,a0,-1378 # 800de8 <main+0x14e>
  800352:	d2dff0ef          	jal	ra,80007e <__warn>
  800356:	b7c9                	j	800318 <umain+0x34>

0000000000800358 <printnum>:
  800358:	02071893          	slli	a7,a4,0x20
  80035c:	7139                	addi	sp,sp,-64
  80035e:	0208d893          	srli	a7,a7,0x20
  800362:	e456                	sd	s5,8(sp)
  800364:	0316fab3          	remu	s5,a3,a7
  800368:	f822                	sd	s0,48(sp)
  80036a:	f426                	sd	s1,40(sp)
  80036c:	f04a                	sd	s2,32(sp)
  80036e:	ec4e                	sd	s3,24(sp)
  800370:	fc06                	sd	ra,56(sp)
  800372:	e852                	sd	s4,16(sp)
  800374:	84aa                	mv	s1,a0
  800376:	89ae                	mv	s3,a1
  800378:	8932                	mv	s2,a2
  80037a:	fff7841b          	addiw	s0,a5,-1
  80037e:	2a81                	sext.w	s5,s5
  800380:	0516f163          	bgeu	a3,a7,8003c2 <printnum+0x6a>
  800384:	8a42                	mv	s4,a6
  800386:	00805863          	blez	s0,800396 <printnum+0x3e>
  80038a:	347d                	addiw	s0,s0,-1
  80038c:	864e                	mv	a2,s3
  80038e:	85ca                	mv	a1,s2
  800390:	8552                	mv	a0,s4
  800392:	9482                	jalr	s1
  800394:	f87d                	bnez	s0,80038a <printnum+0x32>
  800396:	1a82                	slli	s5,s5,0x20
  800398:	00001797          	auipc	a5,0x1
  80039c:	a9078793          	addi	a5,a5,-1392 # 800e28 <main+0x18e>
  8003a0:	020ada93          	srli	s5,s5,0x20
  8003a4:	9abe                	add	s5,s5,a5
  8003a6:	7442                	ld	s0,48(sp)
  8003a8:	000ac503          	lbu	a0,0(s5)
  8003ac:	70e2                	ld	ra,56(sp)
  8003ae:	6a42                	ld	s4,16(sp)
  8003b0:	6aa2                	ld	s5,8(sp)
  8003b2:	864e                	mv	a2,s3
  8003b4:	85ca                	mv	a1,s2
  8003b6:	69e2                	ld	s3,24(sp)
  8003b8:	7902                	ld	s2,32(sp)
  8003ba:	87a6                	mv	a5,s1
  8003bc:	74a2                	ld	s1,40(sp)
  8003be:	6121                	addi	sp,sp,64
  8003c0:	8782                	jr	a5
  8003c2:	0316d6b3          	divu	a3,a3,a7
  8003c6:	87a2                	mv	a5,s0
  8003c8:	f91ff0ef          	jal	ra,800358 <printnum>
  8003cc:	b7e9                	j	800396 <printnum+0x3e>

00000000008003ce <sprintputch>:
  8003ce:	499c                	lw	a5,16(a1)
  8003d0:	6198                	ld	a4,0(a1)
  8003d2:	6594                	ld	a3,8(a1)
  8003d4:	2785                	addiw	a5,a5,1
  8003d6:	c99c                	sw	a5,16(a1)
  8003d8:	00d77763          	bgeu	a4,a3,8003e6 <sprintputch+0x18>
  8003dc:	00170793          	addi	a5,a4,1
  8003e0:	e19c                	sd	a5,0(a1)
  8003e2:	00a70023          	sb	a0,0(a4)
  8003e6:	8082                	ret

00000000008003e8 <vprintfmt>:
  8003e8:	7119                	addi	sp,sp,-128
  8003ea:	f4a6                	sd	s1,104(sp)
  8003ec:	f0ca                	sd	s2,96(sp)
  8003ee:	ecce                	sd	s3,88(sp)
  8003f0:	e8d2                	sd	s4,80(sp)
  8003f2:	e4d6                	sd	s5,72(sp)
  8003f4:	e0da                	sd	s6,64(sp)
  8003f6:	fc5e                	sd	s7,56(sp)
  8003f8:	ec6e                	sd	s11,24(sp)
  8003fa:	fc86                	sd	ra,120(sp)
  8003fc:	f8a2                	sd	s0,112(sp)
  8003fe:	f862                	sd	s8,48(sp)
  800400:	f466                	sd	s9,40(sp)
  800402:	f06a                	sd	s10,32(sp)
  800404:	89aa                	mv	s3,a0
  800406:	892e                	mv	s2,a1
  800408:	84b2                	mv	s1,a2
  80040a:	8db6                	mv	s11,a3
  80040c:	8aba                	mv	s5,a4
  80040e:	02500a13          	li	s4,37
  800412:	5bfd                	li	s7,-1
  800414:	00001b17          	auipc	s6,0x1
  800418:	a48b0b13          	addi	s6,s6,-1464 # 800e5c <main+0x1c2>
  80041c:	000dc503          	lbu	a0,0(s11)
  800420:	001d8413          	addi	s0,s11,1
  800424:	01450b63          	beq	a0,s4,80043a <vprintfmt+0x52>
  800428:	c129                	beqz	a0,80046a <vprintfmt+0x82>
  80042a:	864a                	mv	a2,s2
  80042c:	85a6                	mv	a1,s1
  80042e:	0405                	addi	s0,s0,1
  800430:	9982                	jalr	s3
  800432:	fff44503          	lbu	a0,-1(s0)
  800436:	ff4519e3          	bne	a0,s4,800428 <vprintfmt+0x40>
  80043a:	00044583          	lbu	a1,0(s0)
  80043e:	02000813          	li	a6,32
  800442:	4d01                	li	s10,0
  800444:	4301                	li	t1,0
  800446:	5cfd                	li	s9,-1
  800448:	5c7d                	li	s8,-1
  80044a:	05500513          	li	a0,85
  80044e:	48a5                	li	a7,9
  800450:	fdd5861b          	addiw	a2,a1,-35
  800454:	0ff67613          	zext.b	a2,a2
  800458:	00140d93          	addi	s11,s0,1
  80045c:	04c56263          	bltu	a0,a2,8004a0 <vprintfmt+0xb8>
  800460:	060a                	slli	a2,a2,0x2
  800462:	965a                	add	a2,a2,s6
  800464:	4214                	lw	a3,0(a2)
  800466:	96da                	add	a3,a3,s6
  800468:	8682                	jr	a3
  80046a:	70e6                	ld	ra,120(sp)
  80046c:	7446                	ld	s0,112(sp)
  80046e:	74a6                	ld	s1,104(sp)
  800470:	7906                	ld	s2,96(sp)
  800472:	69e6                	ld	s3,88(sp)
  800474:	6a46                	ld	s4,80(sp)
  800476:	6aa6                	ld	s5,72(sp)
  800478:	6b06                	ld	s6,64(sp)
  80047a:	7be2                	ld	s7,56(sp)
  80047c:	7c42                	ld	s8,48(sp)
  80047e:	7ca2                	ld	s9,40(sp)
  800480:	7d02                	ld	s10,32(sp)
  800482:	6de2                	ld	s11,24(sp)
  800484:	6109                	addi	sp,sp,128
  800486:	8082                	ret
  800488:	882e                	mv	a6,a1
  80048a:	00144583          	lbu	a1,1(s0)
  80048e:	846e                	mv	s0,s11
  800490:	00140d93          	addi	s11,s0,1
  800494:	fdd5861b          	addiw	a2,a1,-35
  800498:	0ff67613          	zext.b	a2,a2
  80049c:	fcc572e3          	bgeu	a0,a2,800460 <vprintfmt+0x78>
  8004a0:	864a                	mv	a2,s2
  8004a2:	85a6                	mv	a1,s1
  8004a4:	02500513          	li	a0,37
  8004a8:	9982                	jalr	s3
  8004aa:	fff44783          	lbu	a5,-1(s0)
  8004ae:	8da2                	mv	s11,s0
  8004b0:	f74786e3          	beq	a5,s4,80041c <vprintfmt+0x34>
  8004b4:	ffedc783          	lbu	a5,-2(s11)
  8004b8:	1dfd                	addi	s11,s11,-1
  8004ba:	ff479de3          	bne	a5,s4,8004b4 <vprintfmt+0xcc>
  8004be:	bfb9                	j	80041c <vprintfmt+0x34>
  8004c0:	fd058c9b          	addiw	s9,a1,-48
  8004c4:	00144583          	lbu	a1,1(s0)
  8004c8:	846e                	mv	s0,s11
  8004ca:	fd05869b          	addiw	a3,a1,-48
  8004ce:	0005861b          	sext.w	a2,a1
  8004d2:	02d8e463          	bltu	a7,a3,8004fa <vprintfmt+0x112>
  8004d6:	00144583          	lbu	a1,1(s0)
  8004da:	002c969b          	slliw	a3,s9,0x2
  8004de:	0196873b          	addw	a4,a3,s9
  8004e2:	0017171b          	slliw	a4,a4,0x1
  8004e6:	9f31                	addw	a4,a4,a2
  8004e8:	fd05869b          	addiw	a3,a1,-48
  8004ec:	0405                	addi	s0,s0,1
  8004ee:	fd070c9b          	addiw	s9,a4,-48
  8004f2:	0005861b          	sext.w	a2,a1
  8004f6:	fed8f0e3          	bgeu	a7,a3,8004d6 <vprintfmt+0xee>
  8004fa:	f40c5be3          	bgez	s8,800450 <vprintfmt+0x68>
  8004fe:	8c66                	mv	s8,s9
  800500:	5cfd                	li	s9,-1
  800502:	b7b9                	j	800450 <vprintfmt+0x68>
  800504:	fffc4693          	not	a3,s8
  800508:	96fd                	srai	a3,a3,0x3f
  80050a:	00dc77b3          	and	a5,s8,a3
  80050e:	00144583          	lbu	a1,1(s0)
  800512:	00078c1b          	sext.w	s8,a5
  800516:	846e                	mv	s0,s11
  800518:	bf25                	j	800450 <vprintfmt+0x68>
  80051a:	000aac83          	lw	s9,0(s5)
  80051e:	00144583          	lbu	a1,1(s0)
  800522:	0aa1                	addi	s5,s5,8
  800524:	846e                	mv	s0,s11
  800526:	bfd1                	j	8004fa <vprintfmt+0x112>
  800528:	4705                	li	a4,1
  80052a:	008a8613          	addi	a2,s5,8
  80052e:	00674463          	blt	a4,t1,800536 <vprintfmt+0x14e>
  800532:	1c030c63          	beqz	t1,80070a <vprintfmt+0x322>
  800536:	000ab683          	ld	a3,0(s5)
  80053a:	4741                	li	a4,16
  80053c:	8ab2                	mv	s5,a2
  80053e:	2801                	sext.w	a6,a6
  800540:	87e2                	mv	a5,s8
  800542:	8626                	mv	a2,s1
  800544:	85ca                	mv	a1,s2
  800546:	854e                	mv	a0,s3
  800548:	e11ff0ef          	jal	ra,800358 <printnum>
  80054c:	bdc1                	j	80041c <vprintfmt+0x34>
  80054e:	000aa503          	lw	a0,0(s5)
  800552:	864a                	mv	a2,s2
  800554:	85a6                	mv	a1,s1
  800556:	0aa1                	addi	s5,s5,8
  800558:	9982                	jalr	s3
  80055a:	b5c9                	j	80041c <vprintfmt+0x34>
  80055c:	4705                	li	a4,1
  80055e:	008a8613          	addi	a2,s5,8
  800562:	00674463          	blt	a4,t1,80056a <vprintfmt+0x182>
  800566:	18030d63          	beqz	t1,800700 <vprintfmt+0x318>
  80056a:	000ab683          	ld	a3,0(s5)
  80056e:	4729                	li	a4,10
  800570:	8ab2                	mv	s5,a2
  800572:	b7f1                	j	80053e <vprintfmt+0x156>
  800574:	00144583          	lbu	a1,1(s0)
  800578:	4d05                	li	s10,1
  80057a:	846e                	mv	s0,s11
  80057c:	bdd1                	j	800450 <vprintfmt+0x68>
  80057e:	864a                	mv	a2,s2
  800580:	85a6                	mv	a1,s1
  800582:	02500513          	li	a0,37
  800586:	9982                	jalr	s3
  800588:	bd51                	j	80041c <vprintfmt+0x34>
  80058a:	00144583          	lbu	a1,1(s0)
  80058e:	2305                	addiw	t1,t1,1
  800590:	846e                	mv	s0,s11
  800592:	bd7d                	j	800450 <vprintfmt+0x68>
  800594:	4705                	li	a4,1
  800596:	008a8613          	addi	a2,s5,8
  80059a:	00674463          	blt	a4,t1,8005a2 <vprintfmt+0x1ba>
  80059e:	14030c63          	beqz	t1,8006f6 <vprintfmt+0x30e>
  8005a2:	000ab683          	ld	a3,0(s5)
  8005a6:	4721                	li	a4,8
  8005a8:	8ab2                	mv	s5,a2
  8005aa:	bf51                	j	80053e <vprintfmt+0x156>
  8005ac:	03000513          	li	a0,48
  8005b0:	864a                	mv	a2,s2
  8005b2:	85a6                	mv	a1,s1
  8005b4:	e042                	sd	a6,0(sp)
  8005b6:	9982                	jalr	s3
  8005b8:	864a                	mv	a2,s2
  8005ba:	85a6                	mv	a1,s1
  8005bc:	07800513          	li	a0,120
  8005c0:	9982                	jalr	s3
  8005c2:	0aa1                	addi	s5,s5,8
  8005c4:	6802                	ld	a6,0(sp)
  8005c6:	4741                	li	a4,16
  8005c8:	ff8ab683          	ld	a3,-8(s5)
  8005cc:	bf8d                	j	80053e <vprintfmt+0x156>
  8005ce:	000ab403          	ld	s0,0(s5)
  8005d2:	008a8793          	addi	a5,s5,8
  8005d6:	e03e                	sd	a5,0(sp)
  8005d8:	14040c63          	beqz	s0,800730 <vprintfmt+0x348>
  8005dc:	11805063          	blez	s8,8006dc <vprintfmt+0x2f4>
  8005e0:	02d00693          	li	a3,45
  8005e4:	0cd81963          	bne	a6,a3,8006b6 <vprintfmt+0x2ce>
  8005e8:	00044683          	lbu	a3,0(s0)
  8005ec:	0006851b          	sext.w	a0,a3
  8005f0:	ce8d                	beqz	a3,80062a <vprintfmt+0x242>
  8005f2:	00140a93          	addi	s5,s0,1
  8005f6:	05e00413          	li	s0,94
  8005fa:	000cc563          	bltz	s9,800604 <vprintfmt+0x21c>
  8005fe:	3cfd                	addiw	s9,s9,-1
  800600:	037c8363          	beq	s9,s7,800626 <vprintfmt+0x23e>
  800604:	864a                	mv	a2,s2
  800606:	85a6                	mv	a1,s1
  800608:	100d0663          	beqz	s10,800714 <vprintfmt+0x32c>
  80060c:	3681                	addiw	a3,a3,-32
  80060e:	10d47363          	bgeu	s0,a3,800714 <vprintfmt+0x32c>
  800612:	03f00513          	li	a0,63
  800616:	9982                	jalr	s3
  800618:	000ac683          	lbu	a3,0(s5)
  80061c:	3c7d                	addiw	s8,s8,-1
  80061e:	0a85                	addi	s5,s5,1
  800620:	0006851b          	sext.w	a0,a3
  800624:	faf9                	bnez	a3,8005fa <vprintfmt+0x212>
  800626:	01805a63          	blez	s8,80063a <vprintfmt+0x252>
  80062a:	3c7d                	addiw	s8,s8,-1
  80062c:	864a                	mv	a2,s2
  80062e:	85a6                	mv	a1,s1
  800630:	02000513          	li	a0,32
  800634:	9982                	jalr	s3
  800636:	fe0c1ae3          	bnez	s8,80062a <vprintfmt+0x242>
  80063a:	6a82                	ld	s5,0(sp)
  80063c:	b3c5                	j	80041c <vprintfmt+0x34>
  80063e:	4705                	li	a4,1
  800640:	008a8d13          	addi	s10,s5,8
  800644:	00674463          	blt	a4,t1,80064c <vprintfmt+0x264>
  800648:	0a030463          	beqz	t1,8006f0 <vprintfmt+0x308>
  80064c:	000ab403          	ld	s0,0(s5)
  800650:	0c044463          	bltz	s0,800718 <vprintfmt+0x330>
  800654:	86a2                	mv	a3,s0
  800656:	8aea                	mv	s5,s10
  800658:	4729                	li	a4,10
  80065a:	b5d5                	j	80053e <vprintfmt+0x156>
  80065c:	000aa783          	lw	a5,0(s5)
  800660:	46e1                	li	a3,24
  800662:	0aa1                	addi	s5,s5,8
  800664:	41f7d71b          	sraiw	a4,a5,0x1f
  800668:	8fb9                	xor	a5,a5,a4
  80066a:	40e7873b          	subw	a4,a5,a4
  80066e:	02e6c663          	blt	a3,a4,80069a <vprintfmt+0x2b2>
  800672:	00371793          	slli	a5,a4,0x3
  800676:	00001697          	auipc	a3,0x1
  80067a:	b1a68693          	addi	a3,a3,-1254 # 801190 <error_string>
  80067e:	97b6                	add	a5,a5,a3
  800680:	639c                	ld	a5,0(a5)
  800682:	cf81                	beqz	a5,80069a <vprintfmt+0x2b2>
  800684:	873e                	mv	a4,a5
  800686:	00000697          	auipc	a3,0x0
  80068a:	7d268693          	addi	a3,a3,2002 # 800e58 <main+0x1be>
  80068e:	8626                	mv	a2,s1
  800690:	85ca                	mv	a1,s2
  800692:	854e                	mv	a0,s3
  800694:	0d4000ef          	jal	ra,800768 <printfmt>
  800698:	b351                	j	80041c <vprintfmt+0x34>
  80069a:	00000697          	auipc	a3,0x0
  80069e:	7ae68693          	addi	a3,a3,1966 # 800e48 <main+0x1ae>
  8006a2:	8626                	mv	a2,s1
  8006a4:	85ca                	mv	a1,s2
  8006a6:	854e                	mv	a0,s3
  8006a8:	0c0000ef          	jal	ra,800768 <printfmt>
  8006ac:	bb85                	j	80041c <vprintfmt+0x34>
  8006ae:	00000417          	auipc	s0,0x0
  8006b2:	79240413          	addi	s0,s0,1938 # 800e40 <main+0x1a6>
  8006b6:	85e6                	mv	a1,s9
  8006b8:	8522                	mv	a0,s0
  8006ba:	e442                	sd	a6,8(sp)
  8006bc:	118000ef          	jal	ra,8007d4 <strnlen>
  8006c0:	40ac0c3b          	subw	s8,s8,a0
  8006c4:	01805c63          	blez	s8,8006dc <vprintfmt+0x2f4>
  8006c8:	6822                	ld	a6,8(sp)
  8006ca:	00080a9b          	sext.w	s5,a6
  8006ce:	3c7d                	addiw	s8,s8,-1
  8006d0:	864a                	mv	a2,s2
  8006d2:	85a6                	mv	a1,s1
  8006d4:	8556                	mv	a0,s5
  8006d6:	9982                	jalr	s3
  8006d8:	fe0c1be3          	bnez	s8,8006ce <vprintfmt+0x2e6>
  8006dc:	00044683          	lbu	a3,0(s0)
  8006e0:	00140a93          	addi	s5,s0,1
  8006e4:	0006851b          	sext.w	a0,a3
  8006e8:	daa9                	beqz	a3,80063a <vprintfmt+0x252>
  8006ea:	05e00413          	li	s0,94
  8006ee:	b731                	j	8005fa <vprintfmt+0x212>
  8006f0:	000aa403          	lw	s0,0(s5)
  8006f4:	bfb1                	j	800650 <vprintfmt+0x268>
  8006f6:	000ae683          	lwu	a3,0(s5)
  8006fa:	4721                	li	a4,8
  8006fc:	8ab2                	mv	s5,a2
  8006fe:	b581                	j	80053e <vprintfmt+0x156>
  800700:	000ae683          	lwu	a3,0(s5)
  800704:	4729                	li	a4,10
  800706:	8ab2                	mv	s5,a2
  800708:	bd1d                	j	80053e <vprintfmt+0x156>
  80070a:	000ae683          	lwu	a3,0(s5)
  80070e:	4741                	li	a4,16
  800710:	8ab2                	mv	s5,a2
  800712:	b535                	j	80053e <vprintfmt+0x156>
  800714:	9982                	jalr	s3
  800716:	b709                	j	800618 <vprintfmt+0x230>
  800718:	864a                	mv	a2,s2
  80071a:	85a6                	mv	a1,s1
  80071c:	02d00513          	li	a0,45
  800720:	e042                	sd	a6,0(sp)
  800722:	9982                	jalr	s3
  800724:	6802                	ld	a6,0(sp)
  800726:	8aea                	mv	s5,s10
  800728:	408006b3          	neg	a3,s0
  80072c:	4729                	li	a4,10
  80072e:	bd01                	j	80053e <vprintfmt+0x156>
  800730:	03805163          	blez	s8,800752 <vprintfmt+0x36a>
  800734:	02d00693          	li	a3,45
  800738:	f6d81be3          	bne	a6,a3,8006ae <vprintfmt+0x2c6>
  80073c:	00000417          	auipc	s0,0x0
  800740:	70440413          	addi	s0,s0,1796 # 800e40 <main+0x1a6>
  800744:	02800693          	li	a3,40
  800748:	02800513          	li	a0,40
  80074c:	00140a93          	addi	s5,s0,1
  800750:	b55d                	j	8005f6 <vprintfmt+0x20e>
  800752:	00000a97          	auipc	s5,0x0
  800756:	6efa8a93          	addi	s5,s5,1775 # 800e41 <main+0x1a7>
  80075a:	02800513          	li	a0,40
  80075e:	02800693          	li	a3,40
  800762:	05e00413          	li	s0,94
  800766:	bd51                	j	8005fa <vprintfmt+0x212>

0000000000800768 <printfmt>:
  800768:	7139                	addi	sp,sp,-64
  80076a:	02010313          	addi	t1,sp,32
  80076e:	f03a                	sd	a4,32(sp)
  800770:	871a                	mv	a4,t1
  800772:	ec06                	sd	ra,24(sp)
  800774:	f43e                	sd	a5,40(sp)
  800776:	f842                	sd	a6,48(sp)
  800778:	fc46                	sd	a7,56(sp)
  80077a:	e41a                	sd	t1,8(sp)
  80077c:	c6dff0ef          	jal	ra,8003e8 <vprintfmt>
  800780:	60e2                	ld	ra,24(sp)
  800782:	6121                	addi	sp,sp,64
  800784:	8082                	ret

0000000000800786 <snprintf>:
  800786:	711d                	addi	sp,sp,-96
  800788:	15fd                	addi	a1,a1,-1
  80078a:	03810313          	addi	t1,sp,56
  80078e:	95aa                	add	a1,a1,a0
  800790:	f406                	sd	ra,40(sp)
  800792:	fc36                	sd	a3,56(sp)
  800794:	e0ba                	sd	a4,64(sp)
  800796:	e4be                	sd	a5,72(sp)
  800798:	e8c2                	sd	a6,80(sp)
  80079a:	ecc6                	sd	a7,88(sp)
  80079c:	e01a                	sd	t1,0(sp)
  80079e:	e42a                	sd	a0,8(sp)
  8007a0:	e82e                	sd	a1,16(sp)
  8007a2:	cc02                	sw	zero,24(sp)
  8007a4:	c515                	beqz	a0,8007d0 <snprintf+0x4a>
  8007a6:	02a5e563          	bltu	a1,a0,8007d0 <snprintf+0x4a>
  8007aa:	75dd                	lui	a1,0xffff7
  8007ac:	86b2                	mv	a3,a2
  8007ae:	00000517          	auipc	a0,0x0
  8007b2:	c2050513          	addi	a0,a0,-992 # 8003ce <sprintputch>
  8007b6:	871a                	mv	a4,t1
  8007b8:	0030                	addi	a2,sp,8
  8007ba:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <shcwd+0xffffffffff7f29d1>
  8007be:	c2bff0ef          	jal	ra,8003e8 <vprintfmt>
  8007c2:	67a2                	ld	a5,8(sp)
  8007c4:	00078023          	sb	zero,0(a5)
  8007c8:	4562                	lw	a0,24(sp)
  8007ca:	70a2                	ld	ra,40(sp)
  8007cc:	6125                	addi	sp,sp,96
  8007ce:	8082                	ret
  8007d0:	5575                	li	a0,-3
  8007d2:	bfe5                	j	8007ca <snprintf+0x44>

00000000008007d4 <strnlen>:
  8007d4:	4781                	li	a5,0
  8007d6:	e589                	bnez	a1,8007e0 <strnlen+0xc>
  8007d8:	a811                	j	8007ec <strnlen+0x18>
  8007da:	0785                	addi	a5,a5,1
  8007dc:	00f58863          	beq	a1,a5,8007ec <strnlen+0x18>
  8007e0:	00f50733          	add	a4,a0,a5
  8007e4:	00074703          	lbu	a4,0(a4)
  8007e8:	fb6d                	bnez	a4,8007da <strnlen+0x6>
  8007ea:	85be                	mv	a1,a5
  8007ec:	852e                	mv	a0,a1
  8007ee:	8082                	ret

00000000008007f0 <strcpy>:
  8007f0:	87aa                	mv	a5,a0
  8007f2:	0005c703          	lbu	a4,0(a1)
  8007f6:	0785                	addi	a5,a5,1
  8007f8:	0585                	addi	a1,a1,1
  8007fa:	fee78fa3          	sb	a4,-1(a5)
  8007fe:	fb75                	bnez	a4,8007f2 <strcpy+0x2>
  800800:	8082                	ret

0000000000800802 <strcmp>:
  800802:	00054783          	lbu	a5,0(a0)
  800806:	0005c703          	lbu	a4,0(a1)
  80080a:	cb89                	beqz	a5,80081c <strcmp+0x1a>
  80080c:	0505                	addi	a0,a0,1
  80080e:	0585                	addi	a1,a1,1
  800810:	fee789e3          	beq	a5,a4,800802 <strcmp>
  800814:	0007851b          	sext.w	a0,a5
  800818:	9d19                	subw	a0,a0,a4
  80081a:	8082                	ret
  80081c:	4501                	li	a0,0
  80081e:	bfed                	j	800818 <strcmp+0x16>

0000000000800820 <strchr>:
  800820:	00054783          	lbu	a5,0(a0)
  800824:	c799                	beqz	a5,800832 <strchr+0x12>
  800826:	00f58763          	beq	a1,a5,800834 <strchr+0x14>
  80082a:	00154783          	lbu	a5,1(a0)
  80082e:	0505                	addi	a0,a0,1
  800830:	fbfd                	bnez	a5,800826 <strchr+0x6>
  800832:	4501                	li	a0,0
  800834:	8082                	ret

0000000000800836 <gettoken>:
  800836:	7139                	addi	sp,sp,-64
  800838:	f822                	sd	s0,48(sp)
  80083a:	6100                	ld	s0,0(a0)
  80083c:	fc06                	sd	ra,56(sp)
  80083e:	f426                	sd	s1,40(sp)
  800840:	f04a                	sd	s2,32(sp)
  800842:	ec4e                	sd	s3,24(sp)
  800844:	e852                	sd	s4,16(sp)
  800846:	e456                	sd	s5,8(sp)
  800848:	e05a                	sd	s6,0(sp)
  80084a:	c405                	beqz	s0,800872 <gettoken+0x3c>
  80084c:	892a                	mv	s2,a0
  80084e:	89ae                	mv	s3,a1
  800850:	00001497          	auipc	s1,0x1
  800854:	a0848493          	addi	s1,s1,-1528 # 801258 <error_string+0xc8>
  800858:	a021                	j	800860 <gettoken+0x2a>
  80085a:	0405                	addi	s0,s0,1
  80085c:	fe040fa3          	sb	zero,-1(s0)
  800860:	00044583          	lbu	a1,0(s0)
  800864:	8526                	mv	a0,s1
  800866:	fbbff0ef          	jal	ra,800820 <strchr>
  80086a:	f965                	bnez	a0,80085a <gettoken+0x24>
  80086c:	00044783          	lbu	a5,0(s0)
  800870:	ef81                	bnez	a5,800888 <gettoken+0x52>
  800872:	4501                	li	a0,0
  800874:	70e2                	ld	ra,56(sp)
  800876:	7442                	ld	s0,48(sp)
  800878:	74a2                	ld	s1,40(sp)
  80087a:	7902                	ld	s2,32(sp)
  80087c:	69e2                	ld	s3,24(sp)
  80087e:	6a42                	ld	s4,16(sp)
  800880:	6aa2                	ld	s5,8(sp)
  800882:	6b02                	ld	s6,0(sp)
  800884:	6121                	addi	sp,sp,64
  800886:	8082                	ret
  800888:	0089b023          	sd	s0,0(s3)
  80088c:	00044583          	lbu	a1,0(s0)
  800890:	00001517          	auipc	a0,0x1
  800894:	9d050513          	addi	a0,a0,-1584 # 801260 <error_string+0xd0>
  800898:	f89ff0ef          	jal	ra,800820 <strchr>
  80089c:	84aa                	mv	s1,a0
  80089e:	c10d                	beqz	a0,8008c0 <gettoken+0x8a>
  8008a0:	00044503          	lbu	a0,0(s0)
  8008a4:	00140493          	addi	s1,s0,1
  8008a8:	00040023          	sb	zero,0(s0)
  8008ac:	0004c783          	lbu	a5,0(s1)
  8008b0:	00f037b3          	snez	a5,a5
  8008b4:	40f007b3          	neg	a5,a5
  8008b8:	8cfd                	and	s1,s1,a5
  8008ba:	00993023          	sd	s1,0(s2)
  8008be:	bf5d                	j	800874 <gettoken+0x3e>
  8008c0:	00044583          	lbu	a1,0(s0)
  8008c4:	4981                	li	s3,0
  8008c6:	00001b17          	auipc	s6,0x1
  8008ca:	9a2b0b13          	addi	s6,s6,-1630 # 801268 <error_string+0xd8>
  8008ce:	02200a13          	li	s4,34
  8008d2:	02000a93          	li	s5,32
  8008d6:	cd99                	beqz	a1,8008f4 <gettoken+0xbe>
  8008d8:	02098363          	beqz	s3,8008fe <gettoken+0xc8>
  8008dc:	00044783          	lbu	a5,0(s0)
  8008e0:	01479663          	bne	a5,s4,8008ec <gettoken+0xb6>
  8008e4:	01540023          	sb	s5,0(s0)
  8008e8:	0019c993          	xori	s3,s3,1
  8008ec:	00144583          	lbu	a1,1(s0)
  8008f0:	0405                	addi	s0,s0,1
  8008f2:	f1fd                	bnez	a1,8008d8 <gettoken+0xa2>
  8008f4:	07700513          	li	a0,119
  8008f8:	00993023          	sd	s1,0(s2)
  8008fc:	bfa5                	j	800874 <gettoken+0x3e>
  8008fe:	855a                	mv	a0,s6
  800900:	f21ff0ef          	jal	ra,800820 <strchr>
  800904:	dd61                	beqz	a0,8008dc <gettoken+0xa6>
  800906:	84a2                	mv	s1,s0
  800908:	07700513          	li	a0,119
  80090c:	b745                	j	8008ac <gettoken+0x76>

000000000080090e <readline>:
  80090e:	711d                	addi	sp,sp,-96
  800910:	ec86                	sd	ra,88(sp)
  800912:	e8a2                	sd	s0,80(sp)
  800914:	e4a6                	sd	s1,72(sp)
  800916:	e0ca                	sd	s2,64(sp)
  800918:	fc4e                	sd	s3,56(sp)
  80091a:	f852                	sd	s4,48(sp)
  80091c:	f456                	sd	s5,40(sp)
  80091e:	f05a                	sd	s6,32(sp)
  800920:	ec5e                	sd	s7,24(sp)
  800922:	c909                	beqz	a0,800934 <readline+0x26>
  800924:	862a                	mv	a2,a0
  800926:	00000597          	auipc	a1,0x0
  80092a:	53258593          	addi	a1,a1,1330 # 800e58 <main+0x1be>
  80092e:	4505                	li	a0,1
  800930:	879ff0ef          	jal	ra,8001a8 <fprintf>
  800934:	6985                	lui	s3,0x1
  800936:	4401                	li	s0,0
  800938:	448d                	li	s1,3
  80093a:	497d                	li	s2,31
  80093c:	4a21                	li	s4,8
  80093e:	4aa9                	li	s5,10
  800940:	4b35                	li	s6,13
  800942:	19f9                	addi	s3,s3,-2
  800944:	00002b97          	auipc	s7,0x2
  800948:	7c4b8b93          	addi	s7,s7,1988 # 803108 <buffer.2>
  80094c:	4605                	li	a2,1
  80094e:	00f10593          	addi	a1,sp,15
  800952:	4501                	li	a0,0
  800954:	ed4ff0ef          	jal	ra,800028 <read>
  800958:	04054163          	bltz	a0,80099a <readline+0x8c>
  80095c:	c549                	beqz	a0,8009e6 <readline+0xd8>
  80095e:	00f14603          	lbu	a2,15(sp)
  800962:	02960c63          	beq	a2,s1,80099a <readline+0x8c>
  800966:	04c97663          	bgeu	s2,a2,8009b2 <readline+0xa4>
  80096a:	fe89c1e3          	blt	s3,s0,80094c <readline+0x3e>
  80096e:	00001597          	auipc	a1,0x1
  800972:	90a58593          	addi	a1,a1,-1782 # 801278 <error_string+0xe8>
  800976:	4505                	li	a0,1
  800978:	831ff0ef          	jal	ra,8001a8 <fprintf>
  80097c:	00f14703          	lbu	a4,15(sp)
  800980:	008b87b3          	add	a5,s7,s0
  800984:	4605                	li	a2,1
  800986:	00e78023          	sb	a4,0(a5)
  80098a:	00f10593          	addi	a1,sp,15
  80098e:	4501                	li	a0,0
  800990:	2405                	addiw	s0,s0,1
  800992:	e96ff0ef          	jal	ra,800028 <read>
  800996:	fc0553e3          	bgez	a0,80095c <readline+0x4e>
  80099a:	4501                	li	a0,0
  80099c:	60e6                	ld	ra,88(sp)
  80099e:	6446                	ld	s0,80(sp)
  8009a0:	64a6                	ld	s1,72(sp)
  8009a2:	6906                	ld	s2,64(sp)
  8009a4:	79e2                	ld	s3,56(sp)
  8009a6:	7a42                	ld	s4,48(sp)
  8009a8:	7aa2                	ld	s5,40(sp)
  8009aa:	7b02                	ld	s6,32(sp)
  8009ac:	6be2                	ld	s7,24(sp)
  8009ae:	6125                	addi	sp,sp,96
  8009b0:	8082                	ret
  8009b2:	01461d63          	bne	a2,s4,8009cc <readline+0xbe>
  8009b6:	d859                	beqz	s0,80094c <readline+0x3e>
  8009b8:	4621                	li	a2,8
  8009ba:	00001597          	auipc	a1,0x1
  8009be:	8be58593          	addi	a1,a1,-1858 # 801278 <error_string+0xe8>
  8009c2:	4505                	li	a0,1
  8009c4:	fe4ff0ef          	jal	ra,8001a8 <fprintf>
  8009c8:	347d                	addiw	s0,s0,-1
  8009ca:	b749                	j	80094c <readline+0x3e>
  8009cc:	03560a63          	beq	a2,s5,800a00 <readline+0xf2>
  8009d0:	f7661ee3          	bne	a2,s6,80094c <readline+0x3e>
  8009d4:	4635                	li	a2,13
  8009d6:	00001597          	auipc	a1,0x1
  8009da:	8a258593          	addi	a1,a1,-1886 # 801278 <error_string+0xe8>
  8009de:	4505                	li	a0,1
  8009e0:	fc8ff0ef          	jal	ra,8001a8 <fprintf>
  8009e4:	a011                	j	8009e8 <readline+0xda>
  8009e6:	d855                	beqz	s0,80099a <readline+0x8c>
  8009e8:	00002797          	auipc	a5,0x2
  8009ec:	72078793          	addi	a5,a5,1824 # 803108 <buffer.2>
  8009f0:	97a2                	add	a5,a5,s0
  8009f2:	00078023          	sb	zero,0(a5)
  8009f6:	00002517          	auipc	a0,0x2
  8009fa:	71250513          	addi	a0,a0,1810 # 803108 <buffer.2>
  8009fe:	bf79                	j	80099c <readline+0x8e>
  800a00:	4629                	li	a2,10
  800a02:	bfd1                	j	8009d6 <readline+0xc8>

0000000000800a04 <reopen>:
  800a04:	1101                	addi	sp,sp,-32
  800a06:	ec06                	sd	ra,24(sp)
  800a08:	e822                	sd	s0,16(sp)
  800a0a:	e426                	sd	s1,8(sp)
  800a0c:	842e                	mv	s0,a1
  800a0e:	e04a                	sd	s2,0(sp)
  800a10:	84aa                	mv	s1,a0
  800a12:	8932                	mv	s2,a2
  800a14:	e12ff0ef          	jal	ra,800026 <close>
  800a18:	8522                	mv	a0,s0
  800a1a:	85ca                	mv	a1,s2
  800a1c:	e04ff0ef          	jal	ra,800020 <open>
  800a20:	842a                	mv	s0,a0
  800a22:	00054463          	bltz	a0,800a2a <reopen+0x26>
  800a26:	00a49e63          	bne	s1,a0,800a42 <reopen+0x3e>
  800a2a:	00142513          	slti	a0,s0,1
  800a2e:	40a0053b          	negw	a0,a0
  800a32:	60e2                	ld	ra,24(sp)
  800a34:	8d61                	and	a0,a0,s0
  800a36:	6442                	ld	s0,16(sp)
  800a38:	64a2                	ld	s1,8(sp)
  800a3a:	6902                	ld	s2,0(sp)
  800a3c:	2501                	sext.w	a0,a0
  800a3e:	6105                	addi	sp,sp,32
  800a40:	8082                	ret
  800a42:	8526                	mv	a0,s1
  800a44:	de2ff0ef          	jal	ra,800026 <close>
  800a48:	85a6                	mv	a1,s1
  800a4a:	8522                	mv	a0,s0
  800a4c:	de0ff0ef          	jal	ra,80002c <dup2>
  800a50:	84aa                	mv	s1,a0
  800a52:	8522                	mv	a0,s0
  800a54:	dd2ff0ef          	jal	ra,800026 <close>
  800a58:	8426                	mv	s0,s1
  800a5a:	bfc1                	j	800a2a <reopen+0x26>

0000000000800a5c <runcmd>:
  800a5c:	7159                	addi	sp,sp,-112
  800a5e:	e8ca                	sd	s2,80(sp)
  800a60:	e0d2                	sd	s4,64(sp)
  800a62:	f85a                	sd	s6,48(sp)
  800a64:	f45e                	sd	s7,40(sp)
  800a66:	f486                	sd	ra,104(sp)
  800a68:	f0a2                	sd	s0,96(sp)
  800a6a:	eca6                	sd	s1,88(sp)
  800a6c:	e4ce                	sd	s3,72(sp)
  800a6e:	fc56                	sd	s5,56(sp)
  800a70:	f062                	sd	s8,32(sp)
  800a72:	e42a                	sd	a0,8(sp)
  800a74:	07700913          	li	s2,119
  800a78:	02000b13          	li	s6,32
  800a7c:	00001b97          	auipc	s7,0x1
  800a80:	584b8b93          	addi	s7,s7,1412 # 802000 <argv.1>
  800a84:	03b00a13          	li	s4,59
  800a88:	4401                	li	s0,0
  800a8a:	03e00493          	li	s1,62
  800a8e:	03c00993          	li	s3,60
  800a92:	082c                	addi	a1,sp,24
  800a94:	0028                	addi	a0,sp,8
  800a96:	da1ff0ef          	jal	ra,800836 <gettoken>
  800a9a:	0e950e63          	beq	a0,s1,800b96 <runcmd+0x13a>
  800a9e:	04a4c763          	blt	s1,a0,800aec <runcmd+0x90>
  800aa2:	0f450063          	beq	a0,s4,800b82 <runcmd+0x126>
  800aa6:	07351e63          	bne	a0,s3,800b22 <runcmd+0xc6>
  800aaa:	082c                	addi	a1,sp,24
  800aac:	0028                	addi	a0,sp,8
  800aae:	d89ff0ef          	jal	ra,800836 <gettoken>
  800ab2:	19251463          	bne	a0,s2,800c3a <runcmd+0x1de>
  800ab6:	6ae2                	ld	s5,24(sp)
  800ab8:	4501                	li	a0,0
  800aba:	d6cff0ef          	jal	ra,800026 <close>
  800abe:	8556                	mv	a0,s5
  800ac0:	4581                	li	a1,0
  800ac2:	d5eff0ef          	jal	ra,800020 <open>
  800ac6:	8aaa                	mv	s5,a0
  800ac8:	10054963          	bltz	a0,800bda <runcmd+0x17e>
  800acc:	d179                	beqz	a0,800a92 <runcmd+0x36>
  800ace:	4501                	li	a0,0
  800ad0:	d56ff0ef          	jal	ra,800026 <close>
  800ad4:	4581                	li	a1,0
  800ad6:	8556                	mv	a0,s5
  800ad8:	d54ff0ef          	jal	ra,80002c <dup2>
  800adc:	8c2a                	mv	s8,a0
  800ade:	8556                	mv	a0,s5
  800ae0:	d46ff0ef          	jal	ra,800026 <close>
  800ae4:	fa0c57e3          	bgez	s8,800a92 <runcmd+0x36>
  800ae8:	8462                	mv	s0,s8
  800aea:	a8bd                	j	800b68 <runcmd+0x10c>
  800aec:	0d250e63          	beq	a0,s2,800bc8 <runcmd+0x16c>
  800af0:	07c00793          	li	a5,124
  800af4:	06f51163          	bne	a0,a5,800b56 <runcmd+0xfa>
  800af8:	f8aff0ef          	jal	ra,800282 <fork>
  800afc:	87aa                	mv	a5,a0
  800afe:	14051763          	bnez	a0,800c4c <runcmd+0x1f0>
  800b02:	d24ff0ef          	jal	ra,800026 <close>
  800b06:	4581                	li	a1,0
  800b08:	4501                	li	a0,0
  800b0a:	d22ff0ef          	jal	ra,80002c <dup2>
  800b0e:	842a                	mv	s0,a0
  800b10:	04054c63          	bltz	a0,800b68 <runcmd+0x10c>
  800b14:	4501                	li	a0,0
  800b16:	d10ff0ef          	jal	ra,800026 <close>
  800b1a:	4501                	li	a0,0
  800b1c:	d0aff0ef          	jal	ra,800026 <close>
  800b20:	b7a5                	j	800a88 <runcmd+0x2c>
  800b22:	e915                	bnez	a0,800b56 <runcmd+0xfa>
  800b24:	c031                	beqz	s0,800b68 <runcmd+0x10c>
  800b26:	00001497          	auipc	s1,0x1
  800b2a:	4da48493          	addi	s1,s1,1242 # 802000 <argv.1>
  800b2e:	6088                	ld	a0,0(s1)
  800b30:	00001597          	auipc	a1,0x1
  800b34:	81858593          	addi	a1,a1,-2024 # 801348 <error_string+0x1b8>
  800b38:	ccbff0ef          	jal	ra,800802 <strcmp>
  800b3c:	e14d                	bnez	a0,800bde <runcmd+0x182>
  800b3e:	4789                	li	a5,2
  800b40:	12f41963          	bne	s0,a5,800c72 <runcmd+0x216>
  800b44:	648c                	ld	a1,8(s1)
  800b46:	00003517          	auipc	a0,0x3
  800b4a:	5c250513          	addi	a0,a0,1474 # 804108 <shcwd>
  800b4e:	4401                	li	s0,0
  800b50:	ca1ff0ef          	jal	ra,8007f0 <strcpy>
  800b54:	a811                	j	800b68 <runcmd+0x10c>
  800b56:	862a                	mv	a2,a0
  800b58:	00000597          	auipc	a1,0x0
  800b5c:	7c858593          	addi	a1,a1,1992 # 801320 <error_string+0x190>
  800b60:	4505                	li	a0,1
  800b62:	e46ff0ef          	jal	ra,8001a8 <fprintf>
  800b66:	547d                	li	s0,-1
  800b68:	70a6                	ld	ra,104(sp)
  800b6a:	8522                	mv	a0,s0
  800b6c:	7406                	ld	s0,96(sp)
  800b6e:	64e6                	ld	s1,88(sp)
  800b70:	6946                	ld	s2,80(sp)
  800b72:	69a6                	ld	s3,72(sp)
  800b74:	6a06                	ld	s4,64(sp)
  800b76:	7ae2                	ld	s5,56(sp)
  800b78:	7b42                	ld	s6,48(sp)
  800b7a:	7ba2                	ld	s7,40(sp)
  800b7c:	7c02                	ld	s8,32(sp)
  800b7e:	6165                	addi	sp,sp,112
  800b80:	8082                	ret
  800b82:	f00ff0ef          	jal	ra,800282 <fork>
  800b86:	87aa                	mv	a5,a0
  800b88:	dd51                	beqz	a0,800b24 <runcmd+0xc8>
  800b8a:	08054463          	bltz	a0,800c12 <runcmd+0x1b6>
  800b8e:	4581                	li	a1,0
  800b90:	ef4ff0ef          	jal	ra,800284 <waitpid>
  800b94:	bdd5                	j	800a88 <runcmd+0x2c>
  800b96:	082c                	addi	a1,sp,24
  800b98:	0028                	addi	a0,sp,8
  800b9a:	c9dff0ef          	jal	ra,800836 <gettoken>
  800b9e:	0d251c63          	bne	a0,s2,800c76 <runcmd+0x21a>
  800ba2:	6ae2                	ld	s5,24(sp)
  800ba4:	4505                	li	a0,1
  800ba6:	c80ff0ef          	jal	ra,800026 <close>
  800baa:	8556                	mv	a0,s5
  800bac:	45d9                	li	a1,22
  800bae:	c72ff0ef          	jal	ra,800020 <open>
  800bb2:	8aaa                	mv	s5,a0
  800bb4:	02054363          	bltz	a0,800bda <runcmd+0x17e>
  800bb8:	4785                	li	a5,1
  800bba:	ecf50ce3          	beq	a0,a5,800a92 <runcmd+0x36>
  800bbe:	4505                	li	a0,1
  800bc0:	c66ff0ef          	jal	ra,800026 <close>
  800bc4:	4585                	li	a1,1
  800bc6:	bf01                	j	800ad6 <runcmd+0x7a>
  800bc8:	0d640063          	beq	s0,s6,800c88 <runcmd+0x22c>
  800bcc:	6762                	ld	a4,24(sp)
  800bce:	00341793          	slli	a5,s0,0x3
  800bd2:	97de                	add	a5,a5,s7
  800bd4:	e398                	sd	a4,0(a5)
  800bd6:	2405                	addiw	s0,s0,1
  800bd8:	bd6d                	j	800a92 <runcmd+0x36>
  800bda:	8456                	mv	s0,s5
  800bdc:	b771                	j	800b68 <runcmd+0x10c>
  800bde:	6088                	ld	a0,0(s1)
  800be0:	4581                	li	a1,0
  800be2:	c3eff0ef          	jal	ra,800020 <open>
  800be6:	87aa                	mv	a5,a0
  800be8:	02054263          	bltz	a0,800c0c <runcmd+0x1b0>
  800bec:	c3aff0ef          	jal	ra,800026 <close>
  800bf0:	00341793          	slli	a5,s0,0x3
  800bf4:	97a6                	add	a5,a5,s1
  800bf6:	0007b023          	sd	zero,0(a5)
  800bfa:	6088                	ld	a0,0(s1)
  800bfc:	00001597          	auipc	a1,0x1
  800c00:	40458593          	addi	a1,a1,1028 # 802000 <argv.1>
  800c04:	e82ff0ef          	jal	ra,800286 <__exec>
  800c08:	842a                	mv	s0,a0
  800c0a:	bfb9                	j	800b68 <runcmd+0x10c>
  800c0c:	5741                	li	a4,-16
  800c0e:	00e50463          	beq	a0,a4,800c16 <runcmd+0x1ba>
  800c12:	843e                	mv	s0,a5
  800c14:	bf91                	j	800b68 <runcmd+0x10c>
  800c16:	6094                	ld	a3,0(s1)
  800c18:	00000617          	auipc	a2,0x0
  800c1c:	73860613          	addi	a2,a2,1848 # 801350 <error_string+0x1c0>
  800c20:	6585                	lui	a1,0x1
  800c22:	00001517          	auipc	a0,0x1
  800c26:	4e650513          	addi	a0,a0,1254 # 802108 <argv0.0>
  800c2a:	b5dff0ef          	jal	ra,800786 <snprintf>
  800c2e:	00001797          	auipc	a5,0x1
  800c32:	4da78793          	addi	a5,a5,1242 # 802108 <argv0.0>
  800c36:	e09c                	sd	a5,0(s1)
  800c38:	bf65                	j	800bf0 <runcmd+0x194>
  800c3a:	00000597          	auipc	a1,0x0
  800c3e:	68658593          	addi	a1,a1,1670 # 8012c0 <error_string+0x130>
  800c42:	4505                	li	a0,1
  800c44:	d64ff0ef          	jal	ra,8001a8 <fprintf>
  800c48:	547d                	li	s0,-1
  800c4a:	bf39                	j	800b68 <runcmd+0x10c>
  800c4c:	fc0543e3          	bltz	a0,800c12 <runcmd+0x1b6>
  800c50:	4505                	li	a0,1
  800c52:	bd4ff0ef          	jal	ra,800026 <close>
  800c56:	4585                	li	a1,1
  800c58:	4501                	li	a0,0
  800c5a:	bd2ff0ef          	jal	ra,80002c <dup2>
  800c5e:	87aa                	mv	a5,a0
  800c60:	fa0549e3          	bltz	a0,800c12 <runcmd+0x1b6>
  800c64:	4501                	li	a0,0
  800c66:	bc0ff0ef          	jal	ra,800026 <close>
  800c6a:	4501                	li	a0,0
  800c6c:	bbaff0ef          	jal	ra,800026 <close>
  800c70:	bd55                	j	800b24 <runcmd+0xc8>
  800c72:	547d                	li	s0,-1
  800c74:	bdd5                	j	800b68 <runcmd+0x10c>
  800c76:	00000597          	auipc	a1,0x0
  800c7a:	67a58593          	addi	a1,a1,1658 # 8012f0 <error_string+0x160>
  800c7e:	4505                	li	a0,1
  800c80:	d28ff0ef          	jal	ra,8001a8 <fprintf>
  800c84:	547d                	li	s0,-1
  800c86:	b5cd                	j	800b68 <runcmd+0x10c>
  800c88:	00000597          	auipc	a1,0x0
  800c8c:	61858593          	addi	a1,a1,1560 # 8012a0 <error_string+0x110>
  800c90:	4505                	li	a0,1
  800c92:	d16ff0ef          	jal	ra,8001a8 <fprintf>
  800c96:	547d                	li	s0,-1
  800c98:	bdc1                	j	800b68 <runcmd+0x10c>

0000000000800c9a <main>:
  800c9a:	7179                	addi	sp,sp,-48
  800c9c:	f022                	sd	s0,32(sp)
  800c9e:	842a                	mv	s0,a0
  800ca0:	00000517          	auipc	a0,0x0
  800ca4:	6b850513          	addi	a0,a0,1720 # 801358 <error_string+0x1c8>
  800ca8:	ec26                	sd	s1,24(sp)
  800caa:	f406                	sd	ra,40(sp)
  800cac:	e84a                	sd	s2,16(sp)
  800cae:	84ae                	mv	s1,a1
  800cb0:	cb8ff0ef          	jal	ra,800168 <cputs>
  800cb4:	4789                	li	a5,2
  800cb6:	04f40e63          	beq	s0,a5,800d12 <main+0x78>
  800cba:	00000497          	auipc	s1,0x0
  800cbe:	6ee48493          	addi	s1,s1,1774 # 8013a8 <error_string+0x218>
  800cc2:	0687c163          	blt	a5,s0,800d24 <main+0x8a>
  800cc6:	00000917          	auipc	s2,0x0
  800cca:	6ea90913          	addi	s2,s2,1770 # 8013b0 <error_string+0x220>
  800cce:	a831                	j	800cea <main+0x50>
  800cd0:	00003797          	auipc	a5,0x3
  800cd4:	42078c23          	sb	zero,1080(a5) # 804108 <shcwd>
  800cd8:	daaff0ef          	jal	ra,800282 <fork>
  800cdc:	cd2d                	beqz	a0,800d56 <main+0xbc>
  800cde:	04054c63          	bltz	a0,800d36 <main+0x9c>
  800ce2:	006c                	addi	a1,sp,12
  800ce4:	da0ff0ef          	jal	ra,800284 <waitpid>
  800ce8:	cd09                	beqz	a0,800d02 <main+0x68>
  800cea:	8526                	mv	a0,s1
  800cec:	c23ff0ef          	jal	ra,80090e <readline>
  800cf0:	842a                	mv	s0,a0
  800cf2:	fd79                	bnez	a0,800cd0 <main+0x36>
  800cf4:	4501                	li	a0,0
  800cf6:	70a2                	ld	ra,40(sp)
  800cf8:	7402                	ld	s0,32(sp)
  800cfa:	64e2                	ld	s1,24(sp)
  800cfc:	6942                	ld	s2,16(sp)
  800cfe:	6145                	addi	sp,sp,48
  800d00:	8082                	ret
  800d02:	46b2                	lw	a3,12(sp)
  800d04:	d2fd                	beqz	a3,800cea <main+0x50>
  800d06:	8636                	mv	a2,a3
  800d08:	85ca                	mv	a1,s2
  800d0a:	4505                	li	a0,1
  800d0c:	c9cff0ef          	jal	ra,8001a8 <fprintf>
  800d10:	bfe9                	j	800cea <main+0x50>
  800d12:	648c                	ld	a1,8(s1)
  800d14:	4601                	li	a2,0
  800d16:	4501                	li	a0,0
  800d18:	cedff0ef          	jal	ra,800a04 <reopen>
  800d1c:	c62a                	sw	a0,12(sp)
  800d1e:	4481                	li	s1,0
  800d20:	d15d                	beqz	a0,800cc6 <main+0x2c>
  800d22:	bfd1                	j	800cf6 <main+0x5c>
  800d24:	00000597          	auipc	a1,0x0
  800d28:	55c58593          	addi	a1,a1,1372 # 801280 <error_string+0xf0>
  800d2c:	4505                	li	a0,1
  800d2e:	c7aff0ef          	jal	ra,8001a8 <fprintf>
  800d32:	557d                	li	a0,-1
  800d34:	b7c9                	j	800cf6 <main+0x5c>
  800d36:	00000697          	auipc	a3,0x0
  800d3a:	63a68693          	addi	a3,a3,1594 # 801370 <error_string+0x1e0>
  800d3e:	00000617          	auipc	a2,0x0
  800d42:	64260613          	addi	a2,a2,1602 # 801380 <error_string+0x1f0>
  800d46:	0f200593          	li	a1,242
  800d4a:	00000517          	auipc	a0,0x0
  800d4e:	64e50513          	addi	a0,a0,1614 # 801398 <error_string+0x208>
  800d52:	aeaff0ef          	jal	ra,80003c <__panic>
  800d56:	8522                	mv	a0,s0
  800d58:	d05ff0ef          	jal	ra,800a5c <runcmd>
  800d5c:	c62a                	sw	a0,12(sp)
  800d5e:	d0eff0ef          	jal	ra,80026c <exit>
