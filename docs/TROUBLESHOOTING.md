# Info

## system

### `updates`

#### `The user systemd session is degraded:`

```sh
systemctl --user reset-failed
```

And rerun updates

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
