#!/usr/bin/env python

import sys
import i3ipc
from pprint import pprint



i3 = i3ipc.Connection()

def nb_screen():
    visible_workspaces = [x['current_workspace'] for x in i3.get_outputs() if x['active'] and x['current_workspace']]
    return len(visible_workspaces)
focused = i3.get_tree().find_focused()
#pprint(vars(focused))


if focused.orientation == 'vertical':
    container = focused
elif focused.orientation == 'horizontal':
    container = focused.parent
elif focused.parent.orientation == 'vertical':
    container = focused.parent
else:
    container = focused
idx = container.parent.nodes.index(container)
if idx == len(container.parent.nodes) - 1:
    #for i in range(len(container.parent.nodes)): container.command('move right')
    container.command('move right')
else:
    #other_container = container.parent.nodes[len(container.parent.nodes) - 1]
    other_container = container.parent.nodes[idx + 1]
    if False:
        cmd = 'swap container {} with {}'.format(container.id, other_container.id)
        print(cmd)
        pprint(i3.command(cmd))
    if True:
        container.command('focus')
        cmd = 'swap container with con_id {}'.format(other_container.id)
        print(cmd)
        container.command(cmd)
        focused.command('focus')

#pprint(vars(container))
sys.exit(0)
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
