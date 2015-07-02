#!/usr/bin/env bash

echo "Cd into project root"
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
projectRoot=$( pwd )

echo "Updating apt-get"
sudo apt-get update

echo "Installing Virtualbox"
sudo apt-get install -y virtualbox

echo "Installing Vagrant"
sudo apt-get install -y vagrant

echo "Installing VirtualBox host kernel modules"
sudo apt-get install -y virtualbox-dkms

echo "Running Unix install script"
./unix_install.sh
