#!/usr/bin/env python3
"""
ansible_template_profiler.py
─────────────────────────────
Parse the stderr of an ANSIBLE_DEBUG=1 run and report which template
expressions / variable lookups consumed the most wall-clock time.

Usage
─────
  # Capture debug output first:
  ANSIBLE_DEBUG=1 ansible-playbook site.yml 2>ansible_debug.log

  # Then analyse:
  python3 ansible_template_profiler.py ansible_debug.log
  python3 ansible_template_profiler.py ansible_debug.log --top 40
  python3 ansible_template_profiler.py ansible_debug.log --min-ms 50
  python3 ansible_template_profiler.py ansible_debug.log --csv out.csv

How it works
────────────
Ansible's debug lines look like (ANSI colour codes included):

  \x1b[1;30m2203356 1777133022.64805: done checking to see if all hosts have failed\x1b[0m

  PID  UNIX_TIMESTAMP_WITH_DECIMALS: message text

ANSI escape sequences are stripped before parsing.
The timestamp is a decimal Unix epoch (float seconds).
There are no per-line durations.  This script uses the *gap between
consecutive debug lines* as a proxy for how long the preceding operation
took.  It then classifies each line by category (template, variable,
lookup, task, connection, …) and accumulates the gap into the matching
bucket.

Because templating gaps are "charged" to the *preceding* line (i.e. the
line that triggered the work), the script also attempts to extract the
Jinja2 expression or variable name from the message text so you can see
exactly which `{{ … }}` is expensive.
"""

import argparse
import collections
import csv
import re
import sys
from pathlib import Path


# ── ANSI escape stripper ──────────────────────────────────────────────────────
ANSI_RE = re.compile(r"\x1b\[[0-9;]*m")

def strip_ansi(s: str) -> str:
    return ANSI_RE.sub("", s)


# ── line format: "<PID> <unix_float>: <message>" ─────────────────────────────
# e.g.  2203356 1777133022.64805: done checking to see if all hosts have failed
LINE_RE = re.compile(r"^\d+\s+(\d+\.\d+):\s*(.+)$")

# ── category rules: (label, compiled-regex-on-message) ───────────────────────
# First match wins.  Order matters — more specific rules first.
CATEGORIES = [
    # --- templating ---
    ("template:jinja_render",   re.compile(r"Jinja2 environment|jinja2 template|jinja render", re.I)),
    ("template:do_template",    re.compile(r"do_template|_do_template|templating string", re.I)),
    ("template:single_var",     re.compile(r"single var|SINGLE_VAR|only_one", re.I)),
    ("template:cache_hit",      re.compile(r"cache hit|already templated", re.I)),
    ("template:recursive",      re.compile(r"recursive loop", re.I)),
    ("template:undefined",      re.compile(r"Ignoring undefined|AnsibleUndefinedVariable", re.I)),
    ("template:type_error",     re.compile(r"failing because of a type error.*template", re.I)),
    ("template:generic",        re.compile(r"templat", re.I)),   # catch-all for 'templat*'

    # --- variable / fact resolution ---
    ("vars:hostvars",           re.compile(r"hostvars", re.I)),
    ("vars:set_host_var",       re.compile(r"set_host_variable|set host var", re.I)),
    ("vars:get_vars",           re.compile(r"get_vars|variable manager|VariableManager", re.I)),
    ("vars:facts",              re.compile(r"gather.?facts|ansible_facts|setup module", re.I)),
    ("vars:include_vars",       re.compile(r"include_vars|vars_files|loading vars", re.I)),
    ("vars:magic",              re.compile(r"magic variable|magic var", re.I)),
    ("vars:generic",            re.compile(r"\bvar(?:iable)?s?\b", re.I)),

    # --- lookup plugins ---
    ("lookup:file",             re.compile(r"lookup.*file|file.*lookup", re.I)),
    ("lookup:env",              re.compile(r"lookup.*env|env.*lookup", re.I)),
    ("lookup:template",         re.compile(r"lookup.*template|template.*lookup", re.I)),
    ("lookup:generic",          re.compile(r"\blookup\b", re.I)),

    # --- task execution ---
    ("task:queue",              re.compile(r"_queue_task|entering _queue_task", re.I)),
    ("task:action",             re.compile(r"in _execute_module|execute_module|action plugin", re.I)),
    ("task:result",             re.compile(r"result_item|process_pending_results|results queue", re.I)),
    ("task:conditional",        re.compile(r"evaluate.*when|when.*condition|conditional", re.I)),
    ("task:handler",            re.compile(r"handler|NOTIFIED HANDLER", re.I)),

    # --- connection / SSH ---
    ("connection:ssh",          re.compile(r"\bssh\b", re.I)),
    ("connection:exec",         re.compile(r"exec_command|_exec_command", re.I)),
    ("connection:lock",         re.compile(r"waiting for lock|acquired lock|released lock", re.I)),
    ("connection:generic",      re.compile(r"connection|connect", re.I)),

    # --- inventory ---
    ("inventory:generic",       re.compile(r"inventory|host pattern", re.I)),

    # --- module packaging ---
    ("module:ansiballz",        re.compile(r"ANSIBALLZ|module zip|module_utils", re.I)),
    ("module:generic",          re.compile(r"\bmodule\b", re.I)),
]

