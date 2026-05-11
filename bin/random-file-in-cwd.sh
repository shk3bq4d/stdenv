#!/usr/bin/env bash
# ex: set filetype=sh :

find -maxdepth 1 -\( -not -type d -\) -print0 | shuf --random-source=/dev/urandom  -zn 1 | xargs -0 basename
