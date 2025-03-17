#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

localhost_times() {
    for i in $(seq 1 $1); do
        echo localhost
    done
}

if [[ $# -eq 0 ]]; then
    nbcon=2
else
    nbcon="$1"
fi

nohup cssh $(localhost_times $nbcon) </dev/null &>/dev/null &
