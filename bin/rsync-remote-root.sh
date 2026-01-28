#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

set -f # disable path expansion globbing *
set -x
rsync --rsh="ssh -t -l automation" --rsync-path="sudo nice -n +3 rsync" "$@"
