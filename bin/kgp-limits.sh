#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

if [[ $# -eq 0 ]]; then
    ARGS="--all-namespaces"
else
    ARGS="$@"
fi

# Fetch once, reuse for all three views
PODS_JSON=$(kubectl get pods $ARGS -o json)
#echo $PODS_JSON

# --- jq helper functions (shared via a jq module string) ---
JQ_CONV='
def cpu_to_m:
  if . == null then 0
  elif test("m$") then (rtrimstr("m") | tonumber)
  else (tonumber * 1000)
  end;

def mem_to_b:
  if . == null then 0
  elif test("Ki$") then (rtrimstr("Ki")|tonumber)*1024
  elif test("Mi$") then (rtrimstr("Mi")|tonumber)*1048576
  elif test("Gi$") then (rtrimstr("Gi")|tonumber)*1073741824
  elif test("Ti$") then (rtrimstr("Ti")|tonumber)*1099511627776
  elif test("k$")  then (rtrimstr("k")|tonumber)*1000
  elif test("M$")  then (rtrimstr("M")|tonumber)*1000000
  elif test("G$")  then (rtrimstr("G")|tonumber)*1000000000
  elif test("T$")  then (rtrimstr("T")|tonumber)*1000000000000
  else tonumber
  end;
'

echo "### Per-container detail ###"
echo "$PODS_JSON" | jq -r "
$JQ_CONV
[\"NAMESPACE\",\"PODNAME\",\"CONTAINER\",\"NODE\",\"CPU_REQ\",\"CPU_LIM\",\"MEM_REQ\",\"MEM_LIM\"],
((if .kind == \"List\" or .kind == \"PodList\" then .items else [.] end)[]
  | .metadata.namespace as \$ns
  | .metadata.name as \$pod
  | .spec.nodeName as \$node
  | .spec.containers[]
  | [\$ns, \$pod, .name, (\$node // \"-\"),
     (.resources.requests.cpu // \"-\"),
     (.resources.limits.cpu // \"-\"),
     (.resources.requests.memory // \"-\"),
     (.resources.limits.memory // \"-\")]
) | @tsv" | column -t

echo
echo "### Per-node totals ###"
echo "$PODS_JSON" | jq -r "
$JQ_CONV
[(if .kind == \"List\" or .kind == \"PodList\" then .items else [.] end)[]
  | .spec.nodeName as \$node
  | .spec.containers[]
  | {
      node: (\$node // \"-\"),
      cpu_req: (.resources.requests.cpu | cpu_to_m),
      cpu_lim: (.resources.limits.cpu | cpu_to_m),
      mem_req: (.resources.requests.memory | mem_to_b),
      mem_lim: (.resources.limits.memory | mem_to_b)
    }]
| group_by(.node)
| map({
    node: .[0].node,
    cpu_req: (map(.cpu_req) | add),
    cpu_lim: (map(.cpu_lim) | add),
    mem_req: (map(.mem_req) | add),
    mem_lim: (map(.mem_lim) | add)
  })
| ([\"NODE\",\"CPU_REQ\",\"CPU_LIM\",\"MEM_REQ\",\"MEM_LIM\"]),
  (.[] | [.node, \"\(.cpu_req)m\", \"\(.cpu_lim)m\",
          \"\((.mem_req/1048576)|floor)Mi\", \"\((.mem_lim/1048576)|floor)Mi\"])
| @tsv" | column -t

echo
echo "### Cluster total ###"
echo "$PODS_JSON" | jq -r "
$JQ_CONV
[(if .kind == \"List\" or .kind == \"PodList\" then .items else [.] end)[]
| .spec.containers[] | {
  cpu_req: (.resources.requests.cpu | cpu_to_m),
  cpu_lim: (.resources.limits.cpu | cpu_to_m),
  mem_req: (.resources.requests.memory | mem_to_b),
  mem_lim: (.resources.limits.memory | mem_to_b)
}]
| {
    cpu_req: (map(.cpu_req) | add),
    cpu_lim: (map(.cpu_lim) | add),
    mem_req: (map(.mem_req) | add),
    mem_lim: (map(.mem_lim) | add)
  }
| ([\"CPU_REQ\",\"CPU_LIM\",\"MEM_REQ\",\"MEM_LIM\"]),
  ([\"\(.cpu_req)m\", \"\(.cpu_lim)m\",
    \"\((.mem_req/1048576)|floor)Mi\", \"\((.mem_lim/1048576)|floor)Mi\"])
| @tsv" | column -t
exit $?

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

if [[ $# -eq 0 ]]; then
    ARGS="--all-namespaces"
else
    ARGS="$@"
fi

kubectl get pods $ARGS -o json | jq -r '
["NAMESPACE","PODNAME","CONTAINER","CPU_REQ","CPU_LIM","MEM_REQ","MEM_LIM"],
(.items[]
  | .metadata.namespace as $ns
  | .metadata.name as $pod
  | .spec.containers[]
  | [$ns, $pod, .name,
     (.resources.requests.cpu // "-"),
     (.resources.limits.cpu // "-"),
     (.resources.requests.memory // "-"),
     (.resources.limits.memory // "-")]
) | @tsv' | column -t
