#!/usr/bin/env bash

set -x
git commit -m "auto $(basename $0)" "$@" && git push origin master
