#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

volumes() {
    for b in "$@"; do
        #echo -n " -v $(realpath "$b"):$tmp_path/$b"
        echo -n " -v $(realpath "$b"):$(realpath "$b")"
    done
}

args() {
    for b in "$@"; do
        #echo -n " $tmp_path/$b"
        echo -n " $(realpath "$b")"
    done
}

docker ps &>/dev/null && SUDO="" || SUDO=sudo

if [[ $# -eq 0 ]]; then
    $SUDO docker run -i --rm -v $PWD:/code eeacms/jshint
elif [[ $1 == -* ]]; then
    $SUDO docker run -i --rm eeacms/jshint /usr/bin/jshint "$@"
else
    $SUDO docker run -i --rm $(volumes "$@") --entrypoint="" eeacms/jshint jshint --verbose $(args "$@")
    #$SUDO docker run -it --rm $(volumes "$@") --entrypoint="" eeacms/jshint cat $(args "$@")
fi

echo "No errors"
exit 0
