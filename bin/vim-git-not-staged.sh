#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

mrdirname () {
    local a
    a="$1"
    if [[ "$a" != */* ]]
    then
        echo .
        return
    fi
    while [[ "$a" == */ ]]
    do
        a="${a:0:${#a}-1}"
    done
    a="${a%/*}"
    if [[ -z "$a" ]]
    then
        echo "/"
    else
        echo "$a"
    fi
}

git_root_dir () {
    local a
    if [[ -n ${GIT_DIR:+1} ]]
    then
        [[ -f ${GIT_DIR}/index ]] && echo "${GIT_DIR}" && return 0
    fi
    a="$PWD"
    while [[ "$a" != "/" ]] && [[ "$a" != "." ]]
    do
        [[ -d "$a/.git" ]] && echo "$a" && return 0
        a="$(mrdirname "$a")"
    done
    return 1
}

list() {
    git status -b --porcelain |
        grep -vE '^##' |
        sed -r -e 's/^...//'
}

! git_root_dir &>/dev/null && echo "FATAL: not a git repository" && exit 1

if [[ -z "$(list)" ]]; then
    echo "no unstaged files"
    exit 1
fi
list
cd $(git_root_dir)
vim $(list)
