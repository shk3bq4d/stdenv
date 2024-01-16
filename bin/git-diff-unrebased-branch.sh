#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

origin_name=origin
branch_name=master

source ~/bin/dot.gitfunctions

files_changed_in_current_branch() {
    git diff --name-only $branch_name..

}

if ! git_is_master_an_ancestor_of_currench_branch; then
    echo "ABORTING: master is not an ancestor of current branch"
    exit 1
fi

# a) get updated origin/master
git fetch $origin_name


git diff $origin_name/$branch_name -- $(files_changed_in_current_branch)

