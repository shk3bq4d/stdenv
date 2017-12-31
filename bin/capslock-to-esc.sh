#!/bin/sh

set -e
# the order of both command seem important
setxkbmap -option caps:none
xmodmap -e "keycode 66 = Escape NoSymbol Escape"        #this will make Caps Lock to act as Esc
echo done
