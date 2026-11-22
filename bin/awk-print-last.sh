#!/usr/bin/env bash

stdbuf -o0 awk '{print $NF}'
