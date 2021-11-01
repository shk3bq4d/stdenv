#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

curl -s http://omahaproxy.appspot.com/all.json | jq -r '.[] | select(.os=="win") | .versions[] | select(.channel=="stable") | .current_version'
