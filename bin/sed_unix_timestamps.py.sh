#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

if hash python3 &>/dev/null; then
    python3 "${RCD:~/bin}/sed_unix_timestamps.py" "$@"
    exit $?
fi

if hash python &>/dev/null; then
    python "${RCD:~/bin}/sed_unix_timestamps.py" "$@"
    exit $?
fi

>&2 echo "FATAL: python not found on system"
exit 1
