#include <ulib.h>
#include <stdio.h>

#define NCHILD 6
#define WORK_ITER 400000

int main(void) {
    int i;
    int pids[NCHILD];

    for (i = 0; i < NCHILD; i++) {
        int pid = fork();
        if (pid == 0) {
            // assign priorities: higher i -> higher priority
            lab6_setpriority(i + 1);
            cprintf("BENCH SUBMIT pid=%d bench=priority prior=%d t=%u\n", getpid(), i+1, gettime_msec());
            cprintf("BENCH START pid=%d t=%u\n", getpid(), gettime_msec());
            volatile unsigned long x = 0;
            for (unsigned long k = 0; k < WORK_ITER; k++) x += k ^ (k << 1);
            cprintf("BENCH END pid=%d t=%u work=priority iter=%d prior=%d\n", getpid(), gettime_msec(), WORK_ITER, i+1);
            exit(0);
        }
        pids[i] = pid;
    }

    for (i = 0; i < NCHILD; i++) {
        int st = 0;
        waitpid(pids[i], &st);
    }
    cprintf("BENCH DONE bench=priority\n");
    return 0;
}
