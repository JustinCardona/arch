# User information
clear
read -p "Enter the host name: " host
read -p "Enter your name: " name
read -p "Enter your region: " region
read -p "Enter your zone: " zone

# Host configuration
ln -sf /usr/share/zoneinfo/"$region"/"$zone" /etc/localtime
hwclock --systohc --utc
echo "LANG=en_US.UTF-8" > /etc/locale.gen
locale-gen
echo "en_US.UTF-8" > /etc/locale.conf
echo "$host" > /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$host.localdomain	$host"> /etc/hosts
clear
echo "Set a password for the root user (admin)"
passwd

# Install packages
pacman -S base-devel linux-headers grub efibootmgr  intel-ucode nvidia nvidia-utils nvidia-settings sudo nano git networkmanager pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack pulseaudio-lirc pulseaudio-zeroconf xorg sddm plasma-meta kde-applications code nautilus firefox

# Grub configuration
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable services
systemctl enable NetworkManager.service
systemctl enable sddm.service

# User configuration
useradd -mG wheel "$name"
clear
echo "Set a password for your user"
passwd "$name"
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers