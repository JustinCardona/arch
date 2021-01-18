# Installing package manager
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD

# Install desktop and applications
yay -S --noconfirm anaconda bitwarden brave-bin chili-sddm-theme discord dmenu feh flameshot i3-wm lib32-vulkan-icd-loader lxappearance nautilus numix-icon-theme-git oreo-cursors-git polybar rofi sddm terminator ttf-roboto vertex-themes vlc vulkan-icd-loader xorg-fonts-misc 

systemctl enable sddm.service
