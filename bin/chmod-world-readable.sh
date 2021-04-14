#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ [DIR_OR_FILES...]
## recursively make file or folders world readable
##

set -euo pipefail
umask 027

for var in "$@"; do
    if [[ ! -e "$var" ]]; then
        echo "FATAL: does not exist $var"
        exit 1
    fi
done

if [[ $EUID -ne 0 ]] && find "$@" -not -uid $EUID | grep -qE ^; then
    echo "one ore more files not owned by $EUID, restarting script with sudo access"
    sudo $0 "$@"
    exit $?
fi

BACKUP_PERMS="./$(basename "$0" .sh).backup.$(date +%s)"
find "$@" -print0 | xargs -0 ls -ld > $BACKUP_PERMS
chmod a+r $BACKUP_PERMS

find "$@" -type d -print0 | xargs -0 chmod o+rx
find "$@" -type f -print0 | xargs -0 chmod o+r

echo DONE
