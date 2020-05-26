#!/usr/bin/env bash

sed -r -i -e "s,worktree = .*,worktree = /home/${STDENV_USER_NAME:-user}," /home/user/stdenv/.git/config

echo "
export _Z_DATA=/stdenv/user/.z-\$EUID
touch \$_Z_DATA
export HISTFILE=/stdenv/user/.zsh_history-\$EUID
" > /home/user/.$(hostname -f)_aliases

echo "
export _Z_DATA=/stdenv/root/.z-\$EUID
touch \$_Z_DATA
export HISTFILE=/stdenv/root/.zsh_history-\$EUID
" > /root/.$(hostname -f)_aliases

/root/entrypoint.sh