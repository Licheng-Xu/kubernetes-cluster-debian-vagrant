vm_list = [
  {
    :name => "k8s-master",
    :cpu => "4",
    :mem => "4096",
    :eth1 => "192.168.100.10",
    :sshport => 22001
  },
  {
    :name => "k8s-worker1",
    :cpu => "2",
    :mem => "2048",
    :eth1 => "192.168.100.11",
    :sshport => 22002
  },
  {
    :name => "k8s-worker2",
    :cpu => "2",
    :mem => "2048",
    :eth1 => "192.168.100.12",
    :sshport => 22003
  }
]

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.box_check_update = false
  config.vbguest.auto_update = false
  Encoding.default_external = 'UTF-8'

  vm_list.each do |item|
    config.vm.define item[:name] do |vm_config|
      vm_config.vm.hostname = item[:name]
      vm_config.vm.network "private_network", ip: item[:eth1]
      # disable the default SSH service forwarding port
      vm_config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
      vm_config.vm.network "forwarded_port", guest: 22, host: item[:sshport]
      vm_config.vm.provider "virtualbox" do |vb|
        vb.name = item[:name];
        vb.cpus = item[:cpu];
        vb.memory = item[:mem];
      end
      # set up the common script to be executed on all vms in the k8s cluster
      vm_config.vm.provision "shell", path: "scripts/common.sh", privileged: false
      if item[:name] == "k8s-master"
        # set up the script to be executed on master node in the k8s cluster
        vm_config.vm.provision "shell", path: "scripts/master.sh", privileged: false
      else
        # set up the script to be executed on worker node in the k8s cluster
        vm_config.vm.provision "shell", path: "scripts/worker.sh", privileged: false
      end
    end
  end
end
