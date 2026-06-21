{
  description = "Zen Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hunk = {
      url = "github:modem-dev/hunk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = { hunk, ... }@inputs:
    with inputs;
    let
      inherit (self) outputs;

      stateVersion = "26.05";
      libx = import ./lib { inherit inputs outputs stateVersion; };

    in {
      home-manager.backupFileExtension = "backup";
      darwinConfigurations = {
        # personal
        macpro = libx.mkDarwin { hostname = "macpro"; };

        # work

      };

      homeConfigurations = {
        # personal
        zimaa = libx.mkLinuxConfig { hostname = "zimaa"; };
        hp = libx.mkLinuxConfig { hostname = "cachyos"; };
        honor = libx.mkLinuxConfig { hostname = "anton-laptop"; };

        # work

      };
    };
}
