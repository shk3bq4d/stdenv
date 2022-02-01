#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:~/bin

if [[ $# -eq 0 ]]; then
    ARGS=all
else
    ARGS="$@"
fi
# hosts (1):
ansible "$ARGS" --list-hosts | sed -r -e '/^\s*hosts[ ()[0-9:]+$/ d' -e 's/^\s+|\s+$//g' | sort -u
