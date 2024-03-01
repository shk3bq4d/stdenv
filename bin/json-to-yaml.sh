#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

if [[ $# -eq 0 ]]; then
    yq e --output-format=yaml -P -

else
    yq e --output-format=yaml -P "$@"
fi
#| yq-kislyuk -y --indentless-lists
