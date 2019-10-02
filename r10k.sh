#!/bin/bash

# Install r10k
yum install ruby git -y
gem install rdoc -v 4.2.2 # fixes annoying doc encoding error
gem install r10k -v 2.6.2
mkdir -p /etc/puppetlabs/r10k/
touch /etc/puppetlabs/r10k/r10k.yaml

cat << 'EOF' >> /etc/puppetlabs/r10k/r10k.yaml
:sources:
  :eupathdb:
    remote: '/vagrant/scratch/puppet-control'
    basedir: '/etc/puppetlabs/code/environments'
EOF

if ! grep -q "export PATH=" /root/.bashrc; then
  echo "export PATH=\$PATH:/usr/local/bin" >> /root/.bashrc
fi

# Temporary fix for broken hiera on vm
GLOBAL_HIERA=/etc/puppetlabs/puppet/hiera.yaml
sed -i '/  - common/{N; /\n  - users$/b; s/\n/\n  - users\n/}' $GLOBAL_HIERA
