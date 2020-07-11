
install: stuff fish link

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
