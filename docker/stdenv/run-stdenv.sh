#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

docker ps &>/dev/null && SUDO="" || SUDO="sudo"
TAG=stdenv

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
V="$DIR/volumes/stdenv-$TAG/stdenv"
test -d "$V" || mkdir -p "$V"
$SUDO docker run -v "$V:/stdenv" --rm -it shk3bq4d/stdenv:$TAG
