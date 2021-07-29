FROM ubuntu:20.10
SHELL ["/bin/bash", "-c"]

LABEL Author = "Koen Verburg <creativekoen@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  g++ \
  sudo \
  gcc \
  apt-utils \
  libc6-dev \
  make \
  git \
  # python-apt \
  python3-apt \
  python3.8 \
  ansible \
  fish

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

RUN chmod +x ./ansible/ubuntu.sh && sudo ./ansible/ubuntu.sh

# RUN sudo rm ~/.config/fish/config.fish && sudo bash ./install


