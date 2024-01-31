#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

xdotool windowfocus --sync $($DIR/whatsapp-window-id.sh)
xdotool sleep ${delay:-0.5} key --window $($DIR/whatsapp-window-id.sh) Tab

exit 0

