#!/usr/bin/env bash
set -e
apt-get update && apt-get install -y sudo && apt-get clean
echo "lowpriv ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/allow-all
chmod 440 /etc/sudoers.d/allow-all