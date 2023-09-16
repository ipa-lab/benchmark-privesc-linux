#!/bin/bash

for i in $(seq 1 11); do
	ip=$((150+$i))
	hostname=$(ssh root@192.168.122.$ip hostname)

	if [ "$hostname" = "test-$i" ]; then
		echo "hostname at 192.168.122.$ip matches"
	else
		echo "hostname $hostname at ip 192.168.122.$ip is wrong"
		exit -1
	fi
done
exit 0
