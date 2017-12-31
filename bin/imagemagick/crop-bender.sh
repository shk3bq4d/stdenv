#!/usr/bin/env bash

i=~/Downloads/Bender_Rodriguez.png
dev=0
if [[ $dev -eq 1 ]]; then
	o=$(mktemp)
else
	o=~/Pictures/bender.png
fi

#convert $i -crop 130x145+90+0 $o
convert $i -crop 90x90+90+60 $o
if [[ $dev -eq 1 ]]; then
	identify $o
	feh $o
	rm -f $o
fi
