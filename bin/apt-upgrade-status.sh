#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

sudo apt-cache policy

sudo zgrep -h ' status installed ' /var/log/dpkg.log* \
  | awk '{print $1, $2, $4, $5, $6}' \
  | sort \
  | tail -n 50

enabled_units() {
    cat << EOF
apt-daily.service
apt-daily.timer
apt-daily-upgrade.service
apt-daily-upgrade.timer
EOF
}

active_units() {
    cat << EOF
apt-daily.timer
apt-daily-upgrade.timer
EOF
}

#{ sudo systemctl status apt-daily.service || true; } | cat
#{ sudo systemctl status apt-daily.timer || true; } | cat
#{ sudo systemctl status apt-daily-upgrade.service || true; } | cat
#{ sudo systemctl status apt-daily-upgrade.timer || true; } | cat

for unit in $(active_units); do
    printf "is-active %-30s" "$unit"
    sudo systemctl is-active "$unit" >/dev/null && echo "ok" || echo "KO"
done
for unit in $(enabled_units); do
    printf "is-enabled %-30s" "$unit"
    sudo systemctl is-enabled "$unit" >/dev/null && echo "ok" || echo "KO"
done

sudo needrestart -b
[[ -f /var/run/reboot-required || -f /opt/sf-scripts/.sf-reboot-needed-custom ]] && echo "reboot needed .bashrc $(hostname -f)"

false && sudo find /etc/apt \
  \( -path '/etc/apt/sources.list' -o \
     -path '/etc/apt/sources.list.d/*.list' -o \
     -path '/etc/apt/sources.list.d/*.sources' \) \
  -type f -print

#sudo grep -RHsEv '^\s*(#|$)' \
{ sudo grep -RHsEv '^\s*(#|$)' \
  /etc/apt/sources.list \
  /etc/apt/sources.list.d/*.list \
  /etc/apt/sources.list.d/*.sources 2>/dev/null || true; } | grep -i --color=always http
