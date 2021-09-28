FROM ubuntu:21.04

# SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

LABEL Author = "Koen Verburg <creativekoen@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  automake \
  build-essential \
  pkg-config \
  cargo \
  cmake \
  coreutils \
  gcc \
  git \
  golang \
  libc6-dev \
  libtool \
  lua5.3-dev \
  make \
  ninja-build \
  nodejs \
  npm \
  python3 \
  rustc \
  sudo

RUN add-apt-repository --yes ppa:neovim-ppa/unstable && \
    apt-get install -y neovim

# RUN  git clone https://github.com/neovim/neovim.git && \
#   cd neovim && \
#   make && \
#   make install && \
#   cd ../ && rm -rf nvim

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

RUN fish -c 'curl -L https://get.oh-my.fish | source - --noninteractive'

RUN apt-get install \
  bat \
  ripgrep \
  fish \
  tmux && \
  npm install --global vim-language-server \
  typescript-language-server \
  vscode-html-languageserver-bin \
  yaml-language-server \
  graphql-language-service-server \
  @stoplight/spectral \
  vscode-css-languageserver-bin

# RUN useradd -ms /bin/fish conrad && \

#   adduser conrad root && \
#   gpasswd -a conrad root && \

#   adduser conrad sudo && \
#   gpasswd -a conrad sudo && \
#   echo 'sudo ALL=(ALL) ALL' >> /etc/sudoers && \
#   echo 'conrad ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir /home/conrad/dotfiles
COPY  --chown=conrad:users . ./home/conrad/dotfiles

# Copy config
COPY . /root/code/github/dotfiles

RUN cd /root/code/github/dotfiles && ./workspace.install

RUN nvim --headless +PackerInstall +qall

# USER conrad
# WORKDIR /home/conrad/dotfiles

WORKDIR /root
ENV shell "/usr/bin/fish"

CMD "/usr/bin/fish"
