#!/bin/bash

set -e

./packages.sh

git submodule update --init --recursive

# setup
(
    mkdir ${HOME}/Projects
)

# vim
(
    cd ${HOME}/Projects
    git clone https://github.com/vim/vim.git || (cd vim && git pull && cd ..)
    cd vim
    make distclean
    ./configure --with-features=huge \
            	--enable-multibyte \
            	--enable-python3interp=yes \
            	--with-python3-config-dir="$(python3-config --configdir)" \
            	--enable-perlinterp=yes \
            	--enable-gui=gtk2 \
            	--enable-cscope \
            	--prefix=/usr/local
    make
    sudo make install
    sudo rm -rf ~/.vim/swapfiles
    sudo mkdir ~/.vim/swapfiles
)

# fzf
(
    cd ${HOME}/Projects
    git clone --depth 1 https://github.com/junegunn/fzf.git  ~/.fzf || (cd ~/.fzf && git pull && cd ..)
    cd
    printf '%s\n' y y n | sudo ./.fzf/install
    chmod +x ~/.fzf.zsh
)

# vim plugins (that are annoying and can't be just copied)
(
    sudo rm -rf ~/.vim/pack/plugins/start/YouCompleteMe
    sudo rm -rf ~/.vim/pack/plugins/start/vim-fugitive
    cd ~/.vim/pack/plugins/start
    sudo git clone https://github.com/ycm-core/YouCompleteMe.git
    sudo git clone https://github.com/tpope/vim-fugitive.git
    cd ~/.vim/pack/plugins/start/YouCompleteMe
    sudo git submodule update --init --recursive
    sudo chmod -R 777 ~/.vim
    python3 install.py --all
)

# kitty
(
    sudo curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
)

./move.sh
