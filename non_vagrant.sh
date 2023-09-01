#!/bin/bash

dnf -y install puppet
exec ./bootstrap.sh
  

exec "/usr/bin/puppet apply /vagrant/scratch/puppet-control/manifests/site.pp"
exec ./r10k.sh