http://www.datadisk.co.uk/html_docs/redhat/rh_lvm.htm

Physical Volume / Volume Group / Logical Volume

lvdisplay
vgdisplay # display attributes of volume groups
pvcreate # initialize a disk or partition for use by LVM
pvdisplay # display attributes of a physical volume

pvscan
pvs
lvs
vgs


pvcreate /dev/sdb
pvresize -v /dev/sda2
yum install cloud-utils-growpart
growpart -u force /dev/sda 2
pvresize -v /dev/sda2

# 10000 * extend size (4Mb) = 40Gb
lvcreate -l 10000 -n datalv  VolGroup00
lvcreate -l 100   -n lv_data vg_system
mkfs.xfs  /dev/VolGroup00/datalv

lvcreate --size 20G  -n lv_data vg_system
mkfs.ext4 /dev/vg_system/lv_data
sudo mkdir /data && echo "/dev/mapper/vg_system-lv_data /data                    ext4    defaults,noexec        1 2" | sudo tee -a /etc/fstab && sudo mount /data



no, for major FS when extending, yes for shrinking #https://unix.stackexchange.com/questions/58432/must-the-filesystem-be-unmounted-while-extending-an-lvm-logical-volume
sudo pvdisplay | grep -E "PE Size|Free PE"
sudo lvdisplay | grep -E "LV Path|LV Size"
lvresize -l+512 -r /dev/vg_system/lv_opt

CONTAINER_NAME=hehe; docker pause $CONTAINER_NAME && lvresize --size +40G --resizefs /dev/mapper/rootvg-data && docker unpause $CONTAINER_NAME && echo success

lvresize --size +1G   --resizefs /dev/VolGroup00/varlv
lvresize --size -6G   --resizefs /dev/mapper/VG_root-LV_data
lvresize --size +1G   --resizefs /dev/mapper/VG_root-LV_data
lvresize --size +1G   --resizefs /dev/mapper/VG_root-LV_var
lvresize --size +1G   --resizefs /dev/mapper/VG_root-LV_usr
lvresize --size +400M --resizefs /dev/mapper/VG_root-LV_usr
lvresize --size +512M --resizefs /dev/mapper/VG_root-opt
lvresize --size +9G   --resizefs /dev/mapper/VG_root-LV_backup
lvresize --size +5G   --resizefs /dev/mapper/VG_root-opt
lvresize --size +9G   --resizefs /dev/mapper/VG_root_home
lvresize --size +10G   --resizefs /dev/mapper/vgroot-lvhome
#lvresize --size 1200M   --resizefs /dev/mapper/VG_root-LV_home --yes <-- schedules via crontab
lvresize --size +3G   --resizefs /dev/mapper/rootvg-optlv
lvresize --size +1G   --resizefs /dev/mapper/rootvg-data
lvresize --size +20G   --resizefs /dev/mapper/rootvg-varlv
lvresize --size +1G   --resizefs /dev/vg_system/lv_var
lvresize --size +1G   --resizefs /dev/mapper/rootvg-varlv
lvresize --size +1G   --resizefs /dev/mapper/rootvg-varlv
printf "fix\nfix\nquit\n" | parted ---pretend-input-tty /dev/sda print
lvresize --size +20G   --resizefs /dev/mapper/ubuntu--vg-lv_var_lib_docker
lvresize --size 500M  --resizefs /dev/debian-vg/home


lvremove # delete rm
lvremove /dev/mapper/rootvg-blobfuse--cache # delete rm
vgremove # delete rm
vgextend - Add physical volumes to a volume group

lvrename VG_root LV_data LV_backup # move rename mv

# var downsizing
zabbix-maintenance-on.sh
docker stop mariadb
systemctl stop vmtoolsd
systemctl stop vgauthd
systemctl stop nginx
systemctl stop polkit
systemctl stop docker.socket
systemctl stop docker.service
systemctl stop containerd
systemctl stop filebeat
systemctl stop zabbix-agent2
#systemctl stop mdatp; systemctl disable mdatp; mv /etc/audisp/plugins.d/{mdatp.conf,.mdatp.conf-disabled} && service auditd restart;
systemctl stop mdatp
systemctl stop audit2why
systemctl stop postfix
systemctl stop nginx
systemctl stop squid
systemctl stop pcsd
systemctl stop gssproxy
systemctl stop rpcbind.service
systemctl stop rpcbind.socket
systemctl stop corosync
systemctl stop rsyslog
systemctl stop atop
systemctl stop chronyd
service auditd stop;
service crond stop;
systemctl stop hypervkvpd
systemctl stop mde_netfilter.socket
systemctl stop systemd-journald.service
systemctl stop systemd-journald.socket
umount /var/lib/docker # and all mount points that are below /var
umount sunrpc # /var/lib/nfs/rpc_pipefs
lvresize --size 14G --resizefs /dev/mapper/VG_root-LV_var

sudo resize2fs  /dev/mapper/vgname-lvname # ext3, ext4 when forgotten to have lvresize with --resizefs (growpart growfs)
sudo xfs_growfs /mount/point              # xfs       when forgotten to have lvresize with --resizefs (growpart growfs)

# remove PV from VG
vgreduce VG_root /dev/sda3
pvremove /dev/sda3
fdisk /dev/sda # delete partition
partprobe


lvremove /dev/mapper/VG_data-LV_opt
lvremove /dev/mapper/VG_data-LV_var
lvremove /dev/mapper/VG_data-LV_data
lvcreate --size 80G  -n LV_data VG_root
mkfs.ext4 /dev/mapper/VG_root-LV_data
