#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

f=~/Music/stereo-test.mp3
if [[ ! -f $f ]]; then
    wget -O$f https://www.aoakley.com/articles/stereo-test.mp3
fi

mpv --start=12 $f
