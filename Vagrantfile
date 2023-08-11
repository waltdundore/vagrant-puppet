Vagrant.configure(2) do |config|

 # config.vm.box_url = 'http://software.apidb.org/vagrant/centos-7-64-puppet.json'
  config.vm.box = 'generic/rocky9'
  config.vm.hostname = 'pup.apidb.org'
  config.vm.network :private_network, type: 'dhcp'
  config.ssh.forward_agent = 'true'

  # Libvirt settings
  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 4
    libvirt.memory = 8192

    # NFS: Make sure to enable UDP for NFSv3 on the host and set sudo rules:
    # https://developer.hashicorp.com/vagrant/docs/synced-folders/nfs#root-privilege-requirement
    config.vm.synced_folder ".", "/vagrant", type: "rsync"
    config.vm.synced_folder "scratch/code/", "/etc/puppetlabs/code/", type: "rsync"
    config.vm.synced_folder "r10k/", "/etc/puppetlabs/r10k/", type: "rsync"
  end

VAGRANT_DBDL = 'false'

  # Provisioning scripts
  config.vm.provision "shell", path: "addswap.sh"
  if VAGRANT_DBDL.eql? 'true'
    config.vm.provision "shell", path: "dbdl.sh"
  end

  config.vm.provision "shell", path: "bootstrap.sh"
  
  config.vm.provision "shell", path: "r10k.sh"

end

