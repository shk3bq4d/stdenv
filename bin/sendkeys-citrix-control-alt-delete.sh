#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

xdotool sleep ${delay:-0.5} key --window $(citrix-window-id.sh) ctrl+alt+Delete

exit 0

