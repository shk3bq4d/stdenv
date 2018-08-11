#!/usr/bin/env bash

case $(uname) in \
CYGWIN*)
	ipconfig /all 2>&1 | sed -n -r -e '/IPv4 Address/s/.*Address[^0-9]+([0-9.]+).*/\1/ p'
	;;
*)	
	if command -v ip &>/dev/null; then
		ip a | \
			grep -Po 'inet [0-9.]+|(?<=^\d: )[^:]+|(?<=^\d\d: )[^:]+' | \
			grep -EB1 '^inet ' | \
			grep -v '^--$' | \
			awk 'NR%2{printf "%s ",$0;next;}1' | \
			sed -r -e 's/ inet / /' | \
			grep -Ev 'lo |docker' | \
			awk-print2.sh | \
			tee ~/.tmp/container_ip
		#| xargs -r printf "%-15s %s\n"
	fi
	;;
esac

