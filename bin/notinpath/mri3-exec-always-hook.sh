#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 11 Jan 2019
##

touch ~/.tmp/touch/mri3-exec-always-hook.start

grep -Po '(?<=^new_window\s).+' ~/.config/i3/config > ~/.tmp/i3-new_window_border
~/bin/compton-background.sh

touch ~/.tmp/touch/mri3-exec-always-hook.end
