FROM debian:latest
MAINTAINER Jivago Alves <jivagoalves@gmail.com>

RUN apt-get update && apt-get install -y \
      curl \
      git \
      vim-nox \
      && curl -fLo /tmp/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
      && git clone https://github.com/jivagoalves/dotfiles.git /tmp/dotfiles \
      && rm -rf /var/lib/apt/lists/* \
      && apt-get purge -y --auto-remove curl

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/vim"]
