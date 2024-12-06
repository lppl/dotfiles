FROM ubuntu:24.04 AS dotfiles-playground


# Warm up apt and intall bare essentials for later ====== #
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y curl git software-properties-common ansible
# ======================================================= #

# SSH Daemon ============================================ #
RUN apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo "Port 5222" >> /etc/ssh/sshd_config.d/securing_ssh.conf
RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config.d/securing_ssh.conf
#RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config.d/securing_ssh.conf
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config.d/securing_ssh.conf
RUN echo "TCPKeepAlive yes" >> /etc/ssh/sshd_config.d/prolonging_connection.conf
RUN echo "ClientAliveInterval 100" >> /etc/ssh/sshd_config.d/prolonging_connection.conf
# ======================================================= #


# Setup user ============================================ #
RUN useradd -m lppl
RUN usermod -aG sudo lppl
WORKDIR /home/lppl
COPY . ./utils/dotfiles
RUN chown -R "lppl:lppl" /home/lppl
USER lppl
# ======================================================= #


EXPOSE  5222
CMD ["/usr/sbin/sshd", "-D"]
