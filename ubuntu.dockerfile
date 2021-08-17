FROM ubuntu:21.04

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

LABEL Author = "Koen Verburg <creativekoen@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  libc6-dev \
  python3 \
  sudo \
  git

RUN useradd -ms /bin/bash conrad && \

  adduser conrad root && \
  gpasswd -a conrad root && \

  adduser conrad sudo && \
  gpasswd -a conrad sudo && \
  echo 'sudo ALL=(ALL) ALL' >> /etc/sudoers && \
  echo 'conrad ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir /home/conrad/dotfiles
COPY  --chown=conrad:users . ./home/conrad/dotfiles

USER conrad
WORKDIR /home/conrad/dotfiles

RUN bash ./install -vv
