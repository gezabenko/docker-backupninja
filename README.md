# docker-backupninja

Simple backupninja container image with patched and static rsync module.

- copy:
    - etc/ -> Config folder (/etc/backupninja.conf; /etc/backup.d).
    - backupninja/ -> backupninja execute folder (/usr/share/backupninja).
- volume:
    - /backup -> Backup directory (/var/backups/servers).
- link:
    - etc/.ssh/ -> root ssh client folder (/root/.ssh).

