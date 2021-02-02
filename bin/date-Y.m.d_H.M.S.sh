#!/usr/bin/env bash

f=$(basename $0 .sh)
f=${f//date-/}
f=${f//%/}
f=$(sed -r -e 's/([a-zA-Z])/%\1/g' <<<"$f")
date +"$f" "$@"
