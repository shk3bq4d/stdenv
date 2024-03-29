#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" && -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
cat "$@" > $_tempfile
cat $_tempfile | xclip
cat $_tempfile
cleanup
exit 0
