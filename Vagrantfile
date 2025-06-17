# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/freebsd14"
  config.vm.box_version = "4.3.12"
  config.vm.provider :libvirt do |libvirt|
    libvirt.qemu_use_session = true
    libvirt.cpus = 4
    libvirt.memory = 4096
  end
  config.ssh.forward_agent = true
  config.vm.provision "shell", path: "provision.sh", privileged: false
end
