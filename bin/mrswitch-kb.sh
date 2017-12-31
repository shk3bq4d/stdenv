#!/usr/bin/env bash

f=~/.tmp/keyboard-layout
#bAString=($(setxkbmap -query | grep -E "^layout"))
#cl=${bAString[1]}
cl=$(setxkbmap -query | sed -n -r -e '/^(layout|variant):/s/.* ([^ ]+)/\1/ p' | command tr -d '\n')

RED="\[\033[0;31m\]"    # red
YELLOW="\[\033[0;33m\]"    # yellow
OFF="\[\033[m\]"
YELLOW=""
RED=""
OFF=""

if [[ -z "$1" ]]
then
	case $cl in \
	us)
		setxkbmap ch fr
		echo "${RED}ch${OFF}" > $f
		;;
	chfr)
		setxkbmap -layout us -variant dvp
		echo "${YELLOW}dvp${OFF}" > $f
		;;
	*)
		#setxkbmap us && echo "us" > $f
		setxkbmap ch fr && echo "ch" > $f
		;;
esac
else
	if [[ "$cl" == "us" ]] && [[ "$1" == "ch" ]]
	then
		setxkbmap ch fr
		echo "${RED}ch${OFF}" > $f
	elif [[ "$cl" != "us" ]] && [[ "$1" == "us" ]]
	then
		setxkbmap us
		echo "us" > $f
	fi
fi
#killall -USR1 i3status
pkill -USR1 i3status
~/bin/notinpath/mrxmodmap.sh
