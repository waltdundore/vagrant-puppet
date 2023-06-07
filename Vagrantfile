Vagrant.configure(2) do |config|

  config.vm.box_url = 'http://software.apidb.org/vagrant/centos-7-64-puppet.json'
  config.vm.box = "ebrc/centos-7-64-puppet"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.ssh.forward_agent = 'true'
  config.vm.network :private_network, type: 'dhcp'
  config.vm.hostname = 'pup.apidb.org'

  # Run scripts to add swap and r10k
  config.vm.provision "shell", path: "addswap.sh"
  config.vm.provision "shell", path: "r10k.sh"
  # cp oracle.tgz from scratch to /u01. Will be downloaded if not there
  #config.vm.provision "shell", path: "dbdl.sh"

  # Setup puppet structure
  config.vm.synced_folder "scratch/code/", "/etc/puppetlabs/code/", owner: "root", group: "root"
  config.vm.synced_folder "r10k/", "/etc/puppetlabs/r10k/", owner: "root", group: "root"

end
