https://www.howtoforge.com/using-iscsi-on-ubuntu-10.04-initiator-and-target

sudo iscsiadm -m discovery -d 6 -P 6 -t st -p charlotte
sudo iscsiadm -m node --targetname "iqn.2014-06.ch.ly1:ly80lvmr0" --portal "10.19.29.221:3260" --login

iscsiadm --mode node --targetname iqn.2014-06.ch.ly1:ly80lvmr0 --portal 10.19.29.221:3260 --login

# charlotte
iscsiadm -m discovery -d 6 -P 6 -t st -p charlotte
service iscsictl restart
/etc/ctl.conf
# https://www.freebsd.org/doc/handbook/network-iscsi.html

# centos
https://www.freebsd.org/doc/handbook/network-iscsi.html
$ yum install iscsi-initiator-utils
$ iscsiadm -m discovery -t sendtargets -p charlotte
[charlotte]:3260,-1 iqn.2014-06.ch.ly1:ly80lvmr0
[charlotte]:3260,-1 iqn.2017-11.ch.ly1:centoshomedocker
$ iscsiadm -m node -T iqn.2017-11.ch.ly1:centoshomedocker --login
Logging in to [iface: default, target: iqn.2017-11.ch.ly1:centoshomedocker, portal: charlotte,3260] (multiple)
Login to [iface: default, target: iqn.2017-11.ch.ly1:centoshomedocker, portal: charlotte,3260] successful.
$ grep "Attached SCSI" /var/log/messages
Nov  5 10:16:17 centoshome kernel: sd 2:0:0:0: [sda] Attached SCSI disk
$ mkfs.btrfs /dev/sda
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
Performing full device TRIM /dev/sda (1.00TiB) ...
Label:              (null)
UUID:               65f1f1fd-4528-400d-8d0e-d66d4ef9193b
Node size:          16384
Sector size:        4096
Filesystem size:    1.00TiB
Block group profiles:
  Data:             single            8.00MiB
    Metadata:         single            8.00MiB
	  System:           single            4.00MiB
	  SSD detected:       yes
	  Incompat features:  extref, skinny-metadata
	  Number of devices:  1
	  Devices:
	     ID        SIZE  PATH
		     1     1.00TiB  /dev/sda
$ blkid /dev/sda
/dev/sda: UUID="65f1f1fd-4528-400d-8d0e-d66d4ef9193b" UUID_SUB="4361395b-58d6-420f-9e20-62af3ee9d9f6" TYPE="btrfs"
$ echo 'UUID="65f1f1fd-4528-400d-8d0e-d66d4ef9193b" /var/lib/docker btrfs _netdev 0 0' >> /etc/fstab

