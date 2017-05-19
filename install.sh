#!/usr/bin/env bash
set -e

echo ''
echo '   _____                       __   .__________              .__                 __         .__  .__                '
echo '  /     \  __ __  _____  __ __|  | _|__\______ \   _______  _|__| ____   _______/  |______  |  | |  |   ___________ '
echo ' /  \ /  \|  |  \/     \|  |  \  |/ /  ||    |  \_/ __ \  \/ /  |/    \ /  ___/\   __\__  \ |  | |  | _/ __ \_  __ \'
echo '/    Y    \  |  /  Y Y  \  |  /    <|  ||    `   \  ___/\   /|  |   |  \\___ \  |  |  / __ \|  |_|  |_\  ___/|  | \/'
echo '\____|__  /____/|__|_|  /____/|__|_ \__/_______  /\___  >\_/ |__|___|  /____  > |__| (____  /____/____/\___  >__|   '
echo '        \/            \/           \/          \/     \/             \/     \/            \/               \/       '
echo ''

## Validate prerequisite

function validateCommand {
    $@ &>/dev/null
    local status="$?"
    if [ $status -ne 0 ]; then
        echo "Please, check the $@'s installation." >&2
	exit
    fi
}

### Validate Git
echo ''
echo '[MumukiDevinstaller] Checking Git installation'
validateCommand 'git --version'

### Validate Vagrant
echo ''
echo '[MumukiDevinstaller] Checking Vagrant installation'
validateCommand 'vagrant -v'

### Validate VirtualBox
echo ''
echo '[MumukiDevinstaller] Checking VirtualBox installation'
validateCommand 'vboxmanage -v'

### Validate Ruby
echo ''
echo '[MumukiDevinstaller] Checking Ruby installation'
validateCommand 'ruby -v'

## Cloning repository

echo ''
echo '[MumukiDevinstaller] Cloning mumuki-development-installer repository....'
git clone https://github.com/mumuki/mumuki-development-installer mumuki
cd mumuki

## Create the Vagrant VM

echo ''
echo '[MumukiDevinstaller] Creating Vagrant VM....'
vagrant up

## Provision the VM using escualo

echo ''
echo '[MumukiDevinstaller] Provisioning the Vagrant VM....'

export OPTIONS='--hostname 127.0.0.1 --username root --ssh-port 2222 --verbose'
escualo bootstrap --with-rbenv $OPTIONS
escualo plugin install postgres $OPTIONS
escualo plugin install docker $OPTIONS
escualo plugin install rabbit $OPTIONS
escualo plugin install mongo $OPTIONS

## Clone all main mumuki repositories

mkdir runners
mkdir gems

echo ''
echo '[MumukiDevinstaller] Cloning Components....'
for component in  laboratory \
                  classroom \
                  classroom-api \
                  bibliotheca \
		  bibliotheca-api \
		  office;  do
  git clone https://github.com/mumuki/mumuki-$component $component
done

echo ''
echo '[MumukiDevinstaller] Cloning Runners....'
for runner in haskell \
              prolog \
              gobstones \
	      xgobstones \
              javascript \
              c \
              cpp \
              ruby \
              java \
              wollok \
              text \
              python \
              elixir \
              qsim ; do
  git clone https://github.com/mumuki/mumuki-$runner-runner runners/$runner
done

echo ''
echo '[MumukiDevinstaller] Cloning Gems....'
git clone https://github.com/mumuki/mumukit gems/mumukit
for gem in bridge \
           auth \
           inspection \
           nuntius \
           core \
           directives \
           service \
           content-type ; do
  git clone https://github.com/mumuki/mumukit-$gem gems/$gem
done

echo ''
echo 'Awesome! Mumuki Platform development environment installation is complete. Now:'
echo ''
echo '$ cd mumuki'
echo '$ vagrant ssh'
echo '$ cd /vagrant'
echo ''
echo 'Happy mumuki coding!'
