#!/usr/bin/env bash

set -e
source ~/bin/dot.lockfunctions
exlock_now || { echo "Couldn't aquire exclusive lock" && exit 1; }
unset GIT_DIR
unset GIT_WORK_TREE

[[ ! -d ~/.ssh/c ]] && mkdir -p ~/.ssh/c
[[ -f ~/.ssh/config ]] && chmod g-rwx,o-rwx ~/.ssh/config

test -x ~/bin/container-ip.sh && ~/bin/container-ip.sh &>/dev/null
set -x
~/bin/stdothers.sh | grep -vE 'stdks' | while read repo; do
    set -x
    cd $repo
    branch=$(basename $repo noexternalcheckout)
    test $branch == stdtsys && branch=$(git rev-parse --abbrev-ref HEAD)
    for remote in $(git remote show); do
        #if [[ "$remote" == ksgitlab ]] && [[ -f ~/.ssh/id_rsa_ks ]] && ! ssh-add -L | grep -q id_rsa_ks; then
        #    ssh-add ~/.ssh/id_rsa_ks
        #fi
        curbranch=$(git rev-parse --abbrev-ref HEAD)
        if [[ "$branch" != "$curbranch" ]]; then
            git checkout -b "$branch" &>/dev/null || git checkout "$branch"
            git branch -D master || true
        fi
        git fetch $remote $branch
    done
    git remote show | grep -q . && \
        git merge -m automerge $(git remote show | sed -r -e "s/$/\\/$branch/")
    set +x
done
[[ -d ~/.tmp/touch ]] && touch ~/.tmp/touch/stdhome-pull
exit 0
