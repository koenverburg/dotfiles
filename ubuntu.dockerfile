FROM ubuntu:20.04
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
  python-apt \
  python3-apt \
  python3.8 \
  ansible

RUN useradd -ms /bin/bash conrad
# RUN adduser conrad sudo
RUN gpasswd -a conrad root
RUN echo 'conrad ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# USER conrad

RUN mkdir /home/conrad/dotfiles
COPY  --chown=conrad:users . ./home/conrad/dotfiles
WORKDIR /home/conrad/dotfiles

RUN chmod +x ./ansible/ubuntu.sh
RUN ./ansible/ubuntu.sh

