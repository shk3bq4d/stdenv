# when booted in single user, remount root file system as writable
// https://github.com/gautamkrishnar/tcso/blob/master/javascript/tcso.js
mount -uw /

# ntpd keep time
sudo service ntpd onestart



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

/usr/libexec/locate.updatedb # mlocate updatedb


# upgrade jails problem
https://dan.langille.org/2015/01/18/failure-with-freebsd-update-how-not-to-upgrade-your-systems/


/usr/libexec/locate.updatedb

# exec as another user
su -m www -c 'sh -c "whoami"'
