{
  description = "NixOS config flake";

  nixConfig = {
    extra-substituters = [ "https://nix-gaming.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-vivaldi-fix.url = "github:SyedAhkam/nixpkgs/wrap-qt-app-vivaldi"; # temporary

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-gaming.url = "github:fufexan/nix-gaming";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-vivaldi-fix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay-vivaldi-fix = final: prev: {
        vivaldi-fix = import nixpkgs-vivaldi-fix {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };
        modules = [
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = [ overlay-vivaldi-fix ];
            }
          )

          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.nixos-hardware.nixosModules.lenovo-ideapad-slim-5
        ];
      };
    };
}
