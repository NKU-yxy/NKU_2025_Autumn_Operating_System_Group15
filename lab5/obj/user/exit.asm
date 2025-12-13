
obj/__user_exit.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <_start>:
.text
.globl _start
_start:
    # call user-program function
    call umain
  800020:	130000ef          	jal	ra,800150 <umain>
1:  j 1b
  800024:	a001                	j	800024 <_start+0x4>

0000000000800026 <__panic>:
#include <stdio.h>
#include <ulib.h>
#include <error.h>

void
__panic(const char *file, int line, const char *fmt, ...) {
  800026:	715d                	addi	sp,sp,-80
  800028:	8e2e                	mv	t3,a1
  80002a:	e822                	sd	s0,16(sp)
    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
    cprintf("user panic at %s:%d:\n    ", file, line);
  80002c:	85aa                	mv	a1,a0
__panic(const char *file, int line, const char *fmt, ...) {
  80002e:	8432                	mv	s0,a2
  800030:	fc3e                	sd	a5,56(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800032:	8672                	mv	a2,t3
    va_start(ap, fmt);
  800034:	103c                	addi	a5,sp,40
    cprintf("user panic at %s:%d:\n    ", file, line);
  800036:	00000517          	auipc	a0,0x0
  80003a:	65250513          	addi	a0,a0,1618 # 800688 <main+0x118>
__panic(const char *file, int line, const char *fmt, ...) {
  80003e:	ec06                	sd	ra,24(sp)
  800040:	f436                	sd	a3,40(sp)
  800042:	f83a                	sd	a4,48(sp)
  800044:	e0c2                	sd	a6,64(sp)
  800046:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800048:	e43e                	sd	a5,8(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  80004a:	058000ef          	jal	ra,8000a2 <cprintf>
    vcprintf(fmt, ap);
  80004e:	65a2                	ld	a1,8(sp)
  800050:	8522                	mv	a0,s0
  800052:	030000ef          	jal	ra,800082 <vcprintf>
    cprintf("\n");
  800056:	00001517          	auipc	a0,0x1
  80005a:	9e250513          	addi	a0,a0,-1566 # 800a38 <error_string+0x128>
  80005e:	044000ef          	jal	ra,8000a2 <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  800062:	5559                	li	a0,-10
  800064:	0ca000ef          	jal	ra,80012e <exit>

0000000000800068 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800068:	1141                	addi	sp,sp,-16
  80006a:	e022                	sd	s0,0(sp)
  80006c:	e406                	sd	ra,8(sp)
  80006e:	842e                	mv	s0,a1
    sys_putc(c);
  800070:	0b8000ef          	jal	ra,800128 <sys_putc>
    (*cnt) ++;
  800074:	401c                	lw	a5,0(s0)
}
  800076:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  800078:	2785                	addiw	a5,a5,1
  80007a:	c01c                	sw	a5,0(s0)
}
  80007c:	6402                	ld	s0,0(sp)
  80007e:	0141                	addi	sp,sp,16
  800080:	8082                	ret

0000000000800082 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  800082:	1101                	addi	sp,sp,-32
  800084:	862a                	mv	a2,a0
  800086:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800088:	00000517          	auipc	a0,0x0
  80008c:	fe050513          	addi	a0,a0,-32 # 800068 <cputch>
  800090:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
  800092:	ec06                	sd	ra,24(sp)
    int cnt = 0;
  800094:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800096:	13c000ef          	jal	ra,8001d2 <vprintfmt>
    return cnt;
}
  80009a:	60e2                	ld	ra,24(sp)
  80009c:	4532                	lw	a0,12(sp)
  80009e:	6105                	addi	sp,sp,32
  8000a0:	8082                	ret

00000000008000a2 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  8000a2:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  8000a4:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  8000a8:	8e2a                	mv	t3,a0
  8000aa:	f42e                	sd	a1,40(sp)
  8000ac:	f832                	sd	a2,48(sp)
  8000ae:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8000b0:	00000517          	auipc	a0,0x0
  8000b4:	fb850513          	addi	a0,a0,-72 # 800068 <cputch>
  8000b8:	004c                	addi	a1,sp,4
  8000ba:	869a                	mv	a3,t1
  8000bc:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  8000be:	ec06                	sd	ra,24(sp)
  8000c0:	e0ba                	sd	a4,64(sp)
  8000c2:	e4be                	sd	a5,72(sp)
  8000c4:	e8c2                	sd	a6,80(sp)
  8000c6:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  8000c8:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  8000ca:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8000cc:	106000ef          	jal	ra,8001d2 <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  8000d0:	60e2                	ld	ra,24(sp)
  8000d2:	4512                	lw	a0,4(sp)
  8000d4:	6125                	addi	sp,sp,96
  8000d6:	8082                	ret

00000000008000d8 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  8000d8:	7175                	addi	sp,sp,-144
  8000da:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  8000dc:	e0ba                	sd	a4,64(sp)
  8000de:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  8000e0:	e42a                	sd	a0,8(sp)
  8000e2:	ecae                	sd	a1,88(sp)
  8000e4:	f0b2                	sd	a2,96(sp)
  8000e6:	f4b6                	sd	a3,104(sp)
  8000e8:	fcbe                	sd	a5,120(sp)
  8000ea:	e142                	sd	a6,128(sp)
  8000ec:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  8000ee:	f42e                	sd	a1,40(sp)
  8000f0:	f832                	sd	a2,48(sp)
  8000f2:	fc36                	sd	a3,56(sp)
  8000f4:	f03a                	sd	a4,32(sp)
  8000f6:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);

    asm volatile (
  8000f8:	6522                	ld	a0,8(sp)
  8000fa:	75a2                	ld	a1,40(sp)
  8000fc:	7642                	ld	a2,48(sp)
  8000fe:	76e2                	ld	a3,56(sp)
  800100:	6706                	ld	a4,64(sp)
  800102:	67a6                	ld	a5,72(sp)
  800104:	00000073          	ecall
  800108:	00a13e23          	sd	a0,28(sp)
        "sd a0, %0"
        : "=m" (ret)
        : "m"(num), "m"(a[0]), "m"(a[1]), "m"(a[2]), "m"(a[3]), "m"(a[4])
        :"memory");
    return ret;
}
  80010c:	4572                	lw	a0,28(sp)
  80010e:	6149                	addi	sp,sp,144
  800110:	8082                	ret

