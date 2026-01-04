.text
.globl _start
_start:
    # set global pointer for RISC-V small data accesses
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    # set ebp for backtrace
    // movl $0x0, %ebp

    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
1:  j 1b
