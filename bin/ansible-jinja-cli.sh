#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ TEMPLATE
##    TEMPLATE: the template to evaluate
##
## Author: Jeff Malone, 02 Dec 2022
##
# 2023.01.19 I am not why I was copying the template to $_tempdir/in, will try to stick to $1 as it breaks template_fullpath
# 2023.03.10 ok, now I know, it's because of macros.j2, well I guess we can't have both template_fullpath and macros.j2 for the time being

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 1 || $# -gt 1 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

! test -f "$1" && echo "FATAL: not a file $1" && exit 1

[[ -t 1 ]] && export ANSIBLE_FORCE_COLOR=true

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" ]]  && [[ -d "$_tempdir" ]]  && rm -rf "$_tempdir"  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
fp="$(realpath "$1")"
if grep -q macros.j2 $fp; then
    cp "$fp" "$_tempdir/in"
    f=~/git/sf/dcn/iaac-master/ans/roles/sf-zabbix-template/templates/macros.j2
    test -f $f && cp "$f" "$_tempdir"
    in="$_tempdir/in"
else
    in="$fp"
fi

ev=$_tempdir/extra-vars.yml
if [[ $fp == *zabbix/templates* ]]; then
    yq '.[0].vars' "$(basename $fp .j2)" > $ev || echo "" >$ev
else
    echo "_nothing:" >$ev
fi


#if ! ansible all -i "localhost," -m template -a "src='$_tempdir/in' dest=$_tempdir/out" --connection=local \
if ! ansible all -i "localhost," -m template -a "src='$in' dest=$_tempdir/out" --connection=local \
    -e @$ev \
    -e @~/git/sf/dcn/iaac-master/ans/group_vars/all.yml \
    -e zabbix_version=6.2.5 \
    -e group_template_uuid=abcd \
    -e _template_uuid=abcd \
    -e template_name=ansible-jinja-cli \
    -e kube_filebeat_namespace=filebeat \
    -e kube_filebeat_app_name=filebeat \
    -e sf_environment=uat \
    -e kube_filebeat_hosts='["hehe"]' \
    &>$_tempdir/err; then
    cat $_tempdir/err
    exit 1
fi

cat $_tempdir/out

exit 0
