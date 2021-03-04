# Preparation
pacman -Syyy
timedatectl set-ntp true
packages="base base-devel git grub linux linux-firmware linux-headers networkmanager sudo vim"

# User and Device Information
disks=$(lsblk -p -n -l -o NAME -e 7,11)
clear
lsblk
PS3='Enter the number of device name you want to install to: '
select dev in ${disks}
do
    break
done

boot_state=`ls /sys/firmware | grep -c "efi"`
cpu_state=`cat /proc/cpuinfo | grep -c "intel"`
gpu_state=`lspci -vnn | grep -c "NVIDIA"`

# Disk Preparation
wipefs -a "$dev"
if [ $boot_state -gt 0 ]
then
	printf "g\nn\n\n\n+256M\nt\n1\nn\n\n\n\nw\n" | fdisk "$dev"
	efip=`lsblk $dev -p -n -l -o NAME -e 7,11 | sed -n 2p`
	rootp=`lsblk $dev -p -n -l -o NAME -e 7,11 | sed -n 3p`
	mkfs.fat -F32 "$efip"
	mkfs.ext4 "$rootp"
	mount "$rootp" /mnt
	mkdir /mnt/boot
	mount "$efip" /mnt/boot
	packages="${packages} efibootmgr"
else
	printf "n\n\n\n\n\nw\n" | fidsk "$dev"
	rootp=`lsblk $dev -p -n -l -o NAME -e 7,11 | sed -n 2p`
	mkfs.ext4 "$rootp"
	mount "$rootp" /mnt
fi

# CPU and GPU configuration
if [ $cpu_state -gt 0 ]
then
	packages="${packages} intel-ucode"
else
	packages="${packages} amd-ucode"
fi

if [ $gpu_state -gt 0 ]
then
	packages="${packages} nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings"
else
	packages="${packages} xf86-video-amdgpu mesa lib32-mesa"
fi

# Install packages
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacstrap /mnt $packages

# Generate File system table
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot
chroot_func()
{
	# User information
	clear
	read -p "Enter the host name: " host
	clear
	read -p "Enter the user name: " name
	clear
	read -p "Enter the region: " region
	clear
	read -p "Enter the zone: " zone

	# Host configuration
	ln -sf /usr/share/zoneinfo/"$region"/"$zone" /etc/localtime
	hwclock --systohc --utc
	echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
	locale-gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	echo "$host" > /etc/hostname
	echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$host.localdomain\t$host"> /etc/hosts

	# Grub configuration
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg

	# Enable services
	systemctl enable NetworkManager.service
	systemctl enable iptables.service
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
}
export -f chroot_func
chroot /mnt /bin/bash -c "chroot_func"
#umount -a
#reboot


