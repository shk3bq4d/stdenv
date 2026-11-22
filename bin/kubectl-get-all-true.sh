#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';


kubectl api-resources --verbs=list --namespaced -o name | grep -xvE 'events|events.events.k8s.io' | xargs -tn 1 kubectl get --show-kind --no-headers --ignore-not-found=true "$@"
