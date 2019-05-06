#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
## Author: Jeff Malone, 06 May 2019
##

set -euo pipefail

xrandr | grep -Po "(?<=current ).*?(?=,)" | sed 's/ //g'

exit 0

