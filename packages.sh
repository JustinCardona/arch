# Installing package manager
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD

# Menu to choose what to Install
clear
PS3='Choose what to configure: '
select config in desktop development applications
do
    break
done

# Extra Applications
sudo yay -S --noconfirm nautilus gimp shotcut blender xournal spotify

# Configs
cd ~/JustinCardona.github.io
cp -a PostInstall/. ~/.config

# Desktop configuration
sudo yay -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader xorg-fonts-misc sddm i3-wm lxappearance texlive-core dmenu rofi terminator feh polybar oreo-cursors-git numix-icon-theme-git vertex-themes chili-sddm-theme firefox bitwarden discord vlc flameshot
clear
read -p "Change the current SDDM theme."
sudo vim /usr/lib/sddm/sddm.conf.d/default.conf
systemctl enable sddm.service

# Development
sudo yay -S --noconfirm python-pip jdk-openjdk atom anaconda
echo 'export PATH="/opt/anaconda/bin:$PATH"'>>~/.bashrc
pip install numpy scipy sklearn matplotlib

# Networking
cd /etc
systemctl enable sshd.service
sudo git clone https://github.com/ChrisTitusTech/firewallsetup.git
cd firewallsetup
chmod +x firewall
sudo ./firewall
