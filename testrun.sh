#!/bin/bash

wintermute_dir=/home/andy/Projects/hackingBuddyGPT
model='gpt4'
context_size='8192'
log_db="run_${model}_${context_size}.sqlite3"

# setup and start virtual machines
pushd .
cd vagrant
vagrant up

# remove all ssh known keys and check connection
gawk -i inplace '!/^192.168.122./' ~/.ssh/known_hosts
./check_ssh_connection.sh

if [$? -eq 0]; then
	echo "virtual machines created!"
else
	echo "wasn't able to bring up virtual machines"
	exit -1
fi
popd


# run ansible playbooks
ansible-playbook -i hosts.ini tasks.yaml

# run tests
pushd .
cd $wintermute_dir

# loop over hosts
for i in $(seq 1 11); do
	ip_last=$((150+$i))
	host="test-$i"
	ip="192.168.122.$ip_last"

	python3 wintermute.py --model $model --context-size $context_size --log $log_db --tag $host --target-ip $ip --target-hostname $host
done
popd

# bring down everything again
echo "destroy test virtual machines"
pushd .
cd vagrant
vagrant destroy -f
popd

echo "all done, check logs in $log_db"