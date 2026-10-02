# Info

## data transfer

```sh
rsync -avzP -e "ssh -o PubkeyAuthentication=no -o IdentitiesOnly=yes" /home/what cachyos:/home/where
```

## `cachyos`

### `ghostty`

```sh
sudo pacman -S ghostty
```

### `niri`

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
