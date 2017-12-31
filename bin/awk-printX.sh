#!/usr/bin/env bash


NAME=$(basename $0 .sh)
NUM=${NAME##awk-print}

awk "{ print \$$NUM }"
