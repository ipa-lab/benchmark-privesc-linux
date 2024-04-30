#!/bin/bash

# bring down everything again
echo "destroy test virtual machines"
vagrant destroy -f
echo "all done, check logs"
