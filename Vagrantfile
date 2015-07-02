VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "groupeat.dev" do |machine|
    machine.vm.box = "ubuntu/trusty64"
    machine.vm.hostname = "PizzeriaDev"

    # Configuring the Virtualbox provider for development
    machine.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]

      # Giving the VM 1/4 system memory & access to all cpu cores on the host
      host = RbConfig::CONFIG["host_os"]

      if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i
        # sysctl returns Bytes and we need to convert to MB
        memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
      elsif host =~ /linux/
        cpus = `nproc`.to_i
        # meminfo shows KB and we need to convert to MB
        memory = `grep "MemTotal" /proc/meminfo | sed -e "s/MemTotal://" -e "s/ kB//"`.to_i / 1024 / 4
      else # sorry Windows folks
        cpus = 2
        memory = 2048
      end

      vb.customize ["modifyvm", :id, "--memory", memory]
      vb.customize ["modifyvm", :id, "--cpus", cpus]
    end

    # Configuring the shared folders
    machine.vm.synced_folder Dir.pwd + "/../groupeat-api", "/home/vagrant/api/current", nfs: true
    machine.vm.synced_folder Dir.pwd + "/../groupeat-frontend", "/home/vagrant/frontend", nfs: true

    # Configuring the VM IP on the local private network
    machine.vm.network "private_network", ip: "192.168.10.10"

    # Configuring port forwarding to the box
    machine.vm.network "forwarded_port", guest: 80, host: 8000
    machine.vm.network "forwarded_port", guest: 443, host: 44300
    machine.vm.network "forwarded_port", guest: 5432, host: 54320

    # Copying the SSH private key to the box
    machine.vm.provision "shell" do |s|
      s.privileged = false
      s.inline = "echo \"$1\" > /home/vagrant/.ssh/id_rsa && chmod 600 /home/vagrant/.ssh/id_rsa"
      s.args = [File.read(File.expand_path("~/.ssh/id_rsa"))]
    end

    # Copying the Git config into the VM
    machine.vm.provision :file, source: "~/.gitconfig", destination: "/home/vagrant/.gitconfig" if File.exist?(ENV["HOME"] + "/.gitconfig")

    # Copying the vagrant authorized keys to the root user
    machine.vm.provision "shell", inline: "cp ~vagrant/.ssh/authorized_keys ~root/.ssh/authorized_keys"

    # Running ansible to install all the needed software
    machine.vm.provision "ansible" do |ansible|
      ansible.playbook = "dev.yml"
    end

    # Adding Composer token for GitHub if existing
    if File.exist?('.composer')
      command = "composer config -g github-oauth.github.com " + File.read('.composer').tr("\n", "")
      machine.vm.provision "shell", inline: command, privileged: false
    end

    # Updating composer
    machine.vm.provision "shell", inline: "cd ~vagrant/api/current; composer self-update"

    # Installing the API dependencies
    machine.vm.provision "shell", inline: "cd ~vagrant/api/current; composer install", privileged: false

    # Installing the API database structure
    machine.vm.provision "shell", inline: "cd ~vagrant/api/current; php artisan db:install --seed", privileged: false

    # Pulling the Adminer files
    machine.vm.provision "shell", inline: "cd ~vagrant/api/current; php artisan adminer", privileged: false
  end
end
