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
    parser = argparse.ArgumentParser(description="Try to human format a date")
    #parser.add_argument("ts", type=str, nargs='*', help="timestampe", default=[dt.utcnow().strftime('%s'), dt.now().strftime('%s')])
    parser.add_argument("ts", type=str, nargs='*', help="timestamp", default=[])
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

def do(bip):
    if re.match(r'^u\d+', bip): # $ timestamp.py u'1493354506'
        print('unicode leading u')
        bip = bip[1:]
    if re.match(r'\d{8,13}\.\d{3}:\d+', bip): # $ timestamp.py 1710318063.679:940914 # auditd
        bip = bip.split(':')[0]
        print('auditd ' + bip)
    try:
        bip_int = float(bip)
        if  bip_int > 1000000000000 and  \
            bip_int < 1000000000000000:
            #         1687343714105
            bip = '{},{}'.format(bip[:-3], bip[-3:])
            bip_int = bip_int / 1000
        print('{} => {}'.format(bip, dt.fromtimestamp(bip_int)))
    except BaseException as e:
        if ' ' in bip:
            for i in bip.split():
                do(i)
        pass

if __name__ == '__main__':
    go(sys.argv[1:])
