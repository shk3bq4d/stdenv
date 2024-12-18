#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

if [[ $# -eq 0 ]]; then
    # I have no idea why I am piping this in prettify-json first as it should not be needed, nonetheless
    # I keep getting
    # Error: bad file '-': yaml: found unknown escape character
    # otherwise
    prettify-json | yq e -P --output-format=yaml

else
    yq e --output-format=yaml -P "$@"
fi
#| yq-kislyuk -y --indentless-lists
