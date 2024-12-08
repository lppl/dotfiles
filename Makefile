build:
	docker build -t dotfiles .

stop:
	docker stop dotfiles-runner

remove:
	docker rm dotfiles-runner

start:
	docker run \
    -it \
    --rm \
    --volume "$(shell pwd):/home/ubuntu/dotfiles" \
    --name dotfiles-runner \
    -u "$(shell id -u):$(shell id -g)" \
    dotfiles:latest

startr:
	docker run \
    -it \
    --volume "$(shell pwd):/home/ubuntu/dotfiles" \
    --name dotfiles-runner \
    dotfiles:latest

full: build start 
