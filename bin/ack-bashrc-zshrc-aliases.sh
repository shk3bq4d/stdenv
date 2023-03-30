#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

files() {
    cat << EOF
~/.bashrc
~/.bashrc_mrprompt
~/.zshrc
~/.sshrc
~/bin/dot.bashfunctions
~/.*aliases
EOF

}

files_unique_sorted() {
    files | sed -r -e "s,^~/,$HOME/," | xargs -n 1 realpath | sort -u

}

ack "$@" -- $(files_unique_sorted)
exit 0
ack "$@" ~/.bashrc ~/.zshrc ~/.sshrc ~/bin/dot.bashfunctions ~/.*aliases

