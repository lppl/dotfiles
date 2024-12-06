#!/usr/bin/env bash

main () {
  install_some_basic_apps
}

install_some_basic_apps () {
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y git git-flow git-svn subversion \
                      python3-pip \
                      vim vim-nox \
                      tmux \
                      xclip \
		                  curl \
                      dconf-editor \
                      openvpn

}

i_am_root () {
  [[ $EUID -eq 0 ]]
}

main
