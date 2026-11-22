#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

pkill compton || true
pkill picom || true
echo "select the window you want to capture"
echo "ress q in the terminal to stop cleanly (Ctrl-C also works but can leave the last frames unmuxed)"

f=~/tmp/screen-capture-$(date +%F-%H%M%S).mp4
echo "File is $f"
eval $(xwininfo -frame | awk '$1=="Absolute"&&$3=="X:"{print "X="$4} $1=="Absolute"&&$3=="Y:"{print "Y="$4} $1=="Width:"{print "W="$2} $1=="Height:"{print "H="$2}') && ffmpeg -f x11grab -framerate 12 -video_size ${W}x${H} -i ${DISPLAY}+${X},${Y} -vf "crop=trunc(iw/2)*2:trunc(ih/2)*2" -c:v libx264 -preset veryfast -tune stillimage -crf 28 -g 600 -pix_fmt yuv420p -an $f
echo "File is $f"
compton-reinitialize.py

exit 0
