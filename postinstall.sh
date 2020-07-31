# Window Tiling
git clone https://github.com/kwin-scripts/kwin-tiling.git
cd kwin-tiling/
plasmapkg2 --type kwinscript -i .
cd ~

# yay for AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
cd ~

# Basic packages
sudo pacman -S code discord firefox gimp shotcut blender lutris
yay -S bitwarden

