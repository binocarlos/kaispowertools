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
RUN add-apt-repository ppa:voronov84/andreyv -y
RUN apt-get update
RUN apt-get install -y python-software-properties make software-properties-common curl python g++ git mercurial subversion bzr

# node
RUN wget -qO /usr/local/bin/nave https://raw.github.com/isaacs/nave/master/nave.sh
RUN chmod a+x /usr/local/bin/nave
RUN nave usemain 0.10.29

# go
RUN curl https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz | tar -C /usr/local -zx

# cleanup
RUN apt-get clean

ENTRYPOINT ["/bin/bash"]