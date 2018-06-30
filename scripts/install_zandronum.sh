#!/usr/bin/env bash

# Install Zandronum

apt-add-repository 'deb http://debian.drdteam.org/ stable multiverse'
wget -O - http://debian.drdteam.org/drdteam.gpg | apt-key add -

apt-get update
apt-get install zandronum
