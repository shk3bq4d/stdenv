#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

sed -r -n \
    -e 's/^ *resource +"([^"]+)" +"([^"]+)".*/-target \1.\2/ p' *.tf
