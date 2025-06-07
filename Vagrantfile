# Prompt for SSH key via environment variable
if ENV['VAGRANT_SSH_KEY'].nil?
  puts 'SSH key not found in environment variable VAGRANT_SSH_KEY.'
  puts 'Please set the SSH key using: export VAGRANT_SSH_KEY="ssh-rsa AAA..."'
  exit
end

# BUG parallel starting of the images resulted in some images
# not being able to start
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"

  # Configuration for libvirt provider
  config.vm.provider "libvirt" do |libvirt|
      libvirt.memory = 512
      libvirt.cpus = 1
  end

  # Configuration for VMware provider
  config.vm.provider "vmware_desktop" do |vmware|
      vmware.gui = true 
      vmware.vmx["memsize"] = "512"
      vmware.vmx["numvcpus"] = "1"
  end

  config.ssh.keys_only = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Basic setup through a shell provisioner
  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /root/.ssh
    echo "#{ENV['VAGRANT_SSH_KEY']}" >> /root/.ssh/authorized_keys
  SHELL

   config.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"

   config.vm.provision :shell, :inline => "sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"


  # todo: check why this does not work
  #config.vm.provision "ansible" do |ansible|
  #  ansible.playbook = "./../tasks.yaml"
  #end

  (1..15).each do |i|
      config.vm.define "test-#{i}" do |node|
         node.vm.network "private_network", ip: "192.168.122.#{i+150}"
         node.vm.hostname = "test-#{i}"
      end
  end  
end
