git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
cd ~
yay -S polybar siji-git

clear
PS3='Do you want additional packages?'
select choice in yes no
do
    break
done

if [ "$choice" = "yes" ]
then
    sudo pacman -S flameshot code gimp shotcut blender lutris discord firefox
    yay -S bitdefender
    git clone https://github.com/simonesestito/dark-arch-sddm
    cd dark-arch-sddm
    ./install.sh
fi