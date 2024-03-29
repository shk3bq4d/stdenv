#!/usr/bin/env python3

import sys
import psutil
import i3ipc
import os
import re
import time
from pprint import pprint, pformat
from sh import xprop

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()
s = str(xprop('-id', focused.window))
p = r'^_NET_WM_PID.CARDINAL. = (\d+)'
m = re.search(p, s, flags=re.MULTILINE).group(1)
p = psutil.Process(int(m))
children = p.children(recursive=True)
#pprint(children[0].create_time())
children = sorted(children, key=lambda x: -x.create_time())
with open(os.path.expanduser('~/.tmp/log/mri3_focused_window_ssh_target.log'), 'a') as f:
    #for child in children:
    #    f.write(pformat(child.as_dict()))
    if 0:
        f.write('---------------------\n')
        for child in children:
            cmdA = child.cmdline()
            cmd = ' '.join(cmdA)
            f.write(cmd[:80])
            f.write('\n')
        sys.exit(0)
    ssh_children = []
#   ansible_children = []
    for c in children:
        f.write("> " + " ".join(c.cmdline()))
        if len(c.cmdline()) == 0: continue
        if c.cmdline()[0] in ['ssh']:
            if '-W' in c.cmdline(): continue # Requests that standard input and output on the client be forwarded to host on port over the secure channel.
            if c.cmdline()[1] == '-C': continue # looks like ansible
            ssh_children.append(c)
#       elif c.cmdline()[0] in ['ansible', 'ansible-playbook']: 
#           ansible_children.append(c)
    if len(ssh_children) == 0:
        f.write('--------------------- len ssh_children is 0\n')
        sys.exit(0)
#   if len(ansible_children) > 0:
#       f.write('--------------------- len ansible_children is > 0\n')
#       sys.exit(0)
    #for c in ssh_children: print(c.cmdline())
    child = ssh_children[0]
    cmdA = child.cmdline()
    cmd0 = cmdA[0]
    if cmd0 not in ['ssh']:
        f.write('--------------------- current cmd is {} with cmdline {}\n'.format(cmd0, ' '.join(cmdA)))
        sys.exit(0)
    cmdA.pop(0) # remove cmd0
    while True:
        if cmdA[0] in ['-t', '-q', '-A', '-x']:
            f.write('skipping no arg argument {}\n'.format(cmdA[0]))
            cmdA.pop(0)
            continue
        elif cmdA[0] in []:
            # pop twice for those args
            f.write('skipping with arg argument {} {}\n'.format(cmdA[0], cmdA[1]))
            cmdA.pop(0)
            cmdA.pop(0)
            continue

        f.write('ssh target is {}\n'.format(cmdA[0]))
        print(cmdA[0])
        break


#pprint(vars(focused))
