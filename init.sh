#!/usr/bin/env sh
### Running
# if running after cloning:
#   cat init.sh | sh

set -e

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

print_info() {
    printf "${blue} [i] %s ${reset}\n" "$1"
}

print_check() {
    printf "${yellow} [?] %s ${reset}\n" "$1"
}

print_success() {
    printf "${green} [✓] %s ${reset}\n" "$1"
}

print_error() {
    printf "${red} [×] %s ${reset}\n" "$1"
}

print_result() {

    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"

}

# Show the given message and exit with status 1.
function raise {
    printf "\n${red} [!] Fatal: $* ${reset}\n"
    exit 1
}


[[ "$USER" == root ]] && raise "Run this as a normal user, I'll sudo when I need to."


### XCode Command Line Tools
#      thx https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

print_check "Checking for XCode Command Line Tools..."
if ! xcode-select --print-path &> /dev/null; then
    print_info "Installing XCode Command Line Tools..."

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

else
    print_success "Already installed."
fi


print_check "Checking for homebrew..."
if [ -n "$(brew --version 2>/dev/null)" ]; then
    print_success "Already installed."
    print_info "Updating homebrew..."
    brew update
else
    print_info "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

print_success "Basic tools are now installed."
