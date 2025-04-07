#!/bin/bash
set -o errexit
set -o pipefail
set -o noclobber
set -o nounset
set -o allexport

readonly NAME="dotfiles"

installuser() {
    if [ "$_REMOTE_USER" = "root" ]; then
        echo "Detected root to be the remote user - exiting ${NAME} installation."
        return
    fi
    if ! id "$_REMOTE_USER"; then
        echo "User does not exist - exiting ${NAME} installation."
        return
    fi

    commands="rm -rf ~/.oh-my-zsh ~/.zshrc ; \
        git clone https://github.com/gbraad-dotfiles/upstream.git ~/.dotfiles --depth 2 \
            && cd ~/.dotfiles \
            && bash ./install.sh"

    su - $_REMOTE_USER -c "${commands}" \
        && chsh -s /usr/bin/zsh $_REMOTE_USER
}

installroot() {
    rm -rf ~/.oh-my-zsh ~/.zshrc
    git clone https://github.com/gbraad-dotfiles/upstream.git ~/.dotfiles --depth 2 \
        && cd ~/.dotfiles \
        && . ./zsh/.zshrc.d/dotfiles.zsh \
        && stow config \
        && dotfiles restow \
        && chsh -s /usr/bin/zsh
}

install() {
    installuser
    installroot
}

echo "Installing ${NAME}..."
install "$@"
