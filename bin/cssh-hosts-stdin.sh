#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" && -d "$_tempdir" ]] && rm -rf $_tempdir || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

hosts-stdin.sh > $_tempdir/a
if [[ $# -eq 0 ]]; then
    mv $_tempdir/a $_tempdir/b
else
    ! grep "$@" $_tempdir/a > $_tempdir/b && cat $_tempdir/a && echo "FATAL: can't find $@ in tempdir/a" && exit 1
fi

cat $_tempdir/b

echo -n "Are you sure you want to proceed (yN): " # read
read _read
echo # read
case "${_read,,}" in \
y|yes) true ;; # read
*)   echo "ABORTING"; cleanup; exit 1;; # read
esac # read

group_name="mygroup"
space=" "
echo -n "${group_name}${space}" >$_tempdir/c

xargs echo < $_tempdir/b >> $_tempdir/c

cat $_tempdir/c

{ sleep 5; mri3_grid_layout.py; } &
{ nohup /usr/bin/clusterssh -c $_tempdir/c $group_name &>/dev/null; } &
sleep 5
cleanup
echo EOF
exit 0
