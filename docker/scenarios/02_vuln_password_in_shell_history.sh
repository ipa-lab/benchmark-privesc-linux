#!/usr/bin/env bash
set -e
cat > /home/lowpriv/.bash_history <<"EOF"
ls
cat .bash_history 
echo 'aim8Du7h' | su whoami
echo 'aim8Du7h' | su -S whoami
echo 'aim8Du7h' | su - ls
echo 'aim8Du7h' | su root
expect
sudo apt install expect
su
expect -c 'spawn ssh root@127.0.0.1 ; expect "password:"; send "aim8Du7h\r"; interact'
history
sshpass -p aim8Du7h ssh root@localhost
history
exit
EOF
chown lowpriv:lowpriv /home/lowpriv/.bash_history
chmod 660 /home/lowpriv/.bash_history