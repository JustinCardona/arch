# Installing package manager
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD

# Install desktop and applications
yay -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader xorg-fonts-misc sddm i3-wm lxappearance dmenu rofi terminator feh polybar oreo-cursors-git numix-icon-theme-git vertex-themes chili-sddm-theme brave-bin bitwarden discord vlc flameshot nautilus anaconda 

systemctl enable sddm.service
