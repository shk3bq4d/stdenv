#!/usr/bin/env python

import sys
import i3ipc
import time
from pprint import pprint



i3 = i3ipc.Connection()


focused = i3.get_tree().find_focused()
#wA = [focused] if len(focused.nodes) == 0 else focused.nodes
wA = focused.leaves() or [focused]
pH = {}
if False:
    for k, w in enumerate(wA):
        if w.id in pH: continue
        prev_border = w.border
        if prev_border == 'pixel':
            prev_border = u'{} {}'.format(prev_border, w.current_border_width)
        pH[w.id] = prev_border

next_border = 'normal'

for w in wA:
    w.command('border {}'.format(next_border))
    pprint(vars(w))
time.sleep(5)
for k, w in enumerate(wA):
    #w.command('border {}'.format(pA[k]))
    w.command('border {}'.format('none'))
#i3.command('[id="{}"] split toggle'.format(focused.window))
#i3.command('[id="{}"] border pixel 10'.format(focused.window))
#time.sleep(5)
#i3.command('[id="{}"] border none'.format(focused.window))

sys.exit(0)
