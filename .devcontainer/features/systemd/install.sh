#!/bin/bash
set -o errexit
set -o pipefail
set -o noclobber
set -o nounset
set -o allexport

readonly NAME="systemd"

install_requirements() {
  APTPKGS="systemd init"
  RPMPKGS="systemd"

  # Crude multi-os installation option
  if [ -x "/usr/bin/apt-get" ]
  then
    apt-get update
    apt-get install -y $APTPKGS
  elif [ -x "/usr/bin/dnf" ]
  then
    dnf install -y $RPMPKGS
  fi
}


install() {
    install_requirements
}

echo "Installing $NAME..."
install "$@"
