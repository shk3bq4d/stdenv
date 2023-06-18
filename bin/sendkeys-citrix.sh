#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

~/py/mr_sendkeys.py --cr --id $(citrix-window-id.sh) "$@"

exit 0

