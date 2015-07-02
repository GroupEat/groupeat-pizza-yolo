# Introduction

The GroupEat website use Vagrant in order not to mess too much with your computer setup. The API will be installed and run in a virtual machine, leaving your actual environment untouched! The added benefit is that the local development environment will be the same than the production one.

# Installing

## Common part

Clone this repository on your machine. Place it where you like and rename it if you want but make sure you won't change your mind because moving it after the following steps will break things... Then `cd` into the project root so that you are in the folder of the `Vagrantfile`.

### Composer and GitHub

Since the API needs a lot of Composer dependencies, you need a token from GitHub in order to be allowed to make all the needed requests. To do so, browse to https://github.com/settings/applications#personal-access-tokens and generate a new token. Create a `.composer` file in the project root and paste the token inside it.

## Mac OS X

 - `./mac_install.sh`

## Ubuntu

 - Install [Ansible](http://docs.ansible.com/intro_installation.html).
 - Install Node.js and the Gulp NPM package globally (`npm install -g gulp`).
 - `./ubuntu_install.sh`

## Other (What is wrong with you ?)

 - Download and install the latest versions of [Virtualbox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html).
 - Install [Ansible](http://docs.ansible.com/intro_installation.html).
 - Install Node.js, and the Gulp NPM package globally (`npm install -g gulp`).
 - Clone the API and frontend repositories with the commands:
   - `git clone git@github.com:GroupEat/groupeat-api.git ../groupeat-api`
   - `git clone git@github.com:GroupEat/groupeat-frontend.git ../groupeat-frontend`
 - Fill the missing data if any in `../groupeat-api/example.env` and copy this file to `../groupeat-api/.env`.
 - Add `192.168.10.10  groupeat.dev` to your hosts file.
 - Run the `vagrant box update` and `vagrant up` commands and wait for them to finish (a few minutes depending on your internet connection).
 - In the `groupeat-frontend` directory, install the dependencies with `npm install` and build with `gulp build`.
 - Browse to http://groupeat.dev and make sure it works.

# Updating

 - `./update.sh`

# Local Usage

## Interacting with the API and the frontend

 - API: every bash command should be executed inside the VM. For that SSH into it with the `vagrant ssh` command.
 - Frontend: every bash command should be executed on the host machine (ie. directly on your OS). This is because the `gulp watch` task and Livereload do not play nicely with Vagrant.

## Administration zone

Some useful admin routes are defined to tinker with the application:

 - http://groupeat.dev/docs: Read the API documentation
 - http://groupeat.dev/db?pgsql=127.0.0.1&username=groupeat&db=groupeat: PostgreSQL management page

Use the `groupeat` password on the local environment to access these pages.

# Provisioning the distant servers

 - Tweak the [inventory file](http://docs.ansible.com/intro_inventory.html) if needed.
 - Run the `ansible-playbook prod.yml -i hosts --ask-vault-pass -vv` command in the project root folder.
