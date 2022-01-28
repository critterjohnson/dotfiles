#!/bin/bash

# kitty
sudo cp -r kitty/ ~/.config/

# zsh
sudo cp ./zsh/.zshrc ~/.zshrc
sudo cp -r ./zsh/.oh-my-zsh ~
sudo cp -r ./zsh/.zsh ~

# vim
sudo cp ./vim/.vimrc ~/.vimrc
sudo cp -r ./vim/.vim ~

# tmux
sudo cp ./tmux/.tmux.conf ~/.tmux.conf
