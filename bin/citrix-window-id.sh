#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" && -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM

if [[ -n "${CITRIX_WINDOW_ID_OVERRIDE:-}" ]]; then
    echo "${CITRIX_WINDOW_ID_OVERRIDE:-}"
    exit 0
fi

if true; then
    xdotool search --name "Windows 11 - ITTS|ITTS Desktop|Windows 11 - External" > $_tempfile
    xdotool search --class Wfica | grep -f $_tempfile
else
    xdotool search --name "zscaler-ubuntu20-citrix-gnome_shaz0140003" > $_tempfile
    xdotool search --class "VirtualBox Machine" | grep -f $_tempfile
fi

cleanup
exit 0

