#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

is_port_free() {
    ! netstat -tan | grep -qw $1
}

HOMEDIR=~/.mitmproxy
EXPLICIT_PROXY_PORT=8080
WEB_PORT=8081
CONTAINER_NAME=mitmproxy
IP=127.0.0.1
TAG=9.0.1
docker ps &>/dev/null && SUDO="" || SUDO="sudo"; $SUDO docker ps

is_port_free $EXPLICIT_PROXY_PORT || EXPLICIT_PROXY_PORT=$(random-free-tcp-port.sh)
is_port_free            $WEB_PORT ||            WEB_PORT=$(random-free-tcp-port.sh)
test -d $HOMEDIR || mkdir $HOMEDIR
chmod 0700 $HOMEDIR

set -x
CONTAINER_ID=$( \
$SUDO \
docker run \
    -d \
    --rm \
    -v $HOMEDIR:/home/mitmproxy/.mitmproxy \
    -p $IP:$EXPLICIT_PROXY_PORT:8080 \
    -p $IP:$WEB_PORT:8081 \
    --name $CONTAINER_NAME \
    mitmproxy/mitmproxy \
    mitmweb \
    --mode regular \
    --verbose \
    -r /home/mitmproxy/.mitmproxy/$(id -un)-flow \
    -w /home/mitmproxy/.mitmproxy/$(id -un)-flow \
    --showhost \
    --listen-host 0.0.0.0 \
    --web-host 0.0.0.0 \

)
$SUDO timeout 5 docker logs -f $CONTAINER_NAME || true

cat << EOF
I suggest you run
export  http_proxy=http://$IP:$EXPLICIT_PROXY_PORT
export https_proxy=http://$IP:$EXPLICIT_PROXY_PORT

and you can access the the webgui at
http://$IP:$WEB_PORT

CONTAINER_NAME: $CONTAINER_NAME
CONTAINER_ID:   $CONTAINER_ID
$SUDO docker logs -f $CONTAINER_NAME
EOF
