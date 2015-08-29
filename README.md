# docker-vim
My vim's docker image!

## Usage

The recommended way is to use [docker-compose](http://docs.docker.com/compose/install/). The following config is a good example:
```yml
home:
  image: busybox
  volumes:
    - /home/dkr

vim:
  image: jivagoalves/vim
  volumes:
    - .:/home/dkr/workspace
    - /tmp:/tmp
    - /home/jivago/.ssh:/home/dkr/.ssh:ro
    - /etc/localtime:/etc/localtime:ro
  volumes_from:
    - home
  environment:
    - WORKSPACE=/home/dkr/workspace
    - DOCKER_GID
    - TMUX
    - TMUX_PANE
    - DISPLAY=unix:0
```

Then fire up vim with:
```
$ docker-compose run --rm vim
```

## How to Build

You can build using docker-compose in this repo:
```
$ docker-compose build vim
```

## How to Push to Docker Hub Registry

Build and tag the image appropriately:
```
$ docker build -t="jivagoalves/vim" .
```

Then push with:
```
$ docker push jivagoalves/vim
```
