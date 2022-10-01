#!/usr/bin/env sh
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

sed -u -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2}){0,2})?[mGK]//g" "$@"
