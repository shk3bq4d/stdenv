#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

help() {
    cat << EOF
tunnel: LocalForward  /normal  tunnel   opens IF1:PORT1 on local  machine to reach  remote network's IP2:PORT2           -L 23131:10.1.1.10:3128
tunnel: RemoteForward /reverse tunnel   opens IF1:PORT1 on remote machine to access client network's IP2:PORT2           -R 50003:127.0.0.1:80

to access remote httpd
-L $(random-free-tcp-port.sh):127.0.0.1:443
-L \$(random-free-tcp-port.sh):127.0.0.1:443

to reverse tunnel to local sshd
-R $(random-free-tcp-port.sh):127.0.0.1:22
-R \$(random-free-tcp-port.sh):127.0.0.1:22
EOF

}

if [[ $# -lt 2 ]]; then
    echo "FATAL: only $# arguments"
    help
    exit 1
fi

command \
    ssh \
    -oControlMaster=no \
    -oControlPath=none \
    -oControlPersist=no \
    -oExitOnForwardFailure=yes \
    -N \
    -vvv \
    "$@" |&
    sed-ssh-packet-type.sh |
    grep -E --line-buffered --color=always 'open failed.*|forwarding.*requested|forwarding.*port|direct-tcpip|The following connections are open|forwarding|forwarded|admin|CHANNEL_OPEN[A-Z_]*|^' \
    &


SSH_PID="$!"
sleep 2
if ps -q $SSH_PID &>/dev/null; then
    echo "SSH: probably still running"
    netstat -ntlpe | grep -E "(\S+\s+){6}$UID\s+.*\s$SSH_PID/ssh" || true
    echo "joining/waiting"
    wait
else
    echo "FATAL: it seems my SSH process is no longer running"
    exit 1
fi
