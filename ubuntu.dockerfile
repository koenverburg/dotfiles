FROM ubuntu:20.04

MAINTAINER Koen Verburg <creativekoen@gmail.com>

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  g++ \
  gcc \
  libc6-dev \
  make \
  ansible

RUN useradd -ms /bin/bash awake
# RUN gpasswd -a awake
RUN echo 'awake ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER awake

RUN mkdir -p /home/awake/code/github/dotfiles
COPY  --chown=awake:users . ./home/awake/code/github/dotfiles
WORKDIR /home/awake/code/github/dotfiles

ENTRYPOINT ["sh", "./ansible/ubuntu.sh"]