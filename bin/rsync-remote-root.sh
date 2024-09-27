#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

set -x
rsync --rsh="ssh -t" --rsync-path="sudo nice -n +3 rsync" "$@"
