#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" ]] && [[ -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

cat << 'EOF' >$_tempfile
#```python

import sys
import yaml
from pprint import pprint
rH = yaml.safe_load(sys.stdin)

def process(foH):
    for key, value in foH['data'].items():
        print("\n==== {}".format(key))
        print(value)


if rH is None:
    pass
elif rH['kind'] == 'List':
    for eH in rH['items']:
        print("\n>>>> {namespace}-{name}".format(**eH['metadata']))
        process(eH)
else:
    process(rH)



#```
EOF

kubectl get configmap \
    -o yaml \
    "$@" | python3 $_tempfile
