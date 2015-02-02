# docker-vim
My vim's docker image!

## Usage

The recommended way is to use [fig](http://www.fig.sh). The following config is a good example:
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
  volumes_from:
    - home
  environment:
    - WORKSPACE=/home/dkr/workspace
    - DOCKER_GID
    - TMUX
    - TMUX_PANE
```

Then fire up vim with:
```
$ fig run --rm vim
```

## How to Build

You can build using fig in this repo:
```
$ fig build vim
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
