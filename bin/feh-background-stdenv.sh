#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
#

case $(hostname -f) in \
feb22*)
    exit 0
    ;;
shaz*)
    if hash at-work.sh 2>/dev/null && at-work.sh; then
        nohup feh --bg-fill ~/Pictures/i3lock/corient-black-$(current-resolution-bigger-screen.sh).png </dev/null &>/dev/null &
        exit 0
    fi
    ;;
esac
nohup feh --bg-scale ~/Pictures/i3lock/boreal3.png </dev/null &>/dev/null &
#feh --bg-scale ~/Pictures/i3lock/boreal3.png
