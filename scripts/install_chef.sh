#!/bin/bash
#
# This script installs ChefDK
#
# Resources:
# https://github.com/test-kitchen/test-kitchen
# https://github.com/test-kitchen/kitchen-docker
#

# Modifiable Vars
OMNITRUCK_URL="https://omnitruck.chef.io/install.sh"
CHEFDK_VERSION="2.4.17"

#Install ChefDK
if [ -d /opt/chefdk ]; then
  echo "'/opt/chefdk' already exists, skipping install" 1>&2
else
  # Install ChefDK
  sudo curl --retry 5 -sL "$OMNITRUCK_URL" | sudo bash -s -- -P chefdk -v $CHEFDK_VERSION
  if test $? -ne 0; then
    echo "Error: Omnitruck Install failed"
    exit 1
  fi
fi

#Configure pathing to use ChefDK Ruby instead of system ruby

sudo echo 'eval "$(chef shell-init bash)"' >> /home/vagrant/.profile
sudo echo 'export "EDITOR=vim"' /home/vagrant/.profile
sudo echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> /home/vagrant/.profile
source /home/vagrant/.profile
which ruby

#Configure knife.rb

ssh-keygen -b 2048 -t rsa -f /home/vagrant/cert.pem -q -N ""
echo "chef_server_url	'http://10.248.23.10:33356'
node_name	'devnode'
client_key	'cert.pem'" >> knife.rb
