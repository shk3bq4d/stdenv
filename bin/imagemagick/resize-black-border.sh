#!/usr/bin/env bash

i=~/Downloads/cucumber900x900.jpg
s=3840x2160
dev=0
if [[ $dev -eq 1 ]]; then
	o=$(mktemp)
else
	o=~/Pictures/i3lock/cucumber-${s}.png
fi

convert $i -resize $s -background black -gravity center -extent $s $o
if [[ $dev -eq 1 ]]; then
	identify $o
	feh $o
	rm -f $o
fi
