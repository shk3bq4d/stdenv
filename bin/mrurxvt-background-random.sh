#!/usr/bin/env bash


DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/mrurxvt-colors
randomcolor

#echo $_MRCOLOR

printf '\033]11;rgb:%s/%s/%s\007' ${_MRCOLOR:0:2} ${_MRCOLOR:2:2} ${_MRCOLOR:4:2}
date >> /tmp/mrurxvt-background-random.log
