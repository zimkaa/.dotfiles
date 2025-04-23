{
  description = "Zen Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
  } @ inputs: let
    configuration = {
      pkgs,
      config,
      ...
    }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = [
        pkgs.alejandra
        pkgs.bat
        pkgs.btop
        pkgs.cookiecutter
        pkgs.devbox
        pkgs.duf
        pkgs.dust
        pkgs.eza
        pkgs.fd
        pkgs.fzf
        pkgs.go
        pkgs.go-task
        pkgs.htop
        pkgs.lazydocker
        pkgs.lazygit
        pkgs.mkalias
        pkgs.neovim
        pkgs.nixd
        pkgs.obsidian
        pkgs.oh-my-posh
        pkgs.poetry
        pkgs.pyenv
        pkgs.ripgrep
        pkgs.rustup
        pkgs.stow
        pkgs.tldr
        pkgs.tmux
        pkgs.uv
        pkgs.vim
        pkgs.yazi
        pkgs.zoxide
      ];

      fonts.packages = [
        pkgs.nerd-fonts.fira-code
      ];

      # SudoTouchIdAuth for not enter password for sudo commands
      security.pam.services.sudo_local.touchIdAuth = true;

      system.defaults = {
        dock.autohide = true;
        #dock.persistent-apps = [
        #  ""
        #];
        dock.mru-spaces = true;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        # NSGlobalDomain.KeyRepeat = 2;
      };

      homebrew = {
        enable = true;
        brews = [
          "asitop"
          "mas"
          "ollama"
          "openssl@3"
          "pkg-config"
          "protobuf"
          "syncthing"
        ];
        casks = [
          "appcleaner"
          "bitwarden"
          "balenaetcher"
          "caffeine"
          "chatgpt"
          "cheatsheet"
          "dbeaver-community"
          "devpod"
          "devtoys"
          "discord"
          "firefox"
          "hiddenbar"
          "iina"
          "insomnia"
          "keycastr"
          "kitty"
          "maccy"
          "obs"
          "orbstack"
          # "postman"
          "rectangle"
          "royal-tsx"
          "stats"
          "termius"
          "the-unarchiver"
          "thunderbird"
          "visual-studio-code"
        ];
        masApps = {
          "hand mirror" = 1502839586;
          "outline-secure-internet-access" = 1356178125;
          "Telegram Lite" = 946399090;
          "Slack for Desktop" = 803453959;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true; # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."macpro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "antonzimin";
            # if already installed homebrew
            # autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macpro".pkgs;
  };
}
