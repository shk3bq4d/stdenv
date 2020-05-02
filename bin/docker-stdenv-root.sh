#!/usr/bin/env bash

docker run "$@" -e TERM=${TERM:-xterm} -it shk3bq4d/stdenv:stdenv zsh
