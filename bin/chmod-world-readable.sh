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

# set +e
# echo ">>>>"
# {
#     find "$@" -type d -! -perm -o+rx -print -quit 2>&1 || true
#     find "$@" -type f -! -perm -o+r  -print -quit 2>&1 || true
# } | grep -E "^" && echo yes || echo no
# echo "<<<<"
# set -e
{
    find "$@" -type d -! -perm -o+rx -print -quit 2>&1 || true
    find "$@" -type f -! -perm -o+r  -print -quit 2>&1 || true
} | grep -qE "^" || { echo "No unreadable or accessible file or folder" && exit 0; }

if [[ $EUID -ne 0 ]]; then
    if ! find "$@" -not -uid $EUID &>/dev/null ||
        find "$@" -not -uid $EUID | grep -qE ^; then
        echo "one ore more files not owned by $EUID, restarting script with sudo access"
        sudo bash $0 "$@"
        exit $?
    fi
fi

if [[ -n "${SUDO_USER:-}" ]]; then
    _HOME="$(eval echo ~${SUDO_USER})"
else
    _HOME="$HOME"
fi
BACKUP_PERMS="$_HOME/$(basename "$0" .sh).backup.$(date +%s)"
echo -n "Would you like to save a copy of the perms in $BACKUP_PERMS (Yn): " # read
read _read
echo ""
case "${_read,,}" in \
""|y|yes)
    find "$@" -print0 | xargs -0 ls -ld > $BACKUP_PERMS
    test -n "${SUDO_UID:-}" && chown $SUDO_UID $BACKUP_PERMS
    test -n "${SUDO_GID:-}" && chgrp $SUDO_GID $BACKUP_PERMS
    ;;
esac # read

find "$@" -type d -! -perm -o+rx -print0 | xargs -rt0 chmod o+rx
find "$@" -type f -! -perm -o+r  -print0 | xargs -rt0 chmod o+r

echo DONE
exit 0
