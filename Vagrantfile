
Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"
  config.vm.network "forwarded_port", guest:8000, host:8000
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "puppet/modules"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.working_directory = "/etc/puppet"
    puppet.options = "--verbose --debug"
  end
  config.vm.synced_folder "../config", "/etc/puppet/hieradata"
end

