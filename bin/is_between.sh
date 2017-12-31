#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ FROM TO  [NOW]
##tests if NOW is between FROM and TO where FROM, TO and NOw
##are /usr/bin/date -d STRING compatible strings
##
## Author: Jeff Malone, 10 Oct 2017
##

set -euo pipefail

function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 2 || $# -gt 3 ]] && echo FATAL: incorrect number of args && usage && exit 1

for i in date; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

if [[ $# -eq 2 ]]; then
	now_epoch=$(date +%s)
else
	now_epoch=$(date -d "$3" +%s)
fi

debug_ts() {
	date -d @$1
}
add() {
	ts=$(( $1 + 86400 * $2 ))
	date -d "@$ts" +%s
}

from_epoch=$(date -d "$1" +%s)
to_epoch=$(date -d "$2" +%s)
if [[ $to_epoch -lt $from_epoch ]]; then
	true
fi
one_day_seconds=86400
# adjust to_epoch as needed to get a less than on day diff
while :; do
	#echo "loop1 to: $(debug_ts $to_epoch)"
	next_to_epoch=$to_epoch
	(( $to_epoch - $from_epoch <= 0 ))  && next_to_epoch=$(add $to_epoch 1)
	(( $to_epoch - $from_epoch > $one_day_seconds ))  && next_to_epoch=$(add $to_epoch -1)
	[[ $to_epoch -eq $next_to_epoch ]] && break
	to_epoch=$next_to_epoch
done
# adjust cojointy to_epoch and from_epoch as needed to get now_epoch in between both
while :; do
	#true && break
	#echo "loop2 to: $(debug_ts $to_epoch) from: $(debug_ts $from_epoch)"
	next_to_epoch=$to_epoch
	next_from_epoch=$from_epoch
	if (( $to_epoch < $now_epoch && $from_epoch < $now_epoch )); then
		next_to_epoch=$(add $to_epoch 1)
		next_from_epoch=$(add $from_epoch 1)
	fi
	[[ $to_epoch -eq $next_to_epoch ]] && break
	to_epoch=$next_to_epoch
	from_epoch=$next_from_epoch
done
while :; do
	#echo "loop3 to: $(debug_ts $to_epoch) from: $(debug_ts $from_epoch)"
	next_to_epoch=$to_epoch
	next_from_epoch=$from_epoch
	if (( $to_epoch > $now_epoch && $from_epoch > $now_epoch )); then
		next_to_epoch=$(add $to_epoch -1)
		next_from_epoch=$(add $from_epoch -1)
	fi
	[[ $to_epoch -eq $next_to_epoch ]] && break
	to_epoch=$next_to_epoch
	from_epoch=$next_from_epoch
done
#debug_ts $from_epoch
#debug_ts $to_epoch
#debug_ts $now_epoch
if (( $from_epoch < $now_epoch && $to_epoch > $now_epoch )); then
	exit 0
else
	exit 1
fi

