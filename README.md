# devmachine

Vagrant + Ansible provisioning of a development virtual machine based on Xubuntu Desktop (https://app.vagrantup.com/viruzzo/boxes/xubuntu-xenial64), provisioned with:

* Java JDK 1.8
* Gradle 4.2
* IntelliJ 2017.3 (community edition)
* Google Chrome (stable)

## Setup:

In the host machine, install the latest stable versions of:

* Git
* Vagrant
* VirtualBox

Once finished with the installation of the programs above, open a command terminal, navigate to a base directory of your choice (avoid directory paths with blanks) and from here:

	git config --global core.autocrlf input
	git clone https://github.com/fagia/devmachine.git
	cd devmachine

Copy the file <code>config.rb.template</code> to <code>config.rb</code> and in the copied file complete the missing informations, then:

	vagrant up

Now you should be able to log in the provisioned development virtual machine (use the credentials that you entered in the config.rb file) and happy coding!
