#!/bin/sh

if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
    ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key
fi

exec /usr/sbin/sshd -D
