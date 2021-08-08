#!/bin/bash

set -e

sudo apt-get update

wget 'https://golang.org/dl/go1.16.7.linux-amd64.tar.gz'
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf 'go1.16.7.linux-amd64.tar.gz'
sudo rm -rf 'go1.16.7.linux-amd64.tar.gz'

sudo apt-get install -y dkms libdrm-dev default-jre cmake
