
install: stuff powerline rsync fish link vim

stuff:
	bash ./scripts/install.sh

fish:
	bash ./scripts/setup_fish.sh

node:
	bash ./scripts/setup_node.sh

link:
	bash ./scripts/link_dotfiles.sh

rsync:
	rsync -av ./configfiles/* ~/.config

vim:
	bash ./scripts/setup_vim.sh

powerline:
	bash ./scripts/setup_powerline.sh


setup_directories:
	mkdir -p ${HOME}/user/Desktop
	mkdir -p ${HOME}/user/Downloads
	mkdir -p ${HOME}/user/Templates
	mkdir -p ${HOME}/user/Public
	mkdir -p ${HOME}/user/Documents
	mkdir -p ${HOME}/user/Music
	mkdir -p ${HOME}/user/Pictures
	mkdir -p ${HOME}/user/Videos
	mkdir -p ${HOME}/user/Pictures/00__Screenshots
	xdg-user-dirs-update
	gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/${USER}/user/Pictures/00__Screenshots/"

build:
	docker build -t dotfiles .

stop:
	docker stop dotfiles-runner

remove:
	docker rm dotfiles-runner

start:
	docker run -it --name dotfiles-runner dotfiles:latest

full: build stop remove start 
