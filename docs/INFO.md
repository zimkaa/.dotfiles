# Info

## data transfer

```sh
rsync -avzP -e "ssh -o PubkeyAuthentication=no -o IdentitiesOnly=yes" /home/what cachyos:/home/where
```

## `cachyos`

### Init scritp

```sh
sudo pacman -S --noconfirm ghostty zsh cachyos-zsh-config
sudo pacman -S --needed --noconfirm sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg qt6-imageformats
chsh -s $(which zsh)
sudo pacman -S --noconfirm ttf-firacode-nerd
fc-cache -fv
mkdir -p ~/install/
mkdir -p ~/all_notes/
cd ~/install/
git clone git@github.com:uiriansan/SilentSDDM.git
cd ~/install/SilentSDDM
sudo mkdir -p /usr/share/sddm/themes/silent
sudo cp -rf . /usr/share/sddm/themes/silent/
sudo cp -r /usr/share/sddm/themes/silent/fonts/* /usr/share/fonts/
sudo cp -f /etc/sddm.conf /etc/sddm.conf.bkp
printf "[Theme]\nCurrent=silent\n" | sudo tee -a /etc/sddm.conf > /dev/null
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
mkdir -p "$HOME/.config/nix/" && \
cp ~/.config/nix/nix.conf "~/.config/nix/nix.conf.bak_$(date +%Y%m%d_%H%M%S)"
echo "experimental-features = nix-command flakes" | tee -a ~/.config/nix/nix.conf > /dev/null
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
nix-channel --update && \
nix run home-manager switch -- -b backup --flake ~/.dotfiles#zimkaa && \
nix flake update --flake ~/.dotfiles && \
home-manager switch -b backup --flake ~/.dotfiles#zimkaa
mkdir -p ~/Pictures/screenshot
cp ~/.config/niri/cfg/misc.kdl ~/.config/niri/cfg/misc.kdl.bak_$(date +%Y%m%d_%H%M%S)
sed -i -E 's|^([[:space:]]*screenshot-path).*|\1 "~/Pictures/screenshot/Screenshot_%Y-%m-%d:%H-%M-%S.png"|' ~/.config/niri/cfg/misc.kdl
cp ~/.config/niri/cfg/keybinds.kdl ~/.config/niri/cfg/keybinds.kdl.bak_$(date +%Y%m%d_%H%M%S)
sed -i '/Mod+Return.*hotkey-overlay-title/ { r ./scripts/niri/keybinds.kdl
d; }' ~/.config/niri/cfg/keybinds.kdl
cp ~/.config/niri/cfg/rules.kdl ~/.config/niri/cfg/rules.kdl.bak_$(date +%Y%m%d_%H%M%S)
cat ~/.dotfiles/scripts/niri/rules.kdl | sudo tee -a ~/.config/niri/cfg/rules.kdl > /dev/null
cp ~/.config/niri/cfg/input.kdl ~/.config/niri/cfg/input.kdl.bak_$(date +%Y%m%d_%H%M%S)
cat ~/.dotfiles/scripts/niri/input.kdl | sudo tee ~/.config/niri/cfg/input.kdl > /dev/null
tmux source ~/.config/tmux/tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins
~/.tmux/plugins/tpm/bin/update_plugins all
```

### `kanata`

```sh
sudo groupadd --system uinput 2>/dev/null || true
sudo usermod -aG input,uinput $USER
sudo modprobe uinput
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | \
sudo tee /etc/udev/rules.d/99-input.rules > /dev/null
sudo udevadm control --reload-rules && sudo udevadm trigger
```

### Terminal `ghostty` and Shell `zsh`

```sh
sudo pacman -S ghostty zsh cachyos-zsh-config
chsh -s $(which zsh)
```

### `niri`

#### `Simple Desktop Display Manager` config [SDDM](https://github.com/uiriansan/SilentSDDM)

```sh
mkdir -p ~/install/
cd ~/install/
sudo pacman -S --needed sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg qt6-imageformats --noconfirm
git clone git@github.com:uiriansan/SilentSDDM.git
cd ~/install/SilentSDDM
sudo mkdir -p /usr/share/sddm/themes/silent
sudo cp -rf . /usr/share/sddm/themes/silent/
sudo cp -r /usr/share/sddm/themes/silent/fonts/* /usr/share/fonts/
sudo cp -f /etc/sddm.conf /etc/sddm.conf.bkp
sudo vim /etc/sddm.conf
```

Add this

```text
[Theme]
Current=silent
```

#### startup windows

Edit config `~/.config/niri/cfg/rules.kdl`

```text
    spawn-at-startup "Telegram"
    spawn-at-startup "firefox"

    workspace "telegram"

    // Telegram отправляем на 1-й рабочий стол
    window-rule {
        match app-id="org.telegram.desktop"
        open-on-workspace "telegram"
        open-maximized true
    }

    workspace "browser"
    // Firefox
    window-rule {
        match app-id="firefox"
        open-on-workspace "browser"
        open-maximized true
    }

    // Obsidian
    window-rule {
        match app-id="obsidian"
        open-maximized true
    }
```

#### fonts

```sh
sudo pacman -S ttf-firacode-nerd
fc-cache -fv
```

#### screenshots

```sh
mkdir -p ~/Pictures/screenshot
```

Need to file `~/.config/niri/cfg/misc.kdl` replace `screenshot-path`

```text
screenshot-path "~/Pictures/screenshot/Screenshot_%Y-%m-%d:%H-%M-%S.png"
```

#### terminal `~/.config/niri/cfg/keybinds.kdl`

```text
    // Mod+Return                          hotkey-overlay-title="Open Terminal: Alacritty" { spawn "alacritty"; }
    Mod+Return                          hotkey-overlay-title="Open Terminal: Ghostty" { spawn "ghostty"; }
```

#### config text input `~/.config/niri/cfg/input.kdl`

```text
input {
    keyboard {
        xkb {
            //If you want to overwrite your keyboard layout,
            // uncomment the line below and change the layout accordingly.
            //layout "us" // Use the American keyboard layout
        layout "us,ru"

        options "grp:alt_shift_toggle"
        }
        numlock // Enable numlock on startup
    }

    touchpad {
        tap // Enable tap-to-click
        natural-scroll // Enable natural (macOS-style) scrolling
    }

    mouse {
        // If you want to disable Mouse Acceleration,
        // uncomment the lines below.
        //accel-profile "flat"
        //accel-speed 0.0
    }

    focus-follows-mouse // Automatically focus windows under the mouse pointer
    workspace-auto-back-and-forth // Enable workspace back & forth switching
}
```

### ssh connection

```sh
sudo vim /etc/ssh/sshd_config
```

Add this:

```text
PubkeyAuthentication yes

# AuthorizedKeysFile    .ssh/authorized_keys
AuthorizedKeysFile .ssh/authorized_keys_static
```

```sh
cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys_static && \
chown 0600 ~/.ssh/authorized_keys_static
```
