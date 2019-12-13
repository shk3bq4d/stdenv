#!/usr/bin/env bash

set -eu

N=$(basename $0 .sh)
N=${N//docker-/}
H="${N//:/.}-$(head -c2 </dev/urandom|xxd -p)"

#docker run "$@" -it $N /bin/bash
tmpp
bash=1
case $N in \
*bash*)
	;;
*alpine*)
	bash=0
	;;
esac
if [[ $bash -eq 1 ]]; then
	docker run "$@" -h $H --name $H -v ~/tmp:/tmpp -v $STDHOME_DIRNAME:/tmp/sshrc/:ro -it $N /bin/bash --rcfile /tmp/sshrc/.sshrc
else
	docker run "$@" -h $H --name $H -v ~/tmp:/tmpp                                    -it $N /bin/sh
fi
