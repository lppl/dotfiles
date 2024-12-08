FROM ubuntu:24.04 AS dotfiles-playground


# Warm up apt and intall bare essentials for later ====== #
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y curl git software-properties-common ansible
RUN apt install -y vim
# ======================================================= #

# Setup user ============================================ #
ENV PATH="/home/ubuntu/dotfiles/env/.local/bin:${PATH}"
ENV DEV_ENV_HOME="/home/ubuntu/dotfiles"

RUN usermod -a -G sudo  ubuntu

WORKDIR /home/ubuntu
# ======================================================= #
