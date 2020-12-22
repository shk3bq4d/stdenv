#!/usr/bin/env bash
set -euo pipefail

cd -P "$( dirname "${BASH_SOURCE[0]}" )"

[[ $# -eq 1 ]] && HOST="$1" || HOST="${HOSTNAME}"

PREFIX="stdhome-templating-"
FILENAME=$(basename $0 .sh)
FILENAME=${FILENAME:${#PREFIX}}
if [[ -z $FILENAME ]]; then
	echo "FATAL: executing ~/bin/notinpath/ instead of symlink ?"
	exit 1
fi

#sed -n -r -e '/^export /s/^export (\\w+)/hehe\1/ p' ${FILENAME}.${HOST} ${FILENAME}.default
F="${FILENAME}.default"
source "$F"
FILES="$F"
F="${FILENAME}.${HOST}"
if [[ -e $F ]]; then
	source "$F"
	FILES="$FILES $F"
fi


VARS="\$STDHOME_GENERATED_TIME $(sed -n -r -e '/^export /s/^export ([^=]+).*/$\1 / p' $FILES | tr -d '\n')"

export STDHOME_GENERATED_TIME="Auto generated file from $(basename $0) on $(date). DO NOT EDIT"
#echo "VARS is $VARS"
if [[ -h ${FILENAME} ]]; then
	rm -f ${FILENAME}
elif [[ -f ${FILENAME} ]]; then
	chmod u+w ${FILENAME}
fi
cat ${FILENAME}.template | envsubst "$VARS" > ${FILENAME}
chmod a-w ${FILENAME}
case ${FILENAME} in \
.Xdefaults)
	hash xrdb 2>/dev/null && xrdb -merge ~/.Xdefaults
	;;
esac
#diff ${FILENAME}.template ${FILENAME}
