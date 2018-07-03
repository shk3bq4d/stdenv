#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 03 Jul 2018
##

set -euo pipefail


case $(hostname -f) in \
*)
	if=$(ip route | grep default | grep -Po '(?<=dev )\S+')
	ips | grep -w $if | awk-print2.sh | tee  ~/.tmp/container_ip
	;;
esac

echo EOF
exit 0

