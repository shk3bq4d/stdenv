#!/usr/bin/env bash
if hash wpctl &>/dev/null; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
else
	amixer -q -D pulse sset Master on
fi
