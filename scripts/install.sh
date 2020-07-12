#!/usr/bin/env bash

main () {
  install_some_basic_apps
}

install_some_basic_apps () {
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y git git-flow git-svn subversion \
                       python3-pip \
                       vim vim-nox \
                       tmux \
                       xclip \
		               curl \
                       openvpn

}

i_am_root () {
  [[ $EUID -eq 0 ]]
}

main
