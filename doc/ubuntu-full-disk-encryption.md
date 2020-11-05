# https://help.ubuntu.com/community/Full_Disk_Encryption_Howto_2019
```sh
sudo -i
export DEV=/dev/nvme0n1
export DM="${DEV##*/}"
export DEVP="${DEV}$( if [[ "$DEV" =~ "nvme" ]]; then echo "p"; fi )"
export DM="${DM}$( if [[ "$DM" =~ "nvme" ]]; then echo "p"; fi )"
sgdisk --zap-all $DEV
sgdisk --new=1:0:+768M $DEV
sgdisk --new=2:0:+2M $DEV
sgdisk --new=3:0:+128M $DEV
sgdisk --new=5:0:0 $DEV
sgdisk --typecode=1:8301 --typecode=2:ef02 --typecode=3:ef00 --typecode=5:8301 $DEV
sgdisk --change-name=1:/boot --change-name=2:GRUB --change-name=3:EFI-SP --change-name=5:rootfs $DEV
sgdisk --hybrid 1:2:3 $DEV
sgdisk --print $DEV
cryptsetup luksFormat --type=luks1 ${DEVP}1
cryptsetup luksFormat ${DEVP}5
cryptsetup open ${DEVP}1 LUKS_BOOT
cryptsetup open ${DEVP}5 ${DM}5_crypt
ls /dev/mapper/
mkfs.ext4 -L boot /dev/mapper/LUKS_BOOT
mkfs.vfat -F 16 -n EFI-SP ${DEVP}3
pvcreate /dev/mapper/${DM}5_crypt
vgcreate ubuntu-vg /dev/mapper/${DM}5_crypt
lvcreate -L 16G -n swap_1 ubuntu-vg
lvcreate -L 20G -n root ubuntu-vg
# start installation, as soon as completed local user account run
echo "GRUB_ENABLE_CRYPTODISK=y" >> /target/etc/default/grub
# let installation complete, but do not reboot
mount /dev/mapper/ubuntu--vg-root /target # was already mounted on ubuntu 20.04.1 installer
for n in proc sys dev etc/resolv.conf; do mount --rbind /$n /target/$n; done
chroot /target
apt install -y cryptsetup-initramfs
echo "KEYFILE_PATTERN=/etc/luks/*.keyfile" >> /etc/cryptsetup-initramfs/conf-hook
echo "UMASK=0077" >> /etc/initramfs-tools/initramfs.conf
mkdir /etc/luks
dd if=/dev/urandom of=/etc/luks/boot_os.keyfile bs=4096 count=1
chmod u=rx,go-rwx /etc/luks
chmod u=r,go-rwx /etc/luks/boot_os.keyfile
cryptsetup luksAddKey ${DEVP}1 /etc/luks/boot_os.keyfile
cryptsetup luksAddKey ${DEVP}5 /etc/luks/boot_os.keyfile
echo "LUKS_BOOT UUID=$(blkid -s UUID -o value ${DEVP}1) /etc/luks/boot_os.keyfile luks,discard" >> /etc/crypttab
echo "${DM}5_crypt UUID=$(blkid -s UUID -o value ${DEVP}5) /etc/luks/boot_os.keyfile luks,discard" >> /etc/crypttab
# https://askubuntu.com/questions/232656/how-to-change-keyboard-layout-for-startup-passphrase-prompt
echo "KEYMAP=Y" | tee -a /etc/initramfs-tools/initramfs.conf
update-initramfs -u -k all
#update-initramfs -u
```

