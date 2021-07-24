#!/bin/bash

echo "\n[options]\nParallelDownloads = 8" >> /etc/pacman.conf
pacman -Syy reflector
reflector -c Bangladesh --save /etc/pacman.d/mirrorlist
ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "archlinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archlinux" >> /etc/hosts
echo root:password | chpasswd

# install package
pacman -S grub efibootmgr networkmanager network-manager-applet dialog mtools dosfstools base-devel linux-headers inetutils dnsutils bash-completion openssh rsync os-prober nano netctl sudo dhcpcd mesa neofetch wget man git amd-ucode linux-lts linux-lts-headers avahi

# install grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# enable service
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable fstrim.timer
# systemctl enable libvirtd
# systemctl enable firewalld
# systemctl enable acpid

useradd -m idbmdran
echo idbmdran:password | chpasswd
usermod -aG idbmdran

echo "idbmdran ALL=(ALL) ALL" >> /etc/sudoers.d/idbmdran

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

