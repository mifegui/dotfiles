#!/bin/bash

sudo apt update
sudo apt install -y \
    newsboat \
    neovim \
    fd-find \
    fzf \
    npm \
    ripgrep 

# wsl-open
sudo npm install -g wsl-open

# bat
apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep
ln -s /usr/bin/batcat ~/.local/bin/bat

# Zoxide
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sh

# Plug e Plugins vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c PlugInstall
nvim -c CocInstall
