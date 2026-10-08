#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
###
##Usage:  __SCRIPT__ IMAGE
## runs docker image with entrypoint removed and starting as sh
##
## Author: Jeff Malone, 26 Sep 2026
##

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';


function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }
[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

 [[ $# -lt 1 || $# -gt 1 ]] && >&2 echo "FATAL: incorrect number of args" && usage && exit 1

docker ps &>/dev/null && SUDO= || SUDO=sudo

#if [[ $bash -eq 1 ]]; then
#	$SUDO docker run "$@" -h $H --name $H -v ~/tmp:/tmpp -v $STDHOME_DIRNAME:/tmp/sshrc/:ro -it $N /bin/bash --rcfile /tmp/sshrc/.sshrc
#else
#	$SUDO docker run "$@" -h $H --name $H -v ~/tmp:/tmpp                                    -it $N /bin/sh
#fi

IMAGE="$1"
NAME="$(echo "$IMAGE" | sed -r -e 's#[:/]+#-#g')"
NAME="${NAME:0:64}"

$SUDO docker pull "$IMAGE"

if \
$SUDO \
    docker \
        run \
        --rm \
        --entrypoint="" \
        --name "if-bash-${NAME}" \
        $IMAGE \
            /bin/bash --version \
        &>/dev/null; then

    $SUDO \
        docker \
            run \
            --rm \
            -it \
            --entrypoint="" \
            --name "${NAME}" \
            --user 0 \
            -h "$NAME" \
            -v ~/tmp:/tmpp \
            -v $STDHOME_DIRNAME:/tmp/sshrc/:ro \
            $IMAGE \
                /bin/bash --rcfile /tmp/sshrc/.sshrc

else

    $SUDO \
        docker \
            run \
            --rm \
            -it \
            --entrypoint="" \
            --name "${NAME}" \
            --user 0 \
            -h "$NAME" \
            -v ~/tmp:/tmpp \
            $IMAGE \
                /bin/sh

fi

echo EOF
exit 0
