# docker-backupninja

Simple backupninja container image with patched and static rsync module.

- copy:
    - `backupninja/`: This is the backupninja execute folder. Place of the your custom or overwrited module. (`/usr/share/backupninja`)
- volume:
    - `/config`: Config directory (`backupninja.conf` and `backup.d` folders).
    - `/backup`: Backup target directory (example: `/var/backups/servers` on host).
- link:
    - `/config/.ssh/`: If this exists, then automatic link to the root ssh client folder (`/root/.ssh`).
    - `/config/backup.d/`: If this exists (recommended :) ), then automatic link to the default backupninja module's config directory (`/etc/backup.d`).

## example

```bash
   docker run -d --rm \
      -e PUID=0 \
      -e PGID=0 \
      -e TZ=Europe/Paris \
      -v /home/etc/backupninja/:/config \
      -v /var/backups/:/backup \
      gbenko/backupninja
```

## todo:

