#!/usr/bin/env bash

echo "Cd into project root"
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
projectRoot=$( pwd )

if [ -d ../groupeat-api ]; then
    echo "GroupEat API repository already exists"
else
    echo "Cloning GroupEat API repository"
    git clone git@github.com:GroupEat/groupeat-api.git ../groupeat-api
fi

if [ -d ../groupeat-frontend ]; then
    echo "GroupEat frontend repository already exists"
else
    echo "Cloning GroupEat frontend repository"
    git clone git@github.com:GroupEat/groupeat-frontend.git ../groupeat-frontend
fi

if [ -d ../groupeat-showcase ]; then
    echo "GroupEat showcase repository already exists"
else
    echo "Cloning GroupEat showcase repository"
    git clone git@github.com:GroupEat/groupeat-showcase.git ../groupeat-showcase
fi

echo "Cd into groupeat-api"
cd ../groupeat-api

while grep -qs FILL_ME example.env; do
    echo 'Please fill the missing data in example.env'
    read -n1 -r -p "Press any key to continue " key
    echo ''
done

if [ ! -f .env ]; then
    echo 'Copying example.env to .env'
    cp example.env .env
fi

echo "Cd into project root"
cd $projectRoot

if grep -Fxqs "192.168.10.10  groupeat.dev" /etc/hosts; then
    echo "/etc/hosts file already modified"
else
    echo "Adding '192.168.10.10  groupeat.dev' to /etc/hosts"
    echo "192.168.10.10  groupeat.dev" | sudo tee -a /etc/hosts
fi

echo "Rebuilding"
./rebuild.sh

echo "Updating Vagrant boxes"
vagrant box update

echo "Booting the VM"
vagrant up
