#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ 
##to be startup by ~/.config/i3/config
##
## Author: Jeff Malone, 22 Oct 2017
##

set -euo pipefail

function usage() { sed -r -n -e s/__SCRIPT__/$0/ -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 0 || $# -gt 0 ]] && echo FATAL: incorrect number of args && usage && exit 1

for i in touch xrdb; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done


touch ~/.tmp/touch/mr-startup-start

xrdb -merge ~/.Xdefaults

touch ~/.tmp/touch/mr-startup-end
exit 0

