
Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"
  config.vm.hostname = "theambassador"
  config.vm.network "forwarded_port", guest:9000, host:9000
  config.vm.network "forwarded_port", guest:8080, host:8080
  config.vm.synced_folder "../config", "/etc/puppet/hieradata"
  config.vm.provision "shell", inline: "yum install puppet git -y"
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

  config.vm.provider :aws do |aws, override|
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "PATH TO YOUR PRIVATE KEY"
  end
end

