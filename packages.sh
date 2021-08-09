#!/bin/bash

set -e

sudo apt-get update

# go
(
    sudo wget 'https://golang.org/dl/go1.16.7.linux-amd64.tar.gz'
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf 'go1.16.7.linux-amd64.tar.gz'
    sudo rm -rf 'go1.16.7.linux-amd64.tar.gz'
)

# regular packages
sudo apt-get install -y dkms libdrm-dev default-jre nodejs npm zsh python3\
    python3-dev build-essential git

# cmake from source
(
    git clone https://github.com/Kitware/CMake/
    cd cmake
    ./bootstrap
    make
    sudo make install
)

# ripgrep
(
    curl -LO 'https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb'
    sudo dpkg -i 'ripgrep_12.1.1_amd64.deb'
    rm 'ripgrep_12.1.1_amd64.deb'
)
