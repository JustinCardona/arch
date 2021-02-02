# Installing package manager
#cd ~
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si PKGBUILD
#cd ~
#rm -rf paru

# Install desktop and applications
paru -S alacritty breeze-default-cursor-theme breeze-gtk feh flameshot lxappearance numlockx pulseaudio xorg xorg-fonts-misc xorg-xinit

# Configuration
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -n -e :a -e '1,5!{P;N;D;};N;ba'
echo "exec i3" >> ~/.xinitrc
cp /etc/i3/config ~/.config/i3/
