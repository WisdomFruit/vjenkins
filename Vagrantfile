
Vagrant.configure("2") do |config|
  
  # distro
  config.vm.box = "centos-7"

  # machine - dockervm
  config.vm.define "vdocker" do |machine|

    # vdocker provider
    machine.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end

    # vdocker network
    machine.vm.network "private_network",
      ip: "172.17.177.100"
    machine.vm.network "forwarded_port",
      guest: 8080,
      host: 8080
    
    # vdocker provision
    machine.vm.provision "docker" do |docker|
      docker.build_image "/vagrant/docker-files",
        args: "-t luckyjenkins-blueocean:2.387.1-1"
    end

    machine.vm.provision "shell", path: "docker-files/run.sh"

  end

end