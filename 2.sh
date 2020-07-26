read -p "Enter the host name: " host
read -p "Enter your name: " name
read -p "Enter your region: " region
read -p "Enter your zone: " zone
read -p "Enter your cpu brand (intel or amd): " cpu
# Host configuration
ln -sf /usr/share/zoneinfo/"$region"/"$zone" /etc/localtime
hwclock --systohc --utc
echo "LANG=en_US.UTF-8" > /etc/locale.gen
locale-gen
echo "en_US.UTF-8" > /etc/locale.conf
echo "$host" > /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$host.localdomain	$host"> /etc/hosts
passwd

# Drivers and development packackes
pacman -S "$cpu"-ucode nvidia nvidia-utils nvidia-settings base-devel linux-headers

# Grub configuration
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Install packages
pacman -S sudo nano git xorg sddm plasma-desktop kde-applications networkmanager

# Enable services
systemctl enable NetworkManager.service
systemctl enable sddm.service

# User configuration
useradd -mG wheel "$name"
passwd "$name"
EDITOR=nano visudo

echo "Type 'exit' then 'umount -a' then 'reboot' then install yay"