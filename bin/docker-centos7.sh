#!/usr/bin/env bash

set -eu

N=$(basename $0 .sh)
N=centos:${N//docker-centos/}
H="${N//:/}-$(head -c2 </dev/urandom|xxd -p)"

test -z ${STDHOME_DIRNAME:-} && export STDHOME_DIRNAME=$(stdhome-dirname.sh)

#docker run "$@" -it centos:$N /bin/bash
docker ps &>/dev/null && SUDO= || SUDO=sudo
$SUDO docker run "$@" -h $H --name $H -v $STDHOME_DIRNAME:/tmp/sshrc/:ro -it $N /bin/bash --rcfile /tmp/sshrc/.sshrc
