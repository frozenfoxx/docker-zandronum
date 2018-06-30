#!/usr/bin/env bash

# Install Zandronum

wget -O - http://debian.drdteam.org/drdteam.gpg | apt-key add -
apt-add-repository 'deb http://debian.drdteam.org/ stable multiverse'

apt-get update
apt-get install -y zandronum
