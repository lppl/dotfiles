#!/usr/bin/env bash


main () {
	local dotfiles_source_path=$(readlink  -e $(dirname $(dirname $BASH_SOURCE)))/dotfiles
	local dotfiles_target_path="/home/lppl"
	link_dotfiles $dotfiles_source_path $dotfiles_target_path
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