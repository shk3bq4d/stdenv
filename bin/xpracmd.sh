#!/usr/bin/env bash 

set -x
if [[ $# -eq 0 ]]; then
	BIN=xpra_target_app.sh
else
	BIN=$1
fi
if [[ ! -x $BIN || ! -f $BIN ]]; then
	echo "FATAL: not an executable $BIN"
	exit 1
fi

NEWDISP=100
LOCKFILE=/tmp/.X${NEWDISP}-lock
[[ -f $LOCKFILE ]] && rm -f $LOCKFILE
MACHINEFILE=/etc/machine-id
if [[ ! -f $MACHINEFILE ]]; then
    echo "non existing file $MACHINEFILE. Please run dbus-uuidgen > /etc/machine-id as root"
    exit 1
fi

set -x
xpra \
    start \
    :$NEWDISP \
    --start-child=$BIN \
    --mdns=no \
    --pulseaudio=no
ret=$?
echo "EOF $ret"
exit $ret
    --auth=allow \
    --exit-with-children \
    --daemon=no 



