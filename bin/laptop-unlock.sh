#!/usr/bin/env bash



TITLE="RDP corp laptop"

PASS_SOURCE="mr/corporate"

WINDOWS=$(xdotool search --name "$TITLE")
if [[ -z $WINDOWS ]]; then
	echo "$(date) no window found"
	break
else
	for w in $WINDOWS; do 
		echo "$(date) password control to $w"
		xdotool type --clearmodifiers --window $w "$(~/py/expect_kpcli.py $PASS_SOURCE )"
		xdotool key --window $w Return
	done
fi

exit 0
