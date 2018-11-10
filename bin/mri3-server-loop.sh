#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 25 Feb 2018
##

set -uo pipefail

PIDF="$HOME/.tmp/pid/$(basename $0 .sh).pid"
source ~/bin/dot.lockfunctions

if exlock_now; then
	echo "sole instance as got exclusive lock"
	echo "unlocked $?"
else
	if [[ -f $PIDF ]]; then
		_pid=$(head -n1 $PIDF)
		echo "Ready to kill"
		pgrep -a -P $_pid -u $UID
		pgrep -F $PIDF
		pkill -9 -P $_pid -u $UID
		pkill -9 -F $PIDF -u $UID
		echo "killed $?"
	fi
	if ! exlock; then
		echo "FATAL Couldn't get lock, exiting"
		exit 1
	fi
fi

echo $$ > $PIDF
while :; do
	echo "starting"
	~/bin/mri3-server.py && echo "exited with 0" || echo "exited with 1"
	sleep 10
done
rm -f $PIDF
