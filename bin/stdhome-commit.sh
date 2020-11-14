#!/usr/bin/env bash

set -e
unset GIT_DIR
unset GIT_WORK_TREE
~/bin/stdothers.sh | grep -vE 'stdks' | while read repo; do
    if [[ "$repo" == *stdtsys ]]; then
        continue
    fi
    cd $repo
    git commit -am "auto commit $(date)" || true
done
~/bin/stdhome-pull.sh
~/bin/stdhome-push.sh
