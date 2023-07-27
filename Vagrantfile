ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'

REQUIRED_PLUGINS = %w(vagrant-libvirt)
exit unless REQUIRED_PLUGINS.all? do |plugin|
  Vagrant.has_plugin?(plugin) || (
    puts "The #{plugin} plugin is required. Please install it with:"
    puts "$ vagrant plugin install #{plugin}"
    false
  )
end

Vagrant.configure(2) do |config|

  #config.vm.box_url = 'http://software.apidb.org/vagrant/centos-7-64-puppet.json'
  #ebrc/centos-7-64-puppet image has an issue where I can't ssh into it
  #config.vm.box = "ebrc/centos-7-64-puppet"

  #vanilla centos image - requires the bootstrap.sh script to install puppet
  config.vm.box = "generic/centos7"

  config.vm.provider "libvirt" do |libvirt|
    libvirt.memory = 8192
    libvirt.cpus = 4
  end

  # Define private network
  config.vm.define :test_vm1 do |test_vm1|
    test_vm1.vm.network :private_network,
      :ip => "19.168.121.50",
      :libvirt__domain_name => "apidb.org"
  end

  config.ssh.forward_agent = true

  config.vm.hostname = "pup.apidb.org"

  #modify the default port
  #config.vm.network "forwarded_port", id: "ssh", guest: 22, host: 2112
  #config.ssh.port = 2112


 
  # Run scripts to add swap and r10k
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision "shell", path: "addswap.sh"
  config.vm.provision "shell", path: "r10k.sh"
  # cp oracle.tgz from scratch to /u01. Will be downloaded if not there
  #config.vm.provision "shell", path: "dbdl.sh"

  # Setup puppet structure
  config.vm.synced_folder "scratch/code/", "/etc/puppetlabs/code/", type: "rsync",
  rsync__exclude: ".git/"
  config.vm.synced_folder "r10k/", "/etc/puppetlabs/r10k/", type: "rsync",
  rsync__exclude: ".git/"
  config.vm.synced_folder ".", "/vagrant/", owner: "root", type: "rsync"

end