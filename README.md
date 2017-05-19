# mumuki-devinstaller
> Installer for the Mumuki Platform development environment

This installer installs a complete development environment in a Vagrant Machine with batteries included:

* Rbenv installation
* The escualo gem
* PosgreSQL and Mongo databases
* Rabbit Queue
* All main Mumuki Platform components, gems and runners

After running it, you are ready to start coding mumuki!

# Requirements

* Git
* Curl
* [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

# Install

Just do

```
curl https://raw.githubusercontent.com/mumuki/mumuki-devinstaller/master/install.sh | bash
```

# Use

```
$ cd mumuki
$ vagrant ssh
$ cd /vagrant
$ ls
```

Happy coding!
