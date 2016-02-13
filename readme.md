# Introduction

GroupEat use Vagrant in order not to mess too much with your computer setup. Everything will be installed and run in a virtual machine, leaving your actual environment untouched! The added benefit is that the local development environment will be the same than the production one.

# Installing

Clone this repository on your machine. Place it where you like and rename it if you want but make sure you won't change your mind because moving it after the following steps will break things... Then `cd` into the project root so that you are in the folder of the `Vagrantfile`.

### Composer and GitHub

Since the API needs a lot of Composer dependencies, you need a token from GitHub in order to be allowed to make all the needed requests. To do so, browse to https://github.com/settings/applications#personal-access-tokens and generate a new token. Create a `.composer` file in the project root and paste the token inside it.

## Required software

 - Git
 - Ansible >= 1.9.1
 - Vagrant >= 1.7.4
 - VirtualBox >= 5.0.0

## Finally

 - `./install.sh`

# Local Usage

## Administration zone

Some useful admin routes are defined to tinker with the application:

 - http://groupeat.dev/docs: Read the API documentation
 - http://groupeat.dev/db?pgsql=127.0.0.1&username=groupeat&db=groupeat: PostgreSQL management page

Use the `groupeat` password on the local environment to access these pages.

# Provisioning the distant servers

 - Tweak the [inventory file](http://docs.ansible.com/intro_inventory.html) if needed.
 - Run the `ansible-playbook prod.yml -i hosts --ask-vault-pass -vv` command in the project root folder.

# Ansible vault

Ansible vault keeps all secret passwords and keys in a secure file. To read its content, you need to have in the current directory a `.vault_pass` file whose content is a password (ask about it to the team members if you don't know it):

```
echo <password> > .vault-pass
ansible-vault --vault-password-file .vault_pass view vars/secrets.yml
```
