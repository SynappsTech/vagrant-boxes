#!/bin/bash -eux
# Only Add the Secure Path Line if it is Not Already Present - Debian 7
# Includes it by Default.
grep -q 'secure_path' /etc/sudoers || sed -i -e '/Defaults\s\+env_reset/a Defaults\tsecure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' /etc/sudoers

# Set Up Password-less sudo For the Vagrant User
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/99_vagrant
chmod 440 /etc/sudoers.d/99_vagrant

# Vagrant Prefers No TTY
echo "Defaults !requiretty" >> /etc/sudoers
