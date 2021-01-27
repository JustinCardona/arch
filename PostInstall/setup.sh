# Installing package manager
cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si PKGBUILD
cd ~
rm -rf paru
# Install desktop and applications
paru bitwarden brave-bin discord feh flameshot numlockx qtile xorg-xinit xterm

# Deploy configs
git clone https://github.com/JustinCardona/JustinCardona.github.io.git
cd JustinCardona.github.io/PostInstall/
sh deployConfig.sh
