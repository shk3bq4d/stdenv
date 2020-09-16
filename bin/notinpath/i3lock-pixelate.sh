#!/usr/bin/env bash

icon="$HOME/.xlock/icon.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

i3lock -c 000000 -n &
FOO_PID=$!
scrot "$tmpbg"
convert "$tmpbg" -scale 5% -scale 2000% "$tmpbg"
#convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
#convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
kill $FOO_PID
i3lock -enf -i "$tmpbg"

