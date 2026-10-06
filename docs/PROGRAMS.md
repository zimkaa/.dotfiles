# Info

## `devpod`

add to config `~/.devpod/config.yaml`

```diff
contexts:
  default:
    defaultProvider: podman
+   options:
+     SSH_CONFIG_PATH:
+       value: /home/anton/.ssh/my_conf/devpod.conf
```

## `kanata`

```sh
sudo groupadd --system uinput 2>/dev/null || true
sudo usermod -aG input,uinput $USER
sudo modprobe uinput
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | \
sudo tee /etc/udev/rules.d/99-input.rules > /dev/null
sudo udevadm control --reload-rules && sudo udevadm trigger
```

## `voxtype`

### install

```sh
sudo pacman -S --noconfirm wtype rustup alsa-lib clang cmake pkgconf
git clone https://github.com/peteonrails/voxtype ~/install/voxtype
cd ~/install/voxtype
cargo build --release
sudo install -Dm755 target/release/voxtype /usr/local/bin/voxtype
voxtype setup systemd
voxtype setup check
```

Then configure voxtype driver_order mode:

```sh
/home/anton/.config/voxtype/config.toml
```

```diff
[hotkey]
- key = "SCROLLLOCK"
+ key = "RIGHTCTRL"
+ modifiers = ["RIGHTALT"]

[whisper]
- language = "en"
+ language = ["en", "ru"]

[output]
+ driver_order = ["wtype"]
```

restart service

```sh
systemctl --user restart voxtype
```

### hotkeys

<https://voxtype.io/docs/CONFIGURATION#hotkey>

## `syncthing`

```sh
systemctl --user status syncthing.service
```

### English

#### 1. Configure the client via Web UI

Open the Web UI and go to:

**Settings → GUI**

Create a username and password for authentication.

```text
https
```

#### 2. Add a new remote host on the `server`

Go to the server and add a new remote host.

#### 3. Get the device ID

On the client device, open:

**Actions → Show ID**

Copy the displayed device ID.

#### 4. Add the device to the server

Paste the copied device ID into the corresponding field on the server when adding the new remote host.

#### 5. Share a folder

After the device has been added, share the required folder with the new device.

### Русская версия

#### 1. Настройте клиент через Web UI

Откройте Web UI и перейдите в:

**Settings → GUI**

Измените протокол на:

```text
https
```

Создайте имя пользователя и пароль для аутентификации.

#### 2. Добавьте новый удалённый хост на сервере

Перейдите на сервер и добавьте новый удалённый хост.

#### 3. Получите ID устройства

На клиентском устройстве откройте:

**Actions → Show ID**

Скопируйте отображаемый ID устройства.

#### 4. Добавьте устройство на сервере

Вставьте скопированный ID устройства в соответствующее поле при добавлении нового удалённого хоста на сервере.

#### 5. Расшарьте папку

После добавления устройства расшарьте нужную папку с новым устройством.
