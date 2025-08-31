{
  description = "Syed's Nix{OS/Darwin} config flake";

  nixConfig = {
    extra-substituters = [ "https://nix-gaming.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];

    experimental-features = ["nix-command" "flakes"];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self, nixpkgs, nix-darwin, ... }@inputs:
     let
      system = "x86_64-linux";
      system-darwin = "aarch64-darwin";
     in
     {
       nixosConfigurations.default = nixpkgs.lib.nixosSystem {
         inherit system;
    
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.nixos-hardware.nixosModules.lenovo-ideapad-slim-5
          ];
        };

      darwinConfigurations.default = nix-darwin.lib.darwinSystem { 
        system = system-darwin;

        specialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/darwin/configuration.nix
          inputs.home-manager.darwinModules.default
        ];
      };
    };
}
