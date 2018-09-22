#!/usr/bin/env python3

#import mri3
import i3ipc
#from pprint import pprint

i3c = i3ipc.Connection()
focused = i3c.get_tree().find_focused()

jump = 1.3
max_threshold = 0.85
min_threshold = 0.1
p = focused.percent
n = p * jump
if n > max_threshold:
    n = p
    while n / jump > min_threshold:
        n = n / jump
n = round(n * 100)
print('{} => {}'.format(p, n))
if focused.parent.orientation == 'vertical':
    cA = (100, n)
else:
    cA = (n, 100)
focused.command('resize set {} ppt {} ppt'.format(*cA))
