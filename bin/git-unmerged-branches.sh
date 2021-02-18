#!/usr/bin/env bash

set -euo pipefail
umask 027
git branch -a --sort=-committerdate --no-merged origin/master "$@"
