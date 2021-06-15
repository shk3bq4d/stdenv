#!/usr/bin/env bash

function debug_vars() {
	mrecho "
STDENV_USER_UID:       $STDENV_USER_UID
STDENV_USER_GID:       $STDENV_USER_GID
STDENV_USER_SUDOER:    $STDENV_USER_SUDOER
STDENV_USER_NAME:      $STDENV_USER_NAME
STDENV_USER_GROUPNAME: $STDENV_USER_GROUPNAME
STDENV_DEBUG:          $STDENV_DEBUG
STDENV_RUNAS:          $STDENV_RUNAS
ARGC:                  $#
ARG:                   $@
	"
}

APT_FLAG=/.apt-entrypoint

function mrecho() {
	[[ -n "${STDENV_DEBUG:-}" ]] && echo "$@" || true
}

function mrcat() {
	[[ -n "${STDENV_DEBUG:-}" ]] && cat || cat &>/dev/null
}

debug_vars "$@"

function _go() {
	local OLD_USER_NAME OLD_USER_GROUPNAME
	set -eu
	[[ -n "${STDENV_DEBUG:-}" ]] && set -x || true
	test -f $APT_FLAG && return

	OLD_USER_NAME=user
	OLD_USER_GROUPNAME=$OLD_USER_NAME
	test -d /stdenv/root || mkdir /stdenv/root
	if [[ ! -d /stdenv/user ]]; then
		mkdir /stdenv/user
		chown user: /stdenv/user
	fi

	if [[ -n "${STDENV_USER_UID:-}" ]]; then
		usermod -u     $STDENV_USER_UID     $OLD_USER_NAME 2>&1 | mrcat
		chown -R $STDENV_USER_UID /stdenv/user
	fi
	if [[ -n "${STDENV_USER_GID:-}" ]]; then
		OLD_USER_GID=$(id -g $OLD_USER_NAME)
		if [[ "$STDENV_USER_GID" != "$OLD_USER_GID" ]]; then
			find $(eval echo ~$OLD_USER_NAME) -gid $OLD_USER_GID -print0 | xargs -0r chgrp -h $STDENV_USER_GID
			groupmod -g $STDENV_USER_GID $OLD_USER_GROUPNAME 2>&1 | mrcat
			chgrp -R $STDENV_USER_GID /stdenv/user
		fi
	fi
	if [[ -n "${STDENV_USER_SUDOER:-}" ]]; then
		usermod -aG sudo $OLD_USER_NAME 2>&1 | mrcat
	fi
	if [[ -n "${STDENV_USER_NAME:-}" ]]; then
		usermod -md /home/$STDENV_USER_NAME -l $STDENV_USER_NAME $OLD_USER_NAME 2>&1 | mrcat
	fi
	if [[ -n "${STDENV_USER_GROUPNAME:-}" ]]; then
		groupmod -n $STDENV_USER_GROUPNAME $OLD_USER_GROUPNAME 2>&1 | mrcat
	fi
	touch $APT_FLAG
	set +x
	mrecho done
}

_go

if [[ -n "${STDENV_RUNAS:-}" ]]; then
	cd "$(eval echo ~$STDENV_RUNAS)"
	if [[ $# -gt 0 ]]; then
		mrecho "runas exec"
		sudo -iu $STDENV_RUNAS bash -c "exec $@"
	else
		mrecho "runas zsh"
		sudo -iu $STDENV_RUNAS zsh
	fi
else
	cd /root
	if [[ $# -gt 0 ]]; then
		mrecho "exec"
		bash -c "exec $@"
	else
		mrecho "bash"
		bash
	fi
fi
mrecho "eof"
