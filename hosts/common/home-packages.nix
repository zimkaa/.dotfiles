{ config, pkgs, username, stateVersion, ... }:
let
    packageNames = import ./packages.nix;
in {
    home.stateVersion = stateVersion;

    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.packages = (map (name: pkgs.${name}) packageNames);

    programs.home-manager.enable = true;
}
