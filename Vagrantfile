VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "PizzeriaDev"

    config.ssh.insert_key = false

    ['/root', '/home/vagrant'].each do |path|
        config.vm.provision "shell" do |s|
          s.inline = "echo \"$1\" | grep -xq \"$1\" #{path}/.ssh/authorized_keys || echo \"$1\" | tee -a #{path}/.ssh/authorized_keys"
          s.args = [File.read(File.expand_path("~/.ssh/id_rsa.pub"))]
        end
    end

    config.vm.provision "ansible" do |ansible|
        ansible.verbose = "vvvv"
        ansible.playbook = "dev.yml"
        ansible.vault_password_file = ".vault_pass"
    end
end
