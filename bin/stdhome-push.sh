#!/usr/bin/env bash

set -ex
f=~/bin/dot.bashfunctions
if [[ -f $f ]]; then
    source $f
    if [[ -z "${SSH_AUTH_SOCK:-}" ]]; then
        start_agent_if_not_started
        mr_ssh_add
    fi
fi
unset GIT_DIR
unset GIT_WORK_TREE

[[ ! -d ~/.ssh/c ]] && mkdir ~/.ssh/c
[[ -f ~/.ssh/config ]] && chmod g-rwx,o-rwx ~/.ssh/config
branch=stdhome
for remote in $(git remote show); do
    #if [[ "$remote" == ksgitlab ]] && [[ -f ~/.ssh/id_rsa_ks ]] && ! ssh-add -L | grep -q id_rsa_ks; then
    #    ssh-add ~/.ssh/id_rsa_ks
    #fi
    if git diff --stat --cached $remote/$branch -- | grep -q .; then
        git push $remote $branch
    fi
done
~/bin/stdothers.sh | grep -vE 'stdks' | while read repo; do
    set -x
    cd $repo
    branch=$(basename $repo noexternalcheckout)
    test $branch == stdtsys && branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$repo" != *noexternalcheckout ]]; then
        #find "$repo" -xdev -mindepth 1 -not -path '*/.git*' -print -delete
        find "$repo" -xdev -mindepth 1 \( -not -path '*/.git*' -and -not -path '*/secrets*' \) -print -delete
    fi
    for remote in $(git remote show); do
        #if [[ "$remote" == ksgitlab ]] && [[ -f ~/.ssh/id_rsa_ks ]] && ! ssh-add -L | grep -q id_rsa_ks; then
        #    ssh-add ~/.ssh/id_rsa_ks
        #fi
        if git diff --stat --cached $remote/$branch -- | grep -q .; then
            git push $remote $branch
        fi
    done
    set +x
done
