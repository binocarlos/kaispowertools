#!/usr/bin/env bash
cd $HOME && git clone https://go.googlesource.com/go
cd $HOME/go && git checkout go1.4.1
cd $HOME/go/src && GOOS=darwin GOARCH=amd64 CGO_ENABLED=1 ./make.bash --no-clean
cd $HOME/go/src && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 ./make.bash --no-clean
echo "GOROOT=/home/vagrant/go" >> /etc/environment
echo "GOPATH=/srv/projects/gocode" >> /etc/environment
echo "PATH=$HOME/go/bin:$PATH" >> /etc/environment