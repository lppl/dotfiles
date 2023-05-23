FROM ubuntu:22.04 AS base

RUN apt update

RUN apt install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

ENV TZ="Europe/Warsaw"

RUN apt install -y \
        sudo vim tmux \
        apt-utils \
        python3-dev \
        python3-pip \
        python3-yaml \
        software-properties-common \
    && apt autoremove

RUN echo "Europe/Warsaw" > /etc/timezone
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN cat /etc/passwd
RUN useradd  --create-home --no-log-init dotfiler 
RUN adduser dotfiler sudo

WORKDIR /home/dotfiler/dotfiles
COPY . .
RUN chown -R dotfiler ./*

USER dotfiler 
RUN bash ./ansible/ansible-run
RUN ansible-playbook -t essentials ansible/ansible.yml
RUN ansible-playbook   -t fish ansible/ansible.yml

RUN mkdir -p ~/.config && stow configfiles -t ~/.config
