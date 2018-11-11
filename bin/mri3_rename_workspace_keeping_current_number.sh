#!/usr/bin/env bash



set -x
prefix="$(mri3_current_workspace.py  | sed -r -e 's/^(.....\S+ ).*/\1/')"
postfix="   "
i3 rename workspace to "\"${prefix}$@${postfix}\""

