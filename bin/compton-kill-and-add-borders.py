#!/usr/bin/env python

import shutil
import sys
import os
import i3ipc
import time
from sh import pkill, sed
from pprint import pprint

try:
    pkill('compton')
except:
    pass
border = 'pixel 9'
if os.environ.get('HOSTNAMEF') == 'dec17.ly.lan':
    border = 'pixel 5'
border_config = border

with open(os.path.expanduser('~/.tmp/compton-enabled'), 'wb') as f:
    f.write('false')
i3 = i3ipc.Connection()
if True:
    i3.command('[class="[.]*"] border {}'.format(border))
else:
    for window in i3.get_tree().leaves():
        #pprint(vars(window))
        if window.border == 'none':
            i3.command('[id="{}"] border {}'.format(window.window, border))
        #print(window.title)

config_fp = '{}/.config/i3/config'.format(os.environ['HOME'])
configtmp_fp = '{}-tmp'.format(config_fp)
shutil.copy2(config_fp, configtmp_fp)
# class                 border  backgr. text    indicator
#client.focused          #4c7899 #4c7899 #ffffff #ffff00
#client.focused_inactive #555555 #000000 #ffffff #484e50
#client.unfocused        #dddddd #aaaaaa #000000 #484e50
#client.urgent           #0000cc #0000ff #ffffff #0000CC
sed('-r', '-i',
    '-e', r's/^(new_window ).*/\1{}/'.format(border_config),
    '-e', r'/^for_window.*border/d',
    '-e', r's/^(client.unfocused ).*/\1        #aaaaaa #aaaaaa #ffffff #ffff00 #aaaaaa/',
    '-e', r's/^(client.focused ).*/\1          #DC322F #DC322F #ffffff #ffff00 #DC322F/',
    '-e', r's/^(client.focused_inactive ).*/\1 #666666 #666666 #ffffff #ffff00 #666666/',
    config_fp
    )
#with open(config_fp, 'rb') as f:
#    print(f.read())
try:
    i3.command('reload')
except:
    pass
try:
    os.remove(config_fp)
except:
    pass
shutil.move(configtmp_fp, config_fp)
with open(os.path.expanduser('~/.tmp/i3-new_window_border'), 'wb') as f:
    f.write(border_config)

