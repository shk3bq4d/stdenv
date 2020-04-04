#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
# https://github.com/jessfraz/dockerfiles/blob/master/chromium/Dockerfile
set -euo pipefail
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 0755 $XAUTH # optional if running as different and non-priviledged UID
set -x
docker run -i \
    --rm \
	--net host \
	--cpuset-cpus 0 \
	--memory 512mb \
    -v $XSOCK:$XSOCK \
    -v $XAUTH:$XAUTH \
    -e XAUTHORITY=$XAUTH \
	-e DISPLAY=$DISPLAY \
	-v $HOME/Downloads:/home/chromium/Downloads \
	--device /dev/snd \
	--device /dev/dri/card1 \
    --security-opt seccomp=$HOME/bin/docker-chromium-browser.chrome.json \
	-v /dev/shm:/dev/shm \
	jess/chromium \
    "$@"

exit 0
	--name chromium-docker \

 -v $HOME/.config/chromium/:/data \ # if you want to save state
	-v /tmp/.X11-unix:/tmp/.X11-unix \
 --security-opt seccomp=$HOME/chrome.json \
	-e DISPLAY=unix$DISPLAY \
