#!/bin/bash bash

set -e

./packages.sh

export PATH="$PATH:/usr/local/go/bin"

sudo git submodule update --init --recursive

# setup
(
    if [ ! -d "${HOME}/Projects" ]; then mkdir ${HOME}/Projects; fi
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
    sudo rm -rf ${HOME}/.vim/swapfiles
    sudo mkdir -p ${HOME}/.vim/swapfiles
)

# fzf
(
    cd ${HOME}/Projects
    git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf || (cd ${HOME}/.fzf && git pull && cd ..)
    cd
    printf '%s\n' y y n | ./.fzf/install
    chmod +x ${HOME}/.fzf.zsh
)

# vim plugins (that are annoying and can't be just copied)
(
    if [ ! -d "${HOME}/.vim/pack/plugins/start" ]; then sudo mkdir -p ${HOME}/.vim/pack/plugins/start; fi
    sudo rm -rf ${HOME}/.vim/pack/plugins/start/YouCompleteMe
    sudo rm -rf ${HOME}/.vim/pack/plugins/start/vim-fugitive
    cd ${HOME}/.vim/pack/plugins/start
    sudo git clone https://github.com/ycm-core/YouCompleteMe.git
    sudo git clone https://github.com/tpope/vim-fugitive.git
    cd ${HOME}/.vim/pack/plugins/start/YouCompleteMe
    sudo git submodule update --init --recursive
    sudo chmod -R 777 ${HOME}/.vim
    python3 install.py --all
)

# kitty
(
    sudo curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
)

./move.sh
