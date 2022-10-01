#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

mysed() {
    sed -r -e '
        # is this going to work
        s/a/_/g
        # ok
        s/r/*/g
        # that is fantastic

        s/c/xxxx/ # phat about
        '
}

cat <<EOF | mysed
abracadabra
EOF
