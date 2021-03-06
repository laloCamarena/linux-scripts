#!/bin/bash

# the default package manager is apt
MANAGER="${1:-apt}"

sudo $MANAGER update
sudo $MANAGER upgrade

ssh-keygen -t ed25519

# gnome desktop stuff
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
gsettings set org.gnome.desktop.sound event-sounds false # this is seriously the most important configuration

# git configurations
sudo $MANAGER install -y git
git config --global user.name "eduardo camarena"
git config --global user.email "lalo.a.camarena@gmail.com"
git config --global pager.branch false
# this can be used to not use any pager: git config --global pager.core ''
# to use a less pager run the command git config --global pager.<pager_type> "less -FRX"

# cool applications
sudo $MANAGER install -y ffmpegthumbnailer
sudo $MANAGER install -y gnome-tweaks
sudo $MANAGER install -y gnome-shell-extensions
sudo $MANAGER install -y psensor
sudo $MANAGER install -y vim
sudo $MANAGER install -y deluge
# run these commands if thumbnails still don't work 
# sudo apt-get install gstreamer1.0-libav
# sudo rm -rf $HOME/.cache/thumbnails/

if $MANAGER == 'apt'; then
  # install brave browser
  sudo apt install apt-transport-https curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install -y brave-browser

  # install vscode
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install -y code

  # install steam
  sudo apt-get update
  sudo apt-get upgrade
  sudo add-apt-repository multiverse
  sudo apt-get install -y steam

  # install lutris
  sudo add-apt-repository ppa:lutris-team/lutris
  sudo apt update
  sudo apt install lutris
elif $MANAGER == 'dnf'; then
  #install brave browser
  sudo dnf install dnf-plugins-core
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install brave-browser

  #install vscode
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  dnf check-update
  sudo dnf install code

  #install steam
  sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install steam

  #install lutris
  sudo dnf install lutris
fi

# programming languages and stuff
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo $MANAGER install -y python3 python3-pip python3-venv
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts
