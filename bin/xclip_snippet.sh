#!/usr/bin/env bash
set -x
name="$(basename ${BASH_SOURCE[0]} .sh)"
name="${name//xclip_/}"
name="$HOME/snippet/$name"
! test -f "$name" && echo "FATAL: not a file $name" && exit 1
xclip < "$name"
