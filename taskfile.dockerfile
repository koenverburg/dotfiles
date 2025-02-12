FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

LABEL Author = "Koen Verburg <creativekoen@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  ca-certificates \
  apt-utils \
  libc6-dev \
  python3 \
  sudo \
  curl \
  git

RUN useradd -ms /bin/bash conrad && \
  adduser conrad root && \
  gpasswd -a conrad root && \
  adduser conrad sudo && \
  gpasswd -a conrad sudo && \
  echo 'sudo ALL=(ALL) ALL' >> /etc/sudoers && \
  echo 'conrad ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER conrad
COPY ./Taskfile.yaml .

RUN sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d
RUN sudo task setup
