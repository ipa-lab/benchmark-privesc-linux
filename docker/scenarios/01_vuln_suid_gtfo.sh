#!/usr/bin/env bash
set -e

apt-get update && apt-get install -y python-is-python3 && apt-get clean
chmod u+s /usr/bin/find /usr/bin/python /usr/bin/python3 /usr/bin/python3.11