#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

ls -l --time-style +"%Y.%m.%d %H:%M:%S" "$@"
