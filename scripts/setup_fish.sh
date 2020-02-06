#!/usr/bin/env bash



main () {
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo apt-get update
	sudo apt-get install -y fish
	USER=`whoami`
	FISH=`which fish`
	sudo chsh -s $FISH $USER 
	curl -L https://get.oh-my.fish | fish
	echo "fish_vi_key_bindings" >> ~/.config/fish/conf.d/conf.fish
}

main

unset -f main
