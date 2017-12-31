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
border_config = 'pixel 9'
i3 = i3ipc.Connection()
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
    '-e', r's/^(client.focused ).*/\1          #ff0000 #ff0000 #ffffff #ffff00/',
    '-e', r's/^(client.focused_inactive ).*/\1 #ffa500 #ffa500 #ffffff #ffff00/',
    config_fp
    )
#with open(config_fp, 'rb') as f:
#    print(f.read())
i3.command('reload')
os.remove(config_fp)
shutil.move(configtmp_fp, config_fp)

sys.exit(0)

focused = i3.get_tree().find_focused()
border = focused.border
if border == 'pixel':
    border = u'{} {}'.format(border, focused.current_border_width)

pprint(vars(focused))
borders = [
    'none',
    'pixel 1',
    'pixel 10',
    'pixel 20',
    'normal'
    ]
next_border = borders[
    (1 + borders.index(border)) % len(borders)
    ]
print(next_border)
i3.command('[id="{}"] border {}'.format(focused.window, next_border))
#i3.command('[id="{}"] split toggle'.format(focused.window))
#i3.command('[id="{}"] border pixel 10'.format(focused.window))
#time.sleep(5)
#i3.command('[id="{}"] border none'.format(focused.window))

sys.exit(0)
