#!/usr/bin/env bash

docker run "$@" \
	-e TERM=${TERM:-xterm} \
	-e STDENV_DEBUG= \
	-e STDENV_USER_SUDOER=1 \
	-e STDENV_USER_UID=$(id -u) \
	-e STDENV_USER_GID=$(id -g) \
	-e STDENV_USER_NAME=$(id -un) \
	-e STDENV_USER_GROUPNAME=$(id -gn) \
	-e STDENV_RUNAS=$(id -un) \
	-it shk3bq4d/stdenv:stdenv
