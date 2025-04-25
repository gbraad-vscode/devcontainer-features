#!/bin/bash
set -o errexit
set -o pipefail
set -o noclobber
set -o nounset
set -o allexport

readonly NAME="ssh-keys"

installuser() {
    if [ "$_REMOTE_USER" = "root" ]; then
        echo "Detected root to be the remote user - exiting ${NAME} installation."
        return
    fi
    if ! id "$_REMOTE_USER"; then
        echo "User does not exist - exiting ${NAME} installation."
        return
    fi

    commands="mkdir -p ~/.ssh/ \
       && curl https://github.com/${USERNAME}.keys | tee -a ~/.ssh/authorized_keys"

    su - $_REMOTE_USER -c "${commands}"
}

install() {
    installuser
}

echo "Installing ${NAME}..."
install "$@"
