#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

# Print one random locally administered, unicast MAC address.
# Usage: random-mac.sh [seed]
#   seed: any string; the same seed always yields the same MAC.

main() {
    if (( $# > 1 )); then
        echo "usage: ${0##*/} [seed]" >&2
        exit 2
    fi

    local hex
    if (( $# == 1 )); then
        hex=$(printf '%s' "$1" | sha256sum)
    else
        hex=$(od -vAn -N6 -tx1 /dev/urandom | tr -d ' \n')
    fi

    # first octet: clear multicast bit, set locally administered bit
    local first=$(( (16#${hex:0:2} & 0xfe) | 0x02 ))
    printf '%02x:%s:%s:%s:%s:%s\n' "$first" \
        "${hex:2:2}" "${hex:4:2}" "${hex:6:2}" "${hex:8:2}" "${hex:10:2}"
}

main "$@"
