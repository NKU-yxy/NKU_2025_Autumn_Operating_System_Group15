#include <ulib.h>
#include <string.h>

char buf[4096];

int main(void) {
    // 触碰缓冲区中两个不同偏移以确保涉及多个页
    strcpy(buf, "hello");
    strcpy(buf + 1024, "world");
    int pid = fork();
    if (pid < 0) {
        cprintf("fork failed\n");
        return 1;
    }
    if (pid == 0) {
        // 子进程
        cprintf("child before write: %s %s\n", buf, buf + 1024);
        // 写入第一页
        buf[0] = 'H';
        // 写入第二页（不同页偏移）
        buf[1024] = 'W';
        cprintf("child after write: %s %s\n", buf, buf + 1024);
        exit(0);
    } else {
        // 父进程
        wait();
        cprintf("parent after child write: %s %s\n", buf, buf + 1024);
        return 0;
    }
}
