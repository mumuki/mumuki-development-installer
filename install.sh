#!/usr/bin/env bash

git clone https://github.com/mumuki/mumuki-development-installer mumuki
cd mumuki
vagrant up
gem install escualo
escualo script development.platform.yml --hostname 127.0.0.1 --username root --ssh-port 2222

mkdir runners
mkdir gems

for component in  atheneum \
                  desktop \
                  classroom-api \
                  bibliotheca;  do
  git clone https://github.com/mumuki/mumuki-$component $component
done

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

git clone https://github.com/mumuki/mumukit gems/mumukit

for gem in bridge \
           auth \
           inspection \
           nuntius \
           core \
           directives \
           serice \
           content-type ; do
  git clone https://github.com/mumuki/mumukit-$gem gems/$gem
done
