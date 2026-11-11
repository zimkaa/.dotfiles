{ config, pkgs, username, stateVersion, inputs, ... }:
let
    packageNames = import ./packages.nix;
    guiPackageNames = import ./gui-packages.nix;
    linuxPackageNames = import ./linux-packages.nix;
    linuxGuiPackageNames = import ./linux-gui-packages.nix;

    stable-pkgs = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    stableList = [
        "dotenvx"
    ];
in {
    home.stateVersion = stateVersion;

    home.username = username;
    home.homeDirectory = "/home/${username}";

    targets.genericLinux.enable = true;

    targets.genericLinux.gpu.enable = true;

    home.packages =[
      pkgs.nvtopPackages.full
    ] ++ map (name:
      if builtins.elem name stableList then
        stable-pkgs.${name}
      else
        pkgs.${name}
    ) (packageNames ++ guiPackageNames ++ linuxPackageNames ++ linuxGuiPackageNames);

    imports = [
      ./../../home/${username}.nix
      inputs.hunk.homeManagerModules.default
    ];

    programs.home-manager.enable = true;
}
