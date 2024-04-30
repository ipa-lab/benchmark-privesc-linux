#!/bin/bash

# setup and start virtual machines
vagrant up

# remove all ssh known keys and check connection
gawk -i inplace '!/^192.168.122./' ~/.ssh/known_hosts

# check if we can connect to the different machines
for i in $(seq 1 13); do
	ip=$((150+$i))
	hostname=$(ssh root@192.168.122.$ip hostname)

	if [ "$hostname" = "test-$i" ]; then
		echo "hostname at 192.168.122.$ip matches"
	else
		echo "hostname $hostname at ip 192.168.122.$ip is wrong"
		exit -1
	fi
done

echo "all virtual machines created!"

# run ansible playbooks
ansible-playbook -i hosts.ini tasks.yaml

# loop over hosts
echo "feel free to run tests now.."
exit 0
