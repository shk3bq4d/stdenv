#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

DIR="$PWD"
source ~/bin/dot.gitfunctions
source ~/bin/dot.bashcolors
echo -n "${EOFF}"

args() {
    if [[ $# -eq 0 ]]; then
        if [[ -n "$(git_root_dir)" ]]; then
            pwd
        else
            find $PWD -maxdepth 2 -type d -name .git -printf '%h\n' | sort
        fi
    else
        xargs -rn 1 echo <<< "$@"
    fi
}

for i in $(args "$@"); do
    test -d "$i" || i="$DIR/$i"
    test -d "$i" || continue
    cd "$i";
    j="$(basename "$i")"
    if git_is_current_repo_clean; then
        echo -e "\n"
        echo -en "$EBGGREEN"
        echo -n "$j "
        echo -en "$EGREEN"
        echo -ne $'\ue0b0'
        echo -n "${EOFF} "
    else
        echo -e "\n"
        echo -en "$EBGYELLOW"
        echo -n "$j "
        echo -en "$EYELLOW"
        echo -ne $'\ue0b0'
        echo -n "${EOFF} "
    fi
#   git fetch >/dev/null
    #git status | head -n 1
    git log -1 --color=always --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' | cat
#   git branch --sort=-committerdate --no-merged origin/master | while read line; do echo "  $line"; done
done
