#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:~/bin

if [[ $# -eq 0 ]]; then
    if false && [[ -t 0 ]]; then
        ARGS=all
    else
        ARGS="$(hosts-from-clipboard.sh)"
        if [[ "$(echo "$ARGS" | wc -l)" -eq 0 ]]; then
            >&2 echo "enter your hosts on the stdin"
            ARGS="$(hosts-stdin.sh)"
        fi
    fi
else
    ARGS="$@"
fi
# hosts (1):
if [[ $(ansible "$ARGS" --list-hosts 2>/dev/null | sed -r -e '/^\s*hosts[ ()[0-9:]+$/ d' -e 's/^\s+|\s+$//g' | wc -l) -eq 0 ]]; then
    cd $(iaac-dir.sh)
fi
ansible "$ARGS" --list-hosts 2>/dev/null | sed -r -e '/^\s*hosts[ ()[0-9:]+$/ d' -e 's/^\s+|\s+$//g' | sort -u
