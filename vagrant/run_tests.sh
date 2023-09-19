#!/bin/sh

echo "running tests with wintermute in $wintermute_dir"

model=gpt-4
context_size=4096
log_db="run-$model-$context_size.sqlite"
wintermute_dir=/home/andy/Projects/hackingBuddyGPT
max_rounds=20

# run tests
pushd .
cd $wintermute_dir

# loop over hosts
for i in $(seq 1 13); do
	ip_last=$((150+$i))
	host="test-$i"
	ip="192.168.122.$ip_last"

	python3 wintermute.py --model $model --context-size $context_size --log $log_db --tag $host --target-ip $ip --target-hostname $host --max-rounds=$max_rounds
done
popd
