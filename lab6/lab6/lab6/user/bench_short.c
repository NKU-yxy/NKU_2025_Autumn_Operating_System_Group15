#include <ulib.h>
#include <stdio.h>

#define NCHILD 5
#define WORK_ITER 300000

int main(void) {
    int i;
    int pids[NCHILD];

    for (i = 0; i < NCHILD; i++) {
        int pid = fork();
        if (pid == 0) {
            unsigned int t_submit = gettime_msec();
            cprintf("BENCH SUBMIT pid=%d bench=short t=%u\n", getpid(), t_submit);
            unsigned int t_start = gettime_msec();
            cprintf("BENCH START pid=%d t=%u\n", getpid(), t_start);
            volatile unsigned long x = 0;
            for (unsigned long k = 0; k < WORK_ITER; k++) {
                x += k ^ (k << 1);
            }
            unsigned int t_end = gettime_msec();
            cprintf("BENCH END pid=%d t=%u work=short iter=%d\n", getpid(), t_end, WORK_ITER);
            exit(0);
        }
        pids[i] = pid;
    }

    for (i = 0; i < NCHILD; i++) {
        int st = 0;
        waitpid(pids[i], &st);
    }
    cprintf("BENCH DONE bench=short\n");
    return 0;
}
