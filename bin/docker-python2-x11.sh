#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

args() {
    if [[ $# -eq 0 ]]; then
        return
    fi
    case "$1" in \
        *.py) echo "python $@"; return;;
        *) echo "$@"; return;;
    esac
    echo "$@"
}

docker ps &>/dev/null && SUDO="" || SUDO="sudo";

test -z "${DISPLAY:-}" && DISPLAY=":0"

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 0755 $XAUTH

args "$@"

$SUDO docker run \
    --rm  \
    -it \
    -e DISPLAY=${DISPLAY} \
    -v $XSOCK:$XSOCK \
    -v $XAUTH:$XAUTH \
    -v $HOME:$HOME \
    -w $PWD \
    -u $(id -u):$(id -g) \
    -e XAUTHORITY=$XAUTH \
    python:2.7 \
    $(args "$@")

echo EOF
exit 0
