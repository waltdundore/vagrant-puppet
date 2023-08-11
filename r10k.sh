#!/bin/bash

# Install r10k
dnf -y install git ruby ruby-devel redhat-rpm-config
gem install rubygems-update
gem update --system
gem install rake
gem install rspec
gem install yard
gem install r10k -v 3.15.4

# r10k not in path by default
if ! grep -q "export PATH=" /root/.bashrc; then
  echo "export PATH=\$PATH:/usr/local/bin" >> /root/.bashrc
fi

# Temporary fix for broken hiera on vm
#GLOBAL_HIERA=/etc/puppetlabs/puppet/hiera.yaml
#sed -i '/  - common/{N; /\n  - users$/b; s/\n/\n  - users\n/}' $GLOBAL_HIERA
