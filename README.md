# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```sh
sudo apt install git
```

### Stow

```sh
sudo apt install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```sh
cd ~
git clone git@github.com:zimkaa/.dotfiles.git
cd .dotfiles
```

then use GNU stow to create symlinks

```sh
stow .
```

to force rewrite files

```sh
stow --adopt .
```

## Helpful info

### Reread tmux config

```sh
tmux source ~/.tmux.conf
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
