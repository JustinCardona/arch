git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
paru -S ufw xorg pulseaudio chromium code jdk discord lutris
sudo systemctl enable ufw.service
