# Installing package manager
cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si PKGBUILD

# Install desktop and applications
paru bitwarden brave-bin breeze-default-cursor-theme breeze-gtk discord feh flameshot lxappearance numlockx qtile xorg-xinit xterm

