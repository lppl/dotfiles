#!/usr/bin/env bash

main() {
    install_vundle
}

install_vundle() {
    rm -rf dotfiles/vim/bundle/*
    git clone https://github.com/VundleVim/Vundle.vim.git dotfiles/vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}

main

