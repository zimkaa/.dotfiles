# Info

## system

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
