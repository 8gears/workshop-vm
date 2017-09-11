# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

  # Ubuntu 16.04 Workshop VM
  config.vm.define 'workshopvm', primary: true do |wvm|  
    wvm.vm.hostname = "workshopvm"
    wvm.vm.box = "box-cutter/ubuntu1604-desktop"
    wvm.vm.network "private_network", type: "dhcp"

    wvm.vm.synced_folder ".", "/vagrant", disabled:true
    # Mounting the folder sporadically fails. In particular if not started using 'vagrant up' but through the
    # VirtualBox UI. Use 'cd ~ && sudo umount ho || sudo mount -t vboxsf home_vagrant_ho ho && ls ho'
    wvm.vm.synced_folder ENV['HOME'], "/home/vagrant/home-"+ENV['USER']

    wvm.vm.provider "virtualbox" do |vb|
      vb.name = config.vm.hostname      
      vb.customize ["modifyvm", :id,
                  "--description", config.vm.hostname,
                  "--vram", 64,
                  "--accelerate3d", "on",                 
                  "--cableconnected1", "on"]                 
      vb.gui = true  # Display the VirtualBox GUI when booting the machine
      # Determine existing machine Memory& CPUs  and use it in the VM
      mem_ratio = 0.50
      host = RbConfig::CONFIG['host_os']
      cpus = 1
      mem = 1024
      if host =~ /darwin/    
        cpus = `sysctl -n hw.physicalcpu`.to_i            
        mem = (`sysctl -n hw.memsize`.to_i / 1024 / 1024 * mem_ratio).to_i
      elsif host =~ /linux/
        cpus = `nproc`.to_i      
        mem = (`grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 * mem_ratio).to_i
      else # Windows folks
        cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i
        mem = (`wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / 1024 * mem_ratio).to_i
      end    
      vb.cpus = cpus
      vb.memory = mem
      #puts "Provisioning #{vb.name} with #{cpus} CPU's and #{mem / 1024 } GB RAM."    
    end

    wvm.vm.provision "file", run: "always", source: "provision/mod-bash.sh", destination: ".workshopvm/mod-bash.sh"
    wvm.vm.provision "file", run: "always", source: "provision/user-settings.sh", destination: ".workshopvm/user-settings.sh"  
    if File.exists?(ENV['HOME']+"/.gitconfig")
      wvm.vm.provision "file", source: ENV['HOME']+"/.gitconfig", destination: ".gitconfig"
    end
    if Dir.exist?(ENV['HOME']+"/.ssh/id_rsa")
      wvm.vm.provision "file", source: ENV['HOME']+"/.ssh/id_rsa", destination: ".ssh/id_rsa"
      wvm.vm.provision "file", source: ENV['HOME']+"/.ssh/id_rsa.pub", destination: ".ssh/id_rsa.pub"
    end
    if File.exists?(ENV['HOME']+"/.ssh/known_hosts")
      wvm.vm.provision "file", source: ENV['HOME']+"/.ssh/known_hosts", destination: ".ssh/known_hosts"
    end

    # install docker and openshift CLI
    wvm.vm.provision "shell", path: "provision/docker.sh"
    wvm.vm.provision "shell", run: "always", path: "provision/openshift.sh"

    # install an informative bash-git-prompt
    wvm.vm.provision "shell", path: "provision/git-bash-prompt.sh"

    # apply various user settings on every startup
    wvm.vm.provision "shell", run: "always", path: "provision/user-setup.sh"

    # fix locale in order to make gnome-terminal correctly
    wvm.vm.provision "shell", path: "provision/locale.sh"

    # Install some tools and virtualbox additions
    wvm.vm.provision "shell", run: "always", path: "provision/install-packages.sh"
  end

  # Worker Node with Docker
  config.vm.define "workshopvm-worker-1" do |wvmw1|
    wvmw1.vm.box = "AlbanMontaigu/boot2docker"    
    wvmw1.vm.hostname = 'worker-1'    
    wvmw1.vm.network "private_network", type: "dhcp"
    wvmw1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", 'workshopvm-worker-1']
    end
  end

  # Worker Node #2 with Docker
  config.vm.define "workshopvm-worker-2" do |wvmw2|
    wvmw2.vm.box = "AlbanMontaigu/boot2docker"
    wvmw2.vm.hostname = 'worker-2'    
    wvmw2.vm.network "private_network", type: "dhcp"
    wvmw2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", 'workshopvm-worker-2']
    end
  end
end