#!/usr/bin/env bash



set -x
prefix="$(i3_current_workspace.py  | sed -r -e 's/^(......).*/\1/')"
postfix="   "
i3 rename workspace to "\"${prefix}$@${postfix}\""

