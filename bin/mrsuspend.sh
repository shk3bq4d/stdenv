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

set -euo pipefail
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
	sleep-feedback.sh 60
	sudo pm-suspend
	;;
dec17.ly.lan)
	if at-work.sh; then
		mri3lock &
	fi
	wait_git
	sudo systemctl suspend
	exit 0
	;;
esac
exit 1
# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)

echo EOF
exit 0

