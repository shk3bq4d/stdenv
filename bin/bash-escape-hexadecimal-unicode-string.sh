#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: 31 Dec 2017
##

set -euo pipefail
{
	if [[ $# -gt 0 ]]; then
		echo "$@"
	else
		cat -
	fi
} | while read -n 1 c; do
	[[ "$c" == "" ]] && break
	printf "%s%X" "\\x" "\"$c"
done
echo ""

exit 0

