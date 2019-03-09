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

source ~/bin/dot.bashcolors

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

[[ -n ${VIMF6:-} ]] && VIMF6="-n gitlab gitlab-unicorn-565459dcf7-r9hjl"

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" && -d "$_tempdir" ]] && rm -rf $_tempdir || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM

# exec > >(tee -a ~/.tmp/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)
f=$_tempdir/pod.yaml

kubectl get pod "$@" -o yaml > $f
#cat $f
{

cat $f |
python -c '
# ```python
import os
import sys
import yaml
from pprint import pprint
rH = yaml.load(sys.stdin)
pattern = "{init:<1s}{name:<20s} {ready!s:<5s} {state:<12s} {exitCode!s:<3s} {restartCount!s:<3s} {startedat!s:<19s} {finishedat!s:<19s} {image}"
#pprint(rH)

f_containers = open(os.path.join(sys.argv[1], "containers"), "wb")
open(os.path.join(sys.argv[1], "name"),      "wb").write(rH["metadata"]["name"])
open(os.path.join(sys.argv[1], "namespace"), "wb").write(rH["metadata"]["namespace"])
#pprint(rH["status"])
print(pattern.format(init = "", name="NAME", ready="READY", state="STATE", exitCode="$?", restartCount="#R", startedat="START", finishedat="FINISHED", image="IMAGE"))
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

    print(pattern.format(**locals()))
    f_containers.write(" " + name)
# ```
' $_tempdir

name="$(cat $_tempdir/name)"
namespace="$(cat $_tempdir/namespace)"

echo -e "\n\nEvents:"
kubectl get event --namespace $namespace --field-selector involvedObject.name=$name
echo -e "\n\n press Q to start reading logs up until now"

} | less --no-init

name="$(cat $_tempdir/name)"
namespace="$(cat $_tempdir/namespace)"
mkdir $_tempdir/logs
for container in $(cat $_tempdir/containers); do
    kubectl logs \
        --timestamps=true \
        --namespace=$namespace \
        --container=$container \
        $name |
        sed -r -e 's,(\S+) (.*),\1 '${EBLUE}${container}${EOFF}' \2,' \
        > $_tempdir/logs/${container}.log
done
sort $_tempdir/logs/*.log | less -M --raw-control-chars --ignore-case --status-column --no-init
exit 0
echo -e "\n\n press Q to start tailing logs up until now"

for container in $_tempdir/containers; do
    kubectl logs \
        --all-containers=true \
        --tail=100 \
        --follow=true \
        --timestamps=true \
        
done

echo EOF
cleanup
exit 0

