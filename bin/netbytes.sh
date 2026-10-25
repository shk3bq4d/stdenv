#!/usr/bin/env bash
# netbytes.sh - show accumulated network bytes (human readable) with a resettable baseline.
#
# The kernel counters (/sys/class/net/<if>/statistics/{rx,tx}_bytes) can't be zeroed
# from userspace, so "reset" saves the current values as a baseline and later
# readings subtract it. A reboot resets kernel counters; that is detected per
# interface and the baseline is treated as 0.
#
# Usage:
#   netbytes.sh [show]       per-interface + total RX/TX since last reset
#   netbytes.sh reset        zero the counters (save baseline)
#   netbytes.sh watch [sec]  refresh every N seconds (default 2)
#   netbytes.sh boot         totals since boot (ignores baseline)
#
# Env:
#   NETBYTES_IFACES="eth0 wlan0"   restrict to these interfaces (default: all except lo)
#   export NETBYTES_IFACES="wlp0s20f3"
#   NETBYTES_STATE=/path/file      baseline file location

set -euo pipefail

STATE="${NETBYTES_STATE:-${XDG_STATE_HOME:-$HOME/.local/state}/netbytes/baseline}"

ifaces() {
    if [[ -n "${NETBYTES_IFACES:-}" ]]; then
        printf '%s\n' $NETBYTES_IFACES
    else
        for d in /sys/class/net/*; do
            n=${d##*/}
            [[ $n == lo ]] || echo "$n"
        done
    fi
}

read_counter() { cat "/sys/class/net/$1/statistics/$2" 2>/dev/null || echo 0; }

human() { numfmt --to=iec-i --suffix=B --format='%.2f' "$1"; }

# Prints the baseline value for iface/direction, or 0.
baseline() {
    [[ -f $STATE ]] || { echo 0; return; }
    awk -v i="$1" -v k="$2" '$1==i { print (k=="rx" ? $2 : $3); f=1 } END { if (!f) print 0 }' "$STATE"
}

cmd_reset() {
    mkdir -p "$(dirname "$STATE")"
    : > "$STATE"
    for i in $(ifaces); do
        echo "$i $(read_counter "$i" rx_bytes) $(read_counter "$i" tx_bytes)" >> "$STATE"
    done
    echo "Counters zeroed ($(date '+%F %T')). Baseline: $STATE"
}

cmd_show() {
    local use_baseline=${1:-1} trx=0 ttx=0 rx tx brx btx
    if (( use_baseline )) && [[ -f $STATE ]]; then
        echo "Since reset at $(date -r "$STATE" '+%F %T')"
    else
        echo "Since boot"
    fi
    printf '%-16s %14s %14s %14s\n' IFACE RX TX TOTAL
    for i in $(ifaces); do
        rx=$(read_counter "$i" rx_bytes)
        tx=$(read_counter "$i" tx_bytes)
        if (( use_baseline )); then
            brx=$(baseline "$i" rx); btx=$(baseline "$i" tx)
            # counter went backwards => reboot / interface re-created
            (( rx < brx )) && brx=0
            (( tx < btx )) && btx=0
            rx=$((rx - brx)); tx=$((tx - btx))
        fi
        trx=$((trx + rx)); ttx=$((ttx + tx))
        printf '%-16s %14s %14s %14s\n' "$i" "$(human $rx)" "$(human $tx)" "$(human $((rx + tx)))"
    done
    printf '%-16s %14s %14s %14s\n' TOTAL "$(human $trx)" "$(human $ttx)" "$(human $((trx + ttx)))"
}

case "${1:-show}" in
    show)  cmd_show 1 ;;
    boot)  cmd_show 0 ;;
    reset|zero) cmd_reset ;;
    watch) while :; do clear; cmd_show 1; sleep "${2:-2}"; done ;;
    *) sed -n '2,18p' "$0"; exit 1 ;;
esac
