```sh
export DEV=/dev/nvme0n1
ls -l $DEV
ot disk 259, 0 Nov  4  2020 /dev/nvme0n1
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
vgcreate ubuntu-vg /dev/mapper/${DM}5_cryp
lvcreate -L 16G -n swap_1 ubuntu-vg
lvcreate -L 20G -n root ubuntu-vg
```
