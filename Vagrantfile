# -- mode: ruby --
# vi: set ft=ruby :

$install_puppet = <<-PUPPET
sudo apt-get update -y
sudo apt-get install -y puppet
PUPPET

Vagrant.configure("2") do |config|
if Vagrant.has_plugin? "vagrant-vbguest"
config.vbguest.no_install = true
config.vbguest.auto_update = false
config.vbguest.no_remote = true
config.vm.box = "bento/ubuntu-20.04"
config.vm.hostname = "puppetServer"
config.vm.network :private_network, ip: "192.168.90.3"
config.vm.provision "shell", inline: $install_puppet
config.vm.provision :puppet do |puppet|
puppet.manifests_path = "puppet/manifests"
puppet.manifest_file = "site.pp"
puppet.module_path = "puppet/modules"
config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
    pip3 install jupyter
    jupyter notebook --generate-config --allow-root
    echo "c.NotebookApp.ip = '0.0.0.0'" >> /home/vagrant/.jupyter/jupyter_notebook_config.py
    echo "c.NotebookApp.open_browser = False" >> /home/vagrant/.jupyter/jupyter_notebook_config.py
  SHELL
end
if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install  = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
end

config.vm.define :clienteUbuntu do |clienteUbuntu|
clienteUbuntu.vm.box = "bento/ubuntu-22.04"
clienteUbuntu.vm.network :private_network, ip: "192.168.100.2"
clienteUbuntu.vm.hostname = "clienteUbuntu"

end
config.vm.define :servidorUbuntu do |servidorUbuntu|
servidorUbuntu.vm.box = "bento/ubuntu-22.04"
servidorUbuntu.vm.network :private_network, ip: "192.168.100.3"
servidorUbuntu.vm.hostname = "servidorUbuntu"
servidorUbuntu.vm.provision "shell", path: "servidorUbuntu.sh"
servidorUbuntu.vm.synced_folder ".", "/var/www/"
end
config.vm.define :servidorUbuntudos do |servidorUbuntu|
servidorUbuntu.vm.box = "bento/ubuntu-22.04"
servidorUbuntu.vm.network :private_network, ip: "192.168.100.4"
servidorUbuntu.vm.hostname = "servidorUbuntudos"
servidorUbuntu.vm.provision "shell", path: "servidorUbuntudos.sh"

end
config.vm.define :servidorUbuntutres do |servidorUbuntu|
servidorUbuntu.vm.box = "bento/ubuntu-22.04"
servidorUbuntu.vm.network :private_network, ip: "192.168.100.5"
servidorUbuntu.vm.hostname = "servidorUbuntutres"
servidorUbuntu.vm.provision "shell", path: "servidorUbuntutres.sh"

end
end
end