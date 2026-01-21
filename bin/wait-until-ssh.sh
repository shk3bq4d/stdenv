#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ HOST
##waits until HOST is SSH connectable
##
## Author: Jeff Malone, 08 Jan 2026
##

set -euo pipefail

function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -ne 1 ]] && echo FATAL: incorrect number of args && usage && exit 1

host="$1"

while :; do
	echo "trying to connect to $host"
	ssh -o ConnectTimeout=10  "$host" true && exit 0
	sleep 2
done | ts
