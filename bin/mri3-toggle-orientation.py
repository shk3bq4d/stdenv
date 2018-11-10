#!/usr/bin/env python3

import sys
import os
try:
    from mri3 import *
except:
    sys.path.append(os.path.expanduser('~/py'))
    from mri3 import *
import time

def t(w, cmd):
    pid = str(os.getpid())
    fp = os.path.expanduser('~/.tmp/tmp/mri3-toggle-orientation-{}'.format(w.id))
    try:
        with open(fp, 'w') as f:
            f.write(pid)
    except BaseException as e:
        pass
    w.command(cmd)
    w.command('border pixel 10')
    
    time.sleep(5)
    newpid = pid
    try:
        with open(fp, 'r') as f:
            newpid = f.read()
        if newpid == pid:
            w.command('border none')
            os.unlink(fp)
    except:
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
