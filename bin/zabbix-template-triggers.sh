#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ TEMPLATE
## dumps the triggers of the passed ZABBIX TEMPLATE
##
## Author: Jeff Malone, 10 Feb 2023
##

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 1 || $# -gt 1 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" ]]  && [[ -d "$_tempdir" ]]  && rm -rf "$_tempdir"  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

f="$1"
! test -f "$f" && echo "FATAL: not a file $f" && exit 1

if [[ $f == *.yml.j2 ]]; then
    g=$_tempdir/bip.yaml
    ansible-jinja-cli.sh $f > $g
    f="$g"
fi

cat << 'EOF' | python3 - $f
# ```python
import sys
import yaml
from pprint import pprint

def print_triggers(oH, key, title):
    iA = oH.get(key, [])
    if len(iA) > 0:
        if title: print(title)
        for iH in iA:
        #   pprint(iH)
            iH['expression'] = ' '.join(iH['expression'].splitlines())
            print("{name:<80s} {expression}".format(**iH))


# arg 0 is "-"
# arg 1 is $f
with open(sys.argv[1], 'rb') as f:
    yH = yaml.safe_load(f)
yH = yH.get('zabbix_export', yH)
print_triggers(yH, "triggers", "")
tA = yH.get('templates', [])
tH = tA[0]
print_triggers(tH, "triggers", "")
iA = tH.get('items', [])
for iH in iA:
    print_triggers(iH, "triggers", "")


dA = tH.get('discovery_rules', [])
for dH in dA:
#   pprint(dH)
    print_triggers(dH, "trigger_prototypes", "\n=== disco {key} {name}".format(**dH))


# ```
EOF



cleanup
exit 0
