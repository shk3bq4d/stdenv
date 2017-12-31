#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
	docker ps 
	exit 1
fi
DID=$(docker inspect -f   '{{.Id}}'  "$@" 2>/dev/null)
set -e
if [[ -z "$DID" ]]; then
	DID=$(docker ps | grep "$@" | awk '{ print $1 }')
	if [[ -z "$DID" ]]; then
		echo "FATAL: can't find running container with args $@"
		exit 1
	fi
fi
if ! docker cp $DID:/tmp/sshrc/.bashrc - &>/dev/null; then 
	tar cPhzpf - --transform "s,^$HOME,sshrc," ~/.sshrc ~/.sshrc.d/ | docker cp - $DID:/tmp
fi
docker exec -it $DID /bin/bash --rcfile /tmp/sshrc/.sshrc
#docker exec -it $DID /bin/sh

