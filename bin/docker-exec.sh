#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
	docker ps 
	exit 1
fi
DID=$(docker inspect -f   '{{.Id}}'  "$1" 2>/dev/null)
set -e
if [[ -z "$DID" ]]; then
	DID=$(docker ps | grep "$@" | awk '{ print $1 }')
	if [[ -z "$DID" ]]; then
		echo "FATAL: can't find running container with args $1"
		exit 1
	fi
fi
shift
docker exec -it $DID "$@"

