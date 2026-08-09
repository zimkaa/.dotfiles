{ config, pkgs, username, stateVersion, inputs, ... }:
let
    packageNames = import ./packages.nix;
    guiPackageNames = import ./gui-packages.nix;
    linuxGuiPackageNames = import ./linux-gui-packages.nix;

    stable-pkgs = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    stableList = [
        "dotenvx"
    ];

    nixVulkanIntel = inputs.nixgl.packages.${pkgs.system}.nixVulkanIntel;

    # Создаем обертку для zeditor
    zedWrapped = pkgs.symlinkJoin {
      name = "zeditor";
      paths = [ pkgs.zed-editor ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        # Переименовываем оригинальный бинарник в zeditor-orig,
        # а вместо zeditor создаем обертку, которая явно вызывает nixVulkanIntel и оригинальный бинарник
        mv $out/bin/zeditor $out/bin/zeditor-orig
        makeWrapper ${nixVulkanIntel}/bin/nixVulkanIntel $out/bin/zeditor \
        --add-flags "$out/bin/zeditor-orig"
      '';
    };
in {
    home.stateVersion = stateVersion;

    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.packages = map (name:
      if name == "zed-editor" then
        zedWrapped
      else if builtins.elem name stableList then 
        stable-pkgs.dotenvx
      else
        pkgs.${name}
    ) (packageNames ++ guiPackageNames ++ linuxGuiPackageNames);

    xdg.desktopEntries.zed = {
      name = "Zed";
      exec = "${zedWrapped}/bin/zeditor %F";
      icon = "zed";
      comment = "A high-performance, multiplayer code editor.";
      categories = [ "Development" "TextEditor" "IDE" ];
      mimeType = [ "text/plain" "text/markdown" ];
    };

    imports = [
      ./../../home/${username}.nix
      inputs.hunk.homeManagerModules.default
    ];

    programs.home-manager.enable = true;
}
