#!/usr/bin/env bash
if hash wpctl &>/dev/null; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
fi
if hash amixer &>/dev/null; then
	amixer -q -D pulse sset Master on
fi
