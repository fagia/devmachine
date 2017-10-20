# -*- mode: ruby -*-
# vi: set ft=ruby :

required_plugins = %w(
  vagrant-reload
)

# Install required plugins
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

begin
  require './config'
rescue LoadError
  puts "Configuration not found!"
  puts "You must copy the 'config.rb.template' file as 'config.rb' and edit the values inside."
  exit
end

Vagrant.configure("2") do |config|
  config.vm.box = "viruzzo/xubuntu-xenial64"
  config.vm.hostname = "devmachine"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = PARAMS[:vm][:memory]
	vb.cpus = PARAMS[:vm][:cpus]
	vb.customize ["modifyvm", :id, "--vram", PARAMS[:vm][:vram]]
	vb.customize ["modifyvm", :id, "--clipboard", PARAMS[:vm][:clipboard]]
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.provisioning_path = "/vagrant/ansible"
    ansible.extra_vars = { params: PARAMS }
  end

  config.vm.provision :reload

end
