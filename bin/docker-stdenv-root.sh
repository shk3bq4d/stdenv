#!/usr/bin/env bash

docker ps &>/dev/null && SUDO="" || SUDO="sudo";
$SUDO docker run "$@" -e TERM=${TERM:-xterm} -it shk3bq4d/stdenv:stdenv zsh
