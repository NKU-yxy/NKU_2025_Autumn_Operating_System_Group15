#!/usr/bin/env python3
"""
Simple runner to build kernel, run QEMU and capture output for a bench.
Usage: bench_runner.py <bench-name> <out-log>
"""
import sys
import subprocess
import shlex
import os
import signal
import time

def run_cmd(cmd, timeout=None):
    proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    try:
        out, _ = proc.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        proc.kill()
        out, _ = proc.communicate()
    return proc.returncode, out

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: bench_runner.py <bench-name> <out-log>")
        sys.exit(2)
    bench = sys.argv[1]
    out_log = sys.argv[2]
    # build
    rc, out = run_cmd('make -j6')
    if rc != 0:
        print('make failed')
        print(out)
        sys.exit(1)
    # run qemu for finite time
    qemu = 'qemu-system-riscv64 -machine virt -nographic -bios default -device loader,file=bin/ucore.img,addr=0x80200000'
    print('Running QEMU (timeout 40s) ...')
    rc, out = run_cmd(qemu, timeout=40)
    os.makedirs(os.path.dirname(out_log), exist_ok=True)
    with open(out_log, 'w') as f:
        f.write(out)
    print('Wrote', out_log)
    sys.exit(0)
