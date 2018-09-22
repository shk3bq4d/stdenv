#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */
#
# https://github.com/acrisci/i3ipc-python

import os
import sys
import re
import argparse
import logging
import logging.config
import i3ipc

from pprint import pprint

logger = logging.getLogger(__name__)

def go(args):
    i3 = i3ipc.Connection()
    help(i3)
    help(i3.get_tree())
    pprint(i3.get_tree())

def debug(e, recursive=True, indent=''):
    if e.type == 'workspace':
        print('{indent}{type}: "{name}"'.format(indent=indent, **vars(e)))
        if recursive:
            for n in e.nodes:
                debug(n, recursive=recursive, indent=indent + ' ')
    elif len(e.nodes) == 0:
        print('{indent}{type}-{window_class} "{name}"'.format(indent=indent, **vars(e)))
    else:
        print('{indent}container: {layout} {orientation}'.format(indent=indent, **vars(e)))
        if recursive:
            for n in e.nodes:
                debug(n, recursive=recursive, indent=indent + ' ')

def mrinspect(foA, foO):
    foA.append(foO)
    if foO['focused']:
        return True
    for i in foO['nodes']:
        if mrinspect(foA, i):
            return True
    foA.pop()
    return False

def mrFocusedStack():
    """ returns a list of container in which the latest is the focused window """
    import json
    import subprocess
    rA = []
    bString = subprocess.check_output(["i3-msg", "-t", "get_tree"])
    cO = json.loads(bString)
    rA = []
    mrinspect(rA, cO)
    return rA

if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf-8')
    go(sys.argv[1:])
