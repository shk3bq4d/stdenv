#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

nohup nice -n -1 mplayer tv://  -tv driver=v4l2:input=1:width=1920:height=1080:fps=30:device=/dev/video0 </dev/null &>/dev/null &