0000000000800112 <sys_exit>:

int
sys_exit(int64_t error_code) {
  800112:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  800114:	4505                	li	a0,1
  800116:	b7c9                	j	8000d8 <syscall>

0000000000800118 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  800118:	4509                	li	a0,2
  80011a:	bf7d                	j	8000d8 <syscall>

000000000080011c <sys_wait>:
}

int
sys_wait(int64_t pid, int *store) {
  80011c:	862e                	mv	a2,a1
    return syscall(SYS_wait, pid, store);
  80011e:	85aa                	mv	a1,a0
  800120:	450d                	li	a0,3
  800122:	bf5d                	j	8000d8 <syscall>

0000000000800124 <sys_yield>:
}

int
sys_yield(void) {
    return syscall(SYS_yield);
  800124:	4529                	li	a0,10
  800126:	bf4d                	j	8000d8 <syscall>

0000000000800128 <sys_putc>:
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_putc(int64_t c) {
  800128:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  80012a:	4579                	li	a0,30
  80012c:	b775                	j	8000d8 <syscall>

000000000080012e <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  80012e:	1141                	addi	sp,sp,-16
  800130:	e406                	sd	ra,8(sp)
    sys_exit(error_code);
  800132:	fe1ff0ef          	jal	ra,800112 <sys_exit>
    cprintf("BUG: exit failed.\n");
  800136:	00000517          	auipc	a0,0x0
  80013a:	57250513          	addi	a0,a0,1394 # 8006a8 <main+0x138>
  80013e:	f65ff0ef          	jal	ra,8000a2 <cprintf>
    while (1);
  800142:	a001                	j	800142 <exit+0x14>

0000000000800144 <fork>:
}

int
fork(void) {
    return sys_fork();
  800144:	bfd1                	j	800118 <sys_fork>

0000000000800146 <wait>:
}

int
wait(void) {
    return sys_wait(0, NULL);
  800146:	4581                	li	a1,0
  800148:	4501                	li	a0,0
  80014a:	bfc9                	j	80011c <sys_wait>

000000000080014c <waitpid>:
}

int
waitpid(int pid, int *store) {
    return sys_wait(pid, store);
  80014c:	bfc1                	j	80011c <sys_wait>

000000000080014e <yield>:
}

void
yield(void) {
    sys_yield();
  80014e:	bfd9                	j	800124 <sys_yield>

0000000000800150 <umain>:
/* Weak hook used only by divzero: if symbol exists, initialize to -1 so
 * division executes with a nonzero denominator and matches expected output. */
extern int zero __attribute__((weak));

void
umain(void) {
  800150:	1141                	addi	sp,sp,-16
  800152:	e406                	sd	ra,8(sp)
    if (&zero != 0) {
  800154:	00000793          	li	a5,0
  800158:	c399                	beqz	a5,80015e <umain+0xe>
        zero = -1;
  80015a:	577d                	li	a4,-1
  80015c:	c398                	sw	a4,0(a5)
    }
    int ret = main();
  80015e:	412000ef          	jal	ra,800570 <main>
    exit(ret);
  800162:	fcdff0ef          	jal	ra,80012e <exit>

0000000000800166 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  800166:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80016a:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  80016c:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800170:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  800172:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  800176:	f022                	sd	s0,32(sp)
  800178:	ec26                	sd	s1,24(sp)
  80017a:	e84a                	sd	s2,16(sp)
  80017c:	f406                	sd	ra,40(sp)
  80017e:	e44e                	sd	s3,8(sp)
  800180:	84aa                	mv	s1,a0
  800182:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  800184:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  800188:	2a01                	sext.w	s4,s4
    if (num >= base) {
  80018a:	03067e63          	bgeu	a2,a6,8001c6 <printnum+0x60>
  80018e:	89be                	mv	s3,a5
        while (-- width > 0)
  800190:	00805763          	blez	s0,80019e <printnum+0x38>
  800194:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  800196:	85ca                	mv	a1,s2
  800198:	854e                	mv	a0,s3
  80019a:	9482                	jalr	s1
        while (-- width > 0)
  80019c:	fc65                	bnez	s0,800194 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  80019e:	1a02                	slli	s4,s4,0x20
  8001a0:	00000797          	auipc	a5,0x0
  8001a4:	52078793          	addi	a5,a5,1312 # 8006c0 <main+0x150>
  8001a8:	020a5a13          	srli	s4,s4,0x20
  8001ac:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001ae:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001b0:	000a4503          	lbu	a0,0(s4)
}
  8001b4:	70a2                	ld	ra,40(sp)
  8001b6:	69a2                	ld	s3,8(sp)
  8001b8:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001ba:	85ca                	mv	a1,s2
  8001bc:	87a6                	mv	a5,s1
}
  8001be:	6942                	ld	s2,16(sp)
  8001c0:	64e2                	ld	s1,24(sp)
  8001c2:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  8001c4:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
  8001c6:	03065633          	divu	a2,a2,a6
  8001ca:	8722                	mv	a4,s0
  8001cc:	f9bff0ef          	jal	ra,800166 <printnum>
  8001d0:	b7f9                	j	80019e <printnum+0x38>

00000000008001d2 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  8001d2:	7119                	addi	sp,sp,-128
  8001d4:	f4a6                	sd	s1,104(sp)
  8001d6:	f0ca                	sd	s2,96(sp)
  8001d8:	ecce                	sd	s3,88(sp)
  8001da:	e8d2                	sd	s4,80(sp)
  8001dc:	e4d6                	sd	s5,72(sp)
  8001de:	e0da                	sd	s6,64(sp)
  8001e0:	fc5e                	sd	s7,56(sp)
  8001e2:	f06a                	sd	s10,32(sp)
  8001e4:	fc86                	sd	ra,120(sp)
  8001e6:	f8a2                	sd	s0,112(sp)
  8001e8:	f862                	sd	s8,48(sp)
  8001ea:	f466                	sd	s9,40(sp)
  8001ec:	ec6e                	sd	s11,24(sp)
  8001ee:	892a                	mv	s2,a0
  8001f0:	84ae                	mv	s1,a1
  8001f2:	8d32                	mv	s10,a2
  8001f4:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001f6:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  8001fa:	5b7d                	li	s6,-1
  8001fc:	00000a97          	auipc	s5,0x0
  800200:	4f8a8a93          	addi	s5,s5,1272 # 8006f4 <main+0x184>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800204:	00000b97          	auipc	s7,0x0
  800208:	70cb8b93          	addi	s7,s7,1804 # 800910 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80020c:	000d4503          	lbu	a0,0(s10)
  800210:	001d0413          	addi	s0,s10,1
  800214:	01350a63          	beq	a0,s3,800228 <vprintfmt+0x56>
            if (ch == '\0') {
  800218:	c121                	beqz	a0,800258 <vprintfmt+0x86>
            putch(ch, putdat);
  80021a:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80021c:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  80021e:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800220:	fff44503          	lbu	a0,-1(s0)
  800224:	ff351ae3          	bne	a0,s3,800218 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
  800228:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  80022c:	02000793          	li	a5,32
        lflag = altflag = 0;
  800230:	4c81                	li	s9,0
  800232:	4881                	li	a7,0
        width = precision = -1;
  800234:	5c7d                	li	s8,-1
  800236:	5dfd                	li	s11,-1
  800238:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  80023c:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  80023e:	fdd6059b          	addiw	a1,a2,-35
  800242:	0ff5f593          	zext.b	a1,a1
  800246:	00140d13          	addi	s10,s0,1
  80024a:	04b56263          	bltu	a0,a1,80028e <vprintfmt+0xbc>
  80024e:	058a                	slli	a1,a1,0x2
  800250:	95d6                	add	a1,a1,s5
  800252:	4194                	lw	a3,0(a1)
  800254:	96d6                	add	a3,a3,s5
  800256:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  800258:	70e6                	ld	ra,120(sp)
  80025a:	7446                	ld	s0,112(sp)
  80025c:	74a6                	ld	s1,104(sp)
  80025e:	7906                	ld	s2,96(sp)
  800260:	69e6                	ld	s3,88(sp)
  800262:	6a46                	ld	s4,80(sp)
  800264:	6aa6                	ld	s5,72(sp)
  800266:	6b06                	ld	s6,64(sp)
  800268:	7be2                	ld	s7,56(sp)
  80026a:	7c42                	ld	s8,48(sp)
  80026c:	7ca2                	ld	s9,40(sp)
  80026e:	7d02                	ld	s10,32(sp)
  800270:	6de2                	ld	s11,24(sp)
  800272:	6109                	addi	sp,sp,128
  800274:	8082                	ret
            padc = '0';
  800276:	87b2                	mv	a5,a2
            goto reswitch;
  800278:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80027c:	846a                	mv	s0,s10
  80027e:	00140d13          	addi	s10,s0,1
  800282:	fdd6059b          	addiw	a1,a2,-35
  800286:	0ff5f593          	zext.b	a1,a1
  80028a:	fcb572e3          	bgeu	a0,a1,80024e <vprintfmt+0x7c>
            putch('%', putdat);
  80028e:	85a6                	mv	a1,s1
  800290:	02500513          	li	a0,37
  800294:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800296:	fff44783          	lbu	a5,-1(s0)
  80029a:	8d22                	mv	s10,s0
  80029c:	f73788e3          	beq	a5,s3,80020c <vprintfmt+0x3a>
  8002a0:	ffed4783          	lbu	a5,-2(s10)
  8002a4:	1d7d                	addi	s10,s10,-1
  8002a6:	ff379de3          	bne	a5,s3,8002a0 <vprintfmt+0xce>
  8002aa:	b78d                	j	80020c <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002ac:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  8002b0:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002b4:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  8002b6:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  8002ba:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002be:	02d86463          	bltu	a6,a3,8002e6 <vprintfmt+0x114>
                ch = *fmt;
  8002c2:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  8002c6:	002c169b          	slliw	a3,s8,0x2
  8002ca:	0186873b          	addw	a4,a3,s8
  8002ce:	0017171b          	slliw	a4,a4,0x1
  8002d2:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  8002d4:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  8002d8:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  8002da:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  8002de:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002e2:	fed870e3          	bgeu	a6,a3,8002c2 <vprintfmt+0xf0>
            if (width < 0)
  8002e6:	f40ddce3          	bgez	s11,80023e <vprintfmt+0x6c>
                width = precision, precision = -1;
  8002ea:	8de2                	mv	s11,s8
  8002ec:	5c7d                	li	s8,-1
  8002ee:	bf81                	j	80023e <vprintfmt+0x6c>
            if (width < 0)
  8002f0:	fffdc693          	not	a3,s11
  8002f4:	96fd                	srai	a3,a3,0x3f
  8002f6:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
  8002fa:	00144603          	lbu	a2,1(s0)
  8002fe:	2d81                	sext.w	s11,s11
  800300:	846a                	mv	s0,s10
            goto reswitch;
  800302:	bf35                	j	80023e <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  800304:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
  800308:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  80030c:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  80030e:	846a                	mv	s0,s10
            goto process_precision;
  800310:	bfd9                	j	8002e6 <vprintfmt+0x114>
    if (lflag >= 2) {
  800312:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800314:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  800318:	01174463          	blt	a4,a7,800320 <vprintfmt+0x14e>
    else if (lflag) {
  80031c:	1a088e63          	beqz	a7,8004d8 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  800320:	000a3603          	ld	a2,0(s4)
  800324:	46c1                	li	a3,16
  800326:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  800328:	2781                	sext.w	a5,a5
  80032a:	876e                	mv	a4,s11
  80032c:	85a6                	mv	a1,s1
  80032e:	854a                	mv	a0,s2
  800330:	e37ff0ef          	jal	ra,800166 <printnum>
            break;
  800334:	bde1                	j	80020c <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  800336:	000a2503          	lw	a0,0(s4)
  80033a:	85a6                	mv	a1,s1
  80033c:	0a21                	addi	s4,s4,8
  80033e:	9902                	jalr	s2
            break;
  800340:	b5f1                	j	80020c <vprintfmt+0x3a>
    if (lflag >= 2) {
  800342:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800344:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  800348:	01174463          	blt	a4,a7,800350 <vprintfmt+0x17e>
    else if (lflag) {
  80034c:	18088163          	beqz	a7,8004ce <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  800350:	000a3603          	ld	a2,0(s4)
  800354:	46a9                	li	a3,10
  800356:	8a2e                	mv	s4,a1
  800358:	bfc1                	j	800328 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
  80035a:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  80035e:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  800360:	846a                	mv	s0,s10
            goto reswitch;
  800362:	bdf1                	j	80023e <vprintfmt+0x6c>
            putch(ch, putdat);
  800364:	85a6                	mv	a1,s1
  800366:	02500513          	li	a0,37
  80036a:	9902                	jalr	s2
            break;
  80036c:	b545                	j	80020c <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
  80036e:	00144603          	lbu	a2,1(s0)
            lflag ++;
  800372:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  800374:	846a                	mv	s0,s10
            goto reswitch;
  800376:	b5e1                	j	80023e <vprintfmt+0x6c>
    if (lflag >= 2) {
  800378:	4705                	li	a4,1
            precision = va_arg(ap, int);
  80037a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  80037e:	01174463          	blt	a4,a7,800386 <vprintfmt+0x1b4>
    else if (lflag) {
  800382:	14088163          	beqz	a7,8004c4 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800386:	000a3603          	ld	a2,0(s4)
  80038a:	46a1                	li	a3,8
  80038c:	8a2e                	mv	s4,a1
  80038e:	bf69                	j	800328 <vprintfmt+0x156>
            putch('0', putdat);
  800390:	03000513          	li	a0,48
  800394:	85a6                	mv	a1,s1
  800396:	e03e                	sd	a5,0(sp)
  800398:	9902                	jalr	s2
            putch('x', putdat);
  80039a:	85a6                	mv	a1,s1
  80039c:	07800513          	li	a0,120
  8003a0:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003a2:	0a21                	addi	s4,s4,8
            goto number;
  8003a4:	6782                	ld	a5,0(sp)
  8003a6:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003a8:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003ac:	bfb5                	j	800328 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003ae:	000a3403          	ld	s0,0(s4)
  8003b2:	008a0713          	addi	a4,s4,8
  8003b6:	e03a                	sd	a4,0(sp)
  8003b8:	14040263          	beqz	s0,8004fc <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  8003bc:	0fb05763          	blez	s11,8004aa <vprintfmt+0x2d8>
  8003c0:	02d00693          	li	a3,45
  8003c4:	0cd79163          	bne	a5,a3,800486 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003c8:	00044783          	lbu	a5,0(s0)
  8003cc:	0007851b          	sext.w	a0,a5
  8003d0:	cf85                	beqz	a5,800408 <vprintfmt+0x236>
  8003d2:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  8003d6:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003da:	000c4563          	bltz	s8,8003e4 <vprintfmt+0x212>
  8003de:	3c7d                	addiw	s8,s8,-1
  8003e0:	036c0263          	beq	s8,s6,800404 <vprintfmt+0x232>
                    putch('?', putdat);
  8003e4:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  8003e6:	0e0c8e63          	beqz	s9,8004e2 <vprintfmt+0x310>
  8003ea:	3781                	addiw	a5,a5,-32
  8003ec:	0ef47b63          	bgeu	s0,a5,8004e2 <vprintfmt+0x310>
                    putch('?', putdat);
  8003f0:	03f00513          	li	a0,63
  8003f4:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003f6:	000a4783          	lbu	a5,0(s4)
  8003fa:	3dfd                	addiw	s11,s11,-1
  8003fc:	0a05                	addi	s4,s4,1
  8003fe:	0007851b          	sext.w	a0,a5
  800402:	ffe1                	bnez	a5,8003da <vprintfmt+0x208>
            for (; width > 0; width --) {
  800404:	01b05963          	blez	s11,800416 <vprintfmt+0x244>
  800408:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  80040a:	85a6                	mv	a1,s1
  80040c:	02000513          	li	a0,32
  800410:	9902                	jalr	s2
            for (; width > 0; width --) {
  800412:	fe0d9be3          	bnez	s11,800408 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  800416:	6a02                	ld	s4,0(sp)
  800418:	bbd5                	j	80020c <vprintfmt+0x3a>
    if (lflag >= 2) {
  80041a:	4705                	li	a4,1
            precision = va_arg(ap, int);
  80041c:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
  800420:	01174463          	blt	a4,a7,800428 <vprintfmt+0x256>
    else if (lflag) {
  800424:	08088d63          	beqz	a7,8004be <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  800428:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  80042c:	0a044d63          	bltz	s0,8004e6 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  800430:	8622                	mv	a2,s0
  800432:	8a66                	mv	s4,s9
  800434:	46a9                	li	a3,10
  800436:	bdcd                	j	800328 <vprintfmt+0x156>
            err = va_arg(ap, int);
  800438:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80043c:	4761                	li	a4,24
            err = va_arg(ap, int);
  80043e:	0a21                	addi	s4,s4,8
            if (err < 0) {
  800440:	41f7d69b          	sraiw	a3,a5,0x1f
  800444:	8fb5                	xor	a5,a5,a3
  800446:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80044a:	02d74163          	blt	a4,a3,80046c <vprintfmt+0x29a>
  80044e:	00369793          	slli	a5,a3,0x3
  800452:	97de                	add	a5,a5,s7
  800454:	639c                	ld	a5,0(a5)
  800456:	cb99                	beqz	a5,80046c <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  800458:	86be                	mv	a3,a5
  80045a:	00000617          	auipc	a2,0x0
  80045e:	29660613          	addi	a2,a2,662 # 8006f0 <main+0x180>
  800462:	85a6                	mv	a1,s1
  800464:	854a                	mv	a0,s2
  800466:	0ce000ef          	jal	ra,800534 <printfmt>
  80046a:	b34d                	j	80020c <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  80046c:	00000617          	auipc	a2,0x0
  800470:	27460613          	addi	a2,a2,628 # 8006e0 <main+0x170>
  800474:	85a6                	mv	a1,s1
  800476:	854a                	mv	a0,s2
  800478:	0bc000ef          	jal	ra,800534 <printfmt>
  80047c:	bb41                	j	80020c <vprintfmt+0x3a>
                p = "(null)";
  80047e:	00000417          	auipc	s0,0x0
  800482:	25a40413          	addi	s0,s0,602 # 8006d8 <main+0x168>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800486:	85e2                	mv	a1,s8
  800488:	8522                	mv	a0,s0
  80048a:	e43e                	sd	a5,8(sp)
  80048c:	0c8000ef          	jal	ra,800554 <strnlen>
  800490:	40ad8dbb          	subw	s11,s11,a0
  800494:	01b05b63          	blez	s11,8004aa <vprintfmt+0x2d8>
                    putch(padc, putdat);
  800498:	67a2                	ld	a5,8(sp)
  80049a:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
  80049e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004a0:	85a6                	mv	a1,s1
  8004a2:	8552                	mv	a0,s4
  8004a4:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004a6:	fe0d9ce3          	bnez	s11,80049e <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004aa:	00044783          	lbu	a5,0(s0)
  8004ae:	00140a13          	addi	s4,s0,1
  8004b2:	0007851b          	sext.w	a0,a5
  8004b6:	d3a5                	beqz	a5,800416 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  8004b8:	05e00413          	li	s0,94
  8004bc:	bf39                	j	8003da <vprintfmt+0x208>
        return va_arg(*ap, int);
  8004be:	000a2403          	lw	s0,0(s4)
  8004c2:	b7ad                	j	80042c <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  8004c4:	000a6603          	lwu	a2,0(s4)
  8004c8:	46a1                	li	a3,8
  8004ca:	8a2e                	mv	s4,a1
  8004cc:	bdb1                	j	800328 <vprintfmt+0x156>
  8004ce:	000a6603          	lwu	a2,0(s4)
  8004d2:	46a9                	li	a3,10
  8004d4:	8a2e                	mv	s4,a1
  8004d6:	bd89                	j	800328 <vprintfmt+0x156>
  8004d8:	000a6603          	lwu	a2,0(s4)
  8004dc:	46c1                	li	a3,16
  8004de:	8a2e                	mv	s4,a1
  8004e0:	b5a1                	j	800328 <vprintfmt+0x156>
                    putch(ch, putdat);
  8004e2:	9902                	jalr	s2
  8004e4:	bf09                	j	8003f6 <vprintfmt+0x224>
                putch('-', putdat);
  8004e6:	85a6                	mv	a1,s1
  8004e8:	02d00513          	li	a0,45
  8004ec:	e03e                	sd	a5,0(sp)
  8004ee:	9902                	jalr	s2
                num = -(long long)num;
  8004f0:	6782                	ld	a5,0(sp)
  8004f2:	8a66                	mv	s4,s9
  8004f4:	40800633          	neg	a2,s0
  8004f8:	46a9                	li	a3,10
  8004fa:	b53d                	j	800328 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  8004fc:	03b05163          	blez	s11,80051e <vprintfmt+0x34c>
  800500:	02d00693          	li	a3,45
  800504:	f6d79de3          	bne	a5,a3,80047e <vprintfmt+0x2ac>
                p = "(null)";
  800508:	00000417          	auipc	s0,0x0
  80050c:	1d040413          	addi	s0,s0,464 # 8006d8 <main+0x168>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800510:	02800793          	li	a5,40
  800514:	02800513          	li	a0,40
  800518:	00140a13          	addi	s4,s0,1
  80051c:	bd6d                	j	8003d6 <vprintfmt+0x204>
  80051e:	00000a17          	auipc	s4,0x0
  800522:	1bba0a13          	addi	s4,s4,443 # 8006d9 <main+0x169>
  800526:	02800513          	li	a0,40
  80052a:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  80052e:	05e00413          	li	s0,94
  800532:	b565                	j	8003da <vprintfmt+0x208>

0000000000800534 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800534:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  800536:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80053a:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80053c:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80053e:	ec06                	sd	ra,24(sp)
  800540:	f83a                	sd	a4,48(sp)
  800542:	fc3e                	sd	a5,56(sp)
  800544:	e0c2                	sd	a6,64(sp)
  800546:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800548:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80054a:	c89ff0ef          	jal	ra,8001d2 <vprintfmt>
}
  80054e:	60e2                	ld	ra,24(sp)
  800550:	6161                	addi	sp,sp,80
  800552:	8082                	ret

0000000000800554 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
  800554:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
  800556:	e589                	bnez	a1,800560 <strnlen+0xc>
  800558:	a811                	j	80056c <strnlen+0x18>
        cnt ++;
  80055a:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
  80055c:	00f58863          	beq	a1,a5,80056c <strnlen+0x18>
  800560:	00f50733          	add	a4,a0,a5
  800564:	00074703          	lbu	a4,0(a4)
  800568:	fb6d                	bnez	a4,80055a <strnlen+0x6>
  80056a:	85be                	mv	a1,a5
    }
    return cnt;
}
  80056c:	852e                	mv	a0,a1
  80056e:	8082                	ret

0000000000800570 <main>:
#include <ulib.h>

int magic = -0x10384;

int
main(void) {
  800570:	1101                	addi	sp,sp,-32
    int pid, code;
    cprintf("I am the parent. Forking the child...\n");
  800572:	00000517          	auipc	a0,0x0
  800576:	46650513          	addi	a0,a0,1126 # 8009d8 <error_string+0xc8>
main(void) {
  80057a:	ec06                	sd	ra,24(sp)
  80057c:	e822                	sd	s0,16(sp)
    cprintf("I am the parent. Forking the child...\n");
  80057e:	b25ff0ef          	jal	ra,8000a2 <cprintf>
    if ((pid = fork()) == 0) {
  800582:	bc3ff0ef          	jal	ra,800144 <fork>
  800586:	c561                	beqz	a0,80064e <main+0xde>
  800588:	842a                	mv	s0,a0
        yield();
        yield();
        exit(magic);
    }
    else {
        cprintf("I am parent, fork a child pid %d\n",pid);
  80058a:	85aa                	mv	a1,a0
  80058c:	00000517          	auipc	a0,0x0
  800590:	48c50513          	addi	a0,a0,1164 # 800a18 <error_string+0x108>
  800594:	b0fff0ef          	jal	ra,8000a2 <cprintf>
    }
    assert(pid > 0);
  800598:	08805c63          	blez	s0,800630 <main+0xc0>
    cprintf("I am the parent, waiting now..\n");
  80059c:	00000517          	auipc	a0,0x0
  8005a0:	4d450513          	addi	a0,a0,1236 # 800a70 <error_string+0x160>
  8005a4:	affff0ef          	jal	ra,8000a2 <cprintf>

    assert(waitpid(pid, &code) == 0 && code == magic);
  8005a8:	006c                	addi	a1,sp,12
  8005aa:	8522                	mv	a0,s0
  8005ac:	ba1ff0ef          	jal	ra,80014c <waitpid>
  8005b0:	e131                	bnez	a0,8005f4 <main+0x84>
  8005b2:	4732                	lw	a4,12(sp)
  8005b4:	00001797          	auipc	a5,0x1
  8005b8:	a4c7a783          	lw	a5,-1460(a5) # 801000 <magic>
  8005bc:	02f71c63          	bne	a4,a5,8005f4 <main+0x84>
    assert(waitpid(pid, &code) != 0 && wait() != 0);
  8005c0:	006c                	addi	a1,sp,12
  8005c2:	8522                	mv	a0,s0
  8005c4:	b89ff0ef          	jal	ra,80014c <waitpid>
  8005c8:	c529                	beqz	a0,800612 <main+0xa2>
  8005ca:	b7dff0ef          	jal	ra,800146 <wait>
  8005ce:	c131                	beqz	a0,800612 <main+0xa2>
    cprintf("waitpid %d ok.\n", pid);
  8005d0:	85a2                	mv	a1,s0
  8005d2:	00000517          	auipc	a0,0x0
  8005d6:	51650513          	addi	a0,a0,1302 # 800ae8 <error_string+0x1d8>
  8005da:	ac9ff0ef          	jal	ra,8000a2 <cprintf>

    cprintf("exit pass.\n");
  8005de:	00000517          	auipc	a0,0x0
  8005e2:	51a50513          	addi	a0,a0,1306 # 800af8 <error_string+0x1e8>
  8005e6:	abdff0ef          	jal	ra,8000a2 <cprintf>
    return 0;
}
  8005ea:	60e2                	ld	ra,24(sp)
  8005ec:	6442                	ld	s0,16(sp)
  8005ee:	4501                	li	a0,0
  8005f0:	6105                	addi	sp,sp,32
  8005f2:	8082                	ret
    assert(waitpid(pid, &code) == 0 && code == magic);
  8005f4:	00000697          	auipc	a3,0x0
  8005f8:	49c68693          	addi	a3,a3,1180 # 800a90 <error_string+0x180>
  8005fc:	00000617          	auipc	a2,0x0
  800600:	44c60613          	addi	a2,a2,1100 # 800a48 <error_string+0x138>
  800604:	45ed                	li	a1,27
  800606:	00000517          	auipc	a0,0x0
  80060a:	45a50513          	addi	a0,a0,1114 # 800a60 <error_string+0x150>
  80060e:	a19ff0ef          	jal	ra,800026 <__panic>
    assert(waitpid(pid, &code) != 0 && wait() != 0);
  800612:	00000697          	auipc	a3,0x0
  800616:	4ae68693          	addi	a3,a3,1198 # 800ac0 <error_string+0x1b0>
  80061a:	00000617          	auipc	a2,0x0
  80061e:	42e60613          	addi	a2,a2,1070 # 800a48 <error_string+0x138>
  800622:	45f1                	li	a1,28
  800624:	00000517          	auipc	a0,0x0
  800628:	43c50513          	addi	a0,a0,1084 # 800a60 <error_string+0x150>
  80062c:	9fbff0ef          	jal	ra,800026 <__panic>
    assert(pid > 0);
  800630:	00000697          	auipc	a3,0x0
  800634:	41068693          	addi	a3,a3,1040 # 800a40 <error_string+0x130>
  800638:	00000617          	auipc	a2,0x0
  80063c:	41060613          	addi	a2,a2,1040 # 800a48 <error_string+0x138>
  800640:	45e1                	li	a1,24
  800642:	00000517          	auipc	a0,0x0
  800646:	41e50513          	addi	a0,a0,1054 # 800a60 <error_string+0x150>
  80064a:	9ddff0ef          	jal	ra,800026 <__panic>
        cprintf("I am the child.\n");
  80064e:	00000517          	auipc	a0,0x0
  800652:	3b250513          	addi	a0,a0,946 # 800a00 <error_string+0xf0>
  800656:	a4dff0ef          	jal	ra,8000a2 <cprintf>
        yield();
  80065a:	af5ff0ef          	jal	ra,80014e <yield>
        yield();
  80065e:	af1ff0ef          	jal	ra,80014e <yield>
        yield();
  800662:	aedff0ef          	jal	ra,80014e <yield>
        yield();
  800666:	ae9ff0ef          	jal	ra,80014e <yield>
        yield();
  80066a:	ae5ff0ef          	jal	ra,80014e <yield>
        yield();
  80066e:	ae1ff0ef          	jal	ra,80014e <yield>
        yield();
  800672:	addff0ef          	jal	ra,80014e <yield>
        exit(magic);
  800676:	00001517          	auipc	a0,0x1
  80067a:	98a52503          	lw	a0,-1654(a0) # 801000 <magic>
  80067e:	ab1ff0ef          	jal	ra,80012e <exit>
