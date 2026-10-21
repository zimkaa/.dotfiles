# Info

## nix service `clean_space_alert`

```sh
chmod +x /home/anton/.dotfiles/scripts/clean_space_alert.sh
```

Start service

```sh
systemctl --user daemon-reload
systemctl --user enable --now /clean_space_alert.timer
systemctl --user status clean_space_alert.timer
systemctl --user list-timers --all
```

Test start

```sh
systemctl --user start clean_space_alert.service
```