# ── expression extractor: pull the {{ … }} or bare var name from a message ───
JINJA_EXPR_RE  = re.compile(r"\{\{(.+?)\}\}")
VAR_NAME_RE    = re.compile(r"'(\w[\w.]*)'|\"(\w[\w.]*)\"|\b(ansible_\w+)\b")
TEMPLATE_STR_RE = re.compile(
    r"(?:template(?:d|ing)?\s+(?:string|data)\s+(?:is)?:?\s*|"
    r"data\s+is:?\s*)(.{1,200})", re.I
)


def extract_expression(msg: str) -> str:
    """Return a short, normalised key representing what was being templated."""
    # Prefer explicit {{ expr }}
    jinja_hits = JINJA_EXPR_RE.findall(msg)
    if jinja_hits:
        expr = jinja_hits[0].strip()
        return ("{{ " + expr[:120] + " }}") if len(expr) <= 120 else ("{{ " + expr[:117] + "… }}")

    # Look for "templating string is: <data>"
    m = TEMPLATE_STR_RE.search(msg)
    if m:
        snippet = m.group(1).strip()[:120]
        return snippet if snippet else "<unknown>"

    # Fallback: first quoted identifier
    m = VAR_NAME_RE.search(msg)
    if m:
        return m.group(1) or m.group(2) or m.group(3)

    return "<unknown>"


def categorise(msg: str) -> str:
    for label, pat in CATEGORIES:
        if pat.search(msg):
            return label
    return "other"


# ── main parser ───────────────────────────────────────────────────────────────

Entry = collections.namedtuple("Entry", ["ts", "category", "expression", "msg"])


def parse_log(path: Path) -> list[Entry]:
    entries = []
    with path.open(errors="replace") as fh:
        for raw in fh:
            # 1. strip ANSI colour codes
            line = strip_ansi(raw.rstrip())
            # 2. match "PID UNIX_FLOAT: message"
            m = LINE_RE.match(line)
            if not m:
                continue
            ts  = float(m.group(1))   # unix epoch as float seconds
            msg = m.group(2).strip()
            cat  = categorise(msg)
            expr = extract_expression(msg) if cat.startswith("template") else ""
            entries.append(Entry(ts=ts, category=cat, expression=expr, msg=msg))
    return entries


def accumulate(entries: list[Entry]):
    """
    Gap-based accumulation:
      gap[i] = entries[i+1].ts - entries[i].ts
    That gap is charged to entry[i]'s category (the operation that
    was running between line i and line i+1).
    """
    # (category, expression) -> total_ms, call_count
    totals: dict[tuple, list] = collections.defaultdict(lambda: [0.0, 0])

    for i in range(len(entries) - 1):
        gap_ms = (entries[i + 1].ts - entries[i].ts) * 1000
        if gap_ms < 0:
            gap_ms = 0.0  # clock skew guard
        key = (entries[i].category, entries[i].expression)
        totals[key][0] += gap_ms
        totals[key][1] += 1

    return totals


