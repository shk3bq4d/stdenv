#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# https://hub.docker.com/r/gists/speedtest-cli
# https://github.com/vgist/dockerfiles/tree/master/speedtest-cli
docker ps &>/dev/null && SUDO="" || SUDO=sudo
$SUDO docker run --rm gists/speedtest-cli
exit 0
