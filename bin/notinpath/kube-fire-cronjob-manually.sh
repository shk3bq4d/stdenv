#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
set -euo pipefail

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

context=MYKUBECONTEXT
namespace=$(basename $DIR)

applabel=$namespace
applabel=${applabel//-uat/}
applabel=${applabel//-prod/}
applabel=${applabel//-dev/}

jobname=shmanual

function k() {
    kubectl --context $context -n $namespace "$@"
}

function get_pod_name() {
    k get pod -l app=$applabel -o name | grep $jobname | tail -1
}


k delete job $jobname &>/dev/null || true
k create job $jobname --from=cronjob/cronjob
while ! get_pod_name &>/dev/null; do
    sleep 1
done
pod=$(get_pod_name)
k wait --for=condition=Ready --timeout=5m $pod
k logs -f $pod --pod-running-timeout=60s --timestamps=true
k delete job $jobname

echo -n "would you like to git pull (yN): " # read
read _read
echo # read
case "${_read,,}" in \
y|yes)
    cd $DIR
    git pull
    ;;
esac # read
echo EOF
exit 0

