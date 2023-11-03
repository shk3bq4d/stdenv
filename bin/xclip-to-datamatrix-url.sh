#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp);   function cleanup() { [[ -n ${_tempfile:-} ]] && [[ -f $_tempfile ]] && rm  -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

if [[ $# -ne 1 ]]; then
    echo "FATAL: wrong number of arguments"
    exit 1
fi

case "$1" in \
http://*) true;;
https://*) true;;
*) echo "FATAL: wrong protocol for $1"; exit 1;;
esac

qrencode -t png -d 600 $1 -o $_tempfile

nohup \
/bin/feh \
    --auto-zoom \
    $_tempfile \
    </dev/null &>/dev/null &
sleep 1 # the sleep is to ensure the file gets not deleted before being read by feh
