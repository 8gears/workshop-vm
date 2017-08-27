<p align="center"><a href="http://8gears.com" target="_blank"><img width="100"src="logo.png"></a></p>
<h1 align="center">Workshop VM</h1>
<p align="center">An instant to use Linux VM for workshops and classrooms for Windows and Mac</p>

# Workshop Linux VM

is an easy to setup and ready to use Linux VM designed to provide all students an equal starting position and a quick getting started during workshops. After the installation the students use only this VM as it brings all the needed tools for the workshop.

This VM was initially designed for 8gears Docker, Kubernetes or OpenShift workshops. However it can also be used for any other type of workshop. Pull requests are welcomed.

## What is it?

Only a minimal set of tools is required to be installed on the Host Machine. Mainly VirtualBox and Vagrant.

Supported Operating Systems

- [Windows](#Windows-Setup)
- [MacOS](#Mac-Setup)

### Content

- Workshop VM is based on Ubuntu 16.04 minus the office tools.
- Vargrant is used to install and configure the VM
- Additional provision scripts can install other tools.

### Prerequisites

- Admin rights on your Computer
- At least 10 GB of free space
- +8 GB of RAM (50% will be used for the VM)

## Initial Setup for Windows

To install Vargrant and VirtualBox we are going to use [Chocolatly](https://chocolatey.org) (a package manager for Windows). If you have both tools installed you can jump straight to the [Install Workshop VM](#Install-Workshop-VM) section.

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

You can continue now with the final step [Install Workshop VM](#Install-Workshop-VM).

## Initial Setup for MacOS

For the MacOS setup we are going to use [Homebrew](https://brew.sh/), a package manager for MacOS.

Open a terminal and paste the following line at a Terminal prompt.

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
&& brew tap caskroom/cask
```

### Install VirtualBox and Vagrant for MacOS

```sh
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

If the Ubuntu User Interface pops up, wait until all the provision scripts finish, thy run in the background. You can track their progress in the terminal.

## Workshop VM Applications

List of additional tools and application that are installed with the VM.

- Docker
- Docker Compose
- OpenShift CLI (OC)
- Visual Studio Code
- Git

## General Usage

After successfully initialization you can start and stop the vm with `vagrant` command `vagrant up` and `vagrant halt`.
However it is also possible to do the same with the VirtualBox Manager GUI.

The username and password is in both cases vagrant.

## Known Issues

Sometimes things don't run as expected, especially as they are many files downloaded from various sources. If this happens often its already enough to run `vagrant up` again.