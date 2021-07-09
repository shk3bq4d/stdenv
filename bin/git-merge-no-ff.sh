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
	echo "temptag is ${temptag:-unset}, branch to merge is ${cur_branch:-unset}"
	exit 1
}

check_wip_or_fixup() {
	if glol $cur_branch...$master_branch | grep -qE -- '--wip--|fixup'; then
		glol $cur_branch...$master_branch | cat
		echo ""
		fatal "found wip or fixup in $cur_branch...$master_branch"
	fi
}

if ! git rev-parse --show-toplevel &>/dev/null; then
	fatal "not a git dir?"
fi

_git_dir="$(git rev-parse --show-toplevel)/.git"

cur_branch="$(git_current_branch)"
master_branch=master

if [[ "$cur_branch" == "$master_branch" ]]; then
	fatal "current branch is $cur_branch, which is the same as target branch $master_branch"
fi

cur_head=$(<$_git_dir/refs/heads/$cur_branch)
master_head=$(<$_git_dir/refs/heads/$master_branch)

if [[ "$cur_head" == "$master_head" ]]; then
	fatal "current branch $cur_branch's head is $cur_branch, identical to target branch $master_branch's head $master_head"
fi

if git branch --merged $master_branch | grep -E "^[\\* ]*$cur_branch\$"; then
	fatal "current branch $cur_branch's is listed as fully merged by git branch --merged"
fi

if ! git-is-current-repo-clean; then
	fatal "current repo not clean"
fi

check_wip_or_fixup

temptag=git-merge-no-ff-$(date +%s)
git tag $temptag

git checkout $master_branch

if ! git pull --ff-only --rebase=false; then
	echo "COULDN'T fast forward $master_branch"
fi

if ! diff -q $_git_dir/refs/heads/$master_branch $_git_dir/refs/remotes/origin/$master_branch >/dev/null; then
	glol -5 $master_branch origin/$master_branch $cur_branch --color=always | cat
	fatal "FATAL: likely $master_branch is ahead or origin/$master_branch\nPlease deal with the situation yourself"
fi


git checkout $cur_branch
if ! git rebase $master_branch; then
	git rebase --abort
	fatal "branch $cur_branch not rebasable on $master_branch"
fi

check_wip_or_fixup

git checkout $master_branch
git merge --no-ff $cur_branch --no-edit

glol ${master_branch}...$master_head^ --color=always | cat

echo "Success, we let you review and push
$master_head : prev $master_branch
$cur_head : prev $cur_branch, tagged as $temptag

temporary tags can be remove by issuing
git tag | grep git-merge-no-ff- | xargs -r git tag -d
"
exit 0
