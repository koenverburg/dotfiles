FROM alpine

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author = "Koen Verburg <creativekoen@gmail.com>"

RUN apk update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  libc6-dev \
  python3 \
  sudo \
  git

RUN mkdir /home/conrad/dotfiles
COPY  --chown=conrad:users . ./home/conrad/dotfiles

USER conrad
WORKDIR /home/conrad/dotfiles

RUN bash ./install -vv

RUN make neovim
