#!/usr/bin/env python3
import re
import sys
from pathlib import Path
from collections import defaultdict

path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(".")

files = sorted(path.glob("strace.out.*"))

fork_re = re.compile(r"\b(clone|clone3|fork|vfork)\(")
child_pid_re = re.compile(r" = ([0-9]+)(?:\s|<|$)")
exec_re = re.compile(r'execve\((.*)\) = 0')
time_re = re.compile(r"^(\d\d:\d\d:\d\d(?:\.\d+)?)")
exit_group_re = re.compile(r"\bexit_group\((-?\d+)\)")
exited_re = re.compile(r"\+\+\+ exited with (-?\d+) \+\+\+")

children = defaultdict(list)
parent = {}
cmd = {}
seen = set()

first_time = {}
last_time = {}
exit_code = {}

def pid_from_filename(p: Path) -> str:
    return p.name.rsplit(".", 1)[-1]

def note_time(pid: str, line: str):
    m = time_re.match(line)
    if not m:
        return
    ts = m.group(1)
    first_time.setdefault(pid, ts)
    last_time[pid] = ts

for file in files:
    pid = pid_from_filename(file)
    seen.add(pid)

    with file.open(errors="replace") as f:
        for line in f:
            note_time(pid, line)

            if fork_re.search(line):
                m = child_pid_re.search(line)
                if m:
                    child = m.group(1)
                    children[pid].append(child)
                    parent[child] = pid
                    seen.update([pid, child])

            m = exec_re.search(line)
            if m:
                cmd[pid] = "execve(" + m.group(1) + ")"
                seen.add(pid)

            m = exit_group_re.search(line)
            if m:
                exit_code[pid] = m.group(1)

            m = exited_re.search(line)
            if m:
                exit_code[pid] = m.group(1)

def meta(pid: str) -> str:
    start = first_time.get(pid, "?")
    end = last_time.get(pid, "?")
    code = exit_code.get(pid, "?")
    return f"[start={start} end={end} exit={code}]"

def print_tree(pid: str, prefix: str = "", is_last: bool = True, is_root: bool = True):
    branch = "" if is_root else ("└── " if is_last else "├── ")
    command = cmd.get(pid, "[no successful execve seen]")
    print(f"{prefix}{branch}{pid} {meta(pid)} {command}")

    kids = children.get(pid, [])
    for i, child in enumerate(kids):
        last = i == len(kids) - 1
        child_prefix = prefix if is_root else prefix + ("    " if is_last else "│   ")
        print_tree(child, child_prefix, last, False)

roots = sorted(seen - set(parent), key=int)

for i, root in enumerate(roots):
    if i:
        print()
    print_tree(root)
