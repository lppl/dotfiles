FROM ubuntu:24.04 AS dotfiles-playground


# Warm up apt and intall bare essentials for later ====== #
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y curl git software-properties-common ansible
# ======================================================= #

# Setup user ============================================ #
RUN useradd -m lppl
RUN usermod -aG sudo lppl
WORKDIR /home/lppl
COPY . ./utils/dotfiles
RUN chown -R "lppl:lppl" /home/lppl
USER lppl
# ======================================================= #
