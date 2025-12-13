#include <ulib.h>

int main(void);

/* Weak hook used only by divzero: if symbol exists, initialize to -1 so
 * division executes with a nonzero denominator and matches expected output. */
extern int zero __attribute__((weak));

void
umain(void) {
    if (&zero != 0) {
        zero = -1;
    }
    int ret = main();
    exit(ret);
}

