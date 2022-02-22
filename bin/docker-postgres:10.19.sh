#!/usr/bin/env bash

set -eu

N=$(basename $0 .sh)
N=${N//docker-/}
H="${N//:/.}-$(head -c2 </dev/urandom|xxd -p)"

#docker run "$@" -it $N /bin/bash
tmpp
DATA=~/tmp/${N//:/.}
test -d $DATA || mkdir $DATA
docker run -it -h $H --name $H  --rm --user "$(id -u):$(id -g)" -v /etc/passwd:/etc/passwd:ro -v $DATA:/var/lib/postgresql/data -e POSTGRES_USER=$(id -un) -e POSTGRES_PASSWORD=mysecretpassword $N "$@"
