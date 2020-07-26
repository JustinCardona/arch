# Archy Arch Linux EFI Installer
## Description
- This is an automated installer for Arch Linux.
- It creates a GPT partition on the drive of your choice, making an EFI partition and a root partition.
- It installs the SDDM display manager and the KDE plasma desktop environment.
## Usage
- Obtain an Arch Linux ISO from https://www.archlinux.org/download/
- Create an installation medium and boot from it. Visit Arch Linux's Wiki for more information. https://wiki.archlinux.org/index.php/Installation_guide#Prepare_an_installation_medium
- When you have reached the ISO command line type:
    - curl -L https://raw.githubusercontent.com/JustinCardona/arch/master/installer.sh > install
    - sh install
## Good Luck 