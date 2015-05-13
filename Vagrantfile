require "json"

Vagrant.configure("2") do |config|
  cwd = File.expand_path File.dirname(__FILE__)
  settings = JSON.parse(File.read("#{cwd}/../config/common.json"))
  server_port = settings['applications']['kegbot']['access_rules']['http']['port']

  config.vm.provider "virtualbox" do |v|
    v.name = "Kegbot"
  end
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"
  config.vm.hostname = "theambassador"
  config.vm.network "forwarded_port", guest:server_port, host:server_port
  config.vm.synced_folder "../config", "/etc/puppet/hieradata"
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
    puppet.options = "--verbose --debug"
  end
end
