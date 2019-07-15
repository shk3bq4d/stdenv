#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 21 Dec 2018
##

#find -maxdepth 1 -type f -print0 | shuf -z | head -zn 1 | xargs -0 basename
find -maxdepth 1 -type f -print0 | shuf -zn 1 | xargs -0 basename
