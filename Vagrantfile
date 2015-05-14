VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "PizzeriaDev"

    config.vm.network "private_network", ip: "192.168.10.9"

    config.vm.provision "shell" do |s|
      s.inline = "cp ~vagrant/.ssh/authorized_keys ~root/.ssh/authorized_keys"
    end

    config.vm.provision "ansible" do |ansible|
        ansible.verbose = "vvvv"
        ansible.playbook = "dev.yml"
        ansible.vault_password_file = ".vault_pass"
    end

    config.vm.provision "shell" do |s|
        s.inline = "echo \"Reducting box size\"; apt-get clean -y; apt-get autoclean -y; rm -rf /usr/src/vboxguest* /usr/src/virtualbox-ose-guest*; rm -rf /usr/src/linux-headers*; rm -rf /temp/*"
    end
end
