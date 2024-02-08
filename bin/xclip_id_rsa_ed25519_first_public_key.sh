#!/usr/bin/env bash

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

for i in ed25519 rsa; do
	if [[ -f ~/.ssh/id_$i.pub ]]; then
		xclip < ~/.ssh/id_$i.pub
		exit 0
	fi
done
exit 1
