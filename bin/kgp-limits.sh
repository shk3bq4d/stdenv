#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# --field-selector=spec.nodeName=NODENAME -A

if [[ $# -eq 0 ]]; then
    ARGS="--all-namespaces"
else
    ARGS="$@"
fi

# Fetch once, reuse for all three views
kubectl get pods $ARGS -o json > "$TMPDIR/pods.json"
kubectl get nodes -o json > "$TMPDIR/nodes.json"

# Usage: <tsv on stdin> | print_table "<comma-separated 1-based column indices to right-align>"
print_table() {
  awk -F'\t' -v rjust="$1" '
    BEGIN {
      n = split(rjust, r, ",")
      for (i = 1; i <= n; i++) rmap[r[i]] = 1
    }
    {
      for (i = 1; i <= NF; i++) {
        data[NR, i] = $i
        if (length($i) > w[i]) w[i] = length($i)
      }
      if (NF > maxnf) maxnf = NF
      nr = NR
    }
    END {
      for (row = 1; row <= nr; row++) {
        line = ""
        for (i = 1; i <= maxnf; i++) {
          cell = data[row, i]
          pad = w[i] - length(cell)
          if (rmap[i]) { for (j = 0; j < pad; j++) cell = " " cell }
          else         { for (j = 0; j < pad; j++) cell = cell " " }
          line = line (i > 1 ? "  " : "") cell
        }
        print line
      }
    }'
}

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

def fmt_cpu_m: "\(.)m";
def fmt_mem_mi: "\((./1048576)|floor)Mi";
'

echo "### Per-container detail ###"
jq -r "
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
) | @tsv" "$TMPDIR/pods.json" | print_table "5,6,7,8"


echo
echo "### Per-node totals ###"
# Optional: regexes to exclude taints/labels by key (leave empty to disable)
TAINT_EXCLUDE_REGEX="${TAINT_EXCLUDE_REGEX:-}"
LABEL_EXCLUDE_REGEX="${LABEL_EXCLUDE_REGEX:-}"

jq -r --slurpfile nodes "$TMPDIR/nodes.json" \
      --arg taint_exclude "$TAINT_EXCLUDE_REGEX" \
      --arg label_exclude "$LABEL_EXCLUDE_REGEX" "
$JQ_CONV

def key_excluded(re):
  (re != \"\") and (.key | test(re));

def fmt_taints:
  map(select(key_excluded(\$taint_exclude) | not))
  | map(if (.value // \"\") != \"\"
        then \"\(.key)=\(.value):\(.effect)\"
        else \"\(.key):\(.effect)\"
        end)
  | join(\",\")
  | if . == \"\" then \"-\" else . end;

def fmt_labels:
  to_entries
  | map(select(key_excluded(\$label_exclude) | not))
  | map(\"\(.key)=\(.value)\")
  | join(\",\")
  | if . == \"\" then \"-\" else . end;

(\$nodes[0].items | map({
    key: .metadata.name,
    value: {
      alloc_cpu: (.status.allocatable.cpu | cpu_to_m),
      alloc_mem: (.status.allocatable.memory | mem_to_b),
      cap_cpu:   (.status.capacity.cpu | cpu_to_m),
      cap_mem:   (.status.capacity.memory | mem_to_b),
      taints:    (.spec.taints // [] | fmt_taints),
      labels:    (.metadata.labels // {} | fmt_labels)
    }
  }) | from_entries) as \$nodemap
| [(if .kind == \"List\" or .kind == \"PodList\" then .items else [.] end)[]
    | .metadata.name as \$pod
    | (.metadata.namespace // \"default\") as \$ns
    | .spec.nodeName as \$node
    | .spec.containers[]
    | {
        node: (\$node // \"PendingPods\"),
        pod: \$pod,
        ns: \$ns,
        cpu_req: (.resources.requests.cpu | cpu_to_m),
        cpu_lim: (.resources.limits.cpu | cpu_to_m),
        mem_req: (.resources.requests.memory | mem_to_b),
        mem_lim: (.resources.limits.memory | mem_to_b)
      }]
  | group_by(.node)
  | map({
      node: .[0].node,
      pods: (map(.pod) | unique | length),
      containers: length,
      cpu_req: (map(.cpu_req) | add),
      cpu_lim: (map(.cpu_lim) | add),
      mem_req: (map(.mem_req) | add),
      mem_lim: (map(.mem_lim) | add),
      alloc_cpu: (\$nodemap[.[0].node].alloc_cpu // 0),
      alloc_mem: (\$nodemap[.[0].node].alloc_mem // 0),
      cap_cpu:   (\$nodemap[.[0].node].cap_cpu // 0),
      cap_mem:   (\$nodemap[.[0].node].cap_mem // 0),
      taints: (if .[0].node == \"PendingPods\"
               then \"-\"
               else (\$nodemap[.[0].node].taints // \"-\") end),
      labels: (if .[0].node == \"PendingPods\"
               then (map(.ns + \"/\" + .pod) | unique | join(\",\"))
               else (\$nodemap[.[0].node].labels // \"-\") end)
    })
  | ([\"NODE\",\"PODS\",\"CONTAINERS\",\"CPU_REQ\",\"CPU_LIM\",\"MEM_REQ\",\"MEM_LIM\",\"ALLOC_CPU\",\"ALLOC_MEM\",\"CAP_CPU\",\"CAP_MEM\",\"TAINTS\",\"LABELS\"]),
    (.[] | [.node, (.pods|tostring), (.containers|tostring),
            (.cpu_req|fmt_cpu_m), (.cpu_lim|fmt_cpu_m),
            (.mem_req|fmt_mem_mi), (.mem_lim|fmt_mem_mi),
            (.alloc_cpu|fmt_cpu_m), (.alloc_mem|fmt_mem_mi),
            (.cap_cpu|fmt_cpu_m), (.cap_mem|fmt_mem_mi),
            .taints, .labels])
  | @tsv" "$TMPDIR/pods.json" | print_table "2,3,4,5,6,7,8,9,10,11" |
      sed -E '
/^PendingPods/ s/^(PendingPods(\s+\S+){6}\s+)(\S+\s+){5}/\1/
s/ +$//
'

echo
echo "### Cluster total ###"
jq -r --slurpfile nodes "$TMPDIR/nodes.json" "
$JQ_CONV
([\$nodes[0].items[] | {
    alloc_cpu: (.status.allocatable.cpu | cpu_to_m),
    alloc_mem: (.status.allocatable.memory | mem_to_b),
    cap_cpu:   (.status.capacity.cpu | cpu_to_m),
    cap_mem:   (.status.capacity.memory | mem_to_b)
  }]) as \$nodetotals
| [(if .kind == \"List\" or .kind == \"PodList\" then .items else [.] end)[]
    | .metadata.name as \$pod
    | .spec.containers[]
    | {
        pod: \$pod,
        cpu_req: (.resources.requests.cpu | cpu_to_m),
        cpu_lim: (.resources.limits.cpu | cpu_to_m),
        mem_req: (.resources.requests.memory | mem_to_b),
        mem_lim: (.resources.limits.memory | mem_to_b)
      }] as \$c
| {
    pods: (\$c | map(.pod) | unique | length),
    containers: (\$c | length),
    cpu_req: (\$c | map(.cpu_req) | add),
    cpu_lim: (\$c | map(.cpu_lim) | add),
    mem_req: (\$c | map(.mem_req) | add),
    mem_lim: (\$c | map(.mem_lim) | add),
    alloc_cpu: (\$nodetotals | map(.alloc_cpu) | add),
    alloc_mem: (\$nodetotals | map(.alloc_mem) | add),
    cap_cpu:   (\$nodetotals | map(.cap_cpu) | add),
    cap_mem:   (\$nodetotals | map(.cap_mem) | add)
  }
| ([\"PODS\",\"CONTAINERS\",\"CPU_REQ\",\"CPU_LIM\",\"MEM_REQ\",\"MEM_LIM\",\"ALLOC_CPU\",\"ALLOC_MEM\",\"CAP_CPU\",\"CAP_MEM\"]),
  ([(.pods|tostring), (.containers|tostring),
    (.cpu_req|fmt_cpu_m), (.cpu_lim|fmt_cpu_m),
    (.mem_req|fmt_mem_mi), (.mem_lim|fmt_mem_mi),
    (.alloc_cpu|fmt_cpu_m), (.alloc_mem|fmt_mem_mi),
    (.cap_cpu|fmt_cpu_m), (.cap_mem|fmt_mem_mi)])
| @tsv" "$TMPDIR/pods.json" | print_table "1,2,3,4,5,6,7,8,9,10"



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
