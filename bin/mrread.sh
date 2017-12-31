#!/usr/bin/env bash

set -e
read "$@" bip </dev/tty
echo -n "$bip"
