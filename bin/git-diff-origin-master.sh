#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

source ~/bin/dot.gitfunctions

if ! cd "$(git_root_dir)" ; then
    echo "FATAL: possibly not a git dir $PWD"
    exit 1
fi
git diff --name-only $(git merge-base HEAD origin/master) HEAD | xargs -rt git diff origin/master --
