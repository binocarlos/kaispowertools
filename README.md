kaispowertools
==============

This repo is totally for me and so I fragrantly litter my opinions throughout.

## setup

When running the docker container the `$HOME` folder is mounted as a volunme.

As a result, ssh hosts and git are configured normally on the host.

```bash
$ GIT_NAME="Kai Davenport" GIT_EMAIL="kaiyadavenport@gmail.com" make gitconfig
```

## docker

Build image:

```bash
$ cd kaispowertools
$ docker build -t devbox .
```

Run dev container (replace mount points to customize):

```bash
$ docker run -ti --rm \
    -v /home/kai/projects:/srv/projects:ro \
    -v /home/kai:/root:ro \
    -v /usr/bin/docker:/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 80:80 \
    devbox
```