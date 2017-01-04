#!/usr/bin/env bash

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
echo '[MumukiDevelopmentInstaller] Checking Git installation'
validateCommand 'git --version'

### Validate Vagrant
echo ''
echo '[MumukiDevelopmentInstaller] Checking Vagrant installation'
validateCommand 'vagrant -v'

### Validate VirtualBox
echo ''
echo '[MumukiDevelopmentInstaller] Checking VirtualBox installation'
validateCommand 'vboxmanage -v'

### Validate Ruby
echo ''
echo '[MumukiDevelopmentInstaller] Checking Ruby installation'
validateCommand 'ruby -v'

## Cloning repository

echo ''
echo '[MumukiDevelopmentInstaller] Cloning mumuki-development-installer repository....'
git clone https://github.com/mumuki/mumuki-development-installer mumuki
cd mumuki

## Create the Vagrant VM

echo ''
echo '[MumukiDevelopmentInstaller] Creating Vagrant VM....'
vagrant up

## Provision the VM using escualo

echo ''
echo '[MumukiDevelopmentInstaller] Provisioning the Vagrant VM....'
gem install escualo -v 0.5.1
escualo script development.platform.yml --hostname 127.0.0.1 \
                                        --username root \
                                        --ssh-port 2222 \
                                        --verbose \
                                        --trace

## Clone all main mumuki repositories

mkdir runners
mkdir gems

echo ''
echo '[MumukiDevelopmentInstaller] Cloning Components....'
for component in  laboratory \
                  classroom \
                  classroom-api \
                  bibliotheca \
		  bibliotheca-api \
		  office;  do
  git clone https://github.com/mumuki/mumuki-$component $component
done

echo ''
echo '[MumukiDevelopmentInstaller] Cloning Runners....'
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
echo '[MumukiDevelopmentInstaller] Cloning Gems....'
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
