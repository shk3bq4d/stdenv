#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 26 Aug 2026
##

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

kubectl get nodes -o json "$@" | jq -r '
    (["NAME","TAINTS","LABELS"] | @tsv),
  (.items[] | [
    .metadata.name,
    ((.spec.taints // [])
      | map(.key + (if .value then "=" + .value else "" end) + ":" + .effect)
      | join(",")) as $t | ($t // "-"),
    (.metadata.labels
      | to_entries
      | map(select(.key | contains("kubernetes.io") | not))
      | map(.key + "=" + .value)
      | join(",")) as $l | ($l // "-")
  ] | @tsv)
' | column -t -s $'\t'
