#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ DATESPEC [COMMAND]
##sleeps until the specified time
##    DATESPEC: date  that has to be understood by date -d "STRING" command
##    COMMAND: optional command to execute when time is reached
##
## Author: Jeff Malone, 08 Oct 2017
##

set -euo pipefail

function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

for i in date sleep; do ! command -v touch &>/dev/null && echo FATAL: unexisting dependency touch && exit 1; done

current_epoch=$(date +%s)
target_epoch=$(date -d "$1" +%s)

sleep_seconds=$(( $target_epoch - $current_epoch ))

echo "" # forces new line before (as the display can be scrambled in my current screen (tmux) setting
if [[ $sleep_seconds -lt 0 ]] && [[ $sleep_seconds -ge -86400 ]]; then
	sleep_seconds=$(( $sleep_seconds + 86400 ))
	echo "Sleeping $sleep_seconds seconds until $1 / $(date -d "$sleep_seconds second")"
else
	echo "Sleeping $sleep_seconds seconds until $1 / $(date -d "$1")"
fi

sleep $sleep_seconds
[[ $# -eq 2 ]] && sh -c "$2"
exit 0

