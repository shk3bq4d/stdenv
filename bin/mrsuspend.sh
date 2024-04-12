#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 22 Sep 2018
##

set -o pipefail
#exec > >(tee /tmp/logfile.txt)
#exec 2>&1

wait_git() {
	while :; do
		pgrep git && sleep 1 && continue
		sleep 0.1
		pgrep git && sleep 1 && continue
		sleep 0.1
		pgrep git && sleep 1 && continue
		sleep 0.1
		pgrep git || break
	done
}
source ~/bin/dot.hostname
for i in ~/.std*_aliases; do
	source  $i
done
case $HOSTNAMEF in \
${WORK_PC1F:-uoeuoeau})
	exit 1
	;;
apr16.ly.lan)
	if [[ -z "$SSH_CLIENT" ]]; then
		sleep-feedback.sh 60
		pkill -9 sshuttle
		docker stop forticlientvpn
		sudo pm-suspend
	else
		nohup sh -c "sleep 5; sudo pm-suspend;" </dev/null &>/dev/null &
		echo "you came remotely and have 5 seconds to close your SSH session"
	fi
	;;
dec17.ly.lan|nov20.ly.lan)
	if at-work.sh; then
		mri3lock &
	fi
	wait_git
	if [[ -z "$SSH_CLIENT" ]]; then
		pkill -9 sshuttle
		docker stop forticlientvpn
		#pkill -9 forticlientsslvpn_cli
	fi
	sudo umount -t fuse.sshfs -a
	sudo systemctl suspend
	exit 0
	;;
esac
exit 1

echo EOF
exit 0

