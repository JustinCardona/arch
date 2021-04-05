# Install aur package manager
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Install packages for desktop environment
yay -S brave plasma-meta kde-applications-meta

# Enable Services
systemctl enable sddm.service
