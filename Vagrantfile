require "json"

Vagrant.configure("2") do |config|
  cwd = File.expand_path File.dirname(__FILE__)
  settings = JSON.parse(File.read("#{cwd}/../config/common.json"))
  server_port = settings['applications']['kegbot']['access_rules']['http']['port']

  config.vm.provider "hyperv" do |hv, override|
    # For networking it is recommended you:
    # 1) Set up an Internal Virtual Network in HyperV
    # 2) Go to the Network Connections window and  share your internet to it
    # 3) When you create the instance with vagrant up, select the
    #    Internal Virtual Network

    # You should set up your samba connections you should create your own
    # as detailed at <http://docs.vagrantup.com/v2/synced-folders/smb.html>.
    # It should be in ~/vagrant.d as per the documentation at
    # <http://docs.vagrantup.com/v2/vagrantfile/index.html> so it never gets
    # accidentally commited to the repository.

    override.vm.box = "giseongeom/centos7-64"
  end

  config.vm.provider "virtualbox" do |vb, override|
    vb.name = "Kegbot"
    override.vm.box = "jhcook/centos7"
  end

  config.vm.hostname = "theambassador"
  config.vm.network "forwarded_port", guest:server_port, host:server_port
  config.vm.synced_folder "../config", "/etc/puppet/hieradata"
  config.vm.provision "shell", inline: "yum update -y; yum upgrade -y"
  config.vm.provision "shell", inline: "rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm || true"
  config.vm.provision "shell", inline: "yum install puppet git -y"
  config.vm.provision "shell", inline: "puppet module install puppetlabs-concat"
  config.vm.provision "shell", inline: "puppet module install puppetlabs-stdlib"
  config.vm.provision "shell", inline: "if [ ! -d '/etc/puppet/modules/mysql' ]; then git clone https://github.com/slalomzacharyd/puppet-supervisord.git /etc/puppet/modules/supervisord; fi";
  config.vm.provision "shell", inline: "if [ ! -d '/etc/puppet/modules/mysql' ]; then git clone https://github.com/slalomzacharyd/puppetlabs-mysql.git /etc/puppet/modules/mysql; fi"; 

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "puppet/modules"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.working_directory = "/etc/puppet"
    #puppet.options = "--verbose --debug"
  end

end
