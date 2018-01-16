#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 02 Nov 2017
##

set -euo pipefail

function usage() { sed -r -n -e s/__SCRIPT__/$0/ -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 0 || $# -gt 0 ]] && echo FATAL: incorrect number of args && usage && exit 1

#for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done
count() {
	DIR=~/Pictures/shutter
	find $DIR -maxdepth 1 -type f | wc -l
}

count_compton=$(pgrep -c compton || true)
if [[ $count_compton -gt 0 ]]; then
	{
		mv    ~/.config/i3/compton.conf{,2}
		touch ~/.config/i3/compton.conf
		pkill --signal SIGUSR1 compton
		sleep 1
		rm -f ~/.config/i3/compton.conf
		mv    ~/.config/i3/compton.conf{2,}
	} &
fi

prev_count=$(count)
max_wait=90
iter=0
echo "count: $(count), prev_count: $prev_count, iter: $iter"
nohup shutter --remove_cursor --select &>/dev/null &
while [[ $(count) -eq $prev_count && $iter -lt $max_wait  && $(pgrep -c shutter) -gt 0 ]]; do
	echo "count: $(count), prev_count: $prev_count, iter: $iter"
	iter=$(( $iter + 1 ))
	sleep 0.2
done
#[[ $count_compton -gt 0 ]] && pkill -9 compton
#compton-reinitialize.py
[[ $count_compton -gt 0 ]] && pkill --signal SIGUSR1 compton


#echo EOF
exit 0