def report(totals, top: int, min_ms: float, csv_path: str | None):
    rows = [
        (cat, expr, ms, cnt, ms / cnt if cnt else 0)
        for (cat, expr), (ms, cnt) in totals.items()
        if ms >= min_ms
    ]
    rows.sort(key=lambda r: -r[2])  # sort by total ms desc

    grand_total = sum(r[2] for r in rows)

    # ── terminal output ───────────────────────────────────────────────────
    header = f"{'TOTAL ms':>10}  {'CALLS':>6}  {'AVG ms':>8}  {'%':>5}  {'CATEGORY':<30}  EXPRESSION"
    sep    = "─" * min(120, len(header) + 20)
    print()
    print(f"  Ansible template profiler  —  top {top} by total time  (min {min_ms:.0f} ms)")
    print(f"  Grand total accounted: {grand_total:,.0f} ms")
    print()
    print("  " + header)
    print("  " + sep)

    for cat, expr, ms, cnt, avg in rows[:top]:
        pct = (ms / grand_total * 100) if grand_total else 0
        expr_col = (expr[:60] + "…") if len(expr) > 60 else expr
        print(f"  {ms:>10,.1f}  {cnt:>6}  {avg:>8,.1f}  {pct:>4.1f}%  {cat:<30}  {expr_col}")

    print()
    print("  Category summary:")
    cat_totals: dict[str, float] = collections.defaultdict(float)
    for cat, _expr, ms, _cnt, _avg in rows:
        cat_root = cat.split(":")[0]
        cat_totals[cat_root] += ms
    for cat_root, ms in sorted(cat_totals.items(), key=lambda x: -x[1]):
        pct = (ms / grand_total * 100) if grand_total else 0
        bar = "█" * int(pct / 2)
        print(f"    {cat_root:<20}  {ms:>10,.0f} ms  {pct:>5.1f}%  {bar}")
    print()

    # ── CSV output ────────────────────────────────────────────────────────
    if csv_path:
        with open(csv_path, "w", newline="") as f:
            w = csv.writer(f)
            w.writerow(["category", "expression", "total_ms", "calls", "avg_ms", "pct"])
            for cat, expr, ms, cnt, avg in rows:
                pct = (ms / grand_total * 100) if grand_total else 0
                w.writerow([cat, expr, f"{ms:.2f}", cnt, f"{avg:.2f}", f"{pct:.2f}"])
        print(f"  CSV written to: {csv_path}")


def main():
    ap = argparse.ArgumentParser(
        description="Profile Ansible Jinja2 templating from ANSIBLE_DEBUG=1 log"
    )
    ap.add_argument("logfile", help="Path to the captured debug log (stderr)")
    ap.add_argument("--top",    type=int,   default=30,  help="Show top N rows (default: 30)")
    ap.add_argument("--min-ms", type=float, default=10,  help="Ignore gaps below this many ms (default: 10)")
    ap.add_argument("--csv",    default=None,            help="Also write results to a CSV file")
    args = ap.parse_args()

    path = Path(args.logfile)
    if not path.exists():
        print(f"ERROR: file not found: {path}", file=sys.stderr)
        sys.exit(1)

    print(f"Parsing {path} …", file=sys.stderr)
    entries = parse_log(path)
    print(f"  {len(entries):,} timestamped lines found", file=sys.stderr)

    if not entries:
        print(
            "\nNo timestamped lines found.\n"
            "Make sure you captured stderr, not stdout:\n"
            "  ANSIBLE_DEBUG=1 ansible-playbook site.yml 2>ansible_debug.log\n"
            "And that your Ansible version emits timestamps (most do by default).",
            file=sys.stderr,
        )
        sys.exit(1)

    totals = accumulate(entries)
    report(totals, top=args.top, min_ms=args.min_ms, csv_path=args.csv)


if __name__ == "__main__":
    main()
