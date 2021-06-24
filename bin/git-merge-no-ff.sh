#!/usr/bin/env bash

set -euo pipefail
umask 027

git_current_branch () {
	local ref
	ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
	local ret=$?
	if [[ $ret != 0 ]]
	then
		[[ $ret == 128 ]] && return
		ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return
	fi
	echo ${ref#refs/heads/}
}
__git_prompt_git () {
	GIT_OPTIONAL_LOCKS=0 command git "$@"
}

glol() {
	git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' "$@"
}

fatal() {
	source ~/bin/dot.bashcolors
	echo -e "${ERED}FATAL: $@${ENONE}"
	exit 1
}

check_wip_or_fixup() {
	if glol $cur_branch...$master_branch | grep -qE -- '--wip--|fixup'; then
		glol $cur_branch...$master_branch | cat
		echo ""
		fatal "found wip or fixup in $cur_branch...$master_branch"
	fi
}

temptag=git-merge-no-ff-$(date +%s)

cur_branch="$(git_current_branch)"
master_branch=master

if [[ "$cur_branch" == "$master_branch" ]]; then
	fatal "can't merge branch $master_branch"
fi

if ! git-is-current-repo-clean; then
	fatal "current repo not clean"
fi

check_wip_or_fixup || exit 1 # test early before anything

git tag $temptag

git checkout $master_branch

if ! git pull --ff-only ; then
	echo "COULDN'T fast forward $master_branch"
	exit 1
fi


git checkout $cur_branch
if ! git rebase $master_branch; then
	git rebase --abort
	fatal "branch $cur_branch not rebasable on $master_branch"
fi

check_wip_or_fixup || exit 1 # well test again, probably redundant

git checkout $master_branch
git merge --no-ff $cur_branch --no-edit
glol $master_branch^^ | cat

echo "Success, we let you the pleasure of pushing, in case any rebase was done, a tag of $cur_branch is $temptag"
exit 0
