#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# https://unix.stackexchange.com/questions/202891/how-to-know-whether-wayland-or-x11-is-being-used
echo "XDG_SESSION_TYPE is ${XDG_SESSION_TYPE:-unset}"
echo "WAYLAND_DISPLAY  is ${WAYLAND_DISPLAY:-unset}"
echo "DISPLAY          is ${DISPLAY:-unset}"
echo -n "loginctl         is "
loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}'
exit 0
