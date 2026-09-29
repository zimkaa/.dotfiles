# Info

## data transfer

```sh
rsync -avzP -e "ssh -o PubkeyAuthentication=no -o IdentitiesOnly=yes" /home/what cachyos:/home/where
```

## ssh connection

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
