#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

N=$(basename $0 .sh)
N=${N//docker-/}
N="${N//:/.}-$(head -c2 </dev/urandom|xxd -p)"
H="$N"

docker ps &>/dev/null && SUDO="" || SUDO="sudo";

source ~/bin/dot.gitfunctions
ROOT_DIR="$(git_root_dir)"
{ test -t 0 && test -t 1; } && TTY_FLAG="-t" || TTY_FLAG=""

set -x
$SUDO \
    docker \
    run \
    -h $H \
    --name $H \
    -i \
    $TTY_FLAG \
    --rm \
    --user $(id -u):$(id -g) \
    -w "$PWD" \
    -v "$HOME:/root" \
    -v "$HOME:$HOME" \
    -v "$ROOT_DIR:$ROOT_DIR" \
    --entrypoint="" \
    alpine/git:v2.54.0 \
    sh \
    "$@"
