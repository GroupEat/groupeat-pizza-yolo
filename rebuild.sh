#!/usr/bin/env bash

echo "Cd into project root"
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
projectRoot=$( pwd )

echo "Updating Vagrant boxes"
vagrant box update

echo "Provisioning the VM"
vagrant provision

echo "Building the frontend"
cd ../groupeat-frontend
vagrant ssh -c "cd ~vagrant/frontend; npm install; gulp build"

echo "Cd into project root"
cd $projectRoot

echo "SSH into the VM"
vagrant ssh
