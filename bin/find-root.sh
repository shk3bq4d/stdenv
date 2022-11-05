#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

find $(ls -1a / | grep -xEv '\.|\.\.|run|proc|sys|lost\+found' | sed -r -e 's,^,/,') "$@"
