#!/bin/bash

if [ -z "$(which easy_install)" ]; then
  echo "installing easy_install..."
  sudo apt-get -y install python-setuptools
fi

if [ -z "$(which pip)" ]; then
  echo "installing pip..."
  sudo easy_install pip
fi

if [ -z "$(which ansible)" ]; then
  echo "installing fagia/ansible@devel version..."
  sudo pip install git+https://github.com/fagia/ansible.git@devel
fi
