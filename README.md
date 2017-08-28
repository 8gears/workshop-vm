<p align="center"><a href="http://8gears.com" target="_blank"><img width="100"src="logo.png"></a></p>
<h1 align="center">Workshop VM</h1>
<p align="center">An instant to use Linux VM for ICT workshops and labs for Windows and Mac</p>

# Workshop Linux VM

is an easy to setup and ready to use Linux Desktop designed to provide students an equal starting position and an instant kickstart during workshops. After the installation of the VM students will only use this VM during the session. The VM should bring all the needed tools for the workshop.

This VM was initially designed for 8gears Docker, Kubernetes or OpenShift workshops. However it can also be used for any other type of coding, developing, hacking workshop. Pull requests are welcomed to add more functionality.

## What is it?

- Workshop VM is based on Ubuntu 16.04 with Unity Desktop.
- Vargrant is used to install and configure the VM.
- Additional provision scripts install more tools and perform initial updates.

Only a minimal set of tools is required to be installed on the Host Machine. Mainly VirtualBox and Vagrant.

Supported Operating Systems

- [Windows](#initial-windows-setup)
- [MacOS](#initial-macos-setup)

### Workshop VM Applications

List of additional tools and application that are installed with the VM.

- Docker
- Docker Compose
- OpenShift CLI (OC)
- Visual Studio Code
- Git

### Prerequisites

- Admin rights on your Computer
- At least 10 GB of free space
- +8 GB of RAM (75% will be used for the VM)

## Initial Windows Setup

To install Vargrant and VirtualBox we are going to use [Chocolatly](https://chocolatey.org) (a package manager for Windows). If you have both tools installed you can jump straight to the [Install Workshop VM](#install-workshop-vm) section.

If for what ever reasons you have difficulties visit the [Chocolatly Install Website](https://chocolatey.org/install) for alternative installation methods and a alternative explanation.

Ensure that you are using an [administrative shell](http://www.howtogeek.com/194041/how-to-open-the-command-prompt-as-administrator-in-windows-8.1/). Paste and execute the following line to install Chocolatly:

```sh
>"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

### Install VirtualBox and Vagrant for Windows

Now we can use Chocolatly to install the other tools. If you don't have Git installed yet can append a third parameter `git`.

```sh
> choco install -y virtualbox vagrant
```

You can continue now with the final step [Install Workshop VM](#install-workshop-vm).

## Initial MacOS Setup

For the MacOS setup we are going to use [Homebrew](https://brew.sh/), a package manager for MacOS.

Open a terminal and paste the following line at a Terminal prompt.

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install VirtualBox and Vagrant for MacOS

```sh
brew tap caskroom/cask
brew cask install virtualbox vagrant
```

## Install Workshop VM

Now is the part to actually install the VM itself and the setup scripts inside the VM

Download or clone this repository somewhere where your code has its home.

```sh
git clone https://github.com/8gears/workshop-vm.git
```

Enter the directory `workshop-vm` and execute following command.

```sh
cd workshop-vm
> vagrant up
```

If the Ubuntu Desktop pops up, wait until all the provision scripts finish. You can track their progress in the terminal.


## General Usage

After successfully initialization you can start and stop the vm with `vagrant` command `vagrant up` and `vagrant halt`.
However it is also possible to do the same with the VirtualBox Manager GUI.

The username and password is in both cases vagrant.

During the workshop it is recommended to close all programms and stop unneeded process on the Host OS as this VM takes up 75% of the RAM. 

## Known Issues

Sometimes things don't run as expected, especially as they are many files that are downloaded from various sources. If an error should happen during the setup often it is already enough to run `vagrant up` again.

## Project Principles

* Community: If a newbie has a bad time, it's a bug.
* Software: Make it work, then make it right, then make it fast.
* Technology: If it doesn't do a thing today, we can make it do it tomorrow.

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports,
complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and
maintainers or community members  saying "send patches or die" - you will not
see that here.

It is more important to me that you are able to contribute.

## License

Apache License, Version 2.0
