# Syed's Dotfiles

My NixOS based dotfiles reside here. Very much a work in progress.

Features a flakes + home-manager based setup.

## Workflow

Make changes -> `./rebuild.sh` -> Repeat.

## Update Flake lock

```sh
nix flake update
```

## First time darwin

```sh
sudo nix run \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles#default
```
