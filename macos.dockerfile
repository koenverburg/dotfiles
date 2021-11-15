FROM sickcodes/docker-osx:naked

# RUN xcode-select --install

RUN bash ansible/macos.sh

RUN bash ./macos.install -vv
