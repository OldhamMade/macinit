#!/usr/bin/env sh

set -e

# Show the given message and exit with status 1.
function raise {
    echo
    echo "\033[31mError: $*\033[0m"
    exit 1
}

# Show the given message with highlighting
function info {
    echo "\033[0;34m$*\033[0m"
}

[[ "$USER" == root ]] && raise "Run this as a normal user, I'll sudo when I need to."

info "Checking for XCode Command Line Tools..."
if [ -d "/Library/Developer/CommandLineTools/usr/bin" ] && \
   [ -n "$(xcode-select --print-path 2>/dev/null)" ] && \
   [ -n "$(git --version 2>/dev/null)" ]; then
    info "... installed."
else
    info "... not found."
    info "I'll need to sudo to continue..."
    sudo info "Thank you."

    info "Installing XCode Command Line Tools..."
    xcode-select --install
    info "Re-run this script to continue with the setup once
the command line tools have finished installing."
fi

info "Checking for homebrew..."
if [ -n "$(brew --version 2>/dev/null)" ]; then
    info "... installed."
    info "Updating homebrew..."
    brew update
else
    info "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

info "Checking for pyenv..."
if [ -n "$(pyenv --version 2>/dev/null)" ]; then
    info "... installed."
else
    info "Installing pyenv..."
    curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
    info "... done."
    info "Loading pyenv..."
    export PATH="$HOME/.pyenv/bin:$PATH"
    info "... done."
    pyenv update
    info "Installing the latest Python 2.7 version..."
    pyenv install 2.7.10
    pyenv global 2.7.10
    info "...done.\n\nPlease re-run this script."
    exit
fi

export PATH="$HOME/.pyenv/bin:$PATH"

pyenv local 2.7.10

info "Installing pip..."
curl -Ls https://bootstrap.pypa.io/get-pip.py | python

info "Installing battleschool..."
pip install battleschool

info "... and we're done!\n
To run battleschool, execute the following command:
battle --config-file http://somesite/path/to/your/config.yml"
