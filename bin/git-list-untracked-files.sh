#!/usr/bin/env bash
# ex: set filetype=sh :

git ls-files --others --exclude-standard "$@"
