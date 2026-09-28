#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';


LOGFILE="$HOME/.tmp/log/$(basename "$0" .sh).log"
#exec > >(tee -a ~/.tmp/log/exec-$(basename $0 .sh).log)
#exec 2>&1

# DUNST_APP_NAME, DUNST_SUMMARY, DUNST_BODY, DUNST_ICON_PATH, DUNST_URGENCY, and DUNST_ID.

printf '%s | app=%s | summary=%s | body=%s\n' \
  "$(date '+%Y-%m-%d %H:%M:%S')" \
  "${DUNST_APP_NAME:-missing DUNST_APP_NAME}" \
  "${DUNST_SUMMARY:-missing DUNST_SUMMARY}" \
  "${DUNST_BODY:-missing DUNST_BODY}" >> $LOGFILE

exit 0
