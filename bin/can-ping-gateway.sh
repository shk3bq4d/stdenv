#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

gateway() {
    ip route </dev/null | grep default | awk '{print $3}'
}

!gateway &>/dev/null && exit 1
ping -c 1 $(gateway) &>/dev/null && exit 0 || exit 2
