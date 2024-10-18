#!/bin/sh

hosts=`virter network list-attached vagrant-libvirt | grep ^benchmark | cut -f 1 -d \  `

echo "deleting the following virtual machines: "
echo "$hosts"

read  -n 1 -p "Press y to continue " answer

if [ "$answer" = "y" ]; then
	echo ""
	echo "deleting VMs"

	for i in $hosts; do
		virter vm rm $i
	done
else
	echo ""
	echo "Not deleting anything"
fi
