#!/usr/bin/env bash

main () {
    install_fish
    setup_status_line
}

install_fish () {
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo apt-get update
	sudo apt-get install -y fish
	USER=`whoami`
	FISH=`which fish`
	sudo chsh -s $FISH $USER
	curl -L https://get.oh-my.fish | fish
}

setup_status_line () {
    omf install bobthefish
}

main
