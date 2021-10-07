#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

if [[ $# -gt 0 ]]; then
    text="$@"
else
    echo "FATAL: pass on the CLI  the text to send"
    exit 1
fi

echo "sleeping 5 seconds"
sleep 5
echo "done, sending"

set -x
xdotool type --clearmodifiers "$text"
echo "EOF"
exit 0
