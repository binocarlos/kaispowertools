FROM ubuntu:12.04

MAINTAINER Kai Davenport, kaiyadavenport@gmail.com

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# general deps
RUN apt-get update
RUN apt-get install -y python-software-properties make software-properties-common curl python g++ mercurial subversion bzr

# git
RUN add-apt-repository ppa:voronov84/andreyv -y
RUN apt-get update
RUN apt-get install -y git

# node
RUN apt-get install wget
RUN wget -qO /usr/local/bin/nave https://raw.github.com/isaacs/nave/master/nave.sh
RUN chmod a+x /usr/local/bin/nave
RUN nave usemain 0.10.29

# go
RUN curl https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz | tar -C /usr/local -zx
RUN echo "GOROOT=/usr/local/go" >> /etc/environment
RUN echo "GOPATH=/srv/projects/gocode" >> /etc/environment
RUN echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin:/srv/projects/gocode/bin" >> /etc/environment

# cleanup
RUN apt-get clean
ENTRYPOINT ["/bin/bash"]