# Fagia Dev Machine

Vagrant + Ansible provisioning of a development virtual machine based on Ubuntu 16.04 + ElementaryOS desktop environment, provisioned with:

* Google Chrome browser (latest stable)
* MariaDB (latest stable available for Ubuntu Xenial)
* Apache (latest stable)
* PHP (latest stable)
* Filezilla (latest stable)
* Java JDK 1.8
* Gradle (latest stable)
* Maven (latest stable)
* IntelliJ (latest stable community edition)
* PyCharm (2017.3.2 community edition)

## Setup:

In the host machine, install the latest stable versions of:

* Git
* Vagrant
* VirtualBox

Once finished with the installation of the programs above, open a command terminal, navigate to a base directory of your choice (avoid directory paths with blanks) and from here:

	git config --global core.autocrlf input
	git clone https://github.com/fagia/devmachine.git your-devmachine-name-here
	cd your-devmachine-name-here

Copy the file <code>config.rb.template</code> to <code>config.rb</code> and, in the copied file, fill in the configuration informations.

Then:

	vagrant up

Hold on, this will take a while. Once the initial setup process is complete, you should be able to log into the fully provisioned development virtual machine (use the credentials that you entered in the config.rb file).

Happy coding!
