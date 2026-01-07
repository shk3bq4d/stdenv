#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

if xrandr | grep -qE "^eDP"; then
    xrandr | grep -E "^(DP|HDMI).* connected" | awk '{ print $1 }' | xargs -rtI@ xrandr --output @ --off
else
    >&2 echo "FATAL: can't find a display matching eDP, so not doing anything"
    exit 1
fi
exit 0
