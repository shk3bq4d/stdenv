#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

CONTAINER_NAME=claude-local
docker ps &>/dev/null && SUDO="" || SUDO="sudo";

if $SUDO docker inspect $CONTAINER_NAME &>/dev/null; then
    $SUDO docker stop $CONTAINER_NAME
else
    echo "no container name was running"
fi
