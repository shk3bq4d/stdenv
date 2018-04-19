write access to / (example: /etc/hosts)
x10:
mount -o rw,remount -t yaffs2 /dev/block/mtdblock3 /system
motog:
mount -o rw,remount -t ext4   /dev/block/platform/msm_sdcc.1/by-name/system /system

hosts
wget http://support.it-mate.co.uk/downloads/hphosts.zip
7z x phosts.zip
ssh root@x10
# password is "admin"
#mount -o rw,remount -t yaffs2 /dev/block/mtdblock3 /system
mount -o remount,rw -t yaffs2 `grep /system /proc/mounts | cut -d' ' -f1` /system
exit



script touch file system read only
#save /system mount rw vs ro status    
c=$(grep /system /proc/mounts | cut -d' ' -f4 | cut -d',' -f1)
[[ "${c}" != "rw" ]] && mount -o remount,rw -t yaffs2 $(grep /system /proc/mounts | cut -d' ' -f1) /system
# do your business
# restores /system mount rw vs ro status
[[ "${c}" != "rw" ]] && mount -o remount,ro -t yaffs2 $(grep /system /proc/mounts | cut -d' ' -f1) /system


am start -a android.intent.action.SENDTO -d sms:+41774552829 --es sms_body "xxx " --ez exit_on_sent true; input keyevent 66;




#sshserver
install sshdroid

#crontab android 

# >= 3.0
mount -o remount,rw -t rootfs / /
# <= 2.3
mount -o remount,rw -t yaffs2 `grep /system /proc/mounts | cut -d' ' -f1` /system
cat - > /etc/init.d/99mr
# enable crond
# crond calls getpwnam (user database search)
mount -o remount,rw -t yaffs2 `grep /system /proc/mounts | cut -d' ' -f1` /system
echo "root:x:0:0::/data/cron:/system/bin/bash" > /etc/passwd
mount -o remount,ro -t yaffs2 `grep /system /proc/mounts | cut -d' ' -f1` /system
# crond has "/bin/sh" hardcoded
mount -o remount,rw rootfs /
ln -s /system/bin/ /bin
mount -o remount,ro rootfs /
# set timezone
TZ=PST8PDT
export TZ
# use /data/cron, call the crontab file "root"
crond -c /data/cron
C-D
chown root:shell /etc/init.d/99mr
chmod 0750 /etc/init.d/99mr
mkdir /data/cron
cat - >/data/cron/root

#* * * * * touch /data/cron/.touch

# backup files from internal storage to sd
* * * * * /data/me/bin/bkup2sd.sh >/data/cron/bkup2sd.log 2>&1

# restore hosts file possibly modified by apps that detect blocking of apps
* * * * * [[ /etc/hosts -nt /etc/hosts.txt ]] && /data/me/bin/hosts.sh >/data/cron/hosts.log 2>&1

*/10 * * * * pgrep dropbear ||  /data/me/bin/mrsshd.sh >/data/cron/mrsshd.log 2>&1

#reload it's configuration
0 12 * * * crond -c /data/cron
C-D
cat - >/data/me/bin/mrsshd.sh
/data/data/berserker.android.apps.sshdroid/dropbear/dropbear -H /data/data/berserker.android.apps.sshdroid/home -s -p 10.19.29.34:22 -r /data/data/berserker.android.apps.sshdroid/dropbear/dropbear.key.rsa -d /data/data/berserker.android.apps.sshdroid/dropbear/dropbear.key.dss -U -a -m
chmod 0777 /data/me/bin/mrsshd.sh


#vibrator
echo 100 >  /sys/devices/virtual/timed_output/vibrator/enable

# change dpi
mount -o remount,rw -t ext4 /system
vi /system/build.prop
# edit ro.sf.lcd_density=180 between 180 and 320, 180 increases the number of objects drawn on screen (thus objects are smaller)


# enable developer mode (likely cyanogenmod only)
Launch the Settings Application
Scroll Down and Tap on About Phone(or About Device)
Locate the Build Number Section
Tap on the Build Number Option 7 Times
Go Back to the Main Settings Page
Scroll Down and Tap on Developer Options
# enable root through developer options on cyanogenmod

# decompile apk jar dex2jar
http://stackoverflow.com/questions/5257830/how-to-use-dextojar/19954951#19954951
Download dex2jar https://code.google.com/p/dex2jar/downloads/list
Run dex2jar on apk d2j-dex2jar.sh someApk.apk
open jar file in JD GUI http://jd.benow.ca/

FCM: fMMpukO7WmA:APA91bGhod_3f4h4mRj7ueRgDD6i-S701FCkcQ5Wk_RrU55fTcQTQxNAQqM91ADDjei6o_5Oj05UV8CvCj7HOWBf5GExo0yWpZ-j_14kHPMCOmi_euaablRxSjgF-73c-5AAmLOnGVkK
https://console.firebase.google.com/project/mrr0-30688/settings/general/

tablette samsung rose: port 22 /mnt/sdcard/extStorages/SdCard/movies
tablette motorola: port 2222 /sdcard/Movies/
