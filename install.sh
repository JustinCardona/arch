# Preparation
pacman -Syyy
timedatectl set-ntp true

# Disk Preparation
disks=$(lsblk -p -n -l -o NAME -e 7,11)
clear
lsblk
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

# Install packages
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman -Syyy
packages="base base-devel efibootmgr git grub linux linux-firmware linux-headers networkmanager sudo vim"

# CPU configuration
if [ cat /proc/cpuinfo | grep -c "intel" ]
then
    packages="${packages} intel-ucode"
elif [ cat /proc/cpuinfo | grep -c "amd" ]
then
    packages="${packages} amd-ucode"
fi

# GPU configuration
if [ `lspci -vnn | grep -c "NVIDIA"` -ge 1 ]
then
    packages="${packages} nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings"

elif [ `lspci -vnn | grep -c "AMD"` -ge 1 ]
then
     packages="${packages} xf86-video-amdgpu mesa lib32-mesa"
fi

pacstrap /mnt $packages

# Generate File system table
genfstab -U /mnt >> /mnt/etc/fstab

#Chroot
curl -L JustinCardona.github.io/chroot.sh > chroot.sh
mv chroot.sh /mnt
arch-chroot /mnt sh chroot.sh
rm /mnt/chroot.sh
umount -a
reboot
