#!/usr/bin/env bash


set -x

TITLE="RDP corp laptop"

while :; do
	WINDOWS=$(xdotool search --name "$TITLE")
	if [[ -z $WINDOWS ]]; then
		echo "$(date) stopping"
		break
	else
		for w in $WINDOWS; do 
			echo "$(date) sending control to $w"
			xdotool key --window $w Control
		done
	fi
	sleep 300
done

exit 0
