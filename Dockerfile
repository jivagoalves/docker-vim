FROM debian:latest
MAINTAINER Jivago Alves <jivagoalves@gmail.com>

RUN apt-get update && apt-get install -y \
      curl \
      git \
      tmux \
      vim-nox \
      gcc make libevent-dev libncurses5-dev \
      && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
      && chmod +x /usr/local/bin/gosu \
      && cd /tmp && curl -OL http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz \
      && tar xf tmux-1.9a.tar.gz \
      && cd tmux-1.9a && ./configure && make && make install \
      && cd / \
      && rm -rf /tmp/tmux* \
      && curl -fLo /plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
      && git clone https://github.com/jivagoalves/dotfiles.git /dotfiles \
      && apt-get purge -y --auto-remove \
        curl \
        gcc make libevent-dev libncurses5-dev \
      && apt-get purge -y tmux \
      && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/vim"]
