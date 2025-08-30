#/usr/bin/env sh


builder=$([[ $(uname) = "Darwin" ]] && echo "darwin-rebuild" || echo "nixos-rebuild")

sudo "$builder" switch --flake "$(pwd)#default"
