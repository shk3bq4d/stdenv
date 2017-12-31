#!/usr/bin/env bash


##
## __SCRIPT__ REMOTEHOST [REMOTEPORT]
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
set -eu
function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }
[[ $# -eq 1 && ( "$1" == -h || "$1" == --help ) ]] && usage && exit 0
[[ $# -lt 1 || $# -gt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

LOCAL_PORT=$(random-free-tcp-port.sh)
REMOTEHOST=$1
REMOTEPORT=${2:-12345}

{
	cleanup()
	{	[ -n "${SSH_PID:-}" ] && echo "cleanup $SSH_PID" && kill -9 $SSH_PID
	}

	ssh -N -o ExitOnForwardFailure=yes -o ControlMaster=no -o ControlPersist=no -o ControlPath=none -L $LOCAL_PORT:127.0.0.1:$REMOTEPORT $REMOTEHOST &
	SSH_PID=$!
	trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
	sleep 1
	export GDK_SCALE=2

	#jconsole 127.0.0.1:$LOCAL_PORT
	[[ -d ~/bin/visualvm_139/bin  ]] && export PATH=~/bin/visualvm_139/bin:$PATH
	#visualvm -J-Dvisualvm.display.name=$REMOTEHOST:$REMOTEPORT --nosplash --openjmx 127.0.0.1:$LOCAL_PORT
	visualvm -J-Dvisualvm.display.name=$REMOTEHOST:$REMOTEPORT-$LOCAL_PORT -J-Xdock:name=burp --nosplash --openjmx 127.0.0.1:$LOCAL_PORT --fontsize 20
	cleanup
} &>/dev/null &
exit 0
