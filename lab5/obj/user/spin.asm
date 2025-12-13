
obj/__user_spin.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <_start>:
.text
.globl _start
_start:
    # call user-program function
    call umain
  800020:	132000ef          	jal	ra,800152 <umain>
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
  80003a:	60a50513          	addi	a0,a0,1546 # 800640 <main+0xce>
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
  800056:	00000517          	auipc	a0,0x0
  80005a:	60a50513          	addi	a0,a0,1546 # 800660 <main+0xee>
  80005e:	044000ef          	jal	ra,8000a2 <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  800062:	5559                	li	a0,-10
  800064:	0d0000ef          	jal	ra,800134 <exit>

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
  800070:	0be000ef          	jal	ra,80012e <sys_putc>
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
  800096:	13e000ef          	jal	ra,8001d4 <vprintfmt>
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
  8000cc:	108000ef          	jal	ra,8001d4 <vprintfmt>
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

0000000000800128 <sys_kill>:
}

int
sys_kill(int64_t pid) {
  800128:	85aa                	mv	a1,a0
    return syscall(SYS_kill, pid);
  80012a:	4531                	li	a0,12
  80012c:	b775                	j	8000d8 <syscall>

000000000080012e <sys_putc>:
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_putc(int64_t c) {
  80012e:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  800130:	4579                	li	a0,30
  800132:	b75d                	j	8000d8 <syscall>

0000000000800134 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  800134:	1141                	addi	sp,sp,-16
  800136:	e406                	sd	ra,8(sp)
    sys_exit(error_code);
  800138:	fdbff0ef          	jal	ra,800112 <sys_exit>
    cprintf("BUG: exit failed.\n");
  80013c:	00000517          	auipc	a0,0x0
  800140:	52c50513          	addi	a0,a0,1324 # 800668 <main+0xf6>
  800144:	f5fff0ef          	jal	ra,8000a2 <cprintf>
    while (1);
  800148:	a001                	j	800148 <exit+0x14>

000000000080014a <fork>:
}

int
fork(void) {
    return sys_fork();
  80014a:	b7f9                	j	800118 <sys_fork>

000000000080014c <waitpid>:
    return sys_wait(0, NULL);
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

0000000000800150 <kill>:
}

int
kill(int pid) {
    return sys_kill(pid);
  800150:	bfe1                	j	800128 <sys_kill>

0000000000800152 <umain>:
/* Weak hook used only by divzero: if symbol exists, initialize to -1 so
 * division executes with a nonzero denominator and matches expected output. */
extern int zero __attribute__((weak));

void
umain(void) {
  800152:	1141                	addi	sp,sp,-16
  800154:	e406                	sd	ra,8(sp)
    if (&zero != 0) {
  800156:	00000793          	li	a5,0
  80015a:	c399                	beqz	a5,800160 <umain+0xe>
        zero = -1;
  80015c:	577d                	li	a4,-1
  80015e:	c398                	sw	a4,0(a5)
    }
    int ret = main();
  800160:	412000ef          	jal	ra,800572 <main>
    exit(ret);
  800164:	fd1ff0ef          	jal	ra,800134 <exit>

0000000000800168 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  800168:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80016c:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  80016e:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800172:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  800174:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  800178:	f022                	sd	s0,32(sp)
  80017a:	ec26                	sd	s1,24(sp)
  80017c:	e84a                	sd	s2,16(sp)
  80017e:	f406                	sd	ra,40(sp)
  800180:	e44e                	sd	s3,8(sp)
  800182:	84aa                	mv	s1,a0
  800184:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  800186:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  80018a:	2a01                	sext.w	s4,s4
    if (num >= base) {
  80018c:	03067e63          	bgeu	a2,a6,8001c8 <printnum+0x60>
  800190:	89be                	mv	s3,a5
        while (-- width > 0)
  800192:	00805763          	blez	s0,8001a0 <printnum+0x38>
  800196:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  800198:	85ca                	mv	a1,s2
  80019a:	854e                	mv	a0,s3
  80019c:	9482                	jalr	s1
        while (-- width > 0)
  80019e:	fc65                	bnez	s0,800196 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8001a0:	1a02                	slli	s4,s4,0x20
  8001a2:	00000797          	auipc	a5,0x0
  8001a6:	4de78793          	addi	a5,a5,1246 # 800680 <main+0x10e>
  8001aa:	020a5a13          	srli	s4,s4,0x20
  8001ae:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001b0:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001b2:	000a4503          	lbu	a0,0(s4)
}
  8001b6:	70a2                	ld	ra,40(sp)
  8001b8:	69a2                	ld	s3,8(sp)
  8001ba:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001bc:	85ca                	mv	a1,s2
  8001be:	87a6                	mv	a5,s1
}
  8001c0:	6942                	ld	s2,16(sp)
  8001c2:	64e2                	ld	s1,24(sp)
  8001c4:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  8001c6:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
  8001c8:	03065633          	divu	a2,a2,a6
  8001cc:	8722                	mv	a4,s0
  8001ce:	f9bff0ef          	jal	ra,800168 <printnum>
  8001d2:	b7f9                	j	8001a0 <printnum+0x38>

00000000008001d4 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  8001d4:	7119                	addi	sp,sp,-128
  8001d6:	f4a6                	sd	s1,104(sp)
  8001d8:	f0ca                	sd	s2,96(sp)
  8001da:	ecce                	sd	s3,88(sp)
  8001dc:	e8d2                	sd	s4,80(sp)
  8001de:	e4d6                	sd	s5,72(sp)
  8001e0:	e0da                	sd	s6,64(sp)
  8001e2:	fc5e                	sd	s7,56(sp)
  8001e4:	f06a                	sd	s10,32(sp)
  8001e6:	fc86                	sd	ra,120(sp)
  8001e8:	f8a2                	sd	s0,112(sp)
  8001ea:	f862                	sd	s8,48(sp)
  8001ec:	f466                	sd	s9,40(sp)
  8001ee:	ec6e                	sd	s11,24(sp)
  8001f0:	892a                	mv	s2,a0
  8001f2:	84ae                	mv	s1,a1
  8001f4:	8d32                	mv	s10,a2
  8001f6:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001f8:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  8001fc:	5b7d                	li	s6,-1
  8001fe:	00000a97          	auipc	s5,0x0
  800202:	4b6a8a93          	addi	s5,s5,1206 # 8006b4 <main+0x142>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800206:	00000b97          	auipc	s7,0x0
  80020a:	6cab8b93          	addi	s7,s7,1738 # 8008d0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80020e:	000d4503          	lbu	a0,0(s10)
  800212:	001d0413          	addi	s0,s10,1
  800216:	01350a63          	beq	a0,s3,80022a <vprintfmt+0x56>
            if (ch == '\0') {
  80021a:	c121                	beqz	a0,80025a <vprintfmt+0x86>
            putch(ch, putdat);
  80021c:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80021e:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  800220:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800222:	fff44503          	lbu	a0,-1(s0)
  800226:	ff351ae3          	bne	a0,s3,80021a <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
  80022a:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  80022e:	02000793          	li	a5,32
        lflag = altflag = 0;
  800232:	4c81                	li	s9,0
  800234:	4881                	li	a7,0
        width = precision = -1;
  800236:	5c7d                	li	s8,-1
  800238:	5dfd                	li	s11,-1
  80023a:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  80023e:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  800240:	fdd6059b          	addiw	a1,a2,-35
  800244:	0ff5f593          	zext.b	a1,a1
  800248:	00140d13          	addi	s10,s0,1
  80024c:	04b56263          	bltu	a0,a1,800290 <vprintfmt+0xbc>
  800250:	058a                	slli	a1,a1,0x2
  800252:	95d6                	add	a1,a1,s5
  800254:	4194                	lw	a3,0(a1)
  800256:	96d6                	add	a3,a3,s5
  800258:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  80025a:	70e6                	ld	ra,120(sp)
  80025c:	7446                	ld	s0,112(sp)
  80025e:	74a6                	ld	s1,104(sp)
  800260:	7906                	ld	s2,96(sp)
  800262:	69e6                	ld	s3,88(sp)
  800264:	6a46                	ld	s4,80(sp)
  800266:	6aa6                	ld	s5,72(sp)
  800268:	6b06                	ld	s6,64(sp)
  80026a:	7be2                	ld	s7,56(sp)
  80026c:	7c42                	ld	s8,48(sp)
  80026e:	7ca2                	ld	s9,40(sp)
  800270:	7d02                	ld	s10,32(sp)
  800272:	6de2                	ld	s11,24(sp)
  800274:	6109                	addi	sp,sp,128
  800276:	8082                	ret
            padc = '0';
  800278:	87b2                	mv	a5,a2
            goto reswitch;
  80027a:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80027e:	846a                	mv	s0,s10
  800280:	00140d13          	addi	s10,s0,1
  800284:	fdd6059b          	addiw	a1,a2,-35
  800288:	0ff5f593          	zext.b	a1,a1
  80028c:	fcb572e3          	bgeu	a0,a1,800250 <vprintfmt+0x7c>
            putch('%', putdat);
  800290:	85a6                	mv	a1,s1
  800292:	02500513          	li	a0,37
  800296:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800298:	fff44783          	lbu	a5,-1(s0)
  80029c:	8d22                	mv	s10,s0
  80029e:	f73788e3          	beq	a5,s3,80020e <vprintfmt+0x3a>
  8002a2:	ffed4783          	lbu	a5,-2(s10)
  8002a6:	1d7d                	addi	s10,s10,-1
  8002a8:	ff379de3          	bne	a5,s3,8002a2 <vprintfmt+0xce>
  8002ac:	b78d                	j	80020e <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002ae:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  8002b2:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002b6:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  8002b8:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  8002bc:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002c0:	02d86463          	bltu	a6,a3,8002e8 <vprintfmt+0x114>
                ch = *fmt;
  8002c4:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  8002c8:	002c169b          	slliw	a3,s8,0x2
  8002cc:	0186873b          	addw	a4,a3,s8
  8002d0:	0017171b          	slliw	a4,a4,0x1
  8002d4:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  8002d6:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  8002da:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  8002dc:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  8002e0:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002e4:	fed870e3          	bgeu	a6,a3,8002c4 <vprintfmt+0xf0>
            if (width < 0)
  8002e8:	f40ddce3          	bgez	s11,800240 <vprintfmt+0x6c>
                width = precision, precision = -1;
  8002ec:	8de2                	mv	s11,s8
  8002ee:	5c7d                	li	s8,-1
  8002f0:	bf81                	j	800240 <vprintfmt+0x6c>
            if (width < 0)
  8002f2:	fffdc693          	not	a3,s11
  8002f6:	96fd                	srai	a3,a3,0x3f
  8002f8:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
  8002fc:	00144603          	lbu	a2,1(s0)
  800300:	2d81                	sext.w	s11,s11
  800302:	846a                	mv	s0,s10
            goto reswitch;
  800304:	bf35                	j	800240 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  800306:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
  80030a:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  80030e:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  800310:	846a                	mv	s0,s10
            goto process_precision;
  800312:	bfd9                	j	8002e8 <vprintfmt+0x114>
    if (lflag >= 2) {
  800314:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800316:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  80031a:	01174463          	blt	a4,a7,800322 <vprintfmt+0x14e>
    else if (lflag) {
  80031e:	1a088e63          	beqz	a7,8004da <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  800322:	000a3603          	ld	a2,0(s4)
  800326:	46c1                	li	a3,16
  800328:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  80032a:	2781                	sext.w	a5,a5
  80032c:	876e                	mv	a4,s11
  80032e:	85a6                	mv	a1,s1
  800330:	854a                	mv	a0,s2
  800332:	e37ff0ef          	jal	ra,800168 <printnum>
            break;
  800336:	bde1                	j	80020e <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  800338:	000a2503          	lw	a0,0(s4)
  80033c:	85a6                	mv	a1,s1
  80033e:	0a21                	addi	s4,s4,8
  800340:	9902                	jalr	s2
            break;
  800342:	b5f1                	j	80020e <vprintfmt+0x3a>
    if (lflag >= 2) {
  800344:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800346:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  80034a:	01174463          	blt	a4,a7,800352 <vprintfmt+0x17e>
    else if (lflag) {
  80034e:	18088163          	beqz	a7,8004d0 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  800352:	000a3603          	ld	a2,0(s4)
  800356:	46a9                	li	a3,10
  800358:	8a2e                	mv	s4,a1
  80035a:	bfc1                	j	80032a <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
  80035c:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  800360:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  800362:	846a                	mv	s0,s10
            goto reswitch;
  800364:	bdf1                	j	800240 <vprintfmt+0x6c>
            putch(ch, putdat);
  800366:	85a6                	mv	a1,s1
  800368:	02500513          	li	a0,37
  80036c:	9902                	jalr	s2
            break;
  80036e:	b545                	j	80020e <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
  800370:	00144603          	lbu	a2,1(s0)
            lflag ++;
  800374:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  800376:	846a                	mv	s0,s10
            goto reswitch;
  800378:	b5e1                	j	800240 <vprintfmt+0x6c>
    if (lflag >= 2) {
  80037a:	4705                	li	a4,1
            precision = va_arg(ap, int);
  80037c:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  800380:	01174463          	blt	a4,a7,800388 <vprintfmt+0x1b4>
    else if (lflag) {
  800384:	14088163          	beqz	a7,8004c6 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800388:	000a3603          	ld	a2,0(s4)
  80038c:	46a1                	li	a3,8
  80038e:	8a2e                	mv	s4,a1
  800390:	bf69                	j	80032a <vprintfmt+0x156>
            putch('0', putdat);
  800392:	03000513          	li	a0,48
  800396:	85a6                	mv	a1,s1
  800398:	e03e                	sd	a5,0(sp)
  80039a:	9902                	jalr	s2
            putch('x', putdat);
  80039c:	85a6                	mv	a1,s1
  80039e:	07800513          	li	a0,120
  8003a2:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003a4:	0a21                	addi	s4,s4,8
            goto number;
  8003a6:	6782                	ld	a5,0(sp)
  8003a8:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003aa:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003ae:	bfb5                	j	80032a <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003b0:	000a3403          	ld	s0,0(s4)
  8003b4:	008a0713          	addi	a4,s4,8
  8003b8:	e03a                	sd	a4,0(sp)
  8003ba:	14040263          	beqz	s0,8004fe <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  8003be:	0fb05763          	blez	s11,8004ac <vprintfmt+0x2d8>
  8003c2:	02d00693          	li	a3,45
  8003c6:	0cd79163          	bne	a5,a3,800488 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003ca:	00044783          	lbu	a5,0(s0)
  8003ce:	0007851b          	sext.w	a0,a5
  8003d2:	cf85                	beqz	a5,80040a <vprintfmt+0x236>
  8003d4:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  8003d8:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003dc:	000c4563          	bltz	s8,8003e6 <vprintfmt+0x212>
  8003e0:	3c7d                	addiw	s8,s8,-1
  8003e2:	036c0263          	beq	s8,s6,800406 <vprintfmt+0x232>
                    putch('?', putdat);
  8003e6:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  8003e8:	0e0c8e63          	beqz	s9,8004e4 <vprintfmt+0x310>
  8003ec:	3781                	addiw	a5,a5,-32
  8003ee:	0ef47b63          	bgeu	s0,a5,8004e4 <vprintfmt+0x310>
                    putch('?', putdat);
  8003f2:	03f00513          	li	a0,63
  8003f6:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003f8:	000a4783          	lbu	a5,0(s4)
  8003fc:	3dfd                	addiw	s11,s11,-1
  8003fe:	0a05                	addi	s4,s4,1
  800400:	0007851b          	sext.w	a0,a5
  800404:	ffe1                	bnez	a5,8003dc <vprintfmt+0x208>
            for (; width > 0; width --) {
  800406:	01b05963          	blez	s11,800418 <vprintfmt+0x244>
  80040a:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  80040c:	85a6                	mv	a1,s1
  80040e:	02000513          	li	a0,32
  800412:	9902                	jalr	s2
            for (; width > 0; width --) {
  800414:	fe0d9be3          	bnez	s11,80040a <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  800418:	6a02                	ld	s4,0(sp)
  80041a:	bbd5                	j	80020e <vprintfmt+0x3a>
    if (lflag >= 2) {
  80041c:	4705                	li	a4,1
            precision = va_arg(ap, int);
  80041e:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
  800422:	01174463          	blt	a4,a7,80042a <vprintfmt+0x256>
    else if (lflag) {
  800426:	08088d63          	beqz	a7,8004c0 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  80042a:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  80042e:	0a044d63          	bltz	s0,8004e8 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  800432:	8622                	mv	a2,s0
  800434:	8a66                	mv	s4,s9
  800436:	46a9                	li	a3,10
  800438:	bdcd                	j	80032a <vprintfmt+0x156>
            err = va_arg(ap, int);
  80043a:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80043e:	4761                	li	a4,24
            err = va_arg(ap, int);
  800440:	0a21                	addi	s4,s4,8
            if (err < 0) {
  800442:	41f7d69b          	sraiw	a3,a5,0x1f
  800446:	8fb5                	xor	a5,a5,a3
  800448:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80044c:	02d74163          	blt	a4,a3,80046e <vprintfmt+0x29a>
  800450:	00369793          	slli	a5,a3,0x3
  800454:	97de                	add	a5,a5,s7
  800456:	639c                	ld	a5,0(a5)
  800458:	cb99                	beqz	a5,80046e <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  80045a:	86be                	mv	a3,a5
  80045c:	00000617          	auipc	a2,0x0
  800460:	25460613          	addi	a2,a2,596 # 8006b0 <main+0x13e>
  800464:	85a6                	mv	a1,s1
  800466:	854a                	mv	a0,s2
  800468:	0ce000ef          	jal	ra,800536 <printfmt>
  80046c:	b34d                	j	80020e <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  80046e:	00000617          	auipc	a2,0x0
  800472:	23260613          	addi	a2,a2,562 # 8006a0 <main+0x12e>
  800476:	85a6                	mv	a1,s1
  800478:	854a                	mv	a0,s2
  80047a:	0bc000ef          	jal	ra,800536 <printfmt>
  80047e:	bb41                	j	80020e <vprintfmt+0x3a>
                p = "(null)";
  800480:	00000417          	auipc	s0,0x0
  800484:	21840413          	addi	s0,s0,536 # 800698 <main+0x126>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800488:	85e2                	mv	a1,s8
  80048a:	8522                	mv	a0,s0
  80048c:	e43e                	sd	a5,8(sp)
  80048e:	0c8000ef          	jal	ra,800556 <strnlen>
  800492:	40ad8dbb          	subw	s11,s11,a0
  800496:	01b05b63          	blez	s11,8004ac <vprintfmt+0x2d8>
                    putch(padc, putdat);
  80049a:	67a2                	ld	a5,8(sp)
  80049c:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004a0:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004a2:	85a6                	mv	a1,s1
  8004a4:	8552                	mv	a0,s4
  8004a6:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004a8:	fe0d9ce3          	bnez	s11,8004a0 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004ac:	00044783          	lbu	a5,0(s0)
  8004b0:	00140a13          	addi	s4,s0,1
  8004b4:	0007851b          	sext.w	a0,a5
  8004b8:	d3a5                	beqz	a5,800418 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  8004ba:	05e00413          	li	s0,94
  8004be:	bf39                	j	8003dc <vprintfmt+0x208>
        return va_arg(*ap, int);
  8004c0:	000a2403          	lw	s0,0(s4)
  8004c4:	b7ad                	j	80042e <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  8004c6:	000a6603          	lwu	a2,0(s4)
  8004ca:	46a1                	li	a3,8
  8004cc:	8a2e                	mv	s4,a1
  8004ce:	bdb1                	j	80032a <vprintfmt+0x156>
  8004d0:	000a6603          	lwu	a2,0(s4)
  8004d4:	46a9                	li	a3,10
  8004d6:	8a2e                	mv	s4,a1
  8004d8:	bd89                	j	80032a <vprintfmt+0x156>
  8004da:	000a6603          	lwu	a2,0(s4)
  8004de:	46c1                	li	a3,16
  8004e0:	8a2e                	mv	s4,a1
  8004e2:	b5a1                	j	80032a <vprintfmt+0x156>
                    putch(ch, putdat);
  8004e4:	9902                	jalr	s2
  8004e6:	bf09                	j	8003f8 <vprintfmt+0x224>
                putch('-', putdat);
  8004e8:	85a6                	mv	a1,s1
  8004ea:	02d00513          	li	a0,45
  8004ee:	e03e                	sd	a5,0(sp)
  8004f0:	9902                	jalr	s2
                num = -(long long)num;
  8004f2:	6782                	ld	a5,0(sp)
  8004f4:	8a66                	mv	s4,s9
  8004f6:	40800633          	neg	a2,s0
  8004fa:	46a9                	li	a3,10
  8004fc:	b53d                	j	80032a <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  8004fe:	03b05163          	blez	s11,800520 <vprintfmt+0x34c>
  800502:	02d00693          	li	a3,45
  800506:	f6d79de3          	bne	a5,a3,800480 <vprintfmt+0x2ac>
                p = "(null)";
  80050a:	00000417          	auipc	s0,0x0
  80050e:	18e40413          	addi	s0,s0,398 # 800698 <main+0x126>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800512:	02800793          	li	a5,40
  800516:	02800513          	li	a0,40
  80051a:	00140a13          	addi	s4,s0,1
  80051e:	bd6d                	j	8003d8 <vprintfmt+0x204>
  800520:	00000a17          	auipc	s4,0x0
  800524:	179a0a13          	addi	s4,s4,377 # 800699 <main+0x127>
  800528:	02800513          	li	a0,40
  80052c:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  800530:	05e00413          	li	s0,94
  800534:	b565                	j	8003dc <vprintfmt+0x208>

0000000000800536 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800536:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  800538:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80053c:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80053e:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800540:	ec06                	sd	ra,24(sp)
  800542:	f83a                	sd	a4,48(sp)
  800544:	fc3e                	sd	a5,56(sp)
  800546:	e0c2                	sd	a6,64(sp)
  800548:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  80054a:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80054c:	c89ff0ef          	jal	ra,8001d4 <vprintfmt>
}
  800550:	60e2                	ld	ra,24(sp)
  800552:	6161                	addi	sp,sp,80
  800554:	8082                	ret

0000000000800556 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
  800556:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
  800558:	e589                	bnez	a1,800562 <strnlen+0xc>
  80055a:	a811                	j	80056e <strnlen+0x18>
        cnt ++;
  80055c:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
  80055e:	00f58863          	beq	a1,a5,80056e <strnlen+0x18>
  800562:	00f50733          	add	a4,a0,a5
  800566:	00074703          	lbu	a4,0(a4)
  80056a:	fb6d                	bnez	a4,80055c <strnlen+0x6>
  80056c:	85be                	mv	a1,a5
    }
    return cnt;
}
  80056e:	852e                	mv	a0,a1
  800570:	8082                	ret

0000000000800572 <main>:
#include <stdio.h>
#include <ulib.h>

int
main(void) {
  800572:	1141                	addi	sp,sp,-16
    int pid, ret;
    cprintf("I am the parent. Forking the child...\n");
  800574:	00000517          	auipc	a0,0x0
  800578:	42450513          	addi	a0,a0,1060 # 800998 <error_string+0xc8>
main(void) {
  80057c:	e406                	sd	ra,8(sp)
  80057e:	e022                	sd	s0,0(sp)
    cprintf("I am the parent. Forking the child...\n");
  800580:	b23ff0ef          	jal	ra,8000a2 <cprintf>
    if ((pid = fork()) == 0) {
  800584:	bc7ff0ef          	jal	ra,80014a <fork>
  800588:	e901                	bnez	a0,800598 <main+0x26>
        cprintf("I am the child. spinning ...\n");
  80058a:	00000517          	auipc	a0,0x0
  80058e:	43650513          	addi	a0,a0,1078 # 8009c0 <error_string+0xf0>
  800592:	b11ff0ef          	jal	ra,8000a2 <cprintf>
        while (1);
  800596:	a001                	j	800596 <main+0x24>
    }
    cprintf("I am the parent. Running the child...\n");
  800598:	842a                	mv	s0,a0
  80059a:	00000517          	auipc	a0,0x0
  80059e:	44650513          	addi	a0,a0,1094 # 8009e0 <error_string+0x110>
  8005a2:	b01ff0ef          	jal	ra,8000a2 <cprintf>

    yield();
  8005a6:	ba9ff0ef          	jal	ra,80014e <yield>
    yield();
  8005aa:	ba5ff0ef          	jal	ra,80014e <yield>
    yield();
  8005ae:	ba1ff0ef          	jal	ra,80014e <yield>

    cprintf("I am the parent.  Killing the child...\n");
  8005b2:	00000517          	auipc	a0,0x0
  8005b6:	45650513          	addi	a0,a0,1110 # 800a08 <error_string+0x138>
  8005ba:	ae9ff0ef          	jal	ra,8000a2 <cprintf>

    assert((ret = kill(pid)) == 0);
  8005be:	8522                	mv	a0,s0
  8005c0:	b91ff0ef          	jal	ra,800150 <kill>
  8005c4:	ed31                	bnez	a0,800620 <main+0xae>
    cprintf("kill returns %d\n", ret);
  8005c6:	4581                	li	a1,0
  8005c8:	00000517          	auipc	a0,0x0
  8005cc:	4a850513          	addi	a0,a0,1192 # 800a70 <error_string+0x1a0>
  8005d0:	ad3ff0ef          	jal	ra,8000a2 <cprintf>

    assert((ret = waitpid(pid, NULL)) == 0);
  8005d4:	4581                	li	a1,0
  8005d6:	8522                	mv	a0,s0
  8005d8:	b75ff0ef          	jal	ra,80014c <waitpid>
  8005dc:	e11d                	bnez	a0,800602 <main+0x90>
    cprintf("wait returns %d\n", ret);
  8005de:	4581                	li	a1,0
  8005e0:	00000517          	auipc	a0,0x0
  8005e4:	4c850513          	addi	a0,a0,1224 # 800aa8 <error_string+0x1d8>
  8005e8:	abbff0ef          	jal	ra,8000a2 <cprintf>

    cprintf("spin may pass.\n");
  8005ec:	00000517          	auipc	a0,0x0
  8005f0:	4d450513          	addi	a0,a0,1236 # 800ac0 <error_string+0x1f0>
  8005f4:	aafff0ef          	jal	ra,8000a2 <cprintf>
    return 0;
}
  8005f8:	60a2                	ld	ra,8(sp)
  8005fa:	6402                	ld	s0,0(sp)
  8005fc:	4501                	li	a0,0
  8005fe:	0141                	addi	sp,sp,16
  800600:	8082                	ret
    assert((ret = waitpid(pid, NULL)) == 0);
  800602:	00000697          	auipc	a3,0x0
  800606:	48668693          	addi	a3,a3,1158 # 800a88 <error_string+0x1b8>
  80060a:	00000617          	auipc	a2,0x0
  80060e:	43e60613          	addi	a2,a2,1086 # 800a48 <error_string+0x178>
  800612:	45dd                	li	a1,23
  800614:	00000517          	auipc	a0,0x0
  800618:	44c50513          	addi	a0,a0,1100 # 800a60 <error_string+0x190>
  80061c:	a0bff0ef          	jal	ra,800026 <__panic>
    assert((ret = kill(pid)) == 0);
  800620:	00000697          	auipc	a3,0x0
  800624:	41068693          	addi	a3,a3,1040 # 800a30 <error_string+0x160>
  800628:	00000617          	auipc	a2,0x0
  80062c:	42060613          	addi	a2,a2,1056 # 800a48 <error_string+0x178>
  800630:	45d1                	li	a1,20
  800632:	00000517          	auipc	a0,0x0
  800636:	42e50513          	addi	a0,a0,1070 # 800a60 <error_string+0x190>
  80063a:	9edff0ef          	jal	ra,800026 <__panic>
