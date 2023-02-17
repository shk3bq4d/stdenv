#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

if [[ $# -eq 0 ]]; then
    yq --output-format=json e .
else
    yq --output-format=json e . "$@"
fi
