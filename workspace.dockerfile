FROM ubuntu:focal

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_VERSION=latest

LABEL Author = "Koen Verburg <creativekoen@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  software-properties-common

# RUN apt-add-repository -y ppa:ansible/ansible
#
# RUN apt-get install -y --no-install-recommends \
#   automake \
#   build-essential \
#   pkg-config \
#   cargo \
#   cmake \
#   coreutils \
#   gcc \
#   git \
#   golang \
#   libc6-dev \
#   libtool \
#   lua5.3-dev \
#   make \
#   ninja-build \
#   nodejs \
#   npm \
#   python3 \
#   rustc \
#   sudo \
#   gettext \
#   libtool-bin \
#   autoconf \
#   g++ \
#   unzip \
#   curl \
#   doxygen \
#   bat \
#   # ripgrep \
#   tmux \
#   ansible

# RUN  git clone https://github.com/neovim/neovim.git && \
#   cd neovim && \
#   sudo make distclean && \
#   sudo make CMAKE_BUILD_TYPE=Release && \
#   sudo make install && \
#   cd ../ # && rm -rf nvim

# RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# RUN npm install --global vim-language-server \
#   typescript-language-server \
#   vscode-html-languageserver-bin \
#   yaml-language-server \
#   graphql-language-service-server \
#   @stoplight/spectral \
#   vscode-css-languageserver-bin

# RUN useradd -ms /bin/fish conrad && \

#   adduser conrad root && \
#   gpasswd -a conrad root && \

#   adduser conrad sudo && \
#   gpasswd -a conrad sudo && \
#   echo 'sudo ALL=(ALL) ALL' >> /etc/sudoers && \
#   echo 'conrad ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy config
# COPY . /root/code/github/dotfiles
# RUN cd /root/code/github/dotfiles && sudo bash ./workspace.install
# RUN cd /root/code/github/dotfiles && sudo bash ./ansible/ubuntu.sh

# RUN nvim --headless +PackerInstall +qall

# USER conrad
# WORKDIR /home/conrad/dotfiles

# WORKDIR /root/code

# ENV shell "/usr/bin/fish"

# SHELL ["/usr/bin/fish"]

CMD "/usr/bin/bash"
