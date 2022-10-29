#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

if [[ $# -eq 0 ]]; then
    yq e -P -
else
    yq e -P "$@"
fi
#| yq-kislyuk -y --indentless-lists
