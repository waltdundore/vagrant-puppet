ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
Vagrant.configure(2) do |config|

  #config.vm.box_url = 'http://software.apidb.org/vagrant/centos-7-64-puppet.json'
  #ebrc/centos-7-64-puppet image has an issue where I can't ssh into it
  #config.vm.box = "ebrc/centos-7-64-puppet"

  #vanilla centos image - requires the bootstrap.sh script to install puppet
  config.vm.box = "generic/centos7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 4
  end

  config.vm.hostname = "pup.apidb.org"
  config.ssh.forward_agent = true
  
  #temporarily stop the virtualbox guest updating every time for speed
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  #modify the default port to match our servers
  config.vm.network "forwarded_port", id: "ssh", guest: 22, host: 2112
  config.ssh.port = 2112


 
  # Run scripts to add swap and r10k
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision "shell", path: "addswap.sh"
  config.vm.provision "shell", path: "r10k.sh"
  # cp oracle.tgz from scratch to /u01. Will be downloaded if not there
  #config.vm.provision "shell", path: "dbdl.sh"

  # Setup puppet structure
  config.vm.synced_folder "scratch/code/", "/etc/puppetlabs/code/", owner: "root", group: "root"
  config.vm.synced_folder "r10k/", "/etc/puppetlabs/r10k/", owner: "root", group: "root"
  config.vm.synced_folder ".", "/vagrant/", owner: "root", group: "root"

end