#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 12 Jun 2021
##

set -euo pipefail
umask 027

mount | grep -vwE 'docker|tmpfs|cgroup|snapd|proc|/run/user|sysfs|udev|devpts|securityfs|pstore|efivarfs|/dev/hugepages|/dev/mqueue|on /sys|type fuse.vagrant'
