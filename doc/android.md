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
```sh

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
```


# enable developer mode (likely cyanogenmod only)
Launch the Settings Application
Scroll Down and Tap on About Phone(or About Device)
Locate the Build Number Section
Tap on the Build Number Option 7 Times
Go Back to the Main Settings Page
Scroll Down and Tap on Developer Options
# enable root through developer options on cyanogenmod

Setting>About>Software>Build Number and Tap on the build number repeatedly so that the Developer mode will turn on. # enable developer mode Android 9

https://www.techdroidtips.com/unlock-bootloader-huawei-p-smart-2019/

# decompile apk jar dex2jar
http://stackoverflow.com/questions/5257830/how-to-use-dextojar/19954951#19954951
Download dex2jar https://code.google.com/p/dex2jar/downloads/list
Run dex2jar on apk d2j-dex2jar.sh someApk.apk
open jar file in JD GUI http://jd.benow.ca/

FCM: fMMpukO7WmA:APA91bGhod_3f4h4mRj7ueRgDD6i-S701FCkcQ5Wk_RrU55fTcQTQxNAQqM91ADDjei6o_5Oj05UV8CvCj7HOWBf5GExo0yWpZ-j_14kHPMCOmi_euaablRxSjgF-73c-5AAmLOnGVkK
https://console.firebase.google.com/project/mrr0-30688/settings/general/

galaxy a3 2016
SM-A310F
https://wiki.lineageos.org/devices/a3xelte/#supported-models
https://wiki.lineageos.org/devices/a3xelte/install/


tablette samsung rose: ssh galaxytab port 22 /mnt/sdcard/extStorages/SdCard/movies
rsync -e 'sshpass -f~/.words/galaxytab ssh' -vrtD --no-xattrs --no-chmod --no-owner --stats --human-readable --progress *mp4 galaxytab:/mnt/sdcard/extStorages/SdCard/movies/sisters/
watch -n 120 'rsync -e "sshpass -f~/.words/galaxytab ssh" -vrtD --no-xattrs --no-chmod --no-owner --stats --human-readable --progress *mp4 galaxytab:/mnt/sdcard/extStorages/SdCard/movies/sisters/'
tablette motorola xoom: port 2222 /sdcard/Movies/
sshpass -f~/.words/motog /usr/bin/ssh motog mkdir /sdcard/Music/$i/
rsync -avr -e "sshpass -f~/.words/motog /usr/bin/ssh" --copy-links --delete $DIR/$i/. motog:/sdcard/Music/$i/.

natel telephone isabelle galaxy-a3:/sdcard/Music
natel telephone marc motog:/sdcard/Music


# sdcard Isabelle
## dmesg
[  +0.434781] mmc0: error -110 whilst initialising SD card
[Feb 1 02:14] usb 1-1: new high-speed USB device number 7 using xhci_hcd
[  +0.148373] usb 1-1: New USB device found, idVendor=aaaa, idProduct=8816
[  +0.000007] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000004] usb 1-1: Product: MXT USB Device
[  +0.000004] usb 1-1: Manufacturer: MXTronics
[  +0.000003] usb 1-1: SerialNumber: 130818v01
[  +0.000930] usb-storage 1-1:1.0: USB Mass Storage device detected
[  +0.000367] scsi host0: usb-storage 1-1:1.0
[  +1.018841] scsi 0:0:0:0: Direct-Access     MXT-USB  Storage Device   1308 PQ: 0 ANSI: 0 CCS
[  +0.001048] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  +0.000404] sd 0:0:0:0: [sda] 31342592 512-byte logical blocks: (16.0 GB/14.9 GiB)
[  +0.000141] sd 0:0:0:0: [sda] Write Protect is off
[  +0.000005] sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
[  +0.000141] sd 0:0:0:0: [sda] No Caching mode page found
[  +0.000010] sd 0:0:0:0: [sda] Assuming drive cache: write through
[  +0.002383]  sda: sda1
[  +0.001285] sd 0:0:0:0: [sda] Attached SCSI removable disk
## fdisk
 ~  sudo fdisk /dev/sda                12:36:41  33"660

Welcome to fdisk (util-linux 2.31.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/sda: 15 GiB, 16047407104 bytes, 31342592 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device     Boot Start      End  Sectors Size Id Type
/dev/sda1        8192 31342591 31334400  15G  c W95 FAT32 (LBA)

Command (m for help):

# adb
adb devices
adb connect TA93005EKM
adb shell
adb push lineage-16.0-20190422-UNOFFICIAL-falcon\ \(1\).zip /sdcard/
adb push open_gapps-arm-9.0-pico-20180820-UNOFFICIAL.zip /sdcard/

https://github.com/opengapps/opengapps/wiki/Advanced-Features-and-Options
/sdcard # cat .gapps-config
Include
Search


https://android.com/find # ring search find lost devices

# xiaomi
IMEI1: 8604 7904 4786 916
IMEI2: 8604 7904 5136 913
SN: 22848/49XS01974
COO 32GB
https://download.lineageos.org/lavender # not exists yet
https://www.lineageoslog.com/17.1/lavender
https://forum.xda-developers.com/redmi-note-7/development/rom-lineageos-16-t3968501
https://www.cyanogenmods.org/forums/topic/download-lineageos-17-redmi-note-7/
https://files.orangefox.download/OrangeFox-Stable/lavender/
https://forum.xda-developers.com/showpost.php?p=76885728&postcount=3
https://status.lineageos.org/

