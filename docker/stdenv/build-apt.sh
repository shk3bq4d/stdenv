#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

c="$( echo "${BASH_SOURCE[0]}" | sed -r -e 's,.*/build-([^/]+)\.sh,\1,')"
echo $c


docker ps &>/dev/null && SUDO="" || SUDO="sudo";
for i in "$c"; do
	cd $DIR/$i
	t=shk3bq4d/stdenv:$i
	$SUDO docker build -t $t .
done

echo EOF
exit 0

