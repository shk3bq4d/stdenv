#!/usr/bin/env bash

set -eu

N=$(basename $0 .sh)
N=${N//docker-/}
N=${N//-/:}
H="${N//:/.}-$(head -c2 </dev/urandom|xxd -p)"

#docker run "$@" -it $N /bin/bash
set -x
docker run "$@" -h $H --name $H -it $N /bin/sh
