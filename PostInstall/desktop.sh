# Installing package manager
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
cd ~
rm -rf yay

# Install desktop and applications
yay -S feh flameshot i3-gaps lxappearance os-prober polybar rofi terminator xorg-xinit

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
