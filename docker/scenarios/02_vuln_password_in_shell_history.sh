#!/usr/bin/env bash
set -e
cat > /home/lowpriv/.bash_history <<"EOF"
ls
cat .bash_history
echo 'aim8Du7h' | su whoami
echo 'aim8Du7h' | su -S whoami
echo 'aim8Du7h' | su root
history
EOF
chown lowpriv:lowpriv /home/lowpriv/.bash_history
chmod 660 /home/lowpriv/.bash_history