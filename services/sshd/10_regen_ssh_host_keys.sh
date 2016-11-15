#!/bin/bash
set -e

if [[ ! -e /etc/service/30-sshd/disabled && ! -e /etc/ssh/keys/ssh_host_rsa_key ]] || [[ "$1" == "-f" ]]; then
	echo "No SSH host key available. Generating one..."
	export LC_ALL=C
	export DEBIAN_FRONTEND=noninteractive
	
	# Check if host keys are present, else create them
	if ! test -f /etc/ssh/keys/ssh_host_rsa_key; then
		ssh-keygen -q -f /etc/ssh/keys/ssh_host_rsa_key -N '' -t rsa
	fi

	if ! test -f /etc/ssh/keys/ssh_host_dsa_key; then
		ssh-keygen -q -f /etc/ssh/keys/ssh_host_dsa_key -N '' -t dsa
	fi

	if ! test -f /etc/ssh/keys/ssh_host_ecdsa_key; then
		ssh-keygen -q -f /etc/ssh/keys/ssh_host_ecdsa_key -N '' -t ecdsa
	fi

	if ! test -f /etc/ssh/keys/ssh_host_ed25519_key; then
		ssh-keygen -q -f /etc/ssh/keys/ssh_host_ed25519_key -N '' -t ed25519
	fi

fi
