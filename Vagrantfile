Vagrant.configure("2") do |config|
  config.vm.box = "opscode-centos65"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"
  config.vm.hostname = "tamvagrant"

  #config.vm.provision :shell, :path => "vagrant.config/bootstrap.sh"


  config.vm.network "private_network", ip: "10.1.1.1"
  config.vm.network "public_network", ip: "192.168.0.111", bridge:"en0: Wi-Fi (AirPort)"

  config.vm.synced_folder "./", "/vagrant/", mount_options: ['dmode=777', 'fmode=666']
end
