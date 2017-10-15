# -*- mode: ruby -*-
# vi: set ft=ruby :

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
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.provisioning_path = "/vagrant/ansible"
    ansible.extra_vars = { params: PARAMS }
  end

end
