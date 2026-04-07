#!/bin/bash

# validate mounted key
if [ ! -f /tmp/authorized_keys ]; then
    echo "ERROR: /tmp/authorized_keys not mounted!" >&2
    exit 1
fi

# add additional packages, default can be an existing package
if [[ -n "$ADDITIONAL_PACKAGES" ]]; then
    echo "Install additional packages: ${ADDITIONAL_PACKAGES}"
    apk add --no-cache ${ADDITIONAL_PACKAGES}
fi

# change ssh password for SSH - but we allow only login by key by default
RANDOM_PASSWORD=$(openssl rand -base64 64 | tr -d '\n')
echo "root:${RANDOM_PASSWORD}" | chpasswd

# prepare key login and copy the key from tmp folder
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cp /tmp/authorized_keys /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# generate required keys
ssh-keygen -A

# start ssh in foreground
/usr/sbin/sshd -D
