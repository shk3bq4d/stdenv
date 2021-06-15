#!/bin/sh

echo -e "-- Removing exited containers --\n"
docker ps --all --quiet --filter="status=exited" | xargs --no-run-if-empty docker rm --volumes

echo -e "\n\n-- Removing untagged images --\n"
#docker rmi --force $(docker images | awk '/^<none>/ { print $3 }')
docker images | awk '/^<none>/ { print $3 }' | xargs -rtn 1 docker rmi

echo -e "\n\n-- Removing volume directories --\n"
docker volume ls --quiet --filter="dangling=true" | xargs -rtn 1 docker volume rm

echo -e "\n\nDone :)"
