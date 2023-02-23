# docker-alpine-backupninja

Alpine base docker image to use backupninja.

## Quick start

```bash
docker run --rm --name backupninja \
  -e TZ=Europe/Budapest \
  -v $(PWD)/config/backupninja.conf:/usr/local/etc/backupninja.conf:ro \
  -v $(PWD)/config/backup.d:/usr/local/etc/backup.d:ro \
  -v $(PWD)/config/ssh:/root/.ssh:ro \
  -v /var/backups:/backup \
  gbenko/backupninja --now
```

## docker-compose

```yaml
---
version: "3.8"

services:
  backupninja:
    image: gbenko/backupninja-alpine:latest
    environment:
      # Add timezone
      - TZ=Europe/Budapest
    volumes:
      # The main backupninja file:
      - ./config/backupninja.conf:/usr/local/etc/backupninja.conf:ro
      # The backupninja jobs folder:
      - ./config/backup.d:/usr/local/etc/backup.d:ro
      # The root ssh folder:
      - ./config/ssh:/root/.ssh:ro
      # (Optional) The msmtprc file:
      - ./config/msmtprc:/etc/msmtprc:ro
      # Location of backups:
      - /var/backups:/backup
      # (Optional) Location of log file:
      - ./log/backupninja.log:/usr/local/var/log/backupninja.log
```

