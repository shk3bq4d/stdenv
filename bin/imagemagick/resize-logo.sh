#!/usr/bin/env bash

i=~/Downloads/logo.jpg
s=3840x2160
dev=0
if [[ $dev -eq 1 ]]; then
	o=$(mktemp)
else
	o=~/Pictures/i3lock/logo${s}.png
fi

convert $i -resize 3540x1860 -extent 3840x2160-180-640 $o
if [[ $dev -eq 1 ]]; then
	identify $o
	feh $o
	rm -f $o
fi
