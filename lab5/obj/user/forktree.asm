
obj/__user_forktree.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <_start>:
.text
.globl _start
_start:
    # call user-program function
    call umain
  800020:	0c4000ef          	jal	ra,8000e4 <umain>
1:  j 1b
  800024:	a001                	j	800024 <_start+0x4>

0000000000800026 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800026:	1141                	addi	sp,sp,-16
  800028:	e022                	sd	s0,0(sp)
  80002a:	e406                	sd	ra,8(sp)
  80002c:	842e                	mv	s0,a1
    sys_putc(c);
  80002e:	094000ef          	jal	ra,8000c2 <sys_putc>
    (*cnt) ++;
  800032:	401c                	lw	a5,0(s0)
}
  800034:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  800036:	2785                	addiw	a5,a5,1
  800038:	c01c                	sw	a5,0(s0)
}
  80003a:	6402                	ld	s0,0(sp)
  80003c:	0141                	addi	sp,sp,16
  80003e:	8082                	ret

0000000000800040 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800040:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800042:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800046:	8e2a                	mv	t3,a0
  800048:	f42e                	sd	a1,40(sp)
  80004a:	f832                	sd	a2,48(sp)
  80004c:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80004e:	00000517          	auipc	a0,0x0
  800052:	fd850513          	addi	a0,a0,-40 # 800026 <cputch>
  800056:	004c                	addi	a1,sp,4
  800058:	869a                	mv	a3,t1
  80005a:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  80005c:	ec06                	sd	ra,24(sp)
  80005e:	e0ba                	sd	a4,64(sp)
  800060:	e4be                	sd	a5,72(sp)
  800062:	e8c2                	sd	a6,80(sp)
  800064:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800066:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800068:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80006a:	116000ef          	jal	ra,800180 <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  80006e:	60e2                	ld	ra,24(sp)
  800070:	4512                	lw	a0,4(sp)
  800072:	6125                	addi	sp,sp,96
  800074:	8082                	ret

0000000000800076 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800076:	7175                	addi	sp,sp,-144
  800078:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  80007a:	e0ba                	sd	a4,64(sp)
  80007c:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  80007e:	e42a                	sd	a0,8(sp)
  800080:	ecae                	sd	a1,88(sp)
  800082:	f0b2                	sd	a2,96(sp)
  800084:	f4b6                	sd	a3,104(sp)
  800086:	fcbe                	sd	a5,120(sp)
  800088:	e142                	sd	a6,128(sp)
  80008a:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  80008c:	f42e                	sd	a1,40(sp)
  80008e:	f832                	sd	a2,48(sp)
  800090:	fc36                	sd	a3,56(sp)
  800092:	f03a                	sd	a4,32(sp)
  800094:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);

    asm volatile (
  800096:	6522                	ld	a0,8(sp)
  800098:	75a2                	ld	a1,40(sp)
  80009a:	7642                	ld	a2,48(sp)
  80009c:	76e2                	ld	a3,56(sp)
  80009e:	6706                	ld	a4,64(sp)
  8000a0:	67a6                	ld	a5,72(sp)
  8000a2:	00000073          	ecall
  8000a6:	00a13e23          	sd	a0,28(sp)
        "sd a0, %0"
        : "=m" (ret)
        : "m"(num), "m"(a[0]), "m"(a[1]), "m"(a[2]), "m"(a[3]), "m"(a[4])
        :"memory");
    return ret;
}
  8000aa:	4572                	lw	a0,28(sp)
  8000ac:	6149                	addi	sp,sp,144
  8000ae:	8082                	ret

00000000008000b0 <sys_exit>:

int
sys_exit(int64_t error_code) {
  8000b0:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  8000b2:	4505                	li	a0,1
  8000b4:	b7c9                	j	800076 <syscall>

00000000008000b6 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  8000b6:	4509                	li	a0,2
  8000b8:	bf7d                	j	800076 <syscall>

00000000008000ba <sys_yield>:
    return syscall(SYS_wait, pid, store);
}

int
sys_yield(void) {
    return syscall(SYS_yield);
  8000ba:	4529                	li	a0,10
  8000bc:	bf6d                	j	800076 <syscall>

00000000008000be <sys_getpid>:
    return syscall(SYS_kill, pid);
}

int
sys_getpid(void) {
    return syscall(SYS_getpid);
  8000be:	4549                	li	a0,18
  8000c0:	bf5d                	j	800076 <syscall>

00000000008000c2 <sys_putc>:
}

