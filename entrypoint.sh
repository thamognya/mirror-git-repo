#!/bin/sh
set -e
mkdir -p /root/.ssh
echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
echo "WARNING: StrictHostKeyChecking disabled"
echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true
sh -c "/mirror.sh $*"
