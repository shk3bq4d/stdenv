#!/usr/bin/env bash

MAX_AVAILABLE_PORT=65535
MIN_AVAILABLE_PORT=1024

if false; then
	ports() {
		netstat -tan | sed -r -n -e '/[0-9]/s/.*:([0-9\*]+).*:([0-9\*]+).*/\1\n\2/g p'  | grep -vF '*'
	}
	max_port=$(ports | sort -n | tail -1)
	#echo "max_port is $max_port"

	if [[ $max_port -le $MIN_AVAILABLE_PORT ]]; then
		echo $MAX_AVAILABLE_PORT
		exit 0
	fi
	if [[ $max_port -ge $MAX_AVAILABLE_PORT ]]; then
		min_port=$(ports | sort -n | head -1)
		if [[ $min_port -le $MIN_AVAILABLE_PORT ]]; then
			echo "FATAL"
			exit 1
		fi
		echo $(( $min_port - 1 ))
		exit 0
	fi
	echo $(( $max_port + 1 ))
fi
while :; do 
	P=$RANDOM
	[[ $P -lt $MIN_AVAILABLE_PORT ]] && continue
	[[ $P -gt $MAX_AVAILABLE_PORT ]] && continue
	netstat -tan | grep -qw $P && continue
	echo $P
	break
done
