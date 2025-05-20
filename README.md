# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```sh
sudo apt install git
```

### Nix [install](https://nixos.org/download/)

#### Linux

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

#### MacOS

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```sh
cd ~
git clone git@github.com:zimkaa/.dotfiles.git
cd .dotfiles
```

## Helpful info

### Tmux

#### Install

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

#### Reread conf

```sh
tmux source ~/.config/tmux/.tmux.conf
```

And install plugins

```sh
prefix + I
```

## Usage

### Configuration

#### MacOS conf

##### Switch

```sh
sudo darwin-rebuild switch --flake ~/.dotfiles/nix/darwin#macpro
```

##### Update

```sh
nix flake update --flake ~/.dotfiles/nix/darwin && sudo darwin-rebuild switch --flake ~/.dotfiles/nix/darwin#macpro
```

#### Linux `zimaa`

##### Switch `zimaa`

```sh
nix run --extra-experimental-features 'nix-command flakes' home-manager switch -- --flake /home/anton/.dotfiles#zimaa
```

##### Update `zimaa`

```sh
nix flake update --flake ~/.dotfiles && \
nix run --extra-experimental-features 'nix-command flakes' home-manager switch -- --flake /home/anton/.dotfiles#zimaa
```

#### Mint machine `honor`

```sh
nix run --extra-experimental-features 'nix-command flakes' home-manager switch -- --flake /home/anton//.#fdg
```

## See generations

```sh
sudo darwin-rebuild --list-generations
```

OR

```sh
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Rollback

#### MacOS generation

```sh
sudo darwin-rebuild switch --rollback
```

### Delete generation

```sh
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 133
```

## Old version with stow

Then use GNU stow to create symlinks

```sh
stow .
```

To force rewrite files

```sh
stow --adopt .
```

## Uninstall

### delete links

```sh
stow -D .
```

### delete stow

```sh
sudo apt remove stow
```
