#!/usr/bin/env bash
sudo apt-get -y install linux-image-extra-$(uname -r)
curl -sSL https://get.docker.io/ubuntu/ | sudo sh
sudo usermod -a -G docker vagrant