Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.box_check_update = false
  # (`vagrant box outdated` to update)

  (3000..3010).each do |it|
    config.vm.network 'forwarded_port', guest: it, host: it
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '2048'
  end

  ssh_private_key_path = File.join Dir.home, '.ssh', 'id_rsa'
  ssh_public_key = File.readlines(File.join Dir.home, '.ssh', 'id_rsa.pub').first.strip

  config.ssh.username = 'root'
  config.ssh.private_key_path = ssh_private_key_path
  
  config.vm.provision 'shell', inline: <<-SHELL
    echo #{ssh_public_key} >> /root/.ssh/authorized_keys
  SHELL
end
