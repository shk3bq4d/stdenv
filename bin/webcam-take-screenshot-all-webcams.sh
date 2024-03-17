#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

DIR=~/tmp/became-take-screenshot-all-webcam-$(date +'%Y.%m.%d-%H.%M.%S')
test -d $DIR || mkdir $DIR

for i in /dev/video*; do
    b=$DIR/$(basename $i).jpeg
    if streamer -c $i -b 16 -s 1920x1080 -o $b; then
        echo "ok $b"
    else
        echo "KO $b"
    fi
done

nohup feh $DIR/*jpeg </dev/null &>/dev/null &

echo EOF
exit 0
