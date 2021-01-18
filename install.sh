# Preparation
clear
pacman -Syyy
timedatectl set-ntp true
# Disk Preparation
disks=$(lsblk -p -n -l -o NAME -e 7,11)
PS3='Enter the number of device name you want to install to: '
select dev in ${disks}
do
    break
done
wipefs -a "$dev"
printf "g\nn\n\n\n+256M\nt\n1\nn\n\n\n\nw\n" | fdisk "$dev"
efip=`lsblk $dev -p -n -l -o NAME -e 7,11 | sed -n 2p`
rootp=`lsblk $dev -p -n -l -o NAME -e 7,11 | sed -n 3p`
mkfs.fat -F32 "$efip"
mkfs.ext4 "$rootp"
mount "$rootp" /mnt
mkdir /mnt/boot
mount "$efip" /mnt/boot

# Installation
pacstrap /mnt base base-devel efibootmgr git grub linux linux-firmware linux-headers networkmanager pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack pulseaudio-lirc pulseaudio-zeroconf sudo vim xorg
genfstab -U /mnt >> /mnt/etc/fstab
curl -L JustinCardona.github.io/setup.sh > setup.sh
mv setup.sh /mnt
arch-chroot /mnt sh setup.sh
rm /mnt/setup.sh
# umount -a
# reboot
