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

#### Enable flakes

```sh
mkdir -p "$HOME/.config/nix/" && \
echo "experimental-features = nix-command flakes" | tee -a ~/.config/nix/nix.conf > /dev/null
```

#### MacOS

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

##### Enable flakes global

```sh
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf > /dev/null
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

### Nvim spelling

#### Install node

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

# Verify versions:
node -v # Should print "v24.10.0".
npm -v # Should print "11.6.1".
```

```sh
npm install -g cspell@latest
```

```sh
npm install -g @vlabo/cspell-lsp
```

Dictionary

```sh
```

## Usage

### Configuration

#### Clear old

```sh
nix-collect-garbage -d --delete-older-than 10d
```

```sh
home-manager expire-generations "-10 days"
```

#### MacOS conf

##### Switch

```sh
sudo darwin-rebuild switch --flake ~/.dotfiles#macpro
```

##### Update

```sh
nix flake update --flake ~/.dotfiles && \
sudo darwin-rebuild switch --flake ~/.dotfiles#macpro && \
rm -rf ~/.cache/oh-my-posh && \
source ~/.zshrc
```

#### Linux Arch `zimaa`

##### Switch `zimaa`

```sh
home-manager switch -b backup --flake ~/.dotfiles#zimaa
```

OR

```sh
nix run --extra-experimental-features 'nix-command flakes' home-manager switch -- -b backup --flake ~/.dotfiles#zimaa
```

##### Update `zimaa`

```sh
cd ~/.dotfiles && \
git pull && \
nix flake update --flake ~/.dotfiles && \
home-manager switch -b backup --flake ~/.dotfiles#zimaa
```

OR

```sh
cd ~/.dotfiles && \
git pull && \
nix flake update --flake ~/.dotfiles && \
nix run --extra-experimental-features 'nix-command flakes' home-manager switch -- -b backup --flake ~/.dotfiles#zimaa
```

#### Linux Mint `honor`

##### Switch `honor`

```sh
home-manager switch -b backup --flake ~/.dotfiles#honor
```

OR

```sh
nix run --extra-experimental-features 'nix-command flakes' home-manager switch -- -b backup --flake ~/.dotfiles#honor
```

##### Update `honor`

```sh
cd ~/.dotfiles && \
git pull && \
nix flake update --flake ~/.dotfiles && \
home-manager switch -b backup --flake ~/.dotfiles#honor
```

OR

```sh
cd ~/.dotfiles && \
git pull && \
nix flake update --flake ~/.dotfiles && \
nix run --extra-experimental-features 'nix-command flakes' home-manager switch -- -b backup --flake ~/.dotfiles#honor
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

#### Linux generation

```sh
home-manager switch --rollback
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
