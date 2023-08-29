https://www.digitalocean.com/community/tutorials/how-to-set-up-time-synchronization-on-ubuntu-16-04
timedatectl set-ntp no
timedatectl set-ntp on
timedatectl
timedatectl show
timedatectl status
timedatectl timesync-status
timedatectl show-timesync | sed -r -e 's/,/\n/g'
timedatectl show-timesync | sed -r -n -e 's/NTPMessage=// p' -e 's/,/\n/g p'
sudo service ntp stop
sudo ntpd -gq
sudo service ntp start
sudo chronyc tracking # centos
sudo chronyc sources  # centos

# timedatectl
  status                   Show current time settings
  show                     Show properties of systemd-timedated
  set-time TIME            Set system time
  set-timezone ZONE        Set system time zone
  list-timezones           Show known time zones
  set-local-rtc BOOL       Control whether RTC is in local time
  set-ntp BOOL             Enable or disable network time synchronization

ssh -t myhost sudo date -us @$(date -u +%s) # set remote system time easily


/etc/systemd/timesyncd.conf
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.
#
# Entries in this file show the compile time defaults.
# You can change settings by editing this file.
# Defaults can be restored by simply deleting this file.
#
# See timesyncd.conf(5) for details.

[Time]
#NTP=
#FallbackNTP=ntp.ubuntu.com
#NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
NTP=6.1.0.50
FallbackNTP=ntp.ubuntu.com


```sh
chronyc> sources -v

210 Number of sources = 2

  .-- Source mode  '^' = server, '=' = peer, '#' = local clock.
 / .- Source state '*' = current synced, '+' = combined , '-' = not combined,
| /   '?' = unreachable, 'x' = time may be in error, '~' = time too variable.
||                                                 .- xxxx [ yyyy ] +/- zzzz
||      Reachability register (octal) -.           |  xxxx = adjusted offset,
||      Log2(Polling interval) --.      |          |  yyyy = measured offset,
||                                \     |          |  zzzz = estimated error.
||                                 |    |           \
MS Name/IP address         Stratum Poll Reach LastRx Last sample
===============================================================================
^? ueaobutnb01.bip.habon.lo>     1   6    77    61   -27.3s[ -27.3s] +/-  10.9s
^? uaeoutnnb02.bip.habon.lo>     2   6    77    63   -27.3s[ -27.3s] +/-  11.0s
```
