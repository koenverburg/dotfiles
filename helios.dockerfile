FROM ubuntu:20.10
SHELL ["/bin/bash", "-c"]

LABEL Auther = "Koen Verburg <creativekoen@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  g++ \
  sudo \
  gcc \
  apt-utils \
  libc6-dev \
  make \
  git \
  python3-apt \
  python3.8 \
  ansible

RUN useradd -ms /bin/bash helios && \

  adduser helios root && \
  gpasswd -a helios root && \

  adduser helios sudo && \
  gpasswd -a helios sudo && \
  echo 'sudo ALL=(ALL) ALL' >> /etc/sudoers && \
  echo 'helios ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir /home/helios/dotfiles
COPY  --chown=helios:users . ./home/helios/dotfiles

USER helios
WORKDIR /home/helios/dotfiles

RUN chmod +x ./ansible/helios.sh && sudo ./ansible/helios.sh


