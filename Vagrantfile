# BUG parallel starting of the images resulted in some images
# not being able to start
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  # provider config
  config.vm.provider "libvirt" do |v|
      v.memory = 512
      v.cpus = 1
  end

  config.ssh.keys_only = false

  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Basic setup through a shell provisioner
  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /root/.ssh
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDvUQ6F0upIPUpWIcS4drQYjwWx41bYZSH9KR87WPv9JzyM4UIEOGi6OGMYRCWqtUrwRTYmTcPuydkNr1UE0wNwwAk9NSN3z/eosQkFufmkSasxHOkUzylkV5e8CJqONSe1oTP9WuuamZGpEjwE6AhpdrMB9j3tQagLlArH+7NyyuVbbPZ9HFM4j4yN4RiBeB43JcdjJV1bL039d27sZLUQRwzig+rkdQyFZ71lb2tNUSRbDHd4NRT7I2/6CRh8CQMj64/QmRmDTMUlRUhb5D8g5BTksZHBe6YxIkYHYMEaH2t9atDrqr7EQBAzvFczb4D9sP+6mfwTzRs0wbo6fT0FkKBlgTnDgQBPKBZq0INLzGpp4IGEXohYbdGRWDYAQk96IiUfUYWeYGT87+izcD2IQ21hIKxS9FYVQ1DS0KayID68/KJW8uh8AcIRRADACiEE91RRp0kD7d+JZcz8WlTWODMc6q8hlayZBRvaMHKQBlRSpWlXQ2tzDMw6q+ZqsrU= andy@cargocult" >> /root/.ssh/authorized_keys
   SHELL

   config.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"

   config.vm.provision :shell, :inline => "sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"


  # todo: check why this does not work
  #config.vm.provision "ansible" do |ansible|
  #  ansible.playbook = "./../tasks.yaml"
  #end

  (1..13).each do |i|
      config.vm.define "test-#{i}" do |node|
         node.vm.network "private_network", ip: "192.168.122.#{i+150}"
         node.vm.hostname = "test-#{i}"
      end
  end  
end
