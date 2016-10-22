# Steve's Super Duper Server

## Requirements
* vagrant - [Vagrant Download Site](https://www.vagrantup.com/downloads.html)
* virtualbox /w Extension Pack - [VirtualBox Download Site](https://www.virtualbox.org/wiki/Downloads)
* vagrant digital-ocean plugin - `vagrant plugin install vagrant-digitalocean`

## Setup
The website content will need to be placed in an app folder which is in the same directory as your Vagrantfile like below.

```./
  app/
    <your website files here>
  Vagrantfile
  env-sample.yaml
```
The env-sample.yaml file is used to store keys and data for using Vagrant to manage machines launched in Digital Ocean. This has not yet been tested

Once you have started the vagrant machine the website can be accessed at http://localhost:8080

## Running the VM
1. Clone the repository `git clone https://github.com/brpacecar/steves-box.git`
2. Start the VM. `vagrant up local`

## Managing the Vagrant machine
* Starting the machine - `vagrant up local`
* Stop the machine - `vagrant halt local`
* Destroy the machine - `vagrant destroy local`

## Changing vagrant options
Several of the standard vagrant machine preferences have been put into variables to make it easy to change. Update the options in the 'Machine Variables' section of the Vagrantfile. You will have to restart a running machine for the changes to take affect.
