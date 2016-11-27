# mumuki-development-installer
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
* Ruby 2+. No special installation is required - `apt-get install ruby` is enough
* Vagrant

# Install

Just do

```
curl https://raw.githubusercontent.com/mumuki/mumuki-development-installer/master/install.sh | bash
```

# Use

```
$ vagrant ssh
$ cd vagrant
$ ls
```

Happy coding!
