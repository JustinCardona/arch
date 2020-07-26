# User information
clear
read -p "Enter the host name: " host
read -p "Enter your name: " name
read -p "Enter your region: " region
read -p "Enter your zone: " zone

# CPU information
clear
PS3="Select your CPU brand by entering a number: "
select choice in intel amd other
do
    break
done
if [[ "$choice" = "intel" ]]
then
    cpu="intel-ucode"
elif [[ "$choice" = "amd" ]]
then
    cpu="amd-ucode"
else
    cpu=""
fi

#GPU information
clear
PS3="Select your GPU brand by entering a number: "
select choice in nvidia amd other
do
    break
done
if [[ "$choice" = "nvidia" ]]
then
    gpu="nvidia nvidia-utils nvidia-settings"
elif [[ "$choice" = "amd" ]]
then
    gpu="xf86-video-amdgpu mesa"
else
    gpu=""
fi

# Desktop configuration
clear
PS3="Select your install type by entering a number: "
select choice in Full Minimal Nothing
do
    break
done
if [[ "$choice" = "Full" ]]
then
    desktop="xorg sddm plasma-desktop kde-applications firefox"
elif [[ "$choice" = "Minimal" ]]
then
    desktop="xorg xorg-xinit i3-wm i3-status i3-lock bluez bluez-utils dmenu"
else
    desktop=""
fi

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
pacman -S "$desktop" "$cpu" "$gpu" base-devel linux-headers grub efibootmgr sudo nano git networkmanager pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack pulseaudio-lirc pulseaudio-zeroconf

# Grub configuration
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable services
systemctl enable NetworkManager.service
if [[ "$choice" = "Full" ]]
then
    echo "systemctl enable sddm.service"
fi

# User configuration
useradd -mG wheel "$name"
clear
echo "Set a password for your user"
passwd "$name"
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers