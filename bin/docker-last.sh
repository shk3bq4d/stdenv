#!/usr/bin/env bash

#                                          this last grep ensure exit code > 0 if empty match
docker ps --format="{{.ID}}" | head -n 1 | grep -E .
