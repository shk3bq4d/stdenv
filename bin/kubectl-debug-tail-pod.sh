#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 03 Mar 2019
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

[[ -n ${VIMF6+1} ]] && VIMF6="-n gitlab gitlab-unicorn-565459dcf7-r9hjl"

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" && -d "$_tempdir" ]] && rm -rf $_tempdir || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM

# exec > >(tee -a ~/.tmp/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)
f=$_tempdir/pod.yaml

kubectl get pod "$@" $VIMF6 -o yaml > $f
#cat $f
cat $f |
python -c '
# ```python
import sys
import yaml
from pprint import pprint
rH = yaml.load(sys.stdin)
f = "{init:<1s}{name:<20s} {ready!s:<5s} {state:<12s} {exitCode!s:<3s} {restartCount!s:<3s} {startedat!s:<19s} {finishedat!s:<19s} {image}"
#pprint(rH)

pprint(rH["status"])
print(f.format(init = "", name="NAME", ready="READY", state="STATE", exitCode="$?", restartCount="#R", startedat="START", finishedat="FINISHED", image="IMAGE"))
cA = map(lambda x: ("*", x), rH["status"].get("initContainerStatuses", []))
cA.extend(map(lambda x: ("", x), rH["status"].get("containerStatuses", [])))
for init, cH in cA:
    keys = cH["state"].keys()
    state = "bip" if len(keys) == 0 else keys[0]
    stateH = cH["state"][state]
    exitCode = stateH.get("exitCode", "")
    restartCount = cH["restartCount"]
    image = cH["image"]
    ready = cH["ready"]
    name = cH["name"]
    restartCount = cH["restartCount"]
    startedat = stateH.get("startedAt", "")
    finishedat = stateH.get("finishedAt", "")

    print(f.format(**locals()))
# ```
'

echo EOF
cleanup
exit 0

