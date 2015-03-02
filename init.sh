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
if [ -n "$(xcode-select --print-path 2>/dev/null)" ] &&
   [ -n "$(git --version 2>/dev/null)" ]; then
    info "... installed."
else
    info "... not found."
    info "I'll need to sudo to continue..."
    sudo info "Thank you."

    info "Installing XCode Command Line Tools..."
    (xcode-select --install 2>/dev/null) &

    while true; do
        sleep 3

        # show some activity while we wait
        echo ".\c"

        # if xcode-select hasn't created the target dir, wait
        if [ ! -d "/Library/Developer/CommandLineTools/usr/bin" ]; then
            continue;
        fi

        # once created, count the number of files in there
        COUNT=`ls -l /Library/Developer/CommandLineTools/usr/bin/ | wc -l`

        # make sure we have a good number of binaries available
        # and that some essentials exist
        if [ -n "$(xcode-select --print-path 2>/dev/null)" ] && \
           [ -n "$(gcc --version 2>/dev/null)" ] && \
           [ -n "$(git --version 2>/dev/null)" ] && \
           [ "$COUNT" -gt "60" ]; then
            break;
        fi
    done

    read -p "Once the installer has finished, hit enter to continue" DONE
fi

info "Installing pip..."
curl -Ls https://bootstrap.pypa.io/get-pip.py | sudo python

info "Installing battleschool..."
sudo pip install battleschool

info "... and we're done!\n
To run battleschool, execute the following command:
battle --config-file http://somesite/path/to/your/config.yml"
