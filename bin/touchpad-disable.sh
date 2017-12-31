#!/usr/bin/env bash

xinput list | sed -r -n -e '/ouch.ad/s/.*id=([0-9]+).*/\1/ p' | xargs --no-run-if-empty xinput --disable
