#!/usr/bin/env python

import sys
import i3ipc
import time
from pprint import pprint

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()
i3.command('[id="{}"] split toggle'.format(focused.window))
i3.command('[id="{}"] border pixel 10'.format(focused.window))
time.sleep(5)
i3.command('[id="{}"] border none'.format(focused.window))

sys.exit(0)

import subprocess

import mri3
import time


bA = mri3.mrFocusedStack()
bA.reverse()

#for i in bA.reverse():
for i in bA:
	bString = i['orientation']
	if bString == 'none':
		continue
	break
cA = ['i3-msg', 'split']
if bString == 'horizontal':
	cA.append('v')
else:
	cA.append('h')
	
subprocess.check_output(cA)
cA = ['i3-msg', 'border', 'pixel']
subprocess.check_output(cA)
time.sleep(5)
cA = ['i3-msg', 'border', 'pixel']
subprocess.check_output(cA)
