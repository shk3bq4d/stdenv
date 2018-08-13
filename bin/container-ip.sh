#!/usr/bin/env bash

case $(uname) in \
CYGWIN*)
	ipconfig /all 2>&1 | sed -n -r -e '/IPv4 Address/s/.*Address[^0-9]+([0-9.]+).*/\1/ p'
	;;
*)	
	ips --no-internet | \
		grep -Ev 'lo |docker' | \
		awk-print2.sh | \
		tee ~/.tmp/container_ip |
		grep -E . || echo "no ip" >&2
	;;
esac

