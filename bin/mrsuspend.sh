#!/usr/bin/env bash
# ex: set filetype=sh :

set -o pipefail
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
exec > >(tee -a ~/.tmp/log/mrsuspend.sh.log)
exec 2>&1

_pgrep() {
    pgrep -f "git (fetch|pull|push)"

}

wait_git() {
    while :; do
        _pgrep && sleep 1 && continue
        sleep 0.1
        _pgrep && sleep 1 && continue
        sleep 0.1
        _pgrep && sleep 1 && continue
        sleep 0.1
        _pgrep || break
    done
}
source ~/bin/dot.hostname
for i in ~/.std*_aliases; do
    source  $i
done
case $HOSTNAMEF in \
${WORK_PC1F:-uoeuoeau})
    exit 1
    ;;
apr16.ly.lan)
    if [[ -z "$SSH_CLIENT" ]]; then
        sleep-feedback.sh 60
        pkill -9 sshuttle
        docker stop forticlientvpn
        sudo pm-suspend
    else
        nohup sh -c "sleep 5; sudo pm-suspend;" </dev/null &>/dev/null &
        echo "you came remotely and have 5 seconds to close your SSH session"
    fi
    ;;
dec17.ly.lan|nov20.ly.lan|shaz*)
    if at-work.sh; then
        mri3_lock &
    fi
    wait_git
    if [[ -z "$SSH_CLIENT" ]]; then
        pkill -9 sshuttle
        #docker stop forticlientvpn
        #pkill -9 forticlientsslvpn_cli
    fi
    ~/bin/bt-airpod-marc-off.sh
    autorandr --load default
    mute.sh
    sudo umount -t fuse.sshfs -a
    citrix-stop-kill-all.sh
    # before suspend launch a background process that, contrary to an unique sleep
    # command, will sleep for at least $delay actual seconds and not
    # for real (wall-clock) time
    # The idea is to restore the keepass fs early
    delay=90
    before=$(date +%s)
    after=$(( before + delay ))
    {
        exec > >(tee -a ~/.tmp/log/mrsuspend.sh2.log)
        exec 2>&1
        date
        while :; do
            now=$(date +%s)
            if [[ $now -gt $after ]]; then
                echo completed
                break
            fi
            sleep 1
        done
        set -x
        run-parts ~/.std/resume-from-suspend/ || true
        date
    } &
    # sudo systemctl hibernate # -> to disk
    mri3_lock &
    sleep 0.3
    ! sudo systemctl hybrid-sleep && sleep 1 && { pkill i3lock || true; } # -> to disk + to RAM
    # sudo systemctl suspend # -> to RAM
    exit 0
    ;;
esac
exit 1

echo EOF
exit 0

