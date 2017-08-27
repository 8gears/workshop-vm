# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  # Ubuntu 16.04
  config.vm.hostname = "workshopvm"
  config.vm.define config.vm.hostname do |machinename|
  end
  config.vm.box = "boxcutter/ubuntu1604-desktop"
  config.vm.network "private_network", type: "dhcp"

  config.vm.synced_folder ".", "/vagrant", disabled:true
  # Mounting the folder sporadically fails. In particular if not started using 'vagrant up' but through the
  # VirtualBox UI. Use 'cd ~ && sudo umount ho || sudo mount -t vboxsf home_vagrant_ho ho && ls ho'
  config.vm.synced_folder ENV['HOME'], "/home/vagrant/home-"+ENV['USER']

  config.vm.provider "virtualbox" do |vb|
    vb.name = config.vm.hostname

    #vb.customize "pre-boot", ["modifyhd", "disk id", "--resize", "128000"]
    vb.customize ["modifyvm", :id,
                 "--description", config.vm.hostname,
                 "--vram", 64,
                 "--accelerate3d", "on",
                 "--cableconnected0", "on",
                 "--cableconnected1", "on"]                 
    vb.gui = true  # Display the VirtualBox GUI when booting the machine
    # Determine existing machine Memory& CPUs  and use it in the VM
    mem_ratio = 0.75
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

  config.vm.provision "file", run: "always", source: "provision/mod-bash.sh", destination: ".workshopvm/mod-bash.sh"
  config.vm.provision "file", run: "always", source: "provision/user-settings.sh", destination: ".workshopvm/user-settings.sh"
  config.vm.provision "file", source: ENV['HOME']+"/.gitconfig", destination: ".gitconfig"
  config.vm.provision "file", source: ENV['HOME']+"/.ssh/id_rsa", destination: ".ssh/id_rsa"
  config.vm.provision "file", source: ENV['HOME']+"/.ssh/id_rsa.pub", destination: ".ssh/id_rsa.pub"
  config.vm.provision "file", source: ENV['HOME']+"/.ssh/known_hosts", destination: ".ssh/known_hosts"

  # install docker and openshift CLI
  config.vm.provision "shell", path: "provision/docker.sh"
  config.vm.provision "shell", run: "always", path: "provision/openshift.sh"

  # install an informative bash-git-prompt
  config.vm.provision "shell", path: "provision/git-bash-prompt.sh"

  # apply various user settings on every startup
  config.vm.provision "shell", run: "always", path: "provision/user-setup.sh"

  # fix locale in order to make gnome-terminal correctly
  config.vm.provision "shell", path: "provision/locale.sh"

  # Install some tools and virtualbox additions
  config.vm.provision "shell", run: "always", path: "provision/install-packages.sh"

end
