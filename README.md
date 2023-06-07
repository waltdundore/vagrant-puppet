
### Setup

    cd scratch/
    git clone git@git.apidb.org:puppet-control.git
    cd puppet-control
    git checkout savm

### Oracle install slow connection
    uncomment dbdl.sh script in Vagrant file
    This will let you put the install file in scratch(or download if missing)

### Usage

For the savm branch:

    sudo -i
    r10k deploy environment savm -pv
    puppet apply --environment savm /etc/puppetlabs/code/environments/savm/manifests/site.pp
