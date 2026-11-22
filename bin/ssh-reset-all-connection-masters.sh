#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

set +e
find ~/.ssh/c -mindepth 1 | xargs ls -1t | while read line; do
    echo "$line"
    ssh -S "$line" -O exit dummy </dev/null  && echo " ok" || echo " KO"
    test -e "$line" && rm "$line"
done
pkill '^ssh$'
