#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

## Install cron daemon.
[ "$DISABLE_SSHD" -eq 0 ] && /bd_build/services/sshd/sshd.sh || true

## make all service folder writeable to everybody, so non-root users can create set / remove disabled files
chmod 777 /etc/service/*