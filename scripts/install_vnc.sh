#!/bin/bash
#
# This script installs VNC

sudo apt-get update -y
sudo apt install xfce4 xfce4-goodies tightvncserver -y
cat "/share/scripts/input.txt" | vncserver -geometry 1280x1024 -depth 16
sudo ufw disable
ifconfig
