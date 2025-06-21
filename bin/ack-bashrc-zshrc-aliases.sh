#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

files() {
    cat << EOF
~/.bashrc
~/.bashrc_mrprompt
~/.zshrc
~/.zlogin
~/.zlogout
~/.zprofile
~/.zshenv
~/.sshrc
~/.profile
~/bin/dot.bashfunctions
~/bin/dot.gitfunctions
/etc/profile
/etc/profile.d/*sh
/etc/bash.bashrc
/etc/bashrc
/etc/inputrc
/etc/screenrc
EOF
    ls -1 ~/.*aliases

}

filter_existing() {
    cat | while read line; do
        test -e "$line" && echo "$line"
    done
}

files_unique_sorted() {
    files | sed -r -e "s,^~/,$HOME/," | filter_existing | xargs -n 1 realpath | sort -u

}

ack -i "$@" -- $(files_unique_sorted)
exit 0
