require 'yaml'
settings     = YAML.load_file 'env.yaml'
hostname     = settings['hostname']
domain       = settings['domain']
token        = settings['token']
ssh_key_path = settings['ssh_key_path']

# Check for required plugins
required_plugins = ['vagrant-digitalocean']
for i in required_plugins do
  unless Vagrant.has_plugin?(i)
    raise "#{i} is not installed!"
  end
end

Vagrant.configure(2) do |config|
  # Wrapper for optional plugins
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false # disable the auto updating guest additions
  end

  config.vm.define 'local' do |c|
    c.vm.box = "ubuntu/trusty64"
    c.vm.hostname = "#{hostname}.local"
    c.vm.provider "virtualbox" do |vb|
      vb.gui = false        # false = start headless
      vb.memory = "768"    # memory allocated to the vm
      vb.name = hostname  # name of the machine in virtualbox
      vb.customize [        # 'vboxmanage modifyvm' options
        "modifyvm", :id,
        "--cpus", "2"
      ]
    end
    c.vm.network "private_network", ip: "192.168.56.143" # host only network specific IP
    c.vm.network "forwarded_port", guest: 80, host: 8080 # port forward
    c.vm.synced_folder "app/", "/var/www/app",
      owner: "www-data", group: "www-data"# synced folder
    c.vm.provision "shell", path: "bootstrap-local.sh"
  end

  # config.vm.define 'production' do |c|
  #   c.vm.provider :digital_ocean do |provider, override|
  #     override.ssh.private_key_path = ssh_key_path
  #     override.vm.box               = 'digital_ocean'
  #     override.vm.box_url           = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
  #
  #     provider.token              = token
  #     provider.image              = 'ubuntu-14-04-x64'
  #     provider.region             = 'sfo1'
  #     provider.size               = '512mb'
  #     provider.private_networking = false
  #   end
  #   c.vm.provision "shell", path: "bootstrap-production.sh"
  # end
end
