# when booted in single user, remount root file system as writable
// https://github.com/gautamkrishnar/tcso/blob/master/javascript/tcso.js
mount -uw /

# ntpd keep time
sudo service ntpd onestart

# change system date
date $(date -v+2m "+%Y%m%d%H%M.%S") # adds two months to sytemdate

# relative date
date -v+1y # one year from now
date -v-1y # one year ago


# vnc desktop i3
# crontab
SHELL=/usr/local/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:$HOME/bin

@reboot /home/myuser/bin/mrvncserver
* * * * * pgrep ^Xvnc$ || /home/myuser/bin/mrvncserver
#bin/mrvncserver
#!/usr/bin/env bash

/usr/local/bin/vncserver -geometry 3840x2160 -fp /usr/local/lib/X11/fonts/misc/,/usr/local/lib/X11/fonts/100dpi/ 2>&1 | tee -a /tmp/reboot.mr.log
# .vnc/xstartup
touch /tmp/home_myuser_.vnc_xstartup
/usr/local/bin/i3 &>> /tmp/mri3_startup.log &


pkg info -D zoneminder
pkg update -f

/usr/libexec/locate.updatedb # mlocate updatedb


# upgrade jails problem
https://dan.langille.org/2015/01/18/failure-with-freebsd-update-how-not-to-upgrade-your-systems/


/usr/libexec/locate.updatedb

# exec as another user
su -m www -c 'sh -c "whoami"'

pw usermod tom -G ftpusers,wwwusers # add user tom to secondary groups ftpusers and wwwusers

# 10.3 to 12 upgrade
https://www.cyberciti.biz/open-source/freebsd-12-released-here-is-how-to-upgrade-freebsd/
$ freebsd-version
10.3-RELEASE-p10
$ uname -mrs
FreeBSD 10.3-RELEASE-p7 amd64
