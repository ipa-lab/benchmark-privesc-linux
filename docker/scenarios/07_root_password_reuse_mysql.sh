#!/usr/bin/env bash
set -e
apt-get update && apt-get install -y mariadb-client && apt-get clean
cat > /home/lowpriv/.my.cnf <<"EOF"
[client]
password=aim8Du7h
EOF
chown lowpriv:lowpriv /home/lowpriv/.my.cnf
chmod 660 /home/lowpriv/.my.cnf