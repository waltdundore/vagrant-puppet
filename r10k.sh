#!/bin/bash

# Install r10k
yum install ruby git -y
/opt/puppetlabs/puppet/bin/gem install multipart-post -v 2.2.0
/opt/puppetlabs/puppet/bin/gem install r10k -v 2.6.2

# r10k not in path by default
if ! grep -q "export PATH=" /root/.bashrc; then
  echo "export PATH=\$PATH:/usr/local/bin" >> /root/.bashrc
fi

# Temporary fix for broken hiera on vm
GLOBAL_HIERA=/etc/puppetlabs/puppet/hiera.yaml
sed -i '/  - common/{N; /\n  - users$/b; s/\n/\n  - users\n/}' $GLOBAL_HIERA
