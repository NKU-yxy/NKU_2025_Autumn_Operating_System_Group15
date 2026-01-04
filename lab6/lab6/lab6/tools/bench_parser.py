#!/usr/bin/env python3
"""
Parse bench logs and produce CSV of metrics (one CSV per log).
"""
import re
import sys
import csv

BENCH_RE = re.compile(r'BENCH (SUBMIT|START|END) pid=(\d+) (?:bench=(\w+) )?t=(\d+)(?:.*)')

if len(sys.argv) < 3:
    print('Usage: bench_parser.py <log-file> <out-csv>')
    sys.exit(2)

logfile = sys.argv[1]
outcsv = sys.argv[2]

records = {}  # pid -> {bench, submit, start, end}

with open(logfile) as f:
    for line in f:
        m = BENCH_RE.search(line)
        if not m:
            continue
        kind, pid_s, bench, t_s = m.groups()
        pid = int(pid_s)
        t = int(t_s)
        r = records.setdefault(pid, {'bench': bench, 'submit': None, 'start': None, 'end': None})
        if kind == 'SUBMIT':
            r['bench'] = bench or r['bench']
            r['submit'] = t
        elif kind == 'START':
            r['start'] = t
        elif kind == 'END':
            r['end'] = t

# aggregate by bench
aggr = {}
for pid, r in records.items():
    bench = r.get('bench') or 'unknown'
    ag = aggr.setdefault(bench, [])
    ag.append(r)

# compute metrics per bench and write csv
with open(outcsv, 'w', newline='') as csvf:
    writer = csv.writer(csvf)
    writer.writerow(['bench', 'n', 'avg_turnaround', 'avg_response', 'num_with_missing'])
    for bench, lst in aggr.items():
        n = len(lst)
        total_turn = 0
        total_resp = 0
        miss = 0
        for r in lst:
            if r['submit'] is None or r['end'] is None:
                miss += 1
                continue
            turn = r['end'] - r['submit']
            total_turn += turn
            if r['start'] is None:
                resp = 0
            else:
                resp = r['start'] - r['submit']
            total_resp += resp
        avg_turn = total_turn / max(1, n - miss)
        avg_resp = total_resp / max(1, n - miss)
        writer.writerow([bench, n, avg_turn, avg_resp, miss])

print('Wrote', outcsv)
