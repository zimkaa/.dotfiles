{ inputs, pkgs, ... }:
let
    packageNames = import ./packages.nix;
in {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = (map (name: pkgs.${name}) packageNames);
}
