#!/bin/bash

counter=40

export ANSIBLE_HOST_KEY_CHECKING=False

for i in scenarios/*.yaml; do

	echo "starting vm for $i"

	vm="$(virter vm run --id $counter --wait-ssh debian-12 --name benchmark-$counter)"
	echo "vm is $vm"

	ansible-playbook basic.yaml -i $vm,  --private-key ~/.config/virter/id_rsa -u root
	ansible-playbook $i -i $vm,  --private-key ~/.config/virter/id_rsa -u root

	counter=$((counter+1))
done
