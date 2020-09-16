#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 16 Sep 2020
##

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    sudo $0 "$@"
    exit $?
fi

set -x
apt update
apt upgrade -y
apt autoremove
set +x
echo ""

test -f /var/run/reboot-required && echo "Reboot needed" || echo "No reboot is required"
