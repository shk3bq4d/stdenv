#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

GREP_PATTERN="."

[[ $# -gt 0 ]] && GREP_PATTERN="$@"

sed -r -n \
    -e 's/^ *resource +"([^"]+)" +"([^"]+)".*/-target \1.\2/ p' \
    -e 's/^ *(module) +"([^"]+)".*/-target \1.\2/ p' \
    *.tf \
    | sort \
    | grep -iE $GREP_PATTERN
