#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

set -x
echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_stop_threshold
echo 20 | sudo tee /sys/class/power_supply/BAT0/charge_start_threshold
