{ config, pkgs, username, stateVersion, ... }:
let
    packageNames = import ./packages.nix;
    guiPackageNames = import ./gui-packages.nix;
    linuxGuiPackageNames = import ./linux-gui-packages.nix;
in {
    home.stateVersion = stateVersion;

    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.packages = map (name: pkgs.${name}) (packageNames ++ guiPackageNames ++ linuxGuiPackageNames);

    imports = [ ./../../home/${username}.nix ];

    programs.home-manager.enable = true;
}
