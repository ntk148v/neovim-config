#!/bin/bash

XTRACE=$(set +o | grep xtrace)
set -o xtrace

echo "Install Neovim"
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim -y

echo "Install Vundle as Package Manager"
mkdir -p ~/.config/nvim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim

echo "Get init.vim"
cd ~/.config/nvim/
wget https://raw.githubusercontent.com/ntk148v/neovim-config/master/init.vim
nvim +PluginInstall +q

$XTRACE