#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

docker ps &>/dev/null && SUDO="" || SUDO="sudo";

test -z "${DISPLAY:-}" && DISPLAY=":0"

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 0755 $XAUTH

$SUDO docker run \
    --rm  \
    -it \
    -e DISPLAY=${DISPLAY} \
    -v $XSOCK:$XSOCK \
    -v $XAUTH:$XAUTH \
    -v $HOME:$HOME \
    -v /etc/passwd:/etc/passwd \
    -v $HOME/bin:$HOME/bin \
    -v $HOME/.ssh:$HOME/.ssh \
    -u $(id -u):$(id -g) \
    -e USER=$USER \
    -e XAUTHORITY=$XAUTH \
    --network=host \
    shk3bq4d/xpra:alpine3.23 \
    "$@"

echo EOF
exit 0
