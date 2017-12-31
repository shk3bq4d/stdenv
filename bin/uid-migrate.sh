#!/usr/bin/env bash

set -e
set -u

function usage()  {
	echo "$(basename $0) [USERNAME|CURUID] NEWUID"
}


if [[ $# -ne 2 ]]; then
	echo "FATAL: incorrect number of args"
	usage
	exit 1
fi

if [[ $EUID -ne 0 ]]; then
	echo "FATAL: this script should be run with root permission"
	exit 1
fi

if ! id -u "$1" &>/dev/null; then
	echo "FATAL: unknown current user $1"
	usage
	exit 1
fi
CURUID=$(id -u "$1")
CURNAME=$(id -un "$CURUID")
if [[ "$CURUID" -le 1 ]]; then
	echo "FATAL: can't remap UID <= 1"
	exit 1
fi
if [[ "$CURUID" -eq $EUID ]]; then
	echo "FATAL: can't remap current UID $EUID"
	exit 1
fi

NEWUID="$2"
if [[ "$CURUID" -eq "$NEWUID" ]]; then
	echo "FATAL: old uid and new uid are the same $1 == $NEWUID"
	usage
	exit 1
fi

if id -u "$NEWUID" &>/dev/null; then
	echo "FATAL: destinatation uid alreay taken $2"
	usage
	exit 1
fi

if pgrep -u "$CURUID"; then
	echo "There exist current process running as $CURUID, killing those"
	while :; do
		if ! pkill -9 -u "$CURUID"; then
			sleep 3
			if ! pkill -9 -u "$CURUID"; then
				break
			fi
		fi
		sleep 5
	done
fi
usermod -u $NEWUID $CURNAME 
/usr/bin/chown --changes --no-dereference --recursive --from=$CURUID $NEWUID /
echo "full success OK"
exit 0
