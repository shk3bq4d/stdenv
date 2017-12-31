#!/usr/bin/env bash

set -e
cd ~/bin/
NAME=setup-x86_64.exe
wget -N https://cygwin.com/$NAME
chmod u+x $NAME
./$NAME
