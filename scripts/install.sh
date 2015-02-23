#!/usr/bin/env bash


main () {
  local dotfiles_source_path=$(readlink  -e $(dirname $(dirname $BASH_SOURCE)))/dotfiles
  local dotfiles_target_path=`eval echo ~`
  install_some_basic_apps
  link_dotfiles $dotfiles_source_path $dotfiles_target_path
  source ~/.profile
}

install_some_basic_apps () {
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install git git-flow git-svn subversion \
                       vim vim-nox \
                       zsh openvpn
}


i_am_root () {
  [[ $EUID -eq 0 ]]
}


link_dotfiles () {
  local source_path=$1
  local target_path=$2
  find $source_path -type f | while read file; do link_dotfile $file $target_path; done
}


link_dotfile () {
  local source_path=$1
  local target_path=$(readlink  -e $2)
  local file=$(basename $source_path)
  cp -fs "$source_path" "$target_path/.$file"
}


main


unset -f main
unset -f install_some_basic_apps
unset -f i_am_root
unset -f link_dotfiles
unset -f link_dotfile
