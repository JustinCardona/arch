git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
cd ~
yay -S polybar 

clear
PS3='Do you want additional packages?'
select choice in yes no
do
    break
done

if [ "$choice" = "yes" ]
then
    sudo pacman -S flameshot code gimp shotcut blender discord firefox 
    yay -S bitwarden oreo-cursors-git numix-icon-theme-git vertex-themes
    git clone https://github.com/simonesestito/dark-arch-sddm
    cd dark-arch-sddm
    ./install.sh
fi
