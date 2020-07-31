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
pacman -S base-devel linux-headers grub efibootmgr sudo nano git networkmanager pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack pulseaudio-lirc pulseaudio-zeroconf xorg 
read -p "Include multilib"
nano /etc/pacman.conf
pacman -Syyy

# CPU configuration
PS3='Choose your CPU by entering a number: '
select processor in intel amd other
do
    break
done
if [ "$processor" = "intel" ]
then
    sudo pacman -S intel-ucode
elif [ "$processor" = "amd" ]
then
    sudo pacman -S amd-ucode
fi

# GPU configuration
PS3='Choose your GPU by entering a number: '
select graphics in nvidia amd other
do
    break
done
if [ "$graphics" = "nvidia" ]
then
    sudo pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
elif [ "$graphics" = "amd" ]
then
    sudo pacman -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
fi

# Desktop configuration
PS3='Choose your Desktop Environment by entering a number: '
select desktop in full minimal other
do
    break
done
if [ "$desktop" = "full" ]
then
    sudo pacman -S sddm plasma-meta kde-applications code nautilus firefox
elif [ "$desktop" = "minimal" ]
then
    sudo pacman -S xorg-xinit i3-wm i3lock i3status dmenu terminator
fi

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
