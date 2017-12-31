#!/usr/bin/env bash

sed -r -n -e '/^\s*[^#]/ p' "$@"
