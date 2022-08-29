#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
#

case $(hostname -f) in \
feb22*)
    exit 0
    ;;
esac
nohup feh --bg-scale ~/Pictures/i3lock/boreal3.png </dev/null &>/dev/null &
#feh --bg-scale ~/Pictures/i3lock/boreal3.png
