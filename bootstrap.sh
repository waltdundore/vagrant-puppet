#!/bin/bash

if [ "$HOSTNAME" != "pup.apidb.org" ]; then
    printf '%s\n' "NO! Do not run this on the host. It is only to run in the vagrant guest."
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! -f .env ]
then
  export $(cat .env | xargs)
fi

echo
echo
echo
echo
echo "**************Connect the vpn****************"
echo
echo
echo
echo

#fix ssh auth
if grep -wq "env_keep+=SSH_AUTH_SOCK" /etc/sudoers;
then
  echo "No changes made, /etc/sudoers already updated" 
else    
  echo "Defaults    env_keep+=SSH_AUTH_SOCK" >> /etc/sudoers && \
  systemctl restart sshd
fi


if [ -d "/root/.ssh" ]  
then 
  echo "No changes made, /root/.ssh already exists"
else 
  mkdir -p /root/.ssh/
fi

#set up ssh config
if grep -wq "*.apidb.org" /root/.ssh/config;
then
  echo "No changes made /root/.ssh/config alreayd modified"
else
  echo "<<<=====Ignore this error, we are fixing this now."
  cat << 'EOF' >> /root/.ssh/config
  Host *.apidb.org
    Port $SSH_PORT
EOF
fi

if grep -wq "git.apidb.org" /root/.ssh/known_hosts;
then
  echo "No changes to known_hosts"
else
  echo "Updating known_hosts file"
  ssh-keyscan -p $SSH_PORT git.apidb.org > /root/.ssh/known_hosts
  chmod 0600 /root/.ssh/*
fi



cd ~
yum -y install /vagrant/scratch/repos/puppet5-release-el-7.noarch.rpm
yum -y install puppet-agent
export PATH=/opt/puppetlabs/bin:$PATH
#/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

