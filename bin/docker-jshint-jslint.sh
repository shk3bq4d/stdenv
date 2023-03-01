#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# https://hub.docker.com/r/gists/speedtest-cli
# https://github.com/vgist/dockerfiles/tree/master/speedtest-cli
docker ps &>/dev/null && SUDO="" || SUDO=sudo
if [[ $# -eq 0 ]]; then
    $SUDO docker run -it --rm -v $PWD:/code eeacms/jshint
else
    $SUDO docker run -it --rm \
        $(for i in "$@"; do echo "-v $(readlink -f "$i"):/code/$(basename "$i")"; done) \
        eeacms/jshint \
        jshint \
        $(for i in "$@"; do echo " /code/$(basename "$i")"; done)
fi
echo EOF
exit 0
