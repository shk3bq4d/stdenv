#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin


is_number() {
    re='^[0-9]+$'
    [[ "$@" =~ $re ]]
}

fatal() {
    echo "FATAL: $@"
    exit 1
}

L4="127.0.0.1"
PRIVILEGED_PORTS_OFFSET=10000

get_command() {
    #echo -n " -o ClearAllForwardings=yes" # ignore forwarding set in config files so you may reuse this command multiple times, well except it also clears the forwarding I'm currently specifying
    echo -n " -o ExitOnForwardFailure=yes"
    for arg in "$@"; do
        echo -n " "
        if is_number "$arg"; then
            [[    $arg -le 2     ]] && fatal $arg less than one
            [[    $arg -gt 65535 ]] && fatal $arg too big
            if [[ $arg -le 1024 ]];  then
                echo -n -L "$L4:$(( $arg + $PRIVILEGED_PORTS_OFFSET )):$L4:$arg"
            else
                echo -n -L "$L4:$(( $arg                            )):$L4:$arg"
            fi
        else
            echo -n "$arg"
        fi
    done
}

if [[ -n "${VIMF6:-}" ]]; then
    echo ssh $(get_command 80 9090 hoho haha)
else
    arg=$(get_command "$@")
    set -x
    ssh $arg
fi
