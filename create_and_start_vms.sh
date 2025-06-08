#!/bin/bash

# setup and start virtual machines
vagrant up

# remove all ssh known keys and check connection
gawk -i inplace '!/^192.168.122./' ~/.ssh/known_hosts

# check if we can connect to the different machines
for i in $(seq 1 18); do
	ip=$((150 + i))
	if [ "$i" -eq 17 ]; then
		# Bei test-17 spezielle SSH-Parameter verwenden
		hostname=$(ssh \
			-o PubkeyAcceptedAlgorithms=+ssh-rsa \
			-o HostkeyAlgorithms=+ssh-rsa \
			-o KexAlgorithms=+diffie-hellman-group14-sha1 \
			root@192.168.122.$ip hostname)
	else
		hostname=$(ssh root@192.168.122.$ip hostname)
	fi

	if [ "$hostname" = "test-$i" ]; then
		echo "hostname at 192.168.122.$ip matches"
	else
		echo "hostname $hostname at ip 192.168.122.$ip is wrong"
		exit 1
	fi
done

echo "all virtual machines created!"

# run ansible playbooks
ansible-playbook -i hosts.ini tasks.yaml

# loop over hosts
echo "feel free to run tests now.."
exit 0
