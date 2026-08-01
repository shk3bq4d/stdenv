#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 01 Aug 2026
##

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

c="$PWD $@"
c="$(echo $c | sed -r -e "

# remove home directory
s,$HOME/?,,

# replace non-words chars with -
s/[^a-zA-Z0-9._-]+/-/g

# trim trailing non-words char
s/^[^a-zA-Z0-9._-]+|[^a-zA-Z0-9._-]+$//g
")"

echo ~/tmp/$(date +%Y.%m.%d-%H.%M.%S)-$c


