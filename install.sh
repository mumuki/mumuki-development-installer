#!/usr/bin/env bash
echo ''
echo '[MumukiDevelopmentInstaller] Clonning mumuki-development-installer repository....'
git clone https://github.com/mumuki/mumuki-development-installer mumuki
cd mumuki

## Create the Vagrant VM

echo ''
echo '[MumukiDevelopmentInstaller] Creating Vagrant VM....'
vagrant up

## Provision the VM using escualo

echo ''
echo '[MumukiDevelopmentInstaller] Provisioning the Vagrant VM....'
gem install escualo
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
for component in  atheneum \
                  desktop \
                  classroom-api \
                  bibliotheca;  do
  git clone https://github.com/mumuki/mumuki-$component $component
done

echo ''
echo '[MumukiDevelopmentInstaller] Cloning Runners....'
for runner in haskell \
              prolog \
              gobstones \
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
echo 'Awesome! Mumuki Platfom development environement installation is complete. Now:'
echo ''
echo '$ cd mumuki'
echo '$ vagrant ssh'
echo '$ cd /vagrant'
echo ''
echo 'Happy mumuki coding!'