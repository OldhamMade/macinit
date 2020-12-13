# macinit

A small script which you can execute to set up basic tools useful for a
freshly-installed mac.

Specifically, it installs the following:

- The xcode command line tools
- homebrew, the "missing package manager for OS X"

## Usage

To start, run the following in a terminal:

    $ curl -Ls https://raw.github.com/OldhamMade/macinit/master/init.sh | sh

## Next steps

Personally I use ansible to manage software installation on my machine.

I do this by first installing dropbox:

    $ brew install ansible dropbox
    $ open /Applications/Dropbox.app

Once it is set-up (unfortunately a very manual process to sign in,
configure settings, and activate local syncing), I can then run:

    $ ansible-playbook ~/Dropbox/ansible/playbook.yml
