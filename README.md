kaispowertools
==============

A collection of useful tools for Kai.

This repo is totally for me and so I fragrantly litter my opinions throughout these tools.

## linux host

If you are running a linux host then copy the `.bashrc` and `bin` to `~`

## vagrant

To boot a development environment from vagrant:

From the host:

```bash
$ vagrant up
```

Then SSH to the guest:

```bash
$ cd /srv/projects/kaispowertools
$ ./setupcore.sh
$ ./setupkai.sh
```

## docker

This boots a docker container with the docker binary and docker socket mounted.

This lets us run `docker run` from inside the container.

```
$ docker build -t devbox .
```