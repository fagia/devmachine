# -*- mode: ruby -*-
# vi: set ft=ruby :

required_plugins = %w(
  vagrant-reload
  vagrant-proxyconf
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
  PARAMS["vault_password_file"] = '/tmp/vault_pass'
rescue LoadError
  puts "Configuration not found!"
  puts "You must copy the 'config.rb.template' file as 'config.rb' and edit the values inside."
  exit
end

Vagrant.configure("2") do |config|

  class AnsibleVaultPassword
    def to_s
      print "Ansible vault password (leave empty if you're not using ansible-vault encrypted group variables): "
      # temp hack to hide pwd characters input:
      #   - https://github.com/ruby/io-console/issues/2
      #   - https://github.com/hashicorp/vagrant/issues/5624#issuecomment-160473599
      # 8m is the control code to hide characters
      puts "\e[0;8m"
      STDOUT.flush
      stdin_pwd = STDIN.gets.chomp
      # 0m is the control code to reset formatting attributes
      puts "\e[0m"
      STDOUT.flush
      stdin_pwd.to_s.empty? ? 'no-password-provided' : stdin_pwd
    end
  end

  config.vm.box = "fagia/ubuntu-elementary-de-16.04"
  config.vm.box_version = "0.0.1"
  config.vm.hostname = PARAMS[:vm][:name]

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = PARAMS[:vm][:memory]
    vb.cpus = PARAMS[:vm][:cpus]
    vb.customize ["modifyvm", :id, "--vram", PARAMS[:vm][:vram]]
    vb.customize ["modifyvm", :id, "--clipboard", PARAMS[:vm][:clipboard]]
    vb.customize ["setextradata", :id, "GUI/MiniToolBarAlignment", "Top"]
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http  = PARAMS[:proxy][:http]
    config.proxy.https = PARAMS[:proxy][:https]
    config.proxy.no_proxy = PARAMS[:proxy][:no_proxy]
  end

  config.vm.provision "shell", env: {"AVPWD" => AnsibleVaultPassword.new, "AVPASSFILE" => PARAMS["vault_password_file"]}, inline: "echo $AVPWD > $AVPASSFILE"

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.provisioning_path = "/vagrant/ansible"
    ansible.vault_password_file = PARAMS["vault_password_file"]
    ansible.extra_vars = { params: PARAMS }
  end

  config.vm.provision :reload

end
