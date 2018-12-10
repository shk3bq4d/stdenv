zfs list
zfs list -t all
zfs list mrpool/myfs@month.05
zfs list -t snapshot -o name,creation
zfs list -t snapshot -o name | grep $(df . | tail -1 | awk '{ print $1 }') # snapshot current working directory cwd pwd filesystem fs
zfs snapshot filesystem@snapname
zfs rollback filesystem@snapname # revert restore
zfs rollback zroot/ezjail/jmadsonic@2017-05-25_01.00.00--7d # revert restore 
zfs rollback zroot/ezjail/jmadsonic@2017-05-25_01.00.00--7d -r # revert intermediate snapshosts
cd myfs/.zfs/snapshot/day.24

# http://www.freebsddiary.org/zfs-with-gpart.php
$ zpool create -f storage ada1 #disk2, disk3, disk4 => pool
zfs create -p storage/ezjail # dataset
zfs destroy storage/ezjail
zfs destroy -r storage/ezjail # recursive
zpool status

------------------------------------------------
with jail sharing filesystem
# zfs create -o mountpoint=/usr/ports tank/FreeBSD/ports
# mount -t nullfs -o ro /usr/ports /jail/myjail/usr/ports
You can add that line to, for example /etc/fstab.myjail:
Code:
/usr/ports                      /jail/myjail/usr/ports                nullfs  ro      0       0
And in /etc/rc.conf:
jail_myjail_mount_enable="YES"
Then it'll be automatically mounted/unmounted when the jail starts/stops. 

sudo zfs create             zroot/mr/jsabnzbd_data
sudo mkdir                                          /usr/jails/jsabnzbd-0-7-20/jsabnzbd_data
sudo mount -t nullfs -o rw /zroot/mr/jsabnzbd_data/ /usr/jails/jsabnzbd-0-7-20/jsabnzbd_data
echo                       /zroot/mr/jsabnzbd_data/ /usr/jails/jsabnzbd-0-7-20/jsabnzbd_data nullfs rw 0 0 | sudo tee -a /etc/fstab.jsabnzbd_0_7_20
in jail
pw groupadd -q -n jsabnzbd_data
pw usermod -n mruser -G "$(groups mruser) jsabnzbd_data"
chgrp jsabnzbd_data /jsabnzbd_data/
chmod g+w /jsabnzbd_data/
zfs set aclinherit=passthrough zroot/mr/jsabnzbd_data
------------------------------------------------

administer zfs dataset from inside jails
HOST:
export DATASET=zroot/mr/jailed_sandbox
export JAILID=138
export JAILNAME=jsandboxzfs
export JAILMOUNTPOINT=/usr/jails/${JAILNAME}/mnt/$(basename $DATASET)
echo "$DATASET $JAILMOUNTPOINT zfs rw 0 0" | sudo tee -a /etc/fstab.$JAILNAME
sudo mkdir -p $JAILMOUNTPOINT
sudo zfs create $DATASET
sudo zfs jail $JAILID $DATASET
sudo jail -m jid=$JAILID allow.mount allow.mount.zfs enforce_statfs=1
sudo sysctl vfs.usermount=1
sudo zfs unjail $JAILID $DATASET
jail_restart.sh $JAILNAME


sudo zfs get casesensitivity /usr/jails/jly200
sudo zfs get 2>&1 | grep -E 'PROPERTY|case'
	PROPERTY       EDIT  INHERIT   VALUES
		casesensitivity  NO      YES   sensitive | insensitive | mixed

sudo zfs set casesensitivity=insensitive zroot/ezjail/jly200
cannot set property for 'zroot/ezjail/jly200': 'casesensitivity' is readonly
sudo zfs rename zroot/ezjail/jly200{,-renamed}

zfs create -V 256G -p zroot/mrvol/ly80lvmr0
zfs get volsize,reservation zroot/mrvol/ly80lvmr0
zfs set volsize=1t zroot/mrvol/ly80lvmr0
growfs -N zroot/mrvol/ly80lvmr0


zfs destroy data/emea/bcv.ch/f5_hsv2000v@zfs-auto-snap_daily-2018-04-17-0000,zfs-auto-snap_daily-2018-04-18-0000%zfs-auto-snap_daily-2018-04-19-0000,zfs-auto-snap_daily-2018-04-20-0000%zfs-auto-snap_daily-2018-04-21-0000,zfs-auto-snap_daily-2018-04-22-0000%zfs-auto-snap_daily-2018-04-23-0000 # delete snapshot
zfs destroy filesystem|volume@snap[%snap[,snap[%snap]]]... # delete snapshot

zfs list -t snapshot -o name | grep $(df . | tail -1 | awk '{ print $1 }') | xargs -prn1 zfs destroy 

zfs get all data/global/mayerbrown.com/chinwsa001.mayerbrown.com


# dedup
zpool list
NAME   SIZE  ALLOC   FREE  EXPANDSZ   FRAG    CAP  DEDUP  HEALTH  ALTROOT
data   583G   271G   311G         -    34%    46%  1.00x  ONLINE  -

zfs get dedup data
NAME      PROPERTY  VALUE          SOURCE
datapool  dedup     on             local
$ zfs get dedup datapool/emea
NAME           PROPERTY  VALUE          SOURCE
datapool/emea  dedup     on             inherited from datapool
zfs get dedup data/global/mayerbrown.com/chinwsa001.mayerbrown.com
NAME                                                  PROPERTY  VALUE          SOURCE
data/global/mayerbrown.com/chinwsa001.mayerbrown.com  dedup     on             inherited from data

zpool get dedupratio data

https://constantin.glez.de/2011/07/27/zfs-to-dedupe-or-not-dedupe/

https://brismuth.com/scheduling-automated-zfs-scrubs-9b2b452e08a4

# add disk as read cache
geom disk list
zpool add zroot cache /dev/vtbd6
zpool iostat -v zroot 5 # livestat

