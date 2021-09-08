git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
paru -S ufw xorg pulseaudio i3 network-manager-applet picom feh terminator firefox flameshot dmenu
sudo systemctl enable ufw.service
