#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
from datetime import datetime as dt
import sys
import fileinput # stdin
import re
import argparse

from pprint import pprint, pformat


def go(args):
    # https://docs.python.org/2/library/argparse.html
    parser = argparse.ArgumentParser(description="Try to human format a number")
    #parser.add_argument("ts", type=str, nargs='*', help="timestampe", default=[dt.utcnow().strftime('%s'), dt.now().strftime('%s')])
    parser.add_argument("ts", type=str, nargs='*', help="number", default=[])
    ar = parser.parse_args(args)
    if len(ar.ts) == 0:
        filepath = '-' # or empty, stdin
        for line in fileinput.input(filepath): # stdin
            line = line.rstrip() # stdin fileinput
            if line == '': # stdin fileinput
                continue # stdin fileinput
            do(line)
    else:
        do(' '.join(ar.ts))

units = ['byte', 'kb', 'mb', 'gb', 'tb', 'pb', 'eb', 'zb', 'yb', 'rb', 'qb']
units2 = ['byte', 'kilo', 'mega', 'giga', 'tera', 'peta', 'exa', 'zetta', 'yotta', 'ronna', 'quetta']

def do(bip):
    bip = int(bip)
    k = 0
    w = -1
    while True:
        formatted = '{:,.1f}'.format(bip).replace(',', "'")
        if w < 0:
            w = len(formatted)
        u = units[k]
        if re.match('.*\.0$', formatted):
            formatted = re.sub(r'\.0$', '', formatted)
            v = w
            u = '  ' + u
        else:
            v = w + 2

        f = '{:>' + str(v) + 's} {}'
        print(f.format(formatted, u))
        if bip < 1024: break
        k = k + 1
        bip = bip = bip / 1024

if __name__ == '__main__':
    go(sys.argv[1:])
