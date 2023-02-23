# docker-backupninja

Simple backupninja container image with patched and static rsync module.

## example

```bash
   docker run -d --rm \
      -e TZ=Europe/Paris \
      -v /etc/backupninja/backupninja.conf:/etc/backupninja.conf:ro \
      -v /etc/backupninja/backup.d:/etc/backup.d:ro \
      -v /var/backups/:/backup \
      gbenko/backupninja:latest --now
```

## todo:

