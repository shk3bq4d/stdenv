#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ SRCDIR DSTDIR
##
## Author: Jeff Malone, 13 Feb 2023
##

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 2 || $# -gt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

SRCDIR="$1"
DSTDIR="$2"
! test -d "$SRCDIR" && echo "FATAL: not a dir $SRCDIR" && exit 1
  test -d "$DSTDIR" && echo "FATAL: already a  dir $DSTDIR" && exit 1

! test -f "$SRCDIR/Vagrantfile" && echo "FATAL: not a file $SRCDIR/Vagrantfile" && exit 1

mkdir "$DSTDIR"
rsync -avr \
    --exclude=.vagrant \
    --exclude=roles-external \
    --max-size=10M \
    "$SRCDIR"/. \
    "$DSTDIR"/.

echo EOF
exit 0
    --exclude=*.box \
