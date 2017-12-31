#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import sys
import argparse

def go(args):
    # https://docs.python.org/2/library/argparse.html
    parser = argparse.ArgumentParser(description="Test if file1 content is fully in file2")
    parser.add_argument("FILE1", type=str, help="file to process")
    parser.add_argument("FILE2", type=str, help="file to process")
    ar = parser.parse_args(args)
    
    with open(ar.FILE1, 'rb') as f:
        content1 = f.read()
    
    with open(ar.FILE2, 'rb') as f:
        content2 = f.read()

    if content1 in content2:
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == '__main__':
    go(sys.argv[1:])

