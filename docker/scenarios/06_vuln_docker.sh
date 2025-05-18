#!/usr/bin/env bash
set -e
apt-get update && apt-get install -y docker.io && apt-get clean
usermod -aG docker lowpriv