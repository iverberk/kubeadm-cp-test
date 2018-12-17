Vagrant.configure("2") do |config|

    config.trigger.before :provision do |trigger|
      trigger.info = "Copying certificates..."
      trigger.only_on = "controller-2"
      trigger.run = { path: "copy-certs.sh" }
    end

    (1..2).each do |i|
        config.vm.define "controller-#{i}" do |node|
            node.vm.box = "ubuntu/bionic64"
            node.vm.hostname = "controller-#{i}"
            node.vm.network "private_network", ip: "10.11.0.#{10+i}"
            node.vm.provision "shell", path: "provision/controller-#{i}.sh"
            node.vm.provider "virtualbox" do |v|
                v.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
                v.customize ["modifyvm", :id, "--audio", "none"]
                v.memory = 1280
                v.cpus = 2
            end
        end
    end
end
