# User Information
lsblk
read -p "Enter the device name you want to install to: " device
dev="/dev/$device"

# Synchronization
pacman -Syyy
timedatectl set-ntp true

# Disk preparation
wipefs -a "$dev"
printf "g\nn\n\n\n+256M\nt\n1\nn\n\n\n\nw\n" | sudo fdisk "$dev"
mkfs.fat -F32 "$dev"1
mkfs.ext4 "$dev"2
mkdir /mnt/boot
mount "$dev"1 /mnt/boot
mount "$dev"2 /mnt

# Install Linux
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
