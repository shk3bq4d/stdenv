#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 12 Oct 2020
##

set -euo pipefail

#echo $0
level="$(sed -r -e 's/^.*-([0-9]+).sh$/\1/' <<< $0)"
pactl set-sink-volume @DEFAULT_SINK@ $level%
