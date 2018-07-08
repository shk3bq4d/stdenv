#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ [SLEEP] CMD [ARGS]
##executes a command indefinitively
##    SLEEP    number of seconds to wait after each iteration
##    CMD      command to execute
##
## Author: Jeff Malone, 08 Jul 2018
##

set -uo pipefail

function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

SLEEP=0
[[ $# -gt 1 && "$1" =~ ^[0-9]+$ ]] && SLEEP="$1" && shift

while :; do
	#exec "$@"
	"$@"
	[[ $SLEEP -ne 0 ]] && sleep $SLEEP
done

exit 0

