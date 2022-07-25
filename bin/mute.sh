#!/usr/bin/env bash
env | grep -iE 'display|PULSE_RUNTIME_PATH'
whoami
amixer -q -D pulse sset Master off
