#include <ulib.h>
#include <stdio.h>

#define N_SHORT 8
#define N_LONG 2
#define SHORT_ITER 150000
#define LONG_ITER 1200000

static void do_work(unsigned long iter) {
    volatile unsigned long x = 0;
    for (unsigned long k = 0; k < iter; k++)
        x += k ^ (k << 1);
}

int main(void) {
    int i;
    int pids[N_SHORT + N_LONG];
    int idx = 0;

    for (i = 0; i < N_SHORT; i++) {
        int pid = fork();
        if (pid == 0) {
            cprintf("BENCH SUBMIT pid=%d bench=mixed_short t=%u\n", getpid(), gettime_msec());
            cprintf("BENCH START pid=%d t=%u\n", getpid(), gettime_msec());
            do_work(SHORT_ITER);
            cprintf("BENCH END pid=%d t=%u work=short iter=%d\n", getpid(), gettime_msec(), SHORT_ITER);
            exit(0);
        }
        pids[idx++] = pid;
    }

    for (i = 0; i < N_LONG; i++) {
        int pid = fork();
        if (pid == 0) {
            cprintf("BENCH SUBMIT pid=%d bench=mixed_long t=%u\n", getpid(), gettime_msec());
            cprintf("BENCH START pid=%d t=%u\n", getpid(), gettime_msec());
            do_work(LONG_ITER);
            cprintf("BENCH END pid=%d t=%u work=long iter=%d\n", getpid(), gettime_msec(), LONG_ITER);
            exit(0);
        }
        pids[idx++] = pid;
    }

    for (i = 0; i < idx; i++) {
        int st = 0;
        waitpid(pids[i], &st);
    }
    cprintf("BENCH DONE bench=mixed\n");
    return 0;
}
