#!/usr/bin/env bash


NAME=$(basename $0 .sh)
NUM=${NAME##awk-print}

stdbuf -o0 awk "{ print \$$NUM }"
