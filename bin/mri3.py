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
    if 0:
        help(i3)
        help(i3.get_tree())
        pprint(i3.get_tree())
    if 1:
        remove_single_child_containers(i3.get_tree().find_focused().workspace())


def debug(e, recursive=True, indent=''):
    if e.type == 'workspace':
        print(u'{indent}{type}: "{name}"'.format(indent=indent, **vars(e)))
        if recursive:
            for n in e.nodes:
                debug(n, recursive=recursive, indent=indent + ' ')
    elif len(e.nodes) == 0:
        print(u'{indent}{type}-{window_class} "{name}"'.format(indent=indent, **vars(e)))
    else:
        print(u'{indent}container: {layout} {orientation}'.format(indent=indent, **vars(e)))
        if recursive:
            for n in e.nodes:
                debug(n, recursive=recursive, indent=indent + ' ')

def remove_single_child_containers(c, recurse=True, _focus=True):
    root = i3ipc.Connection().get_tree()
    if c is None:
        c = root
    if _focus: current = root.find_focused()
    #pprint(c)
    #debug(c, recursive=False)
    if c.type == 'root':
        for w in c.workspaces():
            remove_single_child_containers(w, recurse=recurse, _focus=False)
    elif c.type == 'workspace' or len(c.nodes) != 1:
        for n in c.nodes:
            remove_single_child_containers(n, recurse=recurse, _focus=False)
    else:
        c.nodes[0].command('move {}'.format(
            'up' if c.parent.orientation == 'vertical' else 'left'
            ))
    #if _focus: current.focus()

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
