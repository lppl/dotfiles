#!/usr/bin/env bash


main () {
	local dotfiles_source_path=$(readlink  -e $(dirname $(dirname $BASH_SOURCE)))/dotfiles
	local dotfiles_target_path="~"
	if i_am_root; then 
		local dotfiles_target_path="/root"
	fi
	link_dotfiles $dotfiles_source_path $dotfiles_target_path
	source ~/.profile
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
