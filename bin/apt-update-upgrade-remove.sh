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
    SUDO=sudo
else
    SUDO=""
fi

set -x
$SUDO apt update
$SUDO apt upgrade -y
$SUDO apt autoremove -y
set +x
echo ""

test -f /var/run/reboot-required && echo "Reboot needed" || echo "No reboot is required"
