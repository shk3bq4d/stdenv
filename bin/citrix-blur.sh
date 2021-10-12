#!/usr/bin/env bash
xdotool search --onlyvisible urxvt 2>/dev/null | head -n 1 | xargs -rn1 xdotool windowfocus --sync
