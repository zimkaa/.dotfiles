{ inputs, outputs, config, lib, hostname, system, username, pkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  casksPckgs = import ./casks-packages.nix;
  commonPckgs = import ./gui-packages.nix;

  casks = commonPckgs ++ casksPckgs;
in {
  users.users.${username}.home = "/Users/${username}";

  system.primaryUser = username;

  nixpkgs = {
    config.allowUnfree = true;
    # The platform the configuration will be used on.
    hostPlatform = lib.mkDefault "${system}";
  };

  environment.systemPackages = with pkgs; [
    ## unstable
    # unstablePkgs.yt-dlp
    # unstablePkgs.get_iplayer
    # unstablePkgs.colmena

    ## stable CLI
    # pkgs.comma
    # pkgs.hcloud
    # pkgs.just
    # pkgs.lima
    # pkgs.nix
    neofetch
    mkalias
  ];

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.fira-mono
  ];

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    global.autoUpdate = true;

    brews = [
      "asitop"
      "mas"
      "ollama"  # service
      "openssl@3"
      "pkg-config"
      "protobuf"
      "syncthing"  # service
    ];
    casks = casks;
    masApps = {
      "hand mirror" = 1502839586;
      "outline-secure-internet-access" = 1356178125;
      "Telegram Lite" = 946399090;
      "Slack for Desktop" = 803453959;
    };
  };

  # Necessary for using flakes on this system.
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    channel.enable = false;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    # # TODO: FIX
    # enableCompletion = true;
    # promptInit = builtins.readFile ./../../data/mac-dot-zshrc;
  };

  # macOS configuration

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

  system.defaults = {
    dock.autohide = false;
    #dock.persistent-apps = [
    #  ""
    #];
    dock.mru-spaces = true;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;

    # NSGlobalDomain.AppleShowAllExtensions = true;
    # NSGlobalDomain.AppleShowScrollBars = "Always";
    # NSGlobalDomain.NSUseAnimatedFocusRing = false;
    # NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    # NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    # NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    # NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
    # NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    # NSGlobalDomain.ApplePressAndHoldEnabled = false;
    # NSGlobalDomain.InitialKeyRepeat = 25;
    # NSGlobalDomain.KeyRepeat = 2;
    # NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    # NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    # NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    # LaunchServices.LSQuarantine = false; # disables "Are you sure?" for new apps
    # loginwindow.GuestEnabled = false;
    # finder.FXPreferredViewStyle = "Nlsv";
  };

  # # TODO: find out how
  # # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;


  # TODO: Find out 

  # # pins to stable as unstable updates very often
  # nix.registry = {
  #   n.to = {
  #     type = "path";
  #     path = inputs.nixpkgs;
  #   };
  #   u.to = {
  #     type = "path";
  #     path = inputs.nixpkgs-unstable;
  #   };
  # };

  # programs.nix-index.enable = true;

  # # Keyboard
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = false;

  # system.defaults.CustomUserPreferences = {
  #     "com.apple.finder" = {
  #       ShowExternalHardDrivesOnDesktop = true;
  #       ShowHardDrivesOnDesktop = false;
  #       ShowMountedServersOnDesktop = false;
  #       ShowRemovableMediaOnDesktop = true;
  #       _FXSortFoldersFirst = true;
  #       # When performing a search, search the current folder by default
  #       FXDefaultSearchScope = "SCcf";
  #       DisableAllAnimations = true;
  #       NewWindowTarget = "PfDe";
  #       NewWindowTargetPath = "file://$\{HOME\}/Desktop/";
  #       AppleShowAllExtensions = true;
  #       FXEnableExtensionChangeWarning = false;
  #       ShowStatusBar = true;
  #       ShowPathbar = true;
  #       WarnOnEmptyTrash = false;
  #     };
  #     "com.apple.desktopservices" = {
  #       # Avoid creating .DS_Store files on network or USB volumes
  #       DSDontWriteNetworkStores = true;
  #       DSDontWriteUSBStores = true;
  #     };
  #     "com.apple.dock" = {
  #       autohide = false;
  #       launchanim = false;
  #       static-only = false;
  #       show-recents = false;
  #       show-process-indicators = true;
  #       orientation = "left";
  #       tilesize = 36;
  #       minimize-to-application = true;
  #       mineffect = "scale";
  #       enable-window-tool = false;
  #     };
  #     "com.apple.ActivityMonitor" = {
  #       OpenMainWindow = true;
  #       IconType = 5;
  #       SortColumn = "CPUUsage";
  #       SortDirection = 0;
  #     };
  #     "com.apple.Safari" = {
  #       # Privacy: don’t send search queries to Apple
  #       UniversalSearchEnabled = false;
  #       SuppressSearchSuggestions = true;
  #     };
  #     "com.apple.AdLib" = {
  #       allowApplePersonalizedAdvertising = false;
  #     };
  #     "com.apple.SoftwareUpdate" = {
  #       AutomaticCheckEnabled = true;
  #       # Check for software updates daily, not just once per week
  #       ScheduleFrequency = 1;
  #       # Download newly available updates in background
  #       AutomaticDownload = 1;
  #       # Install System data files & security updates
  #       CriticalUpdateInstall = 1;
  #     };
  #     "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
  #     # Prevent Photos from opening automatically when devices are plugged in
  #     "com.apple.ImageCapture".disableHotPlug = true;
  #     # Turn on app auto-update
  #     "com.apple.commerce".AutoUpdate = true;
  #     "com.googlecode.iterm2".PromptOnQuit = false;
  #     "com.google.Chrome" = {
  #       AppleEnableSwipeNavigateWithScrolls = true;
  #       DisablePrintPreview = true;
  #       PMPrintingExpandedStateForPrint2 = true;
  #     };
  # };
}
