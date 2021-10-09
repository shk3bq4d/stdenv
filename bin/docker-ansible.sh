#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
set -euo pipefail
umask 027

if [[ $# -eq 0 ]]; then
    ARGS=sh
else
    ARGS="$@"
fi
set -x
docker run --rm --pull always -it -v $PWD:/data cytopia/ansible "$@"
