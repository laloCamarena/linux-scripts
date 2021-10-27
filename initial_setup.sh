#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

ssh-keygen -t ed25519

# gnome desktop stuff
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true

# git configurations
sudo apt-get install -y git
git config --global user.name "eduardo camarena"
git config --global user.email "lalo.a.camarena@gmail.com"
git config --global pager.branch false
# this can be used to not use any pager: git config --global pager.core ''
# to use a less pager run the command git config --global pager.<pager_type> "less -FRX"

# cool applications
sudo apt-get install -y ffmpegthumbnailer
sudo apt-get install -y gnome-tweaks
sudo apt-get install -y gnome-shell-extensions
sudo apt-get install -y psensor
sudo apt-get install -y vim
sudo apt-get install -y deluge
# run these commands if thumbnails still don't work 
# sudo apt-get install gstreamer1.0-libav
# sudo rm -rf $HOME/.cache/thumbnails/

# install chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# install brave browser
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# programming languages and stuff
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt-get install -y python3 python3-pip python3-venv
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node # "node" is an alias for the latest version


# install vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install -y code

# install lutris
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt-get update
sudo apt-get install -y --install-recommends winehq-stable
sudo add-apt-repository ppa:lutris-team/lutris
sudo apt-get update
sudo apt-get -y install lutris

# install steam
sudo apt-get update
sudo apt-get upgrade
sudo add-apt-repository multiverse
sudo apt-get install -y steam