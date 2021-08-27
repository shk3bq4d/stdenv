#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -uo pipefail
umask 027

ls -1 ~/.ssh/c
ls -1 ~/.ssh/c | while IFS=_ read host port user; do
    if [[ "$user" == git ]]; then
        # unlikely that the "true" command would work
        continue
    fi
    if ! timeout 5 ssh -p $port $user@$host whoami </dev/null >/dev/null; then
        echo "exiting $port $user@$host"
        ssh -Oexit -p $port $user@$host </dev/null
    else
        echo "$port $user@$host is still alive"
    fi
done
