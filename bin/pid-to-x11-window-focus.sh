#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

# Usage:
#   focus-pid PID [up|down]
#
# up   = try PID, then its parents
# down = try PID, then descendants
#
# Requires: xdotool, ps

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';


set -u

pid="${1:?Usage: $0 PID [up|down]}"
direction="${2:-up}"

focus_pid()
{
    local p="$1"
    local wid

    # Prefer visible windows, and take the last matching one.
    wid=$(xdotool search --onlyvisible --pid "$p" 2>/dev/null | tail -1) || true

    if [[ -n "$wid" ]]; then
        xdotool windowactivate --sync "$wid"
        return 0
    fi

    return 1
}

case "$direction" in
    up)
        p="$pid"

        while [[ "$p" =~ ^[0-9]+$ ]] && (( p > 1 )); do
            if focus_pid "$p"; then
                exit 0
            fi

            p=$(ps -o ppid= -p "$p" 2>/dev/null | tr -d ' ')
            [[ -n "$p" ]] || break
        done
        ;;

    down)
        # PID first, then descendants breadth/depth order as supplied by ps.
        while read -r p; do
            if focus_pid "$p"; then
                exit 0
            fi
        done < <(
            {
                echo "$pid"
                pstree -p "$pid" 2>/dev/null |
                    grep -o '([0-9]\+)' |
                    tr -d '()'
            } | awk '!seen[$0]++'
        )
        ;;

    *)
        echo "direction must be 'up' or 'down'" >&2
        exit 2
        ;;
esac

echo "No X11 window found for PID $pid ($direction process tree)" >&2
exit 1
