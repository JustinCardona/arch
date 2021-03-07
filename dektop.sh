# Install aur package manager
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Install packages for desktop environment
yay -S i3-gaps polybar rofi
