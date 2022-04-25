#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" ]] && [[ -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
backupfile=/tmp/crontab-launch-entry-asap.$(date +'%Y.%m.%d_%H.%M.%S')

cleanup_crontab_line() {
    if [[ "$(source_type "$@")" == *user ]]; then
        sed -r -e "s/^\s*(@\w+\s+|(\S+\s+){5})//"
    else
        sed -r -e "s/^\s*(@\w+\s+|(\S+\s+){5})\S+\s+//"
    fi
}

crontab_line_user() {
    if [[ "$(source_type "$@")" == *user ]]; then
        return 0
    else
        sed -r -e "s/^\s*(@\w+\s+|(\S+\s+){5})(\S+)\s+.*/\3/"
    fi
}

cleanup_crontab_file_stdin() {
    grep -E "^\s*[@*0-9]" | grep -vF '# crontab-launch-entry-asap.sh'
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
    echo -n "$(date -d "@$dateref" +'%_M    %_H  %_d  %_m') $dow"
    echo -n " $(crontab_line_user "$@" <<< "$entry")"
    echo -n " test \`date +\\%Y\` == $(date +%Y) || exit; "
    cleanup_crontab_line "$@" <<< "$entry" | sed -r -e "s/$/ # crontab-launch-entry-asap.sh $(date -d "@$dateref" +'%Y.%m.%d %H:%M:%S')/"
}

consume_crontab() {
    local f user
    if [[ $# -eq 0 ]]; then
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

while :; do
    consume_crontab "$@" | cleanup_crontab_file_stdin > $_tempfile
    nb_lines="$(wc -l < $_tempfile)"
    cat -n $_tempfile
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


    entry="$(sed -r -n "$_read p" < $_tempfile)"
    dateref="$(date +%s -d "-2 minute ago")"
    dow=$(date +%a | tr '[:upper:]' '[:lower:]')
    #echo "entry is $entry"
    #echo "user is $(crontab_line_user "$@" <<< "$entry")"
    #exit 0
    case "$(source_type "$@")" in \
    currentuser)
        {   crontab -l | tee $backupfile
            newentry "$entry" "$@"
        } > $_tempfile
        crontab - < $_tempfile
        ;;
    user)
        if crontab -l -u "$@" &>/dev/null; then
            {   crontab -l -u "$@" | tee $backupfile
                newentry "$entry" "$@"
            } > $_tempfile
            crontab -u "$@" - < $_tempfile
        else
            {   sudo crontab -l -u "$@" | tee $backupfile
                newentry "$entry" "$@"
            } > $_tempfile
            sudo crontab -u "$@" - < $_tempfile
        fi
        ;;
    *)
        cp "$@" $backupfile
        if [[ -w "$@" ]]; then
            newentry "$entry" "$@" >> "$@"
        else
            newentry "$entry" "$@" | sudo tee -a "$@" >/dev/null
        fi
        ;;
    esac
    echo "DONE, will execute at $(date -d @$dateref +'%H:%M'). A backup copy was saved in $backupfile"

    break
done


cleanup
exit 0
