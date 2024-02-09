#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

if [[ $# -eq 0 ]]; then
    ref=HEAD
elif [[ "$1" == "-"* ]]; then
    ref=HEAD
else
    ref="$1"
    shift
fi

git commit --reset-author --reedit-message=$ref "$@"
