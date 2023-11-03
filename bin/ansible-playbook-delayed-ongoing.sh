#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# https://stackoverflow.com/questions/30758424/starting-a-new-process-group-from-bash-script
# difference between a session and a group
ongoing_pgids() {
    ps --no-headers --ppid 1 -o pgid,cmd | grep ansible-playbook-delayed-detached.sh | awk '{ print $1 }'
}

print_pgid() {
    local pgid mpgid sleep sleep_pid start_time sleep_lmod_epoch flag_file
    pgid="$1"
    mpgid="-$pgid"
    #echo "pgid: $1"
    sleep=$(ps --no-headers -o pid,cmd $mpgid | grep -E "sleep [0-9]+$" | awk-print-last.sh)
    #ps --no-headers -o pid,cmd $mpgid | grep -E "sleep [0-9]+$"
    sleep_pid=$(ps --no-headers -o pid,cmd $mpgid | grep -E "sleep [0-9]+$" | awk-print1.sh)
    sleep_lmod_epoch=$(stat -c %Y /proc/$sleep_pid/stat)
    #echo "sleep is $sleep, sleep_pid is $sleep_pid"
    flag_file=$(ps --no-headers -o ppid,cmd $mpgid | grep ansible-playbook-delayed-color- | awk-print-last.sh | sed -r -e 's/-color//' -e 's/\.log$//' -e 's,log/(ansible-playbook-),\1,')

    echo -n -e "\n========= PGID $pgid -- "
    if [[ ! -f $flag_file ]]; then
        echo ""
        echo "skipping as missing flag_file $flag_file"
        continue
    fi

    ps --no-headers -o ppid,cmd $mpgid | grep -E "^ *1 " | awk-print-shift.sh 3
    echo "Since:   $(date +'%a %b %d %H:%M' -d @$sleep_lmod_epoch)"
    echo "Exec:    $(date +'%a %b %d %H:%M' -d @$(( sleep_lmod_epoch + sleep)) ) (sleeping $sleep seconds)"
    echo "To Kill:"
    echo "kill -9 -- $mpgid; command rm -f $flag_file"
}


for pgid in $(ongoing_pgids); do
    print_pgid "$pgid"
done

echo ""
exit 0
