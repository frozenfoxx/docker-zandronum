#!/usr/bin/env bash

# Install Zandronum

sudo apt-add-repository 'deb http://debian.drdteam.org/ stable multiverse'
wget -O - http://debian.drdteam.org/drdteam.gpg | sudo apt-key add -

sudo apt-get update
sudo apt-get install zandronum
