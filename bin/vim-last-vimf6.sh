#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 19 Nov 2019
##

set -euo pipefail

if [[ ! -t 0 || ! -t 1 ]]; then
    echo FATAL: 0,1 is not a tty
    exit 1
fi
ARG="."
n=1
[[ $# -gt 0 ]] && [[ $1 =~ ^[0-9]+$ ]] && n=$1 && shift
[[ $# -gt 0 ]] && ARG="$@"
vim -R ~/.tmp/vim/output/$(ls -tr1 ~/.tmp/vim/output | grep -v vim-last-vimf6.sh | grep -E $ARG | tail -$n | head -n 1)
