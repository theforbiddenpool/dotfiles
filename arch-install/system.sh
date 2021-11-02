#!/bin/bash
#echo "Connecting to the wi-fi..."
#nmcli device wifi connect TP-Link_8F51 password 30566907

#if [[ ! $(ping -c 2 archlinux.org | grep "2 received" ) ]]; then
#  echo "No internet connectivity, exiting..."
#  exit 1
#fi

#echo "Installing packages..."
#pacman -Sy xorg-server xorg-apps xorg-xinit lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan pulseaudio pulseaudio-alsa a52dec faac faad2 libdca libdv libmad libmpeg2 wavpack adobe-source-sans-pro-fonts ttf-anonymous-pro ttf-dejavu ttf-liberation ttf-ubuntu-font-family ttf-font-awesome ttf-sazanami ttf-lato ttf-roboto ttf-hannom ttf-fira-code ttf-opensans noto-fonts-emoji ttf-baekmuk noto-fonts i3-gaps dolphin firefox gedit chrony gst-libav gst-plugins-good mlocate tree zip unrar rsync p7zip pkgfile hplip cups rofi playerctl picom scrot xclip feh pavucontrol dunst network-manager-applet zsh breeze-icons breeze arc-gtk-theme lxappearance qt5ct papirus-icon-theme kvantum-qt5 gnome-keyring libsecret seahorse v4l-utils bluez bluez-utils openssh nomacs inkscape spectacle libreoffice-fresh okular vlc qbittorrent obs-studio steam audacious calibre speedcrunch discord gimp telegram-desktop signal-desktop go nodejs yarn npm git mariadb chromium postgresql openvpn libinput
#sleep 5s
#echo "Change MAKEFLAGS"
#sleep 0.5s
#vim /etc/makepkg.conf

#echo "Edit lightdm.conf"
#sleep 0.5s
#vim /etc/lightdm/lightdm.conf
#vim /etc/lightdm/lightdm-webkit2-greeter.conf

#echo "Adding custom keyboard..."
#cat /run/media/usb/arch-install/dotfiles/colemak-xkb >> /usr/share/X11/xkb/symbols/us
#sleep 0.5s
#vim /usr/share/X11/xkb/rules/base.lst
#vim /usr/share/X11/xkb/rules/base.xml
#vim /usr/share/X11/xkb/rules/evdev.xml
#cp /run/media/usb/arch-install/dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d/

#echo "Adding aliases..."
#echo -e "if [ -f /etc/bash_aliases ] ; then\n\t. /etc/bash_aliases\nfi\n\nshopt -s autocd\nsource /usr/share/doc/pkgfile/command-not-found.bash" >> /etc/bash.bashrc
#echo -e "alias ls='ls --color=auto'\nalias grep='grep --color=auto'\nalias dir='dir --color=auto'\n\nalias ll='ls -lF'\nalias lh='ls -lshF'\nalias lha='ls -lshaF'\nalias lla='ls -laF'\n\nalias clr='clear'\nalias hst='history'\nalias vi='vim'\n\nalias suspend='systemctl suspend'\nalias i3reload='i3-msg \"restart\" && polybar-msg cmd restart'" > /etc/bash_aliases

echo "Adding environment variables..."
echo -e "export VISUAL=vim\nexport PATH=\$PATH:\$HOME/bin:\$(yarn global bin)\nexport SSH_AUTH_SOCK=\"\$XDG_RUNTIME_DIR/ssh-agent.socket\"\nexport GPG_TTY=\$(tty)\n\neval \"\$(direnv hook bash)\"" >> /home/maritimus/.bashrc
#echo "QT_QPA_PLATFORMTHERME=qt5ct" >> /etc/environment

#echo "Updating pkgfile repos..."
#pkgfile -u

#echo "Removing any orphan packages..."
#pacman -Rns $(pacman -Qtdq)

#echo "Enabling chrony..."
#systemctl enable chrony
#vim 

#echo "Setting webcam settings..."
#echo "SUBSYSTEM==\"video4linux\", KERNEL==\"video[0-9]*\", ATTRS{product}==\"C922 Pro Stream Webcam\", ATTRS{serial}==\"5E1AD71F\", RUN+=\"/usr/bin/v4l2-ctl -d \$devnode -v width=1920,height=1080,pixelformat=MJPG -p 30\"" > /etc/udev/rules.d/99-logitech-c922-defaults.rules

echo "Creating ssh-agent service..."
mkdir -p /home/maritimus/.config/systemd/user/
echo -e "[Unit]\nDescription = SSH key agent\n\n[Service]\nType = simple\nEnvironment = SSH_AUTH_SOCK=%t/ssh-agent.socket\nExecStart = /usr/bin/ssh-agent -D -a \$SSH_AUTH_SOCK\n\n[Install]\nWantedBy = default.target" > /home/maritimus/.config/systemd/user/ssh-agent.service

echo "Done"
echo "Please reboot into the graphical system"
