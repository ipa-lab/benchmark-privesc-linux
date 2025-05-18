#!/usr/bin/env bash
set -e
apt-get update && apt-get install -y sudo less man && apt-get clean
echo "lowpriv ALL=(ALL) NOPASSWD:/usr/bin/less, /usr/bin/man" > /etc/sudoers.d/gtfo-int
chmod 440 /etc/sudoers.d/gtfo-int