#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

if [[ $# -eq 0 ]]; then
    out=$(date +'%Y.%m.%d_%H.%M.%S')-mrlatex.pdf
    args="-"
elif [[ $# -eq 1 ]]; then
    out="$(basename "$1" .tex).pdf"
    args="$1"
else
    out="$2"
    args="$1"
fi
#docker run -i narf/latex < $SCRIPT > $out
image=mrlatex
docker ps &>/dev/null && SUDO= || SUDO=sudo
if ! $SUDO docker images $image | grep -wqE "^${image}"; then
    echo "Image not found $image, execute the following:"
    echo "  git clone https://github.com/shk3bq4d/docker-latex/ ~/git/$(id -un)/docker-latex/ && \\"
    echo "    cd ~/git/$(id -un)/docker-latex/ && ./build.sh"
    exit 1
else
    if ! \
    cat "$args" |
    $SUDO \
    docker \
    run \
    -i \
    $(find $PWD -maxdepth 1 -name '*.cls' -printf '-v %p:/tmp/%f ') \
    --workdir=/tmp \
    mrlatex \
    > $out \
    ; then
        cat $out
        exit 1
    fi
fi

echo EOF
exit 0
