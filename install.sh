#!/bin/bash

XTRACE=$(set +o | grep xtrace)
set -o xtrace

echo "Install Neovim"
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim -y

echo "Install Vim-plug as Package Manager"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Get init.vim"
cd ~/.config/nvim/
wget https://raw.githubusercontent.com/ntk148v/neovim-config/master/init.vim
nvim +PluginInstall +q

$XTRACE