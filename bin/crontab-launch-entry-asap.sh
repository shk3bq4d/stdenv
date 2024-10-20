#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" ]] && [[ -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
untrap() { trap - SIGHUP SIGINT SIGQUIT SIGTERM EXIT; }

cleanup_crontab_line() {
    if [[ "$(source_type "$@")" == *user ]]; then
        sed -r -e "s/^\s*(@\w+\s+|[*0-9]\S*\s+(\S+\s+){4})//"
    else
        sed -r -e "s/^\s*(@\w+\s+|[*0-9]\S\s+(\S+\s+){4})\S+\s+//"
    fi
}

crontab_line_user() {
    if [[ "$(source_type "$@")" == *user ]]; then
        return 0
    else
        sed -r -e "s/^\s*(@\w+\s+|[*0-9]\S*\s+(\S+\s+){4})(\S+)\s+.*/\3/"
    fi
}

filter() {
    if [[ $# -eq 0 ]]; then
        cat
    else
        grep -E --color=always "$@"
    fi
}

cleanup_crontab_file_stdin() {
    grep -E "^\s*[@*0-9]" |
        grep -vF '# crontab-launch-entry-asap.sh' |
        grep -vF 'RUNONCEID=' |
        filter "$@"
}

source_type() {
    if [[ $# -eq 0 ]]; then
        echo -n "currentuser"
    elif id -un "$@" &>/dev/null; then
        echo -n "user"
    else
        echo -n "file"
    fi
}

newentry() {
    local entry
    entry="$1"
    shift
    #echo -n "$(date -d "@$dateref" +'%_M    %_H  %_d  %_m') $dow"
    echo -n "$(date -d "@$dateref" +'%_M    %_H  %_d  %_m') *" # don't use dow => https://stackoverflow.com/questions/34357126/why-crontab-uses-or-when-both-day-of-month-and-day-of-week-specified
    echo -n " $(crontab_line_user "$@" <<< "$entry")"
    echo -n " test \`date +\\%Y\` = $(date +%Y) || exit; "
    cleanup_crontab_line "$@" <<< "$entry" | sed -r -e "s/$/ # crontab-launch-entry-asap.sh $(date -d "@$dateref" +'%Y.%m.%d %H:%M:%S')/"
}

consume_crontab() {
    local f user
    if [[ $# -eq 0 ]] || [[ -z "$1" ]]; then
        crontab -l
    elif id -un "$@" &>/dev/null; then
        user="$(id -un "$@")"
        #crontab -l -u "$user"
        ! crontab -l -u "$user" 2>/dev/null && echo "enter your sudo password" && sudo crontab -l -u "$user"
    else
        case "$@" in \
        crontab)
            f=/etc/crontab
            ;;
        *)
            f="$@"
            ;;
        esac
        if [[ -f "$f" ]]; then
            cat $f
        else
            >&2 echo "FATAL: not a file nor a user $@"
            exit 1
        fi
    fi
    return 0
}

remove_colors() {
    sed -u -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2}){0,2})?[mGK]//g" "$@"
}

EOFF=$'\033[m'
ECYAN=$'\033[0;36m'    # cyan

while :; do
    _user="${1:-}"
    _grep="${2:-}"
    [[ $_user == "me" ]] && _user=$(id -un)
    [[ $_user == "" ]] && _user=$(id -un)
    consume_crontab "$_user" | cleanup_crontab_file_stdin "$_grep" > $_tempfile
    nb_lines="$(wc -l < $_tempfile)"
    cat -n $_tempfile  | sed -r -e "s/^([ 0-9]+)/$ECYAN\1$EOFF/"
    echo -n "Which entry would you like to execute ? "

    read _read
    if [[ -z "$_read" ]]; then
        echo "EMPTY, aborting"
        exit 1
    fi
    if ! [[ "$_read" =~ ^[0-9]+$ ]]; then
        echo "NOT a number"
        continue
    fi

    if [[ "$_read" == 0 ]]; then
        echo "ZERO"
        continue
    fi

    if [[ "$_read" -gt "$nb_lines" ]]; then
        echo "Entry $_read is greater than max lines $nb_lines"
        continue
    fi


    entry="$(remove_colors $_tempfile | sed -r -n "$_read p")"
    #dateref="$(date +%s -d "+2 minute ago")"
    dateref="$(date +%s -d "$(date +'%Y-%m-%d %H:%M' -d "+2 minute")")"
    backupfile=/tmp/crontab-launch-entry-asap.$(date +'%Y.%m.%d_%H.%M.%S')
    dow=$(date +%a | tr '[:upper:]' '[:lower:]')
    #echo "entry is $entry"
    #echo "crontab_line_user is $(crontab_line_user "$@" <<< "$entry")"
    #echo "_user is $_user"
    #echo "source_type is $(source_type "$_user")"
    case "$(source_type "$_user")" in \
    currentuser)
        {   crontab -l | tee $backupfile
            newentry "$entry" "$_user"
        } > $_tempfile
        echo A
        if [[ $(stat -c %s $_tempfile) -lt 5 ]]; then
            echo "FATAL: something went off $_tempfile A 1"
            untrap
            exit 1
        fi
        set -x
        crontab - < $_tempfile
        set +x
        if [[ $(crontab -l | wc -c) -lt 5 ]]; then
            echo "FATAL: something went off $_tempfile A 2"
            untrap
            exit 1
        fi
        ;;
    user)
        if crontab -l -u "$_user" &>/dev/null; then
            echo HERE
            {   crontab -l -u "$_user" | tee $backupfile
                newentry "$entry" "$_user"
            } > $_tempfile
            #echo === tempfile is
            #cat $_tempfile
            #echo === before -l is
            #crontab -l -u "$_user"
            #crontab -u "$_user" - < $_tempfile <-- 2024.09.05 that construction was selinux denied
            echo B
            if [[ $(stat -c %s $_tempfile) -lt 5 ]]; then
                echo "FATAL: something went off $_tempfile B 1"
                untrap
                exit 1
            fi
            set -x
            cat $_tempfile | crontab -u "$_user" -
            set +x
            if [[ $(crontab -l -u "$_user" | wc -c) -lt 5 ]]; then
                echo "FATAL: something went off $_tempfile B 2"
                untrap
                exit 1
            fi
            #echo '<<<'
            #echo === after -l is
            #crontab -l -u "$_user"
            #echo '<<<'
        else
            echo C
            set -x
            {   sudo crontab -l -u "$_user" | tee $backupfile
                newentry "$entry" "$_user"
            } > $_tempfile
            if [[ $(stat -c %s $_tempfile) -lt 5 ]]; then
                echo "FATAL: something went off $_tempfile C 1"
                untrap
                exit 1
            fi
            cat $_tempfile | sudo crontab -u "$_user" -
            if [[ $(sudo crontab -l -u "$_user" | wc -c) -lt 5 ]]; then
                echo "FATAL: something went off $_tempfile C 2"
                untrap
                exit 1
            fi
        fi
        ;;
    *)
        cp "$_user" $backupfile
        if [[ -w "$@" ]]; then
            newentry "$entry" "$_user" >> "$_user"
        else
            newentry "$entry" "$_user" | sudo tee -a "$_user" >/dev/null
        fi
        ;;
    esac
    echo "===="
    echo "DONE, will execute at $(date -d @$dateref +'%H:%M') in $(( $(date -d @$dateref +%s) - $(date +%s) )) seconds. A backup copy was saved in $backupfile"

    break
done


cleanup
exit 0
