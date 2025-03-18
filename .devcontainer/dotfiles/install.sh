#!/bin/bash
set -o errexit
set -o pipefail
set -o noclobber
set -o nounset
set -o allexport

readonly NAME="dotfiles"

install() {
    curl -fsSL https://dotfiles.gbraad.nl/install.sh -o /usr/bin/install-dotfiles
    chmod +x /usr/bin/install-dotfiles
}

echo "Installing $NAME..."
install "$@"