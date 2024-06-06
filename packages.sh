#!/bin/bash

set -e

sudo apt-get update

# go
(
    sudo wget 'https://golang.org/dl/go1.18.1.linux-amd64.tar.gz'
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf 'go1.18.1.linux-amd64.tar.gz'
    sudo rm -rf 'go1.18.1.linux-amd64.tar.gz'
)

# regular packages
sudo apt-get install -y dkms libdrm-dev default-jre nodejs npm zsh python3\
    python3-dev build-essential git cmake gcc-8 exuberant-ctags

sudo cp /usr/bin/gcc-8 /usr/bin/gcc

# cmake from source
(
    if [ $(cmake --version | head -n 1 | tr -d -c 0-9) -lt 3140 ]; then
        git clone https://github.com/Kitware/CMake/
        cd CMake
        ./bootstrap
        make
        sudo make install
        cd ..
        rm -rf CMake
    fi
)

# ripgrep
(
    curl -LO 'https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb'
    sudo dpkg -i 'ripgrep_12.1.1_amd64.deb'
    rm 'ripgrep_12.1.1_amd64.deb'
)

# ranger
pip3 install ranger-fm

# fd-find
sudo apt install fd-find
