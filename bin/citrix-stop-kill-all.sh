#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

set +e
set -x
sudo systemctl stop ctxlogd
sudo systemctl stop ctxcwalogd
# /opt/Citrix/ICAClient//UtilDaemon                                                                                                        13:24:58  45ms
sleep 1
sudo pkill -f ^/opt/Citrix/
pkill ServiceRecord
pkill wfica
sleep 1
sudo pkill -9 -f ^/opt/Citrix/
sudo pkill ctxcwalogd
sleep 1
pkill -9 ServiceRecord
pkill -9 wfica
sudo pkill -9 ctxcwalogd
exit 0
