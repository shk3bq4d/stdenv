#!/usr/bin/env bash
ENV_FLAG=/.stdenv-entrypoint

if [[ ! -f $ENV_FLAG ]]; then # if "docker restart" and username actually changed, then /home/user will have already gone away
	sed -r -i -e "s,worktree = .*,worktree = /home/${STDENV_USER_NAME:-user}," /home/user/stdenv/.git/config

	echo "
	export _Z_DATA=/stdenv/user/.z-\$EUID
	touch \$_Z_DATA
	export HISTFILE=/stdenv/user/.zsh_history-\$EUID
	export LESSHISTFILE=/stdenv/user/.lesshst-\$EUID
	export ZDOTDIR=/stdenv/user/zdotdir-\$EUID
	test -d \$ZDOTDIR || mkdir \$ZDOTDIR
	" > /home/user/.$(hostname -f)_aliases

	echo "
	export _Z_DATA=/stdenv/root/.z-\$EUID
	touch \$_Z_DATA
	export HISTFILE=/stdenv/root/.zsh_history-\$EUID
	export LESSHISTFILE=/stdenv/root/.lesshst-\$EUID
	export ZDOTDIR=/stdenv/root/zdotdir-\$EUID
	test -d \$ZDOTDIR || mkdir \$ZDOTDIR
	" > /root/.$(hostname -f)_aliases

	touch $ENV_FLAG
fi

/root/entrypoint.sh "$@"
