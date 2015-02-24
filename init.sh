#!/usr/bin/env sh

set -e

echo "\033[0;34mInstalling XCode Command Line Tools...\033[0m"
xcode-select --install

echo "\033[0;34mInstalling pip...\033[0m"
curl -L https://bootstrap.pypa.io/get-pip.py | sudo python

echo "\033[0;34mInstalling battleschool...\033[0m"
sudo pip install battleschool

echo "\033[0;34mDone.\033[0m"
echo ""
echo "\033[0;34mTo run battleschool, execute the following command:\033[0m"
echo "\033[0;34mbattle --config-file http://somesite/path/to/your/config.yml\033[0m"
