# Installing package manager
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
cd ~
rm -rf yay

# Install desktop and applications
yay -S bitwarden-cli bluez bluez-utils brave-bin breeze-default-cursor-theme breeze-gtk-theme discord feh flameshot gimp i3-gaps lxappearance os-prober picom polybar rofi terminator pulseaudio xorg xorg-xinit 

# Configuration
git clone https://github.com/JustinCardona/JustinCardona.github.io.git
cd JustinCardona.github.io/PostInstall
cp -r config/. ~
cp -r i3 ~/.config/
cp -r polybar ~/.config/
cp -r scripts ~/.config/
cd ~
rm -rf JustinCardona.github.io
chmod +x ~/.config/polybar/launch.sh

# Grub
os-prober
grub-mkconfig

# Enable bluetooth
sudo systemctl enable bluetooth.service

# Start window manager
startx
