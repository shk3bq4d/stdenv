#!/usr/bin/env python

from sh import bash
import i3ipc

border = 'pixel 9'
new_border = 'none'
i3 = i3ipc.Connection()
for window in i3.get_tree().leaves():

    current_border = window.border
    if current_border == 'pixel':
        current_border = u'{} {}'.format(current_border, window.current_border_width)
    if border == current_border:
        i3.command('[id="{}"] border {}'.format(window.window, new_border))
    #print(window.title)
i3.command('reload')


bash("-c", """
if pgrep compton; then 
	pkill --signal SIGUSR1 compton
else
	compton-background.sh
fi
""")

