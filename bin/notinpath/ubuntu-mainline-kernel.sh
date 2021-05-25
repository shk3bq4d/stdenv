#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euxo pipefail

#_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" && -d "$_tempdir" ]] && rm -rf $_tempdir || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
_tempdir=~/tmp/kernel-$(date +'%s')
mkdir $_tempdir

# https://kernel.ubuntu.com/~kernel-ppa/mainline/
URL=https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11.13/amd64/
URL=https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12-rc8/amd64/
URL=https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.12/amd64/
URL=https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11.16/amd64/

cd $_tempdir
curl -s $URL |
    grep -Po '(?<=href=")[^"]+\.deb' |
    grep -v lowlatency |
    xargs -I@ -trn1 wget ${URL}@

ls -lh
set -x
sudo dpkg -i *.deb
set +x


#cleanup
echo EOF
exit 0
