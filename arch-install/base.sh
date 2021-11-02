#!/bin/bash
#echo "Connecting to wi-fi..."
#iwctl --passphrase 30566907 station wlan0 connect TP-Link_8F51
#sleep 5s

if [[ ! $(ping -c 2 archlinux.org | grep "2 received") ]]; then
  echo "No internet connectivity, exiting..."
  exit 1
fi

#timedatectl set-ntp true

#echo "Switching keymap to colemak..."
#loadkeys /run/media/usb/arch-install/dotfiles/colemakp.map.gz

#echo "Create partitions"
#sleep 0.5s
#cgdisk /dev/nvme0n1

read -n 1 -p "Where the partitions set correctly? [y/n] > " input
if [[ $input == "n" ]]; then
  echo -e "\nExiting..."
  exit 1
fi

#echo "Formating the /boot partition..."
#mkfs.fat -F32 /dev/sda1
echo "Encrypting the / partition..."
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 cryptlvm
echo "Creating LVM volumes..."
pvcreate /dev/mapper/cryptlvm
vgcreate beryllium /dev/mapper/cryptlvm
lvcreate -L 270G beryllium -n root
lvcreate -l 100%FREE beryllium -n home
mkfs.ext4 /dev/beryllium/root
mkfs.ext4 /dev/beryllium/home
echo "Mounting volumes..."
cryptsetup open /dev/nvme0n1p2 cryptlvm
mount /dev/beryllium/root /mnt
mkdir /mnt/boot && mkdir /mnt/home
mount /dev/nvme0n1p1 /mnt/boot
mount /dev/beryllium/home /mnt/home
if [[ ! $(mount | grep "/dev/nvme0n1p1") ]] || [[ ! $(mount | grep "/dev/mapper/beryllium-root") ]] || [[ ! $(mount | grep "/dev/mapper/beryllium-home") ]]; then
  echo "Something went wrong when mounting the volumes, exiting..."
  exit 1
fi

echo "Installing base system..."
pacstrap /mnt base base-devel linux-lts linux-lts-headers linux-firmware intel-ucode lvm2 vim reflector bash-completion man-db ntfs-3g

echo "Creating a swap file..."
dd if=/dev/zero of=/mnt/swapfile bs=1M count=7629 status=progress
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile

echo "Generating fstab..."
genfstab -pU /mnt >> /mnt/etc/fstab
vim /mnt/etc/fstab

echo "Done"
echo "Please unmount the usb, and chroot into the new system"
