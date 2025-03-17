#!/bin/bash
set -o errexit
set -o pipefail
set -o noclobber
set -o nounset
set -o allexport

readonly NAME="tailscale"

install() {
    curl -fsSL https://tailscale.com/install.sh | sh
}

echo "Installing $NAME..."
install "$@"