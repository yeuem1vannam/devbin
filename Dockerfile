FROM ruby:3.0

ENV LANG C.UTF-8
ENV BUNDLE_PATH /usr/local/bundle
ENV RAILS_LOG_TO_STDOUT 1

RUN \
  echo "PS1='🐳  \[\033[1;36m\][\$(hostname)] \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]\[\033[0m\]'" >> ~/.bashrc; \
  echo "alias ls='ls --color=auto'" >> ~/.bashrc; \
  echo "alias grep='grep --color=auto'" >> ~/.bashrc

RUN \
  apt-get update -qq && apt-get install -y \
  apt-transport-https ca-certificates gnupg2 software-properties-common \
  build-essential graphviz curl vim cmake \
  && rm -rf /var/lib/apt/lists/*

RUN \
  echo "gem: --no-document --no-rdoc --no-ri" >> ~/.gemrc && \
  gem install bundler:2.1.2

ENV EDITOR=vim
WORKDIR /workspace

CMD ["/bin/bash"]
