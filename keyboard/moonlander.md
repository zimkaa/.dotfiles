# Info

[Keymapp \| zsa.io](https://www.zsa.io/keymapp)
[Linux install · zsa/wally Wiki · GitHub](https://github.com/zsa/wally/wiki/Linux-install#2-create-a-udev-rule-file)

## local drivers

### Install

- install drivers

```sh
sudo apt install libwebkit2gtk-4.1-0 libgtk-3-0 libusb-1.0-0
```

- create file `/etc/udev/rules.d/50-zsa.rules`

```sh
sudo touch /etc/udev/rules.d/50-zsa.rules
```

```sh
sudo tee /etc/udev/rules.d/50-zsa.rules > /dev/null << 'EOF'
# Rules for Oryx web flashing and live training
KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

# Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
EOF
```

```sh
sudo cat /etc/udev/rules.d/50-zsa.rules
```

- usergroup

```sh
groups | grep plugdev || sudo groupadd plugdev && sudo usermod -aG plugdev $USER
```

- cd to dir with file and do

```sh
chmod +x keymapp
```

- restart service

```sh
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=hidraw
```

### Upgrade firmware

<https://configure.zsa.io/moonlander/layouts/Ge46V/latest/4>

- Setup your settings [here](https://configure.zsa.io/moonlander/layouts/Ge46V/latest/4)

Example name: `zsa_moonlander_Ge46V_yo4Rrn_zimkaa.bin`

- open `keymapp`

```sh
sudo -E ~/install/Keyboard/keymapp-latest/keymapp
```

- section `flash` and select your actual firmware
- push the button on keyboard
- run renew script by type `t keybr_update`

```shell
rm ~/.dotfiles/keyboard/bins/old.bin --interactive=never || true && \
mv ~/.dotfiles/keyboard/bins/previous* ~/.dotfiles/keyboard/bins/old.bin && \
mv ~/.dotfiles/keyboard/bins/actual* ~/.dotfiles/keyboard/bins/previous.bin && \
mv ~/Downloads/zsa_moonlander_*_zimkaa.bin ~/.dotfites/keyboard/bins/actual.bin
```

## Online constructor

[Oryx: The ZSA Keyboard Configurator](https://configure.zsa.io/home)

Change here keys and download firmware
