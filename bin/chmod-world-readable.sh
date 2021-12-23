#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ [DIR_OR_FILES...]
## recursively make file or folders world readable
##

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin

for var in "$@"; do
    if [[ ! -e "$var" ]]; then
        echo "FATAL: does not exist $var"
        exit 1
    fi
done

if [[ $EUID -ne 0 ]]; then
    if ! find "$@" -not -uid $EUID &>/dev/null ||
        find "$@" -not -uid $EUID | grep -qE ^; then
        echo "one ore more files not owned by $EUID, restarting script with sudo access"
        sudo $0 "$@"
        exit $?
    fi
fi

BACKUP_PERMS="./$(basename "$0" .sh).backup.$(date +%s)"
find "$@" -print0 | xargs -0 ls -ld > $BACKUP_PERMS
test -n "${SUDO_UID:-}" && chown $SUDO_UID $BACKUP_PERMS
test -n "${SUDO_GID:-}" && chgrp $SUDO_GID $BACKUP_PERMS

find "$@" -type d -! -perm -o+rx -print0 | xargs -rt0 chmod o+rx
find "$@" -type f -! -perm -o+r  -print0 | xargs -rt0 chmod o+r

echo DONE
exit 0
