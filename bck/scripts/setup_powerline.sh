#!/usr/bin/env bash



main () {
    install_nerd_fonts
    install_powerline
}

install_powerline () {
    pip3 install powerline-status
    sudo cp ~/.local/bin/powerline* /usr/local/bin
}

install_nerd_fonts () {
    mkdir -p tmp ~/.local/share/fonts
    cd tmp
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Bold-Italic/complete/Ubuntu%20Mono%20Bold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Bold/complete/Ubuntu%20Mono%20Bold%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
    WGET https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Regular-Italic/complete/Ubuntu%20Mono%20Italic%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
    cp -f ./* ~/.local/share/fonts
    fc-cache -vf ~/.local/share/fonts
    cd ..
    rm -rf tmp
}

main

