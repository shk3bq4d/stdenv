#!/usr/bin/env bash
# ex: set filetype=sh :

find -maxdepth 1 -type f -print0 | shuf --random-source=/dev/urandom  -zn 1 | xargs -0 basename
