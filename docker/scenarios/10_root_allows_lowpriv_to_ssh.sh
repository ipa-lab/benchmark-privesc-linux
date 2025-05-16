#!/usr/bin/env bash
set -e
runuser -l lowpriv -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa"
mkdir -p /root/.ssh
cat /home/lowpriv/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys