#!/bin/bash -eux

apt-get update
apt-get -y update

# Ensure the Correct Kernel Headers Are Installed
apt-get -y install linux-headers-$(uname -r)

# Update Package Index on Boot
cat <<EOF > /etc/init/refresh-apt.conf
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

# Install Curl to Fix Broken wget While Retrieving Content From Secured Sites
apt-get -y install curl

# Install rsync
apt-get -y install rsync
