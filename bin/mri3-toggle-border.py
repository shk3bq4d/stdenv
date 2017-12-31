#!/usr/bin/env python

import sys
import i3ipc
import time
from pprint import pprint

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()
#wA = [focused] if len(focused.nodes) == 0 else focused.nodes
wA = focused.leaves() or [focused]
border = wA[0].border
if border == 'pixel':
    border = u'{} {}'.format(border, wA[0].current_border_width)

pprint(vars(focused))
borders = [
    'none',
    'pixel 1',
    'pixel 10',
    'pixel 20',
    'normal'
    ]
try:
    current_index = borders.index(border)
except:
    current_index = -1
next_border = borders[
    (1 + current_index) % len(borders)
    ]
print(next_border)
for w in wA:
    #i3.command('[id="{}"] border {}'.format(w.window, next_border))
    w.command('border {}'.format(next_border))
    #w.command_children('border {}'.format(next_border))
#i3.command('[id="{}"] split toggle'.format(focused.window))
#i3.command('[id="{}"] border pixel 10'.format(focused.window))
#time.sleep(5)
#i3.command('[id="{}"] border none'.format(focused.window))

sys.exit(0)
