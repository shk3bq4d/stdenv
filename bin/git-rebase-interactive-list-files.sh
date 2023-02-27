#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

#rebase.instructionFormat
_tempfile=$(mktemp);   function cleanup() { [[ -n "${_tempfile:-}" ]] && [[ -f "$_tempfile" ]] && rm  -f "$_tempfile" || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

cat << 'EOF' >"$_tempfile"
#!/usr/bin/env bash

echo "in $PWD, my args are $@"
EOF

chmod u+x "$_tempfile"

#git rebase -i --exec "$_tempfile" "$@"
git -c rebase.instructionFormat='%Cred%h%Creset -%C(auto)%d%Creset %f %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' rebase -i "$@"


cleanup
exit 0
