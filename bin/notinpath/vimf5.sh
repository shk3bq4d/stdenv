#!/usr/bin/env bash
# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

export VIMF6=1

[[ -z "$1" ]] && echo "Inception A" && exit 1
current_epoch=$(date +%s) # duration
SCRIPT="$1"
LOG="$2"
#exec > >(tr -d '\r' | tee "$LOG")
exec > >(tee "$LOG")
exec 2>&1
SCRIPT_DIR=$(dirname "$SCRIPT")
SCRIPT_NAME=$(basename "$SCRIPT")
export PYTHONUNBUFFERED=hehe
function myexit() {
    duration=$(( $(date +%s) - $current_epoch ))
    echo "vimf6.sh by extension exit code is $1, duration is ${duration}s" # to review if we have case exit corde or real interpreter
    exit $1
}

# by extension
case "$SCRIPT" in \
vimf6.sh)
    echo "Inception B"
    exit 0
    ;;
*py)  mypy $SCRIPT; myexit $?;;
esac
echo "($(basename $0)): unimplemented case for script $SCRIPT"
exit 1
