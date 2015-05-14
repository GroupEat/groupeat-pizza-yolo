#!/usr/bin/env bash

echo "Cd into project root"
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
projectRoot=$( pwd )

if [ ! -f .vault_pass ]; then
    ansible-playbook prod.yml -i hosts --ask-vault-pass -vv
else
    ansible-playbook prod.yml -i hosts --vault-password-file .vault_pass -vv
fi

if ssh vagrant@groupeat.fr "[ -d ~vagrant/api/current ]"; then
    echo "The ~vagrant/api/current directory already exists, the API should be live."
else
    cd ../groupeat-api
    rocketeer setup
    rocketeer deploy
    rocketeer deploy # This must be done twice because some errors will occur the first time
    ssh vagrant@groupeat.fr "cd ~vagrant/api/current; php artisan db:install --force --seed"
    cd $projectRoot
fi

if ssh vagrant@groupeat.fr "[ -d ~vagrant/frontend ]"; then
    echo "The ~vagrant/frontend directory already exists, the frontend should be live."
else
    cd ../groupeat-frontend
    gulp deploy
    cd $projectRoot
fi
