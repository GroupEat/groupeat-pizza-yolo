#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]]; then
    echo "Installing Brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Updating Brew"
    brew update
fi

if [[ -n $(brew ls --versions brew-cask) ]]; then
    echo 'Updating Brew-cask'
    brew upgrade brew-cask
else
    echo "Installing Brew-cask"
    brew install caskroom/cask/brew-cask
fi

brew cask list virtualbox
if [[ $? != 0 ]]; then
    echo "Installing Virtualbox"
    brew cask install --force virtualbox
else
    echo "Updating Virtualbox"
    brew cask update virtualbox
fi

brew cask list vagrant
if [[ $? != 0 ]]; then
    echo "Installing Vagrant"
    brew cask install --force vagrant
else
    echo "Updating Vagrant"
    brew cask update vagrant
fi

brew cask list ansible
if [[ $? != 0 ]]; then
    echo "Installing Ansible"
    brew cask install --force ansible
else
    echo "Updating Ansible"
    brew cask update ansible
fi

which node
if [[ $? != 0 ]]; then
    echo "Installing Node.js"
    brew install node
else
    echo "Updating Node.js"
    brew upgrade node
fi

which gulp
if [[ $? != 0 ]]; then
    echo "Installing Gulp"
    npm install -g gulp
else
    echo "Updating Gulp"
    npm update -g gulp
fi

echo "Cleanup Brew"
brew cleanup

echo "Running Unix install script"
./unix_install.sh
