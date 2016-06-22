
### Setup

    cd scratch/
    git clone git@git.apidb.org:puppet4.git puppetlabs


### Install Landrush Plugin (optional)


    git clone https://github.com/mheiges/landrush.git
    cd landrush
    rake build
    vagrant plugin install pkg/landrush-0.18.0.gem


### Oracle install slow connection
    uncomment dbdl.sh script in Vagrant file
    This will let you put the install file in scratch(or download if missing)


### Usage

See `git branch` of the vagrant project for alternate vagrant
configurations supporting development of specific puppet roles/profiles.
For example, `git checkout nginx` will provide a Vagrantfile and
associate assets for two virtual machines, a Nginx host and a backend
web host. To be clear, I referring to the git branch in the vagrant
project (where Vagrantfile and this README are), not the puppet4 git
project in `scratch`, although you might want different branches there
as well.

For the master branch, run Puppet as

    sudo /opt/puppetlabs/bin/puppet apply  --environment=puppetwebdev /etc/puppetlabs/code/environments/puppetwebdev/manifests
