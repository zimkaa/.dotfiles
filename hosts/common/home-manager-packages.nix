{ config, pkgs, username, stateVersion, inputs, ... }:
let
    packageNames = import ./packages.nix;
    guiPackageNames = import ./gui-packages.nix;
    linuxGuiPackageNames = import ./linux-gui-packages.nix;

    stable-pkgs = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    stableList = [
        "dotenvx"
    ];
in {
    home.stateVersion = stateVersion;

    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.packages = map (name:
      if builtins.elem name stableList
      then stable-pkgs.dotenvx
      else pkgs.${name}
    ) (packageNames ++ guiPackageNames ++ linuxGuiPackageNames);

    imports = [ ./../../home/${username}.nix ];

    programs.home-manager.enable = true;
}
