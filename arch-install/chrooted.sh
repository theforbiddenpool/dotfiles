#!/bin/bash
echo "Setting timezone..."
ln -sf /usr/share/zoneinfo/Europe/Lisbon > /etc/localtime
hwclock --systohc

echo "Setting the keymap..."
mkdir -p /usr/local/share/kbd/keymaps
cp /run/media/usb/arch-install/dotfiles/colemakp.map.gz /usr/local/share/kbd/keymaps
loadkeys /usr/share/kbd/keymaps/colemakp.map.gz
echo KEYMAP=/usr/local/share/kbd/keymaps/colemakp.map.gz >> /etc/vconsole.conf

echo "Setting the locale..."
sleep 0.5s
vim /etc/locale.gen
locale-gen
echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US\nLC_ADDRESS=pt_PT.UTF-8\nLC_COLLATE=en_US.UTF-8\nLC_CTYPE=en_US.UTF-8\nLC_MEASUREMENT=pt_PT.UTF-8\nLC_PAPER=pt_PT.UTF-8\nLC_TELEPHONE=pt_PT.UTF-8\nLC_TIME=en_US.UTF-8\nLC_MONETARY=en_US.UTF-8\nLC_NUMERIC=en_US.UTF-8\nLC_ALL=" >> /etc/locale.conf

echo "Setting hostname..."
echo "ursidae" >> /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tursidae.localdomain\tursidae" >> /etc/hosts

echo "Edit pacman.conf"
sleep 0.5s
vim /etc/pacman.conf
echo "Generating optimized mirrorlist..."
reflector --verbose --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo "Updating system..."
pacman -Syu

echo "Set root password"
sleep 0.5s
passwd
echo "Creating new user..."
useradd -m -g users -G wheel,storage,optical,disk -s /bin/bash maritimus
passwd user
echo "Edit visudo"
sleep 0.5s
visudo

echo "Installing systemd-boot..."
bootctl install
echo -e "timeout 0\ndefault arch\neditor no" >> /boot/loader/loader.conf
echo -e "title Arch Linux\nlinux /vmlinuz-linux-lts\ninitrd /intel-ucode.img\ninitrd /initramfs-linux-lts.img\noptions cryptdevice=UUID=$(blkid -s UUID -o value /dev/nvme0n1p2):cryptlvm root=/dev/thallium/root rw" >> /boot/loader/entries/arch.conf
mkdir /etc/pacman.d/hooks
echo -e "[Trigger]\nType = Package\nOperation = Upgrade\nTarget = systemd\n\n[Action]\nDescription = Updating systemd-boot\nWhen = PostTransaction\nExec = /usr/bin/bootctl update" >> /etc/pacman.d/hooks/systemd-boot.hook
echo "Edit mkinitcpio.conf"
sleep 0.5s
echo "HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)" >> /etc/mkinitcpio.conf
vim /etc/mkinitcpio.conf
mkinitcpio -P

echo "Installing graphics card's drivers & NetworkManager..."
pacman -Sy mesa lib32-mesa xf86-video-ati mesa-vdpau lib32-mesa-vdpau networkmanager
echo "Setting custom DNS servers..."
echo -e "[global-dns-domain-*]\nservers=1.1.1.1,1.0.0.1,2606:4700:4700::1111,2606:4700:4700::1001" >> /etc/NetworkManager/conf.d/dns-servers.conf

echo "Enabling fstrim & NetworkManager services..."
systemctl enable fstrim.timer
systemctl enable NetworkManager

echo "Done"
echo "Please exit, unmount /mnt and reboot"
