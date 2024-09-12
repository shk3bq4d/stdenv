#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
###
##Usage:  __SCRIPT__ VAR_RX TARGET_HOSTS
##dumps all variables from TARGET_HOSTS that match VAR_RX
##
## Author: Jeff Malone, 12 sep 2024
##
function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 2 || $# -gt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp --tmpdir=$PWD);   function cleanup() { [[ -n ${_tempfile:-} ]] && [[ -f $_tempfile ]] && rm  -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

cat << 'EOF' > $_tempfile
# ```yaml
- hosts: all
  connection: local
  gather_facts: no
  vars:

    colon:               ":"
    var_rx:              ""
    nb_hosts:            "{{  ansible_play_batch | length }}"
    max_nb_hosts:        30
    hv:                  "{{ hostvars[inventory_hostname] }}"
    hv_keys:             "{{ hv.keys() }}"
    filtered_hv_keys:    "{{ hv_keys | select('search', var_rx) }}"
    nb_filtered_hv_keys: "{{ filtered_hv_keys | length }}"
    max_vars:            30


  tasks:
    - name: aborts when too large
      assert:
        quiet: yes
        that:
          - var_rx | string | length > 0
          - nb_hosts | int            <= max_nb_hosts | int
          - nb_filtered_hv_keys | int <= max_vars | int

    - debug:
        msg: |
          host {{ inventory_hostname }}
          has {{ hv_keys | length }} vars and after filtering {{ filtered_hv_keys | length }}

    - debug:
        var: hv | dict2items | selectattr('key', 'in', filtered_hv_keys) | items2dict

# ```
EOF

ansible-playbook $_tempfile -D -e var_rx="$1" -l "$2"

echo EOF
exit 0
