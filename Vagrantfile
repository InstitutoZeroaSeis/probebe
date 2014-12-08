# encoding: utf-8
# This file originally created at http://rove.io/149631bd654d5e2ef9c5696b09830db6

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise32"

  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/app", nfs: true

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 3010, host: 3010
  config.vm.network :private_network, ip: "10.11.12.13"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
  end
end
