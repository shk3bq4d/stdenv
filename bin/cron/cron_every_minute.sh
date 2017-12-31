#!/bin/bash

. ~/bin/dot.lockfunctions

if ! exlock_now; then
	echo "$(date) skipped execution as no exclusive lock $(basename $0 .sh)"
	exit 0
fi

echo "$(date) start $(basename $0 .sh)"
F=~/bin/cron/cron_every_minute_once.sh

set -x
export DISPLAY=:0
####xdotool search --name "RDP localhost" key $(date | sed -e 's/./\0 /g') Return
#xdotool search --name "RDP localhost" key F8
$F
set +x

sed -i -r -e '/^[^#]/s/^/# /' $F
