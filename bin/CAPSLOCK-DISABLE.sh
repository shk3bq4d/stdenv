#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -x
xdotool key Caps_Lock  # toggles caps lock (not disable) by issuing the capslock key when on X
xdotool keyup Shift_L Shift_R Control_L Control_R \
    Alt_L Alt_R Super_L Super_R Meta_L Meta_R \
    Hyper_L Hyper_R ISO_Level3_Shift

setleds -D -caps 2>/dev/null                        # when on console
true
