
install: stuff fish dotfiles

dotfiles:
	bash ./scripts/link_dotfiles.sh

stuff:
	bash ./scripts/install.sh

fish:
	bash ./scripts/setup_fish.sh
node:
	bash ./scripts/setup_node.sh
