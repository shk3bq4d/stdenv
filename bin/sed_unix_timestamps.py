#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import fileinput # stdin
import datetime

if sys.stdout.isatty() or True:
    none="\033[0m"    # unsets color to term's fg color
    bold="\033[1m"
    off="\033[m"
    black="\033[0;30m"    # black (or more likely white if terminal in day mode)
    red="\033[0;31m"    # red
    green="\033[0;32m"    # green
    yellow="\033[0;33m"    # yellow
    blue="\033[0;34m"    # blue
    magenta="\033[0;35m"    # magenta
    cyan="\033[0;36m"    # cyan
    white="\033[0;37m"    # white (or more likely black if terminal in day mode)
    emblack="\033[1;30m"
    emred="\033[1;31m"
    emgreen="\033[1;32m"
    emyellow="\033[1;33m"
    emblue="\033[1;34m"
    emmagenta="\033[1;35m"
    emcyan="\033[1;36m"
    emwhite="\033[1;37m"
    bgblack="\033[40m"
    bgred="\033[41m"
    bggreen="\033[42m"
    bgyellow="\033[43m"
    bgblue="\033[44m"
    bgmagenta="\033[45m"
    bgcyan="\033[46m"
    bgwhite="\033[47m"
else:
    none=""    # unsets color to term's fg color
    bold=""
    off=""
    black=""    # black
    red=""    # red
    green=""    # green
    yellow=""    # yellow
    blue=""    # blue
    magenta=""    # magenta
    cyan=""    # cyan
    white=""    # white
    emblack=""
    emred=""
    emgreen=""
    emyellow=""
    emblue=""
    emmagenta=""
    emcyan=""
    emwhite=""
    bgblack=""
    bgred=""
    bggreen=""
    bgyellow=""
    bgblue=""
    bgmagenta=""
    bgcyan=""
    bgwhite=""

date_format = '%Y.%m.%d_%H:%M:%S.%f'
def parse_and_write_timestamp(s):
    try:
        d = datetime.datetime.fromtimestamp(float(s))
    except:
        sys.stdout.write(red + '_exception_' + s + '_' + none)
        return
    if d.year < 1970 or d.year > 2035:
        sys.stdout.write(s)
        return
    sys.stdout.write(blue + '_' + d.strftime(date_format) + '_' + none)


# 1671700267
pattern = re.compile(r'1[0-9]{9}')
pattern = re.compile(r'1[0-9]{9}(\.[0-9]{9}|\.[0-9]{6}|\.[0-9]{3})?')
def process_line(line):
    #before = 0
    matcher = None
    for matcher in re.finditer(pattern, line):
        #print("before is {}".format(before))
        #print("matcher.pos is {}".format(matcher.pos))
        sys.stdout.write(line[matcher.pos:matcher.start()])
        parse_and_write_timestamp(matcher.group())
        #before = matcher.end()
    #print("B before is {}, len(line) is {}".format(before, len(line)))
    if matcher is None:
        print(line)
    else:
        print(line[matcher.end():])

def go(args):
    filepath = '-' if len(args) == 0 else args[0]
    print("filepath is {}".format(filepath))
    for line in fileinput.input(filepath):
        line = line.rstrip()
        print("line is {}".format(line))
        process_line(line)
        if line == '':
            continue

if __name__ == '__main__':
    r = go(sys.argv[1:])
