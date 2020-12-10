cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD
sudo pacman -S flameshot nautilus code gimp shotcut blender discord firefox
yay -S oreo-cursors-git numix-icon-theme-git vertex-themes chili-sddm-theme bitwarden vlc xournal
read -p "Change the current SDDM theme to chili. Afterwards go to lxappearance to change system themes."
sudo vim /usr/lib/sddm/sddm.conf.d/sddm.conf
cp -a PostInstall ~/.config
cd /etc
sudo git clone https://github.com/ChrisTitusTech/firewallsetup.git
cd firewallsetup
chmod +x firewall
./firewall
