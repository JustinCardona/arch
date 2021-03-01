# User information
host="aorus"
name="justin"
region="Canada"
zone="Eastern"

# Host configuration
ln -sf /usr/share/zoneinfo/"$region"/"$zone" /etc/localtime
hwclock --systohc --utc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "$host" > /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$host.localdomain\t$host"> /etc/hosts

# Install packages
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman -Syyy

# CPU configuration
if [ cat /proc/cpuinfo | grep -c "intel" ]
then
    sudo pacman -S --noconfirm intel-ucode
elif [ cat /proc/cpuinfo | grep -c "amd" ]
then
    sudo pacman -S --noconfirm amd-ucode
fi

# GPU configuration
if [ `lspci -vnn | grep -c "NVIDIA"` -ge 1 ]
then
    sudo pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings

elif [ `lspci -vnn | grep -c "AMD"` -ge 1 ]
then
    pacman -S xf86-video-amdgpu mesa lib32-mesa
fi

# Grub configuration
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable services
systemctl enable NetworkManager.service
systemctl enable iptables.service
systemctl enable sshd.service
systemctl enable sshd.socket
systemctl enable systemd-timesyncd.service

# User configuration
useradd -mG wheel "$name"
clear
echo "Set a password for your user"
passwd "$name"
clear
echo "Set a password for the root user (admin)"
passwd
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers
