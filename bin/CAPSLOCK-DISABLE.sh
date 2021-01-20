#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 20 Jan 2021
##

set -x
xdotool key --clearmodifiers Caps Lock  # toggles caps lock (not disable) by issuing the capslock key when on X
setleds -D -caps                        # when on console
