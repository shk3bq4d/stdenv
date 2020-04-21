#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 06 Apr 2020
##

set -euo pipefail
curl -sD - -o /dev/null "$@" | less --raw-control-chars --quit-if-one-screen --ignore-case --status-column --no-init
