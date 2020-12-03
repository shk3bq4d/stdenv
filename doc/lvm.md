http://www.datadisk.co.uk/html_docs/redhat/rh_lvm.htm

Physical Volume / Volume Group / Logical Volume

lvdisplay
vgdisplay # display attributes of volume groups
pvcreate # initialize a disk or partition for use by LVM
pvdisplay # display attributes of a physical volume

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

lvresize --size +1G --resizefs /dev/VolGroup00/varlv
lvresize --size +1G --resizefs /dev/mapper/VG_root-LV_usr
lvresize --size +5G --resizefs /dev/mapper/VG_root-opt
lvresize --size +1G --resizefs /dev/vg_system/lv_var
printf "fix\nfix\nquit\n" | parted ---pretend-input-tty /dev/sda print


vgremove
