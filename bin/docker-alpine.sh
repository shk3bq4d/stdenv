#!/usr/bin/env bash

docker ps &>/dev/null && SUDO="" || SUDO="sudo"
$SUDO docker run "$@" -it alpine /bin/sh
