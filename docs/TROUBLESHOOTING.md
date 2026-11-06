# Info

## system

### `nix home-manager` update

If you see these lines, do that

```sh
This non-NixOS system is not yet set up to use the GPU
with Nix packages. To set up GPU drivers, run
  sudo /nix/store/mh26rsim0zzaizcp2d5fkbxxj1hqlvpf-non-nixos-gpu/bin/non-nixos-gpu-setup
```

### `obsidian`

#### black window

```sh
rm -rf ~/.config/obsidian/"Code Cache"
```

### `pacman`

```text
:: Synchronizing package databases...
error: failed to synchronize all databases (unable to lock database)
```

```sh
pgrep -a pacman; pgrep -a paru; pgrep -a yay
```

if empty then

```sh
sudo rm /var/lib/pacman/db.lck
sudo pacman -Syu
```

Look at errors ...

### `OOMkill`

#### noctalia

##### reload

Need start only inside pure terminal not in `tmux`

```sh
pkill "noctalia"
niri msg action spawn -- noctalia
```

##### sound

```sh
enable_power_sounds = true   # sound on charger connect/disconnect
```

### sudo password

Fix line

```sh
sudo vim /etc/security/faillock.conf
```

```text
deny = 8
```

Restart

```sh
faillock --user anton --reset
```

Optional

```sh
systemctl --user reset-failed
```

### `ssh` known hosts

Remove old key

Example

```sh
ssh-keygen -R "[cachyos.local]:2222"
```
