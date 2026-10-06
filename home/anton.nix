{ config, inputs, pkgs, lib, username, ... }:
{
  # 1. Включаем systemd-сервис ssh-agent для пользователя
  services.ssh-agent.enable = true;

  # Добавляем публичный ключ для входящих подключений в ~/.ssh/authorized_keys
  home.file.".ssh/authorized_keys" = {
    text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFaF3caKx1xi7anxnxJcUMZ8MjHTbHj9NyHZ7a4aYCoO zimkaa87@gmail.com
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDnDSqLgmB7MJaRqkg3EkoMAk+N86aMnEbO7iXBWr5VN zimkaa87@gmail.com
    '';
  };

  # 2. Настраиваем SSH и параметры агента
  programs.ssh = {
    enable = true;

    # Отключаем устаревшие дефолты Home Manager, как просит предупреждение
    enableDefaultConfig = false;

    # Включает импорт внешних файлов, если захотите вынести записи DevPod отдельно
    includes = [ "~/.ssh/my_conf/*" ];

    # Новая структура через settings
    settings = {
      "*" = {
        # Замена для устаревшего addKeysToAgent
        AddKeysToAgent = "yes";
        Compression = "no";
        ControlMaster = "no";
        ForwardAgent = "no";
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Замена для extraConfig IdentityAgent
        IdentityAgent = "/run/user/1000/ssh-agent";
      };
      "*.devpod" = {
        LocalForward = "3847 localhost:3847";
      };
    };
  };

  programs.hunk = {
    enable = true;
    enableGitIntegration = true; # Интеграция с вашим programs.git.enable = true;

    settings = {
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };

  programs.diff-so-fancy.enableGitIntegration = true;
  programs.git = {
    enable = true;
    settings = {
      user.email = "zimkaa87@gmail.com";
      user.name = "Anton Zimin";
      core = {
        editor = "vim";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "diff3";
        tool = "meld";
      };
      pull = {
        rebase = true;
      };
      push = {
        autoSetupRemote = true;
      };
    };
    lfs.enable = true;
  };

  # # test
  # programs.lazygit = {
  #   enable = true;
  #   settings = {
  #     git.pull.mode = "rebase";
  #   };
  # };

  # programs.htop = {
  #   enable = true;
  #   settings.show_program_path = true;
  # };

  # programs.lf.enable = true;

  # programs.starship = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   enableBashIntegration = true;
  #   settings = pkgs.lib.importTOML ./starship/starship.toml;
  # };

  programs.bash.enable = true;

  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autosuggestion.enable = true;
  #   #initExtra = (builtins.readFile ../mac-dot-zshrc);
  # };

  home.file = {
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.zshrc";
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.vimrc";
    ".config/cspell" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/cspell";
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/kitty";
      recursive = true;
    };
    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/ghostty";
      recursive = true;
    };
    ".config/ohmyposh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/ohmyposh";
      recursive = true;
    };
    ".config/tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/tmux";
      recursive = true;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/nvim";
      recursive = true;
    };
    ".config/yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/yazi";
      recursive = true;
    };
    ".config/kanata" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/kanata/linux";
      recursive = true;
    };
    ".config/markdownlint" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/markdownlint";
      recursive = true;
    };
    ".config/worktrunk" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/.config/worktrunk";
      recursive = true;
    };
  };

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata Keyboard Remapper";
      After = [ "graphical.target" ];
    };

    Service = {
      ExecStart = "${pkgs.kanata}/bin/kanata -c ${config.home.homeDirectory}/.config/kanata/kanata.kbd";
      Restart = "always";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/${toString config.home.uid}/podman/podman.sock";
  };

  systemd.user.sockets.podman = {
    Unit = {
      Description = "Podman Socket";
    };
    Socket = {
      ListenStream = "%t/podman/podman.sock";
      SocketMode = "0660";
    };
    Install = {
      WantedBy = [ "sockets.target" ];
    };
  };

  systemd.user.services.podman = {
    Unit = {
      Description = "Podman API Service";
    };
    Service = {
      ExecStart = "${pkgs.podman}/bin/podman system service --time=0";
    };
  };

  xdg.configFile."jesseduffield/lazydocker/config.yml".text = ''
    gui:
      scrollHeight: 2
    commandTemplates:
      dockerCompose: podman-compose # Или 'podman compose', если используешь встроенный
      restartService: 'podman-compose restart {{ .Service.Name }}'
      stopService: 'podman-compose stop {{ .Service.Name }}'
    customCommands:
      containers:
        - name: bash
          attach: true
          command: 'podman exec -it {{ .Container.ID }} /bin/sh'
          serviceNames: []
  '';

  xdg.configFile."containers/policy.json".text = ''
    {
      "default": [
        {
          "type": "reject"
        }
      ],
      "transports": {
        "containers-storage": {
          "": [
            {
              "type": "insecureAcceptAnything"
            }
          ]
        },
        "docker": {
          "docker.io": [
            {"type": "insecureAcceptAnything"}
          ],
          "ghcr.io": [
            {"type": "insecureAcceptAnything"}
          ],
          "mcr.microsoft.com": [
            {"type": "insecureAcceptAnything"}
          ]
        },
        "docker-archive": {
          "": [
            {"type": "insecureAcceptAnything"}
          ]
        },
        "oci-archive": {
          "": [
            {"type": "insecureAcceptAnything"}
          ]
        },
        "dir": {
          "": [
            {"type": "insecureAcceptAnything"}
          ]
        }
      }
    }
  '';

  xdg.configFile."containers/registries.conf".text = ''
    unqualified-search-registries = ["docker.io", "quay.io"]
  '';
  xdg.configFile."containers/containers.conf".text = ''
    [network]
    default_rootless_network_cmd = "pasta"
  '';
  # programs.kitty = {
  #   extraConfig = ''
  #     shell_integration disabled
  #     bold_font auto
  #   '';
  #   font.name = "FiraCode Nerd Font Mono";
  # };

  # programs.tmux = {
  #   enable = true;
  #   #keyMode = "vi";
  #   clock24 = true;
  #   historyLimit = 10000;
  #   plugins = with pkgs.tmuxPlugins; [
  #     gruvbox
  #     vim-tmux-navigator
  #   ];
  #   extraConfig = ''
  #     new-session -s main
  #     bind-key -n C-a send-prefix
  #   '';
  # };

  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  # programs.alacritty.enable = true;

  # programs.bat.enable = true;
  # programs.bat.config.theme = "Nord";
  #programs.zsh.shellAliases.cat = "${pkgs.bat}/bin/bat";

  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   plugins = with pkgs.vimPlugins; [
  #     ## regular
  #     comment-nvim
  #     lualine-nvim
  #     nvim-web-devicons
  #     vim-tmux-navigator

  #     ## with config
  #     # {
  #     #   plugin = gruvbox-nvim;
  #     #   config = "colorscheme gruvbox";
  #     # }

  #     {
  #       plugin = catppuccin-nvim;
  #       config = "colorscheme catppuccin";
  #     }

  #     ## telescope
  #     {
  #       plugin = telescope-nvim;
  #       type = "lua";
  #       config = builtins.readFile ./nvim/plugins/telescope.lua;
  #     }
  #     telescope-fzf-native-nvim

  #   ];
  #   extraLuaConfig = ''
  #     ${builtins.readFile ./nvim/options.lua}
  #     ${builtins.readFile ./nvim/keymap.lua}
  #   '';
  # };

  programs.zoxide.enable = true;

  # programs.ssh = {
  #   enable = true;
  #   extraConfig = ''
  # StrictHostKeyChecking no
  #   '';
  #   matchBlocks = {
  #     # ~/.ssh/config
  #     "github.com" = {
  #       hostname = "ssh.github.com";
  #       port = 443;
  #     };
  #     "*" = {
  #       user = "root";
  #     };
  #     # wd

  #     # lancs
  #     # "e elrond" = {
  #     #   hostname = "100.117.223.78";
  #     #   user = "alexktz";
  #     # };
  #     # # jb
  #     # "core" = {
  #     #   hostname = "demo.selfhosted.show";
  #     #   user = "ironicbadger";
  #     #   port = 53142;
  #     # };
  #     # "status" = {
  #     #   hostname = "hc.ktz.cloud";
  #     #   user = "ironicbadger";
  #     #   port = 53142;
  #     # };
  #   };
  # };
}
