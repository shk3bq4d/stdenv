#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

sudo zgrep -h ' status installed ' /var/log/dpkg.log* \
  | awk '{print $1, $2, $4, $5, $6}' \
  | sort \
  | tail -n 50

sudo systemctl status apt-daily.service
sudo systemctl status apt-daily.timer
sudo systemctl status apt-daily-upgrade.service
sudo systemctl status apt-daily-upgrade.timer
