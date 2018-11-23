#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 23 Nov 2018
##

set -euo pipefail
TIMESTAMP_FORMAT='%Y-%m-%dT%H:%M:%S'
TIMESTAMP_FORMAT='%Y.%m.%d %H:%M:%S'
# Bash version in numbers like 4003046, where 4 is major version, 003 is minor, 046 is subminor.
printf -v BV '%d%03d%03d' ${BASH_VERSINFO[0]} ${BASH_VERSINFO[1]} ${BASH_VERSINFO[2]}
if ((BV > 4002000)); then
log() {
    ## Fast (builtin) but sec is min sample for most implementations
    printf "%(${TIMESTAMP_FORMAT})T %5d %s\n" '-1' $$ "$*"  # %b convert escapes, %s print as is
}
else
log() {
    ## Slow (subshell, date) but support nanoseconds and legacy bash versions
    echo "$(date +"${TIMESTAMP_FORMAT}") $$ $*"
}
fi

while read line; do
	log "$line"
done

exit 0

