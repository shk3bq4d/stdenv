#!/usr/bin/env bash


sed -r -e 's/^[0-9:, \-]+//' $@
