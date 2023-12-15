#!/usr/bin/env bash

set -eu

N=node
H="${N//:/.}-$(head -c2 </dev/urandom|xxd -p)"

docker ps &>/dev/null && SUDO="" || SUDO="sudo";

$SUDO docker run "$@" -h $H --name $H -v ~/tmp:/tmpp -v $STDHOME_DIRNAME:/tmp/sshrc/:ro -it $N "$@"
