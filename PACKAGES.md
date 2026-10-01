# Info

## Install

### `voxtype`

```sh
wget -P ~/install/ https://github.com/peteonrails/voxtype/releases/download/v1.0.1/voxtype_1.0.1-1_amd64.deb
sudo apt install ~/install/voxtype_1.0.1-1_amd64.deb
```

Enable gpu acceleration

```sh
sudo voxtype setup gpu --enable && \
systemctl --user restart voxtype
```

```sh
sudo apt install -y ydotool libxkbcommon-dev xclip
git clone https://git.sr.ht/~geb/dotool
cd dotool && ./build.sh && sudo cp dotool /usr/local/bin/
```

Then configure voxtype driver_order mode:

```sh
/home/anton/.config/voxtype/config.toml
```

```text
[whisper]
language = ["en", "ru"]

[output]
driver_order = ["dotool"]
```

#### hotkeys

<https://voxtype.io/docs/CONFIGURATION#hotkey>
