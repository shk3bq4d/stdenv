#!/usr/bin/env python

import sys
import os
try:
    from mri3 import *
except:
    sys.path.append(os.path.expanduser('~/py'))
    from mri3 import *
import time

def t(w, cmd):
    w.command(cmd)
    w.command('border pixel 10')
    time.sleep(5)
    w.command('border none')

w = get_root().find_focused()
p = w.parent

if len(p.nodes) == 1:
    if p.orientation is None or p.orientation == 'none':
        t(w, 'split horizontal')
    elif p.orientation == 'horizontal':
        t(w, 'split vertical')
    elif p.orientation == 'vertical':
        w.command('border none')
        remove_single_child_containers(p)
    else:
        pass
else:
    t(w, 'split horizontal')
