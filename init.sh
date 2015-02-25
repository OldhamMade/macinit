#!/usr/bin/env sh

set -e

echo "\033[0;34mYou'll need to enter your sudo password to continue...\033[0m"

sudo echo "\033[0;34mInstalling XCode Command Line Tools...\033[0m"
if [ -f /usr/bin/gcc ]; then
    echo "\033[0;34m... already installed.\033[0m"
else
    xcode-select --install
fi

echo "\033[0;34mInstalling pip...\033[0m"
curl -L https://bootstrap.pypa.io/get-pip.py | sudo python

echo "\033[0;34mInstalling battleschool...\033[0m"
sudo pip install battleschool

echo "\033[0;34mDone.\033[0m"
echo ""
echo "\033[0;34mTo run battleschool, execute the following command:\033[0m"
echo "\033[0;34mbattle --config-file http://somesite/path/to/your/config.yml\033[0m"
