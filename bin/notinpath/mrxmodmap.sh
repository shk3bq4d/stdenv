#!/bin/bash

echo "MR $0 mrxmodmap.sh $(date)" >>~/startup 2>&1
#xmodmap -e "clear Lock" >>~/ww/mrxmodmap 2>&1
#xmodmap -e "keycode 0x42 = Escape" >>~/ww/mrxmodmap 2>&1


setxkbmap -option -option caps:escape
