#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import re
import os
import sys
from typing import Sequence, Union, Iterator, List, Dict, Tuple, no_type_check, Any, Optional

os.umask (0o27)

def stdin():
    import fileinput # stdin
    filepath = '-' # or empty, stdin
    for line in fileinput.input(filepath): # stdin
        line = line.rstrip() # stdin fileinput
        yield line
        if line == '': # stdin fileinput
            continue # stdin fileinput

def get_args(args: List[str]) -> str:
    if  len(args) == 0 or \
        len(args) == 1 and args == '-':
        for i in stdin():
            yield i
    for arg in args:
        yield arg

def process_number(i: int) -> None:
    print(' ' + chr(i))

def process(i: str) -> None:
    print(f'\n{i}')
    if i.startswith('0x') or \
            re.match('[0-9A-Za-z]+', i) is not None and re.search('[A-Za-z]', i) is not None:
        process_number(int(i, 16))
    else:
        sys.stdout.write(f'   {i:<8s}')
        process_number(int(i, 10))

        h = int(i, 16)
        sys.stdout.write(f' 0x{i:<8s} -> {h}')
        process_number(h)

def go(args: List[str]) -> int:
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMF6' in os.environ: args = ['2584', '2585', '2600']
    for i in get_args(args):
        process(i)
    return 0

if __name__ == '__main__':
     go(sys.argv[1:])
