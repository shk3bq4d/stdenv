#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

set +e
set -x
docker ps &>/dev/null && SUDO="" || SUDO="sudo";
$SUDO docker ps -a | grep -w cups
systemctl status cups | cat
lpstat -p -d #list printers

exit 0

