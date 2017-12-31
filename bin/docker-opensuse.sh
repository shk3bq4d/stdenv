#!/usr/bin/env bash

N=$(basename $0 .sh)
N=${N//docker-opensuse/}
[[ -z "$N" ]] && N=latest

docker run "$@" -it opensuse:$N /bin/sh
