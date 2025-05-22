#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

candidate_flag_files() {
    ls -1 $HOME/.tmp/ansible-playbook-delayed-*
}

process_file() {
    local file args TH args
    file="$1"
    echo -e "\n\n=================== Processing $file"

    if ansible-playbook-delayed-ongoing.sh | grep -qE " $file"'$'; then
        echo "Skipping $file as a matching ongoing process runs"
        return 0
    fi

    TH="$(  grep -Po '(?<=TH is ).*'    $file || true)"
    args="$(grep -Po '(?<=args are ).*' $file || true)"

    if [[ -z "$TH" ]]; then
        echo "skipping file due to missing TH"
        return 0
    fi

    if [[ -z "$args" ]]; then
        echo "skipping file due to missing args"
        return 0 # since I have a clean log message, I'm fine with returning zero
    fi

    rm "$file"
    ansible-playbook-delayed-detached.sh "@$TH" $args
}


go() {
    local file
    candidate_flag_files | while read file; do
        if ! process_file $file; then
            echo "Skipping $file due to failure"
        fi
    done
}

go
