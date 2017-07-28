MUMUKI_PORTS = (3000..3010).to_a - [3001] # Excluding classroom, see mumuki/mumuki-classroom#125
DB_PORTS = [5432, 27017]

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.box_check_update = false
  # (`vagrant box outdated` to update)

  (MUMUKI_PORTS + DB_PORTS).each do |it|
    config.vm.network 'forwarded_port', guest: it, host: it
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 2048
  end

  ssh_private_key_path = File.join Dir.home, '.ssh', 'id_rsa'
  ssh_public_key = File.readlines(File.join Dir.home, '.ssh', 'id_rsa.pub').first.strip

  if ARGV[0] == "ssh"
    config.ssh.username = 'root'
    config.ssh.private_key_path = ssh_private_key_path
  end

  config.vm.synced_folder "repos", "/vagrant"

  config.vm.provision 'shell', inline: <<-SHELL
    set -e

    echo '[MumukiDevinstaller] Copying authorized keys....'
    echo #{ssh_public_key} >> /root/.ssh/authorized_keys

    echo '[MumukiDevinstaller] Installing Ruby....'
    apt-get purge libruby* -y
    apt-add-repository 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main'
    apt-get update
    apt-get install -y --force-yes ruby2.3 ruby2.3-dev

    echo '[MumukiDevinstaller] Installing Escualo....'
    gem install escualo -v 3.1.4

    echo '[MumukiDevinstaller] Running Escualo....'
    export OPTIONS='--verbose --trace'
    escualo bootstrap --env development --with-native-ruby $OPTIONS
    escualo plugin install postgres --pg-username mumuki --pg-password mumuki $OPTIONS
    escualo plugin install docker $OPTIONS
    escualo plugin install rabbit --rabbit-admin-password mumuki $OPTIONS
    escualo plugin install mongo $OPTIONS
    escualo plugin install node $OPTIONS

    echo '[MumukiDevinstaller] Configuring .bashrc....'
    echo 'cd /vagrant' >> /root/.bashrc
  SHELL
end
