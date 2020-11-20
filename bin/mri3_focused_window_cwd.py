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
with open(os.path.expanduser('~/.tmp/log/mri3_focused_window_cwd.log'), 'w') as f:
    #for child in children:
    #    f.write(pformat(child.as_dict()))
    for child in children:
        #cwd = children[0].cwd()
        name = child.name()
        f.write(name + '\n')
        if name not in ['bash', 'zsh', 'vim', 'urxvt']:
            f.write('continue not in\n')
            continue
        cwd = child.cwd()
        if cwd.startswith('/proc/'):
            f.write('continue /proc/\n')
            continue # chromium continue
        f.write('=> ' + cwd + '\n')
        print(cwd)
        sys.exit(0)
    f.write('EOL')
#pprint(vars(focused))
