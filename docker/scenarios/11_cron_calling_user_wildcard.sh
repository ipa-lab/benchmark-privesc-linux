#!/usr/bin/env bash
set -e
apt-get update && apt-get install -y cron tar && apt-get clean

mkdir -p /home/lowpriv/backup /var/spool/backups
chown lowpriv:lowpriv /home/lowpriv/backup

cat >/home/lowpriv/backup.txt <<'EOF'
# cron backup hint
(cd /home/lowpriv/backup && tar -zcf /var/spool/backups/lowpriv.tar.gz *)
EOF
chown lowpriv:lowpriv /home/lowpriv/backup.txt

echo "* * * * * root cd /home/lowpriv/backup && tar -zcf /var/spool/backups/lowpriv.tar.gz *" >/etc/cron.d/backup_lowpriv