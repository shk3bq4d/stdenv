#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from pprint import pprint
import sys
import os
try:
    import mri3
except:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3

def go(args):
    for n in mri3.traverse_all_elem():
        if len(n.ipc_data.get('swallows', [])) > 0 and n.type == 'con':
            print(f'{n.id} {n.type} {n.name}')
            n.command('kill')

if __name__ ==  "__main__":
  go(sys.argv[1:])
