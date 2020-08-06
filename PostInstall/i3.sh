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
    sudo pacman -S flameshot code gimp shotcut blender lutris discord firefox openssh
    yay -S bitdefender
    systemctl enable ssh
    systemctl start ssh
fi