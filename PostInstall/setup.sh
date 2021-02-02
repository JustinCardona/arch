# Installing package manager
#cd ~
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si PKGBUILD
#cd ~
#rm -rf paru

# Install desktop and applications
paru -S alacritty breeze-default-cursor-theme breeze-gtk feh flameshot i3-gaps lxappearance numlockx pulseaudio rofi xorg xorg-fonts-misc xorg-xinit

# Configuration
cp -r config/. ~
cp i3 ~/.config
cp polybar ~/.config
cp scripts ~/.config

