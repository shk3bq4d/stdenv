#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
export PATH=$PATH:$DIR
set -x
~/py/mr_sendkeys.py --focus --id $(whatsapp-window-id.sh) "$@"

exit 0