int
sys_putc(int64_t c) {
  8000c2:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000c4:	4579                	li	a0,30
  8000c6:	bf45                	j	800076 <syscall>

00000000008000c8 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000c8:	1141                	addi	sp,sp,-16
  8000ca:	e406                	sd	ra,8(sp)
    sys_exit(error_code);
  8000cc:	fe5ff0ef          	jal	ra,8000b0 <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000d0:	00000517          	auipc	a0,0x0
  8000d4:	57850513          	addi	a0,a0,1400 # 800648 <main+0x1a>
  8000d8:	f69ff0ef          	jal	ra,800040 <cprintf>
    while (1);
  8000dc:	a001                	j	8000dc <exit+0x14>

00000000008000de <fork>:
}

int
fork(void) {
    return sys_fork();
  8000de:	bfe1                	j	8000b6 <sys_fork>

00000000008000e0 <yield>:
    return sys_wait(pid, store);
}

void
yield(void) {
    sys_yield();
  8000e0:	bfe9                	j	8000ba <sys_yield>

00000000008000e2 <getpid>:
    return sys_kill(pid);
}

int
getpid(void) {
    return sys_getpid();
  8000e2:	bff1                	j	8000be <sys_getpid>

00000000008000e4 <umain>:
/* Weak hook used only by divzero: if symbol exists, initialize to -1 so
 * division executes with a nonzero denominator and matches expected output. */
extern int zero __attribute__((weak));

void
umain(void) {
  8000e4:	1141                	addi	sp,sp,-16
  8000e6:	e406                	sd	ra,8(sp)
    if (&zero != 0) {
  8000e8:	00000793          	li	a5,0
  8000ec:	c399                	beqz	a5,8000f2 <umain+0xe>
        zero = -1;
  8000ee:	577d                	li	a4,-1
  8000f0:	c398                	sw	a4,0(a5)
    }
    int ret = main();
  8000f2:	53c000ef          	jal	ra,80062e <main>
    exit(ret);
  8000f6:	fd3ff0ef          	jal	ra,8000c8 <exit>

00000000008000fa <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  8000fa:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8000fe:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  800100:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800104:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  800106:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  80010a:	f022                	sd	s0,32(sp)
  80010c:	ec26                	sd	s1,24(sp)
  80010e:	e84a                	sd	s2,16(sp)
  800110:	f406                	sd	ra,40(sp)
  800112:	e44e                	sd	s3,8(sp)
  800114:	84aa                	mv	s1,a0
  800116:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  800118:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  80011c:	2a01                	sext.w	s4,s4
    if (num >= base) {
  80011e:	03067e63          	bgeu	a2,a6,80015a <printnum+0x60>
  800122:	89be                	mv	s3,a5
        while (-- width > 0)
  800124:	00805763          	blez	s0,800132 <printnum+0x38>
  800128:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  80012a:	85ca                	mv	a1,s2
  80012c:	854e                	mv	a0,s3
  80012e:	9482                	jalr	s1
        while (-- width > 0)
  800130:	fc65                	bnez	s0,800128 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  800132:	1a02                	slli	s4,s4,0x20
  800134:	00000797          	auipc	a5,0x0
  800138:	52c78793          	addi	a5,a5,1324 # 800660 <main+0x32>
  80013c:	020a5a13          	srli	s4,s4,0x20
  800140:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  800142:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  800144:	000a4503          	lbu	a0,0(s4)
}
  800148:	70a2                	ld	ra,40(sp)
  80014a:	69a2                	ld	s3,8(sp)
  80014c:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  80014e:	85ca                	mv	a1,s2
  800150:	87a6                	mv	a5,s1
}
  800152:	6942                	ld	s2,16(sp)
  800154:	64e2                	ld	s1,24(sp)
  800156:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  800158:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
  80015a:	03065633          	divu	a2,a2,a6
  80015e:	8722                	mv	a4,s0
  800160:	f9bff0ef          	jal	ra,8000fa <printnum>
  800164:	b7f9                	j	800132 <printnum+0x38>

0000000000800166 <sprintputch>:
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
    b->cnt ++;
  800166:	499c                	lw	a5,16(a1)
    if (b->buf < b->ebuf) {
  800168:	6198                	ld	a4,0(a1)
  80016a:	6594                	ld	a3,8(a1)
    b->cnt ++;
  80016c:	2785                	addiw	a5,a5,1
  80016e:	c99c                	sw	a5,16(a1)
    if (b->buf < b->ebuf) {
  800170:	00d77763          	bgeu	a4,a3,80017e <sprintputch+0x18>
        *b->buf ++ = ch;
  800174:	00170793          	addi	a5,a4,1
  800178:	e19c                	sd	a5,0(a1)
  80017a:	00a70023          	sb	a0,0(a4)
    }
}
  80017e:	8082                	ret

0000000000800180 <vprintfmt>:
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  800180:	7119                	addi	sp,sp,-128
  800182:	f4a6                	sd	s1,104(sp)
  800184:	f0ca                	sd	s2,96(sp)
  800186:	ecce                	sd	s3,88(sp)
  800188:	e8d2                	sd	s4,80(sp)
  80018a:	e4d6                	sd	s5,72(sp)
  80018c:	e0da                	sd	s6,64(sp)
  80018e:	fc5e                	sd	s7,56(sp)
  800190:	f06a                	sd	s10,32(sp)
  800192:	fc86                	sd	ra,120(sp)
  800194:	f8a2                	sd	s0,112(sp)
  800196:	f862                	sd	s8,48(sp)
  800198:	f466                	sd	s9,40(sp)
  80019a:	ec6e                	sd	s11,24(sp)
  80019c:	892a                	mv	s2,a0
  80019e:	84ae                	mv	s1,a1
  8001a0:	8d32                	mv	s10,a2
  8001a2:	8a36                	mv	s4,a3
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001a4:	02500993          	li	s3,37
        width = precision = -1;
  8001a8:	5b7d                	li	s6,-1
  8001aa:	00000a97          	auipc	s5,0x0
  8001ae:	4eaa8a93          	addi	s5,s5,1258 # 800694 <main+0x66>
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8001b2:	00000b97          	auipc	s7,0x0
  8001b6:	6feb8b93          	addi	s7,s7,1790 # 8008b0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001ba:	000d4503          	lbu	a0,0(s10)
  8001be:	001d0413          	addi	s0,s10,1
  8001c2:	01350a63          	beq	a0,s3,8001d6 <vprintfmt+0x56>
            if (ch == '\0') {
  8001c6:	c121                	beqz	a0,800206 <vprintfmt+0x86>
            putch(ch, putdat);
  8001c8:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001ca:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  8001cc:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001ce:	fff44503          	lbu	a0,-1(s0)
  8001d2:	ff351ae3          	bne	a0,s3,8001c6 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
  8001d6:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  8001da:	02000793          	li	a5,32
        lflag = altflag = 0;
  8001de:	4c81                	li	s9,0
  8001e0:	4881                	li	a7,0
        width = precision = -1;
  8001e2:	5c7d                	li	s8,-1
  8001e4:	5dfd                	li	s11,-1
  8001e6:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  8001ea:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  8001ec:	fdd6059b          	addiw	a1,a2,-35
  8001f0:	0ff5f593          	zext.b	a1,a1
  8001f4:	00140d13          	addi	s10,s0,1
  8001f8:	04b56263          	bltu	a0,a1,80023c <vprintfmt+0xbc>
  8001fc:	058a                	slli	a1,a1,0x2
  8001fe:	95d6                	add	a1,a1,s5
  800200:	4194                	lw	a3,0(a1)
  800202:	96d6                	add	a3,a3,s5
  800204:	8682                	jr	a3
}
  800206:	70e6                	ld	ra,120(sp)
  800208:	7446                	ld	s0,112(sp)
  80020a:	74a6                	ld	s1,104(sp)
  80020c:	7906                	ld	s2,96(sp)
  80020e:	69e6                	ld	s3,88(sp)
  800210:	6a46                	ld	s4,80(sp)
  800212:	6aa6                	ld	s5,72(sp)
  800214:	6b06                	ld	s6,64(sp)
  800216:	7be2                	ld	s7,56(sp)
  800218:	7c42                	ld	s8,48(sp)
  80021a:	7ca2                	ld	s9,40(sp)
  80021c:	7d02                	ld	s10,32(sp)
  80021e:	6de2                	ld	s11,24(sp)
  800220:	6109                	addi	sp,sp,128
  800222:	8082                	ret
            padc = '0';
  800224:	87b2                	mv	a5,a2
            goto reswitch;
  800226:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80022a:	846a                	mv	s0,s10
  80022c:	00140d13          	addi	s10,s0,1
  800230:	fdd6059b          	addiw	a1,a2,-35
  800234:	0ff5f593          	zext.b	a1,a1
  800238:	fcb572e3          	bgeu	a0,a1,8001fc <vprintfmt+0x7c>
            putch('%', putdat);
  80023c:	85a6                	mv	a1,s1
  80023e:	02500513          	li	a0,37
  800242:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800244:	fff44783          	lbu	a5,-1(s0)
  800248:	8d22                	mv	s10,s0
  80024a:	f73788e3          	beq	a5,s3,8001ba <vprintfmt+0x3a>
  80024e:	ffed4783          	lbu	a5,-2(s10)
  800252:	1d7d                	addi	s10,s10,-1
  800254:	ff379de3          	bne	a5,s3,80024e <vprintfmt+0xce>
  800258:	b78d                	j	8001ba <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  80025a:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  80025e:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800262:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800264:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  800268:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80026c:	02d86463          	bltu	a6,a3,800294 <vprintfmt+0x114>
                ch = *fmt;
  800270:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800274:	002c169b          	slliw	a3,s8,0x2
  800278:	0186873b          	addw	a4,a3,s8
  80027c:	0017171b          	slliw	a4,a4,0x1
  800280:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  800282:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800286:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800288:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  80028c:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800290:	fed870e3          	bgeu	a6,a3,800270 <vprintfmt+0xf0>
            if (width < 0)
  800294:	f40ddce3          	bgez	s11,8001ec <vprintfmt+0x6c>
                width = precision, precision = -1;
  800298:	8de2                	mv	s11,s8
  80029a:	5c7d                	li	s8,-1
  80029c:	bf81                	j	8001ec <vprintfmt+0x6c>
            if (width < 0)
  80029e:	fffdc693          	not	a3,s11
  8002a2:	96fd                	srai	a3,a3,0x3f
  8002a4:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
  8002a8:	00144603          	lbu	a2,1(s0)
  8002ac:	2d81                	sext.w	s11,s11
  8002ae:	846a                	mv	s0,s10
            goto reswitch;
  8002b0:	bf35                	j	8001ec <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  8002b2:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
  8002b6:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  8002ba:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  8002bc:	846a                	mv	s0,s10
            goto process_precision;
  8002be:	bfd9                	j	800294 <vprintfmt+0x114>
    if (lflag >= 2) {
  8002c0:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002c2:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002c6:	01174463          	blt	a4,a7,8002ce <vprintfmt+0x14e>
    else if (lflag) {
  8002ca:	1a088e63          	beqz	a7,800486 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  8002ce:	000a3603          	ld	a2,0(s4)
  8002d2:	46c1                	li	a3,16
  8002d4:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  8002d6:	2781                	sext.w	a5,a5
  8002d8:	876e                	mv	a4,s11
  8002da:	85a6                	mv	a1,s1
  8002dc:	854a                	mv	a0,s2
  8002de:	e1dff0ef          	jal	ra,8000fa <printnum>
            break;
  8002e2:	bde1                	j	8001ba <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  8002e4:	000a2503          	lw	a0,0(s4)
  8002e8:	85a6                	mv	a1,s1
  8002ea:	0a21                	addi	s4,s4,8
  8002ec:	9902                	jalr	s2
            break;
  8002ee:	b5f1                	j	8001ba <vprintfmt+0x3a>
    if (lflag >= 2) {
  8002f0:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002f2:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002f6:	01174463          	blt	a4,a7,8002fe <vprintfmt+0x17e>
    else if (lflag) {
  8002fa:	18088163          	beqz	a7,80047c <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  8002fe:	000a3603          	ld	a2,0(s4)
  800302:	46a9                	li	a3,10
  800304:	8a2e                	mv	s4,a1
  800306:	bfc1                	j	8002d6 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
  800308:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  80030c:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  80030e:	846a                	mv	s0,s10
            goto reswitch;
  800310:	bdf1                	j	8001ec <vprintfmt+0x6c>
            putch(ch, putdat);
  800312:	85a6                	mv	a1,s1
  800314:	02500513          	li	a0,37
  800318:	9902                	jalr	s2
            break;
  80031a:	b545                	j	8001ba <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
  80031c:	00144603          	lbu	a2,1(s0)
            lflag ++;
  800320:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  800322:	846a                	mv	s0,s10
            goto reswitch;
  800324:	b5e1                	j	8001ec <vprintfmt+0x6c>
    if (lflag >= 2) {
  800326:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800328:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  80032c:	01174463          	blt	a4,a7,800334 <vprintfmt+0x1b4>
    else if (lflag) {
  800330:	14088163          	beqz	a7,800472 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800334:	000a3603          	ld	a2,0(s4)
  800338:	46a1                	li	a3,8
  80033a:	8a2e                	mv	s4,a1
  80033c:	bf69                	j	8002d6 <vprintfmt+0x156>
            putch('0', putdat);
  80033e:	03000513          	li	a0,48
  800342:	85a6                	mv	a1,s1
  800344:	e03e                	sd	a5,0(sp)
  800346:	9902                	jalr	s2
            putch('x', putdat);
  800348:	85a6                	mv	a1,s1
  80034a:	07800513          	li	a0,120
  80034e:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800350:	0a21                	addi	s4,s4,8
            goto number;
  800352:	6782                	ld	a5,0(sp)
  800354:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800356:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  80035a:	bfb5                	j	8002d6 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  80035c:	000a3403          	ld	s0,0(s4)
  800360:	008a0713          	addi	a4,s4,8
  800364:	e03a                	sd	a4,0(sp)
  800366:	14040263          	beqz	s0,8004aa <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  80036a:	0fb05763          	blez	s11,800458 <vprintfmt+0x2d8>
  80036e:	02d00693          	li	a3,45
  800372:	0cd79163          	bne	a5,a3,800434 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800376:	00044783          	lbu	a5,0(s0)
  80037a:	0007851b          	sext.w	a0,a5
  80037e:	cf85                	beqz	a5,8003b6 <vprintfmt+0x236>
  800380:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800384:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800388:	000c4563          	bltz	s8,800392 <vprintfmt+0x212>
  80038c:	3c7d                	addiw	s8,s8,-1
  80038e:	036c0263          	beq	s8,s6,8003b2 <vprintfmt+0x232>
                    putch('?', putdat);
  800392:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800394:	0e0c8e63          	beqz	s9,800490 <vprintfmt+0x310>
  800398:	3781                	addiw	a5,a5,-32
  80039a:	0ef47b63          	bgeu	s0,a5,800490 <vprintfmt+0x310>
                    putch('?', putdat);
  80039e:	03f00513          	li	a0,63
  8003a2:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003a4:	000a4783          	lbu	a5,0(s4)
  8003a8:	3dfd                	addiw	s11,s11,-1
  8003aa:	0a05                	addi	s4,s4,1
  8003ac:	0007851b          	sext.w	a0,a5
  8003b0:	ffe1                	bnez	a5,800388 <vprintfmt+0x208>
            for (; width > 0; width --) {
  8003b2:	01b05963          	blez	s11,8003c4 <vprintfmt+0x244>
  8003b6:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  8003b8:	85a6                	mv	a1,s1
  8003ba:	02000513          	li	a0,32
  8003be:	9902                	jalr	s2
            for (; width > 0; width --) {
  8003c0:	fe0d9be3          	bnez	s11,8003b6 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003c4:	6a02                	ld	s4,0(sp)
  8003c6:	bbd5                	j	8001ba <vprintfmt+0x3a>
    if (lflag >= 2) {
  8003c8:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8003ca:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
  8003ce:	01174463          	blt	a4,a7,8003d6 <vprintfmt+0x256>
    else if (lflag) {
  8003d2:	08088d63          	beqz	a7,80046c <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  8003d6:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  8003da:	0a044d63          	bltz	s0,800494 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  8003de:	8622                	mv	a2,s0
  8003e0:	8a66                	mv	s4,s9
  8003e2:	46a9                	li	a3,10
  8003e4:	bdcd                	j	8002d6 <vprintfmt+0x156>
            err = va_arg(ap, int);
  8003e6:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003ea:	4761                	li	a4,24
            err = va_arg(ap, int);
  8003ec:	0a21                	addi	s4,s4,8
            if (err < 0) {
  8003ee:	41f7d69b          	sraiw	a3,a5,0x1f
  8003f2:	8fb5                	xor	a5,a5,a3
  8003f4:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003f8:	02d74163          	blt	a4,a3,80041a <vprintfmt+0x29a>
  8003fc:	00369793          	slli	a5,a3,0x3
  800400:	97de                	add	a5,a5,s7
  800402:	639c                	ld	a5,0(a5)
  800404:	cb99                	beqz	a5,80041a <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  800406:	86be                	mv	a3,a5
  800408:	00000617          	auipc	a2,0x0
  80040c:	28860613          	addi	a2,a2,648 # 800690 <main+0x62>
  800410:	85a6                	mv	a1,s1
  800412:	854a                	mv	a0,s2
  800414:	0ce000ef          	jal	ra,8004e2 <printfmt>
  800418:	b34d                	j	8001ba <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  80041a:	00000617          	auipc	a2,0x0
  80041e:	26660613          	addi	a2,a2,614 # 800680 <main+0x52>
  800422:	85a6                	mv	a1,s1
  800424:	854a                	mv	a0,s2
  800426:	0bc000ef          	jal	ra,8004e2 <printfmt>
  80042a:	bb41                	j	8001ba <vprintfmt+0x3a>
                p = "(null)";
  80042c:	00000417          	auipc	s0,0x0
  800430:	24c40413          	addi	s0,s0,588 # 800678 <main+0x4a>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800434:	85e2                	mv	a1,s8
  800436:	8522                	mv	a0,s0
  800438:	e43e                	sd	a5,8(sp)
  80043a:	128000ef          	jal	ra,800562 <strnlen>
  80043e:	40ad8dbb          	subw	s11,s11,a0
  800442:	01b05b63          	blez	s11,800458 <vprintfmt+0x2d8>
                    putch(padc, putdat);
  800446:	67a2                	ld	a5,8(sp)
  800448:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
  80044c:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  80044e:	85a6                	mv	a1,s1
  800450:	8552                	mv	a0,s4
  800452:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  800454:	fe0d9ce3          	bnez	s11,80044c <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800458:	00044783          	lbu	a5,0(s0)
  80045c:	00140a13          	addi	s4,s0,1
  800460:	0007851b          	sext.w	a0,a5
  800464:	d3a5                	beqz	a5,8003c4 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  800466:	05e00413          	li	s0,94
  80046a:	bf39                	j	800388 <vprintfmt+0x208>
        return va_arg(*ap, int);
  80046c:	000a2403          	lw	s0,0(s4)
  800470:	b7ad                	j	8003da <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  800472:	000a6603          	lwu	a2,0(s4)
  800476:	46a1                	li	a3,8
  800478:	8a2e                	mv	s4,a1
  80047a:	bdb1                	j	8002d6 <vprintfmt+0x156>
  80047c:	000a6603          	lwu	a2,0(s4)
  800480:	46a9                	li	a3,10
  800482:	8a2e                	mv	s4,a1
  800484:	bd89                	j	8002d6 <vprintfmt+0x156>
  800486:	000a6603          	lwu	a2,0(s4)
  80048a:	46c1                	li	a3,16
  80048c:	8a2e                	mv	s4,a1
  80048e:	b5a1                	j	8002d6 <vprintfmt+0x156>
                    putch(ch, putdat);
  800490:	9902                	jalr	s2
  800492:	bf09                	j	8003a4 <vprintfmt+0x224>
                putch('-', putdat);
  800494:	85a6                	mv	a1,s1
  800496:	02d00513          	li	a0,45
  80049a:	e03e                	sd	a5,0(sp)
  80049c:	9902                	jalr	s2
                num = -(long long)num;
  80049e:	6782                	ld	a5,0(sp)
  8004a0:	8a66                	mv	s4,s9
  8004a2:	40800633          	neg	a2,s0
  8004a6:	46a9                	li	a3,10
  8004a8:	b53d                	j	8002d6 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  8004aa:	03b05163          	blez	s11,8004cc <vprintfmt+0x34c>
  8004ae:	02d00693          	li	a3,45
  8004b2:	f6d79de3          	bne	a5,a3,80042c <vprintfmt+0x2ac>
                p = "(null)";
  8004b6:	00000417          	auipc	s0,0x0
  8004ba:	1c240413          	addi	s0,s0,450 # 800678 <main+0x4a>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004be:	02800793          	li	a5,40
  8004c2:	02800513          	li	a0,40
  8004c6:	00140a13          	addi	s4,s0,1
  8004ca:	bd6d                	j	800384 <vprintfmt+0x204>
  8004cc:	00000a17          	auipc	s4,0x0
  8004d0:	1ada0a13          	addi	s4,s4,429 # 800679 <main+0x4b>
  8004d4:	02800513          	li	a0,40
  8004d8:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  8004dc:	05e00413          	li	s0,94
  8004e0:	b565                	j	800388 <vprintfmt+0x208>

00000000008004e2 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004e2:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  8004e4:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004e8:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004ea:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004ec:	ec06                	sd	ra,24(sp)
  8004ee:	f83a                	sd	a4,48(sp)
  8004f0:	fc3e                	sd	a5,56(sp)
  8004f2:	e0c2                	sd	a6,64(sp)
  8004f4:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  8004f6:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004f8:	c89ff0ef          	jal	ra,800180 <vprintfmt>
}
  8004fc:	60e2                	ld	ra,24(sp)
  8004fe:	6161                	addi	sp,sp,80
  800500:	8082                	ret

0000000000800502 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  800502:	711d                	addi	sp,sp,-96
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
    struct sprintbuf b = {str, str + size - 1, 0};
  800504:	15fd                	addi	a1,a1,-1
    va_start(ap, fmt);
  800506:	03810313          	addi	t1,sp,56
    struct sprintbuf b = {str, str + size - 1, 0};
  80050a:	95aa                	add	a1,a1,a0
snprintf(char *str, size_t size, const char *fmt, ...) {
  80050c:	f406                	sd	ra,40(sp)
  80050e:	fc36                	sd	a3,56(sp)
  800510:	e0ba                	sd	a4,64(sp)
  800512:	e4be                	sd	a5,72(sp)
  800514:	e8c2                	sd	a6,80(sp)
  800516:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800518:	e01a                	sd	t1,0(sp)
    struct sprintbuf b = {str, str + size - 1, 0};
  80051a:	e42a                	sd	a0,8(sp)
  80051c:	e82e                	sd	a1,16(sp)
  80051e:	cc02                	sw	zero,24(sp)
    if (str == NULL || b.buf > b.ebuf) {
  800520:	c115                	beqz	a0,800544 <snprintf+0x42>
  800522:	02a5e163          	bltu	a1,a0,800544 <snprintf+0x42>
        return -E_INVAL;
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  800526:	00000517          	auipc	a0,0x0
  80052a:	c4050513          	addi	a0,a0,-960 # 800166 <sprintputch>
  80052e:	869a                	mv	a3,t1
  800530:	002c                	addi	a1,sp,8
  800532:	c4fff0ef          	jal	ra,800180 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  800536:	67a2                	ld	a5,8(sp)
  800538:	00078023          	sb	zero,0(a5)
    return b.cnt;
  80053c:	4562                	lw	a0,24(sp)
}
  80053e:	70a2                	ld	ra,40(sp)
  800540:	6125                	addi	sp,sp,96
  800542:	8082                	ret
        return -E_INVAL;
  800544:	5575                	li	a0,-3
  800546:	bfe5                	j	80053e <snprintf+0x3c>

0000000000800548 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  800548:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
  80054c:	872a                	mv	a4,a0
    size_t cnt = 0;
  80054e:	4501                	li	a0,0
    while (*s ++ != '\0') {
  800550:	cb81                	beqz	a5,800560 <strlen+0x18>
        cnt ++;
  800552:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
  800554:	00a707b3          	add	a5,a4,a0
  800558:	0007c783          	lbu	a5,0(a5)
  80055c:	fbfd                	bnez	a5,800552 <strlen+0xa>
  80055e:	8082                	ret
    }
    return cnt;
}
  800560:	8082                	ret

0000000000800562 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
  800562:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
  800564:	e589                	bnez	a1,80056e <strnlen+0xc>
  800566:	a811                	j	80057a <strnlen+0x18>
        cnt ++;
  800568:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
  80056a:	00f58863          	beq	a1,a5,80057a <strnlen+0x18>
  80056e:	00f50733          	add	a4,a0,a5
  800572:	00074703          	lbu	a4,0(a4)
  800576:	fb6d                	bnez	a4,800568 <strnlen+0x6>
  800578:	85be                	mv	a1,a5
    }
    return cnt;
}
  80057a:	852e                	mv	a0,a1
  80057c:	8082                	ret

000000000080057e <forktree>:
        exit(0);
    }
}

void
forktree(const char *cur) {
  80057e:	1101                	addi	sp,sp,-32
  800580:	ec06                	sd	ra,24(sp)
  800582:	e822                	sd	s0,16(sp)
  800584:	842a                	mv	s0,a0
    cprintf("%04x: I am '%s'\n", getpid(), cur);
  800586:	b5dff0ef          	jal	ra,8000e2 <getpid>
  80058a:	85aa                	mv	a1,a0
  80058c:	8622                	mv	a2,s0
  80058e:	00000517          	auipc	a0,0x0
  800592:	3ea50513          	addi	a0,a0,1002 # 800978 <error_string+0xc8>
  800596:	aabff0ef          	jal	ra,800040 <cprintf>

    forkchild(cur, '0');
  80059a:	03000593          	li	a1,48
  80059e:	8522                	mv	a0,s0
  8005a0:	044000ef          	jal	ra,8005e4 <forkchild>
    if (strlen(cur) >= DEPTH)
  8005a4:	8522                	mv	a0,s0
  8005a6:	fa3ff0ef          	jal	ra,800548 <strlen>
  8005aa:	478d                	li	a5,3
  8005ac:	00a7f663          	bgeu	a5,a0,8005b8 <forktree+0x3a>
    forkchild(cur, '1');
}
  8005b0:	60e2                	ld	ra,24(sp)
  8005b2:	6442                	ld	s0,16(sp)
  8005b4:	6105                	addi	sp,sp,32
  8005b6:	8082                	ret
    snprintf(nxt, DEPTH + 1, "%s%c", cur, branch);
  8005b8:	03100713          	li	a4,49
  8005bc:	86a2                	mv	a3,s0
  8005be:	00000617          	auipc	a2,0x0
  8005c2:	3d260613          	addi	a2,a2,978 # 800990 <error_string+0xe0>
  8005c6:	4595                	li	a1,5
  8005c8:	0028                	addi	a0,sp,8
  8005ca:	f39ff0ef          	jal	ra,800502 <snprintf>
    if (fork() == 0) {
  8005ce:	b11ff0ef          	jal	ra,8000de <fork>
  8005d2:	fd79                	bnez	a0,8005b0 <forktree+0x32>
        forktree(nxt);
  8005d4:	0028                	addi	a0,sp,8
  8005d6:	fa9ff0ef          	jal	ra,80057e <forktree>
        yield();
  8005da:	b07ff0ef          	jal	ra,8000e0 <yield>
        exit(0);
  8005de:	4501                	li	a0,0
  8005e0:	ae9ff0ef          	jal	ra,8000c8 <exit>

00000000008005e4 <forkchild>:
forkchild(const char *cur, char branch) {
  8005e4:	7179                	addi	sp,sp,-48
  8005e6:	f022                	sd	s0,32(sp)
  8005e8:	ec26                	sd	s1,24(sp)
  8005ea:	f406                	sd	ra,40(sp)
  8005ec:	842a                	mv	s0,a0
  8005ee:	84ae                	mv	s1,a1
    if (strlen(cur) >= DEPTH)
  8005f0:	f59ff0ef          	jal	ra,800548 <strlen>
  8005f4:	478d                	li	a5,3
  8005f6:	00a7f763          	bgeu	a5,a0,800604 <forkchild+0x20>
}
  8005fa:	70a2                	ld	ra,40(sp)
  8005fc:	7402                	ld	s0,32(sp)
  8005fe:	64e2                	ld	s1,24(sp)
  800600:	6145                	addi	sp,sp,48
  800602:	8082                	ret
    snprintf(nxt, DEPTH + 1, "%s%c", cur, branch);
  800604:	8726                	mv	a4,s1
  800606:	86a2                	mv	a3,s0
  800608:	00000617          	auipc	a2,0x0
  80060c:	38860613          	addi	a2,a2,904 # 800990 <error_string+0xe0>
  800610:	4595                	li	a1,5
  800612:	0028                	addi	a0,sp,8
  800614:	eefff0ef          	jal	ra,800502 <snprintf>
    if (fork() == 0) {
  800618:	ac7ff0ef          	jal	ra,8000de <fork>
  80061c:	fd79                	bnez	a0,8005fa <forkchild+0x16>
        forktree(nxt);
  80061e:	0028                	addi	a0,sp,8
  800620:	f5fff0ef          	jal	ra,80057e <forktree>
        yield();
  800624:	abdff0ef          	jal	ra,8000e0 <yield>
        exit(0);
  800628:	4501                	li	a0,0
  80062a:	a9fff0ef          	jal	ra,8000c8 <exit>

000000000080062e <main>:

int
main(void) {
  80062e:	1141                	addi	sp,sp,-16
    forktree("");
  800630:	00000517          	auipc	a0,0x0
  800634:	35850513          	addi	a0,a0,856 # 800988 <error_string+0xd8>
main(void) {
  800638:	e406                	sd	ra,8(sp)
    forktree("");
  80063a:	f45ff0ef          	jal	ra,80057e <forktree>
    return 0;
}
  80063e:	60a2                	ld	ra,8(sp)
  800640:	4501                	li	a0,0
  800642:	0141                	addi	sp,sp,16
  800644:	8082                	ret
