#!/bin/bash
#
# This script installs Docker

# Install and start docker-engine


sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo apt-key fingerprint 0EBFCD88
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y
sudo usermod -aG docker vagrant
sudo service docker start

# Test docker install
docker run hello-world
if test $? -ne 0; then
  echo "Error: docker-engine install failed"
  exit 1
fi

# Install the docker driver for the user who launched the present script
sudo su - vagrant -c 'eval "$(chef shell-init bash)" && gem install kitchen-docker'
