#!/bin/bash
set -e

DOCKER_USER=dkr
DOCKER_HOME=/home/$DOCKER_USER

if [ ! -d "$DOCKER_HOME" ]; then
  USERADD_M_FLAG=-m
else
  USERADD_M_FLAG=""
fi

echo "Creating user '$DOCKER_USER'"
if [ "$DOCKER_GID" ]; then
  echo "Using gid '$DOCKER_GID' for '$DOCKER_USER'"
  groupadd -g "$DOCKER_GID" $DOCKER_USER
  useradd $USERADD_M_FLAG -g $DOCKER_USER -s /bin/bash $DOCKER_USER
else
  useradd $USERADD_M_FLAG -s /bin/bash $DOCKER_USER
fi

if [ "$WORKSPACE" ]; then
  echo "Creating '$WORKSPACE'"
  mkdir -p "$WORKSPACE"
fi

if [ ! -f "$DOCKER_HOME/.vim/autoload/plug.vim" ]; then
  echo "Installing Vim-Plug"
  mkdir -p $DOCKER_HOME/.vim/autoload
  mv /plug.vim $DOCKER_HOME/.vim/autoload/
  chown -R $DOCKER_USER:$DOCKER_USER $DOCKER_HOME
fi

if [ ! -d "$DOCKER_HOME/dotfiles" ]; then
  echo "Installing dotfiles"
  mv /dotfiles $DOCKER_HOME/
  chown -R $DOCKER_USER:$DOCKER_USER $DOCKER_HOME
  su -lc 'cd ~/dotfiles && git checkout setup_docker' $DOCKER_USER
  su -lc 'cd ~/dotfiles && ./install.sh' $DOCKER_USER
fi

if [ "$1" = '/usr/bin/vim' ]; then
  echo "Login shell as '$DOCKER_USER'"
  if [ "$WORKSPACE" ]; then
    exec su -c "cd $WORKSPACE && $@" $DOCKER_USER
  else
    exec su -c "$@" $DOCKER_USER
  fi
fi

exec "$@"
