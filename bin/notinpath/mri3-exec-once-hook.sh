#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ 
##to be startup by ~/.config/i3/config
##
## Author: Jeff Malone, 22 Oct 2017
##

touch ~/.tmp/touch/mri3-exec-once-hook.start

xrdb -merge ~/.Xdefaults

touch ~/.tmp/touch/mri3-exec-once-hook.end
