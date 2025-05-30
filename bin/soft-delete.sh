#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

DIR="$HOME/.tmp/soft-delete"
test -d $DIR || mkdir $DIR

cleanup() {
    find $DIR -mindepth 1 -maxdepth 1 -type d -ctime +60 -print0 | xargs -r0 rm -rf
}

NOW_DIR="$HOME/.tmp/soft-delete/$(date +%Y.%m.%d-%H.%M.%S)"

mkdir $NOW_DIR

mv "$@" $NOW_DIR

cleanup
