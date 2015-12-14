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

if [ -d ../groupeat-web-app ]; then
    echo "GroupEat Web App repository already exists"
else
    echo "Cloning GroupEat Web App repository"
    git clone git@github.com:GroupEat/groupeat-web-app.git ../groupeat-web-app
fi

if [ -d ../groupeat-showcase ]; then
    echo "GroupEat Showcase repository already exists"
else
    echo "Cloning GroupEat Showcase repository"
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

if grep -Fxqs "192.168.10.10  app.groupeat.dev" /etc/hosts; then
    echo "/etc/hosts file already modified"
else
    echo "Adding '192.168.10.10  app.groupeat.dev' to /etc/hosts"
    echo "192.168.10.10  app.groupeat.dev" | sudo tee -a /etc/hosts
fi

echo "Booting the VM"
vagrant up

echo "Building the Web App"
vagrant ssh -c "cd ~vagrant/app; npm install; gulp build"

echo "Building the Showcase"
vagrant ssh -c "cd ~vagrant/showcase; npm install; gulp build"

echo "SSH into the VM"
vagrant ssh
