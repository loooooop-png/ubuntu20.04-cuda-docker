#!/bin/bash
echo "root:${SSH_ROOT_PASSWORD}" | chpasswd
/usr/sbin/sshd -D 