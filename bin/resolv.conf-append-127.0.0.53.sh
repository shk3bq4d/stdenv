#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

f=/etc/resolv.conf
g="nameserver 127.0.0.53"
if grep -qE "^$g" $f; then
    echo "noop"
else
    set -x
    echo "$g" | sudo tee -a "$f"
    set +x
    echo success
fi
exit 0
