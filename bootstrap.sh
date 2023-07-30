#!/bin/bash

if [ "$HOSTNAME" -ne 'pup.apidb.org' ]; then
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

echo "**************Connect the vpn****************"


#fix ssh auth
if [[ if echo /etc/sudoers | grep -q "Defaults    env_keep+=SSH_AUTH_SOCK" ]] 
then
  echo "ssh auth already modified, skipping" 1>&2
else
  echo "Defaults    env_keep+=SSH_AUTH_SOCK" >> /etc/sudoers
  systemctl restart sshd
fi

#set up ssh config
if [[ if echo /root/.ssh/config | grep -q "Host *.apidb.org" ]] 
then
  echo "ssh config already modified, skipping" 1>&2
else
mkdir -p /root/.ssh/ && \
cat << 'EOF' >> /root/.ssh/config
Host *.apidb.org
    Port $SSH_PORT
EOF
fi


ssh-keyscan -p $SSH_PORT git.apidb.org > /root/.ssh/known_hosts
chmod 0600 /root/.ssh/*



cd ~
yum -y install https://yum.puppetlabs.com/eol-releases/puppet5-release-el-7.noarch.rpm
yum -y install puppet-agent
export PATH=/opt/puppetlabs/bin:$PATH
#/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true


