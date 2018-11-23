#!/usr/bin/env bash

case $(uname) in \
CYGWIN*)
	ipconfig /all 2>&1 | sed -n -r -e '/IPv4 Address/s/.*Address[^0-9]+([0-9.]+).*/\1/ p'
	;;
*)	
	f=$(echo ~/.tmp/container_ip)
	ips --no-internet | \
		grep -Evw 'lo|docker[0-9]+|virbr[0-9]+' | \
		awk-print2.sh | \
		tr -d '\n' | \
		tee $f |
		grep -E . || echo "no ip" >&2
	pgrep forti &>/dev/null && echo -n " forti" >> $f
	true
	;;
esac

