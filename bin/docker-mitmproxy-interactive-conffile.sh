#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

! test -f "$1" && echo "FATAL: not a file $1" && exit 1
export MITMPROXY_CONFFILE="$(readlink -f "$1")"
shift
docker-mitmproxy-interactive.sh "$@"
exit 0
