sudo pacman -Syyy
sudo pacman -S reflector
sudo reflector -c Canada -a 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyy

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
cd ~

sudo pacman -S xorg-xinit i3-wm i3lock dmenu rofi terminator firefox feh ttf-font-awesome ttf-ubuntu-font-family xorg-fonts-misc picom materia-gtk-theme papirus-icon-theme lxappearance discord flameshot code gimp shotcut blender lutris jdk-openjdk texlive-core dotnet-runtime dotnet-sdk
yay -S polybar siji-git bitwarden
echo "use the recomended config file from the repository"