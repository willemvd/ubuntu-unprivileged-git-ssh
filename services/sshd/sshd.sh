#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

SSHD_BUILD_PATH=/bd_build/services/sshd

## Install the SSH server.
$minimal_apt_get_install openssh-server ed

# setup openssh
sed -i "s/#\{0,1\}PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i 's/#\{0,1\}UsePrivilegeSeparation.*$/UsePrivilegeSeparation no/' /etc/ssh/sshd_config
sed -i 's/#\{0,1\}Port.*$/Port 2222/' /etc/ssh/sshd_config
sed -i 's/HostKey \/etc\/ssh\/ssh_host_\(.*\)$/HostKey \/etc\/ssh\/keys\/ssh_host_\1/' /etc/ssh/sshd_config
chmod 775 /var/run

useradd --system -s /bin/bash -u 99 -g 0 git # uid to replace later
mkdir -p /home/git/.ssh
chmod -R 770 /home/git/
chown -R git:root /home/git

chmod 775 /etc/ssh /home # keep writable for openshift user group (root)
chmod 660 /etc/ssh/sshd_config
chmod 664 /etc/passwd /etc/group # to help uid fix

mkdir /etc/service/30-sshd
cp $SSHD_BUILD_PATH/sshd.runit /etc/service/30-sshd/run

cp $SSHD_BUILD_PATH/00_update_git_user.sh /etc/my_init.d/
cp $SSHD_BUILD_PATH/10_regen_ssh_host_keys.sh /etc/my_init.d/

## Install default *AND INSECURE* SSH key
cp $SSHD_BUILD_PATH/keys/insecure_key.pub /etc/insecure_key.pub
cp $SSHD_BUILD_PATH/keys/insecure_key /etc/insecure_key
chmod 644 /etc/insecure_key*
cp $SSHD_BUILD_PATH/enable_insecure_key /usr/sbin/
