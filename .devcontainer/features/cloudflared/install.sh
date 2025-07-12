#!/bin/bash
set -o errexit
set -o pipefail
set -o noclobber
set -o nounset
set -o allexport

readonly NAME="cloudflared"

install() {
  ARCH=$(arch)
  # Crude multi-os installation option
  VERSION=$(curl -s https://api.github.com/repos/cloudflare/cloudflared/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  if [ -x "/usr/bin/apt-get" ]
  then
    ARCH=$( [ "$ARCH" = "x86_64" ] && echo "amd64" || ( [ "$ARCH" = "aarch64" ] && echo "arm64" ) )
    curl -fsSL https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-linux-${ARCH}.deb -o /tmp/cloudflared.deb
    apt-get install -y \
        /tmp/cloudflared.deb
    rm -f /tmp/cloudflared.deb
    rm -rf /var/lib/apt/lists/*
  elif [ -x "/usr/bin/dnf" ]
  then
    curl -fsSL https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-linux-${ARCH}.rpm -o /tmp/cloudflared.rpm
    dnf install -y \
        /tmp/cloudflared.rpm
    dnf clean all \
    rm -rf /var/cache/yum \
    rm -f /tmp/cloudflared.rpm
  fi
}

echo "Installing $NAME..."
install "$@"
