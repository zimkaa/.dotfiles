#!/usr/bin/env bash

USED=$(df -P / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$USED" -gt 85 ]; then
  MESSAGE="⚠<fe0f> Диск почти заполнен!

Для очистки выполни:

1. Очистка Nix garbage
2. Сборка мусора Nix store
3. Очистка кэша pacman
4. Удаление orphan-пакетов"

  notify-send \
    -u critical \
    -a "Disk Cleanup" \
    -i drive-harddisk \
    "Мало места на диске" \
    "$MESSAGE"
fi
