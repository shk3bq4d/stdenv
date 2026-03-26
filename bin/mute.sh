#!/usr/bin/env bash
xset -b # disable bell
if hash wpctl &>/dev/null; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
fi
if hash amixer &>/dev/null; then
	amixer -q -D pulse sset Master off
fi
