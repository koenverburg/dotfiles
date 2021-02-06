FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]

SHELL ["/bin/bash", "-c"]

LABEL Auther = "Koen Verburg <creativekoen@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  g++ \
  sudo \
  gcc \
  libc6-dev \
  make \
  git \
  ansible

RUN useradd -ms /bin/bash awake
# RUN adduser awake sudo
RUN gpasswd -a awake root
RUN echo 'awake ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER awake

RUN mkdir /home/awake/dotfiles
COPY  --chown=awake:users . ./home/awake/dotfiles
WORKDIR /home/awake/dotfiles

ENTRYPOINT ["bash", "./ansible/ubuntu.sh"]