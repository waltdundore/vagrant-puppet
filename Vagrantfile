Vagrant.configure(2) do |config|

  config.vm.box = "ebrc/centos-7-64-puppet"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.ssh.forward_agent = 'true'

  config.vm.network :private_network, type: 'dhcp'
  if Vagrant.has_plugin?('landrush')
    config.landrush.enabled = true
    config.landrush.tld = ['pup.apidb.org', 'pup.toxodb.org']
  end
 
  config.vm.hostname = 'pup.apidb.org'

  if 1 == 1
    config.vm.provision :puppet do |puppet|
      #puppet.options = '--verbose --debug'
      #puppet.binary_path = '/opt/puppetlabs/bin'
      puppet.hiera_config_path = 'scratch/puppetlabs/code/hiera.yaml'
      puppet.environment_path = 'scratch/puppetlabs/code/environments'
      puppet.environment = 'hashicorp'
      # Can not specify specific manifest file,
      # https://github.com/mitchellh/vagrant/issues/6163
      # so using specific environment to setup PuppetDB
      # puppet.manifest_file = 'puppetdb_standalone.pp'
    end
  end

  # setup puppet structure
  # config.vm.synced_folder "scratch/puppetlabs/code/", "/etc/puppetlabs/code/", type: 'nfs'
  config.vm.synced_folder "scratch/puppetlabs/code/", "/etc/puppetlabs/code/", owner: "root", group: "root" 

  # cp oracle.tgz from scratch to /u01. Will be downloaded if not there
  config.vm.provision "shell", path: "dbdl.sh"

end
