#!/usr/bin/env bash

icon="$HOME/.xlock/icon.png"
tmpbg='/tmp/screen.png'
tmpbg='/tmp/screen.jpg'

(( $# )) && { icon=$1; }

set -x
if true; then
	i3lock -c 000000 -n &
	FOO_PID=$!
fi

i=$RANDOM
j=$(( $i % 10 ))
case $j in \
[0-1]) a=1; b=10000;;
[2-3]) a=2; b=5000 ;;
[4-5]) a=4; b=2500 ;;
[6-7]) a=5; b=2000 ;;
[8])   a=8; b=1205 ;;
[9])   a=10; b=1000;;
esac
#a=100; b=100;
q=$(( $i % 37 ))
scrot --quality $q "$tmpbg"
ls -l "$tmpbg"
if [[ "$tmpbg" != *".png" ]]; then
	newbg="${tmpbg}.png"
	#convert "$tmpbg" "$newbg"
	convert "$tmpbg" -scale ${a}% -scale ${b}% "$newbg"
	#convert "$tmpbg" "$newbg"
	tmpbg="$newbg"
fi

#convert "$tmpbg" -scale 2% -scale 5000% "$tmpbg"
#convert "$tmpbg" -scale 2% -scale 5000% "$tmpbg"
#convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
#convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
test -n "$FOO_PID" && kill $FOO_PID
i3lock -enf -i "$tmpbg"

