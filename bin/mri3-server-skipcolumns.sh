#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027

# we need "skipcolums to be kept in the window title
# sleeping forever is the easiest way to achieve this
# possible this command should spawn a mruxrvt term if
# not executed from terminal so it can be launched from
#
if [[ -t 0 ]]; then
    echo "$(basename $0) sleeping 100 days"
    sleep 100d
else
    mrurxvt --title "$(basename $0)" -e bash -c "echo $(basename $0) sleeping 100 days; sleep 100d"
fi

exit 0
