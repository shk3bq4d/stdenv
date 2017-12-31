#!/usr/bin/env bash

f=~/.tmp/mrtouchpad-state
curstate="$(cat $f 2>/dev/null)"
if [[ "$curstate" = "disable" ]]; then
	action="enable"
else
	action="disable"
fi
echo $action > $f
xinput list | sed -r -n -e '/ouch.ad/s/.*id=([0-9]+).*/\1/ p' | xargs --no-run-if-empty xinput --$action
