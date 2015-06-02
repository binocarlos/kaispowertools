#!/bin/bash
docker run -it --rm \
  --name devbox \
  -p 80:80 \
  -v $HOME/projects:/srv/projects \
  -v $HOME/.gitconfig:/root/.gitconfig \
  -v $HOME/.ssh:/root/.ssh \
  -v /usr/bin/docker:/usr/bin/docker \
  -v /var/run/docker.sock:/var/run/docker.sock \
  devbox

# this is a test this is a test this is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a testthis is a test