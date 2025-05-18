{ inputs, pkgs, ... }:
{
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # # nixpkgs-unstable.legacyPackages.${pkgs.system}.beszel
    # # nixpkgs-unstable.legacyPackages.${pkgs.system}.talosctl
    # nixpkgs.legacyPackages.${pkgs.system}.talosctl

    air  # for GO develop
    alejandra
    bat
    btop
    cookiecutter
    devbox
    duf
    dust
    eza
    fd
    fzf
    go
    go-task
    htop
    httpie
    lazydocker
    lazygit
    mkalias
    neovim
    nixd
    obsidian
    oh-my-posh
    poetry
    pyenv
    ripgrep
    rustup
    stow
    templ  # LSP for GO develop
    tldr
    tmux
    uv
    vim
    yazi
    zoxide

    # # requires nixpkgs.config.allowUnfree = true;
    # vscode-extensions.ms-vscode-remote.remote-ssh
  ];
}
