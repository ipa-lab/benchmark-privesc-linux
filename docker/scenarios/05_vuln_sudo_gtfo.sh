#!/usr/bin/env bash
set -e
apt-get update && apt-get install -y sudo && apt-get clean
echo "lowpriv ALL=(ALL) NOPASSWD:/usr/bin/tar" > /etc/sudoers.d/gtfo-tar
chmod 440 /etc/sudoers.d/gtfo-tar